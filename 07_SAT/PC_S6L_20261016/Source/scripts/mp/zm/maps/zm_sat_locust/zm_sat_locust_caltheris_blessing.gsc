// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_caltheris_blessing.gsc  (hash_3f4571d9d8e40345.gscc) (size: 8661 Bytes / 0x21d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7c6e371 (3351700337)
// size ...... 8661 (0x21d5)
// includes .. 17  (offset: 0x1fed)
// strings ... 25  (offset: 0x2075)
// dev strs .. 3   (offset: 0x21b1)
// exports ... 20  (offset: 0x1359)
// cseg ...... 0x277 + 0x10e2 (0x1359)
// imports ... 81  (offset: 0x1679)
// animtree1 . 0   (offset: 0x21d5)
// animtree2 . 0   (offset: 0x21d5)
#using script_53600bb9c82cbdf2;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\common\field_upgrades\field_upgrades_aether_shroud;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\common\utility\player;
#using scripts\mp\laststand;
#using scripts\mp\playerachievements;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_boss_fight;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_caltheris_blessing;

// Namespace zm_sat_locust_caltheris_blessing
// Params 0
// Checksum 0x45bdb922, Offset: 0x295
// Size: 0x12d
function init_caltheris_blessing()
{
    powerups::register_powerup( "locust_boss", &function_b3c780226073186c, &function_955dae5a970dd94a );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"hash_22fdd0c3eb081084", &function_faa65c55f256000b );
    callback::add( #"hash_bf2f3d5470c22e57", &function_22fc08d53be6ae );
    callback::add( #"player_laststand", &on_player_laststand );
    
    foreach ( player in level.players )
    {
        level thread function_fd089e2903b0723e( player );
    }
    
    level.var_65d57a041006dee5 = 0;
    level.var_1a1166e7984f4f9a = 0;
    level.var_669124beebe79b16 = 1;
    level.var_a7599e13d3805dc2 = [];
    level.var_40eff250088d8288 = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 0
// Checksum 0x56268815, Offset: 0x3ca
// Size: 0x60
function cleanup_caltheris_blessing()
{
    callback::remove( #"player_connect", &on_player_connect );
    callback::remove( #"hash_22fdd0c3eb081084", &function_faa65c55f256000b );
    callback::remove( #"hash_bf2f3d5470c22e57", &function_22fc08d53be6ae );
    callback::remove( #"player_laststand", &on_player_laststand );
    level.var_669124beebe79b16 = 0;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 2
// Checksum 0x306ef65e, Offset: 0x432
// Size: 0x55
function function_c3caec2115529287( aabb_min, aabb_max )
{
    validity_zone = { #aabb_max:aabb_max, #aabb_min:aabb_min };
    level.var_a7599e13d3805dc2 = arraycombineunique( level.var_a7599e13d3805dc2, [ validity_zone ] );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 2
// Checksum 0xe0a64fa9, Offset: 0x48f
// Size: 0x10b
function function_b3c780226073186c( str_powerup, ent_powerup )
{
    logstring( "[BLESSING] Activating blessing by " + self.name );
    players = powerups::get_powerup_players( str_powerup );
    logstring( "[BLESSING] powerup players size " + players.size + " | level players size " + level.players.size );
    
    foreach ( player in level.players )
    {
        level thread function_b5676fab48064d5a( player );
    }
    
    utility::delaythread( 0.5, &zombie_boss_virgil::function_9c386609d0280bef, #"hash_c92603fbad70b904" );
    thread callback::callback( #"hash_e75fd0c2334ddf6", {} );
    level notify( #"hash_eabcf22a0e32a8dd" );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1
// Checksum 0xaca79817, Offset: 0x5a2
// Size: 0x1aa
function function_b5676fab48064d5a( player )
{
    level endon( #"game_over" );
    player endon( #"disconnect" );
    logstring( "[BLESSING] Reviving player " + player.name + " | isReallyAlive: " + player::isreallyalive( player ) + " | sessionstate: " + player.sessionstate );
    
    if ( getdvarint( @"hash_e379740c2526acf7", 0 ) )
    {
        if ( !player::isreallyalive( player ) || player.sessionstate == "spectator" )
        {
            start_time = gettime();
            player.var_14955bc056bab547 = 1;
            player visibility_mode::visibilitymode_unpackvalue();
            player thread playerlogic::spawnclient();
            player utility::waittill_any_timeout( 5, "spawned_player" );
            logstring( "[BLESSING] Respawning player " + player.name + " took " + gettime() - start_time );
            assert( player::isreallyalive( player ), "<dev string:x24>" );
        }
    }
    
    if ( player::isinlaststand( player ) )
    {
        player laststand::exit( "last_stand_revived", player );
    }
    
    var_b8b17c4c051bd983 = getdvarfloat( @"hash_e34399116670a09b", 5 );
    player thread function_589e3fd2d1581770( var_b8b17c4c051bd983 );
    root = powerups::get_powerups_root();
    n_lifetime = root.powerups[ "locust_boss" ].var_3f03b937c69044df;
    
    if ( isdefined( level.powerup_timeout_override ) )
    {
        n_lifetime = self [[ level.powerup_timeout_override ]]( n_lifetime );
    }
    
    player thread powerups_cpmp::function_52318afc13635e7c( "locust_boss", n_lifetime );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0x5e7967dd, Offset: 0x754
// Size: 0x41
function private function_589e3fd2d1581770( var_b8b17c4c051bd983 )
{
    level endon( #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    
    if ( var_b8b17c4c051bd983 == 0 )
    {
        return;
    }
    
    thread field_upgrades_aether_shroud::aether_shroud_active();
    wait var_b8b17c4c051bd983;
    thread field_upgrades_aether_shroud::function_63c791098b816b7();
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 2
// Checksum 0x9f6cf226, Offset: 0x79d
// Size: 0x144
function function_6478eae486cfa1e7( player = undefined, ignore_requirements = 0 )
{
    level endon( #"game_ended" );
    
    if ( level.var_65d57a041006dee5 )
    {
        return;
    }
    
    level.var_65d57a041006dee5 = 1;
    level.var_1a1166e7984f4f9a = 1;
    
    if ( !isdefined( player ) )
    {
        alive_players = utility::get_alive_players( 1 );
        player = utility::array_random( alive_players );
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x4b>" );
        return;
    }
    
    player endon( #"death_or_disconnect" );
    
    if ( !function_cc7c499fa7e81793() && !getdvarint( @"hash_cd26af899a846383", 0 ) && !ignore_requirements )
    {
        return;
    }
    
    player thread callback::callback( #"hash_aeec77b89ab49d7c", {} );
    ideal_location_struct = function_44530372150997bf( player );
    player thread zm_utility::white_screen_flash( 0.75, 0.5 );
    player playsoundtoplayer( "evt_mq_white_out", player );
    blessing_origin = utility::drop_to_ground( ideal_location_struct.origin, undefined, undefined, undefined, level.var_40eff250088d8288 );
    level thread function_a52ecba3a2a5364e( blessing_origin, ideal_location_struct.angles, player );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 3, eflags: 0x4
// Checksum 0x4fc7314e, Offset: 0x8e9
// Size: 0xc3
function private function_a52ecba3a2a5364e( origin, angles, player )
{
    level endon( #"game_ended" );
    wait 2;
    pedestal_scriptable = spawnscriptable( "sat_zm_locust_blessing_pedestal", origin, angles );
    earthquake( 0.5, 1, origin, 2000 );
    
    if ( isdefined( player ) )
    {
        player thread callback::callback( #"hash_4909d16272fe4b", {} );
    }
    
    level thread dialogue::say_global( "dx_zm_lobf_bflo_ssrh_lbfcalbls" );
    wait 2;
    level thread function_567c2ce5ecb68e84( origin );
    level waittill( #"hash_eabcf22a0e32a8dd" );
    pedestal_scriptable setscriptablepartstate( #"vfx", #"despawn" );
    wait 1;
    pedestal_scriptable freescriptable();
    level.var_1a1166e7984f4f9a = 0;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0x2638f1ba, Offset: 0x9b4
// Size: 0xe0
function private function_567c2ce5ecb68e84( origin )
{
    level endon( #"game_ended" );
    powerup = powerups::powerup_drop( "locust_boss", origin + ( 0, 0, 200 ), -1 );
    powerup endon( #"death", #"destroyed" );
    powerup.angles += ( 0, 180, 0 );
    powerup moveto( origin + ( 0, 0, 60 ), 1.8, 0, 1.8 );
    level thread rotate_powerup( powerup );
    wait 1.8;
    
    if ( powerup )
    {
        down_vector = anglestoup( powerup.angles ) * -1;
        powerup function_616378d7e5b22efb( down_vector, 1, 2, 0 );
    }
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0x8b66fc0f, Offset: 0xa9c
// Size: 0x11c
function private rotate_powerup( powerup )
{
    level endon( #"game_ended" );
    powerup endon( #"death", #"destroyed" );
    current_angle = 0;
    previous_time_ms = gettime();
    current_time_ms = gettime();
    
    while ( isdefined( powerup ) )
    {
        current_time_ms = gettime();
        elapsed_time_sec = ( current_time_ms - previous_time_ms ) * 0.001;
        previous_time_ms = gettime();
        current_angle = math::wrap( 0, 360, current_angle + elapsed_time_sec * 65 );
        x = cos( current_angle ) + powerup.origin[ 0 ];
        y = sin( current_angle ) + powerup.origin[ 1 ];
        vector = ( x, y, 0 ) - ( powerup.origin[ 0 ], powerup.origin[ 1 ], 0 );
        new_angles = vectortoangles( vector );
        powerup.angles = new_angles;
        waitframe();
    }
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 0, eflags: 0x4
// Checksum 0xada9d983, Offset: 0xbc0
// Size: 0xb
function private function_cc7c499fa7e81793()
{
    return level.completed_ruby_mq;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0x1ac34277, Offset: 0xbd4
// Size: 0x9f
function private function_faa65c55f256000b( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.completed_ruby_mq )
    {
        return;
    }
    
    if ( params.achievementid == 64034 )
    {
        standard_complete = playerachievements::function_ce48098d17912e1f( self, 64034, "progress", 0 );
    }
    else if ( params.achievementid == 64041 )
    {
        directed_complete = playerachievements::function_ce48098d17912e1f( self, 64041, "progress", 0 );
    }
    
    if ( isplayer( self ) && ( standard_complete || directed_complete ) )
    {
        level.completed_ruby_mq = 1;
    }
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0x14dcc944, Offset: 0xc7b
// Size: 0x49
function private function_fd089e2903b0723e( player )
{
    if ( !level.completed_ruby_mq )
    {
        standard_id = 64034;
        playerachievements::getstate( player, standard_id );
        directed_id = 64041;
        playerachievements::getstate( player, directed_id );
    }
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 0, eflags: 0x4
// Checksum 0x3ffcb85a, Offset: 0xccc
// Size: 0x3, Type: bool
function private function_955dae5a970dd94a()
{
    return false;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0xe25bdf, Offset: 0xcd8
// Size: 0x14
function private on_player_connect( params )
{
    function_fd089e2903b0723e( self );
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0xd4427aec, Offset: 0xcf4
// Size: 0x14c, Type: bool
function private function_22fc08d53be6ae( params )
{
    var_ab260cde1a778350 = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.var_35541497c394d312 ) || player.deaths == player.var_35541497c394d312 )
        {
            var_ab260cde1a778350 = 1;
            break;
        }
    }
    
    if ( level.var_1a1166e7984f4f9a && var_ab260cde1a778350 )
    {
        return true;
    }
    
    if ( !level.var_669124beebe79b16 )
    {
        return false;
    }
    else if ( level.var_65d57a041006dee5 && !level.var_1a1166e7984f4f9a )
    {
        return false;
    }
    else if ( !function_cc7c499fa7e81793() && !getdvarint( @"hash_cd26af899a846383", 0 ) )
    {
        return false;
    }
    
    alive_players = utility::get_alive_players( 0 );
    
    if ( alive_players.size > 0 )
    {
        return false;
    }
    
    if ( !var_ab260cde1a778350 )
    {
        return false;
    }
    
    level thread function_6478eae486cfa1e7( self );
    return true;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0xd39e8076, Offset: 0xe49
// Size: 0x7a
function private on_player_laststand( params )
{
    level endon( #"game_over" );
    self endon( #"death_or_disconnect" );
    
    if ( function_d4619d4a14c93fec() )
    {
        var_ef58452436339895 = zm_sat_locust_boss_fight::function_4266e2c0c79cdd07();
        
        if ( var_ef58452436339895.size == 0 || player::function_74a9f49efde97961( self ) )
        {
            function_22fc08d53be6ae();
            return;
        }
        
        wait 15;
        
        if ( player::isinlaststand( self ) && function_d4619d4a14c93fec() )
        {
            function_22fc08d53be6ae();
        }
    }
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 1, eflags: 0x4
// Checksum 0xc167ac8e, Offset: 0xecb
// Size: 0x357
function private function_44530372150997bf( player )
{
    var_d05f892b71c813f7 = [];
    var_3bcdd42135394f60 = utility::getstructarray( "bossBlessingLoc", "targetname" );
    
    if ( !isdefined( player ) || !isdefined( player.origin ) )
    {
        return var_3bcdd42135394f60[ 0 ].origin;
    }
    
    var_6885806edb06b191 = player.origin + ( 0, 0, 20 );
    
    foreach ( var_399a0f97e8cb8e0b in var_3bcdd42135394f60 )
    {
        if ( var_399a0f97e8cb8e0b.script_noteworthy == "height_req" && var_399a0f97e8cb8e0b.origin[ 2 ] > var_6885806edb06b191[ 2 ] )
        {
            continue;
        }
        
        var_43beac991c2a0b6f = level.var_a7599e13d3805dc2.size == 0 ? 1 : 0;
        
        foreach ( validity_zone in level.var_a7599e13d3805dc2 )
        {
            if ( math::function_47d0ed373b25c699( var_399a0f97e8cb8e0b.origin, validity_zone.aabb_min, validity_zone.aabb_max ) )
            {
                var_43beac991c2a0b6f = 1;
                break;
            }
        }
        
        if ( !var_43beac991c2a0b6f )
        {
            continue;
        }
        
        if ( distance2dsquared( var_399a0f97e8cb8e0b.origin, var_6885806edb06b191 ) > 1000000 )
        {
            continue;
        }
        
        var_d05f892b71c813f7[ var_d05f892b71c813f7.size ] = var_399a0f97e8cb8e0b;
    }
    
    if ( var_d05f892b71c813f7.size <= 0 )
    {
        assertmsg( "<dev string:x8c>" );
        var_d05f892b71c813f7 = var_3bcdd42135394f60;
    }
    
    var_8277262cdcb7c414 = sortbydistance( var_d05f892b71c813f7, var_6885806edb06b191 );
    fallback_struct = undefined;
    fallback_dot = undefined;
    ideal_struct = undefined;
    player_forward = anglestoforward( player.angles );
    
    for ( i = 0; i < var_8277262cdcb7c414.size ; i++ )
    {
        valid_location_struct = var_8277262cdcb7c414[ i ];
        elevated_struct_origin = valid_location_struct.origin + ( 0, 0, 65 );
        direction_vector = vectornormalize( elevated_struct_origin - var_6885806edb06b191 );
        dot = vectordot( direction_vector, player_forward );
        
        if ( dot >= 0.65 )
        {
            result = trace::ray_trace( var_6885806edb06b191, elevated_struct_origin, undefined, level.var_40eff250088d8288 );
            hit_geo = result[ "hittype" ] == "hittype_world";
            
            if ( !hit_geo )
            {
                ideal_struct = valid_location_struct;
                break;
            }
            
            if ( !hit_geo && dot > 0 && ( !isdefined( fallback_dot ) || dot > fallback_dot ) )
            {
                fallback_struct = valid_location_struct;
                fallback_dot = dot;
            }
        }
    }
    
    if ( !isdefined( ideal_struct ) )
    {
        ideal_struct = fallback_struct;
    }
    
    if ( !isdefined( ideal_struct ) )
    {
        ideal_struct = var_8277262cdcb7c414[ 0 ];
    }
    
    return ideal_struct;
}

// Namespace zm_sat_locust_caltheris_blessing
// Params 0
// Checksum 0xb42291e, Offset: 0x122b
// Size: 0x12d, Type: bool
function function_d4619d4a14c93fec()
{
    player = self;
    
    if ( !player.b_has_spawned_once && !player.var_5c81ab2cabcc273f && !player.var_282313ba8fafa8c6 )
    {
        return false;
    }
    
    if ( !player::isinlaststand( player ) && isalive( player ) && ( player.sessionstate == "playing" || player.sessionstate == "playing_but_spectating" ) )
    {
        return false;
    }
    
    if ( isalive( player ) && player laststand::function_7072b516e6cffb7c() > 0 )
    {
        return false;
    }
    
    if ( isdefined( player.selfrevivedata ) )
    {
        return false;
    }
    
    if ( level.var_e6e55ccba9ef0e84 > 0 )
    {
        return false;
    }
    
    if ( player val::get( "allow_last_stand" ) )
    {
        return false;
    }
    
    if ( player utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_last_chance" ) && player.var_84cde01ffd2cb360 < 3 )
    {
        return true;
    }
    
    return false;
}

