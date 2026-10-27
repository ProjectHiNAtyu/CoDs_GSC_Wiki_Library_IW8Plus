// script_6d84980e036a5330  (hash_6d84980e036a5330.gscc) (size: 1176 Bytes / 0x498 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11535c3e (290675774)
// size ...... 1176 (0x498)
// includes .. 3   (offset: 0x44c)
// strings ... 3   (offset: 0x464)
// dev strs .. 0   (offset: 0x498)
// exports ... 6   (offset: 0x244)
// cseg ...... 0x85 + 0x1bf (0x244)
// imports ... 10  (offset: 0x334)
// animtree1 . 0   (offset: 0x498)
// animtree2 . 0   (offset: 0x498)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_b08712ccc11317ed;

// Namespace namespace_b08712ccc11317ed
// Params 0, eflags: 0x5
// Checksum 0xedb7f74f, Offset: 0xa3
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "phoenix_up", #"bgb", &__init__, undefined );
}

// Namespace namespace_b08712ccc11317ed
// Params 0
// Checksum 0x6598d6e, Offset: 0xc8
// Size: 0x40
function __init__()
{
    bgb::register( "phoenix_up", "activated", 1, undefined, undefined, &validation, &activation );
    bgb::function_c9046bccce2a4ac8( "phoenix_up", &function_e4c9e826f4da942, 1 );
    bgb::function_ecc4426f6a3d4e88( "phoenix_up" );
}

// Namespace namespace_b08712ccc11317ed
// Params 0
// Checksum 0x662fca52, Offset: 0x110
// Size: 0xe7, Type: bool
function validation()
{
    players = level.players;
    
    foreach ( player in players )
    {
        if ( player.team != self.team )
        {
            continue;
        }
        
        if ( player.var_a0b1f41aaeb1ce10 )
        {
            return false;
        }
        
        if ( isdefined( level.var_6965477c3d0b042a ) && self [[ level.var_6965477c3d0b042a ]]( player, 1, 1 ) )
        {
            return true;
        }
        
        if ( player.inlaststand )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_b08712ccc11317ed
// Params 0
// Checksum 0xc0d6c432, Offset: 0x200
// Size: 0x17
function activation()
{
    utility::callsharedfunc( "phoenix_up", #"activation" );
}

// Namespace namespace_b08712ccc11317ed
// Params 1
// Checksum 0x2530c8ad, Offset: 0x21f
// Size: 0x24, Type: bool
function function_e4c9e826f4da942( params )
{
    if ( params.reason === "last_stand_bgb" )
    {
        return true;
    }
    
    return false;
}

