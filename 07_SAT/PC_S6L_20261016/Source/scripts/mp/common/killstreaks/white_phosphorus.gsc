// scripts\mp\common\killstreaks\white_phosphorus.gsc  (hash_5efe37e054c73937.gscc) (size: 25598 Bytes / 0x63fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x173d58c4 (389896388)
// size ...... 25598 (0x63fe)
// includes .. 13  (offset: 0x5e82)
// strings ... 73  (offset: 0x5eea)
// dev strs .. 5   (offset: 0x63c2)
// exports ... 68  (offset: 0x4092)
// cseg ...... 0x57e + 0x3b14 (0x4092)
// imports ... 146 (offset: 0x4b32)
// animtree1 . 0   (offset: 0x63fe)
// animtree2 . 0   (offset: 0x63fe)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;

#namespace white_phosphorus;

// Namespace white_phosphorus
// Params 0
// Checksum 0x88b8b3b9, Offset: 0x59c
// Size: 0xa7
function init()
{
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"init" ) )
    {
        [[ utility::getsharedfunc( #"white_phosphorus", #"init" ) ]]();
    }
    
    level.activewpzones = [];
    level.activewpinnerzones = [];
    level.white_phosphorus_damage_area = getent( "white_phosphorus_damage", #targetname );
    
    /#
        setdevdvarifuninitialized( @"hash_b72a0bb47130fb8e", 0 );
        setdevdvarifuninitialized( @"scr_wp_lifetime", 30 );
        setdevdvarifuninitialized( @"hash_51c63714caa01867", 0 );
        setdevdvarifuninitialized( @"hash_1aff95d5bc69c60f", 0 );
    #/
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xf61b84d3, Offset: 0x64b
// Size: 0x97, Type: bool
function weapongivenwp( streakinfo )
{
    if ( level.wpinprogress )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/WP_ACTIVE" );
        }
        
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"white_phosphorus", #"hash_bc456c37cf700436" ) ]]( 0, 1, "long_arrow" );
    }
    
    return true;
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x7bf59195, Offset: 0x6eb
// Size: 0x22
function tryusewp()
{
    streakinfo = killstreak_utility::createstreakinfo( "white_phosphorus", self );
    return tryusewpfromstruct( streakinfo );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x2de414c5, Offset: 0x716
// Size: 0x1c5, Type: bool
function tryusewpfromstruct( streakinfo )
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
    
    deployweaponobj = makeweapon( "ks_remote_map_mp" );
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &weapongivenwp );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    mappointinfo = wp_getmapselectioninfo( streakinfo, 1, 1 );
    
    if ( !isdefined( mappointinfo ) )
    {
        return false;
    }
    
    thread wp_startdeploy( mappointinfo, streakinfo );
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "use_" + streakinfo.streakname, #"use", 1, var_65934120c2efeb81 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "white_phosphorus", self.origin );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_white_phosphorus", self );
    }
    
    return true;
}

// Namespace white_phosphorus
// Params 3
// Checksum 0x75dec53a, Offset: 0x8e4
// Size: 0xbc
function wp_getmapselectioninfo( streakinfo, numselection, directionalselection )
{
    val::set( "map_selection", "weapon_switch", 0 );
    self setsoundsubmix( "mp_killstreak_overlay" );
    mappointinfo = undefined;
    
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"getselectmappoint" ) )
    {
        mappointinfo = self [[ utility::getsharedfunc( #"white_phosphorus", #"getselectmappoint" ) ]]( streakinfo, numselection, directionalselection );
    }
    
    if ( !isdefined( mappointinfo ) )
    {
        val::reset_all( "map_selection" );
        self clearsoundsubmix( "mp_killstreak_overlay" );
        return;
    }
    
    val::reset_all( "map_selection" );
    self clearsoundsubmix( "mp_killstreak_overlay" );
    return mappointinfo;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x54e0cfd4, Offset: 0x9a9
// Size: 0x141
function wp_startdeploy( mappointinfo, streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( level.wpinprogress )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/WP_ACTIVE" );
        }
        
        return 0;
    }
    
    level.wpinprogress = 1;
    
    foreach ( deployindex, pointinfo in mappointinfo )
    {
        mappoint = pointinfo.location;
        directionyaw = pointinfo.angles;
        wp_finishdeployment( mappoint, directionyaw, streakinfo );
        
        if ( mappointinfo.size > 1 && deployindex < mappointinfo.size - 1 )
        {
            wait randomfloatrange( 1, 3 );
        }
    }
}

// Namespace white_phosphorus
// Params 3
// Checksum 0x89b9799e, Offset: 0xaf2
// Size: 0xa2
function wp_finishdeployment( droplocation, dropdirection, streakinfo )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    thread wp_watchdisownaction( "disconnect" );
    thread wp_watchdisownaction( "joined_team" );
    thread wp_watchdisownaction( "joined_spectator" );
    hostmigration::waitlongdurationwithpause( 3 );
    deployplane = wp_createplane( droplocation, dropdirection, streakinfo );
    
    if ( !isdefined( deployplane ) )
    {
        assertmsg( "<dev string:x24>" );
        return 0;
    }
    
    deployplane thread wp_watchplanedisowned();
    deployplane thread wp_deliverpayloads( streakinfo );
}

