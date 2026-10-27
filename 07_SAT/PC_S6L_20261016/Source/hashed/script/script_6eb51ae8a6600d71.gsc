// script_6eb51ae8a6600d71  (hash_6eb51ae8a6600d71.gscc) (size: 12393 Bytes / 0x3069 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8269dbed (2187975661)
// size ...... 12393 (0x3069)
// includes .. 15  (offset: 0x2cd5)
// strings ... 52  (offset: 0x2d4d)
// dev strs .. 3   (offset: 0x3045)
// exports ... 38  (offset: 0x1bf5)
// cseg ...... 0x4a0 + 0x1755 (0x1bf5)
// imports ... 92  (offset: 0x21e5)
// animtree1 . 0   (offset: 0x3069)
// animtree2 . 0   (offset: 0x3069)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zombie_intel;

#namespace namespace_dfad1329c1734063;

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x5
// Checksum 0x1ecfda3b, Offset: 0x4be
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_piano", undefined, undefined, &init );
}

// Namespace namespace_dfad1329c1734063
// Params 0
// Checksum 0x1bcfd246, Offset: 0x4df
// Size: 0x198
function init()
{
    level utility::flag_wait_all( "zm_sat_scarab_ee_piano_cs_completed", "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    level.piano_ee = zm_quest::get_quest( #"scarab_ee_piano" );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79708d13ad566b50", &function_2bf824783762f67, &function_eff2618961fcc718 );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79708e13ad566d03", &function_2bf814783762d34, &function_eff2628961fcc94b );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79708f13ad566eb6", &function_2bf8447837633cd, &function_eff2638961fccb7e );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79709013ad567069", &function_2bf83478376319a, &function_eff2648961fccdb1 );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79709113ad56721c", &function_2bf7e478376269b, &function_eff2658961fccfe4 );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79709213ad5673cf", &function_2bf7d4783762468, &function_eff2668961fcd217 );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"hash_79709313ad567582", &function_2bf804783762b01, &function_eff2678961fcd44a );
    zm_quest::register_quest_step( #"scarab_ee_piano", #"piano_ee_songs", &function_cc207a346b169109, &function_22b960405b91a58c );
    level setup_piano_ee_assets();
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level thread save_load_piano_ee();
    }
    
    /#
        level init_piano_ee_debug();
    #/
    
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"scarab_ee_piano" );
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x5bd84a16, Offset: 0x67f
// Size: 0x7b
function private save_load_piano_ee()
{
    level zm_save::function_1f44a48caae2acbf();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_ee_piano", #"hash_d39039c8ef113a5c" ) )
    {
        level.piano_ee.var_c8a3f04218f7f813 = 1;
    }
    
    var_c9f5ad5a6df55cdd = zm_quest::function_73720cdf21c3cfd7( #"scarab_ee_piano", #"hash_c581d634c18263a3" );
    
    if ( isdefined( var_c9f5ad5a6df55cdd ) )
    {
        level.piano_ee.var_81c31c50d2d616cd = var_c9f5ad5a6df55cdd;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0xfe049189, Offset: 0x702
// Size: 0x4f1
function private setup_piano_ee_assets()
{
    level.piano_ee.var_24d0686e57d5f5c5 = utility::getstruct( "ee_piano_pos", "targetname" );
    level.piano_ee.var_24d0686e57d5f5c5.interaction = zm_quest::function_91f9590e98d57ff6( level.piano_ee.var_24d0686e57d5f5c5.origin, &function_a1763a5d7111f913, &function_fd27bf142cb3baf, "extrasmall" );
    s_piano_sbl = utility::getstruct( "piano_sbl_pos", "targetname" );
    level.piano_ee.s_piano_sbl = spawnscriptable( s_piano_sbl.script_noteworthy, s_piano_sbl.origin, s_piano_sbl.angles, undefined, function_67b78af3c33ac9a8( 1.2 ) );
    level.piano_ee.var_ed44fde0f94be33f = 0;
    level.piano_ee.a_songs = [ [ 8, 4, 1, 8, 4, 1, 8, 4, 8, 4, 1, 8, 4, 1, 8, 4 ], [ 5, 5, 5, 8, 5, 5, 4, 4, 4, 8, 5, 5, 5, 5, 5, 6, 7, 6, 5 ], [ 1, 1, 3, 5, 6, 5, 4, 3, 5, 5, 6, 5, 3, 5, 5, 6, 5 ], [ 4, 5, 6, 5, 5, 4, 5, 6, 5, 3, 7, 3, 7, 3, 4, 4, 5, 6, 5 ], [ 8, 6, 7, 5, 6, 5, 3, 5, 4 ], [ 5, 3, 6, 5, 3, 5, 5, 3, 6, 5, 3, 4, 3, 2, 3, 1, 2, 2, 3, 2, 3, 1 ], [ 1, 1, 1, 1, 1, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 3, 4 ] ];
    level.piano_ee.var_f9332a938fe46877 = [ "piano_ee_song_0_complete", "piano_ee_song_1_complete", "piano_ee_song_2_complete", "piano_ee_song_3_complete", "piano_ee_song_4_complete", "piano_ee_song_5_complete", "piano_ee_song_6_complete" ];
    level.piano_ee.var_3ec362be765f243b = [ 300, 400, 500, 600, 700, 800, 1000 ];
    level.piano_ee.var_32a093fd92b7b686 = [];
    level.piano_ee.var_81c31c50d2d616cd = 0;
    level.piano_ee.var_c8a3f04218f7f813 = 0;
    level.piano_ee.n_last_round = zm_utility::get_round_number();
    level callback::add( "on_round_start", &function_ee8fa78761130c04 );
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0xba456b7f, Offset: 0xbfb
// Size: 0x100
function private function_ee8fa78761130c04( params )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    if ( level.var_dc81f03d76612023 )
    {
        return;
    }
    
    if ( level.piano_ee.n_last_round == zm_utility::get_round_number() )
    {
        return;
    }
    
    level.piano_ee.n_last_round = zm_utility::get_round_number();
    
    if ( level.piano_ee.var_81c31c50d2d616cd >= 3 )
    {
        level.piano_ee.var_24d0686e57d5f5c5.interaction utility::function_7c10ea82c1e305b8( "base", "small" );
    }
    
    level.piano_ee.var_81c31c50d2d616cd = 0;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_piano", #"hash_c581d634c18263a3", 0 );
    level.piano_ee.var_c8a3f04218f7f813 = 0;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_piano", #"hash_d39039c8ef113a5c", 0 );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xa83a51ac, Offset: 0xd03
// Size: 0x6c
function private function_fd27bf142cb3baf( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0xc4f1e19c, Offset: 0xd78
// Size: 0x7d
function private function_a1763a5d7111f913( player )
{
    if ( level utility::flag( "piano_ee_in_progress" ) || player.var_9ba469c390e7eb5 )
    {
        return;
    }
    
    if ( level.piano_ee.var_81c31c50d2d616cd >= 3 )
    {
        return;
    }
    
    level.piano_ee.var_24d0686e57d5f5c5.interaction utility::function_7c10ea82c1e305b8( "base", "off" );
    level thread function_dfbe90682de06e0d( player );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x48088276, Offset: 0xdfd
// Size: 0x22
function private function_2bf824783762f67( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_0_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xba9c5d04, Offset: 0xe27
// Size: 0x3b
function private function_eff2618961fcc718( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_0_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xd0cdd9de, Offset: 0xe6a
// Size: 0x22
function private function_2bf814783762d34( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_1_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x225906ac, Offset: 0xe94
// Size: 0x3b
function private function_eff2628961fcc94b( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_1_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xa2f33367, Offset: 0xed7
// Size: 0x22
function private function_2bf8447837633cd( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_2_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x5067ec15, Offset: 0xf01
// Size: 0x3b
function private function_eff2638961fccb7e( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_2_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x3a3668cf, Offset: 0xf44
// Size: 0x22
function private function_2bf83478376319a( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_3_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xc8a2b7bd, Offset: 0xf6e
// Size: 0x3b
function private function_eff2648961fccdb1( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_3_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x468ee615, Offset: 0xfb1
// Size: 0x22
function private function_2bf7e478376269b( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_4_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xb41a3967, Offset: 0xfdb
// Size: 0x3b
function private function_eff2658961fccfe4( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_4_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xde4bbdbd, Offset: 0x101e
// Size: 0x22
function private function_2bf7d4783762468( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_5_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x2cdf62cf, Offset: 0x1048
// Size: 0x3b
function private function_eff2668961fcd217( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_5_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0xac755704, Offset: 0x108b
// Size: 0x22
function private function_2bf804783762b01( b_skipped, b_save_restored )
{
    level utility::flag_wait( "piano_ee_song_6_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x5ee18876, Offset: 0x10b5
// Size: 0x3b
function private function_eff2678961fcd44a( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "piano_ee_song_6_complete" );
        level.piano_ee.var_ed44fde0f94be33f++;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x38ee4e75, Offset: 0x10f8
// Size: 0x15
function private function_cc207a346b169109( b_skipped, b_save_restored )
{
    
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x76b084d9, Offset: 0x1115
// Size: 0x22
function private function_22b960405b91a58c( b_skipped, b_save_restored )
{
    level utility::flag_set( "piano_ee_complete" );
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0xc6f00b8, Offset: 0x113f
// Size: 0x1e9
function private function_dfbe90682de06e0d( player )
{
    level endon( #"game_ended" );
    level.piano_ee.var_81c31c50d2d616cd++;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_piano", #"hash_c581d634c18263a3", level.piano_ee.var_81c31c50d2d616cd );
    level utility::flag_set( "piano_ee_in_progress" );
    
    if ( level.piano_ee.s_piano_sbl )
    {
        level.piano_ee.s_piano_sbl utility::function_7c10ea82c1e305b8( "anim", "open" );
    }
    
    level.piano_ee.var_32a093fd92b7b686 = [];
    player set_piano_ee_vals();
    player zm_utility::function_814e28ebc00f977d( "piano_ee" );
    player thread function_aaf9ff3521dbffeb();
    player thread piano_ee_timeout();
    player thread function_70f93c3473ac5c4d();
    level waittill( #"piano_ee_closed", var_6b7ddb30cb82d43 );
    
    if ( isalive( player ) )
    {
        player zm_utility::take_fist( "piano_ee" );
        player val::reset( "scarab_piano_ee", "allow_movement" );
        player utility::delaythread( 3, &function_ff2f5f1b74c6a83 );
        
        if ( var_6b7ddb30cb82d43 )
        {
            level function_4503e79d988711c5( player );
        }
        else
        {
            player function_88abc6fa7872ca9d();
        }
    }
    
    if ( level.piano_ee.s_piano_sbl )
    {
        level.piano_ee.s_piano_sbl utility::function_7c10ea82c1e305b8( "anim", "close" );
    }
    
    if ( level.piano_ee.var_81c31c50d2d616cd < 3 )
    {
        level.piano_ee.var_24d0686e57d5f5c5.interaction utility::delaythread( 2, &utility::function_7c10ea82c1e305b8, "base", "extrasmall" );
    }
    
    level utility::flag_clear( "piano_ee_in_progress" );
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x2d749d5c, Offset: 0x1330
// Size: 0x56
function private set_piano_ee_vals()
{
    val::set( "scarab_piano_ee", "ignoreme", 1 );
    val::set( "scarab_piano_ee", "damage", 0 );
    val::set( "scarab_piano_ee", "allow_movement", 0 );
    val::set( "scarab_piano_ee", "allow_scripted_bgb_use", 0 );
    self.var_9ba469c390e7eb5 = 1;
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x7c29b633, Offset: 0x138e
// Size: 0x18
function private function_ff2f5f1b74c6a83()
{
    val::reset_all( "scarab_piano_ee" );
    self.var_9ba469c390e7eb5 = undefined;
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0x869bc7e2, Offset: 0x13ae
// Size: 0x11c
function private function_4503e79d988711c5( player )
{
    player function_88abc6fa7872ca9d();
    n_matched = level.piano_ee.var_3894b950b92ac20a;
    level utility::flag_set( level.piano_ee.var_f9332a938fe46877[ n_matched ] );
    var_2ba94133e51f8658 = level.piano_ee.var_ed44fde0f94be33f;
    level.piano_ee.var_ed44fde0f94be33f++;
    var_72efa215fb005207 = level.piano_ee.var_ed44fde0f94be33f >= 7;
    level.piano_ee.var_c8a3f04218f7f813 = 1;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_piano", #"hash_d39039c8ef113a5c", 1 );
    
    if ( var_72efa215fb005207 )
    {
        player utility::delaycall( 0.5, &playlocalsound, "evt_ee_complete_success_stinger" );
    }
    else
    {
        player utility::delaycall( 0.5, &playlocalsound, "evt_success_stinger" );
    }
    
    level utility::delaythread( 0.5, &function_5870e91176ed1da5, var_2ba94133e51f8658 );
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0xeebc1668, Offset: 0x14d2
// Size: 0x9c
function private function_aaf9ff3521dbffeb()
{
    if ( self.var_fdb89173b52f6163 )
    {
        return;
    }
    
    position = { #vertical_anchor:1, #horizontal_anchor:1, #top:0, #left:0 };
    widget_struct = { #position:position };
    ui::lui_registercallback( "zm_piano_puzzle_pressed", &function_aa473facc30fe6f0 );
    ui::lui_registercallback( "zm_piano_puzzle_close", &function_5ce6097898b0d5d8 );
    scripted_widgets::create( "piano_puzzle", "scripted_widget_piano_puzzle_zm", widget_struct );
    self.var_fdb89173b52f6163 = 1;
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0x32181393, Offset: 0x1576
// Size: 0x202
function private function_aa473facc30fe6f0( value )
{
    if ( isplayer( self ) )
    {
        self playrumbleonentity( "damage_heavy" );
    }
    
    switch ( value )
    {
        case 1:
            self playsound( "evt_scarab_piano_a_low" );
            break;
        case 2:
            self playsound( "evt_scarab_piano_b" );
            break;
        case 3:
            self playsound( "evt_scarab_piano_c" );
            break;
        case 4:
            self playsound( "evt_scarab_piano_d" );
            break;
        case 5:
            self playsound( "evt_scarab_piano_e" );
            break;
        case 6:
            self playsound( "evt_scarab_piano_f" );
            break;
        case 7:
            self playsound( "evt_scarab_piano_g" );
            break;
        case 8:
            self playsound( "evt_scarab_piano_a_high" );
            break;
        default:
            break;
    }
    
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    if ( level utility::flag( "piano_ee_complete" ) )
    {
        return;
    }
    
    if ( level.piano_ee.var_c8a3f04218f7f813 )
    {
        return;
    }
    
    level.piano_ee.var_32a093fd92b7b686[ level.piano_ee.var_32a093fd92b7b686.size ] = value;
    
    for ( i = 0; i < 7 ; i++ )
    {
        if ( level utility::flag( level.piano_ee.var_f9332a938fe46877[ i ] ) )
        {
            continue;
        }
        
        if ( function_a8f3f639742e8960( level.piano_ee.var_32a093fd92b7b686, level.piano_ee.a_songs[ i ] ) )
        {
            level.piano_ee.var_3894b950b92ac20a = i;
            level notify( #"piano_ee_closed", 1 );
            return;
        }
    }
}

// Namespace namespace_dfad1329c1734063
// Params 1, eflags: 0x4
// Checksum 0xebaf925e, Offset: 0x1780
// Size: 0x19
function private function_5ce6097898b0d5d8( value )
{
    level notify( #"piano_ee_closed", 0 );
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x18cfb8c1, Offset: 0x17a1
// Size: 0x46
function private function_88abc6fa7872ca9d()
{
    ui::function_c2505ff7b7fc55a4( "zm_piano_puzzle_pressed", &function_aa473facc30fe6f0 );
    ui::function_c2505ff7b7fc55a4( "zm_piano_puzzle_close", &function_5ce6097898b0d5d8 );
    scripted_widgets::destroy( "piano_puzzle" );
    self.var_fdb89173b52f6163 = undefined;
    self notify( #"hash_475f514df06784ec" );
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x43c7e100, Offset: 0x17ef
// Size: 0x8e, Type: bool
function private function_a8f3f639742e8960( a_pressed, var_a71f9070b44b0bb )
{
    if ( a_pressed.size < var_a71f9070b44b0bb.size )
    {
        return false;
    }
    
    n_max_start = a_pressed.size - var_a71f9070b44b0bb.size;
    
    for ( i = 0; i <= n_max_start ; i++ )
    {
        b_match = 1;
        
        for ( j = 0; j < var_a71f9070b44b0bb.size ; j++ )
        {
            if ( a_pressed[ i + j ] != var_a71f9070b44b0bb[ j ] )
            {
                b_match = 0;
                break;
            }
        }
        
        if ( b_match )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dfad1329c1734063
// Params 2, eflags: 0x4
// Checksum 0x443ddc0f, Offset: 0x1886
// Size: 0x28e
function private function_5870e91176ed1da5( var_2ba94133e51f8658, b_force_spawn_item = 0 )
{
    level endon( #"game_ended" );
    v_origin = level.piano_ee.var_24d0686e57d5f5c5.origin;
    landing_origin = utility::getstruct( "ee_piano_rewards", "targetname" ).origin;
    n_essence = level.piano_ee.var_3ec362be765f243b[ var_2ba94133e51f8658 ];
    n_essence_count = int( n_essence / 100 );
    b_spawn_item = b_force_spawn_item || var_2ba94133e51f8658 == 6;
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( landing_origin, v_origin );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 10;
    spawnoptions.var_34444f0dda11f0d5 = 10;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_789c456dda9c8572 = v_origin;
    spawnoptions.var_44d5025c8cfbd48e = n_essence_count + ( b_spawn_item ? 1 : 0 );
    
    if ( b_spawn_item )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, hashcat( #"hash_fd71a17de0ed110e", var_2ba94133e51f8658 ) );
        a_reward_items = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_piano", #"default", v_origin );
        
        foreach ( item_name in a_reward_items )
        {
            itembundle = common_item::function_90c3e0c1fd55d6b6( item_name );
            
            if ( common_item::function_16e8c106491eeaca( itembundle ) == "weapon" )
            {
                item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
            }
            else
            {
                common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
            }
            
            wait 0.1;
        }
    }
    
    if ( var_2ba94133e51f8658 == 0 )
    {
        s_piano_intel = utility::getstruct( "scarab_doc_5" );
        intel::spawn_intel_at_location( undefined, undefined, s_piano_intel.origin, s_piano_intel.angles, "zmintel_sat_scarab_document_5" );
    }
    
    for ( i = 0; i < n_essence_count ; i++ )
    {
        common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_essence_small", undefined, spawnoptions );
        wait 0.1;
    }
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x87251b3f, Offset: 0x1b1c
// Size: 0x42
function private piano_ee_timeout()
{
    level endon( #"game_ended" );
    level endon( #"piano_ee_closed" );
    self endon( #"hash_475f514df06784ec" );
    self endon( #"death_or_disconnect" );
    wait 30;
    level notify( #"piano_ee_closed", 0 );
}

// Namespace namespace_dfad1329c1734063
// Params 0, eflags: 0x4
// Checksum 0x118192ac, Offset: 0x1b66
// Size: 0x40
function private function_70f93c3473ac5c4d()
{
    level endon( #"game_ended" );
    level endon( #"piano_ee_closed" );
    self endon( #"hash_475f514df06784ec" );
    self waittill( #"death_or_disconnect" );
    level notify( #"piano_ee_closed", 0 );
}

/#

    // Namespace namespace_dfad1329c1734063
    // Params 0, eflags: 0x4
    // Checksum 0x3d19f289, Offset: 0x1bae
    // Size: 0x2e, Type: dev
    function private init_piano_ee_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x5b>", &function_1e07afc305485bb3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_dfad1329c1734063
    // Params 0, eflags: 0x4
    // Checksum 0x39a5ab80, Offset: 0x1be4
    // Size: 0x11, Type: dev
    function private function_1e07afc305485bb3()
    {
        level thread function_5870e91176ed1da5( 6, 1 );
    }

#/
