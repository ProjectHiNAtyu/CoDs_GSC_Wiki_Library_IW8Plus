// scripts\mp\common\killstreaks\bombardment_common.gsc  (hash_722479658b144725.gscc) (size: 19204 Bytes / 0x4b04 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf17b60b0 (4051394736)
// size ...... 19204 (0x4b04)
// includes .. 9   (offset: 0x4758)
// strings ... 55  (offset: 0x47a0)
// dev strs .. 3   (offset: 0x4ae0)
// exports ... 44  (offset: 0x2f04)
// cseg ...... 0x427 + 0x2add (0x2f04)
// imports ... 147 (offset: 0x35e4)
// animtree1 . 0   (offset: 0x4b04)
// animtree2 . 0   (offset: 0x4b04)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\objidpoolmanager;

#namespace bombardment_common;

// Namespace bombardment_common
// Params 0, eflags: 0x1
// Checksum 0xad4a3e06, Offset: 0x445
// Size: 0x56
function autoexec init()
{
    utility::flag_init( "bombardment_common_initialized" );
    utility::registersharedfunc( #"bombardment_common", #"register", &function_5d6bc7d58edfdc2c );
    utility::registersharedfunc( #"bombardment_common", #"use", &tryusebombardment );
    utility::flag_set( "bombardment_common_initialized" );
}

// Namespace bombardment_common
// Params 4
// Checksum 0x481de87d, Offset: 0x4a3
// Size: 0x72
function function_5d6bc7d58edfdc2c( streakname, var_a96f2d2c5fc4b469, var_d7fac21b47c8ba60, var_5b728ff3b49b6e91 )
{
    if ( !isdefined( level.var_b225cccaa9deeda2 ) )
    {
        level.var_b225cccaa9deeda2 = [];
    }
    
    level.var_b225cccaa9deeda2[ streakname ] = { #var_d7fac21b47c8ba60:var_d7fac21b47c8ba60, #var_5b728ff3b49b6e91:var_5b728ff3b49b6e91, #typedata:function_9b5f9e4a73f973ba( var_a96f2d2c5fc4b469 ) };
}

// Namespace bombardment_common
// Params 1
// Checksum 0xfd70e0d1, Offset: 0x51d
// Size: 0xe7
function function_9b5f9e4a73f973ba( var_a96f2d2c5fc4b469 )
{
    return [ "MISSILE_TRAVEL_TIME":var_a96f2d2c5fc4b469.missile_data.bc_missile_travel_time ?? 4, "MAX_TIME_PER_PAYLOAD":var_a96f2d2c5fc4b469.bc_max_time_per_payload ?? 0.75, "MIN_TIME_PER_PAYLOAD":var_a96f2d2c5fc4b469.bc_min_time_per_payload ?? 0.5, "PAYLOAD_PER_WAVE":var_a96f2d2c5fc4b469.bc_payload_per_wave ?? 4, "MAX_TIME_PER_WAVE":var_a96f2d2c5fc4b469.bc_max_time_per_wave ?? 4, "MIN_TIME_PER_WAVE":var_a96f2d2c5fc4b469.bc_min_time_per_wave ?? 3.25, "WAVE_COUNT":var_a96f2d2c5fc4b469.bc_waves ?? 4, "LAUNCH_DELAY":var_a96f2d2c5fc4b469.bc_launch_delay ?? 5, "SELECTION_RADIUS":var_a96f2d2c5fc4b469.bc_selection_radius ?? 900 ];
}

// Namespace bombardment_common
// Params 1
// Checksum 0x250a50ee, Offset: 0x60d
// Size: 0xbc
function function_f732ef7505fe9927( streakinfo )
{
    if ( !isdefined( level.var_b225cccaa9deeda2[ streakinfo.streakname ].var_10ca33f189648678 ) )
    {
        level.var_b225cccaa9deeda2[ streakinfo.streakname ].var_10ca33f189648678 = 0;
    }
    
    level.var_b225cccaa9deeda2[ streakinfo.streakname ].var_10ca33f189648678++;
    return ( isplayer( self ) ? self getxuid() : self getentitynumber() ) + "_" + streakinfo.streakname + "_" + level.var_b225cccaa9deeda2[ streakinfo.streakname ].var_10ca33f189648678;
}

// Namespace bombardment_common
// Params 2
// Checksum 0x94b45803, Offset: 0x6d2
// Size: 0x220
function setupstruct( id, streakinfo )
{
    data = spawnstruct();
    typedata = level.var_b225cccaa9deeda2[ streakinfo.streakname ].typedata;
    data.starttimems = gettime();
    data.totaltimesec = typedata[ "LAUNCH_DELAY" ];
    data.strikedelay = [];
    numwaves = typedata[ "WAVE_COUNT" ];
    var_c11b16cce6cf81ee = typedata[ "PAYLOAD_PER_WAVE" ];
    var_c3dc6dc0fbcf4017 = typedata[ "MIN_TIME_PER_WAVE" ];
    var_afeaad0d882fca6d = typedata[ "MAX_TIME_PER_WAVE" ];
    var_a4db596a495f0704 = typedata[ "MIN_TIME_PER_PAYLOAD" ];
    var_c9bade25e3dc4c62 = typedata[ "MAX_TIME_PER_PAYLOAD" ];
    data.wavedelay = [];
    
    for ( i = 0; i < numwaves ; i++ )
    {
        data.strikedelay[ i ] = [];
        
        for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
        {
            timetowait = var_a4db596a495f0704 == var_c9bade25e3dc4c62 ? var_a4db596a495f0704 : randomfloatrange( var_a4db596a495f0704, var_c9bade25e3dc4c62 );
            data.totaltimesec += timetowait;
            data.strikedelay[ i ][ j ] = timetowait;
        }
        
        timetowait = var_c3dc6dc0fbcf4017 == var_afeaad0d882fca6d ? var_c3dc6dc0fbcf4017 : randomfloatrange( var_c3dc6dc0fbcf4017, var_afeaad0d882fca6d );
        data.totaltimesec += timetowait;
        data.wavedelay[ i ] = timetowait;
    }
    
    if ( !isdefined( level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes ) )
    {
        level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes = [];
    }
    
    level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes[ id ] = data;
}

// Namespace bombardment_common
// Params 1
// Checksum 0x5bf14519, Offset: 0x8fa
// Size: 0x1e8, Type: bool
function tryusebombardment( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.killstreaktriggeredfunc )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( self.kstargetlocation )
    {
        streakinfo.targetlocation = self.kstargetlocation;
        self.kstargetlocation = undefined;
        firedresult = weaponFired( streakinfo, undefined, undefined );
        
        if ( firedresult != "success" )
        {
            return false;
        }
    }
    else
    {
        deployweaponname = streakinfo.bundle.deployweaponname ?? "iw9_laser_large_ir_mp";
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponfireddeploysharedfunc( streakinfo, makeweapon( deployweaponname ), "weapon_fired", undefined, undefined, &weaponFired );
        updateomnvar( "ui_using_" + streakinfo.streakname, deployresult );
        
        if ( !deployresult )
        {
            streakinfo notify( #"hash_a4dbd5131c103980" );
            return false;
        }
    }
    
    if ( level.killstreakbeginusefunc )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    streakinfo.var_37a67976b515ddf = self getplayerangles();
    bundle = streakinfo.bundle;
    used_splash_ref = bundle.usedsplashref;
    var_8f34e01a145e99e2 = utility::getsharedfunc( #"splash", #"registersplashbundle" );
    
    if ( var_8f34e01a145e99e2 )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", streakinfo.streakname, self.origin );
    startstrike( streakinfo );
    return true;
}

// Namespace bombardment_common
// Params 3
// Checksum 0xb8017dde, Offset: 0xaeb
// Size: 0x1be
function weaponFired( streakinfo, firedweaponobj, firedprojectile )
{
    if ( !streakinfo.targetoverride )
    {
        mappoint = airstrike::airstrike_getownerlookatpos( self, 1 );
        
        if ( !mappoint )
        {
            utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/INVALID_POINT" );
            return "continue";
        }
        
        bundle = streakinfo.bundle;
        
        if ( bundle.var_8771a3dbfc3b5dbe && !namespace_9d8e359c3b1041e5::function_99585ce0ed7d5df7( streakinfo, mappoint ) )
        {
            return "continue";
        }
    }
    
    if ( namespace_9d8e359c3b1041e5::is_empdsharedfunc() )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/cannot_be_used" );
        return "continue";
    }
    
    utility::callsharedfunc( #"sound", #"playkillstreakdeploydialog", streakinfo.streakname );
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, streakinfo.streakname + "_use", #"use", 1 );
    updateomnvar( "ui_using_" + streakinfo.streakname, 0 );
    marker = createmarker( streakinfo, mappoint );
    
    if ( !isdefined( streakinfo.markers ) )
    {
        streakinfo.markers = [];
    }
    
    streakinfo.markers[ streakinfo.markers.size ] = marker;
    thread function_2bb2540764ac76b6( streakinfo );
    
    if ( streakinfo.markers.size < streakinfo.var_6d32ae6f8cb439d4 )
    {
        return "continue";
    }
    
    self notify( #"hash_b29435a3a44b69f0" );
    return "success";
}

// Namespace bombardment_common
// Params 1
// Checksum 0xedef897f, Offset: 0xcb2
// Size: 0x136
function startstrike( streakinfo )
{
    id = function_f732ef7505fe9927( streakinfo );
    streakinfo.id = id;
    setupstruct( id, streakinfo );
    thread watchgameend( id, streakinfo );
    thread watchfinish( id, streakinfo );
    
    foreach ( marker in streakinfo.markers )
    {
        thread function_bb4d54f9254e2f0b( streakinfo, marker, id );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        scoreeventkey = function_5d044133536d0766( "", strtok( streakinfo.streakname, "_" ) );
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, scoreeventkey );
    }
}

// Namespace bombardment_common
// Params 3
// Checksum 0xa250ded5, Offset: 0xdf0
// Size: 0x78
function function_bb4d54f9254e2f0b( streakinfo, marker, id )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    marker notify( #"hash_6aa806a3a267001f", "attackStarted" );
    self notify( #"hash_60733902ed6a2449" );
    function_b14261a7353da0a5( streakinfo, isvector( marker ) ? marker : marker.origin, id );
}

// Namespace bombardment_common
// Params 3
// Checksum 0xa694899b, Offset: 0xe70
// Size: 0x305
function function_b14261a7353da0a5( streakinfo, pos, id )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    streakinfo.shots_fired++;
    bundle = streakinfo.bundle;
    typedata = level.var_b225cccaa9deeda2[ streakinfo.streakname ].typedata;
    radius = streakinfo.var_b9f13b776244947c ? streakinfo.var_b9f13b776244947c : typedata[ "SELECTION_RADIUS" ];
    delaytime = streakinfo.launchdelayoverride ? streakinfo.launchdelayoverride : typedata[ "LAUNCH_DELAY" ];
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( self, self.team, radius + 300, streakinfo.streakname, pos, isbrgamemode() ? 6000 : bundle.bcdata.var_6d661a165aa38a86 );
    thread function_bcc5df59a81df112( streakinfo, pos );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( delaytime );
    
    if ( !isdefined( self.attackrange ) )
    {
        self.attackrange = 4000;
    }
    
    if ( !isdefined( self.var_57a843751bdea6d8 ) )
    {
        self.var_57a843751bdea6d8 = 0;
    }
    
    ownerforward = anglestoforward( self.angles );
    ownerright = anglestoright( self.angles );
    var_147ece74855f6277 = isplayer( self ) ? anglestoforward( self getplayerangles() ) : ownerforward;
    var_5a15f8a13e75600f = typedata[ "WAVE_COUNT" ];
    
    for ( i = 0; i < var_5a15f8a13e75600f ; i++ )
    {
        var_c11b16cce6cf81ee = streakinfo.var_6f50b012a8dd6332 ? streakinfo.var_6f50b012a8dd6332 : typedata[ "PAYLOAD_PER_WAVE" ];
        
        for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
        {
            var_4d99e8552caf305a = findunobstructedfiringinfo( streakinfo, pos, radius, var_147ece74855f6277, ownerforward, ownerright, i, j );
            thread launchmissile( streakinfo, var_4d99e8552caf305a );
            timetowait = streakinfo.var_89ba4f440f386ce ? streakinfo.var_89ba4f440f386ce : level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes[ id ].strikedelay[ i ][ j ];
            wait timetowait;
        }
        
        wait level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes[ id ].wavedelay[ i ];
    }
    
    utility::callsharedfunc( #"killstreak", #"killstreak_explosionnearai", pos, 1000, "allies", streakinfo.streakname );
    level notify( "bombardment_common_finished_" + id );
}

// Namespace bombardment_common
// Params 2
// Checksum 0x6271b610, Offset: 0x117d
// Size: 0x308
function launchmissile( streakinfo, var_4d99e8552caf305a )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = streakinfo.bundle;
    bcdata = bundle.bcdata;
    typedata = level.var_b225cccaa9deeda2[ streakinfo.streakname ].typedata;
    missile = magicgrenademanual( bcdata.bc_missile_weapon, var_4d99e8552caf305a.sourcepos, var_4d99e8552caf305a.initvelocity, typedata[ "MISSILE_TRAVEL_TIME" ] + 2, self );
    missile.streakinfo = streakinfo;
    
    if ( level.streakglobals.var_3feb5f5305e6fe83 )
    {
        missile function_681f2a0d5c7420db( streakinfo.bundle.var_77216bac95c39355 );
        missile function_d0fcbff5a25cc481( streakinfo.bundle.var_4d7d4b6afc661107 );
        missile function_d93054349b7f4e82( var_4d99e8552caf305a.goalpos );
    }
    
    missile update_minimap_icon( 1, var_4d99e8552caf305a.goalpos );
    missile setentityowner( self );
    missile setotherent( self );
    missile.owner = self;
    missile.streakinfo = streakinfo;
    killcament = spawn( "script_model", var_4d99e8552caf305a.sourcepos );
    killcament linkto( missile, "tag_origin", ( 10, 0, 10 ), ( 0, 0, 0 ) );
    missile.killcament = killcament;
    missile.explodeent = spawn( "script_model", missile.origin );
    missile.explodeent setmodel( bcdata.var_69e2772648bb5b76 ?? "ks_toma_strike_missile_mp" );
    missile.explodeent linkto( missile );
    missile.explodeent dontinterpolate();
    missile.explodeent setentityowner( self );
    missile.explodeent.killcament = killcament;
    missile setscriptablepartstate( "launch", "active", 0 );
    missile setscriptablepartstate( "trail", "active", 0 );
    missile thread watchowner();
    missile thread watchempd();
    
    if ( bcdata.var_f451397320f3e104 )
    {
        missile.angles = generateaxisanglesfromforwardvector( var_4d99e8552caf305a.initvelocity, missile.angles );
        missile thread updateangle();
    }
    
    if ( var_4d99e8552caf305a.var_471d07fbd87e726b )
    {
        missile thread delayhide( var_4d99e8552caf305a.var_471d07fbd87e726b );
    }
    
    missile thread function_176bdd47ddb8f721( vectortoangles( var_4d99e8552caf305a.initvelocity ), gettime(), var_4d99e8552caf305a.initvelocity );
}

// Namespace bombardment_common
// Params 3
// Checksum 0xf17bf095, Offset: 0x148d
// Size: 0xbc
function missilestuck( stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = !self.waterimpact ? anglestoup( self.angles ) : ( 0, 0, 1 );
    right = anglestoright( launchangles );
    angles = abs( vectordot( forward, up ) ) >= 0.9848 ? function_c40891c366effea6( up, right ) : function_6ab742be89681d41( up, forward );
    self.angles = angles;
    function_cb413cc7d1b83efb();
}

// Namespace bombardment_common
// Params 6
// Checksum 0xef51624c, Offset: 0x1551
// Size: 0x159
function function_30eb3ddd34618732( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.exploding )
    {
        return;
    }
    
    self.exploding = 1;
    var_1ab7db68120283ff = createexplosion( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo );
    var_1ab7db68120283ff.killcament = self.killcament;
    explodepart = "explode_large";
    
    if ( self.waterimpact )
    {
        explodepart += "_water";
    }
    else if ( streakinfo.var_df3d94091dbd9fc3 )
    {
        playrumbleonposition( "artillery_rumble", self.origin );
    }
    
    haspart = var_1ab7db68120283ff getscriptablehaspart( explodepart );
    
    if ( haspart )
    {
        var_1ab7db68120283ff setscriptablepartstate( explodepart, "active", 1 );
    }
    
    if ( self.explodeent )
    {
        self.explodeent delete();
    }
    
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( var_1ab7db68120283ff )
    {
        if ( var_1ab7db68120283ff.killcament )
        {
            var_1ab7db68120283ff.killcament delete();
        }
        
        var_1ab7db68120283ff delete();
    }
    
    self delete();
}

// Namespace bombardment_common
// Params 1
// Checksum 0xe359f809, Offset: 0x16b2
// Size: 0xc4
function function_63b50cece9e5a19f( var_310c207acff4725 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.exploding )
    {
        return;
    }
    
    self.exploding = 1;
    self.explodeent unlink();
    self.explodeent.origin = var_310c207acff4725;
    self.explodeent setscriptablepartstate( "explode", "active", 0 );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( self.explodeent )
    {
        self.explodeent delete();
    }
    
    update_minimap_icon( 0 );
    
    if ( self.killcament )
    {
        self.killcament delete();
    }
    
    self delete();
}

// Namespace bombardment_common
// Params 0
// Checksum 0x34da93b1, Offset: 0x177e
// Size: 0x8b
function waittillimpact()
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    impactinfo = killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact" );
    stuckto = undefined;
    
    if ( impactinfo )
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

// Namespace bombardment_common
// Params 0
// Checksum 0xdae24f3, Offset: 0x1812
// Size: 0x149
function function_cb413cc7d1b83efb()
{
    streakinfo = self.streakinfo;
    bundle = streakinfo.bundle;
    bcdata = bundle.bcdata;
    typestruct = level.var_b225cccaa9deeda2[ streakinfo.streakname ];
    
    if ( typestruct.var_5b728ff3b49b6e91 )
    {
        self.owner thread [[ typestruct.var_5b728ff3b49b6e91 ]]( self.origin, streakinfo, self );
    }
    
    if ( bcdata.var_70dd12d08330bf3e )
    {
        radius = bcdata.var_613bbb633281cc13;
        mindamage = bcdata.var_99bef6a305a98959;
        maxdamage = bcdata.var_23f61d2511b4ea9f;
        weapon = makeweapon( bcdata.var_23f61d2511b4ea9f );
        self radiusdamage( self.origin, radius, maxdamage, mindamage, streakinfo.owner, "MOD_EXPLOSIVE", weapon, undefined, undefined, undefined, 0 );
    }
    
    function_30eb3ddd34618732( self.origin, self.angles, undefined, self.owner, gettime(), streakinfo );
}

// Namespace bombardment_common
// Params 0
// Checksum 0xc151d6cb, Offset: 0x1963
// Size: 0xc8
function updateangle()
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
        if ( !prevloc )
        {
            prevloc = self getorigin();
            waitframe();
            continue;
        }
        
        currloc = self getorigin();
        
        if ( !currloc )
        {
            waitframe();
            continue;
        }
        
        self.angles = anglelerpquat( self.angles, vectortoangles( currloc - prevloc ), self.streakinfo.var_a3fe3d63cfa0baa3 ?? 1 );
        prevloc = currloc;
        waitframe();
    }
}

