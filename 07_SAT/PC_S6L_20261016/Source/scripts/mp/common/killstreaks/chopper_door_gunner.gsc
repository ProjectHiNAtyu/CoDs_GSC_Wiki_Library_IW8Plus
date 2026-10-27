// scripts\mp\common\killstreaks\chopper_door_gunner.gsc  (hash_7d7c7195c66f7a92.gscc) (size: 26327 Bytes / 0x66d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8a5cbd7 (4171615191)
// size ...... 26327 (0x66d7)
// includes .. 10  (offset: 0x626b)
// strings ... 56  (offset: 0x62bb)
// dev strs .. 8   (offset: 0x6677)
// exports ... 55  (offset: 0x40b7)
// cseg ...... 0x469 + 0x3c4e (0x40b7)
// imports ... 201 (offset: 0x494f)
// animtree1 . 0   (offset: 0x66d7)
// animtree2 . 0   (offset: 0x66d7)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\playerlogic;

#namespace chopper_door_gunner;

// Namespace chopper_door_gunner
// Params 0, eflags: 0x1
// Checksum 0x6a0ca915, Offset: 0x487
// Size: 0x61
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "chopper_door_gunner" ), &chopper_door_gunner_init );
    utility::registersharedfunc( "chopper_door_gunner", #"hash_f4b061f9d47c36d6", &function_a6f404d59c4e1996 );
    utility::registersharedfunc( "chopper_door_gunner", #"flyaway", &function_de7dbdb498cc48e0 );
    level callback::add( #"hash_55cb5a4d1562cd4d", &_chopper_door_gunner_watch_for_last_stand );
}

// Namespace chopper_door_gunner
// Params 0
// Checksum 0x8fb2806c, Offset: 0x4f0
// Size: 0x2a3
function chopper_door_gunner_init()
{
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "chopper_door_gunner", &function_878c11e618fb1252 );
    bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
    assert( isdefined( bundle ) );
    assert( isdefined( bundle.deployweaponname ) );
    level.var_766b5edcff5e6857 = spawnstruct();
    level.var_766b5edcff5e6857.deployweaponname = bundle.deployweaponname;
    level.var_766b5edcff5e6857.vehicleinfo = bundle.deployedvehicle;
    level.var_766b5edcff5e6857.totalduration = bundle.var_4cc69b3ae75791b4;
    level.var_766b5edcff5e6857.lightdamagepercent = bundle.var_3076079216285900;
    level.var_766b5edcff5e6857.mediumdamagepercent = bundle.var_8abc814fcbee8055;
    level.var_766b5edcff5e6857.heavydamagepercent = bundle.var_13799a7160f58ca5;
    level.var_766b5edcff5e6857.playermodel = bundle.var_f6ad09861c217c48;
    level.var_766b5edcff5e6857.var_766f4b5c1ae14600 = bundle.var_766f4b5c1ae14600;
    level.var_766b5edcff5e6857.var_ea75c47159152b52 = bundle.var_ea75c47159152b52;
    level.var_766b5edcff5e6857.choppers = [];
    assert( level.var_766b5edcff5e6857.lightdamagepercent > level.var_766b5edcff5e6857.mediumdamagepercent );
    assert( level.var_766b5edcff5e6857.mediumdamagepercent > level.var_766b5edcff5e6857.heavydamagepercent );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "chopper_door_gunner", bundle.var_766f4b5c1ae14600, #"oneshot" );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "chopper_door_gunner", "on", 19 );
    
    /#
        setdevdvar( @"hash_1cdf27df86cea89e", 0 );
        setdevdvar( @"hash_e4ca3c6a2f7549a8", 0 );
        setdevdvar( @"hash_1799d091a02d33be", 0 );
        setdevdvar( @"scr_debug_chopper_door_gunner_path", 0 );
        setdevdvar( @"hash_7a86934e1a533000", 0 );
        setdevdvar( @"hash_7147dc0fd1627607", 0 );
    #/
    
    utility::flag_set( "chopper_shared_initialized" );
    utility::callsharedfunc( #"chopper_door_gunner", #"init" );
}

// Namespace chopper_door_gunner
// Params 2
// Checksum 0x870284ab, Offset: 0x79b
// Size: 0x3ee, Type: bool
function function_878c11e618fb1252( streakinfo, var_d0a9a35fe849ba5a )
{
    owner = self;
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    owner.var_358f8c0520f39fc2 = undefined;
    
    if ( !isdefined( streakinfo ) )
    {
        streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "chopper_door_gunner", owner );
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    val::set( "chopper_door_gunner", "killstreaks", 0 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_1d6c9ff7a5dbeb7d" ) )
    {
        thread utility::callsharedfunc( #"killstreak", #"hash_1d6c9ff7a5dbeb7d", streakinfo );
    }
    
    deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweapontabletdeploysharedfunc( streakinfo, &function_a4846f87cc76b3ee, streakinfo.weaponswitchendedcallback, undefined, &function_4b6b05c8d67db060, level.var_766b5edcff5e6857.deployweaponname );
    
    if ( !deployresult )
    {
        val::reset_all( "chopper_door_gunner" );
        val::reset_all( "chopper_door_gunner_delay" );
        return false;
    }
    
    owner function_21e5fddf66a91fad( 1 );
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            val::reset_all( "chopper_door_gunner" );
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    owner disablephysicaldepthoffieldscripting();
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    veh = owner function_61c1ef5cc77ab171( streakinfo, owner, var_d0a9a35fe849ba5a );
    
    if ( !isdefined( veh ) )
    {
        owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
        val::reset_all( "chopper_door_gunner" );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        return false;
    }
    
    if ( isdefined( level.var_f937837a8308d7a3 ) )
    {
        level thread [[ level.var_f937837a8308d7a3 ]]( veh );
    }
    
    owner.streakinfo = streakinfo;
    owner thread utility::callsharedfunc( #"killstreak", #"hash_bf0d4876dd42e072", veh );
    bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
    veh thread namespace_9d8e359c3b1041e5::killstreak_registerminimapinfosharedfunc( bundle, #"chopper_door_gunner" );
    owner thread _chopper_door_gunner_get_in_vehicle( veh, owner, isdefined( var_d0a9a35fe849ba5a ) && istrue( var_d0a9a35fe849ba5a.var_e2eb1e387b402705 ) );
    veh thread function_8a0e5e0f78420de4( veh, owner, streakinfo );
    
    if ( !streakinfo.issp )
    {
        veh thread function_6d0425a2752f1d6c( veh, owner );
    }
    
    veh thread function_de8d5bc8cc011ca1( veh, owner );
    veh thread function_5fbda29e0a3e5cab( veh );
    veh thread function_76924cf9e3f462f7( owner );
    owner setclientomnvar( "ui_killstreak_health", 1 );
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "chopper_door_gunner", "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "chopper_door_gunner" );
    
    if ( !streakinfo.disablemarker )
    {
        params = { #hideoverlaytargetmarkerfriendly:bundle.hideoverlaytargetmarkerfriendly };
        owner killstreak_shared::killstreak_assigntargetmarkers( params );
        owner thread function_41fef1c994f93902( veh );
    }
    
    owner thread utility::callsharedfunc( #"killstreak", #"hash_ebf03489dd02b19b" );
    
    /#
        veh thread _watch_dvars( veh, owner );
    #/
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "chopper_door_gunner", self );
    }
    
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    veh vehicle_damage::set_can_damage( 1 );
    
    if ( isdefined( self ) )
    {
        var_c2ecf940026626e0 = level.sharedfuncs[ #"killstreak" ][ #"hash_1fa18935c88e6b0c" ];
        
        if ( isdefined( var_c2ecf940026626e0 ) )
        {
            self [[ var_c2ecf940026626e0 ]]( level.var_766b5edcff5e6857.var_766f4b5c1ae14600 );
        }
    }
    
    return true;
}

// Namespace chopper_door_gunner
// Params 1
// Checksum 0x3fdb300e, Offset: 0xb92
// Size: 0x8e
function function_41fef1c994f93902( veh )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    veh endon( #"death" );
    veh endon( #"hash_7c47126b3ee960da" );
    veh endon( #"fatal_damage" );
    var_4565558cb4444c1e = [ "chopper_door_gunner", "airdrop_escort", "missile_turret", "hellstorm_missile", "airdrop" ];
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace chopper_door_gunner
// Params 1
// Checksum 0x7c5373ff, Offset: 0xc28
// Size: 0x16
function function_95f7ae6fbe33631a( veh )
{
    veh _chopper_door_gunner_player_exit_vehicle( veh );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x1ace3801, Offset: 0xc46
// Size: 0xbd
function private function_76924cf9e3f462f7( owner )
{
    self endon( #"death" );
    self endon( #"hash_7c47126b3ee960da" );
    level endon( #"game_ended" );
    self.lifetimeendtime = int( level.var_766b5edcff5e6857.totalduration * 1000 + gettime() );
    timepassed = 0;
    
    while ( timepassed < level.var_766b5edcff5e6857.totalduration && isdefined( owner ) )
    {
        timepassed += level.framedurationseconds;
        owner setclientomnvar( "ui_killstreak_lifetime", 1 - timepassed / level.var_766b5edcff5e6857.totalduration );
        waitframe();
    }
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xd3cff739, Offset: 0xd0b
// Size: 0x3a
function private function_5fbda29e0a3e5cab( veh )
{
    veh endon( #"death" );
    level waittill( #"hash_fa0cfbee663b705f" );
    veh _chopper_door_gunner_player_exit_vehicle( veh );
    waitframe();
    veh thread function_6f122b09847f6f77();
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x99aa8a27, Offset: 0xd4d
// Size: 0x97
function private _chopper_door_gunner_watch_for_last_stand( params )
{
    params.streakinfo endon( #"kill_watch_for_last_stand" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.veh ) )
    {
        return;
    }
    
    if ( isdefined( level.var_766b5edcff5e6857.choppers[ self.veh getentitynumber() ].sceneplaying ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "chopper_door_gunner", "off" );
    thread utility::callsharedfunc( #"killstreak", #"hash_63f802e00dc24246" );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xdd7d0d19, Offset: 0xdec
// Size: 0x2bb
function private function_2ecd97c1e30ea9a9( data )
{
    /#
        setdvar( @"hash_1799d091a02d33be", 0 );
    #/
    
    veh = data.victim;
    
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    veh vehicle_damage::set_can_damage( 0 );
    veh notify( #"fatal_damage" );
    
    if ( isdefined( level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"flare_system", #"hash_58a53f4881a5cfa7" ) )
    {
        veh [[ utility::getsharedfunc( #"flare_system", #"hash_58a53f4881a5cfa7" ) ]]( 0 );
    }
    
    if ( isdefined( veh.gunnerent ) )
    {
        veh.gunnerent unlink();
        veh.gunnerent thread _chopper_door_gunner_delete_after_time( 0 );
        veh.gunnerent = undefined;
    }
    
    owner = veh.owner;
    var_3efd06669258de5b = undefined;
    
    if ( isdefined( veh.driver ) )
    {
        if ( isdefined( level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ] ) )
        {
            var_3efd06669258de5b = function_a39623f12a2b8462( veh.var_1a841c7961778400 );
        }
    }
    
    if ( isdefined( var_3efd06669258de5b ) )
    {
        sceneroot = utility::spawn_model( "tag_origin", veh.origin, veh.angles );
        sceneroot scene::set_scriptbundle( var_3efd06669258de5b );
        sceneroot linkto( veh, "tag_origin" );
        scene::add_scene_func( sceneroot.script_scenescriptbundle, &function_608134c640bb7378, "callback_play" );
        scene::add_scene_func( sceneroot.script_scenescriptbundle, &function_e351fc3416ae83c9, "callback_done" );
        sceneroot.veh = veh;
        vehanim = sceneroot scene::function_d0df7c35d793d179( "flying_chopper_door_gunner", 0 );
        var_97b555a9332e878c = 0;
        veh animscripted( "", veh.origin, veh.angles, vehanim[ 0 ], undefined, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, var_97b555a9332e878c );
        sceneroot thread scene::play( [ owner, veh.pilotent, veh.var_fd454312254c8a23 ] );
        veh.scene_root = sceneroot;
        shouldsnap = 0;
        veh setturrettargetlocalangles( ( 0, 0, 0 ), veh.turretindex, shouldsnap );
        function_b85bceafb1ae15d( veh );
    }
    else
    {
        _chopper_door_gunner_handle_death( veh );
    }
    
    return 0;
}

// Namespace chopper_door_gunner
// Params 2
// Checksum 0x75b4db8f, Offset: 0x10b0
// Size: 0x2a
function function_70aa70c82982cb7e( veh, streakinfo )
{
    veh _chopper_door_gunner_player_exit_vehicle( veh );
    veh function_472d568e5ab61ba0( veh, streakinfo );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xcf955bf3, Offset: 0x10e2
// Size: 0x6f
function private _chopper_door_gunner_handle_death( veh )
{
    veh _chopper_door_gunner_player_exit_vehicle( veh );
    waitframe();
    veh.owner utility::callsharedfunc( #"killstreak", #"playKillstreakTacomDialog", veh.streakinfo, undefined, #"destroyed", 1 );
    veh.deathexplosion function_384cff529040c2db( veh );
    veh function_6f122b09847f6f77();
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0x93c15b0a, Offset: 0x1159
// Size: 0xc8
function private function_608134c640bb7378()
{
    veh = self.veh;
    veh endon( #"death" );
    veh endon( #"hash_7c47126b3ee960da" );
    function_c471e90741ee7005();
    wait 1.75;
    var_c30c982f32a6d46b = veh.var_1a841c7961778400 ? #"right_destroyed" : #"left_destroyed";
    veh.owner thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( veh.streakinfo, undefined, var_c30c982f32a6d46b, 1 );
    level waittill( #"pilot_death" );
    
    if ( isdefined( veh ) && isalive( veh.owner ) )
    {
        veh.owner stopsoundchannel( "voice_radio_2d" );
    }
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0xfcbbec36, Offset: 0x1229
// Size: 0x87
function private function_e351fc3416ae83c9()
{
    sceneroot = self;
    veh = sceneroot.veh;
    level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying = undefined;
    
    if ( veh.health > 0 )
    {
        veh setturretscriptcontrolled( 0, veh.turretindex );
    }
    
    _chopper_door_gunner_handle_death( veh );
    veh.owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x581fc54e, Offset: 0x12b8
// Size: 0x1e9
function private function_725d82a818c26fee( veh )
{
    owner = veh.owner;
    var_fd09c6727402315b = level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].var_fd09c6727402315b;
    var_e18b395d8335f600 = getent( var_fd09c6727402315b, #targetname );
    
    if ( isdefined( veh.var_d0a9a35fe849ba5a ) )
    {
        var_e18b395d8335f600 = veh.var_d0a9a35fe849ba5a;
    }
    
    utility::callsharedfunc( "chopper_door_gunner", #"hash_f4b061f9d47c36d6", veh, var_e18b395d8335f600 );
    veh.driver = owner;
    veh.ispiloted = 1;
    playerangles = owner getplayerangles();
    yaw = playerangles[ 1 ];
    roll = playerangles[ 2 ];
    
    if ( var_e18b395d8335f600.var_e2eb1e387b402705 )
    {
        yaw = veh.angles[ 1 ];
    }
    
    owner usevehicle( veh, veh.gunnerseat );
    newangles = ( 15, yaw, roll );
    owner setplayerangles( newangles );
    veh.controlslinked = 1;
    veh namespace_9d8e359c3b1041e5::registersentientsharedfunc( "Killstreak_Air", owner );
    vehicle_tracking::register_instance( veh, owner, owner.team );
    veh thread function_279f39ca9e8da21b( veh );
    veh setscriptablepartstate( #"ambientlightleft", #"on" );
    veh setscriptablepartstate( #"ambientlightright", #"on" );
    veh setscriptablepartstate( #"ambientvfxleft", #"on" );
    veh setscriptablepartstate( #"ambientvfxright", #"on" );
    veh setscriptablepartstate( #"vehiclelights", #"on" );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xb11a4e70, Offset: 0x14a9
// Size: 0x15
function private function_8580ad0be9f9d2b4( veh )
{
    veh function_6c77c725fc188ca6();
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0x6cd26f4a, Offset: 0x14c6
// Size: 0x197
function private function_55b9ede36c1be075()
{
    sceneroot = self;
    veh = sceneroot.veh;
    level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying = undefined;
    var_38f66933e2959bfc = veh getturretworldangles( veh.turretindex );
    veh.owner setplayerangles( var_38f66933e2959bfc );
    veh setturretscriptcontrolled( 0, veh.turretindex );
    bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
    gamescene = bundle.var_de1e1464ef0ab4e8;
    
    if ( isdefined( gamescene ) )
    {
        if ( utility::issharedfuncdefined( "chopper_door_gunner", #"hash_c44e13c75d2a5c1c" ) )
        {
            sceneroot [[ utility::getsharedfunc( "chopper_door_gunner", #"hash_c44e13c75d2a5c1c" ) ]]( gamescene );
        }
    }
    
    veh function_eb88c4e66edbc855( "path", "advanceOnStart", 0 );
    veh function_eb88c4e66edbc855( "path", "canUpdateAngles", 1 );
    veh function_eb88c4e66edbc855( "path", "canUpdatePathTangent", 1 );
    function_8580ad0be9f9d2b4( veh );
    
    if ( utility::issharedfuncdefined( #"flare_system", #"hash_58a53f4881a5cfa7" ) )
    {
        veh [[ utility::getsharedfunc( #"flare_system", #"hash_58a53f4881a5cfa7" ) ]]( 1 );
    }
    
    veh.owner function_4936e2e9ac3c9825( 1 );
    veh.owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x870c0cd6, Offset: 0x1665
// Size: 0x4f
function private function_a39623f12a2b8462( var_c1cacb66f9b8849 )
{
    bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
    return var_c1cacb66f9b8849 ? bundle.var_c426121cec644be9 : bundle.var_a1d377e9f90b1503;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x51e78a11, Offset: 0x16bd
// Size: 0x4f
function private function_58bfdda610955bd6( var_c1cacb66f9b8849 )
{
    bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
    return var_c1cacb66f9b8849 ? bundle.var_615c7bc972cf17ad : bundle.var_9d14a068cb31a34f;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x3ca1c8b8, Offset: 0x1715
// Size: 0x26b, Type: bool
function private _chopper_door_gunner_handle_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    type = data.meansofdeath;
    modifieddamage = data.damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "chopper_door_gunner" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, 1, 1, 1 );
    }
    
    data.damage = modifieddamage;
    currenthealth = data.victim.health - modifieddamage;
    healthpercent = 100 * currenthealth / data.victim.maxhealth;
    veh = data.victim;
    
    if ( healthpercent < level.var_766b5edcff5e6857.heavydamagepercent )
    {
        veh setscriptablepartstate( #"damageheavy", #"on" );
    }
    else if ( healthpercent < level.var_766b5edcff5e6857.mediumdamagepercent )
    {
        veh setscriptablepartstate( #"damagemedium", #"on" );
    }
    else if ( healthpercent < level.var_766b5edcff5e6857.lightdamagepercent )
    {
        veh setscriptablepartstate( #"damagelight", #"on" );
    }
    
    self.owner setclientomnvar( "ui_killstreak_health", healthpercent / 100 );
    return true;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x2ebf7afc, Offset: 0x1989
// Size: 0xe, Type: bool
function private function_a4846f87cc76b3ee( streakinfo )
{
    return true;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xdc72eabd, Offset: 0x19a0
// Size: 0x18
function private function_4b6b05c8d67db060( streakinfo )
{
    self notify( #"finished_deploy_weapon" );
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0x698bd5cb, Offset: 0x19c0
// Size: 0x21b
function private function_57df7491512e4034()
{
    sceneroot = self;
    ownerplayer = undefined;
    gunner1p = undefined;
    gunner3p = undefined;
    
    foreach ( s_object in sceneroot.scenedata.sceneobjectdata )
    {
        if ( isplayer( s_object.entity ) )
        {
            ownerplayer = s_object.entity;
            continue;
        }
        
        if ( isdefined( s_object.entity ) && s_object.entity.animname == "Gunner1p" )
        {
            gunner1p = s_object.entity;
            continue;
        }
        
        if ( isdefined( s_object.entity ) && s_object.entity.animname == "Gunner3p" )
        {
            gunner3p = s_object.entity;
        }
    }
    
    assert( isdefined( ownerplayer ) );
    assert( isdefined( gunner1p ) );
    assert( isdefined( gunner3p ) );
    
    foreach ( player in level.players )
    {
        if ( player == ownerplayer )
        {
            gunner3p hidefromplayer( player );
            continue;
        }
        
        gunner1p hidefromplayer( player );
    }
    
    if ( !sceneroot.veh.streakinfo.disablemarker )
    {
        ownerplayer mark_enemy_ent( gunner3p );
    }
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x31e11ce7, Offset: 0x1be3
// Size: 0x21
function private function_4487e1ce078c5040( veh )
{
    return veh.var_1a841c7961778400 ? 1 : 2;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xc960bad1, Offset: 0x1c0d
// Size: 0xd4
function private function_fe442d6de43bf56d( veh )
{
    sceneroot = self;
    
    foreach ( sceneobjectdata in sceneroot.scenedata.sceneobjectdata )
    {
        alignmentinfo = sceneobjectdata.alignmentinfo;
        
        if ( !isdefined( alignmentinfo ) )
        {
            continue;
        }
        
        if ( alignmentinfo.aligntarget === "flying_chopper_door_gunner" )
        {
            alignmentinfo.alignent = veh;
        }
    }
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0x97beaf57, Offset: 0x1ce9
// Size: 0xb4
function private function_c471e90741ee7005()
{
    sceneroot = self;
    sceneroot function_57df7491512e4034();
    veh = sceneroot.veh;
    assert( !isdefined( level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying ) );
    level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying = sceneroot;
    veh setturretscriptcontrolled( 1, veh.turretindex );
    sceneroot function_fe442d6de43bf56d( veh );
    veh.owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
}

// Namespace chopper_door_gunner
// Params 3, eflags: 0x4
// Checksum 0x558e9fcd, Offset: 0x1da5
// Size: 0x8d3
function private function_61c1ef5cc77ab171( streakinfo, owner, var_d0a9a35fe849ba5a )
{
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        owner namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        return;
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    var_435a53c33576e96d = [ "chopper_door_gunner_path_start_1", "chopper_door_gunner_path_start_2" ];
    var_fd09c6727402315b = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_1dbff477d74da9bf" ) )
    {
        [ var_e18b395d8335f600, var_fd09c6727402315b ] = utility::callsharedfunc( #"killstreak", #"hash_1dbff477d74da9bf", var_435a53c33576e96d );
    }
    
    if ( !isdefined( var_e18b395d8335f600 ) )
    {
        foreach ( chopperdata in level.var_766b5edcff5e6857.choppers )
        {
            if ( isdefined( chopperdata.veh.driver ) )
            {
                var_435a53c33576e96d = arrayremove( var_435a53c33576e96d, chopperdata.var_fd09c6727402315b );
            }
        }
        
        assert( var_435a53c33576e96d.size != 0 );
        
        if ( var_435a53c33576e96d.size == 0 )
        {
            return;
        }
        
        while ( var_435a53c33576e96d.size > 0 )
        {
            var_fd09c6727402315b = utility::array_random( var_435a53c33576e96d );
            var_e18b395d8335f600 = getent( var_fd09c6727402315b, #targetname );
            
            if ( isdefined( var_e18b395d8335f600 ) )
            {
                break;
            }
            
            var_435a53c33576e96d = arrayremove( var_435a53c33576e96d, var_fd09c6727402315b );
        }
    }
    
    if ( !isdefined( var_e18b395d8335f600 ) )
    {
        var_fd09c6727402315b = "chopper_door_gunner_path_start_1";
    }
    
    /#
        path = getdvarint( @"scr_debug_chopper_door_gunner_path", 0 );
        
        if ( path != 0 )
        {
            if ( path == 1 )
            {
                var_fd09c6727402315b = "<dev string:x24>";
            }
            else if ( path == 2 )
            {
                var_fd09c6727402315b = "<dev string:x45>";
            }
            
            var_e18b395d8335f600 = getent( var_fd09c6727402315b, #targetname );
            setdevdvar( @"scr_debug_chopper_door_gunner_path", 0 );
        }
    #/
    
    if ( isdefined( var_d0a9a35fe849ba5a ) )
    {
        var_e18b395d8335f600 = var_d0a9a35fe849ba5a;
    }
    
    /#
        if ( !isdefined( var_e18b395d8335f600 ) )
        {
            var_e18b395d8335f600 = spawnstruct();
            var_33052bb6811001c0 = 1;
            var_e18b395d8335f600.targetname = var_fd09c6727402315b;
        }
        
        if ( getdvarint( @"hash_1cdf27df86cea89e", 0 ) != 0 )
        {
            var_33052bb6811001c0 = 1;
        }
    #/
    
    spawndata = spawnstruct();
    
    if ( isdefined( var_e18b395d8335f600 ) )
    {
        if ( isdefined( var_e18b395d8335f600.angles ) )
        {
            spawndata.angles = var_e18b395d8335f600.angles;
        }
        
        if ( isdefined( var_e18b395d8335f600.origin ) )
        {
            spawndata.origin = var_e18b395d8335f600.origin;
        }
        
        if ( isdefined( var_e18b395d8335f600.targetname ) )
        {
            spawndata.targetname = var_e18b395d8335f600.targetname;
            
            if ( var_33052bb6811001c0 )
            {
                spawndata.targetname = var_fd09c6727402315b;
            }
        }
        
        if ( isdefined( var_e18b395d8335f600.vehicletype ) )
        {
            spawndata.vehicletype = var_e18b395d8335f600.vehicletype;
        }
    }
    
    if ( !isdefined( spawndata.angles ) || var_33052bb6811001c0 )
    {
        if ( var_e18b395d8335f600.targetname == "chopper_door_gunner_path_start_2" )
        {
            spawndata.angles = owner.angles + ( 0, -90, 0 );
        }
        else
        {
            spawndata.angles = owner.angles + ( 0, 90, 0 );
        }
    }
    
    if ( !isdefined( spawndata.origin ) || var_33052bb6811001c0 )
    {
        offsetposition = anglestoforward( owner.angles ) * 150;
        offsetposition += anglestoright( owner.angles ) * 50;
        offsetposition += ( 0, 0, 150 );
        spawndata.origin = owner.origin + offsetposition;
    }
    
    if ( !isdefined( spawndata.targetname ) )
    {
        spawndata.targetname = "chopper_door_gunner_path_start";
    }
    
    if ( !isdefined( spawndata.vehicletype ) )
    {
        spawndata.vehicletype = "veh_chopper_door_gunner";
    }
    
    veh = vehicle_tracking::spawn_vehicle( spawndata );
    
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    veh.targetname = "flying_chopper_door_gunner";
    veh.streakinfo = streakinfo;
    veh.streakinfo.var_bbd40c52f0758e34 = 1;
    veh.superfaction = namespace_9d8e359c3b1041e5::getplayersuperfactionsharedfunc( owner );
    veh.team = owner.team;
    veh.vehiclename = "chopper";
    veh.owner = owner;
    veh.var_528c6a57b88db732 = var_33052bb6811001c0;
    veh.maxhealth = veh.health;
    veh.skipdeathnotify = 1;
    veh setvehicleteam( veh.team );
    
    if ( var_33052bb6811001c0 )
    {
        veh vehphys_forcekeyframedmotion();
    }
    
    if ( isdefined( var_d0a9a35fe849ba5a ) )
    {
        veh.var_d0a9a35fe849ba5a = var_d0a9a35fe849ba5a;
    }
    
    veh _setupdamagefunctionality( streakinfo.streakname );
    veh vehicle_damage::set_can_damage( 0 );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        veh [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, bundle.headicon_enable, 100 );
    }
    
    if ( !owner.var_23003f8cb6b4e1ae && utility::issharedfuncdefined( #"flare_system", #"defender_init" ) )
    {
        veh [[ utility::getsharedfunc( #"flare_system", #"defender_init" ) ]]( 4, 15, 10, 0 );
    }
    
    if ( isdefined( var_d0a9a35fe849ba5a ) )
    {
        veh.var_1a841c7961778400 = istrue( var_d0a9a35fe849ba5a.isclockwise );
    }
    else if ( isdefined( var_e18b395d8335f600.script_label ) )
    {
        veh.var_1a841c7961778400 = var_e18b395d8335f600.script_label == "clockwise";
    }
    else
    {
        veh.var_1a841c7961778400 = var_fd09c6727402315b == "chopper_door_gunner_path_start_1";
    }
    
    veh.gunnerseat = function_5d51a92d4f88e608( veh, 10, 11 );
    veh.turretindex = function_4487e1ce078c5040( veh );
    veh setotherent( owner );
    level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ] = { #veh:veh, #var_fd09c6727402315b:var_fd09c6727402315b };
    var_90cd804f04b29c03 = function_58bfdda610955bd6( veh.var_1a841c7961778400 );
    function_725d82a818c26fee( veh );
    
    if ( isdefined( var_90cd804f04b29c03 ) && isdefined( level.ismp ) )
    {
        sceneroot = utility::spawn_model( "tag_origin", veh.origin, veh.angles );
        sceneroot scene::set_scriptbundle( var_90cd804f04b29c03 );
        sceneroot linkto( veh, "tag_origin" );
        scene::add_scene_func( sceneroot.script_scenescriptbundle, &function_c471e90741ee7005, "callback_play" );
        scene::add_scene_func( sceneroot.script_scenescriptbundle, &function_55b9ede36c1be075, "callback_done" );
        sceneroot.veh = veh;
        vehanim = sceneroot scene::function_d0df7c35d793d179( "flying_chopper_door_gunner", 0 );
        var_97b555a9332e878c = 0;
        veh animscripted( "", veh.origin, veh.angles, vehanim[ 0 ], undefined, undefined, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, var_97b555a9332e878c );
        veh.owner function_4936e2e9ac3c9825( 0 );
        sceneroot thread scene::play( [ owner ] );
        veh.scene_root = sceneroot;
        shouldsnap = 1;
        veh setturrettargetlocalangles( ( 15, 0, 0 ), veh.turretindex, shouldsnap );
    }
    else
    {
        function_8580ad0be9f9d2b4( veh );
        
        if ( utility::issharedfuncdefined( "chopper_door_gunner", #"setuppilots" ) )
        {
            [[ utility::getsharedfunc( "chopper_door_gunner", #"setuppilots" ) ]]( veh );
        }
    }
    
    veh function_69cd52d64c05f19d();
    return veh;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x72d99679, Offset: 0x2681
// Size: 0x9b
function private _setupdamagefunctionality( streakname )
{
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "destroyed_" + streakname;
    destroyedsplash = "callout_destroyed_" + streakname;
    premoddamagecallback = &_chopper_door_gunner_handle_damage;
    deathcallback = &function_2ecd97c1e30ea9a9;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, self, scorepopup, vodestroyed, destroyedsplash, undefined, undefined, premoddamagecallback, undefined, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0x546a2891, Offset: 0x2724
// Size: 0x1e1
function private function_6c77c725fc188ca6()
{
    veh = self;
    
    if ( isdefined( veh ) )
    {
        veh.gunnerent = spawn( "script_model", ( 0, 0, 0 ) );
        
        if ( isdefined( veh.gunnerent ) )
        {
            veh.gunnerent setmodel( level.var_766b5edcff5e6857.playermodel );
            
            /#
                if ( getdvarint( @"hash_8675efc6943f087f", 0 ) != 0 )
                {
                    veh.gunnerent.var_9e31de8d177e5d6 = 1;
                    entnum = veh.gunnerent getentitynumber();
                    cmd = "<dev string:x66>" + entnum + "<dev string:x80>" + entnum;
                    adddebugcommand( cmd + "<dev string:x9a>" );
                }
            #/
            
            veh.gunnertag = function_5d51a92d4f88e608( veh, "tag_gunner1", "tag_gunner2" );
            veh.gunnerent linkto( veh, veh.gunnertag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            veh.gunnerent setscriptablepartstate( #"mainpart", #"aim" );
            veh.gunnerent function_94058260469a28ee( veh, veh.gunnerseat );
            var_167eef1770960f67 = 0;
            
            /#
                var_167eef1770960f67 = getdvarint( @"hash_7f018be707599194", 0 );
            #/
            
            if ( !var_167eef1770960f67 )
            {
                veh.gunnerent hidefromplayer( veh.owner );
            }
            
            if ( !veh.streakinfo.disablemarker )
            {
                veh.owner mark_enemy_ent( veh.gunnerent );
            }
        }
    }
}

// Namespace chopper_door_gunner
// Params 3, eflags: 0x4
// Checksum 0xdace2d94, Offset: 0x290d
// Size: 0x35
function private function_5d51a92d4f88e608( veh, first, second )
{
    if ( veh.var_1a841c7961778400 )
    {
        return first;
    }
    
    return second;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xf3b2ade6, Offset: 0x294a
// Size: 0x60
function private function_279f39ca9e8da21b( veh )
{
    while ( isdefined( veh ) )
    {
        veh waittill( #"reached_node", index );
        speed = veh.var_e21ba97ae07aeb59[ index ];
        
        if ( isdefined( speed ) )
        {
            veh function_eb88c4e66edbc855( "path", "targetSpeed", speed );
        }
    }
}

// Namespace chopper_door_gunner
// Params 3, eflags: 0x4
// Checksum 0x78b6b45d, Offset: 0x29b2
// Size: 0x137
function private function_a6f404d59c4e1996( veh, var_e18b395d8335f600, sceneplayed )
{
    sceneplayed = undefined;
    
    if ( veh.var_528c6a57b88db732 )
    {
        return;
    }
    
    currnode = var_e18b395d8335f600;
    nodepoints = [];
    nodetimes = [];
    var_e21ba97ae07aeb59 = [];
    i = 0;
    
    while ( isdefined( currnode.target ) )
    {
        nextnode = getvehiclenode( currnode.target, #targetname );
        nodepoints[ i ] = nextnode.origin;
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_bc2f1151d0ac8c8e" ) )
        {
            nodepoints[ i ] = utility::callsharedfunc( #"killstreak", #"hash_bc2f1151d0ac8c8e", currnode.target, nextnode.origin );
        }
        
        nodetimes[ i ] = 10;
        var_e21ba97ae07aeb59[ i ] = nextnode.speed;
        i += 1;
        currnode = nextnode;
    }
    
    var_1f3f0477df65bc90 = 0;
    veh function_afa72b87a1e99531( nodepoints, nodetimes, var_e21ba97ae07aeb59, var_1f3f0477df65bc90 );
}

// Namespace chopper_door_gunner
// Params 4, eflags: 0x4
// Checksum 0xde84a0fa, Offset: 0x2af1
// Size: 0x162
function private function_afa72b87a1e99531( nodepoints, nodetimes, var_e21ba97ae07aeb59, var_1f3f0477df65bc90 )
{
    veh = self;
    veh.var_e21ba97ae07aeb59 = var_e21ba97ae07aeb59;
    looping = 0;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_2da272eb40285cf" ) )
    {
        looping = utility::callsharedfunc( #"killstreak", #"hash_2da272eb40285cf", undefined );
    }
    
    current_spline_id = function_53253e8ea222ed60( nodepoints, nodetimes, looping );
    
    if ( !veh hascomponent( "c2p" ) )
    {
        veh addcomponent( "c2p" );
    }
    
    if ( !veh hascomponent( "path" ) )
    {
        veh addcomponent( "path" );
    }
    
    if ( !var_1f3f0477df65bc90 )
    {
        veh function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
        veh function_eb88c4e66edbc855( "path", "canUpdateAngles", 0 );
        veh function_eb88c4e66edbc855( "path", "canUpdatePathTangent", 0 );
    }
    
    veh function_eb88c4e66edbc855( "path", "yawHelper", 0 );
    veh function_eb88c4e66edbc855( "path", "useManualSpeed", 1 );
    veh function_eb88c4e66edbc855( "path", "instantaneousSpeed", veh.var_e21ba97ae07aeb59[ 0 ] );
    veh function_eb88c4e66edbc855( "path", "catmullRomId", current_spline_id );
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0xe1e96d36, Offset: 0x2c5b
// Size: 0x1c, Type: bool
function private function_b5a5fd10ed4cd7ea()
{
    /#
        if ( getdvarint( @"hash_7a86934e1a533000", 0 ) != 0 )
        {
            return false;
        }
    #/
    
    return true;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x82db083d, Offset: 0x2c80
// Size: 0x37d
function private function_b85bceafb1ae15d( veh )
{
    if ( veh.var_528c6a57b88db732 )
    {
        return;
    }
    
    var_8e89fd4a70031c43 = veh.var_1a841c7961778400 ? "chopper_door_gunner_node_death_1_start" : "chopper_door_gunner_node_death_2_start";
    var_aaadfa6fac73ff5d = getvehiclenode( var_8e89fd4a70031c43, #targetname );
    
    if ( !isdefined( var_aaadfa6fac73ff5d ) )
    {
        return;
    }
    
    if ( !isdefined( var_aaadfa6fac73ff5d.target ) )
    {
        return;
    }
    
    var_f795a9bb5fa53411 = getvehiclenode( var_aaadfa6fac73ff5d.target, #targetname );
    
    if ( !isdefined( var_f795a9bb5fa53411 ) )
    {
        return;
    }
    
    var_e928a605ff7679f1 = utility::mph_to_ips( veh vehicle_getspeed() );
    splinedir = var_f795a9bb5fa53411.origin - var_aaadfa6fac73ff5d.origin;
    splineangles = vectortoangles( splinedir );
    yawdiff = veh.angles[ 1 ] - splineangles[ 1 ];
    var_bdc16de26d3dbc5a = ( 0, 1, 0 );
    var_4e18e7dee7dec5f8 = vectortoangles( var_bdc16de26d3dbc5a );
    var_451ea37b0ee89b9f = var_4e18e7dee7dec5f8[ 1 ] - splineangles[ 1 ];
    var_87ec534b55b055f8 = [ veh.origin ];
    transformratio = var_e928a605ff7679f1 / utility::mph_to_ips( 30 );
    transformratio = transformratio >= 1 ? transformratio * 1 : transformratio / 1;
    nodepoints = [];
    nodetimes = [];
    var_e21ba97ae07aeb59 = [];
    i = 0;
    nodepoints[ 0 ] = veh.origin;
    nodetimes[ 0 ] = 10;
    var_e21ba97ae07aeb59[ 0 ] = var_e928a605ff7679f1;
    i = 1;
    
    for ( currnode = var_aaadfa6fac73ff5d; isdefined( currnode.target ) ; currnode = nextnode )
    {
        nextnode = getvehiclenode( currnode.target, #targetname );
        var_b71d8e50b7bf7417 = nextnode.origin - var_aaadfa6fac73ff5d.origin;
        
        if ( function_b5a5fd10ed4cd7ea() )
        {
            var_87ec534b55b055f8[ i ] = veh.origin + rotatevector( var_b71d8e50b7bf7417, ( 0, yawdiff, 0 ) );
            var_b71d8e50b7bf7417 = rotatevector( var_b71d8e50b7bf7417, ( 0, var_451ea37b0ee89b9f, 0 ) );
            var_b71d8e50b7bf7417 = ( var_b71d8e50b7bf7417[ 0 ], var_b71d8e50b7bf7417[ 1 ] * transformratio, var_b71d8e50b7bf7417[ 2 ] );
            var_b71d8e50b7bf7417 = rotatevector( var_b71d8e50b7bf7417, ( 0, var_451ea37b0ee89b9f * -1, 0 ) );
        }
        
        nodepoints[ i ] = veh.origin + rotatevector( var_b71d8e50b7bf7417, ( 0, yawdiff, 0 ) );
        nodetimes[ i ] = 10;
        var_e21ba97ae07aeb59[ i ] = nextnode.speed;
        i += 1;
    }
    
    /#
        if ( getdvarint( @"hash_7147dc0fd1627607", 0 ) != 0 )
        {
            finalspline = function_53253e8ea222ed60( nodepoints, nodetimes );
            draw_debug_spline( finalspline, debug::get_color( "<dev string:x9c>" ), veh.scene_root scene::function_b3c7b792a7a154fa( 0 ) );
            spline_destroy( finalspline );
            
            if ( function_b5a5fd10ed4cd7ea() )
            {
                originalspline = function_53253e8ea222ed60( var_87ec534b55b055f8, nodetimes );
                draw_debug_spline( originalspline, debug::get_color( "<dev string:xa2>" ), veh.scene_root scene::function_b3c7b792a7a154fa( 0 ) );
                spline_destroy( originalspline );
            }
        }
    #/
    
    var_1f3f0477df65bc90 = 1;
    veh function_afa72b87a1e99531( nodepoints, nodetimes, var_e21ba97ae07aeb59, var_1f3f0477df65bc90 );
}

/#

    // Namespace chopper_door_gunner
    // Params 1, eflags: 0x4
    // Checksum 0xbce72df, Offset: 0x3005
    // Size: 0xce, Type: dev
    function private function_6f14128ca582d40c( veh )
    {
        lastposition = veh.origin;
        var_f1d0df94595a00fa = 0;
        
        while ( isdefined( veh ) )
        {
            inchestraveled = distance( veh.origin, lastposition );
            var_3f62669c2f2dee9d = inchestraveled / ( gettime() - var_f1d0df94595a00fa ) / 1000;
            speedmph = int( var_3f62669c2f2dee9d * 0.056818 );
            lastposition = veh.origin;
            var_f1d0df94595a00fa = gettime();
            print3d( veh.origin + ( 0, 0, 100 ), speedmph, ( 0, 1, 0 ), 1, 25, 1, 1 );
            waitframe();
        }
    }

    // Namespace chopper_door_gunner
    // Params 2, eflags: 0x4
    // Checksum 0x8aa09816, Offset: 0x30db
    // Size: 0x21a, Type: dev
    function private _watch_dvars( veh, owner )
    {
        setdvar( @"hash_1799d091a02d33be", 0 );
        setdvar( @"hash_e4ca3c6a2f7549a8", 0 );
        setdvar( @"hash_a19237957782f31b", 0 );
        setdvar( @"hash_a278c533d4fb083", 0 );
        currdamagestate = 0;
        
        while ( true )
        {
            if ( !isdefined( veh ) )
            {
                break;
            }
            
            var_1c47831ce1a0872d = getdvarint( @"hash_a278c533d4fb083", 0 );
            
            if ( var_1c47831ce1a0872d )
            {
                setdvar( @"hash_a278c533d4fb083", 0 );
                function_568e3a0ff1d1697f( veh, owner );
            }
            
            var_caa5b5cc10091374 = getdvarint( @"hash_1799d091a02d33be", 0 );
            
            if ( var_caa5b5cc10091374 )
            {
                setdvar( @"hash_1799d091a02d33be", 0 );
                
                if ( isdefined( veh ) )
                {
                    data = spawnstruct();
                    data.victim = veh;
                    function_2ecd97c1e30ea9a9( data );
                }
            }
            
            var_d043e32a73b02a4b = getdvarint( @"hash_e4ca3c6a2f7549a8", 0 );
            
            if ( var_d043e32a73b02a4b )
            {
                setdvar( @"hash_e4ca3c6a2f7549a8", 0 );
                veh _chopper_door_gunner_player_exit_vehicle( veh );
            }
            
            newdamagestate = getdvarint( @"hash_a19237957782f31b", 0 );
            
            if ( newdamagestate != currdamagestate )
            {
                if ( newdamagestate == 0 )
                {
                    veh setscriptablepartstate( #"damagelight", #"off" );
                    veh setscriptablepartstate( #"damagemedium", #"off" );
                    veh setscriptablepartstate( #"damageheavy", #"off" );
                }
                else if ( newdamagestate == 1 )
                {
                    veh setscriptablepartstate( #"damagelight", #"on" );
                }
                else if ( newdamagestate == 2 )
                {
                    veh setscriptablepartstate( #"damagemedium", #"on" );
                }
                else if ( newdamagestate == 3 )
                {
                    veh setscriptablepartstate( #"damageheavy", #"on" );
                }
                
                currdamagestate = newdamagestate;
            }
            
            wait 1;
        }
    }

#/

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0xe0b6bc5b, Offset: 0x32fd
// Size: 0x97
function private function_568e3a0ff1d1697f( veh, owner )
{
    if ( utility::issharedfuncdefined( #"flare_system", #"hash_1101719e6ff74ce" ) )
    {
        if ( veh [[ utility::getsharedfunc( #"flare_system", #"hash_1101719e6ff74ce" ) ]]() )
        {
            veh setscriptablepartstate( #"flares", #"off" );
            waitframe();
            veh setscriptablepartstate( #"flares", #"deploy" );
        }
    }
    
    function_8461b1e1af66babe( veh, owner );
    veh thread function_a95294d26847ad1b( veh, owner );
}

// Namespace chopper_door_gunner
// Params 3, eflags: 0x4
// Checksum 0xcf5602fb, Offset: 0x339c
// Size: 0x114
function private _chopper_door_gunner_get_in_vehicle( veh, owner, var_e2eb1e387b402705 )
{
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    owner.restoreangles = owner getplayerangles();
    veh setotherent( owner );
    owner painvisionoff();
    owner killstreak_shared::killstreak_savenvgstate();
    namespace_9d8e359c3b1041e5::addspawnviewersharedfunc( veh );
    veh setrotorsactive( 1 );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        influencer = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_chopper_door_gunner_exposure", veh.origin, veh.team, owner, veh );
        influencer = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_chopper_door_gunner_aim", veh.origin, veh.team, owner, owner );
    }
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0x7b8c4651, Offset: 0x34b8
// Size: 0x35
function private function_a95294d26847ad1b( veh, owner )
{
    if ( owner.var_23003f8cb6b4e1ae )
    {
        return;
    }
    
    wait int( 15 );
    function_8461b1e1af66babe( veh, owner );
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0x46308d8b, Offset: 0x34f5
// Size: 0x7c
function private function_8461b1e1af66babe( veh, owner )
{
    if ( owner.var_23003f8cb6b4e1ae )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"flare_system", #"hash_aa84d9f6a2574574" ) )
    {
        if ( veh [[ utility::getsharedfunc( #"flare_system", #"hash_aa84d9f6a2574574" ) ]]() )
        {
            owner setclientomnvar( "ui_killstreak_flares_available", 1 );
            return;
        }
        
        owner setclientomnvar( "ui_killstreak_flares_available", 0 );
    }
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0x92387819, Offset: 0x3579
// Size: 0xfe
function private function_6d0425a2752f1d6c( veh, owner )
{
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    veh endon( #"fatal_damage" );
    var_6b491fb6a13d8690 = 0;
    owner.usepressed = 0;
    owner.toggleuse = 0;
    
    while ( isdefined( veh ) )
    {
        var_d7b49e968d9da977 = owner usebuttonpressed();
        
        if ( var_d7b49e968d9da977 || owner.toggleuse )
        {
            owner playerlogic::function_3765e79e200dd60f();
            timepassed = gettime() - var_6b491fb6a13d8690;
            owner setclientomnvar( "ui_exit_progress", min( 1, timepassed / 1000 ) );
            
            if ( timepassed >= 1000 )
            {
                veh notify( #"hash_fb44cd088f1f78d7" );
                break;
            }
        }
        else
        {
            owner.usepressed = 0;
            var_6b491fb6a13d8690 = gettime();
            owner setclientomnvar( "ui_exit_progress", 0 );
        }
        
        waitframe();
    }
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0x6fcc3fa2, Offset: 0x367f
// Size: 0x92
function private function_de8d5bc8cc011ca1( veh, owner )
{
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    veh endon( #"hash_7c47126b3ee960da" );
    veh endon( #"fatal_damage" );
    
    if ( owner.var_23003f8cb6b4e1ae )
    {
        return;
    }
    
    owner notifyonplayercommand( "inputReceivedFlares", "+smoke" );
    
    while ( true )
    {
        owner waittill( #"inputReceivedFlares" );
        
        if ( !isdefined( veh ) )
        {
            break;
        }
        
        function_568e3a0ff1d1697f( veh, owner );
    }
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0xa5796e0b, Offset: 0x3719
// Size: 0xb0
function private function_c215c802a68e1c17()
{
    self endon( #"killstreakexit" );
    self endon( #"reached_end_node" );
    self endon( #"hash_fb44cd088f1f78d7" );
    self endon( #"reached_dynamic_path_end" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    self.owner endon( #"last_stand_enter" );
    self.owner endon( #"team_kill_punish" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( level.var_766b5edcff5e6857.totalduration );
}

// Namespace chopper_door_gunner
// Params 3, eflags: 0x4
// Checksum 0xed4f9ba3, Offset: 0x37d1
// Size: 0x3c
function private function_8a0e5e0f78420de4( veh, owner, streakinfo )
{
    veh function_c215c802a68e1c17();
    veh _chopper_door_gunner_player_exit_vehicle( veh );
    veh function_472d568e5ab61ba0( veh, streakinfo );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x5ac45f53, Offset: 0x3815
// Size: 0x21a
function private _chopper_door_gunner_player_exit_vehicle( veh )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( veh.driver ) )
    {
        return;
    }
    
    while ( isdefined( veh.scene_root ) && veh.scene_root scene::get_state() == "Playing" )
    {
        waitframe();
    }
    
    veh.scene_root = undefined;
    owner = veh.driver;
    
    if ( isdefined( veh ) && isdefined( level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ].sceneplaying ) )
    {
        return;
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    owner.streakinfo = undefined;
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    veh setotherent( undefined );
    veh.driver = undefined;
    veh.ispiloted = undefined;
    owner painvisionon();
    owner killstreak_shared::killstreak_restorenvgstate();
    namespace_9d8e359c3b1041e5::removespawnviewersharedfunc( veh );
    
    if ( owner isvehicleactive() )
    {
        owner leavevehicle( 0 );
    }
    
    owner namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    
    if ( owner namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( owner );
    }
    
    veh notify( #"hash_7c47126b3ee960da" );
    veh.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:veh.streakinfo } );
    owner val::set( "chopper_door_gunner", "killstreaks", 1 );
    owner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "chopper_door_gunner", "off" );
    owner killstreak_shared::function_76bbbe12ce816ed2();
    
    if ( !veh.streakinfo.disablemarker )
    {
        owner killstreak_shared::function_b3302c4317df36c6();
    }
    
    owner thread utility::callsharedfunc( #"killstreak", #"hash_63f802e00dc24246", veh );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        veh [[ var_32dbca3143d9c4a5 ]]( 0 );
    }
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0x6dec3509, Offset: 0x3a37
// Size: 0x1d9
function private function_472d568e5ab61ba0( veh, streakinfo )
{
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    if ( veh.var_528c6a57b88db732 )
    {
        veh.var_528c6a57b88db732 = undefined;
        veh function_6f122b09847f6f77();
        return;
    }
    
    veh.var_b8aae568e66b4bc7 = 1;
    velocitynormal = vectornormalize( veh vehicle_getvelocity() );
    var_7fa68182f77c06a1 = ( velocitynormal[ 0 ], velocitynormal[ 1 ], tan( 5 ) );
    targetposition = veh.origin + var_7fa68182f77c06a1 * 100000;
    utility::callsharedfunc( "chopper_door_gunner", #"flyaway", veh, targetposition );
    endtimeflyaway = gettime() + utility::function_4b74c15943231980( streakinfo.flyawaytime ?? 60 );
    startingposition = veh.origin;
    var_70132e7bd057c919 = gettime() + utility::function_4b74c15943231980( 5 );
    assert( var_70132e7bd057c919 <= endtimeflyaway );
    
    while ( isdefined( veh ) )
    {
        if ( distance2dsquared( startingposition, veh.origin ) > 1024000000 )
        {
            break;
        }
        
        if ( gettime() > var_70132e7bd057c919 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( veh ) )
    {
        utility::callsharedfunc( #"vehicle", #"vehicleshowonminimap", 0 );
        
        if ( utility::issharedfuncdefined( #"flare_system", #"hash_58a53f4881a5cfa7" ) )
        {
            veh [[ utility::getsharedfunc( #"flare_system", #"hash_58a53f4881a5cfa7" ) ]]( 0 );
        }
    }
    
    while ( isdefined( veh ) )
    {
        if ( distance2dsquared( startingposition, veh.origin ) > 1024000000 )
        {
            break;
        }
        
        if ( gettime() > endtimeflyaway )
        {
            break;
        }
        
        waitframe();
    }
    
    veh function_6f122b09847f6f77();
}

// Namespace chopper_door_gunner
// Params 2, eflags: 0x4
// Checksum 0xd9cb24c, Offset: 0x3c18
// Size: 0x7e
function private function_de7dbdb498cc48e0( veh, targetpos )
{
    veh removecomponent( "path" );
    veh removecomponent( "c2p" );
    waitframe();
    veh addcomponent( "p2p" );
    veh setconfigvalue( "p2p", "goalPoint", targetpos );
    veh setconfigvalue( "p2p", "goalThreshold", 1000 );
    veh setconfigvalue( "p2p", "manualSpeed", veh vehicle_gettopspeedforward() * 17.6 );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0x9462ee4f, Offset: 0x3c9e
// Size: 0x3d
function private _chopper_door_gunner_delete_after_time( time )
{
    wait time;
    
    if ( isdefined( self ) )
    {
        /#
            if ( self.var_9e31de8d177e5d6 )
            {
                self.var_9e31de8d177e5d6 = undefined;
                adddebugcommand( "<dev string:xa6>" );
            }
        #/
        
        self delete();
    }
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0xb138b6b2, Offset: 0x3ce3
// Size: 0x18f
function private function_6f122b09847f6f77()
{
    self notify( #"death" );
    veh = self;
    
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    level.var_766b5edcff5e6857.choppers[ veh getentitynumber() ] = undefined;
    
    if ( veh.owner && veh.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            veh.owner [[ var_32dbca3143d9c4a5 ]]( veh.streakinfo );
        }
    }
    
    var_1190ac1fca9a2f7 = [ veh.gunnerent, veh.pilotent, veh.var_fd454312254c8a23 ];
    
    foreach ( entity in var_1190ac1fca9a2f7 )
    {
        if ( isdefined( entity ) )
        {
            entity unlink();
            entity thread _chopper_door_gunner_delete_after_time( 0 );
        }
    }
    
    veh.gunnerent = undefined;
    veh.pilotent = undefined;
    veh.var_fd454312254c8a23 = undefined;
    vehicle_tracking::deregister_instance( veh );
    vehicle_tracking::delete_vehicle( veh );
}

// Namespace chopper_door_gunner
// Params 0, eflags: 0x4
// Checksum 0xa1d79928, Offset: 0x3e7a
// Size: 0x93
function private function_69cd52d64c05f19d()
{
    explosion = spawn( "script_model", self.origin );
    explosion.owner = self.owner;
    explosion.team = self.team;
    explosion setotherent( explosion.owner );
    explosion setentityowner( explosion.owner );
    explosion setmodel( level.var_766b5edcff5e6857.var_ea75c47159152b52 );
    self.deathexplosion = explosion;
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xf60c22af, Offset: 0x3f15
// Size: 0x53
function private function_384cff529040c2db( veh )
{
    self dontinterpolate();
    self.origin = veh.origin;
    self.angles = veh.angles;
    self setscriptablepartstate( "deathExplosion", "explode" );
    thread delete_after_time( 20 );
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xd5fac4b3, Offset: 0x3f70
// Size: 0x1a
function private delete_after_time( deletiondelay )
{
    wait deletiondelay;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace chopper_door_gunner
// Params 1, eflags: 0x4
// Checksum 0xd34ab774, Offset: 0x3f92
// Size: 0x43
function private mark_enemy_ent( ent )
{
    ent enableplayermarks( #"air_killstreak" );
    
    if ( level.teambased )
    {
        ent filteroutplayermarks( self.team );
        return;
    }
    
    ent filteroutplayermarks( self );
}

/#

    // Namespace chopper_door_gunner
    // Params 3, eflags: 0x4
    // Checksum 0x1c35ae0b, Offset: 0x3fdd
    // Size: 0xda, Type: dev
    function private draw_debug_spline( splineid, color, duration )
    {
        totalpoints = 20;
        sphereradius = 20;
        internalduration = function_c4dcf1cf93ee158a( splineid );
        internaltimestep = internalduration / ( totalpoints - 1 );
        currpos = ( 0, 0, 0 );
        prevpos = ( 0, 0, 0 );
        pointid = 0;
        
        while ( pointid < totalpoints )
        {
            prevpos = currpos;
            currpos = function_2bf2352736fc6ac8( splineid, pointid * internaltimestep );
            debug::sphere( currpos, sphereradius, color, duration );
            
            if ( pointid > 0 )
            {
                debug::line( prevpos, currpos, color, duration );
            }
            
            pointid += 1;
        }
    }

#/
