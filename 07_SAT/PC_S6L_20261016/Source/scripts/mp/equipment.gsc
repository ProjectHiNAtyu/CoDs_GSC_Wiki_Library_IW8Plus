// scripts\mp\equipment.gsc  (hash_6b0663a111030b30.gscc) (size: 56668 Bytes / 0xdd5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f5ae474 (2136663156)
// size ...... 56668 (0xdd5c)
// includes .. 37  (offset: 0xd154)
// strings ... 112 (offset: 0xd27c)
// dev strs .. 55  (offset: 0xda78)
// exports ... 148 (offset: 0x91b0)
// cseg ...... 0x9f9 + 0x87b7 (0x91b0)
// imports ... 324 (offset: 0xa8d0)
// animtree1 . 0   (offset: 0xdd5c)
// animtree2 . 0   (offset: 0xdd5c)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\hb_sensor;
#using scripts\mp\common\equipment\weapon_drop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\headgear;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\equipment_interact;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gestures;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace equipment_mp;

// Namespace equipment_mp
// Params 0
// Checksum 0xbbe550b8, Offset: 0xa17
// Size: 0x296
function init()
{
    if ( isdefined( level.gametypebundle.equipment_list ) )
    {
        level.equipmenttable = level.gametypebundle.equipment_list;
    }
    else if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.equipment_list ) )
    {
        level.equipmenttable = level.gamemodebundle.equipment_list;
    }
    else if ( getdvarint( @"t10", 0 ) > 0 )
    {
        level.equipmenttable = %"equipmentlist:equipment_list_t10_mp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x24>", level.equipmenttable );
        #/
    }
    else if ( getdvarint( @"mgl", 0 ) > 0 )
    {
        level.equipmenttable = %"equipmentlist:equipment_list_mgl_mp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x24>", level.equipmenttable );
        #/
    }
    else
    {
        level.equipmenttable = %"equipmentlist:equipment_list_iw9_mp";
        
        /#
            utility::scriptbundlewarning( "<dev string:x24>", level.equipmenttable );
        #/
    }
    
    level.equipment = spawnstruct();
    level.equipment.table = [];
    loadequipmentbundles( level.equipmenttable );
    function_e59294212c1bdaf5();
    function_5de69a1a893ed658();
    inititems();
    initlethalmaxoffsetmap();
    function_85b866b4696a2e17();
    utility::flag_init( "equipment_initialized" );
    utility::flag_set( "equipment_initialized", 1 );
    callback::add( #"player_spawned", &equiponplayerspawned );
    callback::add( #"round_ended", &onroundended );
    damage::function_3232791951a34daf( &function_a3a5d39074d58e08 );
    callback::callback( #"equipment_init", undefined );
    callback::remove( #"equipment_init", #"all" );
    level.equipment.var_aeff9a3b25965912 = function_60586aa3d725b77d();
    
    if ( level.equipment.var_aeff9a3b25965912 )
    {
        callback::add( #"hash_5bfa36b3dc1a524b", &function_ff1f3c141c6d39ab );
        callback::add( #"player_laststand", &onplayerlaststand );
        callback::add( #"player_laststand_revived", &onplayerrevived );
        callback::add( #"player_death", &onplayerdeath );
    }
    
    utility::registersharedfunc( #"equipment", #"hash_ea29440e05008300", &function_84f2f5566ba29655 );
}

// Namespace equipment_mp
// Params 3
// Checksum 0x73a8278a, Offset: 0xcb5
// Size: 0x28
function buildequipment( weaponname, variantid, attachments )
{
    return weapon::buildequipment( weaponname, variantid, attachments );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x30fc01e7, Offset: 0xce6
// Size: 0x14
function function_5c326751c7802342( tableinfo )
{
    return weapon::function_5c326751c7802342( tableinfo );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x46f56a3, Offset: 0xd03
// Size: 0x78
function sethudslot( slot, id )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( slot != "super" && slot != "none" )
    {
        self setclientomnvar( "ui_equipment_id_" + slot, id );
        return;
    }
    
    if ( level.gametype == "dungeons" )
    {
        self setclientomnvar( "ui_field_upgrade_icon", id );
        return;
    }
    
    self setclientomnvar( "ui_perk_package_super1", id );
}

// Namespace equipment_mp
// Params 0
// Checksum 0xb42a8035, Offset: 0xd83
// Size: 0x1f8
function inititems()
{
    level.equipment.callbacks = [];
    
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    globals = level.equipment;
    equipment_interact::equipmentinteract_init();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        headgear::init();
    }
    
    weapon_drop::weapondrop_init();
    level callback::callback( "init_grenade" );
    
    if ( utility::issharedfuncdefined( #"equip_butterfly_mine", #"init" ) )
    {
        utility::callsharedfunc( #"equip_butterfly_mine", #"init" );
    }
    
    if ( utility::issharedfuncdefined( #"equip_aethercounter", #"ongive" ) && utility::issharedfuncdefined( #"equip_aethercounter", #"onTake" ) )
    {
        globals.callbacks[ "equip_aethercounter" ][ "onGive" ] = utility::getsharedfunc( #"equip_aethercounter", #"ongive" );
        globals.callbacks[ "equip_aethercounter" ][ "onTake" ] = utility::getsharedfunc( #"equip_aethercounter", #"onTake" );
    }
    
    if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_grenade_get_onplayerdamaged" ) )
    {
        globals.callbacks[ "equip_thermobaric_grenade" ][ "onPlayerDamaged" ] = [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_grenade_get_onplayerdamaged" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"equip_tracker_mine", #"hash_c888c70ae536cc64" ) )
    {
        globals.callbacks[ "equip_tracker_mine" ][ "onOwnerChanged" ] = utility::getsharedfunc( #"equip_tracker_mine", #"hash_c888c70ae536cc64" );
    }
    
    thread watchlethaldelay();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onownerdisconnect );
    
    /#
        thread debughackequipment();
        thread debugemp();
        thread function_5bbba416d98f9fb7();
    #/
}

// Namespace equipment_mp
// Params 3
// Checksum 0x2b266495, Offset: 0xf83
// Size: 0x38
function function_a48e87b7ec89821e( equipname, eventkey, callbackfn )
{
    level.equipment.callbacks[ equipname ][ eventkey ] = callbackfn;
}

// Namespace equipment_mp
// Params 2
// Checksum 0xa1976820, Offset: 0xfc3
// Size: 0x5a
function function_e08050aec5516278( equipmentref, var_eadb663a1292c9e8 )
{
    if ( !isdefined( var_eadb663a1292c9e8 ) )
    {
        return;
    }
    
    if ( !isxhashasset( var_eadb663a1292c9e8 ) )
    {
        assertmsg( "<dev string:x48>" );
        var_eadb663a1292c9e8 = getxhashasset( var_eadb663a1292c9e8 );
    }
    
    if ( var_eadb663a1292c9e8 == %"" )
    {
        return;
    }
    
    level.var_1de668bdb367b433[ var_eadb663a1292c9e8 ] = equipmentref;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x64656bfa, Offset: 0x1025
// Size: 0x2d
function onroundended( data )
{
    utility::flag_clear( "equipment_initialized" );
    callback::remove( #"round_ended", &onroundended );
}

// Namespace equipment_mp
// Params 0, eflags: 0x4
// Checksum 0xed470ebd, Offset: 0x105a
// Size: 0x38
function private function_85b866b4696a2e17()
{
    if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_grenade_init" ) )
    {
        [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_grenade_init" ) ]]();
    }
}

// Namespace equipment_mp
// Params 3
// Checksum 0x2cc14ee8, Offset: 0x109a
// Size: 0x63
function registercallback( equipref, event, callback )
{
    if ( !isdefined( level.equipment.callbacks ) )
    {
        level.equipment.callbacks = [];
    }
    
    level.equipment.callbacks[ equipref ][ event ] = callback;
}

// Namespace equipment_mp
// Params 2
// Checksum 0xe1419a9e, Offset: 0x1105
// Size: 0x49
function getcallback( ref, callback )
{
    if ( !isdefined( level.equipment.callbacks[ ref ] ) )
    {
        return;
    }
    
    return level.equipment.callbacks[ ref ][ callback ];
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf78ef2f4, Offset: 0x1157
// Size: 0xfa
function function_e7be0aab8fa729de( equipmentname )
{
    tokens = strtok( equipmentname, "_" );
    tokens[ tokens.size - 1 ] = undefined;
    
    if ( isint( tokens.size - 1 ) )
    {
        function_cdc669dbc8ea2101( tokens );
    }
    
    if ( tokens[ 0 ] == "jup" )
    {
        tokens[ 0 ] = undefined;
        function_cdc669dbc8ea2101( tokens );
    }
    
    equipmentroot = "";
    counter = 0;
    
    foreach ( tok in tokens )
    {
        if ( counter == 0 )
        {
            equipmentroot += tok;
            counter++;
            continue;
        }
        
        equipmentroot = equipmentroot + "_" + tok;
    }
    
    return equipmentroot;
}

// Namespace equipment_mp
// Params 0, eflags: 0x4
// Checksum 0xfb50ec76, Offset: 0x125a
// Size: 0x12b
function private function_5de69a1a893ed658()
{
    if ( !isdefined( level.var_e18d9ca34dbf9add ) )
    {
        level.var_e18d9ca34dbf9add = isdefined( level.gamemodebundle.var_d2492f51b192d947 );
    }
    
    if ( level.var_e18d9ca34dbf9add )
    {
        if ( function_4042d2fbe6237835( #"hash_1f9543bff3b05a27" ) )
        {
            level.var_e18d9ca34dbf9add = 0;
            return;
        }
    }
    
    if ( level.var_e18d9ca34dbf9add )
    {
        weaponmap = [];
        var_1851b2c8bd0f9c3c = getscriptbundle( level.gamemodebundle.var_d2492f51b192d947 );
        
        foreach ( weaponmapping in var_1851b2c8bd0f9c3c.var_30a89d5470e0d93c )
        {
            weaponmap[ weaponmapping.var_1912d0123d228ec3 ] = weaponmapping.var_63cbc4b3f9b451d2;
        }
        
        level.equipment.weaponmapping = weaponmap;
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0x69bdb5af, Offset: 0x138d
// Size: 0x575
function private loadequipmentbundles( equipmenttable )
{
    level.equipmentblueprints = [];
    level.var_1de668bdb367b433 = [];
    var_546c558fca86f4fe = getscriptbundle( equipmenttable );
    
    for ( i = 0; i < var_546c558fca86f4fe.equipment_list.size ; i++ )
    {
        equipmentref = var_546c558fca86f4fe.equipment_list[ i ].ref;
        equipmentbundlename = var_546c558fca86f4fe.equipment_list[ i ].bundle;
        
        if ( isdefined( equipmentref ) && isdefined( equipmentbundlename ) )
        {
            equipmentbundle = getscriptbundle( equipmentbundlename );
            
            if ( isdefined( equipmentbundle ) )
            {
                struct = spawnstruct();
                struct.ref = equipmentref;
                weaponname = equipmentbundle.useweapon;
                assert( isdefined( weaponname ), getxhashsourcename( equipmenttable ) + "<dev string:x6f>" + equipmentref + "<dev string:x7b>" );
                
                if ( weaponname != "none" )
                {
                    struct.objweapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
                    blueprints = getweaponblueprintnames( weaponname );
                    var_dac4de1a054e611c = blueprints.size;
                    
                    foreach ( blueprint, id in blueprints )
                    {
                        svariantid = weaponname + "|" + string( id );
                        var_dac4de1a054e611c = id > var_dac4de1a054e611c ? id : var_dac4de1a054e611c;
                        level.equipmentblueprints[ svariantid ] = function_6a820129c91338cb( weaponname, blueprint );
                    }
                    
                    struct.var_dac4de1a054e611c = var_dac4de1a054e611c;
                    
                    if ( isdefined( struct.objweapon ) )
                    {
                        level.var_1de668bdb367b433[ struct.objweapon.basenamehash ] = equipmentref;
                    }
                    
                    if ( isdefined( equipmentbundle.var_2e109accd83356e2 ) )
                    {
                        foreach ( wn in equipmentbundle.var_2e109accd83356e2 )
                        {
                            if ( !isdefined( wn.var_d3d64104f72ec581 ) )
                            {
                                continue;
                            }
                            
                            assert( isxhashasset( wn.var_d3d64104f72ec581 ) );
                            level.var_1de668bdb367b433[ wn.var_d3d64104f72ec581 ] = equipmentref;
                        }
                    }
                }
                
                struct.id = i;
                struct.image = equipmentbundle.image;
                struct.defaultslot = equipmentbundle.uislot == 2 ? "secondary" : "primary";
                struct.scavengerammo = equipmentbundle.scavengerammo ?? 0;
                struct.ammoboxammo = equipmentbundle.ammoboxammo;
                struct.utilityboxammo = equipmentbundle.utilityboxammo;
                struct.ispassive = isdefined( equipmentbundle.ispassive ) && equipmentbundle.ispassive;
                struct.isselectable = equipmentbundle.uiorder != -1;
                struct.weaponname = weaponname;
                struct.bundle = equipmentbundle;
                cricketweaponname = equipmentbundle.var_b7251b96720a4324;
                
                if ( isdefined( cricketweaponname ) )
                {
                    struct.cricketweaponname = cricketweaponname;
                    struct.var_f8ab75cc76c4430a = weapon_utility::function_d2c8356dc369d9ce( cricketweaponname );
                    
                    if ( !isdefined( level.var_1de668bdb367b433[ cricketweaponname ] ) )
                    {
                        level.var_1de668bdb367b433[ cricketweaponname ] = equipmentref;
                    }
                }
                
                var_8513b266e33b54c4 = equipmentbundle.damageweapons;
                
                if ( !isdefined( var_8513b266e33b54c4 ) )
                {
                    if ( weaponname != "none" )
                    {
                        struct.damageweaponnames = [ weaponname ];
                    }
                }
                else if ( var_8513b266e33b54c4 == "none" )
                {
                }
                else
                {
                    damageweaponnames = [];
                    
                    if ( weaponname != "none" )
                    {
                        damageweaponnames[ damageweaponnames.size ] = weaponname;
                    }
                    
                    var_cce0fed10bccff92 = strtok( var_8513b266e33b54c4, " " );
                    
                    foreach ( damageweaponname in var_cce0fed10bccff92 )
                    {
                        damageweaponnames[ damageweaponnames.size ] = damageweaponname;
                    }
                    
                    struct.damageweaponnames = damageweaponnames;
                }
                
                level.equipment.table[ equipmentref ] = struct;
            }
        }
    }
    
    utility::flag_set( "loadEquipmentBundles_finished" );
    
    /#
        function_52fe5e8b799cd5b7();
        
        if ( level.var_ac98e7cc4b10cb11 )
        {
            function_24824f49929fad94();
        }
    #/
}

// Namespace equipment_mp
// Params 0, eflags: 0x4
// Checksum 0x580d0c6d, Offset: 0x190a
// Size: 0x3eb
function private function_e59294212c1bdaf5()
{
    if ( !level.var_47dc93bc4166ba18 || !level.var_ac98e7cc4b10cb11 )
    {
        return;
    }
    
    var_74493990567c6efa = level.equipment;
    
    if ( !isarray( level.equipment.table ) || var_74493990567c6efa.protable )
    {
        return;
    }
    
    var_74493990567c6efa.protable = [];
    var_74493990567c6efa.var_3fa9633f9795b719 = [];
    var_74493990567c6efa.var_f6239534f2f3bc28 = [];
    var_74493990567c6efa.var_a418f1d88dec42c9 = [];
    var_74493990567c6efa.var_575bb73e456c1dea = [];
    
    foreach ( baseequip in var_74493990567c6efa.table )
    {
        var_c8839710abf0d329 = baseequip.bundle;
        var_aa0bd3518afab8d6 = baseequip.ref;
        
        if ( !isarray( var_c8839710abf0d329.var_8f21800662496353 ) )
        {
            continue;
        }
        
        foreach ( entry in var_c8839710abf0d329.var_8f21800662496353 )
        {
            if ( !entry.proasset )
            {
                continue;
            }
            
            var_36939f9b3e184f63 = getscriptbundle( entry.proasset );
            
            if ( !var_36939f9b3e184f63 || !isdefined( var_36939f9b3e184f63.lootid ) )
            {
                continue;
            }
            
            var_36939f9b3e184f63.var_6bda5cfddf2527bd = entry.proasset;
            struct = spawnstruct();
            struct.id = baseequip.id;
            struct.image = baseequip.image;
            struct.defaultslot = baseequip.defaultslot;
            struct.scavengerammo = baseequip.scavengerammo;
            struct.ammoboxammo = baseequip.ammoboxammo;
            struct.utilityboxammo = baseequip.utilityboxammo;
            struct.ispassive = baseequip.ispassive;
            struct.isselectable = baseequip.isselectable;
            struct.weaponname = baseequip.bundle.useweapon;
            struct.bundle = var_36939f9b3e184f63;
            struct.objweapon = baseequip.objweapon;
            
            if ( isdefined( struct.objweapon ) )
            {
                var_74493990567c6efa.var_575bb73e456c1dea[ struct.objweapon.basenamehash ] = struct;
            }
            
            var_74493990567c6efa.protable[ entry.proasset ] = struct;
            var_74493990567c6efa.var_3fa9633f9795b719[ var_36939f9b3e184f63.lootid ] = entry.proasset;
            var_74493990567c6efa.var_f6239534f2f3bc28[ var_36939f9b3e184f63.lootid ] = var_aa0bd3518afab8d6;
            var_74493990567c6efa.var_a418f1d88dec42c9[ var_36939f9b3e184f63.lootid ] = var_c8839710abf0d329.lootid;
        }
    }
    
    /#
        function_39bc33e18394c01e();
    #/
    
    level utility::flag_set( "ProContentEquipBundlesParsed" );
}

/#

    // Namespace equipment_mp
    // Params 0
    // Checksum 0x3f432504, Offset: 0x1cfd
    // Size: 0x1e3, Type: dev
    function function_39bc33e18394c01e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8b>" );
        
        foreach ( entry in level.equipment.table )
        {
            if ( !isdefined( entry.bundle ) || !isarray( entry.bundle.var_8f21800662496353 ) )
            {
                continue;
            }
            
            foreach ( proentry in entry.bundle.var_8f21800662496353 )
            {
                if ( !proentry.proasset )
                {
                    continue;
                }
                
                var_c7927ce1577966e = getxhashsourcename( proentry.proasset );
                parts = strtok( var_c7927ce1577966e, "<dev string:xbe>" );
                var_96b9086699c625d8 = parts.size > 1 ? parts[ 1 ] : var_c7927ce1577966e;
                
                if ( !var_c7927ce1577966e )
                {
                    continue;
                }
                
                devgui::add_devgui_command( "<dev string:xc0>" + entry.ref + "<dev string:xc2>" + var_96b9086699c625d8 + "<dev string:xc5>", "<dev string:xc7>" + var_c7927ce1577966e + "<dev string:xe4>" + entry.ref );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace equipment_mp
    // Params 0
    // Checksum 0x44d46f18, Offset: 0x1ee8
    // Size: 0x1e4, Type: dev
    function function_52fe5e8b799cd5b7()
    {
        devgui::function_9082edeb5db93280( "<dev string:x100>" );
        
        foreach ( equipment, entry in level.equipment.table )
        {
            devgui::add_devgui_command( "<dev string:xc0>" + equipment + "<dev string:xc2>" + entry.weaponname + "<dev string:xc5>", "<dev string:x11c>" + equipment );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x136>" );
        
        foreach ( equipment, entry in level.equipment.table )
        {
            blueprintnames = getweaponblueprintnames( entry.objweapon );
            
            foreach ( name, index in blueprintnames )
            {
                devgui::add_devgui_command( "<dev string:xc0>" + equipment + "<dev string:xc0>" + getxhashsourcename( name ), "<dev string:x15c>" + getxhashsourcename( name ) );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace equipment_mp
    // Params 0
    // Checksum 0xd79eff70, Offset: 0x20d4
    // Size: 0x1e8, Type: dev
    function function_24824f49929fad94()
    {
        devgui::function_9082edeb5db93280( "<dev string:x182>" );
        
        foreach ( equipment, entry in level.equipment.table )
        {
            if ( !entry.weaponname || entry.weaponname == "<dev string:x1b9>" || entry.weaponname == "<dev string:x1be>" )
            {
                continue;
            }
            
            attachments = function_2e5ecdd8ac47f308( entry.weaponname, "<dev string:x1c9>" );
            
            if ( isarray( attachments ) )
            {
                foreach ( attachment in attachments )
                {
                    var_3ae2613cf7b701ab = equipment;
                    
                    if ( issubstr( equipment, "<dev string:x1d1>" ) )
                    {
                        var_3ae2613cf7b701ab = getsubstr( equipment, 6 );
                    }
                    
                    attachmentdisplayname = attachment;
                    
                    if ( issubstr( attachment, "<dev string:x1d8>" ) )
                    {
                        attachmentdisplayname = "<dev string:x1d8>";
                    }
                    else if ( issubstr( attachment, "<dev string:x1de>" ) )
                    {
                        attachmentdisplayname = "<dev string:x1de>";
                    }
                    
                    devgui::add_devgui_command( "<dev string:xc0>" + var_3ae2613cf7b701ab + "<dev string:xc2>" + attachmentdisplayname + "<dev string:xc5>", "<dev string:x1e2>" + attachment + "<dev string:xe4>" + equipment );
                }
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace equipment_mp
// Params 1
// Checksum 0xfab34839, Offset: 0x22c4
// Size: 0x63, Type: bool
function function_ae4237ff60a6e452( ref )
{
    if ( !ref )
    {
        return false;
    }
    
    if ( level.var_47dc93bc4166ba18 && isdefined( level.equipment.protable[ ref ] ) )
    {
        return true;
    }
    
    if ( level.equipment.table[ ref ] )
    {
        return true;
    }
    
    return isdefined( supers_mp::function_4b7b32d1d5b0c427( ref ) );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x1b6debcd, Offset: 0x2330
// Size: 0xa7
function getequipmenttableinfo( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        return level.equipment.table[ ref ];
    }
    
    if ( level.var_47dc93bc4166ba18 )
    {
        var_7781459233518d3c = getxhashasset( ref );
        return level.equipment.protable[ var_7781459233518d3c ];
    }
    
    var_deab6db716beff4b = supers_mp::function_4b7b32d1d5b0c427( ref );
    assert( isdefined( var_deab6db716beff4b ), "<dev string:x209>" + ref + "<dev string:x21f>" );
    return var_deab6db716beff4b;
}

// Namespace equipment_mp
// Params 5
// Checksum 0x51c06ba, Offset: 0x23e0
// Size: 0x72d
function giveequipment( ref, slot, class, variantid, attachments )
{
    assert( isdefined( ref ) );
    assert( isdefined( slot ) );
    
    if ( !isdefined( self.equipment ) )
    {
        self.equipment = [];
    }
    
    if ( !isdefined( self.var_e6d8cfcc28a79324 ) )
    {
        self.var_e6d8cfcc28a79324 = [];
    }
    
    if ( ref == "none" )
    {
        return;
    }
    
    if ( slot == "secondary" && level.var_b7e70fa484e134dc && supers_mp::issuperinuse( #"tactical" ) )
    {
        supers_mp::superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, #"tactical" );
    }
    
    if ( !isdefined( level.var_5fe219d680afd262 ) )
    {
        level.var_5fe219d680afd262 = getdvarint( @"hash_2c797047acb795ab", 0 );
    }
    
    if ( level.var_5fe219d680afd262 && equipmentisrestricted( ref ) )
    {
        return;
    }
    
    tableinfo = getequipmenttableinfo( ref );
    assert( isdefined( tableinfo ), "<dev string:x24c>" + ref + "<dev string:x275>" );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    if ( slot == "super" && isdefined( level.br_pickups ) )
    {
        if ( isdefined( level.br_pickups.br_equipnametoscriptable[ ref ] ) )
        {
            supername = level.br_pickups.br_lootreference[ level.br_pickups.br_equipnametoscriptable[ ref ] ];
            
            if ( utility::issharedfuncdefined( #"supers", #"hash_d353fb96f3695667" ) )
            {
                tableinfo.id = [[ utility::getsharedfunc( #"supers", #"hash_d353fb96f3695667" ) ]]( supername );
            }
        }
    }
    
    takeequipment( slot );
    
    if ( isdefined( self.var_8cf9648fae56099c[ ref ] ) && !isdefined( variantid ) )
    {
        variantid = self.var_8cf9648fae56099c[ ref ];
    }
    
    if ( !isdefined( variantid ) )
    {
        variantid = equipment_utility::function_53b772686abfc378( ref );
    }
    
    if ( variantid > 0 )
    {
        var_dac4de1a054e611c = function_d3f81abc962f1d9c( ref );
        
        if ( variantid > var_dac4de1a054e611c )
        {
            assertmsg( "<dev string:x277>" + variantid + "<dev string:x2ac>" + ref + "<dev string:x2bf>" + var_dac4de1a054e611c );
            variantid = 0;
        }
    }
    
    weapon = function_f3104335c7fe8d43( tableinfo, variantid, attachments );
    
    if ( isdefined( weapon ) )
    {
        if ( level.gametype == "ob" && getdvarint( @"hash_5e7b31c6b80ee8b3", 0 ) && isequipmentlethal( ref ) )
        {
            foreach ( var_421a8e537d82e2ee in self.equippedweapons )
            {
                if ( weapon::isweaponequipment( var_421a8e537d82e2ee ) )
                {
                    var_9da5e3b7e787b695 = function_fdc4a655fbde0dec( var_421a8e537d82e2ee.basename );
                    
                    if ( !weapon::issuperweapon( var_421a8e537d82e2ee ) && var_9da5e3b7e787b695 && level.equipment.table[ var_9da5e3b7e787b695 ] && level.equipment.table[ var_9da5e3b7e787b695 ].bundle.equipmenttype == "lethal" )
                    {
                        if ( getdvarint( @"hash_d85c338f51e0290a", 0 ) )
                        {
                            weaponnames = "";
                            
                            for ( i = 0; i < self.equippedweapons.size ; i++ )
                            {
                                equippedweapon = self.equippedweapons[ i ];
                                var_acc1296fbbdd3f49 = "Weapon Index " + i + ": " + equippedweapon.basename;
                                weaponnames = weaponnames + var_acc1296fbbdd3f49 + "\n";
                            }
                            
                            equipmentnames = "";
                            var_24e5d21587d2f0a = self.equipment[ "primary" ];
                            var_d4b1855ffab9f5a3 = "Primary Equipment: " + var_24e5d21587d2f0a;
                            var_3ad31d2512157a1e = self.equipment[ "secondary" ];
                            var_7e5e893b0464306f = "Secondary Equipment: " + var_3ad31d2512157a1e;
                            equipmentnames = equipmentnames + var_d4b1855ffab9f5a3 + "\n" + var_7e5e893b0464306f + "\n";
                            script::demoforcesre( "Multiple lethals attempted to be added to the player's inventory:\n" + "Current Weapons: " + weaponnames + "\n" + "Current Equipment: " + equipmentnames + "\n" + "Attempted Equipment: " + weapon.basename + "\n" );
                        }
                        
                        inventory_utility::_takeweapon( var_421a8e537d82e2ee );
                    }
                }
            }
        }
        
        self giveweapon( weapon );
        var_21f107dee26bd6a = is_equipment_slot_allowed( slot ) || level.var_59a61d1ea442eb02 && !flags::gameflag( "prematch_done" );
        
        if ( var_21f107dee26bd6a && !tableinfo.ispassive )
        {
            if ( slot == "primary" )
            {
                self assignweaponoffhandprimary( weapon );
            }
            else if ( slot == "secondary" )
            {
                self assignweaponoffhandsecondary( weapon );
            }
            else if ( slot == "super" || slot == "tertiary" )
            {
                self assignweaponoffhandspecial( weapon );
            }
        }
    }
    
    function_e8fcb0b6a6a01dad( slot, tableinfo.id );
    self.equipment[ slot ] = ref;
    self.var_e6d8cfcc28a79324[ slot ] = weapon;
    ongivecallback = getcallback( ref, "onGive" );
    
    if ( isdefined( ongivecallback ) )
    {
        self thread [[ ongivecallback ]]( ref, slot, variantid, attachments );
    }
    
    updateammocount( slot, class );
    
    if ( level.var_b7e70fa484e134dc && slot == "secondary" && tableinfo.bundle.issuper )
    {
        var_68a2d5f3aa12e75b = level.superglobals.var_385fefa79e4f1bde;
        
        /#
            if ( level.superglobals.var_1a7a620a960090b9 )
            {
                var_68a2d5f3aa12e75b = level.superglobals.var_1a7a620a960090b9;
            }
        #/
        
        supers_mp::givesuper( tableinfo.bundle.superref, undefined, var_68a2d5f3aa12e75b, undefined, undefined, #"tactical" );
    }
    
    isthrowing = ref == "equip_throwing_knife" || ref == "equip_throwing_knife_fire" || ref == "equip_throwing_knife_electric" || ref == "equip_shuriken" || ref == "equip_mutation_throwstar";
    
    if ( game_utility::getgametype() == "arena" && isthrowing )
    {
    }
    else
    {
        thread watchlethaldelayplayer( ref, slot );
    }
    
    self notify( #"equipment_given", ref, slot );
    thread function_fb1010c8ff915317( ref, slot, variantid, attachments, class );
    callback::callback( #"equipment_given", { #slot:slot, #ref:ref } );
}

// Namespace equipment_mp
// Params 5
// Checksum 0x76d0ac47, Offset: 0x2b15
// Size: 0x2fb
function function_fb1010c8ff915317( equipref, slot, variantid, equipattachments, class )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.var_73926dc557be15a2 ) )
    {
        level.var_73926dc557be15a2 = [ "tertiary":"ui_tertiary_recharge_progress", "secondary":"ui_tactical_recharge_progress", "primary":"ui_lethal_recharge_progress" ];
    }
    
    if ( !isdefined( level.var_4564ab52a6a00ef5 ) )
    {
        level.var_4564ab52a6a00ef5 = [ "tertiary":"ui_tertiary_recharge_timer", "secondary":"ui_tactical_recharge_timer", "primary":"ui_lethal_recharge_timer" ];
    }
    
    bundle = level.equipment.table[ equipref ].bundle;
    
    if ( bundle.var_ff969a74ed1aaeba && !level.var_83d8ad2846573fbf )
    {
        threadclass = class ?? "";
        
        if ( !self.var_430dacaec72befdf[ threadclass ] || self.pers[ "rechargeEquipment" ][ slot ].ref != equipref )
        {
            thread function_a24c757b0224bd9c( class );
            self.var_430dacaec72befdf[ threadclass ] = 1;
        }
        
        if ( self.pers[ "rechargeEquipment" ][ slot ].ref != equipref )
        {
            self.pers[ "rechargeEquipment" ][ slot ] = { #attachments:equipattachments, #variant:variantid, #class:class, #slot:slot, #var_c8d12fce75a1f69d:bundle.var_c8d12fce75a1f69d, #var_e734cfc5db84ec9c:bundle.var_e734cfc5db84ec9c, #var_4a50548c9a4f6682:bundle.var_81791c5da223736a, #var_eb18bebb7b0484fd:bundle.var_a049f4e7e93e05a5, #var_18f81b5d17e7541a:bundle.var_dfa29c6f5a0e2402, #var_13944e5e2e56f0b8:bundle.var_13944e5e2e56f0b8, #rechargetime:bundle.var_af22ec8b7c14505e, #ref:equipref };
            self.pers[ "rechargeEquipment" ][ slot ].rechargeremaining = self.pers[ "rechargeEquipment" ][ slot ].var_af22ec8b7c14505e;
            function_292817f6f6230815( slot, 0, 0 );
            self setpowerprogress( slot, 0 );
            ammo = getequipmentammo( equipref );
            self.pers[ "rechargeEquipment" ][ slot ].rechargeremaining = undefined;
            self.pers[ "rechargeEquipment" ][ slot ].ammo = ammo;
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x68254e7f, Offset: 0x2e18
// Size: 0x23b
function takeequipment( slot )
{
    assert( isdefined( slot ) );
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    tableinfo = getequipmenttableinfo( ref );
    
    if ( isdefined( tableinfo ) && isdefined( tableinfo.objweapon ) )
    {
        var_9bf159279f3c7c5b = undefined;
        
        if ( getdvarint( @"hash_22541071c575fe17", 1 ) )
        {
            equipmentlist = self getweaponslistoffhands();
            
            foreach ( equip in equipmentlist )
            {
                equipref = function_fdc4a655fbde0dec( equip.basename );
                
                if ( equipref == ref )
                {
                    if ( isdefined( self.perks[ "specialty_cricket" ] ) )
                    {
                        var_9bf159279f3c7c5b = tableinfo.var_f8ab75cc76c4430a;
                    }
                    else if ( equip.variantid > 0 || equip.attachments.size > 0 )
                    {
                        var_9bf159279f3c7c5b = buildequipment( equip.basename, equip.variantid, equip.attachments );
                    }
                    else
                    {
                        var_9bf159279f3c7c5b = tableinfo.objweapon;
                    }
                    
                    break;
                }
            }
        }
        else
        {
            var_9bf159279f3c7c5b = tableinfo.objweapon;
        }
        
        if ( isdefined( var_9bf159279f3c7c5b ) && self hasweapon( var_9bf159279f3c7c5b ) )
        {
            inventory_utility::_takeweapon( var_9bf159279f3c7c5b );
            
            if ( slot == "primary" )
            {
                self clearoffhandprimary();
            }
            else if ( slot == "secondary" )
            {
                self clearoffhandsecondary();
            }
        }
    }
    
    function_e8fcb0b6a6a01dad( slot, 0 );
    self.equipment[ slot ] = undefined;
    self.var_e6d8cfcc28a79324[ slot ] = undefined;
    ontakecallback = getcallback( ref, "onTake" );
    
    if ( isdefined( ontakecallback ) )
    {
        self thread [[ ontakecallback ]]( ref, slot );
    }
    
    updateammocount( slot );
    self notify( "equipment_taken_" + ref );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x5d170640, Offset: 0x305b
// Size: 0x15c
function equiponplayerdamaged( data )
{
    weaponname = data.objweapon.basename;
    
    foreach ( ref, tableinfo in level.equipment.table )
    {
        onplayerdamagedcallback = getcallback( ref, "onPlayerDamaged" );
        
        if ( isdefined( onplayerdamagedcallback ) && isdefined( tableinfo.damageweaponnames ) )
        {
            foreach ( damageweaponname in tableinfo.damageweaponnames )
            {
                if ( damageweaponname == weaponname )
                {
                    profilestart();
                    result = [[ onplayerdamagedcallback ]]( data );
                    profilestop();
                    return result;
                }
            }
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xa5b4a557, Offset: 0x31bf
// Size: 0x15c
function equiponplayerkilled( data )
{
    weaponname = data.objweapon.basename;
    
    foreach ( ref, tableinfo in level.equipment.table )
    {
        onplayerkilledcallback = getcallback( ref, "onPlayerKilled" );
        
        if ( isdefined( onplayerkilledcallback ) && isdefined( tableinfo.damageweaponnames ) )
        {
            foreach ( damageweaponname in tableinfo.damageweaponnames )
            {
                if ( damageweaponname == weaponname )
                {
                    profilestart();
                    result = [[ onplayerkilledcallback ]]( data );
                    profilestop();
                    return result;
                }
            }
        }
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0x30d5e1bc, Offset: 0x3323
// Size: 0x67, Type: bool
function ondestroyedbytrophy()
{
    ref = self.equipmentref ?? self.streakname;
    
    if ( isdefined( ref ) )
    {
        var_7188af2d1400239a = getcallback( ref, "onDestroyedByTrophy" );
        
        if ( isdefined( var_7188af2d1400239a ) )
        {
            self thread [[ var_7188af2d1400239a ]]();
            return true;
        }
        else if ( weapons::isplantedequipment( self ) )
        {
            thread weapons::deleteexplosive();
            return true;
        }
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x46e5d815, Offset: 0x3393
// Size: 0x69
function function_b1928e5713e81b5e( index )
{
    switch ( index )
    {
        case 0:
            return "primary";
        case 1:
            return "secondary";
        case 2:
            return "health";
        default:
            assert( 0, "<dev string:x2d4>" + index );
            break;
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xae8f3494, Offset: 0x3404
// Size: 0x45
function disableslotinternal( slot )
{
    if ( slot == "primary" )
    {
        self clearoffhandprimary();
        return;
    }
    
    if ( slot == "secondary" )
    {
        self clearoffhandsecondary();
        return;
    }
    
    if ( slot == "super" )
    {
        self clearoffhandspecial();
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x90db3aa, Offset: 0x3451
// Size: 0xb9
function enableslotinternal( slot )
{
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    tableinfo = getequipmenttableinfo( ref );
    
    if ( isdefined( tableinfo ) && isdefined( tableinfo.objweapon ) && !tableinfo.ispassive )
    {
        if ( slot == "primary" )
        {
            self assignweaponoffhandprimary( tableinfo.objweapon );
            return;
        }
        
        if ( slot == "secondary" )
        {
            self assignweaponoffhandsecondary( tableinfo.objweapon );
            return;
        }
        
        if ( slot == "super" )
        {
            self assignweaponoffhandspecial( tableinfo.objweapon );
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x3b8b8ce6, Offset: 0x3512
// Size: 0x64
function is_equipment_slot_allowed( slot )
{
    if ( level.var_689bd5a3a449c01d )
    {
        return 1;
    }
    
    switch ( slot )
    {
        case #"hash_325cb2e66f67d5b9":
            return val::get( "equipment_primary" );
        case #"hash_511d3c24fcedcdb1":
            return val::get( "equipment_secondary" );
        default:
            return 1;
    }
}

// Namespace equipment_mp
// Params 2
// Checksum 0x588e3faa, Offset: 0x357e
// Size: 0x67
function function_e8fcb0b6a6a01dad( slot, id )
{
    if ( slot != "super" && slot != "none" )
    {
        self setclientomnvar( "ui_equipment_id_" + slot, id );
        return;
    }
    
    if ( level.gametypebundle.var_a81b1ce78da591f1 )
    {
        thread supers_mp::function_cb3e288a8ed4df3e( 1 );
        thread supers_mp::handlesuperuistatechange( 2 );
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0x35860ca0, Offset: 0x35ed
// Size: 0xb
function function_46b102c55f314986()
{
    return self.equipment;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xbd90172e, Offset: 0x3601
// Size: 0x18
function getcurrentequipment( slot )
{
    return self.equipment[ slot ];
}

// Namespace equipment_mp
// Params 1
// Checksum 0x9af4304f, Offset: 0x3622
// Size: 0x18
function function_65267b7e18646851( slot )
{
    return self.var_e6d8cfcc28a79324[ slot ];
}

// Namespace equipment_mp
// Params 1
// Checksum 0x1212598a, Offset: 0x3643
// Size: 0x113
function clearallequipment( var_9edcca6343f41f5b )
{
    if ( !isdefined( self.equipment ) )
    {
        return;
    }
    
    foreach ( slot, ref in self.equipment )
    {
        if ( var_9edcca6343f41f5b && slot == "health" )
        {
            continue;
        }
        
        if ( !self.var_b4c45c2992c2e37c.stackprimary && slot == "primary" || !self.var_b4c45c2992c2e37c.stacksecondary && slot == "secondary" || !self.var_b4c45c2992c2e37c.stacktertiary && slot == "tertiary" )
        {
            takeequipment( slot );
        }
    }
}

// Namespace equipment_mp
// Params 2
// Checksum 0x66a19892, Offset: 0x375e
// Size: 0x4b
function function_95a61402644e5a06( ref, maxammo )
{
    if ( utility::issharedfuncdefined( #"skills", #"hash_28be1e74b50af850" ) )
    {
        return utility::callsharedfunc( #"skills", #"hash_28be1e74b50af850", ref );
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xd04f0807, Offset: 0x37b2
// Size: 0x42
function function_caabefd06f3c41ee( ref )
{
    if ( utility::issharedfuncdefined( #"skills", #"hash_b5a7f9c7f63c374a" ) )
    {
        return utility::callsharedfunc( #"skills", #"hash_b5a7f9c7f63c374a", ref );
    }
}

// Namespace equipment_mp
// Params 2
// Checksum 0x26640243, Offset: 0x37fd
// Size: 0x34
function function_2bdf792341134ea2( maxammo, objweapon )
{
    assert( objweapon, "<dev string:x305>" );
    return int( min( maxammo, weaponclipsize( objweapon ) ) );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x5aeee03a, Offset: 0x383a
// Size: 0x1d1
function function_7a52ef490f6da37a( classtype )
{
    var_2e5e4eab711fb7ef = level.gamemodebundle.var_2e5e4eab711fb7ef;
    
    if ( var_2e5e4eab711fb7ef )
    {
        var_786cefe8eeca4f74 = isdefined( self.perks[ var_2e5e4eab711fb7ef ] );
        
        if ( !var_786cefe8eeca4f74 )
        {
            return 0;
        }
    }
    
    if ( !isdefined( level.gamemodebundle ) || !level.gamemodebundle.var_ed83f0f1668a6ed2 )
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_c550982edd11c6cb" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_949ff3f9d30b937c" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    else
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"cac_getflcextraequipmentprimary" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"table_getflcextraequipmentprimary" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    
    return 0;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x176758f3, Offset: 0x3a14
// Size: 0x1d1
function function_909ac8ba57a9d26e( classtype )
{
    var_f7933e53aa873883 = level.gamemodebundle.var_f7933e53aa873883;
    
    if ( var_f7933e53aa873883 )
    {
        var_786cefe8eeca4f74 = isdefined( self.perks[ var_f7933e53aa873883 ] );
        
        if ( !var_786cefe8eeca4f74 )
        {
            return 0;
        }
    }
    
    if ( !isdefined( level.gamemodebundle ) || !level.gamemodebundle.var_ed83f0f1668a6ed2 )
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_b19221c85188b3ef" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_f5a30b1ddb4dc4b4" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    else
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"cac_getflcextraequipmentsecondary" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"table_getflcextraequipmentsecondary" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    
    return 0;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xe8f65f07, Offset: 0x3bee
// Size: 0x1d1
function function_fde3068b9ac629fe( classtype )
{
    var_fce10a2ea20227d3 = level.gamemodebundle.var_fce10a2ea20227d3;
    
    if ( var_fce10a2ea20227d3 )
    {
        var_786cefe8eeca4f74 = isdefined( self.perks[ var_fce10a2ea20227d3 ] );
        
        if ( !var_786cefe8eeca4f74 )
        {
            return 0;
        }
    }
    
    if ( !isdefined( level.gamemodebundle ) || !level.gamemodebundle.var_ed83f0f1668a6ed2 )
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_eb06e07c96d7d3c9" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_e65b421cf8ab3c94" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    else
    {
        switch ( classtype )
        {
            case #"hash_44e999799ff10fce":
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_7ae4184eac2114" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( self.class_num );
                }
                
                break;
            case #"hash_412d4adaf2412dc0":
                break;
            default:
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"loadout" ][ #"hash_89bd27cc8cc3270b" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    return self [[ var_32dbca3143d9c4a5 ]]( level.classtablename, self.class_num );
                }
                
                break;
        }
    }
    
    return 0;
}

// Namespace equipment_mp
// Params 3
// Checksum 0xb16e4851, Offset: 0x3dc8
// Size: 0x9f
function getequipmentmaxammo( ref, class, slot )
{
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !tableinfo )
    {
        return;
    }
    
    if ( !tableinfo.objweapon )
    {
        return 0;
    }
    
    if ( !isdefined( slot ) )
    {
        slot = findequipmentslot( ref );
    }
    
    if ( common_item::items_isenabled() )
    {
        maxammo = function_ff52646ead6eca2d( ref, slot, tableinfo );
    }
    else if ( isbrgamemode() )
    {
        maxammo = function_eea49a8286718e7( ref, slot, tableinfo );
    }
    else
    {
        maxammo = function_9c2c4b0ce8c26aa0( ref, slot, class, tableinfo );
    }
    
    return maxammo;
}

// Namespace equipment_mp
// Params 3, eflags: 0x4
// Checksum 0x69e79ac3, Offset: 0x3e70
// Size: 0x173
function private function_ff52646ead6eca2d( ref, slot, tableinfo )
{
    if ( ref == ( level.armorref ?? "equip_armorplate" ) )
    {
        return armor::function_db9ebf086f67fe92();
    }
    
    var_2409e4d1557d879a = function_caabefd06f3c41ee( ref );
    
    if ( isint( var_2409e4d1557d879a ) )
    {
        return function_2bdf792341134ea2( var_2409e4d1557d879a, tableinfo.objweapon );
    }
    
    itembundle = common_item::function_cf68ad18114498b2( ref );
    maxammo = isdefined( itembundle ) ? common_item::function_5f3f8e423378acd6( itembundle ) : weaponmaxammo( tableinfo.objweapon );
    
    if ( itembundle.var_4c378a31417eaf3d && isdefined( slot ) && isdefined( itembundle.var_f96b9b6aff0b335f ) )
    {
        if ( function_af93851266de71f3( slot ) )
        {
            maxammo = itembundle.var_f96b9b6aff0b335f;
        }
    }
    
    var_76d0a72c36eb61f = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_fully_equipped" );
    
    if ( var_76d0a72c36eb61f )
    {
        bonusmaxammo = level.zombie_augments[ #"z_mod_fully_equipped" ].var_205d07f13ea7e54c ?? 0;
    }
    else
    {
        bonusmaxammo = function_95a61402644e5a06( ref );
    }
    
    maxammo += bonusmaxammo ?? 0;
    maxammo = function_2bdf792341134ea2( maxammo, tableinfo.objweapon );
    return maxammo;
}

// Namespace equipment_mp
// Params 4, eflags: 0x4
// Checksum 0xfbba61fb, Offset: 0x3fec
// Size: 0x350
function private function_9c2c4b0ce8c26aa0( ref, slot, class, tableinfo )
{
    if ( ref == ( level.armorref ?? "equip_armorplate" ) )
    {
        return armor::function_db9ebf086f67fe92();
    }
    
    maxammo = weaponmaxammo( tableinfo.objweapon, function_6a8b12ac3ea75f73( slot ) );
    
    switch ( ref )
    {
        case #"hash_6d194c409057b2":
        case #"hash_48d3196b46b0ba61":
        case #"hash_4b4a6458f00d9319":
        case #"hash_8770d1da0d7395b9":
        case #"hash_aa60ec2aec479ec8":
        case #"hash_cbcb2b145327e750":
            break;
        default:
            if ( level.gametype == "free_run" || level.gametype == "free_run_evo" )
            {
                break;
            }
            
            if ( level.gametype == "missions" )
            {
                break;
            }
            
            if ( level.gametype == "dungeons" )
            {
                break;
            }
            
            maxammo--;
            break;
    }
    
    if ( !isdefined( slot ) )
    {
        return maxammo;
    }
    
    if ( slot == "primary" )
    {
        if ( function_e210084550f602a( 1 ) )
        {
            if ( isdefined( self.perks[ "specialty_ninja_vest" ] ) )
            {
                if ( issubstr( ref, "throwing_knife" ) || issubstr( ref, "throwstar" ) || issubstr( ref, "shuriken" ) )
                {
                    maxammo++;
                }
            }
            else
            {
                maxammo++;
            }
        }
    }
    
    if ( slot == "secondary" )
    {
        if ( function_18b9048f4179b66b( 1 ) )
        {
            maxammo++;
        }
    }
    
    if ( !isdefined( class ) && isdefined( self.class ) )
    {
        var_9b32ff7ece4ddf79 = self.class;
        
        if ( utility::issharedfuncdefined( #"loadout", #"hash_9603d2d494ac9c0" ) )
        {
            classtype = [[ utility::getsharedfunc( #"loadout", #"hash_9603d2d494ac9c0" ) ]]( var_9b32ff7ece4ddf79 );
        }
        
        var_e3c7e304626f95c8 = slot == "primary" && ref == self.loadoutequipmentprimary;
        var_fb19987fe8f63b38 = slot == "secondary" && ref == self.loadoutequipmentsecondary;
        var_c72c3dc302fadd12 = var_e3c7e304626f95c8 || var_fb19987fe8f63b38;
        
        if ( classtype == "default" && var_c72c3dc302fadd12 )
        {
            class = var_9b32ff7ece4ddf79;
        }
    }
    
    if ( isdefined( class ) )
    {
        classtype = undefined;
        
        if ( utility::issharedfuncdefined( #"loadout", #"hash_9603d2d494ac9c0" ) )
        {
            classtype = [[ utility::getsharedfunc( #"loadout", #"hash_9603d2d494ac9c0" ) ]]( class );
        }
        
        var_aaec75f68d9cc2f6 = function_7a52ef490f6da37a( classtype );
        var_d686f40b80029d52 = function_909ac8ba57a9d26e( classtype );
        
        if ( ( var_aaec75f68d9cc2f6 || function_27c772da069463d8() ) && slot == "primary" )
        {
            maxammo++;
        }
        
        if ( ( var_d686f40b80029d52 || function_24e65fe1b0552823() ) && slot == "secondary" )
        {
            maxammo++;
        }
    }
    else if ( function_27c772da069463d8() && slot == "primary" )
    {
        maxammo++;
    }
    else if ( function_24e65fe1b0552823() && slot == "secondary" )
    {
        maxammo++;
    }
    
    return maxammo;
}

// Namespace equipment_mp
// Params 3, eflags: 0x4
// Checksum 0x85f85b47, Offset: 0x4345
// Size: 0x190
function private function_eea49a8286718e7( ref, slot, tableinfo )
{
    if ( !isdefined( tableinfo.ref ) )
    {
        return 0;
    }
    
    if ( isdefined( level.br_pickups.br_equipnametoscriptable[ tableinfo.ref ] ) )
    {
        equipmentname = level.br_pickups.br_equipnametoscriptable[ tableinfo.ref ];
    }
    else
    {
        equipmentname = level.br_pickups.br_equipnametoscriptable[ getxhash( tableinfo.ref ) ];
    }
    
    if ( !isdefined( level.br_pickups.maxcounts[ equipmentname ] ) )
    {
        assertmsg( "<dev string:x332>" + equipmentname + "<dev string:x33d>" );
    }
    
    maxammo = level.br_pickups.maxcounts[ equipmentname ];
    
    if ( !isdefined( maxammo ) )
    {
        maxammo = 0;
    }
    
    if ( ref == ( level.armorref ?? "equip_armorplate" ) )
    {
        if ( level.var_6a8faefd19f2a7ce )
        {
            maxammo = level.var_6a8faefd19f2a7ce;
        }
        else
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"equipment" ][ #"hash_71d917f49196b82c" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                hasplatepouch = self [[ var_32dbca3143d9c4a5 ]]();
            }
            else
            {
                hasplatepouch = 0;
            }
            
            maxammo += hasplatepouch ? getdvarint( @"hash_a5ab8ed6cc1b486a", 5 ) : 0;
        }
    }
    
    return maxammo;
}

// Namespace equipment_mp
// Params 0
// Checksum 0x924fde95, Offset: 0x44de
// Size: 0x26, Type: bool
function function_27c772da069463d8()
{
    return isdefined( self.perks[ "specialty_grenadier_vest" ] ) || isdefined( self.perks[ "specialty_rhino_rig" ] );
}

// Namespace equipment_mp
// Params 0
// Checksum 0x1b2e6e29, Offset: 0x450d
// Size: 0x3a, Type: bool
function function_24e65fe1b0552823()
{
    return isdefined( self.perks[ "specialty_tac_vest" ] ) || isdefined( self.perks[ "specialty_rhino_rig" ] ) || isdefined( self.perks[ "specialty_pistol_vest" ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x34bf3d8f, Offset: 0x4550
// Size: 0x4c, Type: bool
function function_18b9048f4179b66b( var_21c2cb8cf5cf468c )
{
    if ( isdefined( self.perks[ "specialty_extra_tactical" ] ) || isdefined( self.perks[ "specialty_trait_extra_tactical" ] ) )
    {
        return true;
    }
    
    return var_21c2cb8cf5cf468c && isdefined( self.perks[ "specialty_extraoffhandammo" ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x80193551, Offset: 0x45a5
// Size: 0x79, Type: bool
function function_e210084550f602a( var_21c2cb8cf5cf468c )
{
    if ( isdefined( self.perks[ "specialty_extra_lethal" ] ) || isdefined( self.perks[ "specialty_extra_deadly" ] ) || isdefined( self.perks[ "specialty_trait_extra_lethal" ] ) )
    {
        return true;
    }
    
    if ( !level.gametypebundle.extraoffhandammolethal )
    {
        return false;
    }
    
    return var_21c2cb8cf5cf468c && isdefined( self.perks[ "specialty_extraoffhandammo" ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf9b55d5a, Offset: 0x4627
// Size: 0x35, Type: bool
function function_af93851266de71f3( slot )
{
    if ( slot == "primary" )
    {
        return function_e210084550f602a( 1 );
    }
    
    if ( slot == "secondary" )
    {
        return function_18b9048f4179b66b( 1 );
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x8a723235, Offset: 0x4665
// Size: 0x50
function function_6a8b12ac3ea75f73( slot )
{
    if ( !isdefined( self.perks[ "specialty_extraoffhandammo" ] ) )
    {
        return 0;
    }
    
    if ( slot == "secondary" )
    {
        return 1;
    }
    
    if ( slot == "primary" )
    {
        return level.gametypebundle.extraoffhandammolethal;
    }
    
    return 0;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x8b89d30a, Offset: 0x46be
// Size: 0x2f, Type: bool
function function_d3f81abc962f1d9c( ref )
{
    tableinfo = getequipmenttableinfo( ref );
    return tableinfo.var_dac4de1a054e611c ?? 0;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x373cc25b, Offset: 0x46f6
// Size: 0x4a
function getequipmentstartammo( ref )
{
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    if ( !isdefined( tableinfo.objweapon ) )
    {
        return 0;
    }
    
    return weaponstartammo( tableinfo.objweapon, 0 );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xec837aa0, Offset: 0x4749
// Size: 0x121
function getequipmentammo( ref )
{
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    if ( !isdefined( tableinfo.objweapon ) )
    {
        return 0;
    }
    
    if ( !isplayer( self ) && !isagent( self ) )
    {
        return 0;
    }
    
    weapon = function_f3104335c7fe8d43( tableinfo );
    
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    ammocount = self getammocount( weapon );
    
    if ( ammocount == 0 )
    {
        tableweaponname = weapon.basename;
        
        foreach ( weaponobj in self.offhandinventory )
        {
            if ( weaponobj.basename == tableweaponname )
            {
                ammocount = self getammocount( weaponobj );
            }
        }
    }
    
    return ammocount;
}

// Namespace equipment_mp
// Params 3
// Checksum 0x1bc0bab2, Offset: 0x4873
// Size: 0x19e
function setequipmentammo( ref, amount, maxammo )
{
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !( isdefined( tableinfo ) && isdefined( tableinfo.objweapon ) ) )
    {
        return;
    }
    
    variantid = undefined;
    attachments = undefined;
    equipmentlist = self getweaponslistoffhands();
    
    foreach ( equip in equipmentlist )
    {
        equipref = function_fdc4a655fbde0dec( equip.basename );
        
        if ( equipref == ref )
        {
            variantid = equip.variantid;
            attachments = equip.attachments;
            break;
        }
    }
    
    if ( !isdefined( variantid ) )
    {
        variantid = tableinfo.variantid;
    }
    
    weapon = function_f3104335c7fe8d43( tableinfo, variantid, attachments );
    self setweaponammoclip( weapon, amount );
    slot = findequipmentslot( ref );
    updateammocount( slot, undefined, maxammo );
    callback::callback( #"equipment_ammo_set", { #maxammo:maxammo, #amount:amount, #slot:slot, #ref:ref } );
}

// Namespace equipment_mp
// Params 4
// Checksum 0x2d944d85, Offset: 0x4a19
// Size: 0xbf
function incrementequipmentammo( ref, incrementamount = 1, class, var_c4f01512409e2975 )
{
    currammo = getequipmentammo( ref );
    
    if ( !isdefined( currammo ) )
    {
        logstring( "incrementEquipmentAmmo: Equipment ref \"" + ref + "\" does not have a valid ammo count." );
        return;
    }
    
    var_e091d6f51cf71405 = getequipmentmaxammo( ref, class );
    newammo = int( min( currammo + incrementamount, var_e091d6f51cf71405 ) );
    
    if ( !var_c4f01512409e2975 )
    {
        var_1307eebeedc0f6f7 = getcallback( ref, "onIncrement" );
        
        if ( isdefined( var_1307eebeedc0f6f7 ) )
        {
            self thread [[ var_1307eebeedc0f6f7 ]]( ref, currammo );
        }
    }
    
    setequipmentammo( ref, newammo );
}

// Namespace equipment_mp
// Params 3
// Checksum 0x637b7657, Offset: 0x4ae0
// Size: 0x78
function decrementequipmentammo( ref, decrementamount = 1, class )
{
    currammo = getequipmentammo( ref );
    decrementamount = int( min( decrementamount, currammo ) );
    
    if ( decrementamount > 0 )
    {
        newammo = int( min( currammo - decrementamount, getequipmentmaxammo( ref, class ) ) );
        setequipmentammo( ref, newammo );
    }
}

// Namespace equipment_mp
// Params 3
// Checksum 0xa991615c, Offset: 0x4b60
// Size: 0x7e
function incrementequipmentslotammo( slot, incrementamount, class )
{
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( !isdefined( incrementamount ) )
    {
        incrementamount = 1;
    }
    
    currammo = getequipmentammo( ref );
    newammo = int( min( currammo + incrementamount, getequipmentmaxammo( ref, class ) ) );
    setequipmentammo( ref, newammo );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x9be1109f, Offset: 0x4be6
// Size: 0x74
function decrementequipmentslotammo( slot, decrementamount )
{
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( !isdefined( decrementamount ) )
    {
        decrementamount = 1;
    }
    
    currammo = getequipmentammo( ref );
    newammo = int( min( currammo - decrementamount, getequipmentmaxammo( ref ) ) );
    setequipmentammo( ref, newammo );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x3d89956, Offset: 0x4c62
// Size: 0x30
function getequipmentslotammo( slot )
{
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    return getequipmentammo( ref );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x9fe5ab02, Offset: 0x4c9b
// Size: 0x3a
function setequipmentslotammo( slot, count )
{
    ref = getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    return setequipmentammo( ref, count );
}

// Namespace equipment_mp
// Params 0
// Checksum 0x55140a44, Offset: 0x4cde
// Size: 0x7c, Type: bool
function function_c52f2f379f6712c9()
{
    gaveprimary = 0;
    primary = getcurrentequipment( "primary" );
    
    if ( isdefined( primary ) )
    {
        gaveprimary = incrementequipmentammo( primary, getequipmentmaxammo( primary ) );
    }
    
    gavesecondary = 0;
    secondary = getcurrentequipment( "secondary" );
    
    if ( isdefined( secondary ) )
    {
        gavesecondary = incrementequipmentammo( secondary, getequipmentmaxammo( secondary ) );
    }
    
    return gaveprimary || gavesecondary;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x817642d6, Offset: 0x4d63
// Size: 0x86
function function_fdc4a655fbde0dec( weaponname )
{
    if ( !isxhashasset( weaponname ) )
    {
        if ( !isdefined( weaponname ) )
        {
            return;
        }
        
        weaponname = getxhashasset( weaponname );
    }
    
    var_7237854e3be197ca = level.var_1de668bdb367b433[ weaponname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( level.var_47dc93bc4166ba18 )
    {
        var_7781459233518d3c = level.var_575bb73e456c1dea[ weaponname ].bundle.var_6bda5cfddf2527bd;
        
        if ( isdefined( var_7781459233518d3c ) )
        {
            return var_7781459233518d3c;
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xe12525e1, Offset: 0x4df1
// Size: 0x37
function chargeequipment( ref )
{
    switch ( ref )
    {
        case #"hash_4b4a6458f00d9319":
            return hb_sensor_equipment::function_46167b682270b34e();
        default:
            return 0;
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0xc9840ab9, Offset: 0x4e30
// Size: 0x48
function private mapequipmentweaponforref( objweapon )
{
    weaponname = level.equipment.weaponmapping[ objweapon.basename ];
    
    if ( isdefined( weaponname ) )
    {
        return weapon_utility::function_d2c8356dc369d9ce( weaponname );
    }
    
    return objweapon;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x911d5b75, Offset: 0x4e81
// Size: 0x41
function getequipmentreffromweapon( objweapon )
{
    if ( level.equipment.weaponmapping )
    {
        objweapon = mapequipmentweaponforref( objweapon );
    }
    
    return level.var_1de668bdb367b433[ objweapon.basenamehash ];
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf94c1cec, Offset: 0x4ecb
// Size: 0x186
function getEquipmentBundleFromWeaponName( weaponname )
{
    if ( !isxhashasset( weaponname ) )
    {
        if ( !isdefined( weaponname ) )
        {
            return;
        }
        
        weaponname = getxhashasset( weaponname );
    }
    
    if ( level.var_edb2e9d1f3ac4561[ weaponname ] )
    {
        return;
    }
    
    var_7237854e3be197ca = level.var_2ac9728ad68d060d[ weaponname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_2ac9728ad68d060d ) )
    {
        level.var_2ac9728ad68d060d = [];
    }
    
    foreach ( tableinfo in level.equipment.table )
    {
        if ( weaponname == tableinfo.objweapon.basenamehash )
        {
            level.var_2ac9728ad68d060d[ weaponname ] = tableinfo.bundle;
            return tableinfo.bundle;
        }
        
        if ( weaponname == tableinfo.cricketweaponname )
        {
            level.var_2ac9728ad68d060d[ weaponname ] = tableinfo.bundle;
            return tableinfo.bundle;
        }
    }
    
    if ( !isdefined( level.var_edb2e9d1f3ac4561 ) )
    {
        level.var_edb2e9d1f3ac4561 = [];
    }
    
    level.var_edb2e9d1f3ac4561[ weaponname ] = 1;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xee1bfd7, Offset: 0x505a
// Size: 0x50
function function_c90a9aa89b223dd7( equipref )
{
    if ( !isdefined( equipref ) )
    {
        return;
    }
    
    if ( !isdefined( level.equipment.table[ equipref ] ) )
    {
        return;
    }
    
    return level.equipment.table[ equipref ].bundle;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x947fb418, Offset: 0x50b3
// Size: 0x40
function getweaponfromequipmentref( equipref )
{
    equip = level.equipment.table[ equipref ];
    
    if ( isdefined( equip ) )
    {
        return equip.objweapon;
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf5813eee, Offset: 0x50fc
// Size: 0x97, Type: bool
function hasequipment( ref )
{
    if ( !isdefined( self.equipment ) )
    {
        return false;
    }
    
    foreach ( equippedref in self.equipment )
    {
        if ( equippedref == ref )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x67b197b8, Offset: 0x519c
// Size: 0x95
function findequipmentslot( ref )
{
    if ( !isdefined( self.equipment ) )
    {
        return;
    }
    
    foreach ( slot, equippedref in self.equipment )
    {
        if ( equippedref == ref )
        {
            return slot;
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x2cf023fc, Offset: 0x5239
// Size: 0x1a
function function_65ff545a795c7f55( weaponobj )
{
    return isequipment( getequipmentreffromweapon( weaponobj ) );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x57db3c56, Offset: 0x525c
// Size: 0x23, Type: bool
function isequipment( ref )
{
    return isdefined( level.equipment.table[ ref ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x4e89d5ff, Offset: 0x5288
// Size: 0x14
function isequipmentlethal( ref )
{
    return isequipmentprimary( ref );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xbe16a7f5, Offset: 0x52a5
// Size: 0x70, Type: bool
function isequipmentprimary( ref )
{
    if ( ref == "none" )
    {
        return true;
    }
    
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        if ( level.equipment.table[ ref ].defaultslot == "primary" )
        {
            return true;
        }
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        return true;
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x50abaf2d, Offset: 0x531e
// Size: 0x14
function isequipmenttactical( ref )
{
    return isequipmentsecondary( ref );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x3e3529e6, Offset: 0x533b
// Size: 0x70, Type: bool
function isequipmentsecondary( ref )
{
    if ( ref == "none" )
    {
        return true;
    }
    
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        if ( level.equipment.table[ ref ].defaultslot == "secondary" )
        {
            return true;
        }
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        return true;
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x880d7e2a, Offset: 0x53b4
// Size: 0x8c, Type: bool
function function_700ea1d803c019b8( ref )
{
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        if ( level.equipment.table[ ref ].defaultslot == "tertiary" || level.equipment.table[ ref ].defaultslot == "super" )
        {
            return true;
        }
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        return true;
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x127f9a1b, Offset: 0x5449
// Size: 0x4d
function isequipmentselectable( ref )
{
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        return istrue( level.equipment.table[ ref ].isselectable );
    }
    
    return 0;
}

// Namespace equipment_mp
// Params 0
// Checksum 0x7d543302, Offset: 0x549e
// Size: 0x53
function function_45c3c3f7df352e9f()
{
    var_4c48fad50fa1fc28 = [];
    var_7db8d6a4056c13dc = refillequipment( "primary" );
    
    if ( var_7db8d6a4056c13dc )
    {
        var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = var_7db8d6a4056c13dc;
    }
    
    var_446603dff0e3bd8c = refillequipment( "secondary" );
    
    if ( var_446603dff0e3bd8c )
    {
        var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = var_446603dff0e3bd8c;
    }
    
    return var_4c48fad50fa1fc28;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xd6a2652, Offset: 0x54fa
// Size: 0x54
function function_7f4fec85a827d0c5( equipmentref )
{
    if ( !equipmentref )
    {
        return 1;
    }
    
    switch ( equipmentref )
    {
        case #"hash_2fd6e4e58e79a638":
        case #"hash_7a24b50365517bba":
        case #"hash_d520713a70b60a2e":
            return 0;
        default:
            return 1;
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0x4ac92182, Offset: 0x5556
// Size: 0xf9
function private refillequipment( slot )
{
    var_d1f84487d38a5d5b = 0;
    
    if ( isusingmatchrulesdata() )
    {
        var_d1f84487d38a5d5b = getdvarint( @"ammorestockmaxequipment", getmatchrulesdata( "commonOption", "ammoRestockMaxEquipment" ) );
    }
    
    equipment = getcurrentequipment( slot );
    
    if ( !equipment || !function_7f4fec85a827d0c5( equipment ) )
    {
        return;
    }
    
    var_f6d1f05c41cc8aeb = getequipmentammo( equipment );
    var_f0a78fa090433bda = getequipmentmaxammo( equipment, self.class );
    
    if ( var_f6d1f05c41cc8aeb >= var_f0a78fa090433bda )
    {
        return;
    }
    
    if ( var_d1f84487d38a5d5b )
    {
        setequipmentslotammo( slot, var_f0a78fa090433bda );
    }
    else
    {
        incrementequipmentammo( equipment );
    }
    
    addammo = getequipmentammo( equipment ) - var_f6d1f05c41cc8aeb;
    
    if ( addammo > 0 )
    {
        fakepickup = {};
        fakepickup.count = addammo;
        fakepickup.ref = equipment;
        return fakepickup;
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0xa4fbaed, Offset: 0x5657
// Size: 0xbd, Type: bool
function function_1ea7282f498205a0()
{
    foreach ( equipobj in self.equipment )
    {
        tableinfo = getequipmenttableinfo( equipobj );
        
        if ( !isdefined( tableinfo ) )
        {
            continue;
        }
        
        var_72aba7d4272c25ae = getequipmentmaxammo( equipobj );
        var_e6c9ee5a655526f3 = getequipmentammo( equipobj );
        
        if ( var_72aba7d4272c25ae != var_e6c9ee5a655526f3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace equipment_mp
// Params 3
// Checksum 0x19af4110, Offset: 0x571d
// Size: 0x190
function updateammocount( slot, class, maxammo )
{
    if ( !( isdefined( self.equipment ) && isdefined( slot ) ) )
    {
        return;
    }
    
    ref = getcurrentequipment( slot );
    
    if ( isdefined( ref ) )
    {
        ammo = getequipmentslotammo( slot );
        
        if ( !isdefined( maxammo ) )
        {
            maxammo = getequipmentmaxammo( ref, class );
        }
        
        assert( maxammo == getequipmentmaxammo( ref, class ), "<dev string:x3a8>" + ref );
    }
    else
    {
        ammo = 0;
        maxammo = 0;
    }
    
    if ( slot == "primary" )
    {
        self setclientomnvar( "ui_power_num_charges", ammo );
        
        if ( self function_5c766d1d0140b86( "ui_power_max_charges" ) )
        {
            self setclientomnvar( "ui_power_max_charges", maxammo );
        }
        
        self setpowerammo( "primary", ammo, maxammo );
        return;
    }
    
    if ( slot == "secondary" )
    {
        self setclientomnvar( "ui_power_secondary_num_charges", ammo );
        
        if ( self function_5c766d1d0140b86( "ui_power_secondary_max_charges" ) )
        {
            self setclientomnvar( "ui_power_secondary_max_charges", maxammo );
        }
        
        self setpowerammo( "secondary", ammo, maxammo );
        return;
    }
    
    if ( slot == "health" )
    {
        if ( isdefined( self.pers[ "telemetry" ].armor_collected ) )
        {
            self.pers[ "telemetry" ].armor_collected++;
        }
        
        self setclientomnvar( "ui_equipment_id_health_numCharges", ammo );
        
        if ( isbrgamemode() )
        {
            var_22a509995e00c122 = armor::function_d3aa416001bf116c();
            br_public::updatebrscoreboardstat( "armorPlateCount", ammo + var_22a509995e00c122 );
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x53dc038a, Offset: 0x58b5
// Size: 0x13
function equiponplayerspawned( params )
{
    thread watchoffhandfired();
}

// Namespace equipment_mp
// Params 0
// Checksum 0x97ca355c, Offset: 0x58d0
// Size: 0x16
function resetequipment()
{
    self.equipment = [];
    self.var_e6d8cfcc28a79324 = [];
}

// Namespace equipment_mp
// Params 1
// Checksum 0x92f246f3, Offset: 0x58ee
// Size: 0x31
function function_2e4e9b7492b36578( weaponref )
{
    if ( !isdefined( level.var_215ee8ce2790fa7a ) )
    {
        level.var_215ee8ce2790fa7a = [];
    }
    
    level.var_215ee8ce2790fa7a[ weaponref ] = 1;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xd5fdc186, Offset: 0x5927
// Size: 0x19, Type: bool
function function_e4d1f5399e3d9e7a( weaponref )
{
    return isdefined( level.var_215ee8ce2790fa7a[ weaponref ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x259bc3e5, Offset: 0x5949
// Size: 0x547
function executeoffhandfired( objweapon )
{
    foreach ( slot, ref in self.equipment )
    {
        tableinfo = getequipmenttableinfo( ref );
        
        if ( objweapon.basename && tableinfo.objweapon.basename && objweapon.basename == tableinfo.objweapon.basename )
        {
            if ( isbrgamemode() )
            {
                item_type = "";
                
                if ( isdefined( tableinfo.bundle ) && isdefined( tableinfo.bundle.equipmenttype ) )
                {
                    item_type = tableinfo.bundle.equipmenttype;
                }
                
                br_analytics::branalytics_equipmentuse( self, objweapon, item_type );
            }
            
            if ( level.var_b7e70fa484e134dc && slot == "secondary" && tableinfo.bundle.issuper && self.tacticalsuper )
            {
                var_77278bb457af652a = supers_mp::beginsuperuse( #"tactical" );
                
                if ( !var_77278bb457af652a )
                {
                    if ( getdvarint( @"hash_c8b6c4e40dcae41e", 1 ) == 1 )
                    {
                        currentsuper = supers_mp::getcurrentsuper( #"tactical" );
                        
                        if ( isdefined( currentsuper ) && isdefined( currentsuper.staticdata ) && isdefined( currentsuper.weaponobj ) && isdefined( objweapon ) && objweapon.basename == currentsuper.weaponobj.basename )
                        {
                            supers_mp::refundsuper( #"tactical" );
                        }
                        
                        return;
                    }
                    
                    supers_mp::refundsuper( #"tactical" );
                    return;
                }
                
                updateammocount( slot );
                return;
            }
            
            weaponref = getequipmentreffromweapon( objweapon );
            assert( isdefined( weaponref ), "<dev string:x3d9>" + ( isdefined( objweapon ) && isdefined( objweapon.basename ) ? objweapon.basename : undefined ) );
            battlechatter_mp::onequipmentuse( { #weapon_name:objweapon.basename } );
            
            if ( !function_e4d1f5399e3d9e7a( weaponref ) )
            {
                damage::combatrecordequipmentused( weaponref );
            }
            
            onfiredcallback = getcallback( ref, "onFired" );
            
            if ( isdefined( onfiredcallback ) )
            {
                self thread [[ onfiredcallback ]]( ref, slot, objweapon );
            }
            
            callback::callback( #"equipment_use", { #ref:ref, #slot:slot, #weapon_object:objweapon, #player:self } );
            
            if ( isdefined( self.team ) )
            {
                level notify( "equipment_used_" + self.team, weaponref );
            }
            
            ammo = 0;
            ref = getcurrentequipment( slot );
            
            if ( isdefined( ref ) )
            {
                ammo = getequipmentslotammo( slot );
            }
            
            if ( ammo == 0 && isdefined( level.var_6b152f29f8944b74 ) )
            {
                success = self [[ level.var_6b152f29f8944b74 ]]( self, slot, ref );
                
                if ( success )
                {
                    break;
                }
            }
            
            updateammocount( slot );
            callback::callback( #"equipment_use_success", { #tableinfo:tableinfo, #ref:ref, #slot:slot, #weapon_object:objweapon, #player:self } );
            
            if ( isbrgamemode() && br_default_inventory::isbackpackinventoryenabled() && !getdvarint( @"hash_ced962345ff6ecd0", 0 ) && !br_default_inventory::function_1923cc02d05e07c5( ref ) )
            {
                scriptablename = level.br_pickups.br_equipnametoscriptable[ ref ];
                
                if ( br_public::function_c6c1721a0ec2bf0( scriptablename ) && !br_public::function_2a6e320ec6ac64d1( scriptablename ) )
                {
                    br_default_inventory::removesmallestitemstackbackpack( scriptablename, 1 );
                    incrementequipmentammo( ref, 1 );
                }
            }
            
            persstr = "tacticalsUsed";
            
            if ( isequipmentlethal( weaponref ) )
            {
                persstr = "lethalsUsed";
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ persstr ] ) )
                {
                    self.leaderboarddata[ persstr ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ persstr ] ) )
                {
                    [[ level.leaderboardfunc[ persstr ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x3f7>" );
                
                if ( isdefined( self.pers[ persstr ] ) )
                {
                    self.pers[ persstr ] += 1;
                }
            }
            
            break;
        }
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0xf916970a, Offset: 0x5e98
// Size: 0x5c
function watchoffhandfired()
{
    self notify( #"hash_8154b049436a8e7c" );
    self endon( #"hash_8154b049436a8e7c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"offhand_fired", objweapon );
        executeoffhandfired( objweapon );
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0xaae4c027, Offset: 0x5efc
// Size: 0x40
function getdefaultslot( ref )
{
    if ( !function_ae4237ff60a6e452( ref ) )
    {
        return;
    }
    
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    return tableinfo.defaultslot;
}

// Namespace equipment_mp
// Params 0
// Checksum 0xd4d544, Offset: 0x5f45
// Size: 0x108
function watchlethaldelay()
{
    level endon( #"lethal_delay_end" );
    level endon( #"round_end" );
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    currentgametypestopsclock = currentgametypestopsclock();
    
    if ( currentgametypestopsclock )
    {
        level.lethaldelaystarttime = gettime();
    }
    else
    {
        level.lethaldelaystarttime = game_utility::gettimepassed();
    }
    
    if ( level.lethaldelay == 0 )
    {
        level.lethaldelayendtime = level.lethaldelaystarttime;
        level notify( #"lethal_delay_end" );
    }
    
    level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
    level notify( #"lethal_delay_start" );
    
    while ( true )
    {
        currenttime = undefined;
        
        if ( currentgametypestopsclock )
        {
            currenttime = gettime();
        }
        else
        {
            currenttime = game_utility::gettimepassed();
        }
        
        if ( currenttime >= level.lethaldelayendtime )
        {
            break;
        }
        
        waitframe();
    }
    
    level notify( #"lethal_delay_end" );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x1a8a460f, Offset: 0x6055
// Size: 0x132
function watchlethaldelayplayer( equipmentref, slot )
{
    self endon( #"death_or_disconnect" );
    level endon( #"round_end" );
    level endon( #"game_ended" );
    
    if ( lethaldelaypassed() )
    {
        return;
    }
    
    self notify( "watchLethalDelayPlayer_" + slot );
    self endon( "watchLethalDelayPlayer_" + slot );
    self endon( "equipment_taken_" + equipmentref );
    
    if ( !isdefined( self.lethaldelayallows ) || !self.lethaldelayallows[ slot ] )
    {
        if ( !isdefined( self.lethaldelayallows ) )
        {
            self.lethaldelayallows = [];
        }
        
        self.lethaldelayallows[ slot ] = 1;
        
        if ( slot == "primary" )
        {
            val::set( "watchLethalDelayPlayer", "equipment_primary", 0 );
        }
        else
        {
            val::set( "watchLethalDelayPlayer", "equipment_secondary", 0 );
        }
    }
    
    watchlethaldelayfeedbackplayer( self, slot );
    
    if ( isdefined( self.lethaldelayallows ) && self.lethaldelayallows[ slot ] )
    {
        self.lethaldelayallows[ slot ] = undefined;
        
        if ( self.lethaldelayallows.size == 0 )
        {
            self.lethaldelayallows = undefined;
        }
        
        val::reset_all( "watchLethalDelayPlayer" );
    }
}

// Namespace equipment_mp
// Params 2
// Checksum 0x179cc644, Offset: 0x618f
// Size: 0xff
function watchlethaldelayfeedbackplayer( player, slot )
{
    level endon( #"lethal_delay_end" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"lethal_delay_start" );
    }
    
    command = "+frag";
    
    if ( slot != "primary" )
    {
        command = "+smoke";
    }
    
    if ( !isai( player ) )
    {
        player notifyonplayercommand( "lethal_attempt_" + slot, command );
    }
    
    currentgametypestopsclock = currentgametypestopsclock();
    
    while ( true )
    {
        self waittill( "lethal_attempt_" + slot );
        currenttime = undefined;
        
        if ( currentgametypestopsclock )
        {
            currenttime = gettime();
        }
        else
        {
            currenttime = game_utility::gettimepassed();
        }
        
        n = ( level.lethaldelayendtime - currenttime ) / 1000;
        n = int( max( 0, ceil( n ) ) );
        player hud_message::showerrormessage( %"mp/lethals_unavailable_for_n", n );
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0xcd9ad5f, Offset: 0x6296
// Size: 0x52
function cancellethaldelay()
{
    level.lethaldelay = 0;
    
    if ( currentgametypestopsclock() )
    {
        level.lethaldelaystarttime = gettime();
    }
    else
    {
        level.lethaldelaystarttime = game_utility::gettimepassed();
    }
    
    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify( #"lethal_delay_end" );
}

// Namespace equipment_mp
// Params 0
// Checksum 0x29c041b5, Offset: 0x62f0
// Size: 0x55, Type: bool
function lethaldelaypassed()
{
    if ( level.lethaldelay == 0 )
    {
        return true;
    }
    
    if ( isdefined( level.lethaldelayendtime ) )
    {
        currenttime = undefined;
        
        if ( currentgametypestopsclock() )
        {
            currenttime = gettime();
        }
        else
        {
            currenttime = game_utility::gettimepassed();
        }
        
        return ( currenttime > level.lethaldelayendtime );
    }
    
    return false;
}

// Namespace equipment_mp
// Params 0
// Checksum 0x5c234406, Offset: 0x634e
// Size: 0x3b, Type: bool
function currentgametypestopsclock()
{
    gametype = game_utility::getgametype();
    
    if ( gametype == "hq" || gametype == "grnd" || gametype == "koth" )
    {
        return true;
    }
    
    return false;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x7167b1b6, Offset: 0x6392
// Size: 0x94
function onownerdisconnect( player )
{
    allequip = player weapons::getallequip();
    
    foreach ( equip in allequip )
    {
        equip notify( #"owner_disconnect" );
    }
}

// Namespace equipment_mp
// Params 2
// Checksum 0x9b443ec5, Offset: 0x642e
// Size: 0xd3
function hackequipment( hacker, var_7f2e62e5ec3ea0df )
{
    self.ishacked = 1;
    newowner = hacker;
    
    if ( isdefined( hacker.owner ) && hacker.equipmentref == "equip_capture_bot" )
    {
        newowner = hacker.owner;
    }
    
    newowner gamelogic_mp::sethasdonecombat( newowner, 1 );
    hacker challenges::function_8e891c96efe9f293( self.equipmentref );
    
    if ( isent( self ) )
    {
        changeowner( newowner );
        
        if ( level.teambased )
        {
            self filteroutplayermarks( newowner.team );
        }
        else
        {
            self filteroutplayermarks( newowner );
        }
    }
    
    if ( !var_7f2e62e5ec3ea0df )
    {
        newowner killstreaks::givescoreforhack();
    }
    
    self notify( #"hack_successful", hacker );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x69e4c3dc, Offset: 0x6509
// Size: 0x43
function setupmarks( grenade )
{
    grenade enableplayermarks( #"equipment" );
    
    if ( level.teambased )
    {
        grenade filteroutplayermarks( self.team );
        return;
    }
    
    grenade filteroutplayermarks( self );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf88d52b4, Offset: 0x6554
// Size: 0x3f
function function_c562b7d10b04136a( capturebot )
{
    if ( isdefined( capturebot ) )
    {
        if ( !isdefined( self.var_8ea7d6eab48f122b ) )
        {
            self.var_8ea7d6eab48f122b = [];
        }
        
        self.var_8ea7d6eab48f122b[ self.var_8ea7d6eab48f122b.size ] = capturebot;
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x4825683b, Offset: 0x659b
// Size: 0x94, Type: bool
function function_15ea6ab148e09e8d( var_56f8ff373e20faf1 )
{
    if ( isdefined( self.var_8ea7d6eab48f122b ) )
    {
        foreach ( oldbot in self.var_8ea7d6eab48f122b )
        {
            if ( oldbot == var_56f8ff373e20faf1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xe2ab43fa, Offset: 0x6638
// Size: 0xfa
function changeowner( newowner )
{
    oldowner = self.owner;
    
    if ( !vehicle::is_vehicle() )
    {
        self setentityowner( newowner );
    }
    
    self.owner = newowner;
    oldteam = self.team;
    newteam = newowner.team;
    
    if ( oldteam != newteam )
    {
        if ( !weapon::minechangeteam( oldteam, newteam ) )
        {
            self.team = newteam;
        }
    }
    
    self setotherent( newowner );
    oldowner weapons::removeequip( self );
    self.owner weapons::updateplantedarray( self );
    onownerchanged = getcallback( self.equipmentref, "onOwnerChanged" );
    self notify( #"ownerChanged" );
    
    if ( isdefined( onownerchanged ) )
    {
        self [[ onownerchanged ]]( oldowner );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", self );
}

// Namespace equipment_mp
// Params 3
// Checksum 0x8bb42a31, Offset: 0x673a
// Size: 0xcd
function function_f3104335c7fe8d43( tableinfo, variantid, attachments )
{
    weapon = undefined;
    weaponname = tableinfo.weaponname;
    
    if ( isdefined( self.perks[ "specialty_cricket" ] ) )
    {
        if ( isdefined( tableinfo.cricketweaponname ) )
        {
            weaponname = tableinfo.cricketweaponname;
        }
    }
    
    if ( variantid > 0 || attachments.size > 0 )
    {
        weapon = buildequipment( weaponname, variantid, attachments );
    }
    else
    {
        weapon = tableinfo.objweapon;
        
        if ( isdefined( self.perks[ "specialty_cricket" ] ) && isdefined( tableinfo.var_f8ab75cc76c4430a ) )
        {
            weapon = tableinfo.var_f8ab75cc76c4430a;
        }
    }
    
    return weapon;
}

// Namespace equipment_mp
// Params 0
// Checksum 0xbbdd3d59, Offset: 0x6810
// Size: 0x84
function function_ea51ae6c8436d3cd()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    stuckdata = spawnstruct();
    childthread function_a6d3e652b9c9f89c( stuckdata );
    childthread function_efd7fb0edc3f4f6d( stuckdata );
    self waittill( #"missile_impact", hitent, pos );
    
    if ( !isdefined( stuckdata.stuckto ) && isdefined( hitent ) )
    {
        stuckdata.stuckto = hitent;
    }
    
    return stuckdata;
}

// Namespace equipment_mp
// Params 1
// Checksum 0xff3dec90, Offset: 0x689d
// Size: 0x51
function function_a6d3e652b9c9f89c( stuckdata )
{
    self endon( #"missile_impact" );
    self waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) )
    {
        stuckdata.stuckto = stuckto;
    }
    
    self notify( #"missile_impact" );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xe4cba2f5, Offset: 0x68f6
// Size: 0x3f
function function_efd7fb0edc3f4f6d( stuckdata )
{
    self endon( #"missile_impact" );
    self waittill( #"missile_water_impact" );
    stuckdata.isunderwater = 1;
    self notify( #"missile_impact" );
}

// Namespace equipment_mp
// Params 3
// Checksum 0x1b0e9990, Offset: 0x693d
// Size: 0xa3
function function_2c8f51009c3dd68f( stuckto, destroyfunc, isimmediate )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"disconnect" );
    }
    
    if ( isagent( stuckto ) )
    {
        return;
    }
    
    msg = stuckto utility::waittill_any_return( "death", "destroy" );
    
    if ( isdefined( stuckto ) && stuckto.code_classname == "scriptable" )
    {
        return;
    }
    
    self thread [[ destroyfunc ]]( isimmediate );
}

/#

    // Namespace equipment_mp
    // Params 0
    // Checksum 0x3e8a1b44, Offset: 0x69e8
    // Size: 0xe6, Type: dev
    function function_5bbba416d98f9fb7()
    {
        var_e8b1252fd67d8014 = undefined;
        var_109cc77146f9c72 = undefined;
        
        while ( getdvarint( @"hash_9230085e2e226a12" ) != 0 )
        {
            mainplayer = level.players[ 0 ];
            
            if ( isdefined( mainplayer ) )
            {
                lethal = mainplayer getcurrentequipment( "<dev string:x41d>" );
                
                if ( isdefined( lethal ) )
                {
                    if ( var_109cc77146f9c72 != lethal )
                    {
                        weapon = mainplayer getweaponfromequipmentref( lethal );
                        var_109cc77146f9c72 = lethal;
                        iprintlnbold( "<dev string:x425>" + getcompleteweaponname( weapon ) );
                    }
                }
                
                wait 3;
                tactical = mainplayer getcurrentequipment( "<dev string:x438>" );
                
                if ( isdefined( tactical ) )
                {
                    if ( var_e8b1252fd67d8014 != tactical )
                    {
                        weapon = mainplayer getweaponfromequipmentref( tactical );
                        var_e8b1252fd67d8014 = tactical;
                        iprintlnbold( "<dev string:x442>" + getcompleteweaponname( weapon ) );
                    }
                }
                
                wait 3;
            }
            
            wait 3;
        }
    }

    // Namespace equipment_mp
    // Params 0
    // Checksum 0x1d74d3b6, Offset: 0x6ad6
    // Size: 0x106, Type: dev
    function debughackequipment()
    {
        setdevdvar( @"scr_debughackequipment", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debughackequipment" ) != 0 )
            {
                setdevdvar( @"scr_debughackequipment", 0 );
                mainplayer = level.players[ 0 ];
                enemyplayer = undefined;
                
                for ( i = 1; i < level.players.size ; i++ )
                {
                    if ( mainplayer player_utility::isenemy( level.players[ i ] ) )
                    {
                        enemyplayer = level.players[ i ];
                        break;
                    }
                }
                
                if ( !isdefined( enemyplayer ) )
                {
                    iprintlnbold( "<dev string:x457>" );
                    continue;
                }
                
                allequip = mainplayer weapons::getallequip();
                equipment = undefined;
                
                if ( allequip.size > 0 )
                {
                    equipment = allequip[ 0 ];
                }
                
                if ( !isdefined( equipment ) )
                {
                    iprintlnbold( "<dev string:x491>" );
                    continue;
                }
                
                equipment hackequipment( enemyplayer );
            }
            
            waitframe();
        }
    }

    // Namespace equipment_mp
    // Params 0
    // Checksum 0x892a76a1, Offset: 0x6be4
    // Size: 0xa1, Type: dev
    function debugemp()
    {
        setdevdvar( @"scr_testempgrenade", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_testempgrenade" ) != 0 )
            {
                setdevdvar( @"scr_testempgrenade", 0 );
                
                if ( level.players.size < 2 )
                {
                    iprintlnbold( "<dev string:x4e2>" );
                    continue;
                }
                
                secondplayer = level.players[ 1 ];
                secondplayer weapon::_launchgrenade( "<dev string:x512>", ( 0, 0, 0 ), ( 0, 0, 0 ), 0.05, 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace equipment_mp
// Params 0
// Checksum 0xde1fd357, Offset: 0x6c8d
// Size: 0xeb
function initlethalmaxoffsetmap()
{
    level.lethal_equipmentmaskoffsets = [];
    bitindex = 0;
    
    foreach ( equipment in level.equipment.table )
    {
        if ( !equipment.isselectable )
        {
            continue;
        }
        
        if ( equipment.id <= 0 )
        {
            continue;
        }
        
        if ( equipment.defaultslot == "secondary" )
        {
            continue;
        }
        
        level.lethal_equipmentmaskoffsets[ equipment.ref ] = 1 << bitindex;
        bitindex++;
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x4ec5fbc5, Offset: 0x6d80
// Size: 0x144
function function_16ba989c77e0f2bc( var_495263507ee356c0 )
{
    /#
        if ( isbot( self ) )
        {
            equipweaponname = level.equipment.table[ var_495263507ee356c0 ].weaponname;
            
            if ( equipweaponname )
            {
                equipweapon = makeweapon( equipweaponname );
                return function_97483661b0d7f039( equipweapon );
            }
        }
    #/
    
    if ( isarray( self.equipment ) )
    {
        foreach ( slot, equipment in self.equipment )
        {
            if ( var_495263507ee356c0 == equipment )
            {
                attachments = function_65267b7e18646851( slot ).attachments;
                
                if ( isarray( attachments ) )
                {
                    return attachments;
                }
            }
        }
    }
    
    if ( self.loadoutequipmentprimary == var_495263507ee356c0 )
    {
        return self.loadoutEquipmentPrimaryAttachments;
    }
    else if ( self.loadoutequipmentsecondary == var_495263507ee356c0 )
    {
        return self.loadoutEquipmentSecondaryAttachments;
    }
    
    return [];
}

// Namespace equipment_mp
// Params 2
// Checksum 0xc6635cca, Offset: 0x6ecd
// Size: 0x7f, Type: bool
function function_e6b75548c2c3c6cf( var_495263507ee356c0, attachmentname )
{
    attachments = function_16ba989c77e0f2bc( var_495263507ee356c0 ) ?? [];
    var_af04b6fb987d0b = isxhashasset( attachmentname );
    
    for ( i = 0; i < attachments.size ; i++ )
    {
        var_763bd961b8332362 = var_af04b6fb987d0b ? getxhashasset( attachments[ i ] ) : attachments[ i ];
        
        if ( attachmentname == var_763bd961b8332362 )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace equipment_mp
    // Params 1
    // Checksum 0x9305b8a, Offset: 0x6f55
    // Size: 0xbd, Type: dev
    function function_97483661b0d7f039( var_128567545a5fba8f )
    {
        result = [];
        
        if ( !isdefined( self.var_f5392f9fde9169f3 ) )
        {
            self.var_f5392f9fde9169f3 = [];
        }
        
        foreach ( attachment in self.var_f5392f9fde9169f3 )
        {
            if ( var_128567545a5fba8f && function_5b465daf157fa9a1( var_128567545a5fba8f, attachment ) != -1 )
            {
                result[ result.size ] = attachment;
            }
        }
        
        return result;
    }

#/

// Namespace equipment_mp
// Params 4
// Checksum 0x85b3f58a, Offset: 0x701a
// Size: 0x78, Type: bool
function function_84f2f5566ba29655( ent, delay, triggerradius, var_63a882ef5d5468a3 )
{
    if ( !isdefined( self.var_5a78c19ea6567a04 ) )
    {
        self.var_5a78c19ea6567a04 = [];
    }
    
    if ( function_d84c6f0cac9c8a7( ent ) )
    {
        return true;
    }
    
    if ( !function_543aba88a2550fe7( ent ) )
    {
        if ( var_63a882ef5d5468a3 )
        {
            self thread [[ var_63a882ef5d5468a3 ]]( ent, delay, triggerradius );
        }
        else
        {
            thread function_d0b38c8fb403ca5e( ent, delay, triggerradius );
        }
        
        return true;
    }
    
    return false;
}

// Namespace equipment_mp
// Params 3, eflags: 0x4
// Checksum 0x67ec8144, Offset: 0x709b
// Size: 0x90
function private function_d0b38c8fb403ca5e( ent, delay, triggerradius )
{
    self endon( #"death" );
    starttime = gettime();
    function_d1d291c51aa6d760( ent );
    
    while ( gettime() - starttime < delay * 1000 )
    {
        wait 0.1;
        
        if ( distance2dsquared( self.origin, ent.origin ) > triggerradius * triggerradius )
        {
            function_1a58b9ed0d786c51( ent );
            return;
        }
    }
    
    function_40ac4616989324cf( ent );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x26b5fa19, Offset: 0x7133
// Size: 0x2d
function function_d1d291c51aa6d760( ent )
{
    entnum = ent getentitynumber();
    self.var_5a78c19ea6567a04[ entnum ] = 1;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x3c0a826a, Offset: 0x7168
// Size: 0x2c
function function_40ac4616989324cf( ent )
{
    entnum = ent getentitynumber();
    self.var_5a78c19ea6567a04[ entnum ] = 0;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x53598c69, Offset: 0x719c
// Size: 0x2a
function function_1a58b9ed0d786c51( ent )
{
    entnum = ent getentitynumber();
    self.var_5a78c19ea6567a04[ entnum ] = undefined;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x38457866, Offset: 0x71ce
// Size: 0x2b, Type: bool
function function_543aba88a2550fe7( ent )
{
    entnum = ent getentitynumber();
    return isdefined( self.var_5a78c19ea6567a04[ entnum ] );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xbfaeb806, Offset: 0x7202
// Size: 0x2a
function function_d84c6f0cac9c8a7( ent )
{
    entnum = ent getentitynumber();
    return self.var_5a78c19ea6567a04[ entnum ];
}

// Namespace equipment_mp
// Params 11, eflags: 0x4
// Checksum 0x47f1d7f4, Offset: 0x7235
// Size: 0x202
function private function_a3a5d39074d58e08( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, partname, unmodifieddamage )
{
    if ( !einflictor.bundle.var_d76b57d1a85984cb || !einflictor.equipmentref )
    {
        return idamage;
    }
    
    grenadebundle = einflictor.bundle;
    
    if ( damage_utility::function_5d1c04cbc4da6bc4( partname ) && grenadebundle.var_ab05992ffbfebe26 )
    {
        idamage = int( grenadebundle.var_4f0c2e596e73394e * ( grenadebundle.var_39d9650fbbc73c0 ?? 1 ) );
    }
    else if ( damage_utility::function_facff8bb3d8f891b( partname ) && grenadebundle.var_867a0a00fe56c499 )
    {
        idamage = int( grenadebundle.var_4f0c2e596e73394e * ( grenadebundle.var_ed66ef0c8dddfb95 ?? 1 ) );
    }
    else
    {
        idamage = grenadebundle.var_4f0c2e596e73394e ?? 175;
    }
    
    if ( weapon::isthrowingknife( objweapon ) && isdefined( einflictor.bounced ) && einflictor.bounced > 0 && isdefined( victim ) )
    {
        var_c8b82c183cd5d50a = victim.maxhealth + victim.maxarmorhealth;
        
        if ( isdefined( var_c8b82c183cd5d50a ) && idamage >= var_c8b82c183cd5d50a )
        {
            idamage = var_c8b82c183cd5d50a / 100 * grenadebundle.var_ac9622470c7f429a;
        }
    }
    
    if ( grenadebundle.var_284dbe1d7424b36a && player::isinlaststand( victim ) )
    {
        if ( isdefined( victim.maxarmorhealth ) )
        {
            idamage = victim.maxhealth + victim.maxarmorhealth;
        }
        else
        {
            idamage = victim.maxhealth;
        }
    }
    
    return idamage;
}

// Namespace equipment_mp
// Params 0, eflags: 0x4
// Checksum 0x60774ed7, Offset: 0x7440
// Size: 0xa9
function private function_60586aa3d725b77d()
{
    if ( getdvarint( @"hash_82f583ba981b8db2", 0 ) )
    {
        return;
    }
    
    foreach ( struct in level.equipment.table )
    {
        if ( struct.bundle.var_acd9b9a3c6ea7756 )
        {
            return 1;
        }
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0x33fbd2bc, Offset: 0x74f1
// Size: 0xfd
function private function_ff1f3c141c6d39ab( params )
{
    victim = params.victim;
    attacker = params.attacker;
    equipment = params.equipment;
    timestamp = params.timestamp ?? gettime();
    effectref = params.ref ?? equipment;
    duration = params.duration ?? 0;
    
    if ( victim && isplayer( victim ) && equipment )
    {
        if ( !isdefined( victim.var_cd55587d4fa36a6a ) )
        {
            victim.var_cd55587d4fa36a6a = [];
        }
        
        victim.var_cd55587d4fa36a6a[ equipment ] = { #duration:duration, #effectref:effectref, #timestamp:timestamp };
    }
}

// Namespace equipment_mp
// Params 4, eflags: 0x4
// Checksum 0xf34b64e1, Offset: 0x75f6
// Size: 0xde
function private function_739603b78928b236( equipment, victim, attacker, deathtimestamp = gettime() )
{
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    bundle = level.equipment.table[ equipment ].bundle;
    data = victim.var_cd55587d4fa36a6a[ equipment ];
    
    if ( bundle.var_acd9b9a3c6ea7756 && data.timestamp && deathtimestamp )
    {
        validtime = deathtimestamp - data.timestamp < ( bundle.var_acd9b9a3c6ea7756 + data.duration ) * 1000;
        return validtime;
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0xe9d70395, Offset: 0x76dc
// Size: 0x15
function private onplayerlaststand( data )
{
    function_542c65d1812bee51( data );
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0x7e497eac, Offset: 0x76f9
// Size: 0x45
function private onplayerrevived( data )
{
    if ( isdefined( data.victim ) )
    {
        data.victim.var_cd55587d4fa36a6a = undefined;
        data.victim.var_917038143d36327f = undefined;
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0x6b5c8160, Offset: 0x7746
// Size: 0x2e
function private onplayerdeath( data )
{
    if ( !data.victim.inlaststand )
    {
        function_542c65d1812bee51( data );
    }
}

// Namespace equipment_mp
// Params 1, eflags: 0x4
// Checksum 0xe231be86, Offset: 0x777c
// Size: 0x10a
function private function_542c65d1812bee51( data )
{
    if ( !data || !data.victim )
    {
        return;
    }
    
    victim = data.victim;
    attacker = data.attacker;
    victim.var_917038143d36327f = undefined;
    
    if ( victim.var_cd55587d4fa36a6a )
    {
        foreach ( equipref, effectdata in victim.var_cd55587d4fa36a6a )
        {
            if ( function_739603b78928b236( equipref, victim, attacker ) )
            {
                victim.var_917038143d36327f[ effectdata.effectref ] = 1;
            }
        }
        
        victim.var_cd55587d4fa36a6a = undefined;
    }
}

// Namespace equipment_mp
// Params 3
// Checksum 0xd0610679, Offset: 0x788e
// Size: 0x11b
function watchwaterdepth( var_3587b36e49e5df55, extraendon, var_334c443250f2aeac )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"missile_stuck" );
    
    if ( extraendon )
    {
        self endon( extraendon );
    }
    
    var_46cfcd687c2f9dee = var_334c443250f2aeac ?? 20;
    
    if ( utility::ispointinwater( self.origin ) )
    {
        while ( !utility::ispointinwater( self.origin + ( 0, 0, var_46cfcd687c2f9dee ) ) )
        {
            waitframe();
        }
    }
    else
    {
        self waittill( #"missile_water_impact", var_a923b78f4b77f26b, var_68710ac0de0ae982, var_be7ff3c11cc26733 );
        var_f08ad7fba9e6fef9 = var_68710ac0de0ae982[ 2 ] - var_46cfcd687c2f9dee;
        
        while ( self.origin[ 2 ] > var_f08ad7fba9e6fef9 )
        {
            waitframe();
        }
    }
    
    if ( isstring( var_3587b36e49e5df55 ) )
    {
        self notify( var_3587b36e49e5df55 );
        return;
    }
    
    if ( isfunction( var_3587b36e49e5df55 ) )
    {
        self thread [[ var_3587b36e49e5df55 ]]();
        return;
    }
    
    assertmsg( "<dev string:x521>" );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf3a33cde, Offset: 0x79b1
// Size: 0x39, Type: bool
function function_c2a3ca0d571472a3( var_334c443250f2aeac )
{
    return utility::ispointinwater( self.origin ) && utility::ispointinwater( self.origin + ( 0, 0, var_334c443250f2aeac ?? 20 ) );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x3f56a9d9, Offset: 0x79f3
// Size: 0x3d
function function_e1ef466c93191c6( weaponobj, gestureanim )
{
    if ( self hasweapon( weaponobj ) )
    {
        if ( self isgestureplaying( gestureanim ) )
        {
            self stopgestureviewmodel( gestureanim, 0, 1 );
        }
        
        self takeweapon( weaponobj );
        waitframe();
    }
}

// Namespace equipment_mp
// Params 3
// Checksum 0xdca8541e, Offset: 0x7a38
// Size: 0x58
function function_292817f6f6230815( slot, progress, timer )
{
    self setclientomnvar( level.var_73926dc557be15a2[ slot ], progress );
    
    if ( self function_5c766d1d0140b86( level.var_4564ab52a6a00ef5[ slot ] ) )
    {
        self setclientomnvar( level.var_4564ab52a6a00ef5[ slot ], timer );
    }
}

// Namespace equipment_mp
// Params 5
// Checksum 0x8481b375, Offset: 0x7a98
// Size: 0x3e
function function_8d73970836673a75( rechargetime, updateperiod, equipmentref, var_1b224f553374a3a, var_f0d2326fa4a4e4b2 )
{
    thread function_7e1f16e4e3f626c3( rechargetime, updateperiod, equipmentref, var_f0d2326fa4a4e4b2, var_1b224f553374a3a );
}

// Namespace equipment_mp
// Params 5, eflags: 0x4
// Checksum 0x995857df, Offset: 0x7ade
// Size: 0x79
function private function_7e1f16e4e3f626c3( rechargetime, updateperiod, equipmentref, var_f0d2326fa4a4e4b2, var_1b224f553374a3a )
{
    self notify( #"hash_8353713f77d859bc" );
    self endon( #"hash_8353713f77d859bc" );
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    
    while ( true )
    {
        function_b1d8b89810fc8fb4( rechargetime, updateperiod, equipmentref, var_f0d2326fa4a4e4b2, var_1b224f553374a3a );
        wait updateperiod;
    }
}

// Namespace equipment_mp
// Params 5
// Checksum 0x66b716db, Offset: 0x7b5f
// Size: 0x1d7
function function_b1d8b89810fc8fb4( rechargetime, updateperiod, equipmentref, var_1b224f553374a3a, var_f0d2326fa4a4e4b2 )
{
    equipment = getcurrentequipment( "secondary" );
    
    if ( equipment != equipmentref )
    {
        return;
    }
    
    if ( !isdefined( self.rechargeequipmentstate ) )
    {
        self.rechargeequipmentstate = spawnstruct();
        self.rechargeequipmentstate.progress = [];
        self.rechargeequipmentstate.recharged = [];
    }
    else
    {
        self.rechargeequipmentstate.recharged[ "secondary" ] = undefined;
    }
    
    ammo = getequipmentammo( equipment );
    ammomax = getequipmentmaxammo( equipment );
    state = self.rechargeequipmentstate;
    rechargeperupdate = updateperiod / rechargetime;
    
    if ( !isdefined( state.progress[ "secondary" ] ) )
    {
        state.progress[ "secondary" ] = 0;
    }
    
    if ( ammo < ammomax )
    {
        state.progress[ "secondary" ] = state.progress[ "secondary" ] + rechargeperupdate;
    }
    else
    {
        state.progress[ "secondary" ] = 0;
    }
    
    if ( state.progress[ "secondary" ] > 1 || abs( state.progress[ "secondary" ] - 1 ) < 0.001 )
    {
        incrementequipmentslotammo( "secondary", 1 );
        state.progress[ "secondary" ] = 0;
        state.recharged[ "secondary" ] = 1;
    }
    
    function_68c15bf89e6f60dd( var_1b224f553374a3a, var_f0d2326fa4a4e4b2 );
}

// Namespace equipment_mp
// Params 2, eflags: 0x4
// Checksum 0x896a9f66, Offset: 0x7d3e
// Size: 0x214
function private function_68c15bf89e6f60dd( var_1b224f553374a3a, restocksound = "ui_restock_tactical" )
{
    tacticalprogress = 0;
    var_bd099071594216aa = -1;
    
    if ( isdefined( self.rechargeequipmentstate ) )
    {
        if ( var_1b224f553374a3a )
        {
            if ( !isdefined( self.pers[ var_1b224f553374a3a ] ) )
            {
                self.pers[ var_1b224f553374a3a ] = 0;
            }
        }
        
        state = self.rechargeequipmentstate;
        
        if ( isdefined( state.progress[ "secondary" ] ) )
        {
            tacticalprogress = state.progress[ "secondary" ];
        }
        
        foreach ( slot, _ in state.recharged )
        {
            if ( slot == "secondary" )
            {
                var_bd099071594216aa += 2;
                self playlocalsound( restocksound );
                
                if ( var_1b224f553374a3a )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ var_1b224f553374a3a ] ) )
                        {
                            self.leaderboarddata[ var_1b224f553374a3a ] += 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ var_1b224f553374a3a ] ) )
                        {
                            [[ level.leaderboardfunc[ var_1b224f553374a3a ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x3f7>" );
                        
                        if ( isdefined( self.pers[ var_1b224f553374a3a ] ) )
                        {
                            self.pers[ var_1b224f553374a3a ] += 1;
                        }
                    }
                }
            }
        }
    }
    
    self setclientomnvar( "ui_tactical_recharge_progress", tacticalprogress );
    self setclientomnvar( "ui_recharge_notify", var_bd099071594216aa );
    self setpowerprogress( "secondary", tacticalprogress );
}

// Namespace equipment_mp
// Params 1
// Checksum 0x4ac1201b, Offset: 0x7f5a
// Size: 0xd2
function function_f6c5b0762bf2879e( bundle )
{
    self notify( #"hash_f612b88039d71d2a" );
    self endon( #"hash_f612b88039d71d2a" );
    self endon( #"death_or_disconnect" );
    
    if ( !function_21ce323f0a97cc0b( bundle ) )
    {
        return;
    }
    
    gestureweap = level.gamemodebundle.var_738ea1a9b59fd125;
    gestureanim = level.gamemodebundle.var_c9f2f9f9cc012514;
    
    if ( !( isdefined( gestureweap ) && isdefined( gestureanim ) ) )
    {
        return;
    }
    
    var_82319db22c4486f9 = makeweapon( gestureweap );
    function_e1ef466c93191c6( var_82319db22c4486f9, gestureanim );
    success = weapon_utility::giveandfireoffhandreliable( var_82319db22c4486f9 );
    
    if ( success )
    {
        wait self getgestureanimlength( gestureanim );
    }
    
    if ( self hasweapon( var_82319db22c4486f9 ) )
    {
        self takeweapon( var_82319db22c4486f9 );
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x47d80d41, Offset: 0x8034
// Size: 0xb0, Type: bool
function function_21ce323f0a97cc0b( bundle )
{
    if ( !isdefined( self ) || !bundle.var_d93cc63fa665e1a )
    {
        return false;
    }
    
    heldoffhand = weapon::getgrenadeinpullback();
    
    if ( !heldoffhand && !isnullweapon( heldoffhand ) )
    {
        return false;
    }
    
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self isthrowingbackgrenade() || player::isplayerads() || self.insertingarmorplate )
    {
        return false;
    }
    
    if ( isnullweapon( self getcurrentweapon() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace equipment_mp
// Params 1
// Checksum 0x3788c45c, Offset: 0x80ed
// Size: 0xb0
function function_36cd9122a1bd0a19( seconds )
{
    foreach ( equip in self.pers[ "rechargeEquipment" ] )
    {
        if ( equip.rechargeremaining && seconds )
        {
            equip.rechargeremaining -= seconds;
        }
    }
}

// Namespace equipment_mp
// Params 0
// Checksum 0x7dd7810b, Offset: 0x81a5
// Size: 0x71
function get_recharge_mod()
{
    recharge_mod = 1;
    
    if ( self.var_569051681ab1ed01 )
    {
        recharge_mod = self.var_569051681ab1ed01;
    }
    
    if ( self.var_31d5571990c33a4 )
    {
        recharge_mod = self.var_31d5571990c33a4;
    }
    
    if ( self.var_5b4b541c397a369c )
    {
        recharge_mod *= self.var_5b4b541c397a369c.bundle.var_1f1d6ad5f66695e0;
    }
    
    return recharge_mod;
}

// Namespace equipment_mp
// Params 2
// Checksum 0x7f893bb2, Offset: 0x821f
// Size: 0xf7
function function_ada7da3083a6c593( destroyedequipment, objweapon )
{
    if ( !isdefined( destroyedequipment ) )
    {
        assert( isdefined( destroyedequipment ) && isdefined( "<dev string:x556>" ) );
        return;
    }
    
    if ( !player_utility::playersareenemies( self, destroyedequipment.owner ) )
    {
        return;
    }
    
    equipmentref = destroyedequipment.equipmentref ?? getequipmentreffromweapon( destroyedequipment );
    
    if ( isdefined( equipmentref ) )
    {
        bundle = level.equipment.table[ equipmentref ].bundle;
        
        if ( isdefined( bundle ) && isdefined( bundle.var_d9dbf3735e714ea7 ) )
        {
            thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_d9dbf3735e714ea7, objweapon );
        }
        else
        {
            thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"destroyed_equipment", objweapon );
        }
    }
    else
    {
        thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"destroyed_equipment", objweapon );
    }
    
    gestures::processcalloutdeath( destroyedequipment, self );
}

// Namespace equipment_mp
// Params 2
// Checksum 0x17af862c, Offset: 0x831e
// Size: 0x88
function function_81665ba4ff7d7bd1( ref, class )
{
    tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    weapon = function_5c326751c7802342( tableinfo );
    
    if ( !isdefined( weapon ) )
    {
        return [ 0, 0 ];
    }
    
    ammocount = self getammocount( weapon );
    maxammo = getequipmentmaxammo( ref, class, undefined );
    return [ ammocount, maxammo ];
}

// Namespace equipment_mp
// Params 6
// Checksum 0x83beb0c6, Offset: 0x83af
// Size: 0x666
function function_5d2b66cabb4afed7( equipref, bundle, slot, variantid, equipattachments, class )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.var_5fe219d680afd262 ) )
    {
        level.var_5fe219d680afd262 = getdvarint( @"hash_2c797047acb795ab", 0 );
    }
    
    if ( level.var_5fe219d680afd262 && equipmentisrestricted( equipref ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_73926dc557be15a2 ) )
    {
        level.var_73926dc557be15a2 = [ "tertiary":"ui_tertiary_recharge_progress", "secondary":"ui_tactical_recharge_progress", "primary":"ui_lethal_recharge_progress" ];
    }
    
    if ( !isdefined( level.var_4564ab52a6a00ef5 ) )
    {
        level.var_4564ab52a6a00ef5 = [ "tertiary":"ui_tertiary_recharge_timer", "secondary":"ui_tactical_recharge_timer", "primary":"ui_lethal_recharge_timer" ];
    }
    
    newequip = 0;
    
    if ( !isdefined( self.pers[ "rechargeEquipment" ] ) )
    {
        self.pers[ "rechargeEquipment" ] = [];
    }
    
    if ( !isdefined( self.equipment ) )
    {
        self.equipment = [];
    }
    
    if ( !isdefined( self.var_e6d8cfcc28a79324 ) )
    {
        self.var_e6d8cfcc28a79324 = [];
    }
    
    threadclass = class ?? "";
    
    if ( !self.var_430dacaec72befdf[ threadclass ] || self.pers[ "rechargeEquipment" ][ slot ].ref != equipref )
    {
        thread function_a24c757b0224bd9c( class );
        self.var_430dacaec72befdf[ threadclass ] = 1;
    }
    
    if ( self.pers[ "rechargeEquipment" ][ slot ].ref != equipref )
    {
        /#
            if ( getdvarint( @"scr_equipment_recharge_debug", 0 ) )
            {
                logprint( "<dev string:x5a0>" + self.pers[ "<dev string:x5e7>" ][ slot ].ref + "<dev string:x5f9>" + equipref );
                logstring( "<dev string:x5a0>" + self.pers[ "<dev string:x5e7>" ][ slot ].ref + "<dev string:x5f9>" + equipref );
            }
        #/
        
        newequip = 1;
        self.pers[ "rechargeEquipment" ][ slot ] = { #attachments:equipattachments, #variant:variantid, #class:class, #slot:slot, #var_c8d12fce75a1f69d:bundle.var_c8d12fce75a1f69d, #var_e734cfc5db84ec9c:bundle.var_e734cfc5db84ec9c, #var_4a50548c9a4f6682:bundle.var_81791c5da223736a, #var_eb18bebb7b0484fd:bundle.var_a049f4e7e93e05a5, #var_18f81b5d17e7541a:bundle.var_dfa29c6f5a0e2402, #rechargetime:bundle.var_af22ec8b7c14505e, #ref:equipref };
    }
    
    if ( self.lifeid == 0 )
    {
        giveequipment( equipref, slot, class, variantid, equipattachments );
        
        if ( bundle.var_a049f4e7e93e05a5 )
        {
            var_142d4ebefdf5974c = bundle.var_f50cffb79b5e5e8a;
            self.pers[ "rechargeEquipment" ][ slot ].rechargeremaining = var_142d4ebefdf5974c ? var_142d4ebefdf5974c : 0;
            setequipmentammo( equipref, 0 );
            function_292817f6f6230815( slot, 0, 0 );
            self setpowerprogress( slot, 0 );
            self.pers[ "rechargeEquipment" ][ slot ].ammo = 0;
        }
        
        return;
    }
    
    if ( !self.pers[ "rechargeEquipment" ][ slot ].var_18f81b5d17e7541a )
    {
        giveequipment( equipref, slot, class, variantid, equipattachments );
        ammo = getequipmentammo( equipref );
        self.pers[ "rechargeEquipment" ][ slot ].rechargeremaining = undefined;
        self.pers[ "rechargeEquipment" ][ slot ].ammo = ammo;
        return;
    }
    
    if ( newequip )
    {
        giveequipment( equipref, slot, class, variantid, equipattachments );
        setequipmentammo( equipref, 0 );
        function_292817f6f6230815( slot, 0, 0 );
        self setpowerprogress( slot, 0 );
        self.pers[ "rechargeEquipment" ][ slot ].rechargeremaining = self.pers[ "rechargeEquipment" ][ slot ].var_af22ec8b7c14505e;
        self.pers[ "rechargeEquipment" ][ slot ].ammo = 0;
        self.pers[ "rechargeEquipment" ][ slot ].respawnammo = 0;
        return;
    }
    
    ammo = self.pers[ "rechargeEquipment" ][ slot ].ammo ? self.pers[ "rechargeEquipment" ][ slot ].ammo : 0;
    
    if ( self.pers[ "rechargeEquipment" ][ slot ].ref == self.pers[ #"power_weapon" ][ slot ].ref )
    {
        power_weapon = self.pers[ #"power_weapon" ][ slot ];
        
        if ( !bundle.var_17699bf9870d7319 || power_weapon.clipammo < power_weapon.maxclipammo || power_weapon.stockammo < power_weapon.var_be116b49a96aa33c )
        {
            ammo = 0;
            self.pers[ #"power_weapon" ][ slot ] = undefined;
            self.pers[ "rechargeEquipment" ][ slot ].pauserecharge = undefined;
        }
    }
    
    giveequipment( equipref, slot, class, variantid, equipattachments );
    setequipmentammo( equipref, ammo );
    self.pers[ "rechargeEquipment" ][ slot ].respawnammo = ammo;
    function_292817f6f6230815( slot, 0, 0 );
    self setpowerprogress( slot, 0 );
}

// Namespace equipment_mp
// Params 1
// Checksum 0xf58c2f1d, Offset: 0x8a1d
// Size: 0x6e2
function function_a24c757b0224bd9c( class )
{
    self notify( #"hash_805806b5c7288a27" );
    self endon( #"hash_805806b5c7288a27" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    rechargeinterval = getdvarfloat( @"hash_29408bad5215fc66", 0.05 );
    
    if ( !isdefined( level.run_equipment_recharge ) && getdvarint( @"scr_run_equipment_recharge_throttle", 0 ) )
    {
        level.run_equipment_recharge = throttle::throttle_initialize( "run_equipment_recharge", 5, undefined, 50 );
    }
    
    while ( true )
    {
        lasttime = gettime();
        result = utility::waittill_any_timeout( rechargeinterval, "grenade_thrown", "death", "equipment_recharge" );
        
        if ( isdefined( level.run_equipment_recharge ) )
        {
            throttle::throttle_wait_in_queue( level.run_equipment_recharge, self );
        }
        
        currenttime = gettime();
        var_9d11e730b3f28dc0 = ( currenttime - lasttime ) / 1000;
        
        foreach ( slot, equip in self.pers[ "rechargeEquipment" ] )
        {
            if ( result == "death" && !equip.var_e734cfc5db84ec9c && !equip.var_13944e5e2e56f0b8 )
            {
                continue;
            }
            
            if ( result != "death" && !player::isreallyalive( self ) && !equip.var_13944e5e2e56f0b8 )
            {
                continue;
            }
            
            if ( result != "equipment_recharge" && equip.pauserecharge )
            {
                continue;
            }
            
            if ( equip.ref != self.equipment[ slot ] )
            {
                ref = self.equipment[ slot ];
                equipbundle = function_c90a9aa89b223dd7( ref );
                
                if ( !isdefined( ref ) || ref == "none" || !equipbundle.var_ff969a74ed1aaeba )
                {
                    self.pers[ "rechargeEquipment" ][ slot ] = undefined;
                    function_292817f6f6230815( slot, 0, 0 );
                    self setpowerprogress( slot, 0 );
                    continue;
                }
                
                bundle = level.equipment.table[ ref ].bundle;
                self.pers[ "rechargeEquipment" ][ slot ] = { #attachments:undefined, #variant:undefined, #class:undefined, #slot:slot, #var_c8d12fce75a1f69d:bundle.var_c8d12fce75a1f69d, #var_e734cfc5db84ec9c:bundle.var_e734cfc5db84ec9c, #var_4a50548c9a4f6682:bundle.var_81791c5da223736a, #var_eb18bebb7b0484fd:bundle.var_a049f4e7e93e05a5, #var_18f81b5d17e7541a:bundle.var_dfa29c6f5a0e2402, #rechargetime:bundle.var_af22ec8b7c14505e, #ref:ref };
            }
            
            if ( isdefined( self.pers[ "rechargeEquipment" ][ slot ].respawnammo ) )
            {
                setequipmentammo( equip.ref, self.pers[ "rechargeEquipment" ][ slot ].respawnammo );
                self.pers[ "rechargeEquipment" ][ slot ].respawnammo = undefined;
            }
            
            var_924864f0190122d1 = function_81665ba4ff7d7bd1( equip.ref, class );
            ammo = var_924864f0190122d1[ 0 ];
            ammomax = var_924864f0190122d1[ 1 ];
            
            if ( result == "equipment_recharge" )
            {
                ammo = int( max( ammo, ammomax ) );
                setequipmentammo( equip.ref, ammo );
            }
            
            equip.ammo = ammo;
            
            if ( ammo >= ammomax )
            {
                equip.rechargeremaining = undefined;
                function_292817f6f6230815( slot, 0, 0 );
                self setpowerprogress( slot, 0 );
                continue;
            }
            
            /#
                if ( getdvarint( @"hash_44042ef4c0060bff", 0 ) || getdvarint( @"hash_58a9c778994087a3", 0 ) )
                {
                    foreach ( equipment in self.pers[ "<dev string:x5e7>" ] )
                    {
                        if ( equipment.rechargeremaining )
                        {
                            equipment.rechargeremaining = 0.01;
                        }
                    }
                    
                    if ( getdvarint( @"hash_44042ef4c0060bff", 0 ) )
                    {
                        setdevdvar( @"hash_44042ef4c0060bff", 0 );
                    }
                }
            #/
            
            if ( isdefined( equip.rechargeremaining ) )
            {
                if ( result == "death" && equip.var_e734cfc5db84ec9c )
                {
                    equip.rechargeremaining = clamp( equip.rechargeremaining - equip.var_c8d12fce75a1f69d, 0, equip.rechargetime );
                    continue;
                }
                
                rechargemod = get_recharge_mod();
                equip.rechargeremaining -= var_9d11e730b3f28dc0 * rechargemod;
                progress = clamp( 1 - equip.rechargeremaining / equip.rechargetime, 0, 1 );
                var_66705c9d5a3372e2 = equip.rechargeremaining / rechargemod;
                function_292817f6f6230815( equip.slot, progress, var_66705c9d5a3372e2 );
                self setpowerprogress( slot, 0 );
                
                if ( progress >= 1 )
                {
                    thread incrementequipmentslotammo( equip.slot, 1, class );
                    ammo++;
                    equip.ammo = ammo;
                    
                    if ( ammo >= ammomax )
                    {
                        equip.rechargeremaining = undefined;
                    }
                    else
                    {
                        equip.rechargeremaining = equip.rechargetime;
                    }
                }
                
                continue;
            }
            
            if ( ammo < ammomax )
            {
                equip.rechargeremaining = equip.rechargetime;
            }
        }
    }
}

// Namespace equipment_mp
// Params 1
// Checksum 0x7dffc11a, Offset: 0x9107
// Size: 0xa9
function function_c4b6a3c53d3a34ac( slot )
{
    assert( arraycontains( [ "<dev string:x41d>", "<dev string:x438>", "<dev string:x60b>", "<dev string:x614>" ], slot ), "<dev string:x624>" + slot + "<dev string:x62a>" );
    
    switch ( slot )
    {
        case #"hash_325cb2e66f67d5b9":
            return self fragbuttonpressed();
        case #"hash_511d3c24fcedcdb1":
            return self secondaryoffhandbuttonpressed();
        case #"hash_a7832978dd2b6523":
            return self superbuttonpressed();
        default:
            assertmsg( "<dev string:x649>" + slot );
            break;
    }
}

