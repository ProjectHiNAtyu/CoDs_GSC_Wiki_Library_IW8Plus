// scripts\mp\common\killstreaks\target_marker.gsc  (hash_5e0cc00f069082d4.gscc) (size: 9728 Bytes / 0x2600 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x518876fe (1367897854)
// size ...... 9728 (0x2600)
// includes .. 12  (offset: 0x22f8)
// strings ... 41  (offset: 0x2358)
// dev strs .. 2   (offset: 0x25e8)
// exports ... 23  (offset: 0x164c)
// cseg ...... 0x360 + 0x12ec (0x164c)
// imports ... 77  (offset: 0x19e4)
// animtree1 . 0   (offset: 0x2600)
// animtree2 . 0   (offset: 0x2600)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\supers;

#namespace target_marker;

// Namespace target_marker
// Params 0
// Checksum 0x4412d029, Offset: 0x37e
// Size: 0x8a
function init()
{
    val::group_register( "target_marker", [ "usability", "gesture", "sprint", "weapon_switch", "offhand_weapons", "melee", "execution_attack", "ladder_placement", "supers" ] );
    val::register( "targetmarker_on_failed_stop", 0, 0 );
    val::register( "targetmarker_on_air_stop", 0, 0 );
    val::register( "targetmarker_on_obstruction_stop", 0, 0 );
}

