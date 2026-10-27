// scripts\mp\ob\supers\super_portal_summon.gsc  (hash_05359d8d3d7aecb9.gscc) (size: 12835 Bytes / 0x3223 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd365d6bf (3546666687)
// size ...... 12835 (0x3223)
// includes .. 12  (offset: 0x2fcf)
// strings ... 17  (offset: 0x302f)
// dev strs .. 20  (offset: 0x312b)
// exports ... 36  (offset: 0x1d07)
// cseg ...... 0x170 + 0x1b97 (0x1d07)
// imports ... 112 (offset: 0x22a7)
// animtree1 . 0   (offset: 0x3223)
// animtree2 . 0   (offset: 0x3223)
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace portal_summon;

// Namespace portal_summon
// Params 0, eflags: 0x5
// Checksum 0x5d339352, Offset: 0x18e
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x8b93fbd3, Offset: 0x1ae
// Size: 0x7b
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_portal_summon" );
    
    if ( !bundle )
    {
        return;
    }
    
    weapons::registerusedcallback( "super_portal_summon", &weapon_used );
    disconnect_event_aggregator::function_f460203966e88ab0( &function_afb772a4db682a6c );
    
    if ( bundle.portal_summon_zombie_spawn_fx )
    {
        level._effect[ "portal_summon_zombie_spawn_fx" ] = loadfxasset( bundle.portal_summon_zombie_spawn_fx );
    }
    
    debug_devgui();
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x20e68e3c, Offset: 0x231
// Size: 0xc
function private function_afb772a4db682a6c( player )
{
    
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x9cf1e2e3, Offset: 0x245
// Size: 0x87
function private weapon_used( grenade )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.portal_summon_weapon_obj )
    {
        supers_mp::registersuperextraweapon( "super_portal_summon", grenade.weapon_name );
        level.portal_summon_weapon_obj = grenade.weapon_object;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_portal_summon" );
    thread function_c8d7e43b9edf1252( grenade, bundle );
    thread manage_missile_stuck( grenade, bundle );
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x1b334d1e, Offset: 0x2d4
// Size: 0x86
function private manage_missile_stuck( grenade, bundle )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    grenade endon( #"explode" );
    grenade waittill( #"missile_stuck" );
    position_spawn = grenade.origin;
    angles_spawn = grenade.angles;
    grenade delete();
    function_8ad36b9f50d770db( bundle, position_spawn, angles_spawn );
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x9f47eaa1, Offset: 0x362
// Size: 0x6b
function private function_c8d7e43b9edf1252( grenade, bundle )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    grenade endon( #"missile_stuck" );
    grenade waittill( #"explode", position );
    function_8ad36b9f50d770db( bundle, position, ( 0, 0, 0 ) );
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0xcb059b26, Offset: 0x3d5
// Size: 0x65
function private function_8ad36b9f50d770db( bundle, position_spawn, angles_spawn )
{
    if ( bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        callback::add( #"super_cancel", &cancel );
    }
    
    spawn_all_zombies( bundle, position_spawn, angles_spawn );
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x775cc593, Offset: 0x442
// Size: 0x144
function private cancel( params )
{
    self notify( #"cancel_zombie_spawn" );
    
    if ( self.zombiescreated.size > 0 )
    {
        foreach ( zombie in self.zombiescreated )
        {
            zombie notify( #"cancel_zombie_spawn" );
            zombie thread agent_utils::despawnagent();
        }
        
        self.zombiescreated = undefined;
    }
    
    if ( self.var_dbb0c80988138d18.size > 0 )
    {
        foreach ( groupid in self.var_dbb0c80988138d18 )
        {
            ai_spawn_director::function_d15a5427eec4ebe3( groupid );
        }
    }
    
    remove_cancel();
}

// Namespace portal_summon
// Params 0, eflags: 0x4
// Checksum 0xd868e7fb, Offset: 0x58e
// Size: 0x73
function private remove_cancel()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_portal_summon" );
    
    if ( bundle.var_8b9eade13fbfb044 && ( !isdefined( self.zombiescreated ) || self.zombiescreated.size == 0 ) && callback::exists( #"super_cancel", &cancel ) )
    {
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x6860d550, Offset: 0x609
// Size: 0x8d
function private function_5e3e0df18122335a( sparams )
{
    if ( isplayer( self.owner ) )
    {
        player = self.owner;
        
        if ( !isdefined( player.var_5a95deaf729b5f6a ) || gettime() - player.var_5a95deaf729b5f6a > 1000 )
        {
            player.var_5a95deaf729b5f6a = gettime();
            player utility::callsharedfunc( #"player", #"doScoreEvent", #"super_portal_summon_damage" );
        }
    }
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0xd6fa7b52, Offset: 0x69e
// Size: 0xbf
function private on_zombie_damaged( dmgstruct )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_portal_summon" );
    
    if ( isplayer( dmgstruct.eattacker ) && bundle.var_2e5558958b690224 )
    {
        dmgstruct.idamage *= 1 - bundle.var_2e5558958b690224;
    }
    else if ( isai( dmgstruct.eattacker ) && bundle.var_4b5113fc786f8a6d )
    {
        dmgstruct.idamage *= 1 - bundle.var_4b5113fc786f8a6d;
    }
    
    return dmgstruct.idamage;
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0xb7a149e0, Offset: 0x766
// Size: 0x1b8
function private spawn_all_zombies( bundle, var_309634b8ff5bd84d, anglesspawn )
{
    self endon( #"cancel_zombie_spawn" );
    zombieaitype = bundle.portal_summon_zombie_ai_type ?? "sat_spawner_zombie_base_ob";
    extrazombies = utility::callsharedfunc( "super_portal_summon", #"hash_b670f3895a269ae" ) ?? 0;
    totalzombies = ( bundle.var_b3c4d8d506a0734d ?? 3 ) + extrazombies;
    delayspawn = bundle.var_50cccc5f7115fc8a ?? 0.5;
    
    if ( !isdefined( self.var_dbb0c80988138d18 ) )
    {
        self.var_dbb0c80988138d18 = [];
    }
    
    spawngroupid = ai_spawn_director::function_e19f6a00c4bb7490( "portal_summon", 0, 1, 1, 0, 3 );
    self.var_dbb0c80988138d18[ self.var_dbb0c80988138d18.size ] = spawngroupid;
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", spawngroupid, &function_24bb5c2aa0708efb, { #bundle:bundle, #owner:self } );
    ai_spawn_director::function_35aa3b1d92cd8207( "Shutdown", spawngroupid, &function_d70e6f9cbc66828, { #owner:self } );
    
    if ( !isdefined( self.zombiescreated ) )
    {
        self.zombiescreated = [];
    }
    
    position_to_spawn = function_dc62f3350a2eaec0( var_309634b8ff5bd84d, bundle );
    
    if ( !position_to_spawn )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"hash_1dcdd2de6918fb96" );
        return;
    }
    
    for ( i = 0; i < totalzombies ; i++ )
    {
        thread function_fcc576ce75ae207c( bundle, position_to_spawn, zombieaitype, anglesspawn, spawngroupid );
        
        if ( delayspawn != 0 )
        {
            wait delayspawn;
        }
    }
}

// Namespace portal_summon
// Params 5, eflags: 0x4
// Checksum 0xe381a27e, Offset: 0x926
// Size: 0x8a
function private function_fcc576ce75ae207c( bundle, position_to_spawn, zombieaitype, anglesspawn, spawngroupid )
{
    real_spawn_position = get_spawn_position( bundle, position_to_spawn );
    
    if ( !isdefined( real_spawn_position ) )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"hash_1dcdd2de6918fb96" );
        return;
    }
    
    ai_spawn_director::function_9893a28f1d682a28( spawngroupid, zombieaitype, real_spawn_position, anglesspawn, 1, 0, 1, self.team );
}

// Namespace portal_summon
// Params 4, eflags: 0x4
// Checksum 0xb130d119, Offset: 0x9b8
// Size: 0x37b
function private function_24bb5c2aa0708efb( groupid, userdata, zombie, agentindex )
{
    bundle = userdata.bundle;
    awarenessrange = bundle.var_d99b4f3a0b79655e ?? 1000;
    var_e5a73c1793d4b10b = bundle.var_b58a5e05269a4df7 ?? 1;
    extralifetime = userdata.owner utility::callsharedfunc( "super_portal_summon", #"hash_d3766d9fcce3bda0" ) ?? 0;
    var_eeb3130c678a2e86 = ( userdata.owner.var_f6ce3f6c3c2ead86.bundle.var_88b5ad64969f625d ?? bundle.portal_summon_duration ) + extralifetime;
    spawnanimation = bundle.var_acee750829181180 ?? "spawn_fast";
    var_8670cc80f42dba7 = userdata.owner.var_f6ce3f6c3c2ead86.bundle.var_2c3f6969e027207e ?? bundle.var_461abc728345e970;
    var_790754450bafbc7a = bundle.var_447c56a3560f3583;
    var_c74b2d3be28f1c68 = bundle.var_afbdf3527c2f0767;
    spawnvfxduration = bundle.var_6b2af5a9ea869503;
    
    if ( var_8670cc80f42dba7 )
    {
        zombie set_zombie_difficulty( var_8670cc80f42dba7 );
    }
    
    zombie zombie_utils::function_c2cee1190760989c( userdata.owner, { #state:var_c74b2d3be28f1c68, #part:var_790754450bafbc7a } );
    zombie function_fa32376aaa88a7a2( zombie.origin, awarenessrange );
    zombie disableaimassist();
    zombie.owner = userdata.owner;
    zombie.superref = "super_portal_summon";
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie.var_914a5379b8e8fd3 = 1;
    zombie.glgrenadeparent = level.portal_summon_weapon_obj;
    userdata.owner.zombiescreated[ userdata.owner.zombiescreated.size ] = zombie;
    
    if ( bundle.var_67863b607738daa3 )
    {
        zombie callback::add( #"hash_2f7a081cd065e655", &function_5e3e0df18122335a );
    }
    
    if ( spawnvfxduration )
    {
        zombie thread launch_spawn_vfx( spawnvfxduration );
    }
    
    userdata.owner play_portal_sounds( bundle );
    portal = undefined;
    
    if ( var_e5a73c1793d4b10b )
    {
        portal = function_e0651e762f4fb1c4( bundle, zombie.origin, zombie.angles );
        zombie thread apply_damage_reduction( bundle );
        zombie function_664eafc84079325( zombie.origin, zombie.angles, spawnanimation );
    }
    
    if ( isalive( zombie ) )
    {
        zombie thread auto_destroy( var_eeb3130c678a2e86 );
        
        if ( !userdata.owner.var_95443dd25a6d1b11 )
        {
            var_1df01cf4a4ef56c = userdata.owner utility::callsharedfunc( "super_portal_summon", #"hash_84ff6629a1de214f" );
            
            if ( var_1df01cf4a4ef56c )
            {
                userdata.owner thread function_e971fff44e858af( var_1df01cf4a4ef56c );
            }
        }
    }
    
    if ( portal )
    {
        portal freescriptable();
    }
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x53d1c693, Offset: 0xd3b
// Size: 0xc3
function private function_e971fff44e858af( var_1df01cf4a4ef56c )
{
    self endon( #"death", #"disconnect" );
    self.var_95443dd25a6d1b11 = 1;
    interval = var_1df01cf4a4ef56c.var_92d24e2de2ca0e17;
    radius = var_1df01cf4a4ef56c.var_6174db9417f986c0;
    chance = var_1df01cf4a4ef56c.var_7989887dcf5d9dda;
    maxtier = var_1df01cf4a4ef56c.var_6aec29c1e92657e8;
    duration = var_1df01cf4a4ef56c.var_e72bba8c3cbce14e;
    
    while ( self.zombiescreated.size > 0 )
    {
        function_c744114206616112( duration, radius, chance, maxtier );
        wait interval;
    }
    
    self.var_95443dd25a6d1b11 = undefined;
}

// Namespace portal_summon
// Params 4, eflags: 0x4
// Checksum 0xa1640d2a, Offset: 0xe06
// Size: 0xeb
function private function_c744114206616112( duration, radius, chance, maxtier )
{
    validenemies = function_f332faff97e9cbed( self.zombiescreated, radius, maxtier );
    
    foreach ( enemy in validenemies )
    {
        if ( !utility::percent_chance( chance ) )
        {
            continue;
        }
        
        enemy zombie_utils::function_c2cee1190760989c( self );
        enemy.var_a13bed1ac47e1b2c = 1;
        enemy.var_914a5379b8e8fd3 = 1;
        enemy thread auto_destroy( duration );
    }
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0x37e5fe28, Offset: 0xef9
// Size: 0x1aa
function private function_f332faff97e9cbed( zombies, radius, maxtier )
{
    validenemies = [];
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        nearbyenemies = getaiarrayinradius( zombie.origin, radius );
        
        foreach ( enemy in nearbyenemies )
        {
            if ( enemy zombie_utils::function_bf1464d09f4e4b40() )
            {
                continue;
            }
            
            if ( enemy.team == self.team )
            {
                continue;
            }
            
            aitier = enemy ai_utility::get_power_tier();
            
            if ( !aitier || aitier > maxtier )
            {
                continue;
            }
            
            if ( enemy.subclass == "dawg" || enemy.unittype == "juggernaut" )
            {
                continue;
            }
            
            validenemies = arraycombineunique( validenemies, [ enemy ] );
        }
    }
    
    return validenemies;
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x6fa58a4e, Offset: 0x10ac
// Size: 0x2e
function private play_portal_sounds( bundle )
{
    self playsoundevent( bundle.var_465f82c8935cd783 );
    self playsoundevent( bundle.var_8f2f18b91b3d7882 );
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x9c6afe24, Offset: 0x10e2
// Size: 0xae
function private function_d70e6f9cbc66828( groupid, userdata )
{
    if ( userdata.owner )
    {
        userdata.owner.var_dbb0c80988138d18 = arrayremove( userdata.owner.var_dbb0c80988138d18, groupid );
        
        if ( userdata.owner.var_dbb0c80988138d18.size == 0 )
        {
            userdata.owner.var_dbb0c80988138d18 = undefined;
            userdata.owner.zombiescreated = undefined;
            userdata.owner.var_95443dd25a6d1b11 = undefined;
        }
    }
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x7374c0a7, Offset: 0x1198
// Size: 0x62
function private apply_damage_reduction( bundle )
{
    self endon( #"death" );
    
    if ( !bundle.var_11c18b4d46a06eda )
    {
        return;
    }
    
    spawnduration = bundle.var_1099e635c036145d;
    zombie_utils::function_dfae6a5bd222c586( &on_zombie_damaged );
    wait spawnduration;
    
    if ( isalive( self ) )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &on_zombie_damaged );
    }
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0xdac3f8ee, Offset: 0x1202
// Size: 0x60
function private set_zombie_difficulty( roundnumber )
{
    if ( utility::issharedfuncdefined( #"region_difficulty_manager", #"hash_92c9697fbfaef62e" ) )
    {
        self.difficulty = utility::callsharedfunc( #"region_difficulty_manager", #"hash_92c9697fbfaef62e", roundnumber );
        zombie_utils::set_zombie_round_difficulty( roundnumber );
        return;
    }
    
    zombie_utils::set_zombie_round_difficulty( roundnumber, 0 );
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x9dafbf97, Offset: 0x126a
// Size: 0x9d
function private launch_spawn_vfx( spawnvfxduration )
{
    effectid = utility::getfx( "portal_summon_zombie_spawn_fx" );
    
    if ( !effectid )
    {
        return;
    }
    
    area = utility::spawn_tag_origin( self.origin, anglestoforward( self.angles ) );
    area show();
    playfxontag( effectid, area, "tag_origin" );
    utility::waittill_any_in_array_or_timeout( [ "death", "disconnect", "cancel_zombie_spawn" ], spawnvfxduration );
    killfxontag( effectid, area, "tag_origin" );
    area delete();
}

// Namespace portal_summon
// Params 1, eflags: 0x4
// Checksum 0x8f83722d, Offset: 0x130f
// Size: 0xa0
function private auto_destroy( time )
{
    self endon( #"death" );
    
    if ( time )
    {
        wait time;
    }
    
    if ( isdefined( self ) && isdefined( self.maxhealth ) )
    {
        if ( isarray( self.owner.zombiescreated ) )
        {
            self.owner.zombiescreated = arrayremove( self.owner.zombiescreated, self );
            self.owner remove_cancel();
        }
        
        self dodamage( self.maxhealth, self.origin );
    }
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0x1648a5d0, Offset: 0x13b7
// Size: 0x8e
function private function_664eafc84079325( position, angles, spawnanimation )
{
    movedelta = utility::function_80505911b6822d3( spawnanimation );
    angledelta = utility::function_f59c00aad3d87ab9( spawnanimation );
    movedelta = rotatevector( movedelta, angles );
    startorigin = position - movedelta;
    startangles = ( angles[ 0 ], angleclamp( angles[ 1 ] - angledelta ), angles[ 2 ] );
    utility::animscriptedagent( spawnanimation, "spawn_end", startorigin, startangles, "spawn_animating" );
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x78685b4b, Offset: 0x144d
// Size: 0x87
function private get_random_spawn_position( bundle, spawncenter )
{
    var_4391a07cbe072351 = bundle.var_973184330d00c4e9 ?? 200;
    deltax = 0;
    deltay = 0;
    
    if ( var_4391a07cbe072351 > 0 )
    {
        deltax = randomfloatrange( var_4391a07cbe072351 * -1, var_4391a07cbe072351 );
        deltay = randomfloatrange( var_4391a07cbe072351 * -1, var_4391a07cbe072351 );
    }
    
    spawnposition = spawncenter + ( deltax, deltay, 0 );
    
    if ( function_32cd862d1ed4416b( bundle, spawnposition ) )
    {
        return spawnposition;
    }
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x18e1ea47, Offset: 0x14dd
// Size: 0x3c
function private get_spawn_position( bundle, spawncenter )
{
    if ( bundle.var_6f668c0bb427ec42 )
    {
        return get_random_spawn_position( bundle, spawncenter );
    }
    
    if ( function_32cd862d1ed4416b( bundle, spawncenter ) )
    {
        return spawncenter;
    }
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x5bbf5d2f, Offset: 0x1522
// Size: 0x7c
function private function_32cd862d1ed4416b( bundle, spawncenter )
{
    var_4e6119446c7f14c2 = bundle.var_1686bc86814b6d1e;
    
    if ( var_4e6119446c7f14c2 )
    {
        var_251806f1bc3aa4ae = bundle.var_4fa55cd7c29e4490 ?? 0;
        var_54894f0539919c5b = bundle.var_64136d0c0bba156c ?? 0;
        var_80e672a7bf105694 = function_7e87bf40cee407a7( spawncenter, var_251806f1bc3aa4ae, var_54894f0539919c5b );
        return var_80e672a7bf105694;
    }
    
    return 1;
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0x2dec32eb, Offset: 0x15a7
// Size: 0xdd, Type: bool
function private function_b4422fc3210f5ae2( spawncenter, navmeshspawnpoint, bundle )
{
    var_29706ef49cab1bea = bundle.var_2ac9c4c6e5fb3d53;
    var_ba3561b353d4618 = var_29706ef49cab1bea * var_29706ef49cab1bea;
    var_df4467df4c95edfe = distancesquared( navmeshspawnpoint, spawncenter );
    
    /#
        if ( getdvarint( @"hash_bd8814c36847673c", 0 ) == 1 )
        {
            debugstar( navmeshspawnpoint, ( 1, 0, 0 ), 100, "<dev string:x24>" );
            debugstar( spawncenter, ( 1, 0, 1 ), 100, "<dev string:x3b>" );
            sphere( navmeshspawnpoint, var_29706ef49cab1bea / 2, ( 0, 1, 1 ), 0, 100 );
            sphere( spawncenter, var_29706ef49cab1bea / 2, ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    return var_df4467df4c95edfe < var_ba3561b353d4618;
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0xf354b97e, Offset: 0x168d
// Size: 0x142
function private function_8bd12eb7447abae4( spawncenter, navmeshspawnpoint, bundle )
{
    if ( !bundle.var_c2f0712c03759a55 )
    {
        return 1;
    }
    
    maxheight = max( spawncenter[ 2 ], navmeshspawnpoint[ 2 ] );
    point1 = ( spawncenter[ 0 ], spawncenter[ 1 ], maxheight );
    point2 = ( navmeshspawnpoint[ 0 ], navmeshspawnpoint[ 1 ], maxheight );
    var_46d2f276b846a703 = trace::ray_trace_get_all_results( point1, point2, undefined, undefined, 0, 1, self.team );
    var_979ef19971df0b06 = 1;
    
    if ( var_46d2f276b846a703[ 0 ] )
    {
        var_979ef19971df0b06 = var_46d2f276b846a703[ 0 ][ "fraction" ] == 1;
        
        /#
            if ( getdvarint( @"hash_cbbcaf879864b9ca", 0 ) == 1 )
            {
                debugstar( point1, ( 1, 1, 1 ), 100, "<dev string:x48>" );
                debugstar( point2, ( 1, 1, 1 ), 100, "<dev string:x51>" );
                line( point1, point2, ( 1, 1, 1 ), 1, 0, 100 );
                
                if ( !var_979ef19971df0b06 )
                {
                    debugstar( var_46d2f276b846a703[ 0 ][ "<dev string:x5c>" ], ( 1, 0, 0 ), 100, "<dev string:x65>" );
                }
            }
        #/
    }
    
    return var_979ef19971df0b06;
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0x9c0678b1, Offset: 0x17d8
// Size: 0x55
function private function_e0651e762f4fb1c4( bundle, position, angles )
{
    scriptablename = bundle.var_525d007993550a7c ?? %"aether_elevator_portal";
    portal = spawnscriptable( scriptablename, position, angles );
    return portal;
}

// Namespace portal_summon
// Params 3, eflags: 0x4
// Checksum 0x465a55a8, Offset: 0x1836
// Size: 0x143, Type: bool
function private function_7e87bf40cee407a7( point, distray, maxdistancecheck )
{
    start = point + ( 0, 0, distray );
    end = point;
    collisionpoint = trace::ray_trace( start, end, undefined, trace::create_default_contents( 1 ) )[ "position" ];
    distance = distancesquared( point, collisionpoint );
    maxdistance = maxdistancecheck * maxdistancecheck;
    
    /#
        if ( getdvarint( @"hash_b5c5488d6dfd4ec1", 0 ) == 1 )
        {
            debugstar( start, ( 1, 1, 1 ), 100, "<dev string:x6f>" );
            line( start, end, ( 0, 1, 0 ), 1, 0, 100 );
            debugstar( end, ( 1, 1, 1 ), 100, "<dev string:x79>" );
            debugstar( collisionpoint, ( 1, 1, 1 ), 100, "<dev string:x81>" + sqrt( distance ) );
            sphere( point, maxdistancecheck / 2, ( 0, 1, 1 ), 0, 100 );
            sphere( collisionpoint, maxdistancecheck / 2, ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    return distance < maxdistance;
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0xb2d7bafa, Offset: 0x1982
// Size: 0x114
function private get_ground_point( point, distray )
{
    if ( !distray )
    {
        return point;
    }
    
    start = point + ( 0, 0, distray );
    end = point - ( 0, 0, distray );
    var_9a78988ffd5cd6ef = trace::create_contents( 0, 1, 0, 0, 1 );
    collisionpoint = trace::ray_trace( start, end, undefined, var_9a78988ffd5cd6ef )[ "position" ];
    
    /#
        if ( getdvarint( @"hash_1e07662cdb421d62", 0 ) == 1 )
        {
            debugstar( start, ( 1, 1, 1 ), 100, "<dev string:x6f>" );
            line( start, end, ( 0, 1, 0 ), 1, 0, 100 );
            debugstar( end, ( 1, 1, 1 ), 100, "<dev string:x79>" );
            debugstar( collisionpoint, ( 1, 1, 1 ), 100, "<dev string:x9f>" );
            debugstar( point, ( 1, 1, 1 ), 100, "<dev string:xbb>" );
        }
    #/
    
    return collisionpoint;
}

// Namespace portal_summon
// Params 2
// Checksum 0xac556b6a, Offset: 0x1a9f
// Size: 0x12a
function function_dc62f3350a2eaec0( spawncenter, bundle )
{
    /#
        if ( getdvarint( @"hash_2751e53270dfe652", 0 ) == 1 )
        {
            debugstar( spawncenter, ( 1, 1, 1 ), 100, "<dev string:xc9>" );
        }
    #/
    
    result = function_37a49166d3026362( spawncenter, bundle );
    
    if ( result )
    {
        return result;
    }
    
    angle = 0;
    
    while ( angle < 360 )
    {
        radiusspawn = bundle.var_f05cc516a7779d0e;
        assert( radiusspawn, "<dev string:xd0>" );
        deltax = radiusspawn * cos( angle );
        deltay = radiusspawn * sin( angle );
        var_d6d18ea69df25053 = spawncenter + ( deltax, deltay, 0 );
        
        /#
            if ( getdvarint( @"hash_2751e53270dfe652", 0 ) == 1 )
            {
                debugstar( var_d6d18ea69df25053, ( 1, 1, 1 ), 100, "<dev string:x101>" + angle );
            }
        #/
        
        angle += 90;
        result = function_37a49166d3026362( var_d6d18ea69df25053, bundle );
        
        if ( !result )
        {
            continue;
        }
        
        return result;
    }
}

// Namespace portal_summon
// Params 2, eflags: 0x4
// Checksum 0x37013fcf, Offset: 0x1bd2
// Size: 0x87
function private function_37a49166d3026362( point, bundle )
{
    navmeshspawnpoint = getclosestpointonnavmesh( point );
    var_b379a0f4eada74ee = function_b4422fc3210f5ae2( point, navmeshspawnpoint, bundle );
    
    if ( !var_b379a0f4eada74ee )
    {
        return;
    }
    
    var_f990f8518852b33a = function_8bd12eb7447abae4( point, navmeshspawnpoint, bundle );
    
    if ( !var_f990f8518852b33a )
    {
        return;
    }
    
    var_634bb9d956974ef0 = bundle.var_a1cdd86873ffe97c;
    groundspawnpoint = get_ground_point( navmeshspawnpoint, var_634bb9d956974ef0 );
    return groundspawnpoint;
}

// Namespace portal_summon
// Params 0, eflags: 0x4
// Checksum 0xb787e22b, Offset: 0x1c62
// Size: 0xa5
function private debug_devgui()
{
    /#
        if ( getdvarint( @"hash_876a6ec6dd2f0e38", 0 ) == 1 )
        {
            devgui::init_devgui();
            devgui::function_9082edeb5db93280( "<dev string:x103>" );
            devgui::function_eaac4ba4b3caf621( "<dev string:x114>", @"hash_2751e53270dfe652", 0 );
            devgui::function_eaac4ba4b3caf621( "<dev string:x130>", @"hash_bd8814c36847673c", 1 );
            devgui::function_eaac4ba4b3caf621( "<dev string:x14d>", @"hash_cbbcaf879864b9ca", 2 );
            devgui::function_eaac4ba4b3caf621( "<dev string:x177>", @"hash_1e07662cdb421d62", 3 );
            devgui::function_eaac4ba4b3caf621( "<dev string:x18e>", @"hash_b5c5488d6dfd4ec1", 4 );
            devgui::function_77df7fe7dd273e10();
        }
    #/
}

