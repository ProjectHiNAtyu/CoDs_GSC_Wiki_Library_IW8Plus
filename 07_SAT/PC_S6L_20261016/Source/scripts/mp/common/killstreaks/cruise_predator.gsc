// scripts\mp\common\killstreaks\cruise_predator.gsc  (hash_50ef91777fbaecc3.gscc) (size: 19383 Bytes / 0x4bb7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc9d72ba (3164435130)
// size ...... 19383 (0x4bb7)
// includes .. 15  (offset: 0x45d7)
// strings ... 83  (offset: 0x464f)
// dev strs .. 4   (offset: 0x4b6b)
// exports ... 38  (offset: 0x2d1f)
// cseg ...... 0x5fc + 0x2723 (0x2d1f)
// imports ... 149 (offset: 0x330f)
// animtree1 . 0   (offset: 0x4b9b)
// animtree2 . 1   (offset: 0x4b9b)
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace cruise_predator;

// Namespace cruise_predator
// Params 0
// Checksum 0xb06ab3ae, Offset: 0x61a
// Size: 0x68
function init()
{
    if ( utility::issharedfuncdefined( #"cruise_predator", #"init" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"init" ) ]]();
    }
    
    level function_f68dafac0128d99f();
    level function_cfa206e3a66d542d();
    level init_cruisepredator_anims();
    level init_cruisepredator_vo();
    level init_cruisepredator_fx();
    level function_68ca5134d10dad17();
}

// Namespace cruise_predator
// Params 0
// Checksum 0x9c9b64ef, Offset: 0x68a
// Size: 0x28
function function_f68dafac0128d99f()
{
    killstreak_utility::registervisibilityomnvarforkillstreak( "cruise_predator", "invisible", 7 );
    killstreak_utility::registervisibilityomnvarforkillstreak( "cruise_predator", "on", 8 );
}

// Namespace cruise_predator
// Params 0
// Checksum 0x11be2979, Offset: 0x6ba
// Size: 0x60
function function_cfa206e3a66d542d()
{
    val::group_register( "cruisePredator", [ "allow_movement", "allow_jump", "fire", "weapon_switch", "melee", "usability", "shellshock", "offhand_weapons", "killstreaks" ] );
}

// Namespace cruise_predator
// Params 0
// Checksum 0xb67fb0b6, Offset: 0x722
// Size: 0x2
function init_cruisepredator_anims()
{
    
}

// Namespace cruise_predator
// Params 0
// Checksum 0xcb55e963, Offset: 0x72c
// Size: 0x38
function init_cruisepredator_vo()
{
    if ( utility::issharedfuncdefined( #"cruise_predator", #"registervo" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"registervo" ) ]]();
    }
}

// Namespace cruise_predator
// Params 0
// Checksum 0xc5eb0167, Offset: 0x76c
// Size: 0x1b
function init_cruisepredator_fx()
{
    level._effect[ "predator_pod_break" ] = loadfxasset( "vfx_iw8_mp_strk_cruise_predator_explo" );
}

// Namespace cruise_predator
// Params 0
// Checksum 0xd9778edb, Offset: 0x78f
// Size: 0x59
function function_68ca5134d10dad17()
{
    if ( isdefined( level.cruisepredatorvisionset ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.cruisepredatorvisionset );
    }
    
    killstreak_shared::function_28d986de72ce85f8( "cruise_color_mp" );
    killstreak_shared::function_28d986de72ce85f8( "cruise_color_fog_mp" );
    killstreak_shared::function_28d986de72ce85f8( "cruise_intro_shipment" );
    killstreak_shared::function_28d986de72ce85f8( level.mapname + "_cruise_intro" );
}

// Namespace cruise_predator
// Params 1
// Checksum 0xe8436e99, Offset: 0x7f0
// Size: 0xe, Type: bool
function weapongivencruisepredator( streakinfo )
{
    return true;
}

// Namespace cruise_predator
// Params 0
// Checksum 0xb71ec8e7, Offset: 0x807
// Size: 0x22
function tryusecruisepredator()
{
    streakinfo = killstreak_utility::createstreakinfo( "cruise_predator", self );
    return tryusecruisepredatorfromstruct( streakinfo );
}

// Namespace cruise_predator
// Params 1
// Checksum 0x2757bae0, Offset: 0x832
// Size: 0x119, Type: bool
function tryusecruisepredatorfromstruct( streakinfo )
{
    self notify( #"using_remote" );
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, &weapongivencruisepredator );
    
    if ( !deployresult )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    thirdperson = getdvarint( @"hash_b3b0df534800e4d5", 0 );
    
    /#
        if ( thirdperson )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        }
    #/
    
    result = runcruisepredator( streakinfo.streakname, streakinfo, thirdperson );
    
    if ( !result )
    {
        return false;
    }
    
    return true;
}

// Namespace cruise_predator
// Params 1, eflags: 0x4
// Checksum 0xd15b3271, Offset: 0x954
// Size: 0xe2
function private function_ce7d398a450168c( bundle )
{
    if ( !isdefined( bundle.cruisepredatorspawnplayer ) )
    {
        bundle.cruisepredatorspawnplayer = 0;
    }
    
    if ( !isdefined( bundle.cruisepredatorlifetime ) )
    {
        bundle.cruisepredatorlifetime = 10;
    }
    
    if ( !isdefined( bundle.var_534827da12f0f063 ) )
    {
        bundle.var_534827da12f0f063 = 10000;
    }
    
    if ( !isdefined( bundle.var_e6c52591cd2d2661 ) )
    {
        bundle.var_e6c52591cd2d2661 = 4500;
    }
    
    if ( !isdefined( bundle.cruisepredatordamageradius ) )
    {
        bundle.cruisepredatordamageradius = 600;
    }
    
    if ( !isdefined( bundle.var_4fab50522e477d39 ) )
    {
        bundle.var_4fab50522e477d39 = 700;
    }
    
    if ( !isdefined( bundle.var_4f8762522e1f2a17 ) )
    {
        bundle.var_4f8762522e1f2a17 = 1100;
    }
    
    bundle.initialized = 1;
}

// Namespace cruise_predator
// Params 3
// Checksum 0xa6b1801d, Offset: 0xa3e
// Size: 0x473
function runcruisepredator( streakname, streakinfo, thirdperson )
{
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo );
    }
    
    bundle = level.streakglobals.streakbundles[ "cruise_predator" ];
    
    if ( !bundle.initialized )
    {
        function_ce7d398a450168c( bundle );
    }
    
    self disablephysicaldepthoffieldscripting();
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = bundle.var_534827da12f0f063;
    
    if ( isdefined( heightent ) )
    {
        heightoffset = heightent.origin[ 2 ] + bundle.var_e6c52591cd2d2661;
    }
    
    spawncenterpos = level.mapcenter;
    var_edb1211e4cb558ba = getdvarint( @"hash_a2e7d8fdf5d91dd9", bundle.cruisepredatorspawnplayer );
    
    if ( game_utility::islargemap() || var_edb1211e4cb558ba )
    {
        spawncenterpos = self.origin;
    }
    
    allenemies = [];
    sumvectors = ( 0, 0, 0 );
    forwardvector = undefined;
    character_array = level.players;
    
    foreach ( player in character_array )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( level.teambased && player.team == self.team )
        {
            continue;
        }
        
        sumvectors += player.origin - spawncenterpos;
        allenemies[ allenemies.size ] = player;
    }
    
    if ( isdefined( sumvectors ) && allenemies.size > 0 )
    {
        forwardvector = vectornormalize( sumvectors / allenemies.size );
        forwardvector *= ( 1, 1, 0 );
    }
    else
    {
        randy = randomint( 360 );
        forwardvector = anglestoforward( ( 0, randy, 0 ) );
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"directionoverride" ) )
    {
        forwardvector = self [[ utility::getsharedfunc( #"cruise_predator", #"directionoverride" ) ]]( forwardvector );
    }
    
    missileoffset = spawncenterpos + ( 0, 0, heightoffset );
    startpos = missileoffset - forwardvector * 3000;
    targetpos = spawncenterpos + ( 0, 0, int( heightoffset * 0.5 ) );
    missilepod = spawn( "script_model", startpos );
    missilepod setmodel( bundle.var_ca9d795da15988f2 );
    missilepod.owner = self;
    missilepod.origin = startpos;
    missilepod.angles = vectortoangles( targetpos - startpos );
    missilepod.type = "remote";
    missilepod.team = self.team;
    missilepod.entitynumber = missilepod getentitynumber();
    missilepod.streakinfo = streakinfo;
    missilepod.duration = 30;
    missilepod.animstate = "pod_flying";
    self.restoreangles = self.angles;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakname, missilepod.origin );
    }
    
    level.rockets[ missilepod.entitynumber ] = missilepod;
    level.remotemissileinprogress = 1;
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, streakname + "_use", #"use", 1, 1.5 );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_cruise_predator", self );
    }
    
    result = cruisepredator_followmissilepod( missilepod, targetpos, thirdperson, streakinfo, bundle );
    return result;
}

