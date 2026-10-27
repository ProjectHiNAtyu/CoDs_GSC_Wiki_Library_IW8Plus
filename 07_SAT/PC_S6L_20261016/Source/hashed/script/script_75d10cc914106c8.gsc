// script_75d10cc914106c8  (hash_075d10cc914106c8.gscc) (size: 1198 Bytes / 0x4ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3de385ec (1038321132)
// size ...... 1198 (0x4ae)
// includes .. 3   (offset: 0x436)
// strings ... 6   (offset: 0x44e)
// dev strs .. 0   (offset: 0x4ae)
// exports ... 6   (offset: 0x212)
// cseg ...... 0xd1 + 0x141 (0x212)
// imports ... 11  (offset: 0x302)
// animtree1 . 0   (offset: 0x4ae)
// animtree2 . 0   (offset: 0x4ae)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\values;

#namespace namespace_72c943209a0510e6;

// Namespace namespace_72c943209a0510e6
// Params 0, eflags: 0x5
// Checksum 0xbbd8ca7f, Offset: 0xef
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "aftertaste", #"bgb", &__init__, undefined );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0x355ae771, Offset: 0x114
// Size: 0x31
function __init__()
{
    namespace_6616340f3419ea2d::register( "aftertaste", "event", &event, undefined, &disable );
    namespace_6616340f3419ea2d::function_c9046bccce2a4ac8( "aftertaste", &function_e4c9e826f4da942, 1 );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xbdd8acdb, Offset: 0x14d
// Size: 0x45
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_aftertaste" );
    val::set( "bgb_aftertaste", "show_perk_decay", 0 );
    self waittill( #"bgb_aftertaste_used" );
    namespace_6616340f3419ea2d::function_b62ba460d1b3dac9( "aftertaste" );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xa55f43b, Offset: 0x19a
// Size: 0x1f
function disable()
{
    val::reset( "bgb_aftertaste", "show_perk_decay" );
    self notify( #"kill_aftertaste" );
}

// Namespace namespace_72c943209a0510e6
// Params 1
// Checksum 0xddc19e5c, Offset: 0x1c1
// Size: 0x50, Type: bool
function function_e4c9e826f4da942( params )
{
    if ( namespace_6616340f3419ea2d::is_enabled( "aftertaste" ) && params.reason != "last_stand_revived_quick_revive_augment" )
    {
        params.reason = "last_stand_bgb";
        self notify( #"bgb_aftertaste_used" );
        return true;
    }
    
    return false;
}

