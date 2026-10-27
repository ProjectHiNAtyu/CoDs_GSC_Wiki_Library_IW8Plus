// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_quest_twins_ee_cs.gsc  (hash_42b341884543d34c.gscc) (size: 7522 Bytes / 0x1d62 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe5fdbbc (3193953212)
// size ...... 7522 (0x1d62)
// includes .. 3   (offset: 0x195e)
// strings ... 28  (offset: 0x1976)
// dev strs .. 0   (offset: 0x1d62)
// exports ... 9   (offset: 0x15c6)
// cseg ...... 0x1af + 0x1417 (0x15c6)
// imports ... 20  (offset: 0x172e)
// animtree1 . 0   (offset: 0x1d62)
// animtree2 . 0   (offset: 0x1d62)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_quest_twins_ee_cs;

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 0, eflags: 0x5
// Checksum 0x46c55b57, Offset: 0x1cd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_quest_twins_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xa3afa1dc, Offset: 0x1ee
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x26947230, Offset: 0x1ff
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 2
// Checksum 0x967d2479, Offset: 0x210
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_quest_twins_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_quest_twins_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_quest_twins_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_quest_twins_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xa516c6ff, Offset: 0x298
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_quest_twins_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_quest_twins_ee_cs" );
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x54812ed5, Offset: 0x312
// Size: 0x1294
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5167.86, -3958.62, 1333.5 ), ( 0, 24.53, 0 ), "xe_nd_gr" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -29231.6, 30120.1, 961.42 ), ( 0.99, 298.43, 0.6 ), "un_yt_tc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -29192.9, 29297.1, 961.23 ), ( 8.39, 49.3, 4.64 ), "pn_lw_mb" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28665.5, 30758.8, 967.33 ), ( 4.5, 265.54, 0.94 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28734.5, 29112.4, 960 ), ( 0, 254.28, 0 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28666.5, 28553.7, 928 ), ( 360, 151.72, 0 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28831, 29716.5, 1012.5 ), ( 270, 333.2, -0 ), "qf_iu_jh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28270.4, 30196.7, 960.28 ), ( 0, 166.94, 0.33 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -27383.5, 29770.3, 1008 ), ( 0, 71.77, 0 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28436.1, 30228.6, 960.52 ), ( 0.15, 240.51, -0.56 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28935.8, 30174.2, 951.21 ), ( 358.57, 24.1, 0.35 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -29113.7, 30002.7, 960 ), ( 0, 359.04, 0 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -29049.8, 29448.4, 960.01 ), ( 359.97, 113.4, -0.07 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28442.7, 29338.8, 960 ), ( 0, 51.72, 0 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28692.2, 29730.2, 960 ), ( 0, 50.86, 0 ), "gp_ly_ct" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -29106.9, 29638.1, 957 ), ( 0.51, 56.49, 2.67 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28713, 29889, 955 ), ( 0, 251.96, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28712.9, 29301.6, 961 ), ( 0, 15.18, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28464.2, 29183.5, 962 ), ( 0, 71, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28047.6, 29914.6, 964.58 ), ( 359.33, 241.11, 0.38 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28294.9, 30090.3, 963 ), ( 0, 49.2, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -27937.3, 29651, 969 ), ( 0, 358.98, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28184.7, 29451.3, 956 ), ( 0, 212.36, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28240, 30191.7, 961 ), ( 0, 24.45, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28673, 30365.7, 962 ), ( 0.3, 44.25, -0.27 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28883.4, 30241.9, 952 ), ( 0, 109.95, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28671, 30171.9, 948 ), ( 359.69, 123.54, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28772.8, 29557.7, 951 ), ( 0, 280.36, -0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28499.6, 29277.8, 956 ), ( 0, 131.14, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -27889, 29777.8, 965 ), ( 10.65, 133.84, -2.69 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -29364.2, 29664, 966 ), ( 2.98, 141.43, -2.26 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28747.5, 29584, 1048.5 ), ( 26.11, 89.43, -0 ), "oz_ke_jc" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28620.5, 29871, 947.84 ), ( 0.14, 25.04, 0.38 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28772.2, 29626.5, 949.13 ), ( 359.1, 212.42, 0.32 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28297.4, 30001.4, 960.55 ), ( 1.73, 123.18, 0.04 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28753, 28817.1, 952 ), ( 2.68, 224, -2.34 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28667.7, 30408, 960.78 ), ( 0.15, 17.8, -0.37 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28306.4, 29569.1, 966 ), ( 0, 265.18, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -27653.5, 29880.3, 972 ), ( 0, 251.54, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -30043.9, 29714, 881.79 ), ( 3.11, 161.46, -1.98 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28771, 29686, 1013 ), ( 0, 333, 0 ), "wy_pa_js" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28762.3, 29703, 960 ), ( 0, 240.97, 0 ), "ti_ro_jp" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28692, 29647, 956 ), ( 0, 151, 0 ), "dc_he_jr" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28845.5, 29724.5, 963.5 ), ( 0, 333.04, 0 ), "bn_qw_jl" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28799.4, 29628.3, 960 ), ( 0, 67.5, 0 ), "ls_du_jw" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -5028.5, -3958, 1339.5 ), ( 0, 223.13, 0 ), "ka_vr_rw" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -27854.5, 29676.9, 970.29 ), ( 1.86, 346.95, -1.6 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28666.9, 31078.4, 984.61 ), ( 2.5, 122.68, 0.29 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -28590, 28826, 951.38 ), ( 359.88, 6.66, 3.57 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "h";
    fe [[ f ]]( s, us, cf, ( -29466.3, 29632.2, 956.2 ), ( 358.36, 47.13, -2.83 ), "rv_to_hs" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28710.8, 29654.8, 1012.5 ), ( 270, 150.4, 0 ), "qf_iu_jh" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28770.5, 29686, 960 ), ( 0, 51.75, 0 ), "ml_za_jf" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -29069.7, 29917, 957.95 ), ( 0, 311, 0 ), "pt_na_jsc", undefined, "dance" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "t";
    fe [[ f ]]( s, us, cf, ( -28509.5, 29867.7, 949 ), ( 0, 191.99, 0 ), "hn_er_ts" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28615.1, 29850.6, 947.61 ), ( 0, 270, 0 ), "pt_na_jsc", undefined, "chalk" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "j";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28589, 29876.1, 949.87 ), ( 0, 342.26, 0 ), "pt_na_jsc", undefined, "skipping" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_quest_twins_ee_cs";
    s.groupid = "c";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -28599.4, 29872.7, 947.28 ), ( 0, 0, 0 ), "jb_ko_cs" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xd46848d2, Offset: 0x15ae
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_quest_twins_ee_cs
// Params 0
// Checksum 0x67451bb2, Offset: 0x15b8
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_quest_twins_ee_cs" );
}

