// script_4382611bb6bbf2a0  (hash_4382611bb6bbf2a0.gscc) (size: 10666 Bytes / 0x29aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ef6ed81 (2666982785)
// size ...... 10666 (0x29aa)
// includes .. 7   (offset: 0x27ca)
// strings ... 26  (offset: 0x2802)
// dev strs .. 4   (offset: 0x296e)
// exports ... 19  (offset: 0x1b0a)
// cseg ...... 0x24e + 0x18bc (0x1b0a)
// imports ... 83  (offset: 0x1e02)
// animtree1 . 0   (offset: 0x29aa)
// animtree2 . 0   (offset: 0x29aa)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_3424894d82205bda;

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0xc4982c87, Offset: 0x26c
// Size: 0x242
function init_foursquare_game()
{
    if ( !isdefined( level.s_foursquare_game ) )
    {
        level.s_foursquare_game = spawnstruct();
    }
    
    if ( !isdefined( level.s_foursquare_game.var_fa795a9c34416db2 ) )
    {
        level.s_foursquare_game.var_fa795a9c34416db2 = utility::getstruct( "foursquare_center", "targetname" );
    }
    
    if ( !isdefined( level.s_foursquare_game.var_d7471cf7f600bf44 ) )
    {
        level.s_foursquare_game.var_d7471cf7f600bf44 = utility::getstruct( "foursquare_start_pos", "targetname" );
    }
    
    playfx( level._effect[ "goggles_pickup" ], level.s_foursquare_game.var_d7471cf7f600bf44.origin );
    level.s_foursquare_game.interaction = zm_quest::function_91f9590e98d57ff6( level.s_foursquare_game.var_d7471cf7f600bf44.origin, &on_start_foursquare_game, &hint_start_foursquare_game );
    level.s_foursquare_game.var_6fdd2f80be44e1bf = utility::spawn_model( level.s_foursquare_game.var_d7471cf7f600bf44.script_noteworthy, level.s_foursquare_game.var_d7471cf7f600bf44.origin, level.s_foursquare_game.var_d7471cf7f600bf44.angles, undefined, 1 );
    level.s_foursquare_game.damage_proxy = utility::spawn_model( "t10_zm_gameplay_collision_05", level.s_foursquare_game.var_d7471cf7f600bf44.origin, level.s_foursquare_game.var_d7471cf7f600bf44.angles );
    level.s_foursquare_game.damage_proxy linkto( level.s_foursquare_game.var_6fdd2f80be44e1bf );
    level.s_foursquare_game.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "fx", "glow" );
    level.s_foursquare_game thread start_loop_rotate();
    function_6e4a744ee4fe79ab();
    
    /#
        level thread function_eac9041d551d54a4();
    #/
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0xf84c656a, Offset: 0x4b6
// Size: 0x16b
function function_6e4a744ee4fe79ab()
{
    v_forward = anglestoforward( level.s_foursquare_game.var_fa795a9c34416db2.angles );
    var_1797ef2d4e032c54 = anglestoleft( level.s_foursquare_game.var_fa795a9c34416db2.angles );
    v_right = anglestoright( level.s_foursquare_game.var_fa795a9c34416db2.angles );
    var_23db0ba90da1297c = 64;
    
    if ( !isdefined( level.s_foursquare_game.var_76917f4a688deb31 ) )
    {
        level.s_foursquare_game.var_76917f4a688deb31 = [ level.s_foursquare_game.var_fa795a9c34416db2.origin + v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c, level.s_foursquare_game.var_fa795a9c34416db2.origin + v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c, level.s_foursquare_game.var_fa795a9c34416db2.origin - v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c, level.s_foursquare_game.var_fa795a9c34416db2.origin - v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c ];
    }
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0xe18a8d14, Offset: 0x629
// Size: 0x73
function start_loop_rotate()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_6fdd2f80be44e1bf endon( #"hash_c971de69f46f5be9" );
    var_402653d154a75a2 = vectortoangles( utility::randomvector( 1 ) );
    
    while ( true )
    {
        if ( isdefined( self.var_6fdd2f80be44e1bf ) )
        {
            self.var_6fdd2f80be44e1bf rotateby( var_402653d154a75a2, 5, 0, 0 );
            wait 5;
        }
        
        waitframe();
    }
}

// Namespace namespace_3424894d82205bda
// Params 2
// Checksum 0xc8d231e5, Offset: 0x6a4
// Size: 0xb9
function hint_start_foursquare_game( instance, player )
{
    if ( !zm_quest::function_b0a5181ebe7bb905() || !zm_quest::function_f98968f17772726c() || player.ismutantinjection )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #interactable:1, #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_mantis/maintis_minigame_btn", #description:&"zm_sat_mantis/maintis_minigame_des", #title:&"zm_sat_mantis/maintis_minigame_tile", #type:"HINT_BUTTON" };
}

// Namespace namespace_3424894d82205bda
// Params 1
// Checksum 0xf4f99f7d, Offset: 0x766
// Size: 0xad
function on_start_foursquare_game( player )
{
    if ( !zm_quest::function_f98968f17772726c( 0, [ "progressing_soul_charging" ] ) )
    {
        return;
    }
    
    if ( player.ismutantinjection )
    {
        return;
    }
    
    level.s_foursquare_game.activator = player;
    level utility::flag_set( "progressing_mini_games" );
    zm_sat_mantis_quest_mq::function_4ef47d3c5c627fb6();
    level thread start_foursquare_game( player );
    
    if ( !level.s_foursquare_game.b_played_banter )
    {
        level.s_foursquare_game.b_played_banter = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"start_foursquare", #"bc_flavor_player_positive" );
    }
}

// Namespace namespace_3424894d82205bda
// Params 1
// Checksum 0xf4c0939f, Offset: 0x81b
// Size: 0x21b
function start_foursquare_game( player )
{
    level.s_foursquare_game.n_game_time = level.players.size == 1 ? 25 : 30;
    level thread zm_music::start_zone_music_watcher( "square_game_music", [ "zone_backyard1_b_p", "zone_backyard1_a_p", "zone_deck1_p" ], #"hash_45407f5a18fefe7" );
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"disable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"disable" );
    }
    
    level thread zm_round_spawning::pause_round_spawning( 1, "foursquare_game" );
    level.s_foursquare_game.interaction zm_quest::function_9170db4686f796e2();
    level.s_foursquare_game.sound_sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_child_game_sound", level.s_foursquare_game.var_fa795a9c34416db2.origin );
    player val::set( "foursquare_active", "ignoreme", 1 );
    level thread function_547faddf231fa768();
    level.s_foursquare_game.var_6fdd2f80be44e1bf.aabb_index = function_b6b1d9fc5ae11d50();
    level.s_foursquare_game.var_6fdd2f80be44e1bf thread function_ebbb44d244ca0531();
    level.s_foursquare_game.var_6fdd2f80be44e1bf thread function_a429b8726e6a7cc7();
    level.s_foursquare_game.var_6fdd2f80be44e1bf thread foursquare_game_timer();
    level.s_foursquare_game.damage_proxy setcandamage( 1 );
    level.s_foursquare_game.damage_proxy thread damage_check();
    function_efa287c2419bf4ec( 1 );
    playsoundatpos( level.s_foursquare_game.var_fa795a9c34416db2.origin, #"evt_mq_game_start_stinger" );
    level.s_foursquare_game.sound_sbl utility::function_7c10ea82c1e305b8( "laughter_sound", "playing" );
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0xe45d75ae, Offset: 0xa3e
// Size: 0xc5
function foursquare_game_timer()
{
    level endon( #"game_ended" );
    level endon( #"foursquare_game_completed" );
    var_76975b4b2eb18826 = utility::function_4b74c15943231980( level.s_foursquare_game.n_game_time );
    start_time = gettime();
    
    while ( true )
    {
        time_remaining = var_76975b4b2eb18826 - gettime() - start_time;
        time_remaining = clamp( time_remaining, 0, var_76975b4b2eb18826 );
        zm_quest::function_612a9ad0db22c29c( time_remaining, 1, #"mantis_mq", #"foursquare_game_timer" );
        
        if ( gettime() - start_time >= var_76975b4b2eb18826 )
        {
            level thread cleanup_foursquare_game();
            
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            level notify( #"foursquare_game_completed", 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0xc5e57d99, Offset: 0xb0b
// Size: 0xe8
function function_a429b8726e6a7cc7()
{
    level endon( #"game_ended" );
    level endon( #"foursquare_game_completed" );
    self.var_1e190bee9e1197c7 = 0;
    self.var_d63f7d965163ea32 = 0;
    
    while ( true )
    {
        level waittill( #"hash_be05466f55c5efeb" );
        
        if ( self.var_d63f7d965163ea32 && self.aabb_index != function_b6b1d9fc5ae11d50() )
        {
            self.var_1e190bee9e1197c7 = 0;
        }
        
        self.var_1e190bee9e1197c7++;
        
        if ( self.var_d63f7d965163ea32 && self.aabb_index == function_b6b1d9fc5ae11d50() && self.var_1e190bee9e1197c7 >= 2 || function_b6b1d9fc5ae11d50() == -1 )
        {
            level thread cleanup_foursquare_game( 1 );
            level notify( #"foursquare_game_completed", 0 );
            break;
        }
        
        self.aabb_index = function_b6b1d9fc5ae11d50();
        self.var_d63f7d965163ea32 = 1;
    }
}

// Namespace namespace_3424894d82205bda
// Params 1
// Checksum 0xf6be70c6, Offset: 0xbfb
// Size: 0x245
function cleanup_foursquare_game( var_412eb8cfd17e35fd )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_412eb8cfd17e35fd ) )
    {
        var_412eb8cfd17e35fd = 0;
    }
    
    level notify( #"reset_test" );
    level thread zm_music::function_e9fd14ede793ef0d( "square_game_music" );
    function_efa287c2419bf4ec( 0 );
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player utility::delaythread( 1, &val::reset, "foursquare_active", "ignoreme" );
            player.var_ea71d12bfbbdbcb9 = undefined;
        }
    }
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
    
    playfx( level._effect[ "goggles_pickup" ], level.s_foursquare_game.var_6fdd2f80be44e1bf.origin );
    waitframe();
    level.s_foursquare_game.damage_proxy unlink();
    level.s_foursquare_game.damage_proxy delete();
    level.s_foursquare_game.var_6fdd2f80be44e1bf delete();
    level.s_foursquare_game.sound_sbl freescriptable();
    level thread zm_round_spawning::pause_round_spawning( 0, "foursquare_game" );
    
    if ( !isdefined( level.s_foursquare_game.var_6f783d42b80c3b4b ) && var_412eb8cfd17e35fd )
    {
        level.s_foursquare_game.var_6f783d42b80c3b4b = 1;
        level utility::delaythread( 1, &zm_quest::function_d5ef98341fd6a057, [ #"hash_5de4b308e2c8eb8b", #"hash_5de4b408e2c8ed3e", #"hash_5de4b508e2c8eef1", #"hash_5de4b608e2c8f0a4", #"hash_5de4b708e2c8f257", #"hash_5de4b808e2c8f40a" ] );
    }
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0x9ee462a3, Offset: 0xe48
// Size: 0x324
function damage_check()
{
    level endon( #"game_ended" );
    level endon( #"foursquare_game_completed" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( smeansofdeath == "MOD_MELEE" )
        {
            n_target_index = function_b4434383fc37e104( direction_vec );
            
            if ( n_target_index != -1 )
            {
                v_target_center = level.s_foursquare_game.var_76917f4a688deb31[ n_target_index ];
                var_e52416d170b4070f = level.s_foursquare_game.var_6fdd2f80be44e1bf.origin;
                n_gravity = getdvarfloat( @"foursquare_gravity", -200 );
                n_travel_time = getdvarfloat( @"hash_a7f79c988d389478", 0.7 );
                n_vx = ( v_target_center[ 0 ] - var_e52416d170b4070f[ 0 ] ) / n_travel_time;
                n_vy = ( v_target_center[ 1 ] - var_e52416d170b4070f[ 1 ] ) / n_travel_time;
                var_a563a0aa67810cb7 = level.s_foursquare_game.var_fa795a9c34416db2.origin[ 2 ];
                n_vz = ( var_a563a0aa67810cb7 - var_e52416d170b4070f[ 2 ] ) / n_travel_time - 0.5 * n_gravity * n_travel_time;
                level.s_foursquare_game.var_6fdd2f80be44e1bf.velocity = ( n_vx, n_vy, n_vz );
                level.s_foursquare_game.var_6fdd2f80be44e1bf.gravity = n_gravity;
                level.s_foursquare_game.var_6fdd2f80be44e1bf.v_land_target = v_target_center;
            }
            else
            {
                n_gravity = getdvarfloat( @"foursquare_gravity", -200 );
                n_travel_time = getdvarfloat( @"hash_a7f79c988d389478", 0.7 );
                var_a563a0aa67810cb7 = level.s_foursquare_game.var_fa795a9c34416db2.origin[ 2 ];
                n_vz = ( var_a563a0aa67810cb7 - level.s_foursquare_game.var_6fdd2f80be44e1bf.origin[ 2 ] ) / n_travel_time - 0.5 * n_gravity * n_travel_time;
                level.s_foursquare_game.var_6fdd2f80be44e1bf.velocity = ( 0, 0, n_vz );
                level.s_foursquare_game.var_6fdd2f80be44e1bf.gravity = n_gravity;
                level.s_foursquare_game.var_6fdd2f80be44e1bf.v_land_target = undefined;
            }
            
            playsoundatpos( level.s_foursquare_game.var_6fdd2f80be44e1bf.origin, #"hash_db9ba8d57af66c17" );
        }
        
        waitframe();
    }
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0x35ecefba, Offset: 0x1174
// Size: 0x2c2
function function_ebbb44d244ca0531()
{
    self notify( #"hash_c971de69f46f5be9" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.velocity = ( 0, 0, 100 );
    self.time_scale = 1.7;
    self.gravity = getdvarfloat( @"foursquare_gravity", -200 );
    
    while ( true )
    {
        var_3b153a39b1443d9d = self.velocity[ 2 ] * 0.02 + 0.5 * self.gravity * squared( 0.02 );
        velocity_z = self.velocity[ 2 ] + self.gravity * 0.02;
        var_b1f700964c2fb850 = ( self.velocity[ 0 ] * 0.02, self.velocity[ 1 ] * 0.02, 0 );
        self.velocity = ( self.velocity[ 0 ], self.velocity[ 1 ], velocity_z );
        
        if ( utility::ent_flag( "has_bounced" ) && velocity_z < 0 )
        {
            utility::ent_flag_clear( "has_bounced" );
        }
        
        if ( self.origin[ 2 ] + var_3b153a39b1443d9d + -5 <= level.s_foursquare_game.var_fa795a9c34416db2.origin[ 2 ] && !utility::ent_flag( "has_bounced" ) )
        {
            utility::ent_flag_set( "has_bounced" );
            
            if ( isdefined( self.v_land_target ) )
            {
                self.origin = ( self.v_land_target[ 0 ], self.v_land_target[ 1 ], level.s_foursquare_game.var_fa795a9c34416db2.origin[ 2 ] );
                self.v_land_target = undefined;
            }
            else
            {
                self.origin = self.origin + ( 0, 0, var_3b153a39b1443d9d ) + var_b1f700964c2fb850;
            }
            
            bounce_height = getdvarfloat( @"hash_ac54f6fc210d5a8c", 64 );
            var_5c52832f4649267d = sqrt( 2 * abs( self.gravity ) * bounce_height );
            self.velocity = ( 0, 0, max( abs( velocity_z ), var_5c52832f4649267d ) );
            self.gravity = getdvarfloat( @"foursquare_gravity", -200 );
            playsoundatpos( self.origin, #"hash_741a7967f2ec957f" );
            level notify( #"hash_be05466f55c5efeb" );
            
            /#
                iprintlnbold( "<dev string:x3e>" );
            #/
        }
        else
        {
            self.origin = self.origin + ( 0, 0, var_3b153a39b1443d9d ) + var_b1f700964c2fb850;
        }
        
        wait 0.02;
    }
}

// Namespace namespace_3424894d82205bda
// Params 4
// Checksum 0x2fcb0aca, Offset: 0x143e
// Size: 0x7e, Type: bool
function function_cd0ac729c8f775e1( point, aabb_center, obb_radius, yaw )
{
    var_ce7447cbebe28d4c = anglestoaxis( ( 0, yaw, 0 ) );
    v = point - aabb_center;
    return abs( vectordot( v, var_ce7447cbebe28d4c[ "forward" ] ) ) <= obb_radius && abs( vectordot( v, var_ce7447cbebe28d4c[ "right" ] ) ) <= obb_radius;
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0x8d52a344, Offset: 0x14c5
// Size: 0xde
function function_b6b1d9fc5ae11d50()
{
    foreach ( index, aabb_center in level.s_foursquare_game.var_76917f4a688deb31 )
    {
        if ( function_cd0ac729c8f775e1( level.s_foursquare_game.var_6fdd2f80be44e1bf.origin, aabb_center, 64, level.s_foursquare_game.var_fa795a9c34416db2.angles[ 1 ] ) )
        {
            /#
                iprintlnbold( "<dev string:x51>" + index );
            #/
            
            return index;
        }
    }
    
    return -1;
}

// Namespace namespace_3424894d82205bda
// Params 1
// Checksum 0x91c45dd7, Offset: 0x15ac
// Size: 0x136
function function_b4434383fc37e104( v_direction )
{
    n_current_index = function_b6b1d9fc5ae11d50();
    v_dir_normalized = vectornormalize( ( v_direction[ 0 ], v_direction[ 1 ], 0 ) );
    n_best_index = -1;
    n_best_dot = -2;
    
    foreach ( index, aabb_center in level.s_foursquare_game.var_76917f4a688deb31 )
    {
        if ( index == n_current_index )
        {
            continue;
        }
        
        v_to_center = vectornormalize( aabb_center - level.s_foursquare_game.var_6fdd2f80be44e1bf.origin );
        var_69defb287fc50d2e = vectornormalize( ( v_to_center[ 0 ], v_to_center[ 1 ], 0 ) );
        var_4df7db8d01e4372c = vectordot( v_dir_normalized, var_69defb287fc50d2e );
        
        if ( var_4df7db8d01e4372c > n_best_dot )
        {
            n_best_dot = var_4df7db8d01e4372c;
            n_best_index = index;
        }
    }
    
    return n_best_index;
}

// Namespace namespace_3424894d82205bda
// Params 0
// Checksum 0x7c947697, Offset: 0x16eb
// Size: 0x166
function function_547faddf231fa768()
{
    level endon( #"game_ended" );
    level endon( #"foursquare_game_completed" );
    var_7ae605d773736268 = squared( 190 );
    var_dac75f4116c98678 = level.s_foursquare_game.var_fa795a9c34416db2.origin;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            var_92b21ca8efb6aef2 = distancesquared( player.origin, var_dac75f4116c98678 );
            b_inside_radius = var_92b21ca8efb6aef2 <= var_7ae605d773736268;
            
            if ( b_inside_radius && !player.var_ea71d12bfbbdbcb9 )
            {
                player val::set( "foursquare_active", "ignoreme", 1 );
                player.var_ea71d12bfbbdbcb9 = 1;
                continue;
            }
            
            if ( !b_inside_radius && player.var_ea71d12bfbbdbcb9 )
            {
                player val::reset( "foursquare_active", "ignoreme" );
                player.var_ea71d12bfbbdbcb9 = undefined;
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_3424894d82205bda
// Params 1
// Checksum 0x8ee4f548, Offset: 0x1859
// Size: 0xc0
function function_efa287c2419bf4ec( var_ae740a76f0c8ef99 )
{
    quest_ref = zm_quest::function_b0a5181ebe7bb905() ? #"mantis_mq_guidance" : #"mantis_mq";
    
    if ( var_ae740a76f0c8ef99 )
    {
        zm_quest::function_fba942a1cfd85f5d( 1, 1, quest_ref, #"foursquare_game_timer" );
        zm_quest::function_cd1f2fee4749fb0a( 1, quest_ref, #"foursquare_game_timer" );
        zm_quest::function_612a9ad0db22c29c( utility::function_4b74c15943231980( level.s_foursquare_game.n_game_time ), 1, quest_ref, #"foursquare_game_timer" );
        zm_quest::function_194bde735238c397( 1, 1, quest_ref, #"foursquare_game_timer" );
        return;
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_ref, #"foursquare_game_timer" );
}

/#

    // Namespace namespace_3424894d82205bda
    // Params 0
    // Checksum 0x538c2286, Offset: 0x1921
    // Size: 0x8e, Type: dev
    function function_eac9041d551d54a4()
    {
        foreach ( aabb_center in level.s_foursquare_game.var_76917f4a688deb31 )
        {
            level thread function_6996ff7fb25c9b41( aabb_center, 64 );
        }
    }

    // Namespace namespace_3424894d82205bda
    // Params 2
    // Checksum 0x89e75e9c, Offset: 0x19b7
    // Size: 0x153, Type: dev
    function function_6996ff7fb25c9b41( aabb_center, var_23db0ba90da1297c )
    {
        v_forward = anglestoforward( level.s_foursquare_game.var_fa795a9c34416db2.angles );
        var_1797ef2d4e032c54 = anglestoleft( level.s_foursquare_game.var_fa795a9c34416db2.angles );
        v_right = anglestoright( level.s_foursquare_game.var_fa795a9c34416db2.angles );
        vector1 = aabb_center + v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c;
        vector2 = aabb_center + v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c;
        vector3 = aabb_center - v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c;
        var_581ea6790791c7c7 = aabb_center - v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c;
        level thread utility::draw_line_for_time( vector1, vector2, 1, 0, 0, 100000, "<dev string:x5e>" );
        level thread utility::draw_line_for_time( vector2, vector3, 1, 0, 0, 100000, "<dev string:x5e>" );
        level thread utility::draw_line_for_time( var_581ea6790791c7c7, vector3, 1, 0, 0, 100000, "<dev string:x5e>" );
        level thread utility::draw_line_for_time( vector1, var_581ea6790791c7c7, 1, 0, 0, 100000, "<dev string:x5e>" );
    }

#/
