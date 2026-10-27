// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_nya_cs.gsc  (hash_35ed54fdb5439a9a.gscc) (size: 1577 Bytes / 0x629 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6af44cc (3333375180)
// size ...... 1577 (0x629)
// includes .. 2   (offset: 0x5ad)
// strings ... 6   (offset: 0x5bd)
// dev strs .. 0   (offset: 0x629)
// exports ... 6   (offset: 0x2fd)
// cseg ...... 0xba + 0x243 (0x2fd)
// imports ... 16  (offset: 0x3ed)
// animtree1 . 0   (offset: 0x629)
// animtree2 . 0   (offset: 0x629)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_nya_cs;

// Namespace zm_sat_hornet_ee_nya_cs
// Params 2
// Checksum 0x69b216cd, Offset: 0xd8
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_nya_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_nya_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_nya_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_nya_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_nya_cs
// Params 3, eflags: 0x4
// Checksum 0x5ad9f44b, Offset: 0x160
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_nya_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_nya_cs" );
}

// Namespace zm_sat_hornet_ee_nya_cs
// Params 3, eflags: 0x4
// Checksum 0x6660a9e5, Offset: 0x1da
// Size: 0x103
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_nya_cs";
    fe [[ f ]]( s, us, cf, ( 2275, -20474, 397.92 ), ( 359.76, 346.1, 0.94 ), "ny_nug_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_nya_cs";
    fe [[ f ]]( s, us, cf, ( 3170, -21050, 402 ), ( 349.4, 180, -4.1 ), "ny_tdr_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_nya_cs";
    fe [[ f ]]( s, us, cf, ( 2258, -20458, 397.92 ), ( 359.76, 256.1, 0.94 ), "ny_nug_pi_sp" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_nya_cs
// Params 0, eflags: 0x4
// Checksum 0x62ecea2c, Offset: 0x2e5
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_nya_cs
// Params 0
// Checksum 0x988a2906, Offset: 0x2ef
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_nya_cs" );
}

