// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ee_jumpscare.gsc  (hash_3ff4e20325020e8d.gscc) (size: 7954 Bytes / 0x1f12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26a19956 (648124758)
// size ...... 7954 (0x1f12)
// includes .. 6   (offset: 0x1cde)
// strings ... 36  (offset: 0x1d0e)
// dev strs .. 0   (offset: 0x1f12)
// exports ... 22  (offset: 0x119a)
// cseg ...... 0x31e + 0xe7c (0x119a)
// imports ... 65  (offset: 0x150a)
// animtree1 . 0   (offset: 0x1f12)
// animtree2 . 0   (offset: 0x1f12)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_mantis_ee_jumpscare;

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0, eflags: 0x5
// Checksum 0x54d093e4, Offset: 0x33c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_5dda52cb9ca13273", undefined, undefined, &function_81afec97dc186aee );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x4818bf23, Offset: 0x35d
// Size: 0x25b
function private function_81afec97dc186aee()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    level._effect[ "mantis_js_image" ] = loadfxasset( "vfx_sat_levels_zm_mantis_jump_scare_camera" );
    level._effect[ "mantis_js_orb" ] = loadfxasset( "vfx_t10_gameplay_zm_harvester_orb_idle_red" );
    zm_quest::register_quest_step( #"hash_5dda52cb9ca13273", #"hash_c274ed6b4b9de228", &function_8320f7edb73a569, &function_44565824795ed12 );
    zm_quest::register_quest_step( #"hash_5dda52cb9ca13273", #"rotate_antenna", &setup_rotate_antenna, &cleanup_rotate_antenna );
    zm_quest::register_quest_step( #"hash_5dda52cb9ca13273", #"hash_ccfe066b521dbcb8", &function_f71fe67ecdff5371, &function_d587fa822425b3b6 );
    zm_quest::register_quest_step( #"hash_5dda52cb9ca13273", #"use_tv_forever", &setup_use_tv_forever, &cleanup_use_tv_forever );
    level utility::flag_wait( "scriptables_ready" );
    s_tv_loc = utility::getstruct( "js_ee_tv_loc", "script_noteworthy" );
    var_4240bf4125bcb8cc = utility::getstruct( s_tv_loc.target, "targetname" );
    
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        level.var_1183dec06637753b = spawnscriptable( "equipment_tv_01_scriptable", s_tv_loc.origin, s_tv_loc.angles );
    }
    else
    {
        level.var_1183dec06637753b = spawnscriptable( "zm_sat_firefly_two_sister_ee_tv", s_tv_loc.origin, s_tv_loc.angles );
        level.var_1183dec06637753b setscriptablepartstate( "model", "off" );
    }
    
    level.var_1183dec06637753b.my_interact = zm_quest::function_91f9590e98d57ff6( var_4240bf4125bcb8cc.origin, &use_tv, &use_tv_hint );
    level.var_1183dec06637753b.my_interact.my_owner = level.var_1183dec06637753b;
    level.var_8579e313c0fd5de = [ "noise_1", "noise_2", "noise_3", "noise_4" ];
    level.var_3756ac23f385af87 = getnoentvolumearray( "check_players_in_tv_room", "script_noteworthy" )[ 0 ];
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_5dda52cb9ca13273" );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 1
// Checksum 0x2c437250, Offset: 0x5c0
// Size: 0x3f
function use_tv( player )
{
    if ( !function_36f655ed6710e5d0( player ) )
    {
        return;
    }
    
    if ( utility::flag( "ts_ee_use_tv_in_cd" ) )
    {
        return;
    }
    
    level.var_7831e6ef21375119 = player;
    level notify( #"hash_e7c01930d6deadc0" );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x2253d90e, Offset: 0x607
// Size: 0x36
function use_tv_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 1
// Checksum 0xc2089a89, Offset: 0x646
// Size: 0x130, Type: bool
function function_36f655ed6710e5d0( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    tv_center = level.var_1183dec06637753b.origin + ( 0, 0, 10 );
    eye_origin = player geteye();
    var_e6aa572a52617aab = distancesquared( eye_origin, tv_center ) < getdvarint( @"hash_d4917255f89db9d9", 300 ) * getdvarint( @"hash_d4917255f89db9d9", 300 );
    
    if ( !var_e6aa572a52617aab )
    {
        return false;
    }
    
    if ( !function_df921aebd0550f2( player ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_40a4c85e506e4854", 0 ) || isbot( player ) )
        {
            return true;
        }
    #/
    
    view_angles = player getplayerangles();
    var_bc2e0d8c9229dda3 = utility::within_fov( eye_origin, view_angles, tv_center, 0.766 );
    
    if ( !var_bc2e0d8c9229dda3 )
    {
        return false;
    }
    
    tv_angles = level.var_1183dec06637753b.angles;
    var_5782d0e1532bc457 = utility::within_fov( tv_center, tv_angles, eye_origin, 0.5 );
    
    if ( !var_5782d0e1532bc457 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0xf273d4ab, Offset: 0x77f
// Size: 0xaf, Type: bool
function private function_df921aebd0550f2( player )
{
    eye_origin = player geteye();
    tv_center = level.var_1183dec06637753b.origin + ( 0, 0, 10 );
    tv_angles = level.var_1183dec06637753b.angles;
    tv_up = anglestoup( tv_angles );
    var_57b7eef3331730ec = tv_center - eye_origin;
    up_proj = vectordot( tv_up, var_57b7eef3331730ec );
    return abs( up_proj ) <= abs( getdvarint( @"hash_698acb61ca005314", 60 ) );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0xbb69a9a2, Offset: 0x837
// Size: 0x5c
function function_8320f7edb73a569( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level waittill( #"hash_e7c01930d6deadc0" );
    level.var_1183dec06637753b setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x2987f150, Offset: 0x89b
// Size: 0x42
function function_44565824795ed12( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_1183dec06637753b setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x3f3fbf2b, Offset: 0x8e5
// Size: 0x10f
function setup_rotate_antenna( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    s_antenna_loc = utility::getstruct( "js_ee_antenna_loc", "script_noteworthy" );
    level.var_83802a603bd388fc = spawnscriptable( "zm_sat_mantis_jumpscare_ee_antenna_short", s_antenna_loc.origin, s_antenna_loc.angles );
    s_orb_locs = utility::getstructarray( "js_ee_orb_loc", "script_noteworthy" );
    n_random_index = randomint( s_orb_locs.size );
    zm_quest::function_4eefe6de31f5ddab( #"hash_5dda52cb9ca13273", #"n_fx_index", n_random_index );
    level.var_b1929241711a687a = s_orb_locs[ n_random_index ];
    level.var_d6bfb36ad0f6a11f = playfx( level._effect[ "mantis_js_orb" ], level.var_b1929241711a687a.origin, undefined, undefined, undefined, undefined, 1 );
    level.var_91443af3b9d76a4e = "healthy_" + level.var_b1929241711a687a.targetname;
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x48acdc17, Offset: 0x9fc
// Size: 0x127
function cleanup_rotate_antenna( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        s_antenna_loc = utility::getstruct( "js_ee_antenna_loc", "script_noteworthy" );
        level.var_83802a603bd388fc = spawnscriptable( "zm_sat_mantis_jumpscare_ee_antenna_short", s_antenna_loc.origin, s_antenna_loc.angles );
        s_orb_locs = utility::getstructarray( "js_ee_orb_loc", "script_noteworthy" );
        
        if ( zm_quest::function_73720cdf21c3cfd7( #"hash_5dda52cb9ca13273", #"n_fx_index" ) )
        {
            level.var_b1929241711a687a = s_orb_locs[ zm_quest::function_73720cdf21c3cfd7( #"hash_5dda52cb9ca13273", #"n_fx_index" ) ];
        }
        else
        {
            level.var_b1929241711a687a = utility::array_random( s_orb_locs );
        }
        
        level.var_d6bfb36ad0f6a11f = playfx( level._effect[ "mantis_js_orb" ], level.var_b1929241711a687a.origin, undefined, undefined, undefined, undefined, 1 );
        level.var_91443af3b9d76a4e = "healthy_" + level.var_b1929241711a687a.targetname;
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x4b8f240, Offset: 0xb2b
// Size: 0x31
function function_f71fe67ecdff5371( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_80db7c101ff62294();
    level function_cb20b75fe2077c5f();
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x797788db, Offset: 0xb64
// Size: 0x2e
function function_d587fa822425b3b6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        function_10392a0d3005a35c( level.var_d6bfb36ad0f6a11f );
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x22bf5e4e, Offset: 0xb9a
// Size: 0x29
function setup_use_tv_forever( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_cb20b75fe2077c5f();
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2
// Checksum 0x1b63af65, Offset: 0xbcb
// Size: 0x28
function cleanup_use_tv_forever( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_cb20b75fe2077c5f();
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 1
// Checksum 0x209acb71, Offset: 0xbfb
// Size: 0x197
function function_1a8c1cec23118bd0( players )
{
    level endon( #"game_ended" );
    level endon( #"hash_d2d0b070d78a4c2a" );
    
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
                player notify( #"hash_87a3a9469853aaf9" );
                player stoplocalsound( "evt_ee_ts_tv_stare_riser" );
                player playlocalsound( #"hash_268a30637a07c64b" );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0
// Checksum 0x6861ca3f, Offset: 0xd9a
// Size: 0x60
function function_ca44c881c8ff8df1()
{
    level endon( #"game_ended" );
    self endon( #"hash_87a3a9469853aaf9" );
    self endon( #"death" );
    self playlocalsound( #"evt_ee_ts_tv_stare_riser" );
    wait getdvarint( @"hash_f127041097e38c60", 3 );
    level notify( #"hash_d2d0b070d78a4c2a" );
    self playlocalsound( #"hash_acac62ed7c68acd2" );
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0
// Checksum 0x2f768246, Offset: 0xe02
// Size: 0x8f
function function_80db7c101ff62294()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        current_part_state = level.var_83802a603bd388fc getscriptablepartstate( "base" );
        target_part_state = "healthy_" + level.var_b1929241711a687a.targetname;
        
        if ( current_part_state == target_part_state )
        {
            player = level.var_7831e6ef21375119;
            
            if ( isalive( player ) )
            {
                player playsoundtoplayer( "evt_jumpscare_angel_right", player );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x963a4c57, Offset: 0xe99
// Size: 0x15c
function private do_jumpscare( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_set( "mantis_js_play" );
    player = level.var_7831e6ef21375119;
    
    /#
        if ( b_skipped )
        {
            player = level.players[ 0 ];
        }
    #/
    
    if ( isalive( player ) )
    {
        player thread function_e8bf9da8afb7ffd0();
        level.var_91443af3b9d76a4e = "completed";
        level.var_1183dec06637753b setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
        player val::set( "jumpscare", "show_hud", 0 );
        playfxontagforclients( level._effect[ "mantis_js_image" ], player, "j_head", player );
        wait 0.67;
        earthquake( 0.5, 1.5, player.origin, 150 );
        playrumbleonposition( "grenade_rumble", player.origin );
        player playsoundtoplayer( "evt_ruby_ee_jump_scare_stinger", player );
        wait 0.63;
        
        if ( isdefined( player ) )
        {
            player val::reset_all( "jumpscare" );
        }
        
        level notify( #"hash_780c1c9a7876598c" );
        player allowads( 1 );
        function_10392a0d3005a35c( level.var_d6bfb36ad0f6a11f );
        player play_vo();
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0
// Checksum 0xb36a5faa, Offset: 0xffd
// Size: 0x3d
function function_e8bf9da8afb7ffd0()
{
    level endon( #"hash_780c1c9a7876598c" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self setstance( "stand", 0, 1 );
        self allowads( 0 );
        wait 0.05;
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0
// Checksum 0x2408b998, Offset: 0x1042
// Size: 0x10a
function function_cb20b75fe2077c5f()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_e7c01930d6deadc0" );
        current_part_state = level.var_83802a603bd388fc getscriptablepartstate( "base" );
        
        if ( current_part_state == level.var_91443af3b9d76a4e )
        {
            var_fa1e85053456aff7 = randomint( 6 ) + 1;
            
            for ( i = 0; i < var_fa1e85053456aff7 ; i++ )
            {
                level waittill( #"hash_e7c01930d6deadc0" );
                level.var_1183dec06637753b setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
            }
            
            level.var_1183dec06637753b setscriptablepartstate( "model", "no_girl" );
            level thread function_1a8c1cec23118bd0();
            level waittill( #"hash_d2d0b070d78a4c2a" );
            do_jumpscare();
            return;
        }
        else
        {
            level.var_1183dec06637753b setscriptablepartstate( "model", utility::array_random( level.var_8579e313c0fd5de ) );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_ee_jumpscare
// Params 0
// Checksum 0x9886daa7, Offset: 0x1154
// Size: 0x46
function play_vo()
{
    if ( level.jumpscare_vo_played )
    {
        return;
    }
    
    wait 2;
    var_db75d3de862ce072 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_58b99410ead708c5", #"bc_flavor_player_negative" );
    
    if ( var_db75d3de862ce072 )
    {
        level.jumpscare_vo_played = 1;
    }
}

