// script_782ed84671b152fb  (hash_782ed84671b152fb.gscc) (size: 9234 Bytes / 0x2412 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc72277 (264708727)
// size ...... 9234 (0x2412)
// includes .. 3   (offset: 0x229e)
// strings ... 28  (offset: 0x22b6)
// dev strs .. 1   (offset: 0x2406)
// exports ... 37  (offset: 0x14ca)
// cseg ...... 0x1f3 + 0x12d7 (0x14ca)
// imports ... 66  (offset: 0x1a92)
// animtree1 . 0   (offset: 0x2412)
// animtree2 . 0   (offset: 0x2412)
#using script_44102c05f33e9b1e;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_70ebaadbdb24c64d;

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xd573d02a, Offset: 0x211
// Size: 0x4c
function init()
{
    level.var_11133cb0607b498f = level.var_11133cb0607b498f ?? {};
    level.var_11133cb0607b498f.var_7df46f7e792a7ed = [];
    level.var_11133cb0607b498f.var_7df46f7e792a7ed[ "addCallbacksForContextualTips" ] = &addCallbacksForContextualTips;
}

// Namespace namespace_70ebaadbdb24c64d
// Params 1
// Checksum 0xe3478027, Offset: 0x265
// Size: 0x13d
function function_cc2f74a7cb8daa12( tipskey )
{
    self.var_11133cb0607b498f = self.var_11133cb0607b498f ?? {};
    self.var_11133cb0607b498f.tipsdata = self.var_11133cb0607b498f.tipsdata ?? [];
    
    if ( !self.var_11133cb0607b498f.tipsdata[ tipskey ] )
    {
        self.var_11133cb0607b498f.tipsdata[ tipskey ] = [];
        var_81b93d3cf5844830 = level.var_11133cb0607b498f.var_3128982b9edb0001[ tipskey ];
        
        if ( var_81b93d3cf5844830 )
        {
            foreach ( key, value in var_81b93d3cf5844830 )
            {
                self.var_11133cb0607b498f.tipsdata[ tipskey ][ key ] = value;
            }
        }
    }
    
    return self.var_11133cb0607b498f.tipsdata[ tipskey ];
}

