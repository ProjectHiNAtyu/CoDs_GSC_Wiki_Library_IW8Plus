// scripts\mp\common\equipment\trophy_system.gsc  (hash_38a2a2c62d6be2ed.gscc) (size: 36883 Bytes / 0x9013 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa057818 (4194662424)
// size ...... 36883 (0x9013)
// includes .. 42  (offset: 0x8973)
// strings ... 73  (offset: 0x8ac3)
// dev strs .. 14  (offset: 0x8f5b)
// exports ... 93  (offset: 0x5827)
// cseg ...... 0x6d6 + 0x5151 (0x5827)
// imports ... 293 (offset: 0x66af)
// animtree1 . 0   (offset: 0x9003)
// animtree2 . 1   (offset: 0x9003)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\equipment\snapshot_grenade;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perk_equipmentping;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x1
// Checksum 0xae45bd58, Offset: 0x6f4
// Size: 0x47b
function autoexec trophy_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_trophy", &superset, &superunset, undefined, undefined, undefined, undefined, undefined, &trophy_reclaim, &supers_mp::function_484ca0a545e40e20 );
    levelstruct = spawnstruct();
    levelstruct.barrel_pairs = [];
    trophybundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    
    if ( !isdefined( trophybundle ) )
    {
        trophybundle = equipment_mp::function_c90a9aa89b223dd7( "equip_trophy" );
    }
    
    if ( !isdefined( trophybundle ) )
    {
        trophybundle = spawnstruct();
    }
    
    if ( isdefined( trophybundle.var_59c22b5157d531c0 ) && trophybundle.var_59c22b5157d531c0.size > 0 )
    {
        foreach ( idx, barrel in trophybundle.var_59c22b5157d531c0 )
        {
            levelstruct.barrel_pairs[ idx ] = barrel;
        }
    }
    else
    {
        numbarrels = trophybundle.var_99cc5940518e2f11 ?? 3;
        
        for ( idx = 0; idx < numbarrels ; idx++ )
        {
            barrel = spawnstruct();
            barrel.tag = "tag_barrel_" + idx + 1;
            barrel.part = "barrel" + idx + 1;
            levelstruct.barrel_pairs[ idx ] = barrel;
        }
    }
    
    if ( trophybundle.var_84b7ee21b17a096b )
    {
        levelstruct.timeout = undefined;
    }
    else
    {
        levelstruct.timeout = trophybundle.maxlifetime ?? getdvarfloat( @"hash_d9b119233df13ac1", 45 );
    }
    
    levelstruct.explosionxmodel = trophybundle.var_3c9a830d796718cc ?? "trophy_system_mp_explode";
    levelstruct.norefund = trophybundle.var_6fb8a643800928c5;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    
    if ( !isdefined( bundle ) )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_trophy" );
    }
    
    ignorearr = [];
    
    if ( isdefined( bundle.var_8a2bd4ed971a5f36 ) )
    {
        foreach ( var_21ed91b0e05adbf0 in bundle.var_8a2bd4ed971a5f36 )
        {
            ignorearr[ ignorearr.size ] = var_21ed91b0e05adbf0;
        }
    }
    
    levelstruct.ignorelist = ignorearr;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    
    if ( !isdefined( bundle ) )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_trophy" );
    }
    
    var_216a6c482fe3f15f = bundle.var_3f8a866a1caccbfc ?? 0;
    
    if ( var_216a6c482fe3f15f )
    {
        laservfx = bundle.trophy_laser_fx;
        assert( isdefined( laservfx ), "<dev string:x24>" );
        utility::add_fx( "trophy_laser_beam", laservfx );
    }
    
    level.trophy = levelstruct;
    weapons::registerusedcallback( "trophy", &trophy_used );
    weapons::function_1d6e543fafed66c9( "trophy", &trophy_pickup );
    equipment_mp::registercallback( "equip_trophy", "onGive", &trophy_set );
    equipment_mp::registercallback( "equip_trophy", "onTake", &trophy_unset );
    equipment_mp::registercallback( "equip_trophy", "onOwnerChanged", &trophy_onownerchanged );
    equipment_mp::registercallback( "equip_trophy", "onDestroyedByTrophy", &trophy_delete );
    utility::registersharedfunc( #"trophy_system", #"hack", &hack );
    utility::registersharedfunc( #"trophy", #"modifydamage", &trophy_modifieddamage );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"train" ][ #"hash_2edafff898b3de81" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( #"trophy_system", &sweeptrophy );
    }
    
    if ( !isdefined( level.var_1a371ac7284992a5 ) )
    {
        level.var_1a371ac7284992a5 = [];
    }
    
    level.trophy_system_initialized = 1;
    level thread function_5e7d5f8dc4d07454();
    level thread function_bb14c165d2c90cab();
}

// Namespace trophy_system
// Params 0
// Checksum 0x734e7fa4, Offset: 0xb77
// Size: 0xe9
function superset()
{
    if ( !isdefined( self.var_6a2d9548aeda69ae ) )
    {
        self.var_6a2d9548aeda69ae = [];
    }
    
    bundle = level.superglobals.staticsuperdata[ "super_trophy" ].bundle;
    
    if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_trophy", bundle.var_c7709714d768097c ) )
    {
        self.var_6a2d9548aeda69ae[ "super_trophy" ] = 1;
        assert( bundle.var_4f00f10b13fd5fb7, "<dev string:x6b>" );
        multiplier = bundle.var_4f00f10b13fd5fb7 ?? 2;
        perk::giveperk( "specialty_faster_field_upgrade" );
        val::set( "super_trophy", "field_upgrade_recharge_mult", multiplier );
        return;
    }
    
    self.var_6a2d9548aeda69ae[ "super_trophy" ] = 0;
}

// Namespace trophy_system
// Params 0
// Checksum 0xf1afe9e2, Offset: 0xc68
// Size: 0x40
function superunset()
{
    if ( self.var_6a2d9548aeda69ae[ "super_trophy" ] )
    {
        val::reset( "super_trophy", "field_upgrade_recharge_mult" );
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    self.var_6a2d9548aeda69ae[ "super_trophy" ] = undefined;
}

// Namespace trophy_system
// Params 2, eflags: 0x4
// Checksum 0x3f865c7a, Offset: 0xcb0
// Size: 0x105
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_interact::function_2e1b95de8d0440b9();
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    
    if ( self.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = self.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = self.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = self.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
    }
    
    thread trophy_watchtimeoutorgameended();
}

