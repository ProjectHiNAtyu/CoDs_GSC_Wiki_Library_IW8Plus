// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_script_exfil_cs.gsc  (hash_6918884eba5c9f31.gscc) (size: 5444 Bytes / 0x1544 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50e37977 (1357085047)
// size ...... 5444 (0x1544)
// includes .. 3   (offset: 0x1290)
// strings ... 24  (offset: 0x12a8)
// dev strs .. 0   (offset: 0x1544)
// exports ... 9   (offset: 0xed4)
// cseg ...... 0x2ce + 0xc06 (0xed4)
// imports ... 21  (offset: 0x103c)
// animtree1 . 0   (offset: 0x1544)
// animtree2 . 0   (offset: 0x1544)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_script_exfil_cs;

// Namespace zm_sat_ruby_script_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xab7c9916, Offset: 0x2ec
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_script_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x39f2352e, Offset: 0x30d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xbcc9e6c2, Offset: 0x31e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 2
// Checksum 0xc20b08b, Offset: 0x32f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_script_exfil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_script_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_script_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_script_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x3f4b520d, Offset: 0x3b7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_script_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_script_exfil_cs" );
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xd890a198, Offset: 0x431
// Size: 0xa83
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    s.script_int = int( 120 );
    s.script_label = "zombie_mangler_hvt";
    s.script_radius = int( 9000 );
    s.script_timer = int( 30 );
    fe [[ f ]]( s, us, cf, ( -847.9, -631.2, 838.86 ), ( 0, 0, 0 ), "zm_exfil", "cspf_0_auto3739756290037545803" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -450.79, 211.56, 260.24 ), ( 0, 186.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -897.24, 56.23, 309.75 ), ( 0, 278.89, 0 ), "cspf_0_auto1284933450841619039", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -477.39, 297.3, 373.03 ), ( 0, 186.04, 0 ), "cspf_0_auto1284933450841619039", "cspf_0_auto16911536170443586329", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -459.25, 288.92, 260.24 ), ( 0, 186.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -453.6, 246.8, 260.24 ), ( 0, 186.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -464.58, 326.4, 260.24 ), ( 0, 186.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    s.script_label = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( -930.17, 51.91, 250.73 ), ( 0, 6.11, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto1284933450841619039", "zone_mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -286.51, 52.04, 256 ), ( 0, 180.99, 0 ), "cspf_0_auto1284933450841619039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 321.32, -1772.63, 209.06 ), ( 0, 176.23, 0 ), "cspf_0_auto14746171007235199653" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -257.5, -213.5, 260 ), ( 0, 0, 0 ), "cspf_0_auto1284933450841619039", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 1786, -534, 14 ), ( 0, 0, 0 ), "cspf_0_auto14245463621199419736", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3540, -2357.5, -89 ), ( 0, 0, 0 ), "cspf_0_auto7500718595635598755", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4572.1, -41992.4, -13019.4 ), ( 0, 178.26, 0 ), "cspf_0_auto12524755734517130004" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3983.8, -41864.9, -12875.9 ), ( 0, 356.59, 0 ), "cspf_0_auto15252043018240326838", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4557.4, -41903.9, -12906.6 ), ( 0, 178.26, 0 ), "cspf_0_auto15252043018240326838", "cspf_0_auto12524755734517130004", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3958.49, -2603.05, 9.62 ), ( 0, 88.26, 0 ), "cspf_0_auto8198311460359964822" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4007.95, -1952.18, 64.1 ), ( 0, 80.59, 0 ), "cspf_0_auto7500718595635598755", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4047.05, -2588.3, 122.41 ), ( 0, 88.26, 0 ), "cspf_0_auto7500718595635598755", "cspf_0_auto8198311460359964822", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4036.29, -2605.14, 9.62 ), ( 0, 88.26, 0 ), "cspf_0_auto8198311460359964822" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3993.78, -2605.03, 9.62 ), ( 0, 88.26, 0 ), "cspf_0_auto8198311460359964822" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4074.14, -2604.93, 9.62 ), ( 0, 88.26, 0 ), "cspf_0_auto8198311460359964822" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    s.script_label = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( 4036.98, -1956.05, 4.59 ), ( 0, 172.8, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto7500718595635598755", "zone_telescope_pathway_upper" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3504.54, -2458.1, -99.81 ), ( 0, 70.71, 0 ), "cspf_0_auto7500718595635598755", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2412.23, -890.76, 13.01 ), ( 0, 65.6, 0 ), "cspf_0_auto6146475231540191292" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2089.61, -42.65, 105.4 ), ( 0, 194.38, 0 ), "cspf_0_auto14245463621199419736", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2499.63, -911.26, 125.8 ), ( 0, 65.6, 0 ), "cspf_0_auto14245463621199419736", "cspf_0_auto6146475231540191292", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2483.21, -922.65, 13.01 ), ( 0, 65.6, 0 ), "cspf_0_auto6146475231540191292" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2444.03, -906.19, 13.01 ), ( 0, 65.6, 0 ), "cspf_0_auto6146475231540191292" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2518.23, -937.04, 13.01 ), ( 0, 65.6, 0 ), "cspf_0_auto6146475231540191292" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    s.script_label = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( 2082.15, -10.29, 46.38 ), ( 0, 281.6, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto14245463621199419736", "zone_courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 1812.91, -572.45, 0.73 ), ( 0, 74.57, 0 ), "cspf_0_auto14245463621199419736", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4574.2, -41914.6, -13019.4 ), ( 0, 178.26, 0 ), "cspf_0_auto12524755734517130004" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4574.1, -41957.1, -13019.4 ), ( 0, 178.26, 0 ), "cspf_0_auto12524755734517130004" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4574, -41876.8, -13019.4 ), ( 0, 178.26, 0 ), "cspf_0_auto12524755734517130004" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    s.script_gameobjectname = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( 3954.1, -41866.2, -12932 ), ( 0, 358.8, 0 ), "cspf_0_auto3739756290037545803", "cspf_0_auto15252043018240326838", "zone_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4206.3, -41910.9, -12900.4 ), ( 0, 340.71, 0 ), "cspf_0_auto15252043018240326838", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 4123, -41924, -12928 ), ( 0, 0, 0 ), "cspf_0_auto15252043018240326838", undefined, "override_exfil_center" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x4ec2d413, Offset: 0xebc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_script_exfil_cs
// Params 0
// Checksum 0xfd188f40, Offset: 0xec6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_script_exfil_cs" );
}

