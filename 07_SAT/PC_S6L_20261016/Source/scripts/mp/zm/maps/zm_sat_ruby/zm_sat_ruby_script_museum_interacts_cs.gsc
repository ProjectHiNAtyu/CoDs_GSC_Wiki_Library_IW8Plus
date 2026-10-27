// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_museum_interacts_cs.gsc  (hash_5eaa2befd5f50273.gscc) (size: 3917 Bytes / 0xf4d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35e84c6d (904416365)
// size ...... 3917 (0xf4d)
// includes .. 2   (offset: 0xd35)
// strings ... 29  (offset: 0xd45)
// dev strs .. 0   (offset: 0xf4d)
// exports ... 6   (offset: 0xa85)
// cseg ...... 0x3a8 + 0x6dd (0xa85)
// imports ... 16  (offset: 0xb75)
// animtree1 . 0   (offset: 0xf4d)
// animtree2 . 0   (offset: 0xf4d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_script_museum_interacts_cs;

// Namespace zm_sat_ruby_script_museum_interacts_cs
// Params 2
// Checksum 0xab9ba69e, Offset: 0x3c6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_script_museum_interacts_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_script_museum_interacts_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_script_museum_interacts_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_script_museum_interacts_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_script_museum_interacts_cs
// Params 3, eflags: 0x4
// Checksum 0x98f04418, Offset: 0x44e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_script_museum_interacts_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_script_museum_interacts_cs" );
}

// Namespace zm_sat_ruby_script_museum_interacts_cs
// Params 3, eflags: 0x4
// Checksum 0xabbb4eef, Offset: 0x4c8
// Size: 0x59d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( 297.12, 260.04, 292.36 ), ( 0, 184.74, 0 ), "ruby_museum_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit_twins";
    fe [[ f ]]( s, us, cf, ( -58, 525, 291 ), ( 0, 276.92, 0 ), "ruby_museum_interact", undefined, "vo_twins" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2msmdln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2msmdln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( 116, 3, 300 ), ( 0, 6.42, 0 ), "ruby_museum_interact", undefined, "ruby_museum_star_map" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2msatsdln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2msatsdln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( 76, -621, 300 ), ( 0, 186.29, 0 ), "ruby_museum_interact", undefined, "ruby_museum_saturn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2mstskldln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2mstskldln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( -292.88, -672.96, 293.86 ), ( 0, 276.66, 0 ), "ruby_museum_interact", undefined, "ruby_museum_star_skull" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2mmdln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2mmdln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( -760.38, -175.46, 299.86 ), ( 0, 352.36, 0 ), "ruby_museum_interact", undefined, "ruby_museum_mineral" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2mrd";
    s.name = "script_struct_exhibit_rocket";
    fe [[ f ]]( s, us, cf, ( -235.88, 290.04, 294.86 ), ( 0, 7.74, 0 ), "ruby_museum_interact", undefined, "ruby_museum_rocket" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( -212.88, -663.96, 293.86 ), ( 0, 276.66, 0 ), "ruby_museum_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( -219, -607, 294 ), ( 0, 96.66, 0 ), "ruby_museum_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2mddln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2mddln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( -299, -616, 294 ), ( 0, 96.66, 0 ), "ruby_museum_interact", undefined, "ruby_museum_dagger" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( 23, 533, 291 ), ( 0, 276.92, 0 ), "ruby_museum_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( 305.12, 178.04, 292.36 ), ( 0, 184.74, 0 ), "ruby_museum_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.alias1 = "dx_zm_ruwn_rbyw_thur_rw2mmrdln1";
    s.alias2 = "dx_zm_ruwn_rbyw_thur_rw2mmrdln2";
    s.name = "script_struct_exhibit_vo";
    fe [[ f ]]( s, us, cf, ( 101.12, 387.04, 300.36 ), ( 0, 184.74, 0 ), "ruby_museum_interact", undefined, "ruby_museum_martian_relic" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_museum_interacts_cs";
    s.name = "script_struct_exhibit";
    fe [[ f ]]( s, us, cf, ( -448.88, -836.46, 299.86 ), ( 0, 186.29, 0 ), "ruby_museum_interact" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_script_museum_interacts_cs
// Params 0, eflags: 0x4
// Checksum 0xaa408377, Offset: 0xa6d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_script_museum_interacts_cs
// Params 0
// Checksum 0x5aa39955, Offset: 0xa77
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_script_museum_interacts_cs" );
}

