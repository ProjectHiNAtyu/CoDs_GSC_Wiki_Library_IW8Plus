// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_grp_challenge.gsc  (hash_34601864b5716bc8.gscc) (size: 17522 Bytes / 0x4472 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x571efdc (91353052)
// size ...... 17522 (0x4472)
// includes .. 14  (offset: 0x3f6e)
// strings ... 68  (offset: 0x3fde)
// dev strs .. 5   (offset: 0x442a)
// exports ... 43  (offset: 0x2856)
// cseg ...... 0x743 + 0x2113 (0x2856)
// imports ... 135 (offset: 0x2f0e)
// animtree1 . 0   (offset: 0x4472)
// animtree2 . 0   (offset: 0x4472)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_audio;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_scarab_ee_grp_challenge;

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0, eflags: 0x5
// Checksum 0x8c8e22bf, Offset: 0x761
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_grp_challenge", undefined, undefined, &post_init );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x78430fef, Offset: 0x782
// Size: 0x1f0
function post_init()
{
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level._effect[ "ee_grp_clg_ring" ] = loadfxasset( "vfx_t10_levels_zm_jade_parachute_rings_loop" );
    level._effect[ "ee_grp_clg_bunny_cover" ] = loadfxasset( "vfx_sat_levels_zm_firefly_fog_spawning" );
    level._effect[ "ee_grp_clg_bunny_reward" ] = loadfxasset( "vfx_t10_levels_zm_garnet_bunny_bowling_dance_loop" );
    level._effect[ "ee_grp_clg_ring_spawn" ] = loadfxasset( "vfx_t10_levels_zm_jade_parachute_rings_spawn" );
    zm_quest::register_quest_step( #"hash_ee671a1fa81f1a29", #"hash_59ba6dd27ad7c819", &function_bd96cd307fa83ede, &function_c6ff246bf09f7d8f );
    zm_quest::register_quest_step( #"hash_ee671a1fa81f1a29", #"first_attempt", &setup_first_attempt, &cleanup_first_attempt );
    zm_quest::register_quest_step( #"hash_ee671a1fa81f1a29", #"following_attempts", &setup_following_attempts, &cleanup_following_attempts );
    level utility::flag_wait_all( "zm_sat_scarab_ee_grp_challenge_cs_completed", "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_ee671a1fa81f1a29" );
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( #"player_connect", &on_player_connect );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_18c52c6a6f5a606", &function_ba24ec3b8e7d2f53 );
    
    foreach ( p in level.players )
    {
        p callback::add( #"hash_db23ebf23acc8885", &function_4b6cf7411e65974d );
    }
    
    /#
        level thread init_debug();
    #/
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xa763b21, Offset: 0x97a
// Size: 0x18
function on_round_start( params )
{
    level notify( #"hash_72a543330d5b7560" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xad6079e9, Offset: 0x99a
// Size: 0x21
function on_player_connect( params )
{
    callback::add( #"hash_db23ebf23acc8885", &function_4b6cf7411e65974d );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xfae70bbc, Offset: 0x9c3
// Size: 0x100
function function_4b6cf7411e65974d( params )
{
    level endon( #"game_ended" );
    
    if ( isdefined( params.entity ) && isdefined( params.entity.interact ) )
    {
        params.entity notify( #"hash_c1be6044b5e414bc" );
        params.entity setscriptablepartstate( "amb_fx", "off" );
        params.entity setscriptablepartstate( "kill_fx", "on" );
        params.entity moveto( self gettagorigin( "j_spine4" ), distance( params.entity.origin, self gettagorigin( "j_spine4" ) ) / 1000 );
        params.entity waittill( #"movedone" );
        params.entity.interact function_ebccf10a0951ec1a( self, 0 );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x403876b6, Offset: 0xacb
// Size: 0x1ec
function function_bd96cd307fa83ede( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( !isdefined( level.var_60a09ca9b9f6e187 ) )
    {
        level.var_60a09ca9b9f6e187 = [];
    }
    
    a_part_locs = utility::getstructarray( "ee_grp_bunny_part", "script_noteworthy" );
    
    foreach ( loc in a_part_locs )
    {
        sbl = utility::spawn_model( loc.script_label, loc.origin, loc.angles );
        loc.sbl = sbl;
        
        if ( getdvarint( @"hash_ed2708c34e34087b", 0 ) )
        {
            /#
                sbl thread drawsphere();
            #/
        }
        
        level.var_60a09ca9b9f6e187[ level.var_60a09ca9b9f6e187.size ] = sbl;
        interact = zm_quest::function_91f9590e98d57ff6( sbl.origin, &function_ebccf10a0951ec1a, &function_8430ddd4727558ee );
        interact.owner = sbl;
        sbl.interact = interact;
        
        if ( loc.do_bob == "1" )
        {
            sbl thread function_e6134faf57a42642();
        }
    }
    
    doorbuy_flags = [ "southeast_temple_door_bought", "northeast_temple_door_bought", "zm_sat_scarab_doorbuy_westwing_to_ext_opened", "to_nw_temple_transition_bought", "northwest_temple_door_bought", "southwest_temple_finalroom_door_bought", "southwest_temple_door_bought" ];
    level waittill( #"hash_8fe83d562251f39" );
    level utility::flag_wait_all_array( doorbuy_flags );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x1032269f, Offset: 0xcbf
// Size: 0x20
function function_c6ff246bf09f7d8f( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 3
// Checksum 0x6b8274e4, Offset: 0xce7
// Size: 0x12c
function function_ebccf10a0951ec1a( player, isplayfx = 1, isplaysound = 1 )
{
    level endon( #"game_ended" );
    level.var_60a09ca9b9f6e187 = arrayremove( level.var_60a09ca9b9f6e187, self.owner );
    
    if ( isplayfx )
    {
        self.owner setscriptablepartstate( "kill_fx", "on" );
    }
    
    waitframe();
    
    if ( self.owner.mover )
    {
        self.owner.mover delete();
    }
    
    if ( self.owner )
    {
        self.owner delete();
    }
    
    if ( self )
    {
        self freescriptable();
    }
    
    if ( player && isplaysound )
    {
        player playsoundtoplayer( "evt_scarab_peeks_pickup", player );
    }
    
    if ( level.var_60a09ca9b9f6e187.size <= 0 )
    {
        level notify( #"hash_8fe83d562251f39" );
    }
    
    if ( !player.var_4bbd724e5e5353db )
    {
        player.var_4bbd724e5e5353db = 1;
        player thread play_vo( "ee_grp_pickup_part", 1 );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x652524df, Offset: 0xe1b
// Size: 0x36
function function_8430ddd4727558ee( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x674986fa, Offset: 0xe5a
// Size: 0x70
function function_e6134faf57a42642()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_c1be6044b5e414bc" );
    
    while ( true )
    {
        self movez( 10, 2, 0.5, 0.5 );
        self waittill( #"movedone" );
        self movez( -10, 2, 0.5, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x32e6febf, Offset: 0xed2
// Size: 0xea
function setup_first_attempt( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    utility::flag_wait( "begin_round_logic" );
    s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
    
    foreach ( player in level.players )
    {
        player function_ac5583d5a07e152a( s_spawn_loc );
    }
    
    zm_quest::function_91f9590e98d57ff6( s_spawn_loc.origin, &use_bunny, &function_def9501371ee287a );
    level waittill( #"hash_ef4a5e031b45685e" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x805dc3a1, Offset: 0xfc4
// Size: 0xe2
function cleanup_first_attempt( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        utility::flag_wait( "begin_round_logic" );
        player = level.players[ 0 ];
        
        if ( !isdefined( player.var_6668ab8981792f03 ) )
        {
            player.var_6668ab8981792f03 = 0;
        }
        
        player.var_6668ab8981792f03 = zm_quest::function_73720cdf21c3cfd7( #"hash_ee671a1fa81f1a29", #"grp_attempts" );
        
        if ( player.var_6668ab8981792f03 >= 3 )
        {
            player.var_6668ab8981792f03 = 3;
            return;
        }
        
        s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
        player function_ac5583d5a07e152a( s_spawn_loc );
        zm_quest::function_91f9590e98d57ff6( s_spawn_loc.origin, &use_bunny, &function_def9501371ee287a );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xf7d3510e, Offset: 0x10ae
// Size: 0x11b
function function_ac5583d5a07e152a( s_spawn_loc )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.var_533faf8cb5aa4335 )
    {
        return;
    }
    
    team_select_payload = [ #"teamselect", self getentitynumber() ];
    sbl = spawnscriptable( "sat_zm_scarab_ee_grp_challenge_bunny", s_spawn_loc.origin, s_spawn_loc.angles, undefined, team_select_payload );
    sbl.var_7a65426f252841e7 = 1;
    sbl.owner = self;
    self.var_26e05e8b41abad3 = sbl;
    
    if ( !isdefined( self.var_6668ab8981792f03 ) )
    {
        self.var_6668ab8981792f03 = 0;
    }
    
    fx_tag = utility::spawn_model( "tag_origin", self.var_26e05e8b41abad3.origin );
    playfxontagforclients( level._effect[ "ee_grp_clg_bunny_cover" ], fx_tag, "tag_origin", self );
    playsoundatpos( self.origin, "evt_portal_open" );
    waitframe();
    fx_tag delete();
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x85d449fc, Offset: 0x11d1
// Size: 0x97
function function_b063e55da75b8e37()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_26e05e8b41abad3 )
    {
        return;
    }
    
    self.var_26e05e8b41abad3 freescriptable();
    fx_tag = utility::spawn_model( "tag_origin", self.var_26e05e8b41abad3.origin );
    playfxontagforclients( level._effect[ "ee_grp_clg_bunny_cover" ], fx_tag, "tag_origin", self );
    playsoundatpos( self.origin, "evt_portal_open" );
    waitframe();
    fx_tag delete();
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xd6d9a9, Offset: 0x1270
// Size: 0x70
function use_bunny( player )
{
    if ( player.var_533faf8cb5aa4335 )
    {
        return;
    }
    
    if ( !player.var_26e05e8b41abad3 )
    {
        return;
    }
    
    if ( utility::flag( "ee_grp_clg_in_busy" ) )
    {
        return;
    }
    
    if ( utility::flag( "temple_lockdown_active" ) )
    {
        return;
    }
    
    if ( player.var_6668ab8981792f03 >= 3 )
    {
        return;
    }
    
    level thread function_793f11e96e25347c( player.var_26e05e8b41abad3, player );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x9a24be4a, Offset: 0x12e8
// Size: 0x36
function function_def9501371ee287a( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0xfdde8745, Offset: 0x1327
// Size: 0x232
function function_793f11e96e25347c( var_fd8c56aed200fd72, player )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( player.var_6668ab8981792f03 ) )
    {
        player.var_6668ab8981792f03 = 0;
    }
    
    player.var_6668ab8981792f03++;
    
    if ( player.var_6668ab8981792f03 > 3 )
    {
        player.var_6668ab8981792f03 = 3;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hash_ee671a1fa81f1a29", #"grp_attempts", player.var_6668ab8981792f03 );
    var_24dc036a2bd9a4e0 = player equipment_mp::getcurrentequipment( "secondary" );
    
    if ( var_24dc036a2bd9a4e0 == "equip_grappling_hook" || var_24dc036a2bd9a4e0 == "equip_grappling_hook_upgraded" )
    {
        player zm_ncfdpedestal::force_end_grapple( undefined );
    }
    else
    {
        player notify( #"hash_3dc891bbb01bfa85" );
    }
    
    player thread function_27ab8ff9b59ec6c4();
    
    foreach ( p in level.players )
    {
        if ( p == player )
        {
            continue;
        }
        
        p function_b063e55da75b8e37();
    }
    
    mover = utility::spawn_model( "tag_origin", var_fd8c56aed200fd72.origin, var_fd8c56aed200fd72.angles );
    var_fd8c56aed200fd72 utility::scriptable_setparententity( mover );
    mover rotateyaw( 90, 0.1 );
    var_fd8c56aed200fd72 setscriptablepartstate( "base", "active" );
    var_fd8c56aed200fd72 setscriptablepartstate( "anim", "dance_one_shot" );
    player playsoundtoplayer( "evt_sq_bowling_ball_bunny_end_showup_laugh", player );
    mover playsound( "evt_scarab_peeks_grp_activate" );
    wait 2.6;
    mover delete();
    player thread function_6c5bed0bb81f85bf();
    player thread timeout_watcher();
    player thread function_8b6565d57cd56dc2();
    player thread disconnect_watcher();
    player thread play_vo( "ee_grp_start_challenge", 1 );
    player thread zm_ncfdpedestal::function_8e1671683c63ebb6();
    player zm_ncfdpedestal::give_grappling_hook( self );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xe03afb9a, Offset: 0x1561
// Size: 0x16d
function function_6c5bed0bb81f85bf()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"ee_grp_timeout" );
    self endon( #"ee_grp_force_quit" );
    level.var_b670785523b76244 = gettime();
    thread set_timer_ui();
    thread function_a93652c29331c84c();
    utility::waittill_any( "ee_grp_timeout", "ee_grp_completed", "ee_grp_force_quit" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    
    if ( utility::ent_flag( "ee_grp_completed" ) )
    {
        thread play_vo( "ee_grp_complete_challenge", 1 );
        spawn_rewards();
        level notify( #"hash_ef4a5e031b45685e" );
    }
    
    thread function_44ac76c9c7a85669();
    s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
    
    foreach ( p in level.players )
    {
        if ( p == self )
        {
            continue;
        }
        
        p thread function_ac5583d5a07e152a( s_spawn_loc );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x2557b65b, Offset: 0x16d6
// Size: 0x10b
function function_a93652c29331c84c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"ee_grp_timeout" );
    self endon( #"ee_grp_force_quit" );
    self.var_26e05e8b41abad3.s_next_goal = undefined;
    self.var_26e05e8b41abad3.s_next_goal = set_next_goal( self );
    
    while ( self.var_26e05e8b41abad3.s_next_goal )
    {
        if ( distance( self.origin, self.var_26e05e8b41abad3.s_next_goal.origin ) < 142 )
        {
            self.var_26e05e8b41abad3.s_next_goal = set_next_goal( self );
            
            if ( !isdefined( self.var_5c53eb107f4e413c ) )
            {
                self.var_5c53eb107f4e413c = 0;
            }
            
            self.var_5c53eb107f4e413c += 2.5;
            self playsoundtoplayer( "evt_portal_open", self );
        }
        
        waitframe();
    }
    
    utility::ent_flag_set( "ee_grp_completed" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xa60c0736, Offset: 0x17e9
// Size: 0x4b
function timeout_watcher()
{
    level endon( #"game_ended" );
    self endon( #"ee_grp_completed" );
    self endon( #"death" );
    self endon( #"ee_grp_force_quit" );
    self waittill( #"hash_3dc891bbb01bfa85" );
    reset_challenge( "ee_grp_timeout" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xcafdc968, Offset: 0x183c
// Size: 0x56
function function_8b6565d57cd56dc2()
{
    level endon( #"game_ended" );
    self endon( #"ee_grp_completed" );
    self endon( #"death" );
    self endon( #"ee_grp_timeout" );
    
    while ( true )
    {
        if ( utility::flag( "temple_lockdown_active" ) )
        {
            reset_challenge( "ee_grp_force_quit" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x4b07abcd, Offset: 0x189a
// Size: 0xd3
function disconnect_watcher()
{
    level endon( #"game_ended" );
    self endon( #"ee_grp_completed" );
    self endon( #"ee_grp_timeout" );
    self endon( #"ee_grp_force_quit" );
    self waittill( #"death_or_disconnect" );
    s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
    
    foreach ( p in level.players )
    {
        p thread function_ac5583d5a07e152a( s_spawn_loc );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xbd2d8fa5, Offset: 0x1975
// Size: 0x194
function reset_challenge( str_notify )
{
    self playsoundtoplayer( "evt_ee_fail_stinger", self );
    
    if ( self.var_26e05e8b41abad3 && self.var_26e05e8b41abad3.s_next_goal && self.var_26e05e8b41abad3.s_next_goal.fx )
    {
        killfxontag( level._effect[ "ee_grp_clg_ring" ], self.var_26e05e8b41abad3.s_next_goal.fx, "tag_origin" );
        self.var_26e05e8b41abad3.s_next_goal.fx delete();
    }
    
    self notify( str_notify );
    thread function_44ac76c9c7a85669();
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
    
    foreach ( p in level.players )
    {
        if ( p == self )
        {
            continue;
        }
        
        p thread function_ac5583d5a07e152a( s_spawn_loc );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xf9820f4e, Offset: 0x1b11
// Size: 0xb0
function set_timer_ui()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"ee_grp_completed" );
    self endon( #"ee_grp_force_quit" );
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    zm_quest::function_fb3af5600f6a9441( 2, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
    thread function_85d30e7e7d1b8f7a();
    
    while ( true )
    {
        n_time = gettime() - level.var_b670785523b76244;
        zm_quest::function_612a9ad0db22c29c( n_time, 0, #"hash_ee671a1fa81f1a29", #"first_attempt" );
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xf7fcc5e2, Offset: 0x1bc9
// Size: 0x55
function function_85d30e7e7d1b8f7a()
{
    level endon( #"game_ended" );
    self endon( #"ee_grp_completed" );
    self endon( #"death" );
    self endon( #"ee_grp_force_quit" );
    self endon( #"ee_grp_timeout" );
    
    while ( true )
    {
        self playsoundtoplayer( "evt_scarab_grp_timer_1sec", self );
        wait 1;
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0xc5fa3bc6, Offset: 0x1c26
// Size: 0x1ad
function set_next_goal( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    pre_goal = player.var_26e05e8b41abad3.s_next_goal;
    
    if ( !pre_goal )
    {
        pre_goal = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
        pre_goal.fx = utility::spawn_model( "tag_origin", pre_goal.origin, pre_goal.angles );
    }
    
    if ( pre_goal.fx )
    {
        killfxontag( level._effect[ "ee_grp_clg_ring" ], pre_goal.fx, "tag_origin" );
    }
    
    if ( !pre_goal.target )
    {
        return;
    }
    
    playfxontagforclients( level._effect[ "ee_grp_clg_ring_spawn" ], pre_goal.fx, "tag_origin", player );
    waitframe();
    pre_goal.fx delete();
    s_next_goal = utility::getstruct( pre_goal.target, "targetname" );
    s_next_goal.fx = utility::spawn_model( "tag_origin", s_next_goal.origin, s_next_goal.angles + ( 90, 0, 0 ) );
    s_next_goal.fx thread function_aead9a0e1dd45198();
    playfxontagforclients( level._effect[ "ee_grp_clg_ring" ], s_next_goal.fx, "tag_origin", player );
    player.var_26e05e8b41abad3 thread function_834e4131c2eb400a( s_next_goal );
    return s_next_goal;
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xb5476411, Offset: 0x1ddc
// Size: 0x49
function function_aead9a0e1dd45198()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"deleted" );
    wait 60;
    killfxontag( level._effect[ "ee_grp_clg_ring" ], self, "tag_origin" );
    self delete();
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1
// Checksum 0x4238c2ac, Offset: 0x1e2d
// Size: 0x193
function function_834e4131c2eb400a( s_next_ring )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"deleted" );
    
    if ( self.mover )
    {
        self.mover delete();
    }
    
    self notify( #"hash_d7a34a8909e46c64" );
    mover = utility::spawn_model( "tag_origin", self.origin );
    var_247d22c685c1b9db = s_next_ring.origin - mover.origin;
    mover.angles = axistoangles( var_247d22c685c1b9db, vectorcross( var_247d22c685c1b9db, ( 0, 0, 1 ) ), ( 0, 0, 1 ) );
    utility::scriptable_clearparententity();
    waitframe();
    
    if ( mover )
    {
        utility::scriptable_setparententity( mover );
        self.mover = mover;
        time = distance( mover.origin, s_next_ring.origin ) / 1500;
        mover moveto( s_next_ring.origin, time );
        mover thread utility::play_loop_sound_on_entity( "evt_trail_lp" );
        mover waittill( #"movedone" );
        mover thread utility::stop_loop_sound_on_entity( "evt_trail_lp" );
        self notify( #"hash_d7a34a8909e46c64" );
        utility::scriptable_clearparententity();
        waitframe();
        
        if ( self.mover )
        {
            self.mover delete();
        }
        
        waitframe();
        self.angles = s_next_ring.angles;
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x4cd33d88, Offset: 0x1fc8
// Size: 0x100
function function_44ac76c9c7a85669()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"death_or_disconnect" );
    self.var_533faf8cb5aa4335 = 1;
    fx_tag = utility::spawn_model( "tag_origin", self.var_26e05e8b41abad3.origin );
    playfxontagforclients( level._effect[ "ee_grp_clg_bunny_cover" ], fx_tag, "tag_origin", self );
    waitframe();
    fx_tag delete();
    function_b063e55da75b8e37();
    
    while ( true )
    {
        n_round_wait = 0;
        level waittill( #"hash_72a543330d5b7560" );
        n_round_wait++;
        
        if ( n_round_wait == 1 )
        {
            break;
        }
    }
    
    self.var_533faf8cb5aa4335 = 0;
    s_spawn_loc = utility::getstruct( "ee_grp_clg_bunny_loc_source", "script_noteworthy" );
    
    if ( !utility::flag( "ee_grp_clg_in_busy" ) && self.var_6668ab8981792f03 < 3 )
    {
        function_ac5583d5a07e152a( s_spawn_loc );
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x2bdb30cb, Offset: 0x20d0
// Size: 0x43
function function_27ab8ff9b59ec6c4()
{
    level endon( #"game_ended" );
    level utility::flag_set( "ee_grp_clg_in_busy" );
    utility::waittill_any( "ee_grp_timeout", "ee_grp_completed", "ee_grp_force_quit", "death_or_disconnect" );
    level utility::flag_clear( "ee_grp_clg_in_busy" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0xf89ed4d9, Offset: 0x211b
// Size: 0x3b6
function spawn_rewards()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self playsoundtoplayer( "evt_sq_bowling_ball_bunny_end_showup_laugh", self );
    n_time_spent = utility::function_6f5d2e1f1ff70482( gettime() - level.var_b670785523b76244 );
    s_source_loc = utility::getstruct( "ee_grp_clg_rwd_loc_start", "script_noteworthy" );
    v_end_loc = utility::getstruct( "ee_grp_clg_rwd_loc_end", "script_noteworthy" ).origin;
    
    if ( n_time_spent < 60 )
    {
        level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_1ecbe1cb707c4156", #"hash_7f142f510dae3c5f", [ self ] );
    }
    
    if ( self && self.var_26e05e8b41abad3 )
    {
        self.var_26e05e8b41abad3 utility::scriptable_clearparententity();
        self.var_26e05e8b41abad3.origin = s_source_loc.origin;
        self.var_26e05e8b41abad3.angles = s_source_loc.angles;
        self.var_26e05e8b41abad3 setscriptablepartstate( "anim", "dance_loop" );
    }
    
    fx_tag = utility::spawn_model( "tag_origin", s_source_loc.origin + ( 0, 0, 8 ) );
    playfxontagforclients( level._effect[ "ee_grp_clg_bunny_reward" ], fx_tag, "tag_origin", self );
    wait 6;
    playfxontagforclients( level._effect[ "ee_grp_clg_bunny_cover" ], fx_tag, "tag_origin", self );
    stopfxontag( level._effect[ "ee_grp_clg_bunny_reward" ], fx_tag, "tag_origin" );
    self playsoundtoplayer( "evt_ee_complete_success_stinger", self );
    waitframe();
    fx_tag delete();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_b063e55da75b8e37();
    var_d247615ce2878f0f = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_grp_challenge_rwd_mustdrop", "default" );
    
    for ( i = 0; i < var_d247615ce2878f0f.size ; i++ )
    {
        if ( var_d247615ce2878f0f[ i ] )
        {
            random_point = getrandomnavpoint( v_end_loc, 100 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_d247615ce2878f0f[ i ], s_source_loc.origin, random_point, undefined, 1 );
            wait 0.1;
        }
    }
    
    var_57c98234a2d21fb3 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_grp_challenge_rwd_low", "default" );
    
    if ( n_time_spent < 60 )
    {
        var_57c98234a2d21fb3 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_grp_challenge_rwd_high", "default" );
        
        if ( !isdefined( self.var_2dc35ba786606f7c ) )
        {
            self.var_2dc35ba786606f7c = 0;
        }
        
        self.var_2dc35ba786606f7c++;
        
        if ( self.var_2dc35ba786606f7c == 2 )
        {
            if ( !level utility::flag( "oscar_helmet_has_dropped" ) )
            {
                level utility::flag_set( "oscar_helmet_has_dropped" );
                random_point = getrandomnavpoint( v_end_loc, 100 ) + ( 0, 0, 4 );
                oscar_helmet = zm_quest::spawn_quest_item( random_point, ( 0, 0, 0 ), %"hash_47c51773059c4144" );
                
                if ( oscar_helmet )
                {
                    oscar_helmet thread function_3301ad4fa77ed470();
                }
            }
        }
    }
    
    /#
        if ( level.var_20482a34a823e14c )
        {
            random_point = getrandomnavpoint( v_end_loc, 100 ) + ( 0, 0, 4 );
            oscar_helmet = zm_quest::spawn_quest_item( random_point, ( 0, 0, 0 ), %"hash_47c51773059c4144" );
            
            if ( oscar_helmet )
            {
                oscar_helmet thread function_3301ad4fa77ed470();
            }
        }
    #/
    
    for ( i = 0; i < var_57c98234a2d21fb3.size ; i++ )
    {
        if ( var_57c98234a2d21fb3[ i ] )
        {
            random_point = getrandomnavpoint( v_end_loc, 100 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_57c98234a2d21fb3[ i ], v_end_loc, random_point, undefined, 1 );
            wait 0.1;
        }
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 0
// Checksum 0x3582acd9, Offset: 0x24d9
// Size: 0xad
function function_3301ad4fa77ed470()
{
    level endon( #"game_ended" );
    bobbing_tag = utility::spawn_model( "tag_origin", self.origin );
    localangles = combineangles( invertangles( bobbing_tag.angles ), self.angles );
    localorigin = rotatevectorinverted( self.origin - bobbing_tag.origin, bobbing_tag.origin );
    self scriptablesetparententity( bobbing_tag, localorigin, localangles );
    bobbing_tag function_616378d7e5b22efb( ( 0, 0, 1 ), 3, 3 );
    thread utility::delete_on_death( bobbing_tag );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 1, eflags: 0x4
// Checksum 0xfcadbc0c, Offset: 0x258e
// Size: 0x18
function private function_ba24ec3b8e7d2f53( params )
{
    level notify( #"hash_8fe83d562251f39" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x74f0034f, Offset: 0x25ae
// Size: 0x2b
function setup_following_attempts( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    iprintln( "Following attempts start" );
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0xa852e27d, Offset: 0x25e1
// Size: 0x20
function cleanup_following_attempts( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_scarab_ee_grp_challenge
// Params 2
// Checksum 0x28923863, Offset: 0x2609
// Size: 0x86
function play_vo( str_vo_to_play, var_1fc51011987c93fe )
{
    level endon( #"game_ended" );
    
    if ( zm_sat_scarab_audio::function_7606443c19ef441e() )
    {
        return;
    }
    
    var_d737580b6b81a394 = "";
    
    if ( var_1fc51011987c93fe )
    {
        var_d737580b6b81a394 = #"bc_flavor_player_positive";
    }
    else
    {
        var_d737580b6b81a394 = #"bc_flavor_player_negative";
    }
    
    utility::flag_set( "scarab_mq_vo_playing" );
    wait 0.5;
    
    if ( self )
    {
        namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( str_vo_to_play, var_d737580b6b81a394 );
    }
    
    utility::flag_clear( "scarab_mq_vo_playing" );
}

/#

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0xc6e1a5e5, Offset: 0x2697
    // Size: 0x5a, Type: dev
    function init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3f>", "<dev string:x3f>", &function_d9e438665d9c8640 );
        devgui::add_devgui_func( "<dev string:x50>", "<dev string:x50>", &function_20482a34a823e14c );
        devgui::add_devgui_func( "<dev string:x68>", "<dev string:x68>", &function_55354c7fe925680e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0x6b83cbde, Offset: 0x26f9
    // Size: 0x70, Type: dev
    function function_55354c7fe925680e()
    {
        random_point = getrandomnavpoint( level.players[ 0 ].origin, 100 ) + ( 0, 0, 4 );
        oscar_helmet = zm_quest::spawn_quest_item( random_point, ( 0, 0, 0 ), %"hash_47c51773059c4144" );
        
        if ( oscar_helmet )
        {
            oscar_helmet thread function_3301ad4fa77ed470();
        }
    }

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0x1b66e112, Offset: 0x2771
    // Size: 0x10, Type: dev
    function function_20482a34a823e14c()
    {
        level.var_20482a34a823e14c = 1;
    }

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0x6ac81b28, Offset: 0x2789
    // Size: 0x6a, Type: dev
    function drawsphere()
    {
        self notify( #"hash_b23cd7b2da9dc130" );
        self endon( #"hash_b23cd7b2da9dc130" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            sphere( self.origin, 20, color, 0 );
            waitframe();
        }
    }

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0xe382c216, Offset: 0x27fb
    // Size: 0x41, Type: dev
    function show_time_spend()
    {
        level endon( #"game_ended" );
        level endon( #"hash_ef4a5e031b45685e" );
        
        while ( true )
        {
            iprintln( utility::function_6f5d2e1f1ff70482( gettime() - level.var_b670785523b76244 ) );
            wait 1;
        }
    }

    // Namespace zm_sat_scarab_ee_grp_challenge
    // Params 0
    // Checksum 0x395b60a8, Offset: 0x2844
    // Size: 0x12, Type: dev
    function function_d9e438665d9c8640()
    {
        level utility::flag_set( "<dev string:x7b>" );
    }

#/
