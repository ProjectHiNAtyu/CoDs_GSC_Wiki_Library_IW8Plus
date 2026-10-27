// scripts\mp\common\killstreaks\rcxd_shared.gsc  (hash_071028291285363d.gscc) (size: 27902 Bytes / 0x6cfe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e0f6068 (1578066024)
// size ...... 27902 (0x6cfe)
// includes .. 16  (offset: 0x67ee)
// strings ... 60  (offset: 0x686e)
// dev strs .. 6   (offset: 0x6ca2)
// exports ... 58  (offset: 0x40ae)
// cseg ...... 0x479 + 0x3c35 (0x40ae)
// imports ... 255 (offset: 0x49be)
// animtree1 . 0   (offset: 0x6cfe)
// animtree2 . 0   (offset: 0x6cfe)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\killstreak_utility;

#namespace rcxd_shared;

// Namespace rcxd_shared
// Params 0, eflags: 0x1
// Checksum 0xe40a993e, Offset: 0x497
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "rcxd" ), &init );
}

// Namespace rcxd_shared
// Params 0, eflags: 0x4
// Checksum 0xcaece0bf, Offset: 0x4b6
// Size: 0x141
function private init()
{
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "rcxd", &function_bdbc99e904937454 );
    
    if ( level.projectbundle.var_53c4124af039142e )
    {
        vehbundle = function_aed48b97a3e5310f();
    }
    else
    {
        vehbundlename = function_b86cfd238a4adaac();
        vehbundle = getscriptbundle( getxhashasset( vehbundlename ) );
    }
    
    if ( isstruct( vehbundle ) && isdefined( vehbundle.weapon ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "rcxd", vehbundle.weapon ?? "rcxd", #"low" );
    }
    
    initializevisionset();
    
    /#
        setdevdvarifuninitialized( @"hash_3c982d64c7a6e0e8", 0 );
        setdevdvarifuninitialized( @"scr_rcxd_lifetime", 60 );
        setdevdvarifuninitialized( @"hash_7630e0c88e56c365", 0 );
        setdevdvarifuninitialized( @"hash_e98198514ca25658", 0 );
        setdevdvarifuninitialized( @"hash_38ef427e29d92d0b", 0 );
    #/
    
    level function_3fd63cf21bb7e396();
    utility::registersharedfunc( #"rcxd", #"hack", &rcxd_hack );
    utility::registersharedfunc( #"killstreak_rcxd", #"explode", &rcxd_explode );
    utility::flag_set( "rcxd_shared_initialized" );
}

// Namespace rcxd_shared
// Params 0, eflags: 0x4
// Checksum 0x557cdfcc, Offset: 0x5ff
// Size: 0x96
function private initializevisionset()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    
    if ( isdefined( bundle.var_28b586ad7dc362cb ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_28b586ad7dc362cb );
    }
    
    if ( isdefined( bundle.var_1f97b5b8701ce6e9 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_1f97b5b8701ce6e9 );
    }
    
    if ( isdefined( bundle.var_d4577861dd4e29ef ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_d4577861dd4e29ef );
    }
    
    killstreak_shared::function_28d986de72ce85f8( "killstreak_rcxd_drive" );
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x80708958, Offset: 0x69d
// Size: 0x7a
function function_b86cfd238a4adaac()
{
    var_bc41f635c06545d0 = level.streakglobals.streakbundles[ "rcxd" ];
    
    if ( isdefined( var_bc41f635c06545d0 ) && isdefined( var_bc41f635c06545d0.deployedvehiclebundle ) )
    {
        return ( "vehiclebundle:" + var_bc41f635c06545d0.deployedvehiclebundle );
    }
    
    if ( utility::issp() )
    {
        return ( "vehiclebundle:" + "veh9_rcxd" + "_sp" );
    }
    
    return "vehiclebundle:" + "veh9_rcxd" + "_mp";
}

// Namespace rcxd_shared
// Params 0
// Checksum 0xa91773d, Offset: 0x720
// Size: 0x4b
function function_aed48b97a3e5310f()
{
    var_bc41f635c06545d0 = level.streakglobals.streakbundles[ "rcxd" ];
    
    if ( var_bc41f635c06545d0.deployedvehiclebundle )
    {
        return vehicle::get_data( getxhashasset( var_bc41f635c06545d0.deployedvehiclebundle ) );
    }
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xfdc9fa24, Offset: 0x773
// Size: 0x270
function function_dbdddb07c2492f02( streakname )
{
    if ( level.projectbundle.var_53c4124af039142e )
    {
        vehbundle = function_aed48b97a3e5310f();
    }
    else
    {
        vehbundlename = function_b86cfd238a4adaac();
        vehbundle = getscriptbundle( getxhashasset( vehbundlename ) );
    }
    
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    assert( isdefined( bundle ) );
    assert( isdefined( vehbundle ) );
    assert( isdefined( bundle.deployweaponname ) );
    level.rcxdsettings = [];
    level.rcxdsettings[ streakname ] = spawnstruct();
    level.rcxdsettings[ streakname ].timeout = 60;
    level.rcxdsettings[ streakname ].maxhealth = vehbundle.damage.health;
    level.rcxdsettings[ streakname ].var_d27ae3d8dde66921 = bundle.var_48fd757d26230609 / 100;
    level.rcxdsettings[ streakname ].hitstokill = vehbundle.damage.maxhits;
    level.rcxdsettings[ streakname ].streakname = "rcxd";
    level.rcxdsettings[ streakname ].pausemin = 0.15;
    level.rcxdsettings[ streakname ].pausemax = 0.35;
    level.rcxdsettings[ streakname ].lockstrength = 6;
    level.rcxdsettings[ streakname ].spinuptime = 0.65;
    level.rcxdsettings[ streakname ].deployweaponname = bundle.deployweaponname;
    level.rcxdsettings[ streakname ].stringcannotplace = &"killstreaks_hint_cannot_call_in";
    level.rcxdsettings[ streakname ].scorepopup = "destroyed_rcxd";
    level.rcxdsettings[ streakname ].vodestroyed = "destroyed_rcxd";
    level.rcxdsettings[ streakname ].destroyedsplash = "callout_destroyed_rcxd";
}

// Namespace rcxd_shared
// Params 0
// Checksum 0xc044eb60, Offset: 0x9eb
// Size: 0x39
function function_3fd63cf21bb7e396()
{
    function_dbdddb07c2492f02( "rcxd" );
    level.rcxds = [];
    vehicle_spawn::function_3a15dcf060e81fe( "rcxd", 32 );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "rcxd", "on", 15 );
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x2dc3e5df, Offset: 0xa2c
// Size: 0x18
function deployweapontaken( streakinfo )
{
    self notify( #"finished_deploy_weapon" );
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x18b26673, Offset: 0xa4c
// Size: 0x22
function function_e760addd352d0099()
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "rcxd", self );
    return function_bdbc99e904937454( streakinfo );
}

// Namespace rcxd_shared
// Params 2
// Checksum 0xffc433b5, Offset: 0xa77
// Size: 0x4ad, Type: bool
function function_bdbc99e904937454( streakinfo, rcxd_params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_d3cd9f41839cace8" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_d3cd9f41839cace8" ) ]]( streakinfo );
    }
    
    /#
        if ( getdvarint( @"hash_38ef427e29d92d0b", 0 ) )
        {
            thread function_1beccb0393033dc9( streakinfo.bundle.var_96d854999545fc7b );
        }
    #/
    
    if ( isdefined( rcxd_params.uniquespawnpos ) )
    {
        position = rcxd_params.uniquespawnpos;
    }
    else
    {
        position = function_29b6ac151d26a9ab( 100, streakinfo.bundle.var_96d854999545fc7b, undefined, streakinfo.bundle );
    }
    
    var_627fb43f841ec021 = utility::callsharedfunc( #"map", #"hash_b4fafa9d5f310a7e", self, position );
    
    if ( !isdefined( position ) || var_627fb43f841ec021 )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
        return false;
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        streakinfo notify( #"killstreak_failed_use" );
        return false;
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    val::set( "rcxd", "killstreaks", 0 );
    thread function_7d0c800fc80c693e( streakinfo );
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    var_5ed5790be7f3d0c9 = bundle.var_a812f66f69b6d88f ?? 1;
    var_ec7a8f4f92a59bc3 = undefined;
    blueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    var_9af4377dd7b1d62e = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_22fce0b7d0d69175" ) )
    {
        var_9af4377dd7b1d62e = utility::callsharedfunc( #"killstreak", #"hash_22fce0b7d0d69175" );
    }
    
    if ( streakinfo.mpstreaksysteminfo.blueprintindex == 0 && isdefined( var_9af4377dd7b1d62e ) )
    {
        var_ec7a8f4f92a59bc3 = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( var_9af4377dd7b1d62e, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    else if ( blueprintname )
    {
        var_ec7a8f4f92a59bc3 = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( blueprintname, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( self ) )
    {
        assert( !callback::exists( #"killstreak_cancel", &deploy_cancel ) );
        callback::add( #"killstreak_cancel", &deploy_cancel );
    }
    
    deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweapontabletdeploysharedfunc( streakinfo, undefined, streakinfo.weaponswitchendedcallback, undefined, &deployweapontaken, level.rcxdsettings[ "rcxd" ].deployweaponname, 0, var_5ed5790be7f3d0c9, undefined, undefined, var_ec7a8f4f92a59bc3 );
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( self ) )
    {
        assert( callback::exists( #"killstreak_cancel", &deploy_cancel ) );
        callback::remove( #"killstreak_cancel", &deploy_cancel );
    }
    
    if ( !deployresult )
    {
        streakinfo notify( #"killstreak_failed_use" );
        self notify( #"rcxd_failed_deploy" );
        val::set( "rcxd", "killstreaks", 1 );
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    streakinfo.streakduration = 60;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            val::set( "rcxd", "killstreaks", 1 );
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    result = function_6547441f09075715( streakinfo, position, rcxd_params.var_697ba588b4258b14 );
    
    if ( !result )
    {
        namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
        val::set( "rcxd", "killstreaks", 1 );
        streakinfo notify( #"killstreak_failed_use" );
        return false;
    }
    
    return true;
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0xa00d531e, Offset: 0xf2d
// Size: 0x18
function private deploy_cancel( params )
{
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x63ba4a63, Offset: 0xf4d
// Size: 0x13b
function private function_7d0c800fc80c693e( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    killstreak_utility::function_7ab4bfe11ada17a( bundle );
    transitiondelaysec = bundle.rcxdtransitiondelay ?? 0;
    result = utility::waittill_any_timeout( transitiondelaysec, "cancel_remote_sequence", "rcxd_failed_deploy" );
    
    if ( !isdefined( result ) || result == "cancel_remote_sequence" || result == "rcxd_failed_deploy" )
    {
        return;
    }
    
    if ( bundle.var_8b43cd747014ec7e )
    {
        streakinfo.var_e8b8649e71024d0 = 0.65;
        thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
        return;
    }
    
    if ( namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        self playlocalsound( "mp_killstreak_transition_whoosh" );
        function_451222c181653ecd();
        transitiontimesec = bundle.rcxdtransitiontime ?? 0;
        result = utility::waittill_any_timeout( transitiontimesec, "death" );
        
        if ( !isdefined( result ) || result == "death" )
        {
            self stoplocalsound( "mp_killstreak_transition_whoosh" );
        }
    }
}

// Namespace rcxd_shared
// Params 3
// Checksum 0xa500d48d, Offset: 0x1090
// Size: 0x30b, Type: bool
function function_6547441f09075715( streakinfo, position, var_697ba588b4258b14 )
{
    self disablephysicaldepthoffieldscripting();
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    val::set( "rcxdDropOff", "fire", 0 );
    vehicle_tracking::function_4f76f5b4541acef1();
    rcxd = creatercxd( "rcxd", self, streakinfo, position );
    rcxd vehicle_occupancy::turn_engine_on();
    rcxd.override_unresolved_collision = &override_unresolved_collision;
    rcxd.var_300686ebe3a78e39 = 1;
    
    if ( !isdefined( rcxd ) )
    {
        namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
        val::reset_all( "rcxdDropOff" );
        return false;
    }
    
    val::reset_all( "rcxdDropOff" );
    thread function_aff5382dadd1a572( rcxd, streakinfo.bundle.var_96d854999545fc7b, istrue( streakinfo.disablemarker ), var_697ba588b4258b14 );
    namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "use_" + "rcxd", #"use", 1 );
    utility::trycall( level.matchdata_logkillstreakevent, "rcxd", self.origin );
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        rcxd thread killstreak_shared::function_585fb909f40d8659( rcxd.endtime, bundle.alertfulllength, bundle.var_c3193942aa25f78, bundle.var_28e5801bce7f4815, bundle.var_b84c3eae995cb030, bundle.var_ed6c729701a7f3ed );
    }
    
    rcxd thread function_a20e76ccb47ef978();
    rcxd thread function_899aef7aa02b06ec();
    rcxd thread function_8b47903285bcb7be( streakinfo );
    
    if ( isbrgamemode() )
    {
        rcxd thread rcxd_watchforgameended();
    }
    else
    {
        rcxd thread function_aa8d9503c8889872();
    }
    
    rcxd thread function_6708b2fc2f6e2400( rcxd.owner );
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( rcxd.owner ) )
    {
        assert( !rcxd.owner callback::exists( #"killstreak_cancel", &killstreak_cancel, rcxd ) );
        rcxd.owner callback::add( #"killstreak_cancel", &killstreak_cancel, rcxd );
    }
    
    if ( streakinfo.var_ebcce815485d5da0 )
    {
        rcxd thread function_a941c023c5c61738();
    }
    
    if ( streakinfo.var_1774cdcd85e44099 )
    {
        rcxd thread function_27df7dab52e7b741();
    }
    
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    used_splash_ref = bundle.usedsplashref;
    var_8f34e01a145e99e2 = utility::getsharedfunc( #"splash", #"registersplashbundle" );
    
    if ( isdefined( var_8f34e01a145e99e2 ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    self.vehicle = rcxd;
    return true;
}

// Namespace rcxd_shared
// Params 2
// Checksum 0xc4aa790b, Offset: 0x13a4
// Size: 0x15
function override_unresolved_collision( player, ballowsuicide )
{
    
}

// Namespace rcxd_shared
// Params 4
// Checksum 0xd64d1312, Offset: 0x13c1
// Size: 0x519
function creatercxd( rcxdtype, owner, streakinfo, spawnloc )
{
    var_c7193eb73bf2757f = level.rcxdsettings[ rcxdtype ];
    angles = owner.angles;
    spawndata = spawnstruct();
    spawndata.origin = spawnloc;
    spawndata.angles = angles;
    superfaction = namespace_9d8e359c3b1041e5::getplayersuperfactionsharedfunc( owner );
    spawndata.targetname = rcxdtype;
    spawndata.vehicletype = streakinfo.bundle.deployedvehicle;
    spawndata.owner = owner;
    faildata = spawnstruct();
    rcxd = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !isdefined( rcxd ) )
    {
        return;
    }
    
    if ( streakinfo.var_1641493274c66319 )
    {
        if ( utility::level_supports_ai() || isnavmeshloaded() )
        {
            rcxd utility::set_ai_number();
            
            if ( utility::issharedfuncdefined( #"vehicle", #"initAIAvoidance" ) )
            {
                rcxd thread utility::callsharedfunc( #"vehicle", #"initAIAvoidance" );
            }
            else
            {
                rcxd thread vehicle_code::function_2f279e91bd543e23();
            }
        }
    }
    
    modifiedlifetime = getdvarint( @"scr_rcxd_lifetime", var_c7193eb73bf2757f.timeout );
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
    #/
    
    rcxd.team = owner.team;
    rcxd.teamfriendlyto = owner.team;
    rcxd.owner = owner;
    rcxd.streakinfo = streakinfo;
    rcxd.rcxdtype = rcxdtype;
    rcxd.config = var_c7193eb73bf2757f;
    rcxd.maxhealth = rcxd.health;
    rcxd.health = rcxd.health;
    rcxd.currenthealth = rcxd.health;
    rcxd.lifetime = modifiedlifetime;
    rcxd.superfaction = superfaction;
    rcxd.angles = spawndata.angles;
    rcxd.isdisabled = 0;
    rcxd.remotekillstreak = 1;
    rcxd.var_37ea0fa5533244a1 = 1;
    rcxd.var_1c98f583383286ef = 1;
    rcxd.bundlename = "veh9_rcxd";
    rcxd.var_bdc51be80cbeef82 = streakinfo.bundle.var_bdc51be80cbeef82;
    rcxd setentityowner( owner );
    rcxd setotherent( owner );
    rcxd setvehicleteam( rcxd.team );
    rcxd setnodeploy( 1 );
    rcxd namespace_9d8e359c3b1041e5::registersentientsharedfunc( "Killstreak_Ground", owner );
    rcxd.occupants = [];
    rcxd rcxd_setupdamagefunctionality( streakinfo.streakname );
    rcxd vehicle_damage::set_can_damage( 0 );
    rcxd.childoutlineents = [ rcxd ];
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( rcxd, "killstreak" );
    vehicle_tracking::register_instance( rcxd, owner, owner.team );
    level.rcxds[ level.rcxds.size ] = rcxd;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        rcxd [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo, "Killstreak_Ground", owner, 0, 1, 30 );
    }
    
    level notify( #"matchrecording_small_ground_vehicle", rcxd );
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    rcxd setscriptablepartstate( "lights", "on", 0 );
    
    if ( streakinfo.mpstreaksysteminfo.blueprintindex >= 0 )
    {
        bpname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    }
    
    if ( streakinfo.mpstreaksysteminfo.blueprintindex == 0 )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_22fce0b7d0d69175" ) )
        {
            bpname = utility::callsharedfunc( #"killstreak", #"hash_22fce0b7d0d69175" );
        }
    }
    
    if ( bpname )
    {
        if ( namespace_de7b719e85d98dcc::function_9756c22d39f3dee5( bpname, bundle.var_d6458572c05ed36e ?? #"rcxd", rcxd.vehicletype ) )
        {
            rcxd namespace_de7b719e85d98dcc::function_ee125f945df9bdbc( bpname, bundle.var_d6458572c05ed36e ?? #"rcxd", rcxd.vehicletype );
        }
    }
    
    return rcxd;
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xad472699, Offset: 0x18e3
// Size: 0xd3
function rcxd_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "destroyed_" + streakname;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_9ac5638cd2ef1612;
    var_d188942a41771ea1 = &function_1a32d197323a2036;
    premoddamagecallback = &function_32897193be80a700;
    postmoddamagecallback = &function_3c6a723e8145a303;
    deathcallback = &rcxd_handledeathdamage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x4360db03, Offset: 0x19be
// Size: 0x3f
function function_9ac5638cd2ef1612( streakname )
{
    config = level.rcxdsettings[ self.rcxdtype ];
    vehicle_damage::set_vehicle_hit_damage_data( streakname, config.hitstokill );
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xd819a7d0, Offset: 0x1a05
// Size: 0x19c
function function_1a32d197323a2036( streakname )
{
    weaponname = "thermite_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 18;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 25;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 7;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 8;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "c4_mp_p";
    weaponhitsperattack = 5;
    var_ffcfe5819a7a67f1 = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace rcxd_shared
// Params 2
// Checksum 0x7bad20b, Offset: 0x1ba9
// Size: 0x4c
function function_5c0fde1ea9ab44bd( rcxd, omnvarstate )
{
    if ( isdefined( rcxd ) && !rcxd.destroyed )
    {
        namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( rcxd.streakinfo.streakname, "on" );
    }
}

// Namespace rcxd_shared
// Params 4
// Checksum 0x18dd7a8d, Offset: 0x1bfd
// Size: 0x47e
function function_aff5382dadd1a572( rcxd, var_bb70259700842512, disablemarker, var_697ba588b4258b14 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", rcxd, &function_4ea8fd3f96a5c1fe, &function_50ebfc11acef49a8 );
    bundle = killstreak_utility::function_f943c0602acdc2af( "rcxd" );
    position = function_29b6ac151d26a9ab( 100, var_bb70259700842512, rcxd, bundle );
    
    if ( !level.var_6619e75ea5ba9238 )
    {
        if ( isdefined( position ) )
        {
            rcxd vehicle_teleport( position, self.angles );
        }
    }
    else
    {
        level.var_6619e75ea5ba9238 = undefined;
    }
    
    self.restoreangles = self getplayerangles();
    rcxd vehicle_damage::set_can_damage( 1 );
    data = spawnstruct();
    data.deathoverridecallback = &function_86ce53096e8db304;
    rcxd thread namespace_9d8e359c3b1041e5::handlemovingplatformssharedfunc( data );
    rcxd setotherent( self );
    rcxd.driver = self;
    rcxd.ispiloted = 1;
    self unlink();
    
    if ( rcxd.empcount > 0 )
    {
        namespace_9d8e359c3b1041e5::freezelookcontrolssharedfunc( 1 );
    }
    else
    {
        self usevehicle( rcxd, 0 );
    }
    
    rcxd.controlslinked = 1;
    self painvisionoff();
    var_2c50ebc26185557b = level.sharedfuncs[ #"damage_effects" ][ #"hash_7ff5e70e05a98fb0" ];
    
    if ( isdefined( var_2c50ebc26185557b ) )
    {
        [[ var_2c50ebc26185557b ]]( 0.5 );
    }
    
    killstreak_shared::killstreak_savenvgstate();
    rcxd.starttime = gettime();
    rcxd.endtime = rcxd.starttime + int( rcxd.lifetime * 1000 );
    self setclientomnvar( "ui_killstreak_countdown", rcxd.endtime );
    self setclientomnvar( "ui_killstreak_health", rcxd.health / rcxd.maxhealth );
    self setclientomnvar( "ui_killstreak_damage_state", 0 );
    utility::delaycall( 0, &function_5c0fde1ea9ab44bd, rcxd, "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "rcxd" );
    var_7a46534e9c3e3afa = 0;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_d5feedce982670dd" ) )
    {
        var_7a46534e9c3e3afa = utility::callsharedfunc( #"killstreak", #"hash_d5feedce982670dd" );
    }
    
    if ( !disablemarker && !var_7a46534e9c3e3afa )
    {
        bundle = killstreak::function_85b2d8e857ab4898( "rcxd" );
        targetmarkersettings = bundle.targetmarkersettings ? getscriptbundle( bundle.targetmarkersettings ) : undefined;
        
        if ( utility::issharedfuncdefined( #"killstreak_rcxd", #"assigntargetmarkers" ) )
        {
            killstreak_shared::function_a402a9f43d6f7512( "killstreak_rcxd", undefined, undefined, bundle.var_225c495bde49787b );
        }
        else
        {
            var_1e1ecace3b3c2a63 = targetmarkersettings.var_1e1ecace3b3c2a63 ?? 0;
            var_ee7bc8b53cebd37e = targetmarkersettings.var_ee7bc8b53cebd37e ?? 0;
            params = { #var_ee7bc8b53cebd37e:var_ee7bc8b53cebd37e, #var_1e1ecace3b3c2a63:var_1e1ecace3b3c2a63, #var_4ef38b0aefb507c6:bundle.var_f057b69340b14a5c, #var_d33b439c3dce3f3d:bundle.var_598d79add3230927, #hideoverlaytargetmarkerfriendly:bundle.var_3f3a323868e1d507 };
            killstreak_shared::killstreak_assigntargetmarkers( params );
        }
        
        thread function_c36f9ee4295d0fef( rcxd );
    }
    
    shellshock_utility::_stopshellshock();
    val::set( "rcxd", "shellshock", 0 );
    
    if ( !isdefined( rcxd ) )
    {
        killstreak_shared::function_b3302c4317df36c6();
        return;
    }
    
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( rcxd, "killstreak" );
    function_3d87a59a4ab8b451();
    val::set( "rcxd_spawn", "player_for_spawn_logic", 0 );
    namespace_9d8e359c3b1041e5::addspawnviewersharedfunc( rcxd );
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    
    if ( isdefined( var_697ba588b4258b14 ) )
    {
        self thread [[ var_697ba588b4258b14 ]]( rcxd );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"hash_d8307e54206525a9" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_d8307e54206525a9" ) ]]( rcxd );
    }
    
    rcxd namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( rcxd, &function_f9d36c51f2eb3566, &function_dbbb0387c2265442, &rcxd_emp_cleared );
    rcxd physics_registerforcollisioncallback();
    level thread killstreak_utility::function_6348c97b79ee8a08( rcxd, self, &rcxd_explode );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x644f21f8, Offset: 0x2083
// Size: 0xdd
function private function_c36f9ee4295d0fef( rcxd )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    rcxd endon( #"death" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( "rcxd" );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace rcxd_shared
// Params 0, eflags: 0x4
// Checksum 0x509a33bc, Offset: 0x2168
// Size: 0x85
function private function_3d87a59a4ab8b451()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    fullscreenfxparams = { #visionset:bundle.var_28b586ad7dc362cb ?? "killstreak_rcxd_drive", #postfxbundlename:bundle.var_1f1feedfdba0656d };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace rcxd_shared
// Params 0, eflags: 0x4
// Checksum 0xe74d2dff, Offset: 0x21f5
// Size: 0xa7
function private function_451222c181653ecd()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    
    if ( bundle.var_b4bcd7fcb48a0157 )
    {
        self playcinematicforplayer( bundle.var_8b43cd747014ec7e );
        return;
    }
    
    fullscreenfxparams = { #visionset:bundle.var_1f97b5b8701ce6e9 ?? "killstreak_rcxd_drive", #postfxbundlename:bundle.var_4019fe226f176654 };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace rcxd_shared
// Params 0, eflags: 0x4
// Checksum 0x6c9ad713, Offset: 0x22a4
// Size: 0x85
function private function_fa82b6ae5300a47()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    fullscreenfxparams = { #visionset:bundle.var_d4577861dd4e29ef ?? "killstreak_rcxd_drive", #postfxbundlename:bundle.var_dadff2196c990fca };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x5647fe6f, Offset: 0x2331
// Size: 0x39
function private function_c972f81be751f530( var_effab7a63f64cd3d )
{
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( { #postfxbundlename:var_effab7a63f64cd3d } );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x985f4d25, Offset: 0x2372
// Size: 0x51
function private function_f9d36c51f2eb3566( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    self.var_3b26ba99dd120dbf = 1;
    self dodamage( self.health, self.origin, data.attacker );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0xa28436cd, Offset: 0x23cb
// Size: 0x2b
function private function_dbbb0387c2265442( data )
{
    if ( self.var_3b26ba99dd120dbf )
    {
        return;
    }
    
    function_fa987f8096e70bd1( data.victim );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0xab1fe1fd, Offset: 0x23fe
// Size: 0x21
function private rcxd_emp_cleared( var_d36c41ff2a669928 )
{
    if ( self.var_3b26ba99dd120dbf )
    {
        return;
    }
    
    function_fa987f8096e70bd1( self );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x34023c06, Offset: 0x2427
// Size: 0x15
function private function_4ea8fd3f96a5c1fe( rcxd )
{
    function_fa987f8096e70bd1( rcxd );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0xfe34c1fb, Offset: 0x2444
// Size: 0x15
function private function_50ebfc11acef49a8( rcxd )
{
    function_fa987f8096e70bd1( rcxd );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x804cb5b2, Offset: 0x2461
// Size: 0xa7
function private function_fa987f8096e70bd1( rcxd )
{
    isemped = rcxd.empcount > 0;
    isjammed = istrue( rcxd.isjammed );
    var_251d8987261025ac = isemped || isjammed;
    
    if ( var_251d8987261025ac && !rcxd.isdisabled )
    {
        rcxd.isdisabled = 1;
        function_8096f3f156081abe( rcxd );
        return;
    }
    
    if ( !var_251d8987261025ac && rcxd.isdisabled )
    {
        rcxd.isdisabled = 0;
        function_2b9f048aaf6c9e36( rcxd );
    }
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0x77687021, Offset: 0x2510
// Size: 0xa6
function private function_8096f3f156081abe( rcxd )
{
    maxspeedforward = rcxd vehicle_gettopspeedforward( 1 );
    maxspeedreverse = rcxd vehicle_gettopspeedreverse( 1 );
    var_d27ae3d8dde66921 = level.rcxdsettings[ "rcxd" ].var_d27ae3d8dde66921;
    rcxd vehicle_settopspeedforward( maxspeedforward * var_d27ae3d8dde66921 );
    rcxd vehicle_settopspeedreverse( maxspeedreverse * var_d27ae3d8dde66921 );
    rcxd function_8f57751bc1b28779( 0 );
    rcxd function_ccacc3fd2c146e8( 0 );
    rcxd.owner function_fa82b6ae5300a47();
    self setscriptablepartstate( #"emp", #"on", 0 );
}

// Namespace rcxd_shared
// Params 1, eflags: 0x4
// Checksum 0xd6034b59, Offset: 0x25be
// Size: 0xb4
function private function_2b9f048aaf6c9e36( rcxd )
{
    maxspeedforward = rcxd vehicle_gettopspeedforward( 1 );
    maxspeedreverse = rcxd vehicle_gettopspeedreverse( 1 );
    rcxd vehicle_settopspeedforward( maxspeedforward );
    rcxd vehicle_settopspeedreverse( maxspeedreverse );
    rcxd function_8f57751bc1b28779( 1 );
    rcxd function_ccacc3fd2c146e8( 1 );
    rcxd.owner function_c972f81be751f530( level.streakglobals.streakbundles[ "rcxd" ].var_dadff2196c990fca );
    rcxd.owner function_3d87a59a4ab8b451();
    self setscriptablepartstate( #"emp", #"off", 0 );
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xa2263a4, Offset: 0x267a
// Size: 0xd4, Type: bool
function function_32897193be80a700( data )
{
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = killstreak::function_85b2d8e857ab4898( "rcxd" );
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:data.inflictor } );
    }
    
    return true;
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x6be2f631, Offset: 0x2757
// Size: 0x19e, Type: bool
function function_3c6a723e8145a303( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( isdefined( self.owner ) && self.owner utility::isusingremote() )
    {
        if ( isexplosivedamagemod( type ) )
        {
            if ( ceil( damage / self.maxhealth ) >= 0.33 )
            {
                self.owner earthquakeforplayer( 0.25, 0.2, self.origin, 150 );
                self.owner playrumbleonpositionforclient( "damage_heavy", self.owner geteye() );
            }
        }
        else
        {
            self.owner earthquakeforplayer( 0.15, 0.15, self.origin, 150 );
            self.owner playrumbleonpositionforclient( "damage_light", self.owner geteye() );
        }
    }
    
    utility::callsharedfunc( #"killstreak_rcxd", #"applydamage", data );
    modifieddamage = namespace_9d8e359c3b1041e5::getmodifiedantikillstreakdamagesharedfunc( attacker, objweapon, type, damage, self.maxhealth, 2, 3, 4, 12, 400 ) ?? damage;
    self.currenthealth -= modifieddamage;
    namespace_9d8e359c3b1041e5::killstreak_updatedamagestatesharedfunc( self.currenthealth );
    return true;
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x56fbb46d, Offset: 0x28fe
// Size: 0x3f, Type: bool
function rcxd_handledeathdamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    self.killedbyweapon = data.objweapon;
    thread rcxd_explode();
    return false;
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xe6d07e44, Offset: 0x2946
// Size: 0x13
function function_86ce53096e8db304( data )
{
    thread rcxd_explode();
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x4635b38f, Offset: 0x2961
// Size: 0x85
function function_a20e76ccb47ef978()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    timepassed = 0;
    self.lifetimeendtime = self.lifetime * 1000 + gettime();
    
    while ( timepassed < self.lifetime )
    {
        timepassed += level.framedurationseconds;
        self.owner setclientomnvar( "ui_killstreak_lifetime", 1 - timepassed / self.lifetime );
        waitframe();
    }
}

// Namespace rcxd_shared
// Params 0
// Checksum 0xb3f48ebf, Offset: 0x29ee
// Size: 0x55
function function_899aef7aa02b06ec()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self && self.owner )
    {
        boostcharge = self function_8219169c22f3c66d();
        self.owner setclientomnvar( "ui_killstreak_boost_recharge_percentage", boostcharge );
        waitframe();
    }
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x45be4e52, Offset: 0x2a4b
// Size: 0x51
function function_8b47903285bcb7be( streakinfo )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    function_7aceee150451ed2();
    namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "timeout_" + "rcxd", #"leave", 1 );
    thread rcxd_explode();
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x444b4711, Offset: 0x2aa4
// Size: 0x8e
function function_7aceee150451ed2()
{
    self endon( #"killstreakexit" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    self.owner endon( #"last_stand_enter" );
    self.owner endon( #"team_kill_punish" );
    level endon( #"game_ended" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( self.lifetime );
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x4191ad71, Offset: 0x2b3a
// Size: 0x84
function function_aa8d9503c8889872()
{
    self endon( #"death" );
    level waittill( #"hash_fa0cfbee663b705f" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread rcxd_destroy( 0, 1 );
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x35fb4225, Offset: 0x2bc6
// Size: 0x8b
function rcxd_watchforgameended()
{
    self endon( #"death" );
    level utility::waittill_any( "start_game_ended", "game_ended", "prematch_cleanup" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    rcxd_explode();
}

// Namespace rcxd_shared
// Params 2, eflags: 0x4
// Checksum 0xaf1617c, Offset: 0x2c59
// Size: 0x21
function private killstreak_cancel( params, rcxd )
{
    rcxd thread rcxd_destroy( 0, 1 );
}

// Namespace rcxd_shared
// Params 2
// Checksum 0xfa4186e4, Offset: 0x2c82
// Size: 0x1dd
function rcxd_destroy( wasdestroyed, var_fc44885fb0948ac0 )
{
    if ( isdefined( self.owner.vehicle ) )
    {
        self.owner.vehicle = undefined;
    }
    
    if ( self.destroyed )
    {
        return;
    }
    else
    {
        self.destroyed = 1;
    }
    
    self notify( #"death" );
    self.controlslinked = undefined;
    
    if ( isdefined( self.owner ) )
    {
        self.owner val::set( "rcxd", "killstreaks", 1 );
    }
    
    self.streakinfo.rcxd = self;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    vehicle_tracking::deregister_instance( self );
    vehicle_damage::set_can_damage( 0 );
    namespace_9d8e359c3b1041e5::clear_empsharedfunc( 1 );
    namespace_9d8e359c3b1041e5::allow_empsharedfunc( 0 );
    namespace_9d8e359c3b1041e5::clearoobsharedfunc( self, 1 );
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    self.owner namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( self.streakinfo );
    
    if ( isdefined( self.driver ) )
    {
        self.driver function_97ec301a6784838a( self );
    }
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( self.owner ) )
    {
        assert( self.owner callback::exists( #"killstreak_cancel", &killstreak_cancel, self ) );
        self.owner callback::remove( #"killstreak_cancel", &killstreak_cancel, self );
    }
    
    self notify( #"rcxd_stopped" );
    
    if ( !var_fc44885fb0948ac0 )
    {
        self waittill( #"rcxd_exploded" );
    }
    
    rcxd_delete();
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x68b18e76, Offset: 0x2e67
// Size: 0x22
function rcxd_delete()
{
    waitframe();
    level.rcxds = arrayremove( level.rcxds, self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace rcxd_shared
// Params 1
// Checksum 0xc877ca86, Offset: 0x2e91
// Size: 0x1f9
function function_97ec301a6784838a( rcxd )
{
    self endon( #"disconnect" );
    rcxd utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", rcxd );
    
    if ( rcxd.empcount > 0 )
    {
        namespace_9d8e359c3b1041e5::freezelookcontrolssharedfunc( 0 );
    }
    
    rcxd setotherent( undefined );
    rcxd.driver = undefined;
    rcxd.ispiloted = undefined;
    vehicleactive = self isvehicleactive();
    
    if ( vehicleactive )
    {
        self leavevehicle( 0 );
    }
    
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( rcxd.streakinfo.streakname, "off" );
    function_c972f81be751f530( level.streakglobals.streakbundles[ "rcxd" ].var_4019fe226f176654 );
    function_c972f81be751f530( level.streakglobals.streakbundles[ "rcxd" ].var_dadff2196c990fca );
    function_c972f81be751f530( level.streakglobals.streakbundles[ "rcxd" ].var_1f1feedfdba0656d );
    
    if ( utility::isusingremote() )
    {
        rcxd.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    }
    
    self painvisionon();
    killstreak_shared::killstreak_restorenvgstate();
    val::reset_all( "rcxd_spawn" );
    namespace_9d8e359c3b1041e5::removespawnviewersharedfunc( rcxd );
    killstreak_shared::function_76bbbe12ce816ed2();
    
    if ( !rcxd.streakinfo.disablemarker )
    {
        killstreak_shared::function_b3302c4317df36c6();
    }
    
    if ( namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        shellshock_utility::_stopshellshock();
        val::reset_all( "rcxd" );
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"rcxdendfunc" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"rcxdendfunc" ) ]]( rcxd );
    }
    
    self notify( #"killstreak_end_active_state" );
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x6fbbca4a, Offset: 0x3092
// Size: 0x69
function function_5e658cd4c1d7e145()
{
    self endon( #"death" );
    self.owner endon( #"end_remote" );
    self.owner endon( #"disconnect" );
    
    while ( true )
    {
        self.owner earthquakeforplayer( 0.05, 0.05, self gettagorigin( "tag_body" ), 500 );
        wait 0.05;
    }
}

/#

    // Namespace rcxd_shared
    // Params 1
    // Checksum 0xc8d8736f, Offset: 0x3103
    // Size: 0x1d6, Type: dev
    function function_1beccb0393033dc9( var_bb70259700842512 )
    {
        level notify( #"hash_453400623d1d435c" );
        level endon( #"hash_453400623d1d435c" );
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self endon( #"death" );
        setdvar( @"hash_e98198514ca25658", 1 );
        spawndist = 100;
        bundle = killstreak_utility::function_f943c0602acdc2af( "<dev string:x24>" );
        
        while ( true )
        {
            result = undefined;
            startpos = self.origin;
            startang = self.angles;
            forward = anglestoforward( startang );
            right = anglestoright( startang );
            spawnposchecks = [ startpos + spawndist * forward, startpos + 0.707 * spawndist * ( forward + right ), startpos + 0.707 * spawndist * ( forward - right ) ];
            
            foreach ( curpos in spawnposchecks )
            {
                result = function_1964a035cc08c6c1( startpos, curpos, var_bb70259700842512, undefined, bundle );
                
                if ( isdefined( result ) )
                {
                    print3d( result, "<dev string:x29>", ( 0, 1, 0 ), 1, 1, 1, 1 );
                    continue;
                }
                
                print3d( curpos, "<dev string:x2e>", ( 1, 0, 0 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace rcxd_shared
// Params 4
// Checksum 0x2aa70e8f, Offset: 0x32e1
// Size: 0x150
function function_29b6ac151d26a9ab( spawndist, var_bb70259700842512, var_fd543587a74e8d7f, bundle )
{
    result = undefined;
    startpos = self.origin;
    startang = self.angles;
    forward = anglestoforward( startang );
    right = anglestoright( startang );
    spawnposchecks = [ startpos + spawndist * forward, startpos + 0.707 * spawndist * ( forward + right ), startpos + 0.707 * spawndist * ( forward - right ) ];
    ignorearray = getplayersinradius( startpos, spawndist );
    ignorearray[ ignorearray.size ] = var_fd543587a74e8d7f;
    
    foreach ( curpos in spawnposchecks )
    {
        result = function_1964a035cc08c6c1( startpos, curpos, var_bb70259700842512, ignorearray, bundle );
        
        if ( isdefined( result ) )
        {
            break;
        }
    }
    
    return result;
}

// Namespace rcxd_shared
// Params 5
// Checksum 0x829f202b, Offset: 0x343a
// Size: 0x49f
function function_1964a035cc08c6c1( startpoint, spawnpoint, var_bb70259700842512 = 0, ignorearray, bundle )
{
    zoffset = ( 0, 0, 24 );
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    tracestart = startpoint + zoffset;
    traceend = spawnpoint + zoffset;
    spheretestradius = 15;
    
    /#
        var_ad44eb2fa5f1cc52 = getdvarint( @"hash_e98198514ca25658", 300 );
        debugspawns = getdvarint( @"hash_7630e0c88e56c365", 0 );
    #/
    
    var_38ff0b46d72a541c = trace::ray_trace_passed( tracestart, traceend, self, collisioncontents );
    
    if ( !var_38ff0b46d72a541c )
    {
        return;
    }
    
    groundtrace = trace::ray_trace( traceend, traceend - ( 0, 0, 500 ), ignorearray, collisioncontents );
    
    if ( !isdefined( groundtrace[ "position" ] ) || groundtrace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    if ( bundle.var_96d854999545fc7b && bundle.var_9998923666746c62 > 0 )
    {
        if ( abs( groundtrace[ "position" ][ 2 ] - startpoint[ 2 ] ) > bundle.var_9998923666746c62 )
        {
            return;
        }
    }
    
    groundtrace = trace::convert_surface_flag( groundtrace );
    
    if ( !isdefined( groundtrace[ "surfacetype" ] ) || groundtrace[ "surfacetype" ] == "surftype_water" || groundtrace[ "surfacetype" ] == "surftype_metal_car" )
    {
        return;
    }
    
    testspawnpos = groundtrace[ "position" ] + zoffset;
    var_d6e39170a55e23d0 = trace::sphere_trace_passed( testspawnpos, testspawnpos, spheretestradius, ignorearray, collisioncontents );
    teamtocheck = undefined;
    
    if ( level.teambased )
    {
        teamtocheck = self.team;
    }
    
    if ( var_d6e39170a55e23d0 && !namespace_9d8e359c3b1041e5::ispointinoutofboundssharedfunc( groundtrace[ "position" ], teamtocheck ) )
    {
        result = groundtrace[ "position" ];
        
        /#
            if ( debugspawns )
            {
                line( tracestart, traceend, ( 0, 1, 0 ), 1, 0, var_ad44eb2fa5f1cc52 );
                line( traceend, result, ( 0, 1, 0 ), 1, 0, var_ad44eb2fa5f1cc52 );
                sphere( testspawnpos, spheretestradius, ( 0, 1, 0 ), 0, var_ad44eb2fa5f1cc52 );
                
                if ( var_ad44eb2fa5f1cc52 > 1 && !var_bb70259700842512 )
                {
                    iprintlnbold( "<dev string:x33>" );
                }
            }
        #/
    }
    else
    {
        /#
            if ( debugspawns )
            {
                line( tracestart, traceend, ( 1, 0, 0 ), 1, 0, var_ad44eb2fa5f1cc52 );
                line( traceend, testspawnpos, ( 1, 0, 0 ), 1, 0, var_ad44eb2fa5f1cc52 );
                sphere( testspawnpos, spheretestradius, ( 1, 0, 0 ), 0, var_ad44eb2fa5f1cc52 );
            }
        #/
    }
    
    if ( !result )
    {
        return;
    }
    
    if ( var_bb70259700842512 )
    {
        var_885dc69cd9fa0123 = 6;
        
        if ( bundle.var_96d854999545fc7b && bundle.var_87a7fc367844f1a3 > 0 )
        {
            var_885dc69cd9fa0123 = bundle.var_87a7fc367844f1a3;
        }
        
        x = -1;
        
        while ( x <= 1 )
        {
            y = -1;
            
            while ( y <= 1 )
            {
                tstart = groundtrace[ "position" ] + ( x * spheretestradius, y * spheretestradius, 48 );
                tend = tstart - ( 0, 0, 48 + var_885dc69cd9fa0123 + 1 );
                extratrace = trace::ray_trace( tstart, tend, ignorearray, collisioncontents );
                extratrace = trace::convert_surface_flag( extratrace );
                
                if ( isdefined( extratrace[ "position" ] ) && extratrace[ "hittype" ] == "hittype_none" || extratrace[ "surfacetype" ] == "surftype_water" || abs( extratrace[ "position" ][ 2 ] - groundtrace[ "position" ][ 2 ] ) > var_885dc69cd9fa0123 )
                {
                    /#
                        if ( debugspawns )
                        {
                            sphere( extratrace[ "<dev string:x48>" ], 3, ( 1, 0, 0 ), 0, var_ad44eb2fa5f1cc52 );
                            line( extratrace[ "<dev string:x48>" ], groundtrace[ "<dev string:x48>" ], ( 1, 0, 0 ), 1, 0, var_ad44eb2fa5f1cc52 );
                        }
                    #/
                    
                    return;
                }
                
                /#
                    if ( debugspawns )
                    {
                        sphere( extratrace[ "<dev string:x48>" ], 2, ( 0, 0, 1 ), 0, var_ad44eb2fa5f1cc52 );
                        line( extratrace[ "<dev string:x48>" ], groundtrace[ "<dev string:x48>" ], ( 0, 0, 1 ), 1, 0, var_ad44eb2fa5f1cc52 );
                    }
                #/
                
                y += 2;
            }
            
            x += 2;
        }
    }
    
    return result;
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x758fd9b, Offset: 0x38e2
// Size: 0x33
function rcxd_explode()
{
    if ( self.var_749b7e341dfdf7a9 )
    {
        return;
    }
    
    self.var_749b7e341dfdf7a9 = 1;
    namespace_9d8e359c3b1041e5::vehicle_damage_clearvisualssharedfunc( undefined, undefined, 1 );
    thread function_41010265ba623659();
    thread rcxd_destroy();
}

// Namespace rcxd_shared
// Params 0
// Checksum 0xa35e111b, Offset: 0x391d
// Size: 0x51a
function function_41010265ba623659()
{
    if ( level.projectbundle.var_53c4124af039142e )
    {
        vehbundle = function_aed48b97a3e5310f();
    }
    else
    {
        vehbundlename = function_b86cfd238a4adaac();
        vehbundle = getscriptbundle( getxhashasset( vehbundlename ) );
    }
    
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    explosiondata = vehbundle.pristineexplosion;
    player = self.owner;
    assert( isdefined( explosiondata ), "<dev string:x51>" );
    explosionposition = self.origin;
    utility::callsharedfunc( #"killstreak", #"killstreak_explosionnearai", explosionposition, 500, "allies", "rcxd" );
    utility::callsharedfunc( #"killstreak_rcxd", #"explosiondamagewatcher", player );
    vehicle_damage::set_can_damage( 0 );
    attacker = undefined;
    
    if ( self.explosionowner ?? player )
    {
        attacker = self.explosionowner ?? player;
    }
    
    var_d524dc712f0faeb2 = player.waitingtospawn;
    var_13cc02363f011a45 = undefined;
    
    if ( bundle.explosioncamduration > 0 && isdefined( player ) && player == self getvehicleowner() )
    {
        tracecontents = self.streakinfo.var_d3b88dfe42ae2e2b ?? trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1 );
        var_13cc02363f011a45 = killstreak_shared::function_51a64dfe550d76fa( player, self, bundle.var_2e5b23a43c2eae37 ?? 0, bundle.var_da6f333032a83961 ?? 0, 8, bundle.var_3b2b6f0b5bf6c97, tracecontents, self.streakinfo.var_ef64a7927e76edc4 );
        var_56e236b777d63839 = bundle.var_3a306407cb3dc3df ?? 0.1;
        
        if ( var_13cc02363f011a45.success && var_56e236b777d63839 > 0 )
        {
            player startcameratween( min( bundle.explosioncamduration, var_56e236b777d63839 ), 0, "ease_inout_sine", 1 );
        }
    }
    
    self setscriptablepartstate( #"explode", #"on" );
    
    if ( !var_d524dc712f0faeb2 )
    {
        self waittill( #"rcxd_stopped" );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_8b60bc2f7230ff2e" ) )
    {
        var_d70c9a5dd7dd3545 = player utility::callsharedfunc( #"killstreak", #"hash_8b60bc2f7230ff2e" );
        
        if ( isdefined( player ) )
        {
            var_66933a12fdd7c8ce = var_d70c9a5dd7dd3545.var_66933a12fdd7c8ce;
            
            if ( var_66933a12fdd7c8ce )
            {
                player val::set( "rcxd_explosion_ignore_self", "damage", 0 );
            }
            
            self radiusdamage( self.origin, bundle.var_ea4aed043b578007, bundle.var_795b7c0589ec54d, bundle.var_771a1c058761a33, attacker, "MOD_EXPLOSIVE", vehbundle.weapon ?? "rcxd", undefined, undefined, undefined, var_66933a12fdd7c8ce );
            
            if ( var_66933a12fdd7c8ce )
            {
                player val::reset_all( "rcxd_explosion_ignore_self" );
            }
        }
    }
    else
    {
        self radiusdamage( self.origin, bundle.var_ea4aed043b578007, bundle.var_795b7c0589ec54d, bundle.var_771a1c058761a33, attacker, "MOD_EXPLOSIVE", vehbundle.weapon ?? "rcxd" );
    }
    
    if ( var_d524dc712f0faeb2 )
    {
        self waittill( #"rcxd_stopped" );
    }
    
    self notify( #"rcxd_exploded" );
    level callback::callback( "rcxd_exploded", { #rcxd:self } );
    utility::callsharedfunc( #"ai", #"addactivesmoke", self.origin + ( 0, 0, 70 ), 1.3, 125, 80 );
    physicsexplosionsphere( explosionposition, explosiondata.physicsouterradius, explosiondata.physicsinnerradius, explosiondata.physicsscale );
    
    if ( var_13cc02363f011a45.success && isalive( player ) )
    {
        explosioncam = spawn( "script_model", explosionposition );
        explosioncam setmodel( "tag_player" );
        explosioncam.angles = vectortoangles( var_13cc02363f011a45.focuspos - var_13cc02363f011a45.camerapos );
        explosioncam.origin = var_13cc02363f011a45.camerapos;
        player cameralinkto( explosioncam, "tag_player", 1 );
        utility::callsharedfunc( #"killstreak_rcxd", #"explosioncamstarted", player, bundle );
        player utility::waittill_notify_or_timeout( "killstreak_cancel", bundle.explosioncamduration );
        
        if ( isdefined( player ) )
        {
            player cameraunlink();
        }
        
        player notify( #"hash_29bcbf8ff782a0a9" );
        explosioncam delete();
    }
}

// Namespace rcxd_shared
// Params 1
// Checksum 0x714c8c4a, Offset: 0x3e3f
// Size: 0x13e
function function_6708b2fc2f6e2400( player )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    var_43f809da11b9b2ba = bundle.var_bfc7ea5bafc678b;
    
    for ( attackbuttonprev = 0; true ; attackbuttonprev = attackbuttoncur )
    {
        waitframe();
        var_95ddbb5eccdfd7d8 = self function_e4c70df6ddff5c2d() == 0;
        
        if ( var_95ddbb5eccdfd7d8 && player usinggamepad() )
        {
            attackbuttoncur = player fragbuttonpressed() || player usebuttonpressed();
        }
        else
        {
            attackbuttoncur = player attackbuttonpressed() || player usebuttonpressed();
        }
        
        var_f08e74e09069ad41 = self function_43f4bc8ff857e68e();
        var_66c1daa4b2faca24 = var_f08e74e09069ad41 > var_43f809da11b9b2ba;
        
        if ( var_66c1daa4b2faca24 || gettime() >= self.starttime + 500 && attackbuttoncur && !attackbuttonprev )
        {
            if ( var_66c1daa4b2faca24 )
            {
                player notify( #"hash_bfce2c58340b2599" );
            }
            
            break;
        }
    }
    
    self dodamage( self.health, self.origin );
    thread rcxd_explode();
}

// Namespace rcxd_shared
// Params 0
// Checksum 0xdb48d694, Offset: 0x3f85
// Size: 0x71
function function_a941c023c5c61738()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_7bafb4378d0bb015", ai );
        
        if ( utility::issharedfuncdefined( #"killstreak", #"rcxdhitai" ) )
        {
            utility::callsharedfunc( #"killstreak", #"rcxdhitai", ai );
        }
    }
}

// Namespace rcxd_shared
// Params 0
// Checksum 0x56e936a0, Offset: 0x3ffe
// Size: 0x59
function function_27df7dab52e7b741()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"veh_hit_veh", veh );
        self [[ utility::getsharedfunc( #"killstreak", #"hash_710b6132f679486" ) ]]( veh );
    }
}

// Namespace rcxd_shared
// Params 2
// Checksum 0xe78a21a9, Offset: 0x405f
// Size: 0x4f
function rcxd_hack( hackeffect, attacker )
{
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed" );
    }
    
    self.explosionowner = attacker;
}

