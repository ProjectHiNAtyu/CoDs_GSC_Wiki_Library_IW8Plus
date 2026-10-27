// script_6d906c794395f895  (hash_6d906c794395f895.gscc) (size: 3283 Bytes / 0xcd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb19add9 (4212764121)
// size ...... 3283 (0xcd3)
// includes .. 2   (offset: 0xb4b)
// strings ... 21  (offset: 0xb5b)
// dev strs .. 0   (offset: 0xcd3)
// exports ... 6   (offset: 0x85b)
// cseg ...... 0x2ea + 0x571 (0x85b)
// imports ... 17  (offset: 0x94b)
// animtree1 . 0   (offset: 0xcd3)
// animtree2 . 0   (offset: 0xcd3)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_b_ob_intel_cs;

// Namespace mp_jup_st_b_ob_intel_cs
// Params 2
// Checksum 0x2c01d10f, Offset: 0x308
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_b_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_b_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_intel_cs
// Params 3
// Checksum 0xd33ebbc7, Offset: 0x380
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_b_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_b_ob_intel_cs" );
}

// Namespace mp_jup_st_b_ob_intel_cs
// Params 3
// Checksum 0xb9233607, Offset: 0x3fa
// Size: 0x441
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 1873.5, 23650, 1179 ), ( 0, 253.56, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_neverfun" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 878, 32838, 1465.5 ), ( 0, 359.32, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_imafed" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 4160, 28153.5, 1035.5 ), ( 0, 341.95, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_welcome" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_radio_intel";
    fe [[ f ]]( s, us, cf, ( -10560.5, 30022, 1216 ), ( 0, 165.72, 0 ), "terminus_radio_intel", undefined, "intel_s0_terminus_radio_whatdoyou" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_b_office_lg_01";
    fe [[ f ]]( s, us, cf, ( 7848.92, 24942.2, 1198 ), ( 0, 343.03, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 11468.5, 36037.5, 1345 ), ( 0, 176.26, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_02" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_b_coalplant_office_02";
    fe [[ f ]]( s, us, cf, ( -8485.59, 35103.4, 1452.8 ), ( 0.99, 84.1, -0.1 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_b_store_abandoned_md_01";
    fe [[ f ]]( s, us, cf, ( -9188.75, 19172.2, 1672 ), ( 0.36, 90.1, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_b_factory_md_3s_01";
    fe [[ f ]]( s, us, cf, ( 5812.57, 31310.2, 1408.6 ), ( 0.73, 346.2, -0.24 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_b_station_house_01_a";
    fe [[ f ]]( s, us, cf, ( 10766.2, 36134.7, 1486.62 ), ( 1, 85.8, -0.07 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_b_ob_intel_cs
// Params 0
// Checksum 0x111cfc32, Offset: 0x843
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_b_ob_intel_cs
// Params 0
// Checksum 0x116d668e, Offset: 0x84d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_b_ob_intel_cs" );
}