// Namespace cruise_predator
// Params 3
// Checksum 0xf0491693, Offset: 0xeba
// Size: 0x59
function cruisepredator_watchintropoddisown( streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"disowned" );
    
    if ( isdefined( self ) )
    {
        cruisepredator_detachplayerfromintro( streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup );
        self delete();
    }
}

// Namespace cruise_predator
// Params 3
// Checksum 0x504fcdd6, Offset: 0xf1b
// Size: 0xea
function cruisepredator_detachplayerfromintro( streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup )
{
    missileowner = self.owner;
    
    if ( isdefined( missileowner ) )
    {
        missileowner disablephysicaldepthoffieldscripting();
        missileowner visionsetnakedforplayer( "", 0 );
        missileowner cameraunlink();
        missileowner val::reset_all( "cruisePredator" );
        missileowner killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        missileowner setclientomnvar( "ui_predator_missile", 0 );
        missileowner painvisionon();
        missileowner killstreak_shared::killstreak_restorenvgstate();
        missileowner killstreak_utility::killstreak_setmainvision( "" );
        missileowner killstreak_utility::function_f1c03b279632ba1e();
        level thread game_utility::fadetoblackforplayer( missileowner, 0, 0 );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( isdefined( enemytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( enemytargetmarkergroup );
    }
    
    if ( isdefined( friendlytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( friendlytargetmarkergroup );
    }
}

#using_animtree( "script_model" );

// Namespace cruise_predator
// Params 5
// Checksum 0x52e6566f, Offset: 0x100d
// Size: 0x423, Type: bool
function cruisepredator_followmissilepod( pod, breakpos, thirdperson, streakinfo, bundle )
{
    var_63706ff132987a31 = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "wingtrails" );
    var_4b6bef68f2ea736e = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "shell_break" );
    var_e72939f607d577be = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "second_missile_thruster" );
    var_e848491bb74fbafc = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "anim_end" );
    stage1delay = var_63706ff132987a31;
    stage2delay = var_4b6bef68f2ea736e - var_63706ff132987a31;
    stage3delay = var_e72939f607d577be - var_4b6bef68f2ea736e;
    stage4delay = var_e848491bb74fbafc - var_e72939f607d577be;
    enemytargetmarkergroup = undefined;
    friendlytargetmarkergroup = undefined;
    
    if ( !thirdperson )
    {
        shellshock_utility_cpmp::_stopshellshock();
        val::group_set( "cruisePredator", 0 );
        killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "invisible" );
        self setclientomnvar( "ui_predator_missile", 1 );
        var_361a7ab2055af3a = [];
        var_d79ad8c4fb866425 = [];
        var_c627fd58d5000995 = undefined;
        
        if ( utility::issharedfuncdefined( #"cruise_predator", #"assigntargetmarkers" ) )
        {
            profilestart();
            var_c627fd58d5000995 = self [[ utility::getsharedfunc( #"cruise_predator", #"assigntargetmarkers" ) ]]( self );
            profilestop();
        }
        
        if ( isdefined( var_c627fd58d5000995.enemytargetmarkergroup ) )
        {
            var_361a7ab2055af3a = var_c627fd58d5000995.enemytargetmarkergroup;
        }
        
        if ( isdefined( var_c627fd58d5000995.friendlytargetmarkergroup ) )
        {
            var_d79ad8c4fb866425 = var_c627fd58d5000995.friendlytargetmarkergroup;
        }
        
        enemytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, var_361a7ab2055af3a, self, 0, 1, 1 );
        friendlytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerfriendly", self, var_d79ad8c4fb866425, self, 1, 1 );
        thread killstreak_utility::function_785239235d790099( "80_instant_noscale", 1 );
        
        if ( isdefined( level.mapname ) && issubstr( level.mapname, "_shipment" ) )
        {
            self visionsetnakedforplayer( "cruise_intro_shipment", 0 );
        }
        
        if ( isvisionsetloaded( level.mapname + "_cruise_intro" ) )
        {
            self visionsetnakedforplayer( level.mapname + "_cruise_intro", 0 );
        }
        
        self cameralinkto( pod, "tag_player", 1, 1 );
        pod thread cruisepredator_playdofsequence( var_e72939f607d577be );
        self painvisionoff();
        killstreak_shared::killstreak_savenvgstate();
        self.incruisemissile = 1;
        pod thread cruisepredator_watchintropoddisown( streakinfo, enemytargetmarkergroup, friendlytargetmarkergroup );
        pod thread cruisepredator_watchownerdisownaction( "disconnect" );
        pod thread cruisepredator_watchownerdisownaction( "joined_team" );
        pod thread cruisepredator_watchownerdisownaction( "joined_spectators" );
        pod thread cruisepredator_watchownerdisownaction( "player_fatal_death" );
    }
    
    podmoveanim = "mp_cruise_missile_move_intro";
    pod scriptmodelplayanimdeltamotion( podmoveanim );
    pod setscriptablepartstate( "main_thruster", "on", 0 );
    
    if ( !thirdperson )
    {
        pod playsoundtoplayer( "iw9_cruise_missile_plr_intro", self );
    }
    
    hostmigration::waitlongdurationwithpause( stage1delay );
    
    if ( !isdefined( pod ) )
    {
        return false;
    }
    
    pod setscriptablepartstate( "wing_trails", "on" );
    hostmigration::waitlongdurationwithpause( stage2delay );
    
    if ( !isdefined( pod ) )
    {
        return false;
    }
    
    pod.animstate = "pod_break";
    pod setscriptablepartstate( "wing_trails", "off" );
    pod setscriptablepartstate( "main_thruster", "off", 0 );
    playfxontag( utility::getfx( "predator_pod_break" ), pod, "tag_missile" );
    hostmigration::waitlongdurationwithpause( stage3delay );
    
    if ( !isdefined( pod ) )
    {
        return false;
    }
    
    pod.animstate = "missile_thrusters";
    pod setscriptablepartstate( "sub_thruster", "on", 0 );
    
    if ( !( isdefined( pod ) && isdefined( self ) ) )
    {
        return false;
    }
    
    thread cruisepredator_delayplayslamzoom( pod, stage4delay - 0.15, thirdperson );
    hostmigration::waitlongdurationwithpause( stage4delay - 0.05 );
    
    if ( !( isdefined( pod ) && isdefined( self ) ) )
    {
        return false;
    }
    
    thread cruisepredator_takecontrol( pod, streakinfo, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle );
    return true;
}

// Namespace cruise_predator
// Params 1
// Checksum 0x9f37dcdb, Offset: 0x1439
// Size: 0x8a
function cruisepredator_playdofsequence( var_f4b4635aa0da03b3 )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.05;
    self.owner enablephysicaldepthoffieldscripting();
    self.owner setphysicaldepthoffield( 1.4, 85, 1000, 1000 );
    hostmigration::waitlongdurationwithpause( var_f4b4635aa0da03b3 );
    self.owner setphysicaldepthoffield( 0.5, 1024, 50, 50 );
}

// Namespace cruise_predator
// Params 6
// Checksum 0xb0a3252b, Offset: 0x14cb
// Size: 0x6e4
function cruisepredator_takecontrol( pod, streakinfo, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle )
{
    pod endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    pod setscriptablepartstate( "sub_thruster", "off", 0 );
    val::set( "cruisePredatorUse", "allow_movement", 1 );
    val::set( "cruisePredatorUse", "fire", 1 );
    vehicle_tracking::function_4f76f5b4541acef1();
    spawndata = spawnstruct();
    spawndata.origin = pod gettagorigin( "tag_missile" );
    spawndata.angles = pod.angles;
    spawndata.modelname = bundle.var_35e0d82ed597981b;
    spawndata.vehicletype = bundle.deployedvehicle;
    spawndata.targetname = "rcplane";
    faildata = spawnstruct();
    missile = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !isdefined( missile ) )
    {
        /#
            thread utility::error( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreakmakevehicle" ) )
    {
        missile [[ utility::getsharedfunc( #"killstreak", #"killstreakmakevehicle" ) ]]( streakinfo.streakname );
    }
    
    vehicle_tracking::register_instance( missile );
    streakinfo.shots_fired++;
    missile setcandamage( 0 );
    missile setotherent( self );
    missile setentityowner( self );
    missile.angles = spawndata.angles;
    missile.team = self.team;
    missile.owner = self;
    missile.streakinfo = streakinfo;
    missile.lifetime = bundle.cruisepredatorlifetime;
    missile.weapon_name = bundle.projectileweapon;
    missile.enemytargetmarkergroup = enemytargetmarkergroup;
    missile.friendlytargetmarkergroup = friendlytargetmarkergroup;
    missile setscriptablepartstate( "warhead_thruster", "on", 0 );
    level thread killstreak_utility::function_6348c97b79ee8a08( missile, self, undefined, undefined, 1 );
    missile setvehicleteam( missile.team );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        missile [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 50 );
    }
    
    missile.killcament = spawn( "script_model", missile gettagorigin( "tag_player" ) );
    missile.killcament setmodel( "tag_origin" );
    missile.killcament linkto( missile, "tag_player" );
    missile endon( #"death" );
    missile emp_debuff::set_apply_emp_callback( &cruisepredator_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        missile.ksempapplycallback = &cruisepredator_empapplied;
    }
    
    fxent = spawn( "script_model", missile gettagorigin( "tag_fx" ) );
    fxent setmodel( bundle.var_b8290d66cd375f79 );
    fxent.angles = missile gettagangles( "tag_fx" );
    fxent.team = missile.team;
    fxent.owner = missile.owner;
    fxent.streakinfo = missile.streakinfo;
    fxent linkto( missile, "tag_fx" );
    fxent setscriptablepartstate( "fake_trail", "on", 0 );
    fxent setotherent( self );
    fxent thread cruisepredator_watchgameend( missile, thirdperson, streakinfo );
    fxent thread cruisepredator_watchownerdeath( missile, thirdperson, streakinfo );
    fxent thread cruisepredator_watchmissileinfo( missile );
    fxent thread cruisepredator_watchmissileexplosion( missile, self, missile.killcament, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle );
    missile thread cruisepredator_watchownerdisownaction( "disconnect" );
    missile thread cruisepredator_watchownerdisownaction( "joined_team" );
    missile thread cruisepredator_watchownerdisownaction( "joined_spectators" );
    
    if ( !thirdperson )
    {
        self visionsetnakedforplayer( "", 0 );
        killstreak_utility::killstreak_setmainvision( "" );
    }
    
    hostmigration::waitlongdurationwithpause( 0.05 );
    
    if ( !thirdperson )
    {
        self disablephysicaldepthoffieldscripting();
        self cameraunlink();
        thread killstreak_utility::function_785239235d790099( "default" );
        self cameralinkto( missile, "tag_player", 1 );
        self usevehicle( missile, 0 );
        missilevisionset = "cruise_color_mp";
        
        if ( isdefined( level.mapname ) && ( issubstr( level.mapname, "_shipment" ) || issubstr( level.mapname, "mp_skerries" ) ) )
        {
            missilevisionset = "cruise_color_fog_mp";
        }
        
        killstreak_utility::killstreak_setmainvision( missilevisionset );
        
        if ( isdefined( level.cruisepredatorvisionset ) )
        {
            self.currentvisionset = level.cruisepredatorvisionset;
        }
        else
        {
            self.currentvisionset = "cruise_color_mp";
        }
        
        killstreak_utility::killstreak_setmainvision( self.currentvisionset );
        self.soundent = spawn( "script_origin", missile.origin );
        self.soundent showonlytoplayer( self );
        self.soundent playloopsound( "iw9_cruise_missile_plr" );
        shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", missile.lifetime, 0 );
        killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "on" );
        self setclientomnvar( "ui_predator_missile", 2 );
        self setclientomnvar( "ui_killstreak_health", 1 );
        self setclientomnvar( "ui_killstreak_countdown", gettime() + int( 10000 ) );
        self setclientomnvar( "ui_predator_missiles_left", -1 );
        
        if ( cruisepredator_isnightmap() )
        {
            var_fb9e82ab20fedecf = killstreak_utility::function_2c6a2b2cb28d923a();
            killstreak_utility::killstreak_setmainvision( var_fb9e82ab20fedecf );
            player_utility::setthermalvision( 1, 12, 1500 );
            shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_flir_mp", #"top", missile.lifetime, 0 );
        }
    }
    
    missile thread cruisepredator_delaymissilecollision();
    missile thread cruisepredator_watchtimer( self, bundle.cruisepredatorlifetime );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_db930e86be398a1f" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_db930e86be398a1f" ) ]]( missile );
    }
    
    waitframe();
    
    if ( isdefined( pod ) )
    {
        pod delete();
    }
}

