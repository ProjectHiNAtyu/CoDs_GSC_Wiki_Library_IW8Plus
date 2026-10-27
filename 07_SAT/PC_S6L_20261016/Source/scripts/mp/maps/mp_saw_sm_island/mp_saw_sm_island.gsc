// scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island.gsc  (hash_2e3d956bf3d4c3e7.gscc) (size: 7308 Bytes / 0x1c8c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbff71163 (3220640099)
// size ...... 7308 (0x1c8c)
// includes .. 18  (offset: 0x1a44)
// strings ... 32  (offset: 0x1ad4)
// dev strs .. 2   (offset: 0x1c74)
// exports ... 14  (offset: 0x1118)
// cseg ...... 0x284 + 0xe94 (0x1118)
// imports ... 55  (offset: 0x1348)
// animtree1 . 0   (offset: 0x1c8c)
// animtree2 . 0   (offset: 0x1c8c)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_staged_items;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island_art;
#using scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island_fx;
#using scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island_light;
#using scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island_precache;
#using scripts\mp\poi;
#using scripts\mp\stationary_notes;

#namespace mp_saw_sm_island;

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0xa406176a, Offset: 0x2a2
// Size: 0x4c
function main()
{
    mp_saw_sm_island_precache::main();
    mp_saw_sm_island_art::main();
    mp_saw_sm_island_fx::main();
    mp_saw_sm_island_light::main();
    load::main();
    level thread function_a1c63c5633120d71();
    
    if ( isbrgamemode() )
    {
        level thread stationary_notes::snote_init();
        level thread br_staged_items::init();
    }
    
    level thread late_set_dvars();
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x3ed7f896, Offset: 0x2f6
// Size: 0x18f
function function_a1c63c5633120d71()
{
    compass::setupminimap( "compass_map_" + game_utility::getmapname() );
    setdvar( @"hash_3bdc2896f05e40ac", 0.75 );
    setdvar( @"hash_37f05b20e6e2b254", 35 );
    setdvar( @"hash_44a9f0f91a98f576", -4 );
    setdvar( @"r_tessellation", 0 );
    setdvar( @"hash_239f123a722bc317", 10000 );
    setdvar( @"r_fogheightmapfade", 0.0007 );
    setdvar( @"fd_helicopter_altitude_limiter", 4500 );
    
    if ( !isdefined( game[ "attackers" ] ) )
    {
        game[ "attackers" ] = "axis";
    }
    
    if ( !isdefined( game[ "defenders" ] ) )
    {
        game[ "defenders" ] = "allies";
    }
    
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    
    if ( getdvarint( @"scr_br_outofbounds", 1 ) != 0 )
    {
        level.outofboundstriggersplanetrace = getentarray( "OutOfBounds", #targetname );
        level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
        level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    }
    
    game_utility::registerlargemap();
    
    if ( isbrgamemode() )
    {
        var_a61d552b4be4f88b = getdvar( @"hash_6a6394960e900221", "" );
        
        if ( var_a61d552b4be4f88b != "" )
        {
            setgameprops( var_a61d552b4be4f88b );
        }
        else
        {
            setgameprops( %"hash_32d4d865438ecdb9" );
        }
        
        brinit();
    }
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0xeeaae5a2, Offset: 0x48d
// Size: 0x53f
function brinit()
{
    level thread poi::poi_init();
    br_gametypes::enablefeature( #"circlesnaptonavmesh" );
    br_gametypes::disablefeature( #"gulag" );
    br_anims::init();
    level thread function_51abc721712b72ce();
    utility::registersharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient", &function_abe4cd4ebe9b7f88 );
    utility::registersharedfunc( #"br_map_quest", #"get_challenge_prefix", &function_46300ec2bcaa9de3 );
    utility::registersharedfunc( #"br_ending", #"get_ending_locations", &get_ending_locations );
    utility::registersharedfunc( #"br_infils", #"hash_dd6d580483cd15ca", &function_3855f5796f4d2b65 );
    utility::registersharedfunc( #"br_infils", #"hash_f3c68636c0e494a1", &function_be334704d96df6b0 );
    
    if ( !level.var_c8cb79f46406cf7c )
    {
        if ( getdvarint( @"hash_ec3624dc00480c76", 0 ) == 1 )
        {
            br::function_a4785bf1d05110c2();
        }
        else
        {
            level.br_level = spawnstruct();
            x_corners = [ level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] ];
            y_corners = [ level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] ];
            minx = min( x_corners[ 0 ], x_corners[ 1 ] );
            maxx = max( x_corners[ 0 ], x_corners[ 1 ] );
            miny = min( y_corners[ 0 ], y_corners[ 1 ] );
            maxy = max( y_corners[ 0 ], y_corners[ 1 ] );
            level.br_level.br_mapboundsfull = [];
            level.br_level.br_mapboundsfull[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapboundsfull[ 1 ] = ( minx, miny, 0 );
            mapscalar = 0.95;
            level.br_level.br_mapbounds = [];
            level.br_level.br_mapbounds[ 0 ] = ( maxx * mapscalar, maxy * mapscalar, 0 );
            level.br_level.br_mapbounds[ 1 ] = ( minx * mapscalar, miny * mapscalar, 0 );
            br_c130::setc130heightoverrides( 8500, 65 );
            level.br_level.c130_speedoverride = 2000;
            level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
            level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( 8435 ) );
            level.br_level.var_cd92896f34e2d8ef = -15000;
            level.br_level.var_7dd04763bfd623c1 = 3600;
            level.br_level.var_a8250ecaf9608f68 = 0.6;
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 0 )
    {
        level.br_badcircleareas = [];
        var_9f0fd47e959e375 = utility::getstructarray( "badCircle", "script_noteworthy" );
        
        foreach ( badcircle in var_9f0fd47e959e375 )
        {
            level.br_badcircleareas[ level.br_badcircleareas.size ] = br_circle::createinvalidcirclearea( badcircle.origin, badcircle.radius );
        }
        
        assert( level.br_badcircleareas.size > 0, "<dev string:x24>" );
    }
    
    level.br_prematchspawnlocations = [];
    var_d9a969a0203c9a36 = utility::getstructarray( "prematchSpawnLocation", "script_noteworthy" );
    
    foreach ( spawnlocation in var_d9a969a0203c9a36 )
    {
        level.br_prematchspawnlocations[ level.br_prematchspawnlocations.size ] = br::createspawnlocation( spawnlocation.origin, 0, spawnlocation.radius );
    }
    
    assert( level.br_prematchspawnlocations.size > 0, "<dev string:x87>" );
    init_br_circle_settings();
    
    if ( getdvarint( @"hash_1ee4ba7c3a163093", 0 ) == 1 )
    {
        level thread br_circle_util::function_4608172a74445990();
    }
}

// Namespace mp_saw_sm_island
// Params 0, eflags: 0x4
// Checksum 0x3d1c2770, Offset: 0x9d4
// Size: 0x91
function private init_br_circle_settings()
{
    multicircleconfiglist = getdvar( @"scr_br_multi_circle_config_list", "" );
    
    if ( multicircleconfiglist == "" )
    {
        setdvar( @"scr_br_multi_circle_config_list", "wz_multicircleconfig_mp_saw_sm_island_list" );
    }
    
    if ( !isdefined( level.br_level.br_circleradii ) && getdvarint( @"hash_ec3624dc00480c76", 0 ) == 0 )
    {
        br_circle::function_cfdf3903125095d7();
        br_circle::applycirclesettings();
    }
    
    if ( isdefined( level.br_circle_init_func ) )
    {
        [[ level.br_circle_init_func ]]();
    }
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x1b1b27f8, Offset: 0xa6d
// Size: 0x7
function function_7f668af822a9ac52()
{
    return "mp_br_saw_sm_island_infil_tr";
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x76ad7369, Offset: 0xa7d
// Size: 0x7
function function_abe4cd4ebe9b7f88()
{
    return "mp_br_saw_sm_island_exfil_tr";
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x59502d16, Offset: 0xa8d
// Size: 0x7
function function_46300ec2bcaa9de3()
{
    return "br_s2_map_quest_";
}

// Namespace mp_saw_sm_island
// Params 1
// Checksum 0x7b0ee10d, Offset: 0xa9d
// Size: 0x2d9
function get_ending_locations( exfiltype )
{
    structs = [];
    structs[ 0 ] = br_ending::create_struct( ( -7711.31, -5149.71, 1390 ), ( 0, 113.349, 0 ) );
    structs[ 1 ] = br_ending::create_struct( ( -10138.4, -739.356, 343 ), ( 0, -105.865, 0 ) );
    structs[ 2 ] = br_ending::create_struct( ( -4284.97, -4187.11, 944.027 ), ( 0, -135.374, 0 ) );
    structs[ 3 ] = br_ending::create_struct( ( -6648.67, -160.269, 1191 ), ( 0, 173.932, 0 ) );
    structs[ 4 ] = br_ending::create_struct( ( -4531.23, -1422.83, 1311 ), ( 0, -103.066, 0 ) );
    structs[ 5 ] = br_ending::create_struct( ( -734.625, -771.681, 1223.82 ), ( 0, 108.499, 0 ) );
    structs[ 6 ] = br_ending::create_struct( ( 2764.47, -3443.98, 1005 ), ( 0, 173.911, 0 ) );
    structs[ 7 ] = br_ending::create_struct( ( -1702.82, 2515.71, 1550.31 ), ( 0, -67.6228, 0 ) );
    structs[ 8 ] = br_ending::create_struct( ( 7386.54, -5858.85, 519 ), ( 0, -98.8436, 0 ) );
    structs[ 9 ] = br_ending::create_struct( ( -1375.83, 6245.27, 1427 ), ( 0, 81.3974, 0 ) );
    structs[ 10 ] = br_ending::create_struct( ( 7953.53, -3218.67, 573.135 ), ( 0, -152.834, 0 ) );
    structs[ 11 ] = br_ending::create_struct( ( 6287.23, -292.93, 1015 ), ( 0, 107.217, 0 ) );
    structs[ 12 ] = br_ending::create_struct( ( 4270.67, 2395.89, 1142.25 ), ( 0, -38.4888, 0 ) );
    structs[ 13 ] = br_ending::create_struct( ( 2718.56, 4483.44, 1446.25 ), ( 0, -29.6471, 0 ) );
    structs[ 14 ] = br_ending::create_struct( ( 11463.5, -4756.38, 488 ), ( 0, 30.0757, 0 ) );
    structs[ 15 ] = br_ending::create_struct( ( 3269.93, 9297.86, 1116.25 ), ( 0, -24.8293, 0 ) );
    structs[ 16 ] = br_ending::create_struct( ( 5416.27, 7364.5, 1271.25 ), ( 0, 144.477, 0 ) );
    structs[ 17 ] = br_ending::create_struct( ( 13879.2, 803.79, 164.317 ), ( 0, -81.6603, 0 ) );
    structs[ 18 ] = br_ending::create_struct( ( 12215.7, 4960.76, 285 ), ( 0, -78.1074, 0 ) );
    return structs;
}

// Namespace mp_saw_sm_island
// Params 1
// Checksum 0x421167ce, Offset: 0xd7f
// Size: 0x16
function function_3855f5796f4d2b65( infilname )
{
    unloadinfiltransient( "mp_br_saw_sm_island_infil_tr" );
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x1d48e17e, Offset: 0xd9d
// Size: 0x64
function function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:90, #hotzonemodelname:"mp_saw_sm_island_origin_name_fx_hotzone", #var_19733a4972a03471:"mp_saw_sm_island_origin_name_fx", #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 500 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x1ecf06c0, Offset: 0xe0a
// Size: 0x18c
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
        poi::function_1a666d7097121932( "airstrip", ( 11694, -3685, 1000 ) );
        poi::function_1a666d7097121932( "cemetery", ( -5326, 2157, 1500 ) );
        poi::function_1a666d7097121932( "cove", ( 9904, 5824, 2000 ) );
        poi::function_1a666d7097121932( "gardens", ( -1571, 5014, 2000 ) );
        poi::function_1a666d7097121932( "grand_keep", ( 3168, 6810, 2500 ) );
        poi::function_1a666d7097121932( "lighthouse", ( 7237, -5571, 1500 ) );
        poi::function_1a666d7097121932( "main_gate", ( 453, 2121, 2000 ) );
        poi::function_1a666d7097121932( "overlook", ( -7404, -4816, 2000 ) );
        poi::function_1a666d7097121932( "sea_caves", ( -1647, -1505, 2000 ) );
        poi::function_1a666d7097121932( "town_square", ( -5975, -1487, 1500 ) );
        poi::function_1a666d7097121932( "winery", ( 7701, 377, 2000 ) );
    }
    
    level thread poi::function_60168f9e93bde289();
}

// Namespace mp_saw_sm_island
// Params 0
// Checksum 0x9da40ce0, Offset: 0xf9e
// Size: 0x40
function late_set_dvars()
{
    level waittill( #"player_spawned" );
    setdvar( @"hash_7e128eb152f9065a", 0.02 );
    setdvar( @"hash_21dd07f2103e0be0", 0 );
    setdvar( @"hash_c2a25ed7189f4694", 0 );
}

// Namespace mp_saw_sm_island
// Params 6
// Checksum 0x119aa73b, Offset: 0xfe6
// Size: 0x132
function function_e8e714f9eead8b10( offset, radius, height, inner_radius, teleport_speed, move_time )
{
    level endon( #"game_ended" );
    end_time = gettime() + move_time * 1000;
    
    while ( gettime() < end_time )
    {
        a_veh = vehicle_getarrayinradius( self.origin + offset, radius, height / 2 );
        
        foreach ( veh in a_veh )
        {
            if ( veh.isempty )
            {
                veh vehphys_impulse( ( 0, 0, 1 ), 1 );
            }
        }
        
        wait max( 0.5, getdvarfloat( @"hash_ddd431ba32ed72de" ) - 0.5 );
    }
}

