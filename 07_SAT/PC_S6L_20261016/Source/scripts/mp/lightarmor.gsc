// scripts\mp\lightarmor.gsc  (hash_3c56d7d289aaaf81.gscc) (size: 2246 Bytes / 0x8c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf61264ef (4128400623)
// size ...... 2246 (0x8c6)
// includes .. 2   (offset: 0x892)
// strings ... 2   (offset: 0x8a2)
// dev strs .. 1   (offset: 0x8ba)
// exports ... 12  (offset: 0x4e6)
// cseg ...... 0x73 + 0x473 (0x4e6)
// imports ... 15  (offset: 0x6c6)
// animtree1 . 0   (offset: 0x8c6)
// animtree2 . 0   (offset: 0x8c6)
#using scripts\mp\common\utility\weapon;
#using scripts\mp\heavyarmor;

#namespace lightarmor;

// Namespace lightarmor
// Params 1
// Checksum 0xe6392c0, Offset: 0x91
// Size: 0x16, Type: bool
function haslightarmor( player )
{
    return getlightarmorvalue( player ) > 0;
}

// Namespace lightarmor
// Params 1
// Checksum 0xa889e00f, Offset: 0xb0
// Size: 0x1b, Type: bool
function getlightarmorvalue( player )
{
    return player.lightarmorhp ?? 0;
}

// Namespace lightarmor
// Params 4
// Checksum 0xeee75f71, Offset: 0xd4
// Size: 0xf0
function setlightarmorvalue( player, value, overridegreater = 1, playvfx = 1 )
{
    if ( lightarmor_lightarmor_disabled( player ) )
    {
        value = 0;
        overridegreater = 1;
    }
    
    oldvalue = getlightarmorvalue( player );
    
    if ( !overridegreater && oldvalue > value )
    {
        value = oldvalue;
    }
    
    if ( oldvalue <= 0 && value > 0 )
    {
        lightarmor_set( player, value, playvfx );
        return;
    }
    
    if ( oldvalue > 0 && value <= 0 )
    {
        lightarmor_unset( player );
        return;
    }
    
    player.lightarmorhp = value;
    
    if ( isplayer( player ) && oldvalue <= value && value > 0 && playvfx == 1 )
    {
        thread lightarmor_setfx( player );
    }
    
    if ( isplayer( player ) )
    {
        lightarmor_updatehud( player );
    }
}

// Namespace lightarmor
// Params 0
// Checksum 0xbaea551d, Offset: 0x1cc
// Size: 0x2
function init()
{
    
}

// Namespace lightarmor
// Params 3
// Checksum 0x422bc15a, Offset: 0x1d6
// Size: 0x76
function lightarmor_set( player, value, playvfx )
{
    assert( isdefined( value ), "<dev string:x24>" );
    player notify( #"hash_cf9915148a054109" );
    player.lightarmorhp = value;
    lightarmor_updatehud( player );
    thread lightarmor_monitordeath( player );
    
    if ( isplayer( player ) && playvfx == 1 )
    {
        thread lightarmor_setfx( player );
    }
}

// Namespace lightarmor
// Params 1
// Checksum 0x9a6a5443, Offset: 0x254
// Size: 0x43
function lightarmor_unset( player )
{
    player notify( #"hash_544da6834aa65dc4" );
    player.lightarmorhp = undefined;
    lightarmor_updatehud( player );
    
    if ( isplayer( player ) )
    {
    }
    
    player notify( #"remove_light_armor" );
}

// Namespace lightarmor
// Params 11
// Checksum 0xedef244f, Offset: 0x29f
// Size: 0x19d
function lightarmor_modifydamage( victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query )
{
    ignorelightarmor = 0;
    damageblocked = 0;
    lightarmorhpmodified = victim.lightarmorhp;
    
    if ( !isdefined( query ) )
    {
        query = 1;
    }
    
    if ( !ignorelightarmor )
    {
        if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" )
        {
            ignorelightarmor = 1;
        }
    }
    
    if ( !ignorelightarmor )
    {
        if ( isexplosivedamagemod( smeansofdeath ) )
        {
            if ( isdefined( inflictor ) && inflictor.stuckenemyentity == victim )
            {
                ignorelightarmor = 1;
            }
        }
    }
    
    if ( !ignorelightarmor )
    {
        if ( weapon::issuperdamagesource( sweapon ) )
        {
            ignorelightarmor = 1;
        }
    }
    
    if ( !ignorelightarmor )
    {
        damageblocked = min( damage + damageadd, victim.lightarmorhp );
        lightarmorhpmodified -= damage + damageadd;
        
        if ( !query )
        {
            victim.lightarmorhp -= damage + damageadd;
        }
        
        damage = 0;
        damageadd = 0;
        
        if ( lightarmorhpmodified <= 0 )
        {
            damage = abs( lightarmorhpmodified );
            damageadd = 0;
            
            if ( !query )
            {
                lightarmor_unset( victim );
            }
        }
    }
    
    if ( !query )
    {
        lightarmor_updatehud( self );
    }
    
    if ( damageblocked > 0 && damage == 0 )
    {
        damage = 1;
    }
    
    return [ damageblocked, damage, damageadd ];
}

// Namespace lightarmor
// Params 1
// Checksum 0xce67d63a, Offset: 0x445
// Size: 0x1b, Type: bool
function lightarmor_lightarmor_disabled( player )
{
    if ( player heavyarmor::hasheavyarmor() )
    {
        return true;
    }
    
    return false;
}

// Namespace lightarmor
// Params 1
// Checksum 0xaabb97ad, Offset: 0x469
// Size: 0x4a
function lightarmor_monitordeath( player )
{
    player endon( #"disconnect" );
    player endon( #"hash_cf9915148a054109" );
    player endon( #"hash_544da6834aa65dc4" );
    player waittill( #"death" );
    thread lightarmor_unset( player );
}

// Namespace lightarmor
// Params 1
// Checksum 0x485e5c3b, Offset: 0x4bb
// Size: 0x17
function lightarmor_updatehud( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
}

// Namespace lightarmor
// Params 1
// Checksum 0xddec4a1b, Offset: 0x4da
// Size: 0xc
function lightarmor_setfx( player )
{
    
}

