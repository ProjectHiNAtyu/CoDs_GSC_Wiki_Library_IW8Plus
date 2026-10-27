// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ltm_echo_cs.gsc  (hash_56390e796fe4d6b0.gscc) (size: 14942 Bytes / 0x3a5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6268f0c7 (1651044551)
// size ...... 14942 (0x3a5e)
// includes .. 2   (offset: 0x32de)
// strings ... 34  (offset: 0x32ee)
// dev strs .. 0   (offset: 0x3a5e)
// exports ... 6   (offset: 0x2efe)
// cseg ...... 0x333 + 0x2bcb (0x2efe)
// imports ... 17  (offset: 0x2fee)
// animtree1 . 0   (offset: 0x3a5e)
// animtree2 . 0   (offset: 0x3a5e)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_firefly_ltm_echo_cs;

// Namespace zm_sat_firefly_ltm_echo_cs
// Params 2
// Checksum 0xa58793da, Offset: 0x351
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_ltm_echo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_ltm_echo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_ltm_echo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_ltm_echo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x96ec715c, Offset: 0x3d9
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_ltm_echo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_ltm_echo_cs" );
}

// Namespace zm_sat_firefly_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0xde89b3f9, Offset: 0x453
// Size: 0x2a8b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 25064, 176, 414 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 15069.3, -4932.58, 511.93 ), ( 0, 130.01, 0 ), "echo_portal_spawn", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 15130.6, -4881.15, 512 ), ( 0, 130, 0 ), "echo_portal_spawn", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 3792, -1704, -339.96 ), ( 0, 90.02, 0 ), "echo_portal_spawn", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 3952, -1704, -337.48 ), ( 0, 89.97, 0 ), "echo_portal_spawn", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -8269.79, -6325.29, 1640 ), ( 0, 144.4, 0 ), "echo_portal_spawn", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -8176, -6187, 1640 ), ( 0, 144.37, 0 ), "echo_portal_spawn", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -12615.5, 4657.2, 416.99 ), ( 0, 116, 0 ), "echo_portal_spawn", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -12747.1, 4590.29, 416.99 ), ( 0, 116, 0 ), "echo_portal_spawn", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 13067.7, 1110.39, 894.13 ), ( 0, 296.98, 0 ), "echo_portal_spawn", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 13233, 1106, 899.58 ), ( 0, 270.74, 0 ), "echo_portal_spawn", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 25064, 256, 414 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 13151.7, 1108.39, 896.62 ), ( 0, 283.2, 0 ), "echo_portal_spawn", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 15008, -4984, 511.61 ), ( 0, 130, 0 ), "echo_portal_spawn", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 3872, -1704, -340.12 ), ( 0, 89.96, 0 ), "echo_portal_spawn", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -8222, -6257, 1640 ), ( 0, 144.37, 0 ), "echo_portal_spawn", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -12683.2, 4621.43, 416.99 ), ( 0, 116, 0 ), "echo_portal_spawn", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 25064, 96, 414 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 25064, 416, 414 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 14946.7, -5035.42, 512.35 ), ( 0, 129.99, 0 ), "echo_portal_spawn", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 14885.4, -5086.85, 512 ), ( 0, 130, 0 ), "echo_portal_spawn", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 3712, -1704, -338.99 ), ( 0, 90, 0 ), "echo_portal_spawn", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 4032, -1704, -334.02 ), ( 0, 89.96, 0 ), "echo_portal_spawn", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -8309.79, -6389.29, 1640 ), ( 0, 144.4, 0 ), "echo_portal_spawn", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -8136, -6131, 1640 ), ( 0, 144.37, 0 ), "echo_portal_spawn", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -12554.4, 4681.95, 416.99 ), ( 0, 116, 0 ), "echo_portal_spawn", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -12815.1, 4556.5, 416.99 ), ( 0, 116, 0 ), "echo_portal_spawn", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 13305, 1106, 900.12 ), ( 0, 261.05, 0 ), "echo_portal_spawn", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 13385, 1106, 899.52 ), ( 0, 254.96, 0 ), "echo_portal_spawn", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 46736, -448, -47.5 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 46736, -368, -47.5 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 46736, -528, -46.03 ), ( 1.64, 180.05, 1.65 ), "echo_portal_spawn", undefined, "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 46736, -208, -47.5 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 46736, -288, -47.5 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 24946.5, 257.92, 421.25 ), ( 0, 281.02, 0 ), "player_echo_reward_point", "cspf_0_auto12105319726483954521", "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 24798.6, 198.4, 420.13 ), ( 0, 11.85, 0 ), "cspf_0_auto12105319726483954521" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 24806.1, 370.69, 420.13 ), ( 0, 343.62, 0 ), "cspf_0_auto12105319726483954521" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 24808.9, 125.96, 420.13 ), ( 0, 18.22, 0 ), "cspf_0_auto12105319726483954521" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 24807.5, 289.56, 420.13 ), ( 0, 356.62, 0 ), "cspf_0_auto12105319726483954521" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 22969, 360, 306.38 ), ( 0, 0, 0 ), "echo_portal_spawn", undefined, "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 22969, 440, 306.81 ), ( 0, 0, 0 ), "echo_portal_spawn", undefined, "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 22969, 280, 306.75 ), ( 0, 0, 0 ), "echo_portal_spawn", undefined, "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 22969, 600, 305.67 ), ( 0, 0, 0 ), "echo_portal_spawn", undefined, "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 22969, 520, 307.26 ), ( 0, 0, 0 ), "echo_portal_spawn", undefined, "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23307.5, 455.42, 330.25 ), ( 0, 281.02, 0 ), "player_echo_reward_point", "cspf_0_auto5727742721449406476", "janus2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23159.6, 395.9, 314.13 ), ( 0, 170.85, 0 ), "cspf_0_auto5727742721449406476" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23167.1, 568.19, 317.81 ), ( 0, 208.62, 0 ), "cspf_0_auto5727742721449406476" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23169.9, 323.46, 314.13 ), ( 0, 155.55, 0 ), "cspf_0_auto5727742721449406476" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23168.5, 487.06, 321.01 ), ( 0, 187.62, 0 ), "cspf_0_auto5727742721449406476" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14958.5, -4986.08, 529.25 ), ( 0, 231.02, 0 ), "player_echo_reward_point", "cspf_0_auto46934919519816971", "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14817.8, -4911.04, 524.13 ), ( 0, 335.85, 0 ), "cspf_0_auto46934919519816971" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14954.6, -4806.04, 523.13 ), ( 0, 302.35, 0 ), "cspf_0_auto46934919519816971" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14769, -4965.49, 521.13 ), ( 0, 341.84, 0 ), "cspf_0_auto46934919519816971" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14893.4, -4859.27, 525.13 ), ( 0, 313.38, 0 ), "cspf_0_auto46934919519816971" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 13147.7, -5039.41, 776 ), ( 0, 44.54, 0 ), "echo_portal_spawn", undefined, "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 13203.8, -5096.51, 776 ), ( 0, 44.53, 0 ), "echo_portal_spawn", undefined, "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 13091.5, -4982.44, 776 ), ( 0, 44.53, 0 ), "echo_portal_spawn", undefined, "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 13035.4, -4925.32, 776 ), ( 0, 44.52, 0 ), "echo_portal_spawn", undefined, "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 12979.3, -4868.24, 776 ), ( 0, 44.53, 0 ), "echo_portal_spawn", undefined, "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13100.2, -4974.62, 793.25 ), ( 0, 141.75, 0 ), "player_echo_reward_point", "cspf_0_auto1971553855733128291", "farm2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13172.4, -4819.1, 784.13 ), ( 0, 234.58, 0 ), "cspf_0_auto1971553855733128291" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13274.2, -4972.5, 786.54 ), ( 0, 203.51, 0 ), "cspf_0_auto1971553855733128291" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13106.3, -4765.12, 785.13 ), ( 0, 248.95, 0 ), "cspf_0_auto1971553855733128291" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13249.1, -4892.91, 784.2 ), ( 0, 216.7, 0 ), "cspf_0_auto1971553855733128291" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13231.9, 1048.53, 911.25 ), ( 0, 9.02, 0 ), "player_echo_reward_point", "cspf_0_auto9976559088317387778", "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13286.2, 898.61, 904.13 ), ( 0, 94.59, 0 ), "cspf_0_auto9976559088317387778" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13114.3, 912.12, 906.13 ), ( 0, 66.47, 0 ), "cspf_0_auto9976559088317387778" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13358.9, 906.42, 902.13 ), ( 0, 114.22, 0 ), "cspf_0_auto9976559088317387778" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13194.4, 898.73, 905.13 ), ( 0, 76.18, 0 ), "cspf_0_auto9976559088317387778" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 12218.9, 3359.55, 866 ), ( 0, 334.98, 0 ), "echo_portal_spawn", undefined, "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 12153.9, 3210.93, 866 ), ( 0, 335.17, 0 ), "echo_portal_spawn", undefined, "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 12186.6, 3285.42, 866 ), ( 0, 335.2, 0 ), "echo_portal_spawn", undefined, "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 12127, 3144.17, 866 ), ( 0, 335.05, 0 ), "echo_portal_spawn", undefined, "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 12097, 3070, 866 ), ( 0, 334.96, 0 ), "echo_portal_spawn", undefined, "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 12226.4, 3190.16, 877.25 ), ( 0, 79.02, 0 ), "player_echo_reward_point", "cspf_0_auto15438235946212643083", "lake2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 12385.8, 3189.91, 876.13 ), ( 0, 159.85, 0 ), "cspf_0_auto15438235946212643083" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 12314.4, 3033, 884.13 ), ( 0, 145.58, 0 ), "cspf_0_auto15438235946212643083" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 12403.4, 3260.9, 876.13 ), ( 0, 184.22, 0 ), "cspf_0_auto15438235946212643083" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 12332.4, 3117.73, 878.13 ), ( 0, 153.17, 0 ), "cspf_0_auto15438235946212643083" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3868.93, -1643.07, -328.75 ), ( 0, 189.02, 0 ), "player_echo_reward_point", "cspf_0_auto964188427623103479", "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3814.58, -1493.16, -330.87 ), ( 0, 283.04, 0 ), "cspf_0_auto964188427623103479" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3986.5, -1506.66, -328.87 ), ( 0, 247.62, 0 ), "cspf_0_auto964188427623103479" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3741.88, -1500.97, -329.87 ), ( 0, 292.75, 0 ), "cspf_0_auto964188427623103479" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3905.4, -1505.27, -332.87 ), ( 0, 264.1, 0 ), "cspf_0_auto964188427623103479" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2629, -2279, 328.04 ), ( 0, 270, 0 ), "echo_portal_spawn", undefined, "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 2789, -2279, 328.52 ), ( 0, 270, 0 ), "echo_portal_spawn", undefined, "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 2709, -2279, 327.88 ), ( 0, 270, 0 ), "echo_portal_spawn", undefined, "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2549, -2279, 329.01 ), ( 0, 270, 0 ), "echo_portal_spawn", undefined, "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 2866, -2279, 327.98 ), ( 0, 270, 0 ), "echo_portal_spawn", undefined, "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2705.17, -2296.71, 363.25 ), ( 0, 15.02, 0 ), "player_echo_reward_point", "cspf_0_auto7800759464722151507", "ashwood2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2774.89, -2481.12, 337.13 ), ( 0, 100.69, 0 ), "cspf_0_auto7800759464722151507" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2602.5, -2444.66, 337.13 ), ( 0, 68.84, 0 ), "cspf_0_auto7800759464722151507" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2854.38, -2452.75, 352.13 ), ( 0, 122.09, 0 ), "cspf_0_auto7800759464722151507" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2691.3, -2483.57, 337.13 ), ( 0, 85.68, 0 ), "cspf_0_auto7800759464722151507" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8265.5, -6226.08, 1651.25 ), ( 0, 231.02, 0 ), "player_echo_reward_point", "cspf_0_auto6208965254823805850", "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8406.2, -6151.04, 1651.13 ), ( 0, 323.8, 0 ), "cspf_0_auto6208965254823805850" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8269.4, -6046.04, 1652.13 ), ( 0, 296.41, 0 ), "cspf_0_auto6208965254823805850" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8455, -6205.49, 1651.13 ), ( 0, 341.92, 0 ), "cspf_0_auto6208965254823805850" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8330.6, -6099.27, 1651.13 ), ( 0, 312.84, 0 ), "cspf_0_auto6208965254823805850" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -8742.48, -6693.98, 1306 ), ( 0, 50.4, 0 ), "echo_portal_spawn", undefined, "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -8611.07, -6797.19, 1306 ), ( 0, 50.37, 0 ), "echo_portal_spawn", undefined, "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -8677.69, -6746.42, 1306 ), ( 0, 50.37, 0 ), "echo_portal_spawn", undefined, "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -8803.54, -6649.62, 1306 ), ( 0, 50.4, 0 ), "echo_portal_spawn", undefined, "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -8558, -6841, 1306 ), ( 0, 50.37, 0 ), "echo_portal_spawn", undefined, "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8644.7, -6705.29, 1317.25 ), ( 0, 153.02, 0 ), "player_echo_reward_point", "cspf_0_auto9316254002878325998", "zarya2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8600.55, -6552.06, 1312.13 ), ( 0, 245.68, 0 ), "cspf_0_auto9316254002878325998" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8469.4, -6664.04, 1312.13 ), ( 0, 210.13, 0 ), "cspf_0_auto9316254002878325998" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8663.95, -6515.65, 1312.13 ), ( 0, 264.62, 0 ), "cspf_0_auto9316254002878325998" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -8534.19, -6615.24, 1311.13 ), ( 0, 225.46, 0 ), "cspf_0_auto9316254002878325998" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12694.7, 4641.6, 427.25 ), ( 0, 225.02, 0 ), "player_echo_reward_point", "cspf_0_auto13436574252615615935", "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12835.8, 4747.94, 425.13 ), ( 0, 307.34, 0 ), "cspf_0_auto13436574252615615935" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12654.8, 4803.7, 426.13 ), ( 5.4, 281.54, 0 ), "cspf_0_auto13436574252615615935" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12892, 4701.89, 425.13 ), ( 0, 328.22, 0 ), "cspf_0_auto13436574252615615935" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12725.9, 4802.88, 425.13 ), ( 0, 286.08, 0 ), "cspf_0_auto13436574252615615935" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -10898, 3058.81, 415.1 ), ( 0, 232.2, 0 ), "echo_portal_spawn", undefined, "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -11021.8, 3153.73, 415 ), ( 0, 232.34, 0 ), "echo_portal_spawn", undefined, "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -10959.8, 3103.96, 415.91 ), ( 0, 232.19, 0 ), "echo_portal_spawn", undefined, "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -10837, 3004.7, 415 ), ( 0, 232.22, 0 ), "echo_portal_spawn", undefined, "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -11082, 3200, 412.39 ), ( 0, 232.34, 0 ), "echo_portal_spawn", undefined, "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -10998.4, 3112.82, 433.25 ), ( 0, 311.02, 0 ), "player_echo_reward_point", "cspf_0_auto828424953835727328", "diner2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -11109.7, 2964.29, 430.13 ), ( 0, 43.81, 0 ), "cspf_0_auto828424953835727328" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -11188.4, 3088.24, 429.13 ), ( 0, 19.74, 0 ), "cspf_0_auto828424953835727328" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -11051.6, 2929.77, 429.13 ), ( 0, 61.41, 0 ), "cspf_0_auto828424953835727328" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -11156.6, 3021.73, 432.13 ), ( 0, 27.31, 0 ), "cspf_0_auto828424953835727328" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46677.5, -370.08, -34.75 ), ( 0, 281.02, 0 ), "player_echo_reward_point", "cspf_0_auto2729693277323456838", "boss" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46529.6, -429.6, -36.87 ), ( 0, 8.52, 0 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46537.1, -257.31, -36.87 ), ( 0, 339.32, 0 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46529.9, -508.04, -37.87 ), ( 0, 32.24, 0 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46538.5, -338.44, -36.87 ), ( 0, 351.9, 0 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 25064, 336, 414 ), ( 0, 180, 0 ), "echo_portal_spawn", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 46432.9, 1083.06, -236.5 ), ( 0, 90, 0 ), "echo_portal_spawn", undefined, "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 46512.9, 1083.06, -234.5 ), ( 0, 90, 0 ), "echo_portal_spawn", undefined, "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 46352.9, 1083.07, -236.03 ), ( 0, 90.05, 0 ), "echo_portal_spawn", undefined, "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 46672.9, 1083.06, -235.5 ), ( 0, 90, 0 ), "echo_portal_spawn", undefined, "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 46592.9, 1083.06, -234.5 ), ( 0, 90, 0 ), "echo_portal_spawn", undefined, "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46514.9, 1082.56, -224.75 ), ( 0, 191.02, 0 ), "player_echo_reward_point", "cspf_0_auto9730177006438236041", "boss2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46450.3, 1314.46, -231.87 ), ( 0, 284.4, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46622.6, 1306.96, -229.87 ), ( 0, 243.99, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46371.9, 1314.15, -237.87 ), ( 0, 297.74, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 46541.5, 1305.56, -228.87 ), ( 0, 260.17, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 23470, 678, 351 ), ( 0, 270, 0 ), "curse_inducer", undefined, "janus" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13414, -3631, 696 ), ( 0, 110.04, 0 ), "curse_inducer", undefined, "farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3788, -1243, -288 ), ( 0, 270.04, 0 ), "curse_inducer", undefined, "ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -6240, -7247, 1454 ), ( 0, 194.46, 0 ), "curse_inducer", undefined, "zarya" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -12366.5, 3468, 519.5 ), ( 0, 307.09, 0 ), "curse_inducer", undefined, "diner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 14399.5, 2218, 935.5 ), ( 0, 19.09, 0 ), "curse_inducer", undefined, "lake" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 48391.5, -362, -104.5 ), ( 0, 180, 0 ), "curse_inducer", undefined, "boss" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_ltm_echo_cs
// Params 0, eflags: 0x4
// Checksum 0x202e09a7, Offset: 0x2ee6
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_ltm_echo_cs
// Params 0
// Checksum 0x54bfac11, Offset: 0x2ef0
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_ltm_echo_cs" );
}

