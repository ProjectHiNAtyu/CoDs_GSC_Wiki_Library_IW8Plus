// scripts\autotests\gscunittest\test_gscunittest_patch_far.gsc  (hash_21307da6b7fcd97c.gscc) (size: 470 Bytes / 0x1d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x851827af (2232952751)
// size ...... 470 (0x1d6)
// includes .. 1   (offset: 0x1b6)
// strings ... 2   (offset: 0x1be)
// dev strs .. 0   (offset: 0x1d6)
// exports ... 4   (offset: 0xfa)
// cseg ...... 0xa5 + 0x55 (0xfa)
// imports ... 1   (offset: 0x19a)
// animtree1 . 0   (offset: 0x1d6)
// animtree2 . 0   (offset: 0x1d6)
#using scripts\autotests\autotests;

#namespace test_gscunittest_patch_far;

// Namespace test_gscunittest_patch_far
// Params 0
// Checksum 0xdb95daac, Offset: 0xc3
// Size: 0x17
function patch_far()
{
    autotests::function_d84657f448aaeef6( "patch_far", 1, "scripts/autotests/gscunittest/test_gscunittest_patch_far.gsc", 7 );
}

// Namespace test_gscunittest_patch_far
// Params 0
// Checksum 0x8370eeb9, Offset: 0xe2
// Size: 0xe
function patch_far_notify()
{
    level notify( #"patch_far_notify" );
}

// Namespace test_gscunittest_patch_far
// Params 0
// Checksum 0x7aaf6b7b, Offset: 0xf8
// Size: 0x2
function patch_far_wait()
{
    
}

