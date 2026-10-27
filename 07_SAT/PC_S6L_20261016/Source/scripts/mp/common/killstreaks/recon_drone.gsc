// scripts\mp\common\killstreaks\recon_drone.gsc  (hash_641f981cc2b70c1a.gscc) (size: 49943 Bytes / 0xc317 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9f6c663f (2674681407)
// size ...... 49943 (0xc317)
// includes .. 36  (offset: 0xb973)
// strings ... 123 (offset: 0xba93)
// dev strs .. 7   (offset: 0xc2c3)
// exports ... 103 (offset: 0x7a4f)
// cseg ...... 0x8e4 + 0x716b (0x7a4f)
// imports ... 377 (offset: 0x8a67)
// animtree1 . 0   (offset: 0xc317)
// animtree2 . 0   (offset: 0xc317)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\snapshot;
#using scripts\common\swim_common;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\gunship;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\render_utility;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\outofrange;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace recon_drone;

// Namespace recon_drone
// Params 0, eflags: 0x1
// Checksum 0x438b4383, Offset: 0x902
// Size: 0x9
function autoexec preinit()
{
    init();
}

// Namespace recon_drone
// Params 0
// Checksum 0x7f1072dd, Offset: 0x913
// Size: 0x19c
function init()
{
    utility::flag_wait( "supers_initialized" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_recon_drone" );
    beginusefunc = &recondrone_beginsuper;
    
    if ( bundle.weapontype == "OFFHANDWEAPON" )
    {
        beginusefunc = undefined;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_recon_drone", undefined, &recondrone_unsetsuper, beginusefunc, &recondrone_endsuper, &function_b3f40a817a5cf2e4, undefined, undefined, undefined, undefined );
    function_50423a39147f7827( "radar_drone_recon", bundle, "radar_drone_recon" );
    var_1f0159931b8957d = supers_mp::function_5ffd3dfa9cc1e8de( "super_recon_drone_dmz_mission" );
    beginusefunc = &recondrone_beginsuper;
    
    if ( var_1f0159931b8957d.weapontype == "OFFHANDWEAPON" )
    {
        beginusefunc = undefined;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_recon_drone_dmz_mission", undefined, &recondrone_unsetsuper, beginusefunc, &recondrone_endsuper, &function_b3f40a817a5cf2e4, undefined, undefined, undefined, undefined );
    function_50423a39147f7827( "recon_drone_dmz_mission", var_1f0159931b8957d, "recon_drone_dmz_mission", "rex_ks_remote_device_mp" );
    function_50423a39147f7827( "recon_drone_infiltration", bundle, "recon_drone_infiltration" );
    function_9c9b19560a9445c5( bundle.var_9177f56e99fb6f9d );
    init_recon_drone_vo();
    init_recon_drone_anim();
    function_4f37e92c8f9d7b7f();
    weapons::registerusedcallback( "recon_drone", &recon_drone_used );
    weapons::registerusedcallback( "recon_drone_dmz_mission", &recon_drone_dmz_mission_used );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #customend:1, #customstart:1, #equipref:"equip_recondrone" } );
    
    /#
        init_debug();
    #/
}

/#

    // Namespace recon_drone
    // Params 0, eflags: 0x4
    // Checksum 0xfb5716ab, Offset: 0xab7
    // Size: 0x6d, Type: dev
    function private init_debug()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdevdvarifuninitialized( @"hash_b23e7bb60bbe76a6", 0 );
        setdevdvarifuninitialized( @"hash_7d1382405485d79f", 0 );
        setdevdvarifuninitialized( @"hash_60a091e2e6da3352", 0 );
        setdevdvarifuninitialized( @"scr_recon_drone_smoke", 0 );
        setdevdvarifuninitialized( @"hash_2013691227d032f7", 0 );
        level thread function_7fdb1abda1c40d93();
    }

#/

// Namespace recon_drone
// Params 4
// Checksum 0x918a42de, Offset: 0xb2c
// Size: 0x586
function function_50423a39147f7827( key, bundle, streakname, deployweaponname = "ks_remote_drone_mp" )
{
    level.helperdronesettings[ key ] = spawnstruct();
    level.helperdronesettings[ key ].repeatuse = getdvarint( @"hash_b82bd719c6e7913", 0 );
    level.helperdronesettings[ key ].timeout = bundle.usetime;
    level.helperdronesettings[ key ].maxhealth = 45;
    level.helperdronesettings[ key ].hitstokill = 1;
    level.helperdronesettings[ key ].speed = 140;
    level.helperdronesettings[ key ].accel = 20;
    level.helperdronesettings[ key ].halfsize = 27;
    level.helperdronesettings[ key ].spawndist = 30;
    level.helperdronesettings[ key ].streakname = streakname ?? "radar_drone_recon";
    level.helperdronesettings[ key ].modelbase = bundle.var_2edc8e4795898757;
    level.helperdronesettings[ key ].teamsplash = "used_" + ( streakname ?? "radar_drone_recon" );
    level.helperdronesettings[ key ].destroyedsplash = "callout_destroyed_" + ( streakname ?? "radar_drone_recon" );
    level.helperdronesettings[ key ].scorepopup = "destroyed_" + ( streakname ?? "radar_drone_recon" );
    level.helperdronesettings[ key ].primarymode = "MANUAL";
    level.helperdronesettings[ key ].primarymodestring = &"killstreaks_hints/rcd_manual";
    level.helperdronesettings[ key ].primarymodefunc = &function_faa3adfd4489b4a1;
    level.helperdronesettings[ key ].premoddamagefunc = undefined;
    level.helperdronesettings[ key ].postmoddamagefunc = &helper_drone::helperdrone_postmodifydamage;
    level.helperdronesettings[ key ].tryusefunc = &function_58cfa4f7f03503c8;
    level.helperdronesettings[ key ].exitfunc = &recondrone_exit;
    level.helperdronesettings[ key ].leavefunc = &recondrone_leave;
    level.helperdronesettings[ key ].explodefunc = &recondrone_explode;
    level.helperdronesettings[ key ].returnplayerfunc = &recondrone_returnplayer;
    level.helperdronesettings[ key ].deathfunc = &helper_drone::helperdrone_handledeathdamage;
    level.helperdronesettings[ key ].playfxcallback = &helper_drone::helperdrone_playfx;
    level.helperdronesettings[ key ].var_a2bdd1c0e927f10e = &function_5a4c81b00c16e3c6;
    level.helperdronesettings[ key ].var_d188942a41771ea1 = &function_2ddb10f79088ca52;
    level.helperdronesettings[ key ].var_beb5cf9815327759 = 1;
    level.helperdronesettings[ key ].var_8882e489606fbd21 = 1;
    level.helperdronesettings[ key ].var_56f14c50d828adbe = 3062500;
    level.helperdronesettings[ key ].var_c069a84757495b12 = 6250000;
    level.helperdronesettings[ key ].colorvision = "recon_drone_color_mp";
    level.helperdronesettings[ key ].var_9fa8a04fa6a7af05 = "recon_drone_color_dark_mp";
    level.helperdronesettings[ key ].var_eaf7aed3b097c78d = 1;
    level.helperdronesettings[ key ].voontimeout = 1;
    level.helperdronesettings[ key ].vehicleinfo = bundle.var_14fa65357f4c0f7c;
    level.helperdronesettings[ key ].var_17e473e12ced7138 = bundle.var_9177f56e99fb6f9d;
    level.helperdronesettings[ key ].targetname = streakname;
    level.helperdronesettings[ key ].var_30e7bbc9ee1bd839 = bundle.var_a20dba7db0385e38;
    level.helperdronesettings[ key ].colorpbg = bundle.var_f26a0df067496cc3;
    level.helperdronesettings[ key ].thermalpbg = bundle.var_d22a350a16fb6513;
    level.helperdronesettings[ key ].var_c9532252f020d459 = bundle.var_9cab0ed9cb391322;
    level.helperdronesettings[ key ].onvehicledeath = &recondrone_onvehicledeath;
    level.helperdronesettings[ key ].deployweaponname = deployweaponname;
    
    /#
        level.helperdronesettings[ key ].var_5656d6269df25e83 = 0;
    #/
    
    if ( isbrgamemode() )
    {
        level.helperdronesettings[ key ].diewithowner = 1;
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x874b24d8, Offset: 0x10ba
// Size: 0x13e
function function_9c9b19560a9445c5( var_2b7c04ac7a00d9c )
{
    var_3dfe676467787e1f = [ "allow_jump", "supers", "killstreaks", "offhand_weapons" ];
    
    if ( !var_2b7c04ac7a00d9c )
    {
        var_3dfe676467787e1f[ var_3dfe676467787e1f.size ] = "vehicle_use";
        var_3dfe676467787e1f[ var_3dfe676467787e1f.size ] = "allow_movement";
    }
    
    val::group_register( "reconDrone_switch", var_3dfe676467787e1f );
    deployarray = [ "usability", "melee", "offhand_weapons", "weapon_switch" ];
    
    if ( !var_2b7c04ac7a00d9c )
    {
        deployarray[ deployarray.size ] = "vehicle_use";
    }
    
    val::group_register( "reconDrone_deploy", deployarray );
    usearray = [ "fire", "shellshock", "melee" ];
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_abbcd9152e41d77f" ) && [[ utility::getsharedfunc( #"equipment", #"hash_abbcd9152e41d77f" ) ]]() )
    {
        usearray[ usearray.size ] = "nvg";
    }
    
    if ( !var_2b7c04ac7a00d9c )
    {
        usearray[ usearray.size ] = "vehicle_use";
    }
    
    val::group_register( "reconDrone_use", usearray );
}

// Namespace recon_drone
// Params 0
// Checksum 0x4bf00968, Offset: 0x1200
// Size: 0x7e
function init_recon_drone_vo()
{
    game[ "dialog" ][ "radar_drone_recon" + "_teamleader_friendly_inbound" ] = "fieldupgrade_team_leader" + "_ally_callout";
    game[ "dialog" ][ "radar_drone_recon" + "_teamleader_enemy_inbound" ] = "fieldupgrade_team_leader" + "_enemy_callout";
    game[ "dialog" ][ "radar_drone_recon" + "_timeout" ] = "fieldupgrade_team_leader" + "_timeout";
    game[ "dialog" ][ "radar_drone_recon" + "_destroyed" ] = "fieldupgrade_team_leader" + "_crash";
}

// Namespace recon_drone
// Params 0
// Checksum 0xc39367d6, Offset: 0x1286
// Size: 0x2
function init_recon_drone_anim()
{
    
}

// Namespace recon_drone
// Params 0
// Checksum 0x826902fe, Offset: 0x1290
// Size: 0x1a
function function_4f37e92c8f9d7b7f()
{
    killstreak_shared::function_28d986de72ce85f8( "recon_drone_color_mp" );
    killstreak_shared::function_28d986de72ce85f8( "recon_drone_color_dark_mp" );
}

// Namespace recon_drone
// Params 0
// Checksum 0x9fcd9196, Offset: 0x12b2
// Size: 0x22
function tryuserecondrone()
{
    streakinfo = killstreak_utility::createstreakinfo( "radar_drone_recon", self );
    return function_58cfa4f7f03503c8( streakinfo );
}

// Namespace recon_drone
// Params 2
// Checksum 0x6d5f331c, Offset: 0x12dd
// Size: 0x2d8, Type: bool
function function_58cfa4f7f03503c8( streakinfo, droneentity )
{
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    helperdronetype = streakinfo.streakname;
    startpos = helper_drone::function_a5f95568df49cf66( helperdronetype, droneentity );
    var_627fb43f841ec021 = utility::callsharedfunc( #"map", #"hash_b4fafa9d5f310a7e", self, startpos );
    
    if ( !isdefined( startpos ) || var_627fb43f841ec021 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    if ( !isdefined( droneentity ) )
    {
        deployweaponobj = makeweapon( streakinfo.bundle.deployweaponname ?? "ks_remote_drone_mp" );
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &helper_drone::weapongivenhelperdrone );
        
        if ( !deployresult )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    var_fd467b160103911b = 0.6;
    fullanimtime = 2;
    result = utility::waittill_any_timeout( var_fd467b160103911b, "death", "weapon_switch_started" );
    
    if ( result != "timeout" )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    result = utility::waittill_any_timeout( fullanimtime - var_fd467b160103911b, "death" );
    
    if ( result != "timeout" )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    startpos = helper_drone::function_a5f95568df49cf66( helperdronetype );
    startangles = self.angles;
    recondrone = recondrone_create( startpos, startangles, helperdronetype, streakinfo );
    
    if ( !isdefined( recondrone ) )
    {
        return false;
    }
    
    recondrone.nosuper = streakinfo.nosuper;
    thread helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", recondrone, &function_52ef4af6e1bf6ef2, &function_2825613e791fef04 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreakuse" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"killstreakuse" ) ]]( "recon_drone" );
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_e360b168744d9b7 )
    {
        recondrone vehicleshowonminimap( 0 );
        killstreak_utility::playkillstreakusedialog( helperdronetype );
        recondrone helper_drone::helperdrone_notifyenemyplayersinrange( helperdronetype );
    }
    
    helper_drone::function_bc4c01fe510bb495( streakinfo );
    thread helper_drone::starthelperdrone( recondrone );
    return true;
}

// Namespace recon_drone
// Params 5
// Checksum 0x2ba9369a, Offset: 0x15be
// Size: 0x1a4
function recondrone_create( startpos, startang, helperdronetype, streakinfo, startingvelocity )
{
    recondrone = helper_drone::createhelperdrone( startpos, startang, helperdronetype, streakinfo, 0, 1, startingvelocity );
    
    if ( recondrone vehicle_isphysveh() )
    {
        level thread killstreak_utility::function_6348c97b79ee8a08( recondrone, self, &function_92b1d5858bf6f8de, undefined, 0 );
    }
    
    if ( !isdefined( recondrone ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        helper_drone::helperdronecreationfailedfx( helperdronetype, startpos );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        helper_drone::function_bc4c01fe510bb495( streakinfo );
        return;
    }
    
    recondrone.superref = streakinfo.superref;
    streakinfo.headiconid = entityheadicons::setheadicon_fieldupgrade( recondrone );
    recondrone.superref = undefined;
    thread utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #owner:self, #equipref:"equip_recondrone", #ent:recondrone } );
    config = level.helperdronesettings[ recondrone.helperdronetype ];
    recondrone function_ebaf928aa3a94a34( config );
    return recondrone;
}

// Namespace recon_drone
// Params 1
// Checksum 0x332ba8bc, Offset: 0x176b
// Size: 0x38
function function_5a4c81b00c16e3c6( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    vehicle_damage::set_vehicle_hit_damage_data( streakname, hitstokill );
}

// Namespace recon_drone
// Params 1
// Checksum 0x2fbd5842, Offset: 0x17ab
// Size: 0x91
function function_2ddb10f79088ca52( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    weaponname = "emp_grenade_mp";
    weaponhitsperattack = hitstokill;
    var_ffcfe5819a7a67f1 = hitstokill;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x997fc163, Offset: 0x1844
// Size: 0x6b
function function_faa3adfd4489b4a1( config )
{
    self.repeatuse = config.repeatuse;
    
    if ( !isdefined( self.enemiesmarked ) )
    {
        self.enemiesmarked = [];
    }
    
    if ( !isdefined( self.usedcount ) )
    {
        self.usedcount = 0;
    }
    
    if ( !isdefined( self.dronespectators ) )
    {
        self.dronespectators = [];
    }
    
    thread function_d6d11153072bc6b1( config );
}

// Namespace recon_drone
// Params 1
// Checksum 0x7652df93, Offset: 0x18b7
// Size: 0x50e, Type: bool
function function_d6d11153072bc6b1( config )
{
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    self.owner notify( #"dronestart" );
    
    if ( getdvarint( @"hash_fbbf89bc8f18c20", 1 ) )
    {
        self.owner thread player_utility::watchthermalinputchange( 1 );
    }
    
    self.targetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0 );
    self.dronespectators = self.owner getspectators();
    self.playersfx = spawn( "script_origin", self.origin );
    self.playersfx showonlytoplayer( self.owner );
    self.playersfx linkto( self );
    self.playersfx playloopsound( "recon_drone_overlay" );
    self.owner setsoundsubmix( "mp_recon_drone", 0.2 );
    
    if ( self getscriptableparthasstate( "engine_sfx", "plr_sfx" ) )
    {
        self setscriptablepartstate( "engine_sfx", "plr_sfx", 1 );
    }
    
    self.ispiloted = 1;
    
    if ( utility::issharedfuncdefined( #"supers", #"setsuperisactive" ) && !self.nosuper )
    {
        self.owner thread [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 1 );
    }
    
    if ( !config.var_17e473e12ced7138 )
    {
        self.owner val::group_set( "reconDrone_use", 0 );
        self.owner player::_freezecontrols( 0, 1, "reconDrone" );
        self.owner player::_freezelookcontrols( 0, 1 );
    }
    
    var_f7f0673a9c02ca39 = 0;
    
    /#
        var_be458bc45c02fda5 = getdvarint( @"hash_b23e7bb60bbe76a6", 0 );
        
        if ( var_be458bc45c02fda5 )
        {
            var_f7f0673a9c02ca39 = 1;
        }
    #/
    
    self.owner.restoreangles = self.owner.angles;
    
    if ( config.var_17e473e12ced7138 )
    {
        self.owner usevehicle( self, 0 );
    }
    else
    {
        self.owner setplayerangles( self.angles );
        self.owner cameralinkto( self, "tag_origin" );
        self.owner remotecontrolvehicle( self );
    }
    
    self.owner common_item::function_f3fdebbb09f39fb1( &function_6a4b42d42c4b133e );
    self.owner render_utility::function_2636a65c7f96feff( 1, 0, 0.015, 0.15 );
    self.owner setclientomnvar( "ui_killstreak_health", self.currenthealth / self.maxhealth );
    
    if ( emp_debuff::is_empd() )
    {
        helper_drone::function_f3897bba9c46b35f( 1 );
    }
    
    self.owner painvisionoff();
    self.owner killstreak_shared::killstreak_savenvgstate();
    self setscriptablepartstate( "ddos", "neutral", 0 );
    emp_debuff::set_start_emp_callback( &recondrone_empstarted );
    emp_debuff::set_apply_emp_callback( &recondrone_empapplied );
    emp_debuff::function_6e0986f750cd4259( &function_53fdbf1c2d9339df );
    
    if ( level.killstreak_emp_initialized )
    {
        self.var_5b3dbacfeda0fd01 = &recondrone_empstarted;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempapplycallback = &recondrone_empapplied;
    }
    
    emp_debuff::set_clear_emp_callback( &recondrone_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempclearcallback = &recondrone_empcleared;
    }
    
    chaff_debuff::function_4118b0299dc40ea( &function_db9b1c92c85ca739 );
    chaff_debuff::function_3860212a5ec36b56( &function_b99f4377fc054089 );
    chaff_debuff::function_324dd42a2703bc25( &function_2ae1776e2d374ba0 );
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        self [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( self );
    }
    
    haywire::function_7f69a1eb3d590f76( &recondrone_haywireapplied );
    killstreak_utility::movingplatform_playerlink( self.owner );
    
    if ( !var_f7f0673a9c02ca39 )
    {
        if ( false )
        {
            outofrange::setupoutofrangewatcher( self, undefined, self.owner, undefined, 2250000, 9000000 );
        }
        
        self.owner helper_drone::function_686284be4293a73a( 1, self );
        self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
        self.owner enableusability();
        thread function_79cffad9943d904d( config );
        thread function_348e75efd55b653f( config );
        thread function_a35d4d18f8290186( config );
        
        if ( utility::issharedfuncdefined( #"helper_drone", #"mark_players" ) )
        {
            self thread [[ utility::getsharedfunc( #"helper_drone", #"mark_players" ) ]]( config );
        }
        else
        {
            thread function_d03899ca975b59c3( config );
        }
        
        thread function_baee522ffb64c56f( config );
        thread function_88c8d23ab444a839();
    }
    
    if ( self.oob )
    {
        killstreak_utility::function_6824a8404514032c();
    }
    
    return true;
}

// Namespace recon_drone
// Params 1
// Checksum 0x8606f777, Offset: 0x1dce
// Size: 0x73
function function_ebaf928aa3a94a34( config )
{
    if ( !config.var_17e473e12ced7138 || !common_inventory::inventory_isenabled() )
    {
        return;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( self.origin, self.angles );
    container = common_item::function_57b88e025e5fb03e( %"hash_f797b63f4dceaa0", 1, spawnoptions );
    self.container = container;
}

// Namespace recon_drone
// Params 1
// Checksum 0xfc974af7, Offset: 0x1e49
// Size: 0x3c, Type: bool
function function_6a4b42d42c4b133e( item )
{
    common_inventory_groups::function_d1ad55b9507ab500( 0, 0, 0, 31, 31, self.container, 1, undefined, item );
    common_item::function_6b392f3e5fc53c0d( item, common_item::function_6b8ff3d5f2688336( item ), 0 );
    return true;
}

// Namespace recon_drone
// Params 0
// Checksum 0x7bb45a27, Offset: 0x1e8e
// Size: 0x204, Type: bool
function function_b3f40a817a5cf2e4()
{
    if ( !isdefined( self.recondronesuper ) )
    {
        return false;
    }
    else
    {
        drone = self.recondronesuper;
        
        if ( !drone.repeatuse )
        {
            return false;
        }
        
        if ( !isnullweapon( self getheldoffhand() ) )
        {
            return false;
        }
        
        if ( !self isonground() )
        {
            if ( function_d3ca5bf7385a2bcf() )
            {
                return false;
            }
            
            if ( !player_utility::function_2e61ffcf29281b15() )
            {
                return false;
            }
        }
        
        if ( vehicle::is_in_vehicle( 1 ) )
        {
            return false;
        }
        
        if ( self ismeatshieldactive() || self isinexecutionattack() || self isinexecutionvictim() )
        {
            return false;
        }
        
        superinfo = self.super;
        
        if ( !isdefined( superinfo ) )
        {
            return false;
        }
        
        if ( isdefined( superinfo ) && superinfo.usepercent < 0.05 )
        {
            return false;
        }
        
        drone.var_99e2d83f9d0b250a = 1;
        drone notify( #"regain_control" );
        config = level.helperdronesettings[ drone.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            player::_freezelookcontrols( 1 );
        }
        
        result = recondrone_givedeployweapon( "ks_remote_device_mp", drone );
        thread helper_drone::helperdrone_giveplayerfauxremote( drone.streakinfo );
        
        if ( !result )
        {
            if ( !config.var_17e473e12ced7138 )
            {
                player::_freezelookcontrols( 0, 1 );
            }
            
            val::group_reset( "reconDrone_switch" );
            thread recondrone_takedeployweapon( 1, "ks_remote_device_mp" );
            
            if ( utility::isusingremote() )
            {
                thread helper_drone::helperdrone_takeplayerfauxremote( drone.streakinfo );
            }
            
            return false;
        }
        else
        {
            self.vehicle = drone;
        }
        
        drone killstreak_utility::function_6824a8404514032c();
        drone function_d6d11153072bc6b1( config );
        
        if ( drone.var_d2bfd30f061e7f56 )
        {
            drone thread [[ drone.var_d2bfd30f061e7f56 ]]( drone );
        }
        
        helper_drone::function_98cd33662c8f413d( drone );
        
        if ( drone.isthermalenabled )
        {
            player_utility::setthermalvision( 1, 12, 1000 );
        }
    }
    
    return true;
}

// Namespace recon_drone
// Params 0
// Checksum 0xe51556c8, Offset: 0x209b
// Size: 0x149
function function_88c8d23ab444a839()
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    smokegrenadefeature = getdvarint( @"scr_recon_drone_smoke", 0 );
    
    if ( smokegrenadefeature )
    {
        droneowner notifyonplayercommand( "recon_smoke_launch", "+attack" );
        droneowner setclientomnvar( "ui_killstreak_weapon_1_ammo", 3 );
        smokecount = 3;
        
        while ( smokecount > 0 )
        {
            droneowner waittill( #"recon_smoke_launch" );
            
            if ( !self.ispiloted )
            {
                continue;
            }
            
            launchorigin = self.origin + anglestoforward( self.angles ) * 50;
            launchgoal = gunship::getownerlookatpos( droneowner );
            launchvelocity = launchgoal - launchorigin;
            
            /#
                thread debug_utility::drawsphere( launchgoal, 20, 10, ( 1, 1, 1 ) );
            #/
            
            magicgrenademanual( "smoke_grenade_stick_mp", launchorigin, launchvelocity, 2 );
            smokecount--;
            droneowner setclientomnvar( "ui_killstreak_weapon_1_ammo", smokecount );
        }
        
        return;
    }
    
    droneowner setclientomnvar( "ui_killstreak_weapon_1_ammo", 0 );
}

// Namespace recon_drone
// Params 1
// Checksum 0x2f0e0472, Offset: 0x21ec
// Size: 0x35c
function function_d03899ca975b59c3( config )
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    var_54e4405a5938ecfc = 0;
    self.markingtarget = undefined;
    
    while ( true )
    {
        if ( !isdefined( self.targetmarkergroup ) )
        {
            var_54e4405a5938ecfc = 0;
            waitframe();
        }
        
        self.targethascoldblooded = 0;
        self.targetisnotinmarkingrange = 0;
        self.anyoneisinmarkingrange = 0;
        targets = self.targetsinouterradius;
        
        foreach ( player in targets )
        {
            if ( var_54e4405a5938ecfc >= 3 )
            {
                var_54e4405a5938ecfc = 0;
                waitframe();
            }
            
            if ( !player )
            {
                continue;
            }
            
            if ( emp_debuff::is_empd() )
            {
                continue;
            }
            
            if ( isplayer( player ) && !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( isagent( player ) )
            {
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                if ( isdefined( player.agent_type ) && issubstr( player.agent_type, "civilian" ) )
                {
                    helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 3 );
                    continue;
                }
            }
            
            if ( function_76ecedd053b87c1( player ) )
            {
                continue;
            }
            
            if ( recondrone_ismarked( player ) )
            {
                continue;
            }
            
            var_54e4405a5938ecfc++;
            helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 1 );
            isvisible = helper_drone::helperdrone_canseetarget( player );
            isinreticle = droneowner function_fe4d398293d70efc( player, 70, 50 );
            isinrange = function_5c048b824a93d619( player );
            hascoldblooded = isplayer( player ) && isdefined( player.perks[ "specialty_noscopeoutline" ] ) || player.var_c3b902d41fc3529d;
            
            if ( isinreticle && hascoldblooded )
            {
                self.targethascoldblooded = 1;
            }
            
            if ( isinreticle && !isinrange )
            {
                self.targetisnotinmarkingrange = 1;
            }
            
            if ( isinrange )
            {
                self.anyoneisinmarkingrange = 1;
            }
            
            if ( hascoldblooded )
            {
                helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 3 );
                continue;
            }
            
            if ( ( !isinrange || !isvisible ) && self.ispiloted )
            {
                helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 0 );
                
                if ( self.repeatuse )
                {
                    player thread function_bc8c8dad3d7d1027( self );
                }
                
                continue;
            }
            
            if ( !isinreticle )
            {
                continue;
            }
            
            if ( self.markingtarget )
            {
                continue;
            }
            
            thread function_a128781df7b61a20( player, function_fa52912722ef59ae() );
            droneowner callback::callback( #"recon_drone_watch_enemy", { #objweapon:self, #idamage:0, #inflictor:droneowner, #attacker:droneowner, #victim:player } );
        }
        
        var_54e4405a5938ecfc = 0;
        waitframe();
    }
}

// Namespace recon_drone
// Params 0, eflags: 0x4
// Checksum 0x2ef24a11, Offset: 0x2550
// Size: 0x4a
function private function_fa52912722ef59ae()
{
    if ( !self.var_83f598b130c2ce49 )
    {
        return "enemy";
    }
    
    switch ( self.var_83f598b130c2ce49 )
    {
        case #"hash_f22e325ccd2fb214":
            return "vehicle";
        default:
            return "enemy";
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xfb87106a, Offset: 0x25a2
// Size: 0xb7
function function_79cffad9943d904d( config )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"switch_modes" );
    self.owner endon( #"disconnect" );
    reticlestate = 0;
    
    while ( true )
    {
        if ( self.markingtarget && reticlestate == 0 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 1 );
            reticlestate = 1;
        }
        else if ( !self.markingtarget && reticlestate == 1 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
            reticlestate = 0;
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x388dc81c, Offset: 0x2661
// Size: 0xce
function function_348e75efd55b653f( config )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"switch_modes" );
    self.owner endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.targethascoldblooded )
        {
            self.owner setclientomnvar( "ui_rcd_notification", 3 );
        }
        else if ( self.targetisnotinmarkingrange )
        {
            self.owner setclientomnvar( "ui_rcd_notification", 1 );
        }
        else if ( !self.anyoneisinmarkingrange )
        {
            self.owner setclientomnvar( "ui_rcd_notification", 2 );
        }
        else
        {
            self.owner setclientomnvar( "ui_rcd_notification", 0 );
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x92b9da59, Offset: 0x2737
// Size: 0x253
function function_a35d4d18f8290186( config )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    self.owner endon( #"disconnect" );
    self.targetsinouterradius = [];
    
    while ( true )
    {
        if ( !self.owner )
        {
            return;
        }
        
        targetarray = function_71ffb393cf1aee15();
        
        if ( level.additionalrecondronetargets )
        {
            var_5e22077dad694eaa = [];
            
            foreach ( target in level.additionalrecondronetargets )
            {
                if ( isdefined( target.datakey ) )
                {
                    if ( flags::gameflag( "prematch_done" ) )
                    {
                        if ( utility::issharedfuncdefined( #"player", #"hash_5f47efcdbbb1cf0c" ) )
                        {
                            if ( [[ utility::getsharedfunc( #"player", #"hash_5f47efcdbbb1cf0c" ) ]]( self.owner, target.datakey ) )
                            {
                                var_5e22077dad694eaa[ var_5e22077dad694eaa.size ] = target;
                            }
                        }
                    }
                    
                    continue;
                }
                
                var_5e22077dad694eaa[ var_5e22077dad694eaa.size ] = target;
            }
            
            combinedarray = arraycombine( targetarray, var_5e22077dad694eaa );
        }
        else
        {
            combinedarray = targetarray;
        }
        
        if ( utility::issharedfuncdefined( #"helper_drone", #"hash_8b555f9284e25f65" ) )
        {
            combinedarray = self [[ utility::getsharedfunc( #"helper_drone", #"hash_8b555f9284e25f65" ) ]]( config );
        }
        
        foreach ( ent in combinedarray )
        {
            if ( !function_f21d4db944da7a2( ent ) )
            {
                continue;
            }
            
            thread function_23629954d9425187( ent );
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xcfe7389, Offset: 0x2992
// Size: 0x1cf
function function_23629954d9425187( target )
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    
    if ( !isdefined( self.targetmarkergroup ) )
    {
        return;
    }
    
    self.targetsinouterradius[ self.targetsinouterradius.size ] = target;
    targetmarkergroups::targetmarkergroup_markentity( target, self.targetmarkergroup, 0 );
    
    while ( isdefined( target ) )
    {
        if ( isplayer( target ) )
        {
            if ( !player::isreallyalive( target ) )
            {
                break;
            }
        }
        
        if ( isagent( target ) && !isalive( target ) )
        {
            break;
        }
        
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( config.var_8882e489606fbd21 && !self.owner function_fe4d398293d70efc( target, 70, 300 ) )
        {
            break;
        }
        
        if ( !recondrone_isindetectrange( target ) )
        {
            break;
        }
        
        if ( !targetmarkergroups::function_8057fbde5c4ad4d2( target, self.targetmarkergroup ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( target ) )
    {
        if ( targetmarkergroups::targetmarkergroupexists( self.targetmarkergroup ) && targetmarkergroups::function_8057fbde5c4ad4d2( target, self.targetmarkergroup ) && !recondrone_ismarked( target ) )
        {
            targetmarkergroups::targetmarkergroup_unmarkentity( target, self.targetmarkergroup );
        }
        
        if ( arraycontains( self.targetsinouterradius, target ) )
        {
            self.targetsinouterradius = arrayremove( self.targetsinouterradius, target );
        }
        
        return;
    }
    
    self.targetsinouterradius = function_5713d46873b29625( self.targetsinouterradius );
}

// Namespace recon_drone
// Params 1
// Checksum 0x7dfb5e32, Offset: 0x2b69
// Size: 0x246
function function_baee522ffb64c56f( config )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"regain_control" );
    self.owner endon( #"disconnect" );
    self waittill( #"switch_modes" );
    groundtracestart = self.origin;
    groundtraceend = self.origin - ( 0, 0, 10000 );
    contentoverride = trace::create_world_contents();
    groundtrace = trace::ray_trace( groundtracestart, groundtraceend, self, contentoverride );
    markingorigin = groundtraceend;
    
    if ( isdefined( groundtrace[ "hittype" ] ) && groundtrace[ "hittype" ] != "hittype_none" )
    {
        markingorigin = groundtrace[ "position" ];
    }
    
    markingradius = 1750;
    markingheight = self.origin[ 2 ] - markingorigin[ 2 ];
    
    while ( true )
    {
        potentialtargets = undefined;
        
        if ( utility::issharedfuncdefined( #"helper_drone", #"hash_8b555f9284e25f65" ) )
        {
            potentialtargets = self [[ utility::getsharedfunc( #"helper_drone", #"hash_8b555f9284e25f65" ) ]]( config );
        }
        else if ( level.teambased )
        {
            potentialtargets = utility::playersincylinder( markingorigin, markingradius, undefined, markingheight, self.team );
        }
        else
        {
            potentialtargets = utility::playersincylinder( markingorigin, markingradius, self.owner, markingheight );
        }
        
        waitforcooldown = 0;
        
        foreach ( target in potentialtargets )
        {
            if ( function_481ac92b9a249bdf( target ) )
            {
                function_a128781df7b61a20( target, "enemy", 1 );
                waitforcooldown = 1;
                break;
            }
        }
        
        if ( waitforcooldown )
        {
            wait 3;
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xbb63f106, Offset: 0x2db7
// Size: 0x10c
function function_bc8c8dad3d7d1027( drone )
{
    drone.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    drone endon( #"death" );
    drone endon( #"explode" );
    drone endon( #"switch_modes" );
    self notify( #"hash_3465a667e1624869" );
    self endon( #"hash_3465a667e1624869" );
    
    if ( !isdefined( drone.targetmarkergroup ) )
    {
        return;
    }
    
    while ( drone.ispiloted )
    {
        if ( level.var_9ba524a5a23203ac )
        {
            var_e0c119446b0595b9 = drone helper_drone::helperdrone_canseetarget( self );
            
            if ( !var_e0c119446b0595b9 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    while ( true )
    {
        if ( isplayer( self ) )
        {
            if ( !player::isreallyalive( self ) )
            {
                break;
            }
        }
        
        if ( !drone helper_drone::helperdrone_canseetarget( self, 1 ) || !drone function_5c048b824a93d619( self ) )
        {
            break;
        }
        
        waitframe();
    }
    
    targetmarkergroups::targetmarkergroup_unmarkentity( self, drone.targetmarkergroup );
}

// Namespace recon_drone
// Params 3
// Checksum 0x6e9278f0, Offset: 0x2ecb
// Size: 0x6fd
function function_a128781df7b61a20( target, targettype, automarker )
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    markdata = spawnstruct();
    markdata.target = target;
    markdata.targetnum = target function_f7fe248d4f134ebe();
    markdata.markingent = self;
    markdata.owner = droneowner;
    markdata.ownerteam = droneowner.team;
    markdata.outlineid = undefined;
    markdata.headicon = undefined;
    markdata.beingmarked = undefined;
    markdata.reconmarked = undefined;
    markdata.notifytoendmark = "unmarked_" + markdata.targetnum;
    
    if ( !isdefined( markdata.targetnum ) )
    {
        return;
    }
    
    if ( int( markdata.targetnum ) && markdata.targetnum > function_baaf37c0fcd605c1() - 1 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( self.targetmarkergroup ) && !automarker )
    {
        return;
    }
    
    markdata.beingmarked = 1;
    self.markingtarget = 1;
    self.owner notify( #"marking_target" );
    var_943be17e54d3e21 = function_637e42fd8cfc4a04();
    self.owner playlocalsound( "recon_drone_marking_owner", undefined, 1 );
    self setscriptablepartstate( "target_glint", "on" );
    
    if ( automarker )
    {
        self setlookatent( target );
    }
    
    while ( var_943be17e54d3e21 > 0 )
    {
        if ( !isdefined( target ) )
        {
            return;
        }
        
        isstillvalidtarget = ( !isplayer( target ) && !isagent( target ) || player::isreallyalive( target ) ) && ( automarker && helper_drone::helperdrone_canseetarget( target, 1 ) && function_5c048b824a93d619( target ) || droneowner function_fe4d398293d70efc( target, 70, 50 ) );
        
        if ( !isstillvalidtarget )
        {
            markdata.beingmarked = undefined;
            self.markingtarget = undefined;
            self.owner stoplocalsound( "recon_drone_marking_owner" );
            
            foreach ( spectator in self.dronespectators )
            {
                if ( !isdefined( spectator ) )
                {
                    continue;
                }
                
                spectator stoplocalsound( "recon_drone_marking_owner" );
            }
            
            self setscriptablepartstate( "target_glint", "off" );
            self clearlookatent();
            return;
        }
        
        var_943be17e54d3e21 -= 0.05;
        wait 0.05;
    }
    
    if ( isdefined( target.recondronemarkedcb ) )
    {
        [[ target.recondronemarkedcb ]]( droneowner, target );
    }
    
    droneowner callback::callback( #"hash_2fe6e340a46bbf0f", { #target:target, #droneowner:droneowner } );
    self clearlookatent();
    self setscriptablepartstate( "target_glint", "off" );
    thread function_536b4910f7f91426();
    markdata.reconmarked = 1;
    self.markingtarget = undefined;
    function_2cfcbc130f2dd570( markdata, undefined, automarker );
    self.owner playlocalsound( "recon_drone_marked_owner", undefined, 1 );
    self.owner stoplocalsound( "recon_drone_marking_owner" );
    
    foreach ( spectator in self.dronespectators )
    {
        if ( !spectator )
        {
            continue;
        }
        
        spectator stoplocalsound( "recon_drone_marking_owner" );
    }
    
    function_84e271a577fb97cc( 1, markdata.targetnum, markdata.ownerteam, 1 );
    
    if ( !automarker )
    {
        helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, target, 2 );
    }
    
    function_b8e29e2875b45661( target, targettype );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
    {
        if ( isdefined( self.owner.leaderboarddata[ "reconDroneMarks" ] ) )
        {
            self.owner.leaderboarddata[ "reconDroneMarks" ] = self.owner.leaderboarddata[ "reconDroneMarks" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "reconDroneMarks" ] ) )
        {
            [[ level.leaderboardfunc[ "reconDroneMarks" ] ]]( self.owner, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x7b>" );
        
        if ( isdefined( self.owner.pers[ "reconDroneMarks" ] ) )
        {
            self.owner.pers[ "reconDroneMarks" ] = self.owner.pers[ "reconDroneMarks" ] + 1;
        }
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"hash_fc677b6b2e7fd6bf" ) )
    {
        self.owner [[ utility::getsharedfunc( #"supers", #"hash_fc677b6b2e7fd6bf" ) ]]( "super_recon_drone" );
    }
    
    self.usedcount++;
    timeout = 5;
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"hash_2b56ca7a4c3b32db" ) )
    {
        timeout = [[ utility::getsharedfunc( #"helper_drone", #"hash_2b56ca7a4c3b32db" ) ]]();
    }
    
    if ( isdefined( self.owner.perks[ "specialty_improved_target_mark" ] ) )
    {
        timeout += 2;
    }
    
    target.var_829239c4c3a4a64[ markdata.ownerteam ] = gettime() + timeout * 1000;
    thread function_a8cd2b1fd2d9ebe( markdata, timeout );
    thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #eventid:self.eventid, #equipref:"equip_recondrone", #victim:target, #ent:self, #owner:droneowner } );
}

// Namespace recon_drone
// Params 2
// Checksum 0x6d3dbd7e, Offset: 0x35d0
// Size: 0xb0
function function_b8e29e2875b45661( target, targettype )
{
    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        self.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( hashcat( getxhash( self.helperdronetype ), "_", targettype, "_marked" ) );
    }
    
    if ( utility::issharedfuncdefined( #"player", #"hash_2becc11335863433" ) )
    {
        self.owner thread [[ utility::getsharedfunc( #"player", #"hash_2becc11335863433" ) ]]();
    }
}

// Namespace recon_drone
// Params 2
// Checksum 0xc9f775ed, Offset: 0x3688
// Size: 0x5a
function function_a8cd2b1fd2d9ebe( markdata, timeout )
{
    level endon( #"game_ended" );
    target = markdata.target;
    target endon( markdata.notifytoendmark );
    function_c8ae6bd452680293( markdata, timeout );
    function_19e4b75067119bdc( markdata );
}

// Namespace recon_drone
// Params 2
// Checksum 0x218aadbc, Offset: 0x36ea
// Size: 0xd6
function function_c8ae6bd452680293( markdata, timeout )
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    target = markdata.target;
    target endon( #"death" );
    starttime = gettime();
    
    while ( gettime() <= starttime + timeout * 1000 )
    {
        if ( isdefined( self ) && isdefined( self.owner ) && self.ispiloted && self.owner function_fe4d398293d70efc( target, 70, 50 ) && function_5c048b824a93d619( target ) && helper_drone::helperdrone_canseetarget( target ) )
        {
            starttime = gettime();
        }
        
        wait 0.05;
    }
}

// Namespace recon_drone
// Params 2
// Checksum 0x79f89117, Offset: 0x37c8
// Size: 0x26
function function_2de5f68835eaa77e( markingdrone, target )
{
    return arraycontains( markingdrone.targetsinouterradius, target );
}

// Namespace recon_drone
// Params 1
// Checksum 0xd84a22e3, Offset: 0x37f7
// Size: 0xd0, Type: bool
function function_5c048b824a93d619( target )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    isbigmap = game_utility::islargemap();
    var_26961689c3c3ddea = isbigmap ? config.var_c069a84757495b12 : config.var_56f14c50d828adbe;
    var_26961689c3c3ddea = target function_d3ca5bf7385a2bcf() ? 250000 : var_26961689c3c3ddea;
    
    if ( isdefined( target.markdistanceoverride ) )
    {
        var_26961689c3c3ddea = target.markdistanceoverride;
    }
    
    targetpos = target.origin;
    
    if ( isplayer( target ) )
    {
        targetpos = target utility::function_68061c3d21a6d57a();
    }
    
    return distancesquared( self.origin, targetpos ) < var_26961689c3c3ddea;
}

// Namespace recon_drone
// Params 1
// Checksum 0x7bbb3e0c, Offset: 0x38d0
// Size: 0x4a, Type: bool
function recondrone_isindetectrange( target )
{
    detectrange = 25000000;
    
    if ( target function_d3ca5bf7385a2bcf() )
    {
        detectrange = 562500;
    }
    
    return distancesquared( self.origin, target.origin ) < detectrange;
}

// Namespace recon_drone
// Params 1
// Checksum 0xbb3d0b18, Offset: 0x3923
// Size: 0x4a, Type: bool
function function_b02810a901ee4809( target )
{
    detectrange = 3062500;
    
    if ( target function_d3ca5bf7385a2bcf() )
    {
        detectrange = 250000;
    }
    
    return distancesquared( self.origin, target.origin ) < detectrange;
}

// Namespace recon_drone
// Params 1
// Checksum 0x2fb2a8c9, Offset: 0x3976
// Size: 0x4f, Type: bool
function function_76ecedd053b87c1( target )
{
    if ( !isdefined( self.enemiesmarked ) )
    {
        return false;
    }
    
    markdata = self.enemiesmarked[ target function_f7fe248d4f134ebe() ];
    
    if ( !isdefined( markdata ) )
    {
        return false;
    }
    
    return isdefined( markdata.beingmarked );
}

// Namespace recon_drone
// Params 1
// Checksum 0xd1eeded, Offset: 0x39ce
// Size: 0x4f, Type: bool
function recondrone_ismarked( target )
{
    if ( !isdefined( self.enemiesmarked ) )
    {
        return false;
    }
    
    markdata = self.enemiesmarked[ target function_f7fe248d4f134ebe() ];
    
    if ( !isdefined( markdata ) )
    {
        return false;
    }
    
    return istrue( markdata.reconmarked );
}

// Namespace recon_drone
// Params 0
// Checksum 0x7b4eb870, Offset: 0x3a26
// Size: 0x1b
function function_637e42fd8cfc4a04()
{
    return self.ispiloted ? 0.75 : 1;
}

// Namespace recon_drone
// Params 4
// Checksum 0xdf07b840, Offset: 0x3a4a
// Size: 0x1db
function function_8b9dcee2d6965764( target, markpos, drone, timeout )
{
    markdata = spawnstruct();
    markdata.target = target;
    markdata.targetnum = target function_f7fe248d4f134ebe();
    markdata.outlineid = undefined;
    markdata.headicon = undefined;
    var_23187a3aebf42293 = spawn( "script_model", markpos );
    var_23187a3aebf42293 setmodel( "tag_origin" );
    showto = undefined;
    
    if ( level.teambased )
    {
        showto = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team != self.team )
            {
                continue;
            }
            
            showto[ showto.size ] = player;
        }
    }
    else
    {
        showto = self.owner;
    }
    
    if ( !isdefined( showto ) )
    {
        assertmsg( "<dev string:xa1>" );
        return;
    }
    
    if ( isarray( showto ) && showto.size == 0 )
    {
        assertmsg( "<dev string:xdd>" );
        return;
    }
    
    if ( true )
    {
        markicon = "hud_icon_new_marked";
        
        if ( entityheadicons::function_aeb3fc6af7792562() )
        {
            markicon = "hud_icon_head_marked";
        }
        
        markdata.headicon = var_23187a3aebf42293 entityheadicons::setheadicon_singleimage( showto, markicon, 15, 1, 5000, 500, undefined, 1, 1 );
    }
    
    thread function_acc81c39fcf7add5( markdata, var_23187a3aebf42293, timeout );
}

// Namespace recon_drone
// Params 3
// Checksum 0x1e5139c1, Offset: 0x3c2d
// Size: 0xa4
function function_acc81c39fcf7add5( markdata, var_74edcdf8b319dfa4, timeout )
{
    level endon( #"game_ended" );
    utility::waittill_any_timeout( timeout, "death", "explode" );
    
    if ( isdefined( markdata.icon ) )
    {
        entityheadicons::setheadicon_deleteicon( markdata.icon );
        
        if ( isdefined( var_74edcdf8b319dfa4 ) )
        {
            var_74edcdf8b319dfa4 delete();
        }
    }
    
    if ( isdefined( markdata.target ) )
    {
        markdata.target.locationmarked = undefined;
    }
    
    self.enemiesmarked[ markdata.targetnum ] = undefined;
}

// Namespace recon_drone
// Params 3
// Checksum 0xbe665ba3, Offset: 0x3cd9
// Size: 0x340
function function_2cfcbc130f2dd570( markdata, timeout, var_c6417d5673431a4 )
{
    target = markdata.target;
    self.enemiesmarked[ markdata.targetnum ] = markdata;
    markicon = "hud_icon_new_marked";
    
    if ( entityheadicons::function_aeb3fc6af7792562() )
    {
        markicon = "hud_icon_head_marked";
    }
    
    var_f973a055a629002d = 8;
    
    if ( isplayer( target ) )
    {
        if ( false )
        {
            if ( level.teambased )
            {
                if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
                {
                    markdata.outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( target, "orange", self.owner.team, 0, 1, 0, "killstreak" );
                }
            }
            else if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
            {
                markdata.outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( target, "orange", self.owner, 0, 1, 0, "killstreak" );
            }
            
            if ( utility::issharedfuncdefined( #"outline", #"hash_ad068ada1bc7aadd" ) )
            {
                target [[ utility::getsharedfunc( #"outline", #"hash_ad068ada1bc7aadd" ) ]]( 5, 0, 1 );
            }
        }
        
        target thread snapshot::function_23f4614f16363579();
        target snapshot::function_c802f1ac50040a2c();
        target playlocalsound( "recon_drone_spotted_plr" );
    }
    else if ( false )
    {
        markstruct = function_a8442262d245b063( markicon, var_f973a055a629002d, target );
        markicon = markstruct.weaponicon;
        var_f973a055a629002d = markstruct.weaponoffset;
    }
    
    if ( self.isthermalenabled )
    {
        challenges::function_4fd386d590e901d8( self, #"hash_c50cf868c6994df3", #"hash_332d889bbbece284" );
    }
    
    if ( var_c6417d5673431a4 )
    {
        challenges::function_4fd386d590e901d8( self, #"hash_c50cf868c6994df3", #"auto_marked_target" );
    }
    
    challenges::function_4fd386d590e901d8( self, #"hash_c50cf868c6994df3", #"mark_target" );
    challengeparams = { #fieldupgraderef:"super_recon_drone", #fieldupgradeent:self, #victim:target, #attacker:self.owner };
    callback::callback( #"field_upgrade_hit", challengeparams );
    self.owner challenges::function_a0936b0e5b4550f3( "super_recon_drone", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    self.owner notify( #"marked_target" );
    
    if ( true )
    {
        markdata.headicon = target entityheadicons::setheadicon_singleimage( [], markicon, var_f973a055a629002d, 1, 4000, 500, undefined, 1, 1 );
        function_88952d70abec2f91( markdata );
    }
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"hash_708827ce1949625e" ) )
    {
        self thread [[ utility::getsharedfunc( #"helper_drone", #"hash_708827ce1949625e" ) ]]( markdata );
    }
}

// Namespace recon_drone
// Params 3
// Checksum 0x80f948b7, Offset: 0x4021
// Size: 0x1d5
function function_a8442262d245b063( defaulticon, defaultoffset, target )
{
    weaponicon = defaulticon;
    weaponoffset = defaultoffset;
    weaponstruct = spawnstruct();
    
    if ( isdefined( target.weapon_name ) )
    {
        weaponref = undefined;
        
        if ( issubstr( target.weapon_name, "claymore" ) )
        {
            weaponref = "equip_claymore";
        }
        else if ( issubstr( target.weapon_name, "c4" ) )
        {
            weaponref = "equip_c4";
        }
        else if ( issubstr( target.weapon_name, "atMine" ) )
        {
            weaponref = "equip_at_mine";
        }
        else if ( issubstr( target.weapon_name, "trophy" ) )
        {
            weaponref = "equip_trophy";
        }
        
        if ( isdefined( weaponref ) )
        {
            equipinfo = undefined;
            
            if ( utility::issharedfuncdefined( #"equipment", #"hash_3187f585d2de7de7" ) )
            {
                equipinfo = [[ utility::getsharedfunc( #"equipment", #"hash_3187f585d2de7de7" ) ]]( weaponref );
            }
            
            weaponicon = equipinfo.image;
        }
    }
    else if ( isdefined( target.streakinfo ) )
    {
        streakref = target.streakinfo.streakname;
        streakbundle = level.streakglobals.streakbundles[ streakref ];
        weaponicon = isdefined( streakbundle ) && isdefined( streakbundle.overheadicon ) ? streakbundle.overheadicon : "";
        weaponoffset = 75;
    }
    
    weaponstruct.weaponicon = weaponicon;
    weaponstruct.weaponoffset = weaponoffset;
    return weaponstruct;
}

// Namespace recon_drone
// Params 1
// Checksum 0xca6e2db0, Offset: 0x41ff
// Size: 0x8e
function function_88952d70abec2f91( markdata )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_27f725feb4b40f2d( markdata, player );
    }
}

// Namespace recon_drone
// Params 2
// Checksum 0x6695d7cb, Offset: 0x4295
// Size: 0x10f
function function_27f725feb4b40f2d( markdata, player )
{
    isfriendly = player_utility::isfriendly( markdata.ownerteam, player );
    
    if ( !level.teambased )
    {
        if ( markdata.owner == player )
        {
            isfriendly = 1;
        }
    }
    
    isowner = isdefined( markdata.markingent ) && player == markdata.markingent.owner;
    ispiloted = isdefined( markdata.markingent ) && markdata.markingent.ispiloted;
    ispilot = isowner && ispiloted;
    
    if ( isdefined( markdata.headicon ) )
    {
        if ( isfriendly && !ispilot )
        {
            entityheadicons::setheadicon_addclienttomask( markdata.headicon, player );
            return;
        }
        
        entityheadicons::setheadicon_removeclientfrommask( markdata.headicon, player );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x6ed231af, Offset: 0x43ac
// Size: 0x182
function function_19e4b75067119bdc( markdata )
{
    entityheadicons::setheadicon_deleteicon( markdata.headicon );
    
    if ( isdefined( markdata.target ) )
    {
        markdata.reconmarked = undefined;
        markdata.beingmarked = undefined;
        function_84e271a577fb97cc( 1, markdata.targetnum, markdata.ownerteam, 0 );
        
        if ( isdefined( self ) )
        {
            self.enemiesmarked[ markdata.targetnum ] = undefined;
        }
        
        if ( isplayer( markdata.target ) && 0 )
        {
            if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
            {
                [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( markdata.outlineid, markdata.target );
            }
            
            if ( utility::issharedfuncdefined( #"outline", #"hash_ce25f2d2639fdd76" ) )
            {
                markdata.target [[ utility::getsharedfunc( #"outline", #"hash_ce25f2d2639fdd76" ) ]]();
            }
        }
        
        if ( isdefined( self ) && isdefined( self.targetmarkergroup ) )
        {
            targetmarkergroups::targetmarkergroup_unmarkentity( markdata.target, self.targetmarkergroup );
        }
        
        markdata.target notify( markdata.notifytoendmark );
        return;
    }
    
    if ( self )
    {
        self.enemiesmarked[ markdata.targetnum ] = undefined;
    }
}

// Namespace recon_drone
// Params 0
// Checksum 0x25a5d847, Offset: 0x4536
// Size: 0x1cd
function recondrone_exit()
{
    if ( self.repeatuse && !self.nosuper )
    {
        self.owner player_utility::stopwatchingthermalinputchange();
        self.owner common_item::function_b03dfc0306cdc37();
        self.owner setclientomnvar( "ui_block_fu_not_ready_error", 1 );
        self notify( #"switch_modes" );
        
        if ( isdefined( self.targetmarkergroup ) )
        {
            targetmarkergroups::targetmarkergroup_off( self.targetmarkergroup );
            self.targetmarkergroup = undefined;
        }
        
        if ( emp_debuff::is_empd() )
        {
            helper_drone::function_f3897bba9c46b35f( 0 );
        }
        
        killstreak_utility::function_82efbf260da9f6f();
        recondrone_returnplayer( self.owner );
        
        if ( isdefined( self.owner.super ) && isdefined( self.owner.super.staticdata ) && isdefined( self.owner.super.staticdata.id ) )
        {
            self.owner setclientomnvar( "ui_field_upgrade_use", self.owner.super.staticdata.id );
        }
        
        if ( self getscriptableparthasstate( "engine_sfx", "npc_sfx" ) )
        {
            self setscriptablepartstate( "engine_sfx", "npc_sfx", 1 );
        }
        
        self.owner clearsoundsubmix( "mp_recon_drone", 0.2 );
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            thread recondrone_resetpos( self.origin );
        }
        
        return;
    }
    
    thread recondrone_leave();
}

// Namespace recon_drone
// Params 1
// Checksum 0x29a3d4fb, Offset: 0x470b
// Size: 0x12a
function recondrone_resetpos( var_1d9891be8ab55a12 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self.owner endon( #"dronestart" );
    wait 0.05;
    recondronesettings = level.helperdronesettings[ self.helperdronetype ];
    autospeed = recondronesettings.speed * 0.5;
    autoaccel = recondronesettings.accel * 2;
    autodecel = autoaccel * 0.5;
    self vehicle_setspeed( autospeed, autoaccel, autodecel );
    self sethoverparams( 1, 5, 5 );
    self setvehgoalpos( var_1d9891be8ab55a12, 1 );
    self waittill( #"goal" );
    var_879d6f3b2b3146cd = 200;
    var_cd46785a36fec111 = var_879d6f3b2b3146cd * var_879d6f3b2b3146cd;
    
    while ( true )
    {
        if ( distancesquared( self.origin, var_1d9891be8ab55a12 ) >= var_cd46785a36fec111 )
        {
            self setvehgoalpos( var_1d9891be8ab55a12, 1 );
            self waittill( #"goal" );
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x7a730d10, Offset: 0x483d
// Size: 0x42
function recondrone_onvehicledeath( config )
{
    self setscriptablepartstate( "body_damage_heavy", "on", 0 );
    msg = utility::waittill_notify_or_timeout_return( "collision", 0.5 );
    function_92b1d5858bf6f8de( config );
}

// Namespace recon_drone
// Params 1
// Checksum 0x53914f6d, Offset: 0x4888
// Size: 0x2a
function function_92b1d5858bf6f8de( config )
{
    self setscriptablepartstate( "hide_body", "on", 0 );
    helper_drone::function_e44894e06827a3a9();
    wait 0.25;
}

// Namespace recon_drone
// Params 1
// Checksum 0x92cff244, Offset: 0x48bb
// Size: 0x18
function recondrone_leave( timeout )
{
    thread helper_drone::helperdrone_explode( 0, 1, timeout );
}

// Namespace recon_drone
// Params 7
// Checksum 0x5813475c, Offset: 0x48db
// Size: 0x287
function recondrone_explode( config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson, damagedata )
{
    if ( utility::issharedfuncdefined( #"game", #"clearoob" ) )
    {
        [[ utility::getsharedfunc( #"game", #"clearoob" ) ]]( self, 1 );
    }
    
    if ( isdefined( self.container ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self.container );
        
        foreach ( item in self.container.contents )
        {
            if ( item.lootid )
            {
                itembundle = common_item::function_b202b16941992cca( item.lootid );
                common_item::function_61c2c0251e742ffd( itembundle, item.quantity, spawnoptions );
            }
        }
    }
    
    self.blockmark = undefined;
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    emp_debuff::clear_emp( 1 );
    
    if ( self.ispiloted )
    {
        recondrone_returnplayer( self.owner );
    }
    
    if ( isdefined( self.owner ) && isdefined( self.owner.super ) )
    {
        self.owner setclientomnvar( "ui_block_fu_not_ready_error", 0 );
        self.owner setclientomnvar( "ui_field_upgrade_use", 0 );
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #equipref:"equip_recondrone", #ent:self, #owner:self.owner } );
    
    if ( config.var_17e473e12ced7138 )
    {
        self setscriptablepartstate( "lights", "off", 0 );
        self vehphys_enablecollisioncallback( 1 );
        self.iscrashing = 1;
        self vehphys_crash();
        return;
    }
    
    helper_drone::function_e44894e06827a3a9();
}

// Namespace recon_drone
// Params 1
// Checksum 0xca56564c, Offset: 0x4b6a
// Size: 0x2f9
function recondrone_returnplayer( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player val::group_reset( "reconDrone_deploy" );
    
    if ( self.var_73cce24380743112 )
    {
        self thread [[ self.var_73cce24380743112 ]]( self, 1 );
    }
    
    dronetype = self.helperdronetype;
    config = level.helperdronesettings[ dronetype ];
    self.ispiloted = 0;
    
    if ( utility::issharedfuncdefined( #"supers", #"setsuperisactive" ) && !self.nosuper )
    {
        self.owner thread [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 0 );
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    if ( isdefined( self.enemiesmarked ) )
    {
        foreach ( markdata in self.enemiesmarked )
        {
            function_27f725feb4b40f2d( markdata, player );
        }
    }
    
    tabletweapon = "ks_remote_drone_mp";
    
    if ( self.var_99e2d83f9d0b250a )
    {
        tabletweapon = "ks_remote_device_mp";
    }
    
    player thread recondrone_takedeployweapon( 1, tabletweapon );
    player helper_drone::helperdrone_takeplayerfauxremote( self.streakinfo );
    player painvisionon();
    
    if ( config.var_30e7bbc9ee1bd839 && config.colorpbg )
    {
        pbgpostfxbundleend( player, config.colorpbg );
    }
    else
    {
        player killstreak_utility::killstreak_setmainvision( "" );
    }
    
    if ( self.isthermalenabled )
    {
        player player_utility::setthermalvision( 0 );
    }
    
    player thread helper_drone::function_ab65cb511ffc8807();
    
    if ( !config.var_17e473e12ced7138 )
    {
        player cameraunlink();
        player player::_freezecontrols( 0, 1, "reconDrone" );
        player player::_freezelookcontrols( 0, 1 );
        player val::group_reset( "reconDrone_use" );
    }
    
    if ( !self.haywiredeath )
    {
        if ( config.var_17e473e12ced7138 )
        {
            player leavevehicle( 0 );
        }
        else
        {
            player remotecontrolvehicleoff();
        }
    }
    
    player val::group_reset( "reconDrone_switch" );
    self.owner common_item::function_b03dfc0306cdc37();
    player render_utility::function_7d5ac95f0cd3294a();
    killstreak_utility::movingplatform_playerunlink( player );
    
    if ( player::isreallyalive( player ) && isdefined( player.restoreangles ) )
    {
        player setplayerangles( ( player.restoreangles[ 0 ], player.restoreangles[ 1 ], 0 ) );
    }
    
    player.restoreangles = undefined;
    player killstreak_shared::killstreak_restorenvgstate();
}

// Namespace recon_drone
// Params 1
// Checksum 0xda68e54f, Offset: 0x4e6b
// Size: 0x2d
function recon_drone_dmz_mission_used( droneentity )
{
    droneentity.nosuper = 1;
    thread recon_drone_used( droneentity, "recon_drone_dmz_mission", "super_recon_drone_dmz_mission" );
}

// Namespace recon_drone
// Params 3
// Checksum 0x1a1677e4, Offset: 0x4ea0
// Size: 0x319
function recon_drone_used( droneentity, streakname = "radar_drone_recon", supername = "super_recon_drone" )
{
    forward = anglestoforward( self getplayerangles() ) * getdvarint( @"hash_501a58001996afaf", 200 );
    upvelocity = getdvarint( @"hash_1134c17dc93bd4a5", 180 );
    velocity = self getvelocity() + forward + ( 0, 0, upvelocity );
    var_715897adf964bd99 = getdvarfloat( @"scr_recon_drone_move_time", 0 );
    wait var_715897adf964bd99;
    
    if ( getdvarint( @"hash_91d9d9cd261c02dc", 0 ) == 1 )
    {
        return;
    }
    
    thread function_f532fca6dd33c285( droneentity );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    success = 0;
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    streakinfo.issuper = 1;
    streakinfo.superid = level.superglobals.staticsuperdata[ supername ?? "super_recon_drone" ].id;
    streakinfo.superref = level.superglobals.staticsuperdata[ supername ?? "super_recon_drone" ].ref;
    val::group_set( "reconDrone_deploy", 0 );
    explodedata = function_ed0d6a08a44478aa( droneentity );
    spawndata = function_f3ac06b9127affd9( explodedata, streakname );
    velocity *= getdvarfloat( @"hash_3b3975617ba25768", 1 );
    
    if ( !isdefined( spawndata ) || self.isinsideelevator || train_utility::player_standing_on_train() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        success = 0;
    }
    else if ( !function_3efdf5bbd83ef068( streakinfo, 1 ) )
    {
        thread recondrone_watchcleanupreserved( streakinfo, 0 );
        
        if ( vehicle_tracking::reserve_vehicle() )
        {
            self.reconvehiclereserved = 1;
            var_cf2b4c1b2e7d9885 = spawndata;
            challenges::function_4fd386d590e901d8( var_cf2b4c1b2e7d9885, #"hash_c50cf868c6994df3", #"use" );
            challengeparams = { #fieldupgraderef:"super_recon_drone", #fieldupgradeent:var_cf2b4c1b2e7d9885, #fieldupgradeowner:var_cf2b4c1b2e7d9885.owner };
            callback::callback( #"hash_2af4adf11224c49a", challengeparams );
            thread recondrone_watchcleanupreserved( streakinfo, 1 );
            thread recondrone_deploysuccess( streakinfo, spawndata, velocity );
            success = 1;
        }
        else
        {
            thread recondrone_cleanupreserved( streakinfo, 0 );
        }
    }
    
    if ( !success )
    {
        if ( !spawndata.nosuper )
        {
            supers_mp::refundsuper();
        }
        
        val::group_reset( "reconDrone_deploy" );
        
        if ( isdefined( droneentity ) )
        {
            thread recondrone_deployfail( droneentity );
        }
    }
}

// Namespace recon_drone
// Params 4, eflags: 0x4
// Checksum 0x9f06f594, Offset: 0x51c1
// Size: 0xfd
function private function_a35607bea26772ee( oldstruct, origin, skipvelocity, newstruct = {} )
{
    newstruct.origin = origin;
    newstruct.angles = oldstruct.angles;
    
    if ( !skipvelocity )
    {
        newstruct.velocity = oldstruct.velocity;
    }
    
    newstruct.var_dd760a4d42dd5369 = oldstruct.var_dd760a4d42dd5369;
    newstruct.nosuper = oldstruct.nosuper;
    newstruct.var_513996341b409991 = oldstruct.var_513996341b409991;
    newstruct.var_83f598b130c2ce49 = oldstruct.var_83f598b130c2ce49;
    newstruct.var_c247804f6ab05021 = oldstruct.var_c247804f6ab05021;
    newstruct.owner = oldstruct.owner;
    return newstruct;
}

// Namespace recon_drone
// Params 2
// Checksum 0x547d2f72, Offset: 0x52c7
// Size: 0x41b
function function_f3ac06b9127affd9( explodedata, streakname )
{
    droneconfig = level.helperdronesettings[ streakname ?? "radar_drone_recon" ] ?? level.helperdronesettings[ "radar_drone_recon" ];
    explodedata.angles = self.angles;
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    ignorearray = [ self ];
    position = explodedata.origin;
    var_79d1e5a09c003853 = position - utility::function_f02ebab438642e16();
    fwddir = utility::flatten_vector( var_79d1e5a09c003853 );
    projdist = vectordot( var_79d1e5a09c003853, fwddir );
    extradist = 0;
    
    if ( projdist < droneconfig.spawndist )
    {
        extradist = droneconfig.spawndist - projdist;
    }
    
    traceforward = trace::ray_trace( position, position + fwddir * extradist, ignorearray, contents );
    
    /#
        if ( droneconfig.var_5656d6269df25e83 )
        {
            level thread debug_utility::drawangles( position, explodedata.angles, 30, 4 );
        }
    #/
    
    if ( traceforward[ "hittype" ] != "hittype_none" )
    {
        /#
            if ( droneconfig.var_5656d6269df25e83 )
            {
                level thread debug_utility::drawsphere( traceforward[ "<dev string:x127>" ], 2, 30, ( 1, 0, 0 ) );
            }
        #/
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return;
    }
    
    orientation = vectortoangles( fwddir );
    leftdir = anglestoleft( orientation );
    rightdir = anglestoright( orientation );
    updir = anglestoup( orientation );
    downdir = anglestoup( orientation ) * -1;
    var_6f46dab7eea7751d = vectornormalize( updir + leftdir );
    uprightdir = vectornormalize( updir + rightdir );
    var_c657b7b0fb4483b3 = vectornormalize( downdir + rightdir );
    var_eea16f3afe0a8852 = vectornormalize( downdir + leftdir );
    oppositedir = vectornormalize( explodedata.velocity ) * -2;
    dirvecs = [ updir, var_6f46dab7eea7751d, uprightdir, oppositedir, leftdir, rightdir, var_c657b7b0fb4483b3, var_eea16f3afe0a8852, downdir ];
    var_53d03402676acb78 = trace::sphere_trace_passed( position, position, 14, ignorearray, contents );
    
    if ( var_53d03402676acb78 )
    {
        return function_a35607bea26772ee( explodedata, position );
    }
    
    var_4508c55eab7eed9c = 26.775;
    saferadius = 8.925;
    
    foreach ( dirvec in dirvecs )
    {
        startpos = position;
        endpos = startpos + dirvec * var_4508c55eab7eed9c;
        trace = trace::ray_trace( startpos, endpos, ignorearray, contents );
        var_b4e8bc115cca4840 = trace[ "position" ];
        enoughspace = trace::sphere_trace_passed( var_b4e8bc115cca4840, var_b4e8bc115cca4840, saferadius, ignorearray, contents );
        
        /#
            level thread debug_utility::drawsphere( var_b4e8bc115cca4840, saferadius, 2, enoughspace ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
        #/
        
        if ( enoughspace )
        {
            return function_a35607bea26772ee( explodedata, var_b4e8bc115cca4840 );
        }
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x68adb07f, Offset: 0x56ea
// Size: 0x8a
function function_ed0d6a08a44478aa( droneentity )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    explodedata = spawnstruct();
    childthread function_de0dfd2336e6bd2e( explodedata, droneentity );
    explodetime = getdvarfloat( @"hash_a58f7787fb9e6db8", 0.1 );
    wait explodetime;
    function_a35607bea26772ee( droneentity, droneentity.origin, 1, explodedata );
    self notify( #"hash_8e856665b5d426a4" );
    droneentity delete();
    return explodedata;
}

// Namespace recon_drone
// Params 2
// Checksum 0xc0615e60, Offset: 0x577d
// Size: 0xe4
function function_de0dfd2336e6bd2e( explodedata, droneentity )
{
    self endon( #"hash_8e856665b5d426a4" );
    explodedata.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !( isdefined( droneentity ) && isdefined( droneentity.origin ) ) )
        {
            return;
        }
        
        if ( !isdefined( explodedata.lastorigin ) )
        {
            explodedata.lastorigin = droneentity.origin;
        }
        
        if ( explodedata.lastorigin != droneentity.origin )
        {
            explodedata.velocity = ( droneentity.origin - explodedata.lastorigin ) / level.framedurationseconds;
            explodedata.lastorigin = droneentity.origin;
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xdd48b4a2, Offset: 0x5869
// Size: 0x3d
function function_f532fca6dd33c285( droneentity )
{
    level endon( #"game_ended" );
    droneentity endon( #"death" );
    utility::waittill_any( "death_or_disconnect", "failed_recon_deployment" );
    droneentity delete();
}

// Namespace recon_drone
// Params 0
// Checksum 0x220dad24, Offset: 0x58ae
// Size: 0x1ed, Type: bool
function recondrone_beginsuper()
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    streakinfo = spawnstruct();
    streakinfo.streakname = "radar_drone_recon";
    streakinfo.weaponname = "ks_remote_drone_mp";
    streakinfo.issuper = 1;
    streakinfo.superid = level.superglobals.staticsuperdata[ "super_recon_drone" ].id;
    streakinfo.superref = level.superglobals.staticsuperdata[ "super_recon_drone" ].ref;
    
    if ( isbrgamemode() )
    {
        streakinfo.var_9384480e6997afd7 = 1;
    }
    
    childthread helper_drone::function_a5f95568df49cf66( streakinfo.streakname );
    
    if ( !isdefined( self.recondronesafespawn ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    if ( !helper_drone::tryusehelperdroneearlyout( streakinfo, 1 ) )
    {
        self.recondronereserved = 1;
        thread recondrone_watchcleanupreserved( streakinfo, 0 );
        
        if ( vehicle_tracking::reserve_vehicle() )
        {
            self.reconvehiclereserved = 1;
            thread recondrone_watchcleanupreserved( streakinfo, 1 );
            
            if ( recondrone_givedeployweapon( "ks_remote_drone_mp" ) )
            {
                thread recondrone_watchsuper( streakinfo );
                challenges::function_a0936b0e5b4550f3( "super_recon_drone", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
                return true;
            }
            else
            {
                val::group_reset( "reconDrone_switch" );
                thread recondrone_takedeployweapon( 1, "ks_remote_drone_mp" );
                thread recondrone_cleanupreserved( streakinfo, 1 );
            }
        }
        else
        {
            thread recondrone_cleanupreserved( streakinfo, 0 );
        }
    }
    
    return false;
}

// Namespace recon_drone
// Params 2
// Checksum 0x81a8fb71, Offset: 0x5aa4
// Size: 0xe8, Type: bool
function function_3efdf5bbd83ef068( streakinfo, showerror )
{
    if ( utility::isusingremote() )
    {
        return true;
    }
    
    if ( self.drones_disabled )
    {
        if ( showerror )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/unavailable" );
            }
        }
        
        return true;
    }
    
    var_5348e955fb6f2aa5 = helper_drone::function_82d83598f8412a9d( streakinfo, showerror );
    
    if ( !var_5348e955fb6f2aa5 )
    {
        return true;
    }
    
    var_ae9e5bcd4df7ca7 = helper_drone::function_522905ceb07e70e0( streakinfo, showerror );
    
    if ( !var_ae9e5bcd4df7ca7 )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]( 1 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace recon_drone
// Params 2
// Checksum 0xd19e048d, Offset: 0x5b95
// Size: 0x144
function recondrone_endsuper( fromdeath, attacker )
{
    self notify( #"recondroneended" );
    self.recondronesafespawn = undefined;
    headiconid = self.recondronesuper.streakinfo.headiconid;
    
    if ( isdefined( headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( headiconid );
    }
    
    if ( isdefined( self.recondronerefund ) )
    {
        self.recondronerefund = undefined;
        
        if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) && utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) )
        {
            self [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]() );
        }
    }
    
    if ( isdefined( self.recondronereserved ) )
    {
        self.recondronereserved = undefined;
        streakinfo = spawnstruct();
        streakinfo.streakname = "radar_drone_recon";
        recondrone_cleanupreserved( streakinfo );
    }
    
    if ( isdefined( self.reconvehiclereserved ) )
    {
        self.reconvehiclereserved = undefined;
        vehicle_tracking::function_4f76f5b4541acef1();
    }
}

// Namespace recon_drone
// Params 3
// Checksum 0x9d91b74c, Offset: 0x5ce1
// Size: 0xf6
function recondrone_deploysuccess( streakinfo, spawndata, startingvelocity )
{
    self endon( #"disconnect" );
    result = recondrone_deployinternal( streakinfo, spawndata, startingvelocity );
    
    if ( !result )
    {
        val::group_reset( "reconDrone_switch" );
        val::group_reset( "reconDrone_deploy" );
        
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 1 );
        }
        
        return;
    }
    
    if ( !level.helperdronesettings[ streakinfo.streakname ].repeatuse && utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0 );
    }
}

// Namespace recon_drone
// Params 3
// Checksum 0x60f4be39, Offset: 0x5ddf
// Size: 0x348, Type: bool
function recondrone_deployinternal( streakinfo, spawndata, startingvelocity )
{
    self endon( #"death" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    
    if ( utility::issharedfuncdefined( #"recondrone", #"hash_66946d6fe4c28180" ) )
    {
        self [[ utility::getsharedfunc( #"recondrone", #"hash_66946d6fe4c28180" ) ]]();
    }
    
    config = level.helperdronesettings[ streakinfo.streakname ];
    
    if ( !config.var_17e473e12ced7138 )
    {
        player::_freezecontrols( 1, undefined, "reconDrone" );
    }
    
    isinlaststand = player::isinlaststand( self );
    
    if ( isdefined( spawndata ) && !isinlaststand && !swim_common::isplayerunderwater() )
    {
        self.reconvehiclereserved = undefined;
        thread recondrone_watchcleanupreserved( streakinfo, 0 );
        recondrone = recondrone_create( spawndata.origin, spawndata.angles, streakinfo.streakname, streakinfo, startingvelocity );
        recondrone.nosuper = spawndata.nosuper;
        recondrone.var_513996341b409991 = spawndata.var_513996341b409991;
        recondrone.var_83f598b130c2ce49 = spawndata.var_83f598b130c2ce49;
        recondrone.var_c247804f6ab05021 = spawndata.var_c247804f6ab05021;
        
        if ( isdefined( recondrone ) )
        {
            recondrone.var_4b70483c15214db8 = 1;
            thread helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
            utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", recondrone, &function_52ef4af6e1bf6ef2, &function_2825613e791fef04 );
            recondrone recondrone_addtolists( recondrone, self );
            helper_drone::function_bc4c01fe510bb495( streakinfo );
            thread helper_drone::starthelperdrone( recondrone );
            thread recondrone_givedeployweapon( "ks_remote_drone_mp", recondrone, 1, 1 );
            battlechatter_mp::playkillstreakdeploydialog( streakinfo.streakname );
            
            if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_e360b168744d9b7 )
            {
                recondrone vehicleshowonminimap( 0 );
            }
            
            killstreak_utility::playkillstreakusedialog( streakinfo.streakname );
            recondrone helper_drone::helperdrone_notifyenemyplayersinrange( streakinfo.streakname );
            self notify( #"hash_e18b63d1eac1331b" );
            return true;
        }
        else
        {
            if ( !config.var_17e473e12ced7138 )
            {
                player::_freezecontrols( 0, 1, "reconDrone" );
                helper_drone::helperdronecreationfailedfx( streakinfo.streakname );
            }
            else
            {
                thread recondrone_deployfail( spawndata.var_dd760a4d42dd5369 );
            }
            
            return false;
        }
    }
    else if ( !config.var_17e473e12ced7138 )
    {
        helper_drone::helperdronecreationfailedfx( streakinfo.streakname );
        player::_freezecontrols( 0, 1, "reconDrone" );
    }
    else
    {
        thread recondrone_deployfail( spawndata.var_dd760a4d42dd5369 );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
    }
    
    self notify( #"failed_recon_deployment" );
    return false;
}

// Namespace recon_drone
// Params 1
// Checksum 0x17357857, Offset: 0x6130
// Size: 0x3d
function recondrone_deployfail( var_dd760a4d42dd5369 )
{
    level endon( #"game_ended" );
    var_dd760a4d42dd5369 setscriptablepartstate( "exit", "on", 0 );
    wait 0.25;
    
    if ( isdefined( var_dd760a4d42dd5369 ) )
    {
        var_dd760a4d42dd5369 delete();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xc41df6f3, Offset: 0x6175
// Size: 0xf0
function recondrone_watchsuper( streakinfo )
{
    self endon( #"disconnect" );
    result = recondrone_watchsuperinternal( streakinfo );
    
    if ( !result )
    {
        val::group_reset( "reconDrone_switch" );
        val::group_reset( "reconDrone_deploy" );
        thread recondrone_takedeployweapon( 1, "ks_remote_drone_mp" );
        
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 1 );
        }
        
        return;
    }
    
    if ( !level.helperdronesettings[ streakinfo.streakname ].repeatuse && utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0 );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xc0a65de1, Offset: 0x626d
// Size: 0x2d7, Type: bool
function recondrone_watchsuperinternal( streakinfo )
{
    self endon( #"death" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    thread recondrone_watchsuperendfromswitch();
    
    if ( utility::issharedfuncdefined( #"recondrone", #"hash_66946d6fe4c28180" ) )
    {
        self [[ utility::getsharedfunc( #"recondrone", #"hash_66946d6fe4c28180" ) ]]();
    }
    
    val::group_set( "reconDrone_deploy", 0 );
    config = level.helperdronesettings[ streakinfo.streakname ];
    
    if ( !config.var_17e473e12ced7138 )
    {
        player::_freezecontrols( 1, undefined, "reconDrone" );
    }
    
    wait 1.85;
    childthread helper_drone::function_a5f95568df49cf66( streakinfo.streakname );
    wait 0.15;
    
    if ( level.gameended )
    {
        self.recondronesafespawn = undefined;
    }
    
    isinlaststand = player::isinlaststand( self );
    
    if ( isdefined( self.recondronesafespawn ) && !isinlaststand )
    {
        self.reconvehiclereserved = undefined;
        thread recondrone_watchcleanupreserved( streakinfo, 0 );
        recondrone = recondrone_create( self.recondronesafespawn, self.angles, streakinfo.streakname, streakinfo );
        self.recondronesafespawn = undefined;
        
        if ( isdefined( recondrone ) )
        {
            thread helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
            utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", recondrone, &function_52ef4af6e1bf6ef2, &function_2825613e791fef04 );
            recondrone recondrone_addtolists( recondrone, self );
            helper_drone::function_bc4c01fe510bb495( streakinfo );
            thread helper_drone::starthelperdrone( recondrone );
            battlechatter_mp::playkillstreakdeploydialog( streakinfo.streakname );
            
            if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_e360b168744d9b7 )
            {
                recondrone vehicleshowonminimap( 0 );
            }
            
            killstreak_utility::playkillstreakusedialog( streakinfo.streakname );
            recondrone helper_drone::helperdrone_notifyenemyplayersinrange( streakinfo.streakname );
            self notify( #"hash_e18b63d1eac1331b" );
            return true;
        }
        else
        {
            if ( !config.var_17e473e12ced7138 )
            {
                player::_freezecontrols( 0, 1, "reconDrone" );
            }
            
            helper_drone::helperdronecreationfailedfx( streakinfo.streakname );
        }
    }
    else
    {
        helper_drone::helperdronecreationfailedfx( streakinfo.streakname );
        
        if ( !config.var_17e473e12ced7138 )
        {
            player::_freezecontrols( 0, 1, "reconDrone" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
    }
    
    self notify( #"failed_recon_deployment" );
    return false;
}

// Namespace recon_drone
// Params 0
// Checksum 0xe9b74f1b, Offset: 0x654d
// Size: 0x5e
function recondrone_watchsuperendfromswitch()
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    self endon( #"hash_1fcdd36a32f9f0a" );
    objweapon = makeweapon( "ks_remote_drone_mp" );
    
    while ( true )
    {
        if ( self getcurrentweapon() != objweapon )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x74eb20c6, Offset: 0x65b3
// Size: 0x59
function recondrone_unsetsuper( fromdeath )
{
    self notify( #"recondroneunset" );
    
    if ( true )
    {
        recondrone = self.recondronesuper;
        
        if ( isdefined( recondrone ) )
        {
            if ( !recondrone.isdestroyed )
            {
                recondrone helper_drone::helperdrone_handledeathdamage();
            }
        }
    }
    
    thread recondrone_endsuper( fromdeath );
}

// Namespace recon_drone
// Params 4
// Checksum 0x7d2614a6, Offset: 0x6614
// Size: 0x12b
function recondrone_givedeployweapon( deployweaponname, existingdrone, switchimmediate, var_e90b0e794aa74425 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneweapontaken" );
    self endon( #"redeploy_drone_use" );
    self notify( #"recondroneweapongiven" );
    self endon( #"recondroneweapongiven" );
    objweapon = makeweapon( deployweaponname );
    
    if ( !self hasweapon( objweapon ) && objweapon.basename != "none" )
    {
        inventory_utility::_giveweapon( objweapon );
    }
    
    config = level.helperdronesettings[ existingdrone.helperdronetype ];
    
    if ( !config.var_17e473e12ced7138 )
    {
        val::group_set( "reconDrone_switch", 0 );
    }
    
    thread function_b2610e2cf4508a59( "melee_swipe_start", objweapon );
    thread function_b2610e2cf4508a59( "weapon_change", objweapon );
    thread function_b2610e2cf4508a59( "player_isHaywire", objweapon );
    
    if ( isdefined( existingdrone ) )
    {
        thread function_a16f57aeb68a4e3d( existingdrone, objweapon );
    }
    
    result = inventory_utility::domonitoredweaponswitch( objweapon, switchimmediate, var_e90b0e794aa74425, 1 );
    return result;
}

// Namespace recon_drone
// Params 2
// Checksum 0x49e07e0b, Offset: 0x6748
// Size: 0x6b
function function_b2610e2cf4508a59( actionnotify, deployweapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"recon_drone_cancel" );
    self endon( #"dronestart" );
    level endon( #"game_ended" );
    self waittill( actionnotify );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweapon ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweapon );
    }
    
    self notify( #"recon_drone_cancel" );
}

// Namespace recon_drone
// Params 2
// Checksum 0xf4fafebe, Offset: 0x67bb
// Size: 0xbe
function function_a16f57aeb68a4e3d( drone, deployweapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"recon_drone_cancel" );
    self endon( #"dronestart" );
    level endon( #"game_ended" );
    drone utility::waittill_any( "death", "explode" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweapon ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweapon );
    }
    
    config = level.helperdronesettings[ drone.helperdronetype ];
    
    if ( !config.var_17e473e12ced7138 )
    {
        player::_freezelookcontrols( 0, 1 );
    }
    
    val::group_reset( "reconDrone_switch" );
    self notify( #"recon_drone_cancel" );
}

// Namespace recon_drone
// Params 2
// Checksum 0xa30178c1, Offset: 0x6881
// Size: 0x94
function recondrone_takedeployweapon( forceremove, deployweaponname )
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneweapongiven" );
    self notify( #"recondroneweapontaken" );
    self endon( #"recondroneweapontaken" );
    
    if ( !isdefined( deployweaponname ) )
    {
        return 0;
    }
    
    objweapon = makeweapon( deployweaponname );
    
    if ( forceremove )
    {
        if ( inventory_utility::isswitchingtoweaponwithmonitoring( objweapon ) )
        {
            inventory_utility::abortmonitoredweaponswitch( objweapon );
            return;
        }
    }
    
    if ( forceremove )
    {
        inventory_utility::getridofweapon( objweapon );
    }
    
    val::group_reset( "reconDrone_switch" );
}

// Namespace recon_drone
// Params 2
// Checksum 0x1ef3fc04, Offset: 0x691d
// Size: 0x44
function recondrone_watchcleanupreserved( streakinfo, vehiclereserved )
{
    self notify( #"hash_3e4b8cfe7f13a2ad" );
    self endon( #"hash_3e4b8cfe7f13a2ad" );
    self waittill( #"disconnect" );
    thread recondrone_cleanupreserved( streakinfo, vehiclereserved );
}

// Namespace recon_drone
// Params 2
// Checksum 0x25dfa18d, Offset: 0x6969
// Size: 0x84
function recondrone_cleanupreserved( streakinfo, vehiclereserved )
{
    self notify( #"hash_3e4b8cfe7f13a2ad" );
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]( 1 );
    }
    
    helper_drone::function_bc4c01fe510bb495( streakinfo );
    
    if ( vehiclereserved )
    {
        if ( self.reconvehiclereserved )
        {
            self.reconvehiclereserved = undefined;
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
    }
}

// Namespace recon_drone
// Params 2
// Checksum 0x6151359d, Offset: 0x69f5
// Size: 0x74
function recondrone_addtolists( drone, owner )
{
    owner.recondronesuper = drone;
    owner.pausesuperpointsovertime = 1;
    id = drone function_f7fe248d4f134ebe();
    
    if ( !isdefined( level.recondronesupers ) )
    {
        level.recondronesupers = [];
    }
    
    level.recondronesupers[ id ] = drone;
    thread recondrone_removefromlistsondeath( drone, owner, id );
}

// Namespace recon_drone
// Params 3
// Checksum 0x2bd189e2, Offset: 0x6a71
// Size: 0x72
function recondrone_removefromlists( drone, owner, id )
{
    if ( isdefined( drone ) )
    {
        drone notify( #"hash_71c2ac3c91763c28" );
        id = drone function_f7fe248d4f134ebe();
    }
    
    if ( isdefined( owner ) )
    {
        owner.recondronesuper = undefined;
        owner.pausesuperpointsovertime = 0;
    }
    
    if ( isdefined( level.recondronesupers ) )
    {
        level.recondronesupers[ id ] = undefined;
    }
}

// Namespace recon_drone
// Params 3
// Checksum 0xc5b097d8, Offset: 0x6aeb
// Size: 0x44
function recondrone_removefromlistsondeath( drone, owner, id )
{
    drone endon( #"hash_71c2ac3c91763c28" );
    drone waittill( #"death" );
    thread recondrone_removefromlists( drone, owner, id );
}

// Namespace recon_drone
// Params 0
// Checksum 0xcd473640, Offset: 0x6b37
// Size: 0xb
function function_488bc5e1a3cb4c23()
{
    return self.recondronesuper;
}

// Namespace recon_drone
// Params 0
// Checksum 0x8573801b, Offset: 0x6b4b
// Size: 0xbf, Type: bool
function recondrone_istargetmarked()
{
    if ( level.supportdrones.size > 0 )
    {
        foreach ( drone in level.supportdrones )
        {
            if ( player_utility::playersareenemies( self, drone.owner ) )
            {
                if ( isdefined( drone.enemiesmarked ) && isdefined( drone.enemiesmarked[ function_f7fe248d4f134ebe() ] ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace recon_drone
// Params 3
// Checksum 0x9c598e4b, Offset: 0x6c13
// Size: 0x151
function function_fe4d398293d70efc( scantarget, scanfov, var_aa7184ffa413de37 )
{
    inreticle = 0;
    defaultorigin = scantarget.origin;
    
    if ( isdefined( scantarget.recondronetraceoffset ) )
    {
        defaultorigin += scantarget.recondronetraceoffset;
    }
    
    pointstocheck = [ defaultorigin ];
    
    if ( isplayer( scantarget ) )
    {
        headpos = scantarget utility::function_f02ebab438642e16();
        centerpos = scantarget utility::function_68061c3d21a6d57a();
        pointstocheck = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( scantarget ) )
    {
        pointstocheck = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    foreach ( point in pointstocheck )
    {
        if ( self worldpointinreticle_circle( point, scanfov, var_aa7184ffa413de37 ) )
        {
            inreticle = 1;
            break;
        }
    }
    
    return inreticle;
}

// Namespace recon_drone
// Params 1
// Checksum 0xb8592324, Offset: 0x6d6d
// Size: 0x19c
function function_f21d4db944da7a2( potentialtarget )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( function_802932eaf45c70b1( self ) )
    {
        return 0;
    }
    
    if ( isplayer( potentialtarget ) )
    {
        if ( !player::isreallyalive( potentialtarget ) )
        {
            return 0;
        }
        
        if ( !config.var_beb5cf9815327759 )
        {
            if ( isdefined( potentialtarget.perks[ "specialty_noscopeoutline" ] ) )
            {
                return 0;
            }
        }
    }
    
    if ( isagent( potentialtarget ) )
    {
        if ( !isalive( potentialtarget ) )
        {
            return 0;
        }
        
        if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
        {
            return 0;
        }
    }
    
    if ( level.teambased )
    {
        if ( potentialtarget.team == self.team )
        {
            return 0;
        }
    }
    else
    {
        if ( isplayer( potentialtarget ) && potentialtarget == self.owner )
        {
            return 0;
        }
        
        if ( potentialtarget.owner == self.owner )
        {
            return 0;
        }
    }
    
    if ( !recondrone_isindetectrange( potentialtarget ) )
    {
        return 0;
    }
    
    if ( recondrone_ismarked( potentialtarget ) )
    {
        return 0;
    }
    
    if ( function_2de5f68835eaa77e( self, potentialtarget ) )
    {
        return 0;
    }
    
    if ( level.var_9ba524a5a23203ac )
    {
        var_e0c119446b0595b9 = helper_drone::helperdrone_canseetarget( potentialtarget );
        return var_e0c119446b0595b9;
    }
    
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( config.var_8882e489606fbd21 && !self.owner function_fe4d398293d70efc( potentialtarget, 70, 300 ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace recon_drone
// Params 1
// Checksum 0x1d2a48f1, Offset: 0x6f12
// Size: 0xc2, Type: bool
function function_481ac92b9a249bdf( potentialtarget )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( function_802932eaf45c70b1( self ) )
    {
        return false;
    }
    
    if ( isplayer( potentialtarget ) )
    {
        if ( !player::isreallyalive( potentialtarget ) )
        {
            return false;
        }
        
        if ( isdefined( potentialtarget.perks[ "specialty_noscopeoutline" ] ) )
        {
            return false;
        }
    }
    
    if ( isagent( potentialtarget ) )
    {
        if ( !isalive( potentialtarget ) )
        {
            return false;
        }
        
        if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
        {
            return false;
        }
    }
    
    if ( !helper_drone::helperdrone_canseetarget( potentialtarget, 1 ) )
    {
        return false;
    }
    
    if ( recondrone_ismarked( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace recon_drone
// Params 0
// Checksum 0x842e81f2, Offset: 0x6fdd
// Size: 0x40
function function_536b4910f7f91426()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "flash_glint", "on" );
    wait 0.3;
    self setscriptablepartstate( "flash_glint", "off" );
}

// Namespace recon_drone
// Params 1
// Checksum 0xd219160c, Offset: 0x7025
// Size: 0xa2
function recondrone_haywireapplied( data )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) && isdefined( data.inflictor ) && self.currenthealth > 0 )
    {
        self dodamage( self.maxhealth, self.origin, data.attacker, data.inflictor );
    }
}

// Namespace recon_drone
// Params 1, eflags: 0x4
// Checksum 0xb038bf91, Offset: 0x70cf
// Size: 0x18, Type: bool
function private function_802932eaf45c70b1( recondrone )
{
    return istrue( recondrone.blockmark );
}

// Namespace recon_drone
// Params 1, eflags: 0x4
// Checksum 0x5066791e, Offset: 0x70f0
// Size: 0x15
function private function_52ef4af6e1bf6ef2( recondrone )
{
    function_3665dc9d0b3420b5( recondrone );
}

// Namespace recon_drone
// Params 2, eflags: 0x4
// Checksum 0x596ad59, Offset: 0x710d
// Size: 0x1f
function private function_2825613e791fef04( recondrone, playercancel )
{
    function_3665dc9d0b3420b5( recondrone, playercancel );
}

// Namespace recon_drone
// Params 2
// Checksum 0x49fd95db, Offset: 0x7134
// Size: 0xfa
function function_3665dc9d0b3420b5( recondrone, playercancel )
{
    isemped = recondrone.empcount > 0;
    isjammed = istrue( recondrone.isjammed );
    var_251d8987261025ac = ( isemped || isjammed ) && !playercancel;
    
    if ( var_251d8987261025ac && !recondrone.isdisabled )
    {
        recondrone.isdisabled = 1;
        recondrone.blockmark = 1;
        recondrone_empstarted( recondrone );
        return;
    }
    
    if ( !var_251d8987261025ac && recondrone.isdisabled )
    {
        if ( !playercancel )
        {
            recondrone.blockmark = undefined;
        }
        
        recondrone.isdisabled = 0;
        recondrone_empcleared( recondrone );
        return;
    }
    
    if ( !playercancel && !recondrone.isdisabled )
    {
        recondrone.blockmark = undefined;
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xf896efe1, Offset: 0x7236
// Size: 0xae
function recondrone_empstarted( data )
{
    self setscriptablepartstate( "ddos", "disabled", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( self.ispiloted )
    {
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            self.owner player::_freezecontrols( 1 );
        }
        
        thread emp_debuff::play_scramble_for_player_until_cleared( self.owner, 5 );
        helper_drone::function_f3897bba9c46b35f( 1 );
        self.owner val::set( "recondrone_crash", "allow_movement", 0 );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xe1461016, Offset: 0x72ec
// Size: 0x7e
function recondrone_empapplied( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"disabled_recon_drone", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x94d7626a, Offset: 0x7372
// Size: 0xa6
function function_53fdbf1c2d9339df( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( self.akilo_empd ) )
    {
        self.akilo_empd = 0;
    }
    
    self.akilo_empd++;
    
    if ( self.akilo_empd >= 1 )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"disabled_recon_drone", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
        
        thread helper_drone::helperdrone_leave( 0 );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x3e6b4000, Offset: 0x7420
// Size: 0xa7
function recondrone_empcleared( isdeath )
{
    self setscriptablepartstate( "ddos", "neutral", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( self.ispiloted )
    {
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            self.owner player::_freezecontrols( 0 );
        }
        
        self notify( #"emp_cleared" );
        helper_drone::function_f3897bba9c46b35f( 0 );
        self.owner val::set( "turretdrone_crash", "allow_movement", 1 );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xa84a3dd5, Offset: 0x74cf
// Size: 0x93
function function_db9b1c92c85ca739( data )
{
    self setscriptablepartstate( "ddos", "disabled", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( self.ispiloted )
    {
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            self.owner player::_freezecontrols( 1 );
        }
        
        thread chaff_debuff::play_scramble_for_player_until_cleared( self.owner, 5 );
        helper_drone::function_f3897bba9c46b35f( 1 );
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0xf91eee08, Offset: 0x756a
// Size: 0x70
function function_b99f4377fc054089( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_recon_drone" );
        }
    }
}

// Namespace recon_drone
// Params 1
// Checksum 0x8b08c46d, Offset: 0x75e2
// Size: 0x7f
function function_2ae1776e2d374ba0( isdeath )
{
    self setscriptablepartstate( "ddos", "neutral", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( self.ispiloted )
    {
        config = level.helperdronesettings[ self.helperdronetype ];
        
        if ( !config.var_17e473e12ced7138 )
        {
            self.owner player::_freezecontrols( 0 );
        }
        
        helper_drone::function_f3897bba9c46b35f( 0 );
    }
}

// Namespace recon_drone
// Params 0
// Checksum 0xa58736b8, Offset: 0x7669
// Size: 0x226
function function_71ffb393cf1aee15()
{
    targetarray = [];
    contentoverride = trace::create_world_contents();
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( config.var_17e473e12ced7138 )
    {
        cameraorigin = self gettagorigin( "tag_driver_camera" );
    }
    else
    {
        cameraorigin = self.owner getvieworigin();
    }
    
    detectionorigin = cameraorigin + anglestoforward( self.owner getplayerangles() ) * 5000;
    ignoreents = [ self ];
    viewtrace = trace::ray_trace( cameraorigin, detectionorigin, ignoreents, contentoverride );
    
    if ( viewtrace[ "hittype" ] != "hittype_none" )
    {
        detectionorigin = viewtrace[ "position" ];
    }
    
    /#
        if ( getdvarint( @"scr_recon_drone_debug", 0 ) )
        {
            level thread debug_utility::drawline( cameraorigin, detectionorigin, 0.05, ( 1, 1, 1 ) );
            level thread debug_utility::drawsphere( detectionorigin, 50, 0.05, ( 1, 1, 1 ) );
        }
    #/
    
    if ( self.var_83f598b130c2ce49 )
    {
        switch ( self.var_83f598b130c2ce49 )
        {
            case #"hash_f22e325ccd2fb214":
                targetarray = vehicle_getarrayinradius( detectionorigin, 2500 );
                break;
            default:
                targetarray = utility::function_1b1340a94b43b874( detectionorigin, 2500 );
                break;
        }
    }
    else
    {
        targetarray = utility::function_1b1340a94b43b874( detectionorigin, 2500 );
    }
    
    if ( self.var_513996341b409991 )
    {
        foreach ( target in self.var_513996341b409991 )
        {
            if ( distancesquared( target.origin, detectionorigin ) <= 6.25e+06 )
            {
                targetarray[ targetarray.size ] = target;
            }
        }
    }
    
    return targetarray;
}

// Namespace recon_drone
// Params 0
// Checksum 0x48c3f0cc, Offset: 0x7898
// Size: 0x2a, Type: bool
function function_ec5bc8c2dd7b60b4()
{
    recondrone = self.recondronesuper;
    return isdefined( recondrone ) && !recondrone.isdestroyed;
}

// Namespace recon_drone
// Params 0, eflags: 0x4
// Checksum 0xdb621b75, Offset: 0x78cb
// Size: 0x82
function private function_f7fe248d4f134ebe()
{
    target = self;
    
    if ( isplayer( target ) || isagent( target ) )
    {
        return target getentitynumber();
    }
    
    if ( !target.dronekey )
    {
        if ( !isdefined( level.var_5e0fcddd5f1f9a93 ) )
        {
            level.var_5e0fcddd5f1f9a93 = 0;
        }
        
        target.dronekey = "drone_key_" + string( level.var_5e0fcddd5f1f9a93 );
        level.var_5e0fcddd5f1f9a93++;
    }
    
    return target.dronekey;
}

// Namespace recon_drone
// Params 0, eflags: 0x4
// Checksum 0xead8625d, Offset: 0x7956
// Size: 0x1b
function private function_d3ca5bf7385a2bcf()
{
    if ( isplayer( self ) || isagent( self ) )
    {
        return player_utility::isswimmingunderwater();
    }
    
    return 0;
}

// Namespace recon_drone
// Params 4, eflags: 0x4
// Checksum 0xbbf12638, Offset: 0x797a
// Size: 0x3d
function private function_84e271a577fb97cc( compassid, targetnum, ownerteam, markplayer )
{
    if ( !isint( targetnum ) )
    {
        return;
    }
    
    function_46225a4984a1bcc4( compassid, targetnum, ownerteam, markplayer );
}

/#

    // Namespace recon_drone
    // Params 0
    // Checksum 0x62f6545d, Offset: 0x79bf
    // Size: 0x90, Type: dev
    function function_7fdb1abda1c40d93()
    {
        setdevdvar( @"hash_60a091e2e6da3352", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_60a091e2e6da3352" ) != 0 )
            {
                setdevdvar( @"hash_60a091e2e6da3352", 0 );
                
                if ( level.players.size < 1 )
                {
                    iprintlnbold( "<dev string:x130>" );
                    continue;
                }
                
                firstplayer = level.players[ 0 ];
                firstplayer thread snapshot::function_23f4614f16363579();
                firstplayer snapshot::function_c802f1ac50040a2c();
                firstplayer playlocalsound( "<dev string:x16b>" );
            }
            
            waitframe();
        }
    }

#/
