// scripts\mp\common\killstreaks\manual_turret_mp.gsc  (hash_6b56b541550363b5.gscc) (size: 4656 Bytes / 0x1230 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x411e6ada (1092512474)
// size ...... 4656 (0x1230)
// includes .. 11  (offset: 0x1034)
// strings ... 19  (offset: 0x108c)
// dev strs .. 1   (offset: 0x1224)
// exports ... 13  (offset: 0xae4)
// cseg ...... 0x1f1 + 0x8f3 (0xae4)
// imports ... 28  (offset: 0xcec)
// animtree1 . 0   (offset: 0x1230)
// animtree2 . 0   (offset: 0x1230)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\movers;

#namespace manual_turret_mp;

// Namespace manual_turret_mp
// Params 0
// Checksum 0x978825c2, Offset: 0x20f
// Size: 0xd5
function init()
{
    killstreaks::registerkillstreak( "manual_turret", &manual_turret::tryusemanualturretfromstruct );
    init_manual_turret_settings();
    init_manual_turret_vo();
    utility::registersharedfunc( #"manual_turret", #"monitordamage", &manual_turret_monitordamage );
    utility::registersharedfunc( #"manual_turret", #"createhintobject", &manual_turret_createhintobject );
    utility::registersharedfunc( #"manual_turret", #"gettargetmarker", &manual_turret_gettargetmarker );
    utility::registersharedfunc( #"manual_turret", #"watchforplayerenteringlaststand", &manual_turret_laststandwatcher );
    utility::registersharedfunc( #"manual_turret", #"handlemovingplatform", &manual_turret_handlemovingplatform );
    utility::registersharedfunc( #"manual_turret", #"allowpickupofturret", &manual_turret_canpickup );
}

// Namespace manual_turret_mp
// Params 0
// Checksum 0x11abaf7e, Offset: 0x2ec
// Size: 0x483
function init_manual_turret_settings()
{
    level.sentrysettings[ "manual_turret" ] = spawnstruct();
    level.sentrysettings[ "manual_turret" ].health = 999999;
    level.sentrysettings[ "manual_turret" ].maxhealth = 650;
    level.sentrysettings[ "manual_turret" ].burstmin = 20;
    level.sentrysettings[ "manual_turret" ].burstmax = 120;
    level.sentrysettings[ "manual_turret" ].pausemin = 0.15;
    level.sentrysettings[ "manual_turret" ].pausemax = 0.35;
    level.sentrysettings[ "manual_turret" ].sentrymodeon = "manual";
    level.sentrysettings[ "manual_turret" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "manual_turret" ].ammo = 200;
    level.sentrysettings[ "manual_turret" ].timeout = getdvarfloat( @"hash_9775c39c335aab23", 90 );
    level.sentrysettings[ "manual_turret" ].spinuptime = 0.05;
    level.sentrysettings[ "manual_turret" ].overheattime = 8;
    level.sentrysettings[ "manual_turret" ].cooldowntime = 0.1;
    level.sentrysettings[ "manual_turret" ].fxtime = 0.3;
    level.sentrysettings[ "manual_turret" ].streakname = "manual_turret";
    level.sentrysettings[ "manual_turret" ].weaponinfo = "manual_turret_mp";
    level.sentrysettings[ "manual_turret" ].playerweaponinfo = "manual_turret_mp";
    level.sentrysettings[ "manual_turret" ].scriptable = "ks_manual_turret_mp";
    level.sentrysettings[ "manual_turret" ].modelbasecover = "killstreak_wm_mounted_turret";
    level.sentrysettings[ "manual_turret" ].modelbaseground = "weapon_wm_mg_mobile_turret";
    level.sentrysettings[ "manual_turret" ].modeldestroyedcover = "killstreak_wm_mounted_turret";
    level.sentrysettings[ "manual_turret" ].modeldestroyedground = "weapon_wm_mg_mobile_turret";
    level.sentrysettings[ "manual_turret" ].placementhintstring = &"killstreaks_hints/sentry_place";
    level.sentrysettings[ "manual_turret" ].ownerusehintstring = &"killstreaks_hints/sentry_owner_use";
    level.sentrysettings[ "manual_turret" ].otherusehintstring = &"killstreaks_hints/sentry_other_use";
    level.sentrysettings[ "manual_turret" ].dismantlehintstring = &"killstreaks_hints/sentry_dismantle";
    level.sentrysettings[ "manual_turret" ].headicon = 1;
    level.sentrysettings[ "manual_turret" ].teamsplash = "used_manual_turret";
    level.sentrysettings[ "manual_turret" ].destroyedsplash = "callout_destroyed_manual_turret";
    level.sentrysettings[ "manual_turret" ].shouldsplash = 1;
    level.sentrysettings[ "manual_turret" ].votimeout = "timeout_manual_turret";
    level.sentrysettings[ "manual_turret" ].vodestroyed = "destroyed_manual_turret";
    level.sentrysettings[ "manual_turret" ].scorepopup = "destroyed_manual_turret";
    level.sentrysettings[ "manual_turret" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "manual_turret" ].iskillstreak = 1;
    level.sentrysettings[ "manual_turret" ].headiconoffset = ( 0, 0, 75 );
}

// Namespace manual_turret_mp
// Params 0
// Checksum 0x9da07eb1, Offset: 0x777
// Size: 0x28
function init_manual_turret_vo()
{
    game[ "dialog" ][ "manual_turret_low_ammo" ] = "manual_turret_ammo_low";
    game[ "dialog" ][ "manual_turret_no_ammo" ] = "manual_turret_no_ammo";
}

// Namespace manual_turret_mp
// Params 3
// Checksum 0x4dc1722d, Offset: 0x7a7
// Size: 0xbd
function manual_turret_equipment_wrapper( ref, slot, objweapon )
{
    equipment_mp::takeequipment( slot );
    used = manual_turret::tryusemanualturret( "manual_turret" );
    
    if ( !used )
    {
        equipment_mp::giveequipment( "equip_shieldturret", slot );
        return;
    }
    
    init_manual_turret_settings();
    init_manual_turret_vo();
    utility::registersharedfunc( #"manual_turret", #"monitordamage", &manual_turret_monitordamage );
    utility::registersharedfunc( #"manual_turret", #"createhintobject", &manual_turret_createhintobject );
    utility::registersharedfunc( #"manual_turret", #"gettargetmarker", &manual_turret_gettargetmarker );
}

// Namespace manual_turret_mp
// Params 2
// Checksum 0x2e00f14, Offset: 0x86c
// Size: 0x30
function manual_turret_gettargetmarker( streakinfo, ignorecancel )
{
    assert( isplayer( self ), "<dev string:x24>" );
    return target_marker::gettargetmarker( streakinfo, ignorecancel );
}

// Namespace manual_turret_mp
// Params 11
// Checksum 0x809ce7f9, Offset: 0x8a5
// Size: 0x7b
function manual_turret_createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    return gameobjects::createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov );
}

// Namespace manual_turret_mp
// Params 7
// Checksum 0xcda2712e, Offset: 0x929
// Size: 0x53
function manual_turret_monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken )
{
    damage::monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken );
}

// Namespace manual_turret_mp
// Params 1
// Checksum 0x38c4ec9c, Offset: 0x984
// Size: 0x14
function manual_turret_getenemyplayers( team )
{
    return teams::getenemyplayers( team );
}

// Namespace manual_turret_mp
// Params 1
// Checksum 0x4512f83b, Offset: 0x9a1
// Size: 0x9c
function manual_turret_handlemovingplatform( turret )
{
    if ( isdefined( turret.moving_platform ) )
    {
        data = spawnstruct();
        data.linkparent = turret.moving_platform;
        data.linkoffset = turret.moving_platform_offset;
        data.angleoffset = turret.moving_platform_angles_offset;
        data.endonstring = "carried";
        data.deathoverridecallback = &manualturret_moving_platform_death;
        turret thread movers::handle_moving_platforms( data );
    }
}

// Namespace manual_turret_mp
// Params 1
// Checksum 0x5e622b99, Offset: 0xa45
// Size: 0x18
function manualturret_moving_platform_death( data )
{
    self notify( #"death" );
}

// Namespace manual_turret_mp
// Params 0
// Checksum 0xe34a8a36, Offset: 0xa65
// Size: 0x57
function manual_turret_laststandwatcher()
{
    self endon( #"death_or_disconnect" );
    self notify( #"stop_manual_turret_laststandwatcher" );
    self endon( #"stop_manual_turret_laststandwatcher" );
    self endon( #"turret_placement_finished" );
    thread manual_turret::manualturret_clearplacementinstructions( "last_stand_enter" );
    self waittill( #"last_stand_enter" );
    self notify( #"equip_deploy_cancel" );
}

// Namespace manual_turret_mp
// Params 0
// Checksum 0x301bafce, Offset: 0xac4
// Size: 0x1f, Type: bool
function manual_turret_canpickup()
{
    if ( inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        return false;
    }
    
    if ( killstreak_utility::iskillstreakdeployweapon( self getcurrentweapon() ) )
    {
        return false;
    }
    
    return true;
}

