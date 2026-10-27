// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_slorpy_quest_cs.gsc  (hash_28eae427f0849abd.gscc) (size: 5090 Bytes / 0x13e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6cfecce (2798644430)
// size ...... 5090 (0x13e2)
// includes .. 3   (offset: 0x113e)
// strings ... 37  (offset: 0x1156)
// dev strs .. 0   (offset: 0x13e2)
// exports ... 9   (offset: 0xda6)
// cseg ...... 0x404 + 0x9a2 (0xda6)
// imports ... 20  (offset: 0xf0e)
// animtree1 . 0   (offset: 0x13e2)
// animtree2 . 0   (offset: 0x13e2)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_slorpy_quest_cs;

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 0, eflags: 0x5
// Checksum 0x987effb, Offset: 0x422
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_slorpy_quest_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x8e3607ca, Offset: 0x443
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xb0dd426, Offset: 0x454
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 2
// Checksum 0xbbe4826f, Offset: 0x465
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_slorpy_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_slorpy_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_slorpy_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_slorpy_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x888f60e9, Offset: 0x4ed
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_slorpy_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_slorpy_quest_cs" );
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x7e2bf58b, Offset: 0x567
// Size: 0x81f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -11880, 3288, 558 ), ( 0, 36, 0 ), "sq_slorpy_sugar_locs", "cspf_0_auto9649763636323323190" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -11899, 3434, 528 ), ( 0, 39.3, 0 ), "cspf_0_auto9649763636323323190" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -12032, 3046, 521.5 ), ( 0, 30.84, 0 ), "cspf_0_auto7374838430879181787" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13401, -4274, 587.78 ), ( 0, 218, 0 ), "cspf_0_auto148800386979007356" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13307, -4358, 666 ), ( 0, 0, 0 ), "sq_slorpy_old_milk_locs", "cspf_0_auto148800386979007356" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.is_cs_model = 1;
    s.model = "t10_zm_soda_fountain_fxanim";
    s.var_4a62bf732f3923cb = "1";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -12017, 3433, 528 ), ( 0, 306, 0 ), undefined, undefined, "slorpy_soda_fountain" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 23599.1, 1758.46, 437.84 ), ( 0, 182, -6.3 ), "cspf_0_auto9380137909858228205" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -12218, 3192, 542 ), ( 0, 254, 0 ), "sq_slorpy_eggs_locs", "cspf_0_auto7374838430879181787" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 24042, 424, 488 ), ( 0, 0, 0 ), "sq_slorpy_weeds_locs", "cspf_0_auto9380137909858228205" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "zone_sunken_shops_mercantile";
    fe [[ f ]]( s, us, cf, ( 3120, -2627, 638 ), ( 0, 0, 0 ), "sq_slorpy_peppers_locs", "cspf_0_auto772032313307009444", "trace" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3288.26, -2832.01, 415 ), ( 0, 0, -10 ), "cspf_0_auto772032313307009444" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -13635.2, 3663.39, 423.01 ), ( 0, 93, 0 ), "cspf_0_auto12830905111917526354" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -13721, 3638, 490 ), ( 0, 0, 0 ), "sq_slorpy_gas_locs", "cspf_0_auto12830905111917526354" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13718, -2986, 690 ), ( 0, 0, 0 ), "sq_slorpy_lemons_locs", "cspf_0_auto13819607035427896239" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13298.5, -3247.53, 523.78 ), ( 0, 144.16, 0 ), "cspf_0_auto13819607035427896239" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3945, -2918, 408 ), ( 0, 0, 0 ), "sq_slorpy_beans_locs", "cspf_0_auto6892498903224473884" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3559.9, -2977.06, 440.27 ), ( 358.04, 102.98, 1.88 ), "cspf_0_auto6892498903224473884" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13862, 2678, 1138 ), ( 0, 0, 0 ), "sq_slorpy_fish_locs", "cspf_0_auto4363289160788302798" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13812.7, 3364.72, 920.49 ), ( 0, 325.42, 0 ), "cspf_0_auto4363289160788302798" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -6708, -6038, 1642 ), ( 0, 0, 0 ), "sq_slorpy_stim_locs", "cspf_0_auto11697914901498093457" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( -6689, -6344, 1617 ), ( 90, 348.17, 123.82 ), "cspf_0_auto11697914901498093457" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "zone_janus_warehouse";
    fe [[ f ]]( s, us, cf, ( 23026.2, -294, 454.5 ), ( 0, 0, 0 ), "sq_slorpy_toliet_cleaner_locs", "cspf_0_auto608591258601452558" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 23094, -216, 484 ), ( 351.37, 0, 0 ), "cspf_0_auto608591258601452558" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 13190.5, 951.25, 1081 ), ( 0, 0, 0 ), "sq_slorpy_berries_locs", "cspf_0_auto12324314408957982032" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    fe [[ f ]]( s, us, cf, ( 15258.7, 1398.87, 824.07 ), ( 357.92, 334.01, -2.35 ), "cspf_0_auto12324314408957982032" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "2";
    fe [[ f ]]( s, us, cf, ( -12015, 3421, 533 ), ( 0, 308.12, 0 ), "sq_slorpy_cup_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( -12023, 3415, 533 ), ( 0, 308.12, 0 ), "sq_slorpy_cup_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "4";
    fe [[ f ]]( s, us, cf, ( -11998, 3434, 533 ), ( 0, 308.12, 0 ), "sq_slorpy_cup_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_slorpy_quest_cs";
    s.script_parameters = "3";
    fe [[ f ]]( s, us, cf, ( -12006, 3428, 533 ), ( 0, 308.12, 0 ), "sq_slorpy_cup_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x6057e092, Offset: 0xd8e
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_slorpy_quest_cs
// Params 0
// Checksum 0x4adcbda4, Offset: 0xd98
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_slorpy_quest_cs" );
}

