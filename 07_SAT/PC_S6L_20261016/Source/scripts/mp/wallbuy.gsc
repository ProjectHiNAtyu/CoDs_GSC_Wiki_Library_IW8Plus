// scripts\mp\wallbuy.gsc  (hash_7df061afe12b8318.gscc) (size: 28742 Bytes / 0x7046 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38b53e0f (951401999)
// size ...... 28742 (0x7046)
// includes .. 15  (offset: 0x6ab6)
// strings ... 38  (offset: 0x6b2e)
// dev strs .. 50  (offset: 0x6dc6)
// exports ... 59  (offset: 0x4922)
// cseg ...... 0x35f + 0x45c3 (0x4922)
// imports ... 203 (offset: 0x525a)
// animtree1 . 0   (offset: 0x7046)
// animtree2 . 0   (offset: 0x7046)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\weaponmetadata;
#using scripts\mp\weapons;

#namespace wallbuy;

// Namespace wallbuy
// Params 0, eflags: 0x5
// Checksum 0x219f8191, Offset: 0x37d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"wallbuy", undefined, &__init__, undefined );
}

// Namespace wallbuy
// Params 0
// Checksum 0x1bd0f90d, Offset: 0x39e
// Size: 0xa
function __init__()
{
    level thread function_6b26d12b6e1f3683();
}