// Namespace target_marker
// Params 5
// Checksum 0xc0b92552, Offset: 0x410
// Size: 0x6ea
function gettargetmarker( streakinfo, var_ff3ad3c9d65b87ae, var_825ad58d5c4b9461, markeroverride, deployweaponobj )
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( !player::isreallyalive() )
    {
        return;
    }
    
    val::group_set( "target_marker", 0 );
    
    if ( !markeroverride )
    {
        entity::_enableequipdeployvfx();
    }
    
    if ( var_ff3ad3c9d65b87ae )
    {
        self notify( #"target_marker_begin_non_cancellable" );
    }
    
    if ( !isdefined( streakinfo.weaponname ) && isdefined( streakinfo.deployweaponobj ) )
    {
        streakinfo.weaponname = weapon::getweaponname( streakinfo.deployweaponobj );
    }
    
    if ( isdefined( streakinfo.weaponname ) )
    {
        weapon = makeweaponfromstring( streakinfo.weaponname );
    }
    
    markerinfo = undefined;
    
    if ( isdefined( weapon ) )
    {
        thread watchforinvalidweapon( weapon, streakinfo );
        thread watchforammouse( weapon, streakinfo );
    }
    
    thread watchforempapply( streakinfo );
    thread function_c6d314c7f9d0e61d( streakinfo );
    thread watchforlaststand( streakinfo );
    thread function_83c7ab68e81bcbc2( streakinfo );
    thread function_d186354d04ca5283( streakinfo );
    thread function_8ccd04ac04fdd8d4( streakinfo );
    thread function_1da1f77f2452c0be( streakinfo );
    thread function_30973f8732940bcc( streakinfo );
    thread function_1100484bac8f71e3( level.a_e_portals, streakinfo );
    thread function_b335eda706eb54ad( level.a_e_portals, streakinfo );
    
    if ( !var_ff3ad3c9d65b87ae )
    {
        if ( !isai( self ) )
        {
            self notifyonplayercommand( "equip_deploy_end", "+weapnext" );
            self notifyonplayercommand( "equip_deploy_end", "+weapprev" );
            self notifyonplayercommand( "equip_deploy_end", "+actionslot 4" );
            
            if ( !self isconsoleplayer() )
            {
                self notifyonplayercommand( "equip_deploy_end", "+actionslot 5" );
                self notifyonplayercommand( "equip_deploy_end", "+actionslot 6" );
                self notifyonplayercommand( "equip_deploy_end", "+actionslot 7" );
            }
        }
    }
    
    if ( common_inventory::function_5c64d2b24a8c3e18() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
    }
    
    if ( markeroverride && deployweaponobj )
    {
        self function_2d1ebae13fd5c511( deployweaponobj );
        markerinfo = waittill_succeed_fail_end( "equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start" );
    }
    else
    {
        while ( true )
        {
            markerinfo = waittill_succeed_fail_end( "equip_deploy_succeeded", "equip_deploy_failed", "equip_deploy_end", "equip_deploy_cancel", "giveLoadout_start" );
            
            if ( markerinfo.string == "equip_deploy_cancel" )
            {
                break;
            }
            
            if ( markerinfo.string == "equip_deploy_end" )
            {
                if ( !var_ff3ad3c9d65b87ae )
                {
                    break;
                }
                else
                {
                    hud_message::showerrormessage( %"killstreaks/cannot_switch" );
                }
                
                continue;
            }
            
            if ( markerinfo.string == "equip_deploy_failed" )
            {
                hud_message::showerrormessage( %"killstreaks/cannot_be_placed" );
                
                if ( val::get( "targetmarker_on_failed_stop" ) )
                {
                    markerinfo = undefined;
                    break;
                }
                
                continue;
            }
            
            if ( isdefined( markerinfo ) && markerinfo.string == "equip_deploy_succeeded" )
            {
                var_73ee08fbcb402012 = function_d6e4569bd981ff9( markerinfo );
                
                if ( isdefined( var_73ee08fbcb402012 ) )
                {
                    hud_message::showerrormessage( var_73ee08fbcb402012 );
                    
                    if ( val::get( "targetmarker_on_obstruction_stop" ) )
                    {
                        markerinfo = undefined;
                        break;
                    }
                    
                    continue;
                }
                else if ( !self isonground() || self isonladder() )
                {
                    hud_message::showerrormessage( %"killstreaks/cannot_be_placed_air" );
                    
                    if ( val::get( "targetmarker_on_air_stop" ) )
                    {
                        markerinfo = undefined;
                        break;
                    }
                    
                    continue;
                }
                else if ( isdefined( level.var_59abd25eeb5b2fed ) )
                {
                    canplant = self [[ level.var_59abd25eeb5b2fed ]]( markerinfo.location );
                    
                    if ( !canplant )
                    {
                        hud_message::showerrormessage( %"killstreaks/cannot_be_placed" );
                        continue;
                    }
                }
                else if ( isdefined( var_825ad58d5c4b9461 ) && self [[ var_825ad58d5c4b9461 ]]( markerinfo ) )
                {
                    continue;
                }
            }
            
            break;
        }
    }
    
    if ( isdefined( markerinfo.location ) && isdefined( markerinfo.angles ) )
    {
        starttrace = markerinfo.location + ( 0, 0, 80 );
        endtrace = markerinfo.location + ( 0, 0, -1000 );
        contentsplacement = [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip", "physicscontents_item" ];
        contentsoverride = physics_createcontents( contentsplacement );
        platformtrace = trace::sphere_trace( starttrace, endtrace, 20, undefined, contentsoverride );
        moving_platform = platformtrace[ "entity" ];
        
        if ( function_9816e67f7022702d( moving_platform ) )
        {
            markerinfo.moving_platform = moving_platform;
            var_4f45ae116dd5a53a = markerinfo.location - moving_platform.origin;
            var_ef00cc6756764c1d = vectordot( var_4f45ae116dd5a53a, anglestoforward( moving_platform.angles ) );
            var_ef00cb67567649ea = -1 * vectordot( var_4f45ae116dd5a53a, anglestoright( moving_platform.angles ) );
            var_ef00ca67567647b7 = vectordot( var_4f45ae116dd5a53a, anglestoup( moving_platform.angles ) );
            markerinfo.moving_platform_offset = ( var_ef00cc6756764c1d, var_ef00cb67567649ea, var_ef00ca67567647b7 );
            markerinfo.moving_platform_angles_offset = combineangles( invertangles( moving_platform.angles ), markerinfo.angles );
        }
        else if ( getdvarint( @"hash_50998d037e0d13b9", 0 ) )
        {
            if ( platformtrace[ "hittype" ] != "hittype_none" && isdefined( platformtrace[ "position" ] ) )
            {
                /#
                    thread debug_utility::drawsphere( markerinfo.location, 5, 30, ( 1, 0, 0 ) );
                    thread debug_utility::drawsphere( platformtrace[ "<dev string:x58>" ], 5, 30, ( 0, 1, 0 ) );
                #/
                
                anchorzoffset = ( 0, 0, 0 );
                
                if ( distancesquared( markerinfo.location, platformtrace[ "position" ] ) >= 100 )
                {
                    anchorzoffset = ( 0, 0, 10 );
                }
                
                markerinfo.location = ( markerinfo.location[ 0 ], markerinfo.location[ 1 ], platformtrace[ "position" ][ 2 ] ) - anchorzoffset;
            }
        }
    }
    
    if ( common_inventory::function_5c64d2b24a8c3e18() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 0 );
    }
    
    if ( player::isreallyalive( self ) )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        val::reset_all( "watchPlacement" );
    }
    
    if ( !markeroverride )
    {
        entity::_disableequipdeployvfx();
    }
    
    thread utility::delaythread( 0.05, &val::group_reset, "target_marker" );
    
    if ( var_ff3ad3c9d65b87ae )
    {
        thread utility::delaythread( 0.05, &utility::send_notify, "target_marker_end_non_cancellable" );
    }
    
    return markerinfo;
}

