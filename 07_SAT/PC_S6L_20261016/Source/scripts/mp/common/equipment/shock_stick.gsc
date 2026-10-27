// scripts\mp\common\equipment\shock_stick.gsc  (hash_4966d09e65e628d2.gscc) (size: 48324 Bytes / 0xbcc4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3467262 (3544609378)
// size ...... 48324 (0xbcc4)
// includes .. 52  (offset: 0xb2b8)
// strings ... 105 (offset: 0xb458)
// dev strs .. 32  (offset: 0xbb28)
// exports ... 95  (offset: 0x78a8)
// cseg ...... 0x7e0 + 0x70c8 (0x78a8)
// imports ... 347 (offset: 0x8780)
// animtree1 . 0   (offset: 0xbcc4)
// animtree2 . 0   (offset: 0xbcc4)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\asm\asm_bb;
#using scripts\common\ae_utility;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\killstreaks\cluster_spike;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\dev;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\rescue;
#using scripts\mp\laststand;
#using scripts\mp\meatshield;
#using scripts\mp\mtx_weapon;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\superdeploy;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace shock_stick;

// Namespace shock_stick
// Params 0
// Checksum 0x1050636b, Offset: 0x7fe
// Size: 0x38
function function_7030c7a052b7bf7f()
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return 0;
    }
    
    self.fuseoverride = 0;
    owner shockstick_use( self );
}

