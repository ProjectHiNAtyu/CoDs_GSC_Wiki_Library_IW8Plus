// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon.gsc  (hash_46b6df3699787155.gscc) (size: 13998 Bytes / 0x36ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc81848d0 (3357034704)
// size ...... 13998 (0x36ae)
// includes .. 16  (offset: 0x33c6)
// strings ... 49  (offset: 0x3446)
// dev strs .. 1   (offset: 0x36a2)
// exports ... 13  (offset: 0x2946)
// cseg ...... 0x398 + 0x25ae (0x2946)
// imports ... 53  (offset: 0x2b4e)
// animtree1 . 0   (offset: 0x36ae)
// animtree2 . 0   (offset: 0x36ae)
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_avalon\gen\mp_saw_avalon_art;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_redeploy_parent_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_fx;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_lighting;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_mysteryboxes;
#using scripts\mp\poi;

#namespace mp_saw_avalon;

// Namespace mp_saw_avalon
// Params 0
// Checksum 0xfcf37f62, Offset: 0x3b6
// Size: 0x11e
function main()
{
    mp_saw_avalon_art::main();
    mp_saw_avalon_fx::main();
    mp_saw_avalon_lighting::main();
    
    if ( getdvarint( @"hash_5e2bfe296bd4d512", 1 ) )
    {
        level thread function_8b4c7ffa4faf9013();
    }
    
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_saw_avalon", undefined, 16 );
    game_utility::registerlargemap();
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread poi::poi_init();
    var_a61d552b4be4f88b = getdvar( @"hash_6a6394960e900221", "" );
    var_9848e4d2bc779aba = var_a61d552b4be4f88b == "" ? "mp_saw_avalon" : var_a61d552b4be4f88b;
    setgameprops( var_9848e4d2bc779aba );
    brinit();
    thread function_15ed81b2e75afb3();
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        thread function_7fe52693cf64d7e1();
    }
}

// Namespace mp_saw_avalon
// Params 0, eflags: 0x4
// Checksum 0x9070a1a6, Offset: 0x4dc
// Size: 0x26
function private function_7fe52693cf64d7e1()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1.5;
        
        if ( function_5ea8790daa2f7c36() )
        {
            break;
        }
    }
}

