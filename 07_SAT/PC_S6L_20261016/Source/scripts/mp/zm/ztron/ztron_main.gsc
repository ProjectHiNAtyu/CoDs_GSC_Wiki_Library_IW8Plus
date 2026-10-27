// scripts\mp\zm\ztron\ztron_main.gsc  (hash_380ce71bf263d28b.gscc) (size: 17374 Bytes / 0x43de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51139c32 (1360239666)
// size ...... 17374 (0x43de)
// includes .. 52  (offset: 0x3e66)
// strings ... 66  (offset: 0x4006)
// dev strs .. 0   (offset: 0x43de)
// exports ... 34  (offset: 0x2666)
// cseg ...... 0x66c + 0x1ffa (0x2666)
// imports ... 157 (offset: 0x2bb6)
// animtree1 . 0   (offset: 0x43de)
// animtree2 . 0   (offset: 0x43de)
#using script_16ea1b94f0f381b3;
#using script_31ee2a173f3499b7;
#using script_54a05cbb2455bc6f;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\telemetry_utils;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\currency;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\laststand;
#using scripts\mp\mp_gameskill;
#using scripts\mp\purchasemenu;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_achievements;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bgb_machine;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_cabinet;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_dev;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_ftue;
#using scripts\mp\zm\ztron\ztron_gobblegums;
#using scripts\mp\zm\ztron\ztron_health_bar;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_laststand;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_outro;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_telemetry;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;
#using scripts\mp\zm\ztron\ztron_weapon;
#using scripts\mp\zm\ztron\ztron_weather;
#using scripts\mp\zm\ztron\ztron_world_event;

#namespace ztron_main;

