// script_5a611e71f0704341  (hash_5a611e71f0704341.gscc) (size: 3265 Bytes / 0xcc1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18fadaac (419093164)
// size ...... 3265 (0xcc1)
// includes .. 2   (offset: 0xb35)
// strings ... 21  (offset: 0xb45)
// dev strs .. 0   (offset: 0xcc1)
// exports ... 6   (offset: 0x845)
// cseg ...... 0x2ce + 0x577 (0x845)
// imports ... 17  (offset: 0x935)
// animtree1 . 0   (offset: 0xcc1)
// animtree2 . 0   (offset: 0xcc1)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_d_ob_intel_cs;

// Namespace mp_jup_st_d_ob_intel_cs
// Params 2
// Checksum 0xd72ac67c, Offset: 0x2ec
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_d_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_d_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_intel_cs
// Params 3
// Checksum 0x2815acb4, Offset: 0x364
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_d_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_d_ob_intel_cs" );
}

// Namespace mp_jup_st_d_ob_intel_cs
// Params 3
// Checksum 0xeba6ca9a, Offset: 0x3de
// Size: 0x447
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -28224.5, 9753.5, 1171 ), ( 0, 185.31, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_quartrmstr" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( -15895.5, -22178.5, 4664 ), ( 0, 343.53, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_keepitrun" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( -14292, -13873.5, 1849 ), ( 0, 87.9, 38.67 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_1stimpress" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( -34428, -32089.5, 2058 ), ( 0, 173.19, 0 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_ifneedride" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( -27337, -11357.5, 1665.25 ), ( 0, 172.2, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_noharm" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( -18946, 4916, 1451 ), ( 0, 275.3, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_04" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_d_marina_building_10";
    fe [[ f ]]( s, us, cf, ( -31667.4, 8286.45, 1364.6 ), ( 0, 97.63, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_d_house_md_03";
    fe [[ f ]]( s, us, cf, ( -21595.8, 8742.5, 2553 ), ( 0, 217.63, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_d_house_md_08";
    fe [[ f ]]( s, us, cf, ( -32976, 14796.3, 1108.72 ), ( 359.93, 277.8, -3.86 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_d_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_d_house_md_08_2";
    fe [[ f ]]( s, us, cf, ( -19164.8, 9348.75, 2135.5 ), ( 0.23, 62.49, -4.12 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_d_ob_intel_cs
// Params 0
// Checksum 0x4ad2349c, Offset: 0x82d
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_d_ob_intel_cs
// Params 0
// Checksum 0xea4671fd, Offset: 0x837
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_d_ob_intel_cs" );
}

