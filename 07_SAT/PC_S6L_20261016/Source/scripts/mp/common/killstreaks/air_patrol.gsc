// scripts\mp\common\killstreaks\air_patrol.gsc  (hash_1781fcdd18db5711.gscc) (size: 36307 Bytes / 0x8dd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18f7e50b (418899211)
// size ...... 36307 (0x8dd3)
// includes .. 19  (offset: 0x871f)
// strings ... 90  (offset: 0x87b7)
// dev strs .. 11  (offset: 0x8d4b)
// exports ... 79  (offset: 0x602b)
// cseg ...... 0x6d3 + 0x5958 (0x602b)
// imports ... 212 (offset: 0x6c83)
// animtree1 . 0   (offset: 0x8dd3)
// animtree2 . 0   (offset: 0x8dd3)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;

#namespace air_patrol;

// Namespace air_patrol
// Params 0, eflags: 0x1
// Checksum 0x296354a, Offset: 0x6f1
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "air_patrol" ), &air_patrol_init );
}

// Namespace air_patrol
// Params 0
// Checksum 0x55fd63e3, Offset: 0x710
// Size: 0x1f
function air_patrol_init()
{
    killstreaks::registerkillstreak( "air_patrol", &function_e5cbf13c1eaac569, &function_f27d0d741260a3c6 );
    init();
}

// Namespace air_patrol
// Params 0
// Checksum 0xa6fd1432, Offset: 0x737
// Size: 0x441
function init_airpatrol_params()
{
    level.airpatrolsettings = {};
    level.airpatrolsettings.bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    level.airpatrolsettings.streakname = "air_patrol";
    bundle = level.airpatrolsettings.bundle;
    level.airpatrolsettings.missileweapon = bundle.var_8da7e710414015f8 ?? "air_patrol_proj_mp";
    level.airpatrolsettings.var_e502209c4a42cad8 = bundle.var_6a816b15c6190f66 ?? "air_patrol_no_damage_proj_mp";
    level.airpatrolsettings.var_c178ca8b164fe9e4 = bundle.alliesplanemodel ?? "veh_t10_mil_eu_air_fighter";
    level.airpatrolsettings.var_5f677a962ed91117 = bundle.axisplanemodel ?? "veh9_mil_air_suniform25_mp";
    level.airpatrolsettings.flyoverscene = bundle.var_b948a20a54e81b55 ?? "t10_killstreak_air_patrol_flyover_01";
    level.airpatrolsettings.dogfightscene = bundle.var_5665a239111cf368 ?? "t10_killstreak_air_patrol_dogfight";
    level.airpatrolsettings.var_a9893cd64762fe63 = "ks_airstrike_mp";
    level.airpatrolsettings.health = 999999;
    level.airpatrolsettings.maxhealth = 800;
    level.airpatrolsettings.var_ed5279b45aea0259 = 0;
    level.airpatrolsettings.var_712442d57238a084 = 3;
    level.airpatrolsettings.var_a9a2932d999655 = 0;
    level.airpatrolsettings.vehicletargetscategory = [];
    level.airpatrolsettings.var_1e33b6a4ab9dbfd = bundle.var_c1fd81264ec7d1fe ?? 0.55;
    level.airpatrolsettings.var_2216041e962f5709 = bundle.var_d3957c7b7c9713ec ?? 1;
    level.airpatrolsettings.var_ce5a78eae7b935d7 = bundle.var_d7dc549e6b6b331a ?? 2000;
    
    if ( !isdefined( bundle ) || !bundle.var_5bef6cc593749fc2 )
    {
        level.airpatrolsettings.vehicletargetscategory = [ "air_patrol", "chopper", "flying_chopper_door_gunner", "directional_uav", "counter_uav", "napalm_strike", "scrambler_drone_guard", "uav", "valkyrie_rocket", "switchblade_drone", "loitering_munition", "hover_jet", "gunship", "airdrop_escort", "airdrop" ];
    }
    else
    {
        foreach ( vehicleentry in bundle.airpatrolvehicleentries )
        {
            if ( isdefined( vehicleentry.name ) )
            {
                level.airpatrolsettings.vehicletargetscategory[ level.airpatrolsettings.vehicletargetscategory.size ] = vehicleentry.name;
            }
        }
    }
    
    if ( isdefined( bundle ) )
    {
        weapon::registerkillstreakweaponmap( "air_patrol", level.airpatrolsettings.missileweapon );
        weapon::registerkillstreakweaponmap( "air_patrol", level.airpatrolsettings.var_e502209c4a42cad8 );
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "air_patrol", level.airpatrolsettings.missileweapon, #"oneshot" );
    }
}

// Namespace air_patrol
// Params 0
// Checksum 0x2dce85e6, Offset: 0xb80
// Size: 0x92
function init()
{
    level._effect[ "airpatrol_tracer" ] = loadfxasset( "vfx_iw8_mp_strk_a10_tracer_sep" );
    level callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    init_airpatrol_params();
    init_airpatrol_vo();
    level.var_cd0c9dd138b66e7 = [];
    level.airpatrolcount = 0;
    
    /#
        setdevdvarifuninitialized( @"scr_debugairpatrol", 0 );
        setdevdvarifuninitialized( @"hash_6d5c2800fdfcab05", 0 );
        setdevdvarifuninitialized( @"hash_ffa324b8df420e25", 0 );
        setdevdvarifuninitialized( @"hash_62df82b1a0e3f5e0", 0 );
    #/
}

// Namespace air_patrol
// Params 1, eflags: 0x4
// Checksum 0x8c855663, Offset: 0xc1a
// Size: 0xa9
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    bundle = level.airpatrolsettings.bundle;
    weaponname = bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp";
    
    if ( params.objweapon.basename == weaponname )
    {
        attacker.var_4c99c8a81c239b07 = 1;
    }
}

// Namespace air_patrol
// Params 0
// Checksum 0x754b93da, Offset: 0xccb
// Size: 0x4d
function init_airpatrol_vo()
{
    game[ "dialog" ][ "precision_airstrike_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "precision_airstrike_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "precision_airstrike_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace air_patrol
// Params 1
// Checksum 0xc62ab92c, Offset: 0xd20
// Size: 0x29
function tryuseairpatrol( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return function_e5cbf13c1eaac569( streakinfo );
}

// Namespace air_patrol
// Params 1
// Checksum 0xe8ae7e62, Offset: 0xd52
// Size: 0x217, Type: bool
function function_e5cbf13c1eaac569( streakinfo )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    useresult = airpatrol_canbeused( self );
    
    if ( useresult != "success" && useresult != "dogfight" )
    {
        if ( isdefined( streakinfo.owner ) && isdefined( streakinfo.var_9384480e6997afd7 ) )
        {
            thread killstreak_utility::function_40efaac4d5b5a5b8( streakinfo.var_9384480e6997afd7, useresult );
        }
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
        }
        
        return false;
    }
    
    gestureweaponobj = makeweapon( bundle.deployweaponname );
    animationresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, gestureweaponobj );
    var_b150839c36231d7f = "airPatrolUsed";
    
    if ( !animationresult )
    {
        if ( isbrgamemode() )
        {
            self setclientomnvar( "ui_using_airpatrol", 0 );
            thread killstreak_utility::function_40efaac4d5b5a5b8( streakinfo.var_9384480e6997afd7 );
        }
        
        return false;
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_using_airpatrol", 1 );
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    airpatrolid = function_31f147bb7196d9ec( self );
    function_50dba23f04ff7527( streakinfo, airpatrolid );
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, var_b150839c36231d7f );
    }
    
    self.var_dda5ef0b107c7d42[ level.airpatrolsettings.missileweapon ] = streakinfo;
    return true;
}

// Namespace air_patrol
// Params 1
// Checksum 0xebaa521d, Offset: 0xf72
// Size: 0x15
function function_f27d0d741260a3c6( streakinfo )
{
    thread function_9383881dca8fb28d( streakinfo );
}

// Namespace air_patrol
// Params 1
// Checksum 0xdb77ed4d, Offset: 0xf8f
// Size: 0x253, Type: bool
function function_1fc8096c7db31762( owner )
{
    /#
        if ( getdvarint( @"hash_6d5c2800fdfcab05", 0 ) == 1 )
        {
            return true;
        }
        else if ( getdvarint( @"hash_ffa324b8df420e25", 0 ) == 1 )
        {
            return true;
        }
        else if ( getdvarint( @"hash_62df82b1a0e3f5e0", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    bundle = owner killstreak::function_85b2d8e857ab4898( "air_patrol" );
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    if ( bundle.var_613971e3fffbbb57 )
    {
        return true;
    }
    
    allentities = getentarray();
    var_9373d2c56cb4b452 = [];
    
    foreach ( ent in allentities )
    {
        isenemy = isdefined( ent.team ) && owner player_utility::isenemy( ent );
        
        if ( isenemy && ent.isairkillstreak )
        {
            var_9373d2c56cb4b452[ var_9373d2c56cb4b452.size ] = ent;
        }
    }
    
    foreach ( category in level.airpatrolsettings.vehicletargetscategory )
    {
        foreach ( ent in var_9373d2c56cb4b452 )
        {
            if ( ent.streakname == category || isdefined( ent vehicle::get_ref() ) && ent vehicle::get_ref() == category )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace air_patrol
// Params 3
// Checksum 0x9d91ba17, Offset: 0x11eb
// Size: 0x482
function findtargets( airpatrolid, owner, passcount )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return [];
    }
    
    allentities = getentarray();
    var_9373d2c56cb4b452 = [];
    
    if ( !isdefined( level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7 ) )
    {
        level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7 = [];
    }
    
    level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ] = [];
    maxnumtargets = bundle.var_e11b00afa0c06f64 ?? 0;
    
    foreach ( ent in allentities )
    {
        isdifferentteam = isdefined( ent.team ) && ent.team != owner.pers[ "team" ];
        
        if ( isdifferentteam && ent.isairkillstreak )
        {
            var_9373d2c56cb4b452[ var_9373d2c56cb4b452.size ] = ent;
        }
    }
    
    if ( passcount > 0 && level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount - 1 ].size > 0 )
    {
        foreach ( ent in level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount - 1 ] )
        {
            if ( isdefined( ent ) )
            {
                level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ][ level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ].size ] = ent;
            }
        }
    }
    
    foreach ( category in level.airpatrolsettings.vehicletargetscategory )
    {
        foreach ( ent in var_9373d2c56cb4b452 )
        {
            if ( level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ].size >= maxnumtargets )
            {
                return level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ];
            }
            
            if ( ent.streakname == category || isdefined( ent vehicle::get_ref() ) && ent vehicle::get_ref() == category )
            {
                isduplicate = 0;
                
                foreach ( existingent in level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ] )
                {
                    if ( existingent == ent )
                    {
                        isduplicate = 1;
                        break;
                    }
                }
                
                if ( isduplicate )
                {
                    continue;
                }
                
                level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ][ level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ].size ] = ent;
            }
        }
    }
    
    return level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7[ passcount ];
}

