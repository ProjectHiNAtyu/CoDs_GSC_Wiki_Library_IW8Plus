// scripts\mp\common\weapons\ww_raygun.gsc  (hash_352b4c2fac6dd593.gscc) (size: 481 Bytes / 0x1e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7997c8ae (2039990446)
// size ...... 481 (0x1e1)
// includes .. 2   (offset: 0x1d1)
// strings ... 0   (offset: 0x1e1)
// dev strs .. 0   (offset: 0x1e1)
// exports ... 4   (offset: 0xc1)
// cseg ...... 0x58 + 0x69 (0xc1)
// imports ... 4   (offset: 0x161)
// animtree1 . 0   (offset: 0x1e1)
// animtree2 . 0   (offset: 0x1e1)
#using scripts\common\system;
#using scripts\common\utility;

#namespace ww_raygun;

// Namespace ww_raygun
// Params 0, eflags: 0x5
// Checksum 0x201a98e2, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ww_raygun", undefined, &pre_main, undefined );
}

// Namespace ww_raygun
// Params 0, eflags: 0x4
// Checksum 0x7da85a49, Offset: 0x97
// Size: 0x20
function private pre_main()
{
    utility::registersharedfunc( #"ww_raygun", #"init", &init );
}

// Namespace ww_raygun
// Params 0, eflags: 0x4
// Checksum 0xe7292b9f, Offset: 0xbf
// Size: 0x2
function private init()
{
    
}

