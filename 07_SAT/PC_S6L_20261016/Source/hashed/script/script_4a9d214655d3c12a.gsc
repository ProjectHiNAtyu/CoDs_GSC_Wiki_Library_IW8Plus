// script_4a9d214655d3c12a  (hash_4a9d214655d3c12a.gscc) (size: 611 Bytes / 0x263 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7b58726 (4155868966)
// size ...... 611 (0x263)
// includes .. 1   (offset: 0x24b)
// strings ... 1   (offset: 0x253)
// dev strs .. 0   (offset: 0x263)
// exports ... 6   (offset: 0x123)
// cseg ...... 0x72 + 0xb1 (0x123)
// imports ... 2   (offset: 0x213)
// animtree1 . 0   (offset: 0x263)
// animtree2 . 0   (offset: 0x263)
#using scripts\common\callbacks;

#namespace specialty_heartbreaker;

// Namespace specialty_heartbreaker
// Params 0, eflags: 0x1
// Checksum 0x1a0f1127, Offset: 0x90
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_heartbreaker
// Params 1
// Checksum 0x6dacdb4e, Offset: 0xb0
// Size: 0x55
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_heartbreaker" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_heartbreaker", undefined, undefined, [] );
    }
}

// Namespace specialty_heartbreaker
// Params 0
// Checksum 0x65b7635b, Offset: 0x10d
// Size: 0x2
function initheartbreaker()
{
    
}

// Namespace specialty_heartbreaker
// Params 0
// Checksum 0x287cd4de, Offset: 0x117
// Size: 0x2
function setheartbreaker()
{
    
}

// Namespace specialty_heartbreaker
// Params 0
// Checksum 0xbf997f57, Offset: 0x121
// Size: 0x2
function unsetheartbreaker()
{
    
}