// Namespace mp_saw_avalon
// Params 0
// Checksum 0x8d8fdc4e, Offset: 0x50a
// Size: 0x94e
function brinit()
{
    br_anims::init();
    
    if ( !level.var_c8cb79f46406cf7c )
    {
        if ( getdvarint( @"hash_ec3624dc00480c76", 0 ) == 1 )
        {
            br::function_a4785bf1d05110c2();
        }
        else
        {
            level.br_level = spawnstruct();
            heightoverride = 19000;
            dvarheightoverride = getdvarint( @"scr_game_c130heightoverride", -1 );
            
            if ( dvarheightoverride != -1 )
            {
                heightoverride = dvarheightoverride;
            }
            
            br_c130::setc130heightoverrides( heightoverride, -200 );
            minx = min( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
            maxx = max( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
            miny = min( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
            maxy = max( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
            level.br_level.br_mapboundsfull = [];
            level.br_level.br_mapboundsfull[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapboundsfull[ 1 ] = ( minx, miny, 0 );
            level.br_level.br_mapbounds = [];
            level.br_level.br_mapbounds[ 0 ] = level.br_level.br_mapboundsfull[ 0 ];
            level.br_level.br_mapbounds[ 1 ] = level.br_level.br_mapboundsfull[ 1 ];
            level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
            level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride ) );
            level.br_level.br_circleclosetimes = [ 270, 220, 170, 110, 70, 50, 50, 100 ];
            level.br_level.br_circledelaytimes = [ 220, 90, 75, 60, 60, 45, 30, 0 ];
            level.br_level.br_circleshowdelaydanger = [ 220, 0, 0, 0, 0, 0, 0, 0 ];
            level.br_level.br_circleshowdelaysafe = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
            level.br_level.br_circleminimapradii = [ 10500, 10500, 10500, 10500, 10500, 10500, 10500, 10500 ];
            level.br_level.br_circleradii = [ 81600, 57300, 37500, 22200, 12300, 6000, 3000, 1500, 0 ];
            br_circle::function_cfdf3903125095d7();
            br_circle::applycirclesettings();
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    
    if ( isdefined( level.br_circle_init_func ) )
    {
        [[ level.br_circle_init_func ]]();
    }
    
    initprematchspawnlocations();
    level.var_256941f347945772 = [ br_circle::createinvalidcirclearea( ( 21652, -39944, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 26103, -40813, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 58161, -31518, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -12713, -46027, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -10000, -43900, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -14666, -44625, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -37716, -40278, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -51835, -17050, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -45428, -6689, 0 ), 700 ), br_circle::createinvalidcirclearea( ( -19516, 15246, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 39185, 11650, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 44839, 22872, 0 ), 1200 ), br_circle::createinvalidcirclearea( ( 43984, 27606, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 41758, 26760, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 46351, 27583, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 30238, 49825, 0 ), 700 ), br_circle::createinvalidcirclearea( ( 11207, -32397, 0 ), 700 ) ];
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 0 )
    {
        level.br_badcircleareas = [ br_circle::createinvalidcirclearea( ( 20223, -50919, 0 ), 12500 ), br_circle::createinvalidcirclearea( ( 842, 15000, 0 ), 12000 ), br_circle::createinvalidcirclearea( ( 15658, 11813, 0 ), 8000 ), br_circle::createinvalidcirclearea( ( 36137, -24000, 0 ), 4000 ), br_circle::createinvalidcirclearea( ( 41941, 13841, 0 ), 2000 ), br_circle::createinvalidcirclearea( ( -24788, -2041, 0 ), 2500 ), br_circle::createinvalidcirclearea( ( -43007, -24, 0 ), 2000 ), br_circle::createinvalidcirclearea( ( -45375, 2770, 0 ), 2750 ), br_circle::createinvalidcirclearea( ( -32450, -14917, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( -49575, -28387, 0 ), 7000 ), br_circle::createinvalidcirclearea( ( -39607, -47478, 0 ), 3000 ), br_circle::createinvalidcirclearea( ( -34798, -48573, 0 ), 3250 ), br_circle::createinvalidcirclearea( ( -30567, -54119, 0 ), 5000 ), br_circle::createinvalidcirclearea( ( -13412, -36284, 0 ), 2500 ), br_circle::createinvalidcirclearea( ( -15138, -33222, 0 ), 2000 ), br_circle::createinvalidcirclearea( ( 10, 20, 0 ), 5000 ), br_circle::createinvalidcirclearea( ( 11221, -31987, 0 ), 5500 ), br_circle::createinvalidcirclearea( ( 12263, -24543, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( 12392, -17557, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( 19310, -1419, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( 13757, -12148, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( 16566, -7172, 0 ), 3500 ), br_circle::createinvalidcirclearea( ( -10844, -10596, 0 ), 4500 ), br_circle::createinvalidcirclearea( ( -28855, -40427, 0 ), 4000 ) ];
    }
    
    utility::registersharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient", &function_3d4f802962c90d30 );
    utility::registersharedfunc( #"br_ending", #"get_ending_locations", &get_ending_locations );
    utility::registersharedfunc( #"br_infils", #"hash_dd6d580483cd15ca", &function_3855f5796f4d2b65 );
    
    if ( level.gametype == "bongo" )
    {
        mp_saw_avalon_bongo_redeploy_parent_cs::main();
        mp_saw_avalon_mysteryboxes::main();
    }
}

// Namespace mp_saw_avalon
// Params 1
// Checksum 0xb6cfcb5e, Offset: 0xe60
// Size: 0x16
function function_3855f5796f4d2b65( infilname )
{
    unloadinfiltransient( "mp_infil_br_avalon_saw_sat_s1_tr" );
}

// Namespace mp_saw_avalon
// Params 0
// Checksum 0xb3339d18, Offset: 0xe7e
// Size: 0x7
function function_3d4f802962c90d30()
{
    return "mp_infil_avalon_ending_saw_s1_tr";
}

// Namespace mp_saw_avalon
// Params 0, eflags: 0x4
// Checksum 0x26073e46, Offset: 0xe8e
// Size: 0x1a1
function private initprematchspawnlocations()
{
    level.br_prematchspawnlocations = [ br::createspawnlocation( ( 24629, 1787, 3240 ), 0, 7000 ), br::createspawnlocation( ( 23.17, -1244.16, 1097.55 ), 0, 7000 ), br::createspawnlocation( ( -17536, 6983, 1236 ), 0, 5000 ), br::createspawnlocation( ( -28695.8, 16141.9, 2241.41 ), 0, 5000 ), br::createspawnlocation( ( -44277.4, 12433.7, 1323.1 ), 0, 7000 ), br::createspawnlocation( ( -9620.38, 24314.8, 2370.98 ), 0, 7000 ), br::createspawnlocation( ( 50905, -38244.1, 2150.72 ), 0, 7000 ), br::createspawnlocation( ( 10402.3, -31963.7, 4428.23 ), 0, 5000 ), br::createspawnlocation( ( -16966.1, -44023, 335.668 ), 0, 5000 ), br::createspawnlocation( ( -27937, -28828, 1144 ), 0, 5000 ), br::createspawnlocation( ( -37269.8, -39032.4, 760.547 ), 0, 5000 ), br::createspawnlocation( ( 41972.7, 7138.85, 1203.25 ), 0, 4000 ), br::createspawnlocation( ( 44348.7, 23984.7, 1140.88 ), 0, 5000 ), br::createspawnlocation( ( 47158.1, -11139.2, 433.625 ), 0, 6000 ), br::createspawnlocation( ( 13778, 20809, 1948 ), 0, 5000 ) ];
}

// Namespace mp_saw_avalon
// Params 1
// Checksum 0x65b3e000, Offset: 0x1037
// Size: 0xe69
function get_ending_locations( exfiltype )
{
    structs = [];
    structs[ 0 ] = br_ending::create_struct( ( -46667.6, -38457.9, 60.7395 ), ( 0, -117.214, 0 ) );
    structs[ 1 ] = br_ending::create_struct( ( -36372.6, -49504.9, 199.938 ), ( 0, -173.302, 0 ) );
    structs[ 2 ] = br_ending::create_struct( ( -37564, -45601.2, 500.625 ), ( 0, 139.125, 0 ) );
    structs[ 3 ] = br_ending::create_struct( ( -31805.8, -56903, 728 ), ( 0, 173.538, 0 ) );
    structs[ 4 ] = br_ending::create_struct( ( -38460, -40322.5, 1039.75 ), ( 0, -116.662, 0 ) );
    structs[ 5 ] = br_ending::create_struct( ( -47979.1, -33226.2, 406 ), ( 0, 113.177, 0 ) );
    structs[ 6 ] = br_ending::create_struct( ( -30561.1, -53888.6, 608 ), ( 0, 7.22868, 0 ) );
    structs[ 7 ] = br_ending::create_struct( ( -39568.6, -37032.1, 1022.68 ), ( 0, 146.536, 0 ) );
    structs[ 8 ] = br_ending::create_struct( ( -36965.2, -37467.2, 1028 ), ( 0, 108.533, 0 ) );
    structs[ 9 ] = br_ending::create_struct( ( -44526.6, -27459.9, 82.0001 ), ( 0, 175.16, 0 ) );
    structs[ 10 ] = br_ending::create_struct( ( -24189.4, -49523, 303.5 ), ( 0, 175.773, 0 ) );
    structs[ 11 ] = br_ending::create_struct( ( -33322, -32839.1, 630 ), ( 0, 29.8072, 0 ) );
    structs[ 12 ] = br_ending::create_struct( ( -25218, -42164.3, 608 ), ( 0, -134.323, 0 ) );
    structs[ 13 ] = br_ending::create_struct( ( -50501.6, -16752.9, 368 ), ( 0, -115.393, 0 ) );
    structs[ 14 ] = br_ending::create_struct( ( -18359.3, -44076.1, 314.733 ), ( 0, 164.212, 0 ) );
    structs[ 15 ] = br_ending::create_struct( ( -18964, -37171.4, 534 ), ( 0, -116.553, 0 ) );
    structs[ 16 ] = br_ending::create_struct( ( -36620.7, -16382.3, 318.875 ), ( 0, -91.6737, 0 ) );
    structs[ 17 ] = br_ending::create_struct( ( -46646.4, -9962.07, 127.812 ), ( 0, 119.623, 0 ) );
    structs[ 18 ] = br_ending::create_struct( ( -10013.3, -42692.5, 720 ), ( 0, -21.2479, 0 ) );
    structs[ 19 ] = br_ending::create_struct( ( -24249.4, -20401.8, 964.951 ), ( 0, 42.2828, 0 ) );
    structs[ 20 ] = br_ending::create_struct( ( -26642.6, -14013.4, 364.568 ), ( 0, 57.0285, 0 ) );
    structs[ 21 ] = br_ending::create_struct( ( -58932.8, -2700.07, 525.715 ), ( 0, -67.2139, 0 ) );
    structs[ 22 ] = br_ending::create_struct( ( -52906.6, -2708.88, 240 ), ( 0, -138.485, 0 ) );
    structs[ 23 ] = br_ending::create_struct( ( -3045.71, -48780.8, 557.39 ), ( 0, -125.771, 0 ) );
    structs[ 24 ] = br_ending::create_struct( ( -41409.4, -4680.79, 128 ), ( 0, 15.8494, 0 ) );
    structs[ 25 ] = br_ending::create_struct( ( -2870.92, -39811.6, 916 ), ( 0, 163.977, 0 ) );
    structs[ 26 ] = br_ending::create_struct( ( -588.691, -32194.1, 433 ), ( 0, 106.982, 0 ) );
    structs[ 27 ] = br_ending::create_struct( ( 5050.11, -51405.7, 673 ), ( 0, 165.704, 0 ) );
    structs[ 28 ] = br_ending::create_struct( ( -52604.7, 5212.8, 357.438 ), ( 0, -95.2792, 0 ) );
    structs[ 29 ] = br_ending::create_struct( ( -38709.8, 4475.33, 48.25 ), ( 0, -149.432, 0 ) );
    structs[ 30 ] = br_ending::create_struct( ( -24920.2, -1834.47, 525 ), ( 0, 47.4388, 0 ) );
    structs[ 31 ] = br_ending::create_struct( ( -14508.6, -7313.46, 1856 ), ( 0, 144.825, 0 ) );
    structs[ 32 ] = br_ending::create_struct( ( 9950.91, -45981.4, 1293.9 ), ( 0, -126.431, 0 ) );
    structs[ 33 ] = br_ending::create_struct( ( 1011.13, -20601.5, 416 ), ( 0, -149.326, 0 ) );
    structs[ 34 ] = br_ending::create_struct( ( 9136.28, -35282.6, 4099 ), ( 0, 57.0206, 0 ) );
    structs[ 35 ] = br_ending::create_struct( ( -30112.3, 9422.95, 668 ), ( 0, -54.1083, 0 ) );
    structs[ 36 ] = br_ending::create_struct( ( -3035.41, -9805.08, 814.125 ), ( 0, 50.9023, 0 ) );
    structs[ 37 ] = br_ending::create_struct( ( -51234.2, 15950.3, 1145.85 ), ( 0, -136.431, 0 ) );
    structs[ 38 ] = br_ending::create_struct( ( -38344.9, 13892.3, 126.875 ), ( 0, -158.396, 0 ) );
    structs[ 39 ] = br_ending::create_struct( ( -38636.3, 14200.2, 126.875 ), ( 0, -130.725, 0 ) );
    structs[ 40 ] = br_ending::create_struct( ( -21719.1, 8035.55, 1792 ), ( 0, 111.164, 0 ) );
    structs[ 41 ] = br_ending::create_struct( ( 11955, -29735.9, 4309.28 ), ( 0, 129.565, 0 ) );
    structs[ 42 ] = br_ending::create_struct( ( -17323.3, 5565.28, 3816 ), ( 0, 51.2301, 0 ) );
    structs[ 43 ] = br_ending::create_struct( ( 16275.8, -40338.5, 1093.81 ), ( 0, -22.6202, 0 ) );
    structs[ 44 ] = br_ending::create_struct( ( -6734.48, 4448.86, 528 ), ( 0, 130.036, 0 ) );
    structs[ 45 ] = br_ending::create_struct( ( 13994.6, -13134.8, 3031.71 ), ( 0, 50.608, 0 ) );
    structs[ 46 ] = br_ending::create_struct( ( -14379, 17211.6, 1036.73 ), ( 0, -146.414, 0 ) );
    structs[ 47 ] = br_ending::create_struct( ( 30168.3, -50620.9, 1256 ), ( 0, -154.15, 0 ) );
    structs[ 48 ] = br_ending::create_struct( ( 9577.37, -784.967, 1008 ), ( 0, -142.217, 0 ) );
    structs[ 49 ] = br_ending::create_struct( ( -42136.8, 30394.6, 1757 ), ( 0, -63.2046, 0 ) );
    structs[ 50 ] = br_ending::create_struct( ( 4372.68, 8929.65, 85.125 ), ( 0, 125.355, 0 ) );
    structs[ 51 ] = br_ending::create_struct( ( 32582.4, -36685.9, 1087.75 ), ( 0, -119.609, 0 ) );
    structs[ 52 ] = br_ending::create_struct( ( 35795, -48414.2, 207.875 ), ( 0, 116.332, 0 ) );
    structs[ 53 ] = br_ending::create_struct( ( 30146.9, -24584.2, 239.75 ), ( 0, 48.9292, 0 ) );
    structs[ 54 ] = br_ending::create_struct( ( -22341.5, 29402, 2303.07 ), ( 0, 116.909, 0 ) );
    structs[ 55 ] = br_ending::create_struct( ( -5430.13, 21485, 566 ), ( 0, 148.811, 0 ) );
    structs[ 56 ] = br_ending::create_struct( ( 27511.5, -14021.4, 642.812 ), ( 0, -137.64, 0 ) );
    structs[ 57 ] = br_ending::create_struct( ( -7924.56, 26613.6, 1336 ), ( 0, 53.1208, 0 ) );
    structs[ 58 ] = br_ending::create_struct( ( 40385.8, -42847.5, 710.969 ), ( 0, 102.002, 0 ) );
    structs[ 59 ] = br_ending::create_struct( ( -12864.5, 30647.2, 599.801 ), ( 0, -57.1265, 0 ) );
    structs[ 60 ] = br_ending::create_struct( ( 2539.93, 22288.6, 163.827 ), ( 0, 135.465, 0 ) );
    structs[ 61 ] = br_ending::create_struct( ( -29866, 39054.2, 1718.56 ), ( 0, 21.9865, 0 ) );
    structs[ 62 ] = br_ending::create_struct( ( 20871.3, 6687.01, 1364.3 ), ( 0, 71.7628, 0 ) );
    structs[ 63 ] = br_ending::create_struct( ( -35880.5, 42838.4, 2264.48 ), ( 0, -103.423, 0 ) );
    structs[ 64 ] = br_ending::create_struct( ( 40665.1, -27139.1, 448 ), ( 0, 20.0105, 0 ) );
    structs[ 65 ] = br_ending::create_struct( ( 10306.1, 21166.4, 2362 ), ( 0, 54.8308, 0 ) );
    structs[ 66 ] = br_ending::create_struct( ( 47863.5, -51206.8, 490.257 ), ( 0, -116.506, 0 ) );
    structs[ 67 ] = br_ending::create_struct( ( -18805.8, 42288.5, 1455.06 ), ( 0, 38.1667, 0 ) );
    structs[ 68 ] = br_ending::create_struct( ( 34971.1, -2748.41, 1232 ), ( 0, 30.0608, 0 ) );
    structs[ 69 ] = br_ending::create_struct( ( 40925.8, -11645.3, 309 ), ( 0, 77.6175, 0 ) );
    structs[ 70 ] = br_ending::create_struct( ( 2141.78, 33122.5, 1094.13 ), ( 0, 36.0366, 0 ) );
    structs[ 71 ] = br_ending::create_struct( ( -28957.5, 47616.5, 2416 ), ( 0, -66.1283, 0 ) );
    structs[ 72 ] = br_ending::create_struct( ( 19440, 19253.5, 814 ), ( 0, -178.448, 0 ) );
    structs[ 73 ] = br_ending::create_struct( ( 51457, -44307.3, 2051.99 ), ( 0, -6.12496, 0 ) );
    structs[ 74 ] = br_ending::create_struct( ( 29162.2, 9875.79, 1237 ), ( 0, 93.6085, 0 ) );
    structs[ 75 ] = br_ending::create_struct( ( 53508.6, -35652.9, 1985.61 ), ( 0, 26.4008, 0 ) );
    structs[ 76 ] = br_ending::create_struct( ( 49207.7, -19412.2, 629.787 ), ( 0, 19.0889, 0 ) );
    structs[ 77 ] = br_ending::create_struct( ( 22542.3, 22610.6, 944 ), ( 0, -144.079, 0 ) );
    structs[ 78 ] = br_ending::create_struct( ( 30007, 16575, 1429.37 ), ( 0, -170.141, 0 ) );
    structs[ 79 ] = br_ending::create_struct( ( -8796.99, 46567.5, 172 ), ( 0, -21.9946, 0 ) );
    structs[ 80 ] = br_ending::create_struct( ( -4829.1, 45444.3, 288 ), ( 0, -159.094, 0 ) );
    structs[ 81 ] = br_ending::create_struct( ( 44467.3, -2744.74, 1232 ), ( 0, 136.083, 0 ) );
    structs[ 82 ] = br_ending::create_struct( ( 14540.5, 33610.3, 2000 ), ( 0, -102.264, 0 ) );
    structs[ 83 ] = br_ending::create_struct( ( -25110.2, 54886.8, 2675.31 ), ( 0, -137.087, 0 ) );
    structs[ 84 ] = br_ending::create_struct( ( 41989.9, 9796.52, 1112.25 ), ( 0, 91.0498, 0 ) );
    structs[ 85 ] = br_ending::create_struct( ( 61081, -26133.5, 2453.61 ), ( 0, 17.1853, 0 ) );
    structs[ 86 ] = br_ending::create_struct( ( 10748.4, 44768.2, 714 ), ( 0, 57.6365, 0 ) );
    structs[ 87 ] = br_ending::create_struct( ( -6716.42, 56899.7, 479.033 ), ( 0, -91.7364, 0 ) );
    structs[ 88 ] = br_ending::create_struct( ( 59695.6, -12651.7, 2151.77 ), ( 0, 91.7892, 0 ) );
    structs[ 89 ] = br_ending::create_struct( ( 40384.1, 21452.7, 847.5 ), ( 0, -33.6518, 0 ) );
    structs[ 90 ] = br_ending::create_struct( ( 55607.1, -1728.23, 1339.48 ), ( 0, 30.5504, 0 ) );
    structs[ 91 ] = br_ending::create_struct( ( 51151.8, 10359.6, 1266.86 ), ( 0, 128.385, 0 ) );
    structs[ 92 ] = br_ending::create_struct( ( 19799, 46734.6, 1070 ), ( 0, -87.51, 0 ) );
    structs[ 93 ] = br_ending::create_struct( ( 15538.8, 58082.6, 959.3 ), ( 0, -66.1179, 0 ) );
    structs[ 94 ] = br_ending::create_struct( ( 38212.3, 40415.4, 2031 ), ( 0, -40.3432, 0 ) );
    structs[ 95 ] = br_ending::create_struct( ( 49468.4, 31818.4, 864.055 ), ( 0, 25.2555, 0 ) );
    structs[ 96 ] = br_ending::create_struct( ( 32606.4, 50386.3, 1349.62 ), ( 0, 123.253, 0 ) );
    structs[ 97 ] = br_ending::create_struct( ( 45753.1, 40468.3, 1945.67 ), ( 0, -2.90599, 0 ) );
    structs[ 98 ] = br_ending::create_struct( ( 24964.9, 59939.2, 1394.34 ), ( 0, -81.9915, 0 ) );
    return structs;
}

// Namespace mp_saw_avalon
// Params 0
// Checksum 0xeee09d33, Offset: 0x1ea9
// Size: 0x638
function function_15ed81b2e75afb3()
{
    if ( getdvarint( @"hash_6979a78a1820ac18", 0 ) != 0 )
    {
        return;
    }
    
    level waittill( #"prematch_started" );
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    fwd_ang = level.br_ac130.angles;
    fwd_ang += ( 0, -90, 0 );
    floatingnames = [];
    floatingnames[ 0 ] = { #z:3000, #y:12032, #x:-38448, #displayname:"stadium" };
    floatingnames[ 1 ] = { #z:4000, #y:2560, #x:-15360, #displayname:"high_town" };
    floatingnames[ 2 ] = { #z:3000, #y:-1024, #x:-1024, #displayname:"low_town" };
    floatingnames[ 3 ] = { #z:3000, #y:-12288, #x:-39996, #displayname:"coast_guard" };
    floatingnames[ 4 ] = { #z:3500, #y:-30208, #x:-28160, #displayname:"firing_range" };
    floatingnames[ 5 ] = { #z:3000, #y:-42496, #x:-20992, #displayname:"listening_post" };
    floatingnames[ 6 ] = { #z:3000, #y:-39936, #x:-36864, #displayname:"fort" };
    floatingnames[ 7 ] = { #z:3000, #y:-48384, #x:3840, #displayname:"boat_chopshop" };
    floatingnames[ 8 ] = { #z:3000, #y:-20480, #x:-1024, #displayname:"apartments" };
    floatingnames[ 9 ] = { #z:3000, #y:-22016, #x:30208, #displayname:"heliport" };
    floatingnames[ 10 ] = { #z:3000, #y:-10752, #x:46080, #displayname:"water_treatment" };
    floatingnames[ 11 ] = { #z:3500, #y:25088, #x:-9472, #displayname:"casino" };
    floatingnames[ 12 ] = { #z:3500, #y:35840, #x:-33792, #displayname:"golf_club" };
    floatingnames[ 13 ] = { #z:3000, #y:46080, #x:-9728, #displayname:"residences" };
    floatingnames[ 14 ] = { #z:3000, #y:45046, #x:15360, #displayname:"winery" };
    floatingnames[ 15 ] = { #z:5500, #y:28160, #x:30720, #displayname:"dig_site" };
    floatingnames[ 16 ] = { #z:3500, #y:23552, #x:44544, #displayname:"colosseum" };
    floatingnames[ 17 ] = { #z:4500, #y:19456, #x:11776, #displayname:"resorts" };
    floatingnames[ 18 ] = { #z:3000, #y:8192, #x:43008, #displayname:"cliff_town" };
    floatingnames[ 19 ] = { #z:4000, #y:-37888, #x:51712, #displayname:"car_factory" };
    floatingnames[ 20 ] = { #z:3000, #y:-51712, #x:27136, #displayname:"old_arsenal" };
    isbongo = game_utility::getgametype() == "bongo";
    
    if ( isbongo )
    {
        level thread function_4570b5b01c19735b( floatingnames );
    }
    
    foreach ( floatingname in floatingnames )
    {
        poiname = poi::poi_findpoioriginisin( ( floatingname.x, floatingname.y, floatingname.z ) );
        isHot = level.poi[ poiname ][ "isHot" ];
        
        if ( isbongo )
        {
            assert( !isHot, "<dev string:x24>" );
            var_adac35bf32a6bb6f = "sat_tag_origin_name_fx_avalon_bongo";
        }
        else
        {
            var_adac35bf32a6bb6f = isHot ? "sat_tag_origin_name_fx_avalon_hotzone" : "sat_tag_origin_name_fx_avalon";
        }
        
        level thread function_c074953abc4ec497( floatingname, fwd_ang, var_adac35bf32a6bb6f );
    }
    
    level thread function_235fe628e6fd770e( floatingnames );
}

// Namespace mp_saw_avalon
// Params 3
// Checksum 0x6ecc765c, Offset: 0x24e9
// Size: 0x9f
function function_c074953abc4ec497( floatingname, fwd_ang, var_1763c7b77f896e53 )
{
    name_fx_scriptable = spawn( "script_model", ( floatingname.x, floatingname.y, floatingname.z ) );
    name_fx_scriptable setmodel( var_1763c7b77f896e53 );
    name_fx_scriptable.angles = fwd_ang;
    floatingname.scriptable = name_fx_scriptable;
    wait 0.1;
    name_fx_scriptable setscriptablepartstate( "name_fx", floatingname.displayname );
    name_fx_scriptable forcenetfieldhighlod( 1 );
}

// Namespace mp_saw_avalon
// Params 1
// Checksum 0x61fd6d68, Offset: 0x2590
// Size: 0x1e3
function function_4570b5b01c19735b( floatingnames )
{
    level endon( #"hash_1c918d0a4ce43118" );
    wait 3;
    
    foreach ( vfx in level.name_fx )
    {
        vfx.var_53dc781474a3f55d = 2147483647;
        vfx.var_b5021fc52c9d884 = 0;
    }
    
    var_ff2d375bfa19274 = 0;
    
    while ( var_ff2d375bfa19274 < floatingnames.size )
    {
        foreach ( floatingname in floatingnames )
        {
            vfx = floatingname.scriptable;
            
            if ( isdefined( vfx ) && !vfx.var_b5021fc52c9d884 )
            {
                var_7269f1972a9311d0 = distancesquared( vfx.origin, level.br_ac130.origin );
                
                if ( var_7269f1972a9311d0 < 2025000000 || var_7269f1972a9311d0 > vfx.var_53dc781474a3f55d )
                {
                    vfx.var_b5021fc52c9d884 = 1;
                    var_ff2d375bfa19274++;
                    vfxname = vfx getscriptablepartstate( "name_fx" );
                    vfx setscriptablepartstate( "name_fx", vfxname + "_redaction" );
                    continue;
                }
                
                vfx.var_53dc781474a3f55d = var_7269f1972a9311d0;
            }
        }
        
        wait 0.1;
    }
}

// Namespace mp_saw_avalon
// Params 1
// Checksum 0xae353f0c, Offset: 0x277b
// Size: 0x94
function function_235fe628e6fd770e( floatingnames )
{
    wait 120;
    level notify( #"hash_1c918d0a4ce43118" );
    
    foreach ( floatingname in floatingnames )
    {
        floatingname.scriptable delete();
    }
}

// Namespace mp_saw_avalon
// Params 0
// Checksum 0xa864376f, Offset: 0x2817
// Size: 0x12f
function function_8b4c7ffa4faf9013()
{
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    transmitters = getentitylessscriptablearray( "scriptable_t10_electronics_control_panel_button_01", #classname );
    
    foreach ( transmitter in transmitters )
    {
        transmitter setscriptablepartstate( "arcwire_transmitter", "disabled" );
        
        foreach ( receiver in getentitylessscriptablearray( transmitter.target, #targetname ) )
        {
            receiver notify( #"activate" );
        }
    }
}