// Namespace target_marker
// Params 1
// Checksum 0x13cdae20, Offset: 0xb03
// Size: 0x61, Type: bool
function function_9816e67f7022702d( movingplatform )
{
    if ( !isdefined( movingplatform ) )
    {
        return false;
    }
    
    if ( isdefined( movingplatform.helperdronetype ) )
    {
        return false;
    }
    
    if ( movingplatform vehicle::is_vehicle() && movingplatform vehicle::get_ref() == %"hash_13a0340a4961ca24" )
    {
        return false;
    }
    
    if ( movingplatform.targetname == "dropped_weapon" )
    {
        return false;
    }
    
    return true;
}

// Namespace target_marker
// Params 1
// Checksum 0x13b996cd, Offset: 0xb6d
// Size: 0x58
function isplacementplayerobstructed( marker )
{
    var_254338994178d570 = 0;
    placementposition = marker.location;
    
    if ( !trace::sphere_trace_passed( placementposition + ( 0, 0, 100 ), placementposition, 20, undefined, trace::create_character_contents() ) )
    {
        var_254338994178d570 = 1;
    }
    
    return var_254338994178d570;
}

// Namespace target_marker
// Params 1
// Checksum 0x313b1e33, Offset: 0xbce
// Size: 0x9a
function function_d6e4569bd981ff9( marker )
{
    var_55d329b619f1c72d = undefined;
    placementposition = marker.location;
    trace = trace::sphere_trace( placementposition + ( 0, 0, 100 ), placementposition, 20, undefined, trace::create_character_contents() );
    
    if ( !isdefined( trace ) || trace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    if ( isplayer( trace[ "entity" ] ) )
    {
        var_55d329b619f1c72d = %"killstreaks/cannot_be_placed_player";
    }
    else
    {
        var_55d329b619f1c72d = %"hash_3ef62dd61cc48de6";
    }
    
    return var_55d329b619f1c72d;
}

// Namespace target_marker
// Params 1
// Checksum 0x8276db28, Offset: 0xc71
// Size: 0x5e
function function_30973f8732940bcc( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"equip_deploy_succeeded" );
    level endon( #"game_ended" );
    
    if ( !supers_mp::issuper( streakinfo.streakname ) )
    {
        return;
    }
    
    utility::waittill_any( "equip_deploy_end", "equip_deploy_cancel" );
    thread supers_mp::refundsuper();
}

// Namespace target_marker
// Params 2
// Checksum 0x4e9966e6, Offset: 0xcd7
// Size: 0x8b
function watchforinvalidweapon( weapon, streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self getcurrentweapon().basename != weapon.basename )
        {
            if ( isnullweapon( self getcurrentweapon() ) )
            {
                self notify( #"equip_deploy_cancel" );
            }
            else
            {
                self notify( #"equip_deploy_end" );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace target_marker
// Params 2
// Checksum 0xd4a8f67d, Offset: 0xd6a
// Size: 0x7c
function watchforammouse( weapon, streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    totalclipammo = self getweaponammoclip( weapon );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( objweapon == weapon )
        {
            self setweaponammoclip( objweapon, totalclipammo );
        }
    }
}

// Namespace target_marker
// Params 1
// Checksum 0x4a73070c, Offset: 0xdee
// Size: 0x4a
function watchforempapply( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    self waittill( #"emp_applied" );
    self notify( #"equip_deploy_end" );
}

// Namespace target_marker
// Params 1
// Checksum 0x938f584a, Offset: 0xe40
// Size: 0x61
function function_c6d314c7f9d0e61d( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self isswimming() )
        {
            hud_message::showerrormessage( %"killstreaks/placement_canceled_water" );
            self notify( #"equip_deploy_cancel" );
            break;
        }
        
        waitframe();
    }
}

// Namespace target_marker
// Params 1
// Checksum 0xb0bd261d, Offset: 0xea9
// Size: 0x68
function watchforlaststand( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    waittillframeend();
    
    if ( !self.inlaststand )
    {
        self waittill( #"last_stand_enter" );
    }
    
    hud_message::showerrormessage( %"killstreaks/placement_canceled" );
    self notify( #"equip_deploy_cancel" );
}

// Namespace target_marker
// Params 1
// Checksum 0x58885957, Offset: 0xf19
// Size: 0x4a
function function_83c7ab68e81bcbc2( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    self waittill( #"meatshield_victim_grabbed" );
    self notify( #"equip_deploy_cancel" );
}

// Namespace target_marker
// Params 1
// Checksum 0xc5f54921, Offset: 0xf6b
// Size: 0x61
function function_d186354d04ca5283( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self isparachuting() )
        {
            hud_message::showerrormessage( %"killstreaks/placement_canceled" );
            self notify( #"equip_deploy_cancel" );
            break;
        }
        
        waitframe();
    }
}

// Namespace target_marker
// Params 1
// Checksum 0x794d0ee6, Offset: 0xfd4
// Size: 0x58
function function_8ccd04ac04fdd8d4( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    waittillframeend();
    
    if ( !self.oob )
    {
        self waittill( #"oob_cooldown_end" );
    }
    
    self notify( #"equip_deploy_failed" );
}

// Namespace target_marker
// Params 2
// Checksum 0x69cfeda2, Offset: 0x1034
// Size: 0x191
function function_1100484bac8f71e3( portalarray, streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.a_e_portals ) )
    {
        portalpositions = [];
        
        foreach ( portalentity in portalarray )
        {
            portalpositions[ portalpositions.size ] = portalentity.origin;
        }
        
        while ( true )
        {
            foreach ( portalposition in portalpositions )
            {
                var_817d2cfad4165fc2 = distancesquared( self.origin, portalposition );
                
                if ( var_817d2cfad4165fc2 <= level.var_85b6ad765e4e6748 )
                {
                    self.nearportal = 1;
                    val::set( "watchPlacement", "fire", 0 );
                    break;
                }
                
                self.nearportal = 0;
            }
            
            waitframe();
        }
    }
}

// Namespace target_marker
// Params 2
// Checksum 0xb4d2037b, Offset: 0x11cd
// Size: 0x92
function function_b335eda706eb54ad( portalarray, streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.a_e_portals ) )
    {
        self notifyonplayercommand( "deploy_attempt", "+attack" );
        thread function_b3905f7942488620( streakinfo );
        
        while ( true )
        {
            self waittill( #"deploy_attempt" );
            
            if ( self.nearportal )
            {
                hud_message::showerrormessage( %"killstreaks/cannot_be_placed" );
            }
            
            waitframe();
        }
    }
}

// Namespace target_marker
// Params 1
// Checksum 0xadbd2431, Offset: 0x1267
// Size: 0x42
function function_b3905f7942488620( streakinfo )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    streakinfo waittill( #"killstreak_finished_with_deploy_weapon" );
    self notifyonplayercommandremove( "deploy_attempt", "+attack" );
}

// Namespace target_marker
// Params 1
// Checksum 0xf4a272c4, Offset: 0x12b1
// Size: 0x5a
function function_1da1f77f2452c0be( streakinfo )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self isinexecutionattack() || self isinexecutionvictim() )
        {
            self notify( #"equip_deploy_cancel" );
            break;
        }
        
        waitframe();
    }
}

// Namespace target_marker
// Params 3
// Checksum 0x85ed64bc, Offset: 0x1313
// Size: 0x116
function watchforplacementfirestate( streakinfo, endonnotify, weaponobj )
{
    self endon( endonnotify );
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    
    if ( isdefined( weaponobj ) && !killstreakdeploy::candeploykillstreak( streakinfo, weaponobj ) )
    {
        return;
    }
    
    allowplacement = self function_83761e0b59aa9607() && !entity::touchingoobtrigger();
    
    if ( !allowplacement )
    {
        val::set( "watchPlacement", "fire", 0 );
    }
    
    val::set( "watchPlacement", "usability", 0 );
    thread function_e29c7ef2e20b1b21( streakinfo, endonnotify );
    
    while ( true )
    {
        self waittill( #"hash_d800703acd152163", placementstate );
        
        if ( !placementstate )
        {
            if ( allowplacement )
            {
                allowplacement = 0;
                val::set( "watchPlacement", "fire", 0 );
            }
            
            continue;
        }
        
        if ( !entity::touchingoobtrigger() )
        {
            if ( !allowplacement )
            {
                allowplacement = 1;
                val::set( "watchPlacement", "fire", 1 );
            }
        }
    }
}

// Namespace target_marker
// Params 2
// Checksum 0x50d63491, Offset: 0x1431
// Size: 0x4c
function function_e29c7ef2e20b1b21( streakinfo, endonnotify )
{
    self endon( #"death_or_disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    self waittill( endonnotify );
    val::reset_all( "watchPlacement" );
}

// Namespace target_marker
// Params 5
// Checksum 0x8629b18, Offset: 0x1485
// Size: 0x141
function waittill_succeed_fail_end( confirmstring, failstring, endstring, cancelstring, var_6e4dc9aabbd3af67 )
{
    ent = spawnstruct();
    
    if ( isdefined( confirmstring ) )
    {
        childthread waittill_return( confirmstring, ent );
    }
    
    if ( isdefined( failstring ) )
    {
        childthread waittill_return( failstring, ent );
    }
    
    if ( isdefined( endstring ) )
    {
        childthread waittill_return( endstring, ent );
    }
    
    if ( isdefined( cancelstring ) )
    {
        childthread waittill_return( cancelstring, ent );
    }
    
    if ( isdefined( var_6e4dc9aabbd3af67 ) )
    {
        childthread waittill_return( var_6e4dc9aabbd3af67, ent );
    }
    
    childthread waittill_return( "death", ent );
    ent waittill( #"returned", vfxoffset, weaponname, location, angle, string );
    ent notify( #"die" );
    returninfo = spawnstruct();
    returninfo.weapon = weaponname;
    returninfo.location = location;
    returninfo.angles = angle;
    returninfo.string = string;
    returninfo.fxoffset = vfxoffset;
    return returninfo;
}

// Namespace target_marker
// Params 2
// Checksum 0xc1a71fb2, Offset: 0x15cf
// Size: 0x7d
function waittill_return( confirmstring, ent )
{
    if ( confirmstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( confirmstring, vfxoffset, weapon, location, angle );
    ent notify( #"returned", vfxoffset, weapon, location, angle, confirmstring );
}

