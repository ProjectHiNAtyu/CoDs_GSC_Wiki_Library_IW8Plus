// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_br.gsc  (hash_5f0b748cfaa498d4.gscc) (size: 21198 Bytes / 0x52ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3d03b43 (3016768323)
// size ...... 21198 (0x52ce)
// includes .. 19  (offset: 0x4f6e)
// strings ... 55  (offset: 0x5006)
// dev strs .. 2   (offset: 0x52b6)
// exports ... 19  (offset: 0x3fba)
// cseg ...... 0x46a + 0x3b50 (0x3fba)
// imports ... 65  (offset: 0x42b2)
// animtree1 . 0   (offset: 0x52ce)
// animtree2 . 0   (offset: 0x52ce)
#using script_4a7080e904a6380e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_bunker_alt;
#using scripts\mp\br\gametypes\br_bunker_loot_vaults;
#using scripts\mp\br\gametypes\br_bunker_numberstation;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_movingtrain;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\maps\mp_wz2_sierra\mp_wz2_sierra_light;
#using scripts\mp\maps\mp_wz2_sierra\mp_wz2_sierra_moving_train;
#using scripts\mp\poi;

#namespace mp_saw_sierra_br;

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0xcb324f9a, Offset: 0x488
// Size: 0x87
function init()
{
    brinit();
    level.outofboundstriggersplanetrace = getentarray( "OutOfBounds", #targetname );
    
    if ( br_public::function_9dc52a7da56f6544() )
    {
        level thread mp_wz2_sierra_moving_train::main();
        level thread br_movingtrain::init();
    }
    
    if ( getdvarint( @"scr_sierra_sidequest_enabled", 1 ) == 0 )
    {
        function_533c435e089eac1c();
    }
    
    level thread br_bunker_utility::init();
    level thread br_bunker_loot_vaults::init();
    level thread br_bunker_alt::init();
    level thread br_bunker_numberstation::init();
    level thread init_sierra_challenges();
    namespace_26f4b54362df6ddb::init();
}

// Namespace mp_saw_sierra_br
// Params 0, eflags: 0x4
// Checksum 0xf368681d, Offset: 0x517
// Size: 0xd06
function private brinit()
{
    setdvarifuninitialized( @"hash_183efaf41e5dc7a6", 1 );
    
    if ( !level.var_c8cb79f46406cf7c )
    {
        if ( getdvarint( @"hash_ec3624dc00480c76", 0 ) == 1 )
        {
            br::function_a4785bf1d05110c2();
        }
        else
        {
            level.br_level = spawnstruct();
            level.br_level.br_corners = [];
            level.br_level.br_corners[ 0 ] = ( -45772, -57416, -96 );
            level.br_level.br_corners[ 1 ] = ( 54412, 49920, -450 );
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
            minx = level.mapcorners[ 0 ].origin[ 0 ] * 0.8;
            maxx = level.mapcorners[ 1 ].origin[ 0 ] * 0.8;
            miny = level.mapcorners[ 1 ].origin[ 1 ] * 0.8;
            maxy = level.mapcorners[ 0 ].origin[ 1 ] * 0.8;
            level.br_level.br_mapbounds = [];
            level.br_level.br_mapbounds[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapbounds[ 1 ] = ( minx, miny, 0 );
            level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
            level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride ) );
            level.br_level.var_cd92896f34e2d8ef = -1450;
            level.br_level.var_7dd04763bfd623c1 = 5000;
            br_circle::function_cfdf3903125095d7();
            br_circle::applycirclesettings();
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    level thread function_51abc721712b72ce();
    br_anims::init();
    var_a61d552b4be4f88b = getdvar( @"hash_6a6394960e900221", "" );
    
    if ( var_a61d552b4be4f88b != "" )
    {
        setgameprops( var_a61d552b4be4f88b );
    }
    else
    {
        setgameprops( "mp_wz2_sierra_br" );
    }
    
    level thread function_d4996fa725daae21();
    
    if ( isdefined( level.br_circle_init_func ) )
    {
        [[ level.br_circle_init_func ]]();
    }
    
    if ( game_utility::getgametype() == "zonecontrol" )
    {
        level.br_prematchspawnlocations = [ br::createspawnlocation( ( 41412, 23770, -567 ), 0, 6000 ) ];
    }
    else if ( level.brgametype.resurgencepoi_name == "stadium" )
    {
        level.br_prematchspawnlocations = [ br::createspawnlocation( ( 28731, 2292, 1828 ), 0, 7500 ) ];
    }
    else
    {
        level.br_prematchspawnlocations = [ br::createspawnlocation( ( -27000, -10000, 10 ), 0, 6000 ), br::createspawnlocation( ( -25000, 7300, -262 ), 0, 5500 ), br::createspawnlocation( ( -12600, -14000, -249 ), 0, 5500 ), br::createspawnlocation( ( -22000, 21000, -358 ), 0, 6000 ), br::createspawnlocation( ( -9000, 18000, 4 ), 0, 5000 ), br::createspawnlocation( ( 15000, 14200, 212 ), 500, 5500 ), br::createspawnlocation( ( 23000, -15000, -158 ), 0, 6000 ), br::createspawnlocation( ( 36200, -26500, -507 ), 0, 6000 ), br::createspawnlocation( ( 51000, -39000, 1401 ), 0, 4000 ), br::createspawnlocation( ( 50000, -17000, -295 ), 0, 6000 ), br::createspawnlocation( ( 50200, 3500, 86 ), 0, 5500 ), br::createspawnlocation( ( 32000, 40000, 767 ), 0, 5500 ), br::createspawnlocation( ( 6000, 51000, 1094 ), 0, 6000 ), br::createspawnlocation( ( -21500, 46200, -300 ), 0, 6000 ), br::createspawnlocation( ( -14000, 7800, -334 ), 0, 5000 ), br::createspawnlocation( ( -19500, -30000, 152 ), 0, 6000 ), br::createspawnlocation( ( 8375, -11000, -222 ), 0, 5500 ) ];
    }
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 0 )
    {
        level.br_badcircleareas = [];
        
        if ( getdvarint( @"hash_ed57d7255825317f", 0 ) )
        {
            var_9f0fd47e959e375 = utility::getstructarray( "badCircle", "script_noteworthy" );
            
            foreach ( badcircle in var_9f0fd47e959e375 )
            {
                level.br_badcircleareas[ level.br_badcircleareas.size ] = br_circle::createinvalidcirclearea( badcircle.origin, badcircle.radius );
            }
        }
        else
        {
            level.br_badcircleareas[ level.br_badcircleareas.size ] = br_circle::createinvalidcirclearea( ( 57236, 40042, 3699 ), 10000 );
        }
        
        if ( getdvarint( @"hash_c46966958baa838b", 0 ) )
        {
            level.br_badcircleareas[ level.br_badcircleareas.size ] = br_circle::createinvalidcirclearea( ( 20026, -15191, -334 ), 1600 );
        }
    }
    
    level.var_256941f347945772 = [ br_circle::createinvalidcirclearea( ( 29730, 38282, 2255 ), 250 ), br_circle::createinvalidcirclearea( ( -280, -11909, 1142 ), 200 ), br_circle::createinvalidcirclearea( ( 52118, -23621, 870 ), 450 ), br_circle::createinvalidcirclearea( ( 50153, -24236, 873 ), 150 ), br_circle::createinvalidcirclearea( ( 56264, -17511, 440 ), 150 ), br_circle::createinvalidcirclearea( ( 56455, -17084, 587 ), 150 ), br_circle::createinvalidcirclearea( ( 52419, -19248, 198 ), 300 ), br_circle::createinvalidcirclearea( ( 45490, -8874, 1190 ), 150 ), br_circle::createinvalidcirclearea( ( 45631, -7928, 1076 ), 150 ), br_circle::createinvalidcirclearea( ( 46655, -8630, 967 ), 150 ), br_circle::createinvalidcirclearea( ( 48338, -7177, 993 ), 950 ), br_circle::createinvalidcirclearea( ( 42754, -4882, 1196 ), 350 ), br_circle::createinvalidcirclearea( ( 43343, -3393, 1202 ), 350 ), br_circle::createinvalidcirclearea( ( 44936, -3179, 1117 ), 350 ), br_circle::createinvalidcirclearea( ( -3199, 44147, 3947 ), 600 ), br_circle::createinvalidcirclearea( ( 40031, 23287, 135 ), 150 ), br_circle::createinvalidcirclearea( ( 40072, 14292, 345 ), 500 ), br_circle::createinvalidcirclearea( ( 38183, 27863, 639 ), 250 ), br_circle::createinvalidcirclearea( ( 38045, 29019, 1102 ), 150 ), br_circle::createinvalidcirclearea( ( 39599, 30971, 815 ), 150 ), br_circle::createinvalidcirclearea( ( 40115, 31764, 741 ), 350 ), br_circle::createinvalidcirclearea( ( 20755, 32945, 1929 ), 250 ), br_circle::createinvalidcirclearea( ( 33664, 31278, 1403 ), 150 ), br_circle::createinvalidcirclearea( ( 27531, 35802, 2174 ), 500 ), br_circle::createinvalidcirclearea( ( 31412, 40687, 2491 ), 300 ), br_circle::createinvalidcirclearea( ( 5652, 51883, 1929 ), 300 ), br_circle::createinvalidcirclearea( ( 1957, 55429, 1683 ), 350 ), br_circle::createinvalidcirclearea( ( -838, 53862, 1683 ), 350 ), br_circle::createinvalidcirclearea( ( 24615, -14769, 984 ), 600 ), br_circle::createinvalidcirclearea( ( 10234, -23678, 1700 ), 750 ), br_circle::createinvalidcirclearea( ( -18315, -38515, 2635 ), 350 ), br_circle::createinvalidcirclearea( ( -33986, -25465, 409 ), 450 ), br_circle::createinvalidcirclearea( ( -24218, -14040, 669 ), 800 ), br_circle::createinvalidcirclearea( ( -22567, 48915, 3404 ), 2800 ), br_circle::createinvalidcirclearea( ( -22468, 27304, 2102 ), 550 ), br_circle::createinvalidcirclearea( ( 20026, -15191, -334 ), 1600 ), br_circle::createinvalidcirclearea( ( 19946, -11673, -334 ), 200 ), br_circle::createinvalidcirclearea( ( 19874, -18537, -334 ), 200 ) ];
    utility::registersharedfunc( #"hash_c2ceeb7db51f540e", #"get_exfil_transient", &function_71113f18c12781d1 );
    utility::registersharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient", &function_b220085f7115890c );
    utility::registersharedfunc( #"br_ending", #"get_ending_locations", &get_ending_locations );
    utility::registersharedfunc( #"br_infils", #"hash_dd6d580483cd15ca", &function_3855f5796f4d2b65 );
    utility::registersharedfunc( #"br_infils", #"hash_f3c68636c0e494a1", &function_be334704d96df6b0 );
    utility::registersharedfunc( #"br_flyover", #"getflyoverscriptbundlename", &getflyoverscriptbundlename );
    multicircleconfiglist = getdvar( @"scr_br_multi_circle_config_list", "" );
    
    if ( multicircleconfiglist == "" )
    {
        setdvar( @"scr_br_multi_circle_config_list", "wz_multicircleconfig_mp_wz2_sierra_list" );
    }
    
    function_4d222771fe441b5a();
    activatelocation = utility::getstruct( "br_bot_activate_location", "script_noteworthy" );
    var_7dc27bc9fa62c763 = activatelocation.origin ?? ( 45032, 48584, 336 );
    var_d094491947d7985 = ( 603, 2705, -300 );
    super_bot::function_71585fa0eb269a5f( var_7dc27bc9fa62c763, var_d094491947d7985 );
    utility::registersharedfunc( #"br_bunkers", #"hash_7df9a859177613d0", &function_6977e9dd370de349 );
    function_1c147aecd2dc1d1a();
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0xac1286e6, Offset: 0x1225
// Size: 0x9
function init_sierra_challenges()
{
    function_a9a1a1c8da6b020a();
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x75b8c905, Offset: 0x1236
// Size: 0x5e
function function_a9a1a1c8da6b020a()
{
    var_1bdd62487c20328d = ( 20173.4, -14936.8, 2308.11 );
    tower_volume_size = ( 2343.85, 2403.09, 3280.45 );
    tower_volume = spawn( "noent_volume_trigger_box", var_1bdd62487c20328d, 0, tower_volume_size, tower_volume_size );
    callback::add( "lootcache_looted", &sierra_cache_opened, tower_volume );
}

// Namespace mp_saw_sierra_br
// Params 2
// Checksum 0xd0c0b064, Offset: 0x129c
// Size: 0x34
function sierra_cache_opened( params, tower_volume )
{
    params.cacheinstance thread function_4e6a3ccfd87c235c( params.player, tower_volume );
}

// Namespace mp_saw_sierra_br
// Params 2
// Checksum 0x33a74be1, Offset: 0x12d8
// Size: 0x37
function function_4e6a3ccfd87c235c( player, tower_volume )
{
    if ( ispointinvolume( self.origin, tower_volume ) )
    {
        challenges::function_37e945722d6497f3( player, "overlook_loot_cache", 1 );
    }
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x2b9c6adf, Offset: 0x1317
// Size: 0x4f
function function_d4996fa725daae21()
{
    while ( !isstruct( level.br_circle ) )
    {
        waitframe();
    }
    
    waitframe();
    waittillframeend();
    assert( isstruct( level.br_circle ), "<dev string:x24>" + "<dev string:x4b>" );
    level.br_circle.var_bdb61cc517e4942d = 1;
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x3f3e9af, Offset: 0x136e
// Size: 0x8f
function function_4d222771fe441b5a()
{
    spots = [ ( 36173, 5142, -629 ), ( -18310, -701, -266 ), ( -1049, -28073, 81 ), ( 1065, 4494, 208 ), ( -5635, 5321, -271 ), ( 46606, -33732, 529 ), ( 28547, 1820, -664 ) ];
    super_bot::function_7af21960125481f9( spots );
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x4d446ec5, Offset: 0x1405
// Size: 0x7
function function_71113f18c12781d1()
{
    return "mp_infil_br_sierra_saw_s1_tr";
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0xb5f67ccf, Offset: 0x1415
// Size: 0x7
function function_b220085f7115890c()
{
    return "mp_infil_sierra_ending_saw_s1_tr";
}

// Namespace mp_saw_sierra_br
// Params 1
// Checksum 0x3be51722, Offset: 0x1425
// Size: 0x2668
function get_ending_locations( exfiltype )
{
    structs = [];
    
    if ( exfiltype == "cer_s3" || exfiltype == "" || !isdefined( exfiltype ) )
    {
        structs[ 0 ] = br_ending::create_struct( ( -35516, -26964, -290.492 ), ( 0, -37.2493, 0 ) );
        structs[ 1 ] = br_ending::create_struct( ( -24507.4, -31751.5, -118 ), ( 0, 24.7373, 0 ) );
        structs[ 2 ] = br_ending::create_struct( ( -18286.1, -38430.7, 2620.06 ), ( 0, 162.098, 0 ) );
        structs[ 3 ] = br_ending::create_struct( ( -22962.6, -26693.8, -130 ), ( 0, -79.9927, 0 ) );
        structs[ 4 ] = br_ending::create_struct( ( -21665.5, -27275.8, -140 ), ( 0, -36.6941, 0 ) );
        structs[ 5 ] = br_ending::create_struct( ( -21726, -25961.2, -146 ), ( 0, -108.126, 0 ) );
        structs[ 6 ] = br_ending::create_struct( ( -30525.8, -17654.2, -234.947 ), ( 0, -127.959, 0 ) );
        structs[ 7 ] = br_ending::create_struct( ( -14594.1, -32837.3, 600.134 ), ( 0, -46.4624, 0 ) );
        structs[ 8 ] = br_ending::create_struct( ( -28797.3, -17400, -241.606 ), ( 0, 16.8587, 0 ) );
        structs[ 9 ] = br_ending::create_struct( ( -18155.4, -27275.3, -224.811 ), ( 0, -121.999, 0 ) );
        structs[ 10 ] = br_ending::create_struct( ( -9975.39, -38284.4, 344.1 ), ( 0, -46.4665, 0 ) );
        structs[ 11 ] = br_ending::create_struct( ( -29281.2, -13754.2, -143 ), ( 0, -11.8112, 0 ) );
        structs[ 12 ] = br_ending::create_struct( ( -17821.6, -23448.4, -262 ), ( 0, 62.3774, 0 ) );
        structs[ 13 ] = br_ending::create_struct( ( -18619.8, -20889.8, -257.189 ), ( 0, -71.9892, 0 ) );
        structs[ 14 ] = br_ending::create_struct( ( -11999.8, -28038.4, -31.998 ), ( 0, 5.45263, 0 ) );
        structs[ 15 ] = br_ending::create_struct( ( -32056.9, -9169.36, -306.919 ), ( 0, 71.9528, 0 ) );
        structs[ 16 ] = br_ending::create_struct( ( -23530.6, -14806.7, -69.1128 ), ( 0, -153.028, 0 ) );
        structs[ 17 ] = br_ending::create_struct( ( -27480.3, -10672.5, -69.3776 ), ( 0, -3.16859, 0 ) );
        structs[ 18 ] = br_ending::create_struct( ( -4660.23, -38889.8, 608.219 ), ( 0, 63.5175, 0 ) );
        structs[ 19 ] = br_ending::create_struct( ( -10475.2, -27452, -31.9999 ), ( 0, 118.642, 0 ) );
        structs[ 20 ] = br_ending::create_struct( ( -20693.1, -15175.3, -304 ), ( 0, -66.6904, 0 ) );
        structs[ 21 ] = br_ending::create_struct( ( -16776.3, -18894, -336 ), ( 0, -15.0922, 0 ) );
        structs[ 22 ] = br_ending::create_struct( ( -13668.5, -18519.2, -365 ), ( 0, -143.119, 0 ) );
        structs[ 23 ] = br_ending::create_struct( ( -22473.8, -10149.8, -298 ), ( 0, -70.3961, 0 ) );
        structs[ 24 ] = br_ending::create_struct( ( -11184.8, -21061.9, -315.854 ), ( 0, 5.70909, 0 ) );
        structs[ 25 ] = br_ending::create_struct( ( -34822.4, -1184.25, -263.947 ), ( 0, -71.6069, 0 ) );
        structs[ 26 ] = br_ending::create_struct( ( -27619.2, -2302.54, -313.891 ), ( 0, -8.77301, 0 ), 1 );
        structs[ 27 ] = br_ending::create_struct( ( -7118.65, -19301.2, -144 ), ( 0, -5.73525, 0 ), 1 );
        structs[ 28 ] = br_ending::create_struct( ( -10491.1, -14985.5, -360 ), ( 0, -103.058, 0 ), 1 );
        structs[ 29 ] = br_ending::create_struct( ( -14283.6, -11003.1, -315.39 ), ( 0, 7.08201, 0 ) );
        structs[ 30 ] = br_ending::create_struct( ( -23169, -3966.54, -321.134 ), ( 0, -83.3339, 0 ), 1 );
        structs[ 31 ] = br_ending::create_struct( ( -8787.73, -15589.1, -367.949 ), ( 0, 100.158, 0 ), 1 );
        structs[ 32 ] = br_ending::create_struct( ( -817.503, -25527.6, -256.485 ), ( 0, -66.9498, 0 ), 1 );
        structs[ 33 ] = br_ending::create_struct( ( -14242.2, -8993.57, -285.128 ), ( 0, 40.3822, 0 ) );
        structs[ 34 ] = br_ending::create_struct( ( 4555.72, -36115.3, -200.848 ), ( 0, -156.66, 0 ), 1 );
        structs[ 35 ] = br_ending::create_struct( ( 1627.87, -28799.2, 312 ), ( 0, 150.838, 0 ), 1 );
        structs[ 36 ] = br_ending::create_struct( ( -9101.03, -10035.7, -320 ), ( 0, 33.7296, 0 ) );
        structs[ 37 ] = br_ending::create_struct( ( -6042.41, -13135.6, -363.999 ), ( 0, -134.727, 0 ), 1 );
        structs[ 38 ] = br_ending::create_struct( ( 3185.75, -25611.3, -288.702 ), ( 0, 93.1862, 0 ), 1 );
        structs[ 39 ] = br_ending::create_struct( ( 1792.7, -23147, -290.615 ), ( 0, -151.835, 0 ), 1 );
        structs[ 40 ] = br_ending::create_struct( ( -35463.8, 7869.36, 52.9549 ), ( 0, -93.1204, 0 ), 1 );
        structs[ 41 ] = br_ending::create_struct( ( -716.066, -18775.2, 934 ), ( 0, -148.79, 0 ) );
        structs[ 42 ] = br_ending::create_struct( ( 12452, -35755.6, -484 ), ( 0, -28.7822, 0 ), 1 );
        structs[ 43 ] = br_ending::create_struct( ( 4648.29, -19224.9, -286.002 ), ( 0, 28.824, 0 ), 1 );
        structs[ 44 ] = br_ending::create_struct( ( -21706.1, 6555.31, -279.84 ), ( 0, 5.8398, 0 ), 1 );
        structs[ 45 ] = br_ending::create_struct( ( -16018.1, 4086.84, -318.486 ), ( 0, 3.79374, 0 ), 1 );
        structs[ 46 ] = br_ending::create_struct( ( -25374.2, 10918.1, -320 ), ( 0, 120.887, 0 ), 1 );
        structs[ 47 ] = br_ending::create_struct( ( -12119.8, 2981.18, -329.815 ), ( 0, 105.554, 0 ), 1 );
        structs[ 48 ] = br_ending::create_struct( ( -14767.3, 5096.92, -400.009 ), ( 0, 131.701, 0 ), 1 );
        structs[ 49 ] = br_ending::create_struct( ( 8177.97, -19326, -286.002 ), ( 0, 91.7841, 0 ), 1 );
        structs[ 50 ] = br_ending::create_struct( ( 15726.9, -35325.4, 318.345 ), ( 0, 151.377, 0 ), 1 );
        structs[ 51 ] = br_ending::create_struct( ( 11454.7, -22581.5, -214.023 ), ( 0, -92.045, 0 ), 1 );
        structs[ 52 ] = br_ending::create_struct( ( -21126.1, 11662.1, -317.002 ), ( 0, -174.747, 0 ), 1 );
        structs[ 53 ] = br_ending::create_struct( ( -7293.09, 3009.49, -317.508 ), ( 0, -152.562, 0 ), 1 );
        structs[ 54 ] = br_ending::create_struct( ( 17629.6, -32800.1, 15.9988 ), ( 0, 7.32444, 0 ), 1 );
        structs[ 55 ] = br_ending::create_struct( ( 504.818, -3834.63, -349 ), ( 0, 66.6309, 0 ), 1 );
        structs[ 56 ] = br_ending::create_struct( ( -25415.2, 15191.1, -325.003 ), ( 0, -84.1954, 0 ), 1 );
        structs[ 57 ] = br_ending::create_struct( ( 13957.3, -21816.1, -194 ), ( 0, -75.6819, 0 ), 1 );
        structs[ 58 ] = br_ending::create_struct( ( -10176, 6713.5, -400 ), ( 0, 75.3382, 0 ), 1 );
        structs[ 59 ] = br_ending::create_struct( ( -15327.9, 10742.1, -400 ), ( 0, 32.2232, 0 ), 1 );
        structs[ 60 ] = br_ending::create_struct( ( 8420.99, -11753.6, 306 ), ( 0, 83.4712, 0 ), 1 );
        structs[ 61 ] = br_ending::create_struct( ( -22216, 14718, -64.0002 ), ( 0, -82.0633, 0 ), 1 );
        structs[ 62 ] = br_ending::create_struct( ( -17022, 11976.4, -322.43 ), ( 0, 105.663, 0 ), 1 );
        structs[ 63 ] = br_ending::create_struct( ( -30924.8, 19829.7, 205 ), ( 0, -69.3892, 0 ), 1 );
        structs[ 64 ] = br_ending::create_struct( ( -2024.99, 3060.21, -330.017 ), ( 0, -158.048, 0 ), 1 );
        structs[ 65 ] = br_ending::create_struct( ( -28136.9, 19575.5, -448.227 ), ( 0, -98.4958, 0 ), 1 );
        structs[ 66 ] = br_ending::create_struct( ( -12771.2, 11772.2, -326.973 ), ( 0, 19.9583, 0 ), 1 );
        structs[ 67 ] = br_ending::create_struct( ( 22131, -32223, -440 ), ( 0, 119.727, 0 ), 1 );
        structs[ 68 ] = br_ending::create_struct( ( -22334.3, 18697.4, 688.005 ), ( 0, 140.553, 0 ), 1 );
        structs[ 69 ] = br_ending::create_struct( ( -5988.27, 8879.42, -314.188 ), ( 0, -172.016, 0 ) );
        structs[ 70 ] = br_ending::create_struct( ( -25425.5, 20658.8, -448 ), ( 0, 0.274191, 0 ), 1 );
        structs[ 71 ] = br_ending::create_struct( ( -33327.4, 24789.2, 12.4296 ), ( 0, -44.4776, 0 ), 1 );
        structs[ 72 ] = br_ending::create_struct( ( 21118.3, -22709.8, -232 ), ( 0, 42.769, 0 ) );
        structs[ 73 ] = br_ending::create_struct( ( 24818.8, -31636.5, -536.472 ), ( 0, -140.971, 0 ) );
        structs[ 74 ] = br_ending::create_struct( ( -28418.1, 23715.5, -447.994 ), ( 0, -89.5397, 0 ), 1 );
        structs[ 75 ] = br_ending::create_struct( ( 16769.7, -13392.7, 356.076 ), ( 0, -37.8018, 0 ) );
        structs[ 76 ] = br_ending::create_struct( ( -13952.5, 17259.8, -324 ), ( 0, -76.2444, 0 ), 1 );
        structs[ 77 ] = br_ending::create_struct( ( 24205.4, -25029.5, -328.008 ), ( 0, 169.376, 0 ), 1 );
        structs[ 78 ] = br_ending::create_struct( ( -17899.8, 21527.3, -450.34 ), ( 0, -8.05977, 0 ), 1 );
        structs[ 79 ] = br_ending::create_struct( ( 22217.9, -18422.9, 632 ), ( 0, 162.28, 0 ), 1 );
        structs[ 80 ] = br_ending::create_struct( ( 20834, -14657, 4937 ), ( 0, 30, 0 ), 1 );
        structs[ 81 ] = br_ending::create_struct( ( -2832.02, 13488.4, -319.985 ), ( 0, -0.230498, 0 ), 1 );
        structs[ 82 ] = br_ending::create_struct( ( 3266.46, 9488.52, -317.067 ), ( 0, 97.6153, 0 ), 1 );
        structs[ 83 ] = br_ending::create_struct( ( 22282, -13360, -205 ), ( 0, 310, 0 ), 1 );
        structs[ 84 ] = br_ending::create_struct( ( -23053.6, 27499.5, -460.201 ), ( 0, 83.541, 0 ), 1 );
        structs[ 85 ] = br_ending::create_struct( ( 25849.1, -18871.7, -223.666 ), ( 0, -95.0098, 0 ) );
        structs[ 86 ] = br_ending::create_struct( ( -8326.54, 20049.9, -257.261 ), ( 0, 110.381, 0 ), 1 );
        structs[ 87 ] = br_ending::create_struct( ( 19238.7, -6573.38, -40 ), ( 0, -88.569, 0 ) );
        structs[ 88 ] = br_ending::create_struct( ( -36685.3, 33440.3, 1474.01 ), ( 0, -73.7051, 0 ), 1 );
        structs[ 89 ] = br_ending::create_struct( ( 26412.2, -13112.5, -264 ), ( 0, 55.7859, 0 ), 1 );
        structs[ 90 ] = br_ending::create_struct( ( 20248.8, -2154.65, -496 ), ( 0, 116.839, 0 ) );
        structs[ 91 ] = br_ending::create_struct( ( -6577.92, 23388.3, -448.004 ), ( 0, -101.867, 0 ), 1 );
        structs[ 92 ] = br_ending::create_struct( ( 18069.7, 1558.6, -590.448 ), ( 0, -85.7224, 0 ), 1 );
        structs[ 93 ] = br_ending::create_struct( ( -10855.2, 27363.9, -259.411 ), ( 0, 148.092, 0 ), 1 );
        structs[ 94 ] = br_ending::create_struct( ( -2919.92, 22409.8, -446.75 ), ( 0, -78.7055, 0 ), 1 );
        structs[ 95 ] = br_ending::create_struct( ( -16866.8, 30593, -225.8 ), ( 0, -75.0401, 0 ), 1 );
        structs[ 96 ] = br_ending::create_struct( ( 37954.1, -37722.9, -577.993 ), ( 0, 69.8195, 0 ), 1 );
        structs[ 97 ] = br_ending::create_struct( ( 35023.3, -24338.2, -566 ), ( 0, 53.0156, 0 ), 1 );
        structs[ 98 ] = br_ending::create_struct( ( 16187.4, 8712.66, -332.163 ), ( 0, -84.2018, 0 ), 1 );
        structs[ 99 ] = br_ending::create_struct( ( -25609.6, 36743.4, 348.439 ), ( 0, -160.438, 0 ) );
        structs[ 100 ] = br_ending::create_struct( ( -14068.2, 31959.7, -250.623 ), ( 0, -153.916, 0 ), 1 );
        structs[ 101 ] = br_ending::create_struct( ( 29348.7, -8361.65, -424.006 ), ( 0, -81.6393, 0 ), 1 );
        structs[ 102 ] = br_ending::create_struct( ( 8670.39, 18913.1, -303.729 ), ( 0, 105.535, 0 ), 1 );
        structs[ 103 ] = br_ending::create_struct( ( 35020.4, -16139.2, -572.017 ), ( 0, 58.7604, 0 ), 1 );
        structs[ 104 ] = br_ending::create_struct( ( 19630.8, 10158.6, -451.09 ), ( 0, -142.492, 0 ), 1 );
        structs[ 105 ] = br_ending::create_struct( ( 43465.3, -36148.1, 51.093 ), ( 0, 112.905, 0 ) );
        structs[ 106 ] = br_ending::create_struct( ( -19560, 39017.6, -640 ), ( 0, 105.902, 0 ) );
        structs[ 107 ] = br_ending::create_struct( ( 3395.98, 28640.1, 1.42773 ), ( 0, 135.948, 0 ), 1 );
        structs[ 108 ] = br_ending::create_struct( ( -12456.8, 38252.8, 35 ), ( 0, 136.198, 0 ) );
        structs[ 109 ] = br_ending::create_struct( ( 34810.3, -3657.19, -480 ), ( 0, -139.433, 0 ) );
        structs[ 110 ] = br_ending::create_struct( ( 48307, -38482.1, 2272 ), ( 0, 54.6218, 0 ), 1 );
        structs[ 111 ] = br_ending::create_struct( ( 17534.5, 19736.7, 318.301 ), ( 0, -103.234, 0 ), 1 );
        structs[ 112 ] = br_ending::create_struct( ( 49054.6, -37186.3, 2272.02 ), ( 0, 62.8379, 0 ), 1 );
        structs[ 113 ] = br_ending::create_struct( ( -26149.3, 47192.9, 2703.16 ), ( 0, 36.4515, 0 ) );
        structs[ 114 ] = br_ending::create_struct( ( 50932.9, -41318, 1347 ), ( 0, -109.525, 0 ), 1 );
        structs[ 115 ] = br_ending::create_struct( ( 51090.6, -34587.3, 1343.9 ), ( 0, -9.93786, 0 ), 1 );
        structs[ 116 ] = br_ending::create_struct( ( 32681, 7595.22, -497.554 ), ( 0, -48.5794, 0 ), 1 );
        structs[ 117 ] = br_ending::create_struct( ( 35336.5, 3905.92, -551.754 ), ( 0, -23.8152, 0 ), 1 );
        structs[ 118 ] = br_ending::create_struct( ( 52357.4, -33339, 1258.09 ), ( 0, -20.541, 0 ), 1 );
        structs[ 119 ] = br_ending::create_struct( ( -520.246, 39710.8, 2783 ), ( 0, -72.5011, 0 ), 1 );
        structs[ 120 ] = br_ending::create_struct( ( 45634.6, -11566.6, -58.2778 ), ( 0, -151.105, 0 ), 1 );
        structs[ 121 ] = br_ending::create_struct( ( 50376.7, -21886.4, -395.252 ), ( 0, -23.787, 0 ) );
        structs[ 122 ] = br_ending::create_struct( ( 51570.2, -24783.1, -113.531 ), ( 0, 104.684, 0 ), 1 );
        structs[ 123 ] = br_ending::create_struct( ( 39824, 1114.83, -424.993 ), ( 0, 138.361, 0 ), 1 );
        structs[ 124 ] = br_ending::create_struct( ( 25203.2, 20332.5, 1345.43 ), ( 0, 23.9621, 0 ) );
        structs[ 125 ] = br_ending::create_struct( ( 52294.1, -25802.7, -83.0376 ), ( 0, -19.67, 0 ), 1 );
        structs[ 126 ] = br_ending::create_struct( ( -11742.3, 47596, 1790.51 ), ( 0, -161.796, 0 ), 1 );
        structs[ 127 ] = br_ending::create_struct( ( 44198.1, -4238.47, 266.547 ), ( 0, -102.295, 0 ) );
        structs[ 128 ] = br_ending::create_struct( ( 48747.6, -12179.9, 14.8108 ), ( 0, -111.192, 0 ), 1 );
        structs[ 129 ] = br_ending::create_struct( ( 46453.4, -6647.04, 208.457 ), ( 0, -15.0621, 0 ), 1 );
        structs[ 130 ] = br_ending::create_struct( ( 12849.3, 34747.5, 2458.5 ), ( 0, -39.4017, 0 ), 1 );
        structs[ 131 ] = br_ending::create_struct( ( 52493.1, -17205.6, -391.658 ), ( 0, 19.0522, 0 ), 1 );
        structs[ 132 ] = br_ending::create_struct( ( 54470.9, -21095.7, -394.817 ), ( 0, -68.4661, 0 ) );
        structs[ 133 ] = br_ending::create_struct( ( -24417, 56523.2, 2659.76 ), ( 0, -129.922, 0 ), 1 );
        structs[ 134 ] = br_ending::create_struct( ( 37257.1, 13799.8, 232 ), ( 0, 22.0809, 0 ), 1 );
        structs[ 135 ] = br_ending::create_struct( ( 23294, 29633.7, 1019.7 ), ( 0, 17.9623, 0 ), 1 );
        structs[ 136 ] = br_ending::create_struct( ( 49428.4, 1843.77, 19.9863 ), ( 0, 175.256, 0 ), 1 );
        structs[ 137 ] = br_ending::create_struct( ( 3411.24, 49881.5, 1032 ), ( 0, 83.1958, 0 ), 1 );
        structs[ 138 ] = br_ending::create_struct( ( 57090, -11008.2, -433.158 ), ( 0, -94.4655, 0 ), 1 );
        structs[ 139 ] = br_ending::create_struct( ( 20175.4, 39040, 957.372 ), ( 0, 82.8313, 0 ), 1 );
        structs[ 140 ] = br_ending::create_struct( ( -8255.86, 57148.3, 1071.37 ), ( 0, -11.2614, 0 ), 1 );
        structs[ 141 ] = br_ending::create_struct( ( 51848.1, 3726.24, 29.3418 ), ( 0, 172.199, 0 ), 1 );
        structs[ 142 ] = br_ending::create_struct( ( 50898.1, 6776.73, 29.7878 ), ( 0, -8.3196, 0 ), 1 );
        structs[ 143 ] = br_ending::create_struct( ( -17676, 62373.4, 1908.92 ), ( 0, -4.78614, 0 ) );
        structs[ 144 ] = br_ending::create_struct( ( 12324.8, 47493.6, 1036 ), ( 0, -44.8196, 0 ), 1 );
        structs[ 145 ] = br_ending::create_struct( ( 29716.1, 34472.4, 435.436 ), ( 0, -133.228, 0 ), 1 );
        structs[ 146 ] = br_ending::create_struct( ( 37269.7, 27514, 190.688 ), ( 0, -36.7275, 0 ), 1 );
        structs[ 147 ] = br_ending::create_struct( ( 46679.8, 17932.4, -352.184 ), ( 0, 157.463, 0 ), 1 );
        structs[ 148 ] = br_ending::create_struct( ( 53649.7, 7546.33, 29.3552 ), ( 0, -107.59, 0 ), 1 );
        structs[ 149 ] = br_ending::create_struct( ( 57918.4, 650.832, 41.0137 ), ( 0, 106.07, 0 ), 1 );
        structs[ 150 ] = br_ending::create_struct( ( 7073.74, 57285.5, 1036 ), ( 0, 164.547, 0 ), 1 );
        structs[ 151 ] = br_ending::create_struct( ( 27957.2, 43805.1, 1753.23 ), ( 0, -142.754, 0 ), 1 );
        structs[ 152 ] = br_ending::create_struct( ( 20050.9, 52735.7, 1917.76 ), ( 0, 137.974, 0 ), 1 );
        structs[ 153 ] = br_ending::create_struct( ( 44717.5, 39263.5, -42.8776 ), ( 0, -102.018, 0 ), 1 );
        structs[ 154 ] = br_ending::create_struct( ( 44297.8, 24153.9, 366 ), ( 0, -141.949, 0 ), 1 );
    }
    else if ( exfiltype == "chopper3_qwe" )
    {
        structs[ 0 ] = br_ending::create_struct( ( 28250, 1500, -672 ), ( 0, 0, 0 ) );
    }
    else
    {
        structs[ 0 ] = br_ending::create_struct( ( -33196.1, -33783.6, 111.98 ), ( 0, 115.803, 0 ) );
        structs[ 1 ] = br_ending::create_struct( ( -23875.2, -38204.7, 884.218 ), ( 0, -30.2417, 0 ) );
        structs[ 2 ] = br_ending::create_struct( ( -34810.8, -25903.7, -208.311 ), ( 0, 172.51, 0 ) );
        structs[ 3 ] = br_ending::create_struct( ( -18490.8, -42880.4, 374.836 ), ( 0, -29.3333, 0 ) );
        structs[ 4 ] = br_ending::create_struct( ( -32175.8, -23927.7, -288.088 ), ( 0, 76.2562, 0 ) );
        structs[ 5 ] = br_ending::create_struct( ( -13508, -42830.7, 347.534 ), ( 0, 8.01451, 0 ) );
        structs[ 6 ] = br_ending::create_struct( ( -21713.8, -26181.2, -149.172 ), ( 0, 67.4747, 0 ) );
        structs[ 7 ] = br_ending::create_struct( ( -37117.6, -10190.9, -120.529 ), ( 0, -135.736, 0 ) );
        structs[ 8 ] = br_ending::create_struct( ( -11980.7, -29887.3, -37.7825 ), ( 0, 11.1848, 0 ) );
        structs[ 9 ] = br_ending::create_struct( ( -25389.9, -13131.6, -69.2217 ), ( 0, 24.1318, 0 ) );
        structs[ 10 ] = br_ending::create_struct( ( -2334.96, -41079.4, 365.096 ), ( 0, 20.4232, 0 ) );
        structs[ 11 ] = br_ending::create_struct( ( -37921.3, -1645.87, 108.784 ), ( 0, -97.8273, 0 ) );
        structs[ 12 ] = br_ending::create_struct( ( -4674.58, -30905.4, 281.183 ), ( 0, -130.589, 0 ) );
        structs[ 13 ] = br_ending::create_struct( ( -11034.2, -20239.1, -366.041 ), ( 0, -39.039, 0 ) );
        structs[ 14 ] = br_ending::create_struct( ( -17520.1, -10784.8, -292.834 ), ( 0, 116.303, 0 ) );
        structs[ 15 ] = br_ending::create_struct( ( -28161.7, -3003.04, -316.216 ), ( 0, -89.5041, 0 ) );
        structs[ 16 ] = br_ending::create_struct( ( 4407.15, -36159.8, -206.573 ), ( 0, 28.5016, 0 ) );
        structs[ 17 ] = br_ending::create_struct( ( -448.286, -23112.9, -293.789 ), ( 0, 139.061, 0 ) );
        structs[ 18 ] = br_ending::create_struct( ( -32793.2, 4963.97, -312.125 ), ( 0, -59.7493, 0 ) );
        structs[ 19 ] = br_ending::create_struct( ( -6393.02, -13105.6, -360 ), ( 0, -68.0003, 0 ) );
        structs[ 20 ] = br_ending::create_struct( ( -18615.2, -1446.61, -316.219 ), ( 0, -42.9537, 0 ) );
        structs[ 21 ] = br_ending::create_struct( ( 9393.26, -33259.2, -456.28 ), ( 0, 47.7731, 0 ) );
        structs[ 22 ] = br_ending::create_struct( ( -22141.1, 4413.87, -322.005 ), ( 0, -161.573, 0 ) );
        structs[ 23 ] = br_ending::create_struct( ( -10592.5, -1985.85, -325.007 ), ( 0, -110.463, 0 ) );
        structs[ 24 ] = br_ending::create_struct( ( 14475, -37758.9, -233.322 ), ( 0, 176.773, 0 ) );
        structs[ 25 ] = br_ending::create_struct( ( 3815.61, -14834.8, -286.266 ), ( 0, -109.097, 0 ) );
        structs[ 26 ] = br_ending::create_struct( ( 13167.7, -29025.9, -640.106 ), ( 0, -91.3505, 0 ) );
        structs[ 27 ] = br_ending::create_struct( ( 11468.2, -21196.5, -217.793 ), ( 0, 76.4952, 0 ) );
        structs[ 28 ] = br_ending::create_struct( ( -349.107, -4439.25, -363.255 ), ( 0, -125.089, 0 ) );
        structs[ 29 ] = br_ending::create_struct( ( -23896.6, 14671.6, -64 ), ( 0, -110.556, 0 ) );
        structs[ 30 ] = br_ending::create_struct( ( -31850.9, 19342.3, 205.019 ), ( 0, -135.305, 0 ) );
        structs[ 31 ] = br_ending::create_struct( ( 22502.9, -35290.9, -629.339 ), ( 0, -145.992, 0 ) );
        structs[ 32 ] = br_ending::create_struct( ( 13773.1, -11826.8, -264 ), ( 0, 9.6598, 0 ) );
        structs[ 33 ] = br_ending::create_struct( ( -14842.9, 16221.3, -325.188 ), ( 0, -22.7921, 0 ) );
        structs[ 34 ] = br_ending::create_struct( ( -899.906, 6555.55, -327.188 ), ( 0, 51.4311, 0 ) );
        structs[ 35 ] = br_ending::create_struct( ( -7529.64, 13027.4, -323.288 ), ( 0, -155.426, 0 ) );
        structs[ 36 ] = br_ending::create_struct( ( 20378.5, -19258.8, -112 ), ( 0, -100.817, 0 ) );
        structs[ 37 ] = br_ending::create_struct( ( 10531.3, -2920.35, -291.216 ), ( 0, -120.433, 0 ) );
        structs[ 38 ] = br_ending::create_struct( ( -24746.9, 24507.4, -448.188 ), ( 0, -125.804, 0 ) );
        structs[ 39 ] = br_ending::create_struct( ( 27305.1, -24378.2, -391.703 ), ( 0, 52.9449, 0 ) );
        structs[ 40 ] = br_ending::create_struct( ( 31219.4, -35067.5, -567.357 ), ( 0, 90.7208, 0 ) );
        structs[ 41 ] = br_ending::create_struct( ( 9281.9, 5120.89, -202 ), ( 0, 0.0569, 0 ) );
        structs[ 42 ] = br_ending::create_struct( ( -36720.9, 33655.4, 1467.69 ), ( 0, -88.5771, 0 ) );
        structs[ 43 ] = br_ending::create_struct( ( -13489.2, 24853.9, -448.188 ), ( 0, 94.6448, 0 ) );
        structs[ 44 ] = br_ending::create_struct( ( 26868.2, -15144.4, -244.675 ), ( 0, -38.7766, 0 ) );
        structs[ 45 ] = br_ending::create_struct( ( -3397.25, 21154.9, -380.58 ), ( 0, 54.3053, 0 ) );
        structs[ 46 ] = br_ending::create_struct( ( 4055.63, 16467.4, -294.024 ), ( 0, 58.8983, 0 ) );
        structs[ 47 ] = br_ending::create_struct( ( 18617.3, 2241.49, -601.262 ), ( 0, 45.5374, 0 ) );
        structs[ 48 ] = br_ending::create_struct( ( 23659.8, -2939.53, -559.239 ), ( 0, -134.23, 0 ) );
        structs[ 49 ] = br_ending::create_struct( ( -25686.3, 36017.7, 336.372 ), ( 0, -10.5908, 0 ) );
        structs[ 50 ] = br_ending::create_struct( ( -13567.5, 30968, -251.735 ), ( 0, -7.61727, 0 ) );
        structs[ 51 ] = br_ending::create_struct( ( 40957.9, -41412.1, -724.64 ), ( 0, 26.4091, 0 ) );
        structs[ 52 ] = br_ending::create_struct( ( 29535.8, -9162.74, -420.815 ), ( 0, -80.1718, 0 ) );
        structs[ 53 ] = br_ending::create_struct( ( 36378.2, -23097.6, -564.184 ), ( 0, -105.348, 0 ) );
        structs[ 54 ] = br_ending::create_struct( ( 40291.8, -31856.2, -569.938 ), ( 0, 25.5491, 0 ) );
        structs[ 55 ] = br_ending::create_struct( ( 15057.5, 12279.2, -336.174 ), ( 0, -173.074, 0 ) );
        structs[ 56 ] = br_ending::create_struct( ( -5036.87, 31111.9, -254.926 ), ( 0, -43.6158, 0 ) );
        structs[ 57 ] = br_ending::create_struct( ( -30309.5, 42506.6, 2613.61 ), ( 0, 49.0629, 0 ) );
        structs[ 58 ] = br_ending::create_struct( ( 4633.04, 26113.3, -2.5519 ), ( 0, -78.6017, 0 ) );
        structs[ 59 ] = br_ending::create_struct( ( 36426.9, -10365.5, -365.159 ), ( 0, 1.57208, 0 ) );
        structs[ 60 ] = br_ending::create_struct( ( -19124, 42386.8, -640 ), ( 0, -54.7343, 0 ) );
        structs[ 61 ] = br_ending::create_struct( ( 34998.3, -3778.03, -484.629 ), ( 0, -34.1654, 0 ) );
        structs[ 62 ] = br_ending::create_struct( ( 15029.7, 22341.8, 390.852 ), ( 0, -92.7657, 0 ) );
        structs[ 63 ] = br_ending::create_struct( ( 29751, 6099.14, 854.689 ), ( 0, 48.204, 0 ) );
        structs[ 64 ] = br_ending::create_struct( ( 24370.3, 12901.2, -310.175 ), ( 0, -78.1277, 0 ) );
        structs[ 65 ] = br_ending::create_struct( ( 50860, -39109, 1336.9 ), ( 0, 55.0807, 0 ) );
        structs[ 66 ] = br_ending::create_struct( ( -7125.94, 39691.1, 929.66 ), ( 0, -4.91497, 0 ) );
        structs[ 67 ] = br_ending::create_struct( ( 48553.2, -24470.2, -428.224 ), ( 0, 84.6756, 0 ) );
        structs[ 68 ] = br_ending::create_struct( ( -26055.1, 49915.3, 2269.88 ), ( 0, 170.864, 0 ) );
        structs[ 69 ] = br_ending::create_struct( ( 46938.7, -13707.8, -96.0608 ), ( 0, 101.731, 0 ) );
        structs[ 70 ] = br_ending::create_struct( ( 5832.7, 36339, 1902.26 ), ( 0, 7.37738, 0 ) );
        structs[ 71 ] = br_ending::create_struct( ( 43460.9, -4154.98, 238.75 ), ( 0, 48.9339, 0 ) );
        structs[ 72 ] = br_ending::create_struct( ( -11872.1, 47393.1, 1783.91 ), ( 0, -154.051, 0 ) );
        structs[ 73 ] = br_ending::create_struct( ( 15387.9, 32265, 1403.53 ), ( 0, -160.61, 0 ) );
        structs[ 74 ] = br_ending::create_struct( ( 56589.2, -35216.5, -19.8791 ), ( 0, 86.9305, 0 ) );
        structs[ 75 ] = br_ending::create_struct( ( 40882.2, 3604.76, -258.949 ), ( 0, -10.1054, 0 ) );
        structs[ 76 ] = br_ending::create_struct( ( -17102.1, 51707, 2687.38 ), ( 0, 167.722, 0 ) );
        structs[ 77 ] = br_ending::create_struct( ( 34142.2, 15062.4, 293.056 ), ( 0, 51.1175, 0 ) );
        structs[ 78 ] = br_ending::create_struct( ( 23956, 27383.9, 948.945 ), ( 0, -115.617, 0 ) );
        structs[ 79 ] = br_ending::create_struct( ( 184.564, 45277.3, 1433.98 ), ( 0, 151.628, 0 ) );
        structs[ 80 ] = br_ending::create_struct( ( 58722.5, -22085.4, -284.876 ), ( 0, 62.6424, 0 ) );
        structs[ 81 ] = br_ending::create_struct( ( 54576.1, -6410.17, -770.742 ), ( 0, 83.3932, 0 ) );
        structs[ 82 ] = br_ending::create_struct( ( 58253, -13275, -425.188 ), ( 0, 100.341, 0 ) );
        structs[ 83 ] = br_ending::create_struct( ( 20564.2, 39043.4, 949.883 ), ( 0, -72.4154, 0 ) );
        structs[ 84 ] = br_ending::create_struct( ( 49490.8, 5754.45, 28.9529 ), ( 0, -94.062, 0 ) );
        structs[ 85 ] = br_ending::create_struct( ( 44101.5, 14449.1, -383.213 ), ( 0, 86.1024, 0 ) );
        structs[ 86 ] = br_ending::create_struct( ( 5533.35, 50407, 1027.55 ), ( 0, 53.6811, 0 ) );
        structs[ 87 ] = br_ending::create_struct( ( 32727.8, 30453.7, 568.923 ), ( 0, 71.2524, 0 ) );
        structs[ 88 ] = br_ending::create_struct( ( 38859.1, 23732.9, -218.928 ), ( 0, 116.914, 0 ) );
        structs[ 89 ] = br_ending::create_struct( ( -3751.22, 57231.5, 615.362 ), ( 0, 40.8328, 0 ) );
        structs[ 90 ] = br_ending::create_struct( ( 13193.2, 47609.7, 1034.81 ), ( 0, -23.6196, 0 ) );
        structs[ 91 ] = br_ending::create_struct( ( 58510.2, 1963.22, 24.8131 ), ( 0, 106.632, 0 ) );
        structs[ 92 ] = br_ending::create_struct( ( 6839.83, 56587.6, 1034.81 ), ( 0, -26.4762, 0 ) );
        structs[ 93 ] = br_ending::create_struct( ( 27584.1, 43944.9, 1742.55 ), ( 0, 16.0772, 0 ) );
        structs[ 94 ] = br_ending::create_struct( ( 46690.2, 27661.3, -363.626 ), ( 0, 109.963, 0 ) );
        structs[ 95 ] = br_ending::create_struct( ( 19675.1, 53092.5, 1881.05 ), ( 0, -56.6515, 0 ) );
        structs[ 96 ] = br_ending::create_struct( ( 58995.4, 13880.5, 805.923 ), ( 0, 103.09, 0 ) );
        structs[ 97 ] = br_ending::create_struct( ( 38939.2, 42495.2, 1229.55 ), ( 0, 69.2136, 0 ) );
        structs[ 98 ] = br_ending::create_struct( ( 28773.8, 52305.7, 3242.76 ), ( 0, -128.632, 0 ) );
        structs[ 99 ] = br_ending::create_struct( ( 57184.4, 23557.7, 1565.31 ), ( 0, -153.583, 0 ) );
        structs[ 100 ] = br_ending::create_struct( ( 46036.3, 38523.6, -334.451 ), ( 0, 91.4421, 0 ) );
        structs[ 101 ] = br_ending::create_struct( ( 38808.7, 48914.2, 1345.11 ), ( 0, 140.808, 0 ) );
    }
    
    return structs;
}

// Namespace mp_saw_sierra_br
// Params 1
// Checksum 0xcaf9fb32, Offset: 0x3a96
// Size: 0x16
function function_3855f5796f4d2b65( infilname )
{
    unloadinfiltransient( "mp_infil_br_sierra_saw_s1_tr" );
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x91860c91, Offset: 0x3ab4
// Size: 0x64
function function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:90, #hotzonemodelname:"mp_saw_sierra_origin_name_fx_hotzone", #var_19733a4972a03471:"mp_saw_sierra_origin_name_fx", #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 500 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x47f364bc, Offset: 0x3b21
// Size: 0x2b8
function function_51abc721712b72ce()
{
    if ( getdvarint( @"hash_6979a78a1820ac18", 0 ) != 0 )
    {
        return;
    }
    
    level waittill( #"prematch_fade_done" );
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    if ( utility::issharedfuncdefined( #"br", #"hash_2deeeb25b2c73e08" ) )
    {
        utility::callsharedfunc( #"br", #"hash_2deeeb25b2c73e08" );
    }
    else
    {
        poi::function_1a666d7097121932( "storagetown", ( -25750.9, 7713.93, 2040 ) );
        poi::function_1a666d7097121932( "downtown", ( 26463, -14605, 2583.93 ) );
        poi::function_1a666d7097121932( "farms", ( 47122.4, -11951.5, 2932.43 ) );
        poi::function_1a666d7097121932( "lumber", ( 51383, 2863.92, 2134.51 ) );
        poi::function_1a666d7097121932( "stadium", ( 28653.2, 2390.3, 2103.23 ) );
        poi::function_1a666d7097121932( "prison", ( 51035.6, -39269.9, 2962.7 ) );
        poi::function_1a666d7097121932( "port", ( 35574.6, -27004.9, 2034.4 ) );
        poi::function_1a666d7097121932( "park", ( 20891.3, -29479.6, 2305.89 ) );
        poi::function_1a666d7097121932( "promeast", ( 77.7617, -22879.3, 2009.92 ) );
        poi::function_1a666d7097121932( "launchpad", ( -19096, -37276, 2800 ) );
        poi::function_1a666d7097121932( "promwest", ( -17947.5, -25194.3, 1894.96 ) );
        poi::function_1a666d7097121932( "boneyard", ( -27014.4, -10119.8, 1779.3 ) );
        poi::function_1a666d7097121932( "trainstation", ( -12943.7, -12405.6, 1959.09 ) );
        poi::function_1a666d7097121932( "superstore", ( -13090, 8796, 2113.61 ) );
        poi::function_1a666d7097121932( "airport", ( -16686.4, 23429.6, 1752 ) );
        poi::function_1a666d7097121932( "tvstation", ( 15042.8, 18344.7, 2556 ) );
        poi::function_1a666d7097121932( "quarry", ( 34726.5, 44171.6, 4678.31 ) );
        poi::function_1a666d7097121932( "milbase", ( 8205.67, 51550.9, 5327.58 ) );
        poi::function_1a666d7097121932( "dam", ( -20798.9, 45678.7, 5440 ) );
        poi::function_1a666d7097121932( "hospital", ( 7935.62, -11312.7, 2333.95 ) );
        poi::function_1a666d7097121932( "factory", ( -3870, 5545, 2500 ) );
        poi::function_1a666d7097121932( "signalstation", ( 3250, 39500, 5000 ) );
        poi::function_1a666d7097121932( "automaton", ( 42559.9, 22487.2, 2040 ) );
    }
    
    level thread poi::function_60168f9e93bde289();
}

// Namespace mp_saw_sierra_br
// Params 1
// Checksum 0x45d21691, Offset: 0x3de1
// Size: 0x123
function function_6977e9dd370de349( bunkernumber )
{
    challengeref = undefined;
    
    switch ( bunkernumber )
    {
        case 0:
            challengeref = "sierra_sidequest_1";
            break;
        case 1:
            challengeref = "sierra_sidequest_2";
            break;
        case 2:
            challengeref = "sierra_sidequest_19";
            break;
        case 3:
            challengeref = "sierra_sidequest_3";
            break;
        case 4:
            challengeref = "sierra_sidequest_4";
            break;
        case 5:
            challengeref = "sierra_sidequest_5";
            break;
        case 6:
            challengeref = "sierra_sidequest_6";
            break;
        case 7:
            challengeref = "sierra_sidequest_20";
            break;
        case 8:
            challengeref = "sierra_sidequest_21";
            break;
        case 9:
            challengeref = "sierra_sidequest_7";
            break;
        case 10:
            challengeref = "sierra_sidequest_8";
            break;
    }
    
    challenges::function_37e945722d6497f3( self, challengeref, 1, 1 );
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x3ff51454, Offset: 0x3f0c
// Size: 0x74
function function_1c147aecd2dc1d1a()
{
    if ( getdvarint( @"scr_sierra_sidequest_enabled", 1 ) == 0 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_3a8de92d0770d9a8", 1 ) )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_loadout_crush" );
    }
    
    if ( getdvarint( @"hash_26865ad29c63c829", 1 ) )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_exhibit" );
    }
    
    if ( getdvarint( @"hash_972c2c7b5ad0c0c7", 1 ) )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_vodianov" );
    }
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0x7d01d55d, Offset: 0x3f88
// Size: 0x22
function function_533c435e089eac1c()
{
    level.br_map_quest.enabled = 0;
    level.var_f33b98c8f715da23 = 1;
}

// Namespace mp_saw_sierra_br
// Params 0
// Checksum 0xaa0636c6, Offset: 0x3fb2
// Size: 0x7
function getflyoverscriptbundlename()
{
    return "wz2_sierra_codebowl_flyover";
}

