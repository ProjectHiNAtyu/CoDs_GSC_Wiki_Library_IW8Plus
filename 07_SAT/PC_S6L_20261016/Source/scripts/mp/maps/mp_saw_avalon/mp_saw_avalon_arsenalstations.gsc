// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_arsenalstations.gsc  (hash_1d6bc6dfdecbfb69.gscc) (size: 14395 Bytes / 0x383b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49c360bb (1237541051)
// size ...... 14395 (0x383b)
// includes .. 3   (offset: 0x30e7)
// strings ... 5   (offset: 0x30ff)
// dev strs .. 0   (offset: 0x383b)
// exports ... 9   (offset: 0x2d4f)
// cseg ...... 0xb8 + 0x2c97 (0x2d4f)
// imports ... 20  (offset: 0x2eb7)
// animtree1 . 0   (offset: 0x383b)
// animtree2 . 0   (offset: 0x383b)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_arsenalstations;

// Namespace mp_saw_avalon_arsenalstations
// Params 0, eflags: 0x5
// Checksum 0x28e0d891, Offset: 0xd6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_arsenalstations", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_arsenalstations
// Params 0, eflags: 0x4
// Checksum 0x6d083ae1, Offset: 0xf7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_arsenalstations
// Params 0, eflags: 0x4
// Checksum 0xe833e90d, Offset: 0x108
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_arsenalstations
// Params 2
// Checksum 0x58dabf44, Offset: 0x119
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_arsenalstations" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_arsenalstations" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_arsenalstations" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_arsenalstations" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_arsenalstations
// Params 3, eflags: 0x4
// Checksum 0x6bb15dc2, Offset: 0x1a1
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_arsenalstations" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_arsenalstations" );
}

