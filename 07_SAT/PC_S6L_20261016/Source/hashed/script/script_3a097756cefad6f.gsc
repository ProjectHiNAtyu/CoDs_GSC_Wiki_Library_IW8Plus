// script_3a097756cefad6f  (hash_03a097756cefad6f.gscc) (size: 1557 Bytes / 0x615 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2cd9ccd (3536690381)
// size ...... 1557 (0x615)
// includes .. 3   (offset: 0x5a1)
// strings ... 7   (offset: 0x5b9)
// dev strs .. 0   (offset: 0x615)
// exports ... 8   (offset: 0x2b9)
// cseg ...... 0xe9 + 0x1d0 (0x2b9)
// imports ... 15  (offset: 0x3f9)
// animtree1 . 0   (offset: 0x615)
// animtree2 . 0   (offset: 0x615)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;

#namespace zm_bgb_holiday_cheer;

// Namespace zm_bgb_holiday_cheer
// Params 0, eflags: 0x5
// Checksum 0xa898e4af, Offset: 0x107
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "holiday_cheer", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_holiday_cheer
// Params 0
// Checksum 0x7fe88477, Offset: 0x12c
// Size: 0x42
function __init__()
{
    namespace_6616340f3419ea2d::register( "holiday_cheer", "time", 180, &enable, &disable, undefined );
    callback::add( "on_zombie_ai_spawned", &function_77688a5e67bd527f );
    callback::add( "on_zombie_ai_killed", &on_ai_killed );
}

// Namespace zm_bgb_holiday_cheer
// Params 0
// Checksum 0x8ea17d60, Offset: 0x176
// Size: 0x2
function enable()
{
    
}

// Namespace zm_bgb_holiday_cheer
// Params 0
// Checksum 0x3244f803, Offset: 0x180
// Size: 0x2
function disable()
{
    
}

// Namespace zm_bgb_holiday_cheer
// Params 1, eflags: 0x4
// Checksum 0x3e049ec3, Offset: 0x18a
// Size: 0xcd
function private function_77688a5e67bd527f( params )
{
    if ( self.subclass === "zombie_base" )
    {
        var_6320609c80e36cb4 = 0;
        
        foreach ( player in level.players )
        {
            if ( player namespace_6616340f3419ea2d::is_enabled( "holiday_cheer" ) )
            {
                var_6320609c80e36cb4 = 1;
            }
        }
        
        if ( var_6320609c80e36cb4 )
        {
            self attach( "c_t10_zmb_zombie_christmas_wreath_b_fxanim", "J_Spine4" );
            self.bgb_holiday_cheer = 1;
        }
    }
}

// Namespace zm_bgb_holiday_cheer
// Params 1
// Checksum 0x9bffde27, Offset: 0x25f
// Size: 0x3c
function on_ai_killed( params )
{
    if ( isdefined( self ) && self.bgb_holiday_cheer )
    {
        if ( gettime() >= level.var_7891483386bbdac2 && randomint( 100 ) < 40 )
        {
        }
    }
}

// Namespace zm_bgb_holiday_cheer
// Params 0
// Checksum 0x7dbdd24f, Offset: 0x2a3
// Size: 0x16
function clean_up_hat()
{
    wait randomintrange( 15, 25 );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

