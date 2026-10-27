// script_5c80e17482acb972  (hash_5c80e17482acb972.gscc) (size: 2974 Bytes / 0xb9e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f6f782e (1869576238)
// size ...... 2974 (0xb9e)
// includes .. 3   (offset: 0xb32)
// strings ... 6   (offset: 0xb4a)
// dev strs .. 1   (offset: 0xb92)
// exports ... 11  (offset: 0x712)
// cseg ...... 0xca + 0x648 (0x712)
// imports ... 21  (offset: 0x8ca)
// animtree1 . 0   (offset: 0xb9e)
// animtree2 . 0   (offset: 0xb9e)
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;

#namespace namespace_aa91747accf9e514;

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0x18e493f6, Offset: 0xe8
// Size: 0x177
function overrideweapons( loadout )
{
    if ( getdvarint( @"scr_snipers_only", 0 ) )
    {
        var_4f83e7cda4f33b39 = "weapon_sniper";
    }
    
    primaryweaponclass = weapon::function_c37ac3c4f987e506( loadout.loadoutprimary, #"menuclass" );
    
    if ( isdefined( var_4f83e7cda4f33b39 ) && primaryweaponclass != var_4f83e7cda4f33b39 || weaponisrestricted( loadout.loadoutprimary ) || isdefined( primaryweaponclass ) && function_16ede83265750fcb( primaryweaponclass ) )
    {
        fallbackprimary = class::table_getweapon( level.classtablename, 0, 0 );
        loadout.loadoutprimary = fallbackprimary;
        loadout.loadoutprimaryattachments = [];
        
        if ( game_utility_mp::function_57f7c589ea92d695() )
        {
            loadout.loadoutprimaryvariantid = -1;
        }
    }
    
    secondaryweaponclass = weapon::function_c37ac3c4f987e506( loadout.loadoutsecondary, #"menuclass" );
    
    if ( isdefined( var_4f83e7cda4f33b39 ) && secondaryweaponclass != var_4f83e7cda4f33b39 || weaponisrestricted( loadout.loadoutsecondary ) || isdefined( secondaryweaponclass ) && function_16ede83265750fcb( secondaryweaponclass ) )
    {
        fallbacksecondary = class::table_getweapon( level.classtablename, 0, 1 );
        loadout.loadoutsecondary = fallbacksecondary;
        loadout.loadoutsecondaryattachments = [];
        
        if ( game_utility_mp::function_57f7c589ea92d695() )
        {
            loadout.loadoutsecondaryvariantid = -1;
        }
    }
    
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xda783972, Offset: 0x268
// Size: 0x46
function overrideprimaryweapon( loadout )
{
    fallbackprimary = class::table_getweapon( level.classtablename, 0, 0 );
    loadout.loadoutprimary = fallbackprimary;
    loadout.loadoutprimaryattachments = [];
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xdc11a5ae, Offset: 0x2b7
// Size: 0x47
function overridesecondaryweapon( loadout )
{
    fallbacksecondary = class::table_getweapon( level.classtablename, 0, 1 );
    loadout.loadoutsecondary = fallbacksecondary;
    loadout.loadoutsecondaryattachments = [];
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xde48aad6, Offset: 0x307
// Size: 0xb5
function function_aa4c80e551a05d12( loadout )
{
    msg = "Overriding FLC Perks. ";
    
    for ( i = 0; i < loadout.loadoutperks.size ; i++ )
    {
        msg += "Perk " + i + ": " + loadout.loadoutperks[ i ];
    }
    
    /#
        assertmsg( msg );
        
        for ( perkindex = 0; perkindex < loadout.loadoutperks.size ; perkindex++ )
        {
            loadout.loadoutperks[ perkindex ] = class::function_237fdae48e47e8fc( level.classtablename, 0, perkindex );
        }
    #/
    
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0x4bbd4e80, Offset: 0x3c5
// Size: 0x46
function function_57e0f5dfb9ead678( loadout )
{
    loadout.loadoutequipmentprimary = class::table_getequipmentprimary( level.classtablename, 0 );
    loadout.loadoutextraequipmentprimary = class::table_getflcextraequipmentprimary( level.classtablename, 0 );
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xa0018d56, Offset: 0x414
// Size: 0x46
function function_c7ed4fc5660296e8( loadout )
{
    loadout.loadoutequipmentsecondary = class::table_getequipmentsecondary( level.classtablename, 0 );
    loadout.loadoutextraequipmentsecondary = class::table_getflcextraequipmentsecondary( level.classtablename, 0 );
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0x3995baaf, Offset: 0x463
// Size: 0x2b
function overridesuper( loadout )
{
    loadout.loadoutfieldupgrade1 = class::table_getsuper( level.classtablename, 0, 0 );
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xb68a37ef, Offset: 0x497
// Size: 0x4a
function function_7538c728b6a4bb0b( loadout )
{
    loadout = overrideprimaryweapon( loadout );
    loadout = overridesecondaryweapon( loadout );
    loadout = function_aa4c80e551a05d12( loadout );
    loadout = function_57e0f5dfb9ead678( loadout );
    loadout = function_c7ed4fc5660296e8( loadout );
    loadout = overridesuper( loadout );
    return loadout;
}

// Namespace namespace_aa91747accf9e514
// Params 1
// Checksum 0xde3a7b15, Offset: 0x4ea
// Size: 0xc8
function function_e90603b85d730587( loadout )
{
    vestperk = "specialty_null";
    
    foreach ( perk in loadout.loadoutperks )
    {
        if ( isdefined( perk ) && isdefined( level.perkbundles[ perk ] ) )
        {
            if ( level.perkbundles[ perk ].var_bd1b34729a3981d5 == "vest" )
            {
                vestperk = perk;
            }
        }
    }
    
    return vestperk;
}

// Namespace namespace_aa91747accf9e514
// Params 2
// Checksum 0x4b785ca3, Offset: 0x5bb
// Size: 0x156
function function_beaff1c3af9e5d5( perk, vestperk )
{
    switch ( level.perkbundles[ perk ].var_bd1b34729a3981d5 )
    {
        case #"hash_8cbf71797441f513":
            returnvalue = 1;
            break;
        case #"hash_6fb5d66c124bebf7":
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.gloves == 0 )
            {
                returnvalue = 0;
            }
            else
            {
                returnvalue = 1;
            }
            
            break;
        case #"hash_998e90e64af76252":
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.footwear == 0 )
            {
                returnvalue = 0;
            }
            else
            {
                returnvalue = 1;
            }
            
            break;
        case #"hash_60a8910f025fc58e":
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.gearone == 0 && level.perkbundles[ vestperk ].var_3289ad77b9ef2523.geartwo == 0 )
            {
                returnvalue = 0;
            }
            else
            {
                returnvalue = 1;
            }
            
            break;
        default:
            returnvalue = 0;
            break;
    }
    
    assert( returnvalue, "<dev string:x24>" + perk );
    return returnvalue;
}

