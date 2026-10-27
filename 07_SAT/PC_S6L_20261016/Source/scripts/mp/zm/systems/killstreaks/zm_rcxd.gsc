// scripts\mp\zm\systems\killstreaks\zm_rcxd.gsc  (hash_09f56c420e80588c.gscc) (size: 7868 Bytes / 0x1ebc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x769654e7 (1989563623)
// size ...... 7868 (0x1ebc)
// includes .. 10  (offset: 0x1cbc)
// strings ... 25  (offset: 0x1d0c)
// dev strs .. 0   (offset: 0x1ebc)
// exports ... 22  (offset: 0x10a8)
// cseg ...... 0x1f0 + 0xeb8 (0x10a8)
// imports ... 74  (offset: 0x1418)
// animtree1 . 0   (offset: 0x1ebc)
// animtree2 . 0   (offset: 0x1ebc)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\zm\zm_utility;

#namespace zm_rcxd;

// Namespace zm_rcxd
// Params 0, eflags: 0x5
// Checksum 0x31e357eb, Offset: 0x20e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_rcxd", undefined, &__init__, undefined );
}

// Namespace zm_rcxd
// Params 0
// Checksum 0x3f06fe97, Offset: 0x22f
// Size: 0xa
function __init__()
{
    level thread main();
}