// Namespace bombardment_common
// Params 1
// Checksum 0xc9dcaf15, Offset: 0x1a33
// Size: 0x3e
function delayhide( delaytime )
{
    self endon( #"death" );
    
    if ( delaytime > 0.02 )
    {
        wait delaytime - 0.02;
        self setscriptablepartstate( "visibility", "hide", 1 );
    }
}

// Namespace bombardment_common
// Params 8
// Checksum 0x10ee7ac4, Offset: 0x1a79
// Size: 0x1ca
function findunobstructedfiringinfo( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_147ece74855f6277, ownerforward, ownerright, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    gravity = !getdvarint( @"bg_bristotallynormal", 0 ) ? getdvarfloat( @"bg_gravity", 800 ) : getdvarfloat( @"hash_2f4cf62df1af9a6", 125 );
    typedata = level.var_b225cccaa9deeda2[ streakinfo.streakname ].typedata;
    var_4d99e8552caf305a = spawnstruct();
    var_ae8856ebc968addf = findoptimallaunchpos( streakinfo, var_ff2c40cf5f0d3cc8, var_147ece74855f6277, ownerforward, ownerright );
    var_2bfd178bc84d73d7 = vectornormalize( var_ff2c40cf5f0d3cc8 - ( var_ae8856ebc968addf[ 0 ], var_ae8856ebc968addf[ 1 ], 0 ) );
    var_50e6a9e25a9fba6d = getbombingpoint( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 );
    var_7dae7f8ea43ba5c8 = ( 0, 0, -1 * gravity );
    traveltime = typedata[ "MISSILE_TRAVEL_TIME" ];
    var_9dce17a116cdf149 = ( var_50e6a9e25a9fba6d.point - 0.5 * var_7dae7f8ea43ba5c8 * squared( traveltime ) - var_ae8856ebc968addf ) / traveltime;
    var_4d99e8552caf305a.sourcepos = var_ae8856ebc968addf;
    var_4d99e8552caf305a.entityhit = var_50e6a9e25a9fba6d.entityhit;
    var_4d99e8552caf305a.entityhittype = var_50e6a9e25a9fba6d.entityhittype;
    var_4d99e8552caf305a.goalpos = var_50e6a9e25a9fba6d.point;
    var_4d99e8552caf305a.initvelocity = var_9dce17a116cdf149;
    var_4d99e8552caf305a.var_471d07fbd87e726b = traveltime;
    return var_4d99e8552caf305a;
}

// Namespace bombardment_common
// Params 6
// Checksum 0x3504fba5, Offset: 0x1c4c
// Size: 0xa2
function getbombingpoint( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    typestruct = level.var_b225cccaa9deeda2[ streakinfo.streakname ];
    
    if ( typestruct.var_d7fac21b47c8ba60 )
    {
        targetpoint = self [[ typestruct.var_d7fac21b47c8ba60 ]]( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 );
        return { #point:targetpoint };
    }
    
    return getrandombombingpoint( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 );
}

// Namespace bombardment_common
// Params 5
// Checksum 0x54498341, Offset: 0x1cf7
// Size: 0x2eb
function findoptimallaunchpos( streakinfo, targetpoint, var_147ece74855f6277, ownerforward, ownerright )
{
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( targetpoint - var_147ece74855f6277 * 30, targetpoint + var_147ece74855f6277 * 1000, undefined, contents );
    coord = trace[ "position" ] + trace[ "normal" ] * 20;
    targetpos = coord;
    bundle = streakinfo.bundle;
    bcdata = bundle.bcdata;
    launchheight = bcdata.var_6d661a165aa38a86 ?? 5000;
    var_f3401a2195395d24 = bcdata.var_d3b395c218a23b64 ?? 0;
    var_c09eeec12b11a47 = bcdata.var_f4158cd86cd343a3 ?? 0;
    var_5b3eac5d3b856cef = 0;
    
    if ( var_c09eeec12b11a47 > 0 )
    {
        var_5b3eac5d3b856cef = randomfloat( var_c09eeec12b11a47 * 2 ) - var_c09eeec12b11a47;
    }
    
    trajectoryangle = ( bcdata.var_21f6132b17047686 ?? 45 ) + var_5b3eac5d3b856cef;
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

// Namespace bombardment_common
// Params 5
// Checksum 0xbb175636, Offset: 0x1feb
// Size: 0x16f
function getrandombombingpoint( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    randdist = randomint( var_d0b84b2215b34610 );
    randangle = randomint( 360 );
    x = var_ff2c40cf5f0d3cc8[ 0 ] + randdist * cos( randangle );
    y = var_ff2c40cf5f0d3cc8[ 1 ] + randdist * sin( randangle );
    z = var_ff2c40cf5f0d3cc8[ 2 ];
    point = ( x, y, z );
    
    if ( var_2bfd178bc84d73d7 )
    {
        point -= var_2bfd178bc84d73d7 * 100;
    }
    
    traceheightoffset = 10000;
    pointinfo = spawnstruct();
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( point + ( 0, 0, traceheightoffset ), point - ( 0, 0, traceheightoffset ), undefined, contents );
    
    if ( trace[ "entity" ] )
    {
        entity = trace[ "entity" ];
        pointinfo.entityhit = entity;
        
        if ( isflyingvehicle( entity ) || isflyingkillstreak( entity ) )
        {
            pointinfo.entityhittype = "flying";
        }
    }
    
    if ( trace[ "position" ] )
    {
        point = trace[ "position" ];
    }
    
    pointinfo.point = point;
    return pointinfo;
}

// Namespace bombardment_common
// Params 2
// Checksum 0xc7982dfa, Offset: 0x2163
// Size: 0x194
function function_bcc5df59a81df112( streakinfo, markerorigin )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = streakinfo.bundle;
    typedata = level.var_b225cccaa9deeda2[ streakinfo.streakname ].typedata;
    bcdata = bundle.bcdata;
    soundalias = bcdata.var_f31147f9c92252fa;
    
    if ( !bcdata.var_8978b3da2f859226 || !soundalias )
    {
        return;
    }
    
    if ( ( typedata[ "LAUNCH_DELAY" ] ?? 0 ) > 0 )
    {
        wait typedata[ "LAUNCH_DELAY" ];
    }
    
    if ( isbrgamemode() )
    {
        playpos = ( markerorigin[ 0 ], markerorigin[ 1 ], 7000 );
    }
    else
    {
        ownerforward = anglestoforward( self.angles );
        ownerright = anglestoright( self.angles );
        var_147ece74855f6277 = isplayer( self ) ? anglestoforward( self getplayerangles() ) : ownerforward;
        launchpos = findoptimallaunchpos( markerorigin, var_147ece74855f6277, ownerforward, ownerright );
        soundpos = length2d( launchpos - self.origin ) * vectornormalize2( launchpos - self.origin ) * 2 + self.origin;
        playpos = ( soundpos[ 0 ], soundpos[ 1 ], 0 );
    }
    
    playsoundatpos( playpos, soundalias );
}

// Namespace bombardment_common
// Params 2, eflags: 0x4
// Checksum 0xd870b283, Offset: 0x22ff
// Size: 0x200
function private update_minimap_icon( var_5207c09168cffe2d, missilegoalpos )
{
    bundle = self.streakinfo.bundle;
    
    switch ( var_5207c09168cffe2d )
    {
        case 0:
            if ( isdefined( self.minimapid ) )
            {
                if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
                {
                    [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
                }
                
                self.minimapid = undefined;
            }
            
            break;
        case 1:
            var_f920b37e2fe18c87 = istrue( bundle.bcdata.var_2873eb443747f37 );
            namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
            
            if ( level.streakglobals.var_3feb5f5305e6fe83 )
            {
                namespace_9d8e359c3b1041e5::function_bc3d11edade5004( bundle.var_77216bac95c39355 );
                namespace_9d8e359c3b1041e5::function_2774ff2792a00056( bundle.var_4d7d4b6afc661107 );
                namespace_9d8e359c3b1041e5::function_fe287412c2a2bb55( missilegoalpos );
            }
            
            if ( !var_f920b37e2fe18c87 && bundle.minimapicon )
            {
                namespace_9d8e359c3b1041e5::setmissileimpactminimapiconsharedfunc( bundle.minimapicon );
            }
            
            break;
        case 2:
            if ( bundle.impacticon )
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
                namespace_9d8e359c3b1041e5::setmissileimpactminimapiconsharedfunc( bundle.impacticon );
            }
            else
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
            }
            
            if ( isdefined( self.minimapid ) )
            {
                if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
                {
                    [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
                }
                
                self.minimapid = undefined;
            }
            
            break;
        default:
            assertmsg( "<dev string:x24>" + var_5207c09168cffe2d + "<dev string:x38>" );
            break;
    }
}

// Namespace bombardment_common
// Params 2
// Checksum 0x84f1b1be, Offset: 0x2507
// Size: 0x17a
function createmarker( streakinfo, point )
{
    markerorigin = streakinfo.targetoverride ? streakinfo.targetoverride : point;
    owner = self;
    bundle = streakinfo.bundle;
    marker = spawn( "script_model", markerorigin );
    bcdata = bundle.bcdata;
    
    if ( !marker )
    {
        script::demoforcesre( "Unable to spawn bombardment marker [bombardment_common_createMarker] " + ( point ?? "unknown origin " ) );
        return;
    }
    
    marker setmodel( bcdata.var_b95c8452c15c87c8 ?? "ks_toma_strike_marker_mp" );
    marker.objidnum = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        marker.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
    }
    
    objidpoolmanager::function_e4d6a71507372662( marker.objidnum, 0 );
    marker.icon = bcdata.var_c99efb61c6586628 ?? "hud_icon_killstreak_tomastrike";
    marker setotherent( owner );
    marker setmarkerobjective( marker.objidnum, marker.icon, owner, 50 );
    marker thread handlemarkerscriptable( streakinfo );
    return marker;
}

// Namespace bombardment_common
// Params 4
// Checksum 0x45a78b9c, Offset: 0x268a
// Size: 0x9c
function setmarkerobjective( objid, icon, owner, offset )
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

// Namespace bombardment_common
// Params 1
// Checksum 0xa6819f48, Offset: 0x272e
// Size: 0xbe
function handlemarkerscriptable( streakinfo )
{
    self endon( #"death" );
    self setscriptablepartstate( "target", "on", 0 );
    self waittill( #"hash_6aa806a3a267001f", update );
    
    if ( update == "attackStarted" )
    {
        level waittill( "bombardment_common_cleanup_" + streakinfo.id );
    }
    else
    {
        assert( update == "<dev string:x5b>" );
    }
    
    if ( self )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace bombardment_common
// Params 3
// Checksum 0xade94744, Offset: 0x27f4
// Size: 0xb3
function function_176bdd47ddb8f721( launchangles, launchtimems, launchvelocity )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    stuckto = waittillimpact();
    update_minimap_icon( 2 );
    wait 0.05;
    gravityaccel = -1 * getdvarfloat( @"bg_gravity", 800 );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, gravityaccel * traveltime );
    missilestuck( stuckto, launchangles, impactvelocity );
    self notify( #"hash_7419a6ae62fb730b" );
}

// Namespace bombardment_common
// Params 0
// Checksum 0xb9aa5845, Offset: 0x28af
// Size: 0x87
function watchowner()
{
    self endon( #"missile_empd" );
    self endon( #"death" );
    self endon( #"hash_7419a6ae62fb730b" );
    owner = self.owner;
    owner waittill( #"disconnect" );
    
    if ( self.killcament )
    {
        self.killcament delete();
    }
    
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
    thread function_63b50cece9e5a19f( self.origin );
    self notify( #"hash_f0d4a2ca833ee95c" );
}

// Namespace bombardment_common
// Params 0
// Checksum 0x8a6810cf, Offset: 0x293e
// Size: 0x94
function watchempd()
{
    self endon( #"death" );
    owner = self.owner;
    owner endon( #"disconnect" );
    
    while ( true )
    {
        if ( owner.ksempd )
        {
            self notify( #"missile_empd" );
            
            if ( self.killcament )
            {
                self.killcament delete();
            }
            
            namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
            thread function_63b50cece9e5a19f( self.origin );
            self notify( #"hash_f0d4a2ca833ee95c" );
            break;
        }
        
        waitframe();
    }
}

// Namespace bombardment_common
// Params 2
// Checksum 0x3f3378ea, Offset: 0x29da
// Size: 0x6e
function watchgameend( id, streakinfo )
{
    level endon( "bombardment_common_cleanup_" + id );
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

// Namespace bombardment_common
// Params 2
// Checksum 0x409fc7db, Offset: 0x2a50
// Size: 0x9b
function watchfinish( id, streakinfo )
{
    level endon( #"game_ended" );
    level thread function_4ca9be75bed0f788( "disconnect", id, self );
    level thread function_4ca9be75bed0f788( "bombardment_common_finished_" + id, id );
    level waittill( "bombardment_common_cleanup_" + id );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( self )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    level.var_b225cccaa9deeda2[ streakinfo.streakname ].active_strikes[ id ] = undefined;
}

// Namespace bombardment_common
// Params 3
// Checksum 0x13d05bfe, Offset: 0x2af3
// Size: 0x50
function function_4ca9be75bed0f788( actionnotify, id, player )
{
    level endon( "bombardment_common_cleanup_" + id );
    notifyobject = level;
    
    if ( player )
    {
        notifyobject = player;
    }
    
    notifyobject waittill( actionnotify );
    level notify( "bombardment_common_cleanup_" + id );
}

// Namespace bombardment_common
// Params 1
// Checksum 0x76b29aa4, Offset: 0x2b4b
// Size: 0xd3
function function_2bb2540764ac76b6( streakinfo )
{
    self notify( #"hash_8c081f5bfce7c32b" );
    self endon( #"hash_8c081f5bfce7c32b" );
    self endon( #"hash_b29435a3a44b69f0" );
    utility::waittill_any_ents( self, "death", self, "disconnect", self, "weapon_change", level, "game_ended" );
    
    foreach ( marker in streakinfo.markers )
    {
        marker notify( #"hash_6aa806a3a267001f", "killstreak_cancelled" );
    }
}

// Namespace bombardment_common
// Params 1, eflags: 0x4
// Checksum 0x2cdcb9c2, Offset: 0x2c26
// Size: 0x33, Type: bool
function private function_a7e326714b4bb072( streakinfo )
{
    return streakinfo.bundle.bcdata.var_586e222343351f53 ?? "ks_toma_strike_cluster_mp";
}

// Namespace bombardment_common
// Params 6
// Checksum 0x309e1ed0, Offset: 0x2c62
// Size: 0xe9
function createexplosion( origin, angles, stuckto, owner, starttime, streakinfo )
{
    ent = spawn( "script_model", origin );
    ent.angles = angles;
    ent.stuckto = stuckto;
    ent.owner = owner;
    ent.starttime = starttime;
    ent.streakinfo = streakinfo;
    explosion_model = function_a7e326714b4bb072( streakinfo );
    ent setmodel( explosion_model );
    
    if ( owner )
    {
        ent setotherent( owner );
        ent setentityowner( owner );
    }
    
    if ( stuckto && ( !isagent( stuckto ) || isalive( stuckto ) ) )
    {
        ent linkto( stuckto );
    }
    
    return ent;
}

// Namespace bombardment_common
// Params 0
// Checksum 0xfc1de8c5, Offset: 0x2d54
// Size: 0x72
function startexplosion()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    
    if ( self.stuckto )
    {
        self.stuckto endon( #"death" );
    }
    
    while ( gettime() < self.starttime )
    {
        waitframe();
    }
    
    thread explosionend();
}

// Namespace bombardment_common
// Params 0
// Checksum 0xc1f0a64f, Offset: 0x2dce
// Size: 0x1c
function explosionend()
{
    self setscriptablepartstate( "explode", "active", 0 );
    wait 1;
    self delete();
}

// Namespace bombardment_common
// Params 2
// Checksum 0x6b2a8f7a, Offset: 0x2df2
// Size: 0x3d
function function_c40891c366effea6( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace bombardment_common
// Params 2
// Checksum 0xce820967, Offset: 0x2e38
// Size: 0x3d
function function_6ab742be89681d41( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace bombardment_common
// Params 1
// Checksum 0x479f303a, Offset: 0x2e7e
// Size: 0x20, Type: bool
function isflyingvehicle( entity )
{
    return entity vehicle::get_ref() && entity vehicle::can_fly();
}

// Namespace bombardment_common
// Params 1
// Checksum 0x17a3b4d2, Offset: 0x2ea7
// Size: 0x2c, Type: bool
function isflyingkillstreak( entity )
{
    return entity.streakinfo && entity.sentientpool == "Killstreak_Air";
}

// Namespace bombardment_common
// Params 2
// Checksum 0xb287819e, Offset: 0x2edc
// Size: 0x28
function updateomnvar( omnvar, value )
{
    if ( self function_5c766d1d0140b86( omnvar ) )
    {
        self setclientomnvar( omnvar, value );
    }
}

