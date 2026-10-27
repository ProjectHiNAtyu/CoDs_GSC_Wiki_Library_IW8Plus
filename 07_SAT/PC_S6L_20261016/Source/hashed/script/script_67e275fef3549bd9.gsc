// script_67e275fef3549bd9  (hash_67e275fef3549bd9.gscc) (size: 3815 Bytes / 0xee7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbc0bb53 (3686841171)
// size ...... 3815 (0xee7)
// includes .. 2   (offset: 0xd17)
// strings ... 24  (offset: 0xd27)
// dev strs .. 0   (offset: 0xee7)
// exports ... 6   (offset: 0xa1b)
// cseg ...... 0x37e + 0x69d (0xa1b)
// imports ... 17  (offset: 0xb0b)
// animtree1 . 0   (offset: 0xee7)
// animtree2 . 0   (offset: 0xee7)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_g_ob_intel_cs;

// Namespace mp_jup_st_g_ob_intel_cs
// Params 2
// Checksum 0x94f9752b, Offset: 0x39c
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_g_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_g_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_intel_cs
// Params 3
// Checksum 0x6bc61fe3, Offset: 0x414
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_g_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_g_ob_intel_cs" );
}

// Namespace mp_jup_st_g_ob_intel_cs
// Params 3
// Checksum 0x8e9d7945, Offset: 0x48e
// Size: 0x56d
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -12268.5, -37391, 2541.5 ), ( 0, 289.46, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_imokay" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -6028, -26034, 2912.5 ), ( 0, 211.35, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_mobilearmor" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( -6138.5, -32672.5, 2277.5 ), ( 0, 214, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_hellhound" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_car_dealership_01";
    fe [[ f ]]( s, us, cf, ( -10597, -12182.6, 1919.02 ), ( 0, 222.31, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_university_building_01";
    fe [[ f ]]( s, us, cf, ( -12732, -40048.9, 2641.52 ), ( 0, 19.75, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( -22547, -42373, 3061 ), ( 0, 74.42, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_opportunity" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( -23365, -26490.5, 1756 ), ( 0, 258.78, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_07" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_clinic_01";
    fe [[ f ]]( s, us, cf, ( -14881.4, -42233.8, 3181.58 ), ( 0, 108.16, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_apartment_02";
    fe [[ f ]]( s, us, cf, ( -5909.61, -12987.4, 2022.11 ), ( 0, 226.74, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_apartment_21";
    fe [[ f ]]( s, us, cf, ( -2237.79, -19755.1, 1883.97 ), ( 0, 54.28, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_restaurant_02";
    fe [[ f ]]( s, us, cf, ( -6929.32, -18226.2, 1901.66 ), ( 0, 54.08, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_station_house_01";
    fe [[ f ]]( s, us, cf, ( -28011.7, -15103.5, 1748.88 ), ( 0, 253.37, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_g_apartment_18";
    fe [[ f ]]( s, us, cf, ( -18730.3, -31277.2, 2226.05 ), ( 0, 270.83, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_g_ob_intel_cs
// Params 0
// Checksum 0xb4cbeb05, Offset: 0xa03
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_g_ob_intel_cs
// Params 0
// Checksum 0xa995c2aa, Offset: 0xa0d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_g_ob_intel_cs" );
}