// Namespace cruise_predator
// Params 0
// Checksum 0x472cb2f4, Offset: 0x1bb7
// Size: 0x69
function cruisepredator_watchkillborder()
{
    if ( !isdefined( level.kill_border_triggers ) )
    {
        /#
            self.owner iprintln( "<dev string:x76>" );
        #/
        
        return;
    }
    
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    
    while ( true )
    {
        if ( cruisepredator_istouchingkillborder( level.kill_border_triggers ) )
        {
            self notify( #"explode" );
            break;
        }
        
        waitframe();
    }
}

// Namespace cruise_predator
// Params 1
// Checksum 0x179894fd, Offset: 0x1c28
// Size: 0x93
function cruisepredator_istouchingkillborder( triggerlist )
{
    touchingtrigger = 0;
    
    foreach ( trigger in triggerlist )
    {
        if ( self istouching( trigger ) )
        {
            touchingtrigger = 1;
            break;
        }
    }
    
    return touchingtrigger;
}

// Namespace cruise_predator
// Params 0
// Checksum 0x4fc66b9c, Offset: 0x1cc4
// Size: 0x41
function cruisepredator_delaymissilecollision()
{
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    hostmigration::waitlongdurationwithpause( 0.75 );
    self vehphys_enablecollisioncallback( 1 );
    hostmigration::waitlongdurationwithpause( 1.25 );
    thread cruisepredator_watchkillborder();
}

// Namespace cruise_predator
// Params 3
// Checksum 0xc38afdab, Offset: 0x1d0d
// Size: 0x1b7
function cruisepredator_watchownerdeath( missile, thirdperson, streakinfo )
{
    level endon( #"game_ended" );
    missile endon( #"death" );
    missile endon( #"disowned" );
    missile endon( #"cruise_missile_explode" );
    self endon( #"death" );
    self.owner waittill( #"death_or_disconnect" );
    rider = self.owner;
    
    if ( isdefined( missile.enemytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( missile.enemytargetmarkergroup );
    }
    
    if ( isdefined( missile.friendlytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( missile.friendlytargetmarkergroup );
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"cpunmarkenemies" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"cpunmarkenemies" ) ]]( rider );
    }
    
    if ( isdefined( rider ) )
    {
        if ( !thirdperson )
        {
            rider cameraunlink();
            rider leavevehicle();
            
            if ( isdefined( rider.soundent ) )
            {
                rider.soundent stoploopsound( "iw9_cruise_missile_plr" );
                rider.soundent delete();
            }
        }
        
        rider killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        rider setclientomnvar( "ui_predator_missile", 0 );
        rider thread cruisepredator_returnplayer( streakinfo );
        
        if ( utility::issharedfuncdefined( #"cruise_predator", #"removeitemfromslot" ) )
        {
            [[ utility::getsharedfunc( #"cruise_predator", #"removeitemfromslot" ) ]]( rider );
        }
    }
}

// Namespace cruise_predator
// Params 3
// Checksum 0x2d7bad26, Offset: 0x1ecc
// Size: 0x1ce
function cruisepredator_watchgameend( missile, thirdperson, streakinfo )
{
    missile endon( #"death" );
    missile endon( #"cruise_missile_explode" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    missile notify( #"hash_d492b41c9971638f" );
    rider = self.owner;
    
    if ( isdefined( missile.enemytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( missile.enemytargetmarkergroup );
    }
    
    if ( isdefined( missile.friendlytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( missile.friendlytargetmarkergroup );
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"cpunmarkenemies" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"cpunmarkenemies" ) ]]( rider );
    }
    
    if ( isdefined( rider ) )
    {
        if ( !thirdperson )
        {
            rider cameraunlink();
            rider leavevehicle();
            
            if ( isdefined( rider.soundent ) )
            {
                rider.soundent stoploopsound( "iw9_cruise_missile_plr" );
                rider.soundent delete();
            }
        }
        
        rider killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        rider setclientomnvar( "ui_predator_missile", 0 );
        rider thread cruisepredator_returnplayer( streakinfo );
        
        if ( utility::issharedfuncdefined( #"cruise_predator", #"removeitemfromslot" ) )
        {
            [[ utility::getsharedfunc( #"cruise_predator", #"removeitemfromslot" ) ]]( rider );
        }
    }
    
    vehicle_tracking::deregister_instance( missile );
    vehicle_tracking::delete_vehicle( missile );
}

// Namespace cruise_predator
// Params 1
// Checksum 0xed4e9c7f, Offset: 0x20a2
// Size: 0x49
function cruisepredator_watchmissileinfo( missile )
{
    self endon( #"death" );
    
    while ( true )
    {
        self.missilelastpos = missile.origin;
        self.missilelastangle = missile.angles;
        waitframe();
    }
}

// Namespace cruise_predator
// Params 7
// Checksum 0x884ef2a3, Offset: 0x20f3
// Size: 0x60d
function cruisepredator_watchmissileexplosion( missile, rider, killcament, thirdperson, enemytargetmarkergroup, friendlytargetmarkergroup, bundle )
{
    missile endon( #"hash_d492b41c9971638f" );
    explodepos = undefined;
    missileangles = undefined;
    streakinfo = missile.streakinfo;
    explodeinfo = undefined;
    
    while ( true )
    {
        explodeinfo = missile killstreak_shared::killstreak_waittillexplode( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
        
        if ( explodeinfo.msg == "collision" )
        {
            surface = physics_getsurfacetypefromflags( explodeinfo.param4 );
            surfacetype = getsubstr( surface[ "name" ], 9 );
            collisiondebug = getdvarint( @"hash_c2491ce0fa8bc62", 0 );
            
            /#
                if ( collisiondebug )
                {
                    iprintln( "<dev string:x99>" + surfacetype );
                    continue;
                }
            #/
            
            if ( surfacetype == "glass_pane" )
            {
                continue;
            }
        }
        
        break;
    }
    
    if ( isdefined( missile ) )
    {
        missile setscriptablepartstate( "warhead_thruster", "off", 0 );
        missile notify( #"cruise_missile_explode" );
    }
    
    if ( isdefined( rider ) && rider.incruisemissile )
    {
        if ( isdefined( enemytargetmarkergroup ) )
        {
            targetmarkergroups::targetmarkergroup_off( enemytargetmarkergroup );
        }
        
        if ( isdefined( friendlytargetmarkergroup ) )
        {
            targetmarkergroups::targetmarkergroup_off( friendlytargetmarkergroup );
        }
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"cpunmarkenemies" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"cpunmarkenemies" ) ]]( rider );
    }
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "fake_trail", "off", 0 );
        thread function_30816fcb07d9a7c7();
        explodepos = self.missilelastpos;
        missileangles = self.missilelastangle;
        
        if ( isdefined( rider ) && !thirdperson )
        {
            rider cameraunlink();
            
            if ( rider.incruisemissile )
            {
                rider leavevehicle();
            }
        }
        
        if ( isdefined( missile ) )
        {
            vehicle_tracking::deregister_instance( missile );
            vehicle_tracking::delete_vehicle( missile );
        }
        
        if ( !isdefined( explodeinfo ) || explodeinfo.msg != "emp_defused" && explodeinfo.msg != "trophy_blocked" )
        {
            explosionradius = bundle.cruisepredatordamageradius;
            var_c0180fae9381b5ba = "MOD_EXPLOSIVE";
            var_d74c2c09b82e0591 = bundle.projectileweapon;
            
            if ( isdefined( rider ) )
            {
                skipdamage = isdefined( explodeinfo ) && explodeinfo.msg == "disowned";
                
                if ( !skipdamage )
                {
                    self radiusdamage( explodepos, explosionradius, bundle.var_4f8762522e1f2a17, bundle.var_4fab50522e477d39, rider, var_c0180fae9381b5ba, var_d74c2c09b82e0591 );
                }
                
                players = utility::playersinsphere( explodepos, explosionradius );
                
                foreach ( player in players )
                {
                    if ( player player::isreallyalive() && player_utility::playersareenemies( player, rider ) )
                    {
                        if ( utility::issharedfuncdefined( #"sound", #"trysaylocalsound" ) )
                        {
                            level thread [[ utility::getsharedfunc( #"sound", #"trysaylocalsound" ) ]]( player, #"bc_flavor_player_closecall", 1 );
                        }
                    }
                }
            }
            
            if ( isdefined( level.var_845fe19bc9ff4b8e ) )
            {
                thread [[ level.var_845fe19bc9ff4b8e ]]( self.streakinfo, self.origin, 0 );
            }
        }
        
        if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
        {
            [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( explodepos );
        }
        
        thread cruisepredator_handlevfxstates( explodeinfo );
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"eventrecord" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"eventrecord" ) ]]( explodepos );
    }
    
    if ( isdefined( rider ) )
    {
        rider thread cruisepredator_watchkills( explodeinfo );
        
        if ( !thirdperson )
        {
            assert( isdefined( explodepos ) && isdefined( missileangles ), "<dev string:xc4>" );
            
            if ( isdefined( rider.soundent ) )
            {
                rider.soundent stoploopsound( "iw9_cruise_missile_plr" );
                rider.soundent delete();
            }
            
            rider killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
            rider setclientomnvar( "ui_predator_missile", 0 );
            
            if ( cruisepredator_isnightmap() )
            {
                rider player_utility::setthermalvision( 0 );
            }
            
            if ( isdefined( level.var_fa0d180f4b71bc0e ) )
            {
                thread [[ level.var_fa0d180f4b71bc0e ]]( streakinfo );
            }
            
            visionset = "killstreak_static";
            
            if ( rider.incruisemissile )
            {
                fadeintime = 0.4;
                fadedelay = 0.6;
                fadeouttime = 0.05;
                rider thread cruisepredator_startfadecamtransition( fadeintime, fadedelay, fadeouttime, visionset );
                rider playlocalsound( "iw9_cruise_missile_exp_static" );
                rider earthquakeforplayer( 0.3, 3.5, rider.origin, 100 );
                rider playrumbleonpositionforclient( "artillery_rumble", rider.origin );
                rider thread cruisepredator_returnplayer( streakinfo, 1 );
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"cruise_predator", #"removeitemfromslot" ) )
    {
        [[ utility::getsharedfunc( #"cruise_predator", #"removeitemfromslot" ) ]]( rider );
    }
    
    wait 1.5;
}

// Namespace cruise_predator
// Params 0
// Checksum 0xb31ba4e4, Offset: 0x2708
// Size: 0x72
function function_30816fcb07d9a7c7()
{
    level endon( #"game_ended" );
    minimapid = objidpoolmanager::createobjective( "icon_minimap_cruisemissile", self.team, undefined, 1, undefined, "icon_large" );
    wait 2;
    
    if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
    {
        [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( minimapid );
    }
}

// Namespace cruise_predator
// Params 2
// Checksum 0x4548ba32, Offset: 0x2782
// Size: 0x44
function cruisepredator_cameramove( targetpos, startpos )
{
    self moveto( targetpos, 0.2, 0, 0.05 );
    wait 0.15;
    self moveto( targetpos + vectornormalize( startpos - targetpos ) * 24, 2 );
}

// Namespace cruise_predator
// Params 2
// Checksum 0x72c9d328, Offset: 0x27ce
// Size: 0xfe
function cruisepredator_returnplayer( streakinfo, exploded )
{
    self endon( #"disconnect" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( utility::issharedfuncdefined( #"player", #"disable_backpack_inventory" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"disable_backpack_inventory" ) ]]( 0 );
    }
    
    if ( isdefined( level.killstreakfinishusefunc ) )
    {
        level thread [[ level.killstreakfinishusefunc ]]( streakinfo );
    }
    
    level thread killstreak_utility::restorekillstreakplayerangles( self );
    
    if ( exploded )
    {
        wait 0.5;
    }
    
    killstreak_utility::function_f1c03b279632ba1e();
    killstreak_utility::killstreak_setmainvision( "" );
    self painvisionon();
    killstreak_shared::killstreak_restorenvgstate();
    val::group_reset( "cruisePredator" );
    val::reset_all( "cruisePredatorUse" );
    self.incruisemissile = undefined;
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace cruise_predator
// Params 2
// Checksum 0xe2067352, Offset: 0x28d4
// Size: 0x3f
function cruisepredator_watchtimer( rider, lifetime )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( lifetime );
    self notify( #"explode", self.origin );
}

// Namespace cruise_predator
// Params 1
// Checksum 0x1cd252a3, Offset: 0x291b
// Size: 0x57
function cruisepredator_watchownerdisownaction( action )
{
    self endon( #"death" );
    self endon( #"disowned" );
    level endon( #"game_ended" );
    missileowner = self.owner;
    missileowner waittill( action );
    self notify( #"disowned" );
}

// Namespace cruise_predator
// Params 0
// Checksum 0x6dc22dd1, Offset: 0x297a
// Size: 0x20
function cruisepredator_startexplodecamtransition()
{
    killstreak_utility::killstreak_setmainvision( "killstreak_slamzoom" );
    wait 0.1;
    killstreak_utility::killstreak_setmainvision( "" );
}

// Namespace cruise_predator
// Params 4
// Checksum 0xebdc2314, Offset: 0x29a2
// Size: 0x94
function cruisepredator_startfadecamtransition( fadeintime, fadedelay, fadeouttime, var_5992112f2391b634 )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( fadeintime ) )
    {
        fadeintime = 0.5;
    }
    
    if ( !isdefined( fadedelay ) )
    {
        fadedelay = 0.5;
    }
    
    if ( !isdefined( fadeouttime ) )
    {
        fadeouttime = 0.05;
    }
    
    if ( isdefined( var_5992112f2391b634 ) )
    {
        killstreak_utility::killstreak_setmainvision( var_5992112f2391b634 );
        wait fadedelay;
        killstreak_utility::killstreak_setmainvision( "" );
        return;
    }
    
    level thread game_utility::fadetoblackforplayer( self, 1, fadeintime );
    wait fadedelay;
    level thread game_utility::fadetoblackforplayer( self, 0, fadeouttime );
}

// Namespace cruise_predator
// Params 1
// Checksum 0x41bc9fbb, Offset: 0x2a3e
// Size: 0x53
function cruisepredator_shakerider( shaketime )
{
    self endon( #"disconnect" );
    counter = 0;
    
    while ( counter < shaketime )
    {
        self playrumbleonpositionforclient( "damage_light", self.origin );
        counter += 0.05;
        wait 0.05;
    }
}

// Namespace cruise_predator
// Params 1
// Checksum 0x2ba85318, Offset: 0x2a99
// Size: 0x129
function cruisepredator_handlevfxstates( explodeinfo )
{
    self endon( #"death" );
    self unlink();
    
    if ( !isdefined( explodeinfo ) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked" )
    {
        self setscriptablepartstate( "air_explosion", "on", 0 );
        hostmigration::waitlongdurationwithpause( 0.2 );
        self delete();
    }
    
    worldup = ( 0, 0, 1 );
    surfacenormal = explodeinfo.param6;
    self.angles = vectortoangles( surfacenormal );
    angledirection = vectordot( surfacenormal, worldup );
    
    if ( angledirection >= 0.7 )
    {
        self setscriptablepartstate( "ground_explosion", "on", 0 );
    }
    else
    {
        self setscriptablepartstate( "air_explosion", "on", 0 );
    }
    
    hostmigration::waitlongdurationwithpause( 1 );
    self delete();
}

// Namespace cruise_predator
// Params 1
// Checksum 0x7fc755e2, Offset: 0x2bca
// Size: 0x91
function cruisepredator_watchkills( explodeinfo )
{
    self endon( #"disconnect" );
    hostmigration::waitlongdurationwithpause( 1 );
    
    if ( isdefined( self ) && isdefined( self.recentkillcount ) )
    {
        if ( self.recentkillcount >= 1 )
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "cruise_predator" + "_hit_target", #"hit", 1 );
            return;
        }
        
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "cruise_predator" + "_miss_target", #"miss", 1 );
    }
}

// Namespace cruise_predator
// Params 3
// Checksum 0xe8788ba6, Offset: 0x2c63
// Size: 0x73
function cruisepredator_delayplayslamzoom( pod, delaytime, thirdperson )
{
    self endon( #"disconnect" );
    pod endon( #"disowned" );
    hostmigration::waitlongdurationwithpause( delaytime );
    
    if ( !thirdperson )
    {
        killstreak_utility::killstreak_setmainvision( "killstreak_slamzoom" );
        level thread game_utility::fadetoblackforplayer( self, 1, 0.2 );
        wait 0.2;
        level thread game_utility::fadetoblackforplayer( self, 0, 0 );
    }
}

// Namespace cruise_predator
// Params 1
// Checksum 0x5aff8327, Offset: 0x2cde
// Size: 0x1d
function cruisepredator_empapplied( data )
{
    if ( isdefined( self ) )
    {
        self notify( #"emp_defused" );
    }
}

// Namespace cruise_predator
// Params 0
// Checksum 0xec9f55b4, Offset: 0x2d03
// Size: 0x1b, Type: bool
function cruisepredator_isnightmap()
{
    return utility::isnightmap() || level.mapname == "mp_jup_grandprix_pm_2";
}

