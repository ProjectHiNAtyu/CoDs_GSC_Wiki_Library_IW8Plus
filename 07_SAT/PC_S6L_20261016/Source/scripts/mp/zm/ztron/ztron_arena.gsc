// scripts\mp\zm\ztron\ztron_arena.gsc  (hash_456cc4da5869140b.gscc) (size: 79958 Bytes / 0x13856 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b95a1bd (999662013)
// size ...... 79958 (0x13856)
// includes .. 34  (offset: 0x124c6)
// strings ... 201 (offset: 0x125d6)
// dev strs .. 112 (offset: 0x1330a)
// exports ... 132 (offset: 0xdafa)
// cseg ...... 0x11d0 + 0xc92a (0xdafa)
// imports ... 408 (offset: 0xef9a)
// animtree1 . 0   (offset: 0x13856)
// animtree2 . 0   (offset: 0x13856)
#using script_31ee2a173f3499b7;
#using script_38390664ae794177;
#using script_3940e26d28ff3a75;
#using script_3f7d19e011d97209;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerstats_interface;
#using scripts\mp\zm\ztron\ztron_bgb_machine;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_dev;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_tutorial;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;
#using scripts\mp\zm\ztron\ztron_world_event;

#namespace ztron_arena;

// Namespace ztron_arena
// Params 0
// Checksum 0x30b90db0, Offset: 0x11ee
// Size: 0x473
function init()
{
    level.ztron.arenas = [];
    level.ztron.var_b6efb062e0563051 = [];
    level.ztron.var_2f2a61ca8ee3ed19 = [];
    level.ztron.spawningovertime = 0;
    level.ztron.gatekeys = 0;
    level.ztron.roundplayercount = 0;
    level.ztron.var_316dc0679575bf4d = 0;
    level.ztron.var_e07e459726c5c945 = [];
    level.ztron.var_2b1f629006f6468b = utility::getstructarray( "island_player_spawnpoint", "targetname" );
    level.ztron.var_fb464311636908a3 = 1;
    level.ztron.lastPapabackSpawn = 0;
    level.ztron.getnextarena = &getnextarena;
    level.ztron.var_c68c8726e15520d9 = &function_c68c8726e15520d9;
    arenas = utility::getstructarray( "arena_center", "targetname" );
    var_1972ad4914848d4f = [];
    
    foreach ( arena in arenas )
    {
        assert( isdefined( arena.script_parameters ), "<dev string:x24>" );
        args = strtok( arena.script_parameters, ";" );
        order = int( args[ 0 ] );
        assert( !isdefined( var_1972ad4914848d4f[ order ] ), "<dev string:x81>" + arena.script_noteworthy );
        var_1972ad4914848d4f[ order ] = arena;
    }
    
    id = 0;
    
    for ( index = 0; index < 100 ; index++ )
    {
        if ( isdefined( var_1972ad4914848d4f[ index ] ) )
        {
            registerarena( var_1972ad4914848d4f[ index ], id );
            id++;
        }
    }
    
    ztron_camera::function_740408a841dcb4a5( level.ztron.arenas[ 0 ].center.origin );
    level.ztron.var_3a1ceb1de0671b54 = [ #"elec_pole", #"lawn_mower", #"specter", #"oil_tank", #"crate", #"laser_trap", #"tornado" ];
    level.ztron.var_3711b7c53905302d = [ #"explo_barrel", #"physicsbox", #"fireball", #"dragonhead", #"pungi", #"flogger", #"killbox", #"runestatue", #"elemental_terrain", #"rock_slide", #"moving_platform", #"moving_laser", #"rotating_laser", #"hazard_fungus", #"conveyor_belt", #"air_fan", #"aether_slate" ];
    level utility::flag_init( "ztron_round_spawning" );
    level utility::flag_init( "ztron_round_paused" );
    level utility::flag_init( "ztron_round_over" );
    initsound();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        function_6c0f05eab8f87f6f();
        level.ztron.var_ea94561ca03b6911 = [];
        level callback::add( #"player_spawned", &onplayerspawned );
    }
    
    /#
        function_ac7ee3673d6e340d();
    #/
}

// Namespace ztron_arena
// Params 0, eflags: 0x4
// Checksum 0x2185d9ec, Offset: 0x1669
// Size: 0x32d
function private function_6c0f05eab8f87f6f()
{
    function_75b7773b02ffec7b( "island", undefined, "babylon", "firebase", "top", "left" );
    function_75b7773b02ffec7b( "babylon", undefined, "graveyard", "nuketown", "top", "bottom" );
    function_75b7773b02ffec7b( "firebase", undefined, "graveyard", "nuketown", "right", "left" );
    function_75b7773b02ffec7b( "lava_cave", undefined, "fort_courtyard", "church", "right", "left", "motel", "museum", "top", "bottom" );
    function_75b7773b02ffec7b( "fort_courtyard", undefined, "sculpture", "dry_garden", "top", "bottom" );
    function_75b7773b02ffec7b( "church", undefined, "sculpture", "dry_garden", "top", "bottom" );
    function_75b7773b02ffec7b( "museum", undefined, "homestead", "melting", "left", "bottom" );
    function_75b7773b02ffec7b( "motel", undefined, "homestead", "melting", "left", "bottom" );
    function_75b7773b02ffec7b( "aethereal_swamp", undefined, "aethereal_jungle", undefined, "bottom" );
    function_75b7773b02ffec7b( "aethereal_jungle", undefined, "silverback_arena", undefined, "bottom" );
    function_75b7773b02ffec7b( "town_square", undefined, "estate_courtyard", undefined, "left" );
    function_75b7773b02ffec7b( "estate_courtyard", undefined, "silverback_arena", undefined, "left" );
    level.ztron.var_30dc288b7210c158 = [ "silverback_arena":[ "island" ], "aethereal_jungle":[ "silverback_arena" ], "aethereal_swamp":[ "aethereal_jungle" ], "melting":[ "aethereal_swamp" ], "homestead":[ "aethereal_swamp" ], "museum":[ "homestead", "melting" ], "motel":[ "homestead", "melting" ], "estate_courtyard":[ "silverback_arena" ], "town_square":[ "estate_courtyard" ], "dry_garden":[ "town_square" ], "sculpture":[ "town_square" ], "church":[ "sculpture", "dry_garden" ], "fort_courtyard":[ "sculpture", "dry_garden" ], "lava_cave":[ "fort_courtyard", "church", "motel", "museum" ], "ritual":[ "lava_cave" ], "nuketown":[ "ritual" ], "graveyard":[ "ritual" ], "firebase":[ "graveyard", "nuketown" ], "babylon":[ "graveyard", "nuketown" ], "island":[ "babylon", "firebase" ] ];
}

// Namespace ztron_arena
// Params 0, eflags: 0x4
// Checksum 0x5a7dc225, Offset: 0x199e
// Size: 0x59
function private initsound()
{
    ztron_sound::function_4ac735395b173fe( "ztron_teleporter_spawn", "evt_ztron_teleporter_spawn" );
    ztron_sound::function_4ac735395b173fe( "ztron_teleporter_lp", "evt_ztron_teleporter_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_travel_portal_travel", "evt_ztron_travel_portal_travel" );
    ztron_sound::function_4ac735395b173fe( "ztron_travel_doors_unlocked", "evt_ztron_travel_doors_unlocked" );
    ztron_sound::function_4ac735395b173fe( "ztron_travel_doors_chosen", "evt_ztron_travel_doors_chosen" );
}

// Namespace ztron_arena
// Params 3
// Checksum 0x7d8fc01, Offset: 0x19ff
// Size: 0x6a
function function_c61881897b87656d( name, initf, shutdownf )
{
    assert( isdefined( name ), "<dev string:xc7>" );
    
    if ( isdefined( name ) )
    {
        arena = function_973956bb5a6e60f7( name );
        
        if ( isdefined( arena ) )
        {
            arena.activationfunc = initf;
            arena.deactivationfunc = shutdownf;
        }
    }
}

// Namespace ztron_arena
// Params 2
// Checksum 0xd706dbe0, Offset: 0x1a71
// Size: 0xae5
function registerarena( var_a0ea22c4dcbee483, index )
{
    level endon( #"ztron_game_is_over" );
    arena = spawnstruct();
    arena.center = var_a0ea22c4dcbee483;
    arena.name = var_a0ea22c4dcbee483.script_noteworthy;
    arena.id = index;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        arena.var_84e9c31fbaa384af = getdvarint( @"hash_1fbc1a1993b9a784", 60 );
    }
    else
    {
        arena.var_84e9c31fbaa384af = getdvarint( @"hash_a9401d52263a0d85", 46 );
    }
    
    arena.var_ae48c1fd2b6e2299 = getdvarint( @"hash_a9ab1ef553c74654", 7 );
    arena.var_bbc024c10c8d4b9e = 24;
    arena.var_5fab9e8651b8e54a = utility::getstructarray( arena.name + "_player_spawnpoint", "targetname" );
    assert( arena.var_5fab9e8651b8e54a.size == 4, "<dev string:xf2>" + arena.name );
    arena.lootspots = utility::getstructarray( arena.name + "_pickup", "targetname" );
    arena.bgbspots = utility::getstructarray( arena.name + "_bgb", "targetname" );
    arena.var_9df48f55f947471f = utility::getstructarray( arena.name + "_drop", "targetname" );
    arena.exits = [];
    exits = ztron_util::function_2d9de5c7b97db39( arena.name + "_exit", #targetname );
    assert( exits.size == 4, "<dev string:x124>" + arena.name );
    
    foreach ( exit in exits )
    {
        arena.exits[ exit.script_noteworthy ] = exit;
        exit.isdisabled = 1;
        exit.exitstarts = utility::getstructarray( exit.target, "targetname" );
        assert( exit.exitstarts.size == 4, "<dev string:x150>" + exit.script_noteworthy + "<dev string:x169>" + arena.name );
    }
    
    exitblockers = [];
    exitblockers[ "bottom" ] = getentarray( arena.name + "_blocker_bottom", #targetname );
    exitblockers[ "left" ] = getentarray( arena.name + "_blocker_left", #targetname );
    exitblockers[ "top" ] = getentarray( arena.name + "_blocker_top", #targetname );
    exitblockers[ "right" ] = getentarray( arena.name + "_blocker_right", #targetname );
    
    foreach ( blocker in exitblockers[ "bottom" ] )
    {
        blocker.original_location = blocker.origin;
        blocker.side = "bottom";
    }
    
    foreach ( blocker in exitblockers[ "left" ] )
    {
        blocker.original_location = blocker.origin;
        blocker.side = "left";
    }
    
    foreach ( blocker in exitblockers[ "top" ] )
    {
        blocker.original_location = blocker.origin;
        blocker.side = "top";
    }
    
    foreach ( blocker in exitblockers[ "right" ] )
    {
        blocker.original_location = blocker.origin;
        blocker.side = "right";
    }
    
    arena.exitblockers = exitblockers;
    arena.safespots = utility::getstructarray( arena.name + "_safe_spot", "targetname" );
    arena.safespots = arraycombineunique( arena.safespots, arena.var_5fab9e8651b8e54a );
    arena.safespots = arraycombineunique( arena.safespots, arena.lootspots );
    arena.hazardspots = utility::getstructarray( arena.name + "_hazard", "targetname" );
    arena.papabackspots = utility::getstructarray( arena.name + "_papaback_spawn", "targetname" );
    arena.var_13e779d5bde58881 = utility::getstructarray( arena.name + "_vermin_spawn", "targetname" );
    arena.safevolumes = getentarray( arena.name + "_safety_volume", "targetname" );
    enemyspots = [];
    enemyspots[ "bottom" ] = utility::getstructarray( arena.name + "_enemy_spawn_bottom", "targetname" );
    enemyspots[ "left" ] = utility::getstructarray( arena.name + "_enemy_spawn_left", "targetname" );
    enemyspots[ "top" ] = utility::getstructarray( arena.name + "_enemy_spawn_top", "targetname" );
    enemyspots[ "right" ] = utility::getstructarray( arena.name + "_enemy_spawn_right", "targetname" );
    
    foreach ( spot in enemyspots[ "bottom" ] )
    {
        spot.origin = ztron_util::function_3fe38741460a4a49( spot.origin );
    }
    
    foreach ( spot in enemyspots[ "left" ] )
    {
        spot.origin = ztron_util::function_3fe38741460a4a49( spot.origin );
    }
    
    foreach ( spot in enemyspots[ "top" ] )
    {
        spot.origin = ztron_util::function_3fe38741460a4a49( spot.origin );
    }
    
    foreach ( spot in enemyspots[ "right" ] )
    {
        spot.origin = ztron_util::function_3fe38741460a4a49( spot.origin );
    }
    
    foreach ( key in getarraykeys( enemyspots ) )
    {
        if ( enemyspots[ key ].size < 3 )
        {
            ztron_debug::debugmsg( "ATTENTION! Side (" + key + ") of map " + arena.name + " only has " + enemyspots[ key ].size + " enemy spots defined.  Minimum is 3" );
        }
    }
    
    arena.enemyspots = enemyspots;
    arena.var_913d403c0a0102ea = ztron_util::function_2d9de5c7b97db39( arena.name + "_camera_tweak", #targetname );
    var_190e5fd247eb323e = getent( arena.name + "_heli_height_lock", #targetname );
    
    if ( var_190e5fd247eb323e && var_190e5fd247eb323e.classname == "script_brushmodel" )
    {
        var_190e5fd247eb323e notsolid();
        arena.var_bd9df22b9216b2af = var_190e5fd247eb323e;
    }
    
    level.ztron.arenas[ arena.id ] = arena;
    return arena;
}

// Namespace ztron_arena
// Params 1
// Checksum 0xdaa4bd44, Offset: 0x255f
// Size: 0x9a
function function_973956bb5a6e60f7( name )
{
    foreach ( arena in level.ztron.arenas )
    {
        if ( arena.name == name )
        {
            return arena;
        }
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0x9ba11fbd, Offset: 0x2601
// Size: 0x1f6
function function_8aac54c4cf4240af( name )
{
    if ( !isdefined( name ) )
    {
        return;
    }
    
    switch ( name )
    {
        case #"hash_d48ee44548bb9e4c":
            return &"ztron_hud/arena_island";
        case #"hash_832bdc229a6a3a":
            return &"ztron_hud/arena_babylon";
        case #"hash_5a4d2b12a19ad464":
            return &"ztron_hud/arena_firebase";
        case #"hash_c7f751358c7a68a6":
            return &"ztron_hud/arena_graveyard";
        case #"hash_f6a69f4bf9bd072":
            return &"ztron_hud/arena_ritual";
        case #"hash_702f1fc838e40139":
            return &"ztron_hud/arena_lava_cave";
        case #"hash_15630a99f1361c04":
            return &"ztron_hud/arena_fort_courtyard";
        case #"hash_31ccf4980e7b0f42":
            return &"ztron_hud/arena_church";
        case #"hash_45b734631b205714":
            return &"ztron_hud/arena_sculpture";
        case #"hash_6f76efa550b671d6":
            return &"ztron_hud/arena_dry_garden";
        case #"hash_70e09da89f425e1d":
            return &"ztron_hud/arena_town_square";
        case #"hash_bbc96d75d7f00a3d":
            return &"ztron_hud/arena_estate_courtyard";
        case #"hash_eeffcb3868e1290a":
            return &"ztron_hud/arena_motel";
        case #"hash_81362f13a0a0d675":
            return &"ztron_hud/arena_museum";
        case #"hash_131dde448a5cd67c":
            return &"ztron_hud/arena_nuketown";
        case #"hash_8623b05fe4b87521":
            return &"ztron_hud/arena_homestead";
        case #"hash_77ce93183dbf4b59":
            return &"ztron_hud/arena_melting";
        case #"hash_8520a2d6e5b67789":
            return &"ztron_hud/arena_aethereal_swamp";
        case #"hash_60b556a73fcd0b86":
            return &"ztron_hud/arena_aethereal_jungle";
        case #"hash_e66e13ca7c39a3f3":
            return &"ztron_hud/arena_silverback_arena";
        default:
            assert( 0, "<dev string:x175>" + name );
            break;
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0xa8d03fa1, Offset: 0x27ff
// Size: 0x100
function function_9b7bf2d5c866b74d( side )
{
    arena = level.ztron.active_arena;
    assert( arena.enemyspots[ side ], "<dev string:x18a>" + side + "<dev string:x1a3>" + arena.name );
    
    if ( !isdefined( arena.lastspots ) )
    {
        arena.lastspots = [];
    }
    
    if ( !isdefined( arena.lastspots[ side ] ) )
    {
        arena.lastspots[ side ] = 0;
    }
    
    spot = arena.enemyspots[ side ][ arena.lastspots[ side ] ];
    arena.lastspots[ side ]++;
    
    if ( arena.lastspots[ side ] >= arena.enemyspots[ side ].size )
    {
        arena.lastspots[ side ] = 0;
    }
    
    return spot;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x67b0371e, Offset: 0x2908
// Size: 0xea
function function_f689226c25e1df4e()
{
    arena = level.ztron.active_arena;
    
    if ( isdefined( arena ) )
    {
        assert( arena.var_5fab9e8651b8e54a, "<dev string:x1b6>" + arena.name );
        return arena.var_5fab9e8651b8e54a;
    }
    else if ( level.ztron.var_ad327faac9d676e5 )
    {
        restorearena = level.ztron.arenas[ level.ztron.var_9550382645aa427e ];
        
        if ( isdefined( restorearena ) )
        {
            assert( restorearena.var_5fab9e8651b8e54a, "<dev string:x1b6>" + restorearena.name );
            return restorearena.var_5fab9e8651b8e54a;
        }
    }
    
    return level.ztron.var_2b1f629006f6468b;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xfa433ce9, Offset: 0x29fb
// Size: 0x16
function function_df690dba6107f29c()
{
    return level.ztron.arenas.size;
}

// Namespace ztron_arena
// Params 10
// Checksum 0x51f9b6c0, Offset: 0x2a1a
// Size: 0x1ab
function function_75b7773b02ffec7b( arenaname, branchlogic, var_a72073b6badad331, var_dc543c45b2bd9574, var_149678fa4157d59a, var_b487d80f776d47ab, var_9419960d3c43a13f, var_9a2f2e089d25270a, var_1293e47f2bf0b20, var_d928c47c261371c1 )
{
    arena = function_973956bb5a6e60f7( arenaname );
    assert( isdefined( arena ) );
    assert( isdefined( var_a72073b6badad331 ) );
    assert( isdefined( var_149678fa4157d59a ) );
    assert( !isdefined( level.ztron.var_b6efb062e0563051[ arenaname ] ), "<dev string:x1e3>" );
    branchstruct = spawnstruct();
    branchstruct.id = arena.id;
    branchstruct.branchlogic = branchlogic;
    branchstruct.exitname = [];
    branchstruct.exitname[ var_149678fa4157d59a ] = var_a72073b6badad331;
    branchstruct.firsttargetname = var_a72073b6badad331;
    
    if ( isdefined( var_dc543c45b2bd9574 ) && isdefined( var_b487d80f776d47ab ) )
    {
        branchstruct.exitname[ var_b487d80f776d47ab ] = var_dc543c45b2bd9574;
        branchstruct.secondtargetname = var_dc543c45b2bd9574;
    }
    
    if ( isdefined( var_9419960d3c43a13f ) && isdefined( var_1293e47f2bf0b20 ) )
    {
        branchstruct.exitname[ var_1293e47f2bf0b20 ] = var_9419960d3c43a13f;
        branchstruct.thirdtargetname = var_9419960d3c43a13f;
    }
    
    if ( isdefined( var_9a2f2e089d25270a ) && isdefined( var_d928c47c261371c1 ) )
    {
        branchstruct.exitname[ var_d928c47c261371c1 ] = var_9a2f2e089d25270a;
        branchstruct.var_c0debeaf1f37c67b = var_9a2f2e089d25270a;
    }
    
    level.ztron.var_b6efb062e0563051[ arenaname ] = branchstruct;
}

// Namespace ztron_arena
// Params 1
// Checksum 0xc6d69504, Offset: 0x2bcd
// Size: 0x30a
function function_d9895b0df04e27ae( arenaid )
{
    branchrequest = level.ztron.var_b6efb062e0563051[ level.ztron.arenas[ arenaid ].name ];
    wait 4;
    var_cf30494c821a2d56 = [];
    
    foreach ( key in getarraykeys( branchrequest.exitname ) )
    {
        var_cf30494c821a2d56[ var_cf30494c821a2d56.size ] = key;
        ztron_debug::debugmsg( "handleBranchLogic (" + arenaid + ") Found Exit:" + key );
    }
    
    level function_4019c4a603cd949e( branchrequest.id, var_cf30494c821a2d56 );
    level utility::waittill_any_timeout( isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300, "ztron_exit_taken", "advance_to_next_arena" );
    exit = level.ztron.active_arena.exittaken;
    
    if ( isdefined( exit ) )
    {
        side = exit.side;
    }
    
    if ( !isdefined( side ) )
    {
        side = var_cf30494c821a2d56[ randomint( var_cf30494c821a2d56.size ) ];
    }
    
    assert( isdefined( side ) );
    var_5fa1514cff07edbd = branchrequest.exitname[ side ];
    level.ztron.var_bdbf6cf2011e0b2d = function_973956bb5a6e60f7( var_5fa1514cff07edbd ).id;
    level.ztron.var_d0972e445894306d = undefined;
    
    if ( branchrequest.firsttargetname == var_5fa1514cff07edbd )
    {
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 0;
    }
    else if ( branchrequest.secondtargetname == var_5fa1514cff07edbd )
    {
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 1;
    }
    else if ( branchrequest.thirdtargetname == var_5fa1514cff07edbd )
    {
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 2;
    }
    else
    {
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = 3;
    }
    
    thread ztron_ui::function_464c14312837a513();
    level notify( #"ztron_teleporter_taken" );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xfca4d522, Offset: 0x2edf
// Size: 0x91
function function_c68c8726e15520d9( arenaid )
{
    ztron_debug::debugmsg( "tryBranchingLevel for arena:" + arenaid );
    branchrequest = level.ztron.var_b6efb062e0563051[ level.ztron.arenas[ arenaid ].name ];
    
    if ( isdefined( branchrequest ) )
    {
        if ( isdefined( branchrequest.branchlogic ) )
        {
            return branchrequest.branchlogic;
        }
        else
        {
            return &function_d9895b0df04e27ae;
        }
    }
    
    ztron_debug::debugmsg( "No Branch Found" );
}

// Namespace ztron_arena
// Params 0
// Checksum 0xdf689174, Offset: 0x2f79
// Size: 0x2
function function_4959e0a6f8670b72()
{
    
}

// Namespace ztron_arena
// Params 0
// Checksum 0x7dc29ce, Offset: 0x2f83
// Size: 0x17
function function_90d31e8c6c0eaf9()
{
    level.ztron.gobblegumsenabled = 0;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xbce291d, Offset: 0x2fa2
// Size: 0x32d
function function_3323bd8e1303176()
{
    level.ztron.gobblegumsenabled = 0;
    level.ztron.var_d0972e445894306d = 30;
    scavengerlvl = namespace_4f98d1d7dc3196d::function_de5c10056990b7da( "scavenger" );
    level.ztron.var_d0972e445894306d += scavengerlvl * 2;
    level.ztron.var_ce1978f284e95152 = 0;
    level.ztron.var_501b246c862a128e = 0;
    level.ztron.var_992f29dbad27ad98 = 0.2;
    level.ztron.var_92c01edd802f6a18 = 0;
    level.ztron.var_be8fbd1178946a9 = 0;
    level.ztron.var_bdb94bcd4b8c89bd = 1;
    level.ztron.var_3ee4688dfd3a7d7c = 0.5;
    level.ztron.var_c7659fc1aabef3f0 = 0.1;
    level.ztron.var_c5d5ecce60380726 = [];
    
    foreach ( entry in level.ztron.enemytypes )
    {
        if ( !isdefined( entry.unlockround ) || entry.unlockround == -1 )
        {
            continue;
        }
        
        level.ztron.var_c5d5ecce60380726[ level.ztron.var_c5d5ecce60380726.size ] = entry.unlockround;
    }
    
    level.ztron.var_88b879586dee302f = 0;
    level.ztron.var_acd7346203660b39 = ztron_item::function_71e133b37011bee6( "ztron_timepiece" );
    level.ztron.var_9a38721bfdf46da = 5;
    level.ztron.var_cbceca19d7ef7c87 = 0;
    level.ztron.var_82d1944280581536 = 0;
    level.ztron.var_baa92581d736bcde = 0;
    
    if ( level.ztron.metaenabled )
    {
        namespace_4f98d1d7dc3196d::function_156f5e9e41ac12aa();
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_ztron_blitz_meta_hint", 0 );
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0x799a5939, Offset: 0x32d7
// Size: 0x60
function getnextarena( currentarena )
{
    id = ( currentarena + 1 ) % level.ztron.arenas.size;
    
    if ( isdefined( level.ztron.var_bdbf6cf2011e0b2d ) )
    {
        id = level.ztron.var_bdbf6cf2011e0b2d;
    }
    
    return id;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x9459be6d, Offset: 0x3340
// Size: 0x56f
function main()
{
    self notify( #"hash_2e2bed94255635b9" );
    self endon( #"hash_2e2bed94255635b9" );
    level endon( #"ztron_game_is_over" );
    function_f2e9dd5fcbd74bd( 0, 1 );
    
    if ( level.ztron.arenas.size == 0 )
    {
        return;
    }
    
    foreach ( arena in level.ztron.arenas )
    {
        arena deactivatearena();
    }
    
    level.ztron.active_arena = undefined;
    level.ztron.currentarena = 0;
    level.ztron.var_a58d52a0faa75a57 = [];
    level.ztron.var_bdbf6cf2011e0b2d = undefined;
    ztron_ui::function_464c14312837a513();
    level endon( #"ztron_game_is_over" );
    level utility::flag_wait_all( "ztron_system_start" );
    utility::flag_wait_all( "ztron_restore_finished" );
    level.ztron.game_running = 1;
    
    if ( level.ztron.blitzmode )
    {
        function_3323bd8e1303176();
    }
    else if ( level.ztron.var_371903e5801e0e08 )
    {
        function_4959e0a6f8670b72();
    }
    else if ( level.ztron.var_95d8c7a469393957 )
    {
        function_90d31e8c6c0eaf9();
    }
    
    if ( level.ztron.var_173a38989c2cb25f )
    {
        ztron_ui::function_37aad40e39a9fdfe( "game_starting" );
        arena = level.ztron.arenas[ level.ztron.currentarena ];
        arena.var_bbb74b6dde0dc6bd = 1;
    }
    
    while ( level.ztron.game_running )
    {
        if ( level.ztron.var_ad327faac9d676e5 )
        {
            level.ztron.roundnumber = level.ztron.var_3f4113a10dece01d;
            ztron_main::function_2da19957201c6090();
            
            if ( level.ztron.roundnumber > 5 )
            {
                ztron_main::function_a14deb691144654e();
            }
            
            level.ztron.currentarena = level.ztron.var_9550382645aa427e;
            setomnvar( "ui_ztron_arena_number", level.ztron.var_9550382645aa427e );
            arena = level.ztron.arenas[ level.ztron.var_9550382645aa427e ];
            arena.var_bbb74b6dde0dc6bd = undefined;
            level.ztron.var_db337c72253293a4 = undefined;
            level notify( #"hash_4fa5e390364ace2d" );
            level thread function_ccdf9ab2d1e56830( level.ztron.currentarena, level.ztron.var_89860c0b6bc5f6e3, 1 );
            level.ztron.var_ad327faac9d676e5 = undefined;
            level.ztron.var_89860c0b6bc5f6e3 = undefined;
            level.ztron.var_9550382645aa427e = undefined;
            level.ztron.var_3f4113a10dece01d = undefined;
            thread ztron_ui::function_464c14312837a513();
        }
        else
        {
            level thread function_ccdf9ab2d1e56830( level.ztron.currentarena );
        }
        
        result = level utility::waittill_any_return( "advance_to_next_arena", "return_to_arena_logic" );
        var_fcbbc067e2b4df9e = [[ level.ztron.getnextarena ]]( level.ztron.currentarena );
        level.ztron.var_bdbf6cf2011e0b2d = undefined;
        
        if ( var_fcbbc067e2b4df9e == 0 )
        {
            if ( level.ztron.var_371903e5801e0e08 && level.ztron.var_81b3951997d9b481 )
            {
                thread ztron_main::endgame( "tie", game[ "end_reason" ][ "round_limit_reached" ] );
                wait 10;
            }
            
            level.ztron.game_laps++;
            level notify( #"game_lap" );
            level.ztron.var_a58d52a0faa75a57 = [];
        }
        
        if ( level.ztron.var_371903e5801e0e08 )
        {
            thread ztron_ui::function_464c14312837a513();
        }
        
        setomnvar( "ui_ztron_arena_number", var_fcbbc067e2b4df9e );
        
        if ( level.ztron.blitzmode )
        {
            level.ztron.var_f845f668cc11904f = 1;
        }
        
        function_ec27c480ffdc3c4e( level.ztron.var_f845f668cc11904f, level.ztron.var_451384c8c5191473, var_fcbbc067e2b4df9e );
        level.ztron.var_f845f668cc11904f = undefined;
        level.ztron.var_451384c8c5191473 = undefined;
        level.ztron.currentarena = var_fcbbc067e2b4df9e;
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0x525cd2d3, Offset: 0x38b7
// Size: 0xb6
function function_eb3bad474c41ae42( type )
{
    if ( !isdefined( type ) )
    {
        return self.hazardspots;
    }
    
    hazards = [];
    
    foreach ( var_4d080f710fb8349e in self.hazardspots )
    {
        if ( var_4d080f710fb8349e.script_noteworthy == type )
        {
            hazards[ hazards.size ] = var_4d080f710fb8349e;
        }
    }
    
    return hazards;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x5d6ec9bd, Offset: 0x3975
// Size: 0x8f
function function_7c22457f6306a278()
{
    foreach ( var_4d080f710fb8349e in level.ztron.var_3a1ceb1de0671b54 )
    {
        level thread ztron_hazard::function_ed33fea23f0d8109( var_4d080f710fb8349e, #"arenaspawn" );
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x3b72d85e, Offset: 0x3a0c
// Size: 0x8f
function function_15d63b44db72a92()
{
    foreach ( var_4d080f710fb8349e in level.ztron.var_3711b7c53905302d )
    {
        level thread ztron_hazard::function_ed33fea23f0d8109( var_4d080f710fb8349e, #"arenaspawn" );
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xb37ad060, Offset: 0x3aa3
// Size: 0x154
function function_d3beb9c94441e455()
{
    self notify( #"hash_8d106c9d64fe13d1" );
    self endon( #"hash_8d106c9d64fe13d1" );
    level endon( #"arena_completed" );
    level endon( #"ztron_game_is_over" );
    level endon( #"arena_deactivated" );
    newpoints = [];
    
    foreach ( lootpoint in level.ztron.active_arena.var_9df48f55f947471f )
    {
        if ( !lootpoint.itemused )
        {
            newpoints[ newpoints.size ] = lootpoint;
        }
    }
    
    ztron_item::function_6607be6e510e8f54( newpoints );
    
    foreach ( lootpoint in newpoints )
    {
        lootpoint childthread function_b9ccdb5a4a60da08();
    }
}

// Namespace ztron_arena
// Params 0, eflags: 0xc
// Checksum 0x1d8891e3, Offset: 0x3bff
// Size: 0x3b
function private function_b9ccdb5a4a60da08()
{
    self notify( #"hash_8a4310847338c507" );
    self endon( #"hash_8a4310847338c507" );
    self waittill( #"item_spawned" );
    
    if ( isdefined( self.item ) )
    {
        thread function_5cc5cae8d4e515cf();
    }
}

// Namespace ztron_arena
// Params 0, eflags: 0xc
// Checksum 0x816db8e3, Offset: 0x3c42
// Size: 0x4e
function private function_5cc5cae8d4e515cf()
{
    self notify( #"hash_aa2dad120d2200a9" );
    self endon( #"hash_aa2dad120d2200a9" );
    self.item endon( #"death" );
    self.item waittill( #"picked_up" );
    self.itemused = 1;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x5288c982, Offset: 0x3c98
// Size: 0xcc
function function_90a4f2d50a50aa33()
{
    var_5fab9e8651b8e54a = self.var_5fab9e8651b8e54a ?? level.ztron.var_2b1f629006f6468b;
    
    foreach ( player in level.players )
    {
        player.ztron.predictedspawnpoint = var_5fab9e8651b8e54a[ player.sessionuimemberindex % var_5fab9e8651b8e54a.size ];
        player ztron_ui::function_f7e6c4641e827bf8( 0 );
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x5e7b21a2, Offset: 0x3d6c
// Size: 0x465
function function_40a8071aef0c59b9()
{
    if ( level.ztron.skipNextTeleportOnRoundStart )
    {
        level.ztron.skipNextTeleportOnRoundStart = 0;
        
        foreach ( player in level.players )
        {
            player thread ztron_camera::function_d5969d200777318d( 1 );
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player ztron_player_utility::isplayerspectating() )
            {
                continue;
            }
            
            if ( !isdefined( player.ztron.predictedspawnpoint ) )
            {
                if ( isdefined( self.exittaken ) )
                {
                    exitstart = self.exittaken.exitstarts[ player.sessionuimemberindex ];
                    
                    if ( !isdefined( exitstart.angles ) )
                    {
                        exitstart.angles = ( 0, 0, 0 );
                    }
                    
                    player.ztron.predictedspawnpoint = exitstart;
                }
                else
                {
                    player.ztron.predictedspawnpoint = self.var_5fab9e8651b8e54a[ player.sessionuimemberindex ];
                }
                
                assert( isdefined( player.ztron.predictedspawnpoint ), "<dev string:x21c>" + self.name + "<dev string:x237>" );
            }
            
            spawnpoint = ( player.ztron.predictedspawnpoint.origin[ 0 ], player.ztron.predictedspawnpoint.origin[ 1 ], player.ztron.predictedspawnpoint.origin[ 2 ] );
            assert( isdefined( spawnpoint ), "<dev string:x252>" + player.name + "<dev string:x275>" + self.name );
            
            if ( isdefined( player.ztron.vehicle ) )
            {
                data = vehicle::get_data( player.ztron.vehicle vehicle::get_ref() );
                
                if ( data.canfly )
                {
                    spawnpoint = ( spawnpoint[ 0 ], spawnpoint[ 1 ], spawnpoint[ 2 ] + 85 );
                }
            }
            
            player ztron_util::teleport_player( spawnpoint, player.ztron.predictedspawnpoint.angles );
        }
        
        level ztron_camera::function_517f03fc102b896d( 1 );
        wait 1;
        level ztron_camera::function_517f03fc102b896d( 0 );
        
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_985a085be4ea0ba4();
        }
    }
    
    level ztron_util::function_52cbd62de5b033c9();
    
    foreach ( player in level.players )
    {
        var_6b6e3e10de663faa = player val::get_specific_id( "show_hud", "ztron_loading" );
        
        if ( var_6b6e3e10de663faa == 0 )
        {
            player val::set( "ztron_loading", "show_hud", 1 );
        }
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xe400c8c7, Offset: 0x41d9
// Size: 0x9f
function function_94ed90441a0568ae()
{
    foreach ( player in level.players )
    {
        if ( !player ztron_player_utility::function_a120489ddd3aa5ce() )
        {
            continue;
        }
        
        if ( player ztron_player_utility::isplayerspectating() )
        {
            continue;
        }
        
        player ztron_camera::function_1873609edbd36982();
    }
    
    function_40a8071aef0c59b9();
}

// Namespace ztron_arena
// Params 0
// Checksum 0xc0686a49, Offset: 0x4280
// Size: 0x7b
function function_d23a1fb605db017d()
{
    foreach ( player in level.players )
    {
        player ztron_player::function_b3f2e7a97bd8b613();
    }
}

// Namespace ztron_arena
// Params 3
// Checksum 0x52309cb3, Offset: 0x4303
// Size: 0x1404
function function_ccdf9ab2d1e56830( arenaid, rounds = 4, isrestored = 0 )
{
    self notify( #"hash_dad5a6167013fc64" );
    self endon( #"hash_dad5a6167013fc64" );
    level endon( #"ztron_game_is_over", #"arena_completed" );
    ztron_debug::debugmsg( "runArenaLogic starting for: " + arenaid );
    arena = level.ztron.arenas[ arenaid ];
    
    if ( !level.ztron.var_ad327faac9d676e5 )
    {
        rounds = level.ztron.var_bdb94bcd4b8c89bd;
    }
    
    if ( !arena.var_bbb74b6dde0dc6bd )
    {
        level thread ztron_util::fade_out_hold();
    }
    
    arena.var_bbb74b6dde0dc6bd = undefined;
    removeallfxmarks();
    
    if ( level.ztron.blitzmode )
    {
        ztron_weather::resetlightstate( randomint( 4 ) );
    }
    else
    {
        ztron_weather::resetlightstate( 4 - rounds );
    }
    
    if ( !isrestored )
    {
        ztron_main::function_2da19957201c6090( level.ztron.roundnumber + 1 );
    }
    
    ztron_main::function_6cacd29a4f2b9588( 1 );
    ztron_enemy::function_be8fbd1178946a9( level.ztron.roundnumber );
    ztron_util::killallenemies();
    function_ef31efadee606b76( arenaid );
    
    if ( isrestored )
    {
        function_f2e9dd5fcbd74bd( rounds % 2 == 1 );
    }
    
    function_d23a1fb605db017d();
    level.ztron.arena_rounds_left = rounds;
    
    if ( !level.ztron.var_db337c72253293a4 )
    {
        level.ztron.active_arena function_90a4f2d50a50aa33();
    }
    
    while ( level.ztron.arena_rounds_left > 0 )
    {
        foreach ( player in level.players )
        {
            if ( !player ztron_player_utility::function_32883fa42c326520() )
            {
                player ztron_player_utility::function_dac9f20d4461a130();
            }
        }
        
        ztron_debug::debugmsg( "   ##@@@@ NEW ROUND [" + level.ztron.roundnumber + "] @@@@##: " + level.ztron.active_arena.name );
        level notify( #"round_about_to_start" );
        waitframe();
        
        if ( !level.ztron.var_db337c72253293a4 )
        {
            level.ztron.active_arena thread function_94ed90441a0568ae();
        }
        else
        {
            level utility::flag_clear( "ztron_screen_faded" );
        }
        
        level.ztron.var_db337c72253293a4 = undefined;
        level thread ztron_world_event::function_b0d378779942dd03( 4 - level.ztron.arena_rounds_left );
        
        while ( level utility::flag( "ztron_screen_faded" ) )
        {
            wait 0.25;
        }
        
        level.ztron.roundplayercount += level.players.size;
        level.ztron.roundStartTime = gettime();
        level.ztron.var_dc6d34f4a8b9fad6 = 0;
        level.ztron.var_6a29f05e45e873d0 = 0;
        level.ztron.var_787898a6340dbcbc = 0;
        level.ztron.var_643bcde7c8fa63e3 = 0;
        level.ztron.var_c1a505007543d033 = 0;
        level.ztron.wavesleft = 0;
        level.ztron.var_32de363d4305c0c = 0;
        level.ztron.var_316dc0679575bf4d = 0;
        level.ztron.var_91517987ca332e2a = 0;
        level.ztron.active_arena function_88c5627b236319bf();
        level.ztron.active_arena function_221d68c3fc140fa3();
        level.ztron.active_arena function_7c22457f6306a278();
        level.ztron.itemdef.var_a6fb8def3d6b72e9 = 1;
        function_bdf5aff7155ba61c( level.ztron.roundnumber );
        function_ece71b37bd114ed();
        level notify( #"round_begin_warm_up" );
        ztron_player_utility::function_28d3a926aa4df460();
        wait 3;
        var_daa3a9e1e2cdf839 = ztron_challenge::function_d6dad472bec7f9cd( level.ztron.active_arena.name, 4 - level.ztron.arena_rounds_left + 1 );
        
        if ( var_daa3a9e1e2cdf839 )
        {
            level waittill( #"challenge_ready", challengename );
            level.ztron.activechallenge = challengename;
            function_f67be8b4fbb24ab9( challengename );
        }
        else
        {
            level.ztron.activechallenge = undefined;
        }
        
        level callback::remove( "on_zombie_ai_killed", &on_ai_killed );
        level callback::add( "on_zombie_ai_killed", &on_ai_killed );
        level.ztron.var_5d66e2173c3de46f = 0;
        
        if ( level.ztron.blitzmode )
        {
            level thread function_eaf0cd9998d84176();
        }
        else if ( level.ztron.var_477ba2c6e6ba2820 )
        {
            level thread function_a66946f774c9cea4();
        }
        else
        {
            level thread function_8948506f3660f658();
        }
        
        /#
            ztron_dev::function_61a8de4c804ac998();
        #/
        
        level notify( #"round_begin" );
        
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_af4808ad87d6d3a();
            player notify( #"round_begin" );
        }
        
        level thread function_9b2d66cd16a8a256();
        
        if ( level.ztron.blitzmode && arenaid > 0 )
        {
            level.ztron.var_82d1944280581536 += level.players.size;
            level.ztron.var_baa92581d736bcde++;
            level utility::flag_set( "ztron_round_paused" );
            namespace_423c46dff63ec005::function_c0ca6b6e15e9ae7f( arenaid );
            level utility::flag_clear( "ztron_round_paused" );
            level thread namespace_423c46dff63ec005::function_8a34ddd0e9e79242();
        }
        
        level.ztron.dev.var_2801faffccaf8955[ level.ztron.roundnumber ] = 0;
        
        while ( level utility::flag( "ztron_round_spawning" ) )
        {
            level.ztron.dev.var_2801faffccaf8955[ level.ztron.roundnumber ]++;
            wait 1;
        }
        
        if ( level.ztron.arena_rounds_left > 1 )
        {
            function_f6b211688053bd4f( level.ztron.currentarena, ztron_weather::function_8bfe19c4541053f2() );
            var_59e36a5ae1929a41 = ztron_bonus_room::function_7e1e5feb0aa2cd09();
            
            if ( isdefined( var_59e36a5ae1929a41 ) )
            {
                function_824e42a5208b9a13( var_59e36a5ae1929a41 );
            }
        }
        else if ( !level.ztron.var_371903e5801e0e08 )
        {
            var_fcbbc067e2b4df9e = [[ level.ztron.getnextarena ]]( level.ztron.currentarena );
            function_f6b211688053bd4f( var_fcbbc067e2b4df9e );
        }
        else
        {
            curarena = level.ztron.arenas[ level.ztron.currentarena ];
            branchinfo = level.ztron.var_b6efb062e0563051[ curarena.name ];
            var_6dd2dba3d1c32f94 = function_973956bb5a6e60f7( branchinfo.firsttargetname );
            var_6dd2dea3d1c3362d = function_973956bb5a6e60f7( branchinfo.secondtargetname );
            
            if ( isdefined( var_6dd2dba3d1c32f94 ) && isdefined( var_6dd2dea3d1c3362d ) )
            {
                function_7d4a2bf05d98a038( var_6dd2dba3d1c32f94.id, var_6dd2dea3d1c3362d.id );
            }
        }
        
        level notify( #"ztron_round_stopped_spawning" );
        
        if ( !level.ztron.blitzmode )
        {
            level.ztron.active_arena function_cd7b5b2d9403d4fe();
        }
        
        level.ztron.gatekeys = 15;
        
        while ( utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
        {
            waitframe();
        }
        
        utility::flag_set( "ztron_round_over" );
        level.ztron.roundendtime = gettime();
        
        if ( !level.ztron.blitzmode )
        {
            ztron_util::function_494e6b73ea596cc7( -1 );
        }
        
        level notify( #"round_over" );
        level callback::remove( "on_zombie_ai_killed", &on_ai_killed );
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                continue;
            }
            
            player notify( #"round_over" );
            
            if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
            {
                player ztron_player_utility::playerrespawnnow();
            }
            
            if ( isdefined( level.ztron.var_4064026979f81a0c ) )
            {
                self thread [[ level.ztron.var_4064026979f81a0c ]]( player );
                continue;
            }
            
            roundendaward( player );
        }
        
        waitframe();
        ztron_debug::debugmsg( "   ##@@@@ ROUND OVER  [" + level.ztron.roundnumber + "] @@@@##: " + level.ztron.active_arena.name );
        setomnvar( "ui_ztron_remaining_enemy_count", 0 );
        function_214a788a2800bb8f();
        function_214a788a2800bb8f();
        
        if ( level.playrs.size > 2 )
        {
            function_214a788a2800bb8f();
            function_214a788a2800bb8f();
        }
        
        if ( level.ztron.arena_rounds_left > 1 )
        {
            level function_4019c4a603cd949e( arenaid );
            
            if ( isdefined( level.ztron.var_3678ff7453f3c5cf ) )
            {
                level waittill( level.ztron.var_3678ff7453f3c5cf );
            }
            
            function_a869811b814279a6( ztron_main::function_d0ec00d4cc5debc7(), level.ztron.arena_rounds_left - 1 );
            
            if ( randomint( 100 ) < 30 )
            {
                level thread function_11172d3a2777785d( arenaid );
            }
            
            if ( !level.ztron.blitzmode )
            {
                ztron_ui::function_2a3f45a4f0ab93b6( level.ztron.game_laps > 0 ? 300 : 120 );
            }
            
            result = level utility::waittill_any_return_params_or_timeout( level.ztron.game_laps > 0 ? 300 : 120, "ztron_exit_taken" );
            
            if ( result[ "message" ] == "timeout" )
            {
                exit = level.ztron.active_arena.openexits[ randomint( level.ztron.active_arena.openexits.size ) ];
                exit notify( #"trigger", level.players[ 0 ] );
            }
            
            if ( !level.ztron.blitzmode )
            {
                ztron_ui::function_f6f4dd304ac8569b();
            }
            
            ztron_sound::ztron_playsound( "ztron_travel_doors_chosen" );
            level.ztron.active_arena.openexits = [];
            ztron_util::function_9ecee6f38c56d30f( 1 );
            nextlightstate = ztron_weather::inclightstate();
            removeallfxmarks();
            level notify( #"arena_round_leaving" );
            waitframe();
            ztron_player_utility::function_f0bf0ac112ebf51();
            ztron_weather::resetweather();
            
            if ( ztron_bonus_room::try_activate_bonus_room( result[ 0 ].openedby, nextlightstate ) )
            {
                level waittill( #"bonus_room_completed" );
                ztron_sound::function_ac1e49175da7897d( "arenaEvent", "arenaActivated", level.ztron.active_arena.name );
                ztron_weather::setlightstate( nextlightstate );
            }
            
            function_6303eb6c2cd32650();
            function_f2e9dd5fcbd74bd( !level.ztron.arenaCamFlip );
            ztron_util::function_d54d1c1fe00833d6();
            level thread ztron_item::function_25f69b2b896fd56();
        }
        
        level.ztron.arena_rounds_left--;
        level.ztron.var_e676e7b8c3d951c1 = [];
        
        if ( level.ztron.arena_rounds_left > 0 )
        {
            ztron_main::function_2da19957201c6090( level.ztron.roundnumber + 1 );
            ztron_enemy::function_be8fbd1178946a9( level.ztron.roundnumber );
        }
    }
    
    if ( isdefined( level.ztron.active_arena.extra_round ) )
    {
        thread [[ level.ztron.active_arena.extra_round ]]();
        level waittill( #"extra_round_over" );
        
        if ( isdefined( level.ztron.active_arena.var_99a3ec7b171ae8b1 ) )
        {
            [[ level.ztron.active_arena.var_99a3ec7b171ae8b1 ]]( arenaid );
        }
    }
    
    ztron_debug::debugmsg( "   ##@@@@ ARENA OVER @@@@##: " + level.ztron.active_arena.name );
    level notify( #"arena_over" );
    level function_f6b0233f60da3e6e();
    teleporterspawning = 1;
    var_38244ce5a43b9f39 = [[ level.ztron.var_c68c8726e15520d9 ]]( arenaid );
    
    if ( isdefined( var_38244ce5a43b9f39 ) )
    {
        level thread [[ var_38244ce5a43b9f39 ]]( arenaid );
        teleporterspawning = 0;
    }
    else
    {
        level thread openteleporter( arenaid );
    }
    
    level thread function_9dab0d1667a2eadc( arenaid, teleporterspawning );
    waitframe();
    
    if ( !level.ztron.bossround && !level.ztron.var_95d8c7a469393957 )
    {
        function_5c7f53e41e21ea79( ztron_main::function_d0ec00d4cc5debc7() );
    }
    
    if ( isdefined( level.ztron.var_3678ff7453f3c5cf ) )
    {
        level waittill( level.ztron.var_3678ff7453f3c5cf );
    }
    
    if ( !level.ztron.bossround && level.ztron.var_95d8c7a469393957 )
    {
        function_5c7f53e41e21ea79( ztron_main::function_d0ec00d4cc5debc7() );
    }
    
    assert( !isdefined( level.ztron.slayer.var_41aef428e6e941da ), "<dev string:x280>" );
    
    if ( !level.ztron.blitzmode )
    {
        ztron_ui::function_2a3f45a4f0ab93b6( isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300 );
    }
    else
    {
        level utility::waittill_any_timeout( 10, "teleporter_spawned" );
    }
    
    if ( level.ztron.blitzmode )
    {
        deadline = gettime() + int( ( isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300 ) * 1000 );
        
        for ( msg = undefined; msg != "ztron_teleporter_taken" ; msg = level utility::waittill_any_timeout( waitslice, "ztron_teleporter_taken" ) )
        {
            if ( level utility::flag( "ztron_all_players_dead" ) )
            {
                msg = "ztron_all_players_dead";
                break;
            }
            
            remainingsec = ( deadline - gettime() ) / 1000;
            
            if ( remainingsec <= 0 )
            {
                msg = "timeout";
                break;
            }
            
            waitslice = remainingsec < 0.25 ? remainingsec : 0.25;
        }
    }
    else
    {
        msg = level utility::waittill_any_timeout( isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300, "ztron_teleporter_taken" );
    }
    
    if ( level.ztron.blitzmode )
    {
        setomnvar( "ui_ztron_blitz_escape_dur_s", 0 );
        ztron_ui::function_ed63f265289260bb();
        
        foreach ( player in level.players )
        {
            player ztron_ui::function_1efa96816bcbb6ae();
        }
        
        if ( msg == "ztron_all_players_dead" )
        {
            return;
        }
        
        ztron_util::function_9ecee6f38c56d30f( 1 );
    }
    
    if ( msg == "timeout" )
    {
        level notify( #"ztron_teleporter_taken" );
    }
    
    if ( !level.ztron.blitzmode )
    {
        ztron_ui::function_f6f4dd304ac8569b();
    }
    
    if ( isdefined( level.ztron.active_arena.var_7b32fe236a1111ab ) )
    {
        level thread [[ level.ztron.active_arena.var_7b32fe236a1111ab ]]();
    }
    
    level notify( #"waiting_on_arena_completed" );
    
    if ( isdefined( level.ztron.active_arena.var_7b32fe236a1111ab ) )
    {
        level waittill( #"hash_18198cb75d8aea2e" );
    }
    
    ztron_util::killallenemies( 1 );
    ztron_util::function_d54d1c1fe00833d6();
    timesec = int( utility::function_6f5d2e1f1ff70482( gettime() - level.ztron.roundStartTime ) );
    level.ztron.game_duration += timesec;
    level notify( #"advance_to_next_arena" );
    level.ztron.active_arena thread deactivatearena();
}

// Namespace ztron_arena
// Params 1
// Checksum 0xae813e8a, Offset: 0x570f
// Size: 0x13e
function function_6fc50167bb958c08( var_73a67fc30b0d2b8d = 0 )
{
    if ( var_73a67fc30b0d2b8d && !level utility::flag( "ztron_round_spawning" ) )
    {
        level notify( #"arena_completed" );
    }
    
    level utility::flag_clear( "ztron_round_spawning" );
    utility::flag_clear( "ztron_challenge_round_spawning" );
    activearena = level.ztron.active_arena;
    
    if ( activearena )
    {
        if ( activearena.intro.introstarted && !activearena.intro.introcompleted )
        {
            return;
        }
        
        hazardspots = activearena function_eb3bad474c41ae42( "enemy_spawner" );
        
        foreach ( var_4d080f710fb8349e in hazardspots )
        {
            var_4d080f710fb8349e notify( #"destroy_hazard" );
        }
        
        wait 0.1;
        ztron_util::killallenemies();
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xc2f74a95, Offset: 0x5855
// Size: 0x256
function function_9b2d66cd16a8a256()
{
    self notify( #"hash_b42ac6ab75284294" );
    self endon( #"hash_b42ac6ab75284294" );
    
    if ( !getdvarint( @"hash_b78b7af98765db36", 1 ) || level.ztron.roundnumber == 1 )
    {
        return;
    }
    
    if ( isdefined( level.ztron.var_cd3b78b45db638d8 ) )
    {
        hintai = ztron_enemy::function_72a544a5053399fb( level.ztron.var_cd3b78b45db638d8.name );
        
        if ( isdefined( hintai ) )
        {
            ztron_ui::function_50d443b158550ecd( hintai );
            level.ztron.var_cd3b78b45db638d8.hintshown = 1;
        }
    }
    
    if ( level.ztron.var_371903e5801e0e08 && !isdefined( level.ztron.var_cd3b78b45db638d8 ) )
    {
        foreach ( enemydef in level.ztron.var_6fdc39ee25e5365e )
        {
            if ( enemydef.hintshown == 0 )
            {
                hintai = ztron_enemy::function_72a544a5053399fb( enemydef.name );
                
                if ( isdefined( hintai ) )
                {
                    ztron_ui::function_50d443b158550ecd( hintai );
                    enemydef.hintshown = 1;
                }
            }
        }
    }
    
    if ( level.ztron.var_477ba2c6e6ba2820 )
    {
        if ( !level.ztron.var_ea55d63fdfb9014d )
        {
            ztron_ui::function_50d443b158550ecd( "zombie_difficulty_ai_count_increase" );
        }
    }
    else if ( !level.ztron.var_3767fef3d7e028ef )
    {
        ztron_ui::function_50d443b158550ecd( "zombie_difficulty_round_time_increase" );
    }
    
    if ( function_7cb125cd85afe887() )
    {
        ztron_ui::function_50d443b158550ecd( "zombie_difficulty_ai_speed_increase" );
        
        if ( level.ztron.var_f1569c16a29ffcbf < level.ztron.var_6802a5d0daf63432 )
        {
            ztron_ui::function_50d443b158550ecd( "ztron_difficulty_enemy_health_increase" );
        }
    }
    
    level thread ztron_ui::function_5c32841a472fb828();
}

// Namespace ztron_arena
// Params 1
// Checksum 0x5654b481, Offset: 0x5ab3
// Size: 0x235
function roundendaward( player )
{
    awardedxp = ztron_score::awardxp( player );
    
    /#
        ztron_debug::debugmsg( "<dev string:x2b5>", 1 );
        
        if ( !isdefined( player.ztron.var_2a330d09d47a2e6c ) )
        {
            player.ztron.var_2a330d09d47a2e6c = [];
        }
        
        player.ztron.var_2a330d09d47a2e6c[ level.ztron.roundnumber ] = awardedxp;
        
        if ( !isdefined( level.ztron.var_583f8d32fca61676 ) )
        {
            level.ztron.var_583f8d32fca61676 = [];
        }
        
        if ( !isdefined( level.ztron.var_583f8d32fca61676[ player.name ] ) )
        {
            level.ztron.var_583f8d32fca61676[ player.name ] = 0;
        }
        
        level.ztron.var_583f8d32fca61676[ player.name ] += awardedxp;
        ztron_debug::debugmsg( "<dev string:x2e8>" + level.ztron.var_583f8d32fca61676[ player.name ] + "<dev string:x2fa>", 1 );
        var_a9debbd8293d0e85 = int( ( gettime() - level.ztron.game_starttime ) / 1000 );
        ztron_debug::debugmsg( "<dev string:x2fc>" + var_a9debbd8293d0e85, 1 );
        xp_sec = level.ztron.var_583f8d32fca61676[ player.name ] / var_a9debbd8293d0e85;
        xp_sec = int( xp_sec * 10 ) / 10;
        ztron_debug::debugmsg( "<dev string:x31a>" + xp_sec, 1 );
        ztron_debug::debugmsg( "<dev string:x32b>" + int( xp_sec * 60 ) + "<dev string:x33d>", 1 );
        ztron_debug::debugmsg( "<dev string:x353>" + int( xp_sec * 60 * 60 ) + "<dev string:x368>", 1 );
    #/
}

// Namespace ztron_arena
// Params 0, eflags: 0x4
// Checksum 0xd25be2c9, Offset: 0x5cf0
// Size: 0x125
function private function_cd7b5b2d9403d4fe()
{
    zombies = level.ztron.zombies;
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.ztron.boss )
        {
            continue;
        }
        
        if ( !zombie.marked_for_death )
        {
            mintime = 30;
            maxtime = 50;
            zombie thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( mintime, maxtime ), undefined, "MOD_UNKNOWN", 0 );
        }
    }
    
    level.ztron.var_cd7b5b2d9403d4fe = 1;
    
    while ( !function_eb0732f92004a95c() )
    {
        waitframe();
    }
    
    level.ztron.var_cd7b5b2d9403d4fe = undefined;
}

// Namespace ztron_arena
// Params 0, eflags: 0x4
// Checksum 0x7dbbeeab, Offset: 0x5e1d
// Size: 0x3c
function private function_eb0732f92004a95c()
{
    allenemydead = ztron_util::function_cdd411b0cc1f9d80( 1 ).size == 0;
    
    if ( allenemydead )
    {
        if ( isdefined( self.var_2d9687bd0601271a ) )
        {
            return self [[ self.var_2d9687bd0601271a ]]();
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace ztron_arena
// Params 3
// Checksum 0xd0d15f73, Offset: 0x5e62
// Size: 0x167
function function_ec27c480ffdc3c4e( var_f845f668cc11904f = 0, fadeout = 1, var_fcbbc067e2b4df9e = [[ level.ztron.getnextarena ]]( level.ztron.currentarena ) )
{
    if ( level.ztron.var_fde426ce0f07d8fb != var_fcbbc067e2b4df9e )
    {
        function_db224292347b1b3d();
        function_f6b211688053bd4f( var_fcbbc067e2b4df9e );
    }
    
    setomnvar( "ui_ztron_arena_number", var_fcbbc067e2b4df9e );
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        thread ztron_ui::function_464c14312837a513();
    }
    
    if ( var_f845f668cc11904f )
    {
        if ( fadeout )
        {
            ztron_util::function_9ecee6f38c56d30f( 1 );
        }
        
        return;
    }
    
    ztron_ui::showoverworld();
    
    foreach ( player in level.players )
    {
        player ztron_util::fade_in( 1, 0, 0 );
    }
    
    wait 3;
    ztron_player_utility::function_f0bf0ac112ebf51();
    
    if ( fadeout )
    {
        ztron_util::function_9ecee6f38c56d30f( 1 );
    }
    
    ztron_ui::hideoverworld();
}

// Namespace ztron_arena
// Params 2
// Checksum 0x20311320, Offset: 0x5fd1
// Size: 0x12a
function function_f2e9dd5fcbd74bd( flip = 0, reset = 0 )
{
    if ( reset )
    {
        level.ztron.arenaCamFlip = 0;
    }
    else
    {
        level.ztron.arenaCamFlip = flip;
    }
    
    foreach ( player in level.players )
    {
        if ( !player ztron_player_utility::function_a120489ddd3aa5ce() )
        {
            continue;
        }
        
        if ( player ztron_player_utility::isplayerspectating() )
        {
            continue;
        }
        
        player ztron_camera::flipTopdownCamera( level.ztron.arenaCamFlip );
    }
    
    level notify( #"hash_e2f2f6d0f657e3a3", { #camflipped:level.ztron.arenaCamFlip } );
}

// Namespace ztron_arena
// Params 1
// Checksum 0x5b04e1f9, Offset: 0x6103
// Size: 0x108
function function_ef31efadee606b76( arenaid )
{
    level notify( #"arena_switching" );
    waitframe();
    
    if ( arenaid >= level.ztron.arenas.size )
    {
        arenaid = 0;
    }
    
    level.ztron.active_arena = level.ztron.arenas[ arenaid ];
    level.ztron.active_arena activatearena();
    level.ztron.active_arena.allowteleporter = 1;
    level.ztron.var_3678ff7453f3c5cf = undefined;
    function_f2e9dd5fcbd74bd( 0, 1 );
    level notify( #"arena_initialized" );
    ztron_debug::debugmsg( "###### NEW ARENA  [" + level.ztron.roundnumber + "] #####: " + level.ztron.active_arena.name );
    waitframe();
}

// Namespace ztron_arena
// Params 0
// Checksum 0xf436fd55, Offset: 0x6213
// Size: 0x397
function function_9139285068de6e5d()
{
    self notify( #"hash_cf3b7621e9da2310" );
    self endon( #"hash_cf3b7621e9da2310" );
    level endon( #"arena_deactivated", #"arena_completed" );
    
    if ( !isdefined( self.safevolumes ) || self.safevolumes.size == 0 )
    {
        return;
    }
    
    waitrate = getdvarint( @"hash_24ea3422c25b2c1d", 1 );
    
    /#
        waitrate = level.framedurationseconds;
    #/
    
    while ( true )
    {
        wait waitrate;
        
        /#
            if ( getdvarint( @"hash_c2b0bd1527a4da6c", 0 ) == 1 )
            {
                continue;
            }
        #/
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 4 )
        {
            continue;
        }
        
        if ( level utility::flag( "ztron_screen_faded" ) )
        {
            continue;
        }
        
        if ( level.ztron.active_arena.openexits.size )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( !player.ztron.initialized || player.sessionstate != "playing" )
            {
                continue;
            }
            
            /#
                if ( player isnoclip() )
                {
                    continue;
                }
                
                if ( player isufo() )
                {
                    continue;
                }
            #/
            
            var_fa19860cfaa56257 = 0;
            
            foreach ( safevolume in self.safevolumes )
            {
                if ( player istouching( safevolume ) )
                {
                    var_fa19860cfaa56257 = 1;
                    break;
                }
            }
            
            if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
            {
                continue;
            }
            
            if ( var_fa19860cfaa56257 )
            {
                player.var_b47462e38b032a5 = player.origin;
                continue;
            }
            
            /#
                ztron_debug::debugmsg( "<dev string:x37c>" + player.ztron.color + "<dev string:x387>" + self.name + "<dev string:x3a5>" + player.origin );
                durations = 300;
                level thread ztron_debug::drawsphere( player.origin, 32, durations, ( 1, 0, 0 ), player.name + "<dev string:x3b6>" + player.origin );
                
                if ( player.var_b47462e38b032a5 )
                {
                    level thread ztron_debug::drawsphere( player.var_b47462e38b032a5, 32, durations, ( 0, 1, 0 ), player.name + "<dev string:x3c2>" + player.var_b47462e38b032a5 );
                    level thread ztron_debug::drawline( player.var_b47462e38b032a5, player.origin, durations, ( 1, 0, 0 ) );
                }
            #/
            
            safespot = function_8c2aa5e7037af31c( player.origin );
            level thread ztron_util::warpplayer( player, safespot, 0, 0 );
        }
    }
}

// Namespace ztron_arena
// Params 3
// Checksum 0x50437992, Offset: 0x65b2
// Size: 0x8a
function function_37c3ad87b4c84a3f( name, var_5f3338be9e3baac8 = getdvarint( @"hash_a9401d52263a0d85", 46 ), playerscale = getdvarint( @"hash_a9ab1ef553c74654", 7 ) )
{
    arena = function_973956bb5a6e60f7( name );
    assert( isdefined( arena ), "<dev string:x3d4>" );
    arena.var_84e9c31fbaa384af = var_5f3338be9e3baac8;
    arena.var_ae48c1fd2b6e2299 = playerscale;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xce3dc257, Offset: 0x6644
// Size: 0x121
function activatearena()
{
    ztron_weather::function_118f675e6049a8e0();
    
    foreach ( tweakzone in self.var_913d403c0a0102ea )
    {
        tweakzone thread function_78148da55f00880e();
    }
    
    thread function_9139285068de6e5d();
    thread ztron_tutorial::function_4c5b1b7fd5fb2b4e();
    function_15d63b44db72a92();
    
    if ( isdefined( self.activationfunc ) )
    {
        self thread [[ self.activationfunc ]]();
    }
    
    level thread ztron_player::function_e35fe57c35e0fad4();
    
    if ( isdefined( self.var_bd9df22b9216b2af ) )
    {
        setdvar( @"hash_535b4826432520f3", self.var_bd9df22b9216b2af getentitynumber() );
    }
    else
    {
        setdvar( @"hash_535b4826432520f3", -1 );
    }
    
    level.ztron.var_ab714871c4679ba8 = undefined;
    ztron_sound::function_ac1e49175da7897d( "arenaEvent", "arenaActivated", self.name );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x432be29b, Offset: 0x676d
// Size: 0x1a5
function deactivatearena()
{
    profilestart();
    ztron_weather::function_118f675e6049a8e0();
    level notify( #"arena_completed" );
    
    foreach ( tweakzone in self.var_913d403c0a0102ea )
    {
        if ( isdefined( tweakzone ) )
        {
            tweakzone notify( #"deactivate" );
        }
    }
    
    foreach ( lootpoint in self.var_9df48f55f947471f )
    {
        lootpoint.itemused = undefined;
    }
    
    if ( isdefined( self.deactivationfunc ) )
    {
        self thread [[ self.deactivationfunc ]]();
    }
    
    level notify( #"arena_deactivated" );
    level.ztron.active_arena = undefined;
    ztron_sound::function_ac1e49175da7897d( "arenaEvent", "arenaDeactivated", self.name );
    level.ztron.var_d0972e445894306d = undefined;
    
    if ( level.ztron.blitzmode )
    {
        level.ztron.var_d0972e445894306d = 30;
    }
    
    profilestop();
}

// Namespace ztron_arena
// Params 0
// Checksum 0xfe9b7439, Offset: 0x691a
// Size: 0x1bf
function function_78148da55f00880e()
{
    self endon( #"deactivate" );
    self triggerenable();
    thread function_4d2fb95fba5b301a();
    type = self.script_noteworthy ?? "setCameraDown";
    var_dea69c2e98a0372f = 95;
    var_6d8ea0ef2db9562f = 0;
    
    if ( isdefined( self.script_label ) )
    {
        toks = strtok( self.script_label, ";" );
        assert( toks.size >= 1 );
        var_6d8ea0ef2db9562f = int( toks[ 0 ] );
        
        if ( toks.size >= 2 )
        {
            var_dea69c2e98a0372f = int( toks[ 1 ] );
        }
    }
    
    penetrationaxis = 0;
    testaxis = 0;
    
    if ( isdefined( self.script_parameters ) )
    {
        toks = strtok( self.script_parameters, ";" );
        assert( toks.size >= 2 );
        penetrationaxis = int( toks[ 0 ] );
        testaxis = int( toks[ 1 ] );
    }
    
    self.angles = angleclamp180( self.angles );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() )
        {
            ent = ent.owner;
        }
        
        if ( !isplayer( ent ) || isdefined( ent.var_7f3479cb261e87ed ) )
        {
            continue;
        }
        
        player = ent;
        
        if ( !self function_b0b72d20769d0233() )
        {
            continue;
        }
        
        checkmask = player function_9c6b868cb9f8a373() ? 2 : 1;
        
        if ( ( var_6d8ea0ef2db9562f & checkmask ) == 0 )
        {
            continue;
        }
        
        player function_bcc570093484c238( self, type );
        player thread cameratweak( type, self, var_dea69c2e98a0372f, var_6d8ea0ef2db9562f, penetrationaxis, testaxis );
    }
}

// Namespace ztron_arena
// Params 6
// Checksum 0x3f45ee1d, Offset: 0x6ae1
// Size: 0x1ed
function cameratweak( type, trigger, var_dea69c2e98a0372f, var_6d8ea0ef2db9562f, penetrationaxis = 0, testaxis = 0 )
{
    self notify( #"hash_86234132c2e22304" );
    self endon( #"hash_86234132c2e22304" );
    self endon( #"disconnect", #"hash_cdf25110ae7b21d7" );
    penetrationaxis = int( penetrationaxis );
    textaxis = int( testaxis );
    maxamount = 63;
    maxamount = int( maxamount * ( var_dea69c2e98a0372f - 75 ) / 20 );
    triggerbounds = trigger getboundshalfsize();
    depthmax = triggerbounds[ penetrationaxis ] * 2;
    selfbounds = self getboundshalfsize();
    var_c208040473920e3e = selfbounds[ penetrationaxis ];
    
    while ( true )
    {
        if ( !isdefined( trigger ) || !self istouching( trigger ) || !trigger function_b0b72d20769d0233() )
        {
            break;
        }
        
        checkmask = self function_9c6b868cb9f8a373() ? 2 : 1;
        
        if ( ( var_6d8ea0ef2db9562f & checkmask ) == 0 )
        {
            break;
        }
        
        localpoint = self.origin - trigger.origin;
        contact_point_offset = rotatevector( localpoint, trigger.angles * -1 );
        var_e0adf6856bb33850 = contact_point_offset + trigger.origin;
        dist2 = abs( trigger.origin[ testaxis ] - var_e0adf6856bb33850[ testaxis ] ) - var_c208040473920e3e;
        var_721ab155b603ff6c = 1 - dist2 / depthmax;
        var_7ebe905a91dc9926 = int( mapfloat( 0, 1, 0, maxamount, var_721ab155b603ff6c ) );
        function_311163cc3ff9a24f( type, var_7ebe905a91dc9926 );
        waitframe();
    }
    
    function_793958a7b608eb74();
}

// Namespace ztron_arena
// Params 2
// Checksum 0x2c275ef8, Offset: 0x6cd6
// Size: 0x2b
function function_bcc570093484c238( trigger, type )
{
    self.var_7f3479cb261e87ed = trigger;
    self.var_e3300edb0f032a65 = type;
}

// Namespace ztron_arena
// Params 1
// Checksum 0x7ff9f821, Offset: 0x6d09
// Size: 0x66
function function_793958a7b608eb74( forceend = 0 )
{
    if ( !self.var_7f3479cb261e87ed || !self.var_e3300edb0f032a65 )
    {
        return;
    }
    
    function_311163cc3ff9a24f( self.var_e3300edb0f032a65, 0 );
    self.var_7f3479cb261e87ed = undefined;
    self.var_e3300edb0f032a65 = undefined;
    
    if ( forceend )
    {
        self notify( #"hash_cdf25110ae7b21d7" );
    }
}

// Namespace ztron_arena
// Params 2, eflags: 0x4
// Checksum 0x5c0aec1b, Offset: 0x6d77
// Size: 0x5d
function private function_311163cc3ff9a24f( type, value )
{
    switch ( type )
    {
        case #"hash_b62a4e736ac230f0":
            ztron_camera::setCameraDown( value );
            break;
        default:
            assert( 0, "<dev string:x3f0>" + type + "<dev string:x405>" );
            break;
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xa5eaf7e5, Offset: 0x6ddc
// Size: 0x15
function function_4d2fb95fba5b301a()
{
    self waittill( #"deactivate" );
    self triggerdisable();
}

// Namespace ztron_arena
// Params 0
// Checksum 0x9dd1f9ff, Offset: 0x6df9
// Size: 0xb7
function function_c4ac9d2a474845ee()
{
    spot = level.ztron.active_arena.lootspots[ randomint( level.ztron.active_arena.lootspots.size ) ];
    
    if ( spot == level.ztron.var_ab714871c4679ba8 )
    {
        newarray = arrayremove( level.ztron.active_arena.lootspots, spot );
        spot = newarray[ randomint( newarray.size ) ];
    }
    
    level.ztron.var_ab714871c4679ba8 = spot;
    return spot;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xbdecb9fc, Offset: 0x6eb9
// Size: 0x36
function function_e5b1d0f7344e37c3()
{
    profilestart();
    var_645268b3cf610f86 = getdvarint( @"scr_ztron_armor_plate_roll", 30 );
    
    if ( randomint( var_645268b3cf610f86 ) == 0 )
    {
        ztron_item::function_6dc56ae0eba06de1( "ztron_armor_plate" );
    }
    
    profilestop();
}

// Namespace ztron_arena
// Params 0
// Checksum 0xb9c958c1, Offset: 0x6ef7
// Size: 0x490
function function_9ee2b02a6c783a7e()
{
    self notify( #"hash_c0552584c5190dfd" );
    self endon( #"hash_c0552584c5190dfd" );
    level endon( #"arena_completed" );
    level endon( #"ztron_game_is_over" );
    level endon( #"arena_deactivated" );
    level endon( #"hash_1cf1c429bb1c9a07" );
    wait 8;
    lastitemtype = "";
    level.ztron.var_841c9de1c43b2971 = 0;
    var_f9e32bd0f85aee8c = [];
    
    foreach ( item in level.ztron.itemdef.itemdata )
    {
        if ( item.category != "" )
        {
            continue;
        }
        
        if ( item.var_8b8dc2f3047eeb5c <= level.ztron.roundnumber )
        {
            var_f9e32bd0f85aee8c[ var_f9e32bd0f85aee8c.size ] = item;
        }
    }
    
    function_e5b1d0f7344e37c3();
    level.ztron.var_d32751306128fdeb = var_f9e32bd0f85aee8c;
    
    while ( true )
    {
        wait 0.25;
        
        if ( level utility::flag( "ztron_round_paused" ) )
        {
            wait randomintrange( 1, 4 );
            continue;
        }
        
        if ( level.ztron.var_316dc0679575bf4d > 15 )
        {
            wait 1;
            continue;
        }
        
        if ( gettime() > level.ztron.var_841c9de1c43b2971 )
        {
            if ( isdefined( level.ztron.special_item_spawn ) && level.ztron.special_item_spawn.size )
            {
                iteminfo = level.ztron.special_item_spawn[ 0 ];
                level.ztron.special_item_spawn[ 0 ] = undefined;
                function_cdc669dbc8ea2101( level.ztron.special_item_spawn );
                item = ztron_item::function_44d7d2feb29ee403( iteminfo.itemdefname );
                forced = iteminfo.forced;
                
                if ( iteminfo.itemdefname == "ztron_arcade" && level.ztron.slayer.arcadeitem > 0 )
                {
                    level.ztron.slayer.arcadeitem--;
                }
            }
            else
            {
                item = var_f9e32bd0f85aee8c[ randomint( var_f9e32bd0f85aee8c.size ) ];
                forced = 0;
            }
            
            type = ztron_item::function_8a02cd53a42c0649( item.itemspawnentry );
            
            if ( !forced )
            {
                if ( type == lastitemtype )
                {
                    lastitemtype = "";
                    continue;
                }
            }
            
            if ( isdefined( level.ztron.var_1aafcf52beca1b11 ) && !forced )
            {
                if ( gettime() < level.ztron.var_edc387a66e6f8d8c )
                {
                    item = level.ztron.var_1aafcf52beca1b11;
                    forced = 1;
                }
                else
                {
                    level.ztron.var_1aafcf52beca1b11 = undefined;
                    level.ztron.var_edc387a66e6f8d8c = undefined;
                }
            }
            
            lastitemtype = type;
            qty = function_7a4b3bf63110ece9( type );
            
            while ( qty )
            {
                qty--;
                spot = function_c4ac9d2a474845ee();
                
                if ( !forced && !ztron_item::canspawnitem( item.itemspawnentry, spot.origin, type ) )
                {
                    continue;
                }
                
                radius = 70;
                spawnoptions = ztron_item::function_41854e96b8bf4a06( spot.origin + ( 0, 0, 50 ) );
                ztron_item::requestspawnitem( item.itemspawnentry, spot.origin, radius, spawnoptions );
            }
            
            minwait = level.ztron.var_293c4b94e80c822a * 11;
            maxwait = level.ztron.var_293c4b94e80c822a * 21;
            level.ztron.var_841c9de1c43b2971 = gettime() + int( randomfloatrange( minwait, maxwait ) * 1000 );
        }
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0x4a96b39c, Offset: 0x738f
// Size: 0x3b1
function function_7a4b3bf63110ece9( type )
{
    qty = 1;
    
    switch ( type )
    {
        case #"firstperson":
            qty = level.players.size;
            break;
        case #"clock":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"air_horn":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"boost":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"chicken":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"barrel":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"boots":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"boxing_glove":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"monkey_bomb":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"sentry_turret":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? 2 : 1;
            break;
        case #"sawblade":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? level.players.size : 1;
            break;
        case #"tesla_ball":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? level.players.size : 1;
            break;
        case #"tank":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? level.players.size : 1;
            break;
        case #"helicopter":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? level.players.size : 1;
            break;
        case #"mutant_injection":
            qty = level.ztron.var_371903e5801e0e08 & level.players.size > 1 ? level.players.size : 1;
            break;
    }
    
    return qty;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x4ca08f0a, Offset: 0x7749
// Size: 0x25a
function function_c9560777fa9a0b3()
{
    self notify( #"hash_f750a28a629b7bbc" );
    self endon( #"hash_f750a28a629b7bbc" );
    level endon( #"arena_completed" );
    level endon( #"ztron_game_is_over" );
    level endon( #"arena_deactivated" );
    level endon( #"hash_1cf1c429bb1c9a07" );
    wait 5;
    level.ztron.var_ee6c88337e58c72e = 0;
    weaponspots = level.ztron.active_arena.lootspots;
    var_6f9d07d4971f482c = level.ztron.var_371903e5801e0e08 ? 70 : 95;
    var_f1d90d74befb7e5b = 30;
    var_81d019ff6867f601 = 40;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        var_f1d90d74befb7e5b *= 0.7;
        var_81d019ff6867f601 *= 0.7;
    }
    
    while ( true )
    {
        wait 0.25;
        
        if ( level utility::flag( "ztron_round_paused" ) )
        {
            wait randomintrange( 1, 4 );
            continue;
        }
        
        if ( level.ztron.var_316dc0679575bf4d > 15 )
        {
            wait 1;
            continue;
        }
        
        if ( gettime() > level.ztron.var_ee6c88337e58c72e )
        {
            qty = 1;
            
            if ( randomint( 100 ) > var_6f9d07d4971f482c )
            {
                qty = 3;
            }
            
            itemname = ztron_item::function_f3613b119900d057( #"weapon" );
            
            if ( isdefined( itemname ) )
            {
                while ( qty )
                {
                    spot = function_c4ac9d2a474845ee();
                    pos = spot.origin + ( 0, 0, 30 );
                    spawnoptions = ztron_item::function_41854e96b8bf4a06( pos );
                    ztron_item::clusteritemspawn( itemname, pos, 1, 52, spawnoptions );
                    qty--;
                }
                
                minwait = level.ztron.var_66eddb4a56806387 * var_f1d90d74befb7e5b;
                maxwait = level.ztron.var_66eddb4a56806387 * var_81d019ff6867f601;
                level.ztron.var_ee6c88337e58c72e = gettime() + int( randomfloatrange( minwait, maxwait ) * 1000 );
            }
        }
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xe5ac9531, Offset: 0x79ab
// Size: 0x14a
function function_731f8db476a347a0()
{
    self notify( #"hash_bd9a85471f68f512" );
    self endon( #"hash_bd9a85471f68f512" );
    level endon( #"ztron_game_is_over" );
    level endon( #"hash_1cf1c429bb1c9a07" );
    wait randomintrange( 1, 4 );
    level.ztron.var_ae907b7861f41f63 = 0;
    
    while ( true )
    {
        wait 0.25;
        
        if ( level utility::flag( "ztron_round_paused" ) )
        {
            wait randomintrange( 1, 4 );
            continue;
        }
        
        if ( level.ztron.var_316dc0679575bf4d > 15 )
        {
            wait 1;
            continue;
        }
        
        if ( utility::flag( "ztron_round_over" ) || !isdefined( level.ztron.active_arena ) )
        {
            continue;
        }
        
        if ( gettime() > level.ztron.var_ae907b7861f41f63 )
        {
            function_214a788a2800bb8f();
            minwait = level.ztron.var_992f29dbad27ad98 * 10;
            maxwait = level.ztron.var_992f29dbad27ad98 * 20;
            level.ztron.var_ae907b7861f41f63 = gettime() + randomfloatrange( minwait, maxwait ) * 1000;
        }
    }
}

// Namespace ztron_arena
// Params 2
// Checksum 0x448b922e, Offset: 0x7afd
// Size: 0x5f
function function_a50192ac8a81b0c( min = 1, max = 5 )
{
    rand = randomfloat( 1 );
    bias = 3;
    biased = pow( rand, bias );
    return min + biased * ( max - 1 );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x1c93d4a, Offset: 0x7b65
// Size: 0x12d
function function_214a788a2800bb8f()
{
    spot = level.ztron.active_arena.lootspots[ randomint( level.ztron.active_arena.lootspots.size ) ];
    pos = spot.origin + ( 0, 0, 30 );
    spawnoptions = ztron_item::function_41854e96b8bf4a06( pos );
    qty = randomintrange( 4, 10 );
    ztron_item::function_e062f5021d53874e( pos, qty, 100, spawnoptions );
    gemspawn = randomint( 100 );
    
    if ( gemspawn < 5 )
    {
        qty = 1;
        
        if ( gemspawn == 0 )
        {
        }
        
        for ( qty = 3; qty ; qty-- )
        {
            params = spawnstruct();
            
            if ( !isdefined( params.launchforce ) )
            {
                params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 100 );
            }
            
            params.scale = function_a50192ac8a81b0c();
            ztron_item::function_d0a061baefd87906( pos, 1 );
        }
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x8f2e31c8, Offset: 0x7c9a
// Size: 0x32
function function_ece71b37bd114ed()
{
    level thread ztron_item::function_25f69b2b896fd56();
    level thread function_86af0d6360200dd6();
    level thread function_9ee2b02a6c783a7e();
    level thread function_c9560777fa9a0b3();
    level thread function_731f8db476a347a0();
    level thread function_d3beb9c94441e455();
}

// Namespace ztron_arena
// Params 0
// Checksum 0xd9a03d00, Offset: 0x7cd4
// Size: 0x6c
function function_86af0d6360200dd6()
{
    self notify( #"hash_9dbfed497ba75e86" );
    self endon( #"hash_9dbfed497ba75e86" );
    level endon( #"arena_completed" );
    level endon( #"ztron_game_is_over" );
    level endon( #"arena_deactivated" );
    level waittill( #"ztron_round_spawning" );
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        wait 1;
    }
    
    level notify( #"hash_1cf1c429bb1c9a07" );
}

// Namespace ztron_arena
// Params 2
// Checksum 0xe592a11c, Offset: 0x7d48
// Size: 0x357
function arenaspawnai( spot, forcebasic )
{
    if ( isdefined( level.ztron.var_cd6baaff724ae07d ) )
    {
        spot = [[ level.ztron.var_cd6baaff724ae07d ]]();
    }
    
    if ( isdefined( level.ztron.var_1cf13cded1683a4e ) )
    {
        enemydef = [[ level.ztron.var_1cf13cded1683a4e ]]();
        var_5f818d1c1f901403 = 1;
        forcebasic = 1;
    }
    
    if ( !isdefined( enemydef ) )
    {
        if ( level.ztron.var_805af7b14c9ae458.size )
        {
            clusterrequest = level.ztron.var_805af7b14c9ae458[ 0 ];
            enemydef = clusterrequest.enemydef;
            var_5f818d1c1f901403 = 1;
            clusterrequest.spawns_requested--;
            
            if ( clusterrequest.spawns_requested <= 0 )
            {
                level.ztron.var_805af7b14c9ae458 = arrayremove( level.ztron.var_805af7b14c9ae458, clusterrequest );
            }
        }
    }
    
    if ( !isdefined( enemydef ) )
    {
        if ( level.ztron.var_5d66e2173c3de46f )
        {
            enemydef = level.ztron.basic_zombie_def;
        }
        else
        {
            enemydef = level.ztron.var_6fdc39ee25e5365e[ randomint( level.ztron.var_6fdc39ee25e5365e.size ) ];
        }
        
        var_5f818d1c1f901403 = 0;
        var_70af85ef461d44f0 = 1;
    }
    
    enemy = function_b21056d585c710d( level.players, spot.origin );
    ai = ztron_enemy::function_77e1bf43b991b4a( enemydef, 1, spot.origin, 0, undefined, enemy, undefined, level.ztron.active_arena, undefined, undefined, enemydef.var_e95772ef2aa376a0, var_5f818d1c1f901403, forcebasic );
    
    if ( isdefined( ai ) )
    {
        if ( var_70af85ef461d44f0 && !ai.ztron.var_ae555ddb6e30a0b0 && ai.var_71c2b26838e90f44 == enemydef )
        {
            requested = 0;
            
            if ( isdefined( enemydef.grpmin ) )
            {
                requested = enemydef.grpmin;
                
                if ( isdefined( enemydef.grpmax ) )
                {
                    requested = randomintrange( enemydef.grpmin, enemydef.grpmax + 1 );
                }
            }
            else if ( isdefined( enemydef.grpmax ) )
            {
                requested = randomintrange( 1, enemydef.grpmax );
            }
            
            if ( requested > 0 )
            {
                clusterrequest = spawnstruct();
                clusterrequest.spawns_requested = requested;
                clusterrequest.enemydef = enemydef;
                level.ztron.var_805af7b14c9ae458[ level.ztron.var_805af7b14c9ae458.size ] = clusterrequest;
            }
        }
        
        if ( isdefined( level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ] ) )
        {
            level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ]++;
        }
    }
    
    return ai;
}

// Namespace ztron_arena
// Params 2
// Checksum 0x2f053853, Offset: 0x80a8
// Size: 0x231
function function_9dab0d1667a2eadc( arenaid, waitforteleporter = 1 )
{
    self notify( #"hash_1e84d51e35d73faa" );
    self endon( #"hash_1e84d51e35d73faa" );
    level endon( #"arena_deactivated" );
    
    if ( !level.ztron.gobblegumsenabled )
    {
        return;
    }
    
    if ( level.ztron.no_bgb_machine )
    {
        return;
    }
    
    arena = level.ztron.arenas[ arenaid ];
    center = arena.center;
    
    if ( isdefined( arena.bgb_machines ) && arena.bgb_machines.size > 0 )
    {
        return;
    }
    
    if ( waitforteleporter )
    {
        level utility::waittill_any( "teleporter_spawned" );
        center = function_688e222d8cf08155( arena );
    }
    
    arena.bgb_machines = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( i < arena.bgbspots.size )
        {
            spot = arena.bgbspots[ i ];
            origin = spot.origin;
            angles = spot.angles;
        }
        else
        {
            spot = ztron_util::function_b1b04d15b778298b( arena.lootspots, center.origin );
            origin = spot.origin;
            direction = arena.center.origin - origin;
            angles = ( 0, vectortoyaw( vectornormalize( direction ) ), 0 );
        }
        
        bgb_machine = ztron_bgb_machine::spawn_bgb_machine( origin, angles );
        playfx( utility::getfx( "ztron_radial_purple_128" ), origin + ( 0, 0, 40 ) );
        playfx( utility::getfx( "lightning_strike" ), origin );
        arena.bgb_machines[ arena.bgb_machines.size ] = bgb_machine;
    }
    
    level thread function_3a67d4c5a56efdbd( arena );
}

// Namespace ztron_arena
// Params 1
// Checksum 0x92ba2530, Offset: 0x82e1
// Size: 0xd0
function function_3a67d4c5a56efdbd( arena )
{
    self notify( #"hash_c9e4afc0212fbe5b" );
    self endon( #"hash_c9e4afc0212fbe5b" );
    level endon( #"ztron_game_is_over" );
    level utility::waittill_any( "arena_deactivated", "kill_bgb_machine" );
    
    foreach ( bgb_machine in arena.bgb_machines )
    {
        if ( isdefined( bgb_machine ) )
        {
            bgb_machine ztron_bgb_machine::function_a6356b4f4c66e255();
        }
    }
    
    arena.bgb_machines = [];
}

// Namespace ztron_arena
// Params 2
// Checksum 0xfd7d63ce, Offset: 0x83b9
// Size: 0xd3
function function_db224292347b1b3d( setdefault = 0, lightstate = 0 )
{
    level.ztron.var_fde426ce0f07d8fb = undefined;
    
    foreach ( player in level.players )
    {
        player thread ztron_player_utility::function_af4808ad87d6d3a();
    }
    
    if ( setdefault )
    {
        level thread function_f6b211688053bd4f( level.ztron.currentarena, lightstate );
    }
}

// Namespace ztron_arena
// Params 3
// Checksum 0x96645237, Offset: 0x8494
// Size: 0x130
function function_ce4ea3ff56399ff1( hintpos, which = 0, lightstate = 0 )
{
    if ( which == 0 )
    {
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_fa760210c6b56964( hintpos, undefined, lightstate );
        }
        
        return;
    }
    
    if ( which == 1 )
    {
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_53a479766e307885( hintpos, undefined, lightstate );
        }
    }
}

// Namespace ztron_arena
// Params 2
// Checksum 0xdd4fc280, Offset: 0x85cc
// Size: 0x93
function function_f6b211688053bd4f( var_3b0d28d281aeaa21, lightstate = 0 )
{
    assert( isdefined( var_3b0d28d281aeaa21 ) );
    arenanext = level.ztron.arenas[ var_3b0d28d281aeaa21 ];
    centernext = function_688e222d8cf08155( arenanext );
    hintpos = centernext.origin;
    level.ztron.var_fde426ce0f07d8fb = var_3b0d28d281aeaa21;
    function_ce4ea3ff56399ff1( hintpos, 0, lightstate );
}

// Namespace ztron_arena
// Params 2
// Checksum 0xe9f749e8, Offset: 0x8667
// Size: 0x63
function function_824e42a5208b9a13( room, lightstate = 0 )
{
    assert( isdefined( room ) );
    centernext = room.playersstarts[ 0 ];
    hintpos = centernext.origin;
    function_ce4ea3ff56399ff1( hintpos, 1, lightstate );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x6b2a167d, Offset: 0x86d2
// Size: 0x7b
function function_6303eb6c2cd32650()
{
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_1a460fd0c0d7c699();
    }
}

// Namespace ztron_arena
// Params 3
// Checksum 0x14c7d600, Offset: 0x8755
// Size: 0xe3
function function_7d4a2bf05d98a038( var_614d83649d3d11d3, var_62a061a765fa15c0, lightstate = 0 )
{
    assert( isdefined( var_614d83649d3d11d3 ) );
    assert( isdefined( var_62a061a765fa15c0 ) );
    arenanext = level.ztron.arenas[ var_614d83649d3d11d3 ];
    centernext = function_688e222d8cf08155( arenanext );
    hintpos = centernext.origin;
    level.ztron.var_fde426ce0f07d8fb = var_614d83649d3d11d3;
    function_ce4ea3ff56399ff1( hintpos, 0, lightstate );
    arenanext = level.ztron.arenas[ var_62a061a765fa15c0 ];
    centernext = function_688e222d8cf08155( arenanext );
    hintpos = centernext.origin;
    function_ce4ea3ff56399ff1( hintpos, 1, lightstate );
}

// Namespace ztron_arena
// Params 6, eflags: 0x40 variadic
// Checksum 0x9ad46a56, Offset: 0x8840
// Size: 0x1d1
function function_3f42f859ddaaacdb( hintpos, which = 0, duration = ( level.ztron.game_laps > 0 ? 300 : 120 ) + 1, lightstate = 0, ... )
{
    assert( isdefined( vararg ) && vararg.size > 0, "<dev string:x414>" );
    level endon( #"killStreamerWaitOnNotify", #"ztron_game_is_over" );
    level notify( "killStreamerWaitOnNotify" + which );
    level endon( "killStreamerWaitOnNotify" + which );
    level utility::waittill_any_in_array_or_timeout( vararg, duration );
    level notify( #"hash_42b7a9c1673c310b" );
    waittillframeend();
    
    if ( which == 0 )
    {
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_fa760210c6b56964( hintpos, duration, lightstate );
        }
        
        return;
    }
    
    if ( which == 1 )
    {
        foreach ( player in level.players )
        {
            player thread ztron_player_utility::function_53a479766e307885( hintpos, duration, lightstate );
        }
    }
}

// Namespace ztron_arena
// Params 5, eflags: 0x48 variadic
// Checksum 0xa0fc5152, Offset: 0x8a19
// Size: 0xb2
function function_8ece8896a459622e( loaddefault = 0, timeout = 10, lightstate = 3, ... )
{
    self notify( #"hash_7ef2eb5ad94ded89" );
    self endon( #"hash_7ef2eb5ad94ded89" );
    assert( isdefined( vararg ) && vararg.size > 0, "<dev string:x414>" );
    level endon( #"hash_42b7a9c1673c310b", #"ztron_game_is_over" );
    level utility::waittill_any_in_array_or_timeout( vararg, timeout );
    level notify( #"killStreamerWaitOnNotify" );
    waittillframeend();
    function_db224292347b1b3d( loaddefault, lightstate );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xd6d77a5a, Offset: 0x8ad3
// Size: 0x72
function function_688e222d8cf08155( arena )
{
    center = arena.center;
    
    if ( isdefined( arena.center.target ) )
    {
        var_944d5742f6e058c = utility::getstruct( arena.center.target, "targetname" );
        
        if ( isdefined( var_944d5742f6e058c ) )
        {
            center = var_944d5742f6e058c;
        }
    }
    
    return center;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x1a41fd9f, Offset: 0x8b4e
// Size: 0xf
function function_f6b0233f60da3e6e()
{
    level notify( #"teleporter_being_opened" );
    waitframe();
}

// Namespace ztron_arena
// Params 1
// Checksum 0x7d760336, Offset: 0x8b65
// Size: 0x2bd
function openteleporter( arenaid )
{
    level endon( #"ztron_game_is_over", #"kill_teleporter" );
    level notify( #"hash_824e1ffce3b44832" );
    waitframe();
    
    while ( level utility::flag( "arena_hold_teleporter" ) )
    {
        waitframe();
    }
    
    arena = level.ztron.arenas[ arenaid ];
    center = function_688e222d8cf08155( arena );
    var_fcbbc067e2b4df9e = [[ level.ztron.getnextarena ]]( level.ztron.currentarena );
    function_f6b211688053bd4f( var_fcbbc067e2b4df9e );
    
    if ( isdefined( center ) )
    {
        teleportermodel = utility::spawn_model( "sat_zm_ztron_props_teleporter", center.origin - ( 0, 0, 128 ), center.angles );
        teleportermodel moveto( center.origin, 3 );
        teleportermodel waittill( #"movedone" );
        playfx( utility::getfx( "ztron_protal_radial_burst" ), teleportermodel.origin + ( 0, 0, 24 ) );
        level thread namespace_8898f05447e219f9::function_14c306bcc0c9e83f( teleportermodel );
        playfxontag( utility::getfx( "ztron_arena_teleporter" ), teleportermodel, "tag_origin" );
        arena.teleportertrigger = spawn( "trigger_radius", center.origin + ( 0, 0, 30 ), 0, 40, 72 );
        arena.teleportertrigger.var_8dbd63b14b4b0b40 = teleportermodel;
        arena.teleportertrigger thread function_ebac74fcc3f5d924();
        ztron_sound::ztron_playsound( "ztron_teleporter_spawn", arena.teleportertrigger.origin );
        ztron_sound::function_ac1e49175da7897d( "arenaEvent", "teleporterSpawn", arena.name );
        level notify( #"teleporter_spawned" );
        level.ztron.teleporteractive = 1;
        
        if ( level.ztron.blitzmode && !level.ztron.active_arena.papaback_defeated )
        {
            ztron_ui::function_a9f44f8a92e81c65();
        }
        
        level utility::waittill_any_return( "ztron_teleporter_taken", "close_all_doors", "slayer_arena_activated" );
        level.ztron.teleporteractive = 0;
        wait 3;
        arena.teleportertrigger function_73f90694864f2eae();
        arena.teleportertrigger delete();
    }
    
    level.ztron.var_3678ff7453f3c5cf = undefined;
}

// Namespace ztron_arena
// Params 1
// Checksum 0xb700c00c, Offset: 0x8e2a
// Size: 0x3b1
function function_ebac74fcc3f5d924( timeout = isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300 )
{
    level endon( #"ztron_game_is_over" );
    level endon( #"ztron_teleporter_taken", #"arena_completed", #"close_all_doors", #"kill_teleporter" );
    self endon( #"death" );
    
    if ( isdefined( self.var_8dbd63b14b4b0b40 ) )
    {
        self.var_8dbd63b14b4b0b40 thread ztron_util::orgspinout( 60 );
        ztron_sound::ztron_playsound( "ztron_teleporter_lp", undefined, self.var_8dbd63b14b4b0b40 );
    }
    
    self triggerdisable();
    
    if ( isdefined( level.ztron.var_3678ff7453f3c5cf ) )
    {
        level waittill( level.ztron.var_3678ff7453f3c5cf );
    }
    else
    {
        wait level.ztron.var_3ee4688dfd3a7d7c;
    }
    
    self triggerenable();
    function_58e6a12ecfe3c747( undefined, undefined, "ui_hud_ztron_icon_round_exit" );
    touchingtime = 0;
    waitingtime = 0;
    hintcooldown = 0;
    
    while ( true )
    {
        if ( level utility::flag( "ztron_all_players_dead" ) )
        {
            level.ztron.teleporteractive = 0;
            self triggerdisable();
            return;
        }
        
        /#
            drawtrigger( self, ( 0, 1, 0 ), 0, 1, 0, ( 0, 1, 0 ) );
        #/
        
        istouching = 0;
        var_1af2f040fa3bd8d1 = 0;
        
        foreach ( player in level.players )
        {
            vehtouching = player.ztron.vehicle && player.ztron.vehicle istouching( self );
            playertouching = player istouching( self );
            istouching |= playertouching || vehtouching;
            var_1af2f040fa3bd8d1 |= player.var_d9f82b082e1118d3;
        }
        
        waitingtime += level.framedurationseconds;
        
        if ( istouching )
        {
            touchingtime += level.framedurationseconds;
        }
        else
        {
            touchingtime = 0;
        }
        
        touchthreshold = level.ztron.var_c7659fc1aabef3f0;
        
        if ( touchingtime > touchthreshold || waitingtime > timeout )
        {
            if ( var_1af2f040fa3bd8d1 == 0 )
            {
                break;
            }
            else if ( gettime() > hintcooldown )
            {
                level thread ztron_ui::function_6e791be3702fa2a8( "STORE_PLAYER_IS_BROWSNING_HINT", 0, 8, 1 );
                hintcooldown = gettime() + 12000;
            }
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        player notify( #"ztron_teleporter_taken" );
    }
    
    ztron_sound::ztron_playsound( "ztron_travel_portal_travel" );
    level notify( #"ztron_teleporter_taken" );
}

// Namespace ztron_arena
// Params 2
// Checksum 0xe1c1868e, Offset: 0x91e3
// Size: 0x335
function function_4019c4a603cd949e( arenaid, var_cf30494c821a2d56 )
{
    profilestart();
    arena = level.ztron.arenas[ arenaid ];
    createlabel = 0;
    arena.openexits = [];
    arena.exittaken = undefined;
    allside = [ "bottom", "top", "right", "left" ];
    
    if ( isdefined( var_cf30494c821a2d56 ) && var_cf30494c821a2d56.size )
    {
        allside = var_cf30494c821a2d56;
        num = var_cf30494c821a2d56.size;
        createlabel = 1;
    }
    else
    {
        var_fb464311636908a3 = level.ztron.var_fb464311636908a3;
        
        if ( isdefined( level.ztron.var_d5a46a191654f0dd ) )
        {
            allside = level.ztron.var_d5a46a191654f0dd;
        }
        
        var_fb464311636908a3 = var_fb464311636908a3 > allside.size ? allside.size : var_fb464311636908a3;
        num = randomintrange( 1, var_fb464311636908a3 + 1 );
        num = int( clamp( num, 1, 4 ) );
    }
    
    for ( i = 0; i < num ; i++ )
    {
        side = utility::array_random( allside );
        allside = arrayremove( allside, side );
        exit = arena.exits[ side ];
        
        if ( isdefined( exit ) )
        {
            exit.side = side;
            exitname = undefined;
            
            if ( level.ztron.var_371903e5801e0e08 && createlabel )
            {
                branchrequest = level.ztron.var_b6efb062e0563051[ arena.name ];
                targetarena = branchrequest.exitname[ side ];
                exitname = function_8aac54c4cf4240af( targetarena );
                exit.var_fcbbc067e2b4df9e = function_973956bb5a6e60f7( targetarena );
            }
            
            ztron_debug::debugmsg( " Opening Exit: " + exit.side + ( isdefined( exit.var_fcbbc067e2b4df9e ) ? " Target: " + exit.var_fcbbc067e2b4df9e.name : "" ) );
            arena thread function_1ba3406a47673903( side, level.ztron.var_3678ff7453f3c5cf );
            level.ztron.active_arena.openexits[ level.ztron.active_arena.openexits.size ] = exit;
            exit thread openexit( exitname, level.ztron.var_3678ff7453f3c5cf );
        }
    }
    
    assert( level.ztron.active_arena.openexits.size > 0, "<dev string:x427>" );
    ztron_debug::debugmsg( "Exits Opened: " + level.ztron.active_arena.openexits.size );
    ztron_sound::ztron_playsound( "ztron_travel_doors_unlocked" );
    profilestop();
}

// Namespace ztron_arena
// Params 2
// Checksum 0x96179046, Offset: 0x9520
// Size: 0x252
function openexit( exitname, var_d6fa238b8ce1c6b2 )
{
    level endon( #"ztron_game_is_over" );
    
    if ( var_d6fa238b8ce1c6b2 )
    {
        level waittill( var_d6fa238b8ce1c6b2 );
    }
    
    if ( isdefined( level.ztron.active_arena.openexits[ 0 ].var_fcbbc067e2b4df9e ) && level.ztron.active_arena.openexits[ 0 ] == self )
    {
        centernext = function_688e222d8cf08155( level.ztron.active_arena.openexits[ 0 ].var_fcbbc067e2b4df9e );
        hintpos = centernext.origin;
        function_ce4ea3ff56399ff1( hintpos, 0 );
    }
    else if ( isdefined( level.ztron.active_arena.openexits[ 1 ].var_fcbbc067e2b4df9e ) && level.ztron.active_arena.openexits[ 1 ] == self )
    {
        centernext = function_688e222d8cf08155( level.ztron.active_arena.openexits[ 1 ].var_fcbbc067e2b4df9e );
        hintpos = centernext.origin;
        function_ce4ea3ff56399ff1( hintpos, 1 );
    }
    else if ( !isdefined( level.ztron.var_86ab4cc5041791bb ) )
    {
        function_f6b211688053bd4f( level.ztron.currentarena, ztron_weather::function_8bfe19c4541053f2() );
    }
    
    function_58e6a12ecfe3c747( "tag_origin", level.ztron.active_arena.exitvfx ?? "ztron_arena_exit", "ui_hud_ztron_icon_round_exit", undefined, exitname );
    thread function_699e5d2b0a2caef0();
    ztron_debug::debugmsg( "Exit is now open and waiting " + self.side + ( isdefined( exitname ) ? " target " + exitname : "" ) );
    msg = level utility::waittill_any_return( "ztron_exit_taken", "close_all_doors" );
    ztron_debug::debugmsg( "Exit is closing because it receieved msg " + msg );
    function_73f90694864f2eae();
}

// Namespace ztron_arena
// Params 7
// Checksum 0xb1f2c95, Offset: 0x977a
// Size: 0x1aa
function function_58e6a12ecfe3c747( model, vfx, objectiveicon, origin, text = &"ztron_hud/exit", var_5e996ded56f04bfd, var_afd26528b55a0944 )
{
    ztron_debug::debugmsg( "Enabling Trigger on side: " + self.side );
    self.isdisabled = 0;
    
    if ( isdefined( model ) )
    {
        if ( isdefined( self.var_8dbd63b14b4b0b40 ) )
        {
            self.var_8dbd63b14b4b0b40 delete();
        }
        
        if ( !isdefined( origin ) )
        {
            origin = ztron_util::function_edbdef29925b4c66( self.origin );
        }
        
        self.var_8dbd63b14b4b0b40 = utility::spawn_model( model, origin, self.angles );
        
        if ( isdefined( vfx ) )
        {
            playfxontag( utility::getfx( vfx ), self.var_8dbd63b14b4b0b40, "tag_origin" );
        }
    }
    
    if ( isdefined( objectiveicon ) )
    {
        objectiveindex = objidpoolmanager::requestobjectiveid();
        
        if ( objectiveindex != -1 )
        {
            objectoffset = ( 0, 0, 80 );
            objidpoolmanager::objective_add_objective( objectiveindex, "current", self.origin + objectoffset, objectiveicon );
            objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
            objidpoolmanager::objective_set_play_intro( objectiveindex, 1 );
            objidpoolmanager::objective_set_play_outro( objectiveindex, 0 );
            objidpoolmanager::objective_playermask_showtoall( objectiveindex );
            objidpoolmanager::objective_showdistance( objectiveindex, 0 );
            objidpoolmanager::update_objective_setfriendlylabel( objectiveindex, text );
            objidpoolmanager::update_objective_setneutrallabel( objectiveindex, text );
            objidpoolmanager::update_objective_setenemylabel( objectiveindex, text );
            
            if ( var_5e996ded56f04bfd && var_afd26528b55a0944 )
            {
                objidpoolmanager::function_de3fb937d4f45f38( objectiveindex, var_5e996ded56f04bfd, var_afd26528b55a0944 );
            }
        }
        
        self.objectiveindex = objectiveindex;
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xab05f046, Offset: 0x992c
// Size: 0x65
function function_73f90694864f2eae()
{
    ztron_debug::debugmsg( "Disabling Trigger on side: " + self.side );
    self.isdisabled = 1;
    
    if ( isdefined( self.var_8dbd63b14b4b0b40 ) )
    {
        self.var_8dbd63b14b4b0b40 delete();
    }
    
    if ( isdefined( self.objectiveindex ) )
    {
        objidpoolmanager::returnobjectiveid( self.objectiveindex );
        self.objectiveindex = undefined;
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x1d69d810, Offset: 0x9999
// Size: 0x1e9
function function_699e5d2b0a2caef0()
{
    level endon( #"ztron_game_is_over", #"ztron_exit_taken", #"close_all_doors" );
    
    while ( true )
    {
        self waittill( #"trigger", ent_triggered );
        
        /#
            if ( isbot( ent_triggered ) )
            {
                continue;
            }
        #/
        
        if ( isent( ent_triggered ) )
        {
            if ( isplayer( ent_triggered ) )
            {
                break;
            }
            
            if ( ent_triggered vehicle::is_vehicle() )
            {
                break;
            }
        }
    }
    
    level.ztron.active_arena.exittaken = self;
    
    foreach ( player in level.players )
    {
        exitstart = self.exitstarts[ player.sessionuimemberindex ];
        assert( isdefined( exitstart ) );
        
        if ( !isdefined( exitstart.angles ) )
        {
            exitstart.angles = ( 0, 0, 0 );
        }
        
        player.ztron.predictedspawnpoint = exitstart;
        player notify( #"ztron_exit_taken", { #openedby:ent_triggered } );
    }
    
    ztron_debug::debugmsg( "Exit Triggered: " + self.side + " triggered by: " + ( isdefined( ent_triggered.owner ) ? ent_triggered.owner.name : ent_triggered.name ) );
    level notify( #"ztron_exit_taken", { #openedby:ent_triggered } );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x90372fbc, Offset: 0x9b8a
// Size: 0x126
function function_88c5627b236319bf()
{
    ztron_debug::debugmsg( "Resetting all Blockers!" );
    
    foreach ( side in self.exitblockers )
    {
        foreach ( blocker in side )
        {
            blocker.origin = blocker.original_location;
            ztron_debug::debugmsg( "Moving blocker: " + blocker.side + " to original position " + blocker.origin );
        }
    }
}

// Namespace ztron_arena
// Params 2
// Checksum 0xc1d2550f, Offset: 0x9cb8
// Size: 0xe5
function function_1ba3406a47673903( side, waittillsignal )
{
    level endon( #"ztron_game_is_over" );
    
    if ( waittillsignal )
    {
        level waittill( waittillsignal );
    }
    
    foreach ( blocker in self.exitblockers[ side ] )
    {
        blocker.origin = blocker.original_location + ( 0, 0, -50000 );
        ztron_debug::debugmsg( "Moving blocker: " + side + " to down position " + blocker.origin );
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x289c0f7a, Offset: 0x9da5
// Size: 0x9d
function function_221d68c3fc140fa3()
{
    ztron_debug::debugmsg( "disableAllTrigger called" );
    
    foreach ( exit in self.exits )
    {
        exit function_73f90694864f2eae();
    }
    
    level notify( #"close_all_doors" );
    self.openexits = [];
}

// Namespace ztron_arena
// Params 2
// Checksum 0x7cc9bea, Offset: 0x9e4a
// Size: 0x20b
function changearena( arenaid, rounds )
{
    self notify( #"hash_3c448e91259929f4" );
    self endon( #"hash_3c448e91259929f4" );
    ztron_debug::debugmsg( "changeArena called: " + arenaid );
    level notify( #"arena_completed" );
    level notify( #"round_over" );
    level utility::flag_clear( "ztron_round_spawning" );
    level utility::flag_set( "ztron_round_over" );
    ztron_util::killallenemies();
    ztron_util::function_494e6b73ea596cc7( 3 );
    ztron_util::function_d54d1c1fe00833d6();
    ztron_util::function_4430e75095fb2a8();
    
    if ( isdefined( level.ztron.active_arena ) )
    {
        arena = level.ztron.active_arena;
        arena function_88c5627b236319bf();
        arena function_221d68c3fc140fa3();
        arena deactivatearena();
    }
    
    level.ztron.currentarena = arenaid;
    setomnvar( "ui_ztron_arena_number", arenaid );
    prevround = level.ztron.roundnumber;
    var_bdb94bcd4b8c89bd = level.ztron.var_bdb94bcd4b8c89bd;
    var_28a1bd9e3a501518 = level.ztron.currentarena * var_bdb94bcd4b8c89bd + level.ztron.game_laps * level.ztron.arenas.size * var_bdb94bcd4b8c89bd;
    ztron_main::function_2da19957201c6090( var_28a1bd9e3a501518 );
    var_8c9f25be7256357d = level.ztron.roundnumber + 1;
    rounddiff = var_8c9f25be7256357d - prevround;
    
    if ( rounddiff >= 0 )
    {
        if ( level.ztron.var_be8fbd1178946a9 )
        {
            ztron_enemy::function_be8fbd1178946a9( var_8c9f25be7256357d );
        }
    }
    else
    {
        ztron_enemy::function_15d12af6ebc93bf0( var_8c9f25be7256357d );
    }
    
    level thread function_ccdf9ab2d1e56830( level.ztron.currentarena, rounds );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x6bbc7694, Offset: 0xa05d
// Size: 0x4, Type: bool
function function_7cb125cd85afe887()
{
    return true;
}

// Namespace ztron_arena
// Params 1
// Checksum 0x593ac7da, Offset: 0xa06a
// Size: 0x497
function function_bdf5aff7155ba61c( curround )
{
    profilestart();
    effectiveround = curround;
    
    if ( level.ztron.blitzmode )
    {
        effectiveround = curround * 4;
    }
    
    level.ztron.zombie_base_speed = 0;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.zombie_base_speed = 50;
    }
    
    level.ztron.zombie_base_speed += effectiveround * 5;
    lapround = level.ztron.arenas.size * 4;
    level.ztron.var_f1569c16a29ffcbf = 90 + level.ztron.game_laps * 600;
    level.ztron.var_f1569c16a29ffcbf += effectiveround * level.ztron.zombie_health_inc;
    
    if ( level.ztron.var_b3bd899c956ebef1 && level.ztron.var_f1569c16a29ffcbf > level.ztron.var_6802a5d0daf63432 )
    {
        level.ztron.var_f1569c16a29ffcbf = level.ztron.var_6802a5d0daf63432;
    }
    
    chance_dx = level.ztron.var_95d8c7a469393957 ? 10 : 0;
    chance_dx += level.ztron.blitzmode ? curround * 2 : 0;
    
    if ( level.ztron.game_laps > 0 )
    {
        chance_dx += level.ztron.game_laps * getdvarint( @"hash_f5e5173cadf4212f", 15 ) + int( curround % lapround / int( lapround / 5 ) );
    }
    
    foreach ( aidef in level.ztron.var_6fdc39ee25e5365e )
    {
        if ( aidef.original_chance > 0 && aidef.original_chance < 100 )
        {
            aidef.spawn_chance = clampint( aidef.original_chance + chance_dx + level.players.size, 1, 100 );
        }
        
        if ( level.ztron.game_laps > 0 && level.ztron.game_laps > aidef.var_de74cae86cad2e9b )
        {
            if ( !isdefined( aidef.grpmin ) && aidef.var_6a1cedaf05dbaf69 )
            {
                aidef.grpmin = 1;
                aidef.grpmax = aidef.var_6a1cedaf05dbaf69;
            }
            
            if ( isdefined( aidef.grpmin ) )
            {
                aidef.grpmin += level.ztron.game_laps - aidef.var_de74cae86cad2e9b;
                aidef.grpmax += level.ztron.game_laps - aidef.var_de74cae86cad2e9b;
            }
            
            if ( isdefined( aidef.maxaicount ) )
            {
                aidef.maxaicount += level.ztron.game_laps - aidef.var_de74cae86cad2e9b;
                
                if ( isdefined( aidef.var_9c9bebd72fa2dbe9 ) )
                {
                    aidef.maxaicount = clampint( aidef.maxaicount, 0, aidef.var_9c9bebd72fa2dbe9 );
                }
            }
            
            aidef.var_de74cae86cad2e9b = level.ztron.game_laps;
        }
    }
    
    profilestop();
}

// Namespace ztron_arena
// Params 2
// Checksum 0xea0b3215, Offset: 0xa509
// Size: 0x1a6
function function_c8af49e5a83c7404( var_2740b265d85ddeca, radiussquared )
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        spots = level.ztron.active_arena.safespots;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        spots = level.ztron.slayer.active_arena.safespots;
    }
    
    safespots = [];
    
    foreach ( spot in spots )
    {
        nooverlapping = 1;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( spot.origin, player.origin ) < radiussquared )
            {
                nooverlapping = 0;
                break;
            }
        }
        
        if ( nooverlapping )
        {
            safespots[ safespots.size ] = spot;
        }
    }
    
    return ztron_util::function_c5ac6dde1c89cb8f( safespots, var_2740b265d85ddeca );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xc5f6068c, Offset: 0xa6b8
// Size: 0x187
function function_8c2aa5e7037af31c( var_2740b265d85ddeca )
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( !isdefined( level.ztron.active_arena ) )
        {
            ztron_debug::debugmsg( "getASafeSpot: active_arena is undefined (arena deactivated during AI thread)", 1 );
            return;
        }
        
        safespots = level.ztron.active_arena.safespots;
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        if ( !isdefined( level.ztron.slayer.active_arena ) )
        {
            ztron_debug::debugmsg( "getASafeSpot: slayer active_arena is undefined", 1 );
            return;
        }
        
        safespots = level.ztron.slayer.active_arena.safespots;
    }
    else
    {
        ztron_debug::debugmsg( "getASafeSpot called in illegal context: " + ztron_main::function_4da200e9b8d58a3c(), 1 );
        return;
    }
    
    arenaname = isdefined( level.ztron.active_arena ) ? level.ztron.active_arena.name : "unknown";
    assert( isdefined( safespots ) && safespots.size > 0, "<dev string:x437>" + arenaname + "<dev string:x2fa>" + "<dev string:x458>" + string( ztron_main::function_4da200e9b8d58a3c() ) );
    
    if ( isdefined( safespots ) )
    {
        if ( !isdefined( var_2740b265d85ddeca ) )
        {
            return safespots[ randomint( safespots.size ) ];
        }
        
        return ztron_util::function_c5ac6dde1c89cb8f( safespots, var_2740b265d85ddeca );
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x6021d1f4, Offset: 0xa847
// Size: 0x141
function function_c5ca214b01ea2754()
{
    if ( level.ztron.active_arena.papabackspots.size > 0 )
    {
        return level.ztron.active_arena.papabackspots[ randomint( level.ztron.active_arena.papabackspots.size ) ];
    }
    
    sides = [ "top", "left", "right", "bottom" ];
    
    foreach ( exit in level.ztron.active_arena.openexits )
    {
        if ( isdefined( exit ) )
        {
            sides = arrayremove( sides, exit.side );
        }
    }
    
    return function_9b7bf2d5c866b74d( sides[ randomint( sides.size ) ] );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xcc082b2b, Offset: 0xa991
// Size: 0x165
function function_11172d3a2777785d( arenaid )
{
    self notify( #"hash_6476df55b4115376" );
    self endon( #"hash_6476df55b4115376" );
    level endon( #"ztron_game_is_over", #"ztron_exit_taken", #"ztron_teleporter_taken", #"noPapaBack", #"arena_completed" );
    
    if ( !level.ztron.var_92c01edd802f6a18 )
    {
        return;
    }
    
    if ( level.ztron.roundnumber <= 4 || level.ztron.var_371903e5801e0e08 || level.ztron.bossround || isdefined( level.ztron.slayer.var_41aef428e6e941da ) )
    {
        return;
    }
    
    arena = level.ztron.arenas[ arenaid ];
    
    if ( getdvarint( @"hash_21911e56e6bce96e" ) == 0 )
    {
        wait getdvarint( @"hash_1f90d031ed5d911c", 30 );
    }
    
    level.ztron.lastPapabackSpawn = level.ztron.roundnumber;
    level thread namespace_4f6b9f859d8abc98::function_13ba7fd249fe8069();
    ztron_sound::function_ac1e49175da7897d( "arenaEvent", "papabackSpawn", arena.name );
}

// Namespace ztron_arena
// Params 2
// Checksum 0xaf43828b, Offset: 0xaafe
// Size: 0x79
function function_a869811b814279a6( var_b41d92fac9bfa4b0, var_22a30a9977919a62 )
{
    if ( level.ztron.blitzmode )
    {
        escapedur = level.ztron.var_d0972e445894306d ?? 30;
        setomnvar( "ui_ztron_blitz_escape_dur_s", escapedur );
        ztron_ui::function_37aad40e39a9fdfe( "blitz_threshold_reached" );
        return;
    }
    
    ztron_ui::function_37aad40e39a9fdfe( "round_complete", var_b41d92fac9bfa4b0, var_22a30a9977919a62 );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xc09a66c7, Offset: 0xab7f
// Size: 0x88
function function_5c7f53e41e21ea79( var_b41d92fac9bfa4b0 )
{
    if ( level.ztron.blitzmode )
    {
        setomnvar( "ui_ztron_blitz_escape_dur_s", 0 );
        ztron_ui::function_37aad40e39a9fdfe( "blitz_threshold_reached" );
        level thread function_11a2473bb4a6d293();
        return;
    }
    
    if ( isdefined( level.ztron.var_e733dbd4ae561ad5 ) )
    {
        ztron_ui::function_37aad40e39a9fdfe( level.ztron.var_e733dbd4ae561ad5, var_b41d92fac9bfa4b0 );
        return;
    }
    
    ztron_ui::function_37aad40e39a9fdfe( "arena_last_round_complete", var_b41d92fac9bfa4b0 );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x5e30c958, Offset: 0xac0f
// Size: 0x54
function function_11a2473bb4a6d293()
{
    level endon( #"ztron_game_is_over", #"ztron_teleporter_taken" );
    level waittill( #"teleporter_spawned" );
    escapedur = level.ztron.var_d0972e445894306d ?? 30;
    setomnvar( "ui_ztron_blitz_escape_dur_s", escapedur );
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0x40a4dc21, Offset: 0xac6b
// Size: 0x1f1
function private function_f67be8b4fbb24ab9( challengename )
{
    ztron_ui::function_652bebdb4a15c169( challengename );
    
    switch ( challengename )
    {
        case #"hash_832bdc229a6a3a":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chbyl";
            break;
        case #"hash_5a4d2b12a19ad464":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chfrb";
            break;
        case #"hash_c7f751358c7a68a6":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chgy";
            break;
        case #"hash_f6a69f4bf9bd072":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chrtl";
            break;
        case #"hash_702f1fc838e40139":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chlc";
            break;
        case #"hash_15630a99f1361c04":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chfrtcy";
            break;
        case #"hash_31ccf4980e7b0f42":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chchr";
            break;
        case #"hash_45b734631b205714":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chscp";
            break;
        case #"hash_70e09da89f425e1d":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chts";
            break;
        case #"hash_bbc96d75d7f00a3d":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chetcy";
            break;
        case #"hash_eeffcb3868e1290a":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chmtl";
            break;
        case #"hash_81362f13a0a0d675":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chmsm";
            break;
        case #"hash_131dde448a5cd67c":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chnkt";
            break;
        case #"hash_6f76efa550b671d6":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chdg";
            break;
        case #"hash_8623b05fe4b87521":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chhs";
            break;
        case #"hash_77ce93183dbf4b59":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chmlt";
            break;
        case #"hash_8520a2d6e5b67789":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chswp";
            break;
        case #"hash_60b556a73fcd0b86":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chjng";
            break;
        case #"hash_e66e13ca7c39a3f3":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4chsba";
            break;
        default:
            dialogsoundalias = undefined;
            break;
    }
    
    ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4chlrd" );
    ztron_util::function_40ad6a6cc144aa3f( dialogsoundalias, 1 );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x4f58985f, Offset: 0xae64
// Size: 0x212, Type: bool
function function_af7e3641e16060b0()
{
    if ( level.players.size == 1 && level.ztron.var_ae731d68b2dededc )
    {
        level.ztron.var_ae731d68b2dededc = 1;
        level.ztron.var_1228c567770e4580 = 1;
        roundhigh = 0;
        player = level.players[ 0 ];
        
        if ( level.onlinegame )
        {
            var_dc205c7616637b13 = player playerstats_interface::getplayerstat( "ztronPlayerStats", "advancedSoloHighestRound", undefined, undefined, undefined, "zm" );
            var_9271b3110c7f6f85 = player playerstats_interface::getplayerstat( "ztronPlayerStats", "standModeHighestRound", undefined, undefined, undefined, "zm" );
            roundhigh = int( max( var_dc205c7616637b13, var_9271b3110c7f6f85 ) );
            ztron_debug::debugmsg( "Advanced Start Round: " + roundhigh + " roundHighAdv : " + var_dc205c7616637b13 + " roundHighSolo : " + var_9271b3110c7f6f85 );
        }
        
        /#
            roundhigh = getdvarint( @"hash_6839a108ac19733c", roundhigh );
        #/
        
        if ( roundhigh > 4 )
        {
            level notify( #"remove_papaback_intro" );
            var_24e48bc0c9ac0435 = level.ztron.arenas.size * 4;
            roundhigh = int( min( roundhigh, var_24e48bc0c9ac0435 ) );
            level utility::flag_set( "ztron_advanced_start_process" );
            level utility::flag_set( "ztron_round_paused" );
            level notify( #"advancedstart" );
            level notify( #"hash_1cf1c429bb1c9a07" );
            
            if ( roundhigh > 20 )
            {
                level waittill( #"round_begin" );
                function_7ba29ded89fa298b();
            }
            
            var_71483ab64fc14eb4 = 0;
            
            if ( level.onlinegame )
            {
                var_71483ab64fc14eb4 = player playerstats_interface::getplayerstat( "ztronPlayerStats", "highestCurrencyEarned", undefined, undefined, undefined, "zm" );
            }
            
            /#
                var_71483ab64fc14eb4 = getdvarint( @"hash_2cfdc41e53bbb93f", var_71483ab64fc14eb4 );
            #/
            
            player ztron_player_utility::function_8e1155bcebb3b7b3( var_71483ab64fc14eb4, 0, 0 );
            arenaid = level function_7d0fd8bf4ff808d7( roundhigh );
            level thread function_b60bc9db288fcdb3( arenaid, player );
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xf7d922e3, Offset: 0xb07f
// Size: 0x2d3
function function_7ba29ded89fa298b()
{
    level endon( #"arena_switching", #"game_over", #"ztron_game_is_over" );
    ztron_ui::function_37aad40e39a9fdfe( "advanced_start_room_of_fate" );
    ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4rofch" );
    rockspots = arrayrandomize( utility::getstructarray( "island_fate_rock_loc", "targetname" ) );
    fatedefs = arrayrandomize( ztron_fate::function_f457cde738de3145() );
    faterocks = [];
    
    for ( i = 0; i < rockspots.size && i < fatedefs.size ; i++ )
    {
        rock = ztron_fate::function_6aed78eb7ea46ed2( fatedefs[ i ], rockspots[ i ].origin, 0, 1 );
        faterocks[ faterocks.size ] = rock;
    }
    
    timeout = 60000 + gettime();
    warning = timeout - 15000;
    lasttime = gettime();
    var_8d1f606531959b2d = 0;
    
    while ( !var_8d1f606531959b2d )
    {
        time = gettime();
        
        if ( time > timeout )
        {
            break;
        }
        
        if ( lasttime <= warning && time > warning )
        {
            ztron_ui::function_37aad40e39a9fdfe( "fate_hurry" );
            ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4hry" );
        }
        
        lasttime = time;
        wait 1;
        var_8d1f606531959b2d = 1;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.ztron.var_b11b66f5583f1049 ) )
            {
                var_8d1f606531959b2d = 0;
                break;
            }
        }
    }
    
    foreach ( rock in faterocks )
    {
        if ( rock )
        {
            ztron_item::clearitem( rock );
        }
    }
    
    ztron_ui::function_37aad40e39a9fdfe( "fate_decided" );
    
    foreach ( player in level.players )
    {
        player ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4rofdn" );
    }
    
    wait 4;
    return var_8d1f606531959b2d;
}

// Namespace ztron_arena
// Params 1
// Checksum 0xe197c67d, Offset: 0xb35b
// Size: 0x33
function function_7d0fd8bf4ff808d7( highestRound )
{
    arenaid = int( ( highestRound - 1 ) / 4 );
    arenaid = int( max( 0, arenaid ) );
    return arenaid;
}

// Namespace ztron_arena
// Params 2
// Checksum 0x8d69b887, Offset: 0xb397
// Size: 0x173
function function_b60bc9db288fcdb3( arenaid, player )
{
    level endon( #"arena_switching", #"game_over", #"ztron_game_is_over" );
    level thread openteleporter( 0 );
    slayermart = utility::getstruct( "island_slayer_mart_loc", "targetname" );
    
    if ( isdefined( slayermart ) )
    {
        level thread ztron_slayer::slayer_arena_slayermart( slayermart, ( 0, 0, 0 ), 0, 0, isdefined( level.ztron.var_d0972e445894306d ) ? level.ztron.var_d0972e445894306d : level.ztron.game_laps > 0 ? 600 : 300 );
        player ztron_ui::function_f7e6c4641e827bf8( 1 );
    }
    
    level waittill( #"ztron_teleporter_taken" );
    var_7b1bd66f52b0873 = int( arenaid / 6 ) + player ztron_score::function_4f2852a8848fa4ce();
    player ztron_score::function_928d324dea557052( var_7b1bd66f52b0873 );
    extrabombs = int( arenaid / 5 ) + player namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6();
    player namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( extrabombs );
    extraboosts = int( arenaid / 5 ) + player namespace_33e886a9a5b55137::function_a4ca73e22464e330();
    player namespace_33e886a9a5b55137::function_992dffefa33a9534( extraboosts );
    level utility::flag_clear( "ztron_round_paused" );
    level utility::flag_clear( "ztron_advanced_start_process" );
    level thread changearena( arenaid );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x51784f6a, Offset: 0xb512
// Size: 0x97
function function_21c084afaad504ad()
{
    profilestart();
    var_e648f45ad613cd19 = [];
    
    if ( level.ztron.gatekeys & 1 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 1;
    }
    
    if ( level.ztron.gatekeys & 2 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 2;
    }
    
    if ( level.ztron.gatekeys & 4 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 4;
    }
    
    if ( level.ztron.gatekeys & 8 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 8;
    }
    
    profilestop();
    return var_e648f45ad613cd19;
}

// Namespace ztron_arena
// Params 0
// Checksum 0xa4608db0, Offset: 0xb5b3
// Size: 0x9f
function function_31683be9b388d4dc()
{
    profilestart();
    var_e648f45ad613cd19 = [];
    
    if ( ( level.ztron.gatekeys & 1 ) == 0 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 1;
    }
    
    if ( ( level.ztron.gatekeys & 2 ) == 0 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 2;
    }
    
    if ( ( level.ztron.gatekeys & 4 ) == 0 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 4;
    }
    
    if ( ( level.ztron.gatekeys & 8 ) == 0 )
    {
        var_e648f45ad613cd19[ var_e648f45ad613cd19.size ] = 8;
    }
    
    profilestop();
    return var_e648f45ad613cd19;
}

// Namespace ztron_arena
// Params 1
// Checksum 0x58286fe5, Offset: 0xb65c
// Size: 0x59
function function_9dc96ef85325c7eb( side )
{
    profilestart();
    
    switch ( side )
    {
        case #"hash_6d308d6c437ce11c":
            profilestop();
            return 1;
        case #"hash_c9b3133a17a3b2d0":
            profilestop();
            return 2;
        case #"hash_96815ce4f2a3dbc5":
            profilestop();
            return 4;
        case #"hash_dcbcc9b3083fb78a":
            profilestop();
            return 8;
    }
    
    profilestop();
    return 0;
}

// Namespace ztron_arena
// Params 1
// Checksum 0x54026be1, Offset: 0xb6bf
// Size: 0x69
function function_3f9984ab3a243167( key )
{
    profilestart();
    
    switch ( key )
    {
        case 1:
            profilestop();
            return "top";
        case 2:
            profilestop();
            return "left";
        case 4:
            profilestop();
            return "right";
        case 8:
            profilestop();
            return "bottom";
    }
    
    profilestop();
    return "none";
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0xfb1c57d1, Offset: 0xb732
// Size: 0x100
function private function_2cf802b45af94c34( side )
{
    level endon( #"ztron_game_is_over", #"round_over" );
    mykey = function_9dc96ef85325c7eb( side );
    waitdelay = 0.35;
    waitdelay -= ( level.players.size - 1 ) * 0.05;
    waitdelay = clamp( waitdelay, 0.2, 0.35 );
    
    /#
        level.ztron.waitdelay = waitdelay;
    #/
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        waitframe();
        
        if ( utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
        {
            continue;
        }
        
        if ( level.ztron.gatekeys & mykey )
        {
            spot = function_9b7bf2d5c866b74d( side );
            ai = arenaspawnai( spot, 1 );
            
            if ( isdefined( ai ) )
            {
                wait waitdelay;
            }
        }
    }
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0x3074780b, Offset: 0xb83a
// Size: 0x159
function private function_bd70ef78c6451212( probability )
{
    level endon( #"ztron_game_is_over", #"round_over" );
    probability = int( clamp( probability, 0, 100 ) );
    
    if ( probability == 0 )
    {
        return;
    }
    
    var_2129f9dc992dba6e = getdvarint( @"hash_cb16d4d00466aa91", 5 );
    var_34f8738e2021029c = getdvarint( @"hash_67e37e763abcd557", 12 );
    minwaittime = getdvarint( @"hash_360373bd02a461a8", 1 );
    maxwaittime = getdvarint( @"hash_eb6fbfabaaebbbca", 5 );
    keychosen = undefined;
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        if ( randomint( 100 ) < probability )
        {
            var_64b9c96a524b09a4 = function_31683be9b388d4dc();
            
            if ( var_64b9c96a524b09a4.size )
            {
                keychosen = var_64b9c96a524b09a4[ randomint( var_64b9c96a524b09a4.size ) ];
                level.ztron.gatekeys |= keychosen;
                unlockduration = randomfloatrange( var_2129f9dc992dba6e, var_34f8738e2021029c );
                wait unlockduration;
                level.ztron.gatekeys &= ~keychosen;
            }
        }
        
        wait randomfloatrange( minwaittime, maxwaittime );
    }
}

// Namespace ztron_arena
// Params 2
// Checksum 0x251a26a0, Offset: 0xb99b
// Size: 0x18c
function function_dc88264180fc0c8c( keys = 3, degrade = 42 )
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        degrade = 47;
    }
    
    if ( level.players.size > 1 )
    {
        degrade -= ( level.players.size - 1 ) * 6;
    }
    
    var_9b2a4cb10ebd263a = spawnstruct();
    var_9b2a4cb10ebd263a.var_3697476bd20efe8d = getdvarint( @"hash_8f482a9baeeaff0f", keys );
    var_9b2a4cb10ebd263a.var_e19d9213bc39473 = getdvarint( @"hash_a38cb09617ea72f1", degrade );
    var_9b2a4cb10ebd263a.var_733cb91bab93e58b = 0;
    var_9b2a4cb10ebd263a.var_efb770b1e9386f4d = 0;
    probability = 100;
    var_3697476bd20efe8d = var_9b2a4cb10ebd263a.var_3697476bd20efe8d;
    
    if ( isdefined( level.ztron.var_51b2b203836e3a1d ) )
    {
        while ( var_3697476bd20efe8d )
        {
            duration = int( level.ztron.var_51b2b203836e3a1d * probability / 100 );
            var_9b2a4cb10ebd263a.var_733cb91bab93e58b += duration;
            var_9b2a4cb10ebd263a.var_efb770b1e9386f4d += int( duration * 2.3 );
            probability = int( clamp( probability - var_9b2a4cb10ebd263a.var_e19d9213bc39473, 5, 100 ) );
            var_3697476bd20efe8d--;
        }
    }
    
    return var_9b2a4cb10ebd263a;
}

// Namespace ztron_arena
// Params 1
// Checksum 0x5ed940c7, Offset: 0xbb30
// Size: 0x76
function function_b571858e87ed5ad1( var_9b2a4cb10ebd263a )
{
    profilestart();
    level.ztron.gatekeys = 0;
    var_3697476bd20efe8d = var_9b2a4cb10ebd263a.var_3697476bd20efe8d;
    var_e19d9213bc39473 = var_9b2a4cb10ebd263a.var_e19d9213bc39473;
    probability = 100;
    
    while ( var_3697476bd20efe8d )
    {
        level thread function_bd70ef78c6451212( probability );
        probability -= var_e19d9213bc39473;
        var_3697476bd20efe8d--;
    }
    
    profilestop();
}

// Namespace ztron_arena
// Params 0
// Checksum 0x93730246, Offset: 0xbbae
// Size: 0x3d9
function function_8948506f3660f658()
{
    self notify( #"hash_90c939720ae48a15" );
    self endon( #"hash_90c939720ae48a15" );
    level endon( #"ztron_game_is_over", #"round_over" );
    level utility::flag_set( "ztron_round_spawning" );
    level utility::flag_clear( "ztron_round_over" );
    level thread function_e087402e224a96c();
    startime = gettime();
    var_19e466ad77855bb5 = 1;
    level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ] = 0;
    
    if ( utility::flag( "ztron_challenge_round_spawning" ) )
    {
        level waittill( #"ztron_challenge_round_spawning" );
        var_19e466ad77855bb5 = level.ztron.game_laps > 0;
    }
    
    level notify( #"hash_37d3f74f5fcde156" );
    
    if ( var_19e466ad77855bb5 )
    {
        level.ztron.var_51b2b203836e3a1d = int( 20 + level.ztron.roundnumber * 2 + 120 * level.ztron.game_laps );
        
        if ( !level.ztron.var_95d8c7a469393957 && level.ztron.game_laps == 0 )
        {
            level.ztron.var_51b2b203836e3a1d = clampint( level.ztron.var_51b2b203836e3a1d, 20, 180 );
            level.ztron.var_3767fef3d7e028ef = level.ztron.var_51b2b203836e3a1d == 180;
        }
        
        if ( getdvarint( @"hash_1aafaa210ed87b63", 0 ) )
        {
            level.ztron.var_51b2b203836e3a1d = 9999999;
        }
        
        var_84e9c31fbaa384af = level.ztron.active_arena.var_84e9c31fbaa384af;
        
        /#
            if ( getdvarint( @"hash_14eebd6257ff6543", 0 ) != 0 )
            {
                var_84e9c31fbaa384af = getdvarint( @"hash_14eebd6257ff6543", 0 );
            }
        #/
        
        level thread function_3b188500516e4b48( var_84e9c31fbaa384af );
        gatekeeper = function_dc88264180fc0c8c();
        level.ztron.curkillcount = 0;
        level.ztron.minkillcount = int( gatekeeper.var_efb770b1e9386f4d );
        level.ztron.var_efb770b1e9386f4d = level.ztron.minkillcount;
        level function_b571858e87ed5ad1( gatekeeper );
        level thread function_2cf802b45af94c34( "top" );
        level thread function_2cf802b45af94c34( "left" );
        level thread function_2cf802b45af94c34( "bottom" );
        level thread function_2cf802b45af94c34( "right" );
        level.ztron.var_e839340c881d4d4d = level.ztron.var_51b2b203836e3a1d;
        
        while ( true )
        {
            if ( utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
            {
                waitframe();
                continue;
            }
            
            if ( level.ztron.var_51b2b203836e3a1d <= 0 )
            {
                level.ztron.var_51b2b203836e3a1d = 0;
                
                if ( level.ztron.minkillcount <= 0 )
                {
                    if ( level.ztron.bossround )
                    {
                        level.ztron.minkillcount = 0;
                        continue;
                    }
                    
                    break;
                }
            }
            
            wait 1;
            level.ztron.var_51b2b203836e3a1d -= 1;
        }
    }
    
    wait 1;
    level utility::flag_clear( "ztron_round_spawning" );
}

// Namespace ztron_arena
// Params 1
// Checksum 0x9cf2f023, Offset: 0xbf8f
// Size: 0x50
function function_47d33e24c034668( var_9875a4a4c841bb48 )
{
    threshold = 60 + var_9875a4a4c841bb48 * 5;
    
    if ( threshold > 150 )
    {
        threshold = 150;
    }
    
    if ( level.players.size > 1 )
    {
        threshold += level.players.size * 15;
    }
    
    return threshold;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x4aaa8c85, Offset: 0xbfe8
// Size: 0x1cf
function function_eaf0cd9998d84176()
{
    self notify( #"hash_f7b32781f23bc88" );
    self endon( #"hash_f7b32781f23bc88" );
    level endon( #"ztron_game_is_over", #"ztron_teleporter_taken" );
    level utility::flag_set( "ztron_round_spawning" );
    level utility::flag_clear( "ztron_round_over" );
    level notify( #"hash_6f84e921f58a1be9" );
    level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ] = 0;
    level.ztron.curkillcount = 0;
    var_784e036b356329cd = function_47d33e24c034668( level.ztron.currentarena );
    level.ztron.var_ce1978f284e95152 = var_784e036b356329cd;
    level.ztron.var_501b246c862a128e = 0;
    level.ztron.var_91517987ca332e2a = var_784e036b356329cd;
    level thread function_797fed96129b33a6();
    level notify( #"hash_37d3f74f5fcde156" );
    var_84e9c31fbaa384af = level.ztron.active_arena.var_84e9c31fbaa384af + 12;
    level thread function_3b188500516e4b48( var_84e9c31fbaa384af );
    level.ztron.var_51b2b203836e3a1d = 9999;
    gatekeeper = function_dc88264180fc0c8c();
    level function_cf7ae9686773f14d( gatekeeper );
    level thread function_e57630bd095d94c8( "top" );
    level thread function_e57630bd095d94c8( "left" );
    level thread function_e57630bd095d94c8( "bottom" );
    level thread function_e57630bd095d94c8( "right" );
    level waittill( #"blitz_threshold_reached" );
    level utility::flag_clear( "ztron_round_spawning" );
    wait 8;
    level notify( #"hash_6f84e921f58a1be9" );
}

// Namespace ztron_arena
// Params 1
// Checksum 0xf3dfe525, Offset: 0xc1bf
// Size: 0x76
function function_cf7ae9686773f14d( var_9b2a4cb10ebd263a )
{
    profilestart();
    level.ztron.gatekeys = 0;
    var_3697476bd20efe8d = var_9b2a4cb10ebd263a.var_3697476bd20efe8d;
    var_e19d9213bc39473 = var_9b2a4cb10ebd263a.var_e19d9213bc39473;
    probability = 100;
    
    while ( var_3697476bd20efe8d )
    {
        level thread function_d9ffe4cd3fdf43ae( probability );
        probability -= var_e19d9213bc39473;
        var_3697476bd20efe8d--;
    }
    
    profilestop();
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0x4069d9db, Offset: 0xc23d
// Size: 0xd5
function private function_e57630bd095d94c8( side )
{
    level endon( #"ztron_game_is_over", #"ztron_teleporter_taken", #"hash_6f84e921f58a1be9" );
    mykey = function_9dc96ef85325c7eb( side );
    waitdelay = 0.15;
    
    /#
        level.ztron.waitdelay = waitdelay;
    #/
    
    while ( true )
    {
        waitframe();
        
        if ( utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
        {
            continue;
        }
        
        if ( level.ztron.gatekeys & mykey )
        {
            spot = function_9b7bf2d5c866b74d( side );
            ai = arenaspawnai( spot, 1 );
            
            if ( isdefined( ai ) )
            {
                wait waitdelay;
            }
        }
    }
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0x1a78cfab, Offset: 0xc31a
// Size: 0x162
function private function_d9ffe4cd3fdf43ae( probability )
{
    level endon( #"ztron_game_is_over", #"ztron_teleporter_taken", #"hash_6f84e921f58a1be9" );
    probability = int( clamp( probability, 0, 100 ) );
    
    if ( probability == 0 )
    {
        return;
    }
    
    var_2129f9dc992dba6e = getdvarint( @"hash_cb16d4d00466aa91", 5 );
    var_34f8738e2021029c = getdvarint( @"hash_67e37e763abcd557", 12 );
    minwaittime = getdvarint( @"hash_360373bd02a461a8", 1 );
    maxwaittime = getdvarint( @"hash_eb6fbfabaaebbbca", 5 );
    keychosen = undefined;
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        if ( randomint( 100 ) < probability )
        {
            var_64b9c96a524b09a4 = function_31683be9b388d4dc();
            
            if ( var_64b9c96a524b09a4.size )
            {
                keychosen = var_64b9c96a524b09a4[ randomint( var_64b9c96a524b09a4.size ) ];
                level.ztron.gatekeys |= keychosen;
                unlockduration = randomfloatrange( var_2129f9dc992dba6e, var_34f8738e2021029c );
                wait unlockduration;
                level.ztron.gatekeys &= ~keychosen;
            }
        }
        
        wait randomfloatrange( minwaittime, maxwaittime );
    }
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0xb3ed3362, Offset: 0xc484
// Size: 0x146
function private onplayerspawned( params )
{
    if ( ztron_main::function_4da200e9b8d58a3c() != 1 )
    {
        return;
    }
    
    if ( level utility::flag( "ztron_round_spawning" ) )
    {
        if ( !isdefined( level.ztron.var_ea94561ca03b6911[ level.ztron.roundnumber ] ) )
        {
            level.ztron.var_ea94561ca03b6911[ level.ztron.roundnumber ] = 0;
        }
        
        if ( level.ztron.var_ea94561ca03b6911[ level.ztron.roundnumber ] < 2 )
        {
            level.ztron.var_ea94561ca03b6911[ level.ztron.roundnumber ]++;
            level.ztron.var_91517987ca332e2a += level.ztron.var_e0421d5e75de6120;
            level.ztron.var_6fa31a82b13f7d9b += level.ztron.var_e0421d5e75de6120;
        }
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0xcf4a591e, Offset: 0xc5d2
// Size: 0x97
function function_3b188500516e4b48( var_84e9c31fbaa384af )
{
    self notify( #"hash_f536bf873ee19fbf" );
    self endon( #"hash_f536bf873ee19fbf" );
    level endon( #"ztron_game_is_over", #"round_over" );
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        level.ztron.active_arena.var_f3d2bdcb7cafb15b = var_84e9c31fbaa384af + level.players.size * level.ztron.active_arena.var_ae48c1fd2b6e2299;
        wait 5;
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x146da28, Offset: 0xc671
// Size: 0x82
function function_e087402e224a96c()
{
    self notify( #"hash_43f129aab1725bb8" );
    self endon( #"hash_43f129aab1725bb8" );
    level endon( #"ztron_game_is_over", #"round_over", #"horde_defeated" );
    function_b26dfae9b110de65();
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        waitframe();
    }
    
    level.ztron.var_91517987ca332e2a = level.ztron.zombies.size;
    level thread function_bf1d1ae5d9863498();
}

// Namespace ztron_arena
// Params 0
// Checksum 0x39166f8e, Offset: 0xc6fb
// Size: 0x34
function function_b26dfae9b110de65()
{
    level.ztron.var_91517987ca332e2a = 0;
    setomnvar( "ui_ztron_remaining_enemy_count", level.ztron.var_91517987ca332e2a );
}

// Namespace ztron_arena
// Params 1
// Checksum 0x335fd2bf, Offset: 0xc737
// Size: 0x27e
function on_ai_killed( params )
{
    if ( !isdefined( level.ztron.var_91517987ca332e2a ) )
    {
        level.ztron.var_91517987ca332e2a = 0;
    }
    
    if ( !isdefined( level.ztron.curkillcount ) )
    {
        level.ztron.curkillcount = 0;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        level.ztron.curkillcount++;
        
        if ( level.ztron.minkillcount > 0 )
        {
            level.ztron.minkillcount--;
        }
        
        level.ztron.var_91517987ca332e2a--;
        
        if ( level.ztron.var_91517987ca332e2a < 0 )
        {
            level.ztron.var_91517987ca332e2a = 0;
        }
        
        if ( !level utility::flag( "ztron_round_spawning" ) )
        {
            if ( level.ztron.var_91517987ca332e2a > level.ztron.zombies.size )
            {
                level.ztron.var_91517987ca332e2a = level.ztron.zombies.size;
            }
        }
        
        if ( level.ztron.blitzmode )
        {
            if ( !isdefined( level.ztron.var_ce1978f284e95152 ) )
            {
                level.ztron.var_ce1978f284e95152 = 0;
            }
            
            if ( !level.ztron.var_501b246c862a128e && level.ztron.var_ce1978f284e95152 > 0 )
            {
                level.ztron.var_ce1978f284e95152--;
                
                if ( level.ztron.var_ce1978f284e95152 <= 0 )
                {
                    level.ztron.var_501b246c862a128e = 1;
                    level notify( #"blitz_threshold_reached" );
                    
                    if ( level.ztron.var_88b879586dee302f < level.ztron.var_c5d5ecce60380726.size )
                    {
                        ztron_enemy::function_be8fbd1178946a9( level.ztron.var_c5d5ecce60380726[ level.ztron.var_88b879586dee302f ] );
                        level.ztron.var_88b879586dee302f++;
                    }
                }
            }
        }
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x481edfd5, Offset: 0xc9bd
// Size: 0x166
function function_797fed96129b33a6()
{
    self notify( #"hash_4906b1e83f4f6712" );
    self endon( #"hash_4906b1e83f4f6712" );
    level endon( #"ztron_game_is_over", #"round_over", #"horde_defeated" );
    
    while ( true )
    {
        if ( level utility::flag( "ztron_round_paused" ) )
        {
            setomnvar( "ui_ztron_remaining_enemy_count", 0 );
            waitframe();
            continue;
        }
        
        if ( level utility::flag( "ztron_round_spawning" ) == 0 || !isdefined( level.ztron.var_91517987ca332e2a ) )
        {
            level.ztron.var_91517987ca332e2a = level.ztron.zombies.size;
        }
        else if ( level.ztron.zombies.size > level.ztron.var_91517987ca332e2a )
        {
            level.ztron.var_91517987ca332e2a = level.ztron.zombies.size;
        }
        
        remainingcount = level.ztron.var_91517987ca332e2a;
        
        if ( level.ztron.blitzmode )
        {
            remainingcount = level.ztron.var_ce1978f284e95152;
        }
        
        setomnvar( "ui_ztron_remaining_enemy_count", int( max( remainingcount, 0 ) ) );
        waitframe();
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0xcf4d49b, Offset: 0xcb2b
// Size: 0xab
function function_bf1d1ae5d9863498()
{
    self notify( #"hash_35ee417d7e714272" );
    self endon( #"hash_35ee417d7e714272" );
    level endon( #"ztron_game_is_over", #"round_over", #"horde_defeated" );
    level thread function_797fed96129b33a6();
    killchecks = 120;
    
    while ( true )
    {
        if ( level.ztron.var_91517987ca332e2a <= 0 )
        {
            killchecks--;
        }
        
        if ( level.ztron.var_91517987ca332e2a > 0 || killchecks > 0 )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    function_b26dfae9b110de65();
    level notify( #"horde_defeated" );
}

// Namespace ztron_arena
// Params 0
// Checksum 0x357477a8, Offset: 0xcbde
// Size: 0x60
function function_3a59352403d79a80()
{
    self notify( #"hash_7de807be52439df4" );
    self endon( #"hash_7de807be52439df4" );
    level endon( #"ztron_game_is_over", #"round_over", #"hash_54d22cbc6baa8cf8" );
    
    while ( level.ztron.var_6fa31a82b13f7d9b > 0 )
    {
        waitframe();
    }
    
    level notify( #"hash_54d22cbc6baa8cf8" );
}

// Namespace ztron_arena
// Params 1, eflags: 0x4
// Checksum 0x14156bfc, Offset: 0xcc46
// Size: 0x137
function private function_e50ffe943a15b3e0( side )
{
    level endon( #"ztron_game_is_over", #"round_over", #"hash_54d22cbc6baa8cf8" );
    mykey = function_9dc96ef85325c7eb( side );
    waitdelay = 0.35;
    waitdelay -= ( level.players.size - 1 ) * 0.05;
    waitdelay = clamp( waitdelay, 0.2, 0.35 );
    
    /#
        level.ztron.waitdelay = waitdelay;
    #/
    
    while ( level utility::flag( "ztron_round_spawning" ) )
    {
        waitframe();
        
        if ( level utility::flag( "ztron_round_paused" ) || level.hostmigrationtimer )
        {
            continue;
        }
        
        if ( level.ztron.gatekeys & mykey && level.ztron.var_6fa31a82b13f7d9b > 0 )
        {
            spot = function_9b7bf2d5c866b74d( side );
            ai = arenaspawnai( spot, 1 );
            
            if ( isdefined( ai ) )
            {
                level.ztron.var_6fa31a82b13f7d9b--;
                wait waitdelay;
            }
        }
    }
}

// Namespace ztron_arena
// Params 0
// Checksum 0x3345f83b, Offset: 0xcd85
// Size: 0x31a
function function_a66946f774c9cea4()
{
    self notify( #"hash_58cffce9862bfbe4" );
    self endon( #"hash_58cffce9862bfbe4" );
    level endon( #"ztron_game_is_over", #"round_over" );
    level utility::flag_set( "ztron_round_spawning" );
    level utility::flag_clear( "ztron_round_over" );
    playercountadjust = ( level.players.size - 1 ) * level.ztron.var_e0421d5e75de6120;
    level.ztron.curkillcount = 0;
    
    if ( !isdefined( level.ztron.var_91517987ca332e2a ) )
    {
        level.ztron.var_91517987ca332e2a = 0;
    }
    
    level.ztron.var_6fa31a82b13f7d9b = level.ztron.var_e1fe5ec6a6e36bb7 + level.ztron.roundnumber * 10 + playercountadjust;
    hordemax = level.ztron.var_f3a1a68100ae3b6c + playercountadjust;
    
    if ( level.ztron.var_6fa31a82b13f7d9b > hordemax )
    {
        level.ztron.var_6fa31a82b13f7d9b = hordemax;
        level.ztron.var_ea55d63fdfb9014d = 1;
    }
    
    level.ztron.var_91517987ca332e2a = level.ztron.var_6fa31a82b13f7d9b;
    level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ] = 0;
    
    if ( isdefined( level.ztron.var_aa9e2c7ca33bc903 ) )
    {
        level thread [[ level.ztron.var_aa9e2c7ca33bc903 ]]();
    }
    
    level thread function_bf1d1ae5d9863498();
    level thread function_3a59352403d79a80();
    var_19e466ad77855bb5 = 1;
    
    if ( utility::flag( "ztron_challenge_round_spawning" ) )
    {
        level waittill( #"ztron_challenge_round_spawning" );
        var_19e466ad77855bb5 = level.ztron.game_laps > 0;
    }
    
    level notify( #"hash_37d3f74f5fcde156" );
    
    if ( var_19e466ad77855bb5 )
    {
        var_84e9c31fbaa384af = level.ztron.active_arena.var_84e9c31fbaa384af;
        
        /#
            if ( getdvarint( @"hash_14eebd6257ff6543", 0 ) != 0 )
            {
                var_84e9c31fbaa384af = getdvarint( @"hash_14eebd6257ff6543", 0 );
            }
        #/
        
        level thread function_3b188500516e4b48( var_84e9c31fbaa384af );
        
        /#
            if ( getdvarint( @"hash_b00af5d191b02721", 0 ) == 1 )
            {
                level thread function_3f8628858a7d6f76();
            }
        #/
        
        gatekeeper = function_dc88264180fc0c8c();
        level function_b571858e87ed5ad1( gatekeeper );
        level thread function_e50ffe943a15b3e0( "left" );
        level thread function_e50ffe943a15b3e0( "right" );
        level thread function_e50ffe943a15b3e0( "top" );
        level thread function_e50ffe943a15b3e0( "bottom" );
        level waittill( #"hash_54d22cbc6baa8cf8" );
    }
    
    level utility::flag_clear( "ztron_round_spawning" );
    wait 1;
}

// Namespace ztron_arena
// Params 0
// Checksum 0x253e7f4d, Offset: 0xd0a7
// Size: 0x122
function function_3f8628858a7d6f76()
{
    self notify( #"hash_d8e4cf12368e5044" );
    self endon( #"hash_d8e4cf12368e5044" );
    level endon( #"ztron_game_is_over", #"round_over", #"horde_defeated" );
    x = 1200;
    y = 1100;
    
    while ( true )
    {
        var_58bdd987d9009546 = "";
        
        if ( level.ztron.gatekeys & 1 )
        {
            var_58bdd987d9009546 += " TOP";
        }
        
        if ( level.ztron.gatekeys & 2 )
        {
            var_58bdd987d9009546 += " LEFT";
        }
        
        if ( level.ztron.gatekeys & 4 )
        {
            var_58bdd987d9009546 += " RIGHT";
        }
        
        if ( level.ztron.gatekeys & 8 )
        {
            var_58bdd987d9009546 += " BOTTOM";
        }
        
        ztron_debug::function_7a494955e7b24aa3( x, y, "GATES OPEN: " + var_58bdd987d9009546, ( 1, 1, 0 ), level.framedurationseconds, 2 );
        waitframe();
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0x1a848fe4, Offset: 0xd1d1
// Size: 0x89
function function_d2a08bf013133960( params )
{
    arenaindex = int( params[ 0 ] );
    
    /#
        logstring( "<dev string:x466>" + arenaindex );
    #/
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        level notify( #"slayer_round_abort" );
        level waittill( #"return_to_arena_logic" );
        waittillframeend();
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        /#
            ztron_bonus_room::function_cbdc7523e6d1f3b();
            wait 2;
        #/
    }
    
    if ( isdefined( arenaindex ) )
    {
        level notify( #"remove_papaback_intro" );
        thread changearena( arenaindex );
    }
}

// Namespace ztron_arena
// Params 1
// Checksum 0xe8545f2e, Offset: 0xd262
// Size: 0x13
function debug_end_round( params )
{
    function_6fc50167bb958c08();
}

/#

    // Namespace ztron_arena
    // Params 1
    // Checksum 0xdf6e40c0, Offset: 0xd27d
    // Size: 0x16, Type: dev
    function function_89a76c386a5f75a9( params )
    {
        ztron_util::killallenemies();
    }

    // Namespace ztron_arena
    // Params 1
    // Checksum 0xf72c7108, Offset: 0xd29b
    // Size: 0xa3, Type: dev
    function function_1caa69b7d41dd460( params )
    {
        zombies = getaiarray( level.players[ 0 ].team );
        
        foreach ( zombie in zombies )
        {
            zombie kill();
            waitframe();
        }
    }

    // Namespace ztron_arena
    // Params 1
    // Checksum 0xa0f77e87, Offset: 0xd346
    // Size: 0x1d6, Type: dev
    function function_bb7fbafd7891a010( params )
    {
        if ( !isdefined( level.ztron.active_arena ) )
        {
            return;
        }
        
        if ( isdefined( level.ztron.active_arena.exits ) )
        {
            foreach ( exitobj in level.ztron.active_arena.exits )
            {
                if ( isdefined( exitobj.var_8dbd63b14b4b0b40 ) )
                {
                    exitobj notify( #"trigger", level.players[ 0 ] );
                    return;
                }
            }
        }
        
        if ( isdefined( level.ztron.active_arena.teleportertrigger ) )
        {
            if ( !level.ztron.active_arena.teleportertrigger function_b0b72d20769d0233() )
            {
                return;
            }
            
            level notify( #"ztron_teleporter_taken" );
            return;
        }
        
        if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
        {
            if ( isdefined( level.ztron.var_8a9067aa4cd65369.exit ) )
            {
                level.ztron.var_8a9067aa4cd65369.exit notify( #"trigger", level.players[ 0 ] );
                return;
            }
            
            level.ztron.var_8a9067aa4cd65369 notify( #"room_done" );
            return;
        }
    }

    // Namespace ztron_arena
    // Params 0
    // Checksum 0x70f6a5c2, Offset: 0xd524
    // Size: 0xf8, Type: dev
    function function_ac7ee3673d6e340d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x499>" );
        devgui::add_devgui_func( "<dev string:x4a8>", "<dev string:x4b9>", &function_89a76c386a5f75a9 );
        devgui::add_devgui_func( "<dev string:x4d6>", "<dev string:x4f0>", &function_1caa69b7d41dd460 );
        devgui::add_devgui_func( "<dev string:x512>", "<dev string:x523>", &function_bb7fbafd7891a010 );
        function_8651e57d26929263();
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x542>" );
        devgui::add_devgui_func( "<dev string:x561>", "<dev string:x577>", &function_7ae8a1d0b4ac4e8a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x583>", "<dev string:x58e>", &function_1699487b66f13fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x598>", "<dev string:x5a3>", &function_1699487b66f13fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5ae>", "<dev string:x5b8>", &function_1699487b66f13fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5c1>", "<dev string:x5cb>", &function_1699487b66f13fb );
        devgui::add_devgui_func( "<dev string:x5d5>", "<dev string:x5eb>", &function_71d4257f72febccb );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_arena
    // Params 0
    // Checksum 0x6128bbac, Offset: 0xd624
    // Size: 0x22b, Type: dev
    function function_8651e57d26929263()
    {
        devgui::add_devgui_func( "<dev string:x5f8>", "<dev string:x607>", &ztron_hazard::debug_spawn_barrel );
        devgui::add_devgui_func( "<dev string:x61a>", "<dev string:x630>", &ztron_hazard::debug_spawn_pole );
        devgui::add_devgui_func( "<dev string:x641>", "<dev string:x655>", &ztron_hazard::function_675c8a21648c7594 );
        devgui::add_devgui_func( "<dev string:x66c>", "<dev string:x67d>", &ztron_hazard::debug_spawn_fireball );
        devgui::add_devgui_func( "<dev string:x692>", "<dev string:x6ab>", &ztron_hazard::function_980d15ef3eef7806 );
        devgui::add_devgui_func( "<dev string:x6c8>", "<dev string:x6dc>", &ztron_hazard::debug_spawn_dragonhead );
        devgui::add_devgui_func( "<dev string:x6f3>", "<dev string:x701>", &ztron_hazard::debug_spawn_pungi );
        devgui::add_devgui_func( "<dev string:x713>", "<dev string:x726>", &ztron_hazard::debug_spawn_lawn_mower );
        devgui::add_devgui_func( "<dev string:x73d>", "<dev string:x74d>", &ztron_hazard::debug_spawn_flogger );
        devgui::add_devgui_func( "<dev string:x761>", "<dev string:x771>", &ztron_hazard::function_71e123b58aaef93 );
        devgui::add_devgui_func( "<dev string:x785>", "<dev string:x795>", &ztron_hazard::debug_spawn_specter );
        devgui::add_devgui_func( "<dev string:x7a9>", "<dev string:x7ba>", &ztron_hazard::function_aec715fe33ce0ab5 );
        devgui::add_devgui_func( "<dev string:x7ce>", "<dev string:x7e0>", &ztron_hazard::debug_spawn_lava_pool );
        devgui::add_devgui_func( "<dev string:x7f6>", "<dev string:x814>", &ztron_hazard::function_bae82969d2609056 );
        devgui::add_devgui_func( "<dev string:x830>", "<dev string:x846>", &ztron_hazard::debug_spawn_enemy_spawner );
        devgui::add_devgui_func( "<dev string:x85f>", "<dev string:x877>", &ztron_hazard::debug_spawn_moving_platform );
        devgui::add_devgui_func( "<dev string:x893>", "<dev string:x8a6>", &ztron_hazard::debug_spawn_rats_horde );
        devgui::add_devgui_func( "<dev string:x8bd>", "<dev string:x8cb>", &ztron_hazard::debug_spawn_crate );
        devgui::add_devgui_func( "<dev string:x8dd>", "<dev string:x8ef>", &ztron_hazard::function_ed976f621141163b );
        devgui::add_devgui_func( "<dev string:x905>", "<dev string:x91b>", &ztron_hazard::debug_spawn_conveyor_belt );
        devgui::add_devgui_func( "<dev string:x935>", "<dev string:x947>", &ztron_hazard::debug_spawn_saw_blade );
        devgui::add_devgui_func( "<dev string:x95d>", "<dev string:x972>", &ztron_hazard::debug_spawn_aether_slate );
        devgui::add_devgui_func( "<dev string:x98b>", "<dev string:x9a1>", &ztron_hazard::debug_spawn_bump_mushroom );
        devgui::add_devgui_func( "<dev string:x9bb>", "<dev string:x9cf>", &ztron_hazard::debug_spawn_tornado );
        devgui::add_devgui_func( "<dev string:x9e3>", "<dev string:x9f3>", &ztron_hazard::debug_spawn_snowman );
    }

    // Namespace ztron_arena
    // Params 0
    // Checksum 0x41cf5ab0, Offset: 0xd857
    // Size: 0x62, Type: dev
    function function_71d4257f72febccb()
    {
        challenge = ztron_challenge::function_d013ebdd9c2ce720( level.ztron.active_arena.name );
        
        if ( isdefined( challenge ) )
        {
            challenge.istriggered = 0;
        }
        
        level thread changearena( level.ztron.currentarena );
    }

    // Namespace ztron_arena
    // Params 1
    // Checksum 0x3d956962, Offset: 0xd8c1
    // Size: 0x81, Type: dev
    function function_1699487b66f13fb( params )
    {
        amount = int( params[ 0 ] );
        var_84e9c31fbaa384af = getdvarint( @"hash_14eebd6257ff6543", 0 );
        
        if ( var_84e9c31fbaa384af == 0 )
        {
            var_84e9c31fbaa384af = level.ztron.active_arena.var_84e9c31fbaa384af;
        }
        
        var_84e9c31fbaa384af = int( clamp( var_84e9c31fbaa384af + amount, 0, 80 ) );
        setdvar( @"hash_14eebd6257ff6543", var_84e9c31fbaa384af );
    }

    // Namespace ztron_arena
    // Params 0
    // Checksum 0x621cd6c4, Offset: 0xd94a
    // Size: 0x7b, Type: dev
    function function_7ae8a1d0b4ac4e8a()
    {
        if ( level.ztron.dev.var_7ae8a1d0b4ac4e8a )
        {
            level.ztron.dev.var_7ae8a1d0b4ac4e8a = 0;
            level notify( #"hash_fc7f711ce07b462a" );
            return;
        }
        
        level.ztron.dev.var_7ae8a1d0b4ac4e8a = 1;
        level thread function_ec61e48c4c2a98ce();
    }

    // Namespace ztron_arena
    // Params 0
    // Checksum 0x50731041, Offset: 0xd9cd
    // Size: 0x12d, Type: dev
    function function_ec61e48c4c2a98ce()
    {
        self notify( #"hash_6ff57f124d3bebbf" );
        self endon( #"hash_6ff57f124d3bebbf" );
        level endon( #"ztron_game_is_over", #"hash_fc7f711ce07b462a" );
        
        while ( true )
        {
            if ( isdefined( level.ztron.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
            {
                var_84e9c31fbaa384af = getdvarint( @"hash_14eebd6257ff6543", 0 );
                
                if ( var_84e9c31fbaa384af == 0 )
                {
                    var_84e9c31fbaa384af = level.ztron.active_arena.var_84e9c31fbaa384af;
                }
                
                ztron_debug::function_7a494955e7b24aa3( 1400, 50, "<dev string:xa07>" + var_84e9c31fbaa384af + "<dev string:xa15>" + level.ztron.active_arena.var_ae48c1fd2b6e2299, ( 1, 1, 0 ), level.framedurationseconds, 3 );
                ztron_debug::function_7a494955e7b24aa3( 1400, 80, "<dev string:xa2d>" + level.ztron.zombies.size, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            }
            
            waitframe();
        }
    }

#/
