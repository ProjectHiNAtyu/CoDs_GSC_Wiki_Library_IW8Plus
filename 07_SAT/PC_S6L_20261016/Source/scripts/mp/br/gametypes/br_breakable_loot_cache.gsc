// scripts\mp\br\gametypes\br_breakable_loot_cache.gsc  (hash_29a1d0ebc6f9e813.gscc) (size: 4592 Bytes / 0x11f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34a0294 (55181972)
// size ...... 4592 (0x11f0)
// includes .. 11  (offset: 0x1110)
// strings ... 10  (offset: 0x1168)
// dev strs .. 0   (offset: 0x11f0)
// exports ... 15  (offset: 0x9f0)
// cseg ...... 0x10a + 0x8e6 (0x9f0)
// imports ... 42  (offset: 0xc48)
// animtree1 . 0   (offset: 0x11f0)
// animtree2 . 0   (offset: 0x11f0)
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\common\utility\points;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\structspawnconfig;

#namespace br_breakable_loot_cache;

// Namespace br_breakable_loot_cache
// Params 0, eflags: 0x1
// Checksum 0x9bbbf9de, Offset: 0x128
// Size: 0x7a
function autoexec init()
{
    if ( !getdvarint( @"scr_br_breakable_cache_enabled", 1 ) )
    {
        return;
    }
    
    if ( getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        utility::flag_wait( "ssc_initialized" );
        structspawnconfig::function_7418a260adaec05( "breakable_cache", &function_139d58d75da4222 );
        structspawnconfig::function_8c0a09968efe9138( "breakable_cache", &function_8104420d7fe7348b );
        structspawnconfig::function_36050499b5f48983( "breakable_cache", &function_2581b0af6a936ab1 );
        br_circle::registercirclecallbacks( 19, &dangercircletick, &dangermulticircletick );
    }
}

// Namespace br_breakable_loot_cache
// Params 1
// Checksum 0x156e6f24, Offset: 0x1aa
// Size: 0x27
function function_139d58d75da4222( structname )
{
    allspawnlocations = utility::getstructarray( structname, "targetname" );
    return allspawnlocations;
}

// Namespace br_breakable_loot_cache
// Params 2
// Checksum 0x5f9d01f5, Offset: 0x1da
// Size: 0x44
function function_8104420d7fe7348b( structname, cachestruct )
{
    if ( !isdefined( level.var_166e2370c66f5fb6 ) )
    {
        level.var_166e2370c66f5fb6 = [];
    }
    
    level.var_166e2370c66f5fb6[ level.var_166e2370c66f5fb6.size ] = cachestruct;
    return cachestruct;
}

