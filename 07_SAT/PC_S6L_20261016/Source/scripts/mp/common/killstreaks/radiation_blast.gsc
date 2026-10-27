// scripts\mp\common\killstreaks\radiation_blast.gsc  (hash_3a75dfeaf8482a06.gscc) (size: 27762 Bytes / 0x6c72 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a283a4a (1512585802)
// size ...... 27762 (0x6c72)
// includes .. 23  (offset: 0x67c2)
// strings ... 58  (offset: 0x687a)
// dev strs .. 4   (offset: 0x6c3e)
// exports ... 61  (offset: 0x4702)
// cseg ...... 0x4dd + 0x4225 (0x4702)
// imports ... 191 (offset: 0x508a)
// animtree1 . 0   (offset: 0x6c72)
// animtree2 . 0   (offset: 0x6c72)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\killstreaks\manual_turret_mp;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\gameobjects;

#namespace radiation_blast;

// Namespace radiation_blast
// Params 0, eflags: 0x1
// Checksum 0xf5249250, Offset: 0x4fb
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "radiation_blast" ), &function_cd77d690ae0c4563 );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xc1a5bc71, Offset: 0x51a
// Size: 0x617
function private function_cd77d690ae0c4563()
{
    bundle = level.streakglobals.streakbundles[ "radiation_blast" ];
    killstreak_utility::registervisibilityomnvarforkillstreak( "radiation_blast", "on", 29 );
    killstreaks::registerkillstreak( "radiation_blast", &function_e676c47d6809057f );
    level._effect[ "vfx_sat_core_strk_gammacore_screen_dist" ] = loadfxasset( "vfx_sat_core_strk_gammacore_screen_dist" );
    utility::registersharedfunc( #"radiation_blast", #"createhintobject", &createhintobject );
    utility::registersharedfunc( #"radiation_blast", #"gettargetmarker", &gettargetmarker );
    utility::registersharedfunc( #"radiation_blast", #"allowpickupofturret", &function_93ca4f09d0d5e3f8 );
    utility::registersharedfunc( #"radiation_blast", #"handlemovingplatform", &manual_turret_mp::manual_turret_handlemovingplatform );
    utility::registersharedfunc( #"radiation_blast", #"attachxrays", &attachxrays );
    utility::registersharedfunc( #"radiation_blast", #"hack", &hack );
    level.sentrysettings[ "radiation_blast" ] = spawnstruct();
    level.sentrysettings[ "radiation_blast" ].health = 999999;
    level.sentrysettings[ "radiation_blast" ].lockstrength = 6;
    level.sentrysettings[ "radiation_blast" ].sentrymodeon = "sentry";
    level.sentrysettings[ "radiation_blast" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "radiation_blast" ].spinuptime = 0.65;
    level.sentrysettings[ "radiation_blast" ].overheattime = 8;
    level.sentrysettings[ "radiation_blast" ].cooldowntime = 0.3;
    level.sentrysettings[ "radiation_blast" ].fxtime = 0.3;
    level.sentrysettings[ "radiation_blast" ].streakname = "radiation_blast";
    level.sentrysettings[ "radiation_blast" ].weaponinfo = bundle.spawnweapon ?? "sat_radiation_blast";
    level.sentrysettings[ "radiation_blast" ].playerweaponinfo = bundle.deployweapon ?? "sat_deploy_radiation_blast_mp";
    level.sentrysettings[ "radiation_blast" ].modelbaseground = bundle.var_8a813d89709d46a5 ?? "streak_sat_wm_radiation_blast_turret";
    level.sentrysettings[ "radiation_blast" ].modeldestroyedground = bundle.var_5ede6a1098a35799 ?? "streak_sat_wm_radiation_blast_turret";
    level.sentrysettings[ "radiation_blast" ].var_82765fcc48b457dc = bundle.var_30508d94d8d55a09;
    level.sentrysettings[ "radiation_blast" ].var_8639f03182946365 = bundle.var_59750b2550aba598 ?? #"tag_flash";
    level.sentrysettings[ "radiation_blast" ].mod = bundle.means_of_death ?? "MOD_FIRE";
    level.sentrysettings[ "radiation_blast" ].placementhintstring = &"killstreaks_hints/radiation_blast_place";
    level.sentrysettings[ "radiation_blast" ].ownerusehintstring = &"killstreaks_hints/radiation_blast_use";
    level.sentrysettings[ "radiation_blast" ].otherusehintstring = &"hash_22edd4c0469a442c";
    level.sentrysettings[ "radiation_blast" ].dismantlehintstring = &"killstreaks_hints/radiation_blast_dismantle";
    level.sentrysettings[ "radiation_blast" ].headicon = 1;
    level.sentrysettings[ "radiation_blast" ].destroyedsplash = "callout_destroyed_sentry_gun";
    level.sentrysettings[ "radiation_blast" ].shouldsplash = 1;
    level.sentrysettings[ "radiation_blast" ].votimeout = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "radiation_blast" ].vodestroyed = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "radiation_blast" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "radiation_blast" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "radiation_blast" ].iskillstreak = 1;
    level.sentrysettings[ "radiation_blast" ].headiconoffset = ( 0, 0, 75 );
    level.sentrysettings[ "radiation_blast" ].var_6aafebc8092b3e23 = ( bundle.var_4938d5a5660348d9 ?? 0 ) * 1000 + level.spawnprotectiontimer * 1000;
    level.var_4ee6fb337a3c7ac[ level.sentrysettings[ "radiation_blast" ].weaponinfo ] = 1;
    val::group_register( "radiation_blast_deploy", [ "allow_movement", "allow_jump", "usability", "melee", "offhand_weapons", "supers", "killstreaks" ] );
    callback::add( #"player_spawned", &on_player_spawned );
    utility::registersharedfunc( #"radiation_blast", #"gettargetmarker", &gettargetmarker );
    utility::flag_set( "radiation_blast_initialized" );
    
    /#
        setdevdvarifuninitialized( @"hash_eafda08f2957ff20", 0 );
    #/
}

// Namespace radiation_blast
// Params 1
// Checksum 0x25b7264f, Offset: 0xb39
// Size: 0x37
function on_player_spawned( params )
{
    self.var_2f5b6588a453ae1d = gettime() + int( level.sentrysettings[ "radiation_blast" ].var_6aafebc8092b3e23 );
}

// Namespace radiation_blast
// Params 11
// Checksum 0x8845a73b, Offset: 0xb78
// Size: 0x7b
function createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    return gameobjects::createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov );
}

// Namespace radiation_blast
// Params 1
// Checksum 0xd900d0d7, Offset: 0xbfc
// Size: 0x129
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = level.sentrysettings[ "radiation_blast" ];
    notifyattacker = damage::onkillstreakkilled( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash );
    self notify( #"enemy_destroyed_equipment", attacker );
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" || type == "MOD_CRUSH" )
    {
        explosivedamage = 1;
    }
    
    self notify( #"kill_turret", explosivedamage, 1, 0, 0, attacker );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x8323fb73, Offset: 0xd2d
// Size: 0x137
function modifydamage( data )
{
    bundle = level.streakglobals.streakbundles[ "radiation_blast" ];
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else
    {
        modifieddamage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 12, 400 );
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "throwstar_mp" )
    {
        modifieddamage = 0;
    }
    
    return modifieddamage;
}

// Namespace radiation_blast
// Params 0
// Checksum 0xd0f3a0ee, Offset: 0xe6d
// Size: 0x3, Type: bool
function function_93ca4f09d0d5e3f8()
{
    return false;
}

// Namespace radiation_blast
// Params 1
// Checksum 0xbffe6aa4, Offset: 0xe79
// Size: 0x22
function attachxrays( turret )
{
    turret setentityhudoutlinedata( 3, turret.team );
    return turret;
}

// Namespace radiation_blast
// Params 2
// Checksum 0x8dc204d1, Offset: 0xea4
// Size: 0x30
function gettargetmarker( streakinfo, ignorecancel )
{
    assert( isplayer( self ), "<dev string:x24>" );
    return target_marker::gettargetmarker( streakinfo, ignorecancel );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x2865ca87, Offset: 0xedd
// Size: 0x147, Type: bool
function function_e676c47d6809057f( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    
    if ( !isdefined( streakinfo.weaponname ) )
    {
        streakinfo.weaponname = bundle.deployweapon;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    weaponobj = makeweapon( bundle.deployweapon );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"watchforplacementfirestate" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( streakinfo, endonnotify, weaponobj );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, 1, undefined, undefined, &weaponcleanup );
    
    if ( !deployresult )
    {
        self notify( endonnotify );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self notify( endonnotify );
            return false;
        }
    }
    
    if ( !carry( streakinfo, 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace radiation_blast
// Params 3, eflags: 0x4
// Checksum 0x4e406062, Offset: 0x102d
// Size: 0x2d
function private weaponcleanup( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x4ebad890, Offset: 0x1062
// Size: 0xfe, Type: bool
function private carry( streakinfo, var_ff3ad3c9d65b87ae )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    thread delayplacementinstructions( 2 );
    val::set( "radiation_blast", "ladder", 0 );
    marker = function_ad137095f80dfc4e( streakinfo, var_ff3ad3c9d65b87ae );
    
    if ( !marker )
    {
        val::reset( "radiation_blast", "ladder" );
        return false;
    }
    
    val::group_set( "radiation_blast_deploy", 0 );
    player::_freezecontrols( 1 );
    thread unfreezecontrolsonroundend();
    var_1f928b160f6c87c3 = create( streakinfo, marker, 1.4 );
    
    if ( var_1f928b160f6c87c3 )
    {
        place( streakinfo, var_1f928b160f6c87c3 );
    }
    else
    {
        assertmsg( "<dev string:x58>" );
    }
    
    val::group_reset( "radiation_blast_deploy" );
    val::reset( "radiation_blast", "ladder" );
    self notify( #"hash_2a49ce094d3a7dcf" );
    player::_freezecontrols( 0 );
    return isdefined( var_1f928b160f6c87c3 );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xdde77060, Offset: 0x1169
// Size: 0x2c
function private unfreezecontrolsonroundend()
{
    self endon( #"disconnect", #"hash_2a49ce094d3a7dcf" );
    level waittill( #"round_switch" );
    player::_freezecontrols( 0 );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x493176da, Offset: 0x119d
// Size: 0x58
function private delayplacementinstructions( delaytime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"turret_placement_finished" );
    level endon( #"game_ended" );
    wait delaytime;
    self setclientomnvar( "ui_turret_placement", 1 );
    thread manual_turret::manualturret_clearplacementinstructions( "death" );
    thread manual_turret::manualturret_clearplacementinstructions( "turret_placement_finished" );
}

// Namespace radiation_blast
// Params 3, eflags: 0x4
// Checksum 0xb40ae5c1, Offset: 0x11fd
// Size: 0x506
function private create( streakinfo, marker, delayspawntime )
{
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    
    if ( !isdefined( delayspawntime ) )
    {
        delayspawntime = 0;
    }
    
    remotesentryvehicletype = bundle.deployedvehicle ?? "veh_remote_turret";
    spawndata = { #owner:self, #angles:marker.angles, #targetname:remotesentryvehicletype, #vehicletype:remotesentryvehicletype, #origin:marker.location };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !turret )
    {
        assertmsg( "<dev string:x79>" );
        return;
    }
    
    turret thread function_44cc4da12ed3031( self );
    turret.team = self.team;
    turret.teamfriendlyto = self.team;
    turret.owner = self;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret setnodeploy( 1 );
    turret.streakinfo = streakinfo;
    turret.turrettype = "radiation_blast";
    turret.shouldsplash = 1;
    turret.timeout = bundle.var_217db254ca29ec8f ?? 120;
    turret.lifetimeendtime = int( turret.timeout * 1000 + gettime() );
    turret.maxtimeout = turret.timeout;
    turret.health = bundle.maxhealth ?? 900;
    turret.maxhealth = turret.health;
    turret.medhealth = turret.maxhealth * 2 / 3;
    turret.lowhealth = turret.maxhealth / 3;
    turret setcandamage( 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"radiation_blast" ][ #"attachxrays" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret = self [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    else
    {
        turret = undefined;
    }
    
    turret.dangerzone = namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"hash_e83d99fb3357b241", turret.origin, turret.team, turret.owner, turret );
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            turret.timeout = 9999;
        }
    #/
    
    turret setscriptablepartstate( #"visibility", #"hide" );
    turret function_7f2194db8c3af979();
    turret emp_debuff::allow_emp( 0 );
    turretweapon = turret getturretweapon();
    
    if ( turretweapon )
    {
        killstreaks::registerkillstreakdamagedealingweapon( turret.streakinfo.streakname, turretweapon.basename, #"medium" );
    }
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        turret thread killstreak_shared::function_585fb909f40d8659( turret.lifetimeendtime, bundle.alertfulllength, bundle.var_c3193942aa25f78, bundle.var_28e5801bce7f4815, bundle.var_b84c3eae995cb030, bundle.var_ed6c729701a7f3ed );
    }
    
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "streak_sat_vm_radiation_blast_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    
    if ( bundle.var_d4395803edd6f6c6 )
    {
        turret.navbounds = createnavobstaclebybounds( turret.origin, ( 1, 1, 1 ) * bundle.var_d4395803edd6f6c6, turret.angles );
    }
    
    turret.marker = marker;
    
    if ( self hasweapon( bundle.deployweapon ) )
    {
        killstreak_utility::killstreak_switchbacklastweapon( bundle.deployweapon, 1, delayspawntime );
    }
    
    callback::callback( "remote_sentry_deployed", { #player:self } );
    utility::function_969f9f5596dba07a( turret, &function_fb3b9c035597125d );
    turret init_kill_cam();
    return turret;
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x39f788d1, Offset: 0x170c
// Size: 0x32
function private function_44cc4da12ed3031( owner )
{
    self endon( #"hash_db521cf8a268eb0a" );
    owner waittill( #"death_or_disconnect" );
    
    if ( self )
    {
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x6f7f9e21, Offset: 0x1746
// Size: 0x4e
function private init_kill_cam()
{
    killcament = spawn( "script_model", self.origin );
    killcament setmodel( "tag_origin" );
    killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "turret" );
    self.killcament = killcament;
    thread updatekillcam( killcament );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x2e3e22fd, Offset: 0x179c
// Size: 0x12a
function private updatekillcam( killcament )
{
    self endon( #"death" );
    var_912453fa91d3563e = 0.22;
    var_f98c92f7975262e2 = 0.25;
    var_16d1bbec56a55ca4 = 10;
    var_2b296534a949828 = 0;
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        else if ( self.killcamtarget )
        {
            dirvector = self.killcamtarget getcentroid() - killcament.origin;
            targetangles = vectortoangles( dirvector );
            targetangles = angleclamp180( targetangles );
            targetangles = ( clamp( targetangles[ 0 ], -45, 45 ), targetangles[ 1 ], 0 );
            killcament rotateto( targetangles, var_912453fa91d3563e );
        }
        else if ( !var_2b296534a949828 )
        {
            targetangles = ( var_16d1bbec56a55ca4, self.angles[ 1 ], 0 );
            killcament rotateto( targetangles, var_912453fa91d3563e );
            var_2b296534a949828 = 1;
        }
        
        killcamoffset = ( -30, 0, 35 );
        targetorigin = self.origin + rotatevector( killcamoffset, targetangles );
        killcament moveto( targetorigin, var_f98c92f7975262e2 );
        waitframe();
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x79602c65, Offset: 0x18ce
// Size: 0x12
function private function_fb3b9c035597125d()
{
    self notify( #"kill_turret", 1, 0, 0 );
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0xca2d04f, Offset: 0x18e8
// Size: 0x71b
function private place( streakinfo, turret )
{
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    turret.empapplycallback = &empstarted;
    turret.empremovecallback = &empremoved;
    
    if ( !isdefined( self.placedsentries ) )
    {
        self.placedsentries = [];
    }
    
    if ( !isdefined( self.placedsentries[ turret.turrettype ] ) )
    {
        self.placedsentries[ turret.turrettype ] = [];
    }
    
    if ( turret.shouldsplash )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level thread [[ var_32dbca3143d9c4a5 ]]( "used_radiation_blast", self );
        }
        
        turret.shouldsplash = 0;
    }
    
    turret setcandamage( 1 );
    turret setscriptablepartstate( #"visibility", #"show" );
    turret dontinterpolate();
    marker = turret.marker;
    
    if ( isdefined( marker.moving_platform ) )
    {
        turret.moving_platform = marker.moving_platform;
        turret.moving_platform_offset = marker.moving_platform_offset;
        turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
        
        if ( isdefined( turret.moving_platform.vehicletype ) )
        {
            turret linkto( turret.moving_platform );
        }
    }
    
    turret vehicle_teleport( marker.location, marker.angles, 0 );
    turret setturrettargetlocalangles( marker.angles, 0, 1 );
    turret clearturrettarget();
    turret setscriptablepartstate( #"turret_carry_state", #"turret_plant" );
    turret setscriptablepartstate( #"lights", #"blinking" );
    turret laseron();
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret );
    turret.streakref = turret.streakinfo.streakname;
    turret showminimapcircle();
    turret.owner.var_e73f627a785541a2[ turret.streakinfo.streakname ] = 0;
    self.placedsentries[ turret.turrettype ] = function_5713d46873b29625( self.placedsentries[ turret.turrettype ] );
    turretcount = self.placedsentries[ turret.turrettype ].size;
    
    if ( turretcount + 1 > 1 )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname, "Killstreak_Ground", self, 0, 1, undefined, undefined );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &handlemovingplatformcollision;
        data.validateaccuratetouching = 1;
        var_756db33d31c779b9 = self getcurrentweapon();
        deployablebounds = var_756db33d31c779b9 function_11cf642482e762bc();
        
        if ( deployablebounds )
        {
            data.var_222269e8fc78589a = 1;
            surfaceclearance = 1.125;
            var_f8d962eedd0b6eb2 = 2.5;
            cylinderradius = deployablebounds.var_79ac3e3bfe82e755 - var_f8d962eedd0b6eb2;
            cylinderheight = deployablebounds.var_5e0312e37bd104d8;
            data.custommidpoint = ( 0, 0, cylinderheight / 2 + surfaceclearance );
            data.customhalfsize = ( cylinderradius, cylinderradius, cylinderheight / 2 );
            
            /#
                if ( getdvarint( @"radiation_blast_deploy_debug", 0 ) == 1 )
                {
                    start = marker.location + ( 0, 0, surfaceclearance );
                    end = start + ( 0, 0, cylinderheight );
                    cylinder( start, end, cylinderradius, ( 1, 0, 0 ), 0, 300 );
                    start = marker.location + ( 0, 0, surfaceclearance + cylinderradius );
                    end = start + ( 0, 0, cylinderheight - 2 * cylinderradius );
                    capsule( start, end, cylinderradius, ( 0, 1, 0 ), 0, 300 );
                }
            #/
        }
        
        if ( isdefined( turret.moving_platform ) )
        {
            data.linkparent = turret.moving_platform;
            data.linkoffset = turret.moving_platform_offset;
            data.angleoffset = turret.moving_platform_angles_offset;
            
            if ( utility::is_moving_platform_ent( turret.moving_platform ) )
            {
                data.var_f07590e06f628942 = 1;
            }
        }
        
        turret thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
    
    turret emp_debuff::allow_emp( 1 );
    thread delaydeletemarker( turret, marker );
    turret thread function_7b6a98dfd8fb8441( self );
    turret setupdamagefunctionality( turret.streakinfo.streakname );
    thread function_b4dd10d0f86f1a43( turret );
    thread function_c3b770691f1a9620( turret );
    thread watchdisown( turret );
    thread watchgameend( turret );
    thread watchdamage( turret );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        thread watchcancel( turret );
    }
    
    turret utility::ent_flag_set( "remote_sentry_deployed" );
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    
    if ( !isdefined( level.var_80c6e313f9c36e80 ) )
    {
        level.var_80c6e313f9c36e80 = [];
    }
    
    level.var_80c6e313f9c36e80[ level.var_80c6e313f9c36e80.size ] = turret;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"radiation_blast" ][ #"munitionused" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    turret thread function_52234c4101999057( streakinfo );
    turret notify( #"hash_db521cf8a268eb0a" );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x317a878e, Offset: 0x200b
// Size: 0x3a
function watchdamage( turret )
{
    turret endon( #"kill_turret" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    monitordamage( turret );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x13bc62bf, Offset: 0x204d
// Size: 0x7f
function monitordamage( turret )
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        turret notify( #"hash_132222844eaf7009" );
        turret thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( turret.maxhealth, "hitequip", &handledeathdamage, &modifydamage, 1 );
    }
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x7bad5971, Offset: 0x20d4
// Size: 0xfc
function private function_ad137095f80dfc4e( streakinfo, var_ff3ad3c9d65b87ae )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"radiation_blast" ][ #"watchforplayerenteringlaststand" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"radiation_blast" ][ #"gettargetmarker" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        marker = self [[ var_32dbca3143d9c4a5 ]]( streakinfo, var_ff3ad3c9d65b87ae );
    }
    else
    {
        marker = undefined;
    }
    
    self notify( #"turret_placement_finished" );
    
    if ( marker.string == "equip_deploy_end" || marker.string == "equip_deploy_cancel" )
    {
        if ( player::isreallyalive() )
        {
            killstreak_utility::killstreak_switchbacklastweapon( streakinfo.bundle.deployweapon );
        }
        
        return;
    }
    
    assert( marker.location, "<dev string:x98>" );
    return marker;
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xb0d0c17, Offset: 0x21d9
// Size: 0x3e
function private showminimapcircle()
{
    if ( self && game_utility::questcircle_exists() )
    {
        return;
    }
    
    game_utility::questcircle_create( "Radiation_Blast", self.origin, 0, self.owner );
    game_utility::questcircle_showtoall();
    thread function_9e352e1e03aafafa();
}

// Namespace radiation_blast
// Params 0, eflags: 0xc
// Checksum 0x2328e674, Offset: 0x221f
// Size: 0x58
function private function_9e352e1e03aafafa()
{
    self notify( #"hash_f31080f65357f86" );
    self endon( #"hash_f31080f65357f86" );
    
    while ( self && game_utility::questcircle_exists() )
    {
        if ( self.radiationradius )
        {
            game_utility::questcircle_move( self.origin );
            game_utility::function_d46d8731ed9d281( self.radiationradius );
        }
        
        waitframe();
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xe600e193, Offset: 0x227f
// Size: 0x1e
function private function_7f2194db8c3af979()
{
    if ( self && game_utility::questcircle_exists() )
    {
        game_utility::questcircle_hidefromall();
        game_utility::questcircle_delete();
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xbe7b9dc4, Offset: 0x22a5
// Size: 0x2c
function private empstarted( data )
{
    disable();
    self setscriptablepartstate( #"empd", #"on", 0 );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xf49ec481, Offset: 0x22d9
// Size: 0x30
function private empremoved()
{
    enable();
    
    if ( self.var_7568cab78e4268cc <= 0 )
    {
        self setscriptablepartstate( #"empd", #"off", 0 );
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x56b78dd8, Offset: 0x2311
// Size: 0x1d
function private handlemovingplatformcollision( data )
{
    self notify( #"kill_turret", 1, 1, 0 );
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x84fcfc78, Offset: 0x2336
// Size: 0x52
function private delaydeletemarker( turret, marker )
{
    turret endon( #"kill_turret" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( marker.visual )
    {
        marker.visual delete();
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0xc
// Checksum 0xa6fbd700, Offset: 0x2390
// Size: 0xa1
function private function_7b6a98dfd8fb8441( owner )
{
    self notify( #"hash_ee4252d1f2055714" );
    self endon( #"hash_ee4252d1f2055714" );
    turret = self;
    turret endon( #"death" );
    turret endon( #"turret_hacked" );
    
    while ( true )
    {
        var_c3bb3c0be331bbf3 = owner function_a365f47836f472d2();
        
        if ( turret.var_b36da400d4dde102 && !var_c3bb3c0be331bbf3 )
        {
            turret.var_b36da400d4dde102 = undefined;
        }
        else if ( var_c3bb3c0be331bbf3 )
        {
            turret.var_b36da400d4dde102 = 1;
        }
        
        wait 0.1;
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xf0a9610d, Offset: 0x2439
// Size: 0x14, Type: bool
function private function_a365f47836f472d2()
{
    return !player::isreallyalive() || player::isinlaststand( self );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x1c76df45, Offset: 0x2456
// Size: 0xae
function setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "destroyed_" + streakname;
    destroyedsplash = "callout_destroyed_" + streakname;
    premoddamagecallback = &premoddamagecallback;
    deathcallback = &handledeathdamage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, undefined, undefined, premoddamagecallback, undefined, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    vehicle_occupancy::register_instance( self );
}

// Namespace radiation_blast
// Params 1
// Checksum 0x8efe2fca, Offset: 0x250c
// Size: 0x1a8, Type: bool
function premoddamagecallback( data )
{
    if ( data.meansofdeath == "MOD_TRIGGER_HURT" )
    {
        return false;
    }
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = self.streakinfo.bundle;
        data.iskillstreak = 1;
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    
    if ( !isdefined( self.damagetaken ) )
    {
        self.damagetaken = 0;
    }
    
    remaininghealth = self.maxhealth - self.damagetaken - data.damage;
    
    if ( remaininghealth < self.medhealth && !self.damagedstate )
    {
        self.damagedstate = 1;
        self setscriptablepartstate( #"turret_damage", #"damaged_light", 0 );
    }
    else if ( remaininghealth < self.lowhealth && self.damagedstate != 2 )
    {
        self.damagedstate = 2;
        self setscriptablepartstate( #"turret_damage", #"damaged_heavy", 0 );
    }
    
    return true;
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x72860a27, Offset: 0x26bd
// Size: 0xac
function private function_b4dd10d0f86f1a43( turret )
{
    turret endon( #"turret_hacked" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee, attacker );
    turret notify( #"remote_sentry_death" );
    turret notify( #"death" );
    turret function_a568b2cd41495e07( skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee, attacker );
    delay = skipshutdown && wascancelled ? 0 : 0.2;
    turret delete_radiation_blast( delay );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xdae16a1, Offset: 0x2771
// Size: 0x110
function private delete_radiation_blast( delay )
{
    turret = self;
    turret utility::ent_flag_clear( "remote_sentry_deployed" );
    
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
    
    if ( isdefined( turret.navbounds ) )
    {
        destroynavobstacle( turret.navbounds );
        turret.navbounds = undefined;
    }
    
    if ( isdefined( turret.dangerzone ) )
    {
        turret.dangerzone = undefined;
    }
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( turret )
    {
        vehicle_occupancy::deregister_instance( turret );
        vehicle_tracking::deregister_instance( turret );
        turret vehicle_tracking::delete_vehicle( turret );
    }
}

// Namespace radiation_blast
// Params 5, eflags: 0x4
// Checksum 0x5509712d, Offset: 0x2889
// Size: 0x291
function private function_a568b2cd41495e07( skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee = 0, attacker )
{
    turret = self;
    owner = turret.owner;
    
    if ( turret )
    {
        turret setscriptablepartstate( #"sfx", #"neutral" );
    }
    
    if ( owner )
    {
        if ( !turret.var_a634fe6f7264e95d )
        {
            turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
            owner killstreak_utility::recordkillstreakendstats( turret.streakinfo );
        }
    }
    
    if ( wasdestroyed && !turret.var_a634fe6f7264e95d && attacker != owner )
    {
        owner killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, undefined, #"destroyed" );
    }
    
    turret.var_c3c4d711e69d5ab9 = 1;
    turret function_7f2194db8c3af979();
    turret function_3d11c2e226e80767();
    
    if ( !skipshutdown )
    {
        turret setscriptablepartstate( #"shutdown", #"on" );
        turret setscriptablepartstate( #"turret_carry_state", #"off" );
        turret setcandamage( 0 );
        turret setscriptablepartstate( #"explode", #"regular" );
        turret setscriptablepartstate( #"vfx", #"neutral" );
        turret setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"neutral" );
        turret setscriptablepartstate( #"sfx", #"neutral" );
        
        if ( isdefined( turret.colmodel ) )
        {
            turret.colmodel delete();
        }
        
        wait 2;
    }
    else if ( !wascancelled )
    {
        var_8a191f37d248ee77 = var_d8d5272b051a15ee ? "regular" : "violent";
        turret setscriptablepartstate( #"explode", var_8a191f37d248ee77 );
        turret setscriptablepartstate( #"vfx", #"neutral" );
        turret setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"neutral" );
        turret setscriptablepartstate( #"sfx", #"neutral" );
    }
    
    if ( !turret.var_a634fe6f7264e95d )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x72e8d18e, Offset: 0x2b22
// Size: 0x135
function private function_c3b770691f1a9620( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"turret_hacked" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( turret.maxtimeout < 0 )
    {
        return;
    }
    
    var_f1d0df94595a00fa = gettime();
    
    while ( turret.timeout > 0 )
    {
        if ( !self.var_71b8d0f973d4bc71 )
        {
            var_4c5d15cdeda35583 = gettime() - var_f1d0df94595a00fa;
            turret.timeout -= var_4c5d15cdeda35583 * 0.001;
            var_21622e853a32f8a4 = clamp( turret.timeout / turret.maxtimeout, 0, 1 );
            self setclientomnvar( "ui_killstreak_lifetime", var_21622e853a32f8a4 );
            self setclientomnvar( "ui_killstreak_countdown", int( 100 * var_21622e853a32f8a4 ) );
            var_f1d0df94595a00fa = gettime();
        }
        
        waitframe();
    }
    
    turret function_3d11c2e226e80767();
    killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, undefined, #"leave" );
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x243687ed, Offset: 0x2c5f
// Size: 0x4c
function private watchdisown( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"turret_hacked" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x2cdfc597, Offset: 0x2cb3
// Size: 0x45
function private watchcancel( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"turret_hacked" );
    self waittill( #"killstreak_cancel" );
    turret notify( #"kill_turret", 1, 0, 1 );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xeac02536, Offset: 0x2d00
// Size: 0x89
function private watchgameend( turret )
{
    turret endon( #"kill_turret" );
    level waittill( #"game_ended" );
    
    if ( self && turret.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo );
        }
    }
    
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x2f9e6bca, Offset: 0x2d91
// Size: 0x5c
function private disable()
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 0;
    }
    
    self.var_7568cab78e4268cc++;
    self.radiationradius = 0;
    
    if ( self.var_7568cab78e4268cc == 1 )
    {
        self setscriptablepartstate( #"lid", #"closed", 0 );
    }
    
    updatevfx( self );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xee3d5889, Offset: 0x2df5
// Size: 0x4a
function private enable()
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 1;
    }
    
    self.var_7568cab78e4268cc--;
    
    if ( self.var_7568cab78e4268cc <= 0 )
    {
        self setscriptablepartstate( #"lid", #"open", 0 );
    }
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x179cba15, Offset: 0x2e47
// Size: 0xaa
function private hack( hackeffect, attacker )
{
    if ( hackeffect.var_30e7de3d76d5a085 )
    {
        steal( hackeffect, attacker );
        return;
    }
    
    disable();
    self setscriptablepartstate( #"hacked", #"hacked", 0 );
    self endon( #"death", #"kill_turret", #"turret_hacked" );
    wait ( hackeffect.hackduration ?? 10000 ) * 0.001;
    
    if ( self )
    {
        enable();
        self setscriptablepartstate( #"hacked", #"off", 0 );
    }
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x3e96c547, Offset: 0x2ef9
// Size: 0x4c5
function private steal( hackeffect, attacker )
{
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    turret = self;
    oldowner = turret.owner;
    newowner = attacker;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    turret utility::callsharedfunc( #"killstreak", #"removefromactivekillstreaklist", turret.entnum ?? utility::get_entity_number( turret ) );
    vehicle_occupancy::deregister_instance( turret );
    vehicle_tracking::deregister_instance( turret );
    turret notify( #"turret_hacked" );
    turret.team = newowner.team;
    turret.teamfriendlyto = newowner.team;
    turret.owner = newowner;
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret.timeout = bundle.var_217db254ca29ec8f ?? 120;
    turret.maxtimeout = turret.timeout;
    turret.health = bundle.maxhealth ?? 900;
    turret.maxhealth = turret.health;
    turret.medhealth = turret.maxhealth * 2 / 3;
    turret.lowhealth = turret.maxhealth / 3;
    turret.damagetaken = 0;
    turret.damagedstate = undefined;
    turret.var_a634fe6f7264e95d = 1;
    turret clearturrettarget();
    oldowner.placedsentries[ turret.turrettype ] = arrayremove( oldowner.placedsentries[ turret.turrettype ], turret );
    
    if ( !isdefined( newowner.placedsentries ) )
    {
        newowner.placedsentries = [];
    }
    
    if ( !isdefined( newowner.placedsentries[ turret.turrettype ] ) )
    {
        newowner.placedsentries[ turret.turrettype ] = [];
    }
    
    newowner.placedsentries[ turret.turrettype ] = function_5713d46873b29625( newowner.placedsentries[ turret.turrettype ] );
    turretcount = newowner.placedsentries[ turret.turrettype ].size;
    newowner.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    
    if ( turretcount + 1 > 1 )
    {
        newowner.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    vehicle_tracking::register_instance( turret, newowner, newowner.team );
    vehicle_occupancy::register_instance( turret );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname, "Killstreak_Ground", newowner, 0, 1, undefined, undefined );
    }
    
    turret thread function_7b6a98dfd8fb8441( newowner );
    newowner thread function_b4dd10d0f86f1a43( turret );
    newowner thread function_c3b770691f1a9620( turret );
    newowner thread watchdisown( turret );
    newowner thread watchdamage( turret );
    turret setscriptablepartstate( #"empd", #"off", 0 );
    turret setscriptablepartstate( #"vfx", #"neutral", 0 );
    turret setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"neutral", 0 );
    turret setscriptablepartstate( #"sfx", #"neutral", 0 );
    turret setscriptablepartstate( #"turret_damage", #"off", 0 );
    turret function_7f2194db8c3af979();
    turret.var_7568cab78e4268cc = undefined;
    turret thread function_52234c4101999057( turret.streakinfo );
}

// Namespace radiation_blast
// Params 1, eflags: 0xc
// Checksum 0x6e2a5eb2, Offset: 0x33c6
// Size: 0x4f6
function private function_52234c4101999057( streakinfo )
{
    self notify( #"hash_e623fb4336d222e5" );
    self endon( #"hash_e623fb4336d222e5" );
    self endon( #"death", #"kill_turret", #"turret_hacked" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = self.owner killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    var_f0d9b344951523e = bundle.var_944515cb25322e0b ?? 0;
    waitsec = bundle.var_99cccb02705f4535 ?? 2;
    var_bc73c21283a494b5 = 0.15;
    var_506251a01caeb897 = bundle.var_d15726a12ca3d919 ?? 8;
    var_4fdc305531e3e8d6 = bundle.var_b426bb14b3cfebc3 ?? 25;
    var_a8dedea8f13f5860 = ( bundle.var_3dacbf0db61eb165 ?? 1 ) * var_4fdc305531e3e8d6;
    var_a1deee610926dba = ( bundle.var_e354c400bc296929 ?? 0.25 ) * 1000;
    var_8eb462983119734d = var_506251a01caeb897 * 1000;
    var_4fec39d6bafcb3fd = 3.3;
    var_d0eec4b6a5acd92e = var_506251a01caeb897 - var_4fec39d6bafcb3fd;
    var_d0da9bd70a13b68 = [ [ 0, 0 ], [ 0.105, 0.32 ], [ 0.203, 0.557 ], [ 0.315, 0.75 ], [ 0.415, 0.883 ], [ 0.517, 0.963 ], [ 0.6, 1 ], [ 1, 1 ] ];
    self.radiationradius = 0;
    largestradius = bundle.var_21231bb72f9daf03 ?? 1000;
    
    if ( self )
    {
        self setscriptablepartstate( #"sfx", #"active" );
    }
    
    wait var_f0d9b344951523e;
    
    while ( self )
    {
        self setscriptablepartstate( #"vfx", #"active" );
        self setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"active" );
        thread function_67af32967f79ec36( var_d0eec4b6a5acd92e );
        function_43626612808ab66c();
        
        foreach ( entry in self.var_c0d9eb119c60f3b8 )
        {
            entry.emitterent playloopsound( #"hash_1828cba7b4098ddd" );
        }
        
        var_defe2d0089c0ddeb = gettime();
        endtime = var_defe2d0089c0ddeb + var_8eb462983119734d;
        
        while ( gettime() < endtime && self )
        {
            if ( self.var_7568cab78e4268cc > 0 )
            {
                self.radiationradius = 0;
                var_defe2d0089c0ddeb = gettime();
                endtime = var_defe2d0089c0ddeb + var_8eb462983119734d;
            }
            else
            {
                currenttime = gettime();
                completedratio = ( currenttime - var_defe2d0089c0ddeb ) / var_8eb462983119734d;
                radiuspercent = function_edbdbcee2a4a42c9( var_d0da9bd70a13b68, completedratio );
                self.radiationradius = radiuspercent * largestradius;
            }
            
            if ( self.streakinfo.bundle.var_2dc110e91b803712 )
            {
                function_d3abff7c5b0f7f5a();
            }
            else
            {
                function_c46d9d1b8ee7481b();
            }
            
            function_2aa7673adb74eb42( self.validtargets, self.radiationradius, var_a1deee610926dba, var_4fdc305531e3e8d6, var_a8dedea8f13f5860 );
            updatevfx( self );
            waitframe();
        }
        
        if ( self )
        {
            foreach ( entry in self.var_c0d9eb119c60f3b8 )
            {
                entry.emitterent stoploopsound();
            }
            
            self.radiationradius = 0;
            
            if ( self.streakinfo.bundle.var_2dc110e91b803712 )
            {
                function_d3abff7c5b0f7f5a();
            }
            else
            {
                function_c46d9d1b8ee7481b();
            }
            
            updatevfx( self );
        }
        
        wait waitsec - var_bc73c21283a494b5;
        
        if ( self )
        {
            self setscriptablepartstate( #"lid", #"open" );
        }
        
        wait var_bc73c21283a494b5;
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x8c6437f2, Offset: 0x38c4
// Size: 0x252
function private function_c46d9d1b8ee7481b()
{
    if ( !self || self.stopupdating )
    {
        return;
    }
    
    function_43626612808ab66c();
    
    if ( !isdefined( self.validtargets ) )
    {
        self.validtargets = [];
    }
    
    oldtargets = [];
    newtargets = [];
    
    if ( level.teambased && isdefined( self.team ) )
    {
        enemyteam = team_utility::getenemyteams( self.team );
    }
    
    oldtargets = self.validtargets;
    newtargets = isdefined( enemyteam ) ? getplayersinradius( self.origin, self.radiationradius, undefined, undefined, undefined, enemyteam ) : getplayersinradius( self.origin, self.radiationradius, undefined, undefined, self.owner );
    filteredtargets = [];
    
    foreach ( target in newtargets )
    {
        if ( !target.isjuggernaut )
        {
            filteredtargets[ filteredtargets.size ] = target;
        }
    }
    
    self.validtargets = filteredtargets;
    
    foreach ( player in filteredtargets )
    {
        if ( !arraycontains( oldtargets, player ) )
        {
            player function_fd4d6538dffb3db6( self );
        }
    }
    
    foreach ( player in oldtargets )
    {
        if ( !arraycontains( filteredtargets, player ) )
        {
            player function_7d36f2a1142c2142( self );
        }
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x1aeb0a43, Offset: 0x3b1e
// Size: 0xaf
function private function_d3abff7c5b0f7f5a()
{
    if ( !self || self.stopupdating )
    {
        return;
    }
    
    if ( !isdefined( self.validtargets ) )
    {
        self.validtargets = [];
    }
    
    newtargets = [];
    
    if ( level.teambased && isdefined( self.team ) )
    {
        enemyteam = team_utility::getenemyteams( self.team );
    }
    
    newtargets = isdefined( enemyteam ) ? getplayersandaiarrayinradius( self.origin, self.radiationradius, enemyteam ) : getplayersandaiarrayinradius( self.origin, self.radiationradius );
    self.validtargets = newtargets;
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xab9a872, Offset: 0x3bd5
// Size: 0x8d
function private function_fd4d6538dffb3db6( turret )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    
    if ( bundle.var_941f3a5f9d2d2684 )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:bundle.var_941f3a5f9d2d2684 }, 1, 1 );
    }
    
    self setscriptablepartstate( #"radiation_blast_fx", #"radiation_blast_fx_on", 0 );
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x51707a50, Offset: 0x3c6a
// Size: 0x93
function private function_7d36f2a1142c2142( turret )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "radiation_blast" );
    self.var_8a080ef2dc068f97 = undefined;
    
    if ( bundle.var_941f3a5f9d2d2684 )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.var_941f3a5f9d2d2684 } );
    }
    
    self setscriptablepartstate( #"radiation_blast_fx", #"radiation_blast_fx_deactivate", 0 );
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x206c99bc, Offset: 0x3d05
// Size: 0x11d
function private function_3d11c2e226e80767()
{
    foreach ( player in self.validtargets )
    {
        player function_7d36f2a1142c2142( self );
    }
    
    if ( self )
    {
        self.validtargets = undefined;
    }
    
    foreach ( entry in self.var_c0d9eb119c60f3b8 )
    {
        entry.emitterent delete();
    }
    
    self.var_c0d9eb119c60f3b8 = undefined;
    self.stopupdating = 1;
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x301aa126, Offset: 0x3e2a
// Size: 0xc5
function private function_fde95fad20cb8ac3( targets )
{
    besttarget = undefined;
    
    foreach ( ent in targets )
    {
        if ( isplayer( ent ) )
        {
            if ( !besttarget || besttarget.health > ent.health )
            {
                besttarget = ent;
            }
        }
    }
    
    self.killcamtarget = besttarget ?? self.killcamtarget;
}

// Namespace radiation_blast
// Params 5, eflags: 0x4
// Checksum 0xdcb01130, Offset: 0x3ef7
// Size: 0x23f
function private function_2aa7673adb74eb42( targets, radius, var_a1deee610926dba, damagepertick, var_9bb5404243fafc31 )
{
    if ( !( self.var_7568cab78e4268cc > 0 ) )
    {
        currenttime = gettime();
        
        if ( !self.var_897f7811ba537a3e || self.var_897f7811ba537a3e <= currenttime )
        {
            function_fde95fad20cb8ac3( targets );
            self.var_897f7811ba537a3e = currenttime + 1200;
        }
        
        foreach ( ent in targets )
        {
            if ( ent.var_2f5b6588a453ae1d > currenttime )
            {
                continue;
            }
            
            if ( !ent.var_8a080ef2dc068f97 || ent.var_8a080ef2dc068f97 <= currenttime )
            {
                if ( isplayer( ent ) )
                {
                    if ( ent ismeatshieldvictim() )
                    {
                        ent stopmeatshield( 9 );
                    }
                }
                
                if ( isplayer( ent ) && isdefined( ent.perks[ "specialty_gas_immunity" ] ) )
                {
                    ent dodamage( var_9bb5404243fafc31, self.origin, self.owner, self, "MOD_FIRE", level.sentrysettings[ "radiation_blast" ].weaponinfo, "torso_lower" );
                }
                else
                {
                    if ( self.streakinfo.bundle.var_2dc110e91b803712 )
                    {
                        damage_position = ent.origin;
                    }
                    
                    if ( !isdefined( damage_position ) )
                    {
                        damage_position = self.origin;
                    }
                    
                    ent dodamage( damagepertick, damage_position, self.owner, self, level.sentrysettings[ "radiation_blast" ].mod, level.sentrysettings[ "radiation_blast" ].weaponinfo, "torso_lower" );
                }
                
                ent.var_8a080ef2dc068f97 = currenttime + var_a1deee610926dba;
            }
        }
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xa90fa02b, Offset: 0x413e
// Size: 0x106
function private updatevfx( turret )
{
    if ( turret )
    {
        if ( turret.radiationradius > 0 )
        {
            turret setscriptablepartstate( #"vfx", #"active" );
            turret setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"active" );
            
            if ( !turret.var_7568cab78e4268cc )
            {
                turret showminimapcircle();
            }
        }
        else
        {
            turret setscriptablepartstate( #"vfx", #"neutral" );
            turret setscriptablepartstate( #"hash_ada4b21f87c10d3d", #"neutral" );
            turret function_7f2194db8c3af979();
        }
    }
    
    /#
        if ( getdvarint( @"hash_eafda08f2957ff20" ) > 0 && turret )
        {
            if ( !( self.var_7568cab78e4268cc > 0 ) )
            {
                thread debug_utility::drawsphere( turret.origin, turret.radiationradius, 0.0166667, ( 1, 0, 0 ) );
            }
        }
    #/
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0x21661257, Offset: 0x424c
// Size: 0x2b
function private function_67af32967f79ec36( var_d0eec4b6a5acd92e )
{
    wait var_d0eec4b6a5acd92e;
    
    if ( self )
    {
        self setscriptablepartstate( #"lid", #"closed" );
    }
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0x4ba66ff6, Offset: 0x427f
// Size: 0x155
function private function_43626612808ab66c()
{
    if ( !self )
    {
        return;
    }
    
    if ( !isdefined( self.var_388a7c1f578a6431 ) )
    {
        self.var_388a7c1f578a6431 = [];
    }
    
    oldtargets = [];
    newtargets = [];
    oldtargets = self.var_388a7c1f578a6431;
    newtargets = getplayersinradius( self.origin, 2000 );
    self.var_388a7c1f578a6431 = newtargets;
    
    foreach ( player in newtargets )
    {
        if ( !arraycontains( oldtargets, player ) )
        {
            player function_b88e64ca59c3d374( self );
        }
    }
    
    foreach ( player in oldtargets )
    {
        if ( !arraycontains( newtargets, player ) )
        {
            player function_cc772be46d874848( self );
        }
    }
    
    function_c8e520a780df1455();
}

// Namespace radiation_blast
// Params 0, eflags: 0x4
// Checksum 0xf2caa3c5, Offset: 0x43dc
// Size: 0xe5
function private function_c8e520a780df1455()
{
    foreach ( entry in self.var_c0d9eb119c60f3b8 )
    {
        if ( self.radiationradius > 0 && entry.player && entry.emitterent )
        {
            entry.emitterent.origin = self.origin + vectornormalize( entry.player geteye() - self.origin ) * self.radiationradius;
        }
    }
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xf749c1ee, Offset: 0x44c9
// Size: 0xad
function private function_b88e64ca59c3d374( turret )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( turret.var_c0d9eb119c60f3b8 ) )
    {
        turret.var_c0d9eb119c60f3b8 = [];
    }
    
    playerid = self getentitynumber();
    emitterent = spawn( "script_origin", turret.origin );
    emitterent showonlytoplayer( self );
    
    if ( turret.radiationradius > 0 )
    {
        emitterent playloopsound( #"hash_1828cba7b4098ddd" );
    }
    
    turret.var_c0d9eb119c60f3b8[ playerid ] = { #emitterent:emitterent, #player:self };
}

// Namespace radiation_blast
// Params 1, eflags: 0x4
// Checksum 0xdc707e55, Offset: 0x457e
// Size: 0x63
function private function_cc772be46d874848( turret )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    playerid = self getentitynumber();
    
    if ( turret.var_c0d9eb119c60f3b8[ playerid ] )
    {
        turret.var_c0d9eb119c60f3b8[ playerid ].emitterent delete();
        turret.var_c0d9eb119c60f3b8[ playerid ] = undefined;
    }
}

// Namespace radiation_blast
// Params 2, eflags: 0x4
// Checksum 0x4375b57, Offset: 0x45e9
// Size: 0x118
function private function_edbdbcee2a4a42c9( points, completedratio )
{
    if ( !isdefined( points ) || !points.size )
    {
        return 0;
    }
    
    firstx = points[ 0 ][ 0 ];
    firsty = points[ 0 ][ 1 ];
    lastx = points[ points.size - 1 ][ 0 ];
    lasty = points[ points.size - 1 ][ 1 ];
    
    if ( completedratio <= firstx )
    {
        return firsty;
    }
    
    if ( completedratio >= lastx )
    {
        return lasty;
    }
    
    for ( i = 0; i < points.size - 1 ; i++ )
    {
        var_e84dbb253d793c86 = points[ i ][ 0 ];
        y0 = points[ i ][ 1 ];
        x1 = points[ i + 1 ][ 0 ];
        y1 = points[ i + 1 ][ 1 ];
        
        if ( completedratio <= x1 )
        {
            if ( x1 == var_e84dbb253d793c86 )
            {
                return y1;
            }
            
            t = ( completedratio - var_e84dbb253d793c86 ) / ( x1 - var_e84dbb253d793c86 );
            return ( y0 + ( y1 - y0 ) * t );
        }
    }
    
    return lasty;
}