// Namespace ztron_main
// Params 0
// Checksum 0x4e085500, Offset: 0x68a
// Size: 0x137
function init()
{
    level.ztron = spawnstruct();
    function_dc1834b04e8f3833();
    function_6cacd29a4f2b9588( 0 );
    level.ztron.playerdamagecb = &ztron_player::callback_playerdamage;
    utility::registersharedfunc( #"game", #"roundNumberDifficulty", &function_302999c62e2a79ae );
    level.ammo_mods_in_use = 1;
    level.zombie_augments_in_use = 1;
    level.zombie_perks_in_use = 1;
    ammo_mod::init_ammo_mod();
    level.var_3a28db61277e7016 = 1;
    level.var_a7b38b9723de06b8 = 1;
    level.var_6895525f56448bd5 = 1;
    level.var_2ddab79ae85798d2 = 1;
    mp_gameskill::init_gameskill();
    level thread init_ztron_systems();
    level ui::lui_registercallback( "ztron_game_restart", &ztron_game_restart );
    utility::registersharedfunc( #"zm", #"wait_begin_round_logic", &wait_begin_round_logic );
    utility::registersharedfunc( #"zm", #"hash_24d8662fc27b441c", &function_39e19497f40044fb );
    function_895ee48d98db3668();
    level.zm_get_round_number = &get_ztron_round_number;
    level.var_21108d67c072f793 = &function_319ad45de3801000;
    level.var_8fa6e09410dcd137 = &function_ab301a28efb9a5b4;
}

// Namespace ztron_main
// Params 0
// Checksum 0x8d797229, Offset: 0x7c9
// Size: 0x15
function get_ztron_round_number()
{
    return level.ztron.roundnumber;
}

// Namespace ztron_main
// Params 1
// Checksum 0x77dbd9c9, Offset: 0x7e7
// Size: 0x64
function function_319ad45de3801000( player )
{
    var_bea34a9efeb8e0ed = player.pers[ "telemetry" ].special_eliminations ?? 0;
    var_d456619564bfb4a1 = player.pers[ "telemetry" ].elite_eliminations ?? 0;
    return var_bea34a9efeb8e0ed + var_d456619564bfb4a1;
}

// Namespace ztron_main
// Params 1
// Checksum 0xcf332e26, Offset: 0x854
// Size: 0x39
function function_ab301a28efb9a5b4( player )
{
    var_742ac802312a4031 = player.pers[ "telemetry" ].boss_eliminations ?? 0;
    return var_742ac802312a4031;
}

// Namespace ztron_main
// Params 0
// Checksum 0x4b941648, Offset: 0x896
// Size: 0xf
function wait_begin_round_logic()
{
    level utility::flag_wait( "begin_ztron_logic" );
}

// Namespace ztron_main
// Params 0
// Checksum 0x5a542fff, Offset: 0x8ad
// Size: 0xf
function function_39e19497f40044fb()
{
    level utility::flag_wait( "ztron_game_is_over" );
}

// Namespace ztron_main
// Params 0
// Checksum 0x1049124d, Offset: 0x8c4
// Size: 0x6c
function function_413411fc241df5ae()
{
    if ( !isdefined( level.ztron.var_291105dfc6b5a9b8 ) )
    {
        return 0;
    }
    
    switch ( level.ztron.var_291105dfc6b5a9b8 )
    {
        case 1:
        case 3:
        case 5:
            return 1;
        default:
            return 0;
    }
}

// Namespace ztron_main
// Params 1
// Checksum 0x8b0c7b9f, Offset: 0x938
// Size: 0x20
function ztron_game_restart( param )
{
    if ( !function_413411fc241df5ae() )
    {
        return;
    }
    
    function_940659c4c664d91b( 6 );
}

// Namespace ztron_main
// Params 0
// Checksum 0x14044113, Offset: 0x960
// Size: 0x12a
function function_dc1834b04e8f3833()
{
    level.ztron.var_74a3707334cfe144 = getdvarint( @"hash_12202845e7a09a61", 0 ) == 1;
    level.ztron.var_95d8c7a469393957 = getdvarint( @"hash_d3d5686da05c3c43", 0 ) == 1;
    level.ztron.var_371903e5801e0e08 = getdvarint( @"hash_5f1035b22c47683c", 0 ) == 1;
    level.ztron.blitzmode = getdvarint( @"hash_a673ff22938fd83c", 0 ) == 1;
    level.ztron.metaenabled = getdvarint( @"hash_855920521a29a8de", 0 ) == 1;
    level.ztron.cabinetmode = getdvarint( @"hash_9ce3cdf1c317d867", 0 ) == 1;
    level.ztron.var_ae731d68b2dededc = getdvarint( @"hash_542648c49493c45b", 0 ) == 1;
    level.ztron.var_92c01edd802f6a18 = getdvarint( @"hash_431bf408cb8be3ab", 0 ) == 1;
}

// Namespace ztron_main
// Params 0
// Checksum 0xd9e59183, Offset: 0xa92
// Size: 0x74f
function reset_variables()
{
    level.gameended = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    setomnvarforallclients( "post_game_state", 0 );
    function_6cacd29a4f2b9588( 0 );
    level utility::flag_clear( "ztron_game_is_over" );
    level utility::flag_clear( "ztron_all_players_dead" );
    level flags::levelflagclear( "game_over" );
    level.var_36d4bd62cdd6ddca = dvars::function_13909a5327c395b9( "rank_xp_dr_lower", int( getdvarint( @"hash_cb6ff39f36e72179", 42000 ) * 0.9 ) );
    level.var_a620a2c9949e7ccd = dvars::function_13909a5327c395b9( "rank_xp_dr_upper", getdvarint( @"hash_cb6ff39f36e72179", 42000 ) );
    level.ztron.timepiecescollected = 0;
    level.ztron.var_9bacf7922735dc6f = 0;
    level.ztron.var_a72e8e079aa93eae = 0;
    level.ztron.gobblegumsenabled = getdvarint( @"hash_f3551b40ed57dd52", 1 ) == 1 && !level.ztron.var_95d8c7a469393957;
    
    if ( !level.ztron.gobblegumsenabled )
    {
        level.var_eeb6ebe322e71cd1 = 1;
    }
    
    level.ztron.var_81b3951997d9b481 = getdvarint( @"hash_9681219e9d760ed8", 1 ) == 1;
    level.ztron.roundnumber = 0;
    level.ztron.game_laps = 0;
    level.ztron.game_duration = 0;
    level.ztron.game_starttime = gettime();
    level.ztron.var_a593aa94dc733518 = undefined;
    level.ztron.var_992f29dbad27ad98 = 1;
    level.ztron.var_293c4b94e80c822a = 1;
    level.ztron.var_66eddb4a56806387 = 1;
    level.var_8972cc8b6869f399 = 0;
    level.var_823f78c605f46c5c = level.ztron.var_74a3707334cfe144;
    level.var_cfde89929188f64e = &function_743c7c7066c0e538;
    level.ztron.downedplayers = [];
    level.ztron.temp_ammo_mod = [];
    level.ztron.no_bgb_machine = undefined;
    level._custom_perks_ignore = 1;
    level.var_c156642535692bac = 1;
    level.score_events_disabled = 1;
    level.ztron.var_be8fbd1178946a9 = 1;
    level.var_2365b76f19ea37ea = undefined;
    level.ztron.var_f07686d9ccef6efa = level.ztron.var_371903e5801e0e08 ? getdvarfloat( @"hash_5a86cab2c12cccc7", 1 ) : getdvarfloat( @"hash_f1a0707f991db965", 1.2 );
    level.ztron.zombie_health_inc = level.ztron.blitzmode ? 5 : level.ztron.var_371903e5801e0e08 ? getdvarint( @"hash_17c898c60bdceb85", 10 ) : getdvarint( @"hash_27277d6c51f436ff", 10 );
    level.ztron.var_bdb94bcd4b8c89bd = 4;
    level.ztron.var_3ee4688dfd3a7d7c = 5;
    level.ztron.var_c7659fc1aabef3f0 = 0.6;
    level.ztron.upgradeMask = 0;
    level.ztron.var_c38ef096a66e58de = getdvarfloat( @"hash_8b2fa78678cc7e4e", 2000 );
    level.ztron.var_465fa6f0e489652c = getdvarfloat( @"hash_41a07c960914b272", 25 );
    level.ztron.var_6802a5d0daf63432 = getdvarint( @"hash_356009f2a58e14a3", 1250 );
    level.ztron.var_b3bd899c956ebef1 = getdvarint( @"hash_c07d7d7118089ac4", 0 ) && !level.ztron.var_95d8c7a469393957;
    level.ztron.ai_xp = getdvarfloat( @"hash_32f4cae5e001cb12", 2.2 );
    level.ztron.var_511d9835b00f7ac = getdvarint( @"hash_2da6263e19091f56", 34 );
    level.ztron.var_dbf6eef1a1852eed = getdvarint( @"hash_2da6263e19091f56", 34 ) * getdvarint( @"hash_2da6263e19091f56", 34 );
    level.ztron.var_acd90810a416574f = getdvarint( @"hash_f79953ede8b7c28f", 60 );
    level.ztron.var_656759d1cfed2e1e = getdvarint( @"hash_1d6a07986244804c", 30 );
    level.ztron.var_467d7126f9cbb8f1 = getdvarint( @"hash_681fbbeae7e5f6d9", 30 );
    level.ztron.var_2a2d12c87e88af98 = getdvarint( @"hash_c9d703a4f0b6c0a", 42 );
    level.ztron.var_3172b140ef7aaae3 = getdvarint( @"hash_72edf7fa1570a6eb", 60 );
    level.ztron.var_3bb2add1378575fa = getdvarint( @"hash_f98d15071eb563a0", 38 );
    level.ztron.var_7026573ca277eb95 = getdvarint( @"hash_16544050132479b5", 38 );
    level.ztron.var_d374619c4641a3b1 = level.ztron.var_371903e5801e0e08 ? getdvarfloat( @"hash_69a2a279aac7b976", 1 ) : getdvarfloat( @"hash_1f58c706c1e27b42", 2 );
    level.ztron.var_477ba2c6e6ba2820 = getdvarint( @"hash_7246b931dc1c0a3a", 0 ) == 1 || level.ztron.var_371903e5801e0e08;
    
    if ( level.ztron.var_477ba2c6e6ba2820 )
    {
        level.ztron.var_e1fe5ec6a6e36bb7 = getdvarint( @"hash_fd2be9ccb6bc6062", 100 );
        level.ztron.var_e0421d5e75de6120 = getdvarint( @"hash_8b811e004755ac2c", 50 );
        level.ztron.var_f3a1a68100ae3b6c = getdvarint( @"hash_77883f301d768277", 400 );
    }
    
    [[ level.var_7a6587ea21b92883 ]]();
    level.ztron.var_4b6834fb472ff3dc = 1;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_4b6834fb472ff3dc = 0;
        level thread ztron_fate::function_18f662f900ff4485();
    }
}

// Namespace ztron_main
// Params 0
// Checksum 0x68ae64c5, Offset: 0x11e9
// Size: 0x2
function donothing()
{
    
}

// Namespace ztron_main
// Params 0
// Checksum 0xde5d1ad1, Offset: 0x11f3
// Size: 0x162
function init_ztron_systems()
{
    profilestart();
    level.var_916aae8097d37e9e = &donothing;
    level.var_59b27686ba033588 = &endgame;
    level.var_d5a94b280b9c9c35 = &function_940659c4c664d91b;
    utility::flag_set( "ztron_game_initialized", 0 );
    utility::flag_clear( "ztron_game_is_over" );
    level utility::flag_init( "ztron_all_players_dead" );
    level utility::flag_clear( "ztron_all_players_dead" );
    level utility::flag_set( "ztron_screen_faded", 0 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_disconnect", &telemetryplayerdisconnect );
    currency::init_currency();
    currency::register_currency_type( #"plunder" );
    purchasemenu::init();
    events::function_b8b24a291af69f1d();
    initdialogue();
    ztron_achievements::init();
    ztron_sound::init();
    ztron_arena::init();
    ztron_camera::init();
    ztron_save::init();
    ztron_health_bar::init();
    ztron_player::init();
    ztron_enemy::init();
    ztron_slayer::init();
    ztron_gobblegums::init();
    ztron_bgb_machine::init();
    ztron_weapon::init();
    ztron_laststand::init();
    ztron_vfx::init();
    ztron_score::init();
    ztron_bonus_room::init();
    ztron_challenge::init();
    ztron_outro::init();
    ztron_dev::init();
    ztron_telemetry::init();
    ztron_weather::init();
    ztron_world_event::init();
    utility::flag_set( "ztron_game_initialized", 1 );
    level.var_cfde89929188f64e = &function_743c7c7066c0e538;
    profilestop();
}

// Namespace ztron_main
// Params 0
// Checksum 0x88e418d6, Offset: 0x135d
// Size: 0x12e
function game_reset()
{
    level notify( #"ztron_game_reset" );
    reset_variables();
    ztron_util::killallenemies();
    ztron_util::function_d54d1c1fe00833d6();
    function_2da19957201c6090();
    rejoin_utility::main();
    level thread ztron_arena::main();
    level thread ztron_enemy::main();
    level thread ztron_player::main();
    level thread ztron_bonus_room::main();
    level thread ztron_slayer::main();
    level thread ztron_gobblegums::main();
    level thread ztron_weather::main();
    level thread main();
    level thread ztron_ftue::main();
    level thread ztron_ui::main();
    
    if ( level.ztron.blitzmode )
    {
        level thread ztron_ui::function_1f463ca364400259();
        level thread function_e9cdd2ad373a9ec();
    }
    
    level notify( #"ztron_game_reset_completed" );
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::playerinitialize( 1 );
    }
}

// Namespace ztron_main
// Params 1, eflags: 0x4
// Checksum 0x868ac8da, Offset: 0x1493
// Size: 0xc4
function private function_743c7c7066c0e538( weaponobj )
{
    var_2e08e94c9cb1747c = weaponobj.var_1616e6fbba9a722d;
    
    if ( isdefined( level.weaponmetadata[ var_2e08e94c9cb1747c ] ) )
    {
        var_e491cc4ce8526125 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6c2dc03affad7ce0;
        var_e9ca9da4b737395 = level.weaponmetadata[ var_2e08e94c9cb1747c ].var_6ec5e9b28d8ba1f4;
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj hasattachment( var_e491cc4ce8526125 ) || isdefined( var_e9ca9da4b737395 ) && ( weaponobj hasattachment( var_e9ca9da4b737395 ) || weaponobj hasattachment( var_e9ca9da4b737395 + 2 ) ) )
        {
            return weaponobj;
        }
        
        if ( isdefined( var_e491cc4ce8526125 ) && weaponobj canuseattachment( var_e491cc4ce8526125 ) )
        {
            weaponobj = weaponobj withattachment( var_e491cc4ce8526125 );
        }
    }
    
    return weaponobj;
}

// Namespace ztron_main
// Params 0
// Checksum 0xff20b1f1, Offset: 0x1560
// Size: 0x10e
function function_9b14a60ad872f44e()
{
    level utility::flag_wait( "begin_ztron_logic" );
    timerms = getdvarint( @"hash_57a4ee29a59a7d8b", 120 ) * 1000;
    start_time = gettime();
    
    while ( true )
    {
        var_4f8445da3c85dd73 = 0;
        
        foreach ( player in level.players )
        {
            if ( player ztron_player::function_791dcf0ce4bf51e7() )
            {
                var_4f8445da3c85dd73++;
            }
        }
        
        if ( gettime() >= start_time + timerms || var_4f8445da3c85dd73 == level.players.size )
        {
            break;
        }
        
        wait 0.5;
    }
    
    if ( level.ztron.cabinetstart )
    {
        ztron_cabinet::function_9b14a60ad872f44e();
    }
}

// Namespace ztron_main
// Params 0
// Checksum 0xeabcda1a, Offset: 0x1676
// Size: 0x1d4
function main()
{
    self notify( #"hash_6d5dfb389817a219" );
    self endon( #"hash_6d5dfb389817a219" );
    utility::flag_init( "ztron_system_start" );
    function_9b14a60ad872f44e();
    utility::flag_set( "ztron_system_start" );
    wait 0.1;
    level.ztron.gamestarted = gettime();
    
    for ( keeprunning = 1; keeprunning ; keeprunning = !level utility::flag( "ztron_all_players_dead" ) )
    {
        wait 0.5;
    }
    
    ztron_debug::debugmsg( "All Players have Died at: " + gettime() );
    
    if ( level.ztron.blitzmode )
    {
        ztron_ui::function_ce37a481d70a78ed();
        setomnvar( "ui_ztron_blitz_race_time_s", 0 );
        setomnvar( "ui_ztron_blitz_victory", 0 );
        wait 3;
        
        foreach ( player in level.players )
        {
            player ztron_ui::function_3579c3e1cfd9f4ba();
            player ztron_ui::function_7716b71d0d232366();
        }
        
        wait 20;
        
        foreach ( player in level.players )
        {
            player ztron_ui::function_ccc4f097446d1043();
        }
    }
    
    thread endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

// Namespace ztron_main
// Params 0, eflags: 0x4
// Checksum 0x7703c4dd, Offset: 0x1852
// Size: 0x81
function private function_e9cdd2ad373a9ec()
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"hash_c1b1475af2f47aa3" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( level.ztron.blitzstarttime ) )
        {
            continue;
        }
        
        elapsedms = gettime() - level.ztron.blitzstarttime;
        
        if ( elapsedms >= 3600000 )
        {
            level utility::flag_set( "ztron_all_players_dead" );
            return;
        }
    }
}

// Namespace ztron_main
// Params 1
// Checksum 0xeeff463a, Offset: 0x18db
// Size: 0x2c
function telemetryplayerdisconnect( telemetrydata )
{
    telemetry_utils::function_c54601d44e7b8e8a( self );
    level callback::callback( "player_match_end", { #player:self } );
}

// Namespace ztron_main
// Params 1, eflags: 0x4
// Checksum 0x3fad159d, Offset: 0x190f
// Size: 0x28e
function private displaygameend( endreason )
{
    if ( endreason == game[ "end_reason" ][ "mp_faction_eliminated" ] || endreason == game[ "end_reason" ][ "round_limit_reached" ] || endreason == game[ "end_reason" ][ "mp_faction_success" ] )
    {
        if ( level.players.size > 0 )
        {
            level.ztron.var_74a3707334cfe144 = 0;
            
            foreach ( player in level.players )
            {
                if ( endreason == game[ "end_reason" ][ "round_limit_reached" ] || endreason == game[ "end_reason" ][ "mp_faction_success" ] )
                {
                    level thread game_utility::fadetoblackforplayer( player, 1 );
                }
                
                player notify( #"ztron_playerdumpfps" );
                player ztron_camera::camera_default();
                player player::updatesessionstate( "dead" );
            }
            
            level notify( #"ztron_playerdumpfps" );
            
            if ( !level.ztron.blitzmode )
            {
                level thread ztron_outro::podiumScene( endreason == game[ "end_reason" ][ "mp_faction_success" ] );
                level utility::waittill_any( "podiumAllDone", "request_end_game_again" );
            }
            else
            {
                if ( !level.ztron.var_7bccdb18d1ded9f2 )
                {
                    setomnvar( "ui_ztron_blitz_race_time_s", 0 );
                    ztron_sound::function_ac1e49175da7897d( "gameEvent", "gameOver" );
                    setomnvarforallclients( "post_game_state", 8 );
                    wait 0.6;
                    ztron_ui::function_37aad40e39a9fdfe( "blitz_game_over" );
                    wait 5;
                }
                
                foreach ( player in level.players )
                {
                    level thread game_utility::fadetoblackforplayer( player, 1 );
                }
                
                wait 0.6;
            }
            
            setomnvarforallclients( "post_game_state", 5 );
        }
        
        return;
    }
    
    if ( endreason == game[ "end_reason" ][ "save_and_end_game" ] )
    {
        level.postgamenotifies = -5;
    }
    else
    {
        function_6075f6143b0d4cf3( endreason );
    }
    
    ztron_util::function_4430e75095fb2a8();
}

// Namespace ztron_main
// Params 2, eflags: 0x4
// Checksum 0x7cfe324d, Offset: 0x1ba5
// Size: 0x247
function private endgame_ztron( winner, endreason )
{
    canceljoins();
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    setpresencejoin( 0 );
    function_6bd1d161f425e297();
    level utility::flag_set( "ztron_game_is_over" );
    function_6cacd29a4f2b9588( 2 );
    level notify( #"game_ended" );
    flags::levelflagset( "game_over" );
    waitframe();
    gamescore::updateplacement();
    gamelogic_zm::checkforpersonalbests();
    gamelogic_zm::updatespmstats();
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"ui_opensummary", 1 );
        player thread damage_effects::onexitdeathsdoor( 1 );
        player thread laststand::last_stand_exit_postfx();
    }
    
    displaygameend( endreason );
    gamelogic_zm::processlobbydata();
    playerendmatch();
    level callback::callback( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( endreason != game[ "end_reason" ][ "save_and_end_game" ] )
        {
            telemetry_utils::function_c54601d44e7b8e8a( player );
            eventparams = [];
            gamelogic_zm::function_b7a1afe79c577a08( player, eventparams );
            player game_utility::stopkeyearning( winner, eventparams );
        }
        
        level callback::callback( "player_match_end", { #player:player } );
    }
    
    gamelogic_zm::sendendofmatchdata();
    wait min( 10, 7 + level.postgamenotifies );
    
    if ( getdvarint( @"hash_8179443739b975e2", 1 ) >= 1 )
    {
        level notify( #"exitlevel_called" );
        exitlevel( 0 );
        wait 9999;
    }
    
    level thread game_reset();
}

// Namespace ztron_main
// Params 2
// Checksum 0x3e374a2a, Offset: 0x1df4
// Size: 0xd2
function endgame( winner, endreasontext )
{
    if ( level.gameended )
    {
        return;
    }
    
    level.gameendtime = gettime();
    level.gameended = 1;
    dialogue::say( level.ztron.dialogues[ "game_over" ], 0, 0, 1, 0, "global" );
    
    if ( level.ztron.cabinetmode )
    {
        if ( endreasontext == game[ "end_reason" ][ "round_limit_reached" ] || endreasontext == game[ "end_reason" ][ "mp_faction_eliminated" ] )
        {
            ztron_cabinet::endgame( endreasontext );
            return;
        }
    }
    
    level notify( #"start_game_ended" );
    callback::callback( #"start_game_ended" );
    waitframe();
    endgame_ztron( winner, endreasontext );
}

// Namespace ztron_main
// Params 0, eflags: 0x4
// Checksum 0xf94446d6, Offset: 0x1ece
// Size: 0x7b
function private function_6bd1d161f425e297()
{
    foreach ( player in level.players )
    {
        ztron_score::awardxp( player );
    }
}

// Namespace ztron_main
// Params 1, eflags: 0x4
// Checksum 0xb7deec0d, Offset: 0x1f51
// Size: 0xd8
function private function_6075f6143b0d4cf3( reason )
{
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_out( 1, 1, 0.6 );
    }
    
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "gameOver" );
    wait 0.6;
    setomnvarforallclients( "post_game_state", 8 );
    wait 0.6;
    ztron_ui::function_37aad40e39a9fdfe( "game_over", function_d0ec00d4cc5debc7() );
    wait 3;
    setomnvarforallclients( "post_game_state", 5 );
}

// Namespace ztron_main
// Params 1
// Checksum 0xb3b935ce, Offset: 0x2031
// Size: 0x100
function function_940659c4c664d91b( reason )
{
    self notify( #"hash_e67b758b3038d29c" );
    self endon( #"hash_e67b758b3038d29c" );
    
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    
    if ( level.splitscreen )
    {
        endstring = game[ "end_reason" ][ "ended_game" ];
    }
    else
    {
        endstring = game[ "end_reason" ][ "host_ended_game" ];
    }
    
    if ( reason == 77 )
    {
        endstring = game[ "end_reason" ][ "save_and_end_game" ];
    }
    
    if ( reason == 78 )
    {
        endstring = game[ "end_reason" ][ "server_quit" ];
    }
    
    if ( level.ztron.cabinetmode )
    {
        if ( reason == 6 )
        {
            endstring = game[ "end_reason" ][ "mp_faction_eliminated" ];
        }
    }
    
    level notify( #"force_end" );
    thread endgame( "tie", endstring );
}

// Namespace ztron_main
// Params 1
// Checksum 0x9f9deea5, Offset: 0x2139
// Size: 0x20b
function function_2da19957201c6090( number = level.ztron.roundnumber )
{
    rounddiff = number - level.ztron.roundnumber;
    level.ztron.roundnumber = number;
    
    if ( ztron_ui::function_cb44f155ea13ada2() )
    {
        setomnvar( "ui_ztron_current_round_num", level.ztron.roundnumber );
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.ztron ) )
        {
            continue;
        }
        
        if ( !isdefined( player.ztron.var_24267a29d93a5fa6 ) )
        {
            player.ztron.var_24267a29d93a5fa6 = 0;
        }
        
        player.ztron.var_24267a29d93a5fa6 += rounddiff;
        player ztron_player_utility::update_current_round();
    }
    
    function_1b6eaf7a65cc5971( level.ztron.roundnumber );
    
    if ( level.ztron.roundnumber == 5 )
    {
        function_a14deb691144654e();
    }
    
    if ( level.ztron.roundnumber > 0 )
    {
        zm_utility::function_1bd2eda42461fad1( level.ztron.roundnumber );
    }
    
    /#
        level.ztron.dev.var_2801faffccaf8955[ level.ztron.roundnumber ] = 0;
    #/
}

// Namespace ztron_main
// Params 1
// Checksum 0x2475391, Offset: 0x234c
// Size: 0x6b
function function_6cacd29a4f2b9588( state )
{
    laststate = level.ztron.var_291105dfc6b5a9b8;
    level.ztron.var_291105dfc6b5a9b8 = state;
    level notify( #"worldstatechange", state );
    ztron_debug::debugmsg( "Changing world state to: " + state + " from: " + laststate, 1 );
    return laststate;
}

// Namespace ztron_main
// Params 0
// Checksum 0x8b03f15b, Offset: 0x23c0
// Size: 0x15
function function_4da200e9b8d58a3c()
{
    return level.ztron.var_291105dfc6b5a9b8;
}

// Namespace ztron_main
// Params 0
// Checksum 0x9e9071dd, Offset: 0x23de
// Size: 0x15
function function_d0ec00d4cc5debc7()
{
    return level.ztron.roundnumber;
}

// Namespace ztron_main
// Params 1
// Checksum 0xc619c142, Offset: 0x23fc
// Size: 0xe, Type: bool
function function_302999c62e2a79ae( v_origin )
{
    return true;
}

// Namespace ztron_main
// Params 2
// Checksum 0xb6f9f1f2, Offset: 0x2413
// Size: 0x87
function function_a14deb691144654e( var_94fc0bd1df1e42b0 = 1, var_20a3ec0f6a03631b = 1 )
{
    rejoin_utility::function_bf028e9e4a180ae7( 1 );
    setnojipscore( var_94fc0bd1df1e42b0, var_20a3ec0f6a03631b );
    setnojiptime( var_94fc0bd1df1e42b0, var_20a3ec0f6a03631b );
    setpresencejoin( !var_20a3ec0f6a03631b );
    level.nojip = var_94fc0bd1df1e42b0;
    
    if ( !isdefined( level.ztron.var_b3bfbfee5a13278 ) )
    {
        level.ztron.var_b3bfbfee5a13278 = level.players.size;
    }
}

// Namespace ztron_main
// Params 0, eflags: 0x4
// Checksum 0x587c16fa, Offset: 0x24a2
// Size: 0x5b
function private function_895ee48d98db3668()
{
    level thread utility::callsharedfunc( #"dev", #"hash_8346b110c4eeaf2d" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f8f5eb3644a8df89", &ztron_arena::function_d2a08bf013133960 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"debug_end_round", &ztron_arena::debug_end_round );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"debug_spawn_item", &ztron_item::debug_spawn_item );
}

// Namespace ztron_main
// Params 2
// Checksum 0xe8ec8fa1, Offset: 0x2505
// Size: 0x58
function registerdialog( refid, dialogentry )
{
    if ( !isdefined( level.ztron.dialogues ) )
    {
        level.ztron.dialogues = [];
    }
    
    level.ztron.dialogues[ refid ] = dialogentry;
}

// Namespace ztron_main
// Params 0, eflags: 0x4
// Checksum 0xe4a076ea, Offset: 0x2565
// Size: 0x101
function private initdialogue()
{
    registerdialog( "gametype", "dx_zm_ztr4_anno_anz4_d4modetitle" );
    registerdialog( "game_over", "dx_zm_ztr4_anno_anz4_d4gmovr" );
    registerdialog( "on_gobblegum_used", "dx_zm_ztr4_anno_anz4_d4bgbact" );
    registerdialog( "DOA_Slayer_Arena_Announce", "dx_zm_ztr4_anno_anz4_d4slaran" );
    registerdialog( "DOA_Slayer_Mart_Announce", "dx_zm_ztr4_anno_anz4_d4slmrtan" );
    registerdialog( "DOA_Slayer_Big_Boss_Coming", "dx_zm_ztr4_anno_anz4_d4slbbcm" );
    registerdialog( "DOA_Slayer_Victory", "dx_zm_ztr4_anno_anz4_d4slvct" );
    registerdialog( "DOA_Slayer_Defeat", "dx_zm_ztr4_anno_anz4_d4sldft" );
    registerdialog( "DOA_Slayer_Boss_Knight", "dx_zm_ztr4_anno_anz4_d4slbk" );
    registerdialog( "DOA_Slayer_Boss_ZRex", "dx_zm_ztr4_anno_anz4_d4slbzr" );
    registerdialog( "DOA_Slayer_Boss_Mega_Abom", "dx_zm_ztr4_anno_anz4_d4slbma" );
    registerdialog( "DOA_Slayer_Boss_Zursa", "dx_zm_ztr4_anno_anz4_d4slbclst" );
    registerdialog( "DOA_Slayer_Chickened_Out", "dx_zm_ztr4_anno_anz4_d4slchkout" );
    registerdialog( "DOA_Boss_Fight", "dx_zm_ztr4_anno_anz4_d4chbf" );
    registerdialog( "DOA_Mamaback_Chasing", "dx_zm_ztr4_anno_anz4_d4mbch" );
}

