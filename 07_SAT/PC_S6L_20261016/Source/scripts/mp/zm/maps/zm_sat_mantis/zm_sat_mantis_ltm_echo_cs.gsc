// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ltm_echo_cs.gsc  (hash_354ffedb88b6691e.gscc) (size: 10815 Bytes / 0x2a3f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86bd962e (2260571694)
// size ...... 10815 (0x2a3f)
// includes .. 2   (offset: 0x24db)
// strings ... 26  (offset: 0x24eb)
// dev strs .. 0   (offset: 0x2a3f)
// exports ... 6   (offset: 0x2173)
// cseg ...... 0x2b7 + 0x1ebc (0x2173)
// imports ... 17  (offset: 0x2263)
// animtree1 . 0   (offset: 0x2a3f)
// animtree2 . 0   (offset: 0x2a3f)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_mantis_ltm_echo_cs;

// Namespace zm_sat_mantis_ltm_echo_cs
// Params 2
// Checksum 0xab20eb15, Offset: 0x2d5
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_ltm_echo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_ltm_echo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_ltm_echo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_ltm_echo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x984b0993, Offset: 0x35d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_ltm_echo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_ltm_echo_cs" );
}

// Namespace zm_sat_mantis_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x604f3d6e, Offset: 0x3d7
// Size: 0x1d7c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 56988.4, -32300.7, -127 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 57025.4, -32229.9, -127 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 56951.4, -32371.7, -127 ), ( 0, 152.47, 0 ), "echo_portal_spawn", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 57099.6, -32088, -126.83 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 57062.5, -32159, -125.18 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56965.7, -32201.4, -105 ), ( 0, 253.44, 0 ), "player_echo_reward_point", "cspf_0_auto6090413608952624824", "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56802.6, -32167.7, -127 ), ( 0, 346.82, 0 ), "cspf_0_auto6090413608952624824" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56889, -32018.5, -127 ), ( 0, 306.4, 0 ), "cspf_0_auto6090413608952624824" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56766.6, -32237.3, -127 ), ( 0, 0.16, 0 ), "cspf_0_auto6090413608952624824" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56852.7, -32091, -127 ), ( 0, 322.59, 0 ), "cspf_0_auto6090413608952624824" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56527.2, -31802, 41.13 ), ( 0, 331.74, 0 ), "curse_inducer", undefined, "backyard2_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56639.3, -31262.2, -127.24 ), ( 0, 20.41, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 54822.5, -30399.8, -121.28 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 54895.3, -30366.8, -121.29 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 54749.6, -30432.9, -125 ), ( 0, 114.47, 0 ), "echo_portal_spawn", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 55041.1, -30300.7, -121 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 54968.2, -30333.7, -121.02 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54865.8, -30307.6, -91 ), ( 0, 215.44, 0 ), "player_echo_reward_point", "cspf_0_auto5740635107105931247", "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54758, -30180.6, -121 ), ( 0, 308.82, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54917.9, -30116.2, -121 ), ( 0, 268.4, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54686.8, -30213.3, -124.13 ), ( 0, 322.16, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54844.7, -30151, -121 ), ( 0, 284.59, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54207.3, -29552.2, -127 ), ( 0, 298.42, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54861.2, -29430, -98.87 ), ( 0, 25.73, 0 ), "curse_inducer", undefined, "backyard1_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 54793, -32962.4, -121.6 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 54850, -32906.5, -121.56 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 54735.8, -33018.4, -122.08 ), ( 0, 134.47, 0 ), "echo_portal_spawn", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 54964.4, -32794.5, -125 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 54907.2, -32850.5, -121.53 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54802.1, -32860.9, -95.75 ), ( 0, 235.44, 0 ), "player_echo_reward_point", "cspf_0_auto11885356000693254064", "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54657.4, -32778.4, -124 ), ( 0, 328.82, 0 ), "cspf_0_auto11885356000693254064" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54785.6, -32663.3, -125 ), ( 0, 288.4, 0 ), "cspf_0_auto11885356000693254064" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54601.6, -32833.6, -124.31 ), ( 0, 342.16, 0 ), "cspf_0_auto11885356000693254064" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54728.7, -32721, -124 ), ( 0, 304.59, 0 ), "cspf_0_auto11885356000693254064" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 54115.3, -31776.2, -124 ), ( 0, 226.41, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55156.2, -31810, -130.04 ), ( 0, 224.49, 2 ), "echo_add_model", undefined, "big_crate_72x64" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 79515.4, -32299.7, -127 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 79552.4, -32228.9, -127 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 79478.4, -32370.7, -127 ), ( 0, 152.47, 0 ), "echo_portal_spawn", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 79626.6, -32087, -126.83 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 79589.5, -32158, -125.18 ), ( 0, 152.42, 0 ), "echo_portal_spawn", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79492.7, -32200.4, -105 ), ( 0, 253.44, 0 ), "player_echo_reward_point", "cspf_0_auto15215955256041133238", "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79329.6, -32166.7, -127 ), ( 0, 346.82, 0 ), "cspf_0_auto15215955256041133238" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79416, -32017.5, -127 ), ( 0, 306.4, 0 ), "cspf_0_auto15215955256041133238" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79293.6, -32236.3, -127 ), ( 0, 0.16, 0 ), "cspf_0_auto15215955256041133238" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79379.7, -32090, -127 ), ( 0, 322.59, 0 ), "cspf_0_auto15215955256041133238" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79054.2, -31801, 41.13 ), ( 0, 331.74, 0 ), "curse_inducer", undefined, "backyard2_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 79166.3, -31261.2, -127.24 ), ( 0, 20.41, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 77349.5, -30398.8, -121.28 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 77422.3, -30365.8, -121.29 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 77276.6, -30431.9, -125 ), ( 0, 114.47, 0 ), "echo_portal_spawn", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 77568.1, -30299.7, -121 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77495.2, -30332.7, -121.02 ), ( 0, 114.42, 0 ), "echo_portal_spawn", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77392.8, -30306.6, -91 ), ( 0, 215.44, 0 ), "player_echo_reward_point", "cspf_0_auto2888376370372424429", "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77285, -30179.6, -121 ), ( 0, 308.82, 0 ), "cspf_0_auto2888376370372424429" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77444.9, -30115.2, -121 ), ( 0, 268.4, 0 ), "cspf_0_auto2888376370372424429" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77213.8, -30212.3, -124.13 ), ( 0, 322.16, 0 ), "cspf_0_auto2888376370372424429" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77371.7, -30150, -121 ), ( 0, 284.59, 0 ), "cspf_0_auto2888376370372424429" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 76734.3, -29551.2, -127 ), ( 0, 298.42, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77388.2, -29429, -98.87 ), ( 0, 25.73, 0 ), "curse_inducer", undefined, "backyard1_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 77320, -32961.4, -121.6 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 77377, -32905.5, -121.56 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 77262.8, -33017.4, -122.08 ), ( 0, 134.47, 0 ), "echo_portal_spawn", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 77491.4, -32793.5, -125 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77434.2, -32849.5, -121.53 ), ( 0, 134.42, 0 ), "echo_portal_spawn", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77329.1, -32859.9, -95.75 ), ( 0, 235.44, 0 ), "player_echo_reward_point", "cspf_0_auto18405343789585344818", "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77184.4, -32777.4, -124 ), ( 0, 328.82, 0 ), "cspf_0_auto18405343789585344818" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77312.6, -32662.3, -125 ), ( 0, 288.4, 0 ), "cspf_0_auto18405343789585344818" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77128.6, -32832.6, -124.31 ), ( 0, 342.16, 0 ), "cspf_0_auto18405343789585344818" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77255.7, -32720, -124 ), ( 0, 304.59, 0 ), "cspf_0_auto18405343789585344818" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 76642.3, -31775.2, -124 ), ( 0, 226.41, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 76342.2, -31463, -92.87 ), ( 0, 225.25, 0 ), "curse_inducer", undefined, "street_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 78299.9, -30737.7, -127 ), ( 0, 258.42, 0 ), "player_echo_reward_point", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 78221.6, -30721.7, -125.25 ), ( 0, 258.42, 0 ), "player_echo_reward_point", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 78378.3, -30753.8, -125.25 ), ( 0, 258.47, 0 ), "player_echo_reward_point", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 78064.8, -30689.5, -127 ), ( 0, 258.42, 0 ), "player_echo_reward_point", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 78143.2, -30705.6, -126.79 ), ( 0, 258.42, 0 ), "player_echo_reward_point", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78210.7, -30786.9, -88 ), ( 0, 359.44, 0 ), "player_echo_reward_point", "cspf_0_auto2640247520364693875", "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78179.2, -30931, -123 ), ( 0, 76.82, 0 ), "cspf_0_auto2640247520364693875" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78052, -30895.1, -123 ), ( 0, 52.4, 0 ), "cspf_0_auto2640247520364693875" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78244.1, -30952.4, -123 ), ( 0, 86.16, 0 ), "cspf_0_auto2640247520364693875" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78111.7, -30916, -123 ), ( 0, 68.59, 0 ), "cspf_0_auto2640247520364693875" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 78928.2, -31237, -92.87 ), ( 0, 149.74, 0 ), "curse_inducer", undefined, "culdesac_p" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77694.3, -30567.2, -121.24 ), ( 0, 266.42, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77680.2, -31812, -132.52 ), ( 0, 224.49, 2 ), "echo_add_model", undefined, "big_crate_72x64" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77649.2, -31794, -133.5 ), ( 0, 218.38, 0 ), "echo_add_model", undefined, "t10_barrier_concrete_t_wall_01_full" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77742.2, -31844, -123.22 ), ( 0, 222.49, 0 ), "echo_add_model", undefined, "big_crate_72x64" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55125.2, -31792, -130.19 ), ( 0, 218.38, 0 ), "echo_add_model", undefined, "t10_barrier_concrete_t_wall_01_full" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55218.2, -31842, -123.87 ), ( 0, 222.49, 0 ), "echo_add_model", undefined, "big_crate_72x64" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55255.2, -31942, -124.13 ), ( 0, 218.38, 0 ), "echo_add_model", undefined, "t10_barrier_concrete_t_wall_01_full" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 53659.2, -32288, -92.87 ), ( 0, 315.25, 0 ), "curse_inducer", undefined, "street_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 77779.2, -31944, -122.46 ), ( 0, 218.38, 0 ), "echo_add_model", undefined, "t10_barrier_concrete_t_wall_01_full" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 55772.9, -30738.7, -127 ), ( 0, 258.42, 0 ), "echo_portal_spawn", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 55694.6, -30722.7, -125.25 ), ( 0, 258.42, 0 ), "echo_portal_spawn", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 55851.3, -30754.8, -125.25 ), ( 0, 258.47, 0 ), "echo_portal_spawn", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 55537.8, -30690.5, -127 ), ( 0, 258.42, 0 ), "echo_portal_spawn", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 55616.2, -30706.6, -126.79 ), ( 0, 258.42, 0 ), "echo_portal_spawn", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55683.7, -30787.9, -88 ), ( 0, 359.44, 0 ), "player_echo_reward_point", "cspf_0_auto328049938818646223", "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55696.2, -30954, -123 ), ( 0, 92.82, 0 ), "cspf_0_auto328049938818646223" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55529, -30912.1, -123 ), ( 0, 52.4, 0 ), "cspf_0_auto328049938818646223" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55773.1, -30969.4, -123 ), ( 0, 106.16, 0 ), "cspf_0_auto328049938818646223" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55608.7, -30927, -123 ), ( 0, 68.59, 0 ), "cspf_0_auto328049938818646223" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 56401.2, -31238, -92.87 ), ( 0, 149.74, 0 ), "curse_inducer", undefined, "culdesac_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 55167.3, -30568.2, -121.24 ), ( 0, 266.42, 0 ), "loot_buddy_chompy" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_ltm_echo_cs
// Params 0, eflags: 0x4
// Checksum 0xc09e4620, Offset: 0x215b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_ltm_echo_cs
// Params 0
// Checksum 0x5a18d4de, Offset: 0x2165
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_ltm_echo_cs" );
}

