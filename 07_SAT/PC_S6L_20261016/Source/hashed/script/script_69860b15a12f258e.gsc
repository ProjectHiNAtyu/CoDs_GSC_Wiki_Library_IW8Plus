// script_69860b15a12f258e  (hash_69860b15a12f258e.gscc) (size: 1334 Bytes / 0x536 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7d2c07e (2815606910)
// size ...... 1334 (0x536)
// includes .. 4   (offset: 0x4da)
// strings ... 4   (offset: 0x4fa)
// dev strs .. 0   (offset: 0x536)
// exports ... 6   (offset: 0x2a6)
// cseg ...... 0x83 + 0x223 (0x2a6)
// imports ... 11  (offset: 0x396)
// animtree1 . 0   (offset: 0x536)
// animtree2 . 0   (offset: 0x536)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_turn_coat;

// Namespace zm_bgb_turn_coat
// Params 0, eflags: 0x5
// Checksum 0xd0f342da, Offset: 0xa1
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "turn_coat", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_turn_coat
// Params 0
// Checksum 0x64ceaba9, Offset: 0xc6
// Size: 0x21
function __init__()
{
    bgb::register( "turn_coat", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace zm_bgb_turn_coat
// Params 0
// Checksum 0x6fa12824, Offset: 0xef
// Size: 0x9
function activation()
{
    function_51ec5acae60ad65d();
}

// Namespace zm_bgb_turn_coat
// Params 0
// Checksum 0x235fab10, Offset: 0x100
// Size: 0xc9, Type: bool
function validation()
{
    zombies = getaispeciesarray( "all", "zombie" );
    var_13558672f02377bb = utility::get_array_of_closest( self.origin, zombies, undefined, undefined, 256 );
    n_count = 0;
    
    foreach ( zombie in var_13558672f02377bb )
    {
        if ( !zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            n_count++;
            
            if ( n_count >= 1 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_bgb_turn_coat
// Params 0
// Checksum 0xa819f73, Offset: 0x1d2
// Size: 0xd4
function function_51ec5acae60ad65d()
{
    zombies = getaispeciesarray( "all", "zombie" );
    var_13558672f02377bb = utility::get_array_of_closest( self.origin, zombies, undefined, undefined, 256 );
    n_count = 0;
    
    foreach ( zombie in var_13558672f02377bb )
    {
        if ( !zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            zombie zombie_utils::function_f2e381737e46096( self, 30, 1 );
            n_count++;
            
            if ( n_count >= 5 )
            {
                return;
            }
        }
    }
}

