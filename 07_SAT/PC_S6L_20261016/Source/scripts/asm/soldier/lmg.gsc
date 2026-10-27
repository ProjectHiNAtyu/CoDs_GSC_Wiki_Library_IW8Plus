// scripts\asm\soldier\lmg.gsc  (hash_793ed8a24e515d55.gscc) (size: 4950 Bytes / 0x1356 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1af965a6 (452552102)
// size ...... 4950 (0x1356)
// includes .. 5   (offset: 0x12a2)
// strings ... 10  (offset: 0x12ca)
// dev strs .. 1   (offset: 0x134a)
// exports ... 17  (offset: 0xb2e)
// cseg ...... 0xdb + 0xa53 (0xb2e)
// imports ... 40  (offset: 0xdd6)
// animtree1 . 0   (offset: 0x1356)
// animtree2 . 0   (offset: 0x1356)
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;

#namespace lmg;

// Namespace lmg
// Params 3
// Checksum 0xf5b7d0c6, Offset: 0xf9
// Size: 0x53
function playcovercrouchlmg( asmname, statename, params )
{
    self._blackboard.droppedlmg = 0;
    thread asm::asm_playanimstate( asmname, statename );
    self.rightaimlimit = -80;
    self.leftaimlimit = 80;
}

// Namespace lmg
// Params 3
// Checksum 0x20349afd, Offset: 0x154
// Size: 0x10e
function coverturretterminate( asmname, statename, params )
{
    self setdefaultaimlimits();
    currentturret = self getturret();
    
    if ( !isdefined( currentturret ) || currentturret == self.asm.turret )
    {
        self stopuseturret();
    }
    
    if ( isdefined( self.asm.turret ) )
    {
        self.asm.turret.origin = self.asm.turretorigin;
        self.asm.turret.angles = self.asm.turretangles;
    }
    
    self.asm.turret = undefined;
    self.asm.turretorigin = undefined;
    self.asm.turretangles = undefined;
}

// Namespace lmg
// Params 3
// Checksum 0x8ab731b6, Offset: 0x26a
// Size: 0x2a
function coverlmgterminate( asmname, statename, params )
{
    self function_b389a72141b859b0();
    self setdefaultaimlimits();
}

// Namespace lmg
// Params 3
// Checksum 0x5f37bc30, Offset: 0x29c
// Size: 0xb4
function playanim_droplmg( asmname, statename, params )
{
    shared::dropaiweapon();
    
    if ( !isnullweapon( self.sidearm ) )
    {
        self.weapon = self.sidearm;
        self.bulletsinclip = weaponclipsize( self.weapon );
        shared::updateweaponarchetype( weaponclass( self.weapon ) );
    }
    else
    {
        shared::updateweaponarchetype( "null" );
    }
    
    self._blackboard.inlmgstate = 0;
    self._blackboard.deployedlmgnode = undefined;
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace lmg
// Params 4
// Checksum 0x38fb5517, Offset: 0x358
// Size: 0x2e, Type: bool
function turretrequested( asmname, statename, tostatename, params )
{
    return isdefined( asm_bb::bb_getrequestedturret() );
}

// Namespace lmg
// Params 3
// Checksum 0xab5a1e65, Offset: 0x38f
// Size: 0xa3
function chooseanim_deploylmg( asmname, statename, params )
{
    if ( isnode( self.node ) )
    {
        if ( ismurderhole( self.node ) )
        {
            self function_630eac6fd6900a61( %"cover_murderhole" );
        }
        
        if ( self._blackboard.droppedlmg )
        {
            assert( self.node == self._blackboard.deployedlmgnode );
            return asm::asm_lookupanimfromalias( statename, "remount" );
        }
    }
    
    return asm::asm_lookupanimfromalias( statename, "default" );
}

// Namespace lmg
// Params 3
// Checksum 0xc0e8c485, Offset: 0x43b
// Size: 0xf7
function playanim_deployturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 1;
    assert( isdefined( asm_bb::bb_getrequestedturret() ) );
    turret = asm_bb::bb_getrequestedturret();
    assert( distancesquared( turret.origin, self.origin ) < 4096 );
    assert( !isdefined( self.customnotetrackhandler ) );
    asm::asm_playanimstatenotransition( asmname, statename, params );
    self.asm.turretorigin = turret.origin;
    self.asm.turretangles = turret.angles;
    self.asm.turret = turret;
    self useturret( asm_bb::bb_getrequestedturret() );
}

