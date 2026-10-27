// scripts\mp\riotshield.gsc  (hash_0c5abf1cdb1bb1a5.gscc) (size: 2392 Bytes / 0x958 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x455e9525 (1163826469)
// size ...... 2392 (0x958)
// includes .. 1   (offset: 0x8a4)
// strings ... 4   (offset: 0x8ac)
// dev strs .. 8   (offset: 0x8f8)
// exports ... 11  (offset: 0x5b4)
// cseg ...... 0x97 + 0x51d (0x5b4)
// imports ... 9   (offset: 0x76c)
// animtree1 . 0   (offset: 0x958)
// animtree2 . 0   (offset: 0x958)
#using scripts\mp\common\utility\weapon_utility;

#namespace riotshield;

// Namespace riotshield
// Params 0
// Checksum 0x50082723, Offset: 0xb5
// Size: 0xad
function function_1d321a5b69a36090()
{
    weaponlist = self getweaponslistprimaries();
    shieldweapon = undefined;
    assert( !riotshield_hastwo(), "<dev string:x24>" );
    
    foreach ( weapon in weaponlist )
    {
        if ( weapon_utility::isriotshield( weapon ) )
        {
            shieldweapon = weapon;
            break;
        }
    }
    
    return shieldweapon;
}

// Namespace riotshield
// Params 0
// Checksum 0x4c7935fd, Offset: 0x16b
// Size: 0x8d, Type: bool
function riotshield_hasweapon()
{
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponlist )
    {
        if ( weapontype( weapon ) == "riotshield" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace riotshield
// Params 0
// Checksum 0xf02778d5, Offset: 0x201
// Size: 0xa3, Type: bool
function riotshield_hastwo()
{
    count = 0;
    weapons = self getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapontype( weapon ) == "riotshield" )
        {
            count++;
        }
        
        if ( count == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace riotshield
// Params 2
// Checksum 0x3701fcdd, Offset: 0x2ad
// Size: 0x8d
function riotshield_attach( onarm, modelshield )
{
    tagattach = undefined;
    
    if ( onarm )
    {
        assert( !isdefined( self.riotshieldmodel ), "<dev string:x8a>" );
        self.riotshieldmodel = modelshield;
        tagattach = "j_shield_ri";
    }
    else
    {
        assert( !isdefined( self.riotshieldmodelstowed ), "<dev string:xd4>" );
        self.riotshieldmodelstowed = modelshield;
        tagattach = "tag_shield_back";
    }
    
    self.hasriotshield = riotshield_hasweapon();
}

// Namespace riotshield
// Params 1
// Checksum 0xf9198a05, Offset: 0x342
// Size: 0xa9
function riotshield_detach( onarm )
{
    modelshield = undefined;
    tagdetach = undefined;
    
    if ( onarm )
    {
        assert( isdefined( self.riotshieldmodel ), "<dev string:x11a>" );
        modelshield = self.riotshieldmodel;
        tagdetach = "j_shield_ri";
    }
    else
    {
        assert( isdefined( self.riotshieldmodelstowed ), "<dev string:x160>" );
        modelshield = self.riotshieldmodelstowed;
        tagdetach = "tag_shield_back";
    }
    
    if ( onarm )
    {
        self.riotshieldmodel = undefined;
    }
    else
    {
        self.riotshieldmodelstowed = undefined;
    }
    
    self.hasriotshield = riotshield_hasweapon();
}

// Namespace riotshield
// Params 1
// Checksum 0x228fe32c, Offset: 0x3f3
// Size: 0xc9
function riotshield_move( fromarm )
{
    tagstart = undefined;
    tagend = undefined;
    modelshield = undefined;
    
    if ( fromarm )
    {
        assert( isdefined( self.riotshieldmodel ), "<dev string:x1a6>" );
        modelshield = self.riotshieldmodel;
        tagstart = "j_shield_ri";
        tagend = "tag_shield_back";
    }
    else
    {
        assert( isdefined( self.riotshieldmodelstowed ), "<dev string:x1ea>" );
        modelshield = self.riotshieldmodelstowed;
        tagstart = "tag_shield_back";
        tagend = "j_shield_ri";
    }
    
    if ( fromarm )
    {
        self.riotshieldmodelstowed = modelshield;
        self.riotshieldmodel = undefined;
        return;
    }
    
    self.riotshieldmodel = modelshield;
    self.riotshieldmodelstowed = undefined;
}

// Namespace riotshield
// Params 0
// Checksum 0xb5f17123, Offset: 0x4c4
// Size: 0x20
function riotshield_clear()
{
    self.hasriotshield = 0;
    self.riotshieldmodelstowed = undefined;
    self.riotshieldmodel = undefined;
}

// Namespace riotshield
// Params 0
// Checksum 0x54610ceb, Offset: 0x4ec
// Size: 0x9e
function riotshield_getmodel()
{
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponlist )
    {
        if ( weapon_utility::isriotshield( weapon ) )
        {
            return function_f470dac2408978f1( weapon );
        }
    }
    
    assertmsg( "<dev string:x22e>" );
    return "empty_model";
}

// Namespace riotshield
// Params 0
// Checksum 0x7f48d147, Offset: 0x593
// Size: 0xd
function setignoreriotshieldxp()
{
    self.ignoreriotshieldxp = 1;
}

// Namespace riotshield
// Params 0
// Checksum 0xf4fdef43, Offset: 0x5a8
// Size: 0xc
function clearignoreriotshieldxp()
{
    self.ignoreriotshieldxp = undefined;
}

