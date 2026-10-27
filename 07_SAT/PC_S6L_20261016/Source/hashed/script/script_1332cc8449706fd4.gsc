// script_1332cc8449706fd4  (hash_1332cc8449706fd4.gscc) (size: 23767 Bytes / 0x5cd7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a5d843b (710771771)
// size ...... 23767 (0x5cd7)
// includes .. 13  (offset: 0x54ff)
// strings ... 60  (offset: 0x5567)
// dev strs .. 70  (offset: 0x590f)
// exports ... 59  (offset: 0x3707)
// cseg ...... 0x5a1 + 0x3166 (0x3707)
// imports ... 162 (offset: 0x403f)
// animtree1 . 0   (offset: 0x5cd7)
// animtree2 . 0   (offset: 0x5cd7)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_c8cd07bc5a017259;

// Namespace namespace_c8cd07bc5a017259
// Params 0, eflags: 0x5
// Checksum 0x29beb7d, Offset: 0x5bf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_two_sister_ee", undefined, undefined, &init );
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x820d911d, Offset: 0x5e0
// Size: 0x2d6
function init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level utility::flag_wait_all( "zm_sat_firefly_script_two_sister_ee_cs_completed", "zm_quest_initialized", "scriptables_ready", "ts_ee_tv_spawned" );
    level._effect[ "ts_ee_scene_spawn" ] = loadfxasset( "vfx_sat_zm_two_sisters_spawn" );
    level._effect[ "ts_ee_reward_spawn" ] = loadfxasset( "vfx_t10_levels_zm_opal_ritual_bowl_transition" );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_c274ed6b4b9de228", &function_8320f7edb73a569, &function_44565824795ed12 );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_ccfe066b521dbcb8", &function_f71fe67ecdff5371, &function_d587fa822425b3b6 );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_336769656fcd940c", &function_d4e47ba39d8eb2cf, &function_2f7c0219fa8e1cfe );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_d4b2516b5634fe5b", &function_ea20bb7ec506821e, &function_e6a7058231a7d839 );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_3e77926576bf7064", &function_ff3c16a3bc292cbb, &function_4747719db322caa );
    zm_quest::register_quest_step( #"hash_716fd2fd2970f520", #"hash_4798d797af39df3e", &function_319d2ddc7147c561, &function_1d1b62f7d59750b0 );
    s_tv_loc = utility::getstruct( "ts_ee_tv_loc", "script_noteworthy" );
    var_4240bf4125bcb8cc = utility::getstruct( s_tv_loc.target, "targetname" );
    level.var_eafc3735139d91e1.my_interact = zm_quest::function_91f9590e98d57ff6( var_4240bf4125bcb8cc.origin, &use_tv, &use_tv_hint );
    level.var_eafc3735139d91e1.my_interact.my_owner = level.var_eafc3735139d91e1;
    
    if ( !isdefined( level.var_6ec10f74b02b432b ) )
    {
        level.var_6ec10f74b02b432b = [];
    }
    
    if ( !isdefined( level.var_a76e0b4678c282e6 ) )
    {
        level.var_a76e0b4678c282e6 = [];
    }
    
    level utility::flag_wait( "begin_round_logic" );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_716fd2fd2970f520" );
    level.var_3756ac23f385af87 = getnoentvolumearray( "check_players_in_tv_room", "script_noteworthy" )[ 0 ];
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( #"player_connect", &on_player_connect );
    var_5a7440038d2f4183 = utility::getstruct( "ts_ee_chalk_draw_loc", "script_noteworthy" );
    spawnscriptable( "zm_sat_firefly_two_sister_ee_chalk_drawing", var_5a7440038d2f4183.origin, var_5a7440038d2f4183.angles );
    level.var_8579e313c0fd5de = [ "noise_1", "noise_2", "noise_3", "noise_4" ];
    
    /#
        init_debug();
    #/
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0x10ea8b49, Offset: 0x8be
// Size: 0x5f
function use_tv( player )
{
    if ( !utility::flag( "ts_ee_all_players_can_use_tv" ) )
    {
        if ( !arraycontains( level.var_6ec10f74b02b432b, player ) )
        {
            return;
        }
    }
    
    if ( !function_36f655ed6710e5d0( player ) )
    {
        return;
    }
    
    if ( utility::flag( "ts_ee_use_tv_in_cd" ) )
    {
        return;
    }
    
    level notify( #"ts_ee_use_tv" );
    level thread use_tv_cd();
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0xc37c6e08, Offset: 0x925
// Size: 0x36
function use_tv_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0xda3da95b, Offset: 0x964
// Size: 0x29
function use_tv_cd()
{
    level endon( #"game_ended" );
    utility::flag_set( "ts_ee_use_tv_in_cd" );
    wait 1;
    utility::flag_clear( "ts_ee_use_tv_in_cd" );
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0x798ce868, Offset: 0x995
// Size: 0x197
function function_1a8c1cec23118bd0( players )
{
    level endon( #"game_ended" );
    level endon( #"hash_416321d98850a098" );
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        player.var_bee25557c00cac5d = 0;
    }
    
    while ( true )
    {
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( function_36f655ed6710e5d0( player ) )
            {
                if ( !player.var_bee25557c00cac5d )
                {
                    player.var_bee25557c00cac5d = 1;
                    player thread function_ca44c881c8ff8df1();
                }
                
                continue;
            }
            
            if ( player.var_bee25557c00cac5d )
            {
                player.var_bee25557c00cac5d = 0;
                player notify( #"hash_409ba4727ce201f7" );
                player stoplocalsound( "evt_ee_ts_tv_stare_riser" );
                player playlocalsound( #"hash_268a30637a07c64b" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0x41b805f6, Offset: 0xb34
// Size: 0x127, Type: bool
function function_36f655ed6710e5d0( player )
{
    tv_center = level.var_eafc3735139d91e1.origin + ( 0, 0, 10 );
    
    if ( !isdefined( player ) )
    {
        player = level.players[ 0 ];
    }
    
    eye_origin = player geteye();
    var_e6aa572a52617aab = distance( eye_origin, tv_center ) < getdvarint( @"hash_878419bb3cc65e0c", 300 );
    
    if ( !var_e6aa572a52617aab )
    {
        return false;
    }
    
    if ( !function_df921aebd0550f2( player ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_d76d67cf39364cad", 0 ) || isbot( player ) )
        {
            return true;
        }
    #/
    
    view_angles = player getplayerangles();
    var_bc2e0d8c9229dda3 = utility::within_fov( eye_origin, view_angles, tv_center, cos( 40 ) );
    
    if ( !var_bc2e0d8c9229dda3 )
    {
        return false;
    }
    
    tv_angles = level.var_eafc3735139d91e1.angles;
    var_5782d0e1532bc457 = utility::within_fov( tv_center, tv_angles, eye_origin, cos( 60 ) );
    
    if ( !var_5782d0e1532bc457 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_c8cd07bc5a017259
// Params 1, eflags: 0x4
// Checksum 0x439ed7d4, Offset: 0xc64
// Size: 0xaf, Type: bool
function private function_df921aebd0550f2( player )
{
    eye_origin = player geteye();
    tv_center = level.var_eafc3735139d91e1.origin + ( 0, 0, 10 );
    tv_angles = level.var_eafc3735139d91e1.angles;
    tv_up = anglestoup( tv_angles );
    var_57b7eef3331730ec = tv_center - eye_origin;
    up_proj = vectordot( tv_up, var_57b7eef3331730ec );
    return squared( up_proj ) <= squared( getdvarint( @"hash_d51f0a19ac2e76d", 60 ) );
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0xcadca537, Offset: 0xd1c
// Size: 0x60
function function_ca44c881c8ff8df1()
{
    level endon( #"game_ended" );
    self endon( #"hash_409ba4727ce201f7" );
    self endon( #"death" );
    self playlocalsound( #"evt_ee_ts_tv_stare_riser" );
    wait getdvarint( @"hash_c8249696c48c077", 5 );
    level notify( #"hash_416321d98850a098" );
    self playlocalsound( #"hash_acac62ed7c68acd2" );
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x2db64a14, Offset: 0xd84
// Size: 0x118
function drop_reward()
{
    quest_struct = zm_quest::get_quest( #"hash_716fd2fd2970f520" );
    rewardid = quest_struct.var_3705d250806dcafa ? "completion_2" : "completion_1";
    quest_struct.var_3705d250806dcafa = 1;
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_firefly_two_sister_ee_rewards", rewardid );
    var_21c3b67f1a74cd8e = getclosestpointonnavmesh( self.origin + ( randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ), 0 ) );
    playfx( level._effect[ "ts_ee_reward_spawn" ], var_21c3b67f1a74cd8e );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_21c3b67f1a74cd8e );
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    spawnoptions.var_4a4b419f66681601 = level.var_6ec10f74b02b432b;
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        spawneditems = common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0xc50447a4, Offset: 0xea4
// Size: 0x91, Type: bool
function function_73c4d4357249402a()
{
    zone_info = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( !isdefined( zone_info ) )
    {
        return false;
    }
    
    var_bf66d54bfe517b8 = [ "zone_farm_house", "zone_farm_rear", "zone_farm_cellar", "zone_farm_barn", "zone_farm_road", "zone_farm_close_to_sunken", "zone_farm_close_to_tower", "zone_farm" ];
    
    if ( arraycontains( var_bf66d54bfe517b8, zone_info.script_zone_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0xea64f4bf, Offset: 0xf3e
// Size: 0x5d
function function_123ceffc45a708c7()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_d1c00956ee751325" );
    
    while ( true )
    {
        var_ccf7b54c1d9163ac = randomintrange( 10, 35 );
        wait var_ccf7b54c1d9163ac;
        
        if ( function_73c4d4357249402a() )
        {
            self playlocalsound( #"hash_7a4f0dd708705a9f" );
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0xa2e5a7d1, Offset: 0xfa3
// Size: 0x18
function on_round_start( params )
{
    level notify( #"hash_b16325bde4af7ac1" );
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0xf00463d9, Offset: 0xfc3
// Size: 0x5f
function on_player_connect( params )
{
    if ( arraycontains( level.var_a76e0b4678c282e6, self getxuid() ) )
    {
        if ( !arraycontains( level.var_6ec10f74b02b432b, self ) )
        {
            if ( !isdefined( level.var_6ec10f74b02b432b ) )
            {
                level.var_6ec10f74b02b432b = [];
            }
            
            level.var_6ec10f74b02b432b[ level.var_6ec10f74b02b432b.size ] = self;
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 4
// Checksum 0xa6d15370, Offset: 0x102a
// Size: 0x101
function function_a9b2e85fcabf5313( str_scene_name, str_shot_idle_name, str_shot_stop_name, var_a4d61dba8aea4292 )
{
    playfx( level._effect[ "ts_ee_scene_spawn" ], self.origin );
    thread scene::function_b95eab90f9ebc981( level.var_6ec10f74b02b432b );
    thread scene::play( undefined, str_shot_idle_name, str_scene_name );
    thread scene_stop_watcher( str_shot_stop_name, str_scene_name, var_a4d61dba8aea4292 );
    self.var_fe9ebcd9161bbae8 = [];
    self.var_fe9ebcd9161bbae8 = scene::get_entities();
    
    foreach ( mdl in self.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0x50cbd8ea, Offset: 0x1133
// Size: 0x2c
function dissolve_watcher( n_delay )
{
    level endon( #"game_ended" );
    wait n_delay;
    utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x2425d3ec, Offset: 0x1167
// Size: 0xa7
function function_770ff9cfc7afaf62()
{
    if ( !isdefined( level.var_3756ac23f385af87 ) )
    {
        return;
    }
    
    if ( self istouching( level.var_3756ac23f385af87 ) && !arraycontains( level.var_6ec10f74b02b432b, self ) )
    {
        if ( !isdefined( level.var_6ec10f74b02b432b ) )
        {
            level.var_6ec10f74b02b432b = [];
        }
        
        level.var_6ec10f74b02b432b[ level.var_6ec10f74b02b432b.size ] = self;
        
        if ( !arraycontains( level.var_a76e0b4678c282e6, self getxuid() ) )
        {
            if ( !isdefined( level.var_a76e0b4678c282e6 ) )
            {
                level.var_a76e0b4678c282e6 = [];
            }
            
            level.var_a76e0b4678c282e6[ level.var_a76e0b4678c282e6.size ] = self getxuid();
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x3e80b6a6, Offset: 0x1216
// Size: 0x7c
function function_ad1b283b48c8f556()
{
    if ( !isdefined( level.var_3756ac23f385af87 ) )
    {
        return;
    }
    
    if ( !self istouching( level.var_3756ac23f385af87 ) && arraycontains( level.var_6ec10f74b02b432b, self ) )
    {
        level.var_6ec10f74b02b432b = arrayremove( level.var_6ec10f74b02b432b, self );
        
        if ( arraycontains( level.var_a76e0b4678c282e6, self getxuid() ) )
        {
            level.var_a76e0b4678c282e6 = arrayremove( level.var_a76e0b4678c282e6, self getxuid() );
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x4553f2dd, Offset: 0x129a
// Size: 0x16c
function function_8320f7edb73a569( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_set( "ts_ee_all_players_can_use_tv" );
    var_a38b3c204f6a1f1e = randomintrange( getdvarint( @"hash_7a6ce71b0e27a445", 5 ), getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) );
    
    for ( i = 0; i < var_a38b3c204f6a1f1e ; i++ )
    {
        level waittill( #"ts_ee_use_tv" );
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
    }
    
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "two_girls" );
    level thread function_1a8c1cec23118bd0();
    level waittill( #"hash_416321d98850a098" );
    
    foreach ( player in level.players )
    {
        player function_770ff9cfc7afaf62();
    }
    
    level utility::flag_clear( "ts_ee_all_players_can_use_tv" );
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x9b7d5c0e, Offset: 0x140e
// Size: 0x45
function function_44565824795ed12( b_skipped, b_save_restored )
{
    level utility::flag_clear( "ts_ee_all_players_can_use_tv" );
    
    if ( b_skipped || b_save_restored )
    {
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x3656b988, Offset: 0x145b
// Size: 0x15c
function function_f71fe67ecdff5371( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    var_a38b3c204f6a1f1e = randomintrange( getdvarint( @"hash_7a6ce71b0e27a445", 5 ), getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) );
    
    for ( i = 0; i < var_a38b3c204f6a1f1e ; i++ )
    {
        level waittill( #"ts_ee_use_tv" );
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
    }
    
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "one_girl" );
    e_vo_source = utility::spawn_model( "tag_origin", level.var_eafc3735139d91e1.origin );
    e_vo_source thread function_facc91eeae3df558();
    
    foreach ( player in level.var_6ec10f74b02b432b )
    {
        player playsoundtoplayer( "dx_zm_ffet_esdt_ltwn_ffesdtsgn", player, e_vo_source );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x8f7d2c81, Offset: 0x15bf
// Size: 0x38
function function_d587fa822425b3b6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "one_girl" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0xa38f5fd, Offset: 0x15ff
// Size: 0x192
function function_d4e47ba39d8eb2cf( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    while ( !isdefined( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    if ( level.var_6ec10f74b02b432b.size == 0 )
    {
        level.players[ 0 ].var_bee25557c00cac5d = 1;
        level.players[ 0 ] function_770ff9cfc7afaf62();
    }
    
    utility::array_thread( level.var_6ec10f74b02b432b, &function_123ceffc45a708c7 );
    s_scene_loc = utility::getstruct( "ts_ee_girl_loc_1st_1", "script_noteworthy" );
    s_scene_loc function_a9b2e85fcabf5313( "sat_cin_zm_vig_fly_sisters_chalk", "idle", "exit", 3 );
    level thread play_vo_watcher( s_scene_loc.origin, [ "dx_zm_ffet_esdt_dtwn_ffesdtswi", "dx_zm_ffet_esdt_dtwn_ffesdtsgh" ] );
    level waittill( #"hash_eae08171b355b4e0" );
    e_vo_source = utility::spawn_model( "tag_origin", s_scene_loc.origin );
    e_vo_source thread function_facc91eeae3df558();
    
    foreach ( player in level.var_6ec10f74b02b432b )
    {
        player playsoundtoplayer( "dx_zm_ffet_esdt_dtwn_ffesdtsgn", player, e_vo_source );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x35cd42a4, Offset: 0x1799
// Size: 0x20
function function_2f7c0219fa8e1cfe( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 3
// Checksum 0x45968344, Offset: 0x17c1
// Size: 0x208
function scene_stop_watcher( var_9b2b43a6f4af88c7, str_stop_scene, var_a4d61dba8aea4292 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( var_a4d61dba8aea4292 ) )
    {
        var_a4d61dba8aea4292 = 0;
    }
    
    while ( true )
    {
        if ( isdefined( self ) && isdefined( isarray( level.var_6ec10f74b02b432b ) ) )
        {
            foreach ( player in level.var_6ec10f74b02b432b )
            {
                if ( distance( self.origin, player.origin ) < 150 )
                {
                    if ( isdefined( var_9b2b43a6f4af88c7 ) && isdefined( str_stop_scene ) )
                    {
                        thread scene::play( undefined, var_9b2b43a6f4af88c7, str_stop_scene );
                    }
                    
                    foreach ( mdl in self.var_fe9ebcd9161bbae8 )
                    {
                        mdl thread dissolve_watcher( var_a4d61dba8aea4292 );
                    }
                    
                    level notify( #"hash_eae08171b355b4e0" );
                    wait var_a4d61dba8aea4292 + 5;
                    
                    foreach ( mdl in self.var_fe9ebcd9161bbae8 )
                    {
                        if ( isdefined( mdl ) )
                        {
                            mdl delete();
                        }
                    }
                    
                    scene::stop();
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 1
// Checksum 0x2960b596, Offset: 0x19d1
// Size: 0x62
function get_vo_pos( var_9583f4484e85bc52 )
{
    v_dir = vectornormalize( var_9583f4484e85bc52 - self.origin );
    v_result = self.origin + v_dir * randomintrange( 50, 200 );
    
    /#
        sphere( v_result, 30, ( 0.9, 0.7, 0.6 ) );
    #/
    
    return v_result;
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0xd7468290, Offset: 0x1a3c
// Size: 0xfe
function play_vo_watcher( var_9583f4484e85bc52, a_str_vo_lines )
{
    level endon( #"game_ended" );
    level endon( #"hash_eae08171b355b4e0" );
    
    while ( true )
    {
        wait randomintrange( 6, 20 );
        
        foreach ( player in level.var_6ec10f74b02b432b )
        {
            var_4baa681ad74003db = player get_vo_pos( var_9583f4484e85bc52 );
            e_sound_source = utility::spawn_model( "tag_origin", var_4baa681ad74003db );
            e_sound_source thread function_facc91eeae3df558();
            var_b4103d2679d01a88 = utility::array_random( a_str_vo_lines );
            player playsoundtoplayer( var_b4103d2679d01a88, player, e_sound_source );
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x61d359da, Offset: 0x1b42
// Size: 0x24b
function function_ea20bb7ec506821e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "two_girls" );
    
    while ( !isdefined( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    if ( level.var_6ec10f74b02b432b.size == 0 )
    {
        level.players[ 0 ].var_bee25557c00cac5d = 1;
        level.players[ 0 ] function_770ff9cfc7afaf62();
    }
    
    level thread function_1a8c1cec23118bd0( level.var_6ec10f74b02b432b );
    level waittill( #"hash_416321d98850a098" );
    owners_size = level.var_6ec10f74b02b432b.size;
    
    for ( i = owners_size - 1; i >= 0 ; i-- )
    {
        player = level.var_6ec10f74b02b432b[ i ];
        
        if ( player )
        {
            player function_ad1b283b48c8f556();
        }
    }
    
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
    var_a38b3c204f6a1f1e = randomintrange( getdvarint( @"hash_7a6ce71b0e27a445", 5 ), getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) );
    
    for ( i = 0; i < var_a38b3c204f6a1f1e ; i++ )
    {
        level waittill( #"ts_ee_use_tv" );
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
    }
    
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "no_girl" );
    e_vo_source = utility::spawn_model( "tag_origin", level.var_eafc3735139d91e1.origin );
    e_vo_source thread function_facc91eeae3df558();
    
    foreach ( player in level.var_6ec10f74b02b432b )
    {
        player playsoundtoplayer( "dx_zm_ffet_esdt_ltwn_ffesdtsgn", player, e_vo_source );
        waitframe();
        player playsoundtoplayer( "dx_zm_ffet_esdt_dtwn_ffesdtsgn", player, e_vo_source );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x38d68a8d, Offset: 0x1d95
// Size: 0x38
function function_e6a7058231a7d839( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "no_girl" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x22c23ce5, Offset: 0x1dd5
// Size: 0x2a8
function function_ff3c16a3bc292cbb( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    while ( !isdefined( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    if ( level.var_6ec10f74b02b432b.size == 0 )
    {
        level.players[ 0 ].var_bee25557c00cac5d = 1;
        level.players[ 0 ] function_770ff9cfc7afaf62();
    }
    
    s_scene_loc = utility::getstruct( "ts_ee_girl_loc_2nd_1", "script_noteworthy" );
    s_scene_loc function_a9b2e85fcabf5313( "sat_cin_zm_vig_fly_sisters_dance", "dance_idle" );
    level thread play_vo_watcher( s_scene_loc.origin, [ "dx_zm_ffet_esdt_ltwn_ffesdtswi", "dx_zm_ffet_esdt_dtwn_ffesdtswi", "dx_zm_ffet_esdt_ltwn_ffesdtsgh", "dx_zm_ffet_esdt_dtwn_ffesdtsgh" ] );
    level waittill( #"hash_eae08171b355b4e0" );
    e_vo_source = utility::spawn_model( "tag_origin", s_scene_loc.origin );
    e_vo_source thread function_facc91eeae3df558();
    
    foreach ( player in level.var_6ec10f74b02b432b )
    {
        player playsoundtoplayer( "dx_zm_ffet_esdt_ltwn_ffesdtsgn", player, e_vo_source );
        waitframe();
        player playsoundtoplayer( "dx_zm_ffet_esdt_dtwn_ffesdtsgn", player, e_vo_source );
    }
    
    wait 3.5;
    var_7b6c33252829e33f = utility::getstruct( "ts_ee_girl_loc_teddy", "script_noteworthy" );
    var_7b6c33252829e33f drop_reward();
    level musicbank_utility::function_5aca66c390aa347d( level.var_6ec10f74b02b432b, #"two_sisters" );
    level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
    
    if ( level.var_6ec10f74b02b432b.size > 0 )
    {
        foreach ( player in level.var_6ec10f74b02b432b )
        {
            if ( !player function_704c3e7a56f55fdd() )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "zombieQuest", "ts_ee_unlocked", 1 );
                
                /#
                    if ( player function_704c3e7a56f55fdd() )
                    {
                        iprintlnbold( "<dev string:x24>" );
                    }
                #/
            }
        }
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x7c5b5a28, Offset: 0x2085
// Size: 0x38
function function_4747719db322caa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x48d225c7, Offset: 0x20c5
// Size: 0x17
function function_facc91eeae3df558()
{
    level endon( #"game_ended" );
    wait 5;
    self delete();
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0x86c4ce7e, Offset: 0x20e4
// Size: 0x12b
function function_319d2ddc7147c561( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    while ( !isdefined( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    if ( level.var_6ec10f74b02b432b.size == 0 )
    {
        level.players[ 0 ].var_bee25557c00cac5d = 1;
        level.players[ 0 ] function_770ff9cfc7afaf62();
    }
    
    level thread function_cb20b75fe2077c5f();
    
    while ( true )
    {
        rounds_delay( getdvarint( @"hash_1b4cfba516984c8c", 2 ) );
        s_scene_loc = utility::array_random( utility::getstructarray( "ts_ee_sisters_spawn_loc", "script_noteworthy" ) );
        
        /#
            level.var_6bc30bf17e8408b4 = s_scene_loc;
        #/
        
        s_scene_loc function_a9b2e85fcabf5313( "sat_cin_zm_vig_fly_sisters_dance", "dance_idle" );
        level thread play_vo_watcher( s_scene_loc.origin, [ "dx_zm_ffet_esdt_ltwn_ffesdtswi", "dx_zm_ffet_esdt_dtwn_ffesdtswi", "dx_zm_ffet_esdt_ltwn_ffesdtsgh", "dx_zm_ffet_esdt_dtwn_ffesdtsgh" ] );
        level waittill( #"hash_eae08171b355b4e0" );
        wait 3.5;
        s_scene_loc drop_reward();
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 1, eflags: 0x4
// Checksum 0x306ea410, Offset: 0x2217
// Size: 0x40
function private rounds_delay( var_31e321053dacee32 )
{
    level endon( #"game_ended" );
    
    for ( wait_count = var_31e321053dacee32; wait_count > 0 ; wait_count-- )
    {
        level waittill( #"hash_b16325bde4af7ac1" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 2
// Checksum 0xac1eae72, Offset: 0x225f
// Size: 0x38
function function_1d1b62f7d59750b0( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "two_girls" );
    }
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x2c0fd6a9, Offset: 0x229f
// Size: 0x29, Type: bool
function function_704c3e7a56f55fdd()
{
    if ( isplayer( self ) )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "zombieQuest", "ts_ee_unlocked" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_c8cd07bc5a017259
// Params 0
// Checksum 0x7a02cffe, Offset: 0x22d1
// Size: 0x46
function function_cb20b75fe2077c5f()
{
    level endon( #"game_end" );
    
    while ( true )
    {
        level waittill( #"ts_ee_use_tv" );
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
        waitframe();
    }
}

/#

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0x28929563, Offset: 0x231f
    // Size: 0xcc, Type: dev
    function init_debug()
    {
        zm_quest::function_bc99f123a684344f( #"hash_716fd2fd2970f520" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x3c>", &function_fba2bf9c91eee4c7 );
        devgui::add_devgui_func( "<dev string:x4d>", "<dev string:x4d>", &function_9526b9f5832b7a8f );
        devgui::add_devgui_func( "<dev string:x5e>", "<dev string:x5e>", &function_d908df32ea3b2b93 );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x72>", &function_792deb5f625a0708 );
        devgui::add_devgui_func( "<dev string:x83>", "<dev string:x8d>", &function_35668da33ad8e166 );
        devgui::add_devgui_func( "<dev string:x9d>", "<dev string:xa6>", &function_ccdf59fc34648337 );
        devgui::add_devgui_func( "<dev string:xb9>", "<dev string:xc8>", &function_e1904d567e45bafe );
        devgui::add_devgui_func( "<dev string:xe1>", "<dev string:xef>", &function_fdbca62bb46a0a01 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0x70df2dd7, Offset: 0x23f3
    // Size: 0x5e, Type: dev
    function drawsphere()
    {
        self notify( #"hash_976065b951fca647" );
        self endon( #"hash_976065b951fca647" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            sphere( self.origin, 20, color, 0 );
            waitframe();
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0xa7b68e1e, Offset: 0x2459
    // Size: 0x5e, Type: dev
    function function_fba2bf9c91eee4c7()
    {
        s_scene_node = utility::getstruct( "<dev string:x108>", "<dev string:x11d>" );
        s_scene_node thread scene::play( undefined, "<dev string:x12f>", "<dev string:x134>" );
        wait 10.13;
        s_scene_node thread scene::play( undefined, "<dev string:x155>", "<dev string:x134>" );
        wait 6.93;
        s_scene_node scene::stop();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0x3b5a4bd1, Offset: 0x24bf
    // Size: 0x75, Type: dev
    function function_9526b9f5832b7a8f()
    {
        s_scene_node = utility::getstruct( "<dev string:x108>", "<dev string:x11d>" );
        s_scene_node thread scene::play( undefined, "<dev string:x15a>", "<dev string:x165>" );
        wait 2.26;
        s_scene_node thread scene::play( undefined, "<dev string:x186>", "<dev string:x165>" );
        wait 6;
        s_scene_node thread scene::play( undefined, "<dev string:x191>", "<dev string:x165>" );
        wait 5.6;
        s_scene_node scene::stop();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0x71896fe3, Offset: 0x253c
    // Size: 0x44, Type: dev
    function function_d908df32ea3b2b93()
    {
        s_scene_node = utility::getstruct( "<dev string:x108>", "<dev string:x11d>" );
        s_scene_node thread scene::play( undefined, "<dev string:x19c>", "<dev string:x1a5>" );
        wait 3.83;
        s_scene_node scene::stop();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0
    // Checksum 0x7ea73046, Offset: 0x2588
    // Size: 0x92, Type: dev
    function function_792deb5f625a0708()
    {
        s_scene_node = utility::getstruct( "<dev string:x108>", "<dev string:x11d>" );
        s_scene_node thread scene::play( undefined, "<dev string:x1c9>", "<dev string:x1d8>" );
        wait 9.6;
        s_scene_node thread scene::play( undefined, "<dev string:x1fc>", "<dev string:x1d8>" );
        wait 7.46;
        s_scene_node thread scene::play( undefined, "<dev string:x20f>", "<dev string:x1d8>" );
        wait 4.86;
        s_scene_node thread scene::play( undefined, "<dev string:x224>", "<dev string:x1d8>" );
        wait 10.3;
        s_scene_node scene::stop();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0xc
    // Checksum 0x2910777c, Offset: 0x2622
    // Size: 0x25b, Type: dev
    function private function_35668da33ad8e166()
    {
        self notify( #"hash_4307509e992ae045" );
        self endon( #"hash_4307509e992ae045" );
        me = level.players[ 0 ];
        setdvar( @"scr_devgui_cmd", "<dev string:x239>" );
        wait 1;
        me function_b7c32d7e21abccce();
        me function_9c03e90108e04f5f( level.var_eafc3735139d91e1, "<dev string:x25f>", #"hash_c274ed6b4b9de228", getdvarint( @"hash_878419bb3cc65e0c", 300 ) );
        me function_9c03e90108e04f5f( level.var_eafc3735139d91e1, "<dev string:x264>", #"hash_ccfe066b521dbcb8" );
        wait 3;
        me setorigin( ( 13748, -4059, 426 ) );
        me setplayerangles( ( 11, 161, 0 ) );
        var_a5e67693c21206c0 = utility::getstruct( "<dev string:x27e>", "<dev string:x11d>" );
        me function_9c03e90108e04f5f( var_a5e67693c21206c0, "<dev string:x293>", #"hash_336769656fcd940c", 150 );
        wait 3;
        me function_b7c32d7e21abccce();
        me function_9c03e90108e04f5f( level.var_eafc3735139d91e1, "<dev string:x2a4>", #"hash_d4b2516b5634fe5b", getdvarint( @"hash_878419bb3cc65e0c", 300 ) );
        wait 3;
        me setorigin( ( 15128, -4010, 602 ) );
        me setplayerangles( ( 11, 32, 0 ) );
        var_a308677d02fd02aa = utility::getstruct( "<dev string:x2d8>", "<dev string:x11d>" );
        me function_9c03e90108e04f5f( var_a308677d02fd02aa, "<dev string:x2ed>", #"hash_3e77926576bf7064", 150 );
        reward = utility::getstruct( "<dev string:x2fb>", "<dev string:x11d>" );
        me thread function_4641de835d2d7cb( reward, "<dev string:x310>" );
        wait 5;
        reward notify( #"hash_46463259080ca314" );
        
        for ( rounds_delay = getdvarint( @"hash_1b4cfba516984c8c", 2 ); rounds_delay > 0 ; rounds_delay-- )
        {
            setdvar( @"scr_devgui_cmd", "<dev string:x31d>" );
            wait 10;
        }
        
        while ( !level.var_6bc30bf17e8408b4 )
        {
            waitframe();
        }
        
        me thread function_4641de835d2d7cb( level.var_6bc30bf17e8408b4, "<dev string:x328>", 150 );
        function_2359f97046166a98( #"hash_4798d797af39df3e" );
        wait 5;
        level notify( #"hash_8c688fcb69ef4f4d" );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0xc
    // Checksum 0xa64a2469, Offset: 0x2885
    // Size: 0x362, Type: dev
    function private function_ccdf59fc34648337()
    {
        self notify( #"hash_86e654ab0bc24b3e" );
        self endon( #"hash_86e654ab0bc24b3e" );
        setdvar( @"scr_devgui_cmd", "<dev string:x239>" );
        setdvar( @"bot_godmode", 1 );
        bot = spawn_a_bot( 1 );
        bot childthread function_5211fd23236d3eb8();
        bot.var_65a8b55c5c68fc4 = "<dev string:x332>";
        wait 1;
        bot function_b7c32d7e21abccce();
        
        for ( i = 0; i < getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) ; i++ )
        {
            wait 2;
            level.var_eafc3735139d91e1.my_interact use_tv( bot );
            bot.var_65a8b55c5c68fc4 = "<dev string:x33a>" + getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) - i;
        }
        
        function_2359f97046166a98( #"hash_c274ed6b4b9de228" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x344>";
        wait 2;
        
        for ( i = 0; i < getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) ; i++ )
        {
            wait 2;
            level.var_eafc3735139d91e1.my_interact use_tv( bot );
            bot.var_65a8b55c5c68fc4 = "<dev string:x350>" + getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) - i;
        }
        
        function_2359f97046166a98( #"hash_ccfe066b521dbcb8" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x35a>";
        wait 2;
        bot function_999414b4bef949bf();
        bot.var_65a8b55c5c68fc4 = "<dev string:x365>";
        function_2359f97046166a98( #"hash_336769656fcd940c" );
        wait 5;
        bot function_b7c32d7e21abccce();
        bot.var_65a8b55c5c68fc4 = "<dev string:x373>";
        wait 2;
        
        for ( i = 0; i < getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) ; i++ )
        {
            wait 2;
            level.var_eafc3735139d91e1.my_interact use_tv( bot );
            bot.var_65a8b55c5c68fc4 = "<dev string:x380>" + getdvarint( @"hash_7a8ff11b0e4e01fb", 10 ) - i;
        }
        
        wait 2;
        bot.var_65a8b55c5c68fc4 = "<dev string:x38a>";
        function_2359f97046166a98( #"hash_d4b2516b5634fe5b" );
        wait 2;
        bot function_286299257fa1fbe7();
        bot.var_65a8b55c5c68fc4 = "<dev string:x394>";
        wait 5;
        bot.var_65a8b55c5c68fc4 = "<dev string:x3a2>";
        wait 5;
        function_2359f97046166a98( #"hash_3e77926576bf7064" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x3b1>";
        
        for ( rounds_delay = getdvarint( @"hash_1b4cfba516984c8c", 2 ); rounds_delay > 0 ; rounds_delay-- )
        {
            setdvar( @"scr_devgui_cmd", "<dev string:x31d>" );
            wait 10;
        }
        
        bot.var_65a8b55c5c68fc4 = "<dev string:x3bf>";
        
        while ( !level.var_6bc30bf17e8408b4 )
        {
            waitframe();
        }
        
        if ( bot.pos_linker )
        {
            bot.pos_linker.origin = level.var_6bc30bf17e8408b4.origin;
            return;
        }
        
        bot setorigin( level.var_6bc30bf17e8408b4.origin );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0xc
    // Checksum 0x9d88592a, Offset: 0x2bef
    // Size: 0x17a, Type: dev
    function private function_fdbca62bb46a0a01()
    {
        self notify( #"hash_5d3f4185491c7da3" );
        self endon( #"hash_5d3f4185491c7da3" );
        
        if ( level.var_48d7e30d09553e2f )
        {
            level.var_48d7e30d09553e2f = 0;
            level notify( #"hash_8c688fcb69ef4f4d" );
            return;
        }
        
        level.var_48d7e30d09553e2f = 1;
        me = level.players[ 0 ];
        me thread function_4641de835d2d7cb( level.var_eafc3735139d91e1, "<dev string:x3cf>", getdvarint( @"hash_878419bb3cc65e0c", 300 ) );
        var_a5e67693c21206c0 = utility::getstruct( "<dev string:x27e>", "<dev string:x11d>" );
        me thread function_4641de835d2d7cb( var_a5e67693c21206c0, "<dev string:x3d2>", 150 );
        var_a308677d02fd02aa = utility::getstruct( "<dev string:x2d8>", "<dev string:x11d>" );
        me thread function_4641de835d2d7cb( var_a308677d02fd02aa, "<dev string:x3da>", 150 );
        var_e2384ec3a0f7cfa4 = utility::getstructarray( "<dev string:x3e2>", "<dev string:x11d>" );
        
        foreach ( loc in var_e2384ec3a0f7cfa4 )
        {
            me thread function_4641de835d2d7cb( loc, "<dev string:x3fa>", 150 );
        }
        
        me thread function_490fab8453020ee4();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0x4
    // Checksum 0xde79d8c8, Offset: 0x2d71
    // Size: 0x294, Type: dev
    function private function_490fab8453020ee4()
    {
        level endon( #"game_ended" );
        player = self;
        player endon( #"death_or_disconnect" );
        
        while ( true )
        {
            tv = level.var_eafc3735139d91e1;
            tv_center = level.var_eafc3735139d91e1.origin + ( 0, 0, 10 );
            eye_origin = player geteye();
            view_angles = player getplayerangles();
            var_bc2e0d8c9229dda3 = utility::within_fov( eye_origin, view_angles, tv_center, cos( 40 ) );
            var_5782d0e1532bc457 = utility::within_fov( tv_center, tv.angles, eye_origin, cos( 60 ) );
            var_146584a63b516e06 = distance( player.origin, tv_center ) < getdvarint( @"hash_878419bb3cc65e0c", 300 );
            var_1fa0216a8b733cc9 = function_df921aebd0550f2( player );
            is_in_range = var_bc2e0d8c9229dda3 && var_5782d0e1532bc457 && var_146584a63b516e06 && var_1fa0216a8b733cc9;
            tv_forward = anglestoforward( tv.angles );
            draw_cone( tv_center, tv_forward, getdvarint( @"hash_878419bb3cc65e0c", 300 ), 60, is_in_range ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1 );
            eye_forward = anglestoforward( view_angles );
            draw_cone( eye_origin, eye_forward, getdvarint( @"hash_878419bb3cc65e0c", 300 ), 60, is_in_range ? ( 0, 0.75, 0 ) : ( 1, 0.5, 0 ), 1 );
            
            if ( !is_in_range )
            {
                str = "<dev string:x404>";
                
                if ( !var_bc2e0d8c9229dda3 )
                {
                    str += "<dev string:x405>";
                }
                
                if ( !var_5782d0e1532bc457 )
                {
                    if ( str != "<dev string:x404>" )
                    {
                        str += "<dev string:x416>";
                    }
                    
                    str += "<dev string:x418>";
                }
                
                if ( !var_146584a63b516e06 )
                {
                    if ( str != "<dev string:x404>" )
                    {
                        str += "<dev string:x416>";
                    }
                    
                    str += "<dev string:x429>";
                }
                
                if ( !var_1fa0216a8b733cc9 )
                {
                    if ( str != "<dev string:x404>" )
                    {
                        str += "<dev string:x416>";
                    }
                    
                    str += "<dev string:x439>";
                }
                
                print3d( tv_center + ( 0, 0, 10 ), str, ( 1, 0, 0 ), 1, 0.2 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 7
    // Checksum 0xf736edf2, Offset: 0x300d
    // Size: 0x123, Type: dev
    function draw_cone( origin, forward, length, angle, color, frames, lines_count )
    {
        if ( !isdefined( lines_count ) )
        {
            lines_count = 16;
        }
        
        up_temp = ( 0, 0, 1 );
        left = vectorcross( up_temp, forward );
        up = vectorcross( forward, left );
        lines_start = origin;
        lines_end = lines_start + forward * length;
        line( lines_start, lines_end, color, 1, 0, frames );
        lines_count = max( lines_count, 3 );
        degree_step = 360 / lines_count;
        radius = tan( angle ) * length;
        deg = 0;
        
        while ( deg < 360 )
        {
            end_temp = rotatepointaroundvector( forward, up * radius, deg );
            line( lines_start, lines_end + end_temp, color, 1, 0, frames );
            deg += degree_step;
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0x4
    // Checksum 0x89925d04, Offset: 0x3138
    // Size: 0x25, Type: dev
    function private function_e1904d567e45bafe()
    {
        me = level.players[ 0 ];
        me function_b7c32d7e21abccce();
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0x4
    // Checksum 0x1cc62689, Offset: 0x3165
    // Size: 0x5e, Type: dev
    function private function_b7c32d7e21abccce()
    {
        pos = ( 13490, -3432, 841 );
        
        if ( self.pos_linker )
        {
            self.pos_linker.origin = pos;
            return;
        }
        
        self setorigin( pos );
        self setplayerangles( ( 0, 141, 0 ) );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0x4
    // Checksum 0xf1a8df0c, Offset: 0x31cb
    // Size: 0x5e, Type: dev
    function private function_999414b4bef949bf()
    {
        pos = ( 13582, -3980, 426 );
        
        if ( self.pos_linker )
        {
            self.pos_linker.origin = pos;
            return;
        }
        
        self setorigin( pos );
        self setplayerangles( ( 11, 161, 0 ) );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0x4
    // Checksum 0x55fc370b, Offset: 0x3231
    // Size: 0x5e, Type: dev
    function private function_286299257fa1fbe7()
    {
        pos = ( 15283, -3888, 602 );
        
        if ( self.pos_linker )
        {
            self.pos_linker.origin = pos;
            return;
        }
        
        self setorigin( pos );
        self setplayerangles( ( 11, 32, 0 ) );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 1, eflags: 0x4
    // Checksum 0x5936679b, Offset: 0x3297
    // Size: 0x150, Type: dev
    function private spawn_a_bot( dont_move )
    {
        level endon( #"game_ended" );
        var_e7a717b43846a16 = level.players.size;
        
        if ( var_e7a717b43846a16 >= 4 )
        {
            iprintlnbold( "<dev string:x44a>" );
            return;
        }
        
        bots::spawn_bots( 1, "<dev string:x475>" );
        
        while ( true )
        {
            waitframe();
            new_bot = undefined;
            
            foreach ( index, p in level.players )
            {
                if ( index == 0 )
                {
                    continue;
                }
                
                if ( p.is_using )
                {
                    continue;
                }
                
                p.is_using = 1;
                new_bot = p;
                break;
            }
            
            if ( new_bot )
            {
                if ( dont_move )
                {
                    pos_linker = spawn( "<dev string:x47c>", new_bot.origin, 0 );
                    new_bot playerlinkto( pos_linker );
                    pos_linker thread function_322e983e57b15706( new_bot );
                    new_bot.pos_linker = pos_linker;
                }
                
                return new_bot;
            }
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 4, eflags: 0x4
    // Checksum 0x6c356b51, Offset: 0x33ef
    // Size: 0x54, Type: dev
    function private function_9c03e90108e04f5f( target, print_text, quest_step, radius )
    {
        if ( !isdefined( radius ) )
        {
            radius = 10;
        }
        
        thread function_4641de835d2d7cb( target, print_text, radius );
        function_2359f97046166a98( quest_step );
        target notify( #"hash_46463259080ca314" );
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 1, eflags: 0x4
    // Checksum 0x4b9b9cff, Offset: 0x344b
    // Size: 0x8d, Type: dev
    function private function_2359f97046166a98( quest_step )
    {
        level endon( #"game_ended" );
        quest = zm_quest::get_quest( #"hash_716fd2fd2970f520" );
        quest endon( #"zm_quest_restarted", #"zm_quest_quit", #"zm_quest_completed" );
        step = zm_quest::get_quest_step( #"hash_716fd2fd2970f520", quest_step );
        
        if ( !step.completed )
        {
            step waittill( #"hash_2c4eefaf7e2b24b6" );
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 4, eflags: 0x4
    // Checksum 0x69757cef, Offset: 0x34e0
    // Size: 0x14a, Type: dev
    function private function_4641de835d2d7cb( target, print_text, sphere_radius, color )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x404>";
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 10;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        level endon( #"hash_8c688fcb69ef4f4d" );
        
        if ( !target || !self )
        {
            return;
        }
        
        target endon( #"death", #"hash_46463259080ca314" );
        
        while ( true )
        {
            if ( !target || !target.origin || !self )
            {
                return;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, sphere_radius, color );
            distance_to_target = distance( self.origin, target.origin );
            text_color = distance_to_target <= sphere_radius ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            print3d( target.origin, print_text + "<dev string:x489>" + distance_to_target + "<dev string:x48c>", text_color );
            waitframe();
        }
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 1, eflags: 0x4
    // Checksum 0x7321eaf5, Offset: 0x3632
    // Size: 0x31, Type: dev
    function private function_322e983e57b15706( parent )
    {
        if ( !parent )
        {
            self delete();
            return;
        }
        
        parent waittill( #"death_or_disconnect" );
        self delete();
        return;
    }

    // Namespace namespace_c8cd07bc5a017259
    // Params 0, eflags: 0xc
    // Checksum 0x2e0d4900, Offset: 0x366b
    // Size: 0x9c, Type: dev
    function private function_5211fd23236d3eb8()
    {
        self notify( #"hash_d9d722cd7c809549" );
        self endon( #"hash_d9d722cd7c809549" );
        level endon( #"game_ended" );
        bot = self;
        bot endon( #"death_or_disconnect" );
        color = ( 0, 1, 0 );
        
        while ( true )
        {
            if ( bot.var_65a8b55c5c68fc4 )
            {
                print3d( bot.origin + ( 0, 0, 10 ), bot.var_65a8b55c5c68fc4, color );
            }
            
            waitframe();
        }
    }

#/
