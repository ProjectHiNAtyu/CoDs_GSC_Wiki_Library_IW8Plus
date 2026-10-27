// scripts\mp\common\killstreaks\remote_turret_mp.gsc  (hash_1df41c0907a26351.gscc) (size: 5365 Bytes / 0x14f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6309061f (1661535775)
// size ...... 5365 (0x14f5)
// includes .. 9   (offset: 0x1309)
// strings ... 21  (offset: 0x1351)
// dev strs .. 1   (offset: 0x14e5)
// exports ... 13  (offset: 0xd09)
// cseg ...... 0x1db + 0xb2e (0xd09)
// imports ... 34  (offset: 0xf11)
// animtree1 . 0   (offset: 0x14f5)
// animtree2 . 0   (offset: 0x14f5)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\manual_turret_mp;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\damage;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;

#namespace remote_turret_mp;

// Namespace remote_turret_mp
// Params 0, eflags: 0x1
// Checksum 0x6813d379, Offset: 0x1f9
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"remote_turret", #"init", &init );
}

// Namespace remote_turret_mp
// Params 0
// Checksum 0x57dae634, Offset: 0x221
// Size: 0x11c
function init()
{
    utility::registersharedfunc( #"remote_turret", #"monitordamage", &sentryturret_monitordamage );
    utility::registersharedfunc( #"remote_turret", #"createhintobject", &sentryturret_createhintobject );
    utility::registersharedfunc( #"remote_turret", #"gettargetmarker", &sentryturret_gettargetmarker );
    utility::registersharedfunc( #"remote_turret", #"initsentrysettings", &sentryturret_initsentrysettings );
    utility::registersharedfunc( #"remote_turret", #"allowpickupofturret", &sentryturret_canpickup );
    utility::registersharedfunc( #"remote_turret", #"handlemovingplatform", &manual_turret_mp::manual_turret_handlemovingplatform );
    utility::registersharedfunc( #"remote_turret", #"empstarted", &sentryturret_empstarted );
    utility::registersharedfunc( #"remote_turret", #"empcleared", &sentryturret_empcleared );
    utility::registersharedfunc( #"remote_turret", #"attachxrays", &sentryturret_attachxrays );
    utility::flag_set( "remote_turret_initialized" );
}

// Namespace remote_turret_mp
// Params 2
// Checksum 0xcbc14e2, Offset: 0x345
// Size: 0x30
function sentryturret_gettargetmarker( streakinfo, ignorecancel )
{
    assert( isplayer( self ), "<dev string:x24>" );
    return target_marker::gettargetmarker( streakinfo, ignorecancel );
}

// Namespace remote_turret_mp
// Params 11
// Checksum 0x74dece68, Offset: 0x37e
// Size: 0x7b
function sentryturret_createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    return gameobjects::createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov );
}

// Namespace remote_turret_mp
// Params 1
// Checksum 0xba81db3a, Offset: 0x402
// Size: 0x43
function sentryturret_monitordamage( turret )
{
    assert( isplayer( self ), "<dev string:x24>" );
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &sentryturret_handledeathdamage, &sentryturret_modifydamage, 1 );
}

// Namespace remote_turret_mp
// Params 1
// Checksum 0x24a43a37, Offset: 0x44d
// Size: 0x140
function sentryturret_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    config = level.sentrysettings[ self.turrettype ];
    notifyattacker = damage::onkillstreakkilled( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash );
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    if ( self.var_7f74b37e9e65e4c0 )
    {
        self stopbarrelspin();
        self.var_7f74b37e9e65e4c0 = undefined;
    }
    
    self notify( #"kill_turret", explosivedamage, 1 );
}

// Namespace remote_turret_mp
// Params 1
// Checksum 0xbd8d1202, Offset: 0x595
// Size: 0x1e4
function sentryturret_modifydamage( data )
{
    var_8e762fda3a98df83 = level.sentrysettings[ "remote_turret" ];
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "remote_turret" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 6, 400 );
    }
    
    if ( !isdefined( self.damagetaken ) )
    {
        self.damagetaken = 0;
    }
    
    var_9f6142336d9d2052 = self.damagetaken + modifieddamage;
    
    if ( var_9f6142336d9d2052 >= var_8e762fda3a98df83.maxhealth * 0.5 && !self.damagedstate )
    {
        self.damagedstate = 1;
        self setscriptablepartstate( "turret_damage", "on", 0 );
    }
    
    return modifieddamage;
}

// Namespace remote_turret_mp
// Params 0
// Checksum 0x6baf3534, Offset: 0x782
// Size: 0x4b5
function sentryturret_initsentrysettings()
{
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level.sentrysettings[ "remote_turret" ] = spawnstruct();
    level.sentrysettings[ "remote_turret" ].health = 999999;
    level.sentrysettings[ "remote_turret" ].maxhealth = getdvarint( @"scr_remote_turret_max_health", bundle.remoteturretmaxhealth ?? 650 );
    level.sentrysettings[ "remote_turret" ].lowhealth = bundle.remoteturretlowhealth ?? level.sentrysettings[ "remote_turret" ].maxhealth * 0.5;
    level.sentrysettings[ "remote_turret" ].lockstrength = 2;
    level.sentrysettings[ "remote_turret" ].sentrymodeon = "sentry";
    level.sentrysettings[ "remote_turret" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "remote_turret" ].timeout = getdvarfloat( @"scr_remote_turret_lifetime", bundle.remoteturretduration ?? 120 );
    level.sentrysettings[ "remote_turret" ].ignoreagent = bundle.var_bf87c15175fccbe5 ?? 0;
    level.sentrysettings[ "remote_turret" ].ignorejuggernaut = bundle.var_f8cba75992da4478 ?? 0;
    level.sentrysettings[ "remote_turret" ].spinuptime = 0.65;
    level.sentrysettings[ "remote_turret" ].overheattime = 8;
    level.sentrysettings[ "remote_turret" ].cooldowntime = 0.3;
    level.sentrysettings[ "remote_turret" ].fxtime = 0.3;
    level.sentrysettings[ "remote_turret" ].streakname = "remote_turret";
    level.sentrysettings[ "remote_turret" ].modelbaseground = bundle.sentrymodelbaseground ?? "wm_jup_2h_remote_turret_00";
    level.sentrysettings[ "remote_turret" ].modeldestroyedground = bundle.var_9fe58b22da2ec429 ?? "wm_jup_2h_remote_turret_00";
    level.sentrysettings[ "remote_turret" ].placementhintstring = bundle.var_3c70b670e960ca00 ?? &"killstreaks_hints/sentry_gun_place";
    level.sentrysettings[ "remote_turret" ].ownerusehintstring = bundle.var_d3774bc09069119d ?? &"killstreaks_hints/remote_turret_pickup";
    level.sentrysettings[ "remote_turret" ].otherusehintstring = bundle.var_82f365c6bd12e82a ?? &"killstreaks_hints/sentry_other_use";
    level.sentrysettings[ "remote_turret" ].dismantlehintstring = bundle.var_e5a11864a2b6b540 ?? &"killstreaks_hints/sentry_dismantle";
    level.sentrysettings[ "remote_turret" ].headicon = 1;
    level.sentrysettings[ "remote_turret" ].teamsplash = "used_remote_turret";
    level.sentrysettings[ "remote_turret" ].destroyedsplash = "callout_destroyed_sentry_gun";
    level.sentrysettings[ "remote_turret" ].shouldsplash = 1;
    level.sentrysettings[ "remote_turret" ].votimeout = "remote_turret_teamleader_destroyed";
    level.sentrysettings[ "remote_turret" ].vodestroyed = "remote_turret_teamleader_destroyed";
    level.sentrysettings[ "remote_turret" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "remote_turret" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "remote_turret" ].iskillstreak = 1;
    level.sentrysettings[ "remote_turret" ].headiconoffset = ( 0, 0, 75 );
}

// Namespace remote_turret_mp
// Params 0
// Checksum 0x46884758, Offset: 0xc3f
// Size: 0x68, Type: bool
function sentryturret_canpickup()
{
    if ( inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        return false;
    }
    
    if ( killstreak_utility::iskillstreakdeployweapon( self getcurrentweapon() ) )
    {
        return false;
    }
    
    if ( self.isjuggernaut )
    {
        hud_message::showerrormessage( %"killstreaks/jugg_cannot_be_picked_up" );
        return false;
    }
    
    if ( self isswimming() )
    {
        hud_message::showerrormessage( %"killstreaks/cannot_be_picked_up_water" );
        return false;
    }
    
    if ( !val::get( "killstreaks" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace remote_turret_mp
// Params 0
// Checksum 0x6f466aa0, Offset: 0xcb0
// Size: 0x13
function sentryturret_empstarted()
{
    self setscriptablepartstate( "empd", "active", 0 );
}

// Namespace remote_turret_mp
// Params 0
// Checksum 0xbb864d69, Offset: 0xccb
// Size: 0x13
function sentryturret_empcleared()
{
    self setscriptablepartstate( "empd", "neutral", 0 );
}

// Namespace remote_turret_mp
// Params 1
// Checksum 0x7aba7d0f, Offset: 0xce6
// Size: 0x22
function sentryturret_attachxrays( turret )
{
    turret setentityhudoutlinedata( 3, turret.team );
    return turret;
}

