// scripts\autotests\mp\test_mp_executions.gsc  (hash_08b3f05e0ae5fb77.gscc) (size: 20665 Bytes / 0x50b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe71df7e3 (3877500899)
// size ...... 20665 (0x50b9)
// includes .. 5   (offset: 0x3f61)
// strings ... 365 (offset: 0x3f89)
// dev strs .. 0   (offset: 0x50b9)
// exports ... 8   (offset: 0x397d)
// cseg ...... 0x27a9 + 0x11d4 (0x397d)
// imports ... 39  (offset: 0x3abd)
// animtree1 . 0   (offset: 0x50b9)
// animtree2 . 0   (offset: 0x50b9)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_video;
#using scripts\mp\execution;

#namespace test_mp_executions;

// Namespace test_mp_executions/testautomation
// Params 0, eflags: 0x20
// Checksum 0xc40dd526, Offset: 0x27c7
// Size: 0x2d
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_executions.gsc", #"GP", &start_test, &setup, &cleanup, &parameterize, undefined, 0 );
}

// Namespace test_mp_executions
// Params 0, eflags: 0x4
// Checksum 0x5170c6c, Offset: 0x27fc
// Size: 0xc6, Type: bool
function private setup()
{
    autotests_utility_video::function_5826175e5df28fd8();
    autotests::function_5c8c87763724c132();
    autotests::set_dvar( @"hash_eb038ca43332e718", 1 );
    player = autotests_utility_player::get_player();
    botdata = autotests_utility_bot::get_spawn_data( player, 3000 );
    spawned_bot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    spawned_bot function_3a7598d6982eb648( 1 );
    level.autotests.test_runtime.bot = spawned_bot;
    spawned_bot setplayerangles( vectortoangles( player.origin - botdata.origin + ( 0, 0, 0 ) ) );
    player = autotests_utility_player::get_player();
    player function_ffb0711adb6d8d0d();
    return true;
}