// Namespace trophy_system
// Params 0, eflags: 0xc
// Checksum 0x58a4d02, Offset: 0xdbd
// Size: 0x53
function private function_5e7d5f8dc4d07454()
{
    self notify( #"hash_e44477faf9f935ad" );
    self endon( #"hash_e44477faf9f935ad" );
    level endon( #"game_ended" );
    level endon( #"trophy_system_deployed" );
    
    while ( true )
    {
        level.var_1a371ac7284992a5 = function_5713d46873b29625( level.var_1a371ac7284992a5 );
        wait 10;
    }
}

// Namespace trophy_system
// Params 4
// Checksum 0xb45cbf32, Offset: 0xe18
// Size: 0x35
function trophy_set( equipmentref, slot, variantid, attachments )
{
    trophy_clearstored();
    trophy_populatestored();
}

// Namespace trophy_system
// Params 2
// Checksum 0x1cbcad4f, Offset: 0xe55
// Size: 0x1c
function trophy_unset( equipmentref, slot )
{
    trophy_clearstored();
}

// Namespace trophy_system
// Params 0
// Checksum 0xf4cbd175, Offset: 0xe79
// Size: 0x3e
function function_678b345fbf9e40c4()
{
    if ( self.issuper )
    {
        if ( !level.trophy.norefund )
        {
            self.owner thread trophy_refund();
        }
    }
    
    thread trophy_shutdownanddestroy( 1 );
}

// Namespace trophy_system
// Params 0
// Checksum 0xf39f465f, Offset: 0xebf
// Size: 0x24
function trophy_refund()
{
    if ( isbrgamemode() )
    {
        utility::delaythread( 2.5, &function_40a71b352757d24f );
        return;
    }
    
    supers_mp::refundsuper();
}

// Namespace trophy_system
// Params 0
// Checksum 0x1a0d21ff, Offset: 0xeeb
// Size: 0x8d
function function_40a71b352757d24f()
{
    fakepickup = spawnstruct();
    fakepickup.scriptablename = "brloot_offhand_trophysystem";
    fakepickup.origin = self.origin;
    fakepickup.count = 1;
    fakepickup.var_b8b2f39fcba6d824 = 1;
    forcebackpack = 0;
    
    if ( isdefined( self.super ) && self.var_33129007db246c94 )
    {
        forcebackpack = 1;
    }
    
    br_pickups::function_5b180b03ffe1dd26( fakepickup, undefined, self, undefined, undefined, undefined, forcebackpack );
}

// Namespace trophy_system
// Params 1
// Checksum 0xdae5a142, Offset: 0xf80
// Size: 0x237
function function_175ea5ddbb76e74c( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"trophy_system_deployed" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    relaunchvelocity = getdvarint( @"hash_d57482b850330a6", 150 );
    var_ba51608b6d1e8b62 = istrue( bundle.var_5deeb6b5a6b5a062 );
    lastpos = ( 99999, 99999, 99999 );
    grenade childthread equipment_mp::watchwaterdepth( &function_678b345fbf9e40c4, "trophy_system_deployed" );
    var_7d0ca89c4a583506 = 0;
    
    while ( true )
    {
        if ( var_7d0ca89c4a583506 )
        {
            grenade childthread trophy_watch_flight( self );
        }
        
        if ( var_ba51608b6d1e8b62 )
        {
            grenade waittill( #"missile_bounced" );
            var_48c9acfd176d5868 = function_c36c57fb0cc25228( grenade );
        }
        else
        {
            grenade thread function_603843832f3d6605();
            grenade waittill( #"missile_stuck", var_48c9acfd176d5868, hitentpart, surfacetype, velocity, position, hitnormal );
        }
        
        var_7d0ca89c4a583506 = 0;
        
        if ( isdefined( var_48c9acfd176d5868 ) )
        {
            if ( var_48c9acfd176d5868 vehicle::is_vehicle() )
            {
                if ( isdefined( hitentpart ) )
                {
                    hitentpart = vehicle::function_d88b357b027cbaed( hitentpart );
                    iswheel = issubstr( hitentpart, "wheel" );
                    
                    if ( iswheel )
                    {
                        var_7d0ca89c4a583506 = 1;
                    }
                }
            }
            
            if ( var_48c9acfd176d5868 ismovingplatform() )
            {
                grenade linkto( var_48c9acfd176d5868 );
            }
        }
        
        if ( var_7d0ca89c4a583506 )
        {
            grenade unlink();
            offsetvec = hitnormal + self gettagorigin( "j_spineupper" ) - grenade.origin;
            neworigin = grenade.origin + vectornormalize( offsetvec ) * 10;
            grenade = weapon::_launchgrenade( "trophy_mp", neworigin, hitnormal * relaunchvelocity, undefined, 1, grenade );
            continue;
        }
        
        var_53681a0a80360b28 = bundle.var_3d6ee531339414ec ?? 0;
        grenade.origin += hitnormal * var_53681a0a80360b28;
        break;
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0x3c73c7c8, Offset: 0x11c0
// Size: 0x27
function function_603843832f3d6605()
{
    self endon( #"death", #"trophy_system_deployed" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        thread trophy_shutdownanddestroy( 0 );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x7729ce03, Offset: 0x11ef
// Size: 0x115
function function_c36c57fb0cc25228( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"trophy_system_deployed" );
    lastpos = ( 99999, 99999, 99999 );
    
    while ( true )
    {
        deltapos = grenade.origin - lastpos;
        
        if ( length( deltapos ) < 1 )
        {
            tracestart = grenade.origin;
            ground = tracestart + ( 0, 0, -1000 );
            traceresults = trace::ray_trace( tracestart, ground, self );
            grenade.angles = anglestoup( traceresults[ "normal" ] );
            grenade.origin = traceresults[ "position" ] + anglestoup( traceresults[ "normal" ] );
            return traceresults[ "entity" ];
        }
        
        lastpos = grenade.origin;
        waitframe();
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x26ab3eea, Offset: 0x130c
// Size: 0x763
function trophy_used( grenade )
{
    grenade endon( #"death" );
    self endon( #"disconnect" );
    grenade.superref = "super_trophy";
    
    /#
        print::printgameaction( "<dev string:xc4>", self );
    #/
    
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    
    if ( !grenade.bundle )
    {
        grenade.bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_trophy" );
    }
    
    grenade ent_manager::registerspawn( 2, &sweeptrophy );
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    model_name = undefined;
    superinfo = supers_mp::getcurrentsuper();
    superbundle = superinfo.staticdata.bundle;
    grenade.superinfo = superinfo;
    var_aabaa5ddd68ed2a0 = 0;
    
    if ( var_aabaa5ddd68ed2a0 )
    {
        if ( isdefined( superbundle ) && level.allowsupers )
        {
            model_name = function_ae2e4e43e22fef2c( superbundle, superinfo.blueprintindex );
        }
        
        if ( isdefined( model_name ) )
        {
            genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( superbundle, superinfo.blueprintindex );
            grenade setgenericblueprintmodel( genericblueprintname, #"projectilemodel" );
        }
    }
    
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade thread equipment_mp::watchwaterdepth( &function_678b345fbf9e40c4, "trophy_system_deployed" );
    function_175ea5ddbb76e74c( grenade );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            supers_mp::refundsuper();
            hud_message::showerrormessage( %"equipment/plant_failed" );
            grenade delete();
            return;
        }
    }
    
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    grenade.issuper = isdefined( self.super ) && self.super.staticdata.ref == "super_trophy" || utility::callsharedfunc( #"game", #"isCommonItemEnabled" );
    grenade.superid = level.superglobals.staticsuperdata[ "super_trophy" ].id;
    grenade.usedcount = 0;
    grenade.deployingplayer = self;
    grenade.var_736c0b69e68cc5a0 = isdefined( self.perks[ "specialty_rugged_equipment" ] );
    hasrugged = isdefined( self.perks[ "specialty_rugged_eqp" ] );
    
    if ( hasrugged )
    {
        grenade.hasruggedeqp = 1;
    }
    
    if ( !grenade.issuper )
    {
        grenade.ammo = trophy_removestored();
        
        if ( !isdefined( grenade.ammo ) )
        {
            grenade.ammo = grenade.bundle.trophy_max_ammo ?? 3;
        }
        
        /#
            if ( getdvarint( @"hash_20d714b15057681f", 0 ) == 1 )
            {
                grenade.ammo = grenade.bundle.trophy_max_ammo;
            }
        #/
        
        grenade thread weapons::makeexplosiveusabletag( "tag_use", 1 );
    }
    else
    {
        grenade.ammo = grenade.bundle.trophy_max_ammo ?? 3;
    }
    
    if ( grenade.bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_trophy", grenade.bundle.var_e36b84555e7df1d3 ) )
    {
        assert( grenade.bundle.var_a1f4f4469d591dcb, "<dev string:xd3>" );
        grenade.ammo += grenade.bundle.var_a1f4f4469d591dcb ?? 2;
    }
    
    if ( grenade.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = grenade.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = grenade.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = grenade.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        grenade thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, grenade.team );
    }
    
    weapons::onequipmentplanted( grenade, "equip_trophy", &trophy_shutdownanddestroy );
    thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Tactical_Static", self );
    grenade.explosion = trophy_createexplosion( grenade );
    trophymaxhealth = grenade.bundle.trophy_max_health ?? 100;
    var_2f559c8b6ddfb4a2 = grenade.bundle.trophy_max_health_rugged ?? 200;
    maxhealth = hasrugged ? var_2f559c8b6ddfb4a2 : trophymaxhealth;
    
    if ( isdefined( self.perks[ "specialty_mod_health_max" ] ) )
    {
        maxhealth = var_2f559c8b6ddfb4a2;
    }
    
    damagefeedback = "hitequip";
    grenade thread damage::monitordamage( maxhealth, damagefeedback, &trophy_handlefataldamage, &trophy_handledamage, 0 );
    grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &trophy_applyempcallback );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &trophy_disable;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &trophy_enable;
    }
    
    grenade chaff_debuff::function_3860212a5ec36b56( &function_ffeb4e5ec30224ca );
    grenade chaff_debuff::function_324dd42a2703bc25( &function_14e06af96236e673 );
    grenade haywire::function_7f69a1eb3d590f76( &function_96c5799246de8829 );
    grenade function_a4ebfb83ec0621b9( &trophy_destroy );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"push_zone" ][ #"hash_4f146fe3a20624d1" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        grenade [[ var_32dbca3143d9c4a5 ]]( &trophy_destroy );
    }
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            if ( !isdefined( elevators ) )
            {
                continue;
            }
            
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    utility::function_969f9f5596dba07a( grenade, &trophy_destroy );
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade thread trophy_deploy();
}

// Namespace trophy_system
// Params 1, eflags: 0x4
// Checksum 0x84c59e36, Offset: 0x1a77
// Size: 0x1e
function private function_f872fb3ab42412ea( attacker )
{
    trophy_givepointsfordeath( attacker );
    thread trophy_destroy( 1 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x1fe53a03, Offset: 0x1a9d
// Size: 0x13b
function trophy_watch_flight( player )
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    player endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_fbaf852c9cb6dff8 = -2000;
    traceend = self.origin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        groundentity = traceresults[ "entity" ];
        
        if ( isdefined( groundentity ) )
        {
            if ( utility::is_moving_platform_ent( groundentity ) )
            {
                self.origin = player.origin;
            }
        }
    }
}

/#

    // Namespace trophy_system
    // Params 1
    // Checksum 0x5a9a7ccb, Offset: 0x1be0
    // Size: 0xf, Type: dev
    function trophy_passthrough( target )
    {
        
    }

#/

// Namespace trophy_system
// Params 0
// Checksum 0xcd8a901a, Offset: 0x1bf7
// Size: 0x23f
function trophy_deploy()
{
    self endon( #"death" );
    self notify( #"trophy_system_deployed" );
    level notify( #"trophy_system_deployed" );
    self setscriptablepartstate( "effects", "activeLand" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    
    if ( bundle.var_67296742aaa265f9 )
    {
        thread supers_mp::function_24bd67c384c2e606( level.trophy.timeout );
        thread supers_mp::function_3a21005bdaf91ac2( bundle );
        thread supers_mp::function_e7c245e9675fdabb( level.trophy.timeout, &trophy_shutdownanddestroy );
    }
    
    wait 0.1;
    thread trophy_deployanimation();
    wait 0.2;
    imageoverride = self.var_30656af96b2ac2a4.size > 0 ? bundle.buffedheadicon : undefined;
    self.headiconid = entityheadicons::setheadicon_equipment( self, imageoverride );
    thread weapons::outlineequipmentforowner( self );
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        self [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( self );
    }
    
    if ( getdvarint( @"scr_trophy_use_entity_grid", 0 ) != 0 )
    {
        /#
            if ( getdvarint( @"hash_2fb6b2a16c2792d0", 0 ) != 0 )
            {
                thread function_97100188ddfca70a( 45, 325, &function_77f58809e548a0be, &trophy_passthrough, 1 );
            }
        #/
        
        thread function_97100188ddfca70a( 45, 325, &function_77f58809e548a0be, &function_3db5573072e32ef6, 0 );
    }
    else
    {
        thread trophy_watchprotection( 45, 325, &function_77f58809e548a0be, &function_3db5573072e32ef6, [ &trophy_checkignorelist ] );
    }
    
    thread trophy_watchtimeoutorgameended();
    thread equipment_interact::remoteinteractsetup( &trophy_remote_destroy, 1, 1 );
    thread perk_equipmentping::runequipmentping();
    challenges::function_4fd386d590e901d8( self, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_trophy", #fieldupgradeent:self, #fieldupgradeowner:self.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
    
    /#
        if ( getdvarint( @"scr_trophy_system_draw_debug", 0 ) )
        {
            function_f453d73a546e6575();
        }
    #/
}

// Namespace trophy_system
// Params 1
// Checksum 0x67714a9f, Offset: 0x1e3e
// Size: 0xdf, Type: bool
function trophy_reclaim( super )
{
    superowner = super.owner;
    superowner supers_mp::function_8cb3b4861e05f17( super.superref, super.ammo, super.timeremaining );
    superowner br_pickups::forcegivesuper( "super_trophy", 1, 0, 0, 0 );
    super supers_mp::function_e2c263f3ee5d2d92( super.damagetaken, level.trophy.timeout, super.ammo );
    level thread common_item::function_e8dfe5e68a7a03b4( superowner, supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" ) );
    superowner thread supers_mp::function_5c28588f733c7388( super.timeremaining, level.trophy.timeout );
    super thread trophy_delete( 0.1, 0 );
    return true;
}

// Namespace trophy_system
// Params 0
// Checksum 0xaddb053d, Offset: 0x1f26
// Size: 0x35
function trophy_deployanimation()
{
    self endon( #"death" );
    self setscriptablepartstate( "effects", "activeDeployStart" );
    wait trophy_getdeployanimtime();
    self setscriptablepartstate( "effects", "activeDeployEnd" );
}

// Namespace trophy_system
// Params 1
// Checksum 0x5f76696, Offset: 0x1f63
// Size: 0x15
function trophy_remote_destroy( player )
{
    trophy_destroy( 1 );
}

// Namespace trophy_system
// Params 0
// Checksum 0x9a7815f9, Offset: 0x1f80
// Size: 0x1b
function sweeptrophy()
{
    thread trophy_delete( 0 );
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
}

// Namespace trophy_system
// Params 1
// Checksum 0xd5918240, Offset: 0x1fa3
// Size: 0x2b
function trophy_destroy( wasdestroyed )
{
    thread trophy_delete( 0.1, wasdestroyed );
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x7b9a6deb, Offset: 0x1fd6
// Size: 0x68
function trophy_shutdownanddestroy( wasdestroyed )
{
    level endon( #"game_ended" );
    
    if ( wasdestroyed )
    {
        thread trophy_delete( 2.6, wasdestroyed );
        self setscriptablepartstate( "effects", "activeDestroyStart", 0 );
        wait 2.5;
        
        if ( self )
        {
            self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
        }
        
        return;
    }
    
    thread trophy_delete( 0.1, wasdestroyed );
}

// Namespace trophy_system
// Params 2
// Checksum 0x93b11466, Offset: 0x2046
// Size: 0x18e
function trophy_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "hack_usable", "off" );
    self.owner challenges::function_a0936b0e5b4550f3( "super_trophy", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    
    if ( weapon::function_89d2d0588f2def25() )
    {
        weapon::deregistermine();
    }
    
    self setcandamage( 0 );
    
    if ( !self.issuper )
    {
        weapons::makeexplosiveunusuabletag();
    }
    else
    {
        self makeunusable();
    }
    
    function_7390a3d68debbc2f();
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    
    if ( wasdestroyed )
    {
        self.exploding = 1;
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"trophy_update", 0 );
        self.owner weapons::removeequip( self );
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    level thread function_5e7d5f8dc4d07454();
}

// Namespace trophy_system
// Params 1
// Checksum 0x70f4ae6e, Offset: 0x21dc
// Size: 0x80
function trophy_checkignorelistfuncs( checkignorelistfuncs )
{
    foreach ( checkignorelistfunc in checkignorelistfuncs )
    {
        if ( [[ checkignorelistfunc ]]( self ) )
        {
            return 1;
        }
    }
}

// Namespace trophy_system
// Params 5
// Checksum 0xcae106f4, Offset: 0x2264
// Size: 0x290
function trophy_watchprotection_loop( trophy_castcontents, castorigin, protectiondistsqr, var_b464e409f2bae785, checkignorelistfuncs )
{
    function_7f0b1d6a1474fddc();
    
    foreach ( targetarray in level.trophysystempartition utility::function_92fef8fe5211a388( self.origin ) )
    {
        foreach ( trophytarget in targetarray )
        {
            if ( !isdefined( trophytarget ) )
            {
                continue;
            }
            
            if ( trophytarget.exploding || trophytarget.destroyed )
            {
                continue;
            }
            
            if ( trophytarget == self )
            {
                continue;
            }
            
            if ( self.bundle.var_b977429841d8a2e3 )
            {
                if ( !trophytarget.var_b62d290bca467227 )
                {
                    continue;
                }
            }
            
            if ( trophytarget trophy_checkignorelistfuncs( checkignorelistfuncs ) )
            {
                continue;
            }
            
            if ( trophytarget.var_be6e8f5c5d18acc )
            {
                continue;
            }
            
            if ( trophytarget.var_2805eec786427e6a )
            {
                continue;
            }
            
            trophytargetowner = trophytarget.owner;
            
            if ( !isdefined( trophytargetowner ) && isdefined( trophytarget.vehicle ) )
            {
                trophytargetowner = trophytarget.vehicle.owner;
            }
            
            if ( !isdefined( trophytargetowner ) && isvalidmissile( trophytarget ) )
            {
                trophytargetowner = getmissileowner( trophytarget );
            }
            
            var_7abb8ea921e296dc = 1;
            
            /#
                if ( getdvarint( @"hash_3c6c485214ca7673", 0 ) == 1 )
                {
                    var_7abb8ea921e296dc = 0;
                }
            #/
            
            if ( var_7abb8ea921e296dc )
            {
                if ( isdefined( trophytargetowner ) && !player_utility::playersareenemies( self.owner, trophytargetowner ) )
                {
                    continue;
                }
            }
            
            if ( distancesquared( trophytarget.origin, self.origin ) > trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr ) )
            {
                continue;
            }
            
            if ( function_ffacc9c4c14e5f52( trophy_castcontents, castorigin, trophytarget ) )
            {
                continue;
            }
            
            self [[ var_b464e409f2bae785 ]]( trophytarget );
        }
    }
}

// Namespace trophy_system
// Params 3, eflags: 0x4
// Checksum 0x4a8a0ff8, Offset: 0x24fc
// Size: 0x125, Type: bool
function private function_ffacc9c4c14e5f52( trophy_castcontents, castorigin, trophytarget )
{
    var_356192d436f24583 = [ self, trophytarget ];
    
    if ( trophytarget.var_14f08f0fbff8e052 )
    {
        var_356192d436f24583 = arraycombine( var_356192d436f24583, trophytarget.var_14f08f0fbff8e052 );
    }
    
    castresults = physics_raycast( castorigin, trophytarget.origin, trophy_castcontents, var_356192d436f24583, 0, "physicsquery_closest" );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        ref = trophytarget.equipmentref ?? trophytarget.streakname;
        var_6350cc14c338e310 = [ "equip_grappling_hook":20 ];
        penetrationdistance = var_6350cc14c338e310[ ref ] ?? 0;
        
        if ( penetrationdistance == 0 )
        {
            return true;
        }
        
        var_c699dbe9fc1d88e9 = distance( castorigin, castresults[ 0 ][ "position" ] );
        distancetotarget = distance( castorigin, trophytarget.origin );
        
        if ( distancetotarget > var_c699dbe9fc1d88e9 + penetrationdistance )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace trophy_system
// Params 5
// Checksum 0x764f0df0, Offset: 0x262a
// Size: 0x1bc
function trophy_watchprotection( protectionoffset, var_2937a2ad657d88ac, var_2049c089ca33e54c, var_b464e409f2bae785, checkignorelistfuncs )
{
    self endon( #"death" );
    trophy_castcontents = trophy_castcontents();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" ) ?? level.equipment.table[ "equip_trophy" ].bundle;
    
    while ( [[ var_2049c089ca33e54c ]]() )
    {
        if ( self.isdisabled || self.isjammed || self.chaffstunned )
        {
            waitframe();
            continue;
        }
        
        castorigin = trophy_castorigin( protectionoffset );
        protectiondist = var_2937a2ad657d88ac;
        
        if ( isdefined( self.var_30656af96b2ac2a4 ) )
        {
            distancebuff = 0;
            
            foreach ( var_84f71a335ec4f6bf in self.var_30656af96b2ac2a4 )
            {
                if ( var_84f71a335ec4f6bf.rangebuff )
                {
                    distancebuff = max( distancebuff, var_84f71a335ec4f6bf.rangebuff );
                }
            }
            
            protectiondist += distancebuff;
        }
        
        protectiondistsqr = protectiondist * protectiondist;
        
        if ( bundle.var_33a345a7a70a5c31 )
        {
            thread function_71c31dd9b02af046( protectiondist );
        }
        
        trophy_watchprotection_loop( trophy_castcontents, castorigin, protectiondistsqr, var_b464e409f2bae785, checkignorelistfuncs );
        waitframe();
    }
}

/#

    // Namespace trophy_system
    // Params 2
    // Checksum 0x6f3f570d, Offset: 0x27ee
    // Size: 0x107, Type: dev
    function function_46dbaf53b23be162( ents, partitionents )
    {
        println( "<dev string:x10f>" );
        
        foreach ( entnum, e in ents )
        {
            println( entnum );
        }
        
        println( "<dev string:x11a>" );
        
        foreach ( entnum, e in partitionents )
        {
            println( entnum );
        }
        
        assertmsg( "<dev string:x12a>" );
    }

    // Namespace trophy_system
    // Params 1
    // Checksum 0xe19cc74, Offset: 0x28fd
    // Size: 0x1b0, Type: dev
    function function_1b7962f19ea33a54( ents )
    {
        partitionents = [];
        function_7f0b1d6a1474fddc();
        
        foreach ( targetarray in level.trophysystempartition utility::function_92fef8fe5211a388( self.origin ) )
        {
            foreach ( trophytarget in targetarray )
            {
                partitionents[ trophytarget getentitynumber() ] = trophytarget;
            }
        }
        
        if ( ents.size != partitionents.size )
        {
            function_46dbaf53b23be162( ents, partitionents );
        }
        
        foreach ( e in ents )
        {
            entnum = e getentitynumber();
            
            if ( !isdefined( partitionents[ entnum ] ) )
            {
                function_46dbaf53b23be162( ents, partitionents );
            }
        }
    }

    // Namespace trophy_system
    // Params 1
    // Checksum 0x1b496ae4, Offset: 0x2ab5
    // Size: 0x22, Type: dev
    function function_b3001e09b8d7c2f4( trophytarget )
    {
        level.var_723a5bd2b72f9a11[ trophytarget getentitynumber() ] = 1;
    }

    // Namespace trophy_system
    // Params 4
    // Checksum 0xdc4ba61f, Offset: 0x2adf
    // Size: 0xf3, Type: dev
    function function_3fc4af3c357c7dc1( ents, trophy_castcontents, castorigin, protectiondistsqr )
    {
        level.var_723a5bd2b72f9a11 = [];
        trophy_watchprotection_loop( trophy_castcontents, castorigin, protectiondistsqr, &function_b3001e09b8d7c2f4 );
        
        if ( ents.size != level.var_723a5bd2b72f9a11.size )
        {
            function_46dbaf53b23be162( ents, level.var_723a5bd2b72f9a11 );
        }
        
        foreach ( entnum, e in ents )
        {
            if ( !isdefined( level.var_723a5bd2b72f9a11[ entnum ] ) )
            {
                function_46dbaf53b23be162( ents, level.var_723a5bd2b72f9a11 );
            }
        }
    }

#/

// Namespace trophy_system
// Params 5
// Checksum 0x43cfbefa, Offset: 0x2bda
// Size: 0x39a
function function_97100188ddfca70a( protectionoffset, protectiondist, var_2049c089ca33e54c, var_b464e409f2bae785, gridvalidation )
{
    self endon( #"death" );
    trophy_castcontents = trophy_castcontents();
    typemask = createentitytypemask( [ "etype_missile", "etype_vehicle" ] );
    
    if ( isdefined( self.var_30656af96b2ac2a4 ) )
    {
        distancebuff = 0;
        
        foreach ( var_84f71a335ec4f6bf in self.var_30656af96b2ac2a4 )
        {
            if ( var_84f71a335ec4f6bf.rangebuff )
            {
                distancebuff = max( distancebuff, var_84f71a335ec4f6bf.rangebuff );
            }
        }
        
        protectiondist += distancebuff;
    }
    
    protectiondistsqr = protectiondist * protectiondist;
    
    /#
        validationents = [];
    #/
    
    while ( [[ var_2049c089ca33e54c ]]() )
    {
        if ( self.isdisabled || self.isjammed )
        {
            waitframe();
            continue;
        }
        
        /#
            if ( gridvalidation )
            {
                validationents = [];
            }
        #/
        
        castorigin = trophy_castorigin( protectionoffset );
        ents = getentitiesinradiusfrompartitiongrid( self.origin, 500, typemask, [ self ] );
        
        foreach ( trophytarget in ents )
        {
            if ( !isdefined( trophytarget ) )
            {
                continue;
            }
            
            if ( trophytarget.exploding )
            {
                continue;
            }
            
            if ( trophy_checkignorelist( trophytarget ) )
            {
                continue;
            }
            
            trophytargetowner = trophytarget.owner;
            
            if ( !isdefined( trophytargetowner ) && isdefined( trophytarget.vehicle ) )
            {
                trophytargetowner = trophytarget.vehicle.owner;
            }
            
            if ( !isdefined( trophytargetowner ) && isvalidmissile( trophytarget ) )
            {
                trophytargetowner = getmissileowner( trophytarget );
            }
            
            var_7abb8ea921e296dc = 1;
            
            /#
                if ( getdvarint( @"hash_3c6c485214ca7673", 0 ) == 1 )
                {
                    var_7abb8ea921e296dc = 0;
                }
            #/
            
            if ( var_7abb8ea921e296dc )
            {
                if ( isdefined( trophytargetowner ) && !player_utility::playersareenemies( self.owner, trophytargetowner ) )
                {
                    continue;
                }
            }
            
            if ( distancesquared( trophytarget.origin, self.origin ) > trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr ) )
            {
                continue;
            }
            
            var_356192d436f24583 = [ self, trophytarget ];
            
            if ( trophytarget.var_14f08f0fbff8e052 )
            {
                var_356192d436f24583 = arraycombine( var_356192d436f24583, trophytarget.var_14f08f0fbff8e052 );
            }
            
            castresults = physics_raycast( castorigin, trophytarget.origin, trophy_castcontents, var_356192d436f24583, 0, "physicsquery_closest" );
            
            if ( isdefined( castresults ) && castresults.size > 0 )
            {
                continue;
            }
            
            /#
                if ( gridvalidation )
                {
                    validationents[ trophytarget getentitynumber() ] = 1;
                }
            #/
            
            self [[ var_b464e409f2bae785 ]]( trophytarget );
        }
        
        /#
            if ( gridvalidation )
            {
                function_3fc4af3c357c7dc1( validationents, trophy_castcontents, castorigin, protectiondistsqr );
            }
        #/
        
        waitframe();
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0x2d16433d, Offset: 0x2f7c
// Size: 0xc, Type: bool
function function_77f58809e548a0be()
{
    return isdefined( self.owner );
}

// Namespace trophy_system
// Params 1
// Checksum 0x96d59453, Offset: 0x2f91
// Size: 0x15
function function_3db5573072e32ef6( trophytarget )
{
    thread trophy_fireontarget( trophytarget );
}

// Namespace trophy_system
// Params 1, eflags: 0x4
// Checksum 0x236934e8, Offset: 0x2fae
// Size: 0x5f
function private function_2307e0849e493c48( trophytarget )
{
    outnum = 1;
    
    if ( !isdefined( trophytarget ) )
    {
        return outnum;
    }
    
    if ( !isdefined( trophytarget.weapon_name ) )
    {
        return outnum;
    }
    
    switch ( trophytarget.weapon_name )
    {
        case #"hash_5c272c0617caebf0":
            outnum = 3;
            break;
    }
    
    return outnum;
}

// Namespace trophy_system
// Params 1, eflags: 0x4
// Checksum 0x7f358c2b, Offset: 0x3016
// Size: 0x31e
function private trophy_fireontarget( trophytarget )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_end" );
    self.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weapon_object, 1, "hits" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
    {
        if ( isdefined( self.owner.leaderboarddata[ "trophySystemHits" ] ) )
        {
            self.owner.leaderboarddata[ "trophySystemHits" ] = self.owner.leaderboarddata[ "trophySystemHits" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "trophySystemHits" ] ) )
        {
            [[ level.leaderboardfunc[ "trophySystemHits" ] ]]( self.owner, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x161>" );
        
        if ( isdefined( self.owner.pers[ "trophySystemHits" ] ) )
        {
            self.owner.pers[ "trophySystemHits" ] = self.owner.pers[ "trophySystemHits" ] + 1;
        }
    }
    
    if ( !self.bundle.trophy_is_equipment )
    {
        self.owner supers_mp::combatrecordsupermisc( "super_trophy" );
    }
    
    self.usedcount++;
    trophytarget.var_be6e8f5c5d18acc = 1;
    
    /#
        if ( false )
        {
            function_e88a1fe9d0a3d31b( trophytarget );
        }
    #/
    
    var_db7c1d0a31bd8f51 = trophytarget.origin;
    var_1e76d81fef2570ba = trophy_modifiedprotectiondistsqr( trophytarget, 105625 );
    numshots = function_2307e0849e493c48( trophytarget );
    var_e4261a6c15f9c8e3 = 0.2;
    
    if ( isdefined( self.var_30656af96b2ac2a4 ) )
    {
        foreach ( var_84f71a335ec4f6bf in self.var_30656af96b2ac2a4 )
        {
            var_e4261a6c15f9c8e3 = max( 0, min( var_e4261a6c15f9c8e3, 0.2 - var_84f71a335ec4f6bf.var_8e69ad7d717da8df ) );
        }
    }
    
    if ( self.ammo >= numshots )
    {
        function_3ef7d9b33d884442( trophytarget );
        self.owner killstreaks::givescorefortrophyblocks( self.weapon_object );
        self setscriptablepartstate( "target_destroyed", "on", 0 );
    }
    
    for ( i = 0; i < numshots ; i++ )
    {
        childthread function_1b1128fd01282c79( var_db7c1d0a31bd8f51, i, var_1e76d81fef2570ba );
        wait var_e4261a6c15f9c8e3;
    }
}

// Namespace trophy_system
// Params 3, eflags: 0x4
// Checksum 0x476f6345, Offset: 0x333c
// Size: 0x221
function private function_1b1128fd01282c79( trophytargetpos, shotnum, rangesquared )
{
    if ( self.ammo <= 0 )
    {
        thread trophy_shutdownanddestroy( 0 );
        return 0;
    }
    
    self notify( #"trophy_fire_at_projectile" );
    explorigin = trophytargetpos;
    var_aff3119a20f47d62 = function_b2dbf740fe70732b( explorigin, rangesquared );
    
    if ( var_aff3119a20f47d62 )
    {
        explorigin = function_8ce4b05784bb6460( explorigin );
    }
    
    if ( shotnum > 1 )
    {
        explorigin = function_bb1db0d2858dce73( explorigin );
    }
    
    barrel = function_a784f69ae13819e5( explorigin );
    tag = barrel.tag;
    part = barrel.part;
    self setscriptablepartstate( part, "active", 0 );
    dirangles = vectortoangles( self gettagorigin( tag ) - explorigin );
    explangles = combineangles( dirangles, ( -90, 0, 0 ) );
    self.explosion thread trophy_explode( explorigin, explangles );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" ) ?? level.equipment.table[ "equip_trophy" ].bundle;
    var_216a6c482fe3f15f = bundle.var_3f8a866a1caccbfc ?? 0;
    
    if ( var_216a6c482fe3f15f )
    {
        var_21fc014c6bbe1035 = self gettagorigin( barrel.tag );
        function_7ded61d36dae00a6( var_21fc014c6bbe1035, trophytargetpos );
    }
    
    self setscriptablepartstate( "sfx_" + part, "fire", 0 );
    self.ammo--;
    self notify( #"trophy_ammo_used" );
    
    /#
        if ( getdvarint( @"hash_20d714b15057681f", 0 ) == 1 )
        {
            self.ammo = bundle.trophy_max_ammo;
        }
    #/
    
    if ( self.ammo <= 0 )
    {
        self.owner thread equipment_utility::function_364a1a0e0c018518( self.superref, #"expended" );
        thread trophy_shutdownanddestroy( 1 );
    }
}

// Namespace trophy_system
// Params 2, eflags: 0x4
// Checksum 0xa8d223f1, Offset: 0x3565
// Size: 0x27, Type: bool
function private function_b2dbf740fe70732b( inpoint, rangesquared )
{
    return distancesquared( inpoint, self.origin ) < rangesquared;
}

// Namespace trophy_system
// Params 1, eflags: 0x4
// Checksum 0xaf5165e5, Offset: 0x3595
// Size: 0x54
function private function_8ce4b05784bb6460( explorigin )
{
    var_2e25342648fa0c16 = explorigin;
    lerpfraction = min( 1 - 24 / length( self.origin - explorigin ), 1 );
    var_2e25342648fa0c16 = vectorlerp( self.origin, var_2e25342648fa0c16, lerpfraction );
    return var_2e25342648fa0c16;
}

// Namespace trophy_system
// Params 1, eflags: 0x4
// Checksum 0xb60bc2e5, Offset: 0x35f2
// Size: 0x105
function private function_bb1db0d2858dce73( var_dfe0e3d330e71d26 )
{
    var_bf8625ead07389c4 = 0.05;
    x_scatter = randomfloatrange( 0.9, 1.1 );
    y_scatter = randomfloatrange( 0.9, 1.1 );
    z_scatter = randomfloatrange( 0.8, 1.2 );
    x = var_dfe0e3d330e71d26[ 0 ];
    y = var_dfe0e3d330e71d26[ 1 ];
    z = var_dfe0e3d330e71d26[ 2 ];
    x_delta = x * x_scatter;
    y_delta = y * y_scatter;
    z_delta = z * z_scatter;
    
    if ( abs( x - x_delta ) < x * var_bf8625ead07389c4 )
    {
        x_delta += x_delta * var_bf8625ead07389c4;
    }
    
    if ( abs( y - y_delta ) < y * var_bf8625ead07389c4 )
    {
        y_delta += y_delta * var_bf8625ead07389c4;
    }
    
    if ( abs( z - z_delta ) < z * var_bf8625ead07389c4 )
    {
        z_delta += z_delta * var_bf8625ead07389c4;
    }
    
    return ( x_delta, y_delta, z_delta );
}

// Namespace trophy_system
// Params 1
// Checksum 0x247bad98, Offset: 0x3700
// Size: 0x2da
function function_3ef7d9b33d884442( trophytarget )
{
    trophytarget setcandamage( 0 );
    trophytarget stopsounds();
    
    if ( !isdefined( self.objectsdestroyed ) )
    {
        self.objectsdestroyed = 1;
    }
    else
    {
        self.objectsdestroyed += 1;
    }
    
    if ( self.objectsdestroyed == self.bundle.trophy_max_ammo )
    {
        self.owner thread points::doscoreevent( #"trophy_multi_intercept", self.weapon_object );
    }
    
    self.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weapon_object, 1, "equipment_destructions" );
    self.owner telemetry_mp::function_36100e50dccb52fa( self.owner, self getentitynumber(), self.weapon_object );
    
    if ( isdefined( trophytarget.owner ) )
    {
        trophytarget.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weapon_object, 1, "equipment_destroyed_by" );
    }
    
    trophy_notifytrophytargetowner( trophytarget, "trophy_mp", self.owner );
    trophy_tryreflectsnapshot( trophytarget, trophytarget.owner, self.owner );
    
    if ( isdefined( self.owner ) && isdefined( self.owner.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
    {
        self.owner [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( trophytarget );
    }
    
    if ( isdefined( trophytarget.equipmentref ) && isdefined( trophytarget.owner ) && isdefined( trophytarget.bundle ) && utility::function_edc4cc03e9e60b3e( hashcat( @"hash_52c8f6bfe7848652", trophytarget.equipmentref ), 0, trophytarget.bundle.trophy_system_should_refund ) )
    {
        trophytarget.owner equipment_mp::incrementequipmentammo( trophytarget.equipmentref, 1 );
    }
    
    challengeparams = { #modifiers:[], #hitloc:"", #objweapon:self.weapon_object, #meansofdeath:"MOD_EXPLOSION", #damageflags:undefined, #damage:trophytarget.maxhealth, #attacker:self.owner, #inflictor:self, #victim:trophytarget };
    callback::callback( #"equipment_destroyed", challengeparams );
    
    if ( !trophytarget equipment_mp::ondestroyedbytrophy() )
    {
        trophytarget delete();
    }
}

// Namespace trophy_system
// Params 3
// Checksum 0x46e12c27, Offset: 0x39e2
// Size: 0xb4
function trophy_tryreflectsnapshot( trophytarget, victim, attacker )
{
    if ( trophytarget.equipmentref != "equip_snapshot_grenade" )
    {
        return;
    }
    
    if ( !( isdefined( trophytarget.owner ) && isdefined( self.owner ) ) )
    {
        return;
    }
    
    if ( !player::isreallyalive( victim ) )
    {
        return;
    }
    
    owner = attacker;
    position = victim.origin;
    outlinedata = snapshot_grenade::snapshot_grenade_createoutlinedata( owner, position, self.bundle );
    snapshot_grenade::snapshot_grenade_applysnapshot( victim, attacker, outlinedata, undefined, undefined, undefined, self.bundle );
}

// Namespace trophy_system
// Params 0
// Checksum 0x640c3529, Offset: 0x3a9e
// Size: 0x6c
function trophy_watchtimeoutorgameended()
{
    self notify( #"hash_9a691290ac91bec8" );
    self endon( #"hash_9a691290ac91bec8" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.trophy.timeout ) )
    {
        hostmigration::waitlongdurationwithhostmigrationpause( level.trophy.timeout );
        thread trophy_shutdownanddestroy( 1 );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0xe8db9bb5, Offset: 0x3b12
// Size: 0x12b, Type: bool
function function_438066356dbc7099( objweapon )
{
    function_7f0b1d6a1474fddc();
    
    foreach ( targetarray in level.trophysystempartition utility::function_92fef8fe5211a388( self.origin ) )
    {
        foreach ( trophytarget in targetarray )
        {
            if ( isdefined( trophytarget ) && trophytarget.weapon_name == objweapon.basename && !trophy_checkignorelist( trophytarget ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace trophy_system
// Params 1
// Checksum 0xce93d59c, Offset: 0x3c46
// Size: 0xe1
function trophy_handledamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    
    if ( function_438066356dbc7099( objweapon ) )
    {
        frameduration = getframeduration();
        msg = utility::waittill_notify_or_timeout_return( "trophy_fire_at_projectile", frameduration * 0.001 );
        
        if ( msg == "trophy_fire_at_projectile" )
        {
            return 0;
        }
    }
    
    weapons::equipmenthit( self.owner, attacker, objweapon, type );
    return modifieddamage;
}

// Namespace trophy_system
// Params 1
// Checksum 0x614845e2, Offset: 0x3d30
// Size: 0x5f
function trophy_handlefataldamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    data.victim trophy_givepointsfordeath( data.attacker, data.objweapon );
    data.victim thread trophy_destroy( 1 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x2757a147, Offset: 0x3d97
// Size: 0x6c
function trophy_applyempcallback( data )
{
    if ( data.victim.bundle.var_51e0547e6fe8c62f )
    {
        data.victim trophy_disable();
        return;
    }
    
    self notify( #"enemy_destroyed_equipment", data.attacker );
    data.victim thread trophy_destroy( 1 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x2f7867ce, Offset: 0x3e0b
// Size: 0x28
function function_ffeb4e5ec30224ca( data )
{
    self.chaffstunned = 1;
    self setscriptablepartstate( "empd", "active", 0 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x8f5a287e, Offset: 0x3e3b
// Size: 0x34
function function_14e06af96236e673( data )
{
    self.chaffstunned = 0;
    
    if ( !self.isdisabled )
    {
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x5b5f80bd, Offset: 0x3e77
// Size: 0x3d
function function_96c5799246de8829( data )
{
    data.victim trophy_givepointsfordeath( data.attacker );
    data.victim thread trophy_destroy( 1 );
}

// Namespace trophy_system
// Params 1
// Checksum 0xa363ff9e, Offset: 0x3ebc
// Size: 0x5b
function trophy_disable( data )
{
    self endon( #"death" );
    self.isdisabled = 1;
    self setscriptablepartstate( #"empd", #"active", 0 );
    
    if ( !isdefined( data.ksemp ) )
    {
        wait 6;
        trophy_enable( data );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0xd69e64ea, Offset: 0x3f1f
// Size: 0x3b
function trophy_enable( data )
{
    self endon( #"death" );
    self.isdisabled = 0;
    self setscriptablepartstate( #"empd", #"neutral", 0 );
}

// Namespace trophy_system
// Params 0
// Checksum 0xc973f67e, Offset: 0x3f62
// Size: 0x32
function trophy_pickup()
{
    if ( self.owner equipment_mp::hasequipment( "equip_trophy" ) )
    {
        self.owner trophy_addstored( self.ammo );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x473ed043, Offset: 0x3f9c
// Size: 0x15e
function trophy_createexplosion( trophy )
{
    explosion = spawn( "script_model", trophy.origin );
    explosion.killcament = trophy;
    explosion.owner = trophy.owner;
    explosion.team = trophy.team;
    explosion.equipmentref = trophy.equipmentref;
    explosion.weapon_name = trophy.weapon_name;
    explosion setotherent( explosion.owner );
    explosion setentityowner( explosion.owner );
    blueprintindex = trophy.weapon_object.variantid;
    
    if ( isdefined( blueprintindex ) )
    {
        genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( trophy.bundle, blueprintindex );
        var_a9017aff9f5c1eec = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"hash_13239327fd97153e" );
    }
    
    explosion setmodel( var_a9017aff9f5c1eec ?? level.trophy.explosionxmodel );
    explosion.explode1available = 1;
    explosion thread trophy_cleanuponparentdeath( trophy, 0.1 );
    return explosion;
}

// Namespace trophy_system
// Params 2
// Checksum 0x1e4a93c8, Offset: 0x4103
// Size: 0x8f
function trophy_explode( position, angles )
{
    self dontinterpolate();
    self.origin = position;
    self.angles = angles;
    
    if ( self isscriptable() )
    {
        if ( self.explode1available )
        {
            self setscriptablepartstate( #"explode1", #"activedirectional", 0 );
            self.explode1available = 0;
            return;
        }
        
        self setscriptablepartstate( #"explode2", #"activedirectional", 0 );
        self.explode1available = 1;
    }
}

// Namespace trophy_system
// Params 2, eflags: 0x4
// Checksum 0x5df0b87d, Offset: 0x419a
// Size: 0x4f
function private function_7ded61d36dae00a6( originpos, targetpos )
{
    if ( !level._effect[ "trophy_laser_beam" ] )
    {
        return;
    }
    
    self.laserpulse = function_f5f8abcd7522eee2( level._effect[ "trophy_laser_beam" ], originpos, targetpos );
    thread function_8ecffa5725ed1348();
}

// Namespace trophy_system
// Params 0, eflags: 0x4
// Checksum 0xc4b5fed, Offset: 0x41f1
// Size: 0x6e
function private function_8ecffa5725ed1348()
{
    laserpulse = self.laserpulse;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    visibilitytime = bundle.var_c4d2895b97a5048b;
    var_bf9ff5ffc3a07847 = visibilitytime ?? 0.25;
    wait var_bf9ff5ffc3a07847;
    laserpulse delete();
    
    if ( isdefined( self ) )
    {
        self.laserpulse = undefined;
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x767dd702, Offset: 0x4267
// Size: 0x26
function trophy_castorigin( protectionoffset )
{
    return self.origin + anglestoup( self.angles ) * protectionoffset;
}

// Namespace trophy_system
// Params 0
// Checksum 0x4868ebe1, Offset: 0x4296
// Size: 0x34
function trophy_castcontents()
{
    return physics_createcontents( [ "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item" ] );
}

// Namespace trophy_system
// Params 2
// Checksum 0xa80c972e, Offset: 0x42d3
// Size: 0xe4
function trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr )
{
    if ( !isdefined( trophytarget ) )
    {
        return protectiondistsqr;
    }
    
    if ( isdefined( trophytarget.weapon_name ) )
    {
        switch ( trophytarget.weapon_name )
        {
            case #"hash_c500a77b6bb7c5d0":
                if ( 126750 > protectiondistsqr )
                {
                    protectiondistsqr = 126750;
                }
                
                break;
            case #"hash_aff3ca5fba796fbe":
                protectiondistsqr = max( protectiondistsqr, 237656 );
                break;
        }
    }
    
    if ( isdefined( trophytarget.classname ) )
    {
        switch ( trophytarget.classname )
        {
            case #"hash_4af55147c6098215":
                if ( 211250 > protectiondistsqr )
                {
                    protectiondistsqr = 211250;
                }
                
                break;
            case #"hash_8b48887639da2db5":
                if ( 126750 > protectiondistsqr )
                {
                    protectiondistsqr = 126750;
                }
                
                break;
        }
    }
    
    return protectiondistsqr;
}

// Namespace trophy_system
// Params 1
// Checksum 0x52d5b74a, Offset: 0x43c0
// Size: 0x310, Type: bool
function trophy_checkignorelist( trophytarget )
{
    if ( trophytarget.var_b50582a8004f118e )
    {
        return false;
    }
    
    if ( trophytarget.trophy_system_should_ignore )
    {
        return true;
    }
    
    bundle = trophytarget.bundle;
    
    if ( isdefined( bundle ) && bundle.trophy_system_should_ignore )
    {
        return true;
    }
    
    if ( isdefined( trophytarget.streakname ) )
    {
        streakbundle = level.streakglobals.streakbundles[ trophytarget.streakname ];
        
        if ( isdefined( streakbundle ) && streakbundle.trophy_system_should_ignore )
        {
            return true;
        }
    }
    
    if ( isdefined( trophytarget.superref ) )
    {
        superdata = level.superglobals.staticsuperdata[ trophytarget.superref ];
        
        if ( isdefined( superdata ) && isdefined( superdata.bundle ) && superdata.bundle.trophy_system_should_ignore )
        {
            return true;
        }
    }
    
    weaponname = trophytarget.weapon_name;
    
    if ( !isdefined( weaponname ) )
    {
        weapon_object = trophytarget.weapon_object;
        
        if ( isdefined( weapon_object ) )
        {
            weaponname = weapon_object.basename;
        }
    }
    
    if ( isdefined( trophytarget.streakname ) )
    {
        switch ( trophytarget.streakname )
        {
            case #"hash_6362d6aae3e5a62e":
            case #"hash_7a687f6a4d685110":
                return true;
        }
    }
    else if ( isdefined( trophytarget.streakinfo ) )
    {
        switch ( trophytarget.streakinfo.streakname )
        {
            case #"hash_9e36e3bd3a9dd00d":
                return true;
        }
    }
    
    if ( isdefined( weaponname ) )
    {
        if ( trophytarget.weapon_object.underbarrel == weaponname )
        {
            weaponname = trophytarget.weapon_object.basename;
        }
        
        if ( !utility::is_valid_weapon_name( weaponname ) )
        {
            return true;
        }
        
        if ( weapon::function_33e74163843b348e( weaponname ) )
        {
            return true;
        }
        
        if ( weaponname == "sat_la_polis_mp" )
        {
            return true;
        }
        
        weapon_object = trophytarget.weapon_object;
        
        if ( isdefined( weapon_object ) && weapon::iswonderweapon( weapon_object ) )
        {
            return true;
        }
        
        ignorelist = level.trophy.ignorelist;
        
        foreach ( weaponstruct in ignorelist )
        {
            if ( weaponstruct.var_21ed91b0e05adbf0 == weaponname )
            {
                return true;
            }
        }
    }
    
    if ( trophytarget vehicle::is_vehicle() && !trophytarget.isprojectilekillstreak )
    {
        return true;
    }
    
    return false;
}

// Namespace trophy_system
// Params 3
// Checksum 0xa8627a63, Offset: 0x46d9
// Size: 0xfb
function trophy_notifytrophytargetowner( trophytarget, trophyweaponname, trophyowner )
{
    if ( !isplayer( trophytarget.owner ) )
    {
        return;
    }
    
    if ( damagefeedback::isusingstackablehitmarker() )
    {
        trophytarget.owner damagefeedback::updatedamagefeedback( "hittrophysystem", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
    }
    else
    {
        trophytarget.owner damagefeedback::updatedamagefeedback( "hittrophysystem" );
    }
    
    if ( isdefined( trophytarget.weapon_name ) )
    {
        switch ( trophytarget.weapon_name )
        {
            case #"hash_5b1e7be1304d43db":
            case #"hash_94c7880dca9ccc3f":
            case #"hash_b23a0686850cd666":
                trophytarget.owner notify( #"hash_e48f56f6b662855f", trophyowner, trophyweaponname, trophytarget.weapon_name, trophytarget.origin, trophytarget.angles );
                break;
        }
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0xfdebdee6, Offset: 0x47dc
// Size: 0x13d
function function_a784f69ae13819e5( position )
{
    barrel_pairs = level.trophy.barrel_pairs;
    bestdot = undefined;
    bestbarrel = undefined;
    
    foreach ( id, barrel in barrel_pairs )
    {
        tag = barrel.tag;
        
        if ( self tagexists( tag ) )
        {
            origin = self gettagorigin( tag );
            angles = self gettagangles( tag );
            forward = anglestoforward( angles );
            dot = vectordot( vectornormalize( position - origin ), forward );
            
            if ( id == 0 || dot > bestdot )
            {
                bestdot = dot;
                bestbarrel = barrel;
            }
            
            continue;
        }
        
        assertmsg( "<dev string:x187>" + tag );
    }
    
    return bestbarrel;
}

// Namespace trophy_system
// Params 2
// Checksum 0xd7b3869c, Offset: 0x4922
// Size: 0x33
function trophy_givepointsfordeath( attacker, weaponobj )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        thread supers_mp::function_579d273895a60bdb( attacker, weaponobj );
    }
}

#using_animtree( "scriptables" );

// Namespace trophy_system
// Params 0
// Checksum 0xb73f16c2, Offset: 0x495d
// Size: 0x58
function trophy_getdeployanimtime()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
    deployanimation = %wm_trophy_system_deploy;
    
    if ( isdefined( bundle.trophy_deploy_anim ) )
    {
        deployanimation = bundle.trophy_deploy_anim.id;
    }
    
    return getanimlength( deployanimation );
}

// Namespace trophy_system
// Params 1
// Checksum 0xcacd1255, Offset: 0x49be
// Size: 0x50
function trophy_givedamagefeedback( attacker )
{
    damagefeedback = "";
    
    if ( self.hasruggedeqp || self.var_736c0b69e68cc5a0 )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0x2e94433e, Offset: 0x4a16
// Size: 0x78
function trophy_addstored( ammo )
{
    if ( !isdefined( self.trophies ) )
    {
        self.trophies = [];
    }
    
    if ( self.trophies.size < trophy_maxstored() )
    {
        if ( !isdefined( ammo ) )
        {
            bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" );
            ammo = bundle.trophy_max_ammo;
        }
        
        self.trophies[ self.trophies.size ] = ammo;
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0x6f5f7ce3, Offset: 0x4a96
// Size: 0x5c
function trophy_removestored()
{
    if ( isdefined( self.trophies ) && self.trophies.size > 0 )
    {
        trophy = self.trophies[ self.trophies.size - 1 ];
        self.trophies[ self.trophies.size - 1 ] = undefined;
        return trophy;
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0xdd143431, Offset: 0x4afb
// Size: 0xc
function trophy_clearstored()
{
    self.trophies = undefined;
}

// Namespace trophy_system
// Params 0
// Checksum 0x8528001f, Offset: 0x4b0f
// Size: 0x38
function trophy_populatestored()
{
    maxcharges = equipment_mp::getequipmentmaxammo( "equip_trophy" );
    
    for ( i = 0; i < maxcharges ; i++ )
    {
        trophy_addstored();
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0x30ce8f8b, Offset: 0x4b4f
// Size: 0xd
function trophy_maxstored()
{
    return equipment_mp::getequipmentmaxammo( "equip_trophy" );
}

// Namespace trophy_system
// Params 1
// Checksum 0x15726dc4, Offset: 0x4b65
// Size: 0x50, Type: bool
function function_537d82fb30953fb1( sweapon )
{
    if ( !isdefined( sweapon ) )
    {
        return false;
    }
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        switch ( sweapon )
        {
            case #"hash_5e3fa526a48eaaa5":
            case #"hash_6f08e94ea93bfaf9":
            case #"hash_f085b57dce639767":
                return true;
        }
    }
    
    return false;
}

// Namespace trophy_system
// Params 4
// Checksum 0x22e50938, Offset: 0x4bbe
// Size: 0x8c
function trophy_modifieddamage( attacker, victim, damage, damageadd )
{
    if ( damage == 0 )
    {
        return [ damage, damageadd ];
    }
    
    maxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
    damageclamp = 0.66 * maxhealth;
    modifieddamageadd = damageclamp - damage;
    modifieddamageadd = min( modifieddamageadd, damageadd );
    return [ damage, modifieddamageadd ];
}

// Namespace trophy_system
// Params 2
// Checksum 0xa6639ef8, Offset: 0x4c53
// Size: 0x59
function function_ae2e4e43e22fef2c( bundle, blueprintindex )
{
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    modelname = undefined;
    
    if ( isdefined( genericblueprintname ) )
    {
        modelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"projectilemodel" );
    }
    
    return modelname;
}

// Namespace trophy_system
// Params 2
// Checksum 0xc9d48104, Offset: 0x4cb5
// Size: 0x38
function trophy_cleanuponparentdeath( parent, delay )
{
    self endon( #"death" );
    parent waittill( #"death" );
    wait delay;
    self delete();
}

// Namespace trophy_system
// Params 1
// Checksum 0xe64f3dd6, Offset: 0x4cf5
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace trophy_system
// Params 1
// Checksum 0xf85e0147, Offset: 0x4d14
// Size: 0x5e
function function_2c2206637cf5e977( weaponname )
{
    isignored = undefined;
    
    if ( weapon::iskillstreakweapon( weaponname ) )
    {
        isignored = 1;
        
        switch ( weaponname )
        {
            case #"hash_841e4cad9f0e242e":
            case #"hash_c5c19fe9ae40cd0c":
            case #"hash_f4d2562ef860c1c0":
                isignored = 0;
                break;
        }
    }
    
    return isignored;
}

// Namespace trophy_system
// Params 1
// Checksum 0x8a1812d, Offset: 0x4d7b
// Size: 0x7e
function trophy_onownerchanged( oldowner )
{
    self setscriptablepartstate( #"hacked", #"active", 0 );
    sentientpool = self.sentientpool;
    sentientpoolmanager::unregistersentient( self.sentientpool, self.sentientpoolindex );
    sentientpoolmanager::registersentient( sentientpool, self.owner );
    thread weapons::monitordisownedequipment( self.owner, self );
    thread weapons::outlineequipmentforowner( self );
}

// Namespace trophy_system
// Params 1
// Checksum 0xdb0a57db, Offset: 0x4e01
// Size: 0x232
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        newbuff = { #rangebuff:params.bundle.var_6fc8ba35f66ea05a ?? 500, #var_8e69ad7d717da8df:params.bundle.var_f977d888d1443895 ?? -0.05, #var_244ba9cdacf2ce79:params.combatlink };
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = newbuff;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_8b5c7b2d272f8ea8" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_8b5c7b2d272f8ea8", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
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
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
        }
    }
}

// Namespace trophy_system
// Params 1
// Checksum 0xbd8445e0, Offset: 0x503b
// Size: 0x178
function remove_buff( params )
{
    assert( isdefined( self.var_30656af96b2ac2a4 ), "<dev string:x1a2>" );
    assert( self.var_30656af96b2ac2a4.size >= 1, "<dev string:x1f6>" );
    var_45d885c90f4f315 = [];
    
    foreach ( appliedbuff in self.var_30656af96b2ac2a4 )
    {
        if ( appliedbuff.var_244ba9cdacf2ce79 == params.combatlink )
        {
            var_45d885c90f4f315[ var_45d885c90f4f315.size ] = appliedbuff;
        }
    }
    
    assert( var_45d885c90f4f315.size <= 1, "<dev string:x248>" );
    assert( var_45d885c90f4f315.size >= 1, "<dev string:x27f>" );
    self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, var_45d885c90f4f315 );
    
    if ( self.var_30656af96b2ac2a4.size <= 0 )
    {
        if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
        {
            setheadiconimage( self.headiconid, level.gamemodebundle.var_a43747faa623d1b0, 1 );
        }
        
        self.var_48d6bc4ec1942918 = 1;
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0xe47292f8, Offset: 0x51bb
// Size: 0x57
function function_bb14c165d2c90cab()
{
    if ( !isdefined( level.projectilekillstreaks ) )
    {
        level.projectilekillstreaks = [];
    }
    
    if ( !isdefined( level.grenades ) )
    {
        level.grenades = [];
    }
    
    if ( !isdefined( level.missiles ) )
    {
        level.missiles = [];
    }
    
    while ( true )
    {
        level.trophysystempartition = undefined;
        waitframe();
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0x31695a49, Offset: 0x521a
// Size: 0x16
function function_7f0b1d6a1474fddc()
{
    if ( level.trophysystempartition )
    {
        return;
    }
    
    function_509d838a6bb92bc();
}

// Namespace trophy_system
// Params 0, eflags: 0x4
// Checksum 0xe3fccc14, Offset: 0x5238
// Size: 0x68
function private function_509d838a6bb92bc()
{
    level.var_1a371ac7284992a5 = function_5713d46873b29625( level.var_1a371ac7284992a5 );
    entities = function_be0dd53539a68b65( level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e(), level.projectilekillstreaks, level.var_1a371ac7284992a5 );
    level.trophysystempartition = utility::create_partition( entities, 400, 1 );
}

// Namespace trophy_system
// Params 1
// Checksum 0x3bb0d0b9, Offset: 0x52a8
// Size: 0x251
function function_71c31dd9b02af046( trophy_radius )
{
    if ( !isdefined( self.friendlycircle ) )
    {
        self.friendlycircle = {};
    }
    
    if ( !isdefined( self.enemycircle ) )
    {
        self.enemycircle = {};
    }
    
    if ( isdefined( self.circle_radius ) )
    {
        if ( self.circle_radius != trophy_radius )
        {
            function_7390a3d68debbc2f();
            self.circle_radius = trophy_radius;
        }
        else
        {
            return;
        }
    }
    else
    {
        self.circle_radius = trophy_radius;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_trophy" ) ?? level.equipment.table[ "equip_trophy" ].bundle;
    friendlycircle = bundle.var_d66f469d41606102;
    enemycircle = bundle.var_6b50e84173cf3f7f;
    assert( isdefined( friendlycircle ) && isdefined( enemycircle ), "<dev string:x2b1>" );
    self.friendlycircle game_utility::questcircle_create( friendlycircle, self.origin, trophy_radius );
    self.enemycircle game_utility::questcircle_create( enemycircle, self.origin, trophy_radius );
    ownerteamplayers = teams::getteamdata( self.team, "players" );
    
    foreach ( player in ownerteamplayers )
    {
        self.friendlycircle game_utility::questcircle_showtoplayer( player );
    }
    
    var_7c0674e159957cbf = teams::getenemyplayers( self.team, 0 );
    
    foreach ( player in var_7c0674e159957cbf )
    {
        self.enemycircle game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace trophy_system
// Params 0
// Checksum 0xbe52a9c1, Offset: 0x5501
// Size: 0x4e
function function_7390a3d68debbc2f()
{
    if ( self.friendlycircle )
    {
        self.friendlycircle game_utility::questcircle_delete();
        self.friendlycircle = undefined;
    }
    
    if ( self.enemycircle )
    {
        self.enemycircle game_utility::questcircle_delete();
        self.enemycircle = undefined;
    }
}

/#

    // Namespace trophy_system
    // Params 0
    // Checksum 0xa4d5e901, Offset: 0x5557
    // Size: 0x13, Type: dev
    function function_f453d73a546e6575()
    {
        thread function_930a202b638f2e65();
        thread function_f802b31ae55e758d();
    }

    // Namespace trophy_system
    // Params 0
    // Checksum 0x606b4ec0, Offset: 0x5572
    // Size: 0x11, Type: dev
    function function_7132775d51cfb5e7()
    {
        self notify( #"hash_1904dc5d7becad98" );
    }

    // Namespace trophy_system
    // Params 0
    // Checksum 0x2b16b974, Offset: 0x558b
    // Size: 0x13e, Type: dev
    function function_930a202b638f2e65()
    {
        level endon( #"game_end" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self endon( #"hash_1904dc5d7becad98" );
        baserange = 105625;
        var_b9a7e500b3a86f02 = 126750;
        var_b9a7e400b3a86ccf = 211250;
        baserange = sqrt( baserange );
        var_b9a7e500b3a86f02 = sqrt( var_b9a7e500b3a86f02 );
        var_b9a7e400b3a86ccf = sqrt( var_b9a7e400b3a86ccf );
        ranges = [];
        ranges[ 0 ] = baserange;
        ranges[ 1 ] = var_b9a7e500b3a86f02;
        ranges[ 2 ] = var_b9a7e400b3a86ccf;
        spherecolor = ( 1, 0, 0 );
        
        while ( true )
        {
            foreach ( range in ranges )
            {
                sphere( self.origin, range, spherecolor, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace trophy_system
    // Params 0
    // Checksum 0x245de9f5, Offset: 0x56d1
    // Size: 0xe5, Type: dev
    function function_f802b31ae55e758d()
    {
        level endon( #"game_end" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self endon( #"hash_1904dc5d7becad98" );
        self.var_20c5ec8e75a719f8 = [];
        spherecolor = ( 0, 1, 0 );
        
        while ( true )
        {
            foreach ( var_1b53f79c2495115d in self.var_20c5ec8e75a719f8 )
            {
                sphere( var_1b53f79c2495115d, 5, spherecolor, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace trophy_system
    // Params 1
    // Checksum 0xd262255d, Offset: 0x57be
    // Size: 0x69, Type: dev
    function function_e88a1fe9d0a3d31b( inent )
    {
        if ( isdefined( self.var_20c5ec8e75a719f8 ) )
        {
            self.var_20c5ec8e75a719f8[ self.var_20c5ec8e75a719f8.size ] = inent.origin;
            return;
        }
        
        self.var_20c5ec8e75a719f8 = [];
        self.var_20c5ec8e75a719f8[ self.var_20c5ec8e75a719f8.size ] = inent.origin;
    }

#/
