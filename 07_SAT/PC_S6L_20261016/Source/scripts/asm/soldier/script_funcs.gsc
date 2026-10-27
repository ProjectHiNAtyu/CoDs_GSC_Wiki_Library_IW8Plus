// scripts\asm\soldier\script_funcs.gsc  (hash_7dcd7faceb87e0da.gscc) (size: 13922 Bytes / 0x3662 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaff40a62 (2952006242)
// size ...... 13922 (0x3662)
// includes .. 13  (offset: 0x2fe6)
// strings ... 97  (offset: 0x304e)
// dev strs .. 0   (offset: 0x3662)
// exports ... 33  (offset: 0x2096)
// cseg ...... 0x83a + 0x185c (0x2096)
// imports ... 87  (offset: 0x25be)
// animtree1 . 0   (offset: 0x3662)
// animtree2 . 0   (offset: 0x3662)
#using scripts\anim\combat_utility;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\pain;
#using scripts\common\gameskill;
#using scripts\common\utility;

#namespace namespace_fcb50a41dde46fde;

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x90d10a1e, Offset: 0x858
// Size: 0x1c5
function soldier_init( asmname, statename, params )
{
    assert( isdefined( self.asm ) );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    self.asm.gestures = spawnstruct();
    self.defaultturnthreshold = 59;
    self.anglelerprate = 100;
    
    if ( !isdefined( self.allowlongdeath ) )
    {
        self.allowlongdeath = 1;
    }
    
    if ( isdefined( self.fnasm_initfingerposes ) )
    {
        self thread [[ self.fnasm_initfingerposes ]]();
    }
    
    self.fnhelmetpop = &death::helmetpop;
    initaimlimits( asmname );
    self.var_cf790cd639e66f94 = 1;
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    self function_ff32ea59b2119107();
    weapclass = weaponclass( self.weapon );
    
    if ( weapclass == "mg" )
    {
        self.combatmode = "cover_lmg";
    }
    
    if ( !isdefined( self findoverridearchetype( "weapon" ) ) )
    {
        shared::updateweaponarchetype( weapclass );
    }
    
    if ( !isdefined( self.var_4a70d72021f92db9 ) )
    {
        self.var_4a70d72021f92db9 = &melee::function_67f0be66e0a19b06;
    }
    
    self.disablegrenaderesponse = 0;
    self.fnplaydeathanim = &death::playdeathanim;
    self.fnplaypainanim = &pain::playpainanim;
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0x3bf1f86f, Offset: 0xa25
// Size: 0x2b
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace namespace_fcb50a41dde46fde
// Params 1
// Checksum 0x14efa28d, Offset: 0xa58
// Size: 0x4d2
function initaimlimits( asmname )
{
    if ( !isdefined( level.combataimlimits ) )
    {
        level.combataimlimits = [];
        level.franticaimlimits = [];
        level.aimlimitstatemappings = [];
    }
    
    if ( !isdefined( level.combataimlimits[ asmname ] ) )
    {
        combataimlimits = [];
        franticaimlimits = [];
        aimlimit = [];
        combataimlimits[ "exposed_idle" ] = aimlimit;
        aimlimit = [];
        franticaimlimits[ "exposed_idle" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 15;
        combataimlimits[ "cover_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 15;
        franticaimlimits[ "cover_crouch_lean" ] = aimlimit;
        aimlimit = [];
        franticaimlimits[ "cover_crouch_aim" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        combataimlimits[ "cover_left_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        franticaimlimits[ "cover_left_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        combataimlimits[ "cover_left_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        franticaimlimits[ "cover_left_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 15;
        combataimlimits[ "cover_right_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 37;
        aimlimit[ "left" ] = 24;
        franticaimlimits[ "cover_right_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 25;
        combataimlimits[ "cover_right_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 15;
        franticaimlimits[ "cover_right_crouch_lean" ] = aimlimit;
        level.combataimlimits[ asmname ] = combataimlimits;
        level.franticaimlimits[ asmname ] = franticaimlimits;
    }
    
    if ( !isdefined( level.aimlimitstatemappings[ asmname ] ) )
    {
        aimlimitmapping = [];
        aimlimitmapping[ "cover_stand_exposed" ] = "cover_stand_exposed";
        aimlimitmapping[ "cover_stand_hide_to_exposed" ] = "cover_stand_exposed";
        aimlimitmapping[ "cover_stand_full_exposed" ] = "exposed_idle";
        aimlimitmapping[ "cover_stand_hide_to_full_exposed" ] = "exposed_idle";
        aimlimitmapping[ "cover_stand_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_exit" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_continue" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_left_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_right_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_attach_left_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_attach_right_shoot" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_hide_to_stand" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_hide_to_aim" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_right" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_left" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_lean" ] = "cover_crouch_lean";
        aimlimitmapping[ "cover_crouch_aim" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_lean" ] = "cover_crouch_lean";
        aimlimitmapping[ "cover_crouch_exposed_left" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_exposed_right" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_stand" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_lean" ] = "cover_right_lean";
        aimlimitmapping[ "cover_right_hide_to_lean" ] = "cover_right_lean";
        aimlimitmapping[ "cover_right_crouch_hide_to_lean" ] = "cover_right_crouch_lean";
        aimlimitmapping[ "cover_right_crouch_lean" ] = "cover_right_crouch_lean";
        aimlimitmapping[ "cover_right_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_lean" ] = "cover_left_lean";
        aimlimitmapping[ "cover_left_lean" ] = "cover_left_lean";
        aimlimitmapping[ "cover_left_crouch_hide_to_lean" ] = "cover_left_crouch_lean";
        aimlimitmapping[ "cover_left_crouch_lean" ] = "cover_left_crouch_lean";
        aimlimitmapping[ "cover_left_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cqb_idle" ] = "exposed_idle";
        aimlimitmapping[ "cqb_stand_loop" ] = "exposed_idle";
        aimlimitmapping[ "cqb_stand_strafe_loop" ] = "exposed_idle";
        aimlimitmapping[ "stand_run_strafe_loop" ] = "exposed_idle";
        aimlimitmapping[ "exposed_reload" ] = "exposed_idle";
        aimlimitmapping[ "exposed_weaponswitch" ] = "exposed_idle";
        aimlimitmapping[ "exposed_stand_turn" ] = "exposed_idle";
        aimlimitmapping[ "exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "exposed_prone" ] = "exposed_idle";
        aimlimitmapping[ "exposed_stand_infantry_reaction" ] = "exposed_idle";
        level.aimlimitstatemappings[ asmname ] = aimlimitmapping;
    }
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0xb045634f, Offset: 0xf32
// Size: 0x92, Type: bool
function needtoturn3d( asmname, statename, tostatename, params )
{
    if ( self.matchexposednodeorientation && isdefined( self.node ) )
    {
        return false;
    }
    
    yaw = getturndesiredyaw3d();
    
    if ( abs( yaw ) > self.turnthreshold )
    {
        return true;
    }
    
    pitch = getturndesiredpitch3d();
    
    if ( abs( pitch ) > self.pitchturnthreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0xb267ad81, Offset: 0xfcd
// Size: 0x172
function getturndesiredyaw()
{
    var_7237854e3be197ca = self.desiredturnyaw;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
        else if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
    }
    else if ( isdefined( self.smartfacingpos ) )
    {
        shootpos = self.smartfacingpos;
    }
    
    if ( !isdefined( shootpos ) && isdefined( self.node ) && self.node.type == "Exposed" && distancesquared( self.node.origin, self.origin ) < 36 )
    {
        return angleclamp180( self.node.angles[ 1 ] - self.angles[ 1 ] );
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredyaw = utility::getpredictedaimyawtoshootentorpos( predicttime, shootent, shootpos );
    return desiredyaw;
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0xdcae0077, Offset: 0x1148
// Size: 0xd5
function getturndesiredyaw3d()
{
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
        else if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
    }
    else if ( isdefined( self.enemy ) )
    {
        shootent = self.enemy;
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredyaw = utility::getpredictedaimyawtoshootentorpos3d( predicttime, shootent, shootpos );
    return desiredyaw;
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0x6dcb7612, Offset: 0x1226
// Size: 0xd5
function getturndesiredpitch3d()
{
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
        else if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
    }
    else if ( isdefined( self.enemy ) )
    {
        shootent = self.enemy;
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredpitch = utility::getpredictedaimpitchtoshootentorpos3d( predicttime, shootent, shootpos );
    return desiredpitch;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x614782ff, Offset: 0x1304
// Size: 0x177
function chooseturnanim3d( asmname, statename, params )
{
    desiredyaw = getturndesiredyaw3d();
    desiredpitch = getturndesiredpitch3d();
    
    if ( abs( desiredyaw ) > self.turnthreshold && abs( desiredyaw ) > abs( desiredpitch ) )
    {
        if ( desiredyaw < 0 )
        {
            direction = "right";
        }
        else
        {
            direction = "left";
        }
        
        desiredyaw = abs( desiredyaw );
        angle = 0;
        
        if ( desiredyaw > 157.5 )
        {
            angle = 180;
        }
        else if ( desiredyaw > 112.5 )
        {
            angle = 135;
        }
        else if ( desiredyaw > 67.5 )
        {
            angle = 90;
        }
        else
        {
            angle = 45;
        }
        
        animalias = direction + "_" + angle;
        turnanim = asm::asm_lookupanimfromalias( statename, animalias );
        return turnanim;
    }
    
    if ( desiredpitch < 0 )
    {
        direction = "up";
    }
    else
    {
        direction = "down";
    }
    
    desiredpitch = abs( desiredpitch );
    angle = 0;
    
    if ( desiredpitch > 157.5 )
    {
        angle = 180;
    }
    else if ( desiredpitch > 112.5 )
    {
        angle = 135;
    }
    else if ( desiredpitch > 67.5 )
    {
        angle = 90;
    }
    else
    {
        angle = 45;
    }
    
    animalias = direction + "_" + angle;
    turnanim = asm::asm_lookupanimfromalias( statename, animalias );
    return turnanim;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x90c21de9, Offset: 0x1483
// Size: 0x89
function choosecrouchturnanim( asmname, statename, params )
{
    desiredyaw = getturndesiredyaw();
    
    if ( desiredyaw < -135 )
    {
        alias = "2r";
    }
    else if ( desiredyaw > 135 )
    {
        alias = "2l";
    }
    else if ( desiredyaw < 0 )
    {
        alias = "6";
    }
    else
    {
        alias = "4";
    }
    
    turnanim = asm::asm_lookupanimfromalias( statename, alias );
    return turnanim;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0xe3c9d33c, Offset: 0x1515
// Size: 0x1f2
function reload_cleanup( asmname, statename, params )
{
    nullweapon = nullweapon();
    self notify( #"end_reload" );
    weap = self.asmreloadweapon;
    self.asmreloadweapon = nullweapon;
    self._blackboard.breload = 0;
    
    if ( !isdefined( self.weaponinfo ) )
    {
        return;
    }
    
    var_4a16f94be17c909b = weap != nullweapon && isdefined( self.weapon ) && weap == self.weapon;
    
    if ( weap == nullweapon )
    {
        weap = self.weapon;
    }
    
    weaponname = getcompleteweaponname( weap );
    
    if ( !isdefined( self.weaponinfo[ weaponname ] ) )
    {
        return;
    }
    
    if ( !asm::asm_eventfired( asmname, "drop clip" ) )
    {
        return;
    }
    
    if ( self.weaponinfo[ weaponname ].useclip )
    {
        clipmodel = getweaponclipmodel( weap );
        
        if ( isdefined( clipmodel ) )
        {
            battached = asm::asm_eventfired( asmname, "attach clip left" ) || asm::asm_eventfired( asmname, "attach clip right" );
            bdetached = asm::asm_eventfired( asmname, "detach clip left" ) || asm::asm_eventfired( asmname, "detach clip right" ) || asm::asm_eventfired( asmname, "detach clip nohand" );
            
            if ( !battached )
            {
                self notify( #"abort_reload" );
            }
            else if ( battached && !bdetached )
            {
                if ( asm::asm_eventfired( asmname, "attach clip left" ) )
                {
                    tagname = "tag_accessory_left";
                }
                else
                {
                    tagname = "tag_accessory_right";
                }
                
                self detach( clipmodel, tagname );
                self notify( #"clip_detached" );
                
                if ( var_4a16f94be17c909b )
                {
                    shared::showweaponmagattachment( weaponname );
                }
            }
        }
    }
    
    weaponlist::refillclip();
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x65b6030d, Offset: 0x170f
// Size: 0x33
function terminateexposedprone( asmname, statename, params )
{
    self.pushable = 1;
    self.keepclaimednodeifvalid = 0;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x79ea6281, Offset: 0x174a
// Size: 0x28
function terminateexposedidleaimdown( asmname, statename, params )
{
    self.aimingdown = 0;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0xb7b45b2b, Offset: 0x177a
// Size: 0x28
function terminateexposedcrouchaimdown( asmname, statename, params )
{
    self.aimingdown = 0;
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0xa117b389, Offset: 0x17aa
// Size: 0x30, Type: bool
function shouldfaceenemyinexposed()
{
    if ( isdefined( self.pathgoalpos ) )
    {
        return false;
    }
    
    return isplayer( self.enemy ) && self cansee( self.enemy );
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0xed6a2630, Offset: 0x17e3
// Size: 0xcb
function playanim_weaponswitch( asmname, statename, params )
{
    self endon( statename + "_finished" );
    weapclass = asm_bb::bb_getrequestedweapon();
    animname = asm::asm_getanim( asmname, statename );
    animrate = combat_utility::fasteranimspeed();
    
    if ( self.bhasriotshieldattached )
    {
        animrate = 1;
        self animmode( "gravity" );
    }
    
    self notify( #"abort_reload" );
    self aisetanim( statename, animname, animrate );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animname ) );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    self notify( #"hash_620fa2e847a2e88c" );
    gameskill::didsomethingotherthanshooting();
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x361bef1, Offset: 0x18b6
// Size: 0x40
function terminate_weaponswitch( asmname, statename, params )
{
    weapclass = weaponclass( self.weapon );
    shared::updateweaponarchetype( weapclass );
}

// Namespace namespace_fcb50a41dde46fde
// Params 2
// Checksum 0xe6cc272d, Offset: 0x18fe
// Size: 0x180
function playturnanim_turnanimanglefixup( turnxanim, statename )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    enemy = self.enemy;
    enemy endon( #"death" );
    animlength = getanimlength( turnxanim );
    
    if ( animhasnotetrack( turnxanim, "start_aim" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "start_aim" );
        animlength *= finish_time[ 0 ];
    }
    else if ( animhasnotetrack( turnxanim, "finish" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "finish" );
        animlength *= finish_time[ 0 ];
    }
    
    numframes = int( animlength * 20 );
    remainingframes = numframes;
    
    while ( remainingframes > 0 )
    {
        lerpfraction = 1 / remainingframes;
        yawtoenemy = utility::getyawtospot( enemy.origin );
        self.stepoutyaw = angleclamp180( self.angles[ 1 ] + yawtoenemy );
        currentanimtime = self aigetanimtime( turnxanim );
        animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
        remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
        self orientmode( "face angle", angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction ) );
        remainingframes--;
        wait 0.05;
    }
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0xcb530fa0, Offset: 0x1a86
// Size: 0x95
function shouldsnaptocover_checktype( asmname, statename, tostatename, params )
{
    if ( asm_bb::bb_moverequested() )
    {
        return 0;
    }
    
    if ( !utility::isatcovernode() )
    {
        return 0;
    }
    
    if ( !isdefined( self.node ) )
    {
        return 0;
    }
    
    if ( isdefined( self.primaryweapon ) && utility_common::isusingsidearm() && weaponclass( self.primaryweapon ) != "mg" )
    {
        return 0;
    }
    
    assert( isdefined( params ) );
    return utility::isarrivaltype( asmname, statename, tostatename, params );
}

// Namespace namespace_fcb50a41dde46fde
// Params 1
// Checksum 0x9f2c6a29, Offset: 0x1b24
// Size: 0x21
function reloadnotehandler( note )
{
    self notify( #"start_reload" );
    notetracks::notetrack_prefix_handler( note );
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x851114cd, Offset: 0x1b4e
// Size: 0x33
function assesscleanup( asmname, statename, params )
{
    self._blackboard.var_49f45af6d499f832 = 0;
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0xc92f2aaf, Offset: 0x1b89
// Size: 0x4d, Type: bool
function function_d7045ff31c11e6e1( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.assesslength ) )
    {
        return true;
    }
    
    if ( gettime() < self.assesslength )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_fcb50a41dde46fde
// Params 2
// Checksum 0xa7fa113e, Offset: 0x1bdf
// Size: 0x97
function facegoalthread_newenemyreaction( statename, reactworldyaw )
{
    self notify( #"facegoalthread" );
    self endon( #"facegoalthread" );
    self endon( #"death" );
    self endon( statename + "_finished" );
    
    while ( true )
    {
        multiplier = 0.25;
        reactlocalyaw = angleclamp180( reactworldyaw - self.angles[ 1 ] );
        self orientmode( "face angle", self.angles[ 1 ] + reactlocalyaw * multiplier );
        waitframe();
    }
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0xb8aa11e4, Offset: 0x1c7e
// Size: 0x6a, Type: bool
function handlefacegoalnotetrack_newenemyreaction( statename, note, lastknown )
{
    assert( isdefined( lastknown ) );
    
    if ( note == "face_goal" )
    {
        metopos = lastknown - self.origin;
        reactworldyaw = vectortoyaw( metopos );
        thread facegoalthread_newenemyreaction( statename, reactworldyaw );
        return true;
    }
    
    return false;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x3e39d108, Offset: 0x1cf1
// Size: 0xe8
function playanim_newenemyreaction( asmname, statename, params )
{
    self endon( statename + "_finished" );
    pushdisabledgunpose();
    reactanim = self asmgetanim( asmname, statename );
    assert( isdefined( reactanim ) );
    reactxanim = asm::asm_getxanim( statename, reactanim );
    self aisetanim( statename, reactanim );
    
    if ( isdefined( self.enemy ) )
    {
        lastknown = self lastknownpos( self.enemy );
        thread playturnanim_turnanimanglefixup( reactxanim, statename );
        asm::asm_donotetrackswithinterceptor( asmname, statename, &handlefacegoalnotetrack_newenemyreaction, lastknown );
    }
    else
    {
        asm::asm_donotetracks( asmname, statename );
    }
    
    if ( isdefined( self.enemy ) && self cansee( self.enemy ) )
    {
        self.remainexposedendtime = gettime() + 2000;
    }
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x13f569f0, Offset: 0x1de1
// Size: 0xb2
function chooseanim_playerpushed( asmname, statename, params )
{
    movedir = asm::asm_getephemeraleventdata( "player_pushed", "player_pushed" );
    movedirnormalized = vectornormalize( movedir );
    targetangles = vectortoangles( movedirnormalized );
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    angleindex = asm::yawdiffto2468( targetyaw );
    aliasname = "pushed_" + angleindex;
    turnanim = asm::asm_lookupanimfromalias( statename, aliasname );
    return turnanim;
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0x7301a646, Offset: 0x1e9c
// Size: 0x76
function terminate_casualkiller( asmname, statename, params )
{
    self setbasearchetype( self findoverridearchetype( "default" ) );
    self clearoverridearchetype( "demeanor", 0, 1 );
    self.newenemyreaction = 0;
    self.forcenewenemyreaction = 0;
    self notify( #"leavecasualkiller" );
    self.leavecasualkiller = 0;
    self.casualkiller = 0;
    self setdefaultaimlimits();
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0x1471fb8d, Offset: 0x1f1a
// Size: 0x12
function pushdisabledgunpose()
{
    self function_a83f7fcb7b07947b( "disable", "asm" );
}

// Namespace namespace_fcb50a41dde46fde
// Params 0
// Checksum 0x16aceeed, Offset: 0x1f34
// Size: 0xe
function popdisabledgunpose()
{
    self function_a83f7fcb7b07947b( undefined, "asm" );
}

// Namespace namespace_fcb50a41dde46fde
// Params 3
// Checksum 0xb9fcb989, Offset: 0x1f4a
// Size: 0x41
function function_53c7d5b478068f6e( asmname, statename, params )
{
    self function_455c292c412fd7( self.origin, self.angles );
    utility::loopanim( asmname, statename, params );
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0x39895f57, Offset: 0x1f93
// Size: 0x5c
function function_484f8bb781b29c87( asmname, statename, tostatename, params )
{
    if ( self.var_c16eedc405793a9 )
    {
        self setlookatenabled( 1 );
        utility::lookatentity( self.var_18de38e5e81d2645 );
    }
    
    return asm::asm_lookupanimfromalias( statename, self.dodgedirection );
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0xc660fa0, Offset: 0x1ff8
// Size: 0x43
function function_75ed1bbad0dd0cdf( asmname, statename, tostatename, params )
{
    self setlookatenabled( 0 );
    self.var_4def06a4881ee2b9 = 0;
    self.var_33ff4423807684d2 = 1;
}

// Namespace namespace_fcb50a41dde46fde
// Params 4
// Checksum 0x85a516b1, Offset: 0x2043
// Size: 0x53
function forwardpushevent( asmname, statename, tostatename, params )
{
    movedir = asm::asm_geteventdata( asmname, "player_pushed" );
    asm::asm_fireephemeralevent( "player_pushed", "player_pushed", movedir );
}

