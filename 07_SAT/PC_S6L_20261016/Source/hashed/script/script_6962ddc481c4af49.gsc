// script_6962ddc481c4af49  (hash_6962ddc481c4af49.gscc) (size: 5424 Bytes / 0x1530 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a212863 (2048993379)
// size ...... 5424 (0x1530)
// includes .. 6   (offset: 0x1458)
// strings ... 10  (offset: 0x1488)
// dev strs .. 2   (offset: 0x1518)
// exports ... 12  (offset: 0x102c)
// cseg ...... 0x3ca + 0xc62 (0x102c)
// imports ... 14  (offset: 0x120c)
// animtree1 . 0   (offset: 0x1530)
// animtree2 . 0   (offset: 0x1530)
#using scripts\common\script;
#using scripts\mp\br\gametypes\br_ai_gulag;
#using scripts\mp\br\gametypes\br_dom_gulag;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_large_gulag;
#using scripts\mp\br\gametypes\br_twotwo_gulag;

#namespace namespace_a8afdcd7738e364e;

// Namespace namespace_a8afdcd7738e364e
// Params 0
// Checksum 0x86350092, Offset: 0x3e8
// Size: 0x9d6
function function_8e7f7d52c1481618()
{
    if ( !level.usegulag )
    {
        return;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        level.usegulag = 0;
        return;
    }
    
    level.var_56c3cc3dc37f1728 = spawnstruct();
    level.var_56c3cc3dc37f1728.funcs = [];
    level.var_56c3cc3dc37f1728.disabledfeatures = [];
    level.var_56c3cc3dc37f1728.enabledfeatures = [];
    level.var_56c3cc3dc37f1728.data = [];
    var_e063dee68acbf223 = getdvar( @"hash_7453401bbd201b1f", "" );
    level.var_56c3cc3dc37f1728.name = var_e063dee68acbf223 != "" ? var_e063dee68acbf223 : level.gametypebundle.var_e063dee68acbf223;
    level.var_56c3cc3dc37f1728.targetname = getdvar( @"hash_c65716c2a1cc17b2", "gulag" );
    
    if ( level.var_56c3cc3dc37f1728.targetname == "" )
    {
        level.var_56c3cc3dc37f1728.targetname = level.var_56c3cc3dc37f1728.name;
    }
    
    level.var_56c3cc3dc37f1728.var_1b3298506268556 = getdvarint( @"hash_b5f2b14902860071", 0 );
    level.var_56c3cc3dc37f1728.var_99691e85e5e2144b = getdvarint( @"hash_b2eeb2147b1c0219", 1 );
    level.var_56c3cc3dc37f1728.var_5c0352aead2072bb = getdvarint( @"hash_208847b390767663", 1 );
    level.var_56c3cc3dc37f1728.var_8da80922e9e155b6 = getdvarint( @"hash_8da5e76b1e895313", 2 );
    level.var_56c3cc3dc37f1728.var_a5e3e8fdbe3ad4e5 = getdvarint( @"hash_5df3ab0ab2df2d97", 0 );
    level.var_56c3cc3dc37f1728.spectatetopdown = getdvarint( @"hash_8e9b4afed5d3fc68", 1 );
    level.var_56c3cc3dc37f1728.dooropentime = getdvarfloat( @"hash_d54eaab1ef14a6a6", 9 );
    level.var_56c3cc3dc37f1728.var_17fa9f4050417220 = getdvarfloat( @"hash_d54eaab1ef14a6a6", 9 );
    level.var_56c3cc3dc37f1728.var_e21a752ab8f25b4b = getdvarint( @"hash_49244ddb13d62639", 0 );
    level.var_56c3cc3dc37f1728.var_1f8d0e398bd45a60 = getdvarint( @"hash_2bb3b9b9590667cc", 0 );
    level.var_56c3cc3dc37f1728.overtimevariation = getdvarint( @"scr_br_fc_overtime_variation", 0 );
    level.var_56c3cc3dc37f1728.forceloadoutindex = getdvarint( @"hash_9eddca020b3ff8f", -1 );
    level.var_56c3cc3dc37f1728.var_6dfdf6fe1791a5aa = getdvarint( @"hash_ffc2ea8abaddc229", 0 );
    level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 = getdvarint( @"hash_8744d3e7c83ef792", -1 );
    level.var_56c3cc3dc37f1728.var_3ea0609623948110 = getdvarint( @"hash_4b5a8c9f7ae036e4", 0 );
    level.var_56c3cc3dc37f1728.var_517186cbf8977f33 = getdvarint( @"hash_3498eda80bb80222", 2 );
    level.var_56c3cc3dc37f1728.var_6988df51af3f3602 = getdvarint( @"hash_333310f7e9bbcd8e", -1 );
    level.var_56c3cc3dc37f1728.var_3d03f046485d4942 = getdvarint( @"hash_bf016d6c46e99d48", 0 );
    level.var_56c3cc3dc37f1728.var_106167c0622fbe29 = getdvarint( @"hash_852c517cfb699e95", 0 );
    level.var_56c3cc3dc37f1728.var_b5e323037b34ba3 = getdvarint( @"hash_17ba2e13964efb4a", 0 );
    level.var_56c3cc3dc37f1728.var_c9c0296199422168 = getdvar( @"hash_fe58777db4daf820", "" );
    level.var_56c3cc3dc37f1728.var_6acafb78d5fdfff4 = getdvarint( @"hash_2f58bb09e730f7cd", 2 );
    level.var_56c3cc3dc37f1728.var_747d0f66d247df97 = getdvarint( @"hash_820235266e690648", 5 );
    level.var_56c3cc3dc37f1728.gasspawning = getdvarint( @"hash_2541a23b20690d5b", 0 );
    level.var_56c3cc3dc37f1728.var_b8ce5ae177031821 = getdvarint( @"hash_50d3c409b198c15b", 13 );
    level.var_56c3cc3dc37f1728.var_b91427da7e498253 = getdvarint( @"hash_e5b993b16925ff4d", 0 );
    level.var_56c3cc3dc37f1728.var_8874c85306a586b8 = getdvarint( @"hash_276d595245120a57", 0 );
    level.var_56c3cc3dc37f1728.var_55e4d43596a9b8c9 = getdvarint( @"hash_9e66b59fc89ffbef", 0 );
    level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 = getdvarint( @"hash_8b7830621f9f5ef5", 0 );
    level.var_56c3cc3dc37f1728.var_58ba4ec2b88f9ae2 = getdvarint( @"hash_10fca2d678cb8faf", 1 );
    level.var_56c3cc3dc37f1728.var_e49cc02cc5353ed2 = getdvarint( @"hash_8bb712d4f65ed1c8", 1 );
    
    if ( level.var_56c3cc3dc37f1728.var_3d03f046485d4942 )
    {
        level.var_56c3cc3dc37f1728.dooropentime = getdvarfloat( @"hash_d54eaab1ef14a6a6", 9 );
    }
    else
    {
        level.var_56c3cc3dc37f1728.dooropentime = getdvarfloat( @"hash_d54eaab1ef14a6a6", 13 );
    }
    
    level.var_56c3cc3dc37f1728.var_d9ea32e83b0db25c = getdvarint( @"hash_9ed2fd49cfc46907", 0 );
    level.var_56c3cc3dc37f1728.matchstartweapons = getdvarint( @"hash_23b784d6499a68f3", 5 );
    level.var_56c3cc3dc37f1728.allowfriendlyfire = getdvarint( @"hash_7733d088ade14995", 0 );
    level.var_56c3cc3dc37f1728.var_bb3c05689c4c9669 = getdvarint( @"hash_540f81ab0aacd7c5", 2000 );
    level.var_56c3cc3dc37f1728.var_c94a3da7ef9b6603 = getdvar( @"hash_2728413178b1ee5e", "12000,     5000,   13000,  4500,   15000,  4000,   17000,  3500,   19000,  3000,   22000,  2500,   30000,  2000,   40000,  1700,   50000,  1400,   55000,  1000,   60000,  0" );
    level.var_56c3cc3dc37f1728.var_3e70447761a06062 = getdvar( @"hash_1a6c0b0c4e2a9b59", "7,         5000,    6,     4400,   5,      3600,   4,      2800,   3,      2100,   2,      1400,   1,      700,    0,      0" );
    level.var_56c3cc3dc37f1728.var_27bcd306379bddc3 = getdvar( @"hash_1a6c0b0c4e2a9b59", "100,       2500,   90,     2000,   80,     1500,   70,     1000,   60,     800,    50,     600,    40,     400,    30,     300,    20,     200,    10,     100,    0,      0" );
    level.var_56c3cc3dc37f1728.var_75404b003ec660be = getdvar( @"hash_1a6c0b0c4e2a9b59", "0,         2500,   40,     2000,   80,     1500,   120,    1000,   160,    800,    200,    600,    240,    400,    260,    300,    280,    200,    300,    100,    340,    0" );
    level.var_56c3cc3dc37f1728.var_a3566f7e80af1e0a = getdvar( @"hash_1a6c0b0c4e2a9b59", "2499,      0,      2500,   1,      4000,   2,      5300,   3,      7500,   4,      11000,  5" );
    level.var_56c3cc3dc37f1728.var_9a499bd6444a2758 = getdvar( @"hash_b3919ec55466c612", "" );
    level.var_56c3cc3dc37f1728.var_bb2129b99cb3e2 = getdvarint( @"hash_d7503717efc09613", 1 );
    level.var_56c3cc3dc37f1728.var_c590eb8406743f8e = getdvarint( @"hash_284579e86ada418", 0 );
    level.var_56c3cc3dc37f1728.var_efea3ef64b08393a = getdvarint( @"hash_809e2b6a0ae176ee", 0 );
    level.var_56c3cc3dc37f1728.var_8af2e58b47aa35e4 = getdvarint( @"hash_34c131283285e0c3", 1 );
    level.var_56c3cc3dc37f1728.var_3243cbda03e751d = getdvarint( @"hash_e77b35ec14c97e2a", 1 );
    level.var_56c3cc3dc37f1728.var_f7686e810b4850dc = getdvarint( @"hash_276b722b931120ae", 1 );
    level.var_56c3cc3dc37f1728.var_10cdd335a32170b6 = getdvarint( @"hash_8106433193e14b74", 1 );
    
    if ( level.var_56c3cc3dc37f1728.var_9a499bd6444a2758 != "" )
    {
        var_16516e1541ba46f5 = strtok( level.var_56c3cc3dc37f1728.var_9a499bd6444a2758, " " );
        var_9237a21659317deb = [];
        
        foreach ( index in var_16516e1541ba46f5 )
        {
            var_9237a21659317deb[ var_9237a21659317deb.size ] = int( index );
        }
        
        level.var_56c3cc3dc37f1728.var_9a499bd6444a2758 = var_9237a21659317deb;
    }
    
    switch ( level.var_56c3cc3dc37f1728.name )
    {
        case #"hash_4de6d2f1420f5c6":
            br_ai_gulag::init_ai_gulag();
            break;
        case #"hash_9c45f4b9f1458bf7":
            br_large_gulag::init_large_gulag();
            break;
        case #"hash_e008e31cba81b654":
            br_dom_gulag::init_dom_gulag();
            break;
        case #"hash_7eae9f0c936966e0":
            br_twotwo_gulag::init_twotwo_gulag();
            break;
        case #"":
            return;
        default:
            assertmsg( "<dev string:x24>" + level.var_56c3cc3dc37f1728.name + "<dev string:x60>" );
            break;
    }
}

