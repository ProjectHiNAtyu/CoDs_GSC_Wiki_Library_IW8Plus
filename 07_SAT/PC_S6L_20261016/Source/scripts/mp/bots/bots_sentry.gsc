// scripts\mp\bots\bots_sentry.gsc  (hash_60842faf6b334477.gscc) (size: 5137 Bytes / 0x1411 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78e57621 (2028303905)
// size ...... 5137 (0x1411)
// includes .. 6   (offset: 0x12c9)
// strings ... 18  (offset: 0x12f9)
// dev strs .. 0   (offset: 0x1411)
// exports ... 16  (offset: 0xb99)
// cseg ...... 0x240 + 0x959 (0xb99)
// imports ... 40  (offset: 0xe19)
// animtree1 . 0   (offset: 0x1411)
// animtree2 . 0   (offset: 0x1411)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\mp\bots\bots_killstreaks;
#using scripts\mp\common\killstreaks\autosentry;
#using scripts\mp\common\killstreaks\placeable;

#namespace bots_sentry;

// Namespace bots_sentry
// Params 3
// Checksum 0x641b89ae, Offset: 0x25e
// Size: 0xd4
function function_8df6526373cd03ae( killstreak_info, killstreak_slot, targettype )
{
    self endon( #"hash_240a9610b35494c8" );
    
    while ( gettime() < self.sentry_place_delay )
    {
        wait 1;
    }
    
    if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
    {
        return 1;
    }
    
    targetpoint = self.origin;
    
    if ( targettype != "hide_nonlethal" )
    {
        targetpoint = bot_sentry_choose_target( targettype );
        
        if ( !isdefined( targetpoint ) )
        {
            return 1;
        }
    }
    
    bot_sentry_add_goal( killstreak_info, killstreak_slot, targetpoint, targettype );
    
    while ( bots_tactical_goals::has_tactical_goal( "sentry_placement" ) )
    {
        wait 0.5;
    }
}

// Namespace bots_sentry
// Params 4
// Checksum 0x5bedcf0a, Offset: 0x33a
// Size: 0x104
function bot_sentry_add_goal( killstreak_info, killstreak_slot, targetorigin, targettype )
{
    placement = bot_sentry_choose_placement( killstreak_info, killstreak_slot, targetorigin, targettype );
    
    if ( isdefined( placement ) )
    {
        bots_tactical_goals::abort_tactical_goal( "sentry_placement" );
        extra_params = spawnstruct();
        extra_params.object = placement;
        extra_params.script_goal_yaw = placement.yaw;
        extra_params.script_goal_radius = 16;
        extra_params.start_thread = &bot_sentry_path_start;
        extra_params.end_thread = &bot_sentry_cancel;
        extra_params.should_abort = &bot_sentry_should_abort;
        extra_params.action_thread = &bot_sentry_activate;
        self.placingitemstreakname = killstreak_info.streakname;
        bots_tactical_goals::new_tactical_goal( "sentry_placement", placement.tacpoint, 0, extra_params );
    }
}

// Namespace bots_sentry
// Params 1
// Checksum 0x3a58a76c, Offset: 0x446
// Size: 0x7d, Type: bool
function bot_sentry_should_abort( tactical_goal )
{
    self endon( #"death_or_disconnect" );
    self endon( #"exit_autopilot" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
    {
        return true;
    }
    
    self.sentry_place_delay = gettime() + 1000;
    return false;
}

// Namespace bots_sentry
// Params 0
// Checksum 0x406ff294, Offset: 0x4cc
// Size: 0x67
function bot_sentry_cancel_failsafe()
{
    self endon( #"hash_97d1fab397e2782e" );
    self endon( #"bot_sentry_ensure_exit" );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && self.enemy.health > 0 && self botcanseeentity( self.enemy ) )
        {
            thread bot_sentry_cancel();
        }
        
        wait 0.05;
    }
}

// Namespace bots_sentry
// Params 1
// Checksum 0x33195000, Offset: 0x53b
// Size: 0x15
function bot_sentry_path_start( tactical_goal )
{
    thread bot_sentry_path_thread( tactical_goal );
}

// Namespace bots_sentry
// Params 1
// Checksum 0x26564061, Offset: 0x558
// Size: 0xeb
function bot_sentry_path_thread( tactical_goal )
{
    self endon( #"death_or_disconnect" );
    self endon( #"exit_autopilot" );
    level endon( #"game_ended" );
    self endon( #"stop_tactical_goal" );
    self endon( #"hash_b8ad01b33c92c445" );
    self endon( #"hash_97d1fab397e2782e" );
    self endon( #"hash_240a9610b35494c8" );
    
    while ( true )
    {
        if ( distance2d( self.origin, tactical_goal.object.tacpoint.groundpos ) < 400 )
        {
            thread bots_util::bot_force_stance_for_time( "stand", 5 );
            childthread bot_sentry_cancel_failsafe();
            bots_killstreaks::bot_switch_to_killstreak_weapon( tactical_goal.object.killstreak_info, tactical_goal.object.killstreak_slot );
            return;
        }
        
        wait 0.05;
    }
}

// Namespace bots_sentry
// Params 1
// Checksum 0xc71b2616, Offset: 0x64b
// Size: 0x108
function bot_sentry_choose_target( targettype )
{
    var_7237854e3be197ca = bots_scripted_defense::get_valid_center();
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( isdefined( self.var_624c9f3d7225954 ) )
    {
        return self.var_624c9f3d7225954.groundpos;
    }
    
    tacpoints = function_a034a927128ada11( self.origin, 1000, 0, 512 );
    tacpoints = bots_util::function_4eb61a3985ad712c( tacpoints );
    var_e437ce7a9c5d8619 = 5;
    
    if ( targettype != "turret" )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
        {
            var_e437ce7a9c5d8619 = 10;
        }
        else if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
        {
            var_e437ce7a9c5d8619 = 15;
        }
    }
    
    if ( targettype == "turret_air" )
    {
        targettacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_target -> tacpoint pick exposed no sky", tacpoints, var_e437ce7a9c5d8619, "exposed", "ignore_no_sky" );
    }
    else
    {
        targettacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_target -> tacpoint pick exposed", tacpoints, var_e437ce7a9c5d8619, "exposed" );
    }
    
    if ( isdefined( targettacpoint ) )
    {
        return targettacpoint.groundpos;
    }
}

// Namespace bots_sentry
// Params 4
// Checksum 0xcd3b077c, Offset: 0x75b
// Size: 0x1a6
function bot_sentry_choose_placement( killstreak_info, killstreak_slot, targetorigin, targettype )
{
    placement = undefined;
    tacpoints = function_a034a927128ada11( targetorigin, 1000, 0, 512 );
    tacpoints = bots_util::function_4eb61a3985ad712c( tacpoints );
    var_e437ce7a9c5d8619 = 5;
    
    if ( targettype != "turret" )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
        {
            var_e437ce7a9c5d8619 = 10;
        }
        else if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
        {
            var_e437ce7a9c5d8619 = 15;
        }
    }
    
    if ( targettype == "turret_air" )
    {
        placetacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_placement -> tacpoint pick sentry no sky", tacpoints, var_e437ce7a9c5d8619, "sentry", targetorigin, "ignore_no_sky" );
    }
    else if ( targettype == "trap" )
    {
        placetacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_placement -> tacpoint pick exposed", tacpoints, var_e437ce7a9c5d8619, "exposed" );
    }
    else if ( targettype == "hide_nonlethal" )
    {
        placetacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_placement -> tacpoint pick hide", tacpoints, var_e437ce7a9c5d8619, "hide" );
    }
    else
    {
        placetacpoint = bots_util::function_ec1247a9311f67a4( "bot_sentry_choose_placement -> tacpoint pick senty", tacpoints, var_e437ce7a9c5d8619, "sentry", targetorigin );
    }
    
    if ( isdefined( placetacpoint ) )
    {
        placement = spawnstruct();
        placement.tacpoint = placetacpoint;
        
        if ( targetorigin != placetacpoint.groundpos && targettype != "hide_nonlethal" )
        {
            placement.yaw = vectortoyaw( targetorigin - placetacpoint.groundpos );
        }
        else
        {
            placement.yaw = undefined;
        }
        
        placement.killstreak_info = killstreak_info;
        placement.killstreak_slot = killstreak_slot;
    }
    
    return placement;
}

// Namespace bots_sentry
// Params 0
// Checksum 0xb523ca50, Offset: 0x90a
// Size: 0x48
function bot_sentry_carried_obj()
{
    var_7237854e3be197ca = self.carriedsentry;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.carriedims;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.carrieditem;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace bots_sentry
// Params 1
// Checksum 0xe16ef45f, Offset: 0x95a
// Size: 0x22, Type: bool
function bot_sentry_activate( tactical_goal )
{
    bot_send_place_notify();
    wait 0.25;
    bot_sentry_ensure_exit();
    return true;
}

// Namespace bots_sentry
// Params 0
// Checksum 0x6874b1cb, Offset: 0x985
// Size: 0x65
function bot_send_place_notify()
{
    self notify( #"place_sentry" );
    self notify( #"place_ims" );
    self notify( #"placePlaceable" );
    forwardloc = self.origin + anglestoforward( self.angles ) * 50;
    self notify( #"equip_deploy_succeeded", undefined, undefined, forwardloc, self.angles );
}

// Namespace bots_sentry
// Params 0
// Checksum 0x4404099e, Offset: 0x9f2
// Size: 0x3d
function bot_send_cancel_notify()
{
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
    self notify( #"cancel_sentry" );
    self notify( #"cancel_ims" );
    self notify( #"cancelPlaceable" );
}

// Namespace bots_sentry
// Params 1
// Checksum 0x833aaaf5, Offset: 0xa37
// Size: 0x26
function bot_sentry_cancel( tactical_goal )
{
    self notify( #"hash_97d1fab397e2782e" );
    bot_send_cancel_notify();
    bot_sentry_ensure_exit();
}

// Namespace bots_sentry
// Params 0
// Checksum 0xd61f561c, Offset: 0xa65
// Size: 0xb1
function bot_sentry_ensure_exit()
{
    self notify( #"hash_fec96dcba18326fe" );
    self notify( #"bot_sentry_ensure_exit" );
    self endon( #"bot_sentry_ensure_exit" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self switchtoweapon( "none" );
    self botclearscriptgoal();
    self botsetstance( "none" );
    self enableweapons();
    self enableweaponswitch();
    wait 0.25;
    attempts = 0;
    
    while ( isdefined( bot_sentry_carried_obj() ) )
    {
        attempts++;
        bot_send_cancel_notify();
        wait 0.25;
        
        if ( attempts > 2 )
        {
            bot_sentry_force_cancel();
        }
    }
    
    self notify( #"hash_240a9610b35494c8" );
}

// Namespace bots_sentry
// Params 0
// Checksum 0x9aca5dc2, Offset: 0xb1e
// Size: 0x7b
function bot_sentry_force_cancel()
{
    if ( isdefined( self.carriedsentry ) )
    {
        self.carriedsentry autosentry::sentry_setcancelled();
    }
    
    if ( isdefined( self.carrieditem ) )
    {
        self.carrieditem placeable::oncancel( self.placingitemstreakname, 0 );
    }
    
    self.carriedsentry = undefined;
    self.carriedims = undefined;
    self.carrieditem = undefined;
    self switchtoweapon( "none" );
    self enableweapons();
    self enableweaponswitch();
}

