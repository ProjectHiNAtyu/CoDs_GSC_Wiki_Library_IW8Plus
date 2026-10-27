// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_rocker_cs.gsc  (hash_26743708e5b804a4.gscc) (size: 9329 Bytes / 0x2471 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x521d199d (1377638813)
// size ...... 9329 (0x2471)
// includes .. 2   (offset: 0x1e95)
// strings ... 68  (offset: 0x1ea5)
// dev strs .. 0   (offset: 0x2471)
// exports ... 6   (offset: 0x1be5)
// cseg ...... 0x827 + 0x13be (0x1be5)
// imports ... 16  (offset: 0x1cd5)
// animtree1 . 0   (offset: 0x2471)
// animtree2 . 0   (offset: 0x2471)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_rocker_cs;

// Namespace zm_sat_hornet_ee_rocker_cs
// Params 2
// Checksum 0x69e816b2, Offset: 0x845
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_rocker_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_rocker_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_rocker_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_rocker_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_rocker_cs
// Params 3, eflags: 0x4
// Checksum 0x5a83f434, Offset: 0x8cd
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_rocker_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_rocker_cs" );
}

// Namespace zm_sat_hornet_ee_rocker_cs
// Params 3, eflags: 0x4
// Checksum 0x4915b7c3, Offset: 0x947
// Size: 0x127e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 1942, -24059, 36 ), ( 0, 335, 0 ), "cspf_0_auto9169697828331088736", "cspf_0_auto7952063319404501197" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 2266, -24369, 30 ), ( 0, 344.8, 0 ), "cspf_0_auto7952063319404501197", "cspf_0_auto12556993853962879168" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 2688, -24431, 42 ), ( 0, 0, 0 ), "cspf_0_auto12556993853962879168", "cspf_0_auto8296040667828643877" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 3252, -24351, 34 ), ( 0, 23.1, 0 ), "cspf_0_auto8296040667828643877", "cspf_0_auto18147344362479389378" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 3672, -24139, 32 ), ( 0, 48, 0 ), "cspf_0_auto18147344362479389378", "cspf_0_auto13974465501636799549" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 3893, -23639, 18.44 ), ( 0, 72, 0 ), "cspf_0_auto13974465501636799549" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2348, -22223, 104.31 ), ( 0, 265, 0 ), "cspf_0_auto4925580232925708583", "cspf_0_auto9811134563469429501" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2404, -22044, 123.49 ), ( 0, 270, 0 ), "rkr_sta", "cspf_0_auto4925580232925708583", "rkr_lg_in" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2327, -22485, 69.76 ), ( 0, 290, 0 ), "cspf_0_auto9811134563469429501", "cspf_0_auto3878307340790081772" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2519, -22676, 29 ), ( 0, 270, 0 ), "cspf_0_auto3878307340790081772", "cspf_0_auto2434246750023707053" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2535, -22932, 30.83 ), ( 0, 285, 0 ), "cspf_0_auto2434246750023707053", "cspf_0_auto5999625992071034117" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3665, -21832, 34 ), ( 0, 270, 0 ), "cspf_0_auto4287769302431192706", "cspf_0_auto11092788793802467297" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2646, -23132, 44.61 ), ( 0, 270, 0 ), "cspf_0_auto5999625992071034117", "cspf_0_auto10461094769337080481" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2741, -23470, 47.92 ), ( 0, 285, 0 ), "cspf_0_auto10461094769337080481", "cspf_0_auto16880483104355608757" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2714, -23867, 41 ), ( 0, 270, 0 ), "cspf_0_auto16880483104355608757", "cspf_0_auto9255769585061877144" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3722, -22241, 12.6 ), ( 0, 270, 0 ), "rkr_sta", "cspf_0_auto4287769302431192706", "rkr_bt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2732, -24217, 4 ), ( 0, 270, 0 ), "cspf_0_auto9255769585061877144", "cspf_0_auto10593667092861533307" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 2849, -24367, 32 ), ( 0, 0, 0 ), "cspf_0_auto10593667092861533307", "cspf_0_auto3361872118546453103" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 3082, -24330, 33 ), ( 0, 0, 0 ), "cspf_0_auto3361872118546453103", "cspf_0_auto2461414569162713299" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 3491, -24153, 34 ), ( 0, 0, 0 ), "cspf_0_auto2461414569162713299", "cspf_0_auto1835853558713887684" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 3709, -24000, 32 ), ( 0, 90, 0 ), "cspf_0_auto1835853558713887684", "cspf_0_auto4581987089775595364" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 3793, -23654, 47 ), ( 0, 90, 0 ), "cspf_0_auto4581987089775595364", "cspf_0_auto10736896268275641390" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_in";
    fe [[ f ]]( s, us, cf, ( 3699, -23326, 8.41 ), ( 0, 90, 0 ), "cspf_0_auto10736896268275641390" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3422, -21700, 35 ), ( 0, 270, 0 ), "cspf_0_auto11092788793802467297", "cspf_0_auto13311947736636458952" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3386, -21468, 34 ), ( 0, 270, 0 ), "cspf_0_auto13311947736636458952", "cspf_0_auto2604550030812008375" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3380, -21209, 34 ), ( 0, 270, 0 ), "cspf_0_auto2604550030812008375", "cspf_0_auto3490973444338985116" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3046, -21067, 34 ), ( 0, 270, 0 ), "cspf_0_auto3490973444338985116", "cspf_0_auto3634349741428465642" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -2832, -20864, 34 ), ( 0, 270, 0 ), "cspf_0_auto3634349741428465642", "cspf_0_auto6484764753729144198" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -3074, -20381, 38 ), ( 0, 270, 0 ), "cspf_0_auto6484764753729144198", "cspf_0_auto12884744238558586563" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 1855, -23998, 40 ), ( 0, 0, 0 ), "cspf_0_auto14445360658339969961", "cspf_0_auto9537634546090536382" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1603, -22706, 49.04 ), ( 0, 312, 0 ), "cspf_0_auto9933801413963882252", "cspf_0_auto423731715410555781" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1608, -22391, 101.79 ), ( 0, 270, 0 ), "rkr_sta", "cspf_0_auto3789760467400409297", "rkr_tb" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1573, -22841, 123.19 ), ( 0, 308, 0 ), "cspf_0_auto423731715410555781", "cspf_0_auto13748629571040748216" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1687, -22637, 123.65 ), ( 0, 282, 0 ), "cspf_0_auto3789760467400409297", "cspf_0_auto9933801413963882252" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1503, -23004, 122.04 ), ( 0, 288, 0 ), "cspf_0_auto13748629571040748216", "cspf_0_auto2043142882866322128" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1426, -23209, 119.04 ), ( 0, 319, 0 ), "cspf_0_auto2043142882866322128", "cspf_0_auto9681871370083932883" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1276, -23372, 124.85 ), ( 0, 274, 0 ), "cspf_0_auto9681871370083932883", "cspf_0_auto10387238673934951125" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1274, -23466, 101.04 ), ( 0, 270, 0 ), "cspf_0_auto10387238673934951125", "cspf_0_auto9099518455951043728" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tb";
    fe [[ f ]]( s, us, cf, ( -1236, -23530, 50.72 ), ( 0, 270, 0 ), "cspf_0_auto9099518455951043728" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2682, -20424, 358.74 ), ( 0, 270, 0 ), "cspf_0_auto17773177046125942690", "cspf_0_auto6130363179426900000" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2715, -20416, 348.69 ), ( 0, 270, 0 ), "rkr_sta", "cspf_0_auto17773177046125942690", "rkr_sb" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2651, -20557, 373.25 ), ( 0, 270, 0 ), "cspf_0_auto6130363179426900000", "cspf_0_auto3392056795568967167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2654, -20725, 372.64 ), ( 0, 270, 0 ), "cspf_0_auto3392056795568967167", "cspf_0_auto18213366341646624633" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2554, -20845, 354.13 ), ( 0, 270, 0 ), "cspf_0_auto18213366341646624633", "cspf_0_auto14348664735625050786" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2516, -21008, 373 ), ( 0, 238, 0 ), "cspf_0_auto14348664735625050786", "cspf_0_auto2652028020349580753" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2355, -21144, 376 ), ( 0, 222, 0 ), "cspf_0_auto2652028020349580753", "cspf_0_auto86788661444014002" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2237, -21254, 371 ), ( 0, 240, 0 ), "cspf_0_auto86788661444014002", "cspf_0_auto3272213639094023811" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_sb";
    fe [[ f ]]( s, us, cf, ( 2169, -21356, 347.98 ), ( 0, 258, 0 ), "cspf_0_auto3272213639094023811" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -2998, -19928, 41 ), ( 0, 270, 0 ), "cspf_0_auto12884744238558586563", "cspf_0_auto4224390965995616504" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_bt";
    fe [[ f ]]( s, us, cf, ( -2988, -19831, 12 ), ( 0, 270, 0 ), "cspf_0_auto4224390965995616504", "cspf_0_auto12124439216190379920" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 2010, -24130, 40 ), ( 0, 0, 0 ), "cspf_0_auto9537634546090536382", "cspf_0_auto18234872639193308286" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 2202, -24240, 40 ), ( 0, 0, 0 ), "cspf_0_auto18234872639193308286", "cspf_0_auto16996524834745195230" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 2258, -24227, 41 ), ( 323.96, 61.83, -33.56 ), "cspf_0_auto11088760831081267246", "cspf_0_auto1158175929409041160" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_lg_out";
    fe [[ f ]]( s, us, cf, ( 1742, -23881, 12.99 ), ( 0, 0, 0 ), "rkr_sta", "cspf_0_auto9169697828331088736", "rkr_lg_out" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 1687, -23804, 24.99 ), ( 0, 0, 0 ), "rkr_sta", "cspf_0_auto14445360658339969961", "rkr_tors" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_rocker_cs";
    s.groupid = "path_tors";
    fe [[ f ]]( s, us, cf, ( 2233, -24238, 37 ), ( 0, 0, 0 ), "cspf_0_auto16996524834745195230", "cspf_0_auto11088760831081267246" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_rocker_cs
// Params 0, eflags: 0x4
// Checksum 0x6aacebd4, Offset: 0x1bcd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_rocker_cs
// Params 0
// Checksum 0x98d02979, Offset: 0x1bd7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_rocker_cs" );
}

