// scripts\autotests\mp\autotests_utility_equipment.gsc  (hash_174bf8913e95b2a1.gscc) (size: 1974 Bytes / 0x7b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b64a8ec (1264888044)
// size ...... 1974 (0x7b6)
// includes .. 5   (offset: 0x70a)
// strings ... 8   (offset: 0x732)
// dev strs .. 0   (offset: 0x7b6)
// exports ... 4   (offset: 0x4e6)
// cseg ...... 0x16c + 0x37a (0x4e6)
// imports ... 12  (offset: 0x586)
// animtree1 . 0   (offset: 0x7b6)
// animtree2 . 0   (offset: 0x7b6)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace autotests_utility_equipment;

// Namespace autotests_utility_equipment
// Params 1
// Checksum 0x35b23a9c, Offset: 0x18a
// Size: 0x23, Type: bool
function function_431f880b3bd252a2( equipment_ref )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( equipment_ref );
    return isdefined( bundle );
}

// Namespace autotests_utility_equipment
// Params 4
// Checksum 0xe5fffe3c, Offset: 0x1b6
// Size: 0x225
function function_985cc981faf48b19( equipment_ref, location, attacker, var_523de7bd94592442 = 0.5 )
{
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    bundle = equipment_mp::function_c90a9aa89b223dd7( equipment_ref );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( ( bundle ? "Succeeded: " : "Failed: " ) + "No valid bundle found for equipment ref: " + equipment_ref, bundle, "scripts/autotests/mp/autotests_utility_equipment.gsc", 37 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( ( bundle.useweapon ? "Succeeded: " : "Failed: " ) + "No valid useWeapon found for equipment ref: " + equipment_ref, bundle.useweapon, "scripts/autotests/mp/autotests_utility_equipment.gsc", 39 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    currentweapon = makeweapon( bundle.useweapon );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( ( currentweapon ? "Succeeded: " : "Failed: " ) + "Could not MakeWeapon for equipment ref: " + equipment_ref, currentweapon, "scripts/autotests/mp/autotests_utility_equipment.gsc", 43 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    grenade = attacker weapon::_launchgrenade( currentweapon.basename, location, ( 0, 0, 0 ) );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( ( grenade ? "Succeeded: " : "Failed: " ) + "Could not launch grenade for equipment ref: " + equipment_ref, grenade, "scripts/autotests/mp/autotests_utility_equipment.gsc", 47 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    attacker weapons::grenadeinitialize( grenade, currentweapon, 0, attacker );
    attacker weapons::grenadeused( grenade );
    fuse_time = getgrenadefusetime( grenade.weapon_object );
    wait fuse_time * 0.001 + var_523de7bd94592442;
}

// Namespace autotests_utility_equipment
// Params 1
// Checksum 0x50a08014, Offset: 0x3e3
// Size: 0x102
function function_d7fbf95af74b10e9( testinglevel )
{
    var_546c558fca86f4fe = [];
    
    foreach ( equipment in level.equipment.table )
    {
        if ( equipment.ref == "none" )
        {
            continue;
        }
        
        if ( !autotests_utility::function_16e4b52e47772eb5( equipment.bundle, testinglevel ) )
        {
            continue;
        }
        
        if ( equipment.bundle.uislot == 1 || equipment.bundle.uislot == 2 )
        {
            var_546c558fca86f4fe[ var_546c558fca86f4fe.size ] = equipment;
        }
    }
    
    return var_546c558fca86f4fe;
}