// Namespace zm_rcxd
// Params 0
// Checksum 0x3faa150c, Offset: 0x241
// Size: 0xd6
function main()
{
    utility::flag_wait( "rcxd_shared_initialized" );
    utility::registersharedfunc( #"killstreak", #"hash_d3cd9f41839cace8", &function_abc8dcdb29b329a4 );
    utility::registersharedfunc( #"killstreak", #"hash_d8307e54206525a9", &arcxd_begin );
    utility::registersharedfunc( #"killstreak", #"rcxdendfunc", &arcxd_end );
    utility::registersharedfunc( #"killstreak", #"rcxdhitai", &function_7082d1c4cda7dd9f );
    utility::registersharedfunc( #"killstreak", #"hash_8b60bc2f7230ff2e", &function_ff25c2d96966f008 );
    utility::registersharedfunc( #"killstreak", #"hash_d5feedce982670dd", &function_5c85412f6ad81bb1 );
    scene::function_85b13b837056bc8b( &function_f8f82586afe3325f );
    level thread register_on_kill_medal();
}

// Namespace zm_rcxd
// Params 0
// Checksum 0xa8be5d06, Offset: 0x31f
// Size: 0x4, Type: bool
function function_5c85412f6ad81bb1()
{
    return true;
}

// Namespace zm_rcxd
// Params 0
// Checksum 0x69279348, Offset: 0x32c
// Size: 0x9d
function function_f8f82586afe3325f()
{
    level endon( #"game_ended" );
    
    if ( isarray( level.rcxds ) )
    {
        foreach ( rcxd in level.rcxds )
        {
            if ( isdefined( rcxd ) )
            {
                rcxd thread rcxd_shared::rcxd_explode();
            }
        }
    }
}

// Namespace zm_rcxd
// Params 0, eflags: 0x4
// Checksum 0xeb6fdbdf, Offset: 0x3d1
// Size: 0x4e
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", "rcxd", &on_killed_medal );
    }
}

// Namespace zm_rcxd
// Params 1
// Checksum 0xdf3a83cd, Offset: 0x427
// Size: 0x5a
function function_abc8dcdb29b329a4( streak_info )
{
    val::set( "rcxd", "damage", 0 );
    val::set( "rcxd", "ignoreme", 1 );
    val::set( "rcxd", "interactions", 0 );
    streak_info.var_ebcce815485d5da0 = 1;
    thread function_3fcfdf54c69c6aa2( streak_info );
}

// Namespace zm_rcxd
// Params 1
// Checksum 0x5447b842, Offset: 0x489
// Size: 0x37
function function_3fcfdf54c69c6aa2( streak_info )
{
    self endon( #"disconnect" );
    streak_info utility::waittill_any( "killstreak_finished_with_deploy_weapon", "killstreak_failed_use" );
    val::reset_all( "rcxd" );
}

// Namespace zm_rcxd
// Params 1
// Checksum 0x6f6a0dc8, Offset: 0x4c8
// Size: 0x17a
function arcxd_begin( vh_rcxd )
{
    self endon( #"disconnect" );
    vh_rcxd endon( #"death" );
    utility::flag_set( "rcxd_begin" );
    val::set( "rcxd", "damage", 0 );
    val::set( "rcxd", "ignoreme", 1 );
    val::set( "rcxd", "interactions", 0 );
    val::set( "rcxd", "usability", 0 );
    self notify( #"hash_933fc525ef34eec9" );
    self.var_71b8d0f973d4bc71 = 1;
    vh_rcxd.attractor = zombie_attractor_manager::add_attractor( vh_rcxd, 1, 2000, 1, undefined, &function_e332874c54a744d3, 0, undefined, 1 );
    vh_rcxd thread function_d341891620dcef3( vh_rcxd, self );
    vh_rcxd thread function_b04a05fa0708d4a5( vh_rcxd, self );
    vh_rcxd thread utility::thread_on_notify( "hit_from_attracted_zombie", &on_hit_from_attracted_zombie );
    n_pulse_frequency = level.streakglobals.streakbundles[ "rcxd" ].var_3b037088c6e733f9 ?? 1.5;
    level.zmRCXDTickThrottle = throttle::throttle_initialize( "zmRCXDTickThrottle", 1, level.framedurationseconds );
    wait 0.25;
    arcxd_pulse( vh_rcxd );
    thread function_e4d5f90b8a7969a9( self );
    thread function_6d95dd60d3170b46( vh_rcxd );
    
    while ( true )
    {
        wait n_pulse_frequency;
        
        if ( vh_rcxd.var_24715590a2643 )
        {
            continue;
        }
        
        arcxd_pulse( vh_rcxd );
    }
}

// Namespace zm_rcxd
// Params 1
// Checksum 0x3599c063, Offset: 0x64a
// Size: 0x11e
function function_e4d5f90b8a7969a9( player )
{
    self endon( #"zm_rcxd_end" );
    player endon( #"disconnect" );
    
    while ( player )
    {
        potential_zombies = getaiarrayinradius( player.origin, 45 );
        
        foreach ( zombie in potential_zombies )
        {
            if ( isalive( player ) && isai( zombie ) && isalive( zombie ) && zombie.team != player.team )
            {
                knockback_dir = vectornormalize( player.origin - zombie.origin );
                player knockback( knockback_dir, 100, 1 );
                wait 1;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_rcxd
// Params 1
// Checksum 0xa577bdb1, Offset: 0x770
// Size: 0xc1
function function_6d95dd60d3170b46( vh_rcxd )
{
    self endon( #"zm_rcxd_end" );
    vh_rcxd endon( #"death" );
    off_navmesh_checks = 0;
    
    while ( true )
    {
        if ( !vh_rcxd vehicle_isonground() )
        {
            waitframe();
            continue;
        }
        
        navmesh_pos = getclosestpointonnavmesh( vh_rcxd.origin );
        
        if ( !navmesh_pos || distancesquared( vh_rcxd.origin, navmesh_pos ) > squared( getdvarfloat( @"hash_58343ef192333402", 70 ) ) )
        {
            off_navmesh_checks += 1;
            
            if ( off_navmesh_checks >= getdvarint( @"hash_a31af3afe556fa5c", 4 ) )
            {
                vh_rcxd thread rcxd_shared::rcxd_explode();
            }
        }
        else
        {
            off_navmesh_checks = 0;
        }
        
        wait 0.5;
    }
}

// Namespace zm_rcxd
// Params 2
// Checksum 0x3be963e8, Offset: 0x839
// Size: 0x55
function function_e332874c54a744d3( attractor, ai )
{
    if ( !ai.var_840153567385cc6b )
    {
        if ( ai.team != attractor.source.team )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace zm_rcxd
// Params 2
// Checksum 0xe9a9f18f, Offset: 0x896
// Size: 0x65
function function_b04a05fa0708d4a5( vh_rcxd, player )
{
    self endon( #"disconnect" );
    vh_rcxd endon( #"death" );
    level endon( #"game_ended" );
    player waittill( #"cutscene_cleanup" );
    vh_rcxd thread rcxd_shared::rcxd_explode();
    vh_rcxd.driver thread rcxd_shared::function_97ec301a6784838a( vh_rcxd );
}

// Namespace zm_rcxd
// Params 0, eflags: 0x4
// Checksum 0x21ff42e5, Offset: 0x903
// Size: 0x18
function private on_hit_from_attracted_zombie()
{
    vh_rcxd = self;
    vh_rcxd thread rcxd_shared::rcxd_explode();
}

// Namespace zm_rcxd
// Params 2
// Checksum 0x2e44c8a5, Offset: 0x923
// Size: 0xfa
function function_d341891620dcef3( vh_rcxd, player )
{
    player endon( #"disconnect" );
    vh_rcxd endon( #"death" );
    var_64e6f239baee0248 = 0.1;
    level.var_27d07cce02bb2692 = getentarray( "teleport_back_trigger", #targetname );
    
    if ( level.var_27d07cce02bb2692.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        wait var_64e6f239baee0248;
        
        foreach ( check_volume in level.var_27d07cce02bb2692 )
        {
            if ( self istouching( check_volume ) )
            {
                vh_rcxd thread rcxd_shared::rcxd_explode();
                break;
            }
        }
    }
}

// Namespace zm_rcxd
// Params 1
// Checksum 0xae135702, Offset: 0xa25
// Size: 0x406
function arcxd_pulse( vh_rcxd )
{
    s_killstreak_bundle = level.streakglobals.streakbundles[ "rcxd" ];
    n_radius = s_killstreak_bundle.var_f419bf700afcc6eb ?? 200;
    self endon( #"disconnect" );
    vh_rcxd endon( #"death" );
    vh_rcxd utility::function_7c10ea82c1e305b8( "aether_pulse", "on" );
    a_zombies = getplayersandaiarrayinradius( vh_rcxd.origin, n_radius );
    
    foreach ( var_ea616919227739f in a_zombies )
    {
        if ( isplayer( var_ea616919227739f ) && isalive( var_ea616919227739f ) )
        {
            player = var_ea616919227739f;
            
            if ( player.team == self.team || !player val::get( "damage" ) || player.inlaststand )
            {
                continue;
            }
            
            if ( isdefined( level.zmRCXDTickThrottle ) )
            {
                throttle::throttle_wait_in_queue( level.zmRCXDTickThrottle, player );
            }
            
            player dodamage( player.maxhealth * 0.15, player.origin, vh_rcxd.owner, vh_rcxd, "MOD_UNKNOWN", "rcxd" );
            continue;
        }
        
        if ( isalive( var_ea616919227739f ) && var_ea616919227739f.team === zm_utility::get_zombie_team() && isdefined( var_ea616919227739f.aicategory ) )
        {
            if ( isdefined( level.zmRCXDTickThrottle ) )
            {
                throttle::throttle_wait_in_queue( level.zmRCXDTickThrottle, var_ea616919227739f );
            }
            
            if ( !var_ea616919227739f val::get( "damage" ) )
            {
                continue;
            }
            
            if ( var_ea616919227739f.aicategory == "normal" || var_ea616919227739f.aicategory == "vermin" )
            {
                var_ea616919227739f thread arcxd_zombie_fling( vh_rcxd );
            }
            else if ( var_ea616919227739f.aicategory == "special" )
            {
                var_ea616919227739f dodamage( var_ea616919227739f.maxhealth * 0.15, var_ea616919227739f.origin, vh_rcxd.owner, vh_rcxd, "MOD_UNKNOWN", "rcxd" );
            }
            else if ( var_ea616919227739f.aicategory == "elite" || var_ea616919227739f.aicategory == "hvt" || var_ea616919227739f.aicategory == "boss" )
            {
                var_ea616919227739f dodamage( var_ea616919227739f.maxhealth * 0.05, var_ea616919227739f.origin, vh_rcxd.owner, vh_rcxd, "MOD_UNKNOWN", "rcxd" );
            }
            
            if ( isdefined( level.zmRCXDTickThrottle ) )
            {
                throttle::throttle_wait_in_queue( level.zmRCXDTickThrottle, var_ea616919227739f );
            }
        }
    }
    
    waitframe();
    v_explosion = vh_rcxd.origin;
    earthquake( 0.2, level.streakglobals.streakbundles[ "rcxd" ].var_3b037088c6e733f9 * 0.25, v_explosion, n_radius );
    playrumbleonposition( "grenade_rumble", v_explosion );
    physicsexplosionsphere( v_explosion, n_radius, 0, 200, 0 );
    vh_rcxd radiusdamage( vh_rcxd.origin, n_radius, s_killstreak_bundle.var_795b7c0589ec54d, s_killstreak_bundle.var_771a1c058761a33, self, "MOD_UNKNOWN", "rcxd", 1 );
    glassradiusdamage( vh_rcxd.origin, n_radius, s_killstreak_bundle.var_795b7c0589ec54d, s_killstreak_bundle.var_771a1c058761a33 );
    vh_rcxd utility::function_7c10ea82c1e305b8( "aether_pulse", "off" );
}

// Namespace zm_rcxd
// Params 1
// Checksum 0x8cfa62d8, Offset: 0xe33
// Size: 0xd5
function arcxd_zombie_fling( vh_rcxd )
{
    v_dir = vectornormalize( self.origin - vh_rcxd.origin );
    v_launch = v_dir * randomintrange( 2200, 2400 ) + ( 0, 0, randomintrange( 900, 1100 ) );
    var_471b16bf43cda71a = !zombie_traverse::is_traversing();
    self dodamage( self.health, self.origin, vh_rcxd.owner, vh_rcxd, "MOD_UNKNOWN", "rcxd", "torso_lower" );
    var_24ed309d808c077a = self getcorpseentity();
    
    if ( var_471b16bf43cda71a && isdefined( var_24ed309d808c077a ) && !var_24ed309d808c077a isragdoll() )
    {
        var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch * 1.2 );
    }
}

// Namespace zm_rcxd
// Params 1
// Checksum 0x589c1d7d, Offset: 0xf10
// Size: 0x5b
function arcxd_end( vh_rcxd )
{
    if ( isdefined( vh_rcxd.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( vh_rcxd.attractor );
    }
    
    self notify( #"zm_rcxd_end" );
    utility::flag_clear( "rcxd_begin" );
    val::reset_all( "rcxd" );
    self.var_71b8d0f973d4bc71 = undefined;
}

// Namespace zm_rcxd
// Params 1, eflags: 0x4
// Checksum 0xf31cd1b1, Offset: 0xf73
// Size: 0x13
function private function_7082d1c4cda7dd9f( ai )
{
    thread rcxd_shared::rcxd_explode();
}

// Namespace zm_rcxd
// Params 0, eflags: 0x4
// Checksum 0xa5694ecf, Offset: 0xf8e
// Size: 0x22
function private function_ff25c2d96966f008()
{
    var_180f0855240c12d1 = spawnstruct();
    var_180f0855240c12d1.var_66933a12fdd7c8ce = 1;
    return var_180f0855240c12d1;
}

// Namespace zm_rcxd
// Params 4, eflags: 0x4
// Checksum 0x38a6adc, Offset: 0xfb9
// Size: 0xef
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "rcxd", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "rcxd" ] ) && self.rapidkill_data[ "rcxd" ].rapidkill_count === 5 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_rushdelivery" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "rcxd", victim );
    }
}

