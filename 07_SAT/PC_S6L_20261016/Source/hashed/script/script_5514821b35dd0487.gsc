// script_5514821b35dd0487  (hash_5514821b35dd0487.gscc) (size: 1387 Bytes / 0x56b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xabcbfad1 (2882271953)
// size ...... 1387 (0x56b)
// includes .. 3   (offset: 0x4f7)
// strings ... 6   (offset: 0x50f)
// dev strs .. 0   (offset: 0x56b)
// exports ... 8   (offset: 0x287)
// cseg ...... 0xb3 + 0x1d4 (0x287)
// imports ... 10  (offset: 0x3c7)
// animtree1 . 0   (offset: 0x56b)
// animtree2 . 0   (offset: 0x56b)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\equipment;

#namespace zm_bgb_requipment;

// Namespace zm_bgb_requipment
// Params 0, eflags: 0x5
// Checksum 0x2d33fc8, Offset: 0xd1
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "requipment", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_requipment
// Params 0
// Checksum 0xc8db8a4d, Offset: 0xf6
// Size: 0x25
function __init__()
{
    bgb::register( "requipment", "time", 300, &enable, &disable, &validation );
}

// Namespace zm_bgb_requipment
// Params 0
// Checksum 0x34cd1afe, Offset: 0x123
// Size: 0x36, Type: bool
function validation()
{
    has_lethal = equipment_mp::getcurrentequipment( "primary" );
    has_tactical = equipment_mp::getcurrentequipment( "secondary" );
    return has_lethal || has_tactical;
}

// Namespace zm_bgb_requipment
// Params 0
// Checksum 0xf8972f8b, Offset: 0x162
// Size: 0x9
function enable()
{
    thread requipment_watcher();
}

// Namespace zm_bgb_requipment
// Params 0
// Checksum 0x62351587, Offset: 0x173
// Size: 0x70
function requipment_watcher()
{
    self endon( #"disconnect" );
    self endon( #"disable_requipment" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_d0a03de4597b75bf( "primary", 1 );
        function_d0a03de4597b75bf( "secondary", 1 );
        wait 20;
        function_d0a03de4597b75bf( "primary", 0 );
        function_d0a03de4597b75bf( "secondary", 0 );
        wait 20;
    }
}

// Namespace zm_bgb_requipment
// Params 2
// Checksum 0xde97067a, Offset: 0x1eb
// Size: 0x86
function function_d0a03de4597b75bf( slot, var_9bc811f166d05dfa )
{
    self endon( #"disconnect", #"disable_requipment" );
    level endon( #"game_ended" );
    ref = equipment_mp::getcurrentequipment( slot );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( var_9bc811f166d05dfa == 1 )
    {
        if ( ref != "equip_monkey_bomb" && ref != "equip_blackhole_bomb" )
        {
            equipment_mp::incrementequipmentslotammo( slot );
        }
        
        return;
    }
    
    equipment_mp::incrementequipmentslotammo( slot );
}

// Namespace zm_bgb_requipment
// Params 0
// Checksum 0x572f7bfd, Offset: 0x279
// Size: 0xe
function disable()
{
    self notify( #"disable_requipment" );
}

