// script_46edcb022703579  (hash_046edcb022703579.gscc) (size: 3283 Bytes / 0xcd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7fec714 (4160669460)
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

#namespace mp_jup_st_h_ob_intel_cs;

// Namespace mp_jup_st_h_ob_intel_cs
// Params 2
// Checksum 0x9373f6a3, Offset: 0x308
// Size: 0x70
function main( unused, us )
{
    if ( utility::flag_exist( "mp_jup_st_h_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = create_script_utility::function_4579dd5df27ceeca();
    }
    
    utility::flag_init( "mp_jup_st_h_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_intel_cs
// Params 3
// Checksum 0x6c4c9c6b, Offset: 0x380
// Size: 0x72
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_jup_st_h_ob_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_jup_st_h_ob_intel_cs" );
}

// Namespace mp_jup_st_h_ob_intel_cs
// Params 3
// Checksum 0xe884d92c, Offset: 0x3fa
// Size: 0x441
function createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 11368, -25691.5, 2224 ), ( 0, 182.46, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_weneedresp" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    fe [[ f ]]( s, us, cf, ( 2531, -31770, 1953 ), ( 0, 16.77, 0 ), "deadbolt_audio_intel", undefined, "intel_s0_deadbolt_audio_somethingravenov" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 3956, -14040.5, 1415.5 ), ( 351.7, 231.58, -3.3 ), "deadbolt_radio_intel", undefined, "intel_s0_deadbolt_radio_wileymimic" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    fe [[ f ]]( s, us, cf, ( 16151, -38307, 6545 ), ( 0, 293.66, 0 ), "terminus_audio_intel", undefined, "intel_s0_terminus_audio_mistake" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_h_apartment_17";
    fe [[ f ]]( s, us, cf, ( 8462.5, -36040.5, 3090.5 ), ( 0, 134.05, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_h_apartment_18";
    fe [[ f ]]( s, us, cf, ( 3224.6, -29565.3, 2350.69 ), ( 0, 210.77, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.name = "note_intel";
    fe [[ f ]]( s, us, cf, ( 1118, -18015, 1750 ), ( 0, 161.91, 0 ), "note_intel", undefined, "jup_zm_ob_intel_notes_08" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_h_apartment_22";
    fe [[ f ]]( s, us, cf, ( 12545.1, -35921, 2925.97 ), ( 0, 106.79, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_h_apartment_construction_02";
    fe [[ f ]]( s, us, cf, ( 5530.6, -26994.2, 2037.62 ), ( 0, 254.99, 0 ), "terminus_audio_intel_warlord" );
    s = create_script_utility::s();
    s.cs_flag = "mp_jup_st_h_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_h_apartment_21";
    fe [[ f ]]( s, us, cf, ( 3897.3, -27414.9, 2054.69 ), ( 0, 172.46, 0 ), "terminus_audio_intel_warlord" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_jup_st_h_ob_intel_cs
// Params 0
// Checksum 0x9431bdb8, Offset: 0x843
// Size: 0x2
function function_75f4a755dfd427b6()
{
    
}

// Namespace mp_jup_st_h_ob_intel_cs
// Params 0
// Checksum 0xae1f4122, Offset: 0x84d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_jup_st_h_ob_intel_cs" );
}

