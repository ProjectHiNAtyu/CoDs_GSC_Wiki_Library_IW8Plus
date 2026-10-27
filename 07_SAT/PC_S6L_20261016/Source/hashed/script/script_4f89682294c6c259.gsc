// script_4f89682294c6c259  (hash_4f89682294c6c259.gscc) (size: 4713 Bytes / 0x1269 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0b7ec80 (3770150016)
// size ...... 4713 (0x1269)
// includes .. 2   (offset: 0xfbd)
// strings ... 34  (offset: 0xfcd)
// dev strs .. 0   (offset: 0x1269)
// exports ... 6   (offset: 0xd0d)
// cseg ...... 0x14f + 0xbbe (0xd0d)
// imports ... 16  (offset: 0xdfd)
// animtree1 . 0   (offset: 0x1269)
// animtree2 . 0   (offset: 0x1269)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace saw_cq_crash_sites_cs;

// Namespace saw_cq_crash_sites_cs
// Params 2
// Checksum 0x2f3f0a4d, Offset: 0x16d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "saw_cq_crash_sites_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "saw_cq_crash_sites_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "saw_cq_crash_sites_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "saw_cq_crash_sites_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace saw_cq_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x1c54e8cb, Offset: 0x1f5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "saw_cq_crash_sites_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "saw_cq_crash_sites_cs" );
}

// Namespace saw_cq_crash_sites_cs
// Params 3, eflags: 0x4
// Checksum 0x4466593, Offset: 0x26f
// Size: 0xa7e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "1";
    fe [[ f ]]( s, us, cf, ( -4545, -17871, -156 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "2";
    fe [[ f ]]( s, us, cf, ( 40279, -10186, 576 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "0";
    fe [[ f ]]( s, us, cf, ( -14418.4, 11645.3, -242.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "5";
    fe [[ f ]]( s, us, cf, ( -21650, 7240.26, -267.24 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "4";
    fe [[ f ]]( s, us, cf, ( -16724.4, -1780.7, -116.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "3";
    fe [[ f ]]( s, us, cf, ( -14891, 24079, -390 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "8";
    fe [[ f ]]( s, us, cf, ( 25943.6, 22457.3, 1751.41 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "9";
    fe [[ f ]]( s, us, cf, ( 597.6, -12100.7, 1215.41 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "7";
    fe [[ f ]]( s, us, cf, ( 18007.6, 11093.3, -446.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "11";
    fe [[ f ]]( s, us, cf, ( 32293, 7020, -500 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "12";
    fe [[ f ]]( s, us, cf, ( 42089.6, -26326.7, -386.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "13";
    fe [[ f ]]( s, us, cf, ( 2911.6, -26042.7, -184.47 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "14";
    fe [[ f ]]( s, us, cf, ( 18983.6, -10470.7, -138.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "15";
    fe [[ f ]]( s, us, cf, ( 40469.6, 21577.3, -408.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "16";
    fe [[ f ]]( s, us, cf, ( 7121.6, 37167.3, 1697.41 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "17";
    fe [[ f ]]( s, us, cf, ( -2704.4, 17381.3, -36.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "18";
    fe [[ f ]]( s, us, cf, ( 25855.8, 30681.2, 796.14 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "19";
    fe [[ f ]]( s, us, cf, ( 18261.6, -22780.7, -176.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "20";
    fe [[ f ]]( s, us, cf, ( 26553.6, -13920.7, -176.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "21";
    fe [[ f ]]( s, us, cf, ( -23088.4, -12878.7, -22.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "6";
    fe [[ f ]]( s, us, cf, ( -10254.4, -15380.7, -126.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "22";
    fe [[ f ]]( s, us, cf, ( 8181.6, 21623.3, 1.41 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "23";
    fe [[ f ]]( s, us, cf, ( 10962.4, 11490.7, -228.05 ), ( 0, 180, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "10";
    fe [[ f ]]( s, us, cf, ( -482, 5435, -300 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "24";
    fe [[ f ]]( s, us, cf, ( 2846, 427, -232 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "25";
    fe [[ f ]]( s, us, cf, ( -6104, -32061, 384 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "26";
    fe [[ f ]]( s, us, cf, ( 20101.6, -2356.7, -350.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "27";
    fe [[ f ]]( s, us, cf, ( -16938.4, 37781.3, -480.59 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "28";
    fe [[ f ]]( s, us, cf, ( 24842.4, -31672, -357.45 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_cs";
    s.script_index = "29";
    fe [[ f ]]( s, us, cf, ( -15604.4, -31508.7, 589.41 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1500 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace saw_cq_crash_sites_cs
// Params 0, eflags: 0x4
// Checksum 0xf15e7b54, Offset: 0xcf5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace saw_cq_crash_sites_cs
// Params 0
// Checksum 0xde073586, Offset: 0xcff
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "saw_cq_crash_sites_cs" );
}

