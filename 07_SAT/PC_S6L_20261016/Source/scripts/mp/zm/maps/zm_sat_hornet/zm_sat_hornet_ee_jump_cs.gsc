// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_jump_cs.gsc  (hash_02ce176059cbb9be.gscc) (size: 8258 Bytes / 0x2042 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x161be834 (370927668)
// size ...... 8258 (0x2042)
// includes .. 2   (offset: 0x1b9a)
// strings ... 38  (offset: 0x1baa)
// dev strs .. 0   (offset: 0x2042)
// exports ... 6   (offset: 0x18ea)
// cseg ...... 0x244 + 0x16a6 (0x18ea)
// imports ... 16  (offset: 0x19da)
// animtree1 . 0   (offset: 0x2042)
// animtree2 . 0   (offset: 0x2042)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_jump_cs;

// Namespace zm_sat_hornet_ee_jump_cs
// Params 2
// Checksum 0x99bc08c7, Offset: 0x262
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_jump_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_jump_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_jump_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_jump_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_jump_cs
// Params 3, eflags: 0x4
// Checksum 0xaad7ea41, Offset: 0x2ea
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_jump_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_jump_cs" );
}

// Namespace zm_sat_hornet_ee_jump_cs
// Params 3, eflags: 0x4
// Checksum 0xa31c6a38, Offset: 0x364
// Size: 0x1566
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3632, -18882, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3568, -18882, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3312, -18866, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3504, -18882, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3472, -18722, 48 ), ( 0, 270, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3648, -18690, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3312, -18674, 64 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3408, -18882, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3568, -18690, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3408, -18658, 64 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3664, -18690, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3408, -18578, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3264, -18578, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "gallery";
    fe [[ f ]]( s, us, cf, ( -3520, -18578, 32 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3488.97, -21846.9, 74 ), ( 358.7, 170.64, 97.8 ) );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3279.46, -19933.1, 24 ), ( 0, 308.7, 0 ), "jp_prp", undefined, "bld_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3491.45, -21880.2, 14 ), ( 0, 143.8, 0 ), "jp_kma_end", "cspf_0_auto14154789208457151178" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3353.08, -20034.2, 24 ), ( 0, 8.7, 0 ), "jp_prp", undefined, "bld_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -4210, -19632, 2 ), ( 0, 339, 0 ), "jp_kma" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -4428, -20380, 4 ), ( 0, 29, 0 ), "jp_kma" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -4359.72, -21310.2, 4 ), ( 0, 72, 0 ), "jp_kma" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3519.49, -20005.7, 18 ), ( 0, 295.1, 0 ), "jp_prp", undefined, "bld_lrg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3601.72, -19782.1, 32 ), ( 0, 274, 0 ), "jp_prp", undefined, "bld_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3773.25, -19841.7, 24 ), ( 0, 347.9, 0 ), "jp_prp", undefined, "bld_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec1";
    fe [[ f ]]( s, us, cf, ( -3894.6, -19719.8, 13 ), ( 0, 308.7, 16 ), "jp_prp", undefined, "bld_lrg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec2";
    fe [[ f ]]( s, us, cf, ( -3925.03, -20096.6, 75 ), ( 286, 262, 76 ), "jp_prp", undefined, "wd_pnl" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    s.script_label = "bobber";
    fe [[ f ]]( s, us, cf, ( -4259.89, -20474.4, 42 ), ( 0, 56.3, 90 ), "jp_prp", "0.7", "dr_light" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec2";
    fe [[ f ]]( s, us, cf, ( -3936.61, -19883.1, 74 ), ( 74.83, 76.73, -70.18 ), "jp_prp", undefined, "wd_splint_dr" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    s.script_label = "bobber";
    fe [[ f ]]( s, us, cf, ( -4141.35, -20345.4, 42 ), ( 0, 342.89, 90 ), "jp_prp", undefined, "dr_light" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec2";
    fe [[ f ]]( s, us, cf, ( -4155.23, -20042.2, 33 ), ( 0, 250, -90 ), "jp_prp", undefined, "wd_splint_li" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3513.97, -21906.9, 14 ), ( 0, 126.9, -0 ), "jp_kma_end", "cspf_0_auto12618156077467085608" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    s.script_label = "bobber";
    fe [[ f ]]( s, us, cf, ( -4117.45, -20656.6, 42 ), ( 0, 228.29, 90 ), "jp_prp", "1.2", "dr_light" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec2";
    fe [[ f ]]( s, us, cf, ( -4170.01, -20281.8, 6 ), ( 0, 339, 0 ), "jp_prp", undefined, "bld_lrg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    fe [[ f ]]( s, us, cf, ( -3263, -21774, 74.9 ), ( 0, 115.7, 0 ), "jp_return" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3545.38, -21924.6, 13.89 ), ( 358.69, 109.71, -0.47 ), "jp_kma_end", "cspf_0_auto11042637636562393276" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 80, 162, 206 );
    s._size_min = ( 356, 32, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -2864, -20997, 1 ), ( 0, 0, 0 ), "jp_dis_plach" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "bobber";
    fe [[ f ]]( s, us, cf, ( -4231.48, -21151.6, 44 ), ( 0, 353.89, 90 ), "jp_prp", undefined, "dr_light" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3514.97, -21896.9, 76 ), ( 2.21, 29.72, 91.61 ), "cspf_0_auto12618156077467085608" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3495.97, -21869.9, 76 ), ( 2.21, 55.62, 91.61 ), "cspf_0_auto14154789208457151178" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    s.script_label = "bobber";
    fe [[ f ]]( s, us, cf, ( -4268.94, -20889.6, 42 ), ( 0, 357.89, 90 ), "jp_prp", "2", "dr_light" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    fe [[ f ]]( s, us, cf, ( -4272.84, -21086, -2 ), ( 0, 38.5, 0 ), "jp_prp", undefined, "bld_lrg" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3488.97, -21838.9, 74 ), ( 1.26, 93.19, 110.2 ), "cspf_0_auto16000981069904668691" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -4053.1, -21323.5, 31.88 ), ( 90, 334.6, -0 ), "jp_prp", undefined, "beam_01" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -4063.17, -21200.3, -5 ), ( 0, 229.1, 0 ), "jp_prp", undefined, "wd_shel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3542.97, -21915.9, 76 ), ( 2.21, 9.22, 91.61 ), "cspf_0_auto11042637636562393276" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec3";
    fe [[ f ]]( s, us, cf, ( -4146.48, -20774.1, 32.88 ), ( 90, 0, 11.7 ), "jp_prp", undefined, "beam_01" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -3911.86, -21278.5, 30.88 ), ( 90, 334.6, -0 ), "jp_prp", undefined, "beam_01" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -3775.24, -21585.8, 25 ), ( 0, 4.4, 0 ), "jp_prp", undefined, "wd_shel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -3905.67, -21390.2, 7 ), ( 0, 62.9, 0 ), "jp_prp", undefined, "wd_shel" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "sec4";
    s.script_label = "sinker";
    fe [[ f ]]( s, us, cf, ( -3749.6, -21732.3, 40.88 ), ( 90, 119.3, -0 ), "jp_prp", undefined, "beam_01" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.groupid = "kma";
    fe [[ f ]]( s, us, cf, ( -3485.93, -21853.2, 12.36 ), ( 355.14, 163.37, 7.21 ), "jp_kma_end", "cspf_0_auto16000981069904668691" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 50, 16, 32 );
    s._size_min = ( 44, 52, 44 );
    s.groupid = "tr";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -4185.57, -20251.2, 39 ), ( 0, 330.6, 0 ), "jp_secvol", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 154, 92, 198 );
    s._size_min = ( 176, 130, 88 );
    s.groupid = "tr";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -3030, -19746, 195 ), ( 0, 347.3, 0 ), "jp_secvol", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 60, 32, 32 );
    s._size_min = ( 26, 50, 44 );
    s.groupid = "tr";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -3918, -19700, 44 ), ( 0, 346.9, 0 ), "jp_secvol", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 34, 32, 32 );
    s._size_min = ( 36, 28, 44 );
    s.groupid = "tr";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -4286, -21105, 34 ), ( 0, 0, 0 ), "jp_secvol", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_jump_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 82, 98, 108 );
    s._size_min = ( 60, 70, 66 );
    s.groupid = "tr";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -3548, -21884, 34 ), ( 0, 330, 0 ), "jp_secvol", undefined, "4" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_jump_cs
// Params 0, eflags: 0x4
// Checksum 0xd09d4bfa, Offset: 0x18d2
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_jump_cs
// Params 0
// Checksum 0x6884370c, Offset: 0x18dc
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_jump_cs" );
}

