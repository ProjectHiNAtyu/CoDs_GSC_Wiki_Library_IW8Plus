// scripts\mp\common\killstreaks\sniper_drone.gsc  (hash_1408c834c94b567c.gscc) (size: 19605 Bytes / 0x4c95 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87d0a39b (2278597531)
// size ...... 19605 (0x4c95)
// includes .. 23  (offset: 0x479d)
// strings ... 54  (offset: 0x4855)
// dev strs .. 2   (offset: 0x4c7d)
// exports ... 38  (offset: 0x2cf5)
// cseg ...... 0x41a + 0x28db (0x2cf5)
// imports ... 176 (offset: 0x32e5)
// animtree1 . 0   (offset: 0x4c95)
// animtree2 . 0   (offset: 0x4c95)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\recon_drone;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\render_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\outofbounds;

#namespace sniper_drone;

// Namespace sniper_drone
// Params 0, eflags: 0x1
// Checksum 0x41b78e9c, Offset: 0x438
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "sniper_drone" ), &init );
}

// Namespace sniper_drone
// Params 0
// Checksum 0x4777f66c, Offset: 0x457
// Size: 0x66
function init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "sniper_drone", &tryusesniperdrone );
    }
    
    level callback::add( #"hash_244314ef9125e636", &function_734f27337948fa14 );
    function_ae9a75bc2e37d0f5();
    function_d0cc685116f2c7b();
}

