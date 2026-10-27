// scripts\mp\loot\common_item_upgrade.gsc  (hash_1937f17b21d2cfb9.gscc) (size: 3997 Bytes / 0xf9d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79da924d (2044367437)
// size ...... 3997 (0xf9d)
// includes .. 5   (offset: 0xe95)
// strings ... 14  (offset: 0xebd)
// dev strs .. 0   (offset: 0xf9d)
// exports ... 7   (offset: 0xa4d)
// cseg ...... 0x16e + 0x8df (0xa4d)
// imports ... 26  (offset: 0xb65)
// animtree1 . 0   (offset: 0xf9d)
// animtree2 . 0   (offset: 0xf9d)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;

#namespace item_upgrade;

// Namespace item_upgrade
// Params 0, eflags: 0x5
// Checksum 0x84737fad, Offset: 0x18c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_upgrade", #"common_item", &init_item_upgrade, undefined );
}

// Namespace item_upgrade
// Params 0
// Checksum 0x12d4cb0d, Offset: 0x1b5
// Size: 0xe0
function init_item_upgrade()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.var_63ee1bd04ece86ae = [];
    level.var_63ee1bd04ece86ae[ 0 ] = level.defaultfist.basename;
    level.var_63ee1bd04ece86ae[ 1 ] = "iw9_mg_jltv_mp";
    level.var_63ee1bd04ece86ae[ 2 ] = "iw9_mg_patrol_boat_front_mp";
    level.var_63ee1bd04ece86ae[ 3 ] = "iw9_mg_patrol_boat_back_mp";
    common_item::function_4b30c091d3b04a25( "upgrade" );
    common_item::function_84174b793b5fe9a7( "upgrade", #"use", &use_upgrade );
    common_item::function_84174b793b5fe9a7( "upgrade", #"canautouse", &can_use_upgrade );
    common_item::function_84174b793b5fe9a7( "upgrade", #"hash_9e49dfaa7c147654", &can_use_upgrade );
    common_item::function_84174b793b5fe9a7( "upgrade", #"hash_2d3b76ff260f2d68", &function_d3bcda63b29b89c4 );
}

// Namespace item_upgrade
// Params 4
// Checksum 0x87c1b9dd, Offset: 0x29d
// Size: 0x44
function use_upgrade( itembundle, item, autouse, var_981c264073bf1154 )
{
    weapon = self getcurrentweapon();
    return function_951e0669fdee416a( weapon, itembundle, item, autouse );
}

// Namespace item_upgrade
// Params 5
// Checksum 0x3e4255bb, Offset: 0x2ea
// Size: 0x57
function function_d3bcda63b29b89c4( index, itembundle, lootid, quantity, fromgroup )
{
    weapon = self getcurrentweapon();
    return function_951e0669fdee416a( weapon, itembundle, { #count:quantity }, undefined );
}

// Namespace item_upgrade
// Params 4
// Checksum 0xa9f34fed, Offset: 0x34a
// Size: 0x379
function function_951e0669fdee416a( weapon, itembundle, item, auto_use )
{
    if ( !isdefined( item.count ) )
    {
        item.count = 1;
    }
    
    upgradetype = itembundle.subtype;
    
    if ( upgradetype == "ammomod" )
    {
        if ( isdefined( itembundle.ammomodname ) )
        {
            return ( utility::callsharedfunc( #"ammo_mod", #"use_ammo_mod", weapon, itembundle, item ) ?? item.count );
        }
    }
    else if ( upgradetype == "aethertool" )
    {
        if ( !weapon::iswonderweapon( weapon ) && !weapon::iskillstreakweapon( weapon ) )
        {
            oldrarity = item_weapon::function_fb81bd2fe070faa6( weapon ) ?? 0;
            newrarity = itembundle.upgradelevel;
            
            if ( newrarity > oldrarity )
            {
                self playsoundtoplayer( #"evt_aetherium_tool_use", self );
                item_weapon::function_40e1cbd0e1f47d1a( weapon, newrarity );
                return ( item.count - 1 );
            }
        }
    }
    else if ( upgradetype == "aethercrystal" )
    {
        if ( utility::callsharedfunc( #"pack_a_punch", #"hash_1d402cf8c2699623", weapon ) )
        {
            oldpap = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon ) ?? 0;
            newpap = itembundle.upgradelevel;
            
            if ( newpap > oldpap )
            {
                utility::callsharedfunc( #"pack_a_punch", #"hash_340ee732d0e66af3", weapon, newpap - 1 );
                return ( item.count - 1 );
            }
        }
    }
    else if ( upgradetype == "golden_armor_plate" )
    {
        if ( utility::issharedfuncdefined( #"ob_armor", #"set_golden_armor" ) )
        {
            self playsoundevent( %"sndevent_classified_acquisition_used" );
            self [[ utility::getsharedfunc( #"ob_armor", #"set_golden_armor" ) ]]();
            return ( item.count - 1 );
        }
    }
    else if ( upgradetype == "dog_whistle" )
    {
        if ( utility::issharedfuncdefined( #"ob_dog_whistle", #"hash_4071879418c656da" ) )
        {
            self playsoundevent( %"sndevent_classified_acquisition_used" );
            self [[ utility::getsharedfunc( #"ob_dog_whistle", #"hash_4071879418c656da" ) ]]();
            return ( item.count - 1 );
        }
    }
    else if ( upgradetype == "golden_ammo" )
    {
        if ( utility::issharedfuncdefined( #"ob_golden_ammo", #"set_goldenammo" ) )
        {
            self playsoundevent( %"sndevent_classified_acquisition_used" );
            self [[ utility::getsharedfunc( #"ob_golden_ammo", #"set_goldenammo" ) ]]();
            return ( item.count - 1 );
        }
    }
    else if ( upgradetype == "warlord_afo_beret" || upgradetype == "warlord_chemist_mask" || upgradetype == "warlord_rainmaker_vest" || upgradetype == "warlord_maestro_mod" )
    {
        if ( utility::issharedfuncdefined( #"hash_29802228adb8aae7", #"hash_ff5b730658a761cb" ) )
        {
            self playsoundevent( %"sndevent_classified_acquisition_used" );
            utility::callsharedfunc( #"hash_29802228adb8aae7", #"hash_ff5b730658a761cb", upgradetype );
            return ( item.count - 1 );
        }
    }
    
    return item.count;
}

// Namespace item_upgrade
// Params 4
// Checksum 0xbef0560b, Offset: 0x6cc
// Size: 0x380, Type: bool
function can_use_upgrade( itembundle, item, autouse, allowswap )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    upgradetype = itembundle.subtype;
    weapon = self getcurrentweapon();
    
    if ( self.insertingarmorplate || self isswitchingweapon() )
    {
        return false;
    }
    
    currentweapon = self getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( currentweapon ) )
    {
        return false;
    }
    
    if ( upgradetype == "ammomod" )
    {
        if ( weapon == level.weaponnone )
        {
            return false;
        }
        
        if ( utility::callsharedfunc( #"ammo_mod", #"hash_4f3b91e6539bb512", weapon ) )
        {
            return true;
        }
    }
    else if ( upgradetype == "aethertool" )
    {
        if ( weapon == level.weaponnone )
        {
            return false;
        }
        
        foreach ( weaponname in level.var_63ee1bd04ece86ae )
        {
            if ( weaponname == weapon.basename )
            {
                return false;
            }
        }
        
        if ( weapon::iswonderweapon( weapon ) )
        {
            return false;
        }
        
        aethertier = itembundle.rarity;
        rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
        
        if ( isint( rarity ) && rarity < 5 )
        {
            switch ( aethertier )
            {
                case 1:
                    if ( rarity < 1 )
                    {
                        return true;
                    }
                    
                    break;
                case 2:
                    if ( rarity < 2 )
                    {
                        return true;
                    }
                    
                    break;
                case 3:
                    if ( rarity < 3 )
                    {
                        return true;
                    }
                    
                    break;
                case 4:
                    if ( rarity < 4 )
                    {
                        return true;
                    }
                    
                    break;
                case 5:
                    if ( rarity < 5 )
                    {
                        return true;
                    }
                    
                    break;
            }
        }
    }
    else if ( upgradetype == "aethercrystal" )
    {
        paplv = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
        aethertier = itembundle.rarity;
        
        if ( isdefined( aethertier ) && isdefined( paplv ) )
        {
            switch ( aethertier )
            {
                case 2:
                    if ( paplv == 0 )
                    {
                        return true;
                    }
                    
                    break;
                case 3:
                    if ( paplv == 0 || paplv == 1 )
                    {
                        return true;
                    }
                    
                    break;
                case 4:
                    if ( paplv != 3 )
                    {
                        return true;
                    }
                    
                    break;
                case 5:
                    if ( paplv != 4 )
                    {
                        return true;
                    }
                    
                    break;
            }
        }
    }
    else if ( upgradetype == "golden_armor_plate" )
    {
        if ( !self.var_a1faa64d8c07872e )
        {
            return true;
        }
    }
    else if ( upgradetype == "golden_ammo" )
    {
        if ( !self.hasgoldenammo )
        {
            return true;
        }
    }
    else if ( upgradetype == "dog_whistle" )
    {
        return true;
    }
    else if ( upgradetype == "warlord_afo_beret" || upgradetype == "warlord_chemist_mask" || upgradetype == "warlord_rainmaker_vest" || upgradetype == "warlord_maestro_mod" )
    {
        return true;
    }
    
    return false;
}

