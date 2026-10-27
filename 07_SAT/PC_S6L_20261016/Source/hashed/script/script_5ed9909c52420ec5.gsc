// script_5ed9909c52420ec5  (hash_5ed9909c52420ec5.gscc) (size: 3134 Bytes / 0xc3e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7687e816 (1988618262)
// size ...... 3134 (0xc3e)
// includes .. 2   (offset: 0xace)
// strings ... 20  (offset: 0xade)
// dev strs .. 0   (offset: 0xc3e)
// exports ... 6   (offset: 0x7e2)
// cseg ...... 0x2d5 + 0x50d (0x7e2)
// imports ... 17  (offset: 0x8d2)
// animtree1 . 0   (offset: 0xc3e)
// animtree2 . 0   (offset: 0xc3e)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_a_ob_intel_cs;

// Namespace mp_jup_st_a_ob_intel_cs
// Params 2
// Checksum 0x5406b874, Offset: 0x2f3
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_a_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_a_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_intel_cs
// Params 3
// Checksum 0xab39d2bc, Offset: 0x36b
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_a_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_a_ob_intel_cs" );
}

// Namespace mp_jup_st_a_ob_intel_cs
// Params 3
// Checksum 0x9c6daf17, Offset: 0x3e5
// Size: 0x3dd
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -24982.5, 36842, 2248 ), ( 0, 50.27, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_we_didnt_train" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -30098, 21267, 1455 ), ( 0, 233.8, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_symbiosis" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( -30681, 29451.5, 1395 ), ( 0, 20.16, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_fishwater" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( -22268, 18469.5, 1653 ), ( 0, 308.93, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_ideologies" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_a_store_abandoned_lg_02";
    fe [[ f ]]( s, us, cf, ( -23108.5, 17638.6, 1669.8 ), ( 0, 138.73, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( -36899, 42701, 1801 ), ( 0, 209.62, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_01" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_a_apartment_abandoned_md_02";
    fe [[ f ]]( s, us, cf, ( -23778.7, 39317.3, 2268.83 ), ( 0, 45, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_a_apartment_abandoned_24";
    fe [[ f ]]( s, us, cf, ( -28559.6, 42105.8, 1717.84 ), ( 0, 244.93, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_a_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_a_store_abandoned_md_01_2";
    fe [[ f ]]( s, us, cf, ( -32262.1, 23458.3, 1454.59 ), ( 0, 117.63, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_a_ob_intel_cs
// Params 0
// Checksum 0xd4d1f987, Offset: 0x7ca
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_a_ob_intel_cs
// Params 0
// Checksum 0x696a0ff5, Offset: 0x7d4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_a_ob_intel_cs" );
}