// Namespace sniper_drone
// Params 0
// Checksum 0xc6c13f39, Offset: 0x4c5
// Size: 0x577
function function_ae9a75bc2e37d0f5()
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    
    if ( bundle.deployedvehiclebundle )
    {
        vehbundle = getscriptbundle( getxhashasset( "vehiclebundle:" + bundle.deployedvehiclebundle ) );
    }
    
    if ( !isdefined( level.helperdronesettings ) )
    {
        level.helperdronesettings = [];
    }
    
    level.helperdronesettings[ "sniper_drone" ] = spawnstruct();
    level.helperdronesettings[ "sniper_drone" ].repeatuse = getdvarint( @"hash_f1996252ba1e8d19", 0 );
    level.helperdronesettings[ "sniper_drone" ].timeout = 45;
    level.helperdronesettings[ "sniper_drone" ].maxhealth = vehbundle.damage.health ?? 135;
    level.helperdronesettings[ "sniper_drone" ].hitstokill = 1;
    level.helperdronesettings[ "sniper_drone" ].speed = 140;
    level.helperdronesettings[ "sniper_drone" ].accel = 20;
    level.helperdronesettings[ "sniper_drone" ].halfsize = 27;
    level.helperdronesettings[ "sniper_drone" ].spawndist = 30;
    level.helperdronesettings[ "sniper_drone" ].streakname = "sniper_drone";
    level.helperdronesettings[ "sniper_drone" ].vehicleinfo = undefined;
    level.helperdronesettings[ "sniper_drone" ].modelbase = bundle.sniperdronemodel;
    level.helperdronesettings[ "sniper_drone" ].teamsplash = "used_" + "sniper_drone";
    level.helperdronesettings[ "sniper_drone" ].destroyedsplash = "callout_destroyed_" + "sniper_drone";
    level.helperdronesettings[ "sniper_drone" ].scorepopup = "destroyed_" + "sniper_drone";
    level.helperdronesettings[ "sniper_drone" ].primarymode = "MANUAL";
    level.helperdronesettings[ "sniper_drone" ].primarymodestring = &"killstreaks_hints/rcd_manual";
    level.helperdronesettings[ "sniper_drone" ].primarymodefunc = &function_c4564cddfa8d301;
    level.helperdronesettings[ "sniper_drone" ].premoddamagefunc = &helper_drone::helperdrone_premodifydamage;
    level.helperdronesettings[ "sniper_drone" ].postmoddamagefunc = &postmodifydamage;
    level.helperdronesettings[ "sniper_drone" ].exitfunc = &sniperdrone_exit;
    level.helperdronesettings[ "sniper_drone" ].leavefunc = &sniperdrone_leave;
    level.helperdronesettings[ "sniper_drone" ].explodefunc = &sniperdrone_explode;
    level.helperdronesettings[ "sniper_drone" ].returnplayerfunc = &sniperdrone_returnplayer;
    level.helperdronesettings[ "sniper_drone" ].deathfunc = &sniperdrone_handledeathdamage;
    level.helperdronesettings[ "sniper_drone" ].playfxcallback = &helper_drone::helperdrone_playfx;
    level.helperdronesettings[ "sniper_drone" ].var_beb5cf9815327759 = 1;
    level.helperdronesettings[ "sniper_drone" ].var_8882e489606fbd21 = 1;
    level.helperdronesettings[ "sniper_drone" ].var_56f14c50d828adbe = 3062500;
    level.helperdronesettings[ "sniper_drone" ].var_c069a84757495b12 = 6250000;
    level.helperdronesettings[ "sniper_drone" ].colorvision = "";
    level.helperdronesettings[ "sniper_drone" ].var_9fa8a04fa6a7af05 = "";
    level.helperdronesettings[ "sniper_drone" ].var_eaf7aed3b097c78d = 1;
    level.helperdronesettings[ "sniper_drone" ].voontimeout = 1;
    level.helperdronesettings[ "sniper_drone" ].var_17e473e12ced7138 = 1;
    level.helperdronesettings[ "sniper_drone" ].targetname = "script_vehicle";
    level.helperdronesettings[ "sniper_drone" ].projectileweapon = getxhashasset( bundle.projectileweapon );
    level.helperdronesettings[ "sniper_drone" ].helperdronetype = "sniper_drone";
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "sniper_drone", "on", 26 );
    killstreaks::registerkillstreakdamagedealingweapon( "sniper_drone", bundle.var_8e8819d71a19d8c3, #"low" );
    function_13034abc372edc80();
    killstreaks::registerkillstreakdamagedealingweapon( "sniper_drone", bundle.projectileweapon, #"low" );
}

// Namespace sniper_drone
// Params 0
// Checksum 0xe942294c, Offset: 0xa44
// Size: 0x132
function function_13034abc372edc80()
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return;
    }
    
    foreach ( entry in bundle.var_8f21800662496353 )
    {
        if ( !entry.proasset )
        {
            continue;
        }
        
        overclockbundle = getscriptbundle( entry.proasset );
        
        if ( !overclockbundle )
        {
            continue;
        }
        
        if ( overclockbundle.var_f088013d20169bf3 == #"none" )
        {
            assertmsg( "<dev string:x24>" );
            continue;
        }
        
        turretweapon = overclockbundle.var_8e8819d71a19d8c3;
        
        if ( turretweapon )
        {
            killstreaks::registerkillstreakdamagedealingweapon( "sniper_drone", turretweapon, #"low" );
        }
    }
}

// Namespace sniper_drone
// Params 0
// Checksum 0xa27401d5, Offset: 0xb7e
// Size: 0xc9
function function_d0cc685116f2c7b()
{
    val::group_register( "sniperDrone_deploy", [ "allow_jump", "killstreaks" ] );
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_abbcd9152e41d77f" ) && ![[ utility::getsharedfunc( #"equipment", #"hash_abbcd9152e41d77f" ) ]]() )
    {
        val::group_register( "sniperDrone_use", [ "usability", "shellshock", "melee", "vehicle_use" ] );
        return;
    }
    
    val::group_register( "sniperDrone_use", [ "usability", "shellshock", "melee", "vehicle_use", "nvg" ] );
}

// Namespace sniper_drone
// Params 1
// Checksum 0x4fa0d83a, Offset: 0xc4f
// Size: 0x186
function function_fcdb9bb6dd56c61f( shoulddebug )
{
    radiuscheck = 20;
    var_87206c2adee9ca78 = 30;
    startheight = 25;
    minrise = 9;
    maxrise = 107;
    
    /#
        if ( shoulddebug )
        {
            duration = 1;
        }
    #/
    
    eyepos = self geteye();
    var_c76584854752d352 = eyepos + anglestoforward( self getplayerangles( 1 ) ) * var_87206c2adee9ca78;
    var_e8669987d1f97c05 = var_c76584854752d352 + ( 0, 0, startheight );
    contents = trace::function_95e6759db38fe94e();
    hits = physics_spherecast( var_e8669987d1f97c05, var_c76584854752d352 + ( 0, 0, maxrise ), radiuscheck, contents, undefined, "physicsquery_closest" );
    
    if ( !hits.size )
    {
        startpos = var_c76584854752d352 + ( 0, 0, maxrise - radiuscheck );
        
        /#
            if ( shoulddebug )
            {
                sphere( startpos, radiuscheck, ( 0, 1, 0 ), 0, duration );
            }
        #/
        
        return startpos;
    }
    else
    {
        hitz = hits[ 0 ][ "position" ][ 2 ] - radiuscheck;
        rise = hitz - var_e8669987d1f97c05[ 2 ];
        startpos = var_e8669987d1f97c05 + ( 0, 0, rise );
        
        if ( rise >= minrise )
        {
            /#
                if ( shoulddebug )
                {
                    sphere( startpos, radiuscheck, ( 0, 0, 1 ), 0, duration );
                }
            #/
            
            return startpos;
        }
    }
    
    /#
        if ( shoulddebug )
        {
            sphere( startpos, radiuscheck, ( 1, 0, 0 ), 0, duration );
        }
    #/
}

/#

    // Namespace sniper_drone
    // Params 0, eflags: 0xc
    // Checksum 0xff9fb5f8, Offset: 0xdde
    // Size: 0x2e, Type: dev
    function private function_bf4e481f09a2c704()
    {
        self notify( #"hash_95f7cad44688a5de" );
        self endon( #"hash_95f7cad44688a5de" );
        
        while ( self )
        {
            function_fcdb9bb6dd56c61f( 1 );
            waitframe();
        }
    }

#/

// Namespace sniper_drone
// Params 1
// Checksum 0x676a0b0c, Offset: 0xe14
// Size: 0x7c1, Type: bool
function tryusesniperdrone( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    /#
    #/
    
    helperdronetype = streakinfo.streakname;
    startpos = function_fcdb9bb6dd56c61f();
    
    if ( !isdefined( startpos ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    bundle = streakinfo.bundle;
    blueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_22fce0b7d0d69175" ) )
    {
        var_9af4377dd7b1d62e = utility::callsharedfunc( #"killstreak", #"hash_22fce0b7d0d69175" );
    }
    
    if ( streakinfo.mpstreaksysteminfo.blueprintindex == 0 && var_9af4377dd7b1d62e )
    {
        var_ec7a8f4f92a59bc3 = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( var_9af4377dd7b1d62e, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    else if ( blueprintname )
    {
        var_ec7a8f4f92a59bc3 = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( blueprintname, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    
    killstreak_utility::function_7ab4bfe11ada17a( bundle );
    deployweaponobj = var_ec7a8f4f92a59bc3 ?? makeweapon( bundle.deployweaponname ?? "ks_remote_device_mp" );
    val::group_set( "sniperDrone_deploy", 0 );
    killstreak_shared::starttabletscreen( streakinfo.streakname, 0.05, 1 );
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &helper_drone::weapongivenhelperdrone, &weaponswitchendedcallback );
    
    if ( !deployresult || level.gameended )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        val::group_reset( "sniperDrone_deploy" );
        return false;
    }
    
    streakinfo.streakduration = level.helperdronesettings[ "sniper_drone" ].timeout;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            self setclientomnvar( o"ui_using_killstreak_remote", 0 );
            val::group_reset( "sniperDrone_deploy" );
            return false;
        }
    }
    
    thread function_cd1785b12bd2c5f( streakinfo );
    var_fd467b160103911b = 0.5;
    fullanimtime = 2.8;
    player::_freezecontrols( 1 );
    result = utility::waittill_any_timeout( var_fd467b160103911b, "death", "weapon_switch_started" );
    
    if ( result != "timeout" || self isswimming() || level.gameended )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        player::_freezecontrols( 0 );
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        self notify( #"hash_e5587a9a76e2b2be" );
        val::group_reset( "sniperDrone_deploy" );
        return false;
    }
    
    result = utility::waittill_any_timeout( fullanimtime - var_fd467b160103911b, "death" );
    
    if ( result != "timeout" || self isswimming() || level.gameended )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        player::_freezecontrols( 0 );
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        self notify( #"hash_e5587a9a76e2b2be" );
        val::group_reset( "sniperDrone_deploy" );
        return false;
    }
    
    startpos = function_fcdb9bb6dd56c61f();
    
    if ( !isdefined( startpos ) )
    {
        if ( isdefined( level.sharedfuncs[ #"hud" ][ #"showerrormessage" ] ) )
        {
            self [[ level.sharedfuncs[ #"hud" ][ #"showerrormessage" ] ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        player::_freezecontrols( 0 );
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        self notify( #"hash_e5587a9a76e2b2be" );
        val::group_reset( "sniperDrone_deploy" );
        return false;
    }
    
    sniperDrone = sniperdrone_create( startpos, self.angles, helperdronetype, streakinfo );
    player::_freezecontrols( 0 );
    
    if ( !isdefined( sniperDrone ) )
    {
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        self notify( #"hash_e5587a9a76e2b2be" );
        val::group_reset( "sniperDrone_deploy" );
        return false;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( bundle.usedsplashref, self );
    }
    
    sniperDrone setotherent( self );
    sniperDrone setvehicleteam( self.team );
    sniperDrone.bundlename = sniperDrone.vehiclename;
    vehicle_tracking::register_instance( sniperDrone, self, self.team );
    vehicle_occupancy::register_instance( sniperDrone );
    thread helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
    
    if ( isdefined( level.sharedfuncs[ #"killstreak" ][ #"killstreakuse" ] ) )
    {
        self [[ level.sharedfuncs[ #"killstreak" ][ #"killstreakuse" ] ]]( "recon_drone" );
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_e360b168744d9b7 )
    {
        sniperDrone vehicleshowonminimap( 0 );
        var_65934120c2efeb81 = undefined;
        
        if ( isdefined( level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ] ) )
        {
            self [[ level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ] ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2;
        }
        
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "sniper_drone" + "_use", #"use", 1, var_65934120c2efeb81 );
        sniperDrone helper_drone::helperdrone_notifyenemyplayersinrange( helperdronetype );
    }
    
    helper_drone::function_bc4c01fe510bb495( streakinfo );
    thread helper_drone::starthelperdrone( sniperDrone, undefined, 1 );
    sniperDrone thread function_ec56e40f74244fe8( self, level.helperdronesettings[ "sniper_drone" ].timeout );
    sniperDrone thread function_cba8775b70fe149b( self );
    sniperDrone function_d121d395c8e80c4c();
    sniperDrone setscriptablepartstate( "deploy", "on", 0 );
    sniperDrone.var_485899a46494a80f = &function_2a9e753a6a25fec1;
    
    if ( sniperDrone )
    {
        alertfulllength = level.helperdronesettings[ "sniper_drone" ].timeout / 4;
        var_c3193942aa25f78 = 0.25;
        var_28e5801bce7f4815 = 0.65;
        var_b84c3eae995cb030 = 0.001;
        var_ed6c729701a7f3ed = 0.05;
        endtime = gettime() + utility::function_4b74c15943231980( level.helperdronesettings[ "sniper_drone" ].timeout );
        sniperDrone.lifetimeendtime = int( endtime );
        sniperDrone thread killstreak_shared::function_585fb909f40d8659( endtime, alertfulllength, var_c3193942aa25f78, var_28e5801bce7f4815, var_b84c3eae995cb030, var_ed6c729701a7f3ed );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        sniperDrone [[ var_32dbca3143d9c4a5 ]]( 0, 0, 0, 1, 1, &function_f464894e8df688cb );
    }
    
    self notify( #"hash_e5587a9a76e2b2be" );
    return true;
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0xbabda589, Offset: 0x15de
// Size: 0x60
function private function_f464894e8df688cb( params )
{
    if ( params.attacker.streakinfo && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( params.attacker.streakinfo, undefined, #"hash_8d58bbe685c4f1a1" );
    }
}

// Namespace sniper_drone
// Params 0, eflags: 0x4
// Checksum 0xfe93d0be, Offset: 0x1646
// Size: 0x2e
function private function_d121d395c8e80c4c()
{
    emp_debuff::add_emp_ent( self );
    emp_debuff::set_start_emp_callback( &empstarted );
    emp_debuff::set_apply_emp_callback( &empapplied );
    emp_debuff::set_clear_emp_callback( &empcleared );
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x208ef4c0, Offset: 0x167c
// Size: 0x128
function private empstarted( data )
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    
    if ( bundle.empgrenadeeffect == #"destroyed" )
    {
        return;
    }
    
    if ( isdefined( bundle.var_5c8929409acb483f ) && isdefined( bundle.var_7a7e0d61f7cdc61b ) )
    {
        self setscriptablepartstate( bundle.var_5c8929409acb483f, bundle.var_7a7e0d61f7cdc61b, 0 );
    }
    
    if ( bundle.var_3d9223c5cc20c546 )
    {
        scrambleintensity = bundle.var_f267719d7f291a97 ?? 5;
        thread emp_debuff::play_scramble_for_player_until_cleared( self.owner, scrambleintensity );
    }
    
    if ( bundle.var_5e542ab8ac169942 )
    {
        self.owner player::_freezecontrols( 1 );
    }
    
    if ( bundle.var_fe9dc2384a7eadf0 )
    {
        self.owner player::_freezelookcontrols( 1 );
    }
    
    if ( bundle.var_4741c21927224e6d )
    {
        vehicle_omnvar::show_warning( "DDoSed", self.owner, vehicle::get_ref() );
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x719fa792, Offset: 0x17ac
// Size: 0x52
function private empapplied( data )
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    
    if ( bundle.empgrenadeeffect == #"destroyed" )
    {
        sniperdrone_handledeathdamage( data );
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0xa318ff48, Offset: 0x1806
// Size: 0xec
function private empcleared( fromdeath )
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    
    if ( bundle.empgrenadeeffect == #"destroyed" )
    {
        return;
    }
    
    if ( isdefined( bundle.var_5c8929409acb483f ) && isdefined( bundle.var_a17f2b798564cbec ) )
    {
        self setscriptablepartstate( bundle.var_5c8929409acb483f, bundle.var_a17f2b798564cbec, 0 );
    }
    
    if ( bundle.var_5e542ab8ac169942 )
    {
        self.owner player::_freezecontrols( 0 );
    }
    
    if ( bundle.var_fe9dc2384a7eadf0 )
    {
        self.owner player::_freezelookcontrols( 0 );
    }
    
    if ( bundle.var_4741c21927224e6d )
    {
        vehicle_omnvar::hide_warning( "DDoSed", self.owner, vehicle::get_ref() );
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x9fb1a4de, Offset: 0x18fa
// Size: 0xbd
function private function_f2fdd019aa1d97a6( jammedsniperdrone )
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    maxspeed = jammedsniperdrone function_7fcf4bbd01d894de( 1 );
    var_880301bf15891cb1 = jammedsniperdrone function_5fe67fbdb598e58c( 1 );
    var_7933d08aada2e4ec = bundle.var_7933d08aada2e4ec ?? 0.5;
    jammedsniperdrone function_5a9a3101070af0ea( maxspeed * var_7933d08aada2e4ec );
    jammedsniperdrone function_bb24f8f5818062a8( var_880301bf15891cb1 * var_7933d08aada2e4ec );
    pbgpostfxbundlestart( jammedsniperdrone.owner, bundle.var_812c899cf33a8dae );
    jammedsniperdrone setscriptablepartstate( #"emp", #"on", 0 );
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x589aaf45, Offset: 0x19bf
// Size: 0x9a
function private function_655bd8caffa5d850( jammedsniperdrone )
{
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    maxspeed = jammedsniperdrone function_7fcf4bbd01d894de( 1 );
    var_880301bf15891cb1 = jammedsniperdrone function_5fe67fbdb598e58c( 1 );
    jammedsniperdrone function_5a9a3101070af0ea( maxspeed );
    jammedsniperdrone function_bb24f8f5818062a8( var_880301bf15891cb1 );
    pbgpostfxbundleend( jammedsniperdrone.owner, bundle.var_812c899cf33a8dae );
    jammedsniperdrone setscriptablepartstate( #"emp", #"off", 0 );
}

// Namespace sniper_drone
// Params 2, eflags: 0x4
// Checksum 0xaa90cbdf, Offset: 0x1a61
// Size: 0x37
function private weaponswitchendedcallback( streakinfo, switchresult )
{
    if ( switchresult )
    {
        self setclientomnvar( o"ui_using_killstreak_remote", 1 );
        thread function_1594f952a6588e66( 2.8 );
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x7f2d6a27, Offset: 0x1aa0
// Size: 0xe8
function private function_1594f952a6588e66( delay )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
    assert( isdefined( bundle.var_a2a4d5615a05cfcf ), "<dev string:x61>" );
    
    if ( bundle.var_a2a4d5615a05cfcf == 0 )
    {
        return;
    }
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( bundle.var_8b43cd747014ec7e )
    {
        thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
        return;
    }
    
    self playlocalsound( bundle.var_d09f98defa2e28d1 );
    fullscreenfxparams = { #postfxbundlename:bundle.var_60e3191e4f02b998 };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace sniper_drone
// Params 4
// Checksum 0xafd8667a, Offset: 0x1b90
// Size: 0x103
function sniperdrone_create( startpos, startang, helperdronetype, streakinfo )
{
    streakinfo.var_27b09523e68cae9e = streakinfo.bundle.sniperdronevehicle;
    sniperDrone = helper_drone::createhelperdrone( startpos, startang, helperdronetype, streakinfo, 0, 1 );
    
    if ( !isdefined( sniperDrone ) )
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
    
    return sniperDrone;
}

// Namespace sniper_drone
// Params 1
// Checksum 0xb8aef1a3, Offset: 0x1c9c
// Size: 0x55
function function_c4564cddfa8d301( config )
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
    
    thread function_8c8036bbf0e8fd11( config );
}

// Namespace sniper_drone
// Params 1
// Checksum 0x7edf345b, Offset: 0x1cf9
// Size: 0x45f, Type: bool
function function_8c8036bbf0e8fd11( config )
{
    bundle = self.streakinfo.bundle;
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    self.owner notify( #"dronestart" );
    self.owner setclientomnvar( "ui_killstreak_grenades_button_enabled", bundle.var_dbde1407c5fafcfb ?? 0 );
    targetmarkersettings = bundle.targetmarkersettings ? getscriptbundle( bundle.targetmarkersettings ) : undefined;
    var_1e1ecace3b3c2a63 = targetmarkersettings.var_1e1ecace3b3c2a63 ?? 0;
    var_ee7bc8b53cebd37e = targetmarkersettings.var_ee7bc8b53cebd37e ?? 0;
    params = { #var_ee7bc8b53cebd37e:var_ee7bc8b53cebd37e, #var_1e1ecace3b3c2a63:var_1e1ecace3b3c2a63, #hideoverlaytargetmarkerfriendly:1, #var_d33b439c3dce3f3d:bundle.var_598d79add3230927 };
    self.owner killstreak_shared::killstreak_assigntargetmarkers( params );
    self.playersfx = spawn( "script_origin", self.origin );
    self.playersfx showonlytoplayer( self.owner );
    self.playersfx linkto( self );
    self.playersfx playloopsound( "recon_drone_overlay" );
    self.owner setsoundsubmix( "mp_recon_drone", 1 );
    maxaltitude = 1250;
    
    if ( !isbrgamemode() )
    {
        heightstruct = utility::getstruct( "drone_max_altitude", "script_noteworthy" );
        
        if ( heightstruct )
        {
            maxaltitude = heightstruct.origin[ 2 ];
        }
    }
    else
    {
        maxaltitude = 6000;
    }
    
    self function_6a4bed1cbdcc8027( maxaltitude );
    self.ispiloted = 1;
    self.driver = 1;
    
    if ( bundle.var_da83886af12f3ecc )
    {
        self.owner ai::set_ignoreme( 1 );
    }
    
    if ( self.super && utility::issharedfuncdefined( #"supers", #"setsuperisactive" ) )
    {
        self.owner thread [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 1 );
    }
    
    self.owner val::group_set( "sniperDrone_use", 0 );
    self.owner val::group_reset( "sniperDrone_deploy" );
    self.owner player::_freezecontrols( 0, 1, "sniperDrone" );
    self.owner player::_freezelookcontrols( 0, 1 );
    self.owner.restoreangles = self.owner.angles;
    self.owner setplayerangles( self.angles );
    self.owner usevehicle( self, 0 );
    thread sniperdrone_watchads();
    self.owner render_utility::function_2636a65c7f96feff( 1, 0, 0.015, 0.15 );
    self.owner setclientomnvar( "ui_killstreak_health", self.currenthealth / self.maxhealth );
    self.owner painvisionoff();
    self.owner killstreak_shared::killstreak_savenvgstate();
    killstreak_utility::movingplatform_playerlink( self.owner );
    thread function_4a70ed136e059759( 0.6 );
    outofbounds::function_4cb3ccaabd7eedf9();
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( self, "killstreak" );
    utility::registersharedfunc( bundle.sniperdronevehicle, #"interactswithoobtrigger", &function_975459c3bb2ec9fb );
    self.owner notifyonplayercommand( "sniper_drone_fire", "+attack" );
    
    if ( bundle.var_dbde1407c5fafcfb )
    {
        if ( self.owner usinggamepad() )
        {
            self.owner notifyonplayercommand( "sniper_drone_grenade", "+stance" );
        }
        else
        {
            self.owner notifyonplayercommand( "sniper_drone_grenade", "+reload" );
        }
    }
    
    thread function_c5996caa433fbad5();
    thread function_263273d43f65c5f9();
    self.owner allowads( 1 );
    return true;
}

// Namespace sniper_drone
// Params 1
// Checksum 0xbb766dba, Offset: 0x2161
// Size: 0x42
function function_4a70ed136e059759( delay )
{
    wait delay;
    
    if ( self.owner && self.ispiloted )
    {
        self.owner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "sniper_drone", "on" );
    }
}

// Namespace sniper_drone
// Params 0
// Checksum 0xe6e38cd3, Offset: 0x21ab
// Size: 0x69
function sniperdrone_watchads()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    
    while ( self )
    {
        if ( self.owner playerads() )
        {
            self setscriptablepartstate( "glint", "on" );
        }
        else
        {
            self setscriptablepartstate( "glint", "off" );
        }
        
        waitframe();
    }
}

// Namespace sniper_drone
// Params 2
// Checksum 0x362195a, Offset: 0x221c
// Size: 0x2d, Type: bool
function function_975459c3bb2ec9fb( trigger, vehicle )
{
    if ( trigger.targetname == "Drone_OutOfBounds" )
    {
        return true;
    }
    
    return false;
}

// Namespace sniper_drone
// Params 0
// Checksum 0x7c3bc469, Offset: 0x2252
// Size: 0x9
function sniperdrone_exit()
{
    thread sniperdrone_leave();
}

// Namespace sniper_drone
// Params 1
// Checksum 0x142f3f25, Offset: 0x2263
// Size: 0x18
function sniperdrone_leave( timeout )
{
    thread helper_drone::helperdrone_explode( 0, 1, timeout );
}

// Namespace sniper_drone
// Params 7
// Checksum 0xa9e1f01a, Offset: 0x2283
// Size: 0x8b
function sniperdrone_explode( config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson, damagedata )
{
    if ( self.owner )
    {
        self.owner killstreak_shared::function_b3302c4317df36c6();
    }
    
    namespace_9d8e359c3b1041e5::clearoobsharedfunc( self, 1 );
    
    if ( self.ispiloted )
    {
        sniperdrone_returnplayer( self.owner );
    }
    
    helper_drone::function_e44894e06827a3a9();
}

// Namespace sniper_drone
// Params 2
// Checksum 0xdc835ce2, Offset: 0x2316
// Size: 0x20e
function sniperdrone_returnplayer( player, delayreturn )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    self setotherent( undefined );
    
    if ( player isvehicleactive() )
    {
        player leavevehicle( 0 );
    }
    
    player thread function_6a2d6a59711636b3( self.streakinfo );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    self.ispiloted = 0;
    self.owner ai::set_ignoreme( 0 );
    
    if ( self.super && utility::issharedfuncdefined( #"supers", #"setsuperisactive" ) )
    {
        self.owner thread [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 0 );
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    tabletweapon = "ks_remote_drone_mp";
    
    if ( self.var_99e2d83f9d0b250a )
    {
        tabletweapon = "ks_remote_device_mp";
    }
    
    player thread recon_drone::recondrone_takedeployweapon( 1, tabletweapon );
    player helper_drone::helperdrone_takeplayerfauxremote( self.streakinfo );
    player painvisionon();
    player killstreak_utility::killstreak_setmainvision( "" );
    player namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "sniper_drone", "off" );
    player setclientomnvar( "ui_killstreak_grenades_button_enabled", 0 );
    
    if ( emp_debuff::is_empd() )
    {
        empcleared( 0 );
    }
    
    player thread helper_drone::function_ab65cb511ffc8807();
    player player::_freezecontrols( 0, 1, "sniperDrone" );
    player player::_freezelookcontrols( 0, 1 );
    player val::group_reset( "sniperDrone_use" );
    player render_utility::function_7d5ac95f0cd3294a();
    killstreak_utility::movingplatform_playerunlink( player );
    
    if ( player::isreallyalive( player ) && isdefined( player.restoreangles ) )
    {
        player setplayerangles( ( player.restoreangles[ 0 ], player.restoreangles[ 1 ], 0 ) );
    }
    
    player.restoreangles = undefined;
    player killstreak_shared::killstreak_restorenvgstate();
}

// Namespace sniper_drone
// Params 1
// Checksum 0xf449ecda, Offset: 0x252c
// Size: 0x2c
function function_6a2d6a59711636b3( streakinfo )
{
    bundle = streakinfo.bundle;
    thread killstreak_utility::function_7018f59706013760( bundle );
}

// Namespace sniper_drone
// Params 0
// Checksum 0x4f12645c, Offset: 0x2560
// Size: 0xb5
function function_c5996caa433fbad5()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    bundle = self.streakinfo.bundle;
    var_ab07139b0e7b2609 = bundle.var_fc0c9acee67e217e;
    var_22778fcce37099d5 = bundle.var_3b30619dbd786e6c;
    
    while ( true )
    {
        self.owner setclientomnvar( "ui_veh_ammo_0", self function_4a982264b67c1076() );
        self waittill( #"vehicle_turret_fire" );
        self.owner earthquakeforplayer( var_ab07139b0e7b2609, var_22778fcce37099d5, self.origin, 500 );
    }
}

// Namespace sniper_drone
// Params 0
// Checksum 0x1da3662c, Offset: 0x261d
// Size: 0x1c7
function function_263273d43f65c5f9()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    bundle = self.streakinfo.bundle;
    
    if ( bundle.var_dbde1407c5fafcfb )
    {
        grenades = bundle.sniperdronegrenades;
    }
    
    if ( !isdefined( grenades ) )
    {
        grenades = 0;
    }
    
    grenadename = bundle.projectileweapon;
    self.owner setclientomnvar( "ui_veh_ammo_1", grenades );
    
    while ( true )
    {
        result = self.owner utility::waittill_any_return( "sniper_drone_grenade" );
        
        if ( emp_debuff::is_empd() && bundle.var_e85cc0351c70d74c )
        {
            continue;
        }
        
        if ( result == "sniper_drone_grenade" )
        {
            if ( grenades > 0 )
            {
                var_50dc21b34ea7a147 = anglestoforward( self.owner getplayerangles() );
                var_93012ba28e57c53b = self vehicle_getvelocity() + var_50dc21b34ea7a147 * 1055 + ( 0, 0, 140 );
                grenade = self.owner namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( grenadename, self.origin, var_93012ba28e57c53b, undefined, 0 );
                grenade setmagicgrenadecollision( 0 );
                grenade utility::delaycall( 0.1, &setmagicgrenadecollision, 1 );
                self setscriptablepartstate( #"launch_grenade", #"on", 0 );
                grenade.streakinfo = self.streakinfo;
                grenades--;
            }
            else
            {
                self.owner playlocalsound( "kls_sat_sniper_drone_dryfire_plr" );
            }
        }
        
        self.owner setclientomnvar( "ui_veh_ammo_1", grenades );
    }
}

// Namespace sniper_drone
// Params 1
// Checksum 0xf7bee75c, Offset: 0x27ec
// Size: 0x47
function postmodifydamage( data )
{
    if ( self.var_e4375318293ea745 )
    {
        return 0;
    }
    
    if ( self.health - data.damage <= 0 )
    {
        self.var_e4375318293ea745 = 1;
    }
    
    return helper_drone::helperdrone_postmodifydamage( data );
}

// Namespace sniper_drone
// Params 1
// Checksum 0xb9069066, Offset: 0x283c
// Size: 0xe8
function sniperdrone_handledeathdamage( params )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( params.objweapon.var_25b0062cbe4d9c99 == #"black_hat_sat_mp" && self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
    }
    
    if ( params.attacker && self.owner && player_utility::playersareenemies( self.owner, params.attacker ) )
    {
        params.attacker thread points::doscoreevent( #"hash_cf25a81671c3019d" );
    }
    
    self.attackerdata = undefined;
    self.owner leavevehicle( 0 );
    helper_drone::helperdrone_handledeathdamage( params );
}

// Namespace sniper_drone
// Params 1
// Checksum 0x1abac55b, Offset: 0x292c
// Size: 0x12c
function function_cba8775b70fe149b( owner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    currentfov = owner playerads();
    var_20e7a11b199821fe = self.origin[ 2 ];
    owner setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
    owner setclientomnvar( "ui_altimeter_vertical_movement_state", 0 );
    
    while ( true )
    {
        if ( owner playerads() != currentfov )
        {
            currentfov = owner playerads();
            owner setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
        }
        
        if ( owner function_fadc0f718a6cfc84() )
        {
            owner setclientomnvar( "ui_altimeter_vertical_movement_state", 1 );
        }
        else if ( owner flydownbuttonpressed() )
        {
            owner setclientomnvar( "ui_altimeter_vertical_movement_state", 2 );
        }
        else
        {
            owner setclientomnvar( "ui_altimeter_vertical_movement_state", 0 );
        }
        
        if ( self.origin[ 2 ] != var_20e7a11b199821fe )
        {
            var_20e7a11b199821fe = self.origin[ 2 ];
            owner setclientomnvar( "ui_altimeter_altitude_hiprecise_m", 0.0254 * var_20e7a11b199821fe );
        }
        
        waitframe();
    }
}

// Namespace sniper_drone
// Params 3
// Checksum 0x971fe4dc, Offset: 0x2a60
// Size: 0xe3
function function_ec56e40f74244fe8( owner, lifetime, infinite )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    if ( infinite || !isdefined( lifetime ) || lifetime <= 0 )
    {
        owner setclientomnvar( "ui_killstreak_lifetime", 1 );
        return;
    }
    
    lifetimems = lifetime * 1000;
    endtimems = gettime() + lifetimems;
    
    while ( true )
    {
        timeleftms = endtimems - gettime();
        
        if ( timeleftms <= 0 )
        {
            owner setclientomnvar( "ui_killstreak_lifetime", 0 );
            break;
        }
        
        owner setclientomnvar( "ui_killstreak_lifetime", timeleftms / lifetimems );
        waitframe();
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x3531575a, Offset: 0x2b4b
// Size: 0x7c
function private function_734f27337948fa14( deathdata )
{
    objweapon = deathdata.objweapon;
    streakinfo = deathdata.inflictor.streakinfo;
    
    if ( streakinfo && objweapon.basenamehash == level.helperdronesettings[ "sniper_drone" ].projectileweapon )
    {
        streakinfo.grenadekills++;
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0x9af98017, Offset: 0x2bcf
// Size: 0xaf
function private function_2a9e753a6a25fec1( trigger )
{
    sniperDrone = self;
    sniperDrone setscriptablepartstate( #"deploy", #"on_snapped" );
    
    if ( sniperDrone.owner )
    {
        bundle = level.streakglobals.streakbundles[ "sniper_drone" ];
        fullscreenfxparams = { #postfxbundlename:bundle.var_60e3191e4f02b998 };
        sniperDrone.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
    }
}

// Namespace sniper_drone
// Params 1, eflags: 0x4
// Checksum 0xc4d129d0, Offset: 0x2c86
// Size: 0x6f
function private function_cd1785b12bd2c5f( streakinfo )
{
    self endon( #"disconnect", #"hash_e5587a9a76e2b2be" );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
}

