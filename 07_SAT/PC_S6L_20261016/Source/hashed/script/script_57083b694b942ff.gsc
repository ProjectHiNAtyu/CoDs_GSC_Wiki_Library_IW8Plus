// script_57083b694b942ff  (hash_057083b694b942ff.gscc) (size: 1765 Bytes / 0x6e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x67b30211 (1739784721)
// size ...... 1765 (0x6e5)
// includes .. 5   (offset: 0x651)
// strings ... 7   (offset: 0x679)
// dev strs .. 0   (offset: 0x6e5)
// exports ... 7   (offset: 0x351)
// cseg ...... 0xde + 0x273 (0x351)
// imports ... 17  (offset: 0x469)
// animtree1 . 0   (offset: 0x6e5)
// animtree2 . 0   (offset: 0x6e5)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_rainburps;

// Namespace zm_bgb_rainburps
// Params 0, eflags: 0x5
// Checksum 0xe079cfb3, Offset: 0xfc
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "rainburps", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_rainburps
// Params 0
// Checksum 0x6a1a388a, Offset: 0x121
// Size: 0x4a
function __init__()
{
    namespace_6616340f3419ea2d::register( "rainburps", "time", 180, &enable, &disable, undefined );
    callback::add( "killed_body_cloned", &on_killed_body_cloned );
    level._effect[ "fx_bgb_rainburps" ] = loadfxasset( "vfx_t10_zm_gobblegums_rainburps" );
}

// Namespace zm_bgb_rainburps
// Params 0
// Checksum 0xd5c85c21, Offset: 0x173
// Size: 0x14
function enable()
{
    level callback::add( "pre_killed_body_cloned", &on_ai_killed );
}

// Namespace zm_bgb_rainburps
// Params 0
// Checksum 0xfcb7b795, Offset: 0x18f
// Size: 0x14
function disable()
{
    level callback::remove( "pre_killed_body_cloned", &on_ai_killed );
}

// Namespace zm_bgb_rainburps
// Params 1
// Checksum 0x3e68f2cb, Offset: 0x1ab
// Size: 0xf3
function on_killed_body_cloned( params )
{
    if ( !utility::hastag( self.model, "j_head" ) )
    {
        return;
    }
    
    var_520e2d04de1e4074 = 0;
    
    foreach ( player in level.players )
    {
        if ( player namespace_6616340f3419ea2d::is_enabled( "rainburps" ) )
        {
            var_520e2d04de1e4074 = 1;
        }
    }
    
    if ( var_520e2d04de1e4074 )
    {
        corpse = zombie_utils::function_4e99fb1239980783( params );
        
        if ( isdefined( corpse ) )
        {
            self.bgb_rainburps = 1;
            playfxontag( utility::getfx( "fx_bgb_rainburps" ), corpse, "j_head" );
        }
    }
}

// Namespace zm_bgb_rainburps
// Params 1
// Checksum 0x79b25346, Offset: 0x2a6
// Size: 0xab
function on_ai_killed( params )
{
    var_520e2d04de1e4074 = 0;
    
    foreach ( player in level.players )
    {
        if ( player namespace_6616340f3419ea2d::is_enabled( "rainburps" ) )
        {
            var_520e2d04de1e4074 = 1;
        }
    }
    
    if ( var_520e2d04de1e4074 )
    {
        self.var_b387b5c15ccd406 = 1;
    }
}