// Namespace shock_stick
// Params 0, eflags: 0x1
// Checksum 0x11851344, Offset: 0x83e
// Size: 0x248
function autoexec shockstick_init()
{
    level._effect[ "shock_stick_arc" ] = loadfxasset( "vfx_rex_core_equip_shockstick_connection_beam_01" );
    val::register( "allow_haywire", 1, 0 );
    utility::flag_wait( "equipment_initialized" );
    utility::registersharedfunc( #"shockstick", #"shockstick_applyhaywire", &shockstick_applyhaywire );
    utility::registersharedfunc( #"shockstick", #"shockstick_canbehaywire", &shockstick_canbehaywire );
    callback::add( #"player_laststand", &onplayerlaststand );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    callback::add( #"hash_dff7cb7b68f75deb", &function_c90e70e30bd900f7 );
    callback::add( #"hash_eb54ccc016130a88", &function_b57c3fb941587ca5 );
    weapons::registerusedcallback( "shock_stick", &shockstick_use );
    equipment_mp::registercallback( "equip_shockstick", "onPlayerDamaged", &shockstick_on_player_damaged );
    utility::registersharedfunc( #"shock_charge", #"hack", &hack );
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_shock", &shockstick_use );
    level.shocksticks = [];
    level.var_77a0719d5dc121a4 = [];
    level.var_fca38a9adcb119d1 = [];
    level.var_51913637670f48a7 = [];
    level.var_b3b5ef046f1a8dcf = [];
    
    foreach ( entry in level.equipment.table[ "equip_shockstick" ].bundle.var_fca38a9adcb119d1 )
    {
        level.var_fca38a9adcb119d1[ entry.var_c5dcde0a75982f4e ] = entry.var_4673c50a0cf09258;
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #equipref:"equip_shockstick" } );
    
    /#
        level thread function_259533db18bf7ed6();
    #/
    
    equipmentinteractinit();
}

// Namespace shock_stick
// Params 0
// Checksum 0xd0e34b3b, Offset: 0xa8e
// Size: 0x5f
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_shockstick" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_shockstick" ), #"interactdestroy", &shockstick_destroy );
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x82448d84, Offset: 0xaf5
// Size: 0x74
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
}

// Namespace shock_stick
// Params 1, eflags: 0x4
// Checksum 0x4eced6b1, Offset: 0xb71
// Size: 0x59, Type: bool
function private function_c90e70e30bd900f7( params )
{
    game_object = params.game_object;
    player = params.player;
    
    if ( gameobjects_common::get_type_hash( game_object ) != #"gameobject_type_carry_object" )
    {
        return true;
    }
    
    return !player::ishaywired( player );
}

/#

    // Namespace shock_stick
    // Params 0
    // Checksum 0x5230b7d7, Offset: 0xbd3
    // Size: 0xed, Type: dev
    function function_259533db18bf7ed6()
    {
        while ( true )
        {
            dohaywire = getdvarint( @"hash_4fa4d9014bdc9130", 0 );
            
            if ( dohaywire )
            {
                setdvar( @"hash_4fa4d9014bdc9130", 0 );
                player = dev_mp::devfindhost();
                shockstick = player weapon::_launchgrenade( "<dev string:x24>", player.origin, ( 0, 0, 0 ), undefined, 1 );
                shockstick.tableinfo = weapon::getequipmenttableinfo( "<dev string:x33>" );
                player weapons::grenadeinitialize( shockstick, makeweapon( "<dev string:x24>" ), 0, player );
                shockstick setscriptablepartstate( #"electric", #"active", 0 );
                shockstick setscriptablepartstate( #"detonate", #"detonate", 0 );
                shockstick thread function_1d426c8b1b9484bb();
            }
            
            wait 0.25;
        }
    }

#/

// Namespace shock_stick
// Params 3
// Checksum 0xf3dc2230, Offset: 0xcc8
// Size: 0x2f0
function shockstick_use( grenade, isgl, objweapon )
{
    grenade endon( #"death" );
    
    /#
        setdevdvarifuninitialized( @"hash_d677956e73b3bfb4", 0.8 );
    #/
    
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x44>" );
    }
    
    grenade.tableinfo.stowedweapons = grenade.tableinfo.bundle.stowedweapons;
    grenade.tableinfo.var_5c22a55131667a8d = grenade.tableinfo.bundle.var_5c22a55131667a8d;
    grenade.tableinfo.var_e877025b8a47dca0 = grenade.tableinfo.bundle.var_51913637670f48a7;
    grenade.tableinfo.var_a4f3cecf73e509a = grenade.tableinfo.bundle.var_1fc5ecee144e14ae;
    bundle = level.equipment.table[ "equip_shockstick" ].bundle;
    
    if ( !isdefined( level.equipment.table[ "equip_shockstick" ].effect_duration ) )
    {
        level.equipment.table[ "equip_shockstick" ].effect_duration = bundle.var_3286379ecf01e5d3;
    }
    
    if ( grenade.tableinfo.bundle.var_f3447a3874df563f )
    {
        if ( !isdefined( self.shocksticks ) )
        {
            self.shocksticks = [];
            callback::add( "onPlayerSpawn_destroyEquipment", &function_32bd4b0c52431420 );
        }
        
        self.shocksticks[ self.shocksticks.size ] = grenade;
        weapons::onequipmentplanted( grenade, "equip_shockstick", undefined );
    }
    
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &shockstick_emp_applied );
    grenade thread shockstick_watchdisowned();
    grenade thread function_34c8c5da455ee281();
    grenade thread equipment_mp::watchwaterdepth( &function_5c9427eb5e28ff10 );
    challenges::function_3d7a169dbae062fb( "equip_shockstick", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    thread shockstick_watchstuck( grenade );
    grenade utility::function_8a74027bdea84771( &function_5ea9a3b277397a1b );
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", grenade, &onjammed, &function_50c48f547b740df9 );
}

// Namespace shock_stick
// Params 1, eflags: 0x4
// Checksum 0x699c6b54, Offset: 0xfc0
// Size: 0x34
function private onjammed( jammedshockstick )
{
    jammedshockstick setscriptablepartstate( #"jammed", #"on", 0 );
    jammedshockstick.isjammed = 1;
}

// Namespace shock_stick
// Params 1, eflags: 0x4
// Checksum 0x7336aab4, Offset: 0xffc
// Size: 0x31
function private function_50c48f547b740df9( jammedshockstick )
{
    jammedshockstick setscriptablepartstate( #"jammed", #"off", 0 );
    jammedshockstick.isjammed = undefined;
}

// Namespace shock_stick
// Params 1
// Checksum 0xfc4c983c, Offset: 0x1035
// Size: 0x8d
function shockstick_emp_applied( empstruct )
{
    victim = empstruct.victim;
    attacker = empstruct.attacker;
    objweapon = empstruct.objweapon;
    
    if ( isdefined( attacker ) && player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self, objweapon );
    }
    
    self notify( #"enemy_destroyed_equipment", attacker );
    victim shockstick_destroy( 1 );
}

// Namespace shock_stick
// Params 0
// Checksum 0xb3f4ae84, Offset: 0x10ca
// Size: 0x40
function shockstick_watchdisowned()
{
    self endon( #"death" );
    self endon( #"underwater_swap" );
    self.owner utility::waittill_any( "joined_team", "joined_spectators", "disconnect" );
    thread shockstick_destroy();
}

// Namespace shock_stick
// Params 0
// Checksum 0x8b94ab24, Offset: 0x1112
// Size: 0x2e
function function_34c8c5da455ee281()
{
    self endon( #"death" );
    self endon( #"underwater_swap" );
    self waittill( #"forcedeath" );
    thread shockstick_destroy();
}

// Namespace shock_stick
// Params 0
// Checksum 0x2c34ebb3, Offset: 0x1148
// Size: 0xb
function function_5ea9a3b277397a1b()
{
    shockstick_destroy( 1 );
}

// Namespace shock_stick
// Params 1
// Checksum 0x179603a1, Offset: 0x115b
// Size: 0x105
function shockstick_destroy( isimmediate )
{
    if ( self.exploding )
    {
        return;
    }
    
    var_6c22d099760d3535 = function_5eb527187eac436e( self );
    
    foreach ( linkdata in var_6c22d099760d3535 )
    {
        function_1ada9a8fb9da6962( linkdata );
        level.var_77a0719d5dc121a4 = arrayremove( level.var_77a0719d5dc121a4, linkdata );
        
        if ( isdefined( linkdata ) )
        {
            linkdata = undefined;
        }
    }
    
    time = 0.25;
    
    if ( isimmediate )
    {
        time = 0;
    }
    
    self.exploding = 1;
    self setscriptablepartstate( #"destroy", #"on", 0 );
    thread shockstick_delete( time );
}

// Namespace shock_stick
// Params 1
// Checksum 0x682304f1, Offset: 0x1268
// Size: 0x1a7
function shockstick_delete( deletiondelay )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    
    if ( self.tableinfo.bundle.var_404ff032f30bebd9 )
    {
        self setscriptablepartstate( #"electric", #"neutral", 0 );
        chaindelay = self.tableinfo.bundle.var_3591f7f96806cb7d ?? 1;
        wait chaindelay + 0.5;
        self notify( #"death" );
        wait deletiondelay;
        
        if ( isdefined( self ) )
        {
            if ( isdefined( self.badplace ) )
            {
                destroynavobstacle( self.badplace );
            }
            
            self.var_d6b8b3b84549fb9f = undefined;
            entityheadicons::setheadicon_deleteicon( self.headiconid );
            self delete();
        }
        
        return;
    }
    
    self notify( #"death" );
    
    if ( deletiondelay > 0 )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.badplace ) )
        {
            destroynavobstacle( self.badplace );
        }
        
        if ( isdefined( self.arctrigger ) )
        {
            self.arctrigger delete();
        }
        
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.var_d6b8b3b84549fb9f = undefined;
        self setscriptablepartstate( #"electric", #"neutral", 0 );
        level.shocksticks = arrayremove( level.shocksticks, self );
        self delete();
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xf081d942, Offset: 0x1417
// Size: 0x3c, Type: bool
function shockstick_on_player_damaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    data.victim thread function_741ca0f98c3d4857( 0.2 );
    return true;
}

// Namespace shock_stick
// Params 1
// Checksum 0xfd559db1, Offset: 0x145c
// Size: 0xa2
function function_32bd4b0c52431420( params )
{
    if ( isdefined( self.shocksticks ) )
    {
        foreach ( shockstick in self.shocksticks )
        {
            if ( isdefined( shockstick ) )
            {
                shockstick shockstick_destroy();
            }
        }
        
        self.shocksticks = [];
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x28c16cbb, Offset: 0x1506
// Size: 0xda
function function_ae828c2e06b3f120( grenade )
{
    weaponname = utility::get_scripted_weapon_name( #"shock_stick_underwater" );
    newgrenade = weapon::_launchgrenade( weaponname, grenade.origin, ( 0, 0, 0 ), undefined, 1 );
    weapons::grenadeinitialize( newgrenade, makeweapon( weaponname ), 0, self );
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    newgrenade.tableinfo = weapon::getequipmenttableinfo( ref );
    newgrenade.owner = self;
    grenade notify( #"underwater_swap" );
    grenade delete();
    newgrenade setscriptablepartstate( #"danger-icon", #"on", 0 );
    newgrenade thread shockstick_makedamageable();
    return newgrenade;
}

// Namespace shock_stick
// Params 1
// Checksum 0xbba41aed, Offset: 0x15e9
// Size: 0x35b
function shockstick_watchstuck( grenade )
{
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    else
    {
        self endon( #"death" );
    }
    
    level endon( #"game_ended" );
    grenade endon( #"death" );
    bundle = grenade.tableinfo.bundle;
    stuckdata = grenade equipment_mp::function_ea51ae6c8436d3cd();
    
    if ( !isdefined( stuckdata ) )
    {
        return;
    }
    
    stucktoplayer = 0;
    
    if ( isdefined( stuckdata.stuckto ) )
    {
        stuckto = stuckdata.stuckto;
        
        if ( stuckdata.stuckto.weapon_name == "deployed_decoy_mp" && stuckdata.stuckto.var_db9d0a769662b075 )
        {
            grenade thread shockstick_destroy( 1 );
            return;
        }
        
        if ( isent( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
        {
            grenade setmissileantilagged( 1 );
        }
        
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( challenges::challengesenabledforplayer() )
            {
                challenges::function_37e945722d6497f3( self, "shock_stick_stuck", 1 );
            }
            
            weapons::grenadestuckto( grenade, stuckdata.stuckto );
            stucktoplayer = 1;
        }
        else
        {
            grenade thread equipment_mp::function_2c8f51009c3dd68f( stuckto, &shockstick_destroy, 1 );
        }
        
        grenade.stuckto = stuckto;
        
        if ( isplayer( self ) )
        {
            callbackparams = { #stuckto:stuckto, #equipmentref:"equip_shockstick", #attacker:self };
            callback::callback( #"equipment_stuck", callbackparams );
        }
    }
    
    if ( stucktoplayer )
    {
        if ( isplayer( grenade.owner ) )
        {
            grenade.owner thread gamelogic_mp::threadedsetweaponstatbyname( grenade.weapon_object, 1, "special_hits" );
        }
        
        if ( !isalive( stuckto ) )
        {
            grenade thread stuckkillplayer();
        }
    }
    else
    {
        grenade thread shockstick_makedamageable();
        utility::function_969f9f5596dba07a( grenade, &shockstick_destroy );
        fusetime = bundle.var_77100b2bc42bcfdd ?? 0.35;
        fusetime = getdvarfloat( @"scr_shock_stick_fuse_time", fusetime );
        grenade setscriptablepartstate( #"electric", #"fuse", 0 );
        canarc = grenade.tableinfo.bundle.var_8820685fbc1f0239;
        level.shocksticks[ level.shocksticks.size ] = grenade;
        grenade sentientpoolmanager::registersentient( "Tactical_Static", grenade.owner, 1 );
        
        if ( isdefined( self.perks[ "specialty_cricket" ] ) )
        {
            msg = utility::waittill_any_return( "detonate", "death" );
            
            if ( msg == "death" )
            {
                grenade thread shockstick_destroy( 1 );
                return;
            }
        }
        else
        {
            grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
            wait fusetime;
        }
    }
    
    thread function_9dcb3416596f6f59( grenade, stuckdata );
    params = { #var_a4af6d34cd071836:grenade };
    callback::callback( #"shock_stick_landed", params );
}

// Namespace shock_stick
// Params 0, eflags: 0x4
// Checksum 0x7761100f, Offset: 0x194c
// Size: 0x12
function private function_5c9427eb5e28ff10()
{
    if ( isdefined( self ) )
    {
        self.var_5bfbf66c36d852bb = 1;
    }
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x1da2ff24, Offset: 0x1966
// Size: 0x12e
function private function_9dcb3416596f6f59( grenade, stuckdata )
{
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    else
    {
        self endon( #"death" );
    }
    
    level endon( #"game_ended" );
    bundle = grenade.tableinfo.bundle;
    var_1ea58d8060ea779c = istrue( bundle.var_f3447a3874df563f );
    
    if ( grenade.exploding )
    {
        return;
    }
    
    if ( isdefined( stuckdata.isunderwater ) )
    {
        if ( var_1ea58d8060ea779c )
        {
            grenade shockstick_destroy();
        }
        else if ( grenade.var_5bfbf66c36d852bb )
        {
            grenade = function_ae828c2e06b3f120( grenade );
        }
    }
    
    grenade endon( #"death" );
    
    if ( var_1ea58d8060ea779c )
    {
        if ( !isdefined( stuckdata.isunderwater ) )
        {
            grenade function_a19ec6b53a18c3c5( stuckdata );
        }
        
        return;
    }
    
    grenade setscriptablepartstate( #"electric", #"active", 0 );
    grenade setscriptablepartstate( #"detonate", #"detonate", 0 );
    grenade thread function_1d426c8b1b9484bb();
}

// Namespace shock_stick
// Params 0, eflags: 0x4
// Checksum 0x127beaa1, Offset: 0x1a9c
// Size: 0x44
function private shockstick_makedamageable()
{
    maxhp = self.tableinfo.bundle.shockstick_maxhealth ?? 100;
    thread damage::monitordamage( maxhp, "hitequip", &shockstick_handlefataldamage, undefined );
}

// Namespace shock_stick
// Params 1, eflags: 0x4
// Checksum 0xc1558ed1, Offset: 0x1ae8
// Size: 0x78
function private shockstick_handlefataldamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    
    if ( player_utility::playersareenemies( self.owner, data.attacker ) )
    {
        data.attacker equipment_mp::function_ada7da3083a6c593( self, data.objweapon );
        data.attacker battlechatter_mp::equipmentdestroyed( self );
    }
    
    shockstick_destroy();
}

// Namespace shock_stick
// Params 0, eflags: 0x4
// Checksum 0x98777c16, Offset: 0x1b68
// Size: 0x11
function private stuckkillplayer()
{
    wait 2;
    
    if ( isdefined( self ) )
    {
        thread shockstick_destroy();
    }
}

// Namespace shock_stick
// Params 2
// Checksum 0x6746b601, Offset: 0x1b81
// Size: 0x78
function shockstick_canbehaywire( shockstick, ignoresight )
{
    if ( self == shockstick )
    {
        return 0;
    }
    
    if ( !isdefined( self ) || !val::get( "allow_haywire" ) )
    {
        return 0;
    }
    
    if ( isplayer( self ) )
    {
        return function_a0ce1f526d77cda5( shockstick, ignoresight );
    }
    else if ( self.exploding )
    {
        return 0;
    }
    else if ( self.var_91eefe62b94cf0c6 )
    {
        return 0;
    }
    else
    {
        return function_3588005512de4d42( shockstick );
    }
    
    return 1;
}

// Namespace shock_stick
// Params 1
// Checksum 0xc1666691, Offset: 0x1c02
// Size: 0x24b
function function_3588005512de4d42( shockstick )
{
    if ( !isdefined( self.classname ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.owner ) && !isagent( self ) && self.classname != "misc_turret" && self.classname != "script_vehicle" )
    {
        return 0;
    }
    
    if ( shockstick == self )
    {
        return 0;
    }
    
    bundle = shockstick.tableinfo.bundle;
    
    if ( !bundle.var_9891ed88bcd38fd2 )
    {
        return 0;
    }
    
    if ( self.classname == "misc_turret" && !bundle.var_cd1e9f6afbf90d3a )
    {
        return 0;
    }
    
    if ( self.classname == "script_vehicle" && !bundle.var_c6920ebeb7833310 )
    {
        return 0;
    }
    
    if ( function_eef06a47a34edfd( shockstick ) )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( shockstick.team == self.team )
        {
            if ( isagent( self ) || isdefined( self.owner ) && self.owner != shockstick.owner )
            {
                return 0;
            }
        }
    }
    
    if ( isdefined( self.weapon_name ) )
    {
        if ( !utility::is_valid_weapon_name( self.weapon_name ) )
        {
            return 0;
        }
        
        weapontype = weapon::getweapontype( self.weapon_name );
        
        if ( isdefined( weapontype ) )
        {
            if ( weapontype != "lethal" && weapontype != "tactical" && weapontype != "super" && !cluster_spike::function_3d02e6de6e66d2a3( self.weapon_name ) && weapontype == "killstreak" && !haywire::function_8238cd34bd133b52( self ) )
            {
                return 0;
            }
        }
    }
    
    if ( isagent( self ) && !trace::ray_trace_passed( shockstick.origin, self.origin + ( 0, 0, 50 ), undefined, trace::create_default_contents( 1 ) ) )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"shockstick", #"hash_282a95fe348c0434" ) )
    {
        return utility::callsharedfunc( #"shockstick", #"hash_282a95fe348c0434", shockstick );
    }
    
    return 1;
}

// Namespace shock_stick
// Params 2
// Checksum 0x10a8ce2a, Offset: 0x1e56
// Size: 0x176, Type: bool
function function_a0ce1f526d77cda5( shockstick, ignoresight )
{
    print( "<dev string:x60>" );
    bundle = shockstick.tableinfo.bundle;
    
    if ( ( killstreak::isjuggernaut() || killstreak::function_27766a07ce1d112a() ) && !game_utility_mp::isjuggermoshgamemode() )
    {
        return false;
    }
    
    if ( bundle.var_f3447a3874df563f && ( function_eef06a47a34edfd( shockstick ) || self == shockstick.owner ) )
    {
        return false;
    }
    
    if ( self.spawnprotection )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        if ( !isdefined( self.team ) )
        {
            return true;
        }
        
        if ( shockstick.team == self.team && self != shockstick.owner )
        {
            return false;
        }
    }
    
    if ( utility::isusingremote() || self.isusingcamera )
    {
        return false;
    }
    
    isalive = player::isreallyalive();
    haywireduration = shockstick function_bef03b8a4a022955( self );
    maxhaywireduration = bundle.var_c8bb02c8c8cd0442 ?? 100;
    
    if ( !isalive || haywireduration >= maxhaywireduration )
    {
        return false;
    }
    
    if ( !ignoresight )
    {
        if ( self sightconetrace( shockstick.origin, shockstick ) <= 0 )
        {
            return false;
        }
    }
    
    return istrue( function_6978e1294bb94402( shockstick ) );
}

// Namespace shock_stick
// Params 2
// Checksum 0x1b06583f, Offset: 0x1fd5
// Size: 0xf7, Type: bool
function function_16865da2b6cd8ad9( shockstick, chainorigin )
{
    if ( !( isdefined( shockstick.tableinfo.bundle ) && isdefined( chainorigin ) ) )
    {
        return false;
    }
    
    bundle = shockstick.tableinfo.bundle;
    
    if ( bundle.var_f3447a3874df563f && ( function_eef06a47a34edfd( shockstick ) || self == shockstick.owner ) )
    {
        return false;
    }
    
    isalive = player::isreallyalive();
    haywireduration = shockstick function_bef03b8a4a022955( self );
    maxhaywireduration = bundle.var_c8bb02c8c8cd0442 ?? 100;
    
    if ( !isalive || haywireduration >= maxhaywireduration )
    {
        return false;
    }
    
    if ( self sightconetrace( chainorigin.origin, chainorigin ) <= 0 )
    {
        return false;
    }
    
    return istrue( function_6978e1294bb94402( shockstick ) );
}

// Namespace shock_stick
// Params 1
// Checksum 0x391fc830, Offset: 0x20d5
// Size: 0x52
function function_bef03b8a4a022955( target )
{
    if ( !isdefined( self.var_d6b8b3b84549fb9f ) || !isdefined( target ) )
    {
        return 0;
    }
    
    duration = self.var_d6b8b3b84549fb9f[ target getentitynumber() ];
    
    if ( !isdefined( duration ) )
    {
        return 0;
    }
    
    return duration;
}

// Namespace shock_stick
// Params 1
// Checksum 0x1e3e20b2, Offset: 0x212f
// Size: 0x73, Type: bool
function function_eef06a47a34edfd( shockstick )
{
    if ( !isdefined( self.haywiretimestamp ) )
    {
        return false;
    }
    
    bundle = shockstick.tableinfo.bundle;
    haywirecooldown = bundle.var_f232776b54e76cfa ?? 0.3;
    haywirecooldown *= 1000;
    return gettime() - self.haywiretimestamp <= haywirecooldown;
}

// Namespace shock_stick
// Params 0
// Checksum 0xaf9b7f60, Offset: 0x21ab
// Size: 0x574
function function_1136b799aad87bb9()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    bundle = self.tableinfo.bundle;
    
    foreach ( shockstick in level.shocksticks )
    {
        if ( shockstick == self )
        {
            continue;
        }
        
        if ( !trace::ray_trace_passed( shockstick.origin, self.origin + ( 0, 0, 50 ), undefined, trace::create_default_contents( 1 ) ) )
        {
            linkdata = function_9f342824ea9b32ef( self, shockstick );
            
            if ( isdefined( linkdata ) )
            {
                function_1ada9a8fb9da6962( linkdata );
            }
            
            continue;
        }
        
        if ( distance( shockstick.origin, self.origin ) > bundle.var_776d6259bbeedaaf && distance( shockstick.origin, self.origin ) < bundle.var_d2ce111b4cd7cc4d )
        {
            if ( !function_fdcbae7456ac9efc( self, shockstick ) )
            {
                linkdata = spawnstruct();
                linkdata.shocksticka = self;
                self.arcshockstick = shockstick;
                linkdata.shockstickb = shockstick;
                shockstick.arcshockstick = self;
                linkdata.owners = [];
                linkdata.owners = arraycombineunique( linkdata.owners, [ linkdata.shocksticka.owner ] );
                linkdata.owners = arraycombineunique( linkdata.owners, [ linkdata.shockstickb.owner ] );
                self.var_9a80172827e94fb6 = 1;
                self.arcdamage = bundle.shockstick_arc_damage ?? 0;
                linkdata.arcdistance = distance( linkdata.shockstickb.origin, linkdata.shocksticka.origin );
                linkdata.arcmidpoint = ( ( linkdata.shockstickb.origin[ 0 ] + linkdata.shocksticka.origin[ 0 ] ) / 2, ( linkdata.shockstickb.origin[ 1 ] + linkdata.shocksticka.origin[ 1 ] ) / 2, ( linkdata.shockstickb.origin[ 2 ] + linkdata.shocksticka.origin[ 2 ] ) / 2 );
                arctrigger = spawn( "trigger_rotatable_radius", linkdata.shockstickb.origin, 0, 50, linkdata.arcdistance );
                arctrigger.angles = vectortoangles( linkdata.shocksticka.origin - linkdata.shockstickb.origin ) + ( 90, 0, 0 );
                arctrigger.owners = linkdata.owners;
                linkdata.arctrigger = arctrigger;
                trigger::makeenterexittrigger( linkdata.arctrigger, &function_30b85490f96d9af1, &function_90a21a08c2edf491 );
                
                if ( !isdefined( linkdata.arcvfx ) )
                {
                    wait 0.35;
                    
                    if ( isdefined( linkdata.shocksticka ) && isdefined( linkdata.shockstickb ) && !isdefined( linkdata.arcvfx ) )
                    {
                        linkdata.arcvfx = playfxontagsbetweenclients( level._effect[ "shock_stick_arc" ], linkdata.shocksticka, "tag_fx", linkdata.shockstickb, "tag_fx" );
                    }
                }
                
                level.var_77a0719d5dc121a4 = arraycombineunique( level.var_77a0719d5dc121a4, [ linkdata ] );
            }
            else if ( isdefined( self.stuckto ) )
            {
                linkdata = function_9f342824ea9b32ef( self, shockstick );
                bundle = self.tableinfo.bundle;
                
                if ( !trace::ray_trace_passed( shockstick.origin, self.origin, undefined, trace::create_default_contents( 1 ) ) || linkdata.arcdistance < bundle.var_776d6259bbeedaaf || linkdata.arcdistance > bundle.var_d2ce111b4cd7cc4d )
                {
                    linkdata = function_9f342824ea9b32ef( self, shockstick );
                    
                    if ( isdefined( linkdata ) )
                    {
                        function_1ada9a8fb9da6962( linkdata );
                    }
                    
                    continue;
                }
                
                function_c99c58a7cfce78a8( linkdata );
            }
            
            continue;
        }
        
        linkdata = function_9f342824ea9b32ef( self, shockstick );
        
        if ( isdefined( linkdata ) )
        {
            function_1ada9a8fb9da6962( linkdata );
            level.var_77a0719d5dc121a4 = arrayremove( level.var_77a0719d5dc121a4, linkdata );
            linkdata = undefined;
        }
    }
}

// Namespace shock_stick
// Params 0
// Checksum 0xd4751edd, Offset: 0x2727
// Size: 0xaff
function function_1d426c8b1b9484bb()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    var_6dd1cac20dc0a3ad = 0;
    
    if ( isbrgamemode() )
    {
        var_6dd1cac20dc0a3ad = getdvarint( @"hash_25b486e84d3b2909", 0 );
    }
    
    bundle = self.tableinfo.bundle;
    
    if ( !arraycontains( level.shocksticks, self ) )
    {
        level.shocksticks[ level.shocksticks.size ] = self;
    }
    
    self.ticks = 0;
    objweapon = makeweapon( bundle.useweapon );
    contents = [ "physicscontents_item", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip" ];
    self.totalduration = bundle.var_3286379ecf01e5d3 ?? 5;
    self.totalduration = getdvarfloat( @"shockstick_duration", self.totalduration );
    self.tickrate = bundle.shockstick_tickinterval ?? 0.2;
    self.tickrate = getdvarfloat( @"shockstick_tick_rate", self.tickrate );
    self.tickcount = self.totalduration / self.tickrate;
    self.var_c3c4d711e69d5ab9 = 1;
    
    if ( isdefined( self.arcshockstick ) )
    {
        self.ticks = 0;
        self.arcshockstick.ticks = 0;
    }
    
    detonationradius = bundle.shockstick_detonationradius ?? 125;
    electrocutedamage = bundle.var_fcbedb2a111f91fd ?? 6;
    var_eec5eb1cbf64e024 = istrue( bundle.var_404ff032f30bebd9 );
    
    if ( var_eec5eb1cbf64e024 )
    {
        self.initialhaywire = [];
    }
    
    self.badplace = shockstick_badplace( self.origin, detonationradius );
    stealtheventbroadcastbytacsight( "decoy_grenade", self.owner, self.origin, 512 );
    
    while ( self.ticks < self.tickcount )
    {
        if ( bundle.var_8820685fbc1f0239 )
        {
            thread function_1136b799aad87bb9();
        }
        
        ents = entity::getentitiesinradius( self.origin, detonationradius, undefined, undefined, physics_createcontents( contents ) );
        
        if ( isdefined( self.arcvictims ) )
        {
            foreach ( victim in self.arcvictims )
            {
                ents = arraycombineunique( ents, [ victim ] );
            }
        }
        
        print( "<dev string:x82>" + ents.size );
        
        foreach ( ent in ents )
        {
            if ( !isdefined( ent ) )
            {
                print( "<dev string:x9b>" + ent getentitynumber() + "<dev string:xa4>" );
                continue;
            }
            
            if ( ent == self )
            {
                print( "<dev string:x9b>" + ent getentitynumber() + "<dev string:xb2>" );
                continue;
            }
            
            if ( var_6dd1cac20dc0a3ad )
            {
                if ( isdefined( ent.domflag.trigger.var_5b3dbacfeda0fd01 ) )
                {
                    if ( ent.domflag.trigger.stronghold.capturedteam == self.owner.team )
                    {
                        continue;
                    }
                    
                    applied = shockstick_applyemp( ent.domflag.trigger );
                    
                    if ( !applied )
                    {
                        continue;
                    }
                }
                
                if ( level.var_c7c34c7053a29846 )
                {
                    if ( ent.isredeploydrone && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                    {
                        applied = shockstick_applyemp( ent );
                        
                        if ( !applied )
                        {
                            continue;
                        }
                    }
                }
                
                if ( level.deployablekiosks.var_fe3437bbc52ad866 )
                {
                    if ( ent.type == "portable_buy_drone" && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                    {
                        if ( ent.team == self.owner.team )
                        {
                            continue;
                        }
                        
                        applied = shockstick_applyemp( ent );
                        
                        if ( !applied )
                        {
                            continue;
                        }
                    }
                }
                
                if ( level.deployablekiosks.var_e253c9f921155d75 )
                {
                    if ( ent.type == "deployable_buystation" && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                    {
                        if ( ent.team == self.owner.team )
                        {
                            continue;
                        }
                        
                        applied = shockstick_applyemp( ent );
                        
                        if ( !applied )
                        {
                            continue;
                        }
                    }
                }
            }
            
            if ( !ent shockstick_canbehaywire( self ) )
            {
                print( "<dev string:x9b>" + ent getentitynumber() + "<dev string:xc5>" );
                continue;
            }
            
            print( "<dev string:x9b>" + ent getentitynumber() + "<dev string:xd3>" );
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                damagedone = 0;
                isswimming = ent isswimming();
                
                if ( isswimming )
                {
                    ent dodamage( electrocutedamage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper" );
                    damagedone += electrocutedamage;
                }
                
                if ( self.var_9a80172827e94fb6 )
                {
                    ent dodamage( self.arcdamage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper" );
                    damagedone += self.arcdamage;
                }
                
                if ( isdefined( ent.perks[ "specialty_shock_immunity" ] ) )
                {
                    if ( damagedone > 0 )
                    {
                        thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #healthdamage:damagedone, #victim:ent, #attacker:self.owner, #grenade:self } );
                    }
                    
                    continue;
                }
                
                thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #healthdamage:damagedone, #victim:ent, #attacker:self.owner, #grenade:self } );
                
                if ( !isswimming )
                {
                    if ( ent != self.owner )
                    {
                        if ( isdefined( ent.perks[ "specialty_tac_resist" ] ) || isdefined( ent.perks[ "specialty_shock_resist" ] ) )
                        {
                            if ( damagefeedback::isusingstackablehitmarker() )
                            {
                                stackablehitmarkerdata = damagefeedback::function_63bdec1d3fd95d25( 1, ent, 0, objweapon );
                                stackablehitmarkerdata.soundtypeoverride = 3;
                                self.owner damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1, undefined, undefined, undefined, stackablehitmarkerdata, undefined, undefined, 2 );
                            }
                            else
                            {
                                self.owner damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
                            }
                        }
                        else if ( damagefeedback::isusingstackablehitmarker() )
                        {
                            stackablehitmarkerdata = damagefeedback::function_63bdec1d3fd95d25( 1, ent, 0 );
                            stackablehitmarkerdata.soundtypeoverride = 3;
                            self.owner damagefeedback::updatedamagefeedback( "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, stackablehitmarkerdata, undefined, undefined, 2 );
                        }
                        else
                        {
                            self.owner damagefeedback::updatedamagefeedback( "" );
                        }
                    }
                }
                
                if ( ent != self.owner )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
                    {
                        if ( isdefined( self.owner.leaderboarddata[ "shockStickHits" ] ) )
                        {
                            self.owner.leaderboarddata[ "shockStickHits" ] = self.owner.leaderboarddata[ "shockStickHits" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "shockStickHits" ] ) )
                        {
                            [[ level.leaderboardfunc[ "shockStickHits" ] ]]( self.owner, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe3>" );
                        
                        if ( isdefined( self.owner.pers[ "shockStickHits" ] ) )
                        {
                            self.owner.pers[ "shockStickHits" ] = self.owner.pers[ "shockStickHits" ] + 1;
                        }
                    }
                }
                
                self.owner thread function_fa14725672b3e4ff( ent getentitynumber(), self getentitynumber() );
            }
            
            if ( var_eec5eb1cbf64e024 )
            {
                self.initialhaywire[ self.initialhaywire.size ] = ent;
            }
            
            print( "<dev string:x9b>" + ent getentitynumber() + "<dev string:x109>" );
            thread shockstick_applyhaywire( ent, objweapon, var_eec5eb1cbf64e024 );
            function_6c143baef8998c80( ent );
            waitframe();
        }
        
        if ( var_6dd1cac20dc0a3ad )
        {
            scriptables = getentitylessscriptablearray( undefined, undefined, self.origin, detonationradius );
            
            foreach ( scriptable in scriptables )
            {
                if ( !level.var_c7c34c7053a29846 && scriptable.isredeploydrone )
                {
                    continue;
                }
                
                if ( isdefined( scriptable.var_5b3dbacfeda0fd01 ) )
                {
                    if ( scriptable.activeteam == self.owner.team )
                    {
                        continue;
                    }
                    
                    applied = shockstick_applyemp( scriptable );
                    
                    if ( !applied )
                    {
                        continue;
                    }
                }
                
                waitframe();
            }
        }
        
        self.ticks++;
        wait self.tickrate;
    }
    
    if ( self isscriptable() )
    {
        shockstick_destroy();
    }
}

// Namespace shock_stick
// Params 2
// Checksum 0x5d450aaf, Offset: 0x322e
// Size: 0xe4
function function_30b85490f96d9af1( ent, trigger )
{
    if ( !( isdefined( ent ) && isdefined( trigger ) ) )
    {
        return;
    }
    
    if ( !isdefined( trigger.arcvictims ) )
    {
        trigger.arcvictims = [];
    }
    
    trigger.arcvictims = arraycombineunique( trigger.arcvictims, [ ent ] );
    
    foreach ( owner in trigger.owners )
    {
        owner thread points::doscoreevent( #"hash_48a9288d80d93e78" );
    }
}

// Namespace shock_stick
// Params 2
// Checksum 0xecceed53, Offset: 0x331a
// Size: 0x40
function function_90a21a08c2edf491( ent, trigger )
{
    if ( !( isdefined( ent ) && isdefined( trigger ) ) )
    {
        return;
    }
    
    trigger.arcvictims = arrayremove( trigger.arcvictims, ent );
}

// Namespace shock_stick
// Params 1
// Checksum 0xeba7dfee, Offset: 0x3362
// Size: 0xa8, Type: bool
function shockstick_applyemp( ent )
{
    if ( !isdefined( ent.lastshockstick ) )
    {
        ent.lastshockstick = self;
    }
    else if ( ent.lastshockstick == self )
    {
        return false;
    }
    else
    {
        ent.lastshockstick = self;
    }
    
    data = spawnstruct();
    data.time = 5;
    data.attacker = self.owner;
    data.reason = "SHOCK_STICK";
    ent thread [[ ent.var_5b3dbacfeda0fd01 ]]( data );
    return true;
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x7e2a9d02, Offset: 0x3413
// Size: 0x14f
function private function_fa14725672b3e4ff( victimentnum, shockstickentnum )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_4f1c15d757e28f37 ) )
    {
        self.var_4f1c15d757e28f37 = [];
    }
    
    if ( !isdefined( victimentnum ) || !isdefined( shockstickentnum ) )
    {
        return;
    }
    
    self.var_4ae408b3e79fd97f[ victimentnum ] = [ gettime(), shockstickentnum ];
    
    if ( !arraycontains( self.var_4f1c15d757e28f37, shockstickentnum ) )
    {
        self.var_4f1c15d757e28f37[ self.var_4f1c15d757e28f37.size ] = shockstickentnum;
    }
    
    wait 2;
    
    if ( isdefined( self.var_4f1c15d757e28f37 ) )
    {
        ss_index = function_f02c63b99c9614c9( self.var_4f1c15d757e28f37, shockstickentnum );
        
        if ( isdefined( ss_index ) )
        {
            self.var_4f1c15d757e28f37[ ss_index ] = undefined;
            function_5713d46873b29625( self.var_4f1c15d757e28f37 );
            
            if ( self.var_4f1c15d757e28f37.size == 0 )
            {
                self.var_4f1c15d757e28f37 = undefined;
            }
        }
    }
    
    if ( isdefined( self.var_4ae408b3e79fd97f ) )
    {
        if ( gettime() - ( self.var_4ae408b3e79fd97f[ victimentnum ][ 0 ] ?? 0 ) >= 2000 )
        {
            self.var_4ae408b3e79fd97f[ victimentnum ] = undefined;
            function_5713d46873b29625( self.var_4ae408b3e79fd97f );
            
            if ( self.var_4ae408b3e79fd97f.size == 0 )
            {
                self.var_4ae408b3e79fd97f = undefined;
            }
        }
    }
}

// Namespace shock_stick
// Params 1, eflags: 0xc
// Checksum 0x991b7dd5, Offset: 0x356a
// Size: 0x9a
function private function_1b56b9866489f0bc( shockstickentnum )
{
    self notify( #"hash_cb20ea4f9543ece4" );
    self endon( #"hash_cb20ea4f9543ece4" );
    self endon( #"disconnect" );
    wait 2;
    
    if ( isdefined( self.var_418bbadd7a23d27d ) )
    {
        self.var_418bbadd7a23d27d[ shockstickentnum ] = undefined;
        
        if ( self.var_418bbadd7a23d27d.size == 0 )
        {
            self.var_418bbadd7a23d27d = undefined;
        }
    }
    
    if ( isdefined( self.var_4f1c15d757e28f37[ shockstickentnum ] ) )
    {
        self.var_4f1c15d757e28f37[ shockstickentnum ] = undefined;
        
        if ( self.var_4f1c15d757e28f37.size == 0 )
        {
            self.var_4f1c15d757e28f37 = undefined;
        }
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x888c522e, Offset: 0x360c
// Size: 0x101
function onplayerlaststand( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !function_fc585aa2ae70c760( attacker, victim ) )
    {
        return;
    }
    
    function_a7e25c172287a9d5( victim, attacker );
    shockstickentnum = function_9c16e67c9b5444db( attacker, victim );
    
    if ( !isdefined( shockstickentnum ) )
    {
        return;
    }
    
    shockstruct = {};
    
    if ( !isdefined( data.callbackeventdata ) )
    {
        data.callbackeventdata = [];
    }
    
    data.callbackeventdata[ "equip_shockstick" ] = shockstruct;
    
    if ( attacker.var_418bbadd7a23d27d[ shockstickentnum ] == 2 )
    {
        shockstruct.var_851e18fd344212db = 1;
    }
    
    if ( attacker.var_418bbadd7a23d27d[ shockstickentnum ] == 3 )
    {
        shockstruct.var_b50e303a13353a38 = 1;
    }
    
    attacker.var_421ca81478fc2aef = 1;
    attacker thread function_1b56b9866489f0bc( shockstickentnum );
}

// Namespace shock_stick
// Params 1
// Checksum 0x6c85050e, Offset: 0x3715
// Size: 0x1f4
function onplayerdeath( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( data.iskillstreakweapon && !weapon::function_1344ad15d2d7bd21( data.objweapon ) )
    {
        return;
    }
    
    if ( victim.inlaststand )
    {
        laststanddowneddata = victim.laststanddowneddata;
        shockstruct = laststanddowneddata.callbackeventdata[ "equip_shockstick" ];
        
        if ( !isdefined( shockstruct ) )
        {
            return;
        }
        
        laststanddowneddata.attacker events::function_1df78f8cb7d682d0( victim.laststanddowneddata.objweapon );
        
        if ( shockstruct.var_851e18fd344212db )
        {
            laststanddowneddata.attacker thread points::doscoreevent( #"double_shocked", victim.laststanddowneddata.objweapon );
        }
        
        if ( shockstruct.var_b50e303a13353a38 )
        {
            laststanddowneddata.attacker thread points::doscoreevent( #"triple_tactical_kill", victim.laststanddowneddata.objweapon );
        }
        
        return;
    }
    
    if ( !function_fc585aa2ae70c760( attacker, victim ) )
    {
        return;
    }
    
    function_a7e25c172287a9d5( victim, attacker );
    shockstickentnum = function_9c16e67c9b5444db( attacker, victim );
    
    if ( !isdefined( shockstickentnum ) )
    {
        return;
    }
    
    attacker events::function_1df78f8cb7d682d0( data.objweapon );
    
    if ( attacker.var_418bbadd7a23d27d[ shockstickentnum ] == 2 )
    {
        attacker thread points::doscoreevent( #"double_shocked" );
    }
    
    if ( attacker.var_418bbadd7a23d27d[ shockstickentnum ] == 3 )
    {
        attacker thread points::doscoreevent( #"triple_tactical_kill" );
    }
    
    attacker.var_421ca81478fc2aef = 1;
    attacker thread function_1b56b9866489f0bc( shockstickentnum );
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x196eaa8, Offset: 0x3911
// Size: 0x38, Type: bool
function private function_fc585aa2ae70c760( attacker, victim )
{
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return false;
    }
    
    if ( !isdefined( attacker.var_4f1c15d757e28f37 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0xf630afbb, Offset: 0x3952
// Size: 0x42
function private function_a7e25c172287a9d5( victim, attacker )
{
    if ( isdefined( victim.shockstickgrenadeweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( victim.shockstickgrenadeweapon, 1, "killed_while_debuffed_by", undefined, attacker );
    }
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x20db8f5f, Offset: 0x399c
// Size: 0x123
function private function_9c16e67c9b5444db( attacker, victim )
{
    victimentnum = victim getentitynumber();
    
    foreach ( ssentnum in attacker.var_4f1c15d757e28f37 )
    {
        if ( ssentnum === attacker.var_4ae408b3e79fd97f[ victimentnum ][ 1 ] )
        {
            shockstickentnum = ssentnum;
            break;
        }
    }
    
    if ( !isdefined( shockstickentnum ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_418bbadd7a23d27d ) )
    {
        attacker.var_418bbadd7a23d27d = [];
    }
    
    if ( !isdefined( attacker.var_418bbadd7a23d27d[ shockstickentnum ] ) )
    {
        attacker.var_418bbadd7a23d27d[ shockstickentnum ] = 0;
    }
    
    attacker.var_418bbadd7a23d27d[ shockstickentnum ] += 1;
    return shockstickentnum;
}

// Namespace shock_stick
// Params 1
// Checksum 0xf25a780f, Offset: 0x3ac8
// Size: 0xe0
function function_6c143baef8998c80( ent )
{
    entisvehicle = ent vehicle::is_vehicle();
    
    if ( !entisvehicle )
    {
        if ( ent === self.owner )
        {
            return;
        }
        else if ( level.teambased )
        {
            if ( !( isdefined( ent.team ) && isdefined( self.team ) ) || !isenemyteam( ent.team, self.team ) )
            {
                return;
            }
        }
    }
    else if ( !vehicle::is_enemy_to_player( ent, self.owner ) )
    {
        return;
    }
    
    cooldownseconds = self.tableinfo.bundle.var_923956080b9c633b ?? 6;
    self.owner namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "shockStickHit", cooldownseconds );
}

// Namespace shock_stick
// Params 1
// Checksum 0xa5753cfc, Offset: 0x3bb0
// Size: 0x4b2
function function_a58153495f7f4240( victim )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    var_76ef953de2ba340e = self.tableinfo.bundle.var_9be7618649ee616f ?? 1;
    var_76cc873de293cd8c = self.tableinfo.bundle.var_9bc44f8649c7f221 ?? 1;
    chaindelay = var_76ef953de2ba340e < var_76cc873de293cd8c ? randomfloatrange( var_76ef953de2ba340e, var_76cc873de293cd8c ) : var_76ef953de2ba340e;
    wait chaindelay;
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    bundle = self.tableinfo.bundle;
    objweapon = makeweapon( "shock_stick_mp" );
    contents = [ "physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip" ];
    electrocutedamage = bundle.var_fcbedb2a111f91fd ?? 6;
    var_5d86fc37d682061a = bundle.var_2eaf6e9c4885615 ?? 3;
    var_d347aa4dc9f212f4 = bundle.var_6591f2c82f84f6b5 ?? 125;
    ents = entity::getentitiesinradius( victim.origin, var_d347aa4dc9f212f4, undefined, undefined, physics_createcontents( contents ) );
    targets = [];
    victimorigin = victim.origin;
    firsttimecheck = 1;
    maxdistance = -1;
    maxdistanceindex = 0;
    
    foreach ( ent in ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( ent == victim )
        {
            continue;
        }
        
        if ( isagent( ent ) || isplayer( ent ) )
        {
            if ( !ent function_16865da2b6cd8ad9( self, victim ) )
            {
                continue;
            }
            
            if ( level.teambased )
            {
                if ( self.team == ent.team )
                {
                    continue;
                }
            }
            
            if ( arraycontains( self.initialhaywire, ent ) )
            {
                continue;
            }
            
            if ( ent isswimming() )
            {
                ent dodamage( electrocutedamage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper" );
            }
            else if ( ent != self.owner )
            {
                self.owner damagefeedback::updatedamagefeedback( "" );
            }
            
            if ( targets.size < var_5d86fc37d682061a )
            {
                targetstruct = spawnstruct();
                targetstruct.ent = ent;
                targets[ targets.size ] = targetstruct;
                continue;
            }
            
            if ( firsttimecheck )
            {
                firsttimecheck = 0;
                
                for ( i = 0; i < targets.size ; i++ )
                {
                    targets[ i ].dist = distancesquared( victimorigin, targets[ i ].ent.origin );
                    
                    if ( targets[ i ].dist > maxdistance )
                    {
                        maxdistance = targets[ i ].dist;
                        maxdistanceindex = i;
                    }
                }
            }
            
            targetdist = distancesquared( victimorigin, ent.origin );
            
            if ( targetdist < maxdistance )
            {
                targets[ maxdistanceindex ].ent = ent;
                targets[ maxdistanceindex ].dist = targetdist;
                maxdistance = -1;
                maxdistanceindex = -1;
                
                for ( i = 0; i < targets.size ; i++ )
                {
                    if ( targets[ i ].dist > maxdistance )
                    {
                        maxdistance = targets[ i ].dist;
                        maxdistanceindex = i;
                    }
                }
            }
        }
    }
    
    foreach ( target in targets )
    {
        thread shockstick_applyhaywire( target.ent, objweapon, 0 );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x67a6fe70, Offset: 0x406a
// Size: 0x2d5
function function_a19ec6b53a18c3c5( stuckdata )
{
    self endon( #"death" );
    self setscriptablepartstate( #"beacon", #"active", 0 );
    contents = [ "physicscontents_item", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip" ];
    dohaywire = 0;
    bundle = self.tableinfo.bundle;
    triggerradius = bundle.var_5893c8e694c3c228 ?? 125;
    
    while ( !dohaywire )
    {
        if ( !isdefined( self.owner ) )
        {
            shockstick_destroy();
        }
        
        if ( self.isjammed )
        {
            waitframe();
            continue;
        }
        
        ents = entity::getentitiesinradius( self.origin, triggerradius, undefined, undefined, physics_createcontents( contents ) );
        
        if ( isdefined( self.arcvictims ) )
        {
            foreach ( victim in self.arcvictims )
            {
                ents = arraycombineunique( ents, [ victim ] );
            }
        }
        
        foreach ( ent in ents )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent == self )
            {
                continue;
            }
            
            if ( !isagent( ent ) && !isplayer( ent ) )
            {
                continue;
            }
            
            if ( isdefined( ent.perks[ "specialty_lightfoot" ] ) && self.stuckto != ent )
            {
                continue;
            }
            
            if ( ent.var_ff102e941e8065c )
            {
                delayapplied = equipment_mp::function_84f2f5566ba29655( ent, ent.var_ff102e941e8065c, triggerradius );
                
                if ( delayapplied )
                {
                    continue;
                }
            }
            
            if ( !ent shockstick_canbehaywire( self ) )
            {
                continue;
            }
            
            dohaywire = 1;
        }
        
        if ( !dohaywire )
        {
            waitframe();
        }
    }
    
    self setscriptablepartstate( #"electric", #"active", 0 );
    self setscriptablepartstate( #"detonate", #"detonate", 0 );
    thread function_1d426c8b1b9484bb();
}

// Namespace shock_stick
// Params 1
// Checksum 0xc0549a9b, Offset: 0x4347
// Size: 0x17c
function function_4b12e71f283462c4( victim )
{
    victim endon( #"haywire_cleared" );
    self endon( #"death" );
    
    if ( !isdefined( self.var_d6b8b3b84549fb9f ) )
    {
        self.var_d6b8b3b84549fb9f = [];
    }
    
    if ( !isdefined( self.var_d6b8b3b84549fb9f[ victim getentitynumber() ] ) )
    {
        self.var_d6b8b3b84549fb9f[ victim getentitynumber() ] = 0;
    }
    
    bundle = self.tableinfo.bundle;
    maxduration = bundle.var_c8bb02c8c8cd0442 ?? 100;
    
    while ( true )
    {
        self.var_d6b8b3b84549fb9f[ victim getentitynumber() ] += 0.05;
        
        if ( player::function_74a9f49efde97961( victim ) )
        {
            if ( !isdefined( self.challengedata ) )
            {
                self.challengedata = {};
            }
            
            if ( !isdefined( self.challengedata.bitmodifiers ) )
            {
                self.challengedata.bitmodifiers = [];
            }
            
            self.challengedata.bitmodifiers = arraycombineunique( self.challengedata.bitmodifiers, [ #"hash_4b588ee27b41bd0f" ] );
        }
        
        if ( self.var_d6b8b3b84549fb9f[ victim getentitynumber() ] >= maxduration )
        {
            victim notify( #"haywire_max_duration" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace shock_stick
// Params 4
// Checksum 0xc45e95cf, Offset: 0x44cb
// Size: 0x267
function shockstick_applyhaywire( victim, objweapon, chain, vfxstate )
{
    level endon( #"game_ended" );
    victim endon( #"disconnect" );
    victim notify( #"shockstick_haywireapplied" );
    victim endon( #"shockstick_haywireapplied" );
    assert( isdefined( victim ), "<dev string:x11a>" );
    assert( isdefined( objweapon ), "<dev string:x14c>" );
    
    if ( isplayer( victim ) )
    {
        victim thread mtx_weapon::function_3c5b3042f8d8a4f7();
        
        if ( level.equipment.var_aeff9a3b25965912 )
        {
            callback::callback( #"hash_5bfa36b3dc1a524b", { #ref:"shocked", #attacker:self.owner, #victim:victim, #equipment:"equip_shockstick" } );
        }
    }
    
    data = damage_utility::packdamagedata( self.owner, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
    
    if ( vfxstate )
    {
        data.vfxstate = vfxstate;
    }
    
    function_c3e4ab2f908e3421();
    
    if ( chain )
    {
        childthread function_a58153495f7f4240( victim );
    }
    
    if ( isplayer( victim ) || isagent( victim ) )
    {
        childthread function_4b12e71f283462c4( victim );
    }
    
    shockstick_applyhaywirestruct( data );
    result = function_91912910551a1283( data );
    fromdeath = 0;
    
    if ( isplayer( data.victim ) || isagent( data.victim ) )
    {
        fromdeath = !player::isreallyalive( data.victim ) || player::isinlaststand( data.victim );
        data.victim function_3b842f42dbb783cf( fromdeath, self.owner, objweapon );
    }
    
    challengeparams = { #effectref:"shocked", #duration:0, #equipmentref:"equip_shockstick", #equipmentent:self, #victim:victim, #attacker:self.owner };
    callback::callback( #"hash_10e686549630fd9f", challengeparams );
    function_396a585ccd7071f5( data, fromdeath );
}

// Namespace shock_stick
// Params 3
// Checksum 0xc5076033, Offset: 0x473a
// Size: 0x124
function function_3b842f42dbb783cf( fromdeath, shockowner, objweapon )
{
    if ( fromdeath )
    {
        waitframe();
        
        if ( !( isdefined( self ) && isdefined( shockowner ) ) )
        {
            return;
        }
        else if ( isdefined( self.attackers ) )
        {
            foreach ( attacker in self.attackers )
            {
                function_821af06722c9bf17( attacker, self, shockowner, objweapon );
            }
        }
        else if ( isdefined( attacker ) )
        {
            function_821af06722c9bf17( attacker, self, shockowner, objweapon );
        }
        
        if ( self.lastkilledby == shockowner )
        {
            var_2af095c1d27d568d = gettime();
            shockowner thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "debuff_kills" );
            shockowner telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, shockowner, var_2af095c1d27d568d, objweapon );
            return;
        }
        
        shockowner thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "debuff_assists" );
    }
}

// Namespace shock_stick
// Params 4
// Checksum 0xc4f327da, Offset: 0x4866
// Size: 0xa8
function function_821af06722c9bf17( attacker, victim, owner, objweapon )
{
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return;
    }
    
    if ( attacker == owner )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( player::isinlaststand( victim ) )
    {
        if ( !isdefined( victim.var_4b1550856e654943 ) )
        {
            victim.var_4b1550856e654943 = [];
        }
        
        victim.var_4b1550856e654943 = arraycombineunique( victim.var_4b1550856e654943, [ owner ] );
        return;
    }
    
    owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_105b493d63214015" );
}

// Namespace shock_stick
// Params 0
// Checksum 0xf2accb37, Offset: 0x4916
// Size: 0xc
function function_c3e4ab2f908e3421()
{
    self.var_3ded14e19d81ef7e = undefined;
}

// Namespace shock_stick
// Params 1
// Checksum 0x556a885d, Offset: 0x492a
// Size: 0x282
function shockstick_applyhaywirestruct( data )
{
    assert( isdefined( data ), "<dev string:x188>" );
    assert( isdefined( data.attacker ), "<dev string:x1bd>" );
    assert( isdefined( data.victim ), "<dev string:x1fd>" );
    assert( isdefined( data.objweapon ), "<dev string:x23b>" );
    assert( isweapon( data.objweapon ), "<dev string:x27c>" );
    assert( isdefined( data.inflictor ), "<dev string:x2c3>" );
    
    if ( !isdefined( data.damage ) )
    {
        data.damage = 1;
    }
    
    if ( !isdefined( data.meansofdeath ) )
    {
        data.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( !isdefined( data.point ) )
    {
        data.point = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.direction_vec ) )
    {
        data.direction_vec = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.modelname ) )
    {
        data.modelname = 0;
    }
    
    if ( !isdefined( data.partname ) )
    {
        data.partname = "";
    }
    
    if ( !isdefined( data.tagname ) )
    {
        data.tagname = 0;
    }
    
    if ( !isdefined( data.damageflags ) )
    {
        data.damageflags = 0;
    }
    
    if ( !isdefined( data.hitloc ) )
    {
        data.hitloc = "none";
    }
    
    if ( !isdefined( data.timeoffset ) )
    {
        data.timeoffset = 0;
    }
    
    if ( !data.var_b688bbdf5036e88e )
    {
        data.var_b688bbdf5036e88e = 0;
    }
    
    if ( !data.var_f3b6e148094e7137 )
    {
        data.var_f3b6e148094e7137 = 0;
    }
    
    if ( isagent( data.victim ) )
    {
        thread shockstick_haywireagent( data );
        return;
    }
    
    if ( isplayer( data.victim ) )
    {
        thread function_5f89a63c19349cd5( data );
        return;
    }
    
    if ( entity::isturret( data.victim ) && !haywire::function_8238cd34bd133b52( data.victim ) )
    {
        thread function_cd1e9f6afbf90d3a( data );
        return;
    }
    
    thread function_9891ed88bcd38fd2( data );
}

// Namespace shock_stick
// Params 1
// Checksum 0x7f1a51bd, Offset: 0x4bb4
// Size: 0xeb
function function_cd1e9f6afbf90d3a( data )
{
    level endon( #"game_ended" );
    data.victim endon( #"death" );
    data.victim endon( #"haywire_cleared" );
    
    if ( data.victim.ishaywire )
    {
        return;
    }
    
    data.victim.ishaywire = 1;
    data.victim.shockstickgrenadeweapon = self.weapon_object;
    turretweapon = data.victim.objweapon;
    
    if ( !isdefined( turretweapon ) )
    {
        return;
    }
    
    turretuser = data.victim.owner;
    
    if ( !isdefined( turretuser ) )
    {
        return;
    }
    
    turretuser startforcedfire();
}

// Namespace shock_stick
// Params 2
// Checksum 0xb623c169, Offset: 0x4ca7
// Size: 0xd3
function function_91912910551a1283( data, var_363e132bd47a1fc2 )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    data.victim childthread function_308429e4f8b00b34();
    bundle = self.tableinfo.bundle;
    haywireduration = var_363e132bd47a1fc2 ?? bundle.var_860545b754d7ecc0 ?? 0.25;
    haywireduration = getdvarfloat( @"hash_e66e541920ac9101", haywireduration );
    result = data.victim utility::waittill_any_timeout( haywireduration, "haywire_cleared", "haywire_max_duration", "shockstick_interrupt", "killed_player", "last_stand_enter" );
    return result;
}

// Namespace shock_stick
// Params 0
// Checksum 0xb11b6092, Offset: 0x4d83
// Size: 0x42
function function_308429e4f8b00b34()
{
    self endon( #"haywire_cleared" );
    self endon( #"haywire_max_duration" );
    
    while ( true )
    {
        if ( isplayer( self ) )
        {
            if ( self isinexecutionvictim() )
            {
                self notify( #"shockstick_interrupt" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace shock_stick
// Params 2
// Checksum 0xf5f20555, Offset: 0x4dcd
// Size: 0x1d3
function function_904e61c3aefb61c2( ishaywire, var_7117a3496062c73d )
{
    if ( ishaywire )
    {
        val::set( "haywire_controls", "sprint", 0 );
        val::set( "haywire_controls", "supersprint", 0 );
        val::set( "haywire_controls", "ads", 0 );
        val::set( "haywire_controls", "weapon_switch", 0 );
        val::set( "haywire_controls", "weapon_pickup", 0 );
        val::set( "haywire_controls", "ascender_use", 0 );
        val::set( "haywire_controls", "autoreload", 0 );
        val::set( "haywire_controls", "reload", 0 );
        val::set( "haywire_controls", "mantle", 0 );
        val::set( "haywire_controls", "weapon_switch_clip", 0 );
        val::set( "haywire_controls", "melee", 0 );
        val::set( "haywire_controls", "offhand_throwback", 0 );
        val::set( "haywire_controls", "offhand_weapons", 0 );
        val::set( "haywire_controls", "supers", 0 );
        val::set( "haywire_controls", "usability", 0 );
        val::set( "haywire_controls", "interactions", 0 );
        val::set( "haywire_controls", "ladder", 0 );
        val::set( "haywire_controls", "execution_attack", 0 );
        
        if ( nvg::function_c58b7b66805088f5() )
        {
            val::set( "haywire_controls", "nvg", 0 );
        }
        
        player::codcastersetplayerstatuseffect( "shock", -1 );
        
        if ( var_7117a3496062c73d )
        {
            val::set( "haywire_controls", "fire", 0 );
        }
        
        self setshocked( 1, 0.5 );
        return;
    }
    
    val::reset_all( "haywire_controls" );
    self setshocked( 0, 0.5 );
    player::codcastersetplayerstatuseffect( "shock", 0 );
}

// Namespace shock_stick
// Params 2
// Checksum 0xe6cae1c3, Offset: 0x4fa8
// Size: 0x1b0
function function_5f89a63c19349cd5( var_ed2c165091bf4dd5, bundle )
{
    victim = var_ed2c165091bf4dd5.victim;
    attacker = var_ed2c165091bf4dd5.attacker;
    objweapon = var_ed2c165091bf4dd5.objweapon;
    print( "<dev string:x304>" );
    level endon( #"game_ended" );
    
    if ( victim.ishaywire || victim utility::isusingremote() || !player::isreallyalive( victim ) )
    {
        return;
    }
    
    if ( isdefined( attacker.var_c36269996253c559.var_4e0caacb60f9e217 ) && victim [[ attacker.var_c36269996253c559.var_4e0caacb60f9e217 ]]( objweapon, attacker, "MOD_GRENADE_SPLASH" ) )
    {
        if ( isdefined( attacker.var_c36269996253c559.var_11a45d4b82e41038 ) )
        {
            victim thread [[ attacker.var_c36269996253c559.var_11a45d4b82e41038 ]]( attacker, self );
        }
    }
    
    victim.ishaywire = 1;
    victim.shockstickgrenadeweapon = self.weapon_object;
    
    if ( !isdefined( bundle ) )
    {
        bundle = level.equipment.table[ "equip_shockstick" ].bundle;
    }
    
    victim thread function_85325bfe497746ba( var_ed2c165091bf4dd5, bundle );
    
    if ( objweapon && !bundle.var_4c6cc0f99efbb64f && weapon_utility::isgrenadeweapon( objweapon ) )
    {
        challenges::function_3d7a169dbae062fb( "equip_shockstick", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    }
}

// Namespace shock_stick
// Params 2, eflags: 0x4
// Checksum 0x220fc033, Offset: 0x5160
// Size: 0x36c
function private function_85325bfe497746ba( var_ed2c165091bf4dd5, bundle )
{
    attacker = var_ed2c165091bf4dd5.attacker;
    objweapon = var_ed2c165091bf4dd5.objweapon;
    level endon( #"game_ended" );
    
    if ( game_utility::getgametype() == "rescue" )
    {
        if ( isdefined( self.carryobject ) )
        {
            hostage = self.carryobject;
            hostage gameobjects::setdropped( 0 );
            hostage rescue::hostage_forcedrop( self );
            
            if ( isnullweapon( self getcurrentweapon() ) )
            {
                foreach ( weap in self.primaryweapons )
                {
                    if ( !isnullweapon( weap ) )
                    {
                        inventory_utility::domonitoredweaponswitch( weap, 1 );
                        break;
                    }
                }
            }
        }
    }
    else if ( isdefined( self.carryobject ) )
    {
        self notify( #"force_manual_drop" );
    }
    
    if ( self ishanging() )
    {
        self clearhanging();
    }
    
    var_3166aa89082d16f4 = haywire::function_8238cd34bd133b52( self );
    
    if ( var_3166aa89082d16f4 )
    {
        self thread [[ var_3166aa89082d16f4 ]]( var_ed2c165091bf4dd5 );
    }
    
    curweapon = self getcurrentweapon();
    gestureref = bundle.var_48a550bf2b8d7af3 ?? "vm_ges_shockstick_react";
    var_cecb8a84cc5afcc4 = isdefined( curweapon ) && function_cebf276742140d1d( curweapon );
    var_c7687d465794b18d = 0;
    
    if ( var_cecb8a84cc5afcc4 && self isalternatemode( curweapon ) )
    {
        self setalternatemode( curweapon, 0 );
        var_c7687d465794b18d = 1;
        waitframe();
    }
    
    if ( weapon::isfistweapon( curweapon ) )
    {
        gestureref = bundle.var_84e04f4a22bdb425 ?? "vm_ges_shockstick_react_fists";
    }
    
    if ( level.var_fca38a9adcb119d1 )
    {
        weaponref = "";
        
        if ( weapon::function_170e300815e9c1a2( curweapon ) )
        {
            weaponref = weapon::function_170e300815e9c1a2( curweapon );
        }
        
        if ( level.var_fca38a9adcb119d1[ weaponref ] )
        {
            gestureref = level.var_fca38a9adcb119d1[ weaponref ];
        }
    }
    
    islauncher = isdefined( curweapon ) && weaponclass( curweapon ) == "rocketlauncher";
    var_ed91cd75e13e489c = isdefined( curweapon ) && function_f626ad1bef78c107( curweapon );
    var_7117a3496062c73d = islauncher || var_ed91cd75e13e489c;
    var_c32821c8bb63e729 = getdvarint( @"hash_9eeb398153f70e19", 1 );
    
    if ( var_c32821c8bb63e729 )
    {
        function_904e61c3aefb61c2( 1, var_7117a3496062c73d );
    }
    
    self function_61089c118e376955( 1 );
    
    if ( player_utility::function_cdedd9a19069ca4c( self ) )
    {
        self.var_45ab03788f1a0a4d = 1;
    }
    
    if ( isdefined( bundle.var_e92504c2b2f419a8 ) )
    {
        [[ bundle.var_e92504c2b2f419a8 ]]();
    }
    else
    {
        function_a986163e6356d32a( objweapon, var_ed2c165091bf4dd5.vfxstate );
    }
    
    childthread function_4cd1590989d6701( bundle );
    
    if ( var_c32821c8bb63e729 )
    {
        childthread function_2ea7dfd90ad1b57d( gestureref, undefined );
    }
    
    if ( !self.var_192ff6d823148f9a && !attacker.var_f134573d7e5fed4f )
    {
        childthread function_fd690ed96d43dd99( bundle );
    }
    
    childthread function_5a06848ea4a5dd80( bundle );
    childthread function_97f59ce5db3d42a6( bundle, var_7117a3496062c73d, var_cecb8a84cc5afcc4 );
    meatshield::function_db06fbfec0ffa2eb();
    self notify( #"player_ishaywire" );
}

// Namespace shock_stick
// Params 1
// Checksum 0x8a5a878, Offset: 0x54d4
// Size: 0xd0
function function_4cd1590989d6701( bundle )
{
    self endon( #"death_or_disconnect" );
    movespeedscale = getdvarfloat( @"hash_d677956e73b3bfb4", 0.8 );
    movespeedscale = bundle.var_9342451ed3d7db03 ?? movespeedscale;
    
    if ( !isdefined( self.perks[ "specialty_tac_resist" ] ) && !isdefined( self.perks[ "specialty_shock_resist" ] ) )
    {
        self setmovespeedscale( movespeedscale );
        
        while ( !self isswimming() && self.ishaywire )
        {
            wait 0.1;
        }
        
        weapons::updatemovespeedscale();
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_veteran" ] ) )
    {
        namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
        return;
    }
    
    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_tac_resist" );
}

// Namespace shock_stick
// Params 2
// Checksum 0x72e385e0, Offset: 0x55ac
// Size: 0x166
function function_2ea7dfd90ad1b57d( gestureref, grenade )
{
    self endon( #"death_or_disconnect" );
    self endon( #"haywire_cleared" );
    
    while ( self function_7d9f109338409783() )
    {
        waitframe();
    }
    
    while ( self isgestureplaying( gestureref ) )
    {
        if ( !self.ishaywire )
        {
            return;
        }
        
        waitframe();
    }
    
    curweapon = utility::function_64003742d8f5c781( self getcurrentweapon() );
    weaponref = weapon::function_170e300815e9c1a2( curweapon );
    
    if ( self isswitchingweapon() )
    {
        weaponswitchto = self function_ca1904a5dd87fd53();
        
        if ( weaponswitchto )
        {
            curweapon = utility::function_64003742d8f5c781( weaponswitchto );
            weaponref = weapon::function_170e300815e9c1a2( curweapon );
        }
    }
    
    var_82d487f644ca8867 = self getheldoffhand();
    
    if ( isdefined( curweapon ) && curweapon.basenamehash != %"none" && !weapon::isakimbo( curweapon ) && curweapon.basenamehash != %"iw9_me_sword01_mp" && ( isnullweapon( var_82d487f644ca8867 ) || !var_82d487f644ca8867.isfieldupgrade ) )
    {
        gestureref = function_272df1526383be08( curweapon );
        
        if ( self.var_386d13820628c200 != weaponref )
        {
            curweapon = utility::function_64003742d8f5c781( weaponswitchto );
            weaponref = weapon::function_170e300815e9c1a2( curweapon );
            gestureref = function_272df1526383be08( curweapon );
        }
        
        self forceplaygestureviewmodel( gestureref );
        self.var_ac0eae4ff18c28e5 = gestureref;
    }
}

// Namespace shock_stick
// Params 3
// Checksum 0xf7addf7f, Offset: 0x571a
// Size: 0x75
function function_97f59ce5db3d42a6( bundle, var_7117a3496062c73d, var_c7687d465794b18d )
{
    self endon( #"death_or_disconnect" );
    
    if ( bundle.var_49bb7ce47fe491e0 )
    {
        self setaimspreadmovementscale( bundle.var_6c1eb73e3429f18f );
        self function_3c23baaaad4a0695( bundle.var_cdecaa2fadd9b51d );
    }
    
    if ( bundle.var_bd94b71ffdfd39c && !var_7117a3496062c73d )
    {
        self startforcedfire();
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x923eb9f4, Offset: 0x5797
// Size: 0x5d
function function_fd690ed96d43dd99( bundle )
{
    self endon( #"death_or_disconnect" );
    
    if ( bundle.var_f3447a3874df563f )
    {
        self setempjammed( 1 );
        self.haywiretimestamp = gettime();
    }
    
    self waittill( #"haywire_cleared" );
    
    if ( bundle.var_f3447a3874df563f )
    {
        self setempjammed( 0 );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xdf8bd1ca, Offset: 0x57fc
// Size: 0x52
function function_5a06848ea4a5dd80( bundle )
{
    self endon( #"death_or_disconnect" );
    
    if ( bundle.var_b110dbf60f7e2c47 )
    {
        function_ef03efbecb279b8a( 1 );
    }
    
    self waittill( #"haywire_cleared" );
    
    if ( bundle.var_b110dbf60f7e2c47 )
    {
        function_ef03efbecb279b8a( 0 );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xd364e4a6, Offset: 0x5856
// Size: 0x9e
function function_7197db4cd82cbd52( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( function_6ca968da6531e6a4( weapobj ) )
    {
        return 1;
    }
    
    if ( weapon::issuperuseweapon( weapobj ) )
    {
        return 0;
    }
    
    if ( weapon::function_42e884104fc16220( weapobj ) )
    {
        return 1;
    }
    
    if ( weapon::isdeploytablet( weapobj ) )
    {
        return 1;
    }
    
    if ( weapon::iskillstreakweapon( weapobj ) || weapon::issuperweapon( weapobj ) )
    {
        return 1;
    }
    
    if ( killstreak_utility::function_8bec29aceea719c3( weapobj ) || superdeploy::function_dac4a41a0ff10a48( weapobj ) )
    {
        return 1;
    }
    
    if ( helper_drone::function_91d1cd88e72287( weapobj ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace shock_stick
// Params 1
// Checksum 0x6fbc59aa, Offset: 0x58fc
// Size: 0x13e
function function_6ca968da6531e6a4( weapon )
{
    tableinfo = level.equipment.table[ "equip_shockstick" ];
    
    if ( isdefined( tableinfo.stowedweapons ) )
    {
        foreach ( stowedweapon in tableinfo.stowedweapons )
        {
            if ( stowedweapon.stowedweapon == weapon.basename )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    switch ( weapon.basenamehash )
    {
        case %"c4_mp":
        case %"hb_sensor_mp":
        case %"adrenaline_mp":
        case %"teammate_revive_stim_mp":
        case %"offhand_spotter_scope_mp":
        case %"briefcase_bomb_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xe12628d2, Offset: 0x5a42
// Size: 0x3f
function function_3bd9867060459c34( weaponnamehash )
{
    switch ( weaponnamehash )
    {
        case %"electric_discharge_mp":
        case %"super_laser_charge_mp":
            return 0;
        default:
            return 1;
    }
}

// Namespace shock_stick
// Params 1, eflags: 0x4
// Checksum 0xcff7ab4f, Offset: 0x5a89
// Size: 0x3c
function private function_9e91207191c2a1af( shockstick )
{
    currentweapon = undefined;
    
    if ( weapon::grenadeinpullback() )
    {
        currentweapon = weapon::getgrenadeinpullback();
    }
    
    if ( !isdefined( currentweapon ) )
    {
        currentweapon = self.currentweapon;
    }
    
    return currentweapon;
}

// Namespace shock_stick
// Params 1
// Checksum 0xb20ea565, Offset: 0x5ace
// Size: 0x2b2
function function_6978e1294bb94402( shockstick )
{
    print( "<dev string:x315>" );
    self endon( #"death_or_disconnect" );
    shockstick endon( #"death" );
    currentweapon = function_9e91207191c2a1af( shockstick );
    
    if ( !isdefined( currentweapon ) || isnullweapon( currentweapon ) )
    {
        return 1;
    }
    
    if ( shockstick.owner == self && currentweapon.basenamehash == %"shock_stick_mp" )
    {
        return 1;
    }
    
    if ( !function_3bd9867060459c34( currentweapon.basenamehash ) )
    {
        return 0;
    }
    
    if ( !currentweapon.var_3d24307493bd5ab )
    {
        return 1;
    }
    
    ammocount = self getweaponammoclip( currentweapon );
    
    if ( ammocount <= 0 )
    {
        return 1;
    }
    
    if ( self.var_9d46480598e68297 )
    {
        return 0;
    }
    
    shouldstowweapon = function_7197db4cd82cbd52( currentweapon );
    prevweapon = self.prevweaponobj;
    
    if ( !isdefined( prevweapon ) )
    {
        prevweapon = level.defaultfist;
    }
    
    print( "<dev string:x9b>" + self getentitynumber() + "<dev string:x32e>" );
    
    if ( !shouldstowweapon )
    {
        print( "<dev string:x9b>" + self getentitynumber() + "<dev string:x34f>" );
        var_bc953e90a77f36e = self.origin;
        equipmenttype = weapon::getequipmenttype( currentweapon );
        shoulddropweapon = !self function_7d9f109338409783();
        
        if ( !isdefined( equipmenttype ) )
        {
            return 1;
        }
        
        if ( equipmenttype == "tactical" )
        {
            var_bc953e90a77f36e = self gettagorigin( "tag_accessory_right" );
        }
        else if ( equipmenttype == "lethal" )
        {
            var_bc953e90a77f36e = self gettagorigin( "tag_accessory_left" );
        }
        
        if ( shoulddropweapon )
        {
            velocityvec = ( 0, 0, 0 );
            velocityvec += anglestoforward( self.angles ) * getdvarfloat( @"hash_c7f7fb9ea22e108f", 200 );
            velocityvec += anglestoup( self.angles ) * getdvarfloat( @"hash_b2d4c6bd7da9e85f", 100 );
            
            if ( !getdvarint( @"hash_a72432771f3b4378", 0 ) && self isthrowinggrenade() )
            {
                self canceloffhands();
                
                while ( self isthrowinggrenade() )
                {
                    waitframe();
                }
            }
            else
            {
                inventory_utility::getridofweapon( currentweapon, 1 );
            }
            
            inventory_utility::_giveweapon( currentweapon, undefined, undefined, 1 );
            droppedgrenade = weapon::_launchgrenade( currentweapon.basename, var_bc953e90a77f36e, velocityvec );
            self setweaponammoclip( currentweapon, ammocount - 1 );
            weapons::grenadeinitialize( droppedgrenade, currentweapon, 0, self );
            weapons::grenadeused( droppedgrenade );
        }
        
        return 1;
    }
    
    return function_774e8c70c50cca4f( currentweapon );
}

// Namespace shock_stick
// Params 0
// Checksum 0x37566fda, Offset: 0x5d88
// Size: 0x24, Type: bool
function function_56af225f9add06c5()
{
    return isdefined( self.var_100d1ec32fd4d973 ) && gettime() - self.var_100d1ec32fd4d973 < 0.5;
}

// Namespace shock_stick
// Params 1
// Checksum 0x50185464, Offset: 0x5db5
// Size: 0x14e
function function_774e8c70c50cca4f( currentweapon )
{
    print( "<dev string:x35d>" );
    
    if ( killstreak_utility::function_8bec29aceea719c3( currentweapon ) )
    {
        return 0;
    }
    
    if ( helper_drone::function_91d1cd88e72287( currentweapon ) )
    {
        return 0;
    }
    
    if ( weapon::function_42e884104fc16220( currentweapon ) )
    {
        self.var_45ab03788f1a0a4d = 1;
        self notify( #"cancel_location" );
        return 0;
    }
    
    if ( currentweapon.basenamehash == %"deploy_sentry_mp" || currentweapon.basenamehash == %"deploy_remote_turret_mp" )
    {
        self notify( #"equip_deploy_cancel" );
        return 1;
    }
    
    if ( currentweapon.basenamehash == %"deploy_loadout_drop_mp" )
    {
        print( "<dev string:x377>" );
        self notify( #"cancel_all_killstreak_deployments" );
        return 1;
    }
    
    if ( function_72205f1742102d05( currentweapon ) )
    {
        function_c6fbe3f220755dd9( currentweapon );
        
        if ( weapon::issuperweapon( currentweapon ) )
        {
            if ( function_56af225f9add06c5() )
            {
                supers_mp::refundsuper();
                
                if ( isdefined( self.var_c4c535d1f47c26f2 ) )
                {
                    self.var_c4c535d1f47c26f2 delete();
                }
            }
        }
        
        return 1;
    }
    
    if ( laststand::laststand_isreviveweapon( currentweapon ) )
    {
        self.var_3ded14e19d81ef7e = 1;
    }
    
    inventory_utility::getridofweapon( currentweapon, 1 );
    return 1;
}

// Namespace shock_stick
// Params 1
// Checksum 0x77bc7ab3, Offset: 0x5f0b
// Size: 0x113
function function_c6fbe3f220755dd9( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"killed_player" );
    level endon( #"game_ended" );
    ammoclip = self getweaponammoclip( weapon );
    ammostock = self getweaponammostock( weapon );
    inventory_utility::_takeweapon( weapon );
    wait 0.05;
    inventory_utility::_giveweapon( weapon, undefined, undefined );
    self setweaponammoclip( weapon, ammoclip );
    self setweaponammostock( weapon, ammostock );
    
    if ( weapon::issuperweapon( weapon ) )
    {
        self assignweaponoffhandspecial( weapon );
        return;
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( weapon );
    
    if ( isdefined( equipmentref ) )
    {
        slot = equipment_mp::findequipmentslot( equipmentref );
        assert( slot == "<dev string:x394>" || slot == "<dev string:x39c>", "<dev string:x3a6>" + equipmentref + "<dev string:x3bf>" );
        
        if ( slot == "primary" )
        {
            self assignweaponoffhandprimary( weapon );
            return;
        }
        
        if ( slot == "secondary" )
        {
            self assignweaponoffhandsecondary( weapon );
        }
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xa7b52b74, Offset: 0x6026
// Size: 0xd7, Type: bool
function function_cebf276742140d1d( weapon )
{
    tableinfo = level.equipment.table[ "equip_shockstick" ];
    
    if ( tableinfo.var_e877025b8a47dca0 )
    {
        foreach ( var_81ee6fcf3b8fc2f7 in tableinfo.var_e877025b8a47dca0 )
        {
            if ( var_81ee6fcf3b8fc2f7.altfireweapon == weapon.basename )
            {
                if ( self isalternatemode( weapon ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace shock_stick
// Params 1
// Checksum 0x94257f31, Offset: 0x6106
// Size: 0xd7, Type: bool
function function_f626ad1bef78c107( weapon )
{
    tableinfo = level.equipment.table[ "equip_shockstick" ];
    
    if ( tableinfo.var_a4f3cecf73e509a )
    {
        foreach ( var_31b825d617d8aefe in tableinfo.var_a4f3cecf73e509a )
        {
            if ( var_31b825d617d8aefe.var_5b4f9b416fc423f6 == weapon.basename )
            {
                if ( self isalternatemode( weapon ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace shock_stick
// Params 1
// Checksum 0x77c5caf, Offset: 0x61e6
// Size: 0x140
function function_72205f1742102d05( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    tableinfo = level.equipment.table[ "equip_shockstick" ];
    
    if ( tableinfo.var_5c22a55131667a8d )
    {
        foreach ( var_958f26d4f272504c in tableinfo.var_5c22a55131667a8d )
        {
            if ( var_958f26d4f272504c.var_958f26d4f272504c == weapon.basename )
            {
                return 1;
            }
        }
    }
    
    if ( weapon::issuperweapon( weaponobj ) )
    {
        return 1;
    }
    
    switch ( weaponobj.var_5e3a1c87edc1edd5 )
    {
        case #"c4":
        case #"spotter_scope":
        case #"adrenaline":
        case #"hb_sensor":
            return 1;
        default:
            return 0;
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xd33a2af8, Offset: 0x632e
// Size: 0x349
function shockstick_haywireagent( var_ed2c165091bf4dd5 )
{
    level endon( #"game_ended" );
    victim = var_ed2c165091bf4dd5.victim;
    attacker = var_ed2c165091bf4dd5.attacker;
    objweapon = var_ed2c165091bf4dd5.objweapon;
    inflictor = var_ed2c165091bf4dd5.inflictor;
    var_b688bbdf5036e88e = var_ed2c165091bf4dd5.var_b688bbdf5036e88e ?? 0;
    var_f3b6e148094e7137 = var_ed2c165091bf4dd5.var_f3b6e148094e7137 ?? 0;
    var_d7e160d46b65574f = var_ed2c165091bf4dd5.var_d7e160d46b65574f;
    victim.haywiretimestamp = gettime();
    
    if ( isstruct( inflictor ) )
    {
        inflictor = attacker;
    }
    
    if ( victim.health > 0 && !( victim asm_bb::bb_isanimscripted() && !victim.var_b88c60078c599375 ) )
    {
        firstshock = gettime() > victim._blackboard.var_ba9517cfc0287af8 + getdvarint( @"ai_shockduration" );
        victim._blackboard.var_ba9517cfc0287af8 = gettime();
        victim._blackboard.shockedendtime = gettime() + getdvarint( @"ai_shockduration" ) + var_b688bbdf5036e88e;
        var_428804d73586049e = 0;
        
        if ( !isdefined( victim.var_81b406cea4293e1d ) )
        {
            victim.var_81b406cea4293e1d = [];
        }
        
        if ( !arraycontains( victim.var_81b406cea4293e1d, self ) )
        {
            victim.var_81b406cea4293e1d[ victim.var_81b406cea4293e1d.size ] = self;
            var_428804d73586049e = 1;
        }
        
        params = spawnstruct();
        params.var_ed2c165091bf4dd5 = var_ed2c165091bf4dd5;
        params.firstshock = firstshock;
        params.var_428804d73586049e = var_428804d73586049e;
        victim callback::callback( "shockStick_agentApplyHaywire", params );
        
        if ( !isdefined( self.enemies_shocked ) )
        {
            self.enemies_shocked = int( 0 );
        }
        
        self.enemies_shocked++;
        
        if ( victim.allowpain && victim asmhaspainstate( victim.asmname ) && firstshock )
        {
            victim asmevalpaintransition( victim.asmname );
        }
        
        if ( !var_f3b6e148094e7137 )
        {
            victim function_a986163e6356d32a( objweapon );
        }
        
        if ( firstshock )
        {
            if ( !isdefined( level.shockstick_haywireagent_throttle ) )
            {
                level.shockstick_haywireagent_throttle = throttle::throttle_initialize( "shockStick_haywireAgent", 1, level.framedurationseconds );
            }
            
            throttle::throttle_wait_in_queue( level.shockstick_haywireagent_throttle, victim );
            
            if ( isdefined( victim ) && isdefined( attacker ) && isdefined( inflictor ) )
            {
                if ( var_d7e160d46b65574f )
                {
                    victim dodamage( var_d7e160d46b65574f, victim.origin, attacker, inflictor, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper" );
                }
                else
                {
                    victim dodamage( 1, victim.origin, attacker, inflictor, "MOD_ELEMENTAL_ELEC", objweapon, "torso_upper" );
                }
            }
        }
        
        victim.ishaywire = 1;
        victim.shockstickgrenadeweapon = self.weapon_object;
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x4b972318, Offset: 0x667f
// Size: 0x4c
function function_9891ed88bcd38fd2( data )
{
    level endon( #"game_ended" );
    var_3166aa89082d16f4 = haywire::function_8238cd34bd133b52( data.victim );
    
    if ( var_3166aa89082d16f4 )
    {
        data.victim thread [[ var_3166aa89082d16f4 ]]( data );
    }
}

// Namespace shock_stick
// Params 3
// Checksum 0xd8ba0bf8, Offset: 0x66d3
// Size: 0x30a
function function_396a585ccd7071f5( data, fromdeath, bundle )
{
    if ( data.victim.ishaywire )
    {
        if ( data.victim.var_81b406cea4293e1d.size > 0 )
        {
            data.victim.var_81b406cea4293e1d = arrayremove( data.victim.var_81b406cea4293e1d, self );
            data.victim.var_81b406cea4293e1d = function_5713d46873b29625( data.victim.var_81b406cea4293e1d );
            
            if ( data.victim.var_81b406cea4293e1d.size > 0 )
            {
                return;
            }
        }
        
        data.victim.ishaywire = undefined;
        data.victim.shockstickgrenadeweapon = undefined;
        var_daaf54b453aef55c = haywire::function_57b88bc7394677d8( data.victim );
        
        if ( isagent( data.victim ) )
        {
            params = spawnstruct();
            params.var_ed2c165091bf4dd5 = data;
            params.fromdeath = fromdeath;
            data.victim callback::callback( "shockStick_agentClearHaywire", params );
            
            if ( data.victim isscriptable() && data.victim getscriptablehaspart( "shockStickVfx" ) )
            {
                scriptablepart = data.victim getscriptablepartstate( "shockStickVfx", 1 );
                
                if ( isdefined( scriptablepart ) )
                {
                    data.victim setscriptablepartstate( #"shockStickVfx", #"off", 0 );
                }
            }
        }
        else if ( isplayer( data.victim ) )
        {
            data.victim thread function_a509214050ca03a5( fromdeath, bundle );
        }
        else if ( entity::isturret( data.victim ) )
        {
            if ( isdefined( data.victim.owner ) )
            {
                data.victim.owner stopforcedfire();
            }
        }
        else if ( isdefined( var_daaf54b453aef55c ) )
        {
            data.victim [[ var_daaf54b453aef55c ]]( data );
        }
        
        if ( entity::isturret( data.victim ) && isdefined( var_daaf54b453aef55c ) )
        {
            data.victim [[ var_daaf54b453aef55c ]]( data );
        }
        
        bundle = self.tableinfo.bundle;
        
        if ( bundle.var_875c853f191e72ea && isdefined( self ) && isplayer( data.victim ) )
        {
            self setscriptablepartstate( #"electric", #"neutral", 0 );
            shockstick_destroy( 0 );
        }
        
        data.victim notify( #"haywire_cleared" );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x53a59034, Offset: 0x69e5
// Size: 0x17
function function_ad017d743c743e73( applycallback )
{
    self.var_3166aa89082d16f4 = applycallback;
}

// Namespace shock_stick
// Params 1
// Checksum 0xd92147fa, Offset: 0x6a04
// Size: 0x17
function function_211b949b06482e81( removecallback )
{
    self.var_26a4e8521d226be = removecallback;
}

// Namespace shock_stick
// Params 2
// Checksum 0x519ba3a8, Offset: 0x6a23
// Size: 0x221
function function_a509214050ca03a5( fromdeath, bundle )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self stopforcedfire();
    self function_61089c118e376955( 0 );
    
    if ( !isdefined( bundle ) )
    {
        bundle = level.equipment.table[ "equip_shockstick" ].bundle;
    }
    
    if ( isdefined( bundle.var_e92504c2b2f419a8 ) )
    {
        [[ bundle.var_e92504c2b2f419a8 ]]();
    }
    else
    {
        self setscriptablepartstate( #"shockStickVfx", #"off", 0 );
    }
    
    curweapon = self getcurrentweapon();
    weaponref = "";
    
    if ( weapon::function_170e300815e9c1a2( curweapon ) )
    {
        weaponref = weapon::function_170e300815e9c1a2( curweapon );
    }
    
    reactgesture = bundle.var_48a550bf2b8d7af3 ?? "vm_ges_shockstick_react";
    var_bce72bce5af120da = bundle.var_84e04f4a22bdb425 ?? "vm_ges_shockstick_react_fists";
    
    if ( self isgestureplaying( reactgesture ) )
    {
        self stopgestureviewmodel( reactgesture, 0.7 );
    }
    else if ( self isgestureplaying( var_bce72bce5af120da ) )
    {
        self stopgestureviewmodel( var_bce72bce5af120da, 0.7 );
    }
    else if ( weaponref && isdefined( level.var_fca38a9adcb119d1[ weaponref ] ) && self isgestureplaying( level.var_fca38a9adcb119d1[ weaponref ] ) )
    {
        self stopgestureviewmodel( level.var_fca38a9adcb119d1[ weaponref ], 0.7 );
    }
    
    if ( isdefined( self.var_ac0eae4ff18c28e5 ) )
    {
        if ( self isgestureplaying( self.var_ac0eae4ff18c28e5 ) )
        {
            self stopgestureviewmodel( self.var_ac0eae4ff18c28e5, 0.7 );
        }
        
        self.var_ac0eae4ff18c28e5 = undefined;
    }
    
    if ( bundle.var_49bb7ce47fe491e0 )
    {
        self setaimspreadmovementscale( 0 );
        self function_985a80734a98d286();
    }
    
    weapons::updatemovespeedscale();
    
    if ( !fromdeath || getdvarint( @"hash_fd1dfe2f46113506", 1 ) )
    {
        function_904e61c3aefb61c2( 0 );
    }
    
    var_daaf54b453aef55c = haywire::function_57b88bc7394677d8( self );
    
    if ( var_daaf54b453aef55c )
    {
        self thread [[ var_daaf54b453aef55c ]]();
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xdfe5cc2f, Offset: 0x6c4c
// Size: 0xef
function function_ef03efbecb279b8a( lock )
{
    stance = "stand";
    
    if ( self issprintsliding() )
    {
        stance = "crouch";
    }
    else if ( self isdiving() )
    {
        stance = "prone";
    }
    else
    {
        stance = self getstance();
    }
    
    if ( lock )
    {
        if ( stance == "stand" )
        {
            val::set( "shockstick_stance", "crouch", 0 );
            val::set( "shockstick_stance", "prone", 0 );
        }
        else if ( stance == "crouch" )
        {
            val::set( "shockstick_stance", "stand", 0 );
            val::set( "shockstick_stance", "prone", 0 );
        }
        else if ( stance == "prone" )
        {
            val::set( "shockstick_stance", "crouch", 0 );
            val::set( "shockstick_stance", "stand", 0 );
        }
        
        return;
    }
    
    val::reset_all( "shockstick_stance" );
}

// Namespace shock_stick
// Params 2
// Checksum 0xdfecb30b, Offset: 0x6d43
// Size: 0x86
function shockstick_badplace( impactorigin, radius )
{
    if ( !bots_util::bot_bots_enabled_or_added() && !utility::level_supports_ai() )
    {
        return;
    }
    
    if ( isdefined( level.var_3d90777bfb7fc504 ) )
    {
        badplace = function_30c25bea1909556f( impactorigin, ( radius, radius, 125 ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
    }
    else
    {
        badplace = createnavbadplacebybounds( impactorigin, ( radius, radius, 125 ), ( 0, 0, 0 ) );
    }
    
    return badplace;
}

// Namespace shock_stick
// Params 1
// Checksum 0x6e3fa50f, Offset: 0x6dd2
// Size: 0x4d
function function_741ca0f98c3d4857( duration )
{
    self endon( #"hash_7210705d3fd1826e" );
    self endon( #"disconnect" );
    self notify( #"shockfx_active" );
    self endon( #"shockfx_active" );
    thread function_813e886c38b4d382();
    wait duration;
    stopshockfx();
}

// Namespace shock_stick
// Params 0
// Checksum 0x7ee68090, Offset: 0x6e27
// Size: 0xae
function function_813e886c38b4d382()
{
    self notify( #"stopshockfx" );
    self endon( #"disconnect" );
    self endon( #"stopshockfx" );
    
    while ( true )
    {
        if ( !player::isreallyalive( self ) )
        {
            return;
        }
        
        var_6c3b2d1cd405d80c = !self isswimming();
        var_2749a0d97d87e9bc = istrue( self.var_2749a0d97d87e9bc );
        
        if ( var_6c3b2d1cd405d80c && var_2749a0d97d87e9bc )
        {
            damage::dequeuecorpsetablefunc( "shockStickDeath" );
            self.var_2749a0d97d87e9bc = undefined;
        }
        else if ( !var_6c3b2d1cd405d80c && !var_2749a0d97d87e9bc )
        {
            damage::enqueuecorpsetablefunc( "shockStickDeath", &function_54f311799849992b );
            self.var_2749a0d97d87e9bc = 1;
        }
        
        waitframe();
    }
}

// Namespace shock_stick
// Params 0
// Checksum 0x46cc09aa, Offset: 0x6edd
// Size: 0x24
function stopshockfx()
{
    self notify( #"stopshockfx" );
    damage::dequeuecorpsetablefunc( "shockStickDeath" );
    self.var_2749a0d97d87e9bc = undefined;
}

// Namespace shock_stick
// Params 1
// Checksum 0x3d0ecc68, Offset: 0x6f09
// Size: 0x26
function function_54f311799849992b( corpsetable )
{
    corpsetable setscriptablepartstate( #"shockStickDeath", #"vfx_start", 0 );
}

// Namespace shock_stick
// Params 2
// Checksum 0x79691f4a, Offset: 0x6f37
// Size: 0x71
function function_a986163e6356d32a( objweapon, vfxstate )
{
    shockevent = vfxstate ?? "vfx_start";
    
    if ( isdefined( objweapon.basenamehash ) )
    {
        switch ( objweapon.basenamehash )
        {
            case %"electric_discharge_mp":
                shockevent = "vfx_start_super";
                break;
        }
    }
    
    utility::function_7c10ea82c1e305b8( "shockStickVfx", shockevent );
}

// Namespace shock_stick
// Params 2
// Checksum 0xc068ab65, Offset: 0x6fb0
// Size: 0xcf, Type: bool
function function_fdcbae7456ac9efc( var_4cfc44bae9fff5c7, othershockstick )
{
    foreach ( linkdata in level.var_77a0719d5dc121a4 )
    {
        if ( linkdata.shocksticka == var_4cfc44bae9fff5c7 || linkdata.shockstickb == var_4cfc44bae9fff5c7 )
        {
            if ( linkdata.shockstickb == othershockstick || linkdata.shocksticka == othershockstick )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace shock_stick
// Params 1
// Checksum 0x7ed77326, Offset: 0x7088
// Size: 0xbb
function function_5eb527187eac436e( shockstick )
{
    var_6c22d099760d3535 = [];
    
    foreach ( linkdata in level.var_77a0719d5dc121a4 )
    {
        if ( linkdata.shocksticka == shockstick || linkdata.shockstickb == shockstick )
        {
            var_6c22d099760d3535 = arraycombineunique( var_6c22d099760d3535, [ linkdata ] );
        }
    }
    
    return var_6c22d099760d3535;
}

// Namespace shock_stick
// Params 2
// Checksum 0xec7cc4da, Offset: 0x714c
// Size: 0xce
function function_9f342824ea9b32ef( shocksticka, shockstickb )
{
    foreach ( linkdata in level.var_77a0719d5dc121a4 )
    {
        if ( linkdata.shocksticka == shocksticka || linkdata.shockstickb == shocksticka )
        {
            if ( linkdata.shockstickb == shockstickb || linkdata.shocksticka == shockstickb )
            {
                return linkdata;
            }
        }
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x5169884c, Offset: 0x7223
// Size: 0x4a
function function_1ada9a8fb9da6962( linkdata )
{
    if ( isdefined( linkdata.arctrigger ) )
    {
        linkdata.arctrigger delete();
    }
    
    if ( isdefined( linkdata.arcvfx ) )
    {
        linkdata.arcvfx delete();
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xbf289351, Offset: 0x7275
// Size: 0x239
function function_c99c58a7cfce78a8( linkdata )
{
    if ( isdefined( linkdata.arctrigger ) )
    {
        linkdata.arctrigger delete();
    }
    
    linkdata.arcdistance = distance( linkdata.shockstickb.origin, linkdata.shocksticka.origin );
    linkdata.arcmidpoint = ( ( linkdata.shockstickb.origin[ 0 ] + linkdata.shocksticka.origin[ 0 ] ) / 2, ( linkdata.shockstickb.origin[ 1 ] + linkdata.shocksticka.origin[ 1 ] ) / 2, ( linkdata.shockstickb.origin[ 2 ] + linkdata.shocksticka.origin[ 2 ] ) / 2 );
    arctrigger = spawn( "trigger_rotatable_radius", linkdata.shockstickb.origin, 0, 50, linkdata.arcdistance );
    arctrigger.angles = vectortoangles( linkdata.shocksticka.origin - linkdata.shockstickb.origin ) + ( 90, 0, 0 );
    linkdata.arctrigger = arctrigger;
    trigger::makeenterexittrigger( linkdata.arctrigger, &function_30b85490f96d9af1, &function_90a21a08c2edf491 );
    wait 0.35;
    
    if ( isdefined( linkdata.shocksticka ) && isdefined( linkdata.shockstickb ) )
    {
        if ( isdefined( linkdata.arcvfx ) )
        {
            linkdata.arcvfx delete();
        }
        
        linkdata.arcvfx = playfxontagsbetweenclients( level._effect[ "shock_stick_arc" ], linkdata.shocksticka, "tag_fx", linkdata.shockstickb, "tag_fx" );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0x51dd8d20, Offset: 0x74b6
// Size: 0xd4
function function_b57c3fb941587ca5( params )
{
    if ( !params.victim.var_4b1550856e654943 )
    {
        return;
    }
    
    foreach ( player in params.victim.var_4b1550856e654943 )
    {
        if ( player::isreallyalive( player ) )
        {
            player thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_105b493d63214015" );
        }
    }
    
    params.victim.var_4b1550856e654943 = undefined;
}

// Namespace shock_stick
// Params 4
// Checksum 0x690e823e, Offset: 0x7592
// Size: 0x237
function function_8db896e6f63b004b( attacker, objweapon, bundle, duration )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    assert( isplayer( self ), "<dev string:x3da>" );
    assert( isdefined( objweapon ) && isweapon( objweapon ), "<dev string:x419>" );
    
    if ( self.ishaywire || utility::isusingremote() || !player::isreallyalive( self ) )
    {
        return;
    }
    
    self notify( #"shockstick_haywireapplied" );
    self endon( #"shockstick_haywireapplied" );
    
    if ( !isdefined( bundle ) )
    {
        bundle = level.equipment.table[ "equip_shockstick" ].bundle;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = bundle.var_860545b754d7ecc0 ?? 0.25;
    }
    
    duration = getdvarfloat( @"hash_e66e541920ac9101", duration );
    thread mtx_weapon::function_3c5b3042f8d8a4f7();
    
    if ( level.equipment.var_aeff9a3b25965912 )
    {
        callback::callback( #"hash_5bfa36b3dc1a524b", { #ref:"shocked", #attacker:attacker, #victim:self, #equipment:"equip_shockstick" } );
    }
    
    self.ishaywire = 1;
    self.shockstickgrenadeweapon = objweapon;
    var_ed2c165091bf4dd5 = { #objweapon:objweapon, #attacker:attacker, #victim:self };
    function_85325bfe497746ba( var_ed2c165091bf4dd5, bundle );
    childthread function_308429e4f8b00b34();
    utility::waittill_any_timeout( duration, #"haywire_cleared", #"haywire_max_duration", #"shockstick_interrupt", #"killed_player", #"last_stand_enter" );
    fromdeath = !player::isreallyalive( self ) || player::isinlaststand( self );
    
    if ( self.ishaywire )
    {
        self.ishaywire = undefined;
        self.shockstickgrenadeweapon = undefined;
        thread function_a509214050ca03a5( fromdeath, bundle );
        self notify( #"haywire_cleared" );
    }
}

// Namespace shock_stick
// Params 1
// Checksum 0xdade0e09, Offset: 0x77d1
// Size: 0xd6
function function_272df1526383be08( currentweapon )
{
    if ( weapon::function_170e300815e9c1a2( currentweapon ) )
    {
        weaponref = weapon::function_170e300815e9c1a2( currentweapon );
        self.var_386d13820628c200 = weaponref;
    }
    
    if ( level.var_fca38a9adcb119d1[ weaponref ] )
    {
        gestureref = level.var_fca38a9adcb119d1[ weaponref ];
    }
    else
    {
        if ( !isdefined( bundle ) )
        {
            bundle = level.equipment.table[ "equip_shockstick" ].bundle;
        }
        
        if ( weapon::isfistweapon( currentweapon ) )
        {
            reactgesture = bundle.var_84e04f4a22bdb425 ?? "vm_ges_shockstick_react_fists";
        }
        else
        {
            reactgesture = bundle.var_48a550bf2b8d7af3 ?? "vm_ges_shockstick_react";
        }
        
        gestureref = reactgesture;
    }
    
    return gestureref;
}

