// scripts\mp\common\supers\combat_hologram.gsc  (hash_0d4343cc8d54c793.gscc) (size: 31242 Bytes / 0x7a0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xddf3c835 (3723741237)
// size ...... 31242 (0x7a0a)
// includes .. 35  (offset: 0x754a)
// strings ... 46  (offset: 0x7662)
// dev strs .. 9   (offset: 0x799e)
// exports ... 69  (offset: 0x4daa)
// cseg ...... 0x35e + 0x4a4c (0x4daa)
// imports ... 238 (offset: 0x5872)
// animtree1 . 0   (offset: 0x7a0a)
// animtree2 . 0   (offset: 0x7a0a)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\flash_grenade;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\loot\common_item;
#using scripts\mp\outofbounds;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace combat_hologram;

// Namespace combat_hologram
// Params 0, eflags: 0x5
// Checksum 0xd32ae3a4, Offset: 0x37c
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &combatholo_init );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x6a4e3059, Offset: 0x39c
// Size: 0x184
function combatholo_init( params )
{
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_combat_hologram", &function_582af21e79220c4e, &function_4991f73438496833, &function_871cceab1af15a6a, undefined, undefined, undefined, undefined, &combatholo_reclaim );
    weapons::registerusedcallback( "combat_hologram", &function_246e92bc144211ca );
    level callback::add( #"hash_2709fd1dd4cef88d", &function_38cf8364e4d8e652 );
    level callback::add( #"hash_eb54ccc016130a88", &on_player_elim );
    level callback::add( #"player_disconnect", &combatholo_onplayerdisconnect );
    utility::registersharedfunc( #"combat_hologram", #"hack", &combatholo_hack );
    
    if ( !isdefined( level.combatholos ) )
    {
        level.combatholos = [];
    }
    
    var_1f3d0fa875f80f72 = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle.var_43e80329a9a3fa13;
    
    if ( weaponexists( var_1f3d0fa875f80f72 ) )
    {
        weaponrootname = getweaponrootstring( var_1f3d0fa875f80f72 );
    }
    
    if ( weaponrootname )
    {
        var_7134bc8346073af3 = weapon::buildweapon( weaponrootname );
    }
    
    if ( isweapon( var_7134bc8346073af3 ) && !isnullweapon( var_7134bc8346073af3 ) )
    {
        level.var_45e605ee1bcfe0f5 = var_7134bc8346073af3;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_cd5d60a88e91cfee", 0, 0, 1 );
    #/
    
    thread equipmentinteractinit();
}

// Namespace combat_hologram
// Params 0
// Checksum 0x97b94789, Offset: 0x528
// Size: 0xa7
function equipmentinteractinit()
{
    utility::flag_wait( "equipment_initialized" );
    bundle = level.equipment.table[ "equip_combat_hologram" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_combat_hologram" ), #"interactdisable", &equipment_interact_disable );
    utility::registersharedfunc( getxhash( "equip_combat_hologram" ), #"interactenable", &equipment_interact_enable );
    utility::registersharedfunc( getxhash( "equip_combat_hologram" ), #"interactdestroy", &combatholo_destroy );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x394c783a, Offset: 0x5d7
// Size: 0x14
function equipment_interact_disable( data )
{
    function_f2fdd019aa1d97a6( self );
}

// Namespace combat_hologram
// Params 1
// Checksum 0xba10e42f, Offset: 0x5f3
// Size: 0x14
function equipment_interact_enable( data )
{
    function_655bd8caffa5d850( self );
}

// Namespace combat_hologram
// Params 0
// Checksum 0x2b3591be, Offset: 0x60f
// Size: 0xd1
function function_582af21e79220c4e()
{
    if ( !isdefined( self.var_6a2d9548aeda69ae ) )
    {
        self.var_6a2d9548aeda69ae = [];
    }
    
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_combat_hologram", bundle.var_c7709714d768097c ) )
    {
        self.var_6a2d9548aeda69ae[ "super_combat_hologram" ] = 1;
        multiplier = bundle.var_95d092921525ae5e ?? 1.2;
        perk::giveperk( "specialty_faster_field_upgrade" );
        val::set( "super_combat_hologram", "field_upgrade_recharge_mult", multiplier );
        return;
    }
    
    self.var_6a2d9548aeda69ae[ "super_combat_hologram" ] = 0;
}

// Namespace combat_hologram
// Params 0
// Checksum 0x9c61690f, Offset: 0x6e8
// Size: 0x40
function function_4991f73438496833()
{
    if ( self.var_6a2d9548aeda69ae[ "super_combat_hologram" ] )
    {
        val::reset( "super_combat_hologram", "field_upgrade_recharge_mult" );
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    self.var_6a2d9548aeda69ae[ "super_combat_hologram" ] = undefined;
}

// Namespace combat_hologram
// Params 0
// Checksum 0x17daca17, Offset: 0x730
// Size: 0x45, Type: bool
function function_871cceab1af15a6a()
{
    self endon( #"death_or_disconnect" );
    results = utility::waittill_any_return_params_or_timeout( 5, "combat_holo_deploy_success", "combat_holo_deploy_failed" );
    result = results[ "message" ];
    return result == "combat_holo_deploy_success";
}

// Namespace combat_hologram
// Params 1
// Checksum 0x51041e81, Offset: 0x77e
// Size: 0xe0, Type: bool
function combatholo_reclaim( super )
{
    superowner = super.owner;
    superowner supers_mp::function_8cb3b4861e05f17( super.superref, super.ammo, super.timeremaining );
    superowner br_pickups::forcegivesuper( "super_combat_hologram", 1, 0, 0, 0 );
    super supers_mp::function_e2c263f3ee5d2d92( super.damagetaken, super.bundle.var_ead9bcfecbd8c1a, super.ammo );
    level thread common_item::function_e8dfe5e68a7a03b4( superowner, supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_hologram" ) );
    superowner thread supers_mp::function_5c28588f733c7388( super.timeremaining, super.bundle.var_ead9bcfecbd8c1a );
    super thread combatholo_destroy( undefined, 1 );
    return true;
}

// Namespace combat_hologram
// Params 0
// Checksum 0x8f3b0e96, Offset: 0x867
// Size: 0xc
function function_9af7e665ed29a13f()
{
    thread combatholo_destroy( undefined, 1 );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x5f63e6fb, Offset: 0x87b
// Size: 0x5c4
function function_246e92bc144211ca( combatholo )
{
    combatholo endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    combatholo.var_20fb6d9e02a1d35 = 1;
    combatholo.var_b5ff937ea7459936 = &combatholo_shouldcaptureobjective;
    combatholo.superref = "super_combat_hologram";
    
    if ( self.combatholo )
    {
        self.combatholo thread combatholo_destroy( undefined, 0 );
    }
    
    combatholo thread equipment_mp::watchwaterdepth( &function_9af7e665ed29a13f );
    combatholo.var_30656af96b2ac2a4 = [];
    combatholo.add_buff = &add_buff;
    combatholo.remove_buff = &remove_buff;
    combatholo waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, hitvelocity, position, hitnormal );
    utility::callsharedfunc( #"sat_whiteout", #"hash_b50f0f1668fc8491", combatholo, stuckto );
    axis = anglestoaxis( combatholo.angles );
    axis[ "forward" ] = rotatepointaroundvector( axis[ "up" ], axis[ "forward" ], 90 );
    axis[ "right" ] = rotatepointaroundvector( axis[ "up" ], axis[ "right" ], 90 );
    newangles = axistoangles( axis[ "forward" ], axis[ "right" ], axis[ "up" ] );
    combatholo.angles = newangles;
    utility::function_969f9f5596dba07a( combatholo, &combatholo_destroy );
    
    if ( !function_a610c535c5dc1ea2( stuckto ) || combatholo outofbounds::istouchingoobtrigger() || combatholo equipment_mp::function_c2a3ca0d571472a3() )
    {
        combatholo thread combatholo_destroy( undefined, 1 );
        self notify( #"combat_holo_deploy_failed" );
        return;
    }
    
    self notify( #"combat_holo_deploy_success" );
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        combatholo linkto( stuckto );
    }
    
    self.combatholo = combatholo;
    level.combatholos[ combatholo getentitynumber() ] = combatholo;
    combatholo setscriptablepartstate( #"visibility", #"show", 0 );
    combatholo.issuper = 1;
    combatholo.superref = "super_combat_hologram";
    combatholo.owner = self;
    combatholo.team = self.team;
    combatholo.bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    combatholo.superid = combatholo.bundle.id;
    combatholo setentityowner( self );
    combatholo setotherent( self );
    combatholo function_28bf72d5a6dace11( ( 0, combatholo.owner.angles[ 1 ], 0 ) );
    weapons::onequipmentplanted( combatholo, "equip_combat_hologram", &combatholo_destroy );
    
    if ( !combatholo.invulnerable )
    {
        combatholo combatholo_makedamageable();
        combatholo sentientpoolmanager::registersentient( "Tactical_Static", combatholo.owner );
    }
    
    combatholo callback::add( #"hash_a4b2d4dcbb4cda95", &function_12f7e3a1c915cc4d );
    combatholo namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( combatholo, &combatholo_empapplied );
    combatholo.empremovecallback = &combatholo_empcleared;
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", combatholo, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    combatholo.invalidplacement = combatholo function_6fb0602e3daaef27();
    
    if ( combatholo.invalidplacement )
    {
        combatholo thread function_e0dec82b884dc166();
        combatholo function_4d84a6523c59bb8a();
        combatholo.decoy thread function_46e531d5690b2d47( 1 );
        combatholo.var_c3c4d711e69d5ab9 = 1;
    }
    
    if ( combatholo.var_7568cab78e4268cc || combatholo.invalidplacement )
    {
        if ( isdefined( combatholo.var_ad4eb9f85798b7a7 ) )
        {
            combatholo entityheadicons::setheadicon_deleteicon( combatholo.var_ad4eb9f85798b7a7 );
        }
        
        combatholo.var_ad4eb9f85798b7a7 = undefined;
        
        if ( isdefined( combatholo.var_505a6bc6f580454c ) )
        {
            combatholo entityheadicons::setheadicon_deleteicon( combatholo.var_505a6bc6f580454c );
        }
        
        combatholo.var_505a6bc6f580454c = combatholo function_72a1bd67cc9bf1b8();
    }
    else
    {
        combatholo thread combatholo_activate( self );
    }
    
    if ( combatholo.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = combatholo.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = combatholo.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = combatholo.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        combatholo thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, combatholo.team );
    }
    
    combatholo thread combatholo_watchlifetime( self );
    combatholo function_128475e3ddbe758e( self );
    combatholo utility::callsharedfunc( #"threatbias", #"hash_a1bb26444c471b10", combatholo );
    
    if ( combatholo.bundle.var_67296742aaa265f9 )
    {
        combatholo thread supers_mp::function_24bd67c384c2e606( combatholo.bundle.var_ead9bcfecbd8c1a );
        combatholo thread supers_mp::function_3a21005bdaf91ac2( combatholo.bundle );
    }
}

// Namespace combat_hologram
// Params 1
// Checksum 0x9c1e3fd3, Offset: 0xe47
// Size: 0x57, Type: bool
function function_a610c535c5dc1ea2( var_20da6e5e207349a )
{
    if ( isent( var_20da6e5e207349a ) && var_20da6e5e207349a vehicle::is_vehicle() && !level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle.var_748c9f912bd90890 )
    {
        return false;
    }
    
    return true;
}

// Namespace combat_hologram
// Params 1
// Checksum 0xa0654ee3, Offset: 0xea7
// Size: 0x57
function function_128475e3ddbe758e( ownerplayer )
{
    var_9d11534ddcd153c5 = { #combatholoid:self getentitynumber(), #weaponobj:self.weapon_object, #var_1a6c7de4dc0d7c23:0, #ownerplayer:ownerplayer };
    thread function_a504d57870a93f2( var_9d11534ddcd153c5 );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x5253b5be, Offset: 0xf06
// Size: 0x67
function function_a504d57870a93f2( var_9d11534ddcd153c5 )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_a981377deaf648f3", victim );
        victim thread function_6864379a8124b546( var_9d11534ddcd153c5, gettime() );
        victim thread function_f06e375e645ec30c( var_9d11534ddcd153c5, victim );
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0x712dc0d2, Offset: 0xf75
// Size: 0x89
function function_f06e375e645ec30c( var_9d11534ddcd153c5, victim )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"disconnect" );
    combatholoid = var_9d11534ddcd153c5.combatholoid;
    combatholoweapon = var_9d11534ddcd153c5.weaponobj;
    telemetry_mp::function_594cbdc6a4d8098a( victim, var_9d11534ddcd153c5.ownerplayer, combatholoweapon, combatholoid );
    thread telemetry_mp::function_c66882927ed29e53( victim, combatholoweapon, combatholoid, 7 );
}

// Namespace combat_hologram
// Params 2
// Checksum 0xd187adc9, Offset: 0x1006
// Size: 0xbf
function function_6864379a8124b546( var_9d11534ddcd153c5, var_7a2d35b57eae93c9 )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    combatholoowner = var_9d11534ddcd153c5.ownerplayer;
    
    if ( self.attacker == combatholoowner )
    {
        if ( self.attacker.modifiers[ "wasTricked" ] )
        {
            var_9d11534ddcd153c5.var_1a6c7de4dc0d7c23++;
            
            if ( var_9d11534ddcd153c5.var_1a6c7de4dc0d7c23 == 2 )
            {
                combatholoowner thread points::doscoreevent( #"combat_holo_catfish", var_9d11534ddcd153c5.weaponobj );
            }
        }
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0x4980351, Offset: 0x10cd
// Size: 0x1ef
function combatholo_activate( owner, showheadicon = 1 )
{
    self notify( #"hash_a72079c151dc4640" );
    self endon( #"hash_a72079c151dc4640" );
    
    if ( !( isdefined( self ) && isdefined( owner ) ) || self.var_918f5731d316cbc )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"game_ended", #"round_end" );
    owner endon( #"disconnect" );
    self endon( #"hologram_hacked" );
    thread function_28a1be9b590503d5();
    
    if ( self.triggervolume && !self.triggervolume.istouched )
    {
        self.decoy thread function_b3081550a6f4d862();
    }
    
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    delaytime = bundle.var_ca33da63f2aba3bd ?? 0;
    wait delaytime;
    self notify( #"combatholo_activated" );
    
    if ( isdefined( self.var_ad4eb9f85798b7a7 ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_ad4eb9f85798b7a7 );
    }
    
    if ( showheadicon )
    {
        imageoverride = self.var_30656af96b2ac2a4.size > 0 ? self.bundle.buffedheadicon : undefined;
        self.var_ad4eb9f85798b7a7 = entityheadicons::setheadicon_fieldupgrade( self, imageoverride );
    }
    
    if ( isdefined( self.var_505a6bc6f580454c ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_505a6bc6f580454c );
    }
    
    if ( showheadicon )
    {
        self.var_505a6bc6f580454c = function_72a1bd67cc9bf1b8();
    }
    
    if ( bundle.var_e36b84555e7df1d3 && owner supers_mp::function_d45945781d29204a( "super_combat_hologram", bundle.var_e36b84555e7df1d3 ) )
    {
        self.decoy thread function_ef46303028fba0fe();
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0x7ea2b18a, Offset: 0x12c4
// Size: 0xbd
function private combatholo_watchlifetime( owner )
{
    self notify( #"hash_23fc42815473c7a3" );
    self endon( #"hash_23fc42815473c7a3" );
    self endon( #"death" );
    owner endon( #"disconnect" );
    self endon( #"hologram_hacked" );
    lifetime = self.var_71ef7a5805150f86 ?? self.bundle.var_ead9bcfecbd8c1a ?? 0;
    
    if ( lifetime == 0 )
    {
        level utility::waittill_any( "game_ended", "round_end" );
    }
    else
    {
        level utility::waittill_any_timeout( lifetime, "game_ended", "round_end" );
    }
    
    if ( self )
    {
        combatholo_destroy( undefined, 0 );
    }
}

// Namespace combat_hologram
// Params 8
// Checksum 0xc389b9af, Offset: 0x1389
// Size: 0x72f
function function_28bf72d5a6dace11( decoyangles, var_beeec41193f50549 = 1, skinoverride = undefined, var_8d46d13edeada490 = undefined, var_bba1a181899c8b7a = undefined, weaponoverride = undefined, overridetriggerradius = undefined, showheadicon = 1 )
{
    combatholo = self;
    player = self.owner;
    decoyorigin = combatholo isscriptable() ? combatholo gettagorigin( "tag_base" ) : combatholo.origin;
    combatholo.decoy = spawn( "script_model", decoyorigin );
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    skinname = skinoverride ?? player.operatorcustomization.skinref;
    assert( bundle.var_650fafb5bf403e5c, "<dev string:x24>" );
    combatholo.decoy function_ce21f4102d5d17f6( skinname, bundle.var_650fafb5bf403e5c );
    combatholo.decoy function_5240ca87211d537e();
    combatholo.decoy.var_aa82c7f64e626133 = 1;
    combatholo.decoy.team = player.team;
    combatholo.decoy.owner = player;
    combatholo.decoy setentityowner( player );
    combatholo.decoy setotherent( player );
    combatholo.decoy.grenadeowner = combatholo;
    combatholo.decoy.angles = decoyangles;
    linkingtag = combatholo isscriptable() ? "tag_base" : "tag_origin";
    combatholo.decoy linkto( combatholo, linkingtag );
    weaponobj = weaponoverride ?? level.var_45e605ee1bcfe0f5;
    
    if ( !weaponobj )
    {
        gamemodebundle = getgamemodescriptbundle();
        
        if ( gamemodebundle.weaponlist )
        {
            weaponlistbundle = getscriptbundle( gamemodebundle.weaponlist );
            var_907cbe52a4f7eced = weaponlistbundle.defaultprimaryweapon;
            
            if ( var_907cbe52a4f7eced )
            {
                weaponrootname = getscriptbundlefieldvalue( getxhashasset( "weapondata:" + var_907cbe52a4f7eced ), #"ref" ) ?? var_907cbe52a4f7eced ?? "none";
            }
            else
            {
                weaponrootname = "none";
            }
            
            weaponobj = weapon::buildweapon( weaponrootname );
            
            if ( isweapon( weaponobj ) && !isnullweapon( weaponobj ) )
            {
                level.var_45e605ee1bcfe0f5 = weaponobj;
            }
        }
    }
    
    if ( isweapon( weaponobj ) && !isnullweapon( weaponobj ) )
    {
        weaponent = spawn( "script_weapon", combatholo.decoy.origin, 0, 0, weaponobj );
        weaponent makeunusable();
        weaponent linkto( combatholo.decoy, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        combatholo.decoy.weaponent = weaponent;
    }
    else
    {
        assertmsg( "<dev string:x63>" );
    }
    
    if ( player getstance() == "crouch" )
    {
        assert( bundle.var_fa16205775935d5e, "<dev string:xa0>" );
        crouchinganim = var_bba1a181899c8b7a ?? removesubstr( bundle.var_fa16205775935d5e.name, "@sbundle" );
        combatholo.decoy scriptmodelplayanim( crouchinganim, "combatHolo_notify" );
        combatholo.decoy.spawnedtype = 1;
    }
    else
    {
        assert( bundle.var_91710ac1896fd3ba, "<dev string:xe2>" );
        standinganim = var_8d46d13edeada490 ?? removesubstr( bundle.var_91710ac1896fd3ba.name, "@sbundle" );
        combatholo.decoy scriptmodelplayanim( standinganim, "combatHolo_notify" );
        combatholo.decoy.spawnedtype = 0;
    }
    
    combatholo.decoy.hitreactent = spawn( "script_model", decoyorigin );
    assert( bundle.var_4cba468ac777af58, "<dev string:x123>" );
    combatholo.decoy.hitreactent setmodel( bundle.var_4cba468ac777af58 );
    combatholo.decoy.hitreactent.team = player.team;
    combatholo.decoy.hitreactent.owner = player;
    combatholo.decoy.hitreactent setentityowner( player );
    combatholo.decoy.hitreactent setotherent( player );
    combatholo.decoy.hitreactent linkto( combatholo.decoy, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    combatholo.decoy thread function_f4d9cb4623219410();
    combatholo function_7fb88a403ed43138( overridetriggerradius, showheadicon );
    
    if ( var_beeec41193f50549 )
    {
        combatholo.decoy function_493086e37a3370dd();
    }
    
    if ( utility::issharedfuncdefined( #"combat_hologram", #"zombie_attractor_validator" ) )
    {
        attractorvalidator = utility::getsharedfunc( #"combat_hologram", #"zombie_attractor_validator" );
        combatholo.decoy.zombieattractor = zombie_attractor_manager::add_attractor( combatholo.decoy, undefined, 128, 1, undefined, attractorvalidator );
        decoyheight = combatholo.decoy.spawnedtype == 1 ? 48 : 64;
        zombie_attractor_manager::function_a2aab3762aaa055f( combatholo.decoy.zombieattractor, combatholo.decoy.origin + ( 0, 0, decoyheight / 2 ), ( 16, 16, decoyheight / 2 ), combatholo.decoy.angles );
        combatholo.decoy thread function_3d9b9c7406cc251d();
        combatholo.decoy thread function_c1baf4650534f732();
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0x423083aa, Offset: 0x1ac0
// Size: 0x1f
function private function_3d9b9c7406cc251d()
{
    self waittill( #"death" );
    zombie_attractor_manager::remove_attractor( self.zombieattractor );
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0x577ab7e8, Offset: 0x1ae7
// Size: 0x7f
function private function_c1baf4650534f732()
{
    self endon( #"death" );
    hitstokill = self.grenadeowner.bundle.var_418d0de0fe719d04 ?? 5;
    
    for ( hitcount = 0; hitcount < hitstokill ; hitcount++ )
    {
        self waittill( #"hit_from_attracted_zombie" );
    }
    
    if ( self.grenadeowner )
    {
        self.grenadeowner thread combatholo_destroy( undefined, 0 );
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0x1b237f42, Offset: 0x1b6e
// Size: 0x165
function private function_493086e37a3370dd()
{
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    assert( bundle.var_316f7cc32e16930d && bundle.var_2110de22336f1e4e, "<dev string:x161>" );
    grenadeownerteam = self.grenadeowner.team ?? self.owner.team;
    
    if ( !isdefined( self.var_a5a8615f53766fa9 ) )
    {
        self.var_a5a8615f53766fa9 = outline::outlineenableforteam( self, grenadeownerteam, bundle.var_316f7cc32e16930d, "equipment" );
    }
    
    if ( !isdefined( self.var_ce66719dd1aaa231 ) )
    {
        self.var_ce66719dd1aaa231 = outline::outlineenableforteam( self.weaponent, grenadeownerteam, bundle.var_316f7cc32e16930d, "equipment" );
    }
    
    enemyteams = team_utility::getenemyteams( grenadeownerteam );
    
    if ( !isdefined( self.var_262974bc36aa2c8a ) )
    {
        self.var_262974bc36aa2c8a = outline::function_6901ecad424487e8( self, enemyteams, bundle.var_2110de22336f1e4e, "equipment" );
    }
    
    if ( !isdefined( self.var_c6a5b26e87c0be52 ) )
    {
        self.var_c6a5b26e87c0be52 = outline::function_6901ecad424487e8( self.weaponent, enemyteams, bundle.var_2110de22336f1e4e, "equipment" );
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0xff1f9d07, Offset: 0x1cdb
// Size: 0x16f
function function_7fb88a403ed43138( radiusoverride = undefined, showheadicon = 1 )
{
    radius = radiusoverride ?? self.bundle.var_6528ae7425ee84af ?? 40;
    height = self.decoy.spawnedtype == 1 ? 48 : 64;
    self.triggervolume = spawn( "trigger_radius", self.origin, 0, radius, height );
    self.triggervolume.owner = self.owner;
    self.triggervolume.grenadeowner = self;
    self.triggervolume enablelinkto();
    linkingtag = self isscriptable() ? "tag_base" : "tag_origin";
    self.triggervolume linkto( self, linkingtag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.triggervolume setentityowner( self.owner );
    self.triggervolume setotherent( self.owner );
    self.triggervolume thread function_289695cc2b5d54ef( showheadicon );
    
    /#
        thread function_f8d3fcace9e2fab4( radius, height );
    #/
}

/#

    // Namespace combat_hologram
    // Params 2, eflags: 0xc
    // Checksum 0x3a59da8f, Offset: 0x1e52
    // Size: 0xcb, Type: dev
    function private function_f8d3fcace9e2fab4( radius, height )
    {
        self notify( #"hash_9f58dd49ef56d0a4" );
        self endon( #"hash_9f58dd49ef56d0a4" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        level endon( #"game_ended", #"round_end" );
        upvector = vectornormalize( anglestoup( self.angles ) ) * height;
        
        while ( true )
        {
            if ( getdvarint( @"hash_cd5d60a88e91cfee" ) == 1 )
            {
                cylinder( self.origin, self.origin + upvector, radius, ( 1, 1, 0 ), 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0xe5307088, Offset: 0x1f25
// Size: 0x257, Type: bool
function private function_6fb0602e3daaef27()
{
    if ( !self.decoy )
    {
        return false;
    }
    
    if ( outofbounds::ispointinoutofbounds( self.origin, self.team ) )
    {
        return true;
    }
    
    if ( self.var_e296b7ab52cd76c7 && gettime() - self.var_e296b7ab52cd76c7 < 300 )
    {
        return false;
    }
    
    self.var_e296b7ab52cd76c7 = gettime();
    tracestartoffset = 10;
    traceradius = 0.3;
    decoyheight = self.decoy.spawnedtype == 1 ? 48 : 64;
    tracelength = decoyheight - tracestartoffset;
    tracestartpos = self.origin + ( 0, 0, 1 ) * tracestartoffset;
    traceendpos = tracestartpos + ( 0, 0, 1 ) * tracelength;
    tracecontent = trace::create_contents( 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0 );
    ignorelist = [ self, self.decoy, self.owner, self.decoy.weaponent ];
    traceback = trace::sphere_trace( tracestartpos, traceendpos, traceradius, ignorelist, tracecontent );
    
    /#
        if ( getdvarint( @"hash_cd5d60a88e91cfee" ) == 1 )
        {
            utility::draw_capsule( tracestartpos, traceradius, 0, ( 0, 0, 0 ), ( 1, 0, 0 ), undefined, int( 1000 ) );
            utility::draw_capsule( traceendpos, traceradius, 0, ( 0, 0, 0 ), ( 0, 1, 0 ), undefined, int( 1000 ) );
        }
    #/
    
    if ( traceback[ "hittype" ] != "hittype_none" && isdefined( traceback[ "entity" ] ) )
    {
        traceent = traceback[ "entity" ];
        
        if ( isplayer( traceent ) )
        {
            return false;
        }
        
        if ( self.bundle.var_748c9f912bd90890 && traceent vehicle::is_vehicle() && self islinked() && self getlinkedparent() == traceent )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0x96e8d3ba, Offset: 0x2185
// Size: 0x33a
function private function_289695cc2b5d54ef( showheadicon = 1 )
{
    self notify( #"hash_898867acb5272e6e" );
    self endon( #"hash_898867acb5272e6e" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() && self.grenadeowner getlinkedparent() != ent )
        {
            if ( self.grenadeowner function_6fb0602e3daaef27() )
            {
                self.grenadeowner thread combatholo_destroy( undefined, 1 );
            }
            
            continue;
        }
        
        if ( isplayer( ent ) && isdefined( self.grenadeowner ) && !self.grenadeowner.var_7568cab78e4268cc )
        {
            if ( self.grenadeowner.invalidplacement )
            {
                continue;
            }
            
            if ( isdefined( self.grenadeowner.decoy ) )
            {
                self.grenadeowner thread function_e0dec82b884dc166();
                self.grenadeowner.decoy thread function_46e531d5690b2d47();
                self.istouched = 1;
                
                if ( isdefined( self.grenadeowner.var_ad4eb9f85798b7a7 ) )
                {
                    entityheadicons::setheadicon_deleteicon( self.grenadeowner.var_ad4eb9f85798b7a7 );
                }
                
                self.grenadeowner.var_ad4eb9f85798b7a7 = undefined;
                
                if ( isdefined( self.owner ) && self.owner != ent && player_utility::playersareenemies( self.owner, ent ) )
                {
                    self.grenadeowner.decoy thread function_2170ea7264e10277( ent );
                }
                else if ( self.grenadeowner.decoy.hitreactent )
                {
                    if ( self.grenadeowner.decoy.hitreactent getscriptablepartstate( #"hitreact_fx", 1, 1 ) == #"neutral" )
                    {
                        self.grenadeowner.decoy.hitreactent setscriptablepartstate( #"hitreact_fx", #"ally_triggered", 0 );
                    }
                }
            }
            
            while ( isdefined( ent ) && ent istouching( self ) )
            {
                waitframe();
            }
            
            if ( self.grenadeowner && showheadicon )
            {
                if ( !isdefined( self.grenadeowner.var_ad4eb9f85798b7a7 ) )
                {
                    self.grenadeowner.var_ad4eb9f85798b7a7 = entityheadicons::setheadicon_fieldupgrade( self.grenadeowner );
                }
            }
            
            if ( isdefined( self.grenadeowner.decoy ) )
            {
                if ( self.grenadeowner )
                {
                    self.grenadeowner thread function_28a1be9b590503d5();
                }
                
                self.grenadeowner.decoy thread function_b3081550a6f4d862();
                self.istouched = undefined;
            }
        }
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0xc70ef787, Offset: 0x24c7
// Size: 0x15
function private function_11958aa3a2f98512()
{
    return level.gametypebundle.var_d551cdb6b861bdf;
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0xea425ac9, Offset: 0x24e5
// Size: 0xfa
function private function_185ad580c06ca0bd()
{
    if ( isdefined( level.objectives ) )
    {
        foreach ( obj in level.objectives )
        {
            if ( function_4c96295bf65b714d( obj ) )
            {
                structref = { #ignorereason:#"" };
                
                if ( function_c24e0b97a3c60ad( obj, structref ) )
                {
                    if ( structref.ignorereason == #"objective_trigger_off" )
                    {
                        thread function_8c281cfc528934d6( obj );
                    }
                    
                    continue;
                }
                
                function_30efcbf8c0f08b06( obj );
                return;
            }
        }
        
        self setscriptablepartstate( #"objective", #"neutral", 0 );
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0xdc93c72a, Offset: 0x25e7
// Size: 0x78
function private function_8c281cfc528934d6( obj )
{
    self endon( #"death" );
    self endon( #"disable_capturing" );
    level endon( #"game_ended", #"round_end" );
    
    while ( obj.trigger.trigger_off )
    {
        wait 1;
    }
    
    if ( !function_c24e0b97a3c60ad( obj ) && function_4c96295bf65b714d( obj ) )
    {
        function_30efcbf8c0f08b06( obj );
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0x7024221d, Offset: 0x2667
// Size: 0xec
function private function_30efcbf8c0f08b06( obj )
{
    self.var_325b10d7c325f3b4 = 1;
    
    if ( !self.var_2b687e67457307 )
    {
        self.pers = [];
        self.pers[ "team" ] = self.owner.team;
        self.touchtriggers = [];
        self.guid = "CombatHolo" + self getentitynumber();
        self.objectivescaler = 1;
        self.clientid = self.owner.clientid;
        self.var_2b687e67457307 = 1;
    }
    
    thread function_17c4a802ef96db74( obj );
    
    if ( isdefined( obj.objectivekey ) )
    {
        self.currenttargetobjid = obj.objectivekey;
        self.owner.var_e111c8f072108f5b = obj.objidnum;
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0xa1133041, Offset: 0x275b
// Size: 0x1d
function private function_9bf2cd96d9754fd1()
{
    if ( function_11958aa3a2f98512() )
    {
        self.var_57b273c971318b8f = 1;
        function_185ad580c06ca0bd();
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0x75b7089b, Offset: 0x2780
// Size: 0x52
function private function_4d84a6523c59bb8a()
{
    self notify( #"disable_capturing" );
    
    if ( isdefined( self.var_325b10d7c325f3b4 ) )
    {
        self.var_325b10d7c325f3b4 = undefined;
    }
    
    if ( isdefined( self.currenttargetobjid ) )
    {
        self.currenttargetobjid = undefined;
    }
    
    if ( self.var_57b273c971318b8f )
    {
        self.var_57b273c971318b8f = 0;
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0xf1edf608, Offset: 0x27da
// Size: 0x11b
function private function_17c4a802ef96db74( obj )
{
    self notify( #"hash_5732ad2ba4862658" );
    self endon( #"hash_5732ad2ba4862658" );
    self endon( #"death" );
    self endon( #"disable_capturing" );
    level endon( #"game_ended", #"round_end" );
    
    while ( combatholo_shouldcaptureobjective( obj ) )
    {
        obj gameobjects::processtouchent( self, obj.entnum );
        
        if ( obj.stalemate || obj gameobjects::caninteractwith( self.pers[ "team" ], self ) )
        {
            if ( self getscriptablepartstate( #"objective" ) != "on_objective" )
            {
                self setscriptablepartstate( #"objective", #"on_objective", 0 );
            }
        }
        else if ( self getscriptablepartstate( #"objective" ) == "on_objective" )
        {
            self setscriptablepartstate( #"objective", #"neutral", 0 );
        }
        
        waitframe();
    }
    
    self setscriptablepartstate( #"objective", #"neutral", 0 );
}

// Namespace combat_hologram
// Params 2, eflags: 0x4
// Checksum 0x387433f, Offset: 0x28fd
// Size: 0x119, Type: bool
function private function_c24e0b97a3c60ad( obj, structref )
{
    if ( !obj.trigger )
    {
        if ( structref )
        {
            structref.ignorereason = #"objective_no_trigger";
        }
        
        return true;
    }
    
    if ( isdefined( obj.cancontestclaim ) && !obj.cancontestclaim )
    {
        if ( structref )
        {
            structref.ignorereason = #"hash_9a1b73c1e1b0b6be";
        }
        
        return true;
    }
    
    if ( obj.id == "bomb_zone" )
    {
        if ( structref )
        {
            structref.ignorereason = #"hash_a07f45ed67250d55";
        }
        
        return true;
    }
    
    if ( obj.activitytype == #"destroy" )
    {
        if ( structref )
        {
            structref.ignorereason = #"hash_d34a151cedb21254";
        }
        
        return true;
    }
    
    if ( obj.trigger.trigger_off )
    {
        if ( structref )
        {
            structref.ignorereason = #"objective_trigger_off";
        }
        
        return true;
    }
    
    return false;
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0x33af2c4f, Offset: 0x2a1f
// Size: 0x38
function private function_4c96295bf65b714d( obj )
{
    if ( function_11958aa3a2f98512() )
    {
        if ( !obj.trigger )
        {
            return 0;
        }
        
        return self istouching( obj.trigger );
    }
    
    return 0;
}

// Namespace combat_hologram
// Params 1
// Checksum 0xf34d3e34, Offset: 0x2a60
// Size: 0x49, Type: bool
function combatholo_shouldcaptureobjective( obj )
{
    return self.var_57b273c971318b8f && !self.var_918f5731d316cbc && self.var_325b10d7c325f3b4 && !function_c24e0b97a3c60ad( obj ) && function_4c96295bf65b714d( obj );
}

// Namespace combat_hologram
// Params 2, eflags: 0x4
// Checksum 0x5a287aac, Offset: 0x2ab2
// Size: 0x2cd
function private function_2170ea7264e10277( victim, fromshooting )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    var_f39f0b5d791a8c28 = 0;
    currenttime = gettime();
    debufftime = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle.var_6dce5b01e9a8563b ?? 7;
    debufftime *= 1000;
    
    if ( isdefined( victim ) )
    {
        if ( !isdefined( victim.var_3a29ed04cfdf5c2 ) )
        {
            var_f39f0b5d791a8c28 = 1;
        }
        else if ( currenttime - victim.var_3a29ed04cfdf5c2 > debufftime )
        {
            var_f39f0b5d791a8c28 = 1;
        }
        else
        {
            var_f39f0b5d791a8c28 = 0;
        }
        
        victim.var_3a29ed04cfdf5c2 = currenttime;
        victim.var_b5d86c7faddcaeb = self;
    }
    
    var_2d59a5c1c13f34a1 = { #distractor:self, #time:currenttime, #combatholoowner:self.owner };
    victim.var_8f711e8aa29675bb[ victim getentitynumber() ] = var_2d59a5c1c13f34a1;
    
    if ( self.hitreactent )
    {
        if ( self.hitreactent getscriptablepartstate( #"hitreact_fx", 1, 1 ) == #"neutral" )
        {
            self.hitreactent setscriptablepartstate( #"hitreact_fx", #"enemy_triggered", 0 );
        }
    }
    
    if ( fromshooting )
    {
        victim playlocalsound( "fup_combat_holo_impact_2d" );
    }
    
    thread function_2d68a3b0478102fb( 1 );
    victim.var_483315f90a71728e[ self.owner getentitynumber() ] = currenttime;
    waitframe();
    
    if ( var_f39f0b5d791a8c28 && self.owner )
    {
        self.grenadeowner notify( #"hash_a981377deaf648f3", victim );
        
        if ( self.grenadeowner.var_64440c60068942c4 )
        {
            basepoints = rank::getscoreinfovalue( #"hash_c448a3b5652c2767" ) ?? 0;
            self.owner thread points::doscoreevent( #"hash_c448a3b5652c2767", self.grenadeowner.weapon_object, basepoints + self.grenadeowner.var_64440c60068942c4 );
        }
        else
        {
            self.owner thread points::doscoreevent( #"hash_c448a3b5652c2767", self.grenadeowner.weapon_object );
        }
        
        self.owner thread challenges::function_a0936b0e5b4550f3( "super_combat_hologram", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0xc
// Checksum 0xd247d414, Offset: 0x2d87
// Size: 0x1d5
function private function_ef46303028fba0fe()
{
    self notify( #"hash_1d31290088689cf1" );
    self endon( #"hash_1d31290088689cf1" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    checkinterval = 1;
    cooldown = self.grenadeowner.bundle.var_17adc2d74156fee1 ?? 7;
    detectionradius = self.grenadeowner.bundle.var_94dc2a1ac6e1ce79 ?? 300;
    hasflashed = 0;
    
    while ( true )
    {
        if ( self.grenadeowner.var_7568cab78e4268cc || !self.isvisible )
        {
            wait checkinterval;
            continue;
        }
        
        enemiesinrange = [];
        
        foreach ( player in getplayersinradius( self.origin, detectionradius ) )
        {
            if ( player::isreallyalive( player ) && player_utility::playersareenemies( player, self.owner ) && !isdefined( player.perks[ "specialty_ghost" ] ) )
            {
                enemiesinrange[ enemiesinrange.size ] = player;
            }
        }
        
        if ( enemiesinrange.size > 0 )
        {
            hasflashed = 1;
            thread function_5b1d95e12cd9f275( enemiesinrange );
        }
        
        wait hasflashed ? cooldown : checkinterval;
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0x7c7989d, Offset: 0x2f64
// Size: 0x2a8
function private function_5b1d95e12cd9f275( enemiesinrange )
{
    self notify( #"hash_14dd2894ed22761b" );
    self endon( #"hash_14dd2894ed22761b" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    assert( bundle.var_a0652728c2c212a, "<dev string:x1aa>" );
    assert( bundle.var_57cc19b430454f8, "<dev string:x1f5>" );
    decoyheight = self.spawnedtype == 1 ? 48 : 64;
    var_404e35c35105ba43 = self.origin + ( 0, 0, decoyheight );
    var_4c8fde40a11f90ca = magicgrenademanual( bundle.var_a0652728c2c212a, var_404e35c35105ba43, ( 0, 0, 0 ), 0.1, self.owner );
    duration = 2;
    interruptdelayms = 500;
    var_4c8fde40a11f90ca.owner = self.owner;
    var_4c8fde40a11f90ca setentityowner( self.owner );
    var_4c8fde40a11f90ca setotherent( self.owner );
    var_880115487e410e7f = 120;
    fovthreshold = cos( var_880115487e410e7f / 2 );
    tracecontents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1 );
    
    foreach ( victim in enemiesinrange )
    {
        if ( !victim player::isreallyalive( victim ) || victim utility::isusingremote() || !function_af84c424532750db( victim, var_4c8fde40a11f90ca, var_404e35c35105ba43, fovthreshold, tracecontents ) )
        {
            continue;
        }
        
        thread function_2170ea7264e10277( victim );
        
        if ( !victim usingtouch() )
        {
            victim utility::hidehudenable();
        }
        
        victim shellshock_utility_cpmp::_shellshock( bundle.var_57cc19b430454f8, #"flash", duration, 1, interruptdelayms );
        victim player::codcastersetplayerstatuseffect( "flash", duration );
        victim thread flash_grenade::function_c9bd8e0a8c61894a( duration, !player::isreallyalive( victim ) );
    }
}

// Namespace combat_hologram
// Params 5, eflags: 0x4
// Checksum 0x583f67cd, Offset: 0x3214
// Size: 0x84, Type: bool
function private function_af84c424532750db( enemy, var_4c8fde40a11f90ca, var_404e35c35105ba43, fovthreshold, tracecontents )
{
    ignorelist = [ self, self.weaponent, var_4c8fde40a11f90ca, enemy ];
    
    if ( !enemy math::point_in_fov( var_404e35c35105ba43, fovthreshold, 0 ) )
    {
        return false;
    }
    
    if ( !trace::ray_trace_passed( enemy geteye(), var_404e35c35105ba43, ignorelist, tracecontents ) )
    {
        return false;
    }
    
    return true;
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0xef4141aa, Offset: 0x32a1
// Size: 0x159
function private function_2d68a3b0478102fb( time )
{
    self notify( #"hash_8e11e8aec06c8ff7" );
    self endon( #"hash_8e11e8aec06c8ff7" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    bundle = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle;
    assert( bundle.var_570e82bd3cc3bff0, "<dev string:x231>" );
    
    if ( !isdefined( self.var_b3ea506586f0a592 ) )
    {
        self.var_b3ea506586f0a592 = outline::outlineenableforall( self, bundle.var_570e82bd3cc3bff0, "equipment" );
    }
    
    if ( !isdefined( self.var_90fc86371c7af80a ) )
    {
        self.var_90fc86371c7af80a = outline::outlineenableforall( self.weaponent, bundle.var_570e82bd3cc3bff0, "equipment" );
    }
    
    wait time;
    
    if ( self.var_b3ea506586f0a592 )
    {
        outline::outlinedisable( self.var_b3ea506586f0a592, self );
        self.var_b3ea506586f0a592 = undefined;
    }
    
    if ( self.var_90fc86371c7af80a )
    {
        outline::outlinedisable( self.var_90fc86371c7af80a, self.weaponent );
        self.var_90fc86371c7af80a = undefined;
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0x4
// Checksum 0x4704b09, Offset: 0x3402
// Size: 0xbc
function private combatholo_makedamageable()
{
    self.health = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle.var_d866eea5f822e4ae ?? 1;
    self setcandamage( 1 );
    thread damage::monitordamage( self.health, "hitequip", &combatholo_destroy, &function_34ede7ad2dc7b96d );
    self.decoy.health = 100;
    self.decoy setcandamage( 1 );
    self.decoy thread damage::monitordamage( self.decoy.health, "hitequip", &function_387b2f9a569a54ac, &function_cd9d0a58ab997ef9 );
}

// Namespace combat_hologram
// Params 1
// Checksum 0xea542dee, Offset: 0x34c6
// Size: 0xf1
function function_34ede7ad2dc7b96d( damagedata )
{
    if ( damagedata.meansofdeath == "MOD_IMPACT" && !damagedata.inflictor.bundle.force_damage_combatholo || damagedata.damage <= 1 )
    {
        return 0;
    }
    
    attacker = damagedata.attacker;
    owner = self.owner;
    
    if ( !( isdefined( attacker ) && isdefined( owner ) ) )
    {
        return 0;
    }
    
    if ( attacker.team && owner != attacker && !player_utility::playersareenemies( owner, attacker ) && !attacker.var_f8f3389a826c5d19 )
    {
        return 0;
    }
    
    if ( damagedata.inflictor.classname == "rocket" )
    {
        return self.maxhealth;
    }
    
    return 1;
}

// Namespace combat_hologram
// Params 1
// Checksum 0x1d906e96, Offset: 0x35c0
// Size: 0x68, Type: bool
function function_cd9d0a58ab997ef9( damagedata )
{
    attacker = damagedata.attacker;
    owner = self.owner;
    
    if ( !( isdefined( attacker ) && isdefined( owner ) ) )
    {
        return false;
    }
    
    if ( owner == attacker || !player_utility::playersareenemies( owner, attacker ) )
    {
        return false;
    }
    
    thread function_2170ea7264e10277( attacker, 1 );
    return false;
}

// Namespace combat_hologram
// Params 1
// Checksum 0x22ebea7a, Offset: 0x3631
// Size: 0x214
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_f1bd7a2ddbd3f4a" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_f1bd7a2ddbd3f4a", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.var_ad4eb9f85798b7a7 ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.var_ad4eb9f85798b7a7, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_51188edb12d4a1e2 = params.bundle.var_b44cb84a7d9e2dda ?? undefined;
            self.var_64440c60068942c4 = params.bundle.var_67dd432c1993434c ?? undefined;
        }
    }
}

// Namespace combat_hologram
// Params 1
// Checksum 0x614fb6c4, Offset: 0x384d
// Size: 0xc2
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.var_ad4eb9f85798b7a7 ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.var_ad4eb9f85798b7a7, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                self.var_51188edb12d4a1e2 = undefined;
                self.var_64440c60068942c4 = undefined;
            }
        }
    }
}

// Namespace combat_hologram
// Params 1
// Checksum 0x12e78c48, Offset: 0x3917
// Size: 0x252
function function_38cf8364e4d8e652( params )
{
    debufftime = level.superglobals.staticsuperdata[ "super_combat_hologram" ].bundle.var_6dce5b01e9a8563b ?? 7;
    debufftime += params.victim.var_b5d86c7faddcaeb.grenadeowner.var_51188edb12d4a1e2 ?? 0;
    debufftime *= 1000;
    
    if ( params.victim.var_8f711e8aa29675bb )
    {
        foreach ( var_2d59a5c1c13f34a1 in params.victim.var_8f711e8aa29675bb )
        {
            if ( var_2d59a5c1c13f34a1.time >= gettime() - debufftime )
            {
                if ( var_2d59a5c1c13f34a1.combatholoowner == self )
                {
                    self.modifiers[ "wasTricked" ] = 1;
                    self.modifiers[ "wasTrickedEchoWeapon" ] = var_2d59a5c1c13f34a1.distractor.grenadeowner.weapon_object;
                    continue;
                }
                
                if ( !isdefined( self.modifiers[ "wasTrickedAssistList" ] ) )
                {
                    self.modifiers[ "wasTrickedAssistList" ] = [];
                }
                
                if ( !function_978bde7975eb37( self.modifiers[ "wasTrickedAssistList" ], var_2d59a5c1c13f34a1.combatholoowner ) )
                {
                    var_32687339cd7ffa62 = spawnstruct();
                    var_32687339cd7ffa62.player = var_2d59a5c1c13f34a1.combatholoowner;
                    var_32687339cd7ffa62.echoweapon = var_2d59a5c1c13f34a1.distractor.grenadeowner.weapon_object;
                    self.modifiers[ "wasTrickedAssistList" ][ self.modifiers[ "wasTrickedAssistList" ].size ] = var_32687339cd7ffa62;
                }
            }
        }
        
        params.victim.var_8f711e8aa29675bb = undefined;
    }
}

// Namespace combat_hologram
// Params 1
// Checksum 0xa5591acf, Offset: 0x3b71
// Size: 0xee
function on_player_elim( params )
{
    if ( self.modifiers[ "wasTricked" ] )
    {
        thread points::doscoreevent( #"super_combat_hologram_kill", self.modifiers[ "wasTrickedEchoWeapon" ] );
    }
    
    if ( self.modifiers[ "wasTrickedAssistList" ].size > 0 )
    {
        foreach ( struct in self.modifiers[ "wasTrickedAssistList" ] )
        {
            struct.player thread points::doscoreevent( #"super_combat_hologram_assist", struct.echoweapon );
        }
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0x37d9f261, Offset: 0x3c67
// Size: 0x93, Type: bool
function function_978bde7975eb37( structarray, targetplayer )
{
    foreach ( struct in structarray )
    {
        if ( struct.player == targetplayer )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace combat_hologram
// Params 1
// Checksum 0x54702ba7, Offset: 0x3d03
// Size: 0x2b
function combatholo_onplayerdisconnect( params )
{
    if ( isdefined( self.combatholo ) )
    {
        self.combatholo thread combatholo_destroy( undefined, 0 );
    }
}

// Namespace combat_hologram
// Params 1
// Checksum 0xdf938489, Offset: 0x3d36
// Size: 0x92
function function_12f7e3a1c915cc4d( params )
{
    if ( self.owner )
    {
        weaponobject = isweapon( params.capturebot.weapon_object ) ? params.capturebot.weapon_object : undefined;
        self.owner points::doscoreevent( #"combat_holo_capture", weaponobject );
        
        if ( weaponobject )
        {
            self.owner thread gamelogic_mp::threadedsetweaponstatbyname( weaponobject, 1, "objective_captures" );
        }
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0x7794bf7b, Offset: 0x3dd0
// Size: 0x1cd
function combatholo_destroy( damagedata, immediate )
{
    if ( !isdefined( self ) || self.var_918f5731d316cbc )
    {
        return;
    }
    
    if ( damagedata )
    {
        attacker = isplayer( damagedata ) ? damagedata : damagedata.attacker;
        objweapon = isplayer( damagedata ) ? undefined : damagedata.objweapon;
    }
    
    if ( attacker && player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( self.owner )
        {
            self.owner thread equipment_utility::function_72a91d0610eb601c( "super_combat_hologram", #"destroyed", #"destroyed_multiple" );
        }
        
        attacker thread points::doscoreevent( #"super_combat_hologram_destroyed", objweapon );
    }
    
    function_4d84a6523c59bb8a();
    self setcandamage( 0 );
    equipment_interact::function_2e1b95de8d0440b9();
    
    if ( !isdefined( immediate ) )
    {
        immediate = !self.planted;
    }
    
    deletiondelay = 0.3;
    
    if ( !immediate )
    {
        thread function_e0dec82b884dc166();
        
        if ( self.decoy )
        {
            self.decoy thread function_46e531d5690b2d47();
        }
    }
    
    self setscriptablepartstate( #"destroy", #"active", 0 );
    
    if ( isdefined( self.decoy ) && !self.decoy.var_918f5731d316cbc )
    {
        self.decoy thread function_387b2f9a569a54ac( damagedata, immediate );
    }
    
    if ( isdefined( self.triggervolume ) )
    {
        self.triggervolume thread combatholo_delete_trigger();
    }
    
    if ( attacker )
    {
        attacker.var_3a29ed04cfdf5c2 = gettime();
        attacker.var_b5d86c7faddcaeb = self;
    }
    
    thread function_6e4673d949d933a2( deletiondelay );
}

// Namespace combat_hologram
// Params 1
// Checksum 0xf962786, Offset: 0x3fa5
// Size: 0xef
function function_6e4673d949d933a2( deletiondelay )
{
    self notify( #"hash_88ee3e64655ae9ca" );
    self endon( #"hash_88ee3e64655ae9ca" );
    self notify( #"death" );
    self.var_918f5731d316cbc = 1;
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
    
    if ( isdefined( self.var_ad4eb9f85798b7a7 ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_ad4eb9f85798b7a7 );
        self.var_ad4eb9f85798b7a7 = undefined;
    }
    
    if ( isdefined( self.var_505a6bc6f580454c ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_505a6bc6f580454c );
        self.var_505a6bc6f580454c = undefined;
    }
    
    if ( self.owner )
    {
        self.owner.combatholo = undefined;
        self.owner weapons::removeequip( self );
    }
    
    level.combatholos[ self getentitynumber() ] = undefined;
    wait deletiondelay;
    
    if ( self )
    {
        self delete();
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0xc97c7fc6, Offset: 0x409c
// Size: 0x4a
function function_387b2f9a569a54ac( damagedata, immediate )
{
    if ( !isdefined( self ) || self.var_918f5731d316cbc )
    {
        return;
    }
    
    self setcandamage( 0 );
    deletiondelay = 0.1;
    thread function_89921bee7c5140e7( deletiondelay );
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0xe9d407e8, Offset: 0x40ee
// Size: 0x19d
function private function_89921bee7c5140e7( deletiondelay )
{
    self notify( #"hash_a00099899351684a" );
    self endon( #"hash_a00099899351684a" );
    self notify( #"death" );
    self.var_918f5731d316cbc = 1;
    
    if ( self.var_a5a8615f53766fa9 )
    {
        outline::outlinedisable( self.var_a5a8615f53766fa9, self );
        self.var_a5a8615f53766fa9 = undefined;
    }
    
    if ( self.var_ce66719dd1aaa231 )
    {
        outline::outlinedisable( self.var_ce66719dd1aaa231, self.weaponent );
        self.var_ce66719dd1aaa231 = undefined;
    }
    
    if ( self.var_262974bc36aa2c8a )
    {
        outline::outlinedisable( self.var_262974bc36aa2c8a, self );
        self.var_262974bc36aa2c8a = undefined;
    }
    
    if ( self.var_c6a5b26e87c0be52 )
    {
        outline::outlinedisable( self.var_c6a5b26e87c0be52, self.weaponent );
        self.var_c6a5b26e87c0be52 = undefined;
    }
    
    if ( self.var_b3ea506586f0a592 )
    {
        outline::outlinedisable( self.var_b3ea506586f0a592, self );
        self.var_b3ea506586f0a592 = undefined;
    }
    
    if ( self.var_90fc86371c7af80a )
    {
        outline::outlinedisable( self.var_90fc86371c7af80a, self.weaponent );
        self.var_90fc86371c7af80a = undefined;
    }
    
    if ( self.grenadeowner )
    {
        self.grenadeowner.decoy = undefined;
    }
    
    wait deletiondelay;
    
    if ( self.weaponent )
    {
        self.weaponent delete();
    }
    
    if ( self.hitreactent )
    {
        self.hitreactent delete();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0xc
// Checksum 0x1ba87364, Offset: 0x4293
// Size: 0x52
function private combatholo_delete_trigger()
{
    self notify( #"hash_4538ce5d0da56d1e" );
    self endon( #"hash_4538ce5d0da56d1e" );
    self notify( #"death" );
    self.grenadeowner.triggervolume = undefined;
    waitframe();
    
    if ( isdefined( self ) && isdefined( self.grenadeowner ) )
    {
        self delete();
    }
}

// Namespace combat_hologram
// Params 0, eflags: 0xc
// Checksum 0xa9bd1ee4, Offset: 0x42ed
// Size: 0xca
function private function_28a1be9b590503d5()
{
    self notify( #"hash_c43219b8c790e161" );
    self endon( #"hash_c43219b8c790e161" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    if ( self.invalidplacement || !self isscriptable() )
    {
        return;
    }
    
    self setscriptablepartstate( #"deactivate", #"neutral", 0 );
    self setscriptablepartstate( #"emped", #"off", 0 );
    self setscriptablepartstate( #"activate", #"activate", 0 );
    self setscriptablepartstate( #"active", #"active", 0 );
}

// Namespace combat_hologram
// Params 1, eflags: 0xc
// Checksum 0x25aea246, Offset: 0x43bf
// Size: 0xf3
function private function_e0dec82b884dc166( var_fecc00ce5ad91c96 )
{
    self notify( #"hash_7f402705a555549e" );
    self endon( #"hash_7f402705a555549e" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    if ( !self isscriptable() )
    {
        return;
    }
    
    self setscriptablepartstate( #"objective", #"neutral", 0 );
    self setscriptablepartstate( #"activate", #"neutral", 0 );
    self setscriptablepartstate( #"active", #"neutral", 0 );
    self setscriptablepartstate( #"deactivate", #"deactivate", 0 );
    
    if ( !self.invalidplacement && var_fecc00ce5ad91c96 )
    {
        self setscriptablepartstate( #"emped", #"on", 0 );
    }
}

// Namespace combat_hologram
// Params 0
// Checksum 0x177c6be4, Offset: 0x44ba
// Size: 0x1b2
function function_b3081550a6f4d862()
{
    self endon( #"death", #"hash_cf86568d0a6b1f06" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    if ( self.grenadeowner.invalidplacement )
    {
        return;
    }
    
    var_1b5e3111cf500f3e = self getscriptablepartstate( #"fade", 1, 1 );
    
    if ( var_1b5e3111cf500f3e == #"hash_9bd4548c6267f4c" )
    {
        return;
    }
    
    self setscriptablepartstate( #"fx", #"on", 0 );
    
    if ( var_1b5e3111cf500f3e == #"in_final" )
    {
        self show();
        
        if ( self.weaponent )
        {
            self.weaponent show();
        }
    }
    else
    {
        self notify( #"hash_32c701a246e49883" );
        self hide();
        
        if ( self.weaponent )
        {
            self.weaponent hide();
        }
        
        self setscriptablepartstate( #"fade", #"hash_9bd4548c6267f4c", 0 );
        wait 0.1;
        self show();
        wait 0.1;
        
        if ( self.weaponent )
        {
            self.weaponent show();
        }
        
        wait 0.1;
    }
    
    if ( self.spawnedtype == 1 )
    {
        self setscriptablepartstate( #"hash_cbdc08e3bb09833d", #"crouch", 0 );
    }
    else
    {
        self setscriptablepartstate( #"hash_cbdc08e3bb09833d", #"idle", 0 );
    }
    
    if ( self.grenadeowner )
    {
        self.grenadeowner function_9bf2cd96d9754fd1();
    }
    
    self.isvisible = 1;
}

// Namespace combat_hologram
// Params 1
// Checksum 0x49e431ea, Offset: 0x4674
// Size: 0x194
function function_46e531d5690b2d47( immediate )
{
    self endon( #"death", #"hash_32c701a246e49883" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    var_1b5e3111cf500f3e = self getscriptablepartstate( #"fade", 1, 1 );
    
    if ( var_1b5e3111cf500f3e == #"hash_80c4f2a8975d2279" )
    {
        return;
    }
    
    self setscriptablepartstate( #"hash_cbdc08e3bb09833d", #"none", 0 );
    self setscriptablepartstate( #"fx", #"off", 0 );
    
    if ( var_1b5e3111cf500f3e == #"out_final" )
    {
        self hide();
        
        if ( self.weaponent )
        {
            self.weaponent hide();
        }
    }
    else
    {
        self notify( #"hash_cf86568d0a6b1f06" );
        
        if ( immediate )
        {
            self setscriptablepartstate( #"fade", #"out_final", 0 );
            
            if ( self.weaponent )
            {
                self.weaponent hide();
            }
        }
        else
        {
            self show();
            self setscriptablepartstate( #"fade", #"hash_80c4f2a8975d2279", 0 );
            wait 0.1;
            
            if ( self.weaponent )
            {
                self.weaponent hide();
            }
            
            wait 0.1;
        }
    }
    
    self hide();
    
    if ( self.grenadeowner )
    {
        self.grenadeowner function_4d84a6523c59bb8a();
    }
    
    self.isvisible = 0;
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0x44ecf3f5, Offset: 0x4810
// Size: 0xb3
function private updatedisable( jammedholo )
{
    if ( jammedholo.var_7568cab78e4268cc )
    {
        jammedholo function_4d84a6523c59bb8a();
        jammedholo thread function_e0dec82b884dc166( 1 );
        
        if ( jammedholo.decoy )
        {
            jammedholo.decoy thread function_46e531d5690b2d47();
        }
        
        if ( isdefined( jammedholo.var_ad4eb9f85798b7a7 ) )
        {
            entityheadicons::setheadicon_deleteicon( jammedholo.var_ad4eb9f85798b7a7 );
        }
        
        jammedholo.var_ad4eb9f85798b7a7 = undefined;
        return;
    }
    
    jammedholo thread combatholo_activate( jammedholo.owner );
    
    if ( !isdefined( jammedholo.var_ad4eb9f85798b7a7 ) )
    {
        jammedholo.var_ad4eb9f85798b7a7 = entityheadicons::setheadicon_fieldupgrade( jammedholo );
    }
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0x54c6fc34, Offset: 0x48cb
// Size: 0x3c
function private function_f2fdd019aa1d97a6( jammedholo )
{
    if ( !isdefined( jammedholo.var_7568cab78e4268cc ) )
    {
        jammedholo.var_7568cab78e4268cc = 0;
    }
    
    jammedholo.var_7568cab78e4268cc++;
    updatedisable( jammedholo );
}

// Namespace combat_hologram
// Params 1, eflags: 0x4
// Checksum 0x8735ea39, Offset: 0x490f
// Size: 0x21
function private function_655bd8caffa5d850( jammedholo )
{
    jammedholo.var_7568cab78e4268cc--;
    updatedisable( jammedholo );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x2a2a4d4c, Offset: 0x4938
// Size: 0x34
function combatholo_empapplied( empstruct )
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 0;
    }
    
    self.var_7568cab78e4268cc++;
    updatedisable( self );
}

// Namespace combat_hologram
// Params 1
// Checksum 0x46058f57, Offset: 0x4974
// Size: 0x1e
function combatholo_empcleared( empstruct )
{
    self.var_7568cab78e4268cc--;
    updatedisable( self );
}

// Namespace combat_hologram
// Params 0, eflags: 0xc
// Checksum 0xfd889ee4, Offset: 0x499a
// Size: 0x8d
function private function_f4d9cb4623219410()
{
    self notify( #"hash_7714e0501fde0f19" );
    self endon( #"hash_7714e0501fde0f19" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    while ( true )
    {
        self waittill( #"hash_fcabc713fb442a93", smokegrenadeowner );
        
        if ( player_utility::playersareenemies( self.owner, smokegrenadeowner ) )
        {
            thread function_2170ea7264e10277( smokegrenadeowner );
        }
    }
}

// Namespace combat_hologram
// Params 2
// Checksum 0x96d4d670, Offset: 0x4a2f
// Size: 0x27f
function combatholo_hack( hackeffect, attacker )
{
    self notify( #"hologram_hacked" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_interact::function_2e1b95de8d0440b9();
    self.owner.combatholo = undefined;
    
    if ( isdefined( self.decoy ) && !self.decoy.var_918f5731d316cbc )
    {
        self.decoy thread function_387b2f9a569a54ac( undefined, 1 );
    }
    
    if ( isdefined( self.triggervolume ) )
    {
        self.triggervolume thread combatholo_delete_trigger();
    }
    
    function_4d84a6523c59bb8a();
    
    if ( attacker.combatholo )
    {
        attacker.combatholo thread combatholo_destroy( undefined, 0 );
    }
    
    self.owner = attacker;
    self.team = attacker.team;
    self.pers[ "team" ] = attacker.team;
    self setentityowner( attacker );
    self setotherent( attacker );
    attacker.combatholo = self;
    function_28bf72d5a6dace11( ( 0, self.owner.angles[ 1 ], 0 ) );
    thread combatholo_activate( attacker );
    thread combatholo_watchlifetime( attacker );
    
    if ( !self.invulnerable )
    {
        combatholo_makedamageable();
    }
    
    if ( self.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = self.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = self.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = self.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", self );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( attacker.team );
    }
    else
    {
        self filteroutplayermarks( attacker );
    }
    
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
}

// Namespace combat_hologram
// Params 0
// Checksum 0x6fa76cf4, Offset: 0x4cb6
// Size: 0xf3
function function_72a1bd67cc9bf1b8()
{
    showto = teams::getenemyplayers( self.team );
    image = level.gamemodebundle.var_a43747faa623d1b0 ?? "ui_hud_icon_field_upgrade";
    offset = 10;
    drawthroughgeo = 0;
    maxdrawdist = 250;
    naturaldist = 0;
    delaytime = 0;
    var_c6bd58f878e4420a = 0;
    var_6275850de36415ea = 0;
    overrideorigin = undefined;
    showonminimap = 0;
    iconsize = "icon_small";
    var_2647798941f03f3b = 1;
    var_36f6867c83910042 = undefined;
    var_ec2e1175c694fcf6 = -1;
    return entityheadicons::setheadicon_singleimage( showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap, iconsize, var_2647798941f03f3b, var_36f6867c83910042, var_ec2e1175c694fcf6 );
}

