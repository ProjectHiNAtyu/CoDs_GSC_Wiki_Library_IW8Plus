// scripts\mp\common\killstreaks\throwback_marker.gsc  (hash_6354b6a887ca61d0.gscc) (size: 2418 Bytes / 0x972 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbfc7f752 (3217553234)
// size ...... 2418 (0x972)
// includes .. 4   (offset: 0x8ca)
// strings ... 10  (offset: 0x8ea)
// dev strs .. 0   (offset: 0x972)
// exports ... 11  (offset: 0x576)
// cseg ...... 0xfd + 0x479 (0x576)
// imports ... 14  (offset: 0x72e)
// animtree1 . 0   (offset: 0x972)
// animtree2 . 0   (offset: 0x972)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;

#namespace throwback_marker;

// Namespace throwback_marker
// Params 0
// Checksum 0xd6550c25, Offset: 0x11b
// Size: 0x21
function init()
{
    val::group_register( "throwback_marker", [ "usability", "gesture" ] );
}

// Namespace throwback_marker
// Params 8
// Checksum 0x7dd38522, Offset: 0x144
// Size: 0xf3, Type: bool
function throwbackmarker_trythrowbackmarker( streakinfo, weapondetonatefunc, weaponoverride, weapongivenfunc, weaponswitchendedfunc, weaponfiredfunc, weaponcleanupcallback, weapontakenfunc )
{
    weapongivencallback = &throwbackmarker_weapongiven;
    weaponswitchendedcallback = &throwbackmarker_weaponswitchended;
    weaponfiredcallback = &throwbackmarker_weaponfired;
    weapontakencallback = &throwbackmarker_weapontaken;
    streakinfo.throwbackmarker_weapondetonatefunc = weapondetonatefunc;
    streakinfo.throwbackmarker_weapongivenfunc = weapongivenfunc;
    streakinfo.throwbackmarker_weaponswitchendedfunc = weaponswitchendedfunc;
    streakinfo.throwbackmarker_weaponfiredfunc = weaponfiredfunc;
    streakinfo.throwbackmarker_weapontakenfunc = weapontakenfunc;
    deployresult = killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy( streakinfo, weaponoverride, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !deployresult )
    {
        return false;
    }
    
    return true;
}

// Namespace throwback_marker
// Params 1
// Checksum 0x9b7aba37, Offset: 0x240
// Size: 0x3d
function throwbackmarker_weapongiven( streakinfo )
{
    weapongivenresult = 1;
    
    if ( isdefined( streakinfo.throwbackmarker_weapongivenfunc ) )
    {
        weapongivenresult = level [[ streakinfo.throwbackmarker_weapongivenfunc ]]( streakinfo );
    }
    
    return weapongivenresult;
}

// Namespace throwback_marker
// Params 2
// Checksum 0x62790987, Offset: 0x286
// Size: 0x44
function throwbackmarker_weaponswitchended( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread throwbackmarker_watchplayerweapon( streakinfo );
    }
    
    if ( isdefined( streakinfo.throwbackmarker_weaponswitchendedfunc ) )
    {
        level thread [[ streakinfo.throwbackmarker_weaponswitchendedfunc ]]( streakinfo, switchresult );
    }
}

// Namespace throwback_marker
// Params 1
// Checksum 0xc025c4a2, Offset: 0x2d2
// Size: 0x89
function throwbackmarker_watchplayerweapon( streakinfo )
{
    self endon( #"disconnect" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    result = utility::waittill_any_return( "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace throwback_marker
// Params 3
// Checksum 0xf1b0b893, Offset: 0x363
// Size: 0x6a
function throwbackmarker_weaponfired( streakinfo, firedweaponobj, firedprojectile )
{
    firedresult = "success";
    level thread throwbackmarker_watchdetonate( streakinfo, firedprojectile, self );
    level thread throwbackmarker_watchthrowback( streakinfo, firedprojectile );
    
    if ( isdefined( streakinfo.throwbackmarker_weaponfiredfunc ) )
    {
        firedresult = [[ streakinfo.throwbackmarker_weaponfiredfunc ]]( streakinfo, firedweaponobj, firedprojectile );
    }
    
    return firedresult;
}

// Namespace throwback_marker
// Params 3
// Checksum 0x4bd32d10, Offset: 0x3d6
// Size: 0x72
function throwbackmarker_watchdetonate( streakinfo, projectile, owner )
{
    level endon( #"game_ended" );
    projectile endon( #"trigger" );
    projectile waittill( #"explode", explodepos );
    
    if ( isdefined( streakinfo.throwbackmarker_weapondetonatefunc ) )
    {
        [[ streakinfo.throwbackmarker_weapondetonatefunc ]]( streakinfo, explodepos, owner );
    }
}

// Namespace throwback_marker
// Params 2
// Checksum 0xed50c509, Offset: 0x450
// Size: 0x8c
function throwbackmarker_watchthrowback( streakinfo, projectile )
{
    projectile endon( #"fired_off" );
    projectile waittill( #"trigger", player );
    player endon( #"death_or_disconnect" );
    player waittill( #"grenade_fire", grenade, weapon );
    level thread throwbackmarker_watchdetonate( streakinfo, grenade, player );
    level thread throwbackmarker_watchthrowback( streakinfo, grenade );
    player thread throwbackmarker_takeweapon( weapon );
}

// Namespace throwback_marker
// Params 1
// Checksum 0x908daf61, Offset: 0x4e4
// Size: 0x5f
function throwbackmarker_takeweapon( weapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    counter = 0;
    
    while ( counter < 5 )
    {
        if ( self hasweapon( weapon ) )
        {
            inventory_utility::_takeweapon( weapon );
        }
        else
        {
            counter += 1;
        }
        
        wait 0.05;
    }
}

// Namespace throwback_marker
// Params 1
// Checksum 0xed55a4b0, Offset: 0x54b
// Size: 0x2b
function throwbackmarker_weapontaken( streakinfo )
{
    if ( isdefined( streakinfo.throwbackmarker_weapontakenfunc ) )
    {
        [[ streakinfo.throwbackmarker_weapontakenfunc ]]( streakinfo );
    }
}

