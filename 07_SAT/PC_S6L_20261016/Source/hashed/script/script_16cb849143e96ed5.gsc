// script_16cb849143e96ed5  (hash_16cb849143e96ed5.gscc) (size: 3108 Bytes / 0xc24 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76e22add (1994533597)
// size ...... 3108 (0xc24)
// includes .. 2   (offset: 0xab4)
// strings ... 20  (offset: 0xac4)
// dev strs .. 0   (offset: 0xc24)
// exports ... 6   (offset: 0x7c8)
// cseg ...... 0x2bb + 0x50d (0x7c8)
// imports ... 17  (offset: 0x8b8)
// animtree1 . 0   (offset: 0xc24)
// animtree2 . 0   (offset: 0xc24)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_jup_st_i_ob_intel_cs;

// Namespace mp_jup_st_i_ob_intel_cs
// Params 2
// Checksum 0xf9d55d21, Offset: 0x2d9
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_i_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_i_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_intel_cs
// Params 3
// Checksum 0x6ea37e9, Offset: 0x351
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_i_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_i_ob_intel_cs" );
}

// Namespace mp_jup_st_i_ob_intel_cs
// Params 3
// Checksum 0x3a13c955, Offset: 0x3cb
// Size: 0x3dd
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 28233.5, -32243, 4036 ), ( 0, 69.2, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_heresyourexpert" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 39170, -18654.5, 3216.5 ), ( 0, 209.97, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_testing" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 22701, -20478.5, 2896 ), ( 351.41, 295.74, -55.62 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_intheturn" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( 30317, -22010, 3296 ), ( 0, 34.76, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_shoot_them" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_i_manor_ranch_house_lg_01";
    fe [[ f ]]( s, us, cf, ( 42027.2, -26919.8, 3482.19 ), ( 0, 126.17, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_i_manor_gym_01";
    fe [[ f ]]( s, us, cf, ( 23797, -33271.2, 3681.56 ), ( 0, 248.62, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 43058.5, -28909, 3139 ), ( 357.6, 24.39, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_09" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_i_manor_guest_house_02";
    fe [[ f ]]( s, us, cf, ( 29398.4, -26545.5, 3294.13 ), ( 0, 236.88, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_i_house_lg_01";
    fe [[ f ]]( s, us, cf, ( 39544.3, -27577.1, 3158.96 ), ( 0, 291.3, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_i_ob_intel_cs
// Params 0
// Checksum 0x2301cfbf, Offset: 0x7b0
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_i_ob_intel_cs
// Params 0
// Checksum 0xc4b9eaa0, Offset: 0x7ba
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_i_ob_intel_cs" );
}