// Namespace lmg
// Params 3
// Checksum 0xed4b07d8, Offset: 0x53a
// Size: 0xec
function noanim_deployturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 1;
    assert( isdefined( asm_bb::bb_getrequestedturret() ) );
    turret = asm_bb::bb_getrequestedturret();
    assert( distancesquared( turret.origin, self.origin ) < 4096 );
    assert( !isdefined( self.customnotetrackhandler ) );
    self.asm.turretorigin = turret.origin;
    self.asm.turretangles = turret.angles;
    self.asm.turret = turret;
    self useturret( asm_bb::bb_getrequestedturret() );
}

// Namespace lmg
// Params 3
// Checksum 0x4d3b0e3f, Offset: 0x62e
// Size: 0x3e
function playanim_dismountturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 0;
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace lmg
// Params 4
// Checksum 0xf940d2c6, Offset: 0x674
// Size: 0xbc
function shoulddismountlmg( asmname, statename, tostatename, params )
{
    if ( self._blackboard.usingaturret )
    {
        turret = self getturret();
        requestedturret = asm_bb::bb_getrequestedturret();
        usingturret = isdefined( turret ) && turret getturretowner() == self;
        usingrequestedturret = usingturret && requestedturret == turret;
        return !usingrequestedturret;
    }
    
    moverequested = asm_bb::bb_moverequested();
    atcovernode = utility::isatcovernode();
    return moverequested || !atcovernode;
}

// Namespace lmg
// Params 3
// Checksum 0x2ccd3d40, Offset: 0x738
// Size: 0x1a7
function playanim_deploylmg( asmname, statename, params )
{
    if ( isdefined( self.node ) )
    {
        self._blackboard.deployedlmgnode = self.node;
        self.keepclaimednodeifvalid = 1;
    }
    
    assert( !isdefined( self.customnotetrackhandler ) );
    self.customnotetrackhandler = &notehandler_deploylmg;
    self._blackboard.inlmgstate = 1;
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    
    if ( isdefined( self.node ) )
    {
        if ( self._blackboard.droppedlmg )
        {
            self forceteleport( self.node.origin, self.angles );
            self orientmode( "face angle", self.node.angles[ 1 ] );
        }
        else
        {
            animangle = getangledelta( xanim );
            desiredyaw = self.node.angles[ 1 ] - animangle;
            self orientmode( "face angle", desiredyaw );
        }
    }
    else
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    self endon( statename + "_finished" );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, xanim );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace lmg
// Params 3
// Checksum 0x29961ea1, Offset: 0x8e7
// Size: 0x28
function terminate_deploylmg( asmname, statename, params )
{
    self.customnotetrackhandler = undefined;
}

// Namespace lmg
// Params 3
// Checksum 0x79e5e594, Offset: 0x917
// Size: 0x57
function playanim_dismountlmg( asmname, statename, params )
{
    self function_630eac6fd6900a61( undefined );
    self._blackboard.deployedlmgnode = undefined;
    self._blackboard.inlmgstate = 0;
    asm::asm_playanimstate( asmname, statename );
}

// Namespace lmg
// Params 4
// Checksum 0xb1992cdf, Offset: 0x976
// Size: 0xdb
function notehandler_deploylmg( note, flagname, customfunction, customparams )
{
    switch ( note )
    {
        case #"hash_187a1588294dd34e":
            shared::placeweaponon( self.weapon, "none" );
            break;
        case #"hash_c24ff1dd3ebd3f6c":
            assert( isdefined( self._blackboard.leftweaponent ) );
            self._blackboard.leftweaponent delete();
            self._blackboard.leftweaponent = undefined;
            assert( weaponclass( self.primaryweapon ) == "<dev string:x24>" );
            shared::placeweaponon( self.primaryweapon, "right" );
            break;
    }
}

// Namespace lmg
// Params 4
// Checksum 0x9a60b50, Offset: 0xa59
// Size: 0x6a, Type: bool
function lowestcoverstanddeployposeis( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    
    if ( isdefined( self.node ) )
    {
        if ( !self.node utility::isvalidpeekoutdir( "over" ) )
        {
            return ( params == "high" );
        }
        
        return ( params == "stand" );
    }
    
    return false;
}

// Namespace lmg
// Params 4
// Checksum 0x7250cb71, Offset: 0xacc
// Size: 0x61, Type: bool
function desiredturretposeis( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    
    if ( isdefined( self._blackboard.requestedturretpose ) )
    {
        return ( self._blackboard.requestedturretpose == params );
    }
    
    return false;
}

