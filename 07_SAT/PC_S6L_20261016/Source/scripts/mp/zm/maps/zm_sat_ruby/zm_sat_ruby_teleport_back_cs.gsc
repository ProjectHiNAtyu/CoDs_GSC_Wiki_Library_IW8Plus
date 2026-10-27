// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_teleport_back_cs.gsc  (hash_2b5bd5cf069cecbe.gscc) (size: 3422 Bytes / 0xd5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee7e7ee1 (4001267425)
// size ...... 3422 (0xd5e)
// includes .. 3   (offset: 0xc16)
// strings ... 9   (offset: 0xc2e)
// dev strs .. 0   (offset: 0xd5e)
// exports ... 9   (offset: 0x87e)
// cseg ...... 0x158 + 0x726 (0x87e)
// imports ... 20  (offset: 0x9e6)
// animtree1 . 0   (offset: 0xd5e)
// animtree2 . 0   (offset: 0xd5e)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_teleport_back_cs;

// Namespace zm_sat_ruby_teleport_back_cs
// Params 0, eflags: 0x5
// Checksum 0xd97e24cb, Offset: 0x176
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_teleport_back_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0xd8619b24, Offset: 0x197
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0x5d5a48c8, Offset: 0x1a8
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 2
// Checksum 0xedb31e81, Offset: 0x1b9
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_teleport_back_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_teleport_back_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_teleport_back_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_teleport_back_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 3, eflags: 0x4
// Checksum 0xded8fc07, Offset: 0x241
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_teleport_back_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_teleport_back_cs" );
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 3, eflags: 0x4
// Checksum 0xed5981dd, Offset: 0x2bb
// Size: 0x5a3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4476, 701.5, 47 ), ( 0, 0, 0 ), "cspf_0_auto14943191313276647055", "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3839, 819, -43 ), ( 0, 247.56, 0 ), "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4265, 499.5, 278.5 ), ( 0, 0, 0 ), "teleport_back_pos", "cspf_0_auto14943191313276647055" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4395.86, 744.5, -41 ), ( 0, 229.42, 0 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4491, 630, -41 ), ( 0, 229.42, 0 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4471, 197.5, 94 ), ( 0, 0, 0 ), "cspf_0_auto14943191313276647055", "cspf_0_auto7468209785617022851" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3968, 777, -43 ), ( 0, 239.75, 0 ), "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3832.5, 811, 163 ), ( 0, 0, 0 ), "cspf_0_auto14943191313276647055", "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3628.5, 945, -112.5 ), ( 0, 0, 0 ), "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3559, 1128, -162.5 ), ( 0, 210.23, 0 ), "cspf_0_auto12717703240842136290" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3488.5, 1236.5, -110.5 ), ( 0, 0, 0 ), "cspf_0_auto14943191313276647055", "cspf_0_auto12717703240842136290" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3468.5, 1294, -164.5 ), ( 0, 224.35, 0 ), "cspf_0_auto12717703240842136290" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3305, 1396, -164.5 ), ( 0, 237.74, 0 ), "cspf_0_auto12717703240842136290" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4449.09, 658.97, -41 ), ( 0, 229.42, 0 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4489.17, 115.22, -42 ), ( 0, 188.65, 0 ), "cspf_0_auto7468209785617022851" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4356.83, 237.21, -42 ), ( 0, 188.65, 0 ), "cspf_0_auto7468209785617022851" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4420.47, 174.57, -42 ), ( 0, 188.65, 0 ), "cspf_0_auto7468209785617022851" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4475.5, 188.5, -42 ), ( 0, 188.65, 0 ), "cspf_0_auto7468209785617022851" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 4406.13, 682.59, -41 ), ( 0, 229.42, 0 ), "cspf_0_auto12838885354152493914" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3904, 820, -43 ), ( 0, 259.77, 0 ), "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3783.5, 828.5, -43 ), ( 0, 252.58, 0 ), "cspf_0_auto18316205288097584319" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_teleport_back_cs";
    fe [[ f ]]( s, us, cf, ( 3376.5, 1361.5, -164.5 ), ( 0, 232.35, 0 ), "cspf_0_auto12717703240842136290" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 0, eflags: 0x4
// Checksum 0x41c7cae6, Offset: 0x866
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_teleport_back_cs
// Params 0
// Checksum 0x1c8b214a, Offset: 0x870
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_teleport_back_cs" );
}

