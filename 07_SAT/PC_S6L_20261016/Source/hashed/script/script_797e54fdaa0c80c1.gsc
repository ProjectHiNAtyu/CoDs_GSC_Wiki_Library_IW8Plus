// script_797e54fdaa0c80c1  (hash_797e54fdaa0c80c1.gscc) (size: 3304 Bytes / 0xce8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4eb2ad9 (2766875353)
// size ...... 3304 (0xce8)
// includes .. 2   (offset: 0xb60)
// strings ... 21  (offset: 0xb70)
// dev strs .. 0   (offset: 0xce8)
// exports ... 6   (offset: 0x870)
// cseg ...... 0x2ff + 0x571 (0x870)
// imports ... 17  (offset: 0x960)
// animtree1 . 0   (offset: 0xce8)
// animtree2 . 0   (offset: 0xce8)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_c_ob_intel_cs;

// Namespace mp_jup_st_c_ob_intel_cs
// Params 2
// Checksum 0xe04f2601, Offset: 0x31d
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_c_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_c_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_intel_cs
// Params 3
// Checksum 0x1f704cc9, Offset: 0x395
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_c_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_c_ob_intel_cs" );
}

// Namespace mp_jup_st_c_ob_intel_cs
// Params 3
// Checksum 0x34d3c0ca, Offset: 0x40f
// Size: 0x441
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 32629.5, 36250, 1240.5 ), ( 0, 45, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_whothisguy" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 36961, 18882, 3834 ), ( 0, 307.63, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_byemom" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 25382, 32726.5, 2301 ), ( 0, 214.66, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_never_fear" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( 23351, 21726, 1532 ), ( 0, 178.1, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_illshowyou" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_c_subbase_warehouse_02";
    fe [[ f ]]( s, us, cf, ( 32014.9, 39906.5, 1216 ), ( 0, 185, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 32667.5, 26917, 1735 ), ( 0, 178.75, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_03" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_c_countdown_office_2s_01";
    fe [[ f ]]( s, us, cf, ( 35840.5, 29502.4, 1975.5 ), ( 0, 59.44, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_c_milbase_office_2s_02";
    fe [[ f ]]( s, us, cf, ( 32175.6, 30044.8, 1504.75 ), ( 4.03, 59.67, -0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_c_milbase_warehouse_01";
    fe [[ f ]]( s, us, cf, ( 24254.8, 34044.6, 1784.15 ), ( 0, 20.25, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_c_police_station_01_b";
    fe [[ f ]]( s, us, cf, ( 27751, 24056.5, 1619.68 ), ( 0, 80.91, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_c_ob_intel_cs
// Params 0
// Checksum 0xc4d2b9, Offset: 0x858
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_c_ob_intel_cs
// Params 0
// Checksum 0xdd239180, Offset: 0x862
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_c_ob_intel_cs" );
}