// Namespace test_mp_executions
// Params 1, eflags: 0x4
// Checksum 0x38fca6da, Offset: 0x28cb
// Size: 0xce9
function private parameterize( datasets )
{
    if ( !datasets || datasets.size == 0 )
    {
        return [];
    }
    
    dataset = datasets[ 0 ];
    t10_carry = [ "t10_mp_execution_knife_02", "t10_mp_execution_ice_ax_07", "t10_mp_execution_bat_06", "t10_mp_execution_code_royal_marine_054", "t10_mp_execution_powerkick", "t10_mp_execution_shrouded_hitman_023", "t10_mp_execution_goggle_squad_032", "t10_mp_execution_90s_action_figure_029", "t10_mp_execution_ice_ax_008", "t10_mp_execution_art_deco_sniper_034", "t10_mp_execution_steampunk_028", "t10_mp_execution_bong_m_044", "t10_mp_execution_barehand_016", "t10_mp_execution_bat_000", "t10_mp_execution_parasite_041", "t10_mp_execution_hyena_040", "t10_mp_execution_forge_dragon_055", "t10_mp_execution_tac_vampire_081", "t10_mp_execution_035_90s_plaid", "t10_mp_execution_027_high_class_hitman", "t10_mp_execution_078_cowboy_milsim", "t10_mp_execution_031_high_end_bodyguard", "t10_mp_execution_077_replacer", "t10_mp_execution_anime_snowboard_033", "t10_mp_execution_cybernetics_077", "t10_mp_execution_toxic_positivity_030", "t10_mp_execution_082_tsa_xray", "t10_mp_execution_037_tattooed_gangster", "t10_mp_execution_soccerkick", "t10_mp_execution_bad_nog_083", "t10_mp_execution_molly_051", "t10_mp_execution_052_clown", "t10_mp_execution_051_stingray_beta", "t10_mp_execution_tuna_050", "t10_mp_execution_070_bounty_hunter", "t10_mp_execution_059_90s_creature_moviemask", "t10_mp_execution_038_unicorn_light", "t10_mp_execution_058_lunar_new_year", "t10_mp_execution_jack_frost_024", "t10_mp_execution_slick_bank_robber_036", "t10_mp_execution_062_death_metal", "t10_mp_execution_064_jack_of_diamonds", "t10_mp_execution_069_cel_anime_motorcore", "t10_mp_execution_004_knife", "t10_mp_execution_073_battle_pass_01", "t10_mp_execution_artic_071", "t10_mp_execution_099_red_panda", "t10_mp_execution_072_aerospace_ops", "t10_mp_execution_015_barehand", "t10_mp_execution_068_ice_and_lava", "t10_mp_execution_neckbreak", "t10_mp_execution_074_battle_pass_02", "t10_mp_execution_077_see_no_evil", "t10_mp_execution_075_battle_pass_03", "t10_mp_execution_105_falcon", "t10_mp_execution_103_wolf", "t10_mp_execution_067_carnival", "t10_mp_execution_046_boba_jasmine", "t10_mp_execution_044_taro", "t10_mp_execution_048_brownsugar_thai", "t10_mp_execution_045_boba_assam", "t10_mp_execution_ferro_fluid_063", "t10_mp_execution_thai_047", "t10_mp_execution_101_battle_pass_s3_02", "t10_mp_execution_302_broccoli_cauliflower", "t10_mp_execution_095_king_card", "t10_mp_execution_374_battle_pass_8", "t10_mp_execution_comic_stip_300", "t10_mp_execution_301_tomato", "t10_mp_execution_305_german_shepard", "t10_mp_execution_370_care_package", "t10_mp_execution_hackerchip", "t10_mp_execution_306_battle_pass_04", "t10_mp_execution_paintball", "t10_mp_execution_096_glow_in_the_dark", "t10_mp_execution_375_battle_pass_9", "t10_mp_execution_373_sledgehammer", "t10_mp_execution_086_cardboard_mech", "t10_mp_execution_097_big_joke_2", "t10_mp_execution_304_bacon", "t10_mp_execution_376_replacer_f1driver_4", "t10_mp_execution_085_magic_girl_anime", "t10_mp_execution_091_viking", "t10_mp_execution_090_mr_peeks_easter", "t10_mp_execution_303_cucumber", "t10_mp_execution_089_deep_voyage_2", "t10_mp_execution_094_jekyll_hyde", "t10_mp_execution_087_humonculus", "t10_mp_execution_372_enforcer", "t10_mp_execution_088_bubble_lamp", "t10_mp_execution_404_dark_magic", "t10_mp_execution_300_archie_atom", "t10_mp_execution_406_cel_shaded_noir", "t10_mp_execution_407_arcade_fighter", "t10_mp_execution_409_anime_zombie", "t10_mp_execution_401_doberman", "t10_mp_execution_417_jaguar_luchador", "t10_mp_execution_hot_steel_rod_424", "t10_mp_execution_3d_printer_420", "t10_mp_execution_426_battlepass_s4", "t10_mp_execution_405_lightning_god", "t10_mp_execution_423_battlepass_s4", "t10_mp_execution_411_goated", "t10_mp_execution_419_blackcell_cerberus", "t10_mp_execution_goldbars", "t10_mp_execution_425_battlepass", "t10_mp_execution_402_bichon", "t10_mp_execution_403_bichon", "t10_mp_execution_414_goldennoodle", "t10_mp_execution_426_alien_queen", "t10_mp_execution_413_dino", "t10_mp_execution_408_poodle", "t10_mp_execution_513_battlepass_s5" ];
    var_3edc01e95535d039 = [ "execution_019", "neck_stab", "execution_053", "execution_mp_juggernaut_01", "execution_default", "execution_044", "execution_050", "execution_061", "execution_animal_002", "execution_025", "execution_087", "execution_038", "execution_065", "execution_076", "execution_006", "execution_066", "execution_098", "execution_008", "execution_017", "execution_060", "execution_mp_juggernaut_03", "execution_095", "execution_096", "execution_031", "execution_062", "execution_092", "execution_069", "execution_097", "execution_015", "execution_000", "execution_016", "execution_036", "execution_026", "execution_047", "execution_012", "execution_005", "execution_048", "execution_057", "execution_078", "execution_088", "execution_animal_001", "execution_064", "execution_039", "execution_073", "execution_011", "execution_mp_juggernaut_02", "execution_081", "execution_animal_003", "execution_animal_007", "execution_001", "execution_094", "execution_037", "execution_002", "execution_083", "execution_028", "execution_075", "execution_054", "execution_034", "execution_085", "execution_068", "execution_089", "execution_022", "execution_072", "execution_020", "execution_009", "execution_043", "execution_084", "execution_030", "execution_071", "execution_055", "execution_animal_004", "execution_067", "execution_041", "execution_052", "execution_086", "execution_042", "execution_010", "execution_080", "execution_024", "execution_animal_006", "execution_059", "execution_091", "execution_049", "execution_032", "execution_093", "execution_023", "execution_100", "execution_animal_000", "execution_056", "execution_004", "execution_029", "execution_045", "execution_058", "execution_099", "execution_033", "execution_animal_005", "execution_074", "execution_013", "execution_040", "execution_018", "execution_079", "execution_082", "execution_027", "execution_070", "execution_021", "execution_063", "execution_051", "execution_046", "execution_014", "execution_035", "execution_003", "execution_077", "execution_007", "execution_090", "execution_baton_jailer_00", "execution_baton_jailer_00_left", "execution_baton_jailer_00_right", "execution_baton_jailer_00_front", "execution_101", "execution_102", "execution_103", "execution_104", "execution_105", "execution_106", "execution_107", "execution_108", "execution_109", "execution_110", "execution_111", "execution_112", "execution_113", "execution_114", "execution_115", "execution_116", "execution_117", "execution_118", "execution_119", "execution_120", "mgl_execution_001", "execution_boss_swamp_monster_00", "execution_boss_swamp_monster_00_front", "execution_boss_butcher_00", "execution_boss_butcher_00_front", "execution_boss_mummy_00", "execution_boss_mummy_00_front" ];
    jup_carry = [ "jup_mp_execution_knife_01", "jup_mp_execution_kravmaga_01", "jup_mp_execution_silat_01", "jup_mp_execution_mike93_01", "jup_mp_execution_coscar635_01", "jup_mp_execution_uzulum_01", "jup_mp_execution_acharlie300_01", "jup_mp_execution_svictor_01", "jup_mp_execution_oromeo12_01", "jup_mp_execution_qbravo95_01", "jup_execution_first_person_000", "jup_execution_first_person_001", "jup_execution_first_person_002", "jup_mp_execution_cowboy_01", "jup_mp_execution_judo_01", "jup_mp_execution_break_01", "jup_mp_execution_sg_01", "jup_mp_execution_sn_01", "jup_mp_execution_smg_01", "jup_mp_execution_pkilo_01", "jup_mp_execution_muaythai_01", "jup_mp_execution_code_01", "jup_mp_execution_elf_02", "jup_mp_execution_recho870_01", "jup_mp_execution_beta_01", "jup_mp_execution_zeta_01", "jup_mp_execution_eta_01", "jup_mp_execution_gamma_01", "jup_execution_first_person_farah_001", "jup_mp_execution_banana_01", "jup_mp_execution_pineapple_01", "jup_mp_execution_plantain_01", "jup_mp_execution_plum_01", "jup_mp_execution_raspberry_01", "jup_mp_execution_strawberry_01", "jup_mp_execution_bow_01", "jup_mp_execution_doublebarrel_01", "jup_mp_execution_buzzsaw_01", "jup_mp_execution_bcs2_01", "jup_mp_execution_sportsbike_01", "jup_mp_execution_dog_01", "jup_mp_execution_dog_02_01", "jup_mp_takedown_sword_01_2", "jup_mp_takedown_sword_01_4", "jup_mp_takedown_sword_01_6", "jup_mp_takedown_sword_01_8", "jup_mp_takedown_strawberry_2", "jup_mp_takedown_strawberry_4", "jup_mp_takedown_strawberry_6", "jup_mp_takedown_strawberry_8", "jup_mp_execution_longsword_01", "jup_mp_execution_wonton_01", "jup_mp_execution_mandu_01", "jup_mp_execution_brownie_01", "jup_mp_execution_leveraction_01", "jup_mp_execution_flamethrower_01", "jup_mp_execution_ubgl_01", "jup_mp_execution_huevos_01", "jup_mp_execution_dance_01", "jup_mp_execution_batonknife_01", "jup_mp_execution_gunfu_01", "jup_mp_execution_tap_01", "jup_mp_execution_yeet_01", "jup_mp_execution_soccer_01", "jup_mp_execution_winter_01", "jup_mp_execution_dog_04", "jup_mp_execution_lightforce_01", "jup_mp_execution_fuel_01", "jup_mp_execution_mint_01", "jup_mp_execution_thyme_01", "jup_mp_execution_dill_01", "jup_mp_execution_woods_01", "jup_mp_takedown_sword_4001_01_2", "jup_mp_takedown_sword_4001_01_4", "jup_mp_takedown_sword_4001_01_8", "jup_mp_takedown_sword_4001_01_6", "jup_mp_execution_thyme_sage_01", "jup_mp_execution_ruby_01", "jup_mp_execution_chair_01", "jup_mp_execution_mochi_01", "jup_mp_execution_caramel_01", "jup_mp_execution_pbomb_01", "jup_mp_execution_gelato_01", "jup_mp_execution_copper_01", "jup_mp_execution_clay_01", "jup_mp_execution_mithril_01", "jup_mp_execution_bcs6_01", "jup_mp_execution_darts_01", "jup_mp_execution_caramel_01_slam", "jup_mp_execution_mochi_01_slam", "jup_mp_execution_gelato_01_slam", "jup_mp_execution_chair_01_slam", "jup_mp_execution_pbomb_01_slam", "jup_mp_takedown_sword_5019_01_2", "jup_mp_takedown_sword_5019_01_4", "jup_mp_takedown_sword_5019_01_6", "jup_mp_takedown_sword_5019_01_8" ];
    
    if ( dataset == "iw9" )
    {
        return var_3edc01e95535d039;
    }
    else if ( dataset == "jup" )
    {
        return jup_carry;
    }
    
    return t10_carry;
}

