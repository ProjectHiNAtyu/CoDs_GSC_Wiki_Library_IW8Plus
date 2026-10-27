// scripts\mp\heavyarmor.gsc  (hash_5242c074cd388a30.gscc) (size: 2536 Bytes / 0x9e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a0c4cfd (1779191037)
// size ...... 2536 (0x9e8)
// includes .. 3   (offset: 0x9a0)
// strings ... 4   (offset: 0x9b8)
// dev strs .. 0   (offset: 0x9e8)
// exports ... 10  (offset: 0x62c)
// cseg ...... 0x92 + 0x59a (0x62c)
// imports ... 17  (offset: 0x7bc)
// animtree1 . 0   (offset: 0x9e8)
// animtree2 . 0   (offset: 0x9e8)
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\weapon;

#namespace heavyarmor;

// Namespace heavyarmor
// Params 1
// Checksum 0xe3316094, Offset: 0xb0
// Size: 0x8b
function addheavyarmor( value )
{
    if ( !isdefined( self.heavyarmor ) )
    {
        self.heavyarmor = spawnstruct();
        self.heavyarmor.player = self;
        self.heavyarmor.hp = value;
        self notify( #"heavyarmor_added" );
        return;
    }
    
    self.heavyarmor.hp += value;
}

// Namespace heavyarmor
// Params 1
// Checksum 0x5df168ca, Offset: 0x143
// Size: 0xa1
function subtractheavyarmor( value )
{
    assert( isdefined( self.heavyarmor ) && self.heavyarmor.hp > 0 );
    struct = self.heavyarmor;
    
    if ( struct.immunityframe )
    {
        return;
    }
    
    if ( struct.hp > 0 )
    {
        struct.hp = max( 0, struct.hp - value );
        
        if ( struct.hp <= 0 )
        {
            thread heavyarmor_break();
        }
    }
}

// Namespace heavyarmor
// Params 0
// Checksum 0xbd149f4f, Offset: 0x1ec
// Size: 0x2a
function removeheavyarmor()
{
    assert( isdefined( self.heavyarmor ) );
    self notify( #"heavyarmor_removed" );
    self.heavyarmor = undefined;
}

// Namespace heavyarmor
// Params 11
// Checksum 0x4714ec7c, Offset: 0x21e
// Size: 0x1e3
function heavyarmormodifydamage( victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query )
{
    if ( damage <= 0 && damageadd <= 0 )
    {
        return [ 0, damage, damageadd ];
    }
    
    if ( smeansofdeath == "MOD_SUICIDE" )
    {
        return [ 0, damage, damageadd ];
    }
    
    if ( isdefined( attacker ) && ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" ) )
    {
        return [ 0, damage, damageadd ];
    }
    
    if ( !victim hasheavyarmor() )
    {
        return [ 0, damage, damageadd ];
    }
    
    if ( weapon::isbombsiteweapon( sweapon ) )
    {
        return [ 0, damage, damageadd ];
    }
    
    if ( victim hasheavyarmorinvulnerability() )
    {
        return [ 1, 1, 0 ];
    }
    
    var_b108ae86e81917c3 = victim getheavyarmor();
    modifier = heavyarmor_getdamagemodifier( victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query );
    modifieddamage = damage * modifier;
    modifieddamageadd = damageadd * modifier;
    modifieddamageblocked = modifieddamage + modifieddamageadd;
    
    if ( !query )
    {
        victim subtractheavyarmor( modifieddamageblocked );
    }
    
    if ( victim hasheavyarmorinvulnerability() )
    {
        return [ var_b108ae86e81917c3, 1, 0 ];
    }
    
    return [ damage + damageadd, 1, 0 ];
}

// Namespace heavyarmor
// Params 0
// Checksum 0x8571a66, Offset: 0x40a
// Size: 0x21
function getheavyarmor()
{
    if ( !hasheavyarmor() )
    {
        return 0;
    }
    
    return self.heavyarmor.hp;
}

// Namespace heavyarmor
// Params 0
// Checksum 0xaf488b7a, Offset: 0x434
// Size: 0x2e, Type: bool
function hasheavyarmor()
{
    return self.heavyarmor.hp > 0 || self.heavyarmor.invulnerabilityframe;
}

// Namespace heavyarmor
// Params 0
// Checksum 0x4976ca2d, Offset: 0x46b
// Size: 0x16, Type: bool
function hasheavyarmorinvulnerability()
{
    return istrue( self.heavyarmor.invulnerabilityframe );
}

// Namespace heavyarmor
// Params 0
// Checksum 0x2adb7c8d, Offset: 0x48a
// Size: 0x4e
function heavyarmor_break()
{
    self endon( #"disconnect" );
    self endon( #"heavyarmor_removed" );
    
    if ( !game_utility_mp::isanymlgmatch() )
    {
        self.heavyarmor.invulnerabilityframe = 1;
    }
    
    self notify( #"heavyarmor_broken" );
    waittillframeend();
    thread removeheavyarmor();
}

// Namespace heavyarmor
// Params 11
// Checksum 0x344c88d8, Offset: 0x4e0
// Size: 0x14b
function heavyarmor_getdamagemodifier( victim, attacker, damage, damageadd, smeansofdeath, sweapon, impactpoint, impactdir, shitloc, inflictor, query )
{
    modifiers = [];
    
    if ( weapon::issuperweapon( sweapon ) )
    {
        modifiers[ modifiers.size ] = 1.33;
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        modifiers[ modifiers.size ] = 1.5;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        modifiers[ modifiers.size ] = 1.5;
    }
    
    if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
    {
        modifiers[ modifiers.size ] = 1.5;
    }
    
    bestmodifier = 1;
    
    foreach ( modifier in modifiers )
    {
        if ( modifier > bestmodifier )
        {
            modifier = bestmodifier;
        }
    }
    
    return bestmodifier;
}

