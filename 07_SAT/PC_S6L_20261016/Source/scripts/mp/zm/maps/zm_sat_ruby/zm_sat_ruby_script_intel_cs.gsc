// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_intel_cs.gsc  (hash_5245ca0fbb61ecd9.gscc) (size: 2280 Bytes / 0x8e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa17b3af (4195857327)
// size ...... 2280 (0x8e8)
// includes .. 2   (offset: 0x800)
// strings ... 12  (offset: 0x810)
// dev strs .. 0   (offset: 0x8e8)
// exports ... 6   (offset: 0x550)
// cseg ...... 0x17d + 0x3d3 (0x550)
// imports ... 16  (offset: 0x640)
// animtree1 . 0   (offset: 0x8e8)
// animtree2 . 0   (offset: 0x8e8)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_script_intel_cs;

// Namespace zm_sat_ruby_script_intel_cs
// Params 2
// Checksum 0x5e53a2d, Offset: 0x19b
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_script_intel_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_script_intel_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_script_intel_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_script_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_script_intel_cs
// Params 3, eflags: 0x4
// Checksum 0x368ed8ab, Offset: 0x223
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_script_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_script_intel_cs" );
}

// Namespace zm_sat_ruby_script_intel_cs
// Params 3, eflags: 0x4
// Checksum 0xba263f18, Offset: 0x29d
// Size: 0x293
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 1921.5, -2650, 93.5 ), ( 0, 70.83, 0 ), "ruby_document2_stack" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    s.script_string = "zmintel_sat_ruby_audiolog_1";
    fe [[ f ]]( s, us, cf, ( 257.75, 1617, 321 ), ( 0, 0, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    s.script_string = "zmintel_sat_ruby_audiolog_2";
    fe [[ f ]]( s, us, cf, ( 4994.75, -705, 58.75 ), ( 0, 244.63, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    s.script_string = "zmintel_sat_ruby_audiolog_4";
    fe [[ f ]]( s, us, cf, ( 3758.25, -2580.5, 16.5 ), ( 0, 0, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    s.script_string = "zmintel_sat_ruby_audiolog_3";
    fe [[ f ]]( s, us, cf, ( 1483, -3244.5, 386.5 ), ( 0, 118.31, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 912.75, 873.5, 443.75 ), ( 0, 70.83, 0 ), "pluto_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    fe [[ f ]]( s, us, cf, ( 912.75, 873.5, 236.5 ), ( 0, 70.83, 0 ), "ruby_document1_land" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_intel_cs";
    s.script_string = "zmintel_sat_ruby_document_3";
    fe [[ f ]]( s, us, cf, ( 3963.5, 944.5, -85 ), ( 45.74, 47.37, -12.25 ), undefined, undefined, "zombie_intel" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_script_intel_cs
// Params 0, eflags: 0x4
// Checksum 0x9f48ac9f, Offset: 0x538
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_script_intel_cs
// Params 0
// Checksum 0xf4dd05e6, Offset: 0x542
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_script_intel_cs" );
}

