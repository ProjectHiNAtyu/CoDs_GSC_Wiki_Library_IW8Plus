// scripts\mp\br\gametypes\br_gametype_blight.gsc  (hash_6cbf2f5bc4b51623.gscc) (size: 83010 Bytes / 0x14442 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x953964fb (2503566587)
// size ...... 83010 (0x14442)
// includes .. 75  (offset: 0x12f82)
// strings ... 223 (offset: 0x131da)
// dev strs .. 97  (offset: 0x13f52)
// exports ... 181 (offset: 0xd0ae)
// cseg ...... 0x1351 + 0xbd5d (0xd0ae)
// imports ... 541 (offset: 0xecf6)
// animtree1 . 0   (offset: 0x14442)
// animtree2 . 0   (offset: 0x14442)
#using script_19aec99df234f03a;
#using script_2bcdd4c5a6662216;
#using script_43c750266ef75ab1;
#using script_6e841597aa154b0f;
#using script_71cef547a69e4a26;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\squad_wipe_streak;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\menus;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\squads;
#using scripts\mp\supers;
#using scripts\mp\weaponmetadata;
#using scripts\mp\weapons;

#namespace br_gametype_blight;

// Namespace br_gametype_blight
// Params 0
// Checksum 0x33da88d0, Offset: 0x136f
// Size: 0xf0
function main()
{
    callback::add( "brGametypeInit", &init );
    level.forceteamassignmentoverride = &function_973f1d933bdf1237;
    level.brenableagents = 1;
    level.supportsai = 1;
    level.var_5195f9fa56bdff5 = 1;
    level.var_a27e6eedf72c9dd1 = 1;
    level.var_90854497526d85e2 = 1;
    level.var_4b1d806e34262a54 = 1;
    level.var_d5c2787fbd88bebd = 1;
    level thread function_18db07862a1fa985( "match_state_prematch" );
    br::main();
    
    if ( !level.var_c339a4b8c7451a75 )
    {
        level.getspawnpoint = &get_prematch_spawn_point;
    }
    
    level.bypassclasschoicefunc = &function_c521ed1cde1f13ca;
    level.var_3d90777bfb7fc504 = [ "axis" ];
    br_clash_bots::init();
    weaponmetadata::init_weaponmetadata();
    level.br_endgamesplashcallback = &function_8f261015e4f861ae;
    level.br_ending_delay = 3;
    level.br_skipending = 1;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xcc36bdb7, Offset: 0x1467
// Size: 0x45d
function init( params )
{
    level.blight_data = {};
    level.blight_data.cs_flag_name = getdvar( @"hash_6f65885e90f96a04", "mp_saw_manticore_s6_blight_cs" );
    level.blight_data.var_8395a0d335e96d8d = getdvarint( @"hash_c6f74b1d7655192e", 60 );
    level.blight_data.time_limit = getmatchrulesdata( "commonOption", "timeLimit" );
    level.blight_data.var_e4b282a855625dd5 = getdvarfloat( @"hash_f993740b296b2aac", 1 );
    level.blight_data.var_bd3d5c5e3b3e4082 = getdvarfloat( @"hash_6795c03339145a93", 1 );
    level.blight_data.var_a208d7d8cdbeda0 = getdvarint( @"hash_caf7878fd2b1deef", 1 );
    level.blight_data.var_2e8243d05444447a = getdvarint( @"hash_910e8220bc4beecd", 60 );
    level.blight_data.var_3459ea044f2c17a = getdvarint( @"hash_e2e284db249799cb", 1 );
    level.blight_data.self_revive_item = common_item_database::function_a4f0a21951180013( "wz_consumable_self_revive" );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &function_b0c9d22416a3c49a );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &function_55afff28bffb52d4 );
    utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &function_ee0f54cba034e45b );
    utility::registersharedfunc( #"gametype", #"hash_7176c1a02c5f7181", &function_6ebc44048f38fc94 );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &function_4625a17a2b7eddcf );
    utility::registersharedfunc( #"gametype", #"playerkilledspawn", &gametype_player_respawn );
    utility::registersharedfunc( #"gametype", #"infilsequence", &function_e81ea78b68a99fed );
    utility::registersharedfunc( #"gametype", #"isteameliminated", &function_e63b08cdf3694f0f );
    utility::registersharedfunc( #"gametype", #"hash_6c05b3acbd2dd56b", &function_9dd94976f58656ab );
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &function_ba0dbb6375b27b99 );
    utility::registersharedfunc( #"gametype", #"hash_1ca6f9c7ab29f828", &br::nakeddrophandleloadout );
    utility::registersharedfunc( #"gametype", #"hash_9274b776f2a290a6", &gametype_update_winning_players );
    utility::registersharedfunc( #"gametype", #"hash_7af8e4ae0ab0a773", &function_22623d18d6e2f656 );
    utility::registersharedfunc( #"gametype", #"play_br_ending", &function_679512e045a398c2 );
    utility::registersharedfunc( #"gametype", #"droponplayerdeath", &function_4c3d731e7b33f4a5 );
    utility::registersharedfunc( #"gametype", #"hash_ded3090518300d77", &function_9a78810c38dfc0ad );
    utility::registersharedfunc( #"gametype", #"endgame", &gametype_end_game );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &gametype_on_player_killed );
    utility::registersharedfunc( #"gamemode", #"hash_8d3beab1cbd2cada", &function_5d9a2cd26f2b3d5b );
    level thread function_6db9b6d3de5ff382();
    init_loadouts();
    init_score_tiers();
    init_airdrop();
    init_br_features();
    init_infected_scenes();
    level thread init_dialog();
    level.brgametype.playerdeathflare = getdvarint( @"hash_c528d703cb1f905e", 1 );
    utility::delaythread( 5, &loadsound );
    utility::registersharedfunc( #"zombie_damage", #"hash_35082172ddd8a685", &zombie_damage::handle_status_effects );
    callback::add( "smokeGrenade_playerGiveBlindeye", &function_d916bae096e090d5 );
    callback::add( "smokeGrenade_playerRemoveBlindeye", &function_4d1e80e942b6cc06 );
    weapons::deregisterusedcallback( "decoy_grenade" );
    weapons::registerusedcallback( "decoy_grenade", &function_12d3e6293a73c2b );
    
    /#
        init_debug();
    #/
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x30f536bd, Offset: 0x18cc
// Size: 0xe
function loadsound()
{
    audio_utility::snd_transient_load( "br_zxp" );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xc0614fbb, Offset: 0x18e2
// Size: 0x14
function disable_encounters()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    function_5c8d67de275a7b84( 0 );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xc603ae8a, Offset: 0x18fe
// Size: 0x9
function enable_encounters()
{
    function_5c8d67de275a7b84( 1 );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x9dff1a70, Offset: 0x190f
// Size: 0x37
function function_18db07862a1fa985( tag )
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    function_a25acb62ddab20e2( tag, 1 );
    level.blight_data.var_86b56771a4fa03ca = tag;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x81957ba4, Offset: 0x194e
// Size: 0x128
function function_6db9b6d3de5ff382()
{
    level endon( #"game_ended" );
    level.blight_data.map_structs = [];
    
    if ( level.blight_data.cs_flag_name == "" )
    {
        flag_name = "create_script_initialized";
    }
    else
    {
        flag_name = level.blight_data.cs_flag_name + "_completed";
    }
    
    utility::flag_wait( flag_name );
    target_names = [ "blight_infil_spawn", "blight_infected_scene", "blight_ambient_spawn_blocker" ];
    
    foreach ( target_name in target_names )
    {
        level.blight_data.map_structs[ target_name ] = utility::getstructarray( target_name, "targetname" );
    }
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xf405b423, Offset: 0x1a7e
// Size: 0x274
function init_dna_samples()
{
    level.blight_data.dna_sample_count = 0;
    level.blight_data.airdrops_spawned = 0;
    level.blight_data.dna_sample_max = getdvarint( @"hash_7ac5fa1e48e5e396", 15000 );
    level.blight_data.var_26d75b7715a707cf = getdvarint( @"hash_6bdc44aca2fd795a", 300 );
    level.blight_data.var_fcbdf6efd84e7e83 = getdvarint( @"hash_b696362544bd4c15", 50 );
    level.blight_data.var_c08710cff86ce264 = getdvarint( @"hash_a272fc6a3659182b", 25 );
    level.blight_data.var_2653eb09f0d23bbf = getdvarint( @"hash_9d8c2abc36f40b73", 10 );
    level.blight_data.var_415b101f17d8fa2c = getdvarint( @"hash_62636be61edcdc08", 25 );
    level.blight_data.var_65fa2b5d2770cb2d = getdvarint( @"hash_722374974d6cf830", 1 ) != 0;
    level.blight_data.var_bdd4992f4669ffa9 = getdvarfloat( @"hash_2528cd56ceb21d36", 1 );
    level.blight_data.dna_multiplier = level.blight_data.var_bdd4992f4669ffa9;
    level.blight_data.var_bea6d01c509bc044 = [ { #multiplier:getdvarfloat( @"hash_b500248f8c7a4470", 1.5 ), #threshold:getdvarint( @"hash_a99c954f03495c3e", 50 ), #type:"percent" }, { #multiplier:getdvarfloat( @"hash_feb63987c3da7144", 2 ), #threshold:getdvarint( @"hash_17b4117346845f4a", 25 ), #type:"percent" }, { #multiplier:getdvarfloat( @"hash_dc3eca5e3b4efb64", 2.5 ), #threshold:getdvarint( @"hash_c83173d33cbe456a", 5 ), #type:"survivors" } ];
    currency::register_currency_type( "dna_sample", undefined, undefined, &function_6d16c5e59603aa8b );
    level thread function_38707ded255ad51a();
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x47267a72, Offset: 0x1cfa
// Size: 0x13f
function init_loadouts()
{
    setomnvar( o"ui_only_default_loadouts", 1 );
    loadout_table = getscriptbundle( level.classtablename );
    var_d2f8a9659e85cb03 = getdvarint( @"hash_18bac806cec1a906", 5 );
    survivor_loadouts = [];
    infected_loadouts = [];
    
    foreach ( i, loadout_entry in loadout_table.classlist )
    {
        var_178ac71b8d3da156 = getscriptbundle( hashcat( %"classtableentry:", loadout_entry.entry ) );
        var_b662f7daaabd57ef = class::function_79947c7814a64d0e( var_178ac71b8d3da156 );
        class_key = menus::getclasschoice( 100 + i );
        
        if ( i < var_d2f8a9659e85cb03 )
        {
            survivor_loadouts[ class_key ] = var_b662f7daaabd57ef;
            continue;
        }
        
        infected_loadouts[ class_key ] = var_b662f7daaabd57ef;
    }
    
    init_infected_loadout( infected_loadouts );
    init_survivor_loadout( survivor_loadouts );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x932b0f58, Offset: 0x1e41
// Size: 0x59
function init_infected_loadout( loadouts )
{
    level.blight_data.infectedloadouts = loadouts;
    level.blight_data.infectedloadout = utility::array_random( loadouts );
    assert( level.blight_data.infectedloadout );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xd7058e1b, Offset: 0x1ea2
// Size: 0x28f
function init_survivor_loadout( loadouts )
{
    level.blight_data.survivorloadouts = loadouts;
    level.blight_data.var_1b92ea09b2011c5f = utility::array_random( getarraykeys( loadouts ) );
    level.blight_data.survivorloadout = loadouts[ level.blight_data.var_1b92ea09b2011c5f ];
    level.brgametype.var_9286479699f5ca9b = getdvarint( @"hash_fb97a0687ce79e14", 1 );
    level.brgametype.var_2d4806127526d579 = getdvarint( @"hash_ec758320492bf8e", 1 );
    
    if ( level.brgametype.var_2d4806127526d579 != -1 )
    {
        level.brgametype.var_97ef3254270cf0b3 = [];
        level.brgametype.var_97ef3254270cf0b3[ 0 ] = level.brgametype.var_2d4806127526d579;
        var_97ef3254270cf0b3 = strtok( getdvar( @"hash_5503e93341fca8ba", "2:3,4:5" ), "," );
        
        foreach ( var_3481bfa65d96b0a in var_97ef3254270cf0b3 )
        {
            data = strtok( var_3481bfa65d96b0a, ":" );
            assert( data.size == 2, "<dev string:x24>" );
            assert( int( data[ 0 ] ) != 0, "<dev string:x4f>" );
            level.brgametype.var_97ef3254270cf0b3[ int( data[ 0 ] ) ] = int( data[ 1 ] );
        }
        
        level.brgametype.var_14218428ebed4a75 = level.brgametype.var_97ef3254270cf0b3.size - 1;
    }
    
    if ( level.brgametype.var_9286479699f5ca9b )
    {
        level.var_996fc22e6a2c14a2 = class::getclassindex( level.blight_data.var_1b92ea09b2011c5f );
    }
    
    if ( !level.br_allowloadout )
    {
        level.modeloadoutupdateammo = &br::brloadoutupdateammo;
        level.var_bece8079501efa50 = &br::function_ea36aaaded0fd51f;
        level.giveloadouteverytime = 1;
    }
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x3e61eadc, Offset: 0x2139
// Size: 0x8f
function init_score_tiers()
{
    level.brgametype.var_6648f001bf5c77a2 = getdvarint( @"hash_b888acf624f2866e", 90 );
    level.brgametype.var_641e0cf69a87e2ba = getdvarint( @"hash_8d8bfaa130e05e87", 5 );
    level.brgametype.var_ca4eee2c3590b638 = getdvarint( @"hash_2e59dee4a76a9041", 120 );
    level.brgametype.var_8854b2d070c2e9d8 = getdvarint( @"hash_1f2f87ee3591bee6", 500 );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x383b808d, Offset: 0x21d0
// Size: 0x34
function init_br_features()
{
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"hash_56a2d01019099833" );
    events::function_b8b24a291af69f1d();
    level.var_6dec2a870f55b3c2 = 1;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xd1d7dcf7, Offset: 0x220c
// Size: 0x27
function private function_c521ed1cde1f13ca()
{
    class = "default1";
    self.pers[ "class" ] = class;
    return class;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x9adec550, Offset: 0x223c
// Size: 0xd4
function init_infected_scenes()
{
    bundle = getscriptbundle( %"hash_2f939fb56b709520" );
    level.blight_data.var_94dc8e8b32f90fdb = [];
    
    foreach ( entry in bundle.var_f437355af0c34bc6 )
    {
        level.blight_data.var_94dc8e8b32f90fdb[ level.blight_data.var_94dc8e8b32f90fdb.size ] = entry.scenebundle;
    }
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xf5f9bc56, Offset: 0x2318
// Size: 0x4e1
function init_dialog()
{
    utility::registersharedfunc( #"blight", #"hash_372b7765497d3ec4", &function_86e69830b4062c31 );
    level waittill( #"hash_bb95e0eb0e85637" );
    level.var_d0dcfd1df517304f = 0;
    game[ "dialog" ][ "gametype_giant_infected_name" ] = "dx_br_msmt_giin_haan_ggi1";
    game[ "dialog" ][ "gametype_giant_infected_desc" ] = "dx_br_msmt_giin_haan_gdgi";
    game[ "dialog" ][ "random_zombie_selection_soon" ] = "dx_br_msmt_giin_haan_rzss";
    game[ "dialog" ][ "random_zombie_selected" ] = "dx_br_msmt_giin_haan_rzsl";
    game[ "dialog" ][ "respawn_as_zombie" ] = "dx_br_msmt_giin_haan_reaz";
    game[ "dialog" ][ "respawning_enemy_in_area" ] = "giin_haan_zsnw";
    game[ "dialog_prefix" ][ "respawning_enemy_in_area" ] = "dx_br_msmt_";
    game[ "dialog" ][ "25perc_infected" ] = "dx_br_msmt_giin_haan_25pi";
    game[ "dialog" ][ "50perc_infected" ] = "dx_br_msmt_giin_haan_50pi";
    game[ "dialog" ][ "75perc_infected" ] = "dx_br_msmt_giin_haan_75pi";
    game[ "dialog" ][ "5_survivors_remaining" ] = "dx_br_msmt_giin_haan_5svr";
    game[ "dialog" ][ "3_survivors_remaining" ] = "dx_br_msmt_giin_haan_3svr";
    game[ "dialog" ][ "1_survivor_remaining" ] = "dx_br_msmt_giin_haan_1svr";
    game[ "dialog" ][ "match_timer_halftime" ] = "dx_br_msmt_giin_haan_mthf";
    game[ "dialog" ][ "match_timer_five_minutes_left" ] = "dx_br_msmt_giin_haan_mt4l";
    game[ "dialog" ][ "match_timer_one_minute_left" ] = "dx_br_msmt_giin_haan_mt1l";
    game[ "dialog" ][ "zombie_powers_upgraded" ] = "dx_br_msmt_giin_haan_zpup";
    game[ "dialog" ][ "25perc_dna_collected" ] = "dx_br_msmt_giin_haan_25pd";
    game[ "dialog" ][ "50perc_dna_collected" ] = "dx_br_msmt_giin_haan_50pd";
    game[ "dialog" ][ "75perc_dna_collected" ] = "dx_br_msmt_giin_haan_75pd";
    game[ "dialog" ][ "100perc_dna_collected" ] = "dx_br_msmt_giin_haan_100d";
    game[ "dialog" ][ "survivors_win" ] = "dx_br_msmt_giin_haan_svwi";
    game[ "dialog" ][ "zombies_win" ] = "dx_br_msmt_giin_haan_zmwi";
    game[ "dialog" ][ "public_event_supply_airdrop" ] = "dx_br_msmt_giin_haan_pesa";
    game[ "dialog" ][ "public_event_vehicle_airdrop" ] = "dx_br_msmt_giin_haan_peva";
    game[ "dialog" ][ "public_event_dna_airdrop" ] = "dx_br_msmt_giin_haan_peda";
    game[ "dialog" ][ "public_event_jugg_suit_airdrop" ] = "dx_br_msmt_giin_haan_peja";
    game[ "dialog" ][ "public_event_wonder_weapon_airdrop" ] = "dx_br_msmt_giin_haan_peww";
    game[ "dialog" ][ "player_wonder_weapon_equipped_proximity_warning" ] = "dx_br_msmt_giin_haan_wwpx";
    game[ "dialog" ][ "survivor_weapon_upgraded" ] = "dx_br_msmt_giin_haan_svwu";
    game[ "dialog" ][ "circle_collapse" ] = "dx_br_msmt_giin_haan_cico";
    game[ "dialog" ][ "zombie_respawns_disabled_soon_survivors" ] = "dx_br_msmt_giin_haan_zrds";
    game[ "dialog" ][ "zombie_respawns_disabled_soon_zombies" ] = "dx_br_msmt_giin_haan_zrdz";
    game[ "dialog" ][ "zombie_respawns_disabled_survivors" ] = "dx_br_msmt_giin_haan_zrxs";
    game[ "dialog" ][ "zombie_respawns_disabled_zombies" ] = "dx_br_msmt_giin_haan_zrxz";
    level.blight_data.dialog = {};
    level.blight_data.dialog.player_count_next_index = 0;
    level.blight_data.dialog.player_count_sequence = [ { #threshold:25, #type:"percent", #key:"25perc_infected" }, { #threshold:50, #type:"percent", #key:"50perc_infected" }, { #threshold:75, #type:"percent", #key:"75perc_infected" }, { #threshold:5, #type:"survivors", #key:"5_survivors_remaining" }, { #threshold:3, #type:"survivors", #key:"3_survivors_remaining" }, { #threshold:1, #type:"survivors", #key:"1_survivor_remaining" } ];
    level.blight_data.dialog.dna_next_index = 0;
    level.blight_data.dialog.dna_sequence = [ { #threshold:25, #key:"25perc_dna_collected" }, { #threshold:50, #key:"50perc_dna_collected" }, { #threshold:75, #key:"75perc_dna_collected" }, { #threshold:100, #key:"100perc_dna_collected" } ];
}

// Namespace br_gametype_blight
// Params 3
// Checksum 0x45efd6ed, Offset: 0x2801
// Size: 0xa0
function function_86e69830b4062c31( dialog, var_16638b9bb24628a4, delay = 0 )
{
    target = undefined;
    
    if ( isarray( var_16638b9bb24628a4 ) )
    {
        target = var_16638b9bb24628a4;
    }
    else if ( isplayer( var_16638b9bb24628a4 ) )
    {
        target = [ var_16638b9bb24628a4 ];
    }
    else if ( isstring( var_16638b9bb24628a4 ) )
    {
        target = teams::getteamdata( var_16638b9bb24628a4, "players" );
    }
    else
    {
        assertmsg( "<dev string:x6c>" + dialog + "<dev string:x8c>" );
        return;
    }
    
    br_public::brleaderdialog( dialog, 0, target, 1, delay, undefined, "" );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xc742597e, Offset: 0x28a9
// Size: 0x1af
function function_ab4e4a2017d89a67()
{
    survivor_count = teams::getteamdata( "allies", "players" ).size;
    infected_count = teams::getteamdata( "axis", "players" ).size;
    total_count = survivor_count + infected_count;
    
    if ( total_count <= 0 )
    {
        return;
    }
    
    infected_perc = infected_count * 100 / total_count;
    play_index = -1;
    
    for ( i = level.blight_data.dialog.player_count_next_index; i < level.blight_data.dialog.player_count_sequence.size ; i++ )
    {
        entry = level.blight_data.dialog.player_count_sequence[ i ];
        valid = 0;
        
        switch ( entry.type )
        {
            case #"hash_29d064edbf33703a":
                valid = infected_perc >= entry.threshold;
                break;
            case #"hash_de7c048858d4d584":
                valid = survivor_count <= entry.threshold;
                break;
        }
        
        if ( valid )
        {
            play_index = i;
        }
    }
    
    if ( play_index < 0 )
    {
        return;
    }
    
    level.blight_data.dialog.player_count_next_index = play_index + 1;
    function_86e69830b4062c31( level.blight_data.dialog.player_count_sequence[ play_index ].key, "allies" );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x362426bc, Offset: 0x2a60
// Size: 0x142
function function_5d07eb2290abebcf()
{
    if ( level.blight_data.dna_sample_max <= 0 )
    {
        return;
    }
    
    dna_perc = level.blight_data.dna_sample_count * 100 / level.blight_data.dna_sample_max;
    play_index = -1;
    
    for ( i = level.blight_data.dialog.dna_next_index; i < level.blight_data.dialog.dna_sequence.size ; i++ )
    {
        if ( dna_perc >= level.blight_data.dialog.dna_sequence[ i ].threshold )
        {
            play_index = i;
        }
    }
    
    if ( play_index < 0 )
    {
        return;
    }
    
    level.blight_data.dialog.dna_next_index = play_index + 1;
    function_86e69830b4062c31( level.blight_data.dialog.dna_sequence[ play_index ].key, "allies" );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xed4aa16f, Offset: 0x2baa
// Size: 0xf3
function function_5597a9e3b1925cfc()
{
    /#
        if ( level.blight_data.time_limit < 180 )
        {
            return;
        }
    #/
    
    times = [ level.blight_data.time_limit * 0.5, 300, 60 ];
    dialog_names = [ "match_timer_halftime", "match_timer_five_minutes_left", "match_timer_one_minute_left" ];
    current_time_sec = gettime() * 0.001;
    end_time_sec = current_time_sec + level.blight_data.time_limit;
    
    for ( i = 0; i < times.size ; i++ )
    {
        wait end_time_sec - current_time_sec - times[ i ];
        current_time_sec = gettime() * 0.001;
        function_86e69830b4062c31( dialog_names[ i ], level.players );
    }
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xdd0c54b, Offset: 0x2ca5
// Size: 0x63
function init_airdrop()
{
    level.brgametype.var_e61994d389be1cc3 = getdvarint( @"hash_c40bed1c6c93721c", 0 );
    
    if ( level.brgametype.var_e61994d389be1cc3 )
    {
        utility::delaythread( level.framedurationseconds, &airdrop_scriptbundle::registerairdrop, "saw_airdrop_blight_weapon", &function_37eb1543bf6a4acd, &function_1e8637e9de8e144c, &function_be47d6fad7ac5a99 );
    }
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x9b6d8dd6, Offset: 0x2d10
// Size: 0x501
function init_activities()
{
    level endon( #"game_ended" );
    
    /#
        if ( level.var_c339a4b8c7451a75 )
        {
            return;
        }
    #/
    
    activity_common::function_9fd46b47e0d8481d( 13, &function_e9cfbcd076e6aa5e );
    level.blight_data.finale_instance = activity_instance_common::createactivityinstance( "BLIGHT_FINALE", "finale" );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_bb5870a6bfcb1d90, "BLIGHT_FINALE" );
    activity_common::function_2dd4f07fa5c3e911( "ActivityFailure", &function_6408b1de541e8fd1, "BLIGHT_FINALE" );
    init_public_events();
    level.blight_data.var_f3df3e7851ff02a = getdvarint( @"hash_d8a44c494a3ab3ad", 1 );
    level.blight_data.var_7659fcceeec3dda1 = [];
    level.blight_data.var_300d6f8744c75f9c = [];
    level.blight_data.var_c9a988d9e3cf0d41 = [];
    activity_settings = level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_d0392b6883a8a63b" ];
    activity_list = activity_settings.activitylist;
    level.blight_data.activity_type_data = [];
    
    foreach ( entry in activity_list )
    {
        activity_struct = entry.activity;
        type = activity_struct.activitytype;
        activity_type_disabled = getdvarint( hashcat( @"hash_b4f3f261e9af0fa2", type ), 0 );
        
        if ( activity_type_disabled )
        {
            continue;
        }
        
        var_5537b7783b622b98 = getdvarint( hashcat( @"hash_20df75384a6f9d79", type ), activity_struct.var_62b562f8da847626 );
        var_c8055debb85181e = getdvarint( hashcat( @"hash_56f766ffbfe5b93f", type ), activity_struct.maxpermatch );
        var_c024105e10188736 = getdvarint( hashcat( @"hash_16dba23a9bd40b3f", type ), activity_struct.var_c0cc07294e59e2c );
        var_e3fc2e8fc90e232d = getdvarint( hashcat( @"hash_86aeeaf1c8d7e5e", type ), activity_struct.var_f9418c8764ac631b );
        var_5758451b780b91cc = getdvarint( hashcat( @"hash_99aba1ec0a72881", type ), activity_struct.var_acb2ecb0fc735ece );
        level.blight_data.activity_type_data[ type ] = { #var_5758451b780b91cc:var_5758451b780b91cc, #var_e3fc2e8fc90e232d:var_e3fc2e8fc90e232d, #var_c024105e10188736:var_c024105e10188736, #var_c8055debb85181e:var_c8055debb85181e, #var_5537b7783b622b98:var_5537b7783b622b98 };
        level.blight_data.var_7659fcceeec3dda1[ type ] = [];
        variant_names = activity_definition_utils::function_d795f5e961e88824( type );
        
        foreach ( name in variant_names )
        {
            variant = activity_instance_common::createactivityinstance( type, name );
            level.blight_data.var_7659fcceeec3dda1[ type ][ level.blight_data.var_7659fcceeec3dda1[ type ].size ] = variant;
            level.blight_data.var_300d6f8744c75f9c[ level.blight_data.var_300d6f8744c75f9c.size ] = variant;
            function_26abe599a8b916bb( variant );
        }
    }
    
    level activity_distribution();
    
    foreach ( entry in activity_list )
    {
        level thread function_84469a1c59bdb6bb( entry.activity, level.blight_data.activity_distribution.var_be307fd6a7c3f648[ entry.activity.activitytype ] );
        level thread function_6325e0feaf56d335( entry.activity, level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ entry.activity.activitytype ] );
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xcaf173cc, Offset: 0x3219
// Size: 0xb27
function private activity_distribution()
{
    flags::function_2f3408423ccc9b2e( "initial_spawns_selected" );
    level.blight_data.activity_distribution = {};
    activity_settings = level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_d0392b6883a8a63b" ];
    general_settings = activity_settings.generalsettings;
    var_49783ed112e7a24c = getdvarint( @"hash_40af28432093f2e3", general_settings.mindistspawn );
    var_d8dfdc22d462ef44 = getdvarint( @"hash_c8758cb17c1c12df", general_settings.mindistactivities );
    var_d34fa2d06a50c573 = level.blight_data.var_300d6f8744c75f9c;
    var_6051ffdbbc260e10 = [];
    instances_chosen = [];
    var_be307fd6a7c3f648 = [];
    var_f9fc19b48d1fc4f1 = [];
    
    foreach ( instance in level.blight_data.var_300d6f8744c75f9c )
    {
        foreach ( cluster in level.blight_data.var_aba7c9f65a2bf5f1 )
        {
            if ( !cluster.used )
            {
                continue;
            }
            
            dist = distance2dsquared( cluster.origin, instance.var_441d26d05f86b224 );
            
            if ( dist < squared( var_49783ed112e7a24c ) )
            {
                if ( !isdefined( var_f9fc19b48d1fc4f1[ instance.type ] ) )
                {
                    var_f9fc19b48d1fc4f1[ instance.type ] = [];
                }
                
                var_6051ffdbbc260e10[ var_6051ffdbbc260e10.size ] = instance;
                var_f9fc19b48d1fc4f1[ instance.type ][ var_f9fc19b48d1fc4f1[ instance.type ].size ] = instance;
                var_d34fa2d06a50c573 = arrayremove( var_d34fa2d06a50c573, instance );
            }
        }
    }
    
    level.blight_data.activity_distribution.starting_quadrant = randomintrange( 1, 5 );
    current_quadrant = level.blight_data.activity_distribution.starting_quadrant;
    var_7bd1f382bb3860b3 = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        var_696b98d6f248e722 = [];
        level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ] = [];
        var_6afbbcf4dd24af42 = arrayrandomize( level.blight_data.var_c9a988d9e3cf0d41[ current_quadrant ] );
        
        for ( idx = 0; idx < var_6afbbcf4dd24af42.size ; idx++ )
        {
            instance = var_6afbbcf4dd24af42[ idx ];
            
            if ( !arraycontains( var_d34fa2d06a50c573, instance ) )
            {
                continue;
            }
            
            if ( !isdefined( var_be307fd6a7c3f648[ instance.type ] ) )
            {
                var_be307fd6a7c3f648[ instance.type ] = [];
            }
            
            if ( !isdefined( var_f9fc19b48d1fc4f1[ instance.type ] ) )
            {
                var_f9fc19b48d1fc4f1[ instance.type ] = [];
            }
            
            if ( !isdefined( var_7bd1f382bb3860b3[ instance.type ] ) )
            {
                var_7bd1f382bb3860b3[ instance.type ] = 0;
            }
            
            if ( !isdefined( var_696b98d6f248e722[ instance.type ] ) )
            {
                var_696b98d6f248e722[ instance.type ] = 0;
            }
            
            if ( !isdefined( level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ] ) )
            {
                level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ] = 0;
            }
            
            if ( var_7bd1f382bb3860b3[ instance.type ] >= level.blight_data.activity_type_data[ instance.type ].var_c8055debb85181e )
            {
                var_6051ffdbbc260e10[ var_6051ffdbbc260e10.size ] = instance;
                var_f9fc19b48d1fc4f1[ instance.type ][ var_f9fc19b48d1fc4f1[ instance.type ].size ] = instance;
                var_d34fa2d06a50c573 = arrayremove( var_d34fa2d06a50c573, instance );
                continue;
            }
            
            if ( var_696b98d6f248e722[ instance.type ] >= level.blight_data.activity_type_data[ instance.type ].var_e3fc2e8fc90e232d )
            {
                var_6051ffdbbc260e10[ var_6051ffdbbc260e10.size ] = instance;
                var_f9fc19b48d1fc4f1[ instance.type ][ var_f9fc19b48d1fc4f1[ instance.type ].size ] = instance;
                var_d34fa2d06a50c573 = arrayremove( var_d34fa2d06a50c573, instance );
                continue;
            }
            
            if ( instances_chosen.size == 0 )
            {
                instances_chosen[ instances_chosen.size ] = instance;
                var_be307fd6a7c3f648[ instance.type ][ var_be307fd6a7c3f648[ instance.type ].size ] = instance;
                var_d34fa2d06a50c573 = arrayremove( var_d34fa2d06a50c573, instance );
                var_7bd1f382bb3860b3[ instance.type ]++;
                var_696b98d6f248e722[ instance.type ]++;
                level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ]++;
                continue;
            }
            
            too_close = 0;
            
            foreach ( used_instance in instances_chosen )
            {
                var_222cd977387f3329 = distance2dsquared( used_instance.var_441d26d05f86b224, instance.var_441d26d05f86b224 );
                
                if ( var_222cd977387f3329 < squared( var_d8dfdc22d462ef44 ) )
                {
                    too_close = 1;
                    break;
                }
            }
            
            if ( too_close )
            {
                var_6051ffdbbc260e10[ var_6051ffdbbc260e10.size ] = instance;
                var_f9fc19b48d1fc4f1[ instance.type ][ var_f9fc19b48d1fc4f1[ instance.type ].size ] = instance;
                var_d34fa2d06a50c573 = arrayremove( var_d34fa2d06a50c573, instance );
                continue;
            }
            
            instances_chosen[ instances_chosen.size ] = instance;
            var_be307fd6a7c3f648[ instance.type ][ var_be307fd6a7c3f648[ instance.type ].size ] = instance;
            var_7bd1f382bb3860b3[ instance.type ]++;
            var_696b98d6f248e722[ instance.type ]++;
            level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ]++;
        }
        
        current_quadrant++;
        
        if ( current_quadrant > 4 )
        {
            current_quadrant = 1;
        }
    }
    
    level.blight_data.activity_distribution.var_7bd1f382bb3860b3 = arraycopy( var_7bd1f382bb3860b3 );
    level.blight_data.activity_distribution.var_6051ffdbbc260e10 = arraycopy( var_6051ffdbbc260e10 );
    level.blight_data.activity_distribution.var_f9fc19b48d1fc4f1 = arraycopy( var_f9fc19b48d1fc4f1 );
    level.blight_data.activity_distribution.instances_chosen = arraycopy( instances_chosen );
    level.blight_data.activity_distribution.var_be307fd6a7c3f648 = arraycopy( var_be307fd6a7c3f648 );
    
    foreach ( type, num_chosen in var_7bd1f382bb3860b3 )
    {
        if ( num_chosen < level.blight_data.activity_type_data[ type ].var_5537b7783b622b98 )
        {
            function_1c715140bb66dc3d( type );
        }
    }
    
    if ( !level.blight_data.debug_activity_spread )
    {
        foreach ( type, data in level.blight_data.activity_type_data )
        {
            if ( data.var_c024105e10188736 )
            {
                if ( !isdefined( level.blight_data.activity_distribution.var_ad1fa2b6321474f5 ) )
                {
                    level.blight_data.activity_distribution.var_ad1fa2b6321474f5 = [];
                }
                
                if ( !isdefined( level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ type ] ) )
                {
                    level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ type ] = [];
                }
                
                if ( level.blight_data.activity_type_data[ type ].var_5758451b780b91cc )
                {
                    foreach ( instance in level.blight_data.activity_distribution.var_be307fd6a7c3f648[ type ] )
                    {
                        level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ type ][ level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ type ].size ] = instance.activitydefinitiontag;
                    }
                    
                    foreach ( instance in level.blight_data.activity_distribution.var_f9fc19b48d1fc4f1[ type ] )
                    {
                        if ( instance.state != "Active" )
                        {
                            activity_instance_common::function_9aeeabe50fc9cc3e( instance );
                        }
                    }
                    
                    continue;
                }
                
                level.blight_data.activity_distribution.var_ad1fa2b6321474f5[ type ] = level.blight_data.activity_distribution.var_f9fc19b48d1fc4f1[ type ];
            }
        }
    }
    
    /#
        function_b46176641d013e85();
    #/
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xba9ab12, Offset: 0x3d48
// Size: 0x60c
function private function_1c715140bb66dc3d( activity_type )
{
    activity_settings = level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_d0392b6883a8a63b" ];
    general_settings = activity_settings.generalsettings;
    var_d8dfdc22d462ef44 = getdvarint( @"hash_c8758cb17c1c12df", general_settings.mindistactivities );
    fallback_attempts = 0;
    var_673a1cd19e9213ae = 10;
    current_quadrant = level.blight_data.activity_distribution.starting_quadrant;
    
    while ( fallback_attempts < var_673a1cd19e9213ae && level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ activity_type ] < level.blight_data.activity_type_data[ activity_type ].var_5537b7783b622b98 )
    {
        fallback_attempts++;
        var_d8dfdc22d462ef44 -= 500 * fallback_attempts;
        var_d8dfdc22d462ef44 = max( 1, var_d8dfdc22d462ef44 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ activity_type ] >= level.blight_data.activity_type_data[ activity_type ].var_5537b7783b622b98 )
            {
                break;
            }
            
            var_6afbbcf4dd24af42 = arrayrandomize( level.blight_data.var_c9a988d9e3cf0d41[ current_quadrant ] );
            
            for ( idx = 0; idx < var_6afbbcf4dd24af42.size ; idx++ )
            {
                if ( level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ activity_type ] >= level.blight_data.activity_type_data[ activity_type ].var_5537b7783b622b98 )
                {
                    break;
                }
                
                instance = var_6afbbcf4dd24af42[ idx ];
                
                if ( arraycontains( level.blight_data.activity_distribution.var_be307fd6a7c3f648[ activity_type ], instance ) || instance.type != activity_type )
                {
                    continue;
                }
                
                if ( !isdefined( level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ instance.type ] ) )
                {
                    level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ instance.type ] = 0;
                }
                
                if ( !isdefined( level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ] ) )
                {
                    level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ] = 0;
                }
                
                if ( level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ instance.type ] >= level.blight_data.activity_type_data[ instance.type ].var_c8055debb85181e )
                {
                    continue;
                }
                
                if ( level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ] >= level.blight_data.activity_type_data[ instance.type ].var_e3fc2e8fc90e232d )
                {
                    continue;
                }
                
                too_close = 0;
                
                foreach ( used_instance in level.blight_data.activity_distribution.instances_chosen )
                {
                    var_222cd977387f3329 = distance2dsquared( used_instance.var_441d26d05f86b224, instance.var_441d26d05f86b224 );
                    
                    if ( var_222cd977387f3329 < squared( var_d8dfdc22d462ef44 ) )
                    {
                        too_close = 1;
                        break;
                    }
                }
                
                if ( too_close )
                {
                    continue;
                }
                
                level.blight_data.activity_distribution.instances_chosen[ level.blight_data.activity_distribution.instances_chosen.size ] = instance;
                level.blight_data.activity_distribution.var_be307fd6a7c3f648[ instance.type ][ level.blight_data.activity_distribution.var_be307fd6a7c3f648[ instance.type ].size ] = instance;
                level.blight_data.activity_distribution.var_6051ffdbbc260e10 = arrayremove( level.blight_data.activity_distribution.var_6051ffdbbc260e10, instance );
                level.blight_data.activity_distribution.var_f9fc19b48d1fc4f1[ instance.type ] = arrayremove( level.blight_data.activity_distribution.var_f9fc19b48d1fc4f1[ instance.type ], instance );
                level.blight_data.activity_distribution.var_7bd1f382bb3860b3[ instance.type ]++;
                level.blight_data.activity_distribution.var_696b98d6f248e722[ current_quadrant ][ instance.type ]++;
            }
            
            current_quadrant++;
            
            if ( current_quadrant > 4 )
            {
                current_quadrant = 1;
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xc3788a14, Offset: 0x435c
// Size: 0x266
function private function_26abe599a8b916bb( activity_instance )
{
    map_center_angles = ( 0, 0, 0 );
    var_b85216ee45ee6071 = ( 0, 0, activity_instance.var_441d26d05f86b224[ 2 ] );
    map_forward = anglestoforward( map_center_angles );
    map_left = anglestoleft( map_center_angles );
    activity_dir = vectornormalize( var_b85216ee45ee6071 - activity_instance.var_441d26d05f86b224 );
    vector_dot = vectordot( map_forward, activity_dir );
    vector_dot_left = vectordot( map_left, activity_dir );
    
    if ( vector_dot > 0 )
    {
        if ( vector_dot_left > 0 )
        {
            quadrant = 3;
            
            if ( !isdefined( level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] ) )
            {
                level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] = [];
            }
            
            level.blight_data.var_c9a988d9e3cf0d41[ quadrant ][ level.blight_data.var_c9a988d9e3cf0d41[ quadrant ].size ] = activity_instance;
        }
        else
        {
            quadrant = 1;
            
            if ( !isdefined( level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] ) )
            {
                level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] = [];
            }
            
            level.blight_data.var_c9a988d9e3cf0d41[ quadrant ][ level.blight_data.var_c9a988d9e3cf0d41[ quadrant ].size ] = activity_instance;
        }
    }
    else if ( vector_dot_left > 0 )
    {
        quadrant = 4;
        
        if ( !isdefined( level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] ) )
        {
            level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] = [];
        }
        
        level.blight_data.var_c9a988d9e3cf0d41[ quadrant ][ level.blight_data.var_c9a988d9e3cf0d41[ quadrant ].size ] = activity_instance;
    }
    else
    {
        quadrant = 2;
        
        if ( !isdefined( level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] ) )
        {
            level.blight_data.var_c9a988d9e3cf0d41[ quadrant ] = [];
        }
        
        level.blight_data.var_c9a988d9e3cf0d41[ quadrant ][ level.blight_data.var_c9a988d9e3cf0d41[ quadrant ].size ] = activity_instance;
    }
    
    activity_instance.map_quadrant = quadrant;
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x48ac670c, Offset: 0x45ca
// Size: 0x147
function private function_84469a1c59bdb6bb( activity_struct, activity_instances )
{
    level endon( #"game_ended", #"finale_bomb_armed", #"finale_started" );
    level endon( #"hash_5a3ae2a0a696ee1f" );
    delay = getdvarint( hashcat( @"hash_3ef3f61394e749e9", activity_struct.activitytype ), activity_struct.var_e718fa46a25a62d1 );
    
    if ( delay > 0 )
    {
        flags::function_2f3408423ccc9b2e( "infil_complete" );
        wait delay;
    }
    else
    {
        flags::function_2f3408423ccc9b2e( "initial_spawns_selected" );
    }
    
    foreach ( instance in activity_instances )
    {
        activity_instance_common::function_46135a69bddfec2c( instance );
    }
    
    if ( activity_instances[ 0 ] && isdefined( activity_struct.var_550217baa20805bd ) && activity_struct.var_550217baa20805bd != "" )
    {
        activity_instances[ 0 ] activity_player_broadcasting::function_cb4750c84882dd07( activity_struct.var_550217baa20805bd );
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xfa11e1db, Offset: 0x4719
// Size: 0x3ca
function private function_6325e0feaf56d335( activity_struct, var_2b5558fed446b09 )
{
    level endon( #"game_ended", #"finale_bomb_armed", #"finale_started" );
    level endon( #"hash_5a3ae2a0a696ee1f" );
    
    if ( var_2b5558fed446b09.size == 0 )
    {
        return;
    }
    
    delay = getdvarint( hashcat( @"hash_3f3f9b2014c2b8ab", activity_struct.activitytype ), activity_struct.var_a470c8290d28af9b );
    
    if ( delay > 0 )
    {
        flags::function_2f3408423ccc9b2e( "infil_complete" );
        wait delay;
    }
    else
    {
        flags::function_2f3408423ccc9b2e( "initial_spawns_selected" );
    }
    
    active_instances = [];
    
    foreach ( instance in level.activities.instances )
    {
        if ( instance.type == activity_struct.activitytype && instance.state == "Active" )
        {
            active_instances[ active_instances.size ] = instance;
        }
    }
    
    var_c024105e10188736 = level.blight_data.activity_type_data[ activity_struct.activitytype ].var_c024105e10188736;
    var_c8055debb85181e = level.blight_data.activity_type_data[ activity_struct.activitytype ].var_c8055debb85181e;
    var_8c2b6450be727420 = min( var_c024105e10188736, var_c8055debb85181e - active_instances.size );
    
    if ( var_8c2b6450be727420 > 0 )
    {
        var_2b5558fed446b09 = arrayrandomize( var_2b5558fed446b09 );
        var_829607649f7880a = 0;
        var_8a26c962d5504af1 = var_2b5558fed446b09[ 0 ];
        
        for ( i = 0; i < var_2b5558fed446b09.size ; i++ )
        {
            instance = var_2b5558fed446b09[ i ];
            
            if ( !activity_instance_common::isactivityinstance( instance ) )
            {
                create_new_instance = 1;
                
                foreach ( active_instance in active_instances )
                {
                    if ( instance == active_instance.activitydefinitiontag )
                    {
                        create_new_instance = 0;
                        break;
                    }
                }
                
                if ( create_new_instance )
                {
                    instance = activity_instance_common::createactivityinstance( activity_struct.activitytype, instance );
                    var_8a26c962d5504af1 = instance;
                }
                else
                {
                    continue;
                }
            }
            
            instance.var_829607649f7880a = 1;
            activity_instance_common::function_46135a69bddfec2c( instance );
            var_829607649f7880a++;
            
            if ( var_829607649f7880a == var_8c2b6450be727420 )
            {
                break;
            }
        }
        
        if ( var_8a26c962d5504af1 && activity_instance_common::isactivityinstance( var_8a26c962d5504af1 ) && isdefined( activity_struct.var_550217baa20805bd ) && activity_struct.var_550217baa20805bd != "" )
        {
            var_8a26c962d5504af1 activity_player_broadcasting::function_cb4750c84882dd07( activity_struct.var_550217baa20805bd );
        }
    }
    
    foreach ( instance in var_2b5558fed446b09 )
    {
        if ( activity_instance_common::isactivityinstance( instance ) && instance.state != "Active" )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( instance );
        }
    }
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x610e2720, Offset: 0x4aeb
// Size: 0x72
function function_e9cfbcd076e6aa5e( params )
{
    conditional_container = params[ 0 ];
    activity_instance = params[ 1 ];
    types = [ "BR_PUBLIC_EVENT_JUGGERNAUT", "BR_PUBLIC_EVENT_RESTOCK", "BLIGHT_CRATE_DROP" ];
    
    if ( arraycontains( types, activity_instance.type ) )
    {
        conditional_container::addcondition( conditional_container, &function_c9ba43997feb67bd, [] );
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x47a265ac, Offset: 0x4b65
// Size: 0x26, Type: bool
function private function_c9ba43997feb67bd( player, params )
{
    return player.team != "axis";
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xe444f64c, Offset: 0x4b94
// Size: 0x33
function function_b0c9d22416a3c49a()
{
    level thread init_activities();
    flags::gameflaginit( "infil_complete", 0 );
    flags::gameflaginit( "initial_spawns_selected", 0 );
    level thread on_prematch_fade_done();
    br_infils_util::function_3855f5796f4d2b65();
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xd3aac54a, Offset: 0x4bcf
// Size: 0xe6
function on_prematch_fade_done()
{
    flags::gameflagwait( "prematch_fade_done" );
    init_dna_samples();
    level thread function_2503658c1f77908c();
    
    if ( level.brgametype.var_e61994d389be1cc3 )
    {
        level thread function_bb517f5d695440ab();
    }
    
    level.disableforfeit = 1;
    level.forceteamassignmentoverride = undefined;
    level callback::add( #"player_death", &on_player_death );
    level callback::add( "lootcache_looted", &on_player_loot_cache );
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    level callback::add( #"hash_d06b059fdd983fc3", &on_player_score_given );
    level callback::add( #"player_damaged", &on_player_damaged );
    level thread function_cd3f04e1b0ac352b();
    level thread watch_player_count();
    level thread function_b04d974eaf8775f9();
    level thread function_6005f8ac721eaeb5();
    ai_spawn_director::function_c83497dcedebe189( &on_agent_spawned );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x4489f9f3, Offset: 0x4cbd
// Size: 0xe5
function watch_player_count()
{
    level endon( #"game_ended" );
    function_831ed812280386ab();
    
    for ( ;; )
    {
        survivor_count = teams::getteamdata( "allies", "players" ).size;
        infected_count = teams::getteamdata( "axis", "players" ).size;
        
        if ( survivor_count <= 0 )
        {
            level.blight_data.end_game_reason = "wipeout";
            level thread [[ level.endgame ]]( "axis" );
            return;
        }
        
        setomnvar( "ui_allies_team_size", survivor_count );
        setomnvar( "ui_axis_team_size", infected_count );
        
        if ( level.blight_data.var_65fa2b5d2770cb2d )
        {
            function_637c8da31eb5180c( survivor_count, infected_count );
        }
        
        if ( level.blight_data.var_9df63a352b2aee7f )
        {
            function_a66d00edcfdd324e( survivor_count, infected_count );
        }
        
        function_ab4e4a2017d89a67();
        wait 1;
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xf82f4004, Offset: 0x4daa
// Size: 0x102
function private function_831ed812280386ab()
{
    level.blight_data.var_9df63a352b2aee7f = getdvarint( @"hash_212d1a22bef74d9e", 1 ) != 0;
    level.blight_data.var_dc1db3cfbe66b079 = getdvarint( @"hash_99322a7461f87374", 5 );
    level.blight_data.var_b524628cb475a388 = getdvarint( @"hash_63b26556962327c8", 60 ) * 1000;
    level.blight_data.var_45e4ae07133a674 = getdvarint( @"hash_c3de8d3d665a020", 180 ) * 1000;
    level.blight_data.var_ef07716953661a8c = 0;
    level.blight_data.var_ba2e087b7fe399a2 = undefined;
    
    if ( !level.blight_data.var_9df63a352b2aee7f || level.players.size < level.blight_data.var_dc1db3cfbe66b079 )
    {
        return;
    }
    
    level thread function_dc452564a0567406();
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xc11f37e4, Offset: 0x4eb4
// Size: 0x46
function private function_dc452564a0567406()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "infil_complete" );
    level.blight_data.var_ba2e087b7fe399a2 = gettime() + level.blight_data.var_45e4ae07133a674;
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xf52698cc, Offset: 0x4f02
// Size: 0xe2
function private function_a66d00edcfdd324e( survivor_count, infected_count )
{
    if ( infected_count >= level.blight_data.var_dc1db3cfbe66b079 )
    {
        return;
    }
    
    if ( !isdefined( level.blight_data.var_ba2e087b7fe399a2 ) || survivor_count <= 0 )
    {
        return;
    }
    
    current_time = gettime();
    
    if ( current_time > level.blight_data.var_ba2e087b7fe399a2 )
    {
        return;
    }
    
    if ( current_time < level.blight_data.var_ef07716953661a8c )
    {
        return;
    }
    
    squad = function_eda467da940d80b( infected_count );
    
    if ( !isdefined( squad ) )
    {
        return;
    }
    
    level.blight_data.var_ef07716953661a8c = current_time + level.blight_data.var_b524628cb475a388;
    level thread function_227859c7ab91b3a9( squad );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x97683fac, Offset: 0x4fec
// Size: 0x159
function private function_227859c7ab91b3a9( squad )
{
    level endon( #"game_ended" );
    util_show_splash( "infected_minimum_warning", squad.players, 0 );
    half_wait_time = 2.5;
    wait half_wait_time;
    
    foreach ( player in squad.players )
    {
        player.scene_death = 1;
        player.special_fade = 1;
        level thread game_utility::fadetoblackforplayer( player, 1, half_wait_time );
    }
    
    wait half_wait_time;
    
    foreach ( player in squad.players )
    {
        if ( isalive( player ) )
        {
            player suicide();
        }
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xf0a5c4e5, Offset: 0x514d
// Size: 0x2ac
function private function_eda467da940d80b( infected_count )
{
    var_89005ea3b242a5c3 = level.blight_data.var_dc1db3cfbe66b079 - infected_count + 1;
    candidates = [];
    
    foreach ( squad in level.squaddata[ "allies" ] )
    {
        if ( !isdefined( squad ) )
        {
            continue;
        }
        
        alive_players = [];
        
        foreach ( player in squad.players )
        {
            if ( isalive( player ) )
            {
                alive_players[ alive_players.size ] = player;
            }
        }
        
        if ( alive_players.size == 0 )
        {
            continue;
        }
        
        candidates[ candidates.size ] = { #players:alive_players };
    }
    
    if ( candidates.size == 0 )
    {
        return;
    }
    
    best = undefined;
    
    foreach ( candidate in candidates )
    {
        if ( candidate.players.size < var_89005ea3b242a5c3 )
        {
            continue;
        }
        
        if ( !isdefined( best ) || candidate.players.size < best.players.size )
        {
            best = candidate;
        }
    }
    
    if ( isdefined( best ) )
    {
        return best;
    }
    
    foreach ( candidate in candidates )
    {
        if ( !isdefined( best ) || candidate.players.size > best.players.size )
        {
            best = candidate;
        }
    }
    
    return best;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x801706b5, Offset: 0x5402
// Size: 0x1b6
function function_b04d974eaf8775f9()
{
    level endon( #"game_ended" );
    
    if ( !level.timelimit )
    {
        level.timelimit = level.blight_data.time_limit;
    }
    
    gamelogic_mp::pausetimer();
    level waittill( #"infil_complete" );
    gamelogic_mp::resumetimer();
    level childthread function_5597a9e3b1925cfc();
    setomnvar( "ui_match_timer_hidden", 0 );
    
    /#
        if ( getdvarint( @"hash_39478b3f18e1b4af", 0 ) )
        {
            return;
        }
    #/
    
    time_to_wait = level.blight_data.time_limit;
    level.blight_data.start_time = gettime();
    
    while ( true )
    {
        result = utility::waittill_any_timeout( time_to_wait, "finale_bomb_armed", "finale_started" );
        
        switch ( result )
        {
            case #"hash_53164ee2dbe50280":
                time_remaining = gamelogic_mp::gettimeremaining();
                var_a44f67a72c6aa4fa = 0;
                
                if ( level.blight_data.var_a208d7d8cdbeda0 )
                {
                    if ( time_remaining < level.blight_data.var_2e8243d05444447a * 1000 )
                    {
                        var_a44f67a72c6aa4fa = function_d894c3263499d8bb( time_remaining );
                    }
                }
                
                time_to_wait = ( time_remaining + var_a44f67a72c6aa4fa ) * 0.001;
                break;
            case #"hash_b35e230b014bc9df":
                gamelogic_mp::pausetimer();
                setomnvar( "ui_match_timer_hidden", 1 );
                return;
            case #"hash_d4dde12b38318c68":
                utility::flag_set( "blight_ending" );
                level.blight_data.end_game_reason = "time";
                level thread [[ level.endgame ]]( "axis" );
                return;
        }
    }
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x956804ee, Offset: 0x55c0
// Size: 0xb9
function function_d894c3263499d8bb( time_remaining )
{
    if ( level.timelimit == 0 )
    {
        return 0;
    }
    
    if ( !isdefined( level.extratime ) )
    {
        level.extratime = 0;
    }
    
    minimum_time = level.blight_data.var_2e8243d05444447a;
    var_b7c814d77cccdfcb = roundint( minimum_time - time_remaining * 0.001 );
    var_5e9c63c8746e7992 = int( minimum_time * 1000 - time_remaining );
    level.extratime += var_b7c814d77cccdfcb;
    gamelogic_mp::pausetimer();
    gamelogic_mp::resumetimer( var_5e9c63c8746e7992 + time_remaining );
    setomnvar( o"ui_match_extra_time", var_b7c814d77cccdfcb );
    return var_5e9c63c8746e7992;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xdd7ead7, Offset: 0x5682
// Size: 0x117
function function_bb517f5d695440ab()
{
    level endon( #"game_ended" );
    next_airdrop = level.blight_data.var_26d75b7715a707cf;
    
    for ( ;; )
    {
        if ( level.blight_data.dna_sample_count >= next_airdrop )
        {
            level.blight_data.airdrops_spawned++;
            next_airdrop = ( level.blight_data.airdrops_spawned + 1 ) * level.blight_data.var_26d75b7715a707cf;
            crates = airdrop_scriptbundle::startairdrop( "saw_airdrop_blight_weapon", undefined, "allies" );
            
            foreach ( crate in crates )
            {
                function_9449b795b43ccbe0( crate );
            }
        }
        
        wait 1;
    }
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xcf3922f6, Offset: 0x57a1
// Size: 0xc
function on_player_connect( params )
{
    
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x8562afb3, Offset: 0x57b5
// Size: 0x22e
function on_player_death( params )
{
    if ( params.inflictor.classname == "worldspawn" )
    {
        return;
    }
    
    if ( params.victim.team == "allies" )
    {
        if ( params.attacker.team == "axis" )
        {
            challenges::function_37e945722d6497f3( params.attacker, "gametype_blight_human_turned", 1 );
        }
        
        if ( level.brgametype.playerdeathflare )
        {
            level thread squad_wipe_streak::squad_wipe_shoot_flare( params.victim );
        }
        
        if ( level.blight_data.var_3459ea044f2c17a && params.meansofdeath != "MOD_SUICIDE" )
        {
            foreach ( data in params.victim.attackerdata )
            {
                if ( data.var_2a11f150d0e7dca4 > 0 && !data.downedby )
                {
                    continue;
                }
                
                if ( data.var_2a11f150d0e7dca4 == 0 && data.killedby )
                {
                    continue;
                }
                
                if ( data.downedby && data.killedby )
                {
                    continue;
                }
                
                if ( isdefined( data.damage ) )
                {
                    if ( data.damage >= 70 )
                    {
                        bonusmagnitude = 2;
                    }
                    else if ( data.damage >= 35 )
                    {
                        bonusmagnitude = 1;
                    }
                }
                
                data.attackerent thread gamescore::processassist( params.victim, params.objweapon, bonusmagnitude, data.damage );
            }
        }
    }
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x554bd970, Offset: 0x59eb
// Size: 0x96
function on_player_death_add_items( params )
{
    if ( params.victim.team == "axis" && !level.blight_data.finale_triggered )
    {
        quantity = level.blight_data.var_fcbdf6efd84e7e83;
        itemname = item_currency::function_a3eadb2d3c329589( "dna_sample", quantity );
        return [ { #quantity:quantity, #itemname:itemname } ];
    }
    
    return [];
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x37fbb71, Offset: 0x5a8a
// Size: 0x75
function on_player_loot_cache( params )
{
    if ( params.player.team == "allies" )
    {
        quantity = level.blight_data.var_c08710cff86ce264;
        item_name = item_currency::function_a3eadb2d3c329589( "dna_sample", quantity );
        common_item::function_57b88e025e5fb03e( item_name, quantity, params.spawnoptions );
    }
}

// Namespace br_gametype_blight
// Params 3
// Checksum 0x966206f0, Offset: 0x5b07
// Size: 0x96
function on_agent_spawned( agent, requestid, data )
{
    agent.health = level.blight_data.var_f1569c16a29ffcbf;
    
    if ( !data.ambient )
    {
        return;
    }
    
    var_81a5a78b4d1c8ec = utility::random_weighted( level.blight_data.var_fc6261768b030b78, level.blight_data.var_95b2260ee357c0bd );
    agent zombie_utils::function_a8ce00e0448cb6f0( var_81a5a78b4d1c8ec, "zombie_movement_type", 1 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xae15c968, Offset: 0x5ba5
// Size: 0x1d2
function private function_6005f8ac721eaeb5()
{
    level endon( #"game_ended" );
    level.blight_data.difficulty_keyframes = [ { #weights:[ 50, 45, 5, 0 ], #health:150, #time:0 }, { #weights:[ 35, 50, 15, 0 ], #health:200, #time:300 }, { #weights:[ 0, 25, 50, 25 ], #health:300, #time:900 } ];
    level.blight_data.var_fc6261768b030b78 = [ "walk", "run", "sprint", "super_sprint" ];
    level.blight_data.var_95b2260ee357c0bd = arraycopy( level.blight_data.difficulty_keyframes[ 0 ].weights, 0 );
    level.blight_data.var_f1569c16a29ffcbf = level.blight_data.difficulty_keyframes[ 0 ].health;
    level.blight_data.var_79fcf1b00922dc8b = 0;
    start_time = gettime();
    
    while ( true )
    {
        wait 10;
        elapsed_sec = ( gettime() - start_time ) * 0.001;
        
        if ( function_88edd6bcd9ca78b2( elapsed_sec ) )
        {
            break;
        }
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x48075f15, Offset: 0x5d7f
// Size: 0x1ef, Type: bool
function private function_88edd6bcd9ca78b2( elapsed_sec )
{
    keyframes = level.blight_data.difficulty_keyframes;
    
    while ( level.blight_data.var_79fcf1b00922dc8b < keyframes.size - 1 && elapsed_sec >= keyframes[ level.blight_data.var_79fcf1b00922dc8b + 1 ].time )
    {
        level.blight_data.var_79fcf1b00922dc8b++;
    }
    
    from_index = level.blight_data.var_79fcf1b00922dc8b;
    
    if ( from_index >= keyframes.size - 1 )
    {
        final_keyframe = keyframes[ keyframes.size - 1 ];
        level.blight_data.var_95b2260ee357c0bd = arraycopy( final_keyframe.weights, 0 );
        level.blight_data.var_f1569c16a29ffcbf = final_keyframe.health;
        return true;
    }
    
    from = keyframes[ from_index ];
    to = keyframes[ from_index + 1 ];
    frac = math::lerp_fraction( from.time, to.time, elapsed_sec );
    level.blight_data.var_f1569c16a29ffcbf = roundint( math::lerp( from.health, to.health, frac ) );
    
    for ( i = 0; i < level.blight_data.var_fc6261768b030b78.size ; i++ )
    {
        level.blight_data.var_95b2260ee357c0bd[ i ] = roundint( math::lerp( from.weights[ i ], to.weights[ i ], frac ) );
    }
    
    return false;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x445862fa, Offset: 0x5f77
// Size: 0xa2
function function_8c5e06ee1e60aeb7( params )
{
    if ( params.victim.activity_spawned || !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( randomint( 101 ) > 25 )
    {
        return;
    }
    
    quantity = level.blight_data.var_2653eb09f0d23bbf;
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( params.victim );
    item_name = item_currency::function_a3eadb2d3c329589( "dna_sample", quantity );
    common_item::function_57b88e025e5fb03e( item_name, quantity, spawn_options );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xe799427b, Offset: 0x6021
// Size: 0xe, Type: bool
function function_ee0f54cba034e45b( player )
{
    return true;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x208e52ab, Offset: 0x6038
// Size: 0xd, Type: bool
function function_55afff28bffb52d4( player )
{
    return false;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xa80bd44, Offset: 0x604e
// Size: 0x27, Type: bool
function function_6ebc44048f38fc94( deathdata )
{
    return deathdata.victim.team == "allies";
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x27d36028, Offset: 0x607e
// Size: 0x17
function function_4625a17a2b7eddcf( player )
{
    return flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xbd8afab3, Offset: 0x609e
// Size: 0xd, Type: bool
function function_e63b08cdf3694f0f( team )
{
    return false;
}

// Namespace br_gametype_blight
// Params 2
// Checksum 0xd08fe632, Offset: 0x60b4
// Size: 0x85, Type: bool
function gametype_player_respawn( death_data, final_death )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( level.gameended || utility::flag( "blight_ending" ) )
    {
        death_data.victim thread br_spectate::spawnspectator( death_data, 1, 0 );
        return false;
    }
    
    zombiespawnpoint = get_zombie_spawn_origin();
    thread function_b3283af49c10d434( "axis", zombiespawnpoint, self.scene_death );
    return true;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0xfc192313, Offset: 0x6142
// Size: 0xa
function function_e81ea78b68a99fed()
{
    level thread function_cdf1070dc65f3d83();
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xe5ec7650, Offset: 0x6154
// Size: 0x34f
function private function_8499ed0926316541( var_52f9bd64feef6c51, group_size )
{
    all_groups = [];
    buckets = [];
    
    for ( i = group_size - 1; i > 0 ; i-- )
    {
        buckets[ i ] = [];
    }
    
    foreach ( squad in var_52f9bd64feef6c51 )
    {
        if ( squad.players.size >= group_size )
        {
            all_groups[ all_groups.size ] = { #players:squad.players };
            continue;
        }
        
        if ( squad.players.size > 0 )
        {
            buckets[ squad.players.size ][ buckets[ squad.players.size ].size ] = squad;
        }
    }
    
    next = [];
    
    for ( size = 1; size < group_size ; size++ )
    {
        if ( isdefined( buckets[ size ] ) )
        {
            buckets[ size ] = arrayrandomize( buckets[ size ] );
        }
        
        next[ size ] = 0;
    }
    
    var_564dc86c0a0e7be = [];
    
    for ( ;; )
    {
        start_size = 0;
        
        for ( size = group_size - 1; size >= 1 ; size-- )
        {
            if ( isdefined( buckets[ size ] ) && next[ size ] < buckets[ size ].size )
            {
                start_size = size;
                break;
            }
        }
        
        if ( start_size == 0 )
        {
            break;
        }
        
        group_players = [];
        
        foreach ( player in buckets[ start_size ][ next[ start_size ] ].players )
        {
            group_players[ group_players.size ] = player;
        }
        
        next[ start_size ]++;
        remaining = group_size - group_players.size;
        
        for ( fill_size = remaining; fill_size >= 1 ; fill_size-- )
        {
            while ( fill_size <= remaining && isdefined( buckets[ fill_size ] ) && next[ fill_size ] < buckets[ fill_size ].size )
            {
                foreach ( player in buckets[ fill_size ][ next[ fill_size ] ].players )
                {
                    group_players[ group_players.size ] = player;
                }
                
                next[ fill_size ]++;
                remaining = group_size - group_players.size;
            }
        }
        
        if ( group_players.size < group_size )
        {
            var_564dc86c0a0e7be[ var_564dc86c0a0e7be.size ] = { #players:group_players };
            continue;
        }
        
        all_groups[ all_groups.size ] = { #players:group_players };
    }
    
    return { #var_564dc86c0a0e7be:var_564dc86c0a0e7be, #full_groups:all_groups };
}

// Namespace br_gametype_blight
// Params 2
// Checksum 0x54a5a450, Offset: 0x64ac
// Size: 0x269
function function_3f8eb87f855a3b12( group_size, min_infected )
{
    squads = [];
    
    foreach ( squad in level.squaddata[ "allies" ] )
    {
        if ( getdvarint( @"hash_926883e2c429851a", 0 ) )
        {
            skip = 0;
            
            foreach ( player in squad.players )
            {
                if ( isbot( player ) || player isplayerheadless() )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
        }
        
        squads[ squads.size ] = squad;
    }
    
    var_6ed21c51e2e18aa8 = function_8499ed0926316541( squads, group_size );
    all_groups = var_6ed21c51e2e18aa8.full_groups;
    var_b7084280e7c81564 = getdvarint( @"hash_200e1eff7c87cab2", 1 );
    var_d5cadca02bc215ea = all_groups.size * group_size > min_infected;
    
    if ( !var_b7084280e7c81564 || !var_d5cadca02bc215ea )
    {
        all_groups = arraycombine( all_groups, var_6ed21c51e2e18aa8.var_564dc86c0a0e7be );
    }
    
    all_groups = arrayrandomize( all_groups );
    infected = [];
    
    for ( i = 0; i < all_groups.size && infected.size < min_infected ; i++ )
    {
        foreach ( player in all_groups[ i ].players )
        {
            infected[ infected.size ] = player;
        }
    }
    
    return infected;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x3dd45d11, Offset: 0x671e
// Size: 0x4ef
function function_cdf1070dc65f3d83()
{
    flags::gameflagset( "prematch_fade_done" );
    disable_encounters();
    function_827d2127e7621f7d();
    level.gamemodebundle.var_6e029a8992f30541 = 1;
    level.forcegivesuper = &item_super::function_ea946b46f6cd671f;
    level.gametypebundle.prematchsuper = "none";
    players = teams::getteamdata( "allies", "players" );
    group_size = squad_utility::getmaxsquadsize();
    infected_count = getdvarint( @"hash_6c464fec50c98c06", 8 );
    selection_mode = getdvarint( @"hash_c66d175e5ad1fbbd", 1 );
    
    switch ( selection_mode )
    {
        case 1:
            infected = function_3f8eb87f855a3b12( group_size, infected_count );
            humans = arrayremove( players, infected );
            break;
        case 2:
            humans = utility::array_slice_random( players, infected_count );
            infected = arrayremove( players, humans );
            break;
        case 0:
        default:
            humans = players;
            infected = [];
            break;
    }
    
    if ( humans.size == 0 && infected.size > 0 )
    {
        candidates = infected;
        
        /#
            if ( candidates.size > 1 )
            {
                candidates = arrayremove( candidates, level.player );
            }
        #/
        
        guaranteed_human = utility::array_random( candidates );
        humans[ humans.size ] = guaranteed_human;
        infected = arrayremove( infected, guaranteed_human );
    }
    
    /#
        if ( getdvarint( @"hash_ec7ec67c705ad147", 0 ) && !arraycontains( infected, level.player ) )
        {
            infected[ infected.size ] = level.player;
            humans = arrayremove( humans, level.player );
        }
    #/
    
    level.blight_data.initial_infected = arraycopy( infected );
    utility::array_thread( level.players, &common_item::function_8d9d36a5c7542cab, 1 );
    
    if ( !level.br_infils_disabled )
    {
        infected_spawns = arrayrandomize( level.blight_data.map_structs[ "blight_infected_scene" ] );
        assert( infected.size <= infected_spawns.size, "<dev string:x9f>" + infected_spawns.size + "<dev string:xe6>" + infected.size + "<dev string:xf3>" );
        
        foreach ( idx, player in infected )
        {
            base = infected_spawns[ idx % infected_spawns.size ];
            scene_root = { #angles:base.angles, #origin:base.origin };
            player thread infected_play_scene( base.script_scenescriptbundle, scene_root );
        }
        
        function_251d50cc62b19c98( humans );
    }
    else
    {
        foreach ( player in infected )
        {
            scene_root = { #angles:player.angles, #origin:player.origin };
            player thread infected_play_scene( utility::array_random( level.blight_data.var_94dc8e8b32f90fdb ), scene_root );
        }
        
        foreach ( player in humans )
        {
            player thread human_infil_spawn( { #angles:player.angles, #origin:player.origin } );
        }
    }
    
    flags::gameflagset( "initial_spawns_selected" );
    wait 10;
    level.blight_data.var_26dc92ca3c027a03 = gettime();
    flags::gameflagset( "infil_complete" );
    function_86e69830b4062c31( "gametype_giant_infected_name", humans );
    function_86e69830b4062c31( "gametype_giant_infected_desc", humans, 1 );
    wait 3;
    enable_encounters();
    level thread function_18db07862a1fa985( "match_state_live" );
    level thread function_1a55252685d6a95e();
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xc5d585a0, Offset: 0x6c15
// Size: 0x144
function private function_9598743e75c66e94( players )
{
    var_c6cf4b680826df39 = [];
    
    foreach ( player in players )
    {
        if ( !isdefined( var_c6cf4b680826df39[ player.sessionsquadid ] ) )
        {
            var_c6cf4b680826df39[ player.sessionsquadid ] = [];
        }
        
        var_c6cf4b680826df39[ player.sessionsquadid ][ var_c6cf4b680826df39[ player.sessionsquadid ].size ] = player;
    }
    
    squads = [];
    
    foreach ( squad_players in var_c6cf4b680826df39 )
    {
        squads[ squads.size ] = { #players:squad_players };
    }
    
    return squads;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x3a2fac2c, Offset: 0x6d62
// Size: 0x473
function function_251d50cc62b19c98( humans )
{
    group_size = squad_utility::getmaxsquadsize();
    squads = function_9598743e75c66e94( humans );
    var_6ed21c51e2e18aa8 = function_8499ed0926316541( squads, group_size );
    human_groups = arraycombine( var_6ed21c51e2e18aa8.full_groups, var_6ed21c51e2e18aa8.var_564dc86c0a0e7be );
    human_groups = arrayrandomize( human_groups );
    spawn_in_clusters = getdvarint( @"hash_ed7dc3fd9ec56671", 1 );
    
    if ( spawn_in_clusters )
    {
        clusters = [];
        
        foreach ( spawn_point in level.blight_data.map_structs[ "blight_infil_spawn" ] )
        {
            if ( !isdefined( clusters[ spawn_point.script_noteworthy ] ) )
            {
                clusters[ spawn_point.script_noteworthy ] = [];
            }
            
            clusters[ spawn_point.script_noteworthy ][ clusters[ spawn_point.script_noteworthy ].size ] = spawn_point;
        }
        
        clusters = arrayrandomize( clusters );
        cluster_index = 0;
        spawn_index = 0;
        spawns = arrayrandomize( clusters[ 0 ] );
        
        foreach ( group_index, group in human_groups )
        {
            function_f2d1bdbcce55b8be( group.players, spawns[ spawn_index ] );
            spawn_index++;
            
            if ( spawn_index >= spawns.size )
            {
                is_last_group = group_index == human_groups.size - 1;
                is_last_cluster = cluster_index == clusters.size - 1;
                assert( is_last_group || !is_last_cluster, "<dev string:xf6>" );
                cluster_index++;
                spawns = arrayrandomize( clusters[ cluster_index ] );
                spawn_index = 0;
            }
        }
    }
    else
    {
        spawns = arrayrandomize( level.blight_data.map_structs[ "blight_infil_spawn" ] );
        spawn_index = 0;
        
        foreach ( group_index, group in human_groups )
        {
            function_f2d1bdbcce55b8be( group.players, spawns[ spawn_index ] );
            spawn_index++;
            is_last_group = group_index == human_groups.size - 1;
            is_last_spawn = spawn_index == spawns.size - 1;
            assert( is_last_group || !is_last_spawn, "<dev string:xf6>" );
        }
    }
    
    cluster_structs = [];
    
    foreach ( idx, cluster in clusters )
    {
        var_31ebc537d891bb1f = ( 0, 0, 0 );
        
        foreach ( spawn_point in cluster )
        {
            var_31ebc537d891bb1f += spawn_point.origin;
        }
        
        var_31ebc537d891bb1f /= cluster.size;
        cluster_struct = { #used:idx <= cluster_index, #name:idx, #origin:var_31ebc537d891bb1f };
        function_3719622570eab651( cluster_struct );
        cluster_structs[ cluster_structs.size ] = cluster_struct;
    }
    
    level.blight_data.var_aba7c9f65a2bf5f1 = arraycopy( cluster_structs );
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x93c2fb98, Offset: 0x71dd
// Size: 0x89
function private function_f2d1bdbcce55b8be( players, spawn_point )
{
    foreach ( slot, player in players )
    {
        function_2b3821ec5ae28a59( player, spawn_point, slot );
    }
}

// Namespace br_gametype_blight
// Params 3, eflags: 0x4
// Checksum 0xd75da844, Offset: 0x726e
// Size: 0xa2
function private function_2b3821ec5ae28a59( player, spawn_point, slot )
{
    origin = spawn_point.origin;
    angles = spawn_point.angles;
    offset = anglestoforward( angles ) * 50;
    offset = rotatevector( offset, ( 0, -15 + slot * 90, 0 ) );
    origin += offset;
    origin = br_public::droptogroundmultitrace( origin, 100 );
    player thread human_infil_spawn( { #angles:angles, #origin:origin } );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x7807a7cf, Offset: 0x7318
// Size: 0xe2
function private function_3719622570eab651( cluster )
{
    map_center_angles = ( 0, 0, 0 );
    var_b85216ee45ee6071 = ( 0, 0, cluster.origin[ 2 ] );
    map_forward = anglestoforward( map_center_angles );
    map_left = anglestoleft( map_center_angles );
    activity_dir = vectornormalize( var_b85216ee45ee6071 - cluster.origin );
    vector_dot = vectordot( map_forward, activity_dir );
    vector_dot_left = vectordot( map_left, activity_dir );
    
    if ( vector_dot > 0 )
    {
        if ( vector_dot_left > 0 )
        {
            quadrant = 3;
        }
        else
        {
            quadrant = 1;
        }
    }
    else if ( vector_dot_left > 0 )
    {
        quadrant = 4;
    }
    else
    {
        quadrant = 2;
    }
    
    cluster.map_quadrant = quadrant;
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x4bf18c6, Offset: 0x7402
// Size: 0xb2
function function_827d2127e7621f7d()
{
    foreach ( blocker in level.blight_data.map_structs[ "blight_ambient_spawn_blocker" ] )
    {
        function_1c4c7ef874191be2( "blight_infil", blocker.origin, blocker.radius, 1 );
    }
    
    utility::delaycall( 60, &function_314a16bd86565779 );
}

// Namespace br_gametype_blight
// Params 0
// Checksum 0x3c1cb1a9, Offset: 0x74bc
// Size: 0xc
function function_314a16bd86565779()
{
    function_71799ce2c69ce5a9( "blight_infil" );
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0xfc06f7a1, Offset: 0x74d0
// Size: 0x11
function function_973f1d933bdf1237( params )
{
    return "allies";
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xb566086c, Offset: 0x74ea
// Size: 0x155
function private gametype_end_game( winner, end_reason_text )
{
    var_22392512aa68e918 = winner == "allies" ? "survivors_win" : "zombies_win";
    game[ "dialog" ][ "team_loss" ] = undefined;
    function_86e69830b4062c31( var_22392512aa68e918, level.players, 2 );
    level thread disable_encounters();
    survivor_count = teams::getteamdata( "allies", "players" ).size;
    infected_count = teams::getteamdata( "axis", "players" ).size;
    elapsed_time = ( gettime() - level.blight_data.start_time ) * 0.001;
    eventparams = [];
    eventparams[ eventparams.size ] = "match_end_reason";
    eventparams[ eventparams.size ] = level.blight_data.end_game_reason;
    eventparams[ eventparams.size ] = "survivor_count";
    eventparams[ eventparams.size ] = survivor_count;
    eventparams[ eventparams.size ] = "infected_count";
    eventparams[ eventparams.size ] = infected_count;
    eventparams[ eventparams.size ] = "dna_collected";
    eventparams[ eventparams.size ] = level.blight_data.dna_sample_count;
    eventparams[ eventparams.size ] = "time_elapsed_seconds";
    eventparams[ eventparams.size ] = elapsed_time;
    dlog_recordevent( "dlog_event_blight_game_ended", eventparams );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x79d61540, Offset: 0x7647
// Size: 0x15e
function private function_8f261015e4f861ae( winner )
{
    winning_players = teams::getfriendlyplayers( winner, 0 );
    losing_players = teams::getenemyplayers( winner, 0 );
    var_ca079f0038cca1c5 = gamelogic_mp::getbrendsplashpostgamestate();
    
    foreach ( player in winning_players )
    {
        player setclientomnvar( "ui_br_player_position", 1 );
        player setclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
        player setclientomnvar( "ui_br_end_game_splash_type", 1 );
    }
    
    foreach ( player in losing_players )
    {
        player setclientomnvar( "ui_br_player_position", 2 );
        player setclientomnvar( "post_game_state", var_ca079f0038cca1c5 );
        player setclientomnvar( "ui_br_end_game_splash_type", 1 );
    }
}

// Namespace br_gametype_blight
// Params 3
// Checksum 0x98cd4937, Offset: 0x77ad
// Size: 0xc5
function function_b3283af49c10d434( target_team, spawn_point, var_e69562235889eed7 = 0 )
{
    assert( isdefined( self ), "<dev string:x123>" );
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"doingrespawn" );
    player.var_1be091ba55db848e = "blight";
    respawnstruct = function_28d55e4634552238( target_team, var_e69562235889eed7 );
    fade_delay = target_team == "axis" ? level.blight_data.var_e4b282a855625dd5 : undefined;
    player br_spawnrespawn::br_doingrespawn( fade_delay, respawnstruct, spawn_point );
}

// Namespace br_gametype_blight
// Params 2
// Checksum 0xc80e316, Offset: 0x787a
// Size: 0xba
function function_28d55e4634552238( target_team, var_e69562235889eed7 = 0 )
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97();
    rs br_spawnrespawn::function_ffd4cf4c20eae881( &function_c3ab5a8acb841dfc );
    rs br_spawnrespawn::function_b9b32e1004a183cb( &gametype_onrespawn );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( &function_f7ee3315cdf0f422 );
    rs br_spawnrespawn::function_7275e4fc001d486a( &function_e40506ebbeaa8031 );
    rs.optparams.target_team = target_team;
    rs.optparams.var_e69562235889eed7 = var_e69562235889eed7;
    
    if ( var_e69562235889eed7 )
    {
        rs.skipbattlechatter = 1;
        rs.skipparachute = 1;
    }
    
    return rs;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x21ae8f2b, Offset: 0x793d
// Size: 0x176, Type: bool
function function_c3ab5a8acb841dfc( optparams )
{
    target_team = optparams.target_team;
    
    if ( self.team != target_team )
    {
        if ( self.team == "allies" && target_team == "axis" )
        {
            function_e350c0052f866283( "converted_to_zombie" );
        }
        
        self setclientomnvar( o"hash_cd934a49066f02dc", 0 );
        profilestart();
        squad = teams::function_72b89edf6b47c40a( self );
        menus::addtoteam( target_team, 0, isalive( self ), 1 );
        squads::setsquad( target_team );
        
        foreach ( player in squad.players )
        {
            if ( player::isinlaststand( player ) && player.laststandreviveent )
            {
                laststand::function_9199954e53abe5f( player.laststandreviveent, self );
            }
        }
        
        profilestop();
        
        if ( target_team == "axis" )
        {
            function_86e69830b4062c31( "respawn_as_zombie", self, 4 );
            util_show_splash( "zombie_infected", self, 4 );
        }
    }
    
    ability_manager::function_5e3b7fab0d6d1449();
    namespace_69e3a436b5d8370e::function_5f06be4b62682c68( 0 );
    return true;
}

// Namespace br_gametype_blight
// Params 1
// Checksum 0x5b6cc541, Offset: 0x7abc
// Size: 0xd8
function gametype_onrespawn( optparams )
{
    if ( isbot( self ) )
    {
        self.var_e2512b84b839d80f = 1;
    }
    
    if ( self.special_fade )
    {
        level thread game_utility::fadetoblackforplayer( self, 0, level.framedurationseconds );
        self.special_fade = undefined;
    }
    
    var_af1feabe896eff01 = self.team == "axis";
    
    if ( var_af1feabe896eff01 )
    {
        br_player_zombie::setup( 1 );
        thread zombie_tier_start();
        function_4eff634a8afb54cd( self, 1 );
    }
    else
    {
        br_player_zombie::setup( 0 );
        
        if ( optparams.var_e69562235889eed7 )
        {
            thread human_infil_camera();
        }
        
        function_211ae758a9239007( 1 );
    }
    
    if ( !isdefined( self.survivor_tier ) )
    {
        self.survivor_tier = 0;
    }
    
    self setclientomnvar( o"ui_use_alt_bonus_items", var_af1feabe896eff01 );
    level thread br::updateplayerandteamcountui();
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x7d994310, Offset: 0x7b9c
// Size: 0x42
function private function_f7ee3315cdf0f422( optparams )
{
    if ( self.team == "axis" && !optparams.var_e69562235889eed7 )
    {
        wait level.blight_data.var_bd3d5c5e3b3e4082;
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x370aad7f, Offset: 0x7be6
// Size: 0x37
function private function_e40506ebbeaa8031( optparams )
{
    if ( self.team == "axis" )
    {
        common_item::function_8d9d36a5c7542cab( 0 );
        supers_mp::clearsuper();
        self.scene_death = undefined;
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x4300e3e1, Offset: 0x7c25
// Size: 0xe, Type: bool
function private function_ba0dbb6375b27b99( player )
{
    return true;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x72a89591, Offset: 0x7c3c
// Size: 0x2
function private function_76c72c86f14efd69()
{
    
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xb9ddd253, Offset: 0x7c46
// Size: 0xc
function private gametype_update_winning_players( winnerplayers )
{
    
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xfc89ee53, Offset: 0x7c5b
// Size: 0x43, Type: bool
function private function_22623d18d6e2f656( data )
{
    attacker = data.attacker ?? data.inflictor;
    return attacker br_public::playeriszombie() || isscriptedagent( attacker );
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x6dc893a9, Offset: 0x7ca7
// Size: 0x15
function private function_679512e045a398c2( winnerplayers, var_c71a8bc30a7b241b )
{
    
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xc13d5c9c, Offset: 0x7cc4
// Size: 0x100, Type: bool
function private function_4c3d731e7b33f4a5()
{
    victim = self;
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( victim );
    spawnoptions.isdeathevent = 1;
    spawnoptions.var_50e31f8c119ef961 = 0;
    spawnoptions.analyticssource = "death";
    human_death = victim.team == "allies";
    filter = common_inventory::function_369198873216ea88( victim );
    filter.dropweapons = 0;
    filter.dropcash = 0;
    filter.dropequipment = human_death;
    filter.dropammo = human_death;
    additionalitems = on_player_death_add_items( { #victim:victim } );
    victim common_inventory::function_4c281d89a14b4a16( spawnoptions, filter );
    spawnoptions.var_7a166247da860246 = arraycombine( spawnoptions.var_7a166247da860246, additionalitems );
    level thread common_inventory::function_993f81a1c4d8bbc1( spawnoptions );
    return true;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x39110aec, Offset: 0x7dcd
// Size: 0x70, Type: bool
function private function_9a78810c38dfc0ad()
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    spawnoptions.isdeathevent = 0;
    spawnoptions.var_50e31f8c119ef961 = 0;
    filter = common_inventory::function_369198873216ea88( self );
    filter.dropweapons = 0;
    filter.dropcash = 0;
    common_inventory::function_4c281d89a14b4a16( spawnoptions, filter );
    level thread common_inventory::function_993f81a1c4d8bbc1( spawnoptions );
    return true;
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xa78793b3, Offset: 0x7e46
// Size: 0xbb
function private gametype_on_player_killed( deathdata )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    victim = deathdata.victim;
    
    if ( victim.team == "allies" )
    {
        aliveplayers = teams::getteamdata( "allies", "alivePlayers" );
        
        if ( aliveplayers.size == 1 && !utility::flag( "final_survivor" ) )
        {
            level thread final_survivor_sequence( aliveplayers[ 0 ] );
            return;
        }
        
        if ( aliveplayers.size == 0 )
        {
            level.blight_data.end_game_reason = "wipeout";
            level thread [[ level.endgame ]]( "axis" );
        }
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xefd610d0, Offset: 0x7f09
// Size: 0x22
function private function_5d9a2cd26f2b3d5b( owner, owner_team )
{
    return teams::getteamdata( owner_team, "players" );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x1e9c8b85, Offset: 0x7f34
// Size: 0xe9
function private function_211ae758a9239007( max_ammo )
{
    item_ammo::function_a530c73bf2e2b013( 0, 0, max_ammo );
    primaryequipment = equipment_mp::getcurrentequipment( "primary" );
    secondaryequipment = equipment_mp::getcurrentequipment( "secondary" );
    var_64475d2b78c272c3 = function_5713d46873b29625( [ primaryequipment, secondaryequipment ] );
    
    foreach ( equipment in var_64475d2b78c272c3 )
    {
        var_c8eb89f9e85900d2 = equipment_mp::getequipmentammo( equipment );
        
        if ( var_c8eb89f9e85900d2 == 0 )
        {
            equipment_mp::incrementequipmentammo( equipment, 1 );
        }
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xb0496a46, Offset: 0x8025
// Size: 0xa1
function private human_infil_spawn( spawn_point )
{
    self endon( #"death_or_disconnect" );
    self.respawningbr = isalive( self );
    function_b3283af49c10d434( "allies", spawn_point, 1 );
    self.respawningbr = undefined;
    function_211ae758a9239007();
    function_2ffc9ff578abb765();
    
    if ( laststand::function_7072b516e6cffb7c() < level.gametypebundle.var_a6e51b07b899b200 )
    {
        itembundle = getscriptbundle( level.blight_data.self_revive_item );
        common_item::function_360e96e0447f17f9( itembundle, 1 );
    }
    
    common_item::function_8d9d36a5c7542cab( 0 );
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x811668e4, Offset: 0x80ce
// Size: 0x14b
function private infected_play_scene( scriptbundlename, scene_root )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( scene_root ) )
    {
        scene_root = { #angles:self.angles, #origin:self.origin };
    }
    
    game_utility::fadetoblackforplayer( self, 1, level.framedurationseconds );
    
    if ( self.sessionstate != "spectator" )
    {
        self setorigin( scene_root.origin );
        self setplayerangles( scene_root.angles ?? ( 0, 0, 0 ) );
    }
    
    thread function_17155c9eec4b6833();
    function_e07b4ada8d132094();
    val::set( #"game_over", "show_hud", 0 );
    val::set( #"game_over", "freezecontrols", 1 );
    self.disabledropondeath = 1;
    function_2ffc9ff578abb765();
    scene::add_scene_func( scriptbundlename, &function_e8b0b9129d4400f9, "callback_play" );
    scene::add_scene_func( scriptbundlename, &function_3a0de8f79d8554ef, "callback_done" );
    function_86e69830b4062c31( "random_zombie_selected", self );
    level thread function_66211dfc41993e50( self, scene_root );
    scene_root scene::function_b95eab90f9ebc981( self );
    scene_root scene::pre_stream_play( 2.5, self, undefined, scriptbundlename );
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xfc7a1d9b, Offset: 0x8221
// Size: 0x48
function private function_66211dfc41993e50( player, scene_root )
{
    scene_root endon( #"scene_completed" );
    player endon( #"scene_completed" );
    player waittill( #"death_or_disconnect" );
    scene_root scene::cleanup( 1 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x9d396989, Offset: 0x8271
// Size: 0x31
function private function_17155c9eec4b6833()
{
    self endon( #"death_or_disconnect" );
    self endon( #"scene_completed" );
    
    for ( ;; )
    {
        self waittill( #"giveloadout" );
        function_e07b4ada8d132094();
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xb1f76a1, Offset: 0x82aa
// Size: 0x46
function private function_e07b4ada8d132094()
{
    operatorref = %"t10_usa_pl_john";
    operatorbundle = getoperatorscriptbundle( operatorref );
    var_2106ff72782c3841 = operatorbundle.defaultskin;
    operator::createoperatorcustomization( operatorref, var_2106ff72782c3841 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x496c3c52, Offset: 0x82f8
// Size: 0xaf
function private function_e8b0b9129d4400f9()
{
    player = undefined;
    entities = scene::get_entities();
    
    foreach ( ent in entities )
    {
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        player = ent;
        break;
    }
    
    wait 0.1;
    game_utility::fadetoblackforplayer( player, 0, 1 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x5277426, Offset: 0x83af
// Size: 0x176
function private function_3a0de8f79d8554ef()
{
    player = undefined;
    entities = scene::get_entities();
    
    foreach ( ent in entities )
    {
        if ( isscriptedai( ent ) )
        {
            if ( ent.magic_bullet_shield )
            {
                ent ai::stop_magic_bullet_shield();
            }
            
            ent.nocorpse = 1;
            ent.var_a13bed1ac47e1b2c = 1;
            ent.death_source = "despawn";
            ent kill();
        }
        
        if ( isplayer( ent ) )
        {
            player = ent;
        }
        
        if ( ent.classname == "script_model" )
        {
            ent delete();
        }
    }
    
    player notify( #"scene_completed" );
    self notify( #"scene_completed" );
    
    /#
        if ( !player val::get( "<dev string:x147>" ) )
        {
            player operator::createoperatorcustomization();
            player val::nuke_all();
            player.disabledropondeath = undefined;
            return;
        }
    #/
    
    player.scene_death = 1;
    player br_spawnrespawn::function_1d2f70d591e967bc();
    player kill();
    player.disabledropondeath = undefined;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x2745dcc4, Offset: 0x852d
// Size: 0x3d
function private function_2ffc9ff578abb765()
{
    self.plotarmor = undefined;
    self setclientomnvar( o"ui_br_infiled", 1 );
    self skydive_setdeploymentstatus( 1 );
    self skydive_setbasejumpingstatus( 1 );
    self clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x6512249e, Offset: 0x8572
// Size: 0x35
function private function_9dd94976f58656ab()
{
    result = { #quickloadout:1, #noextraammo:0, #respawnloadout:build_loadout() };
    return result;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x9fec5794, Offset: 0x85b0
// Size: 0xe9
function private build_loadout()
{
    if ( self.team == "allies" )
    {
        survivorloadout = level.blight_data.survivorloadouts[ get_survivor_loadout_key() ];
        
        if ( level.brgametype.var_2d4806127526d579 == -1 )
        {
            return survivorloadout;
        }
        
        loadout = arraycopy( survivorloadout );
        
        for ( i = 5; i >= level.brgametype.var_2d4806127526d579 ; i-- )
        {
            loadout[ "loadoutPrimaryAttachment" + ( i > 0 ? i : "" ) ] = "none";
            loadout[ "loadoutSecondaryAttachment" + ( i > 0 ? i : "" ) ] = "none";
        }
        
        return loadout;
    }
    
    return level.blight_data.infectedloadout;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x2855fe50, Offset: 0x86a1
// Size: 0x7e
function private get_survivor_loadout_key()
{
    if ( level.brgametype.var_9286479699f5ca9b )
    {
        return level.blight_data.var_1b92ea09b2011c5f;
    }
    
    if ( !isdefined( level.blight_data.survivorloadouts[ self.class ] ) )
    {
        assert( isdefined( level.blight_data.survivorloadouts[ self.class ] ) );
        return;
    }
    
    return self.class;
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x79abd578, Offset: 0x8728
// Size: 0xf3
function private function_6d16c5e59603aa8b( amount )
{
    if ( self.team == "allies" )
    {
        amount = int( amount * level.blight_data.dna_multiplier );
        level.blight_data.dna_sample_count += amount;
        
        if ( level.blight_data.dna_sample_count >= level.blight_data.dna_sample_max && !level.blight_data.finale_triggered )
        {
            level.blight_data.finale_triggered = 1;
            level thread trigger_blight_finale();
        }
        
        function_5d07eb2290abebcf();
    }
    else
    {
        points::doscoreevent( #"hash_cde1b2055c084ad0" );
    }
    
    currency::function_9f4bd7c92079e530( amount, "dna_sample" );
    function_b6781da7ed913abf();
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xee3f085, Offset: 0x8823
// Size: 0x180
function private function_637c8da31eb5180c( survivor_count, infected_count )
{
    multiplier = level.blight_data.var_bdd4992f4669ffa9;
    total_count = survivor_count + infected_count;
    
    if ( total_count <= 0 )
    {
        level.blight_data.dna_multiplier = multiplier;
        return;
    }
    
    survivor_perc = survivor_count * 100 / total_count;
    
    foreach ( entry in level.blight_data.var_bea6d01c509bc044 )
    {
        valid = 0;
        
        switch ( entry.type )
        {
            case #"hash_29d064edbf33703a":
                valid = survivor_perc <= entry.threshold;
                break;
            case #"hash_de7c048858d4d584":
                valid = survivor_count <= entry.threshold;
                break;
        }
        
        if ( valid && entry.multiplier > multiplier )
        {
            multiplier = entry.multiplier;
        }
    }
    
    level.blight_data.dna_multiplier = multiplier;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x46559dfc, Offset: 0x89ab
// Size: 0x24b
function private function_38707ded255ad51a()
{
    level.blight_data.hud = {};
    survivors_hud = newhudelem();
    survivors_hud.x = 10;
    survivors_hud.y = 25;
    survivors_hud.alignx = "left";
    survivors_hud.aligny = "top";
    survivors_hud.vertalign = "fullscreen";
    survivors_hud.horizalign = "fullscreen";
    survivors_hud.font = "smallfixed";
    survivors_hud.fontscale = 0.75;
    survivors_hud.color = ( 0.5, 1, 0.5 );
    survivors_hud settext( &"hash_373df2129444e213" );
    infected_hud = newhudelem();
    infected_hud.x = 10;
    infected_hud.y = 50;
    infected_hud.alignx = "left";
    infected_hud.aligny = "top";
    infected_hud.vertalign = "fullscreen";
    infected_hud.horizalign = "fullscreen";
    infected_hud.font = "smallfixed";
    infected_hud.fontscale = 0.75;
    infected_hud.color = ( 1, 0.5, 0.5 );
    infected_hud settext( &"hash_1b218844072a99ad" );
    label_hud = newhudelem();
    label_hud.x = 10;
    label_hud.y = 75;
    label_hud.alignx = "left";
    label_hud.aligny = "top";
    label_hud.vertalign = "fullscreen";
    label_hud.horizalign = "fullscreen";
    label_hud.font = "smallfixed";
    label_hud.fontscale = 0.75;
    label_hud.color = ( 1, 1, 1 );
    label_hud settext( &"hash_2bafe3582c058111" );
    function_b6781da7ed913abf();
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x7e7e61c0, Offset: 0x8bfe
// Size: 0x5a
function private function_b6781da7ed913abf()
{
    amount = level.blight_data.dna_sample_count;
    var_a159d147b71debfd = level.blight_data.dna_sample_max;
    setomnvar( "ui_main_objective_progress_percentage", int( clamp( amount / var_a159d147b71debfd * 100, 0, 100 ) ) );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xd65c8929, Offset: 0x8c60
// Size: 0x16a
function private trigger_blight_finale()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.blight_data.finale_instance ) )
    {
        level.blight_data.end_game_reason = "no_bomb_end";
        level thread [[ level.endgame ]]( "allies" );
        return;
    }
    
    level notify( #"finale_started" );
    activity_instance_common::function_46135a69bddfec2c( level.blight_data.finale_instance );
    activity_participation::function_fb0ec90aaf6d4c61( level.blight_data.finale_instance, teams::getteamdata( "allies", "players" ) );
    
    if ( level.blight_data.var_f3df3e7851ff02a )
    {
        foreach ( instance in level.blight_data.var_300d6f8744c75f9c )
        {
            if ( activity_instance_common::getactivitystate( instance ) == "Active" )
            {
                activity_instance_common::endactivity( instance, 0 );
            }
        }
    }
    
    level waittill( #"finale_bomb_armed" );
    music_br::function_800a641abdbdca63( #"br_circle_close_final" );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xf8ff061d, Offset: 0x8dd2
// Size: 0x37
function private function_bb5870a6bfcb1d90( relevant_info_struct )
{
    level.blight_data.end_game_reason = "bomb_exploded";
    level thread [[ level.endgame ]]( "allies" );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x12f19ab9, Offset: 0x8e11
// Size: 0x37
function private function_6408b1de541e8fd1( relevant_info_struct )
{
    level.blight_data.end_game_reason = "bomb_destroyed";
    level thread [[ level.endgame ]]( "axis" );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0xc
// Checksum 0xe4083a10, Offset: 0x8e50
// Size: 0x347
function private zombie_tier_start( immediate = 0 )
{
    self notify( #"hash_d2294e427e3dd038" );
    self endon( #"hash_d2294e427e3dd038" );
    level endon( #"game_ended" );
    self endon( #"zombie_unset" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.var_ecb816c18201341f ) )
    {
        self.var_ecb816c18201341f = { #tiersgranted:0, #var_3a859dd63e87bd56:0, #elapsedms:0 };
    }
    
    if ( !immediate )
    {
        self waittill( #"bpz_activated" );
        var_93754e7ee4a1bb07 = function_1df0da80cb0b2e8();
        var_45767ee012da78a0 = function_aa7c4abc05c82f0();
        catchup_tier = maxint( var_93754e7ee4a1bb07, var_45767ee012da78a0 );
        
        if ( catchup_tier > self.var_ecb816c18201341f.tiersgranted )
        {
            self.var_ecb816c18201341f.tiersgranted = catchup_tier;
        }
        
        for ( i = 0; i <= self.var_ecb816c18201341f.tiersgranted ; i++ )
        {
            namespace_69e3a436b5d8370e::function_323d8c9159939a6d( i );
            function_3556c75bf083cb03( i );
        }
    }
    else
    {
        namespace_69e3a436b5d8370e::function_323d8c9159939a6d( self.var_ecb816c18201341f.tiersgranted );
        function_3556c75bf083cb03( self.var_ecb816c18201341f.tiersgranted );
    }
    
    var_1dd7d171ec645a72 = level.brgametype.var_641e0cf69a87e2ba;
    
    if ( self.var_ecb816c18201341f.tiersgranted >= var_1dd7d171ec645a72 )
    {
        self setclientomnvar( o"hash_90880b30052eb780", 0 );
        return;
    }
    
    interval_ms = level.brgametype.var_6648f001bf5c77a2 * 1000;
    var_22f910ddeefe0445 = ( self.var_ecb816c18201341f.tiersgranted + 1 ) * interval_ms;
    var_75c0f406111e9648 = 0;
    self setclientomnvar( o"hash_90880b30052eb780", 1 );
    
    while ( self.var_ecb816c18201341f.tiersgranted < var_1dd7d171ec645a72 )
    {
        waitframe();
        self.var_ecb816c18201341f.elapsedms += level.frameduration;
        effective_elapsed = self.var_ecb816c18201341f.elapsedms + self.var_ecb816c18201341f.var_3a859dd63e87bd56;
        self setclientomnvar( o"hash_cd934a49066f02dc", ( effective_elapsed - var_75c0f406111e9648 ) / ( var_22f910ddeefe0445 - var_75c0f406111e9648 ) );
        
        if ( effective_elapsed >= var_22f910ddeefe0445 )
        {
            self.var_ecb816c18201341f.tiersgranted++;
            namespace_69e3a436b5d8370e::function_323d8c9159939a6d( self.var_ecb816c18201341f.tiersgranted );
            function_3556c75bf083cb03( self.var_ecb816c18201341f.tiersgranted );
            var_75c0f406111e9648 = var_22f910ddeefe0445;
            var_22f910ddeefe0445 = ( self.var_ecb816c18201341f.tiersgranted + 1 ) * interval_ms;
            function_86e69830b4062c31( "zombie_powers_upgraded", self, 1 );
            util_show_splash( "zombie_upgrade", self );
        }
    }
    
    self setclientomnvar( o"hash_90880b30052eb780", 0 );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xb8b851b8, Offset: 0x919f
// Size: 0x72
function private function_2718073dd0301bf1( seconds )
{
    if ( !isdefined( self.var_ecb816c18201341f ) )
    {
        self.var_ecb816c18201341f = { #tiersgranted:0, #var_3a859dd63e87bd56:0, #elapsedms:0 };
    }
    
    self.var_ecb816c18201341f.var_3a859dd63e87bd56 += int( seconds * 1000 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x280d446f, Offset: 0x9219
// Size: 0x81
function private function_1df0da80cb0b2e8()
{
    if ( !isdefined( level.blight_data.var_26dc92ca3c027a03 ) )
    {
        return 0;
    }
    
    elapsed_ms = gettime() - level.blight_data.var_26dc92ca3c027a03;
    interval_ms = level.brgametype.var_ca4eee2c3590b638 * 1000;
    return clampint( int( elapsed_ms / interval_ms ), 0, level.brgametype.var_641e0cf69a87e2ba );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x2e742d82, Offset: 0x92a3
// Size: 0x2e
function private function_aa7c4abc05c82f0()
{
    return clampint( int( ceil( self.survivor_tier / 2 ) ), 0, level.brgametype.var_641e0cf69a87e2ba );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x87ec538e, Offset: 0x92da
// Size: 0x111
function private function_3556c75bf083cb03( tier )
{
    profilestart();
    
    switch ( tier )
    {
        case 0:
            ability_manager::assign_ability( "guts_throw", "tactical" );
            break;
        case 1:
            ability_manager::assign_ability( "emp_blast", "lethal" );
            break;
        case 2:
            br_player_zombie::set_movespeed( 1.2 );
            perk::giveperk( "specialty_walljump_buffed" );
            break;
        case 3:
            ability_manager::assign_ability( "power_jump", "ads" );
            break;
        case 4:
            self.maxhealth += 150;
            self.health = self.maxhealth;
            break;
        case 5:
            thread br_player_zombie::set_radar();
            thread br_player_zombie::set_heatmap_radar();
            self setclientomnvar( o"hash_cd934a49066f02dc", 0 );
            break;
        default:
            break;
    }
    
    profilestop();
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xb8b76c3a, Offset: 0x93f3
// Size: 0x86
function private on_player_score_given( params )
{
    tier_value = function_589b2d3d02d0d41a( params.event, params.points, self.team );
    function_d7888ed91d2016b5( params, tier_value );
    
    if ( self.team == "allies" )
    {
        function_30c220d4f5fe66b5( tier_value );
        return;
    }
    
    if ( self.team == "axis" )
    {
        function_2718073dd0301bf1( tier_value * 0.001 );
    }
}

// Namespace br_gametype_blight
// Params 3, eflags: 0x4
// Checksum 0x895056f5, Offset: 0x9481
// Size: 0x62
function private function_589b2d3d02d0d41a( event, points, team )
{
    if ( team == "axis" )
    {
        switch ( event )
        {
            case #"elimination_melee":
                points = 300;
                break;
            default:
                break;
        }
        
        return ( points * 100 );
    }
    
    return points;
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x3c066d3d, Offset: 0x94eb
// Size: 0x137
function private function_9ec71f1b6a661608( tier, do_notify = 0 )
{
    if ( level.brgametype.var_97ef3254270cf0b3[ tier ] )
    {
        thread function_d51cbc351210c949( get_survivor_loadout_key(), tier );
        
        if ( do_notify )
        {
            function_86e69830b4062c31( "survivor_weapon_upgraded", self, 1 );
            util_show_splash( "human_upgrade", self );
        }
    }
    else
    {
        switch ( tier )
        {
            case 3:
                armor_satchel = spawnscriptable( %"brloot_satchel_armor", ( 0, 0, 0 ) );
                common_item::function_2b5e2ff57d5f392( armor_satchel );
                break;
            case 5:
                self.maxhealth += 50;
                self.health = self.maxhealth;
                self setclientomnvar( o"hash_cd934a49066f02dc", 0 );
                break;
        }
    }
    
    if ( tier >= level.brgametype.var_641e0cf69a87e2ba )
    {
        self setclientomnvar( o"hash_90880b30052eb780", 0 );
        return;
    }
    
    self setclientomnvar( o"hash_90880b30052eb780", 1 );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x353453c6, Offset: 0x962a
// Size: 0xdf
function private function_30c220d4f5fe66b5( amount )
{
    if ( !isdefined( self.blightscorepoints ) )
    {
        self.blightscorepoints = 0;
    }
    
    self.blightscorepoints += amount;
    var_5f8f38c773b1e60a = self.blightscorepoints / level.brgametype.var_8854b2d070c2e9d8;
    self setclientomnvar( o"hash_cd934a49066f02dc", var_5f8f38c773b1e60a - int( var_5f8f38c773b1e60a ) );
    tiers_earned = int( self.blightscorepoints / level.brgametype.var_8854b2d070c2e9d8 );
    var_c9cab7dd509d679c = namespace_69e3a436b5d8370e::function_c6facc0238baaa44() + 1;
    newtiers = tiers_earned - var_c9cab7dd509d679c;
    
    if ( newtiers > 0 )
    {
        namespace_69e3a436b5d8370e::function_5522ec1a2a1200a5( newtiers );
        function_9ec71f1b6a661608( tiers_earned, 1 );
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x4536ab6e, Offset: 0x9711
// Size: 0x140
function private function_1a55252685d6a95e()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait level.blight_data.var_8395a0d335e96d8d;
        humans = teams::getteamdata( "allies", "players" );
        infected = teams::getteamdata( "axis", "players" );
        
        if ( !humans.size )
        {
            return;
        }
        
        total_count = humans.size + infected.size;
        survival_event = #"hash_d663d3fef961336f";
        
        if ( total_count > 0 )
        {
            human_percentage = humans.size * 100 / total_count;
            
            if ( human_percentage <= 25 )
            {
                survival_event = #"hash_7d3a0243b85d8a21";
            }
            else if ( human_percentage <= 50 )
            {
                survival_event = #"hash_cd69bdeb2e1cde65";
            }
        }
        
        foreach ( human in humans )
        {
            human points::doscoreevent( survival_event );
        }
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x9e9a13b0, Offset: 0x9859
// Size: 0xc6
function private function_d7888ed91d2016b5( params, tier_value )
{
    if ( !getdvarint( @"hash_22b5fcb0eb096e0e", 1 ) )
    {
        return;
    }
    
    if ( isbot( self ) || !gameplay_telemetry_utils::function_f78eef1203724422() )
    {
        return;
    }
    
    if ( !isdefined( self.var_4bfabe2338b216d8 ) )
    {
        self.var_4bfabe2338b216d8 = [];
    }
    
    logentry = { #time:gettime(), #spm:gameplay_telemetry_utils::function_8f71c8ffb480ebc3(), #tiervalue:tier_value, #points:params.points, #event:params.event };
    self.var_4bfabe2338b216d8[ self.var_4bfabe2338b216d8.size ] = logentry;
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xc84b942a, Offset: 0x9927
// Size: 0x1cf
function private function_e350c0052f866283( reason )
{
    if ( !isdefined( self.var_4bfabe2338b216d8 ) || self.var_4bfabe2338b216d8.size == 0 )
    {
        return;
    }
    
    total = 0;
    
    foreach ( logentry in self.var_4bfabe2338b216d8 )
    {
        total += logentry.points;
    }
    
    logstring( "[BLIGHT_SCORE_TIMELINE] player=" + self.name + " reason=" + reason + " time=" + gettime() + " eventCount=" + self.var_4bfabe2338b216d8.size + " totalPoints=" + total );
    
    foreach ( index, logentry in self.var_4bfabe2338b216d8 )
    {
        logstring( "[BLIGHT_SCORE_TIMELINE]   [" + index + "] time=" + logentry.time + " event=" + logentry.event + " points=" + logentry.points + " tierValue=" + logentry.tiervalue + " spm=" + logentry.spm );
    }
    
    self.var_4bfabe2338b216d8 = [];
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xbdf823fd, Offset: 0x9afe
// Size: 0x8d
function private function_cd3f04e1b0ac352b()
{
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player function_e350c0052f866283( "match_end" );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x23f61d31, Offset: 0x9b93
// Size: 0x76
function private on_player_damaged( params )
{
    if ( isplayer( params.eattacker ) && params.eattacker.team == "axis" )
    {
        if ( params.einflictor.equipmentref == "equip_guts" )
        {
            params.eattacker thread points::doscoreevent( #"guts_impact" );
        }
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x17d20d92, Offset: 0x9c11
// Size: 0x1c6
function private init_public_events()
{
    level.blight_data.public_events = [ "restock":{ #bundle:%"hash_7d173dd584d84174", #variant:"restock_default", #type:"BR_PUBLIC_EVENT_RESTOCK" }, "crate_drop":{ #bundle:%"hash_38c8625c49d2717c", #variant:"crate_drop_default", #type:"BLIGHT_CRATE_DROP" } ];
    
    foreach ( event in level.blight_data.public_events )
    {
        activity_definition_utils::function_74af1ab4059e3c06( event.bundle, event.variant );
    }
    
    level.blight_data.var_8e0961f85fb2cc94 = [ { #time:90, #ref:"crate_drop" }, { #time:180, #ref:"restock" }, { #time:270, #ref:"crate_drop" }, { #time:450, #ref:"restock" }, { #time:510, #ref:"crate_drop" } ];
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xa3c48a75, Offset: 0x9ddf
// Size: 0xe4
function private function_2503658c1f77908c()
{
    level endon( #"game_ended" );
    level endon( #"finale_started" );
    elapsed = 0;
    
    foreach ( event in level.blight_data.var_8e0961f85fb2cc94 )
    {
        delay = event.time - elapsed;
        
        if ( delay > 0 )
        {
            wait delay;
        }
        
        elapsed = event.time;
        spawn_public_event( event.ref );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x735691ca, Offset: 0x9ecb
// Size: 0x53
function private spawn_public_event( ref )
{
    activity_instance_common::createactivityinstance( level.blight_data.public_events[ ref ].type, level.blight_data.public_events[ ref ].variant );
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x2c55349d, Offset: 0x9f26
// Size: 0xe
function private function_1e8637e9de8e144c( isfirstactivation )
{
    profilestart();
    profilestop();
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xa36d2381, Offset: 0x9f3c
// Size: 0xeb
function private function_37eb1543bf6a4acd( crate )
{
    retval = br::br_selectdropbagclass( crate );
    
    if ( !retval )
    {
        return;
    }
    
    utility::callsharedfunc( #"br", #"superslotcleanup" );
    br::br_giveselectedclass( self, 0, 0 );
    
    if ( !isdefined( self.survivor_tier ) )
    {
        self.survivor_tier = 0;
    }
    
    if ( self.survivor_tier < level.brgametype.var_14218428ebed4a75 )
    {
        self.survivor_tier++;
    }
    
    index = class::getclassindex( self.class );
    key = menus::getclasschoice( 100 + index );
    thread function_d51cbc351210c949( key, self.survivor_tier );
    
    if ( crate.obj_id )
    {
        objidpoolmanager::objective_playermask_hidefrom( crate.obj_id, self );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x3f52b3f6, Offset: 0xa02f
// Size: 0x34
function private function_be47d6fad7ac5a99( immediate )
{
    profilestart();
    
    if ( self.obj_id )
    {
        objidpoolmanager::returnobjectiveid( self.obj_id );
        self.obj_id = undefined;
    }
    
    profilestop();
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x90ec59f8, Offset: 0xa06b
// Size: 0xf3
function private function_9449b795b43ccbe0( crate )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        objidpoolmanager::objective_add_objective( objid, "current", crate.origin, "ui_mp_br_mapmenu_icon_boss_chopper_event_dropbox" );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
        objidpoolmanager::update_objective_onentity( objid, crate );
        objidpoolmanager::update_objective_setzoffset( objid, 75 );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        objidpoolmanager::objective_showdistance( objid, 1 );
        objidpoolmanager::function_373aaf492aabde6f( objid, 255, 198, 0, 1 );
        function_24edb8a97f6832f0( objid, 1 );
        function_8eab38514b79538d( objid, 2000 );
        objidpoolmanager::update_objective_description( objid, &"MP_INGAME_ONLY/SUPPLY_CRATE_CAPS" );
        objidpoolmanager::update_objective_setneutrallabel( objid, &"MP_INGAME_ONLY/SUPPLY_CRATE_CAPS" );
        objidpoolmanager::function_19410dd520bff519( objid, "allies" );
        crate.obj_id = objid;
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x8b43dd7a, Offset: 0xa166
// Size: 0x5d
function private function_d51cbc351210c949( key, tier )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.survivor_tier = tier;
    function_a8f3497a1feba61( level.blight_data.survivorloadouts[ key ], tier );
    thread flash_weapon_info();
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xa4393dbb, Offset: 0xa1cb
// Size: 0x2a
function private flash_weapon_info()
{
    self endon( #"disconnect" );
    self setclientomnvar( "ui_show_current_weapon_info", 1 );
    wait 1;
    self setclientomnvar( "ui_show_current_weapon_info", 0 );
}

// Namespace br_gametype_blight
// Params 2, eflags: 0xc
// Checksum 0x6e337300, Offset: 0xa1fd
// Size: 0x325
function private function_a8f3497a1feba61( survivorloadout, tier = -1 )
{
    self notify( #"hash_a4aadce135981ba5" );
    self endon( #"hash_a4aadce135981ba5" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_408522e3869135b = level.brgametype.var_97ef3254270cf0b3[ tier ];
    
    if ( !var_408522e3869135b )
    {
        return;
    }
    
    while ( !can_weapon_upgrade() )
    {
        waitframe();
    }
    
    firstweapon = item_weapon::function_80e13ca8b843fd9e();
    secondweapon = item_weapon::function_7e6b6d717dfe28d8();
    
    foreach ( weapon in [ secondweapon, firstweapon ] )
    {
        if ( weapon.basename == survivorloadout[ "loadoutPrimary" ] + "_mp" )
        {
            loadoutattachments = [ survivorloadout[ "loadoutPrimaryAttachment" ], survivorloadout[ "loadoutPrimaryAttachment1" ], survivorloadout[ "loadoutPrimaryAttachment2" ], survivorloadout[ "loadoutPrimaryAttachment3" ], survivorloadout[ "loadoutPrimaryAttachment4" ] ];
            weapon_name = survivorloadout[ "loadoutPrimary" ];
        }
        else
        {
            loadoutattachments = [ survivorloadout[ "loadoutSecondaryAttachment" ], survivorloadout[ "loadoutSecondaryAttachment1" ], survivorloadout[ "loadoutSecondaryAttachment2" ], survivorloadout[ "loadoutSecondaryAttachment3" ], survivorloadout[ "loadoutSecondaryAttachment4" ] ];
            weapon_name = survivorloadout[ "loadoutSecondary" ];
        }
        
        loadoutattachments = arrayremove( loadoutattachments, "none" );
        
        /#
            foreach ( attachment in loadoutattachments )
            {
                assert( weapon::attachmentisselectable( weapon_name, attachment ) );
            }
        #/
        
        if ( loadoutattachments.size > 0 )
        {
            giveattachments = utility::array_slice( loadoutattachments, 0, var_408522e3869135b );
        }
        
        switch ( tier )
        {
            case 2:
                camo = "sat_camo_pap_firefly_02";
                var_e9ca9da4b737395 = level.weaponmetadata[ weapon.var_1616e6fbba9a722d ].var_6ec5e9b28d8ba1f4;
                break;
            case 4:
                camo = "sat_camo_pap_firefly_03";
                var_e9ca9da4b737395 = level.weaponmetadata[ weapon.var_1616e6fbba9a722d ].var_c5e9a849426045ca;
                break;
        }
        
        if ( var_e9ca9da4b737395 )
        {
            arrayinsert( giveattachments, var_e9ca9da4b737395, 0 );
        }
        
        newweaponobj = weapon::buildweapon( weapon_name, giveattachments, camo );
        function_8a51e33a51dcbeeb( weapon, newweaponobj );
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xf00d2a77, Offset: 0xa52a
// Size: 0xc3
function private function_8a51e33a51dcbeeb( weapon, var_ab3d86fd09bad221 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_1dd5fd3c089a62d8 = self isalternatemode( weapon ) && weapons::shouldweaponsavealtstate( weapon );
    removeparams = { #weapon:weapon, #var_5156a93210ad2807:1, #dontdrop:1 };
    item_weapon::items_weapon_removeweapon( removeparams );
    item_weapon::function_96add18b226ff731( var_ab3d86fd09bad221, 1, undefined, 1 );
    item_weapon::function_165956c3013b4abf( var_ab3d86fd09bad221 );
    
    if ( var_1dd5fd3c089a62d8 && var_ab3d86fd09bad221.hasalternate )
    {
        self setalternatemode( var_ab3d86fd09bad221, 1 );
    }
    
    item_ammo::function_46e5ccf39665fcf4( weapon, 0, 0, 1 );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xc0f654e4, Offset: 0xa5f5
// Size: 0x17e
function private human_infil_camera()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    val::set( #"human_infil", "show_hud", 0 );
    val::set( #"human_infil", "freezecontrols", 1 );
    self setcamerathirdperson( 1 );
    var_9351ed0421033dac = self.origin + ( 0, 0, 1000 );
    camera = utility::function_1808878d1c511ce8( var_9351ed0421033dac, ( 90, self.angles[ 1 ], 0 ) );
    self startcameratween( 0.2, 0 );
    self cameralinkto( camera, "tag_origin", 1, 1 );
    self waittill( #"hash_88b506e95217aeab" );
    self playsoundevent( "manticore_s6_blight_camera_fade_up" );
    thread gameobjects::forceunsetdemeanor( 1 );
    target_angles = self getplayerangles();
    shoulder_pos = self geteye() + rotatevector( ( -85, -17, 11 ), target_angles );
    camera moveto( shoulder_pos, 2, 1, 1 );
    wait 1;
    camera rotateto( target_angles, 1, 0.9, 0.1 );
    camera waittill( #"movedone" );
    wait 0.1;
    self cameraunlink();
    self setcamerathirdperson( 0 );
    camera delete();
    wait 0.5;
    thread gameobjects::forceunsetdemeanor( 0 );
    val::reset_all( #"human_infil" );
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xd9beef76, Offset: 0xa77b
// Size: 0xfa, Type: bool
function private can_weapon_upgrade()
{
    can_use = common_item::function_c6f3ef3dcb4c55c0( "weapon", #"hash_9e49dfaa7c147654" );
    
    if ( !self [[ can_use ]]() )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( self ismantling() || self ishanging() )
    {
        return false;
    }
    
    if ( self isonzipline() || self isonascender() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self ismeatshieldactive() )
    {
        return false;
    }
    
    if ( !self isweaponsenabled() )
    {
        return false;
    }
    
    if ( self function_c14b349706b01c1b() || self function_a6d700f2335edc93() )
    {
        return false;
    }
    
    if ( self isskydiving() || self isinfreefall() || self isparachuting() )
    {
        return false;
    }
    
    if ( supers_mp::issuperinuse( #"default" ) || supers_mp::function_f863d9ef10bf403f( #"default" ) || supers_mp::function_ec7e2ab9a462557b() )
    {
        return false;
    }
    
    if ( self function_5616aa6e4686fae5() || self isthrowinggrenade() || self isthrowingbackgrenade() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gametype_blight
// Params 3, eflags: 0x4
// Checksum 0x44070dec, Offset: 0xa87e
// Size: 0x2a
function private util_show_splash( splash_ref, target, delay )
{
    level thread function_756df6fe031c3b34( splash_ref, target, delay );
}

// Namespace br_gametype_blight
// Params 3, eflags: 0x4
// Checksum 0x9d128c0, Offset: 0xa8b0
// Size: 0xff
function private function_756df6fe031c3b34( splash_ref, target, delay )
{
    level endon( #"game_ended" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( isplayer( target ) )
    {
        target thread hud_message::showsplash( splash_ref, undefined, undefined, undefined, undefined, "saw_blight_splashlist" );
        return;
    }
    
    targets = undefined;
    
    if ( isstring( target ) )
    {
        targets = teams::getteamdata( target, "players" );
    }
    else if ( isarray( target ) )
    {
        targets = target;
    }
    
    if ( !targets )
    {
        return;
    }
    
    foreach ( target in targets )
    {
        target thread hud_message::showsplash( splash_ref, undefined, undefined, undefined, undefined, "saw_blight_splashlist" );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xe2ae6b0a, Offset: 0xa9b7
// Size: 0xa7
function private final_survivor_sequence( player )
{
    utility::flag_set( "final_survivor" );
    instance = { #var_ca369031b554da2f:player };
    instance final_survivor_icon();
    instance namespace_4aabd2c8a4353c13::function_37e7688019b2a3e2( player );
    
    if ( !player killstreak::isjuggernaut() )
    {
        item = spawnscriptable( %"brloot_perk_specialist_saw", ( 0, 0, 0 ) );
        player common_item::function_2b5e2ff57d5f392( item );
    }
    
    player thread points::doscoreevent( #"final_survivor" );
    level thread hud_util::teamplayercardsplash( "callout_final_survivor", player );
    player thread final_survivor_max_tier();
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xc5e486f1, Offset: 0xaa66
// Size: 0x31
function private final_survivor_icon()
{
    br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active" );
    objective_disableping( self.objectiveiconid, 1 );
    final_survivor_visibility();
    thread final_survivor_update_icon();
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xfd66a5a4, Offset: 0xaa9f
// Size: 0x94
function private final_survivor_visibility()
{
    show_to = arrayremove( level.players, self.var_ca369031b554da2f );
    
    foreach ( player in show_to )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x633a6eea, Offset: 0xab3b
// Size: 0x44
function private final_survivor_update_icon()
{
    self.var_ca369031b554da2f endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 5;
        objidpoolmanager::update_objective_position( self.objectiveiconid, self.var_ca369031b554da2f.origin );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0xce375035, Offset: 0xab87
// Size: 0x6f, Type: bool
function private function_b7ec978fe92352af( candidate )
{
    if ( outofbounds::ispointinoutofbounds( candidate ) )
    {
        return false;
    }
    
    if ( !br_c130::ispointinbounds( candidate, 1 ) )
    {
        return false;
    }
    
    if ( br_circle::_ispointinbadarea( candidate ) )
    {
        return false;
    }
    
    if ( !utility::function_d9f2bbbeb0e054b8( candidate + ( 0, 0, 50 ) ) )
    {
        return false;
    }
    
    if ( utility::ispointinwater( candidate - ( 0, 0, 32 ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0xb845ecce, Offset: 0xabff
// Size: 0x79
function private function_e6de5f4315812e8c( candidate, var_66539d73ab258ad8 )
{
    blocked_dirs = [];
    yaw = 0;
    
    while ( yaw < 360 )
    {
        dir = anglestoforward( ( 0, yaw, 0 ) );
        probe = candidate + dir * var_66539d73ab258ad8;
        
        if ( !br_c130::ispointinbounds( probe, 0 ) )
        {
            blocked_dirs[ blocked_dirs.size ] = dir;
        }
        
        yaw += 45;
    }
    
    return blocked_dirs;
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x1dfdcf9e, Offset: 0xac81
// Size: 0x1b6
function private function_bc7d56b587af8045( candidate, inward_ref )
{
    var_66539d73ab258ad8 = getdvarfloat( @"hash_958b0b3783d02ae7", 1024 );
    iterations = getdvarint( @"hash_f9656d2f23f974fc", 3 );
    
    for ( i = 0; i < iterations ; i++ )
    {
        blocked_dirs = function_e6de5f4315812e8c( candidate, var_66539d73ab258ad8 );
        
        if ( blocked_dirs.size == 0 )
        {
            return candidate;
        }
        
        push = ( 0, 0, 0 );
        
        foreach ( dir in blocked_dirs )
        {
            push -= dir;
        }
        
        if ( lengthsquared( push ) < 0.01 )
        {
            fallback_target = inward_ref ?? level.br_level.br_mapcenter ?? ( 0, 0, 0 );
            push = fallback_target - candidate;
        }
        
        push = vectornormalize( push );
        var_16a098908f045fa7 = getclosestpointonnavmesh( candidate + push * var_66539d73ab258ad8 );
        
        if ( distance2dsquared( var_16a098908f045fa7, candidate ) < 1 )
        {
            return;
        }
        
        /#
            line( candidate, var_16a098908f045fa7, ( 1, 0.5, 0 ), 1, 0, int( 10 / level.framedurationseconds ) );
        #/
        
        candidate = var_16a098908f045fa7;
    }
    
    if ( function_e6de5f4315812e8c( candidate, var_66539d73ab258ad8 ).size > 0 )
    {
        return;
    }
    
    return candidate;
}

// Namespace br_gametype_blight
// Params 3, eflags: 0x4
// Checksum 0x91012e18, Offset: 0xae40
// Size: 0xa9
function private function_aef47d9dd0a162e0( point, radius, sample_count )
{
    candidates = [];
    
    for ( i = 0; i < sample_count ; i++ )
    {
        yaw = randomfloatrange( 0, 360 );
        direction = anglestoforward( ( 0, yaw, 0 ) );
        candidate = getclosestpointonnavmesh( point + direction * radius );
        candidate = function_bc7d56b587af8045( candidate, point );
        
        if ( !isdefined( candidate ) )
        {
            continue;
        }
        
        if ( !function_b7ec978fe92352af( candidate ) )
        {
            continue;
        }
        
        candidates[ candidates.size ] = candidate;
    }
    
    return candidates;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x1de0c038, Offset: 0xaef2
// Size: 0xcd
function private get_prematch_spawn_point()
{
    loc = utility::array_random( level.prematchspawnorigins );
    radius = randomfloatrange( loc.minradius, loc.radius );
    angles = ( getdvarfloat( @"hash_d6f7a211c05b441f", 75 ), randomintrange( 0, 360 ), 0 );
    offset = anglestoforward( angles ) * -1;
    origin = loc.origin + offset * radius;
    spawnpoint = { #index:-1, #forceangles:1, #angles:angles, #origin:origin };
    return spawnpoint;
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0xd5cd1b28, Offset: 0xafc8
// Size: 0x125
function private get_zombie_spawn_origin()
{
    if ( !getdvarint( @"hash_a8ccd64d95090cc1", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( self.lastdeathpos ) )
    {
        return;
    }
    
    radius = getdvarint( @"hash_340bea1e8845b61b", 8000 );
    sample_count = getdvarint( @"hash_a4c229c0dbeb0887", 8 );
    candidates = function_aef47d9dd0a162e0( self.lastdeathpos, radius, sample_count );
    
    if ( candidates.size == 0 )
    {
        return;
    }
    
    [ best_origin ] = function_9a4ee51bfbb6efd5( candidates );
    scalar = getdvarfloat( @"hash_350b715e957e177a", 0.75 );
    height_offset = int( parachute::getc130height() * scalar );
    spawn_offset = ( 0, 0, height_offset );
    origin = br::getoffsetspawnoriginmultitrace( best_origin, spawn_offset );
    angles = br_spawnrespawn::function_46f3bef64ca7cfca( origin, self.lastdeathpos );
    return { #angles:angles, #origin:origin };
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x8cfdb350, Offset: 0xb0f6
// Size: 0xc1
function private function_9a4ee51bfbb6efd5( candidates )
{
    best_origin = undefined;
    best_influence = undefined;
    
    foreach ( candidate in candidates )
    {
        influence = getplayerinfluenceatposition( candidate, 1 );
        
        if ( !isdefined( best_influence ) || influence < best_influence )
        {
            best_influence = influence;
            best_origin = candidate;
        }
    }
    
    return [ best_origin, best_influence ];
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x7027bbea, Offset: 0xb1c0
// Size: 0x51
function private final_survivor_max_tier()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    curr_tier = namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
    
    while ( curr_tier < 5 )
    {
        namespace_69e3a436b5d8370e::function_5522ec1a2a1200a5( 1 );
        curr_tier = namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
        function_9ec71f1b6a661608( curr_tier );
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x6ac2226e, Offset: 0xb219
// Size: 0x79
function private function_d916bae096e090d5( params )
{
    if ( params.time_left > 0 )
    {
        smoke_end_time = gettime() + utility::function_4b74c15943231980( params.time_left );
        
        if ( !isdefined( self.smoke_end_time ) )
        {
            self.smoke_end_time = smoke_end_time;
            thread function_a8cb0626ab4cd31c();
            return;
        }
        
        self.smoke_end_time = max( self.smoke_end_time, smoke_end_time );
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x242b0faa, Offset: 0xb29a
// Size: 0x93
function private function_a8cb0626ab4cd31c()
{
    self endon( #"disconnect" );
    
    while ( isalive( self ) && gettime() < self.smoke_end_time )
    {
        zombiearray = getaiarrayinradius( self.origin, 60, "axis" );
        noenemynearby = zombiearray.size == 0;
        val::set( "smokegrenade", "ignoreme", noenemynearby );
        wait 0.5;
    }
    
    self.smoke_kills = 0;
    val::reset_all( "smokegrenade" );
    self.smoke_end_time = undefined;
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x92b0baec, Offset: 0xb335
// Size: 0x2a
function private function_4d1e80e942b6cc06( params )
{
    if ( !isdefined( self.perks[ "specialty_blindeye" ] ) )
    {
        self.smoke_end_time = undefined;
    }
}

// Namespace br_gametype_blight
// Params 1, eflags: 0x4
// Checksum 0x4b6b3267, Offset: 0xb367
// Size: 0x13b
function private function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, undefined, &function_a92d75a1117625fc, 0, self.team, 1 );
    grenade thread function_7de4ee6d3709aa7f();
    var_4bc2dcb755f719f6 = getaiarrayinradius( grenade.origin, grenade.tableinfo.bundle.var_ca694ff612181976 );
    
    foreach ( ai in var_4bc2dcb755f719f6 )
    {
        ai aieventlistenerevent( "decoy_grenade", grenade, grenade.origin );
    }
}

// Namespace br_gametype_blight
// Params 0, eflags: 0x4
// Checksum 0x5aca9f25, Offset: 0xb4aa
// Size: 0x2c
function private function_7de4ee6d3709aa7f()
{
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
}

// Namespace br_gametype_blight
// Params 2, eflags: 0x4
// Checksum 0x1879c622, Offset: 0xb4de
// Size: 0x26, Type: bool
function private function_a92d75a1117625fc( attractor, ai )
{
    return ai.aicategory == "normal";
}

/#

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x562a43d, Offset: 0xb50d
    // Size: 0x66c, Type: dev
    function private init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x14d>" );
        devgui::add_devgui_func( "<dev string:x155>", "<dev string:x167>", &debug_respawn_as_zombie );
        devgui::add_devgui_func( "<dev string:x180>", "<dev string:x19a>", &function_511b948018473702 );
        devgui::add_devgui_func( "<dev string:x1b2>", "<dev string:x1cb>", &function_2adb9dbbc5ff3ff1 );
        devgui::add_devgui_func( "<dev string:x1e9>", "<dev string:x21a>", &function_be1f718c2d0d7d4f );
        devgui::add_devgui_func( "<dev string:x247>", "<dev string:x278>", &function_f90dc9a073fcd9a4 );
        devgui::add_devgui_func( "<dev string:x2a7>", "<dev string:x2c3>", &function_deea71709f4d2c8f );
        devgui::add_devgui_func( "<dev string:x2e6>", "<dev string:x302>", &function_e8724156ec2f6954 );
        devgui::add_devgui_func( "<dev string:x325>", "<dev string:x336>", &function_84c56b031124e4c5 );
        devgui::add_devgui_func( "<dev string:x34e>", "<dev string:x367>", &function_42c231f1d407349 );
        devgui::add_devgui_func( "<dev string:x37e>", "<dev string:x396>", &function_196e203673490108 );
        devgui::add_devgui_func( "<dev string:x3b3>", "<dev string:x3ce>", &function_a0aedef46184d7d7 );
        devgui::add_devgui_func( "<dev string:x3ee>", "<dev string:x409>", &function_85f0b4512cf707e3 );
        devgui::add_devgui_func( "<dev string:x426>", "<dev string:x444>", &function_64c4da7b21ced155 );
        devgui::add_devgui_func( "<dev string:x46f>", "<dev string:x484>", &function_1dbdf1765a499853 );
        devgui::add_devgui_func( "<dev string:x4a0>", "<dev string:x4b5>", &function_1000900547a4d76e );
        devgui::add_devgui_func( "<dev string:x4d1>", "<dev string:x4e9>", &function_4e33a986b5815f24 );
        devgui::add_devgui_func( "<dev string:x513>", "<dev string:x52c>", &function_e2c8a99f1592bc00 );
        
        foreach ( key, val in level.blight_data.infectedloadouts )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x550>" + key, "<dev string:x560>" + "<dev string:x570>" + "<dev string:x575>" + key, &debug_give_loadout );
        }
        
        var_2a88723414227592 = 0;
        
        foreach ( key, val in level.blight_data.survivorloadouts )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x577>" + key + "<dev string:x586>", "<dev string:x592>" + key + "<dev string:x575>" + var_2a88723414227592, &function_6948ba8b19d99f5d );
            
            foreach ( tier, _ in level.brgametype.var_97ef3254270cf0b3 )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x577>" + key + "<dev string:x5a9>" + tier, "<dev string:x5b4>" + key + "<dev string:x575>" + var_2a88723414227592 + "<dev string:x575>" + tier, &function_782a48465afc06da );
            }
            
            var_2a88723414227592++;
        }
        
        devgui::add_devgui_func( "<dev string:x5ca>", "<dev string:x5dd>", &function_d64799ee5e7fb308 );
        setdevdvarifuninitialized( @"hash_a27ff17573099185", 100, 1, 10000 );
        devgui::add_devgui_dvar( "<dev string:x5f7>", "<dev string:x602>" );
        devgui::add_devgui_func( "<dev string:x621>", "<dev string:x634>", &function_d3e9ebd184e818d );
        devgui::add_devgui_func( "<dev string:x651>", "<dev string:x662>", &function_de681e0ab020dee1 );
        devgui::add_devgui_func( "<dev string:x67d>", "<dev string:x69a>", &function_5557746cc184d3a3 );
        
        foreach ( str_scene_name in level.blight_data.var_94dc8e8b32f90fdb )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x6b1>" + str_scene_name, "<dev string:x6ce>" + str_scene_name, &function_1692a1bb7a68666 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x6e6>" + str_scene_name, "<dev string:x6ce>" + str_scene_name + "<dev string:x706>", &function_1692a1bb7a68666 );
        }
        
        devgui::function_cd4e263c1f3018ae( "<dev string:x70f>", "<dev string:x738>", &function_1692a1bb7a68666 );
        splash_lists = [ { #bundle:getscriptbundle( %"hash_1ecf7e16d6ea7bef" ), #name:"<dev string:x756>" }, { #bundle:getscriptbundle( %"splashlist:saw_blight_splashlist" ), #name:"<dev string:x775>" } ];
        
        foreach ( list in splash_lists )
        {
            path = "<dev string:x78b>" + list.name + "<dev string:x795>";
            
            foreach ( splash in list.bundle.splash_list )
            {
                name = getxhashsourcename( splash.ref );
                devgui::function_cd4e263c1f3018ae( path + name, "<dev string:x797>" + name + "<dev string:x575>" + list.name, &function_fc658a9261348c32 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x64cf5af3, Offset: 0xbb81
    // Size: 0x56, Type: dev
    function private debug_respawn_as_zombie( params )
    {
        player = level.player;
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        player.respawningbr = 1;
        player function_b3283af49c10d434( "<dev string:x570>" );
        player.respawningbr = undefined;
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x6c79fb5c, Offset: 0xbbdf
    // Size: 0x3a, Type: dev
    function private function_511b948018473702( params )
    {
        player = level.player;
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        player br_player_zombie::setup( 1 );
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x249384de, Offset: 0xbc21
    // Size: 0x19, Type: dev
    function private function_deea71709f4d2c8f()
    {
        level notify( #"hash_f1bfa4b872ea7a18" );
        level thread function_eae3d25b6b1cf0c6();
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x84ff451e, Offset: 0xbc42
    // Size: 0x36, Type: dev
    function private function_e8724156ec2f6954()
    {
        level notify( #"hash_f1bfa4b872ea7a18" );
        
        if ( isdefined( level.var_5e27e0e2ed6f644b ) )
        {
            level.var_5e27e0e2ed6f644b destroy();
            level.var_5e27e0e2ed6f644b = undefined;
        }
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x4327339c, Offset: 0xbc80
    // Size: 0x1c5, Type: dev
    function private function_eae3d25b6b1cf0c6()
    {
        level endon( #"game_ended" );
        level endon( #"hash_f1bfa4b872ea7a18" );
        
        if ( isdefined( level.var_5e27e0e2ed6f644b ) )
        {
            level.var_5e27e0e2ed6f644b destroy();
        }
        
        level.var_5e27e0e2ed6f644b = newhudelem();
        level.var_5e27e0e2ed6f644b.x = 25;
        level.var_5e27e0e2ed6f644b.y = 200;
        level.var_5e27e0e2ed6f644b.color = ( 1, 1, 1 );
        level.var_5e27e0e2ed6f644b.alpha = 1;
        level.var_5e27e0e2ed6f644b.hidden = 0;
        level.var_5e27e0e2ed6f644b.var_3d413c404ce8bc30 = 0;
        level.var_5e27e0e2ed6f644b.fontscale = 1;
        
        while ( true )
        {
            text = "<dev string:x7ab>";
            text += "<dev string:x7c3>" + level.blight_data.var_f1569c16a29ffcbf;
            text += "<dev string:x7cd>";
            
            if ( isarray( level.blight_data.var_fc6261768b030b78 ) )
            {
                for ( i = 0; i < level.blight_data.var_fc6261768b030b78.size ; i++ )
                {
                    text += "<dev string:x7e2>" + level.blight_data.var_fc6261768b030b78[ i ] + "<dev string:x7e6>" + level.blight_data.var_95b2260ee357c0bd[ i ];
                }
            }
            
            level.var_5e27e0e2ed6f644b setdevtext( text );
            wait 0.5;
        }
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x14d2c9d9, Offset: 0xbe4d
    // Size: 0x19, Type: dev
    function private function_1dbdf1765a499853()
    {
        level notify( #"hash_b293419657fc557c" );
        level thread function_ad24afeb6a3c3bd2();
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0xeb06876f, Offset: 0xbe6e
    // Size: 0x11, Type: dev
    function private function_1000900547a4d76e()
    {
        level notify( #"hash_b293419657fc557c" );
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x945b61be, Offset: 0xbe87
    // Size: 0x136, Type: dev
    function private function_ad24afeb6a3c3bd2()
    {
        level endon( #"game_ended" );
        level endon( #"hash_b293419657fc557c" );
        var_e2fb812c18e59daa = ( 0, 0, 40 );
        
        for ( ;; )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                color = ( 1, 1, 1 );
                
                if ( player.team == "<dev string:x7e9>" )
                {
                    color = ( 0, 1, 0 );
                }
                else if ( player.team == "<dev string:x570>" )
                {
                    color = ( 1, 0, 0 );
                }
                
                print3d( player.origin + var_e2fb812c18e59daa, player.sessionsquadid, color, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x4f151bb4, Offset: 0xbfc5
    // Size: 0x47, Type: dev
    function private function_be1f718c2d0d7d4f( params )
    {
        player = level.player;
        
        if ( !isdefined( player.lastdeathpos ) )
        {
            return;
        }
        
        function_e05519ff2725234a( player.lastdeathpos );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xc7dde184, Offset: 0xc014
    // Size: 0x36, Type: dev
    function private function_f90dc9a073fcd9a4( params )
    {
        player = level.player;
        function_e05519ff2725234a( player.origin );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x29aa242, Offset: 0xc052
    // Size: 0x1ed, Type: dev
    function private function_e05519ff2725234a( referencepoint )
    {
        duration = int( 10 / level.framedurationseconds );
        radius = getdvarint( @"hash_340bea1e8845b61b", 8000 );
        sample_count = getdvarint( @"hash_a4c229c0dbeb0887", 8 );
        candidates = function_aef47d9dd0a162e0( referencepoint, radius, sample_count );
        
        if ( candidates.size == 0 )
        {
            return;
        }
        
        debugstar( referencepoint, ( 1, 1, 1 ), duration, "<dev string:x7f0>", 1 );
        line( referencepoint, ( referencepoint[ 0 ], referencepoint[ 1 ], 12000 ), ( 1, 1, 1 ), 1, 0, duration );
        
        foreach ( candidate in candidates )
        {
            influence = getplayerinfluenceatposition( candidate, 1 );
            debugstar( candidate, ( 1, 1, 0 ), duration, string( influence ), 1 );
            line( candidate, ( candidate[ 0 ], candidate[ 1 ], 12000 ), ( 1, 1, 0 ), 1, 0, duration );
        }
        
        pick_result = function_9a4ee51bfbb6efd5( candidates );
        best_origin = pick_result[ 0 ];
        best_influence = pick_result[ 1 ];
        debugstar( best_origin, ( 0, 1, 0 ), duration, "<dev string:x7f4>" + best_influence, 1.5 );
        line( best_origin, ( best_origin[ 0 ], best_origin[ 1 ], 12000 ), ( 0, 1, 0 ), 1, 0, duration, 10 );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xd4f5a355, Offset: 0xc247
    // Size: 0x56, Type: dev
    function private function_84c56b031124e4c5( params )
    {
        player = level.player;
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        player.respawningbr = 1;
        player function_b3283af49c10d434( "<dev string:x7e9>" );
        player.respawningbr = undefined;
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xa9bce095, Offset: 0xc2a5
    // Size: 0x39, Type: dev
    function private function_42c231f1d407349( params )
    {
        player = level.player;
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        player br_player_zombie::setup( 0 );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x604b35a6, Offset: 0xc2e6
    // Size: 0xff, Type: dev
    function private function_64c4da7b21ced155( params )
    {
        player = level.player;
        var_64bb57aa2d6e8b35 = level.squaddata[ player.team ][ player.sessionsquadid ];
        
        if ( !isdefined( var_64bb57aa2d6e8b35 ) )
        {
            return;
        }
        
        alive_players = [];
        
        foreach ( squadmate in var_64bb57aa2d6e8b35.players )
        {
            if ( isalive( squadmate ) )
            {
                alive_players[ alive_players.size ] = squadmate;
            }
        }
        
        if ( alive_players.size == 0 )
        {
            return;
        }
        
        level thread function_227859c7ab91b3a9( { #players:alive_players } );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x25648ad9, Offset: 0xc3ed
    // Size: 0xb8, Type: dev
    function private debug_give_loadout( params )
    {
        team = params[ 0 ];
        key = params[ 1 ];
        teamloadout = team == "<dev string:x570>" ? level.blight_data.infectedloadouts : level.blight_data.survivorloadouts;
        loadout = teamloadout[ key ];
        player = level.player;
        player.pers[ "<dev string:x7fa>" ] = loadout;
        player class::preloadandqueueclass( "<dev string:x80a>", 1 );
        player thread class::swaploadout();
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xe0585461, Offset: 0xc4ad
    // Size: 0xa2, Type: dev
    function private function_196e203673490108( params )
    {
        if ( !flags::gameflag( "<dev string:x813>" ) )
        {
            return;
        }
        
        player = level.player;
        
        if ( player.team != "<dev string:x7e9>" )
        {
            return;
        }
        
        if ( player.awardtierpoints >= level.gametypebundle.awardtiers.size )
        {
            return;
        }
        
        player namespace_69e3a436b5d8370e::function_5522ec1a2a1200a5( 1 );
        curr_tier = player namespace_69e3a436b5d8370e::function_8af42f15cd41334c();
        player function_9ec71f1b6a661608( curr_tier );
        player.survivor_tier = curr_tier;
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xb9afd21c, Offset: 0xc557
    // Size: 0x75, Type: dev
    function private function_a0aedef46184d7d7( params )
    {
        if ( !flags::gameflag( "<dev string:x813>" ) )
        {
            return;
        }
        
        player = level.player;
        
        if ( player.team != "<dev string:x7e9>" )
        {
            return;
        }
        
        if ( !player.awardtierpoints || player.awardtierpoints == 0 )
        {
            return;
        }
        
        player namespace_69e3a436b5d8370e::function_5522ec1a2a1200a5( -1 );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x77dec7ba, Offset: 0xc5d4
    // Size: 0x20, Type: dev
    function private function_85f0b4512cf707e3( params )
    {
        level thread final_survivor_sequence( level.player );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xedee7c92, Offset: 0xc5fc
    // Size: 0xe6, Type: dev
    function private function_2adb9dbbc5ff3ff1( params )
    {
        if ( !flags::gameflag( "<dev string:x813>" ) )
        {
            return;
        }
        
        player = level.player;
        
        if ( player.team != "<dev string:x570>" )
        {
            return;
        }
        
        if ( player.var_ecb816c18201341f.tiersgranted >= level.brgametype.var_641e0cf69a87e2ba )
        {
            return;
        }
        
        interval_ms = level.brgametype.var_6648f001bf5c77a2 * 1000;
        player.var_ecb816c18201341f.tiersgranted++;
        player.var_ecb816c18201341f.elapsedms = player.var_ecb816c18201341f.tiersgranted * interval_ms;
        player thread zombie_tier_start( 1 );
    }

    // Namespace br_gametype_blight
    // Params 2, eflags: 0x4
    // Checksum 0xbabc50dc, Offset: 0xc6ea
    // Size: 0x12a, Type: dev
    function private function_6948ba8b19d99f5d( params, player )
    {
        key = params[ 0 ];
        var_2a88723414227592 = int( params[ 1 ] );
        loadout = level.blight_data.survivorloadouts[ key ];
        class_slot = "<dev string:x821>" + var_2a88723414227592 + 1;
        
        if ( !isdefined( player ) )
        {
            player = level.player;
        }
        
        player.class = class_slot;
        player.pers[ "<dev string:x829>" ] = class_slot;
        player.loadoutbrfieldupgrade = loadout[ "<dev string:x82f>" ];
        
        if ( isdefined( level.var_996fc22e6a2c14a2 ) )
        {
            prev_class = level.var_996fc22e6a2c14a2;
            level.var_996fc22e6a2c14a2 = undefined;
            setdvar( @"hash_d2d81d15778565ca", 1 );
        }
        
        player class::preloadandqueueclass( class_slot, 1 );
        player class::swaploadout();
        player function_211ae758a9239007();
        
        if ( prev_class )
        {
            level.var_996fc22e6a2c14a2 = prev_class;
            setdvar( @"hash_d2d81d15778565ca", 0 );
        }
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xb516b220, Offset: 0xc81c
    // Size: 0x90, Type: dev
    function private function_782a48465afc06da( params )
    {
        key = params[ 0 ];
        var_2a88723414227592 = int( params[ 1 ] );
        tier = int( params[ 2 ] );
        player = level.player;
        class_slot = "<dev string:x821>" + var_2a88723414227592 + 1;
        
        if ( player.class != class_slot )
        {
            function_6948ba8b19d99f5d( params, player );
        }
        
        player thread function_d51cbc351210c949( key, tier );
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0xa6616285, Offset: 0xc8b4
    // Size: 0x5a, Type: dev
    function private function_d64799ee5e7fb308()
    {
        player = level.player;
        
        if ( !player val::get( "<dev string:x844>" ) )
        {
            return;
        }
        
        player thread br_spawnrespawn::function_1d2f70d591e967bc();
        player thread human_infil_camera();
        wait 1;
        player thread br_spawnrespawn::function_24b79e9319c6f02f();
        player notify( #"hash_88b506e95217aeab" );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x14376284, Offset: 0xc916
    // Size: 0x4d, Type: dev
    function private function_d3e9ebd184e818d( params )
    {
        player = level.player;
        amount = getdvarint( @"hash_a27ff17573099185", 100 );
        player currency::add_currency_amount( "<dev string:x84d>", amount );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x4ed63e6c, Offset: 0xc96b
    // Size: 0x5b, Type: dev
    function private function_de681e0ab020dee1( params )
    {
        amount = getdvarint( @"hash_a27ff17573099185", 100 );
        level.blight_data.dna_sample_count += amount;
        function_b6781da7ed913abf();
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x3c045b1d, Offset: 0xc9ce
    // Size: 0xa4, Type: dev
    function private function_5557746cc184d3a3( params )
    {
        player = level.player;
        amount = getdvarint( @"hash_a27ff17573099185", 100 );
        item_name = item_currency::function_a3eadb2d3c329589( "<dev string:x84d>", amount );
        offset = anglestoforward( player.angles ) * 50;
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( player.origin + offset, player.angles );
        common_item::function_57b88e025e5fb03e( item_name, amount, spawn_options );
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0xdd25032e, Offset: 0xca7a
    // Size: 0x1b9, Type: dev
    function private function_1692a1bb7a68666( params )
    {
        scriptbundlename = params[ 0 ];
        players = [ level.player ];
        
        if ( params[ 1 ] == "<dev string:x858>" )
        {
            players = arrayremove( level.players, level.player );
        }
        
        foreach ( player in players )
        {
            if ( scriptbundlename == "<dev string:x860>" )
            {
                if ( level.blight_data.map_structs[ "<dev string:x867>" ].size == 0 )
                {
                    return;
                }
                
                node = function_47c86977a18df38b( level.blight_data.map_structs[ "<dev string:x867>" ], player.origin );
                
                if ( !node )
                {
                    continue;
                }
                
                scene_root = { #angles:node.angles, #origin:node.origin };
                scriptbundlename = node.script_scenescriptbundle;
            }
            else
            {
                scene_root = { #angles:player.angles, #origin:player.origin };
            }
            
            player val::set( #"blight_debug", "<dev string:x147>", 0 );
            player thread infected_play_scene( scriptbundlename, scene_root );
        }
    }

    // Namespace br_gametype_blight
    // Params 1, eflags: 0x4
    // Checksum 0x2ef959e4, Offset: 0xcc3b
    // Size: 0x48, Type: dev
    function private function_fc658a9261348c32( args )
    {
        splash_ref = args[ 0 ];
        splash_list = args[ 1 ];
        level.players[ 0 ] hud_message::showsplash( splash_ref, undefined, undefined, undefined, 0, splash_list, 1 );
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x6353cd3d, Offset: 0xcc8b
    // Size: 0x5c, Type: dev
    function private function_4e33a986b5815f24()
    {
        if ( level.blight_data.debug_activity_spread )
        {
            level.blight_data.debug_activity_spread = 0;
            level notify( #"hash_5a3ae2a0a696ee1f" );
            return;
        }
        
        level.blight_data.debug_activity_spread = 1;
        function_b46176641d013e85();
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x8c301220, Offset: 0xccef
    // Size: 0x23c, Type: dev
    function private function_b46176641d013e85()
    {
        if ( level.blight_data.debug_activity_spread )
        {
            level notify( #"hash_5a3ae2a0a696ee1f" );
            
            foreach ( instance in level.blight_data.activity_distribution.instances_chosen )
            {
                color = instance.type == "<dev string:x87d>" ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                debug::sphere( instance.var_441d26d05f86b224 + ( 0, 0, 300 ), 50, color, undefined, "<dev string:x88b>" );
                debug::line( instance.var_441d26d05f86b224 + ( 0, 0, 300 ), instance.var_441d26d05f86b224 + ( 0, 0, 5000 ), color, undefined, "<dev string:x88b>" );
            }
            
            foreach ( cluster in level.blight_data.var_aba7c9f65a2bf5f1 )
            {
                if ( cluster.used )
                {
                    debug::sphere( cluster.origin, 10, ( 0, 0, 1 ), undefined, "<dev string:x88b>" );
                    debug::line( cluster.origin, cluster.origin + ( 0, 0, 10000 ), ( 0, 0, 1 ), undefined, "<dev string:x88b>" );
                }
            }
        }
    }

    // Namespace br_gametype_blight
    // Params 0, eflags: 0x4
    // Checksum 0x253457a, Offset: 0xcf33
    // Size: 0x17b, Type: dev
    function private function_e2c8a99f1592bc00()
    {
        level.blight_data.debug_activity_spread = 1;
        level notify( #"hash_5a3ae2a0a696ee1f" );
        
        foreach ( cluster in level.blight_data.var_aba7c9f65a2bf5f1 )
        {
            cluster.used = 0;
        }
        
        clusters = arraycopy( level.blight_data.var_aba7c9f65a2bf5f1 );
        clusters = arrayrandomize( clusters );
        
        for ( i = 0; i < 3 ; i++ )
        {
            cluster = clusters[ i ];
            cluster.used = 1;
            debug::sphere( cluster.origin, 10, ( 0, 0, 1 ), undefined, "<dev string:x88b>" );
            debug::line( cluster.origin, cluster.origin + ( 0, 0, 10000 ), ( 0, 0, 1 ), undefined, "<dev string:x88b>" );
        }
        
        iprintlnbold( "<dev string:x8a8>" );
        level thread activity_distribution();
    }

#/
