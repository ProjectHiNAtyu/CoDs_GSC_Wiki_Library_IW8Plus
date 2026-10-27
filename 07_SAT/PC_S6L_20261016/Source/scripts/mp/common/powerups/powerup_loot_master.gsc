// scripts\mp\common\powerups\powerup_loot_master.gsc  (hash_07a53ddb7df5cd06.gscc) (size: 3378 Bytes / 0xd32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49e7dab3 (1239931571)
// size ...... 3378 (0xd32)
// includes .. 6   (offset: 0xc5a)
// strings ... 13  (offset: 0xc8a)
// dev strs .. 0   (offset: 0xd32)
// exports ... 8   (offset: 0x7e2)
// cseg ...... 0x15a + 0x688 (0x7e2)
// imports ... 28  (offset: 0x922)
// animtree1 . 0   (offset: 0xd32)
// animtree2 . 0   (offset: 0xd32)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace powerup_loot_master;

// Namespace powerup_loot_master
// Params 0, eflags: 0x1
// Checksum 0xec8be21e, Offset: 0x178
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_loot_master", 0 ) )
    {
        return;
    }
    
    init();
}

// Namespace powerup_loot_master
// Params 0
// Checksum 0xb20b7b63, Offset: 0x19b
// Size: 0x55
function init()
{
    powerups::register_powerup( "loot_master", &function_6638234b060fb05d );
    level callback::add( "lootcache_looted", &function_e6f3970223d386dc );
    level.var_2db504e5beb73396 = getdvarint( @"hash_68e9b8d89e502dcf", 100 );
    level.var_81cb0fc51674f5ba = getdvarint( @"hash_2d46605c811f73eb", 30 );
}

// Namespace powerup_loot_master
// Params 2
// Checksum 0xf61fcb05, Offset: 0x1f8
// Size: 0x99
function function_6638234b060fb05d( str_powerup, ent_powerup )
{
    a_squadplayers = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_squadplayers )
    {
        player thread function_96c1303278cb0d77();
    }
}

// Namespace powerup_loot_master
// Params 1
// Checksum 0x88029c52, Offset: 0x299
// Size: 0x81
function function_96c1303278cb0d77( n_lifetime )
{
    self notify( #"powerup_loot_master" );
    self endon( #"powerup_loot_master" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.powerup_loot_master_active = 1;
    
    if ( !isdefined( n_lifetime ) )
    {
        n_lifetime = powerups::function_f379817a62e3850c( "loot_master" );
    }
    
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "loot_master", n_lifetime );
    utility::waittill_any_timeout( n_lifetime, "end_powerup_loot_master", "death" );
    function_fb826031718b1621();
}

// Namespace powerup_loot_master
// Params 0
// Checksum 0x6711903, Offset: 0x322
// Size: 0x18
function function_fb826031718b1621()
{
    self.powerup_loot_master_active = undefined;
    self notify( #"end_powerup_loot_master" );
}

// Namespace powerup_loot_master
// Params 1
// Checksum 0x19e16f9c, Offset: 0x342
// Size: 0x32a
function function_e6f3970223d386dc( params )
{
    if ( params.player.var_29a41377838fcaef )
    {
        return;
    }
    
    if ( params.cacheinstance.type != "br_loot_cache" && params.cacheinstance.type != "br_loot_cache_lege" && params.cacheinstance.type != "br_reusable_loot_cache" )
    {
        return;
    }
    
    if ( params.player.powerup_loot_master_active )
    {
        roll = randomint( 100 );
        thread function_5c5a1700f8da6ac( params.player, "powerup_sat_loot_master_cache_fx", params.cacheinstance, 5 );
        
        if ( roll < level.var_2db504e5beb73396 )
        {
            wait 0.5;
            s_spawn = spawnstruct();
            s_spawn.origin = params.cacheinstance.origin + anglestoleft( params.cacheinstance.angles + ( 0, 20, 0 ) ) * 30;
            s_spawn.angles = ( 0, randomint( 360 ), 0 );
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_loot_cache_loot_master" );
            
            if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                spawnoptions = common_item::function_bc5ff2958b71a708( s_spawn.origin, s_spawn.angles );
                spawnoptions.var_8d4f327170228364 = 0;
                spawnoptions.var_789c456dda9c8572 = params.cacheinstance.origin + ( 0, 0, 40 );
                common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
            }
        }
        
        if ( roll < level.var_81cb0fc51674f5ba )
        {
            wait 0.5;
            s_spawn = spawnstruct();
            s_spawn.origin = params.cacheinstance.origin + anglestoleft( params.cacheinstance.angles + ( 0, -20, 0 ) ) * 30;
            s_spawn.angles = ( 0, randomint( 360 ), 0 );
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_loot_cache_lege_loot_master" );
            
            if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                spawnoptions = common_item::function_bc5ff2958b71a708( s_spawn.origin, s_spawn.angles );
                spawnoptions.var_8d4f327170228364 = 0;
                spawnoptions.var_789c456dda9c8572 = params.cacheinstance.origin + ( 0, 0, 40 );
                common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
            }
        }
    }
}

// Namespace powerup_loot_master
// Params 4
// Checksum 0xd7ff3554, Offset: 0x674
// Size: 0x16e
function function_5c5a1700f8da6ac( owner, fx_scriptable, cache, duration )
{
    level endon( #"game_ended" );
    payload = [ #"teamselect", owner getentitynumber() ];
    scriptable = spawnscriptable( fx_scriptable, cache.origin, cache.angles, undefined, payload );
    scriptable setscriptablepartstate( "vfx", "spawn" );
    
    if ( !isdefined( level.brgametype ) || !level.brgametype.var_f9db3bc1f9b3dac4 )
    {
        scriptable setscriptablepartstate( "sfx", "spawn" );
    }
    
    if ( isdefined( cache.var_37bf28e977662d28 ) )
    {
        localorigin = rotatevectorinverted( scriptable.origin - cache.var_37bf28e977662d28.origin, cache.var_37bf28e977662d28.angles );
        localangles = combineangles( invertangles( cache.var_37bf28e977662d28.angles ), cache.angles );
        scriptable utility::scriptable_setparententity( cache.var_37bf28e977662d28, localorigin, localangles );
    }
    
    wait duration;
    scriptable freescriptable();
}

