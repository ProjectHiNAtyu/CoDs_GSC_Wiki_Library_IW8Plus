// scripts\mp\common\killstreaks\auto_drone_mp.gsc  (hash_37c6dc95fbbebc3a.gscc) (size: 555 Bytes / 0x22b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e21cd45 (505531717)
// size ...... 555 (0x22b)
// includes .. 3   (offset: 0x207)
// strings ... 1   (offset: 0x21f)
// dev strs .. 0   (offset: 0x22b)
// exports ... 3   (offset: 0xe7)
// cseg ...... 0x66 + 0x81 (0xe7)
// imports ... 6   (offset: 0x15f)
// animtree1 . 0   (offset: 0x22b)
// animtree2 . 0   (offset: 0x22b)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\auto_drone;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace auto_drone_mp;

// Namespace auto_drone_mp
// Params 0, eflags: 0x5
// Checksum 0x4e5457ae, Offset: 0x84
// Size: 0x38
function private autoexec main()
{
    killstreaks::registerkillstreak( "auto_drone", &auto_drone::function_948ef213e45dfc60 );
    utility::registersharedfunc( #"auto_drone", #"attachxrays", &auto_drone_attachxrays );
    auto_drone::init();
}

// Namespace auto_drone_mp
// Params 1
// Checksum 0x90f33e0a, Offset: 0xc4
// Size: 0x22
function auto_drone_attachxrays( autodrone )
{
    autodrone setentityhudoutlinedata( 3, autodrone.team );
    return autodrone;
}

