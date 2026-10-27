// scripts\mp\common\killstreaks\sentry_gun.gsc  (hash_7f269af2f05b8a3c.gscc) (size: 27047 Bytes / 0x69a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50c027e8 (1354770408)
// size ...... 27047 (0x69a7)
// includes .. 10  (offset: 0x6567)
// strings ... 52  (offset: 0x65b7)
// dev strs .. 18  (offset: 0x68a7)
// exports ... 57  (offset: 0x43db)
// cseg ...... 0x3b8 + 0x4023 (0x43db)
// imports ... 200 (offset: 0x4cc3)
// animtree1 . 0   (offset: 0x69a7)
// animtree2 . 0   (offset: 0x69a7)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\functionals_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\hostmigration;

#namespace sentry_gun;

// Namespace sentry_gun
// Params 0
// Checksum 0x6f1a51f, Offset: 0x3d6
// Size: 0x17a
function init()
{
    utility::callsharedfunc( #"sentry_gun", #"init" );
    utility::callsharedfunc( #"sentry_gun", #"initsentrysettings" );
    bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
    
    if ( isdefined( bundle.deployweapon ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "sentry_gun", bundle.deployweapon, #"large" );
    }
    
    if ( isdefined( bundle.spawnweapon ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "sentry_gun", bundle.spawnweapon, #"large" );
        level thread register_on_kill_medal( bundle.spawnweapon );
        function_94510e770b58cf65( "sentry_gun", bundle.deployweapon, bundle.spawnweapon, "sentry_turret" );
    }
    
    val::group_register( "sentry", [ "armor", "mantle", "ladder", "killstreaks", "offhand_weapons" ] );
    utility::registersharedfunc( #"sentry_gun", #"destroy", &function_fb3b9c035597125d );
    
    /#
        setdevdvarifuninitialized( @"hash_c9bd691ce96079ac", 0 );
        setdevdvarifuninitialized( @"hash_e19e5d308effeda3", 1 );
        setdevdvarifuninitialized( @"hash_8b57c69d6f7ca720", 0 );
    #/
}

// Namespace sentry_gun
// Params 1, eflags: 0x4
// Checksum 0xb9987aa7, Offset: 0x558
// Size: 0x5b
function private register_on_kill_medal( weaponname )
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace sentry_gun
// Params 3
// Checksum 0x187d414b, Offset: 0x5bb
// Size: 0x2d
function weaponcleanupsentryturret( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        namespace_9d8e359c3b1041e5::getridofkillstreakdeployweaponsharedfunc( weaponobj );
    }
}

// Namespace sentry_gun
// Params 4
// Checksum 0xa7064975, Offset: 0x5f0
// Size: 0xaf
function function_94510e770b58cf65( streakname, deployweapon, turretweapon, turrettype )
{
    if ( !isdefined( level.sentrydata ) )
    {
        level.sentrydata = [];
    }
    
    sentryentry = spawnstruct();
    sentryentry.streakname = streakname;
    sentryentry.deployweapon = deployweapon;
    sentryentry.turretweapon = turretweapon;
    sentryentry.turrettype = turrettype ?? streakname;
    sentryentry.var_a1ff4562e4dc0818 = getxhash( turrettype ?? streakname );
    level.sentrydata[ streakname ] = sentryentry;
}

// Namespace sentry_gun
// Params 1
// Checksum 0xd94e690, Offset: 0x6a7
// Size: 0x52
function function_64ba8f03d1de7b25( streakname )
{
    assert( isdefined( level.sentrydata ), "<dev string:x24>" );
    assert( isdefined( level.sentrydata[ streakname ] ), "<dev string:x65>" + streakname + "<dev string:x8e>" );
    return level.sentrydata[ streakname ];
}

// Namespace sentry_gun
// Params 1
// Checksum 0xbc964a63, Offset: 0x702
// Size: 0x29
function tryusesentryturret( streakname )
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( streakname, self );
    return tryusesentryturretfromstruct( streakinfo );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x2bf1458, Offset: 0x734
// Size: 0x299, Type: bool
function tryusesentryturretfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    sentrydata = function_64ba8f03d1de7b25( streakinfo.streakname );
    
    if ( !isdefined( sentrydata ) )
    {
        return false;
    }
    
    namespace_9d8e359c3b1041e5::saveweaponstatessharedfunc();
    
    if ( !function_47d86575eecf7d92() )
    {
        return false;
    }
    
    /#
        forceenemyturret = getdvarint( @"hash_8b57c69d6f7ca720", 0 );
        
        if ( forceenemyturret )
        {
            if ( level.teambased )
            {
                turretteam = self.team == "<dev string:xa5>" ? "<dev string:xac>" : "<dev string:xa5>";
                
                if ( level.teamdata[ turretteam ][ "<dev string:xb1>" ].size == 0 )
                {
                    assertmsg( "<dev string:xb9>" );
                    return false;
                }
            }
            else if ( level.teamdata[ self.team ][ "<dev string:xb1>" ].size == 1 )
            {
                assertmsg( "<dev string:xb9>" );
                return false;
            }
        }
    #/
    
    deployweapon = function_47a76868af26ec22( streakinfo, sentrydata );
    
    if ( !deployweapon )
    {
        return false;
    }
    
    turret = sentryturret_create( sentrydata.turrettype, streakinfo );
    
    if ( !isdefined( turret ) )
    {
        self.bgivensentry = 0;
        return false;
    }
    
    config = level.sentrysettings[ sentrydata.turrettype ];
    
    if ( utility::issharedfuncdefined( streakinfo.streakname, #"oncarry" ) )
    {
        [[ utility::getsharedfunc( streakinfo.streakname, #"oncarry" ) ]]( turret, config );
    }
    
    marker = sentryturret_watchplacement( turret, streakinfo, 0, 1.25, deployweapon );
    
    if ( !isdefined( marker ) )
    {
        turret delete();
        self.bgivensentry = 0;
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    turret namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( turret, &sentryturret_empapplied, &sentryturret_empstarted, &sentryturret_empcleared );
    sentryturret_setplaced( turret, marker );
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"sentry_gun", #"munitionused" ) ]]();
    }
    
    return true;
}

// Namespace sentry_gun
// Params 5
// Checksum 0x6f0705d4, Offset: 0x9d6
// Size: 0x27f
function sentryturret_watchplacement( turret, streakinfo, ignorecancel, var_c6c7c3535d7e7bda, deployweapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.bgivensentry = 1;
    turret laseroff();
    thread utility::callsharedfunc( #"killstreak", #"manualturret_delayplacementinstructions", var_c6c7c3535d7e7bda );
    thread utility::callsharedfunc( #"killstreak", #"hash_29252bc7877f4fbe" );
    marker = undefined;
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"gettargetmarker" ) )
    {
        marker = self [[ utility::getsharedfunc( #"sentry_gun", #"gettargetmarker" ) ]]( streakinfo, ignorecancel );
    }
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        if ( namespace_9d8e359c3b1041e5::isalivesharedfunc() )
        {
            namespace_9d8e359c3b1041e5::killstreak_switchbacklastweaponsharedfunc( deployweapon );
        }
        
        self notify( #"turret_placement_finished" );
        val::set( "sentry", "interactions", 1 );
        val::group_reset( "sentry" );
        return;
    }
    
    if ( isdefined( marker.location ) && streakinfo.var_57c71d466dcad714 )
    {
        turret.colmodel show();
        turret.colmodel.angles = marker.angles;
        turret.colmodel.origin = marker.location;
    }
    
    turret thread namespace_9d8e359c3b1041e5::manualturret_disablefiresharedfunc( self, 1, 1 );
    
    if ( self getcurrentweapon() == deployweapon )
    {
        thread namespace_9d8e359c3b1041e5::killstreak_switchbacklastweaponsharedfunc( deployweapon, 1, streakinfo.var_5fa75a5415c9168 ?? 1 );
    }
    
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    var_1f804af8a4435c33 = 1;
    timeout = hostmigration::waittillnotifyortimeoutpause( "equip_deploy_cancel", bundle.var_c01a34d94c34f050 ?? 1 );
    
    if ( !isdefined( timeout ) || isstring( timeout ) && timeout == "timeout" )
    {
        var_1f804af8a4435c33 = 0;
        waitframe();
    }
    
    self notify( #"turret_placement_finished" );
    val::set( "sentry", "interactions", 1 );
    val::group_reset( "sentry" );
    return var_1f804af8a4435c33 ? marker : undefined;
}

// Namespace sentry_gun
// Params 3
// Checksum 0x377aa236, Offset: 0xc5e
// Size: 0x790
function sentryturret_create( turrettype, streakinfo, var_5da7449dad10cbc2 = 1 )
{
    config = level.sentrysettings[ turrettype ];
    bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
    
    if ( isdefined( bundle ) && isdefined( streakinfo ) && isdefined( streakinfo.mpstreaksysteminfo ) && isdefined( streakinfo.mpstreaksysteminfo.blueprintindex ) )
    {
        var_a96305f184ce69af = function_e8ac80ca17e7c88d( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    }
    
    turret = spawnturret( "misc_turret", self.origin, level.sentrysettings[ turrettype ].weaponinfo, var_5da7449dad10cbc2 );
    turret.owner = self;
    turret.team = self.team;
    turret.isdisabled = 0;
    
    /#
        forceenemyteam = getdvarint( @"hash_8b57c69d6f7ca720", 0 );
        
        if ( forceenemyteam )
        {
            if ( level.teambased )
            {
                turret.team = self.team == "<dev string:xa5>" ? "<dev string:xac>" : "<dev string:xa5>";
                turret.owner = level.teamdata[ turret.team ][ "<dev string:xb1>" ][ 0 ];
            }
            else
            {
                foreach ( player in level.players )
                {
                    if ( player != self )
                    {
                        turret.owner = player;
                        turret.team = player.team;
                        break;
                    }
                }
            }
        }
    #/
    
    turret.angles = self.angles;
    turret.health = 9999;
    turret.maxhealth = config.maxhealth;
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.ammocount = config.ammo;
    turret.timeout = config.timeout;
    turret.var_a96305f184ce69af = var_a96305f184ce69af ?? config;
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"attachxrays" ) )
    {
        turret = [[ utility::getsharedfunc( #"sentry_gun", #"attachxrays" ) ]]( turret );
    }
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            turret.timeout = 9999;
        }
    #/
    
    if ( !isdefined( turret.timeout ) )
    {
        turret.timeout = 120;
    }
    
    turret.lifetimeendtime = int( turret.timeout * 1000 + gettime() );
    streakinfo.streakduration = turret.timeout;
    turret.carriedby = self;
    turret sentryturret_setturretmodel( "placed" );
    turret setturretowner( turret.owner );
    turret.owner.var_e73f627a785541a2[ streakinfo.streakname ] = 0;
    turret setturretteam( turret.team );
    
    if ( turrettype == "railgun" )
    {
        turret function_ec095c4067f1edba();
        turret setmode( "manual" );
    }
    
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret hide();
    turret setautorotationdelay( 0.2 );
    turret.momentum = 0;
    turret.heatlevel = 0;
    turret.overheated = 0;
    turret.cooldownwaittime = 0.1;
    
    switch ( turrettype )
    {
        case #"hash_fa4536bde6f7ad9":
        default:
            turret setleftarc( 80 );
            turret setrightarc( 80 );
            turret setbottomarc( 50 );
            turret settoparc( 60 );
            turret setconvergencetime( 0.6, "pitch" );
            turret setconvergencetime( 0.6, "yaw" );
            turret setconvergenceheightpercent( 0.65 );
            turret setdefaultdroppitch( streakinfo.defaultdroppitch ?? -89 );
            break;
    }
    
    turret setturretmodechangewait( 1 );
    turret namespace_9d8e359c3b1041e5::allow_empsharedfunc( 0 );
    turret function_a4ebfb83ec0621b9( &function_fb3b9c035597125d );
    
    if ( isdefined( level.elevators ) && utility::issharedfuncdefined( #"game", #"isentitytouchingdoortrigger" ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread [[ utility::getsharedfunc( #"game", #"isentitytouchingdoortrigger" ) ]]( turret );
        }
    }
    
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    killcamtag = bundle.var_5a2f2caddf9acbd2 ?? #"tag_aim_pivot";
    killcamorigin = turret gettagorigin( killcamtag );
    killcament = spawn( "script_model", killcamorigin );
    var_37f5b92a7b89aa1a = ( ( bundle.var_35dc2200d74d381f ?? 20 ) * -1, 0, bundle.var_b586a75a1f9b4d08 ?? 10 );
    killcament linkto( turret, killcamtag, var_37f5b92a7b89aa1a, ( 0, 0, 0 ) );
    turret.killcament = killcament;
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel.turretowner = turret;
    turret.colmodel setmodel( bundle.playercolmodel ?? "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    
    if ( isdefined( config.hitbyvehiclefunc ) )
    {
        turret.hitbyvehiclefunc = config.hitbyvehiclefunc;
    }
    
    return turret;
}

// Namespace sentry_gun
// Params 1, eflags: 0x4
// Checksum 0x86c406fe, Offset: 0x13f7
// Size: 0x13b
function private sentryturret_delete( turret )
{
    turret setturretowner( undefined );
    turret laseroff();
    
    if ( isdefined( turret.killcament ) )
    {
        turret.killcament delete();
    }
    
    if ( isdefined( turret.useownerobj ) )
    {
        turret.useownerobj delete();
    }
    
    if ( isdefined( turret.useotherobj ) )
    {
        turret.useotherobj delete();
    }
    
    if ( isdefined( turret.colmodel ) )
    {
        turret.colmodel delete();
    }
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    turret namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( turret );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_c33ceb91d0ca7a9d" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    
    thread function_523db54fa0410e62( turret );
}

// Namespace sentry_gun
// Params 1, eflags: 0x4
// Checksum 0x7d07a750, Offset: 0x153a
// Size: 0x2d
function private function_523db54fa0410e62( turret )
{
    wait 3;
    
    if ( isdefined( turret ) )
    {
        turret setscriptablepartstate( "visibility", "hide" );
        turret delete();
    }
}

// Namespace sentry_gun
// Params 2
// Checksum 0x839cf8da, Offset: 0x156f
// Size: 0x5d
function function_e8ac80ca17e7c88d( bundle, blueprintindex )
{
    var_a96305f184ce69af = spawnstruct();
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    var_a96305f184ce69af.blueprintname = genericblueprintname;
    var_a96305f184ce69af.var_777ca86f76320f94 = #"gunmodel";
    return var_a96305f184ce69af;
}

// Namespace sentry_gun
// Params 2
// Checksum 0x17ade888, Offset: 0x15d5
// Size: 0x6fe
function sentryturret_setplaced( turret, marker )
{
    config = level.sentrysettings[ turret.turrettype ];
    sentrydata = function_64ba8f03d1de7b25( turret.streakinfo.streakname );
    turret sentryturret_setturretmodel( "placed" );
    
    if ( turret.shouldsplash )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( turret.streakinfo.streakname );
        }
        
        namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( self, self.team, 2000, turret.streakinfo.streakname );
        splashname = config.teamsplash;
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashname, self );
        }
        
        turret.shouldsplash = 0;
    }
    
    turret show();
    turret setscriptablepartstate( #"visibility", #"show" );
    turret dontinterpolate();
    turret.angles = marker.angles;
    turret.carriedby = undefined;
    
    if ( isdefined( marker.moving_platform ) )
    {
        turret.moving_platform = marker.moving_platform;
        turret.moving_platform_offset = marker.moving_platform_offset;
        turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
        
        if ( utility::issharedfuncdefined( #"turret", #"movingplatformonplaced" ) )
        {
            level thread [[ utility::getsharedfunc( #"turret", #"movingplatformonplaced" ) ]]( turret, marker );
        }
    }
    
    self.bgivensentry = 0;
    turret.origin = marker.location;
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"onplaced" ) )
    {
        level thread [[ utility::getsharedfunc( #"sentry_gun", #"onplaced" ) ]]( turret, marker );
    }
    
    turret utility::play_sound_in_space( "kls_sentry_deploy_plant", turret.origin + ( 0, 0, 20 ) );
    turret setscriptablepartstate( "lights", "daytime", 0 );
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret );
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"handlemovingplatform" ) )
    {
        [[ utility::getsharedfunc( #"sentry_gun", #"handlemovingplatform" ) ]]( turret );
    }
    
    streakname = turret.streakinfo.streakname;
    bundle = level.streakglobals.streakbundles[ streakname ];
    turret.minimapid = turret killstreak_utility::function_99456b220fc6798e( streakname, "hud_icon_minimap_killstreak_sentry", bundle, undefined, 0 );
    headiconoffset = 70;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        turret [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakname, "Killstreak_Ground", self, 0, 1, headiconoffset, [ "carried", "kill_turret" ] );
    }
    
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeon );
    function_65a8665b05618e72( turret, config );
    turret namespace_9d8e359c3b1041e5::allow_empsharedfunc( 1 );
    turret namespace_9d8e359c3b1041e5::registersentientsharedfunc( "Killstreak_Static", self );
    turret function_23198c680e4b78e3( turret, 1 );
    
    if ( isdefined( sentrydata.var_a1ff4562e4dc0818 ) && utility::issharedfuncdefined( sentrydata.var_a1ff4562e4dc0818, #"attacktargets" ) )
    {
        turret thread [[ utility::getsharedfunc( sentrydata.var_a1ff4562e4dc0818, #"attacktargets" ) ]]();
    }
    else
    {
        turret thread sentry_attacktargets();
    }
    
    if ( utility::issharedfuncdefined( streakname, #"onspawn" ) )
    {
        [[ utility::getsharedfunc( streakname, #"onspawn" ) ]]( turret, config );
    }
    
    params = { #marker:marker, #turret:turret };
    callback::callback( #"sentry_gun_on_spawn", params );
    bundle = level.streakglobals.streakbundles[ streakname ];
    turret.ignoreme = bundle.sentryturretignoreme ?? 0;
    
    if ( bundle.var_13cdd0801abe3dfa )
    {
        turret function_8e758aa38263a4db( 1 );
    }
    
    utility::function_969f9f5596dba07a( turret, &function_fb3b9c035597125d );
    
    /#
        turret thread function_9af1305fb37c8555();
    #/
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_sentry_gun", turret.origin, turret.team, turret.owner, turret );
    }
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        influencer = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_sentry_gun_cone", turret.origin, turret.team, turret.owner, turret );
    }
    
    thread sentryturret_delaydeletemarker( turret, marker );
    thread sentryturret_watchpickup( turret );
    thread sentryturret_watchdamage( turret );
    thread sentryturret_watchdeath( turret );
    thread sentryturret_watchdisown( turret );
    thread sentryturret_watchgameend( turret );
    
    if ( !turret.streakinfo.disabletimeout && !self.var_1f7c1a5f16a94bfe )
    {
        thread sentryturret_watchtimeout( turret );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_ca0042e3cac99672" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret, &function_23198c680e4b78e3, &function_23198c680e4b78e3 );
    }
    
    turret notify( #"hash_db521cf8a268eb0a" );
}

// Namespace sentry_gun
// Params 3
// Checksum 0x4db50e43, Offset: 0x1cdb
// Size: 0x24e
function function_65a8665b05618e72( turret, config, var_4478520bfce4382b )
{
    streakname = turret.streakinfo.streakname;
    bundle = level.streakglobals.streakbundles[ streakname ];
    hinttag = bundle.var_5a2f2caddf9acbd2 ?? #"tag_aim_pivot";
    
    if ( isdefined( var_4478520bfce4382b ) )
    {
        hinttag = var_4478520bfce4382b;
    }
    
    hintpos = turret gettagorigin( hinttag );
    
    if ( !isdefined( turret.useownerobj ) )
    {
        hinticon = undefined;
        hintduration = undefined;
        hintdist = undefined;
        usedist = undefined;
        hinttype = "hint_noicon";
        
        if ( utility::issp() )
        {
            hinttype = "hint_button";
        }
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"createhintobject" ) )
        {
            turret.useownerobj = [[ utility::getsharedfunc( #"sentry_gun", #"createhintobject" ) ]]( hintpos, hinttype, hinticon, config.ownerusehintstring, undefined, hintduration, "show", hintdist, undefined, usedist, undefined );
        }
    }
    else
    {
        turret.useownerobj setusableenabled( 1 );
        turret.useownerobj dontinterpolate();
        turret.useownerobj.origin = hintpos;
    }
    
    foreach ( guy in level.players )
    {
        if ( guy != turret.owner )
        {
            turret.useownerobj namespace_9d8e359c3b1041e5::disableplayerusesharedfunc( guy );
            continue;
        }
        
        turret.useownerobj namespace_9d8e359c3b1041e5::enableplayerusesharedfunc( guy );
    }
    
    turret.useownerobj linkto( turret, hinttag );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x89fa0850, Offset: 0x1f31
// Size: 0x352
function sentryturret_setcarried( turret )
{
    var_a76d51a51d956fa = 0;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_c33ceb91d0ca7a9d" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    
    utility::function_a605d1fb62b31e70( turret );
    
    if ( isdefined( turret.moving_platform ) )
    {
        turret.moving_platform = undefined;
        turret.moving_platform_offset = undefined;
        turret.moving_platform_angles_offset = undefined;
        turret unlink();
    }
    
    turret namespace_9d8e359c3b1041e5::allow_empsharedfunc( 0 );
    turret namespace_9d8e359c3b1041e5::unregistersentientsharedfunc( turret.sentientpool, turret.sentientpoolindex );
    linkedchildren = turret getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( isdefined( child ) )
        {
            child unlink();
        }
    }
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    turret.colmodel unlink();
    turret.colmodel hide();
    sentryturret_setinactive( turret );
    turret hide();
    turret.carriedby = self;
    turret notify( #"carried" );
    namespace_9d8e359c3b1041e5::saveweaponstatessharedfunc();
    sentrydata = function_64ba8f03d1de7b25( turret.streakinfo.streakname );
    deployweapon = function_47a76868af26ec22( turret.streakinfo, sentrydata, turret );
    
    if ( self && turret && deployweapon )
    {
        config = level.sentrysettings[ sentrydata.turrettype ];
        
        if ( utility::issharedfuncdefined( turret.streakinfo.streakname, #"oncarry" ) )
        {
            [[ utility::getsharedfunc( turret.streakinfo.streakname, #"oncarry" ) ]]( turret, config );
        }
        
        marker = sentryturret_watchplacement( turret, turret.streakinfo, 1, 2, deployweapon );
        
        if ( self && turret && isdefined( marker ) )
        {
            var_a76d51a51d956fa = 1;
        }
    }
    
    if ( !var_a76d51a51d956fa )
    {
        if ( turret )
        {
            level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
            sentryturret_delete( turret );
        }
        
        if ( self )
        {
            self.bgivensentry = 0;
            utility::callsharedfunc( #"killstreak", #"refundkillstreak", "sentry_gun" );
        }
        
        return;
    }
    
    sentryturret_setplaced( turret, marker );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x1b54d38e, Offset: 0x228b
// Size: 0xb8
function sentryturret_switchbacklastweapon( immediateswitch )
{
    bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
    deployweaponname = bundle.deployweapon ?? "deploy_sentry_mp";
    curweapon = self getcurrentweapon();
    
    if ( curweapon.basename != deployweaponname )
    {
        return;
    }
    
    if ( immediateswitch )
    {
        namespace_9d8e359c3b1041e5::switchtoweaponimmediatesharedfunc( self.lastdroppableweaponobj );
    }
    else
    {
        namespace_9d8e359c3b1041e5::switchtoweaponsharedfunc( self.lastdroppableweaponobj );
    }
    
    namespace_9d8e359c3b1041e5::takeweaponsharedfunc( deployweaponname );
    self notify( #"equip_deploy_cancel" );
    val::group_reset( "sentry" );
}

// Namespace sentry_gun
// Params 1
// Checksum 0xb41a3096, Offset: 0x234b
// Size: 0x3c
function sentryturret_setinactive( turret )
{
    if ( isdefined( turret.useownerobj ) )
    {
        turret.useownerobj setusableenabled( 0 );
        turret.useownerobj unlink();
    }
}

// Namespace sentry_gun
// Params 2
// Checksum 0x9b1a184e, Offset: 0x238f
// Size: 0x60
function sentryturret_delaydeletemarker( turret, marker )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( isdefined( marker.visual ) )
    {
        marker.visual delete();
    }
}

// Namespace sentry_gun
// Params 2
// Checksum 0xa9ddd19f, Offset: 0x23f7
// Size: 0x85
function sentryturret_disableplayeruseonconnect( turret, useobj )
{
    if ( isdefined( turret ) )
    {
        turret endon( #"kill_turret" );
        turret endon( #"death" );
        turret endon( #"carried" );
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        useobj namespace_9d8e359c3b1041e5::disableplayerusesharedfunc( player );
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0xe1891f3, Offset: 0x2484
// Size: 0x131
function sentryturret_watchpickup( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        turret.useownerobj waittill( #"trigger", player );
        
        if ( !isplayer( player ) || !isplayer( self ) )
        {
            continue;
        }
        
        if ( player != self )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"allowpickupofturret" ) )
        {
            if ( !player [[ utility::getsharedfunc( #"sentry_gun", #"allowpickupofturret" ) ]]() )
            {
                continue;
            }
        }
        
        if ( !function_47d86575eecf7d92( turret ) )
        {
            continue;
        }
        
        turret.useownerobj setusableenabled( 0 );
        turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeoff );
        thread sentryturret_setcarried( turret );
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0x9fd604e2, Offset: 0x25bd
// Size: 0x8e
function sentryturret_disableplayerpickuponconnect( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player waittill( #"spawned_player" );
        turret.useownerobj namespace_9d8e359c3b1041e5::disableplayerusesharedfunc( player );
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0xdf4007a0, Offset: 0x2653
// Size: 0x12c
function sentryturret_watchdismantle( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
            
            continue;
        }
        
        if ( player != self )
        {
        }
    }
    
    thread sentryturret_disableplayerdismantleonconnect( turret );
    
    while ( true )
    {
        turret.dismantleobj waittill( #"trigger", player );
        turret notify( #"kill_turret", 0, 1 );
        break;
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0x8a8931ab, Offset: 0x2787
// Size: 0x84
function sentryturret_watchdamage( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"monitordamage" ) )
    {
        self [[ utility::getsharedfunc( #"sentry_gun", #"monitordamage" ) ]]( turret );
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0xfbee7609, Offset: 0x2813
// Size: 0xa1
function sentryturret_disableplayerdismantleonconnect( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player waittill( #"spawned_player" );
        
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
        }
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0xcc32d921, Offset: 0x28bc
// Size: 0x97
function sentryturret_empapplied( data )
{
    bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
    var_20cb8f4e47f3353e = bundle.var_20cb8f4e47f3353e;
    
    if ( namespace_9d8e359c3b1041e5::function_d2b2cb6a7fea26de() < damage_tuning::function_8118e38bf1ed06de( data, var_20cb8f4e47f3353e ) )
    {
        return;
    }
    
    turret = data.victim;
    turret notify( #"kill_turret", 1, 1 );
    self notify( #"enemy_destroyed_equipment", data.attacker );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x8ee597ad, Offset: 0x295b
// Size: 0x87
function sentryturret_empstarted( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker thread utility::callsharedfunc( #"player", #"doScoreEvent", #"emp_disable" );
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empstarted" ) ]]();
        }
    }
    
    function_23198c680e4b78e3( self );
}

// Namespace sentry_gun
// Params 1
// Checksum 0xf4a6cfd, Offset: 0x29ea
// Size: 0x51
function sentryturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
    {
        self [[ utility::getsharedfunc( #"sentry_gun", #"empcleared" ) ]]();
    }
    
    function_23198c680e4b78e3( self );
}

// Namespace sentry_gun
// Params 2
// Checksum 0x34e14885, Offset: 0x2a43
// Size: 0x13d
function function_23198c680e4b78e3( turret, forceupdate )
{
    isemped = turret.empcount > 0;
    isjammed = istrue( turret.isjammed );
    var_251d8987261025ac = isemped || isjammed;
    
    if ( var_251d8987261025ac && ( !turret.isdisabled || forceupdate ) )
    {
        bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
        turret setdefaultdroppitch( bundle.sentryturretdefaultdroppitch ?? 0 );
        self setmode( level.sentrysettings[ self.turrettype ].sentrymodeoff );
        wait 0.4;
        turret.isdisabled = 1;
        
        if ( bundle.var_d5cdd82b2ca23ea3 )
        {
            turret setturretholdstill( 1 );
        }
        
        function_34cf31c70cc86654( turret );
        return;
    }
    
    if ( !var_251d8987261025ac && ( turret.isdisabled || forceupdate ) )
    {
        turret.isdisabled = 0;
        turret setturretholdstill( 0 );
        function_482e3c7ce20bb458( turret );
    }
}

// Namespace sentry_gun
// Params 1, eflags: 0x4
// Checksum 0x1ba9c315, Offset: 0x2b88
// Size: 0x3b
function private function_34cf31c70cc86654( turret )
{
    self turretfiredisable();
    self setmode( level.sentrysettings[ self.turrettype ].sentrymodeoff );
    self laseroff();
}

// Namespace sentry_gun
// Params 1, eflags: 0x4
// Checksum 0x339c5d40, Offset: 0x2bcb
// Size: 0x3b
function private function_482e3c7ce20bb458( turret )
{
    self turretfireenable();
    self setmode( level.sentrysettings[ self.turrettype ].sentrymodeon );
    self laseron();
}

// Namespace sentry_gun
// Params 1
// Checksum 0xa571d70, Offset: 0x2c0e
// Size: 0x193
function sentryturret_watchdeath( turret )
{
    turret endon( #"carried" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed );
    
    if ( isdefined( self ) )
    {
        sentryturret_setinactive( turret );
        
        /#
            if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
            {
                self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x140>", self );
            }
        #/
        
        turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( turret.streakinfo );
    }
    
    if ( wasdestroyed )
    {
        bundle = level.streakglobals.streakbundles[ "sentry_gun" ];
        
        if ( bundle.var_45480ecba03fa84a )
        {
            turret setturretholdstill( 1 );
        }
        
        namespace_9d8e359c3b1041e5::playkillstreakteamleaderdialogsharedfunc( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_destroyed", #"destroyed" );
    }
    
    turret sentryturret_setturretmodel( "destroyed" );
    
    if ( !skipshutdown )
    {
        turret setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        turret setscriptablepartstate( "explode", "violent" );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    sentryturret_delete( turret );
}

// Namespace sentry_gun
// Params 0
// Checksum 0xdfd22dd1, Offset: 0x2da9
// Size: 0x1d
function sentryturret_delayscriptabledelete()
{
    level endon( #"game_ended" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 5 );
    self delete();
}

// Namespace sentry_gun
// Params 1
// Checksum 0xaed18612, Offset: 0x2dce
// Size: 0x112
function sentryturret_watchtimeout( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"death" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_6e2137bbf3d91212 = gettime();
    
    while ( turret.timeout > 0 )
    {
        currenttimems = gettime();
        elapsedtimems = currenttimems - var_6e2137bbf3d91212;
        turret.timeout -= elapsedtimems / 1000;
        var_6e2137bbf3d91212 = currenttimems;
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 0.05 );
    }
    
    turret.timeout = 0;
    namespace_9d8e359c3b1041e5::playkillstreakteamleaderdialogsharedfunc( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_timeout", #"leave" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace sentry_gun
// Params 1
// Checksum 0xf5bfcb7d, Offset: 0x2ee8
// Size: 0x50
function sentryturret_watchdisown( turret )
{
    turret endon( #"kill_turret", #"death", #"carried" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x419070dd, Offset: 0x2f40
// Size: 0x9a
function sentryturret_watchgameend( turret )
{
    turret endon( #"kill_turret", #"death", #"carried" );
    level waittill( #"game_ended" );
    
    if ( self && turret.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo );
        }
    }
    
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace sentry_gun
// Params 1
// Checksum 0xd04617df, Offset: 0x2fe2
// Size: 0x10b
function sentryturret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "placed" )
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modelbaseground;
    }
    else
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modeldestroyedground;
    }
    
    if ( isdefined( self.var_a96305f184ce69af.blueprintname ) && isdefined( self.var_a96305f184ce69af.var_777ca86f76320f94 ) )
    {
        self setgenericblueprintmodel( self.var_a96305f184ce69af.blueprintname, self.var_a96305f184ce69af.var_777ca86f76320f94 );
    }
    
    /#
        modeltype = getdvarint( @"hash_e19e5d308effeda3", 1 );
        
        if ( !modeltype )
        {
            turretmodel = "<dev string:x161>";
        }
    #/
    
    assert( isdefined( turretmodel ), "<dev string:x17c>" );
    self setmodel( turretmodel );
    self.var_b63edf1fc78a71c4 = 1;
}

// Namespace sentry_gun
// Params 3
// Checksum 0x10bc06e0, Offset: 0x30f5
// Size: 0x1a3
function function_47a76868af26ec22( streakinfo, sentrydata, existingturret )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    endonnotify = "sentry_placement_failed";
    
    if ( utility::issharedfuncdefined( #"weapons", #"watchforplacementfirestate" ) )
    {
        self thread [[ utility::getsharedfunc( #"weapons", #"watchforplacementfirestate" ) ]]( streakinfo, endonnotify );
    }
    
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    deployweaponname = bundle.deployweapon ?? "deploy_sentry_mp";
    blueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    deployweapon = undefined;
    
    if ( isdefined( blueprintname ) )
    {
        deployweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( blueprintname, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    else
    {
        attachments = getweapondefaultattachments( deployweaponname );
        deployweapon = makeweapon( deployweaponname, attachments );
    }
    
    streakinfo.var_53cb7968c54bb61d = 1;
    streakinfo.var_37df6fe5dd599cc0 = 0;
    deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponswitchdeploysharedfunc( streakinfo, deployweapon, 1, undefined, undefined, &weaponcleanupsentryturret );
    
    if ( !deployresult )
    {
        self notify( endonnotify );
        self.bgivensentry = 0;
        return;
    }
    
    val::group_set( "sentry", 0 );
    self playsound( "kls_sentry_pickup" );
    return deployweapon;
}

// Namespace sentry_gun
// Params 1
// Checksum 0x2071495, Offset: 0x32a1
// Size: 0x94, Type: bool
function function_47d86575eecf7d92( existingturret )
{
    currentstance = self getstance();
    
    if ( currentstance == "stand" || currentstance == "crouch" )
    {
        return true;
    }
    
    cannotcrouch = self getstanceblocked( "crouch" );
    
    if ( cannotcrouch )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace sentry_gun
// Params 1
// Checksum 0xe9a9671c, Offset: 0x333e
// Size: 0x18f
function sentry_attacktargets( var_926c66af24bdeb68 )
{
    /#
        self.owner endon( #"manual_shoot_at_target" );
    #/
    
    self endon( #"kill_turret" );
    self endon( #"death" );
    self endon( #"carried" );
    level endon( #"game_ended" );
    self.momentum = 0;
    self setscriptablepartstate( "idle_scanning_and_player_targeting", "idle_start", 0 );
    streakname = self.streakinfo.streakname;
    bundle = level.streakglobals.streakbundles[ streakname ];
    var_a62db6a9362bca9b = istrue( bundle.var_70f777acecd34f83 );
    
    if ( bundle.var_c221127c0f70d5ba ?? 1 )
    {
        self laseroff();
    }
    
    while ( true )
    {
        self waittill( #"turretstatechange" );
        
        if ( self isfiringturret() )
        {
            if ( bundle.var_505a04aea155cf6e ?? 1 )
            {
                self laseroff();
            }
            else
            {
                self laseron();
            }
            
            self setscriptablepartstate( "idle_scanning_and_player_targeting", "player_targeting_trigger", 0 );
            
            if ( self getmode() == "manual" )
            {
                continue;
            }
            
            thread sentry_burstfirestart( var_926c66af24bdeb68, undefined, var_a62db6a9362bca9b );
            continue;
        }
        
        if ( bundle.var_c221127c0f70d5ba ?? 1 )
        {
            self laseroff();
        }
        else
        {
            self laseron();
        }
        
        self setscriptablepartstate( "idle_scanning_and_player_targeting", "idle_start", 0 );
        thread sentry_spindown( bundle );
        thread sentry_burstfirestop();
    }
}

/#

    // Namespace sentry_gun
    // Params 1
    // Checksum 0x83ceb30c, Offset: 0x34d5
    // Size: 0x27c, Type: dev
    function function_9af1305fb37c8555( var_926c66af24bdeb68 )
    {
        self endon( #"kill_turret" );
        self endon( #"death" );
        self endon( #"carried" );
        level endon( #"game_ended" );
        self.turrettarget = spawn( "<dev string:x1c1>", self gettagorigin( #"tag_flash" ) + anglestoforward( self gettagangles( #"tag_flash" ) * 300 ) );
        self.turrettarget.targeton = 0;
        self.turrettarget dontinterpolate();
        self.turrettarget thread function_bd4050d0ad153be2( self );
        self.turrettarget thread function_8fde2339d0c5440e( self );
        var_da2d7a72e68a9626 = undefined;
        
        if ( isdefined( var_926c66af24bdeb68 ) )
        {
            var_da2d7a72e68a9626 = var_926c66af24bdeb68;
        }
        else
        {
            var_da2d7a72e68a9626 = level.sentrysettings[ self.turrettype ];
        }
        
        sentrymode = var_da2d7a72e68a9626.sentrymodeon;
        manualmode = "<dev string:x1ce>";
        turretmode = sentrymode;
        notifyon = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_c9bd691ce96079ac", 0 ) == 1 )
            {
                if ( !notifyon )
                {
                    self.owner notifyonplayercommand( "<dev string:x1dc>", "<dev string:x1f3>" );
                    notifyon = 1;
                }
                
                self.owner waittill( #"manual_shoot_at_target" );
                
                if ( turretmode != manualmode )
                {
                    self setmode( manualmode );
                    turretmode = manualmode;
                    starttrace = self.owner getvieworigin();
                    endtrace = starttrace + anglestoforward( self.owner getplayerangles() ) * 50000;
                    trace = trace::ray_trace( starttrace, endtrace, self.owner );
                    endpos = undefined;
                    
                    if ( isdefined( trace[ "<dev string:x200>" ] ) && trace[ "<dev string:x200>" ] != "<dev string:x208>" )
                    {
                        endpos = trace[ "<dev string:x215>" ];
                    }
                    
                    if ( isdefined( endpos ) )
                    {
                        thread function_19b4cffcd9af1928( endpos );
                    }
                }
                else
                {
                    function_1edb521e572f5da8();
                    turretmode = sentrymode;
                    self setmode( turretmode );
                    thread sentry_attacktargets();
                }
                
                continue;
            }
            
            notifyon = 0;
            
            if ( turretmode != sentrymode )
            {
                self.owner notifyonplayercommandremove( "<dev string:x1dc>", "<dev string:x1f3>" );
                function_1edb521e572f5da8();
                turretmode = sentrymode;
                self setmode( turretmode );
                thread sentry_attacktargets();
            }
            
            waitframe();
        }
    }

    // Namespace sentry_gun
    // Params 1
    // Checksum 0x78fe08b6, Offset: 0x3759
    // Size: 0x217, Type: dev
    function function_19b4cffcd9af1928( firepos )
    {
        self.owner endon( #"stop_manual_target" );
        self.owner endon( #"manual_shoot_at_target" );
        self endon( #"kill_turret" );
        self endon( #"death" );
        self endon( #"carried" );
        level endon( #"game_ended" );
        self laseron();
        thread sentry_burstfirestop();
        self.turrettarget.origin = firepos;
        self settargetentity( self.turrettarget );
        self.turrettarget.targeton = 1;
        starttag = #"tag_aim_animated";
        
        if ( self.streakinfo.streakname == "<dev string:x21e>" )
        {
            starttag = #"barrel_animate_jnt";
        }
        
        endtag = #"tag_flash";
        wait 1;
        self laseron();
        
        while ( true )
        {
            var_22d188c5c239532c = self gettagorigin( starttag );
            var_5f44ac430764d62e = self gettagangles( starttag );
            sphere( var_22d188c5c239532c, 2, ( 0, 1, 1 ), 0, int( 1 / level.framedurationseconds ) );
            line( var_22d188c5c239532c, var_22d188c5c239532c + anglestoforward( var_5f44ac430764d62e ) * 1800, ( 0, 1, 1 ), 1, 0, int( 1 / level.framedurationseconds ) );
            flashtagorigin = self gettagorigin( endtag );
            var_9d1c6b53d42e88 = self gettagangles( endtag );
            sphere( flashtagorigin, 2, ( 1, 1, 0 ), 0, int( 1 / level.framedurationseconds ) );
            line( flashtagorigin, flashtagorigin + anglestoforward( var_9d1c6b53d42e88 ) * 1800, ( 1, 1, 0 ), 1, 0, int( 1 / level.framedurationseconds ) );
            sentry_burstfirestart( undefined, undefined, 1 );
            wait 1;
        }
    }

    // Namespace sentry_gun
    // Params 0
    // Checksum 0x9a1dfdf, Offset: 0x3978
    // Size: 0x41, Type: dev
    function function_1edb521e572f5da8()
    {
        self cleartargetentity();
        self laseroff();
        thread sentry_burstfirestop();
        self.turrettarget.targeton = 0;
        self.owner notify( #"stop_manual_target" );
    }

    // Namespace sentry_gun
    // Params 1
    // Checksum 0xb8dda0a1, Offset: 0x39c1
    // Size: 0x83, Type: dev
    function function_bd4050d0ad153be2( turret )
    {
        turret endon( #"kill_turret" );
        turret endon( #"death" );
        turret endon( #"carried" );
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( self.targeton )
            {
                sphere( self.origin, 20, ( 1, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace sentry_gun
    // Params 1
    // Checksum 0xf3e2514f, Offset: 0x3a4c
    // Size: 0x2f, Type: dev
    function function_8fde2339d0c5440e( turret )
    {
        self endon( #"death" );
        turret waittill( #"death" );
        self delete();
    }

#/

// Namespace sentry_gun
// Params 1
// Checksum 0x9b9d030f, Offset: 0x3a83
// Size: 0x51
function sentry_spinup( var_926c66af24bdeb68 )
{
    self notify( #"hash_771e6c90f42397b6" );
    
    while ( self.momentum < var_926c66af24bdeb68.spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0x9423f063, Offset: 0x3adc
// Size: 0xb9
function sentry_spindown( bundle )
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"turretstatechange" );
    self endon( #"hash_771e6c90f42397b6" );
    
    if ( isdefined( bundle.var_6f9750800bff8f4b ) )
    {
        wait bundle.var_6f9750800bff8f4b;
    }
    
    self notify( #"hash_1ee0767c965f8fff" );
    
    if ( bundle.var_86cc9b2f5053e680 )
    {
        while ( self.momentum > 0 )
        {
            self.momentum -= 0.1;
            wait 0.1;
        }
        
        return;
    }
    
    self.momentum = 0;
}

// Namespace sentry_gun
// Params 3
// Checksum 0xfb5eefe3, Offset: 0x3b9d
// Size: 0x2bd
function sentry_burstfirestart( var_926c66af24bdeb68, var_bf3bf8023c049fcd, var_70f777acecd34f83 )
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"stop_shooting" );
    self endon( #"hash_1ee0767c965f8fff" );
    level endon( #"game_ended" );
    var_da2d7a72e68a9626 = var_926c66af24bdeb68 ?? level.sentrysettings[ self.turrettype ];
    sentrydata = function_64ba8f03d1de7b25( self.streakname );
    
    if ( utility::issharedfuncdefined( sentrydata.var_a1ff4562e4dc0818, #"hash_fe9b7e41ee4c3a1f" ) )
    {
        self thread [[ utility::getsharedfunc( sentrydata.var_a1ff4562e4dc0818, #"hash_fe9b7e41ee4c3a1f" ) ]]();
    }
    
    sentry_spinup( var_da2d7a72e68a9626 );
    shoot_turret_tag = var_da2d7a72e68a9626.var_8639f03182946365 ?? #"tag_flash";
    
    if ( level.streakglobals.streakbundles[ self.streakname ].var_88a23ab1179f8d0 )
    {
        target = self getturrettarget( 0 );
        childthread sentry_watchtargetdeath( target );
    }
    
    while ( true )
    {
        if ( getdvarfloat( @"testheight", 0 ) > 0 )
        {
            var_da2d7a72e68a9626.var_82765fcc48b457dc = getdvarfloat( @"testheight", 0 );
        }
        
        if ( isdefined( var_da2d7a72e68a9626.var_82765fcc48b457dc ) )
        {
            target = self getturrettarget( 0 );
            
            if ( isdefined( target ) )
            {
                if ( distancesquared( self.origin, target.origin ) < 3600 )
                {
                    self setconvergenceheightpercent( var_da2d7a72e68a9626.var_82765fcc48b457dc );
                }
                else
                {
                    self setconvergenceheightpercent( 0.65 );
                }
            }
        }
        
        numshots = randomintrange( var_da2d7a72e68a9626.burstmin, var_da2d7a72e68a9626.burstmax + 1 );
        
        if ( isdefined( var_bf3bf8023c049fcd ) )
        {
            numshots = var_bf3bf8023c049fcd;
        }
        
        prefiretime = self prefireturret();
        
        if ( prefiretime > 0 )
        {
            wait prefiretime;
        }
        
        for ( i = 0; i < numshots && !self.overheated ; i++ )
        {
            self shootturret( shoot_turret_tag, var_da2d7a72e68a9626.lockstrength );
            self.streakinfo.shots_fired++;
            wait weaponfiretime( var_da2d7a72e68a9626.weaponinfo );
        }
        
        if ( var_70f777acecd34f83 )
        {
            self cleartargetentity();
            self.momentum = 0;
            break;
        }
        
        wait randomfloatrange( var_da2d7a72e68a9626.pausemin, var_da2d7a72e68a9626.pausemax );
    }
}

// Namespace sentry_gun
// Params 1
// Checksum 0x296efbf7, Offset: 0x3e62
// Size: 0x34
function sentry_watchtargetdeath( target )
{
    target waittill( #"death_or_disconnect" );
    self.momentum = 0;
    self.target = undefined;
    self cleartargetentity();
}

// Namespace sentry_gun
// Params 0
// Checksum 0x116ba1df, Offset: 0x3e9e
// Size: 0xe
function sentry_burstfirestop()
{
    self notify( #"stop_shooting" );
}

// Namespace sentry_gun
// Params 0
// Checksum 0xf8352fca, Offset: 0x3eb4
// Size: 0xc5
function turret_heatmonitor()
{
    /#
        self.owner endon( #"manual_shoot_at_target" );
    #/
    
    self endon( #"kill_turret" );
    self endon( #"death" );
    self endon( #"carried" );
    level endon( #"game_ended" );
    overheattime = level.sentrysettings[ self.turrettype ].overheattime;
    
    while ( true )
    {
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            
            while ( self.heatlevel )
            {
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( #"not_overheated" );
        }
        
        wait 0.05;
    }
}

// Namespace sentry_gun
// Params 0
// Checksum 0x55407e90, Offset: 0x3f81
// Size: 0x79
function playheatfx()
{
    self endon( #"death" );
    self endon( #"not_overheated" );
    level endon( #"game_ended" );
    self notify( #"hash_a49d775cc1653783" );
    self endon( #"hash_a49d775cc1653783" );
    
    for ( ;; )
    {
        playfxontag( utility::getfx( "sentry_overheat_mp" ), self, #"tag_flash" );
        wait level.sentrysettings[ self.turrettype ].fxtime;
    }
}

// Namespace sentry_gun
// Params 0
// Checksum 0xc10d355a, Offset: 0x4002
// Size: 0xb0
function turret_coolmonitor()
{
    /#
        self.owner endon( #"manual_shoot_at_target" );
    #/
    
    self endon( #"kill_turret" );
    self endon( #"death" );
    self endon( #"carried" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
            {
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            }
            else
            {
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace sentry_gun
// Params 2
// Checksum 0xfb207f8b, Offset: 0x40ba
// Size: 0x1f4
function sentryturret_hack( newowner, oldowner )
{
    self notify( #"turret_hacked" );
    self setturretowner( newowner );
    self.owner = newowner;
    
    if ( isdefined( newowner.team ) )
    {
        self setturretteam( newowner.team );
        self.team = newowner.team;
    }
    else
    {
        self setturretteam( "neutral" );
        self.team = "neutral";
    }
    
    if ( newowner && utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        newowner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( self.streakinfo.streakname );
    }
    
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( newowner, newowner.team, 2000, self.streakinfo.streakname );
    
    if ( newowner )
    {
        newowner function_65a8665b05618e72( self );
        newowner thread sentryturret_watchpickup( self );
    }
    
    var_a885d5f3931619f4 = level.sharedfuncs[ #"killstreak" ][ #"getkillstreakminimapicon" ];
    
    if ( isdefined( var_a885d5f3931619f4 ) )
    {
        minimapicon = [[ var_a885d5f3931619f4 ]]( self.streakinfo.streakname );
    }
    
    if ( !isdefined( minimapicon ) )
    {
        minimapicon = "hud_icon_minimap_killstreak_sentry";
    }
    
    functionals_utility::clearminimapid();
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        self.minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( minimapicon, newowner.team, undefined, 1, 1 );
    }
    
    if ( level.teambased )
    {
        self filteroutplayermarks( newowner.team );
        return;
    }
    
    self filteroutplayermarks( newowner );
}

// Namespace sentry_gun
// Params 1
// Checksum 0x1d55eb22, Offset: 0x42b6
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace sentry_gun
// Params 0
// Checksum 0xc4789fb, Offset: 0x42d5
// Size: 0x11
function function_fb3b9c035597125d()
{
    self notify( #"kill_turret", 1, 0 );
}

// Namespace sentry_gun
// Params 4, eflags: 0x4
// Checksum 0xbae65762, Offset: 0x42ee
// Size: 0xed
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "sentry_gun" );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "sentry_gun" ] ) && self.rapidkill_data[ "sentry_gun" ].rapidkill_count === 5 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_crackdown" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "sentry_gun", victim );
    }
}

