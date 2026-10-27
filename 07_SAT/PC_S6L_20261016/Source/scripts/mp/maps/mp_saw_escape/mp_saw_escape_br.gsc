// scripts\mp\maps\mp_saw_escape\mp_saw_escape_br.gsc  (hash_46a09372f38b3740.gscc) (size: 9263 Bytes / 0x242f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa077081 (4194791553)
// size ...... 9263 (0x242f)
// includes .. 14  (offset: 0x2233)
// strings ... 32  (offset: 0x22a3)
// dev strs .. 0   (offset: 0x242f)
// exports ... 20  (offset: 0x1743)
// cseg ...... 0x2c9 + 0x147a (0x1743)
// imports ... 59  (offset: 0x1a63)
// animtree1 . 0   (offset: 0x242f)
// animtree2 . 0   (offset: 0x242f)
#using script_75b994f10201e95c;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_anims;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_staged_items;
#using scripts\mp\maps\mp_saw_escape\mp_saw_escape_master_cs;
#using scripts\mp\maps\mp_wz2_escape\mp_wz2_escape_ee;
#using scripts\mp\poi;
#using scripts\mp\stationary_notes;

#namespace mp_saw_escape_br;

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0x9db2a690, Offset: 0x2e7
// Size: 0xb4
function init()
{
    brinit();
    br_anims::init();
    level.outofboundstriggersplanetrace = getentarray( "OutOfBounds", #targetname );
    br_gametypes::enablefeature( #"infiluseplaneheightoob" );
    var_a61d552b4be4f88b = getdvar( @"hash_6a6394960e900221", "" );
    
    if ( var_a61d552b4be4f88b != "" )
    {
        setgameprops( var_a61d552b4be4f88b );
    }
    else
    {
        var_8f56c942ffd26085 = utility::callsharedfunc( #"hash_f4ba51c3ec7610da", #"hash_34fbaf8cde855ef5" );
        setgameprops( var_8f56c942ffd26085 ?? "mp_saw_escape_rain_br" );
    }
    
    thread mp_wz2_escape_ee::init();
    thread stationary_notes::snote_init();
    thread function_e366fbb9e97d64a2();
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0xb5cbf5ae, Offset: 0x3a3
// Size: 0x973
function brinit()
{
    level thread function_51abc721712b72ce();
    
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
            level.br_level.br_corners[ 0 ] = ( -16000, -16000, 200 );
            level.br_level.br_corners[ 1 ] = ( 16000, 16000, 200 );
            heightoverride = 8000;
            br_c130::setc130heightoverrides( heightoverride, 65 );
            level.br_level.c130_speedoverride = 2000;
            minx = min( level.br_level.br_corners[ 0 ][ 0 ], level.br_level.br_corners[ 1 ][ 0 ] );
            maxx = max( level.br_level.br_corners[ 0 ][ 0 ], level.br_level.br_corners[ 1 ][ 0 ] );
            miny = min( level.br_level.br_corners[ 1 ][ 1 ], level.br_level.br_corners[ 0 ][ 1 ] );
            maxy = max( level.br_level.br_corners[ 1 ][ 1 ], level.br_level.br_corners[ 0 ][ 1 ] );
            level.br_level.br_mapboundsfull = [];
            level.br_level.br_mapboundsfull[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapboundsfull[ 1 ] = ( minx, miny, 0 );
            minx = level.br_level.br_corners[ 0 ][ 0 ] * 0.95;
            maxx = level.br_level.br_corners[ 1 ][ 0 ] * 0.95;
            miny = level.br_level.br_corners[ 0 ][ 1 ] * 0.95;
            maxy = level.br_level.br_corners[ 1 ][ 1 ] * 0.95;
            level.br_level.br_mapbounds = [];
            level.br_level.br_mapbounds[ 0 ] = ( maxx, maxy, 0 );
            level.br_level.br_mapbounds[ 1 ] = ( minx, miny, 0 );
            level.br_level.br_mapcenter = ( ( minx + maxx ) / 2, ( miny + maxy ) / 2, 0 );
            level.br_level.br_mapsize = ( abs( maxx - minx ), abs( maxy - miny ), abs( level.br_level.c130_heightoverride - level.br_level.c130_sealeveloverride ) );
            level.br_level.var_cd92896f34e2d8ef = -450;
            level.br_level.var_7dd04763bfd623c1 = 3400;
            level.br_level.var_a8250ecaf9608f68 = 0.45;
            level.br_level.var_b87f1926d764d03a = ( -1200, 0, 0 );
            br_circle::function_cfdf3903125095d7();
            br_circle::applycirclesettings();
        }
    }
    
    level.var_c8cb79f46406cf7c = undefined;
    
    if ( isdefined( level.br_circle_init_func ) )
    {
        [[ level.br_circle_init_func ]]();
    }
    
    level.br_prematchspawnlocations = [ br::createspawnlocation( ( 0, 400, 1000 ), 0, 1000 ), br::createspawnlocation( ( -2000, -5211, 1000 ), 0, 1000 ), br::createspawnlocation( ( 4542, -3893, 1000 ), 0, 1000 ), br::createspawnlocation( ( -1000, 10000, 1000 ), 0, 1000 ), br::createspawnlocation( ( -4000, 3000, 1000 ), 0, 1000 ), br::createspawnlocation( ( -1500, -11500, 1000 ), 0, 1000 ) ];
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 0 )
    {
        level.br_badcircleareas = [ br_circle::createinvalidcirclearea( ( -18691, 12376, 200 ), 15000 ), br_circle::createinvalidcirclearea( ( -19459, -12712, 200 ), 15000 ), br_circle::createinvalidcirclearea( ( 19261, -12712, 200 ), 15000 ), br_circle::createinvalidcirclearea( ( 18493, 12376, 200 ), 15000 ), br_circle::createinvalidcirclearea( ( -707, 20888, 200 ), 8000 ), br_circle::createinvalidcirclearea( ( -707, -22632, 200 ), 8000 ), br_circle::createinvalidcirclearea( ( 5255, -15805, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 8323, -9836, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 8642, 3052, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 7015, 9413, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 4349, 13144, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -7087, 13998, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -8292, 8684, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -9920, 2816, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -8292, 8684, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -9088, -5312, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -7424, -12800, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -1600, -17344, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 9923, -2860, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( -1859, 16600, 200 ), 4500 ), br_circle::createinvalidcirclearea( ( 2388, -11256, 200 ), 2400 ), br_circle::createinvalidcirclearea( ( -4140, -8184, 200 ), 2000 ), br_circle::createinvalidcirclearea( ( -6085, 2857, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( -92, 12848, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( -4582, 10069, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( 4957, 4374, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( 4579, 6143, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( -6700, -824, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( -3820, -9656, 200 ), 1100 ), br_circle::createinvalidcirclearea( ( 1556, -13880, 200 ), 1100 ) ];
    }
    
    level.var_256941f347945772 = [ br_circle::createinvalidcirclearea( ( -3160, -3527, 1777 ), 150 ), br_circle::createinvalidcirclearea( ( -6877, -1544, 977 ), 150 ), br_circle::createinvalidcirclearea( ( 6002, -3565, 927 ), 150 ), br_circle::createinvalidcirclearea( ( 802, 9483, 1807 ), 150 ), br_circle::createinvalidcirclearea( ( -2952, -11082, 1448 ), 150 ), br_circle::createinvalidcirclearea( ( 1321, 9467, 2404 ), 150 ) ];
    utility::registersharedfunc( #"hash_e179a026a53bd163", #"get_exfil_transient", &function_abe4cd4ebe9b7f88 );
    utility::registersharedfunc( #"br_ending", #"get_ending_locations", &get_ending_locations );
    utility::registersharedfunc( #"br_infils", #"hash_dd6d580483cd15ca", &function_3855f5796f4d2b65 );
    utility::registersharedfunc( #"br_infils", #"hash_f3c68636c0e494a1", &function_be334704d96df6b0 );
    utility::registersharedfunc( #"br_infils", #"hash_50d7df11518fd6c8", &function_409ffc723ef522af );
    utility::registersharedfunc( #"br_flyover", #"getflyoverscriptbundlename", &getflyoverscriptbundlename );
    
    if ( utility::issharedfuncdefined( #"create_script_master", #"override_init" ) )
    {
        level thread [[ utility::getsharedfunc( #"create_script_master", #"override_init" ) ]]();
    }
    else
    {
        level thread mp_saw_escape_master_cs::main();
    }
    
    level thread br_staged_items::init();
    level thread namespace_8cdbb6d4564d9fae::init();
    
    /#
        thread function_d7dc5a5d532dda55( heightoverride );
    #/
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0xc3927010, Offset: 0xd1e
// Size: 0x7
function function_abe4cd4ebe9b7f88()
{
    return "mp_infil_br_escape_ending_saw_tr";
}

// Namespace mp_saw_escape_br
// Params 1
// Checksum 0x357092aa, Offset: 0xd2e
// Size: 0x11d
function get_ending_locations( exfiltype )
{
    structs = [];
    structs[ 0 ] = br_ending::create_struct( ( -223, -8426, 157 ), ( 0, 0, 0 ) );
    structs[ 1 ] = br_ending::create_struct( ( -4934, 621, 721.5 ), ( 0, 65, 0 ) );
    structs[ 2 ] = br_ending::create_struct( ( -1379.17, 9824.93, 656.5 ), ( 0, -71.249, 0 ) );
    structs[ 3 ] = br_ending::create_struct( ( 2066.5, -5556.54, 691 ), ( 0, 51.195, 0 ) );
    structs[ 4 ] = br_ending::create_struct( ( 2824.94, -128.393, 835 ), ( 0, -112.261, 0 ) );
    structs[ 5 ] = br_ending::create_struct( ( -666.062, 6778.61, 1061.71 ), ( 0, 127.054, 0 ) );
    structs[ 6 ] = br_ending::create_struct( ( -4011.06, -882.893, 697.212 ), ( 0, 173.102, 359 ) );
    return structs;
}

// Namespace mp_saw_escape_br
// Params 1
// Checksum 0x52c02cd9, Offset: 0xe54
// Size: 0x16
function function_3855f5796f4d2b65( infilname )
{
    unloadinfiltransient( "mp_infil_br_escape_saw_tr" );
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0x644be32, Offset: 0xe72
// Size: 0x1f
function function_409ffc723ef522af()
{
    level.infilstruct.hwconfig = %"hw_jup_mp_wz2_escape_cin_cer";
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0x7ec04965, Offset: 0xe99
// Size: 0x75
function function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:30, #hotzonemodelname:function_165a55de5137a89d(), #var_de90d5a70718f121:function_5b849ecfa8452971(), #var_19733a4972a03471:function_12b5560b835a6ac4(), #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 750 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0xdcfd8467, Offset: 0xf17
// Size: 0x16e
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
    
    poi::function_1a666d7097121932( "factory", ( 4500, -2000, 1400 ) );
    poi::function_1a666d7097121932( "industry", ( -1875, 7200, 1400 ) );
    poi::function_1a666d7097121932( "prison", ( -360, 180, 2400 ) );
    poi::function_1a666d7097121932( "livingquarters", ( -50, -5900, 1500 ) );
    poi::function_1a666d7097121932( "dock", ( -6200, -1100, 1400 ) );
    poi::function_1a666d7097121932( "chemical", ( 1375, 7475, 1600 ) );
    poi::function_1a666d7097121932( "bioweapons", ( -2150, 10400, 1500 ) );
    poi::function_1a666d7097121932( "stronghold", ( -650, -10250, 1500 ) );
    poi::function_1a666d7097121932( "headquarters", ( 1750, -3350, 2000 ) );
    poi::function_1a666d7097121932( "harbor", ( 3850, 3750, 1400 ) );
    poi::function_1a666d7097121932( "control", ( -3200, -2400, 1700 ) );
    poi::function_1a666d7097121932( "turbine", ( -4700, 4230, 1700 ) );
    level thread poi::function_60168f9e93bde289();
}

// Namespace mp_saw_escape_br
// Params 0, eflags: 0x4
// Checksum 0x330824ff, Offset: 0x108d
// Size: 0x3b
function private function_12b5560b835a6ac4()
{
    if ( utility::issharedfuncdefined( #"br_infils", #"get_name_fx_model" ) )
    {
        return utility::callsharedfunc( #"br_infils", #"get_name_fx_model" );
    }
    
    return "mp_saw_escape_s4_origin_name_fx";
}

// Namespace mp_saw_escape_br
// Params 0, eflags: 0x4
// Checksum 0x5fbb8598, Offset: 0x10d1
// Size: 0x22, Type: bool
function private function_165a55de5137a89d()
{
    return utility::callsharedfunc( #"br_infils", #"hash_78269a69dcd3adae" ) ?? "mp_saw_escape_s4_origin_name_fx_hotzone";
}

// Namespace mp_saw_escape_br
// Params 0, eflags: 0x4
// Checksum 0xf4588c86, Offset: 0x10fc
// Size: 0x22, Type: bool
function private function_5b849ecfa8452971()
{
    return utility::callsharedfunc( #"br_infils", #"hash_a36fc9f96b87097c" ) ?? "mp_saw_escape_s4_origin_name_fx_gas_bomb_strikes";
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0x7b7be475, Offset: 0x1127
// Size: 0xa9
function function_e366fbb9e97d64a2()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_debb802494baa5f6 = getent( "escape5_lighthouse", "script_noteworthy" );
    var_3c724322eacb6bdb = undefined;
    
    if ( isdefined( var_debb802494baa5f6 ) )
    {
        if ( var_debb802494baa5f6.target == level.br_destruction_scenario.selectedscenario.name )
        {
            var_3c724322eacb6bdb = getent( var_debb802494baa5f6.target, "targetname" );
        }
        
        thread infilsiren( var_debb802494baa5f6, var_3c724322eacb6bdb );
        thread function_7c18b60505df7387( var_debb802494baa5f6, isdefined( var_3c724322eacb6bdb ) );
        thread function_2e55c912037a98b7( var_debb802494baa5f6, isdefined( var_3c724322eacb6bdb ) );
    }
}

// Namespace mp_saw_escape_br
// Params 2
// Checksum 0xb678b4a6, Offset: 0x11d8
// Size: 0x9c
function infilsiren( var_3e99aa785d8f7b0, var_3c724322eacb6bdb )
{
    level endon( #"game_ended" );
    siren = spawn( "script_model", var_3e99aa785d8f7b0.origin );
    siren setmodel( "br_escape_sound_siren_sfx" );
    siren forcenetfieldhighlod( 1 );
    level waittill( #"br_c130_in_bounds" );
    wait 2;
    
    if ( isdefined( var_3c724322eacb6bdb ) )
    {
        infilstate = "siren_destroyed";
        siren thread function_9644f2d385c53512( var_3c724322eacb6bdb );
    }
    else
    {
        infilstate = "siren_pristine";
    }
    
    thread sirensfx( var_3e99aa785d8f7b0, siren, infilstate, 35 );
}

// Namespace mp_saw_escape_br
// Params 1
// Checksum 0x2e491a13, Offset: 0x127c
// Size: 0x40
function function_9644f2d385c53512( var_3c724322eacb6bdb )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 1.5;
    self moveto( var_3c724322eacb6bdb.origin, 3.5 );
}

// Namespace mp_saw_escape_br
// Params 2
// Checksum 0x508ce181, Offset: 0x12c4
// Size: 0x71
function function_2e55c912037a98b7( var_3e99aa785d8f7b0, var_d2515d57832b87c3 )
{
    level endon( #"game_ended" );
    
    if ( var_d2515d57832b87c3 )
    {
        return;
    }
    
    var_9c43bdd4ccd0778b = utility::callsharedfunc( #"gametype", #"hash_a8f0ac21a885a542" );
    
    if ( !var_9c43bdd4ccd0778b )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( var_9c43bdd4ccd0778b );
        thread sirensfx( var_3e99aa785d8f7b0, undefined, "round_transition", 18 );
    }
}

// Namespace mp_saw_escape_br
// Params 2
// Checksum 0x10097b27, Offset: 0x133d
// Size: 0xab
function function_7c18b60505df7387( var_3e99aa785d8f7b0, var_d2515d57832b87c3 )
{
    level endon( #"game_ended" );
    level waittill( #"infils_ready" );
    
    if ( level.brgametype.var_551ace5c0006c70a || var_d2515d57832b87c3 )
    {
        return;
    }
    
    var_2603ed516d8c8e3b = undefined;
    
    if ( isdefined( level.var_9c42cd6ef80d1c1a ) )
    {
        var_2603ed516d8c8e3b = level.var_9c42cd6ef80d1c1a;
    }
    else if ( !br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        var_2603ed516d8c8e3b = br_gulag::gettimetogulagclosed();
    }
    
    if ( isdefined( var_2603ed516d8c8e3b ) )
    {
        wait var_2603ed516d8c8e3b - 15;
        thread sirensfx( var_3e99aa785d8f7b0, undefined, "siren_ending", 18 );
    }
}

// Namespace mp_saw_escape_br
// Params 4
// Checksum 0xb2350c56, Offset: 0x13f0
// Size: 0x7d
function sirensfx( var_3e99aa785d8f7b0, sirenscriptmodel, sirenstate, duration )
{
    level endon( #"game_ended" );
    
    if ( !sirenscriptmodel )
    {
        sirenscriptmodel = spawn( "script_model", var_3e99aa785d8f7b0.origin );
        sirenscriptmodel setmodel( "br_escape_sound_siren_sfx" );
        sirenscriptmodel forcenetfieldhighlod( 1 );
        waitframe();
    }
    
    sirenscriptmodel setscriptablepartstate( "sound_fx", sirenstate );
    wait duration;
    sirenscriptmodel delete();
}

// Namespace mp_saw_escape_br
// Params 0
// Checksum 0xdbc943a0, Offset: 0x1475
// Size: 0x7
function getflyoverscriptbundlename()
{
    return "wz2_escape_codebowl_flyover";
}

/#

    // Namespace mp_saw_escape_br
    // Params 1
    // Checksum 0x33fd7ee2, Offset: 0x1485
    // Size: 0x2be, Type: dev
    function function_d7dc5a5d532dda55( zheight )
    {
        if ( getdvarint( @"hash_9d56ff51cec560dc", 0 ) == 0 )
        {
            return;
        }
        
        while ( true )
        {
            p1 = ( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 0 ][ 1 ], zheight );
            p2 = ( level.br_level.br_mapbounds[ 1 ][ 0 ], level.br_level.br_mapbounds[ 0 ][ 1 ], zheight );
            p3 = ( level.br_level.br_mapbounds[ 1 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 1 ], zheight );
            p4 = ( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 1 ], zheight );
            line( p1, p2, ( 0, 1, 0 ) );
            line( p2, p3, ( 0, 1, 0 ) );
            line( p3, p4, ( 0, 1, 0 ) );
            line( p4, p1, ( 0, 1, 0 ) );
            p5 = ( level.br_level.br_mapboundsfull[ 0 ][ 0 ], level.br_level.br_mapboundsfull[ 0 ][ 1 ], zheight );
            p6 = ( level.br_level.br_mapboundsfull[ 1 ][ 0 ], level.br_level.br_mapboundsfull[ 0 ][ 1 ], zheight );
            p7 = ( level.br_level.br_mapboundsfull[ 1 ][ 0 ], level.br_level.br_mapboundsfull[ 1 ][ 1 ], zheight );
            p8 = ( level.br_level.br_mapboundsfull[ 0 ][ 0 ], level.br_level.br_mapboundsfull[ 1 ][ 1 ], zheight );
            line( p5, p6, ( 1, 1, 0 ) );
            line( p6, p7, ( 1, 1, 0 ) );
            line( p7, p8, ( 1, 1, 0 ) );
            line( p8, p5, ( 1, 1, 0 ) );
            waitframe();
        }
    }

#/
