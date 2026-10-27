// script_903065977591c95  (hash_0903065977591c95.gscc) (size: 3287 Bytes / 0xcd7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32402eb7 (843067063)
// size ...... 3287 (0xcd7)
// includes .. 2   (offset: 0xb5f)
// strings ... 20  (offset: 0xb6f)
// dev strs .. 0   (offset: 0xcd7)
// exports ... 6   (offset: 0x86f)
// cseg ...... 0x30a + 0x565 (0x86f)
// imports ... 17  (offset: 0x95f)
// animtree1 . 0   (offset: 0xcd7)
// animtree2 . 0   (offset: 0xcd7)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_f_ob_intel_cs;

// Namespace mp_jup_st_f_ob_intel_cs
// Params 2
// Checksum 0xdac1f785, Offset: 0x328
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_f_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_f_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_intel_cs
// Params 3
// Checksum 0x25fe9d4d, Offset: 0x3a0
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_f_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_f_ob_intel_cs" );
}

// Namespace mp_jup_st_f_ob_intel_cs
// Params 3
// Checksum 0xaaeb9727, Offset: 0x41a
// Size: 0x435
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 42962.5, -7993.5, 3112 ), ( 0, 267, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_taomangler" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( 27103.5, -1930, 2689.15 ), ( 0, 327.94, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_beginning" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 32493, -12022, 2965 ), ( 0, 191.8, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_10" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_shop_md_01";
    fe [[ f ]]( s, us, cf, ( 34644.8, 917.58, 2554.04 ), ( 0, 0.29, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_packing_building_01";
    fe [[ f ]]( s, us, cf, ( 42411.7, -4171.42, 3176 ), ( 0, 270.29, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_06_abandoned";
    fe [[ f ]]( s, us, cf, ( 41247, 14662.3, 3413.52 ), ( 0, 321.37, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_06";
    fe [[ f ]]( s, us, cf, ( 28186.5, 10412.5, 2112 ), ( 0, 141.37, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_2s_03";
    fe [[ f ]]( s, us, cf, ( 27113.2, -2021, 2532.5 ), ( 0, 351.18, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_house_lg_01";
    fe [[ f ]]( s, us, cf, ( 31878.4, 1864.64, 2381.3 ), ( 0, 90.29, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_police_station_01";
    fe [[ f ]]( s, us, cf, ( 24491.5, -14978.4, 2994.57 ), ( 0, 38.95, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_f_ob_intel_cs
// Params 0
// Checksum 0x2765b02e, Offset: 0x857
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_f_ob_intel_cs
// Params 0
// Checksum 0xe7ad4004, Offset: 0x861
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_f_ob_intel_cs" );
}

