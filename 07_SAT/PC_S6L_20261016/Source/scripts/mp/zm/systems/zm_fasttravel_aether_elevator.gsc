// scripts\mp\zm\systems\zm_fasttravel_aether_elevator.gsc  (hash_2dc181cb271d2cb2.gscc) (size: 4693 Bytes / 0x1255 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9dc482b6 (2646901430)
// size ...... 4693 (0x1255)
// includes .. 5   (offset: 0x1051)
// strings ... 31  (offset: 0x1079)
// dev strs .. 0   (offset: 0x1255)
// exports ... 5   (offset: 0xa61)
// cseg ...... 0x346 + 0x71b (0xa61)
// imports ... 44  (offset: 0xb29)
// animtree1 . 0   (offset: 0x1255)
// animtree2 . 0   (offset: 0x1255)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\zm\systems\zm_fasttravel;

#namespace zm_fasttravel_aether_elevator;

// Namespace zm_fasttravel_aether_elevator
// Params 0
// Checksum 0x358b6535, Offset: 0x364
// Size: 0x7f
function init_aether_elevators()
{
    level._effect[ "aether_orb" ] = loadfxasset( "vfx_t10_levels_zm_jade_aether_elevator_fast_travel" );
    level._effect[ "aether_orb_cam" ] = loadfxasset( "vfx_t10_levels_zm_jade_aether_elevator_fast_travel_screen_fx" );
    level._effect[ "aether_orb_spawn" ] = loadfxasset( "vfx_t10_levels_zm_jade_aether_elevator_fast_travel_spawn" );
    level._effect[ "aether_orb_despawn" ] = loadfxasset( "vfx_t10_levels_zm_jade_aether_elevator_fast_travel_explo" );
    level._effect[ "scrnfx_aether_elevator_use" ] = loadfxasset( "vfx_t10_levels_zm_jade_aether_elevator_fast_travel_cam" );
}