// Namespace test_mp_executions
// Params 0, eflags: 0x4
// Checksum 0xe0c5d5aa, Offset: 0x35bd
// Size: 0x29
function private cleanup()
{
    autotests_utility_video::function_2bddeed61c9c1561();
    autotests_utility_bot::kick_all_bots();
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
}

// Namespace test_mp_executions
// Params 0
// Checksum 0xcb97b30e, Offset: 0x35ee
// Size: 0x2b6
function start_test()
{
    execution = self.parameters[ 0 ];
    autotests::set_current_asset_name( execution );
    player = autotests_utility_player::get_player();
    spawn_data = autotests_utility_bot::get_spawn_data( player, -200 );
    front_data = autotests_utility_bot::get_spawn_data( player, 64 );
    bot = level.autotests.test_runtime.bot;
    starttime = gettime();
    
    while ( !isalive( player ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Player was not alive withing 5 seconds of test starting.", 0, "scripts/autotests/mp/test_mp_executions.gsc", 85 );
            return;
        }
    }
    
    starttime = gettime();
    
    while ( !isalive( bot ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Bot was not alive withing 5 seconds of test starting.", 0, "scripts/autotests/mp/test_mp_executions.gsc", 86 );
            return;
        }
    }
    
    testbundle = autotests::get_test_bundle( self.test.xhash_ref );
    bot autotests_utility_video::function_fa5160f0e09f8bf9( testbundle );
    player autotests_utility_video::function_fa5160f0e09f8bf9( testbundle );
    bot setorigin( spawn_data.origin );
    xoffset = 0;
    voffset = 0;
    playerattack = 1;
    
    if ( playerattack )
    {
        attacker = player;
        victim = bot;
    }
    else
    {
        attacker = bot;
        victim = player;
    }
    
    level.autotests.test_runtime.attackerangles = attacker getplayerangles();
    level.autotests.test_runtime.victimangles = victim getplayerangles();
    look_angles = vectortoangles( front_data.origin - attacker.origin + ( xoffset, 0, voffset ) );
    attacker setplayerangles( look_angles );
    victim setplayerangles( look_angles );
    victim setorigin( front_data.origin );
    starttime = gettime();
    
    while ( !victim isonground() )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Teleported player did not land on ground in 5 seconds.", 0, "scripts/autotests/mp/test_mp_executions.gsc", 118 );
            return;
        }
    }
    
    wait 1;
    attacker testexecution( execution );
    attacker setplayerangles( level.autotests.test_runtime.attackerangles );
    victim setplayerangles( level.autotests.test_runtime.victimangles );
    function_3abe1f9532a7887b( "g_freeClientCorpses 1" );
}

// Namespace test_mp_executions
// Params 1, eflags: 0x4
// Checksum 0xac5f7aba, Offset: 0x38ac
// Size: 0x60
function private testexecution( execution )
{
    execution::_giveexecution( execution );
    self.operatorcustomization.execution = self.executionref;
    wait 2;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "execute" );
    test_execute();
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "execute" );
}

// Namespace test_mp_executions
// Params 0, eflags: 0x4
// Checksum 0xc14df852, Offset: 0x3914
// Size: 0x69
function private test_execute()
{
    self botpressbutton( "melee", 2 );
    wait 0.5;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Execution started?", self isinexecutionattack(), "scripts/autotests/mp/test_mp_executions.gsc", 141 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    while ( self isinexecutionattack() )
    {
        waitframe();
    }
    
    wait 5;
}

