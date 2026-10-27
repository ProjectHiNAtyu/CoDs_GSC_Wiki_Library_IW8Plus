// script_5a54cbef2f6dff5a  (hash_5a54cbef2f6dff5a.gscc) (size: 1098 Bytes / 0x44a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd867b91f (3630676255)
// size ...... 1098 (0x44a)
// includes .. 4   (offset: 0x412)
// strings ... 1   (offset: 0x432)
// dev strs .. 0   (offset: 0x44a)
// exports ... 7   (offset: 0x1c2)
// cseg ...... 0x68 + 0x15a (0x1c2)
// imports ... 11  (offset: 0x2da)
// animtree1 . 0   (offset: 0x44a)
// animtree2 . 0   (offset: 0x44a)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_powerups;

#namespace namespace_5a59092f034c1c3d;

// Namespace namespace_5a59092f034c1c3d
// Params 0, eflags: 0x5
// Checksum 0x9e3d84a5, Offset: 0x86
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"power_vacuum_zm", "power_vacuum", &pre_main, undefined );
}

// Namespace namespace_5a59092f034c1c3d
// Params 0, eflags: 0x4
// Checksum 0x569b6942, Offset: 0xab
// Size: 0x42
function private pre_main()
{
    utility::registersharedfunc( "power_vacuum", #"enable", &enable );
    utility::registersharedfunc( "power_vacuum", #"disable", &disable );
    namespace_c0d2b08434f47155::function_fb99058524336897( &function_9af9414723a09886 );
}

// Namespace namespace_5a59092f034c1c3d
// Params 0
// Checksum 0xf0ecd40f, Offset: 0xf5
// Size: 0x2
function enable()
{
    
}

// Namespace namespace_5a59092f034c1c3d
// Params 0
// Checksum 0x92999d5b, Offset: 0xff
// Size: 0x18
function disable()
{
    self notify( #"kill_power_vacuum" );
    self.var_c33b95f2af8ebec5 = undefined;
}

// Namespace namespace_5a59092f034c1c3d
// Params 1
// Checksum 0xf6b55b4f, Offset: 0x11f
// Size: 0x68, Type: bool
function function_9af9414723a09886( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player bgb::is_enabled( "power_vacuum" ) || player.var_c33b95f2af8ebec5 )
    {
        return false;
    }
    
    if ( utility::percent_chance( 10 ) )
    {
        player thread bonus_cooldown();
        return true;
    }
    
    return false;
}

// Namespace namespace_5a59092f034c1c3d
// Params 0
// Checksum 0x8bf57687, Offset: 0x190
// Size: 0x32
function bonus_cooldown()
{
    self endon( #"disconnect" );
    self endon( #"kill_power_vacuum" );
    self.var_c33b95f2af8ebec5 = 1;
    wait 20;
    self.var_c33b95f2af8ebec5 = undefined;
}

