// scripts\autotests\test_navdata.gsc  (hash_7f8e6ba377ce8989.gscc) (size: 1111 Bytes / 0x457 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f0dc306 (1057866502)
// size ...... 1111 (0x457)
// includes .. 1   (offset: 0x3f3)
// strings ... 6   (offset: 0x3fb)
// dev strs .. 0   (offset: 0x457)
// exports ... 4   (offset: 0x1f7)
// cseg ...... 0xf1 + 0x106 (0x1f7)
// imports ... 12  (offset: 0x297)
// animtree1 . 0   (offset: 0x457)
// animtree2 . 0   (offset: 0x457)
#using scripts\autotests\autotests;

#namespace test_navdata;

// Namespace test_navdata/testautomation
// Params 0, eflags: 0x20
// Checksum 0x966b255f, Offset: 0x10f
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_navdata.gsc", #"ai", &start_test, &setup );
}

// Namespace test_navdata
// Params 0
// Checksum 0x2fde3a67, Offset: 0x138
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_navdata
// Params 0
// Checksum 0xe9578493, Offset: 0x14c
// Size: 0xaa, Type: bool
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    autotests::function_d84657f448aaeef6( "Map has navmesh?", isnavmeshloaded(), "scripts/autotests/test_navdata.gsc", 24 );
    nav_bounds = getnavbounds();
    autotests::function_d84657f448aaeef6( "Map has nav bounds?", isdefined( nav_bounds ), "scripts/autotests/test_navdata.gsc", 27 );
    autotests::function_d84657f448aaeef6( "Map has tacgraph?", hastacgraph(), "scripts/autotests/test_navdata.gsc", 29 );
    autotests::function_e5040106e5cc1c59( "Map has nav zones?", getzonecount(), 0, "scripts/autotests/test_navdata.gsc", 31 );
    autotests::function_e5040106e5cc1c59( "Map has fixed path nodes?", getpathfixednodecount(), 0, "scripts/autotests/test_navdata.gsc", 33 );
    return false;
}

