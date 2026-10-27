// scripts\mp\common\utility\inventory.gsc  (hash_376710f138a3aae7.gscc) (size: 2118 Bytes / 0x846 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd21f6623 (3525273123)
// size ...... 2118 (0x846)
// includes .. 3   (offset: 0x7fa)
// strings ... 2   (offset: 0x812)
// dev strs .. 2   (offset: 0x82e)
// exports ... 7   (offset: 0x52a)
// cseg ...... 0x6d + 0x4bd (0x52a)
// imports ... 15  (offset: 0x642)
// animtree1 . 0   (offset: 0x846)
// animtree2 . 0   (offset: 0x846)
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\juggernaut;

#namespace inventory;

// Namespace inventory
// Params 0
// Checksum 0x69c50654, Offset: 0x8b
// Size: 0x1d
function getlastweapon()
{
    assert( isdefined( self.lastnormalweaponobj ) );
    return self.lastnormalweaponobj;
}

// Namespace inventory
// Params 0
// Checksum 0x30cbe0c0, Offset: 0xb1
// Size: 0x62
function switchtolastweapon()
{
    if ( !isai( self ) )
    {
        lastweaponobj = getlastweapon();
        
        if ( killstreak::isjuggernaut() )
        {
            lastweaponobj = juggernaut::jugg_getminigunweapon();
        }
        else if ( !self hasweapon( lastweaponobj ) )
        {
            lastweaponobj = getfirstprimaryweapon();
        }
        
        if ( isdefined( lastweaponobj ) )
        {
            inventory_utility::_switchtoweapon( lastweaponobj );
        }
        
        return;
    }
    
    inventory_utility::_switchtoweapon( "none" );
}

// Namespace inventory
// Params 0
// Checksum 0x32c20dca, Offset: 0x11b
// Size: 0x60
function getfirstprimaryweapon()
{
    weaponslist = self getweaponslistprimaries();
    
    if ( isdefined( self.pers[ "altStates" ] ) && weaponslist.size > 0 )
    {
        var_bda53394c108f2e = getcompleteweaponname( weaponslist[ 0 ] );
        
        if ( self.pers[ "altStates" ][ var_bda53394c108f2e ] )
        {
            return weaponslist[ 0 ] getaltweapon();
        }
    }
    
    return weaponslist[ 0 ];
}

// Namespace inventory
// Params 3
// Checksum 0x39b54803, Offset: 0x184
// Size: 0x212
function registerweaponchangecallback( callbackfunc, isoneshot, var_abb0840fbf1202e0 )
{
    data = self.weaponchangecallbacks;
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
        self.weaponchangecallbacks = data;
        data.nextid = 1;
        data.nextoneshotid = -1;
        data.callbacks = [];
        data.oneshotcallbacks = [];
        data.persistentcallbacks = [];
    }
    
    id = undefined;
    
    if ( isoneshot )
    {
        /#
            foreach ( oneshotcallback in data.oneshotcallbacks )
            {
                assert( oneshotcallback != callbackfunc, "<dev string:x24>" );
            }
        #/
        
        id = data.nextoneshotid;
        data.nextoneshotid--;
        data.oneshotcallbacks[ id ] = callbackfunc;
    }
    else
    {
        /#
            foreach ( othercallback in data.callbacks )
            {
                assert( othercallback != callbackfunc, "<dev string:x6f>" );
            }
        #/
        
        id = data.nextid;
        data.nextid++;
        data.callbacks[ id ] = callbackfunc;
    }
    
    if ( var_abb0840fbf1202e0 )
    {
        data.persistentcallbacks[ id ] = id;
    }
    
    return id;
}

// Namespace inventory
// Params 1
// Checksum 0x2510486d, Offset: 0x39f
// Size: 0x52
function unregisterweaponchangecallback( id )
{
    data = self.weaponchangecallbacks;
    assert( isdefined( data ) );
    
    if ( id < 0 )
    {
        data.oneshotcallbacks[ id ] = undefined;
        return;
    }
    
    data.callbacks[ id ] = undefined;
}

// Namespace inventory
// Params 0
// Checksum 0x5d8b83b9, Offset: 0x3f9
// Size: 0x131
function handleweaponchangecallbacksondeath()
{
    data = self.weaponchangecallbacks;
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    foreach ( id, callback in data.callbacks )
    {
        if ( !isdefined( data.persistentcallbacks[ id ] ) )
        {
            data.callbacks[ id ] = undefined;
        }
    }
    
    foreach ( id, callback in data.oneshotcallbacks )
    {
        if ( !isdefined( data.persistentcallbacks[ id ] ) )
        {
            data.oneshotcallbacks[ id ] = undefined;
        }
    }
}