// Namespace namespace_a8afdcd7738e364e
// Params 0
// Checksum 0x9a100af4, Offset: 0xdc6
// Size: 0x31, Type: bool
function function_373b8665fd6de550()
{
    if ( !isdefined( level.var_56c3cc3dc37f1728 ) || level.var_56c3cc3dc37f1728.name == "" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_a8afdcd7738e364e
// Params 2
// Checksum 0x4deaa9b7, Offset: 0xe00
// Size: 0x5c
function registergulagvariationfunc( funcname, function )
{
    if ( isdefined( level.var_56c3cc3dc37f1728.funcs[ funcname ] ) )
    {
        script::demoforcesre( "registerGulagVariationFunc already has " + funcname + " defined." );
    }
    
    level.var_56c3cc3dc37f1728.funcs[ funcname ] = function;
}

// Namespace namespace_a8afdcd7738e364e
// Params 3, eflags: 0x40 variadic
// Checksum 0x79e44c4e, Offset: 0xe64
// Size: 0x62
function function_2af099d01df1a89c( funcname, ... )
{
    if ( isdefined( level.var_56c3cc3dc37f1728 ) && isdefined( level.var_56c3cc3dc37f1728.funcs[ funcname ] ) )
    {
        return [[ level.var_56c3cc3dc37f1728.funcs[ funcname ] ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0x4dc74f01, Offset: 0xece
// Size: 0x30, Type: bool
function function_3d1f225aa0b4d926( funcname )
{
    return isdefined( level.var_56c3cc3dc37f1728 ) && isdefined( level.var_56c3cc3dc37f1728.funcs[ funcname ] );
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0xe99ee778, Offset: 0xf07
// Size: 0x25
function function_6042ec174569fa17( featurename )
{
    level.var_56c3cc3dc37f1728.disabledfeatures[ featurename ] = 1;
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0xd55c2800, Offset: 0xf34
// Size: 0x31, Type: bool
function function_28a656fdb9ac6cff( featurename )
{
    return !isdefined( level.var_56c3cc3dc37f1728 ) || level.var_56c3cc3dc37f1728.disabledfeatures[ featurename ];
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0xfd174595, Offset: 0xf6e
// Size: 0x25
function function_aef334516f0c2e7e( featurename )
{
    level.var_56c3cc3dc37f1728.enabledfeatures[ featurename ] = 1;
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0xc8681dc2, Offset: 0xf9b
// Size: 0x30, Type: bool
function function_3da7ed4f19aeb4( featurename )
{
    return isdefined( level.var_56c3cc3dc37f1728 ) && level.var_56c3cc3dc37f1728.enabledfeatures[ featurename ];
}

// Namespace namespace_a8afdcd7738e364e
// Params 2
// Checksum 0xc8ceec39, Offset: 0xfd4
// Size: 0x2d
function function_f4cd9204964d2492( dataref, data )
{
    level.var_56c3cc3dc37f1728.data[ dataref ] = data;
}

// Namespace namespace_a8afdcd7738e364e
// Params 1
// Checksum 0x8d8b1d3b, Offset: 0x1009
// Size: 0x22
function function_e5d277ce2fc621bf( dataref )
{
    return level.var_56c3cc3dc37f1728.data[ dataref ];
}