// Namespace mp_saw_avalon_arsenalstations
// Params 3, eflags: 0x4
// Checksum 0x6dbc791, Offset: 0x21b
// Size: 0x2b14
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 28423, -36268, 256 ), ( 0, 0, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 53564, -40977, 2052.83 ), ( 359.97, 135, -0.01 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 54170, -36666, 1991 ), ( 0, 45, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 2262.25, -46820.1, 49.22 ), ( 0, 333.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 59768, -16118, 2601 ), ( 0, 81.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 49635, -11501, 460.99 ), ( 0, 271.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -7019.27, 53091.4, 309.25 ), ( 0, 76.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 34923, 38090, 2951.5 ), ( 0, 100.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11027.7, 42674.3, 713.88 ), ( 0, 79.2, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 38673, 40251, 1895 ), ( 0, 315, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 39450, -27231.7, 258.21 ), ( 0, 331.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 3415.04, 50262.4, 527.66 ), ( 0, 264.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 35773.8, -38897.1, 1091.65 ), ( 0, 90, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 31756, 44593, 1181 ), ( 0, 353.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 22064, 55230, 709 ), ( 0, 60.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 19371, 57135, 961 ), ( 0, 181.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 31219.4, 49840.7, 1354.43 ), ( 0, 218.59, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 18259, 45225, 824 ), ( 0, 55, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11606, 50078, 633.89 ), ( 0, 201.2, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 21935, 41182, 992 ), ( 0, 80.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 18653.3, 49645.4, 824 ), ( 0, 10.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 16885, 42573, 825.81 ), ( 0, 245.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -21366.2, -42120.7, 361.21 ), ( 0, 100.8, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 7620, 53540, 736 ), ( 0, 86.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 19625.8, 18818.3, 645.9 ), ( 0, 317.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -49394, -15517.8, 106 ), ( 0, 196, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 6659, 39284, 712 ), ( 0, 340.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -26345, 53989, 2680 ), ( 0, 9.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 26999.3, -52589.6, 84.81 ), ( 0, 129.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 20472.5, -37424.6, 449 ), ( 0, 107.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -28672, 52126, 2696 ), ( 0, 241, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -21475.2, 52795.5, 1889.81 ), ( 0, 295, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -43181.3, -27477.2, 92 ), ( 0, 330.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 40374.6, -43929.6, 757 ), ( 0, 136, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 28122.6, -13787.6, 296 ), ( 0, 49.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 3333.92, -1129.37, 521 ), ( 0, 330.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 14507.9, 34208.8, 2000 ), ( 0, 270.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -28102, 42055, 1751 ), ( 0, 284.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 36858.3, -3207.67, 1232 ), ( 0, 90.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 28977, 9611.96, 1239.83 ), ( 0, 84.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 28361.5, -22873.3, 239 ), ( 0, 147.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11337.2, 17750.3, 126 ), ( 0, 290.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -29400, 38468, 1717.56 ), ( 0, 239.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -28940, 34380, 1665.3 ), ( 0, 60.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -35875, 33233, 1571 ), ( 0, 315, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 60058.9, -39566, 2512.63 ), ( 0, 43.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 29009.3, 27960.8, 3200.44 ), ( 0, 200.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -31307, 30250, 1694.84 ), ( 0, 236.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 57701.1, -24593.3, 2424.55 ), ( 0, 255, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -3992.03, 8627.28, 78 ), ( 0, 254.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -32219, 25489, 1714.5 ), ( 0, 274.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 27596.6, 14164.2, 850.13 ), ( 0, 2.2, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -5459.7, 2216.32, 536 ), ( 0, 196.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 47514.6, -36955.5, 1995 ), ( 0, 134, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 44204.6, -10401.3, 309.7 ), ( 0, 1.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 41976.7, 7781.43, 1146.45 ), ( 0, 231.2, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -42010, 30512, 1597 ), ( 0, 339.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 47048.2, 12285.6, 622 ), ( 0, 276.8, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 54917.9, 18341.5, 433.73 ), ( 0, 146.49, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -46857, 19948, 723.67 ), ( 0, 351.8, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 43620.3, 23600.2, 673.89 ), ( 0, 60.79, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 38396.7, 27758.4, 1016 ), ( 0, 321.39, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 51173.5, 28542.2, 1047.25 ), ( 0, 41.59, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 43099.8, 33556.7, 1345.73 ), ( 0, 315.29, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -29505, 9003, 348 ), ( 0, 180, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11893.9, -28915.5, 4051.94 ), ( 0, 29, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -29811.8, -30897.7, 918.5 ), ( 0, 230.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -36739, 12447, 97 ), ( 359.97, 180, -0.01 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -41343, 15446, 416 ), ( 0, 315, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -38764.6, -41856.9, 733.86 ), ( 0, 270.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -43770.9, 9385.74, 272 ), ( 0, 89.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -15430.2, -23483.4, 547.1 ), ( 0, 88.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -14541.2, 12668.8, 1116 ), ( 0, 185, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 2944.09, -19633, 468 ), ( 0, 0.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -38462, 8134, 928 ), ( 0, 360, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 16024.5, -6458.92, 3228 ), ( 0, 317.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -50243, 1673.4, 270.42 ), ( 0, 152.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -44929, 16858, 241 ), ( 0, 274.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -52939, 7437.93, 352 ), ( 0, 354.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -41750.6, -11835.9, 128 ), ( 0, 142.5, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -54898, -1421, 238.95 ), ( 0, 332.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -30411.6, -53831.2, 304 ), ( 0, 0.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -14458.8, 3448.9, 1013.17 ), ( 0, 223.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -12560, 27335.9, 448 ), ( 0, 219.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -1377.02, -31782.2, 288.75 ), ( 0, 236.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -6800.54, 42394.9, 87.07 ), ( 0, 44.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -47754.8, -9186.23, 127.98 ), ( 0, 45.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -14738.3, 51991.1, 567.46 ), ( 0, 89.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -16822.3, 44052.8, 1195.07 ), ( 0, 124.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -25952.4, 48063.8, 1684.43 ), ( 0, 74.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 1803.27, 33009.5, 1093.13 ), ( 0, 252.2, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -23571.2, -15200.8, 898.01 ), ( 8.43, 42.1, 8.29 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -43599.2, -5762.2, 129.75 ), ( 0, 305.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -30703.1, 16548.1, 1064.04 ), ( 0, 186.21, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -21818.9, 27633.3, 2239.9 ), ( 0, 68.09, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -34432.2, 37445.5, 1918 ), ( 0, 314.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -31700, -4950, 554.39 ), ( 0, 225, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -37235.3, 24981.5, 1800.96 ), ( 0, 91.59, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11985.4, 8143.57, 32.25 ), ( 0, 89.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -28215, -10123, 135.25 ), ( 0, 353.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -32564, -18235.5, 468.5 ), ( 0, 270, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 43561.4, -52220.3, 597.68 ), ( 0, 90.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -32168, -23109, 771 ), ( 0, 86, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -26210, -21236, 976 ), ( 0, 77.1, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -16599, -28704, 204 ), ( 0, 164, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -25693, -34581, 775.5 ), ( 0, 330, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -34992, -37857, 692 ), ( 359.97, 270, -0.01 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -40808, -38115, 908.01 ), ( 0, 135, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -10061, -42877, 720 ), ( 0, 238.3, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 20329, -56548, 32 ), ( 0, 196.06, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 52876, -52827, 875 ), ( 0, 133.08, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 58277, -31568, 2250 ), ( 0, 347.76, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 42813, -24363, 321 ), ( 0, 198.13, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 43146, -15962, 622 ), ( 0, 2.12, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 572, -53581, 1224 ), ( 0, 24.65, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -1617, -44029, 695.46 ), ( 0, 138.09, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -3820, -47661, 808 ), ( 0, 305.09, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 9002, -50927, 1032.42 ), ( 0, 186.95, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 4511, -51505, 673 ), ( 0, 293.51, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 5246, -47787, 104 ), ( 0, 147.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 5741, -44569, 258 ), ( 0, 230.06, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 8736, -39187, 1023.12 ), ( 10.09, 259.87, -0.95 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 9766.68, -38344.9, 2805.53 ), ( 0, 288.07, -2.26 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 3423, -27793, 1385 ), ( 0, 66.6, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11686, -24435, 3803.45 ), ( 353.86, 357.8, -0.11 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 13597, -15676, 3476 ), ( 0, 270, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 23999.1, -20478.3, 345.7 ), ( 359.6, 262.09, -0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 33844, -11349, 222.93 ), ( 358.57, 226.07, -2.44 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 27134, -3284, 493.86 ), ( 3.28, 306.69, -0.74 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 8179, -9807, 1970 ), ( 0, 242, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -14452, -5174, 835.5 ), ( 0, 63.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 3248, 7430, 95 ), ( 0, 254.7, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -3455, -5575, 433 ), ( 0, 360, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -18883, 9858, 1201 ), ( 359.68, 90, -0.09 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -9138, 25355.7, 768 ), ( 0, 40.97, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -4972, 21545, 566 ), ( 0, 163.19, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -9522, 29407, 640 ), ( 0, 129.9, -0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -13170, 23457, 616 ), ( 0, 39.99, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( -9033, 20302, 572.69 ), ( 0.59, 126.93, 0.08 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11857, 22667, 612 ), ( 0, 270, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 11779, 21073, 2360 ), ( 0, 0, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 4416, 22855, 510.94 ), ( 360, 77, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 22188, 15486, 260 ), ( 0, 184.4, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 49130, 24211, 789 ), ( 0, 98.9, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 45706, 19230, 18 ), ( 359.98, 188.9, -1.02 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 32961, 26892, 3080 ), ( 0, 204.78, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 30941, 25370, 3083 ), ( 0, 204.37, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_arsenalstations";
    fe [[ f ]]( s, us, cf, ( 28916.6, 31520.1, 3072 ), ( 0, 293.92, 0 ), "buy_station", undefined, "arsenal_station", undefined, undefined, undefined, undefined, 1000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_arsenalstations
// Params 0, eflags: 0x4
// Checksum 0x181b0743, Offset: 0x2d37
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_arsenalstations
// Params 0
// Checksum 0xa9e2808f, Offset: 0x2d41
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_arsenalstations" );
}