// Namespace air_patrol
// Params 2
// Checksum 0xc48b21a0, Offset: 0x1676
// Size: 0x14f
function function_50dba23f04ff7527( streakinfo, airpatrolid )
{
    airpatrol_plr_sfx = spawn( "script_origin", self.origin );
    splashref = "used_" + streakinfo.streakname;
    thread function_a5f16e2c4a9ede1d( streakinfo, airpatrolid );
    
    if ( isdefined( airpatrol_plr_sfx ) )
    {
        airpatrol_plr_sfx stoploopsound( "" );
        airpatrol_plr_sfx delete();
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    self notify( #"successful_fire" );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashref, self );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.streakname, self.origin );
    }
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
}

// Namespace air_patrol
// Params 2
// Checksum 0xcfcd1f2d, Offset: 0x17cd
// Size: 0x116
function function_a5f16e2c4a9ede1d( streakinfo, airpatrolid )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    var_a1401a0db0f64288 = bundle.var_7003241507532b5a ?? 0;
    thread airpatrol_watchkills( streakinfo, var_a1401a0db0f64288 * 2, airpatrolid );
    thread function_c0b60e4ce351a854( airpatrolid );
    thread airpatrol_watchgameend( streakinfo, airpatrolid );
    function_b5b41f4a964dfc38( streakinfo, airpatrolid );
    level thread function_97f8e7fdc24d98b9( self, airpatrolid );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>" + streakinfo.streakname, self );
        }
    #/
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace air_patrol
// Params 2
// Checksum 0x53cd4939, Offset: 0x18eb
// Size: 0xa2
function function_b5b41f4a964dfc38( streakinfo, airpatrolid )
{
    self notify( #"used" );
    self notify( #"airpatrol_used" );
    
    /#
        if ( getdvarint( @"hash_62df82b1a0e3f5e0", 0 ) == 1 )
        {
            function_a2db122326684bc3( streakinfo, airpatrolid );
            wait 15;
            return;
        }
        else if ( getdvarint( @"hash_ffa324b8df420e25", 0 ) == 1 )
        {
            thread function_f46f0f52d4b1f2dc( airpatrolid );
            dodogfight( self, streakinfo, airpatrolid );
            return;
        }
    #/
    
    if ( function_6e345934f84572cc( airpatrolid ) )
    {
        dodogfight( self, streakinfo, airpatrolid );
        return;
    }
    
    doairpatrol( self, streakinfo, airpatrolid );
}

/#

    // Namespace air_patrol
    // Params 1
    // Checksum 0x9cf157c8, Offset: 0x1995
    // Size: 0x6f, Type: dev
    function function_f46f0f52d4b1f2dc( airpatrolid )
    {
        wait 2;
        ownerairpatrol = level.var_cd0c9dd138b66e7[ airpatrolid ];
        ownerairpatrol.dogfightdata = { #var_f87d6b56846ec166:1, #var_1fa8b167bf2c1ed9:airpatrolid, #var_924aad6a2300361c:airpatrolid, #isattacker:1 };
        self notify( #"hash_d0fe45d9b6c95379" );
    }

#/

// Namespace air_patrol
// Params 3
// Checksum 0xa76ff79e, Offset: 0x1a0c
// Size: 0x42
function dodogfight( owner, streakinfo, airpatrolid )
{
    level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7 = [];
    level calldogfight( owner, streakinfo, airpatrolid );
}

// Namespace air_patrol
// Params 3
// Checksum 0x6dcd7a1e, Offset: 0x1a56
// Size: 0x462
function calldogfight( owner, streakinfo, airpatrolid )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 24000;
    planeflyspeed = 6500;
    planeflyheight = 5000;
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = max( heightent.origin[ 2 ], planeflyheight );
    }
    
    /#
        var_9e63aae57bdfe5ed = getdvarint( @"hash_a8c67ad3c59a6e03", 0 );
        planeflyheight += var_9e63aae57bdfe5ed;
    #/
    
    formationwidth = bundle.var_170df8c6930db1dd ?? 0;
    var_330fc4411beb95aa = bundle.var_330fc4411beb95aa ?? 0;
    ownerspawnpoint = owner.origin;
    spawngroup = owner spawnlogic::function_1f5152a92aada360( #"start" ) ? #"start" : #"primary";
    spawn_points = owner spawnlogic::function_f89ebff0bfb8555( spawngroup, owner.pers[ "team" ] );
    
    if ( spawn_points.size > 0 )
    {
        ownerspawnpoint = spawn_points[ 0 ].origin;
    }
    
    planeforward = vectornormalize( level.mapcenter - ownerspawnpoint );
    flightpaths = function_c1cf21f3c98d2864( owner, var_330fc4411beb95aa, formationwidth, planehalfdistance, heightent, planeflyheight, planeflyspeed, streakinfo.streakname, 1, planeforward );
    owner waittill( #"hash_d0fe45d9b6c95379", victim );
    owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"hash_c39d3be4a3b8aa28", 1 );
    
    if ( bundle.var_773e476c99e01f31 )
    {
        owner function_a2db122326684bc3( streakinfo, airpatrolid );
    }
    
    var_2458724e344634e4 = [];
    
    for ( i = 0; i < var_330fc4411beb95aa ; i++ )
    {
        planeflyheight += randomintrange( 0, 100 );
        planeid = i + 1;
        var_2458724e344634e4[ var_2458724e344634e4.size ] = level spawnplane( owner.origin, flightpaths[ i ][ "startPoint" ], flightpaths[ i ][ "endPoint" ], streakinfo, owner, airpatrolid, planeid );
    }
    
    /#
        if ( getdvarint( @"hash_ffa324b8df420e25", 0 ) == 1 )
        {
            level.var_cd0c9dd138b66e7[ level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.var_1fa8b167bf2c1ed9 ].owner = owner;
        }
    #/
    
    victimowner = level.var_cd0c9dd138b66e7[ level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.var_1fa8b167bf2c1ed9 ].owner;
    
    for ( i = 0; i < var_330fc4411beb95aa ; i++ )
    {
        planeflyheight += randomintrange( 0, 100 );
        planeid = i + 1 + var_330fc4411beb95aa;
        var_2458724e344634e4[ var_2458724e344634e4.size ] = level spawnplane( victimowner.origin, flightpaths[ i ][ "endPoint" ], flightpaths[ i ][ "startPoint" ], streakinfo, victimowner, airpatrolid, planeid );
    }
    
    scene_struct = spawnstruct();
    scene_struct.origin = ( flightpaths[ 0 ][ "endPoint" ] + flightpaths[ 0 ][ "startPoint" ] ) / 2;
    scene_struct.angles = vectortoangles( flightpaths[ 0 ][ "endPoint" ] - flightpaths[ 0 ][ "startPoint" ] );
    scene_struct scene::play( var_2458724e344634e4, "shot_010", level.airpatrolsettings.dogfightscene );
    objweapon = makeweapon( level.airpatrolsettings.missileweapon );
    owner thread points::doscoreevent( #"kill_ss_air_patrol", objweapon );
    killstreak::function_b700fb2ad0fa69e9( victim, owner, streakinfo );
    
    if ( isdefined( victim ) )
    {
        victim thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"destroyed", 1 );
    }
    
    owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"exit_interceptors", 1 );
    
    if ( isdefined( bundle.var_6203bc2d78f80e93 ) )
    {
        owner thread points::doscoreevent( bundle.var_6203bc2d78f80e93 );
    }
    
    level clearplanes( var_2458724e344634e4 );
}

// Namespace air_patrol
// Params 3
// Checksum 0xb23e32a2, Offset: 0x1ec0
// Size: 0x29b
function doairpatrol( owner, streakinfo, airpatrolid )
{
    bundle = streakinfo.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    numpasses = bundle.var_d4d749d00bf6a069 ?? 0;
    var_a1401a0db0f64288 = bundle.var_7003241507532b5a ?? 0;
    level.var_cd0c9dd138b66e7[ airpatrolid ].var_62a2c264926c84e7 = [];
    ownerspawnpoint = owner.origin;
    spawngroup = owner spawnlogic::function_1f5152a92aada360( #"start" ) ? #"start" : #"primary";
    spawn_points = owner spawnlogic::function_f89ebff0bfb8555( spawngroup, owner.pers[ "team" ] );
    
    if ( spawn_points.size > 0 )
    {
        ownerspawnpoint = spawn_points[ 0 ].origin;
    }
    
    planeforward = vectornormalize( level.mapcenter - ownerspawnpoint );
    
    /#
        if ( getdvarint( @"scr_debugairpatrol", 0 ) > 0 )
        {
            sphere( ownerspawnpoint, 500, ( 0, 0, 1 ), 0, 1000 );
            line( ownerspawnpoint, ownerspawnpoint + planeforward * 1000, ( 1, 0, 0 ), 1, 0, 1000 );
        }
    #/
    
    for ( passcount = 0; passcount < numpasses ; passcount++ )
    {
        if ( function_2c866b9f5c6c79f9( airpatrolid ) )
        {
            function_a770f986a818912a( airpatrolid );
        }
        else
        {
            missiledelay = 0;
            
            if ( level.airpatrolsettings.var_712442d57238a084 > 0 && ( passcount == 0 || level.airpatrolsettings.var_ed5279b45aea0259 ) )
            {
                missiledelay = level.airpatrolsettings.var_712442d57238a084;
            }
            
            if ( passcount < numpasses - 1 )
            {
                level thread callstrike( owner, streakinfo, airpatrolid, findtargets( airpatrolid, owner, passcount ), passcount, missiledelay, planeforward );
            }
            else
            {
                if ( isdefined( level.var_cd0c9dd138b66e7[ airpatrolid ] ) )
                {
                    level.var_cd0c9dd138b66e7[ airpatrolid ].lastpass = 1;
                }
                
                level callstrike( owner, streakinfo, airpatrolid, findtargets( airpatrolid, owner, passcount ), passcount, missiledelay, planeforward );
            }
        }
        
        if ( passcount < numpasses - 1 && function_2c866b9f5c6c79f9( airpatrolid ) )
        {
            function_a770f986a818912a( airpatrolid );
        }
        
        if ( var_a1401a0db0f64288 > 0 && passcount < numpasses - 1 )
        {
            wait var_a1401a0db0f64288;
        }
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0xe523965a, Offset: 0x2163
// Size: 0x115
function function_a770f986a818912a( airpatrolid )
{
    if ( isdefined( level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata ) && level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.isattacker == 0 && level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.var_f87d6b56846ec166 == 0 )
    {
        victimairpatrol = level.var_cd0c9dd138b66e7[ airpatrolid ];
        var_924aad6a2300361c = victimairpatrol.dogfightdata.var_924aad6a2300361c;
        attackerairpatrol = level.var_cd0c9dd138b66e7[ var_924aad6a2300361c ];
        
        if ( isdefined( attackerairpatrol.owner ) )
        {
            attackerairpatrol.owner notify( #"hash_d0fe45d9b6c95379", self );
        }
        
        victimairpatrol.dogfightdata.var_f87d6b56846ec166 = 1;
        attackerairpatrol.dogfightdata.var_f87d6b56846ec166 = 1;
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0xcbbd9578, Offset: 0x2280
// Size: 0x50, Type: bool
function function_2c866b9f5c6c79f9( airpatrolid )
{
    if ( isdefined( level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata ) && level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.isattacker == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace air_patrol
// Params 1
// Checksum 0x2350ab07, Offset: 0x22d9
// Size: 0x51, Type: bool
function function_6e345934f84572cc( airpatrolid )
{
    if ( isdefined( level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata ) && level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.isattacker == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace air_patrol
// Params 1
// Checksum 0x3c0e33ab, Offset: 0x2333
// Size: 0x64
function function_48143b06ebb0a78b( airpatrolid )
{
    if ( level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.isattacker )
    {
        return level.var_cd0c9dd138b66e7[ level.var_cd0c9dd138b66e7[ airpatrolid ].dogfightdata.var_1fa8b167bf2c1ed9 ].owner;
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0xb673faa1, Offset: 0x23a0
// Size: 0x44
function function_c0b60e4ce351a854( airpatrolid )
{
    self endon( "airpatrol_finished" + "_" + airpatrolid );
    level endon( #"game_ended" );
    utility::waittill_any( "disconnect", "joined_team" );
    function_97f8e7fdc24d98b9( self, airpatrolid );
}

// Namespace air_patrol
// Params 1
// Checksum 0x9034c024, Offset: 0x23ec
// Size: 0x70
function function_df6f9a5e363a43fc( flightpaths )
{
    if ( flightpaths.size > 0 )
    {
        bundle = level.airpatrolsettings.bundle;
        
        if ( !isdefined( bundle ) )
        {
            return;
        }
        
        wait bundle.var_50a97a980e6268e2 ?? 0;
        playsoundatpos( flightpaths[ 0 ][ "startPoint" ], bundle.var_1961bd078831fa8e ?? #"hash_9e30f200f6d3340a" );
    }
}

// Namespace air_patrol
// Params 7
// Checksum 0x15bfc840, Offset: 0x2464
// Size: 0x3a2
function callstrike( owner, streakinfo, airpatrolid, var_2f2db8d3b081a63e, passcount, missiledelay, planeforward )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( function_2c866b9f5c6c79f9( airpatrolid ) )
    {
        function_a770f986a818912a( airpatrolid );
        return;
    }
    
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 24000;
    planeflyspeed = 6500;
    planeflyheight = bundle.var_d9ad2bf80059d061 ?? 5000;
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = heightent.origin[ 2 ] + ( bundle.var_75fcd2c92520daab ?? 0 );
    }
    
    /#
        var_9e63aae57bdfe5ed = getdvarint( @"hash_a8c67ad3c59a6e03", 0 );
        planeflyheight += var_9e63aae57bdfe5ed;
    #/
    
    formationwidth = bundle.var_170df8c6930db1dd ?? 0;
    var_330fc4411beb95aa = bundle.var_330fc4411beb95aa ?? 0;
    var_a9c475604212b4ac = bundle.var_a9c475604212b4ac ?? 0;
    flightpaths = function_c1cf21f3c98d2864( owner, var_330fc4411beb95aa, formationwidth, planehalfdistance, heightent, planeflyheight, planeflyspeed, streakinfo.streakname, passcount, planeforward );
    wait missiledelay;
    
    if ( function_2c866b9f5c6c79f9( airpatrolid ) )
    {
        function_a770f986a818912a( airpatrolid );
        return;
    }
    
    thread function_df6f9a5e363a43fc( flightpaths );
    firemissiles( owner, streakinfo, var_2f2db8d3b081a63e, flightpaths );
    
    if ( passcount == 0 )
    {
        owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"arrive", 1 );
    }
    else
    {
        owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"second_pass", 1 );
        players = utility::callsharedfunc( #"team_utility", #"getenemyplayers", owner.team, 1 );
        
        if ( isdefined( players ) )
        {
            foreach ( player in players )
            {
                player thread namespace_9d8e359c3b1041e5::playkillstreakteamleaderdialogsharedfunc( streakinfo, undefined, #"second_pass_enemy" );
            }
        }
    }
    
    if ( var_a9c475604212b4ac > 0 )
    {
        wait var_a9c475604212b4ac;
    }
    
    if ( function_2c866b9f5c6c79f9( airpatrolid ) )
    {
        function_a770f986a818912a( airpatrolid );
        return;
    }
    
    var_2458724e344634e4 = [];
    
    for ( i = 0; i < var_330fc4411beb95aa ; i++ )
    {
        planeflyheight += randomintrange( 0, 100 );
        planeid = i + 1;
        var_2458724e344634e4[ var_2458724e344634e4.size ] = level spawnplane( owner.origin, flightpaths[ i ][ "startPoint" ], flightpaths[ i ][ "endPoint" ], streakinfo, owner, airpatrolid, planeid );
    }
    
    scene_struct = spawnstruct();
    scene_struct.origin = ( flightpaths[ 0 ][ "endPoint" ] + flightpaths[ 0 ][ "startPoint" ] ) / 2;
    scene_struct.angles = vectortoangles( flightpaths[ 0 ][ "endPoint" ] - flightpaths[ 0 ][ "startPoint" ] );
    scene_struct scene::play( var_2458724e344634e4, "shot_010", level.airpatrolsettings.flyoverscene );
    level clearplanes( var_2458724e344634e4 );
}

// Namespace air_patrol
// Params 4
// Checksum 0x2c2ad7ad, Offset: 0x280e
// Size: 0x2ee
function firemissiles( owner, streakinfo, var_2f2db8d3b081a63e, launchpositions )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    var_63e7327be6ec083e = bundle.var_9ee60417c309b93e ?? 0;
    maxnumtargets = bundle.var_e11b00afa0c06f64 ?? 0;
    var_ff1340861fdaeb4c = bundle.var_409fb3499fdc5b6a ?? 0;
    
    if ( maxnumtargets > var_2f2db8d3b081a63e.size )
    {
        maxnumtargets = var_2f2db8d3b081a63e.size;
    }
    
    for ( i = 0; i < maxnumtargets ; i++ )
    {
        for ( j = 0; j < var_63e7327be6ec083e ; j++ )
        {
            if ( !isdefined( var_2f2db8d3b081a63e[ i ] ) )
            {
                continue;
            }
            
            if ( level.airpatrolsettings.var_a9a2932d999655 > 0 )
            {
                wait level.airpatrolsettings.var_a9a2932d999655;
            }
            
            var_b02573c1200f4fc3 = vectortoangles( var_2f2db8d3b081a63e[ i ].origin - launchpositions[ 0 ][ "startPoint" ] );
            missilestart = var_2f2db8d3b081a63e[ i ].origin - vectornormalize( anglestoforward( var_b02573c1200f4fc3 ) ) * var_ff1340861fdaeb4c;
            missileend = var_2f2db8d3b081a63e[ i ].origin;
            bundle = level.streakglobals.streakbundles[ "air_patrol" ];
            
            if ( j == 0 )
            {
                missileweapon = level.airpatrolsettings.missileweapon;
            }
            else
            {
                missileweapon = level.airpatrolsettings.var_e502209c4a42cad8;
            }
            
            missile = weapon_utility::_magicbullet( makeweapon( missileweapon ), missilestart, var_2f2db8d3b081a63e[ i ].origin, owner, undefined );
            missile.weapon_name = missileweapon;
            missile.team = owner.team;
            missile.streakinfo = streakinfo;
            
            if ( j == 0 )
            {
                if ( isdefined( var_2f2db8d3b081a63e[ i ] ) )
                {
                    thread airpatrol_delaymissiletracking( missile, var_2f2db8d3b081a63e[ i ] );
                }
            }
            
            /#
                if ( getdvarint( @"scr_debugairpatrol", 0 ) > 0 )
                {
                    sphere( missilestart, 500, ( 0, 1, 0 ), 0, 1000 );
                    sphere( missileend, 500, ( 1, 0, 0 ), 0, 1000 );
                    sphere( launchpositions[ i ][ "<dev string:x38>" ], 500, ( 0, 0, 1 ), 0, 1000 );
                    line( missilestart, missileend, ( 1, 0, 0 ), 1, 0, 1000 );
                    line( launchpositions[ i ][ "<dev string:x38>" ], missileend, ( 1, 0, 0 ), 1, 0, 1000 );
                }
            #/
        }
    }
}

// Namespace air_patrol
// Params 2
// Checksum 0xa1cf2249, Offset: 0x2b04
// Size: 0x47
function airpatrol_delaymissiletracking( missile, missiletargetent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.1 );
    
    if ( isdefined( missile ) )
    {
        missile missile_settargetent( missiletargetent );
    }
}

// Namespace air_patrol
// Params 7
// Checksum 0xf8b6974b, Offset: 0x2b53
// Size: 0x4a3
function spawnplane( targetsite, var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, streakinfo, owner, airpatrolid, planeid )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    config = level.airpatrolsettings;
    planemodel = config.var_c178ca8b164fe9e4;
    
    if ( isdefined( config.var_5f677a962ed91117 ) && owner.team == "axis" )
    {
        planemodel = config.var_5f677a962ed91117;
    }
    
    var_aa3618dd78b3981d = vectortoangles( var_4c67c7deb1a274ee - var_bbcd7c6de5c8f8b );
    plane = spawn( "script_model", var_bbcd7c6de5c8f8b );
    plane setmodel( planemodel );
    plane.angles = var_aa3618dd78b3981d;
    plane.flightdir = anglestoforward( var_aa3618dd78b3981d );
    plane.flightheight = var_bbcd7c6de5c8f8b[ 2 ];
    plane.owner = owner;
    plane.team = owner.team;
    plane.lifeid = streakinfo.lifeid;
    plane.streakinfo = streakinfo;
    plane.streakinfo.var_bbd40c52f0758e34 = 1;
    plane.airpatrolid = airpatrolid;
    plane setotherent( owner );
    plane scriptmoveroutline();
    plane scriptmoverthermal();
    plane scriptmoverplane();
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        plane [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 0, 100 );
    }
    
    plane disableplayermarks( #"air_killstreak" );
    
    if ( utility::issharedfuncdefined( #"br", #"challengeevaluator" ) )
    {
        paramstruct = spawnstruct();
        paramstruct.plane = plane;
        paramstruct.targetsite = targetsite;
        owner [[ utility::getsharedfunc( #"br", #"challengeevaluator" ) ]]( "br_mastery_pointBlank_airpatrol", paramstruct );
    }
    
    planeicon = killstreak_utility::function_d734101502c23572( streakinfo.streakname ) ?? "hud_icon_minimap_killstreak_fuel_airstrike";
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        plane.minimapid = plane [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( planeicon, plane.team, 1, 1, 1 );
    }
    
    objidpoolmanager::function_e4d6a71507372662( plane.minimapid, 0 );
    bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    plane.var_16f8fcd927d3c930 = plane namespace_9d8e359c3b1041e5::killstreak_registerminimapinfosharedfunc( bundle, #"air_patrol" );
    
    if ( isdefined( plane.minimapid ) )
    {
        function_38c992e07c477802( plane.minimapid, 1 );
    }
    
    if ( isdefined( plane.var_16f8fcd927d3c930 ) )
    {
        function_38c992e07c477802( plane.var_16f8fcd927d3c930, 1 );
    }
    
    plane thread airpatrol_delayplayscriptable( 0.05 );
    plane thread function_d823b13719ddfa61();
    plane.animname = "Prop " + planeid;
    plane.scenenode = spawn( "script_model", var_bbcd7c6de5c8f8b );
    plane.scenenode.angles = plane.angles;
    plane.scenenode setmodel( "tag_origin" );
    plane.health = level.airpatrolsettings.health;
    plane.maxhealth = level.airpatrolsettings.maxhealth;
    plane.currenthealth = level.airpatrolsettings.maxhealth;
    plane thread airpatrol_watchdamage();
    
    /#
        if ( getdvarint( @"scr_debugairpatrol", 0 ) > 0 )
        {
            plane thread function_9619a686271b836b( var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, ( 1, 1, 1 ), 20 );
            plane thread function_bc7388025d453a4e( var_bbcd7c6de5c8f8b[ 2 ] - targetsite[ 2 ], targetsite );
        }
    #/
    
    return plane;
}

// Namespace air_patrol
// Params 1
// Checksum 0x5d36f65b, Offset: 0x2fff
// Size: 0x139
function clearplanes( planeentityarray )
{
    var_5f033665ab44a97c = utility::getsharedfunc( #"game", #"returnobjectiveid" );
    
    foreach ( plane in planeentityarray )
    {
        if ( isdefined( plane.minimapid ) )
        {
            if ( isdefined( var_5f033665ab44a97c ) )
            {
                [[ var_5f033665ab44a97c ]]( plane.minimapid );
            }
        }
        
        if ( isdefined( plane.var_16f8fcd927d3c930 ) )
        {
            if ( isdefined( var_5f033665ab44a97c ) )
            {
                [[ var_5f033665ab44a97c ]]( plane.var_16f8fcd927d3c930 );
            }
        }
        
        plane notify( #"delete" );
        
        if ( isdefined( plane.turrettarget ) )
        {
            plane.turrettarget delete();
        }
        
        if ( isdefined( plane.scenenode ) )
        {
            plane.scenenode delete();
        }
        
        if ( isdefined( plane ) )
        {
            plane delete();
        }
    }
}

// Namespace air_patrol
// Params 3
// Checksum 0x16d25430, Offset: 0x3140
// Size: 0x123
function airpatrol_watchkills( streakinfo, var_e41c9dd8df48b729, airpatrolid )
{
    self endon( #"disconnect" );
    self notify( #"airpatrol_watch_kills" );
    self endon( #"airpatrol_watch_kills" );
    waittillnotify = "airpatrol_finished" + "_" + airpatrolid;
    self.airpatrolkillcount = 0;
    self.var_6a73b2bd383cfa80 = 0;
    childthread airpatrol_watchkillscount( waittillnotify );
    childthread function_30356bd8d25e1d75( waittillnotify );
    utility::waittill_any_timeout_no_endon_death( var_e41c9dd8df48b729, waittillnotify );
    
    /#
        if ( getdvarint( @"hash_ffa324b8df420e25", 0 ) == 1 )
        {
            self.var_6a73b2bd383cfa80 = undefined;
            return;
        }
    #/
    
    if ( self.var_6a73b2bd383cfa80 == 0 )
    {
        dialogueref = "exit_killed_none";
    }
    else if ( self.var_6a73b2bd383cfa80 > 0 && self.var_6a73b2bd383cfa80 <= 3 )
    {
        dialogueref = "exit_killed_" + self.var_6a73b2bd383cfa80;
    }
    else
    {
        dialogueref = "exit_killed_multiple";
    }
    
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, getxhash( dialogueref ), 1 );
    self.var_6a73b2bd383cfa80 = undefined;
}

// Namespace air_patrol
// Params 1
// Checksum 0x48e53d35, Offset: 0x326b
// Size: 0x6b
function airpatrol_watchkillscount( endonnotify )
{
    self endon( endonnotify );
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"update_rapid_kill_buffered", recentkillcount, var_95795539e2a8343 );
        function_56e018fa9e4cc42e( bundle, var_95795539e2a8343 );
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0xd1aa4c43, Offset: 0x32de
// Size: 0x6b
function function_30356bd8d25e1d75( endonnotify )
{
    self endon( endonnotify );
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"update_rapid_agent_kill_buffered", recentkillcount, var_bda53394c108f2e );
        function_56e018fa9e4cc42e( bundle, var_bda53394c108f2e );
    }
}

// Namespace air_patrol
// Params 2
// Checksum 0x4cbcd00d, Offset: 0x3351
// Size: 0x8c
function function_56e018fa9e4cc42e( bundle, var_95795539e2a8343 )
{
    if ( !isstring( var_95795539e2a8343 ) )
    {
        return;
    }
    
    var_b5a4635278cb7686 = var_95795539e2a8343 == ( bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp" );
    var_e885eb6644a41cd4 = var_95795539e2a8343 == level.airpatrolsettings.missileweapon || var_b5a4635278cb7686;
    
    if ( var_b5a4635278cb7686 )
    {
        thread points::doscoreevent( #"air_patrol_incidental_damage" );
    }
    
    if ( var_e885eb6644a41cd4 )
    {
        self.airpatrolkillcount++;
    }
}

/#

    // Namespace air_patrol
    // Params 1
    // Checksum 0x220a84ea, Offset: 0x33e5
    // Size: 0x4c, Type: dev
    function testsoundplacement( flyoutfx )
    {
        flyoutfx endon( #"death" );
        
        while ( true )
        {
            sphere( flyoutfx.origin, 100, ( 0, 1, 0 ), 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace air_patrol
// Params 10
// Checksum 0x8d33b8c2, Offset: 0x3439
// Size: 0x20a
function function_c1cf21f3c98d2864( owner, fightercount, formationwidth, planehalfdistance, heightent, planeflyheight, planeflyspeed, streakname, passcount, planeforward )
{
    bundle = level.airpatrolsettings.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    flightdirection = 1;
    
    if ( passcount % 2 == 1 )
    {
        flightdirection *= -1;
    }
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = heightent.origin[ 2 ];
    }
    
    planefacing = planeforward * flightdirection;
    startpointroot = level.mapcenter - planefacing * planehalfdistance;
    startpointroot *= ( 1, 1, 0 );
    startpointroot += ( 0, 0, planeflyheight );
    endpointroot = level.mapcenter + planefacing * planehalfdistance;
    endpointroot *= ( 1, 1, 0 );
    endpointroot += ( 0, 0, planeflyheight );
    horizontal_offset = formationwidth / fightercount;
    positionmultiplier = 0;
    
    for ( i = 0; i < ( bundle.var_330fc4411beb95aa ?? 0 ) ; i++ )
    {
        if ( i % 2 == 0 )
        {
            positionmultiplier++;
            directionscalar = -1;
        }
        else
        {
            directionscalar = 1;
        }
        
        horizontal_scale = directionscalar * horizontal_offset * positionmultiplier;
        forward_scale = -1 * horizontal_offset * positionmultiplier;
        offset = anglestoright( vectortoangles( planefacing ) ) * horizontal_scale + planefacing * forward_scale;
        startpoint = startpointroot + offset;
        endpoint = endpointroot + offset;
        flightpath[ i ][ "startPoint" ] = startpoint;
        flightpath[ i ][ "endPoint" ] = endpoint;
    }
    
    return flightpath;
}

/#

    // Namespace air_patrol
    // Params 2
    // Checksum 0x5b174390, Offset: 0x364c
    // Size: 0x101, Type: dev
    function function_bc7388025d453a4e( planeflyheight, targetsite )
    {
        self endon( #"death" );
        level endon( #"debug_airpatrol" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debugairpatrol" ) == 0 )
            {
                return;
            }
            
            anglesforward = anglestoforward( level.players[ 0 ].angles );
            scalar = ( anglesforward[ 0 ] * 300, anglesforward[ 1 ] * 300, anglesforward[ 2 ] );
            print3d( level.players[ 0 ].origin + scalar, "<dev string:x43>" + planeflyheight, ( 1, 0, 0 ) );
            print3d( level.players[ 0 ].origin + scalar - ( 0, 0, 20 ), "<dev string:x50>" + distance2d( targetsite, self.origin ) );
            waitframe();
        }
    }

    // Namespace air_patrol
    // Params 4
    // Checksum 0x8ba494b3, Offset: 0x3755
    // Size: 0x62, Type: dev
    function function_9619a686271b836b( start, end, color, duration )
    {
        frames = duration * 20;
        
        for ( i = 0; i < frames ; i++ )
        {
            line( start, end, color );
            wait 0.05;
        }
    }

#/

// Namespace air_patrol
// Params 1
// Checksum 0x734471b7, Offset: 0x37bf
// Size: 0x38
function airpatrol_delayplayscriptable( delaytime )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait delaytime;
    self setscriptablepartstate( "bodyfx", "on", 0 );
}

// Namespace air_patrol
// Params 0
// Checksum 0xf80da480, Offset: 0x37ff
// Size: 0x49
function function_d823b13719ddfa61()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"air_patrol_kill_fx" );
    self setscriptablepartstate( "bodyfx", "off", 0 );
    self setscriptablepartstate( "fire", "off", 0 );
}

// Namespace air_patrol
// Params 2
// Checksum 0xba974f4f, Offset: 0x3850
// Size: 0x7d
function airpatrol_watchgameend( streakinfo, airpatrolid )
{
    self endon( "airpatrol_finished" + "_" + airpatrolid, #"disconnect" );
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

// Namespace air_patrol
// Params 1
// Checksum 0xc50d26e2, Offset: 0x38d5
// Size: 0x1cb
function function_31f147bb7196d9ec( owner )
{
    level.airpatrolcount++;
    newstrike = { #id:owner getxuid() + "_" + level.airpatrolcount, #owner:owner, #origin:owner.origin };
    
    if ( level.var_cd0c9dd138b66e7.size > 0 )
    {
        foreach ( airpatrol in level.var_cd0c9dd138b66e7 )
        {
            if ( airpatrol.owner.team != owner.team && !airpatrol.lastpass )
            {
                airpatrol.dogfightdata = { #var_f87d6b56846ec166:0, #var_1fa8b167bf2c1ed9:airpatrol.id, #var_924aad6a2300361c:newstrike.id, #isattacker:0 };
                newstrike.dogfightdata = { #var_f87d6b56846ec166:0, #var_1fa8b167bf2c1ed9:airpatrol.id, #var_924aad6a2300361c:newstrike.id, #isattacker:1 };
                break;
            }
        }
    }
    
    level.var_cd0c9dd138b66e7[ newstrike.id ] = newstrike;
    return newstrike.id;
}

// Namespace air_patrol
// Params 2
// Checksum 0x3bf9541e, Offset: 0x3aa9
// Size: 0x39
function function_97f8e7fdc24d98b9( owner, var_8513e683c139ca76 )
{
    level.var_cd0c9dd138b66e7[ var_8513e683c139ca76 ] = undefined;
    
    if ( isdefined( owner ) )
    {
        owner notify( "airpatrol_finished" + "_" + var_8513e683c139ca76 );
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0x9559fc73, Offset: 0x3aea
// Size: 0x106
function airpatrol_canbeused( owner )
{
    useresult = "success";
    
    /#
        if ( getdvarint( @"hash_ffa324b8df420e25", 0 ) == 1 )
        {
            return "<dev string:x5b>";
        }
    #/
    
    if ( level.var_cd0c9dd138b66e7.size > 0 )
    {
        foreach ( airpatrol in level.var_cd0c9dd138b66e7 )
        {
            if ( airpatrol.owner.team != owner.team && !airpatrol.lastpass )
            {
                return "dogfight";
            }
        }
    }
    
    if ( !function_1fc8096c7db31762( owner ) )
    {
        useresult = "KILLSTREAKS/AIR_PATROL_CANNOT_BE_USED";
    }
    
    return useresult;
}

// Namespace air_patrol
// Params 0
// Checksum 0xef2f95e8, Offset: 0x3bf9
// Size: 0x52d
function airpatrol_watchdamage()
{
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    self setcandamage( 1 );
    self.damagetaken = 0;
    self setscriptablepartstate( "bodyfx", "on", 0 );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        debugdamage = undefined;
        
        /#
            debugdamage = istrue( self.debugdamage );
        #/
        
        if ( utility::issharedfuncdefined( #"weapons", #"hash_cbe6f240c4185aed" ) )
        {
            objweapon = [[ utility::getsharedfunc( #"weapons", #"hash_cbe6f240c4185aed" ) ]]( objweapon, inflictor );
        }
        
        if ( !isplayer( attacker ) )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            continue;
        }
        
        if ( meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" )
        {
            continue;
        }
        
        self.wasdamaged = 1;
        modifieddamage = damage;
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        divisorlrg = 1;
        divisormed = 1;
        divisorlow = 1;
        divisormelee = 0;
        divisortick = 3;
        
        if ( isdefined( objweapon ) )
        {
            if ( debugdamage )
            {
                modifieddamage = damage;
            }
            else if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
            {
                bundle = level.streakglobals.streakbundles[ "air_patrol" ];
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:inflictor } );
            }
            else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
            {
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick );
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
            {
                [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, meansofdeath, modifieddamage );
            }
            
            if ( utility::issharedfuncdefined( #"damage", #"logattackerkillstreak" ) )
            {
                self [[ utility::getsharedfunc( #"damage", #"logattackerkillstreak" ) ]]( self, damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
            }
        }
        
        self.damagetaken += modifieddamage;
        
        /#
            if ( isdefined( self ) && getdvarint( @"g_debugdamage" ) )
            {
                println( "<dev string:x64>" + self getentitynumber() + "<dev string:x6f>" + self.health - self.damagetaken + "<dev string:x78>" + attacker.clientid + "<dev string:x83>" + isplayer( attacker ) + "<dev string:x99>" + modifieddamage + "<dev string:xa2>" + distance( attacker.origin, self.origin ) );
            }
        #/
        
        self.currenthealth -= modifieddamage;
        killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
        
        if ( self.damagetaken >= self.maxhealth )
        {
            if ( isplayer( attacker ) && ( !isdefined( self.owner ) || attacker != self.owner ) )
            {
                vodestroyed = "air_patrol" + "_destroyed";
                destroyedsplash = "callout_destroyed_" + "air_patrol";
                
                if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
                {
                    self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( "air_patrol", attacker, objweapon, meansofdeath, damage, "destroyed_" + "air_patrol", vodestroyed, destroyedsplash, 1 );
                }
            }
            
            self setscriptablepartstate( "explode", "on", 0 );
            self notify( #"explode" );
            return;
        }
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0x8804632f, Offset: 0x412e
// Size: 0xb7
function function_9383881dca8fb28d( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    targetsexist = 0;
    slotnumber = killstreaks::getequippedkillstreakslotbyname( streakinfo.streakname );
    
    if ( isdefined( slotnumber ) )
    {
        thread killstreak_utility::function_8b88dd572355be1f( streakinfo, slotnumber, 3 );
        
        while ( streakinfo.available )
        {
            var_363bfb3a68d52125 = function_1fc8096c7db31762( self );
            
            if ( targetsexist != var_363bfb3a68d52125 )
            {
                if ( var_363bfb3a68d52125 )
                {
                    thread killstreak_utility::function_8b88dd572355be1f( streakinfo, slotnumber, 0 );
                }
                else
                {
                    thread killstreak_utility::function_8b88dd572355be1f( streakinfo, slotnumber, 3 );
                }
                
                targetsexist = var_363bfb3a68d52125;
            }
            
            waitframe();
        }
    }
}

// Namespace air_patrol
// Params 0
// Checksum 0xf84e7f49, Offset: 0x41ed
// Size: 0x1f
function airpatrol_destroy()
{
    self setscriptablepartstate( "explode", "on", 0 );
    self notify( #"explode" );
}

// Namespace air_patrol
// Params 2
// Checksum 0xa76772e8, Offset: 0x4214
// Size: 0x31
function function_a2db122326684bc3( streakinfo, airpatrolid )
{
    function_c37ba4d8b21a2cd7( airpatrolid );
    thread function_24a00f0389faeb2c( streakinfo, airpatrolid, level.mapcenter );
}

// Namespace air_patrol
// Params 0
// Checksum 0xd4372494, Offset: 0x424d
// Size: 0x72
function function_5d04a29523cf7ed6()
{
    self endon( #"death" );
    self setscriptablepartstate( "target", "on", 0 );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 10 );
    
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace air_patrol
// Params 3
// Checksum 0x550c0b75, Offset: 0x42c7
// Size: 0x2e1
function function_24a00f0389faeb2c( streakinfo, airpatrolid, targetposition )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_60733902ed6a2449" );
    streakinfo.shots_fired++;
    markerorigin = targetposition;
    bundle = level.airpatrolsettings.bundle;
    
    if ( bundle.var_ae76d9c0e240c0b4 )
    {
        marker = spawn( "script_model", markerorigin );
        marker setmodel( bundle.var_b2f2e9d6e52c5d4c ?? "ks_toma_strike_marker_t10_mp" );
        marker.objidnum = 0;
        
        if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
        {
            marker.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        }
        
        objidpoolmanager::function_e4d6a71507372662( marker.objidnum, 0 );
        marker.icon = "icon_waypoint_clusterstrike";
        marker setotherent( self );
        marker function_d04fc0c1ad910718( marker.objidnum, marker.icon, self, 50 );
        marker thread function_5d04a29523cf7ed6();
    }
    
    radius = bundle.var_3885548b6cbee76b ?? 500;
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( self, self.team, radius + 300, streakinfo.streakname, markerorigin );
    delaytime = bundle.var_19f274cf46a240ad ?? 0;
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( delaytime );
    
    if ( !isdefined( self.attackrange ) )
    {
        self.attackrange = 4000;
    }
    
    if ( !isdefined( self.var_57a843751bdea6d8 ) )
    {
        self.var_57a843751bdea6d8 = 0;
    }
    
    var_22cd0beb893f30ed = function_2afcfb0d21f86e61( airpatrolid );
    
    for ( i = 0; i < var_22cd0beb893f30ed ; i++ )
    {
        var_c11b16cce6cf81ee = function_5d560ee4e4ca6f84( airpatrolid, i );
        
        if ( isdefined( streakinfo.var_6f50b012a8dd6332 ) )
        {
            var_c11b16cce6cf81ee = streakinfo.var_6f50b012a8dd6332;
        }
        
        for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
        {
            var_147ece74855f6277 = anglestoforward( self getplayerangles() );
            ownerforward = anglestoforward( self.angles );
            ownerright = anglestoright( self.angles );
            var_4d99e8552caf305a = findunobstructedfiringinfo( markerorigin, radius, var_147ece74855f6277, ownerforward, ownerright );
            thread function_fc3c36dbd144f98f( var_4d99e8552caf305a, streakinfo, airpatrolid );
            wait function_280a5b85af6aabb8( airpatrolid, i, j );
        }
        
        timetowait = function_d262c86fa28684f5( airpatrolid, i );
        wait timetowait;
    }
}

// Namespace air_patrol
// Params 3
// Checksum 0xb96c22e2, Offset: 0x45b0
// Size: 0x3a4
function function_fc3c36dbd144f98f( var_4d99e8552caf305a, streakinfo, airpatrolid )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    traveltime = bundle.var_19d53f01855190be ?? 4;
    weaponname = bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp";
    missile = magicgrenademanual( weaponname, var_4d99e8552caf305a.sourcepos, var_4d99e8552caf305a.initvelocity, traveltime + 2 );
    missile.team = self.team;
    minimapid = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        minimapid = missile [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_fuel_airstrike", self.team, 1, 1, 1 );
    }
    
    if ( isdefined( minimapid ) )
    {
        missile.minimapid = minimapid;
        function_38c992e07c477802( missile.minimapid, 1 );
    }
    
    missile setentityowner( self );
    missile setotherent( self );
    missile.owner = self;
    missile.streakinfo = streakinfo;
    killcament = spawn( "script_model", var_4d99e8552caf305a.sourcepos );
    killcament linkto( missile, "tag_origin", ( 10, 0, 10 ), ( 0, 0, 0 ) );
    missile.killcament = killcament;
    missile.explodeent = spawn( "script_model", missile.origin );
    missile.explodeent setmodel( bundle.var_6deb4fd60fbaa0eb ?? "ks_airpatrol_crash_cer_mp" );
    missile.explodeent linkto( missile );
    missile.explodeent dontinterpolate();
    missile.explodeent setentityowner( self );
    missile.explodeent.killcament = killcament;
    
    if ( !self.var_5d350bc7166e50ce && utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_39046aa32b2153cf", var_4d99e8552caf305a.goalpos, self.team );
    }
    
    missile setscriptablepartstate( "bodyfx", "off", 0 );
    missile setscriptablepartstate( "onFire", "on", 0 );
    missile thread function_4f4db39e3a8c3910( airpatrolid );
    missile thread function_125af9c4098150ef( airpatrolid );
    
    if ( bundle.var_bbbf07ff943fdfa7 )
    {
        missile thread function_e21df50d04a5010();
    }
    
    var_c70fe14f2661a47e = traveltime - 0.5;
    killcamendpos = var_4d99e8552caf305a.preexplpos;
    missile thread function_b4617af02e235eba( var_4d99e8552caf305a.preexplpos, var_4d99e8552caf305a.entityhit, var_4d99e8552caf305a.entityhittype, self.var_ca5dd26ab39d925b, airpatrolid );
    missile thread function_13a79cb1be3ecd87( vectortoangles( var_4d99e8552caf305a.initvelocity ), gettime(), var_4d99e8552caf305a.initvelocity );
    missile.killcament thread function_1b2acd1ba9cba5d8( var_c70fe14f2661a47e, killcamendpos );
}

// Namespace air_patrol
// Params 3
// Checksum 0x746c63d, Offset: 0x495c
// Size: 0x105
function function_13a79cb1be3ecd87( launchangles, launchtimems, launchvelocity )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    stuckto = function_a3b328da16435196();
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    gravityaccel = -1 * getdvarfloat( @"bg_gravity", 800 );
    traveltime = ( gettime() - launchtimems ) * 0.001;
    impactvelocity = launchvelocity + ( 0, 0, gravityaccel * traveltime );
    function_e55713293b1490f( stuckto, launchangles, impactvelocity );
    self notify( #"hash_7419a6ae62fb730b" );
}

// Namespace air_patrol
// Params 5
// Checksum 0xbec70ec7, Offset: 0x4a69
// Size: 0x1f1
function findunobstructedfiringinfo( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_147ece74855f6277, ownerforward, ownerright )
{
    bundle = level.airpatrolsettings.bundle;
    gravity = getdvarfloat( @"bg_gravity", 800 );
    
    if ( getdvarint( @"bg_bristotallynormal", 0 ) )
    {
        gravity = getdvarfloat( @"hash_2f4cf62df1af9a6", 125 );
    }
    
    var_4d99e8552caf305a = spawnstruct();
    var_ae8856ebc968addf = function_5b138dff369abbb3( var_ff2c40cf5f0d3cc8, var_147ece74855f6277, ownerforward, ownerright );
    var_2bfd178bc84d73d7 = vectornormalize( var_ff2c40cf5f0d3cc8 - ( var_ae8856ebc968addf[ 0 ], var_ae8856ebc968addf[ 1 ], 0 ) );
    var_50e6a9e25a9fba6d = function_a17d8a9d617d374a( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7 );
    var_7dae7f8ea43ba5c8 = ( 0, 0, -1 * gravity );
    traveltime = bundle.var_19d53f01855190be ?? 4;
    var_9dce17a116cdf149 = ( var_50e6a9e25a9fba6d.point - 0.5 * var_7dae7f8ea43ba5c8 * squared( traveltime ) - var_ae8856ebc968addf ) / traveltime;
    
    if ( !isdefined( self.var_ca5dd26ab39d925b ) )
    {
        self.var_ca5dd26ab39d925b = traveltime - 0.075;
    }
    
    var_2dd8674712c19866 = var_ae8856ebc968addf + var_9dce17a116cdf149 * self.var_ca5dd26ab39d925b + 0.5 * var_7dae7f8ea43ba5c8 * squared( self.var_ca5dd26ab39d925b );
    var_4d99e8552caf305a.sourcepos = var_ae8856ebc968addf;
    var_4d99e8552caf305a.entityhit = var_50e6a9e25a9fba6d.entityhit;
    var_4d99e8552caf305a.entityhittype = var_50e6a9e25a9fba6d.entityhittype;
    var_4d99e8552caf305a.goalpos = var_50e6a9e25a9fba6d.point;
    var_4d99e8552caf305a.preexplpos = var_2dd8674712c19866;
    var_4d99e8552caf305a.initvelocity = var_9dce17a116cdf149;
    return var_4d99e8552caf305a;
}

// Namespace air_patrol
// Params 3
// Checksum 0x9c43dbc6, Offset: 0x4c63
// Size: 0x38
function function_280a5b85af6aabb8( airpatrolid, waveindex, strikeindex )
{
    return level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay[ waveindex ][ strikeindex ];
}

// Namespace air_patrol
// Params 2
// Checksum 0x54504d8d, Offset: 0x4ca4
// Size: 0x2d
function function_d262c86fa28684f5( airpatrolid, waveindex )
{
    return level.var_ab770f999b8c77c0[ airpatrolid ].wavedelay[ waveindex ];
}

// Namespace air_patrol
// Params 1
// Checksum 0xfb602865, Offset: 0x4cda
// Size: 0x23
function function_2afcfb0d21f86e61( airpatrolid )
{
    return level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay.size;
}

// Namespace air_patrol
// Params 2
// Checksum 0xacb9ae21, Offset: 0x4d06
// Size: 0x2e
function function_5d560ee4e4ca6f84( airpatrolid, waveid )
{
    return level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay[ waveid ].size;
}

// Namespace air_patrol
// Params 1
// Checksum 0xae31cf2f, Offset: 0x4d3d
// Size: 0x262
function function_c37ba4d8b21a2cd7( airpatrolid )
{
    bundle = level.airpatrolsettings.bundle;
    level.var_ab770f999b8c77c0[ airpatrolid ] = spawnstruct();
    level.var_ab770f999b8c77c0[ airpatrolid ].starttimems = gettime();
    level.var_ab770f999b8c77c0[ airpatrolid ].totaltimesec = bundle.var_19f274cf46a240ad ?? 0;
    level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay = [];
    var_22cd0beb893f30ed = bundle.var_64a4f4bca967cd14 ?? 1;
    var_c11b16cce6cf81ee = bundle.var_feef2b4ecf5c09e4 ?? 1;
    var_c3dc6dc0fbcf4017 = bundle.var_63116254051d6986 ?? 7;
    var_afeaad0d882fca6d = bundle.var_5540a7677b45fa7c ?? 7;
    var_a4db596a495f0704 = bundle.var_71f091636071f5f ?? 0.55;
    var_c9bade25e3dc4c62 = bundle.var_c848a2524137040d ?? 1.35;
    level.var_ab770f999b8c77c0[ airpatrolid ].wavedelay = [];
    
    for ( i = 0; i < var_22cd0beb893f30ed ; i++ )
    {
        level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay[ i ] = [];
        
        for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
        {
            timetowait = var_a4db596a495f0704 == var_c9bade25e3dc4c62 ? var_a4db596a495f0704 : randomfloatrange( var_a4db596a495f0704, var_c9bade25e3dc4c62 );
            level.var_ab770f999b8c77c0[ airpatrolid ].totaltimesec += timetowait;
            level.var_ab770f999b8c77c0[ airpatrolid ].strikedelay[ i ][ j ] = timetowait;
        }
        
        timetowait = var_c3dc6dc0fbcf4017 == var_afeaad0d882fca6d ? var_c3dc6dc0fbcf4017 : randomfloatrange( var_c3dc6dc0fbcf4017, var_afeaad0d882fca6d );
        level.var_ab770f999b8c77c0[ airpatrolid ].totaltimesec += timetowait;
        level.var_ab770f999b8c77c0[ airpatrolid ].wavedelay[ i ] = timetowait;
    }
}

// Namespace air_patrol
// Params 4
// Checksum 0xdbfe2de8, Offset: 0x4fa7
// Size: 0x2db
function function_5b138dff369abbb3( markerorigin, var_147ece74855f6277, ownerforward, ownerright )
{
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( markerorigin - var_147ece74855f6277 * 30, markerorigin + var_147ece74855f6277 * 1000, undefined, contents );
    coord = trace[ "position" ] + trace[ "normal" ] * 20;
    targetpos = coord;
    bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    launchheight = bundle.var_27656f12e43997c9 ?? 5000;
    var_f3401a2195395d24 = bundle.var_3da813fbe2b5a12f ?? 0;
    var_c09eeec12b11a47 = bundle.var_13507f8e110885b0 ?? 0;
    var_5b3eac5d3b856cef = 0;
    
    if ( var_c09eeec12b11a47 > 0 )
    {
        var_5b3eac5d3b856cef = randomfloat( var_c09eeec12b11a47 * 2 ) - var_c09eeec12b11a47;
    }
    
    trajectoryangle = ( bundle.var_6f676e4315048a3f ?? 45 ) + var_5b3eac5d3b856cef;
    targetforward = launchheight * tan( trajectoryangle );
    var_4159891f0b5bc03 = [ targetpos + ownerforward * 100, targetpos - ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + ( ownerforward + ownerright ) * 100, targetpos + ( ownerforward - ownerright ) * 100, targetpos + ( ownerright - ownerforward ) * 100, targetpos + ( -1 * ownerforward - ownerright ) * 100 ];
    var_54454e7b516826d3 = vectornormalize( var_4159891f0b5bc03[ 0 ] - targetpos );
    bestlaunchpos = targetpos + ( 0, 0, launchheight ) - var_54454e7b516826d3 * targetforward;
    
    foreach ( dirpos in var_4159891f0b5bc03 )
    {
        direction = vectornormalize( dirpos - targetpos );
        starttracepos = bestlaunchpos;
        
        if ( var_f3401a2195395d24 > 0 )
        {
            starttracepos = targetpos + ( randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ), randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ), launchheight + randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ) ) - direction * targetforward;
        }
        else
        {
            starttracepos = targetpos + ( 0, 0, launchheight ) - direction * targetforward;
        }
        
        endtracepos = targetpos;
        traceresult = trace::ray_trace_passed( starttracepos, endtracepos, undefined, contents );
        
        if ( !traceresult )
        {
            continue;
        }
        
        bestlaunchpos = starttracepos;
        break;
    }
    
    return bestlaunchpos;
}

// Namespace air_patrol
// Params 3
// Checksum 0xa0af67dd, Offset: 0x528b
// Size: 0xde
function function_e55713293b1490f( stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( self.angles );
    right = anglestoright( launchangles );
    
    if ( self.waterimpact )
    {
        up = ( 0, 0, 1 );
    }
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = function_24be2cb71a04b496( up, right );
    }
    else
    {
        angles = function_73206da319b77791( up, forward );
    }
    
    self.angles = angles;
    thread function_5203012df0290590( self.origin, angles, stuckto, self.owner, gettime(), self.streakinfo );
}

// Namespace air_patrol
// Params 0
// Checksum 0x3a0bbc6f, Offset: 0x5371
// Size: 0x8c
function function_a3b328da16435196()
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    impactinfo = killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact" );
    stuckto = undefined;
    
    if ( isdefined( impactinfo ) )
    {
        if ( impactinfo.msg == "missile_stuck" )
        {
            stuckto = impactinfo.param1;
        }
        else if ( impactinfo.msg == "missile_water_impact" )
        {
            self.waterimpact = 1;
        }
    }
    
    return stuckto;
}

// Namespace air_patrol
// Params 2
// Checksum 0xf4ab7e19, Offset: 0x5406
// Size: 0x4e
function function_1b2acd1ba9cba5d8( var_6edb5cd6057d3905, endpos )
{
    if ( isdefined( self ) )
    {
        self endon( #"death" );
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( var_6edb5cd6057d3905 );
        self unlink();
        self moveto( endpos, 5 );
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 7 );
        self delete();
    }
}

// Namespace air_patrol
// Params 5
// Checksum 0xea79520, Offset: 0x545c
// Size: 0xf4
function function_b4617af02e235eba( var_310c207acff4725, entityhit, entityhittype, explosiondelay, airpatrolid )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    self endon( #"hash_7419a6ae62fb730b" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( explosiondelay );
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
    
    if ( !isdefined( var_310c207acff4725 ) )
    {
        var_310c207acff4725 = self.origin;
    }
    
    thread function_8b5b4665497393a2( var_310c207acff4725, airpatrolid );
    
    if ( isdefined( entityhit ) && entityhittype == "flying" )
    {
        bundle = level.streakglobals.streakbundles[ "air_patrol" ];
        weaponname = bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp";
        entityhit dodamage( 500, var_310c207acff4725, self.owner, self, "MOD_EXPLOSIVE", makeweapon( weaponname ) );
    }
}

// Namespace air_patrol
// Params 0
// Checksum 0xed2f16a8, Offset: 0x5558
// Size: 0xb4
function function_e21df50d04a5010()
{
    self endon( #"death" );
    self endon( #"missile_empd" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    self endon( #"hash_7419a6ae62fb730b" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    prevloc = self getorigin();
    
    while ( true )
    {
        if ( !isdefined( prevloc ) )
        {
            prevloc = self getorigin();
            waitframe();
            continue;
        }
        
        currloc = self getorigin();
        
        if ( !isdefined( currloc ) )
        {
            waitframe();
            continue;
        }
        
        self.angles = anglelerpquat( self.angles, vectortoangles( currloc - prevloc ), 1 );
        prevloc = currloc;
        waitframe();
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0x236eb549, Offset: 0x5614
// Size: 0x94
function function_125af9c4098150ef( airpatrolid )
{
    self notify( #"missile_empd" );
    self endon( #"death" );
    owner = self.owner;
    
    while ( true )
    {
        if ( owner.ksempd )
        {
            if ( isdefined( self.killcament ) )
            {
                self.killcament delete();
            }
            
            namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
            thread function_8b5b4665497393a2( self.origin, airpatrolid );
            self notify( #"hash_f0d4a2ca833ee95c" );
            break;
        }
        
        waitframe();
    }
}

// Namespace air_patrol
// Params 1
// Checksum 0x9e6f4418, Offset: 0x56b0
// Size: 0x94
function function_4f4db39e3a8c3910( airpatrolid )
{
    self endon( #"missile_empd" );
    self endon( #"death" );
    self endon( #"hash_7419a6ae62fb730b" );
    owner = self.owner;
    owner waittill( #"disconnect" );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
    thread function_8b5b4665497393a2( self.origin, airpatrolid );
    self notify( #"hash_f0d4a2ca833ee95c" );
}

// Namespace air_patrol
// Params 2
// Checksum 0xce1dc9d, Offset: 0x574c
// Size: 0xfb
function function_8b5b4665497393a2( var_310c207acff4725, airpatrolid )
{
    self endon( #"death" );
    self.exploding = 1;
    self.explodeent unlink();
    self.explodeent.origin = var_310c207acff4725;
    function_8e7fdc6647fb268d( airpatrolid );
    thread function_9ecae99f1b696869();
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( isdefined( self.explodeent ) )
    {
        self.explodeent delete();
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    self delete();
}

// Namespace air_patrol
// Params 1
// Checksum 0x2a9753a0, Offset: 0x584f
// Size: 0x1b7
function function_8e7fdc6647fb268d( airpatrolid )
{
    bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    
    if ( bundle.var_80dcbe63100cf1f8 )
    {
        self.health = 9999;
        attacker = self.owner ?? self;
        defender = function_48143b06ebb0a78b( airpatrolid );
        
        if ( isdefined( defender ) )
        {
            defender radiusdamage( self.origin, bundle.var_3af7e9bf163df410 ?? 1000, bundle.var_e64c2a1ff0c6f62f.max ?? 200, bundle.var_e64c2a1ff0c6f62f.min ?? 200, defender, "MOD_EXPLOSIVE", bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp" );
        }
        
        attacker radiusdamage( self.origin, bundle.var_e79f53f700d2025a ?? 1000, bundle.var_e64c2a1ff0c6f62f.max ?? 200, bundle.var_e64c2a1ff0c6f62f.min ?? 200, self.owner, "MOD_EXPLOSIVE", bundle.var_91c44200962aa050 ?? "air_patrol_crash_proj_mp" );
    }
    
    earthquake( level.airpatrolsettings.var_1e33b6a4ab9dbfd, level.airpatrolsettings.var_2216041e962f5709, self.origin, level.airpatrolsettings.var_ce5a78eae7b935d7 );
    self setscriptablepartstate( "explode", "on", 0 );
}

// Namespace air_patrol
// Params 0
// Checksum 0x542404c2, Offset: 0x5a0e
// Size: 0x25
function function_9ecae99f1b696869()
{
    self endon( #"death" );
    wait 0.05;
    self setscriptablepartstate( "visibility", "hide", 0 );
}

// Namespace air_patrol
// Params 6
// Checksum 0xee96170a, Offset: 0x5a3b
// Size: 0x108
function function_5203012df0290590( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo )
{
    level endon( #"game_ended" );
    self.exploding = 1;
    var_1ab7db68120283ff = function_7ecf68b33e0cf0dd( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo );
    var_1ab7db68120283ff.killcament = self.killcament;
    explodepart = "explode_large";
    
    if ( self.waterimpact )
    {
        explodepart += "_water";
    }
    
    var_1ab7db68120283ff setscriptablepartstate( explodepart, "active", 0 );
    
    if ( isdefined( self.explodeent ) )
    {
        self.explodeent delete();
    }
    
    self delete();
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( isdefined( var_1ab7db68120283ff ) )
    {
        if ( isdefined( var_1ab7db68120283ff.killcament ) )
        {
            var_1ab7db68120283ff.killcament delete();
        }
        
        var_1ab7db68120283ff delete();
    }
}

// Namespace air_patrol
// Params 4
// Checksum 0x8abe541b, Offset: 0x5b4b
// Size: 0xc0
function function_1aeb5f5aafa29662( origin, angles, stuckto, streakinfo )
{
    delayms = 50;
    
    if ( true )
    {
        delayms = randomintrange( 50, 350 );
    }
    
    starttime = self.preventstarttime + delayms;
    ent = function_7ecf68b33e0cf0dd( origin + anglestoup( angles ), angles, stuckto, self.shareddata.owner, starttime, streakinfo );
    self.preventstarttime = starttime;
    self.ents[ self.ents.size ] = ent;
    self.shareddata function_522076d02f8c0795();
    return ent;
}

// Namespace air_patrol
// Params 2
// Checksum 0x459f1f1c, Offset: 0x5c14
// Size: 0x3d
function function_24be2cb71a04b496( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace air_patrol
// Params 2
// Checksum 0xcc4fa668, Offset: 0x5c5a
// Size: 0x3d
function function_73206da319b77791( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace air_patrol
// Params 0
// Checksum 0x9fcf5da8, Offset: 0x5ca0
// Size: 0xc
function function_522076d02f8c0795()
{
    self.entstotal++;
}

// Namespace air_patrol
// Params 6
// Checksum 0xd4b037cf, Offset: 0x5cb4
// Size: 0xf3
function function_7ecf68b33e0cf0dd( origin, angles, stuckto, owner, starttime, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "air_patrol" ];
    ent = spawn( "script_model", origin );
    ent.angles = angles;
    ent.stuckto = stuckto;
    ent.owner = owner;
    ent.starttime = starttime;
    ent.streakinfo = streakinfo;
    ent setmodel( bundle.var_4e69ef417a7213bf ?? "ks_toma_strike_cluster_t10_mp" );
    ent setotherent( owner );
    ent setentityowner( owner );
    
    if ( isdefined( stuckto ) )
    {
        ent linkto( stuckto );
    }
    
    return ent;
}

// Namespace air_patrol
// Params 3
// Checksum 0x6e62f37e, Offset: 0x5db0
// Size: 0x178
function function_a17d8a9d617d374a( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7 )
{
    randdist = randomint( var_d0b84b2215b34610 );
    randangle = randomint( 360 );
    x = var_ff2c40cf5f0d3cc8[ 0 ] + randdist * cos( randangle );
    y = var_ff2c40cf5f0d3cc8[ 1 ] + randdist * sin( randangle );
    z = var_ff2c40cf5f0d3cc8[ 2 ];
    point = ( x, y, z );
    
    if ( isdefined( var_2bfd178bc84d73d7 ) )
    {
        point -= var_2bfd178bc84d73d7 * 100;
    }
    
    traceheightoffset = 10000;
    
    if ( isdefined( level.var_47dbfe761f1cf76c ) )
    {
        traceheightoffset = level.var_47dbfe761f1cf76c;
    }
    
    pointinfo = spawnstruct();
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( point + ( 0, 0, traceheightoffset ), point - ( 0, 0, traceheightoffset ), undefined, contents );
    
    if ( isdefined( trace[ "entity" ] ) )
    {
        entity = trace[ "entity" ];
        pointinfo.entityhit = entity;
        
        if ( function_5d27e580932e17e6( entity ) || function_3502d273013246e4( entity ) )
        {
            pointinfo.entityhittype = "flying";
        }
    }
    
    if ( isdefined( trace[ "position" ] ) )
    {
        point = trace[ "position" ];
    }
    
    pointinfo.point = point;
    return pointinfo;
}

// Namespace air_patrol
// Params 4
// Checksum 0x46f0e8e7, Offset: 0x5f31
// Size: 0x9c
function function_d04fc0c1ad910718( objid, icon, owner, offset )
{
    objective_icon( objid, icon );
    objective_showtoplayersinmask( objid );
    objective_addclienttomask( objid, owner );
    objective_onentity( objid, self );
    objective_setzoffset( objid, offset );
    objective_setplayintro( objid, 0 );
    objective_setplayoutro( objid, 0 );
    objective_setbackground( objid, 1 );
    
    if ( level.teambased )
    {
        objective_setownerteam( objid, owner.team );
    }
    else
    {
        objective_setownerclient( objid, owner );
    }
    
    objective_state( objid, "current" );
}

// Namespace air_patrol
// Params 1
// Checksum 0x8c77494f, Offset: 0x5fd5
// Size: 0x1f, Type: bool
function function_5d27e580932e17e6( entity )
{
    return isdefined( vehicle::get_ref() ) && entity vehicle::can_fly();
}

// Namespace air_patrol
// Params 1
// Checksum 0x233230ce, Offset: 0x5ffd
// Size: 0x2d, Type: bool
function function_3502d273013246e4( entity )
{
    return isdefined( entity.streakinfo ) && entity.sentientpool == "Killstreak_Air";
}

