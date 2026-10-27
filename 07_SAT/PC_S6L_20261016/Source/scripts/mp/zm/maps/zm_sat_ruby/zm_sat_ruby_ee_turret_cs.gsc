// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_turret_cs.gsc  (hash_771b9bc8f33eea8c.gscc) (size: 4333 Bytes / 0x10ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa9e2061 (2862489697)
// size ...... 4333 (0x10ed)
// includes .. 2   (offset: 0xe71)
// strings ... 28  (offset: 0xe81)
// dev strs .. 0   (offset: 0x10ed)
// exports ... 6   (offset: 0xbc1)
// cseg ...... 0x31e + 0x8a3 (0xbc1)
// imports ... 16  (offset: 0xcb1)
// animtree1 . 0   (offset: 0x10ed)
// animtree2 . 0   (offset: 0x10ed)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_ee_turret_cs;

// Namespace zm_sat_ruby_ee_turret_cs
// Params 2
// Checksum 0xeb85f1fc, Offset: 0x33c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_ee_turret_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_ee_turret_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_ee_turret_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_ee_turret_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_ee_turret_cs
// Params 3, eflags: 0x4
// Checksum 0xd8ee137a, Offset: 0x3c4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_ee_turret_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_ee_turret_cs" );
}

// Namespace zm_sat_ruby_ee_turret_cs
// Params 3, eflags: 0x4
// Checksum 0x514d24c4, Offset: 0x43e
// Size: 0x763
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "rock";
    fe [[ f ]]( s, us, cf, ( 4692, 825, 7 ), ( 297.78, 215.13, 28.43 ), "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 6004, 2370, 387 ), ( 0, 0, 0 ), "cspf_0_auto78167102636272718", "cspf_0_auto5576725701509727739", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 91, 9, 121 );
    s._size_min = ( 75, 32, 55 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4738, 1057, 25 ), ( 0, 315, 0 ), "ee_ruby_rock_path_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 4845, 1133, 46 ), ( 341.3, 50.9, 0 ), "ee_ruby_rock_path_start", "cspf_0_auto78167102636272718", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 6836.46, 3564.93, 793 ), ( 0, 0, 0 ), "cspf_0_auto5576725701509727739", "cspf_0_auto293911931743866950", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 7712.05, 5735.78, 1688 ), ( 0, 0, 0 ), "cspf_0_auto293911931743866950", "cspf_0_auto13396282435036360688", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -3125.14, -304.87, 215.06 ), ( 0, 46.8, 0 ), "ee_ruby_rock_path_end", undefined, "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 6394.58, 7042.35, 2724.39 ), ( 0, 0, 0 ), "cspf_0_auto13396282435036360688", "cspf_0_auto4530343993108001560", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 4027.7, 7519.61, 3017.52 ), ( 0, 0, 0 ), "cspf_0_auto4530343993108001560", "cspf_0_auto10157211994742110522", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 1427.57, 7477.29, 3059.31 ), ( 0, 0, 0 ), "cspf_0_auto10157211994742110522", "cspf_0_auto12068557829798987029", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( 186.45, 7078.49, 3032.53 ), ( 0, 25, 0 ), "cspf_0_auto12068557829798987029", "cspf_0_auto6966296561924608248", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -881.27, 6113.96, 3012.79 ), ( 0, 25, 0 ), "cspf_0_auto6966296561924608248", "cspf_0_auto3067816741703411222", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -2497.37, 1392.87, 2567.44 ), ( 0, 165, 0 ), "cspf_0_auto3573594077247068617", "cspf_0_auto17271099106172781632", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -2680.06, 728.61, 2060.91 ), ( 0, 165, 0 ), "cspf_0_auto17271099106172781632", "cspf_0_auto14091297683829930583", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -2868.66, 174.54, 1403.83 ), ( 0, 165, 0 ), "cspf_0_auto14091297683829930583", "cspf_0_auto806598616963221743", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -2985.37, -63.98, 835 ), ( 0, 165, 0 ), "cspf_0_auto806598616963221743", "ee_ruby_rock_path_end", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "item";
    fe [[ f ]]( s, us, cf, ( 6816.9, 3519.83, 828 ), ( 338.71, 140.69, -15.35 ), "ee_ruby_path_item" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "flight_path";
    fe [[ f ]]( s, us, cf, ( -2043.25, 3074.3, 2948.22 ), ( 0, 25, 0 ), "cspf_0_auto3067816741703411222", "cspf_0_auto3573594077247068617", "ee_ruby_rock_path" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "turret";
    fe [[ f ]]( s, us, cf, ( -2882.96, 2.97, 58.43 ), ( 12.2, 333.87, -1.7 ), "ee_ruby_turret" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_turret_cs";
    s.name = "rock";
    fe [[ f ]]( s, us, cf, ( 6553.61, 175.99, 971.65 ), ( 59.1, 38.38, 154.4 ), "ee_ruby_rock_away" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_ee_turret_cs
// Params 0, eflags: 0x4
// Checksum 0xe8f4446c, Offset: 0xba9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_ee_turret_cs
// Params 0
// Checksum 0x1abdce37, Offset: 0xbb3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_ee_turret_cs" );
}

