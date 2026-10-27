// scripts\mp\common\utility\loot.gsc  (hash_1ade2fa7cae9593d.gscc) (size: 9195 Bytes / 0x23eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ea80d2 (132808914)
// size ...... 9195 (0x23eb)
// includes .. 3   (offset: 0x2157)
// strings ... 43  (offset: 0x216f)
// dev strs .. 8   (offset: 0x238b)
// exports ... 26  (offset: 0x1903)
// cseg ...... 0x79f + 0x1164 (0x1903)
// imports ... 35  (offset: 0x1d13)
// animtree1 . 0   (offset: 0x23eb)
// animtree2 . 0   (offset: 0x23eb)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace loot;

// Namespace loot
// Params 0
// Checksum 0xc36be60f, Offset: 0x7bd
// Size: 0xe6
function init()
{
    level.lootmaster = [];
    
    for ( row = 0; true ; row++ )
    {
        typename = tablelookupbyrow( "loot/loot_types.csv", row, 0 );
        
        if ( !isdefined( typename ) || typename == "" )
        {
            break;
        }
        
        typevalue = int( tablelookupbyrow( "loot/loot_types.csv", row, 1 ) );
        data = spawnstruct();
        data.typename = typename;
        data.typevalue = typevalue;
        level.lootmaster[ typename ] = data;
    }
    
    if ( !level.gametypebundle.var_3a960ff885ea423 )
    {
        function_ace7a24559a019fb();
    }
    
    function_36413802e4a9f188();
    utility::registersharedfunc( #"loot", #"hash_e8a1675206a03393", &function_d3e3bcaea591a6a2 );
}

// Namespace loot
// Params 0
// Checksum 0x9ac6008c, Offset: 0x8ab
// Size: 0xf5
function function_36413802e4a9f188()
{
    level.var_7dcfd72b3473e97d = [];
    level.var_77778f180e1e6ad3 = [];
    var_aa1e7736aee2628f = getdvar( @"lui_banned_loot_items" );
    
    if ( isdefined( var_aa1e7736aee2628f ) )
    {
        itemids = strtok( var_aa1e7736aee2628f, "|" );
        
        foreach ( itemid in itemids )
        {
            level.var_7dcfd72b3473e97d[ level.var_7dcfd72b3473e97d.size ] = int( itemid );
        }
    }
    
    var_aa1e7736aee2628f = getdvar( @"hash_18d43c13f449a92b" );
    
    if ( isdefined( var_aa1e7736aee2628f ) )
    {
        level.var_77778f180e1e6ad3 = strtok( var_aa1e7736aee2628f, "|" );
    }
}

// Namespace loot
// Params 0
// Checksum 0x80394222, Offset: 0x9a8
// Size: 0x18a
function function_ace7a24559a019fb()
{
    if ( isdefined( level.var_16e1c38355341288 ) )
    {
        return;
    }
    
    level.var_16e1c38355341288 = [];
    level.var_e43af16903bda945 = [];
    projectscriptbundle = level.projectbundle;
    var_5f783a376dc26921 = getscriptbundle( hashcat( %"hash_6da2812724ad07ed", projectscriptbundle.consumablelist ) );
    
    /#
        if ( !isdefined( var_5f783a376dc26921 ) )
        {
            println( "<dev string:x24>" + projectscriptbundle.consumablelist );
        }
    #/
    
    foreach ( consumable in var_5f783a376dc26921.consumablelist )
    {
        consumableref = consumable.bundle;
        
        if ( !isdefined( consumableref ) )
        {
            continue;
        }
        
        consumablebundle = getscriptbundlefieldvalues( hashcat( %"hash_2d4d7620ade90519", consumableref ), [ #"lootid" ] );
        
        if ( !isdefined( consumablebundle ) )
        {
            println( "<dev string:x51>" + projectscriptbundle.consumablelist + "<dev string:x87>" + consumableref );
            continue;
        }
        
        level.var_16e1c38355341288[ consumableref ] = consumablebundle;
        level.var_e43af16903bda945[ level.var_e43af16903bda945.size ] = consumableref;
    }
}

// Namespace loot
// Params 1
// Checksum 0x4aca9f60, Offset: 0xb3a
// Size: 0x44
function function_2fa0a9205d311c5d( consumableref )
{
    function_ace7a24559a019fb();
    var_7237854e3be197ca = level.var_16e1c38355341288[ consumableref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    println( "<dev string:x8a>" + consumableref );
}

// Namespace loot
// Params 1
// Checksum 0x3b929f86, Offset: 0xb87
// Size: 0x50
function function_5c29f3f1f5ff18bd( lootid )
{
    function_ace7a24559a019fb();
    var_7237854e3be197ca = function_389a4f515c2668d4( level.var_16e1c38355341288, #lootid, lootid );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    println( "<dev string:xb2>" + lootid );
}

// Namespace loot
// Params 1
// Checksum 0xc99beed2, Offset: 0xbe0
// Size: 0x2e
function function_f9c3c4cb22370a36( typevalue )
{
    return function_389a4f515c2668d4( level.lootmaster, #typevalue, typevalue ).typename;
}

// Namespace loot
// Params 1
// Checksum 0xda6b0fc4, Offset: 0xc17
// Size: 0x2e
function function_a7da1aae18be3d0c( typename )
{
    return function_389a4f515c2668d4( level.lootmaster, #typename, typename ).typevalue;
}

// Namespace loot
// Params 1
// Checksum 0x19453bf8, Offset: 0xc4e
// Size: 0x5a
function function_52cf8374c44a4ff5( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    lootinfo = getlootiteminfofromid( lootid );
    
    if ( !isdefined( lootinfo.category ) )
    {
        return;
    }
    
    typename = lootinfo.category;
    
    if ( typename == "" )
    {
        return;
    }
    
    return typename;
}

// Namespace loot
// Params 1
// Checksum 0x783a3a00, Offset: 0xcb1
// Size: 0x60
function function_5f0a3b2f02f64376( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    lootinfo = getlootiteminfofromid( lootid );
    
    if ( !( isdefined( lootinfo ) && isdefined( lootinfo.primaryproject ) ) )
    {
        return;
    }
    
    primaryproject = lootinfo.primaryproject;
    
    if ( primaryproject == "" )
    {
        return;
    }
    
    return primaryproject;
}

// Namespace loot
// Params 2
// Checksum 0x4ecb54b4, Offset: 0xd1a
// Size: 0x2bc
function function_5fea6a6dee392b8( lootid, weaponrootname )
{
    uniqueref = function_f54ecb89dfab8e8c( lootid );
    bundledata = weapon::function_e0801e95ac4c4925( uniqueref, [ #"baseref", #"category" ] );
    conversionkitname = undefined;
    
    if ( isdefined( bundledata ) && bundledata.category == "CONVERSIONKIT" )
    {
        conversionkitname = uniqueref;
    }
    
    if ( isdefined( bundledata ) && isdefined( bundledata.baseref ) && bundledata.baseref != "" )
    {
        if ( bundledata.baseref != uniqueref )
        {
            var_4ac39864cfcaa467 = weapon::function_e0801e95ac4c4925( bundledata.baseref, [ #"lootid", #"category" ] );
            assert( isdefined( var_4ac39864cfcaa467 ), "<dev string:xe7>" + bundledata.baseref );
            
            if ( isdefined( var_4ac39864cfcaa467 ) && var_4ac39864cfcaa467.lootid != 0 )
            {
                lootid = var_4ac39864cfcaa467.lootid;
                
                if ( var_4ac39864cfcaa467.category == "CONVERSIONKIT" )
                {
                    conversionkitname = bundledata.baseref;
                }
                else
                {
                    conversionkitname = undefined;
                }
            }
        }
    }
    
    foreach ( slot in level.attachmentslotarray )
    {
        if ( !isdefined( weaponrootname ) )
        {
            break;
        }
        
        var_8672e9cd534b1c9f = function_2e5ecdd8ac47f308( weaponrootname, slot, 1 );
        
        if ( isdefined( var_8672e9cd534b1c9f ) )
        {
            foreach ( attachment in var_8672e9cd534b1c9f )
            {
                id = getscriptbundlefieldvalue( hashcat( %"hash_3c2c9813bb16552f", attachment ), #"lootid" );
                
                if ( !isdefined( id ) )
                {
                    logprint( "^3Failed to find attachment data with a valid id for [" + attachment + "] despite the weapon [" + weaponrootname + "] listing it as a possible attachment." );
                    continue;
                }
                
                if ( id != lootid )
                {
                    continue;
                }
                
                if ( isdefined( conversionkitname ) && conversionkitname != attachment )
                {
                    continue;
                }
                
                return attachment;
            }
        }
    }
    
    return uniqueref;
}

// Namespace loot
// Params 1
// Checksum 0x881afdbb, Offset: 0xfdf
// Size: 0x7a
function function_f54ecb89dfab8e8c( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    var_7237854e3be197ca = level.var_b2f40628ef3d5319[ lootid ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_b2f40628ef3d5319 ) )
    {
        level.var_b2f40628ef3d5319 = [];
    }
    
    itemref = getlootiteminfofromid( lootid ).itemref;
    
    if ( itemref )
    {
        level.var_b2f40628ef3d5319[ lootid ] = itemref;
    }
    
    return itemref;
}

// Namespace loot
// Params 1
// Checksum 0xbbcfdfb1, Offset: 0x1062
// Size: 0x7e
function getlootidfromref( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_c2ec1ee1716fa425 ) )
    {
        level.var_c2ec1ee1716fa425 = [];
    }
    
    var_7237854e3be197ca = level.var_c2ec1ee1716fa425[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    lootid = getLootItemInfoFromRef( ref ).itemid;
    
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    level.var_c2ec1ee1716fa425[ ref ] = lootid;
    return lootid;
}

// Namespace loot
// Params 1
// Checksum 0xc69bc1ce, Offset: 0x10e9
// Size: 0x186
function function_25cbc3f93cc261bf( type )
{
    if ( !isdefined( type ) )
    {
        return;
    }
    
    switch ( type )
    {
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_511d3c24fcedcdb1":
            return "weapon";
        case #"hash_933827ed049cbeb9":
            return "special_weapon";
        case #"hash_339227cb650975db":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
            return "equipment";
        case #"hash_9b65aa0f76e2e865":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            return "super";
        case #"hash_1cac65e1b8bf24a7":
            return "killstreak";
        case #"hash_ab671284a3fc4e3d":
            return "perk";
        case #"hash_4a01666eb6c388c8":
            return "attachment";
        case #"hash_59b8e9d05b31ff9":
        case #"hash_7d516d84d0a82f2":
        case #"hash_d42d44f53610ee5":
        case #"hash_13d1f84d0ae96a5f":
        case #"hash_55425b6c36803a4c":
        case #"hash_5e0a8ff36bce5106":
        case #"hash_6287e3a709aed1ed":
        case #"hash_68f4eeaa46e980a8":
        case #"hash_69146251ab5ca13a":
        case #"hash_7142f43f1e6394cf":
        case #"hash_7b7fff9980d178cf":
        case #"hash_8499464a48c4e157":
        case #"hash_bf5597954aaed3d7":
            return "consumable";
    }
}

// Namespace loot
// Params 1
// Checksum 0xb63febfe, Offset: 0x1278
// Size: 0x90
function function_3bbf7813accff0d9( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    var_7237854e3be197ca = level.br_pickups.br_weapontoscriptable[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = level.br_pickups.br_equipnametoscriptable[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = level.br_pickups.var_5515c706eaccd3[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace loot
// Params 1
// Checksum 0xd45ee37a, Offset: 0x1310
// Size: 0x6c
function getScriptableFromLootID( lootid )
{
    scriptable = namespace_9d8e359c3b1041e5::getscriptablefromlootidsharedfunc( lootid );
    
    if ( isdefined( scriptable ) )
    {
        return scriptable;
    }
    
    var_7237854e3be197ca = level.br_pickups.var_cf921d0c5390e142[ lootid ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    ref = function_f54ecb89dfab8e8c( lootid );
    return function_3bbf7813accff0d9( ref );
}

// Namespace loot
// Params 1
// Checksum 0xd60cc405, Offset: 0x1385
// Size: 0x100
function function_d3e3bcaea591a6a2( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"getlootidfromref" ) )
    {
        return level [[ utility::getsharedfunc( #"game", #"getlootidfromref" ) ]]( ref );
    }
    
    var_7237854e3be197ca = level.br_pickups.var_2e379e316c36bf4a[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( isdefined( level.br_pickups.br_lootreference[ ref ] ) && isdefined( level.br_pickups.br_itemtype[ ref ] ) )
    {
        return getlootidfromref( level.br_pickups.br_lootreference[ ref ] );
    }
    
    if ( isdefined( level.br_pickups.br_equipname[ ref ] ) )
    {
        return getlootidfromref( level.br_pickups.br_equipname[ ref ] );
    }
}

// Namespace loot
// Params 1
// Checksum 0x5684edb1, Offset: 0x148d
// Size: 0x1e
function function_19b5dfbb93a81e04( lootid )
{
    return function_5c29f3f1f5ff18bd( lootid ).cost;
}

// Namespace loot
// Params 1
// Checksum 0x97c4b358, Offset: 0x14b4
// Size: 0x31
function function_9aa227aad7652d16( scriptablename )
{
    lootid = function_d3e3bcaea591a6a2( scriptablename );
    
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    return function_50aa4aee29aee621( lootid );
}

// Namespace loot
// Params 1
// Checksum 0x9412b4a1, Offset: 0x14ee
// Size: 0x1f, Type: bool
function function_50aa4aee29aee621( lootid )
{
    return !function_5c29f3f1f5ff18bd( lootid ).unequippable;
}

// Namespace loot
// Params 1
// Checksum 0x79ff5f5c, Offset: 0x1516
// Size: 0x216
function function_c0c6b52344a55671( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    switch ( ref )
    {
        case #"hash_aa60ec2aec479ec8":
            return "super_tac_cover";
        case #"hash_c848458cca24d656":
            return "super_trophy";
        case #"hash_de0fbd002a2503b7":
            return "super_recon_drone";
        case #"hash_8bb4a7de3879026d":
            return "super_deadsilence";
        case #"hash_b593201e2eae5dcd":
            return "super_support_box";
        case #"hash_ecd28780631ff043":
            return "super_ammo_drop";
        case #"hash_91076f076ee682f4":
            return "super_armor_drop";
        case #"hash_5bb446fe7b2c92da":
            return "super_haunted_drop";
        case #"hash_b3d0752364b0193d":
            return "super_utility_drop";
        case #"hash_4d6bb233bacb2d87":
            return "super_battlerage";
        case #"hash_2ee3956fc66771d2":
            return "super_stimpistol";
        case #"hash_8e058a166a2a6049":
            return "super_deployed_decoy";
        case #"hash_1eeb976ed8edf3e2":
            return "super_tac_camera";
        case #"hash_ac9ba190f352c1f":
            return "super_emp_pulse";
        case #"hash_4cbb2e16d7934fbc":
            return "super_supply_drop";
        case #"hash_9abd51e099d625":
            return "super_fulton";
        case #"hash_59c61d6301a0c38f":
            return "super_vehicle_drop";
        case #"hash_f4e4d96da65cbe0c":
            return "super_sound_veil";
        case #"hash_7c09786dbc292c05":
            return "super_sonar_pulse";
        case #"hash_221cbd05ce8eda95":
            return "super_suppression_rounds";
        case #"hash_1a66514788f13506":
            return "super_reinforcement_flare";
        case #"hash_d83c44d7d3de6d4a":
            return "super_personal_redeploy_drone";
        case #"hash_d7c0526ce6fa6664":
            return "super_oxygen_mask";
        case #"hash_26da5d1481b16057":
            return "super_squadrage";
        case #"hash_4b4a6458f00d9319":
            return "super_hb_sensor";
        case #"hash_d3dba172bb61068c":
            return "super_redeploy_drone_beacon";
        case #"hash_b4bddb9307cef53c":
            return "super_contract_skipper";
        case #"hash_6fd1fe9f5304719a":
            return "super_mutation_ninja_vanish";
    }
}

// Namespace loot
// Params 1
// Checksum 0x75e3070b, Offset: 0x1735
// Size: 0x1a
function function_f2c2d1fd3285a91d( lootid )
{
    return function_e147eb0fef559d72( getScriptableFromLootID( lootid ) );
}

// Namespace loot
// Params 1
// Checksum 0xaae8a49f, Offset: 0x1758
// Size: 0x2f, Type: bool
function function_e147eb0fef559d72( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    return level.br_pickups.counts[ scriptablename ] ?? 0;
}

// Namespace loot
// Params 1
// Checksum 0xb47a3446, Offset: 0x1790
// Size: 0x30
function function_7ece35b2b5205ad( lootid )
{
    if ( !isdefined( level.var_7dcfd72b3473e97d ) )
    {
        function_36413802e4a9f188();
    }
    
    return arraycontains( level.var_7dcfd72b3473e97d, lootid );
}

// Namespace loot
// Params 1
// Checksum 0x7ab8f824, Offset: 0x17c9
// Size: 0x4b
function isitembannedbyref( ref )
{
    if ( !isdefined( level.var_7dcfd72b3473e97d ) )
    {
        function_36413802e4a9f188();
    }
    
    if ( arraycontains( level.var_77778f180e1e6ad3, ref ) )
    {
        return 1;
    }
    
    return arraycontains( level.var_7dcfd72b3473e97d, getlootidfromref( ref ) );
}

// Namespace loot
// Params 1
// Checksum 0x92da7a6d, Offset: 0x181d
// Size: 0xe6
function function_c09d31266119497d( rarity )
{
    if ( !rarity )
    {
        assertmsg( "<dev string:x111>" );
        return 20;
    }
    
    switch ( rarity )
    {
        case #"hash_c2edf9ba6f0b9554":
            return 0;
        case #"hash_2e81c71244ed0403":
            return 1;
        case #"hash_6890a955031d74fd":
            return 2;
        case #"hash_b66a81c9f9084ac8":
            return 3;
        case #"hash_691fdd7406b568aa":
            return 4;
        case #"hash_14260078fe1cadb5":
            return 5;
        case #"hash_ca19b00c4dd1a7":
            return 6;
        case #"hash_38b18aaab011f3a8":
            return 18;
        case #"hash_f92869b5447d6a18":
            return 19;
        case #"hash_19139d07b705acac":
            return 20;
        default:
            assertmsg( "<dev string:x140>" + rarity );
            return 20;
    }
}

