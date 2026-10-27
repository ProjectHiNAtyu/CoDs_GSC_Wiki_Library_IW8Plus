// script_a8268e56860874f  (hash_0a8268e56860874f.gscc) (size: 4295 Bytes / 0x10c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fe995be (535401918)
// size ...... 4295 (0x10c7)
// includes .. 5   (offset: 0xfd7)
// strings ... 12  (offset: 0xfff)
// dev strs .. 0   (offset: 0x10c7)
// exports ... 10  (offset: 0xa17)
// cseg ...... 0x11f + 0x8f8 (0xa17)
// imports ... 35  (offset: 0xba7)
// animtree1 . 0   (offset: 0x10c7)
// animtree2 . 0   (offset: 0x10c7)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\zm\tedd_tasks;

#namespace namespace_e9b9b9f95177a5c7;

// Namespace namespace_e9b9b9f95177a5c7
// Params 0, eflags: 0x5
// Checksum 0xd166b80d, Offset: 0x13d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"interactable_chests", undefined, &init_chest, undefined );
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 0
// Checksum 0x1c93091d, Offset: 0x15e
// Size: 0x2
function init_chest()
{
    
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 4
// Checksum 0x4157f2b, Offset: 0x168
// Size: 0x31e
function function_9275e2f3d8ac4142( chestitem, hint_data, reward_str, cleanup_call )
{
    if ( getdvar( @"hash_1d0bc0b2bba0332d", "" ) != "" )
    {
        self.str_chest_scriptable = getdvar( @"hash_1d0bc0b2bba0332d" );
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    objicon = "ui_icon_zm_trials_icon_backer_blue_with_rewards_chest";
    
    if ( isdefined( s_bundle.rewardobjectiveicon ) )
    {
        objicon = s_bundle.rewardobjectiveicon;
    }
    
    self.caches = [];
    self.var_8572c15d1a1510fb = 0;
    
    if ( !level callback::exists( #"player_spawned", &function_2f56f98f7a8bd801, self ) )
    {
        level callback::add( #"player_spawned", &function_2f56f98f7a8bd801, self );
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            payload = [ #"teamselect", player getentitynumber() ];
            cache = common_cache::spawncache( chestitem, self.origin, self.angles, undefined, payload );
            cache.var_5a4d5180ea13e4ed = 1;
            common_cache::function_a136b84fc5c0dfab( cache, reward_str, 9, 1 );
            level callback::add( "chest_hide_icons", &chest_hide_icons, cache );
            level callback::add( "chest_show_icons", &chest_show_icons, cache );
            self.caches[ self.caches.size ] = cache;
            cache enablescriptableplayeruse( player );
            
            foreach ( otherplayer in level.players )
            {
                if ( otherplayer != player )
                {
                    cache disablescriptableplayeruse( otherplayer );
                }
            }
            
            self.var_8572c15d1a1510fb += 1;
            cache utility::function_7c10ea82c1e305b8( "additional", "warp" );
            cache utility::function_7c10ea82c1e305b8( "objective", "show" );
            
            if ( !player callback::exists( "lootcache_looted", &opened_cache ) )
            {
                player callback::add( "lootcache_looted", &opened_cache );
            }
            
            cache callback::add( #"on_cache_closed", &function_182a5bc598b48cdc, cleanup_call );
            cache.chest = self;
        }
    }
    
    thread watch_cleanup( cleanup_call );
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 1
// Checksum 0xdd738be5, Offset: 0x48e
// Size: 0x8d
function opened_cache( sparams )
{
    if ( isplayer( self ) && isdefined( sparams.cacheinstance.origin ) && !sparams.cacheinstance.openedbefore )
    {
        level thread utility::callsharedfunc( #"zombie", #"hash_26befc250486510c", sparams.cacheinstance.origin, sparams.cacheinstance.angles, self );
    }
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 2
// Checksum 0x95ef49e5, Offset: 0x523
// Size: 0xd3
function function_2f56f98f7a8bd801( params, chest )
{
    if ( isdefined( params ) && isplayer( self ) )
    {
        foreach ( cache in chest.caches )
        {
            cache utility::function_7c10ea82c1e305b8( "objective", "hide" );
            cache disablescriptableplayeruse( self );
            
            if ( !cache.isemptied )
            {
                cache utility::function_7c10ea82c1e305b8( "objective", "show_simple" );
            }
        }
    }
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 2
// Checksum 0x6ff45a92, Offset: 0x5fe
// Size: 0xf0
function function_182a5bc598b48cdc( params, cleanup_call )
{
    if ( params.isempty )
    {
        utility::function_7c10ea82c1e305b8( "objective", "hide" );
        self.isemptied = 1;
        
        if ( !isdefined( self.chest.openers ) )
        {
            self.chest.openers = [];
        }
        
        self.chest.openers = arraycombineunique( self.chest.openers, [ params.opener ] );
        
        if ( self.chest.openers.size >= self.chest.var_8572c15d1a1510fb || self.chest.openers.size >= 4 )
        {
            level notify( cleanup_call );
        }
    }
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 1
// Checksum 0x9c481b0e, Offset: 0x6f6
// Size: 0x2a6
function watch_cleanup( cleanup_call )
{
    self.openers = [];
    level waittill( cleanup_call );
    
    foreach ( cache in self.caches )
    {
        foreach ( player in level.players )
        {
            if ( player common_cache::function_e3795ef6fb5d5a82() )
            {
                if ( isdefined( self ) && isdefined( cache ) && isdefined( player ) )
                {
                    common_cache::closelootablecontainer( cache, player );
                }
            }
            
            player callback::remove( "lootcache_looted", &opened_cache );
        }
        
        if ( isdefined( cache ) )
        {
            cache utility::function_7c10ea82c1e305b8( "objective", "hide" );
            cache utility::function_7c10ea82c1e305b8( "additional", "warp_out" );
        }
    }
    
    level callback::remove( #"player_spawned", &function_2f56f98f7a8bd801 );
    wait 1;
    a_cols = teddtasks::function_3627db2cb6b33dfe( self.script_location );
    
    foreach ( col in a_cols )
    {
        col notsolid();
        col connectpaths();
    }
    
    if ( isdefined( self.var_57874961e9d1c09f ) )
    {
        self.var_57874961e9d1c09f delete();
    }
    
    foreach ( cache in self.caches )
    {
        if ( isdefined( cache ) )
        {
            cache notify( #"death" );
            cache freescriptable();
        }
    }
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 2
// Checksum 0x91a13ec2, Offset: 0x9a4
// Size: 0x2e
function chest_hide_icons( params, cache )
{
    if ( isdefined( cache ) )
    {
        cache utility::function_7c10ea82c1e305b8( "objective", "hide" );
    }
}

// Namespace namespace_e9b9b9f95177a5c7
// Params 2
// Checksum 0xe53a4ea, Offset: 0x9da
// Size: 0x3d
function chest_show_icons( params, cache )
{
    if ( isdefined( cache ) )
    {
        if ( !cache.isemptied )
        {
            cache utility::function_7c10ea82c1e305b8( "objective", "show_simple" );
        }
    }
}

