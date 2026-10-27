// scripts\mp\loot\common_item_aether_upgrade.gsc  (hash_0cf99b3cf14a336f.gscc) (size: 2994 Bytes / 0xbb2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc9ac6d3 (3432695507)
// size ...... 2994 (0xbb2)
// includes .. 8   (offset: 0xb3e)
// strings ... 3   (offset: 0xb7e)
// dev strs .. 0   (offset: 0xbb2)
// exports ... 10  (offset: 0x5d6)
// cseg ...... 0xa5 + 0x531 (0x5d6)
// imports ... 34  (offset: 0x766)
// animtree1 . 0   (offset: 0xbb2)
// animtree2 . 0   (offset: 0xbb2)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weapons;

#namespace item_aether_upgrade;

// Namespace item_aether_upgrade
// Params 0, eflags: 0x5
// Checksum 0xc81ab538, Offset: 0xc3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_aether_upgrade", #"common_item", &function_717ebfc96d2731a5, undefined );
}

// Namespace item_aether_upgrade
// Params 0, eflags: 0x4
// Checksum 0x4280f213, Offset: 0xec
// Size: 0x4d
function private function_717ebfc96d2731a5()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "aether_upgrade" );
    common_item::function_84174b793b5fe9a7( "aether_upgrade", #"use", &function_8e3f598397e9125a );
    common_item::function_84174b793b5fe9a7( "aether_upgrade", #"hash_9e49dfaa7c147654", &function_7c48445076c96ef6 );
}

// Namespace item_aether_upgrade
// Params 2, eflags: 0x4
// Checksum 0x50c52cb9, Offset: 0x141
// Size: 0x79
function private function_eeeae0ac9eca8816( player, var_ab3d86fd09bad221 )
{
    itembundlename = common_item_database::function_ca9ca606e66b5911( var_ab3d86fd09bad221.scriptable );
    var_9ffea708a12df7c3 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itembundlename );
    player setclientomnvar( "ui_br_upgraded_weapon_item_bundle", var_9ffea708a12df7c3 ?? 0 );
    thread utility::callsharedfunc( #"challenges", #"reportweaponupgrade", player, var_ab3d86fd09bad221 );
}

// Namespace item_aether_upgrade
// Params 4
// Checksum 0x713fa5c0, Offset: 0x1c2
// Size: 0x1ef
function function_8e3f598397e9125a( itembundle, item, autouse, spawnoptions )
{
    weapon = function_b90608854b53b2df( self );
    var_ab3d86fd09bad221 = function_16e691241286a5d5( self, weapon );
    
    if ( !var_ab3d86fd09bad221 )
    {
        return item.count;
    }
    
    pastteam = item_weapon::function_af299135a62729b8( weapon );
    var_1dd5fd3c089a62d8 = self isalternatemode( weapon ) && weapons::shouldweaponsavealtstate( weapon );
    removeparams = { #weapon:weapon, #dontdrop:1 };
    var_9365dd79ea80061d = item_weapon::items_weapon_removeweapon( removeparams );
    weaponitem = { #count:common_item::function_598dd39282efb544( var_9365dd79ea80061d.ammoclipright, var_9365dd79ea80061d.ammoclipleft, var_9365dd79ea80061d.ammoclipalt ) };
    function_eeeae0ac9eca8816( self, var_ab3d86fd09bad221 );
    
    if ( getdvarint( @"hash_3d61c95afeee3d5e", 1 ) )
    {
        self.var_2e6e138927b1b4b7 = weapon.camo;
    }
    
    [ _item, newweapon ] = item_weapon::function_5be1bc100827adc7( var_ab3d86fd09bad221, weaponitem );
    self.var_2e6e138927b1b4b7 = undefined;
    
    if ( newweapon )
    {
        if ( pastteam )
        {
            item_weapon::function_59db11f47705f704( newweapon, pastteam );
        }
        
        if ( itembundle.var_a67a1b969e8fea3 )
        {
            item_weapon::function_165956c3013b4abf( newweapon );
        }
        
        if ( var_1dd5fd3c089a62d8 && newweapon.hasalternate )
        {
            self setalternatemode( newweapon, 1 );
        }
    }
    
    if ( !isdefined( self.endmatchstats[ "weaponUpgradesUsed" ] ) )
    {
        self.endmatchstats[ "weaponUpgradesUsed" ] = 0;
    }
    
    self.endmatchstats[ "weaponUpgradesUsed" ]++;
    return item.count - 1;
}

// Namespace item_aether_upgrade
// Params 4
// Checksum 0xecb805e6, Offset: 0x3ba
// Size: 0x67, Type: bool
function function_7c48445076c96ef6( itembundle, item, autouse, allowswap )
{
    weapon = function_b90608854b53b2df( self );
    var_ab3d86fd09bad221 = function_16e691241286a5d5( self, weapon );
    
    if ( !var_ab3d86fd09bad221 )
    {
        hud_message::showerrormessage( %"hash_3abbf0058f5a7ec6" );
        return false;
    }
    
    return true;
}

// Namespace item_aether_upgrade
// Params 2
// Checksum 0x98846017, Offset: 0x42a
// Size: 0x7a
function function_2e03bb7a00789440( var_b9af2aa63e8b8169, var_b9af27a63e8b7ad0 )
{
    if ( var_b9af2aa63e8b8169 == var_b9af27a63e8b7ad0 )
    {
        return 1;
    }
    
    var_cbb01a38897941b3 = getscriptbundlefieldvalue( var_b9af2aa63e8b8169, #"rarity" ) ?? 0;
    var_fb7f1a8cfc52b69e = getscriptbundlefieldvalue( var_b9af27a63e8b7ad0, #"rarity" ) ?? 0;
    
    if ( var_cbb01a38897941b3 > var_fb7f1a8cfc52b69e )
    {
        return function_7ef1566b9f1d810f( var_b9af2aa63e8b8169, var_b9af27a63e8b7ad0 );
    }
    else
    {
        return function_7ef1566b9f1d810f( var_b9af27a63e8b7ad0, var_b9af2aa63e8b8169 );
    }
    
    return 0;
}

// Namespace item_aether_upgrade
// Params 2
// Checksum 0xde38d92a, Offset: 0x4ad
// Size: 0x54, Type: bool
function function_7ef1566b9f1d810f( var_9873c6a8c0262af2, var_43d2493830f3b85b )
{
    for ( bundlename = getscriptbundlefieldvalue( var_43d2493830f3b85b, #"weaponupgradeitem" ); bundlename ; bundlename = getscriptbundlefieldvalue( bundlename, #"weaponupgradeitem" ) )
    {
        if ( bundlename == var_9873c6a8c0262af2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace item_aether_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf45ea21c, Offset: 0x50a
// Size: 0x17
function private function_b90608854b53b2df( player )
{
    return player.currentprimaryweapon;
}

// Namespace item_aether_upgrade
// Params 2, eflags: 0x4
// Checksum 0xd39f70fa, Offset: 0x52a
// Size: 0xac
function private function_16e691241286a5d5( player, weapon )
{
    weapon = weapon getnoaltweapon();
    
    if ( weapon::isbackuppistol( weapon ) )
    {
        return;
    }
    
    if ( weapon::isunderwaterweaponobject( weapon ) )
    {
        return;
    }
    
    if ( weapon::isclimbweaponobject( weapon ) )
    {
        return;
    }
    
    exoticrarity = common_item::function_b297a2bfcaccc713( #"exotic" );
    
    if ( weapon.var_e4de3f79b4ac164f < exoticrarity )
    {
        itemname = player item_weapon::function_3c60845f4139b91d( weapon );
        
        if ( itemname )
        {
            var_24e0fe8c7eaf03da = getscriptbundlefieldvalue( itemname, #"weaponupgradeitem" );
            
            if ( var_24e0fe8c7eaf03da )
            {
                return common_item::function_90c3e0c1fd55d6b6( var_24e0fe8c7eaf03da );
            }
        }
    }
}

