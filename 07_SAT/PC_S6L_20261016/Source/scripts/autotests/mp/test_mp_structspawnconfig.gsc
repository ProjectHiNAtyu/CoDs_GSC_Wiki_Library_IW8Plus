// scripts\autotests\mp\test_mp_structspawnconfig.gsc  (hash_137f5b0c60207888.gscc) (size: 10303 Bytes / 0x283f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0aaafe4 (2963976164)
// size ...... 10303 (0x283f)
// includes .. 6   (offset: 0x2633)
// strings ... 23  (offset: 0x2663)
// dev strs .. 0   (offset: 0x283f)
// exports ... 25  (offset: 0x19ff)
// cseg ...... 0x3cd + 0x1632 (0x19ff)
// imports ... 52  (offset: 0x1de7)
// animtree1 . 0   (offset: 0x283f)
// animtree2 . 0   (offset: 0x283f)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\structspawnconfig;

#namespace test_mp_structspawnconfig;

// Namespace test_mp_structspawnconfig/testautomation
// Params 0, eflags: 0x20
// Checksum 0x6fa84eda, Offset: 0x3eb
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_structspawnconfig.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_structspawnconfig
// Params 0
// Checksum 0xb370203c, Offset: 0x419
// Size: 0x3a0, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 30 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Minimum distance SSC spawn logic ran successfully?" );
    test_result_int = function_b8a5185989aa6ec6() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Minimum distance SSC spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 32 );
    autotests::pop_function( "Minimum distance SSC spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Minimum distance SSC spawn logic ran poorly successfully?" );
    test_result_int = function_785f00b9e2d26aca() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Minimum distance SSC spawn logic ran poorly successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 33 );
    autotests::pop_function( "Minimum distance SSC spawn logic ran poorly successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Maximum distance SSC spawn logic ran successfully??" );
    test_result_int = function_6b6ef728efb38efc() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Maximum distance SSC spawn logic ran successfully??", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 34 );
    autotests::pop_function( "Maximum distance SSC spawn logic ran successfully??" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn count SSC spawn logic ran meh successfully?" );
    test_result_int = function_7a75ab42887f31ee() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn count SSC spawn logic ran meh successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 35 );
    autotests::pop_function( "Spawn count SSC spawn logic ran meh successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn count SSC spawn logic ran successfully?" );
    test_result_int = function_d726463c8509a841() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn count SSC spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 36 );
    autotests::pop_function( "Spawn count SSC spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn count only maximum SSC spawn logic ran successfully?" );
    test_result_int = function_46bf48a4edec5d49() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn count only maximum SSC spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 37 );
    autotests::pop_function( "Spawn count only maximum SSC spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn count force min SSC spawn logic ran successfully?" );
    test_result_int = function_76e74f443e34956c() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn count force min SSC spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 38 );
    autotests::pop_function( "Spawn count force min SSC spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Force spawns spawn logic ran successfully?" );
    test_result_int = function_33d3d2fff6b7fac7() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Force spawns spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 39 );
    autotests::pop_function( "Force spawns spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Force blocks spawn logic ran successfully?" );
    test_result_int = function_af3fea9861b53655() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Force blocks spawn logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 40 );
    autotests::pop_function( "Force blocks spawn logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn all spawn logic successfully?" );
    test_result_int = test_spawn_all() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn all spawn logic successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 41 );
    autotests::pop_function( "Spawn all spawn logic successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Multiple ssc parameters spawn logic ran poorly successfully?" );
    test_result_int = function_775ec980f9b5524c() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Multiple ssc parameters spawn logic ran poorly successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 42 );
    autotests::pop_function( "Multiple ssc parameters spawn logic ran poorly successfully?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Spawn flags logic ran successfully?" );
    test_result_int = test_spawn_flags() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Spawn flags logic ran successfully?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 43 );
    autotests::pop_function( "Spawn flags logic ran successfully?" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xea1c1fe9, Offset: 0x7c2
// Size: 0x1dc
function private setup()
{
    autotests_utility::setup();
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 54 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    vehicleref = level.projectbundle.var_53c4124af039142e ? getxhashasset( self.bundle.structspawnconfigvehicle ) : vehicle::function_451bd53633bae879( self.bundle.structspawnconfigvehicle );
    level.autotests.test_runtime.vehicleref = vehicleref;
    vehicletype = vehicle_spawn::get_vehicle_asset( vehicleref );
    vehiclehash = getxhashasset( vehicletype );
    level.autotests.test_runtime.vehiclehash = vehiclehash;
    level.autotests.test_runtime.var_1203f9795300b943 = level.ssc.var_1203f9795300b943[ vehicleref ];
    level.autotests.test_runtime.var_2baf370af79db528 = level.ssc.var_2baf370af79db528[ vehicleref ];
    level.autotests.test_runtime.funcgetlocations = level.ssc.funcgetlocations[ vehicleref ];
    structspawnconfig::function_8c0a09968efe9138( vehicleref, &on_spawn_single );
    structspawnconfig::function_36050499b5f48983( vehicleref, &on_spawn_complete );
    structspawnconfig::function_7418a260adaec05( vehicleref, &get_spawn_locations );
    return 1;
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xf02334ce, Offset: 0x9a7
// Size: 0x159
function private cleanup()
{
    autotests_utility::cleanup();
    function_c4781504391f61db();
    vehicleref = level.autotests.test_runtime.vehicleref;
    structspawnconfig::function_8c0a09968efe9138( vehicleref, level.autotests.test_runtime.var_1203f9795300b943 );
    structspawnconfig::function_36050499b5f48983( vehicleref, level.autotests.test_runtime.var_2baf370af79db528 );
    structspawnconfig::function_7418a260adaec05( vehicleref, level.autotests.test_runtime.funcgetlocations );
    level.autotests.test_runtime.vehicleref = undefined;
    level.autotests.test_runtime.var_1203f9795300b943 = undefined;
    level.autotests.test_runtime.var_2baf370af79db528 = undefined;
    level.autotests.test_runtime.funcgetlocations = undefined;
    level.autotests.test_runtime.vehicleref = undefined;
    level.autotests.test_runtime.vehiclehash = undefined;
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x248ebdf2, Offset: 0xb08
// Size: 0xae
function private function_b8a5185989aa6ec6()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_6cd2597c1e9eb3b3 = 5;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2800, 0 ) );
    create_spawn_struct( ( 0, 3600, 0 ) );
    create_spawn_struct( ( 0, 4000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 3 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xe7a693ad, Offset: 0xbbe
// Size: 0xae
function private function_785f00b9e2d26aca()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_6cd2597c1e9eb3b3 = 5;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2600, 0 ) );
    create_spawn_struct( ( 0, 3600, 0 ) );
    create_spawn_struct( ( 0, 4000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 1 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x67b04d75, Offset: 0xc74
// Size: 0xae
function private function_6b6ef728efb38efc()
{
    config = function_c6e0b52ac763a109();
    config.var_715b2669956e715b = 999;
    config.var_6cd2597c1e9eb3b3 = 5;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    create_spawn_struct( ( 0, 3500, 0 ) );
    create_spawn_struct( ( 0, 4500, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 2 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x4f9d2aa, Offset: 0xd2a
// Size: 0x9e
function private function_7a75ab42887f31ee()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_6cd2597c1e9eb3b3 = 3;
    config.var_e5ec4086fe7f1be5 = 5;
    
    for ( index = 0; index < config.var_e5ec4086fe7f1be5 + 3 ; index++ )
    {
        create_spawn_struct( ( 0, config.var_b32905ce7447fd * index, 0 ) );
    }
    
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( config.var_6cd2597c1e9eb3b3 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xaa6aa57e, Offset: 0xdd0
// Size: 0x90
function private function_d726463c8509a841()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_6cd2597c1e9eb3b3 = 5;
    
    for ( index = 0; index < config.var_6cd2597c1e9eb3b3 + 3 ; index++ )
    {
        create_spawn_struct( ( 0, config.var_b32905ce7447fd * index, 0 ) );
    }
    
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( config.var_6cd2597c1e9eb3b3 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x573e4a5d, Offset: 0xe68
// Size: 0x86
function private function_46bf48a4edec5d49()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_e5ec4086fe7f1be5 = 5;
    
    for ( index = 0; index < config.var_e5ec4086fe7f1be5 + 3 ; index++ )
    {
        create_spawn_struct( ( 0, config.var_b32905ce7447fd * index, 0 ) );
    }
    
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 0 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xcb85b21b, Offset: 0xef6
// Size: 0xd9
function private function_76e74f443e34956c()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_6cd2597c1e9eb3b3 = 5;
    config.var_5dce8d5b724a09ce = 1;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 3500, 0 ) );
    create_spawn_struct( ( 0, 4500, 0 ) );
    create_spawn_struct( ( 0, 5500, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( config.var_6cd2597c1e9eb3b3 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x98cf4ee1, Offset: 0xfd7
// Size: 0x11d
function private function_33d3d2fff6b7fac7()
{
    config = function_c6e0b52ac763a109();
    config.var_b32905ce7447fd = 1000;
    config.var_715b2669956e715b = 1001;
    config.var_6cd2597c1e9eb3b3 = 0;
    config.var_e5ec4086fe7f1be5 = 0;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    create_spawn_struct( ( 0, 3000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 0 );
    autotests_utility::flag_clear( "spawnComplete" );
    config.force_spawn_list = [ { #spawn_number:2 }, { #spawn_number:5 } ];
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( config.force_spawn_list.size );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x8d8e1b76, Offset: 0x10fc
// Size: 0x135
function private function_af3fea9861b53655()
{
    config = function_c6e0b52ac763a109();
    config.var_6cd2597c1e9eb3b3 = 5;
    config.var_e5ec4086fe7f1be5 = 5;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    create_spawn_struct( ( 0, 3000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 5 );
    autotests_utility::flag_clear( "spawnComplete" );
    level.autotests.test_runtime.spawnedstructs = undefined;
    config.force_block_list = [ { #spawn_number:1 }, { #spawn_number:2 }, { #spawn_number:3 }, { #spawn_number:5 } ];
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 1 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xd33eb3ac, Offset: 0x1239
// Size: 0xbc
function private test_spawn_all()
{
    config = function_c6e0b52ac763a109();
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    create_spawn_struct( ( 0, 3000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 0 );
    autotests_utility::flag_clear( "spawnComplete" );
    config.spawn_all = 1;
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 5 );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x8bc6e291, Offset: 0x12fd
// Size: 0x153
function private function_775ec980f9b5524c()
{
    config = function_c6e0b52ac763a109();
    config.var_6cd2597c1e9eb3b3 = 3;
    config.var_e5ec4086fe7f1be5 = 4;
    config.var_b32905ce7447fd = 500;
    config.var_715b2669956e715b = 1000;
    config.force_spawn_list = [ { #spawn_number:6 }, { #spawn_number:7 } ];
    config.force_block_list = [ { #spawn_number:1 } ];
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    create_spawn_struct( ( 0, 3000, 0 ) );
    create_spawn_struct( ( 0, 50000, 0 ) );
    create_spawn_struct( ( 0, 125000, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( config.var_6cd2597c1e9eb3b3 + config.force_spawn_list.size );
    function_c4781504391f61db();
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x898f4d90, Offset: 0x1458
// Size: 0x113
function private test_spawn_flags()
{
    config = function_c6e0b52ac763a109();
    config.spawn_all = 1;
    create_spawn_struct( ( 0, 1000, 0 ) );
    create_spawn_struct( ( 0, 1500, 0 ) );
    create_spawn_struct( ( 0, 2000, 0 ) );
    create_spawn_struct( ( 0, 2500, 0 ) );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 4 );
    autotests_utility::flag_clear( "spawnComplete" );
    level.autotests.test_runtime.spawnedstructs = undefined;
    structs = level.struct_class_names[ "vehicletype" ][ level.autotests.test_runtime.vehiclehash ];
    structs[ 0 ] vehicle_spawn::set_flag( 1, 1 );
    structs[ 2 ] vehicle_spawn::set_flag( 1, 1 );
    structspawnconfig::function_c23b46dea4f3bf15( config );
    test_spawns_spawned( 2 );
}

// Namespace test_mp_structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xc9eaa35b, Offset: 0x1573
// Size: 0x24b
function private test_spawns_spawned( var_b8608fb692fe910a )
{
    msg = autotests_utility::flag_wait_or_timeout( "spawnComplete", 10 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spawning completed?", msg != "timeout", "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 383 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    vehicleref = level.autotests.test_runtime.vehicleref;
    vehiclehash = level.autotests.test_runtime.vehiclehash;
    structspawns = level.struct_class_names[ "vehicletype" ][ vehiclehash ];
    spawnedstructs = level.autotests.test_runtime.spawnedstructs[ vehicleref ];
    spawnedcount = 0;
    
    foreach ( spawnedstruct in spawnedstructs )
    {
        foreach ( structspawn in structspawns )
        {
            if ( structspawn.origin == spawnedstruct.origin && structspawn.vehicletype == spawnedstruct.vehicletype )
            {
                spawnedcount++;
                break;
            }
        }
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Correct number of spawns: " + var_b8608fb692fe910a, var_b8608fb692fe910a, spawnedcount, "scripts/autotests/mp/test_mp_structspawnconfig.gsc", 403 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x22bdd4a0, Offset: 0x17c6
// Size: 0x55
function private create_spawn_struct( position )
{
    if ( !isdefined( level.struct_class_names ) )
    {
        level.struct_class_names = [];
    }
    
    vehicleref = level.autotests.test_runtime.vehicleref;
    vehicle_spawn::add_spawn_struct( vehicleref, position );
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x82a80428, Offset: 0x1823
// Size: 0x15
function private function_c4781504391f61db()
{
    clear_spawn_structs();
    autotests_utility::flag_clear( "spawnComplete" );
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x2972c6dd, Offset: 0x1840
// Size: 0xb1
function private clear_spawn_structs()
{
    vehicleref = level.autotests.test_runtime.vehicleref;
    vehiclehash = level.autotests.test_runtime.vehiclehash;
    level.vehicle_spawns[ vehicleref ] = undefined;
    level.struct_class_names[ "script_vehiclebundle" ][ vehicleref ] = undefined;
    level.struct_class_names[ "script_vehicleref" ][ vehicleref ] = undefined;
    level.struct_class_names[ "vehicletype" ][ vehiclehash ] = undefined;
    level.autotests.test_runtime.spawnedstructs = undefined;
}

// Namespace test_mp_structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xa9cd95f1, Offset: 0x18f9
// Size: 0x4d
function private function_c6e0b52ac763a109()
{
    return { #debug_icon:"hud_icon_vehicle_atv", #debug_color:( 234, 219, 55 ), #script_struct:level.autotests.test_runtime.vehicleref };
}

// Namespace test_mp_structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xf5abab9e, Offset: 0x194f
// Size: 0x6f
function private on_spawn_single( scriptstruct, mapstruct )
{
    spawnedstructs = level.autotests.test_runtime.spawnedstructs[ scriptstruct ] ?? [];
    spawnedstructs[ spawnedstructs.size ] = mapstruct;
    level.autotests.test_runtime.spawnedstructs[ scriptstruct ] = spawnedstructs;
    return {};
}

// Namespace test_mp_structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xae9944f, Offset: 0x19c7
// Size: 0x18
function private on_spawn_complete( scriptstruct )
{
    autotests_utility::flag_set( "spawnComplete" );
}

// Namespace test_mp_structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x34997caa, Offset: 0x19e7
// Size: 0x17
function private get_spawn_locations( scriptstruct )
{
    return vehicle_spawn::get_spawn_structs( scriptstruct, undefined, undefined, 0 );
}