// Namespace namespace_70ebaadbdb24c64d
// Params 1
// Checksum 0x91005289, Offset: 0x3ab
// Size: 0x25
function addCallbacksForContextualTips( params )
{
    callback::add( params.callbackname, &function_590b61c93b9bda37, params );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 2
// Checksum 0xb69ca47a, Offset: 0x3d8
// Size: 0xc9
function function_590b61c93b9bda37( params, additionalparams )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    tipsdata = function_cc2f74a7cb8daa12( additionalparams.tipskey );
    
    switch ( additionalparams.callbacktype )
    {
        case #"hash_a0c0b0fcd18bbfc8":
            tipsdata[ additionalparams.datakey ] = additionalparams.var_9b3000a2f37ff90f;
            break;
        case #"hash_17bb2ffef212433b":
            tipsdata[ additionalparams.datakey ] = ( tipsdata[ additionalparams.datakey ] ?? 0 ) + additionalparams.var_9b3000a2f37ff90f;
            break;
        default:
            break;
    }
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x585e6f10, Offset: 0x4a9
// Size: 0x1b
function function_69d58ce278635296()
{
    level.var_31ba871bbc6d3d12[ #"condfalse" ] = &condfalse;
}

// Namespace namespace_70ebaadbdb24c64d
// Params 2
// Checksum 0xb7e6fc36, Offset: 0x4cc
// Size: 0x81
function function_c2198fe46a43aff8( tipindex, data )
{
    assert( isint( tipindex ) && tipindex >= 0 && tipindex < 100, "<dev string:x24>" + tipindex );
    keyhash = getxhash( data.key );
    level.contextualtips[ keyhash ] = data;
    level.var_13483806c100ad3e[ tipindex ] = keyhash;
    level.var_2e3590a0be8bd1ef[ keyhash ] = tipindex;
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x35ca173e, Offset: 0x555
// Size: 0x3, Type: bool
function condfalse()
{
    return false;
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x82ba7627, Offset: 0x561
// Size: 0x8f
function function_1081d0f46308197a()
{
    data = spawnstruct();
    data.key = "Prematch";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.inprematch = 1;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_fa2a31ff3c992888;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_41a8ddbbb7993cdf;
    function_c2198fe46a43aff8( 0, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x59320698, Offset: 0x5f8
// Size: 0xfc
function function_d43d10b864e0ad45()
{
    data = spawnstruct();
    data.key = "ParachuteControls";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_239f1a2e516d9e97;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_4decc7d41f685eea;
    data.endconditions = [];
    data.endconditions[ 0 ] = spawnstruct();
    data.endconditions[ 0 ].func = #"hash_2985d7fb1675a4c9";
    data.endconditions[ 0 ].action = #"hash_e175bca8011c1c15";
    level.var_31ba871bbc6d3d12[ #"hash_e175bca8011c1c15" ] = &namespace_44e68768d1d1a5d6::function_96e54646554bf124;
    function_c2198fe46a43aff8( 1, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x713dabdb, Offset: 0x6fc
// Size: 0x93
function function_f7ae54e608caaa8f()
{
    data = spawnstruct();
    data.key = "SupplyCache";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_b40e6af1bca2e1c1;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_764a6f92fb3f1e50;
    function_c2198fe46a43aff8( 2, data );
    callback::add( "lootcache_looted", &namespace_44e68768d1d1a5d6::function_2f7e8aea3e552c46 );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x56bcab03, Offset: 0x797
// Size: 0x79
function function_41321fd83620de64()
{
    data = spawnstruct();
    data.key = "Inventory";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 20;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_15e8c2db227acfab;
    function_c2198fe46a43aff8( 3, data );
    level thread namespace_44e68768d1d1a5d6::function_5a5268fd00fbd788();
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x7b941ea2, Offset: 0x818
// Size: 0x82
function function_73388a5bcfe6c6b6()
{
    data = spawnstruct();
    data.key = "Map";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 20;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_bad2eaf0cf5510a0;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_1c6c6e87122d0c9;
    function_c2198fe46a43aff8( 4, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xc415ce20, Offset: 0x8a2
// Size: 0x82
function function_e434792ce13fb774()
{
    data = spawnstruct();
    data.key = "BuyStation";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_505083ed8776ba06;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_a2fadcb4852edcfd;
    function_c2198fe46a43aff8( 5, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x39365598, Offset: 0x92c
// Size: 0x82
function function_30a05ad3fe3a00af()
{
    data = spawnstruct();
    data.key = "Armor";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_7469a2b459512969;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_6007f889a2f1ca7c;
    function_c2198fe46a43aff8( 6, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xf4248966, Offset: 0x9b6
// Size: 0x82
function function_b511e5fc0ac11e15()
{
    data = spawnstruct();
    data.key = "LoadoutDrop";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_4b7b04c28bcd5e0f;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_ecb4cfeeea0f2e66;
    function_c2198fe46a43aff8( 7, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x467764e7, Offset: 0xa40
// Size: 0x82
function function_817ae4c0ebff89aa()
{
    data = spawnstruct();
    data.key = "Contract";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_b390b4db4291a3e4;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_de7f57a58497cb73;
    function_c2198fe46a43aff8( 8, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x467764d0, Offset: 0xaca
// Size: 0x82
function function_5292b7d150248473()
{
    data = spawnstruct();
    data.key = "GasClose";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_ed5db8d44e66b0e1;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_55d2c5926889dd5a;
    function_c2198fe46a43aff8( 9, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x384e80b2, Offset: 0xb54
// Size: 0x71
function function_714a7f2cc53f688e()
{
    data = spawnstruct();
    data.key = "GasAvoid";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_2cae950dde3c313b;
    function_c2198fe46a43aff8( 10, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x2d2271a0, Offset: 0xbcd
// Size: 0x71
function function_a8bf1b5d0438ad19()
{
    data = spawnstruct();
    data.key = "GasMask";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_46355408a8f5b396;
    function_c2198fe46a43aff8( 11, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x421e9dfa, Offset: 0xc46
// Size: 0x90
function function_24d0b37b472884f3()
{
    data = spawnstruct();
    data.key = "BuyBack";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_d11df06dfc63beb1;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_da96c8389f9e70b4;
    data.var_7df69b09c1a2a1c9 = 1;
    function_c2198fe46a43aff8( 12, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xd183309, Offset: 0xcde
// Size: 0x90
function function_4d236e5bf63ee9cc()
{
    data = spawnstruct();
    data.key = "Gulag";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.ingulag = 1;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_d6f4feada417e0fe;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_34d363d56476b073;
    function_c2198fe46a43aff8( 13, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x3f948961, Offset: 0xd76
// Size: 0x90
function function_c45d107fae9123b9()
{
    data = spawnstruct();
    data.key = "EnemyDowned";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_b6ed34fdf8814f4b;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_b0dfe8e28849286a;
    data.var_dd0eac742e1ea485 = 1;
    function_c2198fe46a43aff8( 14, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xa55658c8, Offset: 0xe0e
// Size: 0x82
function function_a830241cc164f893()
{
    data = spawnstruct();
    data.key = "ReviveAlly";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_a94d2d2d51fa7c9;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_426acec7a58d5e6a;
    function_c2198fe46a43aff8( 15, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x296728d, Offset: 0xe98
// Size: 0x82
function initializesprint()
{
    data = spawnstruct();
    data.key = "Sprint";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_e74bbb2e536cec42;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_ab9c7c897605a051;
    function_c2198fe46a43aff8( 16, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x2dc824f0, Offset: 0xf22
// Size: 0x82
function initializemovement()
{
    data = spawnstruct();
    data.key = "Movement";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_72895e0151a7e65f;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_9fccfef2c76a3d50;
    function_c2198fe46a43aff8( 17, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x2dc824c5, Offset: 0xfac
// Size: 0x82
function initializeswimming()
{
    data = spawnstruct();
    data.key = "Swimming";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 40;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_512b2c1304a42d13;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_8ad2aa2207e163a8;
    function_c2198fe46a43aff8( 18, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xae3daecd, Offset: 0x1036
// Size: 0x71
function initializeperkpack()
{
    data = spawnstruct();
    data.key = "PerkPack";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_e93aeaf085511858;
    function_c2198fe46a43aff8( 19, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x1c76f8c3, Offset: 0x10af
// Size: 0x71
function initializearmorvest()
{
    data = spawnstruct();
    data.key = "ArmorVest";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_7225860b161daa0a;
    function_c2198fe46a43aff8( 20, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x8d74a72f, Offset: 0x1128
// Size: 0x71
function function_867d8f76e6aa98ad()
{
    data = spawnstruct();
    data.key = "FalseFlag";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_2c75a06270b84176;
    function_c2198fe46a43aff8( 32, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x46d5a124, Offset: 0x11a1
// Size: 0x82
function function_e7f7ad9b7318b728()
{
    data = spawnstruct();
    data.key = "HVLZ";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_e2aa62faf61d0172;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_3f7367749c067bb1;
    function_c2198fe46a43aff8( 33, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x2dc824d6, Offset: 0x122b
// Size: 0x82
function initializecontrols()
{
    data = spawnstruct();
    data.key = "Controls";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 60;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_ef247399120b8628;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_ac85f6b6f4b1c457;
    function_c2198fe46a43aff8( 21, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0xfde0f75b, Offset: 0x12b5
// Size: 0x82
function function_5f0cdf77c54f36ec()
{
    data = spawnstruct();
    data.key = "TrainControls";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::function_655dbd39bdca1172;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_6351cb9a97bc5363;
    function_c2198fe46a43aff8( 22, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x6856c401, Offset: 0x133f
// Size: 0x82
function function_4ccfbaf45618c66c()
{
    data = spawnstruct();
    data.key = "DrivingGas";
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = 30;
    data.condfunc = &namespace_44e68768d1d1a5d6::condnever;
    data.execfunc = &namespace_44e68768d1d1a5d6::function_4e24335ca30b4bf1;
    function_c2198fe46a43aff8( 23, data );
}

// Namespace namespace_70ebaadbdb24c64d
// Params 2
// Checksum 0x60437cfa, Offset: 0x13c9
// Size: 0x52
function function_c5e5437dd11aa222( tipname, tipindex )
{
    if ( utility::issharedfuncdefined( tipname, #"initializeftuedata" ) )
    {
        data = [[ utility::getsharedfunc( tipname, #"initializeftuedata" ) ]]();
        function_c2198fe46a43aff8( tipindex, data );
    }
}

// Namespace namespace_70ebaadbdb24c64d
// Params 0
// Checksum 0x942cc0fe, Offset: 0x1423
// Size: 0x9
function function_2a1ffa928d6acd27()
{
    thread namespace_44e68768d1d1a5d6::function_8ec5da1736d6205d();
}

// Namespace namespace_70ebaadbdb24c64d
// Params 4
// Checksum 0xa248324f, Offset: 0x1434
// Size: 0x95
function function_e7f1fa10c009bf55( key, priority, condfunc, execfunc )
{
    data = spawnstruct();
    data.key = key;
    data.var_887f369888f42d5b = [ 0, 1, 2, 3 ];
    data.priority = priority;
    data.condfunc = condfunc;
    data.execfunc = execfunc;
    return data;
}

