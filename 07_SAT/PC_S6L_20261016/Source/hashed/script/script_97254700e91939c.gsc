// script_97254700e91939c  (hash_097254700e91939c.gscc) (size: 1588 Bytes / 0x634 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeac74b6d (3938929517)
// size ...... 1588 (0x634)
// includes .. 4   (offset: 0x5c0)
// strings ... 6   (offset: 0x5e0)
// dev strs .. 0   (offset: 0x634)
// exports ... 8   (offset: 0x2b0)
// cseg ...... 0xca + 0x1e6 (0x2b0)
// imports ... 16  (offset: 0x3f0)
// animtree1 . 0   (offset: 0x634)
// animtree2 . 0   (offset: 0x634)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_d5a3ac8427209bc9;

// Namespace namespace_d5a3ac8427209bc9
// Params 0, eflags: 0x5
// Checksum 0xc31e071a, Offset: 0xe8
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "newtonian_negation", #"bgb", &__init__, undefined );
}

// Namespace namespace_d5a3ac8427209bc9
// Params 0
// Checksum 0xee92e621, Offset: 0x10d
// Size: 0x20
function __init__()
{
    namespace_6616340f3419ea2d::register( "newtonian_negation", "time", 180, &enable, &disable, undefined );
}

// Namespace namespace_d5a3ac8427209bc9
// Params 0
// Checksum 0xc0320470, Offset: 0x135
// Size: 0x12
function enable()
{
    invert_gravity( 1 );
    thread disable_on_disconnect();
}

// Namespace namespace_d5a3ac8427209bc9
// Params 0
// Checksum 0xba9fc62b, Offset: 0x14f
// Size: 0x22
function disable_on_disconnect()
{
    self endon( #"newtonian_negation_disable" );
    self waittill( #"disconnect" );
    thread disable();
}

// Namespace namespace_d5a3ac8427209bc9
// Params 0
// Checksum 0x573429cf, Offset: 0x179
// Size: 0xa9
function disable()
{
    if ( isdefined( self ) )
    {
        self notify( #"newtonian_negation_disable" );
    }
    
    foreach ( player in level.players )
    {
        if ( player != self && player namespace_6616340f3419ea2d::is_enabled( "newtonian_negation" ) )
        {
            return;
        }
    }
    
    invert_gravity( 0 );
    removeallcorpses();
}

// Namespace namespace_d5a3ac8427209bc9
// Params 1
// Checksum 0xcbefe8e9, Offset: 0x22a
// Size: 0x4c
function invert_gravity( b_onoff )
{
    if ( b_onoff )
    {
        physics_setgravityragdollscalar( -1 );
        level callback::add( "pre_killed_body_cloned", &on_ai_killed );
        return;
    }
    
    physics_setgravityragdollscalar( 1 );
    level callback::remove( "pre_killed_body_cloned", &on_ai_killed );
}

// Namespace namespace_d5a3ac8427209bc9
// Params 1, eflags: 0x4
// Checksum 0xf5d6d791, Offset: 0x27e
// Size: 0x32
function private on_ai_killed( params )
{
    self.var_f7d02d1022565946 = "death_upwards";
    utility::ent_flag_set( "dissolve_purple" );
    utility::ent_flag_set( "dark_aether_bubble" );
}

