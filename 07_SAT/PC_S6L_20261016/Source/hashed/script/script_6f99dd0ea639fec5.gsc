// script_6f99dd0ea639fec5  (hash_6f99dd0ea639fec5.gscc) (size: 4293 Bytes / 0x10c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae9eaec3 (2929635011)
// size ...... 4293 (0x10c5)
// includes .. 2   (offset: 0xea1)
// strings ... 27  (offset: 0xeb1)
// dev strs .. 0   (offset: 0x10c5)
// exports ... 6   (offset: 0xb99)
// cseg ...... 0x3c9 + 0x7d0 (0xb99)
// imports ... 17  (offset: 0xc89)
// animtree1 . 0   (offset: 0x10c5)
// animtree2 . 0   (offset: 0x10c5)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_e_ob_intel_cs;

// Namespace mp_jup_st_e_ob_intel_cs
// Params 2
// Checksum 0x4d180946, Offset: 0x3e7
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_e_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_e_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_intel_cs
// Params 3
// Checksum 0xb227638e, Offset: 0x45f
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_e_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_e_ob_intel_cs" );
}

// Namespace mp_jup_st_e_ob_intel_cs
// Params 3
// Checksum 0x9babb011, Offset: 0x4d9
// Size: 0x6a0
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -6966, -5509, 2186 ), ( 0, 285.79, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_hereagain" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 19282, -8022, 2423.5 ), ( 0, 45.07, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_oldschool" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 6296, -5541.5, 3094 ), ( 0, 210, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_megabomb" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 22443.5, -1908, 2385.5 ), ( 18.03, 318.48, 59.65 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_disciple" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 6232.5, 9922, 1490.5 ), ( 0, 18.17, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_05" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_radio_intel";
    fe [[ f ]]( s, us, cf, ( 1928, 4416, 2050.5 ), ( 89.17, 167.41, 173.21 ), "terminus_radio_intel", undefined, "intel_s0_terminus_radio_fletscareme" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_radio_intel";
    fe [[ f ]]( s, us, cf, ( 11769, 275, 1666 ), ( 0, 208.67, 0 ), "terminus_radio_intel", undefined, "intel_s0_terminus_radio_fletinspire" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 12038, -9614, 1816 ), ( 0, 348.02, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_06" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( -6791, 8436.5, 2567 ), ( 0, 187.83, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_chaosdown" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_warehouse_ind_02";
    fe [[ f ]]( s, us, cf, ( -8151.39, 7864.26, 1100.09 ), ( 0, 344.21, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_office_lg_02";
    fe [[ f ]]( s, us, cf, ( -13849.3, 11792, 1449 ), ( 0, 209.65, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_office_md_02";
    fe [[ f ]]( s, us, cf, ( -17546.6, 4379.88, 1447.81 ), ( 0, 182.63, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_18";
    fe [[ f ]]( s, us, cf, ( 20277.9, -1939.11, 2188.82 ), ( 0, 257.63, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_15_b";
    fe [[ f ]]( s, us, cf, ( 20612.8, 988, 2226.5 ), ( 0, 118.31, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_10";
    fe [[ f ]]( s, us, cf, ( 21735.2, -4873.75, 2423.22 ), ( 0, 359.43, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_19";
    fe [[ f ]]( s, us, cf, ( 18195.3, -2872.82, 1994.93 ), ( 0, 251.89, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_e_ob_intel_cs
// Params 0
// Checksum 0xd762223, Offset: 0xb81
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_e_ob_intel_cs
// Params 0
// Checksum 0x7074bec7, Offset: 0xb8b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_e_ob_intel_cs" );
}

