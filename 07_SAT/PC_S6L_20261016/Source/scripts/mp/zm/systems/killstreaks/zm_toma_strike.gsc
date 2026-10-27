// scripts\mp\zm\systems\killstreaks\zm_toma_strike.gsc  (hash_76eb0a59e8926fd5.gscc) (size: 4491 Bytes / 0x118b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad40f13a (2906714426)
// size ...... 4491 (0x118b)
// includes .. 7   (offset: 0x1083)
// strings ... 13  (offset: 0x10bb)
// dev strs .. 0   (offset: 0x118b)
// exports ... 16  (offset: 0x95f)
// cseg ...... 0x182 + 0x7dd (0x95f)
// imports ... 40  (offset: 0xbdf)
// animtree1 . 0   (offset: 0x118b)
// animtree2 . 0   (offset: 0x118b)
#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_toma_strike;

// Namespace zm_toma_strike
// Params 0, eflags: 0x5
// Checksum 0x228ea6fa, Offset: 0x1a0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_toma_strike", undefined, &__init__, undefined );
}

// Namespace zm_toma_strike
// Params 0
// Checksum 0x2b48c9d4, Offset: 0x1c1
// Size: 0xa
function __init__()
{
    level thread init_zm_toma_strike();
}

// Namespace zm_toma_strike
// Params 0
// Checksum 0x467bc3ec, Offset: 0x1d3
// Size: 0xca
function init_zm_toma_strike()
{
    utility::flag_wait( "toma_strike_initialized" );
    utility::registersharedfunc( #"killstreak", #"hash_8c6567a01fb8c81a", &function_64dc683ec422a7aa );
    utility::registersharedfunc( #"killstreak", #"hash_764fee55301f33f3", &toma_strike_begin );
    utility::registersharedfunc( #"killstreak", #"tomastrikeendfunc", &toma_strike_end );
    utility::registersharedfunc( #"toma_strike", #"damageoverride", &zm_toma_strike_damage );
    utility::registersharedfunc( #"killstreak", #"hash_3687f10503075830", &function_5b265793f7ece22a );
    utility::registersharedfunc( #"killstreak", #"hash_7af048d104650b20", &toma_strike_cancel );
    level thread register_on_kill_medal();
}

// Namespace zm_toma_strike
// Params 0, eflags: 0x4
// Checksum 0x53831dfa, Offset: 0x2a5
// Size: 0x88
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        bundle = level.streakglobals.streakbundles[ "toma_strike" ];
        
        if ( isdefined( bundle.toma_weapon_name ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", bundle.toma_weapon_name, &on_killed_medal );
        }
    }
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0xf72b669, Offset: 0x335
// Size: 0x39
function function_64dc683ec422a7aa( streak_info )
{
    val::set( "toma_strike", "interactions", 0 );
    thread function_22f4a1b7c90a257c( streak_info );
    thread function_51736a19e7bc9b39( streak_info );
    thread function_b2d4111410993d4f( streak_info );
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0xb11ff76f, Offset: 0x376
// Size: 0x18
function toma_strike_cancel( streak_info )
{
    self setclientomnvar( "ui_turret_placement", 0 );
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0x9fac06de, Offset: 0x396
// Size: 0x3c
function function_22f4a1b7c90a257c( streak_info )
{
    self endon( #"disconnect" );
    streak_info utility::waittill_any( "killstreak_finished_with_deploy_weapon", "killstreak_failed_use", "toma_strike_canceled" );
    val::reset_all( "toma_strike" );
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0x826fc045, Offset: 0x3da
// Size: 0xd7
function function_51736a19e7bc9b39( streak_info )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"cancel_all_killstreak_deployments" );
    streak_info endon( #"killstreak_finished_with_deploy_weapon" );
    streak_info endon( #"toma_strike_canceled" );
    streak_info endon( #"killstreak_failed_use" );
    streak_info endon( #"deploy_finished" );
    
    while ( true )
    {
        if ( isdefined( level.var_7a5a3a48204781da ) && isdefined( streak_info.mpstreaksysteminfo ) && isdefined( streak_info.var_9384480e6997afd7 ) )
        {
            if ( !self [[ level.var_7a5a3a48204781da ]]( streak_info.mpstreaksysteminfo, streak_info.var_9384480e6997afd7 ) )
            {
                self setclientomnvar( "ui_turret_placement", 0 );
                killstreakdeploy::streakdeploy_cancelalldeployments();
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0x97780f30, Offset: 0x4b9
// Size: 0xe6
function function_b2d4111410993d4f( streakinfo )
{
    self notify( #"hash_a08f34602583045d" );
    self endon( #"hash_a08f34602583045d" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    streakinfo endon( #"toma_strike_canceled" );
    streakinfo endon( #"killstreak_failed_use" );
    streakinfo endon( #"deploy_finished" );
    
    while ( isalive( self ) )
    {
        self.var_5aef88060ea2e2c1 = toma_strike::tomastrike_getownerlookat( self, streakinfo );
        var_ef727c3ceab7d1d6 = function_5b265793f7ece22a( self.var_5aef88060ea2e2c1 );
        
        if ( var_ef727c3ceab7d1d6 )
        {
            self function_43c87f41d02d3870();
        }
        else
        {
            self function_f7cc2bc7474de74e();
        }
        
        self setclientomnvar( "ui_turret_placement", !var_ef727c3ceab7d1d6 );
        wait 0.25;
    }
    
    if ( self )
    {
        self function_43c87f41d02d3870();
        self setclientomnvar( "ui_turret_placement", 0 );
    }
}

// Namespace zm_toma_strike
// Params 0
// Checksum 0x9f63642f, Offset: 0x5a7
// Size: 0x21
function toma_strike_begin()
{
    val::set( "toma_strike", "interactions", 1 );
    utility::flag_set( "toma_strike_begin" );
}

// Namespace zm_toma_strike
// Params 0
// Checksum 0x6d36ae0e, Offset: 0x5d0
// Size: 0x1f
function toma_strike_end()
{
    if ( isdefined( self ) )
    {
        val::reset_all( "toma_strike" );
        utility::flag_clear( "toma_strike_begin" );
    }
}

// Namespace zm_toma_strike
// Params 7
// Checksum 0xd8318ac7, Offset: 0x5f7
// Size: 0xf6
function zm_toma_strike_damage( origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon )
{
    attacker radiusdamage( origin, range, maxdamage, mindamage, attacker, meansofdeath, weapon, 1 );
    var_317a1fff030a6aa1 = attacker get_proximity_enemies( range, origin );
    
    foreach ( ai in var_317a1fff030a6aa1 )
    {
        ai dodamage( maxdamage, ai.origin, attacker, attacker, meansofdeath, weapon, "none", undefined, 536936448 );
        waitframe();
    }
}

// Namespace zm_toma_strike
// Params 2
// Checksum 0xcc6a9cc0, Offset: 0x6f5
// Size: 0xff
function get_proximity_enemies( n_radius, v_origin )
{
    a_ai_nearby = physics_querypoint( v_origin, n_radius, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
    var_317a1fff030a6aa1 = [];
    
    if ( !isdefined( a_ai_nearby ) )
    {
        return var_317a1fff030a6aa1;
    }
    
    foreach ( ai_nearby in a_ai_nearby )
    {
        ai = ai_nearby[ "entity" ];
        
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai.team == self.team )
        {
            continue;
        }
        
        var_317a1fff030a6aa1[ var_317a1fff030a6aa1.size ] = ai;
    }
    
    return var_317a1fff030a6aa1;
}

// Namespace zm_toma_strike
// Params 4, eflags: 0x4
// Checksum 0x9d5496fc, Offset: 0x7fd
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "toma_strike", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "toma_strike" ] ) && self.rapidkill_data[ "toma_strike" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_strikedelivered" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "toma_strike", victim );
    }
}

// Namespace zm_toma_strike
// Params 1
// Checksum 0x594cebd4, Offset: 0x8f4
// Size: 0x6a, Type: bool
function function_5b265793f7ece22a( pos )
{
    if ( !pos )
    {
        return false;
    }
    
    if ( isdefined( level.var_82608d37301e46de ) )
    {
        zone_struct = zone_manager::function_90e5c3e2272b0130( pos );
        
        if ( zone_struct.zone_name && arraycontains( level.var_82608d37301e46de, zone_struct.zone_name ) || !zone_struct )
        {
            return false;
        }
    }
    
    return true;
}

