// script_6378d24a1cb6e227  (hash_6378d24a1cb6e227.gscc) (size: 1374 Bytes / 0x55e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b6f844f (997164111)
// size ...... 1374 (0x55e)
// includes .. 3   (offset: 0x4ea)
// strings ... 7   (offset: 0x502)
// dev strs .. 0   (offset: 0x55e)
// exports ... 7   (offset: 0x27e)
// cseg ...... 0xdb + 0x1a3 (0x27e)
// imports ... 12  (offset: 0x396)
// animtree1 . 0   (offset: 0x55e)
// animtree2 . 0   (offset: 0x55e)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;

#namespace namespace_7ceb9c9cd79d0f1a;

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 0, eflags: 0x5
// Checksum 0xfb39efb8, Offset: 0xf9
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "quacknarok", #"bgb", &__init__, undefined );
}

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 0
// Checksum 0xbc8081ef, Offset: 0x11e
// Size: 0x42
function __init__()
{
    bgb::register( "quacknarok", "time", 180, &enable, &disable, undefined );
    callback::add( "on_zombie_ai_spawned", &function_77688a5e67bd527f );
    callback::add( "on_zombie_ai_killed", &on_ai_killed );
}

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 0
// Checksum 0x243dc728, Offset: 0x168
// Size: 0x2
function enable()
{
    
}

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 0
// Checksum 0x98d8424b, Offset: 0x172
// Size: 0x2
function disable()
{
    
}

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 1, eflags: 0x4
// Checksum 0x10420799, Offset: 0x17c
// Size: 0xcd
function private function_77688a5e67bd527f( params )
{
    if ( self.subclass === "zombie_base" )
    {
        var_f74ed6e091c46e62 = 0;
        
        foreach ( player in level.players )
        {
            if ( player bgb::is_enabled( "quacknarok" ) )
            {
                var_f74ed6e091c46e62 = 1;
            }
        }
        
        if ( var_f74ed6e091c46e62 )
        {
            self attach( "t10_zm_red_floatie_duck_front", "J_MainRoot" );
            self.var_590ed57a5a3e1f54 = 1;
        }
    }
}

// Namespace namespace_7ceb9c9cd79d0f1a
// Params 1
// Checksum 0xd044223b, Offset: 0x251
// Size: 0x2d
function on_ai_killed( params )
{
    if ( isdefined( self ) && self.var_590ed57a5a3e1f54 )
    {
        self playsoundevent( %"snd_quacknarok_death" );
    }
}

