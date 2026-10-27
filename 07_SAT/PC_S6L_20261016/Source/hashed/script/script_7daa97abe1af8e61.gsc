// script_7daa97abe1af8e61  (hash_7daa97abe1af8e61.gscc) (size: 4381 Bytes / 0x111d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf63eb75 (3747867509)
// size ...... 4381 (0x111d)
// includes .. 2   (offset: 0xead)
// strings ... 31  (offset: 0xebd)
// dev strs .. 0   (offset: 0x111d)
// exports ... 6   (offset: 0xbfd)
// cseg ...... 0x144 + 0xab9 (0xbfd)
// imports ... 16  (offset: 0xced)
// animtree1 . 0   (offset: 0x111d)
// animtree2 . 0   (offset: 0x111d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace saw_cq_crash_sites_avalon_cs;

// Namespace saw_cq_crash_sites_avalon_cs
// Params 2
// Checksum 0x17001c4f, Offset: 0x162
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "saw_cq_crash_sites_avalon_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "saw_cq_crash_sites_avalon_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "saw_cq_crash_sites_avalon_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "saw_cq_crash_sites_avalon_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace saw_cq_crash_sites_avalon_cs
// Params 3, eflags: 0x4
// Checksum 0x246bfec9, Offset: 0x1ea
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "saw_cq_crash_sites_avalon_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "saw_cq_crash_sites_avalon_cs" );
}

// Namespace saw_cq_crash_sites_avalon_cs
// Params 3, eflags: 0x4
// Checksum 0x1cde7e3b, Offset: 0x264
// Size: 0x979
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "0";
    fe [[ f ]]( s, us, cf, ( 11952, 23968, 1072 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "4";
    fe [[ f ]]( s, us, cf, ( 6014, -3760, 801.02 ), ( 360, 360, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "7";
    fe [[ f ]]( s, us, cf, ( 11966, 5434, 369.02 ), ( 360, 360, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "3";
    fe [[ f ]]( s, us, cf, ( -12998, 5714, 1217.02 ), ( 360, 360, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "10";
    fe [[ f ]]( s, us, cf, ( 13398, 16318, 38.77 ), ( 0, 336, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "2";
    fe [[ f ]]( s, us, cf, ( 31516, 12408, 814 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "12";
    fe [[ f ]]( s, us, cf, ( 30256, 5212, 702 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "5";
    fe [[ f ]]( s, us, cf, ( -24, 5042, 175.18 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "8";
    fe [[ f ]]( s, us, cf, ( 21030, 21284, 706 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "13";
    fe [[ f ]]( s, us, cf, ( 30798, -24626, 582 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "14";
    fe [[ f ]]( s, us, cf, ( 10692, -33306, 4338 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "15";
    fe [[ f ]]( s, us, cf, ( -24396, -13854, 1420 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "16";
    fe [[ f ]]( s, us, cf, ( -27992, -29122, 938 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "18";
    fe [[ f ]]( s, us, cf, ( -12516, 31412, 656 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "20";
    fe [[ f ]]( s, us, cf, ( -16758, -2628, 1628 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "21";
    fe [[ f ]]( s, us, cf, ( -1240, -19544, 232.95 ), ( 0, 332, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "22";
    fe [[ f ]]( s, us, cf, ( 26868, -13682, 677.85 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "23";
    fe [[ f ]]( s, us, cf, ( -33540, -3182, 604 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "9";
    fe [[ f ]]( s, us, cf, ( 43632, -10742, 582 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "1";
    fe [[ f ]]( s, us, cf, ( -14968, 12852, 1125.02 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "6";
    fe [[ f ]]( s, us, cf, ( 10318, 41956, 1557.02 ), ( 360, 360, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "19";
    fe [[ f ]]( s, us, cf, ( 22412, -20236, 361.02 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "24";
    fe [[ f ]]( s, us, cf, ( -38428, 12088, 236 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "25";
    fe [[ f ]]( s, us, cf, ( -15394, -19428, 590 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "11";
    fe [[ f ]]( s, us, cf, ( 29408, 31034, 3014 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "26";
    fe [[ f ]]( s, us, cf, ( -22876, 30916, 2642 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "saw_cq_crash_sites_avalon_cs";
    s.script_index = "17";
    fe [[ f ]]( s, us, cf, ( 28970, -4992, 338 ), ( 0, 0, 0 ), undefined, undefined, "ironclad_crash_site", undefined, undefined, undefined, undefined, 1000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace saw_cq_crash_sites_avalon_cs
// Params 0, eflags: 0x4
// Checksum 0x45986a30, Offset: 0xbe5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace saw_cq_crash_sites_avalon_cs
// Params 0
// Checksum 0xe6382384, Offset: 0xbef
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "saw_cq_crash_sites_avalon_cs" );
}

