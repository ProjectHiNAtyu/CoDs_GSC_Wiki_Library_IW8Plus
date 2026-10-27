// scripts\asm\soldier\grenade_response.gsc  (hash_4482ef346d9a8971.gscc) (size: 3008 Bytes / 0xbc0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17b8ef75 (397995893)
// size ...... 3008 (0xbc0)
// includes .. 2   (offset: 0xae4)
// strings ... 16  (offset: 0xaf4)
// dev strs .. 0   (offset: 0xbc0)
// exports ... 8   (offset: 0x684)
// cseg ...... 0x13d + 0x547 (0x684)
// imports ... 27  (offset: 0x7c4)
// animtree1 . 0   (offset: 0xbc0)
// animtree2 . 0   (offset: 0xbc0)
#using scripts\anim\shared;
#using scripts\asm\asm;

#namespace grenade_response;

// Namespace grenade_response
// Params 3
// Checksum 0x31198a56, Offset: 0x15b
// Size: 0x200
function playgrenadereturnthrowanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    throwanim = asm::asm_getanim( asmname, statename );
    throwxanim = asm::asm_getxanim( statename, throwanim );
    self animmode( "zonly_physics" );
    
    if ( isdefined( self.grenade ) && distancesquared( self.grenade.origin, self.origin ) > 36 )
    {
        self orientmode( "face angle", vectortoyaw( self.grenade.origin - self.origin ) );
    }
    
    self aisetanim( statename, throwanim );
    var_d7dc30ad9015a913 = animhasnotetrack( throwxanim, "grenade_left" );
    var_17c2051a3138e71c = animhasnotetrack( throwxanim, "grenade_right" );
    var_3ccb0ddc5c7936bc = var_d7dc30ad9015a913 || var_17c2051a3138e71c;
    
    if ( var_3ccb0ddc5c7936bc )
    {
        shared::placeweaponon( self.weapon, "left" );
        thread asm::asm_donotetracks( asmname, statename );
        
        if ( var_d7dc30ad9015a913 )
        {
            self waittillmatch( statename, #"grenade_left" );
        }
        else
        {
            self waittillmatch( statename, #"grenade_right" );
        }
        
        self pickupgrenade();
        addbattlechatternotify( self, undefined, "use", "frag_grenade" );
        grenadevel = self getgrenadetossvel();
        
        if ( isdefined( grenadevel ) )
        {
            grenadeangle = vectortoyaw( grenadevel );
            self orientmode( "face angle", grenadeangle );
        }
        
        self waittillmatch( statename, #"grenade_throw" );
    }
    else
    {
        thread asm::asm_donotetracks( asmname, statename );
        self waittillmatch( statename, #"grenade_throw" );
        self pickupgrenade();
        addbattlechatternotify( self, undefined, "use", "frag_grenade" );
    }
    
    if ( isdefined( self.grenade ) )
    {
        self throwgrenade();
    }
    
    wait 1;
    self notify( #"killanimscript" );
}

// Namespace grenade_response
// Params 3
// Checksum 0x68abe74, Offset: 0x363
// Size: 0x6d
function terminategrenadereturnthrowanim( asmname, statename, params )
{
    asm::asm_fireephemeralevent( "grenade_response", "return throw complete" );
    shared::placeweaponon( self.weapon, "right" );
    
    if ( isdefined( self.oldgrenadeweapon ) )
    {
        self.grenadeweapon = self.oldgrenadeweapon;
        self.oldgrenadeweapon = undefined;
    }
}

// Namespace grenade_response
// Params 0
// Checksum 0xeef1f7bd, Offset: 0x3d8
// Size: 0x5b
function islowthrowsafe()
{
    start = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 20 );
    end = start + anglestoforward( self.angles ) * 50;
    return sighttracepassed( start, end, 0, undefined );
}

// Namespace grenade_response
// Params 3
// Checksum 0xbe81e091, Offset: 0x43c
// Size: 0xa4
function choosegrenadereturnthrowanim( asmname, statename, params )
{
    throwdist = 1000;
    
    if ( isdefined( self.enemy ) )
    {
        throwdist = distance( self.origin, self.enemy.origin );
    }
    
    if ( throwdist < 600 && islowthrowsafe() )
    {
        if ( throwdist < 300 )
        {
            return asm::asm_lookupanimfromalias( statename, "throw_short" );
        }
        else
        {
            return asm::asm_lookupanimfromalias( statename, "throw_long" );
        }
    }
    
    return asm::asm_lookupanimfromalias( statename, "throw_default" );
}

// Namespace grenade_response
// Params 3
// Checksum 0x9976a00d, Offset: 0x4e9
// Size: 0x3b
function playgrenadeavoidanim( asmname, statename, params )
{
    self.asm.bshouldattemptdive = randomint( 100 ) > 50;
}

// Namespace grenade_response
// Params 4
// Checksum 0xcd236571, Offset: 0x52c
// Size: 0x11e, Type: bool
function shouldgrenadedive( asmname, statename, tostatename, params )
{
    if ( !self.asm.bshouldattemptdive )
    {
        return false;
    }
    
    if ( self.currentpose != "stand" )
    {
        return false;
    }
    
    if ( !isdefined( self.grenade ) )
    {
        return false;
    }
    
    var_ba0732f6d1b27284 = 0;
    var_ba0732f6d1b27284 = angleclamp180( vectortoangles( self.grenade.origin - self.origin )[ 1 ] - self.angles[ 1 ] );
    
    if ( abs( var_ba0732f6d1b27284 ) < 90 && params == "backward" )
    {
        return false;
    }
    
    diveanim = asm::asm_getanim( asmname, tostatename );
    divexanim = asm::asm_getxanim( tostatename, diveanim );
    moveby = getmovedelta( divexanim, 0, 0.5 );
    divetopos = self localtoworldcoords( moveby );
    
    if ( !self maymovetopoint( divetopos ) )
    {
        return false;
    }
    
    return true;
}

// Namespace grenade_response
// Params 3
// Checksum 0xc0084717, Offset: 0x653
// Size: 0x31
function grenadeavoid_terminate( asmname, statename, params )
{
    self.asm.bshouldattemptdive = undefined;
}

