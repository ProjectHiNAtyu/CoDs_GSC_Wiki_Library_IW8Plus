// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_simon_cs.gsc  (hash_741ac5b3229539b4.gscc) (size: 1890 Bytes / 0x762 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28a6b243 (682013251)
// size ...... 1890 (0x762)
// includes .. 2   (offset: 0x69a)
// strings ... 10  (offset: 0x6aa)
// dev strs .. 0   (offset: 0x762)
// exports ... 6   (offset: 0x3ea)
// cseg ...... 0xd2 + 0x318 (0x3ea)
// imports ... 16  (offset: 0x4da)
// animtree1 . 0   (offset: 0x762)
// animtree2 . 0   (offset: 0x762)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_ee_simon_cs;

// Namespace zm_sat_ruby_ee_simon_cs
// Params 2
// Checksum 0x80c35127, Offset: 0xf0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_ee_simon_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_ee_simon_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_ee_simon_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_ee_simon_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_ee_simon_cs
// Params 3, eflags: 0x4
// Checksum 0xb3a8b3a1, Offset: 0x178
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_ee_simon_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_ee_simon_cs" );
}

// Namespace zm_sat_ruby_ee_simon_cs
// Params 3, eflags: 0x4
// Checksum 0xe13eec83, Offset: 0x1f2
// Size: 0x1d8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1463, -3333, 241 ), ( 0, 117.16, 0 ), "ruby_ee_simon", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1472, -3327, 241 ), ( 0, 117.16, 0 ), "ruby_ee_simon", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1453, -3339, 241 ), ( 0, 117.16, 0 ), "ruby_ee_simon", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1432, -3349, 241 ), ( 0, 117.16, 0 ), "ruby_ee_simon", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1442, -3343, 241 ), ( 0, 117.16, 0 ), "ruby_ee_simon", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_simon_cs";
    fe [[ f ]]( s, us, cf, ( 1453, -3339, 241 ), ( 0, 118.16, 0 ), "ruby_ee_simon_reward" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_ee_simon_cs
// Params 0, eflags: 0x4
// Checksum 0x3a620e, Offset: 0x3d2
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_ee_simon_cs
// Params 0
// Checksum 0x71fb6eec, Offset: 0x3dc
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_ee_simon_cs" );
}

