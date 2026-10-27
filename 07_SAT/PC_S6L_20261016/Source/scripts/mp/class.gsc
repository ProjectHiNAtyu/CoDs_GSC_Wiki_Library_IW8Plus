// scripts\mp\class.gsc  (hash_062b082b02843be8.gscc) (size: 167924 Bytes / 0x28ff4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x119beb64 (295431012)
// size ...... 167924 (0x28ff4)
// includes .. 65  (offset: 0x264ac)
// strings ... 446 (offset: 0x266b4)
// dev strs .. 52  (offset: 0x28d28)
// exports ... 378 (offset: 0x1bd6c)
// cseg ...... 0x283a + 0x19532 (0x1bd6c)
// imports ... 811 (offset: 0x1f87c)
// animtree1 . 0   (offset: 0x28ff4)
// animtree2 . 0   (offset: 0x28ff4)
#using script_70ac8a06d80020b0;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\script;
#using scripts\common\snapshot;
#using scripts\common\swim_common;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\armor;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\class_hiding_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\prestige_challenge_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gestures;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_backpack;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\menus;
#using scripts\mp\operator;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\riotshield;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\validation;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

#namespace class;

// Namespace class
// Params 0
// Checksum 0x2b928e25, Offset: 0x2858
// Size: 0x57f
function init()
{
    /#
        setdvarifuninitialized( @"hash_9d24f55b5f58e63b", 0 );
    #/
    
    function_3c33b2559c4712be();
    level.classmap[ "gamemode" ] = 0;
    level.classmap[ "callback" ] = 0;
    level.classmap[ "juggernaut" ] = 0;
    
    if ( getcodegate( #"hash_c0af7aa622f4561b" ) )
    {
        function_34aa9e98d3a79724();
    }
    
    if ( level.tempv_enabled )
    {
        level.classmap[ "superpower" ] = 0;
    }
    
    for ( i = 0; i <= 2 ; i++ )
    {
        level.classmap[ "class" + i ] = 0;
    }
    
    for ( i = 1; i <= 12 ; i++ )
    {
        level.classmap[ "custom" + i ] = i - 1;
    }
    
    for ( i = 1; i <= 6 ; i++ )
    {
        level.classmap[ "axis_recipe" + i ] = i - 1;
        level.classmap[ "allies_recipe" + i ] = i - 1;
    }
    
    for ( i = 1; i <= 10 ; i++ )
    {
        level.classmap[ "default" + i ] = i - 1;
    }
    
    if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
    {
        if ( level.gamemodebundle.var_466182224fed917d && isdefined( level.gamemodebundle.var_d99b08c8f66883f4 ) && level.gamemodebundle.var_7d3e8d5033d22ced )
        {
            prestigebundle = getscriptbundle( level.gamemodebundle.var_d99b08c8f66883f4 );
            
            if ( isdefined( prestigebundle ) )
            {
                level.var_71749a9a1664454 = prestigebundle.classtable;
                prestigeclasstable = getscriptbundle( level.var_71749a9a1664454 );
                
                if ( isdefined( prestigeclasstable ) && isdefined( prestigeclasstable.classlist ) )
                {
                    classtitle = prestige_challenge_utility::function_9bdd875e7b63531e();
                    
                    for ( i = 1; i <= prestigeclasstable.classlist.size ; i++ )
                    {
                        level.classmap[ classtitle + i ] = i - 1;
                    }
                }
            }
        }
    }
    
    namespace_9197bf71f178e483::init();
    
    /#
        level.var_61b6f530efa70119 = [];
        level.var_61b6f530efa70119[ 0 ] = "<dev string:x24>";
        level.var_61b6f530efa70119[ 1 ] = "<dev string:x24>";
        level.var_61b6f530efa70119[ 2 ] = "<dev string:x24>";
        level.var_61b6f530efa70119[ 3 ] = "<dev string:x24>";
        level.var_61b6f530efa70119[ 4 ] = "<dev string:x24>";
    #/
    
    level.aibuildweapon = &buildweapon_redirect;
    
    /#
        level.aivalidateweapon = &function_b04ba67f049690a9;
    #/
    
    level.defaultclass = "CLASS_ASSAULT";
    
    if ( isdefined( level.gametypebundle.classTableOverride ) )
    {
        level.classtablename = level.gametypebundle.classTableOverride;
        
        if ( game_utility::function_d60ba5ade32ddb31() )
        {
            level.classtablename = "classtable_battlemode_zul";
        }
    }
    else if ( isdefined( level.gamemodebundle.classtable ) )
    {
        level.classtablename = level.gamemodebundle.classtable;
    }
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        level.classtablename = level.gamemodebundle.var_87d99f1c2533c774;
    }
    
    if ( getdvar( @"scr_classtable_override", "" ) != "" )
    {
        tablename = getdvar( @"scr_classtable_override" );
        classtable = getscriptbundle( "classtable:" + tablename );
        
        if ( isdefined( classtable ) )
        {
            level.classtablename = hashcat( %"classtable:", tablename );
        }
    }
    
    level.var_893e01501401ebc0 = getdvarint( @"scr_enable_classswap_postcombat" ) == 1;
    assert( isdefined( level.classtablename ), "<dev string:x2b>" );
    
    if ( isusingmatchrulesdata() )
    {
        level.var_a912a3e22d337a23 = getmatchrulesdata( "commonOption", "backupPistol" );
        level.var_b36ec6e82a2a804f = getmatchrulesdata( "commonOption", "backupPistolCamo" );
        level.var_d8579ef527127221 = getmatchrulesdata( "commonOption", "backupPistolReticle" );
        level.var_8b6e23e8333e6c6a = getmatchrulesdata( "commonOption", "backupPistolReload" );
        level.var_2b140b6eecabbe7 = [];
        
        for ( i = 1; i <= 5 ; i++ )
        {
            fieldname = "backupPistolAttachment" + i;
            attachment = getmatchrulesdata( "commonOption", fieldname );
            
            if ( isdefined( attachment ) && attachment != "none" )
            {
                level.var_2b140b6eecabbe7[ level.var_2b140b6eecabbe7.size ] = attachment;
            }
        }
        
        level.var_2b140b6eecabbe7[ level.var_2b140b6eecabbe7.size ] = "backup_pistol";
        level.disableBonusPerks = getmatchrulesdata( "commonOption", "disableBonusPerks" );
    }
    
    if ( level.gametypebundle.var_a9d5efb23dfeefe )
    {
        level.allowclasschoicefunc = &function_5a1e833d6e7513aa;
        level.bypassclasschoicefunc = &function_c2df8a6daecfea12;
    }
    
    utility::registersharedfunc( #"dmz", #"hash_8ba44ea29695fe01", &function_2ed2b8bcdb9e828 );
    function_8397a0963efc18ee();
    level thread onplayerconnecting();
    level thread onplayerspawned();
}

// Namespace class
// Params 0
// Checksum 0x40a40ff5, Offset: 0x2ddf
// Size: 0xf4
function function_8397a0963efc18ee()
{
    if ( level.projectbundle.var_786bc1b37b3f67fa )
    {
        if ( level.projectbundle.var_b0ce8746399cd16a )
        {
            utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &function_965c85a4e2efba31, 1 );
            utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &function_ed695e64253d505c, 1 );
        }
        else
        {
            utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &function_4d5d5b22ebcdfca0, 1 );
            utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &function_cc98941cc6d2c869, 1 );
        }
        
        return;
    }
    
    utility::registersharedfunc( #"player", #"hash_c631568a218d88a6", &function_63f75b40675b196f, 1 );
    utility::registersharedfunc( #"player", #"hash_3f6034cbc65791c3", &function_11d5729edc847aa6, 1 );
}

// Namespace class
// Params 0
// Checksum 0xc4a38456, Offset: 0x2edb
// Size: 0xac, Type: bool
function function_5a1e833d6e7513aa()
{
    assert( level.gametypebundle.var_a9d5efb23dfeefe, "<dev string:x6a>" );
    
    if ( isbot( self ) )
    {
        return true;
    }
    
    if ( ( !isdefined( self.pers[ "class" ] ) || self.pers[ "class" ] == "" ) && ( game[ "state" ] != "playing" || !flags::gameflag( "prematch_done" ) ) )
    {
        return false;
    }
    
    if ( self.switching_teams )
    {
        return false;
    }
    
    if ( flags::gameflag( "prematch_started" ) || flags::gameflag( "graceperiod_done" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace class
// Params 0
// Checksum 0x72ff9e28, Offset: 0x2f90
// Size: 0x80
function function_c2df8a6daecfea12()
{
    if ( isbot( self ) )
    {
        return "callback";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        if ( !isdefined( self.loadoutdata ) )
        {
            self.loadoutdata = level.loadoutdata;
        }
        
        savedloadoutindex = self getplayerdata( self.loadoutdata, "loadoutSettings", "lastSelectedLoadoutIndex" );
    }
    else
    {
        savedloadoutindex = self getplayerdata( level.loadoutdata, "squadMembers", "lastSelectedLoadoutIndex" );
    }
    
    return menus::getclasschoice( savedloadoutindex );
}

// Namespace class
// Params 0
// Checksum 0x5c736ffa, Offset: 0x3019
// Size: 0xed
function function_3c33b2559c4712be()
{
    level.defaultfist = weapon_utility::makedefaultweapon( getscriptbundlefieldvalue( level.gamemodebundle.defaultfist, #"asset" ) );
    level.var_f8ac15ada97a702a = weapon_utility::makedefaultweapon( getscriptbundlefieldvalue( level.gamemodebundle.var_f8ac15ada97a702a, #"asset" ) );
    level.var_f51157de397416bd = weapon_utility::makedefaultweapon( getscriptbundlefieldvalue( level.gamemodebundle.var_f51157de397416bd, #"asset" ) );
    level.defaultswimweapon = weapon_utility::makedefaultweapon( getscriptbundlefieldvalue( level.gamemodebundle.defaultswimweapon, #"asset" ) );
    level.defaultknifestab = weapon_utility::makedefaultweapon( getscriptbundlefieldvalue( level.gamemodebundle.defaultknifestab, #"asset" ) );
}

/#

    // Namespace class
    // Params 9
    // Checksum 0x6862eebc, Offset: 0x310e
    // Size: 0x6a, Type: dev
    function function_b04ba67f049690a9( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg )
    {
        return weapon::validateweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg );
    }

#/

// Namespace class
// Params 9
// Checksum 0x4ee135b5, Offset: 0x3180
// Size: 0x66
function buildweapon_redirect( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg )
{
    return weapon::buildweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg );
}

// Namespace class
// Params 1
// Checksum 0xe7eaba0c, Offset: 0x31ef
// Size: 0x23
function getclasschoice( response )
{
    assert( isdefined( level.classmap[ response ] ) );
    return response;
}

// Namespace class
// Params 1
// Checksum 0x6b93f7ee, Offset: 0x321b
// Size: 0x3a
function getweaponchoice( response )
{
    tokens = strtok( response, "," );
    
    if ( tokens.size > 1 )
    {
        return int( tokens[ 1 ] );
    }
    
    return 0;
}

// Namespace class
// Params 0
// Checksum 0xbb8522f4, Offset: 0x325d
// Size: 0x26
function function_4d362babbfd5b4b1()
{
    if ( !isdefined( level.var_c158efd9b3edbd8b ) )
    {
        level.var_c158efd9b3edbd8b = function_508751cafa49d057();
    }
    
    return level.var_c158efd9b3edbd8b;
}

// Namespace class
// Params 0, eflags: 0x4
// Checksum 0xa8363165, Offset: 0x328c
// Size: 0xe1
function private function_508751cafa49d057()
{
    if ( level.projectbundle.var_786bc1b37b3f67fa && ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec ) )
    {
        return getdvarint( @"hash_ab286b48fb8457", 1 );
    }
    
    projectname = getxhash( getprojectname() ?? "" );
    
    switch ( projectname )
    {
        case #"kra":
        case #"krw":
        case #"t10":
        case #"wz2":
        case #"SAT":
        case #"saw":
        case #"zul":
            return getdvarint( @"hash_ab286b48fb8457", 1 );
    }
    
    return 0;
}

// Namespace class
// Params 0
// Checksum 0x740d73ea, Offset: 0x3376
// Size: 0x39
function function_2951ee8f6b75caad()
{
    projectname = getprojectname();
    
    if ( projectname == "SAT" || projectname == "SAW" )
    {
        return getdvarint( @"hash_1b81cd71045ce5bb", 0 );
    }
    
    return 0;
}

// Namespace class
// Params 1
// Checksum 0xf323e636, Offset: 0x33b8
// Size: 0x61
function function_4573a68b3f3d5235( lootid )
{
    var_5f429aeecb6159c4 = weapons::function_636e43f4bcdc20b5( lootid );
    
    if ( isdefined( var_5f429aeecb6159c4 ) && var_5f429aeecb6159c4 != 0 )
    {
        lootid = var_5f429aeecb6159c4;
    }
    
    if ( lootid == 0 )
    {
        return "none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( ref.size == 0 )
    {
        return "none";
    }
    
    return ref;
}

// Namespace class
// Params 2
// Checksum 0x33a6a04a, Offset: 0x3422
// Size: 0x96
function cac_getweapon( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"weaponsetups", weaponindex, #"weaponlootid" );
        return function_4573a68b3f3d5235( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, #"squadmembers", #"loadouts", classindex, #"weaponsetups", weaponindex, #"weapon" );
}

// Namespace class
// Params 0
// Checksum 0x99fed95b, Offset: 0x34c1
// Size: 0x15
function function_facf39de1a82731a()
{
    return self.classstruct.loadoutwildcard;
}

// Namespace class
// Params 1
// Checksum 0xaf9812d1, Offset: 0x34df
// Size: 0xa2
function function_be7cee2ec3dda47a( classindex )
{
    if ( !level.gamemodebundle.var_2cb40e0296514a72 )
    {
        return;
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "wildcardLootID" );
        
        if ( lootid == 0 )
        {
            return "wildcard_none";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "wildcard_none";
        }
        
        return ref;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "wildcard" );
}

// Namespace class
// Params 0, eflags: 0x4
// Checksum 0x5fd55f18, Offset: 0x358a
// Size: 0x151
function private function_34aa9e98d3a79724()
{
    if ( !getcodegate( #"hash_c0af7aa622f4561b" ) )
    {
        return;
    }
    
    if ( !function_4d362babbfd5b4b1() )
    {
        return;
    }
    
    var_9f70876e102558df = 1;
    projectname = getprojectname();
    
    if ( projectname == "ZUL" )
    {
        var_9f70876e102558df = 0;
    }
    
    if ( var_9f70876e102558df )
    {
        isbr = isbrgamemode();
        
        if ( !isbr )
        {
            return;
        }
    }
    
    tablename = "loot/cer_attachment_overrides.csv";
    
    if ( !tableexists( tablename ) )
    {
        return;
    }
    
    numrows = tablelookupgetnumrows( tablename );
    
    if ( !isdefined( numrows ) || numrows < 1 )
    {
        return;
    }
    
    level.var_436d40ec1515db96 = [];
    
    for ( rownum = 0; rownum < numrows ; rownum++ )
    {
        var_1dd697f8451f5447 = tablelookupbyrow( tablename, rownum, 0 );
        
        if ( !var_1dd697f8451f5447 )
        {
            continue;
        }
        
        var_dd6f56f8bedb8817 = tablelookupbyrow( tablename, rownum, 1 );
        
        if ( !var_dd6f56f8bedb8817 )
        {
            continue;
        }
        
        var_1630c53fc2385cb9 = tablelookupbyrow( tablename, rownum, 2 );
        
        if ( !var_1630c53fc2385cb9 )
        {
            continue;
        }
        
        var_9a79784ff6fd2620 = tablelookupbyrow( tablename, rownum, 3 );
        
        if ( !isint( var_9a79784ff6fd2620 ) )
        {
            continue;
        }
        
        level.var_436d40ec1515db96[ var_1dd697f8451f5447 ][ var_dd6f56f8bedb8817 ][ var_9a79784ff6fd2620 ] = var_1630c53fc2385cb9;
    }
    
    level.var_d62386002a717103 = 1;
}

// Namespace class
// Params 0, eflags: 0x4
// Checksum 0x3d96eb11, Offset: 0x36e3
// Size: 0xc, Type: bool
function private function_d62386002a717103()
{
    return istrue( level.var_d62386002a717103 );
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xcf5efd67, Offset: 0x36f8
// Size: 0x48
function private function_700ff34abd500029( var_e2f5e239362adf91 )
{
    if ( !function_d62386002a717103() )
    {
        return;
    }
    
    if ( !tableexists( "loot/cer_attachment_overrides.csv" ) )
    {
        return;
    }
    
    parentref = tablelookup( "loot/cer_attachment_overrides.csv", 2, var_e2f5e239362adf91, 0 );
    
    if ( !parentref )
    {
        return;
    }
    
    return parentref;
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xddb8f249, Offset: 0x3749
// Size: 0x8e, Type: bool
function private function_67ed5ccfe31d2542( attachmentref )
{
    if ( !function_d62386002a717103() )
    {
        return false;
    }
    
    if ( !isdefined( attachmentref ) || attachmentref.size == 0 || attachmentref == "none" )
    {
        return false;
    }
    
    lootid = loot::getlootidfromref( attachmentref ) ?? 0;
    
    if ( lootid == 0 )
    {
        return true;
    }
    
    primaryproject = loot::function_5f0a3b2f02f64376( lootid );
    
    if ( !isdefined( primaryproject ) )
    {
        return false;
    }
    
    if ( primaryproject == "iw9" || primaryproject == "jup" )
    {
        return true;
    }
    
    return false;
}

// Namespace class
// Params 3, eflags: 0x4
// Checksum 0xc4d830e5, Offset: 0x37e0
// Size: 0x91
function private function_c2b876c33c61a7a3( var_24dd5f5e18f69db4, weaponref, var_5bd1afcd821f4aed )
{
    if ( !function_d62386002a717103() )
    {
        return var_24dd5f5e18f69db4;
    }
    
    if ( !isdefined( level.var_436d40ec1515db96 ) )
    {
        return var_24dd5f5e18f69db4;
    }
    
    var_8fffa1939d46bb9e = level.var_436d40ec1515db96[ var_24dd5f5e18f69db4 ][ weaponref ][ var_5bd1afcd821f4aed ];
    
    if ( !var_8fffa1939d46bb9e )
    {
        return var_24dd5f5e18f69db4;
    }
    
    var_28573d7465b62b0e = loot::getlootidfromref( var_8fffa1939d46bb9e ) ?? 0;
    
    if ( var_28573d7465b62b0e != 0 )
    {
        return var_24dd5f5e18f69db4;
    }
    
    if ( var_8fffa1939d46bb9e.size == 0 )
    {
        return "none";
    }
    
    return var_8fffa1939d46bb9e;
}

// Namespace class
// Params 2
// Checksum 0x3d0afff2, Offset: 0x387a
// Size: 0xe9
function function_5acc830f47e150f0( weapon, lootid )
{
    if ( isdefined( lootid ) && lootid != 0 )
    {
        if ( getcodegate( #"hash_c0af7aa622f4561b" ) && function_d62386002a717103() )
        {
            var_e0ef09eb495fd32b = loot::function_5fea6a6dee392b8( lootid, weapon::weaponassetnamemap( weapon ) );
            var_5f429aeecb6159c4 = loot::getlootidfromref( var_e0ef09eb495fd32b ) ?? 0;
            
            if ( var_5f429aeecb6159c4 == 0 )
            {
                if ( function_67ed5ccfe31d2542( var_e0ef09eb495fd32b ) )
                {
                    parentref = function_700ff34abd500029( var_e0ef09eb495fd32b );
                    
                    if ( isdefined( parentref ) )
                    {
                        var_5f429aeecb6159c4 = loot::getlootidfromref( parentref ) ?? 0;
                        
                        if ( var_5f429aeecb6159c4 != 0 )
                        {
                            lootid = var_5f429aeecb6159c4;
                        }
                    }
                }
            }
        }
    }
    
    if ( lootid == 0 )
    {
        return "none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( !isdefined( ref ) || ref.size == 0 )
    {
        return "none";
    }
    
    return ref;
}

// Namespace class
// Params 4
// Checksum 0x671234be, Offset: 0x396c
// Size: 0x18c
function cac_getweaponattachment( classindex, weaponindex, attachmentindex, weapon = cac_getweapon( classindex, weaponindex ) )
{
    if ( weapon == "none" )
    {
        return "none";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"weaponsetups", weaponindex, #"attachmentsetup", attachmentindex, #"attachmentlootid" );
        ref = function_5acc830f47e150f0( weapon, lootid );
        
        if ( getcodegate( #"hash_c0af7aa622f4561b" ) && function_d62386002a717103() )
        {
            if ( ref != "none" && function_67ed5ccfe31d2542( ref ) )
            {
                var_5bd1afcd821f4aed = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"weaponsetups", weaponindex, #"attachmentsetup", attachmentindex, #"attachmentoverridechildindex" ) ?? 0;
                var_30158a1169c794c9 = function_c2b876c33c61a7a3( ref, weapon, var_5bd1afcd821f4aed );
                
                if ( isdefined( var_30158a1169c794c9 ) )
                {
                    ref = var_30158a1169c794c9;
                }
            }
        }
    }
    else
    {
        ref = self getplayerdata( level.loadoutdata, #"squadmembers", #"loadouts", classindex, #"weaponsetups", weaponindex, #"attachmentsetup", attachmentindex, #"attachment" );
    }
    
    return weapon::function_668a13182805f553( weapon, ref );
}

// Namespace class
// Params 3
// Checksum 0xcb5c7589, Offset: 0x3b01
// Size: 0xa1
function cac_getweaponattachmentid( classindex, weaponindex, attachmentindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"weaponsetups", weaponindex, #"attachmentsetup", attachmentindex, #"attachmentvariantid" );
    }
    
    return self getplayerdata( level.loadoutdata, #"squadmembers", #"loadouts", classindex, #"weaponsetups", weaponindex, #"attachmentsetup", attachmentindex, #"variantid" );
}

// Namespace class
// Params 3
// Checksum 0xecd812df, Offset: 0x3bab
// Size: 0xfd
function cac_getweaponattachmenttuning( classindex, weaponindex, attachmentindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        slider1 = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 0 );
        slider2 = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 1 );
    }
    else
    {
        slider1 = self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 0 );
        slider2 = self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachmentindex, "customTune", 1 );
    }
    
    return function_30bf6ea7991aec2a( slider1, slider2 );
}

// Namespace class
// Params 2
// Checksum 0x18c7dcb3, Offset: 0x3cb1
// Size: 0x62
function function_30bf6ea7991aec2a( slider1, slider2 )
{
    var_2a4aa0596dcdf6cc = function_4bd7309db3ebaf5c( slider1 );
    var_ba1490a1d93ab37 = function_4bd7309db3ebaf5c( slider2 );
    
    if ( !( isdefined( var_2a4aa0596dcdf6cc ) && isdefined( var_ba1490a1d93ab37 ) ) )
    {
        return;
    }
    
    sliders = [ var_2a4aa0596dcdf6cc, var_ba1490a1d93ab37 ];
    return sliders;
}

// Namespace class
// Params 2
// Checksum 0x71c2170f, Offset: 0x3d1b
// Size: 0x97
function cac_getweaponlootitemid( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "weaponLootID" );
        var_5f429aeecb6159c4 = weapons::function_636e43f4bcdc20b5( lootid );
        
        if ( isdefined( var_5f429aeecb6159c4 ) && var_5f429aeecb6159c4 != 0 )
        {
            return var_5f429aeecb6159c4;
        }
        
        return lootid;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID" );
}

// Namespace class
// Params 1
// Checksum 0xe59f3901, Offset: 0x3dbb
// Size: 0xf9
function function_8840c0bc3ed152d1( lootid )
{
    if ( lootid == 0 )
    {
        return 0;
    }
    
    variantref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", lootid ) ?? loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( !isdefined( variantref ) )
    {
        return 0;
    }
    
    baseweaponref = weapon::weaponassetnamemap( weapon::getweaponrootname( variantref ) );
    var_6ced0f085bfa4a3c = getxhashasset( variantref );
    weaponvariants = getweaponblueprintnames( baseweaponref );
    
    foreach ( variant, id in weaponvariants )
    {
        if ( var_6ced0f085bfa4a3c == variant )
        {
            return id;
        }
    }
    
    return 0;
}

// Namespace class
// Params 2
// Checksum 0x38adb426, Offset: 0x3ebd
// Size: 0x7a
function cac_getweaponvariantid( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "weaponLootID" );
        return function_8840c0bc3ed152d1( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "variantID" );
}

// Namespace class
// Params 1
// Checksum 0x88085b30, Offset: 0x3f40
// Size: 0x4d
function function_3e323ed5347a6e8d( lootid )
{
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        return "camo_none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( !isdefined( ref ) || ref.size == 0 )
    {
        return "camo_none";
    }
    
    return ref;
}

// Namespace class
// Params 1
// Checksum 0x2ae8e0fb, Offset: 0x3f96
// Size: 0x67
function function_e6526d29276880dd( lootid )
{
    ref = function_3e323ed5347a6e8d( lootid );
    
    if ( ref == "camo_none" )
    {
        return "camo_none";
    }
    
    ref = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", ref ), #"ref" );
    
    if ( !isdefined( ref ) || ref.size == 0 )
    {
        return "camo_none";
    }
    
    return ref;
}

// Namespace class
// Params 2
// Checksum 0xcbffd6d5, Offset: 0x4006
// Size: 0x7a
function cac_getweaponcamo( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "camoLootID" );
        return function_e6526d29276880dd( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo" );
}

// Namespace class
// Params 2
// Checksum 0x11d81d3f, Offset: 0x4089
// Size: 0x66
function cac_getweaponchroma( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "chroma" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "chroma" );
}

// Namespace class
// Params 2
// Checksum 0xd3d01264, Offset: 0x40f8
// Size: 0xd6
function function_e33bbd58c1d11a9( classindex, weaponindex )
{
    if ( getdvarint( @"hash_48a7efbad3962529", -1 ) >= 0 )
    {
        return getdvarint( @"hash_48a7efbad3962529" );
    }
    
    var_9693eb1222f0f801 = function_4d362babbfd5b4b1();
    
    for ( i = 0; i < 2 ; i++ )
    {
        serialvalue = 0;
        
        if ( var_9693eb1222f0f801 )
        {
            serialvalue = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "stickerSerialID", i );
        }
        else
        {
            serialvalue = self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "stickerSerialID", i );
        }
        
        if ( isdefined( serialvalue ) && serialvalue != 0 )
        {
            return serialvalue;
        }
    }
    
    return 0;
}

// Namespace class
// Params 1
// Checksum 0xd21e2dc1, Offset: 0x41d7
// Size: 0x3d
function function_6522d758f2f446e9( lootid )
{
    if ( lootid == 0 )
    {
        return "none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( ref.size == 0 )
    {
        return "none";
    }
    
    return ref;
}

// Namespace class
// Params 2
// Checksum 0x94de5895, Offset: 0x421d
// Size: 0x7a
function cac_getweaponreticle( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "reticleLootID" );
        return function_6522d758f2f446e9( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle" );
}

// Namespace class
// Params 2
// Checksum 0xf15a0ad8, Offset: 0x42a0
// Size: 0xd0
function cac_getkillstreak( index, class )
{
    [ killstreakref, lootid ] = cac_getkillstreak_internal( index, class );
    
    if ( level.var_ac98e7cc4b10cb11 && killstreakref && lootid )
    {
        if ( !isdefined( self.pers[ #"hash_5358b5a919fe00a6" ] ) )
        {
            self.pers[ #"hash_5358b5a919fe00a6" ] = [];
        }
        
        self.pers[ #"hash_5358b5a919fe00a6" ][ killstreakref ] = level.streakglobals.var_99bf84bbdcdf0052[ lootid ];
    }
    
    self.var_648d16a68046d1b6[ #"killstreak" ][ index ] = lootid;
    return killstreakref;
}

// Namespace class
// Params 2, eflags: 0x4
// Checksum 0x805cdd5e, Offset: 0x4379
// Size: 0x50b
function private cac_getkillstreak_internal( index, class )
{
    lootid = undefined;
    
    if ( !isdefined( level.var_d8927de46057730d ) )
    {
        level.var_d8927de46057730d = getdvarint( @"elt_killstreaks", 0 ) > 0;
    }
    
    if ( level.var_d8927de46057730d )
    {
        switch ( index )
        {
            case 0:
                cackillstreak = getdvar( @"hash_1449213edaa3d562", "none" );
                break;
            case 1:
                cackillstreak = getdvar( @"hash_1449203edaa3d32f", "none" );
                break;
            case 2:
                cackillstreak = getdvar( @"hash_14491f3edaa3d0fc", "none" );
                break;
            default:
                break;
        }
        
        return [ cackillstreak, lootid ];
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        if ( level.var_ac98e7cc4b10cb11 )
        {
            lootid = self getplayerdata( self.loadoutdata, "killstreakSetups", index, "proContentLootID" );
            
            /#
                if ( level.var_ac98e7cc4b10cb11 )
                {
                    switch ( index )
                    {
                        case 0:
                            if ( getdvarint( @"hash_85b7cdab7bb067f6", 0 ) > 0 )
                            {
                                lootid = getdvarint( @"hash_85b7cdab7bb067f6" );
                            }
                            
                            break;
                        case 1:
                            if ( getdvarint( @"hash_85b7ceab7bb06a29", 0 ) > 0 )
                            {
                                lootid = getdvarint( @"hash_85b7ceab7bb06a29" );
                            }
                            
                            break;
                        case 2:
                            if ( getdvarint( @"hash_85b7cbab7bb06390", 0 ) > 0 )
                            {
                                lootid = getdvarint( @"hash_85b7cbab7bb06390" );
                            }
                            
                            break;
                        default:
                            break;
                    }
                }
            #/
            
            if ( ( lootid ?? 0 ) != 0 )
            {
                cackillstreak = level.streakglobals.var_4384a813e6a0950[ lootid ];
            }
        }
        
        if ( !lootid || lootid == 0 )
        {
            if ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec )
            {
                classindex = getclassindex( class );
                lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "killstreakSetups", index, "killstreakLootID" ) ?? 0;
            }
            else
            {
                lootid = self getplayerdata( self.loadoutdata, "killstreakSetups", index, "killstreakLootID" ) ?? 0;
            }
        }
        
        if ( lootid == 0 )
        {
            return [ "none", undefined ];
        }
        
        if ( !isdefined( cackillstreak ) )
        {
            cackillstreak = loot::function_f54ecb89dfab8e8c( lootid );
        }
        
        if ( cackillstreak.size == 0 )
        {
            return [ "none", undefined ];
        }
    }
    else
    {
        cackillstreak = self getplayerdata( level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreak" );
    }
    
    if ( isdefined( level.var_5b4b6d7aef345c0e ) && level.gametype == "conf_v" )
    {
        switch ( index )
        {
            case 0:
                cackillstreak = "none";
                break;
            case 1:
                cackillstreak = "electric_discharge";
                break;
            case 2:
                cackillstreak = "laser_charge";
                break;
            case 3:
                cackillstreak = "none";
                break;
            default:
                break;
        }
        
        return [ cackillstreak, undefined ];
    }
    
    if ( level.var_9394f65c684e87fb )
    {
        switch ( index )
        {
            case 0:
                cackillstreak = getdvar( hashcat( @"hash_7129c8b31055dff8", 1 ), "switchblade_drone" );
                break;
            case 1:
                cackillstreak = getdvar( hashcat( @"hash_7129c8b31055dff8", 2 ), "cruise_predator" );
                break;
            case 2:
                cackillstreak = getdvar( hashcat( @"hash_7129c8b31055dff8", 3 ), "fuel_airstrike" );
                break;
            default:
                break;
        }
        
        return [ cackillstreak, undefined ];
    }
    
    switch ( index )
    {
        case 0:
            var_b75a5195c67b403f = level.gametypebundle.killstreak.killstreak1;
            break;
        case 1:
            var_b75a5195c67b403f = level.gametypebundle.killstreak.killstreak2;
            break;
        case 2:
            var_b75a5195c67b403f = level.gametypebundle.killstreak.killstreak3;
            break;
        default:
            break;
    }
    
    if ( var_b75a5195c67b403f != 0 )
    {
        lootid = var_b75a5195c67b403f;
        cackillstreak = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    return [ cackillstreak, lootid ];
}

// Namespace class
// Params 3
// Checksum 0x7ec913c7, Offset: 0x488d
// Size: 0xe4
function function_9f6f840868cfaebb( index, class, killstreakref )
{
    if ( function_4d362babbfd5b4b1() && !level.gamemodebundle.var_f45b2050846bb791 )
    {
        if ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec )
        {
            lootid = self getplayerdata( self.loadoutdata, "loadouts", 0, "killstreakSetups", index, "blueprintLootID" );
        }
        else
        {
            lootid = self getplayerdata( self.loadoutdata, "killstreakSetups", index, "blueprintLootID" );
        }
    }
    else
    {
        lootid = self getplayerdata( level.loadoutdata, "squadMembers", "killstreakSetups", index, "blueprintLootID" );
    }
    
    return killstreaks::function_a9203223832db05d( killstreakref, lootid );
}

// Namespace class
// Params 0
// Checksum 0xc51199b9, Offset: 0x497a
// Size: 0x28
function cac_getcharacterarchetype()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        return self.changedarchetypeinfo.archetype;
    }
    
    return "archetype_assault";
}

// Namespace class
// Params 3
// Checksum 0x840b9639, Offset: 0x49ab
// Size: 0x12e
function function_d5b183532c47be35( classindex, equipindex, equipref )
{
    if ( !equipref )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ #"hash_ddf4800634d16ffd" ] ) )
    {
        self.pers[ #"hash_ddf4800634d16ffd" ] = [];
    }
    
    if ( !function_4d362babbfd5b4b1() || !level.var_ac98e7cc4b10cb11 )
    {
        self.pers[ #"hash_ddf4800634d16ffd" ][ equipref ] = undefined;
        return;
    }
    
    proContentLootID = self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", equipindex, "proContentLootID" ) ?? 0;
    
    if ( ( proContentLootID ?? 0 ) != 0 )
    {
        var_57ba1dca95b7f9a8 = level.equipment.var_f6239534f2f3bc28[ proContentLootID ];
    }
    
    if ( var_57ba1dca95b7f9a8 && proContentLootID )
    {
        self.pers[ #"hash_ddf4800634d16ffd" ][ equipref ] = level.equipment.var_3fa9633f9795b719[ proContentLootID ];
    }
    else
    {
        self.pers[ #"hash_ddf4800634d16ffd" ][ equipref ] = undefined;
    }
    
    return var_57ba1dca95b7f9a8;
}

// Namespace class
// Params 1
// Checksum 0x620a1b33, Offset: 0x4ae2
// Size: 0xdf
function cac_getequipmentprimary( classindex )
{
    self.var_648d16a68046d1b6[ #"equipmentprimary" ] = 0;
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 0, "equipmentLootID" );
        
        if ( lootid == 0 )
        {
            return "none";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "none";
        }
        
        self.var_648d16a68046d1b6[ #"equipmentprimary" ] = lootid;
        var_7781459233518d3c = function_d5b183532c47be35( classindex, 0, ref );
        return ( var_7781459233518d3c ?? ref );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "equipment" );
}

// Namespace class
// Params 2
// Checksum 0xf208a733, Offset: 0x4bc9
// Size: 0xa7
function function_be70f19314ad522( classindex, equipindex )
{
    if ( function_4d362babbfd5b4b1() && level.var_ac98e7cc4b10cb11 )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", equipindex, "proContentLootID" );
        
        if ( lootid == 0 )
        {
            return [];
        }
        
        ref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", lootid ) ?? loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return [];
        }
        
        return [ ref ];
    }
    
    return [];
}

// Namespace class
// Params 1
// Checksum 0x562864f2, Offset: 0x4c78
// Size: 0x5f
function function_fa9f647e285ca27a( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 0, "equipmentVariantID" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "variantID" );
}

// Namespace class
// Params 1
// Checksum 0x73ed518a, Offset: 0x4cdf
// Size: 0x5f
function cac_getextraequipmentprimary( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 0, "extraCharge" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "extraCharge" );
}

// Namespace class
// Params 1
// Checksum 0x53c59584, Offset: 0x4d46
// Size: 0x3c
function cac_getflcextraequipmentprimary( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return 0;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 0, "flcExtraEquipment" );
}

// Namespace class
// Params 1
// Checksum 0xaf0c0e1a, Offset: 0x4d8b
// Size: 0xe2
function cac_getequipmentsecondary( classindex )
{
    self.var_648d16a68046d1b6[ #"equipmentsecondary" ] = 0;
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 1, "equipmentLootID" );
        
        if ( lootid == 0 )
        {
            return "none";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "none";
        }
        
        self.var_648d16a68046d1b6[ #"equipmentsecondary" ] = lootid;
        var_7781459233518d3c = function_d5b183532c47be35( classindex, 1, ref );
        return ( var_7781459233518d3c ?? ref );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "equipment" );
}

// Namespace class
// Params 1
// Checksum 0x95fc4356, Offset: 0x4e75
// Size: 0x61
function function_a0b11324d7722a86( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 1, "equipmentVariantID" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "variantID" );
}

// Namespace class
// Params 1
// Checksum 0x6e6ae15c, Offset: 0x4ede
// Size: 0x61
function cac_getextraequipmentsecondary( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 1, "extraCharge" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "extraCharge" );
}

// Namespace class
// Params 1
// Checksum 0xcb483486, Offset: 0x4f47
// Size: 0x41
function cac_getflcextraequipmentsecondary( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return 0;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 1, "flcExtraEquipment" );
}

// Namespace class
// Params 1
// Checksum 0x5aaba68e, Offset: 0x4f90
// Size: 0xe2
function function_9fb74ba447b5422a( classindex )
{
    self.var_648d16a68046d1b6[ #"equipmenttertiary" ] = 0;
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 2, "equipmentLootID" );
        
        if ( lootid == 0 )
        {
            return "none";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "none";
        }
        
        self.var_648d16a68046d1b6[ #"equipmenttertiary" ] = lootid;
        var_7781459233518d3c = function_d5b183532c47be35( classindex, 2, ref );
        return ( var_7781459233518d3c ?? ref );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 2, "equipment" );
}

// Namespace class
// Params 1
// Checksum 0x85f3f5d2, Offset: 0x507a
// Size: 0x61
function function_5f4a1fc6176d6416( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 2, "equipmentVariantID" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 2, "variantID" );
}

// Namespace class
// Params 1
// Checksum 0x46cdb45a, Offset: 0x50e3
// Size: 0x61
function function_1d8851306246d240( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "equipmentSetups", 2, "extraCharge" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", 2, "extraCharge" );
}

// Namespace class
// Params 2
// Checksum 0x481914f8, Offset: 0x514c
// Size: 0xef
function cac_getfieldupgrade( classindex, superindex )
{
    self.var_648d16a68046d1b6[ #"fieldupgrade" ][ superindex ] = 0;
    
    if ( level.var_be3230656ced9724 )
    {
        return "none";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "fieldUpgradeSetups", superindex, "fieldUpgradeLootID" );
        
        if ( lootid == 0 )
        {
            return "none";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( !isdefined( ref ) || ref.size == 0 )
        {
            return "none";
        }
        
        self.var_648d16a68046d1b6[ #"fieldupgrade" ][ superindex ] = lootid;
        return ref;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeSetups", superindex, "fieldUpgrade" );
}

// Namespace class
// Params 2
// Checksum 0x35b92e0b, Offset: 0x5243
// Size: 0xb5
function cac_getfieldupgradeattachments( classindex, superindex )
{
    if ( level.var_be3230656ced9724 )
    {
        return [];
    }
    
    if ( function_4d362babbfd5b4b1() && level.var_ac98e7cc4b10cb11 )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "fieldUpgradeSetups", superindex, "proContentLootID" );
        
        if ( lootid == 0 )
        {
            return [];
        }
        
        ref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", lootid ) ?? loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return [];
        }
        
        return [ ref ];
    }
    
    return [];
}

// Namespace class
// Params 2
// Checksum 0x78f13f6a, Offset: 0x5300
// Size: 0x78
function function_4dd91ac57bdf0c71( classindex, superindex )
{
    if ( level.var_be3230656ced9724 )
    {
        return 0;
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( self.loadoutdata, "loadouts", classindex, "fieldUpgradeSetups", superindex, "blueprintIndex" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeSetups", superindex, "blueprintIndex" );
}

// Namespace class
// Params 2
// Checksum 0x3f2c4a43, Offset: 0x5380
// Size: 0x41
function function_6610276bf5e32f57( classindex, superindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return 0;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeUses", superindex );
}

// Namespace class
// Params 0
// Checksum 0xae11dad6, Offset: 0x53ca
// Size: 0xa7
function cac_getgesture()
{
    gestureid = "none";
    
    if ( isdefined( level.projectbundle.gesturelist ) )
    {
        if ( isdefined( self.changedarchetypeinfo ) )
        {
            archetypeindex = level.archetypeids[ self.changedarchetypeinfo.archetype ];
            gestureid = self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypePreferences", archetypeindex, "gesture" );
        }
        else
        {
            gestureid = self getplayerdata( level.loadoutsgroup, "squadMembers", "gesture" );
        }
        
        return gestures::getgesturedata( gestureid );
    }
    
    return gestureid;
}

// Namespace class
// Params 2
// Checksum 0xd9ce6ce7, Offset: 0x547a
// Size: 0xae
function cac_getloadoutperk( classindex, perkindex )
{
    if ( !( isdefined( classindex ) && isdefined( perkindex ) ) )
    {
        return "specialty_null";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "perkLootIDs", perkindex );
        
        if ( lootid == 0 )
        {
            return "specialty_null";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "specialty_null";
        }
        
        return ref;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "loadoutPerks", perkindex );
}

// Namespace class
// Params 1
// Checksum 0x82f0651e, Offset: 0x5530
// Size: 0x7d
function function_3d3ba2b618c7313d( classindex )
{
    if ( !isdefined( classindex ) )
    {
        return "specialty_null";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "majorPerk" );
        
        if ( lootid == 0 )
        {
            return "specialty_null";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "specialty_null";
        }
        
        return ref;
    }
    
    return "specialty_null";
}

// Namespace class
// Params 2
// Checksum 0x8964b609, Offset: 0x55b6
// Size: 0x8e
function function_256fa068b5933dfd( classindex, skillindex )
{
    if ( !( isdefined( classindex ) && isdefined( skillindex ) ) )
    {
        return "specialty_null";
    }
    
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "skillLootIDs", skillindex );
        
        if ( lootid == 0 )
        {
            return "specialty_null";
        }
        
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        if ( ref.size == 0 )
        {
            return "specialty_null";
        }
        
        return ref;
    }
    
    return "specialty_null";
}

// Namespace class
// Params 1
// Checksum 0x818d5eb7, Offset: 0x564d
// Size: 0x11d
function function_321cbfe02cd247bc( packageindex )
{
    packagelist = function_ed1b512446ab1177();
    packagecount = 6;
    
    if ( isdefined( packagelist ) )
    {
        if ( getdvarint( @"hash_b8e2aa1e6fa68b8d", 0 ) )
        {
            packagecount = packagelist.packages.size;
        }
        else
        {
            packagecount = packagelist.bundlesize;
        }
    }
    
    if ( packageindex < packagecount )
    {
        return function_3ed117625f37b14a( packagelist.packages[ packageindex ].package );
    }
    else
    {
        packageindex -= packagecount;
    }
    
    perkarray = [];
    perkarray[ 0 ] = self getplayerdata( level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 0 );
    perkarray[ 1 ] = self getplayerdata( level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 1 );
    perkarray[ 2 ] = self getplayerdata( level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 2 );
    perkarray[ 3 ] = self getplayerdata( level.loadoutsgroup, "customPerkPackage", packageindex, "perks", 3 );
    return perkarray;
}

// Namespace class
// Params 1
// Checksum 0x5d594897, Offset: 0x5773
// Size: 0x2b, Type: bool
function isemptyperkpackage( perksarray )
{
    return !isdefined( perksarray[ 0 ] ) || perksarray[ 0 ] == "specialty_null" || perksarray[ 0 ] == "none";
}

// Namespace class
// Params 2
// Checksum 0x62784c2f, Offset: 0x57a7
// Size: 0x4c, Type: bool
function function_e10c10070fe641b7( perksarray, package )
{
    if ( perksarray.size != package.size )
    {
        return false;
    }
    
    for ( i = 0; i < perksarray.size ; i++ )
    {
        if ( package[ i ] != perksarray[ i ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace class
// Params 1
// Checksum 0xd4fb5b62, Offset: 0x57fc
// Size: 0xbd
function function_c7dba280a2e3e52e( perksarray )
{
    if ( isemptyperkpackage( perksarray ) )
    {
        return -1;
    }
    
    packagelist = function_ed1b512446ab1177();
    
    if ( isdefined( packagelist ) )
    {
        packagecount = packagelist.packages.size;
        
        for ( i = 0; i < packagecount ; i++ )
        {
            packagebundlename = packagelist.packages[ i ].package;
            package = function_3ed117625f37b14a( packagebundlename );
            
            if ( function_e10c10070fe641b7( perksarray, package ) )
            {
                scriptable = namespace_5ab67a14d18bea3f::function_5f9f617c656b5d34( packagebundlename );
                
                if ( isdefined( scriptable ) )
                {
                    return i;
                }
            }
        }
    }
    
    return -2;
}

// Namespace class
// Params 1
// Checksum 0xdc0e44ab, Offset: 0x58c2
// Size: 0x35
function function_f44a0914ea5bdf38( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return;
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equippedPerkPackageIndex" );
}

// Namespace class
// Params 2
// Checksum 0xea8df91d, Offset: 0x5900
// Size: 0x45
function cac_getloadoutextraperk( classindex, perkindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return "specialty_null";
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "extraPerks", perkindex );
}

// Namespace class
// Params 2
// Checksum 0x3b20e439, Offset: 0x594e
// Size: 0x45
function function_57e20038d70fdb33( classindex, perkindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        return "specialty_null";
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "flcPerks", perkindex );
}

// Namespace class
// Params 0
// Checksum 0x4332c852, Offset: 0x599c
// Size: 0x89
function cac_getloadoutarchetypeperk()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        return self.changedarchetypeinfo.trait;
    }
    
    if ( level.projectbundle.var_786bc1b37b3f67fa && ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec ) )
    {
        return "specialty_null";
    }
    
    return self getplayerdata( level.loadoutsgroup, "squadMembers", "archetypePerk" );
}

// Namespace class
// Params 0
// Checksum 0xfb07b65a, Offset: 0x5a2d
// Size: 0x123
function function_ed1b512446ab1177()
{
    var_1246e61a33539b25 = getdvarint( @"hash_a0ade898bfc7ab0e", 0 ) != 0;
    bundlename = "perkpackagelist_iw9";
    
    /#
        var_1501548c0e22c19c = 6;
    #/
    
    if ( level.leagueplaymatch )
    {
        bundlename = "ranked_perkpackagelist_iw9";
        
        /#
            var_1501548c0e22c19c = 3;
        #/
    }
    else if ( isbrgamemode() )
    {
        bundlename = "perkpackagelist_wz";
        
        /#
            var_1501548c0e22c19c = 14;
        #/
    }
    
    packagesstruct = getscriptbundle( "perkpackagelist:" + bundlename );
    packagesstruct.bundlesize = packagesstruct.packages.size;
    
    for ( i = packagesstruct.packages.size - 1; i >= 0 ; i-- )
    {
        if ( !isdefined( packagesstruct.packages[ i ].package ) )
        {
            packagesstruct.packages[ i ] = undefined;
        }
    }
    
    /#
        if ( isdefined( var_1501548c0e22c19c ) && packagesstruct.bundlesize != var_1501548c0e22c19c )
        {
            assertmsg( "<dev string:xe3>" );
            script::demoforcesre( "<dev string:xe3>" );
        }
    #/
    
    return packagesstruct;
}

// Namespace class
// Params 1
// Checksum 0x73fba622, Offset: 0x5b59
// Size: 0x5a
function cac_getusingspecialist( classindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        wildcard = function_be7cee2ec3dda47a( classindex );
        return ( wildcard == "wildcard_perkstreak" ? 1 : 0 );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "usingSpecialist" );
}

// Namespace class
// Params 1
// Checksum 0x40da80b8, Offset: 0x5bbc
// Size: 0x3d
function function_9e833ec629866afb( lootid )
{
    if ( lootid == 0 )
    {
        return "charm_none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( ref.size == 0 )
    {
        return "charm_none";
    }
    
    return ref;
}

// Namespace class
// Params 2
// Checksum 0xddabc33e, Offset: 0x5c02
// Size: 0x7a
function cac_getweaponcosmeticattachment( classindex, weaponindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachmentLootID" );
        return function_9e833ec629866afb( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment" );
}

// Namespace class
// Params 1
// Checksum 0x37cb46e1, Offset: 0x5c85
// Size: 0x3d
function function_3b5cd530636d604a( lootid )
{
    if ( lootid == 0 )
    {
        return "sticker_none";
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( ref.size == 0 )
    {
        return "sticker_none";
    }
    
    return ref;
}

// Namespace class
// Params 3
// Checksum 0xc300cfd9, Offset: 0x5ccb
// Size: 0x87
function cac_getweaponsticker( classindex, weaponindex, stickerindex )
{
    if ( function_4d362babbfd5b4b1() )
    {
        lootid = self getplayerdata( self.loadoutdata, "loadouts", classindex, "weaponSetups", weaponindex, "stickerLootIDs", stickerindex );
        return function_3b5cd530636d604a( lootid );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "sticker", stickerindex );
}

// Namespace class
// Params 1
// Checksum 0x2d1cd54d, Offset: 0x5d5b
// Size: 0x85
function function_f1f2a5135fbe83f( weaponindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "weaponSetups", weaponindex, "progress" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "weaponSetups", weaponindex, "progress" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "weaponSetups", weaponindex, "progress" );
}

// Namespace class
// Params 1
// Checksum 0x8e40b264, Offset: 0x5de9
// Size: 0x85
function function_a9a5ba5a2745dd58( weaponindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "weaponSetups", weaponindex, "isDiamond" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "weaponSetups", weaponindex, "isDiamond" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "weaponSetups", weaponindex, "isDiamond" );
}

// Namespace class
// Params 1
// Checksum 0xd1041ff0, Offset: 0x5e77
// Size: 0x85
function function_7ea65ab64d45951b( equipmentindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "progress" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "progress" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "progress" );
}

// Namespace class
// Params 1
// Checksum 0x65f4e479, Offset: 0x5f05
// Size: 0x85
function function_4fe1d5b1ce437c8c( equipmentindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "isDiamond" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "isDiamond" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "equipmentSetups", equipmentindex, "isDiamond" );
}

// Namespace class
// Params 1
// Checksum 0x314c9421, Offset: 0x5f93
// Size: 0x85
function function_1e986bb80d3f2f3( fieldupgradeindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "progress" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "progress" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "progress" );
}

// Namespace class
// Params 1
// Checksum 0x13e7d11d, Offset: 0x6021
// Size: 0x85
function function_2e6bde4694e5bc14( fieldupgradeindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "isDiamond" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "isDiamond" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "fieldUpgradeSetups", fieldupgradeindex, "isDiamond" );
}

// Namespace class
// Params 1
// Checksum 0xf2763051, Offset: 0x60af
// Size: 0x85
function function_f792e49976e43075( streakindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "killstreakSetups", streakindex, "progress" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "killstreakSetups", streakindex, "progress" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "killstreakSetups", streakindex, "progress" );
}

// Namespace class
// Params 1
// Checksum 0xdddd333, Offset: 0x613d
// Size: 0x85
function function_b906cc74d1c29a7e( streakindex )
{
    if ( function_2951ee8f6b75caad() )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, "selectedLoadoutMastery", "killstreakSetups", streakindex, "isDiamond" );
    }
    else if ( function_4d362babbfd5b4b1() )
    {
        return self getplayerdata( level.loadoutdata, "selectedLoadoutMastery", "killstreakSetups", streakindex, "isDiamond" );
    }
    
    return self getplayerdata( level.loadoutdata, "squadMembers", "selectedLoadoutMastery", "killstreakSetups", streakindex, "isDiamond" );
}

// Namespace class
// Params 3
// Checksum 0xcd384ef0, Offset: 0x61cb
// Size: 0x3d
function recipe_getkillstreak( classteam, classindex, streakindex )
{
    return game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "kilstreakSetups", streakindex, "killstreak" );
}

// Namespace class
// Params 2
// Checksum 0xf721661d, Offset: 0x6211
// Size: 0x65
function function_2ed2b8bcdb9e828( player, classtype )
{
    if ( player.var_9404f68c3560db )
    {
        return 1;
    }
    
    if ( classtype == "juggernaut" )
    {
        return 0;
    }
    
    enabledefault = player getplayerdata( level.var_6f9b00680ed002d8, "enableDefaultDMZLoadouts" );
    
    if ( level.var_ce6a3d4f3b628e3a )
    {
        enabledefault = 1;
    }
    
    return enabledefault;
}

// Namespace class
// Params 2
// Checksum 0xceb9e82, Offset: 0x627f
// Size: 0x2c
function function_c8af2f6f0e6e684( player, enabled )
{
    player setplayerdata( level.var_6f9b00680ed002d8, "enableDefaultDMZLoadouts", enabled );
}

// Namespace class
// Params 1
// Checksum 0x21542c69, Offset: 0x62b3
// Size: 0xb2
function table_gettable( tablename )
{
    if ( !isdefined( level.cachedclasstable ) || isdefined( tablename ) && level.cachedclasstable.id != tablename )
    {
        level.cachedclasstable = spawnstruct();
        level.cachedclasstable.id = tablename;
        level.cachedclasstable.classes = [];
        level.cachedclasstable.classtable = getscriptbundle( tablename );
        assert( isdefined( level.cachedclasstable.classtable ) );
    }
    
    return level.cachedclasstable;
}

// Namespace class
// Params 2
// Checksum 0x2cca7c5e, Offset: 0x636e
// Size: 0x1fe
function table_getitem( tablename, classindex )
{
    cachedclasstable = table_gettable( tablename );
    
    if ( cachedclasstable.classes[ classindex ] )
    {
        return cachedclasstable.classes[ classindex ];
    }
    
    if ( classindex >= cachedclasstable.classtable.classlist.size )
    {
        classindex = 0;
    }
    
    if ( !isdefined( cachedclasstable.classes[ classindex ] ) )
    {
        classtableentry = cachedclasstable.classtable.classlist[ classindex ];
        
        if ( !isdefined( classtableentry.entry ) )
        {
            var_17c159b66ed80e4 = getxhashhexname( tablename ?? #"hash_6dbbf42744237118" );
            
            /#
                var_17c159b66ed80e4 = getxhashsourcename( tablename );
            #/
            
            var_b33cdecbc552c9a5 = "class::table_getItem() -" + ( !isdefined( classtableentry ) ? " The classTableEntry value is UNDEFINED" : "" ) + ( !isdefined( classtableentry.entry ) ? " The .entry field of the retrieved classTableEntry is UNDEFINED" : "" ) + " given the specified/retrieved table data:" + "\n - tableName: " + ( var_17c159b66ed80e4 ?? "UNDEFINED" ) + "\n - classIndex: " + ( classindex ?? "UNDEFINED" ) + "\n - cachedClassTable.classList.size: " + ( isdefined( cachedclasstable ) ? cachedclasstable.classtable.classlist.size : "" ) + "\n - cachedClassTable.classList[0].entry: " + ( isdefined( cachedclasstable ) && cachedclasstable.classtable.classlist.size > 0 ? cachedclasstable.classtable.classlist[ 0 ].entry : "" );
            script::demoforcesre( var_b33cdecbc552c9a5 );
            return;
        }
        
        cachedclasstable.classes[ classindex ] = getscriptbundle( hashcat( %"classtableentry:", classtableentry.entry ) );
    }
    
    return cachedclasstable.classes[ classindex ];
}

// Namespace class
// Params 1
// Checksum 0x5efde54f, Offset: 0x6575
// Size: 0x36
function function_868832c7872f848e( tablename )
{
    cachedclasstable = table_gettable( tablename );
    return cachedclasstable.classtable.classlist.size;
}

// Namespace class
// Params 3
// Checksum 0x2439df49, Offset: 0x65b4
// Size: 0x78
function function_1e4f9b4322db4414( tablename, classindex, weaponindex )
{
    weaponinfo = table_getitem( tablename, classindex );
    
    switch ( weaponindex )
    {
        case 0:
            return weaponinfo.primaryweapon;
        case 1:
            return weaponinfo.secondaryweapon;
    }
    
    return weaponinfo.tertiaryWeapon;
}

// Namespace class
// Params 3
// Checksum 0x4df423aa, Offset: 0x6635
// Size: 0x4c
function table_getweapon( tablename, classindex, weaponindex )
{
    weapon = function_1e4f9b4322db4414( tablename, classindex, weaponindex ).weapon;
    
    if ( !isdefined( weapon ) )
    {
        weapon = "none";
    }
    
    return weapon;
}

// Namespace class
// Params 2
// Checksum 0xc83256e9, Offset: 0x668a
// Size: 0x289
function table_getweaponattachments( classstruct, weaponindex )
{
    if ( isdefined( classstruct.primaryweapon ) && !isdefined( classstruct.primaryweapon.attachments ) )
    {
        weap = classstruct.primaryweapon;
        classstruct.primaryweapon.attachments = [ weap.attachment1, weap.attachment2, weap.attachment3, weap.attachment4, weap.attachment5, weap.attachment6, weap.attachment7, weap.attachment8 ];
    }
    
    if ( isdefined( classstruct.secondaryweapon ) && !isdefined( classstruct.secondaryweapon.attachments ) )
    {
        weap = classstruct.secondaryweapon;
        classstruct.secondaryweapon.attachments = [ weap.attachment1, weap.attachment2, weap.attachment3, weap.attachment4, weap.attachment5, weap.attachment6 ];
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        if ( isdefined( classstruct.tertiaryWeapon ) && !isdefined( classstruct.tertiaryWeapon.attachments ) )
        {
            weap = classstruct.tertiaryWeapon;
            classstruct.tertiaryWeapon.attachments = [ weap.attachment1, weap.attachment2, weap.attachment3, weap.attachment4, weap.attachment5 ];
        }
    }
    
    if ( weaponindex == 0 )
    {
        return classstruct.primaryweapon.attachments;
    }
    
    if ( weaponindex == 1 )
    {
        return classstruct.secondaryweapon.attachments;
    }
    
    return classstruct.tertiaryWeapon.attachments;
}

// Namespace class
// Params 4
// Checksum 0xedd0e51b, Offset: 0x691b
// Size: 0x78
function table_getweaponattachment( tablename, classindex, weaponindex, attachmentindex )
{
    classstruct = table_getitem( tablename, classindex );
    weaponattachments = table_getweaponattachments( classstruct, weaponindex );
    attachmentname = weaponattachments[ attachmentindex ];
    
    if ( !isdefined( attachmentname ) || attachmentname == "" )
    {
        return "none";
    }
    
    return attachmentname;
}

// Namespace class
// Params 3
// Checksum 0x21bf204b, Offset: 0x699c
// Size: 0x32
function table_getweaponcamo( tablename, classindex, weaponindex )
{
    return function_1e4f9b4322db4414( tablename, classindex, weaponindex ).camo;
}

// Namespace class
// Params 3
// Checksum 0xc698fb46, Offset: 0x69d7
// Size: 0x32
function table_getweaponreticle( tablename, classindex, weaponindex )
{
    return function_1e4f9b4322db4414( tablename, classindex, weaponindex ).reticle;
}

// Namespace class
// Params 5
// Checksum 0xec997873, Offset: 0x6a12
// Size: 0x140
function table_getweaponvariantid( tablename, classindex, weaponindex, rootweapon, norandom )
{
    weapon = function_1e4f9b4322db4414( tablename, classindex, weaponindex );
    
    if ( isdefined( weapon.blueprintweapon ) )
    {
        weaponasset = undefined;
        
        if ( isdefined( level.weaponmapdata[ rootweapon ] ) )
        {
            weaponasset = level.weaponmapdata[ rootweapon ].assetname;
        }
        
        if ( isdefined( weaponasset ) )
        {
            weaponvariants = getweaponblueprintnames( weaponasset );
            
            foreach ( variant, id in weaponvariants )
            {
                if ( weapon.blueprintweapon == variant )
                {
                    return table_parseweaponvariantidvalue( rootweapon, id, norandom );
                }
            }
        }
    }
    
    svariantid = weapon.variantid;
    return table_parseweaponvariantidvalue( rootweapon, svariantid, norandom );
}

// Namespace class
// Params 3
// Checksum 0xcef23963, Offset: 0x6b5b
// Size: 0x2c4
function table_parseweaponvariantidvalue( rootweapon, value, norandom )
{
    if ( rootweapon == "none" )
    {
        return 0;
    }
    
    if ( !isdefined( level.blockedvariantidsmap ) )
    {
        level.blockedvariantidsmap = [];
        var_5f53140b369e7180 = getdvar( @"hash_4caa11caeebf587b", "" );
        
        if ( var_5f53140b369e7180 != "" )
        {
            var_e57bafa6482d1b7f = strtok( var_5f53140b369e7180, "," );
            
            foreach ( weaponvariant in var_e57bafa6482d1b7f )
            {
                pair = strtok( weaponvariant, "|" );
                
                if ( pair.size == 2 )
                {
                    weaponblock = pair[ 0 ];
                    idblock = int( pair[ 1 ] );
                    
                    if ( !isdefined( level.blockedvariantidsmap[ weaponblock ] ) )
                    {
                        level.blockedvariantidsmap[ weaponblock ] = [];
                    }
                    
                    level.blockedvariantidsmap[ weaponblock ][ level.blockedvariantidsmap[ weaponblock ].size ] = idblock;
                }
            }
        }
    }
    
    blockedids = undefined;
    
    if ( isdefined( level.blockedvariantidsmap[ rootweapon ] ) )
    {
        blockedids = level.blockedvariantidsmap[ rootweapon ];
    }
    
    variantid = 0;
    allowrandom = !norandom;
    forcerandom = allowrandom && getdvarint( @"hash_c895ae760d4177d4", 0 );
    
    if ( forcerandom == 1 )
    {
        variantid = weapon::getweaponrandomvariantid( rootweapon, blockedids );
    }
    else
    {
        var_89033abf5b28266d = strtok( value, " " );
        variantids = [];
        
        foreach ( sid in var_89033abf5b28266d )
        {
            iid = int( sid );
            
            if ( !isdefined( blockedids ) || !arraycontains( blockedids, iid ) )
            {
                variantids[ variantids.size ] = iid;
            }
        }
        
        if ( variantids.size != 0 )
        {
            if ( allowrandom )
            {
                variantid = variantids[ randomint( variantids.size ) ];
            }
            else
            {
                variantid = variantids[ 0 ];
            }
        }
    }
    
    if ( variantid == -1 )
    {
        if ( allowrandom )
        {
            variantid = weapon::getweaponrandomvariantid( rootweapon, blockedids );
        }
        else
        {
            variantid = 0;
        }
    }
    
    return variantid;
}

// Namespace class
// Params 3
// Checksum 0x82169777, Offset: 0x6e28
// Size: 0x115
function table_getperk( tablename, classindex, perkindex )
{
    assert( perkindex <= ( level.gamemodebundle.var_88172641641648e1 ?? 3 ) );
    classstruct = table_getitem( tablename, classindex );
    
    if ( !isdefined( classstruct.perksarray ) )
    {
        classstruct.perksarray = [ classstruct.perks.perk1, classstruct.perks.perk2, classstruct.perks.perk3, classstruct.perks.perk4, classstruct.perks.perk5, classstruct.perks.perk6 ];
    }
    
    return classstruct.perksarray[ perkindex ];
}

// Namespace class
// Params 2
// Checksum 0xf378334, Offset: 0x6f46
// Size: 0x28
function function_f5ceaf83aec79f3a( tablename, classindex )
{
    return table_getitem( tablename, classindex ).majorperk;
}

// Namespace class
// Params 2
// Checksum 0xc6a8743a, Offset: 0x6f77
// Size: 0xc7
function function_b4da613a244ba2fb( tablename, classindex )
{
    operatorskills = [];
    classskills = table_getitem( tablename, classindex ).skills;
    
    if ( isdefined( classskills ) && classskills.size > 0 )
    {
        foreach ( skill in classskills )
        {
            operatorskills[ operatorskills.size ] = skill;
        }
    }
    
    if ( operatorskills.size > 0 )
    {
        return operatorskills;
    }
}

// Namespace class
// Params 2
// Checksum 0x1b31ae6b, Offset: 0x7047
// Size: 0x43
function table_getperkpackage( tablename, classindex )
{
    perkpackagename = table_getitem( tablename, classindex ).perkpackage;
    
    if ( isdefined( perkpackagename ) )
    {
        return function_3ed117625f37b14a( perkpackagename );
    }
}

// Namespace class
// Params 3
// Checksum 0xf276d8a2, Offset: 0x7093
// Size: 0xb4
function table_getextraperk( tablename, classindex, perkindex )
{
    assert( perkindex <= 3 );
    classstruct = table_getitem( tablename, classindex );
    
    if ( !isdefined( classstruct.extraperksarray ) )
    {
        classstruct.extraperksarray = [ classstruct.extraperks.perk1, classstruct.extraperks.perk2, classstruct.extraperks.perk3 ];
    }
    
    return classstruct.extraperksarray[ perkindex ];
}

// Namespace class
// Params 3
// Checksum 0xe28d6a02, Offset: 0x7150
// Size: 0x118
function function_237fdae48e47e8fc( tablename, classindex, perkindex )
{
    assert( perkindex <= 5 );
    classstruct = table_getitem( tablename, classindex );
    
    if ( !isdefined( classstruct.var_84ba0951ad72fec7 ) )
    {
        classstruct.var_84ba0951ad72fec7 = [ classstruct.flcPerks.perk1, classstruct.flcPerks.perk2, classstruct.flcPerks.perk3, classstruct.flcPerks.perk4, classstruct.flcPerks.perk5, classstruct.flcPerks.perk6, classstruct.flcPerks.perk7 ];
    }
    
    return classstruct.var_84ba0951ad72fec7[ perkindex ];
}

// Namespace class
// Params 2
// Checksum 0x19cbe398, Offset: 0x7271
// Size: 0x32
function table_getequipmentprimary( tablename, classindex )
{
    return table_getitem( tablename, classindex ).equipment.primary;
}

// Namespace class
// Params 2
// Checksum 0x4e43ccd6, Offset: 0x72ac
// Size: 0x80
function table_getequipmentprimaryattachments( tablename, classindex )
{
    attachments = [];
    
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return attachments;
    }
    
    var_3e66143142a96449 = table_getitem( tablename, classindex ).equipment;
    attachment1 = var_3e66143142a96449.var_7d9865ad66c66afc ?? "none";
    
    if ( attachment1 != "none" )
    {
        attachments[ attachments.size ] = attachment1;
    }
    
    return attachments;
}

// Namespace class
// Params 2
// Checksum 0x168048d4, Offset: 0x7335
// Size: 0x43, Type: bool
function table_getextraequipmentprimary( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).extrapower.primary;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0x64c5ff60, Offset: 0x7381
// Size: 0x43, Type: bool
function table_getflcextraequipmentprimary( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).flcExtraEquipment.primary;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0x21019046, Offset: 0x73cd
// Size: 0x32
function table_getequipmentsecondary( tablename, classindex )
{
    return table_getitem( tablename, classindex ).equipment.secondary;
}

// Namespace class
// Params 2
// Checksum 0xee402a96, Offset: 0x7408
// Size: 0x80
function table_getequipmentsecondaryattachments( tablename, classindex )
{
    attachments = [];
    
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return attachments;
    }
    
    var_3e66143142a96449 = table_getitem( tablename, classindex ).equipment;
    attachment1 = var_3e66143142a96449.var_e4a636a89c7c832c ?? "none";
    
    if ( attachment1 != "none" )
    {
        attachments[ attachments.size ] = attachment1;
    }
    
    return attachments;
}

// Namespace class
// Params 2
// Checksum 0x50714af6, Offset: 0x7491
// Size: 0x43, Type: bool
function table_getextraequipmentsecondary( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).extrapower.secondary;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0xc9451799, Offset: 0x74dd
// Size: 0x43, Type: bool
function table_getflcextraequipmentsecondary( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).flcExtraEquipment.secondary;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0x278967dd, Offset: 0x7529
// Size: 0x32
function function_aae501d9b54400d9( tablename, classindex )
{
    return table_getitem( tablename, classindex ).equipment.tertiary;
}

// Namespace class
// Params 2
// Checksum 0x2bbbfb5f, Offset: 0x7564
// Size: 0x80
function function_57f521192747393d( tablename, classindex )
{
    attachments = [];
    
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return attachments;
    }
    
    var_3e66143142a96449 = table_getitem( tablename, classindex ).equipment;
    attachment1 = var_3e66143142a96449.var_984a1eaffe37e60c ?? "none";
    
    if ( attachment1 != "none" )
    {
        attachments[ attachments.size ] = attachment1;
    }
    
    return attachments;
}

// Namespace class
// Params 2
// Checksum 0xb6b2249b, Offset: 0x75ed
// Size: 0x43, Type: bool
function function_4061d408e63f77f5( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).extrapower.tertiary;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0xfb5b3156, Offset: 0x7639
// Size: 0x28
function function_4134f54d889a409a( tablename, classindex )
{
    return table_getitem( tablename, classindex ).operatorwest;
}

// Namespace class
// Params 2
// Checksum 0xfb5b3156, Offset: 0x766a
// Size: 0x28
function function_6d91728f8b3e3960( tablename, classindex )
{
    return table_getitem( tablename, classindex ).operatoreast;
}

// Namespace class
// Params 3
// Checksum 0xa98750ae, Offset: 0x769b
// Size: 0x88
function table_getsuper( tablename, classindex, index )
{
    classstruct = table_getitem( tablename, classindex );
    
    if ( !isdefined( classstruct ) )
    {
        return;
    }
    
    classstruct.fieldupgradearray = [ classstruct.fieldUpgrades.fieldupgrade1, classstruct.fieldUpgrades.fieldupgrade2 ];
    return classstruct.fieldupgradearray[ index ];
}

// Namespace class
// Params 3
// Checksum 0x4817724c, Offset: 0x772c
// Size: 0xb7
function table_getsuperattachments( tablename, classindex, index )
{
    attachments = [];
    
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return attachments;
    }
    
    var_3e66143142a96449 = table_getitem( tablename, classindex ).fieldUpgrades;
    attachment1 = "none";
    
    if ( index == 0 )
    {
        attachment1 = var_3e66143142a96449.var_444c364249ef2a7b ?? "none";
    }
    else if ( index == 1 )
    {
        attachment1 = var_3e66143142a96449.var_947d47a293ec8828 ?? "none";
    }
    
    if ( attachment1 != "none" )
    {
        attachments[ attachments.size ] = attachment1;
    }
    
    return attachments;
}

// Namespace class
// Params 2
// Checksum 0x8c774a74, Offset: 0x77ec
// Size: 0x36
function function_65fbd50b1b899df7( table, index )
{
    return getscriptbundle( table_getitem( table, index ).killstreak.streaktype );
}

// Namespace class
// Params 3
// Checksum 0x6a2575e2, Offset: 0x782b
// Size: 0x9f
function function_174dc1fa6552b3( tablename, classindex, index )
{
    classstruct = table_getitem( tablename, classindex );
    classstruct.killstreakarray = [ classstruct.killstreak.killstreak1, classstruct.killstreak.killstreak2, classstruct.killstreak.killstreak3 ];
    return loot::function_f54ecb89dfab8e8c( classstruct.killstreakarray[ index ] );
}

// Namespace class
// Params 3
// Checksum 0xb9503a24, Offset: 0x78d3
// Size: 0x80
function function_8811f1fcd6faca58( tablename, classindex, index )
{
    classstruct = table_getitem( tablename, classindex );
    classstruct.var_b08cb05a2253135f = [ classstruct.var_37556274d6e08609.fieldupgrade1, classstruct.var_37556274d6e08609.fieldupgrade2 ];
    return classstruct.var_b08cb05a2253135f[ index ];
}

// Namespace class
// Params 2
// Checksum 0xdcd6fcec, Offset: 0x795c
// Size: 0x39, Type: bool
function table_getspecialist( tablename, classindex )
{
    value = table_getitem( tablename, classindex ).specialist;
    return value == 1;
}

// Namespace class
// Params 2
// Checksum 0x6640e5c4, Offset: 0x799e
// Size: 0x28
function table_getgesture( tablename, classindex )
{
    return table_getitem( tablename, classindex ).gesture;
}

// Namespace class
// Params 2
// Checksum 0xaf052c0a, Offset: 0x79cf
// Size: 0x28
function table_getexecution( tablename, classindex )
{
    return table_getitem( tablename, classindex ).execution;
}

// Namespace class
// Params 2
// Checksum 0xd3337b07, Offset: 0x7a00
// Size: 0x4a
function function_6e209ed6e2db2b0b( tablename, classindex )
{
    if ( !level.gamemodebundle.var_2cb40e0296514a72 )
    {
        return;
    }
    
    return table_getitem( tablename, classindex ).wildcard.wildcard;
}

// Namespace class
// Params 2
// Checksum 0xbe5fbf31, Offset: 0x7a53
// Size: 0x28
function function_f261720ab677a2a9( tablename, classindex )
{
    return table_getitem( tablename, classindex ).backpackitems;
}

// Namespace class
// Params 1
// Checksum 0x794b1a81, Offset: 0x7a84
// Size: 0xa7
function loadout_getplayerstreaktype( loadoutstreaktype )
{
    if ( level.gamemodebundle.streaktypeenabled )
    {
        return killstreaks::getstreaktype();
    }
    
    assert( isdefined( loadoutstreaktype ), "<dev string:x138>" );
    result = undefined;
    
    switch ( loadoutstreaktype )
    {
        case #"hash_e23522b86eb526c3":
            result = "support";
            break;
        case #"hash_946bfb43e361a475":
            result = "specialist";
            break;
        case #"hash_84b8b53bd4ec32c0":
            result = "resource";
            break;
        default:
            result = "assault";
            break;
    }
    
    return result;
}

// Namespace class
// Params 1
// Checksum 0xc49e7284, Offset: 0x7b34
// Size: 0x9e
function function_3ed117625f37b14a( bundlename )
{
    perkpackagebundle = getscriptbundle( "perkpackage:" + bundlename );
    perkpackage = [ 4 ];
    perkpackage[ 0 ] = perkpackagebundle.perks.baseperk1;
    perkpackage[ 1 ] = perkpackagebundle.perks.baseperk2;
    perkpackage[ 2 ] = perkpackagebundle.perks.bonusperk;
    perkpackage[ 3 ] = perkpackagebundle.perks.ultimateperk;
    return perkpackage;
}

// Namespace class
// Params 1
// Checksum 0xf1292e49, Offset: 0x7bdb
// Size: 0x86
function getloadoutstreaktypefromstreaktype( streaktype )
{
    if ( !isdefined( streaktype ) )
    {
        assertmsg( "<dev string:x18f>" );
        return "streaktype_assault";
    }
    
    switch ( streaktype )
    {
        case #"hash_605929bc0f7f95c8":
            return "streaktype_support";
        case #"hash_2bee0bf604b15c84":
            return "streaktype_specialist";
        case #"hash_d4f05e450448c3ec":
            return "streaktype_assault";
        default:
            assert( 0, "<dev string:x1d5>" );
            return "streaktype_assault";
    }
}

// Namespace class
// Params 1
// Checksum 0x5d77cc0f, Offset: 0x7c69
// Size: 0x63
function loadout_getclassteam( class )
{
    if ( !isdefined( self.team ) || self.team == "spectator" )
    {
        return "none";
    }
    
    if ( issubstr( class, "axis" ) )
    {
        return "axis";
    }
    else if ( issubstr( class, "allies" ) )
    {
        return "allies";
    }
    
    return "none";
}

// Namespace class
// Params 3
// Checksum 0xee98dc73, Offset: 0x7cd5
// Size: 0xae
function loadout_clearplayer( var_cdccaae2e6a4aa0, var_9edcca6343f41f5b, options )
{
    loadout_clearweapons( var_cdccaae2e6a4aa0 );
    _detachall( var_cdccaae2e6a4aa0 );
    
    if ( !options.var_982fa733d18d80c )
    {
        equipment_mp::clearallequipment( var_9edcca6343f41f5b );
    }
    
    if ( isdefined( self.loadoutarchetype ) )
    {
        clearscriptable();
    }
    
    if ( !options.var_dc70254216f48951 )
    {
        loadout_clearperks( var_cdccaae2e6a4aa0 );
    }
    
    gestures::cleargesture();
    
    if ( !options.keepexecution )
    {
        execution::_clearexecution();
    }
    
    perkpackage::perkpackage_resetoverridefieldupgrades();
    
    if ( !var_cdccaae2e6a4aa0 )
    {
        resetfunctionality( options );
        resetactionslots();
    }
}

// Namespace class
// Params 1
// Checksum 0xaa19a854, Offset: 0x7d8b
// Size: 0x152
function loadout_clearweapons( var_cdccaae2e6a4aa0 )
{
    var_7f69ceb7ad2070c1 = istrue( level.var_9f50122980b82252 );
    
    if ( var_cdccaae2e6a4aa0 && !var_7f69ceb7ad2070c1 )
    {
        if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            item_weapon::function_e762c26370fb8ad2( 1 );
        }
        else
        {
            if ( isdefined( self.primaryweaponobj ) && self.primaryweaponobj.basename != "none" )
            {
                inventory_utility::_takeweapon( self.primaryweaponobj );
            }
            
            if ( isdefined( self.secondaryweaponobj ) && self.secondaryweaponobj.basename != "none" )
            {
                inventory_utility::_takeweapon( self.secondaryweaponobj );
            }
            
            if ( isdefined( self.var_cc1262e66dbb1c79 ) && self.var_cc1262e66dbb1c79.basename != "none" )
            {
                inventory_utility::_takeweapon( self.var_cc1262e66dbb1c79 );
            }
        }
    }
    else
    {
        self takeallweapons();
    }
    
    self.primaryweapon = undefined;
    self.primaryweaponobj = undefined;
    self.secondaryweapon = undefined;
    self.secondaryweaponobj = undefined;
    self.tertiaryWeapon = undefined;
    self.var_cc1262e66dbb1c79 = undefined;
    gameplay_telemetry::function_3e91d2222fa2419f( 0, 1 );
}

// Namespace class
// Params 1
// Checksum 0xecdbd69c, Offset: 0x7ee5
// Size: 0x42
function loadout_giveperk( perkname )
{
    if ( !isdefined( self.loadoutperks ) )
    {
        self.loadoutperks = [];
    }
    
    perk::giveperk( perkname );
    self.loadoutperks[ self.loadoutperks.size ] = perkname;
}

// Namespace class
// Params 1
// Checksum 0x231d0b42, Offset: 0x7f2f
// Size: 0xce
function loadout_removeperk( perkname )
{
    if ( isdefined( self.loadoutperks ) )
    {
        perkremoved = 0;
        var_97064cb1b176c426 = [];
        
        foreach ( _perkname in self.loadoutperks )
        {
            if ( !perkremoved )
            {
                if ( _perkname == perkname )
                {
                    perk::removeperk( _perkname );
                    perkremoved = 1;
                    continue;
                }
            }
            
            var_97064cb1b176c426[ var_97064cb1b176c426.size ] = _perkname;
        }
        
        self.loadoutperks = var_97064cb1b176c426;
    }
}

// Namespace class
// Params 1
// Checksum 0x2350564a, Offset: 0x8005
// Size: 0x19d
function loadout_clearperks( var_cdccaae2e6a4aa0 )
{
    if ( getdvarint( @"hash_6a4d5cd30c97a609", 0 ) )
    {
        assertmsg( "<dev string:x219>" );
    }
    
    perks::function_aa47e658394516c1();
    
    if ( var_cdccaae2e6a4aa0 )
    {
        if ( isdefined( self.loadoutperks ) && !self.perkscleared )
        {
            foreach ( perkname in self.loadoutperks )
            {
                perk::removeperk( perkname );
            }
        }
    }
    else
    {
        perks::_clearperks();
        self notify( #"hash_acbc7ab957079995" );
    }
    
    if ( getdvarint( @"hash_6a4d5cd30c97a609", 0 ) )
    {
        logstring( "\n PERKS BUG LOGGING - After clear, player has " + self.perks.size + " perks." );
        
        foreach ( idx, perk in self.perks )
        {
            logstring( "\n" + idx );
        }
    }
    
    self.loadoutperks = [];
    self notify( #"loadout_perks_cleared" );
}

// Namespace class
// Params 0, eflags: 0x4
// Checksum 0xbd1afe71, Offset: 0x81aa
// Size: 0x706
function private function_78bef2fe4565d594()
{
    struct = {};
    struct.loadoutarchetype = "none";
    struct.loadoutprimary = "none";
    struct.loadoutprimaryattachments = [];
    struct.loadoutprimaryattachmentids = [];
    struct.var_277379f78fc833f4 = [];
    maxprimaryattachments = weapon::function_45ab75ece154ca8f();
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        struct.loadoutprimaryattachments[ attachmentindex ] = "none";
        struct.loadoutprimaryattachmentids[ attachmentindex ] = 0;
    }
    
    struct.loadoutprimarycamo = "camo_none";
    struct.var_69ae546f481034e2 = getxhashasset( "none" );
    struct.loadoutprimaryreticle = "none";
    struct.loadoutprimarylootitemid = 0;
    struct.loadoutprimaryvariantid = -1;
    struct.loadoutprimarycosmeticattachment = "charm_none";
    struct.var_bf06b7def8985709 = 0;
    struct.loadoutprimarystickers = [];
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutprimarystickers[ stickerindex ] = "sticker_none";
    }
    
    struct.loadoutsecondary = "none";
    struct.loadoutsecondaryattachments = [];
    struct.loadoutsecondaryattachmentids = [];
    struct.var_b93fbd33bb0d0a2c = [];
    maxsecondaryattachments = weapon::function_a7a39da0cf2d5b5b();
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = "none";
        struct.loadoutsecondaryattachmentids[ attachmentindex ] = 0;
    }
    
    struct.loadoutsecondarycamo = "camo_none";
    struct.var_2bab3f4f3d38584a = getxhashasset( "none" );
    struct.loadoutsecondaryreticle = "none";
    struct.loadoutsecondarylootitemid = 0;
    struct.loadoutsecondaryvariantid = -1;
    struct.loadoutsecondarycosmeticattachment = "charm_none";
    struct.var_8d1ed34c7709f241 = 0;
    struct.loadoutsecondarystickers = [];
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutsecondarystickers[ stickerindex ] = "sticker_none";
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        struct.loadouttertiary = "none";
        struct.var_c6ea1bb7cfd9e16e = [];
        struct.var_d957b896dcfa75ed = [];
        struct.var_50da18834547334c = [];
        var_dc1543b984237bf8 = weapon::function_bedf9f9cfa13920d();
        
        for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
        {
            struct.var_c6ea1bb7cfd9e16e[ attachmentindex ] = "none";
            struct.var_d957b896dcfa75ed[ attachmentindex ] = 0;
        }
        
        struct.loadouttertiarycamo = "camo_none";
        struct.loadouttertiaryreticle = "none";
        struct.var_ed9b3d4420e4e620 = 0;
        struct.loadouttertiaryvariantid = -1;
        struct.var_c3c185cb12ccad46 = "charm_none";
        struct.var_ea6fecf8edebaf61 = 0;
        struct.var_6f4ac9993a146618 = [];
        
        for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
        {
            struct.var_6f4ac9993a146618[ stickerindex ] = "sticker_none";
        }
    }
    
    struct.loadoutperksfromgamemode = 0;
    struct.loadoutperks = [];
    struct.loadoutperkstreaks = [];
    struct.loadoutstandardperks = [];
    struct.loadoutextraperks = [];
    struct.loadoutrigtrait = "specialty_null";
    struct.loadoutusingspecialist = 0;
    struct.loadoutequipmentprimary = "none";
    struct.var_cedaf611f3c02546 = [];
    struct.var_a1191d5606e653f0 = 0;
    struct.loadoutextraequipmentprimary = 0;
    struct.loadoutequipmentsecondary = "none";
    struct.var_7a0c0f1f8552f73e = [];
    struct.var_9481e959139fe88 = 0;
    struct.loadoutextraequipmentsecondary = 0;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = "none";
        struct.var_b32cdcb41c22f1be = [];
        struct.var_324b19b627387508 = 0;
        struct.loadoutExtraEquipmentTertiary = 0;
    }
    
    struct.loadoutmeleeslot = "none";
    struct.loadoutswimweapon = "none";
    struct.loadoutclimbweapon = "none";
    struct.loadoutsuper = "none";
    struct.loadoutgesture = "none";
    struct.loadoutaccessorydata = "none";
    struct.loadoutaccessoryweapon = "none";
    struct.loadoutfieldupgrade1 = "none";
    struct.var_6dd76aa72f0c26e1 = [];
    struct.var_6b08217cbc33ea5c = 0;
    struct.loadoutfieldupgrade2 = "none";
    struct.var_3834964fc455658e = [];
    struct.var_5e73e76f67b0afed = 0;
    struct.loadoutstreaksfilled = 0;
    
    if ( level.gamemodebundle.streaktypeenabled )
    {
        struct.loadoutstreaktype = getscriptbundle( level.gamemodebundle.streaktype );
        struct.loadoutkillstreak1 = getscriptbundlefieldvalue( struct.loadoutstreaktype.default_selections[ 0 ].streak, #"hash_fac9242d98a23ee8" ) ?? "none";
        struct.loadoutkillstreak2 = getscriptbundlefieldvalue( struct.loadoutstreaktype.default_selections[ 1 ].streak, #"hash_fac9242d98a23ee8" ) ?? "none";
        struct.loadoutkillstreak3 = getscriptbundlefieldvalue( struct.loadoutstreaktype.default_selections[ 2 ].streak, #"hash_fac9242d98a23ee8" ) ?? "none";
    }
    else
    {
        struct.loadoutstreaktype = "streaktype_assault";
        struct.loadoutkillstreak1 = "none";
        struct.loadoutkillstreak2 = "none";
        struct.loadoutkillstreak3 = "none";
    }
    
    struct.var_2ca84378b025c036 = 0;
    struct.var_efe096b4dabb84e3 = 0;
    struct.var_dc8ecd8732f650c4 = 0;
    struct.tweakedbyplayerduringmatch = 0;
    struct.gamemodeforcednewloadout = 0;
    struct.iscopiedclass = 0;
    return struct;
}

// Namespace class
// Params 0
// Checksum 0x22366b20, Offset: 0x88b9
// Size: 0x83
function loadout_getclassstruct()
{
    if ( !isdefined( level.var_af41f134389a876c ) )
    {
        level.var_af41f134389a876c = function_78bef2fe4565d594();
    }
    
    struct = structcopy( level.var_af41f134389a876c );
    
    if ( isdefined( self.callbacks[ #"hash_15b5bc31a89fd02b" ] ) || isdefined( level.callbacks[ #"hash_15b5bc31a89fd02b" ] ) )
    {
        callback::callback( #"hash_15b5bc31a89fd02b", { #struct:struct } );
    }
    
    return struct;
}

// Namespace class
// Params 1
// Checksum 0xd729c5dd, Offset: 0x8945
// Size: 0x672
function loadout_copyclassstruct( classstruct )
{
    copystruct = spawnstruct();
    copystruct.loadoutarchetype = classstruct.loadoutarchetype;
    copystruct.loadoutprimary = classstruct.loadoutprimary;
    copystruct.loadoutprimaryattachments = classstruct.loadoutprimaryattachments;
    copystruct.loadoutprimaryattachmentids = classstruct.loadoutprimaryattachmentids;
    copystruct.var_277379f78fc833f4 = classstruct.var_277379f78fc833f4;
    copystruct.loadoutprimarycamo = classstruct.loadoutprimarycamo;
    copystruct.loadoutprimarycosmeticattachment = classstruct.loadoutprimarycosmeticattachment;
    copystruct.loadoutprimarylootitemid = classstruct.loadoutprimarylootitemid;
    copystruct.loadoutprimaryreticle = classstruct.loadoutprimaryreticle;
    copystruct.loadoutprimarystickers = classstruct.loadoutprimaryweaponstickers;
    copystruct.loadoutprimaryvariantid = classstruct.loadoutprimaryvariantid;
    copystruct.loadoutsecondary = classstruct.loadoutsecondary;
    copystruct.loadoutsecondaryattachments = classstruct.loadoutsecondaryattachments;
    copystruct.loadoutsecondaryattachmentids = classstruct.loadoutsecondaryattachmentids;
    copystruct.var_b93fbd33bb0d0a2c = classstruct.var_b93fbd33bb0d0a2c;
    copystruct.loadoutsecondarycamo = classstruct.loadoutsecondarycamo;
    copystruct.loadoutsecondarycosmeticattachment = classstruct.loadoutsecondarycosmeticattachment;
    copystruct.loadoutsecondarylootitemid = classstruct.loadoutsecondarylootitemid;
    copystruct.loadoutsecondaryreticle = classstruct.loadoutsecondaryreticle;
    copystruct.loadoutsecondarystickers = classstruct.loadoutsecondarystickers;
    copystruct.loadoutsecondaryvariantid = classstruct.loadoutsecondaryvariantid;
    
    if ( level.tertiaryweaponslotenabled )
    {
        copystruct.loadouttertiary = classstruct.loadouttertiary;
        copystruct.var_c6ea1bb7cfd9e16e = classstruct.var_c6ea1bb7cfd9e16e;
        copystruct.var_d957b896dcfa75ed = classstruct.var_d957b896dcfa75ed;
        copystruct.var_50da18834547334c = classstruct.var_50da18834547334c;
        copystruct.loadouttertiarycamo = classstruct.loadouttertiarycamo;
        copystruct.loadouttertiaryreticle = classstruct.loadouttertiaryreticle;
        copystruct.var_ed9b3d4420e4e620 = classstruct.var_ed9b3d4420e4e620;
        copystruct.loadouttertiaryvariantid = classstruct.loadouttertiaryvariantid;
        copystruct.var_c3c185cb12ccad46 = classstruct.var_c3c185cb12ccad46;
        copystruct.var_6f4ac9993a146618 = classstruct.var_6f4ac9993a146618;
    }
    
    copystruct.loadoutmeleeslot = classstruct.loadoutmeleeslot;
    copystruct.loadoutperksfromgamemode = classstruct.loadoutperksfromgamemode;
    copystruct.loadoutperks = classstruct.loadoutperks;
    copystruct.loadoutperkstreaks = classstruct.loadoutperkstreaks;
    copystruct.loadoutstandardperks = classstruct.loadoutstandardperks;
    copystruct.loadoutextraperks = classstruct.loadoutextraperks;
    copystruct.loadoutrigtrait = classstruct.loadoutrigtrait;
    copystruct.loadoutusingspecialist = classstruct.loadoutusingspecialist;
    copystruct.loadoutequipmentprimary = classstruct.loadoutequipmentprimary;
    copystruct.var_cedaf611f3c02546 = classstruct.var_cedaf611f3c02546;
    copystruct.loadoutextraequipmentprimary = classstruct.loadoutextraequipmentprimary;
    copystruct.loadoutequipmentsecondary = classstruct.loadoutequipmentsecondary;
    copystruct.var_7a0c0f1f8552f73e = classstruct.var_7a0c0f1f8552f73e;
    copystruct.loadoutextraequipmentsecondary = classstruct.loadoutextraequipmentsecondary;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        copystruct.loadoutEquipmentTertiary = classstruct.loadoutEquipmentTertiary;
        copystruct.var_b32cdcb41c22f1be = classstruct.var_b32cdcb41c22f1be;
        copystruct.loadoutExtraEquipmentTertiary = classstruct.loadoutExtraEquipmentTertiary;
    }
    
    copystruct.loadoutsuper = classstruct.loadoutsuper;
    copystruct.loadoutgesture = classstruct.loadoutgesture;
    copystruct.loadoutfieldupgrade1 = classstruct.loadoutfieldupgrade1;
    copystruct.var_6dd76aa72f0c26e1 = classstruct.var_6dd76aa72f0c26e1;
    copystruct.loadoutfieldupgrade2 = classstruct.loadoutfieldupgrade2;
    copystruct.var_3834964fc455658e = classstruct.var_3834964fc455658e;
    copystruct.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
    copystruct.loadoutstreaktype = classstruct.loadoutstreaktype;
    copystruct.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
    copystruct.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
    copystruct.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
    copystruct.var_2ca84378b025c036 = classstruct.var_2ca84378b025c036;
    copystruct.var_efe096b4dabb84e3 = classstruct.var_efe096b4dabb84e3;
    copystruct.var_dc8ecd8732f650c4 = classstruct.var_dc8ecd8732f650c4;
    
    if ( isdefined( self.callbacks[ #"hash_41d19d1295d8261e" ] ) || isdefined( level.callbacks[ #"hash_41d19d1295d8261e" ] ) )
    {
        callback::callback( #"hash_41d19d1295d8261e", { #classstruct:classstruct, #copystruct:copystruct } );
    }
    
    copystruct.tweakedbyplayerduringmatch = classstruct.tweakedbyplayerduringmatch;
    copystruct.gamemodeforcednewloadout = classstruct.gamemodeforcednewloadout;
    copystruct.iscopiedclass = classstruct.iscopiedclass;
    copystruct = loadout_updateclass( copystruct, "copied" );
    return copystruct;
}

// Namespace class
// Params 3
// Checksum 0xd72e555d, Offset: 0x8fc0
// Size: 0x555
function loadout_updateclassteam( struct, class, classteam )
{
    classteam = loadout_getclassteam( class );
    classindex = getclassindex( class );
    wildcard = function_be7cee2ec3dda47a( classindex );
    self.class_num = classindex;
    self.classteam = classteam;
    struct.loadoutarchetype = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "archetype" );
    struct.loadoutprimary = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "weapon" );
    
    if ( struct.loadoutprimary == "none" )
    {
        struct.loadoutprimary = level.defaultfist.basename;
    }
    else
    {
        maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
        {
            struct.loadoutprimaryattachments[ attachmentindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "attachmentSetup" );
        }
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            struct.loadoutprimarystickers[ stickerindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "sticker" );
        }
    }
    
    struct.loadoutprimarycamo = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "camo" );
    struct.loadoutprimaryreticle = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 0, "reticle" );
    struct.loadoutsecondary = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "weapon" );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "attachmentSetup" );
    }
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutsecondarystickers[ stickerindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "sticker" );
    }
    
    struct.loadoutsecondarycamo = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "camo" );
    struct.loadoutsecondaryreticle = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "reticle" );
    
    if ( level.tertiaryweaponslotenabled )
    {
        struct.loadouttertiary = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "weapon" );
        var_dc1543b984237bf8 = weapon::function_222f1c49e082a080( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
        {
            struct.var_c6ea1bb7cfd9e16e[ attachmentindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "attachmentSetup" );
        }
        
        for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
        {
            struct.var_6f4ac9993a146618[ stickerindex ] = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "sticker" );
        }
        
        struct.loadouttertiarycamo = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "camo" );
        struct.loadouttertiaryreticle = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "weaponSetups", 1, "reticle" );
    }
    
    struct.loadoutmeleeslot = "none";
    struct.loadoutequipmentprimary = "none";
    struct.var_cedaf611f3c02546 = [];
    struct.loadoutextraequipmentprimary = 0;
    struct.loadoutequipmentsecondary = "none";
    struct.var_7a0c0f1f8552f73e = [];
    struct.loadoutextraequipmentsecondary = 0;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = "none";
        struct.var_b32cdcb41c22f1be = [];
        struct.loadoutExtraEquipmentTertiary = 0;
    }
    
    struct.loadoutfieldupgrade1 = "none";
    struct.var_6dd76aa72f0c26e1 = [];
    struct.loadoutfieldupgrade2 = "none";
    struct.var_3834964fc455658e = [];
    struct.loadoutgesture = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "gesture" );
    struct.loadoutstreaksfilled = 1;
    struct.loadoutkillstreak1 = recipe_getkillstreak( classteam, classindex, 0 );
    struct.loadoutkillstreak2 = recipe_getkillstreak( classteam, classindex, 1 );
    struct.loadoutkillstreak3 = recipe_getkillstreak( classteam, classindex, 2 );
}

// Namespace class
// Params 3
// Checksum 0x9f2a288f, Offset: 0x951d
// Size: 0x78
function loadout_updateclasscustom( struct, class, var_4d5575c6f9ec8a5b )
{
    if ( utility::issharedfuncdefined( #"instanceInventory", #"hash_10edfd81317fb1b4" ) )
    {
        [[ utility::getsharedfunc( #"instanceInventory", #"hash_10edfd81317fb1b4" ) ]]( self, struct, class, var_4d5575c6f9ec8a5b );
        return;
    }
    
    if ( !isvalidclass( class ) )
    {
        class = "custom1";
    }
    
    function_3f8300ab762286c6( struct, class, var_4d5575c6f9ec8a5b );
}

// Namespace class
// Params 3
// Checksum 0xc0ececa9, Offset: 0x959d
// Size: 0xb73
function function_3f8300ab762286c6( struct, class, var_4d5575c6f9ec8a5b )
{
    classindex = getclassindex( class );
    self.class_num = classindex;
    struct.loadoutwildcard = function_be7cee2ec3dda47a( classindex );
    struct.loadoutarchetype = cac_getcharacterarchetype();
    struct.loadoutprimary = cac_getweapon( classindex, 0 );
    
    if ( !isdefined( struct.loadoutprimary ) && !self isplayerheadless() )
    {
        script::function_2e2007575f92910d( "CER-400502: primary undefined classIndex " + ( classindex ?? "" ) + " for " + ( self getplayerunoid() ?? "" ) + " for class " + ( class ?? "" ) );
    }
    
    if ( isbrgamemode() && !getdvarint( @"hash_78f6e349889208bc", 0 ) )
    {
        if ( struct.loadoutwildcard && struct.loadoutwildcard != "wildcard_none" && isdefined( struct.loadoutprimary ) && struct.loadoutprimary != "" && struct.loadoutprimary != "none" )
        {
            weaponproject = weaponrank::function_30f0a3aa3c1905ea( struct.loadoutprimary );
            
            if ( weaponproject == "iw9" || weaponproject == "jup" )
            {
                if ( struct.loadoutwildcard == "wildcard_gunfighter" )
                {
                    struct.loadoutwildcard = "wildcard_none";
                }
            }
        }
    }
    
    wildcard = struct.loadoutwildcard;
    var_9a5b9551a8a827f = level.gamemodebundle.var_54a7512237514195;
    var_97391427c9f86ae9 = isdefined( var_9a5b9551a8a827f );
    var_4baa04ac0a97ef88 = 0;
    struct.loadoutprimaryvariantid = cac_getweaponvariantid( classindex, 0 );
    
    if ( 0 != struct.loadoutprimaryvariantid )
    {
        var_4baa04ac0a97ef88 = 1;
        ignorelist = weapon::function_2374da6f1b4fad4e( weapon::weaponassetnamemap( struct.loadoutprimary ), struct.loadoutprimaryvariantid );
        struct.var_277379f78fc833f4 = arraycombine( struct.var_277379f78fc833f4, ignorelist );
    }
    
    if ( struct.loadoutprimary )
    {
        var_bd97cd76300c7c4a = weapon::getmaxprimaryattachments( wildcard );
        var_695383f15083ef1c = var_bd97cd76300c7c4a + var_4baa04ac0a97ef88;
        var_c2f6200dba6031e = var_4baa04ac0a97ef88 == 0 && var_97391427c9f86ae9;
        weaponname = cac_getweapon( classindex, 0 );
        
        for ( attachmentindex = 0; attachmentindex < var_695383f15083ef1c ; attachmentindex++ )
        {
            attachmentname = cac_getweaponattachment( classindex, 0, attachmentindex, weaponname );
            struct.loadoutprimaryattachments[ attachmentindex ] = attachmentname;
            struct.loadoutprimaryattachmentids[ attachmentindex ] = cac_getweaponattachmentid( classindex, 0, attachmentindex );
            
            if ( !var_4d5575c6f9ec8a5b )
            {
                tuningvalues = cac_getweaponattachmenttuning( classindex, 0, attachmentindex );
                
                if ( isdefined( tuningvalues ) )
                {
                    struct.var_57a15af46a205668[ attachmentname ] = tuningvalues;
                }
            }
            
            if ( !var_c2f6200dba6031e )
            {
                continue;
            }
            
            if ( !isdefined( attachmentname ) || attachmentname == "" )
            {
                continue;
            }
            
            if ( weapon::attachmentmap_tocategory( attachmentname ) == var_9a5b9551a8a827f )
            {
                var_695383f15083ef1c++;
                var_c2f6200dba6031e = 0;
            }
        }
    }
    
    struct.loadoutprimarycamo = cac_getweaponcamo( classindex, 0 );
    struct.var_69ae546f481034e2 = cac_getweaponchroma( classindex, 0 );
    struct.loadoutprimaryreticle = cac_getweaponreticle( classindex, 0 );
    struct.loadoutprimarylootitemid = cac_getweaponlootitemid( classindex, 0 );
    struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment( classindex, 0 );
    struct.var_bf06b7def8985709 = function_e33bbd58c1d11a9( classindex, 0 );
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutprimarystickers[ stickerindex ] = cac_getweaponsticker( classindex, 0, stickerindex );
    }
    
    struct.loadoutsecondary = cac_getweapon( classindex, 1 );
    
    if ( !isdefined( struct.loadoutsecondary ) && !self isplayerheadless() )
    {
        script::function_2e2007575f92910d( "CER-400502: secondary undefined classIndex " + ( classindex ?? "" ) + " for " + ( self getplayerunoid() ?? "" ) + " for class " + ( class ?? "" ) );
    }
    
    var_963dd2589442060 = 0;
    struct.loadoutsecondaryvariantid = cac_getweaponvariantid( classindex, 1 );
    
    if ( 0 != struct.loadoutsecondaryvariantid )
    {
        var_963dd2589442060 = 1;
        ignorelist = weapon::function_2374da6f1b4fad4e( weapon::weaponassetnamemap( struct.loadoutsecondary ), struct.loadoutsecondaryvariantid );
        struct.var_b93fbd33bb0d0a2c = arraycombine( struct.var_b93fbd33bb0d0a2c, ignorelist );
    }
    
    if ( struct.loadoutsecondary )
    {
        var_e6597c17a78feafa = weapon::getmaxsecondaryattachments( wildcard );
        var_6cf605f6270cbe8c = var_e6597c17a78feafa + var_963dd2589442060;
        var_f81b0ecb9b397aae = var_963dd2589442060 == 0 && var_97391427c9f86ae9;
        weaponname = cac_getweapon( classindex, 1 );
        
        for ( attachmentindex = 0; attachmentindex < var_6cf605f6270cbe8c ; attachmentindex++ )
        {
            attachmentname = cac_getweaponattachment( classindex, 1, attachmentindex, weaponname );
            struct.loadoutsecondaryattachments[ attachmentindex ] = attachmentname;
            struct.loadoutsecondaryattachmentids[ attachmentindex ] = cac_getweaponattachmentid( classindex, 1, attachmentindex );
            
            if ( !var_4d5575c6f9ec8a5b )
            {
                tuningvalues = cac_getweaponattachmenttuning( classindex, 1, attachmentindex );
                
                if ( isdefined( tuningvalues ) )
                {
                    struct.var_f2b8977772330320[ attachmentname ] = tuningvalues;
                }
            }
            
            if ( !var_f81b0ecb9b397aae )
            {
                continue;
            }
            
            if ( !isdefined( attachmentname ) || attachmentname == "" )
            {
                continue;
            }
            
            if ( weapon::attachmentmap_tocategory( attachmentname ) == var_9a5b9551a8a827f )
            {
                var_6cf605f6270cbe8c++;
                var_f81b0ecb9b397aae = 0;
            }
        }
    }
    
    struct.loadoutsecondarycamo = cac_getweaponcamo( classindex, 1 );
    struct.var_2bab3f4f3d38584a = cac_getweaponchroma( classindex, 1 );
    struct.loadoutsecondaryreticle = cac_getweaponreticle( classindex, 1 );
    struct.loadoutsecondarylootitemid = cac_getweaponlootitemid( classindex, 1 );
    struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment( classindex, 1 );
    struct.var_8d1ed34c7709f241 = function_e33bbd58c1d11a9( classindex, 1 );
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutsecondarystickers[ stickerindex ] = cac_getweaponsticker( classindex, 1, stickerindex );
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        var_fd7313c9cf8b0bbd = cac_getweapon( classindex, 2 );
        
        if ( getdvarint( @"hash_cda07d97d51d94d5", 0 ) > 0 )
        {
            var_be0ec98b46b8b28 = struct.loadoutwildcard ? getxhash( struct.loadoutwildcard ) : #"none";
            
            if ( var_be0ec98b46b8b28 == #"wildcard_flyswatter" )
            {
                var_fd7313c9cf8b0bbd = "t10_la_p18_stisaac";
            }
        }
        
        struct.loadouttertiary = var_fd7313c9cf8b0bbd;
        var_dc1543b984237bf8 = weapon::function_222f1c49e082a080( wildcard );
        weaponname = cac_getweapon( classindex, 2 );
        
        for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
        {
            attachmentname = cac_getweaponattachment( classindex, 2, attachmentindex, weaponname );
            struct.var_c6ea1bb7cfd9e16e[ attachmentindex ] = attachmentname;
            struct.var_d957b896dcfa75ed[ attachmentindex ] = cac_getweaponattachmentid( classindex, 2, attachmentindex );
            tuningvalues = cac_getweaponattachmenttuning( classindex, 2, attachmentindex );
            
            if ( isdefined( tuningvalues ) )
            {
                struct.var_d3a06e057eb576c0[ attachmentname ] = tuningvalues;
            }
        }
        
        struct.loadouttertiarycamo = cac_getweaponcamo( classindex, 2 );
        struct.var_de6bc6d1e7c111ea = cac_getweaponchroma( classindex, 2 );
        struct.loadouttertiaryreticle = cac_getweaponreticle( classindex, 2 );
        struct.var_ed9b3d4420e4e620 = cac_getweaponlootitemid( classindex, 2 );
        struct.loadouttertiaryvariantid = cac_getweaponvariantid( classindex, 2 );
        struct.var_c3c185cb12ccad46 = cac_getweaponcosmeticattachment( classindex, 2 );
        struct.var_ea6fecf8edebaf61 = function_e33bbd58c1d11a9( classindex, 2 );
        
        for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
        {
            struct.var_6f4ac9993a146618[ stickerindex ] = cac_getweaponsticker( classindex, 2, stickerindex );
        }
    }
    
    struct.loadoutequipmentprimary = cac_getequipmentprimary( classindex );
    struct.var_cedaf611f3c02546 = function_be70f19314ad522( classindex, 0 );
    struct.var_a1191d5606e653f0 = function_fa9f647e285ca27a( classindex );
    struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary( classindex );
    struct.loadoutequipmentsecondary = cac_getequipmentsecondary( classindex );
    struct.var_7a0c0f1f8552f73e = function_be70f19314ad522( classindex, 1 );
    struct.var_9481e959139fe88 = function_a0b11324d7722a86( classindex );
    struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary( classindex );
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = function_9fb74ba447b5422a( classindex );
        struct.var_b32cdcb41c22f1be = function_be70f19314ad522( classindex, 2 );
        struct.var_324b19b627387508 = function_5f4a1fc6176d6416( classindex );
        struct.loadoutExtraEquipmentTertiary = function_1d8851306246d240( classindex );
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        function_5a1b748b70ab10c2( struct );
    }
    
    struct.loadoutgesture = cac_getgesture();
    struct.loadoutfieldupgrade1 = cac_getfieldupgrade( classindex, 0 );
    struct.var_6dd76aa72f0c26e1 = cac_getfieldupgradeattachments( classindex, 0 );
    struct.var_6b08217cbc33ea5c = function_4dd91ac57bdf0c71( classindex, 0 );
    struct.loadoutfieldupgrade2 = cac_getfieldupgrade( classindex, 1 );
    struct.var_3834964fc455658e = cac_getfieldupgradeattachments( classindex, 1 );
    struct.var_5e73e76f67b0afed = function_4dd91ac57bdf0c71( classindex, 1 );
    struct.loadoutstreaksfilled = 1;
    struct.loadoutkillstreak1 = cac_getkillstreak( 0, class );
    struct.loadoutkillstreak2 = cac_getkillstreak( 1, class );
    struct.loadoutkillstreak3 = cac_getkillstreak( 2, class );
    struct.var_2ca84378b025c036 = function_9f6f840868cfaebb( 0, class, struct.loadoutkillstreak1 );
    struct.var_efe096b4dabb84e3 = function_9f6f840868cfaebb( 1, class, struct.loadoutkillstreak2 );
    struct.var_dc8ecd8732f650c4 = function_9f6f840868cfaebb( 2, class, struct.loadoutkillstreak3 );
    struct.loadoutusingspecialist = cac_getusingspecialist( classindex );
    
    if ( struct.loadoutusingspecialist )
    {
        function_3eadf9f9486c1d3f( struct );
    }
    
    if ( isdefined( self.callbacks[ #"hash_bc53f926031ea3f6" ] ) || isdefined( level.callbacks[ #"hash_bc53f926031ea3f6" ] ) )
    {
        var_4d362babbfd5b4b1 = function_4d362babbfd5b4b1();
        callback::callback( #"hash_bc53f926031ea3f6", { #var_4d362babbfd5b4b1:var_4d362babbfd5b4b1, #class:class, #struct:struct } );
    }
}

// Namespace class
// Params 2
// Checksum 0xf9d9f6d2, Offset: 0xa118
// Size: 0x878
function loadout_updateclassgamemode( struct, class )
{
    if ( !isdefined( self.pers[ "gamemodeLoadout" ] ) && isbot( self ) )
    {
        bots_loadout::function_869a511557a60ad4();
        loadout_updateclasscallback( struct );
        return;
    }
    
    self.class_num = getclassindex( class );
    gamemodeloadout = self.pers[ "gamemodeLoadout" ];
    wildcard = function_be7cee2ec3dda47a( self.class_num );
    
    if ( !isdefined( gamemodeloadout[ "loadoutArchetype" ] ) )
    {
        if ( isbot( self ) )
        {
            struct.loadoutarchetype = "archetype_assault";
        }
        else
        {
            struct.loadoutarchetype = cac_getcharacterarchetype();
        }
    }
    else
    {
        struct.loadoutarchetype = gamemodeloadout[ "loadoutArchetype" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutRigTrait" ] ) )
    {
        struct.loadoutrigtrait = gamemodeloadout[ "loadoutRigTrait" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimary" ] ) )
    {
        struct.loadoutprimary = gamemodeloadout[ "loadoutPrimary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryAttachments" ] ) )
    {
        struct.loadoutprimaryattachments = gamemodeloadout[ "loadoutPrimaryAttachments" ];
    }
    
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachstring = getattachmentloadoutstring( attachmentindex, #"primary" );
        
        if ( isdefined( gamemodeloadout[ attachstring ] ) && gamemodeloadout[ attachstring ] != "none" )
        {
            struct.loadoutprimaryattachments[ attachmentindex ] = gamemodeloadout[ attachstring ];
        }
    }
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        stickerstring = getstickerloadoutstring( stickerindex, #"primary" );
        
        if ( isdefined( gamemodeloadout[ stickerstring ] ) )
        {
            struct.loadoutprimarystickers[ stickerindex ] = gamemodeloadout[ stickerstring ];
        }
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryCamo" ] ) )
    {
        struct.loadoutprimarycamo = gamemodeloadout[ "loadoutPrimaryCamo" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryCosmeticAttachment" ] ) )
    {
        struct.loadoutprimarycosmeticattachment = gamemodeloadout[ "loadoutPrimaryCosmeticAttachment" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryReticle" ] ) )
    {
        struct.loadoutprimaryreticle = gamemodeloadout[ "loadoutPrimaryReticle" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryVariantID" ] ) )
    {
        struct.loadoutprimaryvariantid = gamemodeloadout[ "loadoutPrimaryVariantID" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPrimaryVariantID" ] ) && game_utility::getgametype() == "arena" )
    {
        if ( isdefined( gamemodeloadout[ "roundWinStreakPrimaryCamoTeam" ] ) && isdefined( self.pers[ "team" ] ) && gamemodeloadout[ "roundWinStreakPrimaryCamoTeam" ] == self.pers[ "team" ] )
        {
            if ( isdefined( gamemodeloadout[ "roundWinStreakPrimaryCamo" ] ) )
            {
                struct.loadoutprimarycamo = gamemodeloadout[ "roundWinStreakPrimaryCamo" ];
            }
        }
        
        if ( gamemodeloadout[ "loadoutPrimaryVariantID" ] != -1 )
        {
            setomnvar( "ui_arena_primaryVariantID", gamemodeloadout[ "loadoutPrimaryVariantID" ] );
        }
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondary" ] ) )
    {
        struct.loadoutsecondary = gamemodeloadout[ "loadoutSecondary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryAttachments" ] ) )
    {
        struct.loadoutsecondaryattachments = gamemodeloadout[ "loadoutSecondaryAttachments" ];
    }
    
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachstring = getattachmentloadoutstring( attachmentindex, #"secondary" );
        
        if ( isdefined( gamemodeloadout[ attachstring ] ) && gamemodeloadout[ attachstring ] != "none" )
        {
            struct.loadoutsecondaryattachments[ attachmentindex ] = gamemodeloadout[ attachstring ];
        }
    }
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        stickerstring = getstickerloadoutstring( stickerindex, #"secondary" );
        
        if ( isdefined( gamemodeloadout[ stickerstring ] ) )
        {
            struct.loadoutsecondarystickers[ stickerindex ] = gamemodeloadout[ stickerstring ];
        }
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryCamo" ] ) )
    {
        struct.loadoutsecondarycamo = gamemodeloadout[ "loadoutSecondaryCamo" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryCosmeticAttachment" ] ) )
    {
        struct.loadoutsecondarycosmeticattachment = gamemodeloadout[ "loadoutSecondaryCosmeticAttachment" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryReticle" ] ) )
    {
        struct.loadoutsecondaryreticle = gamemodeloadout[ "loadoutSecondaryReticle" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryVariantID" ] ) )
    {
        struct.loadoutsecondaryvariantid = gamemodeloadout[ "loadoutSecondaryVariantID" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSecondaryVariantID" ] ) && game_utility::getgametype() == "arena" && gamemodeloadout[ "loadoutSecondaryVariantID" ] != -1 )
    {
        if ( isdefined( gamemodeloadout[ "roundWinStreakecondaryCamoTeam" ] ) && isdefined( self.pers[ "team" ] ) && gamemodeloadout[ "roundWinStreakecondaryCamoTeam" ] == self.pers[ "team" ] )
        {
            if ( isdefined( gamemodeloadout[ "roundWinStreakSecondaryCamo" ] ) )
            {
                struct.loadoutsecondarycamo = gamemodeloadout[ "roundWinStreakSecondaryCamo" ];
            }
        }
        
        if ( gamemodeloadout[ "loadoutSecondaryVariantID" ] != -1 )
        {
            setomnvar( "ui_arena_secondaryVariantID", gamemodeloadout[ "loadoutSecondaryVariantID" ] );
        }
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutTertiary" ] ) )
    {
        struct.loadouttertiary = gamemodeloadout[ "loadoutTertiary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutTertiaryCamo" ] ) )
    {
        struct.loadouttertiarycamo = gamemodeloadout[ "loadoutTertiaryCamo" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutTertiaryReticle" ] ) )
    {
        struct.loadouttertiaryreticle = gamemodeloadout[ "loadoutTertiaryReticle" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutTertiaryVariantID" ] ) )
    {
        struct.loadouttertiaryvariantid = gamemodeloadout[ "loadoutTertiaryVariantID" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutMeleeSlot" ] ) )
    {
        struct.loadoutmeleeslot = gamemodeloadout[ "loadoutMeleeSlot" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSwimWeapon" ] ) )
    {
        struct.loadoutswimweapon = gamemodeloadout[ "loadoutSwimWeapon" ];
    }
    
    struct.loadoutperksfromgamemode = isdefined( gamemodeloadout[ "loadoutPerks" ] );
    
    if ( isdefined( gamemodeloadout[ "loadoutPerks" ] ) )
    {
        struct.loadoutperks = gamemodeloadout[ "loadoutPerks" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutPerkStreaks" ] ) )
    {
        struct.loadoutperkstreaks = gamemodeloadout[ "loadoutPerkStreaks" ];
    }
    
    struct.loadoutextraperksfromgamemode = isdefined( gamemodeloadout[ "loadoutExtraPerks" ] );
    
    if ( isdefined( gamemodeloadout[ "loadoutExtraPerks" ] ) )
    {
        struct.loadoutextraperks = gamemodeloadout[ "loadoutExtraPerks" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutEquipmentPrimary" ] ) )
    {
        struct.loadoutequipmentprimary = gamemodeloadout[ "loadoutEquipmentPrimary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutExtraEquipmentPrimary" ] ) )
    {
        struct.loadoutextraequipmentprimary = gamemodeloadout[ "loadoutExtraEquipmentPrimary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutEquipmentSecondary" ] ) )
    {
        struct.loadoutequipmentsecondary = gamemodeloadout[ "loadoutEquipmentSecondary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutExtraEquipmentSecondary" ] ) )
    {
        struct.loadoutextraequipmentsecondary = gamemodeloadout[ "loadoutExtraEquipmentSecondary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutEquipmentTertiary" ] ) )
    {
        struct.loadoutEquipmentTertiary = gamemodeloadout[ "loadoutEquipmentTertiary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutExtraEquipmentTertiary" ] ) )
    {
        struct.loadoutExtraEquipmentTertiary = gamemodeloadout[ "loadoutExtraEquipmentTertiary" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutSuper" ] ) )
    {
        struct.loadoutsuper = gamemodeloadout[ "loadoutSuper" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutFieldUpgrade1" ] ) )
    {
        struct.loadoutfieldupgrade1 = gamemodeloadout[ "loadoutFieldUpgrade1" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutFieldUpgrade2" ] ) )
    {
        struct.loadoutfieldupgrade2 = gamemodeloadout[ "loadoutFieldUpgrade2" ];
    }
    
    if ( isdefined( gamemodeloadout[ #"disablebackuppistol" ] ) )
    {
        struct.disablebackuppistol = gamemodeloadout[ #"disablebackuppistol" ];
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutGesture" ] ) )
    {
        if ( gamemodeloadout[ "loadoutGesture" ] == "playerData" )
        {
            if ( isbot( self ) )
            {
                struct.loadoutgesture = "none";
            }
            else
            {
                struct.loadoutgesture = cac_getgesture();
            }
        }
        else
        {
            struct.loadoutgesture = gamemodeloadout[ "loadoutGesture" ];
        }
    }
    
    if ( isdefined( gamemodeloadout[ "loadoutKillstreak1" ] ) && gamemodeloadout[ "loadoutKillstreak1" ] != "specialty_null" || isdefined( gamemodeloadout[ "loadoutKillstreak2" ] ) && gamemodeloadout[ "loadoutKillstreak2" ] != "specialty_null" || isdefined( gamemodeloadout[ "loadoutKillstreak3" ] ) && gamemodeloadout[ "loadoutKillstreak3" ] != "specialty_null" )
    {
        struct.loadoutstreaksfilled = 1;
        struct.loadoutkillstreak1 = gamemodeloadout[ "loadoutKillstreak1" ];
        struct.loadoutkillstreak2 = gamemodeloadout[ "loadoutKillstreak2" ];
        struct.loadoutkillstreak3 = gamemodeloadout[ "loadoutKillstreak3" ];
    }
    
    struct.loadoutstreaktype = gamemodeloadout[ "loadoutStreakType" ];
    
    if ( isdefined( gamemodeloadout[ "loadoutUsingSpecialist" ] ) )
    {
        struct.loadoutusingspecialist = 1;
    }
}

// Namespace class
// Params 1
// Checksum 0xf1f3f3ab, Offset: 0xa998
// Size: 0x1132
function loadout_updateclasscallback( struct )
{
    if ( !isdefined( self.classcallback ) )
    {
        utility::error( "self.classCallback function reference required for class 'callback'" );
    }
    
    callbackloadout = self [[ self.classcallback ]]();
    
    if ( !isdefined( callbackloadout ) )
    {
        utility::error( "array required from self.classCallback for class 'callback'" );
    }
    
    if ( isbot( self ) )
    {
        if ( isdefined( callbackloadout.archetype ) )
        {
            struct.loadoutarchetype = "archetype_" + tolower( callbackloadout.archetype );
        }
        
        if ( isdefined( callbackloadout.primaryweapon.weapon ) )
        {
            struct.loadoutprimary = callbackloadout.primaryweapon.weapon;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment1 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment1;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment2 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment2;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment3 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment3;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment4 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment4;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment5 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment5;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.attachment6 ) )
        {
            struct.loadoutprimaryattachments[ struct.loadoutprimaryattachments.size ] = callbackloadout.primaryweapon.attachment6;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.variantid ) )
        {
            struct.loadoutprimaryvariantid = callbackloadout.primaryweapon.variantid;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.camo ) )
        {
            struct.loadoutprimarycamo = callbackloadout.primaryweapon.camo;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.chroma ) )
        {
            struct.var_69ae546f481034e2 = callbackloadout.primaryweapon.chroma;
        }
        
        if ( isdefined( callbackloadout.primaryweapon.reticle ) )
        {
            struct.loadoutprimaryreticle = callbackloadout.primaryweapon.reticle;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.weapon ) )
        {
            struct.loadoutsecondary = callbackloadout.secondaryweapon.weapon;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.attachment1 ) )
        {
            struct.loadoutsecondaryattachments[ struct.loadoutsecondaryattachments.size ] = callbackloadout.secondaryweapon.attachment1;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.attachment2 ) )
        {
            struct.loadoutsecondaryattachments[ struct.loadoutsecondaryattachments.size ] = callbackloadout.secondaryweapon.attachment2;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.attachment3 ) )
        {
            struct.loadoutsecondaryattachments[ struct.loadoutsecondaryattachments.size ] = callbackloadout.secondaryweapon.attachment3;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.attachment4 ) )
        {
            struct.loadoutsecondaryattachments[ struct.loadoutsecondaryattachments.size ] = callbackloadout.secondaryweapon.attachment4;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.attachment5 ) )
        {
            struct.loadoutsecondaryattachments[ struct.loadoutsecondaryattachments.size ] = callbackloadout.secondaryweapon.attachment5;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.variantid ) )
        {
            struct.loadoutsecondaryvariantid = callbackloadout.secondaryweapon.variantid;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.camo ) )
        {
            struct.loadoutsecondarycamo = callbackloadout.secondaryweapon.camo;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.chroma ) )
        {
            struct.var_2bab3f4f3d38584a = callbackloadout.secondaryweapon.chroma;
        }
        
        if ( isdefined( callbackloadout.secondaryweapon.reticle ) )
        {
            struct.loadoutsecondaryreticle = callbackloadout.secondaryweapon.reticle;
        }
        
        if ( isdefined( callbackloadout.tertiaryWeapon ) )
        {
            if ( isdefined( callbackloadout.tertiaryWeapon.weapon ) )
            {
                struct.loadouttertiary = callbackloadout.tertiaryWeapon.weapon;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.attachment1 ) )
            {
                struct.var_c6ea1bb7cfd9e16e[ struct.var_c6ea1bb7cfd9e16e.size ] = callbackloadout.tertiaryWeapon.attachment1;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.attachment2 ) )
            {
                struct.var_c6ea1bb7cfd9e16e[ struct.var_c6ea1bb7cfd9e16e.size ] = callbackloadout.tertiaryWeapon.attachment2;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.attachment3 ) )
            {
                struct.var_c6ea1bb7cfd9e16e[ struct.var_c6ea1bb7cfd9e16e.size ] = callbackloadout.tertiaryWeapon.attachment3;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.attachment4 ) )
            {
                struct.var_c6ea1bb7cfd9e16e[ struct.var_c6ea1bb7cfd9e16e.size ] = callbackloadout.tertiaryWeapon.attachment4;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.attachment5 ) )
            {
                struct.var_c6ea1bb7cfd9e16e[ struct.var_c6ea1bb7cfd9e16e.size ] = callbackloadout.tertiaryWeapon.attachment5;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.variantid ) )
            {
                struct.loadouttertiaryvariantid = callbackloadout.tertiaryWeapon.variantid;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.camo ) )
            {
                struct.loadouttertiarycamo = callbackloadout.tertiaryWeapon.camo;
            }
            
            if ( isdefined( callbackloadout.tertiaryWeapon.reticle ) )
            {
                struct.loadouttertiaryreticle = callbackloadout.tertiaryWeapon.reticle;
            }
        }
        
        if ( isdefined( callbackloadout.meleeslot ) )
        {
            struct.loadoutmeleeslot = callbackloadout.meleeslot;
        }
        
        if ( isdefined( callbackloadout.equipment.primary ) )
        {
            struct.loadoutequipmentprimary = callbackloadout.equipment.primary;
        }
        
        if ( isdefined( callbackloadout.equipment.secondary ) )
        {
            struct.loadoutequipmentsecondary = callbackloadout.equipment.secondary;
        }
        
        if ( isdefined( callbackloadout.equipment.tertiary ) )
        {
            struct.loadoutEquipmentTertiary = callbackloadout.equipment.tertiary;
        }
        
        if ( isdefined( callbackloadout.perks.perk1 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.perks.perk1;
        }
        
        if ( isdefined( callbackloadout.perks.perk2 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.perks.perk2;
        }
        
        if ( isdefined( callbackloadout.perks.perk3 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.perks.perk3;
        }
        
        if ( isdefined( callbackloadout.extraperks.perk1 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.extraperks.perk1;
        }
        
        if ( isdefined( callbackloadout.extraperks.perk2 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.extraperks.perk2;
        }
        
        if ( isdefined( callbackloadout.extraperks.perk3 ) )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = callbackloadout.extraperks.perk3;
        }
        
        if ( isdefined( callbackloadout.gesture ) )
        {
            struct.loadoutgesture = callbackloadout.gesture;
        }
        
        if ( isdefined( callbackloadout.fieldUpgrades.fieldupgrade1 ) )
        {
            struct.loadoutfieldupgrade1 = callbackloadout.fieldUpgrades.fieldupgrade1;
        }
        
        if ( isdefined( callbackloadout.fieldUpgrades.fieldupgrade2 ) )
        {
            struct.loadoutfieldupgrade2 = callbackloadout.fieldUpgrades.fieldupgrade2;
        }
        
        if ( isdefined( callbackloadout.killstreaks.killstreak1 ) )
        {
            struct.loadoutkillstreak1 = callbackloadout.killstreaks.killstreak1;
        }
        
        if ( isdefined( callbackloadout.killstreaks.killstreak2 ) )
        {
            struct.loadoutkillstreak2 = callbackloadout.killstreaks.killstreak2;
        }
        
        if ( isdefined( callbackloadout.killstreaks.killstreak3 ) )
        {
            struct.loadoutkillstreak3 = callbackloadout.killstreaks.killstreak3;
        }
        
        if ( isdefined( callbackloadout.killstreaks.streaktype ) )
        {
            struct.loadoutstreaktype = callbackloadout.killstreaks.streaktype;
        }
        
        if ( isdefined( callbackloadout.specialist ) )
        {
            struct.loadoutusingspecialist = callbackloadout.specialist;
        }
        
        struct utility::callsharedfunc( #"bodysize", #"hash_5aabc0a191f4bbd9", callbackloadout );
    }
    else
    {
        if ( isdefined( callbackloadout[ "loadoutArchetype" ] ) )
        {
            struct.loadoutarchetype = callbackloadout[ "loadoutArchetype" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutPrimary" ] ) )
        {
            struct.loadoutprimary = callbackloadout[ "loadoutPrimary" ];
        }
        
        maxprimaryattachments = weapon::function_45ab75ece154ca8f();
        
        for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
        {
            attachstring = getattachmentloadoutstring( attachmentindex, #"primary" );
            
            if ( isdefined( callbackloadout[ attachstring ] ) )
            {
                struct.loadoutprimaryattachments[ attachmentindex ] = callbackloadout[ attachstring ];
            }
        }
        
        if ( isdefined( callbackloadout[ "loadoutPrimaryCamo" ] ) )
        {
            struct.loadoutprimarycamo = callbackloadout[ "loadoutPrimaryCamo" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutPrimaryReticle" ] ) )
        {
            struct.loadoutprimaryreticle = callbackloadout[ "loadoutPrimaryReticle" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutPrimaryVariantID" ] ) )
        {
            struct.loadoutprimaryvariantid = callbackloadout[ "loadoutPrimaryVariantID" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutSecondary" ] ) )
        {
            struct.loadoutsecondary = callbackloadout[ "loadoutSecondary" ];
        }
        
        maxsecondaryattachments = weapon::function_a7a39da0cf2d5b5b();
        
        for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
        {
            attachstring = getattachmentloadoutstring( attachmentindex, #"secondary" );
            
            if ( isdefined( callbackloadout[ attachstring ] ) )
            {
                struct.loadoutsecondaryattachments[ attachmentindex ] = callbackloadout[ attachstring ];
            }
        }
        
        if ( isdefined( callbackloadout[ "loadoutSecondaryCamo" ] ) )
        {
            struct.loadoutsecondarycamo = callbackloadout[ "loadoutSecondaryCamo" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutSecondaryReticle" ] ) )
        {
            struct.loadoutsecondaryreticle = callbackloadout[ "loadoutSecondaryReticle" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutSecondaryVariantID" ] ) )
        {
            struct.loadoutsecondaryvariantid = callbackloadout[ "loadoutSecondaryVariantID" ];
        }
        
        if ( level.tertiaryweaponslotenabled )
        {
            if ( isdefined( callbackloadout[ "loadoutTertiary" ] ) )
            {
                struct.loadouttertiary = callbackloadout[ "loadoutTertiary" ];
            }
            
            var_dc1543b984237bf8 = weapon::function_bedf9f9cfa13920d();
            
            for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
            {
                attachstring = getattachmentloadoutstring( attachmentindex, #"tertiary" );
                
                if ( isdefined( callbackloadout[ attachstring ] ) )
                {
                    struct.var_c6ea1bb7cfd9e16e[ attachmentindex ] = callbackloadout[ attachstring ];
                }
            }
            
            if ( isdefined( callbackloadout[ "loadoutTertiaryCamo" ] ) )
            {
                struct.loadouttertiarycamo = callbackloadout[ "loadoutTertiaryCamo" ];
            }
            
            if ( isdefined( callbackloadout[ "loadoutTertiaryReticle" ] ) )
            {
                struct.loadouttertiaryreticle = callbackloadout[ "loadoutTertiaryReticle" ];
            }
            
            if ( isdefined( callbackloadout[ "loadoutTertiaryVariantID" ] ) )
            {
                struct.loadouttertiaryvariantid = callbackloadout[ "loadoutTertiaryVariantID" ];
            }
        }
        
        if ( isdefined( callbackloadout[ "loadoutMeleeSlot" ] ) )
        {
            struct.loadoutmeleeslot = callbackloadout[ "loadoutMeleeSlot" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutEquipmentPrimary" ] ) )
        {
            struct.loadoutequipmentprimary = callbackloadout[ "loadoutEquipmentPrimary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutExtraEquipmentPrimary" ] ) )
        {
            struct.loadoutextraequipmentprimary = callbackloadout[ "loadoutExtraEquipmentPrimary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutEquipmentSecondary" ] ) )
        {
            struct.loadoutequipmentsecondary = callbackloadout[ "loadoutEquipmentSecondary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutExtraEquipmentSecondary" ] ) )
        {
            struct.loadoutextraequipmentsecondary = callbackloadout[ "loadoutExtraEquipmentSecondary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutEquipmentTertiary" ] ) )
        {
            struct.loadoutEquipmentTertiary = callbackloadout[ "loadoutEquipmentTertiary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutExtraEquipmentTertiary" ] ) )
        {
            struct.loadoutExtraEquipmentTertiary = callbackloadout[ "loadoutExtraEquipmentTertiary" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutSuper" ] ) )
        {
            struct.loadoutsuper = callbackloadout[ "loadoutSuper" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutGesture" ] ) )
        {
            struct.loadoutgesture = callbackloadout[ "loadoutGesture" ];
        }
        
        struct.loadoutstreaksfilled = isdefined( callbackloadout[ "loadoutStreak1" ] ) || isdefined( callbackloadout[ "loadoutStreak2" ] ) || isdefined( callbackloadout[ "loadoutStreak3" ] );
        
        if ( isdefined( callbackloadout[ "loadoutStreakType" ] ) )
        {
            struct.loadoutstreaktype = callbackloadout[ "loadoutStreakType" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutStreak1" ] ) )
        {
            struct.loadoutkillstreak1 = callbackloadout[ "loadoutStreak1" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutStreak2" ] ) )
        {
            struct.loadoutkillstreak2 = callbackloadout[ "loadoutStreak2" ];
        }
        
        if ( isdefined( callbackloadout[ "loadoutStreak3" ] ) )
        {
            struct.loadoutkillstreak3 = callbackloadout[ "loadoutStreak3" ];
        }
        
        if ( isdefined( callbackloadout[ #"disablebackuppistol" ] ) )
        {
            struct.disablebackuppistol = callbackloadout[ #"disablebackuppistol" ];
        }
    }
    
    struct.var_8216875ae46583d4 = isdefined( struct.loadoutperks ) && struct.loadoutperks.size > 0;
    struct.var_99e10a3e980b2a86 = isdefined( struct.loadoutextraperks ) && struct.loadoutextraperks.size > 0;
}

// Namespace class
// Params 2
// Checksum 0x7064361f, Offset: 0xbad2
// Size: 0x401
function loadout_updateclassdefault( struct, class )
{
    if ( !isvalidclass( class ) )
    {
        class = "default1";
    }
    
    classindex = getclassindex( class );
    self.class_num = classindex;
    classtablename = level.classtablename;
    
    if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
    {
        if ( prestige_challenge_utility::function_ba46581a84b1edac() )
        {
            if ( !prestige_challenge_utility::function_38b6d988f3bd7208( class ) )
            {
                class = prestige_challenge_utility::function_615e6a7465344cf5();
            }
            
            classtablename = level.var_71749a9a1664454;
        }
    }
    
    loadout_updateclassdefault_weapons( struct, classindex );
    struct.loadoutequipmentprimary = table_getequipmentprimary( classtablename, classindex );
    struct.var_cedaf611f3c02546 = table_getequipmentprimaryattachments( classtablename, classindex );
    struct.loadoutextraequipmentprimary = table_getextraequipmentprimary( classtablename, classindex );
    struct.loadoutequipmentsecondary = table_getequipmentsecondary( classtablename, classindex );
    struct.var_7a0c0f1f8552f73e = table_getequipmentsecondaryattachments( classtablename, classindex );
    struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary( classtablename, classindex );
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = function_aae501d9b54400d9( classtablename, classindex );
        struct.var_b32cdcb41c22f1be = function_57f521192747393d( classtablename, classindex );
        struct.loadoutExtraEquipmentTertiary = function_4061d408e63f77f5( classtablename, classindex );
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        function_5a1b748b70ab10c2( struct );
    }
    
    struct.loadoutusingspecialist = table_getspecialist( classtablename, classindex );
    struct.loadoutfieldupgrade1 = table_getsuper( classtablename, classindex, 0 );
    struct.var_6dd76aa72f0c26e1 = table_getsuperattachments( classtablename, classindex, 0 );
    struct.loadoutfieldupgrade2 = table_getsuper( classtablename, classindex, 1 );
    struct.var_3834964fc455658e = table_getsuperattachments( classtablename, classindex, 1 );
    struct.loadoutarchetype = cac_getcharacterarchetype();
    
    if ( level.projectbundle.var_6549de919aac5cec || level.gamemodebundle.var_6549de919aac5cec )
    {
        if ( level.gamemodebundle.streaktypeenabled )
        {
            struct.loadoutstreaktype = function_65fbd50b1b899df7( classtablename, classindex );
        }
        
        struct.loadoutkillstreak1 = function_174dc1fa6552b3( classtablename, classindex, 0 );
        struct.loadoutkillstreak2 = function_174dc1fa6552b3( classtablename, classindex, 1 );
        struct.loadoutkillstreak3 = function_174dc1fa6552b3( classtablename, classindex, 2 );
    }
    else
    {
        struct.loadoutkillstreak1 = cac_getkillstreak( 0, class );
        struct.loadoutkillstreak2 = cac_getkillstreak( 1, class );
        struct.loadoutkillstreak3 = cac_getkillstreak( 2, class );
        struct.var_2ca84378b025c036 = function_9f6f840868cfaebb( 0, class, struct.loadoutkillstreak1 );
        struct.var_efe096b4dabb84e3 = function_9f6f840868cfaebb( 1, class, struct.loadoutkillstreak2 );
        struct.var_dc8ecd8732f650c4 = function_9f6f840868cfaebb( 2, class, struct.loadoutkillstreak3 );
    }
    
    struct.loadoutrigtrait = cac_getloadoutarchetypeperk();
    struct.backpackitems = function_f261720ab677a2a9( classtablename, classindex );
    
    if ( utility::issharedfuncdefined( #"instanceInventory", #"hash_4cd131c09ba7529a" ) && !function_2ed2b8bcdb9e828( self, class ) )
    {
        [[ utility::getsharedfunc( #"instanceInventory", #"hash_4cd131c09ba7529a" ) ]]( self, struct );
    }
    
    if ( isdefined( self.callbacks[ #"hash_dd3cc659d7255154" ] ) || isdefined( level.callbacks[ #"hash_dd3cc659d7255154" ] ) )
    {
        callback::callback( #"hash_dd3cc659d7255154", { #class:class, #struct:struct } );
    }
}

// Namespace class
// Params 2
// Checksum 0x318234d, Offset: 0xbedb
// Size: 0x263
function loadout_updateclassdefault_weapons( struct, classindex )
{
    classtablename = level.classtablename;
    
    if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
    {
        if ( prestige_challenge_utility::function_ba46581a84b1edac() )
        {
            classtablename = level.var_71749a9a1664454;
        }
    }
    
    struct.loadoutprimary = table_getweapon( classtablename, classindex, 0 );
    wildcard = function_6e209ed6e2db2b0b( classtablename, classindex );
    var_ab6cf2494c881f0a = isdefined( level.gamemodebundle.var_54a7512237514195 );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments + var_ab6cf2494c881f0a ; attachmentindex++ )
    {
        struct.loadoutprimaryattachments[ attachmentindex ] = table_getweaponattachment( classtablename, classindex, 0, attachmentindex );
    }
    
    struct.loadoutprimarycamo = table_getweaponcamo( classtablename, classindex, 0 );
    struct.loadoutprimaryreticle = table_getweaponreticle( classtablename, classindex, 0 );
    struct.loadoutprimaryvariantid = table_getweaponvariantid( classtablename, classindex, 0, struct.loadoutprimary, 1 );
    struct.loadoutsecondary = table_getweapon( classtablename, classindex, 1 );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments + var_ab6cf2494c881f0a ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = table_getweaponattachment( classtablename, classindex, 1, attachmentindex );
    }
    
    struct.loadoutsecondarycamo = table_getweaponcamo( classtablename, classindex, 1 );
    struct.loadoutsecondaryreticle = table_getweaponreticle( classtablename, classindex, 1 );
    struct.loadoutsecondaryvariantid = table_getweaponvariantid( classtablename, classindex, 1, struct.loadoutsecondary, 1 );
    
    if ( level.tertiaryweaponslotenabled )
    {
        struct.loadouttertiary = table_getweapon( classtablename, classindex, 2 );
        var_dc1543b984237bf8 = weapon::function_222f1c49e082a080( wildcard );
        
        for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
        {
            struct.var_c6ea1bb7cfd9e16e[ attachmentindex ] = table_getweaponattachment( classtablename, classindex, 2, attachmentindex );
        }
        
        struct.loadouttertiarycamo = table_getweaponcamo( classtablename, classindex, 2 );
        struct.loadouttertiaryreticle = table_getweaponreticle( classtablename, classindex, 2 );
    }
}

// Namespace class
// Params 2
// Checksum 0x66aa9a81, Offset: 0xc146
// Size: 0x195
function loadout_updatestreaktype( struct, class )
{
    if ( level.gamemodebundle.streaktypeenabled )
    {
        classtype = loadout_getclasstype( class );
        classindex = getclassindex( class );
        
        if ( classtype == "custom" )
        {
            var_1b53333caf312d33 = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"killstreaksettings", #"killstreakearnmode" );
            streaktypes = getscriptbundle( level.gamemodebundle.streaktypelist ).streak_type_list;
            self.streaktype = getscriptbundle( streaktypes[ var_1b53333caf312d33 - 1 ].bundle );
        }
        else if ( classtype == "callback" )
        {
            return;
        }
        else if ( classtype == "gamemode" )
        {
            return;
        }
        else
        {
            classtablename = level.classtablename;
            
            if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
            {
                if ( prestige_challenge_utility::function_ba46581a84b1edac() && prestige_challenge_utility::function_38b6d988f3bd7208( class ) )
                {
                    classtablename = level.var_71749a9a1664454;
                }
            }
            
            self.streaktype = function_65fbd50b1b899df7( classtablename, classindex );
        }
    }
    else if ( struct.loadoutusingspecialist )
    {
        self.streaktype = "streaktype_specialist";
    }
    else
    {
        self.streaktype = "streaktype_assault";
    }
    
    struct.loadoutstreaktype = self.streaktype;
}

// Namespace class
// Params 2
// Checksum 0xfefc7a6e, Offset: 0xc2e3
// Size: 0x9f5
function loadout_updateabilities( struct, class )
{
    if ( br_instance_inventory::function_926a8f8643d34690() && getdvarint( @"hash_48587f2cfa448879", 1 ) == 1 )
    {
        return;
    }
    
    if ( common_instance_inventory::isenabled() )
    {
        return;
    }
    
    /#
        if ( common_instance_inventory::devenabled() )
        {
            return;
        }
    #/
    
    if ( !isdefined( self.pers[ "loadoutPerks" ] ) )
    {
        self.pers[ "loadoutPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutStandardPerks" ] ) )
    {
        self.pers[ "loadoutStandardPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutExtraPerks" ] ) )
    {
        self.pers[ "loadoutExtraPerks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutRigTrait" ] ) )
    {
        self.pers[ "loadoutRigTrait" ] = [];
    }
    
    if ( !isdefined( self.pers[ "loadoutUsingSpecialist" ] ) )
    {
        self.pers[ "loadoutUsingSpecialist" ] = 0;
    }
    
    isdefaultclass = getsubstr( class, 0, 7 ) == "default";
    classtablename = level.classtablename;
    
    if ( getcodegate( #"hash_d8bf19b3daff8a30" ) )
    {
        if ( prestige_challenge_utility::function_ba46581a84b1edac() && prestige_challenge_utility::function_38b6d988f3bd7208( class ) )
        {
            isdefaultclass = 1;
            classtablename = level.var_71749a9a1664454;
        }
    }
    
    if ( struct.loadoutperksfromgamemode || struct.var_8216875ae46583d4 )
    {
        loadoutperks = struct.loadoutperks;
        struct.loadoutperks = [];
        
        foreach ( perk in loadoutperks )
        {
            if ( !isdefined( perk ) || perk == "specialty_null" )
            {
                continue;
            }
            
            slot = perks::getperkslot( perk );
            
            if ( !isdefined( slot ) )
            {
                continue;
            }
            
            struct.loadoutperks[ struct.loadoutperks.size ] = perk;
            struct.loadoutstandardperks[ struct.loadoutstandardperks.size ] = perk;
        }
        
        if ( struct.loadoutextraperksfromgamemode || struct.var_99e10a3e980b2a86 )
        {
            struct.loadoutextraperks = struct.loadoutextraperks;
        }
    }
    else if ( !perk::perksenabled() )
    {
        return;
    }
    else if ( class == "juggernaut" || class == "copied" || class == "superpower" )
    {
    }
    else if ( game_utility_mp::ismutationgamemodezombie() )
    {
        return;
    }
    else
    {
        classteam = loadout_getclassteam( class );
        classindex = getclassindex( class );
        perkpackage = [];
        perkpackageenabled = perk::function_93baad77ae8e5757();
        
        if ( perkpackageenabled )
        {
            if ( classteam != "none" )
            {
            }
            else if ( isdefaultclass )
            {
                defaultperkpackage = table_getperkpackage( classtablename, classindex );
                
                if ( isdefined( defaultperkpackage ) )
                {
                    perkpackage = defaultperkpackage;
                }
            }
            else
            {
                var_2e167293ef29827e = function_f44a0914ea5bdf38( self.class_num );
                perkpackage = function_321cbfe02cd247bc( var_2e167293ef29827e );
            }
        }
        
        var_53a317db4937e644 = 0;
        
        if ( perkpackage.size > 0 )
        {
            foreach ( perk in perkpackage )
            {
                if ( perk != "specialty_null" )
                {
                    var_53a317db4937e644 = 1;
                    break;
                }
            }
            
            assert( var_53a317db4937e644, "<dev string:x243>" );
        }
        
        if ( level.gamemodebundle.var_1a2f8cded6a4cc9b || level.gamemodebundle.var_c6b4f78dd0a7a36 )
        {
            if ( isdefaultclass || classteam != "none" )
            {
                majorperk = function_f5ceaf83aec79f3a( classtablename, classindex );
                
                if ( isdefined( majorperk ) )
                {
                    struct.loadoutperks[ struct.loadoutperks.size ] = majorperk;
                }
            }
            else
            {
                majorperk = function_3d3ba2b618c7313d( classindex );
                
                if ( isdefined( majorperk ) && majorperk != "specialty_null" )
                {
                    struct.loadoutperks[ struct.loadoutperks.size ] = majorperk;
                }
            }
        }
        
        if ( level.gamemodebundle.var_abac368f5bbda953 )
        {
            for ( skillindex = 0; skillindex < 3 ; skillindex++ )
            {
                self setclientomnvar( "ui_operator_skill_" + skillindex, "none" );
            }
            
            if ( isdefaultclass || classteam != "none" )
            {
                skills = function_b4da613a244ba2fb( classtablename, classindex );
                
                if ( isdefined( skills ) )
                {
                    skillindex = 0;
                    
                    foreach ( skill in skills )
                    {
                        struct.loadoutperks[ struct.loadoutperks.size ] = skill.skillref;
                        self setclientomnvar( "ui_operator_skill_" + skillindex, skill.skillref );
                        skillindex++;
                    }
                }
            }
            else
            {
                for ( skillindex = 0; skillindex < 3 ; skillindex++ )
                {
                    skill = function_256fa068b5933dfd( classindex, skillindex );
                    
                    if ( isdefined( skill ) && skill != "specialty_null" )
                    {
                        struct.loadoutperks[ struct.loadoutperks.size ] = skill;
                        self setclientomnvar( "ui_operator_skill_" + skillindex, skill );
                    }
                }
            }
        }
        
        usingperkpackage = perkpackageenabled && var_53a317db4937e644;
        var_e83a206c880abdd4 = perk::function_2d1b2c825510b212();
        
        if ( var_e83a206c880abdd4 )
        {
            for ( perkindex = 0; perkindex < 5 ; perkindex++ )
            {
                if ( classteam != "none" )
                {
                    perk = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "loadoutPerks" );
                }
                else if ( isdefaultclass )
                {
                    perk = function_237fdae48e47e8fc( classtablename, classindex, perkindex );
                }
                else
                {
                    perk = function_57e20038d70fdb33( self.class_num, perkindex );
                }
                
                if ( isdefined( perk ) && perk != "specialty_null" )
                {
                    struct.loadoutperks[ struct.loadoutperks.size ] = perk;
                    struct.loadoutstandardperks[ struct.loadoutstandardperks.size ] = perk;
                }
            }
        }
        else
        {
            if ( isdefaultclass )
            {
                struct.loadoutwildcard = function_6e209ed6e2db2b0b( classtablename, classindex );
            }
            
            var_d60b4f65d442b907 = level.gamemodebundle.var_88172641641648e1 ?? 3;
            
            if ( perks::function_ae69f867e887ac4a( "wildcard_perk_greed" ) )
            {
                if ( struct.loadoutwildcard != "wildcard_perk_greed" )
                {
                    var_d60b4f65d442b907--;
                }
            }
            
            for ( perkindex = 0; perkindex < var_d60b4f65d442b907 ; perkindex++ )
            {
                if ( usingperkpackage )
                {
                    perk = perkpackage[ perkindex ];
                }
                else if ( classteam != "none" )
                {
                    perk = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "loadoutPerks" );
                }
                else if ( isdefaultclass )
                {
                    perk = table_getperk( classtablename, classindex, perkindex );
                }
                else
                {
                    perk = cac_getloadoutperk( self.class_num, perkindex );
                }
                
                if ( isdefined( perk ) && perk != "specialty_null" )
                {
                    struct.loadoutperks[ struct.loadoutperks.size ] = perk;
                    struct.loadoutstandardperks[ struct.loadoutstandardperks.size ] = perk;
                }
            }
            
            for ( perkindex = 0; perkindex < 3 ; perkindex++ )
            {
                if ( classteam != "none" )
                {
                    perk = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "extraPerks" );
                }
                else if ( isdefaultclass )
                {
                    perk = table_getextraperk( classtablename, classindex, perkindex );
                }
                else
                {
                    perk = cac_getloadoutextraperk( self.class_num, perkindex );
                }
                
                if ( isdefined( perk ) && perk != "specialty_null" )
                {
                    struct.loadoutextraperks[ struct.loadoutextraperks.size ] = perk;
                }
            }
        }
        
        if ( classteam != "none" )
        {
            perk = game_utility_mp::getmatchrulesdatawithteamandindex( "defaultClasses", classteam, classindex, "class", "archetypePerk" );
        }
        else
        {
            perk = cac_getloadoutarchetypeperk();
        }
        
        if ( isdefined( perk ) && perk != "specialty_null" )
        {
            struct.loadoutperks[ struct.loadoutperks.size ] = perk;
            self.pers[ "loadoutRigTrait" ] = perk;
            struct.loadoutrigtrait = perk;
        }
    }
    
    /#
        assert( isdefined( level.perkbundles ) );
        
        foreach ( perk in struct.loadoutperks )
        {
            if ( perk == "<dev string:x27b>" || perk == "<dev string:x280>" )
            {
                continue;
            }
            
            assert( isdefined( level.perkbundles[ perk ] ) && isdefined( level.var_fadc1b38f6006441[ perk ] ), "<dev string:x28f>" + class + "<dev string:x298>" + perk );
        }
    #/
}

// Namespace class
// Params 1
// Checksum 0xa57efe1, Offset: 0xcce0
// Size: 0xce
function loadout_getclasstype( classname )
{
    classteam = loadout_getclassteam( classname );
    
    if ( classteam == "none" && !isdefined( classname ) )
    {
        return "custom";
    }
    
    if ( classteam != "none" )
    {
        return "team";
    }
    
    if ( issubstr( classname, "custom" ) )
    {
        return "custom";
    }
    
    if ( classname == "gamemode" )
    {
        return "gamemode";
    }
    
    if ( classname == "callback" )
    {
        return "callback";
    }
    
    if ( classname == "juggernaut" )
    {
        return "juggernaut";
    }
    
    if ( classname == "superpower" )
    {
        return "superpower";
    }
    
    if ( classname == "copied" )
    {
        return "copied";
    }
    
    return "default";
}

// Namespace class
// Params 0
// Checksum 0xeb21aeca, Offset: 0xcdb6
// Size: 0x46, Type: bool
function function_ad7e91d3dac61546()
{
    if ( level.leagueplaymatch )
    {
        if ( level.leagueplaytype == 1 && getdvarint( @"hash_ca2769e986904fa", 0 ) == 1 || level.leagueplaytype != 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 2
// Checksum 0x6a48a2c3, Offset: 0xce05
// Size: 0x99
function loadout_updateglobalclass( globalstruct, class )
{
    classtype = loadout_getclasstype( class );
    
    switch ( classtype )
    {
        case #"hash_33857c6e26098e6c":
            break;
        case #"hash_44e999799ff10fce":
            break;
        case #"hash_412d4adaf2412dc0":
            loadout_updateglobalclassgamemode( globalstruct, class );
            break;
        case #"hash_43e76e9ca2c4666":
            break;
        case #"hash_7038dec66d8275be":
            break;
        case #"hash_4ad475e6e15635bd":
            break;
    }
    
    return globalstruct;
}

// Namespace class
// Params 0
// Checksum 0x37c8977d, Offset: 0xcea7
// Size: 0x20
function function_f23baf5f65682744()
{
    if ( isdefined( level.var_a36865ea27883563 ) )
    {
        return [[ level.var_a36865ea27883563 ]]();
    }
    
    return !isbrgamemode();
}

// Namespace class
// Params 3
// Checksum 0x363cde91, Offset: 0xced0
// Size: 0x360
function loadout_updateclass( struct, class, allowthrottle = 0 )
{
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "loadout_updateClass: begin - class is " + ( class ?? "<undefined>" ) );
    
    if ( !isdefined( self.var_406090c6ef364821 ) )
    {
        self.var_406090c6ef364821 = 0;
    }
    
    self.var_406090c6ef364821++;
    
    if ( self.var_406090c6ef364821 > 10 )
    {
        self.var_406090c6ef364821--;
        return struct;
    }
    
    while ( self.var_a440780622ad4128 )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return struct;
    }
    
    self.var_a440780622ad4128 = 1;
    numloadouts = function_868832c7872f848e( level.classtablename );
    
    if ( !isagent( self ) && self isplayerheadless() && function_f23baf5f65682744() )
    {
        class = "default" + randomint( numloadouts ) + 1;
    }
    
    if ( !( level.leagueplaymatch || level.var_309e3d9dac389de6 ) )
    {
        if ( function_2ed2b8bcdb9e828( self, class ) && ( game_utility::getgametype() == "dmz" || game_utility::getgametype() == "ob" ) )
        {
            var_88b030afe8d7b0c0 = getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) == 1;
            loadoutindex = var_88b030afe8d7b0c0 ? 0 : randomint( numloadouts );
            class = "default" + loadoutindex + 1;
            self.var_9404f68c3560db = 1;
            function_c8af2f6f0e6e684( self, 0 );
        }
    }
    
    classtype = loadout_getclasstype( class );
    var_4d5575c6f9ec8a5b = function_ad7e91d3dac61546();
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "loadout_updateClass: switch statement - classType is " + ( classtype ?? "<undefined>" ) + ", class is " + ( class ?? "<undefined>" ) );
    
    switch ( classtype )
    {
        case #"hash_33857c6e26098e6c":
            loadout_updateclassteam( struct, class );
            break;
        case #"hash_44e999799ff10fce":
            loadout_updateclasscustom( struct, class, var_4d5575c6f9ec8a5b );
            break;
        case #"hash_412d4adaf2412dc0":
            loadout_updateclassgamemode( struct, class );
            break;
        case #"hash_43e76e9ca2c4666":
            loadout_updateclasscallback( struct );
            break;
        case #"hash_7038dec66d8275be":
            loadout_updateclassdefault( struct, class );
            break;
        case #"hash_4ad475e6e15635bd":
            break;
        case #"hash_80a9479df6c38d3d":
            break;
        case #"hash_bd4afc9a088efe45":
            break;
    }
    
    if ( !isdefined( self.class_num ) )
    {
        self.class_num = getclassindex( class );
    }
    
    function_3d518a47c4b095e6( struct, class );
    loadout_updatehasnvg( struct );
    loadout_updateclassfistweapons( struct );
    function_e2203059a355d05b( struct );
    function_3a4343f28cdf8044( struct );
    loadout_updatestreaktype( struct, class );
    loadout_updateabilities( struct, class );
    struct = loadout_validateclass( struct, class );
    iscustom = issubstr( class, "custom" ) || issubstr( class, "default" );
    loadout_updateclassfinalweapons( struct, iscustom, allowthrottle );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( level.modeupdateloadoutclass ) )
        {
            self [[ level.modeupdateloadoutclass ]]( struct );
        }
        
        self.var_a440780622ad4128 = undefined;
        self.var_406090c6ef364821--;
    }
    
    return struct;
}

// Namespace class
// Params 3
// Checksum 0x6cd5b2be, Offset: 0xd239
// Size: 0x72
function function_768676b5466bdb8b( struct, var_1bea5ba0503241d3, loadoutindex = undefined )
{
    loadoutfound = function_d85916071bcb512c( struct, var_1bea5ba0503241d3, loadoutindex );
    
    if ( !loadoutfound )
    {
        if ( !isdefined( loadoutindex ) )
        {
            var_2f4e6505b731029a = function_868832c7872f848e( var_1bea5ba0503241d3 );
            loadoutindex = randomintrange( 0, var_2f4e6505b731029a );
        }
        
        struct = function_bea358acf2701ef5( struct, loadoutindex, var_1bea5ba0503241d3 );
    }
    
    return struct;
}

// Namespace class
// Params 3
// Checksum 0xb75f36de, Offset: 0xd2b4
// Size: 0x4e4
function function_bea358acf2701ef5( struct, classindex, table )
{
    struct.loadoutarchetype = "archetype_assault";
    struct.loadoutprimary = table_getweapon( table, classindex, 0 );
    wildcard = function_6e209ed6e2db2b0b( table, classindex );
    classstruct = table_getitem( table, classindex );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    var_83417329f285ded6 = table_getweaponattachments( classstruct, 0 );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachmentname = var_83417329f285ded6[ attachmentindex ] ?? "none";
        
        if ( attachmentname == "" )
        {
            attachmentname = "none";
        }
        
        struct.loadoutprimaryattachments[ attachmentindex ] = attachmentname;
    }
    
    struct.loadoutprimarycamo = classstruct.primaryweapon.camo;
    struct.loadoutprimaryreticle = classstruct.primaryweapon.reticle;
    struct.var_69ae546f481034e2 = classstruct.primaryweapon.chroma;
    struct.var_bf06b7def8985709 = 0;
    struct.loadoutsecondary = table_getweapon( table, classindex, 1 );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    var_3ca2889466d62ee6 = table_getweaponattachments( classstruct, 1 );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachmentname = var_3ca2889466d62ee6[ attachmentindex ] ?? "none";
        
        if ( attachmentname == "" )
        {
            attachmentname = "none";
        }
        
        struct.loadoutsecondaryattachments[ attachmentindex ] = attachmentname;
    }
    
    struct.loadoutsecondarycamo = classstruct.secondaryweapon.camo;
    struct.loadoutsecondaryreticle = classstruct.secondaryweapon.reticle;
    struct.var_2bab3f4f3d38584a = classstruct.secondaryweapon.chroma;
    struct.var_8d1ed34c7709f241 = 0;
    struct.loadoutmeleeslot = "none";
    struct.loadoutequipmentprimary = classstruct.equipment.primary;
    struct.var_cedaf611f3c02546 = [];
    struct.loadoutequipmentsecondary = classstruct.equipment.secondary;
    struct.var_7a0c0f1f8552f73e = [];
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = classstruct.equipment.tertiary;
        struct.var_b32cdcb41c22f1be = [];
    }
    
    struct.loadouttertiary = table_getweapon( table, classindex, 2 );
    struct.loadouttertiarycamo = classstruct.tertiaryWeapon.camo;
    struct.loadouttertiaryreticle = classstruct.tertiaryWeapon.reticle;
    struct.var_de6bc6d1e7c111ea = classstruct.tertiaryWeapon.chroma;
    struct.var_ea6fecf8edebaf61 = 0;
    struct.loadoutstreaktype = "assault";
    struct.loadoutkillstreak1 = "none";
    struct.loadoutkillstreak2 = "none";
    struct.loadoutkillstreak3 = "none";
    struct.var_2ca84378b025c036 = 0;
    struct.var_efe096b4dabb84e3 = 0;
    struct.var_dc8ecd8732f650c4 = 0;
    struct.loadoutfieldupgrade1 = "super_br_extract";
    struct.var_6dd76aa72f0c26e1 = [];
    struct.loadoutfieldupgrade2 = "none";
    struct.var_3834964fc455658e = [];
    struct.var_6b08217cbc33ea5c = 0;
    struct.var_5e73e76f67b0afed = 0;
    struct.loadoutperks = [ classstruct.perks.perk1, classstruct.perks.perk2, classstruct.perks.perk3, classstruct.extraperks.perk1, classstruct.extraperks.perk2, classstruct.extraperks.perk3 ];
    struct.loadoutgesture = "playerData";
    return struct;
}

// Namespace class
// Params 3, eflags: 0x4
// Checksum 0xca2082c2, Offset: 0xd7a1
// Size: 0x40d, Type: bool
function private function_d85916071bcb512c( struct, itemspawnlist, loadoutindex = undefined )
{
    randomstruct = function_5cb1c189c2761b9c( itemspawnlist, loadoutindex );
    
    if ( !isdefined( randomstruct ) )
    {
        struct.var_74bf72275e8840fc = 0;
        return false;
    }
    
    struct.var_74bf72275e8840fc = 1;
    struct.loadoutarchetype = "archetype_assault";
    struct.loadoutprimary = randomstruct.loadoutprimary;
    struct.loadoutprimaryobject = randomstruct.var_685250dd1aaec20b ? item_weapon::function_477bf1207c6672a5( randomstruct.var_685250dd1aaec20b ) : nullweapon();
    struct.loadoutprimaryattachments = arraycopy( randomstruct.loadoutprimaryattachments );
    struct.loadoutprimarycamo = randomstruct.loadoutprimarycamo;
    struct.loadoutprimaryreticle = randomstruct.loadoutprimaryreticle;
    struct.var_69ae546f481034e2 = randomstruct.var_69ae546f481034e2;
    struct.var_bf06b7def8985709 = randomstruct.var_bf06b7def8985709;
    struct.loadoutsecondary = randomstruct.loadoutsecondary;
    struct.loadoutsecondaryobject = randomstruct.var_1b64e2b058e26723 ? item_weapon::function_477bf1207c6672a5( randomstruct.var_1b64e2b058e26723 ) : nullweapon();
    struct.loadoutsecondaryattachments = arraycopy( randomstruct.loadoutsecondaryattachments );
    struct.loadoutsecondarycamo = randomstruct.loadoutsecondarycamo;
    struct.loadoutsecondaryreticle = randomstruct.loadoutsecondaryreticle;
    struct.var_2bab3f4f3d38584a = randomstruct.var_2bab3f4f3d38584a;
    struct.var_8d1ed34c7709f241 = randomstruct.var_8d1ed34c7709f241;
    struct.loadoutmeleeslot = "none";
    struct.loadoutequipmentprimary = randomstruct.loadoutequipmentprimary;
    struct.var_cedaf611f3c02546 = [];
    struct.loadoutequipmentsecondary = randomstruct.loadoutequipmentsecondary;
    struct.var_7a0c0f1f8552f73e = [];
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = randomstruct.loadoutEquipmentTertiary;
        struct.var_b32cdcb41c22f1be = [];
    }
    
    struct.loadouttertiary = randomstruct.loadouttertiary;
    struct.var_9dcef9a8722c3abb = randomstruct.var_f29ed4ccda1704c3 ? item_weapon::function_477bf1207c6672a5( randomstruct.var_f29ed4ccda1704c3 ) : nullweapon();
    struct.loadouttertiarycamo = randomstruct.loadouttertiarycamo;
    struct.loadouttertiaryreticle = randomstruct.loadouttertiaryreticle;
    struct.var_de6bc6d1e7c111ea = randomstruct.var_de6bc6d1e7c111ea;
    struct.var_ea6fecf8edebaf61 = randomstruct.var_ea6fecf8edebaf61;
    struct.loadoutstreaktype = "assault";
    struct.loadoutkillstreak1 = "none";
    struct.loadoutkillstreak2 = "none";
    struct.loadoutkillstreak3 = "none";
    struct.var_2ca84378b025c036 = 0;
    struct.var_efe096b4dabb84e3 = 0;
    struct.var_dc8ecd8732f650c4 = 0;
    struct.loadoutfieldupgrade1 = "super_br_extract";
    struct.var_6dd76aa72f0c26e1 = [];
    struct.loadoutfieldupgrade2 = "none";
    struct.var_3834964fc455658e = [];
    struct.var_6b08217cbc33ea5c = 0;
    struct.var_5e73e76f67b0afed = 0;
    struct.loadoutperks = arraycopy( randomstruct.loadoutperks );
    struct.loadoutgesture = "playerData";
    return true;
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x1be189fb, Offset: 0xdbb7
// Size: 0x508
function private function_1d1b10e51fd0ca1f( itemspawnlist )
{
    loadout = getscriptbundle( itemspawnlist );
    assert( isdefined( loadout ) );
    weapons = [];
    lethals = [];
    tacticals = [];
    perks = [];
    
    foreach ( itementry in loadout.itementries )
    {
        if ( !isdefined( itementry.itemspawnentry ) || !isdefined( itementry.weight ) || itementry.weight == 0 )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itementry.itemspawnentry );
        type = common_item::function_16e8c106491eeaca( itembundle );
        
        switch ( type )
        {
            case #"hash_27124c6c97ccffa1":
                weapons[ weapons.size ] = itementry.itemspawnentry;
                break;
            case #"hash_339227cb650975db":
                lethals = arraycombineunique( lethals, [ itembundle.ref ] );
                break;
            case #"hash_850999d7864fa3b4":
                tacticals = arraycombineunique( tacticals, [ itembundle.ref ] );
                break;
            case #"hash_ab671284a3fc4e3d":
                perks = arraycombineunique( perks, [ itembundle.ref ] );
                break;
            default:
                break;
        }
    }
    
    var_685250dd1aaec20b = weapons[ 0 ] ? getscriptbundle( weapons[ 0 ] ) : undefined;
    
    if ( var_685250dd1aaec20b )
    {
        loadoutprimaryobject = item_weapon::function_477bf1207c6672a5( var_685250dd1aaec20b );
        loadoutprimary = var_685250dd1aaec20b.baseweapon;
        loadoutprimaryattachments = loadoutprimaryobject.attachments;
        loadoutprimarycamo = getweaponcamoname( loadoutprimaryobject ) ?? "camo_none";
        loadoutprimaryreticle = function_4af0b444e167186d( loadoutprimaryobject ) ?? "none";
    }
    else
    {
        loadoutprimaryobject = nullweapon();
        loadoutprimary = "none";
        loadoutprimaryattachments = [];
        loadoutprimarycamo = "camo_none";
        loadoutprimaryreticle = "none";
    }
    
    var_1b64e2b058e26723 = weapons[ 1 ] ? getscriptbundle( weapons[ 1 ] ) : undefined;
    
    if ( var_1b64e2b058e26723 )
    {
        loadoutsecondaryobject = item_weapon::function_477bf1207c6672a5( var_1b64e2b058e26723 );
        loadoutsecondary = var_1b64e2b058e26723.baseweapon;
        loadoutsecondaryattachments = loadoutsecondaryobject.attachments;
        loadoutsecondarycamo = getweaponcamoname( loadoutsecondaryobject ) ?? "camo_none";
        loadoutsecondaryreticle = function_4af0b444e167186d( loadoutsecondaryobject ) ?? "none";
    }
    else
    {
        loadoutsecondaryobject = nullweapon();
        loadoutsecondary = "none";
        loadoutsecondaryattachments = [];
        loadoutsecondarycamo = "camo_none";
        loadoutsecondaryreticle = "none";
    }
    
    var_f29ed4ccda1704c3 = weapons[ 2 ] ? getscriptbundle( weapons[ 2 ] ) : undefined;
    
    if ( var_f29ed4ccda1704c3 )
    {
        var_9dcef9a8722c3abb = item_weapon::function_477bf1207c6672a5( var_f29ed4ccda1704c3 );
        loadouttertiary = var_f29ed4ccda1704c3.baseweapon;
        loadouttertiarycamo = getweaponcamoname( var_9dcef9a8722c3abb ) ?? "camo_none";
        loadouttertiaryreticle = function_4af0b444e167186d( var_9dcef9a8722c3abb ) ?? "none";
    }
    else
    {
        var_9dcef9a8722c3abb = nullweapon();
        loadouttertiary = "none";
        loadouttertiarycamo = "camo_none";
        loadouttertiaryreticle = "none";
    }
    
    loadoutequipmentprimary = lethals[ 0 ] ?? "none";
    loadoutequipmentsecondary = tacticals[ 0 ] ?? "none";
    loadoutEquipmentTertiary = "none";
    var_69ae546f481034e2 = undefined;
    var_2bab3f4f3d38584a = undefined;
    var_de6bc6d1e7c111ea = undefined;
    return { #loadoutperks:perks, #loadoutEquipmentTertiary:loadoutEquipmentTertiary, #loadoutequipmentsecondary:loadoutequipmentsecondary, #loadoutequipmentprimary:loadoutequipmentprimary, #var_de6bc6d1e7c111ea:var_de6bc6d1e7c111ea, #loadouttertiaryreticle:loadouttertiaryreticle, #loadouttertiarycamo:loadouttertiarycamo, #loadouttertiary:loadouttertiary, #var_f29ed4ccda1704c3:var_f29ed4ccda1704c3, #var_2bab3f4f3d38584a:var_2bab3f4f3d38584a, #loadoutsecondaryreticle:loadoutsecondaryreticle, #loadoutsecondarycamo:loadoutsecondarycamo, #loadoutsecondaryattachments:loadoutsecondaryattachments, #loadoutsecondary:loadoutsecondary, #var_1b64e2b058e26723:var_1b64e2b058e26723, #var_69ae546f481034e2:var_69ae546f481034e2, #loadoutprimaryreticle:loadoutprimaryreticle, #loadoutprimarycamo:loadoutprimarycamo, #loadoutprimaryattachments:loadoutprimaryattachments, #loadoutprimary:loadoutprimary, #var_685250dd1aaec20b:var_685250dd1aaec20b };
}

// Namespace class
// Params 2, eflags: 0x4
// Checksum 0x6bbf3ab8, Offset: 0xe0c8
// Size: 0x233
function private function_5cb1c189c2761b9c( itemspawnlist, loadoutindex = undefined )
{
    assert( itemspawnlist );
    
    if ( !isdefined( level.var_3b7ddf0d20373155 ) )
    {
        level.var_3b7ddf0d20373155 = [];
    }
    
    cache = level.var_3b7ddf0d20373155;
    loadouts = cache[ itemspawnlist ];
    
    if ( !isdefined( loadouts ) )
    {
        loadoutsbundle = getscriptbundle( itemspawnlist );
        loadouts = [];
        
        foreach ( entry in loadoutsbundle.itemlistentries )
        {
            if ( !isdefined( entry.itemspawnlist ) || !isdefined( entry.weight ) || entry.weight == 0 )
            {
                continue;
            }
            
            loadout = { #weight:entry.weight, #bundlename:hashcat( %"itemspawnlist:", entry.itemspawnlist ) };
            loadouts[ loadouts.size ] = loadout;
        }
        
        cache[ itemspawnlist ] = loadouts;
    }
    
    if ( isdefined( loadoutindex ) )
    {
        itemspawnliststring = getxhashhexname( itemspawnlist ?? #"undefined" );
        
        /#
            itemspawnliststring = getxhashsourcename( itemspawnlist ?? #"undefined" );
        #/
        
        assert( loadoutindex >= 0 && loadoutindex < loadouts.size, "<dev string:x2b4>" + loadoutindex + "<dev string:x2ed>" + itemspawnliststring + "<dev string:x312>" + loadouts.size );
    }
    
    if ( loadouts.size == 0 )
    {
        return;
    }
    
    loadout = isdefined( loadoutindex ) ? loadouts[ loadoutindex ] : utility::random_weighted_struct( loadouts );
    
    if ( !isdefined( loadout ) )
    {
        return;
    }
    
    if ( !isdefined( loadout.struct ) )
    {
        loadout.struct = function_1d1b10e51fd0ca1f( loadout.bundlename );
    }
    
    return loadout.struct;
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x5c98e552, Offset: 0xe304
// Size: 0xbc, Type: bool
function private function_6c4f192694cfe827( itemspawnlist )
{
    assert( itemspawnlist );
    loadoutsbundle = getscriptbundle( itemspawnlist );
    
    foreach ( entry in loadoutsbundle.itemlistentries )
    {
        if ( isdefined( entry.itemspawnlist ) && entry.weight > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 1
// Checksum 0xe7dd10fe, Offset: 0xe3c9
// Size: 0x19f
function loadout_updateclassfistweapons( struct )
{
    if ( !isdefined( struct.loadoutprimary ) )
    {
        struct.loadoutprimary = "none";
    }
    
    if ( !isdefined( struct.loadoutsecondary ) )
    {
        struct.loadoutsecondary = "none";
    }
    
    if ( struct.loadoutprimary == "none" )
    {
        struct.loadoutprimary = self.var_2516791e1cd27f66 ? "none" : level.defaultfist.basename;
    }
    
    if ( game_utility_mp::function_7f1dcc0fc932f72a() || self.var_2516791e1cd27f66 )
    {
        if ( struct.loadoutsecondary == "none" )
        {
            struct.loadoutsecondary = "none";
        }
    }
    else if ( struct.loadoutsecondary == "none" && !weapon::isfistweapon( struct.loadoutprimary ) && !self.isjuggernaut )
    {
        struct.loadoutsecondary = level.defaultfist.basename;
    }
    else if ( weapon::isfistweapon( struct.loadoutprimary ) && weapon::isfistweapon( struct.loadoutsecondary ) )
    {
        struct.loadoutsecondary = "none";
    }
    
    if ( level.gametypebundle.var_ea4ec8fa0e468cf9 && weapon::isfistweapon( struct.loadoutsecondary ) )
    {
        struct.loadoutsecondary = "none";
    }
}

// Namespace class
// Params 1
// Checksum 0xa3b7327d, Offset: 0xe570
// Size: 0x3f
function function_e2203059a355d05b( struct )
{
    if ( struct.loadoutswimweapon == "none" )
    {
        struct.loadoutswimweapon = level.defaultswimweapon.basename;
    }
}

// Namespace class
// Params 1
// Checksum 0xdfa882c7, Offset: 0xe5b7
// Size: 0x3f
function function_3a4343f28cdf8044( struct )
{
    if ( struct.loadoutclimbweapon == "none" )
    {
        struct.loadoutclimbweapon = level.var_f8ac15ada97a702a.basename;
    }
}

// Namespace class
// Params 1
// Checksum 0xae150ea, Offset: 0xe5fe
// Size: 0x232
function function_5a1b748b70ab10c2( struct )
{
    primary = level.var_613ba3e28ca2d235 ? struct.loadoutEquipmentTertiary : struct.loadoutequipmentsecondary;
    var_a77de173405af8aa = level.var_613ba3e28ca2d235 ? struct.var_b32cdcb41c22f1be : struct.var_7a0c0f1f8552f73e;
    primaryvariantid = level.var_613ba3e28ca2d235 ? struct.var_324b19b627387508 : struct.var_9481e959139fe88;
    extraequipmentprimary = level.var_613ba3e28ca2d235 ? struct.loadoutExtraEquipmentTertiary : struct.loadoutextraequipmentsecondary;
    secondary = struct.loadoutequipmentprimary;
    var_b03a616e6aaf91ba = struct.var_cedaf611f3c02546;
    secondaryvariantid = struct.var_a1191d5606e653f0;
    extraequipmentsecondary = struct.loadoutextraequipmentprimary;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        tertiary = struct.loadoutequipmentsecondary;
        tertiaryattachments = struct.var_7a0c0f1f8552f73e;
        tertiaryvariantid = struct.var_9481e959139fe88;
        extraequipmenttertiary = struct.loadoutextraequipmentsecondary;
    }
    
    struct.loadoutequipmentprimary = primary;
    struct.var_cedaf611f3c02546 = var_a77de173405af8aa;
    struct.var_a1191d5606e653f0 = primaryvariantid;
    struct.loadoutextraequipmentprimary = extraequipmentprimary;
    struct.loadoutequipmentsecondary = secondary;
    struct.var_7a0c0f1f8552f73e = var_b03a616e6aaf91ba;
    struct.var_9481e959139fe88 = secondaryvariantid;
    struct.loadoutextraequipmentsecondary = extraequipmentsecondary;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        struct.loadoutEquipmentTertiary = tertiary;
        struct.var_b32cdcb41c22f1be = tertiaryattachments;
        struct.var_324b19b627387508 = tertiaryvariantid;
        struct.loadoutExtraEquipmentTertiary = extraequipmenttertiary;
    }
}

// Namespace class
// Params 1
// Checksum 0x50661149, Offset: 0xe838
// Size: 0x23
function loadout_updatehasnvg( struct )
{
    if ( utility::function_2a082dafe6f4bd5b() )
    {
        struct.loadouthasnvg = 1;
    }
}

// Namespace class
// Params 2
// Checksum 0xda8fac1a, Offset: 0xe863
// Size: 0x1d3
function loadout_validateclass( struct, class )
{
    var_8230ac7ada026a03 = game_utility::getgametype() == "gold_gun" && getdvarint( @"hash_131708578e1fbe81", 1 );
    var_fdec62d6d6a42362 = getmatchrulesdata( "commonOption", "loadoutRestrictions" ) ?? 0;
    validatedefaultclass = ( var_8230ac7ada026a03 || var_fdec62d6d6a42362 || game_utility_mp::isanymlgmatch() || game_utility_mp::function_389f6e205b205e99() ) && issubstr( class, "default" );
    
    if ( self.pers[ "forceDefaultLoadouts" ] )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "loadout_validateClass: self.pers[ 'forceDefaultLoadouts' ] is true, calling loadout_updateClassDefault() using 'default1'" );
        loadout_updateclassdefault( struct, "default1" );
        self.pers[ "forceDefaultLoadouts" ] = 0;
        return struct;
    }
    
    if ( !level.gamemodebundle.var_88a15fb9fa8c3ae4 )
    {
        if ( issubstr( class, "custom" ) || validatedefaultclass )
        {
            var_25cd9baa4bdd20fd = validation::validateloadout( struct, class );
            
            if ( var_25cd9baa4bdd20fd && !self isplayerheadless() && !issubstr( tolower( var_25cd9baa4bdd20fd ), "none" ) && !issubstr( tolower( var_25cd9baa4bdd20fd ), "fists" ) && ( !level.var_309e3d9dac389de6 || level.var_309e3d9dac389de6 && !issubstr( tolower( var_25cd9baa4bdd20fd ), "restricted" ) ) )
            {
                script::function_2e2007575f92910d( "[Loadout] bad validation for player " + ( self getplayerunoid() ?? "" ) + " with class : " + ( class ?? "" ) + ". " + ( var_25cd9baa4bdd20fd ?? "" ) );
            }
            
            return struct;
        }
        else if ( !isbrgamemode() )
        {
            validation::validatekillstreaks( struct );
        }
    }
    
    return struct;
}

// Namespace class
// Params 1
// Checksum 0x34cecf71, Offset: 0xea3f
// Size: 0xec
function loadout_forcearchetype( struct )
{
    forcearchetype = getdvarint( @"forcearchetype", 0 );
    
    if ( forcearchetype > 0 )
    {
        idx = getdvarint( @"forcearchetype", 0 );
        
        switch ( idx )
        {
            case 1:
                struct.loadoutarchetype = "archetype_assault";
                break;
            default:
                assertmsg( "<dev string:x31e>" );
                struct.loadoutarchetype = "archetype_assault";
                break;
        }
        
        return;
    }
    
    if ( forcearchetype == -1 )
    {
        archetypes = [ "archetype_assault" ];
        rand = randomint( archetypes.size );
        struct.loadoutarchetype = archetypes[ rand ];
        self iprintlnbold( "Random Archetype: " + archetypes[ rand ] );
    }
}

// Namespace class
// Params 2
// Checksum 0xcd49ef15, Offset: 0xeb33
// Size: 0x28c
function loadout_updateplayerarchetype( struct, options )
{
    /#
        loadout_forcearchetype( struct );
    #/
    
    if ( !self.btestclient )
    {
        if ( !isdefined( level.aonrules ) || level.aonrules == 0 )
        {
            assert( struct.loadoutarchetype != "<dev string:x27b>", "<dev string:x35e>" );
        }
    }
    
    self.loadoutarchetype = struct.loadoutarchetype;
    weapons::updatemovespeedscale();
    move_double_jump = 1;
    move_slide = 2;
    move_wall_run = 4;
    move_dodge = 8;
    movemask = 0;
    funcapply = undefined;
    clothtype = undefined;
    maxenergy = 400;
    restorerate = 400;
    resttime = 900;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        restorerate = 133.333;
        resttime = 1800;
    }
    
    switch ( self.loadoutarchetype )
    {
        case #"hash_98ff6f21872f18e0":
            movemask = move_double_jump | move_slide | move_wall_run;
            funcapply = &archassault::applyarchetype;
            clothtype = "vestlight";
            self.clothtype = clothtype;
            break;
        default:
            if ( !self.btestclient )
            {
                if ( !isdefined( level.aonrules ) || level.aonrules == 0 )
                {
                    assertmsg( "<dev string:x3b0>" + struct.loadoutarchetype );
                }
            }
            
            break;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_ba3719a1ad298b5", 0 );
    #/
    
    if ( getdvarint( @"hash_ba3719a1ad298b5" ) )
    {
        self allowdoublejump( movemask & move_double_jump );
        self allowwallrun( movemask & move_wall_run );
        self allowdodge( movemask & move_dodge );
    }
    else
    {
        self allowwallrun( 0 );
        
        if ( !options.allowdoublejump )
        {
            self allowdoublejump( 0 );
        }
        
        self allowwallrun( 0 );
        self allowdodge( 0 );
    }
    
    self allowslide( movemask & move_slide );
    self allowlean( 0 );
    self energy_setmax( 0, maxenergy );
    self energy_setenergy( 0, maxenergy );
    self energy_setrestorerate( 0, restorerate );
    self energy_setresttimems( 0, resttime );
    self energy_setmax( 1, 50 );
    self energy_setenergy( 1, 50 );
    self energy_setrestorerate( 1, 10 );
    self energy_setresttimems( 1, game_utility_mp::isanymlgmatch() ? 2500 : 0 );
    
    if ( isdefined( funcapply ) )
    {
        self [[ funcapply ]]();
    }
}

// Namespace class
// Params 2
// Checksum 0xf0c63dbe, Offset: 0xedc7
// Size: 0x7c
function function_788f97dda6180b0a( weapon, chroma )
{
    if ( !isdefined( weapon ) || isnullweapon( weapon ) || !isdefined( chroma ) )
    {
        return;
    }
    
    if ( isxhashasset( chroma ) )
    {
        weapon withchroma( chroma );
        return;
    }
    
    if ( isstring( chroma ) && chroma != "none" )
    {
        weapon withchroma( chroma );
        return;
    }
    
    if ( isnumber( chroma ) && chroma != 0 )
    {
        weapon withchroma( chroma );
    }
}

// Namespace class
// Params 2
// Checksum 0xf7b81864, Offset: 0xee4b
// Size: 0x38
function function_15dd83b5623487c2( weapon, serialvalue )
{
    if ( !isdefined( weapon ) || isnullweapon( weapon ) || !isdefined( serialvalue ) )
    {
        return weapon;
    }
    
    return weapon function_887ab70184ca7b6e( serialvalue );
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xcff88730, Offset: 0xee8c
// Size: 0x7f
function private throttle_loadout_updateclassfinalweapons( callindex )
{
    shouldthrottle = istrue( level.gamemodebundle.var_791b2589fc8196d8 );
    
    /#
        shouldthrottle |= getdvarint( @"hash_4db78bd54824bf44", 0 );
    #/
    
    if ( !shouldthrottle )
    {
        return;
    }
    
    if ( getdvarint( @"hash_5f08c9c6fe264553", 0 ) > 0 )
    {
        return;
    }
    
    if ( playerlogic::function_b81aa08420416b47() )
    {
        if ( callindex == 1 )
        {
            playerlogic::function_17bffb98a94b1e2b();
        }
        
        return;
    }
    
    script::waittillslowprocessallowed( 1 );
}

// Namespace class
// Params 3, eflags: 0x4
// Checksum 0x70155eb7, Offset: 0xef13
// Size: 0x26b
function private function_d6a06bf022cc9c90( weaponroot, attachments, reticle )
{
    if ( !( isdefined( reticle ) && isdefined( weaponroot ) ) || weaponroot == "none" )
    {
        return reticle;
    }
    
    if ( isstring( reticle ) && reticle == "none" || isnumber( reticle ) && reticle == 0 )
    {
        return reticle;
    }
    
    weaponassetname = weapon::weaponassetnamemap( weaponroot );
    scopeattachment = undefined;
    
    foreach ( attachment in attachments )
    {
        if ( !isstring( attachment ) || attachment == "" || attachment == "none" )
        {
            continue;
        }
        
        if ( getattachmentslot( weaponassetname, attachment ) == "scope" )
        {
            scopeattachment = attachment;
            break;
        }
    }
    
    if ( !isdefined( scopeattachment ) )
    {
        foreach ( attachment in getweapondefaultattachments( weaponassetname ) )
        {
            if ( getattachmentslot( weaponassetname, attachment ) == "scope" )
            {
                scopeattachment = attachment;
                break;
            }
        }
    }
    
    if ( isdefined( scopeattachment ) )
    {
        attachmentdata = function_333a08591af6b59( weaponassetname, scopeattachment );
        
        if ( !isdefined( attachmentdata ) )
        {
            println( "<dev string:x3f2>" + reticle + "<dev string:x433>" + weaponassetname + "<dev string:x441>" + scopeattachment + "<dev string:x45e>" );
            return "none";
        }
        
        reticlecategory = getscriptbundlefieldvalue( attachmentdata, #"reticlecategory" );
        
        if ( !isdefined( reticlecategory ) )
        {
            println( "<dev string:x3f2>" + reticle + "<dev string:x433>" + weaponassetname + "<dev string:x441>" + scopeattachment + "<dev string:x477>" );
            return "none";
        }
    }
    else
    {
        println( "<dev string:x3f2>" + reticle + "<dev string:x433>" + weaponassetname + "<dev string:x490>" );
        return "none";
    }
    
    return reticle;
}

// Namespace class
// Params 3
// Checksum 0xfc488b62, Offset: 0xf187
// Size: 0x428
function loadout_updateclassfinalweapons( struct, iscustom, allowthrottle = 0 )
{
    if ( allowthrottle )
    {
        throttle_loadout_updateclassfinalweapons( 1 );
    }
    
    struct.loadoutprimaryreticle = function_d6a06bf022cc9c90( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimaryreticle );
    
    if ( !isdefined( struct.loadoutprimaryobject ) )
    {
        struct.loadoutprimaryobject = weapon::buildweapon( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue( struct.loadouthasnvg ), struct.var_57a15af46a205668, iscustom, struct.var_277379f78fc833f4 );
    }
    
    function_788f97dda6180b0a( struct.loadoutprimaryobject, struct.var_69ae546f481034e2 );
    struct.loadoutprimaryobject = function_15dd83b5623487c2( struct.loadoutprimaryobject, struct.var_bf06b7def8985709 );
    struct.loadoutprimaryfullname = getcompleteweaponname( struct.loadoutprimaryobject );
    
    if ( allowthrottle )
    {
        throttle_loadout_updateclassfinalweapons( 2 );
    }
    
    struct.loadoutsecondaryreticle = function_d6a06bf022cc9c90( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondaryreticle );
    
    if ( !isdefined( struct.loadoutsecondaryobject ) )
    {
        struct.loadoutsecondaryobject = weapon::buildweapon( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue( struct.loadouthasnvg ), struct.var_f2b8977772330320, iscustom, struct.var_b93fbd33bb0d0a2c );
    }
    
    function_788f97dda6180b0a( struct.loadoutsecondaryobject, struct.var_2bab3f4f3d38584a );
    struct.loadoutsecondaryobject = function_15dd83b5623487c2( struct.loadoutsecondaryobject, struct.var_8d1ed34c7709f241 );
    struct.loadoutsecondaryfullname = getcompleteweaponname( struct.loadoutsecondaryobject );
    
    if ( allowthrottle )
    {
        throttle_loadout_updateclassfinalweapons( 3 );
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        struct.loadouttertiaryreticle = function_d6a06bf022cc9c90( struct.loadouttertiary, struct.var_c6ea1bb7cfd9e16e, struct.loadouttertiaryreticle );
        
        if ( !isdefined( struct.var_9dcef9a8722c3abb ) )
        {
            struct.var_9dcef9a8722c3abb = weapon::buildweapon( struct.loadouttertiary, struct.var_c6ea1bb7cfd9e16e, struct.loadouttertiarycamo, struct.loadouttertiaryreticle, struct.loadouttertiaryvariantid, struct.var_d957b896dcfa75ed, struct.var_c3c185cb12ccad46, struct.var_6f4ac9993a146618, istrue( struct.loadouthasnvg ), struct.var_d3a06e057eb576c0, iscustom, struct.var_50da18834547334c );
        }
        
        function_788f97dda6180b0a( struct.var_9dcef9a8722c3abb, struct.var_de6bc6d1e7c111ea );
        struct.var_9dcef9a8722c3abb = function_15dd83b5623487c2( struct.var_9dcef9a8722c3abb, struct.var_ea6fecf8edebaf61 );
        struct.var_441e64c50e9d846a = getcompleteweaponname( struct.var_9dcef9a8722c3abb );
    }
    
    if ( function_d31c1081fbeb777b() )
    {
        struct.var_183fb1979f9b8498 = weapon::buildweapon( level.var_a912a3e22d337a23, level.var_2b140b6eecabbe7, level.var_b36ec6e82a2a804f, level.var_d8579ef527127221 );
    }
}

// Namespace class
// Params 6
// Checksum 0x54bd49f0, Offset: 0xf5b7
// Size: 0x4cb
function loadout_updateplayerweapons( struct, class, setspawnweap = 1, skipfirstraise, var_468cbb735a52e11b, options )
{
    respawnitems = self.respawnitems;
    usingrespawnitems = respawnitems_hasweapondata( respawnitems );
    var_f00d4da234cdf6e7 = level.magcount;
    primarygiveweaponobj = loadout_giveprimaryweapon( struct, respawnitems, usingrespawnitems );
    
    if ( options.throttle )
    {
        waitframe();
    }
    
    secondarygiveweaponobj = undefined;
    var_325dfdba6032fa0 = !isdefined( respawnitems ) || isdefined( respawnitems.weapons[ "secondary" ] );
    
    if ( var_325dfdba6032fa0 )
    {
        secondarygiveweaponobj = loadout_givesecondaryweapon( struct, respawnitems, usingrespawnitems );
        
        if ( options.throttle )
        {
            waitframe();
        }
    }
    
    tertiarygiveweaponobj = undefined;
    
    if ( level.tertiaryweaponslotenabled )
    {
        if ( options.droptertiary )
        {
            loadout_droptertiary( struct );
        }
        else
        {
            var_fc212808696e6e0 = !isdefined( respawnitems ) || isdefined( respawnitems.weapons[ "tertiary" ] );
            
            if ( var_fc212808696e6e0 )
            {
                tertiarygiveweaponobj = function_d89bbcdf1e49045c( struct, respawnitems, usingrespawnitems );
            }
        }
        
        if ( options.throttle )
        {
            waitframe();
        }
    }
    
    self.var_c99cd485dda40b28 = 0;
    gameplay_telemetry_utils::function_7e116413984d3a47( primarygiveweaponobj, secondarygiveweaponobj, tertiarygiveweaponobj );
    
    if ( function_d31c1081fbeb777b() )
    {
        function_9e101b7b7b333117( struct );
    }
    
    function_aadb8084fdd4747a( struct );
    function_f7671a4963dfdfaf( struct );
    
    if ( !options.droptertiary )
    {
        function_d85292b9940d9b4e( struct );
    }
    
    loadout_updateammo( struct, primarygiveweaponobj, secondarygiveweaponobj, tertiarygiveweaponobj, respawnitems, usingrespawnitems, var_f00d4da234cdf6e7, var_468cbb735a52e11b );
    self.loadoutmeleeslot = struct.loadoutmeleeslot;
    
    if ( !isdefined( primarygiveweaponobj ) )
    {
        if ( isdefined( struct.loadoutprimary ) )
        {
            logstring( "IW9-688909: primaryGiveWeaponObj is undefined, weapon name is " + struct.loadoutprimary );
        }
        else
        {
            logstring( "IW9-688909: primaryGiveWeaponObj is undefined, weapon name is also undefined" );
        }
    }
    
    var_41d13e18c1ef3371 = function_f7f9eef02d1e3c60( respawnitems );
    var_b9770ab87618980e = isdefined( var_41d13e18c1ef3371 ) && var_41d13e18c1ef3371.basename != "none" && self hasweapon( var_41d13e18c1ef3371 );
    var_77b5ebbb8f25e62e = isdefined( primarygiveweaponobj ) && primarygiveweaponobj.basename != "none" && self hasweapon( primarygiveweaponobj );
    var_13a07ae6f45d85f2 = isdefined( secondarygiveweaponobj ) && secondarygiveweaponobj.basename != "none" && self hasweapon( secondarygiveweaponobj );
    var_7be1e853818582c2 = isdefined( tertiarygiveweaponobj ) && tertiarygiveweaponobj.basename != "none" && self hasweapon( tertiarygiveweaponobj );
    var_5f1594deaecdd1fa = var_13a07ae6f45d85f2 && ( !var_77b5ebbb8f25e62e || weapon::isfistweapon( primarygiveweaponobj ) && !weapon::isfistweapon( secondarygiveweaponobj ) );
    var_ab2faffb22c2de0a = var_7be1e853818582c2 && ( !var_77b5ebbb8f25e62e || weapon::isfistweapon( primarygiveweaponobj ) && !weapon::isfistweapon( secondarygiveweaponobj ) ) && ( !var_13a07ae6f45d85f2 || weapon::isfistweapon( var_13a07ae6f45d85f2 ) && !weapon::isfistweapon( tertiarygiveweaponobj ) );
    
    if ( var_b9770ab87618980e )
    {
        spawnweaponobj = var_41d13e18c1ef3371;
    }
    else if ( var_5f1594deaecdd1fa )
    {
        spawnweaponobj = secondarygiveweaponobj;
    }
    else if ( var_ab2faffb22c2de0a )
    {
        spawnweaponobj = tertiarygiveweaponobj;
    }
    else if ( var_77b5ebbb8f25e62e )
    {
        spawnweaponobj = primarygiveweaponobj;
    }
    
    if ( !isai( self ) && isweapon( spawnweaponobj ) )
    {
        inventory_utility::_switchtoweapon( spawnweaponobj );
    }
    
    if ( !isdefined( spawnweaponobj ) )
    {
        loadoutprimary = struct.loadoutprimary ?? "";
        var_940a0c5378f2a86e = primarygiveweaponobj.basename ?? "";
        var_8d4d96d1f26d607e = secondarygiveweaponobj.basename ?? "";
        logstring( "[SRE] spawnWeaponObj is undefined! struct.loadoutPrimary : " + loadoutprimary + ", primaryGiveWeaponObj : " + var_940a0c5378f2a86e + " secondaryGiveWeaponObj : " + var_8d4d96d1f26d607e );
    }
    
    if ( isdefined( spawnweaponobj ) && setspawnweap )
    {
        skipfirstraise = function_28db18ee2fa5c094( spawnweaponobj, skipfirstraise );
        
        if ( !isagent( self ) && isweapon( spawnweaponobj ) )
        {
            self setspawnweapon( spawnweaponobj, !skipfirstraise );
        }
    }
    
    var_db7da140a9d7f20a = isdefined( self.spawnweaponobj ) && isdefined( spawnweaponobj ) && issameweapon( spawnweaponobj, self.spawnweaponobj, 1 );
    self.spawnweaponobj = spawnweaponobj;
    
    if ( isdefined( skipfirstraise ) && !skipfirstraise && var_db7da140a9d7f20a && self.hasspawned )
    {
        self function_9b4d59c6a67288f3( self.spawnweaponobj );
    }
    
    loadout_updateweapondependentsettings();
    gameplay_telemetry::function_3e91d2222fa2419f();
}

// Namespace class
// Params 0
// Checksum 0xcf34b0ad, Offset: 0xfa8a
// Size: 0xc3
function loadout_finalizeweapons()
{
    self notify( #"loadout_weapon_finalize" );
    var_d2bbd1d7a3e0fc78 = 0;
    
    if ( isdefined( self.primaryweaponobj ) && !self hasweapon( self.primaryweaponobj ) )
    {
        loadout_giveprimaryweapon( self.classstruct );
        var_d2bbd1d7a3e0fc78 = 1;
    }
    
    if ( isdefined( self.secondaryweaponobj ) && !self hasweapon( self.secondaryweaponobj ) )
    {
        loadout_givesecondaryweapon( self.classstruct );
        var_d2bbd1d7a3e0fc78 = 1;
    }
    
    if ( isdefined( self.var_cc1262e66dbb1c79 ) && !self hasweapon( self.var_cc1262e66dbb1c79 ) )
    {
        function_d89bbcdf1e49045c( self.classstruct );
        var_d2bbd1d7a3e0fc78 = 1;
    }
    
    if ( var_d2bbd1d7a3e0fc78 )
    {
        thread trackriotshield_monitorshieldattach();
    }
}

// Namespace class
// Params 3
// Checksum 0xebf650e6, Offset: 0xfb55
// Size: 0x13c
function loadout_giveprimaryweapon( struct, respawnitems, usingrespawnitems )
{
    self.loadoutprimary = struct.loadoutprimary;
    self.loadoutprimarycamo = struct.loadoutprimarycamo;
    self.var_69ae546f481034e2 = struct.var_69ae546f481034e2;
    self.loadoutprimaryattachments = struct.loadoutprimaryattachments;
    self.loadoutprimaryattachmentids = struct.loadoutprimaryattachmentids;
    self.var_277379f78fc833f4 = struct.var_277379f78fc833f4;
    self.loadoutprimaryreticle = struct.loadoutprimaryreticle;
    self.loadoutprimarylootitemid = struct.loadoutprimarylootitemid;
    self.loadoutprimaryvariantid = struct.loadoutprimaryvariantid;
    primarygiveweaponobj = loadout_giveweaponobj( "primary", struct.loadoutprimaryobject, respawnitems, usingrespawnitems );
    self.primaryweapon = struct.loadoutprimaryfullname;
    self.primaryweaponobj = struct.loadoutprimaryobject;
    self.pers[ "primaryWeapon" ] = struct.loadoutprimaryfullname;
    return primarygiveweaponobj;
}

// Namespace class
// Params 3
// Checksum 0x9ab4ff94, Offset: 0xfc9a
// Size: 0x13c
function loadout_givesecondaryweapon( struct, respawnitems, usingrespawnitems )
{
    self.loadoutsecondary = struct.loadoutsecondary;
    self.loadoutsecondarycamo = struct.loadoutsecondarycamo;
    self.var_2bab3f4f3d38584a = struct.var_2bab3f4f3d38584a;
    self.loadoutsecondaryattachments = struct.loadoutsecondaryattachments;
    self.loadoutsecondaryattachmentids = struct.loadoutsecondaryattachmentids;
    self.var_b93fbd33bb0d0a2c = struct.var_b93fbd33bb0d0a2c;
    self.loadoutsecondaryreticle = struct.loadoutsecondaryreticle;
    self.loadoutsecondarylootitemid = struct.loadoutsecondarylootitemid;
    self.loadoutsecondaryvariantid = struct.loadoutsecondaryvariantid;
    secondarygiveweaponobj = loadout_giveweaponobj( "secondary", struct.loadoutsecondaryobject, respawnitems, usingrespawnitems );
    self.secondaryweapon = struct.loadoutsecondaryfullname;
    self.secondaryweaponobj = struct.loadoutsecondaryobject;
    self.pers[ "secondaryWeapon" ] = struct.loadoutsecondaryfullname;
    return secondarygiveweaponobj;
}

// Namespace class
// Params 2
// Checksum 0xc09e06ce, Offset: 0xfddf
// Size: 0xb1
function function_c75ae4ad670c642c( tertiarygiveweaponobj, var_586a4c78bb8a3fe7 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"giveloadout_start" );
    self endon( #"hash_418b511a577dd571" );
    var_a3ef19fae03f7e13 = var_586a4c78bb8a3fe7;
    waitframe();
    
    while ( true )
    {
        if ( var_a3ef19fae03f7e13 != self function_2792dece9bf7d433() )
        {
            var_a3ef19fae03f7e13 = !var_a3ef19fae03f7e13;
            
            if ( var_a3ef19fae03f7e13 )
            {
                weaponobj = self getweaponmeleeslot();
                
                if ( !isnullweapon( weaponobj ) )
                {
                    self assignweaponprimaryslot( weaponobj );
                }
            }
            else
            {
                weaponobj = self function_a4f068798d87b7ea( 2 );
                
                if ( !isnullweapon( weaponobj ) )
                {
                    self assignweaponmeleeslot( weaponobj );
                }
            }
        }
        
        self waittill( #"hash_a40628a5e05f1aa" );
    }
}

// Namespace class
// Params 3
// Checksum 0xc171c080, Offset: 0xfe98
// Size: 0xee
function function_d89bbcdf1e49045c( struct, respawnitems, usingrespawnitems )
{
    self.loadouttertiary = struct.loadouttertiary;
    self.loadouttertiarycamo = struct.loadouttertiarycamo;
    self.var_c6ea1bb7cfd9e16e = struct.var_c6ea1bb7cfd9e16e;
    self.var_d957b896dcfa75ed = struct.var_d957b896dcfa75ed;
    self.var_50da18834547334c = struct.var_50da18834547334c;
    self.loadouttertiaryreticle = struct.loadouttertiaryreticle;
    self.var_ed9b3d4420e4e620 = struct.var_ed9b3d4420e4e620;
    self.loadouttertiaryvariantid = struct.loadouttertiaryvariantid;
    tertiarygiveweaponobj = loadout_giveweaponobj( "tertiary", struct.var_9dcef9a8722c3abb, respawnitems, usingrespawnitems );
    weapon::function_b4c9549dee5d0fc5( tertiarygiveweaponobj );
    return tertiarygiveweaponobj;
}

// Namespace class
// Params 1
// Checksum 0x4b7d637d, Offset: 0xff8f
// Size: 0x69
function function_9e101b7b7b333117( struct )
{
    if ( struct.disablebackuppistol )
    {
        return;
    }
    
    self giveweapon( struct.var_183fb1979f9b8498, 0, 0, 0, 1, 1 );
    thread function_2ab4e0aab98f0f4c( struct.var_183fb1979f9b8498 );
    thread function_26ac6085a9989d97( struct.var_183fb1979f9b8498 );
    thread function_36697132ee943eed( struct.var_183fb1979f9b8498 );
}

// Namespace class
// Params 4
// Checksum 0xc3a8b175, Offset: 0x10000
// Size: 0x135
function loadout_giveweaponobj( weaponslot, weaponobj, respawnitems, usingrespawnitems )
{
    giveweaponobj = usingrespawnitems ? respawnitems_getweaponobj( respawnitems, weaponslot ) : weaponobj;
    
    if ( !isundefinedweapon( giveweaponobj ) )
    {
        if ( weapon_utility::function_1bf655fc8f1fda2d( giveweaponobj ) && !flags::gameflag( "prematch_done" ) && flags::gameflag( "infil_will_run" ) )
        {
            thread function_1e5f41cc244447ad( weaponslot, weaponobj, respawnitems, usingrespawnitems );
        }
        else
        {
            giveweaponobj = weapons::updatesavedaltstate( giveweaponobj );
            
            if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) && level.gametypebundle.var_75cfa2fc20e8a335 )
            {
                var_3df5b0fceaf91931 = !self.classstruct.var_74bf72275e8840fc;
                item_weapon::function_96add18b226ff731( giveweaponobj, var_3df5b0fceaf91931, undefined );
            }
            else
            {
                inventory_utility::_giveweapon( giveweaponobj, undefined, undefined, 1 );
            }
            
            weapons::updatetogglescopestate( giveweaponobj );
            weapons::function_bc0af64402b25353( giveweaponobj );
        }
    }
    
    if ( usingrespawnitems )
    {
        rarity = function_683e659a77d1a2d6( respawnitems, weaponslot );
        item_weapon::function_40e1cbd0e1f47d1a( giveweaponobj, rarity );
    }
    
    return giveweaponobj;
}

// Namespace class
// Params 4
// Checksum 0x9c23e4f, Offset: 0x1013e
// Size: 0xc4
function function_1e5f41cc244447ad( weaponslot, weaponobj, respawnitems, usingrespawnitems )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9e1c21c199e3d5f2" );
    self endon( #"giveloadout_start" );
    level waittill( #"prematch_over" );
    giveweaponobj = undefined;
    
    if ( !usingrespawnitems )
    {
        giveweaponobj = weaponobj;
    }
    else
    {
        giveweaponobj = respawnitems_getweaponobj( respawnitems, weaponslot );
    }
    
    if ( !isundefinedweapon( giveweaponobj ) )
    {
        giveweaponobj = weapons::updatesavedaltstate( giveweaponobj );
        inventory_utility::_giveweapon( giveweaponobj, undefined, undefined, 1 );
        weapons::updatetogglescopestate( giveweaponobj );
        weapons::function_bc0af64402b25353( giveweaponobj );
    }
    
    if ( weaponslot == "primary" )
    {
        inventory_utility::_switchtoweapon( giveweaponobj );
    }
}

// Namespace class
// Params 4
// Checksum 0x7ff7268b, Offset: 0x1020a
// Size: 0x60
function function_e79fc12390ff1916( primaryweaponobj, secondaryweaponobj, respawnitems, usingrespawnitems )
{
    self endon( #"death_or_disconnect" );
    level waittill( #"prematch_over" );
    loadout_updateammo( self.classstruct, primaryweaponobj, secondaryweaponobj, undefined, respawnitems, usingrespawnitems, level.magcount );
}

// Namespace class
// Params 1
// Checksum 0x31a1a9f6, Offset: 0x10272
// Size: 0x48
function function_aadb8084fdd4747a( struct )
{
    if ( struct.loadoutswimweapon != "none" )
    {
        giveweaponobj = level.defaultswimweapon;
        self giveweapon( giveweaponobj );
    }
    
    self.swimweapon = giveweaponobj;
}

// Namespace class
// Params 1
// Checksum 0x1def81b6, Offset: 0x102c2
// Size: 0x48
function function_f7671a4963dfdfaf( struct )
{
    if ( struct.loadoutclimbweapon != "none" )
    {
        giveweaponobj = level.var_f8ac15ada97a702a;
        self giveweapon( giveweaponobj );
    }
    
    self.climbweapon = giveweaponobj;
}

// Namespace class
// Params 1
// Checksum 0x9a5afa8f, Offset: 0x10312
// Size: 0x4d
function function_d85292b9940d9b4e( struct )
{
    if ( struct.loadoutmeleeslot != "none" )
    {
        giveweaponobj = weapon::buildweapon( struct.loadoutmeleeslot );
        self giveweapon( giveweaponobj );
        self assignweaponmeleeslot( giveweaponobj );
    }
}

// Namespace class
// Params 1
// Checksum 0xefd512a5, Offset: 0x10367
// Size: 0x70
function loadout_droptertiary( struct )
{
    if ( struct.loadouttertiary != "none" )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        itembundle = common_item::function_cf68ad18114498b2( struct.loadouttertiary );
        item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
    }
}

// Namespace class
// Params 8
// Checksum 0x92bae070, Offset: 0x103df
// Size: 0x344
function loadout_updateammo( struct, primarygiveweaponobj, secondarygiveweaponobj, tertiarygiveweaponobj, respawnitems, usingrespawnitems, var_f00d4da234cdf6e7, var_468cbb735a52e11b )
{
    loadoutweapons = [];
    
    if ( isdefined( struct.loadoutprimaryobject ) && struct.loadoutprimaryobject.basename != "none" )
    {
        loadoutweapons[ loadoutweapons.size ] = struct.loadoutprimaryobject;
    }
    
    if ( isdefined( struct.loadoutsecondaryobject ) && struct.loadoutsecondaryobject.basename != "none" )
    {
        loadoutweapons[ loadoutweapons.size ] = struct.loadoutsecondaryobject;
    }
    
    if ( isdefined( struct.var_9dcef9a8722c3abb ) && struct.var_9dcef9a8722c3abb.basename != "none" )
    {
        loadoutweapons[ loadoutweapons.size ] = struct.var_9dcef9a8722c3abb;
    }
    
    if ( function_d31c1081fbeb777b() && isdefined( struct.var_183fb1979f9b8498 ) && struct.var_183fb1979f9b8498.basename != "none" )
    {
        loadoutweapons[ loadoutweapons.size ] = struct.var_183fb1979f9b8498;
    }
    
    if ( isdefined( level.modeloadoutupdateammo ) && !var_468cbb735a52e11b )
    {
        self [[ level.modeloadoutupdateammo ]]( loadoutweapons );
    }
    else if ( usingrespawnitems )
    {
        respawnitems_giveweaponammo( respawnitems, "primary" );
        respawnitems_giveweaponammo( respawnitems, "secondary" );
        respawnitems_giveweaponammo( respawnitems, "tertiary" );
    }
    else if ( var_f00d4da234cdf6e7 != 3 )
    {
        if ( isdefined( primarygiveweaponobj ) )
        {
            spawnammocountoverride_giveweaponammo( primarygiveweaponobj, "primary", var_f00d4da234cdf6e7 );
        }
        
        if ( isdefined( secondarygiveweaponobj ) )
        {
            spawnammocountoverride_giveweaponammo( secondarygiveweaponobj, "secondary", var_f00d4da234cdf6e7 );
        }
        
        if ( isdefined( tertiarygiveweaponobj ) )
        {
            spawnammocountoverride_giveweaponammo( tertiarygiveweaponobj, "tertiary", var_f00d4da234cdf6e7 );
        }
    }
    else
    {
        foreach ( weapon in loadoutweapons )
        {
            if ( getweaponhasperk( weapon, "specialty_extraclip" ) )
            {
                addstock = self getweaponammoclip( weapon );
                
                if ( addstock < 6 )
                {
                    addstock = 6;
                }
                
                currentstock = self getweaponammostock( weapon );
                self setweaponammostock( weapon, currentstock + addstock );
            }
        }
    }
    
    if ( !usingrespawnitems && var_f00d4da234cdf6e7 == 3 )
    {
        foreach ( weapon in loadoutweapons )
        {
            if ( weapon::isakimbo( weapon ) )
            {
                self setweaponammostock( weapon, self getweaponammostock( weapon ) + weaponclipsize( weapon ) * 3 );
            }
        }
    }
}

// Namespace class
// Params 0
// Checksum 0xdd72f6b8, Offset: 0x1072b
// Size: 0x9
function loadout_updateweapondependentsettings()
{
    weapons::updatemovespeedscale();
}

// Namespace class
// Params 2
// Checksum 0xc011d536, Offset: 0x1073c
// Size: 0x1ba
function function_fd9078bc5ebdea3e( classindex, isprimary )
{
    class = menus::getclasschoice( classindex );
    struct = loadout_getclassstruct();
    var_4d5575c6f9ec8a5b = function_ad7e91d3dac61546();
    loadout_updateclasscustom( struct, class, var_4d5575c6f9ec8a5b );
    struct = loadout_validateclass( struct, class );
    
    if ( isprimary )
    {
        struct.loadoutprimaryobject = weapon::buildweapon( struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue( struct.loadouthasnvg ), struct.var_57a15af46a205668, 1, struct.var_277379f78fc833f4, struct.var_bf06b7def8985709 );
        return struct.loadoutprimaryobject;
    }
    else
    {
        struct.loadoutsecondaryobject = weapon::buildweapon( struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue( struct.loadouthasnvg ), struct.var_f2b8977772330320, 1, struct.var_b93fbd33bb0d0a2c, struct.var_8d1ed34c7709f241 );
        return struct.loadoutsecondaryobject;
    }
    
    return level.var_6417f60a871eaa35;
}

// Namespace class
// Params 1
// Checksum 0x1274f399, Offset: 0x108ff
// Size: 0x135
function function_c8d9816a5c9f1f97( player )
{
    if ( level.gamemodebundle.var_a0b0a8d8b395697e )
    {
        perks = level.var_6417f60a871eaa35 ?? function_96674d4f4b799db1();
        perks = arraycopy( perks );
    }
    else
    {
        perks = [ "specialty_pistoldraw" ];
    }
    
    if ( isdvardefined( @"scr_test_suit" ) && getdvar( @"scr_test_suit" ) != "" )
    {
        perks[ perks.size ] = "specialty_weight_encumbered";
    }
    
    if ( game_utility_mp::islaststandenabled() )
    {
        perks[ perks.size ] = "specialty_pistoldeath";
    }
    
    if ( utility::isnightmap() && utility::function_2a082dafe6f4bd5b() )
    {
        if ( getdvarint( @"hash_58735393383459d4", 1 ) == 1 )
        {
            perks[ perks.size ] = "specialty_spygame";
        }
    }
    
    if ( player.scorestreaktype )
    {
        perks[ perks.size ] = "specialty_strategist";
    }
    
    if ( level.var_5c7269a460306111 && isdefined( player.platecarriertype ) )
    {
        perks[ perks.size ] = perkfunctions::function_bc67eadf98fb969a( player.platecarriertype );
    }
    
    if ( level.var_10cdddd9174f6d1c )
    {
        perks[ perks.size ] = "specialty_br_movement_mod";
    }
    
    return perks;
}

// Namespace class
// Params 3
// Checksum 0x5bac83b8, Offset: 0x10a3d
// Size: 0x78f
function loadout_updateplayerperks( struct, class, options )
{
    respawnitems = self.respawnitems;
    hasperkdata = function_5cc13631b3b7a959( respawnitems );
    
    /#
        if ( level.projectbundle.var_6549de919aac5cec && !level.gamemodebundle.streaktypeenabled )
        {
            killstreaks::resetstreakpoints();
        }
    #/
    
    if ( !hasperkdata )
    {
        defaultperks = function_c8d9816a5c9f1f97( self );
        
        foreach ( perk in defaultperks )
        {
            loadout_giveperk( perk );
        }
    }
    
    var_b4c3418bc2c05576 = level.gamemodebundle.noloadoutperks && !getdvarint( @"hash_3802b0d284c7f2dd", 0 );
    
    if ( !var_b4c3418bc2c05576 )
    {
        if ( options.var_ef2b67ac76d8f44a )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            spawnoptions.var_dff7232dcf40509e = struct.loadoutperks;
            utility::callsharedfunc( #"perk", #"dropperks", spawnoptions );
        }
        else if ( class != "juggernaut" )
        {
            if ( hasperkdata )
            {
                loadoutperks = respawnitems_getloadoutperks( respawnitems );
                loadoutstandardperks = function_cd87144240a5924f( respawnitems );
                loadoutextraperks = function_121fb7f84c56afc( respawnitems );
                loadoutrigtrait = function_b9fbba2ba3adc6a1( respawnitems );
                loadoutusingspecialist = function_1e64ef461f21688c( respawnitems );
            }
            else
            {
                loadoutperks = struct.loadoutperks;
                loadoutperkstreaks = struct.loadoutperkstreaks;
                loadoutstandardperks = self.pers[ "loadoutStandardPerks" ];
                loadoutextraperks = self.pers[ "loadoutExtraPerks" ];
                loadoutrigtrait = self.pers[ "loadoutRigTrait" ];
                loadoutusingspecialist = self.pers[ "loadoutUsingSpecialist" ];
            }
            
            if ( isdefined( loadoutperks ) && loadoutperks.size > 0 )
            {
                dupeupdated = function_2c739fffd9cf4748( struct );
                
                if ( dupeupdated )
                {
                    perks::giveperks( struct.loadoutperks );
                }
                else
                {
                    perks::giveperks( loadoutperks );
                }
                
                if ( !level.useperkpackage && perk::function_2d1b2c825510b212() )
                {
                    perks::giveperks( loadoutextraperks );
                }
                
                if ( getdvarint( @"scr_test_loadouts", 0 ) )
                {
                    if ( !level.useperkpackage && perk::function_2d1b2c825510b212() )
                    {
                        perks::giveperks( struct.loadoutextraperks );
                    }
                    
                    self.shooting_mode = "1st";
                    
                    foreach ( perk in loadoutperks )
                    {
                        if ( perk == "specialty_third_person" )
                        {
                            self.shooting_mode = "3rd";
                        }
                    }
                    
                    self.pers[ "shootingMode" ] = self.shooting_mode;
                }
            }
            
            self.pers[ "loadoutPerks" ] = loadoutperks;
            self.pers[ "loadoutPerkStreaks" ] = loadoutperkstreaks;
            self.pers[ "loadoutStandardPerks" ] = loadoutstandardperks;
            self.pers[ "loadoutExtraPerks" ] = loadoutextraperks;
            self.pers[ "loadoutRigTrait" ] = loadoutrigtrait;
            self.pers[ "loadoutUsingSpecialist" ] = loadoutusingspecialist;
            
            if ( self.avoidkillstreakonspawntimer > 0 )
            {
                thread perks::giveperksafterspawn();
            }
            
            if ( !isagent( self ) && dvars::getintproperty( @"scr_showperksonspawn", 1 ) == 1 && game[ "state" ] != "postgame" )
            {
                perksarray = loadoutperks ?? [];
                extraperksarray = loadoutextraperks ?? [];
                perks::function_8165040202c6ebe5( perksarray );
                perks::setomnvarsforperklist( "ui_spawn_perk_", perksarray, extraperksarray );
            }
        }
        
        if ( getdvarint( @"hash_6a4d5cd30c97a609", 0 ) )
        {
            logstring( "\n PERKS BUG LOGGING - After update, player has " + self.perks.size + " perks." );
            
            foreach ( idx, perk in self.perks )
            {
                logstring( "\n" + idx );
            }
        }
        
        function_fcd287e3e2445b46( perksarray );
        
        if ( perk::function_2461b046fc74d8de() )
        {
            hud_message::showsplash( "equipped_perks_mp" );
        }
        
        if ( getdvarint( @"boba_mode", 0 ) )
        {
            perk::giveperk( "wildcard_high_roller" );
        }
        
        if ( isdefined( struct.loadoutwildcard ) && struct.loadoutwildcard != "wildcard_none" && isdefined( level.wildcardbundles[ struct.loadoutwildcard ] ) )
        {
            loadout_giveperk( struct.loadoutwildcard );
        }
        
        if ( !isdefined( struct.loadoutwildcard ) )
        {
            struct.loadoutwildcard = "wildcard_none";
        }
        
        if ( level.gametypebundle.extrawildcard )
        {
            loadout_giveperk( level.gametypebundle.extrawildcard );
        }
        
        omnvarvalue = struct.loadoutwildcard;
        self setclientomnvar( "ui_spawn_wildcard", omnvarvalue );
    }
    
    self.var_32fd3b4f0d29af1f = undefined;
    
    if ( isdefined( self.perks[ "wildcard_perk_greed" ] ) && ( isdefined( self.perks[ "specialty_slayer" ] ) || isdefined( self.perks[ "specialty_operative" ] ) || isdefined( self.perks[ "specialty_tactician" ] ) ) )
    {
        var_fe166b3bdb609342 = [];
        
        foreach ( perk in self.loadoutperks )
        {
            if ( !level.perkbundles[ perk ].var_b8eda1a24efa0884 )
            {
                continue;
            }
            
            if ( !isdefined( var_fe166b3bdb609342[ level.perkbundles[ perk ].var_b8eda1a24efa0884 ] ) )
            {
                var_fe166b3bdb609342[ level.perkbundles[ perk ].var_b8eda1a24efa0884 ] = 0;
            }
            
            var_fe166b3bdb609342[ level.perkbundles[ perk ].var_b8eda1a24efa0884 ]++;
            
            if ( var_fe166b3bdb609342[ level.perkbundles[ perk ].var_b8eda1a24efa0884 ] == 4 )
            {
                self.var_32fd3b4f0d29af1f = 1;
            }
        }
    }
    
    level notify( #"hash_7dcad959a10ea3e5", self );
}

// Namespace class
// Params 1
// Checksum 0x54ae10fe, Offset: 0x111d4
// Size: 0x13f
function function_2c739fffd9cf4748( struct )
{
    vestperk = function_d485f9f983dd0157( struct );
    
    if ( isdefined( vestperk ) )
    {
        dupeperk = function_acf5edc7b83e8635( vestperk );
        
        if ( !isdefined( dupeperk ) )
        {
            return 0;
        }
        
        if ( !isarray( dupeperk ) )
        {
            dupeperk = [ dupeperk ];
        }
        
        foreach ( dupe in dupeperk )
        {
            foreach ( perk in struct.loadoutperks )
            {
                if ( perk == dupe )
                {
                    return function_b26026b36b7f1945( vestperk, dupe, struct );
                }
            }
        }
        
        return 0;
    }
}

// Namespace class
// Params 1
// Checksum 0x20322bc6, Offset: 0x1131b
// Size: 0x177
function function_d485f9f983dd0157( struct )
{
    vestarray = [ "specialty_infantry_vest", "specialty_grenadier_vest", "specialty_cct_vest", "specialty_overkill_vest", "specialty_tac_vest", "specialty_gunner_vest", "specialty_scout_vest", "specialty_marksman_vest", "specialty_ninja_vest", "specialty_compression_carrier_vest", "specialty_rhino_rig", "specialty_pistol_vest" ];
    
    foreach ( perk in struct.loadoutperks )
    {
        if ( arraycontains( vestarray, perk ) )
        {
            return perk;
        }
    }
    
    foreach ( perk in struct.loadoutextraperks )
    {
        if ( arraycontains( vestarray, perk ) )
        {
            return perk;
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xd7213668, Offset: 0x1149b
// Size: 0x113
function function_acf5edc7b83e8635( vestperk )
{
    switch ( vestperk )
    {
        case #"hash_568523fdd9886154":
            return "specialty_running_sneakers";
        case #"hash_2fbe6bc056549a68":
            return;
        case #"hash_c1dfdb4041d59e89":
            return "specialty_intel_jacker";
        case #"hash_522bef19e9286b39":
            return [ "specialty_custom_gloves", "specialty_silicon_gloves" ];
        case #"hash_82a9f5a3ce609b36":
            return "specialty_fast_reload";
        case #"hash_39fbb731f952e175":
            return "specialty_ghost_camo";
        case #"hash_24af5eb2e03b90bd":
            return "specialty_marksman_gloves";
        case #"hash_ceead0eadcdc2887":
            return [ "specialty_canvas_sneakers", "specialty_dauntless_boots" ];
        case #"hash_c474ef13b42188e8":
            return [ "specialty_compression_plate", "specialty_tac_mask" ];
        case #"hash_f0ce2815ea1b92db":
            return;
        case #"hash_6bbf74cf8705b69a":
            return [ "specialty_custom_gloves", "specialty_silicon_gloves", "specialty_fast_reload" ];
    }
}

// Namespace class
// Params 3
// Checksum 0x3a7b0621, Offset: 0x115b7
// Size: 0x1c9, Type: bool
function function_b26026b36b7f1945( vestperk, dupeperk, struct )
{
    newperk = undefined;
    
    switch ( vestperk )
    {
        case #"hash_568523fdd9886154":
            newperk = "specialty_ultra_light_boots";
            break;
        case #"hash_c1dfdb4041d59e89":
            newperk = "specialty_hardline";
            break;
        case #"hash_522bef19e9286b39":
            newperk = "specialty_marksman_gloves";
            break;
        case #"hash_82a9f5a3ce609b36":
            newperk = "specialty_hardline";
            break;
        case #"hash_39fbb731f952e175":
            newperk = "specialty_covert_ops";
            break;
        case #"hash_24af5eb2e03b90bd":
            newperk = "specialty_custom_gloves";
            break;
        case #"hash_ceead0eadcdc2887":
            newperk = "specialty_running_sneakers";
            break;
        case #"hash_c474ef13b42188e8":
            newperk = "specialty_eod_vest";
            break;
    }
    
    if ( vestperk == "specialty_tac_vest" && ( arraycontains( struct.loadoutperks, "specialty_hardline" ) || arraycontains( struct.loadoutextraperks, "specialty_hardline" ) ) )
    {
        newperk = "specialty_tac_mask";
    }
    
    if ( vestperk == "specialty_pistol_vest" )
    {
        if ( dupeperk == "specialty_custom_gloves" || dupeperk == "specialty_silicon_gloves" )
        {
            newperk = "specialty_marksman_gloves";
        }
        else if ( dupeperk == "specialty_fast_reload" )
        {
            newperk = "specialty_hardline";
        }
    }
    
    key = function_f02c63b99c9614c9( struct.loadoutperks, dupeperk );
    
    if ( isdefined( key ) )
    {
        struct.loadoutperks[ key ] = newperk;
        return true;
    }
    else
    {
        key = function_f02c63b99c9614c9( struct.loadoutextraperks, dupeperk );
        
        if ( isdefined( key ) )
        {
            struct.loadoutextraperks[ key ] = newperk;
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 1
// Checksum 0x1037ef78, Offset: 0x11789
// Size: 0x3d2
function function_fcd287e3e2445b46( loadoutperks )
{
    if ( !isdefined( level.var_6e428b8946955e28 ) )
    {
        return;
    }
    
    self.var_8ce8d93781ae0220 = undefined;
    self.var_c7f9996ef2343f2a = undefined;
    
    if ( level.disableBonusPerks )
    {
        return;
    }
    
    var_c9687d5205245eb0 = [];
    var_893bfa849fa487f9 = 0;
    
    foreach ( perk in loadoutperks )
    {
        var_893bfa849fa487f9++;
        
        if ( var_893bfa849fa487f9 > 3 )
        {
            break;
        }
        
        foreach ( var_c90e0f718f64b095 in level.var_6e428b8946955e28 )
        {
            bundle = level.perkbundles[ perk ];
            
            if ( !( isdefined( bundle ) && isdefined( bundle.var_b8eda1a24efa0884 ) ) )
            {
                continue;
            }
            
            if ( bundle.var_b8eda1a24efa0884 == var_c90e0f718f64b095.playstyle )
            {
                if ( !isdefined( var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ] ) )
                {
                    countdata = spawnstruct();
                    countdata.var_c90e0f718f64b095 = var_c90e0f718f64b095;
                    countdata.ctr = 1;
                    var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ] = countdata;
                    continue;
                }
                
                if ( !var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ].isgiven )
                {
                    var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ].ctr++;
                    
                    if ( var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ].ctr == var_c90e0f718f64b095.var_6784f188fa7a71ea )
                    {
                        bonusperk = level.var_5ca0738fa58d5896[ var_c90e0f718f64b095.bundle ];
                        assert( isdefined( bonusperk ) );
                        
                        if ( perkisrestricted( bonusperk ) )
                        {
                            continue;
                        }
                        
                        if ( isdefined( bonusperk ) )
                        {
                            loadout_giveperk( bonusperk );
                            self.var_8ce8d93781ae0220 = bonusperk;
                        }
                        
                        var_c9687d5205245eb0[ var_c90e0f718f64b095.playstyle ].isgiven = 1;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( self.var_8ce8d93781ae0220 ) )
    {
        foreach ( var_c90e0f718f64b095 in level.var_6e428b8946955e28 )
        {
            if ( !var_c90e0f718f64b095.var_5a62279e693d6b16 )
            {
                continue;
            }
            
            if ( !( isdefined( var_c9687d5205245eb0[ var_c90e0f718f64b095.var_d23e73dbacec6e3d ] ) && isdefined( var_c9687d5205245eb0[ var_c90e0f718f64b095.var_d23e70dbacec67a4 ] ) ) )
            {
                continue;
            }
            
            hybridcount = var_c9687d5205245eb0[ var_c90e0f718f64b095.var_d23e73dbacec6e3d ].ctr + var_c9687d5205245eb0[ var_c90e0f718f64b095.var_d23e70dbacec67a4 ].ctr;
            
            if ( hybridcount >= 3 )
            {
                bonusperk = level.var_5ca0738fa58d5896[ var_c90e0f718f64b095.bundle ];
                assert( isdefined( bonusperk ) );
                
                if ( perkisrestricted( bonusperk ) )
                {
                    continue;
                }
                
                if ( isdefined( bonusperk ) )
                {
                    loadout_giveperk( bonusperk );
                    self.var_8ce8d93781ae0220 = bonusperk;
                    self.var_c7f9996ef2343f2a = 1;
                }
            }
        }
    }
}

// Namespace class
// Params 4
// Checksum 0xd7165b4, Offset: 0x11b63
// Size: 0x67c
function loadout_updateplayerequipment( struct, class, var_9edcca6343f41f5b, options )
{
    respawnitems = self.respawnitems;
    usingrespawnitems = respawnitems_hasequipmentdata( respawnitems );
    self.loadoutequipmentprimary = struct.loadoutequipmentprimary;
    self.loadoutequipmentsecondary = struct.loadoutequipmentsecondary;
    self.var_cedaf611f3c02546 = struct.var_cedaf611f3c02546;
    self.var_7a0c0f1f8552f73e = struct.var_7a0c0f1f8552f73e;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        self.loadoutEquipmentTertiary = struct.loadoutEquipmentTertiary;
        self.var_b32cdcb41c22f1be = struct.var_b32cdcb41c22f1be;
    }
    
    if ( !usingrespawnitems )
    {
        var_908edfb703ce80d1 = struct.loadoutequipmentprimary;
        var_5a1ed6750ff09281 = struct.loadoutequipmentsecondary;
        
        if ( level.var_613ba3e28ca2d235 )
        {
            var_426598ec562d7261 = struct.loadoutEquipmentTertiary;
        }
    }
    else
    {
        var_908edfb703ce80d1 = respawnitems_getequipmentref( respawnitems, "primary" );
        var_5a1ed6750ff09281 = respawnitems_getequipmentref( respawnitems, "secondary" );
        
        if ( level.var_613ba3e28ca2d235 )
        {
            var_426598ec562d7261 = respawnitems_getequipmentref( respawnitems, "tertiary" );
        }
    }
    
    if ( options.var_29c8c383efb94d57 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        itembundle = common_item::function_cf68ad18114498b2( struct.loadoutequipmentprimary );
        item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
        itembundle = common_item::function_cf68ad18114498b2( struct.loadoutequipmentsecondary );
        item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
        
        if ( level.var_613ba3e28ca2d235 )
        {
            itembundle = common_item::function_cf68ad18114498b2( struct.loadoutEquipmentTertiary );
            item = common_item::function_61c2c0251e742ffd( itembundle, common_item::function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1, spawnoptions );
        }
    }
    else
    {
        var_87ebce4cb9d9243c = struct.var_a1191d5606e653f0;
        var_a7ed574b449d9650 = level.equipment.table[ var_908edfb703ce80d1 ].bundle;
        giveprimary = !level.var_8fa813be08407e9a || usingrespawnitems;
        givesecondary = !level.var_8435149df71566da || usingrespawnitems;
        
        if ( level.var_613ba3e28ca2d235 )
        {
            givetertiary = !level.var_9bbb6e59f0d3bd58 || usingrespawnitems;
        }
        
        if ( level.var_b8686b90947d6097 )
        {
            giveprimary = giveprimary && isdefined( var_908edfb703ce80d1 );
            givesecondary = givesecondary && isdefined( var_5a1ed6750ff09281 );
            
            if ( level.var_613ba3e28ca2d235 )
            {
                givetertiary = givetertiary && isdefined( var_426598ec562d7261 );
            }
        }
        
        if ( giveprimary )
        {
            if ( !var_a7ed574b449d9650.var_ff969a74ed1aaeba || level.var_83d8ad2846573fbf )
            {
                if ( !self.var_b4c45c2992c2e37c.stackprimary )
                {
                    equipment_mp::giveequipment( var_908edfb703ce80d1, "primary", class, var_87ebce4cb9d9243c, self.var_cedaf611f3c02546 );
                }
            }
            else
            {
                equipment_mp::function_5d2b66cabb4afed7( var_908edfb703ce80d1, var_a7ed574b449d9650, "primary", var_87ebce4cb9d9243c, self.var_cedaf611f3c02546, class );
            }
        }
        
        var_42a17be4f1eba70c = struct.var_9481e959139fe88;
        var_527f946f17a1700 = level.equipment.table[ var_5a1ed6750ff09281 ].bundle;
        
        if ( givesecondary )
        {
            if ( !var_527f946f17a1700.var_ff969a74ed1aaeba || level.var_83d8ad2846573fbf )
            {
                if ( !self.var_b4c45c2992c2e37c.stacksecondary )
                {
                    equipment_mp::giveequipment( var_5a1ed6750ff09281, "secondary", class, var_42a17be4f1eba70c, self.var_7a0c0f1f8552f73e );
                }
            }
            else
            {
                equipment_mp::function_5d2b66cabb4afed7( var_5a1ed6750ff09281, var_527f946f17a1700, "secondary", var_42a17be4f1eba70c, self.var_7a0c0f1f8552f73e, class );
            }
        }
        
        if ( level.var_613ba3e28ca2d235 )
        {
            var_eae791bb654ed66c = struct.var_324b19b627387508;
            var_1b63037005a7d9e0 = level.equipment.table[ var_426598ec562d7261 ].bundle;
            
            if ( givetertiary )
            {
                if ( !var_1b63037005a7d9e0.var_ff969a74ed1aaeba || level.var_83d8ad2846573fbf )
                {
                    if ( !self.var_b4c45c2992c2e37c.stacktertiary )
                    {
                        equipment_mp::giveequipment( var_426598ec562d7261, "tertiary", class, var_eae791bb654ed66c, self.var_b32cdcb41c22f1be );
                    }
                }
                else
                {
                    equipment_mp::function_5d2b66cabb4afed7( var_426598ec562d7261, var_1b63037005a7d9e0, "tertiary", var_eae791bb654ed66c, self.var_b32cdcb41c22f1be, class );
                }
            }
        }
    }
    
    if ( level.allowarmor && !var_9edcca6343f41f5b )
    {
        utility::callsharedfunc( #"armor", #"hash_75e364874abb092f" );
    }
    
    if ( equipment_mp::function_e210084550f602a() )
    {
        equipment_mp::incrementequipmentammo( var_908edfb703ce80d1, self.var_e2083398840cb40c );
    }
    
    if ( equipment_mp::function_18b9048f4179b66b() )
    {
        equipment_mp::incrementequipmentammo( var_5a1ed6750ff09281, self.var_298c5ef409ca127 );
    }
    
    if ( level.var_613ba3e28ca2d235 && isdefined( self.perks[ "specialty_extra_tertiary" ] ) )
    {
        equipment_mp::incrementequipmentammo( var_426598ec562d7261, self.var_218167271e2aeae4 );
    }
    
    classtype = loadout_getclasstype( class );
    var_aaec75f68d9cc2f6 = undefined;
    
    if ( !level.var_8fa813be08407e9a )
    {
        var_aaec75f68d9cc2f6 = equipment_mp::function_7a52ef490f6da37a( classtype );
    }
    
    var_d686f40b80029d52 = undefined;
    
    if ( !level.var_8435149df71566da )
    {
        var_d686f40b80029d52 = equipment_mp::function_909ac8ba57a9d26e( classtype );
    }
    
    if ( level.var_613ba3e28ca2d235 )
    {
        var_bf5c447e31579722 = undefined;
        
        if ( !level.var_9bbb6e59f0d3bd58 )
        {
            var_bf5c447e31579722 = equipment_mp::function_fde3068b9ac629fe( classtype );
        }
    }
    
    if ( level.var_bece8079501efa50 )
    {
        self [[ level.var_bece8079501efa50 ]]( [ var_908edfb703ce80d1, var_5a1ed6750ff09281 ] );
    }
    
    if ( var_aaec75f68d9cc2f6 )
    {
        equipment_mp::incrementequipmentammo( var_908edfb703ce80d1, undefined, class );
    }
    
    if ( var_d686f40b80029d52 )
    {
        equipment_mp::incrementequipmentammo( var_5a1ed6750ff09281, undefined, class );
    }
    
    if ( var_bf5c447e31579722 )
    {
        equipment_mp::incrementequipmentammo( var_426598ec562d7261, undefined, class );
    }
    
    if ( usingrespawnitems )
    {
        respawnitems_giveequipmentammo( respawnitems, "primary" );
        respawnitems_giveequipmentammo( respawnitems, "secondary" );
    }
    
    if ( nvg::function_c58b7b66805088f5() )
    {
        thread nvg::runnvg();
        thread loadout_updateplayernvgs();
    }
}

// Namespace class
// Params 0
// Checksum 0x4a8ab24a, Offset: 0x121e7
// Size: 0xec
function loadout_updateplayernvgs()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_85cedbb6e879103e" );
    self endon( #"hash_85cedbb6e879103e" );
    apply = 0;
    
    if ( game[ "roundsPlayed" ] == 0 && !self.hasspawned && ( utility::isnightmap() || getdvarint( @"hash_68a323d5bd07266c", 0 ) == 1 ) )
    {
        if ( !flags::gameflag( "infil_will_run" ) || flags::gameflag( "infil_started" ) )
        {
            apply = 1;
        }
    }
    else if ( self.pers[ "useNVG" ] )
    {
        apply = 1;
    }
    
    if ( self.inspawncamera )
    {
        utility::waittill_any( "spawned_player", "fadeUp_start" );
    }
    
    while ( !isdefined( self.operatorcustomization ) )
    {
        waitframe();
    }
    
    if ( apply )
    {
        self nightvisionviewon( 1 );
    }
    
    nvg::nvg_update3rdperson( apply );
}

// Namespace class
// Params 1
// Checksum 0x53b94f98, Offset: 0x122db
// Size: 0x15c
function loadout_updateplayersuper( struct )
{
    var_6d4a186900955135 = struct.loadoutsuper;
    respawnitems = self.respawnitems;
    usingrespawnitems = respawnitems_hassuperdata( respawnitems );
    
    if ( usingrespawnitems )
    {
        var_6d4a186900955135 = respawnitems_getsuperref( respawnitems );
    }
    
    if ( isdefined( supers_mp::getcurrentsuper() ) )
    {
        currentsuper = supers_mp::getcurrentsuperref();
        
        if ( currentsuper == var_6d4a186900955135 && !haschangedarchetype() )
        {
            supers_mp::givesuperweapon( self.super );
            return;
        }
    }
    
    if ( var_6d4a186900955135 == "none" || !level.allowsupers )
    {
        supers_mp::clearsuper();
        self.loadoutsuper = undefined;
        return;
    }
    
    if ( level.allowsupers && isdefined( self.pers[ "gamemodeLoadout" ][ "loadoutSuper" ] ) )
    {
        self.loadoutsuper = self.pers[ "gamemodeLoadout" ][ "loadoutSuper" ];
        supers_mp::givesuper( self.loadoutsuper, 1 );
        return;
    }
    
    self.loadoutsuper = struct.loadoutsuper;
    supers_mp::givesuper( var_6d4a186900955135, 1 );
    
    if ( usingrespawnitems )
    {
        supers_mp::setsuperbasepoints( respawnitems_getsuperpoints( respawnitems ) );
        supers_mp::setsuperextrapoints( respawnitems_getsuperextrapoints( respawnitems ) );
    }
}

// Namespace class
// Params 1
// Checksum 0x7b46cd60, Offset: 0x1243f
// Size: 0x6a
function loadout_updateplayergesture( struct )
{
    if ( isdefined( level.projectbundle.gesturelist ) )
    {
        if ( !self.btestclient )
        {
            if ( struct.loadoutgesture != "none" )
            {
                self.loadoutgesture = struct.loadoutgesture;
                gestures::givegesture( struct.loadoutgesture );
            }
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xacd4a9b7, Offset: 0x124b1
// Size: 0xc3
function loadout_updateplayerstreaktype( struct )
{
    self.streaktype = loadout_getplayerstreaktype( struct.loadoutstreaktype );
    var_b88bca548b133587 = isdefined( level.gametypebundle ) && level.gametypebundle.var_810c88117fa06279;
    
    if ( isdefined( level.gametype ) && !isbrgamemode() && !var_b88bca548b133587 )
    {
        isscorestreaktype = self getplayerdata( level.loadoutdata, "squadMembers", "scoreStreak" );
        
        /#
            if ( !isscorestreaktype )
            {
                debugscorestreak = getdvarint( @"scr_enable_scorestreaks", 0 );
                isscorestreaktype = debugscorestreak;
            }
        #/
        
        self.scorestreaktype = istrue( isscorestreaktype );
    }
}

// Namespace class
// Params 2
// Checksum 0xa631f88d, Offset: 0x1257c
// Size: 0x84
function function_4e4f82219a34494c( struct, streakname )
{
    blueprintindex = 0;
    
    if ( streakname == struct.loadoutkillstreak1 )
    {
        blueprintindex = struct.var_2ca84378b025c036;
    }
    else if ( streakname == struct.loadoutkillstreak2 )
    {
        blueprintindex = struct.var_efe096b4dabb84e3;
    }
    else if ( streakname == struct.loadoutkillstreak3 )
    {
        blueprintindex = struct.var_dc8ecd8732f650c4;
    }
    
    return blueprintindex;
}

// Namespace class
// Params 2
// Checksum 0x3bedf81e, Offset: 0x12609
// Size: 0x29
function loadout_updateplayerperkstreaks( struct, class )
{
    self.perkstreaks = struct.loadoutperkstreaks;
}

// Namespace class
// Params 1
// Checksum 0xa5ee5c79, Offset: 0x1263a
// Size: 0x11f
function function_3eadf9f9486c1d3f( struct )
{
    if ( level.wildcard_perkstreak_unavailable )
    {
        return;
    }
    
    if ( struct.loadoutwildcard != "wildcard_perkstreak" )
    {
        return;
    }
    
    perks = [];
    
    for ( index = 0; index < 3 ; index++ )
    {
        cacperkstreak = undefined;
        
        if ( function_4d362babbfd5b4b1() )
        {
            lootid = self getplayerdata( self.loadoutdata, "loadouts", self.class_num, "perkStreakLootIDs", index );
            
            if ( lootid == 0 )
            {
                cacperkstreak = "specialty_null";
            }
            else
            {
                cacperkstreak = loot::function_f54ecb89dfab8e8c( lootid );
            }
            
            if ( cacperkstreak.size == 0 )
            {
                break;
            }
        }
        else
        {
            cacperkstreak = self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", self.class_num, "perkStreak" );
        }
        
        if ( cacperkstreak )
        {
            perks[ perks.size ] = cacperkstreak;
        }
    }
    
    perks[ perks.size ] = "specialty_perkstreaks";
    struct.loadoutperkstreaks = perks;
    self.perkstreaks = struct.loadoutperkstreaks;
}

// Namespace class
// Params 2
// Checksum 0x8031e080, Offset: 0x12761
// Size: 0x755
function loadout_updateplayerkillstreaks( struct, class )
{
    if ( level.gamemodebundle.streakearn == #"score" )
    {
        perk::giveperk( "specialty_killstreak_to_scorestreak" );
    }
    
    var_d2aa9771b99aa4ec = isdefined( self.perks[ "specialty_perkstreaks" ] );
    
    if ( !level.allowkillstreaks && !var_d2aa9771b99aa4ec )
    {
        struct.loadoutkillstreak1 = "none";
        struct.loadoutkillstreak2 = "none";
        struct.loadoutkillstreak3 = "none";
        struct.var_2ca84378b025c036 = 0;
        struct.var_efe096b4dabb84e3 = 0;
        struct.var_dc8ecd8732f650c4 = 0;
    }
    
    if ( struct.loadoutstreaksfilled == 0 && isdefined( self.streakdata ) && self.streakdata.streaks.size > 0 && class == "gamemode" )
    {
        collected = 0;
        
        foreach ( key, killstreak in self.streakdata.streaks )
        {
            if ( isxhash( key ) && key == #"high_roller" )
            {
                continue;
            }
            
            if ( collected == 0 )
            {
                struct.loadoutkillstreak1 = killstreak.streakname;
                struct.var_2ca84378b025c036 = 0;
                collected++;
                continue;
            }
            
            if ( collected == 1 )
            {
                struct.loadoutkillstreak2 = killstreak.streakname;
                struct.var_efe096b4dabb84e3 = 0;
                collected++;
                continue;
            }
            
            if ( collected == 2 )
            {
                struct.loadoutkillstreak3 = killstreak.streakname;
                struct.var_dc8ecd8732f650c4 = 0;
                break;
            }
        }
    }
    
    var_3fed5397d9ea73b5 = [ struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3 ];
    self.loadoutusingspecialist = level.useperkpackage ? 0 : struct.loadoutusingspecialist;
    
    if ( level.gamemodebundle.var_2cb40e0296514a72 && !level.useperkpackage && var_d2aa9771b99aa4ec )
    {
        var_3fed5397d9ea73b5 = replacewithspecialistkillstreaks( struct );
    }
    
    respawnitems = self.respawnitems;
    usingrespawnitems = respawnitems_hasstreakdata( respawnitems );
    
    if ( usingrespawnitems && ( level.allowkillstreaks || var_d2aa9771b99aa4ec ) )
    {
        var_3fed5397d9ea73b5 = respawnitems_getstreaks( respawnitems );
    }
    
    if ( level.allowkillstreaks && !var_d2aa9771b99aa4ec )
    {
        var_3fed5397d9ea73b5 = sortkillstreaksbycost( var_3fed5397d9ea73b5 );
    }
    
    if ( level.killstreak_escalation.overrides )
    {
        var_3fed5397d9ea73b5 = [];
        
        foreach ( struct in level.killstreak_escalation.overrides )
        {
            var_3fed5397d9ea73b5[ var_3fed5397d9ea73b5.size ] = struct.ref;
        }
    }
    
    streaksupdated = 0;
    
    if ( !isagent( self ) )
    {
        var_8bcf27967983c34f = !killstreaks::arekillstreaksequipped( var_3fed5397d9ea73b5 );
        
        if ( !var_8bcf27967983c34f )
        {
            if ( isdefined( self.callbacks[ #"hash_152a1ab7758bead2" ] ) || isdefined( level.callbacks[ #"hash_152a1ab7758bead2" ] ) )
            {
                var_ec7b0c2ee85103f = {};
                callback::callback( #"hash_152a1ab7758bead2", var_ec7b0c2ee85103f );
                
                if ( var_ec7b0c2ee85103f.needsupdating )
                {
                    var_8bcf27967983c34f = 1;
                }
            }
        }
        
        if ( var_8bcf27967983c34f )
        {
            self notify( #"hash_ed3f1f9683d18cd9" );
            var_a9551ece556205ae = killstreaks::getgimmeslotkillstreakstructs();
            earnedkillstreaks = killstreaks::getavailableequippedkillstreakstructs();
            
            if ( !isdefined( self.perks[ "specialty_support_killstreaks" ] ) && !self.earnedmaxkillstreak )
            {
                killstreaks::clearkillstreaks();
            }
            
            if ( level.projectbundle.var_6549de919aac5cec )
            {
                foreach ( streakindex, streak in earnedkillstreaks )
                {
                    var_dbfbe6a412116bb7 = killstreaks::createstreakitemstruct( streak.streakname );
                    var_a9551ece556205ae[ var_a9551ece556205ae.size ] = var_dbfbe6a412116bb7;
                }
                
                earnedkillstreaks = undefined;
            }
            
            for ( streakindex = 0; streakindex < var_3fed5397d9ea73b5.size ; streakindex++ )
            {
                streak = var_3fed5397d9ea73b5[ streakindex ];
                
                if ( isdefined( streak ) && streak != "none" && streak != "" )
                {
                    killstreaks::equipkillstreak( streak, streakindex + 1, function_4e4f82219a34494c( struct, streak ) );
                }
            }
            
            if ( isdefined( self.callbacks[ #"hash_263b7787b761917f" ] ) || isdefined( level.callbacks[ #"hash_263b7787b761917f" ] ) )
            {
                var_fe686fd39270112c = { #loadoutstruct:struct, #namedstreaks:[] };
                callback::callback( #"hash_263b7787b761917f", var_fe686fd39270112c );
                
                foreach ( streakslot, streak in var_fe686fd39270112c.namedstreaks )
                {
                    if ( isdefined( streak ) && streak != "none" && streak != "" )
                    {
                        killstreaks::equipkillstreak( streak, streakslot, function_4e4f82219a34494c( struct, streak ) );
                    }
                }
            }
            
            if ( var_a9551ece556205ae.size > 0 )
            {
                for ( structindex = var_a9551ece556205ae.size - 1; structindex >= 0 ; structindex-- )
                {
                    streak = var_a9551ece556205ae[ structindex ];
                    
                    if ( !streak.isspecialist )
                    {
                        killstreaks::awardkillstreakfromstruct( var_a9551ece556205ae[ structindex ], "other" );
                    }
                }
            }
            
            for ( structindex = 0; structindex < earnedkillstreaks.size ; structindex++ )
            {
                streak = earnedkillstreaks[ structindex ];
                
                if ( !streak.isspecialist )
                {
                    killstreaks::awardkillstreakfromstruct( earnedkillstreaks[ structindex ], "other", undefined, undefined, undefined, streak.slotnumber );
                }
            }
            
            streaksupdated = 1;
        }
    }
    
    callback::callback( #"hash_2e73c786a3b2d7b2", { #streaksupdated:streaksupdated } );
    self notify( #"hash_d3c2fc4c31a502ec" );
}

// Namespace class
// Params 1
// Checksum 0x97e3efd, Offset: 0x12ebe
// Size: 0xdd
function sortkillstreaksbycost( streaklist )
{
    for ( i = 0; i < streaklist.size - 1 ; i++ )
    {
        if ( isdefined( streaklist[ i ] ) && streaklist[ i ] != "none" && streaklist[ i ] != "" )
        {
            for ( j = i + 1; j < streaklist.size ; j++ )
            {
                if ( isdefined( streaklist[ j ] ) && streaklist[ j ] != "none" && streaklist[ j ] != "" )
                {
                    currentcost = killstreaks::calcstreakcost( streaklist[ i ] );
                    nextcost = killstreaks::calcstreakcost( streaklist[ j ] );
                    
                    if ( nextcost < currentcost )
                    {
                        ref = streaklist[ j ];
                        streaklist[ j ] = streaklist[ i ];
                        streaklist[ i ] = ref;
                    }
                }
            }
        }
    }
    
    return streaklist;
}

// Namespace class
// Params 2
// Checksum 0xd7915d75, Offset: 0x12fa4
// Size: 0x22
function loadout_updateplayeractionslots( struct, class )
{
    self setactionslot( 3, "altmode" );
}

// Namespace class
// Params 2
// Checksum 0x1ee2cd59, Offset: 0x12fce
// Size: 0x3e6
function loadout_updatefieldupgrades( struct, class )
{
    if ( isdefined( class ) && ( class == "juggernaut" || class == "superpower" ) )
    {
        return;
    }
    
    respawnitems = self.respawnitems;
    
    if ( respawnitems_hassuperdata( respawnitems ) )
    {
        [ self.loadoutfieldupgrade1, self.loadoutfieldupgrade2 ] = respawnitems_getsuperfieldupgrades( respawnitems );
    }
    else
    {
        self.loadoutfieldupgrade1 = struct.loadoutfieldupgrade1;
        self.var_6b08217cbc33ea5c = struct.var_6b08217cbc33ea5c;
        self.var_6dd76aa72f0c26e1 = struct.var_6dd76aa72f0c26e1;
        self.loadoutfieldupgrade2 = struct.loadoutfieldupgrade2;
        self.var_5e73e76f67b0afed = struct.var_e5495cc8199ea32f;
        self.var_3834964fc455658e = struct.var_3834964fc455658e;
    }
    
    if ( level.var_5f50c32cec04ffe0 || superisrestricted( self.loadoutfieldupgrade1 ) )
    {
        self.loadoutfieldupgrade1 = "none";
        self.var_6b08217cbc33ea5c = 0;
        self.var_6dd76aa72f0c26e1 = [];
    }
    
    if ( level.var_5f50c32cec04ffe0 || superisrestricted( self.loadoutfieldupgrade2 ) )
    {
        self.loadoutfieldupgrade2 = "none";
        self.var_5e73e76f67b0afed = 0;
        self.var_3834964fc455658e = [];
    }
    
    if ( game_utility_mp::isanymlgmatch() || self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2 )
    {
        self.loadoutfieldupgrade2 = "none";
        self.var_5e73e76f67b0afed = 0;
        self.var_3834964fc455658e = [];
    }
    
    if ( level.allowsupers )
    {
        mapname = game_utility::getmapname();
        
        if ( issubstr( mapname, "mp_m_" ) && mapname != "mp_m_speed" )
        {
            self.loadoutfieldupgrade1 = function_e44a686e735af760( self.loadoutfieldupgrade1 );
            self.loadoutfieldupgrade2 = function_e44a686e735af760( self.loadoutfieldupgrade2 );
            
            if ( self.loadoutfieldupgrade1 == self.loadoutfieldupgrade2 )
            {
                self.loadoutfieldupgrade2 = "none";
                self.var_5e73e76f67b0afed = 0;
                self.var_3834964fc455658e = [];
            }
        }
        
        thread supers_mp::watchplayersuperdelayweapon();
        thread perkpackage::perkpackage_initperkpackages();
        
        if ( !level.var_be3230656ced9724 && ( isbrgamemode() || common_inventory::inventory_isenabled() ) )
        {
            super = fixsuperforbr( self.loadoutfieldupgrade1 );
            
            if ( isdefined( level.forcegivesuper ) )
            {
                self [[ level.forcegivesuper ]]( super );
            }
        }
    }
    else if ( !level.var_be3230656ced9724 && ( isbrgamemode() || common_inventory::inventory_isenabled() ) )
    {
        self.loadoutbrfieldupgrade = fixsuperforbr( self.loadoutfieldupgrade1 );
        self.loadoutfieldupgrade1 = "none";
        self.var_6b08217cbc33ea5c = 0;
        self.var_6dd76aa72f0c26e1 = [];
        self.loadoutfieldupgrade2 = "none";
        self.var_5e73e76f67b0afed = 0;
        self.var_3834964fc455658e = [];
        
        if ( getdvarint( @"scr_disableperks", 0 ) == 0 )
        {
            perkpackage::perkpackage_initpersdata();
        }
        
        if ( level.gamemodebundle.var_6e029a8992f30541 && isdefined( level.forcegivesuper ) )
        {
            self [[ level.forcegivesuper ]]( self.loadoutbrfieldupgrade );
        }
    }
    
    if ( self.loadoutfieldupgrade1 != "super_emp_pulse" && self.loadoutfieldupgrade2 != "super_emp_pulse" )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"super_emp_pulse" ][ #"hash_443ff395a15388c5" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( 0 );
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xeac20738, Offset: 0x133bc
// Size: 0x62
function fixsuperforbr( superref )
{
    if ( !level.var_3e0ce9b4c749525f && !isdefined( superref ) )
    {
        return "super_ammo_drop";
    }
    
    if ( superref == "none" && !br_instance_inventory::function_926a8f8643d34690() )
    {
        return ( level.gametypebundle.prematchsuper ?? "super_ammo_drop" );
    }
    
    return superref;
}

// Namespace class
// Params 1
// Checksum 0x342d35f5, Offset: 0x13426
// Size: 0x55
function function_e44a686e735af760( loadoutfieldupgrade )
{
    switch ( loadoutfieldupgrade )
    {
        case #"hash_699e6c3e460adde4":
        case #"hash_7266a252f51150e9":
        case #"hash_ac520bae8aaba66b":
            loadoutfieldupgrade = "super_ammo_drop";
            break;
        default:
            break;
    }
    
    return loadoutfieldupgrade;
}

// Namespace class
// Params 2
// Checksum 0xe05845a2, Offset: 0x13484
// Size: 0xf6, Type: bool
function function_82b2dc7e29f59d( struct, class )
{
    if ( self.operatorcustomization.rebuild )
    {
        struct.operator = undefined;
        struct.operatorskin = undefined;
        return true;
    }
    
    if ( level.projectbundle.var_786bc1b37b3f67fa )
    {
        if ( !isdefined( struct.operator ) || !isdefined( struct.operatorskin ) )
        {
            return false;
        }
        
        if ( self.var_44212c4c1b32eae3 )
        {
            if ( loadout_getclasstype( class ) == "default" )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( struct.operator ) && isdefined( struct.operatorskin ) )
    {
        /#
            if ( getdvarint( @"hash_4a5e71f71cdf472f", 0 ) )
            {
                return false;
            }
        #/
        
        if ( self.operatorcustomization.skinref != struct.operatorskin )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 2
// Checksum 0x66e1f381, Offset: 0x13583
// Size: 0x12e
function function_3d518a47c4b095e6( struct, class )
{
    if ( isbot( self ) )
    {
        operatorref = operator::function_88393e18041634ac();
        operatorskin = operator::function_33d682bc951e8992();
    }
    else
    {
        operatorref = [[ level.sharedfuncs[ #"player" ][ #"hash_c631568a218d88a6" ] ]]( class );
        
        if ( isdefined( operatorref ) )
        {
            operatorskin = [[ level.sharedfuncs[ #"player" ][ #"hash_3f6034cbc65791c3" ] ]]( class );
        }
    }
    
    if ( !isdefined( operatorref ) )
    {
        superfactionindex = self.team == "allies" ? 0 : 1;
        operatorref = operator::function_297589994c9a9eff( superfactionindex );
        operatorskin = operator::function_447fce2531e40d0e( operatorref );
    }
    
    struct.operator = operatorref;
    struct.operatorskin = operatorskin;
    
    if ( isdefined( level.sharedfuncs[ #"voiceselection" ][ #"hash_21dde89b2676f0a8" ] ) )
    {
        struct = [[ level.sharedfuncs[ #"voiceselection" ][ #"hash_21dde89b2676f0a8" ] ]]( class, struct );
    }
    
    return struct;
}

// Namespace class
// Params 3
// Checksum 0x6b9f7c2e, Offset: 0x136ba
// Size: 0x14a
function function_a330728710083362( struct, class, options )
{
    if ( !options.keepoperator )
    {
        if ( !isdefined( self.operatorcustomization ) || function_82b2dc7e29f59d( struct, class ) )
        {
            operator::createoperatorcustomization( struct.operator, struct.operatorskin );
            
            if ( isdefined( level.sharedfuncs[ #"voiceselection" ][ #"hash_980225cc8bb3f9fa" ] ) )
            {
                self [[ level.sharedfuncs[ #"voiceselection" ][ #"hash_980225cc8bb3f9fa" ] ]]( struct );
            }
        }
    }
    
    self.maxpoise = 100;
    
    if ( utility::issharedfuncdefined( #"bodysize", #"hash_72910efb9e693a00" ) )
    {
        self.maxpoise = utility::callsharedfunc( #"bodysize", #"hash_72910efb9e693a00", self.operatorcustomization.operatorref ).maxpoise;
        self.poise = self.maxpoise;
    }
    
    self.poise = self.maxpoise;
    utility::callsharedfunc( #"bodysize", #"hash_b15f41d962f55b6c" );
}

// Namespace class
// Params 8
// Checksum 0x36e09cfb, Offset: 0x1380c
// Size: 0x2da
function loadout_updateplayer( globalstruct, struct, class, setspawnweap, skipfirstraise, var_468cbb735a52e11b, var_9edcca6343f41f5b, options )
{
    function_a330728710083362( struct, class, options );
    function_3eadf9f9486c1d3f( struct );
    loadout_updateplayerstreaktype( struct );
    loadout_updateplayerarchetype( struct, options );
    
    if ( !level.noweaponsonstart )
    {
        loadout_updateplayerweapons( struct, class, setspawnweap, skipfirstraise, var_468cbb735a52e11b, options );
    }
    
    loadout_updateplayerperks( struct, class, options );
    
    if ( !level.noweaponsonstart && !( level.var_8fa813be08407e9a && level.var_8435149df71566da ) )
    {
        loadout_updateplayerequipment( struct, class, var_9edcca6343f41f5b, options );
    }
    
    if ( !game[ "isLaunchChunk" ] && !isbrgamemode() && !level.gametypebundle.var_2a2653130aa31b2d )
    {
        loadout_updateplayerkillstreaks( struct, class );
    }
    
    loadout_updateplayeractionslots( struct, class );
    
    if ( !game[ "isLaunchChunk" ] && !level.var_613ba3e28ca2d235 )
    {
        loadout_updatefieldupgrades( struct, class );
    }
    
    if ( level.var_e1d4b8532f2bf85c && !isdefined( struct.operator ) )
    {
        assert( isdefined( level.var_77fb663123a79288 ), "<dev string:x4b5>" );
        random_team = randomint( 2 ) ? "allies" : "axis";
        random_operator = utility::array_random( level.var_77fb663123a79288[ random_team ] );
        struct.operator = level.var_77fb663123a79288[ random_team ][ random_operator[ 0 ] ];
    }
    
    self.pers[ "lastClass" ] = self.class;
    self.lastclass = self.class;
    self.lastarchetypeinfo = self.changedarchetypeinfo;
    
    if ( isdefined( self.gamemode_chosenclass ) )
    {
        self.pers[ "class" ] = self.gamemode_chosenclass;
        self.pers[ "lastClass" ] = self.gamemode_chosenclass;
        self.class = self.gamemode_chosenclass;
        self.lastclass = self.gamemode_chosenclass;
        self.gamemode_chosenclass = undefined;
    }
    
    if ( isdefined( self.revive_chosenclass ) )
    {
        self.pers[ "class" ] = self.revive_chosenclass;
        self.pers[ "lastClass" ] = self.revive_chosenclass;
        self.class = self.revive_chosenclass;
        self.lastclass = self.revive_chosenclass;
    }
    
    teams::setupplayermodel();
    setthirdpersonview();
}

// Namespace class
// Params 2
// Checksum 0xb5188a37, Offset: 0x13aee
// Size: 0x2e5
function setmlgspectatorclientloadoutdata( player, struct )
{
    if ( isagent( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player notify( #"hash_b662a6ba7d1a4c96" );
    player endon( #"hash_b662a6ba7d1a4c96" );
    player setclientweaponinfo( 0, struct.loadoutprimaryfullname );
    player.var_709577f800a50e3b = undefined;
    player setclientweaponinfo( 1, struct.loadoutsecondaryfullname );
    player.var_d0dcd97d91a4a748 = undefined;
    
    if ( isdefined( self.equipment[ "primary" ] ) )
    {
        var_7ba01742b7b8bf0c = equipment_mp::getequipmenttableinfo( self.equipment[ "primary" ] );
        
        if ( isdefined( var_7ba01742b7b8bf0c ) )
        {
            player setclientloadoutinfo( "primaryPower", var_7ba01742b7b8bf0c.id );
        }
    }
    else
    {
        player setclientloadoutinfo( "primaryPower", 0 );
    }
    
    if ( isdefined( self.equipment[ "secondary" ] ) )
    {
        var_4eeafd8096dd8864 = equipment_mp::getequipmenttableinfo( self.equipment[ "secondary" ] );
        
        if ( isdefined( var_4eeafd8096dd8864 ) )
        {
            player setclientloadoutinfo( "secondaryPower", var_4eeafd8096dd8864.id );
        }
    }
    else
    {
        player setclientloadoutinfo( "secondaryPower", 0 );
    }
    
    player setclientloadoutinfo( "fieldUpgrade", supers_mp::getsuperid( self.loadoutfieldupgrade1 ) );
    var_3f815fc839bafc54 = supers_mp::getsuperid( struct.loadoutsuper );
    player setclientloadoutinfo( "super", var_3f815fc839bafc54 );
    
    if ( isai( player ) )
    {
        for ( perkindex = 0; perkindex < struct.loadoutperks.size ; perkindex++ )
        {
            perk = struct.loadoutperks[ perkindex ];
            perkid = perks::function_95981724c25c1835( perk );
            player setclientloadoutinfo( perkindex + 1 + "_perk", perkid );
        }
    }
    else
    {
        if ( struct.loadoutperksfromgamemode )
        {
            struct.loadoutstandardperks = struct.loadoutperks;
        }
        
        for ( perkindex = 0; perkindex < self.pers[ "loadoutPerks" ].size ; perkindex++ )
        {
            perk = self.pers[ "loadoutPerks" ][ perkindex ];
            perkid = perks::function_95981724c25c1835( perk );
            player setclientloadoutinfo( perkindex + 1 + "_perk", perkid );
        }
        
        for ( perkindex = 0; perkindex < struct.loadoutextraperks.size ; perkindex++ )
        {
            perk = struct.loadoutextraperks[ perkindex ];
            perkid = perks::function_95981724c25c1835( perk );
            player setclientloadoutinfo( perkindex + 1 + "_extraPerk", perkid );
        }
    }
    
    rigtrait = struct.loadoutrigtrait;
    var_5c247cdf2a9e7fe5 = perks::function_95981724c25c1835( rigtrait );
    player setclientloadoutinfo( "rigTrait", var_5c247cdf2a9e7fe5 );
}

// Namespace class
// Params 1
// Checksum 0x13400688, Offset: 0x13ddb
// Size: 0x202
function shouldallowinstantclassswap( error )
{
    if ( vehicle::is_in_vehicle( 1 ) || self isonascender() )
    {
        disableclassswapallowed();
    }
    
    if ( game_utility_mp::isjuggermoshgamemode() )
    {
        return 0;
    }
    
    if ( game_utility::function_d60ba5ade32ddb31() )
    {
        if ( isdefined( error ) )
        {
            error.string = "MP/CHANGE_CLASS_NEXT_SPAWN";
        }
        
        return 0;
    }
    
    /#
        if ( getdvarint( @"hash_4c4ab1767cbd45aa", 0 ) == 1 )
        {
            if ( isdefined( error ) )
            {
                error.string = "<dev string:x4e4>";
            }
            
            return 0;
        }
        
        if ( getdvarint( @"hash_949bb374b6fa817f", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( game_utility::function_36ce69a7be195555() )
    {
        return 1;
    }
    
    if ( self.pers[ "forceDefaultLoadouts" ] )
    {
        return 1;
    }
    
    if ( !isdefined( self.instantclassswapallowed ) )
    {
        return 1;
    }
    
    var_b3ac82786c50196 = 0;
    
    if ( isbrgamemode() && !var_b3ac82786c50196 && !gamelogic_mp::inprematch() )
    {
        if ( isdefined( error ) && level.br_allowloadout && !level.br_allowloadoutonlyinprelobby )
        {
            error.string = "MP/CHANGE_CLASS_NEXT_SPAWN";
        }
        
        return 0;
    }
    
    /#
        if ( level.var_ae23cdf298259a28 )
        {
            return 1;
        }
    #/
    
    if ( !self.instantclassswapallowed )
    {
        if ( isdefined( self.var_c839f8b9780fe600 ) )
        {
            timepassed = ( gettime() - self.var_c839f8b9780fe600 ) / 1000;
            disabledtime = getdvarfloat( @"hash_ea52d059e79ddfbf", 10 );
            println( "<dev string:x4ff>" + timepassed + "<dev string:x52f>" + disabledtime );
            
            if ( isdefined( error ) )
            {
                error.string = "MP/CHANGE_CLASS_COOLDOWN_COMBAT";
                error.param = maxint( int( disabledtime - timepassed ), 1 );
            }
            
            return utility::time_has_passed( self.var_c839f8b9780fe600, disabledtime );
        }
        
        if ( isdefined( error ) )
        {
            error.string = "MP/CHANGE_CLASS_NEXT_SPAWN";
        }
        
        return 0;
    }
    
    return 1;
}

// Namespace class
// Params 0
// Checksum 0x683283e7, Offset: 0x13fe6
// Size: 0x2d7
function swaploadout()
{
    if ( utility::ent_flag_exist( "swapLoadout_blocked" ) && utility::ent_flag( "swapLoadout_blocked" ) )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"joined_team" );
        self endon( #"joined_spectators" );
        self notify( #"hash_9e1c21c199e3d5f2" );
        self endon( #"hash_9e1c21c199e3d5f2" );
        
        if ( !utility::ent_flag( "swapLoadout_pending" ) )
        {
            utility::ent_flag_set( "swapLoadout_pending" );
        }
        
        self waittill( #"swapLoadout_blocked" );
    }
    
    setclass( self.pers[ "class" ] );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    weapons::savetogglescopestates();
    weapons::savealtstates();
    weapons::function_7cc000a4d4bc9a60();
    self.var_c99cd485dda40b28 = 1;
    
    if ( game_utility_mp::allowclasschoice() )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "classChanges" ] ) )
            {
                self.leaderboarddata[ "classChanges" ] = self.leaderboarddata[ "classChanges" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "classChanges" ] ) )
            {
                [[ level.leaderboardfunc[ "classChanges" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x53d>" );
            
            if ( isdefined( self.pers[ "classChanges" ] ) )
            {
                self.pers[ "classChanges" ] = self.pers[ "classChanges" ] + 1;
            }
        }
    }
    
    giveloadout( self.pers[ "team" ], self.pers[ "class" ], undefined, 1 );
    
    if ( weapon::isakimbo( self.primaryweaponobj ) || weapon::isakimbo( self.secondaryweaponobj ) )
    {
        if ( !flags::gameflag( "prematch_done" ) && flags::gameflag( "infil_will_run" ) )
        {
            respawnitems = self.respawnitems;
            usingrespawnitems = respawnitems_hasweapondata( respawnitems );
            thread function_e79fc12390ff1916( self.primaryweaponobj, self.secondaryweaponobj, respawnitems, usingrespawnitems );
        }
    }
    
    var_250f673a62c724cf = isbrgamemode() && !flags::gameflag( "prematch_done" );
    
    if ( var_250f673a62c724cf && isdefined( level.var_5ece30396ddd4663 ) && !level.var_389f79c31f7b06b6 )
    {
        self [[ level.var_5ece30396ddd4663 ]]();
    }
    
    if ( utility::ent_flag_exist( "swapLoadout_pending" ) && utility::ent_flag( "swapLoadout_pending" ) )
    {
        utility::ent_flag_clear( "swapLoadout_pending" );
        utility::ent_flag_set( "swapLoadout_complete" );
    }
}

/#

    // Namespace class
    // Params 1
    // Checksum 0x1f145d92, Offset: 0x142c5
    // Size: 0x4f, Type: dev
    function function_1d6668561f286691( class )
    {
        if ( isbot( self ) )
        {
            var_ea26531fc574ade1 = getdvarint( @"hash_3b22f26edfbc398", 0 );
            
            if ( var_ea26531fc574ade1 > 0 )
            {
                class = "<dev string:x563>" + var_ea26531fc574ade1;
                self.preloadedclassstruct = undefined;
            }
        }
        
        return class;
    }

#/

// Namespace class
// Params 9
// Checksum 0xd288d778, Offset: 0x1431c
// Size: 0x5b1
function giveloadout( team, class, setspawnweap, var_cdccaae2e6a4aa0, skipfirstraise, var_e41679f53738a87f, var_468cbb735a52e11b, var_9edcca6343f41f5b, options )
{
    self notify( #"giveloadout_start" );
    
    if ( isdefined( self.callbacks[ #"hash_9622b7d2625165be" ] ) || isdefined( level.callbacks[ #"hash_9622b7d2625165be" ] ) )
    {
        callback::callback( #"hash_9622b7d2625165be", {} );
    }
    
    self.gettingloadout = 1;
    function_998337b629bb83ef( self );
    
    if ( getdvarint( @"hash_6a4d5cd30c97a609", 0 ) )
    {
        assertmsg( "<dev string:x56b>" + class );
        logstring( "\n Player already has " + self.perks.size + " perks." );
        
        foreach ( idx, perk in self.perks )
        {
            logstring( "\n" + idx );
        }
    }
    
    self.lastweaponobj = undefined;
    
    if ( isdefined( self.perks ) )
    {
        self.oldperks = self.perks;
    }
    
    var_d31c9faa2166bc3f = self.attached_bag;
    loadout_clearplayer( var_cdccaae2e6a4aa0, var_9edcca6343f41f5b, options );
    
    /#
        class = function_1d6668561f286691( class );
    #/
    
    globalstruct = loadout_getglobalclassstruct();
    globalstruct = loadout_updateglobalclass( globalstruct, class );
    self.globalstruct = globalstruct;
    struct = undefined;
    
    if ( isdefined( self.preloadedclassstruct ) )
    {
        struct = self.preloadedclassstruct;
        self.preloadedclassstruct = undefined;
        self.class_num = getclassindex( class );
    }
    else
    {
        struct = loadout_getclassstruct();
        struct = loadout_updateclass( struct, class, options.throttle );
    }
    
    self.classstruct = struct;
    loadout_updateplayer( globalstruct, struct, class, setspawnweap, skipfirstraise, var_468cbb735a52e11b, var_9edcca6343f41f5b, options );
    validation::function_433259b02f4ab842( struct );
    
    if ( class != "juggernaut" && class != "superpower" )
    {
        function_cc134deb92601b32( struct );
        
        if ( flags::gameflag( "prematch_done" ) )
        {
            loadout_lognewlygivenloadout( globalstruct, struct, class );
        }
    }
    
    self.gettingloadout = 0;
    
    if ( isdefined( var_d31c9faa2166bc3f ) && var_e41679f53738a87f )
    {
        backpack::attachbag( var_d31c9faa2166bc3f );
    }
    else if ( common_item::items_isenabled() )
    {
        item_backpack::function_dafbda061f5fa101();
    }
    else
    {
        backpack::attachbag( br_default_inventory::function_269d933ef7b39d72( self ) );
    }
    
    if ( respawnitems_hasrespawnitems() && ( isdefined( self.callbacks[ #"hash_f46cdaf446ff2fe5" ] ) || isdefined( level.callbacks[ #"hash_f46cdaf446ff2fe5" ] ) ) )
    {
        callback::callback( #"hash_f46cdaf446ff2fe5", {} );
    }
    
    respawnitems_clear();
    self notify( #"changed_kit" );
    self notify( #"giveloadout" );
    rank::tryresetrankxp();
    
    if ( !game[ "isLaunchChunk" ] && !isagent( self ) )
    {
        killstreaks::resetforloadoutswitch( options.fromspawnplayer );
    }
    
    playerlogic::trydisableminimap();
    var_eae4d92546b1a00a = getdvarint( @"hash_71175162fc904ea1", 0 );
    enableenemyoutlines = getdvarint( @"hash_cc275c16edd52097", 0 );
    
    if ( var_eae4d92546b1a00a > 0 )
    {
        thread function_76cc2e656d714f53( var_eae4d92546b1a00a );
    }
    
    if ( enableenemyoutlines > 0 )
    {
        thread function_6f4d2fd6c46e696b( enableenemyoutlines );
    }
    
    if ( getdvarint( @"hash_ae93197786d503ec", 0 ) == 1 )
    {
        thread monitorstowedriotshieldspeed();
    }
    
    if ( getdvar( @"hash_138eb261013ca091", "" ) != "" )
    {
        thread function_8124103b03efdf12();
    }
    
    if ( getdvarint( @"hash_862eba26990b004c", 0 ) == 1 )
    {
        thread function_6129faa650ca49b3();
    }
    
    if ( getdvarint( @"hash_f834da80397b0ab6", 0 ) == 1 )
    {
        thread disablesprintingpronehackcomplex();
    }
    
    if ( getdvarint( @"scr_remove_all_super_speed", 0 ) == 1 )
    {
        if ( self hasperk( "specialty_super_speed" ) )
        {
            self unsetperk( "specialty_super_speed", 1 );
        }
    }
    
    if ( getdvarint( @"hash_5853d4ddf45702de", 0 ) == 1 )
    {
        if ( !isdefined( self.perks[ "specialty_dash" ] ) )
        {
            self allowdash( 0 );
        }
    }
    
    if ( getdvarint( @"hash_778701d88a44a98f", 0 ) == 1 )
    {
        if ( !isdefined( self.perks[ "specialty_parkour" ] ) )
        {
            self allowwallrun( 0 );
        }
    }
    
    if ( getdvarint( @"hash_1988997dc2c8b83f", 0 ) == 1 )
    {
        foreach ( weapon in self.weaponlist )
        {
            if ( weapon.basename == "jup_jp26_la_mike32_mp" )
            {
                thread function_2e3d65c182c64c5b( weapon );
            }
        }
    }
    
    if ( isdefined( self.callbacks[ #"loadout_given" ] ) || isdefined( level.callbacks[ #"loadout_given" ] ) )
    {
        callback::callback( #"loadout_given", {} );
    }
}

// Namespace class
// Params 0
// Checksum 0xafb4a669, Offset: 0x148d5
// Size: 0x72
function disablesprintingpronehackcomplex()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.var_b64b12f21408f6b3 == 0 )
        {
            continue;
        }
        
        if ( self isjumping() )
        {
            val::set( "disableSprintingProneHackComplex", "prone", 0 );
            
            while ( self isjumping() )
            {
                wait 0.1;
            }
            
            val::set( "disableSprintingProneHackComplex", "prone", 1 );
        }
    }
}

// Namespace class
// Params 0
// Checksum 0xd9e7d1cc, Offset: 0x1494f
// Size: 0x4a
function function_6129faa650ca49b3()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self issprinting() && self getstance() == "prone" )
        {
            self setstance( "stand" );
        }
        
        wait 0.1;
    }
}

// Namespace class
// Params 0
// Checksum 0x49c43978, Offset: 0x149a1
// Size: 0xfd
function function_8124103b03efdf12()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 0.3;
    execution = getdvar( @"hash_138eb261013ca091" );
    
    if ( execution )
    {
        if ( isplayer( self ) )
        {
            self clearexecution();
            
            if ( isdefined( self.equippedweapons ) )
            {
                foreach ( weapon in self.equippedweapons )
                {
                    if ( issubstr( weapon.basename, "iw8_execution_" ) )
                    {
                        self takeweapon( weapon );
                    }
                }
            }
            
            execution::_giveexecution( execution );
            self iprintlnbold( "Execution Equipped:" + execution );
        }
    }
}

// Namespace class
// Params 1
// Checksum 0x91432d51, Offset: 0x14aa6
// Size: 0x3f
function function_cc134deb92601b32( struct )
{
    if ( level.codcasterenabled )
    {
        if ( !isplayer( self ) && !isalive( self ) )
        {
            return;
        }
        
        if ( isagent( self ) )
        {
            return;
        }
        
        thread setmlgspectatorclientloadoutdata( self, struct );
    }
}

// Namespace class
// Params 3
// Checksum 0xf8b37bf2, Offset: 0x14aed
// Size: 0x4a0
function loadout_lognewlygivenloadout( globalstruct, struct, class )
{
    if ( !isplayer( self ) && !isalive( self ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( level.codcasterenabled )
    {
        thread setmlgspectatorclientloadoutdata( self, struct );
    }
    
    if ( getdvarint( @"online_matchdata_enabled" ) == 0 )
    {
        return;
    }
    
    if ( self.var_8cd4fafa67a4f362 )
    {
        return;
    }
    
    if ( struct.iscopiedclass )
    {
        var_e7f97a78edc6e299 = 99;
        classtype = "copied";
    }
    else
    {
        var_e7f97a78edc6e299 = getclassindex( class );
        classtype = loadout_getclasstype( class );
        isdefaultclass = getsubstr( class, 0, 7 ) == "default";
        self.loadoutclass = class;
        
        if ( isdefaultclass )
        {
            var_e7f97a78edc6e299 += 20;
        }
    }
    
    var_13a62eb300beb02d = struct.tweakedbyplayerduringmatch || struct.gamemodeforcednewloadout;
    
    if ( isdefined( struct ) )
    {
        struct.tweakedbyplayerduringmatch = 0;
        struct.gamemodeforcednewloadout = 0;
    }
    
    var_e09c81b2bbdea49b = 0;
    
    if ( !isdefined( self.pers[ "loggedClasses" ] ) )
    {
        self.pers[ "loggedClasses" ] = [];
    }
    
    loadoutindex = -1;
    
    foreach ( index, loggedclass in self.pers[ "loggedClasses" ] )
    {
        var_359651f4d7d71fd6 = self.pers[ "loggedClasses" ][ index ];
        
        if ( var_359651f4d7d71fd6 == var_e7f97a78edc6e299 )
        {
            if ( var_13a62eb300beb02d )
            {
                var_e09c81b2bbdea49b += 1;
                continue;
            }
            
            loadoutindex = index;
        }
    }
    
    primaryblueprint = undefined;
    secondaryblueprint = undefined;
    
    if ( loadoutindex == -1 || struct.iscopiedclass )
    {
        loadoutindex = self.pers[ "loggedClasses" ].size;
        self.pers[ "loggedClasses" ][ loadoutindex ] = var_e7f97a78edc6e299;
        primaryweapon = struct.loadoutprimaryobject;
        
        if ( isdefined( primaryweapon ) )
        {
            primaryvariantid = primaryweapon.variantid;
            
            if ( isdefined( primaryvariantid ) )
            {
                var_cdc949f6756caf78 = getweaponrootstring( primaryweapon ) + "|" + primaryvariantid;
                blueprint = primaryweapon.weaponblueprint;
                
                if ( isdefined( blueprint ) )
                {
                    primaryblueprint = blueprint;
                    primaryblueprint.blueprintname = var_cdc949f6756caf78;
                }
            }
        }
        
        secondaryweapon = struct.loadoutsecondaryobject;
        
        if ( isdefined( secondaryweapon ) )
        {
            secondaryvariantid = secondaryweapon.variantid;
            
            if ( isdefined( secondaryvariantid ) )
            {
                var_a954b06c700a4b28 = getweaponrootstring( secondaryweapon ) + "|" + secondaryvariantid;
                blueprint = secondaryweapon.weaponblueprint;
                
                if ( isdefined( blueprint ) )
                {
                    secondaryblueprint = blueprint;
                    secondaryblueprint.blueprintname = var_a954b06c700a4b28;
                }
            }
        }
        
        telemetry_data = spawnstruct();
        
        if ( isdefined( self.pers[ "telemetry" ].life.life_index ) )
        {
            telemetry_data.lifeindex = self.pers[ "telemetry" ].life.life_index;
        }
        
        if ( isdefined( primaryblueprint ) )
        {
            telemetry_data.primaryblueprint = primaryblueprint;
        }
        
        if ( isdefined( secondaryblueprint ) )
        {
            telemetry_data.secondaryblueprint = secondaryblueprint;
        }
        
        telemetry_data.globalstruct = globalstruct;
        telemetry_data.classstruct = struct;
        telemetry_data.classtype = classtype;
        telemetry_data.loadoutindex = loadoutindex;
        telemetry_data.var_e09c81b2bbdea49b = var_e09c81b2bbdea49b;
        telemetry_data.player = self;
        telemetry_utils::function_af2d366f9522f76f( "callback_player_new_loadout_used", telemetry_data );
    }
    
    if ( self.loadoutindex != loadoutindex )
    {
        telemetry_data = spawnstruct();
        telemetry_data.player = self;
        telemetry_data.globalstruct = globalstruct;
        telemetry_data.struct = struct;
        telemetry_data.class = class;
        telemetry_utils::function_af2d366f9522f76f( "callback_player_loadout_changed", telemetry_data );
    }
    
    self.loadoutindex = loadoutindex;
}

// Namespace class
// Params 0
// Checksum 0x84ecf90b, Offset: 0x14f95
// Size: 0x13, Type: bool
function hasvalidationinfraction()
{
    return self.pers[ "validationInfractions" ] > 0;
}

// Namespace class
// Params 0
// Checksum 0xc757cb82, Offset: 0x14fb1
// Size: 0x37
function recordvalidationinfraction()
{
    if ( isdefined( self.pers[ "validationInfractions" ] ) )
    {
        self.pers[ "validationInfractions" ] = self.pers[ "validationInfractions" ] + 1;
    }
}

// Namespace class
// Params 1
// Checksum 0x31cac30c, Offset: 0x14ff0
// Size: 0x64
function _detachall( var_8f6b0fac52a01e09 )
{
    if ( !var_8f6b0fac52a01e09 )
    {
        self.headmodel = undefined;
    }
    
    if ( isdefined( self.riotshieldmodel ) )
    {
        riotshield::riotshield_detach( 1 );
    }
    
    if ( isdefined( self.riotshieldmodelstowed ) )
    {
        riotshield::riotshield_detach( 0 );
    }
    
    if ( !var_8f6b0fac52a01e09 )
    {
        backpack::detachbag();
        self detachall();
    }
    
    nvg::clearnvg( istrue( var_8f6b0fac52a01e09 ) );
}

// Namespace class
// Params 0
// Checksum 0xa732e85d, Offset: 0x1505c
// Size: 0x9d
function trackriotshield_ontrophystow()
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    
    while ( true )
    {
        self waittill( #"grenade_pullback", objweapon );
        
        if ( objweapon.basename != "trophy_mp" )
        {
            continue;
        }
        
        if ( !isdefined( self.riotshieldmodel ) )
        {
            continue;
        }
        
        riotshield::riotshield_move( 1 );
        self waittill( #"offhand_end" );
        
        if ( weapon_utility::isriotshield( self getcurrentweapon() ) && isdefined( self.riotshieldmodelstowed ) )
        {
            riotshield::riotshield_move( 0 );
        }
    }
}

// Namespace class
// Params 1
// Checksum 0x387a2f5a, Offset: 0x15101
// Size: 0x77, Type: bool
function istwohandedoffhand( grenade )
{
    if ( isdefined( grenade ) && grenade.basename != "none" )
    {
        if ( weapon::issuperweapon( grenade.basename ) && !weapon::issupergestureweapon( grenade.basename ) )
        {
            return true;
        }
        
        equipmenttype = weapon::getequipmenttype( grenade );
        
        if ( equipmenttype == "lethal" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 0
// Checksum 0x1492cb79, Offset: 0x15181
// Size: 0x5d
function trackriotshield_grenadepullbackforc4()
{
    while ( true )
    {
        self waittill( #"grenade_pullback", grenade );
        
        if ( !isnullweapon( grenade ) && grenade.basename == "c4_mp" && weapon_utility::isriotshield( self getcurrentweapon() ) )
        {
            self.onriotshieldstow_force = 1;
        }
        
        waitframe();
    }
}

// Namespace class
// Params 0
// Checksum 0x2c6f53cd, Offset: 0x151e6
// Size: 0x65
function trackriotshield_updateoffhandstowignorec4()
{
    if ( !self.onriotshieldstow_force )
    {
        weaponobj = self getheldoffhand();
        
        if ( !isnullweapon( weaponobj ) && weaponobj.basename != "c4_mp" && weapon_utility::isriotshield( self getcurrentweapon() ) && istwohandedoffhand( weaponobj ) )
        {
            self.onriotshieldstow_force = 1;
        }
    }
}

// Namespace class
// Params 0
// Checksum 0x71c6f70d, Offset: 0x15253
// Size: 0x6a
function trackriotshield_watchswitchawayfromshield()
{
    self.riotshieldswitchawaytimer = undefined;
    self.riotshieldswitchaway = undefined;
    
    while ( true )
    {
        self waittill( #"weapon_switch_started", weapon );
        
        if ( !weapon_utility::isriotshield( weapon ) )
        {
            self.riotshieldswitchawaytimer = gettime() + 200;
            continue;
        }
        
        self.riotshieldswitchawaytimer = undefined;
        self.riotshieldswitchaway = undefined;
    }
}

// Namespace class
// Params 0
// Checksum 0x64add66a, Offset: 0x152c5
// Size: 0x43
function trackriotshield_watchcancelswitchaway()
{
    while ( true )
    {
        self waittill( #"weapon_switch_canceled", weapon );
        waittillframeend();
        
        if ( weapon_utility::isriotshield( weapon ) )
        {
            self.riotshieldswitchawaytimer = undefined;
            self.riotshieldswitchaway = undefined;
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xb7fa173c, Offset: 0x15310
// Size: 0x1ee
function trackriotshield_monitorshieldattach( wasinlaststand )
{
    self notify( #"hash_91a3a5607e96b9d6" );
    self endon( #"hash_91a3a5607e96b9d6" );
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"hash_f0727a24a36040ec" );
    
    if ( isdefined( self.infil ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    childthread trackriotshield_grenadepullbackforc4();
    
    if ( isdefined( wasinlaststand ) )
    {
        self.wasinlaststand = wasinlaststand;
    }
    else if ( !isdefined( self.wasinlaststand ) )
    {
        self.wasinlaststand = 0;
    }
    
    while ( riotshield::riotshield_hasweapon() )
    {
        trackriotshield_updateoffhandstowignorec4();
        
        if ( !self.inlaststand )
        {
            if ( self.wasinlaststand )
            {
                self.laststandforceback = 1;
                self.laststandforcebackendtime = gettime() + 1000;
            }
            else if ( gettime() >= self.laststandforcebackendtime )
            {
                self.laststandforceback = undefined;
                self.laststandforcebackendtime = undefined;
            }
            
            self.wasinlaststand = 0;
        }
        else
        {
            self.laststandforceback = undefined;
            self.laststandforcebackendtime = undefined;
            self.wasinlaststand = 1;
        }
        
        if ( self isonladder() )
        {
            trackriotshield_tryback();
        }
        else if ( self isinexecutionattack() )
        {
            trackriotshield_tryback();
        }
        else if ( self isinexecutionvictim() )
        {
            trackriotshield_trydetach();
        }
        else if ( self ismeatshieldvictim() )
        {
            trackriotshield_trydetach();
        }
        else if ( self isparachuting() || self isskydiving() )
        {
            trackriotshield_tryback();
        }
        else if ( self.laststandforceback )
        {
            trackriotshield_tryback();
        }
        else if ( self.onriotshieldstow_force )
        {
            if ( isnullweapon( self getheldoffhand() ) )
            {
                self.onriotshieldstow_force = undefined;
                trackriotshield_tryreset();
            }
            else
            {
                trackriotshield_tryback();
            }
        }
        else
        {
            trackriotshield_tryreset();
        }
        
        waitframe();
    }
    
    trackriotshield_tryreset();
}

// Namespace class
// Params 0
// Checksum 0x5708053c, Offset: 0x15506
// Size: 0x51
function trackriotshield_tryback()
{
    onarm = isdefined( self.riotshieldmodel );
    onback = isdefined( self.riotshieldmodelstowed );
    
    if ( !onback )
    {
        if ( onarm )
        {
            riotshield::riotshield_move( 1 );
            return;
        }
        
        riotshield::riotshield_attach( 0, riotshield::riotshield_getmodel() );
    }
}

// Namespace class
// Params 0
// Checksum 0x4b5f88ae, Offset: 0x1555f
// Size: 0x51
function trackriotshield_tryarm()
{
    onarm = isdefined( self.riotshieldmodel );
    onback = isdefined( self.riotshieldmodelstowed );
    
    if ( !onarm )
    {
        if ( onback )
        {
            riotshield::riotshield_move( 0 );
            return;
        }
        
        riotshield::riotshield_attach( 1, riotshield::riotshield_getmodel() );
    }
}

// Namespace class
// Params 0
// Checksum 0x88c2cd72, Offset: 0x155b8
// Size: 0x47
function trackriotshield_trydetach()
{
    onarm = isdefined( self.riotshieldmodel );
    onback = isdefined( self.riotshieldmodelstowed );
    
    if ( onarm )
    {
        riotshield::riotshield_detach( 1 );
    }
    
    if ( onback )
    {
        riotshield::riotshield_detach( 0 );
    }
}

// Namespace class
// Params 0
// Checksum 0x97c617b2, Offset: 0x15607
// Size: 0x7e
function trackriotshield_tryreset()
{
    if ( riotshield::riotshield_hasweapon() )
    {
        holdingshield = weapon_utility::isriotshield( self getcurrentweapon() );
        
        if ( holdingshield )
        {
            trackriotshield_tryarm();
        }
        else
        {
            trackriotshield_tryback();
        }
        
        return;
    }
    
    onarm = isdefined( self.riotshieldmodel );
    onback = isdefined( self.riotshieldmodelstowed );
    
    if ( onarm )
    {
        riotshield::riotshield_detach( 1 );
    }
    
    if ( onback )
    {
        riotshield::riotshield_detach( 0 );
    }
}

// Namespace class
// Params 1
// Checksum 0x2cb4c472, Offset: 0x1568d
// Size: 0x39
function riotshieldonweaponchange( objweapon )
{
    if ( riotshield::riotshield_hasweapon() )
    {
        thread trackriotshield_monitorshieldattach();
        return;
    }
    
    trackriotshield_tryreset();
    riotshieldclearvars();
    self notify( #"hash_f0727a24a36040ec" );
}

// Namespace class
// Params 1
// Checksum 0xfe789595, Offset: 0x156ce
// Size: 0x57
function riotshieldclearvars( fromdeath )
{
    self.laststandforceback = undefined;
    self.laststandforcebackendtime = undefined;
    self.wasinlaststand = undefined;
    
    if ( fromdeath )
    {
        self.hasriotshield = undefined;
        self.hasriotshieldequipped = undefined;
        self.riotshieldmodel = undefined;
        self.riotshieldmodelstowed = undefined;
    }
}

// Namespace class
// Params 1
// Checksum 0x75586448, Offset: 0x1572d
// Size: 0x12
function isweaponsilenced( weapon )
{
    return weapon issilenced();
}

// Namespace class
// Params 0
// Checksum 0xb921e946, Offset: 0x15748
// Size: 0xb5
function replenishloadout()
{
    team = self.pers[ "team" ];
    class = self.pers[ "class" ];
    weaponslist = self getweaponslistall();
    
    for ( idx = 0; idx < weaponslist.size ; idx++ )
    {
        weapon = weaponslist[ idx ];
        self givemaxammo( weapon );
        self setweaponammoclip( weapon, 9999 );
        weaponname = weapon.basename;
        
        if ( weaponname == "claymore_mp" || weaponname == "claymore_detonator_mp" )
        {
            self setweaponammostock( weapon, 2 );
        }
    }
}

// Namespace class
// Params 0
// Checksum 0x492088fa, Offset: 0x15805
// Size: 0x14b
function onplayerconnecting()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        /#
            player thread debug_weapons_list();
        #/
        
        player enableplayerbreathsystem( 0 );
        
        if ( !isdefined( player.pers[ "class" ] ) )
        {
            player.pers[ "class" ] = "";
        }
        
        if ( !isdefined( player.pers[ "lastClass" ] ) )
        {
            player.pers[ "lastClass" ] = "";
        }
        
        player.class = player.pers[ "class" ];
        player.lastclass = player.pers[ "lastClass" ];
        player.changedarchetypeinfo = player.pers[ "changedArchetypeInfo" ];
        player.lastarchetypeinfo = undefined;
        
        if ( !isdefined( player.pers[ "validationInfractions" ] ) )
        {
            player.pers[ "validationInfractions" ] = 0;
        }
        
        if ( !isdefined( player.pers[ #"hash_47bf97fb56ab9eaf" ] ) )
        {
            player.pers[ #"hash_47bf97fb56ab9eaf" ] = player function_a75ec559a62b1069( gettime() );
        }
    }
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xc0f81a31, Offset: 0x15958
// Size: 0x61
function private function_6f7ddd70d24c5abc( value )
{
    if ( value == 0 )
    {
        return;
    }
    
    var_dfe925d485d5eac8 = utility::getfx( "loadout_bootup_fx" );
    playfxontag( var_dfe925d485d5eac8, self, "tag_origin" );
    utility::waittill_any_in_array_or_timeout( [ "death", "disconnect" ], 2 );
    stopfxontag( var_dfe925d485d5eac8, self, "tag_origin" );
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xbe0ff290, Offset: 0x159c1
// Size: 0x8b
function private function_a75ec559a62b1069( timejoined )
{
    assert( !isdefined( self.pers[ #"hash_47bf97fb56ab9eaf" ] ) );
    var_a02ea54b9c58c35c = level.gametypebundle.var_6dcfd6e236dce97d ?? #"none";
    
    switch ( var_a02ea54b9c58c35c )
    {
        case #"frommatchstart":
            return function_211c3ed3648335a7( timejoined );
        default:
            break;
    }
    
    return #"hash_100d8b71ac0e53b1";
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x4f705858, Offset: 0x15a55
// Size: 0x94
function private function_211c3ed3648335a7( timejoined )
{
    matchstarttime = game[ "startTimeFromMatchStart" ];
    
    if ( !isdefined( matchstarttime ) )
    {
        return #"hash_b228dd3d04ec5960";
    }
    
    var_dc9adb4bfaa663e3 = ( level.gametypebundle.var_d2e2c19aa8de828 ?? 0 ) * 1000;
    overridetime = getdvarint( @"hash_caf295a2602d55f2", 0 );
    
    if ( overridetime > 0 )
    {
        var_dc9adb4bfaa663e3 = overridetime;
    }
    
    if ( timejoined > matchstarttime + var_dc9adb4bfaa663e3 )
    {
        return #"joinedlate";
    }
    
    return #"hash_7fcd94570adae599";
}

// Namespace class
// Params 0
// Checksum 0xb6dae0d4, Offset: 0x15af2
// Size: 0x28b
function onplayerspawned()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player enableplayerbreathsystem( 1 );
        player operator::setgendersoundcontext();
        
        if ( isdefined( level.gamemodebundle.var_feb4b2aad25fbaf3 ) && soundexists( level.gamemodebundle.var_feb4b2aad25fbaf3 ) )
        {
            function_4009348bd72e9021( level.gamemodebundle.var_feb4b2aad25fbaf3, player );
            
            if ( soundexists( "deaths_door_death_lsrs_02" ) )
            {
                function_4009348bd72e9021( "deaths_door_death_lsrs_02", player );
                function_4009348bd72e9021( "deaths_door_death_lsrs", player );
            }
        }
        
        if ( soundexists( "mp_rex_fuse_kill" ) )
        {
            player playlocalsound( "mp_rex_fuse_kill" );
        }
        
        if ( isdefined( level.var_4c05236cc4daf4b1 ) )
        {
            player stoplocalsound( level.var_4c05236cc4daf4b1 );
        }
        
        player clearsoundsubmix( "player_swimming_underwater", 1 );
        player clearsoundsubmix( "mp_juggernaut", 0.5 );
        player clearsoundsubmix( "iw9_mp_soccer_goal", 1 );
        player setentitysoundcontext( "atmosphere", "", 1 );
        player clearclienttriggeraudiozone( 2 );
        
        if ( isdefined( player.operatorsfx ) )
        {
            player clearsoundsubmix( "iw8_mp_spawn_camera" );
            player.operatorsfx stoploopsound( self.operatorsfxalias );
            player.operatorsfx delete();
            player.operatorsfx = undefined;
            player.operatorsfxalias = undefined;
        }
        
        if ( isdefined( player.operatorcustomization.clothtype ) && player.operatorcustomization.clothtype != "" )
        {
            player setclothtype( getxhash( player.operatorcustomization.clothtype ) );
        }
        else
        {
            player setclothtype( #"vestlight" );
        }
        
        if ( isdefined( player.operatorcustomization.geartype ) && player.operatorcustomization.geartype != "" )
        {
            player setgeartype( getxhash( player.operatorcustomization.geartype ) );
        }
        else
        {
            player setgeartype( #"millghtgr" );
        }
        
        if ( level.gametype == "dungeons" )
        {
            player execution::_giveexecution( "jup_execution_first_person_000", 1 );
        }
    }
}

// Namespace class
// Params 2
// Checksum 0xa7d3cd0f, Offset: 0x15d85
// Size: 0x2a
function fadeaway( waitdelay, fadedelay )
{
    wait waitdelay;
    self fadeovertime( fadedelay );
    self.alpha = 0;
}

// Namespace class
// Params 1
// Checksum 0xddecc130, Offset: 0x15db7
// Size: 0x17
function setclass( newclass )
{
    self.curclass = newclass;
}

// Namespace class
// Params 0
// Checksum 0x5872bb98, Offset: 0x15dd6
// Size: 0x5c, Type: bool
function haschangedclass()
{
    if ( isdefined( self.lastclass ) && self.lastclass != self.class || !isdefined( self.lastclass ) )
    {
        return true;
    }
    
    if ( game_utility::isinfectedgametype() && self.last_infected_class != self.infected_class )
    {
        return true;
    }
    
    return false;
}

// Namespace class
// Params 0
// Checksum 0x192d47d8, Offset: 0x15e3b
// Size: 0x3a, Type: bool
function haschangedarchetype()
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        if ( !isdefined( self.lastarchetypeinfo ) )
        {
            return true;
        }
        
        if ( self.changedarchetypeinfo != self.lastarchetypeinfo )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 0
// Checksum 0xc41b16fa, Offset: 0x15e7e
// Size: 0x70
function resetactionslots()
{
    self setactionslot( 1, "" );
    self setactionslot( 2, "" );
    self setactionslot( 3, "" );
    self setactionslot( 4, "" );
    
    if ( !isagent( self ) && !self isconsoleplayer() )
    {
        self setactionslot( 5, "" );
        self setactionslot( 6, "" );
        self setactionslot( 7, "" );
    }
}

// Namespace class
// Params 1
// Checksum 0xd71e992c, Offset: 0x15ef6
// Size: 0x1f0
function resetfunctionality( options )
{
    self enableequipdeployvfx( 0 );
    
    if ( !isagent( self ) )
    {
        if ( !self.ksempd )
        {
            player::hidehudclear();
        }
        else
        {
            var_fa1bab4400a2b667 = val::get_specific_id( "killstreaks", "ksEMPBlast" );
            var_759dc83cfcc8f71c = val::get_specific_id( "supers", "ksEMPBlast" );
        }
        
        vehicle_allowplayeruse( self, 1 );
        
        if ( level.minimaponbydefault || isbrgamemode() && game[ "inLiveLobby" ] )
        {
            self setclientomnvar( "ui_hide_minimap", 0 );
        }
        else
        {
            self setclientomnvar( "ui_hide_minimap", 1 );
        }
    }
    
    if ( !level.var_ddd4489f3a9d5b8f )
    {
        val::nuke_all();
    }
    
    if ( isdefined( var_fa1bab4400a2b667 ) )
    {
        val::set( "ksEMPBlast", "killstreaks", var_fa1bab4400a2b667 );
    }
    
    if ( isdefined( var_759dc83cfcc8f71c ) )
    {
        val::set( "ksEMPBlast", "supers", var_759dc83cfcc8f71c );
    }
    
    vehicle_occupancy::clear_allow_movement_player( self, 1 );
    self.doublejumpenergy = undefined;
    self.doublejumpenergyrestorerate = undefined;
    self.enabledcollisionnotifies = undefined;
    self.enabledequipdeployvfx = undefined;
    self.minimapstatetracker = undefined;
    self.isstunned = undefined;
    self.isblinded = undefined;
    self.nocorpse = undefined;
    self.prematchlook = undefined;
    damage::resetattackerlist();
    damage::clearcorpsetablefuncs();
    riotshieldclearvars();
    player_utility::cleardemeanorsafe();
    damage_effects::clearburning( 1 );
    molotov::molotov_clear_fx();
    gas_grenade::gas_clear( 1 );
    
    if ( !isagent( self ) )
    {
        snapshot::function_9f8f232c138a6f15();
    }
    
    white_phosphorus::clearloopingcoughaudio();
    
    if ( isdefined( self.callbacks[ #"hash_d9bade91bf637702" ] ) || isdefined( level.callbacks[ #"hash_d9bade91bf637702" ] ) )
    {
        callback::callback( #"hash_d9bade91bf637702", {} );
    }
    
    player::_resetenableignoreme();
    player_utility::function_278a198455b7bee6();
}

// Namespace class
// Params 0
// Checksum 0xc7797137, Offset: 0x160ee
// Size: 0x12
function clearscriptable()
{
    self setscriptablepartstate( "CompassIcon", "defaultIcon" );
}

// Namespace class
// Params 3
// Checksum 0x6695513f, Offset: 0x16108
// Size: 0x13b
function changearchetype( archetype, super, trait )
{
    if ( isdefined( self.changedarchetypeinfo ) )
    {
        var_ee0094b5ae0b3d96 = self.changedarchetypeinfo;
        
        if ( var_ee0094b5ae0b3d96.archetype == archetype && var_ee0094b5ae0b3d96.super == super && var_ee0094b5ae0b3d96.trait == trait )
        {
            return;
        }
    }
    
    changedarchetypeinfo = spawnstruct();
    changedarchetypeinfo.archetype = archetype;
    changedarchetypeinfo.super = super;
    changedarchetypeinfo.trait = trait;
    self.changedarchetypeinfo = changedarchetypeinfo;
    self.pers[ "changedArchetypeInfo" ] = changedarchetypeinfo;
    
    if ( isdefined( self.pers[ "class" ] ) && self.pers[ "class" ] != "" )
    {
        preloadandqueueclass( self.pers[ "class" ] );
        
        if ( shouldallowinstantclassswap() )
        {
            thread swaploadout();
            return;
        }
        
        if ( isalive( self ) )
        {
            self iprintlnbold( game[ "strings" ][ "change_rig" ] );
        }
    }
}

// Namespace class
// Params 2
// Checksum 0xc5ff3c42, Offset: 0x1624b
// Size: 0xac
function getattachmentloadoutstring( attachmentindex, slot )
{
    assert( isxhash( slot ) );
    
    if ( !isdefined( level.var_c884aa612a43e00d ) )
    {
        level.var_c884aa612a43e00d = [];
        level.var_c884aa612a43e00d[ #"primary" ] = "loadoutPrimaryAttachment";
        level.var_c884aa612a43e00d[ #"secondary" ] = "loadoutSecondaryAttachment";
        level.var_c884aa612a43e00d[ #"tertiary" ] = "loadoutTertiaryAttachment";
    }
    
    base = level.var_c884aa612a43e00d[ slot ];
    
    if ( attachmentindex == 0 )
    {
        return base;
    }
    
    return base + attachmentindex;
}

// Namespace class
// Params 2
// Checksum 0x551c5109, Offset: 0x16300
// Size: 0xac
function getstickerloadoutstring( stickerindex, slot )
{
    assert( isxhash( slot ) );
    
    if ( !isdefined( level.var_7207a85e2b434283 ) )
    {
        level.var_7207a85e2b434283 = [];
        level.var_7207a85e2b434283[ #"primary" ] = "loadoutPrimarySticker";
        level.var_7207a85e2b434283[ #"secondary" ] = "loadoutSecondarySticker";
        level.var_7207a85e2b434283[ #"tertiary" ] = "loadoutTertiarySticker";
    }
    
    base = level.var_7207a85e2b434283[ slot ];
    
    if ( stickerindex == 0 )
    {
        return base;
    }
    
    return base + stickerindex;
}

// Namespace class
// Params 0
// Checksum 0xdfdf5e11, Offset: 0x163b5
// Size: 0x4
function function_b6a916f16fba9df2()
{
    return 5;
}

// Namespace class
// Params 0
// Checksum 0x7754ad04, Offset: 0x163c2
// Size: 0x4
function function_9df021ae03066e()
{
    return 5;
}

// Namespace class
// Params 1
// Checksum 0x8ea81e84, Offset: 0x163cf
// Size: 0x148
function findfirststreakdifferentcost( var_390bac07f4f9b2f2 )
{
    unusedstreaks = [];
    
    foreach ( streakref, bundle in level.streakglobals.streakbundles )
    {
        if ( !bundle.var_883566fc1e9d2da3 )
        {
            continue;
        }
        
        skipstreak = 0;
        
        foreach ( slotstreak in var_390bac07f4f9b2f2 )
        {
            if ( streakref == slotstreak || killstreaks::calcstreakcost( streakref ) == killstreaks::calcstreakcost( slotstreak ) )
            {
                skipstreak = 1;
                break;
            }
        }
        
        if ( !skipstreak )
        {
            unusedstreaks[ unusedstreaks.size ] = streakref;
        }
    }
    
    return unusedstreaks[ 0 ];
}

// Namespace class
// Params 1
// Checksum 0xfd06c57e, Offset: 0x16520
// Size: 0x31
function replacewithspecialistkillstreaks( struct )
{
    return [ "specialist_perk_1", "specialist_perk_2", "specialist_perk_3", "specialist_perk_bonus" ];
}

// Namespace class
// Params 0
// Checksum 0x69385c4, Offset: 0x1655a
// Size: 0x90
function updateinstantclassswapallowed()
{
    self notify( #"hash_18f9d68da3451836" );
    self endon( #"hash_18f9d68da3451836" );
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.instantclassswapallowed = 1;
    
    if ( isbrgamemode() )
    {
        if ( gamelogic_mp::function_a054d2386f2ced38() )
        {
            flags::gameflagwait( "prematch_fade_done" );
            gamelogic_mp::function_c8f5736e0ad9354b();
            updateinstantclassswapallowedinternal();
        }
    }
    else
    {
        flags::gameflagwait( "prematch_done" );
        updateinstantclassswapallowedinternal();
    }
    
    disableclassswapallowed();
}

// Namespace class
// Params 0
// Checksum 0xf52f5406, Offset: 0x165f2
// Size: 0x52
function updateinstantclassswapallowedinternal()
{
    self endon( #"death" );
    graceperiod = game_utility_mp::ismlgmatch() ? 5 : 15;
    
    if ( isdefined( self.perks[ "specialty_tune_up" ] ) )
    {
        graceperiod = game_utility_mp::ismlgmatch() ? 5 : 5;
    }
    
    wait graceperiod;
}

// Namespace class
// Params 0
// Checksum 0x9966ff4c, Offset: 0x1664c
// Size: 0x6b
function disableclassswapallowed()
{
    if ( level.var_7501b1ce6afaa90b )
    {
        return;
    }
    
    if ( self.instantclassswapallowed )
    {
        self.instantclassswapallowed = 0;
        
        if ( game_utility_mp::isteamreviveenabled() && !game_utility_mp::ismutationgamemodezombie() )
        {
            self.revive_chosenclass = self.class;
            self.pers[ "next_round_class" ] = self.class;
        }
    }
    
    function_e441c383fc2c59c9();
}

// Namespace class
// Params 0
// Checksum 0x8fab1499, Offset: 0x166bf
// Size: 0x1d
function function_e441c383fc2c59c9()
{
    if ( !level.var_893e01501401ebc0 )
    {
        return;
    }
    
    self.var_c839f8b9780fe600 = gettime();
}

// Namespace class
// Params 1
// Checksum 0x8a014ebc, Offset: 0x166e4
// Size: 0x1c, Type: bool
function isvalidclass( class )
{
    return isdefined( class ) && !( class === "" );
}

// Namespace class
// Params 1
// Checksum 0xf499baf1, Offset: 0x16709
// Size: 0x7b
function getclassindex( classname )
{
    var_cc37d68a03792304 = menus::function_b8d426cb0b593d1();
    
    if ( var_cc37d68a03792304 >= 0 )
    {
        return var_cc37d68a03792304;
    }
    
    assert( isdefined( level.classmap[ classname ] ), "<dev string:x5a2>" + classname + "<dev string:x5bc>" );
    
    if ( !isdefined( level.classmap[ classname ] ) )
    {
        logstring( "ERROR: class::getClassIndex() - className [" + classname + "] not defined in level.classMap" );
    }
    
    return level.classmap[ classname ];
}

// Namespace class
// Params 2
// Checksum 0x27422dfd, Offset: 0x1678d
// Size: 0x55
function preloadandqueueclass( class, highpriorityload )
{
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "preloadAndQueueClass: class is " + ( class ?? "<undefined>" ) );
    struct = loadout_getorbuildclassstruct( class );
    preloadandqueueclassstruct( struct, highpriorityload );
    return struct;
}

// Namespace class
// Params 0
// Checksum 0xeeab8e91, Offset: 0x167eb
// Size: 0x3a
function savefavoriteloadout()
{
    loadoutchoice = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
    
    if ( isdefined( loadoutchoice ) )
    {
        loadoutchoice = menus::getclasschoice( loadoutchoice );
        return preloadandqueueclass( loadoutchoice );
    }
}

// Namespace class
// Params 0
// Checksum 0xe5e1f951, Offset: 0x1682e
// Size: 0x3b
function function_c076a1e54ebf636a()
{
    loadoutchoice = self getplayerdata( level.var_6f9b00680ed002d8, "favoriteLoadoutIndex" );
    
    if ( !isdefined( loadoutchoice ) )
    {
        return;
    }
    
    loadoutchoice = menus::getclasschoice( loadoutchoice );
    return loadout_getorbuildclassstruct( loadoutchoice );
}

// Namespace class
// Params 3
// Checksum 0x1fc104a1, Offset: 0x16872
// Size: 0x4e
function preloadandqueueclassstruct( classstruct, highpriorityload, var_3d108eb75be0d19a )
{
    playerassets = playerlogic::getplayerassets( classstruct );
    playerlogic::loadplayerassets( [ playerassets ], highpriorityload, var_3d108eb75be0d19a );
    self.preloadedclassstruct = classstruct;
}

// Namespace class
// Params 1
// Checksum 0xacc1b8aa, Offset: 0x168c8
// Size: 0x204
function loadout_getorbuildclassstruct( classname )
{
    if ( !isdefined( classname ) )
    {
        script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "loadout_getOrBuildClassStruct: className undefined, setting it to 'default1'" );
        classname = "default1";
        logstring( "ERROR: loadout_getOrBuildClassStruct() called with no className using default1 for player:" + self );
    }
    
    classtype = loadout_getclasstype( classname );
    cachedstruct = getcachedloadoutstruct( classname, classtype );
    
    if ( isdefined( cachedstruct ) )
    {
        if ( !isdefined( cachedstruct.loadoutprimaryobject ) && isdefined( cachedstruct.loadoutprimaryfullname ) && cachedstruct.loadoutprimaryfullname != "none" )
        {
            cachedstruct.loadoutprimaryobject = makeweaponfromstring( cachedstruct.loadoutprimaryfullname );
        }
        
        if ( !isdefined( cachedstruct.loadoutsecondaryobject ) && isdefined( cachedstruct.loadoutsecondaryfullname ) && cachedstruct.loadoutsecondaryfullname != "none" )
        {
            cachedstruct.loadoutsecondaryobject = makeweaponfromstring( cachedstruct.loadoutsecondaryfullname );
        }
        
        if ( !isdefined( cachedstruct.var_9dcef9a8722c3abb ) && isdefined( cachedstruct.var_441e64c50e9d846a ) && cachedstruct.var_441e64c50e9d846a != "none" )
        {
            cachedstruct.var_9dcef9a8722c3abb = makeweaponfromstring( cachedstruct.var_441e64c50e9d846a );
        }
    }
    
    if ( isdefined( cachedstruct ) )
    {
        if ( classname == "gamemode" )
        {
            tempstruct = loadout_getclassstruct();
            tempstruct = loadout_updateclass( tempstruct, classname );
            var_20b15d9bcd0969e3 = compareclassstructs( tempstruct, cachedstruct );
            
            if ( !var_20b15d9bcd0969e3 )
            {
                tempstruct.gamemodeforcednewloadout = 1;
                trytocacheclassstruct( tempstruct, classname, classtype );
                return tempstruct;
            }
        }
        
        return cachedstruct;
    }
    
    script::function_789a02669a1a12e9( @"hash_a423522f752bd1f6", "loadout_getOrBuildClassStruct: about to call loadout_updateClass, className is " + ( classname ?? "<undefined>" ) );
    classstruct = loadout_getclassstruct();
    classstruct = loadout_updateclass( classstruct, classname );
    trytocacheclassstruct( classstruct, classname, classtype );
    return classstruct;
}

// Namespace class
// Params 0
// Checksum 0x824fb91c, Offset: 0x16ad5
// Size: 0x2c
function loadout_getglobalclassstruct()
{
    if ( !isdefined( self.pers[ "globalLoadoutStruct" ] ) )
    {
        loadout_updateglobalclassstruct();
    }
    
    return self.pers[ "globalLoadoutStruct" ];
}

// Namespace class
// Params 0
// Checksum 0xf1f70ff5, Offset: 0x16b0a
// Size: 0xc9
function loadout_updateglobalclassstruct()
{
    struct = spawnstruct();
    struct.loadoutfieldupgrade1 = "none";
    struct.var_6dd76aa72f0c26e1 = [];
    struct.loadoutfieldupgrade2 = "none";
    struct.var_3834964fc455658e = [];
    
    if ( !isagent( self ) )
    {
        if ( !isdefined( self.loadoutfieldupgrade1 ) && getdvarint( @"t10", 0 ) )
        {
            if ( getdvar( @"hash_953b8c504c0dd6f2", "" ) == "zm_t10" )
            {
                struct.loadoutfieldupgrade1 = "super_aether_shroud";
            }
            else
            {
                struct.loadoutfieldupgrade1 = "super_trophy";
            }
        }
    }
    
    self.pers[ "globalLoadoutStruct" ] = struct;
}

// Namespace class
// Params 0
// Checksum 0x5372e735, Offset: 0x16bdb
// Size: 0x66, Type: bool
function loadout_editglobalclassstruct()
{
    var_8cdabebeb8057d49 = loadout_getglobalclassstruct();
    loadout_updateglobalclassstruct();
    var_af781e8beedff3ca = loadout_getglobalclassstruct();
    
    if ( var_8cdabebeb8057d49.loadoutfieldupgrade1 != var_af781e8beedff3ca.loadoutfieldupgrade1 )
    {
        return true;
    }
    
    if ( var_8cdabebeb8057d49.loadoutfieldupgrade2 != var_af781e8beedff3ca.loadoutfieldupgrade2 )
    {
        return true;
    }
    
    return false;
}

// Namespace class
// Params 2
// Checksum 0xe4b8dd, Offset: 0x16c4a
// Size: 0x72
function loadout_updateglobalclassgamemode( globalstruct, class )
{
    gamemodeloadout = self.pers[ "gamemodeLoadout" ];
    
    if ( isdefined( gamemodeloadout ) )
    {
        if ( isdefined( gamemodeloadout[ "loadoutFieldUpgrade1" ] ) )
        {
            globalstruct.loadoutfieldupgrade1 = gamemodeloadout[ "loadoutFieldUpgrade1" ];
        }
        
        if ( isdefined( gamemodeloadout[ "loadoutFieldUpgrade2" ] ) )
        {
            globalstruct.loadoutfieldupgrade2 = gamemodeloadout[ "loadoutFieldUpgrade2" ];
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xc5e4f23d, Offset: 0x16cc4
// Size: 0x8a, Type: bool
function loadout_editcachedclassstruct( classname )
{
    classtype = loadout_getclasstype( classname );
    cachedstruct = getcachedloadoutstruct( classname, classtype );
    
    if ( isdefined( cachedstruct ) )
    {
        tempstruct = loadout_getclassstruct();
        tempstruct = loadout_updateclass( tempstruct, classname );
        var_20b15d9bcd0969e3 = compareclassstructs( tempstruct, cachedstruct );
        
        if ( !var_20b15d9bcd0969e3 )
        {
            tempstruct.tweakedbyplayerduringmatch = 1;
            trytocacheclassstruct( tempstruct, classname, classtype );
            return true;
        }
    }
    
    return false;
}

// Namespace class
// Params 2
// Checksum 0x23cc0ed3, Offset: 0x16d57
// Size: 0xad
function getcachedloadoutstruct( classname, classtype )
{
    /#
        if ( getdvarint( @"hash_d2d81d15778565ca", 0 ) != 0 )
        {
            return;
        }
    #/
    
    switch ( classtype )
    {
        case #"hash_412d4adaf2412dc0":
        case #"hash_44e999799ff10fce":
        case #"hash_7038dec66d8275be":
            cachedloadout = self.pers[ #"classcache" ][ classname ];
            return cachedloadout;
        case #"hash_43e76e9ca2c4666":
            cachedloadout = self.pers[ #"classcache" ][ #"callback" ];
            return cachedloadout;
    }
}

// Namespace class
// Params 3
// Checksum 0x431e7264, Offset: 0x16e0d
// Size: 0x7a
function trytocacheclassstruct( classstruct, classname, classtype )
{
    switch ( classtype )
    {
        case #"hash_412d4adaf2412dc0":
        case #"hash_44e999799ff10fce":
        case #"hash_7038dec66d8275be":
            addclassstructtocache( classstruct, classname );
            break;
        case #"hash_43e76e9ca2c4666":
            addclassstructtocache( classstruct, #"callback" );
            break;
    }
}

// Namespace class
// Params 2
// Checksum 0x90f1e63c, Offset: 0x16e8f
// Size: 0x66
function addclassstructtocache( classstruct, classname )
{
    if ( !isdefined( classname ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ #"classcache" ] ) )
    {
        self.pers[ #"classcache" ] = [];
    }
    
    self.pers[ #"classcache" ][ classname ] = classstruct;
    self function_9570f571c4bb5f6d();
}

// Namespace class
// Params 1
// Checksum 0xe48e5d60, Offset: 0x16efd
// Size: 0x3b
function loadout_emptycacheofloadout( classname )
{
    if ( !isdefined( self.pers[ #"classcache" ] ) )
    {
        return;
    }
    
    self.pers[ #"classcache" ][ classname ] = undefined;
}

// Namespace class
// Params 1
// Checksum 0x9437bee1, Offset: 0x16f40
// Size: 0x99
function copyclassfornextlife( otherplayer )
{
    self setclientomnvar( "ui_loadout_copied", gettime() );
    thread _loadout_setcopyloadoutomvnaronspawn();
    loadout = undefined;
    
    if ( isdefined( otherplayer.juggcontext.prevclassstruct ) )
    {
        loadout = otherplayer.juggcontext.prevclassstruct;
    }
    else
    {
        loadout = otherplayer.classstruct;
    }
    
    self.pers[ "copiedClass" ] = loadout_copyclassstruct( loadout );
    self.pers[ "lastKiller" ] = otherplayer;
}

// Namespace class
// Params 0
// Checksum 0x5aa86d24, Offset: 0x16fe1
// Size: 0x34
function _loadout_setcopyloadoutomvnaronspawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"spawned" );
    self setclientomnvar( "ui_loadout_changed", 13 );
}

// Namespace class
// Params 2
// Checksum 0xf3e8c4b8, Offset: 0x1701d
// Size: 0x11d
function loadout_fixcopiedclassstruct( copiedstruct, classstruct )
{
    copiedstruct.loadoutsuper = classstruct.loadoutsuper;
    copiedstruct.loadoutstreaksfilled = classstruct.loadoutstreaksfilled;
    copiedstruct.loadoutstreaktype = classstruct.loadoutstreaktype;
    copiedstruct.loadoutkillstreak1 = classstruct.loadoutkillstreak1;
    copiedstruct.loadoutkillstreak2 = classstruct.loadoutkillstreak2;
    copiedstruct.loadoutkillstreak3 = classstruct.loadoutkillstreak3;
    
    if ( isdefined( self.callbacks[ #"hash_dd3af83b12238bf5" ] ) || isdefined( level.callbacks[ #"hash_dd3af83b12238bf5" ] ) )
    {
        callback::callback( #"hash_dd3af83b12238bf5", { #classstruct:classstruct, #copiedstruct:copiedstruct } );
    }
    
    copiedstruct.tweakedbyplayerduringmatch = 0;
    copiedstruct.gamemodeforcednewloadout = 0;
    copiedstruct.iscopiedclass = 1;
}

// Namespace class
// Params 4
// Checksum 0x5bf2b45d, Offset: 0x17142
// Size: 0x162
function function_8cc2758f17a3d70a( weapontype, var_d78ea6210a4218bd = 0, botloadoutphase = undefined, botdifficulty = undefined )
{
    assert( isxhash( weapontype ), "<dev string:x5be>" );
    assert( !isdefined( botdifficulty ) || isstring( botdifficulty ), "<dev string:x5da>" );
    loadouts = var_d78ea6210a4218bd ? function_4114c3434215b587( weapontype, botloadoutphase, botdifficulty ) : [];
    
    if ( loadouts.size > 0 )
    {
        return loadouts;
    }
    
    if ( isdefined( level.gametypebundle.var_14a374941dd4696c ) )
    {
        var_5dbc409c18abc66b = level.gametypebundle.var_14a374941dd4696c;
        
        foreach ( loadoutentry in var_5dbc409c18abc66b )
        {
            if ( !isdefined( loadoutentry.bundle ) )
            {
                continue;
            }
            
            if ( loadoutentry.weapon_type != weapontype )
            {
                continue;
            }
            
            loadouts[ loadouts.size ] = loadoutentry;
        }
    }
    
    return loadouts;
}

// Namespace class
// Params 3, eflags: 0x4
// Checksum 0xf5f9624c, Offset: 0x172ad
// Size: 0x30f
function private function_4114c3434215b587( weapontype, botloadoutphase, botdifficulty )
{
    loadouts = [];
    var_5dbc409c18abc66b = undefined;
    var_40a75c7d11a290dd = 0;
    var_1f11e6e321fa3fcf = weapontype;
    var_eb6c8f50380f4b66 = undefined;
    
    switch ( weapontype )
    {
        case #"hash_85c0a4f944c05150":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "casual";
            break;
        case #"hash_6cba3f258e9e37ad":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "recruit";
            break;
        case #"hash_b46b486416015f6b":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "regular";
            break;
        case #"hash_dd23114dfaf56fa2":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "hardened";
            break;
        case #"hash_b784ee1bdc3c0360":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "veteran";
            break;
        case #"hash_8098cd59cb63f1b8":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "elite";
            break;
        case #"hash_55a548ca43d305c7":
            var_1f11e6e321fa3fcf = #"bot_airdrop";
            var_eb6c8f50380f4b66 = "master";
            break;
    }
    
    if ( isdefined( var_eb6c8f50380f4b66 ) )
    {
        assert( !isdefined( botdifficulty ) || botdifficulty == var_eb6c8f50380f4b66, "<dev string:x606>" );
        botdifficulty = var_eb6c8f50380f4b66;
    }
    
    switch ( var_1f11e6e321fa3fcf )
    {
        case #"bot":
            var_5dbc409c18abc66b = level.gametypebundle.var_bffce2a9051dce8b;
            break;
        case #"bot_airdrop":
            var_5dbc409c18abc66b = level.gametypebundle.var_c464050ef1940e0d;
            break;
        default:
            var_5dbc409c18abc66b = level.gametypebundle.var_a3629e43eb48c55;
            var_40a75c7d11a290dd = 1;
            break;
    }
    
    if ( isdefined( var_5dbc409c18abc66b ) )
    {
        foreach ( loadoutentry in var_5dbc409c18abc66b )
        {
            if ( !isdefined( loadoutentry.bundle ) )
            {
                continue;
            }
            
            if ( var_40a75c7d11a290dd && loadoutentry.weapon_type != var_1f11e6e321fa3fcf )
            {
                continue;
            }
            
            if ( isdefined( botdifficulty ) && !function_42188c7814babc72( loadoutentry.bot_difficulty, botdifficulty ) )
            {
                continue;
            }
            
            if ( isdefined( botloadoutphase ) && loadoutentry.phase != botloadoutphase + 1 )
            {
                continue;
            }
            
            isvalid = function_6c4f192694cfe827( loadoutentry.bundle );
            
            if ( !isvalid )
            {
                /#
                    logstring( "<dev string:x642>" + getxhashsourcename( loadoutentry.bundle ) + "<dev string:x680>" );
                #/
                
                continue;
            }
            
            loadouts[ loadouts.size ] = loadoutentry;
        }
    }
    
    return loadouts;
}

// Namespace class
// Params 2, eflags: 0x4
// Checksum 0xb52bdc52, Offset: 0x175c5
// Size: 0xc8
function private function_42188c7814babc72( var_ef2b4a0db733a70c, botdifficulty )
{
    switch ( botdifficulty )
    {
        case #"hash_46fdaf04e9be63e4":
            return var_ef2b4a0db733a70c.casual;
        case #"hash_29f66d99d48ef101":
            return var_ef2b4a0db733a70c.recruit;
        case #"hash_284b2545dbaa82f7":
            return var_ef2b4a0db733a70c.regular;
        case #"hash_bd9217f8be6084ee":
            return var_ef2b4a0db733a70c.hardened;
        case #"hash_b66ed8ef2f4f67f4":
            return var_ef2b4a0db733a70c.veteran;
        case #"hash_7b0e2f2ed84f34":
            return var_ef2b4a0db733a70c.elite;
        case #"hash_75157a9ee3260b93":
            return var_ef2b4a0db733a70c.master;
    }
    
    return 0;
}

// Namespace class
// Params 2
// Checksum 0x8b118007, Offset: 0x17696
// Size: 0x3c
function function_28db18ee2fa5c094( weaponobj, skipfirstraise = 0 )
{
    if ( utility::shouldskipfirstraise() )
    {
        skipfirstraise = 1;
    }
    
    if ( self.wassquadspawned )
    {
        skipfirstraise = 1;
    }
    
    return skipfirstraise;
}

// Namespace class
// Params 5
// Checksum 0x7ac7dc2c, Offset: 0x176db
// Size: 0xfb
function respawnitems_saveplayeritemstostruct( saveweapons, saveequipment, savestreaks, saveperks, savesuper )
{
    respawnitems = spawnstruct();
    
    if ( !isdefined( saveweapons ) || saveweapons )
    {
        respawnitems_saveweapons( respawnitems );
    }
    
    if ( !isdefined( saveequipment ) || saveequipment )
    {
        respawnitems_saveequipmentitems( respawnitems );
    }
    
    if ( !isdefined( savestreaks ) || savestreaks )
    {
        respawnitems_savestreaks( respawnitems );
    }
    
    if ( !isdefined( saveperks ) || saveperks )
    {
        function_12140aab8fa2b533( respawnitems );
    }
    
    if ( !isdefined( savesuper ) || savesuper )
    {
        respawnitems_savesuper( respawnitems );
    }
    
    if ( isdefined( self.callbacks[ #"hash_b9fa08c48b5f7a5b" ] ) || isdefined( level.callbacks[ #"hash_b9fa08c48b5f7a5b" ] ) )
    {
        callback::callback( #"hash_b9fa08c48b5f7a5b", { #respawnitems:respawnitems } );
    }
    
    return respawnitems;
}

// Namespace class
// Params 1
// Checksum 0x3fdc4685, Offset: 0x177df
// Size: 0x17
function respawnitems_assignrespawnitems( respawnitems )
{
    self.respawnitems = respawnitems;
}

// Namespace class
// Params 0
// Checksum 0x25c739c4, Offset: 0x177fe
// Size: 0xc, Type: bool
function respawnitems_hasrespawnitems()
{
    return isdefined( self.respawnitems );
}

// Namespace class
// Params 0
// Checksum 0x49f97822, Offset: 0x17813
// Size: 0xc
function respawnitems_clear()
{
    self.respawnitems = undefined;
}

// Namespace class
// Params 1
// Checksum 0xacb763ff, Offset: 0x17827
// Size: 0x357
function respawnitems_saveweapons( respawnitems )
{
    cacweapons = [];
    currentweaponobj = self.currentweapon;
    primaryweaponobj = undefined;
    
    if ( self.var_e4646dd860ad6049.size > 0 )
    {
        cacweapons = self.var_e4646dd860ad6049;
        self.var_e4646dd860ad6049 = undefined;
        primaryweaponobj = cacweapons[ 0 ];
    }
    else
    {
        var_61ab6f371a1722fd = self.primaryweapons;
        
        foreach ( weapon in var_61ab6f371a1722fd )
        {
            if ( weapon::iscacprimaryorsecondary( weapon ) && !weapon::function_707f7162a89aa0e0( weapon ) && !weapon::isbackuppistol( weapon ) )
            {
                cacweapons[ cacweapons.size ] = weapon;
            }
        }
        
        var_edef5e03a82bc1b4 = 0;
        
        if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) )
        {
            var_edef5e03a82bc1b4 = utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" );
        }
        
        assert( cacweapons.size <= 2 || var_edef5e03a82bc1b4, "<dev string:x6a2>" );
        
        if ( isdefined( self.lastcacweaponobj ) && self hasweapon( self.lastcacweaponobj ) && ( !isdefined( self.var_cc1262e66dbb1c79 ) || self.lastcacweaponobj != self.var_cc1262e66dbb1c79 ) )
        {
            primaryweaponobj = self.lastcacweaponobj;
        }
        else if ( weapon::iscacprimaryorsecondary( self.currentweapon ) && ( !isdefined( self.var_cc1262e66dbb1c79 ) || self.currentweapon != self.var_cc1262e66dbb1c79 ) )
        {
            primaryweaponobj = self.currentweapon;
        }
        else if ( cacweapons.size > 0 )
        {
            primaryweaponobj = cacweapons[ 0 ];
        }
    }
    
    if ( isundefinedweapon( primaryweaponobj ) )
    {
        primaryweaponobj = level.defaultfist;
    }
    
    respawnitems_saveweapon( primaryweaponobj, "primary", respawnitems );
    secondaryweaponobj = undefined;
    
    foreach ( weapon in cacweapons )
    {
        if ( !issameweapon( weapon, primaryweaponobj, 1 ) )
        {
            secondaryweaponobj = weapon;
            break;
        }
    }
    
    if ( isdefined( secondaryweaponobj ) )
    {
        respawnitems_saveweapon( secondaryweaponobj, "secondary", respawnitems );
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        var_cc1262e66dbb1c79 = self.var_cc1262e66dbb1c79;
        
        if ( isdefined( var_cc1262e66dbb1c79 ) )
        {
            respawnitems_saveweapon( var_cc1262e66dbb1c79, "tertiary", respawnitems );
            
            if ( self.lastcacweaponobj == self.var_cc1262e66dbb1c79 )
            {
                self.var_fde03100c88f699e = self.var_cc1262e66dbb1c79;
            }
        }
    }
    
    if ( isdefined( self.var_fde03100c88f699e ) )
    {
        function_940dd48f04da8191( self.var_fde03100c88f699e, respawnitems );
        self.var_fde03100c88f699e = undefined;
    }
    
    /#
        function_6bef751891dad439( respawnitems );
    #/
}

// Namespace class
// Params 3
// Checksum 0x921058ba, Offset: 0x17b86
// Size: 0xe5
function respawnitems_saveweapon( weaponobj, weaponslot, respawnitems )
{
    if ( !isdefined( respawnitems.weapons ) )
    {
        respawnitems.weapons = [];
    }
    
    weaponinfo = spawnstruct();
    respawnitems.weapons[ weaponslot ] = weaponinfo;
    weaponinfo.weaponobj = weaponobj;
    weaponinfo.rarity = item_weapon::function_fb81bd2fe070faa6( weaponobj );
    weaponinfo.clipammo = self getweaponammoclip( weaponobj );
    weaponinfo.stockammo = self getweaponammostock( weaponobj );
    
    if ( weaponobj.hasalternate )
    {
        weaponaltobj = weaponobj getaltweapon();
        weaponinfo.altclipammo = self getweaponammoclip( weaponaltobj );
        weaponinfo.altstockammo = self getweaponammostock( weaponaltobj );
    }
}

/#

    // Namespace class
    // Params 1
    // Checksum 0x744dd3a1, Offset: 0x17c73
    // Size: 0xfb, Type: dev
    function function_6bef751891dad439( respawnitems )
    {
        if ( !isdefined( respawnitems.weapons ) )
        {
            return;
        }
        
        assert( isdefined( respawnitems.weapons[ "<dev string:x6ef>" ].weaponobj ) && isdefined( respawnitems.weapons[ "<dev string:x6ef>" ].clipammo ) && isdefined( respawnitems.weapons[ "<dev string:x6ef>" ].stockammo ) );
        assert( !isdefined( respawnitems.weapons[ "<dev string:x6f7>" ] ) || isdefined( respawnitems.weapons[ "<dev string:x6f7>" ].weaponobj ) && isdefined( respawnitems.weapons[ "<dev string:x6f7>" ].clipammo ) && isdefined( respawnitems.weapons[ "<dev string:x6f7>" ].stockammo ) );
    }

#/

// Namespace class
// Params 2, eflags: 0x4
// Checksum 0x871b4fa5, Offset: 0x17d76
// Size: 0x23
function private function_940dd48f04da8191( weaponobj, respawnitems )
{
    respawnitems.var_41d13e18c1ef3371 = weaponobj;
}

// Namespace class
// Params 1
// Checksum 0xba119b58, Offset: 0x17da1
// Size: 0x34
function respawnitems_saveequipmentitems( respawnitems )
{
    respawnitems_saveequipment( "primary", respawnitems );
    respawnitems_saveequipment( "secondary", respawnitems );
    
    /#
        function_24f191684a12b247( respawnitems );
    #/
}

// Namespace class
// Params 2
// Checksum 0xebfafb4a, Offset: 0x17ddd
// Size: 0xb4
function respawnitems_saveequipment( slot, respawnitems )
{
    itemref = equipment_mp::getcurrentequipment( slot );
    
    if ( !isdefined( itemref ) )
    {
        itemref = "none";
    }
    
    if ( !isdefined( respawnitems.equipment ) )
    {
        respawnitems.equipment = [];
    }
    
    equipmentinfo = spawnstruct();
    respawnitems.equipment[ slot ] = equipmentinfo;
    equipmentinfo.item = itemref;
    
    if ( itemref != "none" )
    {
        equipmentinfo.ammo = equipment_mp::getequipmentammo( equipmentinfo.item );
        return;
    }
    
    equipmentinfo.ammo = 0;
}

/#

    // Namespace class
    // Params 1
    // Checksum 0xfa2b70a7, Offset: 0x17e99
    // Size: 0xd4, Type: dev
    function function_24f191684a12b247( respawnitems )
    {
        if ( !isdefined( respawnitems.equipment ) )
        {
            return;
        }
        
        assert( !isdefined( respawnitems.equipment[ "<dev string:x6ef>" ] ) || isdefined( respawnitems.equipment[ "<dev string:x6ef>" ].item ) && isdefined( respawnitems.equipment[ "<dev string:x6ef>" ].ammo ) );
        assert( !isdefined( respawnitems.equipment[ "<dev string:x6f7>" ] ) || isdefined( respawnitems.equipment[ "<dev string:x6f7>" ].item ) && isdefined( respawnitems.equipment[ "<dev string:x6f7>" ].ammo ) );
    }

#/

// Namespace class
// Params 1
// Checksum 0xbeedca73, Offset: 0x17f75
// Size: 0x11d
function respawnitems_savestreaks( respawnitems )
{
    streakstate = spawnstruct();
    streakstate.streaks = [];
    streakstate.streakpoints = self.streakpoints;
    
    if ( !isdefined( self.streakpoints ) )
    {
        return;
    }
    
    streakinfo = killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( streakinfo ) )
    {
        streakstate.streaks[ streakstate.streaks.size ] = streakinfo.streakname;
    }
    
    streakinfo = killstreaks::getkillstreakinslot( 2 );
    
    if ( isdefined( streakinfo ) )
    {
        streakstate.streaks[ streakstate.streaks.size ] = streakinfo.streakname;
    }
    
    streakinfo = killstreaks::getkillstreakinslot( 3 );
    
    if ( isdefined( streakinfo ) )
    {
        streakstate.streaks[ streakstate.streaks.size ] = streakinfo.streakname;
    }
    
    if ( streakstate.streaks.size <= 0 )
    {
        return;
    }
    
    respawnitems.streakstate = streakstate;
    
    /#
        function_5b46a6a9f2286d73( respawnitems );
    #/
}

/#

    // Namespace class
    // Params 1
    // Checksum 0x721ffc93, Offset: 0x1809a
    // Size: 0x78, Type: dev
    function function_5b46a6a9f2286d73( respawnitems )
    {
        if ( !isdefined( respawnitems.streakstate ) )
        {
            return;
        }
        
        assert( isdefined( respawnitems.streakstate.streakpoints ) );
        assert( isdefined( respawnitems.streakstate.streaks ) && respawnitems.streakstate.streaks.size > 0 );
    }

#/

// Namespace class
// Params 1
// Checksum 0x631f6877, Offset: 0x1811a
// Size: 0xb7
function function_12140aab8fa2b533( respawnitems )
{
    perkstate = spawnstruct();
    respawnitems.perkstate = perkstate;
    perkstate.loadoutperks = self.loadoutperks;
    perkstate.loadoutstandardperks = self.pers[ "loadoutStandardPerks" ];
    perkstate.loadoutextraperks = self.pers[ "loadoutExtraPerks" ];
    perkstate.loadoutrigtrait = self.pers[ "loadoutRigTrait" ];
    perkstate.loadoutusingspecialist = self.pers[ "loadoutUsingSpecialist" ];
    
    /#
        function_5ee66f4e2b389af5( respawnitems );
    #/
}

/#

    // Namespace class
    // Params 1
    // Checksum 0x52c5351f, Offset: 0x181d9
    // Size: 0x153, Type: dev
    function function_5ee66f4e2b389af5( respawnitems )
    {
        if ( !isdefined( respawnitems.perkstate ) )
        {
            return;
        }
        
        if ( br_instance_inventory::function_926a8f8643d34690() && getdvarint( @"hash_48587f2cfa448879", 1 ) == 1 )
        {
            return;
        }
        
        if ( common_instance_inventory::isenabled() )
        {
            return;
        }
        
        /#
            if ( common_instance_inventory::devenabled() )
            {
                return;
            }
        #/
        
        assert( isdefined( respawnitems.perkstate.loadoutperks ) );
        assert( isdefined( respawnitems.perkstate.loadoutstandardperks ) );
        assert( isdefined( respawnitems.perkstate.loadoutextraperks ) );
        assert( isdefined( respawnitems.perkstate.loadoutrigtrait ) );
        assert( isdefined( respawnitems.perkstate.loadoutusingspecialist ) );
        
        if ( level.useperkpackage )
        {
            assert( isdefined( respawnitems.perkstate.perkpackageprogress ) );
            assert( isdefined( respawnitems.perkstate.perkpackagetier2earned ) );
            assert( isdefined( respawnitems.perkstate.perkpackagetier3state ) );
        }
    }

#/

// Namespace class
// Params 1
// Checksum 0x521e3b08, Offset: 0x18334
// Size: 0xc9
function respawnitems_savesuper( respawnitems )
{
    superref = supers_mp::getcurrentsuperref();
    
    if ( !isdefined( superref ) )
    {
        return;
    }
    
    superstate = spawnstruct();
    respawnitems.superstate = superstate;
    superstate.super = superref;
    superstate.superpoints = supers_mp::getcurrentsuperbasepoints();
    superstate.extrapoints = supers_mp::getcurrentsuperextrapoints();
    
    if ( superref == "super_select" )
    {
        currentsuper = supers_mp::getcurrentsuper();
        superstate.firstupgrade = currentsuper.firstupgrade;
        superstate.secondupgrade = currentsuper.secondupgrade;
    }
    
    /#
        function_cfea2ebf86641f94( respawnitems );
    #/
}

/#

    // Namespace class
    // Params 1
    // Checksum 0x8ee16469, Offset: 0x18405
    // Size: 0xd4, Type: dev
    function function_cfea2ebf86641f94( respawnitems )
    {
        if ( !isdefined( respawnitems.superstate ) )
        {
            return;
        }
        
        assert( isdefined( respawnitems.superstate.super ) );
        assert( isdefined( respawnitems.superstate.superpoints ) );
        assert( isdefined( respawnitems.superstate.extrapoints ) );
        
        if ( respawnitems.superstate.super == "<dev string:x701>" )
        {
            assert( isdefined( respawnitems.superstate.firstupgrade ) );
            assert( isdefined( respawnitems.superstate.secondupgrade ) );
        }
    }

#/

// Namespace class
// Params 1
// Checksum 0x185ef4d8, Offset: 0x184e1
// Size: 0x18, Type: bool
function respawnitems_hasweapondata( respawnitems )
{
    return isdefined( respawnitems.weapons );
}

// Namespace class
// Params 2
// Checksum 0xe1212d34, Offset: 0x18502
// Size: 0x2d
function respawnitems_getweaponobj( respawnitems, weaponslot )
{
    return respawnitems.weapons[ weaponslot ].weaponobj;
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x9466c983, Offset: 0x18538
// Size: 0x17
function private function_f7f9eef02d1e3c60( respawnitems )
{
    return respawnitems.var_41d13e18c1ef3371;
}

// Namespace class
// Params 2
// Checksum 0x2671fe6b, Offset: 0x18558
// Size: 0x2d
function function_683e659a77d1a2d6( respawnitems, weaponslot )
{
    return respawnitems.weapons[ weaponslot ].rarity;
}

// Namespace class
// Params 2
// Checksum 0xf698f887, Offset: 0x1858e
// Size: 0xdb
function respawnitems_giveweaponammo( respawnitems, weaponslot )
{
    weaponinfo = respawnitems.weapons[ weaponslot ];
    
    if ( !isdefined( weaponinfo ) )
    {
        return;
    }
    
    self setweaponammoclip( weaponinfo.weaponobj, weaponinfo.clipammo );
    
    if ( !weapon::function_33e74163843b348e( weaponinfo.weaponobj ) )
    {
        self setweaponammostock( weaponinfo.weaponobj, weaponinfo.stockammo );
        
        if ( weaponinfo.weaponobj.hasalternate )
        {
            weaponaltobj = weaponinfo.weaponobj getaltweapon();
            self setweaponammoclip( weaponaltobj, weaponinfo.altclipammo );
            self setweaponammostock( weaponaltobj, weaponinfo.altstockammo );
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xa89ebcb9, Offset: 0x18671
// Size: 0x21, Type: bool
function respawnitems_hasequipmentdata( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return false;
    }
    
    return isdefined( respawnitems.equipment );
}

// Namespace class
// Params 2
// Checksum 0x36ef855, Offset: 0x1869b
// Size: 0x2d
function respawnitems_getequipmentref( respawnitems, slot )
{
    return respawnitems.equipment[ slot ].item;
}

// Namespace class
// Params 2
// Checksum 0x36979f6b, Offset: 0x186d1
// Size: 0x132
function respawnitems_giveequipmentammo( respawnitems, slot )
{
    item = respawnitems_getequipmentref( respawnitems, slot );
    
    if ( !isdefined( item ) || item == "none" )
    {
        return;
    }
    
    ammo = respawnitems.equipment[ slot ].ammo;
    
    if ( !isdefined( ammo ) )
    {
        return;
    }
    
    equipment_mp::setequipmentammo( item, ammo );
    equipbundle = equipment_mp::function_c90a9aa89b223dd7( item );
    
    if ( supers_mp::function_fe4678cde55a525d() && slot == "secondary" && equipbundle.issuper )
    {
        superslot = #"tactical";
        superinfo = supers_mp::getcurrentsuper( superslot );
        assert( equipbundle.superref == superinfo.staticdata.ref, "<dev string:x70e>" );
        ammo = equipment_mp::getequipmentslotammo( slot );
        maxammo = equipment_mp::getequipmentmaxammo( item, undefined );
        
        if ( ammo < maxammo )
        {
            supers_mp::setsuperbasepoints( 0, 1, #"tactical" );
        }
    }
}

// Namespace class
// Params 1
// Checksum 0xccb7a53b, Offset: 0x1880b
// Size: 0x21, Type: bool
function respawnitems_hasstreakdata( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return false;
    }
    
    return isdefined( respawnitems.streakstate );
}

// Namespace class
// Params 1
// Checksum 0x4c05210c, Offset: 0x18835
// Size: 0x21
function respawnitems_getstreakpoints( respawnitems )
{
    return respawnitems.streakstate.streakpoints;
}

// Namespace class
// Params 1
// Checksum 0x3d30b689, Offset: 0x1885f
// Size: 0x21
function respawnitems_getstreaks( respawnitems )
{
    return respawnitems.streakstate.streaks;
}

// Namespace class
// Params 1
// Checksum 0xa11e2801, Offset: 0x18889
// Size: 0x21, Type: bool
function function_5cc13631b3b7a959( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return false;
    }
    
    return isdefined( respawnitems.perkstate );
}

// Namespace class
// Params 1
// Checksum 0xe74411b9, Offset: 0x188b3
// Size: 0x21
function respawnitems_getloadoutperks( respawnitems )
{
    return respawnitems.perkstate.loadoutperks;
}

// Namespace class
// Params 1
// Checksum 0x44f860a7, Offset: 0x188dd
// Size: 0x21
function function_cd87144240a5924f( respawnitems )
{
    return respawnitems.perkstate.loadoutstandardperks;
}

// Namespace class
// Params 1
// Checksum 0x6390148d, Offset: 0x18907
// Size: 0x21
function function_121fb7f84c56afc( respawnitems )
{
    return respawnitems.perkstate.loadoutextraperks;
}

// Namespace class
// Params 1
// Checksum 0x6225adb1, Offset: 0x18931
// Size: 0x21
function function_b9fbba2ba3adc6a1( respawnitems )
{
    return respawnitems.perkstate.loadoutrigtrait;
}

// Namespace class
// Params 1
// Checksum 0x1441155e, Offset: 0x1895b
// Size: 0x21
function function_1e64ef461f21688c( respawnitems )
{
    return respawnitems.perkstate.loadoutusingspecialist;
}

// Namespace class
// Params 1
// Checksum 0xa9dcfdb, Offset: 0x18985
// Size: 0x21
function function_9ce5f1ee71334fa4( respawnitems )
{
    return respawnitems.perkstate.perkpackageprogress;
}

// Namespace class
// Params 1
// Checksum 0xfaf1ac1, Offset: 0x189af
// Size: 0x21
function function_72114a8c0e95dc0c( respawnitems )
{
    return respawnitems.perkstate.perkpackagetier2earned;
}

// Namespace class
// Params 1
// Checksum 0x9083c6f0, Offset: 0x189d9
// Size: 0x21
function function_5f65ebd2483620ed( respawnitems )
{
    return respawnitems.perkstate.perkpackagetier3state;
}

// Namespace class
// Params 1
// Checksum 0xf79089d9, Offset: 0x18a03
// Size: 0x21, Type: bool
function respawnitems_hassuperdata( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return false;
    }
    
    return isdefined( respawnitems.superstate );
}

// Namespace class
// Params 1
// Checksum 0xd232c3c2, Offset: 0x18a2d
// Size: 0x21
function respawnitems_getsuperref( respawnitems )
{
    return respawnitems.superstate.super;
}

// Namespace class
// Params 1
// Checksum 0x8453eeef, Offset: 0x18a57
// Size: 0x21
function respawnitems_getsuperpoints( respawnitems )
{
    return respawnitems.superstate.superpoints;
}

// Namespace class
// Params 1
// Checksum 0x9ff1559e, Offset: 0x18a81
// Size: 0x21
function respawnitems_getsuperextrapoints( respawnitems )
{
    return respawnitems.superstate.extrapoints;
}

// Namespace class
// Params 1
// Checksum 0x17c2046b, Offset: 0x18aab
// Size: 0xbb
function respawnitems_getsuperfieldupgrades( respawnitems )
{
    player = self;
    superref = respawnitems_getsuperref( respawnitems );
    
    if ( !isdefined( superref ) )
    {
        script::demoforcesre( "respawnItems_getSuperFieldUpgrades does not have proper super ref for: " + ( player getplayerunoid() ?? "" ) + " " + gettime() );
        return [ "none", "none" ];
    }
    
    if ( superref == "super_select" )
    {
        return [ respawnitems.superstate.firstupgrade, respawnitems.superstate.secondupgrade ];
    }
    
    return [ superref, "none" ];
}

// Namespace class
// Params 3
// Checksum 0xd4a4b29e, Offset: 0x18b6f
// Size: 0x15d
function spawnammocountoverride_giveweaponammo( weaponobj, weaponslot, var_f00d4da234cdf6e7 )
{
    weaponinfo = weaponobj;
    noammo = !var_f00d4da234cdf6e7;
    
    if ( noammo && !ismeleeweapon( weaponobj ) )
    {
        clipsize = 0;
        reserveammo = 0;
        
        if ( weaponobj.isdualwield )
        {
            self setweaponammoclip( weaponinfo, clipsize, "left" );
        }
    }
    else
    {
        clipsize = weaponinfo.clipsize;
        reserveammo = var_f00d4da234cdf6e7 - 1;
    }
    
    if ( var_f00d4da234cdf6e7 == 7 )
    {
        reserveammo = weaponmaxammo( weaponinfo );
    }
    else if ( issubstr( weaponinfo.basename, "iw8_sh_charlie725" ) && !noammo )
    {
        reserveammo = weaponinfo.clipsize * reserveammo + 18;
    }
    else
    {
        reserveammo = weaponinfo.clipsize * reserveammo;
    }
    
    self setweaponammoclip( weaponinfo, clipsize );
    self setweaponammostock( weaponinfo, reserveammo );
    
    if ( weaponobj.hasalternate )
    {
        weaponaltobj = weaponobj getaltweapon();
        
        if ( noammo )
        {
            altclipammo = 0;
            altstockammo = 0;
        }
        else
        {
            altclipammo = self getweaponammoclip( weaponaltobj );
            altstockammo = self getweaponammostock( weaponaltobj );
        }
        
        self setweaponammoclip( weaponaltobj, altclipammo );
        self setweaponammostock( weaponaltobj, altstockammo );
    }
}

// Namespace class
// Params 1
// Checksum 0x3c2ecc6b, Offset: 0x18cd4
// Size: 0x2c, Type: bool
function ismeleeweapon( objweapon )
{
    return level.ismeleeweapon[ objweapon.basenamehash ] ?? function_bb70cf14cd5f9c64( objweapon );
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x79b41dcc, Offset: 0x18d09
// Size: 0x5b
function private function_bb70cf14cd5f9c64( objweapon )
{
    ismeleeweapon = weapon_utility::isknifeonly( objweapon.basename ) || weapon::function_e93a21a657377115( objweapon ) || weapon_utility::isriotshield( objweapon );
    level.ismeleeweapon[ objweapon.basenamehash ] = ismeleeweapon;
    return ismeleeweapon;
}

// Namespace class
// Params 2
// Checksum 0x4a51b504, Offset: 0x18d6d
// Size: 0x711, Type: bool
function compareclassstructs( classa, classb )
{
    if ( classa.loadoutarchetype != classb.loadoutarchetype )
    {
        return false;
    }
    
    if ( classa.loadoutprimary != classb.loadoutprimary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutprimaryattachments, classb.loadoutprimaryattachments ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutprimaryattachmentids, classb.loadoutprimaryattachmentids ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_277379f78fc833f4, classb.var_277379f78fc833f4 ) )
    {
        return false;
    }
    
    if ( classa.loadoutprimarycamo != classb.loadoutprimarycamo )
    {
        return false;
    }
    
    if ( classa.loadoutprimaryreticle != classb.loadoutprimaryreticle )
    {
        return false;
    }
    
    if ( classa.loadoutprimarylootitemid != classb.loadoutprimarylootitemid )
    {
        return false;
    }
    
    if ( classa.loadoutprimaryvariantid != classb.loadoutprimaryvariantid )
    {
        return false;
    }
    
    if ( classa.loadoutprimarycosmeticattachment != classb.loadoutprimarycosmeticattachment )
    {
        return false;
    }
    
    if ( classa.loadoutsecondary != classb.loadoutsecondary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutsecondaryattachments, classb.loadoutsecondaryattachments ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutsecondaryattachmentids, classb.loadoutsecondaryattachmentids ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_b93fbd33bb0d0a2c, classb.var_b93fbd33bb0d0a2c ) )
    {
        return false;
    }
    
    if ( classa.loadoutsecondarycamo != classb.loadoutsecondarycamo )
    {
        return false;
    }
    
    if ( classa.loadoutsecondaryreticle != classb.loadoutsecondaryreticle )
    {
        return false;
    }
    
    if ( classa.loadoutsecondarylootitemid != classb.loadoutsecondarylootitemid )
    {
        return false;
    }
    
    if ( classa.loadoutsecondaryvariantid != classb.loadoutsecondaryvariantid )
    {
        return false;
    }
    
    if ( classa.loadoutsecondarycosmeticattachment != classb.loadoutsecondarycosmeticattachment )
    {
        return false;
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        if ( !checkclassstructarray( classa.var_c6ea1bb7cfd9e16e, classb.var_c6ea1bb7cfd9e16e ) )
        {
            return false;
        }
        
        if ( !checkclassstructarray( classa.var_d957b896dcfa75ed, classb.var_d957b896dcfa75ed ) )
        {
            return false;
        }
        
        if ( !checkclassstructarray( classa.var_50da18834547334c, classb.var_50da18834547334c ) )
        {
            return false;
        }
        
        if ( classa.loadouttertiarycamo != classb.loadouttertiarycamo )
        {
            return false;
        }
        
        if ( classa.loadouttertiaryreticle != classb.loadouttertiaryreticle )
        {
            return false;
        }
        
        if ( classa.var_ed9b3d4420e4e620 != classb.var_ed9b3d4420e4e620 )
        {
            return false;
        }
        
        if ( classa.loadouttertiaryvariantid != classb.loadouttertiaryvariantid )
        {
            return false;
        }
        
        if ( classa.var_c3c185cb12ccad46 != classb.var_c3c185cb12ccad46 )
        {
            return false;
        }
    }
    
    if ( !checkclassstructarray( classa.loadoutperks, classb.loadoutperks ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutstandardperks, classb.loadoutstandardperks ) )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.loadoutextraperks, classb.loadoutextraperks ) )
    {
        return false;
    }
    
    if ( classa.loadoutusingspecialist != classb.loadoutusingspecialist )
    {
        return false;
    }
    
    if ( classa.loadoutmeleeslot != classb.loadoutmeleeslot )
    {
        return false;
    }
    
    if ( classa.loadoutperksfromgamemode != classb.loadoutperksfromgamemode )
    {
        return false;
    }
    
    if ( classa.loadoutrigtrait != classb.loadoutrigtrait )
    {
        return false;
    }
    
    if ( classa.loadoutequipmentprimary != classb.loadoutequipmentprimary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_cedaf611f3c02546, classb.var_cedaf611f3c02546 ) )
    {
        return false;
    }
    
    if ( classa.var_a1191d5606e653f0 != classb.var_a1191d5606e653f0 )
    {
        return false;
    }
    
    if ( classa.loadoutextraequipmentprimary != classb.loadoutextraequipmentprimary )
    {
        return false;
    }
    
    if ( classa.loadoutequipmentsecondary != classb.loadoutequipmentsecondary )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_7a0c0f1f8552f73e, classb.var_7a0c0f1f8552f73e ) )
    {
        return false;
    }
    
    if ( classa.var_9481e959139fe88 != classb.var_9481e959139fe88 )
    {
        return false;
    }
    
    if ( classa.loadoutextraequipmentsecondary != classb.loadoutextraequipmentsecondary )
    {
        return false;
    }
    
    if ( level.var_613ba3e28ca2d235 )
    {
        if ( classa.loadoutEquipmentTertiary != classb.loadoutEquipmentTertiary )
        {
            return false;
        }
        
        if ( !checkclassstructarray( classa.var_b32cdcb41c22f1be, classb.var_b32cdcb41c22f1be ) )
        {
            return false;
        }
        
        if ( classa.var_324b19b627387508 != classb.var_324b19b627387508 )
        {
            return false;
        }
        
        if ( classa.loadoutExtraEquipmentTertiary != classb.loadoutExtraEquipmentTertiary )
        {
            return false;
        }
    }
    
    if ( classa.loadoutfieldupgrade1 != classb.loadoutfieldupgrade1 )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_6dd76aa72f0c26e1, classb.var_6dd76aa72f0c26e1 ) )
    {
        return false;
    }
    
    if ( classa.loadoutfieldupgrade2 != classb.loadoutfieldupgrade2 )
    {
        return false;
    }
    
    if ( !checkclassstructarray( classa.var_3834964fc455658e, classb.var_3834964fc455658e ) )
    {
        return false;
    }
    
    if ( classa.loadoutgesture != classb.loadoutgesture )
    {
        return false;
    }
    
    if ( classa.loadoutstreaksfilled != classb.loadoutstreaksfilled )
    {
        return false;
    }
    
    if ( classa.loadoutstreaktype != classb.loadoutstreaktype )
    {
        return false;
    }
    
    if ( classa.loadoutkillstreak1 != classb.loadoutkillstreak1 )
    {
        return false;
    }
    
    if ( classa.loadoutkillstreak2 != classb.loadoutkillstreak2 )
    {
        return false;
    }
    
    if ( classa.loadoutkillstreak3 != classb.loadoutkillstreak3 )
    {
        return false;
    }
    
    if ( isdefined( level.callbacks[ #"hash_efd1801a62921f1c" ] ) || isdefined( level.callbacks[ #"hash_efd1801a62921f1c" ] ) )
    {
        if ( callback::response( 1, #"hash_efd1801a62921f1c", { #classb:classb, #classa:classa } ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace class
// Params 2
// Checksum 0x116f65fc, Offset: 0x19487
// Size: 0xa3, Type: bool
function checkclassstructarray( arraya, arrayb )
{
    if ( arraya.size != arrayb.size )
    {
        return false;
    }
    
    foreach ( key, value in arraya )
    {
        if ( !isdefined( arrayb[ key ] ) )
        {
            return false;
        }
        
        if ( arrayb[ key ] != value )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace class
// Params 0
// Checksum 0x225d371, Offset: 0x19533
// Size: 0x32
function blockclasschange()
{
    utility::ent_flag_init( "swapLoadout_blocked" );
    utility::ent_flag_init( "swapLoadout_pending" );
    utility::ent_flag_init( "swapLoadout_complete" );
    utility::ent_flag_set( "swapLoadout_blocked" );
}

// Namespace class
// Params 0
// Checksum 0x406ba68b, Offset: 0x1956d
// Size: 0x37
function unblockclasschange()
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::ent_flag_exist( "swapLoadout_blocked" ) && utility::ent_flag( "swapLoadout_blocked" ) )
    {
        utility::ent_flag_clear( "swapLoadout_blocked" );
    }
}

// Namespace class
// Params 0
// Checksum 0x35013724, Offset: 0x195ac
// Size: 0xff
function setthirdpersonview()
{
    if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
    {
        self setcamerathirdperson( 0 );
        thread restoregameplaythirdperson();
        return;
    }
    
    if ( self.perkthirdperson )
    {
        self setcamerathirdperson( 1 );
        return;
    }
    
    if ( self.liveragdoll )
    {
        self setcamerathirdperson( 1 );
        return;
    }
    
    switch ( level.thirdpersonmode )
    {
        case 1:
            self setcamerathirdperson( 1 );
            break;
        case 2:
            self setcamerathirdperson( self.team == "allies" );
            break;
        case 3:
            self setcamerathirdperson( self.team == "axis" );
            break;
        default:
            if ( !level.var_c57ff57d8b66d391 || self.var_7bbad00825f3c09a )
            {
                self setcamerathirdperson( 0 );
            }
            
            break;
    }
}

// Namespace class
// Params 0
// Checksum 0x4e9bcbe9, Offset: 0x196b3
// Size: 0x39
function restoregameplaythirdperson()
{
    self endon( #"death_or_disconnect" );
    self notify( #"restoregameplaythirdperson" );
    self endon( #"restoregameplaythirdperson" );
    flags::gameflagwait( "prematch_done" );
    setthirdpersonview();
}

// Namespace class
// Params 0
// Checksum 0xe993aac, Offset: 0x196f4
// Size: 0x7
function alwaysgamemodeclass()
{
    return "gamemode";
}

// Namespace class
// Params 0
// Checksum 0xf8cebbcb, Offset: 0x19704
// Size: 0x7f
function function_e84a99f0f4904c66()
{
    self setclientomnvar( "ui_skip_loadout", 1 );
    self.pers[ "class" ] = "gamemode";
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    
    if ( isbot( self ) )
    {
        self.classcallback = "gamemode";
    }
}

// Namespace class
// Params 1
// Checksum 0xdd534265, Offset: 0x1978b
// Size: 0xf3
function function_76cc2e656d714f53( var_eae4d92546b1a00a )
{
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    
    while ( !isdefined( self.team ) )
    {
        waitframe();
    }
    
    while ( !isdefined( team_utility::getotherteam( self.team ) ) )
    {
        waitframe();
    }
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    waitframe();
    
    switch ( var_eae4d92546b1a00a )
    {
        case 2:
            outline::outlineenableforteam( self, self.team, "jup_teammate_outline", "lowest" );
            break;
        case 1:
            outline::outlineenableforteam( self, self.team, "jup_teammate_outline_beforetrans", "lowest" );
            break;
        case 3:
            outline::outlineenableforteam( self, self.team, "jup_teammate_outline_nodistance", "lowest" );
            break;
        default:
            break;
    }
}

// Namespace class
// Params 1
// Checksum 0x7faa7211, Offset: 0x19886
// Size: 0x15f
function function_6f4d2fd6c46e696b( enableenemyoutlines )
{
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    
    while ( !isdefined( self.team ) )
    {
        waitframe();
    }
    
    while ( !isdefined( team_utility::getenemyteams( self.team ) ) )
    {
        waitframe();
    }
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    otherteams = team_utility::getenemyteams( self.team );
    
    foreach ( team in otherteams )
    {
        switch ( enableenemyoutlines )
        {
            case 1:
                outline::outlineenableforteam( self, team, "jup_enemy_outline", "lowest" );
                break;
            case 2:
                outline::outlineenableforteam( self, team, "jup_enemy_outline_beforetrans", "lowest" );
                break;
            case 3:
                outline::outlineenableforteam( self, team, "jup_enemy_outline_nodistance", "lowest" );
                break;
            default:
                break;
        }
    }
}

// Namespace class
// Params 0
// Checksum 0x9b04ca67, Offset: 0x199ed
// Size: 0x171
function monitorstowedriotshieldspeed()
{
    self endon( #"death_or_disconnect" );
    self endon( #"game_ended" );
    self notify( #"monitorstowedriotshieldspeed" );
    self endon( #"monitorstowedriotshieldspeed" );
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        waitframe();
        
        if ( self.isjuggernaut || self.isjuggernautrecon )
        {
            continue;
        }
        
        self.stowedriotshield = 0;
        
        if ( isdefined( self.weaponlist ) )
        {
            foreach ( weap in self.weaponlist )
            {
                if ( weap == self.currentprimaryweapon && issubstr( weap.basename, "riotshield" ) )
                {
                    continue;
                }
                
                if ( issubstr( weap.basename, "riotshield" ) )
                {
                    var_a443d49a36de8e0f = getdvarfloat( @"hash_ed3656881cc512d9", 0.9 );
                    self setmovespeedscale( var_a443d49a36de8e0f );
                    self.stowedriotshield = 1;
                }
            }
        }
        
        if ( !self.stowedriotshield )
        {
            self setmovespeedscale( 1 );
        }
        
        waitframe();
    }
}

// Namespace class
// Params 0
// Checksum 0x237b7120, Offset: 0x19b66
// Size: 0x32, Type: bool
function function_d31c1081fbeb777b()
{
    return isdefined( level.var_a912a3e22d337a23 ) && level.var_a912a3e22d337a23 != "" && level.var_a912a3e22d337a23 != "none";
}

// Namespace class
// Params 1
// Checksum 0x647cd070, Offset: 0x19ba1
// Size: 0x10f
function function_abb528f0a5d311e0( player )
{
    usingpistol = 0;
    var_c8ddd6411f7aed02 = 0;
    nextreloadtime = 0;
    pausereloadtime = 0;
    var_68b66508c98bc655 = 0;
    
    while ( true )
    {
        canreload = !player ishanging() && !player isonladder() && !player swim_common::isplayerunderwater();
        
        if ( usingpistol && canreload )
        {
            usingpistol = 0;
            var_c8ddd6411f7aed02 = 1;
            var_68b66508c98bc655 = level.var_8b6e23e8333e6c6a - pausereloadtime;
            nextreloadtime = gettime() + var_68b66508c98bc655;
        }
        else if ( !usingpistol && !canreload )
        {
            if ( nextreloadtime > gettime() )
            {
                pausereloadtime = nextreloadtime - gettime();
            }
            else
            {
                pausereloadtime = 0;
            }
            
            var_c8ddd6411f7aed02 = 0;
            usingpistol = 1;
        }
        
        if ( var_c8ddd6411f7aed02 )
        {
            if ( nextreloadtime <= gettime() )
            {
                return;
            }
            
            wait var_68b66508c98bc655 / 1000;
            continue;
        }
        
        player utility::waittill_any( "mantle_start", "mantle_end", "player_on_ladder_begin", "player_on_ladder_end", #"hash_3030751fd4115249" );
    }
}

// Namespace class
// Params 1
// Checksum 0xb1b607ac, Offset: 0x19cb8
// Size: 0xdd
function function_36697132ee943eed( weaponobj )
{
    self endon( #"death_or_disconnect" );
    waittillframeend();
    self endon( #"giveloadout" );
    
    while ( true )
    {
        function_abb528f0a5d311e0( self );
        
        if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            attemptedreload = item_weapon::function_165956c3013b4abf( weaponobj );
        }
        
        if ( !attemptedreload )
        {
            clipsize = weaponclipsize( weaponobj );
            ammo = self getweaponammoclip( weaponobj );
            var_8bb1b2bde27b267c = 0;
            
            if ( ammo < clipsize )
            {
                poolammo = self getweaponammostock( weaponobj );
                var_8bb1b2bde27b267c += clipsize - ammo;
                
                if ( var_8bb1b2bde27b267c > poolammo )
                {
                    var_8bb1b2bde27b267c = poolammo;
                }
                
                if ( var_8bb1b2bde27b267c > 0 )
                {
                    self setweaponammoclip( weaponobj, clipsize );
                    self setweaponammostock( weaponobj, poolammo - var_8bb1b2bde27b267c );
                }
            }
        }
    }
}

// Namespace class
// Params 1
// Checksum 0x3233ca32, Offset: 0x19d9d
// Size: 0x95
function function_2ab4e0aab98f0f4c( var_b5ddaaf5fffe6e65 )
{
    self endon( #"death_or_disconnect" );
    waittillframeend();
    self endon( #"giveloadout" );
    
    if ( !getdvarint( @"hash_ad5d112e9d176248", 1 ) )
    {
        return;
    }
    
    while ( true )
    {
        msg = utility::waittill_any_return( "target_marker_begin_non_cancellable", "target_marker_end_non_cancellable" );
        
        if ( msg == "target_marker_begin_non_cancellable" )
        {
            markerweapon = self getcurrentweapon();
            
            if ( isdefined( markerweapon ) )
            {
                self.var_dcaf78557efb63d8 = markerweapon;
                continue;
            }
        }
        
        self.var_dcaf78557efb63d8 = undefined;
    }
}

// Namespace class
// Params 1
// Checksum 0x221bbc14, Offset: 0x19e3a
// Size: 0x62
function function_26ac6085a9989d97( var_b5ddaaf5fffe6e65 )
{
    level endon( #"game_ended" );
    player = self;
    player endon( #"death_or_disconnect" );
    waittillframeend();
    player endon( #"giveloadout" );
    player enableweaponpickup();
    player enableweaponfireunderwater();
    player childthread function_5d70bb77a5d97109( var_b5ddaaf5fffe6e65 );
    player childthread function_4930eec9c817358( var_b5ddaaf5fffe6e65 );
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x32d63057, Offset: 0x19ea4
// Size: 0x7f
function private function_3849822cb42c621d( underwaterdata )
{
    if ( underwaterdata.isunderwater )
    {
        self notify( #"hash_562678f0fd6829ed" );
        
        if ( level.gametypebundle.var_eec5bffb9fed1693 )
        {
            self enableweaponswitch();
        }
        
        if ( self.inlaststand )
        {
            underwaterdata.isunderwater = undefined;
        }
        else
        {
            function_40e3c14541b5befb( underwaterdata, 1 );
            underwaterdata.isunderwater = 0;
        }
        
        underwaterdata.switchedweapon = undefined;
    }
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0x9a2c804a, Offset: 0x19f2b
// Size: 0x143
function private function_5d70bb77a5d97109( var_b5ddaaf5fffe6e65 )
{
    player = self;
    underwaterdata = spawnstruct();
    underwaterdata.isunderwater = undefined;
    underwaterdata.switchedweapon = undefined;
    underwaterdata.backuppistol = var_b5ddaaf5fffe6e65;
    
    while ( true )
    {
        if ( player swim_common::isplayerunderwater() && !player.inlaststand && !player utility::isusingremote() && !player function_41360f0bcfc012aa() )
        {
            curweapon = player getcurrentweapon();
            
            if ( !weapon::issuperweapon( curweapon ) )
            {
                player.var_be04506626bbcc1f = curweapon;
            }
            
            if ( !underwaterdata.isunderwater )
            {
                player notify( #"hash_b9ce68d1ae5ca421" );
                underwaterdata.isunderwater = 1;
                
                if ( player vehicle::is_in_vehicle( 1 ) )
                {
                    continue;
                }
                
                player function_99faafebcde581c9( underwaterdata );
                
                if ( level.gametypebundle.var_eec5bffb9fed1693 )
                {
                    player disableweaponswitch();
                }
                
                player thread function_1c51359871e59f42( underwaterdata );
            }
        }
        else
        {
            function_3849822cb42c621d( underwaterdata );
        }
        
        player utility::waittill_any( "last_stand_enter", "last_stand_finished", #"hash_3030751fd4115249" );
    }
}

// Namespace class
// Params 1, eflags: 0x4
// Checksum 0xc54ec263, Offset: 0x1a076
// Size: 0x10a
function private function_4930eec9c817358( var_b5ddaaf5fffe6e65 )
{
    player = self;
    hangdata = spawnstruct();
    hangdata.ishanging = 0;
    hangdata.switchedweapon = undefined;
    hangdata.backuppistol = var_b5ddaaf5fffe6e65;
    
    while ( true )
    {
        if ( player ishanging() || player isonladder() )
        {
            if ( !hangdata.ishanging )
            {
                player notify( #"hash_b9ce68d1ae5ca421" );
                player function_660223f473645910( hangdata.backuppistol );
                hangdata.ishanging = 1;
                hangdata.switchedweapon = player getcurrentprimaryweapon();
            }
        }
        else if ( hangdata.ishanging )
        {
            player function_40e3c14541b5befb( hangdata, 1 );
            hangdata.ishanging = 0;
            hangdata.switchedweapon = undefined;
        }
        
        player utility::waittill_any( "mantle_start", "mantle_end", "player_on_ladder_begin", "player_on_ladder_end" );
    }
}

// Namespace class
// Params 2, eflags: 0x4
// Checksum 0xfc8c4edb, Offset: 0x1a188
// Size: 0x36, Type: bool
function private function_8dd433c6d048ba69( weap, backuppistol )
{
    return weap != backuppistol && weaponclass( weap ) == "pistol" && !weapon::ismeleeonly( weap );
}

// Namespace class
// Params 1
// Checksum 0xd64756cc, Offset: 0x1a1c7
// Size: 0x1e5
function function_99faafebcde581c9( underwaterdata )
{
    player = self;
    player disableweaponpickup();
    player enableweaponfireunderwater();
    playerweapon = player getcurrentprimaryweapon();
    
    if ( function_773ed07a32166cd8( playerweapon, underwaterdata ) )
    {
        underwaterdata.switchedweapon = playerweapon;
    }
    
    var_b4f3cad0493e5c32 = playerweapon;
    
    if ( !function_8dd433c6d048ba69( var_b4f3cad0493e5c32, underwaterdata.backuppistol ) )
    {
        var_b4f3cad0493e5c32 = underwaterdata.backuppistol;
        
        foreach ( weap in player.primaryweapons )
        {
            if ( weap == playerweapon )
            {
                continue;
            }
            
            if ( function_8dd433c6d048ba69( weap, underwaterdata.backuppistol ) )
            {
                var_b4f3cad0493e5c32 = weap;
                break;
            }
        }
    }
    
    player function_660223f473645910( var_b4f3cad0493e5c32 );
    success = player inventory_utility::domonitoredweaponswitch( var_b4f3cad0493e5c32, 0, 1 );
    
    if ( success != 1 )
    {
        if ( !player inventory_utility::iscurrentweapon( var_b4f3cad0493e5c32 ) )
        {
            if ( getdvarint( @"hash_c32ab1b4badd23f5", 1 ) && !var_b4f3cad0493e5c32 hasattachment( "backup_pistol" ) )
            {
                ammoclip = self getweaponammoclip( var_b4f3cad0493e5c32 );
                ammostock = self getweaponammostock( var_b4f3cad0493e5c32 );
                rarity = player item_weapon::function_fb81bd2fe070faa6( var_b4f3cad0493e5c32 );
                player inventory_utility::abortmonitoredweaponswitch( var_b4f3cad0493e5c32 );
                player giveweapon( var_b4f3cad0493e5c32, 0, 0, 0, 1 );
                self setweaponammoclip( var_b4f3cad0493e5c32, ammoclip );
                self setweaponammostock( var_b4f3cad0493e5c32, ammostock );
                player item_weapon::function_40e1cbd0e1f47d1a( var_b4f3cad0493e5c32, rarity );
                return;
            }
            
            player inventory_utility::abortmonitoredweaponswitch( var_b4f3cad0493e5c32 );
        }
    }
}

// Namespace class
// Params 2
// Checksum 0x33aa2c6a, Offset: 0x1a3b4
// Size: 0x8c, Type: bool
function function_773ed07a32166cd8( switchedweapon, data )
{
    if ( self.var_dcaf78557efb63d8 == switchedweapon )
    {
        return true;
    }
    
    if ( switchedweapon.basename == "none" )
    {
        return false;
    }
    
    return switchedweapon != data.backuppistol && !armor::function_eecfbcb181240dd9( switchedweapon ) && !weapon::isgunlessweapon( switchedweapon ) && !weapon::iskillstreakweapon( switchedweapon ) && !weapon::isclimbweapon( switchedweapon ) && !weapon::isunderwaterweapon( switchedweapon );
}

// Namespace class
// Params 1
// Checksum 0x703f6906, Offset: 0x1a449
// Size: 0xa2
function function_660223f473645910( var_b4f3cad0493e5c32 )
{
    player = self;
    
    if ( !getdvarint( @"hash_4326092f73174099", 1 ) )
    {
        if ( utility::issharedfuncdefined( #"damage_upgrade", #"hash_b39175d78cf5b360" ) )
        {
            attachment = self [[ utility::getsharedfunc( #"damage_upgrade", #"hash_b39175d78cf5b360" ) ]]( var_b4f3cad0493e5c32 );
            
            if ( attachment && !var_b4f3cad0493e5c32 hasattachment( attachment ) )
            {
                var_b4f3cad0493e5c32 = var_b4f3cad0493e5c32 withattachment( attachment );
            }
        }
    }
    
    if ( !player hasweapon( var_b4f3cad0493e5c32 ) )
    {
        player giveweapon( var_b4f3cad0493e5c32, 0, 0, 0, 1, 1 );
    }
}

// Namespace class
// Params 1
// Checksum 0xdc758652, Offset: 0x1a4f3
// Size: 0xce
function function_f91e5ae66870b608( data )
{
    player = self;
    
    if ( !isdefined( data.switchedweapon ) || !function_773ed07a32166cd8( data.switchedweapon, data ) )
    {
        foreach ( weap in player.primaryweapons )
        {
            if ( function_773ed07a32166cd8( weap, data ) )
            {
                data.switchedweapon = weap;
                break;
            }
        }
    }
}

// Namespace class
// Params 2
// Checksum 0xf346a604, Offset: 0x1a5c9
// Size: 0x14a
function function_40e3c14541b5befb( data, waittillequipped )
{
    player = self;
    playercurrentweapon = player getcurrentprimaryweapon();
    
    if ( !weapon::isbackuppistol( playercurrentweapon ) )
    {
        return;
    }
    
    player enableweaponpickup();
    player enableweaponfireunderwater();
    var_b669dfba087589f3 = isdefined( playercurrentweapon ) && playercurrentweapon.basename != "none";
    
    if ( data.switchedweapon && !self hasweapon( data.switchedweapon ) && weapon::issuperweapon( data.switchedweapon ) )
    {
        data.switchedweapon = inventory::getlastweapon();
    }
    
    if ( !var_b669dfba087589f3 || !function_773ed07a32166cd8( playercurrentweapon, data ) )
    {
        player function_f91e5ae66870b608( data );
        result = 0;
        
        while ( !result )
        {
            result = player inventory_utility::domonitoredweaponswitch( data.switchedweapon, 0, 1 );
            
            if ( !result )
            {
                waitframe();
                player function_f91e5ae66870b608( data );
            }
        }
        
        data.switchedweapon = undefined;
        return;
    }
    
    if ( waittillequipped && isdefined( playercurrentweapon ) && playercurrentweapon != data.backuppistol )
    {
        player thread function_f70d50807a683bbe( data );
    }
}

// Namespace class
// Params 1
// Checksum 0x35445382, Offset: 0x1a71b
// Size: 0xfa
function function_f70d50807a683bbe( data )
{
    player = self;
    player notify( #"hash_aa6d432a7fab4287" );
    player endon( #"giveloadout" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_aa6d432a7fab4287" );
    player endon( #"hash_b9ce68d1ae5ca421" );
    player endon( #"last_stand_enter" );
    var_769d6360e060c6dc = player getcurrentprimaryweapon();
    var_85ff632837d5fcbf = player function_ca1904a5dd87fd53();
    
    if ( var_769d6360e060c6dc == var_85ff632837d5fcbf )
    {
        while ( player isswitchingweapon() )
        {
            waitframe();
        }
    }
    else
    {
        msg = player utility::waittill_any_in_array_return( [ "weapon_switch_done", "weapon_change", "weapon_change_complete" ] );
    }
    
    if ( player function_b5d50e390a29b3d3() )
    {
        player function_40e3c14541b5befb( data, 0 );
        return;
    }
    
    if ( weapon::ismeleeoverrideweapon( var_769d6360e060c6dc ) )
    {
        player function_f70d50807a683bbe( data );
    }
}

// Namespace class
// Params 1
// Checksum 0x32e4bfcc, Offset: 0x1a81d
// Size: 0x15b
function function_1c51359871e59f42( underwaterdata )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"giveloadout" );
    
    if ( !player swim_common::isplayerunderwater() || player.inlaststand )
    {
        function_3849822cb42c621d( underwaterdata );
        return;
    }
    
    player endon( #"hash_562678f0fd6829ed" );
    var_d52d50b6e29fba7a = getdvarfloat( @"hash_5eb644efd8a6bf0b", 7 );
    dotimeout = 0;
    
    while ( true )
    {
        playercurrentweapon = player getcurrentprimaryweapon();
        
        if ( weaponclass( playercurrentweapon ) != "pistol" )
        {
            player enableweaponpickup();
            player disableweaponfireunderwater();
            dotimeout = 1;
        }
        else
        {
            player enableweaponfireunderwater();
        }
        
        if ( !dotimeout )
        {
            dotimeout = 0;
            msg = player utility::waittill_any_in_array_return( [ "weapon_switch_done", "weapon_change", "weapon_change_complete" ] );
            continue;
        }
        
        msg = player utility::waittill_any_in_array_or_timeout( [ "damage", "weapon_switch_done", "weapon_change", "weapon_change_complete" ], var_d52d50b6e29fba7a );
        
        if ( msg == "timeout" || msg == "damage" )
        {
            player function_99faafebcde581c9( underwaterdata );
        }
    }
}

// Namespace class
// Params 0
// Checksum 0x63557cad, Offset: 0x1a980
// Size: 0x48, Type: bool
function function_b5d50e390a29b3d3()
{
    currentweap = self getcurrentprimaryweapon();
    
    if ( isdefined( self.classstruct.var_183fb1979f9b8498 ) && isdefined( currentweap ) )
    {
        return ( currentweap == self.classstruct.var_183fb1979f9b8498 );
    }
    
    return false;
}

// Namespace class
// Params 1
// Checksum 0x8d11bf6b, Offset: 0x1a9d1
// Size: 0x1b1
function function_2e3d65c182c64c5b( weapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( weapon hasattachment( "jup_jp26_la_mike32_rec_amp" ) )
    {
        if ( weapon hasattachment( "jup_ammo_44mm_drill" ) )
        {
            var_147b151ffaa0612e = getdvarint( @"hash_f810f62d8e34f749", 6 );
            self setweaponammoclip( weapon, int( min( 6, var_147b151ffaa0612e ) ) );
            self setweaponammostock( weapon, int( max( 0, var_147b151ffaa0612e ) - 6 ) );
        }
        else if ( weapon hasattachment( "jup_ammo_44mm_slug" ) )
        {
            var_340f10f4d31c681e = getdvarint( @"hash_c84b8c70b1a6559b", 12 );
            self setweaponammoclip( weapon, int( min( 6, var_340f10f4d31c681e ) ) );
            self setweaponammostock( weapon, int( max( 0, var_340f10f4d31c681e ) - 6 ) );
        }
        else if ( weapon hasattachment( "jup_ammo_44mm_sticky" ) )
        {
            var_9bfd549bfc8aafde = getdvarint( @"hash_217d89d2acacb55b", 6 );
            self setweaponammoclip( weapon, int( min( 6, var_9bfd549bfc8aafde ) ) );
            self setweaponammostock( weapon, int( max( 0, var_9bfd549bfc8aafde ) - 6 ) );
        }
        else
        {
            var_d533e58283de3286 = getdvarint( @"hash_24cb33e0921e4525", 6 );
            self setweaponammoclip( weapon, int( min( 6, var_d533e58283de3286 ) ) );
            self setweaponammostock( weapon, int( max( 0, var_d533e58283de3286 ) - 6 ) );
        }
        
        return;
    }
    
    var_d533e58283de3286 = getdvarint( @"hash_24cb33e0921e4525", 6 );
    self setweaponammoclip( weapon, int( min( 6, var_d533e58283de3286 ) ) );
    self setweaponammostock( weapon, int( max( 0, var_d533e58283de3286 ) - 6 ) );
}

// Namespace class
// Params 2
// Checksum 0xc001aaaf, Offset: 0x1ab8a
// Size: 0x9a
function function_85cbfb19b81c4ac7( var_df75b7d8d3c9112, loadouts )
{
    customloadouts = function_8cc2758f17a3d70a( var_df75b7d8d3c9112 );
    
    foreach ( entry in customloadouts )
    {
        function_a05a60a097c83ac( entry, loadouts );
    }
}

// Namespace class
// Params 2
// Checksum 0x8fd67256, Offset: 0x1ac2c
// Size: 0x13b
function function_a05a60a097c83ac( var_471f67719c37edf3, loadouts )
{
    classtablebundle = getscriptbundle( var_471f67719c37edf3.bundle );
    assert( isdefined( classtablebundle ), "<dev string:x73d>" );
    
    foreach ( loadoutentry in classtablebundle.classlist )
    {
        assert( isdefined( loadoutentry ) );
        var_79240becd50c909e = hashcat( %"classtableentry:", loadoutentry.entry );
        var_227506a321482ad6 = getscriptbundle( var_79240becd50c909e );
        assert( isdefined( var_227506a321482ad6 ), "<dev string:x779>" );
        assert( !isdefined( loadouts[ loadoutentry.entry ] ), "<dev string:x7c6>" + loadoutentry.entry );
        loadouts[ loadoutentry.entry ] = function_79947c7814a64d0e( var_227506a321482ad6 );
    }
}

// Namespace class
// Params 2
// Checksum 0x757e6612, Offset: 0x1ad6f
// Size: 0x614
function function_79947c7814a64d0e( classtableentrybundle, allowattachments = 1 )
{
    loadout = [];
    var_7164818b802f69bf = weapon::getweaponrootname( classtableentrybundle.primaryweapon.weapon );
    loadout[ "loadoutPrimary" ] = var_7164818b802f69bf;
    loadout[ "loadoutPrimaryAttachment" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment1 : "none";
    loadout[ "loadoutPrimaryAttachment1" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment2 : "none";
    loadout[ "loadoutPrimaryAttachment2" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment3 : "none";
    loadout[ "loadoutPrimaryAttachment3" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment4 : "none";
    loadout[ "loadoutPrimaryAttachment4" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment5 : "none";
    loadout[ "loadoutPrimaryAttachment5" ] = allowattachments ? classtableentrybundle.primaryweapon.attachment6 : "none";
    loadout[ "loadoutPrimaryCamo" ] = classtableentrybundle.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = classtableentrybundle.primaryweapon.reticle;
    loadout[ "loadoutPrimaryVariantID" ] = classtableentrybundle.primaryweapon.variantid;
    loadout[ "loadoutPrimaryAmmoMod" ] = classtableentrybundle.primaryweapon.ammomod;
    loadout[ "loadoutPrimaryRarity" ] = classtableentrybundle.primaryweaponrarity;
    var_7a3873d28921fe2f = weapon::getweaponrootname( classtableentrybundle.secondaryweapon.weapon );
    loadout[ "loadoutSecondary" ] = var_7a3873d28921fe2f;
    loadout[ "loadoutSecondaryAttachment" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment1 : "none";
    loadout[ "loadoutSecondaryAttachment1" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment2 : "none";
    loadout[ "loadoutSecondaryAttachment2" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment3 : "none";
    loadout[ "loadoutSecondaryAttachment3" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment4 : "none";
    loadout[ "loadoutSecondaryAttachment4" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment5 : "none";
    loadout[ "loadoutSecondaryAttachment5" ] = allowattachments ? classtableentrybundle.secondaryweapon.attachment6 : "none";
    loadout[ "loadoutSecondaryCamo" ] = classtableentrybundle.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = classtableentrybundle.secondaryweapon.reticle;
    loadout[ "loadoutSecondaryVariantID" ] = classtableentrybundle.secondaryweapon.variantid;
    loadout[ "loadoutSecondaryRarity" ] = classtableentrybundle.secondaryweaponrarity;
    var_f20a18d4656a078f = weapon::getweaponrootname( classtableentrybundle.tertiaryWeapon.weapon );
    loadout[ "loadoutTertiary" ] = var_f20a18d4656a078f;
    loadout[ "loadoutTertiaryCamo" ] = classtableentrybundle.tertiaryWeapon.camo;
    loadout[ "loadoutEquipmentPrimary" ] = classtableentrybundle.equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = classtableentrybundle.equipment.secondary;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        loadout[ "loadoutTertiaryVariantID" ] = classtableentrybundle.tertiaryWeapon.variantid;
        loadout[ "loadoutEquipmentTertiary" ] = classtableentrybundle.equipment.tertiary;
    }
    
    loadout[ "loadoutFieldUpgrade1" ] = classtableentrybundle.fieldUpgrades.fieldupgrade1;
    loadout[ "loadoutFieldUpgrade2" ] = classtableentrybundle.fieldUpgrades.fieldupgrade2;
    loadout[ "loadoutPerks" ] = [];
    loadout[ "loadoutPerks" ][ 0 ] = classtableentrybundle.perks.perk1;
    loadout[ "loadoutPerks" ][ 1 ] = classtableentrybundle.perks.perk2;
    loadout[ "loadoutPerks" ][ 2 ] = classtableentrybundle.perks.perk3;
    loadout[ "loadoutPerks" ][ 3 ] = classtableentrybundle.perks.perk4;
    loadout[ "loadoutGesture" ] = "playerdata";
    loadout[ "loadoutExecution" ] = "playerdata";
    
    if ( game_utility::getgametype() == "ob" )
    {
        loadout[ "selfReviveCount" ] = classtableentrybundle.selfReviveCount;
        loadout[ "loadoutPowerTier" ] = classtableentrybundle.powertier;
        loadout[ "loadoutSkillTracks" ] = classtableentrybundle.skilltracks;
    }
    
    loadout[ "loadoutSkills" ] = classtableentrybundle.skills;
    loadout[ "loadoutKillstreak1" ] = function_7292081d9725c851( classtableentrybundle.killstreak.killstreak1 );
    loadout[ "loadoutKillstreak2" ] = function_7292081d9725c851( classtableentrybundle.killstreak.killstreak2 );
    loadout[ "loadoutKillstreak3" ] = function_7292081d9725c851( classtableentrybundle.killstreak.killstreak3 );
    loadout[ "loadoutStreakType" ] = classtableentrybundle.killstreak.streaktype;
    loadout[ #"disablebackuppistol" ] = classtableentrybundle.disablebackuppistol;
    return loadout;
}

// Namespace class
// Params 1
// Checksum 0x543b30b7, Offset: 0x1b38c
// Size: 0x38
function function_7292081d9725c851( killstreakref )
{
    if ( !isdefined( killstreakref ) )
    {
        return "none";
    }
    else if ( isint( killstreakref ) )
    {
        return ( loot::function_f54ecb89dfab8e8c( killstreakref ) ?? "none" );
    }
    
    return killstreakref;
}

// Namespace class
// Params 1
// Checksum 0x46fb23d7, Offset: 0x1b3cd
// Size: 0x5a
function function_48beae0092e1c9e9( loadout )
{
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment1" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryAttachment3" ] = "none";
    loadout[ "loadoutPrimaryAttachment4" ] = "none";
    loadout[ "loadoutPrimaryAttachment5" ] = "none";
}

// Namespace class
// Params 1
// Checksum 0x707dbd76, Offset: 0x1b42f
// Size: 0x5a
function function_b39175d63d495f69( loadout )
{
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment1" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryAttachment3" ] = "none";
    loadout[ "loadoutSecondaryAttachment4" ] = "none";
    loadout[ "loadoutSecondaryAttachment5" ] = "none";
}

// Namespace class
// Params 0, eflags: 0x4
// Checksum 0xe91373fa, Offset: 0x1b491
// Size: 0x14b
function private function_96674d4f4b799db1()
{
    level.var_6417f60a871eaa35 = [];
    var_b4a58d6f6ae74e4d = level.gamemodebundle.var_6417f60a871eaa35;
    
    foreach ( entry in var_b4a58d6f6ae74e4d )
    {
        level.var_6417f60a871eaa35[ level.var_6417f60a871eaa35.size ] = entry.specialty;
    }
    
    foreach ( entry in level.gametypebundle.var_6417f60a871eaa35 )
    {
        level.var_6417f60a871eaa35[ level.var_6417f60a871eaa35.size ] = entry.specialty;
    }
    
    return level.var_6417f60a871eaa35;
}

// Namespace class
// Params 0
// Checksum 0xb79ecd8a, Offset: 0x1b5e5
// Size: 0x31
function function_3ffe6bf4c4104c66()
{
    level.tertiaryweaponslotenabled = getdvarint( @"tertiaryweaponslotenabled", 0 ) > 0;
    
    if ( level.tertiaryweaponslotenabled )
    {
        level.var_af41f134389a876c = undefined;
    }
}

// Namespace class
// Params 0
// Checksum 0x5e2f556, Offset: 0x1b61e
// Size: 0x50
function function_1e64c4417c67cfa4()
{
    level.var_613ba3e28ca2d235 = level.gamemodebundle.var_613ba3e28ca2d235;
    level.var_b8686b90947d6097 = level.gamemodebundle.var_b8686b90947d6097;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        level.var_af41f134389a876c = undefined;
    }
}

// Namespace class
// Params 1
// Checksum 0xdf504eca, Offset: 0x1b676
// Size: 0x9a
function function_4d5d5b22ebcdfca0( class )
{
    classtype = loadout_getclasstype( class );
    classindex = getclassindex( class );
    
    if ( classtype == "custom" )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"selectedoperator", #"operatorlootid" );
        return loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    return table_getitem( level.classtablename, classindex ).operator;
}

// Namespace class
// Params 1
// Checksum 0x20fbe7fb, Offset: 0x1b718
// Size: 0xac
function function_cc98941cc6d2c869( class )
{
    classtype = loadout_getclasstype( class );
    classindex = getclassindex( class );
    
    if ( classtype == "custom" )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"selectedoperator", #"skinlootid" );
        return loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    operator = table_getitem( level.classtablename, classindex ).operator;
    return operator::function_447fce2531e40d0e( operator );
}

// Namespace class
// Params 1
// Checksum 0x31395d24, Offset: 0x1b7cc
// Size: 0xfa
function function_965c85a4e2efba31( class )
{
    team = self.team;
    superfactionindex = operator::getsuperfactionindex();
    classtype = loadout_getclasstype( class );
    classindex = getclassindex( class );
    
    if ( classtype == "custom" )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"selectedoperators", superfactionindex, #"operatorlootid" );
        
        if ( lootid != 0 )
        {
            return loot::function_f54ecb89dfab8e8c( lootid );
        }
        else
        {
            return;
        }
        
        return;
    }
    
    classentry = table_getitem( level.classtablename, classindex );
    operator = team == "allies" ? classentry.operatorwest : classentry.operatoreast;
    return operator;
}

// Namespace class
// Params 1
// Checksum 0x146cb671, Offset: 0x1b8ce
// Size: 0x112
function function_ed695e64253d505c( class )
{
    team = self.team;
    superfactionindex = operator::getsuperfactionindex();
    classtype = loadout_getclasstype( class );
    classindex = getclassindex( class );
    
    if ( classtype == "custom" )
    {
        lootid = self getplayerdata( self.loadoutdata, #"loadouts", classindex, #"selectedoperators", superfactionindex, #"skinlootid" );
        
        if ( lootid != 0 )
        {
            return loot::function_f54ecb89dfab8e8c( lootid );
        }
        else
        {
            operator = operator::function_297589994c9a9eff( superfactionindex );
            return operator::function_447fce2531e40d0e( operator );
        }
        
        return;
    }
    
    classentry = table_getitem( level.classtablename, classindex );
    operator = team == "allies" ? classentry.operatorwest : classentry.operatoreast;
    return operator::function_447fce2531e40d0e( operator );
}

// Namespace class
// Params 2, eflags: 0x40 variadic
// Checksum 0x46409ba7, Offset: 0x1b9e8
// Size: 0xaa
function function_63f75b40675b196f( ... )
{
    superfactionindex = operator::getsuperfactionindex();
    operator = undefined;
    
    if ( operator::function_fce13d709d67dd26() )
    {
        operator = self getplayerdata( level.loadoutsgroup, "customizations", "operators", superfactionindex, "operatorRef" );
    }
    else if ( getprojectname() != "REW" )
    {
        operator = self getplayerdata( level.loadoutsgroup, #"customizationsetup", #"operators", superfactionindex );
    }
    
    if ( operator::function_fb3ad5cd3a9ae76b( operator ) )
    {
        return operator;
    }
    
    return operator::function_297589994c9a9eff( superfactionindex );
}

// Namespace class
// Params 2, eflags: 0x40 variadic
// Checksum 0xb9e34516, Offset: 0x1ba9a
// Size: 0xb4
function function_11d5729edc847aa6( ... )
{
    operatorref = function_63f75b40675b196f();
    
    if ( operator::function_fce13d709d67dd26() )
    {
        superfactionindex = operator::getsuperfactionindex();
        skin = self getplayerdata( level.loadoutsgroup, "customizations", "operators", superfactionindex, "skinRef" );
    }
    else
    {
        skin = self getplayerdata( level.loadoutsgroup, #"customizationsetup", #"operatorcustomization", operatorref, #"skin" );
    }
    
    if ( skin == %"" )
    {
        skin = operator::function_447fce2531e40d0e( operatorref );
    }
    
    return skin;
}

/#

    // Namespace class
    // Params 0, eflags: 0xc
    // Checksum 0xac3b5ad8, Offset: 0x1bb57
    // Size: 0x215, Type: dev
    function private debug_weapons_list()
    {
        self notify( #"hash_277bf35bd1b990bc" );
        self endon( #"hash_277bf35bd1b990bc" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            scr_debug_weapons = getdvarint( @"hash_9d24f55b5f58e63b", 0 );
            
            while ( scr_debug_weapons )
            {
                hudelem = self.var_c460e38ba081c99c;
                
                if ( !isdefined( hudelem ) )
                {
                    hudelem = newclienthudelem( self );
                    hudelem.alignx = "<dev string:x7e2>";
                    hudelem.aligny = "<dev string:x7e7>";
                    hudelem.x = -50;
                    hudelem.y = 200;
                    hudelem.foreground = 1;
                    hudelem.color = ( 1, 1, 1 );
                    hudelem.fontscale = 1.25;
                    hudelem.scramblerdisabled = 1;
                }
                
                self.var_c460e38ba081c99c = hudelem;
                weapons = self getweaponslistall();
                msg = "<dev string:x7eb>" + weapons.size + "<dev string:x7f5>";
                
                foreach ( weapon in weapons )
                {
                    weapontext = getcompleteweaponname( weapon );
                    
                    if ( weapontext.size > 67 )
                    {
                        weapontext = getsubstr( weapontext, 0, 32 ) + "<dev string:x7f7>" + getsubstr( weapontext, weapontext.size - 32 );
                    }
                    
                    msg = msg + weapontext + "<dev string:x7f5>";
                }
                
                hudelem setdevtext( msg );
                scr_debug_weapons = getdvarint( @"hash_9d24f55b5f58e63b", 0 );
                waitframe();
            }
            
            if ( self.var_c460e38ba081c99c )
            {
                self.var_c460e38ba081c99c destroy();
                self.var_c460e38ba081c99c = undefined;
            }
            
            wait 1;
        }
    }

#/
