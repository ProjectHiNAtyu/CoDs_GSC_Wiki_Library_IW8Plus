// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ee_golf_powerup_cs.gsc  (hash_27d1b5451dbe09cb.gscc) (size: 3962 Bytes / 0xf7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4aec48de (1256999134)
// size ...... 3962 (0xf7a)
// includes .. 3   (offset: 0xdc6)
// strings ... 10  (offset: 0xdde)
// dev strs .. 0   (offset: 0xf7a)
// exports ... 9   (offset: 0xa2e)
// cseg ...... 0x147 + 0x8e7 (0xa2e)
// imports ... 20  (offset: 0xb96)
// animtree1 . 0   (offset: 0xf7a)
// animtree2 . 0   (offset: 0xf7a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_ee_golf_powerup_cs;

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 0, eflags: 0x5
// Checksum 0x165d56c4, Offset: 0x165
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_ee_golf_powerup_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 0, eflags: 0x4
// Checksum 0x86e79f3e, Offset: 0x186
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 0, eflags: 0x4
// Checksum 0x3dc4cd2, Offset: 0x197
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 2
// Checksum 0xb3351a9b, Offset: 0x1a8
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_ee_golf_powerup_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_ee_golf_powerup_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_ee_golf_powerup_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_ee_golf_powerup_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 3, eflags: 0x4
// Checksum 0x805ef81d, Offset: 0x230
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_ee_golf_powerup_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_ee_golf_powerup_cs" );
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 3, eflags: 0x4
// Checksum 0x5135a0e7, Offset: 0x2aa
// Size: 0x764
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_pos";
    fe [[ f ]]( s, us, cf, ( 79709, -32279.5, -186 ), ( 0, 0, 0 ), undefined, "cspf_0_auto12910339013484203139", "hole_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_pos";
    fe [[ f ]]( s, us, cf, ( 79766.2, -32162.8, -186 ), ( 0, 0, 0 ), undefined, "cspf_0_auto508069745159863413", "hole_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_pos";
    fe [[ f ]]( s, us, cf, ( 79725.2, -32154.3, -186 ), ( 0, 0, 0 ), undefined, "cspf_0_auto17147826837053442029", "hole_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_origin";
    fe [[ f ]]( s, us, cf, ( 79709, -32279.2, -129 ), ( 0, 0, 0 ), "cspf_0_auto12910339013484203139", undefined, "hole_origin", undefined, undefined, undefined, undefined, 2 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_origin";
    fe [[ f ]]( s, us, cf, ( 79637.5, -32338.8, -129 ), ( 0, 0, 0 ), "cspf_0_auto19598203080703122", undefined, "hole_origin", undefined, undefined, undefined, undefined, 2 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_origin";
    fe [[ f ]]( s, us, cf, ( 79725.2, -32154.2, -129 ), ( 0, 0, 0 ), "cspf_0_auto17147826837053442029", undefined, "hole_origin", undefined, undefined, undefined, undefined, 2 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_origin";
    fe [[ f ]]( s, us, cf, ( 79766.2, -32162.8, -129 ), ( 0, 0, 0 ), "cspf_0_auto508069745159863413", undefined, "hole_origin", undefined, undefined, undefined, undefined, 2 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79743.2, -32166, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79693.2, -32268, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79647.2, -32322, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79596, -32393, -126.56 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79607.2, -32414, -126.75 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79630.7, -32408.5, -126.85 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79617.2, -32352, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79624.2, -32299, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79758.2, -32227, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79729.2, -32134, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79782.2, -32152, -124 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79775.2, -32117, -126.56 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79693.2, -32305, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "ball_pos";
    fe [[ f ]]( s, us, cf, ( 79666.2, -32216, -126 ), ( 0, 0, 0 ), undefined, undefined, "ball_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ee_golf_powerup_cs";
    s.name = "hole_pos";
    fe [[ f ]]( s, us, cf, ( 79637.5, -32339, -186 ), ( 0, 0, 0 ), undefined, "cspf_0_auto19598203080703122", "hole_pos" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 0, eflags: 0x4
// Checksum 0x69000ef7, Offset: 0xa16
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_ee_golf_powerup_cs
// Params 0
// Checksum 0x420d2550, Offset: 0xa20
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_ee_golf_powerup_cs" );
}

