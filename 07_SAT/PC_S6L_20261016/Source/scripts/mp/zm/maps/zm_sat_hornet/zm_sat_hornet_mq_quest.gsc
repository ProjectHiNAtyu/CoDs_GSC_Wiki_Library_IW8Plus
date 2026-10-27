// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_mq_quest.gsc  (hash_5b24a895b2f8c407.gscc) (size: 311676 Bytes / 0x4c17c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae86858 (183003224)
// size ...... 311676 (0x4c17c)
// includes .. 58  (offset: 0x47424)
// strings ... 817 (offset: 0x475f4)
// dev strs .. 196 (offset: 0x4b7b4)
// exports ... 576 (offset: 0x35ba8)
// cseg ...... 0x451e + 0x3168a (0x35ba8)
// imports ... 1196 (offset: 0x3b5a8)
// animtree1 . 0   (offset: 0x4c17c)
// animtree2 . 0   (offset: 0x4c17c)
#using script_16ea1b94f0f381b3;
#using script_5a0c375c28690264;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\easing;
#using scripts\common\hud_util;
#using scripts\common\intel;
#using scripts\common\interactive_notes;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\doorbuy;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\player_banter;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_boss_fight;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ninja_kite;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_sakura;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_livingworld;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zombie_intel;

#namespace zm_sat_hornet_mq_quest;

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x5
// Checksum 0x18a7682c, Offset: 0x453c
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hornet_mq_quest", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x17c0c9bb, Offset: 0x4569
// Size: 0x59d
function function_7cf8dacb278a2665()
{
    if ( !getdvarint( @"enable_hornet_mq", 0 ) )
    {
        return;
    }
    
    scene::add_scene_func( "sat_cin_zm_vig_pap_smash_grab", &function_b534f739af4f3c49, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_pap_smash_grab", &function_26600a0de797bdbf, "callback_done" );
    namespace_c0b4f2882c9d100f::function_65f03bd58b4aa( "sat_zm_quest_hornet_purse", 1 );
    level utility::flag_wait( "zm_quest_initialized" );
    level.hornet_mq = zm_quest::get_quest( #"hornet_mq_quest" );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"light_lanterns", &function_800e934efeb3fe9d, &function_5ca9dbf851e48b0a );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"escort_shogun", &function_800e904efeb3f804, &function_5ca9daf851e488d7 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"retrieve_mask", &function_800e914efeb3fa37, &function_5ca9d9f851e486a4 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_c865abef877aecdb", &function_800e8e4efeb3f39e, &function_5ca9d8f851e48471 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_e4040d7209af1d17", &function_800e8f4efeb3f5d1, &function_5ca9d7f851e4823e );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_7f12f627b62cc20e", &function_800e8c4efeb3ef38, &function_5ca9d6f851e4800b );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_e29d8253603c9b5f", &function_800e8d4efeb3f16b, &function_5ca9d5f851e47dd8 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_466b7049ee9ee8ab", &function_800e8a4efeb3ead2, &function_5ca9d4f851e47ba5 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_9bb08f6254a92708", &function_800e8b4efeb3ed05, &function_5ca9d3f851e47972 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"approach_purse", &function_540ca3ba25d91677, &function_ae19fd1c199e308e );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_df33888db858b0b", &function_540ca2ba25d91444, &function_ae19fe1c199e32c1 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"collect_pages", &function_540ca5ba25d91add, &function_ae19fb1c199e2c28 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_e13f3a4a4601bbff", &function_540ca4ba25d918aa, &function_ae19fc1c199e2e5b );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"scroll_puzzle", &function_540c9fba25d90dab, &function_ae1a011c199e395a );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"get_pestle", &function_540c9eba25d90b78, &function_ae1a021c199e3b8d );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"bring_pestle", &function_540ca1ba25d91211, &function_ae19ff1c199e34f4 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"toxic_charge", &function_540ca0ba25d90fde, &function_ae1a001c199e3727 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_3a088bfdf160e3e3", &function_540c9bba25d904df, &function_ae19f51c199e1ef6 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_c6b9bdd390523ca3", &function_540c9aba25d902ac, &function_ae19f61c199e2129 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_a75ca3a6f6c75897", &function_53ff91ba25cada5c, &function_ae15771c19991405 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"get_supplies", &function_53ff92ba25cadc8f, &function_ae15761c199911d2 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"kintsugi_holdout", &function_53ff93ba25cadec2, &function_ae15751c19990f9f );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_9e3843889c7c2988", &function_53ff94ba25cae0f5, &function_ae15741c19990d6c );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"get_cup", &function_53ff8dba25cad190, &function_ae15731c19990b39 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"investigate_rooms", &function_53ff8eba25cad3c3, &function_ae15721c19990906 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"chase_hound", &function_53ff8fba25cad5f6, &function_ae15711c199906d3 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_b6128d4a2d97e51c", &function_53ff90ba25cad829, &function_ae15701c199904a0 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"get_clock_hand", &function_53ff99ba25caebf4, &function_ae157f1c1999259d );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"repair_clock", &function_53ff9aba25caee27, &function_ae157e1c1999236a );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"solve_banners", &function_540397ba25cedd65, &function_ae10f11c1993f77c );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"get_medallion", &function_540396ba25cedb32, &function_ae10f21c1993f9af );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"hash_c133b34a34982f8e", &function_540395ba25ced8ff, &function_ae10f31c1993fbe2 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"solve_mystery", &function_540394ba25ced6cc, &function_ae10f41c1993fe15 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"summon_hvt", &function_540393ba25ced499, &function_ae10ed1c1993eeb0 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"defeat_hvt", &function_540392ba25ced266, &function_ae10ee1c1993f0e3 );
    zm_quest::register_quest_step( #"hornet_mq_quest", #"release_pearl", &function_540391ba25ced033, &function_ae10ef1c1993f316 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_fdceacd4a723e647", &function_a4f35c61acb88b1 );
    equipment_mp::function_2e4e9b7492b36578( "equip_frag_hsg" );
    level callback::add( "special_round_scheduled", &function_9606e29bd262152e );
    
    /#
        init_mq_debug();
    #/
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x57f7ee59, Offset: 0x4b0e
// Size: 0x1d6
function postmain_init()
{
    if ( !getdvarint( @"enable_hornet_mq", 0 ) )
    {
        return;
    }
    
    level.hornet_mq.throttle = throttle::throttle_initialize( "hornet_mq", 1 );
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( "quest_item_used", &quest_item_used );
    level callback::add( #"hash_c677129e3ed530bc", &function_1dff160fff0074b9 );
    level scriptable::scriptable_addusedcallback( &function_44da2a208ba2b248 );
    level callback::add( #"hash_192d68b28556705b", &on_note_closed );
    level scriptable::scriptable_adddamagedcallback( &function_9a415159d7ab174 );
    level scriptable::scriptable_adddamagedcallback( &function_1d34aa3d950d5995 );
    level scriptable::scriptable_adddamagedcallback( &function_ace528f06f6036e8 );
    
    if ( !getdvarint( @"hash_fc73cc5cdf1c91a4", 0 ) )
    {
        level thread zm_quest::start_quest( #"hornet_mq_quest" );
    }
    
    level thread setup_murder_solution();
    level setup_evidence_shelf();
    level setup_graphic_screens();
    level setup_lanterns();
    level thread setup_scroll_puzzle();
    level function_fa0b214b7ee1dda7();
    level setup_gardener_flowers();
    level thread function_fb612c5b8894d299();
    level thread setup_produce_bags();
    level thread function_eaecbd445c6db062();
    level thread function_cef208d60878faf();
    level thread setup_plum_evidence();
    level thread setup_flower_evidence();
    level thread setup_pouch_item();
    level thread function_a82b58868927f4ae();
    level thread setup_coin_box();
    level setup_investigate_locs();
    level thread function_4b1fb87387d01647();
    level thread function_56733592b8210253();
    level setup_banner_locs();
    level thread function_ea169a9c73ed10ba();
    level thread setup_zodiac_dial();
    level thread function_eff0f78aa264032a();
    level thread function_ef0036fdd770b14d();
    level thread function_fb4e8f531e1e476b();
    level thread function_b8dfbdb19fb7f856();
    level thread function_2609ec2fda6e6a5e();
    level thread setup_audio_evidence();
    level thread function_c1827b18275d55d7();
    level utility::flag_set( "mq_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4273875d, Offset: 0x4cec
// Size: 0x2c
function function_51445825201dd469()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "" );
    level thread zm_quest::start_quest( #"hornet_mq_quest" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x305bd7f9, Offset: 0x4d20
// Size: 0x2a0
function setup_murder_solution()
{
    level zm_save::function_1f44a48caae2acbf();
    solution = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_31a970df2e88b6ab" );
    
    if ( !isdefined( solution ) )
    {
        solution = 0;
        solution = utility::set_bit_flag( solution, 0 );
        poison_index = utility::array_random( [ 6, 7, 8 ] );
        solution = utility::set_bit_flag( solution, poison_index );
        
        if ( poison_index == 6 )
        {
            accomplice_index = utility::array_random( [ 3, 4 ] );
        }
        else if ( poison_index == 7 )
        {
            accomplice_index = utility::array_random( [ 4, 5 ] );
        }
        else if ( poison_index == 8 )
        {
            accomplice_index = utility::array_random( [ 3, 5 ] );
        }
        
        solution = utility::set_bit_flag( solution, accomplice_index );
        var_17011eaaeed2dd22 = utility::array_random( [ 9, 10, 11 ] );
        solution = utility::set_bit_flag( solution, var_17011eaaeed2dd22 );
        solution = utility::set_bit_flag( solution, 14 );
        hour_index = utility::array_random( [ 22, 23, 24, 25, 26, 27 ] );
        solution = utility::set_bit_flag( solution, hour_index );
    }
    else
    {
        poison_index = function_24ae2266c03ce254( solution, [ 6, 7, 8 ] );
        accomplice_index = function_24ae2266c03ce254( solution, [ 3, 4, 5 ] );
        hour_index = function_24ae2266c03ce254( solution, [ 22, 23, 24, 25, 26, 27 ] );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_31a970df2e88b6ab", solution );
    level.hornet_mq.solution_info = { #poison_index:poison_index, #accomplice_index:accomplice_index, #hour_index:hour_index };
    level.hornet_mq.doc_data = {};
    level.hornet_mq.doc_data setup_document_data( level.hornet_mq.solution_info );
    level.hornet_mq.solution_info.dial_solution = setup_dial_solution( level.hornet_mq.solution_info );
    level utility::flag_set( "mq_mss_init_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x68e7d589, Offset: 0x4fc8
// Size: 0x8d
function function_24ae2266c03ce254( solution, range )
{
    foreach ( index in range )
    {
        if ( utility::get_bit_flag( solution, index ) )
        {
            return index;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x484da5f5, Offset: 0x505e
// Size: 0x11e
function setup_document_data( data )
{
    poison_index = data.poison_index;
    accomplice_index = data.accomplice_index;
    hour_index = data.hour_index;
    
    if ( poison_index == 6 )
    {
        if ( accomplice_index == 3 )
        {
            var_f4603954af61874 = "_paralysis";
        }
        else if ( accomplice_index == 4 )
        {
            var_f4603954af61874 = "_plant";
        }
    }
    else if ( poison_index == 7 )
    {
        if ( accomplice_index == 4 )
        {
            var_f4603954af61874 = "_food";
        }
        else if ( accomplice_index == 5 )
        {
            var_f4603954af61874 = "_paralysis";
        }
    }
    else if ( poison_index == 8 )
    {
        if ( accomplice_index == 3 )
        {
            var_f4603954af61874 = "_food";
        }
        else if ( accomplice_index == 5 )
        {
            var_f4603954af61874 = "_plant";
        }
    }
    
    self.var_f4603954af61874 = var_f4603954af61874;
    self.var_3caa7b068d2f476b = hour_index;
    pc_indices = [ 13, 14, 15 ];
    self.var_80e2d83e1c46eea0 = randomintrange( 1, pc_indices.size + 1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4f5bc855, Offset: 0x5184
// Size: 0x2
function function_1182df919f8e4d3f()
{
    
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x9daeeb83, Offset: 0x518e
// Size: 0x19c
function setup_dial_solution( data )
{
    poison_index = data.poison_index;
    hour_index = data.hour_index;
    pc_variant = level.hornet_mq.doc_data.var_80e2d83e1c46eea0;
    
    switch ( pc_variant )
    {
        case 1:
            fish_time = 1;
            plum_time = 2;
            flower_time = 1;
            break;
        case 2:
            fish_time = 2;
            plum_time = 3;
            flower_time = 2;
            break;
        case 3:
            fish_time = 3;
            plum_time = 4;
            flower_time = 2;
            break;
    }
    
    if ( poison_index == 6 )
    {
        time_mod = flower_time;
    }
    else if ( poison_index == 7 )
    {
        time_mod = fish_time;
    }
    else if ( poison_index == 8 )
    {
        time_mod = plum_time;
    }
    
    switch ( hour_index )
    {
        case 22:
            zodiac_hour = 4;
            break;
        case 23:
            zodiac_hour = 5;
            break;
        case 24:
            zodiac_hour = 6;
            break;
        case 25:
            zodiac_hour = 7;
            break;
        case 26:
            zodiac_hour = 8;
            break;
        case 27:
            zodiac_hour = 9;
            break;
    }
    
    if ( zodiac_hour - time_mod < 0 )
    {
        zodiac_hour += 12;
    }
    
    return zodiac_hour - time_mod;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x13ffcb76, Offset: 0x5333
// Size: 0x16e, Type: bool
function function_a1eae3cc9a535084()
{
    solution = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_31a970df2e88b6ab" );
    
    if ( !isdefined( level.hornet_mq.solve_attempts ) )
    {
        level.hornet_mq.solve_attempts = 0;
    }
    
    level.hornet_mq.solve_attempts += 1;
    
    foreach ( table in level.hornet_mq.evidence_tables.tables )
    {
        correct_evidence = function_993f78bfb5b651e4( table.script_noteworthy );
        
        if ( table.placed_evidence != correct_evidence )
        {
            return false;
        }
    }
    
    if ( level.hornet_mq.zodiac_dial.curr_hour != level.hornet_mq.solution_info.dial_solution )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc67c212e, Offset: 0x54aa
// Size: 0x16e
function function_993f78bfb5b651e4( st_category )
{
    solution = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_31a970df2e88b6ab" );
    
    switch ( st_category )
    {
        case #"hash_90259d6c553fba32":
            var_94a83d6470bc99fa = 0;
            break;
        case #"hash_c775b6c10b66b7a":
            var_94a83d6470bc99fa = [ 3, 4, 5 ];
            break;
        case #"hash_890e226c519dc6ab":
            var_94a83d6470bc99fa = [ 6, 7, 8 ];
            break;
        case #"hash_2f27486c2242f37d":
            var_94a83d6470bc99fa = [ 9, 10, 11 ];
            break;
        case #"hash_2894da6c1f0a5e33":
            var_94a83d6470bc99fa = 14;
            break;
    }
    
    if ( !isarray( var_94a83d6470bc99fa ) )
    {
        var_94a83d6470bc99fa = [ var_94a83d6470bc99fa ];
    }
    
    foreach ( evidence_index in var_94a83d6470bc99fa )
    {
        if ( utility::get_bit_flag( solution, evidence_index ) )
        {
            var_66600a1be51efa02 = function_11889a50be16a152( evidence_index );
        }
    }
    
    return var_66600a1be51efa02;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6873d47b, Offset: 0x5621
// Size: 0x76
function function_961f851ce570e9cb( st_category )
{
    if ( st_category != "acc" )
    {
        return;
    }
    
    switch ( function_993f78bfb5b651e4( st_category ) )
    {
        case #"hash_4e89e96c332989a2":
            note_ref = "zm_hornet_mq_acc_n";
            break;
        case #"hash_15519c6352de1cbf":
            note_ref = "zm_hornet_mq_acc_g";
            break;
        case #"hash_705898d5f7d98ffe":
            note_ref = "zm_hornet_mq_acc_m";
            break;
    }
    
    return note_ref;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xbe898844, Offset: 0x56a0
// Size: 0x121
function function_6e29e1bbb80eff60( var_85d6c71e334f1a13, var_b80830934ea8167a )
{
    if ( var_85d6c71e334f1a13 )
    {
        foreach ( zone in var_b80830934ea8167a )
        {
            level zm_sat_hornet_weather_ash::function_a0ca938f7360747e( zone );
        }
        
        if ( !level zm_sat_hornet_assault_rounds::get_assault_rounds_blocked() )
        {
            level zm_sat_hornet_assault_rounds::set_assault_rounds_blocked( 1 );
        }
        
        return;
    }
    
    foreach ( zone in var_b80830934ea8167a )
    {
        level zm_sat_hornet_weather_ash::function_35ed61636451860f( zone );
    }
    
    if ( level zm_sat_hornet_assault_rounds::get_assault_rounds_blocked() )
    {
        level zm_sat_hornet_assault_rounds::set_assault_rounds_blocked( 0 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 3, eflags: 0x4
// Checksum 0xd7dba9db, Offset: 0x57c9
// Size: 0x249
function private function_9947038abd0d1056( inv_item_ref, player = undefined, var_4468da2c811ea3bf = 1 )
{
    if ( inv_item_ref == #"pip" || inv_item_ref == #"case" || inv_item_ref == #"cmb" )
    {
        inv_quest_ref = #"mq";
        var_adf950527690eb80 = #"ev_sus";
        var_4468da2c811ea3bf = function_4f27d2823783c907( 2, 1, 0 );
    }
    else if ( inv_item_ref == #"shrs" || inv_item_ref == #"hat" || inv_item_ref == #"abc" )
    {
        inv_quest_ref = #"mq";
        var_adf950527690eb80 = #"ev_acc";
        var_4468da2c811ea3bf = function_4f27d2823783c907( 3, 4, 5 );
    }
    else if ( inv_item_ref == #"fug" || inv_item_ref == #"hash_353d73dcd4cf7d1" || inv_item_ref == #"ppts" )
    {
        inv_quest_ref = #"mq";
        var_adf950527690eb80 = #"ev_poi";
        var_4468da2c811ea3bf = function_4f27d2823783c907( 8, 6, 7 );
    }
    else if ( inv_item_ref == #"hrs" || inv_item_ref == #"twsk" || inv_item_ref == #"cal_kt" )
    {
        inv_quest_ref = #"mq";
        var_adf950527690eb80 = #"ev_loc";
        var_4468da2c811ea3bf = function_4f27d2823783c907( 10, 9, 11 );
    }
    else if ( inv_item_ref == #"hank" || inv_item_ref == #"med" || inv_item_ref == #"hash_b5616090e87b63f5" )
    {
        inv_quest_ref = #"mq";
        var_adf950527690eb80 = #"ev_mot";
        var_4468da2c811ea3bf = function_4f27d2823783c907( 12, 13, 14 );
    }
    else
    {
        inv_quest_ref = #"key_items";
        var_adf950527690eb80 = inv_item_ref;
    }
    
    curr_phase_index = zm_quest::function_23669314446ef229( inv_quest_ref );
    level zm_quest::function_b57dfe9625966b0b( inv_quest_ref, curr_phase_index, var_adf950527690eb80, var_4468da2c811ea3bf );
    
    if ( var_adf950527690eb80 == #"ev_mot" && var_4468da2c811ea3bf == 3 )
    {
        return;
    }
    
    if ( player )
    {
        level zm_quest::show_splash_item_picked_up( inv_quest_ref, var_adf950527690eb80, var_4468da2c811ea3bf, player );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x9c77b9a4, Offset: 0x5a1a
// Size: 0xce
function function_4f27d2823783c907( var_99647b7805fd76e5, var_9964787805fd704c, var_9964797805fd727f )
{
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" );
    
    if ( !isdefined( gathered_evidence ) )
    {
        gathered_evidence = 0;
    }
    
    var_9905c935fb02de76 = 0;
    
    if ( utility::get_bit_flag( gathered_evidence, var_99647b7805fd76e5 ) )
    {
        if ( utility::get_bit_flag( gathered_evidence, var_9964787805fd704c ) )
        {
            if ( utility::get_bit_flag( gathered_evidence, var_9964797805fd727f ) )
            {
                var_9905c935fb02de76 = 8;
            }
            else
            {
                var_9905c935fb02de76 = 5;
            }
        }
        else if ( utility::get_bit_flag( gathered_evidence, var_9964797805fd727f ) )
        {
            var_9905c935fb02de76 = 7;
        }
        else
        {
            var_9905c935fb02de76 = 2;
        }
    }
    else if ( utility::get_bit_flag( gathered_evidence, var_9964787805fd704c ) )
    {
        if ( utility::get_bit_flag( gathered_evidence, var_9964797805fd727f ) )
        {
            var_9905c935fb02de76 = 6;
        }
        else
        {
            var_9905c935fb02de76 = 3;
        }
    }
    else
    {
        var_9905c935fb02de76 = 4;
    }
    
    return var_9905c935fb02de76;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x481cf8b0, Offset: 0x5af1
// Size: 0x1ba
function function_cdc9ba0c3e381dfb( evidence_index )
{
    switch ( evidence_index )
    {
        case 0:
            item_ref = #"cmb";
            break;
        case 1:
            item_ref = #"case";
            break;
        case 2:
            item_ref = #"pip";
            break;
        case 3:
            item_ref = #"shrs";
            break;
        case 4:
            item_ref = #"hat";
            break;
        case 5:
            item_ref = #"abc";
            break;
        case 6:
            item_ref = #"hash_353d73dcd4cf7d1";
            break;
        case 7:
            item_ref = #"fug";
            break;
        case 8:
            item_ref = #"ppts";
            break;
        case 9:
            item_ref = #"twsk";
            break;
        case 10:
            item_ref = #"cal_kt";
            break;
        case 11:
            item_ref = #"hrs";
            break;
        case 12:
            item_ref = #"hash_b5616090e87b63f5";
            break;
        case 13:
            item_ref = #"hank";
            break;
        case 14:
            item_ref = #"med";
            break;
        default:
            item_ref = undefined;
            break;
    }
    
    return item_ref;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd2023ffe, Offset: 0x5cb4
// Size: 0x86
function function_fb4e8f531e1e476b()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    
    for ( i = 0; i < 15 ; i++ )
    {
        if ( utility::get_bit_flag( gathered_evidence, i ) )
        {
            item_ref = function_cdc9ba0c3e381dfb( i );
            
            if ( isdefined( item_ref ) )
            {
                function_9947038abd0d1056( item_ref );
            }
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0xfc5b8c4, Offset: 0x5d42
// Size: 0x1a
function private function_c1827b18275d55d7()
{
    level utility::flag_wait( "completed_ww_step_6" );
    wait 1;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xa6ddf876, Offset: 0x5d64
// Size: 0x27
function function_3582825f5c626855()
{
    if ( !level.directed_mode )
    {
        return;
    }
    
    if ( level utility::flag( "ar_active" ) )
    {
        return;
    }
    
    zm_quest::clear_all_guidance();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdeadf9e9, Offset: 0x5d93
// Size: 0x1385
function function_ecc91637c2a6fbb1()
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( !utility::flag( "completed_ww_step_6" ) )
    {
        return;
    }
    
    if ( level utility::flag( "ar_active" ) )
    {
        return;
    }
    
    if ( level utility::flag( "hornet_mq_mem_playing" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "mq_step_1_complete" ) )
    {
        level thread function_9307e26fc6b1ac5b();
        return;
    }
    
    if ( !level utility::flag( "mq_step_3_complete" ) )
    {
        if ( !level utility::flag( "mq_step_3_mem_complete" ) )
        {
            memory_loc = utility::getstruct( "memory_sus", "targetname" );
            level thread zm_quest::update_guidance( [ [ memory_loc.origin, 40 ] ], #"hornet_mq_guidance", #"hash_70bbef9962d38614" );
        }
        else
        {
            var_ad7d5b97217db5e2 = 0;
            
            foreach ( player in level.players )
            {
                if ( player utility::ent_flag( "hornet_mq_guided_taking_high_path" ) )
                {
                    var_ad7d5b97217db5e2 = 1;
                }
            }
            
            if ( var_ad7d5b97217db5e2 )
            {
                guidance_loc = utility::getstruct( "f_mask_spawn_loc", "targetname" );
            }
            else
            {
                guidance_loc = utility::getstruct( "koinobori_high_model", "targetname" );
            }
            
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"get_fmask" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_4_complete" ) )
    {
        guidance_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_608ee2813cf035d1" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_5_complete" ) )
    {
        level thread function_b1a3e47b82db53();
        return;
    }
    
    if ( !level utility::flag( "mq_step_6_complete" ) )
    {
        guidance_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_7f12f627b62cc20e" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_7_complete" ) )
    {
        level thread function_f2a12bb986799e7a();
        return;
    }
    
    if ( !level utility::flag( "mq_step_8_complete" ) )
    {
        guidance_loc = utility::getstruct( "dir_es_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_466b7049ee9ee8ab" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_9_complete" ) )
    {
        if ( !level utility::flag( "mq_directed_revealed_screen_sus" ) )
        {
            foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
            {
                if ( screen.script_noteworthy == "sus" )
                {
                    target_screen = screen;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ target_screen.origin ] ], #"hornet_mq_guidance", #"reveal_screen" );
        }
        else
        {
            level thread function_eebef3bed7218046();
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_10_complete" ) )
    {
        guidance_loc = utility::getstruct( "cnp_coalesce_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ], [ guidance_loc.origin, 0, 500 ] ], #"hornet_mq_guidance", #"hash_df33888db858b0b" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_11_complete" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.coin_purse ] ], #"hornet_mq_guidance", #"hash_df33888db858b0b" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_12_complete" ) )
    {
        if ( !callback::exists( #"player_connect", &function_9ae1fa35c0497979 ) )
        {
            level callback::add( #"player_connect", &function_9ae1fa35c0497979 );
        }
        
        level thread function_638cef3204d15db7();
        return;
    }
    
    if ( !level utility::flag( "mq_step_13_complete" ) )
    {
        if ( callback::exists( #"player_connect", &function_9ae1fa35c0497979 ) )
        {
            level callback::remove( #"player_connect", &function_9ae1fa35c0497979 );
        }
        
        guidance_loc = utility::getstruct( "dir_es_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_e13f3a4a4601bbff" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_14_complete" ) )
    {
        if ( !level utility::flag( "mq_directed_revealed_screen_acc" ) )
        {
            foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
            {
                if ( screen.script_noteworthy == "acc" )
                {
                    target_screen = screen;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ target_screen.origin ] ], #"hornet_mq_guidance", #"reveal_screen" );
        }
        else
        {
            guidance_loc = level.hornet_mq.scrolls[ 1 ][ 1 ];
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 32 ] ], #"hornet_mq_guidance", #"scroll_puzzle" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_15_complete" ) || isdefined( level.hornet_mq.var_870342c57e88eff7.records_struct ) || isdefined( level.hornet_mq.var_870342c57e88eff7.pestle ) )
    {
        if ( isdefined( level.hornet_mq.var_870342c57e88eff7.records_struct ) && isdefined( level.hornet_mq.var_870342c57e88eff7.pestle ) )
        {
            guidance_loc = ( level.hornet_mq.var_870342c57e88eff7.records_struct.origin + level.hornet_mq.var_870342c57e88eff7.pestle.origin ) / 2;
        }
        else if ( isdefined( level.hornet_mq.var_870342c57e88eff7.records_struct ) )
        {
            guidance_loc = level.hornet_mq.var_870342c57e88eff7.records_struct.origin;
        }
        else if ( isdefined( level.hornet_mq.var_870342c57e88eff7.pestle ) )
        {
            guidance_loc = level.hornet_mq.var_870342c57e88eff7.pestle.origin;
        }
        
        level thread zm_quest::update_guidance( [ [ guidance_loc, 16 ] ], #"hornet_mq_guidance", #"get_pestle" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_16_complete" ) )
    {
        guidance_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 16 ] ], #"hornet_mq_guidance", #"return_pestle" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_17_complete" ) )
    {
        guidance_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 16 ], [ guidance_loc.origin, 0, 350 ] ], #"hornet_mq_guidance", #"toxic_charge" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_18_complete" ) )
    {
        guidance_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 16 ] ], #"hornet_mq_guidance", #"hash_79c3a18887529d62" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_19_complete" ) )
    {
        level thread function_a4b3c6a115752f13();
        return;
    }
    
    if ( !level utility::flag( "mq_step_20_complete" ) )
    {
        guidance_loc = utility::getstruct( "dir_es_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4dce8349f27173fe" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_21_complete" ) )
    {
        if ( !level utility::flag( "mq_directed_revealed_screen_poi" ) )
        {
            foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
            {
                if ( screen.script_noteworthy == "poi" )
                {
                    target_screen = screen;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ target_screen.origin ] ], #"hornet_mq_guidance", #"reveal_screen" );
        }
        else
        {
            var_dd4f64c5a98cbcce = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6" ) ?? 0;
            
            if ( !utility::get_bit_flag( var_dd4f64c5a98cbcce, 0 ) )
            {
                guidance_loc = utility::getstruct( "knts_shard_spawn", "targetname" );
                level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_532dda045fee7884" );
            }
            else if ( !utility::get_bit_flag( var_dd4f64c5a98cbcce, 1 ) )
            {
                guidance_loc = utility::getstruct( "knts_shard_spawn_2", "targetname" );
                level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_532ddd045fee7d9d" );
            }
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_22_complete" ) )
    {
        if ( level.hornet_mq.var_c44feadec8f65180 )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.var_c44feadec8f65180.origin ] ], #"hornet_mq_guidance", #"hash_532dda045fee7884" );
        }
        else if ( !level.hornet_mq.s_cup.sbl )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.var_4f641d5d0ca98ee7.interact.origin ] ], #"hornet_mq_guidance", #"hash_14d3993d57e50dae" );
        }
        else
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.s_cup.sbl.origin ] ], #"hornet_mq_guidance", #"hash_14d3983d57e50bfb" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_23_complete" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.s_cup.sbl.origin ] ], #"hornet_mq_guidance", #"hash_9e3843889c7c2988" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_24_complete" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.s_cup.sbl.origin ] ], #"hornet_mq_guidance", #"hash_c612ef6ad1afe08e" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_25_complete" ) )
    {
        level thread update_investigate_guidance();
        return;
    }
    
    if ( !level utility::flag( "mq_step_26_complete" ) )
    {
        if ( isalive( level.hornet_mq.chase_hellhound ) )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.chase_hellhound, 64 ] ], #"hornet_mq_guidance", #"hash_c612f36ad1afe75a" );
        }
        else
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.var_14e2b5af3f8ececf.origin ] ], #"hornet_mq_guidance", #"hash_c612f26ad1afe5a7" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_27_complete" ) )
    {
        guidance_loc = utility::getstruct( "dir_es_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_b6128d4a2d97e51c" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_29_complete" ) )
    {
        if ( !( level utility::flag( "mq_directed_revealed_screen_loc_a" ) || level utility::flag( "mq_directed_revealed_screen_loc_b" ) || level utility::flag( "mq_directed_revealed_screen_loc_c" ) || level utility::flag( "mq_directed_revealed_screen_loc" ) ) )
        {
            foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
            {
                if ( screen.script_noteworthy == "loc" )
                {
                    target_screen = screen;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ target_screen.origin ] ], #"hornet_mq_guidance", #"reveal_screen" );
        }
        else
        {
            guidance_loc = level.hornet_mq.clock.hand_loc;
            level thread zm_quest::update_guidance( [ [ guidance_loc ] ], #"hornet_mq_guidance", #"calibrate_clock" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_30_complete" ) )
    {
        level function_27407a0f6f588b45();
        return;
    }
    
    if ( !level utility::flag( "mq_step_31_complete" ) )
    {
        guidance_loc = level.hornet_mq.medallion;
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"get_medallion" );
        return;
    }
    
    if ( !level utility::flag( "mq_all_ev_delivered" ) )
    {
        if ( !level utility::flag( "mq_player_got_ev_mot_take" ) )
        {
            level function_dd1fff69d05a7ba3();
        }
        else
        {
            guidance_loc = utility::getstruct( "dir_es_loc", "targetname" );
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_c133b34a34982f8e" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_33_complete" ) )
    {
        if ( !level utility::flag( "mq_directed_revealed_screen_mot" ) )
        {
            foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
            {
                if ( screen.script_noteworthy == "mot" )
                {
                    target_screen = screen;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ target_screen.origin ] ], #"hornet_mq_guidance", #"reveal_screen" );
        }
        else
        {
            level function_6b7a2fa43d516d9e();
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_step_34_complete" ) )
    {
        guidance_loc = level.hornet_mq.var_28c45c5d375ce1a1;
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"pursue_truth" );
        return;
    }
    
    if ( !level utility::flag( "mq_step_35_complete" ) )
    {
        if ( isalive( level.hornet_mq.onryo ) )
        {
            if ( !level utility::flag( "onryo_multi_mask_active" ) )
            {
                hud_data = [ [ level.hornet_mq.onryo, 80 ] ];
                guidance = #"defeat_hvt";
            }
            else
            {
                guidance_loc = utility::getstruct( "ev_circ_struct", "targetname" );
                hud_data = [ [ guidance_loc.origin, 0, 650 ] ];
                guidance = #"hash_43d1787b00ad68b7";
            }
        }
        else
        {
            hud_data = undefined;
            guidance = #"defeat_hvt";
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
        return;
    }
    
    if ( !level utility::flag( "mq_step_36_complete" ) )
    {
        guidance_loc = level.hornet_mq.bossfight_interact;
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"boss_warp" );
        return;
    }
    
    level function_3582825f5c626855();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc12ba540, Offset: 0x7120
// Size: 0x155
function function_9307e26fc6b1ac5b()
{
    self notify( #"hash_6b612051f4a6d0da" );
    self endon( #"hash_6b612051f4a6d0da" );
    
    if ( level utility::flag( "mq_lanterns_timed_out" ) )
    {
        level zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_376b382f7c71fb00" );
        return;
    }
    
    target_lantern = undefined;
    
    foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
    {
        if ( !var_cb5369743609abbe.var_8be48bacaa8fcd16 )
        {
            target_lantern = var_cb5369743609abbe;
            break;
        }
    }
    
    guidance = level utility::flag( "mq_step_1_fll" ) ? #"hash_81aec5964d66b6b" : #"light_lanterns";
    guidance_pos = target_lantern.origin + anglestoup( target_lantern.angles ) * 42;
    level zm_quest::update_guidance( [ [ guidance_pos ] ], #"hornet_mq_guidance", guidance );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xcf6be07f, Offset: 0x727d
// Size: 0x1d2
function function_b1a3e47b82db53()
{
    self notify( #"hash_31eb81d56f701c0d" );
    self endon( #"hash_31eb81d56f701c0d" );
    circle_center_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
    
    if ( level utility::flag( "n_mask_puzzle_reenabled" ) )
    {
        guidance = #"hash_965886e8e00e98bb";
        guidance_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        hud_data = [ [ guidance_loc.origin ] ];
    }
    else if ( level utility::flag( "n_mask_puzzle_active" ) && !level utility::flag( "n_mask_puzzle_round_active" ) )
    {
        if ( level utility::flag( "n_mask_puzzle_waiting_to_progress" ) )
        {
            guidance = #"hash_965886e8e00e98bb";
            guidance_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
            hud_data = [ [ guidance_loc.origin ] ];
        }
        else
        {
            guidance = #"simon_says";
            hud_data = [ [ circle_center_loc.origin, 0, 330 ] ];
        }
    }
    else if ( !level utility::flag( "n_mask_puzzle_active" ) && !level utility::flag( "n_mask_puzzle_round_active" ) )
    {
        guidance = #"hash_37c1ecd6badd5dbf";
        hud_data = undefined;
    }
    else
    {
        guidance = #"simon_says";
        guidance_loc = level.hornet_mq.noh_puzzle.wall_masks[ level.hornet_mq.noh_puzzle.var_d4cee9ef8c97d5f6 ].origin;
        hud_data = [ [ guidance_loc ] ];
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3ee6e9f9, Offset: 0x7457
// Size: 0x298
function function_f2a12bb986799e7a()
{
    if ( !level utility::flag( "fmask_hiding" ) && !( level.hornet_mq.ev_pipe || level.hornet_mq.ev_case || level.hornet_mq.ev_comb ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.f_mask.linkedparent ] ], #"hornet_mq_guidance", #"chase_mask" );
        return;
    }
    
    if ( !( level.hornet_mq.ev_pipe || level.hornet_mq.ev_case || level.hornet_mq.ev_comb ) )
    {
        if ( !level utility::flag( "hornet_mq_players_near_hidden_mask" ) )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.f_mask.hiding_data.origin ] ], #"hornet_mq_guidance", #"hash_e003b704d0555ba8" );
        }
        else
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_mq.f_mask.hiding_data.origin, 0, level.hornet_mq.f_mask.hiding_data.radius ] ], #"hornet_mq_guidance", #"hash_e003b704d0555ba8" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_ev_sus_p" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.ev_pipe ] ], #"hornet_mq_guidance", #"hash_f89af80ae7d02787" );
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_ev_sus_ca" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.ev_case ] ], #"hornet_mq_guidance", #"hash_f89af80ae7d02787" );
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_ev_sus_co" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.ev_comb ] ], #"hornet_mq_guidance", #"hash_f89af80ae7d02787" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xbd128ea0, Offset: 0x76f7
// Size: 0x2ee
function function_eebef3bed7218046()
{
    self notify( #"hash_706f8fb9341bb027" );
    self endon( #"hash_706f8fb9341bb027" );
    var_2d3ca5735ec11867 = 0;
    
    foreach ( player in level.players )
    {
        maneki_neko_weap = player.var_e6d8cfcc28a79324[ "secondary" ].basename == "sat_maneki_neko_zm" ? player.var_e6d8cfcc28a79324[ "secondary" ] : undefined;
        
        if ( !maneki_neko_weap )
        {
            continue;
        }
        
        maneki_neko_count = player getammocount( maneki_neko_weap );
        
        if ( maneki_neko_count > 0 )
        {
            var_2d3ca5735ec11867 = 1;
            break;
        }
    }
    
    var_693e19bf9d182dc8 = 0;
    
    if ( level utility::flag( "powerup_fire_sale_active" ) )
    {
        var_693e19bf9d182dc8 = 1;
    }
    else
    {
        foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
        {
            if ( var_349a0723ed9ac19c.var_f14b2b4820b635e7 || var_349a0723ed9ac19c.var_9870f882980ab31b )
            {
                if ( var_349a0723ed9ac19c == level.hornet_mq.coin_box )
                {
                    var_693e19bf9d182dc8 = 1;
                    continue;
                }
                
                current_magicbox = var_349a0723ed9ac19c;
            }
        }
    }
    
    if ( !var_693e19bf9d182dc8 )
    {
        hud_data = [ [ current_magicbox.origin ] ];
        guidance = #"hash_bec26e3541234237";
    }
    else if ( !var_2d3ca5735ec11867 && !level utility::flag( "mq_mnk_set" ) )
    {
        hud_data = [ [ level.ww_neko.mdl_table.interact, 16 ] ];
        guidance = #"hash_9b37a9987e86aa4f";
    }
    else if ( level utility::flag( "mq_mnk_set" ) )
    {
        hud_data = [ [ level.hornet_mq.coin_box, 32 ] ];
        guidance = #"hash_3320fe4935be9cf8";
    }
    else
    {
        hud_data = [ [ level.hornet_mq.coin_box, 32 ] ];
        guidance = #"coin_box";
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x304583c6, Offset: 0x79ed
// Size: 0x14
function function_9ae1fa35c0497979( params )
{
    level thread function_638cef3204d15db7();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdc0eea32, Offset: 0x7a09
// Size: 0x7a
function function_638cef3204d15db7()
{
    self notify( #"hash_fb707141c97f53fb" );
    self endon( #"hash_fb707141c97f53fb" );
    
    if ( !level utility::flag( "mq_player_got_ev_acc_n" ) || !level utility::flag( "solve_mq_read_note_zm_hornet_mq_acc_n" ) )
    {
        level function_aa3603f619e66aef();
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_ev_acc_g" ) || !level utility::flag( "solve_mq_read_note_zm_hornet_mq_acc_g" ) )
    {
        level function_b7321236dc0ee761();
        return;
    }
    
    level function_92a9c283804a148b();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6646c2a4, Offset: 0x7a8b
// Size: 0x2d8
function function_aa3603f619e66aef()
{
    if ( !level utility::flag( "mq_acc_n_summoned" ) )
    {
        hud_data = [];
        
        foreach ( shutter in level.hornet_mq.var_7261a69b7d3f75cf )
        {
            if ( !shutter.has_decoy )
            {
                hud_data[ hud_data.size ] = [ shutter.origin ];
            }
        }
        
        var_9572786461dd9316 = level.hornet_mq.var_7261a69b7d3f75cf.size;
        
        if ( !isdefined( var_9572786461dd9316 ) )
        {
            var_9572786461dd9316 = 3;
        }
        
        progress = var_9572786461dd9316 - hud_data.size;
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"acc_n_summon" );
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"acc_n_summon" );
        
        if ( !level callback::exists( "on_round_start", &function_d19695bcd9b54d7c ) )
        {
            level callback::add( "on_round_start", &function_d19695bcd9b54d7c );
        }
        
        if ( !level utility::flag( "ar_active" ) )
        {
            zm_sat_hornet_assault_rounds::function_40eb772f9085ef92( 1, 1 );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_acc_n_killed" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.noble_zombie, 84 ] ], #"hornet_mq_guidance", #"acc_n_defeat" );
        
        if ( level callback::exists( "on_round_start", &function_d19695bcd9b54d7c ) )
        {
            level callback::remove( "on_round_start", &function_d19695bcd9b54d7c );
        }
        
        if ( !level utility::flag( "ar_active" ) )
        {
            zm_sat_hornet_assault_rounds::function_40eb772f9085ef92( 0 );
        }
        
        return;
    }
    
    hud_data = [];
    
    if ( isdefined( level.hornet_mq.var_da95bf2359181d00 ) && !level utility::flag( "mq_player_got_ev_acc_n" ) )
    {
        hud_elem = [ level.hornet_mq.var_da95bf2359181d00.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    if ( isdefined( level.hornet_mq.var_7170dedf1eee0ac2 ) && !level utility::flag( "solve_mq_read_note_zm_hornet_mq_acc_n" ) )
    {
        hud_elem = [ level.hornet_mq.var_7170dedf1eee0ac2.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"acc_n_gather" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x595789be, Offset: 0x7d6b
// Size: 0x5c
function function_d19695bcd9b54d7c( params )
{
    if ( level utility::flag( "mq_acc_n_summoned" ) )
    {
        if ( level callback::exists( "on_round_start", &function_d19695bcd9b54d7c ) )
        {
            level callback::remove( "on_round_start", &function_d19695bcd9b54d7c );
        }
    }
    
    if ( !level utility::flag( "ar_active" ) )
    {
        zm_sat_hornet_assault_rounds::function_40eb772f9085ef92( 1, 1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd8266ea6, Offset: 0x7dcf
// Size: 0x754
function function_b7321236dc0ee761()
{
    if ( !level utility::flag( "mq_acc_g_summoned" ) )
    {
        hud_data = [];
        
        foreach ( weed_struct in level.hornet_mq.weed_structs )
        {
            if ( !weed_struct.b_grown )
            {
                hud_data[ hud_data.size ] = [ weed_struct.center_origin + ( 0, 0, 20 ) ];
            }
        }
        
        var_76f07d52c9e0e108 = level.hornet_mq.weed_structs.size;
        
        if ( !isdefined( var_76f07d52c9e0e108 ) )
        {
            var_76f07d52c9e0e108 = 3;
        }
        
        progress = var_76f07d52c9e0e108 - hud_data.size;
        
        foreach ( player in level.players )
        {
            player function_d385bd2c55eb7da9();
        }
        
        waitframe();
        level zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_5570161f86bccd74" );
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"hash_5570161f86bccd74" );
        waitframe();
        
        foreach ( player in level.players )
        {
            zm_quest::function_1a1a1e0bd84ac45e( player );
        }
        
        foreach ( player in level.players )
        {
            if ( !player.var_ce3e987a55fb9239 )
            {
                closest_bucket = undefined;
                
                foreach ( s_bucket in level.hornet_mq.var_8d695c4a2be21565 )
                {
                    if ( !closest_bucket )
                    {
                        closest_bucket = s_bucket.bucket;
                        var_7f97bb28affb1cbf = distance2dsquared( closest_bucket.origin, player.origin );
                        continue;
                    }
                    
                    if ( distance2dsquared( s_bucket.bucket.origin, player.origin ) < var_7f97bb28affb1cbf )
                    {
                        closest_bucket = s_bucket.bucket;
                        var_7f97bb28affb1cbf = distance2dsquared( s_bucket.bucket.origin, player.origin );
                    }
                }
                
                if ( closest_bucket )
                {
                    level zm_quest::function_38cacc34ddb8431c( player );
                    player thread function_dc0ce077cc93cb0c( closest_bucket, "hornet_mq_pp_guidance_wp_bucket_" + player.name, 0, #"hash_5570181f86bcd0da" );
                }
                
                continue;
            }
            
            if ( !player.var_976664409e016652 )
            {
                guidance_loc = utility::getstruct( "dir_bathhouse_loc", "targetname" );
                
                if ( guidance_loc )
                {
                    level zm_quest::function_38cacc34ddb8431c( player );
                    player thread function_dc0ce077cc93cb0c( guidance_loc, "hornet_mq_pp_guidance_wp_bucket_" + player.name, 200, #"hash_5570171f86bccf27" );
                }
            }
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_acc_g_killed" ) )
    {
        foreach ( player in level.players )
        {
            player function_d385bd2c55eb7da9();
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_mq_guidance", #"hash_5570181f86bcd0da" );
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_mq_guidance", #"hash_5570171f86bccf27" );
            player zm_quest::function_fb3af5600f6a9441( 0, 0, #"hornet_mq_guidance", #"hash_5570181f86bcd0da" );
            player zm_quest::function_fb3af5600f6a9441( 0, 0, #"hornet_mq_guidance", #"hash_5570171f86bccf27" );
            zm_quest::function_1a1a1e0bd84ac45e( player );
        }
        
        hud_data = [];
        var_dc9e30ef0d417936 = 0;
        
        foreach ( plant_struct in level.hornet_mq.a_plants )
        {
            if ( plant_struct.var_f6115109f5cdd47c )
            {
                var_dc9e30ef0d417936 = 1;
                hud_data[ hud_data.size ] = [ plant_struct.raised_loc.origin + ( 0, 0, 80 ) ];
            }
        }
        
        if ( var_dc9e30ef0d417936 )
        {
            guidance = #"acc_g_defeat";
        }
        else
        {
            hud_element = [ level.hornet_mq.gardener_zombie, 64 ];
            hud_data[ hud_data.size ] = hud_element;
            guidance = #"hash_71db9009d76263e3";
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
        return;
    }
    
    hud_data = [];
    
    if ( isdefined( level.hornet_mq.var_4064357a5936b62a ) && !level utility::flag( "mq_player_got_ev_acc_g" ) )
    {
        hud_elem = [ level.hornet_mq.var_4064357a5936b62a.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    if ( isdefined( level.hornet_mq.var_3ee868880e6db754 ) && !level utility::flag( "solve_mq_read_note_zm_hornet_mq_acc_g" ) )
    {
        hud_elem = [ level.hornet_mq.var_3ee868880e6db754.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"acc_g_gather" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6c706f70, Offset: 0x852b
// Size: 0x369
function function_92a9c283804a148b()
{
    if ( !level utility::flag( "mq_acc_m_f_a_pickup_active" ) && !level utility::flag( "mq_acc_m_fr_drop_success" ) )
    {
        if ( level utility::flag( "mq_basket_empty_a" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_5fae516e1851e299" );
        }
        else
        {
            guidance_loc = utility::function_30dbabe3200518b( "fruit_basket_persimmon", #targetname );
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_9e9c5e650229e480" );
        }
        
        return;
    }
    
    if ( !isalive( level.hornet_mq.fruit_zombie ) && !level utility::flag( "mq_acc_m_fr_drop_success" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.dropped_persimmon ], [ level.hornet_mq.dropped_persimmon.origin, 0, 1680 ] ], #"hornet_mq_guidance", #"hash_9e9c61650229e999" );
        return;
    }
    
    if ( !level utility::flag( "mq_acc_m_fr_drop_success" ) )
    {
        if ( level utility::flag( "directed_mode_persimmon_zombie_near_merchant_shack" ) )
        {
            guidance = #"hash_ad9f4fa2ad34654c";
        }
        else
        {
            guidance = #"hash_9e9c60650229e7e6";
        }
        
        hud_data = [ [ level.hornet_mq.fruit_zombie, 88 ], [ level.hornet_mq.merchant_trig.origin, 48 ], [ level.hornet_mq.merchant_trig.origin, 0, 128 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
        return;
    }
    
    if ( !level utility::flag( "mq_acc_m_killed" ) )
    {
        if ( isalive( level.hornet_mq.merchant_zombie ) )
        {
            hud_data = [ [ level.hornet_mq.merchant_zombie, 64 ] ];
        }
        else
        {
            hud_data = undefined;
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"acc_m_defeat" );
        return;
    }
    
    hud_data = [];
    
    if ( isdefined( level.hornet_mq.var_db3547b19ab47ec ) && !level utility::flag( "mq_player_got_ev_acc_m" ) )
    {
        hud_elem = [ level.hornet_mq.var_db3547b19ab47ec.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    if ( isdefined( level.hornet_mq.var_785464c716d43c5e ) && !level utility::flag( "solve_mq_read_note_zm_hornet_mq_acc_m" ) )
    {
        hud_elem = [ level.hornet_mq.var_785464c716d43c5e.origin, 16 ];
        hud_data[ hud_data.size ] = hud_elem;
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"acc_m_gather" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd34fa115, Offset: 0x889c
// Size: 0x9b
function function_a4b3c6a115752f13()
{
    self notify( #"hash_193df08f2004d252" );
    self endon( #"hash_193df08f2004d252" );
    
    if ( !level utility::flag( "mq_player_got_f_poi" ) )
    {
        fish_loc = utility::getstruct( "mq_f_poi_spawn_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ fish_loc.origin ] ], #"hornet_mq_guidance", #"get_poi_f" );
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_p_poi" ) )
    {
        level function_51d17d0cd087b559();
        return;
    }
    
    level function_d97dbc65c1a1e32();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x9dac5f46, Offset: 0x893f
// Size: 0x126
function function_51d17d0cd087b559()
{
    if ( !level utility::flag( "mq_acc_m_p_sqsh_active" ) )
    {
        if ( level utility::flag( "mq_basket_empty_u" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_4cc2fe372fc00c9e" );
        }
        else
        {
            guidance_loc = utility::function_30dbabe3200518b( "fruit_basket_plum", #targetname );
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_9419d1f90a823b4f" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_acc_m_p_sqsh_success" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.current_plum.origin ] ], #"hornet_mq_guidance", #"hash_9419d2f90a823d02" );
        return;
    }
    
    level thread zm_quest::update_guidance( [ [ level.hornet_mq.pits.origin ] ], #"hornet_mq_guidance", #"hash_9419d3f90a823eb5" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x9d2e41e2, Offset: 0x8a6d
// Size: 0x4d3
function function_d97dbc65c1a1e32()
{
    if ( !level utility::flag( "mq_player_got_fbud" ) )
    {
        guidance_loc = utility::getstruct( "mq_m_poi_appear_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_5c4f8be5155867e7" );
        return;
    }
    
    if ( !level utility::flag( "mq_pch_dislodged" ) )
    {
        guidance_loc = utility::getstruct( "mq_pouch_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_5c4f8ce51558699a" );
        return;
    }
    
    if ( !level utility::flag( "mq_player_got_pch" ) )
    {
        guidance_loc = utility::getstruct( "mq_pouch_fall_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_5c4f8de515586b4d" );
        return;
    }
    
    if ( !level utility::flag( "mq_gathered_apch" ) )
    {
        if ( !zm_sat_hornet_weather_ash::function_989fd2b3918fb9da() )
        {
            level.hornet_mq.var_62a2941168be1a18 = undefined;
            level thread zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_5c4f86e515585f68" );
        }
        else if ( !level.hornet_mq.var_62a2941168be1a18 )
        {
            var_b80830934ea8167a = zm_sat_hornet_weather_ash::function_8928ea3a422bbcaf();
            var_86b832c9eb3baf34 = utility::array_random( var_b80830934ea8167a );
            guidance_loc = function_be6ad4ecaa95fe7e( var_86b832c9eb3baf34 );
            level.hornet_mq.var_62a2941168be1a18 = guidance_loc;
            level thread zm_quest::update_guidance( [ [ guidance_loc.origin ], [ guidance_loc.origin, 0, 700 ] ], #"hornet_mq_guidance", #"hash_5c4f87e51558611b" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "mq_apch_emptied" ) )
    {
        guidance_loc = utility::getstruct( "mq_m_poi_place_loc", "targetname" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_5c4f88e5155862ce" );
        return;
    }
    
    if ( !level utility::flag( "mq_poi_fl_grown" ) )
    {
        var_8047c5019ffae070 = [];
        
        foreach ( player in level.players )
        {
            if ( player utility::ent_flag( "skr_buff" ) )
            {
                var_8047c5019ffae070[ var_8047c5019ffae070.size ] = player;
            }
        }
        
        if ( var_8047c5019ffae070.size == 0 && !level utility::flag( "mq_sakura_storm_in_flower_range" ) )
        {
            if ( level.sakura_root.var_c7cc42d5608bad9d.size == 0 )
            {
                hud_data = undefined;
                guidance = #"hash_338c3043453368a0";
            }
            else
            {
                if ( level.hornet_mq.var_4f2a806134a15d78 )
                {
                    tree = level.hornet_mq.var_4f2a806134a15d78;
                }
                else
                {
                    tree = zm_sat_hornet_weather_sakura::select_tree();
                    level.hornet_mq.var_4f2a806134a15d78 = tree;
                }
                
                if ( isdefined( tree ) )
                {
                    hud_data = [ [ tree.origin ] ];
                    guidance = #"hash_338c334345336db9";
                }
                else
                {
                    hud_data = undefined;
                    guidance = #"hash_338c3043453368a0";
                    level.hornet_mq.var_4f2a806134a15d78 = undefined;
                }
            }
        }
        else if ( var_8047c5019ffae070.size >= 0 && !level utility::flag( "mq_sakura_storm_in_flower_range" ) )
        {
            guidance_loc = utility::getstruct( "mq_m_poi_place_loc", "targetname" );
            hud_data = [ [ guidance_loc.origin ], [ guidance_loc.origin, 0, 350 ] ];
            guidance = #"hash_5c4f89e515586481";
        }
        else
        {
            hud_data = [ [ guidance_loc.origin ] ];
            guidance = #"hash_338c324345336c06";
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", guidance );
        return;
    }
    
    guidance_loc = utility::getstruct( "mq_m_poi_place_loc", "targetname" );
    level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_5c4f82e51558589c" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x17963890, Offset: 0x8f48
// Size: 0x3f
function function_be6ad4ecaa95fe7e( ash_zone_name )
{
    var_a6ef7c3b0f3824a4 = zm_utility::function_fbb7d4c98261e273( ash_zone_name );
    s_waypoint = utility::getstruct( "ash_wp_" + var_a6ef7c3b0f3824a4, "targetname" );
    return s_waypoint;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x929c3bd5, Offset: 0x8f90
// Size: 0x2d2
function update_investigate_guidance()
{
    if ( !isdefined( level.hornet_mq.revealed_items ) )
    {
        level.hornet_mq.revealed_items = [];
    }
    
    level.hornet_mq.revealed_items = function_5713d46873b29625( level.hornet_mq.revealed_items );
    
    if ( !level utility::flag( "mq_got_scup" ) && !( level utility::flag( "mq_inv_loc_succeeded" ) || level utility::flag( "mq_inv_loc_active" ) ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.s_cup.sbl.origin ] ], #"hornet_mq_guidance", #"hash_c612ef6ad1afe08e" );
        return;
    }
    
    if ( !level utility::flag( "mq_inv_loc_active" ) && !level.hornet_mq.revealed_items.size > 0 )
    {
        hud_data = [];
        
        foreach ( loc in level.hornet_mq.investigate_locs )
        {
            if ( !loc.var_2389aa3c5f35b020 )
            {
                hud_data[ hud_data.size ] = [ loc.origin ];
            }
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_c612ee6ad1afdedb" );
        return;
    }
    
    if ( !level.hornet_mq.revealed_items.size > 0 )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_mq.defend_cup.origin ] ], #"hornet_mq_guidance", #"hash_c612ed6ad1afdd28" );
        return;
    }
    
    hud_data = [];
    
    foreach ( item in level.hornet_mq.revealed_items )
    {
        if ( item )
        {
            hud_data[ hud_data.size ] = [ item ];
        }
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_c612f46ad1afe90d" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdee732, Offset: 0x926a
// Size: 0x382
function function_27407a0f6f588b45()
{
    if ( level.hornet_mq.banner_puzzle.banners_recovered < level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7.size )
    {
        if ( !level utility::flag( "ar_active" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_78c0c96c46024d98" );
        }
        
        return;
    }
    
    if ( !function_6d2b9cfdd36913a() )
    {
        curr_zone = level.hornet_mq.banner_puzzle.zone_roots.size - 1;
        
        for ( i = 0; i < level.hornet_mq.banner_puzzle.zone_roots.size ; i++ )
        {
            if ( level.hornet_mq.banner_puzzle.zone_roots[ i ].sum != level.hornet_mq.clock.sequence[ i ] )
            {
                curr_zone = i;
                break;
            }
        }
        
        curr_zone = min( curr_zone, level.hornet_mq.banner_puzzle.zone_roots.size - 1 );
        
        switch ( curr_zone )
        {
            case 0:
                ref = #"hash_fe3f7154d4275859";
                break;
            case 1:
                ref = #"hash_fe3f6e54d4275340";
                break;
            case 2:
                ref = #"hash_fe3f6f54d42754f3";
                break;
            case 3:
            default:
                ref = #"hash_fe3f7454d4275d72";
                break;
        }
        
        banner_midpoint = ( level.hornet_mq.banner_puzzle.zone_roots[ curr_zone ].place_locs[ 0 ].origin + level.hornet_mq.banner_puzzle.zone_roots[ curr_zone ].place_locs[ 1 ].origin ) / 2;
        var_74e5ff44bcadcf72 = ( -249.158, -22473, 198.37 );
        hud_data = [ [ banner_midpoint ], [ var_74e5ff44bcadcf72 ], [ var_74e5ff44bcadcf72, 0, 400 ] ];
        level zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", ref );
        level zm_quest::function_9f49b2a045ece8ae( level.hornet_mq.banner_puzzle.zone_roots[ curr_zone ].sum, 1, #"hornet_mq_guidance", ref );
        level zm_quest::function_c2af37f835cd840b( level.hornet_mq.clock.sequence[ curr_zone ], 1, #"hornet_mq_guidance", ref );
        return;
    }
    
    guidance_loc = level.hornet_mq.clock.hand_loc;
    level thread zm_quest::update_guidance( [ [ guidance_loc ] ], #"hornet_mq_guidance", #"reactivate_clock" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x821fb4f8, Offset: 0x95f4
// Size: 0x199
function function_dd1fff69d05a7ba3()
{
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( s_flow in var_d9662461fbddd8e6 )
    {
        if ( s_flow.script_noteworthy == "westbailey" )
        {
            target_flow = s_flow;
            break;
        }
    }
    
    if ( !target_flow.iscooled )
    {
        hud_data = undefined;
        ref = #"hash_c00e561ab0f2d2ec";
    }
    else if ( !level utility::flag( "mq_br_mot_ev_launched" ) )
    {
        hud_data = [ [ level.hornet_mq.bro_carving.linkedparent ], [ level.hornet_mq.bro_carving.linkedparent, 0, 32 ] ];
        ref = #"hash_c00e591ab0f2d805";
    }
    else
    {
        hud_data = [ [ level.hornet_mq.var_54ecbb8f70471080.origin ] ];
        ref = #"hash_c00e581ab0f2d652";
    }
    
    level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", ref );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb500b05c, Offset: 0x9795
// Size: 0xbba
function function_6b7a2fa43d516d9e()
{
    if ( level.hornet_mq.var_b13513a678ed761 )
    {
        guidance_loc = level.hornet_mq.var_b13513a678ed761;
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_72927120be6bf741" );
        return;
    }
    
    if ( !level utility::flag( "mq_guided_correct_acc_test_received" ) )
    {
        level function_51cadb8d6154468e();
        return;
    }
    
    if ( level utility::flag( "hornet_mq_wrng_sol_entered" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_98e5557a6c937420" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_lit_burner_1" ) && !level utility::flag( "mq_solve_process_started" ) )
    {
        var_c4a1c8e3495b1ed1 = getentitylessscriptablearray( "mq_in_bn_loc", #targetname );
        
        foreach ( s_incense in var_c4a1c8e3495b1ed1 )
        {
            if ( s_incense.script_noteworthy == "dis" )
            {
                guidance_loc = s_incense;
            }
        }
        
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_ccfc4d02cd012c6b" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_player_has_ev_sus" ) && !level utility::flag( "solve_mq_correct_ev_placed_sus" ) )
    {
        guidance_loc = function_1cc936c807d90a4( "sus" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 5 ] ], #"hornet_mq_guidance", #"hash_d704808dda7f6217" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_correct_ev_placed_sus" ) )
    {
        foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
        {
            if ( var_8c6af4441aab050c.script_noteworthy == "sus" )
            {
                guidance_loc = var_8c6af4441aab050c;
                break;
            }
        }
        
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4503240130ff021f" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_player_has_ev_acc" ) && !level utility::flag( "solve_mq_correct_ev_placed_acc" ) )
    {
        guidance_loc = function_1cc936c807d90a4( "acc" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 5 ] ], #"hornet_mq_guidance", #"hash_11a2f0985cc44ef6" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_correct_ev_placed_acc" ) )
    {
        foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
        {
            if ( var_8c6af4441aab050c.script_noteworthy == "acc" )
            {
                guidance_loc = var_8c6af4441aab050c;
                break;
            }
        }
        
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_acc_n" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_acc_m" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_acc_g" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_plant" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_food" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4503240130ff021f" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_has_cr_ex_poi" ) )
    {
        hud_data = [];
        var_6ca39bdfbe732823 = function_961f851ce570e9cb( "acc" );
        
        if ( !level utility::flag( "solve_mq_read_note_" + var_6ca39bdfbe732823 ) )
        {
            note_struct = utility::getstruct( var_6ca39bdfbe732823, "targetname" );
            hud_data[ hud_data.size ] = [ note_struct.origin ];
        }
        
        if ( !level utility::flag( "solve_mq_read_note_zm_hornet_mq_pc" ) )
        {
            note_struct = utility::getstruct( "zm_hornet_mq_pc", "targetname" );
            hud_data[ hud_data.size ] = [ note_struct.origin ];
        }
        
        if ( !( level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_plant" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_food" ) ) )
        {
            note_struct = utility::getstruct( "zm_hornet_mq_dr", "targetname" );
            hud_data[ hud_data.size ] = [ note_struct.origin ];
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_1fbc7f8e80aebebf" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_player_has_ev_poi" ) && !level utility::flag( "solve_mq_correct_ev_placed_poi" ) )
    {
        guidance_loc = function_1cc936c807d90a4( "poi" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 5 ] ], #"hornet_mq_guidance", #"hash_667c82f3325894bc" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_correct_ev_placed_poi" ) )
    {
        foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
        {
            if ( var_8c6af4441aab050c.script_noteworthy == "poi" )
            {
                guidance_loc = var_8c6af4441aab050c;
                break;
            }
        }
        
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4503240130ff021f" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_appr_graphic" ) )
    {
        guidance_loc = utility::function_30dbabe3200518b( "loc", #script_noteworthy );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_1aedbebe16b5227c" );
        level thread function_9be1f973613c4cc( guidance_loc );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_player_has_ev_loc" ) && !level utility::flag( "solve_mq_correct_ev_placed_loc" ) )
    {
        guidance_loc = function_1cc936c807d90a4( "loc" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 5 ] ], #"hornet_mq_guidance", #"hash_383bea8f20becfda" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_correct_ev_placed_loc" ) )
    {
        foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
        {
            if ( var_8c6af4441aab050c.script_noteworthy == "loc" )
            {
                guidance_loc = var_8c6af4441aab050c;
                break;
            }
        }
        
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4503240130ff021f" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_player_has_ev_mot" ) && !level utility::flag( "solve_mq_correct_ev_placed_mot" ) )
    {
        guidance_loc = function_1cc936c807d90a4( "mot" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin, 5 ] ], #"hornet_mq_guidance", #"hash_3ff7ec8f24dd6720" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_correct_ev_placed_mot" ) )
    {
        foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
        {
            if ( var_8c6af4441aab050c.script_noteworthy == "mot" )
            {
                guidance_loc = var_8c6af4441aab050c;
                break;
            }
        }
        
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_plant" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_dr_food" );
        level utility::flag_clear( "solve_mq_read_note_zm_hornet_mq_pc" );
        level utility::flag_clear( "solve_mq_has_cr_ex_tme" );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_4503240130ff021f" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_has_cr_ex_tme" ) )
    {
        hud_data = [];
        
        if ( !level utility::flag( "solve_mq_read_note_zm_hornet_mq_pc" ) )
        {
            note_struct = utility::getstruct( "zm_hornet_mq_pc", "targetname" );
            hud_data[ hud_data.size ] = [ note_struct.origin ];
        }
        
        if ( !( level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_plant" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_food" ) ) )
        {
            note_struct = utility::getstruct( "zm_hornet_mq_dr", "targetname" );
            hud_data[ hud_data.size ] = [ note_struct.origin ];
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_68ee3bec67e3f5b" );
        return;
    }
    
    if ( !level utility::flag( "solve_mq_zd_d_set_correct" ) )
    {
        guidance_loc = getent( "zd_mdl_hand", #targetname );
        level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_2b71824b496d13e9" );
        return;
    }
    
    var_c4a1c8e3495b1ed1 = getentitylessscriptablearray( "mq_in_bn_loc", #targetname );
    
    foreach ( s_incense in var_c4a1c8e3495b1ed1 )
    {
        if ( s_incense.script_noteworthy == "sol" )
        {
            guidance_loc = s_incense;
        }
    }
    
    level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_ccfc4e02cd012e1e" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xff30b03b, Offset: 0xa357
// Size: 0x1f8
function function_51cadb8d6154468e()
{
    if ( !level.hornet_mq.var_a3569cd04eed51b )
    {
        hud_data = [];
        
        foreach ( ghost_struct in level.hornet_mq.var_a83fe95ced8fdb4 )
        {
            if ( ghost_struct.var_bf0a22dcb2f3138d )
            {
                continue;
            }
            
            hud_data_struct = [ ghost_struct.trap_root, 90 ];
            hud_data[ hud_data.size ] = hud_data_struct;
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_58db116e919a12d1" );
        return;
    }
    
    if ( level.hornet_mq.var_a3569cd04eed51b.num_kills < 20 )
    {
        hud_data = [ [ level.hornet_mq.var_a3569cd04eed51b.trap_root.origin, 90 ], [ level.hornet_mq.var_a3569cd04eed51b.trap_root.origin, 0, 500 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hornet_mq_guidance", #"hash_58db0e6e919a0db8" );
        return;
    }
    
    guidance_loc = level.hornet_mq.var_a3569cd04eed51b;
    level thread zm_quest::update_guidance( [ [ guidance_loc.origin ] ], #"hornet_mq_guidance", #"hash_58db0f6e919a0f6b" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xd8385be1, Offset: 0xa557
// Size: 0x166
function function_1cc936c807d90a4( st_category )
{
    correct_ref = function_993f78bfb5b651e4( st_category );
    
    foreach ( var_8c6af4441aab050c in level.hornet_mq.evidence_tables.tables )
    {
        if ( var_8c6af4441aab050c.placed_evidence == correct_ref )
        {
            guidance_loc = var_8c6af4441aab050c;
            break;
        }
    }
    
    if ( guidance_loc )
    {
        return guidance_loc;
    }
    
    foreach ( struct in level.hornet_mq.evidence_shelf.evidence_structs )
    {
        if ( struct.script_noteworthy == correct_ref )
        {
            guidance_loc = struct;
            break;
        }
    }
    
    return guidance_loc;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x3c5b77e7, Offset: 0xa6c6
// Size: 0x158
function function_9be1f973613c4cc( graphic_loc )
{
    near_radius = 150;
    observe_time_sec = 2;
    step = 0.1;
    time_elapsed = 0;
    
    while ( true )
    {
        if ( time_elapsed >= observe_time_sec )
        {
            break;
        }
        
        near_players = getplayersinradius( graphic_loc.origin, near_radius );
        
        /#
            sphere( graphic_loc.origin, near_radius, ( 1, 1, 1 ), 0, int( step / level.framedurationseconds ) );
        #/
        
        var_490b28fb5c703838 = 0;
        
        foreach ( player in near_players )
        {
            if ( utility::function_af749a6c1f8241f0( player, graphic_loc.origin ) )
            {
                var_490b28fb5c703838 = 1;
                break;
            }
        }
        
        if ( var_490b28fb5c703838 )
        {
            time_elapsed += step;
        }
        else
        {
            time_elapsed = 0;
        }
        
        wait step;
    }
    
    level utility::flag_set( "solve_mq_appr_graphic" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0xcd52b12b, Offset: 0xa826
// Size: 0x1c0
function function_dc0ce077cc93cb0c( guidance_loc, objective_name, circle_radius = 0, guidance_ref )
{
    function_d385bd2c55eb7da9();
    origin = guidance_loc.origin;
    waitframe();
    self.var_4e6d456b37bda90c = guidance_ref;
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hornet_mq_guidance", guidance_ref );
    zm_quest::function_fb3af5600f6a9441( 2, 0, #"hornet_mq_guidance", guidance_ref );
    self.var_c4801e1b22df8773 = zm_quest::function_b98d4144845ffc13( objective_name, 1, "ui_icon_zm_objective", "icon_small_medium", "current", origin, undefined, undefined, undefined, 0, 1 );
    
    if ( circle_radius > 0 )
    {
        var_22b49e580e7fd151 = spawnstruct();
        var_22b49e580e7fd151.index = 0;
        var_22b49e580e7fd151.radius = circle_radius;
        var_22b49e580e7fd151.origin = origin;
        var_22b49e580e7fd151 game_utility::questcircle_create( "testCircle_Orange", var_22b49e580e7fd151.origin, var_22b49e580e7fd151.radius );
        var_22b49e580e7fd151 game_utility::questcircle_showtoplayer( self );
        self.var_8e3478d1b43b5b1b = var_22b49e580e7fd151;
    }
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.var_c4801e1b22df8773, player );
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( self.var_c4801e1b22df8773, player );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd75a7155, Offset: 0xa9ee
// Size: 0x7e
function function_d385bd2c55eb7da9()
{
    if ( self.var_4e6d456b37bda90c )
    {
        zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_mq_guidance", self.var_4e6d456b37bda90c );
        zm_quest::function_fb3af5600f6a9441( 0, 0, #"hornet_mq_guidance", self.var_4e6d456b37bda90c );
    }
    
    if ( isdefined( self.var_c4801e1b22df8773 ) )
    {
        zm_quest::complete_objective_waypoints( self.var_c4801e1b22df8773 );
    }
    
    if ( isdefined( self.var_8e3478d1b43b5b1b ) )
    {
        self.var_8e3478d1b43b5b1b game_utility::questcircle_delete();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x2fde6272, Offset: 0xaa74
// Size: 0x43
function private function_800e934efeb3fe9d( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "mq_setup_complete" );
    level function_c04278a79d481af4();
    level utility::flag_wait( "mq_step_1_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xd2521866, Offset: 0xaabf
// Size: 0x48
function private function_5ca9dbf851e48b0a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_1_complete" );
        level thread function_661528427ae66e80();
        return;
    }
    
    level scriptable::function_65c9f35ffd4310f8( "lantern_damaged_notify", &function_9a415159d7ab174 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x66d894d5, Offset: 0xab0f
// Size: 0x36
function private function_800e904efeb3f804( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_57c3735267969937();
    level utility::flag_wait( "mq_step_2_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x1834e358, Offset: 0xab4d
// Size: 0x21
function private function_5ca9daf851e488d7( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x529965cf, Offset: 0xab76
// Size: 0x54
function private function_800e914efeb3fa37( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_3_complete" );
        level function_9947038abd0d1056( #"f_mask" );
        return;
    }
    
    level thread function_d8e9a758971850eb();
    level utility::flag_wait( "mq_step_3_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x131b37fa, Offset: 0xabd2
// Size: 0x97
function private function_5ca9d9f851e486a4( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_3_complete" );
        return;
    }
    
    if ( level.hornet_mq.nk_fmask )
    {
        level.hornet_mq.nk_fmask utility::delaycall( level.framedurationseconds, &freescriptable );
    }
    
    if ( callback::exists( #"hash_285de7f1c47ba90d", &function_e155348135692fa6 ) )
    {
        level callback::remove( #"hash_285de7f1c47ba90d", &function_e155348135692fa6 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x4930107b, Offset: 0xac71
// Size: 0x10c
function private function_800e8e4efeb3f39e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        place_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        level.hornet_mq.f_mask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", place_loc.origin, ( 0, 10, 90 ) );
        level.hornet_mq.f_mask_interact = interaction::register_interact( place_loc.origin, 80, &function_680eaba440fa62ce, &function_b298b61b50a32644 );
        level utility::flag_set( "mq_step_4_complete" );
        return;
    }
    
    place_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
    level.hornet_mq.f_mask_interact = interaction::register_interact( place_loc.origin, 80, &function_680eaba440fa62ce, &function_b298b61b50a32644 );
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_4_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xf157466d, Offset: 0xad85
// Size: 0x21
function private function_5ca9d8f851e48471( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xbdf7f8a0, Offset: 0xadae
// Size: 0x43
function private function_800e8f4efeb3f5d1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_5_complete" );
        return;
    }
    
    level thread function_9b32453437b6c5cf();
    level utility::flag_wait( "mq_step_5_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x422ce272, Offset: 0xadf9
// Size: 0x2e
function private function_5ca9d7f851e4823e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_5_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x33b85316, Offset: 0xae2f
// Size: 0x36
function private function_800e8c4efeb3ef38( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level function_bafeaf3a28b49b48();
    level utility::flag_wait( "mq_step_6_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x301208cb, Offset: 0xae6d
// Size: 0x2e
function private function_5ca9d6f851e4800b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_6_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xb5e127c5, Offset: 0xaea3
// Size: 0x36
function private function_800e8d4efeb3f16b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_d503cd35783a2003();
    level utility::flag_wait( "mq_step_7_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xa8d75363, Offset: 0xaee1
// Size: 0x2e
function private function_5ca9d5f851e47dd8( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_7_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x2f482e8e, Offset: 0xaf17
// Size: 0xcf
function private function_800e8a4efeb3ead2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_4b3dca338605aff3 = [ 1, 0, 2 ];
        
        foreach ( evidence in var_4b3dca338605aff3 )
        {
            level function_fd1996af0db6a8ca( evidence );
        }
        
        level deliver_evidence( 1 );
        return;
    }
    
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_8_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xc963157f, Offset: 0xafee
// Size: 0x2e
function private function_5ca9d4f851e47ba5( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_8_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x9b34189f, Offset: 0xb024
// Size: 0x63
function private function_800e8b4efeb3ed05( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level function_792c7fa14bdc067( "sus" );
        level function_9947038abd0d1056( #"hash_77f372195699d154" );
        return;
    }
    
    level thread function_792c7fa14bdc067( "sus", 1 );
    level thread function_10c9ef343431801b();
    level utility::flag_wait( "mq_step_9_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x3f811415, Offset: 0xb08f
// Size: 0x1aa
function private function_5ca9d3f851e47972( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_9_complete" );
        return;
    }
    
    level.hornet_mq.var_2fcc157edc12dbf1 = undefined;
    
    if ( level.hornet_mq.ghost_coin )
    {
        level.hornet_mq.ghost_coin freescriptable();
    }
    
    if ( level callback::exists( "zm_perk_obtained", &update_player_perks ) )
    {
        level callback::remove( "zm_perk_obtained", &update_player_perks );
    }
    
    if ( level callback::exists( "zm_perk_lost", &update_player_perks ) )
    {
        level callback::remove( "zm_perk_lost", &update_player_perks );
    }
    
    if ( level.directed_mode )
    {
        if ( !level callback::exists( #"equipment_given", &function_d4ba804bf48616b9 ) )
        {
            level callback::remove( #"equipment_given", &function_d4ba804bf48616b9 );
        }
        
        if ( !level callback::exists( #"equipment_ammo_set", &function_d4ba804bf48616b9 ) )
        {
            level callback::remove( #"equipment_ammo_set", &function_d4ba804bf48616b9 );
        }
        
        if ( !level callback::exists( #"hash_9325330e77aef2ad", &on_fire_sale ) )
        {
            level callback::remove( #"hash_9325330e77aef2ad", &on_fire_sale );
        }
        
        if ( !level callback::exists( #"firesale_end", &function_fea81c3cdaf819f4 ) )
        {
            level callback::remove( #"firesale_end", &function_fea81c3cdaf819f4 );
        }
        
        if ( !level callback::exists( "field_upgrade_used", &on_field_upgrade_used ) )
        {
            level callback::remove( "field_upgrade_used", &on_field_upgrade_used );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xbaea689a, Offset: 0xb241
// Size: 0x36
function private function_540ca3ba25d91677( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_ee3368c6e69f3ca1();
    level utility::flag_wait( "mq_step_10_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xecfae69f, Offset: 0xb27f
// Size: 0x2e
function private function_ae19fd1c199e308e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_10_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x22dc6d43, Offset: 0xb2b5
// Size: 0x36
function private function_540ca2ba25d91444( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level function_15168f0e9fd3075d();
    level utility::flag_wait( "mq_step_11_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x8b45a3c, Offset: 0xb2f3
// Size: 0x7f
function private function_ae19fe1c199e32c1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_11_complete" );
        return;
    }
    
    if ( isdefined( level.hornet_mq.coin_purse ) )
    {
        level.hornet_mq.coin_purse.linkedparent delete();
        level.hornet_mq.coin_purse freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xd6f0d57, Offset: 0xb37a
// Size: 0x36
function private function_540ca5ba25d91add( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread setup_accomplice_zombies();
    level utility::flag_wait( "mq_step_12_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x601578e, Offset: 0xb3b8
// Size: 0x2e
function private function_ae19fb1c199e2c28( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_12_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xbf1c6897, Offset: 0xb3ee
// Size: 0xc8
function private function_540ca4ba25d918aa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_4b3dca338605aff3 = [ 4, 3, 5 ];
        
        foreach ( evidence in var_4b3dca338605aff3 )
        {
            level function_fd1996af0db6a8ca( evidence );
        }
        
        level deliver_evidence( 1 );
        return;
    }
    
    level utility::flag_wait( "mq_step_13_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x9ec40c26, Offset: 0xb4be
// Size: 0x2e
function private function_ae19fc1c199e2e5b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_13_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xd1eee7, Offset: 0xb4f4
// Size: 0x5a
function private function_540c9fba25d90dab( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level function_792c7fa14bdc067( "acc" );
        level thread function_3a17f3a04d485be3();
        return;
    }
    
    level thread function_792c7fa14bdc067( "acc", 1 );
    level thread function_d890706f97462680();
    level utility::flag_wait( "mq_step_14_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xe27c82fc, Offset: 0xb556
// Size: 0x2e
function private function_ae1a011c199e395a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_14_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xfd22d56a, Offset: 0xb58c
// Size: 0x97
function private function_540c9eba25d90b78( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( level.hornet_mq.var_870342c57e88eff7.pestle ) )
        {
            level.hornet_mq.var_870342c57e88eff7.pestle freescriptable();
        }
        
        level utility::flag_set( "mq_step_15_complete" );
        level function_9947038abd0d1056( #"pstle" );
        return;
    }
    
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_15_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x7ab9d954, Offset: 0xb62b
// Size: 0x2e
function private function_ae1a021c199e3b8d( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_15_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x63f23474, Offset: 0xb661
// Size: 0x78
function private function_540ca1ba25d91211( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level place_pestle();
        return;
    }
    
    place_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
    interaction::register_interact( place_loc.origin, 80, &function_190b4200fef18909, &pestle_hint_callback );
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_16_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x88733ed, Offset: 0xb6e1
// Size: 0x2e
function private function_ae19ff1c199e34f4( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_16_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x5cafee76, Offset: 0xb717
// Size: 0x36
function private function_540ca0ba25d90fde( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level function_19e341ff8108fe97();
    level utility::flag_wait( "mq_step_17_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x90426845, Offset: 0xb755
// Size: 0x7a
function private function_ae1a001c199e3727( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_17_complete" );
        return;
    }
    
    if ( level callback::exists( "on_zombie_ai_damaged", &function_73b2aa6f186eda ) )
    {
        level callback::remove( "on_zombie_ai_damaged", &function_73b2aa6f186eda );
    }
    
    if ( level callback::exists( "on_turned", &function_cf5db315f92f725c ) )
    {
        level callback::remove( "on_turned", &function_cf5db315f92f725c );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xfdbb9d66, Offset: 0xb7d7
// Size: 0x36
function private function_540c9bba25d904df( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level setup_poison_memory();
    level utility::flag_wait( "mq_step_18_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xf1f62e59, Offset: 0xb815
// Size: 0x2e
function private function_ae19f51c199e1ef6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_18_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x35119f9f, Offset: 0xb84b
// Size: 0x36
function private function_540c9aba25d902ac( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread spawn_blowfish();
    level utility::flag_wait( "mq_step_19_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x693375f1, Offset: 0xb889
// Size: 0x2e
function private function_ae19f61c199e2129( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_19_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x7fedb7e7, Offset: 0xb8bf
// Size: 0xc8
function private function_53ff91ba25cada5c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_4b3dca338605aff3 = [ 7, 8, 6 ];
        
        foreach ( evidence in var_4b3dca338605aff3 )
        {
            level function_fd1996af0db6a8ca( evidence );
        }
        
        level deliver_evidence( 1 );
        return;
    }
    
    level utility::flag_wait( "mq_step_20_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x5e35d35d, Offset: 0xb98f
// Size: 0x2e
function private function_ae15771c19991405( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_20_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x3a2bca45, Offset: 0xb9c5
// Size: 0x70
function private function_53ff92ba25cadc8f( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level function_792c7fa14bdc067( "poi" );
        level function_9947038abd0d1056( #"hash_46cb4c18e27f9240" );
        level utility::flag_set( "mq_step_21_complete" );
        return;
    }
    
    level thread function_792c7fa14bdc067( "poi", 1 );
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_21_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xc6f088f5, Offset: 0xba3d
// Size: 0x2e
function private function_ae15761c199911d2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_21_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x98132701, Offset: 0xba73
// Size: 0x43
function private function_53ff93ba25cadec2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_22_complete" );
        return;
    }
    
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_22_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xc627dfd6, Offset: 0xbabe
// Size: 0x11d
function private function_ae15751c19990f9f( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( isdefined( level.hornet_mq.var_4f641d5d0ca98ee7.interact ) )
        {
            level.hornet_mq.var_4f641d5d0ca98ee7.interact makeunusable();
        }
        
        if ( isdefined( level.hornet_mq.var_4f641d5d0ca98ee7.placed_shards ) )
        {
            foreach ( var_4b6319d4eaeb0942 in level.hornet_mq.var_4f641d5d0ca98ee7.placed_shards )
            {
                var_4b6319d4eaeb0942 freescriptable();
            }
        }
        
        level utility::flag_set( "mq_step_22_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xb9448f99, Offset: 0xbbe3
// Size: 0x36
function private function_53ff94ba25cae0f5( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread setup_sake_cup();
    level utility::flag_wait( "mq_step_23_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x2c0b39e4, Offset: 0xbc21
// Size: 0x2e
function private function_ae15741c19990d6c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_23_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x65e5d0f8, Offset: 0xbc57
// Size: 0xd7
function private function_53ff8dba25cad190( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_got_scup" );
        return;
    }
    
    if ( !isdefined( level.hornet_mq.s_cup.sbl ) )
    {
        cup_loc = utility::getstruct( "knts_puzzle_interact", "targetname" );
        level.hornet_mq.s_cup = {};
        level.hornet_mq.s_cup.sbl = spawnscriptable( %"hash_5749a765462049d6", cup_loc.origin, cup_loc.angles );
        level thread function_c06753a78b2f3984();
    }
    
    level utility::flag_wait( "mq_step_24_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x50b3b73e, Offset: 0xbd36
// Size: 0x2e
function private function_ae15731c19990b39( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_24_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x325efaab, Offset: 0xbd6c
// Size: 0x36
function private function_53ff8eba25cad3c3( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_bba786df8f95e013();
        return;
    }
    
    level utility::flag_wait( "mq_step_25_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xc876ec96, Offset: 0xbdaa
// Size: 0x2e
function private function_ae15721c19990906( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_25_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xe3d722e0, Offset: 0xbde0
// Size: 0x49
function private function_53ff8fba25cad5f6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread setup_chase_hellhound( level.hornet_mq.var_30278ba7270a73e2 );
    level utility::flag_wait( "mq_step_26_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xba48062f, Offset: 0xbe31
// Size: 0x48
function private function_ae15711c199906d3( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
        level utility::flag_set( "mq_step_26_complete" );
        return;
    }
    
    level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x355393c, Offset: 0xbe81
// Size: 0xc8
function private function_53ff90ba25cad829( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_4b3dca338605aff3 = [ 9, 10, 11 ];
        
        foreach ( evidence in var_4b3dca338605aff3 )
        {
            level function_fd1996af0db6a8ca( evidence );
        }
        
        level deliver_evidence( 1 );
        return;
    }
    
    level utility::flag_wait( "mq_step_27_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x228d5d87, Offset: 0xbf51
// Size: 0x2e
function private function_ae15701c199904a0( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_27_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xa732949f, Offset: 0xbf87
// Size: 0x5c
function private function_53ff99ba25caebf4( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level function_792c7fa14bdc067( "loc" );
        level function_b5fcf3a36fd29070( 1 );
        return;
    }
    
    level thread function_792c7fa14bdc067( "loc", 1 );
    level thread function_c09fe1a868d0af4f();
    level utility::flag_wait( "mq_step_28_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x8784c624, Offset: 0xbfeb
// Size: 0x3b
function private function_ae157f1c1999259d( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( b_save_restored )
        {
            level function_df8931e58abea5dd();
        }
        
        level utility::flag_set( "mq_step_28_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xe584991b, Offset: 0xc02e
// Size: 0x36
function private function_53ff9aba25caee27( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level function_ecc91637c2a6fbb1();
    level utility::flag_wait( "mq_step_29_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xdbfc4033, Offset: 0xc06c
// Size: 0x2e
function private function_ae157e1c1999236a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_29_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x80a3a386, Offset: 0xc0a2
// Size: 0x62
function private function_540397ba25cedd65( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread open_clock();
        return;
    }
    
    level callback::add( #"player_disconnect", &function_a0e27eba7315e6ad );
    level callback::add( #"player_death", &function_a0e27eba7315e6ad );
    level utility::flag_wait( "mq_step_30_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xef40173c, Offset: 0xc10c
// Size: 0xf8
function private function_ae10f11c1993f77c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_30_complete" );
        return;
    }
    
    for ( i = 0; i < level.hornet_mq.banner_puzzle.zone_roots.size ; i++ )
    {
        level.hornet_mq.banner_puzzle.zone_roots[ i ].symbol_sbl utility::function_7c10ea82c1e305b8( "visual", "off" );
    }
    
    if ( callback::exists( #"player_disconnect", &function_a0e27eba7315e6ad ) )
    {
        callback::remove( #"player_disconnect", &function_a0e27eba7315e6ad );
    }
    
    if ( callback::exists( #"player_death", &function_a0e27eba7315e6ad ) )
    {
        callback::remove( #"player_death", &function_a0e27eba7315e6ad );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xb93df099, Offset: 0xc20c
// Size: 0x2e
function private function_540396ba25cedb32( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "mq_step_31_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x1e656674, Offset: 0xc242
// Size: 0x2e
function private function_ae10f21c1993f9af( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_31_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xef223696, Offset: 0xc278
// Size: 0xc8
function private function_540395ba25ced8ff( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_4b3dca338605aff3 = [ 13, 12, 14 ];
        
        foreach ( evidence in var_4b3dca338605aff3 )
        {
            level function_fd1996af0db6a8ca( evidence );
        }
        
        level deliver_evidence( 1 );
        return;
    }
    
    level utility::flag_wait( "mq_all_ev_delivered" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x1dd1118f, Offset: 0xc348
// Size: 0x3b
function private function_ae10f31c1993fbe2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_32_complete" );
        level utility::flag_set( "mq_all_ev_delivered" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x2bc91f28, Offset: 0xc38b
// Size: 0x52
function private function_540394ba25ced6cc( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level function_792c7fa14bdc067( "mot" );
        return;
    }
    
    level thread function_792c7fa14bdc067( "mot", 1 );
    level thread setup_solve_logic();
    level utility::flag_wait( "mq_step_33_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xe30b887f, Offset: 0xc3e5
// Size: 0xd9
function private function_ae10f41c1993fe15( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_213723ab5a2d0467();
        level utility::flag_set( "mq_step_33_complete" );
        return;
    }
    
    foreach ( table in level.hornet_mq.evidence_tables.tables )
    {
        if ( isdefined( table.interact ) )
        {
            table.interact delete();
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x4e69960a, Offset: 0xc4c6
// Size: 0x44
function private function_540393ba25ced499( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.var_7e6171d8827ba694 = "zm_t10_teleport_vortex_red";
    level function_cad8bd257a48fc87();
    level utility::flag_wait( "mq_step_34_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xc09c8c70, Offset: 0xc512
// Size: 0x5c
function private function_ae10ed1c1993eeb0( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_34_complete" );
        return;
    }
    
    if ( level.hornet_mq.var_28c45c5d375ce1a1 )
    {
        level.hornet_mq.var_28c45c5d375ce1a1 delete();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x12e8070a, Offset: 0xc576
// Size: 0x36
function private function_540392ba25ced266( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_e8f4ecd2397bc342();
    level utility::flag_wait( "mq_step_35_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x6562fd6e, Offset: 0xc5b4
// Size: 0x5d
function private function_ae10ee1c1993f0e3( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_35_complete" );
        return;
    }
    
    if ( isdefined( level.hornet_mq.onryo ) )
    {
        level.hornet_mq.onryo kill();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x14f1aa1d, Offset: 0xc619
// Size: 0x46
function private function_540391ba25ced033( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_c2a23cf83940cadf();
        return;
    }
    
    level thread function_90c72c6cab29cb72();
    level thread function_af6027f41da042e3();
    level utility::flag_wait( "mq_step_36_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0x62dde8ae, Offset: 0xc667
// Size: 0x2e
function private function_ae10ef1c1993f316( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "mq_step_36_complete" );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3ca8adb1, Offset: 0xc69d
// Size: 0x58
function function_c2a23cf83940cadf()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    
    if ( !utility::get_bit_flag( var_181bfe57b6b9d727, 21 ) )
    {
        level function_af6027f41da042e3( 1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x5cbb279b, Offset: 0xc6fd
// Size: 0x32
function function_213723ab5a2d0467()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( !level utility::flag( "mq_step_35_complete" ) )
    {
        activateworldevent( "we_katana_react_mq" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x77c26201, Offset: 0xc737
// Size: 0x85
function function_bba786df8f95e013()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x45e11458, Offset: 0xc97d
// Size: 0x197
function setup_lanterns()
{
    var_36c874a259d7deed = [];
    a_lanterns = getentitylessscriptablearray( "guided_lantern_start", #targetname );
    var_cb5369743609abbe = a_lanterns[ 0 ];
    var_36c874a259d7deed[ var_36c874a259d7deed.size ] = var_cb5369743609abbe;
    
    while ( true )
    {
        a_lanterns = getentitylessscriptablearray( var_cb5369743609abbe.target, #targetname );
        
        if ( a_lanterns.size < 1 )
        {
            break;
        }
        
        var_cb5369743609abbe = a_lanterns[ 0 ];
        var_36c874a259d7deed[ var_36c874a259d7deed.size ] = var_cb5369743609abbe;
    }
    
    level.hornet_mq.a_lanterns = var_36c874a259d7deed;
    
    for ( i = 0; i < level.hornet_mq.a_lanterns.size ; i++ )
    {
        if ( i + 1 < 10 )
        {
            var_55c7580859294826 = "0" + string( i + 1 );
        }
        else
        {
            var_55c7580859294826 = string( i + 1 );
        }
        
        level.hornet_mq.a_lanterns[ i ].world_event = "we_lgt_MQ_lantern" + "_" + var_55c7580859294826;
        level.hornet_mq.a_lanterns[ i ].var_8be48bacaa8fcd16 = 0;
    }
    
    level.hornet_mq.a_lanterns = arrayreverse( level.hornet_mq.a_lanterns );
    level.hornet_mq.a_lanterns[ 0 ].b_isfirst = 1;
    level utility::flag_set( "mq_lantern_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xe6ecbe85, Offset: 0xcb1c
// Size: 0xa2
function function_661528427ae66e80()
{
    level utility::flag_wait( "mq_lantern_setup_complete" );
    
    if ( !level utility::flag( "mq_step_33_complete" ) )
    {
        foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
        {
            var_cb5369743609abbe set_lantern_lit();
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xcfdfd7e3, Offset: 0xcbc6
// Size: 0x1f4
function function_ef0871e1b6e54ad4()
{
    self notify( #"hash_8618aa2f8a13af17" );
    self endon( #"hash_8618aa2f8a13af17" );
    level endon( #"game_ended" );
    level endon( #"mq_step_1_complete" );
    time_max = isdefined( level.directed_mode ) ? 13500 : 10000;
    duration = gettime() + time_max;
    
    while ( true )
    {
        time_left = duration - gettime();
        
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            bar_progress = clamp( time_left / time_max, 0, 99 ) * 100;
            level zm_quest::function_9f49b2a045ece8ae( bar_progress, 1, #"hornet_mq_guidance", #"hash_81aec5964d66b6b" );
        }
        
        if ( time_left <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    level utility::flag_clear( "mq_step_1_fll" );
    level utility::flag_clear( "mq_lantern_music_playing" );
    level utility::flag_set( "mq_lanterns_timed_out" );
    musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_c55390f46a81c59e" );
    
    if ( level.directed_mode )
    {
        level thread function_490cc449b7de9830( [ #"hash_294f661b345eb4ce", #"hash_294f651b345eb31b" ], level.players, 0.5, 1 );
    }
    
    foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
    {
        var_cb5369743609abbe set_lantern_unlit( 0 );
    }
    
    level function_ecc91637c2a6fbb1();
    level waittill( #"on_round_start" );
    level utility::flag_clear( "mq_lanterns_timed_out" );
    level function_c04278a79d481af4();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x83c752c6, Offset: 0xcdc2
// Size: 0x8f
function function_c04278a79d481af4()
{
    foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
    {
        var_cb5369743609abbe set_lantern_unlit( 1 );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0xf389784d, Offset: 0xce59
// Size: 0x2ac
function function_9a415159d7ab174( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( level utility::flag( "mq_step_1_complete" ) )
    {
        return;
    }
    
    if ( instance.type != "zm_sat_hornet_mq_lantern" )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename != "sat_ww_hornet_zm" )
    {
        return;
    }
    
    if ( instance.var_8be48bacaa8fcd16 )
    {
        return;
    }
    
    instance set_lantern_lit();
    
    if ( isplayer( eattacker ) )
    {
        eattacker thread function_68a1e7f6b5555b2c();
        eattacker thread function_69f8ccd581947698();
    }
    
    if ( !level utility::flag( "mq_step_1_fll" ) )
    {
        var_efe087da86c69c0 = 0;
        
        foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
        {
            if ( var_cb5369743609abbe.var_8be48bacaa8fcd16 )
            {
                var_efe087da86c69c0 += 1;
            }
        }
        
        if ( var_efe087da86c69c0 == 1 )
        {
            level utility::flag_set( "mq_step_1_fll" );
        }
    }
    
    if ( !level utility::flag( "mq_lantern_music_playing" ) )
    {
        level utility::flag_set( "mq_lantern_music_playing" );
        musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_c55390f46a81c59e" );
    }
    
    level thread function_ef0871e1b6e54ad4();
    
    foreach ( var_cb5369743609abbe in level.hornet_mq.a_lanterns )
    {
        if ( !var_cb5369743609abbe.var_8be48bacaa8fcd16 )
        {
            level function_ecc91637c2a6fbb1();
            return;
        }
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_c55390f46a81c59e" );
    
    if ( isplayer( eattacker ) )
    {
        eattacker thread function_2a6deff157d1165a( #"hash_91642b58abf58a0c", #"bc_flavor_player_positive", 2 );
    }
    
    level utility::flag_set( "mq_step_1_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0x360efc9d, Offset: 0xd10d
// Size: 0x67
function private function_68a1e7f6b5555b2c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( level utility::flag( "hornet_mq_first_lantern_vo_sequence_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "hornet_mq_first_lantern_vo_sequence_played" );
    level thread function_e3a03fbfe3e8424b( [ #"hash_92345f22f5b14a64" ], [ self ] );
    wait 4;
    function_2a6deff157d1165a( #"hash_8f7142c324d6cfca", undefined );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf2e6c2c4, Offset: 0xd17c
// Size: 0x3d
function set_lantern_lit()
{
    utility::function_7c10ea82c1e305b8( "fx", "on" );
    utility::function_7c10ea82c1e305b8( "health", "idle" );
    self.var_8be48bacaa8fcd16 = 1;
    activateworldevent( self.world_event );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x4549b80d, Offset: 0xd1c1
// Size: 0x5f
function set_lantern_unlit( var_b0152d95472a1d9f )
{
    utility::function_7c10ea82c1e305b8( "fx", "off" );
    self.var_8be48bacaa8fcd16 = 0;
    
    if ( var_b0152d95472a1d9f )
    {
        utility::function_7c10ea82c1e305b8( "health", "lantern_damageable" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "health", "idle" );
    }
    
    deactivateworldevent( self.world_event );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0xc
// Checksum 0xe83eef75, Offset: 0xd228
// Size: 0x80
function private function_69f8ccd581947698()
{
    self notify( #"hash_a5ab8e9e7edbb138" );
    self endon( #"hash_a5ab8e9e7edbb138" );
    self endon( #"death_or_disconnect" );
    self playrumblelooponentity( "low_highfreq" );
    weapons::addextramovespeed( "mq_step_1_sb_st", 0.45 );
    weapons::updatemovespeedscale();
    wait 5;
    self stoprumble( "low_highfreq" );
    
    if ( isdefined( self.var_2d0e74f429afe5a0[ "mq_step_1_sb_st" ] ) )
    {
        weapons::removeextramovespeed( "mq_step_1_sb_st" );
        weapons::updatemovespeedscale();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xec1ba6ec, Offset: 0xd2b0
// Size: 0xbd
function function_57c3735267969937()
{
    level endon( #"game_ended" );
    level utility::flag_set( "mq_step_2_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd50821, Offset: 0xd62f
// Size: 0x42
function function_37c3c8a292fc2aae()
{
    level endon( #"game_ended" );
    level waittill( #"on_round_start" );
    level utility::flag_clear( "mq_step_1_complete" );
    level thread zm_quest::function_80abdea0cd4c89a7( #"hornet_mq_quest", #"light_lanterns" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0xab237cd, Offset: 0xd679
// Size: 0x798
function play_memory( var_41a291ed441ee2ba, var_7af983ebe6f1e54a = 0, trig )
{
    level endon( #"game_ended" );
    level utility::flag_set( "hornet_mq_mem_playing" );
    level utility::flag_set( "hornet_skip_round_vo" );
    level function_3582825f5c626855();
    
    switch ( var_41a291ed441ee2ba )
    {
        case #"hash_5c2f7b9a1cffb124":
            bit_index = 0;
            var_a46ed4bd986c88f3 = &function_2e24f585dcaf4911;
            var_b3cba93ca4e38d36 = #"hash_63f9ba8d35b6c16b";
            var_76c038314f68629f = #"hash_f707660cac63b0e0";
            break;
        case #"hash_1eb1e2908750f457":
            bit_index = 1;
            var_a46ed4bd986c88f3 = &function_cdd5c4bfe3462fea;
            var_b3cba93ca4e38d36 = #"hash_31a1fcd899d25a89";
            var_76c038314f68629f = #"hash_38bbd004cc17963c";
            break;
        case #"hash_f439cd99e67ac454":
            bit_index = 2;
            var_b3cba93ca4e38d36 = #"hash_e66a8cb8b2833e3";
            var_76c038314f68629f = #"hash_2421bbc81d68bbb";
            break;
        case #"hash_7429b89a2a0563a1":
            bit_index = 3;
            var_b3cba93ca4e38d36 = #"hash_af398c11410e034f";
            var_76c038314f68629f = #"hash_be981803064ba2d5";
            break;
        case #"hash_558a129a19b8192f":
            bit_index = 4;
            var_a46ed4bd986c88f3 = &function_97db136027f87806;
            var_b3cba93ca4e38d36 = #"hash_96b99ca2ab208baf";
            var_76c038314f68629f = #"hash_44f89ee130db03f4";
            break;
    }
    
    while ( level utility::flag( "hornet_mq_vo_playing" ) )
    {
        wait 0.1;
    }
    
    s_scenedef = utility::getstruct( var_41a291ed441ee2ba, "targetname" );
    zone_struct = zone_manager::get_zone_struct( s_scenedef.script_noteworthy );
    var_aa6a7d050293c5f2 = zone_struct zone_manager::get_adjacent_zones( zone_struct ) ?? [];
    var_aa6a7d050293c5f2[ var_aa6a7d050293c5f2.size ] = zone_struct;
    
    foreach ( zone_struct in var_aa6a7d050293c5f2 )
    {
        level thread zm_quest::cleanup_zombies_manually( 0, zone_struct.zone_name );
    }
    
    fade_time = 2;
    
    if ( var_7af983ebe6f1e54a )
    {
        nearby_players = getplayersinradius( s_scenedef.origin, 750 );
        
        foreach ( player in level.players )
        {
            if ( zone_manager::function_90e5c3e2272b0130( s_scenedef.origin ) == zone_manager::function_90e5c3e2272b0130( player.origin ) )
            {
                nearby_players = arraycombineunique( nearby_players, [ player ] );
            }
        }
        
        playsoundatpos( s_scenedef.origin, #"hash_e19c7622866b19a2" );
        
        foreach ( player in nearby_players )
        {
            player thread zm_utility::white_screen_flash( fade_time, 0.1 );
        }
    }
    
    clean_delay = 0.18;
    wait clean_delay;
    zone_struct = zone_manager::get_zone_struct( s_scenedef.script_noteworthy );
    var_aa6a7d050293c5f2 = zone_struct zone_manager::get_adjacent_zones( zone_struct ) ?? [];
    var_aa6a7d050293c5f2[ var_aa6a7d050293c5f2.size ] = zone_struct;
    
    foreach ( zone_struct in var_aa6a7d050293c5f2 )
    {
        zone_spawner::function_2ce7db1d59b307d8( zone_struct.zone_name );
    }
    
    level zm_sat_hornet_weather_ash::function_209997c5345ab152( s_scenedef.script_noteworthy );
    level zm_sat_hornet_weather_ash::function_a0ca938f7360747e( s_scenedef.script_noteworthy );
    
    if ( !isdefined( trig ) )
    {
        trig = getent( var_41a291ed441ee2ba + "_trig", #targetname );
    }
    
    if ( !isdefined( trig ) )
    {
        trig = spawn( "trigger_radius", s_scenedef.origin, 0, 500, 80 );
    }
    
    level thread function_e40ef213c02b6164( var_41a291ed441ee2ba, trig );
    var_5a349ab68e4b2fdf = 0.45;
    wait var_5a349ab68e4b2fdf;
    
    if ( isdefined( var_b3cba93ca4e38d36 ) )
    {
        nearby_players = getplayersinradius( s_scenedef.origin, 3000 );
        level musicbank_utility::function_5aca66c390aa347d( nearby_players, var_b3cba93ca4e38d36 );
    }
    
    nearby_players = getplayersinradius( s_scenedef.origin, s_scenedef.radius );
    a_safe_locations = utility::getstructarray( s_scenedef.target, "targetname" );
    
    for ( i = 0; i < nearby_players.size ; i++ )
    {
        nearby_players[ i ] setorigin( a_safe_locations[ i ].origin );
        nearby_players[ i ] setplayerangles( a_safe_locations[ i ].angles );
    }
    
    wait fade_time - var_5a349ab68e4b2fdf - clean_delay;
    
    while ( level utility::flag( "hornet_mq_vo_playing" ) )
    {
        wait 0.1;
    }
    
    if ( isdefined( var_a46ed4bd986c88f3 ) )
    {
        level thread [[ var_a46ed4bd986c88f3 ]]( s_scenedef );
    }
    
    s_scenedef scene::play( s_scenedef.existingents );
    nearby_players = function_5713d46873b29625( nearby_players );
    
    if ( isdefined( var_b3cba93ca4e38d36 ) )
    {
        level musicbank_utility::function_4f253fd35ec68cbc( nearby_players, var_b3cba93ca4e38d36 );
    }
    
    level utility::flag_clear( "hornet_mq_mem_playing" );
    level utility::flag_set( var_41a291ed441ee2ba + "_ended" );
    level.hornet_mq.vignette_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_36715aa8ae539973" ) ?? 0;
    level.hornet_mq.vignette_data = level utility::set_bit_flag( level.hornet_mq.vignette_data, bit_index );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_36715aa8ae539973", level.hornet_mq.vignette_data );
    
    foreach ( s_object in s_scenedef.scenedata.sceneobjectdata )
    {
        s_object.entity delete();
    }
    
    level function_45ad7aa946240db5( var_76c038314f68629f, s_scenedef );
    wait 1.5;
    level utility::flag_clear( "hornet_skip_round_vo" );
    
    foreach ( zone_struct in var_aa6a7d050293c5f2 )
    {
        zone_spawner::function_8a020f24a3b73c79( zone_struct.zone_name );
    }
    
    level zm_sat_hornet_weather_ash::function_35ed61636451860f( s_scenedef.script_noteworthy );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x59ee5e5b, Offset: 0xde19
// Size: 0x6d
function function_45ad7aa946240db5( var_76c038314f68629f, s_scenedef )
{
    var_3dc01cb9198cf143 = utility::spawn_model( "tag_origin", s_scenedef.origin + ( 0, 0, 40 ), s_scenedef.angles );
    var_3dc01cb9198cf143 dialogue::say( var_76c038314f68629f, 151, undefined, undefined, 2 );
    waitframe();
    
    if ( var_3dc01cb9198cf143 )
    {
        var_3dc01cb9198cf143 delete();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x5b945e3, Offset: 0xde8e
// Size: 0x26b
function function_e40ef213c02b6164( var_dc8ff5ce9ed5e4ce, trig )
{
    level endon( #"game_ended" );
    
    if ( !trig )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        var_6f88a6bfefadea5e = { #var_dc8ff5ce9ed5e4ce:var_dc8ff5ce9ed5e4ce, #player:player };
        level callback::add( #"on_ai_damaged", &function_b3cbb1b091ce4c06, var_6f88a6bfefadea5e );
    }
    
    while ( !level utility::flag( var_dc8ff5ce9ed5e4ce + "_ended" ) )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( trig ) && !player utility::ent_flag( var_dc8ff5ce9ed5e4ce + "_early_reset_notarget" ) )
            {
                if ( !player.var_7fecb7d41c82df14 )
                {
                    player function_ed6d4d857114e051( 1, var_dc8ff5ce9ed5e4ce );
                }
                
                continue;
            }
            
            if ( player.var_7fecb7d41c82df14 )
            {
                player function_ed6d4d857114e051( 0, var_dc8ff5ce9ed5e4ce );
            }
        }
        
        wait 1;
    }
    
    wait 1.5;
    
    foreach ( player in level.players )
    {
        player function_ed6d4d857114e051( 0, var_dc8ff5ce9ed5e4ce );
        var_6f88a6bfefadea5e = { #var_dc8ff5ce9ed5e4ce:var_dc8ff5ce9ed5e4ce, #player:player };
        
        if ( level callback::exists( #"on_ai_damaged", &function_b3cbb1b091ce4c06, var_6f88a6bfefadea5e ) )
        {
            level callback::remove( #"on_ai_damaged", &function_b3cbb1b091ce4c06, var_6f88a6bfefadea5e );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x99d876c5, Offset: 0xe101
// Size: 0x92
function function_b3cbb1b091ce4c06( params, var_6f88a6bfefadea5e )
{
    if ( !isdefined( var_6f88a6bfefadea5e.player ) )
    {
        level callback::remove( #"on_ai_damaged", &function_b3cbb1b091ce4c06, var_6f88a6bfefadea5e );
    }
    
    if ( params.eattacker == var_6f88a6bfefadea5e.player )
    {
        var_6f88a6bfefadea5e.player utility::ent_flag_set( var_6f88a6bfefadea5e.var_dc8ff5ce9ed5e4ce + "_early_reset_notarget" );
        level callback::remove( #"on_ai_damaged", &function_b3cbb1b091ce4c06, var_6f88a6bfefadea5e );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x6128e046, Offset: 0xe19b
// Size: 0xbc
function function_ed6d4d857114e051( state, var_41a291ed441ee2ba )
{
    self.var_7fecb7d41c82df14 = state;
    
    if ( state )
    {
        val::set( var_41a291ed441ee2ba, "ignoreme", 1 );
        val::set( var_41a291ed441ee2ba, "ignore_afk", 1 );
        
        if ( isdefined( self.var_4fd5ac47a9bd8c18 ) )
        {
            self.var_4fd5ac47a9bd8c18.can_target = 0;
        }
        
        return;
    }
    
    val::reset_all( var_41a291ed441ee2ba );
    
    if ( isdefined( self.var_4fd5ac47a9bd8c18 ) && !utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_pretty_mask" ) )
    {
        self.var_4fd5ac47a9bd8c18.can_target = 1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x2cd6f265, Offset: 0xe25f
// Size: 0x7c
function memory_hint_callback( usable, player )
{
    if ( level.directed_mode )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_dc6b80cffd01d2e", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x75c724e2, Offset: 0xe2e3
// Size: 0x187
function function_cdd5c4bfe3462fea( s_scenedef )
{
    if ( !isdefined( level.hornet_mq.f_mask ) )
    {
        place_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        level.hornet_mq.f_mask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", place_loc.origin, ( 0, 10, 90 ) );
        level.hornet_mq.f_mask_interact = interaction::register_interact( place_loc.origin, 80, &function_680eaba440fa62ce, &function_b298b61b50a32644 );
    }
    
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "fx", "none" );
    level waittill( #"hash_d1b0271028f29e20" );
    waitframe();
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "fx", "mask_grabbed" );
    level.hornet_mq.f_mask.origin -= ( 0, 0, 200 );
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "model", "mask_simple" );
    level waittill( #"hash_607ce1f637a923e3" );
    level utility::flag_set( "mq_step_6_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x11f44113, Offset: 0xe472
// Size: 0x1ac
function function_97db136027f87806( s_scenedef )
{
    level waittill( #"hash_34a656e7bcf2342c" );
    level.hornet_mq.memory_cup.origin -= ( 0, 0, 200 );
    level waittill( #"hash_c460ed02debb2dc9" );
    
    foreach ( object in s_scenedef.scenedata.sceneobjectdata )
    {
        if ( isdefined( object.entity ) && isdefined( object.entity.model ) && object.entity.model == "sat_zm_sake_cup_ghost" )
        {
            object.entity hide();
        }
    }
    
    if ( isdefined( level.hornet_mq.memory_cup.origin ) )
    {
        level.hornet_mq.memory_cup.origin += ( 0, 0, 200 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xb3af57e1, Offset: 0xe626
// Size: 0x40
function function_2e24f585dcaf4911( s_scenedef )
{
    wait 38.5;
    
    if ( level.hornet_mq.shogun_shard )
    {
        level.hornet_mq.shogun_shard function_e203bba36cfb19d0();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x87e75a97, Offset: 0xe66e
// Size: 0x1b4
function function_bafeaf3a28b49b48()
{
    if ( !isdefined( level.hornet_mq.f_mask ) )
    {
        place_loc = utility::getstruct( "vig_mask_loc", "targetname" );
        level.hornet_mq.f_mask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", place_loc.origin, place_loc.angles );
    }
    else
    {
        place_loc = utility::getstruct( "vig_mask_loc", "targetname" );
        level.hornet_mq.f_mask.angles = place_loc.angles;
        level.hornet_mq.f_mask.origin = place_loc.origin;
    }
    
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "fx", "memory" );
    
    if ( isdefined( level.hornet_mq.f_mask_interact ) )
    {
        level.hornet_mq.f_mask_interact delete();
    }
    
    level function_ecc91637c2a6fbb1();
    level.hornet_mq.f_mask.attract_audio = spawnscriptable( %"zm_sat_hornet_mq_memory", level.hornet_mq.f_mask.origin, ( 0, 0, 0 ) );
    interaction::register_interact( level.hornet_mq.f_mask.origin, 80, &function_f56f4e7ac241da43, &memory_hint_callback );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x667c95df, Offset: 0xe82a
// Size: 0xec
function function_f56f4e7ac241da43( player )
{
    self makeunusable();
    trig = getent( "n_mask_trig", #targetname );
    
    if ( level.hornet_mq.f_mask.attract_audio )
    {
        level.hornet_mq.f_mask.attract_audio freescriptable();
    }
    
    level play_memory( "memory_mask", 1, trig );
    st_intel_name = "zmintel_sat_hornet_audiolog_12";
    spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
    level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
    level thread function_8408a524375103f1( trig );
    level utility::flag_set( "mq_step_6_complete" );
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xb7e7bebf, Offset: 0xe91e
// Size: 0x10c
function function_8408a524375103f1( trig )
{
    var_836bf0dbdd5b1693 = [];
    
    foreach ( player in level.players )
    {
        if ( player istouching( trig ) )
        {
            var_836bf0dbdd5b1693[ var_836bf0dbdd5b1693.size ] = player;
        }
    }
    
    if ( var_836bf0dbdd5b1693.size <= 0 )
    {
        return;
    }
    
    selected_player = utility::array_random( var_836bf0dbdd5b1693 );
    selected_player function_2a6deff157d1165a( #"hash_f6cd26d237f8c16e", undefined, 0.5 );
    waitframe();
    
    if ( var_836bf0dbdd5b1693.size == 1 )
    {
        return;
    }
    
    other_player = utility::function_879489791c3d805( var_836bf0dbdd5b1693, [ selected_player ] );
    
    if ( other_player )
    {
        other_player function_2a6deff157d1165a( #"hash_584f443c1d1caf7d", undefined, 0.5 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x5e228d40, Offset: 0xea32
// Size: 0x13c
function function_15168f0e9fd3075d()
{
    if ( !isdefined( level.hornet_mq.coin_purse ) )
    {
        loc = utility::getstruct( "cnp_coalesce_loc", "targetname" );
        level.hornet_mq.coin_purse = spawnscriptable( %"zm_sat_hornet_mq_coin", loc.origin, loc.angles );
        level.hornet_mq.coin_purse utility::function_7c10ea82c1e305b8( "visual", "purse" );
    }
    
    level.hornet_mq.coin_purse thread function_113be2163cc65126( 2, 3 );
    level.hornet_mq.coin_purse.attract_audio = spawnscriptable( %"zm_sat_hornet_mq_memory", level.hornet_mq.coin_purse.origin, ( 0, 0, 0 ) );
    interaction::register_interact( level.hornet_mq.coin_purse.origin, 80, &function_4ab3a68f48286b98, &memory_hint_callback );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc664acf5, Offset: 0xeb76
// Size: 0x20d
function function_4ab3a68f48286b98( player )
{
    self makeunusable();
    target_loc = utility::getstruct( "cnp_moveto_loc", "targetname" );
    level.hornet_mq.coin_purse.linkedparent moveto( target_loc.origin, 0.85, 0.4 );
    level.hornet_mq.coin_purse.linkedparent rotateto( target_loc.angles, 0.85, 0.4 );
    level.hornet_mq.coin_purse.linkedparent waittill( #"movedone" );
    
    if ( level.hornet_mq.coin_purse.attract_audio )
    {
        level.hornet_mq.coin_purse.attract_audio freescriptable();
    }
    
    if ( level.hornet_mq.coin_purse.linkedparent )
    {
        level.hornet_mq.coin_purse.linkedparent delete();
    }
    
    if ( level.hornet_mq.coin_purse )
    {
        level.hornet_mq.coin_purse freescriptable();
    }
    
    trig = getent( "mq_mem_acc_trig", #targetname );
    level play_memory( "memory_acc", 1, trig );
    st_intel_name = "zmintel_sat_hornet_audiolog_3";
    spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
    level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
    level thread function_d7715e6a59d31f6a( trig );
    level utility::flag_set( "mq_step_11_complete" );
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x124c4a99, Offset: 0xed8b
// Size: 0xd3
function function_d7715e6a59d31f6a( trig )
{
    var_836bf0dbdd5b1693 = [];
    
    foreach ( player in level.players )
    {
        if ( player istouching( trig ) )
        {
            var_836bf0dbdd5b1693[ var_836bf0dbdd5b1693.size ] = player;
        }
    }
    
    if ( var_836bf0dbdd5b1693.size <= 0 )
    {
        return;
    }
    
    selected_player = utility::array_random( var_836bf0dbdd5b1693 );
    selected_player thread function_2a6deff157d1165a( #"hash_3a9deb0519519abc", #"hash_5212ed7ec42f115a", 0.5 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb4158bcb, Offset: 0xee66
// Size: 0x17f
function setup_poison_memory()
{
    pestle_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
    spawn_loc = pestle_loc.origin;
    spawn_angles = pestle_loc.angles;
    
    if ( level.hornet_mq.pestle )
    {
        spawn_loc = level.hornet_mq.pestle.origin;
        spawn_angles = level.hornet_mq.pestle.angles;
        level.hornet_mq.pestle delete();
    }
    
    level.hornet_mq.pestle = utility::spawn_model( "ghost::sat_zm_pestle", spawn_loc, spawn_angles );
    memory_loc = {};
    memory_loc.attract_audio = spawnscriptable( %"zm_sat_hornet_mq_memory", level.hornet_mq.pestle.origin, ( 0, 0, 0 ) );
    memory_loc.interact = interaction::register_interact( level.hornet_mq.pestle.origin, 80, &function_22343ff2203e59b, &memory_hint_callback );
    memory_loc.interact.root = memory_loc;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2ef7de1e, Offset: 0xefed
// Size: 0x106
function function_22343ff2203e59b( player )
{
    self makeunusable();
    
    if ( self.root.attract_audio )
    {
        self.root.attract_audio freescriptable();
    }
    
    if ( level.hornet_mq.pestle )
    {
        level.hornet_mq.pestle delete();
    }
    
    trig = getent( "tcharge_trig", #targetname );
    level play_memory( "memory_poi", 1, trig );
    st_intel_name = "zmintel_sat_hornet_audiolog_2";
    spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
    level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
    level thread function_2982b98429643919( trig );
    level utility::flag_set( "mq_step_18_complete" );
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x586a59db, Offset: 0xf0fb
// Size: 0xd3
function function_2982b98429643919( trig )
{
    var_836bf0dbdd5b1693 = [];
    
    foreach ( player in level.players )
    {
        if ( player istouching( trig ) )
        {
            var_836bf0dbdd5b1693[ var_836bf0dbdd5b1693.size ] = player;
        }
    }
    
    if ( var_836bf0dbdd5b1693.size <= 0 )
    {
        return;
    }
    
    selected_player = utility::array_random( var_836bf0dbdd5b1693 );
    selected_player thread function_2a6deff157d1165a( #"hash_7126f3371eb1ca5d", #"hash_5212ed7ec42f115a", 0.5 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x9ec15093, Offset: 0xf1d6
// Size: 0x6c
function function_d8e9a758971850eb()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    vignette_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_36715aa8ae539973" ) ?? 0;
    
    if ( !utility::get_bit_flag( vignette_data, 0 ) )
    {
        level thread function_619e26314b229b79();
        return;
    }
    
    level utility::flag_set( "mq_step_3_mem_complete" );
    level function_e416c151cb24af31();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb56dbdf1, Offset: 0xf24a
// Size: 0x233
function function_619e26314b229b79()
{
    level endon( #"mq_step_3_complete" );
    level function_ecc91637c2a6fbb1();
    body_loc = utility::getstruct( "sh_bd_loc", "targetname" );
    
    if ( !isdefined( body_loc.angles ) )
    {
        body_loc.angles = ( 0, 0, 0 );
    }
    
    level.hornet_mq.var_942e078a8a9fb0d9 = spawnscriptable( %"zm_sat_hornet_mq_memory", body_loc.origin, body_loc.angles );
    level.hornet_mq.var_942e078a8a9fb0d9 utility::function_7c10ea82c1e305b8( "visual", "shogun" );
    sword_loc = utility::getstruct( "sh_bd_loc_elnath_loc", "targetname" );
    level.hornet_mq.var_af4853258a3a9142 = spawnscriptable( %"hash_531f9e32c953ec23", sword_loc.origin, sword_loc.angles );
    interact_loc = utility::getstruct( body_loc.target, "targetname" );
    body_interact = interaction::register_interact( interact_loc.origin, 80, &function_8355d59cdb75671a, &memory_hint_callback );
    level waittill( #"hash_172050b35c9a7a86" );
    
    if ( body_interact )
    {
        body_interact delete();
    }
    
    if ( level.hornet_mq.shogun_shard )
    {
        level.hornet_mq.shogun_shard function_7653c765b6c7b815();
    }
    
    trig = getent( "memory_sus_trig", #targetname );
    level play_memory( "memory_sus", 1, trig );
    st_intel_name = "zmintel_sat_hornet_audiolog_1";
    spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
    level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
    level thread function_1a064f5d568f2f9d( trig );
    level utility::flag_set( "mq_step_3_mem_complete" );
    level function_ecc91637c2a6fbb1();
    level function_e416c151cb24af31();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb72e57f2, Offset: 0xf485
// Size: 0xe2
function function_e416c151cb24af31()
{
    spawn_loc = utility::getstruct( "f_mask_spawn_loc", "targetname" );
    level.hornet_mq.nk_fmask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", spawn_loc.origin, spawn_loc.angles );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level.hornet_mq.nk_fmask utility::function_7c10ea82c1e305b8( "model", "mask_outline" );
    }
    
    trig = getent( "nk_fmask_interact_trig", #targetname );
    trig thread function_e80b58dda62ed272();
    
    if ( level.directed_mode )
    {
        if ( !callback::exists( #"hash_285de7f1c47ba90d", &function_e155348135692fa6 ) )
        {
            level callback::add( #"hash_285de7f1c47ba90d", &function_e155348135692fa6 );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x799caab0, Offset: 0xf56f
// Size: 0x45
function function_e155348135692fa6( params )
{
    if ( isdefined( params ) && isdefined( params.var_bce93d4f2ae719c0 ) && isplayer( self ) )
    {
        utility::ent_flag_set( "hornet_mq_guided_taking_high_path" );
        thread function_5d0e8cd48aca06ef();
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xa7c7e4ed, Offset: 0xf5bc
// Size: 0x2f
function function_5d0e8cd48aca06ef()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"fasttravel_over" );
    utility::ent_flag_clear( "hornet_mq_guided_taking_high_path" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0xe4ab3c25, Offset: 0xf5f3
// Size: 0xf1
function private function_1a064f5d568f2f9d( shogun_trig )
{
    level endon( #"game_ended" );
    var_6edc253bde2124dc = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && ( !isdefined( shogun_trig ) || player istouching( shogun_trig ) ) )
        {
            var_6edc253bde2124dc[ var_6edc253bde2124dc.size ] = player;
        }
    }
    
    if ( var_6edc253bde2124dc.size <= 0 )
    {
        return;
    }
    
    selected_player = utility::array_random( var_6edc253bde2124dc );
    selected_player thread function_2a6deff157d1165a( #"hash_cdfc7eee36456ed", #"hash_5212ed7ec42f115a", 0.5 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x8959e25d, Offset: 0xf6ec
// Size: 0x26
function function_8355d59cdb75671a( player )
{
    self makeunusable();
    level notify( #"hash_172050b35c9a7a86" );
    level thread function_d32a2f3d0ec90366();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xbd36e0cd, Offset: 0xf71a
// Size: 0x61
function function_d32a2f3d0ec90366()
{
    wait 1;
    
    if ( level.hornet_mq.var_942e078a8a9fb0d9 )
    {
        level.hornet_mq.var_942e078a8a9fb0d9 freescriptable();
    }
    
    if ( level.hornet_mq.var_af4853258a3a9142 )
    {
        level.hornet_mq.var_af4853258a3a9142 freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x97cf0754, Offset: 0xf783
// Size: 0xbf
function function_e80b58dda62ed272()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_3_complete" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player.var_7bfccbdf294cddb3 )
            {
                if ( ispointinvolume( player.origin, self ) )
                {
                    player thread function_9f4334d155c2f495( self );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xa1f1fc17, Offset: 0xf84a
// Size: 0x1fd
function function_9f4334d155c2f495( trig )
{
    self notify( #"hash_d7bb2ffcb8c4e36d" );
    self endon( #"hash_d7bb2ffcb8c4e36d" );
    self endon( #"death_or_disconnect" );
    level endon( #"mq_step_3_complete" );
    level endon( #"game_ended" );
    self.var_7bfccbdf294cddb3 = 1;
    
    if ( self usinggamepad() )
    {
        b_usinggamepad = 1;
        self notifyonplayercommand( "interacted", "+usereload" );
    }
    else
    {
        b_usinggamepad = 0;
        self notifyonplayercommand( "interacted", "+activate" );
    }
    
    thread function_be191a4d3d7db4c3( trig );
    msg = utility::waittill_any_return( "interacted", "left_trigger" );
    self.var_7bfccbdf294cddb3 = 0;
    
    if ( b_usinggamepad )
    {
        self notifyonplayercommandremove( "interacted", "+usereload" );
    }
    else
    {
        self notifyonplayercommandremove( "interacted", "+activate" );
    }
    
    if ( msg == "interacted" )
    {
        self setclientomnvar( "ui_show_playersplash_no_hud", 1 );
        utility::delaycallendon( 5, "death_or_disconnect", &setclientomnvar, "ui_show_playersplash_no_hud", 0 );
        
        foreach ( player in level.players )
        {
            player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_4" );
        }
        
        thread function_2a6deff157d1165a( #"hash_57a2367e31f56121", #"bc_flavor_player_positive" );
        level.hornet_mq.nk_fmask utility::function_7c10ea82c1e305b8( "fx", "pickup" );
        level function_9947038abd0d1056( #"f_mask", self );
        level utility::flag_set( "mq_step_3_complete" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xf73c094a, Offset: 0xfa4f
// Size: 0x6a
function function_be191a4d3d7db4c3( trig )
{
    self notify( #"hash_70a83974234caee8" );
    self endon( #"hash_70a83974234caee8" );
    self endon( #"death_or_disconnect" );
    level endon( #"mq_step_3_complete" );
    level endon( #"game_ended" );
    
    while ( ispointinvolume( self.origin, trig ) )
    {
        waitframe();
    }
    
    self notify( #"left_trigger" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x31a5ed1a, Offset: 0xfac1
// Size: 0xf1
function function_680eaba440fa62ce( player )
{
    if ( !isdefined( level.hornet_mq.f_mask ) )
    {
        level.hornet_mq.f_mask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", self.origin, ( 0, 10, 90 ) );
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "audio", "place" );
        player thread function_2a6deff157d1165a( #"hash_59cc264ba79d2b4d", #"hash_5212ed7ec42f115a", 0.5 );
        level utility::flag_set( "mq_step_4_complete" );
        return;
    }
    
    if ( level utility::flag( "n_mask_puzzle_active" ) )
    {
        level notify( #"hash_7dff93af04a5423f" );
        return;
    }
    
    if ( level utility::flag( "n_mask_puzzle_reenabled" ) )
    {
        level utility::flag_clear( "n_mask_puzzle_reenabled" );
        level thread function_9b32453437b6c5cf();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x3b780d4c, Offset: 0xfbba
// Size: 0x111
function function_b298b61b50a32644( usable, player )
{
    if ( level.directed_mode )
    {
        if ( !isdefined( level.hornet_mq.f_mask ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_42a574564a065ecb", #type:"HINT_BUTTON" };
        }
        else if ( level utility::flag( "n_mask_puzzle_waiting_to_progress" ) || level utility::flag( "n_mask_puzzle_reenabled" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_3548edc9fe9d20da", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x37d78663, Offset: 0xfcd3
// Size: 0x12a
function function_fa0b214b7ee1dda7()
{
    level utility::flag_wait( "scriptables_ready" );
    wall_masks = utility::getstructarray( "n_mask", "targetname" );
    wall_masks = arraysort( wall_masks, undefined, &compare_script_int );
    
    foreach ( struct in wall_masks )
    {
        struct.sbl = spawnscriptable( %"zm_sat_hornet_mq_n_mask", struct.origin, struct.angles );
        struct.sbl utility::function_7c10ea82c1e305b8( "model", string( struct.script_int ) );
    }
    
    level.hornet_mq.noh_puzzle = {};
    level.hornet_mq.noh_puzzle.wall_masks = wall_masks;
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x4e0bbab8, Offset: 0xfe05
// Size: 0x1be
function function_bffc448792f681e2( mask_type, spawner, var_74729ba05d4968f5 = 0 )
{
    switch ( mask_type )
    {
        case 0:
            subclass = "sat_spawner_zombie_base_zm_hornet_mq_simon_h";
            break;
        case 1:
            subclass = "sat_spawner_zombie_base_zm_hornet_mq_simon_t";
            break;
        case 3:
            subclass = "sat_spawner_zombie_base_zm_hornet_mq_simon_s";
            break;
        case 4:
            subclass = "sat_spawner_zombie_base_zm_hornet_mq_simon_k";
            break;
        case 2:
        default:
            subclass = "sat_spawner_zombie_base_zm_hornet_mq_simon_o";
            break;
    }
    
    zombie = function_89266a24d0006d65( subclass, spawner );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( !isdefined( level.hornet_mq.var_443f9790b3051c1c ) )
    {
        level.hornet_mq.var_443f9790b3051c1c = [];
    }
    
    level.hornet_mq.var_443f9790b3051c1c[ level.hornet_mq.var_443f9790b3051c1c.size ] = zombie;
    zombie.mask_type = mask_type;
    zombie.var_825b17c932865df = 1;
    zombie.var_3807d4363cfee498 = 1;
    zombie.var_be5ccf6d16f6b59e = 1;
    zombie val::set( "hornet_mq_n_mask_puzzle", "ammomod_immune", 1 );
    zombie val::set( "hornet_mq_n_mask_puzzle", "ignore_cleanup", 1 );
    zombie.var_a13bed1ac47e1b2c = 1;
    
    if ( !var_74729ba05d4968f5 )
    {
        zombie callback::add( "on_zombie_ai_killed", &function_93a90a9c8bd98929 );
        wait 0.5;
        zombie zone_spawner::function_ce10e453e7f7bb8e( spawner );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6988d528, Offset: 0xffcb
// Size: 0x98
function function_93a90a9c8bd98929( params )
{
    if ( !level utility::flag( "n_mask_puzzle_round_active" ) )
    {
        return;
    }
    
    if ( !self.var_45806768a9c23a8b )
    {
        var_a65a556e144e8c0b = utility::getstructarray( "n_mask_p_spawn", "targetname" );
        spawner = utility::array_random( var_a65a556e144e8c0b );
        level thread function_bffc448792f681e2( self.mask_type, spawner );
        return;
    }
    
    z_mod = 32;
    level thread function_fdb1e772ec02e727( self.origin + ( 0, 0, z_mod ), self.mask_type );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xf2d2db, Offset: 0x1006b
// Size: 0x6b
function function_fdb1e772ec02e727( starting_position, mask_type )
{
    level endon( #"game_ended" );
    goal_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
    level function_8f370c37e2e751f2( starting_position, goal_pos.origin, 0, 0.75, "noh" );
    level notify( #"hash_9b90f8852ca8709c", mask_type );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xcb950464, Offset: 0x100de
// Size: 0x664
function function_9b32453437b6c5cf()
{
    level endon( #"game_ended" );
    level endon( #"hash_27fbe7096c1a60cc" );
    level utility::flag_set( "n_mask_puzzle_active" );
    level utility::flag_set( "hornet_mq_blocking_horse_ee" );
    
    if ( isdefined( level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253" ) ) )
    {
        level utility::flag_set( "n_mask_puzzle_waiting_to_progress" );
        level waittill( #"hash_7dff93af04a5423f" );
    }
    
    level.hornet_mq.var_2c5788c0eb038232 = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253" ) ?? 0;
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253", level.hornet_mq.var_2c5788c0eb038232 );
    trig = getent( "n_mask_trig", #targetname );
    level zm_music::start_zone_music_watcher( "mq_noh_mask_music", [ "zone_main_keep_west_path_a", "zone_main_keep_west_path_b" ], #"mq_mask" );
    a_barrier_loc = utility::getstructarray( "nh_barrier_loc", "targetname" );
    
    foreach ( var_dff548c3090b7c3b in a_barrier_loc )
    {
        var_dff548c3090b7c3b.sbl = spawnscriptable( %"hash_c5980df7b8a3480", var_dff548c3090b7c3b.origin, var_dff548c3090b7c3b.angles );
    }
    
    level function_6e29e1bbb80eff60( 1, [ "zone_main_keep_west_path_a" ] );
    wait 1;
    var_2339625ecafd2945 = level.hornet_mq.var_2c5788c0eb038232;
    
    for ( i = var_2339625ecafd2945; i < 3 ; i++ )
    {
        level utility::flag_clear( "n_mask_puzzle_waiting_to_progress" );
        level.hornet_mq.noh_puzzle.var_d4cee9ef8c97d5f6 = undefined;
        level function_ecc91637c2a6fbb1();
        level thread function_abf8d431a8614c42( trig );
        num_masks = 3 + 1 * i;
        a_sequence = function_93cec4cbfd91ec9e( num_masks );
        level function_d37250ba7b3e39eb( a_sequence );
        level utility::flag_set( "n_mask_puzzle_round_active" );
        level thread function_8076bfeac8ae20fe( a_sequence );
        level thread function_bded3d1a185ff1e4();
        b_round_active = 1;
        b_round_succeeded = 0;
        var_f36e0fd5d908f821 = 0;
        level.hornet_mq.noh_puzzle.var_d4cee9ef8c97d5f6 = a_sequence[ var_f36e0fd5d908f821 ];
        level function_ecc91637c2a6fbb1();
        
        while ( b_round_active )
        {
            level waittill( #"hash_9b90f8852ca8709c", mask_type );
            
            if ( mask_type != a_sequence[ var_f36e0fd5d908f821 ] )
            {
                b_round_active = 0;
            }
            else if ( var_f36e0fd5d908f821 == a_sequence.size - 1 )
            {
                b_round_succeeded = 1;
                b_round_active = 0;
            }
            
            var_f36e0fd5d908f821++;
            level.hornet_mq.noh_puzzle.var_d4cee9ef8c97d5f6 = a_sequence[ var_f36e0fd5d908f821 ];
            
            if ( b_round_active )
            {
                level function_ecc91637c2a6fbb1();
            }
        }
        
        level utility::flag_clear( "n_mask_puzzle_round_active" );
        level notify( #"n_mask_puzzle_round_ended" );
        
        if ( !b_round_succeeded )
        {
            level.hornet_mq.var_2c5788c0eb038232 = 0;
            zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253", level.hornet_mq.var_2c5788c0eb038232 );
            sound_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
            playsoundatpos( sound_pos.origin, "evt_mq_mask_event_fail" );
            level zm_music::function_e9fd14ede793ef0d( "mq_noh_mask_music" );
            level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
            
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            logstring( "************mq_nmask_fail reason: wrong mask shot" );
            level thread function_490cc449b7de9830( [ #"hash_fa9aef91f34403ed", #"hash_fa9aec91f343fed4" ], level.players, 0.5, 1 );
            break;
        }
        
        foreach ( mask_struct in level.hornet_mq.noh_puzzle.wall_masks )
        {
            mask_state = mask_struct.sbl getscriptablepartstate( "model" );
            mask_struct.sbl utility::function_7c10ea82c1e305b8( "fx", mask_state );
        }
        
        level thread function_db840c891e326576();
        level.hornet_mq.var_2c5788c0eb038232 += 1;
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253", level.hornet_mq.var_2c5788c0eb038232 );
        
        if ( i != 2 )
        {
            sound_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
            playsoundatpos( sound_pos.origin, "evt_mq_mask_round_success" );
            level utility::flag_set( "n_mask_puzzle_waiting_to_progress" );
            level function_ecc91637c2a6fbb1();
            level waittill( #"hash_7dff93af04a5423f" );
            level utility::flag_clear( "n_mask_puzzle_waiting_to_progress" );
        }
    }
    
    level utility::flag_clear( "n_mask_puzzle_active" );
    level function_9bd5cafcd7b0a736();
    
    if ( b_round_succeeded )
    {
        sound_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
        playsoundatpos( sound_pos.origin, "evt_mq_mask_event_success" );
        level zm_music::function_e9fd14ede793ef0d( "mq_noh_mask_music" );
        level thread function_490cc449b7de9830( [ #"hash_5184180cee83d9ca", #"hash_5184170cee83d817" ], level.players, 0.5, 1 );
        level utility::flag_set( "mq_step_5_complete" );
    }
    else
    {
        level thread function_eda64e9d9102473f();
    }
    
    level notify( #"hash_27fbe7096c1a60cc" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x78b704fe, Offset: 0x1074a
// Size: 0xac
function function_eda64e9d9102473f()
{
    level endon( #"game_ended" );
    level function_ecc91637c2a6fbb1();
    
    if ( level.hornet_mq.f_mask )
    {
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "fx", "noh_failed" );
    }
    
    level waittill( #"on_round_start" );
    level utility::flag_set( "n_mask_puzzle_reenabled" );
    level function_ecc91637c2a6fbb1();
    
    if ( level.hornet_mq.f_mask )
    {
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "fx", "none" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x455790eb, Offset: 0x107fe
// Size: 0x167
function function_d37250ba7b3e39eb( a_sequence )
{
    level endon( #"game_ended" );
    level endon( #"hash_27fbe7096c1a60cc" );
    level thread function_5fa91076a3b825b5();
    
    while ( true )
    {
        var_4347b70d1a2af5ff = 1;
        
        foreach ( mask_struct in level.hornet_mq.noh_puzzle.wall_masks )
        {
            mask_state = mask_struct.sbl getscriptablepartstate( "fx" );
            
            if ( mask_state != "off" )
            {
                var_4347b70d1a2af5ff = 0;
            }
        }
        
        if ( var_4347b70d1a2af5ff )
        {
            break;
        }
        
        wait 0.1;
    }
    
    for ( i = 0; i < a_sequence.size ; i++ )
    {
        mask_int = a_sequence[ i ];
        level.hornet_mq.noh_puzzle.wall_masks[ mask_int ].sbl utility::function_7c10ea82c1e305b8( "fx", string( mask_int ) );
        wait 2;
    }
    
    wait 1;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x40de62bd, Offset: 0x1096d
// Size: 0x217
function function_5fa91076a3b825b5()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_damaged", &function_c2bee78b4ae8254f ) )
    {
        level callback::add( #"on_ai_damaged", &function_c2bee78b4ae8254f );
    }
    
    trig = getent( "n_mask_trig", #targetname );
    
    while ( !level utility::flag( "n_mask_puzzle_round_active" ) )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( trig ) && !player utility::ent_flag( "hornet_mq_mask_demo_early_reset_notarget" ) )
            {
                if ( !player.var_bfbb61330ab94ce9 )
                {
                    player.var_bfbb61330ab94ce9 = 1;
                    player val::set( "hornet_mq_n_mask_demonstration", "ignoreme", 1 );
                }
                
                continue;
            }
            
            if ( player.var_bfbb61330ab94ce9 )
            {
                player.var_bfbb61330ab94ce9 = 0;
                player val::reset_all( "hornet_mq_n_mask_demonstration" );
            }
        }
        
        wait 0.2;
    }
    
    foreach ( player in level.players )
    {
        player.var_bfbb61330ab94ce9 = undefined;
        player val::reset_all( "hornet_mq_n_mask_demonstration" );
        player utility::ent_flag_clear( "hornet_mq_mask_demo_early_reset_notarget" );
    }
    
    if ( level callback::exists( #"on_ai_damaged", &function_c2bee78b4ae8254f ) )
    {
        level callback::remove( #"on_ai_damaged", &function_c2bee78b4ae8254f );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x9894fa56, Offset: 0x10b8c
// Size: 0x35
function function_c2bee78b4ae8254f( params )
{
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker utility::ent_flag_set( "hornet_mq_mask_demo_early_reset_notarget" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc40d0074, Offset: 0x10bc9
// Size: 0x183
function function_8076bfeac8ae20fe( a_sequence )
{
    level endon( #"game_ended" );
    level endon( #"hash_27fbe7096c1a60cc" );
    level endon( #"n_mask_puzzle_round_ended" );
    var_a65a556e144e8c0b = utility::getstructarray( "n_mask_p_spawn", "targetname" );
    var_a65a556e144e8c0b = arrayrandomize( var_a65a556e144e8c0b );
    spawners_to_use = utility::array_slice( var_a65a556e144e8c0b, 0, a_sequence.size );
    
    for ( i = 0; i < spawners_to_use.size ; i++ )
    {
        mask_type = a_sequence[ i ];
        level thread function_bffc448792f681e2( mask_type, spawners_to_use[ i ] );
    }
    
    for ( i = 0; i < roundint( a_sequence.size / 2 ) ; i++ )
    {
        mask_type = utility::array_random( a_sequence );
        level thread function_bffc448792f681e2( mask_type, utility::array_random( var_a65a556e144e8c0b ) );
    }
    
    var_a0a27536579257e4 = arrayrandomize( level.players );
    
    foreach ( player in var_a0a27536579257e4 )
    {
        if ( player.var_45806768a9c23a8b )
        {
            player thread function_2a6deff157d1165a( #"hash_a9e02a294abd5e5", undefined, 4.5 );
            break;
        }
    }
    
    level function_3c8259fffcdb2b13();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x27146895, Offset: 0x10d54
// Size: 0x154
function function_3c8259fffcdb2b13()
{
    level endon( #"hash_27fbe7096c1a60cc" );
    var_99d40f3880840018 = 0.33;
    var_a65a556e144e8c0b = utility::getstructarray( "n_mask_p_spawn", "targetname" );
    var_a65a556e144e8c0b = arrayrandomize( var_a65a556e144e8c0b );
    var_65fe938ca22b9c53 = [ 0, 1, 2, 3, 4 ];
    
    while ( true )
    {
        wait var_99d40f3880840018;
        min_zoms = level.players.size == 1 ? 6 : level.players.size > 3 ? 9 : 8;
        level.hornet_mq.var_443f9790b3051c1c = utility::array_removedead_or_dying( level.hornet_mq.var_443f9790b3051c1c );
        
        if ( level.hornet_mq.var_443f9790b3051c1c.size >= min_zoms )
        {
            continue;
        }
        
        zoms_to_spawn = min_zoms - level.hornet_mq.var_443f9790b3051c1c.size;
        
        for ( i = 0; i < zoms_to_spawn ; i++ )
        {
            mask_type = utility::array_random( var_65fe938ca22b9c53 );
            level function_bffc448792f681e2( mask_type, utility::array_random( var_a65a556e144e8c0b ) );
            wait var_99d40f3880840018;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xf061f1ef, Offset: 0x10eb0
// Size: 0x2c, Type: bool
function private compare_script_int( item1, item2 )
{
    return item1.script_int < item2.script_int;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf4ff25cb, Offset: 0x10ee5
// Size: 0xd3
function function_9bd5cafcd7b0a736()
{
    level thread function_db840c891e326576();
    level utility::flag_clear( "n_mask_puzzle_active" );
    level function_6e29e1bbb80eff60( 0, [ "zone_main_keep_west_path_a" ] );
    a_barrier_loc = utility::getstructarray( "nh_barrier_loc", "targetname" );
    
    foreach ( var_dff548c3090b7c3b in a_barrier_loc )
    {
        if ( var_dff548c3090b7c3b.sbl )
        {
            var_dff548c3090b7c3b.sbl freescriptable();
        }
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xaf44ec7, Offset: 0x10fc0
// Size: 0x15e
function function_db840c891e326576()
{
    level endon( #"game_ended" );
    search_center = utility::getstruct( "f_mask_place_loc", "targetname" );
    var_4db281afd81246b9 = getaiarrayinradius( search_center.origin, 1500 );
    var_892ba4c542dfcb2f = [];
    
    foreach ( zom in var_4db281afd81246b9 )
    {
        if ( isdefined( zom.mask_type ) )
        {
            var_892ba4c542dfcb2f[ var_892ba4c542dfcb2f.size ] = zom;
        }
    }
    
    foreach ( zom in var_892ba4c542dfcb2f )
    {
        throttle::throttle_wait_in_queue( level.hornet_mq.throttle, zom );
        zom.forceannihilate = 1;
        zom kill();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe1e6d19f, Offset: 0x11126
// Size: 0x142
function function_abf8d431a8614c42( trig )
{
    self notify( #"hash_b78acb1a9fb0bcd1" );
    self endon( #"hash_b78acb1a9fb0bcd1" );
    level endon( #"game_ended" );
    level endon( #"hash_27fbe7096c1a60cc" );
    level.hornet_mq.var_443f9790b3051c1c = [];
    
    while ( true )
    {
        trig waittill( #"trigger", ent );
        
        if ( ent.var_45806768a9c23a8b )
        {
            continue;
        }
        
        if ( isplayer( ent ) && ( player::isinlaststand( ent ) || !isalive( ent ) ) )
        {
            continue;
        }
        
        if ( isai( ent ) && !utility::is_dead_or_dying( ent ) && !arraycontains( level.hornet_mq.var_443f9790b3051c1c, ent ) )
        {
            if ( !val::get( "ammomod_immune" ) )
            {
                ent val::set( "hornet_mq_n_mask_puzzle", "ammomod_immune", 1 );
            }
            
            level.hornet_mq.var_443f9790b3051c1c[ level.hornet_mq.var_443f9790b3051c1c.size ] = ent;
        }
        
        ent.var_45806768a9c23a8b = 1;
        ent thread function_24e4e30154c4b6ab( trig );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xa05f5618, Offset: 0x11270
// Size: 0x191
function function_24e4e30154c4b6ab( trig )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_27fbe7096c1a60cc" );
    
    if ( isplayer( self ) )
    {
        b_isplayer = 1;
        callback::add( #"player_disconnect", &function_38c343104fa1141b );
    }
    
    while ( self istouching( trig ) )
    {
        if ( b_isplayer )
        {
            if ( player::isinlaststand( self ) )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    self.var_45806768a9c23a8b = 0;
    
    if ( isai( self ) && !utility::is_dead_or_dying( self ) )
    {
        if ( val::get( "ammomod_immune" ) )
        {
            val::reset_all( "hornet_mq_n_mask_puzzle" );
        }
        
        if ( isdefined( self.mask_type ) )
        {
            level.hornet_mq.var_2c5788c0eb038232 = 0;
            zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253", level.hornet_mq.var_2c5788c0eb038232 );
            sound_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
            playsoundatpos( sound_pos.origin, "evt_mq_mask_event_fail" );
            level zm_music::function_e9fd14ede793ef0d( "mq_noh_mask_music" );
            level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
            logstring( "************mq_nmask_fail reason: masked left zone" );
            
            /#
                iprintlnbold( "<dev string:x46>" );
            #/
            
            level thread function_4fdf34138bcf43d0();
            return;
        }
    }
    
    if ( b_isplayer )
    {
        callback::remove( #"player_disconnect", &function_38c343104fa1141b );
        level function_38c343104fa1141b();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x887a90f9, Offset: 0x11409
// Size: 0x6e
function function_4fdf34138bcf43d0()
{
    level thread function_490cc449b7de9830( [ #"hash_fa9aef91f34403ed", #"hash_fa9aec91f343fed4" ], level.players, 0.5, 1 );
    level notify( #"hash_27fbe7096c1a60cc" );
    level utility::flag_clear( "n_mask_puzzle_round_active" );
    
    if ( !level utility::flag( "mq_step_5_complete" ) )
    {
        level thread function_eda64e9d9102473f();
    }
    
    level function_9bd5cafcd7b0a736();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe129e9c4, Offset: 0x1147f
// Size: 0x23
function function_3e2edad798996d83( params )
{
    if ( isdefined( self ) )
    {
        self.var_45806768a9c23a8b = 0;
    }
    
    level function_38c343104fa1141b();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x9c12c542, Offset: 0x114aa
// Size: 0x127
function function_38c343104fa1141b( params )
{
    foreach ( player in level.players )
    {
        if ( player.var_45806768a9c23a8b )
        {
            return;
        }
    }
    
    level.hornet_mq.var_2c5788c0eb038232 = 0;
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_1f22bbf5eb7b1253", level.hornet_mq.var_2c5788c0eb038232 );
    sound_pos = utility::getstruct( "f_mask_place_loc", "targetname" );
    playsoundatpos( sound_pos.origin, "evt_mq_mask_event_fail" );
    level zm_music::function_e9fd14ede793ef0d( "mq_noh_mask_music" );
    level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
    logstring( "************mq_nmask_fail reason: players left zone" );
    level thread function_4fdf34138bcf43d0();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdcd94560, Offset: 0x115d9
// Size: 0x271
function function_bded3d1a185ff1e4()
{
    self notify( #"hash_cccef443e661a62c" );
    self endon( #"hash_cccef443e661a62c" );
    level endon( #"game_ended" );
    level endon( #"hash_27fbe7096c1a60cc" );
    level endon( #"n_mask_puzzle_round_ended" );
    step = 0.1;
    
    while ( true )
    {
        var_4431504627a295f4 = [];
        
        foreach ( zom in level.hornet_mq.var_443f9790b3051c1c )
        {
            if ( isalive( zom ) && isdefined( zom.mask_type ) )
            {
                if ( isalive( zom.enemy ) && !zom.enemy.var_45806768a9c23a8b )
                {
                    var_4431504627a295f4[ var_4431504627a295f4.size ] = zom;
                }
            }
        }
        
        if ( var_4431504627a295f4.size == 0 )
        {
            wait step;
            continue;
        }
        
        var_153319e852ccf0f6 = [];
        
        foreach ( player in level.players )
        {
            if ( player.var_45806768a9c23a8b )
            {
                var_153319e852ccf0f6[ var_153319e852ccf0f6.size ] = player;
            }
        }
        
        if ( var_153319e852ccf0f6.size == 0 )
        {
            wait step;
            continue;
        }
        
        foreach ( zom in var_4431504627a295f4 )
        {
            if ( var_153319e852ccf0f6.size > 1 )
            {
                new_enemy_player = function_47c86977a18df38b( var_153319e852ccf0f6, zom.origin, 4500 );
            }
            else
            {
                new_enemy_player = var_153319e852ccf0f6[ 0 ];
            }
            
            if ( isdefined( new_enemy_player ) )
            {
                zom thread function_e28a1426e1d22a0d( new_enemy_player );
            }
        }
        
        wait step;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xaee1be9a, Offset: 0x11852
// Size: 0xb3
function function_e28a1426e1d22a0d( new_enemy_player )
{
    self notify( #"hash_192626f0dd5f829a" );
    self endon( #"hash_192626f0dd5f829a" );
    self endon( #"death" );
    
    if ( !isdefined( new_enemy_player ) )
    {
        return;
    }
    
    var_3d065c4e99e3d90f = "hornet_mq_noh_mask_targeting";
    zombie_utils::set_ai_target_priority( new_enemy_player, var_3d065c4e99e3d90f, 6 );
    time_elapsed = 0;
    step = 0.1;
    var_e0a6725d56aaf029 = 3;
    
    while ( time_elapsed < var_e0a6725d56aaf029 )
    {
        if ( !isdefined( new_enemy_player ) || !new_enemy_player.var_45806768a9c23a8b )
        {
            break;
        }
        
        time_elapsed += step;
        wait step;
    }
    
    zombie_utils::set_ai_target_priority( undefined, var_3d065c4e99e3d90f, 0 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0xb0e42cf8, Offset: 0x1190d
// Size: 0x10d
function private function_93cec4cbfd91ec9e( num_masks )
{
    var_65fe938ca22b9c53 = [ 0, 1, 2, 3, 4 ];
    sequence = [];
    
    for ( i = 0; i < num_masks ; i++ )
    {
        mask = utility::array_random( var_65fe938ca22b9c53 );
        
        if ( i - 2 >= 0 && sequence[ i - 2 ] == mask && sequence[ i - 1 ] == mask )
        {
            if ( mask > 0 && mask < var_65fe938ca22b9c53.size - 1 )
            {
                random_mod = utility::array_random( [ -1, 1 ] );
                mask += random_mod;
            }
            else if ( mask > 0 && !mask < var_65fe938ca22b9c53.size - 1 )
            {
                mask -= 1;
            }
            else if ( !mask > 0 && mask < var_65fe938ca22b9c53.size - 1 )
            {
                mask += 1;
            }
        }
        
        sequence[ sequence.size ] = mask;
    }
    
    return sequence;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xae54ff83, Offset: 0x11a23
// Size: 0x860
function function_d503cd35783a2003()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.hornet_mq.f_mask ) )
    {
        place_loc = utility::getstruct( "f_mask_place_loc", "targetname" );
        level.hornet_mq.f_mask = spawnscriptable( %"zm_sat_hornet_mq_f_mask", place_loc.origin, ( 0, 10, 90 ) );
    }
    
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "model", "mask_simple" );
    level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "collision", "on" );
    level scriptable::scriptable_adddamagedcallback( &function_c1c2015ffc8b70b2 );
    level.hornet_mq.f_mask.trail_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", level.hornet_mq.f_mask.origin, level.hornet_mq.f_mask.angles );
    level.hornet_mq.f_mask.trail_fx utility::function_7c10ea82c1e305b8( "visual", "f_mask" );
    mover = utility::spawn_model( "tag_origin", level.hornet_mq.f_mask.origin, level.hornet_mq.f_mask.angles );
    waitframe();
    level.hornet_mq.f_mask utility::scriptable_setparententity( mover, ( 0, 0, 0 ), ( 0, 90, 90 ) );
    level.hornet_mq.f_mask.trail_fx utility::scriptable_setparententity( mover );
    last_node = undefined;
    evidence_index = 0;
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" );
    
    if ( isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, 2 ) )
    {
        level utility::flag_set( "mq_player_got_ev_sus_p" );
        
        if ( utility::get_bit_flag( gathered_evidence, 1 ) )
        {
            last_node = utility::getstruct( "fmask_rloc_3", "targetname" );
            mover.origin = last_node.origin;
            mover.angles = last_node.angles;
            evidence_index = 2;
            b_skip_move = 1;
            level utility::flag_set( "mq_player_got_ev_sus_ca" );
        }
        else
        {
            last_node = utility::getstruct( "fmask_rloc_2", "targetname" );
            mover.origin = last_node.origin;
            mover.angles = last_node.angles;
            evidence_index = 1;
            b_skip_move = 1;
        }
    }
    
    while ( true )
    {
        if ( !b_skip_move )
        {
            level function_ecc91637c2a6fbb1();
            
            if ( last_node )
            {
                node_start = utility::getstruct( last_node.target, "targetname" );
                time = last_node.script_float;
            }
            else
            {
                node_start = utility::getstruct( "f_mask_path_start", "targetname" );
                time = node_start.script_float;
            }
            
            path = [ node_start.origin ];
            node = node_start;
            
            while ( node.target )
            {
                var_c27efcf4d873bd51 = utility::getstruct( node.target, "targetname" );
                path[ path.size ] = var_c27efcf4d873bd51.origin;
                node = var_c27efcf4d873bd51;
                
                if ( issubstr( node.targetname, "fmask_rloc" ) )
                {
                    last_node = node;
                    break;
                }
                
                if ( node.script_noteworthy == "mq_kt_loc" )
                {
                    b_final_path = 1;
                    break;
                }
            }
            
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "audio", "chase" );
            
            if ( !b_final_path )
            {
                level.hornet_mq.f_mask thread function_5e0a645de9fffe22( time / 5 * 4 );
            }
            
            mover utility::function_2159dd4196ff4b81( path, time, 1, 1, 0, 0.85, 0.5 );
        }
        
        b_skip_move = 0;
        
        if ( b_final_path )
        {
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "projectile_fx", "ev_release" );
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "model", "invisible" );
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "audio", "dissipate" );
            wait 2;
            break;
        }
        
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "model", "mask_simple" );
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "audio", "off" );
        level utility::flag_set( "fmask_hiding" );
        mover.angles = last_node.angles + ( 180, 90, 90 );
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "health", "fmask_damageable" );
        
        if ( level.directed_mode )
        {
            s_waypoint = utility::getstruct( "fmloc_gd_" + string( evidence_index + 1 ), "targetname" );
            s_waypoint.radius = evidence_index + 1 == 3 ? 400 : s_waypoint.radius;
            level.hornet_mq.f_mask.hiding_data = { #radius:s_waypoint.radius, #origin:s_waypoint.origin };
            level thread function_ab99e7279e25d332( s_waypoint );
        }
        
        if ( evidence_index == 1 && isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, 1 ) )
        {
            level utility::flag_set( "mq_player_got_ev_sus_ca" );
            b_skip_location = 1;
        }
        else if ( evidence_index == 2 && isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, 0 ) )
        {
            level utility::flag_set( "mq_player_got_ev_sus_co" );
            b_skip_location = 1;
        }
        
        if ( !b_skip_location )
        {
            level function_ecc91637c2a6fbb1();
            level waittill( #"hash_de2c2f4b324653eb", eattacker );
            level utility::flag_clear( "fmask_hiding" );
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "health", "idle" );
            level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "audio", "evidence" );
            level thread function_1a78f8a4bc01f983( evidence_index, level.hornet_mq.f_mask.origin, ( 0, 0, 0 ), eattacker );
        }
        
        b_skip_location = 0;
        evidence_index += 1;
        level.hornet_mq.f_mask utility::function_7c10ea82c1e305b8( "model", "mask_simple" );
        level.hornet_mq.f_mask.trail_fx utility::function_7c10ea82c1e305b8( "visual", "f_mask" );
    }
    
    if ( level.hornet_mq.f_mask.trail_fx )
    {
        level.hornet_mq.f_mask.trail_fx freescriptable();
    }
    
    if ( level.hornet_mq.f_mask )
    {
        level.hornet_mq.f_mask freescriptable();
        level.hornet_mq.f_mask = undefined;
    }
    
    mover delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x17d11615, Offset: 0x1228b
// Size: 0x53
function function_5e0a645de9fffe22( time_sec )
{
    wait time_sec;
    utility::function_7c10ea82c1e305b8( "fx", "none" );
    utility::function_7c10ea82c1e305b8( "model", "invisible" );
    self.trail_fx utility::function_7c10ea82c1e305b8( "visual", "invisible" );
    level function_3582825f5c626855();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x9fb745c3, Offset: 0x122e6
// Size: 0x16c
function function_ab99e7279e25d332( waypoint )
{
    self notify( #"hash_f45658bf7f4b44e1" );
    self endon( #"hash_f45658bf7f4b44e1" );
    
    while ( level utility::flag( "fmask_hiding" ) )
    {
        b_players_nearby = 0;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, waypoint.origin ) < waypoint.radius * waypoint.radius && abs( player.origin[ 2 ] - waypoint.origin[ 2 ] ) < 64 )
            {
                b_players_nearby = 1;
                break;
            }
        }
        
        if ( b_players_nearby )
        {
            if ( !level utility::flag( "hornet_mq_players_near_hidden_mask" ) )
            {
                level utility::flag_set( "hornet_mq_players_near_hidden_mask" );
                level function_ecc91637c2a6fbb1();
            }
        }
        else if ( level utility::flag( "hornet_mq_players_near_hidden_mask" ) )
        {
            level utility::flag_clear( "hornet_mq_players_near_hidden_mask" );
            level function_ecc91637c2a6fbb1();
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0x693ab9f, Offset: 0x1245a
// Size: 0x9c
function function_c1c2015ffc8b70b2( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_hornet_mq_f_mask" )
    {
        return;
    }
    
    instance utility::function_7c10ea82c1e305b8( "projectile_fx", "ev_release" );
    level notify( #"hash_de2c2f4b324653eb", eattacker );
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0xf32af7df, Offset: 0x124fe
// Size: 0x29d
function function_1a78f8a4bc01f983( evidence_index, origin, angles, player )
{
    level endon( #"game_ended" );
    var_9734ee8502ef0d3d = [ %"hash_27269d4a6428ec8c", %"hash_47d05eb0cc0b8fc", %"hash_72a9aaeb0284481d" ];
    itembundle = var_9734ee8502ef0d3d[ evidence_index ];
    item = level mq_spawn_item( itembundle, origin, angles );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    s_target_pos = utility::getstruct( "ev_sus_fall_idx_" + string( evidence_index ), "targetname" );
    end_pos = s_target_pos.origin + ( s_target_pos.script_int, s_target_pos.script_int, 0 );
    trail_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", item.origin, angles );
    trail_fx utility::function_7c10ea82c1e305b8( "visual", "gold" );
    mover = utility::spawn_model( "tag_origin", item.origin, angles );
    waitframe();
    item utility::scriptable_setparententity( mover );
    trail_fx utility::scriptable_setparententity( mover );
    distance = distancesquared( mover.origin, end_pos );
    var_ef4c488861c69885 = 280;
    travel_time = clamp( distance / var_ef4c488861c69885 * var_ef4c488861c69885, 0.85, 1 );
    control_pos = ( ( origin[ 0 ] + end_pos[ 0 ] ) / 2, ( origin[ 1 ] + end_pos[ 1 ] ) / 2, origin[ 2 ] + 50 );
    mover thread function_cad0bf3e8e891213();
    mover utility::function_8001268940441423( mover.origin, end_pos, control_pos, travel_time );
    waitframe();
    
    if ( isdefined( item ) )
    {
        item utility::scriptable_clearparententity();
        item.angles = s_target_pos.angles;
    }
    
    if ( isdefined( mover ) )
    {
        mover delete();
    }
    
    if ( isdefined( trail_fx ) )
    {
        trail_fx freescriptable();
    }
    
    switch ( evidence_index )
    {
        case 0:
            level.hornet_mq.ev_pipe = item;
            break;
        case 1:
            level.hornet_mq.ev_case = item;
            break;
        case 2:
            level.hornet_mq.ev_comb = item;
            break;
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xe84087f8, Offset: 0x127a3
// Size: 0x1fd
function setup_coin_box()
{
    level utility::flag_wait_all( "scriptables_ready", "magicbox_ready" );
    a_valid_boxes = [];
    prevented_box_locs = [ ( -1421, -22179, 137 ), ( 1910.37, -22397.9, 227 ) ];
    
    foreach ( var_209ed49971299121 in level.var_1bbb5557537e2c0c )
    {
        var_1dfe9780535a42fe = 0;
        
        foreach ( prevented_origin in prevented_box_locs )
        {
            if ( distance2dsquared( var_209ed49971299121.origin, prevented_origin ) <= 2500 )
            {
                var_1dfe9780535a42fe = 1;
            }
        }
        
        if ( !var_1dfe9780535a42fe )
        {
            a_valid_boxes[ a_valid_boxes.size ] = var_209ed49971299121;
        }
    }
    
    target_box = utility::array_random( a_valid_boxes );
    level.hornet_mq.coin_box = target_box;
    [ coin_loc ] = utility::function_b7f3d374aa10aa51( "mq_gc_loc", "targetname", target_box.origin, 200 );
    assert( isdefined( coin_loc ), "<dev string:x62>" );
    level.hornet_mq.ghost_coin = spawnscriptable( %"zm_sat_hornet_mq_coin", coin_loc.origin, coin_loc.angles );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x1f54319e, Offset: 0x129a8
// Size: 0x166
function function_10c9ef343431801b()
{
    if ( level.directed_mode )
    {
        level utility::flag_wait( "mq_directed_revealed_screen_sus" );
    }
    
    if ( level.hornet_mq.ghost_coin )
    {
        level.hornet_mq.ghost_coin utility::function_7c10ea82c1e305b8( "fx", "coin_glow" );
    }
    
    level callback::add( "magicbox_used", &on_magicbox_used );
    level thread function_7ea5c00d03806ed5();
    
    if ( level.directed_mode )
    {
        if ( !level callback::exists( #"equipment_given", &function_d4ba804bf48616b9 ) )
        {
            level callback::add( #"equipment_given", &function_d4ba804bf48616b9 );
        }
        
        if ( !level callback::exists( #"equipment_ammo_set", &function_d4ba804bf48616b9 ) )
        {
            level callback::add( #"equipment_ammo_set", &function_d4ba804bf48616b9 );
        }
        
        if ( !level callback::exists( #"hash_9325330e77aef2ad", &on_fire_sale ) )
        {
            level callback::add( #"hash_9325330e77aef2ad", &on_fire_sale );
        }
        
        if ( !level callback::exists( #"firesale_end", &function_fea81c3cdaf819f4 ) )
        {
            level callback::add( #"firesale_end", &function_fea81c3cdaf819f4 );
        }
        
        if ( !level callback::exists( "field_upgrade_used", &on_field_upgrade_used ) )
        {
            level callback::add( "field_upgrade_used", &on_field_upgrade_used );
        }
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0x552a4755, Offset: 0x12b16
// Size: 0x123
function private on_magicbox_used( params )
{
    if ( level utility::flag( "mq_step_9_complete" ) )
    {
        return;
    }
    
    if ( level.directed_mode )
    {
        params.var_349a0723ed9ac19c thread function_9754b3a6d190d07b();
    }
    
    if ( params.var_349a0723ed9ac19c != level.hornet_mq.coin_box )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"bgb", #"is_enabled", "wonderbar" ) )
    {
        return;
    }
    
    near_neko = level function_124ba5d7960ae3d5( params.var_349a0723ed9ac19c );
    
    if ( !isdefined( near_neko ) )
    {
        return;
    }
    
    params.var_349a0723ed9ac19c.var_1d277c93fff5ec4d = "zm_sat_hornet_item_quest_mq_purse";
    level utility::flag_set( "mq_mnk_set" );
    
    if ( isdefined( near_neko ) )
    {
        fx = spawnscriptable( %"hash_646825aa6b00139", near_neko.origin, near_neko.angles );
        fx thread function_74f4695662cf0986( near_neko );
    }
    
    level function_ecc91637c2a6fbb1();
    params.var_349a0723ed9ac19c thread function_bad6cf8a8f85852c();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x26757dfe, Offset: 0x12c41
// Size: 0x2cc
function function_124ba5d7960ae3d5( coin_box )
{
    var_fb7b0eefb7d521a8 = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.maneki_neko ) )
        {
            var_fb7b0eefb7d521a8[ var_fb7b0eefb7d521a8.size ] = player.maneki_neko;
        }
    }
    
    if ( var_fb7b0eefb7d521a8.size <= 0 )
    {
        return;
    }
    
    corner_a = coin_box.origin + vectornormalize( anglestoforward( coin_box.angles ) ) * 125 + vectornormalize( anglestoright( coin_box.angles ) ) * 89;
    corner_b = coin_box.origin + vectornormalize( anglestoforward( coin_box.angles ) ) * 125 - vectornormalize( anglestoright( coin_box.angles ) ) * 89;
    corner_c = coin_box.origin - vectornormalize( anglestoforward( coin_box.angles ) ) * 125 - vectornormalize( anglestoright( coin_box.angles ) ) * 89;
    corner_d = coin_box.origin - vectornormalize( anglestoforward( coin_box.angles ) ) * 125 + vectornormalize( anglestoright( coin_box.angles ) ) * 89;
    
    foreach ( maneki_neko in var_fb7b0eefb7d521a8 )
    {
        b_istouching = utility::function_3fa3de7c5aef7907( maneki_neko.origin, corner_a, corner_b, corner_c, corner_d );
        
        /#
            debugstar( corner_a, ( 1, 0, 0 ), 900 );
            debugstar( corner_b, ( 1, 0, 0 ), 900 );
            debugstar( corner_c, ( 1, 0, 0 ), 900 );
            debugstar( corner_d, ( 1, 0, 0 ), 900 );
        #/
        
        if ( b_istouching )
        {
            near_neko = maneki_neko;
            var_3b5bd788782ba9ff = 1;
            break;
        }
    }
    
    if ( !var_3b5bd788782ba9ff )
    {
        return;
    }
    
    return near_neko;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf8b478c, Offset: 0x12f16
// Size: 0x55
function function_9754b3a6d190d07b()
{
    self notify( #"hash_c2a17367080a9b9f" );
    self endon( #"hash_c2a17367080a9b9f" );
    delay_msg = utility::waittill_any_return( "magicbox_closed", "magicbox_left" );
    
    if ( delay_msg == "magicbox_left" )
    {
        wait 8;
    }
    else
    {
        wait 0.1;
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5be6cf49, Offset: 0x12f73
// Size: 0x51
function function_74f4695662cf0986( source_neko )
{
    level endon( #"game_ended" );
    wait 3;
    
    if ( !isdefined( source_neko ) )
    {
        self freescriptable();
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "fx", "appear" );
    wait 4;
    
    if ( !isdefined( source_neko ) )
    {
        self freescriptable();
        return;
    }
    
    self freescriptable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xcd6aa5ee, Offset: 0x12fcc
// Size: 0x26
function function_bad6cf8a8f85852c()
{
    self waittill( #"magicbox_closed" );
    self.var_1d277c93fff5ec4d = undefined;
    level utility::flag_clear( "mq_mnk_set" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x20f43aa3, Offset: 0x12ffa
// Size: 0xc8
function function_7ea5c00d03806ed5()
{
    level endon( #"game_ended" );
    level endon( #"end_firesale_start" );
    level endon( #"mq_step_9_complete" );
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        var_349a0723ed9ac19c childthread function_6801b3faa66a8441();
    }
    
    level waittill( #"hash_521db4bb6803fe8c" );
    level.var_8734476d4fee1150 = level.hornet_mq.coin_box;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4f033806, Offset: 0x130ca
// Size: 0x1a
function function_6801b3faa66a8441()
{
    utility::flag_wait( "magicbox_moving" );
    level notify( #"hash_521db4bb6803fe8c" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x14748a87, Offset: 0x130ec
// Size: 0x14
function function_d4ba804bf48616b9( params )
{
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2d251280, Offset: 0x13108
// Size: 0x32
function function_1dff160fff0074b9( params )
{
    if ( !isdefined( function_124ba5d7960ae3d5( level.hornet_mq.coin_box ) ) )
    {
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xbe10cb30, Offset: 0x13142
// Size: 0x17
function on_fire_sale( params )
{
    wait 2;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x878cac4f, Offset: 0x13161
// Size: 0x17
function function_fea81c3cdaf819f4( params )
{
    wait 1;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x64916d86, Offset: 0x13180
// Size: 0x2b
function on_field_upgrade_used( params )
{
    if ( params.ref == "super_mary_paris" )
    {
        wait 4;
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6c9d505d, Offset: 0x131b3
// Size: 0x36
function update_player_perks( params )
{
    if ( zombie_perks::has_perk( "specialty_death_perception" ) )
    {
        self setclientomnvar( "ui_zm_hornet_mq_glints_enabled", 1 );
        return;
    }
    
    self setclientomnvar( "ui_zm_hornet_mq_glints_enabled", 0 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6767756, Offset: 0x131f1
// Size: 0x20e
function function_ee3368c6e69f3ca1()
{
    level endon( #"game_ended" );
    level endon( #"MQ_STEP_10_COMPLETE" );
    level function_ecc91637c2a6fbb1();
    trig = getent( "mq_mem_acc_trig", #targetname );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( trig ) )
            {
                approached_player = player;
                var_5edc72701d83bced = 1;
                break;
            }
        }
        
        if ( var_5edc72701d83bced )
        {
            break;
        }
        
        wait 0.1;
    }
    
    spawn_loc = approached_player getcentroid();
    var_3530c91bc79c1c9e = anglestoforward( approached_player.angles );
    spawn_loc += vectornormalize( var_3530c91bc79c1c9e ) * 10;
    level.hornet_mq.coin_purse = spawnscriptable( %"zm_sat_hornet_mq_coin", spawn_loc, approached_player.angles );
    level.hornet_mq.coin_purse utility::function_7c10ea82c1e305b8( "visual", "purse" );
    mover = utility::spawn_model( "tag_origin", spawn_loc );
    waitframe();
    level.hornet_mq.coin_purse utility::scriptable_setparententity( mover );
    destination = utility::getstruct( "cnp_coalesce_loc", "targetname" );
    mover moveto( destination.origin, 3 );
    mover waittill( #"movedone" );
    waitframe();
    level.hornet_mq.coin_purse thread function_113be2163cc65126( 2, 3 );
    level utility::flag_set( "mq_step_10_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf22083d7, Offset: 0x13407
// Size: 0x86
function function_55acfd3cd98b6c2f()
{
    foreach ( player in level.players )
    {
        player currency::add_currency_amount( #"essence", 9 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf695aa0a, Offset: 0x13495
// Size: 0x1b1
function setup_gardener_flowers()
{
    plant_structs = utility::getstructarray( "mq_acc_g_pl_loc", "script_noteworthy" );
    a_plants = [];
    
    foreach ( struct in plant_structs )
    {
        plant = {};
        plant.var_f6115109f5cdd47c = 0;
        plant.raised_loc = struct;
        plant.lowered_loc = { #angles:struct.angles - ( 0, 720, 0 ), #origin:struct.origin - ( 0, 0, struct.script_int ) };
        plant.mdl = spawnscriptable( %"zm_sat_hornet_mq_acc_g_plant", plant.raised_loc.origin, plant.raised_loc.angles );
        plant.mdl.root = plant;
        [ plant.trig ] = getnoentvolumearray( struct.target, #targetname );
        a_plants[ a_plants.size ] = plant;
    }
    
    level.hornet_mq.a_plants = a_plants;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xfaa2316a, Offset: 0x1364e
// Size: 0x408
function setup_accomplice_zombies( var_b3da033d8e155f46 )
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "init_level_living_world_bundles" );
    var_3495db260d95d87b = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" );
    var_2df6322257f2133e = [ "g", "m", "n" ];
    
    foreach ( ref in var_2df6322257f2133e )
    {
        switch ( ref )
        {
            case #"hash_31103dbc01bd80e6":
                skvp = 3;
                var_f05ecc33838367ff = 17;
                break;
            case #"hash_311046bc01bd8f11":
                skvp = 4;
                var_f05ecc33838367ff = 19;
                break;
            case #"hash_311043bc01bd8a58":
                skvp = 5;
                var_f05ecc33838367ff = 21;
                break;
        }
        
        if ( isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, skvp ) )
        {
            level utility::flag_set( "mq_player_got_ev_acc_" + ref );
            continue;
        }
        
        if ( ref == "g" )
        {
            weed_locs = utility::getstructarray( "mq_acc_g_wd_loc", "targetname" );
            var_2fb3ee833efc4586 = [];
            
            foreach ( loc in weed_locs )
            {
                weed_struct = setup_weed_struct( loc.origin );
                var_2fb3ee833efc4586[ var_2fb3ee833efc4586.size ] = weed_struct;
            }
            
            level.hornet_mq.weed_structs = var_2fb3ee833efc4586;
            
            if ( utility::get_bit_flag( var_3495db260d95d87b, 2 ) )
            {
                var_2fb3ee833efc4586[ 0 ] thread grow_weed();
                var_2fb3ee833efc4586[ 1 ] thread grow_weed();
            }
        }
        
        if ( ref == "n" )
        {
            if ( !level.hornet_mq.var_7261a69b7d3f75cf )
            {
                shutter_1 = getent( "mq_acc_n_de_trig_1", #targetname );
                shutter_2 = getent( "mq_acc_n_de_trig_2", #targetname );
                shutter_3 = getent( "mq_acc_n_de_trig_3", #targetname );
                level.hornet_mq.var_7261a69b7d3f75cf = [ shutter_1, shutter_2, shutter_3 ];
            }
            
            if ( utility::get_bit_flag( var_3495db260d95d87b, 0 ) )
            {
                level thread function_97c525b5f90bd575();
            }
            else
            {
                level callback::add( #"grenade_fire", &function_673bc738bc57c8ed );
            }
        }
        
        if ( ref == "m" )
        {
            if ( !level.hornet_mq.merchant_trig )
            {
                [ level.hornet_mq.merchant_trig ] = getnoentvolumearray( "mq_acc_m_es_trig", #targetname );
                level thread function_ede8bc238620d26();
            }
            
            if ( utility::get_bit_flag( var_3495db260d95d87b, 1 ) )
            {
                var_51bc0779ee40d7a7 = utility::getstruct( "sat_cin_zm_living_world_solo_eating_zmb_01", "script_noteworthy" );
                var_51bc0779ee40d7a7 zm_livingworld::livingworld_spawn_encounter();
                zombie = var_51bc0779ee40d7a7.scene_ents[ "actors" ][ 0 ];
                
                if ( zombie )
                {
                    zombie thread function_722fa62e943f9d10( undefined );
                }
            }
        }
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x46d3e87, Offset: 0x13a5e
// Size: 0x81
function function_2ff429eb92e72314()
{
    val::set( "hornet_mq_acc_val", "ignore_cleanup", 1 );
    val::set( "hornet_mq_acc_val", "allow_dismember", 0 );
    val::set( "hornet_mq_acc_val", "ignore_blackhole_bomb", 1 );
    val::set( "hornet_mq_acc_val", "allow_brot", 0 );
    self.var_a13bed1ac47e1b2c = 1;
    self.script_animation = "spawn_hop";
    self.b_disable_cordyception = 1;
    utility::function_7c10ea82c1e305b8( "hornet_mq_icon", "active" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb08f5e2f, Offset: 0x13ae7
// Size: 0x2b9
function function_b2488a168322aad1()
{
    level utility::flag_set( "mq_acc_g_summoned" );
    var_3495db260d95d87b = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_3495db260d95d87b = utility::set_bit_flag( var_3495db260d95d87b, 2 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_3495db260d95d87b );
    spawners = utility::getstructarray( "acc_s_l_g", "targetname" );
    spawner = utility::array_random( spawners );
    level zm_music::start_zone_music_watcher( "mq_gardener_music", [ "zone_lava_garden_a", "zone_lava_garden_b", "zone_lava_garden_c", "zone_third_bailey_east_b", "zone_second_bailey_d" ], #"mq_gardener" );
    params = {};
    params.round_override = 15;
    zombie = function_89266a24d0006d65( "sat_spawner_zombie_base_zm_hornet_mq_acc_g", spawner, params );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    zombie function_2ff429eb92e72314();
    zombie.b_ignore_toxic_growth = 1;
    zombie val::set( "hornet_mq_acc_val", "damage", 0 );
    zombie zone_spawner::function_ce10e453e7f7bb8e( zombie );
    
    if ( isdefined( zombie ) )
    {
        zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "mq_acc_g", 6 );
    }
    
    zombie callback::add( "on_zombie_ai_killed", &function_edfd86b33e11a345, "g" );
    zombie zombie_utils::function_dfae6a5bd222c586( &function_d7440fdd6864899d );
    zombie val::reset( "hornet_mq_acc_val", "damage" );
    level.hornet_mq.gardener_zombie = zombie;
    level scriptable::scriptable_adddamagedcallback( &function_f2eaffae45a30ee5 );
    
    foreach ( plant in level.hornet_mq.a_plants )
    {
        plant.mdl utility::function_7c10ea82c1e305b8( "health", "plant_damageable" );
        plant.mdl thread function_915f4cb9f8b26005();
    }
    
    zombie thread function_529a6447339d169b();
    zombie val::set( "gardener", "ignore_cleanup", 1 );
    zombie.b_cleanup_no_respawn = 1;
    zombie.ignore_enemy_count = 1;
    zombie.var_15598d8e493afe88 = 1;
    zombie.var_825b17c932865df = 1;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6c01175, Offset: 0x13da8
// Size: 0x258
function function_fb612c5b8894d299()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    
    while ( !isdefined( level.players ) || level.players.size <= 0 )
    {
        waitframe();
    }
    
    level.hornet_mq.var_c919f860368d9200 = getentarray( "water_physics_trigger", #targetname );
    var_a7432983aec71fe0 = utility::getstructarray( "trig_water_center", "targetname" );
    
    foreach ( water_center in var_a7432983aec71fe0 )
    {
        water_center.interact = interaction::register_interact( water_center.origin, 300, &on_water_interacted, &water_hint_callback );
        water_center thread function_281539d414d55a9a();
    }
    
    level.hornet_mq.var_8d695c4a2be21565 = [];
    bucket_structs = utility::getstructarray( "jpn_barrel_wood_01_open", "targetname" );
    
    for ( i = 0; i < bucket_structs.size ; i++ )
    {
        bucket_structs[ i ].return_index = i;
        bucket_structs[ i ] function_afb709bfaccf5bc8();
    }
    
    var_fe766e46bbd5032d = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_4eb382909b2ae877" ) ?? 676767;
    
    if ( isdefined( var_fe766e46bbd5032d ) )
    {
        if ( var_fe766e46bbd5032d == 676767 )
        {
            return;
        }
        
        switch ( var_fe766e46bbd5032d )
        {
            case 0:
                bucket_structs[ 0 ].water_level = 0;
                break;
            case 1:
                bucket_structs[ 0 ].water_level = 1;
                break;
            case 2:
                bucket_structs[ 0 ].water_level = 2;
                break;
            case 3:
                bucket_structs[ 0 ].water_level = 3;
                break;
        }
        
        bucket_structs[ 0 ].interact function_4cc11a08315d7661( level.players[ 0 ] );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x588583f8, Offset: 0x14008
// Size: 0xcd
function function_afb709bfaccf5bc8()
{
    self.bucket = utility::spawn_model( "jpn_barrel_wood_01_open", self.origin, self.angles, 0, 0.3 );
    self.interact = zm_quest::function_91f9590e98d57ff6( self.origin, &function_4cc11a08315d7661, &function_e6dc5cc047f94a92 );
    self.interact.var_c0c940b175bdf3ca = self;
    
    if ( self.script_noteworthy == "tea_garden" )
    {
        self.interact utility::function_7c10ea82c1e305b8( "base", "extrasmall" );
    }
    
    self.water_level = self.water_level;
    level.hornet_mq.var_8d695c4a2be21565[ level.hornet_mq.var_8d695c4a2be21565.size ] = self;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x38d7c59b, Offset: 0x140dd
// Size: 0x220
function function_4cc11a08315d7661( player )
{
    if ( player.var_ce3e987a55fb9239 )
    {
        return;
    }
    
    if ( isdefined( player ) && !level utility::flag( "hornet_mq_first_bucket_picked_up" ) )
    {
        level utility::flag_set( "hornet_mq_first_bucket_picked_up" );
        player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
    }
    
    player playsound( "evt_mq_bucket_pickup", undefined, player );
    var_fe766e46bbd5032d = 0;
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_4eb382909b2ae877", var_fe766e46bbd5032d );
    index_to_remove = undefined;
    
    for ( i = 0; i < level.hornet_mq.var_8d695c4a2be21565.size ; i++ )
    {
        if ( level.hornet_mq.var_8d695c4a2be21565[ i ].bucket == self.var_c0c940b175bdf3ca.bucket )
        {
            index_to_remove = i;
            break;
        }
    }
    
    level.hornet_mq.var_8d695c4a2be21565[ index_to_remove ] = undefined;
    
    if ( isint( index_to_remove ) )
    {
        function_cdc669dbc8ea2101( level.hornet_mq.var_8d695c4a2be21565 );
    }
    
    self.var_c0c940b175bdf3ca.bucket delete();
    player.var_ce3e987a55fb9239 = 1;
    self.var_c0c940b175bdf3ca notify( #"hash_c199654a5a8223c7" );
    player.var_f6d8c1de028436b0 = self.var_c0c940b175bdf3ca.return_index;
    
    if ( self.var_c0c940b175bdf3ca.water_level )
    {
        player.water_level = self.var_c0c940b175bdf3ca.water_level;
        player thread function_2047a2138ce27819();
    }
    
    player thread watch_for_drop_bucket();
    player callback::add( #"player_disconnect", &function_9645bc9f8d336e1 );
    player callback::add( #"player_death", &function_9645bc9f8d336e1 );
    level function_ecc91637c2a6fbb1();
    player function_ab65ed8c1d75e438( 1 );
    self freescriptable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x8af4797a, Offset: 0x14305
// Size: 0xe4
function function_ab65ed8c1d75e438( b_show )
{
    if ( b_show )
    {
        if ( !isdefined( self.water_level ) )
        {
            self setclientomnvar( "ui_hud_carried_item_index", 9 );
            self setclientomnvar( "ui_hud_carried_item_count", 1 );
            return;
        }
        
        switch ( self.water_level )
        {
            case 0:
                self setclientomnvar( "ui_hud_carried_item_index", 9 );
                break;
            case 1:
                self setclientomnvar( "ui_hud_carried_item_index", 13 );
                break;
            case 2:
                self setclientomnvar( "ui_hud_carried_item_index", 14 );
                break;
            case 3:
                self setclientomnvar( "ui_hud_carried_item_index", 15 );
                break;
            default:
                return;
        }
        
        self setclientomnvar( "ui_hud_carried_item_count", 1 );
        return;
    }
    
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x791b7c4b, Offset: 0x143f1
// Size: 0x8a
function function_e6dc5cc047f94a92( usable, player )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() && !player.var_ce3e987a55fb9239 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_163a4f06c5577c15", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe017e7d, Offset: 0x14483
// Size: 0x3f
function function_9645bc9f8d336e1( params )
{
    cached_origin = self.origin;
    var_aec84052d285d8fc = self.var_f6d8c1de028436b0;
    level drop_bucket( cached_origin, var_aec84052d285d8fc );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4061a779, Offset: 0x144ca
// Size: 0xc3
function watch_for_drop_bucket()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_6de8fa57f6b8efeb" );
    self notifyonplayercommand( "mq_drop_bucket_notify", "+stance" );
    self notifyonplayercommand( "mq_drop_bucket_notify", "+prone" );
    self notifyonplayercommand( "mq_drop_bucket_notify", "+movedown" );
    self setstance( "stand" );
    val::set( "mq_bucket_carry", "crouch", 0 );
    val::set( "mq_bucket_carry", "stance_change", 0 );
    
    while ( true )
    {
        utility::waittill_any( "mq_drop_bucket_notify", "fasttravel_start" );
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_4eb382909b2ae877", 676767 );
        level thread drop_bucket( self, self.var_f6d8c1de028436b0 );
        return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xba2e045, Offset: 0x14595
// Size: 0x27e
function drop_bucket( var_94fbf8f3bff2a601, var_f6d8c1de028436b0 )
{
    if ( isplayer( var_94fbf8f3bff2a601 ) || isbot( var_94fbf8f3bff2a601 ) )
    {
        water_level = var_94fbf8f3bff2a601.water_level;
        var_94fbf8f3bff2a601 notifyonplayercommandremove( "mq_drop_bucket_notify", "+stance" );
        var_94fbf8f3bff2a601 notifyonplayercommandremove( "mq_drop_bucket_notify", "+prone" );
        var_94fbf8f3bff2a601 notifyonplayercommandremove( "mq_drop_bucket_notify", "+movedown" );
        var_94fbf8f3bff2a601 thread function_31a9b22b4d75cce9();
        start_origin = vectornormalize( anglestoforward( var_94fbf8f3bff2a601.angles ) ) * 48 + var_94fbf8f3bff2a601.origin;
    }
    else
    {
        start_origin = var_94fbf8f3bff2a601;
    }
    
    ground_pos = utility::drop_to_ground( start_origin, 200, -200 );
    
    if ( ground_pos[ 2 ] > start_origin[ 2 ] + 50 )
    {
        ground_pos = utility::drop_to_ground( start_origin, 50, -200 );
    }
    
    ground_angles = ( 0, randomfloatrange( 0, 360 ), 0 );
    bucket_struct = { #water_level:water_level, #return_index:var_f6d8c1de028436b0, #angles:ground_angles, #origin:ground_pos };
    bucket_struct function_afb709bfaccf5bc8();
    playsoundatpos( ground_pos + ( 0, 0, 25 ), #"hash_dd79768344198997" );
    bucket_struct thread function_1ade5240a6c16f88( var_f6d8c1de028436b0 );
    
    if ( !isplayer( var_94fbf8f3bff2a601 ) || isbot( var_94fbf8f3bff2a601 ) )
    {
        return;
    }
    
    var_94fbf8f3bff2a601 notify( #"hash_6de8fa57f6b8efeb" );
    var_94fbf8f3bff2a601 callback::remove( #"player_disconnect", &function_9645bc9f8d336e1 );
    var_94fbf8f3bff2a601 callback::remove( #"player_death", &function_9645bc9f8d336e1 );
    var_94fbf8f3bff2a601 function_ab65ed8c1d75e438( 0 );
    var_94fbf8f3bff2a601.var_ce3e987a55fb9239 = 0;
    
    if ( var_94fbf8f3bff2a601.var_976664409e016652 )
    {
        var_94fbf8f3bff2a601.var_976664409e016652 = 0;
        var_94fbf8f3bff2a601.water_level = undefined;
        var_94fbf8f3bff2a601 callback::remove( #"player_damaged", &on_player_damaged );
    }
    
    bucket_struct.bucket hudoutlineenable( "shimmer_default" );
    level function_ecc91637c2a6fbb1();
    
    if ( bucket_struct.water_level > 0 )
    {
        spawn_loc = bucket_struct.bucket.origin;
        water_fx = spawnscriptable( %"zm_sat_hornet_mq_water_fx", spawn_loc, self.angles );
        water_fx utility::delaycall( 1, &freescriptable );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x181fb65d, Offset: 0x1481b
// Size: 0x32
function function_31a9b22b4d75cce9()
{
    self endon( #"death_or_disconnect" );
    
    while ( self stancebuttonpressed() )
    {
        waitframe();
    }
    
    waitframe();
    self setstance( "stand" );
    val::reset_all( "mq_bucket_carry" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x8eba8c6d, Offset: 0x14855
// Size: 0x123
function function_1ade5240a6c16f88( return_index )
{
    self notify( #"hash_4d50a3a5b47993b9" );
    self endon( #"hash_4d50a3a5b47993b9" );
    self endon( #"hash_c199654a5a8223c7" );
    wait 60;
    index_to_remove = undefined;
    
    for ( i = 0; i < level.hornet_mq.var_8d695c4a2be21565.size ; i++ )
    {
        if ( level.hornet_mq.var_8d695c4a2be21565[ i ].bucket == self.bucket )
        {
            index_to_remove = i;
            break;
        }
    }
    
    level.hornet_mq.var_8d695c4a2be21565[ index_to_remove ] = undefined;
    
    if ( isint( index_to_remove ) )
    {
        function_cdc669dbc8ea2101( level.hornet_mq.var_8d695c4a2be21565 );
    }
    
    self.bucket delete();
    self.interact freescriptable();
    var_e5025e02bb65659d = utility::getstructarray( "jpn_barrel_wood_01_open", "targetname" );
    source_struct = var_e5025e02bb65659d[ return_index ];
    source_struct function_afb709bfaccf5bc8();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x27c063c1, Offset: 0x14980
// Size: 0xe3
function is_player_looking_at_water( var_c919f860368d9200 )
{
    var_3530c91bc79c1c9e = anglestoforward( self getplayerangles() );
    result = trace::ray_trace( self geteye(), self geteye() + var_3530c91bc79c1c9e * 100, undefined, undefined, 1, 0 );
    
    foreach ( water_volume in var_c919f860368d9200 )
    {
        if ( isdefined( result[ "position" ] ) )
        {
            projected_pos = result[ "position" ] + var_3530c91bc79c1c9e * 15;
            
            if ( ispointinvolume( projected_pos, water_volume, 1 ) )
            {
                return result[ "position" ];
            }
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3e593072, Offset: 0x14a6c
// Size: 0xfc
function function_281539d414d55a9a()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        near_players = getplayersinradius( self.origin, self.radius );
        
        if ( !near_players.size > 0 )
        {
            wait 0.2;
            continue;
        }
        
        for ( i = 0; i < near_players.size ; i++ )
        {
            if ( !near_players[ i ].var_ce3e987a55fb9239 )
            {
                near_players[ i ].var_b94012466b9d3a0e = 0;
                continue;
            }
            
            var_3f4c71ebbbc34648 = near_players[ i ] is_player_looking_at_water( level.hornet_mq.var_c919f860368d9200 );
            
            if ( var_3f4c71ebbbc34648 )
            {
                near_players[ i ].var_b94012466b9d3a0e = 1;
                near_players[ i ].var_bb09f7cd47f47cae = var_3f4c71ebbbc34648;
                continue;
            }
            
            near_players[ i ].var_b94012466b9d3a0e = 0;
            near_players[ i ].var_bb09f7cd47f47cae = undefined;
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe05954ea, Offset: 0x14b70
// Size: 0xff
function on_water_interacted( player )
{
    if ( !player.var_ce3e987a55fb9239 )
    {
        return;
    }
    
    if ( !player.var_b94012466b9d3a0e )
    {
        return;
    }
    
    if ( !isdefined( player.water_level ) || player.water_level != 3 )
    {
        water_fx = spawnscriptable( %"zm_sat_hornet_mq_water_fx", player.var_bb09f7cd47f47cae, ( 0, 0, 0 ) );
        water_fx utility::function_7c10ea82c1e305b8( "fx", "pickup_splash" );
        water_fx utility::delaycall( 1, &freescriptable );
    }
    
    player.water_level = 3;
    player thread function_2047a2138ce27819();
    nearby_players = getplayersinradius( player.origin, 360 );
    level thread function_490cc449b7de9830( [ #"hash_2372d9ddf4e710c1", #"hash_2372d6ddf4e70ba8" ], nearby_players, 0.33, 1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xdccc70b3, Offset: 0x14c77
// Size: 0xda
function water_hint_callback( usable, player )
{
    if ( level.directed_mode && player.var_ce3e987a55fb9239 && player.var_b94012466b9d3a0e )
    {
        if ( player.water_level == 3 )
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_5da70b6a15a59c53", #type:"HINT_BUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x7542ed25, Offset: 0x14d59
// Size: 0x23c
function function_2047a2138ce27819()
{
    self notify( #"hash_5cdadb5fc70773ed" );
    self endon( #"hash_5cdadb5fc70773ed" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_6de8fa57f6b8efeb" );
    self.var_976664409e016652 = 1;
    
    if ( !isdefined( self.water_level ) )
    {
        self.water_level = 3;
    }
    
    var_fe766e46bbd5032d = self.water_level;
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_4eb382909b2ae877", var_fe766e46bbd5032d );
    waitframe();
    function_ab65ed8c1d75e438( 1 );
    childthread function_a6a09f2871a9468e();
    
    if ( !callback::exists( #"player_damaged", &on_player_damaged ) )
    {
        callback::add( #"player_damaged", &on_player_damaged );
    }
    
    level function_ecc91637c2a6fbb1();
    
    while ( true )
    {
        self waittill( #"hash_a1f7aa511e90d581", st_reason );
        self.water_level -= 1;
        self.water_level = max( self.water_level, 0 );
        var_fe766e46bbd5032d = self.water_level;
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_4eb382909b2ae877", var_fe766e46bbd5032d );
        function_ab65ed8c1d75e438( 1 );
        spawn_loc = self getcentroid();
        spawn_loc += anglestoforward( self getplayerangles() ) * 5;
        water_fx = spawnscriptable( %"zm_sat_hornet_mq_water_fx", spawn_loc, self.angles );
        water_fx utility::delaycall( 1, &freescriptable );
        
        if ( self.water_level == 0 )
        {
            if ( isdefined( self ) && !level utility::flag( "hornet_mq_first_bucket_water_lost" ) )
            {
                level utility::flag_set( "hornet_mq_first_bucket_water_lost" );
                thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_negative", 0.5 );
            }
            
            break;
        }
        
        level function_ecc91637c2a6fbb1();
        
        if ( st_reason != "grown" )
        {
            wait 2;
        }
    }
    
    self.var_976664409e016652 = 0;
    self.water_level = undefined;
    
    if ( callback::exists( #"player_damaged", &on_player_damaged ) )
    {
        callback::remove( #"player_damaged", &on_player_damaged );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc5661bca, Offset: 0x14f9d
// Size: 0x3b
function function_a6a09f2871a9468e()
{
    while ( true )
    {
        if ( self isjumping() || self issprinting() || self issprintsliding() )
        {
            self notify( #"hash_a1f7aa511e90d581", "movement" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2d44ebc0, Offset: 0x14fe0
// Size: 0x1d
function on_player_damaged( params )
{
    self notify( #"hash_a1f7aa511e90d581", "damage" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x86dbc017, Offset: 0x15005
// Size: 0x153
function setup_weed_struct( center_origin )
{
    var_d730daa4dbff6a82 = [];
    weed = spawnscriptable( %"zm_sat_hornet_mq_weed", center_origin, ( 0, randomfloatrange( 0, 360 ), 0 ) );
    var_d730daa4dbff6a82[ var_d730daa4dbff6a82.size ] = weed;
    weeds_to_spawn = 3 - var_d730daa4dbff6a82.size;
    
    for ( i = 0; i < weeds_to_spawn ; i++ )
    {
        new_origin = center_origin + ( utility::array_random( [ -4, -3, 3, 4 ] ), utility::array_random( [ -4, -3, 3, 4 ] ), randomfloatrange( 1, 8 ) );
        weed = spawnscriptable( %"zm_sat_hornet_mq_weed", new_origin, ( 0, randomfloatrange( 0, 360 ), 0 ) );
        var_d730daa4dbff6a82[ var_d730daa4dbff6a82.size ] = weed;
    }
    
    interact = zm_quest::function_91f9590e98d57ff6( center_origin + ( 0, 0, 10 ), &function_e61d19fffad407f5, &weed_hint_callback );
    weed_struct = { #center_origin:center_origin, #b_grown:0, #interact:interact, #var_d730daa4dbff6a82:var_d730daa4dbff6a82 };
    interact.var_c0c940b175bdf3ca = weed_struct;
    return weed_struct;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe1b7cb50, Offset: 0x15161
// Size: 0x14a
function function_e61d19fffad407f5( player )
{
    if ( !player.var_976664409e016652 || !player.var_ce3e987a55fb9239 )
    {
        return;
    }
    
    if ( self.var_c0c940b175bdf3ca.b_grown )
    {
        return;
    }
    
    if ( self.var_c0c940b175bdf3ca.is_destroyed )
    {
        return;
    }
    
    self.var_c0c940b175bdf3ca grow_weed( player );
    
    foreach ( weed_struct in level.hornet_mq.weed_structs )
    {
        if ( !weed_struct.b_grown )
        {
            player notify( #"hash_a1f7aa511e90d581", "grown" );
            return;
        }
    }
    
    level utility::flag_set( "mq_acc_g_all_w_gr" );
    player notify( #"hash_a1f7aa511e90d581", "grown" );
    wait 0.5;
    player thread function_2a6deff157d1165a( #"hash_f4c911d8673fdd24", undefined, 3 );
    level function_b2488a168322aad1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x814277c4, Offset: 0x152b3
// Size: 0xb2
function weed_hint_callback( usable, player )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() && player.var_ce3e987a55fb9239 && player.var_976664409e016652 && !usable.var_c0c940b175bdf3ca.b_grown )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3965b915f747f5c2", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc592bab8, Offset: 0x1536d
// Size: 0x10d
function grow_weed( growing_player = undefined )
{
    self.b_grown = 1;
    
    foreach ( model in self.var_d730daa4dbff6a82 )
    {
        delay = randomfloatrange( 0.1, 0.3 );
        model utility::delaycall( delay, &utility::function_7c10ea82c1e305b8, "anim", "grow" );
    }
    
    if ( growing_player )
    {
        nearby_players = getplayersinradius( growing_player.origin, 360 );
        level thread function_490cc449b7de9830( [ #"hash_9bb22f77d83f2027", #"hash_9bb23077d83f21da" ], nearby_players, 5.5, 1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdcc8dda9, Offset: 0x15482
// Size: 0x12b
function destroy_weed()
{
    self.b_grown = 0;
    self.is_destroyed = 1;
    
    foreach ( model in self.var_d730daa4dbff6a82 )
    {
        delay = randomfloatrange( 0.1, 0.3 );
        model utility::delaycall( delay, &utility::function_7c10ea82c1e305b8, "anim", "destroy" );
    }
    
    wait 0.5;
    
    foreach ( model in self.var_d730daa4dbff6a82 )
    {
        model freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0x2850bde5, Offset: 0x155b5
// Size: 0xd0
function function_f2eaffae45a30ee5( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_hornet_mq_acc_g_plant" )
    {
        return;
    }
    
    if ( !instance.root.var_f6115109f5cdd47c )
    {
        return;
    }
    
    var_6f88a6bfefadea5e = { #eattacker:eattacker, #idamage:idamage };
    instance.root notify( #"hash_2b93fe630eac2481", var_6f88a6bfefadea5e );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xec3becbc, Offset: 0x1568d
// Size: 0x1fa
function function_915f4cb9f8b26005()
{
    level endon( #"game_ended" );
    level endon( #"mq_acc_g_killed" );
    
    while ( true )
    {
        self.root.var_f6115109f5cdd47c = 1;
        level function_ecc91637c2a6fbb1();
        curr_round = zm_utility::get_round_number();
        self.health = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", curr_round ) );
        utility::function_7c10ea82c1e305b8( "visual", "open" );
        level function_33b21997c764990c();
        
        while ( true )
        {
            self.root waittill( #"hash_2b93fe630eac2481", var_6f88a6bfefadea5e );
            player_attacker = isplayer( var_6f88a6bfefadea5e.eattacker ) ? var_6f88a6bfefadea5e.eattacker : var_6f88a6bfefadea5e.eattacker.owner;
            
            if ( self.root.var_a67b77717f8f77d9.size > 0 )
            {
                continue;
            }
            
            self.health -= var_6f88a6bfefadea5e.idamage;
            
            if ( self.health <= 0 )
            {
                if ( isplayer( player_attacker ) )
                {
                    player_attacker damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
                }
                
                break;
            }
            
            if ( isplayer( player_attacker ) )
            {
                player_attacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
            }
        }
        
        self.root.var_f6115109f5cdd47c = 0;
        
        if ( isplayer( player_attacker ) && !level utility::flag( "hornet_mq_first_gardener_plant_shot" ) )
        {
            level utility::flag_set( "hornet_mq_first_gardener_plant_shot" );
            player_attacker thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
        }
        
        level function_ecc91637c2a6fbb1();
        utility::function_7c10ea82c1e305b8( "visual", "closed" );
        level function_33b21997c764990c();
        var_66bb3b1bb79c4a52 = randomfloatrange( 8, 14 );
        wait var_66bb3b1bb79c4a52;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x24f11471, Offset: 0x1588f
// Size: 0xf5
function function_33b21997c764990c()
{
    if ( !isalive( level.hornet_mq.gardener_zombie ) )
    {
        return;
    }
    
    var_7244160bcf272fdb = 1;
    
    foreach ( plant in level.hornet_mq.a_plants )
    {
        if ( plant.var_f6115109f5cdd47c )
        {
            var_7244160bcf272fdb = 0;
            break;
        }
    }
    
    state = var_7244160bcf272fdb ? "off" : "acc_g_pet";
    level.hornet_mq.gardener_zombie utility::function_7c10ea82c1e305b8( "hornet_mq_fx", state );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xefdeec95, Offset: 0x1598c
// Size: 0xc0
function function_6b245bb1a20ab024()
{
    level endon( #"game_ended" );
    
    foreach ( plant in level.hornet_mq.a_plants )
    {
        plant.mdl utility::function_7c10ea82c1e305b8( "visual", "closed" );
        plant.mdl utility::function_7c10ea82c1e305b8( "health", "idle" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe4366189, Offset: 0x15a54
// Size: 0xfc
function function_d7440fdd6864899d( params )
{
    var_b7b3f9fdfed71344 = 0;
    
    foreach ( plant in level.hornet_mq.a_plants )
    {
        if ( plant.var_f6115109f5cdd47c )
        {
            var_b7b3f9fdfed71344 += 1;
        }
    }
    
    if ( var_b7b3f9fdfed71344 > 1 && var_b7b3f9fdfed71344 <= 2 )
    {
        modified_damage = 0;
    }
    else if ( var_b7b3f9fdfed71344 > 0 && var_b7b3f9fdfed71344 <= 1 )
    {
        modified_damage = params.idamage / 2;
    }
    else
    {
        return params.idamage;
    }
    
    return modified_damage;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x93236449, Offset: 0x15b59
// Size: 0x85
function function_529a6447339d169b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    a_destroyed_weeds = [];
    
    while ( true )
    {
        if ( a_destroyed_weeds.size < level.hornet_mq.weed_structs.size )
        {
            current_weed = utility::function_879489791c3d805( level.hornet_mq.weed_structs, a_destroyed_weeds );
            function_5f126bdd63cf9633( current_weed );
            a_destroyed_weeds[ a_destroyed_weeds.size ] = current_weed;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5d3b09ad, Offset: 0x15be6
// Size: 0x115
function function_5f126bdd63cf9633( weed_struct )
{
    self notify( #"hash_da74d754da4232c7" );
    self endon( #"hash_da74d754da4232c7" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( self.goal_attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
    }
    
    weed_origin = weed_struct.center_origin;
    var_5f4d19ee2f1cae92 = { #origin:weed_origin };
    self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92, 3, undefined, 0 );
    
    while ( true )
    {
        if ( !weed_struct.b_grown )
        {
            break;
        }
        
        if ( distance2dsquared( self.origin, var_5f4d19ee2f1cae92.origin ) <= 900 )
        {
            wait 0.5;
            weed_struct thread destroy_weed();
            break;
        }
        
        wait 0.1;
    }
    
    if ( isdefined( self.goal_attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
    }
    
    level notify( #"hash_f95bed1ea4a9a949" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xd76e661f, Offset: 0x15d03
// Size: 0xdb
function function_faac2ba2b7b50897( spawner )
{
    params = {};
    params.round_override = 15;
    zombie = function_89266a24d0006d65( "sat_spawner_zombie_base_zm_hornet_mq_acc_n", spawner, params );
    zombie function_2ff429eb92e72314();
    zombie.var_a8fa61d92872fc74 = 1;
    zombie callback::add( "on_zombie_ai_killed", &function_edfd86b33e11a345, "n" );
    zombie zombie_utils::function_dfae6a5bd222c586( &function_58b3056cf6d6eb43 );
    
    if ( isdefined( zombie ) )
    {
        zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "mq_acc_n", 6 );
    }
    
    grenade_zone = getent( "mq_acc_n_gren_trig", #targetname );
    grenade_zone thread function_3f344c27560aed50();
    zombie thread function_2dda099af3fe23d5();
    level.hornet_mq.noble_zombie = zombie;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0x8bf6a709, Offset: 0x15de6
// Size: 0x1dd
function private function_673bc738bc57c8ed( s_grenade )
{
    if ( !level.hornet_mq.var_7261a69b7d3f75cf )
    {
        return;
    }
    
    if ( s_grenade.grenade.weapon_name != "sat_decoy_grenade_zm" )
    {
        return;
    }
    
    s_grenade.grenade endon( #"death", #"explode" );
    s_grenade.grenade waittill( #"missile_stuck" );
    
    foreach ( shutter in level.hornet_mq.var_7261a69b7d3f75cf )
    {
        if ( shutter function_d228e4c8ca4098a2( s_grenade.grenade ) )
        {
            shutter notify( #"hash_cefd657a6b20f6d" );
            shutter thread function_3cc848c23485ddac();
            shutter.has_decoy = 1;
            level thread function_70344b9928288e9f( shutter );
        }
    }
    
    level function_ecc91637c2a6fbb1();
    
    foreach ( shutter in level.hornet_mq.var_7261a69b7d3f75cf )
    {
        if ( !shutter.has_decoy )
        {
            return;
        }
    }
    
    thread function_2a6deff157d1165a( #"hash_45eca7c5bf3098ae", undefined, 0.5 );
    level thread function_97c525b5f90bd575();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5710d28e, Offset: 0x15fcb
// Size: 0x30, Type: bool
function function_d228e4c8ca4098a2( grenade )
{
    if ( ispointinvolume( grenade.origin, self ) )
    {
        /#
            iprintlnbold( "<dev string:xa8>" );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x86a104d2, Offset: 0x16004
// Size: 0x53
function function_3cc848c23485ddac()
{
    self notify( #"hash_13c9de1870495471" );
    self endon( #"hash_13c9de1870495471" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_cefd657a6b20f6d" );
    wait 15;
    self.has_decoy = 0;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe1ba64c8, Offset: 0x1605f
// Size: 0x7a
function function_70344b9928288e9f( shutter )
{
    if ( level.hornet_mq.var_c3761f5f79c6ffd8 )
    {
        return;
    }
    
    level.hornet_mq.var_c3761f5f79c6ffd8 = 1;
    wait 1.5;
    sound_loc = shutter.origin;
    playsoundatpos( sound_loc, "evt_mq_noble_grumble" );
    wait 30;
    level.hornet_mq.var_c3761f5f79c6ffd8 = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3b03b5a0, Offset: 0x160e1
// Size: 0x228
function function_97c525b5f90bd575()
{
    level endon( #"game_ended" );
    level utility::flag_set( "mq_acc_n_summoned" );
    var_3495db260d95d87b = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_3495db260d95d87b = utility::set_bit_flag( var_3495db260d95d87b, 0 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_3495db260d95d87b );
    
    if ( level.hornet_mq.shutter_open )
    {
        return;
    }
    
    level.hornet_mq.shutter_open = 1;
    
    if ( level callback::exists( #"grenade_fire", &function_673bc738bc57c8ed ) )
    {
        level callback::remove( #"grenade_fire", &function_673bc738bc57c8ed );
    }
    
    level function_ecc91637c2a6fbb1();
    level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"hornet_mq_guidance", #"acc_n_defeat" );
    sound_loc = getent( "n_shutt_2", #targetname );
    playsoundatpos( sound_loc.origin, "evt_mq_noble_commotion" );
    playsoundatpos( sound_loc.origin, "evt_mq_noble_grumble" );
    wait 0.5;
    
    for ( i = 3; i > 0 ; i-- )
    {
        shutter = getent( "n_shutt_" + string( i ), #targetname );
        dest = shutter.origin - ( 0, 80, 0 );
        playsoundatpos( shutter.origin, "evt_mq_noble_window_open" );
        shutter moveto( dest, 0.5, 0.2 );
        wait 0.3;
        shutter utility::delaycall( 1, &delete );
    }
    
    level zm_music::start_zone_music_watcher( "mq_noble_music", [ "zone_broken_turrets_a", "zone_broken_turrets_b", "zone_broken_turrets_c" ], #"mq_noble" );
    spawn_struct = utility::getstruct( "mq_acc_spawn_loc_n", "targetname" );
    level thread function_faac2ba2b7b50897( spawn_struct );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd4da585a, Offset: 0x16311
// Size: 0x21f
function function_2dda099af3fe23d5()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_d95b1c73d0080fec = utility::getstructarray( "mq_acc_n_run_loc", "targetname" );
    var_d95b1c73d0080fec = utility::array_sort_by_script_index( var_d95b1c73d0080fec );
    var_cf2c0bca8d1791f9 = 1;
    projectile_weapon = "sat_frag_hornet_spirit_grenade_zm";
    grenade_target_default = utility::getstruct( "mq_acc_n_gren_target_def", "targetname" );
    var_efdaaa1a8ec49be7 = 0;
    step = 0.1;
    
    while ( true )
    {
        if ( isdefined( self.goal_attractor ) )
        {
            if ( distance2dsquared( self.origin, var_d95b1c73d0080fec[ var_cf2c0bca8d1791f9 ].origin ) <= 900 )
            {
                zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
                self.goal_attractor = undefined;
            }
            
            if ( var_efdaaa1a8ec49be7 <= 0 )
            {
                grenades_thrown = 0;
                
                while ( level utility::flag( "mq_acc_n_gren_zone_occupied" ) )
                {
                    if ( grenades_thrown >= 3 )
                    {
                        var_efdaaa1a8ec49be7 = 5;
                        break;
                    }
                    
                    if ( utility::percent_chance( 75 ) )
                    {
                        [ var_a2a95f1dd066f5f ] = function_628bac9faa9d1e86( var_d95b1c73d0080fec, self.origin );
                        thread noble_throw_grenade( var_a2a95f1dd066f5f, projectile_weapon, grenade_target_default );
                        grenades_thrown += 1;
                    }
                    else
                    {
                        break;
                    }
                    
                    wait 1.5;
                }
            }
        }
        
        if ( !isdefined( self.goal_attractor ) )
        {
            random_loc = utility::function_879489791c3d805( var_d95b1c73d0080fec, [ var_d95b1c73d0080fec[ var_cf2c0bca8d1791f9 ] ] );
            var_5f4d19ee2f1cae92 = { #index:random_loc.script_int, #target:random_loc.target, #origin:random_loc.origin };
            self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92 );
            var_cf2c0bca8d1791f9 = self.goal_attractor.source.index;
            self.var_cf2c0bca8d1791f9 = var_cf2c0bca8d1791f9;
        }
        
        wait step;
        var_efdaaa1a8ec49be7 -= step;
        var_efdaaa1a8ec49be7 = max( 0, var_efdaaa1a8ec49be7 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xd43521e4, Offset: 0x16538
// Size: 0x103
function function_58b3056cf6d6eb43( params )
{
    if ( isplayer( params.eattacker ) && params.objweapon.basename == "sat_frag_hornet_spirit_grenade_zm" && params.einflictor && isplayer( params.einflictor.owner ) )
    {
        damage = self.maxhealth * 0.34;
        
        if ( level.directed_mode )
        {
            progress = max( self.health - damage, 0 ) / self.maxhealth * 100;
            level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"acc_n_defeat" );
        }
        
        params.eattacker thread function_2a6deff157d1165a( #"hash_2392eb618be5f142", #"bc_flavor_player_positive", 0.33 );
        return damage;
    }
    
    return 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x52d42e55, Offset: 0x16644
// Size: 0x105
function noble_throw_grenade( source_struct, projectile_weapon, grenade_target_default )
{
    if ( !level utility::flag( "mq_acc_n_gren_zone_occupied" ) )
    {
        return;
    }
    
    grenade_start = utility::array_random( utility::getstructarray( source_struct.target, "targetname" ) );
    target = grenade_target_default.origin + ( randomfloatrange( -200, 200 ), randomfloatrange( -200, 200 ), 0 );
    v_grenade = target - grenade_start.origin;
    self playsound( #"evt_mq_noble_grumble" );
    projectile = namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( projectile_weapon, grenade_start.origin, v_grenade, undefined, 0 );
    
    if ( isdefined( projectile ) )
    {
        projectile setentityowner( self );
        projectile.weapon_name = projectile_weapon;
        projectile.owner = self;
        projectile.team = self.team;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x57baddea, Offset: 0x16751
// Size: 0xfd
function function_3f344c27560aed50()
{
    level endon( #"game_ended" );
    level endon( #"mq_acc_n_killed" );
    
    while ( true )
    {
        b_occupied = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                b_occupied = 1;
                break;
            }
        }
        
        if ( b_occupied && !level utility::flag( "mq_acc_n_gren_zone_occupied" ) )
        {
            level utility::flag_set( "mq_acc_n_gren_zone_occupied" );
        }
        else if ( !b_occupied && level utility::flag( "mq_acc_n_gren_zone_occupied" ) )
        {
            level utility::flag_clear( "mq_acc_n_gren_zone_occupied" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x37424ee9, Offset: 0x16856
// Size: 0x2d9
function function_c1f40464f7f0b260( itembundle, note_ref, start_index )
{
    level endon( #"game_ended" );
    destination_struct = utility::getstruct( "mq_acc_n_gren_target_def", "targetname" );
    var_d95b1c73d0080fec = utility::getstructarray( "mq_acc_n_run_loc", "targetname" );
    var_d95b1c73d0080fec = utility::array_sort_by_script_index( var_d95b1c73d0080fec );
    
    if ( isdefined( var_d95b1c73d0080fec ) && isdefined( start_index ) && var_d95b1c73d0080fec.size > 0 )
    {
        var_de36f83051d17edc = utility::getstructarray( var_d95b1c73d0080fec[ start_index ].target, "targetname" );
        var_93c3e7bb3f019adf = utility::array_random( var_de36f83051d17edc );
    }
    else
    {
        var_93c3e7bb3f019adf = destination_struct;
        b_skipmove = 1;
    }
    
    itemmover = utility::spawn_model( "tag_origin", var_93c3e7bb3f019adf.origin, var_93c3e7bb3f019adf.angles );
    pagemover = utility::spawn_model( "tag_origin", var_93c3e7bb3f019adf.origin, var_93c3e7bb3f019adf.angles );
    item = level mq_spawn_item( itembundle, var_93c3e7bb3f019adf.origin );
    page = level spawn_page( note_ref, undefined, var_93c3e7bb3f019adf.origin, ( 0, 0, 0 ), 1 );
    waitframe();
    item utility::scriptable_setparententity( itemmover );
    page utility::scriptable_setparententity( pagemover );
    page utility::function_7c10ea82c1e305b8( "model", "outlined" );
    var_26156990a527ca5 = [ pagemover, itemmover ];
    var_373b002c9b398dcc = [ "nte", "ev" ];
    
    if ( !b_skipmove )
    {
        for ( i = 0; i < var_26156990a527ca5.size ; i++ )
        {
            target_loc = utility::getstruct( "acc_m_ev_dest_" + var_373b002c9b398dcc[ i ], "targetname" );
            var_c23a8cb334b43f16 = target_loc.origin + ( 0, 0, 1 );
            midpoint = ( var_93c3e7bb3f019adf.origin + var_c23a8cb334b43f16 ) / 2;
            midpoint = ( midpoint[ 0 ], midpoint[ 1 ], var_93c3e7bb3f019adf.origin[ 2 ] );
            var_26156990a527ca5[ i ].angles = target_loc.angles;
            var_26156990a527ca5[ i ] thread utility::function_8001268940441423( var_93c3e7bb3f019adf.origin, var_c23a8cb334b43f16, midpoint, 1.5 );
            wait 0.5;
        }
    }
    
    itemmover waittill( #"off_bezier_curve" );
    level.hornet_mq.var_da95bf2359181d00 = item;
    level.hornet_mq.var_7170dedf1eee0ac2 = page;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x63640beb, Offset: 0x16b37
// Size: 0x5a
function function_ede8bc238620d26()
{
    level endon( #"game_ended" );
    level endon( #"mq_acc_m_killed" );
    first_spawn_delay = getdvarint( @"zombie_cheat", 0 ) ? 5 : 25;
    wait first_spawn_delay;
    
    while ( true )
    {
        level function_804a7a568e5ea8c6();
        wait randomfloatrange( 25, 45 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xff5d4ab1, Offset: 0x16b99
// Size: 0xe5
function function_804a7a568e5ea8c6()
{
    level endon( #"game_ended" );
    level endon( #"mq_acc_m_spawned" );
    
    if ( isalive( level.hornet_mq.merchant_zombie ) )
    {
        return;
    }
    
    closet_loc = utility::getstruct( "mq_acc_m_return_loc", "targetname" );
    near_players = getplayersinradius( closet_loc.origin, 500 );
    
    foreach ( player in near_players )
    {
        player playsoundtoplayer( "evt_mq_merchant_grumble", player );
    }
    
    wait 15;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xee36e2b9, Offset: 0x16c86
// Size: 0x1a8
function function_abb9d7c076fba681( spawner )
{
    level endon( #"game_ended" );
    level function_ecc91637c2a6fbb1();
    var_3495db260d95d87b = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_3495db260d95d87b = utility::set_bit_flag( var_3495db260d95d87b, 1 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_3495db260d95d87b );
    var_58f7dfca951b2094 = 0;
    earthquake( 0.2, 1.2, spawner.origin, 700 );
    playrumbleonposition( "low_highfreq", spawner.origin );
    level.hornet_mq.var_a6b1c96cab3bf858 = getplayersinradius( spawner.origin, 2000 );
    level musicbank_utility::function_5aca66c390aa347d( level.hornet_mq.var_a6b1c96cab3bf858, #"mq_merchant" );
    level.hornet_mq.var_e46d3e7a2913bad0 = [];
    var_58f4b2110540aa60 = utility::getstructarray( "mq_acc_m_fd_loc", "targetname" );
    var_58f4b2110540aa60 = arrayrandomize( var_58f4b2110540aa60 );
    var_bce1341751114bbc = level.players.size > 1 ? 5 : 7;
    
    for ( i = 0; i < var_bce1341751114bbc ; i++ )
    {
        if ( i >= var_bce1341751114bbc / 2 && !var_58f7dfca951b2094 )
        {
            var_58f7dfca951b2094 = 1;
            level thread function_3a6b41581f7b2eaf( spawner );
        }
        
        level thread spawn_food( spawner.origin, var_58f4b2110540aa60[ i ].origin );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x454311e9, Offset: 0x16e36
// Size: 0x128
function function_3a6b41581f7b2eaf( spawner )
{
    params = {};
    params.round_override = 20;
    zombie = function_89266a24d0006d65( "sat_spawner_zombie_base_zm_hornet_mq_acc_m", spawner, params );
    zombie function_2ff429eb92e72314();
    zombie thread function_28551b187f03befc();
    playsoundatpos( zombie.origin, "evt_mq_merchant_commotion" );
    playsoundatpos( zombie.origin, "evt_mq_merchant_grumble" );
    zombie val::set( "hornet_mq_acc_val", "damage", 0 );
    zombie.var_190f8e8daa83f8c = 1;
    zombie zone_spawner::function_ce10e453e7f7bb8e( zombie );
    zombie callback::add( "on_zombie_ai_killed", &function_edfd86b33e11a345, "m" );
    
    if ( isdefined( zombie ) )
    {
        zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "mq_acc_m", 6 );
    }
    
    zombie val::reset( "hornet_mq_acc_val", "damage" );
    level notify( #"mq_acc_m_spawned" );
    wait 1.5;
    zombie thread function_ac096443b4d371d6();
    level.hornet_mq.merchant_zombie = zombie;
    level function_ecc91637c2a6fbb1();
    return zombie;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x5de141f5, Offset: 0x16f67
// Size: 0xe8
function function_28551b187f03befc()
{
    self endon( #"death" );
    utility::ent_flag_set( "acc_m_in_spawn_closet" );
    corner_a = ( -577.75, -22241.3, 118.75 );
    corner_b = ( -262.75, -22242.8, 148.75 );
    corner_c = ( -266, -22028.6, 167.5 );
    corner_d = ( -576.25, -22028.6, 129 );
    
    while ( isalive( self ) )
    {
        var_8f8778769affde5d = utility::function_3fa3de7c5aef7907( self.origin, corner_a, corner_b, corner_c, corner_d );
        
        if ( var_8f8778769affde5d && !utility::ent_flag( "acc_m_in_spawn_closet" ) )
        {
            utility::ent_flag_set( "acc_m_in_spawn_closet" );
        }
        else if ( !var_8f8778769affde5d && utility::ent_flag( "acc_m_in_spawn_closet" ) )
        {
            utility::ent_flag_clear( "acc_m_in_spawn_closet" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd185a812, Offset: 0x17057
// Size: 0x618
function function_ac096443b4d371d6()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( utility::ent_flag( "acc_m_in_spawn_closet" ) || ai::is_doing_traversal( self ) )
        {
            wait 0.1;
            continue;
        }
        
        break;
    }
    
    self.target_food = level.hornet_mq.dropped_fruit;
    var_5f4d19ee2f1cae92 = { #origin:self.target_food.origin };
    
    if ( self.target_food.origin )
    {
        self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92, 3, undefined, 0 );
    }
    
    old_pos = self.origin;
    
    while ( true )
    {
        level.hornet_mq.var_e46d3e7a2913bad0 = function_5713d46873b29625( level.hornet_mq.var_e46d3e7a2913bad0 );
        
        if ( level.hornet_mq.var_e46d3e7a2913bad0.size <= 0 )
        {
            if ( self.goal_attractor )
            {
                zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
            }
            
            self enabletraversals( 1, "zombie", "custom" );
            spawn_struct = utility::getstruct( "mq_acc_m_return_loc", "targetname" );
            var_5f4d19ee2f1cae92 = { #origin:spawn_struct.origin };
            self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92, 3, undefined, 0 );
            
            while ( distance2dsquared( self.origin, var_5f4d19ee2f1cae92.origin ) >= 900 )
            {
                wait 0.1;
            }
            
            break;
        }
        
        if ( self.origin == old_pos )
        {
            thread function_cb86d33dc9f14a72( old_pos );
        }
        
        if ( !isdefined( self.target_food ) )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
            self.target_food = utility::array_random( level.hornet_mq.var_e46d3e7a2913bad0 );
            var_5f4d19ee2f1cae92 = { #origin:self.target_food.origin };
            self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92, 3, undefined, 0 );
        }
        
        if ( distance2dsquared( self.origin, self.target_food.origin ) <= 1600 )
        {
            if ( self.target_food.model == "sat_zm_fruit_peach" )
            {
                mdl = %"sat_zm_fruit_peach";
            }
            else
            {
                mdl = %"sat_zm_fruit_kaki";
            }
            
            self.mdl_fruit = utility::spawn_model( mdl, self.target_food.origin, self.target_food.angles );
            self.target_food freescriptable();
            dir_to_zombie = vectornormalize( self.origin - self.mdl_fruit.origin );
            self.pickup_angle = vectortoangles( dir_to_zombie )[ 1 ];
            pickup_offset_x = getdvarfloat( @"hash_fedf4be59f2995e7", 39 );
            pickup_offset_y = getdvarfloat( @"hash_fedf4ae59f2993b4", 6.5 );
            v_angles = ( 0, self.pickup_angle, 0 );
            target_pos = self.mdl_fruit.origin + anglestoforward( v_angles ) * pickup_offset_x + anglestoright( v_angles ) * pickup_offset_y;
            self setorigin( target_pos );
            scene_root = spawnstruct();
            scene_root.origin = self.origin;
            scene_root.angles = ( 0, self.pickup_angle + 180, 0 );
            scene_root thread scene::play( self, "shot_2", "sat_cin_zm_vig_hornet_mq_food_merchant_eat" );
            wait 1.95;
            fruit_tag = "j_wrist_ri";
            hand_pos = self gettagorigin( fruit_tag );
            hand_angles = self gettagangles( fruit_tag );
            offset_x = getdvarfloat( @"hash_b4e2cf37f4f7d38e", 4 );
            offset_y = getdvarfloat( @"hash_b4e2d037f4f7d5c1", 0 );
            offset_z = getdvarfloat( @"hash_b4e2cd37f4f7cf28", 0.2 );
            hand_offset = ( offset_x, offset_y, offset_z );
            self.mdl_fruit moveto( hand_pos, 0.1 );
            self.mdl_fruit rotateto( hand_angles, 0.1 );
            self.mdl_fruit waittill( #"movedone" );
            self.mdl_fruit linkto( self, fruit_tag, hand_offset, ( 0, 0, 0 ) );
            wait 1.3;
            var_abd0e9e671ff084a = self.maxhealth * 0.35;
            self.health = int( clamp( self.health + var_abd0e9e671ff084a, 0, self.maxhealth ) );
            utility::function_7c10ea82c1e305b8( "hornet_mq_fx", "acc_m_eat" );
            
            if ( self.mdl_fruit )
            {
                self.mdl_fruit delete();
            }
            
            continue;
        }
        
        old_pos = self.origin;
        waitframe();
    }
    
    if ( !level utility::flag( "hornet_mq_merchant_failed_first_time" ) )
    {
        search_center = utility::getstruct( "mq_acc_m_return_loc", "targetname" );
        nearby_players = getplayersinradius( search_center.origin, 250 );
        selected_player = utility::array_random( nearby_players );
        
        if ( isdefined( selected_player ) )
        {
            level utility::flag_set( "hornet_mq_merchant_failed_first_time" );
            selected_player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_negative", 0.5 );
        }
    }
    
    utility::function_7c10ea82c1e305b8( "fog", "despawn" );
    wait 0.6;
    self.nocorpse = 1;
    self kill();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xa05f16ec, Offset: 0x17677
// Size: 0xbe
function function_cb86d33dc9f14a72( var_88b24477df8bad44 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.var_318e1354ba2bb13c == var_88b24477df8bad44 )
    {
        return;
    }
    
    self.var_318e1354ba2bb13c = var_88b24477df8bad44;
    var_98edcad5b8301f0b = 0.75;
    time_elapsed = 0;
    step = var_98edcad5b8301f0b / 10;
    
    while ( self.origin == var_88b24477df8bad44 )
    {
        if ( time_elapsed >= var_98edcad5b8301f0b )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
            wait 1;
            self.target_food = undefined;
            self.var_318e1354ba2bb13c = undefined;
            return;
        }
        
        wait step;
        time_elapsed += step;
    }
    
    self.var_318e1354ba2bb13c = undefined;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x5780ca6b, Offset: 0x1773d
// Size: 0x17d
function spawn_food( var_93c3e7bb3f019adf, destination_loc )
{
    level endon( #"game_ended" );
    food = spawnscriptable( %"zm_sat_hornet_mq_acc_m_food", var_93c3e7bb3f019adf, ( 0, 0, 0 ) );
    linker = utility::spawn_model( "tag_origin", var_93c3e7bb3f019adf, ( 0, 0, 0 ) );
    waitframe();
    food utility::scriptable_setparententity( linker );
    food utility::function_7c10ea82c1e305b8( "model", utility::array_random( [ "p", "a" ] ) );
    midpoint = ( var_93c3e7bb3f019adf + destination_loc ) / 2;
    offset_z = ( 0, 0, randomintrange( 75, 200 ) );
    control_loc = midpoint + offset_z;
    time = randomfloatrange( 1, 1.33 );
    linker utility::function_8001268940441423( var_93c3e7bb3f019adf, destination_loc, control_loc, time );
    
    if ( isdefined( food ) && isdefined( linker ) )
    {
        food utility::scriptable_clearparententity();
    }
    
    if ( isdefined( linker ) )
    {
        linker delete();
    }
    
    if ( isdefined( food ) )
    {
        level.hornet_mq.var_e46d3e7a2913bad0[ level.hornet_mq.var_e46d3e7a2913bad0.size ] = food;
        food utility::function_7c10ea82c1e305b8( "land_sfx", "on" );
        food interaction::set_interact_hint_callback( &function_2d989bddbb196d1 );
        food utility::function_7c10ea82c1e305b8( "usable", "enabled" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x26f294e6, Offset: 0x178c2
// Size: 0x11f
function function_2d989bddbb196d1( usable, player )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( isdefined( usable.model ) )
        {
            if ( usable.model == "sat_zm_fruit_plum" )
            {
                title = &"hash_428edfa1e0f5e88";
            }
            else if ( usable.model == "sat_zm_fruit_kaki" )
            {
                title = &"hash_428e1fa1e0f4a24";
            }
            else
            {
                title = &"hash_428f2fa1e0f6707";
            }
        }
        else
        {
            title = &"hash_162c176a7954082c";
        }
        
        return { #rarity:2, #icon:"sat_ui_icon_zm_augment_minor_health_increase", #var_26bbd300351fde34:1, #description:&"hash_162c176a7954082c", #title:title, #string:undefined, #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x58ef2501, Offset: 0x179e9
// Size: 0x128
function function_389ce5fca9aeb74b( instance, part, state, player, bautouse, usestring )
{
    if ( instance utility::function_9f2c41c1dcc8c94( "model", "p" ) )
    {
        regen_amt = 18;
    }
    else if ( instance utility::function_9f2c41c1dcc8c94( "model", "a" ) )
    {
        regen_amt = 13;
        level utility::flag_clear( "mq_acc_m_f_a_pickup_active" );
        level function_ecc91637c2a6fbb1();
    }
    else if ( instance utility::function_9f2c41c1dcc8c94( "model", "u" ) )
    {
        regen_amt = 7;
    }
    else
    {
        regen_amt = 7;
    }
    
    player playsoundtoplayer( "evt_mq_player_eat_food", player );
    utility::callsharedfunc( #"health", #"hash_291dc25cfb86af01", player, #"toxic_growth_plant_food", regen_amt );
    
    if ( instance utility::function_9f2c41c1dcc8c94( "model", "u" ) )
    {
        player thread function_2a6deff157d1165a( #"hash_2e85c2fba142b88a", #"bc_flavor_player_positive" );
    }
    
    instance notify( #"mq_acc_m_fd_consumed" );
    instance freescriptable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x32343f3, Offset: 0x17b19
// Size: 0x403
function function_edfd86b33e11a345( params, accomplice_ref )
{
    origin = self.origin + ( 0, 0, 16 );
    
    switch ( accomplice_ref )
    {
        case #"hash_31103dbc01bd80e6":
            itembundle = %"hash_8e37751e6198196";
            note_ref = "zm_hornet_mq_acc" + "_g";
            level notify( #"mq_acc_g_killed" );
            level utility::flag_set( "mq_acc_g_killed" );
            level thread function_6b245bb1a20ab024();
            level zm_music::function_e9fd14ede793ef0d( "mq_gardener_music" );
            var_5ae3f3c491a78ed8 = 0;
            
            foreach ( t_lava in level.a_t_lava )
            {
                if ( ispointinvolume( origin - ( 0, 0, 16 ), t_lava ) )
                {
                    var_5ae3f3c491a78ed8 = 1;
                    break;
                }
            }
            
            if ( var_5ae3f3c491a78ed8 )
            {
                var_43384144f7756681 = utility::getstructarray( "acc_g_ev_safe_loc", "targetname" );
                loc = function_b21056d585c710d( var_43384144f7756681, origin );
                origin = loc.origin + ( 0, 0, 16 );
            }
            
            break;
        case #"hash_311043bc01bd8a58":
            if ( self.mdl_fruit )
            {
                self.mdl_fruit delete();
            }
            
            level.hornet_mq.var_a6b1c96cab3bf858 = function_5713d46873b29625( level.hornet_mq.var_a6b1c96cab3bf858 );
            level musicbank_utility::function_4f253fd35ec68cbc( level.hornet_mq.var_a6b1c96cab3bf858, #"mq_merchant" );
            
            if ( isdefined( params.eattacker ) && params.eattacker.classname == "worldspawn" )
            {
                level utility::flag_clear( "mq_acc_m_summoned" );
                level utility::flag_clear( "mq_acc_m_fr_drop_success" );
                level.hornet_mq.merchant_zombie = undefined;
                level function_ecc91637c2a6fbb1();
                return;
            }
            
            if ( utility::ent_flag( "acc_m_in_spawn_closet" ) )
            {
                safe_pos = utility::getstruct( "acc_m_fallback_ev_fall_loc", "targetname" );
                origin = safe_pos.origin;
            }
            
            itembundle = %"hash_1c8db823d9932e7";
            note_ref = "zm_hornet_mq_acc" + "_m";
            level notify( #"mq_acc_m_killed" );
            level utility::flag_set( "mq_acc_m_killed" );
            break;
        case #"hash_311046bc01bd8f11":
            itembundle = %"hash_306517a56af8abad";
            note_ref = "zm_hornet_mq_acc" + "_n";
            level notify( #"mq_acc_n_killed" );
            level utility::flag_set( "mq_acc_n_killed" );
            level thread function_c1f40464f7f0b260( itembundle, note_ref, self.var_cf2c0bca8d1791f9 );
            level zm_music::function_e9fd14ede793ef0d( "mq_noble_music" );
            return;
    }
    
    item = level mq_drop_item( itembundle, origin );
    page = level spawn_page( note_ref, undefined, origin, ( 0, 0, 0 ), 1 );
    
    if ( level.directed_mode )
    {
        if ( accomplice_ref == "m" )
        {
            level.hornet_mq.var_db3547b19ab47ec = item;
            level.hornet_mq.var_785464c716d43c5e = page;
        }
        else if ( accomplice_ref == "g" )
        {
            level.hornet_mq.var_4064357a5936b62a = item;
            level.hornet_mq.var_3ee868880e6db754 = page;
        }
    }
    
    page utility::function_7c10ea82c1e305b8( "model", "outlined" );
    level utility::delaycall( 1, &function_ecc91637c2a6fbb1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x71f0db87, Offset: 0x17f24
// Size: 0x5c2
function setup_scroll_puzzle()
{
    level utility::flag_wait( "scriptables_ready" );
    var_c15b2920a773fae2 = utility::getstructarray( "mq_puzzle_scrl", "targetname" );
    scrolls = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        scrolls[ i ] = [];
        
        for ( j = 0; j < 3 ; j++ )
        {
            foreach ( struct in var_c15b2920a773fae2 )
            {
                if ( struct.script_note_x == i && struct.script_note_y == j )
                {
                    if ( struct.script_noteworthy == "records" )
                    {
                        struct.sbl = spawnscriptable( %"zm_sat_hornet_mq_puzzle_scroll", struct.origin, struct.angles );
                        struct.sbl utility::function_7c10ea82c1e305b8( "visual", "scroll" );
                    }
                    else if ( struct.script_noteworthy == "sml" )
                    {
                        struct.sbl = spawnscriptable( %"zm_sat_hornet_mq_puzzle_scroll", struct.origin, struct.angles, undefined, function_67b78af3c33ac9a8( 0.5 ) );
                    }
                    else if ( struct.script_noteworthy == "med" )
                    {
                        struct.sbl = spawnscriptable( %"zm_sat_hornet_mq_puzzle_scroll", struct.origin, struct.angles, undefined, function_67b78af3c33ac9a8( 0.6 ) );
                    }
                    else
                    {
                        struct.sbl = spawnscriptable( %"zm_sat_hornet_mq_puzzle_scroll", struct.origin, struct.angles, undefined, function_67b78af3c33ac9a8( 0.75 ) );
                    }
                    
                    struct.mover = utility::spawn_model( "tag_origin", struct.origin, struct.angles );
                    waitframe();
                    struct.sbl utility::scriptable_setparententity( struct.mover );
                    
                    if ( i == 0 )
                    {
                        height_adjust = 0.45;
                    }
                    else if ( i == 1 )
                    {
                        height_adjust = 0.5;
                    }
                    else
                    {
                        height_adjust = 0.3;
                    }
                    
                    if ( j == 0 )
                    {
                        out_pos = ( -862.75, -18125.5, 0 );
                    }
                    else if ( j == 1 )
                    {
                        out_pos = ( -868.75, -18126.5, 0 );
                    }
                    else
                    {
                        out_pos = ( -874.5, -18127.5, 0 );
                    }
                    
                    struct.in_pos = struct.origin + ( 0, 0, height_adjust );
                    struct.out_pos = ( out_pos[ 0 ], out_pos[ 1 ], struct.origin[ 2 ] + height_adjust );
                    
                    if ( i == 1 && j == 1 )
                    {
                        fwd_offset = vectornormalize( anglestoright( struct.angles ) ) * 3.7 * -1;
                        z_offset = ( 0, 0, height_adjust );
                        struct.out_pos = struct.origin + fwd_offset + z_offset;
                    }
                    
                    struct.var_16bb68f3614c1919 = 1;
                    struct.sbl.root = struct;
                    struct.row = struct.script_note_x;
                    struct.column = struct.script_note_y;
                    struct.var_2f40ad3537606e57 = utility::getstruct( struct.target, "targetname" );
                    struct.var_6f5250a0b1fb07d6 = utility::getstruct( struct.target2, "targetname" );
                    scrolls[ i ][ j ] = struct;
                }
            }
        }
    }
    
    level.hornet_mq.scrolls = scrolls;
    level.hornet_mq.records = level.hornet_mq.scrolls[ 1 ][ 1 ].sbl;
    level.hornet_mq.scrolls[ 1 ][ 1 ].sbl.var_8d286506276efa4a = 1;
    spawn_loc = utility::getstruct( "backup_col_loc", "targetname" );
    level.hornet_mq.var_50662f65e2693f7f = spawnscriptable( "zm_sat_hornet_mq_scroll_collision_backup", spawn_loc.origin, spawn_loc.angles );
    waitframe();
    
    for ( i = 0; i < 3 ; i++ )
    {
        for ( j = 0; j < 3 ; j++ )
        {
            if ( i == 0 )
            {
                height_adjust = 0.45;
            }
            else if ( i == 1 )
            {
                height_adjust = 0.5;
            }
            else
            {
                height_adjust = 0.3;
            }
            
            level.hornet_mq.scrolls[ i ][ j ].mover.origin += ( 0, 0, height_adjust );
        }
    }
    
    level utility::flag_set( "mq_scr_puz_setup" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xf368719d, Offset: 0x184ee
// Size: 0x37
function function_3224898b28533f45( bound_point, struct )
{
    return rotatepointaroundvector( anglestoup( struct.angles ), bound_point, struct.angles[ 0 ] );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x767a3fee, Offset: 0x1852e
// Size: 0x3b8
function function_d890706f97462680()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mq_scr_puz_setup" );
    
    if ( level.directed_mode )
    {
        level utility::flag_wait( "mq_directed_revealed_screen_acc" );
    }
    
    level function_ecc91637c2a6fbb1();
    a_configs = [ [ [ 0, 0, 0 ], [ 1, 1, 0 ], [ 0, 0, 0 ] ], [ [ 0, 0, 0 ], [ 0, 1, 1 ], [ 0, 1, 0 ] ], [ [ 1, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 0 ] ], [ [ 1, 0, 1 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], [ [ 1, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], [ [ 1, 0, 1 ], [ 1, 1, 0 ], [ 0, 0, 0 ] ], [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 0, 0, 0 ] ], [ [ 0, 1, 0 ], [ 0, 1, 1 ], [ 0, 1, 0 ] ], [ [ 0, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 0 ] ] ];
    config = utility::array_random( a_configs );
    
    for ( i = 0; i < 3 ; i++ )
    {
        for ( j = 0; j < 3 ; j++ )
        {
            level.hornet_mq.scrolls[ i ][ j ].var_16bb68f3614c1919 = config[ i ][ j ] ? 0 : 1;
            level.hornet_mq.scrolls[ i ][ j ].sbl toggle_scroll();
            level.hornet_mq.scrolls[ i ][ j ].sbl utility::function_7c10ea82c1e305b8( "health", "damageable" );
        }
    }
    
    level scriptable::scriptable_adddamagedcallback( &function_5f8cda7768b77c6a );
    level.hornet_mq.var_50662f65e2693f7f utility::function_7c10ea82c1e305b8( "health", "damageable" );
    level scriptable::scriptable_adddamagedcallback( &function_51536c5eec552f47 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0xc6f58f55, Offset: 0x188ee
// Size: 0x300
function function_51536c5eec552f47( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    waitframe();
    
    if ( level.hornet_mq.scrolls_locked )
    {
        return;
    }
    
    level.hornet_mq.scrolls_locked = 1;
    
    if ( !level utility::flag( "hornet_mq_scroll_shot_first_time" ) )
    {
        level utility::flag_set( "hornet_mq_scroll_shot_first_time" );
        
        for ( i = 0; i < 3 ; i++ )
        {
            for ( j = 0; j < 3 ; j++ )
            {
                if ( level.hornet_mq.scrolls[ i ][ j ].var_16bb68f3614c1919 && level.hornet_mq.scrolls[ i ][ j ].sbl.var_8d286506276efa4a )
                {
                    level.hornet_mq.scrolls[ i ][ j ].sbl utility::function_7c10ea82c1e305b8( "fx", "in" );
                    continue;
                }
                
                level.hornet_mq.scrolls[ i ][ j ].sbl utility::function_7c10ea82c1e305b8( "fx", "out" );
            }
        }
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        for ( j = 0; j < 3 ; j++ )
        {
            currscroll = level.hornet_mq.scrolls[ i ][ j ];
            
            if ( vpoint[ 0 ] <= currscroll.var_2f40ad3537606e57.origin[ 0 ] && vpoint[ 0 ] >= currscroll.var_6f5250a0b1fb07d6.origin[ 0 ] )
            {
                if ( vpoint[ 2 ] >= currscroll.var_2f40ad3537606e57.origin[ 2 ] && vpoint[ 2 ] <= currscroll.var_6f5250a0b1fb07d6.origin[ 2 ] )
                {
                    closestscroll = currscroll;
                    
                    /#
                        debugstar( currscroll.var_2f40ad3537606e57.origin, ( 1, 0, 0 ), 100 );
                    #/
                    
                    /#
                        debugstar( currscroll.var_6f5250a0b1fb07d6.origin, ( 0, 0, 1 ), 100 );
                    #/
                }
            }
        }
    }
    
    if ( !closestscroll )
    {
        level.hornet_mq.scrolls_locked = 0;
        return;
    }
    
    closestscroll thread shoot_scroll();
    
    if ( isplayer( eattacker ) )
    {
        eattacker thread function_622561610fb2a062();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0xda484df8, Offset: 0x18bf6
// Size: 0x1fb
function function_5f8cda7768b77c6a( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) || instance.type != "zm_sat_hornet_mq_puzzle_scroll" )
    {
        return;
    }
    
    if ( level.hornet_mq.scrolls_locked )
    {
        return;
    }
    
    level.hornet_mq.scrolls_locked = 1;
    
    if ( !level utility::flag( "hornet_mq_scroll_shot_first_time" ) )
    {
        level utility::flag_set( "hornet_mq_scroll_shot_first_time" );
        
        for ( i = 0; i < 3 ; i++ )
        {
            for ( j = 0; j < 3 ; j++ )
            {
                if ( level.hornet_mq.scrolls[ i ][ j ].var_16bb68f3614c1919 && level.hornet_mq.scrolls[ i ][ j ].sbl.var_8d286506276efa4a )
                {
                    level.hornet_mq.scrolls[ i ][ j ].sbl utility::function_7c10ea82c1e305b8( "fx", "in" );
                    continue;
                }
                
                level.hornet_mq.scrolls[ i ][ j ].sbl utility::function_7c10ea82c1e305b8( "fx", "out" );
            }
        }
        
        eattacker thread function_2a6deff157d1165a( undefined, #"hash_5212ed7ec42f115a", 0.5 );
    }
    
    instance.root thread shoot_scroll();
    
    if ( isplayer( eattacker ) )
    {
        eattacker thread function_622561610fb2a062();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xeebd5c3c, Offset: 0x18df9
// Size: 0x25d
function shoot_scroll()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_14_complete" );
    
    if ( !level.hornet_mq.var_bf6b79b6721ec21e )
    {
        level thread function_55ad3e7f56d3caa3();
    }
    
    self.sbl toggle_scroll();
    
    if ( self.var_16bb68f3614c1919 )
    {
        sound_alias = "evt_mq_scrolls_in";
    }
    else
    {
        sound_alias = "evt_mq_scrolls_out";
    }
    
    playsoundatpos( self.origin, sound_alias );
    
    if ( isdefined( level.hornet_mq.scrolls[ self.row ][ self.column + 1 ] ) )
    {
        level.hornet_mq.scrolls[ self.row ][ self.column + 1 ].sbl toggle_scroll();
    }
    
    if ( isdefined( level.hornet_mq.scrolls[ self.row ][ self.column - 1 ] ) )
    {
        level.hornet_mq.scrolls[ self.row ][ self.column - 1 ].sbl toggle_scroll();
    }
    
    if ( isdefined( level.hornet_mq.scrolls[ self.row - 1 ][ self.column ] ) )
    {
        level.hornet_mq.scrolls[ self.row - 1 ][ self.column ].sbl toggle_scroll();
    }
    
    if ( isdefined( level.hornet_mq.scrolls[ self.row + 1 ][ self.column ] ) )
    {
        level.hornet_mq.scrolls[ self.row + 1 ][ self.column ].sbl toggle_scroll();
    }
    
    wait 0.1;
    var_6aa9916868bf639f = function_be2ce462eaadc539();
    
    if ( var_6aa9916868bf639f )
    {
        level thread function_9464d5c9aeb62f6e();
        return;
    }
    
    level.hornet_mq.scrolls_locked = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5491b687, Offset: 0x1905e
// Size: 0x108
function toggle_scroll( b_allowhighlight = 1 )
{
    if ( self.root.var_16bb68f3614c1919 )
    {
        self.root.mover moveto( self.root.out_pos, 0.1 );
        
        if ( level utility::flag( "hornet_mq_scroll_shot_first_time" ) )
        {
            utility::function_7c10ea82c1e305b8( "fx", "out" );
        }
    }
    else
    {
        self.root.mover moveto( self.root.in_pos, 0.1 );
        
        if ( b_allowhighlight )
        {
            if ( level utility::flag( "hornet_mq_scroll_shot_first_time" ) && self.var_8d286506276efa4a )
            {
                utility::function_7c10ea82c1e305b8( "fx", "in" );
            }
        }
    }
    
    self.root.var_16bb68f3614c1919 = !self.root.var_16bb68f3614c1919;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x281ec3b9, Offset: 0x1916e
// Size: 0x60, Type: bool
function function_be2ce462eaadc539()
{
    for ( i = 0; i < 3 ; i++ )
    {
        for ( j = 0; j < 3 ; j++ )
        {
            if ( !level.hornet_mq.scrolls[ i ][ j ].var_16bb68f3614c1919 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x1fba9553, Offset: 0x191d7
// Size: 0x44e
function function_9464d5c9aeb62f6e()
{
    level endon( #"game_ended" );
    
    for ( k = 0; k < 4 ; k++ )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            for ( j = 0; j < 3 ; j++ )
            {
                level.hornet_mq.scrolls[ i ][ j ].sbl toggle_scroll( 0 );
                wait 0.075;
            }
        }
    }
    
    if ( isdefined( level.hornet_mq.records ) && isdefined( level.hornet_mq.records.linkedparent ) )
    {
        level.hornet_mq.records utility::scriptable_clearparententity();
    }
    
    mover = utility::spawn_model( "tag_origin", level.hornet_mq.records.origin, level.hornet_mq.records.angles );
    waitframe();
    level.hornet_mq.records utility::scriptable_setparententity( mover );
    level.hornet_mq.records utility::function_7c10ea82c1e305b8( "fx", "idle" );
    var_ff3f156fcd8fe422 = utility::getstruct( "fall_loc_pestl", "targetname" );
    mover thread utility::function_8001268940441423( mover.origin, var_ff3f156fcd8fe422.origin, var_ff3f156fcd8fe422.origin + ( 0, 0, 65 ), 0.65 );
    mover waittill( #"off_bezier_curve" );
    level.hornet_mq.records freescriptable();
    mover delete();
    level.hornet_mq.var_870342c57e88eff7 = {};
    records_struct = utility::getstruct( "fall_loc_records", "targetname" );
    animated_scroll = spawnscriptable( %"hash_235c1bedac3721e8", records_struct.origin, records_struct.angles );
    animated_scroll utility::function_7c10ea82c1e305b8( "pestle", "hide" );
    pestle_loc = utility::getstruct( "fall_loc_pestl", "targetname" );
    pestle = utility::spawn_model( %"sat_zm_pestle", pestle_loc.origin, pestle_loc.angles );
    pestle_end = utility::getstruct( "pestl_end_loc", "targetname" );
    pestle moveto( pestle_end.origin, 3.2, 0.2, 1 );
    pestle rotatepitch( -720, 3.2, 0.2, 1 );
    wait 2.2;
    pestle rotateto( pestle_end.angles, 1, 0, 1 );
    pestle waittill( #"movedone" );
    animated_scroll freescriptable();
    note_ref = "zm_hornet_mq_dr" + level.hornet_mq.doc_data.var_f4603954af61874;
    param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
    param = string( param );
    level.hornet_mq.var_870342c57e88eff7.records_struct = level spawn_page( note_ref, param, records_struct.origin, records_struct.angles, 1 );
    level.hornet_mq.var_870342c57e88eff7.records_struct utility::function_7c10ea82c1e305b8( "model", "outlined" );
    pestle delete();
    level.hornet_mq.var_870342c57e88eff7.pestle = level mq_spawn_item( %"hash_657a5c27d4c0c0a3", pestle_end.origin, pestle_end.angles );
    level utility::flag_set( "mq_step_14_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc649b8b, Offset: 0x1962d
// Size: 0x57
function function_622561610fb2a062()
{
    self notify( #"hash_7767bf2b36ca2405" );
    self endon( #"hash_7767bf2b36ca2405" );
    self endon( #"hash_e34f6885ee95392c" );
    
    if ( !val::get( "ignore_afk" ) )
    {
        val::set( "hornet_mq_scrolls", "ignore_afk", 1 );
    }
    
    wait 30;
    val::reset( "hornet_mq_scrolls" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb3afccfb, Offset: 0x1968c
// Size: 0x3cd
function function_55ad3e7f56d3caa3()
{
    self notify( #"hash_c36760194f43d4ff" );
    self endon( #"hash_c36760194f43d4ff" );
    scroll_zone = getent( "scroll_zone", #targetname );
    level.hornet_mq.var_bf6b79b6721ec21e = 1;
    spawn_loc = utility::getstruct( "scroll_hint_loc", "targetname" );
    var_57af14f514a18cb7 = spawnscriptable( %"hash_646825aa6b00139", spawn_loc.origin, spawn_loc.angles );
    
    if ( !isdefined( level.hornet_mq.notarget_mnk ) )
    {
        level.hornet_mq.notarget_mnk = utility::spawn_model( "offhand_sat_wm_zm_beckoning_cat", spawn_loc.origin, spawn_loc.angles );
        var_57af14f514a18cb7 utility::function_7c10ea82c1e305b8( "fx", "appear" );
    }
    
    level.hornet_mq.notarget_mnk scriptmodelplayanim( "sat_zm_beckoning_cat_wave_01" );
    
    foreach ( player in level.players )
    {
        player utility::ent_flag_clear( "scroll_puzzle_early_reset_notarget" );
        var_6f88a6bfefadea5e = { #player:player };
        level callback::add( #"on_ai_damaged", &function_265ed95a01523b41, var_6f88a6bfefadea5e );
    }
    
    time_elapsed = 0;
    step = 0.3;
    
    while ( time_elapsed <= 120 )
    {
        if ( level utility::flag( "mq_step_14_complete" ) )
        {
            wait 5;
            break;
        }
        
        var_275fa648b5778b99 = 1;
        
        foreach ( player in level.players )
        {
            if ( player istouching( scroll_zone ) )
            {
                if ( !player.var_ce990cc2ad04a67d && !player utility::ent_flag( "scroll_puzzle_early_reset_notarget" ) )
                {
                    player.var_ce990cc2ad04a67d = 1;
                    player function_81e028aa2967b984( 1 );
                }
            }
            else if ( player.var_ce990cc2ad04a67d || player utility::ent_flag( "scroll_puzzle_early_reset_notarget" ) )
            {
                player.var_ce990cc2ad04a67d = 0;
                player function_81e028aa2967b984( 0 );
            }
            
            if ( !player utility::ent_flag( "scroll_puzzle_early_reset_notarget" ) )
            {
                var_275fa648b5778b99 = 0;
            }
        }
        
        if ( var_275fa648b5778b99 )
        {
            break;
        }
        
        wait step;
        time_elapsed += step;
    }
    
    foreach ( player in level.players )
    {
        player function_81e028aa2967b984( 0 );
        player.var_ce990cc2ad04a67d = 0;
    }
    
    level.hornet_mq.notarget_mnk scriptmodelclearanim();
    
    if ( var_57af14f514a18cb7 )
    {
        var_57af14f514a18cb7 freescriptable();
    }
    
    level waittill( #"on_round_start" );
    level.hornet_mq.var_bf6b79b6721ec21e = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x694633bf, Offset: 0x19a61
// Size: 0x7c
function function_81e028aa2967b984( state )
{
    if ( state )
    {
        val::set( "hornet_mq_scrolls", "ignoreme", 1 );
        return;
    }
    
    val::reset_all( "hornet_mq_scrolls" );
    var_6f88a6bfefadea5e = { #player:self };
    
    if ( level callback::exists( #"on_ai_damaged", &function_265ed95a01523b41, var_6f88a6bfefadea5e ) )
    {
        level callback::remove( #"on_ai_damaged", &function_265ed95a01523b41, var_6f88a6bfefadea5e );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x9b0925e3, Offset: 0x19ae5
// Size: 0x86
function function_265ed95a01523b41( params, var_6f88a6bfefadea5e )
{
    if ( !isdefined( var_6f88a6bfefadea5e.player ) )
    {
        level callback::remove( #"on_ai_damaged", &function_265ed95a01523b41, var_6f88a6bfefadea5e );
    }
    
    if ( params.eattacker == var_6f88a6bfefadea5e.player )
    {
        var_6f88a6bfefadea5e.player utility::ent_flag_set( "scroll_puzzle_early_reset_notarget" );
        level callback::remove( #"on_ai_damaged", &function_265ed95a01523b41, var_6f88a6bfefadea5e );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc59eff68, Offset: 0x19b73
// Size: 0x1ba
function function_3a17f3a04d485be3()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    var_c546cdaaa8093c3a = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_7ced37341c55f339 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_64236e264a7d47fb" ) ?? 0;
    records_struct = utility::getstruct( "fall_loc_records", "targetname" );
    
    if ( !utility::get_bit_flag( var_c546cdaaa8093c3a, 3 ) )
    {
        pestle_loc = utility::getstruct( "pestl_end_loc", "targetname" );
        pestle = level mq_spawn_item( %"hash_657a5c27d4c0c0a3", pestle_loc.origin, pestle_loc.angles );
    }
    
    level.hornet_mq.var_870342c57e88eff7 = {};
    level.hornet_mq.var_870342c57e88eff7.pestle = pestle;
    
    if ( !utility::get_bit_flag( var_7ced37341c55f339, 0 ) )
    {
        note_ref = "zm_hornet_mq_dr" + level.hornet_mq.doc_data.var_f4603954af61874;
        param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
        param = string( param );
        level.hornet_mq.var_870342c57e88eff7.records_struct = level spawn_page( note_ref, param, records_struct.origin, records_struct.angles, 1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xa344ad80, Offset: 0x19d35
// Size: 0x127
function place_pestle()
{
    place_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
    level.hornet_mq.pestle = utility::spawn_model( %"sat_zm_pestle", place_loc.origin, place_loc.angles );
    var_72b1e09e96a28cbb = utility::spawn_model( "tag_origin", level.hornet_mq.var_14f3d8f8c3fabb8b.origin, level.hornet_mq.var_14f3d8f8c3fabb8b.angles );
    pestle_offset = var_72b1e09e96a28cbb.origin - level.hornet_mq.pestle.origin;
    level.hornet_mq.pestle linkto( var_72b1e09e96a28cbb, "tag_origin", pestle_offset, ( 0, 270, -55 ) );
    level.hornet_mq.pestle.var_72b1e09e96a28cbb = var_72b1e09e96a28cbb;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xcdead6fe, Offset: 0x19e64
// Size: 0x61
function function_190b4200fef18909( player )
{
    level place_pestle();
    level.hornet_mq.pestle function_87893dd47b0afe41();
    level utility::flag_set( "mq_step_16_complete" );
    player thread function_2a6deff157d1165a( #"hash_ca212b7a7d9fedcf", #"bc_flavor_player_positive", 0.25 );
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xaa9a7925, Offset: 0x19ecd
// Size: 0x7c
function pestle_hint_callback( usable, player )
{
    if ( level.directed_mode )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_4cc9b8d47d6c068e", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xfee4be1b, Offset: 0x19f51
// Size: 0x64
function function_87893dd47b0afe41()
{
    self notify( #"hash_b6cfb44e1093b1a0" );
    self endon( #"hash_b6cfb44e1093b1a0" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( self ) && isdefined( self.var_72b1e09e96a28cbb ) )
    {
        self.var_72b1e09e96a28cbb rotateyaw( 360, 1.2, 0.1, 0.5 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x62fc694a, Offset: 0x19fbd
// Size: 0x2b6
function function_19e341ff8108fe97()
{
    level endon( #"game_ended" );
    level function_ecc91637c2a6fbb1();
    
    if ( !isdefined( level.hornet_mq.toxic_charge ) )
    {
        level.hornet_mq.toxic_charge = {};
    }
    
    level.hornet_mq.toxic_charge.trig = getent( "tcharge_trig", #targetname );
    level callback::add( "on_zombie_ai_damaged", &function_73b2aa6f186eda );
    level callback::add( "on_turned", &function_cf5db315f92f725c );
    charge_dest = level.hornet_mq.var_14f3d8f8c3fabb8b;
    level function_6e29e1bbb80eff60( 1, [ "zone_second_bailey_c" ] );
    
    if ( !level.hornet_mq.mortar )
    {
        level.hornet_mq.mortar = getent( "sat_zm_mortar_1", #targetname );
    }
    
    level.hornet_mq.mortar utility::function_7c10ea82c1e305b8( "border_fx", "on" );
    level zm_music::start_zone_music_watcher( "mq_toxic_charge_music", [ "zone_second_bailey_a", "zone_second_bailey_b", "zone_second_bailey_c" ], #"hash_508ed6d0c38aab7" );
    charges_received = 0;
    charges_needed = level.players.size > 1 ? 60 : 40;
    
    while ( true )
    {
        level waittill( #"hash_70ac38c0185ecfbc", charge_info );
        charge_amt = charge_info.var_3510eba0a7ae5dbd ? 5 : 1;
        charges_received += charge_amt;
        level thread function_ce96252df904d0b4( charge_info.loc + ( 0, 0, 40 ), charge_dest.origin, charges_received, charges_needed, charge_info.var_3510eba0a7ae5dbd );
        
        if ( charges_received > charges_needed )
        {
            break;
        }
    }
    
    level function_6e29e1bbb80eff60( 0, [ "zone_second_bailey_c" ] );
    level.hornet_mq.mortar utility::function_7c10ea82c1e305b8( "border_fx", "off" );
    level zm_music::function_e9fd14ede793ef0d( "mq_toxic_charge_music" );
    level utility::flag_set( "mq_step_17_complete" );
    selected_player = utility::get_closest_filtered( level.hornet_mq.var_14f3d8f8c3fabb8b.origin, level.players );
    selected_player thread function_2a6deff157d1165a( #"hash_63693e75e39ebca9", #"bc_flavor_player_positive", 0.5 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc6174fe2, Offset: 0x1a27b
// Size: 0xdf
function function_73b2aa6f186eda( params )
{
    if ( !self istouching( level.hornet_mq.toxic_charge.trig ) )
    {
        return;
    }
    
    if ( params.var_5e5a2456deacd236 != "toxic" )
    {
        return;
    }
    
    if ( self.health - params.idamage > 0 )
    {
        return;
    }
    
    self.var_a13bed1ac47e1b2c = 1;
    var_4346ca48d4b756d8 = params.idamage / self.maxhealth;
    var_4346ca48d4b756d8 *= 100;
    charge_info = {};
    charge_info.damage = var_4346ca48d4b756d8;
    charge_info.loc = self.origin;
    charge_info.source = self;
    level notify( #"hash_70ac38c0185ecfbc", charge_info );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2a873338, Offset: 0x1a362
// Size: 0x3c
function function_cf5db315f92f725c( var_75e7c1be4fd022be )
{
    if ( !self istouching( level.hornet_mq.toxic_charge.trig ) )
    {
        return;
    }
    
    level thread function_14d896895726d1da( self );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x59d522a1, Offset: 0x1a3a6
// Size: 0x162
function function_14d896895726d1da( zombie )
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( !isalive( zombie ) )
    {
        return;
    }
    
    if ( zombie.var_8784eb75b9be9390 )
    {
        return;
    }
    
    attractor_loc = level.hornet_mq.var_14f3d8f8c3fabb8b;
    attractor_base = {};
    attractor_base.origin = attractor_loc.origin;
    
    if ( isdefined( zombie.brainrot_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( zombie.brainrot_attractor );
    }
    
    zombie.attractor = zombie zombie_attractor_manager::function_7eb1aaa8bc7cc15( attractor_base, 3, undefined, 0, undefined, undefined, undefined, "axis" );
    
    while ( isalive( zombie ) && distance2dsquared( zombie.origin, attractor_loc.origin ) > 2500 )
    {
        wait 0.1;
    }
    
    zombie.attractor = undefined;
    
    if ( isalive( zombie ) )
    {
        charge_info = {};
        charge_info.loc = zombie.origin;
        charge_info.damage = 500;
        charge_info.source = zombie;
        charge_info.var_3510eba0a7ae5dbd = 1;
        level notify( #"hash_70ac38c0185ecfbc", charge_info );
        zombie kill();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 5
// Checksum 0xa71539af, Offset: 0x1a510
// Size: 0x197
function function_ce96252df904d0b4( starting_pos, goal_pos, charges_received, charges_needed, var_6f52bdd3cc5f64d4 = 0 )
{
    if ( !var_6f52bdd3cc5f64d4 )
    {
        level function_8f370c37e2e751f2( starting_pos, goal_pos - ( 0, 0, 3.5 ), 1, 0.75, "green" );
    }
    
    if ( level.hornet_mq.mortar )
    {
        level.hornet_mq.mortar utility::function_7c10ea82c1e305b8( "impact_fx", "on" );
    }
    
    if ( level.hornet_mq.pestle )
    {
        level.hornet_mq.pestle thread function_87893dd47b0afe41();
    }
    
    if ( !level utility::flag( "hornet_mq_first_toxic_charge_complete" ) )
    {
        if ( level.hornet_mq.mortar )
        {
            nearby_players = getplayersinradius( level.hornet_mq.mortar.origin, 270 );
            selected_player = utility::array_random( nearby_players );
            
            if ( isdefined( selected_player ) )
            {
                level utility::flag_set( "hornet_mq_first_toxic_charge_complete" );
                selected_player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
            }
        }
    }
    
    progress = clamp( charges_received / charges_needed, 0, 1 ) * 100;
    level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"toxic_charge" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x808deee0, Offset: 0x1a6af
// Size: 0x69
function function_cef208d60878faf()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    pestle_place_loc = utility::getstruct( "ppl_txchr_0", "targetname" );
    level.hornet_mq.var_14f3d8f8c3fabb8b = utility::getstruct( pestle_place_loc.target, "targetname" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x698a25ef, Offset: 0x1a720
// Size: 0x11d
function function_eaecbd445c6db062()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "mq_mss_init_complete" );
    var_7ced37341c55f339 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_64236e264a7d47fb" );
    
    if ( isdefined( var_7ced37341c55f339 ) && utility::get_bit_flag( var_7ced37341c55f339, 12 ) )
    {
        return;
    }
    
    spawn_loc = utility::getstruct( "spawn_loc_pc", "targetname" );
    variant = level.hornet_mq.doc_data.var_80e2d83e1c46eea0;
    variant = string( variant );
    level.hornet_mq.var_b13513a678ed761 = level spawn_page( "zm_hornet_mq_pc", variant, spawn_loc.origin, spawn_loc.angles, 1 );
    
    if ( level.directed_mode )
    {
        level.hornet_mq.var_b13513a678ed761 utility::function_7c10ea82c1e305b8( "model", "outlined" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x5b37b5ff, Offset: 0x1a845
// Size: 0x456
function function_ef0036fdd770b14d()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "mq_mss_init_complete" );
    var_7ced37341c55f339 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_64236e264a7d47fb" ) ?? 0;
    var_cf445190aa96d78d = [ 0, 12, 17, 19, 21 ];
    var_87b2d1dc0cfdaa71 = [ [ 1, 2, 3 ], [ 13, 14, 15 ], undefined, undefined, undefined ];
    
    for ( i = 0; i < var_cf445190aa96d78d.size ; i++ )
    {
        var_dcc391fe6316139d = var_cf445190aa96d78d[ i ];
        var_870e4c540e3c5fec = var_87b2d1dc0cfdaa71[ i ];
        
        if ( isdefined( var_7ced37341c55f339 ) && utility::get_bit_flag( var_7ced37341c55f339, var_dcc391fe6316139d ) )
        {
            switch ( var_dcc391fe6316139d )
            {
                case 0:
                    note_ref = "zm_hornet_mq_dr" + level.hornet_mq.doc_data.var_f4603954af61874;
                    param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
                    param = string( param );
                    break;
                case 12:
                    note_ref = "zm_hornet_mq_pc";
                    param = level.hornet_mq.doc_data.var_80e2d83e1c46eea0;
                    param = string( param );
                    break;
                case 17:
                    note_ref = "zm_hornet_mq_acc" + "_g";
                    param = undefined;
                    level utility::flag_set( "solve_mq_read_note_zm_hornet_mq_acc_g" );
                    break;
                case 21:
                    note_ref = "zm_hornet_mq_acc" + "_m";
                    level utility::flag_set( "solve_mq_read_note_zm_hornet_mq_acc_m" );
                    param = undefined;
                    break;
                case 19:
                    note_ref = "zm_hornet_mq_acc" + "_n";
                    level utility::flag_set( "solve_mq_read_note_zm_hornet_mq_acc_n" );
                    param = undefined;
                    break;
            }
            
            dest = function_5f89cd24480ebd1b( note_ref );
            note = level spawn_page( note_ref, param, dest.origin, dest.angles, 0 );
        }
    }
    
    var_3495db260d95d87b = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    var_aa74d7e566bd6e49 = [ 2, 0, 1 ];
    var_e71dde5f6633f958 = [ 17, 19, 21 ];
    var_3d655b5f8f538a79 = [ "zm_hornet_mq_acc" + "_g", "zm_hornet_mq_acc" + "_n", "zm_hornet_mq_acc" + "_m" ];
    var_565f0c44a8324a4c = [ 3, 4, 5 ];
    
    for ( i = 0; i < var_aa74d7e566bd6e49.size ; i++ )
    {
        if ( utility::get_bit_flag( var_3495db260d95d87b, var_aa74d7e566bd6e49[ i ] ) && utility::get_bit_flag( gathered_evidence, var_565f0c44a8324a4c[ i ] ) && !utility::get_bit_flag( var_7ced37341c55f339, var_e71dde5f6633f958[ i ] ) )
        {
            if ( i == 0 )
            {
                a_spawn_loc = utility::getstructarray( "acc_s_l_g", "targetname" );
                spawn_loc = utility::array_random( a_spawn_loc );
            }
            else if ( i == 1 )
            {
                spawn_loc = utility::getstruct( "acc_m_ev_dest_nte", "targetname" );
            }
            else if ( i == 2 )
            {
                spawn_loc = utility::getstruct( "acc_m_fallback_ev_fall_loc", "targetname" );
            }
            
            note_ref = var_3d655b5f8f538a79[ i ];
            page = level spawn_page( note_ref, undefined, spawn_loc.origin, spawn_loc.angles, 1 );
            page utility::function_7c10ea82c1e305b8( "model", "outlined" );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf330fa59, Offset: 0x1aca3
// Size: 0x102
function spawn_blowfish()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    gathered_evidence = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    
    if ( !utility::get_bit_flag( gathered_evidence, 7 ) )
    {
        fish_loc = utility::getstruct( "mq_f_poi_spawn_loc", "targetname" );
        level mq_spawn_item( %"hash_ef3510304fae44a", fish_loc.origin, fish_loc.angles );
    }
    else
    {
        level utility::flag_set( "mq_player_got_f_poi" );
        level function_9947038abd0d1056( #"fug" );
    }
    
    door = getent( "kitchen_shelf_01_pantry_door", #targetname );
    door moveto( door.origin + ( -8, 1.46, 0 ), 0.45, 0.2, 0.2 );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd4beafc8, Offset: 0x1adad
// Size: 0x7a
function setup_plum_evidence()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" );
    
    if ( isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, 8 ) )
    {
        level utility::flag_set( "mq_player_got_p_poi" );
        level function_9947038abd0d1056( #"ppts" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0xa63f47de, Offset: 0x1ae2f
// Size: 0xd5
function function_ace528f06f6036e8( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_hornet_mq_acc_m_food" )
    {
        return;
    }
    
    if ( instance utility::function_9f2c41c1dcc8c94( "model", "a" ) )
    {
        level utility::flag_clear( "mq_acc_m_f_a_pickup_active" );
        level utility::flag_clear( "mq_acc_m_fr_drop_success" );
        level function_ecc91637c2a6fbb1();
    }
    
    instance notify( #"mq_acc_m_f_destroyed" );
    waitframe();
    
    if ( instance )
    {
        instance utility::scriptable_clearparententity();
        instance freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x2ffabd8e, Offset: 0x1af0c
// Size: 0x94
function setup_produce_bags()
{
    level utility::flag_wait( "scriptables_ready" );
    var_a8edff07174136af = utility::function_30dbabe3200518b( "fruit_basket_plum", #targetname );
    var_a8edff07174136af utility::function_7c10ea82c1e305b8( "model", "model_u" );
    var_a8edff07174136af = utility::function_30dbabe3200518b( "fruit_basket_persimmon", #targetname );
    var_a8edff07174136af utility::function_7c10ea82c1e305b8( "model", "model_a" );
    var_a8edff07174136af = utility::function_30dbabe3200518b( "fruit_basket_peach", #targetname );
    var_a8edff07174136af utility::function_7c10ea82c1e305b8( "model", "model_p" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0x928d8889, Offset: 0x1afa8
// Size: 0x441
function function_1d34aa3d950d5995( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_hornet_mq_produce_bag" || smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    if ( instance.var_daaae86080cbbe57 )
    {
        return;
    }
    
    instance.var_daaae86080cbbe57 = 1;
    instance thread function_c6fc6a2587dd23ad();
    
    if ( isdefined( eattacker ) && !level utility::flag( "hornet_mq_first_fruit_released" ) )
    {
        level utility::flag_set( "hornet_mq_first_fruit_released" );
        eattacker thread function_2a6deff157d1165a( undefined, #"hash_5212ed7ec42f115a", 0.5 );
    }
    
    instance utility::function_7c10ea82c1e305b8( "anim", "meleed" );
    var_175e0109a63f0a9b = vectornormalize( vdir );
    startloc = vpoint + var_175e0109a63f0a9b * 10;
    startloc += ( 0, 0, 2 );
    produce_sbl = spawnscriptable( %"zm_sat_hornet_mq_acc_m_food", startloc, ( randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ) ) );
    linker = utility::spawn_model( "tag_origin", startloc, ( 0, 0, 0 ) );
    waitframe();
    produce_sbl utility::scriptable_setparententity( linker );
    produce_sbl utility::function_7c10ea82c1e305b8( "model", instance.script_noteworthy );
    endstruct = utility::getstruct( instance.targetname + "_land_loc", "targetname" );
    endloc = endstruct.origin;
    endloc += ( 0, 0, 2 );
    midpoint = ( startloc + endloc ) / 2;
    midpoint += ( 0, 0, 75 );
    linker thread function_cad0bf3e8e891213();
    linker thread utility::function_8001268940441423( startloc, endloc, midpoint, 0.6, 0, 0, 0.995 );
    linker waittill( #"off_bezier_curve" );
    var_9524d5ea4c732e1b = utility::getstruct( instance.target, "targetname" );
    var_2e72e7bd4bd7e398 = var_9524d5ea4c732e1b.origin + ( randomfloatrange( var_9524d5ea4c732e1b.radius * -1 / 2, var_9524d5ea4c732e1b.radius / 2 ), randomfloatrange( var_9524d5ea4c732e1b.radius * -1 / 2, var_9524d5ea4c732e1b.radius / 2 ), 0 );
    var_2e72e7bd4bd7e398 += ( 0, 0, 2 );
    midpoint = ( linker.origin + var_2e72e7bd4bd7e398 ) / 2;
    midpoint += ( 0, 0, 20 );
    linker thread utility::function_8001268940441423( linker.origin, var_2e72e7bd4bd7e398, midpoint, 0.45 );
    linker waittill( #"off_bezier_curve" );
    
    if ( isdefined( produce_sbl ) )
    {
        produce_sbl utility::scriptable_clearparententity();
        produce_sbl interaction::set_interact_hint_callback( &function_2d989bddbb196d1 );
        produce_sbl utility::function_7c10ea82c1e305b8( "usable", "enabled" );
        produce_sbl thread function_c9880eed1e20cb60();
        produce_sbl.angles = ( 0, 0, 0 );
    }
    
    if ( instance.script_noteworthy == "a" )
    {
        sound_alias = "evt_mq_persimmon_ground_impact";
    }
    else
    {
        sound_alias = "evt_mq_fruit_ground_impact";
    }
    
    playsoundatpos( endloc, sound_alias );
    
    if ( instance.script_noteworthy == "u" && !level utility::flag( "mq_player_got_p_poi" ) )
    {
        produce_sbl thread function_c6e4a3747f005070();
    }
    
    if ( instance.script_noteworthy == "a" && !level utility::flag( "mq_acc_m_f_a_pickup_active" ) && !level utility::flag( "mq_acc_m_killed" ) )
    {
        level.hornet_mq.dropped_persimmon = produce_sbl;
        produce_sbl thread function_d213fb61409ae9c6();
    }
    
    linker delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x160f6509, Offset: 0x1b3f1
// Size: 0x73
function function_c6fc6a2587dd23ad()
{
    self notify( #"hash_879620cb64fe35c5" );
    self endon( #"hash_879620cb64fe35c5" );
    level endon( #"game_ended" );
    level utility::flag_set( "mq_basket_empty_" + self.script_noteworthy );
    level waittill( #"on_round_start" );
    level utility::flag_clear( "mq_basket_empty_" + self.script_noteworthy );
    self.var_daaae86080cbbe57 = 0;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x353e56c5, Offset: 0x1b46c
// Size: 0x73
function function_cad0bf3e8e891213()
{
    level endon( #"game_ended" );
    self endon( #"stop_curve" );
    self endon( #"off_bezier_curve" );
    rotatemod = ( randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ) );
    
    while ( isdefined( self ) )
    {
        self rotateby( rotatemod, 0.25 );
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x62a70ee4, Offset: 0x1b4e7
// Size: 0x101
function function_c9880eed1e20cb60()
{
    self endon( #"mq_acc_m_fd_consumed" );
    
    if ( utility::function_9f2c41c1dcc8c94( "model", "a" ) )
    {
        var_3c3715f5d5ea6f3b = 1;
        level endon( #"mq_acc_m_f_a_pickup_active" );
    }
    
    time_waited = 0;
    step = 0.5;
    
    while ( true )
    {
        if ( !self )
        {
            if ( var_3c3715f5d5ea6f3b )
            {
                level utility::flag_clear( "mq_acc_m_f_a_pickup_active" );
                
                if ( self == level.hornet_mq.dropped_fruit )
                {
                    level.hornet_mq.dropped_fruit = undefined;
                }
                
                level function_ecc91637c2a6fbb1();
                return;
            }
        }
        
        lifetime = var_3c3715f5d5ea6f3b ? 120 : 60;
        
        if ( time_waited >= lifetime )
        {
            break;
        }
        
        wait step;
        time_waited += step;
    }
    
    self notify( #"mq_acc_m_f_destroyed" );
    
    if ( var_3c3715f5d5ea6f3b )
    {
        level utility::flag_clear( "mq_acc_m_fr_drop_success" );
    }
    
    level function_ecc91637c2a6fbb1();
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x23ffea1b, Offset: 0x1b5f0
// Size: 0x10d
function function_d213fb61409ae9c6()
{
    self endon( #"mq_acc_m_fd_consumed" );
    self endon( #"mq_acc_m_f_destroyed" );
    level endon( #"mq_acc_m_killed" );
    
    if ( !( isdefined( self ) && isdefined( self.origin ) ) )
    {
        return;
    }
    
    level utility::flag_set( "mq_acc_m_f_a_pickup_active" );
    level function_ecc91637c2a6fbb1();
    fruit_pos = self.origin;
    time_left_alone = 0;
    step = 0.5;
    
    while ( true )
    {
        near_players = getplayersinradius( fruit_pos, 1680 );
        
        if ( near_players.size > 0 )
        {
            time_left_alone = 0;
            wait step;
            continue;
        }
        
        if ( time_left_alone >= 60 )
        {
            break;
        }
        
        time_left_alone += step;
        wait step;
    }
    
    var_51bc0779ee40d7a7 = utility::getstruct( "sat_cin_zm_living_world_solo_eating_zmb_01", "script_noteworthy" );
    var_51bc0779ee40d7a7 zm_livingworld::livingworld_spawn_encounter();
    zombie = var_51bc0779ee40d7a7.scene_ents[ "actors" ][ 0 ];
    
    if ( zombie )
    {
        zombie thread function_722fa62e943f9d10( self );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x26755cd6, Offset: 0x1b705
// Size: 0x1c6
function function_722fa62e943f9d10( produce_sbl )
{
    /#
        iprintlnbold( "<dev string:xbe>" );
    #/
    
    self endon( #"death" );
    val::set( "mq_acc_m_fruit_zom", "ignore_cleanup", 1 );
    val::set( "mq_acc_m_fruit_zom", "ignoreme", 1 );
    
    if ( !threatbiasgroupexists( "mq_fruit_zombie" ) )
    {
        createthreatbiasgroup( "mq_fruit_zombie" );
        setthreatbiasignoreall( "mq_fruit_zombie" );
    }
    
    self setthreatbiasgroup( "mq_fruit_zombie" );
    level.hornet_mq.fruit_zombie = self;
    self.var_3807d4363cfee498 = 1;
    level function_ecc91637c2a6fbb1();
    
    if ( isdefined( produce_sbl ) )
    {
        produce_sbl freescriptable();
    }
    
    fruit_tag = "j_jaw";
    jaw_pos = self gettagorigin( fruit_tag );
    jaw_angles = self gettagangles( fruit_tag );
    offset_x = getdvarfloat( @"hash_47cd74911d8499fd", 0 );
    offset_y = getdvarfloat( @"hash_47cd73911d8497ca", -4.5 );
    offset_z = getdvarfloat( @"hash_47cd72911d849597", -2.85 );
    angle_offset_y = getdvarfloat( @"hash_3350e8f6236fd5fa", 35 );
    jaw_offset = ( offset_x, offset_y, offset_z );
    self.fruit_mdl = utility::spawn_model( %"sat_zm_fruit_kaki", jaw_pos, jaw_angles );
    self.fruit_mdl linkto( self, fruit_tag, jaw_offset, ( 0, angle_offset_y, 0 ) );
    callback::add( "on_zombie_ai_killed", &function_8de84c8d6b6ffe03 );
    val::set( "mq_acc_m_fruit_zom", "allow_brot", 0 );
    thread function_8616c1446e92c34a();
    
    if ( level.directed_mode )
    {
        thread function_35ea685a0e0fa29c();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc83a3517, Offset: 0x1b8d3
// Size: 0xcc
function function_35ea685a0e0fa29c()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( level.hornet_mq.merchant_trig ) && self istouching( level.hornet_mq.merchant_trig ) && !level utility::flag( "directed_mode_persimmon_zombie_near_merchant_shack" ) )
        {
            level utility::flag_set( "directed_mode_persimmon_zombie_near_merchant_shack" );
            level function_ecc91637c2a6fbb1();
        }
        else if ( isdefined( level.hornet_mq.merchant_trig ) && !self istouching( level.hornet_mq.merchant_trig ) && level utility::flag( "directed_mode_persimmon_zombie_near_merchant_shack" ) )
        {
            level utility::flag_clear( "directed_mode_persimmon_zombie_near_merchant_shack" );
            level function_ecc91637c2a6fbb1();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd8e91364, Offset: 0x1b9a7
// Size: 0x27
function function_8616c1446e92c34a()
{
    while ( isalive( self ) )
    {
        utility::function_7c10ea82c1e305b8( "hornet_mq_fx", "acc_m_eat" );
        wait randomfloatrange( 5, 8 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xb5e5f469, Offset: 0x1b9d6
// Size: 0x95
function function_8de84c8d6b6ffe03( params )
{
    if ( self.goal_attractor )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
    }
    
    level utility::flag_clear( "mq_acc_m_f_a_pickup_active" );
    level.hornet_mq.fruit_zombie = undefined;
    
    if ( !isdefined( params.vdir ) )
    {
        params.vdir = ( 0, 0, 1 );
    }
    
    self.fruit_mdl thread function_d68d2889f0db1904( params.vdir, params.eattacker );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xd05cb2ab, Offset: 0x1ba73
// Size: 0x27e
function function_d68d2889f0db1904( source_velocity, var_683802b2050b229 = undefined )
{
    zombie = self.linkedparent;
    self unlink();
    self.angles = ( 0, 0, 0 );
    target_pos = self.origin + source_velocity * -5;
    
    /#
        debugstar( target_pos, ( 1, 0, 0 ), 900 );
    #/
    
    ground_pos = getclosestpointonnavmesh( target_pos );
    
    if ( !isdefined( ground_pos ) )
    {
        ground_pos = zombie.origin;
    }
    
    ground_pos = utility::drop_to_ground( ground_pos, 50, -50 );
    ground_pos += ( 0, 0, 1 );
    
    /#
        debugstar( ground_pos, ( 0, 1, 0 ), 900 );
    #/
    
    control_pos = ( self.origin + ground_pos ) / 2 + ( 0, 0, 20 );
    utility::function_8001268940441423( self.origin, ground_pos, control_pos, 0.3, 1 );
    produce_sbl = spawnscriptable( %"zm_sat_hornet_mq_acc_m_food", ground_pos, self.angles );
    produce_sbl utility::function_7c10ea82c1e305b8( "model", "a" );
    produce_sbl interaction::set_interact_hint_callback( &function_2d989bddbb196d1 );
    produce_sbl utility::function_7c10ea82c1e305b8( "usable", "enabled" );
    produce_sbl utility::function_7c10ea82c1e305b8( "land_sfx", "on" );
    produce_sbl thread function_c9880eed1e20cb60();
    
    /#
        if ( !isdefined( level.hornet_mq.merchant_trig ) )
        {
            iprintlnbold( "<dev string:xd1>" );
        }
    #/
    
    if ( isdefined( level.hornet_mq.merchant_trig ) && self istouching( level.hornet_mq.merchant_trig ) )
    {
        level utility::flag_set( "mq_acc_m_fr_drop_success" );
        level.hornet_mq.dropped_fruit = produce_sbl;
        
        if ( level utility::flag( "mq_acc_m_summoned" ) )
        {
            return;
        }
        
        level utility::flag_set( "mq_acc_m_summoned" );
        wait 1;
        spawn_struct = utility::getstruct( "mq_acc_spawn_loc_m", "targetname" );
        level thread function_abb9d7c076fba681( spawn_struct );
        
        if ( isalive( var_683802b2050b229 ) )
        {
            var_683802b2050b229 thread function_2a6deff157d1165a( #"hash_101651bbc6412d80", undefined, 1.3 );
        }
    }
    
    level function_ecc91637c2a6fbb1();
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x9ec72ba1, Offset: 0x1bcf9
// Size: 0xbc
function function_c6e4a3747f005070()
{
    level endon( #"game_ended" );
    level endon( #"mq_player_got_p_poi" );
    level utility::flag_set( "mq_acc_m_p_sqsh_active" );
    level.hornet_mq.current_plum = self;
    level function_ecc91637c2a6fbb1();
    self.trig = spawn( "trigger_radius", self.origin, 0, 15, 110 );
    self.trig childthread function_3ec35c7f3205404f( self );
    msg = utility::waittill_any_return( "mq_p_poi_unlocked", "mq_acc_m_f_destroyed", "mq_acc_m_fd_consumed" );
    var_dd4d4fa2a3955923 = msg == "mq_p_poi_unlocked" ? 1 : 0;
    level cleanup_plum( var_dd4d4fa2a3955923, self );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x3513fa10, Offset: 0x1bdbd
// Size: 0x178
function cleanup_plum( var_dd4d4fa2a3955923, var_cc9436df78116cdd )
{
    level.hornet_mq.current_plum = undefined;
    
    if ( var_dd4d4fa2a3955923 )
    {
        cached_pos = var_cc9436df78116cdd.origin;
        cached_ang = var_cc9436df78116cdd.angles;
        level utility::flag_set( "mq_acc_m_p_sqsh_success" );
    }
    else
    {
        level utility::flag_clear( "mq_acc_m_p_sqsh_active" );
        level utility::flag_clear( "mq_acc_m_p_sqsh_success" );
    }
    
    if ( var_cc9436df78116cdd )
    {
        var_cc9436df78116cdd freescriptable();
    }
    
    if ( var_dd4d4fa2a3955923 )
    {
        level.hornet_mq.pits = level mq_spawn_item( %"hash_403f244a721f15aa", cached_pos, cached_ang );
        level function_ecc91637c2a6fbb1();
        var_cc9436df78116cdd.trig waittill( #"hash_6305c6c3aee31a00" );
        sound_loc = level.hornet_mq.pits.origin;
        playsoundatpos( sound_loc, "evt_mq_plum_squish_destroyed" );
        level.hornet_mq.pits freescriptable();
        level.hornet_mq.pits = undefined;
        level utility::flag_clear( "mq_acc_m_p_sqsh_active" );
        level utility::flag_clear( "mq_acc_m_p_sqsh_success" );
    }
    
    if ( var_cc9436df78116cdd.trig )
    {
        var_cc9436df78116cdd.trig delete();
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xdd365786, Offset: 0x1bf3d
// Size: 0x20b
function function_3ec35c7f3205404f( plum )
{
    self notify( #"hash_239f6f295f648941" );
    self endon( #"hash_239f6f295f648941" );
    level notify( #"hash_ae5affb3a5dc3937" );
    level endon( #"game_ended" );
    level endon( #"hash_ae5affb3a5dc3937" );
    self endon( #"death" );
    times_jumped = 0;
    jumps_required = randomintrange( 3, 4 );
    var_9386a7c05732f496 = 0.5;
    
    if ( level.directed_mode )
    {
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"hornet_mq_guidance", #"hash_9419d2f90a823d02" );
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) && player isjumping() )
            {
                wait var_9386a7c05732f496;
                
                if ( player istouching( self ) && player isonground() )
                {
                    times_jumped += 1;
                    self notify( #"hash_6305c6c3aee31a00" );
                    plum utility::function_7c10ea82c1e305b8( "fx", "u_squash" );
                    
                    if ( level.directed_mode )
                    {
                        progress = clamp( times_jumped / jumps_required, 0, 1 ) * 100;
                        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"hash_9419d2f90a823d02" );
                    }
                    
                    if ( times_jumped == jumps_required )
                    {
                        plum notify( #"mq_p_poi_unlocked" );
                    }
                    
                    if ( times_jumped > jumps_required )
                    {
                        if ( !level utility::flag( "hornet_mq_first_jump_fail_vo_played" ) )
                        {
                            if ( isdefined( player ) )
                            {
                                level utility::flag_set( "hornet_mq_first_jump_fail_vo_played" );
                                player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_negative", 0.5 );
                            }
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb15bedad, Offset: 0x1c150
// Size: 0x27b
function setup_flower_evidence()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    
    while ( !isdefined( level.players ) || level.players.size <= 0 )
    {
        waitframe();
    }
    
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    
    if ( utility::get_bit_flag( gathered_evidence, 6 ) )
    {
        level function_9947038abd0d1056( #"hash_353d73dcd4cf7d1" );
        return;
    }
    
    if ( !utility::get_bit_flag( var_181bfe57b6b9d727, 4 ) )
    {
        bud_loc = utility::getstruct( "mq_m_poi_appear_loc", "targetname" );
        
        if ( level.directed_mode )
        {
            level mq_spawn_item( %"hash_4ad8fc4e1404f6c7", bud_loc.origin, bud_loc.angles );
        }
        else
        {
            bud = spawnscriptable( %"hash_24be5c31873b2573", bud_loc.origin, bud_loc.angles );
            bud utility::function_7c10ea82c1e305b8( "usable", "enabled_standard" );
        }
    }
    else
    {
        level utility::flag_set( "mq_player_got_fbud" );
        level function_9947038abd0d1056( #"hash_345ff3dcd40fe6d" );
        
        if ( !utility::get_bit_flag( var_181bfe57b6b9d727, 5 ) || !utility::get_bit_flag( var_181bfe57b6b9d727, 6 ) )
        {
            level setup_planter_interact();
        }
    }
    
    if ( utility::get_bit_flag( var_181bfe57b6b9d727, 6 ) )
    {
        level utility::flag_set( "mq_apch_emptied" );
    }
    
    spawn_loc = utility::getstruct( "mq_m_poi_place_loc", "targetname" );
    
    if ( utility::get_bit_flag( var_181bfe57b6b9d727, 5 ) && !utility::get_bit_flag( var_181bfe57b6b9d727, 7 ) )
    {
        level.hornet_mq.var_a81563937a7071d0 = spawnscriptable( %"hash_24be5c31873b2573", spawn_loc.origin, spawn_loc.angles );
        level thread function_b202271261e14de();
        return;
    }
    
    if ( utility::get_bit_flag( var_181bfe57b6b9d727, 7 ) && !utility::get_bit_flag( gathered_evidence, 6 ) )
    {
        level mq_spawn_item( %"hash_40941bf2a1d7f0cf", spawn_loc.origin, spawn_loc.angles );
        level utility::flag_set( "mq_poi_fl_grown" );
        level utility::flag_set( "mq_sakura_storm_in_flower_range" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x128a2bd5, Offset: 0x1c3d3
// Size: 0x16b
function setup_pouch_item()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    pouch_state = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6f603c1ee13db4c5" );
    
    if ( pouch_state == 2 )
    {
        level utility::flag_set( "mq_apch_emptied" );
        level utility::flag_set( "mq_gathered_apch" );
        level utility::flag_set( "mq_player_got_pch" );
        level utility::flag_set( "mq_pch_dislodged" );
        level function_9947038abd0d1056( #"pch", undefined );
        return;
    }
    
    if ( pouch_state == 1 )
    {
        level utility::flag_set( "mq_gathered_apch" );
        level utility::flag_set( "mq_player_got_pch" );
        level utility::flag_set( "mq_pch_dislodged" );
        level function_9947038abd0d1056( #"pch", undefined, 3 );
        return;
    }
    
    if ( pouch_state == 0 )
    {
        level utility::flag_set( "mq_player_got_pch" );
        level utility::flag_set( "mq_pch_dislodged" );
        level thread function_98352a2c73c286b4();
        level function_9947038abd0d1056( #"pch", undefined );
        return;
    }
    
    pouch_loc = utility::getstruct( "mq_pouch_loc", "targetname" );
    level.hornet_mq.pouch = utility::spawn_model( %"hash_1a29a4a50eac25c4", pouch_loc.origin, pouch_loc.angles );
    level thread function_1b4b122ecb7780ca();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xe777686a, Offset: 0x1c546
// Size: 0x66
function function_8378410e50e85615()
{
    if ( level utility::flag( "mq_apch_emptied" ) )
    {
        pouch_state = 2;
    }
    else if ( level utility::flag( "mq_gathered_apch" ) )
    {
        pouch_state = 1;
    }
    else if ( level utility::flag( "mq_player_got_pch" ) )
    {
        pouch_state = 0;
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6f603c1ee13db4c5", pouch_state );
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x8f52a9d5, Offset: 0x1c5b4
// Size: 0xc6
function function_7405f53addf7ae1e( instance, part, state, player, bautouse, usestring )
{
    level utility::flag_set( "mq_player_got_fbud" );
    level function_9947038abd0d1056( #"hash_345ff3dcd40fe6d", player );
    level setup_planter_interact();
    player playsoundtoplayer( "evt_mq_monkshood_pickup", player );
    misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    misc_item_data = utility::set_bit_flag( misc_item_data, 4 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
    instance freescriptable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x33069632, Offset: 0x1c682
// Size: 0x2bf
function function_1b4b122ecb7780ca()
{
    if ( !isdefined( level.hornet_mq.pouch ) )
    {
        pouch_loc = utility::getstruct( "mq_pouch_loc", "targetname" );
        level.hornet_mq.pouch = utility::spawn_model( %"hash_1a29a4a50eac25c4", pouch_loc.origin, pouch_loc.angles );
    }
    
    trigger = getent( "closet_shelf_trig_zone_broken_turrets", #targetname );
    
    while ( true )
    {
        trigger waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        trigger.health = 99999;
        
        if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) && isdefined( inflictor ) && isdefined( inflictor.weapon_name ) ) )
        {
            continue;
        }
        
        if ( objweapon.basename != "sat_ww_hornet_zm" )
        {
            continue;
        }
        
        if ( inflictor.weapon_name != "sat_underbarrel_ww_hornet" )
        {
            continue;
        }
        
        break;
    }
    
    var_93c3e7bb3f019adf = level.hornet_mq.pouch;
    var_c23a8cb334b43f16 = utility::getstruct( "mq_pouch_fall_loc", "targetname" );
    control_point = utility::getstruct( var_c23a8cb334b43f16.target, "targetname" );
    level.hornet_mq.pouch thread function_cad0bf3e8e891213();
    level.hornet_mq.pouch utility::function_8001268940441423( var_93c3e7bb3f019adf.origin, var_c23a8cb334b43f16.origin, control_point.origin, 0.5 );
    mq_spawn_item( %"hash_2d8fa9845d2b9cb", level.hornet_mq.pouch.origin, ( 0, 0, 0 ) );
    level utility::flag_set( "mq_pch_dislodged" );
    level function_ecc91637c2a6fbb1();
    level.hornet_mq.pouch delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4732b025, Offset: 0x1c949
// Size: 0x388
function function_98352a2c73c286b4()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_19_complete" );
    level thread function_fea9a5cd9197e233();
    
    if ( level.directed_mode )
    {
        level callback::add( "ash_start", &function_eff796e53737af16 );
        level callback::add( "ash_end", &function_f854ac2c90a90ce3 );
        level function_ecc91637c2a6fbb1();
    }
    
    var_a9a6ebd7f7730321 = 50;
    step = 0.1;
    var_ca94181290d92efe = 0.025;
    var_71fc0e67f24be933 = step - var_ca94181290d92efe;
    level.hornet_mq.var_1797dd5daa377eae = 0;
    var_288d2cd88be6ca4c = undefined;
    
    while ( true )
    {
        progress = clamp( level.hornet_mq.var_1797dd5daa377eae / var_a9a6ebd7f7730321, 0, 1 ) * 100;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"hash_5c4f87e51558611b" );
        level.hornet_mq.var_a91b2d16f4fb9c9d = progress;
        function_398bc9ee922d91fd( "snd_hornet_mq_ash_sndmodifier", progress );
        var_61973c47236dc234 = 0;
        
        foreach ( player in level.players )
        {
            if ( player.b_in_ash )
            {
                var_288d2cd88be6ca4c = player;
                var_61973c47236dc234 += 1;
                
                if ( !player.var_8723db3efefaa92b )
                {
                    player.var_8723db3efefaa92b = 1;
                    player thread utility::play_loop_sound_on_entity( "evt_mq_pouch_filling_lp" );
                }
                
                continue;
            }
            
            if ( player.var_8723db3efefaa92b )
            {
                player.var_8723db3efefaa92b = 0;
                player utility::stop_loop_sound_on_entity( "evt_mq_pouch_filling_lp" );
            }
        }
        
        if ( var_61973c47236dc234 > 0 )
        {
            level.hornet_mq.var_1797dd5daa377eae += var_71fc0e67f24be933 + var_ca94181290d92efe * var_61973c47236dc234;
        }
        
        if ( level.hornet_mq.var_1797dd5daa377eae >= var_a9a6ebd7f7730321 )
        {
            if ( isdefined( var_288d2cd88be6ca4c ) )
            {
                var_288d2cd88be6ca4c thread function_2a6deff157d1165a( #"hash_5a9d9550dc765445", #"bc_flavor_player_positive", 0.25 );
            }
            
            foreach ( player in level.players )
            {
                if ( player.var_8723db3efefaa92b )
                {
                    player.var_8723db3efefaa92b = 0;
                    player utility::stop_loop_sound_on_entity( "evt_mq_pouch_filling_lp" );
                }
                
                player playsoundtoplayer( "evt_mq_pouch_filled_complete", player );
            }
            
            break;
        }
        
        wait step;
    }
    
    level utility::flag_set( "mq_gathered_apch" );
    level function_8378410e50e85615();
    level function_9947038abd0d1056( #"pch", var_288d2cd88be6ca4c, 3 );
    
    if ( level.directed_mode )
    {
        level callback::remove( "ash_start", &function_eff796e53737af16 );
        level callback::remove( "ash_end", &function_f854ac2c90a90ce3 );
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xde67c731, Offset: 0x1ccd9
// Size: 0x4f
function function_fea9a5cd9197e233()
{
    level endon( #"mq_step_19_complete" );
    level endon( #"ash_started" );
    
    if ( !level.directed_mode )
    {
        return;
    }
    
    if ( zm_sat_hornet_weather_ash::function_989fd2b3918fb9da() )
    {
        level function_ecc91637c2a6fbb1();
        return;
    }
    
    level waittill( #"on_round_start" );
    level thread function_2adfcf2f4ebf2421();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6138c6cf, Offset: 0x1cd30
// Size: 0xa6
function function_2adfcf2f4ebf2421()
{
    level endon( #"game_ended" );
    var_2185cd23a0eac159 = [ "zone_main_bailey", "zone_third_bailey_east", "zone_third_bailey_west", "zone_west_bailey", "zone_broken_turrets", "zone_second_bailey", "zone_lava_garden" ];
    ash_zone = utility::array_random( var_2185cd23a0eac159 );
    level zm_sat_hornet_weather_ash::function_6f9a9c8f4f91f3a4( ash_zone );
    
    /#
        iprintlnbold( "<dev string:x127>" + ash_zone );
    #/
    
    wait_len = zm_sat_hornet_weather_ash::function_9618619ab04e15f1();
    wait wait_len * 60;
    level zm_sat_hornet_weather_ash::function_209997c5345ab152( ash_zone );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xef20a517, Offset: 0x1cdde
// Size: 0x20
function function_eff796e53737af16( params )
{
    level notify( #"ash_started" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xba39cfc, Offset: 0x1ce06
// Size: 0x76
function function_f854ac2c90a90ce3( params )
{
    if ( level.directed_mode && !level utility::flag( "mq_gathered_apch" ) )
    {
        if ( level.hornet_mq.var_1797dd5daa377eae >= 47.5 )
        {
            level.hornet_mq.var_1797dd5daa377eae = 50;
        }
        
        level.hornet_mq.var_62a2941168be1a18 = undefined;
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x776a140c, Offset: 0x1ce84
// Size: 0x67
function setup_planter_interact()
{
    interact_loc = utility::getstruct( "mq_m_poi_place_loc", "targetname" );
    interact = interaction::register_interact( interact_loc.origin, 80, &function_a5bc5676052b3c36, &function_e09a4681c90b2a2b );
    interact sethintonobstruction( "show" );
    interact.root = interact_loc;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xd71666fb, Offset: 0x1cef3
// Size: 0x1f1
function function_a5bc5676052b3c36( player )
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "mq_player_got_fbud" ) )
    {
        return;
    }
    
    self makeunusable();
    
    if ( !isdefined( level.hornet_mq.var_a81563937a7071d0 ) )
    {
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 5 );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
        level.hornet_mq.var_a81563937a7071d0 = spawnscriptable( %"hash_24be5c31873b2573", self.root.origin, self.root.angles );
        wait 1.5;
    }
    
    if ( level utility::flag( "mq_gathered_apch" ) )
    {
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 6 );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
        level utility::flag_set( "mq_apch_emptied" );
        level function_8378410e50e85615();
        level function_9947038abd0d1056( #"pch", undefined );
        level.hornet_mq.var_a81563937a7071d0 utility::function_7c10ea82c1e305b8( "fx", "ash" );
        level function_ecc91637c2a6fbb1();
        player thread function_2a6deff157d1165a( #"hash_89f7f966c360294c", #"bc_flavor_player_positive", 0.25 );
    }
    else
    {
        self makeusable();
        self sethintonobstruction( "show" );
        player thread function_2a6deff157d1165a( #"hash_23b719da1764954f", #"hash_5212ed7ec42f115a", 0.25 );
        return;
    }
    
    level thread function_b202271261e14de();
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xbc2d8c81, Offset: 0x1d0ec
// Size: 0x112
function function_e09a4681c90b2a2b( usable, player )
{
    if ( level.directed_mode )
    {
        if ( !isdefined( level.hornet_mq.var_a81563937a7071d0 ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_4d6c3b4cddb31ad8", #type:"HINT_BUTTON" };
        }
        else if ( level utility::flag( "mq_gathered_apch" ) && !level utility::flag( "mq_apch_emptied" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_62708739de31dea3", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xe016cfe2, Offset: 0x1d206
// Size: 0x1dc
function function_b202271261e14de()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_19_complete" );
    level function_ecc91637c2a6fbb1();
    
    if ( level.directed_mode )
    {
        childthread function_d597bb4abc2c1342();
    }
    
    while ( true )
    {
        level waittill( #"hash_d418716213427ca5", params );
        
        /#
            iprintlnbold( distance2d( params.position, level.hornet_mq.var_a81563937a7071d0.origin ) );
        #/
        
        if ( distance2dsquared( params.position, level.hornet_mq.var_a81563937a7071d0.origin ) < 122500 )
        {
            break;
        }
    }
    
    level utility::flag_set( "mq_sakura_storm_in_flower_range" );
    level function_ecc91637c2a6fbb1();
    level.hornet_mq.var_a81563937a7071d0 utility::function_7c10ea82c1e305b8( "fx", "growing" );
    wait 5;
    level mq_spawn_item( %"hash_40941bf2a1d7f0cf", level.hornet_mq.var_a81563937a7071d0.origin, level.hornet_mq.var_a81563937a7071d0.angles );
    level utility::flag_set( "mq_poi_fl_grown" );
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 7 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
    
    if ( isdefined( level.hornet_mq.var_a81563937a7071d0 ) )
    {
        level.hornet_mq.var_a81563937a7071d0 freescriptable();
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xbe322466, Offset: 0x1d3ea
// Size: 0x242
function function_d597bb4abc2c1342()
{
    var_ee583b17d60ffe56 = [];
    var_ee583b17d60ffe56[ "zone_broken_turrets_tree" ] = { #var_c50f749e8cfd5137:0 };
    var_ee583b17d60ffe56[ "zone_main_keep_tree" ] = { #var_c50f749e8cfd5137:0 };
    var_ee583b17d60ffe56[ "zone_second_bailey_tree" ] = { #var_c50f749e8cfd5137:0 };
    var_ee583b17d60ffe56[ "zone_third_bailey_tree" ] = { #var_c50f749e8cfd5137:0 };
    var_e87a2dfa872dd30f = [ "zone_broken_turrets_tree", "zone_main_keep_tree", "zone_second_bailey_tree", "zone_third_bailey_tree" ];
    var_99d33e2b7396290 = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        var_99d33e2b7396290[ i ] = level.players[ i ] utility::ent_flag( "skr_buff" );
    }
    
    while ( !level utility::flag( "mq_poi_fl_grown" ) )
    {
        b_update_guidance = 0;
        
        for ( i = 0; i < var_e87a2dfa872dd30f.size ; i++ )
        {
            curr_name = var_e87a2dfa872dd30f[ i ];
            
            if ( isdefined( level.sakura_root.all_trees[ curr_name ].var_c50f749e8cfd5137 ) && !var_ee583b17d60ffe56[ curr_name ].var_c50f749e8cfd5137 || !isdefined( level.sakura_root.all_trees[ curr_name ].var_c50f749e8cfd5137 ) && var_ee583b17d60ffe56[ curr_name ].var_c50f749e8cfd5137 )
            {
                var_ee583b17d60ffe56[ curr_name ].var_c50f749e8cfd5137 = isdefined( level.sakura_root.all_trees[ curr_name ].var_c50f749e8cfd5137 );
                b_update_guidance = 1;
            }
        }
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( var_99d33e2b7396290[ i ] && !level.players[ i ] utility::ent_flag( "skr_buff" ) || !var_99d33e2b7396290[ i ] && level.players[ i ] utility::ent_flag( "skr_buff" ) )
            {
                var_99d33e2b7396290[ i ] = level.players[ i ] utility::ent_flag( "skr_buff" );
                b_update_guidance = 1;
            }
        }
        
        if ( b_update_guidance )
        {
            level function_ecc91637c2a6fbb1();
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x9d931e86, Offset: 0x1d634
// Size: 0xa9
function function_f94649487d31572e( spawn_struct_or_ent, shard_bit_index = undefined )
{
    var_4b6319d4eaeb0942 = spawnscriptable( %"hash_14ca78785cc15d00", spawn_struct_or_ent.origin, spawn_struct_or_ent.angles );
    
    if ( isdefined( shard_bit_index ) )
    {
        var_4b6319d4eaeb0942.shard_bit_index = shard_bit_index;
    }
    
    if ( level.directed_mode || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        var_4b6319d4eaeb0942 utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_guided" );
    }
    else
    {
        var_4b6319d4eaeb0942 utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_standard" );
    }
    
    return var_4b6319d4eaeb0942;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2ba6ad29, Offset: 0x1d6e6
// Size: 0x2a2
function function_11b2073d4c4e8310( var_d0361b1d8c7f1ba3 )
{
    var_7ae3d9c853414295 = 4;
    shard_mdl = %"sat_zm_sake_cup_chip";
    var_73dad4f976e77991 = 0.5;
    var_d0fc8dd989cf48f1 = 2;
    var_d11f9fd989f5b83f = 7;
    playsoundatpos( var_d0361b1d8c7f1ba3.origin, "evt_mq_ceramic_cup_break" );
    all_shards = [];
    main_shard = spawnscriptable( %"hash_14ca78785cc15d00", var_d0361b1d8c7f1ba3.origin, var_d0361b1d8c7f1ba3.angles );
    main_shard utility::function_7c10ea82c1e305b8( "model", "base_directed" );
    var_7d2113d9b9d33446 = utility::spawn_model( "tag_origin", var_d0361b1d8c7f1ba3.origin, var_d0361b1d8c7f1ba3.angles );
    all_shards[ all_shards.size ] = var_7d2113d9b9d33446;
    
    for ( i = 0; i < var_7ae3d9c853414295 ; i++ )
    {
        var_4b6319d4eaeb0942 = utility::spawn_model( shard_mdl, var_d0361b1d8c7f1ba3.origin, ( randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ), randomfloatrange( -360, 360 ) ) );
        var_4b6319d4eaeb0942 hudoutlineenable( "shimmer_default" );
        all_shards[ all_shards.size ] = var_4b6319d4eaeb0942;
    }
    
    waitframe();
    main_shard utility::scriptable_setparententity( var_7d2113d9b9d33446 );
    
    foreach ( var_4b6319d4eaeb0942 in all_shards )
    {
        radius = randomfloatrange( var_d0fc8dd989cf48f1, var_d11f9fd989f5b83f );
        var_c23a8cb334b43f16 = utility::function_8ae0ea62537eafc5( var_d0361b1d8c7f1ba3.origin, radius, 0 );
        control_pos = ( var_d0361b1d8c7f1ba3.origin + var_c23a8cb334b43f16 ) / 2 + ( 0, 0, 10 );
        var_4b6319d4eaeb0942 thread utility::function_8001268940441423( var_4b6319d4eaeb0942.origin, var_c23a8cb334b43f16, control_pos, var_73dad4f976e77991 );
    }
    
    wait var_73dad4f976e77991;
    var_b9cac5f1a122b15d = level zm_quest::function_b0a5181ebe7bb905() ? 1 : 0;
    
    if ( var_b9cac5f1a122b15d )
    {
        main_shard utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_guided" );
    }
    else
    {
        main_shard utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_standard" );
    }
    
    main_shard utility::scriptable_clearparententity();
    var_7d2113d9b9d33446 delete();
    all_shards = function_5713d46873b29625( all_shards );
    level.hornet_mq.var_91b0d39e821f536e = all_shards;
    return main_shard;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xed0361ef, Offset: 0x1d991
// Size: 0x2b8
function function_4b1fb87387d01647()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level.hornet_mq.var_4f641d5d0ca98ee7 = utility::getstruct( "knts_puzzle_interact", "targetname" );
    level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd = [];
    var_dd4f64c5a98cbcce = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6" ) ?? 0;
    
    if ( !utility::get_bit_flag( var_dd4f64c5a98cbcce, 0 ) )
    {
        shard_loc = utility::getstruct( "knts_shard_spawn", "targetname" );
        level.hornet_mq.shogun_shard = level function_f94649487d31572e( shard_loc, 0 );
    }
    
    if ( var_dd4f64c5a98cbcce )
    {
        level function_9947038abd0d1056( #"hash_46cb4c18e27f9240" );
        level utility::flag_set( "mq_got_cer_shrd" );
    }
    
    level.hornet_mq.var_4f641d5d0ca98ee7.a_shards = getentitylessscriptablearray( "kintsugi_shard_ambient", #targetname );
    
    foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
    {
        var_204ea7f9ea2acbd1 = sbl_shard.script_noteworthy;
        
        if ( !var_204ea7f9ea2acbd1 )
        {
            sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
            level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd[ level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd.size ] = sbl_shard;
            continue;
        }
        
        sbl_shard utility::function_7c10ea82c1e305b8( "model", var_204ea7f9ea2acbd1 );
    }
    
    if ( utility::get_bit_flag( var_dd4f64c5a98cbcce, 0 ) )
    {
        level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd[ 0 ] utility::function_7c10ea82c1e305b8( "model", "base" );
    }
    
    if ( utility::get_bit_flag( var_dd4f64c5a98cbcce, 1 ) )
    {
        level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd[ 1 ] utility::function_7c10ea82c1e305b8( "model", "base" );
    }
    
    level function_2c94bcdee510f3a0();
    level utility::flag_set( "mq_kintsugi_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb002e068, Offset: 0x1dc51
// Size: 0x7d
function function_2ed7c5fbeb746fd0()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    var_dd4f64c5a98cbcce = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6" ) ?? 0;
    
    if ( !utility::get_bit_flag( var_dd4f64c5a98cbcce, 1 ) )
    {
        shard_loc = utility::getstruct( "knts_shard_spawn_2", "targetname" );
        var_4b6319d4eaeb0942 = level function_f94649487d31572e( shard_loc, 1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x2d438fff, Offset: 0x1dcd6
// Size: 0x8a
function function_2c94bcdee510f3a0()
{
    level.hornet_mq.var_4f641d5d0ca98ee7.interact = interaction::register_interact( level.hornet_mq.var_4f641d5d0ca98ee7.origin, 80, &function_b190f8cb34e9a64e, &function_713376e8c220debb );
    level.hornet_mq.var_4f641d5d0ca98ee7.interact.root = level.hornet_mq.var_4f641d5d0ca98ee7;
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x236cd40a, Offset: 0x1dd68
// Size: 0x24f
function function_ba82c5ccc4f941d6( instance, part, state, player, bautouse, usestring )
{
    instance utility::function_7c10ea82c1e305b8( "usable", "disabled" );
    var_dd4f64c5a98cbcce = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6" ) ?? 0;
    
    if ( isdefined( instance.shard_bit_index ) && !utility::get_bit_flag( var_dd4f64c5a98cbcce, instance.shard_bit_index ) )
    {
        var_dd4f64c5a98cbcce = utility::set_bit_flag( var_dd4f64c5a98cbcce, instance.shard_bit_index );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6", var_dd4f64c5a98cbcce );
        level utility::flag_set( "mq_got_cer_shrd" );
    }
    
    if ( isdefined( instance.shard_bit_index ) )
    {
        level.hornet_mq.var_4f641d5d0ca98ee7.var_e2badefa1e96aadd[ instance.shard_bit_index ] utility::function_7c10ea82c1e305b8( "model", "base" );
    }
    
    if ( level.directed_mode && level utility::flag( "mq_inv_locs_started" ) )
    {
        level.hornet_mq.var_c44feadec8f65180 = undefined;
        level function_ecc91637c2a6fbb1();
    }
    
    if ( isdefined( level.hornet_mq.var_91b0d39e821f536e ) && level.hornet_mq.var_91b0d39e821f536e.size > 0 )
    {
        foreach ( var_4b6319d4eaeb0942 in level.hornet_mq.var_91b0d39e821f536e )
        {
            var_4b6319d4eaeb0942 delete();
        }
        
        level.hornet_mq.var_91b0d39e821f536e = undefined;
    }
    
    level function_b838fb7a5ac512b9( player );
    instance utility::function_7c10ea82c1e305b8( "audio", "pickup" );
    instance utility::delaycall( level.framedurationseconds, &freescriptable );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x83c82154, Offset: 0x1dfbf
// Size: 0xc9
function function_b838fb7a5ac512b9( gathering_player )
{
    var_dd4f64c5a98cbcce = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_e8d0ebab9c9c69e6" ) ?? 0;
    
    if ( utility::get_bit_flag( var_dd4f64c5a98cbcce, 0 ) && utility::get_bit_flag( var_dd4f64c5a98cbcce, 1 ) )
    {
        gathering_player thread function_2a6deff157d1165a( #"hash_5a2d422e24cf11d3", #"bc_flavor_player_positive", 0.25 );
        level function_9947038abd0d1056( #"hash_46cb4c18e27f9240", gathering_player, 3 );
        level utility::flag_set( "mq_step_21_complete" );
    }
    else
    {
        gathering_player thread function_2a6deff157d1165a( undefined, #"hash_5212ed7ec42f115a", 0.25 );
        level function_9947038abd0d1056( #"hash_46cb4c18e27f9240", gathering_player, 2 );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7b5b0a75, Offset: 0x1e090
// Size: 0x56
function function_b190f8cb34e9a64e( player )
{
    self makeunusable();
    
    if ( !level utility::flag( "mq_step_21_complete" ) )
    {
        self makeusable();
        return;
    }
    
    var_4519b2f8f8bb3ec2 = function_3bc6c7caaae12576( player );
    
    if ( !var_4519b2f8f8bb3ec2 )
    {
        self makeusable();
        return;
    }
    
    level function_f73b51666ff4888e( player );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x1bdf7301, Offset: 0x1e0ee
// Size: 0x9d
function function_713376e8c220debb( usable, player )
{
    if ( level.directed_mode && level utility::flag( "mq_step_21_complete" ) && !level utility::flag( "knts_holding_interact" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3ead4b16ffb72621", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x3fbfd62e, Offset: 0x1e193
// Size: 0x1ce
function function_f73b51666ff4888e( player = undefined )
{
    cup_loc = utility::getstruct( "knts_puzzle_interact", "targetname" );
    level.hornet_mq.s_cup = {};
    level.hornet_mq.s_cup.sbl = spawnscriptable( %"hash_5749a765462049d6", cup_loc.origin, cup_loc.angles );
    level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "visual", "repaired" );
    level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "fx", "repaired" );
    
    foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
    {
        sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
    }
    
    if ( player )
    {
        player thread function_2a6deff157d1165a( #"hash_1489e1ca1a4dcea9", #"hash_5212ed7ec42f115a", 0.5 );
    }
    
    if ( level utility::flag( "mq_inv_locs_started" ) )
    {
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_873f70958c2da305", 14 );
    }
    
    level thread function_fcbf31e6325f57f1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6a5e192e, Offset: 0x1e369
// Size: 0x112
function function_fcbf31e6325f57f1()
{
    level function_ecc91637c2a6fbb1();
    level waittill( #"on_round_start" );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_873f70958c2da305", 1 );
    
    if ( level utility::flag( "mq_inv_locs_started" ) )
    {
        if ( level.hornet_mq.s_cup.sbl )
        {
            level.hornet_mq.s_cup.sbl freescriptable();
        }
        
        cup_loc = utility::getstruct( "knts_puzzle_interact", "targetname" );
        level.hornet_mq.s_cup = {};
        level.hornet_mq.s_cup.sbl = spawnscriptable( %"hash_5749a765462049d6", cup_loc.origin, cup_loc.angles );
        level thread function_c06753a78b2f3984();
    }
    
    level utility::flag_set( "mq_step_22_complete" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x800fa1a6, Offset: 0x1e483
// Size: 0x20e
function function_3bc6c7caaae12576( player )
{
    level utility::flag_set( "knts_holding_interact" );
    level.hornet_mq.var_4f641d5d0ca98ee7.a_shards = getentitylessscriptablearray( "kintsugi_shard_ambient", #targetname );
    
    foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
    {
        var_204ea7f9ea2acbd1 = sbl_shard.script_noteworthy;
        
        if ( !isdefined( var_204ea7f9ea2acbd1 ) )
        {
            var_204ea7f9ea2acbd1 = "base";
        }
        
        sbl_shard utility::function_7c10ea82c1e305b8( "model", var_204ea7f9ea2acbd1 );
        sbl_shard utility::function_7c10ea82c1e305b8( "anim", "start_jitter" );
    }
    
    params = { #save_progress:0, #use_object:self, #hold_time:4, #hud_description:&"hash_62f32b6984697787", #craft_reason:#"hash_1a041bcd5ff1c742" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
    {
        sbl_shard utility::function_7c10ea82c1e305b8( "anim", "return_to_start" );
    }
    
    level utility::flag_clear( "knts_holding_interact" );
    return result;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x75e64df, Offset: 0x1e69a
// Size: 0x60d
function function_56733592b8210253()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "mq_kintsugi_setup_complete" );
    level utility::flag_wait( "scriptables_ready" );
    cup_state = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_873f70958c2da305" );
    var_ac2b716086a7d3fd = utility::getstructarray( "mq_inves_loc", "targetname" );
    
    if ( !isdefined( cup_state ) )
    {
        return;
    }
    
    level thread function_6e5fb74e5532d2e8( cup_state );
    
    if ( cup_state >= 20 )
    {
        waitframe();
        level utility::flag_clear( "mq_got_scup" );
        level utility::flag_set( "mq_inv_locs_started" );
        level.hornet_mq.var_4f641d5d0ca98ee7.interact makeusable();
        
        if ( cup_state == 24 )
        {
        }
        else
        {
            level utility::flag_clear( "mq_step_22_complete" );
            level utility::flag_clear( "mq_inv_loc_succeeded" );
            
            foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
            {
                sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
            }
            
            if ( cup_state == 21 )
            {
                var_fa2f112f6c745733 = "zone_main_keep_wall_jump_zone_02";
            }
            else if ( cup_state == 22 )
            {
                var_fa2f112f6c745733 = "zone_main_keep_2nd_floor_c";
            }
            else
            {
                var_fa2f112f6c745733 = "zone_broken_turrets_d";
            }
            
            foreach ( loc in var_ac2b716086a7d3fd )
            {
                if ( loc.script_noteworthy == var_fa2f112f6c745733 )
                {
                    target_loc = loc;
                    break;
                }
            }
            
            s_spawner = { #origin:target_loc.origin + ( 0, 0, 30 ) };
            level function_11b2073d4c4e8310( s_spawner );
        }
    }
    else if ( cup_state >= 10 )
    {
        waitframe();
        level utility::flag_clear( "mq_got_scup" );
        level utility::flag_set( "mq_inv_locs_started" );
        
        foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
        {
            sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
        }
        
        if ( cup_state == 14 )
        {
            level function_f73b51666ff4888e();
        }
        else
        {
            level utility::flag_wait( "mq_investigate_loc_setup_complete" );
            
            if ( cup_state == 11 )
            {
                var_fa2f112f6c745733 = "zone_main_keep_wall_jump_zone_02";
            }
            else if ( cup_state == 12 )
            {
                var_fa2f112f6c745733 = "zone_main_keep_2nd_floor_c";
            }
            else
            {
                var_fa2f112f6c745733 = "zone_broken_turrets_d";
            }
            
            foreach ( loc in var_ac2b716086a7d3fd )
            {
                if ( loc.script_noteworthy == var_fa2f112f6c745733 )
                {
                    target_loc = loc;
                    break;
                }
            }
            
            level.hornet_mq.defend_cup = spawnscriptable( %"hash_5749a765462049d6", target_loc.origin, target_loc.angles );
            level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "visual", "item" );
            
            if ( level zm_quest::function_b0a5181ebe7bb905() )
            {
                level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_guide" );
            }
            else
            {
                level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_standard" );
            }
        }
    }
    else if ( cup_state == 2 )
    {
        level function_9947038abd0d1056( #"hash_46cb4c18e27f9240", undefined, 4 );
        level utility::flag_set( "mq_got_scup" );
        level utility::flag_set( "mq_step_24_complete" );
        level utility::flag_set( "mq_inv_locs_started" );
        
        foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
        {
            sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
        }
    }
    else
    {
        foreach ( sbl_shard in level.hornet_mq.var_4f641d5d0ca98ee7.a_shards )
        {
            sbl_shard utility::function_7c10ea82c1e305b8( "model", "off" );
        }
        
        waitframe();
        
        if ( !level utility::flag( "mq_step_23_complete" ) )
        {
            level setup_sake_cup();
        }
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x2645f0f1, Offset: 0x1ecaf
// Size: 0x2b5
function function_6e5fb74e5532d2e8( cup_state )
{
    level utility::flag_wait( "mq_investigate_loc_setup_complete" );
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    
    foreach ( investigate_loc in level.hornet_mq.investigate_locs )
    {
        item_ref = undefined;
        
        if ( investigate_loc.script_noteworthy == "zone_main_keep_wall_jump_zone_02" )
        {
            var_46d396204d211489 = 8;
            
            if ( !utility::get_bit_flag( gathered_evidence, 10 ) )
            {
                item_ref = %"hash_1e3143f8a7c1e6c8";
                target_loc = investigate_loc;
                
                if ( cup_state == 11 )
                {
                    var_ff2f45c6e6205cb4 = item_ref;
                }
            }
        }
        else if ( investigate_loc.script_noteworthy == "zone_main_keep_2nd_floor_c" )
        {
            var_46d396204d211489 = 9;
            
            if ( !utility::get_bit_flag( gathered_evidence, 11 ) )
            {
                item_ref = %"hash_58ee983cf15bea95";
                target_loc = investigate_loc;
                
                if ( cup_state == 12 )
                {
                    var_ff2f45c6e6205cb4 = item_ref;
                }
            }
        }
        else if ( investigate_loc.script_noteworthy == "zone_broken_turrets_d" )
        {
            var_46d396204d211489 = 10;
            
            if ( !utility::get_bit_flag( gathered_evidence, 9 ) )
            {
                item_ref = %"hash_6d90e79d6ed53dc0";
                target_loc = investigate_loc;
                
                if ( cup_state == 13 )
                {
                    var_ff2f45c6e6205cb4 = item_ref;
                }
            }
        }
        
        if ( utility::get_bit_flag( var_181bfe57b6b9d727, var_46d396204d211489 ) )
        {
            investigate_loc.var_2389aa3c5f35b020 = 1;
            investigate_loc.interact makeunusable();
            level.hornet_mq.var_f47b6e6966ed4cdf += 1;
            
            if ( item_ref )
            {
                item = level mq_spawn_item( item_ref, target_loc.evidence_loc.origin, target_loc.evidence_loc.angles );
            }
            
            if ( item && var_ff2f45c6e6205cb4 && var_ff2f45c6e6205cb4 == item_ref )
            {
                level utility::flag_set( "mq_inv_loc_succeeded" );
                level.hornet_mq.revealed_items = [ level.hornet_mq.defend_cup, item ];
            }
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xe7c92515, Offset: 0x1ef6c
// Size: 0x1c9
function setup_sake_cup()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level.directed_mode )
    {
        level utility::flag_wait( "mq_directed_revealed_screen_poi" );
    }
    
    if ( level.hornet_mq.s_cup.sbl )
    {
        level.hornet_mq.s_cup.sbl freescriptable();
    }
    
    cup_loc = utility::getstruct( "knts_puzzle_interact", "targetname" );
    level.hornet_mq.s_cup = {};
    level.hornet_mq.s_cup.sbl = spawnscriptable( %"hash_5749a765462049d6", cup_loc.origin, cup_loc.angles );
    level.hornet_mq.s_cup.attract_audio = spawnscriptable( %"zm_sat_hornet_mq_memory", cup_loc.origin, ( 0, 0, 0 ) );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_trigger_mem_guide" );
    }
    else
    {
        level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_trigger_mem_standard" );
    }
    
    level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "visual", "memory" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf439c414, Offset: 0x1f13d
// Size: 0xb1
function function_c06753a78b2f3984()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_guide" );
    }
    else
    {
        level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_standard" );
    }
    
    level.hornet_mq.s_cup.sbl utility::function_7c10ea82c1e305b8( "visual", "item" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0xe5909c84, Offset: 0x1f1f6
// Size: 0x1e6
function function_778c2d8f2240c88a( instance, part, state, player, bautouse, usestring )
{
    instance utility::function_7c10ea82c1e305b8( "usable", "disabled" );
    
    if ( level.hornet_mq.s_cup.attract_audio )
    {
        level.hornet_mq.s_cup.attract_audio freescriptable();
    }
    
    if ( issubstr( state, "enabled_trigger_mem" ) )
    {
        level.hornet_mq.memory_cup = instance;
        trig = getent( "mq_mem_loc_trig", #targetname );
        level play_memory( "memory_loc", 1, trig );
        st_intel_name = "zmintel_sat_hornet_audiolog_4";
        spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
        level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
        player thread function_2a6deff157d1165a( #"hash_c0aa455de8c5fb08", #"hash_5212ed7ec42f115a", 0.5 );
        level utility::flag_set( "mq_step_23_complete" );
        level function_ecc91637c2a6fbb1();
        instance freescriptable();
        return;
    }
    
    level function_9947038abd0d1056( #"hash_46cb4c18e27f9240", player, 4 );
    level utility::flag_set( "mq_got_scup" );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_873f70958c2da305", 2 );
    level utility::flag_set( "mq_step_24_complete" );
    sound_pos = instance.origin;
    playsoundatpos( sound_pos, "evt_mq_evidence_cup_pickup" );
    instance freescriptable();
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd98a9494, Offset: 0x1f3e4
// Size: 0x16d
function setup_investigate_locs()
{
    investigate_locs = utility::getstructarray( "mq_inves_loc", "targetname" );
    
    foreach ( loc in investigate_locs )
    {
        loc.var_2389aa3c5f35b020 = 0;
        loc.evidence_loc = utility::getstruct( loc.target, "targetname" );
        loc.zone = loc.script_noteworthy;
        loc.var_8133ea3bbadb0bc9 = loc.evidence_loc.script_noteworthy;
        loc.interact = interaction::register_interact( loc.origin, 80, &function_838f2e0513559599, &investigate_hint_callback );
        loc.interact.root = loc;
    }
    
    level.hornet_mq.investigate_locs = investigate_locs;
    level.hornet_mq.var_f47b6e6966ed4cdf = 0;
    level utility::flag_set( "mq_investigate_loc_setup_complete" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x380d980e, Offset: 0x1f559
// Size: 0xe8
function function_838f2e0513559599( player )
{
    if ( !level utility::flag( "mq_got_scup" ) )
    {
        return;
    }
    
    if ( self.root.var_2389aa3c5f35b020 )
    {
        return;
    }
    
    if ( isdefined( level.directed_mode ) )
    {
        if ( isdefined( level.hornet_mq.revealed_items ) )
        {
            level.hornet_mq.revealed_items = function_5713d46873b29625( level.hornet_mq.revealed_items );
            
            if ( level.hornet_mq.revealed_items && level.hornet_mq.revealed_items.size > 0 )
            {
                return;
            }
        }
    }
    
    self makeunusable();
    level utility::flag_clear( "mq_got_scup" );
    player thread function_2a6deff157d1165a( #"hash_9e2204831d5c3620", undefined, 0.5 );
    level thread function_a5cf84eddb61ecd4( self );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x65f32395, Offset: 0x1f649
// Size: 0x8c
function investigate_hint_callback( usable, player )
{
    if ( level.directed_mode && level utility::flag( "mq_got_scup" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3a2c46a07aaadc57", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6ff2d920, Offset: 0x1f6dd
// Size: 0x631
function function_a5cf84eddb61ecd4( parent_interact )
{
    defend_loc = parent_interact.root.origin;
    defend_ang = parent_interact.root.angles;
    
    switch ( parent_interact.root.script_noteworthy )
    {
        case #"hash_c72c4d3743ed7daf":
            skvp = 11;
            break;
        case #"hash_b1cf54afa7137f77":
            skvp = 12;
            break;
        case #"hash_64c87649c671edc2":
            skvp = 13;
            break;
        default:
            skvp = 14;
            break;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_873f70958c2da305", skvp );
    level utility::flag_set( "hornet_mq_blocking_horse_ee" );
    
    if ( !utility::flag( "mq_inv_locs_started" ) )
    {
        level utility::flag_set( "mq_inv_locs_started" );
    }
    
    level utility::flag_set( "mq_inv_loc_active" );
    level utility::flag_clear( "hornet_mq_investigate_defend_ended" );
    level.hornet_mq.defend_cup = spawnscriptable( %"hash_5749a765462049d6", defend_loc, defend_ang );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "on" );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "visual", "repaired" );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "audio", "investigate" );
    level.hornet_mq.defend_cup thread function_363cad07761d477a( defend_loc );
    e_attractor = utility::spawn_tag_origin( defend_loc, ( 0, 0, 0 ) );
    e_attractor.health = 999999;
    e_attractor.allowdeath = 0;
    e_attractor setcandamage( 1 );
    e_attractor = zombie_attractor_manager::add_attractor( e_attractor, 3, undefined, 1 );
    zombie_attractor_manager::function_a2aab3762aaa055f( e_attractor, defend_loc + ( 0, 0, 30 ), ( 32, 32, 32 ), defend_ang );
    
    if ( level.hornet_mq.var_f47b6e6966ed4cdf == 0 )
    {
        level thread function_83c81d6af6932677( defend_loc, [ parent_interact.root.script_noteworthy ], [ [ "zombie_base", 4, 1 ], [ "zombie_base_armored_light", 2, 1.5 ], [ "zombie_base_armored_agni", 3, 3.5 ] ], [ [ "zombie_base", 7, 0.85 ], [ "zombie_base_armored_light", 4, 1 ], [ "zombie_base_armored_agni", 5, 2 ] ] );
    }
    else if ( level.hornet_mq.var_f47b6e6966ed4cdf == 1 )
    {
        level thread function_83c81d6af6932677( defend_loc, [ parent_interact.root.script_noteworthy ], [ [ "zombie_base_armored_heavy", 2, 3 ], [ "zombie_base_armored_light", 6, 1 ], [ "zombie_hellhound", 1, 5 ] ], [ [ "zombie_base_armored_heavy", 4, 2 ], [ "zombie_base_armored_light", 7, 1 ], [ "zombie_hellhound", 2, 3 ] ] );
    }
    else
    {
        level thread function_83c81d6af6932677( defend_loc, [ parent_interact.root.script_noteworthy ], [ [ "zombie_base", 6, 1 ], [ "zombie_base_armored_light", 3, 1 ], [ "zombie_base_armored_heavy", 2, 1 ] ], [ [ "zombie_base", 8, 0.5 ], [ "zombie_base_armored_light", 4, 0.8 ], [ "zombie_base_armored_heavy", 3, 1 ] ] );
    }
    
    level function_ecc91637c2a6fbb1();
    time_elapsed = 0;
    step = 0.1;
    var_fb2f98f9e8f799fa = e_attractor.source.health;
    num_hits = 0;
    
    while ( time_elapsed <= 15 )
    {
        if ( level.hornet_mq.var_f47b6e6966ed4cdf + 1 >= 3 && time_elapsed > 5 )
        {
            var_75247c60c985c835 = 1;
            break;
        }
        
        if ( var_fb2f98f9e8f799fa != e_attractor.source.health )
        {
            var_fb2f98f9e8f799fa = e_attractor.source.health;
            level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "damage_audio", "hit" );
            num_hits += 1;
        }
        
        if ( e_attractor.source.health <= 0 || num_hits >= 3 )
        {
            var_3a7db1d265d18c10 = 1;
            break;
        }
        
        wait step;
        time_elapsed += step;
    }
    
    zombie_attractor_manager::remove_attractor( e_attractor );
    
    if ( !var_75247c60c985c835 )
    {
        level utility::flag_set( "hornet_mq_investigate_defend_ended" );
    }
    
    level function_b8d00f1073273fa5( var_3a7db1d265d18c10, level.hornet_mq.defend_cup, parent_interact );
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0x9fe99fe7, Offset: 0x1fd16
// Size: 0x12f
function function_83c81d6af6932677( defend_loc, var_1c8e72b84f32c5d5, var_54a5b18a6968f72, var_54032c0c91f8f352 )
{
    level endon( #"hornet_mq_investigate_defend_ended" );
    search_radius = 950;
    var_586d08786c9e84f8 = level.players.size > 1 ? 1 : 0;
    var_c2232852fe3df305 = var_586d08786c9e84f8 ? 22 : 15;
    var_4db281afd81246b9 = getaiarrayinradius( defend_loc, search_radius );
    
    if ( var_4db281afd81246b9.size >= var_c2232852fe3df305 )
    {
        return;
    }
    
    level.hornet_mq.var_2413fe7cedab8358 = [];
    var_289d532001cac3ee = var_586d08786c9e84f8 ? var_54032c0c91f8f352 : var_54a5b18a6968f72;
    
    foreach ( var_5e422986322a015 in var_289d532001cac3ee )
    {
        childthread function_f41939f47420dd0a( var_1c8e72b84f32c5d5, var_5e422986322a015 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xeb69e81f, Offset: 0x1fe4d
// Size: 0x192
function function_f41939f47420dd0a( var_1c8e72b84f32c5d5, var_5e422986322a015 )
{
    subclass = var_5e422986322a015[ 0 ];
    max_num_zoms = var_5e422986322a015[ 1 ];
    var_ca27f2becbe427c1 = var_5e422986322a015[ 2 ];
    spawn_params = {};
    spawn_params.round_override = 20;
    spawn_params.var_241efc7b886a40e2 = "sprint";
    level.hornet_mq.var_2413fe7cedab8358[ subclass ] = 0;
    
    while ( true )
    {
        if ( level.hornet_mq.var_2413fe7cedab8358[ subclass ] >= max_num_zoms )
        {
            waitframe();
            continue;
        }
        
        for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ) )
        {
            waitframe();
        }
        
        zone = utility::array_random( var_1c8e72b84f32c5d5 );
        zombie = function_89266a24d0006d65( subclass, zone, spawn_params );
        
        if ( !isdefined( zombie ) )
        {
            continue;
        }
        
        zombie.ignore_enemy_count = 1;
        level.hornet_mq.var_2413fe7cedab8358[ subclass ] += 1;
        zombie callback::add( "on_zombie_ai_killed", &function_30249e89b49224ec );
        zombie.var_c990c4c145ba59b8 = 1;
        throttle::throttle_wait_in_queue( level.hornet_mq.throttle, zombie );
        wait var_ca27f2becbe427c1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x68f8aee0, Offset: 0x1ffe7
// Size: 0x6d
function function_30249e89b49224ec( params )
{
    if ( !isdefined( level.hornet_mq.var_2413fe7cedab8358[ self.subclass ] ) )
    {
        return;
    }
    
    level.hornet_mq.var_2413fe7cedab8358[ self.subclass ] -= 1;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x770e8e66, Offset: 0x2005c
// Size: 0xdf
function function_abb896fecea8c018( origin )
{
    wait 1;
    nearby_zoms = getaiarrayinradius( origin, 1000 );
    
    foreach ( zom in nearby_zoms )
    {
        if ( zom.var_c990c4c145ba59b8 )
        {
            throttle::throttle_wait_in_queue( level.hornet_mq.throttle, zom );
            zom.forceannihilate = 1;
            zom.var_a13bed1ac47e1b2c = 1;
            zom zm_utility::function_5bbd540197e3fd( undefined, undefined, undefined, undefined, 0 );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xadcfff0c, Offset: 0x20143
// Size: 0x125
function function_b3fb3decd26dcf46( origin )
{
    var_78ce88f2e7b25639 = getaiarrayinradius( origin, 800 );
    var_78ce88f2e7b25639 = arrayremove( var_78ce88f2e7b25639, level.hornet_mq.chase_hellhound );
    
    foreach ( zom in var_78ce88f2e7b25639 )
    {
        throttle::throttle_wait_in_queue( level.hornet_mq.throttle, zom );
        
        if ( !isalive( zom ) || zom.magic_bullet_shield || zom.damageshield )
        {
            continue;
        }
        
        if ( !zom.var_c990c4c145ba59b8 )
        {
            zom zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        zom.forceannihilate = 1;
        zom.var_a13bed1ac47e1b2c = 1;
        zom kill();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xa2d32f6e, Offset: 0x20270
// Size: 0x176
function function_363cad07761d477a( var_c23a8cb334b43f16 )
{
    level endon( #"hash_190a8b66be92fff5" );
    var_9fe0f1d6f77c7315 = 36;
    mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( mover ) )
    {
        return;
    }
    
    if ( isdefined( self.linkedparent ) )
    {
        parent = self.linkedparent;
        utility::scriptable_clearparententity();
        parent delete();
    }
    
    level utility::flag_clear( "hornet_mq_cup_movement_stopped" );
    utility::scriptable_setparententity( mover );
    mover rotateyaw( 2160, 3, 3 );
    mover moveto( self.origin + ( 0, 0, var_9fe0f1d6f77c7315 ), 3, 1, 0.5 );
    mover waittill( #"movedone" );
    move_dir = -1;
    
    while ( true )
    {
        if ( level utility::flag( "hornet_mq_investigate_defend_ended" ) )
        {
            break;
        }
        
        mover movez( 12 * move_dir, 2, 0.5, 0.5 );
        mover rotateyaw( 1440, 2 );
        mover waittill( #"movedone" );
        move_dir *= -1;
    }
    
    mover rotateyaw( 2160, 3, 0, 3 );
    mover moveto( var_c23a8cb334b43f16, 3, 0.5, 1 );
    mover waittill( #"movedone" );
    level utility::flag_set( "hornet_mq_cup_movement_stopped" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0xf3d92643, Offset: 0x203ee
// Size: 0x551
function function_b8d00f1073273fa5( var_3a7db1d265d18c10, cup, parent_interact )
{
    level utility::flag_clear( "mq_inv_loc_active" );
    
    if ( var_3a7db1d265d18c10 )
    {
        level notify( #"hash_190a8b66be92fff5" );
        level thread function_abb896fecea8c018( cup.origin );
        
        if ( !level.hornet_mq.var_4f641d5d0ca98ee7.interact )
        {
            level function_2c94bcdee510f3a0();
        }
        else
        {
            level.hornet_mq.var_4f641d5d0ca98ee7.interact makeusable();
        }
        
        level.hornet_mq.var_c44feadec8f65180 = level function_11b2073d4c4e8310( cup );
        
        switch ( parent_interact.root.script_noteworthy )
        {
            case #"hash_c72c4d3743ed7daf":
                skvp = 21;
                break;
            case #"hash_b1cf54afa7137f77":
                skvp = 22;
                break;
            case #"hash_64c87649c671edc2":
                skvp = 23;
                break;
            default:
                skvp = 24;
                break;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_873f70958c2da305", skvp );
        
        if ( level.directed_mode )
        {
            level utility::flag_clear( "mq_step_22_complete" );
            level utility::flag_clear( "mq_inv_loc_succeeded" );
            level function_ecc91637c2a6fbb1();
        }
        
        nearby_players = getplayersinradius( cup.origin, 600 );
        level thread function_490cc449b7de9830( [ #"hash_ff07c5c74c393a8e", #"hash_ff07c4c74c3938db" ], nearby_players, 0.5, 1 );
        cup utility::function_7c10ea82c1e305b8( "fx", "break" );
        waitframe();
        cup freescriptable();
        parent_interact makeusable();
        level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "off" );
        level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
        return;
    }
    
    level utility::flag_set( "mq_inv_loc_succeeded" );
    level thread function_abb896fecea8c018( cup.origin );
    parent_interact.root.var_2389aa3c5f35b020 = 1;
    level.hornet_mq.var_f47b6e6966ed4cdf += 1;
    
    if ( level.hornet_mq.var_f47b6e6966ed4cdf < 3 )
    {
        switch ( parent_interact.root.var_8133ea3bbadb0bc9 )
        {
            case #"hash_4580372509891086":
                item = %"hash_58ee983cf15bea95";
                skvp = 9;
                break;
            case #"hash_13894b2d73f9873f":
                item = %"hash_6d90e79d6ed53dc0";
                skvp = 10;
                break;
            case #"hash_5b73f98f5259d72f":
                item = %"hash_1e3143f8a7c1e6c8";
                skvp = 8;
                break;
        }
        
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, skvp );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
        level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "off" );
        level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "visual", "item" );
        end_pos = utility::drop_to_ground( parent_interact.root.evidence_loc.origin, 0 );
        
        if ( !isdefined( end_pos ) )
        {
            end_pos = parent_interact.root.evidence_loc.origin - ( 0, 0, 48 );
        }
        
        level function_8f370c37e2e751f2( cup.origin, end_pos, 0, 1, "sake_charge" );
        item = level mq_spawn_item( item, parent_interact.root.evidence_loc.origin, parent_interact.root.evidence_loc.angles );
        mask_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", end_pos, ( 0, 0, 0 ) );
        mask_fx utility::function_7c10ea82c1e305b8( "impact", "dust_impact" );
        mask_fx utility::delaycall( 1, &freescriptable );
        level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
    }
    else
    {
        level thread function_cb4ebbef4a10ab45( parent_interact, cup );
    }
    
    level function_3582825f5c626855();
    level utility::flag_wait( "hornet_mq_cup_movement_stopped" );
    
    if ( !level utility::flag( "mq_step_25_complete" ) )
    {
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            cup utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_guide" );
        }
        else
        {
            cup utility::function_7c10ea82c1e305b8( "usable", "enabled_pickup_standard" );
        }
    }
    
    level.hornet_mq.revealed_items = [ cup, item ];
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x9d5ad15f, Offset: 0x20947
// Size: 0x59b
function function_cb4ebbef4a10ab45( parent_interact, cup )
{
    level endon( #"game_ended" );
    level.hornet_mq.var_71ac555879808712 = {};
    level.hornet_mq.var_71ac555879808712.var_8133ea3bbadb0bc9 = parent_interact.root.var_8133ea3bbadb0bc9;
    interact_copy = {};
    interact_copy.root = structcopy( parent_interact.root, 1 );
    level.hornet_mq.var_30278ba7270a73e2 = interact_copy;
    level utility::flag_set( "mq_step_25_complete" );
    var_5062251c0b2ec7bd = 30;
    time_elapsed = 0;
    var_b53c799cdd5f52a9 = 32400;
    var_2883e8a586d0f079 = 52900;
    
    while ( true )
    {
        if ( isdefined( level.hornet_mq.chase_hellhound ) )
        {
            var_cb55529c0f61fa1c = distance2dsquared( level.hornet_mq.chase_hellhound.origin, parent_interact.root.evidence_loc.origin );
            
            if ( var_cb55529c0f61fa1c <= var_2883e8a586d0f079 && !level utility::flag( "hornet_mq_hellhound_chase_zoms_cleared" ) )
            {
                level utility::flag_set( "hornet_mq_hellhound_chase_zoms_cleared" );
                level thread function_b3fb3decd26dcf46( parent_interact.root.evidence_loc.origin );
            }
            
            if ( var_cb55529c0f61fa1c <= var_b53c799cdd5f52a9 )
            {
                break;
            }
        }
        else if ( time_elapsed >= var_5062251c0b2ec7bd )
        {
            break;
        }
        
        waitframe();
        time_elapsed += level.framedurationseconds;
    }
    
    var_949e8d3f75cd709f = cup.origin;
    level utility::flag_set( "hornet_mq_investigate_defend_ended" );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "off" );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "visual", "repaired" );
    end_pos = parent_interact.root.evidence_loc.origin;
    bolt = spawnscriptable( %"zm_sat_hornet_mq_trail", cup.origin, cup.angles );
    bolt utility::function_7c10ea82c1e305b8( "visual", "sake_charge" );
    bolt_mover = utility::spawn_model( "tag_origin", cup.origin, cup.angles );
    bolt utility::scriptable_setparententity( bolt_mover );
    step = level.framedurationseconds;
    speed = 10;
    
    while ( true )
    {
        if ( !isdefined( level.hornet_mq.chase_hellhound ) )
        {
            switch ( level.hornet_mq.var_71ac555879808712.var_8133ea3bbadb0bc9 )
            {
                case #"hash_4580372509891086":
                    item = %"hash_58ee983cf15bea95";
                    var_46d396204d211489 = 11;
                    break;
                case #"hash_13894b2d73f9873f":
                    item = %"hash_6d90e79d6ed53dc0";
                    var_46d396204d211489 = 9;
                    break;
                case #"hash_5b73f98f5259d72f":
                    item = %"hash_1e3143f8a7c1e6c8";
                    var_46d396204d211489 = 10;
                    break;
            }
            
            gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
            
            if ( !utility::get_bit_flag( gathered_evidence, var_46d396204d211489 ) )
            {
                level.hornet_mq.var_14e2b5af3f8ececf = level mq_spawn_item( item, bolt_mover.origin, ( 0, 0, 0 ) );
            }
            
            break;
        }
        
        if ( distance2dsquared( bolt_mover.origin, end_pos ) <= 400 )
        {
            if ( isalive( level.hornet_mq.chase_hellhound ) && level.hornet_mq.chase_hellhound.subclass == "zombie_hellhound" )
            {
                target_pos = level.hornet_mq.chase_hellhound gettagorigin( "tag_mouth_fx" );
            }
        }
        else
        {
            target_pos = end_pos + ( 0, 0, 30 );
        }
        
        v_to_mouth = vectornormalize( target_pos - bolt_mover.origin );
        
        if ( distance2dsquared( bolt_mover.origin, target_pos ) <= 225 )
        {
            break;
        }
        
        if ( level.hornet_mq.chase_hellhound.var_2306902cce331139 )
        {
            break;
        }
        
        new_pos = bolt_mover.origin + v_to_mouth * speed;
        bolt_mover moveto( new_pos, step );
        wait step;
    }
    
    bolt freescriptable();
    bolt_mover delete();
    level utility::flag_set( "hornet_mq_hellhound_took_ev" );
    nearby_players = getplayersinradius( var_949e8d3f75cd709f, 2000 );
    level musicbank_utility::function_5aca66c390aa347d( nearby_players, #"hash_ca85e44b90264bbb" );
    level thread function_abb896fecea8c018( var_949e8d3f75cd709f );
    level function_3582825f5c626855();
    level utility::flag_wait( "hornet_mq_cup_movement_stopped" );
    level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "off" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc01de61b, Offset: 0x20eeb
// Size: 0x4d0
function setup_chase_hellhound( source_interact )
{
    level utility::flag_set( "hornet_mq_blocking_horse_ee" );
    
    if ( !isdefined( source_interact ) )
    {
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        
        if ( utility::get_bit_flag( var_181bfe57b6b9d727, 11 ) )
        {
            var_fa2f112f6c745733 = "zone_main_keep_wall_jump_zone_02";
        }
        else if ( utility::get_bit_flag( var_181bfe57b6b9d727, 12 ) )
        {
            var_fa2f112f6c745733 = "zone_main_keep_2nd_floor_c";
        }
        else if ( utility::get_bit_flag( var_181bfe57b6b9d727, 13 ) )
        {
            var_fa2f112f6c745733 = "zone_broken_turrets_d";
        }
        else
        {
            var_fa2f112f6c745733 = "zone_main_keep_wall_jump_zone_02";
        }
        
        investigate_locs = utility::getstructarray( "mq_inves_loc", "targetname" );
        
        foreach ( loc in investigate_locs )
        {
            if ( loc.script_noteworthy == var_fa2f112f6c745733 )
            {
                loc.var_2389aa3c5f35b020 = 1;
                loc.evidence_loc = utility::getstruct( loc.target, "targetname" );
                loc.zone = loc.script_noteworthy;
                loc.var_8133ea3bbadb0bc9 = loc.evidence_loc.script_noteworthy;
                target_loc = loc;
                break;
            }
        }
        
        source_interact = {};
        source_interact.root = target_loc;
    }
    
    if ( !( isdefined( level.hornet_mq.var_71ac555879808712 ) && isdefined( level.hornet_mq.var_71ac555879808712.item ) && isdefined( level.hornet_mq.var_71ac555879808712.item_ref ) ) )
    {
        switch ( source_interact.root.var_8133ea3bbadb0bc9 )
        {
            case #"hash_4580372509891086":
                item = %"hash_58ee983cf15bea95";
                misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
                misc_item_data = utility::set_bit_flag( misc_item_data, 12 );
                level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
                break;
            case #"hash_13894b2d73f9873f":
                item = %"hash_6d90e79d6ed53dc0";
                misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
                misc_item_data = utility::set_bit_flag( misc_item_data, 13 );
                level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
                break;
            case #"hash_5b73f98f5259d72f":
                item = %"hash_1e3143f8a7c1e6c8";
                misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
                misc_item_data = utility::set_bit_flag( misc_item_data, 11 );
                level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
                break;
        }
        
        level.hornet_mq.var_71ac555879808712 = {};
        level.hornet_mq.var_71ac555879808712.var_8133ea3bbadb0bc9 = source_interact.root.var_8133ea3bbadb0bc9;
        level.hornet_mq.var_71ac555879808712.item_ref = item;
    }
    
    hellhound = function_604997e8573b2e9c( source_interact );
    
    if ( isdefined( hellhound.idle_eyes_attractor ) )
    {
        hellhound zombie_attractor_manager::function_dcfb4c31f1d97cd2( hellhound.idle_eyes_attractor );
    }
    
    attractor_base = {};
    attractor_base.origin = source_interact.root.evidence_loc.origin;
    attractor_base.target = utility::getstruct( source_interact.root.evidence_loc.target, "targetname" );
    hellhound.goal_attractor = hellhound zombie_attractor_manager::function_7eb1aaa8bc7cc15( attractor_base, 3, undefined, 0 );
    hellhound.goal_attractor.target = attractor_base.target;
    
    /#
        sphere( attractor_base.origin, 15, ( 1, 1, 1 ), 0, 9999 );
    #/
    
    hellhound thread function_6fed6f2a9876146f();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7466be2b, Offset: 0x213c3
// Size: 0x345
function function_604997e8573b2e9c( source_interact )
{
    switch ( source_interact.root.var_8133ea3bbadb0bc9 )
    {
        case #"hash_4580372509891086":
            misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            misc_item_data = utility::set_bit_flag( misc_item_data, 12 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
            break;
        case #"hash_13894b2d73f9873f":
            misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            misc_item_data = utility::set_bit_flag( misc_item_data, 13 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
            break;
        case #"hash_5b73f98f5259d72f":
            misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            misc_item_data = utility::set_bit_flag( misc_item_data, 11 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
            break;
    }
    
    [ spawner ] = utility::function_b7f3d374aa10aa51( "spawn_loc_hh", "script_noteworthy", source_interact.root.origin, 600 );
    var_81780e0ae227b9cf = spawnscriptable( "scriptable_zombie_hellhound_spawn", spawner.origin + ( 0, 0, 48 ), spawner.angles );
    var_81780e0ae227b9cf utility::function_7c10ea82c1e305b8( "spawn_fx", "spawn_loop" );
    wait 1.5;
    
    if ( isdefined( level.hornet_mq.defend_cup ) )
    {
        level.hornet_mq.defend_cup utility::function_7c10ea82c1e305b8( "investigate", "off" );
    }
    
    for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ) )
    {
        waitframe();
    }
    
    s_additional_params = { #b_ignore_idle_eyes:1 };
    level.hornet_mq.chase_hellhound = function_89266a24d0006d65( "sat_spawner_zombie_hellhound_zm_hornet_mq", spawner, s_additional_params );
    level.hornet_mq.chase_hellhound thread function_8d94f35f67792b5e();
    playsoundatpos( spawner.origin, #"hash_eb9a64f1e34e8174" );
    level thread function_126ac7d38df52177( source_interact );
    var_81780e0ae227b9cf freescriptable();
    level.hornet_mq.chase_hellhound function_afbc854c30f3e5fe( "all_enabled" );
    
    if ( isdefined( level.hornet_mq.chase_hellhound ) )
    {
        level.hornet_mq.chase_hellhound zombie_utils::function_a8ce00e0448cb6f0( "sprint", "mq_hh_chase_ref", 6 );
    }
    
    level.hornet_mq.chase_hellhound callback::add( "on_zombie_ai_killed", &function_1bec6259b57d386d );
    return level.hornet_mq.chase_hellhound;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x775054bc, Offset: 0x21711
// Size: 0x31
function function_8d94f35f67792b5e()
{
    self endon( #"death" );
    wait 5;
    
    while ( true )
    {
        self playsoundonmovingent( #"hash_b46a80a93534203b" );
        wait randomintrange( 4, 8 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x1f14788b, Offset: 0x2174a
// Size: 0x1a8
function function_afbc854c30f3e5fe( val_state )
{
    if ( val_state == "all_enabled" )
    {
        val::set( "mq_hh_chase_ref", "ammomod_immune", 1 );
        val::set( "mq_hh_chase_ref", "damage", 0 );
        val::set( "mq_hh_chase_ref", "death", 0 );
        val::set( "mq_hh_chase_ref", "allow_secondary_attack_damage", 0 );
        val::set( "mq_hh_chase_ref", "show_healthbar", 0 );
        self.var_190f8e8daa83f8c = 1;
        self.var_a8fa61d92872fc74 = 1;
        val::set( "mq_hh_chase_ref", "ignore_cleanup", 1 );
        val::set( "mq_hh_chase_ref", "allow_brot", 0 );
        val::set( "mq_hh_chase_ref", "stunned", 0 );
        val::set( "mq_hh_chase_ref", "disallow_stun", 1 );
        val::set( "mq_hh_chase_ref", "allow_haywire", 0 );
        return;
    }
    
    if ( val_state == "spawn_disabled" )
    {
        val::reset( "mq_hh_chase_ref", "ammomod_immune" );
        val::reset( "mq_hh_chase_ref", "damage" );
        val::reset( "mq_hh_chase_ref", "death" );
        val::reset( "mq_hh_chase_ref", "allow_secondary_attack_damage" );
        val::reset( "mq_hh_chase_ref", "show_healthbar" );
        val::reset( "mq_hh_chase_ref", "stunned" );
        val::reset( "mq_hh_chase_ref", "disallow_stun" );
        val::reset( "mq_hh_chase_ref", "allow_haywire" );
        self.var_190f8e8daa83f8c = 0;
        return;
    }
    
    val::reset_all( "mq_hh_chase_ref" );
    self.var_190f8e8daa83f8c = 1;
    self.var_a8fa61d92872fc74 = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xad34552b, Offset: 0x218fa
// Size: 0x434
function function_126ac7d38df52177( source_interact )
{
    level.hornet_mq.chase_hellhound endon( #"death" );
    level utility::waittill_any_timeout( 15, "hornet_mq_hellhound_took_ev" );
    level.hornet_mq.var_71ac555879808712.item = level mq_spawn_item( level.hornet_mq.var_71ac555879808712.item_ref, source_interact.root.evidence_loc.origin - ( 0, 0, 30 ), source_interact.root.evidence_loc.angles );
    level.hornet_mq.var_71ac555879808712.item function_7653c765b6c7b815();
    level.hornet_mq.chase_hellhound.trail = spawnscriptable( %"zm_sat_hornet_mq_trail", level.hornet_mq.var_71ac555879808712.item.origin, level.hornet_mq.var_71ac555879808712.item.angles );
    level.hornet_mq.chase_hellhound.trail utility::function_7c10ea82c1e305b8( "visual", "hellhound_ev_trail" );
    mover = utility::spawn_model( "tag_origin", level.hornet_mq.var_71ac555879808712.item.origin, level.hornet_mq.var_71ac555879808712.item.angles );
    waitframe();
    level.hornet_mq.var_71ac555879808712.item utility::scriptable_setparententity( mover );
    level.hornet_mq.chase_hellhound.trail utility::scriptable_setparententity( mover );
    mouth_offset_x = getdvarfloat( @"hash_a32ba081ab85fbb6", 12 );
    mouth_offset_y = getdvarfloat( @"hash_a32ba181ab85fde9", -3 );
    mouth_offset_z = getdvarfloat( @"hash_a32b9e81ab85f750", -3.5 );
    mouth_angles_x = 0;
    mouth_angles_y = 90;
    mouth_angles_z = 0;
    
    if ( level.hornet_mq.var_71ac555879808712.item_ref == %"hash_1e3143f8a7c1e6c8" )
    {
        mouth_angles_x = 90;
        mouth_angles_y = 0;
    }
    
    mover linkto( level.hornet_mq.chase_hellhound, "j_head", ( mouth_offset_x, mouth_offset_y, mouth_offset_z ), ( mouth_angles_x, mouth_angles_y, mouth_angles_z ) );
    level.hornet_mq.chase_hellhound playsoundonmovingent( #"hash_ef2bcdd65d6acb3f" );
    level.hornet_mq.chase_hellhound utility::function_7c10ea82c1e305b8( "hornet_mq_carrying_ev", "on" );
    nearby_players = getplayersinradius( level.hornet_mq.chase_hellhound.origin, 600 );
    
    if ( nearby_players.size < 1 )
    {
        return;
    }
    
    foreach ( player in nearby_players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            selected_player = player;
            break;
        }
    }
    
    if ( !isdefined( selected_player ) )
    {
        selected_player = nearby_players[ 0 ];
    }
    
    selected_player thread function_2a6deff157d1165a( #"hash_7436068fd46e90ea", #"bc_flavor_player_negative", 0.5 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4f0d6b90, Offset: 0x21d36
// Size: 0x1d4
function function_6fed6f2a9876146f()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_c7b8289e9b333354 = 0;
    var_a3e361b7d1abf729 = 0;
    
    while ( true )
    {
        if ( !( isdefined( self.origin ) && isdefined( self.goal_attractor.source.origin ) ) )
        {
            return;
        }
        
        if ( var_a3e361b7d1abf729 )
        {
            self.var_2306902cce331139 = 1;
            attractor_base = {};
            attractor_base.curr_struct = self.goal_attractor.target;
            attractor_base.origin = attractor_base.curr_struct.origin;
            attractor_base.target = utility::getstruct( attractor_base.curr_struct.target, "targetname" );
            
            if ( isdefined( self.goal_attractor ) )
            {
                zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.goal_attractor );
            }
            
            self.goal_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( attractor_base, 3, undefined, 0 );
            self.goal_attractor.target = attractor_base.target;
            var_a3e361b7d1abf729 = 0;
            
            /#
                sphere( attractor_base.origin, 15, ( 1, 1, 1 ), 0, 9999 );
            #/
        }
        
        if ( distancesquared( self.origin, self.goal_attractor.source.origin ) < 1225 )
        {
            var_a3e361b7d1abf729 = 1;
            waitframe();
            continue;
        }
        
        if ( !var_c7b8289e9b333354 )
        {
            var_c7b8289e9b333354 = 1;
            level function_ecc91637c2a6fbb1();
            utility::delaythreadendon( 7, "death", &function_afbc854c30f3e5fe, "spawn_disabled" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x57c2cf0c, Offset: 0x21f12
// Size: 0x21e
function function_1bec6259b57d386d( params )
{
    if ( isdefined( level.hornet_mq.var_71ac555879808712.item.linkedparent ) )
    {
        level.hornet_mq.var_71ac555879808712.item.linkedparent delete();
    }
    
    if ( isdefined( level.hornet_mq.var_71ac555879808712.item ) )
    {
        level.hornet_mq.var_71ac555879808712.item freescriptable();
    }
    
    if ( isdefined( level.hornet_mq.chase_hellhound.trail ) )
    {
        level.hornet_mq.chase_hellhound.trail freescriptable();
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_ca85e44b90264bbb" );
    
    switch ( level.hornet_mq.var_71ac555879808712.var_8133ea3bbadb0bc9 )
    {
        case #"hash_4580372509891086":
            item = %"hash_58ee983cf15bea95";
            var_46d396204d211489 = 11;
            break;
        case #"hash_13894b2d73f9873f":
            item = %"hash_6d90e79d6ed53dc0";
            var_46d396204d211489 = 9;
            break;
        case #"hash_5b73f98f5259d72f":
            item = %"hash_1e3143f8a7c1e6c8";
            var_46d396204d211489 = 10;
            break;
    }
    
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    
    if ( !utility::get_bit_flag( gathered_evidence, var_46d396204d211489 ) )
    {
        level.hornet_mq.var_14e2b5af3f8ececf = level mq_spawn_item( item, self.origin + ( 0, 0, 16 ), ( 0, 0, 0 ) );
    }
    
    level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf7dad51, Offset: 0x22138
// Size: 0x6b
function function_c09fe1a868d0af4f()
{
    level endon( #"game_ended" );
    wait 2;
    earthquake_center = utility::getstruct( "mq_oyo_trans_loc", "targetname" );
    earthquake( 0.3, 6, earthquake_center.origin, 5200 );
    playsoundatpos( earthquake_center.origin, #"hash_300f0055eb4d4331" );
    wait 2;
    level thread function_b5fcf3a36fd29070();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x55914ba3, Offset: 0x221ab
// Size: 0x315
function function_b5fcf3a36fd29070( var_f4b855dc0b3f1d91 = 0 )
{
    level endon( #"game_ended" );
    level setup_lantern_clock();
    debris = getent( "mq_cl_debris", #targetname );
    debris_col = getent( "sat_zm_jap_broken_stones_col", #targetname );
    activateworldevent( "we_rubble_settle" );
    
    if ( !var_f4b855dc0b3f1d91 )
    {
        level.hornet_mq.clock.mdl thread utility::do_jitter( 0.75, 1.5, 0, 0.5, 1 );
        level.hornet_mq.clock.mdl.origin = ( level.hornet_mq.clock.mdl.origin[ 0 ], level.hornet_mq.clock.mdl.origin[ 1 ], level.hornet_mq.clock.mdl.origin[ 2 ] - 15 );
        level.hornet_mq.clock.hand.origin = ( level.hornet_mq.clock.hand.origin[ 0 ], level.hornet_mq.clock.hand.origin[ 1 ], level.hornet_mq.clock.hand.origin[ 2 ] - 15 );
        level.hornet_mq.clock.mdl movez( 15, 0.75, 0, 0.5 );
        level.hornet_mq.clock.hand movez( 15, 0.75, 0.5 );
        goal_pos = debris.origin - ( 0, 0, 108 );
        playsoundatpos( debris.origin, "evt_mq_debris_settle" );
        debris moveto( goal_pos, 3, 3 );
        debris waittill( #"movedone" );
    }
    
    if ( isdefined( debris ) )
    {
        debris delete();
    }
    
    if ( isdefined( debris_col ) )
    {
        debris_col delete();
    }
    
    if ( level.directed_mode )
    {
        level utility::flag_wait_any( "mq_directed_revealed_screen_loc", "mq_directed_revealed_screen_loc_a", "mq_directed_revealed_screen_loc_b", "mq_directed_revealed_screen_loc_c" );
        level function_ecc91637c2a6fbb1();
    }
    
    level.hornet_mq.clock.interact makeusable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x8d12a479, Offset: 0x224c8
// Size: 0x41b
function function_a444c7e83d38b1a0( player )
{
    level endon( #"game_ended" );
    self makeunusable();
    level utility::flag_set( "hornet_mq_clock_animating" );
    
    if ( level utility::flag( "mq_step_30_complete" ) )
    {
        return;
    }
    
    if ( level.directed_mode )
    {
        level thread function_a0081e4637a77dc2();
    }
    
    if ( !isdefined( level.hornet_mq.clock.var_b5414513c717c917 ) )
    {
        level.hornet_mq.clock.var_b5414513c717c917 = 1;
        player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_5" );
        zm_sat_hornet_assault_rounds::set_preferred_sector( "ar_sec2" );
        
        if ( level.hornet_mq.next_assault_round )
        {
            currround = zm_round_logic::get_rb_round_number();
            
            if ( currround >= 997 )
            {
                if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
                {
                    zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
                    zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( 999 );
                    level zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, 999 );
                }
                else
                {
                    level thread function_e78b04526b14e29d();
                }
            }
            else if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
            {
                if ( abs( level.hornet_mq.next_assault_round - currround ) <= 1 )
                {
                    var_8a85a2e511a669e2 = currround + 2;
                }
                else
                {
                    var_8a85a2e511a669e2 = currround + 1;
                }
                
                zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
                zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( var_8a85a2e511a669e2 );
                level zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, var_8a85a2e511a669e2 );
            }
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
                {
                    if ( var_8a85a2e511a669e2 && var_8a85a2e511a669e2 > 15 )
                    {
                        zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
                        zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( 15 );
                        level zm_round_spawning::function_9fd9e12523021d1d( var_8a85a2e511a669e2, 15 );
                    }
                }
                else
                {
                    level thread function_e78b04526b14e29d( 15 );
                }
            }
        }
        
        level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "clock_fx", "clock_activate" );
        earthquake( 0.2, 1.5, level.hornet_mq.clock.mdl.origin, 150 );
        playrumbleonposition( "low_highfreq", level.hornet_mq.clock.mdl.origin );
        affected_players = function_d63fe6a4c08ba6f5( level.hornet_mq.clock.mdl.origin - ( 0, 0, 32 ), 85, 96 );
        
        foreach ( affected_player in affected_players )
        {
            v_knockback = affected_player.origin - level.hornet_mq.clock.mdl.origin - ( 0, 0, 32 );
            affected_player knockback( v_knockback, 275, 1 );
        }
        
        level thread function_fbc84be173293c74( player, self.origin );
        wait 3;
        level function_d40215239bfba47c();
        level utility::flag_set( "mq_step_29_complete" );
        wait 0.5;
        level function_ecc91637c2a6fbb1();
    }
    
    if ( function_6d2b9cfdd36913a() )
    {
        level thread open_clock();
        return;
    }
    
    level function_daab3ab588c846e7( level.hornet_mq.clock.sequence );
    level utility::flag_clear( "hornet_mq_clock_animating" );
    self makeusable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xf04c725a, Offset: 0x228eb
// Size: 0x8d
function clock_hint_callback( usable, player )
{
    if ( level.directed_mode && !level utility::flag( "hornet_mq_clock_animating" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_5daf7c79fcd1754d", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xbac257e8, Offset: 0x22980
// Size: 0x73
function function_fbc84be173293c74( player, clock_origin )
{
    player function_2a6deff157d1165a( #"hash_9fec461cb7bc938b", #"hash_5212ed7ec42f115a", 0.5 );
    nearby_players = getplayersinradius( clock_origin, 600 );
    level thread function_490cc449b7de9830( [ #"hash_98be93493c023b21", #"hash_98be90493c023608" ], nearby_players, 1, 1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x8265652f, Offset: 0x229fb
// Size: 0x32
function function_a0081e4637a77dc2()
{
    self notify( #"hash_9410f8b913514823" );
    self endon( #"hash_9410f8b913514823" );
    level waittill( #"ar_ended" );
    wait 1;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xeaf2b9d, Offset: 0x22a35
// Size: 0x17a
function function_df8931e58abea5dd()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level utility::flag( "mq_step_30_complete" ) )
    {
        return;
    }
    
    waitframe();
    zm_sat_hornet_assault_rounds::set_preferred_sector( "ar_sec2" );
    
    if ( level.hornet_mq.next_assault_round )
    {
        currround = zm_round_logic::get_rb_round_number();
        
        if ( currround >= 997 )
        {
            if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
            {
                zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
                zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( 999 );
                level zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, 999 );
            }
            else
            {
                level thread function_e78b04526b14e29d();
            }
        }
        else if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
        {
            if ( abs( level.hornet_mq.next_assault_round - currround ) <= 1 )
            {
                var_8a85a2e511a669e2 = currround + 2;
            }
            else
            {
                var_8a85a2e511a669e2 = currround + 1;
            }
            
            zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
            zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( var_8a85a2e511a669e2 );
            level zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, var_8a85a2e511a669e2 );
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            if ( zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
            {
                if ( var_8a85a2e511a669e2 && var_8a85a2e511a669e2 > 15 )
                {
                    zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
                    zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( 15 );
                    level zm_round_spawning::function_9fd9e12523021d1d( var_8a85a2e511a669e2, 15 );
                }
            }
            else
            {
                level thread function_e78b04526b14e29d( 15 );
            }
        }
    }
    
    level function_d40215239bfba47c();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0xc306c29, Offset: 0x22bb7
// Size: 0x6e
function private function_e78b04526b14e29d( next_assault_round = 999 )
{
    level endon( #"game_ended" );
    
    while ( !zm_sat_hornet_assault_rounds::function_88712c1ecdd86a0f( "ar_sec2" ) )
    {
        level waittill( #"on_round_start" );
    }
    
    zm_sat_hornet_assault_rounds::function_8c0bf06dd299f021();
    zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( next_assault_round );
    level zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, next_assault_round );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xeb696663, Offset: 0x22c2d
// Size: 0x268
function setup_lantern_clock()
{
    if ( isdefined( level.hornet_mq.clock ) )
    {
        return;
    }
    
    level.hornet_mq.clock = {};
    level.hornet_mq.clock.mdl = getent( "sat_zm_lantern_clock", #targetname );
    level.hornet_mq.clock.hand_loc = level.hornet_mq.clock.mdl gettagorigin( "tag_dial_1_fx" );
    level.hornet_mq.clock.original_angles = level.hornet_mq.clock.mdl gettagangles( "tag_dial_1_fx" );
    level.hornet_mq.clock.hand_loc += vectornormalize( anglestoforward( level.hornet_mq.clock.original_angles ) * 0.2 );
    level.hornet_mq.clock.var_bc853211dbc105d7 = 1;
    level.hornet_mq.clock.hand = utility::spawn_model( %"sat_zm_lantern_clock_hand", level.hornet_mq.clock.hand_loc, level.hornet_mq.clock.original_angles );
    level utility::flag_set( "mq_step_28_complete" );
    interact_loc = utility::getstruct( "mq_cl_interact_loc", "targetname" );
    level.hornet_mq.clock.interact = interaction::register_interact( interact_loc.origin, 80, &function_a444c7e83d38b1a0, &clock_hint_callback );
    level.hornet_mq.clock.interact makeunusable();
    level utility::flag_set( "hornet_mq_lantern_clock_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x973fcd16, Offset: 0x22e9d
// Size: 0x401
function function_d40215239bfba47c()
{
    a_banners = [ 1, 2, 3, 4, 5, 6 ];
    var_83a1fa93e2318d67 = [ randomintrange( 1, a_banners.size + 1 ), randomintrange( 1, a_banners.size + 1 ) ];
    
    for ( i = 0; i < a_banners.size ; i++ )
    {
        if ( arraycontains( var_83a1fa93e2318d67, i + 1 ) )
        {
            var_4572f0c3e9ef532 = [];
            var_4572f0c3e9ef532 = arraycopy( a_banners );
            var_4572f0c3e9ef532[ a_banners[ i ] ] = undefined;
            
            if ( isint( a_banners[ i ] ) )
            {
                function_cdc669dbc8ea2101( var_4572f0c3e9ef532 );
            }
            
            a_banners[ i ] = utility::array_random( var_4572f0c3e9ef532 );
        }
    }
    
    banner_counts = [ 0, 0, 0, 0, 0, 0, 0 ];
    var_64e6e13f5d1d66a2 = [];
    
    foreach ( banner_value in [ 1, 2, 3, 4, 5, 6 ] )
    {
        for ( i = 0; i < a_banners.size ; i++ )
        {
            if ( a_banners[ i ] == banner_value )
            {
                banner_counts[ banner_value ] += 1;
                
                if ( banner_counts[ banner_value ] > 2 )
                {
                    var_64e6e13f5d1d66a2[ var_64e6e13f5d1d66a2.size ] = i;
                }
            }
        }
    }
    
    foreach ( banner in var_64e6e13f5d1d66a2 )
    {
        if ( a_banners[ banner ] < 6 )
        {
            a_banners[ banner ] += 1;
            continue;
        }
        
        a_banners[ banner ] -= 1;
    }
    
    level.hornet_mq.clock.curr_banners = arraycopy( a_banners );
    banners_to_use = a_banners;
    banners_to_add = [];
    banners_to_add[ 0 ] = banners_to_use[ 0 ];
    banners_to_use[ 0 ] = undefined;
    
    if ( isint( 0 ) )
    {
        function_cdc669dbc8ea2101( banners_to_use );
    }
    
    for ( i = banners_to_add.size; i < 4 ; i++ )
    {
        picked_index = randomintrange( 0, banners_to_use.size - 1 );
        banners_to_add[ i ] = banners_to_use[ picked_index ];
        banners_to_use[ picked_index ] = undefined;
        
        if ( isint( picked_index ) )
        {
            function_cdc669dbc8ea2101( banners_to_use );
        }
    }
    
    banner_sums = [];
    i = 0;
    
    while ( i < banners_to_add.size )
    {
        sum = banners_to_add[ i ] + banners_to_add[ i + 1 ];
        banner_sums[ banner_sums.size ] = sum;
        i += 2;
    }
    
    sequence = arraycombine( banners_to_use, banner_sums );
    sequence = arrayrandomize( sequence );
    level.hornet_mq.clock.sequence = sequence;
    level.hornet_mq.banner_puzzle.zone_roots = arrayrandomize( level.hornet_mq.banner_puzzle.zone_roots );
    
    for ( i = 0; i < level.hornet_mq.banner_puzzle.zone_roots.size ; i++ )
    {
        level.hornet_mq.banner_puzzle.zone_roots[ i ].symbol_sbl utility::function_7c10ea82c1e305b8( "visual", string( i + 1 ) );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xf0768517, Offset: 0x232a6
// Size: 0x171
function function_daab3ab588c846e7( a_sequence )
{
    level endon( #"game_ended" );
    
    foreach ( num in a_sequence )
    {
        goal_angles = num * 30;
        goal_angles *= -1;
        angle_delta = goal_angles - level.hornet_mq.clock.hand.angles[ 2 ];
        target_angles = ( 0, 0, angle_delta - 1440 );
        level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "audio", "hand_spin" );
        level.hornet_mq.clock.hand rotateby( target_angles, 1, 0, 0.8 );
        level.hornet_mq.clock.hand waittill( #"rotatedone" );
        
        /#
            iprintlnbold( num );
        #/
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3b10bf8a, Offset: 0x2341f
// Size: 0x36a
function open_clock()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "hornet_mq_lantern_clock_setup_complete" );
    level utility::flag_set( "mq_step_30_complete" );
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    
    if ( !utility::get_bit_flag( gathered_evidence, 14 ) )
    {
        spawn_loc = utility::getstruct( "mq_ev_mdl_spawn_loc", "targetname" );
        level.hornet_mq.medallion = mq_spawn_item( %"hash_4fba957b8dde57df", spawn_loc.origin, spawn_loc.angles );
    }
    
    if ( !isdefined( level.hornet_mq.clock.hand ) )
    {
        level.hornet_mq.clock.hand_loc = utility::getstruct( "mq_cl_hand", "targetname" );
        level.hornet_mq.clock.hand = utility::spawn_model( %"sat_zm_lantern_clock_hand", level.hornet_mq.clock.hand_loc, level.hornet_mq.clock.original_angles );
    }
    
    level.hornet_mq.clock.hand linkto( level.hornet_mq.clock.mdl, "tag_dial_1_fx", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level function_ecc91637c2a6fbb1();
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        wait 2;
    }
    
    level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "anim", "open" );
    st_intel_name = "zmintel_sat_hornet_audiolog_5";
    spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
    level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
    
    if ( level.directed_mode )
    {
        var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
        
        foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
        {
            if ( var_b4c1c1d2a952db62.script_noteworthy == "westbailey" )
            {
                var_b4c1c1d2a952db62 thread namespace_923cf551235ca152::set_flow_cooled( 1, 3 );
            }
        }
    }
    
    wait 5;
    
    for ( i = 1; i < 13 ; i++ )
    {
        level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "number_" + string( i ), "off" );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0x370dc732, Offset: 0x23791
// Size: 0x2b
function private function_9606e29bd262152e( params )
{
    level.hornet_mq.next_assault_round = params.roundnumber;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xfb25469d, Offset: 0x237c4
// Size: 0xd0, Type: bool
function function_6d2b9cfdd36913a()
{
    if ( !( isdefined( level.hornet_mq.banner_puzzle.zone_roots ) && isdefined( level.hornet_mq.clock.sequence ) ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.hornet_mq.banner_puzzle.zone_roots.size ; i++ )
    {
        if ( level.hornet_mq.banner_puzzle.zone_roots[ i ].sum != level.hornet_mq.clock.sequence[ i ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xe33a549e, Offset: 0x2389d
// Size: 0x147
function function_452095b2748c51a3( banner_value, spawner )
{
    zombies = getaiarray( "team_two_hundred" );
    
    if ( zombies.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
    {
        for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ) )
        {
            waitframe();
        }
    }
    
    zombie = function_89266a24d0006d65( "zombie_base", spawner );
    bone = "j_spineLower";
    banner_loc = zombie gettagorigin( bone );
    banner_angles = zombie gettagangles( bone );
    zombie.banner = function_a2733f0065f9fc1c( banner_value, banner_loc, banner_angles );
    zombie.banner linkto( zombie, bone, ( getdvarfloat( @"hash_a474fc92daba1156", -25 ), getdvarfloat( @"hash_a474fd92daba1389", 4.2 ), 0 ), ( 90, 0, 0 ) );
    zombie val::set( "mq_cl_bn_zmb", "ignore_cleanup", 1 );
    zombie callback::add( "on_zombie_ai_killed", &function_2eff3448fa26dc17 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0x273a3c3e, Offset: 0x239ec
// Size: 0xdf
function function_a2733f0065f9fc1c( banner_value, banner_loc, banner_angles, banner_set = undefined )
{
    banner_parent = utility::spawn_model( "tag_origin", banner_loc, banner_angles );
    banner_visual = spawnscriptable( %"hash_731969e920013209", banner_loc, banner_angles );
    banner_visual utility::function_7c10ea82c1e305b8( "usable", "disabled" );
    banner_parent.banner_set = banner_set ?? utility::array_random( [ "a", "b" ] );
    banner_visual utility::function_7c10ea82c1e305b8( "visual", string( banner_value ) + banner_parent.banner_set );
    banner_visual utility::function_7c10ea82c1e305b8( "ambient_fx", "on" );
    banner_visual utility::scriptable_setparententity( banner_parent );
    return banner_parent;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x1be7453d, Offset: 0x23ad4
// Size: 0x71
function cleanup_carriable_banner( holding_ent = undefined )
{
    if ( self.linkedchildren )
    {
        if ( isdefined( holding_ent ) && !isplayer( holding_ent ) )
        {
            self.linkedchildren[ 0 ] utility::function_7c10ea82c1e305b8( "fx", "despawn" );
        }
        
        self.linkedchildren[ 0 ] utility::delaycall( level.framedurationseconds, &freescriptable );
    }
    
    self delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x22cbd4e8, Offset: 0x23b4d
// Size: 0x127
function function_2eff3448fa26dc17( params )
{
    banner_set = self.banner.banner_set;
    self.banner cleanup_carriable_banner( self );
    start = self.origin;
    goal_struct = level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7[ level.hornet_mq.banner_puzzle.banners_recovered ];
    banner_value = level.hornet_mq.clock.curr_banners[ level.hornet_mq.banner_puzzle.banners_recovered ];
    level.hornet_mq.banner_puzzle.banners_recovered += 1;
    level thread function_be32a3491d7e21d6( start, goal_struct, 20, banner_value, banner_set );
}

// Namespace zm_sat_hornet_mq_quest
// Params 5
// Checksum 0x1496c4e0, Offset: 0x23c7c
// Size: 0x1d0
function function_be32a3491d7e21d6( start, goal_struct, time, banner_value, banner_set )
{
    level endon( #"game_ended" );
    trail = utility::spawn_model( %"tag_origin", start, ( 0, 0, 0 ) );
    trail.scr_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", trail.origin, trail.angles );
    waitframe();
    trail.scr_fx utility::scriptable_setparententity( trail );
    trail.scr_fx utility::function_7c10ea82c1e305b8( "visual", "banner" );
    
    if ( goal_struct && goal_struct.origin )
    {
        path = findpathcustom( start, goal_struct.origin );
        adjusted_path = [];
        
        foreach ( point in path )
        {
            adjusted_point = point + ( 0, 0, randomfloatrange( 30, 60 ) );
            adjusted_path[ adjusted_path.size ] = adjusted_point;
        }
        
        trail utility::function_2159dd4196ff4b81( adjusted_path, time, 1, 0, 1, 0.5, 0.5, 1 );
        goal_struct.sbl place_banner( banner_value, banner_set, 1 );
    }
    
    trail.scr_fx freescriptable();
    trail delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x82434eb4, Offset: 0x23e54
// Size: 0x35f
function setup_banner_locs()
{
    if ( isdefined( level.hornet_mq.banner_puzzle ) )
    {
        return;
    }
    
    level.hornet_mq.banner_puzzle = {};
    var_9ee9b5a59b362e2e = utility::getstructarray( "mq_cl_zn_root", "targetname" );
    
    foreach ( root in var_9ee9b5a59b362e2e )
    {
        root.sum = 0;
        root.symbol_sbl = spawnscriptable( %"hash_40409f748b65851e", root.origin, root.angles );
        root.var_861c1e24b587051c = undefined;
        root.place_locs = utility::getstructarray( root.target, "targetname" );
        
        foreach ( place_loc in root.place_locs )
        {
            place_loc.zone_root = root;
            place_loc.banner_value = 0;
            place_loc.sbl = spawnscriptable( %"hash_731969e920013209", place_loc.origin, place_loc.angles );
            place_loc.sbl interaction::set_interact_hint_callback( &banner_hint_callback );
            place_loc.sbl.root = place_loc;
        }
    }
    
    level.hornet_mq.banner_puzzle.zone_roots = var_9ee9b5a59b362e2e;
    var_b03b56a78c865f38 = utility::getstructarray( "mq_cl_bnr_start_loc", "targetname" );
    
    foreach ( var_93c3e7bb3f019adf in var_b03b56a78c865f38 )
    {
        var_93c3e7bb3f019adf.banner_value = 0;
        var_93c3e7bb3f019adf.sbl = spawnscriptable( %"hash_731969e920013209", var_93c3e7bb3f019adf.origin, var_93c3e7bb3f019adf.angles );
        var_93c3e7bb3f019adf.sbl interaction::set_interact_hint_callback( &banner_hint_callback );
        var_93c3e7bb3f019adf.sbl.root = var_93c3e7bb3f019adf;
    }
    
    var_b03b56a78c865f38 = arrayrandomize( var_b03b56a78c865f38 );
    level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7 = var_b03b56a78c865f38;
    level thread function_8cd6c5f091b3bf5f();
    level.hornet_mq.banner_puzzle.banners_recovered = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x3b8d8ea4, Offset: 0x241bb
// Size: 0x188
function function_4f7a810805fa1c9f( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.root ) )
    {
        return;
    }
    
    if ( instance.root.banner_value > 0 )
    {
        if ( player.banner_value > 0 )
        {
            var_bb73ca92b9ebefa8 = player.banner_value;
            var_f29a6c6925dac259 = player.banner_set;
            var_b2278588fa84d7a0 = instance.root.banner_value;
            var_d2241f5e622c2521 = instance.root.banner_set;
            instance function_686cb1695f11973c( player, var_b2278588fa84d7a0, var_d2241f5e622c2521 );
            instance place_banner( var_bb73ca92b9ebefa8, var_f29a6c6925dac259 );
        }
        else
        {
            instance function_686cb1695f11973c( player, instance.root.banner_value, instance.root.banner_set );
        }
        
        return;
    }
    
    if ( player.banner_value > 0 )
    {
        instance place_banner( player.banner_value, player.banner_set );
        player function_90a648d8fddceb53();
        player thread function_2a6deff157d1165a( #"hash_33f42c378b434f7d", #"bc_flavor_player_positive", 0.5 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x78371d2e, Offset: 0x2434b
// Size: 0x1b5
function banner_hint_callback( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( usable.root.banner_value > 0 && player.banner_value > 0 )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_5a10f5185917853e", #type:"HINT_BUTTON" };
        }
        else if ( usable.root.banner_value == 0 & player.banner_value > 0 )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_7fbac0c344a11a0e", #type:"HINT_BUTTON" };
        }
        else if ( usable.root.banner_value > 0 & player.banner_value == 0 )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_5b7e69e8e87a0ad6", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0xa698fbe4, Offset: 0x24508
// Size: 0xc1
function place_banner( banner_value, banner_set, var_c0e852e92fd7bb4 = 0 )
{
    self.root.banner_value = banner_value;
    self.root.banner_set = banner_set;
    utility::function_7c10ea82c1e305b8( "visual", string( banner_value ) + banner_set );
    
    if ( var_c0e852e92fd7bb4 )
    {
        utility::function_7c10ea82c1e305b8( "fx", "spawn" );
    }
    
    utility::function_7c10ea82c1e305b8( "audio", "placed" );
    
    if ( isdefined( self.root.zone_root ) )
    {
        self.root.zone_root function_dfc8f0595fb2523a( banner_value );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0xa9034cdc, Offset: 0x245d1
// Size: 0x1d8
function function_686cb1695f11973c( player, var_c95eb1265734dfe2 = 0, var_6020d2cf8da0eecb = "a" )
{
    if ( isdefined( player ) )
    {
        if ( player.banner_value > 0 )
        {
            player.banner cleanup_carriable_banner( player );
        }
        
        banner_loc = player gettagorigin( "J_SpineLower" );
        player.banner = function_a2733f0065f9fc1c( var_c95eb1265734dfe2, banner_loc, player.angles, var_6020d2cf8da0eecb );
        player.banner linkto( player, "J_SpineLower", ( getdvarfloat( @"hash_a474fc92daba1156", -25 ), 4.2, 0 ), ( 90, 0, 0 ) );
        player.banner_value = var_c95eb1265734dfe2;
        player.banner_set = var_6020d2cf8da0eecb;
        
        if ( player.banner.linkedchildren[ 0 ] )
        {
            player.banner.linkedchildren[ 0 ] utility::function_7c10ea82c1e305b8( "audio", "pickup" );
        }
        
        player thread function_2a6deff157d1165a( #"hash_49a5292c645ac199", #"bc_flavor_player_positive", 0.5 );
        player setclientomnvar( "ui_hud_carried_item_index", 10 );
        player setclientomnvar( "ui_hud_carried_item_count", 1 );
    }
    
    utility::function_7c10ea82c1e305b8( "visual", "empty" );
    self.root.banner_value = 0;
    self.root.banner_set = undefined;
    
    if ( isdefined( self.root.zone_root ) )
    {
        self.root.zone_root function_dfc8f0595fb2523a( var_c95eb1265734dfe2 * -1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x22a507af, Offset: 0x247b1
// Size: 0x3d
function function_dfc8f0595fb2523a( value )
{
    self.sum += value;
    
    if ( level.directed_mode )
    {
        level function_ecc91637c2a6fbb1();
    }
    
    level function_e1dba62dc4715e7a();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc0d76866, Offset: 0x247f6
// Size: 0x12b
function function_e1dba62dc4715e7a()
{
    var_c284de8a6167d0ff = [];
    
    for ( i = 0; i < level.hornet_mq.banner_puzzle.zone_roots.size ; i++ )
    {
        if ( level.hornet_mq.banner_puzzle.zone_roots[ i ].sum )
        {
            var_c284de8a6167d0ff[ var_c284de8a6167d0ff.size ] = level.hornet_mq.banner_puzzle.zone_roots[ i ].sum;
        }
    }
    
    for ( i = 1; i < 13 ; i++ )
    {
        if ( !arraycontains( var_c284de8a6167d0ff, i ) )
        {
            level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "number_" + string( i ), "off" );
            continue;
        }
        
        level.hornet_mq.clock.mdl utility::function_7c10ea82c1e305b8( "number_" + string( i ), "on" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xb0ab5d51, Offset: 0x24929
// Size: 0x42
function function_90a648d8fddceb53()
{
    if ( !isdefined( self.banner ) )
    {
        return;
    }
    
    self.banner cleanup_carriable_banner( self );
    self.banner_value = 0;
    self.banner_set = undefined;
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x526380c7, Offset: 0x24973
// Size: 0x173
function function_8cd6c5f091b3bf5f()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_30_complete" );
    var_7c8e1a47b2d75c76 = 1;
    
    while ( true )
    {
        level waittill( #"special_round_start" );
        
        if ( level.ar_root.current_sector != "ar_sec2" )
        {
            continue;
        }
        
        if ( !isdefined( level.hornet_mq.clock.hand ) )
        {
            continue;
        }
        
        if ( var_7c8e1a47b2d75c76 )
        {
            var_7c8e1a47b2d75c76 = 0;
        }
        else
        {
            level function_d43934245ff33324();
        }
        
        level waittill( #"hash_205a22de093717f9" );
        var_aaf412f3d49ebe9b = level.ar_root.var_28e4ff3f60d19060[ level.ar_root.current_sector ];
        
        foreach ( banner_value in level.hornet_mq.clock.curr_banners )
        {
            spawner = utility::array_random( var_aaf412f3d49ebe9b );
            function_452095b2748c51a3( banner_value, spawner );
            wait 1;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x8fac8748, Offset: 0x24aee
// Size: 0x2cf
function function_d43934245ff33324()
{
    if ( level.directed_mode )
    {
        level thread function_490cc449b7de9830( [ #"hash_68975099b833c0b5", #"hash_68974d99b833bb9c" ], level.players, 1, 1 );
    }
    
    foreach ( zone_root in level.hornet_mq.banner_puzzle.zone_roots )
    {
        foreach ( place_loc in zone_root.place_locs )
        {
            banner_value = place_loc.banner_value;
            banner_set = place_loc.banner_set;
            place_loc.sbl function_686cb1695f11973c( undefined, banner_value, banner_set );
        }
        
        zone_root.sum = 0;
    }
    
    foreach ( var_93c3e7bb3f019adf in level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7 )
    {
        banner_value = var_93c3e7bb3f019adf.banner_value;
        banner_set = var_93c3e7bb3f019adf.banner_set;
        var_93c3e7bb3f019adf.sbl function_686cb1695f11973c( undefined, banner_value, banner_set );
    }
    
    foreach ( player in level.players )
    {
        player function_90a648d8fddceb53();
    }
    
    level.hornet_mq.banner_puzzle.banners_recovered = 0;
    level function_d40215239bfba47c();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xf0912531, Offset: 0x24dc5
// Size: 0x10d
function function_a0e27eba7315e6ad( params )
{
    if ( !self.banner_value )
    {
        return;
    }
    
    var_93c3e7bb3f019adf = self.origin;
    banner_value = self.banner_value;
    banner_set = self.banner_set;
    
    foreach ( banner_loc in level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7 )
    {
        if ( banner_loc.banner_value <= 0 )
        {
            goal_struct = banner_loc;
            break;
        }
    }
    
    function_90a648d8fddceb53();
    level thread function_be32a3491d7e21d6( var_93c3e7bb3f019adf, goal_struct, 3, banner_value, banner_set );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6fb70929, Offset: 0x24eda
// Size: 0x156
function function_ea169a9c73ed10ba()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" );
    
    if ( isdefined( gathered_evidence ) && utility::get_bit_flag( gathered_evidence, 12 ) )
    {
        return;
    }
    
    spawn_loc = utility::getstruct( "mq_ev_brth_spawn_loc", "targetname" );
    level.hornet_mq.bro_carving = spawnscriptable( %"zm_sat_hornet_mq_evidence", spawn_loc.origin, spawn_loc.angles );
    level.hornet_mq.bro_carving utility::function_7c10ea82c1e305b8( "visual", "brothers" );
    raised_loc = utility::getstruct( spawn_loc.target, "targetname" );
    level.hornet_mq.bro_carving.lowered_pos = spawn_loc.origin;
    level.hornet_mq.bro_carving.raised_pos = raised_loc.origin - ( 0, 0, 3.3 );
    level thread function_e1c40b94508b061();
    level thread function_2a613c022e632175();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x5fe12952, Offset: 0x25038
// Size: 0x213
function function_e1c40b94508b061()
{
    level endon( #"mq_player_got_ev_mot_take" );
    level endon( #"mq_br_mot_ev_launched" );
    mover = utility::spawn_model( "tag_origin", level.hornet_mq.bro_carving.origin, level.hornet_mq.bro_carving.angles );
    waitframe();
    level.hornet_mq.bro_carving utility::scriptable_setparententity( mover );
    wait 5.1;
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
    {
        if ( var_b4c1c1d2a952db62.script_noteworthy == "westbailey" )
        {
            if ( var_b4c1c1d2a952db62.iscooled )
            {
                mover.origin = level.hornet_mq.bro_carving.raised_pos;
            }
        }
    }
    
    while ( true )
    {
        level waittill( #"lava_flow_started_cooling_westbailey" );
        level.hornet_mq.bro_carving utility::function_7c10ea82c1e305b8( "specific_fx", "carving_melt" );
        mover moveto( level.hornet_mq.bro_carving.raised_pos, 4, 0, 0.1 );
        level utility::delaycall( 5, &function_ecc91637c2a6fbb1 );
        level waittill( #"lava_flow_started_melting_westbailey" );
        mover moveto( level.hornet_mq.bro_carving.lowered_pos, 4, 0, 1 );
        level utility::delaycall( 5, &function_ecc91637c2a6fbb1 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xce467b73, Offset: 0x25253
// Size: 0x294
function function_2a613c022e632175()
{
    level endon( #"mq_player_got_ev_mot_take" );
    var_59264b9070bd7dfe = 32;
    sq_dist_threshold = var_59264b9070bd7dfe * var_59264b9070bd7dfe;
    
    while ( true )
    {
        level waittill( #"hash_5d12c982d0942ee5", spawn_loc );
        nearby_players = getplayersinradius( spawn_loc, 1600 );
        level thread function_e3a03fbfe3e8424b( [ #"hash_a846579b0a871c19", #"hash_a846549b0a871700", #"hash_a846559b0a8718b3", #"hash_a8465a9b0a872132" ], nearby_players, 1.2 );
        
        if ( distance2dsquared( spawn_loc, level.hornet_mq.bro_carving.origin ) < sq_dist_threshold )
        {
            level utility::flag_set( "mq_br_mot_ev_launched" );
            dest = utility::getstruct( "mq_br_mot_launch_loc", "targetname" );
            control_pos = utility::getstruct( dest.target, "targetname" );
            var_d524330523e6df2d = 1;
            level.hornet_mq.bro_carving utility::function_7c10ea82c1e305b8( "specific_fx", "carving_melt" );
            level.hornet_mq.bro_carving.linkedparent rotateto( dest.angles, var_d524330523e6df2d );
            level.hornet_mq.bro_carving.linkedparent thread utility::function_8001268940441423( level.hornet_mq.bro_carving.origin, dest.origin, control_pos.origin, var_d524330523e6df2d );
            level.hornet_mq.bro_carving.linkedparent waittill( #"off_bezier_curve" );
            break;
        }
    }
    
    level.hornet_mq.var_54ecbb8f70471080 = level mq_spawn_item( %"hash_7fbb0e19e6b879f7", level.hornet_mq.bro_carving.origin, level.hornet_mq.bro_carving.angles );
    level.hornet_mq.bro_carving.linkedparent delete();
    level.hornet_mq.bro_carving freescriptable();
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x50a0695a, Offset: 0x254ef
// Size: 0xd1
function function_cad8bd257a48fc87()
{
    if ( level.hornet_mq.var_28c45c5d375ce1a1 )
    {
        level.hornet_mq.var_28c45c5d375ce1a1 delete();
    }
    
    level.hornet_mq.var_9865205a186a2480 = 0;
    interact_loc = utility::getstruct( "mq_oyo_interact_loc", "targetname" );
    level.hornet_mq.var_28c45c5d375ce1a1 = interaction::register_interact( interact_loc.origin, 80, &function_e408b8034669053a );
    level.hornet_mq.var_28c45c5d375ce1a1 interaction::set_interact_hint_callback( &function_2faa59b5aa41afd3 );
    level.hornet_mq.var_28c45c5d375ce1a1 sethintonobstruction( "show" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xcfe674d3, Offset: 0x255c8
// Size: 0x18c
function function_e408b8034669053a( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    self makeunusable();
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"hash_1cedf86fba43ed28";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    /#
        if ( getdvarint( @"zombie_cheat", 0 ) )
        {
            b_passed = 1;
        }
    #/
    
    if ( b_passed )
    {
        self makeunusable();
        earthquake( 0.25, 6.1, self.origin, 1050 );
        playrumbleonposition( "heavy_5s", self.origin );
        level utility::flag_set( "hornet_mq_blocking_horse_ee" );
        level thread function_e3a03fbfe3e8424b( [ #"hash_ac16321353239fa5" ], level.players, 0.5 );
        wait 6;
        deactivateworldevent( "we_katana_react_mq" );
        level notify( #"hornet_mq_onryo_fight_fasttravel_started" );
        
        foreach ( player in level.players )
        {
            player thread function_145366ae23bc1e63();
        }
        
        level utility::flag_set( "mq_step_34_complete" );
        return;
    }
    
    self makeusable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x677d0954, Offset: 0x2575c
// Size: 0x9a
function function_2faa59b5aa41afd3( usable, player )
{
    if ( player.interactions_disabled || utility::flag( "exfil_window_active" ) || !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_75ecc146688100eb", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x139e0786, Offset: 0x257fe
// Size: 0xc1
function function_145366ae23bc1e63()
{
    self endon( #"death_or_disconnect" );
    warp_locs = utility::getstructarray( "mq_oyo_ptp_loc", "targetname" );
    var_6787895101874fb4 = zm_fasttravel::function_c10a103f92f5a219( self );
    loc = warp_locs[ var_6787895101874fb4 ];
    self predictstreamposuntilcleared( loc.origin );
    utility::ent_flag_set( "onryo_fight_fasttravel_active" );
    fasttravel_time = 5;
    zm_fasttravel::set_player_vars( 1 );
    thread zm_fasttravel::fasttravel_teleport_vortex( loc, 1, undefined, 1, undefined, 0 );
    utility::delaycall( fasttravel_time, &zm_fasttravel::set_player_vars, 0 );
    utility::delaycall( fasttravel_time, &utility::ent_flag_clear, "onryo_fight_fasttravel_active" );
    utility::delaycallendon( fasttravel_time + 1, "death_or_disconnect", &clearpredictedstreampos );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x158ad3ec, Offset: 0x258c7
// Size: 0x12f
function function_eff0f78aa264032a()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "doorbuy_init_complete" );
    level.hornet_mq.courtyard_doors = [];
    
    foreach ( door in level.a_s_doorbuys )
    {
        if ( door.script_flag_set == "door_main_bailey_to_main_keep" || door.script_flag_set == "door_broken_turrets_to_main_bailey" || door.script_flag_set == "door_second_bailey_to_main_bailey" )
        {
            door.s_doorbuy.var_870561c2bbbdb6b7 = 1;
            door.script_delete = 0;
            level.hornet_mq.courtyard_doors[ level.hornet_mq.courtyard_doors.size ] = door;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x1c9d822c, Offset: 0x259fe
// Size: 0xc9a
function function_e8f4ecd2397bc342()
{
    level endon( #"game_ended" );
    level callback::callback( "disable_ninja_kite_vials" );
    
    if ( !level zm_sat_hornet_assault_rounds::get_assault_rounds_blocked() )
    {
        level zm_sat_hornet_assault_rounds::set_assault_rounds_blocked( 1 );
    }
    
    level function_6e29e1bbb80eff60( 1, [ "zone_main_bailey" ] );
    
    foreach ( s_trap_root in level.murder_holes_root.var_2747e0528b1f176 )
    {
        if ( s_trap_root.script_noteworthy == "mh_root_4" )
        {
            var_8db7030994cd3dfe = [ "red_ug_mh", "green_ug_mh", "yellow_ug_mh", "white_ug_mh" ];
            
            foreach ( flag in var_8db7030994cd3dfe )
            {
                if ( s_trap_root utility::ent_flag( flag ) )
                {
                    var_4d70c60b4d0878f5 = 1;
                    break;
                }
            }
            
            if ( !var_4d70c60b4d0878f5 )
            {
                var_faaa5df2b72b622d = s_trap_root;
                zm_sat_hornet_murder_holes::function_9ceca8d29317aa92( var_faaa5df2b72b622d );
            }
        }
    }
    
    function_ad915db840c90fb3( 1023, 3, 0 );
    activateworldevent( "we_vfx_onryo_arena" );
    level callback::add( "on_player_hotjoin_spawn", &function_145366ae23bc1e63 );
    level.hornet_mq.var_dde019a70c51836b = [ "zone_main_bailey_a", "zone_main_bailey_b", "zone_main_bailey_c", "zone_main_bailey_d" ];
    zm_quest::function_fe2a9a31ab8fbcab( level.hornet_mq.var_dde019a70c51836b );
    utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_a036ff8b4156ec99", level.hornet_mq.var_dde019a70c51836b );
    
    if ( level.var_1516cb7495d00783 )
    {
        level.var_1516cb7495d00783 utility::function_7c10ea82c1e305b8( "courtyard", "show" );
    }
    
    foreach ( door in level.hornet_mq.courtyard_doors )
    {
        foreach ( e_door_mdl in door.doors )
        {
            e_door_mdl.b_doorbuy_opened = 0;
            
            if ( e_door_mdl isscriptable() && isent( e_door_mdl ) )
            {
                e_door_mdl setscriptablepartstate( "base", "idle" );
                continue;
            }
            
            if ( e_door_mdl.var_f1be77dc9d0b94af )
            {
                e_door_mdl moveto( e_door_mdl.v_close_pos, 0.1 );
                
                if ( isdefined( e_door_mdl.v_close_ang ) )
                {
                    e_door_mdl rotateto( e_door_mdl.v_close_ang, 0.1 );
                }
                
                e_door_mdl waittill( #"movedone" );
                
                if ( isdefined( e_door_mdl.var_1d5250246632b2e5 ) )
                {
                    e_door_mdl.var_1d5250246632b2e5 notsolid();
                    e_door_mdl.var_1d5250246632b2e5 connectpaths();
                }
                
                e_door_mdl solid();
                e_door_mdl disconnectpaths();
                continue;
            }
            
            e_door_mdl solid();
            e_door_mdl show();
        }
    }
    
    door_col = getent( "mq_oyo_arna_doors", #targetname );
    door_col.origin += ( 0, 0, 512 );
    door_col show();
    door_col disconnectpaths();
    level.hornet_mq.onryo_fight_throttle = throttle::throttle_initialize( "onryo_fight_throttle", 1, undefined, 1 );
    level function_ecc91637c2a6fbb1();
    zm_round_spawning::pause_round_spawning( 1, "mq_onryo_fight_values_ref" );
    wait 7;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"mq_mini_boss" );
    transform_loc = utility::getstruct( "mq_oyo_trans_loc", "targetname" );
    fx = spawnscriptable( "zm_sat_hornet_mq_oyo_fx", transform_loc.origin, transform_loc.angles );
    fx utility::function_7c10ea82c1e305b8( "fx", "transition_to_oyo" );
    wait 5;
    fx freescriptable();
    zombies = getaiarray( "team_two_hundred" );
    
    if ( zombies.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
    {
        for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ) )
        {
            waitframe();
        }
    }
    
    var_6f88a6bfefadea5e = { #var_42598999191bb358:1, #round_override:30 };
    level.hornet_mq.onryo = function_89266a24d0006d65( "zombie_orion_hvt_mq", transform_loc, var_6f88a6bfefadea5e );
    level.hornet_mq.onryo val::set( "mq_oyo_vals", "ignore_cleanup", 1 );
    level.hornet_mq.onryo val::set( "mq_oyo_vals", "ignore_blackhole_bomb", 1 );
    level.hornet_mq.onryo callback::add( "on_zombie_ai_damaged", &function_26536f8132157ac5 );
    level.hornet_mq.onryo callback::add( "on_zombie_ai_killed", &function_1ba9a9bc5c85bd1b );
    level scriptable::scriptable_adddamagedcallback( &function_85c2993ebeb16844 );
    level function_ecc91637c2a6fbb1();
    waitframe();
    level.hornet_mq.onryo thread function_8daceb55ebaeecd7();
    level thread function_886f2a5ba054ca92();
    wait 3;
    var_59262b01e7bfa115 = 0;
    step = 0.1;
    
    while ( isalive( level.hornet_mq.onryo ) )
    {
        if ( var_59262b01e7bfa115 >= 25 )
        {
            if ( utility::cointoss() )
            {
                level.hornet_mq.onryo thread function_8daceb55ebaeecd7();
            }
            else
            {
                level thread function_bec07aed081d6e54( level.hornet_mq.onryo );
            }
            
            var_59262b01e7bfa115 = 0;
        }
        
        if ( level.hornet_mq.onryo.health / level.hornet_mq.onryo.maxhealth <= 0.15 && !level utility::flag( "mq_oyo_v_three_comp" ) )
        {
            level utility::flag_set( "mq_oyo_v_three_comp" );
            level.hornet_mq.onryo thread function_8daceb55ebaeecd7();
            var_59262b01e7bfa115 = 0;
        }
        
        if ( level.hornet_mq.onryo.health / level.hornet_mq.onryo.maxhealth <= 0.45 && !( level utility::flag( "mq_oyo_v_two_comp" ) || level utility::flag( "mq_oyo_v_three_comp" ) ) )
        {
            level utility::flag_set( "mq_oyo_v_two_comp" );
            level thread function_bec07aed081d6e54( level.hornet_mq.onryo );
            var_59262b01e7bfa115 = 0;
        }
        
        if ( level.hornet_mq.onryo.health / level.hornet_mq.onryo.maxhealth <= 0.75 && !( level utility::flag( "mq_oyo_v_one_comp" ) || level utility::flag( "mq_oyo_v_two_comp" ) || level utility::flag( "mq_oyo_v_three_comp" ) ) )
        {
            level utility::flag_set( "mq_oyo_v_one_comp" );
            level.hornet_mq.onryo thread function_8daceb55ebaeecd7();
            var_59262b01e7bfa115 = 0;
        }
        
        wait step;
        var_59262b01e7bfa115 += step;
    }
    
    level utility::flag_set( "hornet_mq_onryo_killed" );
    level callback::remove( "on_player_hotjoin_spawn", &function_145366ae23bc1e63 );
    level function_a8b47b90b47172fe();
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"mq_mini_boss" );
    
    foreach ( zom in level.hornet_mq.var_f62d4df2791ba151.occupants )
    {
        throttle::throttle_wait_in_queue( level.hornet_mq.onryo_fight_throttle, zom );
        
        if ( zom.var_6298584c895e2be0 )
        {
            continue;
        }
        
        zom.forceannihilate = 1;
        zom.var_a13bed1ac47e1b2c = 1;
        zom kill();
    }
    
    level utility::flag_wait_or_timeout( "hornet_mq_onryo_defeat_vo_played", 20 );
    
    if ( var_faaa5df2b72b622d )
    {
        zm_sat_hornet_murder_holes::function_a5a77f6d33ed909( var_faaa5df2b72b622d );
    }
    
    warp_locs = utility::getstructarray( "mq_oyo_ptp_exit_loc", "targetname" );
    warp_locs = arrayrandomize( warp_locs );
    fasttravel_time = 5;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] predictstreamposuntilcleared( warp_locs[ i ].origin );
        level.players[ i ] zm_fasttravel::set_player_vars( 1 );
        level.players[ i ] thread zm_fasttravel::fasttravel_teleport_vortex( warp_locs[ i ], 1, undefined, 1, undefined, 0 );
        level.players[ i ] utility::delaycallendon( fasttravel_time, "death_or_disconnect", &zm_fasttravel::set_player_vars, 0 );
        level.players[ i ] utility::delaycallendon( fasttravel_time + 1, "death_or_disconnect", &clearpredictedstreampos );
    }
    
    level utility::delaycall( fasttravel_time, &utility::flag_set, "mq_step_35_complete" );
    level utility::flag_clear( "hornet_mq_blocking_horse_ee" );
    zm_quest::function_765655c7699f9fb7();
    utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_c75006e0ddcb3da4" );
    
    if ( level.var_1516cb7495d00783 )
    {
        level.var_1516cb7495d00783 utility::function_7c10ea82c1e305b8( "courtyard", "remove" );
    }
    
    foreach ( door in level.hornet_mq.courtyard_doors )
    {
        foreach ( e_door_mdl in door.doors )
        {
            e_door_mdl.var_c1c98a810b837560 = 0;
            e_door_mdl doorbuy::function_f3160e450543b4f1();
        }
    }
    
    door_col connectpaths();
    door_col hide();
    function_ad915db840c90fb3( 1023, 0, 0 );
    deactivateworldevent( "we_vfx_onryo_arena" );
    level function_6e29e1bbb80eff60( 0, [ "zone_main_bailey" ] );
    zm_round_spawning::pause_round_spawning( 0, "mq_onryo_fight_values_ref" );
    level callback::callback( "enable_ninja_kite_vials" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x68eb2eac, Offset: 0x266a0
// Size: 0x1b0
function function_8daceb55ebaeecd7()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.var_e93bd4609ecde646 )
    {
        return;
    }
    
    self.var_e93bd4609ecde646 = 1;
    level function_a8b47b90b47172fe();
    zombie_stun::stun_ai( 3, "stunned_on" );
    self playsoundonmovingent( #"hash_a82d4275f6df42aa" );
    
    if ( level.players.size > 1 )
    {
        projectile_set = [ 4, 5 ];
    }
    else
    {
        projectile_set = [ 3, 4 ];
    }
    
    var_36fe873f9b79dd4f = utility::array_random( projectile_set );
    var_431b035e59c04fd0 = var_36fe873f9b79dd4f * level.players.size;
    var_431b035e59c04fd0 = var_431b035e59c04fd0 > 0 ? var_431b035e59c04fd0 : 1;
    spawn_center = self.origin + ( 0, 0, 30 );
    a_spawn_locs = utility::function_950fed9c7e18b522( spawn_center, 30, var_431b035e59c04fd0, 0 );
    
    for ( i = 0; i < a_spawn_locs.size ; i++ )
    {
        loc = a_spawn_locs[ i ];
        v_starting_offset = vectortoangles( loc - spawn_center );
        f_starting_offset = v_starting_offset[ 1 ];
        spawn_angle = v_starting_offset + ( 0, 90, 90 );
        target_player_index = int( floor( i / var_36fe873f9b79dd4f ) );
        target_player = level.players[ target_player_index ];
        level thread function_327ff5cd89d75d8a( loc, spawn_angle, f_starting_offset, target_player, 0.4 );
    }
    
    wait 3;
    self.var_e93bd4609ecde646 = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x21fc6ccc, Offset: 0x26858
// Size: 0x31d
function function_327ff5cd89d75d8a( spawn_loc, spawn_angles, f_starting_offset, target, var_5277b69d1a8c7666, var_43dce45c65e3abf3 = undefined )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_43dce45c65e3abf3 ) && ( !isalive( target ) || player::isinlaststand( target ) ) )
    {
        return;
    }
    
    if ( isdefined( var_43dce45c65e3abf3 ) )
    {
        var_20d0d91805a2e86 = var_43dce45c65e3abf3.var_20d0d91805a2e86;
        spiral_distance = var_43dce45c65e3abf3.spiral_distance;
        spiral_center = var_43dce45c65e3abf3.spiral_center;
        spiral_size = var_43dce45c65e3abf3.spiral_size;
        spiral_time = var_43dce45c65e3abf3.spiral_time;
        var_68adf9e2e6f7547b = var_43dce45c65e3abf3.var_68adf9e2e6f7547b;
        var_7d6a2b058ab80ed6 = var_43dce45c65e3abf3.var_7d6a2b058ab80ed6;
    }
    
    mask = utility::spawn_model( "tag_origin", spawn_loc, ( 0, 0, 0 ) );
    mask.health = 50;
    mask.old_pos = mask.origin;
    
    if ( isdefined( var_43dce45c65e3abf3 ) )
    {
        mask.health = var_43dce45c65e3abf3.mask_health;
    }
    
    mask_sbl = spawnscriptable( %"zm_sat_hornet_mq_f_mask", spawn_loc, spawn_angles );
    waitframe();
    mask_sbl utility::scriptable_setparententity( mask, ( 0, 0, 0 ), ( 0, 90, 90 ) );
    mask_sbl utility::function_7c10ea82c1e305b8( "projectile_fx", "missile_projectile" );
    mask_sbl utility::function_7c10ea82c1e305b8( "collision", "on" );
    mask_sbl utility::function_7c10ea82c1e305b8( "health", "fmask_damageable" );
    
    if ( !isdefined( level.hornet_mq.var_6407b410be8174bf ) )
    {
        level.hornet_mq.var_6407b410be8174bf = [];
    }
    
    level.hornet_mq.var_6407b410be8174bf[ level.hornet_mq.var_6407b410be8174bf.size ] = mask;
    
    if ( isdefined( var_43dce45c65e3abf3 ) )
    {
        mask_sbl utility::function_7c10ea82c1e305b8( "model", "mask_hannya" );
        mask_sbl utility::function_7c10ea82c1e305b8( "projectile_fx", "mask_projectile" );
        
        if ( var_7d6a2b058ab80ed6 )
        {
            mask.var_7d6a2b058ab80ed6 = 1;
        }
    }
    
    mask.remaining_lifetime = 7.5 * randomfloatrange( 0.75, 1 );
    
    if ( isdefined( var_20d0d91805a2e86 ) )
    {
        mask.remaining_lifetime = var_20d0d91805a2e86;
    }
    
    if ( !isdefined( spiral_distance ) )
    {
        spiral_distance = 100;
    }
    
    if ( !isdefined( spiral_center ) )
    {
        spiral_center = level.hornet_mq.onryo;
    }
    
    if ( !isdefined( var_68adf9e2e6f7547b ) )
    {
        var_68adf9e2e6f7547b = 0.5;
    }
    
    if ( !isdefined( spiral_time ) )
    {
        spiral_time = 1;
    }
    
    if ( !isdefined( spiral_size ) )
    {
        spiral_size = 100;
    }
    
    mask utility::follow_spiral( 0, spiral_size, ( 0, 0, 1 ), spiral_distance, spiral_time, spiral_center, var_68adf9e2e6f7547b, 0, f_starting_offset );
    mask thread function_76c8315e2eb68456( spawn_loc, spawn_angles, target, var_5277b69d1a8c7666, var_43dce45c65e3abf3 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 5
// Checksum 0x430d0eb9, Offset: 0x26b7d
// Size: 0x66d
function function_76c8315e2eb68456( spawn_loc, spawn_angles, target, var_5277b69d1a8c7666, var_43dce45c65e3abf3 = undefined )
{
    self endon( #"death" );
    mask = self;
    
    if ( isdefined( var_43dce45c65e3abf3 ) )
    {
        var_20d0d91805a2e86 = var_43dce45c65e3abf3.var_20d0d91805a2e86;
    }
    
    var_3da7de2a38c36ae3 = [];
    var_cf4746117daa5dc3 = 0;
    var_3773e7e597c6618c = 1 + randomfloat( 0.3 );
    step = 0.1;
    
    for ( speed = 25; mask.health > 0 && mask.remaining_lifetime > 0 ; speed = 25 * max( mask.remaining_lifetime / 1.25, 0.33 ) )
    {
        throttle::throttle_wait_in_queue( level.hornet_mq.onryo_fight_throttle, mask );
        
        if ( !isdefined( var_43dce45c65e3abf3 ) && ( !isalive( target ) || player::isinlaststand( target ) ) )
        {
            break;
        }
        
        if ( !isdefined( mask ) )
        {
            return;
        }
        
        if ( isdefined( var_43dce45c65e3abf3 ) && !isdefined( target ) )
        {
            target = function_c80123e7402eb296( mask.origin );
        }
        
        if ( !isdefined( var_43dce45c65e3abf3 ) && !mask.var_b15b1bc47e459d78 )
        {
            foreach ( player in level.players )
            {
                var_f1b807e36f506e21 = distance2dsquared( player getcentroid(), mask.origin );
                
                if ( var_f1b807e36f506e21 <= 625 )
                {
                    var_bc0e2be7e0b6e71c = player;
                    break;
                }
            }
            
            if ( var_bc0e2be7e0b6e71c )
            {
                break;
            }
        }
        else if ( mask.var_b15b1bc47e459d78 )
        {
            var_f1b807e36f506e21 = distance2dsquared( target getcentroid(), mask.origin );
            
            if ( var_f1b807e36f506e21 <= 625 )
            {
                break;
            }
        }
        
        forward = anglestoforward( mask.angles );
        result = trace::ray_trace( mask.origin, mask.origin + forward * 25, undefined, undefined, 1, 1 );
        
        if ( result[ "hittype" ] == "hittype_world" && result[ "fraction" ] >= 0.5 )
        {
            break;
        }
        
        var_3773e7e597c6618c += step;
        
        if ( var_5277b69d1a8c7666 > 0 && var_3773e7e597c6618c >= 1 )
        {
            if ( !isdefined( var_43dce45c65e3abf3 ) )
            {
                var_3773e7e597c6618c = 0;
                nav_start = getclosestpointonnavmesh( mask.origin ) ?? undefined;
                
                if ( isplayer( target ) || isbot( target ) || isai( target ) )
                {
                    nav_end = getclosestpointonnavmesh( target.origin ) ?? undefined;
                }
                else
                {
                    nav_end = getclosestpointonnavmesh( target ) ?? undefined;
                }
                
                if ( isdefined( nav_start ) && isdefined( nav_end ) )
                {
                    var_3da7de2a38c36ae3 = findpathcustom( nav_start, nav_end );
                    var_cf4746117daa5dc3 = 0;
                }
                else
                {
                    var_3da7de2a38c36ae3 = [];
                }
            }
            else if ( distance2dsquared( mask.origin, target ) < 10000 )
            {
                target = function_c80123e7402eb296( target );
                
                if ( isdefined( nav_start ) && isdefined( nav_end ) )
                {
                    var_3da7de2a38c36ae3 = findpathcustom( nav_start, nav_end );
                    var_cf4746117daa5dc3 = 0;
                }
                else
                {
                    var_3da7de2a38c36ae3 = [];
                }
            }
        }
        
        if ( var_3da7de2a38c36ae3.size > 0 && var_cf4746117daa5dc3 < var_3da7de2a38c36ae3.size - 1 )
        {
            if ( distance2dsquared( mask.origin, var_3da7de2a38c36ae3[ var_cf4746117daa5dc3 ] ) <= 10000 )
            {
                var_cf4746117daa5dc3++;
            }
        }
        
        total_lifetime = var_20d0d91805a2e86 ?? 7.5;
        
        if ( isplayer( target ) || isbot( target ) || isai( target ) )
        {
            direct_target = target getcentroid() + mask.remaining_lifetime / total_lifetime * ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) * 85 + ( 0, 0, 5 );
        }
        else
        {
            direct_target = target + mask.remaining_lifetime / total_lifetime * ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) * 85 + ( 0, 0, 5 );
        }
        
        if ( var_3da7de2a38c36ae3.size > 0 )
        {
            nav_pt = var_3da7de2a38c36ae3[ var_cf4746117daa5dc3 ];
            var_58ece150154635c = ( nav_pt[ 0 ], nav_pt[ 1 ], nav_pt[ 2 ] + 85 );
        }
        else
        {
            var_58ece150154635c = direct_target;
        }
        
        target_pos = vectorlerp( direct_target, var_58ece150154635c, var_5277b69d1a8c7666 );
        var_da20088ae67ad678 = target_pos - mask.origin;
        ang_to_target = vectortoangles( var_da20088ae67ad678 );
        current_angles = mask.angles;
        angular_delta = abs( angleclamp180( ang_to_target[ 1 ] - current_angles[ 1 ] ) );
        inertia_factor = 1 - angular_delta / 180 * 0.85;
        new_pos = mask.origin + forward * speed * inertia_factor;
        mask moveto( new_pos, step );
        total_lifetime = var_20d0d91805a2e86 ?? 7.5;
        roll_ang = mask.remaining_lifetime / total_lifetime * randomfloatrange( -1, 1 ) * 85;
        ang_to_target = ( ang_to_target[ 0 ], ang_to_target[ 1 ], roll_ang );
        mask rotateto( ang_to_target, step );
        mask.old_pos = mask.origin;
        wait step;
        mask.remaining_lifetime -= step;
        total_lifetime = var_20d0d91805a2e86 ?? 7.5;
        
        if ( mask.remaining_lifetime < total_lifetime / 6 )
        {
        }
    }
    
    if ( !mask.b_returning )
    {
        if ( mask.var_b15b1bc47e459d78 )
        {
            mask thread function_5782067a20f23027( 0, 1, undefined );
            return;
        }
        
        if ( !isdefined( var_43dce45c65e3abf3 ) )
        {
            mask thread function_5782067a20f23027( 0, 1, var_bc0e2be7e0b6e71c );
            return;
        }
        
        mask thread function_5782067a20f23027( 1, 0, var_bc0e2be7e0b6e71c );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x28fdb15, Offset: 0x271f2
// Size: 0x128
function function_c80123e7402eb296( var_ee7d95e51e1e54f2 )
{
    var_e4036970b3306a95 = utility::function_b7f3d374aa10aa51( "oyo_m_move_struct", "targetname", var_ee7d95e51e1e54f2, 400 );
    
    if ( !var_e4036970b3306a95 || var_e4036970b3306a95.size <= 1 )
    {
        var_e4036970b3306a95 = utility::getstructarray( "oyo_m_move_struct", "targetname" );
    }
    
    var_dfa493471c9ac822 = utility::function_b7f3d374aa10aa51( "oyo_m_move_struct", "targetname", var_ee7d95e51e1e54f2, 110 );
    var_812efba24055d1a9 = [];
    
    foreach ( possible_target in var_e4036970b3306a95 )
    {
        if ( !arraycontains( var_dfa493471c9ac822, possible_target ) )
        {
            var_812efba24055d1a9[ var_812efba24055d1a9.size ] = possible_target;
        }
    }
    
    if ( var_812efba24055d1a9.size == 0 )
    {
        var_812efba24055d1a9 = utility::getstructarray( "oyo_m_move_struct", "targetname" );
    }
    
    var_5990ce3727e634d1 = utility::array_random( var_812efba24055d1a9 );
    return var_5990ce3727e634d1.origin;
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0x2ec349e5, Offset: 0x27323
// Size: 0x320
function function_5782067a20f23027( var_7c5da28c24f117ca = 1, b_dodamage = 1, var_bc0e2be7e0b6e71c = undefined, var_b15b1bc47e459d78 = 0 )
{
    level endon( #"game_ended" );
    mask_sbl = self.linkedchildren[ 0 ];
    mask = self;
    
    if ( var_7c5da28c24f117ca )
    {
        forward = anglestoforward( mask.angles );
        forward_point = mask.origin + forward * 45;
        dest = getclosestpointonnavmesh( forward_point );
        control_pos = dest + ( 0, 0, 60 );
        mask utility::function_8001268940441423( mask.origin, dest, control_pos, 0.8 );
        
        if ( mask.var_7d6a2b058ab80ed6 )
        {
            level notify( #"hash_b5b2753b53b16cd2", dest );
        }
        else if ( !b_dodamage && !level utility::flag( "hornet_mq_onryo_killed" ) )
        {
            mask_type = randomintrange( 0, 5 );
            spawner = { #angles:( 0, 0, 0 ), #origin:dest };
            level thread function_bffc448792f681e2( mask_type, spawner, 1 );
        }
    }
    
    mask_sbl utility::scriptable_clearparententity();
    mask_sbl utility::function_7c10ea82c1e305b8( "projectile_fx", "impact" );
    
    if ( b_dodamage )
    {
        if ( !var_b15b1bc47e459d78 )
        {
            nearby_players = getplayersinradius( mask.origin, 150 );
            
            foreach ( player in nearby_players )
            {
                var_f1b807e36f506e21 = distance2dsquared( player.origin, mask.origin );
                
                if ( var_f1b807e36f506e21 > 10000 )
                {
                    dmg_mod = 1 - var_f1b807e36f506e21 / 2500;
                }
                else
                {
                    dmg_mod = 1;
                }
                
                dmg = 45 * dmg_mod;
                dmg = clamp( dmg, 17, 45 );
                player dodamage( dmg, mask.origin, mask, mask, "MOD_EXPLOSIVE", level.weaponnone, "none", undefined, 1073741824 );
            }
            
            if ( var_bc0e2be7e0b6e71c )
            {
            }
        }
        else
        {
            level.hornet_mq.onryo dodamage( level.hornet_mq.onryo.maxhealth * 1.5, mask.origin );
        }
    }
    
    if ( mask )
    {
        mask delete();
    }
    
    if ( mask_sbl )
    {
        mask_sbl utility::delaycall( 0.5, &freescriptable );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x67b1f179, Offset: 0x2764b
// Size: 0x9e
function function_a8b47b90b47172fe()
{
    foreach ( projectile in level.hornet_mq.var_6407b410be8174bf )
    {
        projectile thread function_5782067a20f23027( 1, 0, undefined );
    }
    
    level.hornet_mq.var_6407b410be8174bf = [];
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x831c4d5d, Offset: 0x276f1
// Size: 0x1a7
function function_4bd1adbc952a8d7( spawn_loc )
{
    orb = spawnscriptable( "zm_sat_hornet_mq_oyo_orb", spawn_loc + ( 0, 0, 5 ), ( 0, 0, 0 ) );
    time_elapsed = 0;
    step = 0.1;
    collecting_player = undefined;
    
    while ( time_elapsed < 10 )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, orb.origin ) < 1600 )
            {
                collecting_player = player;
                break;
            }
        }
        
        if ( collecting_player )
        {
            break;
        }
        
        if ( time_elapsed >= 5 && !orb.b_isflickering )
        {
            orb.b_isflickering = 1;
            orb utility::function_7c10ea82c1e305b8( "fx", "flicker" );
        }
        
        time_elapsed += step;
        wait step;
    }
    
    if ( collecting_player )
    {
        collecting_player.health = int( min( collecting_player.health + 20, collecting_player.maxhealth ) );
    }
    
    orb utility::function_7c10ea82c1e305b8( "fx", "grabbed" );
    orb utility::delaycall( 0.5, &freescriptable );
}

// Namespace zm_sat_hornet_mq_quest
// Params 11
// Checksum 0x9ffbcdc5, Offset: 0x278a0
// Size: 0x18f
function function_85c2993ebeb16844( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "zm_sat_hornet_mq_f_mask" )
    {
        return;
    }
    
    if ( !instance.linkedparent )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( instance.linkedparent.health - idamage <= 0 )
    {
        var_838caad217384a1b = 1;
        instance.b_returning = 1;
        eattacker damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
    }
    else
    {
        eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
    }
    
    instance.linkedparent.health -= idamage;
    
    if ( var_838caad217384a1b && isdefined( objweapon ) && objweapon.basename == "sat_ww_hornet_zm" )
    {
        cached_origin = instance.linkedparent.origin;
        cached_angles = instance.linkedparent.angles;
        level thread function_258d19d800cb47c3( cached_origin, cached_angles );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6363f402, Offset: 0x27a37
// Size: 0x3b4
function function_bec07aed081d6e54( onryo )
{
    level endon( #"game_ended" );
    onryo endon( #"death" );
    
    if ( onryo.var_e93bd4609ecde646 )
    {
        return;
    }
    
    onryo.var_e93bd4609ecde646 = 1;
    level utility::flag_set( "onryo_multi_mask_active" );
    level function_ecc91637c2a6fbb1();
    onryo.var_99ae508ac039ff18 = 1;
    level function_a8b47b90b47172fe();
    spawn_center = onryo.origin;
    onryo val::set( "mq_hvt_oyo_val_ref", "damage", 0 );
    onryo val::set( "mq_hvt_oyo_val_ref", "death", 0 );
    onryo val::set( "mq_hvt_oyo_val_ref", "show_healthbar", 0 );
    fx = spawnscriptable( "zm_sat_hornet_mq_oyo_fx", spawn_center );
    fx utility::function_7c10ea82c1e305b8( "fx", "multi_mask" );
    fx utility::delaycall( 2, &freescriptable );
    tp_loc = utility::getstruct( "oyo_mm_tp_loc", "targetname" );
    onryo setorigin( tp_loc.origin );
    onryo thread function_100f383be6d5cd50( tp_loc.origin );
    onryo utility::function_7c10ea82c1e305b8( "icon", "idle" );
    onryo.b_ignore_death_perception = 1;
    onryo.var_2fc3a5fb762afb6e = 1;
    var_5f4d19ee2f1cae92 = { #origin:onryo.origin };
    tp_attractor = onryo zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_5f4d19ee2f1cae92, 3, undefined, 0 );
    num_masks = level.players.size > 1 ? 9 : 6;
    var_5b6032ba97fa81f0 = randomintrange( 0, num_masks );
    a_spawn_locs = utility::function_950fed9c7e18b522( spawn_center, 30, num_masks, 0 );
    
    for ( i = 0; i < num_masks ; i++ )
    {
        loc = a_spawn_locs[ i ];
        v_starting_offset = vectortoangles( loc - spawn_center );
        f_starting_offset = v_starting_offset[ 1 ];
        spawn_angle = v_starting_offset + ( 0, 90, 90 );
        var_43dce45c65e3abf3 = {};
        var_43dce45c65e3abf3.spiral_dist = 50;
        var_43dce45c65e3abf3.var_68adf9e2e6f7547b = 1.5;
        var_43dce45c65e3abf3.spiral_time = 0.75;
        var_43dce45c65e3abf3.spiral_size = 50;
        var_43dce45c65e3abf3.var_20d0d91805a2e86 = 9999;
        var_43dce45c65e3abf3.var_7d6a2b058ab80ed6 = i == var_5b6032ba97fa81f0 ? 1 : 0;
        var_43dce45c65e3abf3.spiral_center = spawn_center;
        var_43dce45c65e3abf3.mask_health = 5;
        level thread function_327ff5cd89d75d8a( loc, spawn_angle, f_starting_offset, undefined, 0.95, var_43dce45c65e3abf3 );
    }
    
    level waittill( #"hash_b5b2753b53b16cd2", var_c23a8cb334b43f16 );
    level utility::flag_clear( "onryo_multi_mask_active" );
    level function_ecc91637c2a6fbb1();
    level function_a8b47b90b47172fe();
    onryo zombie_attractor_manager::function_dcfb4c31f1d97cd2( tp_attractor );
    onryo setorigin( var_c23a8cb334b43f16 );
    onryo utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_traverse_teleport" );
    onryo utility::function_7c10ea82c1e305b8( "icon", "active" );
    onryo.b_ignore_death_perception = 0;
    onryo.var_2fc3a5fb762afb6e = 0;
    onryo val::reset_all( "mq_hvt_oyo_val_ref" );
    onryo.var_99ae508ac039ff18 = 0;
    var_772501ce9a0c24da = 0.85;
    onryo zombie_stun::stun_ai( var_772501ce9a0c24da, "stunned_on" );
    wait var_772501ce9a0c24da;
    onryo.var_e93bd4609ecde646 = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x4101a6e5, Offset: 0x27df3
// Size: 0x5d
function function_100f383be6d5cd50( tp_loc )
{
    self endon( #"death" );
    level endon( #"hash_b5b2753b53b16cd2" );
    
    while ( self.var_e93bd4609ecde646 )
    {
        wait 0.1;
        
        if ( distance2dsquared( self.origin, tp_loc ) >= 2500 )
        {
            self setorigin( tp_loc );
            continue;
        }
        
        break;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x25ae85df, Offset: 0x27e58
// Size: 0x11a
function function_258d19d800cb47c3( spawn_loc, spawn_angles )
{
    mask = utility::spawn_model( "tag_origin", spawn_loc, ( 0, 0, 0 ) );
    mask.health = 50;
    mask.remaining_lifetime = 3.75;
    mask.old_pos = mask.origin;
    mask.var_b15b1bc47e459d78 = 1;
    mask_sbl = spawnscriptable( %"zm_sat_hornet_mq_f_mask", spawn_loc, spawn_angles );
    waitframe();
    mask_sbl utility::scriptable_setparententity( mask, ( 0, 0, 0 ), ( 0, 90, 90 ) );
    mask_sbl utility::function_7c10ea82c1e305b8( "projectile_fx", "missile_projectile" );
    mask_sbl utility::function_7c10ea82c1e305b8( "collision", "on" );
    mask_sbl utility::function_7c10ea82c1e305b8( "health", "fmask_damageable" );
    mask thread function_76c8315e2eb68456( spawn_loc, spawn_angles, level.hornet_mq.onryo, 0.6 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xaa02701, Offset: 0x27f7a
// Size: 0x18b
function function_886f2a5ba054ca92()
{
    level endon( #"game_ended" );
    level.hornet_mq.onryo endon( #"death" );
    level.hornet_mq.var_f62d4df2791ba151 = getent( "mq_oyo_enct_trig", #targetname );
    level.hornet_mq.var_f62d4df2791ba151.occupants = [];
    level.hornet_mq.var_f62d4df2791ba151 childthread function_1f111599e0f24fc1();
    var_cfdcb332178e0755 = [ "zone_main_bailey_a", "zone_main_bailey_b", "zone_main_bailey_c" ];
    var_a65a556e144e8c0b = zone_spawner::function_20c574a6ba7cc5c6( var_cfdcb332178e0755, "zombie_base" );
    
    while ( true )
    {
        level.hornet_mq.var_f62d4df2791ba151.occupants = utility::array_removedead_or_dying( level.hornet_mq.var_f62d4df2791ba151.occupants );
        baseline = level.players.size > 1 ? 20 : 10;
        
        if ( level.hornet_mq.var_f62d4df2791ba151.occupants.size < baseline )
        {
            spawner = utility::array_random( var_a65a556e144e8c0b );
            mask_type = randomintrange( 0, 5 );
            level function_bffc448792f681e2( mask_type, spawner, 1 );
        }
        
        wait 3;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x139ed1a7, Offset: 0x2810d
// Size: 0x66
function function_1f111599e0f24fc1()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isagent( ent ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.occupants, ent ) )
        {
            self.occupants[ self.occupants.size ] = ent;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xccb6152, Offset: 0x2817b
// Size: 0x6f
function function_26536f8132157ac5( params )
{
    if ( self.health - params.idamage > 0 )
    {
        return;
    }
    
    val::set( "mq_hvt_oyo_val_ref", "damage", 0 );
    val::set( "mq_hvt_oyo_val_ref", "death", 0 );
    val::set( "mq_hvt_oyo_val_ref", "show_healthbar", 0 );
    thread function_423bd68813cf1b66( params.eattacker );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xab0535ef, Offset: 0x281f2
// Size: 0xbf
function function_423bd68813cf1b66( attacker )
{
    if ( self.var_decdde16c256c29b )
    {
        return;
    }
    
    self.var_decdde16c256c29b = 1;
    fx = spawnscriptable( "zm_sat_hornet_mq_oyo_fx", self.origin, self.angles );
    fx utility::function_7c10ea82c1e305b8( "fx", "disappear" );
    zombie_stun::stun_ai( 2, "stunned_on" );
    wait 2;
    warp_locs = utility::getstructarray( "mq_oyo_ptp_exit_loc", "targetname" );
    warp_locs = arrayrandomize( warp_locs );
    val::reset_all( "mq_hvt_oyo_val_ref" );
    fx freescriptable();
    level thread function_91fc1a986ea964d4( attacker );
    self kill( self.origin, attacker );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x76cf6ce6, Offset: 0x282b9
// Size: 0x179
function function_91fc1a986ea964d4( attacker )
{
    vo_start_time = gettime();
    var_582aac4888813da8 = 9;
    
    if ( isplayer( attacker ) )
    {
        attacker function_2a6deff157d1165a( #"hash_40d0ca564af6f37a", #"bc_flavor_player_positive", 1 );
        
        if ( !attacker namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            wait var_582aac4888813da8;
        }
    }
    else
    {
        selected_player = undefined;
        b_is_hero = 0;
        
        foreach ( player in level.players )
        {
            if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
            {
                selected_player = player;
                b_is_hero = 1;
                break;
            }
        }
        
        if ( !isdefined( selected_player ) )
        {
            selected_player = utility::array_random( level.players );
        }
        
        selected_player function_2a6deff157d1165a( #"hash_40d0ca564af6f37a", #"bc_flavor_player_positive", 1 );
        
        if ( !b_is_hero )
        {
            wait var_582aac4888813da8;
        }
    }
    
    for ( current_time = gettime(); utility::function_6f5d2e1f1ff70482( current_time ) <= utility::function_6f5d2e1f1ff70482( vo_start_time ) + var_582aac4888813da8 ; current_time = gettime() )
    {
        wait 0.1;
    }
    
    level utility::flag_set( "hornet_mq_onryo_defeat_vo_played" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe7efd8df, Offset: 0x2843a
// Size: 0xc
function function_1ba9a9bc5c85bd1b( params )
{
    
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x7756556, Offset: 0x2844e
// Size: 0x6d
function equipfoxmask()
{
    self endon( #"death_or_disconnect" );
    weaponnone = makeweapon( "none" );
    curweap = self getcurrentweapon();
    self.var_90333b71551aeac0 = 1;
    wait 0.338;
    self.var_90333b71551aeac0 = 0;
    self.foxmaskequipped = 1;
    function_f208aae54c373165( 0, 0 );
    self notify( #"foxmask_equipped" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdcc04ff8, Offset: 0x284c3
// Size: 0x9d
function removefoxmask()
{
    self endon( #"death_or_disconnect" );
    
    if ( !self.foxmaskequipped )
    {
        return;
    }
    
    weaponnone = makeweapon( "none" );
    curweap = self getcurrentweapon();
    
    if ( !issameweapon( curweap, weaponnone ) )
    {
        utility::callsharedfunc( #"gasmask", #"playequipgesture", 0 );
    }
    
    self.var_90333b71551aeac0 = 1;
    wait 0.521;
    self.var_90333b71551aeac0 = 0;
    self.foxmaskequipped = 0;
    function_a93bcdcd417490f7();
    self notify( #"hash_d0802e928dce8a31" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xdab87a77, Offset: 0x28568
// Size: 0x17e
function function_f208aae54c373165( fadeintime, delaytime )
{
    self.foxmaskoverlay = newclienthudelem( self );
    self.foxmaskoverlay.x = 0;
    self.foxmaskoverlay.y = 0;
    self.foxmaskoverlay.alignx = "left";
    self.foxmaskoverlay.aligny = "top";
    self.foxmaskoverlay.horzalign = "fullscreen";
    self.foxmaskoverlay.vertalign = "fullscreen";
    self.foxmaskoverlay setshader( "foxmask_overlay_delta", 640, 480 );
    self.foxmaskoverlay.sort = -10;
    self.foxmaskoverlay.archived = 1;
    
    if ( isbrgamemode() )
    {
        self.foxmaskoverlay.alpha = 0;
        
        if ( isdefined( fadeintime ) )
        {
            if ( isdefined( delaytime ) )
            {
                wait delaytime;
            }
            
            if ( isdefined( self.foxmaskoverlay ) )
            {
                self.foxmaskoverlay fadeovertime( fadeintime );
            }
        }
    }
    
    if ( isdefined( self.foxmaskoverlay ) )
    {
        self.foxmaskoverlay.alpha = 1;
        self.foxmaskoverlay.lowresbackground = 1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x3b345be8, Offset: 0x286ee
// Size: 0x4e
function function_96250850bbe198df( fadeouttime )
{
    self.foxmaskoverlay.alpha = 1;
    self.foxmaskoverlay fadeovertime( fadeouttime );
    self.foxmaskoverlay.alpha = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x8a0c4c84, Offset: 0x28744
// Size: 0x89
function function_a93bcdcd417490f7( fadeouttime, delaytime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.foxmaskoverlay ) )
    {
        return;
    }
    
    if ( isdefined( fadeouttime ) )
    {
        if ( isdefined( delaytime ) )
        {
            wait delaytime;
        }
        
        if ( isdefined( self.foxmaskoverlay ) )
        {
            function_96250850bbe198df( fadeouttime );
            wait fadeouttime;
        }
    }
    
    if ( isdefined( self.foxmaskoverlay ) )
    {
        self.foxmaskoverlay destroy();
        self.foxmaskoverlay = undefined;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 3, eflags: 0x4
// Checksum 0x1144d46d, Offset: 0x287d5
// Size: 0x1e1
function private function_89266a24d0006d65( subclass, var_84fd8ed7c7b06f95, additional_params )
{
    if ( isstring( var_84fd8ed7c7b06f95 ) )
    {
        zone = utility::getstruct( var_84fd8ed7c7b06f95, "targetname" );
        zombie = agent_spawner::spawn_agent_custom( subclass, "zone", { #zones:[ zone ] } );
    }
    else if ( isstruct( var_84fd8ed7c7b06f95 ) )
    {
        zombie = agent_manager::spawn_agent( subclass, var_84fd8ed7c7b06f95.origin, var_84fd8ed7c7b06f95.angles, "team_two_hundred" );
    }
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    zombie endon( #"death" );
    throttle::throttle_wait_in_queue( level.hornet_mq.throttle, zombie );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( isdefined( additional_params ) )
    {
        if ( additional_params.b_ignore_idle_eyes )
        {
            zombie.var_a8fa61d92872fc74 = 1;
        }
        
        if ( additional_params.round_override )
        {
            round_override = additional_params.round_override;
        }
        
        if ( additional_params.var_241efc7b886a40e2 )
        {
            var_241efc7b886a40e2 = additional_params.var_241efc7b886a40e2;
        }
        
        if ( additional_params.var_42598999191bb358 )
        {
            zombie.disable_spawn_vfx = 1;
        }
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    round_difficulty = round_number;
    
    if ( round_override )
    {
        if ( round_override > round_difficulty )
        {
            round_difficulty = round_override;
        }
    }
    
    zombie zombie_utils::set_zombie_round_difficulty( round_difficulty );
    
    if ( var_241efc7b886a40e2 && isdefined( zombie ) )
    {
        zombie zombie_utils::function_a8ce00e0448cb6f0( var_241efc7b886a40e2, "mq_quest_generic_spawn_speed_override", 6 );
    }
    
    zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
    zombie.ignore_enemy_count = 1;
    zombie.kiastring = #"zombie_kia_mission_kill";
    return zombie;
}

// Namespace zm_sat_hornet_mq_quest
// Params 5, eflags: 0x4
// Checksum 0x5c8d8d18, Offset: 0x289bf
// Size: 0x117
function private function_8b9daf36eb8b2e7e( spawn_origin, goal_position, var_5a349ab68e4b2fdf = 0, move_duration = 1, var_5308a14af7d8f7b3 = "purple" )
{
    trail = utility::spawn_model( %"tag_origin", spawn_origin );
    trail.scr_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", trail.origin, trail.angles );
    waitframe();
    trail.scr_fx utility::scriptable_setparententity( trail );
    trail.scr_fx utility::function_7c10ea82c1e305b8( "visual", var_5308a14af7d8f7b3 );
    trail moveto( goal_position, move_duration, move_duration / 4 );
    trail waittill( #"movedone" );
    trail.scr_fx utility::function_7c10ea82c1e305b8( "impact", var_5308a14af7d8f7b3 );
    waitframe();
    trail.scr_fx freescriptable();
    trail delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 6, eflags: 0x4
// Checksum 0x1baf5df, Offset: 0x28ade
// Size: 0x168
function private function_8f370c37e2e751f2( spawn_origin, goal_position, var_5a349ab68e4b2fdf, move_duration, var_5308a14af7d8f7b3 = "purple", var_49d82b40197d0b6e = undefined )
{
    control_pos = ( spawn_origin + goal_position ) / 2 + ( 0, 0, randomfloatrange( 30, 55 ) );
    
    if ( !isdefined( var_5a349ab68e4b2fdf ) )
    {
        var_5a349ab68e4b2fdf = 0;
    }
    
    if ( !isdefined( move_duration ) )
    {
        move_duration = 1;
    }
    
    trail = utility::spawn_model( %"tag_origin", spawn_origin );
    trail.scr_fx = spawnscriptable( %"zm_sat_hornet_mq_trail", trail.origin, trail.angles );
    waitframe();
    trail.scr_fx utility::scriptable_setparententity( trail );
    trail.scr_fx utility::function_7c10ea82c1e305b8( "visual", var_5308a14af7d8f7b3 );
    path_percent = var_49d82b40197d0b6e.path_percent ?? 1;
    trail utility::function_8001268940441423( spawn_origin, goal_position, control_pos, move_duration, 0, 0, path_percent );
    trail.scr_fx utility::function_7c10ea82c1e305b8( "impact", var_5308a14af7d8f7b3 + "_impact" );
    trail.scr_fx utility::delaycall( 1, &freescriptable );
    trail utility::delaycall( 1, &delete );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3, eflags: 0x4
// Checksum 0xb6554954, Offset: 0x28c4e
// Size: 0x93
function private mq_drop_item( bundle, origin, angles = undefined )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    itembundle = getscriptbundle( bundle );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin, angles );
    spawnoptions.critical = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    return item;
}

// Namespace zm_sat_hornet_mq_quest
// Params 3, eflags: 0x4
// Checksum 0xa3c42b67, Offset: 0x28cea
// Size: 0x93
function private mq_spawn_item( bundle, origin, angles = undefined )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    itembundle = getscriptbundle( bundle );
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.critical = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    return item;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0xe7047398, Offset: 0x28d86
// Size: 0xa88
function private quest_item_used( params )
{
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    
    switch ( itembundle.ref )
    {
        case #"hash_f508beeca306a11d":
            level utility::flag_set( "mq_step_15_complete" );
            level function_9947038abd0d1056( #"pstle", player );
            misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            misc_item_data = utility::set_bit_flag( misc_item_data, 3 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
            player thread function_2a6deff157d1165a( #"hash_e21cbe3b3ef5b6eb", #"hash_5212ed7ec42f115a", 1.25 );
            return;
        case #"hash_2031afad21bebf07":
            level function_fd1996af0db6a8ca( 13 );
            level function_9947038abd0d1056( #"hank", player );
            level thread function_a458e12004e428f1( item.origin );
            return;
        case #"hash_37d6402e2bfc3062":
            level utility::flag_set( "mq_player_got_ev_sus_p" );
            level function_fd1996af0db6a8ca( 2 );
            level function_9947038abd0d1056( #"pip", player );
            level utility::delaycall( level.framedurationseconds, &function_1805638627b4a07e, [ 0, 1, 2 ], "mq_step_7_complete" );
            level thread function_a458e12004e428f1( item.origin );
            
            if ( isdefined( player ) && !level utility::flag( "hornet_mq_first_ev_sus_picked_up" ) )
            {
                level utility::flag_set( "hornet_mq_first_ev_sus_picked_up" );
                player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
            }
            
            return;
        case #"hash_ca0bdfc4a4594d6a":
            level utility::flag_set( "mq_player_got_ev_sus_ca" );
            level function_fd1996af0db6a8ca( 1 );
            level function_9947038abd0d1056( #"case", player );
            level utility::delaycall( level.framedurationseconds, &function_1805638627b4a07e, [ 0, 1, 2 ], "mq_step_7_complete" );
            level thread function_a458e12004e428f1( item.origin );
            
            if ( isdefined( player ) && !level utility::flag( "hornet_mq_first_ev_sus_picked_up" ) )
            {
                level utility::flag_set( "hornet_mq_first_ev_sus_picked_up" );
                player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
            }
            
            return;
        case #"hash_625514c46e05cfbf":
            level utility::flag_set( "mq_player_got_ev_sus_co" );
            level function_fd1996af0db6a8ca( 0 );
            level function_9947038abd0d1056( #"cmb", player );
            level utility::delaycall( level.framedurationseconds, &function_1805638627b4a07e, [ 0, 1, 2 ], "mq_step_7_complete" );
            level thread function_a458e12004e428f1( item.origin );
            
            if ( isdefined( player ) && !level utility::flag( "hornet_mq_first_ev_sus_picked_up" ) )
            {
                level utility::flag_set( "hornet_mq_first_ev_sus_picked_up" );
                player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
            }
            
            return;
        case #"hash_3bc1dce00de56fa0":
            level utility::flag_set( "mq_player_got_ev_acc_g" );
            level function_fd1996af0db6a8ca( 3 );
            level function_9947038abd0d1056( #"shrs", player );
            level function_1805638627b4a07e( [ 3, 4, 5 ], "mq_step_12_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_7030515691c2e08c", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_312be53c579757df":
            level utility::flag_set( "mq_player_got_ev_acc_n" );
            level function_fd1996af0db6a8ca( 4 );
            level function_9947038abd0d1056( #"hat", player );
            level function_1805638627b4a07e( [ 3, 4, 5 ], "mq_step_12_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_27333e8fd5878f5c", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_2eec3c363ac7bb31":
            level utility::flag_set( "mq_player_got_ev_acc_m" );
            level function_fd1996af0db6a8ca( 5 );
            level function_9947038abd0d1056( #"abc", player );
            level function_1805638627b4a07e( [ 3, 4, 5 ], "mq_step_12_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_8d892dd16a7eaba5", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_c4cb7aa808e62fc0":
            level utility::flag_set( "mq_player_got_f_poi" );
            level function_fd1996af0db6a8ca( 7 );
            level function_9947038abd0d1056( #"fug", player );
            level function_1805638627b4a07e( [ 6, 7, 8 ], "mq_step_19_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_28ee8576b55b50e6", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_4d055f2e36ceadc0":
            level utility::flag_set( "mq_player_got_p_poi" );
            level function_fd1996af0db6a8ca( 8 );
            level function_9947038abd0d1056( #"ppts", player );
            level function_1805638627b4a07e( [ 6, 7, 8 ], "mq_step_19_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_a98ae3af391c1d77", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_edff6ae1cac7d4c5":
            level utility::flag_set( "mq_player_got_fl_poi" );
            level function_fd1996af0db6a8ca( 6 );
            level function_9947038abd0d1056( #"hash_353d73dcd4cf7d1", player );
            level function_1805638627b4a07e( [ 6, 7, 8 ], "mq_step_19_complete" );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_c3d972e9c5772bb9", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_eb880dbe57f08565":
            level utility::flag_set( "mq_player_got_fbud" );
            level function_9947038abd0d1056( #"hash_345ff3dcd40fe6d", player );
            level setup_planter_interact();
            misc_item_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            misc_item_data = utility::set_bit_flag( misc_item_data, 4 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", misc_item_data );
            player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_positive", 0.5 );
            return;
        case #"hash_15771bba77e2f815":
            level utility::flag_set( "mq_player_got_pch" );
            level function_9947038abd0d1056( #"pch", player );
            level function_8378410e50e85615();
            level thread function_98352a2c73c286b4();
            player thread function_2a6deff157d1165a( #"hash_2bd4878806ab0471", #"hash_5212ed7ec42f115a" );
            return;
        case #"hash_1261f9c8b7538a7e":
            level function_fd1996af0db6a8ca( 9 );
            level function_9947038abd0d1056( #"twsk", player );
            level function_1805638627b4a07e( [ 9, 10, 11 ], "mq_step_26_complete" );
            level utility::delaycall( level.framedurationseconds, &function_ecc91637c2a6fbb1 );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_f1d44c74ac39c5a0", #"hash_5212ed7ec42f115a", 0.25 );
            return;
        case #"hash_9414996bb10d2292":
            level function_fd1996af0db6a8ca( 10 );
            level function_9947038abd0d1056( #"cal_kt", player );
            level function_1805638627b4a07e( [ 9, 10, 11 ], "mq_step_26_complete" );
            level utility::delaycall( level.framedurationseconds, &function_ecc91637c2a6fbb1 );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_ae71fc6004fdd44b", #"hash_5212ed7ec42f115a", 0.25 );
            return;
        case #"hash_908bf187cb226e0b":
            level function_fd1996af0db6a8ca( 11 );
            level function_9947038abd0d1056( #"hrs", player );
            level function_1805638627b4a07e( [ 9, 10, 11 ], "mq_step_26_complete" );
            level utility::delaycall( level.framedurationseconds, &function_ecc91637c2a6fbb1 );
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_635c27e7fc559b45", #"hash_5212ed7ec42f115a", 0.25 );
            return;
        case #"hash_608b8e5f66cbb247":
            level utility::flag_set( "mq_step_28_complete" );
            return;
        case #"hash_f82aab8b1d66f821":
            level function_fd1996af0db6a8ca( 12 );
            level function_9947038abd0d1056( #"hash_b5616090e87b63f5", player );
            level utility::flag_set( "mq_player_got_ev_mot_take" );
            level function_ecc91637c2a6fbb1();
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_602bb77309fffe1b", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_c85e8cac00eacd":
            level function_fd1996af0db6a8ca( 14 );
            level function_9947038abd0d1056( #"med", player );
            level utility::flag_set( "mq_step_31_complete" );
            level function_ecc91637c2a6fbb1();
            level thread function_a458e12004e428f1( item.origin );
            player thread function_2a6deff157d1165a( #"hash_b807d38f8f67a62c", #"bc_flavor_player_positive", 0.25 );
            return;
        case #"hash_a07d29f60b9b2ee5":
            level function_9947038abd0d1056( #"hash_77f372195699d154", player );
            level utility::flag_set( "mq_step_9_complete" );
            player thread function_2a6deff157d1165a( #"hash_ef04c7e2e1e2527f", #"hash_5212ed7ec42f115a", 0.25 );
            return;
        default:
            return;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 6, eflags: 0x4
// Checksum 0x9cb683a5, Offset: 0x29816
// Size: 0x108
function private function_44da2a208ba2b248( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    switch ( instance.type )
    {
        case #"hash_dd5e00c056a94e7b":
            function_ba82c5ccc4f941d6( instance, part, state, player, bautouse, usestring );
            break;
        case #"hash_9072ea37fee00aff":
            function_778c2d8f2240c88a( instance, part, state, player, bautouse, usestring );
            break;
        case #"hash_77ace9135031b2da":
            function_4f7a810805fa1c9f( instance, part, state, player, bautouse, usestring );
            break;
        case #"hash_a4fc9047daa13c2a":
            function_82be991de4ef9308( instance, part, state, player, bautouse, usestring );
            break;
        case #"hash_d7b27617ab8682aa":
            function_389ce5fca9aeb74b( instance, part, state, player, bautouse, usestring );
            break;
        case #"hash_913fa536745ad4cc":
            function_7405f53addf7ae1e( instance, part, state, player, bautouse, usestring );
            break;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x66656f35, Offset: 0x29926
// Size: 0x135
function function_fd1996af0db6a8ca( evidence_index )
{
    level.hornet_mq.gathered_evidence = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    level.hornet_mq.gathered_evidence = utility::set_bit_flag( level.hornet_mq.gathered_evidence, evidence_index );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_5674ab884e5e790a", level.hornet_mq.gathered_evidence );
    
    foreach ( var_d7eabb0d1c802dc9 in [ 21, 26, 23, 22, 24, 25 ] )
    {
        if ( evidence_index == var_d7eabb0d1c802dc9 )
        {
            level function_1e65c5f86f678780( evidence_index );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x1d780561, Offset: 0x29a63
// Size: 0x8e
function setup_solve_logic()
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( level.directed_mode )
    {
        level utility::flag_wait( "mq_directed_revealed_screen_mot" );
        level function_ecc91637c2a6fbb1();
    }
    
    if ( level utility::flag( "hornet_mq_solve_enabled" ) )
    {
        return;
    }
    
    level utility::flag_set( "hornet_mq_solve_enabled" );
    level thread function_72e8aa5833dac385();
    trig = getent( "mq_es_trigger", #targetname );
    trig thread function_a039811cedecf4b2();
    level setup_evidence_tables();
    level function_f259d5be65c29d3d();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x97fd7756, Offset: 0x29af9
// Size: 0x33
function function_a458e12004e428f1( loc, angles = ( 0, 0, 0 ) )
{
    
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x52595ca5, Offset: 0x29b64
// Size: 0x164
function setup_evidence_shelf()
{
    if ( !isdefined( level.hornet_mq.evidence_shelf ) )
    {
        level.hornet_mq.evidence_shelf = {};
    }
    
    a_evidence_locs = utility::getstructarray( "es_eloc", "targetname" );
    
    foreach ( struct in a_evidence_locs )
    {
        struct.var_528309df984ec9f8 = 0;
        struct.var_ed42e41ee1346fd2 = 0;
        struct.scriptable = spawnscriptable( %"zm_sat_hornet_mq_evidence", struct.origin, struct.angles );
        struct.scriptable.root = struct;
    }
    
    level.hornet_mq.evidence_shelf.evidence_structs = a_evidence_locs;
    trig = getent( "mq_es_trigger", #targetname );
    trig thread function_956dafb7506d8f27();
    trig interaction::set_interact_hint_callback( &function_77aadbcd5c30f376 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x45505b2f, Offset: 0x29cd0
// Size: 0x2d6
function deliver_evidence( var_3e70f5e0d4169591 = 0, player = undefined, var_af010a6b2dc148ca = 0 )
{
    level.hornet_mq.delivered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_a90576392145440" ) ?? 0;
    level.hornet_mq.gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    var_9dbfc82a7874640b = [];
    
    for ( i = 0; i < 15 ; i++ )
    {
        gathered_state = utility::get_bit_flag( level.hornet_mq.gathered_evidence, i );
        delivered_state = utility::get_bit_flag( level.hornet_mq.delivered_evidence, i );
        
        if ( gathered_state != delivered_state || var_af010a6b2dc148ca && delivered_state )
        {
            var_9dbfc82a7874640b[ var_9dbfc82a7874640b.size ] = i;
        }
    }
    
    if ( var_9dbfc82a7874640b.size <= 0 )
    {
        return;
    }
    
    if ( isdefined( player ) && !var_3e70f5e0d4169591 && var_9dbfc82a7874640b.size > 0 && var_9dbfc82a7874640b.size < 3 )
    {
        player thread function_2a6deff157d1165a( #"hash_110643c43e15ed85", undefined, 1 );
    }
    
    foreach ( item in var_9dbfc82a7874640b )
    {
        ref = function_11889a50be16a152( item );
        
        if ( isdefined( ref ) )
        {
            level thread function_2449528487ed5cc8( ref, player );
        }
        
        level function_1e65c5f86f678780( item );
        
        if ( !var_3e70f5e0d4169591 )
        {
            wait 0.35;
        }
    }
    
    level function_51faa687c36f4b91( [ 0, 1, 2 ], "mq_step_8_complete", #"ev_sus", player );
    level function_51faa687c36f4b91( [ 3, 4, 5 ], "mq_step_13_complete", #"ev_acc", player );
    level function_51faa687c36f4b91( [ 6, 7, 8 ], "mq_step_20_complete", #"ev_poi", player );
    level function_51faa687c36f4b91( [ 9, 10, 11 ], "mq_step_27_complete", #"ev_loc", player );
    level function_51faa687c36f4b91( [ 12, 13, 14 ], "mq_all_ev_delivered", #"ev_mot", player );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe235f119, Offset: 0x29fae
// Size: 0x17e
function function_11889a50be16a152( item )
{
    switch ( item )
    {
        case 0:
            ref = "comb";
            break;
        case 1:
            ref = "case";
            break;
        case 2:
            ref = "pipe";
            break;
        case 3:
            ref = "shears";
            break;
        case 4:
            ref = "hat";
            break;
        case 5:
            ref = "abacus";
            break;
        case 6:
            ref = "flower";
            break;
        case 7:
            ref = "fish";
            break;
        case 8:
            ref = "plum";
            break;
        case 9:
            ref = "whisk";
            break;
        case 10:
            ref = "writing";
            break;
        case 11:
            ref = "horse";
            break;
        case 12:
            ref = "brothers";
            break;
        case 13:
            ref = "seal";
            break;
        case 14:
            ref = "mitsuhime";
            break;
        default:
            ref = undefined;
            break;
    }
    
    return ref;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xcde67e45, Offset: 0x2a135
// Size: 0x158
function function_4d1964b43d62cd56( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    switch ( ref )
    {
        case #"hash_ea093f29bbd46654":
            idx = 0;
            break;
        case #"hash_a170042996314a11":
            idx = 1;
            break;
        case #"hash_8c1d648493292b59":
            idx = 2;
            break;
        case #"hash_15519c6352de1cbf":
            idx = 3;
            break;
        case #"hash_4e89e96c332989a2":
            idx = 4;
            break;
        case #"hash_705898d5f7d98ffe":
            idx = 5;
            break;
        case #"hash_37143eaacab73366":
            idx = 6;
            break;
        case #"hash_ceb3b9150f04bcc3":
            idx = 7;
            break;
        case #"hash_776c2d8488b9c1cb":
            idx = 8;
            break;
        case #"hash_13894b2d73f9873f":
            idx = 9;
            break;
        case #"hash_5b73f98f5259d72f":
            idx = 10;
            break;
        case #"hash_4580372509891086":
            idx = 11;
            break;
        case #"hash_2e50beff48feda22":
            idx = 12;
            break;
        case #"hash_b4f27b89f5a78a00":
            idx = 13;
            break;
        case #"hash_4f9b103e1de2f3d0":
            idx = 14;
            break;
        default:
            idx = undefined;
            break;
    }
    
    return idx;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xbe6f2e3a, Offset: 0x2a296
// Size: 0xac, Type: bool
function function_13a33d950c2a41c0( category_indices )
{
    all_delivered = 1;
    
    foreach ( index in category_indices )
    {
        if ( !utility::get_bit_flag( level.hornet_mq.delivered_evidence, index ) )
        {
            all_delivered = 0;
        }
    }
    
    if ( all_delivered )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0x90694e40, Offset: 0x2a34b
// Size: 0x119
function function_51faa687c36f4b91( category_indices, flag, inv_quest_ref, delivering_player = undefined )
{
    if ( level utility::flag( flag ) )
    {
        return 1;
    }
    
    if ( !function_13a33d950c2a41c0( category_indices ) )
    {
        return;
    }
    
    level utility::flag_set( flag );
    
    switch ( flag )
    {
        case #"hash_9cc08a95afd55db1":
            alias = #"hash_8ffc057b32e90cf4";
            break;
        case #"hash_59d9a2a37db8f7b7":
            alias = #"hash_a662c759510e13a";
            break;
        case #"hash_ff5bd2dbda9bc89":
            alias = #"hash_122177f4dd9a6c05";
            break;
        case #"hash_49473125db528626":
            alias = #"hash_76bba1f58a5b1239";
            break;
        case #"hash_c597b6958d2209c":
            alias = #"hash_672b30990bc0daf";
            break;
        default:
            return;
    }
    
    if ( isalive( delivering_player ) )
    {
        delivering_player thread function_2a6deff157d1165a( alias, undefined, 0.25 );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x54b4bd02, Offset: 0x2a46c
// Size: 0xd4
function function_1805638627b4a07e( category_indices, flag )
{
    if ( level utility::flag( flag ) )
    {
        return 1;
    }
    
    all_gathered = 1;
    
    foreach ( index in category_indices )
    {
        if ( !utility::get_bit_flag( level.hornet_mq.gathered_evidence, index ) )
        {
            all_gathered = 0;
        }
    }
    
    if ( all_gathered )
    {
        level utility::flag_set( flag );
    }
    
    level function_ecc91637c2a6fbb1();
    return all_gathered;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x1191c6e6, Offset: 0x2a549
// Size: 0x98
function function_1e65c5f86f678780( evidence_index )
{
    level.hornet_mq.delivered_evidence = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_a90576392145440" ) ?? 0;
    level.hornet_mq.delivered_evidence = utility::set_bit_flag( level.hornet_mq.delivered_evidence, evidence_index );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_a90576392145440", level.hornet_mq.delivered_evidence );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x99820773, Offset: 0x2a5e9
// Size: 0x295
function function_2449528487ed5cc8( var_8133ea3bbadb0bc9, player = undefined )
{
    var_ed92d3edd3eded9 = undefined;
    
    foreach ( struct in level.hornet_mq.evidence_shelf.evidence_structs )
    {
        if ( struct.script_noteworthy == var_8133ea3bbadb0bc9 )
        {
            var_ed92d3edd3eded9 = struct;
            break;
        }
    }
    
    if ( !isdefined( var_ed92d3edd3eded9 ) )
    {
        assertmsg( "<dev string:x139>" + var_8133ea3bbadb0bc9 );
        return;
    }
    
    if ( isdefined( player ) )
    {
        if ( level.directed_mode )
        {
            var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
            
            foreach ( st_category in var_267ae6135028442e )
            {
                if ( player.held_evidence == function_993f78bfb5b651e4( st_category ) )
                {
                    level utility::flag_clear( "solve_mq_player_has_ev_" + st_category );
                }
            }
            
            level function_ecc91637c2a6fbb1();
        }
        
        player.held_evidence = undefined;
        player function_df87131d7571b22f( 0 );
        
        if ( player callback::exists( #"player_disconnect", &function_37080a45f6fcf7b6 ) && player callback::exists( #"player_death", &function_37080a45f6fcf7b6 ) )
        {
            player callback::remove( #"player_disconnect", &function_37080a45f6fcf7b6 );
            player callback::remove( #"player_death", &function_37080a45f6fcf7b6 );
        }
        
        level function_5ca6c6fdd78f6275( player, var_ed92d3edd3eded9 );
    }
    
    var_ed92d3edd3eded9.scriptable utility::function_7c10ea82c1e305b8( "visual", var_ed92d3edd3eded9.script_noteworthy );
    var_ed92d3edd3eded9.scriptable utility::function_7c10ea82c1e305b8( "collision", "on_" + var_ed92d3edd3eded9.script_noteworthy );
    var_ed92d3edd3eded9.var_528309df984ec9f8 = 1;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x370d8025, Offset: 0x2a886
// Size: 0x1e9
function function_660c9940ee85c4f( evidence_struct )
{
    self.held_evidence = evidence_struct.script_noteworthy;
    
    if ( isplayer( self ) )
    {
        if ( !callback::exists( #"player_disconnect", &function_37080a45f6fcf7b6 ) && !callback::exists( #"player_death", &function_37080a45f6fcf7b6 ) )
        {
            callback::add( #"player_disconnect", &function_37080a45f6fcf7b6 );
            callback::add( #"player_death", &function_37080a45f6fcf7b6 );
        }
    }
    
    evidence_struct.scriptable utility::function_7c10ea82c1e305b8( "audio", evidence_struct.script_noteworthy );
    evidence_struct.scriptable utility::function_7c10ea82c1e305b8( "visual", "empty" );
    evidence_struct.scriptable utility::function_7c10ea82c1e305b8( "collision", "off" );
    evidence_struct.var_528309df984ec9f8 = 0;
    
    if ( isplayer( self ) )
    {
        function_df87131d7571b22f( 1 );
    }
    
    self.var_f11f0245e58e572a = undefined;
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.directed_mode )
    {
        var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
        
        foreach ( st_category in var_267ae6135028442e )
        {
            if ( self.held_evidence == function_993f78bfb5b651e4( st_category ) )
            {
                level utility::flag_set( "solve_mq_player_has_ev_" + st_category );
            }
        }
        
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd92ca3c6, Offset: 0x2aa77
// Size: 0x8a
function function_956dafb7506d8f27()
{
    self notify( #"hash_cb5fba2fa804ac51" );
    self endon( #"hash_cb5fba2fa804ac51" );
    level endon( #"game_ended" );
    level endon( #"mq_step_33_complete" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !level utility::flag( "mq_all_ev_delivered" ) && level utility::flag( "power_on" ) )
        {
            level thread deliver_evidence( 0, ent );
            continue;
        }
        
        ent function_a18abd24dc77a957();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x8eb3aef6, Offset: 0x2ab09
// Size: 0x98
function function_a18abd24dc77a957()
{
    if ( level utility::flag( "mq_step_33_complete" ) )
    {
        return;
    }
    
    if ( level utility::flag( "mq_solution_items_locked" ) )
    {
        return;
    }
    
    result = function_afca6d72adde4b68();
    
    if ( is_player_looking_at_evidence( result ) )
    {
        if ( isdefined( self.held_evidence ) )
        {
            level thread function_2449528487ed5cc8( self.held_evidence, self );
        }
        
        function_660c9940ee85c4f( result[ "scriptable" ].root );
        return;
    }
    
    if ( isdefined( self.held_evidence ) )
    {
        level thread function_2449528487ed5cc8( self.held_evidence, self );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x7c36fe7, Offset: 0x2aba9
// Size: 0x330
function function_a039811cedecf4b2()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    level endon( #"mq_step_33_complete" );
    level endon( #"mq_complete" );
    var_2ac84a43a796d35c = 0;
    
    while ( true )
    {
        if ( level utility::flag( "mq_solution_items_locked" ) )
        {
            if ( !var_2ac84a43a796d35c )
            {
                var_2ac84a43a796d35c = 1;
                
                foreach ( evidence in level.hornet_mq.evidence_shelf.evidence_structs )
                {
                    if ( !evidence.var_528309df984ec9f8 )
                    {
                        continue;
                    }
                    
                    evidence.scriptable utility::function_32b24db3127bff40( "visual", evidence.script_noteworthy );
                }
                
                waitframe();
                continue;
            }
            else
            {
                var_2ac84a43a796d35c = 1;
                wait 0.5;
                continue;
            }
        }
        
        var_2ac84a43a796d35c = 0;
        
        foreach ( evidence in level.hornet_mq.evidence_shelf.evidence_structs )
        {
            if ( evidence.var_ed42e41ee1346fd2 )
            {
                evidence.var_ed42e41ee1346fd2 = 0;
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                player function_8e0bebe46ab04ae9();
            }
        }
        
        foreach ( evidence in level.hornet_mq.evidence_shelf.evidence_structs )
        {
            if ( !evidence.var_528309df984ec9f8 )
            {
                continue;
            }
            
            if ( evidence.var_ed42e41ee1346fd2 )
            {
                evidence.scriptable utility::function_32b24db3127bff40( "visual", evidence.script_noteworthy + "_outline" );
                continue;
            }
            
            evidence.scriptable utility::function_32b24db3127bff40( "visual", evidence.script_noteworthy );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x13043f53, Offset: 0x2aee1
// Size: 0x471
function function_77aadbcd5c30f376( usable, player )
{
    if ( !level utility::flag( "mq_all_ev_delivered" ) && level utility::flag( "power_on" ) )
    {
        if ( level.directed_mode )
        {
            if ( level.hornet_mq.gathered_evidence != level.hornet_mq.delivered_evidence )
            {
                return { #var_26bbd300351fde34:0, #string:&"hash_72bd21db218fcb44", #type:"HINT_BUTTON" };
            }
            else
            {
                return { #string:&"", #type:"HINT_NOBUTTON" };
            }
        }
        else
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    if ( !isdefined( player.var_f11f0245e58e572a ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    switch ( player.var_f11f0245e58e572a )
    {
        case #"hash_8c1d648493292b59":
            return { #var_26bbd300351fde34:0, #string:&"hash_6cdf73a4f84762b6", #type:"HINT_BUTTON" };
        case #"hash_a170042996314a11":
            return { #var_26bbd300351fde34:0, #string:&"hash_447bb5abde9930ce", #type:"HINT_BUTTON" };
        case #"hash_ea093f29bbd46654":
            return { #var_26bbd300351fde34:0, #string:&"hash_5a0906ccc0204c99", #type:"HINT_BUTTON" };
        case #"hash_15519c6352de1cbf":
            return { #var_26bbd300351fde34:0, #string:&"hash_4bd10b5f9bd40e9c", #type:"HINT_BUTTON" };
        case #"hash_705898d5f7d98ffe":
            return { #var_26bbd300351fde34:0, #string:&"hash_720353a67883df1b", #type:"HINT_BUTTON" };
        case #"hash_4e89e96c332989a2":
            return { #var_26bbd300351fde34:0, #string:&"hash_4c9f367132be91b7", #type:"HINT_BUTTON" };
        case #"hash_ceb3b9150f04bcc3":
            return { #var_26bbd300351fde34:0, #string:&"hash_498460bf746b3488", #type:"HINT_BUTTON" };
        case #"hash_776c2d8488b9c1cb":
            return { #var_26bbd300351fde34:0, #string:&"hash_28d11b439c481fd0", #type:"HINT_BUTTON" };
        case #"hash_37143eaacab73366":
            return { #var_26bbd300351fde34:0, #string:&"hash_6d5adb8261a958a3", #type:"HINT_BUTTON" };
        case #"hash_13894b2d73f9873f":
            return { #var_26bbd300351fde34:0, #string:&"hash_3ca7a46c1c4b7b1c", #type:"HINT_BUTTON" };
        case #"hash_4580372509891086":
            return { #var_26bbd300351fde34:0, #string:&"hash_41391f419de4fde3", #type:"HINT_BUTTON" };
        case #"hash_5b73f98f5259d72f":
            return { #var_26bbd300351fde34:0, #string:&"hash_5198c57661a2158c", #type:"HINT_BUTTON" };
        case #"hash_2e50beff48feda22":
            return { #var_26bbd300351fde34:0, #string:&"hash_1112fd92d838bad7", #type:"HINT_BUTTON" };
        case #"hash_4f9b103e1de2f3d0":
            return { #var_26bbd300351fde34:0, #string:&"hash_7a676d2258a6aadd", #type:"HINT_BUTTON" };
        case #"hash_b4f27b89f5a78a00":
            return { #var_26bbd300351fde34:0, #string:&"hash_1f02000ff6579df1", #type:"HINT_BUTTON" };
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xc181df41, Offset: 0x2b35a
// Size: 0x7f
function function_8e0bebe46ab04ae9()
{
    result = function_afca6d72adde4b68();
    
    if ( is_player_looking_at_evidence( result ) )
    {
        result[ "scriptable" ].root.var_ed42e41ee1346fd2 = 1;
        self.var_f11f0245e58e572a = result[ "scriptable" ].root.script_noteworthy;
        function_9949dfbd9b5f96be( 0 );
        return;
    }
    
    self.var_f11f0245e58e572a = undefined;
    function_9949dfbd9b5f96be( 1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xba7f6886, Offset: 0x2b3e1
// Size: 0x5a
function function_afca6d72adde4b68()
{
    if ( self getcamerathirdperson() )
    {
        starttrace = self getcamerathirdpersonorigin();
    }
    else
    {
        starttrace = self geteye();
    }
    
    endtrace = starttrace + anglestoforward( self getplayerangles() ) * 1000;
    result = trace::ray_trace( starttrace, endtrace, undefined, undefined, undefined, undefined, 1 );
    return result;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc5c055cc, Offset: 0x2b444
// Size: 0x4f, Type: bool
function is_player_looking_at_evidence( result )
{
    if ( isdefined( result[ "scriptable" ] ) && isdefined( result[ "scriptable" ].root ) && isdefined( result[ "scriptable" ].root.var_ed42e41ee1346fd2 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7836dc74, Offset: 0x2b49c
// Size: 0x1fe
function function_df87131d7571b22f( b_show )
{
    if ( b_show )
    {
        if ( !isdefined( self.held_evidence ) )
        {
            return;
        }
        
        switch ( self.held_evidence )
        {
            case #"hash_ea093f29bbd46654":
                self setclientomnvar( "ui_hud_carried_item_index", 7 );
                break;
            case #"hash_a170042996314a11":
                self setclientomnvar( "ui_hud_carried_item_index", 16 );
                break;
            case #"hash_8c1d648493292b59":
                self setclientomnvar( "ui_hud_carried_item_index", 17 );
                break;
            case #"hash_15519c6352de1cbf":
                self setclientomnvar( "ui_hud_carried_item_index", 18 );
                break;
            case #"hash_4e89e96c332989a2":
                self setclientomnvar( "ui_hud_carried_item_index", 19 );
                break;
            case #"hash_705898d5f7d98ffe":
                self setclientomnvar( "ui_hud_carried_item_index", 20 );
                break;
            case #"hash_37143eaacab73366":
                self setclientomnvar( "ui_hud_carried_item_index", 21 );
                break;
            case #"hash_ceb3b9150f04bcc3":
                self setclientomnvar( "ui_hud_carried_item_index", 22 );
                break;
            case #"hash_776c2d8488b9c1cb":
                self setclientomnvar( "ui_hud_carried_item_index", 23 );
                break;
            case #"hash_13894b2d73f9873f":
                self setclientomnvar( "ui_hud_carried_item_index", 24 );
                break;
            case #"hash_5b73f98f5259d72f":
                self setclientomnvar( "ui_hud_carried_item_index", 25 );
                break;
            case #"hash_4580372509891086":
                self setclientomnvar( "ui_hud_carried_item_index", 26 );
                break;
            case #"hash_2e50beff48feda22":
                self setclientomnvar( "ui_hud_carried_item_index", 27 );
                break;
            case #"hash_b4f27b89f5a78a00":
                self setclientomnvar( "ui_hud_carried_item_index", 28 );
                break;
            case #"hash_4f9b103e1de2f3d0":
                self setclientomnvar( "ui_hud_carried_item_index", 29 );
                break;
            default:
                return;
        }
        
        self setclientomnvar( "ui_hud_carried_item_count", 1 );
        return;
    }
    
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x49847b19, Offset: 0x2b6a2
// Size: 0xdd
function function_72e8aa5833dac385()
{
    level endon( #"mq_step_33_complete" );
    zone_trig = getent( "evid_room_trig", #targetname );
    
    if ( !zone_trig )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player.held_evidence )
            {
                waitframe();
                continue;
            }
            
            if ( !player istouching( zone_trig ) )
            {
                level thread function_2449528487ed5cc8( player.held_evidence, player );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x501f1a76, Offset: 0x2b787
// Size: 0x2c
function function_37080a45f6fcf7b6( params )
{
    if ( !self.held_evidence )
    {
        return;
    }
    
    level thread function_2449528487ed5cc8( self.held_evidence, self );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x39c1c72d, Offset: 0x2b7bb
// Size: 0x1df
function function_5ca6c6fdd78f6275( player, s_destination )
{
    travel_time_sec = 0.75;
    starting_point = player getcentroid();
    end_point = s_destination.origin;
    wisp = spawnscriptable( %"zm_sat_hornet_mq_trail", starting_point, ( 0, 0, 0 ) );
    wisp utility::function_7c10ea82c1e305b8( "visual", "gold" );
    mover = utility::spawn_model( "tag_origin", starting_point, ( 0, 0, 0 ) );
    wisp utility::scriptable_setparententity( mover );
    
    if ( !isalive( player ) )
    {
        var_9769d4ec8ad9b372 = 1;
        midpoint = ( starting_point + end_point ) / 2;
        control_point = midpoint + ( 0, 0, 10 );
        mover utility::function_8001268940441423( starting_point, end_point, control_point, travel_time_sec );
    }
    else
    {
        path = [ starting_point ];
        point_fwd = player.origin + anglestoforward( player getplayerangles() ) * 8;
        eye_pos = player geteye();
        second_point = ( point_fwd[ 0 ], point_fwd[ 1 ], eye_pos[ 2 ] );
        path[ path.size ] = second_point;
        third_point = ( end_point + second_point ) / 2;
        path[ path.size ] = third_point;
        path[ path.size ] = end_point;
        mover utility::function_2159dd4196ff4b81( path, travel_time_sec, 1, 1, 0, 0.5, 1 );
    }
    
    wisp utility::function_7c10ea82c1e305b8( "impact", "gold_impact" );
    wisp utility::function_7c10ea82c1e305b8( "visual", "invisible" );
    wisp utility::scriptable_clearparententity();
    mover delete();
    wisp utility::delaycall( 1, &freescriptable );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xf7bfa958, Offset: 0x2b9a2
// Size: 0x31
function function_b8dfbdb19fb7f856()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level deliver_evidence( 1, undefined, 1 );
    level utility::flag_set( "mq_save_restored_evidence_delivered" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x654a0c88, Offset: 0x2b9db
// Size: 0x457
function setup_evidence_tables()
{
    if ( !isdefined( level.hornet_mq.evidence_tables ) )
    {
        level.hornet_mq.evidence_tables = {};
    }
    
    var_b88cff45f0beffdb = utility::getstructarray( "mq_ev_tbl", "targetname" );
    
    foreach ( struct in var_b88cff45f0beffdb )
    {
        struct.placed_evidence = undefined;
        struct.interact = interaction::register_interact( struct.origin, 80, &function_59d4ccb7a51fec06 );
        struct.interact setusefov( 45 );
        struct.interact interaction::set_interact_hint_callback( &function_5b864af8baab1d26 );
        struct.interact.root = struct;
        struct.scriptable = spawnscriptable( %"zm_sat_hornet_mq_evidence", struct.origin, struct.angles );
        struct.scriptable.base_origin = struct.origin;
        struct.scriptable.base_angles = struct.angles;
        struct.scriptable.root = struct;
    }
    
    level.hornet_mq.evidence_tables.tables = var_b88cff45f0beffdb;
    
    if ( !isdefined( level.hornet_mq.var_c4a1c8e3495b1ed1 ) )
    {
        level.hornet_mq.var_c4a1c8e3495b1ed1 = [];
    }
    
    var_f034ad6873c6ea21 = getentitylessscriptablearray( "mq_in_bn_loc", #targetname );
    
    foreach ( sbl_burner in var_f034ad6873c6ea21 )
    {
        s_incense = {};
        s_incense.sbl = sbl_burner;
        s_incense.sbl interaction::set_interact_hint_callback( &burner_hint_callback );
        
        if ( sbl_burner.script_noteworthy == "sol" )
        {
            s_incense.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_solve" );
        }
        else if ( sbl_burner.script_noteworthy == "dis" )
        {
            s_incense.sbl utility::function_7c10ea82c1e305b8( "usable", "enabled_distract" );
        }
        
        s_incense.sbl.root = s_incense;
        s_incense.var_91fad0a70b0a8fd3 = [];
        
        for ( i = 0; i < 2 ; i++ )
        {
            smoke_path_start = utility::getstruct( "pre_smk_path_" + sbl_burner.script_noteworthy + "_" + string( i + 1 ), "targetname" );
            s_incense.var_91fad0a70b0a8fd3[ i ] = [ smoke_path_start.origin ];
            node = smoke_path_start;
            
            while ( node.target )
            {
                var_c27efcf4d873bd51 = utility::getstruct( node.target, "targetname" );
                s_incense.var_91fad0a70b0a8fd3[ i ][ s_incense.var_91fad0a70b0a8fd3[ i ].size ] = var_c27efcf4d873bd51.origin;
                node = var_c27efcf4d873bd51;
                
                if ( node.targetname == "smk_coalesce_loc" )
                {
                    break;
                }
            }
        }
        
        level.hornet_mq.var_c4a1c8e3495b1ed1[ level.hornet_mq.var_c4a1c8e3495b1ed1.size ] = s_incense;
    }
    
    level utility::flag_set( "mq_evidence_table_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x92f6441d, Offset: 0x2be3a
// Size: 0x116
function function_cda1dad5854f8cf0( ref )
{
    if ( isdefined( ref ) )
    {
        switch ( ref )
        {
            case #"hash_13894b2d73f9873f":
                angles = ( 358.204, 99.8348, 78.9455 );
                offset = ( -4, 0, 1 );
                break;
            case #"hash_37143eaacab73366":
                angles = ( 23.8993, 280.129, -89.6714 );
                offset = ( -7, 0, 0 );
                break;
            case #"hash_4f9b103e1de2f3d0":
                angles = ( 0, randomfloatrange( -50, 50 ), 0 );
                offset = ( 0, 0, 1 );
                break;
            default:
                offset = ( 0, 0, 0 );
                angles = ( 0, randomfloatrange( -50, 50 ), 0 );
                break;
        }
    }
    else
    {
        offset = ( 0, 0, 0 );
        angles = ( 0, 0, 0 );
    }
    
    return { #angles:angles, #offset:offset };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7a289e0d, Offset: 0x2bf59
// Size: 0x904
function function_59d4ccb7a51fec06( player )
{
    if ( level utility::flag( "mq_solution_items_locked" ) )
    {
        return;
    }
    
    if ( isdefined( self.root.placed_evidence ) )
    {
        if ( isdefined( player.held_evidence ) )
        {
            player_evidence = player.held_evidence;
            table_evidence = self.root.placed_evidence;
            
            if ( level.directed_mode )
            {
                var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
                
                foreach ( st_category in var_267ae6135028442e )
                {
                    if ( table_evidence == function_993f78bfb5b651e4( st_category ) )
                    {
                        level utility::flag_set( "solve_mq_player_has_ev_" + st_category );
                    }
                    
                    if ( player_evidence == function_993f78bfb5b651e4( st_category ) )
                    {
                        level utility::flag_clear( "solve_mq_player_has_ev_" + st_category );
                    }
                }
            }
            
            self.root.scriptable utility::function_7c10ea82c1e305b8( "visual", player_evidence );
            self.root.placed_evidence = player_evidence;
            self.root function_1f3ec96cec3f01f6( self.root.placed_evidence );
            self.root.scriptable.origin = self.root.scriptable.base_origin;
            self.root.scriptable.angles = self.root.scriptable.base_angles;
            var_1237a2e6411cfd94 = function_cda1dad5854f8cf0( player_evidence );
            
            if ( var_1237a2e6411cfd94 )
            {
                self.root.scriptable.origin += var_1237a2e6411cfd94.offset;
                self.root.scriptable.angles = var_1237a2e6411cfd94.angles;
            }
            
            player.held_evidence = table_evidence;
            player function_df87131d7571b22f( 1 );
            self.root.scriptable utility::function_7c10ea82c1e305b8( "audio", self.root.placed_evidence );
        }
        else
        {
            if ( level.directed_mode )
            {
                var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
                
                foreach ( st_category in var_267ae6135028442e )
                {
                    if ( self.root.placed_evidence == function_993f78bfb5b651e4( st_category ) )
                    {
                        level utility::flag_set( "solve_mq_player_has_ev_" + st_category );
                    }
                }
            }
            
            player.held_evidence = self.root.placed_evidence;
            player function_df87131d7571b22f( 1 );
            self.root.scriptable utility::function_7c10ea82c1e305b8( "visual", "empty" );
            self.root.placed_evidence = undefined;
            self.root function_1f3ec96cec3f01f6( undefined );
            
            if ( !player callback::exists( #"player_disconnect", &function_37080a45f6fcf7b6 ) && !player callback::exists( #"player_death", &function_37080a45f6fcf7b6 ) )
            {
                player callback::add( #"player_disconnect", &function_37080a45f6fcf7b6 );
                player callback::add( #"player_death", &function_37080a45f6fcf7b6 );
            }
        }
        
        self.root.scriptable utility::function_7c10ea82c1e305b8( "audio", player.held_evidence );
    }
    else if ( isdefined( player.held_evidence ) )
    {
        if ( level.directed_mode )
        {
            var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
            
            foreach ( st_category in var_267ae6135028442e )
            {
                if ( player.held_evidence == function_993f78bfb5b651e4( st_category ) )
                {
                    level utility::flag_clear( "solve_mq_player_has_ev_" + st_category );
                }
            }
        }
        
        self.root.placed_evidence = player.held_evidence;
        self.root.scriptable utility::function_7c10ea82c1e305b8( "visual", player.held_evidence );
        self.root function_1f3ec96cec3f01f6( self.root.placed_evidence );
        self.root.scriptable.origin = self.root.scriptable.base_origin;
        self.root.scriptable.angles = self.root.scriptable.base_angles;
        var_1237a2e6411cfd94 = function_cda1dad5854f8cf0( player.held_evidence );
        
        if ( var_1237a2e6411cfd94 )
        {
            self.root.scriptable.origin += var_1237a2e6411cfd94.offset;
            self.root.scriptable.angles = var_1237a2e6411cfd94.angles;
        }
        
        player.held_evidence = undefined;
        player function_df87131d7571b22f( 0 );
        
        if ( player callback::exists( #"player_disconnect", &function_37080a45f6fcf7b6 ) && player callback::exists( #"player_death", &function_37080a45f6fcf7b6 ) )
        {
            player callback::remove( #"player_disconnect", &function_37080a45f6fcf7b6 );
            player callback::remove( #"player_death", &function_37080a45f6fcf7b6 );
        }
        
        switch ( self.root.script_noteworthy )
        {
            case #"hash_90259d6c553fba32":
                alias = #"hash_74f64c06062a1ff";
                break;
            case #"hash_c775b6c10b66b7a":
                alias = #"hash_591d3b396c1fab34";
                break;
            case #"hash_890e226c519dc6ab":
                alias = #"hash_d04abdc12995e8";
                break;
            case #"hash_2f27486c2242f37d":
                alias = #"hash_cbfe45611f8dd649";
                break;
            case #"hash_2894da6c1f0a5e33":
                alias = #"hash_5067d5e26afa088e";
                break;
            default:
                break;
        }
        
        if ( isdefined( alias ) )
        {
            player thread function_2a6deff157d1165a( alias, undefined, 0.33 );
        }
        
        self.root.scriptable utility::function_7c10ea82c1e305b8( "audio", self.root.placed_evidence );
    }
    
    if ( level.directed_mode )
    {
        if ( self.root.placed_evidence == function_993f78bfb5b651e4( self.root.script_noteworthy ) )
        {
            level utility::flag_set( "solve_mq_correct_ev_placed_" + self.root.script_noteworthy );
        }
        else
        {
            level utility::flag_clear( "solve_mq_correct_ev_placed_" + self.root.script_noteworthy );
        }
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x65bd4767, Offset: 0x2c865
// Size: 0x36
function function_5b864af8baab1d26( usable, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x699c6288, Offset: 0x2c8a4
// Size: 0xea
function function_1f3ec96cec3f01f6( ev_ref )
{
    switch ( self.script_noteworthy )
    {
        case #"hash_90259d6c553fba32":
            skvp = #"hash_34a9cf60134c560";
            break;
        case #"hash_c775b6c10b66b7a":
            skvp = #"hash_88905ef5bb47c458";
            break;
        case #"hash_890e226c519dc6ab":
            skvp = #"hash_1c8919f60f4bacbd";
            break;
        case #"hash_2f27486c2242f37d":
            skvp = #"hash_2af48bf586bc1153";
            break;
        case #"hash_2894da6c1f0a5e33":
            skvp = #"hash_1fd289f57fba510d";
            break;
    }
    
    evidence_value = function_4d1964b43d62cd56( ev_ref );
    
    if ( evidence_value )
    {
        zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", skvp, evidence_value );
        return;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", skvp, -1 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x7cb6841c, Offset: 0x2c996
// Size: 0x347
function function_2609ec2fda6e6a5e()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "mq_save_restored_evidence_delivered" );
    level utility::flag_wait( "mq_evidence_table_setup_complete" );
    level zm_save::function_1f44a48caae2acbf();
    waitframe();
    var_267ae6135028442e = [ "sus", "acc", "poi", "loc", "mot" ];
    var_c4b7714fab999bcd = [ #"hash_34a9cf60134c560", #"hash_88905ef5bb47c458", #"hash_1c8919f60f4bacbd", #"hash_2af48bf586bc1153", #"hash_1fd289f57fba510d" ];
    
    for ( i = 0; i < var_c4b7714fab999bcd.size ; i++ )
    {
        var_6d2c79eed5611d2b = var_c4b7714fab999bcd[ i ];
        var_b1617529ffed4cbb = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", var_6d2c79eed5611d2b );
        
        if ( !isdefined( var_b1617529ffed4cbb ) || var_b1617529ffed4cbb < 0 )
        {
            continue;
        }
        
        shelf_state = function_11889a50be16a152( var_b1617529ffed4cbb );
        
        foreach ( var_cb586e8a3019c9fa in level.hornet_mq.evidence_shelf.evidence_structs )
        {
            if ( var_cb586e8a3019c9fa.script_noteworthy == shelf_state )
            {
                var_4b6fc40909186e23 = {};
                var_4b6fc40909186e23 function_660c9940ee85c4f( var_cb586e8a3019c9fa );
            }
        }
        
        foreach ( table_struct in level.hornet_mq.evidence_tables.tables )
        {
            if ( table_struct.script_noteworthy == var_267ae6135028442e[ i ] )
            {
                table_struct.scriptable utility::function_7c10ea82c1e305b8( "visual", shelf_state );
                table_struct.scriptable.origin = table_struct.scriptable.base_origin;
                table_struct.scriptable.angles = table_struct.scriptable.base_angles;
                var_1237a2e6411cfd94 = function_cda1dad5854f8cf0( shelf_state );
                
                if ( var_1237a2e6411cfd94 )
                {
                    table_struct.scriptable.origin += var_1237a2e6411cfd94.offset;
                    table_struct.scriptable.angles = var_1237a2e6411cfd94.angles;
                }
                
                table_struct.placed_evidence = shelf_state;
            }
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 6
// Checksum 0x6cac4329, Offset: 0x2cce5
// Size: 0x5b
function function_82be991de4ef9308( instance, part, state, player, bautouse, usestring )
{
    if ( state == "enabled_solve" )
    {
        instance thread function_2884c37acf7f6a07( player );
        return;
    }
    
    instance thread function_1db0cf8861ac618c( player );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x40fbd257, Offset: 0x2cd48
// Size: 0xad
function burner_hint_callback( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_71aed1bcae95f86", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xfb150812, Offset: 0x2cdfd
// Size: 0x3b0
function function_2884c37acf7f6a07( player )
{
    level endon( #"game_ended" );
    utility::function_7c10ea82c1e305b8( "fx", "burning" );
    utility::function_7c10ea82c1e305b8( "usable", "disabled" );
    b_earlyout = 0;
    
    foreach ( table in level.hornet_mq.evidence_tables.tables )
    {
        if ( !isdefined( table.placed_evidence ) )
        {
            b_earlyout = 1;
        }
    }
    
    if ( b_earlyout )
    {
        wait 1;
        utility::function_7c10ea82c1e305b8( "fx", "extinguished" );
        wait 3;
        utility::function_7c10ea82c1e305b8( "usable", "enabled_solve" );
        return;
    }
    
    level utility::flag_set( "mq_solution_items_locked" );
    level function_3582825f5c626855();
    
    if ( level.hornet_mq.var_2cc1ff521d5f4749 )
    {
        level.hornet_mq.var_2cc1ff521d5f4749 utility::stop_loop_sound_on_entity( #"mus_mq_evidence_room" );
        level.hornet_mq.var_2cc1ff521d5f4749 delete();
    }
    
    if ( level function_a1eae3cc9a535084() )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_3d9d9fccab5e9285" );
    }
    else
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_4e2ad9ed33f58ada" );
    }
    
    wait 5;
    
    if ( level function_a1eae3cc9a535084() )
    {
        level function_9e0ebd27e583048();
        level utility::flag_set( "mq_step_33_complete" );
        level utility::flag_set( "mq_sol_seq_ended" );
        level notify( #"mq_sol_seq_ended" );
    }
    else
    {
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 18 );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
        
        foreach ( s_burner in level.hornet_mq.var_c4a1c8e3495b1ed1 )
        {
            s_burner.sbl utility::function_7c10ea82c1e305b8( "flourish", "do_failure_flourish" );
            state = s_burner.sbl.script_noteworthy == "sol" ? "enabled_solve" : "enabled_distract";
            level thread function_bf9ee15645385fe2( s_burner.sbl, state );
        }
        
        level notify( #"mq_sol_seq_early_reset_notarget" );
        
        if ( isdefined( player ) && !level utility::flag( "hornet_mq_failed_mystery_solve_first_time" ) )
        {
            level utility::flag_set( "hornet_mq_failed_mystery_solve_first_time" );
            player thread function_2a6deff157d1165a( undefined, #"bc_flavor_player_negative", 1 );
        }
        
        level function_5089f2dc0a8c2c93();
        level thread function_c5b10d13f5f52053();
        level utility::flag_set( "mq_sol_seq_ended" );
        level utility::flag_clear( "mq_solve_process_started" );
        level notify( #"mq_sol_seq_ended" );
        level utility::flag_set( "hornet_mq_wrng_sol_entered" );
    }
    
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xcf2a449b, Offset: 0x2d1b5
// Size: 0x17b
function function_1db0cf8861ac618c( player )
{
    level endon( #"game_ended" );
    level endon( #"mq_step_33_complete" );
    utility::function_7c10ea82c1e305b8( "usable", "disabled" );
    var_dc8ff5ce9ed5e4ce = "mq_sol_seq";
    
    if ( level utility::flag( var_dc8ff5ce9ed5e4ce + "_ended" ) )
    {
        level utility::flag_clear( var_dc8ff5ce9ed5e4ce + "_ended" );
    }
    
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( var_dc8ff5ce9ed5e4ce + "_early_reset_notarget" ) )
        {
            player utility::ent_flag_clear( var_dc8ff5ce9ed5e4ce + "_early_reset_notarget" );
        }
    }
    
    utility::function_7c10ea82c1e305b8( "fx", "burning" );
    trig = getent( "evid_room_trig", #targetname );
    level thread function_e40ef213c02b6164( var_dc8ff5ce9ed5e4ce, trig );
    level thread function_770156bbf03b6e7a();
    thread function_cbfb52bc5f8d58f8( 120, 1, 1 );
    level thread function_bf9ee15645385fe2( self, "enabled_distract" );
    
    if ( level.directed_mode )
    {
        level utility::flag_set( "solve_mq_lit_burner_1" );
        level utility::flag_set( "mq_solve_process_started" );
        level function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4beb7fc4, Offset: 0x2d338
// Size: 0x63
function function_770156bbf03b6e7a()
{
    spawn_loc = utility::getstruct( "smk_coalesce_loc", "targetname" );
    level.hornet_mq.var_2cc1ff521d5f4749 = spawn( "script_origin", spawn_loc.origin );
    level.hornet_mq.var_2cc1ff521d5f4749 playloopsound( "mus_mq_evidence_room" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0x1688c6f, Offset: 0x2d3a3
// Size: 0x10c
function function_cbfb52bc5f8d58f8( duration, var_629e83dd79c92e9a = 0, var_f262ffbff5a299ed = 0 )
{
    level endon( #"game_ended" );
    
    if ( var_f262ffbff5a299ed )
    {
        level thread function_f50165775dd912d();
        msg = level utility::waittill_any_timeout( duration, "mq_sol_seq_ended" );
    }
    else
    {
        wait duration;
    }
    
    if ( level.hornet_mq.var_2cc1ff521d5f4749 )
    {
        level.hornet_mq.var_2cc1ff521d5f4749 utility::stop_loop_sound_on_entity( #"mus_mq_evidence_room" );
        level.hornet_mq.var_2cc1ff521d5f4749 delete();
    }
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "fx", "extinguished" );
    }
    
    if ( var_f262ffbff5a299ed )
    {
        level utility::flag_clear( "solve_mq_lit_burner_1" );
    }
    
    if ( var_629e83dd79c92e9a )
    {
        state = var_f262ffbff5a299ed ? "enabled_distract" : "enabled_solve";
        level thread function_bf9ee15645385fe2( self, state );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x6edbe5da, Offset: 0x2d4b7
// Size: 0xf7
function function_f50165775dd912d()
{
    self notify( #"hash_447c058df070b32a" );
    self endon( #"hash_447c058df070b32a" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_5718d205affe7277 = 1;
        
        foreach ( player in level.players )
        {
            if ( !player utility::ent_flag( "mq_sol_seq_early_reset_notarget" ) )
            {
                var_5718d205affe7277 = 0;
                break;
            }
        }
        
        if ( var_5718d205affe7277 )
        {
            break;
        }
        
        if ( level utility::flag( "mq_step_33_complete" ) )
        {
            break;
        }
        
        wait 1;
    }
    
    level utility::flag_set( "mq_sol_seq_ended" );
    level notify( #"mq_sol_seq_ended" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x3f89efd9, Offset: 0x2d5b6
// Size: 0x6c
function function_bf9ee15645385fe2( sbl_burner, state )
{
    level endon( #"game_ended" );
    level endon( #"mq_step_33_complete" );
    level waittill( #"on_round_start" );
    sbl_burner utility::function_7c10ea82c1e305b8( "usable", state );
    level utility::flag_clear( "hornet_mq_wrng_sol_entered" );
    level utility::flag_clear( "mq_solution_items_locked" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x79097d9c, Offset: 0x2d62a
// Size: 0x31b
function setup_zodiac_dial()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "mq_mss_init_complete" );
    
    if ( !isdefined( level.hornet_mq.zodiac_dial ) )
    {
        level.hornet_mq.zodiac_dial = {};
    }
    
    var_d5c04942b45ee620 = [];
    level.hornet_mq.zodiac_dial.hand = getent( "zd_mdl_hand", #targetname );
    level.hornet_mq.zodiac_dial.base = getent( "zd_mdl_base", #targetname );
    var_d5c04942b45ee620[ var_d5c04942b45ee620.size ] = level.hornet_mq.zodiac_dial.hand;
    
    if ( isdefined( level.hornet_mq.zodiac_dial.base ) )
    {
        var_d5c04942b45ee620[ var_d5c04942b45ee620.size ] = level.hornet_mq.zodiac_dial.base;
    }
    
    level.hornet_mq.zodiac_dial.curr_hour = 6;
    var_5d4db766ed47ec6a = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
    var_594599dd9a9f3c97 = level.hornet_mq.zodiac_dial.curr_hour - level.hornet_mq.solution_info.dial_solution;
    
    if ( var_594599dd9a9f3c97 < 0 )
    {
        offset_to_remove = 6 + abs( var_594599dd9a9f3c97 );
        var_5d4db766ed47ec6a = arrayremove( var_5d4db766ed47ec6a, var_5d4db766ed47ec6a[ offset_to_remove - 1 ] );
    }
    else if ( var_594599dd9a9f3c97 > 0 )
    {
        offset_to_remove = 12 - var_594599dd9a9f3c97;
        var_5d4db766ed47ec6a = arrayremove( var_5d4db766ed47ec6a, var_5d4db766ed47ec6a[ offset_to_remove - 1 ] );
    }
    
    var_71d6803b87dffba9 = utility::array_random( var_5d4db766ed47ec6a );
    level.hornet_mq.zodiac_dial.hand rotateroll( var_71d6803b87dffba9 * -30, level.framedurationseconds );
    level.hornet_mq.zodiac_dial.curr_hour += var_71d6803b87dffba9;
    
    if ( level.hornet_mq.zodiac_dial.curr_hour >= 12 )
    {
        level.hornet_mq.zodiac_dial.curr_hour -= 12;
    }
    
    level utility::flag_set( "mq_zd_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x2f7db50f, Offset: 0x2d94d
// Size: 0x66
function function_f259d5be65c29d3d()
{
    level utility::flag_wait( "mq_zd_setup_complete" );
    interact_loc = utility::getstruct( "mq_zd_dial_int", "targetname" );
    level.hornet_mq.zodiac_dial.interact = interaction::register_interact( interact_loc.origin, 80, &function_b10a5eaf1fad0d, &function_892a4d6bade23e9f );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7ed7c71e, Offset: 0x2d9bb
// Size: 0x1f8
function function_b10a5eaf1fad0d( player )
{
    if ( level utility::flag( "mq_solution_items_locked" ) )
    {
        return;
    }
    
    if ( level utility::flag( "mq_zd_d_moving" ) )
    {
        return;
    }
    
    level utility::flag_set( "mq_zd_d_moving" );
    playsoundatpos( level.hornet_mq.zodiac_dial.hand.origin, "evt_mq_zodiac_dial_hand_turn" );
    level.hornet_mq.zodiac_dial.curr_hour += 1;
    
    if ( level.hornet_mq.zodiac_dial.curr_hour >= 12 )
    {
        level.hornet_mq.zodiac_dial.curr_hour = 0;
    }
    
    /#
        iprintlnbold( level.hornet_mq.zodiac_dial.curr_hour );
    #/
    
    var_fbeda6d709e1ceb5 = -30;
    level.hornet_mq.zodiac_dial.hand rotateroll( var_fbeda6d709e1ceb5, 0.1 );
    level.hornet_mq.zodiac_dial.hand waittill( #"rotatedone" );
    
    if ( level.directed_mode )
    {
        if ( level.hornet_mq.zodiac_dial.curr_hour == level.hornet_mq.solution_info.dial_solution )
        {
            level utility::flag_set( "solve_mq_zd_d_set_correct" );
        }
        else
        {
            level utility::flag_clear( "solve_mq_zd_d_set_correct" );
        }
        
        level function_ecc91637c2a6fbb1();
    }
    
    level thread function_9ee581ed47c666e0( player );
    level utility::flag_clear( "mq_zd_d_moving" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xa32a4d34, Offset: 0x2dbbb
// Size: 0x7c
function function_892a4d6bade23e9f( usable, player )
{
    if ( level.directed_mode )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_684256dee37ccad2", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc5414bf5, Offset: 0x2dc3f
// Size: 0x42
function function_9ee581ed47c666e0( player )
{
    self notify( #"hash_87c6c3dee005b52b" );
    self endon( #"hash_87c6c3dee005b52b" );
    wait 1.5;
    player thread function_2a6deff157d1165a( #"hash_529cefb85106ea36", undefined, 0.25 );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xfd00f7ac, Offset: 0x2dc89
// Size: 0x104
function function_c5b10d13f5f52053()
{
    var_a65a556e144e8c0b = utility::getstructarray( "inc_h_p_loc", "targetname" );
    var_f373c367aed887c8 = [ "zombie_orion" ];
    
    if ( level.players.size > 1 )
    {
        a_extra_spawns = [];
        
        for ( i = var_f373c367aed887c8.size; i < var_a65a556e144e8c0b.size ; i++ )
        {
            a_extra_spawns[ a_extra_spawns.size ] = utility::array_random( [ "zombie_orion", "zombie_mimic_emp" ] );
        }
        
        var_f373c367aed887c8 = arraycombine( var_f373c367aed887c8, a_extra_spawns );
    }
    
    for ( var_f5cc2dec0a5315cc = zm_utility::function_922d522db5f1ceda( var_f373c367aed887c8.size, [ "normal" ] ); !var_f5cc2dec0a5315cc ; var_f5cc2dec0a5315cc = zm_utility::function_922d522db5f1ceda( var_f373c367aed887c8.size, [ "normal" ] ) )
    {
        waitframe();
    }
    
    for ( i = 0; i < var_f373c367aed887c8.size ; i++ )
    {
        var_6f88a6bfefadea5e = { #round_override:30 };
        level thread function_89266a24d0006d65( var_f373c367aed887c8[ i ], var_a65a556e144e8c0b[ i ], var_6f88a6bfefadea5e );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x10c94e18, Offset: 0x2dd95
// Size: 0x101
function function_5089f2dc0a8c2c93()
{
    foreach ( table in level.hornet_mq.evidence_tables.tables )
    {
        level function_2449528487ed5cc8( table.placed_evidence );
        table.placed_evidence = undefined;
        table.scriptable utility::function_7c10ea82c1e305b8( "visual", "empty" );
    }
    
    level utility::flag_clear( "solve_mq_correct_ev_placed_sus" );
    level utility::flag_clear( "solve_mq_correct_ev_placed_acc" );
    level utility::flag_clear( "solve_mq_correct_ev_placed_poi" );
    level utility::flag_clear( "solve_mq_correct_ev_placed_loc" );
    level utility::flag_clear( "solve_mq_correct_ev_placed_mot" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xda001932, Offset: 0x2de9e
// Size: 0x41e
function function_9e0ebd27e583048()
{
    foreach ( s_burner in level.hornet_mq.var_c4a1c8e3495b1ed1 )
    {
        s_burner.sbl utility::function_7c10ea82c1e305b8( "flourish", "do_success_flourish" );
    }
    
    foreach ( s_burner in level.hornet_mq.var_c4a1c8e3495b1ed1 )
    {
        for ( i = 0; i < s_burner.var_91fad0a70b0a8fd3.size ; i++ )
        {
            level thread function_eb8309335458fc46( s_burner.var_91fad0a70b0a8fd3[ i ] );
        }
    }
    
    wait 3.5;
    coalesce_loc = utility::getstruct( "smk_coalesce_loc", "targetname" );
    main_ball = spawnscriptable( %"hash_3d7b334deea8aec0", coalesce_loc.origin, coalesce_loc.angles );
    main_ball.mover = utility::spawn_model( "tag_origin", coalesce_loc.origin, coalesce_loc.angles );
    main_ball utility::scriptable_setparententity( main_ball.mover );
    mover = utility::spawn_model( "tag_origin", coalesce_loc.origin, coalesce_loc.angles );
    earthquake( 0.25, 6, coalesce_loc.origin, 850 );
    playrumbleonposition( "low_highfreq", coalesce_loc.origin );
    wait 10;
    
    foreach ( s_burner in level.hornet_mq.var_c4a1c8e3495b1ed1 )
    {
        s_burner.sbl utility::function_7c10ea82c1e305b8( "fx", "extinguished" );
    }
    
    time = 25;
    node_start = coalesce_loc;
    path = [ node_start.origin ];
    
    for ( node = node_start; node.target ; node = var_c27efcf4d873bd51 )
    {
        var_c27efcf4d873bd51 = utility::getstruct( node.target, "targetname" );
        path[ path.size ] = var_c27efcf4d873bd51.origin;
    }
    
    main_ball.mover thread utility::follow_circle( 10, time, mover, 15, ( 135, 135, 0 ) );
    mover thread function_3d49269dc44b2c3e();
    mover utility::function_2159dd4196ff4b81( path, time, 1, 1, 0, 0.85, 0.5 );
    level utility::flag_set( "hornet_mq_smoke_ball_finished_moving" );
    activateworldevent( "we_katana_react_mq" );
    main_ball.mover notify( #"hash_19abb8141ef5e90f" );
    main_ball.mover utility::function_7c10ea82c1e305b8( "fx", "collision" );
    earthquake( 0.2, 3, var_c27efcf4d873bd51.origin, 500 );
    playrumbleonposition( "low_highfreq", var_c27efcf4d873bd51.origin );
    wait 1;
    mover delete();
    main_ball.mover delete();
    main_ball freescriptable();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x91b16f15, Offset: 0x2e2c4
// Size: 0x5a
function function_3d49269dc44b2c3e()
{
    step = 0.1;
    
    while ( !level utility::flag( "hornet_mq_smoke_ball_finished_moving" ) )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        earthquake( 0.2, step, self.origin, 150 );
        playrumbleonposition( "low_highfreq", self.origin );
        wait step;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x31c15d07, Offset: 0x2e326
// Size: 0xc2
function function_eb8309335458fc46( path )
{
    wait randomfloatrange( 0, 1 );
    fx_sbl = spawnscriptable( %"zm_sat_hornet_mq_trail", path[ 0 ], ( 0, 0, 0 ) );
    fx_sbl utility::function_7c10ea82c1e305b8( "visual", "smoke" );
    mover = utility::spawn_model( "tag_origin", path[ 0 ], ( 0, 0, 0 ) );
    waitframe();
    fx_sbl utility::scriptable_setparententity( mover );
    time = 3.5 * randomfloatrange( 0.85, 1.1 );
    mover utility::function_2159dd4196ff4b81( path, time, 1, 0, 0, 1, 0.1 );
    fx_sbl freescriptable();
    mover delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xcbeecdee, Offset: 0x2e3f0
// Size: 0x63
function setup_graphic_screens()
{
    level.hornet_mq.graphic_screens = {};
    a_screens = getentitylessscriptablearray( "mq_e_screen", #targetname );
    a_screens = arraysort( a_screens, undefined, &compare_script_int );
    level.hornet_mq.graphic_screens.a_screens = a_screens;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xc41972de, Offset: 0x2e45b
// Size: 0x4f9
function function_792c7fa14bdc067( ref, var_1cc80ebfb61cb6bf = 0 )
{
    foreach ( screen in level.hornet_mq.graphic_screens.a_screens )
    {
        if ( screen.script_noteworthy == ref )
        {
            target_screen = screen;
            break;
        }
    }
    
    if ( !isdefined( target_screen ) )
    {
        assertmsg( "<dev string:x15d>" );
        return;
    }
    
    if ( ref == "loc" )
    {
        ref = function_fd0f9391fa10d0d3();
    }
    
    if ( var_1cc80ebfb61cb6bf )
    {
        look_center = utility::getstruct( "gslook_center", "targetname" );
        zone_trig = getent( "evid_room_trig", #targetname );
        var_698413ce614574f7 = 0;
        
        while ( true )
        {
            var_490b28fb5c703838 = 0;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player istouching( zone_trig ) && utility::function_af749a6c1f8241f0( player, look_center.origin, 50 ) )
                {
                    var_490b28fb5c703838 = 1;
                    var_b0ba0211aafd8ca0 = player;
                    
                    if ( var_698413ce614574f7 >= 1 )
                    {
                        if ( !var_b0ba0211aafd8ca0 player_banter::function_4e1aff6241ebea8() )
                        {
                            var_6fb860f7c9723d4e = 1;
                            break;
                        }
                    }
                }
            }
            
            if ( var_490b28fb5c703838 )
            {
                var_698413ce614574f7 += 0.1;
            }
            else
            {
                var_698413ce614574f7 = 0;
            }
            
            if ( var_6fb860f7c9723d4e )
            {
                break;
            }
            
            wait 0.1;
        }
    }
    
    if ( var_1cc80ebfb61cb6bf )
    {
        earthquake( 0.1, 3, target_screen.origin, 200 );
        wait 0.5;
        playrumbleonposition( "light_2s", target_screen.origin );
    }
    
    level utility::flag_set( "mq_directed_revealed_screen_" + ref );
    
    if ( level.directed_mode )
    {
        switch ( ref )
        {
            case #"hash_90259d6c553fba32":
                round_cap = 12;
                break;
            case #"hash_c775b6c10b66b7a":
                round_cap = 13;
                break;
            case #"hash_890e226c519dc6ab":
                round_cap = 14;
                break;
            case #"hash_2f27486c2242f37d":
            case #"hash_69f5eb33db9880ec":
            case #"hash_69f5ec33db98827f":
            case #"hash_69f5ee33db9885a5":
                round_cap = 15;
                break;
        }
        
        if ( round_cap )
        {
            level thread zm_quest::update_round_cap( round_cap );
        }
        
        level function_ecc91637c2a6fbb1();
    }
    
    if ( isalive( var_b0ba0211aafd8ca0 ) )
    {
        if ( var_b0ba0211aafd8ca0 namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            selected_player = var_b0ba0211aafd8ca0;
        }
        else
        {
            a_other_players = function_d63fe6a4c08ba6f5( var_b0ba0211aafd8ca0.origin, 600, 64, 0, [ var_b0ba0211aafd8ca0 ] );
            
            if ( a_other_players.size > 0 )
            {
                foreach ( other_player in a_other_players )
                {
                    if ( var_b0ba0211aafd8ca0 namespace_c0b4f2882c9d100f::is_hero_operator() )
                    {
                        selected_player = other_player;
                        break;
                    }
                }
            }
        }
        
        if ( isdefined( selected_player ) )
        {
            switch ( ref )
            {
                case #"hash_90259d6c553fba32":
                    alias = #"hash_86391a0552ff1b39";
                    break;
                case #"hash_c775b6c10b66b7a":
                    alias = #"hash_b89e9197288f253";
                    break;
                case #"hash_890e226c519dc6ab":
                    alias = #"hash_40056923cfa0f46c";
                    break;
                case #"hash_69f5eb33db9880ec":
                case #"hash_69f5ec33db98827f":
                case #"hash_69f5ee33db9885a5":
                    alias = #"hash_9b5b736ae1cd5d6e";
                    break;
                case #"hash_2894da6c1f0a5e33":
                    alias = #"hash_7adf37deebc15110";
                    break;
                default:
                    break;
            }
            
            if ( isdefined( alias ) )
            {
                selected_player thread function_2a6deff157d1165a( alias, undefined, 3.25 );
            }
        }
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_9a9c62e013db3274" );
    target_screen utility::function_7c10ea82c1e305b8( "model", ref );
    level thread function_91c6730a76bb7ffa( ref );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x3b046dce, Offset: 0x2e95c
// Size: 0x110
function function_fd0f9391fa10d0d3()
{
    var_83ae5d90bf06dda = undefined;
    solution = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_31a970df2e88b6ab" );
    
    foreach ( index in [ 9, 10, 11 ] )
    {
        if ( utility::get_bit_flag( solution, index ) )
        {
            var_83ae5d90bf06dda = index;
        }
    }
    
    switch ( var_83ae5d90bf06dda )
    {
        case 9:
            ref = "loc_c";
            break;
        case 10:
            ref = "loc_b";
            break;
        case 11:
            ref = "loc_a";
            break;
    }
    
    return ref;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xdabd75f1, Offset: 0x2ea75
// Size: 0x3b
function function_91c6730a76bb7ffa( step_ref )
{
    if ( step_ref == "sus" )
    {
        wait 3;
        level function_55acfd3cd98b6c2f();
    }
    
    if ( step_ref == "poi" )
    {
        wait 1.5;
        level function_2ed7c5fbeb746fd0();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 6, eflags: 0x4
// Checksum 0x53c35de4, Offset: 0x2eab8
// Size: 0x1e6
function private function_113be2163cc65126( bobspeed, spinspeed = undefined, var_b9ec064188b2225f = 0, var_ab820074ac19314c = 0, var_63155ce24e9fbb6 = 1, var_1f4b807e4eda3b51 = undefined )
{
    self endon( #"stop_bobbing" );
    level endon( #"game_ended" );
    
    if ( var_b9ec064188b2225f )
    {
        self.origin -= ( 0, 0, 64 );
    }
    
    mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( mover ) )
    {
        return;
    }
    
    if ( isdefined( self.linkedparent ) )
    {
        parent = self.linkedparent;
        utility::scriptable_clearparententity();
        parent delete();
    }
    
    utility::scriptable_setparententity( mover );
    
    if ( spinspeed > 0 )
    {
        mover thread function_e10aa0268e36149d( spinspeed, var_ab820074ac19314c );
    }
    
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    var_4e6259a9fa7bf79 = 0;
    
    if ( var_b9ec064188b2225f )
    {
        mover moveto( self.origin + ( 0, 0, 64 ), 2, 1.5, 0 );
        mover waittill( #"movedone" );
    }
    
    bob_height = isdefined( var_1f4b807e4eda3b51 ) ? var_1f4b807e4eda3b51 : 12;
    
    while ( isdefined( self ) )
    {
        if ( !var_63155ce24e9fbb6 && !var_4e6259a9fa7bf79 )
        {
            mover movez( bob_height * move_dir, bobspeed );
            var_4e6259a9fa7bf79 = 1;
        }
        else
        {
            mover movez( bob_height * move_dir, bobspeed, acceleration_const, acceleration_const );
        }
        
        mover waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2, eflags: 0x4
// Checksum 0xfb9dd27b, Offset: 0x2eca6
// Size: 0xe7
function private function_e10aa0268e36149d( spinspeed, var_ab820074ac19314c = 0 )
{
    self.linkedchildren[ 0 ] endon( #"death" );
    self.linkedchildren[ 0 ] endon( #"stop_bobbing" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( var_ab820074ac19314c )
    {
        rollspeed = spinspeed * randomfloatrange( 1.1, 1.35 );
        pitchspeed = spinspeed * randomfloatrange( 1.1, 1.35 );
    }
    
    while ( isdefined( self.linkedchildren[ 0 ] ) )
    {
        if ( var_ab820074ac19314c )
        {
            self rotateby( ( 35 * rollspeed, 35 * spinspeed, 35 * pitchspeed ), spinspeed );
        }
        else
        {
            self rotateyaw( 35, spinspeed );
        }
        
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5b9c6d6b, Offset: 0x2ed95
// Size: 0x27c
function on_note_closed( params )
{
    level notify( #"interactive_note_closed", params.note_data );
    
    if ( level.directed_mode )
    {
        level utility::flag_set( "solve_mq_read_note_" + params.note_data.ref );
        var_6ca39bdfbe732823 = function_961f851ce570e9cb( "acc" );
        
        if ( level utility::flag( "solve_mq_read_note_" + var_6ca39bdfbe732823 ) && level utility::flag( "solve_mq_read_note_zm_hornet_mq_pc" ) && ( level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_plant" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_food" ) ) )
        {
            level utility::flag_set( "solve_mq_has_cr_ex_poi" );
        }
        
        if ( level utility::flag( "solve_mq_read_note_zm_hornet_mq_pc" ) && ( level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_plant" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_paralysis" ) || level utility::flag( "solve_mq_read_note_zm_hornet_mq_dr_food" ) ) )
        {
            level utility::flag_set( "solve_mq_has_cr_ex_tme" );
        }
        
        level utility::delaycall( 0.1, &function_ecc91637c2a6fbb1 );
    }
    
    foreach ( other_player in level.players )
    {
        if ( other_player == params.player )
        {
            continue;
        }
        
        if ( isdefined( other_player.current_note ) && other_player.current_note == params.note_data.parent_scriptable )
        {
            other_player interactive_notes::close_note();
        }
    }
    
    if ( issubstr( params.note_data.ref, "zm_hornet_mq_pc" ) )
    {
        params.player thread function_2a6deff157d1165a( #"hash_69fd69c6507c8488", #"hash_5212ed7ec42f115a", 1.25 );
        return;
    }
    
    if ( issubstr( params.note_data.ref, "zm_hornet_mq_dr" ) )
    {
        params.player thread function_2a6deff157d1165a( #"hash_9041fc58abf9923d", #"hash_5212ed7ec42f115a", 0.25 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xb2825ea2, Offset: 0x2f019
// Size: 0x23
function function_a7d4311f575d62e4( params )
{
    params.player.current_note = self;
}

// Namespace zm_sat_hornet_mq_quest
// Params 5
// Checksum 0x3f671f6f, Offset: 0x2f044
// Size: 0x15b
function spawn_page( note_ref, param, loc, angles, var_f9d8b0696854da72 = 1 )
{
    if ( issubstr( note_ref, "zm_hornet_mq_dr" ) )
    {
        sbl_type = "interactive_note_hornet_mq_page" + "_dr";
    }
    else if ( issubstr( note_ref, "zm_hornet_mq_pc" ) )
    {
        sbl_type = "interactive_note_hornet_mq_page" + "_pc";
    }
    else if ( note_ref == "zm_hornet_mq_acc" + "_m" )
    {
        sbl_type = "interactive_note_hornet_mq_page" + "_acc_m";
    }
    else if ( note_ref == "zm_hornet_mq_acc" + "_n" )
    {
        sbl_type = "interactive_note_hornet_mq_page" + "_acc_n";
    }
    else if ( note_ref == "zm_hornet_mq_acc" + "_g" )
    {
        sbl_type = "interactive_note_hornet_mq_page" + "_acc_g";
    }
    else
    {
        assertmsg( "<dev string:x1a5>" );
        return;
    }
    
    data = level interactive_notes::create_note_data( note_ref, sbl_type, param );
    note = interactive_notes::spawn_note( data, loc, angles );
    note interaction::set_interact_hint_callback( &set_note_interact_hint_callback );
    playsoundatpos( loc, "evt_mq_evidence_note_ground_impact" );
    note callback::add( #"interactive_note_scriptable_used", &function_a7d4311f575d62e4 );
    
    if ( var_f9d8b0696854da72 )
    {
        level thread function_f71bdeafbc637aee( note );
    }
    
    return note;
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x6095db59, Offset: 0x2f1a8
// Size: 0x255
function set_note_interact_hint_callback( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.note_data && usable.note_data.ref == "zm_hornet_mq_pc" )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_a6f64cfe79d07ed", #type:"HINT_BUTTON" };
    }
    
    if ( usable.note_data && issubstr( usable.note_data.ref, "zm_hornet_mq_dr" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_1aa857267c9ddc60", #type:"HINT_BUTTON" };
    }
    
    if ( usable.note_data && usable.note_data.ref == "zm_hornet_mq_acc" + "_m" )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_2a94ad01c3963b69", #type:"HINT_BUTTON" };
    }
    
    if ( usable.note_data && usable.note_data.ref == "zm_hornet_mq_acc" + "_g" )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_68690321ad44e32b", #type:"HINT_BUTTON" };
    }
    
    if ( usable.note_data && usable.note_data.ref == "zm_hornet_mq_acc" + "_n" )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_7058114bc8a98642", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"INTERACTABLE_NOTES_SABA/HINT_NOTE_DEFAULT", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xe8888530, Offset: 0x2f405
// Size: 0x208
function function_f71bdeafbc637aee( note )
{
    level endon( #"game_ended" );
    data = note.note_data;
    
    while ( true )
    {
        level waittill( #"interactive_note_closed", closed_note_data );
        
        if ( closed_note_data.parent_scriptable == note )
        {
            break;
        }
    }
    
    var_7ced37341c55f339 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_64236e264a7d47fb" );
    
    if ( !isdefined( var_7ced37341c55f339 ) )
    {
        var_7ced37341c55f339 = 0;
    }
    
    indices = function_2afa8dc00045f1( data );
    
    foreach ( index in indices )
    {
        var_7ced37341c55f339 = utility::set_bit_flag( var_7ced37341c55f339, index );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_64236e264a7d47fb", var_7ced37341c55f339 );
    note freescriptable();
    
    if ( !( isdefined( data ) && isdefined( data.ref ) ) )
    {
        assertmsg( "<dev string:x1d8>" );
        return;
    }
    
    dest = function_5f89cd24480ebd1b( data.ref );
    
    if ( level.directed_mode && issubstr( data.ref, "zm_hornet_mq_pc" ) )
    {
        level.hornet_mq.var_b13513a678ed761 = undefined;
        level function_ecc91637c2a6fbb1();
    }
    
    if ( !isdefined( dest ) )
    {
        assertmsg( "<dev string:x22d>" );
        return;
    }
    
    spawn_page( data.ref, data.variant, dest.origin, dest.angles, 0 );
    
    /#
        iprintlnbold( "<dev string:x26c>" );
    #/
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5243fdd3, Offset: 0x2f615
// Size: 0x82
function function_5f89cd24480ebd1b( note_ref )
{
    if ( issubstr( note_ref, "zm_hornet_mq_dr" ) )
    {
        dest = utility::getstruct( "zm_hornet_mq_dr", "targetname" );
        return dest;
    }
    
    if ( issubstr( note_ref, "zm_hornet_mq_pc" ) )
    {
        dest = utility::getstruct( "zm_hornet_mq_pc", "targetname" );
        return dest;
    }
    
    if ( issubstr( note_ref, "zm_hornet_mq_acc" ) )
    {
        dest = utility::getstruct( note_ref, "targetname" );
        return dest;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x5308d24, Offset: 0x2f6a0
// Size: 0x21c
function function_2afa8dc00045f1( data )
{
    note_ref = data.ref;
    note_variant = data.variant;
    
    if ( issubstr( note_ref, "zm_hornet_mq_dr" ) )
    {
        note_index = 0;
        
        if ( note_ref == "zm_hornet_mq_dr" + "_plant" )
        {
            note_variant_index = 1;
        }
        else if ( note_ref == "zm_hornet_mq_dr" + "_paralysis" )
        {
            note_variant_index = 2;
        }
        else if ( note_ref == "zm_hornet_mq_dr" + "_food" )
        {
            note_variant_index = 3;
        }
        
        switch ( note_variant )
        {
            case 1:
                var_dea2bf1ff1b4a68e = 22;
                break;
            case 2:
                var_dea2bf1ff1b4a68e = 23;
                break;
            case 3:
                var_dea2bf1ff1b4a68e = 24;
                break;
            case 4:
                var_dea2bf1ff1b4a68e = 25;
                break;
            case 5:
                var_dea2bf1ff1b4a68e = 26;
                break;
            case 6:
                var_dea2bf1ff1b4a68e = 27;
                break;
            default:
                var_dea2bf1ff1b4a68e = undefined;
                break;
        }
    }
    else if ( issubstr( note_ref, "zm_hornet_mq_pc" ) )
    {
        note_index = 12;
        
        if ( isdefined( note_variant ) )
        {
            switch ( note_variant )
            {
                case 1:
                    note_variant_index = 13;
                    break;
                case 2:
                    note_variant_index = 14;
                    break;
                case 3:
                    note_variant_index = 15;
                    break;
                default:
                    note_variant_index = undefined;
                    break;
            }
        }
    }
    else if ( issubstr( note_ref, "zm_hornet_mq_acc" + "_g" ) )
    {
        note_index = 17;
    }
    else if ( issubstr( note_ref, "zm_hornet_mq_acc" + "_n" ) )
    {
        note_index = 19;
    }
    else if ( issubstr( note_ref, "zm_hornet_mq_acc" + "_m" ) )
    {
        note_index = 21;
    }
    
    return_data = [ note_index, note_variant_index, var_dea2bf1ff1b4a68e ];
    return_data = function_5713d46873b29625( return_data );
    return return_data;
}

// Namespace zm_sat_hornet_mq_quest
// Params 3
// Checksum 0xdc458db0, Offset: 0x2f8c5
// Size: 0x210
function function_f94b860aecb76639( note_type_index, variant_index = undefined, var_bff23b62f1c81add = undefined )
{
    if ( isdefined( variant_index ) )
    {
        switch ( variant_index )
        {
            case 1:
                variant_ref = "_plant";
                break;
            case 3:
                variant_ref = "_food";
                break;
            case 2:
                variant_ref = "_paralysis";
                break;
            case 13:
                variant_ref = 1;
                break;
            case 14:
                variant_ref = 2;
                break;
            case 15:
                variant_ref = 3;
                break;
        }
    }
    
    if ( isdefined( var_bff23b62f1c81add ) )
    {
        switch ( var_bff23b62f1c81add )
        {
            case 22:
                var_f71eb3049192f730 = 1;
                break;
            case 23:
                var_f71eb3049192f730 = 2;
                break;
            case 24:
                var_f71eb3049192f730 = 3;
                break;
            case 25:
                var_f71eb3049192f730 = 4;
                break;
            case 26:
                var_f71eb3049192f730 = 5;
                break;
            case 27:
                var_f71eb3049192f730 = 6;
                break;
        }
    }
    
    switch ( note_type_index )
    {
        case 0:
            note_ref = "zm_hornet_mq_dr" + variant_ref;
            break;
        case 12:
            note_ref = "zm_hornet_mq_pc";
            break;
        case 17:
            note_ref = "zm_hornet_mq_acc" + "_g";
            break;
        case 19:
            note_ref = "zm_hornet_mq_acc" + "_n";
            break;
        case 21:
            note_ref = "zm_hornet_mq_acc" + "_m";
            break;
    }
    
    var_ef8ba9b0d91da68c = { #var_f71eb3049192f730:var_f71eb3049192f730, #variant_ref:variant_ref, #note_ref:note_ref };
    return var_ef8ba9b0d91da68c;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x82a66822, Offset: 0x2fade
// Size: 0x365
function function_a82b58868927f4ae()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    var_a83fe95ced8fdb4 = utility::getstructarray( "mq_mh_ew_loc", "targetname" );
    
    foreach ( struct in var_a83fe95ced8fdb4 )
    {
        struct.sbl = spawnscriptable( %"zm_sat_hornet_ghost", struct.origin, struct.angles );
        struct.var_c91f26ce3738add1 = 0;
        
        if ( struct.script_int == 1 )
        {
            /#
                debugstar( struct.sbl.origin, ( 0, 0, 1 ), 900 );
            #/
            
            spawn_offset = vectornormalize( anglestoforward( struct.sbl.angles ) ) * 80 + ( 0, 0, 45 );
            
            /#
                debugstar( struct.sbl.origin + spawn_offset, ( 1, 1, 1 ), 900 );
            #/
        }
        else
        {
            spawn_offset = vectornormalize( anglestoforward( struct.sbl.angles ) ) * 40 + ( 0, 0, 45 );
        }
        
        struct.interact = interaction::register_interact( struct.sbl.origin + spawn_offset, 80, &function_7ffa914111ac60bb );
        struct.interact interaction::set_interact_hint_callback( &function_b60fa544be669c6f );
        
        if ( level.directed_mode )
        {
            struct.interact makeunusable();
        }
        
        struct.trap_root = utility::getstruct( "mh_root_" + struct.script_int, "script_noteworthy" );
        struct.sbl.var_c0c940b175bdf3ca = struct;
        struct.interact.var_c0c940b175bdf3ca = struct;
        struct thread function_44196dc27cf9e0b9();
        
        if ( struct.script_int == 4 && utility::get_bit_flag( var_181bfe57b6b9d727, 16 ) )
        {
            struct.var_bf0a22dcb2f3138d = 1;
            continue;
        }
        
        if ( struct.script_int == 1 && utility::get_bit_flag( var_181bfe57b6b9d727, 14 ) )
        {
            struct.var_bf0a22dcb2f3138d = 1;
            continue;
        }
        
        if ( struct.script_int == 3 && utility::get_bit_flag( var_181bfe57b6b9d727, 15 ) )
        {
            struct.var_bf0a22dcb2f3138d = 1;
        }
    }
    
    level.hornet_mq.var_a83fe95ced8fdb4 = var_a83fe95ced8fdb4;
    
    if ( utility::get_bit_flag( var_181bfe57b6b9d727, 17 ) )
    {
        level utility::flag_set( "mq_guided_correct_acc_test_received" );
    }
    
    level utility::flag_set( "mq_eyewitness_ghost_setup_complete" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xdf7f9535, Offset: 0x2fe4b
// Size: 0x99
function function_3577204b85000e68()
{
    level utility::flag_wait( "mq_eyewitness_ghost_setup_complete" );
    
    foreach ( ghost_struct in level.hornet_mq.var_a83fe95ced8fdb4 )
    {
        ghost_struct.interact makeusable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x482cf781, Offset: 0x2feec
// Size: 0xdd
function function_44196dc27cf9e0b9()
{
    level endon( #"game_ended" );
    level endon( #"mq_step_33_complete" );
    level waittill( #"mq_step_13_complete" );
    
    if ( level.directed_mode )
    {
        level function_3577204b85000e68();
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.hornet_mq.throttle, self.trap_root );
        self.trap_root waittill( #"trap_activated" );
        self.trap_root thread function_b2c512b26409373c( self );
        self.num_kills = 0;
        
        if ( level.directed_mode )
        {
            if ( !level.hornet_mq.var_a3569cd04eed51b )
            {
                level.hornet_mq.var_a3569cd04eed51b = self;
            }
            
            level function_ecc91637c2a6fbb1();
        }
        
        thread function_675b9214723cd1f();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xeac5fe43, Offset: 0x2ffd1
// Size: 0x1a0
function function_675b9214723cd1f()
{
    self notify( #"hash_974f11a41f8d93f0" );
    self endon( #"hash_974f11a41f8d93f0" );
    self endon( #"trap_duration_ended" );
    
    if ( level.directed_mode && self == level.hornet_mq.var_a3569cd04eed51b )
    {
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"hornet_mq_guidance", #"hash_58db0e6e919a0db8" );
    }
    
    while ( self.trap_root.var_711e3c9a288e87ff )
    {
        self.trap_root waittill( #"hash_9dcf89f0e929dea6" );
        self.num_kills += 1;
        
        if ( level.directed_mode && self == level.hornet_mq.var_a3569cd04eed51b )
        {
            progress = self.num_kills / 20 * 100;
            level zm_quest::function_9f49b2a045ece8ae( progress, 1, #"hornet_mq_guidance", #"hash_58db0e6e919a0db8" );
        }
        
        if ( self.num_kills >= 20 )
        {
            self.sbl utility::function_7c10ea82c1e305b8( "model", "samurai_ghost" );
            self.sbl utility::function_7c10ea82c1e305b8( "spawn", "show" );
            self.sbl utility::function_7c10ea82c1e305b8( "fx", "fullbody" );
            self.sbl utility::function_7c10ea82c1e305b8( "anims", "idle" );
            self.var_c91f26ce3738add1 = 1;
            self.var_13da55243ecd1ae8 = 0;
            level function_ecc91637c2a6fbb1();
            break;
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x38f7f4c, Offset: 0x30179
// Size: 0x117
function function_b2c512b26409373c( ghost_struct )
{
    self notify( #"hash_5a0a21ba759226e3" );
    self endon( #"hash_5a0a21ba759226e3" );
    level endon( #"game_ended" );
    self waittill( #"trap_duration_ended" );
    
    if ( level.directed_mode && ghost_struct == level.hornet_mq.var_a3569cd04eed51b )
    {
        level.hornet_mq.var_a3569cd04eed51b = undefined;
        level function_ecc91637c2a6fbb1();
    }
    
    ghost_struct.sbl utility::function_32b24db3127bff40( "spawn", "none" );
    ghost_struct.sbl utility::function_32b24db3127bff40( "model", "invisible" );
    ghost_struct.sbl utility::function_32b24db3127bff40( "fx", "none" );
    ghost_struct.sbl utility::function_32b24db3127bff40( "anims", "none" );
    ghost_struct.sbl utility::function_7c10ea82c1e305b8( "despawn", "default" );
    ghost_struct.var_c91f26ce3738add1 = 0;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x1ea3aae9, Offset: 0x30298
// Size: 0x1f6
function function_7ffa914111ac60bb( player )
{
    if ( !self.var_c0c940b175bdf3ca.var_c91f26ce3738add1 || self.var_c0c940b175bdf3ca.var_13da55243ecd1ae8 )
    {
        return;
    }
    
    if ( level.directed_mode )
    {
        self.var_c0c940b175bdf3ca.var_bf0a22dcb2f3138d = 1;
    }
    
    self.var_c0c940b175bdf3ca.var_13da55243ecd1ae8 = 1;
    ghost_zone = zone_manager::function_90e5c3e2272b0130( self.var_c0c940b175bdf3ca.origin );
    
    if ( isdefined( ghost_zone ) )
    {
        zone_spawner::function_2ce7db1d59b307d8( ghost_zone.zone_name );
    }
    
    var_cf60afae55368970 = self.var_c0c940b175bdf3ca function_db108efba6c18a6f();
    speaker_ent = utility::spawn_model( "tag_origin", self.var_c0c940b175bdf3ca.origin, self.var_c0c940b175bdf3ca.angles );
    speaker_ent dialogue::say( utility::array_random( var_cf60afae55368970 ), 99, 0, 0, 1.5 );
    
    if ( isdefined( ghost_zone ) )
    {
        zone_spawner::function_8a020f24a3b73c79( ghost_zone.zone_name );
    }
    
    self.var_c0c940b175bdf3ca.sbl utility::function_32b24db3127bff40( "spawn", "none" );
    self.var_c0c940b175bdf3ca.sbl utility::function_32b24db3127bff40( "model", "invisible" );
    self.var_c0c940b175bdf3ca.sbl utility::function_32b24db3127bff40( "fx", "none" );
    self.var_c0c940b175bdf3ca.sbl utility::function_32b24db3127bff40( "anims", "none" );
    self.var_c0c940b175bdf3ca.var_c91f26ce3738add1 = 0;
    level.hornet_mq.var_a3569cd04eed51b = undefined;
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xd1f0f28b, Offset: 0x30496
// Size: 0xd8
function function_b60fa544be669c6f( usable, player )
{
    if ( usable.var_c0c940b175bdf3ca.var_13da55243ecd1ae8 || !usable.var_c0c940b175bdf3ca.var_c91f26ce3738add1 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_4fd4612eee469c1a", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x9b4910e6, Offset: 0x30576
// Size: 0x222
function function_db108efba6c18a6f()
{
    switch ( level.hornet_mq.solution_info.accomplice_index )
    {
        case 3:
            accomplice = "g";
            var_ff27a8f22579a864 = [ #"hash_1244e08e9d778d5a" ];
            var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 16 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
            break;
        case 4:
            accomplice = "n";
            var_ff27a8f22579a864 = [ #"hash_83707d0931f99723" ];
            var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 15 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
            break;
        case 5:
            accomplice = "m";
            var_ff27a8f22579a864 = [ #"hash_bb8e0a8e6c52fb33" ];
            var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
            var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 14 );
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
            break;
        default:
            accomplice = undefined;
            var_ff27a8f22579a864 = [ #"hash_c372678e70937f2e" ];
            break;
    }
    
    if ( self.script_noteworthy != accomplice )
    {
        var_ff27a8f22579a864 = [ #"hash_c372678e70937f2e" ];
    }
    else
    {
        level utility::flag_set( "mq_guided_correct_acc_test_received" );
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 17 );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
    }
    
    return var_ff27a8f22579a864;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x8a574644, Offset: 0x307a1
// Size: 0x2
function function_b143270e2c2975d9()
{
    
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xc10a6e7, Offset: 0x307ab
// Size: 0x333
function function_90c72c6cab29cb72( var_ebdb33df8213d1d8 = 0 )
{
    level utility::flag_wait( "scriptables_ready" );
    level zm_save::function_1f44a48caae2acbf();
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    
    if ( utility::get_bit_flag( var_181bfe57b6b9d727, 19 ) )
    {
        level.var_77cd5723411bf803 = 1;
    }
    
    var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 19 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
    
    while ( !isdefined( level.players ) || level.players.size <= 0 )
    {
        waitframe();
    }
    
    level function_3582825f5c626855();
    
    if ( !var_ebdb33df8213d1d8 )
    {
        vignette_locs = utility::getstructarray( "mq_oyo_ptp_exit_loc", "targetname" );
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( distancesquared( level.players[ i ].origin, vignette_locs[ i ].origin ) > 625 )
            {
                if ( level.players[ i ] isspectatinganyone() || level.players[ i ].sessionstate == "spectator" )
                {
                    continue;
                }
                
                level.players[ i ] setorigin( vignette_locs[ i ].origin );
                level.players[ i ] setplayerangles( vignette_locs[ i ].angles );
            }
        }
    }
    else
    {
        level utility::flag_clear( "kill_diana_wingbeat" );
        
        /#
            function_413a9c1c74bd7a4d();
        #/
    }
    
    foreach ( player in level.players )
    {
        player function_814e28ebc00f977d();
        player function_37716fe9178a62fc( 1 );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_aeb585af4a2599d3" );
    level zm_round_spawning::pause_round_spawning( 1, "mq_dragon_vignette_pause_round_spawning" );
    level zm_utility::util_kill_all_zombies();
    
    if ( level.hornet_pap_quest.sc_pedestal )
    {
        level.hornet_pap_quest.sc_pedestal utility::function_7c10ea82c1e305b8( "visual", "pedestal_free" );
    }
    
    if ( level.hornet_pap_quest.sc_seed_hair )
    {
        level.hornet_pap_quest.sc_seed_hair freescriptable();
    }
    
    wait 0.5;
    childthread function_d86b7b1b1bd30ab0();
    childthread function_d9dfa2199a0b05e7();
    childthread function_6ac9583ed6ddbf45();
    childthread function_1b5755cfa853c4a9();
    s_scenedef = utility::getstruct( "sat_cin_zm_vig_pap_smash_grab", "targetname" );
    s_scenedef scene::play( s_scenedef.existingents );
    level zm_round_spawning::pause_round_spawning( 0, "mq_dragon_vignette_pause_round_spawning" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x603afc5b, Offset: 0x30ae6
// Size: 0x2f
function function_b534f739af4f3c49()
{
    zom_diana = scene::get_entity( "diana" );
    childthread function_97868a8c6c05d0cc( zom_diana );
    zom_diana notify( #"hash_4ad5af914cce06a3" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x4a92dea4, Offset: 0x30b1d
// Size: 0x29
function function_26600a0de797bdbf()
{
    zom_diana = scene::get_entity( "diana" );
    
    if ( isalive( zom_diana ) )
    {
        zom_diana kill();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xb0f35cc5, Offset: 0x30b4e
// Size: 0x8e
function function_97868a8c6c05d0cc( ent_diana )
{
    ent_diana endon( #"death" );
    var_40a39f0725737c35 = 0.1;
    var_f53bf2b4d87cb195 = level.framedurationseconds * 20;
    level waittill( #"hash_8df867817683467" );
    
    while ( !level utility::flag( "kill_diana_wingbeat" ) )
    {
        earthquake( var_40a39f0725737c35, var_f53bf2b4d87cb195, ent_diana.origin, 7500 );
        playrumbleonposition( "damage_light", ent_diana.origin );
        wait var_f53bf2b4d87cb195;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x33695c2b, Offset: 0x30be4
// Size: 0x1bb
function function_d86b7b1b1bd30ab0()
{
    var_d2e68fcd2059ee26 = utility::getstruct( "diana_vig_eq_loc_outer", "targetname" );
    var_fe6aded37b5d9cf0 = [];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "med", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "small", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "med", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "large", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "small", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "medium", var_d2e68fcd2059ee26 ];
    var_fe6aded37b5d9cf0[ var_fe6aded37b5d9cf0.size ] = [ "medium", var_d2e68fcd2059ee26 ];
    rumble_index = 0;
    
    while ( true )
    {
        if ( rumble_index >= var_fe6aded37b5d9cf0.size )
        {
            break;
        }
        
        level waittill( #"hash_a56c44de6869ed14" );
        level utility::flag_set( "kill_diana_wingbeat" );
        earthquake_loc = var_fe6aded37b5d9cf0[ rumble_index ][ 1 ];
        
        switch ( var_fe6aded37b5d9cf0[ rumble_index ][ 0 ] )
        {
            case #"hash_5971965ed985a26c":
                earthquake_size = 0.1;
                var_f761544d755bbd79 = 1;
                rumble = "low_highfreq";
            case #"hash_28a7ce6c1f1955d9":
                earthquake_size = 0.2;
                var_f761544d755bbd79 = 1;
                rumble = "damage_med";
            case #"hash_4bf33d595d8f4894":
                earthquake_size = 0.3;
                var_f761544d755bbd79 = 2;
                rumble = "heavy_5s";
                break;
        }
        
        earthquake( earthquake_size, var_f761544d755bbd79, earthquake_loc.origin, 1750 );
        playrumbleonposition( rumble, earthquake_loc.origin );
        rumble_index += 1;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x30bb60fd, Offset: 0x30da7
// Size: 0x172
function function_d9dfa2199a0b05e7()
{
    level waittill( #"hash_29259764bbf71ab2" );
    
    if ( level.hornet_pap_quest.sc_pedestal )
    {
        level.hornet_pap_quest.sc_pedestal freescriptable();
    }
    
    if ( level.hornet_pap_quest.sc_seed )
    {
        level.hornet_pap_quest.sc_seed delete();
    }
    
    if ( level.hornet_pap_quest.sc_seed_hair )
    {
        level.hornet_pap_quest.sc_seed_hair freescriptable();
    }
    
    if ( !isdefined( level.hornet_pap_quest.onryo_katana ) )
    {
        return;
    }
    
    if ( !isdefined( level.hornet_mq.solve_attempts ) )
    {
        level.hornet_mq.solve_attempts = 0;
    }
    
    var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
    
    if ( ( getdvarint( @"zombie_cheat", 0 ) || level.hornet_mq.solve_attempts <= 1 || !utility::get_bit_flag( var_181bfe57b6b9d727, 18 ) ) && !isdefined( level.var_77cd5723411bf803 ) )
    {
        level thread free_sword();
        return;
    }
    
    level.hornet_pap_quest.onryo_katana delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0x77803144, Offset: 0x30f21
// Size: 0x250
function private free_sword()
{
    level utility::flag_set( "hornet_mq_mystery_solved_first_attempt" );
    var_c23a8cb334b43f16 = utility::getstruct( "elnath_end_loc", "targetname" );
    control_pos = ( level.hornet_pap_quest.onryo_katana.origin + var_c23a8cb334b43f16.origin ) / 2;
    control_pos += ( 0, 0, 10 );
    move_time = 0.85;
    level.hornet_pap_quest.onryo_katana thread function_aca6982b3dfd7e66( var_c23a8cb334b43f16, move_time );
    level.hornet_pap_quest.onryo_katana utility::function_8001268940441423( level.hornet_pap_quest.onryo_katana.origin, var_c23a8cb334b43f16.origin, control_pos, move_time );
    
    foreach ( player in level.players )
    {
        var_8a61d4195b4b6e64 = getscriptbundle( %"itemspawnentry:zm_sat_item_weapon_me_elnath_ultra" );
        spawnoptions = common_item::function_bc5ff2958b71a708( var_c23a8cb334b43f16.origin, var_c23a8cb334b43f16.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        item = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
        
        foreach ( other_player in level.players )
        {
            if ( other_player == player )
            {
                continue;
            }
            
            item disablescriptableplayeruse( other_player );
            item function_d6a7b7ef13a57f38( other_player );
        }
    }
    
    level.hornet_pap_quest.onryo_katana delete();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0x6637ea2c, Offset: 0x31179
// Size: 0x7a
function function_aca6982b3dfd7e66( var_c23a8cb334b43f16, move_time )
{
    var_3713fe4fbd12ef53 = var_c23a8cb334b43f16.angles;
    self.angles = var_3713fe4fbd12ef53;
    var_9a5eb9ad5f8667eb = 5;
    step = move_time / var_9a5eb9ad5f8667eb;
    time_elapsed = 0;
    
    while ( time_elapsed <= move_time )
    {
        self rotatepitch( 360, step );
        wait step;
        time_elapsed += step;
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xa30f9d5c, Offset: 0x311fb
// Size: 0xf3
function function_1b5755cfa853c4a9()
{
    level waittill( #"hash_a1d9fc7bf1144aed" );
    
    foreach ( player in level.players )
    {
        player function_b252f2d3fe074e9e();
        player function_37716fe9178a62fc( 0 );
    }
    
    selected_player = utility::array_random( level.players );
    
    if ( selected_player )
    {
        selected_player thread function_2a6deff157d1165a( #"hash_6a1f04768ac487f4", #"bc_flavor_player_negative", 0.1 );
    }
    
    old_pap_col = getent( "clip_pap_pedestal", #targetname );
    old_pap_col hide();
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0xd512c598, Offset: 0x312f6
// Size: 0xf
function function_6ac9583ed6ddbf45()
{
    level waittill( #"hash_29259764bbf71ab2" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0xa64a14db, Offset: 0x3130d
// Size: 0x1ab
function function_37716fe9178a62fc( var_3a12f3a8d107bc87 )
{
    if ( var_3a12f3a8d107bc87 )
    {
        val::set( #"hash_f053074b9dad9d61", "allow_movement", 0 );
        val::set( #"hash_f053074b9dad9d61", "show_hud", 0 );
        val::set( #"hash_f053074b9dad9d61", "fire", 0 );
        val::set( #"hash_f053074b9dad9d61", "melee", 0 );
        val::set( #"hash_f053074b9dad9d61", "stance_change", 0 );
        val::set( #"hash_f053074b9dad9d61", "ads", 0 );
        val::set( #"hash_f053074b9dad9d61", "weapon_switch", 0 );
        val::set( #"hash_f053074b9dad9d61", "ignore_playable_area_check", 1 );
        val::set( #"hash_f053074b9dad9d61", "ignoreme", 1 );
        val::set( #"hash_f053074b9dad9d61", "allow_toggle_third_person", 0 );
        self.var_466457b7a975a0d6 = utility::spawn_tag_origin( self.origin, self getplayerangles( 0 ) );
        self playerlinktodelta( self.var_466457b7a975a0d6, "tag_origin", 0, 25, 25, 25, 25, 1, 1 );
        self.var_c265931620eac039 = self getcamerathirdperson();
        
        if ( self.var_c265931620eac039 )
        {
            self setcamerathirdperson( 0 );
        }
        
        return;
    }
    
    val::reset_all( #"hash_f053074b9dad9d61" );
    self unlink();
    
    if ( isdefined( self.var_466457b7a975a0d6 ) )
    {
        self.var_466457b7a975a0d6 delete();
        self.var_466457b7a975a0d6 = undefined;
    }
    
    if ( self.var_c265931620eac039 )
    {
        self setcamerathirdperson( 1 );
    }
    
    self.var_c265931620eac039 = undefined;
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0x3bddaf9, Offset: 0x314c0
// Size: 0x5e
function private function_814e28ebc00f977d()
{
    if ( !self hasweapon( level.defaultfist ) )
    {
        inventory_utility::_giveweapon( level.defaultfist );
        self.var_921eb6cefd4f85ef = 1;
    }
    
    self.var_573e8e51d228740 = self getcurrentweapon();
    
    if ( self getcurrentweapon() != level.defaultfist )
    {
        self switchtoweapon( level.defaultfist );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0xbdbdcbe, Offset: 0x31526
// Size: 0x8e
function private function_b252f2d3fe074e9e()
{
    if ( self.var_921eb6cefd4f85ef )
    {
        inventory_utility::_takeweapon( level.defaultfist );
    }
    
    self.var_921eb6cefd4f85ef = undefined;
    
    if ( isdefined( self.var_573e8e51d228740 ) && self hasweapon( self.var_573e8e51d228740 ) )
    {
        if ( self.var_573e8e51d228740 != level.defaultfist )
        {
            self switchtoweapon( self.var_573e8e51d228740 );
        }
    }
    else if ( val::get( "weapon" ) )
    {
        inventory_utility::forcevalidweapon();
    }
    
    self.var_573e8e51d228740 = undefined;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x3166e6b7, Offset: 0x315bc
// Size: 0x24a
function function_af6027f41da042e3( b_dev_skip = 0 )
{
    if ( !b_dev_skip )
    {
        wait 5;
        level waittill( #"hash_a1d9fc7bf1144aed" );
    }
    
    if ( level.hornet_mq.bossfight_interact )
    {
        level.hornet_mq.bossfight_interact delete();
    }
    
    banner_loc = utility::getstruct( "koinobori_bossfight", "targetname" );
    level.hornet_mq.bossfight_banner = spawnscriptable( %"zm_sat_hornet_koinobori", banner_loc.origin, banner_loc.angles );
    move_time_sec = 2.5;
    var_1ccc664edf819117 = 0;
    target_z_offset = 192;
    var_a2d962c5022d11f9 = level.hornet_mq.bossfight_banner.origin[ 2 ];
    
    while ( var_1ccc664edf819117 < 1 )
    {
        new_z = easing::ease_back( 0, target_z_offset, var_1ccc664edf819117, 1, 1, 0.14 );
        new_origin = ( level.hornet_mq.bossfight_banner.origin[ 0 ], level.hornet_mq.bossfight_banner.origin[ 1 ], var_a2d962c5022d11f9 + new_z );
        level.hornet_mq.bossfight_banner.origin = new_origin;
        wait level.framedurationseconds;
        var_1ccc664edf819117 += level.framedurationseconds / move_time_sec;
    }
    
    wait 1.5;
    interact_loc = utility::getstruct( "mq_bf_warp_interact", "targetname" );
    level.hornet_mq.bossfight_interact = interaction::register_interact( interact_loc.origin + ( 0, 0, 30 ), 80, &function_4bf6b817540ad50e );
    level.hornet_mq.bossfight_interact interaction::set_interact_hint_callback( &function_4dd6944967cc9aa7 );
    level.hornet_mq.bossfight_interact sethintonobstruction( "show" );
    level function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xec585a8e, Offset: 0x3180e
// Size: 0xc5
function function_4dd6944967cc9aa7( usable, player )
{
    if ( player.interactions_disabled || !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #buttoncallout:&"SHARED_HINTSTRINGS/FASTTRAVEL_TITLE", #icon:"sat_ui_icon_zm_ai_boss", #description:&"hash_6190e1ef867f528b", #string:&"hash_6190e1ef867f528b", #title:&"SHARED_HINTSTRINGS/FASTTRAVEL_TITLE", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0x4fe3d9fb, Offset: 0x318db
// Size: 0x3b0
function private function_4bf6b817540ad50e( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    /#
        if ( getdvarint( @"zombie_cheat", 0 ) )
        {
            b_passed = 1;
        }
    #/
    
    if ( b_passed && !level.var_7a0e1cc5121e500d )
    {
        self makeunusable();
        level utility::flag_set( "hornet_mq_blocking_horse_ee" );
        level utility::delaythread( 15, &utility::flag_clear, "hornet_mq_blocking_horse_ee" );
        level utility::flag_set( "mq_step_36_complete" );
        
        if ( isalive( level.ar_root.ar_diana ) )
        {
            level.ar_root.ar_diana val::reset( "zombie_diana", "death" );
            level.ar_root.ar_diana kill();
        }
        
        level function_3582825f5c626855();
        level notify( #"hornet_mq_bossfight_fasttravel_started" );
        
        foreach ( player in level.players )
        {
            player utility::ent_flag_set( "bossfight_fasttravel_active" );
        }
        
        if ( !level.hornet_mq.var_9375c03d9d90e6ac )
        {
            level.hornet_mq.var_9375c03d9d90e6ac = [];
            path_starts = utility::getstructarray( "bossfight_fly_in_path_start", "targetname" );
            
            foreach ( path_start in path_starts )
            {
                path = function_1215034504e1e891( path_start );
                level.hornet_mq.var_9375c03d9d90e6ac[ level.hornet_mq.var_9375c03d9d90e6ac.size ] = path;
            }
        }
        
        selected_player = utility::array_random( level.players );
        selected_player thread function_2a6deff157d1165a( #"hash_5f30f84d1a464996", #"bc_flavor_player_positive", 0.5 );
        level thread function_123e2161308e2a7c();
        level.hornet_mq.var_9375c03d9d90e6ac = arrayrandomize( level.hornet_mq.var_9375c03d9d90e6ac );
        
        for ( i = 0; i < level.hornet_mq.var_9375c03d9d90e6ac.size ; i++ )
        {
            if ( !level.players[ i ] )
            {
                break;
            }
            
            var_3b45147e7f19934e = { #path_time_override:12 * randomfloatrange( 0.9, 1.1 ), #b_skip_common_path:1 };
            level.players[ i ] thread function_28dcbe0ba25cf08( level.hornet_mq.var_9375c03d9d90e6ac[ i ], var_3b45147e7f19934e );
        }
        
        zm_utility::util_kill_all_zombies();
        level.var_7a0e1cc5121e500d = 1;
        zm_sat_hornet_boss_fight::start_boss_fight();
        self delete();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0, eflags: 0x4
// Checksum 0x92cc6613, Offset: 0x31c93
// Size: 0x111
function private function_123e2161308e2a7c()
{
    level endon( #"game_ended" );
    var_b4a6dec191a97b08 = 0;
    
    while ( true )
    {
        level waittill( #"hash_e884b09f4947a70e" );
        var_b4a6dec191a97b08++;
        
        if ( var_b4a6dec191a97b08 == level.var_3563a572046857f1 )
        {
            level.var_3563a572046857f1 = undefined;
            level notify( #"fast_travel_into_boss_arena_complete" );
            level notify( #"hash_d69e9ba70f5bf07c" );
            break;
        }
    }
    
    foreach ( player in level.players )
    {
        player utility::ent_flag_clear( "bossfight_fasttravel_active" );
    }
    
    if ( level.hornet_mq.bossfight_banner )
    {
        level.hornet_mq.bossfight_banner freescriptable();
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 2
// Checksum 0xd7a6bd1c, Offset: 0x31dac
// Size: 0x1bd
function function_28dcbe0ba25cf08( path, var_3b45147e7f19934e )
{
    if ( !isdefined( level.var_3563a572046857f1 ) )
    {
        level.var_3563a572046857f1 = 0;
    }
    
    level.var_3563a572046857f1++;
    msg = utility::waittill_any_in_array_or_timeout( [ "death_or_disconnect" ], randomfloatrange( 0.33, 1.33 ) );
    
    if ( msg == "death_or_disconnect" )
    {
        level.var_3563a572046857f1--;
        return;
    }
    
    self notify( #"fasttravel_start" );
    self.var_d1c4c78b9fb7d153 = 1;
    hud_util::fade_out( 3, "white", 1 );
    thread zm_sat_hornet_ninja_kite::function_bfcbb2ea1cdfec0b( path, var_3b45147e7f19934e );
    msg = utility::waittill_any_in_array_or_timeout( [ "death_or_disconnect" ], 0.5 );
    
    if ( msg == "death_or_disconnect" )
    {
        level.var_3563a572046857f1--;
        return;
    }
    
    thread hud_util::fade_out( 3, "white", 0 );
    activateworldevent( "we_vfx_boss_clouds" );
    activateworldevent( "we_vfx_volcano_vista", 1 );
    activateworldevent( "we_vfx_volcano_boss_start", 1 );
    msg = utility::waittill_any_in_array_or_timeout( [ "death_or_disconnect" ], randomfloatrange( 1, 3 ) );
    
    if ( msg == "death_or_disconnect" )
    {
        level.var_3563a572046857f1--;
        return;
    }
    
    roll_direction = utility::cointoss() ? "right" : "left";
    zm_sat_hornet_ninja_kite::roll_player_direction( roll_direction );
    msg = utility::waittill_any_in_array( [ "fasttravel_over", "death_or_disconnect" ] );
    
    if ( msg == "death_or_disconnect" )
    {
        level.var_3563a572046857f1--;
        return;
    }
    
    inventory_utility::takegunlessweapon();
    deactivateworldevent( "we_vfx_boss_clouds" );
    function_3d8060f59d60822a( 0 );
    self.var_d1c4c78b9fb7d153 = 0;
    level notify( #"hash_e884b09f4947a70e" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x6a101520, Offset: 0x31f71
// Size: 0x79
function function_1215034504e1e891( path_start )
{
    currnode = path_start;
    path = [ currnode.origin ];
    
    while ( true )
    {
        if ( !currnode.target )
        {
            break;
        }
        
        currnode = utility::getstruct( currnode.target, "targetname" );
        path[ path.size ] = currnode.origin;
    }
    
    return path;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0xf48f71e, Offset: 0x31ff3
// Size: 0x95
function private function_3d8060f59d60822a( var_b0e144194be51c26 )
{
    if ( var_b0e144194be51c26 )
    {
        val::set( #"hash_379a478893c16f36", "weapon", 0 );
        val::set( #"hash_379a478893c16f36", "freezecontrols", 1 );
        val::set( #"hash_379a478893c16f36", "ignore_playable_area_check", 1 );
        val::set( #"hash_379a478893c16f36", "ignoreme", 1 );
        val::set( #"hash_379a478893c16f36", "show_hud", 0 );
        return;
    }
    
    val::reset_all( #"hash_379a478893c16f36" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 4, eflags: 0x4
// Checksum 0x4a802602, Offset: 0x32090
// Size: 0xf7
function private function_e3a03fbfe3e8424b( var_e63c7e0aadac607f, a_players, n_delay_before, var_981a33fd66bb63f5 = 0 )
{
    assert( isarray( var_e63c7e0aadac607f ), "<dev string:x279>" );
    assert( var_e63c7e0aadac607f.size > 0, "<dev string:x293>" );
    
    if ( !var_981a33fd66bb63f5 )
    {
        if ( !isdefined( level.hornet_mq.var_6031232782b8ab51 ) )
        {
            level.hornet_mq.var_6031232782b8ab51 = [];
        }
        
        if ( arraycontains( level.hornet_mq.var_6031232782b8ab51, var_e63c7e0aadac607f[ 0 ] ) )
        {
            return;
        }
        
        level.hornet_mq.var_6031232782b8ab51[ level.hornet_mq.var_6031232782b8ab51.size ] = var_e63c7e0aadac607f[ 0 ];
    }
    
    level utility::flag_set( "hornet_mq_vo_playing" );
    level zm_quest::play_vo_events( var_e63c7e0aadac607f, a_players, n_delay_before );
    level utility::flag_clear( "hornet_mq_vo_playing" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 4, eflags: 0x4
// Checksum 0x1e487a43, Offset: 0x3218f
// Size: 0x110
function private function_490cc449b7de9830( var_cbb9de3ce21516de, a_players, n_delay_before, var_3226ffc41619dbe2 )
{
    assert( isarray( var_cbb9de3ce21516de ), "<dev string:x2ab>" );
    assert( var_cbb9de3ce21516de.size > 0, "<dev string:x2cc>" );
    
    if ( !isdefined( level.hornet_mq.var_2926000ad1ba5c3e ) )
    {
        level.hornet_mq.var_2926000ad1ba5c3e = [];
    }
    
    if ( arraycontains( level.hornet_mq.var_2926000ad1ba5c3e, var_cbb9de3ce21516de[ 0 ] ) )
    {
        return;
    }
    
    while ( level utility::flag( "player_banter_playing" ) )
    {
        /#
            iprintlnbold( "<dev string:x2eb>" );
        #/
        
        wait 0.1;
    }
    
    level.hornet_mq.var_2926000ad1ba5c3e[ level.hornet_mq.var_2926000ad1ba5c3e.size ] = var_cbb9de3ce21516de[ 0 ];
    level utility::flag_set( "hornet_mq_vo_playing" );
    level zm_quest::function_d5ef98341fd6a057( var_cbb9de3ce21516de, a_players, n_delay_before, var_3226ffc41619dbe2 );
    level utility::flag_clear( "hornet_mq_vo_playing" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 3, eflags: 0x4
// Checksum 0xa3500390, Offset: 0x322a7
// Size: 0x142
function private function_2a6deff157d1165a( banter_event, var_41ede7102b609a29 = undefined, start_delay_sec = undefined )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( banter_event ) )
    {
        if ( isdefined( var_41ede7102b609a29 ) )
        {
            level thread battlechatter_mp::trysaylocalsound( self, var_41ede7102b609a29 );
        }
        
        return;
    }
    
    if ( !isdefined( level.hornet_mq.played_banter ) )
    {
        level.hornet_mq.played_banter = [];
    }
    
    if ( arraycontains( level.hornet_mq.played_banter, banter_event ) )
    {
        return;
    }
    
    level.hornet_mq.played_banter[ level.hornet_mq.played_banter.size ] = banter_event;
    
    if ( isdefined( start_delay_sec ) )
    {
        wait start_delay_sec;
    }
    
    if ( namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        while ( player_banter::function_4e1aff6241ebea8() )
        {
            wait 0.1;
        }
        
        if ( !player_banter::function_4e1aff6241ebea8() )
        {
            level utility::flag_set( "hornet_mq_vo_playing" );
            player_banter::play_banter_vo( banter_event, [ self ], undefined, 1 );
            level utility::flag_clear( "hornet_mq_vo_playing" );
        }
        
        return;
    }
    
    if ( isdefined( var_41ede7102b609a29 ) )
    {
        level thread battlechatter_mp::trysaylocalsound( self, var_41ede7102b609a29 );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1, eflags: 0x4
// Checksum 0x8a1b3c0b, Offset: 0x323f1
// Size: 0x66
function private on_player_connect( params )
{
    if ( !callback::exists( #"hash_875577910e58057b", &function_9a51e1d676692551 ) )
    {
        callback::add( #"hash_875577910e58057b", &function_9a51e1d676692551 );
    }
    
    if ( !callback::exists( #"hash_4228c0dfe35c7523", &function_1d64dbbbdf132d0c ) )
    {
        callback::add( #"hash_4228c0dfe35c7523", &function_1d64dbbbdf132d0c );
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 0
// Checksum 0x209f8d87, Offset: 0x3245f
// Size: 0x24d
function setup_audio_evidence()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "initial_player_connected" );
    gathered_evidence = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_5674ab884e5e790a" ) ?? 0;
    vignette_data = zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_36715aa8ae539973" ) ?? 0;
    var_2810fccb0e23ac8d = [ 21, 26, 23, 22, 24, 25 ];
    var_d76340204a92cc7c = [ "zmintel_sat_hornet_audiolog_1", "zmintel_sat_hornet_audiolog_12", "zmintel_sat_hornet_audiolog_3", "zmintel_sat_hornet_audiolog_2", "zmintel_sat_hornet_audiolog_4", "zmintel_sat_hornet_audiolog_5" ];
    
    for ( i = 0; i < var_d76340204a92cc7c.size ; i++ )
    {
        if ( utility::get_bit_flag( gathered_evidence, var_2810fccb0e23ac8d[ i ] ) )
        {
            spawn_loc = utility::getstruct( var_d76340204a92cc7c[ i ], "targetname" );
            level function_20fe0186d4bb0dbc( var_d76340204a92cc7c[ i ], spawn_loc.origin, spawn_loc.angles, 1 );
            continue;
        }
        
        st_intel_name = undefined;
        
        if ( i == 0 && utility::get_bit_flag( vignette_data, 0 ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_1";
        }
        else if ( i == 1 && utility::get_bit_flag( vignette_data, 1 ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_12";
        }
        else if ( i == 2 && utility::get_bit_flag( vignette_data, 2 ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_3";
        }
        else if ( i == 3 && utility::get_bit_flag( vignette_data, 3 ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_2";
        }
        else if ( i == 4 && utility::get_bit_flag( vignette_data, 4 ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_4";
        }
        else if ( i == 5 && level utility::flag( "mq_step_30_complete" ) )
        {
            st_intel_name = "zmintel_sat_hornet_audiolog_5";
        }
        
        if ( st_intel_name )
        {
            spawn_loc = utility::getstruct( "spawn_" + st_intel_name, "targetname" );
            level function_20fe0186d4bb0dbc( st_intel_name, spawn_loc.origin, spawn_loc.angles );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 4
// Checksum 0x66ee6220, Offset: 0x326b4
// Size: 0xb8
function function_20fe0186d4bb0dbc( st_intel_name, loc, angles, var_6f153a5a439cc992 = 0 )
{
    s_intel = intel::spawn_intel_at_location( undefined, undefined, loc, angles, st_intel_name, undefined, 1 );
    
    if ( var_6f153a5a439cc992 && isdefined( s_intel ) && isdefined( s_intel.mdl_intel ) )
    {
        s_intel.mdl_intel.var_b6cb9607222e92b = 1;
        s_intel.mdl_intel.var_7de3fbd79094ebcd = 1;
    }
    
    if ( !s_intel )
    {
        return;
    }
    
    s_intel.mdl_intel utility::function_7c10ea82c1e305b8( "audio", "mq_on_world" );
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x7906c334, Offset: 0x32774
// Size: 0x4e0
function function_1d64dbbbdf132d0c( params )
{
    str_intel_name = params.str_intel_name;
    mdl_intel = params.mdl_intel;
    var_4a8a2b8ed8dae4b8 = 0;
    
    foreach ( var_73841c4bbbfb0f5e in [ "zmintel_sat_hornet_audiolog_1", "zmintel_sat_hornet_audiolog_12", "zmintel_sat_hornet_audiolog_3", "zmintel_sat_hornet_audiolog_2", "zmintel_sat_hornet_audiolog_4", "zmintel_sat_hornet_audiolog_5" ] )
    {
        if ( var_73841c4bbbfb0f5e == str_intel_name )
        {
            var_4a8a2b8ed8dae4b8 = 1;
            break;
        }
    }
    
    if ( !var_4a8a2b8ed8dae4b8 )
    {
        return;
    }
    
    if ( !mdl_intel.var_b6cb9607222e92b && !mdl_intel.var_7de3fbd79094ebcd )
    {
        switch ( str_intel_name )
        {
            case #"hash_de7aaf3512439ed":
            case #"zmintel_sat_hornet_audiolog_1":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_1";
                var_6dbc3b82b31ab9 = 21;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_1";
                break;
            case #"hash_de7a7f351243534":
            case #"zmintel_sat_hornet_audiolog_2":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_2";
                var_6dbc3b82b31ab9 = 22;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_2";
                break;
            case #"hash_de7a8f3512436c7":
            case #"zmintel_sat_hornet_audiolog_3":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_3";
                var_6dbc3b82b31ab9 = 23;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_3";
                break;
            case #"hash_de7a5f35124320e":
            case #"zmintel_sat_hornet_audiolog_4":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_4";
                var_6dbc3b82b31ab9 = 24;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_4";
                break;
            case #"hash_de7a6f3512433a1":
            case #"zmintel_sat_hornet_audiolog_5":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_5";
                var_6dbc3b82b31ab9 = 25;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_5";
                break;
            case #"hash_7ebfc08bc071a0d":
            case #"zmintel_sat_hornet_audiolog_12":
                var_dc6a4b4b351da087 = "zmintel_sat_hornet_audiolog_12";
                var_6dbc3b82b31ab9 = 26;
                var_ec3dae4f6f575a27 = "zmintel_sat_hornet_audiolog_12";
                break;
            default:
                return;
        }
        
        if ( function_ae6e6f69b0e2302( var_ec3dae4f6f575a27 ) )
        {
            return;
        }
        
        level utility::flag_set( "moved_to_shelf_" + var_ec3dae4f6f575a27 );
        mdl_intel utility::function_7c10ea82c1e305b8( "audio", "mq_collect" );
        level function_fd1996af0db6a8ca( var_6dbc3b82b31ab9 );
        spawn_loc = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
        new_s_intel = intel::spawn_intel_at_location( undefined, undefined, spawn_loc.origin, spawn_loc.angles, str_intel_name, undefined, 1 );
        new_mdl_intel = new_s_intel.mdl_intel;
        new_mdl_intel utility::function_7c10ea82c1e305b8( "audio", "mq_on_shelf" );
        new_mdl_intel.var_b6cb9607222e92b = 1;
        
        if ( self )
        {
            self.var_a42fba1b72dd02a6 = 1;
        }
        
        mdl_intel function_7653c765b6c7b815();
        
        foreach ( other_player in level.players )
        {
            mdl_intel function_d6a7b7ef13a57f38( other_player );
        }
        
        mdl_intel.var_7de3fbd79094ebcd = 1;
        
        foreach ( other_player in level.players )
        {
            if ( other_player != self && !other_player intel::player_has_intel( str_intel_name ) )
            {
                other_player utility::callsharedfunc( #"intel", #"collect_intel", str_intel_name, mdl_intel, undefined, 1 );
            }
        }
    }
    
    foreach ( other_s_intel in level.var_d269a296de42db6b )
    {
        if ( isdefined( other_s_intel ) && isdefined( other_s_intel.mdl_intel ) && other_s_intel.mdl_intel isscriptableinstance() )
        {
            other_s_intel.mdl_intel disablescriptableplayeruse( self );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x190d6ab1, Offset: 0x32c5c
// Size: 0x29, Type: bool
function function_ae6e6f69b0e2302( str_intel_name )
{
    if ( isdefined( str_intel_name ) && level utility::flag( "moved_to_shelf_" + str_intel_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x4c877c1b, Offset: 0x32c8e
// Size: 0xf2
function function_9a51e1d676692551( params )
{
    mdl_intel = params.mdl_intel;
    
    if ( self )
    {
        self.var_a42fba1b72dd02a6 = 0;
    }
    
    if ( mdl_intel && !mdl_intel.var_b6cb9607222e92b )
    {
        level.var_bb461868542d6ed3 = arrayremove( level.var_bb461868542d6ed3, mdl_intel );
        mdl_intel freescriptable();
    }
    
    foreach ( var_368174aee74a60c3 in level.var_d269a296de42db6b )
    {
        if ( var_368174aee74a60c3.mdl_intel )
        {
            var_368174aee74a60c3.mdl_intel enablescriptableplayeruse( self );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x13da82f5, Offset: 0x32d88
// Size: 0x169
function function_9949dfbd9b5f96be( b_canuse )
{
    if ( self.var_a42fba1b72dd02a6 )
    {
        return;
    }
    
    if ( b_canuse )
    {
        foreach ( s_intel in level.var_d269a296de42db6b )
        {
            if ( isdefined( s_intel ) && isdefined( s_intel.mdl_intel ) && s_intel.mdl_intel isscriptableinstance() )
            {
                s_intel.mdl_intel enablescriptableplayeruse( self );
            }
        }
        
        return;
    }
    
    foreach ( s_intel in level.var_d269a296de42db6b )
    {
        if ( isdefined( s_intel ) && isdefined( s_intel.mdl_intel ) && s_intel.mdl_intel isscriptableinstance() )
        {
            s_intel.mdl_intel disablescriptableplayeruse( self );
        }
    }
}

// Namespace zm_sat_hornet_mq_quest
// Params 1
// Checksum 0x9d6f0aee, Offset: 0x32ef9
// Size: 0x12a
function function_a4f35c61acb88b1( params )
{
    wwq = zm_quest::get_quest( #"hornet_ww_quest" );
    level thread zm_quest::start_quest( #"hornet_ww_quest" );
    
    foreach ( step in wwq.steps )
    {
        zm_quest::function_e65609834444650c( step );
    }
    
    wait 1;
    level utility::flag_set( "locate_nekomata" );
    level utility::flag_set( "capture_nekomata" );
    level utility::flag_set( "feed_nekomata" );
    level utility::flag_set( "save_nekomata" );
    level utility::flag_set( "nekomata_acquired" );
    level utility::flag_set( "wwq_complete" );
    level utility::flag_set( "completed_ww_step_6" );
    wait 1;
    level.players[ 0 ] stopgestureviewmodel();
    level function_ecc91637c2a6fbb1();
}

/#

    // Namespace zm_sat_hornet_mq_quest
    // Params 0
    // Checksum 0xe6abe85d, Offset: 0x3302b
    // Size: 0x4bc, Type: dev
    function init_mq_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x301>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x314>", "<dev string:x323>", &function_e48e8cc4696d4b95, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32c>", "<dev string:x33f>", &function_ce6805a624abf763, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x348>", "<dev string:x359>", &function_9e4f9fa3035db1fc, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x36a>", "<dev string:x37e>", &function_89d828184c72f712, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x396>", "<dev string:x3af>", &function_ecb6a2ea36c26354, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3b9>", "<dev string:x3cd>", &function_63b3e70a7f6d0566, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d7>", "<dev string:x3eb>", &function_59a6bcdb9fc7e5f, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3f5>", "<dev string:x408>", &function_4bf2bb23653d54b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x412>", "<dev string:x425>", &function_e8d7a914b07dbfd, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x434>", "<dev string:x447>", &function_753d3a3ce84e41e3, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x456>", "<dev string:x466>", &function_1fc9b77a419d2413, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x475>", "<dev string:x48a>", &function_f8cef622f48f4de4, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x494>", "<dev string:x4a3>", &function_51475c50979b28f5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4b3>", "<dev string:x4c7>", &function_d68e5397ec99f4a3, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d3>", "<dev string:x4ef>", &function_f65b064814ef704e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x501>", "<dev string:x512>", &function_ac3c2c5bc9a68bed, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51c>", "<dev string:x530>", &function_9f459364e9a26875, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x53a>", "<dev string:x54d>", &function_1e8a3c8e6a0e8f5a, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x557>", "<dev string:x57a>", &function_d293aef71d5fe10c, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x585>", "<dev string:x59f>", &function_5d37b9cb9ff65093, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5ac>", "<dev string:x5c6>", &function_57f05aca33c3a6d6, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5d3>", "<dev string:x5eb>", &function_4d8544c090eb5915, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f6>", "<dev string:x608>", &debug_do_jitter, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x613>", "<dev string:x625>", &debug_setup_weed, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x630>", "<dev string:x645>", &function_50fcc373ba8eca1f, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x652>", "<dev string:x669>", &function_c9cf936bf4b4a656, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x674>", "<dev string:x68e>", &function_55245f759a99070d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x699>", "<dev string:x6b3>", &function_f33aaaa94505237f, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6be>", "<dev string:x6d9>", &function_6776ba2004cd4d28, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6e4>", "<dev string:x6f8>", &function_e79c4f932d535482, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x705>", "<dev string:x71d>", &function_5b6b30690a6fe386, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x728>", "<dev string:x73b>", &function_63a614de978847b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x747>", "<dev string:x765>", &function_2178d7296094d32d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x770>", "<dev string:x78c>", &function_20e66ab2cf2bb09f, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x797>", "<dev string:x7be>", &function_19176a8a919728ce, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7cb>", "<dev string:x7f3>", &function_413a9c1c74bd7a4d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x800>", "<dev string:x824>", &function_1b9e689d705e01c4, 1 );
        devgui::add_devgui_func( "<dev string:x831>", "<dev string:x85a>", &function_e5496628b5182fee );
        devgui::add_devgui_func( "<dev string:x875>", "<dev string:x891>", &function_e4d4fabba821119d );
        devgui::add_devgui_func( "<dev string:x8b3>", "<dev string:x8d4>", &function_b21b746ba86e763, 1 );
        devgui::add_devgui_func( "<dev string:x8df>", "<dev string:x90d>", &function_30f698cf0144933c, 1 );
        devgui::add_devgui_func( "<dev string:x91a>", "<dev string:x932>", &function_58178d8f8f592450, 1 );
        devgui::add_devgui_func( "<dev string:x93f>", "<dev string:x950>", &function_ec0a86a9669640e1, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x95d>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x979>", "<dev string:x98d>", &function_d28228937582bb68, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9a2>", "<dev string:x9b5>", &function_17d0b6e77abdec22, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9c9>", "<dev string:x9e2>", &function_16becf330e00e39f, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9f5>", "<dev string:xa0f>", &function_1fd7183258ea801e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa22>", "<dev string:xa3b>", &function_ce5e2232d901c33c, 1 );
        devgui::function_77df7fe7dd273e10();
        level.hornet_mq.debug = {};
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x52d5add8, Offset: 0x334ef
    // Size: 0x179, Type: dev
    function function_e48e8cc4696d4b95( params )
    {
        wwq = zm_quest::get_quest( #"hornet_ww_quest" );
        level thread zm_quest::start_quest( #"hornet_ww_quest" );
        
        foreach ( step in wwq.steps )
        {
            zm_quest::function_e65609834444650c( step );
        }
        
        level utility::flag_set( "<dev string:xa4e>" );
        level utility::flag_set( "<dev string:xa5b>" );
        level utility::flag_set( "<dev string:xa6b>" );
        level utility::flag_set( "<dev string:xa7c>" );
        level utility::flag_set( "<dev string:xa8a>" );
        level utility::flag_set( "<dev string:xa98>" );
        level utility::flag_set( "<dev string:xaaa>" );
        wait 1;
        level function_ecc91637c2a6fbb1();
        weapon_name = weapon::getweaponrootname( "<dev string:xabe>" );
        weapon = weapon::buildweapon( weapon_name );
        level.players[ 0 ] giveweapon( weapon );
        level.players[ 0 ] switchtoweapon( weapon );
        weapon::fixupplayerweapons( level.players[ 0 ], weapon_name );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x67460058, Offset: 0x33670
    // Size: 0xa6, Type: dev
    function function_ce6805a624abf763( params )
    {
        foreach ( evidence in level.hornet_mq.evidence_shelf.evidence_structs )
        {
            level function_2449528487ed5cc8( evidence.script_noteworthy );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xcd5484bd, Offset: 0x3371e
    // Size: 0x96, Type: dev
    function function_9e4f9fa3035db1fc( params )
    {
        if ( isdefined( level.hornet_mq.debug.var_f42b5c8ef2812f10 ) )
        {
            return;
        }
        
        level.hornet_mq.debug.var_f42b5c8ef2812f10 = 1;
        level utility::flag_set( "<dev string:xacf>" );
        trig = getent( "<dev string:xae3>", #targetname );
        trig thread function_956dafb7506d8f27();
        trig thread function_a039811cedecf4b2();
        level setup_solve_logic();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xdbef731e, Offset: 0x337bc
    // Size: 0x1c, Type: dev
    function function_89d828184c72f712( params )
    {
        level thread play_memory( "<dev string:xaf1>" );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x39fb0be0, Offset: 0x337e0
    // Size: 0x17, Type: dev
    function function_ecb6a2ea36c26354( params )
    {
        level function_c04278a79d481af4();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x4fed1c7e, Offset: 0x337ff
    // Size: 0xa9, Type: dev
    function function_63b3e70a7f6d0566( params )
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:xafc>" ] ) )
        {
            loc = {};
            loc.origin = result[ "<dev string:xafc>" ];
            mask_type = randomintrange( 0, 5 );
            function_bffc448792f681e2( mask_type, loc, 1 );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xfedea6e0, Offset: 0x338b0
    // Size: 0xc5, Type: dev
    function function_59a6bcdb9fc7e5f( params )
    {
        setup_lantern_clock();
        
        if ( !level.generated_sequence )
        {
            level.generated_sequence = 1;
            level function_d40215239bfba47c();
        }
        
        setup_banner_locs();
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:xafc>" ] ) )
        {
            loc = {};
            loc.origin = result[ "<dev string:xafc>" ];
            function_452095b2748c51a3( 1, loc );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x70457066, Offset: 0x3397d
    // Size: 0x17, Type: dev
    function function_4bf2bb23653d54b( params )
    {
        level thread function_9b32453437b6c5cf();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 0
    // Checksum 0xec1a6d5a, Offset: 0x3399c
    // Size: 0x2f, Type: dev
    function function_9aacae45111ed4ba()
    {
        while ( isdefined( self ) )
        {
            /#
                debugstar( self.origin, ( 1, 1, 1 ), 1000 );
            #/
            
            waitframe();
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x7045706d, Offset: 0x339d3
    // Size: 0x17, Type: dev
    function function_e8d7a914b07dbfd( params )
    {
        level function_b2488a168322aad1();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x642df50c, Offset: 0x339f2
    // Size: 0xc2, Type: dev
    function function_753d3a3ce84e41e3( params )
    {
        level.hornet_mq.dropped_fruit = spawnscriptable( %"zm_sat_hornet_mq_acc_m_food", level.players[ 0 ].origin, ( 0, 0, 0 ) );
        
        if ( !level.hornet_mq.merchant_trig )
        {
            [ level.hornet_mq.merchant_trig ] = getnoentvolumearray( "<dev string:xb05>", #targetname );
        }
        
        spawn_struct = utility::getstruct( "<dev string:xb16>", "<dev string:xb29>" );
        level thread function_abb9d7c076fba681( spawn_struct );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xa5bfcc34, Offset: 0x33abc
    // Size: 0x17, Type: dev
    function function_1fc9b77a419d2413( params )
    {
        level thread function_97c525b5f90bd575();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xb77781c1, Offset: 0x33adb
    // Size: 0x3ac, Type: dev
    function function_f8cef622f48f4de4( params )
    {
        level thread function_9464d5c9aeb62f6e();
        return;
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xfef6adca, Offset: 0x33e8f
    // Size: 0xf, Type: dev
    function function_51475c50979b28f5( params )
    {
        
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x434fe472, Offset: 0x33ea6
    // Size: 0x10e, Type: dev
    function function_d68e5397ec99f4a3( params )
    {
        debris = getent( "<dev string:xb46>", #targetname );
        
        if ( isdefined( debris ) )
        {
            debris delete();
        }
        
        wait 1;
        level setup_lantern_clock();
        
        if ( !isdefined( level.hornet_mq.clock.hand ) )
        {
            level.hornet_mq.clock.hand = utility::spawn_model( %"sat_zm_lantern_clock_hand", level.hornet_mq.clock.hand_loc.origin, level.hornet_mq.clock.hand_loc.angles, 0, 0.3 );
            waitframe();
        }
        
        level function_daab3ab588c846e7( level.hornet_mq.clock.sequence );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x835c69f6, Offset: 0x33fbc
    // Size: 0x4f, Type: dev
    function function_f65b064814ef704e( params )
    {
        level setup_lantern_clock();
        level function_d40215239bfba47c();
        level function_daab3ab588c846e7( level.hornet_mq.clock.sequence );
        wait 1;
        level open_clock();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xa7cefb14, Offset: 0x34013
    // Size: 0xe2, Type: dev
    function function_ac3c2c5bc9a68bed( params )
    {
        level setup_lantern_clock();
        level function_d40215239bfba47c();
        level function_daab3ab588c846e7( level.hornet_mq.clock.sequence );
        wait 1;
        level setup_banner_locs();
        
        for ( i = 0; i < level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7.size ; i++ )
        {
            value = level.hornet_mq.clock.curr_banners[ i ];
            level.hornet_mq.banner_puzzle.var_746c0f5976b6c4b7[ i ].sbl place_banner( value );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x94d02b66, Offset: 0x340fd
    // Size: 0x110, Type: dev
    function function_9f459364e9a26875( params )
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:xafc>" ] ) )
        {
            loc = {};
            loc.origin = result[ "<dev string:xafc>" ];
            note_ref = "<dev string:xb53>" + level.hornet_mq.doc_data.var_f4603954af61874;
            param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
            param = string( param );
            level spawn_page( note_ref, param, loc.origin, ( 0, 0, 0 ), 1 );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xd32e0c2, Offset: 0x34215
    // Size: 0xca, Type: dev
    function function_1e8a3c8e6a0e8f5a( params )
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        projectile_weapon = level.equipment.table[ "<dev string:xb63>" ].weaponname;
        projectile = player namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( projectile_weapon, player.origin, var_3530c91bc79c1c9e, undefined, 0 );
        
        if ( isdefined( projectile ) )
        {
            projectile setentityowner( player );
            projectile.weapon_name = projectile_weapon;
            projectile.owner = player;
            projectile.team = player.team;
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x9bbd878d, Offset: 0x342e7
    // Size: 0x95, Type: dev
    function function_d293aef71d5fe10c( params )
    {
        if ( !isdefined( level.hornet_mq.var_eb18039ec2782af8 ) )
        {
            level.hornet_mq.var_eb18039ec2782af8 = 0;
        }
        
        level.hornet_mq.var_eb18039ec2782af8 = !level.hornet_mq.var_eb18039ec2782af8;
        
        if ( level.hornet_mq.var_eb18039ec2782af8 )
        {
            /#
                iprintlnbold( "<dev string:xb6e>" );
            #/
            
            return;
        }
        
        /#
            iprintlnbold( "<dev string:xb88>" );
        #/
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1, eflags: 0x4
    // Checksum 0xc02b6b9f, Offset: 0x34384
    // Size: 0x59, Type: dev
    function private function_d744a2c3aa49c60c( pos )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            line( level.players[ 0 ].origin, pos, ( 1, 1, 1 ), 1, 0, level.frameduration );
            waitframe();
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1, eflags: 0x4
    // Checksum 0x9cdf12c, Offset: 0x343e5
    // Size: 0x1b, Type: dev
    function private function_5d37b9cb9ff65093( params )
    {
        level notify( #"hash_728df321137ade0f" );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1, eflags: 0x4
    // Checksum 0xc8ebe9cc, Offset: 0x34408
    // Size: 0x23b, Type: dev
    function private function_57f05aca33c3a6d6( params )
    {
        if ( !isdefined( level.hornet_mq.var_e999ce7dfe305da ) )
        {
            level.hornet_mq.var_e999ce7dfe305da = 0;
        }
        
        if ( !level.hornet_mq.var_9375c03d9d90e6ac )
        {
            level.hornet_mq.var_9375c03d9d90e6ac = [];
            path_starts = utility::getstructarray( "<dev string:xbaa>", "<dev string:xb29>" );
            
            foreach ( path_start in path_starts )
            {
                path = function_1215034504e1e891( path_start );
                level.hornet_mq.var_9375c03d9d90e6ac[ level.hornet_mq.var_9375c03d9d90e6ac.size ] = path;
            }
        }
        
        level.hornet_mq.var_9375c03d9d90e6ac = arrayrandomize( level.hornet_mq.var_9375c03d9d90e6ac );
        
        for ( i = 0; i < level.hornet_mq.var_9375c03d9d90e6ac.size ; i++ )
        {
            if ( !level.players[ i ] )
            {
                return;
            }
            
            var_3b45147e7f19934e = { #path_time_override:12 * randomfloatrange( 0.9, 1.1 ), #b_skip_common_path:1 };
            level.players[ i ] thread function_28dcbe0ba25cf08( level.hornet_mq.var_9375c03d9d90e6ac[ i ], var_3b45147e7f19934e );
        }
        
        level.hornet_mq.var_e999ce7dfe305da++;
        
        if ( level.hornet_mq.var_e999ce7dfe305da > level.hornet_mq.var_9375c03d9d90e6ac.size )
        {
            level.hornet_mq.var_9375c03d9d90e6ac = 0;
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x2cb99de3, Offset: 0x3464b
    // Size: 0xbd, Type: dev
    function function_4d8544c090eb5915( params )
    {
        if ( level.hornet_mq.fmask_zom )
        {
            level.hornet_mq.fmask_zom kill();
        }
        
        if ( level.hornet_mq.onryo )
        {
            if ( level.hornet_mq.onryo callback::exists( "<dev string:xbc6>", &function_1ba9a9bc5c85bd1b ) )
            {
                level.hornet_mq.onryo callback::remove( "<dev string:xbc6>", &function_1ba9a9bc5c85bd1b );
            }
            
            level.hornet_mq.onryo kill();
        }
        
        level function_e8f4ecd2397bc342();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x6485cd21, Offset: 0x34710
    // Size: 0x47b, Type: dev
    function debug_do_jitter( params )
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:xafc>" ] ) )
        {
            level.hornet_mq.var_71ac555879808712 = {};
            level.hornet_mq.var_71ac555879808712.item_ref = %"hash_6d90e79d6ed53dc0";
            spawner = { #angles:( 0, 0, 0 ), #origin:result[ "<dev string:xafc>" ] };
            var_81780e0ae227b9cf = spawnscriptable( "<dev string:xbda>", spawner.origin + ( 0, 0, 48 ), spawner.angles );
            var_81780e0ae227b9cf utility::function_7c10ea82c1e305b8( "<dev string:xbfc>", "<dev string:xc05>" );
            wait 1.5;
            level.hornet_mq.var_71ac555879808712.item = level mq_spawn_item( level.hornet_mq.var_71ac555879808712.item_ref, spawner.origin, spawner.angles );
            level.hornet_mq.var_71ac555879808712.item function_7653c765b6c7b815();
            level.hornet_mq.var_71ac555879808712.item notify( #"stop_bobbing" );
            mover = utility::spawn_model( "<dev string:xc10>", level.hornet_mq.var_71ac555879808712.item.origin, level.hornet_mq.var_71ac555879808712.item.angles );
            waitframe();
            level.hornet_mq.var_71ac555879808712.item utility::scriptable_setparententity( mover );
            
            for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "<dev string:xc1b>" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "<dev string:xc1b>" ] ) )
            {
                waitframe();
            }
            
            level.hornet_mq.chase_hellhound = function_89266a24d0006d65( "<dev string:xc22>", spawner );
            var_81780e0ae227b9cf freescriptable();
            mouth_offset_x = getdvarfloat( @"hash_a32ba081ab85fbb6", 12 );
            mouth_offset_y = getdvarfloat( @"hash_a32ba181ab85fde9", -3 );
            mouth_offset_z = getdvarfloat( @"hash_a32b9e81ab85f750", -3.5 );
            mouth_angles_x = 0;
            mouth_angles_y = 90;
            mouth_angles_z = 0;
            
            if ( level.hornet_mq.var_71ac555879808712.item_ref == %"hash_1e3143f8a7c1e6c8" )
            {
                mouth_angles_x = 90;
                mouth_angles_y = 0;
            }
            
            mover linkto( level.hornet_mq.chase_hellhound, "<dev string:xc4c>", ( mouth_offset_x, mouth_offset_y, mouth_offset_z ), ( mouth_angles_x, mouth_angles_y, mouth_angles_z ) );
            level.hornet_mq.chase_hellhound function_afbc854c30f3e5fe( "<dev string:xc53>" );
            
            if ( isdefined( level.hornet_mq.chase_hellhound ) )
            {
                level.hornet_mq.chase_hellhound zombie_utils::function_a8ce00e0448cb6f0( "<dev string:xc5f>", "<dev string:xc66>", 6 );
            }
            
            level.hornet_mq.chase_hellhound callback::add( "<dev string:xbc6>", &function_1bec6259b57d386d );
            return;
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xf54b029b, Offset: 0x34b93
    // Size: 0xd5, Type: dev
    function debug_setup_weed( params )
    {
        weed_locs = utility::getstructarray( "<dev string:xc76>", "<dev string:xb29>" );
        weed_structs = [];
        
        foreach ( loc in weed_locs )
        {
            weed_struct = setup_weed_struct( loc.origin );
            weed_structs[ weed_structs.size ] = weed_struct;
        }
        
        level.hornet_mq.weed_structs = weed_structs;
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x18ac6990, Offset: 0x34c70
    // Size: 0x95, Type: dev
    function function_50fcc373ba8eca1f( params )
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:xafc>" ] ) )
        {
            sbl = spawnscriptable( "<dev string:xc86>", result[ "<dev string:xafc>" ], ( 0, 0, 0 ) );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x92c8e235, Offset: 0x34d0d
    // Size: 0x17, Type: dev
    function function_c9cf936bf4b4a656( params )
    {
        level function_eebef3bed7218046();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xb0d7ccf9, Offset: 0x34d2c
    // Size: 0x3f, Type: dev
    function function_55245f759a99070d( params )
    {
        level utility::flag_set( "<dev string:xca6>" );
        level function_fd1996af0db6a8ca( 4 );
        level function_9947038abd0d1056( #"hat" );
        level function_ecc91637c2a6fbb1();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xe0ac7828, Offset: 0x34d73
    // Size: 0x67, Type: dev
    function function_f33aaaa94505237f( params )
    {
        level utility::flag_set( "<dev string:xca6>" );
        level function_fd1996af0db6a8ca( 4 );
        level function_9947038abd0d1056( #"hat" );
        level utility::flag_set( "<dev string:xcbd>" );
        level function_fd1996af0db6a8ca( 3 );
        level function_9947038abd0d1056( #"shrs" );
        level function_ecc91637c2a6fbb1();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xcc2261, Offset: 0x34de2
    // Size: 0x2a, Type: dev
    function function_6776ba2004cd4d28( params )
    {
        level zm_quest::update_guidance( undefined, #"hornet_mq_guidance", #"hash_fe3f7154d4275859" );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x55babbe8, Offset: 0x34e14
    // Size: 0x26c, Type: dev
    function function_e79c4f932d535482( params )
    {
        var_7ced37341c55f339 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_64236e264a7d47fb" );
        
        if ( !isdefined( var_7ced37341c55f339 ) )
        {
            var_7ced37341c55f339 = 0;
        }
        
        var_cf445190aa96d78d = [ 0, 12, 17, 19, 21 ];
        var_87b2d1dc0cfdaa71 = [ [ 1, 2, 3 ], [ 13, 14, 15 ], undefined, undefined, undefined ];
        
        for ( i = 0; i < var_cf445190aa96d78d.size ; i++ )
        {
            var_dcc391fe6316139d = var_cf445190aa96d78d[ i ];
            var_870e4c540e3c5fec = var_87b2d1dc0cfdaa71[ i ];
            
            if ( isdefined( var_7ced37341c55f339 ) && !utility::get_bit_flag( var_7ced37341c55f339, var_dcc391fe6316139d ) )
            {
                switch ( var_dcc391fe6316139d )
                {
                    case 0:
                        note_ref = "<dev string:xb53>" + level.hornet_mq.doc_data.var_f4603954af61874;
                        param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
                        param = string( param );
                        break;
                    case 12:
                        note_ref = "<dev string:xcd4>";
                        param = level.hornet_mq.doc_data.var_80e2d83e1c46eea0;
                        param = string( param );
                        break;
                    case 17:
                        note_ref = "<dev string:xce4>" + "<dev string:xcf5>";
                        param = undefined;
                        break;
                    case 21:
                        note_ref = "<dev string:xce4>" + "<dev string:xcf8>";
                        param = undefined;
                        break;
                    case 19:
                        note_ref = "<dev string:xce4>" + "<dev string:xcfb>";
                        param = undefined;
                        break;
                }
                
                dest = function_5f89cd24480ebd1b( note_ref );
                note = level spawn_page( note_ref, param, dest.origin, dest.angles, 0 );
            }
        }
        
        level.hornet_mq.var_b13513a678ed761 = undefined;
        level utility::flag_set( "<dev string:xcfe>" );
        level function_ecc91637c2a6fbb1();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x9b00057a, Offset: 0x35088
    // Size: 0x104, Type: dev
    function function_5b6b30690a6fe386( params )
    {
        if ( level.players[ 0 ].var_90333b71551aeac0 )
        {
            return;
        }
        
        if ( !isdefined( level.hornet_mq.debug.fmask_state ) )
        {
            level.hornet_mq.debug.fmask_state = 0;
        }
        
        level.hornet_mq.debug.fmask_state = !level.hornet_mq.debug.fmask_state;
        
        if ( level.hornet_mq.debug.fmask_state )
        {
            /#
                iprintlnbold( "<dev string:xd22>" );
            #/
            
            level.players[ 0 ] equipfoxmask();
            return;
        }
        
        /#
            iprintlnbold( "<dev string:xd2f>" );
        #/
        
        level.players[ 0 ] removefoxmask();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xb92bd020, Offset: 0x35194
    // Size: 0x34, Type: dev
    function function_63a614de978847b( params )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_3d9d9fccab5e9285" );
        wait 5;
        level thread function_9e0ebd27e583048();
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xc32dd58e, Offset: 0x351d0
    // Size: 0x60, Type: dev
    function function_2178d7296094d32d( params )
    {
        var_51bc0779ee40d7a7 = utility::getstruct( "<dev string:xd3c>", "<dev string:xd67>" );
        var_51bc0779ee40d7a7 zm_livingworld::livingworld_spawn_encounter();
        zombie = var_51bc0779ee40d7a7.scene_ents[ "<dev string:xd79>" ][ 0 ];
        
        if ( zombie )
        {
            zombie thread function_722fa62e943f9d10( undefined );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x70457043, Offset: 0x35238
    // Size: 0x19, Type: dev
    function function_19176a8a919728ce( params )
    {
        level function_90c72c6cab29cb72( 1 );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xb1cd3224, Offset: 0x35259
    // Size: 0x15d, Type: dev
    function function_413a9c1c74bd7a4d( params )
    {
        if ( !isdefined( level.hornet_mq.debug.var_8475f7c6fe4bd13e ) )
        {
            level.hornet_mq.debug.var_8475f7c6fe4bd13e = -1;
        }
        
        level.hornet_mq.debug.var_8475f7c6fe4bd13e += 1;
        
        if ( level.hornet_mq.debug.var_8475f7c6fe4bd13e > 3 )
        {
            level.hornet_mq.debug.var_8475f7c6fe4bd13e = 0;
        }
        
        vignette_locs = utility::getstructarray( "<dev string:xd80>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( vignette_locs[ level.hornet_mq.debug.var_8475f7c6fe4bd13e ].origin );
        level.players[ 0 ] setplayerangles( vignette_locs[ level.hornet_mq.debug.var_8475f7c6fe4bd13e ].angles );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x5b373a76, Offset: 0x353be
    // Size: 0x76, Type: dev
    function function_d28228937582bb68( params )
    {
        s_scenedef = utility::getstruct( "<dev string:xaf1>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( s_scenedef.origin );
        wait 1;
        trig = getent( "<dev string:xd94>", #targetname );
        level thread play_memory( "<dev string:xaf1>", 1, trig );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x7e3616e, Offset: 0x3543c
    // Size: 0x76, Type: dev
    function function_17d0b6e77abdec22( params )
    {
        s_scenedef = utility::getstruct( "<dev string:xda4>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( s_scenedef.origin );
        wait 1;
        trig = getent( "<dev string:xdb0>", #targetname );
        level thread play_memory( "<dev string:xda4>", 1, trig );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xc9b46c24, Offset: 0x354ba
    // Size: 0x76, Type: dev
    function function_16becf330e00e39f( params )
    {
        s_scenedef = utility::getstruct( "<dev string:xdbc>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( s_scenedef.origin );
        wait 1;
        trig = getent( "<dev string:xdc7>", #targetname );
        level thread play_memory( "<dev string:xdbc>", 1, trig );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x98300371, Offset: 0x35538
    // Size: 0x76, Type: dev
    function function_1fd7183258ea801e( params )
    {
        s_scenedef = utility::getstruct( "<dev string:xdd7>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( s_scenedef.origin );
        wait 1;
        trig = getent( "<dev string:xde2>", #targetname );
        level thread play_memory( "<dev string:xdd7>", 1, trig );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x6dd9b07b, Offset: 0x355b6
    // Size: 0x76, Type: dev
    function function_ce5e2232d901c33c( params )
    {
        s_scenedef = utility::getstruct( "<dev string:xdef>", "<dev string:xb29>" );
        level.players[ 0 ] setorigin( s_scenedef.origin );
        wait 1;
        trig = getent( "<dev string:xdfa>", #targetname );
        level thread play_memory( "<dev string:xdef>", 1, trig );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xdc370ae7, Offset: 0x35634
    // Size: 0x101, Type: dev
    function function_20e66ab2cf2bb09f( params )
    {
        var_a83fe95ced8fdb4 = utility::getstructarray( "<dev string:xe0a>", "<dev string:xb29>" );
        
        foreach ( ghost_struct in var_a83fe95ced8fdb4 )
        {
            ghost_struct.sbl utility::function_7c10ea82c1e305b8( "<dev string:xe17>", "<dev string:xe1d>" );
            ghost_struct.sbl utility::function_7c10ea82c1e305b8( "<dev string:xe2b>", "<dev string:xe2e>" );
            ghost_struct.sbl utility::function_7c10ea82c1e305b8( "<dev string:xe33>", "<dev string:xe39>" );
            ghost_struct.var_c91f26ce3738add1 = 1;
            ghost_struct.var_13da55243ecd1ae8 = 0;
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xf1a89010, Offset: 0x3573d
    // Size: 0xc4, Type: dev
    function function_1b9e689d705e01c4( params )
    {
        var_5f9d342e0a42e999 = [ "<dev string:xe45>", "<dev string:xe63>", "<dev string:xe81>", "<dev string:xe9f>", "<dev string:xebd>", "<dev string:xedb>" ];
        angle_mod = 360 / var_5f9d342e0a42e999.size;
        
        for ( i = 0; i < var_5f9d342e0a42e999.size ; i++ )
        {
            level function_20fe0186d4bb0dbc( var_5f9d342e0a42e999[ i ], level.players[ 0 ].origin + ( sin( i * angle_mod ) * 30, cos( i * angle_mod ) * 30, 30 ), ( 0, 0, 0 ) );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xabe3b6eb, Offset: 0x35809
    // Size: 0x87, Type: dev
    function function_e5496628b5182fee( params )
    {
        closest_zom = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xefa>" );
        
        if ( closest_zom )
        {
            if ( !isdefined( closest_zom.var_95d667429da2c1d2 ) )
            {
                closest_zom.var_95d667429da2c1d2 = 0;
            }
            
            closest_zom.var_95d667429da2c1d2 = !closest_zom.var_95d667429da2c1d2;
            closest_zom function_68f2f6fd8a4ffcae( 0, closest_zom.var_95d667429da2c1d2 );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0xd960e808, Offset: 0x35898
    // Size: 0x8f, Type: dev
    function function_e4d4fabba821119d( params )
    {
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( isdefined( origin ) )
        {
            origin = utility::groundpos( origin );
            scene_root = spawnstruct();
            scene_root.origin = origin;
            scene_root.angles = ( 0, 0, 0 );
            shot_name = "<dev string:xf06>" + randomintrange( 1, 3 );
            scene_root thread scene::play( undefined, shot_name, "<dev string:xf0c>" );
        }
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x64a2ca03, Offset: 0x3592f
    // Size: 0x21e, Type: dev
    function function_b21b746ba86e763( params )
    {
        records_struct = utility::getstruct( "<dev string:xf37>", "<dev string:xb29>" );
        animated_scroll = spawnscriptable( %"hash_235c1bedac3721e8", records_struct.origin, records_struct.angles );
        animated_scroll utility::function_7c10ea82c1e305b8( "<dev string:xf48>", "<dev string:xf4f>" );
        pestle_loc = utility::getstruct( "<dev string:xf54>", "<dev string:xb29>" );
        pestle = utility::spawn_model( %"sat_zm_pestle", pestle_loc.origin, pestle_loc.angles );
        pestle_end = utility::getstruct( "<dev string:xf63>", "<dev string:xb29>" );
        pestle moveto( pestle_end.origin, 3.2, 0.2, 1 );
        pestle rotatepitch( -720, 3.2, 0.2, 1 );
        wait 2.2;
        pestle rotateto( pestle_end.angles, 1, 0, 1 );
        pestle waittill( #"movedone" );
        animated_scroll freescriptable();
        note_ref = "<dev string:xb53>" + level.hornet_mq.doc_data.var_f4603954af61874;
        param = level.hornet_mq.doc_data.var_3caa7b068d2f476b - 21;
        param = string( param );
        level.hornet_mq.var_870342c57e88eff7.records_struct = level spawn_page( note_ref, param, records_struct.origin, records_struct.angles, 1 );
        pestle delete();
        level.hornet_mq.var_870342c57e88eff7.pestle = level mq_spawn_item( %"hash_657a5c27d4c0c0a3", pestle_end.origin, pestle_end.angles );
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x929b7078, Offset: 0x35b55
    // Size: 0x25, Type: dev
    function function_30f698cf0144933c( params )
    {
        level.hornet_mq.var_f47b6e6966ed4cdf = 2;
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x547c238e, Offset: 0x35b82
    // Size: 0xf, Type: dev
    function function_58178d8f8f592450( params )
    {
        
    }

    // Namespace zm_sat_hornet_mq_quest
    // Params 1
    // Checksum 0x6742618f, Offset: 0x35b99
    // Size: 0xf, Type: dev
    function function_ec0a86a9669640e1( params )
    {
        
    }

#/