// Namespace br_breakable_loot_cache
// Params 1
// Checksum 0x36c751a9, Offset: 0x227
// Size: 0xef
function function_2581b0af6a936ab1( structname )
{
    level endon( #"game_ended" );
    utility::flag_wait( "br_prematchEnded" );
    waitframe();
    
    if ( !isdefined( level.var_166e2370c66f5fb6 ) || level.var_166e2370c66f5fb6.size == 0 )
    {
        return;
    }
    
    foreach ( cachestruct in level.var_166e2370c66f5fb6 )
    {
        function_3bc34aa2066b18e1( cachestruct );
    }
    
    scriptable::scriptable_adddamagedcallback( &function_71d0fffa1fa44929 );
    level.var_da7a5ba26e49d7de = throttle::throttle_initialize_gate( "br_breakable_cache_restock", 2, level.framedurationseconds );
    thread function_41a5e1ee9aa11c43();
}

// Namespace br_breakable_loot_cache
// Params 0
// Checksum 0xfec50ab, Offset: 0x31e
// Size: 0xaf
function function_41a5e1ee9aa11c43()
{
    level waittill( #"br_ending_start" );
    
    if ( !isdefined( level.var_1596b10e3ae45c5c ) || level.var_1596b10e3ae45c5c.size == 0 )
    {
        return;
    }
    
    foreach ( cache in level.var_1596b10e3ae45c5c )
    {
        if ( isdefined( cache ) )
        {
            cache pickups::deletescriptableinstance( 1 );
        }
    }
}

// Namespace br_breakable_loot_cache
// Params 1
// Checksum 0x32072cc8, Offset: 0x3d5
// Size: 0x61
function function_3bc34aa2066b18e1( cachestruct )
{
    if ( !isdefined( level.var_1596b10e3ae45c5c ) )
    {
        level.var_1596b10e3ae45c5c = [];
    }
    
    cache = spawncachesinglebase( cachestruct.origin, cachestruct.angles );
    level.var_1596b10e3ae45c5c[ level.var_1596b10e3ae45c5c.size ] = cache;
}

// Namespace br_breakable_loot_cache
// Params 2
// Checksum 0x24c63f2f, Offset: 0x43e
// Size: 0x40
function spawncachesinglebase( origin, angles )
{
    cache = spawnscriptable( "br_breakable_loot_cache", origin, angles );
    cache setscriptablepartstate( "base", "visible" );
    return cache;
}

// Namespace br_breakable_loot_cache
// Params 0
// Checksum 0x12896757, Offset: 0x487
// Size: 0xf6
function function_9175b4f5270c16b9()
{
    self notify( #"hash_cf9586accaa1d8b5" );
    self endon( #"hash_cf9586accaa1d8b5" );
    
    if ( !isdefined( level.var_166e2370c66f5fb6 ) )
    {
        return;
    }
    
    activecaches = level.var_1596b10e3ae45c5c;
    
    foreach ( cachestruct in level.var_166e2370c66f5fb6 )
    {
        throttle::throttle_wait_gate( level.var_da7a5ba26e49d7de );
        
        if ( activecaches.size > 0 )
        {
            nearbycaches = function_c44b31a67523b336( activecaches, cachestruct.origin, 40, 0 );
            
            if ( nearbycaches.size > 0 )
            {
                continue;
            }
        }
        
        function_3bc34aa2066b18e1( cachestruct );
    }
}

// Namespace br_breakable_loot_cache
// Params 11
// Checksum 0x9b0c1feb, Offset: 0x585
// Size: 0xa8
function function_71d0fffa1fa44929( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    cache = instance;
    
    if ( !isdefined( cache ) || cache.type != "br_breakable_loot_cache" )
    {
        return;
    }
    
    level thread function_5a73c31f2dd6ccdc( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
}

// Namespace br_breakable_loot_cache
// Params 11
// Checksum 0x113307c, Offset: 0x635
// Size: 0x165
function function_5a73c31f2dd6ccdc( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    cache = instance;
    waittillframeend();
    
    if ( eattacker vehicle::is_vehicle() )
    {
        eattacker = eattacker.owner;
    }
    
    if ( !isdefined( eattacker ) )
    {
        return;
    }
    
    if ( !isdefined( cache ) )
    {
        level.var_1596b10e3ae45c5c = function_5713d46873b29625( level.var_1596b10e3ae45c5c );
        return;
    }
    
    if ( common_item::items_isenabled() )
    {
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_breakable_cache" );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            cachespawnlist = var_f67995529827f79.spawnlistname;
            spawncount = var_f67995529827f79.spawncount;
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( instance.origin, instance.angles );
            common_item::function_38cde6a6acb68ea6( cachespawnlist, spawncount, spawnoptions );
            eattacker thread points::doscoreevent( #"br_cacheOpen" );
        }
    }
    
    cache deletescriptable();
}

// Namespace br_breakable_loot_cache
// Params 0, eflags: 0x4
// Checksum 0x4765bbab, Offset: 0x7a2
// Size: 0x29
function private scriptablehide()
{
    cache = self;
    cache setscriptablepartstate( "base", "dead" );
    cache deletescriptable();
}

// Namespace br_breakable_loot_cache
// Params 0, eflags: 0x4
// Checksum 0x765b8442, Offset: 0x7d3
// Size: 0x38
function private deletescriptable()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level.var_1596b10e3ae45c5c = arrayremove( level.var_1596b10e3ae45c5c, self );
    waitframe();
    self freescriptable();
}

// Namespace br_breakable_loot_cache
// Params 3
// Checksum 0x1637eb39, Offset: 0x813
// Size: 0xd6
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !level.var_1596b10e3ae45c5c || level.var_1596b10e3ae45c5c.size == 0 )
    {
        br_circle::function_e441e2dbc58966e8( 19 );
        return;
    }
    
    var_38121c1776b71ce3 = function_c44b31a67523b336( level.var_1596b10e3ae45c5c, dangercircleorigin, dangercircleradius + thresholdradius, 1 );
    
    foreach ( cache in var_38121c1776b71ce3 )
    {
        cache thread scriptablehide();
    }
}

// Namespace br_breakable_loot_cache
// Params 0, eflags: 0x4
// Checksum 0x897da17f, Offset: 0x8f1
// Size: 0xff
function private dangermulticircletick()
{
    if ( br_circle_util::function_7c3401c47d505872() == 1 )
    {
        dangercircleorigin = br_circle::getdangercircleorigin();
        dangercircleradius = br_circle::getdangercircleradius();
        dangercircletick( dangercircleorigin, dangercircleradius, level.var_ea96217a33eb6457 );
        return;
    }
    
    if ( !level.var_1596b10e3ae45c5c || level.var_1596b10e3ae45c5c.size == 0 )
    {
        br_circle::function_e441e2dbc58966e8( 19 );
        return;
    }
    
    foreach ( cache in level.var_1596b10e3ae45c5c )
    {
        if ( br_circle_util::ispointinmulticircledanger( cache.origin, level.var_ea96217a33eb6457 ) )
        {
            cache thread scriptablehide();
        }
    }
}

