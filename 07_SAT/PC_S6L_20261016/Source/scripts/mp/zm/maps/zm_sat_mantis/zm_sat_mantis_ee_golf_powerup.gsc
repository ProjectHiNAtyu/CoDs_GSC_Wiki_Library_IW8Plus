// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ee_golf_powerup.gsc  (hash_0b1029dbd1504632.gscc) (size: 6002 Bytes / 0x1772 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4739dc6 (3832782278)
// size ...... 6002 (0x1772)
// includes .. 8   (offset: 0x15fa)
// strings ... 19  (offset: 0x163a)
// dev strs .. 0   (offset: 0x1772)
// exports ... 17  (offset: 0xe36)
// cseg ...... 0x1b0 + 0xc86 (0xe36)
// imports ... 42  (offset: 0x10de)
// animtree1 . 0   (offset: 0x1772)
// animtree2 . 0   (offset: 0x1772)
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_ee_golf_powerup;

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0, eflags: 0x5
// Checksum 0x55296a18, Offset: 0x1ce
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_5b7983ac243fa626", undefined, undefined, &function_62c2cf69fbe0ffdd );
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0, eflags: 0x4
// Checksum 0x1f8ef5b6, Offset: 0x1ef
// Size: 0xce
function private function_62c2cf69fbe0ffdd()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    level._effect[ "mantis_gp_celebrate" ] = loadfxasset( "vfx_present_box_opening" );
    zm_quest::register_quest_step( #"hash_5b7983ac243fa626", #"spawn_flag", &setup_spawn_flag, &cleanup_spawn_flag );
    zm_quest::register_quest_step( #"hash_5b7983ac243fa626", #"spawn_powerup", &setup_spawn_powerup, &cleanup_spawn_powerup );
    zm_quest::register_quest_step( #"hash_5b7983ac243fa626", #"loop_execution", &start_loop_execution, &cleanup_loop_execution );
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_5b7983ac243fa626" );
    level callback::add( "on_round_start", &on_round_start );
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0x6c7f7281, Offset: 0x2c5
// Size: 0x114
function setup_spawn_flag( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.var_6ce62f2b0df3936b = zm_utility::get_round_number();
    level.var_175baa9544e54d14 = utility::getstructarray( "hole_pos", "script_noteworthy" );
    var_72867871174a6345 = utility::array_random( level.var_175baa9544e54d14 );
    level.var_fb8c01164b4a4046 = spawnscriptable( "zm_sat_mantis_golf_powerup_ee_flag", var_72867871174a6345.origin, var_72867871174a6345.angles );
    level.var_1f7d298f60bf90ae = utility::getstruct( var_72867871174a6345.target, "targetname" );
    level.var_403ad8b73c6c23d6 = getscriptablearray( "golf_powerup_ball", "targetname" );
    level.var_4c8e3d5901f5285b = utility::getstructarray( "ball_pos", "script_noteworthy" );
    function_ba80e0b5c5168875( level.var_403ad8b73c6c23d6 );
    level thread function_ec67274eb79b31ef();
    level function_14c689c1c4345178();
    level waittill( #"hash_2da5ecdec7c15fa1" );
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0xaa4ab75c, Offset: 0x3e1
// Size: 0xf3
function cleanup_spawn_flag( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_175baa9544e54d14 = utility::getstructarray( "hole_pos", "script_noteworthy" );
        var_72867871174a6345 = utility::array_random( level.var_175baa9544e54d14 );
        level.var_fb8c01164b4a4046 = spawnscriptable( "zm_sat_mantis_golf_powerup_ee_flag", var_72867871174a6345.origin, var_72867871174a6345.angles );
        level.var_fb8c01164b4a4046 setscriptablepartstate( "base", "hide" );
        level.var_1f7d298f60bf90ae = utility::getstruct( var_72867871174a6345.target, "targetname" );
        level.var_403ad8b73c6c23d6 = getscriptablearray( "golf_powerup_ball", "targetname" );
        level.var_4c8e3d5901f5285b = utility::getstructarray( "ball_pos", "script_noteworthy" );
        function_ba80e0b5c5168875( level.var_403ad8b73c6c23d6 );
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 1
// Checksum 0x75584715, Offset: 0x4dc
// Size: 0x12b
function function_ba80e0b5c5168875( balls )
{
    if ( !balls || !level.var_4c8e3d5901f5285b )
    {
        return;
    }
    
    var_45f0fcc53ed6ae58 = arrayrandomize( level.var_4c8e3d5901f5285b );
    
    foreach ( ball in balls )
    {
        foreach ( loc in var_45f0fcc53ed6ae58 )
        {
            ball.origin = loc.origin;
            var_45f0fcc53ed6ae58 = arrayremove( var_45f0fcc53ed6ae58, loc );
            break;
        }
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0x65f6d329, Offset: 0x60f
// Size: 0x34
function setup_spawn_powerup( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_786da0d62c3d914c();
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0xed4f6fb, Offset: 0x64b
// Size: 0x5c
function cleanup_spawn_powerup( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( zm_quest::function_73720cdf21c3cfd7( #"hash_5b7983ac243fa626", #"hash_1fe17efd2fcf810e" ) )
        {
            level.var_6ce62f2b0df3936b = zm_quest::function_73720cdf21c3cfd7( #"hash_5b7983ac243fa626", #"hash_1fe17efd2fcf810e" );
        }
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0x3627c639, Offset: 0x6af
// Size: 0x19e
function function_786da0d62c3d914c()
{
    level.var_fb8c01164b4a4046 setscriptablepartstate( "base", "hide" );
    level.var_6ce62f2b0df3936b = zm_utility::get_round_number();
    zm_quest::function_4eefe6de31f5ddab( #"hash_5b7983ac243fa626", #"hash_1fe17efd2fcf810e", level.var_6ce62f2b0df3936b );
    playfx( level._effect[ "mantis_gp_celebrate" ], level.var_1f7d298f60bf90ae.origin );
    playsoundatpos( level.var_1f7d298f60bf90ae.origin + ( 0, 0, 15 ), #"hash_997c14386d048ea8" );
    wait 0.5;
    
    if ( level.var_aef99ecd3ab9268a.hitcount == 1 )
    {
        level powerups::powerup_drop( "bonus_points_team", level.var_1f7d298f60bf90ae.origin + ( 32, 0, 32 ), undefined, undefined, "quest" );
        level powerups::powerup_drop( "insta_kill", level.var_1f7d298f60bf90ae.origin + ( 0, 32, 32 ), undefined, undefined, "quest" );
        level powerups::powerup_drop( "full_armor", level.var_1f7d298f60bf90ae.origin + ( 32, 32, 32 ), undefined, undefined, "quest" );
        play_vo();
        return;
    }
    
    level powerups::powerup_drop( "bonus_points_team", level.var_1f7d298f60bf90ae.origin + ( 32, 0, 32 ), undefined, undefined, "quest" );
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0x4551839c, Offset: 0x855
// Size: 0x72
function play_vo()
{
    if ( level.var_4610ccbe85182a62 || !isdefined( level.var_aef99ecd3ab9268a.var_b6a5243ab32ae3d5 ) )
    {
        return;
    }
    
    wait 1;
    var_db75d3de862ce072 = level.var_aef99ecd3ab9268a.var_b6a5243ab32ae3d5 namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_ae3077c95d1c4245", #"bc_flavor_player_positive" );
    
    if ( var_db75d3de862ce072 )
    {
        level.var_4610ccbe85182a62 = 1;
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0xcc847586, Offset: 0x8cf
// Size: 0x49
function start_loop_execution( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"hash_2da5ecdec7c15fa1" );
        function_786da0d62c3d914c();
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 2
// Checksum 0x45963dcf, Offset: 0x920
// Size: 0x38
function cleanup_loop_execution( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_fb8c01164b4a4046 setscriptablepartstate( "base", "hide" );
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 1
// Checksum 0xb0a74d7b, Offset: 0x960
// Size: 0xf9
function on_round_start( params )
{
    if ( !isdefined( level.var_6ce62f2b0df3936b ) )
    {
        return;
    }
    
    current_round = zm_utility::get_round_number();
    
    if ( current_round - level.var_6ce62f2b0df3936b == 5 )
    {
        is_player_nearby = check_player_nearby();
        
        if ( is_player_nearby )
        {
            level.var_6ce62f2b0df3936b++;
            return;
        }
        
        var_72867871174a6345 = utility::array_random( level.var_175baa9544e54d14 );
        level.var_fb8c01164b4a4046.origin = var_72867871174a6345.origin;
        level.var_fb8c01164b4a4046 setscriptablepartstate( "base", "show" );
        level.var_1f7d298f60bf90ae = utility::getstruct( var_72867871174a6345.target, "targetname" );
        function_ba80e0b5c5168875( level.var_403ad8b73c6c23d6 );
        level.var_6ce62f2b0df3936b = current_round;
        level thread function_ec67274eb79b31ef();
        level function_14c689c1c4345178();
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0xca79befe, Offset: 0xa61
// Size: 0xa1, Type: bool
function check_player_nearby()
{
    foreach ( player in level.players )
    {
        if ( distancesquared( player.origin, level.var_1f7d298f60bf90ae.origin ) < 250000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0x378e652c, Offset: 0xb0b
// Size: 0x211
function function_ec67274eb79b31ef()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( ball in level.var_403ad8b73c6c23d6 )
        {
            if ( distancesquared( ball.origin, level.var_1f7d298f60bf90ae.origin ) < 9 )
            {
                level notify( #"hash_2da5ecdec7c15fa1" );
                level.var_aef99ecd3ab9268a = ball;
                
                foreach ( player in level.players )
                {
                    if ( distancesquared( player.origin, level.var_1f7d298f60bf90ae.origin ) < 90000 )
                    {
                        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
                    }
                }
                
                return;
            }
        }
        
        var_9c39bfc2688c4ae5 = getaiarrayinradius( level.var_1f7d298f60bf90ae.origin, 350, "team_two_hundred" );
        
        foreach ( zombie in var_9c39bfc2688c4ae5 )
        {
            zombie.forceannihilate = 1;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0x9f82a8f3, Offset: 0xd24
// Size: 0x88
function function_14c689c1c4345178()
{
    foreach ( ball in level.var_403ad8b73c6c23d6 )
    {
        ball.hitcount = 0;
        ball thread wait_damage();
    }
}

// Namespace zm_sat_mantis_ee_golf_powerup
// Params 0
// Checksum 0xa3260438, Offset: 0xdb4
// Size: 0x82
function wait_damage()
{
    self notify( #"hash_39473635ce13a46" );
    self endon( #"hash_39473635ce13a46" );
    level endon( #"game_ended" );
    level endon( #"hash_2da5ecdec7c15fa1" );
    
    while ( self.hitcount < 2 )
    {
        self waittill( #"damage", damage, attacker );
        self.var_b6a5243ab32ae3d5 = attacker;
        self.hitcount++;
        wait 0.3;
    }
}