// Namespace white_phosphorus
// Params 3
// Checksum 0xad62eab6, Offset: 0xb9c
// Size: 0x1e5
function wp_createplane( droppointorigin, planedirectionyaw, streakinfo )
{
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 28000;
    planeflyspeed = 5000;
    planeflyheight = 2500;
    var_52a7c56f48361b92 = 1500;
    planedirection = ( 0, planedirectionyaw, 0 );
    
    if ( !isdefined( heightent ) )
    {
        assertmsg( "<dev string:x7f>" );
        planeflyheight += 3000;
    }
    else
    {
        planeflyheight = heightent.origin[ 2 ] + 3000;
        var_52a7c56f48361b92 = airstrike::getexplodedistance( planeflyheight );
    }
    
    flightpath = airstrike::getflightpath( droppointorigin, planedirection, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_52a7c56f48361b92 );
    plane = spawn( "script_model", flightpath[ "startPoint" ] );
    plane.angles = planedirection;
    plane.flightpath = flightpath;
    plane.owner = self;
    plane.team = self.team;
    plane.streakinfo = streakinfo;
    plane.speed = planeflyspeed;
    planemodel = "veh9_mil_air_suniform25_mp";
    
    if ( player_utility::getplayersuperfaction( self ) )
    {
        planemodel = "veh9_mil_air_suniform25_mp";
    }
    
    plane setmodel( planemodel );
    plane.minimapid = plane objidpoolmanager::createobjective( "icon_minimap_wp", plane.team, 1, 1, 1 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        plane [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( plane.streakinfo.streakname, "Killstreak_Air", self );
    }
    
    return plane;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x77c54a52, Offset: 0xd8a
// Size: 0x49
function wp_watchdisownaction( action, deployplane )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    self waittill( action );
    level.wpinprogress = undefined;
    level notify( #"white_phosphorus_end" );
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x7e8bc416, Offset: 0xddb
// Size: 0x23
function wp_watchplanedisowned()
{
    self endon( #"death" );
    level waittill( #"white_phosphorus_end" );
    wp_removeplane( self );
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x6572681d, Offset: 0xe06
// Size: 0x6f
function wp_watchforsmokedisowned()
{
    self endon( #"death" );
    level waittill( #"white_phosphorus_end" );
    
    if ( wp_isactivewpzone( "smoke", self ) )
    {
        level wp_removefromactivewplist( "smoke", self );
        return;
    }
    
    var_9aff48f9929935f4 = 0;
    
    /#
        var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
    #/
    
    if ( var_9aff48f9929935f4 )
    {
        self freescriptable();
        return;
    }
    
    self delete();
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x9cedeb40, Offset: 0xe7d
// Size: 0xa1
function wp_watchforflaredisowned( effecttype )
{
    self endon( #"death" );
    level waittill( #"white_phosphorus_end" );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( wp_isactivewpzone( "inner", self ) )
    {
        level wp_removefromactivewplist( "inner", self, effecttype, 1 );
    }
    
    self notify( #"hash_cde2d0d0f082e3a8" );
    var_9aff48f9929935f4 = 0;
    
    /#
        var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
    #/
    
    if ( var_9aff48f9929935f4 )
    {
        self freescriptable();
        return;
    }
    
    self delete();
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x51f6a2a4, Offset: 0xf26
// Size: 0x21d
function wp_deliverpayloads( streakinfo )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    flightstart = self.flightpath[ "startPoint" ];
    flightgoal = self.flightpath[ "endPoint" ];
    flighttime = self.flightpath[ "flyTime" ];
    bombingstart = flightstart + anglestoforward( self.angles ) * 12500;
    bombingend = flightgoal - anglestoforward( self.angles ) * 12500;
    bombingdistance = length( bombingstart - bombingend );
    payloadlifetime = 30;
    
    /#
        payloadlifetime = getdvarint( @"scr_wp_lifetime", 30 );
        debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
        
        if ( debugpayload )
        {
            line( flightstart, flightgoal, ( 1, 1, 1 ), 1, 0, payloadlifetime * 30 );
        }
    #/
    
    self.owner thread wp_watchend( streakinfo, payloadlifetime );
    self.owner thread wp_watchgameend( streakinfo );
    self moveto( flightgoal, flighttime );
    self setscriptablepartstate( "bodyFX", "on", 0 );
    self scriptmodelplayanim( "mp_suniform25_flyin" );
    thread wp_enterpayloadaudio();
    thread wp_exitpayloadaudio( flightgoal, flighttime );
    var_f8265fbfbffd144d = 3;
    
    /#
        var_58eb84d60500161b = getdvarint( @"hash_51c63714caa01867", 0 );
        
        if ( var_58eb84d60500161b )
        {
            var_f8265fbfbffd144d = 1;
        }
    #/
    
    wp_handlepayloadtyperelease( &wp_fireairburst, flightstart, bombingstart, bombingdistance, payloadlifetime, 4000, var_f8265fbfbffd144d, 1 );
    wp_handlepayloadtyperelease( &wp_firesmoke, flightstart, bombingstart, bombingdistance, payloadlifetime, 4000, 3, 1 );
    wp_handlepayloadtyperelease( &wp_fireflaregroup, flightstart, bombingstart, bombingdistance, payloadlifetime, 2000, 6, 2 );
    hostmigration::waitlongdurationwithpause( flighttime );
    self stopsounds();
    self scriptmodelplayanimdeltamotion( "mp_suniform25_exit" );
    hostmigration::waitlongdurationwithpause( 5.33 );
    wp_removeplane( self );
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x6fdb0a1a, Offset: 0x114b
// Size: 0x57
function wp_watchend( streakinfo, payloadlifetime )
{
    self endon( #"disconnect" );
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( payloadlifetime );
    self notify( #"white_phosphorus_finished" );
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x5843658, Offset: 0x11aa
// Size: 0x7b
function wp_watchgameend( streakinfo )
{
    self endon( #"disconnect", #"white_phosphorus_finished" );
    level endon( #"white_phosphorus_end" );
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

// Namespace white_phosphorus
// Params 0
// Checksum 0x633de9fc, Offset: 0x122d
// Size: 0x26
function wp_enterpayloadaudio()
{
    self endon( #"death" );
    level endon( #"white_phosphorus_end" );
    waitframe();
    self playsoundonmovingent( "iw8_mp_white_phos_su25_flyby" );
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x363caefa, Offset: 0x125b
// Size: 0x42
function wp_exitpayloadaudio( flightgoal, flighttime )
{
    self endon( #"death" );
    level endon( #"white_phosphorus_end" );
    hostmigration::waitlongdurationwithpause( flighttime );
    playsoundatpos( flightgoal, "iw8_mp_white_phos_su25_exit" );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xbfe82b69, Offset: 0x12a5
// Size: 0x55
function wp_watchunsuccessfulzones( var_4bb3406dee025359 )
{
    level endon( #"hash_80082d72e3e620d3" );
    level endon( #"game_ended" );
    
    for ( var_c42eac94d0a2d4da = 0; var_c42eac94d0a2d4da < var_4bb3406dee025359 ; var_c42eac94d0a2d4da++ )
    {
        level waittill( #"hash_f93ba4f4d15243df" );
    }
    
    level.wpinprogress = undefined;
}

// Namespace white_phosphorus
// Params 8
// Checksum 0x2e5598f8, Offset: 0x1302
// Size: 0x1af
function wp_handlepayloadtyperelease( payloadreleasefunc, var_fdd30951256be3f8, var_25986a782a609694, var_2373cbdeb968eac3, payloadlifetime, var_d5023dd5bd54cf17, var_37722f9abd8dc9a5, var_d45710722ce26d1c )
{
    var_453db8d55ecf01d9 = int( var_2373cbdeb968eac3 / var_d5023dd5bd54cf17 );
    var_4244fd0573a27feb = 0;
    
    if ( !isdefined( var_37722f9abd8dc9a5 ) )
    {
        var_37722f9abd8dc9a5 = var_453db8d55ecf01d9;
    }
    else
    {
        payloaddiff = var_453db8d55ecf01d9 - var_37722f9abd8dc9a5;
        var_4244fd0573a27feb = int( payloaddiff / 2 );
    }
    
    if ( isdefined( var_d45710722ce26d1c ) )
    {
        var_4244fd0573a27feb += var_d45710722ce26d1c;
    }
    
    payloadforward = anglestoforward( self.angles );
    bombingpos = var_25986a782a609694;
    bombingcounter = 0;
    
    for ( i = 0; i < var_453db8d55ecf01d9 ; i++ )
    {
        var_25ecf9b44b2c66db = length( var_fdd30951256be3f8 - bombingpos ) / self.speed;
        
        if ( i < var_4244fd0573a27feb )
        {
            bombingpos += payloadforward * var_d5023dd5bd54cf17;
            continue;
        }
        
        payloadreleaseorigin = bombingpos - ( 0, 0, 2000 );
        
        if ( payloadreleasefunc == &wp_fireflaregroup )
        {
            killcament = spawn( "script_model", var_fdd30951256be3f8 + ( 0, 0, 1500 ) );
            killcament thread wp_movekillcam( var_25ecf9b44b2c66db, payloadreleaseorigin, payloadforward, payloadlifetime );
            self thread [[ payloadreleasefunc ]]( payloadreleaseorigin, payloadforward, var_25ecf9b44b2c66db, killcament );
        }
        else if ( payloadreleasefunc == &wp_firesmoke )
        {
            self thread [[ payloadreleasefunc ]]( payloadreleaseorigin, payloadforward, var_25ecf9b44b2c66db, i );
        }
        else
        {
            self thread [[ payloadreleasefunc ]]( payloadreleaseorigin, payloadforward, var_25ecf9b44b2c66db );
        }
        
        bombingpos += payloadforward * var_d5023dd5bd54cf17;
        bombingcounter++;
        
        if ( bombingcounter == var_37722f9abd8dc9a5 )
        {
            break;
        }
    }
}

// Namespace white_phosphorus
// Params 4
// Checksum 0x458e29f3, Offset: 0x14b9
// Size: 0x83
function wp_movekillcam( movetime, endpos, killcamforward, payloadlifetime )
{
    self endon( #"death" );
    endpos -= killcamforward * 3500;
    var_627e69dd497438a2 = endpos - killcamforward * 1000;
    self moveto( endpos, movetime + 3 );
    hostmigration::waitlongdurationwithpause( movetime + 2 );
    self moveto( var_627e69dd497438a2, 3 );
    hostmigration::waitlongdurationwithpause( payloadlifetime );
    self delete();
}

// Namespace white_phosphorus
// Params 3
// Checksum 0xd4b42bc2, Offset: 0x1544
// Size: 0xad
function wp_testpayloads( testpos, testangles, testdelaytime )
{
    self endon( #"death" );
    
    /#
        payloadlifetime = getdvarint( @"scr_wp_lifetime", 30 );
        debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
        
        if ( debugpayload )
        {
            sphere( testpos, 50, ( 1, 1, 1 ), 0, payloadlifetime * 30 );
            line( testpos, testpos - ( 0, 0, 5000 ), ( 1, 1, 1 ), 1, 0, payloadlifetime * 30 );
        }
    #/
}

// Namespace white_phosphorus
// Params 3
// Checksum 0x1b2e97d0, Offset: 0x15f9
// Size: 0xdd
function wp_fireairburst( airburstpos, airburstangles, airburstdelaytime )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    var_e7219b2ae8b945a0 = airburstpos - airburstangles * 3000;
    soundorigin = airburstpos - airburstangles * 2000;
    payloadlifetime = 30;
    
    /#
        payloadlifetime = getdvarint( @"scr_wp_lifetime", 30 );
        debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
        
        if ( debugpayload )
        {
            sphere( var_e7219b2ae8b945a0, 100, ( 0, 1, 1 ), 0, payloadlifetime * 30 );
        }
    #/
    
    hostmigration::waitlongdurationwithpause( airburstdelaytime );
    playfx( utility::getfx( "white_phosphorus_inair_explosion" ), var_e7219b2ae8b945a0, airburstangles );
    playsoundatpos( soundorigin, "iw8_mp_white_phos_midair_explo" );
}

// Namespace white_phosphorus
// Params 4
// Checksum 0x2ce79efc, Offset: 0x16de
// Size: 0x3d5
function wp_firesmoke( smokelaunchpos, var_822c2861261c63b8, smokedelaytime, smokezoneindex )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.playersininitialsmokerange ) )
    {
        self.playersininitialsmokerange = [];
    }
    
    if ( !isdefined( self.playersoutsideinitialsmokerange ) )
    {
        self.playersoutsideinitialsmokerange = [];
    }
    
    var_e2d8e8c08afe565d = 1;
    
    if ( game_utility::islargemap() && level.gametype != "arm" && level.gametype != "conflict" )
    {
        var_e2d8e8c08afe565d = 0;
    }
    
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"hash_2ed60ba038310c20" ) )
    {
        var_e2d8e8c08afe565d = [[ utility::getsharedfunc( #"white_phosphorus", #"hash_2ed60ba038310c20" ) ]]();
    }
    
    shottrace = trace::ray_trace( smokelaunchpos, smokelaunchpos - ( 0, 0, 10000 ) );
    var_9d55914a61599574 = shottrace[ "position" ];
    payloadlifetime = 30;
    
    /#
        payloadlifetime = getdvarint( @"scr_wp_lifetime", 30 );
        debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
        
        if ( debugpayload )
        {
            sphere( smokelaunchpos, 200, ( 1, 1, 0 ), 0, payloadlifetime * 30 );
        }
    #/
    
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"hash_193fb21151a6cb04" ) )
    {
        payloadlifetime = [[ utility::getsharedfunc( #"white_phosphorus", #"hash_193fb21151a6cb04" ) ]]();
    }
    
    hostmigration::waitlongdurationwithpause( smokedelaytime );
    var_9aff48f9929935f4 = 0;
    
    /#
        var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
    #/
    
    if ( utility::issharedfuncdefined( #"white_phosphorus", #"hash_ab8065c8a5c0bd07" ) )
    {
        var_9aff48f9929935f4 = [[ utility::getsharedfunc( #"white_phosphorus", #"hash_21e5040a4dcedc17" ) ]]();
    }
    
    if ( var_9aff48f9929935f4 )
    {
        var_ca692e4b190bae74 = spawnscriptable( "ks_white_phosphorus_mp_p", var_9d55914a61599574, self.angles );
    }
    else
    {
        var_ca692e4b190bae74 = spawn( "script_model", var_9d55914a61599574 );
        var_ca692e4b190bae74 setmodel( "ks_white_phosphorus_mp" );
        var_ca692e4b190bae74 setentityowner( self.owner );
    }
    
    var_ca692e4b190bae74.team = self.team;
    var_ca692e4b190bae74.owner = self.owner;
    var_ca692e4b190bae74.streakinfo = self.streakinfo;
    var_ca692e4b190bae74 thread wp_watchforsmokedisowned();
    hostmigration::waitlongdurationwithpause( 1 );
    level thread wp_playimpactsound( var_ca692e4b190bae74 );
    
    if ( var_e2d8e8c08afe565d )
    {
        var_ec7107b96ab6e4aa = smokezoneindex == 3;
        
        if ( var_ec7107b96ab6e4aa )
        {
            hostmigration::waitlongdurationwithpause( 3.5 );
            self.playersininitialsmokerange = utility::playersincylinder( var_9d55914a61599574, 2000 );
            self.playersoutsideinitialsmokerange = arrayremove( level.players, self.playersininitialsmokerange );
            var_ca692e4b190bae74 thread wp_watchdisorienteffect( 2000, self.playersininitialsmokerange, self.playersoutsideinitialsmokerange );
        }
    }
    else
    {
        if ( utility::isnightmap() )
        {
            var_ca692e4b190bae74 setscriptablepartstate( "smoke_night", "on", 0 );
        }
        else
        {
            var_ca692e4b190bae74 setscriptablepartstate( "smoke", "on", 0 );
        }
        
        hostmigration::waitlongdurationwithpause( 3.5 );
        var_ca692e4b190bae74 thread wp_watchdisorienteffect( 2000, var_e2d8e8c08afe565d );
        
        /#
            debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
            
            if ( debugpayload )
            {
                sphere( var_ca692e4b190bae74.origin, 2000, ( 1, 1, 0 ), 0, payloadlifetime * 24 );
            }
        #/
    }
    
    level wp_addtoactivewplist( "smoke", var_ca692e4b190bae74 );
    hostmigration::waitlongdurationwithpause( payloadlifetime );
    level wp_removefromactivewplist( "smoke", var_ca692e4b190bae74 );
}

// Namespace white_phosphorus
// Params 4
// Checksum 0x6af977fc, Offset: 0x1abb
// Size: 0x312
function wp_fireflaregroup( flarelaunchpos, var_efe949cacd37f4e1, flaredelaytime, killcament )
{
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    flareowner = self.owner;
    flareteam = self.team;
    flareangle = self.angles;
    shottrace = trace::ray_trace( flarelaunchpos, flarelaunchpos - ( 0, 0, 10000 ), self, undefined, 1, 1 );
    var_9d55914a61599574 = shottrace[ "position" ];
    shotsurface = shottrace[ "surfacetype" ];
    damageareaexists = isdefined( level.white_phosphorus_damage_area );
    
    if ( damageareaexists )
    {
        level.white_phosphorus_damage_area dontinterpolate();
        level.white_phosphorus_damage_area.owner = flareowner;
        level.white_phosphorus_damage_area.team = flareteam;
        level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
    }
    
    payloadlifetime = 30;
    
    /#
        payloadlifetime = getdvarint( @"scr_wp_lifetime", 30 );
    #/
    
    hostmigration::waitlongdurationwithpause( flaredelaytime );
    flarepositions = wp_getflarepositions( flarelaunchpos, var_9d55914a61599574, 4, int( 250 ) );
    
    foreach ( struct in flarepositions )
    {
        var_9aff48f9929935f4 = 0;
        
        /#
            var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
        #/
        
        if ( var_9aff48f9929935f4 )
        {
            flare = spawnscriptable( "ks_white_phosphorus_mp_p", struct.flareorigin, flareangle );
        }
        else
        {
            flare = spawn( "script_model", struct.flareorigin );
            flare setmodel( "ks_white_phosphorus_mp" );
            flare setentityowner( flareowner );
            flare.angles = flareangle;
        }
        
        flare.owner = flareowner;
        flare.team = flareteam;
        flare.streakinfo = self.streakinfo;
        flare.struct = struct;
        flare.weapon_name = "white_phosphorus_proj_mp";
        flare.killcament = killcament;
        flare thread wp_watchforflaredisowned( "burn" );
        flare thread wp_projwatchimpact( payloadlifetime, "burn", shotsurface );
        wait randomfloatrange( 0.1, 0.4 );
    }
    
    if ( damageareaexists )
    {
        level.white_phosphorus_damage_area.origin = ( 0, 0, 50000 );
    }
}

// Namespace white_phosphorus
// Params 4
// Checksum 0xb801dac0, Offset: 0x1dd5
// Size: 0x1c0
function wp_getflarepositions( launchpos, impactcenterpos, numpoints, var_256406bebf555607 )
{
    flarepoints = [];
    planeangles = self.angles * ( 0, 1, 0 );
    planeforward = anglestoforward( planeangles );
    planeright = anglestoright( planeangles );
    contents = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle" ];
    contentoverride = physics_createcontents( contents );
    var_f60242b77eb9b026 = -2000;
    var_ae13bdae79ff6941 = 0;
    
    for ( i = 0; i < numpoints ; i++ )
    {
        shotoffset = planeforward * var_f60242b77eb9b026 + planeright * var_ae13bdae79ff6941;
        var_fee83f4c3f3c4a18 = impactcenterpos + planeforward * var_f60242b77eb9b026;
        var_50dd93729b597e80 = impactcenterpos + shotoffset;
        flaretrace = trace::ray_trace( var_50dd93729b597e80 + ( 0, 0, launchpos[ 2 ] ), var_50dd93729b597e80 - ( 0, 0, 10000 ), level.characters, contentoverride );
        flareorigin = flaretrace[ "position" ];
        damageorigin = impactcenterpos * ( 1, 1, 0 ) + ( 0, 0, flareorigin[ 2 ] ) + planeforward * var_f60242b77eb9b026;
        flareinfo = spawnstruct();
        flareinfo.damageorigin = damageorigin;
        flareinfo.flareorigin = flareorigin;
        flarepoints[ flarepoints.size ] = flareinfo;
        var_f60242b77eb9b026 += 500;
        var_ae13bdae79ff6941 = randomintrange( -750, 750 );
    }
    
    return flarepoints;
}

// Namespace white_phosphorus
// Params 3
// Checksum 0x103dc9d8, Offset: 0x1f9e
// Size: 0x23e
function wp_projwatchimpact( payloadlifetime, effecttype, shotsurface )
{
    self endon( #"death" );
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 2.5 );
    self.projimpacted = 1;
    level wp_addtoactivewplist( "inner", self );
    self setscriptablepartstate( "impact", "on", 0 );
    
    if ( shotsurface == "surftype_water" )
    {
        self setscriptablepartstate( "flare_death_water", "on", 0 );
    }
    else
    {
        self setscriptablepartstate( "flare", "on", 0 );
    }
    
    damageradiuspos = self.struct.damageorigin + ( 0, 0, 10 );
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( damageradiuspos, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp" );
        
        /#
            debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
            
            if ( debugpayload )
            {
                sphere( damageradiuspos, 512, ( 1, 1, 0 ), 0, payloadlifetime * 30 );
            }
        #/
    }
    
    if ( isdefined( shotsurface ) && shotsurface != "surftype_water" )
    {
        if ( isdefined( effecttype ) )
        {
            self.killcament = spawn( "script_model", self.origin + ( 0, 0, 100 ) );
            
            if ( effecttype == "burn" )
            {
                thread wp_watchburneffect( 300 );
            }
            else
            {
                thread wp_watchblindeffect( 300 );
            }
            
            killstreak_utility::function_e6fc48237c0a5166( #"killstreak_white_phosphorus", self.origin, self.team, self.owner );
        }
        
        hostmigration::waitlongdurationwithpause( payloadlifetime );
        level wp_removefromactivewplist( "inner", self, effecttype, 1 );
        self notify( #"hash_cde2d0d0f082e3a8" );
        self setscriptablepartstate( "flare", "off", 0 );
        self setscriptablepartstate( "flare_death", "on", 0 );
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    thread wp_delayzonedelete( 15 );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xe54a996a, Offset: 0x21e4
// Size: 0x6d
function wp_delayzonedelete( timedelay )
{
    self endon( #"death" );
    level endon( #"white_phosphorus_end" );
    level endon( #"game_ended" );
    var_9aff48f9929935f4 = 0;
    
    /#
        var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
    #/
    
    hostmigration::waitlongdurationwithpause( timedelay );
    
    if ( var_9aff48f9929935f4 )
    {
        self freescriptable();
        return;
    }
    
    self delete();
}

// Namespace white_phosphorus
// Params 3
// Checksum 0x4141f2c8, Offset: 0x2259
// Size: 0x1e9
function wp_watchdisorienteffect( disorientradius, var_7aa96b357e8b6c05, var_8562f039bfeea63d )
{
    self endon( #"death" );
    self.playersindisorientradius = [];
    
    if ( isdefined( var_7aa96b357e8b6c05 ) && isdefined( var_8562f039bfeea63d ) )
    {
        thread wp_delaydisorientplayersinrange( 0.15, 2000, var_7aa96b357e8b6c05 );
        thread wp_delaydisorientplayersinrange( 0.25, undefined, var_8562f039bfeea63d );
        return;
    }
    
    while ( true )
    {
        var_d19187bb3daecab5 = utility::playersincylinder( self.origin, disorientradius );
        var_c93777cb294c828b = arrayremove( level.players, var_d19187bb3daecab5 );
        
        foreach ( player in var_d19187bb3daecab5 )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( !wp_isinwpzone( "smoke", player, self ) )
            {
                wp_addplayertostatusradiuslist( "smoke", player );
            }
            
            if ( !player.wpdisorient )
            {
                player thread wp_startdisorientplayer( self );
            }
        }
        
        foreach ( player in var_c93777cb294c828b )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player.wpdisorient && wp_isinwpzone( "smoke", player, self ) )
            {
                player thread wp_stopdisorientplayer( self );
            }
        }
        
        waitframe();
    }
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x5a35f911, Offset: 0x244a
// Size: 0xb2
function wp_getplayerswithinrange( playerstocheck, range )
{
    playersinrange = [];
    
    foreach ( player in playerstocheck )
    {
        if ( distance2dsquared( self.origin, player.origin ) <= range * range )
        {
            playersinrange[ playersinrange.size ] = player;
        }
    }
    
    return playersinrange;
}

// Namespace white_phosphorus
// Params 3
// Checksum 0xc1f70ee5, Offset: 0x2505
// Size: 0xfd
function wp_delaydisorientplayersinrange( delaytime, range, initialtargetarray )
{
    self endon( #"death" );
    
    if ( delaytime > 0 )
    {
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    targetsinrange = initialtargetarray;
    
    if ( range > 0 )
    {
        targetsinrange = wp_getplayerswithinrange( initialtargetarray, range );
    }
    
    foreach ( player in targetsinrange )
    {
        if ( player player::isreallyalive() )
        {
            wp_addplayertostatusradiuslist( "smoke", player );
            
            if ( !player.wpdisorient )
            {
                player thread wp_startdisorientplayer( self );
            }
        }
        
        player thread wp_startdisorientplayeronspawn( self );
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x991eead5, Offset: 0x260a
// Size: 0x14c
function wp_watchburneffect( burnradius )
{
    self endon( #"hash_cde2d0d0f082e3a8" );
    self endon( #"death" );
    self.playersininnerradius = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( distance2d( self.origin, player.origin ) <= burnradius && trace::ray_trace_passed( player geteye(), self.origin + ( 0, 0, 30 ), player ) )
            {
                if ( !player.wpburning )
                {
                    player thread wp_startburnplayer( self, self.owner );
                }
                
                continue;
            }
            
            if ( player.wpburning && wp_isinwpzone( "inner", player, self ) )
            {
                player wp_stopburnplayer( self );
            }
        }
        
        waitframe();
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x2c71f4e7, Offset: 0x275e
// Size: 0x143
function wp_watchblindeffect( blindradius )
{
    self endon( #"hash_cde2d0d0f082e3a8" );
    self endon( #"death" );
    self.playersininnerradius = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( distance2d( self.origin, player.origin ) <= blindradius && trace::ray_trace_passed( player geteye(), self.origin + ( 0, 0, 30 ), player ) )
            {
                if ( !player.wpblinding )
                {
                    player wp_startblindplayer( self );
                }
                
                continue;
            }
            
            if ( player.wpblinding && wp_isinwpzone( "inner", player, self ) )
            {
                player wp_stopblindplayer( self );
            }
        }
        
        waitframe();
    }
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x505cfbd5, Offset: 0x28a9
// Size: 0x51
function wp_addtoactivewplist( type, var_b0c62706bc87dc55 )
{
    if ( type == "smoke" )
    {
        level.activewpzones[ level.activewpzones.size ] = var_b0c62706bc87dc55;
        return;
    }
    
    level.activewpinnerzones[ level.activewpinnerzones.size ] = var_b0c62706bc87dc55;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0xf327621d, Offset: 0x2902
// Size: 0x122
function wp_isactivewpzone( type, var_aba0e88e24d68526 )
{
    isactivezone = 0;
    
    if ( type == "smoke" )
    {
        foreach ( zone in level.activewpzones )
        {
            if ( zone == var_aba0e88e24d68526 )
            {
                isactivezone = 1;
                break;
            }
        }
    }
    else
    {
        foreach ( zone in level.activewpinnerzones )
        {
            if ( zone == var_aba0e88e24d68526 )
            {
                isactivezone = 1;
                break;
            }
        }
    }
    
    return isactivezone;
}

// Namespace white_phosphorus
// Params 4
// Checksum 0xd1c85eaa, Offset: 0x2a2d
// Size: 0x2fb
function wp_removefromactivewplist( type, var_9ffa124700b46742, subeffecttype, dontdelete )
{
    if ( !isdefined( var_9ffa124700b46742 ) )
    {
        return;
    }
    
    newlist = [];
    
    if ( type == "smoke" )
    {
        foreach ( wpzone in level.activewpzones )
        {
            if ( wpzone == var_9ffa124700b46742 )
            {
                continue;
            }
            
            newlist[ newlist.size ] = wpzone;
        }
        
        level.activewpzones = newlist;
        
        if ( isdefined( var_9ffa124700b46742.playersindisorientradius ) )
        {
            foreach ( player in var_9ffa124700b46742.playersindisorientradius )
            {
                if ( isdefined( player ) && !wp_isinanywpzone( "smoke", player ) )
                {
                    player thread wp_stopdisorientplayer( var_9ffa124700b46742 );
                }
            }
        }
        
        if ( level.activewpzones.size <= 0 )
        {
            level.wpinprogress = undefined;
        }
    }
    else
    {
        foreach ( wpzone in level.activewpinnerzones )
        {
            if ( wpzone == var_9ffa124700b46742 )
            {
                continue;
            }
            
            newlist[ newlist.size ] = wpzone;
        }
        
        level.activewpinnerzones = newlist;
        
        if ( isdefined( var_9ffa124700b46742.playersininnerradius ) )
        {
            foreach ( player in var_9ffa124700b46742.playersininnerradius )
            {
                if ( isdefined( player ) && !wp_isinanywpzone( "inner", player ) )
                {
                    if ( subeffecttype == "burn" )
                    {
                        player thread wp_stopburnplayer( var_9ffa124700b46742 );
                        continue;
                    }
                    
                    player thread wp_stopblindplayer( var_9ffa124700b46742 );
                }
            }
        }
    }
    
    if ( dontdelete )
    {
        return;
    }
    
    var_9aff48f9929935f4 = 0;
    
    /#
        var_9aff48f9929935f4 = getdvarint( @"hash_1aff95d5bc69c60f", 0 );
    #/
    
    if ( var_9aff48f9929935f4 )
    {
        var_9ffa124700b46742 freescriptable();
        return;
    }
    
    var_9ffa124700b46742 delete();
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x992d71ca, Offset: 0x2d30
// Size: 0x12e
function wp_isinanywpzone( type, var_5b415c263e1d902 )
{
    var_5321f37c2266baa3 = 0;
    
    if ( type == "smoke" )
    {
        foreach ( wpzone in level.activewpzones )
        {
            if ( wp_isinwpzone( type, var_5b415c263e1d902, wpzone ) )
            {
                var_5321f37c2266baa3 = 1;
                break;
            }
        }
    }
    else
    {
        foreach ( wpzone in level.activewpinnerzones )
        {
            if ( wp_isinwpzone( type, var_5b415c263e1d902, wpzone ) )
            {
                var_5321f37c2266baa3 = 1;
                break;
            }
        }
    }
    
    return var_5321f37c2266baa3;
}

// Namespace white_phosphorus
// Params 3
// Checksum 0xf057e3c2, Offset: 0x2e67
// Size: 0xdb
function wp_isinwpzone( type, var_5b415c263e1d902, wpzone )
{
    isinzone = 0;
    var_4ac072e904324493 = undefined;
    
    if ( type == "smoke" )
    {
        var_4ac072e904324493 = wpzone.playersindisorientradius;
    }
    else
    {
        var_4ac072e904324493 = wpzone.playersininnerradius;
    }
    
    if ( isdefined( var_4ac072e904324493 ) )
    {
        foreach ( player in var_4ac072e904324493 )
        {
            if ( player == var_5b415c263e1d902 )
            {
                isinzone = 1;
                break;
            }
        }
    }
    
    return isinzone;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0xff04888a, Offset: 0x2f4b
// Size: 0x51
function wp_addplayertostatusradiuslist( type, playertoadd )
{
    if ( type == "smoke" )
    {
        self.playersindisorientradius[ self.playersindisorientradius.size ] = playertoadd;
        return;
    }
    
    self.playersininnerradius[ self.playersininnerradius.size ] = playertoadd;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x3793e2fe, Offset: 0x2fa4
// Size: 0x13f
function wp_removeplayerfromstatusradiuslist( type, var_b1c4a8fbb5b20426 )
{
    if ( type == "smoke" )
    {
        newlist = [];
        
        foreach ( player in self.playersindisorientradius )
        {
            if ( player == var_b1c4a8fbb5b20426 )
            {
                continue;
            }
            
            newlist[ newlist.size ] = player;
        }
        
        self.playersindisorientradius = newlist;
        return;
    }
    
    newlist = [];
    
    foreach ( player in self.playersininnerradius )
    {
        if ( player == var_b1c4a8fbb5b20426 )
        {
            continue;
        }
        
        newlist[ newlist.size ] = player;
    }
    
    self.playersininnerradius = newlist;
}

// Namespace white_phosphorus
// Params 2
// Checksum 0xc3777c75, Offset: 0x30eb
// Size: 0x129
function wp_removeplayerfromallstatusradiuslists( type, var_b1c4a8fbb5b20426 )
{
    if ( type == "smoke" )
    {
        foreach ( wpzone in level.activewpzones )
        {
            if ( wp_isinwpzone( type, var_b1c4a8fbb5b20426, wpzone ) )
            {
                wpzone wp_removeplayerfromstatusradiuslist( type, var_b1c4a8fbb5b20426 );
            }
        }
        
        return;
    }
    
    foreach ( wpzone in level.activewpinnerzones )
    {
        if ( wp_isinwpzone( type, var_b1c4a8fbb5b20426, wpzone ) )
        {
            wpzone wp_removeplayerfromstatusradiuslist( type, var_b1c4a8fbb5b20426 );
        }
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x9446872a, Offset: 0x321c
// Size: 0x5e
function wp_startdisorientplayeronspawn( wpzone )
{
    wpzone endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        hostmigration::waitlongdurationwithpause( 0.1 );
        wpzone wp_addplayertostatusradiuslist( "smoke", self );
        thread wp_startdisorientplayer( wpzone );
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x4df492ff, Offset: 0x3282
// Size: 0x155
function wp_startdisorientplayer( wpzone )
{
    wpzone endon( #"death" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_disorient" );
    level endon( #"game_ended" );
    self.wpdisorient = 1;
    
    while ( isdefined( self.sessionstate ) && self.sessionstate != "playing" )
    {
        waitframe();
    }
    
    thread wp_stopdisorientonplayerdeath( wpzone );
    thread wp_monitorsmokevisionset( wpzone );
    playfxontagforclients( utility::getfx( "white_phosphorus_screen" ), self, "tag_eye", self );
    
    if ( level.teambased && self.team == wpzone.team || self == wpzone.owner )
    {
        skipplayer = 1;
        
        /#
            debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
            
            if ( debugpayload )
            {
                skipplayer = 0;
            }
        #/
        
        if ( skipplayer )
        {
            return;
        }
    }
    
    self.wphealthblock = 1;
    perk::giveperk( "specialty_block_health_regen" );
    
    if ( self.health > 10 )
    {
        healthdebuffamount = wp_gethealthdebuffamount();
        wp_degenhealth( healthdebuffamount, wpzone );
    }
    
    if ( !wp_hasresistperk() )
    {
        enableloopingcoughaudio( wpzone );
    }
}

// Namespace white_phosphorus
// Params 2
// Checksum 0xc23806e2, Offset: 0x33df
// Size: 0x6f
function wp_degenhealth( var_ea7d1088c1925603, wpzone )
{
    if ( self.gasmaskequipped )
    {
        return;
    }
    
    if ( !isdefined( self.wphealthblock ) )
    {
        self.wphealthblock = 1;
        perk::giveperk( "specialty_block_health_regen" );
    }
    
    self dodamage( var_ea7d1088c1925603, self.origin, wpzone.owner, wpzone, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp" );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xe285a9a1, Offset: 0x3456
// Size: 0x49
function wp_startdofshiftforplayer( wpzone )
{
    wpzone endon( #"death" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self.wpdisorient )
    {
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xfa2eb579, Offset: 0x34a7
// Size: 0x49
function wp_stopdisorientonplayerdeath( wpzone )
{
    wpzone endon( #"death" );
    self endon( #"stop_disorient" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    wp_stopdisorientplayer( wpzone, 1 );
}

// Namespace white_phosphorus
// Params 2
// Checksum 0x13bd328f, Offset: 0x34f8
// Size: 0x104
function wp_stopdisorientplayer( wpzone, var_a7f2af35663d7c1c )
{
    level endon( #"game_ended" );
    
    if ( var_a7f2af35663d7c1c )
    {
        level wp_removeplayerfromallstatusradiuslists( "smoke", self );
    }
    else
    {
        wpzone wp_removeplayerfromstatusradiuslist( "smoke", self );
    }
    
    if ( !wp_isinanywpzone( "smoke", self ) || var_a7f2af35663d7c1c )
    {
        if ( self.wpdisorient )
        {
            self.wpdisorient = undefined;
            
            if ( player::isreallyalive() )
            {
                self visionsetnakedforplayer( "", 2 );
            }
            
            stopfxontagforclients( utility::getfx( "white_phosphorus_screen" ), self, "tag_eye", self );
            
            if ( self.wphealthblock )
            {
                if ( utility::issharedfuncdefined( #"perk", #"removeperk" ) )
                {
                    self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( "specialty_block_health_regen" );
                }
                
                self.wphealthblock = undefined;
            }
            
            disableloopingcoughaudio();
            self notify( #"stop_disorient" );
        }
    }
}

// Namespace white_phosphorus
// Params 2
// Checksum 0xe2faca15, Offset: 0x3604
// Size: 0x1c8
function wp_startburnplayer( wpzone, attacker )
{
    wpzone endon( #"death" );
    self endon( #"hash_5d8919bdae473963" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( level.teambased && self.team == wpzone.team && self != wpzone.owner )
    {
        skipplayer = 1;
        
        /#
            debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
            
            if ( debugpayload )
            {
                skipplayer = 0;
            }
        #/
        
        if ( skipplayer )
        {
            return;
        }
    }
    
    wpzone wp_addplayertostatusradiuslist( "inner", self );
    self.wpburning = 1;
    
    if ( utility::issharedfuncdefined( #"weapons", #"hash_ab76b187280ae421" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"hash_ab76b187280ae421" ) ]]( undefined, "wp_active" );
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"enqueuecorpsetablefunc" ) )
    {
        [[ utility::getsharedfunc( #"damage", #"enqueuecorpsetablefunc" ) ]]( "white_phosphorus_burning", &wp_playcorpsetableburningfx );
    }
    
    thread wp_stopstatuseffectondeath( wpzone );
    damage = 10;
    
    while ( true )
    {
        if ( self.health <= damage )
        {
            self notify( #"hash_fc3d611a26ecd601" );
        }
        
        self dodamage( damage, self.origin, attacker, wpzone, "MOD_FIRE", wpzone.weapon_name );
        wait 0.5;
        damage++;
        
        if ( damage >= 20 )
        {
            damage = 20;
        }
        
        self.lastburntime = gettime();
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x3812d661, Offset: 0x37d4
// Size: 0x3e
function wp_stopburnplayer( wpzone )
{
    wpzone wp_removeplayerfromstatusradiuslist( "inner", self );
    
    if ( !wp_isinanywpzone( "inner", self ) )
    {
        wp_resetstatuseffect();
        self notify( #"hash_5d8919bdae473963" );
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x1a950ba2, Offset: 0x381a
// Size: 0xa9
function wp_startblindplayer( wpzone )
{
    if ( level.teambased && self.team == wpzone.team || self == wpzone.owner )
    {
        skipplayer = 1;
        
        /#
            debugpayload = getdvarint( @"hash_b72a0bb47130fb8e", 0 );
            
            if ( debugpayload )
            {
                skipplayer = 0;
            }
        #/
        
        if ( skipplayer )
        {
            return;
        }
    }
    
    wpzone wp_addplayertostatusradiuslist( "inner", self );
    self.wpblinding = 1;
    thread wp_stopstatuseffectondeath( wpzone );
    self visionsetnakedforplayer( "wp_flare", 1 );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xc81d7289, Offset: 0x38cb
// Size: 0x32
function wp_stopblindplayer( wpzone )
{
    wpzone wp_removeplayerfromstatusradiuslist( "inner", self );
    
    if ( !wp_isinanywpzone( "inner", self ) )
    {
        wp_resetstatuseffect();
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xd23420d8, Offset: 0x3905
// Size: 0x47
function wp_stopstatuseffectondeath( wpzone )
{
    wpzone endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    wp_resetstatuseffect( 1 );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xef5f1615, Offset: 0x3954
// Size: 0xfa
function wp_resetstatuseffect( var_da3992464725f7c8 )
{
    if ( self.wpburning )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"hash_7d3fa27f0a2ead54" ) )
        {
            self [[ utility::getsharedfunc( #"weapons", #"hash_7d3fa27f0a2ead54" ) ]]( undefined, "wp_active" );
        }
        
        if ( player::isreallyalive() )
        {
            if ( utility::issharedfuncdefined( #"damage", #"dequeuecorpsetablefunc" ) )
            {
                self [[ utility::getsharedfunc( #"damage", #"dequeuecorpsetablefunc" ) ]]( "white_phosphorus_burning" );
            }
        }
        
        self.wpburning = undefined;
    }
    
    if ( self.wpblinding )
    {
        self.wpblinding = undefined;
        
        if ( wp_isinanywpzone( "smoke", self ) )
        {
            self visionsetnakedforplayer( wp_getsmokevisionset(), 1 );
        }
        else
        {
            self visionsetnakedforplayer( "", 1 );
        }
    }
    
    if ( var_da3992464725f7c8 )
    {
        level wp_removeplayerfromallstatusradiuslists( "inner", self );
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xececf282, Offset: 0x3a56
// Size: 0x7e
function wp_removeplane( plane )
{
    assert( isdefined( plane ), "<dev string:xb2>" );
    
    if ( isdefined( plane.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( plane.minimapid );
        }
        
        plane.minimapid = undefined;
    }
    
    plane delete();
}

// Namespace white_phosphorus
// Params 0
// Checksum 0xc4dcc3d, Offset: 0x3adc
// Size: 0x3d
function wp_getsmokevisionset()
{
    dayvisionset = "wp_smoke";
    nightvisionset = "wp_smoke_night";
    smokevisionset = dayvisionset;
    
    if ( utility::isnightmap() )
    {
        smokevisionset = nightvisionset;
    }
    
    return smokevisionset;
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xfee09043, Offset: 0x3b22
// Size: 0x90
function wp_monitorsmokevisionset( wpzone )
{
    wpzone endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"stop_disorient" );
    self endon( #"death" );
    level endon( #"game_ended" );
    prevvision = undefined;
    
    while ( true )
    {
        if ( self.wpdisorient )
        {
            currentvision = wp_getsmokevisionset();
            
            if ( currentvision != prevvision )
            {
                prevvision = currentvision;
                self visionsetnakedforplayer( currentvision, 2 );
            }
        }
        
        waitframe();
    }
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x29b74467, Offset: 0x3bba
// Size: 0x58
function wp_gethealthdebuffamount()
{
    healthdebuffamount = 50;
    
    if ( wp_hasresistperk() )
    {
        healthdebuffamount *= 0.5;
    }
    
    targethealth = self.health;
    var_1a67fb62d9099608 = targethealth - healthdebuffamount;
    
    if ( var_1a67fb62d9099608 < 10 )
    {
        healthdebuffamount -= 10 - var_1a67fb62d9099608;
    }
    
    return healthdebuffamount;
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x5d59a638, Offset: 0x3c1b
// Size: 0x1e
function wp_playcorpsetableburningfx( corpsetable )
{
    corpsetable setscriptablepartstate( "wp_burning", "flareUp", 0 );
}

// Namespace white_phosphorus
// Params 0
// Checksum 0xc33a94d9, Offset: 0x3c41
// Size: 0x12, Type: bool
function wp_hasresistperk()
{
    return isdefined( self.perks[ "specialty_tac_resist" ] );
}

// Namespace white_phosphorus
// Params 1
// Checksum 0x32b0ff0, Offset: 0x3c5c
// Size: 0x44
function enableloopingcoughaudio( wpzone )
{
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        self.loopingcoughaudio = 0;
    }
    
    self.loopingcoughaudio++;
    
    if ( self.loopingcoughaudio == 1 )
    {
        thread startloopingcoughaudio( wpzone );
    }
}

// Namespace white_phosphorus
// Params 0
// Checksum 0xb7272aa7, Offset: 0x3ca8
// Size: 0x52
function disableloopingcoughaudio()
{
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        return;
    }
    
    self.loopingcoughaudio--;
    assert( self.loopingcoughaudio >= 0, "<dev string:xfd>" );
    
    if ( self.loopingcoughaudio == 0 )
    {
        thread stoploopingcoughaudio();
        self.loopingcoughaudio = undefined;
    }
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xa9e588f7, Offset: 0x3d02
// Size: 0x29c
function startloopingcoughaudio( wpzone )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9d76019069d13f3c" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waittime = randomfloatrange( 5, 7 );
        
        if ( !loopingcoughaudioissupressed() )
        {
            soundalias = "generic_cough_3_enemy_1";
            
            if ( isdefined( self.operatorcustomization ) )
            {
                if ( isdefined( wpzone ) )
                {
                    zoneteam = wpzone.team;
                }
                else
                {
                    zoneteam = "allies";
                }
                
                if ( self.team == zoneteam )
                {
                    if ( operator::isfemale() )
                    {
                        cough_amount = game[ "dialogue" ][ "allies_female_cough" ].size;
                        current_cough = randomint( cough_amount );
                        soundalias = game[ "dialogue" ][ "allies_female_cough" ][ current_cough ];
                    }
                    else
                    {
                        cough_amount = game[ "dialogue" ][ "allies_male_cough" ].size;
                        current_cough = randomint( cough_amount );
                        soundalias = game[ "dialogue" ][ "allies_male_cough" ][ current_cough ];
                    }
                }
                else if ( operator::isfemale() )
                {
                    cough_amount = game[ "dialogue" ][ "axis_female_cough" ].size;
                    current_cough = randomint( cough_amount );
                    soundalias = game[ "dialogue" ][ "axis_female_cough" ][ current_cough ];
                }
                else
                {
                    cough_amount = game[ "dialogue" ][ "axis_male_cough" ].size;
                    current_cough = randomint( cough_amount );
                    soundalias = game[ "dialogue" ][ "axis_male_cough" ][ current_cough ];
                }
            }
            else
            {
                cough_amount = game[ "dialogue" ][ "axis_male_cough" ].size;
                current_cough = randomint( cough_amount );
                soundalias = game[ "dialogue" ][ "axis_male_cough" ][ current_cough ];
            }
            
            if ( !isai( self ) )
            {
                self playlocalsound( "gas_player_cough" );
            }
            
            if ( utility::ismp() && game_utility::getgametype() != "ob" )
            {
                enemyteams = arrayremove( level.teamnamelist, self.team );
                self playsoundtoteam( soundalias, self.team, self, self );
                self playsoundtoteam( soundalias, enemyteams[ 0 ], self, self );
                
                if ( isdefined( enemyteams[ 1 ] ) )
                {
                    self playsoundtoteam( soundalias, enemyteams[ 1 ], self, self );
                }
            }
            else if ( game_utility::getgametype() == "ob" )
            {
                if ( isplayer( self ) )
                {
                    enemyteams = arrayremove( level.teamnamelist, self.team );
                    self playsoundtoteam( soundalias, self.team, self, self );
                    
                    if ( isdefined( enemyteams[ 0 ] ) )
                    {
                        self playsoundtoteam( soundalias, enemyteams[ 0 ], self, self );
                    }
                }
                else
                {
                    self playsoundonmovingent( soundalias );
                }
            }
            
            wait waittime;
            continue;
        }
        
        wait 1;
    }
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x6bcd5f27, Offset: 0x3fa6
// Size: 0xe
function stoploopingcoughaudio()
{
    self notify( #"hash_9d76019069d13f3c" );
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x36d54248, Offset: 0x3fbc
// Size: 0x22
function enableloopingcoughaudiosupression()
{
    if ( !isdefined( self.loopingcoughaudiosupression ) )
    {
        self.loopingcoughaudiosupression = 0;
    }
    
    self.loopingcoughaudiosupression++;
}

// Namespace white_phosphorus
// Params 0
// Checksum 0xd34856a2, Offset: 0x3fe6
// Size: 0x33
function disableloopingcoughaudiosupression()
{
    if ( !isdefined( self.loopingcoughaudiosupression ) )
    {
        return;
    }
    
    self.loopingcoughaudiosupression--;
    assert( self.loopingcoughaudiosupression >= 0, "<dev string:x146>" );
}

// Namespace white_phosphorus
// Params 0
// Checksum 0x6a7b0a29, Offset: 0x4021
// Size: 0xd, Type: bool
function loopingcoughaudioissupressed()
{
    return self.loopingcoughaudiosupression > 0;
}

// Namespace white_phosphorus
// Params 0
// Checksum 0xf7d6b54d, Offset: 0x4037
// Size: 0x22
function clearloopingcoughaudio()
{
    self notify( #"hash_9d76019069d13f3c" );
    self.loopingcoughaudio = undefined;
    self.loopingcoughaudiosupression = undefined;
}

// Namespace white_phosphorus
// Params 1
// Checksum 0xfa52948e, Offset: 0x4061
// Size: 0x31
function wp_playimpactsound( var_ca692e4b190bae74 )
{
    var_ca692e4b190bae74 setscriptablepartstate( "impact_center", "on", 0 );
    waitframe();
    var_ca692e4b190bae74 setscriptablepartstate( "impact_center", "off", 0 );
}

