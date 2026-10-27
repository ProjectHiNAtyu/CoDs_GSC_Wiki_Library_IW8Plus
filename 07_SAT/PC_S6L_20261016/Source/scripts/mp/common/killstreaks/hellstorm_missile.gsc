// scripts\mp\common\killstreaks\hellstorm_missile.gsc  (hash_4a9c301d3918fc47.gscc) (size: 37497 Bytes / 0x9279 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8cecb92 (4174302098)
// size ...... 37497 (0x9279)
// includes .. 11  (offset: 0x8b79)
// strings ... 102 (offset: 0x8bd1)
// dev strs .. 9   (offset: 0x9205)
// exports ... 73  (offset: 0x5d7d)
// cseg ...... 0x7e5 + 0x5598 (0x5d7d)
// imports ... 271 (offset: 0x68e5)
// animtree1 . 0   (offset: 0x9279)
// animtree2 . 0   (offset: 0x9279)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;

#namespace hellstorm_missile;

// Namespace hellstorm_missile
// Params 0, eflags: 0x1
// Checksum 0x13707d80, Offset: 0x803
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "hellstorm_missile" ), &init );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x6f2de868, Offset: 0x822
// Size: 0x365
function init()
{
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "hellstorm_missile", &function_1562fb0708734323 );
    utility::registersharedfunc( #"hellstorm_missile", #"initactionsets", &function_72aad3b0d40ee2e6, 1 );
    utility::registersharedfunc( #"hellstorm_missile", #"registervo", &function_85bc60c9edbe1df1, 1 );
    utility::registersharedfunc( #"hellstorm_missile", #"eventrecord", &function_201cc0477d622e5c, 1 );
    utility::registersharedfunc( #"hellstorm_missile", #"createpod", &function_bd88280fd21ae5d6 );
    utility::registersharedfunc( #"hellstorm_missile", #"followpod", &function_cd1dbece9ec13d35 );
    utility::registersharedfunc( #"hellstorm_missile", #"missileinittrans", &function_74c32d5981ff22eb );
    utility::registersharedfunc( #"hellstorm_missile", #"charactertargets", &function_57b18952fc886f94 );
    utility::registersharedfunc( #"hellstorm_missile", #"setmissilescriptablestate", &function_ab2cfc2ac65594c9 );
    utility::registersharedfunc( #"hellstorm_missile", #"setfovpreset", &function_c8ce0872c7f15dcb );
    utility::registersharedfunc( #"hellstorm_missile", #"assigntargetmarkers", &function_eadce66a6aa319ca );
    bundle = level.streakglobals.streakbundles[ "hellstorm_missile" ];
    assert( isdefined( bundle ) );
    assert( isdefined( bundle.var_e00730f7172b3226 ) );
    assert( isdefined( bundle.deployweaponname ) );
    level.var_961ecbdb14725d57 = spawnstruct();
    level.var_961ecbdb14725d57.deployweaponname = bundle.deployweaponname;
    level.var_961ecbdb14725d57.var_e00730f7172b3226 = bundle.var_e00730f7172b3226;
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "hellstorm_missile", bundle.projectileweapon, #"large" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "hellstorm_missile", bundle.var_e00730f7172b3226, #"large" );
    
    /#
        setdevdvarifuninitialized( @"hash_93921bac59b50618", 0 );
        setdevdvarifuninitialized( @"hash_3a9a76ce997f682b", 1000 );
        setdevdvarifuninitialized( @"hash_5c31e35b791afd24", 0 );
        setdevdvarifuninitialized( @"hash_52ee5211cdef7fe4", 50 );
        setdevdvarifuninitialized( @"hash_95e758249d8faaa0", 150 );
        setdevdvarifuninitialized( @"hash_1dd0c19edb1951fc", 1 );
        setdevdvarifuninitialized( @"scr_cruise_collision_debug", 0 );
        setdevdvarifuninitialized( @"scr_debug_hellstorm", 0 );
        setdevdvarifuninitialized( @"hash_938e1fa8d958bff", 0 );
        setdevdvarifuninitialized( @"hash_bb7e1875b8c27444", 0 );
        setdevdvarifuninitialized( @"hash_348de87258fbac1e", 0 );
        setdevdvarifuninitialized( @"hash_48644484b2c4a3c9", 1 );
        setdevdvarifuninitialized( @"hash_98b8768f54529b8f", 1 );
    #/
    
    level function_d58e2df1af162d0b();
    level utility::callsharedfunc( #"hellstorm_missile", #"initactionsets" );
    level function_6db58b2268da1eb9();
    level function_6dfb9c226926d38c();
    level function_a41f7c85e6669f83();
    scene::function_85b13b837056bc8b( &function_6f44a5ce1febb7b0 );
    utility::registersharedfunc( #"hellstorm_missile", #"hack", &hellstorm_missile_hack );
    utility::flag_set( "hellstorm_missile_initialized" );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x970f3f14, Offset: 0xb8f
// Size: 0x87
function function_85bc60c9edbe1df1()
{
    game[ "dialog" ][ "cruise_separation_1" ] = "flavor_predator20";
    game[ "dialog" ][ "cruise_separation_2" ] = "flavor_predator30";
    game[ "dialog" ][ "cruise_control_1" ] = "flavor_predator40";
    game[ "dialog" ][ "cruise_control_2" ] = "flavor_predator50";
    game[ "dialog" ][ "cruise_control_3" ] = "flavor_predator60";
    game[ "dialog" ][ "cruise_kill" ] = "cruise_predator_hit";
    game[ "dialog" ][ "cruise_miss" ] = "cruise_predator_miss";
}

// Namespace hellstorm_missile
// Params 1
// Checksum 0x2b7339a4, Offset: 0xc1e
// Size: 0x1b
function function_201cc0477d622e5c( explodepos )
{
    if ( isdefined( explodepos ) )
    {
        namespace_9d8e359c3b1041e5::function_4c27e16d83fce53a( explodepos );
    }
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x231cf5b6, Offset: 0xc41
// Size: 0x45
function function_72aad3b0d40ee2e6()
{
    val::group_register( "hellstormMissile", [ "fire", "weapon_switch", "melee", "usability", "shellshock", "offhand_weapons" ] );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x83e86d2e, Offset: 0xc8e
// Size: 0x28
function function_d58e2df1af162d0b()
{
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "hellstorm_missile", "invisible", 13 );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "hellstorm_missile", "on", 14 );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0xec9f07b4, Offset: 0xcbe
// Size: 0x1b
function function_6db58b2268da1eb9()
{
    utility::callsharedfunc( #"hellstorm_missile", #"registervo" );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0xe2c0a1ad, Offset: 0xce1
// Size: 0x6e
function function_6dfb9c226926d38c()
{
    bundle = level.streakglobals.streakbundles[ "hellstorm_missile" ];
    assert( isdefined( bundle.var_1bafecce394db6cc ) );
    var_1905c44503da3868 = bundle.var_1bafecce394db6cc ?? "vfx_iw8_mp_strk_cruise_predator_explo";
    level._effect[ "predator_pod_break" ] = loadfxasset( var_1905c44503da3868 );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x765932ff, Offset: 0xd57
// Size: 0x74
function function_a41f7c85e6669f83()
{
    if ( isdefined( level.var_53d61e37342749c2 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.var_53d61e37342749c2 );
    }
    else
    {
        killstreak_shared::function_28d986de72ce85f8( "cruise_color_mp" );
    }
    
    bundle = level.streakglobals.streakbundles[ "hellstorm_missile" ];
    
    if ( isdefined( bundle.var_b9126e5673967962 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_b9126e5673967962 );
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x83151831, Offset: 0xdd3
// Size: 0xe, Type: bool
function private function_5dcea9aa9cd60d7b( streakinfo )
{
    return true;
}

// Namespace hellstorm_missile
// Params 4
// Checksum 0xd2bcb8cd, Offset: 0xdea
// Size: 0x7e
function function_1d9ee2e2a5ce63fc( player, start_position, end_position, speed = 200 )
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "hellstorm_missile", player );
    streakinfo.var_3748b8c29ef65e91 = [ start_position, end_position, speed ];
    return player function_1562fb0708734323( streakinfo, ( 0, 0, 0 ) );
}

// Namespace hellstorm_missile
// Params 2
// Checksum 0xbb530dd8, Offset: 0xe71
// Size: 0x380, Type: bool
function function_1562fb0708734323( streakinfo, bombtargetpos )
{
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_failed_use" );
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_a67817cc009547a9" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_a67817cc009547a9" ) ]]( streakinfo );
    }
    
    val::set( "hellstorm_active", "killstreaks", 0 );
    deployresult = 1;
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        if ( level.gametypebundle.var_711e33239e4c9925 )
        {
            assert( !callback::exists( #"killstreak_cancel", &function_961a3029bb23b54d ) );
            assert( !isdefined( self.var_8598ad3c49553a06 ) );
            self.var_8598ad3c49553a06 = streakinfo;
            callback::add( #"killstreak_cancel", &function_961a3029bb23b54d );
            deployresult = undefined;
            thread function_a6a2d5c7d0477b4c( streakinfo );
            self waittill( #"hash_598401e5ed7efc87", deployresult );
            callback::remove( #"killstreak_cancel", &function_961a3029bb23b54d );
            self.var_8598ad3c49553a06 = undefined;
        }
        else
        {
            deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweapontabletdeploysharedfunc( streakinfo, &function_5dcea9aa9cd60d7b, streakinfo.weaponswitchendedcallback, undefined, undefined, level.var_961ecbdb14725d57.deployweaponname );
        }
    }
    
    if ( !deployresult )
    {
        streakinfo notify( #"killstreak_failed_use" );
        val::set( "hellstorm_active", "killstreaks", 1 );
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            val::set( "hellstorm_active", "killstreaks", 1 );
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_failed_use" );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        val::set( "hellstorm_active", "killstreaks", 1 );
        return false;
    }
    
    thirdperson = getdvarint( @"hash_93921bac59b50618", 0 );
    streakinfo.var_e8b8649e71024d0 = 0.8;
    
    /#
        if ( thirdperson )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        }
    #/
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_c9165dc5ca7dc356" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_c9165dc5ca7dc356" ) ]]();
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    
    if ( bundle.var_62999497c58c0833 )
    {
        bombtargetpos = self.origin;
    }
    
    result = function_a1e64b0aed03b553( streakinfo.streakname, streakinfo, thirdperson, bombtargetpos );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_d5389c45c9f4aa3" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_d5389c45c9f4aa3" ) ]]( result );
    }
    
    if ( !result )
    {
        val::set( "hellstorm_active", "killstreaks", 1 );
        return false;
    }
    
    utility::callsharedfunc( #"hud", #"teamplayercardsplash", "used_hellstorm_missile", self );
    return true;
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x131be15b, Offset: 0x11fa
// Size: 0xaa
function private function_a6a2d5c7d0477b4c( streakinfo )
{
    self endon( #"killstreak_finished_with_deploy_weapon" );
    result = utility::waittill_notify_or_timeout_return( "cancel_all_killstreak_deployments", level.framedurationseconds );
    
    if ( result == "cancel_all_killstreak_deployments" )
    {
        self notify( #"hash_598401e5ed7efc87", 0 );
        return;
    }
    
    deployresult = 1;
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweapontabletdeploysharedfunc( streakinfo, &function_5dcea9aa9cd60d7b, streakinfo.weaponswitchendedcallback, undefined, undefined, level.var_961ecbdb14725d57.deployweaponname );
    }
    
    self notify( #"hash_598401e5ed7efc87", deployresult );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0x5931e861, Offset: 0x12ac
// Size: 0x19
function function_57b18952fc886f94()
{
    character_array = level.players;
    return character_array;
}

// Namespace hellstorm_missile
// Params 4, eflags: 0x4
// Checksum 0x573d27e, Offset: 0x12ce
// Size: 0x412, Type: bool
function private function_a1e64b0aed03b553( streakname, streakinfo, thirdperson, bombtargetpos )
{
    self disablephysicaldepthoffieldscripting();
    spawncenterpos = level.mapcenter;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_b48d25f031e6955c" ) )
    {
        spawncenterpos = self [[ utility::getsharedfunc( #"killstreak", #"hash_b48d25f031e6955c" ) ]]();
    }
    
    if ( !isvector( spawncenterpos ) )
    {
        spawncenterpos = self.origin;
    }
    
    if ( isvector( bombtargetpos ) )
    {
        spawncenterpos = bombtargetpos;
    }
    
    allenemies = [];
    sumvectors = ( 0, 0, 0 );
    forwardvector = undefined;
    character_array = utility::callsharedfunc( #"hellstorm_missile", #"charactertargets" );
    
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
        forwardvector = sumvectors / allenemies.size * ( 1, 1, 0 );
        forwardvector = vectornormalize2( forwardvector );
    }
    else
    {
        randy = randomint( 360 );
        
        /#
            randy = getdvarint( @"testyaw", randy );
        #/
        
        forwardvector = anglestoforward( ( 0, randy, 0 ) );
    }
    
    if ( utility::issharedfuncdefined( #"hellstorm_missile", #"directionoverride" ) )
    {
        forwardvector = self [[ utility::getsharedfunc( #"hellstorm_missile", #"directionoverride" ) ]]( spawncenterpos );
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    level.var_80e306c723f24a10 = getdvarint( @"hash_938e1fa8d958bff", 0 ) && isdefined( bundle.var_5dbd007f427cc754 );
    
    if ( isdefined( self ) )
    {
        var_c2ecf940026626e0 = level.sharedfuncs[ #"killstreak" ][ #"hash_1fa18935c88e6b0c" ];
        
        if ( isdefined( var_c2ecf940026626e0 ) )
        {
            self [[ var_c2ecf940026626e0 ]]( bundle.projectileweapon );
        }
    }
    
    missilepod = undefined;
    
    if ( level.var_80e306c723f24a10 )
    {
        [ startpos, targetpos ] = function_1861590fe361a961( spawncenterpos, forwardvector );
        var_a5a36198bbfe76b0 = { #angles:vectortoangles( forwardvector ), #origin:startpos };
        missilepod = hellstormmissile_spawnvehicle( var_a5a36198bbfe76b0, streakinfo );
        self usevehicle( missilepod, 0 );
    }
    else
    {
        missilepod = utility::callsharedfunc( #"hellstorm_missile", #"createpod", spawncenterpos, forwardvector, bombtargetpos, streakinfo );
    }
    
    self.restoreangles = self.angles;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakname, missilepod.origin );
    }
    
    namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "use_" + streakname, #"use", 1 );
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, #"deploy", 1, 1 );
    thread utility::callsharedfunc( #"hellstorm_missile", #"followpod", missilepod, missilepod.targetpos, thirdperson, streakinfo );
    return true;
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xd59a8146, Offset: 0x16e9
// Size: 0x39
function private function_961a3029bb23b54d( params )
{
    self notify( #"hash_598401e5ed7efc87", 0 );
    self notify( #"cancel_all_killstreak_deployments" );
    self.var_8598ad3c49553a06 notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0x8e40a972, Offset: 0x172a
// Size: 0xea
function private function_1861590fe361a961( spawncenterpos, forwardvector )
{
    var_cbaab2ed6edf8fc7 = getdvarint( @"hash_9d9cb6af37b21ba2", 9800 );
    
    if ( utility::issharedfuncdefined( #"hellstorm_missile", #"getcustomstartandtargetposition" ) )
    {
        return utility::callsharedfunc( #"hellstorm_missile", #"getcustomstartandtargetposition", var_cbaab2ed6edf8fc7, forwardvector );
    }
    
    heightent = namespace_9d8e359c3b1041e5::getkillstreakairstrikeheightentsharedfunc();
    heightoffset = isdefined( heightent ) ? heightent.origin[ 2 ] + 7000 : 10000;
    missileoffset = spawncenterpos + ( 0, 0, heightoffset );
    startpos = missileoffset - forwardvector * var_cbaab2ed6edf8fc7;
    targetpos = spawncenterpos + ( 0, 0, int( heightoffset * 0.5 ) );
    return [ startpos, targetpos ];
}

// Namespace hellstorm_missile
// Params 4, eflags: 0x4
// Checksum 0x8a1a1f80, Offset: 0x181d
// Size: 0x1cb
function private function_bd88280fd21ae5d6( spawncenterpos, forwardvector, bombtargetpos, streakinfo )
{
    [ startpos, targetpos ] = function_1861590fe361a961( spawncenterpos, forwardvector );
    bundle = level.streakglobals.streakbundles[ "hellstorm_missile" ];
    assert( isdefined( bundle.var_9de3ad483b150bd2 ) );
    podmodelname = bundle.var_9de3ad483b150bd2 ?? "wmd_vm_missile_cruise_mp";
    missilepod = spawn( "script_model", startpos );
    missilepod setmodel( podmodelname );
    missilepod.owner = self;
    missilepod.origin = startpos;
    missilepod.angles = vectortoangles( targetpos - startpos );
    missilepod.type = "remote";
    missilepod.team = self.team;
    missilepod.targetpos = targetpos;
    missilepod.entitynumber = missilepod getentitynumber();
    missilepod.streakinfo = streakinfo;
    missilepod.duration = 30;
    missilepod.bombtargetpos = bombtargetpos;
    missilepod.angles = ( 0, missilepod.angles[ 1 ], 0 );
    
    if ( !isvector( missilepod.bombtargetpos ) )
    {
        missilepod.bombtargetpos = spawncenterpos;
    }
    
    level.rockets[ missilepod.entitynumber ] = missilepod;
    level.remotemissileinprogress = 1;
    return missilepod;
}

// Namespace hellstorm_missile
// Params 1
// Checksum 0x451ebcdc, Offset: 0x19f1
// Size: 0x45
function function_1638fb886ca4c4df( streakinfo )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"disowned" );
    
    if ( isdefined( self ) )
    {
        function_2c66bf200b36b129( streakinfo );
        self delete();
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x9a98a781, Offset: 0x1a3e
// Size: 0xca
function private function_2c66bf200b36b129( streakinfo )
{
    missileowner = self.owner;
    
    if ( isdefined( missileowner ) )
    {
        missileowner disablephysicaldepthoffieldscripting();
        missileowner unlink();
        missileowner val::group_reset( "hellstormMissile" );
        missileowner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "off" );
        missileowner setclientomnvar( "ui_predator_missile", 0 );
        missileowner painvisionon();
        missileowner killstreak_shared::killstreak_restorenvgstate();
        missileowner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( spawnstruct() );
        level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( missileowner, 0, 0 );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    missileowner killstreak_shared::function_76bbbe12ce816ed2();
    missileowner killstreak_shared::function_b3302c4317df36c6();
}

// Namespace hellstorm_missile
// Params 4, eflags: 0x4
// Checksum 0x538455d9, Offset: 0x1b10
// Size: 0x5f1
function private function_cd1dbece9ec13d35( pod, breakpos, thirdperson, streakinfo )
{
    self endon( #"killstreak_cancel" );
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    var_eb7637b38fd11de3 = bundle.var_1d06cd8110cc6b2d ?? 3;
    self setclientomnvar( "ui_killstreak_weapon_1_ammo", var_eb7637b38fd11de3 );
    
    /#
        pod thread debugdrawpod();
    #/
    
    var_361a7ab2055af3a = [];
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        self.var_8ff71ee2591d99a9 = 1;
        
        if ( !thirdperson )
        {
            namespace_9d8e359c3b1041e5::stopshellshocksharedfunc();
            val::group_set( "hellstormMissile", 0 );
            namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "invisible" );
            self setclientomnvar( "ui_predator_missile", 1 );
            killstreak_shared::function_9fc2f7ee10890d99( "hellstorm_missile" );
            markedgroups = killstreak_shared::function_a402a9f43d6f7512( "killstreak_shared", bundle.var_598d79add3230927, undefined, bundle.var_225c495bde49787b );
            var_361a7ab2055af3a = markedgroups.var_d164bd71a2690aba;
            thread function_fc87adc3374cc9b3( streakinfo, var_361a7ab2055af3a );
            self painvisionoff();
            killstreak_shared::killstreak_savenvgstate();
            pod thread function_1638fb886ca4c4df( streakinfo );
            pod thread function_dac27b2bebde9a8f( "disconnect" );
            pod thread function_dac27b2bebde9a8f( "joined_team" );
            pod thread function_dac27b2bebde9a8f( "joined_spectators" );
        }
        
        if ( level.var_80e306c723f24a10 && isdefined( bundle.var_5dbd007f427cc754 ) )
        {
            bundle.var_5dbd007f427cc754 = %"hash_170cd921569bfedb";
        }
        
        if ( isdefined( bundle.var_5dbd007f427cc754 ) )
        {
            self.animname = "Player 1";
            var_e7f6bb87b02e5208 = pod vehicle::is_vehicle();
            pod.animname = var_e7f6bb87b02e5208 ? "Vehicle 1" : "Prop 1";
            var_51dc6e1726cd0245 = bundle.var_1b5a05636a58f9dd ?? bundle.var_22d1b69bd691bbc6 ?? "veh_t10_mil_us_heli_heavy";
            introheli = utility::spawn_model( var_51dc6e1726cd0245 );
            introheli.animname = var_e7f6bb87b02e5208 ? "Prop 2" : "Prop 1";
            intro_start_time_fraction = level.hellstorm_intro_fraction ?? 0;
            introheli hide();
            introheli showtoplayer( self );
            fullscreenfxparams = { #visionsetname:undefined, #postfxbundlename:bundle.var_7310ae140fffa7ef };
            self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
            var_b59a72bf8a2b7b5c = { #angles:pod.angles, #origin:pod.origin };
            var_b59a72bf8a2b7b5c thread scene::play( [ self, pod, introheli ], "shot_010", bundle.var_5dbd007f427cc754, intro_start_time_fraction );
            sceneduration = ( 1 - intro_start_time_fraction ) * var_b59a72bf8a2b7b5c scene::function_b3c7b792a7a154fa( "shot_010" ) - 0.5;
            sceneduration = max( sceneduration, 0.5 );
            thread function_bfce7dec0cb388ea( pod );
            assert( isdefined( bundle.var_ff967289b663f84c ) );
            modelname = ( level.var_80e306c723f24a10 ? bundle.var_c976e45cd01d5cea : bundle.var_ff967289b663f84c ) ?? "wmd_vm_missile_cruise_warhead_mp";
            self prestreamasset( "model", modelname, 10000 );
            var_3d716ff9288f9fd = undefined;
            
            if ( getdvarint( @"hash_48644484b2c4a3c9", 1 ) > 0 && !bundle.var_3aae7adbc47d88ec )
            {
                var_3d716ff9288f9fd = utility::spawn_model( modelname );
                linktag = pod tagexists( #"tag_body_animate" ) ? #"tag_body_animate" : #"tag_origin";
                var_3d716ff9288f9fd linkto( pod, linktag, ( bundle.var_689a3c831b486096 ?? 1200, 0, bundle.var_689a3a831b485c30 ?? 50 ), ( 0, bundle.var_8ad3b1079884cc08 ?? 180, 0 ) );
                var_3d716ff9288f9fd hide();
                var_3d716ff9288f9fd thread function_1a5d0db25aeb9d16( self, bundle.var_67be6ecfcdc5fd7b ?? 0 );
            }
            
            if ( level.gametypebundle.var_711e33239e4c9925 )
            {
                assert( !isdefined( self.var_8598ad3c49553a06 ) );
                assert( !callback::exists( #"killstreak_cancel", &function_729cab8fd1cf366f ) );
                self.var_8598ad3c49553a06 = { #streakinfo:streakinfo, #var_b59a72bf8a2b7b5c:var_b59a72bf8a2b7b5c, #var_3d716ff9288f9fd:var_3d716ff9288f9fd, #introheli:introheli, #var_8f2f51cf1451a6e5:pod };
                callback::add( #"killstreak_cancel", &function_729cab8fd1cf366f );
            }
            
            transitionstyle = #"nofadetoblack";
            
            if ( transitionstyle == #"fadetoblack" )
            {
                var_c06180c7ac436579 = 0.3;
                var_dc99fa164f8c246c = sceneduration - var_c06180c7ac436579;
                namespace_9d8e359c3b1041e5::waittill_notify_or_timeout_hostmigration_pause( "killstreak_cancel", var_dc99fa164f8c246c );
                thread function_83cde0ea9ab22231( 0.4, 0.6, 0.4 );
                namespace_9d8e359c3b1041e5::waittill_notify_or_timeout_hostmigration_pause( "killstreak_cancel", var_c06180c7ac436579 );
            }
            else
            {
                childthread function_bc72cd7170212591( bundle, sceneduration - 1 );
                namespace_9d8e359c3b1041e5::waittill_notify_or_timeout_hostmigration_pause( "killstreak_cancel", sceneduration );
            }
            
            self notify( #"hash_b08f65b7c271cdde" );
            introheli delete();
            
            if ( isdefined( var_3d716ff9288f9fd ) )
            {
                level thread function_891322c93832488a( var_3d716ff9288f9fd );
            }
        }
        
        if ( self )
        {
            self.var_8ff71ee2591d99a9 = 0;
        }
    }
    
    if ( self )
    {
        thread hellstormmissile_takecontrol( pod, streakinfo, thirdperson, var_361a7ab2055af3a );
    }
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0x5a751c91, Offset: 0x2109
// Size: 0x28
function private function_bc72cd7170212591( bundle, delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xe460089a, Offset: 0x2139
// Size: 0x79
function private function_1a5d0db25aeb9d16( player, delay )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self endon( #"death" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    self showtoplayer( player );
    waitframe();
    
    if ( self getscriptablepartstate( #"booster_visibility", 1 ) )
    {
        self setscriptablepartstate( #"booster_visibility", #"hide", 0 );
    }
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xedf51f0e, Offset: 0x21ba
// Size: 0xec
function private function_fc87adc3374cc9b3( streakinfo, var_a713170297a2e4b )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hellstorm_missile_finished" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e, var_a713170297a2e4b );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x608e4a4d, Offset: 0x22ae
// Size: 0x1dc
function private function_729cab8fd1cf366f( params )
{
    self cameraunlink();
    
    if ( self isvehicleactive() )
    {
        self leavevehicle( 0, 1 );
    }
    
    if ( isdefined( self.var_8598ad3c49553a06.var_b59a72bf8a2b7b5c ) )
    {
        self.var_8598ad3c49553a06.var_b59a72bf8a2b7b5c scene::stop();
    }
    
    self.var_8ff71ee2591d99a9 = 0;
    
    if ( isdefined( self.var_8598ad3c49553a06.var_8f2f51cf1451a6e5 ) )
    {
        if ( isdefined( self.soundent ) )
        {
            self.soundent stopsounds();
            self.soundent stoploopsound( self.soundent.playerloopsound );
            self.soundent delete();
        }
        
        if ( isdefined( self.var_8598ad3c49553a06.fxent ) )
        {
            self.var_8598ad3c49553a06.fxent delete();
        }
        
        if ( isdefined( self.var_8598ad3c49553a06.streakinfo ) )
        {
            self.var_8598ad3c49553a06.var_8f2f51cf1451a6e5 function_2c66bf200b36b129( self.var_8598ad3c49553a06.streakinfo );
        }
        
        if ( isdefined( self.var_8598ad3c49553a06.var_8f2f51cf1451a6e5 ) )
        {
            self.var_8598ad3c49553a06.var_8f2f51cf1451a6e5 delete();
        }
    }
    
    if ( isdefined( self.var_8598ad3c49553a06.introheli ) )
    {
        self.var_8598ad3c49553a06.introheli delete();
    }
    
    if ( isdefined( self.var_8598ad3c49553a06.var_3d716ff9288f9fd ) )
    {
        level thread function_891322c93832488a( self.var_8598ad3c49553a06.var_3d716ff9288f9fd );
    }
    
    function_ec4ca176d4a6aee0( self.var_8598ad3c49553a06.streakinfo );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x73571e4e, Offset: 0x2492
// Size: 0x1f
function private function_891322c93832488a( var_3d716ff9288f9fd )
{
    wait 0.5;
    
    if ( isdefined( var_3d716ff9288f9fd ) )
    {
        var_3d716ff9288f9fd delete();
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xa0ff2ec4, Offset: 0x24b9
// Size: 0x7a
function private function_bfce7dec0cb388ea( pod )
{
    pod endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_b08f65b7c271cdde" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        pod waittill( #"hash_b1defaf0b1af1888", rumblename );
        self playrumbleonpositionforclient( rumblename ?? "artillery_rumble", pod.origin );
    }
}

// Namespace hellstorm_missile
// Params 3, eflags: 0x4
// Checksum 0x9bd6a6d2, Offset: 0x253b
// Size: 0x755
function private function_72dc6df00aed003d( enemies, missile, streakinfo )
{
    self endon( #"disconnect" );
    missile endon( #"death" );
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    assert( isdefined( bundle ), "<dev string:x24>" );
    
    if ( !isdefined( bundle ) )
    {
        bundle = spawnstruct();
    }
    
    var_eb7637b38fd11de3 = bundle.var_1d06cd8110cc6b2d ?? 3;
    slowspeed = bundle.var_32828482a47425f8 ?? 60;
    normalspeed = bundle.var_a1f602144f02732 ?? 120;
    fastspeed = bundle.var_f431bacd9f4df2af ?? 200000;
    lockedonenemy = undefined;
    var_97c9f103b38dfc1 = undefined;
    var_6ff734f3f26bf897 = [];
    var_fc001412d29c37dd = 0;
    self setclientomnvar( "ui_killstreak_clusters_bomb", var_fc001412d29c37dd );
    previsattackbuttonpressed = 0;
    isattackbuttonpressed = 0;
    stayboosted = 0;
    currentdesiredspeed = normalspeed;
    dotthreshold = cos( 20 );
    function_aacc2a717c9352a5( missile, normalspeed );
    var_4a98f50083ff3e8d = makeweapon( bundle.var_e00730f7172b3226 );
    var_51ddf299be996210 = [ #"tag_small_missile_d", #"tag_small_missile_b", #"tag_small_missile_a", #"tag_small_missile_c" ];
    var_d27001f4477ddce6 = [ #"small_missile_b", #"small_missile_d", #"small_missile_a", #"small_missile_c" ];
    missile utility::callsharedfunc( #"vehicle", #"vehicleshowonminimap", 1 );
    var_1e93e3e55b805dd9 = undefined;
    
    while ( true )
    {
        if ( !stayboosted )
        {
            currentdesiredspeed = normalspeed;
            fov = "hellstorm_missile_default";
            
            if ( self sprintbuttonpressed() )
            {
                currentdesiredspeed = fastspeed;
                fov = "hellstorm_missile_zoom_out";
                stayboosted = 1;
                missile setscriptablepartstate( #"air_brakes", #"release_brakes" );
                self playrumbleonpositionforclient( "artillery_rumble", missile.origin );
                
                if ( missile getscriptablehaspart( #"boost" ) )
                {
                    missile setscriptablepartstate( #"boost", #"on" );
                }
            }
            else if ( self adsbuttonpressed() )
            {
                currentdesiredspeed = slowspeed;
                fov = "hellstorm_missile_zoom_in";
                missile setscriptablepartstate( #"air_brakes", #"apply_brakes" );
            }
            else
            {
                missile setscriptablepartstate( #"air_brakes", #"release_brakes" );
            }
            
            if ( var_1e93e3e55b805dd9 != currentdesiredspeed )
            {
                function_aacc2a717c9352a5( missile, currentdesiredspeed );
                var_1e93e3e55b805dd9 = currentdesiredspeed;
            }
            
            function_cde840c576d21d4d( fov );
        }
        
        var_cc45b86486ddd697 = 0;
        previsattackbuttonpressed = isattackbuttonpressed;
        isattackbuttonpressed = self attackbuttonpressed();
        
        if ( isattackbuttonpressed != previsattackbuttonpressed )
        {
            if ( isattackbuttonpressed )
            {
                /#
                    if ( getdvarint( @"scr_debug_hellstorm", 0 ) )
                    {
                        function_c5068642fe086f78( missile );
                    }
                #/
                
                if ( var_fc001412d29c37dd < var_eb7637b38fd11de3 && !streakinfo.var_d21dd966482847f0 )
                {
                    var_cc45b86486ddd697 = 1;
                }
                
                /#
                    if ( getdvarint( @"scr_debug_hellstorm", 0 ) )
                    {
                        println( "<dev string:x4d>" );
                        iprintln( "<dev string:x4d>" );
                    }
                #/
            }
            else
            {
                /#
                    if ( getdvarint( @"scr_debug_hellstorm", 0 ) )
                    {
                        println( "<dev string:x6b>" );
                        iprintln( "<dev string:x6b>" );
                    }
                #/
            }
        }
        
        if ( isdefined( enemies ) )
        {
            if ( isdefined( lockedonenemy ) )
            {
                if ( !lockedonenemy namespace_9d8e359c3b1041e5::isalivesharedfunc() )
                {
                    lockedonenemy = undefined;
                    var_bfaf0bfa81bdb920 = undefined;
                }
            }
            
            maxdot = -2;
            missileforward = anglestoforward( missile.angles );
            var_fc166872231b109e = missile.origin + missileforward * 250;
            now = gettime();
            
            if ( !isdefined( lockedonenemy ) || var_97c9f103b38dfc1 < now )
            {
                var_933aef90a70f2fc4 = lockedonenemy;
                lockedonenemy = undefined;
                
                foreach ( targetenemy in enemies )
                {
                    if ( !targetenemy namespace_9d8e359c3b1041e5::isalivesharedfunc() )
                    {
                        continue;
                    }
                    
                    enemyentnum = targetenemy getentitynumber();
                    
                    if ( var_6ff734f3f26bf897[ enemyentnum ] > now )
                    {
                        continue;
                    }
                    
                    if ( targetenemy killstreak_shared::function_5a4e3aca08ef7a29( self ) )
                    {
                        continue;
                    }
                    
                    var_773d28b0c31914a6 = vectornormalize( targetenemy.origin - missile.origin );
                    enemydot = vectordot( missileforward, var_773d28b0c31914a6 );
                    
                    if ( enemydot < dotthreshold )
                    {
                        continue;
                    }
                    
                    if ( enemydot > maxdot )
                    {
                        maxdot = enemydot;
                        lockedonenemy = targetenemy;
                    }
                }
                
                if ( isdefined( lockedonenemy ) )
                {
                    if ( !( var_933aef90a70f2fc4 === lockedonenemy ) )
                    {
                        var_97c9f103b38dfc1 = now + 1000;
                        var_bfaf0bfa81bdb920 = lockedonenemy;
                        var_bfaf0bfa81bdb920 killstreak_shared::function_70e34750441c92eb( self );
                    }
                }
            }
        }
        
        if ( var_cc45b86486ddd697 )
        {
            if ( isdefined( var_bfaf0bfa81bdb920 ) )
            {
                var_1c51980e61de8c = var_51ddf299be996210[ var_fc001412d29c37dd ];
                var_122b5b78b30f428a = var_d27001f4477ddce6[ var_fc001412d29c37dd ];
                
                if ( isdefined( var_122b5b78b30f428a ) )
                {
                    missile setscriptablepartstate( var_122b5b78b30f428a, #"fire" );
                }
                
                var_fc001412d29c37dd++;
                self setclientomnvar( "ui_killstreak_clusters_bomb", var_fc001412d29c37dd );
                enemyentnum = var_bfaf0bfa81bdb920 getentitynumber();
                var_6ff734f3f26bf897[ enemyentnum ] = gettime() + 1000;
                
                /#
                    if ( getdvarint( @"scr_debug_hellstorm", 0 ) )
                    {
                        sphere( var_bfaf0bfa81bdb920.origin, 20, ( 1, 0, 0 ), 0, 100 );
                        line( missile.origin, var_bfaf0bfa81bdb920.origin, ( 1, 0, 0 ), 1, 0, 100 );
                    }
                #/
                
                var_aa4773f1c142a864 = var_fc166872231b109e;
                
                if ( isdefined( var_1c51980e61de8c ) && missile tagexists( var_1c51980e61de8c ) )
                {
                    var_aa4773f1c142a864 = missile gettagorigin( var_1c51980e61de8c ) + missileforward * 350;
                }
                
                var_9f74d100c16605dd = var_bfaf0bfa81bdb920.origin;
                clusterbomb = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( var_4a98f50083ff3e8d, var_aa4773f1c142a864, var_9f74d100c16605dd, missile );
                clusterbomb.streakinfo = missile.streakinfo;
                clusterbomb missile_settargetent( var_bfaf0bfa81bdb920 );
                clusterbomb.var_57fc77af24a8791e = &function_e2541b90894a1bc;
                clusterbomb thread function_3a2b39f3235abff9( var_bfaf0bfa81bdb920 );
                self playrumbleonpositionforclient( "defaultweapon_fire", missile.origin );
                
                if ( isdefined( bundle.impacticon ) )
                {
                    clusterbomb namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
                    clusterbomb namespace_9d8e359c3b1041e5::setmissileimpactminimapiconsharedfunc( bundle.impacticon );
                }
                
                /#
                    if ( getdvarint( @"scr_debug_hellstorm", 0 ) )
                    {
                        iprintln( "<dev string:x8a>" + string( enemyentnum ) + "<dev string:x9c>", var_aa4773f1c142a864, var_9f74d100c16605dd );
                    }
                #/
                
                var_bfaf0bfa81bdb920 = undefined;
                lockedonenemy = undefined;
                var_933aef90a70f2fc4 = undefined;
            }
        }
        
        function_96e451070be939b1( missile, streakinfo );
        waitframe();
    }
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xbd236de3, Offset: 0x2c98
// Size: 0x73
function private function_96e451070be939b1( missile, streakinfo )
{
    if ( streakinfo.var_3c1228fe065ebc5f )
    {
        var_68901e5e7832ff80 = missile vehicle_getinputvalue( 6 );
        var_caefadbc469aee63 = missile vehicle_getinputvalue( 2 );
        
        if ( var_68901e5e7832ff80 != 0 || var_caefadbc469aee63 != 0 )
        {
            missile playrumblelooponentity( "steerable_missile" );
            return;
        }
        
        missile stoprumble( "steerable_missile" );
    }
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xfde13eeb, Offset: 0x2d13
// Size: 0x46
function private function_aacc2a717c9352a5( missile, speed )
{
    if ( missile.var_77ff08dd90ccd98c )
    {
        missile rcplane_setminspeed( speed );
        missile rcplane_settopspeed( speed );
        missile rcplane_settopspeedboost( speed );
        return;
    }
    
    missile vehicle_settopspeedforward( speed );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x27bc1772, Offset: 0x2d61
// Size: 0x2e
function private function_cde840c576d21d4d( fovpreset )
{
    if ( isdefined( fovpreset ) )
    {
        utility::callsharedfunc( #"hellstorm_missile", #"setfovpreset", self, fovpreset );
    }
}

// Namespace hellstorm_missile
// Params 3, eflags: 0x4
// Checksum 0x4c9e34c6, Offset: 0x2d97
// Size: 0x3ac
function private hellstormmissile_spawnvehicle( pod, streakinfo, initialspeed )
{
    var_77ff08dd90ccd98c = 1;
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    assert( isdefined( bundle.var_ff967289b663f84c ) );
    modelname = ( level.var_80e306c723f24a10 ? bundle.var_c976e45cd01d5cea : bundle.var_ff967289b663f84c ) ?? "wmd_vm_missile_cruise_warhead_mp";
    assert( isdefined( bundle.var_d27d55fd858e0f2e ) );
    vehiclename = ( level.var_80e306c723f24a10 ? bundle.var_a6b7d9dad0a3cb44 : bundle.var_d27d55fd858e0f2e ) ?? "veh_hellstorm_missile_mp";
    
    if ( var_77ff08dd90ccd98c )
    {
        vehiclename = "veh_hellstorm_missile_deprecated";
    }
    
    pod.bundle = bundle;
    missileinittrans = utility::callsharedfunc( #"hellstorm_missile", #"missileinittrans", pod );
    utility::callsharedfunc( #"hellstorm_missile", #"removefakemissile", pod );
    spawndata = spawnstruct();
    spawndata.origin = missileinittrans.origin;
    
    if ( var_77ff08dd90ccd98c )
    {
        spawndata.modelname = modelname;
    }
    
    spawndata.vehicletype = vehiclename;
    spawndata.targetname = "rcplane";
    spawndata.angles = missileinittrans.angles;
    spawndata.owner = self;
    
    if ( isdefined( initialspeed ) )
    {
        spawndata.initialvelocity = anglestoforward( spawndata.angles ) * initialspeed;
        spawndata.origin += spawndata.initialvelocity * 17.6 * level.framedurationseconds;
    }
    
    faildata = spawnstruct();
    missile = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    missile.var_77ff08dd90ccd98c = var_77ff08dd90ccd98c;
    
    if ( !isdefined( missile ) )
    {
        /#
            thread utility::error( "<dev string:x9e>" );
        #/
        
        return;
    }
    
    missile hellstormmissile_setupdamagefunctionality( streakinfo.streakname );
    vehicle_tracking::register_instance( missile );
    streakinfo.shots_fired++;
    missile setotherent( self );
    missile setentityowner( self );
    missile.angles = spawndata.angles;
    missile.team = self.team;
    missile.owner = self;
    self.var_e73f627a785541a2[ "hellstorm_missile" ] = 0;
    missile.streakinfo = streakinfo;
    missile.lifetime = bundle.hellstormlifetime ?? 10;
    missile.weapon_name = bundle.projectileweapon;
    missile.isprojectile = 1;
    missile.var_37ea0fa5533244a1 = 1;
    missile.var_57fc77af24a8791e = &function_e2541b90894a1bc;
    missile.maxhealth = bundle.maxhealth ?? 1000;
    missile.health = int( missile.maxhealth );
    missile.currenthealth = missile.maxhealth;
    missile setcandamage( istrue( bundle.candamage ) );
    vehicle_tracking::function_4f76f5b4541acef1();
    return missile;
}

// Namespace hellstorm_missile
// Params 0, eflags: 0x4
// Checksum 0xccf587a6, Offset: 0x314c
// Size: 0x35
function private function_e2541b90894a1bc()
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self.owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( self.streakinfo, undefined, #"hit", 0 );
}

// Namespace hellstorm_missile
// Params 4
// Checksum 0x6d30cef, Offset: 0x3189
// Size: 0x89b
function hellstormmissile_takecontrol( pod, streakinfo, thirdperson, var_361a7ab2055af3a )
{
    if ( isdefined( pod ) && !isstruct( pod ) )
    {
        pod endon( #"death" );
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    val::set( "hellstormMissile", "fire", 1 );
    self.var_30f2bdd931bb9ba1 = 1;
    initialspeed = 130;
    var_63b6b7b8163139d1 = pod vehicle::is_vehicle();
    missile = var_63b6b7b8163139d1 ? pod : hellstormmissile_spawnvehicle( pod, streakinfo, initialspeed );
    missile thread function_5e95fe7d59b2ef8b();
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_hellstorm", missile.origin, missile.team, missile.owner, missile );
    }
    
    function_aacc2a717c9352a5( missile, initialspeed );
    
    if ( isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        start_position = streakinfo.var_3748b8c29ef65e91[ 0 ];
        end_position = streakinfo.var_3748b8c29ef65e91[ 1 ];
        missile.origin = start_position;
        missile.angles = vectortoangles( vectornormalize( end_position - start_position ) );
        
        if ( isdefined( streakinfo.var_3748b8c29ef65e91[ 2 ] ) )
        {
            function_aacc2a717c9352a5( missile, streakinfo.var_3748b8c29ef65e91[ 2 ] );
        }
    }
    
    utility::callsharedfunc( #"hellstorm_missile", #"setmissilescriptablestate", missile );
    missile setvehicleteam( missile.team );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        missile [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 50 );
    }
    
    killcamtag = #"tag_player";
    var_1473f5202d85fb09 = missile gettagorigin( killcamtag, 1 );
    
    if ( !isdefined( var_1473f5202d85fb09 ) )
    {
        killcamtag = #"tag_origin";
        
        if ( !isdefined( var_1473f5202d85fb09 ) )
        {
            var_1473f5202d85fb09 = missile gettagorigin( killcamtag );
        }
    }
    
    missile.var_791e0897097155a2 = killcamtag;
    missile.killcament = spawn( "script_model", var_1473f5202d85fb09 );
    missile.killcament setmodel( "tag_origin" );
    missile.killcament linkto( missile, killcamtag );
    missile.killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "missile", 0, 0 );
    missile endon( #"death" );
    missile namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( missile, &hellstormmissile_empapplied );
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    assert( isdefined( bundle.var_3531c62e95980045 ) );
    var_ab9d6a38be1c915a = bundle.var_3531c62e95980045 ?? "ks_cruise_predator_mp";
    var_6478ce2c2fd2c163 = missile tagexists( #"tag_body" ) ? #"tag_body" : #"tag_origin";
    fxent = spawn( "script_model", missile gettagorigin( var_6478ce2c2fd2c163 ) );
    fxent setmodel( var_ab9d6a38be1c915a );
    fxent.angles = missile gettagangles( var_6478ce2c2fd2c163 );
    fxent.team = missile.team;
    fxent.owner = missile.owner;
    fxent.streakinfo = missile.streakinfo;
    fxent linkto( missile, var_6478ce2c2fd2c163 );
    fxent setotherent( self );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        assert( callback::exists( #"killstreak_cancel", &function_729cab8fd1cf366f ) );
        callback::remove( #"killstreak_cancel", &function_729cab8fd1cf366f );
        self.var_8598ad3c49553a06 = { #streakinfo:streakinfo, #fxent:fxent, #var_8f2f51cf1451a6e5:missile };
        callback::add( #"killstreak_cancel", &function_729cab8fd1cf366f );
    }
    
    if ( streakinfo.var_f916c2b02f7e0e4c && missile getscriptablehaspart( "fake_trail" ) )
    {
        fxent.var_f916c2b02f7e0e4c = 1;
        missile setscriptablepartstate( "fake_trail", "on", 0 );
    }
    else
    {
        fxent setscriptablepartstate( "fake_trail", "on", 0 );
    }
    
    fxent thread function_c9fac59edc8bde59( streakinfo );
    fxent thread function_3d15bc551dbd3962( missile );
    fxent thread function_ca1755aa6608898d( missile, self, missile.killcament, thirdperson );
    missile thread function_dac27b2bebde9a8f( "disconnect" );
    missile thread function_dac27b2bebde9a8f( "joined_team" );
    missile thread function_dac27b2bebde9a8f( "joined_spectators" );
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) && -1 )
    {
        self startcameratween( 0.6, 1, "ease_out_sine" );
    }
    
    /#
        missile thread debugdrawmissile();
    #/
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        thread function_72dc6df00aed003d( var_361a7ab2055af3a, missile, streakinfo );
    }
    
    level thread function_2e5aa3088dacddb6( missile );
    
    if ( missile getscriptablehaspart( #"small_missile_cover_panels" ) )
    {
        missile setscriptablepartstate( #"small_missile_cover_panels", #"hidden" );
    }
    
    if ( !thirdperson && !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        self disablephysicaldepthoffieldscripting();
        
        if ( missile.var_77ff08dd90ccd98c )
        {
            self cameraunlink();
            self cameralinkto( missile, missile.var_791e0897097155a2 ?? #"tag_player", 1 );
        }
        
        if ( !var_63b6b7b8163139d1 )
        {
            self usevehicle( missile, 0 );
        }
        
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( spawnstruct() );
        fullscreenfxparams = { #visionsetname:level.var_53d61e37342749c2 ?? "cruise_color_mp", #postfxbundlename:bundle.var_8214d5448944811c };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
        self.soundent = spawn( "script_origin", missile.origin );
        self.soundent showonlytoplayer( self );
        bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
        self.soundent.var_5cc16a673bfd0f9c = bundle.var_97bf045a96f27cb0 ?? "ks_hellstorm_plr_start";
        
        if ( soundexists( self.soundent.var_5cc16a673bfd0f9c ) )
        {
            self.soundent playsound( self.soundent.var_5cc16a673bfd0f9c );
        }
        
        self.soundent.playerloopsound = bundle.var_28a0b6cd99487390 ?? "ks_hellstorm_plr_lp_f";
        
        if ( soundexists( self.soundent.playerloopsound ) )
        {
            self.soundent playloopsound( self.soundent.playerloopsound );
        }
        
        namespace_9d8e359c3b1041e5::shellshocksharedfunc( %"killstreak_veh_camera_mp", #"top", missile.lifetime, 0 );
        namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "on" );
        
        if ( !streakinfo.var_ec0738c69279f3a5 )
        {
            self setclientomnvar( "ui_predator_missile", 2 );
        }
        
        self setclientomnvar( "ui_killstreak_health", 1 );
        self setclientomnvar( "ui_killstreak_countdown", gettime() + int( 10000 ) );
        self setclientomnvar( "ui_predator_missiles_left", -1 );
    }
    
    missile thread function_ef4c200193c66192();
    randomindex = randomintrange( 1, 3 );
    missile namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "cruise_control_" + randomindex, #"control" );
    missile thread function_c0ab81e5633ee5cf( missile.lifetime );
    
    if ( !var_63b6b7b8163139d1 )
    {
        pod hide( 1 );
    }
    
    waitframe();
    
    if ( !var_63b6b7b8163139d1 && isdefined( pod ) )
    {
        wait 0.75;
        pod delete();
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xdf77d64a, Offset: 0x3a2c
// Size: 0xaa
function private function_2e5aa3088dacddb6( missile )
{
    if ( !missile getscriptablehaspart( #"missile_lift" ) )
    {
        return;
    }
    
    missile setscriptablepartstate( #"missile_lift", #"open" );
    
    if ( getdvarint( @"hash_98b8768f54529b8f", 1 ) > 0 )
    {
        waitframe();
        
        for ( attempts = 20; isdefined( missile ) && attempts > 0 ; attempts-- )
        {
            missile setscriptablepartstate( #"missile_lift", #"closed" );
            waitframe();
            
            if ( isdefined( missile ) )
            {
                missile setscriptablepartstate( #"missile_lift", #"open" );
            }
            
            waitframe();
        }
    }
}

// Namespace hellstorm_missile
// Params 1
// Checksum 0xe39a5560, Offset: 0x3ade
// Size: 0xc1
function function_ab2cfc2ac65594c9( missile )
{
    if ( missile getscriptablepartstate( #"booster_visibility", 1 ) )
    {
        missile setscriptablepartstate( #"booster_visibility", #"hide", 0 );
    }
    
    if ( missile getscriptablepartstate( #"thruster", 1 ) )
    {
        missile setscriptablepartstate( #"thruster", #"on", 0 );
    }
    
    if ( missile getscriptablepartstate( #"wing_trails", 1 ) )
    {
        missile setscriptablepartstate( #"wing_trails", #"on", 0 );
    }
    
    if ( missile getscriptablehaspart( #"boost" ) )
    {
        missile setscriptablepartstate( #"boost", #"off" );
    }
}

// Namespace hellstorm_missile
// Params 1
// Checksum 0x428440d4, Offset: 0x3ba7
// Size: 0xf5
function function_74c32d5981ff22eb( pod )
{
    if ( isstruct( pod ) )
    {
        trans = { #angles:pod.angles, #origin:pod.origin };
    }
    else
    {
        var_fe3253e0e92fab8f = pod tagexists( #"tag_body_animate" ) ? #"tag_body_animate" : #"tag_origin";
        trans = { #origin:pod gettagorigin( var_fe3253e0e92fab8f ) };
        foryaw = pod gettagangles( #"tag_origin" );
        forpitch = pod gettagangles( var_fe3253e0e92fab8f ) + ( pod.bundle.var_169a3352b6ad74ab ?? -360, 180, 0 );
        trans.angles = ( forpitch[ 0 ] * -1, foryaw[ 1 ], 0 );
    }
    
    return trans;
}

// Namespace hellstorm_missile
// Params 0, eflags: 0x4
// Checksum 0x67eddf30, Offset: 0x3ca5
// Size: 0x60
function private function_6f4c7462853ee3c8()
{
    if ( !isdefined( level.kill_border_triggers ) )
    {
        /#
            iprintln( "<dev string:xf0>" );
        #/
        
        return;
    }
    
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    
    while ( true )
    {
        if ( function_3b36aeb1b8decd38( level.kill_border_triggers ) )
        {
            self notify( #"explode" );
            break;
        }
        
        waitframe();
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xaa9346cf, Offset: 0x3d0d
// Size: 0x93
function private function_3b36aeb1b8decd38( triggerlist )
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

// Namespace hellstorm_missile
// Params 0, eflags: 0x4
// Checksum 0xff916204, Offset: 0x3da9
// Size: 0x41
function private function_ef4c200193c66192()
{
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 0.75 );
    self vehphys_enablecollisioncallback( 1 );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 1.25 );
    thread function_6f4c7462853ee3c8();
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x286e712f, Offset: 0x3df2
// Size: 0x10f
function private function_c9fac59edc8bde59( streakinfo )
{
    self endon( #"death" );
    self.owner endon( #"disconnect", #"hellstorm_missile_finished" );
    level waittill( #"game_ended" );
    
    if ( self.owner && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    if ( isdefined( self.owner.soundent ) )
    {
        self.owner.soundent stopsounds();
        self.owner.soundent stoploopsound( self.owner.soundent.playerloopsound );
        self.owner.soundent delete();
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x8a8a34ca, Offset: 0x3f09
// Size: 0x56
function private function_3d15bc551dbd3962( missile )
{
    self endon( #"death" );
    missile endon( #"cruise_missile_explode" );
    
    while ( true )
    {
        self.missilelastpos = missile.origin;
        self.missilelastangle = missile.angles;
        waitframe();
    }
}

// Namespace hellstorm_missile
// Params 4, eflags: 0x4
// Checksum 0xca600745, Offset: 0x3f67
// Size: 0x131
function private function_ca1755aa6608898d( missile, rider, killcament, thirdperson )
{
    missile endon( #"cruise_missile_explode" );
    missile.var_1d6e417ec5a9010e = rider;
    missile.var_a91e0415b1843197 = self;
    missile.var_a0bd9033f791c5aa = killcament;
    missile.var_2549decd41a8fab2 = thirdperson;
    
    while ( true )
    {
        explodeinfo = missile function_836bac52a379aaa6( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
        collisiondebug = getdvarint( @"scr_cruise_collision_debug", 0 );
        
        if ( explodeinfo.msg == "collision" )
        {
            surface = physics_getsurfacetypefromflags( explodeinfo.param4 );
            surfacetype = getsubstr( surface[ "name" ], 9 );
            
            if ( surfacetype == "glass_pane" )
            {
                continue;
            }
            
            /#
                if ( collisiondebug )
                {
                    iprintln( "<dev string:x126>" + surfacetype );
                }
            #/
        }
        
        break;
    }
    
    thread function_9a2400b456e38f61( missile, explodeinfo );
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0x3a870cd8, Offset: 0x40a0
// Size: 0x7aa
function private function_9a2400b456e38f61( missile, explodeinfo )
{
    if ( !isdefined( missile.var_a91e0415b1843197 ) )
    {
        return;
    }
    
    if ( missile.var_43fbe2d4e6182bd2 )
    {
        return;
    }
    
    missile.var_43fbe2d4e6182bd2 = 1;
    rider = missile.var_1d6e417ec5a9010e;
    killcament = missile.var_a0bd9033f791c5aa;
    fxent = missile.var_a91e0415b1843197;
    thirdperson = missile.var_2549decd41a8fab2;
    missile notify( #"cruise_missile_explode" );
    explodepos = undefined;
    missileangles = undefined;
    streakinfo = missile.streakinfo;
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    fxent thread function_307243dba288005c( 0.05, missile );
    
    if ( isdefined( rider ) )
    {
        rider killstreak_shared::function_76bbbe12ce816ed2();
        rider childthread killstreak_shared::function_b3302c4317df36c6();
        
        if ( utility::issharedfuncdefined( #"hellstorm_missile", #"cpunmarkenemies" ) )
        {
            [[ utility::getsharedfunc( #"hellstorm_missile", #"cpunmarkenemies" ) ]]( rider );
        }
    }
    
    camtype = 1;
    
    if ( isdefined( fxent ) )
    {
        explodepos = fxent.missilelastpos;
        missileangles = fxent.missilelastangle;
        utility::callsharedfunc( #"hellstorm_missile", #"explode", explodepos );
        utility::callsharedfunc( #"killstreak", #"killstreak_explosionnearai", explodepos, 1000, "allies", "hellstorm_missile" );
        
        if ( isdefined( rider ) && !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
        {
            if ( rider namespace_9d8e359c3b1041e5::isalivesharedfunc() && rider isvehicleactive() )
            {
                visionset = "killstreak_static";
                
                if ( camtype == 2 )
                {
                    visionset = "killstreak_flash";
                }
                
                if ( bundle.var_d30c20664d0c31fd )
                {
                    rider thread killstreak_utility::function_7018f59706013760( bundle );
                }
                else
                {
                    rider thread function_83cde0ea9ab22231( 0.4, 0.6, 0.05, visionset );
                    rider playlocalsound( "ks_sat_hellstorm_static_transition" );
                }
            }
        }
        
        if ( !isdefined( explodeinfo ) || explodeinfo.msg != "emp_defused" && explodeinfo.msg != "trophy_blocked" )
        {
            explosionradius = bundle.var_f099b3cc0d985576 ?? 600;
            var_a5bbb21ec2bc863f = bundle.var_6692da4d91ee65ea ?? 1000;
            var_a598a01ec29616f1 = bundle.var_66b5c44d92147d40 ?? 1000;
            var_c0180fae9381b5ba = "MOD_EXPLOSIVE";
            var_d74c2c09b82e0591 = bundle.projectileweapon;
            attacker = missile.explosionowner ?? rider;
            
            if ( attacker )
            {
                skipdamage = isdefined( explodeinfo ) && explodeinfo.msg == "disowned";
                
                if ( !skipdamage )
                {
                    if ( utility::issharedfuncdefined( #"hellstorm_missile", #"damageoverride" ) )
                    {
                        [[ utility::getsharedfunc( #"hellstorm_missile", #"damageoverride" ) ]]( explodepos, explosionradius, var_a5bbb21ec2bc863f, var_a598a01ec29616f1, attacker, var_c0180fae9381b5ba, var_d74c2c09b82e0591, missile );
                    }
                    else
                    {
                        missile radiusdamage( explodepos, explosionradius, var_a5bbb21ec2bc863f, var_a598a01ec29616f1, attacker, var_c0180fae9381b5ba, var_d74c2c09b82e0591 );
                    }
                }
                
                players = utility::playersinsphere( explodepos, explosionradius );
                
                foreach ( player in players )
                {
                    if ( player namespace_9d8e359c3b1041e5::isalivesharedfunc() && player_utility::playersareenemies( player, attacker ) )
                    {
                        if ( utility::issharedfuncdefined( #"sound", #"trysaylocalsound" ) )
                        {
                            level thread [[ utility::getsharedfunc( #"sound", #"trysaylocalsound" ) ]]( player, #"bc_flavor_player_closecall", 1 );
                        }
                    }
                }
            }
        }
        
        wait 0.1;
        
        if ( rider )
        {
            if ( missile.var_77ff08dd90ccd98c )
            {
                rider cameraunlink();
            }
            
            if ( rider namespace_9d8e359c3b1041e5::isalivesharedfunc() && rider isvehicleactive() )
            {
                rider leavevehicle();
            }
        }
        
        if ( isdefined( missile ) )
        {
            vehicle_tracking::deregister_instance( missile );
            vehicle_tracking::delete_vehicle( missile );
        }
        
        namespace_9d8e359c3b1041e5::shellshock_artilleryearthquakesharedfunc( explodepos, 1 );
        
        if ( isdefined( fxent ) )
        {
            fxent thread function_203d7c05622dc37d( explodeinfo );
        }
    }
    
    if ( utility::issharedfuncdefined( #"hellstorm_missile", #"eventrecord" ) )
    {
        [[ utility::getsharedfunc( #"hellstorm_missile", #"eventrecord" ) ]]( explodepos );
    }
    
    if ( isdefined( rider ) && !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        rider thread function_c582caa7c522d7b3( explodeinfo, streakinfo );
        
        if ( !thirdperson )
        {
            assert( isdefined( explodepos ) && isdefined( missileangles ), "<dev string:x151>" );
            
            if ( isdefined( rider.soundent ) )
            {
                rider.soundent stoploopsound( rider.soundent.playerloopsound );
                rider.soundent delete();
            }
            
            rider namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( streakinfo.streakname, "off" );
            rider setclientomnvar( "ui_predator_missile", 0 );
            explosioncam = spawn( "script_model", explodepos );
            explosioncam setmodel( "tag_player" );
            distoffset = getdvarint( @"hash_3a9a76ce997f682b", 1000 );
            heightoffset = getdvarint( @"hash_5c31e35b791afd24", 0 );
            missileforward = anglestoforward( missileangles );
            newcampos = explodepos - missileforward * distoffset;
            newheightoffset = ( 0, 0, heightoffset );
            var_5244296b8dbd1bc5 = newcampos + newheightoffset;
            explosioncam.angles = vectortoangles( explodepos + ( 0, 0, 150 ) - var_5244296b8dbd1bc5 );
            
            if ( isdefined( killcament ) )
            {
                killcament unlink();
                killcament linkto( explosioncam, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            explosioncam.origin = var_5244296b8dbd1bc5;
            
            if ( missile.var_77ff08dd90ccd98c )
            {
                rider cameralinkto( explosioncam, "tag_player" );
            }
            
            if ( !level.gameended )
            {
                thread function_122682d1e86bb65( explodepos, rider, streakinfo );
            }
            
            rider notify( #"hellstorm_missile_finished" );
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hellstormendfunc" ) )
            {
                rider thread [[ utility::getsharedfunc( #"killstreak", #"hellstormendfunc" ) ]]();
            }
            
            rider function_ec4ca176d4a6aee0( streakinfo, explosioncam );
            rider namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
        }
    }
    
    if ( isdefined( killcament ) )
    {
        killcament delete();
    }
    
    if ( isdefined( rider ) )
    {
        if ( utility::issharedfuncdefined( #"hellstorm_missile", #"removeitemfromslot" ) )
        {
            [[ utility::getsharedfunc( #"hellstorm_missile", #"removeitemfromslot" ) ]]( rider );
        }
        
        rider notify( #"killstreak_end_active_state" );
        rider setclientomnvar( "ui_killstreak_clusters_bomb", 0 );
        rider setclientomnvar( "ui_killstreak_weapon_1_ammo", 0 );
    }
    
    self.var_30f2bdd931bb9ba1 = undefined;
}

// Namespace hellstorm_missile
// Params 3, eflags: 0x4
// Checksum 0x697e5070, Offset: 0x4852
// Size: 0x13a
function private function_122682d1e86bb65( explodepos, rider, streakinfo )
{
    nearplayers = utility::playersinsphere( explodepos, 2000 );
    
    foreach ( player in nearplayers )
    {
        if ( !isdefined( player ) || !player namespace_9d8e359c3b1041e5::isalivesharedfunc() || player == rider )
        {
            continue;
        }
        
        player earthquakeforplayer( 0.3, 2, player.origin, 100 );
        player playrumbleonpositionforclient( "artillery_rumble", player.origin );
    }
    
    rider earthquakeforplayer( 0.3, 3, rider.origin, 100 );
    rider playrumbleonpositionforclient( "artillery_rumble", rider.origin );
    
    if ( !isdefined( streakinfo.var_3748b8c29ef65e91 ) )
    {
        rider thread function_e2e76b88b9adef19( 1 );
    }
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xfeff9b57, Offset: 0x4994
// Size: 0x64
function private function_307243dba288005c( delay, missile )
{
    self endon( #"death" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( self.var_f916c2b02f7e0e4c && isdefined( missile ) )
    {
        missile setscriptablepartstate( "fake_trail", "off", 0 );
        return;
    }
    
    self setscriptablepartstate( "fake_trail", "off", 0 );
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0x5d2e54d8, Offset: 0x4a00
// Size: 0x169
function private function_ec4ca176d4a6aee0( streakinfo, explosioncam )
{
    profilestart();
    utility::callsharedfunc( #"hellstorm_missile", #"setfovpreset", self, "default" );
    val::set( "hellstorm_active", "killstreaks", 1 );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    namespace_9d8e359c3b1041e5::stopshellshocksharedfunc();
    self cameraunlink();
    
    if ( isdefined( explosioncam ) )
    {
        explosioncam delete();
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    modelname = ( level.var_80e306c723f24a10 ? bundle.var_c976e45cd01d5cea : bundle.var_ff967289b663f84c ) ?? "wmd_vm_missile_cruise_warhead_mp";
    self prestreamasset( "model", modelname, -1 );
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( {} );
    val::group_reset( "hellstormMissile" );
    self painvisionoff();
    killstreak_shared::killstreak_restorenvgstate();
    level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        callback::remove( #"killstreak_cancel", &function_729cab8fd1cf366f );
        self.var_8598ad3c49553a06 = undefined;
    }
    
    profilestop();
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x1b5f5fb, Offset: 0x4b71
// Size: 0x36
function private function_c0ab81e5633ee5cf( duration )
{
    self endon( #"death" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( duration );
    self notify( #"explode", self.origin );
}

// Namespace hellstorm_missile
// Params 1
// Checksum 0xf7eb3513, Offset: 0x4baf
// Size: 0xb6
function function_dac27b2bebde9a8f( action )
{
    self endon( #"death" );
    self endon( #"disowned" );
    level endon( #"game_ended" );
    missileowner = self.owner;
    missileowner waittill( action );
    
    if ( action == "disconnect" )
    {
        if ( isdefined( missileowner.soundent ) )
        {
            missileowner.soundent stopsounds();
            missileowner.soundent stoploopsound( missileowner.soundent.playerloopsound );
            missileowner.soundent delete();
        }
    }
    
    self notify( #"disowned" );
}

// Namespace hellstorm_missile
// Params 4, eflags: 0x4
// Checksum 0x239d12da, Offset: 0x4c6d
// Size: 0x88
function private function_83cde0ea9ab22231( fadeintime = 0.5, fadedelay = 0.5, fadeouttime = 0.05, var_5992112f2391b634 )
{
    if ( isdefined( var_5992112f2391b634 ) )
    {
        namespace_9d8e359c3b1041e5::killstreak_setmainvisionsharedfunc( var_5992112f2391b634 );
        wait fadedelay;
        namespace_9d8e359c3b1041e5::killstreak_setmainvisionsharedfunc( "" );
        return;
    }
    
    level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( self, 1, fadeintime );
    wait fadedelay;
    level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( self, 0, fadeouttime );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xada6e52f, Offset: 0x4cfd
// Size: 0x5f
function private function_e2e76b88b9adef19( shaketime )
{
    self endon( #"disconnect" );
    self endon( #"killstreak_cancel" );
    counter = 0;
    
    while ( counter < shaketime )
    {
        self playrumbleonpositionforclient( "damage_light", self.origin );
        counter += 0.05;
        wait 0.05;
    }
}

// Namespace hellstorm_missile
// Params 6
// Checksum 0xfb61d16, Offset: 0x4d64
// Size: 0x1ac
function function_836bac52a379aaa6( var_19eee95063be9ec9, var_19eee65063be9830, var_19eee75063be9a63, var_19eeec5063bea562, var_19eeed5063bea795, var_19eeea5063bea0fc )
{
    ent = spawnstruct();
    
    if ( isdefined( var_19eee95063be9ec9 ) )
    {
        thread waittill_explodestring( var_19eee95063be9ec9, ent );
    }
    
    if ( isdefined( var_19eee65063be9830 ) )
    {
        thread waittill_explodestring( var_19eee65063be9830, ent );
    }
    
    if ( isdefined( var_19eee75063be9a63 ) )
    {
        thread waittill_explodestring( var_19eee75063be9a63, ent );
    }
    
    if ( isdefined( var_19eeec5063bea562 ) )
    {
        thread waittill_explodestring( var_19eeec5063bea562, ent );
    }
    
    if ( isdefined( var_19eeed5063bea795 ) )
    {
        thread waittill_explodestring( var_19eeed5063bea795, ent );
    }
    
    if ( isdefined( var_19eeea5063bea0fc ) )
    {
        thread waittill_explodestring( var_19eeea5063bea0fc, ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( #"die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace hellstorm_missile
// Params 2
// Checksum 0x52cb7dd2, Offset: 0x4f19
// Size: 0x89
function waittill_explodestring( msg, ent )
{
    self endon( #"death" );
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xcdf65af0, Offset: 0x4faa
// Size: 0x1a5
function private function_203d7c05622dc37d( explodeinfo )
{
    self endon( #"death" );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    if ( !isdefined( explodeinfo ) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked" )
    {
        self setscriptablepartstate( "air_explosion", "on", 0 );
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 0.2 );
        self delete();
    }
    
    if ( isvector( explodeinfo.param5 ) && utility::ispointinwater( explodeinfo.param5 ) )
    {
        self setscriptablepartstate( "water_explosion", "on", 0 );
        explotype = #"water";
    }
    else
    {
        worldup = ( 0, 0, 1 );
        surfacenormal = explodeinfo.param6;
        angledirection = vectordot( surfacenormal, worldup );
        
        if ( angledirection >= 0.7 )
        {
            self setscriptablepartstate( "ground_explosion", "on", 0 );
            explotype = #"ground";
        }
        else
        {
            self setscriptablepartstate( "air_explosion", "on", 0 );
            explotype = #"air";
        }
    }
    
    /#
        if ( getdvarint( @"hash_348de87258fbac1e", 0 ) != 0 )
        {
            function_5f060bc92fedfaab( explotype );
        }
    #/
    
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 1 );
    self delete();
}

// Namespace hellstorm_missile
// Params 2, eflags: 0x4
// Checksum 0xb6d06317, Offset: 0x5157
// Size: 0xa9
function private function_c582caa7c522d7b3( explodeinfo, streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"killstreak_cancel" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 1 );
    
    if ( !isdefined( streakinfo.kills ) || streakinfo.kills == 0 )
    {
        dialogueref = "hit_none";
    }
    else
    {
        dialogueref = streakinfo.kills > 3 ? "kill_multiple" : "kill_" + streakinfo.kills;
    }
    
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, undefined, getxhash( dialogueref ), 1 );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x41aa8da, Offset: 0x5208
// Size: 0x1d
function private hellstormmissile_empapplied( data )
{
    if ( isdefined( self ) )
    {
        self notify( #"emp_defused" );
    }
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xf9ca173e, Offset: 0x522d
// Size: 0xa0
function private hellstormmissile_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = undefined;
    var_d188942a41771ea1 = undefined;
    premoddamagecallback = &function_ce078f3a7f514ecb;
    postmoddamagecallback = &function_c5f9831848df79d6;
    deathcallback = &hellstormmissile_handledeathdamage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x10491ea8, Offset: 0x52d5
// Size: 0xc4, Type: bool
function private function_ce078f3a7f514ecb( data )
{
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "hellstorm_missile" ];
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    
    return true;
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x1a00edb6, Offset: 0x53a2
// Size: 0x4a, Type: bool
function private function_c5f9831848df79d6( data )
{
    damage = data.damage;
    self.currenthealth -= damage;
    namespace_9d8e359c3b1041e5::killstreak_updatedamagestatesharedfunc( self.currenthealth );
    return true;
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0xa1f64f28, Offset: 0x53f5
// Size: 0xfd
function private hellstormmissile_handledeathdamage( data )
{
    if ( !isent( self ) )
    {
        return 0;
    }
    
    if ( self.isdying )
    {
        return;
    }
    
    self.isdying = 1;
    self notify( #"enemy_destroyed_equipment", data.attacker );
    self.killedbyweapon = data.objweapon;
    explodeinfo = spawnstruct();
    explodeinfo.msg = "explode";
    explodeinfo.param1 = self.origin;
    thread function_9a2400b456e38f61( self, explodeinfo );
    
    if ( data.attacker && self.streakinfo )
    {
        vodestroyed = "destroyed_" + self.streakinfo.streakname;
        self.owner killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, vodestroyed, #"destroyed" );
    }
    
    return 0;
}

// Namespace hellstorm_missile
// Params 2
// Checksum 0xb71c5fe7, Offset: 0x54fb
// Size: 0x1d
function function_c8ce0872c7f15dcb( player, fovpreset )
{
    player lerpfovbypreset( fovpreset );
}

// Namespace hellstorm_missile
// Params 0
// Checksum 0xfac5a8b6, Offset: 0x5520
// Size: 0x1a1
function function_eadce66a6aa319ca()
{
    assignments = killstreak_shared::function_4b478d49af66b9e5( 1 );
    bundle = killstreak::function_85b2d8e857ab4898( "hellstorm_missile" );
    
    if ( bundle.var_328920f545762b9b && bundle.var_f088013d20169bf3 == #"mod" )
    {
        return assignments;
    }
    
    foreach ( enemyhumanoid in assignments.var_d164bd71a2690aba )
    {
        if ( enemyhumanoid.juggcontext.hidefromhellstorm )
        {
            assignments.var_d164bd71a2690aba = arrayremove( assignments.var_d164bd71a2690aba, enemyhumanoid );
        }
    }
    
    foreach ( var_777098aa7d58bb16 in assignments.enemytargetmarkergroup )
    {
        if ( var_777098aa7d58bb16.juggcontext.hidefromhellstorm )
        {
            assignments.enemytargetmarkergroup = arrayremove( assignments.enemytargetmarkergroup, var_777098aa7d58bb16 );
        }
    }
    
    return assignments;
}

// Namespace hellstorm_missile
// Params 1, eflags: 0x4
// Checksum 0x850ec0bd, Offset: 0x56ca
// Size: 0x38
function private function_3a2b39f3235abff9( targetent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    targetent waittill( #"death" );
    self missile_cleartarget();
}

// Namespace hellstorm_missile
// Params 0, eflags: 0x4
// Checksum 0xdec5c841, Offset: 0x570a
// Size: 0x4d
function private function_5e95fe7d59b2ef8b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    utility::waittill_any_ents( level, "hellstorm_missile_early_quit", self.owner, "hellstorm_missile_early_quit" );
    self notify( #"explode" );
}

// Namespace hellstorm_missile
// Params 0, eflags: 0x4
// Checksum 0x29a1db3c, Offset: 0x575f
// Size: 0xc3
function private function_6f44a5ce1febb7b0()
{
    foreach ( player in level.players )
    {
        if ( player.var_8ff71ee2591d99a9 || player.var_30f2bdd931bb9ba1 )
        {
            player notify( #"cancel_all_killstreak_deployments" );
            player notify( #"hellstorm_missile_early_quit" );
            player cameraunlink();
            
            if ( player isvehicleactive() )
            {
                player leavevehicle( 0, 1 );
            }
        }
    }
}

// Namespace hellstorm_missile
// Params 2
// Checksum 0xe137a1e6, Offset: 0x582a
// Size: 0x4f
function hellstorm_missile_hack( hackeffect, attacker )
{
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
    }
    
    self.explosionowner = attacker;
}

/#

    // Namespace hellstorm_missile
    // Params 0, eflags: 0x4
    // Checksum 0x1a8561a6, Offset: 0x5881
    // Size: 0xcd, Type: dev
    function private debugdrawpod()
    {
        level notify( #"hash_984a588ddc13a80c" );
        level notify( #"hash_8500241a19a198a3" );
        level endon( #"hash_984a588ddc13a80c" );
        level.var_382e8897c7044c1b = [];
        
        if ( getdvarint( @"hash_bb7e1875b8c27444", 0 ) == 0 )
        {
            return;
        }
        
        level childthread function_6105816e3ed9b9f7();
        pod = self;
        
        do
        {
            level.var_382e8897c7044c1b[ gettime() ] = spawnstruct();
            level.var_382e8897c7044c1b[ gettime() ].origin = pod gettagorigin( #"tag_body_animate" );
            level.var_382e8897c7044c1b[ gettime() ].angles = pod gettagangles( #"tag_body_animate" );
            waitframe();
            
            if ( !isdefined( pod ) )
            {
                return;
            }
        }
        while ( true );
    }

    // Namespace hellstorm_missile
    // Params 0, eflags: 0x4
    // Checksum 0x3ac6e8d7, Offset: 0x5956
    // Size: 0xa0, Type: dev
    function private function_6105816e3ed9b9f7()
    {
        while ( true )
        {
            foreach ( debuginfo in level.var_382e8897c7044c1b )
            {
                sphere( debuginfo.origin, 12, ( 0, 0, 1 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace hellstorm_missile
    // Params 0, eflags: 0x4
    // Checksum 0x208e1139, Offset: 0x59fe
    // Size: 0xc1, Type: dev
    function private debugdrawmissile()
    {
        level notify( #"hash_8500241a19a198a3" );
        level endon( #"hash_8500241a19a198a3" );
        level.var_9e395a0a0f9f6 = [];
        
        if ( getdvarint( @"hash_bb7e1875b8c27444", 0 ) == 0 )
        {
            return;
        }
        
        level childthread function_c013d1552e0cf0d8();
        missile = self;
        
        do
        {
            level.var_9e395a0a0f9f6[ gettime() ] = spawnstruct();
            level.var_9e395a0a0f9f6[ gettime() ].origin = missile gettagorigin( #"tag_origin" );
            level.var_9e395a0a0f9f6[ gettime() ].angles = missile gettagangles( #"tag_origin" );
            waitframe();
            
            if ( !isdefined( missile ) )
            {
                return;
            }
        }
        while ( true );
    }

    // Namespace hellstorm_missile
    // Params 0, eflags: 0x4
    // Checksum 0x30c5f231, Offset: 0x5ac7
    // Size: 0xa0, Type: dev
    function private function_c013d1552e0cf0d8()
    {
        while ( true )
        {
            foreach ( debuginfo in level.var_9e395a0a0f9f6 )
            {
                sphere( debuginfo.origin, 12, ( 1, 0.5, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace hellstorm_missile
    // Params 1, eflags: 0x4
    // Checksum 0xb3becb54, Offset: 0x5b6f
    // Size: 0xc2, Type: dev
    function private function_5f060bc92fedfaab( explotype )
    {
        switch ( explotype )
        {
            case #"ground":
                debugcolor = ( 0, 1, 0 );
                break;
            case #"water":
                debugcolor = ( 0, 0, 1 );
                break;
            case #"air":
                debugcolor = ( 0, 1, 1 );
                break;
            default:
                debugcolor = ( 0, 0, 0 );
                break;
        }
        
        explo_pos = self gettagorigin( #"tag_fx_explo" );
        sphere( explo_pos, 10, debugcolor, 0, 5000 );
    }

    // Namespace hellstorm_missile
    // Params 1
    // Checksum 0x960c7375, Offset: 0x5c39
    // Size: 0x144, Type: dev
    function function_c5068642fe086f78( missile )
    {
        duration = 100;
        len = 10000;
        missileangles = missile.angles;
        forwardmissile = anglestoforward( missileangles );
        uptemp = ( 0, 0, 1 );
        left = vectorcross( uptemp, forwardmissile );
        up = vectorcross( forwardmissile, left );
        linesstart = missile.origin + forwardmissile * 250;
        linesend = linesstart + forwardmissile * len;
        line( linesstart, linesend, ( 0, 0, 1 ), 1, 0, duration );
        ulen = len * tan( 20 );
        deg = 0;
        
        while ( deg < 360 )
        {
            endtemp = up * ulen;
            end = rotatepointaroundvector( forwardmissile, endtemp, deg );
            line( linesstart, linesend + end, ( 1, 1, 1 ), 1, 0, duration );
            deg += 22.5;
        }
    }

#/
