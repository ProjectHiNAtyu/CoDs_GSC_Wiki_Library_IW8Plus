// scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_relay_antenna_cs.gsc  (hash_5eb02441641c005e.gscc) (size: 1789 Bytes / 0x6fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8429f24f (2217341519)
// size ...... 1789 (0x6fd)
// includes .. 2   (offset: 0x659)
// strings ... 9   (offset: 0x669)
// dev strs .. 0   (offset: 0x6fd)
// exports ... 6   (offset: 0x3a9)
// cseg ...... 0x128 + 0x281 (0x3a9)
// imports ... 16  (offset: 0x499)
// animtree1 . 0   (offset: 0x6fd)
// animtree2 . 0   (offset: 0x6fd)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_mechanics_relay_antenna_cs;

// Namespace mp_saw_mechanics_relay_antenna_cs
// Params 2
// Checksum 0x124117dc, Offset: 0x146
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_mechanics_relay_antenna_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_mechanics_relay_antenna_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_mechanics_relay_antenna_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_mechanics_relay_antenna_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_mechanics_relay_antenna_cs
// Params 3, eflags: 0x4
// Checksum 0x212af55a, Offset: 0x1ce
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_mechanics_relay_antenna_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_mechanics_relay_antenna_cs" );
}

// Namespace mp_saw_mechanics_relay_antenna_cs
// Params 3, eflags: 0x4
// Checksum 0x95ed163c, Offset: 0x248
// Size: 0x141
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_relay_antenna_cs";
    s.activity_bundle = "saw_bongo_activity_relay_antenna";
    s.name = "mp_dev_location_1_relay_antenna";
    fe [[ f ]]( s, us, cf, ( 192, 1088, -512 ), ( 0, 0, 0 ), "activity_nexus_variant", "mp_dev_location_1_relay_antenna", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_relay_antenna_cs";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 64, 1088, -512 ), ( 0, 0, 0 ), "mp_dev_location_1_relay_antenna", undefined, "beacon", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_mechanics_relay_antenna_cs
// Params 0, eflags: 0x4
// Checksum 0xc4b48560, Offset: 0x391
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_mechanics_relay_antenna_cs
// Params 0
// Checksum 0xe3792817, Offset: 0x39b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_mechanics_relay_antenna_cs" );
}

