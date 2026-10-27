// scripts\asm\soldier\pain.gsc  (hash_3d342fd57d1ab889.gscc) (size: 18818 Bytes / 0x4982 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x271ad0ce (656068814)
// size ...... 18818 (0x4982)
// includes .. 9   (offset: 0x42ee)
// strings ... 89  (offset: 0x4336)
// dev strs .. 0   (offset: 0x4982)
// exports ... 66  (offset: 0x2b42)
// cseg ...... 0x5aa + 0x2598 (0x2b42)
// imports ... 99  (offset: 0x3592)
// animtree1 . 0   (offset: 0x4982)
// animtree2 . 0   (offset: 0x4982)
#using scripts\anim\battlechatter_events;
#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;

#namespace pain;

// Namespace pain
// Params 4
// Checksum 0x200b1fa3, Offset: 0x5c8
// Size: 0x4b
function isdamagelocation_rarm( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "right_arm_upper", "right_arm_lower", "right_hand" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0x23689a64, Offset: 0x61c
// Size: 0x4b
function isdamagelocation_rleg( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "right_leg_upper", "right_foot", "right_leg_lower" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0x3c1caada, Offset: 0x670
// Size: 0x4b
function isdamagelocation_lleg( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "left_leg_upper", "left_foot", "left_leg_lower" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0x3f7f2f1d, Offset: 0x6c4
// Size: 0x4b
function isdamagelocation_larm( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "left_arm_upper", "left_arm_lower", "left_hand" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0xf1fa40d6, Offset: 0x718
// Size: 0x46
function isdamagelocation_torso( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "torso_upper", "torso_lower" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0x324fb836, Offset: 0x767
// Size: 0x4b
function isdamagelocation_head( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return utility::damagelocationisany( "head", "neck", "helmet" );
    }
    
    return 0;
}

// Namespace pain
// Params 4
// Checksum 0xcf384ce7, Offset: 0x7bb
// Size: 0x50
function isdamagelocation_larmcrouch( asmname, statename, tostatename, params )
{
    return utility::damagelocationisany( "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower" );
}

// Namespace pain
// Params 4
// Checksum 0x1341bc9f, Offset: 0x814
// Size: 0x6d, Type: bool
function isdamagelocation_back( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        if ( utility::gethumandamagedirstring() == 1 && !utility::damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace pain
// Params 4
// Checksum 0x2aa18ae, Offset: 0x88a
// Size: 0x69
function isdamagelocation_torsocovercrouch( asmname, statename, tostatename, params )
{
    return utility::damagelocationisany( "right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot" );
}

// Namespace pain
// Params 3
// Checksum 0xa7e2af70, Offset: 0x8fc
// Size: 0x35
function choosepainanimshock( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, "shock_loop_" + self.currentpose );
}

// Namespace pain
// Params 0
// Checksum 0xbc9c5709, Offset: 0x93a
// Size: 0x2
function playsonicshockfx()
{
    
}

// Namespace pain
// Params 3
// Checksum 0xa1682a98, Offset: 0x944
// Size: 0x112
function playshockpainloop( asmname, statename, params )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    painanim = asm::asm_getanim( asmname, statename );
    loop_time = self.empstuntime ?? 3.5;
    playsonicshockfx();
    self animmode( "zonly_physics" );
    wait randomfloat( 0.3 );
    
    if ( self.asmname == "c6" || self.asmname == "c6_worker" )
    {
        thread shockpainloop_internal( self.asmname, statename, 1, 0, 1 );
        self playsound( "generic_flashbang_c6_1" );
    }
    else
    {
        thread shockpainloop_internal( self.asmname, statename, 1, 0 );
    }
    
    wait loop_time;
    self notify( #"painloop_end" );
    asm::asm_fireevent( asmname, "stop_loop_pain" );
    self.emplooptime = undefined;
    finishpain( asmname, statename, params );
}

// Namespace pain
// Params 3
// Checksum 0x2631c186, Offset: 0xa5e
// Size: 0x24
function shockpainloop_c6_cleanup( asmname, statename, params )
{
    self stopsounds();
}

// Namespace pain
// Params 5
// Checksum 0x1e1325b2, Offset: 0xa8a
// Size: 0xf2
function shockpainloop_internal( asmname, statename, playbackrate, ismovestate, allowrandom )
{
    self endon( statename + "_finished" );
    self endon( #"painloop_end" );
    
    if ( ismovestate )
    {
        moveknob = asm::asm_lookupanimfromaliasifexists( "knobs", "move" );
        
        if ( isdefined( moveknob ) )
        {
            self setmoveanimknob( moveknob );
        }
    }
    
    prevanim = asm::asm_getbodyknob();
    curanim = asm::asm_getanim( asmname, statename );
    
    while ( true )
    {
        if ( isdefined( allowrandom ) )
        {
            curanim = asm::asm_getanim( asmname, statename );
        }
        
        curxanim = asm::asm_getxanim( statename, curanim );
        self aisetanim( statename, curanim, playbackrate );
        asm::asm_playfacialanim( asmname, statename, curxanim );
        prevanim = curanim;
        asm::asm_donotetrackssingleloop( asmname, statename, curxanim, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain
// Params 3
// Checksum 0x4c512a8e, Offset: 0xb84
// Size: 0x35
function chooseshockpainrecovery( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, "shock_finish_" + self.currentpose );
}

// Namespace pain
// Params 3
// Checksum 0x74ca991, Offset: 0xbc2
// Size: 0x2a
function playpainanim( asmname, statename, params )
{
    playpainaniminternal( asmname, statename, params, 0 );
}

// Namespace pain
// Params 3
// Checksum 0x662da76c, Offset: 0xbf4
// Size: 0x2b
function playpainanimwithadditives( asmname, statename, params )
{
    playpainaniminternal( asmname, statename, params, 1 );
}

// Namespace pain
// Params 3
// Checksum 0xa277a573, Offset: 0xc27
// Size: 0x40
function playpainanimlmg( asmname, statename, params )
{
    self._blackboard.inlmgstate = 1;
    playpainaniminternal( asmname, statename, params, 0 );
}

// Namespace pain
// Params 2
// Checksum 0xb7ece8e7, Offset: 0xc6f
// Size: 0x23
function pain_can_use_handler( note, params )
{
    if ( note == "pain_can_end" )
    {
        return 1;
    }
}

// Namespace pain
// Params 0
// Checksum 0xaf9f55b1, Offset: 0xc9a
// Size: 0x142
function getpainweaponsize()
{
    size = "_md";
    weaponsize = "rifle";
    objweapon = self.damageweapon;
    
    if ( isdefined( objweapon ) && objweapon.basename != "iw8_sn_mike14" )
    {
        weaponsize = objweapon.classname;
    }
    
    if ( weaponsize == "pistol" || weaponsize == "smg" )
    {
        size = "_md";
    }
    else if ( weaponsize == "spread" )
    {
        size = "_md";
        
        if ( isdefined( self.lastattacker ) && distancesquared( self.lastattacker.origin, self.origin ) <= 62500 )
        {
            size = "_lg";
        }
    }
    else if ( weaponsize == "sniper" || weaponsize == "mg" )
    {
        size = "_lg";
    }
    else if ( weaponsize == "grenade" && isdefined( self.damagemod ) && self.damagemod == "MOD_IMPACT" )
    {
        size = "_lg";
    }
    
    if ( isdefined( level.fnasmsoldiergetpainweaponsize ) )
    {
        size = self [[ level.fnasmsoldiergetpainweaponsize ]]( size );
    }
    
    return size;
}

// Namespace pain
// Params 0
// Checksum 0xac4a0c5f, Offset: 0xde5
// Size: 0x9a
function getpaindirectiontoactor()
{
    if ( self.damageyaw >= -45 && self.damageyaw <= 45 )
    {
        dir = "_b";
        return dir;
    }
    
    if ( self.damageyaw < -45 && self.damageyaw > -135 )
    {
        dir = "_l";
        return dir;
    }
    
    if ( self.damageyaw > 45 && self.damageyaw < 135 )
    {
        dir = "_r";
        return dir;
    }
    
    dir = "_f";
    return dir;
}

// Namespace pain
// Params 3
// Checksum 0xf98d2735, Offset: 0xe87
// Size: 0x53
function choosedirectionalpainanim_transition( asmname, statename, params )
{
    if ( isdefined( self.var_a82df882e2a61d97 ) )
    {
        var_f0bc2e0ac08694f3 = self.var_a82df882e2a61d97;
        return asm::asm_lookupanimfromalias( statename, var_f0bc2e0ac08694f3 );
    }
    
    return asm::asm_getrandomanim( asmname, statename );
}

// Namespace pain
// Params 8
// Checksum 0x5dd1eee9, Offset: 0xee3
// Size: 0x281
function playpainaniminternal( asmname, statename, params, shouldplayadditives, var_ccc36424805a94f2, statenameoverride, dontsetorientmode, var_9460a944b35e984 )
{
    self endon( statename + "_finished" );
    self.var_3b3c56eeb617f219 = 1;
    
    if ( isdefined( self.a.paintime ) )
    {
        self.a.lastpaintime = self.a.paintime;
    }
    else
    {
        self.a.lastpaintime = 0;
    }
    
    self.a.paintime = gettime();
    
    if ( self.stairsstate != "none" )
    {
        self.a.painonstairs = 1;
    }
    else
    {
        self.a.painonstairs = undefined;
    }
    
    self.a.painplaying = 1;
    
    if ( isdefined( self.painfunction ) )
    {
        shouldcontinue = [[ self.painfunction ]]();
        
        if ( !shouldcontinue )
        {
            self.a.painplaying = undefined;
            return;
        }
    }
    
    self animmode( "gravity" );
    
    if ( !dontsetorientmode )
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    if ( !isdefined( self.no_pain_sound ) )
    {
        face::saygenericdialogue( "pain" );
    }
    
    if ( death::shouldhelmetpoponpain( utility::wasdamagedbyexplosive() ) )
    {
        death::helmetpop();
    }
    
    animstatename = statename;
    
    if ( isdefined( statenameoverride ) )
    {
        animstatename = statenameoverride;
    }
    
    painanim = asm::asm_getanim( asmname, statename, params );
    assert( isdefined( painanim ) );
    self aisetanim( animstatename, painanim );
    painxanim = asm::asm_getxanim( animstatename, painanim );
    asm::asm_playfacialanim( asmname, statename, painxanim );
    
    if ( isdefined( var_9460a944b35e984 ) )
    {
        self thread [[ var_9460a944b35e984 ]]( asmname, statename, painanim, painxanim );
    }
    
    self.requestdifferentcover = 1;
    
    if ( animhasnotetrack( painxanim, "code_move" ) )
    {
        asm::asm_donotetracks( asmname, statename, undefined, undefined, animstatename );
    }
    
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), undefined, animstatename );
    
    if ( var_ccc36424805a94f2 )
    {
        finishpain( asmname, statename, params );
        return;
    }
    
    finishpain( asmname, statename );
}

// Namespace pain
// Params 2
// Checksum 0xd17ce66e, Offset: 0x116c
// Size: 0x2e
function paincanend( statename, notename )
{
    switch ( notename )
    {
        case #"hash_b28f889d3f68dd76":
            return 1;
    }
}

// Namespace pain
// Params 3
// Checksum 0x8680cca5, Offset: 0x11a2
// Size: 0x42
function coverexppainselectreturna( asmname, statename, params )
{
    if ( self._blackboard.coverexposetype == "A" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace pain
// Params 3
// Checksum 0xcd1893d9, Offset: 0x11ec
// Size: 0x77
function finishpain( asmname, statename, params )
{
    self.a.painplaying = undefined;
    self notify( #"killanimscript" );
    returnstate = undefined;
    
    if ( isdefined( params ) )
    {
        if ( isarray( params ) )
        {
            returnstate = params[ 0 ];
        }
        else
        {
            returnstate = params;
        }
    }
    
    if ( !isdefined( returnstate ) )
    {
        return;
    }
    
    thread asm::asm_setstate( returnstate, undefined );
}

// Namespace pain
// Params 3
// Checksum 0x42278843, Offset: 0x126b
// Size: 0x36
function playcoverpainanimwithadditives( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    playpainaniminternal( asmname, statename, params, 1 );
}

// Namespace pain
// Params 3
// Checksum 0xbf21a3a7, Offset: 0x12a9
// Size: 0x34
function playcoverpainanim( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    playpainanim( asmname, statename, params );
}

// Namespace pain
// Params 3
// Checksum 0xea0969a0, Offset: 0x12e5
// Size: 0x9d
function choosepainanim_standtorsotoexposed( asmname, statename, params )
{
    assert( isdefined( self.lasttorsoanim ) );
    
    if ( self.lasttorsoanim == "torso_upper" )
    {
        transitionanim = asm::asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( self.lasttorsoanim == "torso_lower" )
    {
        transitionanim = asm::asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else
    {
        transitionanim = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    self.lasttorsoanim = undefined;
    return transitionanim;
}

// Namespace pain
// Params 3
// Checksum 0x57fa231f, Offset: 0x138b
// Size: 0x94
function choosepainanim_standtorso( asmname, statename, params )
{
    if ( utility::damagelocationisany( "torso_upper" ) )
    {
        self.lasttorsoanim = "torso_upper";
        return asm::asm_lookupanimfromalias( statename, "torso_upper" );
    }
    
    if ( utility::damagelocationisany( "torso_lower" ) )
    {
        self.lasttorsoanim = "torso_lower";
        return asm::asm_lookupanimfromalias( statename, "torso_lower" );
    }
    
    self.lasttorsoanim = "default";
    return asm::asm_lookupanimfromalias( statename, "default" );
}

// Namespace pain
// Params 3
// Checksum 0xa265f878, Offset: 0x1427
// Size: 0x195
function choosepainanim_stand( asmname, statename, params )
{
    if ( utility_common::isusingsidearm() )
    {
        return choosepainanim_pistol( asmname, statename, params );
    }
    
    painarray = [];
    
    if ( utility::damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( utility::damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else if ( utility::damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "head" );
    }
    else if ( utility::damagelocationisany( "right_arm_upper", "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "right_arm" );
    }
    else if ( utility::damagelocationisany( "left_arm_upper", "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "left_arm" );
    }
    else if ( utility::damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "left_leg" );
    }
    else if ( utility::damagelocationisany( "right_leg_upper", "right_leg_lower", "right_foot" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "right_leg" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0xe8676df7, Offset: 0x15c5
// Size: 0x60
function choosepainanim_damageshield( asmname, statename, params )
{
    painarray = [];
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0xcab4a11b, Offset: 0x162e
// Size: 0x57
function choosedynamicpainanim_expcrouchlegs( asmname, statename, params )
{
    painarray = [];
    painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0x9de01084, Offset: 0x168e
// Size: 0xad
function choosepainanim_crouch( asmname, statename, params )
{
    painarray = [];
    painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    
    if ( utility::damagelocationisany( "left_hand", "left_arm_lower", "left_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "left_arm" );
    }
    
    if ( utility::damagelocationisany( "right_hand", "right_arm_lower", "right_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "right_arm" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0xe61ae789, Offset: 0x1744
// Size: 0x1a6
function choosepainanim_pistol( asmname, statename, params )
{
    painarray = [];
    
    if ( utility::damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_torso_upper" );
    }
    else if ( utility::damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_torso_lower" );
    }
    else if ( utility::damagelocationisany( "neck" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_neck" );
    }
    else if ( utility::damagelocationisany( "head" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_head" );
    }
    else if ( utility::damagelocationisany( "left_leg_upper", "right_leg_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_leg" );
    }
    else if ( utility::damagelocationisany( "left_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_left_arm_upper" );
    }
    else if ( utility::damagelocationisany( "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_left_arm_lower" );
    }
    else if ( utility::damagelocationisany( "right_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_right_arm_upper" );
    }
    else if ( utility::damagelocationisany( "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_right_arm_lower" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "pistol_default" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 4
// Checksum 0xa72987e9, Offset: 0x18f3
// Size: 0x6d
function choosepainanim_covercorner_helper( asmname, statename, params, angles )
{
    if ( isdefined( params[ 1 ] ) )
    {
        return asm::asm_lookupanimfromalias( statename, params[ 1 ] );
    }
    
    if ( self.currentpose == "crouch" )
    {
        return asm::asm_lookupanimfromalias( statename, "crouch" );
    }
    
    return asm::asm_lookupanimfromalias( statename, "stand" );
}

// Namespace pain
// Params 3
// Checksum 0xbb58a05d, Offset: 0x1968
// Size: 0x29
function choosepainanim_covercorner( asmname, statename, params )
{
    return choosepainanim_covercorner_helper( asmname, statename, params, undefined );
}

// Namespace pain
// Params 3
// Checksum 0x43b3136b, Offset: 0x199a
// Size: 0x38
function choosedynamicpainanim_back( asmname, statename, params )
{
    alias = "back";
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace pain
// Params 3
// Checksum 0x4bf1c83a, Offset: 0x19db
// Size: 0xb4
function choosedynamicpainanim_covercrouch( asmname, statename, params )
{
    painarray = [];
    
    if ( utility::damagelocationisany( "torso_upper", "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "torso" );
    }
    else if ( utility::damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "head" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0x9266b54d, Offset: 0x1a98
// Size: 0x181
function choosedynamicpainanim_coverstand( asmname, statename, params )
{
    painarray = [];
    
    if ( utility::damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( utility::damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else if ( utility::damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "head" );
    }
    else if ( utility::damagelocationisany( "right_arm_upper", "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "right_arm" );
    }
    else if ( utility::damagelocationisany( "left_arm_upper", "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "left_arm" );
    }
    else if ( utility::damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "left_leg" );
    }
    else if ( utility::damagelocationisany( "right_leg_upper", "right_leg_lower", "right_foot" ) )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "right_leg" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    assert( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain
// Params 3
// Checksum 0xfdcfe634, Offset: 0x1c22
// Size: 0x3c
function function_b7ef46b50fa40f6a( asmname, statename, params )
{
    self aisettargetspeed( length( self.velocity ) );
    cleanuppainanim( asmname, statename, params );
}

// Namespace pain
// Params 3
// Checksum 0x707765c2, Offset: 0x1c66
// Size: 0x18a
function cleanuppainanim( asmname, statename, params )
{
    if ( self.script == "pain" )
    {
        self notify( #"killanimscript" );
    }
    
    self.a.painplaying = undefined;
    
    if ( isdefined( self.damageshieldpain ) )
    {
        self.damageshieldcounter = undefined;
        self.damageshieldpain = undefined;
        self.allowpain = 1;
        
        if ( !isdefined( self.predamageshieldignoreme ) )
        {
            self.ignoreme = 0;
        }
        
        self.predamageshieldignoreme = undefined;
    }
    
    if ( isdefined( self.blockingpain ) )
    {
        self.blockingpain = undefined;
        self.allowpain = 1;
    }
    
    self._blackboard.var_49f45af6d499f832 = 0;
    self.var_3b3c56eeb617f219 = 0;
    self.shouldstumble = 0;
    self.shouldflinch = 0;
    clearpainturnrate( asmname, statename, params );
    
    if ( self.leavecasualkiller )
    {
        namespace_fcb50a41dde46fde::terminate_casualkiller( asmname, statename, params );
    }
    
    if ( !self.ignoreall )
    {
        if ( isdefined( self.enemy ) && isdefined( self.weapon ) && lengthsquared( self.velocity ) < 1 && !self.enemy.ignoreme && self cansee( self.enemy ) )
        {
            self.remainexposedendtime = gettime() + 2000;
        }
    }
}

// Namespace pain
// Params 4
// Checksum 0x212e3756, Offset: 0x1df8
// Size: 0x66, Type: bool
function transition_flashfinished( asmname, fromstate, tostate, params )
{
    if ( !utility::isflashed() )
    {
        return true;
    }
    
    if ( gettime() > self.flashendtime )
    {
        return true;
    }
    
    return asm::asm_eventfired( asmname, "end" ) || asm::asm_eventfired( asmname, "finish" );
}

// Namespace pain
// Params 3
// Checksum 0xbeb2cbb6, Offset: 0x1e67
// Size: 0x6c
function playanim_stunned( asmname, statename, params )
{
    if ( isdefined( self.stunnedcallback ) )
    {
        self [[ self.stunnedcallback ]]();
    }
    
    self.var_3b3c56eeb617f219 = 1;
    stunnedanim = asm::asm_getanim( asmname, statename, params );
    self aisetanim( statename, stunnedanim );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace pain
// Params 3
// Checksum 0xf1a90081, Offset: 0x1edb
// Size: 0x47
function playanim_stunnedloop( asmname, statename, params )
{
    stunnedanim = asm::asm_getanim( asmname, statename, params );
    self aisetanim( statename, stunnedanim );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace pain
// Params 3
// Checksum 0x9fdd669b, Offset: 0x1f2a
// Size: 0x36, Type: bool
function function_43beedc91c08023f( asmname, statename, params )
{
    if ( utility::isstunned() )
    {
        return false;
    }
    
    cleanuppainanim( asmname, statename, params );
    return true;
}

// Namespace pain
// Params 3
// Checksum 0x932235f5, Offset: 0x1f69
// Size: 0x47
function playanim_flashed( asmname, statename, params )
{
    self endon( statename + "_finished" );
    playanim_flashed_internal( asmname, statename );
    thread playanim_monitorflashrestart( asmname, statename );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace pain
// Params 2
// Checksum 0xdc362007, Offset: 0x1fb8
// Size: 0xf6
function playanim_flashed_internal( asmname, statename )
{
    flashanim = asm::asm_getanim( asmname, statename );
    self.var_3b3c56eeb617f219 = 1;
    
    if ( self.covernode )
    {
        self.keepclaimednodeifvalid = 1;
    }
    
    rate = 1;
    
    if ( isdefined( self.flashendtime ) )
    {
        flashlength = self.flashendtime - gettime();
        xanim = asm::asm_getxanim( statename, flashanim );
        animlength = getanimlength( xanim ) * 1000;
        
        if ( flashlength > 0 )
        {
            rate = animlength / flashlength;
        }
        
        rate += randomfloatrange( -0.1, 0.05 );
        rate = clamp( rate, 0.65, 1.2 );
        self.flashendtime = gettime() + int( animlength / rate );
    }
    
    self aisetanim( statename, flashanim, rate );
}

// Namespace pain
// Params 2
// Checksum 0x63a83b0f, Offset: 0x20b6
// Size: 0x6a
function playanim_monitorflashrestart( asmname, statename )
{
    self endon( statename + "_finished" );
    prevflashendtime = self.flashendtime;
    
    while ( isdefined( self.flashendtime ) )
    {
        if ( prevflashendtime != self.flashendtime )
        {
            playanim_flashed_internal( asmname, statename );
            prevflashendtime = self.flashendtime;
        }
        
        waitframe();
    }
}

// Namespace pain
// Params 3
// Checksum 0xb229200b, Offset: 0x2128
// Size: 0x46
function cleanupflashanim( asmname, statename, params )
{
    if ( self.covernode )
    {
        self.keepclaimednodeifvalid = 0;
    }
    
    cleanuppainanim( asmname, statename, params );
    utility::flashbangstop();
}

// Namespace pain
// Params 3
// Checksum 0xfdd3ef5a, Offset: 0x2176
// Size: 0xcc
function playanim_burning( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( level.battlechatter ) )
    {
        bcs_subcategory = battlechatter_events::function_e08b029c30762ab3( self.damageweapon );
        
        if ( isdefined( bcs_subcategory ) )
        {
            addbattlechatternotify( self, undefined, "burn", bcs_subcategory );
        }
    }
    
    self.var_3b3c56eeb617f219 = 1;
    burninganim = asm::asm_getanim( asmname, statename, params );
    playrate = randomfloatrange( 0.8, 1.2 );
    self orientmode( "face angle", self.angles[ 1 ] );
    self aisetanim( statename, burninganim, playrate );
    asm::asm_donotetracks( asmname, statename, &burn_notetrack_handler );
}

// Namespace pain
// Params 1
// Checksum 0xa5e81a67, Offset: 0x224a
// Size: 0x14b
function burn_notetrack_handler( note )
{
    if ( isdefined( self.semtexstuckto ) )
    {
        return;
    }
    
    switch ( note )
    {
        case #"hash_b3c1b4729e0c6d1a":
            if ( level.g_effect[ "vfx_burn_sml_head_low" ] )
            {
                playfxontag( level.g_effect[ "vfx_burn_sml_head_low" ], self, "j_helmet" );
            }
            
            break;
        case #"hash_91b66b1e7d9268f1":
            if ( level.g_effect[ "vfx_burn_sml_low" ] )
            {
                playfxontag( level.g_effect[ "vfx_burn_sml_low" ], self, "j_elbow_le" );
            }
            
            break;
        case #"hash_91b6751e7d9278af":
            if ( level.g_effect[ "vfx_burn_sml_low" ] )
            {
                playfxontag( level.g_effect[ "vfx_burn_sml_low" ], self, "j_shoulder_ri" );
            }
            
            break;
        case #"hash_72c435d66be93437":
            if ( level.g_effect[ "vfx_burn_med_low" ] )
            {
                playfxontag( level.g_effect[ "vfx_burn_med_low" ], self, "j_knee_le" );
            }
            
            break;
        case #"hash_72c43bd66be93da9":
            if ( level.g_effect[ "vfx_burn_med_low" ] )
            {
                playfxontag( level.g_effect[ "vfx_burn_med_low" ], self, "j_knee_ri" );
            }
            
            break;
    }
}

// Namespace pain
// Params 4
// Checksum 0x5e3682, Offset: 0x239d
// Size: 0x20a
function painanimfaceenemy( asmname, statename, animid, xanim )
{
    self endon( statename + "_finished" );
    enemy = self.enemy;
    animlength = getanimlength( xanim );
    endtime = animlength * 0.8;
    var_cc7dfd8c89067cad = getnotetracktimes( xanim, "face_enemy" )[ 0 ];
    
    if ( isdefined( var_cc7dfd8c89067cad ) )
    {
        endtime = var_cc7dfd8c89067cad * animlength;
    }
    else
    {
        if ( asm::asm_currentstatehasflag( asmname, "notetrackAim" ) )
        {
            startaimfrac = getnotetracktimes( xanim, "start_aim" )[ 0 ];
            
            if ( isdefined( startaimfrac ) )
            {
                endtime = min( endtime, max( 0, startaimfrac - 0.3 ) * animlength );
                startaimtime = startaimfrac * animlength;
            }
        }
        
        endtime = min( endtime, max( 0, animlength - 0.5 ) );
    }
    
    wait endtime;
    
    if ( isalive( enemy ) )
    {
        var_c788c77640e2f802 = getnotetracktimes( xanim, "face_enemy_end" )[ 0 ];
        var_7e04c317a0347e0f = 1;
        
        if ( isdefined( var_c788c77640e2f802 ) )
        {
            var_7e04c317a0347e0f = var_c788c77640e2f802;
        }
        
        turnduration = getanimlength( xanim ) * var_7e04c317a0347e0f - endtime;
        var_447f8a149a80442a = gettime() + turnduration * 1000;
        
        while ( gettime() < var_447f8a149a80442a && isalive( enemy ) )
        {
            metoenemy = enemy.origin - self.origin;
            angletoenemy = vectortoyaw( metoenemy );
            anglediff = angleclamp180( angletoenemy - self.angles[ 1 ] );
            curt = self getanimtime( xanim );
            remainingrot = getangledelta( xanim, curt, var_7e04c317a0347e0f );
            delta = anglediff - remainingrot;
            self orientmode( "face angle", self.angles[ 1 ] + delta );
            waitframe();
        }
    }
}

// Namespace pain
// Params 3
// Checksum 0xca422d43, Offset: 0x25af
// Size: 0x85
function playpainanim_faceplayer( asmname, statename, params )
{
    self endon( statename + "_finished" );
    fnthread = undefined;
    
    if ( isalive( self.enemy ) && isdefined( self.lastattacker ) && self.enemy == self.lastattacker )
    {
        fnthread = &painanimfaceenemy;
    }
    
    playpainaniminternal( asmname, statename, params, 0, 1, undefined, 1, fnthread );
}

// Namespace pain
// Params 3
// Checksum 0x62d999f4, Offset: 0x263c
// Size: 0x84
function playpainanim_exposedstand( asmname, statename, params )
{
    self endon( statename + "_finished" );
    fnthread = undefined;
    
    if ( isalive( self.enemy ) && isdefined( self.lastattacker ) && self.enemy == self.lastattacker )
    {
        fnthread = &painanimfaceenemy;
    }
    
    playpainaniminternal( asmname, statename, params, 0, 1, undefined, 0, fnthread );
}

// Namespace pain
// Params 3
// Checksum 0x35f2d30d, Offset: 0x26c8
// Size: 0x49
function playpainanim_exposedcrouch( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.painattacker = self.lastattacker;
    playpainaniminternal( asmname, statename, params, 0, 1 );
}

// Namespace pain
// Params 3
// Checksum 0xf7a8b2c6, Offset: 0x2719
// Size: 0xc0
function playpainanim_exposedcrouchtransition( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    
    if ( isalive( self.enemy ) && isdefined( self.painattacker ) && self.enemy == self.painattacker )
    {
        thread painanimfaceenemy( asmname, statename, animid, asm::asm_getxanim( statename, animid ) );
    }
    
    self.painattacker = undefined;
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace pain
// Params 3
// Checksum 0x6378b1da, Offset: 0x27e1
// Size: 0x47
function clearpainturnrate( asmname, statename, params )
{
    if ( isdefined( self.painoldturnrate ) )
    {
        self.turnrate = self.painoldturnrate;
        self.painoldturnrate = undefined;
    }
}

// Namespace pain
// Params 3
// Checksum 0x9d32ae0c, Offset: 0x2830
// Size: 0xcc
function function_32a18757e1b21733( asmname, statename, params )
{
    animaliasparam = undefined;
    
    if ( isstring( params ) )
    {
        animaliasparam = params;
    }
    
    self endon( statename + "_finished" );
    self orientmode( "face current" );
    self animmode( "live_ragdoll" );
    
    if ( isdefined( animaliasparam ) )
    {
        animid = asm::asm_getanim( asmname, statename, animaliasparam );
    }
    else
    {
        animid = asm::asm_getanim( asmname, statename );
    }
    
    thread function_5a48c34424f696eb();
    self aisetanim( statename, animid );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain
// Params 4
// Checksum 0x61210fd9, Offset: 0x2904
// Size: 0xb8
function function_3c18ca2cedef736c( asmname, statename, blendtime, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    animname = asm::asm_getxanim( statename, animid );
    thread function_9dfbfeb50836baa4();
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, animname );
    self setliveragdollrecoveryanim( animname );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain
// Params 0
// Checksum 0xd39f7522, Offset: 0x29c4
// Size: 0x4a
function function_5a48c34424f696eb()
{
    if ( !isdefined( self.weapon ) )
    {
        return;
    }
    
    self endon( #"death" );
    self waittillmatch( #"live_ragdoll_test", #"ragdoll_gun_stow" );
    shared::placeweaponon( self.weapon, "chest" );
}

// Namespace pain
// Params 0
// Checksum 0x96981492, Offset: 0x2a16
// Size: 0x4a
function function_9dfbfeb50836baa4()
{
    if ( !isdefined( self.weapon ) )
    {
        return;
    }
    
    self endon( #"death" );
    self waittillmatch( #"live_ragdoll_recover", #"ragdoll_gun_unstow" );
    shared::placeweaponon( self.weapon, "right" );
}

// Namespace pain
// Params 4
// Checksum 0xd69e5ea3, Offset: 0x2a68
// Size: 0x31, Type: bool
function disablerunpain( asmname, statename, tostatename, params )
{
    return istrue( self.disablerunpain );
}

// Namespace pain
// Params 3
// Checksum 0xef23cf50, Offset: 0x2aa2
// Size: 0x4b
function function_e582aef87a1c9df2( asmname, statename, params )
{
    painalias = "pain_popup" + getpaindirectiontoactor();
    painanim = asm::asm_lookupanimfromalias( statename, painalias );
    return painanim;
}

// Namespace pain
// Params 3
// Checksum 0x48799e94, Offset: 0x2af6
// Size: 0x4b
function function_aa3735e4c6bbbca4( asmname, statename, params )
{
    painalias = "pain_popup_recover" + getpaindirectiontoactor();
    painanim = asm::asm_lookupanimfromalias( statename, painalias );
    return painanim;
}

