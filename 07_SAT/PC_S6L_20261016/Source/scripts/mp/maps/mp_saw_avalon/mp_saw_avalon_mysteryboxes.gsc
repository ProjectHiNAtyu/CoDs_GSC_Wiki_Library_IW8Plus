// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_mysteryboxes.gsc  (hash_27a1a78f3c0e642e.gscc) (size: 8445 Bytes / 0x20fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d24e99d (1562700189)
// size ...... 8445 (0x20fd)
// includes .. 3   (offset: 0x1f1d)
// strings ... 3   (offset: 0x1f35)
// dev strs .. 0   (offset: 0x20fd)
// exports ... 9   (offset: 0x1b85)
// cseg ...... 0x93 + 0x1af2 (0x1b85)
// imports ... 20  (offset: 0x1ced)
// animtree1 . 0   (offset: 0x20fd)
// animtree2 . 0   (offset: 0x20fd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_mysteryboxes;

// Namespace mp_saw_avalon_mysteryboxes
// Params 0, eflags: 0x5
// Checksum 0xa78899f5, Offset: 0xb1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_mysteryboxes", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 0, eflags: 0x4
// Checksum 0x87dd893a, Offset: 0xd2
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 0, eflags: 0x4
// Checksum 0x2e65ad6, Offset: 0xe3
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 2
// Checksum 0xb20f0c9f, Offset: 0xf4
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_mysteryboxes" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_mysteryboxes" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_mysteryboxes" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_mysteryboxes" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 3, eflags: 0x4
// Checksum 0x8164ee19, Offset: 0x17c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_mysteryboxes" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_mysteryboxes" );
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 3, eflags: 0x4
// Checksum 0x4f1a7b8f, Offset: 0x1f6
// Size: 0x196f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 43741.3, -52922.2, 613.66 ), ( 0, 180.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 53448, -53705.8, 868.38 ), ( 0, 44.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 52260.8, -39927.5, 2168 ), ( 0, 134.8, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 58193.5, -31339.6, 2265.05 ), ( 0, 349, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 29150, -24012, 255 ), ( 0, 93.8, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 56836, -24284, 2431.74 ), ( 0, 74.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 47748, -36700, 2012 ), ( 0, 44.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 60560.5, -39427, 2525.5 ), ( 0, 118.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 40027.2, -44310.2, 733 ), ( 0, 138.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 34893.5, -38556.5, 1103 ), ( 0, 271.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 37856, -32356, 650.21 ), ( 0, 217.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 34006.5, -49508.2, 225.18 ), ( 0, 42.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 41120, -25360, 527 ), ( 0, 326.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 41628.8, -27766, 274.17 ), ( 0, 182.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 28862, -36286, 258 ), ( 0, 180, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 26770, -35840, 256 ), ( 0, 90, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 43280.8, -10844.8, 327.76 ), ( 0, 344.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 25592, -50830, 222 ), ( 0, 40.8, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 23082, -56132, 96.01 ), ( 0, 300.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 28176, -54416, 96.21 ), ( 0, 220.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 30880, -51008, 1272 ), ( 0, 310.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 29340, -54768, 89.6 ), ( 0, 311.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 20636, -57252, 48 ), ( 0, 16, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 21248, -53520, 96.23 ), ( 0, 309.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 27092, -48084, 224 ), ( 0, 42.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 50700.8, -10307.8, 463.38 ), ( 0, 1.8, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 20324, -35940, 515 ), ( 0, 350.8, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 48150, -7745.25, 462.31 ), ( 0, 50.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 22830, -21612, 394.15 ), ( 0, 61.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 30772, -20178, 264 ), ( 0, 326, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 33480, -11570, 232.07 ), ( 0, 270, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 28036, -12462, 307.17 ), ( 0, 48.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 4502.5, -2815, 567.44 ), ( 0, 233, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -95, -1057, 496 ), ( 0, 13.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -4292.5, 2230.5, 552 ), ( 0, 85.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 34562.5, -2823.5, 1248 ), ( 0, 0.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 28688.5, -5763.5, 255.58 ), ( 0, 74.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 27432.5, 9040.5, 1310.38 ), ( 0, 84.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 29224.5, 14580.5, 848.85 ), ( 0, 211.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 20601.5, 20514.5, 661.89 ), ( 0, 211.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 8988.5, 18930.5, 270 ), ( 0, 269, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 12952.5, 23130.5, 590.77 ), ( 0, 133.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -1271.5, 5838.5, 78 ), ( 0, 165.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 15975.5, 33873.5, 2011.22 ), ( 0, 270.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 11849.5, 44595.5, 729.16 ), ( 0, 330.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 19152.5, 39881.5, 1183.3 ), ( 0, 350.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 18510.5, 48187.5, 832 ), ( 0, 10.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 7154.5, 39595.5, 726.59 ), ( 0, 339.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 4968.5, 54843.5, 899.22 ), ( 0, 90.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 1960.5, 52315.5, 633.4 ), ( 0, 84, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 31440.5, 49602.5, 1364.57 ), ( 0, 246.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 30719.5, 26765.5, 3061.87 ), ( 0, 55.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 41869, 9550, 1128.25 ), ( 0, 143.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 39514, 7469, 1080 ), ( 0, 143.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 47194, 10061, 666.5 ), ( 0, 96.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 55992.5, 18743.8, 481.4 ), ( 0, 248.99, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 53120.5, 19987.8, 414.96 ), ( 0, 40.19, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 44686.5, 23895.2, 689.89 ), ( 0, 190.39, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 40503.5, 26458.2, 854.08 ), ( 0, 231.39, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 50551, 27641.7, 1061.9 ), ( 0, 311.59, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 43423.5, 35009.9, 1368.34 ), ( 0, 315.29, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 2948, -27524, 1406 ), ( 0, 66.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 11844.5, -30871.8, 4122.48 ), ( 0, 55.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 2516, -44961.3, 120.96 ), ( 0, 275.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -21730, -40910.7, 408 ), ( 0, 99.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -27986, -29703.3, 906.01 ), ( 0, 320.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -38144, -39293.3, 912 ), ( 0, 180.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -30860, -55505.3, 490 ), ( 0, 238, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -15042, -21671.3, 228.59 ), ( 0, 178.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -4780, -29342.7, 260 ), ( 0, 359.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -535.3, -19634, 192 ), ( 0, 89.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 6764.45, -9756, 1986 ), ( 0, 242.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 16249.2, -9125.75, 3476.84 ), ( 0, 65.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -44629, -27548.3, 98 ), ( 0, 330.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -50789, -17468.3, 367.37 ), ( 0, 89.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -52707, -1265.3, 256 ), ( 0, 150.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -41646.8, -11145.5, 151.85 ), ( 0, 142.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -52873, 6818.7, 368 ), ( 0, 305.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -14195.5, -1115, 1188.95 ), ( 0, 7.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -15767.5, 7301, 1057.25 ), ( 0, 142.4, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -13127.5, 16813, 1008 ), ( 0, 169.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -10834.5, 25521, 464 ), ( 0, 129.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -8806.5, 41223, 286 ), ( 0, 220.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -4539, 45770.5, 304.86 ), ( 0, 130.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -14292, 50592.5, 577.86 ), ( 0, 11, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -7253, 51010.5, 351 ), ( 0, 349.1, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -19023, 42180, 1471.07 ), ( 0, 126.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -25988.2, 50437, 1854.47 ), ( 0, 257.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 1792.5, 30587.5, 1038.85 ), ( 0, 89.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -24050, -13767.3, 1359.06 ), ( 0, 91.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -34343, 11862.7, 433 ), ( 0, 269.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -29063, 19625.2, 1669.7 ), ( 0, 294.7, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -25799, 24649.2, 1962.73 ), ( 0, 12.2, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -33591, 34505.2, 1931.94 ), ( 0, 43.9, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -44187, 12774.7, 401 ), ( 0, 269.3, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -41915, 29808.2, 1606 ), ( 0, 159.29, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( -32747, 25152.2, 1715.42 ), ( 0, 186.89, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 12883.5, 5391.5, 269.96 ), ( 0, 278.6, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_mysteryboxes";
    fe [[ f ]]( s, us, cf, ( 21244.2, 15469.2, 276 ), ( 0, 275.5, 0 ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 0, eflags: 0x4
// Checksum 0x6b0bae8e, Offset: 0x1b6d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_mysteryboxes
// Params 0
// Checksum 0x43373354, Offset: 0x1b77
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_mysteryboxes" );
}