// Namespace wallbuy
// Params 1
// Checksum 0x40618c2d, Offset: 0x3b0
// Size: 0x397
function function_6b26d12b6e1f3683( var_c9c6c666b81696b6 )
{
    utility::flag_init( "wallbuy_ready" );
    var_1cd4c25867e233df = level.gametypebundle.wallbuybundle ?? level.gamemodebundle.wallbuybundle;
    level.wallbuybundle = getscriptbundle( "wallbuy:" + var_1cd4c25867e233df );
    utility::flag_wait( "content_manager_initialized" );
    content_manager::function_3209da123476142f( "wallbuy", &on_spawn_wallbuy );
    content_manager::register_disable_toggle( "wallbuy", &content_manager::function_5d04e50a29a2142c, &function_d2e4e3d71fdec0a9, &function_c065fc0d1c1800a2 );
    level.wallbuy_currency_type = level.weaponmetadata[ "wallbuy_settings" ].var_4f89042344f3ffde ?? #"essence";
    level.var_6d19a7bd6f5ca21a = level.weaponmetadata[ "wallbuy_settings" ].var_6c0293f8e2c934b8 ?? 1000;
    level.var_c9c6c666b81696b6 = [];
    level.var_a1e014d3b627d368 = spawnstruct();
    level.var_a1e014d3b627d368.reloadcost = level.wallbuybundle.reloadcost;
    level.var_a1e014d3b627d368.var_b73cf47f78dc7922 = level.wallbuybundle.var_cc8793402a2e95f9;
    level.var_a1e014d3b627d368.var_b73cf37f78dc76ef = level.wallbuybundle.var_cc8790402a2e8f60;
    level.var_a1e014d3b627d368.var_b73cf27f78dc74bc = level.wallbuybundle.var_cc8791402a2e9193;
    level.var_a1e014d3b627d368.var_b73cf17f78dc7289 = level.wallbuybundle.var_cc8796402a2e9c92;
    level setup_wallbuy_weapons( var_c9c6c666b81696b6 );
    level.wallbuy_variants = [];
    
    if ( isdefined( level.wallbuybundle.var_687480df02c786a1 ) )
    {
        level.var_49911708ccd031bf = setup_variant_wallbuys( level.wallbuybundle.var_687480df02c786a1 );
        level.var_139e91e252a2df0c = [];
        
        foreach ( var_ba8d8fbc30d8e26c in level.wallbuybundle.var_687480df02c786a1 )
        {
            if ( isdefined( var_ba8d8fbc30d8e26c.armorlevel ) && !var_ba8d8fbc30d8e26c.var_63742ca90c328008 )
            {
                level.var_139e91e252a2df0c[ var_ba8d8fbc30d8e26c.armorlevel ] = var_ba8d8fbc30d8e26c;
            }
        }
    }
    
    /#
        level thread setup_wallbuy_devgui();
    #/
    
    level._effect[ "vfx_wallbuy_upgrade" ] = loadfxasset( level.wallbuybundle.var_b2bb9a6dfe3085b9 ?? "vfx_t10_gameplay_zm_wallbuy_upgrade" );
    
    if ( !level.gamemodebundle.var_c214fc63695cd685 )
    {
        level thread init_wallbuy_postmain();
    }
    else
    {
        level callback::add( "ob_content_process_create_script", &function_9508cd29cfb39802 );
    }
    
    level callback::add( "on_round_end", &on_round_end );
    utility::registersharedfunc( #"wallbuy", #"get_wallbuy_scriptable", &get_wallbuy_scriptable );
    utility::registersharedfunc( #"wallbuy", #"hash_d188728d6e7395f5", &function_c2a9b9b2e4b90c0a );
    
    /#
        level thread setup_weapon_rarity_devgui();
    #/
}

// Namespace wallbuy
// Params 3
// Checksum 0x228605ed, Offset: 0x74f
// Size: 0x60
function function_2cf9e927b4199326( variant_type_name, var_525a259402658d7e, var_fbb806c5df70a428 )
{
    utility::registersharedfunc( hashcat( #"hash_98a94353ec1044cc", variant_type_name ), #"hash_aabdea2170a670c7", var_525a259402658d7e );
    utility::registersharedfunc( hashcat( #"hash_98a94353ec1044cc", variant_type_name ), #"hash_eb2053cea864e5ab", var_fbb806c5df70a428 );
}

/#

    // Namespace wallbuy
    // Params 0
    // Checksum 0x4919defa, Offset: 0x7b7
    // Size: 0x2f, Type: dev
    function setup_wallbuy_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x31>", "<dev string:x48>", &debug_update_rarity, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace wallbuy
// Params 0
// Checksum 0xf0f1594b, Offset: 0x7ee
// Size: 0xd0
function init_wallbuy_postmain()
{
    level endon( #"game_ended" );
    waittillframeend();
    utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    
    if ( isdefined( var_959dbddcfff2592d ) && var_959dbddcfff2592d.size > 0 )
    {
        foreach ( destination in var_959dbddcfff2592d )
        {
            level function_8a61cea25fb92cf0( destination );
        }
    }
    
    utility::flag_set( "wallbuy_ready" );
}

// Namespace wallbuy
// Params 1
// Checksum 0x77d9254d, Offset: 0x8c6
// Size: 0x118
function function_8a61cea25fb92cf0( destination )
{
    foreach ( location in destination.locations )
    {
        wallbuy = location.instances[ "wallbuy" ];
        
        if ( isdefined( wallbuy ) )
        {
            foreach ( instance in wallbuy.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0xb32db994, Offset: 0x9e6
// Size: 0x1a1
function function_9508cd29cfb39802( sparams )
{
    level.var_38f42d124c1fc599 = [];
    var_aa72fc23f7515d32 = utility::getstructarray( "content_struct", "variantname" );
    var_759a4a0f92d9f29f = [];
    
    foreach ( struct in var_aa72fc23f7515d32 )
    {
        if ( !isdefined( struct.wallbuy_scriptable ) && isdefined( struct.content_key ) && struct.content_key == "wallbuy_spawn" )
        {
            var_759a4a0f92d9f29f[ var_759a4a0f92d9f29f.size ] = struct;
        }
    }
    
    if ( isdefined( level.var_37ee95c5464d47be ) )
    {
        var_759a4a0f92d9f29f = [[ level.var_37ee95c5464d47be ]]( "wallbuy", var_759a4a0f92d9f29f );
    }
    
    foreach ( struct in var_759a4a0f92d9f29f )
    {
        var_5fc50378c6914d59 = function_c2a9b9b2e4b90c0a( struct );
        level.var_38f42d124c1fc599[ level.var_38f42d124c1fc599.size ] = var_5fc50378c6914d59;
    }
    
    callback::callback( "ob_wallbuys_create_script_done" );
    utility::flag_set( "wallbuy_ready" );
}

// Namespace wallbuy
// Params 1
// Checksum 0xdc0223ef, Offset: 0xb8f
// Size: 0xcd
function on_spawn_wallbuy( struct )
{
    assert( isstruct( struct ), "<dev string:x5f>" );
    
    if ( isdefined( level.var_fae6d1257d19cfb ) )
    {
        return;
    }
    
    spawn_points = struct.var_1d6cddfc47031bff[ "wallbuy_spawn" ];
    
    if ( isdefined( spawn_points ) )
    {
        foreach ( point in spawn_points )
        {
            if ( point content_manager::function_e0f0562adcd2c071() )
            {
                point function_c2a9b9b2e4b90c0a( point, undefined );
            }
        }
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0xce73d26f, Offset: 0xc64
// Size: 0xcd
function setup_wallbuy_weapons( var_c9c6c666b81696b6 )
{
    if ( isdefined( level.weaponmetadata ) )
    {
        var_c9c6c666b81696b6 = [];
        
        foreach ( var_2e08e94c9cb1747c, var_fe68cd50dcda7fdc in level.weaponmetadata )
        {
            if ( isstruct( var_fe68cd50dcda7fdc ) && isdefined( var_fe68cd50dcda7fdc.wallbuyscriptable ) )
            {
                var_c9c6c666b81696b6[ var_2e08e94c9cb1747c ] = var_fe68cd50dcda7fdc;
            }
        }
    }
    
    /#
        if ( !isdefined( var_c9c6c666b81696b6 ) )
        {
            assertmsg( "<dev string:x7a>" );
        }
    #/
    
    level.var_c9c6c666b81696b6 = var_c9c6c666b81696b6;
}

// Namespace wallbuy
// Params 1
// Checksum 0xe7344704, Offset: 0xd39
// Size: 0xb4
function setup_variant_wallbuys( variantlist )
{
    var_fd933ae00658724f = [];
    
    if ( isarray( variantlist ) )
    {
        foreach ( variantinfo in variantlist )
        {
            if ( isstruct( variantinfo ) && isdefined( variantinfo.scriptable ) )
            {
                var_fd933ae00658724f[ variantinfo.scriptable ] = variantinfo;
            }
        }
    }
    
    return var_fd933ae00658724f;
}

// Namespace wallbuy
// Params 2
// Checksum 0x50018dc4, Offset: 0xdf6
// Size: 0x19d
function function_5a5f7ce4fe9e322a( point, var_9a65918d435f6dbf )
{
    var_93a7f94d17c09da3 = "ob_jup_item_weapon_ar_bromeo805";
    regiondifficulty = "difficulty_undefined";
    
    if ( !isdefined( var_9a65918d435f6dbf ) )
    {
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( point );
        }
    }
    else
    {
        regiondifficulty = var_9a65918d435f6dbf;
    }
    
    if ( regiondifficulty != "difficulty_undefined" && isdefined( level.wallbuybundle.var_3497dc20c1f4c453 ) )
    {
        var_c2a717d146660202 = 0;
        
        switch ( regiondifficulty )
        {
            case #"hash_7bb2cd766703d463":
                var_c2a717d146660202 = level.wallbuybundle.var_87a39ca946129390;
                break;
            case #"hash_af83e47edfa8900a":
                var_c2a717d146660202 = level.wallbuybundle.var_74ff45e341fe523f;
                break;
            case #"hash_5343b465e56ec9a4":
                var_c2a717d146660202 = level.wallbuybundle.var_7e7c601b761ba679;
                break;
            default:
                var_c2a717d146660202 = level.wallbuybundle.var_7e7c601b761ba679;
                break;
        }
        
        if ( isdefined( var_c2a717d146660202 ) )
        {
            var_bf56d62bb4ede994 = common_item::items_selectfromlist( var_c2a717d146660202, 1 );
            
            if ( var_bf56d62bb4ede994.size > 0 )
            {
                var_a4b74322e8e657b4 = getscriptbundle( var_bf56d62bb4ede994[ 0 ] );
                
                if ( isdefined( var_a4b74322e8e657b4.baseweapon ) )
                {
                    return var_a4b74322e8e657b4.baseweapon;
                }
            }
            else
            {
                assertmsg( "<dev string:x9b>" + var_c2a717d146660202 );
            }
            
            return var_93a7f94d17c09da3;
        }
    }
    
    println( "<dev string:xca>" );
    return var_93a7f94d17c09da3;
}

// Namespace wallbuy
// Params 2
// Checksum 0x2b75324d, Offset: 0xf9c
// Size: 0xc7
function function_e936e9fcedcf1f75( structspawn, weapon_name )
{
    difficulty = undefined;
    
    switch ( weapon_name )
    {
        case #"hash_b2e10c40219f4a4e":
            return [ weapon_name, 1 ];
        case #"hash_effd2298700f0b22":
            return [ weapon_name, 1, "difficulty_easy" ];
        case #"hash_b2671eb78c100817":
            return [ weapon_name, 1, "difficulty_normal" ];
        case #"hash_b0f23a91ee977869":
            return [ weapon_name, 1, "difficulty_hard" ];
    }
    
    return [ weapon_name, 0 ];
}

// Namespace wallbuy
// Params 2
// Checksum 0xa27f49dc, Offset: 0x106c
// Size: 0x67
function function_f4b2a422a5738164( structspawn, weapon_name )
{
    var_c29643ab961b3d5e = function_e936e9fcedcf1f75( structspawn, weapon_name );
    weapon_name = var_c29643ab961b3d5e[ 0 ];
    var_e5930abecf778d19 = var_c29643ab961b3d5e[ 1 ];
    var_546e4eb5269dbafa = var_c29643ab961b3d5e[ 2 ];
    
    if ( var_e5930abecf778d19 )
    {
        weapon_name = function_5a5f7ce4fe9e322a( structspawn.origin, var_546e4eb5269dbafa );
    }
    
    return weapon_name;
}

// Namespace wallbuy
// Params 2
// Checksum 0x3e74541a, Offset: 0x10dc
// Size: 0xf4
function function_c2a9b9b2e4b90c0a( structspawn, forcedrarity )
{
    wallbuy_name = structspawn.script_noteworthy;
    wallbuy_name = function_f4b2a422a5738164( structspawn, wallbuy_name );
    
    if ( !isdefined( wallbuy_name ) )
    {
        assert( "<dev string:x116>" );
    }
    
    weapon = makeweapon( wallbuy_name );
    weapon_root_name = weapon.var_1616e6fbba9a722d;
    var_98fe32d0f123fcbe = get_wallbuy_scriptable( weapon_root_name );
    
    if ( !isdefined( level.var_caf65b937e9cbfaf ) )
    {
        level.var_caf65b937e9cbfaf = [];
    }
    
    if ( !arraycontains( level.var_caf65b937e9cbfaf, structspawn ) )
    {
        level.var_caf65b937e9cbfaf[ level.var_caf65b937e9cbfaf.size ] = structspawn;
    }
    
    if ( isdefined( var_98fe32d0f123fcbe ) )
    {
        wallbuyscriptable = function_351154aae2b044e5( structspawn, forcedrarity, weapon_root_name, wallbuy_name, var_98fe32d0f123fcbe );
        return wallbuyscriptable;
    }
    
    wallbuyscriptable = function_d925a3a846d30612( structspawn, forcedrarity, wallbuy_name );
    return wallbuyscriptable;
}

// Namespace wallbuy
// Params 5
// Checksum 0x1cf0bf29, Offset: 0x11d9
// Size: 0x289
function function_351154aae2b044e5( structspawn, forcedrarity, weapon_root_name, weapon_name, scriptablename )
{
    if ( level.gametypebundle.disablewallbuys )
    {
        return;
    }
    
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    rarity = structspawn get_rarity_distribution();
    
    if ( isdefined( forcedrarity ) )
    {
        rarity = forcedrarity;
    }
    
    var_6d19a7bd6f5ca21a = get_wallbuy_cost( weapon_root_name, rarity );
    var_e70b9ac867e905d3 = get_wallbuy_weapon( weapon_root_name );
    var_8a968ea891a86d04 = get_wallbuy_item( weapon_root_name );
    wallbuy_bundle = getscriptbundle( var_8a968ea891a86d04 );
    mapinfo = getactivemapinfobundle();
    var_d2e325ed1ceba400 = mapinfo.var_4a98227bf6f428ba;
    
    if ( isarray( var_d2e325ed1ceba400 ) )
    {
        foreach ( var_232bf4cbe3e7f0ce in var_d2e325ed1ceba400 )
        {
            if ( var_232bf4cbe3e7f0ce.var_5d4a55e1eb574935 == scriptablename )
            {
                scriptablename = var_232bf4cbe3e7f0ce.override;
            }
        }
    }
    
    wallbuy_scriptable = spawnscriptable( scriptablename, structspawn.origin, structspawn.angles );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", wallbuy_scriptable, "icon" );
    function_ef135a26415497af( wallbuy_scriptable, rarity );
    wallbuy_scriptable = interaction::register_scriptable_interact( wallbuy_scriptable, &function_c8c8a561d596b8f );
    wallbuy_scriptable interaction::function_3d5329c553924b3();
    wallbuy_scriptable interaction::set_interact_hint_callback( &setup_wallbuy_hintstring );
    wallbuy_scriptable.cost = var_6d19a7bd6f5ca21a;
    wallbuy_scriptable.weapon = var_e70b9ac867e905d3;
    wallbuy_scriptable.weapon_name = weapon_name;
    wallbuy_scriptable.rarity = rarity;
    wallbuy_scriptable.scriptable_name = scriptablename;
    wallbuy_scriptable.itementry = var_8a968ea891a86d04;
    wallbuy_scriptable.weapon_root_name = weapon_root_name;
    wallbuy_scriptable.icon = wallbuy_bundle.icon;
    structspawn.wallbuy_scriptable = wallbuy_scriptable;
    
    if ( !isdefined( level.var_e69afc14a07b4f3d ) )
    {
        level.var_e69afc14a07b4f3d = [];
    }
    
    level.var_e69afc14a07b4f3d[ weapon_root_name ] = 1;
    return structspawn;
}

// Namespace wallbuy
// Params 0
// Checksum 0xac78fed5, Offset: 0x146b
// Size: 0x15
function function_3401a0a7b55ffbdb()
{
    return level.wallbuybundle.var_63742ca90c328008;
}

// Namespace wallbuy
// Params 3
// Checksum 0x4623b75b, Offset: 0x1489
// Size: 0x375
function function_d925a3a846d30612( structspawn, forcedrarity, wallbuy_name )
{
    string_array = strtok( wallbuy_name, "_" );
    b_armor_wallbuy = arraycontains( string_array, "armor" );
    
    if ( level.gametypebundle.var_c1e5bbace58c9528 && b_armor_wallbuy )
    {
        return;
    }
    
    if ( b_armor_wallbuy && function_3401a0a7b55ffbdb() )
    {
        foreach ( var_ba8d8fbc30d8e26c in level.var_49911708ccd031bf )
        {
            if ( var_ba8d8fbc30d8e26c.var_63742ca90c328008 )
            {
                var_cab78f2dcd1cfc65 = var_ba8d8fbc30d8e26c;
            }
        }
    }
    
    if ( !isdefined( var_cab78f2dcd1cfc65 ) )
    {
        var_cab78f2dcd1cfc65 = function_b1ac1ed5869786d9( wallbuy_name );
    }
    
    if ( !isdefined( var_cab78f2dcd1cfc65 ) )
    {
        return;
    }
    
    rarity = structspawn get_rarity_distribution();
    
    if ( isdefined( forcedrarity ) )
    {
        rarity = forcedrarity;
    }
    
    var_6d19a7bd6f5ca21a = get_variant_wallbuy_cost( wallbuy_name, rarity );
    wallbuy_cost_alternate = var_cab78f2dcd1cfc65.costalternate;
    wallbuy_cost_refill = var_cab78f2dcd1cfc65.costrefill;
    wallbuy_model = var_cab78f2dcd1cfc65.spawnmodel;
    var_8a968ea891a86d04 = var_cab78f2dcd1cfc65.var_d81b21fa1a5f80c;
    scriptablename = var_cab78f2dcd1cfc65.scriptable;
    wallbuytype = var_cab78f2dcd1cfc65.type;
    disable_upgrade = var_cab78f2dcd1cfc65.var_6296bed744eaccb1;
    wallbuy_scriptable = spawnscriptable( scriptablename, structspawn.origin, structspawn.angles );
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", wallbuy_scriptable, "icon" );
    function_ef135a26415497af( wallbuy_scriptable, rarity );
    
    if ( isdefined( wallbuytype ) )
    {
        var_91d4dd43c90e63a = hashcat( #"hash_98a94353ec1044cc", wallbuytype );
        
        if ( utility::issharedfuncdefined( var_91d4dd43c90e63a, #"hash_aabdea2170a670c7" ) && utility::issharedfuncdefined( var_91d4dd43c90e63a, #"hash_eb2053cea864e5ab" ) )
        {
            wallbuy_scriptable = interaction::register_scriptable_interact( wallbuy_scriptable, utility::getsharedfunc( var_91d4dd43c90e63a, #"hash_aabdea2170a670c7" ) );
            wallbuy_scriptable interaction::function_3d5329c553924b3();
            wallbuy_scriptable interaction::set_interact_hint_callback( utility::getsharedfunc( var_91d4dd43c90e63a, #"hash_eb2053cea864e5ab" ) );
        }
        else
        {
            assertmsg( "<dev string:x147>" + wallbuy_name + "<dev string:x150>" );
        }
        
        wallbuy_scriptable.cost = var_6d19a7bd6f5ca21a;
        wallbuy_scriptable.costalternate = wallbuy_cost_alternate;
        wallbuy_scriptable.costrefill = wallbuy_cost_refill;
        wallbuy_scriptable.wallbuy_spawn_model = wallbuy_model;
        wallbuy_scriptable.rarity = rarity;
        wallbuy_scriptable.scriptablename = scriptablename;
        wallbuy_scriptable.var_8a968ea891a86d04 = var_8a968ea891a86d04;
        wallbuy_scriptable.variant_type = wallbuytype;
        wallbuy_scriptable.disable_upgrade = disable_upgrade;
        wallbuy_scriptable.var_7ffbc1821f2b0602 = getxhash( scriptablename );
        structspawn.wallbuy_scriptable = wallbuy_scriptable;
        wallbuy_scriptable callback::callback( "on_variant_wallbuy_spawn" );
        return structspawn;
    }
}

// Namespace wallbuy
// Params 2
// Checksum 0x62ccfb69, Offset: 0x1806
// Size: 0xbf
function function_ef135a26415497af( wallbuy_scriptable, rarity )
{
    switch ( rarity )
    {
        case #"hash_883ff07272b4f9c":
            wallbuy_scriptable setscriptablepartstate( "wallbuy", "green" );
            break;
        case #"hash_778bb52ecd08072d":
            wallbuy_scriptable setscriptablepartstate( "wallbuy", "blue" );
            break;
        case #"hash_598a30e44f53045f":
            wallbuy_scriptable setscriptablepartstate( "wallbuy", "purple" );
            break;
        case #"hash_35bb3bd014c77f4b":
            wallbuy_scriptable setscriptablepartstate( "wallbuy", "orange" );
            break;
        default:
            wallbuy_scriptable setscriptablepartstate( "wallbuy", "base" );
            break;
    }
}

// Namespace wallbuy
// Params 2
// Checksum 0x9707207e, Offset: 0x18cd
// Size: 0x3e6
function setup_wallbuy_hintstring( usable, player )
{
    var_78a9bbaea0e11692 = abs( usable.origin[ 2 ] - 80 - player.origin[ 2 ] );
    
    if ( var_78a9bbaea0e11692 > 80 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_e830497a1d286f74 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.var_83480e7607063d3f )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    var_436166def74e7611 = usable.weapon;
    lootid = weapon::function_57559cfce1d2812d( usable.weapon );
    var_436166def74e7611 = makeweapon( var_436166def74e7611 );
    weapon_name = var_436166def74e7611.displayname;
    var_90269f24164ee19a = usable.rarity;
    var_bacc0c211bfcfcac = player currency::get_currency_amount( #"essence" );
    weapon_rarity = &"SHARED_HINTSTRINGS/LOOT_RARITY_BASE";
    weapon_icon = usable.icon;
    weapon_cost = usable.cost;
    
    if ( isdefined( player.var_bc0b9e201dc8d785 ) )
    {
        foreach ( var_a89b5e340fffb0d1 in player.var_bc0b9e201dc8d785 )
        {
            var_bcfe0ed5ba4c9e74 = player [[ var_a89b5e340fffb0d1 ]]( usable );
            
            if ( isdefined( var_bcfe0ed5ba4c9e74 ) )
            {
                weapon_cost = var_bcfe0ed5ba4c9e74;
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"wallbuy", #"hash_24b240b4ca884d15" ) )
    {
        var_66071b7285da1614 = utility::callsharedfunc( #"wallbuy", #"hash_24b240b4ca884d15", player, var_436166def74e7611, weapon_name, weapon_icon );
        
        if ( isdefined( var_66071b7285da1614 ) )
        {
            return var_66071b7285da1614;
        }
    }
    
    reload_result = level function_c4331849c3ecc665( player, var_436166def74e7611, weapon_name, weapon_icon, var_90269f24164ee19a, usable );
    
    if ( isdefined( reload_result ) )
    {
        return reload_result;
    }
    
    switch ( var_90269f24164ee19a )
    {
        case #"hash_883ff07272b4f9c":
            weapon_rarity = &"SHARED_HINTSTRINGS/LOOT_RARITY_GREEN";
            break;
        case #"hash_778bb52ecd08072d":
            weapon_rarity = &"SHARED_HINTSTRINGS/LOOT_RARITY_BLUE";
            break;
        case #"hash_598a30e44f53045f":
            weapon_rarity = &"SHARED_HINTSTRINGS/LOOT_RARITY_PURPLE";
            break;
        case #"hash_35bb3bd014c77f4b":
            weapon_rarity = &"SHARED_HINTSTRINGS/LOOT_RARITY_ORANGE";
            break;
    }
    
    obj = { #loot_id:lootid, #icon:weapon_icon, #icon_text_value:weapon_cost, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #description:weapon_rarity, #title:weapon_name, #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    
    if ( var_bacc0c211bfcfcac < weapon_cost )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        obj.interactable = 0;
    }
    
    return obj;
}

// Namespace wallbuy
// Params 6
// Checksum 0x552a5540, Offset: 0x1cbc
// Size: 0x26c
function function_c4331849c3ecc665( player, var_436166def74e7611, weapon_name, weapon_icon, wall_rarity, usable )
{
    curweapon = player getcurrentweapon();
    var_d1ad847a3b590336 = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( curweapon );
    wall_value = function_bd5a94ee7552fcbd( wall_rarity );
    
    if ( var_d1ad847a3b590336 < wall_value )
    {
        return;
    }
    
    var_1d54b58625d294b5 = var_436166def74e7611 getbaseweapon();
    var_ab13966355ea575f = undefined;
    
    foreach ( weapon in player.primaryinventory )
    {
        var_4d2571bbc7397806 = weapon getbaseweapon();
        
        if ( issameweapon( var_1d54b58625d294b5, var_4d2571bbc7397806 ) )
        {
            var_ab13966355ea575f = weapon;
        }
    }
    
    if ( isdefined( var_ab13966355ea575f ) )
    {
        var_d1ad847a3b590336 = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( var_ab13966355ea575f );
        
        if ( var_d1ad847a3b590336 < wall_value )
        {
            return;
        }
    }
    
    if ( !isdefined( var_ab13966355ea575f ) )
    {
        return;
    }
    
    cost = function_a80df1a750486e6b( player, var_ab13966355ea575f );
    cost = usable function_60355d4a5847e024( player, cost );
    obj = { #icon:weapon_icon, #icon_text_value:cost, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #description:&"SHARED_HINTSTRINGS/WALLBUY_REFILL_AMMO", #title:weapon_name, #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    var_bacc0c211bfcfcac = player currency::get_currency_amount( #"essence" );
    
    if ( var_bacc0c211bfcfcac < cost )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        obj.interactable = 0;
        return obj;
    }
    
    bfullammo = player is_weapon_ammo_full( var_ab13966355ea575f );
    
    if ( bfullammo )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/WALLBUY_AMMO_FULL";
        obj.interactable = 0;
        return obj;
    }
    
    return obj;
}

// Namespace wallbuy
// Params 1, eflags: 0x4
// Checksum 0xfd201535, Offset: 0x1f31
// Size: 0xc8
function private is_weapon_ammo_full( var_ab13966355ea575f )
{
    player = self;
    var_50bac4dcea60a475 = function_a80df1a750486e6b( player, var_ab13966355ea575f );
    max_clip_ammo = weaponclipsize( var_ab13966355ea575f );
    max_stock_ammo = utility::get_max_stock_ammo( var_ab13966355ea575f );
    currentclipammo = player getweaponammoclip( var_ab13966355ea575f );
    currentstockammo = player getweaponammostock( var_ab13966355ea575f );
    
    if ( function_fbb6adbc1a89658a( var_ab13966355ea575f ) )
    {
        var_63753858c2ea9497 = currentclipammo >= max_clip_ammo;
    }
    else
    {
        var_63753858c2ea9497 = currentclipammo >= max_clip_ammo && currentstockammo >= max_stock_ammo;
    }
    
    if ( var_ab13966355ea575f.isdualwield )
    {
        var_506693b2ebc6da6a = player getweaponammoclip( var_ab13966355ea575f, "left" );
        
        if ( var_506693b2ebc6da6a < max_clip_ammo )
        {
            var_63753858c2ea9497 = 0;
        }
    }
    
    return var_63753858c2ea9497;
}

// Namespace wallbuy
// Params 0
// Checksum 0x33691d1e, Offset: 0x2002
// Size: 0xac
function get_rarity_distribution()
{
    if ( level.gametypebundle.var_1eb2c0b45fe36409 )
    {
        rarity = "white";
    }
    else if ( isdefined( self.script_string ) && self.script_string != "" )
    {
        rarity = self.script_string;
    }
    else
    {
        rarity = "white";
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_e29bc9f93cc9ba4" ) )
    {
        override_rarity = utility::callsharedfunc( #"zombie", #"hash_e29bc9f93cc9ba4", rarity );
        
        if ( isdefined( override_rarity ) )
        {
            rarity = override_rarity;
        }
    }
    
    return rarity;
}

// Namespace wallbuy
// Params 1
// Checksum 0xb176876b, Offset: 0x20b7
// Size: 0x53
function get_wallbuy_item( weapon_name )
{
    if ( isdefined( weapon_name ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ] ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ].itementry ) )
    {
        return level.var_c9c6c666b81696b6[ weapon_name ].itementry;
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0xcca99bbd, Offset: 0x2112
// Size: 0x53
function get_wallbuy_weapon( weapon_name )
{
    if ( isdefined( weapon_name ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ] ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ].weapon ) )
    {
        return level.var_c9c6c666b81696b6[ weapon_name ].weapon;
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0x2b15803e, Offset: 0x216d
// Size: 0x85
function get_wallbuy_scriptable( weapon_name )
{
    /#
        if ( isdefined( weapon_name ) && !isdefined( level.var_c9c6c666b81696b6[ weapon_name ] ) )
        {
            println( "<dev string:x1a1>" + getxhashsourcename( weapon_name ) + "<dev string:x1b3>" );
        }
    #/
    
    if ( isdefined( weapon_name ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ] ) && isdefined( level.var_c9c6c666b81696b6[ weapon_name ].wallbuyscriptable ) )
    {
        return level.var_c9c6c666b81696b6[ weapon_name ].wallbuyscriptable;
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0x64b051b7, Offset: 0x21fa
// Size: 0x2f
function function_b1ac1ed5869786d9( wallbuy_name )
{
    if ( isdefined( wallbuy_name ) && isdefined( level.var_49911708ccd031bf[ wallbuy_name ] ) )
    {
        return level.var_49911708ccd031bf[ wallbuy_name ];
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0x977d369d, Offset: 0x2231
// Size: 0x2f
function function_7cd289ee83ffd8d2( n_armor_level )
{
    if ( isdefined( n_armor_level ) && isdefined( level.var_139e91e252a2df0c[ n_armor_level ] ) )
    {
        return level.var_139e91e252a2df0c[ n_armor_level ];
    }
}

// Namespace wallbuy
// Params 2
// Checksum 0xaff47879, Offset: 0x2268
// Size: 0x26e
function get_wallbuy_cost( weapon_root_name, rarity )
{
    cost = level.var_6d19a7bd6f5ca21a;
    
    if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ] ) )
    {
        if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_17cdc34f7e3374a ) )
        {
            cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_17cdc34f7e3374a;
        }
        
        switch ( rarity )
        {
            case #"hash_883ff07272b4f9c":
                if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_23cb9f326db8a91c ) )
                {
                    cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_23cb9f326db8a91c;
                }
                else
                {
                    cost += 500;
                }
                
                break;
            case #"hash_778bb52ecd08072d":
                if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_c669f83c0a42d027 ) )
                {
                    cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_c669f83c0a42d027;
                }
                else
                {
                    cost += 1500;
                }
                
                break;
            case #"hash_598a30e44f53045f":
                if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_dd05784382c1291 ) )
                {
                    cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_dd05784382c1291;
                }
                else
                {
                    cost += 2500;
                }
                
                break;
            case #"hash_35bb3bd014c77f4b":
                if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_c3259532a851aced ) )
                {
                    cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_c3259532a851aced;
                }
                else
                {
                    cost += 3500;
                }
                
                break;
            default:
                if ( isdefined( level.var_c9c6c666b81696b6[ weapon_root_name ].var_17cdc34f7e3374a ) )
                {
                    cost = level.var_c9c6c666b81696b6[ weapon_root_name ].var_17cdc34f7e3374a;
                }
                else
                {
                    cost = 1000;
                }
                
                break;
        }
    }
    else
    {
        switch ( rarity )
        {
            case #"hash_883ff07272b4f9c":
                cost += 500;
                break;
            case #"hash_778bb52ecd08072d":
                cost += 1500;
                break;
            case #"hash_598a30e44f53045f":
                cost += 2500;
                break;
            case #"hash_35bb3bd014c77f4b":
                cost += 3500;
                break;
            default:
                cost = 1000;
                break;
        }
    }
    
    return cost;
}

// Namespace wallbuy
// Params 2
// Checksum 0xfadad535, Offset: 0x24df
// Size: 0x1ab
function get_variant_wallbuy_cost( wallbuy_name, rarity )
{
    cost = level.var_6d19a7bd6f5ca21a;
    var_cab78f2dcd1cfc65 = function_b1ac1ed5869786d9( wallbuy_name );
    
    if ( isdefined( var_cab78f2dcd1cfc65 ) )
    {
        if ( isdefined( var_cab78f2dcd1cfc65.costbase ) )
        {
            cost = var_cab78f2dcd1cfc65.costbase;
        }
        
        var_f213ae944e9e2ccb = 0;
        
        switch ( rarity )
        {
            case #"hash_883ff07272b4f9c":
                var_f213ae944e9e2ccb = var_cab78f2dcd1cfc65.costuncommon ?? cost + 500;
                break;
            case #"hash_778bb52ecd08072d":
                var_f213ae944e9e2ccb = var_cab78f2dcd1cfc65.costrare ?? cost + 1500;
                break;
            case #"hash_598a30e44f53045f":
                var_f213ae944e9e2ccb = var_cab78f2dcd1cfc65.costepic ?? cost + 2500;
                break;
            case #"hash_35bb3bd014c77f4b":
                var_f213ae944e9e2ccb = var_cab78f2dcd1cfc65.costlegendary ?? cost + 3500;
                break;
            default:
                var_f213ae944e9e2ccb = var_cab78f2dcd1cfc65.costbase ?? cost + 1000;
                break;
        }
    }
    else
    {
        switch ( rarity )
        {
            case #"hash_883ff07272b4f9c":
                cost += 500;
                break;
            case #"hash_778bb52ecd08072d":
                cost += 1500;
                break;
            case #"hash_598a30e44f53045f":
                cost += 2500;
                break;
            case #"hash_35bb3bd014c77f4b":
                cost += 3500;
                break;
            default:
                cost = 1000;
                break;
        }
    }
    
    return cost;
}

// Namespace wallbuy
// Params 1
// Checksum 0x68ae1d8b, Offset: 0x2693
// Size: 0x70
function function_bd5a94ee7552fcbd( rarity )
{
    switch ( rarity )
    {
        case #"hash_883ff07272b4f9c":
            return 1;
        case #"hash_778bb52ecd08072d":
            return 2;
        case #"hash_598a30e44f53045f":
            return 3;
        case #"hash_35bb3bd014c77f4b":
            return 4;
        default:
            return 0;
    }
    
    return 0;
}

// Namespace wallbuy
// Params 2
// Checksum 0xb8377c3b, Offset: 0x270c
// Size: 0xbb
function function_60355d4a5847e024( player, cost )
{
    if ( isplayer( player ) && isdefined( player.mary_paris_mdl ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_family_discount" ) )
    {
        if ( distance2d( player.mary_paris_mdl.origin, self.origin ) <= 62500 )
        {
            var_a4038f7ff99928d9 = level.zombie_augments[ #"mary_paris_family_discount" ].var_fd44baa3fdbc070 ?? 0.5;
            cost = int( cost * var_a4038f7ff99928d9 );
        }
    }
    
    return cost;
}

// Namespace wallbuy
// Params 1
// Checksum 0x3da5a144, Offset: 0x27d0
// Size: 0x97f
function function_c8c8a561d596b8f( player )
{
    if ( !isplayer( player ) || !( isdefined( self.cost ) && isdefined( self.weapon_name ) ) )
    {
        assertmsg( "<dev string:x1d9>" );
        return;
    }
    
    if ( player.var_e830497a1d286f74 )
    {
        return;
    }
    
    if ( player.var_83480e7607063d3f )
    {
        return;
    }
    
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"wallbuy", #"player_has_weapon_override" ) )
    {
        var_66071b7285da1614 = utility::callsharedfunc( #"wallbuy", #"player_has_weapon_override", player, self.itementry );
        
        if ( var_66071b7285da1614 )
        {
            return;
        }
    }
    
    cost = self.cost;
    
    if ( isdefined( player.var_bc0b9e201dc8d785 ) )
    {
        foreach ( var_a89b5e340fffb0d1 in player.var_bc0b9e201dc8d785 )
        {
            var_bcfe0ed5ba4c9e74 = player [[ var_a89b5e340fffb0d1 ]]( self );
            
            if ( isdefined( var_bcfe0ed5ba4c9e74 ) )
            {
                cost = var_bcfe0ed5ba4c9e74;
            }
        }
    }
    
    curweapon = player getcurrentweapon();
    var_d1ad847a3b590336 = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( curweapon );
    wall_value = function_bd5a94ee7552fcbd( self.rarity );
    
    if ( curweapon.basename == self.weapon_name && var_d1ad847a3b590336 >= wall_value )
    {
        function_21da8105947ab024( player, self.itementry );
        return;
    }
    
    var_e155b1457fe82e13 = makeweapon( self.weapon );
    var_1d54b58625d294b5 = var_e155b1457fe82e13 getbaseweapon();
    var_ab13966355ea575f = undefined;
    
    foreach ( weapon in player.primaryinventory )
    {
        var_4d2571bbc7397806 = weapon getbaseweapon();
        
        if ( issameweapon( var_1d54b58625d294b5, var_4d2571bbc7397806 ) )
        {
            var_ab13966355ea575f = weapon;
        }
    }
    
    if ( isdefined( var_ab13966355ea575f ) )
    {
        var_d1ad847a3b590336 = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( var_ab13966355ea575f );
        
        if ( isdefined( var_ab13966355ea575f ) && var_d1ad847a3b590336 >= wall_value )
        {
            function_21da8105947ab024( player, self.itementry );
            return;
        }
    }
    
    if ( player currency::attempt_purchase( level.wallbuy_currency_type, cost, undefined, undefined, #"wallbuy" ) )
    {
        var_482e9999b75ed3d8 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
        
        if ( isdefined( self.itementry ) )
        {
            favoriteweapon = player weaponmetadata::function_c68204eff69ed046( self.weapon_name );
            var_827e6c420604dd2 = self.itementry;
            
            if ( isdefined( self.rarity ) && self.rarity != "white" )
            {
                var_827e6c420604dd2 = hashcat( var_827e6c420604dd2, "_", self.rarity );
            }
            
            item_bundle = getscriptbundle( var_827e6c420604dd2 );
            var_34cdd5cda21b2ad1 = item_bundle.scriptable;
            fakeitem = spawnstruct();
            
            if ( isdefined( favoriteweapon ) )
            {
                fakeitem.weaponobj = favoriteweapon;
                item_bundle = getscriptbundle( level.gametypebundle.var_9d7bd1394c38803a );
                var_aa4a28d277a533b8 = function_bd5a94ee7552fcbd( self.rarity );
                item_bundle.rarity = var_aa4a28d277a533b8;
            }
            else
            {
                fakeitem.weaponobj = item_weapon::function_477bf1207c6672a5( item_bundle );
            }
            
            clipammo = 0;
            stockammo = 0;
            var_ed4b15516542bf71 = 0;
            var_f02d9cbb7946af65 = undefined;
            
            if ( isdefined( fakeitem.weaponobj ) )
            {
                clipammo = weaponclipsize( fakeitem.weaponobj );
                stockammo = utility::get_max_stock_ammo( fakeitem.weaponobj, var_482e9999b75ed3d8 );
                var_f02d9cbb7946af65 = fakeitem.weaponobj;
            }
            else
            {
                clipammo = weaponclipsize( self.weapon );
                stockammo = utility::get_max_stock_ammo( self.weapon, var_482e9999b75ed3d8 );
                var_f02d9cbb7946af65 = self.weapon;
            }
            
            if ( var_f02d9cbb7946af65 )
            {
                altweapon = var_f02d9cbb7946af65 getaltweapon();
                
                if ( altweapon )
                {
                    var_ed4b15516542bf71 = weaponclipsize( altweapon );
                }
            }
            
            if ( fakeitem.weaponobj.isdualwield )
            {
                fakeitem.count = common_item::function_598dd39282efb544( clipammo, clipammo );
            }
            else if ( fakeitem.weaponobj.hasalternate )
            {
                fakeitem.count = common_item::function_598dd39282efb544( clipammo, undefined, var_ed4b15516542bf71 );
            }
            else
            {
                fakeitem.count = common_item::function_598dd39282efb544( clipammo );
            }
            
            fakeitem.weaponstockammo = stockammo;
            var_6691fe43150a092f = 0;
            
            if ( function_c2e50a32d8592f77( player ) )
            {
                if ( !isdefined( fakeitem.var_951c89546ec50477 ) )
                {
                    fakeitem.var_951c89546ec50477 = 0;
                }
                
                fakeitem.var_951c89546ec50477++;
                fakeitem.var_951c89546ec50477 = int( clamp( fakeitem.var_951c89546ec50477, 0, 3 ) );
                fakeitem.var_768b3618cd111c7e = 1;
                var_6691fe43150a092f = 1;
                fakeitem.upgrade_source = #"wallbuy";
            }
            
            fakeitem.pickup_source = #"wallbuy";
            
            if ( isweapon( fakeitem.weaponobj ) )
            {
                player loadweaponsforplayer( [ fakeitem.weaponobj ] );
            }
            
            var_5d8cc93233d1451a = player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem, function_4d52f81f088365b9( player, self ) );
            
            if ( isarray( var_5d8cc93233d1451a ) && isweapon( var_5d8cc93233d1451a[ 1 ] ) )
            {
                var_5d8cc93233d1451a = var_5d8cc93233d1451a[ 1 ];
            }
        }
        else
        {
            if ( getdvarint( @"scr_use_random_attachments" ) )
            {
                var_408522e3869135b = function_8a90fa1c0093eee2( self.rarity );
                var_5d8cc93233d1451a = weapons::function_777e95225ed7341c( self.weapon_name, var_408522e3869135b, 1 );
            }
            else
            {
                var_5d8cc93233d1451a = weapon::buildweapon( self.weapon_name );
            }
            
            if ( isweapon( var_5d8cc93233d1451a ) )
            {
                player loadweaponsforplayer( [ var_5d8cc93233d1451a ] );
            }
            
            player.droppeddeathweapon = undefined;
            player weapons::dropweaponfordeath( undefined, "" );
            player.droppeddeathweapon = undefined;
            player giveweapon( var_5d8cc93233d1451a );
            player setweaponammoclip( var_5d8cc93233d1451a, weaponclipsize( var_5d8cc93233d1451a ) );
            
            if ( var_5d8cc93233d1451a.isdualwield )
            {
                player setweaponammoclip( var_5d8cc93233d1451a, weaponclipsize( var_5d8cc93233d1451a ), "left" );
            }
            
            if ( var_5d8cc93233d1451a.altweapon )
            {
                player setweaponammoclip( var_5d8cc93233d1451a.altweapon, weaponclipsize( var_5d8cc93233d1451a.altweapon ) );
                player setweaponammostock( var_5d8cc93233d1451a.altweapon, utility::get_max_stock_ammo( var_5d8cc93233d1451a.altweapon, var_482e9999b75ed3d8 ) );
            }
            
            player setweaponammostock( var_5d8cc93233d1451a, utility::get_max_stock_ammo( var_5d8cc93233d1451a, var_482e9999b75ed3d8 ) );
            player switchtoweaponimmediate( var_5d8cc93233d1451a );
        }
        
        if ( isplayer( player ) && isweapon( var_5d8cc93233d1451a ) )
        {
            player utility::callsharedfunc( #"ammo_cache", #"ammo_cache_give_ammo", var_5d8cc93233d1451a );
        }
        
        if ( !isdefined( self.var_5499b4433cb4a919 ) )
        {
            target_angle = ( angleclamp180( 360 - self.angles[ 0 ] ), angleclamp180( self.angles[ 1 ] - 180 ), angleclamp180( 360 - self.angles[ 2 ] ) );
            var_5499b4433cb4a919 = function_2535619d314c1099( self.weapon_name, self.origin, target_angle );
            var_5499b4433cb4a919.angles = var_5499b4433cb4a919.angles;
            self.var_5499b4433cb4a919 = var_5499b4433cb4a919;
            var_5534ee0990246282 = ( 0, -5, 0 );
            var_cd42b2a7832a77a8 = var_5499b4433cb4a919 localtoworldcoords( var_5534ee0990246282 );
            var_5499b4433cb4a919 notsolid();
            var_177018b3984d2e6a = ( 0, 0.5, 0 );
            var_c6ec37af26231409 = 1;
            targetposworld = var_5499b4433cb4a919 localtoworldcoords( var_177018b3984d2e6a );
            var_5499b4433cb4a919.origin = var_cd42b2a7832a77a8;
            var_5499b4433cb4a919 moveto( targetposworld, var_c6ec37af26231409 );
        }
        
        playsoundatpos( self.origin, "evt_zm_core_wallbuy_purchase" );
        params = spawnstruct();
        params.objweapon = var_5d8cc93233d1451a;
        params.cost = cost;
        params.rarity = self.rarity;
        params.lootid = weapon::function_57559cfce1d2812d( var_5d8cc93233d1451a );
        params.currency = level.wallbuy_currency_type;
        params.var_6691fe43150a092f = var_6691fe43150a092f;
        player callback::callback( "wallbuy_purchase", params );
    }
}

// Namespace wallbuy
// Params 2, eflags: 0x4
// Checksum 0x8a214dfd, Offset: 0x3157
// Size: 0x20e
function private function_21da8105947ab024( player, itementry )
{
    item_bundle = getscriptbundle( itementry );
    weaponobj = item_weapon::function_477bf1207c6672a5( item_bundle );
    var_1d54b58625d294b5 = weaponobj getbaseweapon();
    var_ab13966355ea575f = undefined;
    
    foreach ( weapon in player.primaryinventory )
    {
        var_4d2571bbc7397806 = weapon getbaseweapon();
        
        if ( issameweapon( var_1d54b58625d294b5, var_4d2571bbc7397806 ) )
        {
            var_ab13966355ea575f = weapon;
        }
    }
    
    if ( !isdefined( var_ab13966355ea575f ) )
    {
        return;
    }
    
    if ( player attackbuttonpressed() )
    {
        return;
    }
    
    if ( var_ab13966355ea575f.ismelee )
    {
        return;
    }
    
    if ( !weapon::isprimaryweapon( var_ab13966355ea575f ) )
    {
        return;
    }
    
    currencytype = #"essence";
    var_50bac4dcea60a475 = function_a80df1a750486e6b( player, var_ab13966355ea575f );
    var_50bac4dcea60a475 = function_60355d4a5847e024( player, var_50bac4dcea60a475 );
    bfullammo = player is_weapon_ammo_full( var_ab13966355ea575f );
    
    if ( bfullammo )
    {
        if ( isdefined( level.currency[ currencytype ].denysound ) )
        {
            player playsoundtoplayer( level.currency[ currencytype ].denysound, player );
        }
        
        return;
    }
    
    playsoundatpos( self.origin, #"hash_483f9acf2399f880" );
    
    if ( !isdefined( currencytype ) || var_50bac4dcea60a475 == 0 )
    {
        player utility::callsharedfunc( #"ammo_cache", #"ammo_cache_give_ammo", var_ab13966355ea575f );
        return;
    }
    
    if ( player currency::attempt_purchase( currencytype, var_50bac4dcea60a475, 1, 0, #"ammo_cache" ) )
    {
        player utility::callsharedfunc( #"ammo_cache", #"ammo_cache_give_ammo", var_ab13966355ea575f );
    }
}

// Namespace wallbuy
// Params 2
// Checksum 0xdd5772e8, Offset: 0x336e
// Size: 0x111
function function_a80df1a750486e6b( player, weapon )
{
    cost = level.var_a1e014d3b627d368.reloadcost;
    
    if ( isplayer( player ) && isdefined( weapon ) )
    {
        paplevel = player pack_a_punch::get_pap_level( weapon );
        
        switch ( paplevel )
        {
            case 0:
                break;
            case 1:
                cost = level.var_a1e014d3b627d368.var_b73cf47f78dc7922;
                break;
            case 2:
                cost = level.var_a1e014d3b627d368.var_b73cf37f78dc76ef;
                break;
            case 3:
                cost = level.var_a1e014d3b627d368.var_b73cf27f78dc74bc;
                break;
            case 4:
                cost = level.var_a1e014d3b627d368.var_b73cf17f78dc7289;
                break;
            default:
                break;
        }
    }
    
    return cost;
}

// Namespace wallbuy
// Params 2
// Checksum 0x287cb275, Offset: 0x3488
// Size: 0x129
function function_4d52f81f088365b9( player, wallbuy )
{
    if ( isdefined( wallbuy.origin ) && isdefined( wallbuy.angles ) )
    {
        if ( !isdefined( wallbuy.dropped_item_count ) || wallbuy.dropped_item_count >= 12 )
        {
            wallbuy.dropped_item_count = 0;
        }
        
        startorigin = wallbuy.origin;
        forwardangles = wallbuy.angles + ( 0, -90, 0 );
        forwarddirection = anglestoforward( forwardangles );
        endorigin = getgroundposition( startorigin + forwarddirection * 60, 1, 60, 0 );
        var_4e68d5c61b67187f = common_item::function_b94327aa4c1b718b( endorigin, player );
        var_4e68d5c61b67187f.spawnpositionindex = wallbuy.dropped_item_count;
        var_4e68d5c61b67187f.var_44d5025c8cfbd48e = 12;
        var_4e68d5c61b67187f.var_2321e933cbdf46d8 = 20;
        var_4e68d5c61b67187f.var_34444f0dda11f0d5 = 20;
        wallbuy.dropped_item_count++;
        return var_4e68d5c61b67187f;
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0x310a8a07, Offset: 0x35ba
// Size: 0x84
function function_8a90fa1c0093eee2( rarity )
{
    var_408522e3869135b = 0;
    
    switch ( rarity )
    {
        case #"hash_1393412d7401c646":
            var_408522e3869135b = 1;
            break;
        case #"hash_883ff07272b4f9c":
            var_408522e3869135b = 2;
            break;
        case #"hash_778bb52ecd08072d":
            var_408522e3869135b = 3;
            break;
        case #"hash_598a30e44f53045f":
            var_408522e3869135b = 4;
            break;
        case #"hash_35bb3bd014c77f4b":
            var_408522e3869135b = 5;
            break;
    }
    
    return var_408522e3869135b;
}

/#

    // Namespace wallbuy
    // Params 0
    // Checksum 0x6ed00e9a, Offset: 0x3647
    // Size: 0x1de, Type: dev
    function debug_update_rarity()
    {
        foreach ( instance in level.contentmanager.spawnedinstances[ "<dev string:x22f>" ] )
        {
            if ( isdefined( instance.var_1d6cddfc47031bff[ "<dev string:x237>" ] ) )
            {
                foreach ( wallbuy_spawn in instance.var_1d6cddfc47031bff[ "<dev string:x237>" ] )
                {
                    if ( isdefined( wallbuy_spawn.wallbuy_scriptable ) )
                    {
                        var_cb5377751f030f6c = "<dev string:x245>";
                        
                        if ( isdefined( wallbuy_spawn.wallbuy_scriptable.rarity ) )
                        {
                            switch ( wallbuy_spawn.wallbuy_scriptable.rarity )
                            {
                                case #"hash_1393412d7401c646":
                                    var_cb5377751f030f6c = "<dev string:x252>";
                                    break;
                                case #"hash_883ff07272b4f9c":
                                    var_cb5377751f030f6c = "<dev string:x258>";
                                    break;
                                case #"hash_778bb52ecd08072d":
                                    var_cb5377751f030f6c = "<dev string:x25d>";
                                    break;
                                case #"hash_598a30e44f53045f":
                                    var_cb5377751f030f6c = "<dev string:x245>";
                                    break;
                                case #"hash_35bb3bd014c77f4b":
                                    var_cb5377751f030f6c = "<dev string:x245>";
                                    break;
                            }
                        }
                        
                        wallbuy_spawn function_6ad7ea470d0872aa( wallbuy_spawn, var_cb5377751f030f6c );
                        waitframe();
                    }
                }
            }
        }
    }

#/

// Namespace wallbuy
// Params 2
// Checksum 0xa41dbe2f, Offset: 0x382d
// Size: 0x1b5
function function_6ad7ea470d0872aa( structspawn, rarity )
{
    assert( isdefined( structspawn.wallbuy_scriptable ) );
    
    if ( level.gametypebundle.var_485e39c96ada1e41 ?? 0 )
    {
        return;
    }
    
    if ( structspawn.wallbuy_scriptable.disable_upgrade )
    {
        return;
    }
    
    fxdir = anglestoright( structspawn.wallbuy_scriptable.angles );
    updir = anglestoup( structspawn.wallbuy_scriptable.angles );
    playfx( utility::getfx( "vfx_wallbuy_upgrade" ), structspawn.wallbuy_scriptable.origin, fxdir, updir );
    newrarity = rarity;
    cost = 1000;
    
    if ( isdefined( structspawn.wallbuy_scriptable.weapon_root_name ) )
    {
        cost = get_wallbuy_cost( structspawn.wallbuy_scriptable.weapon_root_name, newrarity );
    }
    else if ( isdefined( structspawn.wallbuy_scriptable.scriptablename ) )
    {
        cost = get_variant_wallbuy_cost( structspawn.wallbuy_scriptable.scriptablename, newrarity );
    }
    
    structspawn.wallbuy_scriptable.cost = cost;
    structspawn.wallbuy_scriptable.rarity = newrarity;
    
    if ( newrarity == "white" )
    {
        newrarity = "base";
    }
    
    structspawn.wallbuy_scriptable setscriptablepartstate( "wallbuy", newrarity );
}

// Namespace wallbuy
// Params 2
// Checksum 0xfea8272f, Offset: 0x39ea
// Size: 0x40f, Type: bool
function function_9671f0078ceb9f5d( var_5da8bec91e1b0eb3, round_number )
{
    n_chance = 0;
    
    switch ( round_number )
    {
        case 5:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_7b01592d564f9005 ?? 8;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_1ec8dc397176d2f7 ?? 6;
            }
            else
            {
                n_chance = level.wallbuybundle.var_b9a947363b1f23ce ?? 23;
            }
            
            break;
        case 10:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d3755bb4d0e5f8cb ?? 10;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a7da154883e7961 ?? 7;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e7d1244058f39de ?? 45;
            }
            
            break;
        case 15:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d3755eb4d0e5ff64 ?? 19;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a7da454883e7ffa ?? 9;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e7d1744058f44dd ?? 74;
            }
            
            break;
        case 20:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d36849b4d0d7bcb0 ?? 44;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a822754884395ea ?? 9;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e788c44058a1d55 ?? 84;
            }
            
            break;
        case 25:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d3684eb4d0d7c7af ?? 73;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a82245488438f51 ?? 18;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e788744058a1256 ?? 95;
            }
            
            break;
        case 30:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d36ccfb4d0dcd939 ?? 90;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a868d5488486c13 ?? 43;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e740644058500cc ?? 100;
            }
            
            break;
        case 35:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d36cd2b4d0dcdfd2 ?? 100;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a869054884872ac ?? 63;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e7403440584fa33 ?? 100;
            }
            
            break;
        case 40:
        default:
            if ( var_5da8bec91e1b0eb3 == "blue" )
            {
                n_chance = level.wallbuybundle.var_d382cdb4d0f50806 ?? 100;
            }
            else if ( var_5da8bec91e1b0eb3 == "purple" )
            {
                n_chance = level.wallbuybundle.var_2a8b1354884d889c ?? 90;
            }
            else
            {
                n_chance = level.wallbuybundle.var_6e7000440580fdc3 ?? 100;
            }
            
            break;
    }
    
    if ( utility::percent_chance( n_chance ) )
    {
        return true;
    }
    
    return false;
}

// Namespace wallbuy
// Params 1
// Checksum 0x7201a30a, Offset: 0x3e02
// Size: 0x271
function on_round_end( params )
{
    if ( !isdefined( level.contentmanager.spawnedinstances[ "wallbuy" ] ) )
    {
        return;
    }
    
    if ( !params.var_e7c2c09903c13bf7 )
    {
        return;
    }
    
    if ( level.round_number % 5 == 0 )
    {
        round_number = level.round_number;
        
        foreach ( instance in level.contentmanager.spawnedinstances[ "wallbuy" ] )
        {
            if ( isdefined( instance.var_1d6cddfc47031bff ) && instance.var_1d6cddfc47031bff.size > 0 )
            {
                foreach ( wallbuy_spawn in instance.var_1d6cddfc47031bff[ "wallbuy_spawn" ] )
                {
                    if ( isdefined( wallbuy_spawn.wallbuy_scriptable ) && isdefined( wallbuy_spawn.wallbuy_scriptable.rarity ) && wallbuy_spawn.wallbuy_scriptable.rarity != "orange" )
                    {
                        if ( function_9671f0078ceb9f5d( wallbuy_spawn.wallbuy_scriptable.rarity, round_number ) )
                        {
                            switch ( wallbuy_spawn.wallbuy_scriptable.rarity )
                            {
                                case #"hash_1393412d7401c646":
                                    var_7c0d29caa7b948c6 = "green";
                                    break;
                                case #"hash_883ff07272b4f9c":
                                    var_7c0d29caa7b948c6 = "blue";
                                    break;
                                case #"hash_778bb52ecd08072d":
                                    var_7c0d29caa7b948c6 = "purple";
                                    break;
                                case #"hash_598a30e44f53045f":
                                default:
                                    var_7c0d29caa7b948c6 = "orange";
                                    break;
                            }
                            
                            function_6ad7ea470d0872aa( wallbuy_spawn, var_7c0d29caa7b948c6 );
                            waitframe();
                        }
                    }
                }
            }
        }
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0x3447498c, Offset: 0x407b
// Size: 0x90
function function_c2e50a32d8592f77( player )
{
    if ( isdefined( level.var_15cf51666bfa84a0 ) )
    {
        foreach ( func in level.var_15cf51666bfa84a0 )
        {
            return [[ func ]]( player );
        }
    }
    
    return 0;
}

// Namespace wallbuy
// Params 1
// Checksum 0xa7727134, Offset: 0x4114
// Size: 0x3f
function register_upgrade_weapon( func_upgrade_weapon )
{
    if ( !isdefined( level.var_15cf51666bfa84a0 ) )
    {
        level.var_15cf51666bfa84a0 = [];
    }
    
    level.var_15cf51666bfa84a0 = arraycombineunique( level.var_15cf51666bfa84a0, [ func_upgrade_weapon ] );
}

// Namespace wallbuy
// Params 2
// Checksum 0x36e0da0f, Offset: 0x415b
// Size: 0xb6
function function_45ca4bd44974b58b( player, var_ba8d8fbc30d8e26c )
{
    origin = var_ba8d8fbc30d8e26c.origin;
    angles = var_ba8d8fbc30d8e26c.angles + ( 0, -90, 0 );
    right = anglestoright( var_ba8d8fbc30d8e26c.angles );
    plangles = vectortoangles( right ) + ( 0, 180, 0 );
    var_dfcdb500ce642a84 = origin + anglestoforward( angles ) * 24;
    var_dfcdb500ce642a84 = getgroundposition( var_dfcdb500ce642a84, 16 );
    player setorigin( var_dfcdb500ce642a84 );
    player setplayerangles( plangles );
}

// Namespace wallbuy
// Params 1
// Checksum 0x5ef50835, Offset: 0x4219
// Size: 0x3f
function register_player_weapon_cost_override( var_a89b5e340fffb0d1 )
{
    if ( !isdefined( self.var_bc0b9e201dc8d785 ) )
    {
        self.var_bc0b9e201dc8d785 = [];
    }
    
    self.var_bc0b9e201dc8d785 = arraycombineunique( self.var_bc0b9e201dc8d785, [ var_a89b5e340fffb0d1 ] );
}

// Namespace wallbuy
// Params 1
// Checksum 0x23f5d487, Offset: 0x4260
// Size: 0x31
function function_e123b2e2d54943a8( var_a89b5e340fffb0d1 )
{
    if ( isdefined( self.var_bc0b9e201dc8d785 ) )
    {
        self.var_bc0b9e201dc8d785 = arrayremove( self.var_bc0b9e201dc8d785, var_a89b5e340fffb0d1 );
    }
}

// Namespace wallbuy
// Params 1
// Checksum 0xb5f30f90, Offset: 0x4299
// Size: 0x2a
function function_d2e4e3d71fdec0a9( s_feature )
{
    wallbuy = s_feature.wallbuy_scriptable;
    wallbuy function_7653c765b6c7b815();
}

// Namespace wallbuy
// Params 1
// Checksum 0x66580cfc, Offset: 0x42cb
// Size: 0x2a
function function_c065fc0d1c1800a2( s_feature )
{
    wallbuy = s_feature.wallbuy_scriptable;
    wallbuy function_e203bba36cfb19d0();
}

/#

    // Namespace wallbuy
    // Params 0, eflags: 0x4
    // Checksum 0x7c0cb513, Offset: 0x42fd
    // Size: 0x183, Type: dev
    function private setup_weapon_rarity_devgui()
    {
        level utility::flag_wait( "<dev string:x264>" );
        devgui::function_9082edeb5db93280( "<dev string:x272>" );
        
        foreach ( index, var_ba8d8fbc30d8e26c in level.var_caf65b937e9cbfaf )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x282>" + index + "<dev string:x29c>" + ( var_ba8d8fbc30d8e26c.script_noteworthy ?? "<dev string:x29e>" ), "<dev string:x29f>" + index + "<dev string:x2b0>" + index, &function_2155286f69ee8572 );
        }
        
        devgui::add_devgui_func( "<dev string:x2b2>", "<dev string:x2c6>", &function_c084aeee373ddbcf, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x2da>" );
        devgui::add_devgui_func( "<dev string:x2f0>", "<dev string:x31f>", &function_8fa198f77c9ade7d );
        devgui::add_devgui_func( "<dev string:x32e>", "<dev string:x35f>", &function_fc58569de7fb4d23 );
        devgui::add_devgui_func( "<dev string:x36e>", "<dev string:x39a>", &function_42a9d4fa18fc40ac );
        devgui::add_devgui_func( "<dev string:x3a8>", "<dev string:x3d6>", &function_336cc25f22033da );
        devgui::add_devgui_func( "<dev string:x3e6>", "<dev string:x419>", &function_fe11091861e6bfa );
        devgui::add_devgui_func( "<dev string:x429>", "<dev string:x44f>", &function_b5d5ab3b14bba2ca );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0xc5c2edb1, Offset: 0x4488
    // Size: 0xe5, Type: dev
    function function_c084aeee373ddbcf()
    {
        while ( true )
        {
            foreach ( index, var_ba8d8fbc30d8e26c in level.var_caf65b937e9cbfaf )
            {
                sphere( var_ba8d8fbc30d8e26c.origin, 20, ( 0, 0, 1 ) );
                print3d( var_ba8d8fbc30d8e26c.origin, "<dev string:x45e>" + index + "<dev string:x467>" + ( var_ba8d8fbc30d8e26c.script_noteworthy ?? "<dev string:x29e>" ), ( 1, 1, 1 ), undefined, 0.05, undefined, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace wallbuy
    // Params 1
    // Checksum 0x3ffe7aaa, Offset: 0x4575
    // Size: 0x4c, Type: dev
    function function_2155286f69ee8572( params )
    {
        index = int( params[ 0 ] );
        var_ba8d8fbc30d8e26c = level.var_caf65b937e9cbfaf[ index ];
        function_45ca4bd44974b58b( level.players[ 0 ], var_ba8d8fbc30d8e26c );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0x9568f54a, Offset: 0x45c9
    // Size: 0x11, Type: dev
    function function_8fa198f77c9ade7d()
    {
        function_d190796711035d3d( "<dev string:x24c>" );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0x73dd6cf, Offset: 0x45e2
    // Size: 0x11, Type: dev
    function function_fc58569de7fb4d23()
    {
        function_d190796711035d3d( "<dev string:x252>" );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0xc389cbe5, Offset: 0x45fb
    // Size: 0x11, Type: dev
    function function_42a9d4fa18fc40ac()
    {
        function_d190796711035d3d( "<dev string:x258>" );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0x6676fc2c, Offset: 0x4614
    // Size: 0x11, Type: dev
    function function_336cc25f22033da()
    {
        function_d190796711035d3d( "<dev string:x25d>" );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0x91363fb2, Offset: 0x462d
    // Size: 0x11, Type: dev
    function function_fe11091861e6bfa()
    {
        function_d190796711035d3d( "<dev string:x245>" );
    }

    // Namespace wallbuy
    // Params 0
    // Checksum 0x250362c1, Offset: 0x4646
    // Size: 0x11, Type: dev
    function function_b5d5ab3b14bba2ca()
    {
        function_d190796711035d3d( "<dev string:x47c>" );
    }

    // Namespace wallbuy
    // Params 1
    // Checksum 0x7ce28e9a, Offset: 0x465f
    // Size: 0x2c3, Type: dev
    function function_d190796711035d3d( rarity )
    {
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) || !isdefined( player getcurrentweapon() ) )
            {
                assert( "<dev string:x482>" );
                return;
            }
            
            var_482e9999b75ed3d8 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "<dev string:x4bd>", #"z_mod_pack_mule" ) );
            currentweapon = player getcurrentweapon();
            var_5d8cc93233d1451a = currentweapon;
            var_b1e51965a7fe0efc = currentweapon.var_1616e6fbba9a722d;
            itementry = get_wallbuy_item( var_b1e51965a7fe0efc );
            paplevel = player utility::callsharedfunc( #"zombie", #"get_pap_level", var_5d8cc93233d1451a );
            
            if ( isdefined( itementry ) )
            {
                fakeitem = spawnstruct();
                max_stock_ammo = utility::get_max_stock_ammo( var_5d8cc93233d1451a, var_482e9999b75ed3d8 );
                var_827e6c420604dd2 = itementry;
                
                if ( isdefined( rarity ) && rarity != "<dev string:x24c>" )
                {
                    var_827e6c420604dd2 = hashcat( var_827e6c420604dd2, "<dev string:x4cd>", rarity );
                }
                
                item_bundle = getscriptbundle( var_827e6c420604dd2 );
                var_34cdd5cda21b2ad1 = item_bundle.scriptable;
                fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
                fakeitem.var_951c89546ec50477 = paplevel;
                player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
            }
            else
            {
                var_2e08e94c9cb1747c = weapon::getweaponrootname( currentweapon ) + "<dev string:x4cf>";
                
                if ( getdvarint( @"scr_use_random_attachments" ) )
                {
                    var_408522e3869135b = function_8a90fa1c0093eee2( rarity );
                    var_5d8cc93233d1451a = weapons::function_777e95225ed7341c( var_2e08e94c9cb1747c, var_408522e3869135b, 1 );
                }
                else
                {
                    var_5d8cc93233d1451a = weapon::buildweapon( var_2e08e94c9cb1747c );
                }
                
                player.droppeddeathweapon = undefined;
                player weapons::dropweaponfordeath( undefined, "<dev string:x29e>" );
                player.droppeddeathweapon = undefined;
                player giveweapon( var_5d8cc93233d1451a );
                player setweaponammoclip( var_5d8cc93233d1451a, weaponclipsize( var_5d8cc93233d1451a ) );
                player setweaponammostock( var_5d8cc93233d1451a, utility::get_max_stock_ammo( var_5d8cc93233d1451a, var_482e9999b75ed3d8 ) );
                player switchtoweaponimmediate( var_5d8cc93233d1451a );
                player utility::callsharedfunc( #"zombie", #"hash_4fb89d74adceafac", var_5d8cc93233d1451a, paplevel );
            }
            
            playsoundatpos( player.origin, "<dev string:x4d3>" );
        }
    }

#/