// Namespace zm_fasttravel_aether_elevator
// Params 2
// Checksum 0x4ac81549, Offset: 0x3eb
// Size: 0x5fa
function aether_elevator_use( player, s_destination )
{
    level endon( #"game_ended" );
    
    if ( player )
    {
        player endon( #"death_or_disconnect" );
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.b_offline ) )
    {
        return;
    }
    
    player utility::ent_flag_set( "fasttravel_start" );
    self.var_7899dd4d8ac31d1a.cool_down_time = 30;
    player thread zm_fasttravel::fasttravel_cooldown_timer( self );
    player zm_fasttravel::function_12b11b69ea8587b8( 1 );
    player zm_fasttravel::set_player_vars( 1 );
    player val::set( "fasttravel", "weapon", 0 );
    player val::set( "fasttravel", "crouch", 0 );
    player val::set( "fasttravel", "prone", 0 );
    player val::set( "fasttravel", "melee", 0 );
    player val::set( "aether_elevator_tp", "allow_toggle_third_person", 0 );
    player zm_fasttravel::prestream_minimap( s_destination );
    
    if ( !isdefined( self.var_7899dd4d8ac31d1a.angles ) )
    {
        self.var_7899dd4d8ac31d1a.angles = ( 0, 0, 0 );
    }
    
    v_fx_loc = player gettagorigin( "j_spine4" );
    var_9b0535a434f74a2c = player getplayerangles();
    player playrumblelooponentity( "damage_heavy" );
    playfx( level._effect[ "aether_orb_spawn" ], v_fx_loc, anglestoforward( var_9b0535a434f74a2c ) );
    var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", player.origin, player.angles );
    ae_scriptable = spawnscriptable( "aether_elevator_audio", ( 0, 0, 0 ), ( 0, 0, 0 ), var_2b0c20cebe23ba0b );
    player setscriptablepartstate( "aether_shroud_fx", "super_fx_on", 0 );
    playfxontag( level._effect[ "aether_orb" ], player, "j_spine4" );
    playfxontagforclients( level._effect[ "aether_orb_cam" ], player, "tag_eye", player );
    player playerlinkto( var_2b0c20cebe23ba0b, "tag_origin", 1, 0, 0, 0, 0 );
    var_c430e398f22f2648 = 64 * vectornormalize( self.var_7899dd4d8ac31d1a.origin - s_destination.origin )[ 2 ];
    n_dir = 1;
    
    if ( var_c430e398f22f2648 < 0 )
    {
        n_dir = -1;
    }
    
    var_59d2cbb102282176 = ( self.var_7899dd4d8ac31d1a.angles[ 0 ] + var_c430e398f22f2648, self.var_7899dd4d8ac31d1a.angles[ 1 ] + 180, 0 );
    var_b2c9720e09f44e38 = self.var_7899dd4d8ac31d1a.origin + ( 0, 0, 32 * n_dir * -1 );
    var_2b0c20cebe23ba0b moveto( var_b2c9720e09f44e38, 0.4 );
    var_2b0c20cebe23ba0b rotateto( var_59d2cbb102282176, 0.4 );
    wait 0.4;
    player playerhide();
    v_destination = s_destination.origin + ( 0, 0, 24 * n_dir );
    move_height = abs( v_destination[ 2 ] - var_b2c9720e09f44e38[ 2 ] );
    n_move_time = move_height / 1400;
    n_rotate_time = n_move_time * 0.85;
    n_current_yaw = angleclamp( var_2b0c20cebe23ba0b.angles[ 1 ] );
    n_goal_yaw = angleclamp( s_destination.angles[ 1 ] );
    n_yaw_delta = 180 - abs( abs( n_goal_yaw - n_current_yaw ) - 180 );
    n_delta_mod = mod( var_59d2cbb102282176[ 1 ] - var_9b0535a434f74a2c[ 1 ] + 180, 360 ) - 180;
    
    if ( n_delta_mod <= 0 )
    {
        n_yaw_delta *= -1;
    }
    
    var_2b0c20cebe23ba0b moveto( v_destination, n_move_time );
    var_2b0c20cebe23ba0b rotateby( ( 0, n_yaw_delta, 0 ), n_rotate_time + 0.5 );
    var_919ccbfcfa4b4c4e = n_move_time - n_rotate_time + 0.125;
    s_landing = player zm_fasttravel::function_2723774980bb17c4( s_destination );
    var_2b0c20cebe23ba0b utility::delaycall( n_rotate_time, &rotateto, s_landing.angles, var_919ccbfcfa4b4c4e, var_919ccbfcfa4b4c4e - 0.1 );
    wait n_move_time;
    var_2b0c20cebe23ba0b moveto( s_landing.origin, 0.5, 0.49, 0.01 );
    ae_scriptable setscriptablepartstate( "audio", "finish_lift" );
    player val::reset( "fasttravel", "weapon" );
    player playershow();
    wait 0.5;
    player stoprumble( "damage_heavy" );
    waitframe();
    player playrumbleonentity( "damage_heavy" );
    player setscriptablepartstate( "aether_shroud_fx", "super_fx_deactivate", 0 );
    killfxontag( level._effect[ "aether_orb" ], player, "j_spine4" );
    killfxontag( level._effect[ "aether_orb_cam" ], player, "tag_eye" );
    ae_scriptable setscriptablepartstate( "audio", "complete" );
    playfx( level._effect[ "aether_orb_despawn" ], player gettagorigin( "j_spine4" ), anglestoforward( var_2b0c20cebe23ba0b.angles ) );
    ae_scriptable freescriptable();
    var_2b0c20cebe23ba0b delete();
    playfxontagforclients( level._effect[ "scrnfx_aether_elevator_use" ], player, "tag_origin", player );
    params = { #delay:1, #player:player };
    callback::callback( "callback_play_ae_vo", params );
    player thread function_ba4ce85983a03719( 0.5 );
    player zm_fasttravel::set_player_vars( 0 );
    player zm_fasttravel::function_12b11b69ea8587b8( 0 );
    player val::reset( "aether_elevator_tp", "allow_toggle_third_person" );
    player.var_d1c4c78b9fb7d153 = 0;
    player thread function_502febb2303a3d2f( 2 );
    player utility::ent_flag_clear( "fasttravel_start" );
}

// Namespace zm_fasttravel_aether_elevator
// Params 1, eflags: 0x4
// Checksum 0x7c58f099, Offset: 0x9ed
// Size: 0x30
function private function_502febb2303a3d2f( n_delay )
{
    self endon( #"death_or_disconnect" );
    self.var_c51fe993f3dc78d9 = 1;
    wait n_delay;
    self.var_c51fe993f3dc78d9 = undefined;
}

// Namespace zm_fasttravel_aether_elevator
// Params 1, eflags: 0x4
// Checksum 0xa3699939, Offset: 0xa25
// Size: 0x3c
function private function_ba4ce85983a03719( n_dur )
{
    self endon( #"death" );
    vision_utility::function_89d3efe42060754c( "zm_t10_garnet_vfx_cam_church", level.framedurationseconds );
    wait n_dur;
    vision_utility::function_6cb9d8e0202ee81( "zm_t10_garnet_vfx_cam_church" );
}

