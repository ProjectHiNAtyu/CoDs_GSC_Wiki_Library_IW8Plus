// script_6da29e3ae241e21  (hash_06da29e3ae241e21.gscc) (size: 9048 Bytes / 0x2358 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fbe2bff (800992255)
// size ...... 9048 (0x2358)
// includes .. 7   (offset: 0x2078)
// strings ... 46  (offset: 0x20b0)
// dev strs .. 5   (offset: 0x231c)
// exports ... 16  (offset: 0x1580)
// cseg ...... 0x3cf + 0x11b1 (0x1580)
// imports ... 73  (offset: 0x1800)
// animtree1 . 0   (offset: 0x2358)
// animtree2 . 0   (offset: 0x2358)
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_6f8905547d0e74ed;

// Namespace namespace_6f8905547d0e74ed
// Params 0
// Checksum 0x1e6c0ec4, Offset: 0x3ed
// Size: 0x193
function init_zombiejacks_game()
{
    if ( !isdefined( level.s_zombiejacks_game ) )
    {
        level.s_zombiejacks_game = spawnstruct();
    }
    
    level.s_zombiejacks_game.var_fa795a9c34416db2 = utility::getstruct( "zombiejacks_center", "targetname" );
    level.s_zombiejacks_game.var_d7471cf7f600bf44 = utility::getstruct( "zombiejacks_start_pos", "targetname" );
    level.s_zombiejacks_game.interaction = zm_quest::function_91f9590e98d57ff6( level.s_zombiejacks_game.var_d7471cf7f600bf44.origin + ( 0, 0, 10 ), &on_start_zombiejacks_game, &function_b332f6a876e92eb8 );
    level.s_zombiejacks_game.var_6fdd2f80be44e1bf = utility::spawn_model( level.s_zombiejacks_game.var_d7471cf7f600bf44.script_noteworthy, level.s_zombiejacks_game.var_d7471cf7f600bf44.origin, level.s_zombiejacks_game.var_d7471cf7f600bf44.angles );
    level.s_zombiejacks_game.var_6fdd2f80be44e1bf utility::function_7c10ea82c1e305b8( "fx", "glow" );
    level.s_zombiejacks_game thread function_d5f263f90c265822();
    playfx( level._effect[ "goggles_pickup" ], level.s_zombiejacks_game.var_d7471cf7f600bf44.origin );
    
    /#
        level thread function_98f2489eb60da2fc();
    #/
}

// Namespace namespace_6f8905547d0e74ed
// Params 1
// Checksum 0xe8aa0e0d, Offset: 0x588
// Size: 0x16d
function start_zombiejacks_game( player )
{
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"disable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"disable" );
    }
    
    level thread zm_music::start_zone_music_watcher( "jacks_game_music", [ "zone_street_1_p", "zone_street_2_p" ], #"hash_45407f5a18fefe7" );
    level.s_zombiejacks_game.interaction zm_quest::function_9170db4686f796e2();
    level.s_zombiejacks_game.sound_sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_child_game_sound", level.s_zombiejacks_game.var_fa795a9c34416db2.origin );
    level.s_zombiejacks_game.sound_sbl utility::function_7c10ea82c1e305b8( "laughter_sound", "playing" );
    level.s_zombiejacks_game.outer_circle_vfx = namespace_2d09656773c0c203::function_5cb04c35b2faa393( "zombiejack_circle", level.s_zombiejacks_game.var_fa795a9c34416db2 );
    level.s_zombiejacks_game.var_6fdd2f80be44e1bf thread function_ebbb44d244ca0531();
    level.s_zombiejacks_game.var_6fdd2f80be44e1bf thread ball_damage_check( player );
    level.s_zombiejacks_game thread function_822f6cf46f6ee8da( player );
    level.s_zombiejacks_game thread zombiejacks_game_process( player );
}

// Namespace namespace_6f8905547d0e74ed
// Params 1
// Checksum 0xfe3da021, Offset: 0x6fd
// Size: 0x14a
function cleanup_zombiejacks_game( b_success )
{
    level endon( #"game_ended" );
    level thread zm_music::function_e9fd14ede793ef0d( "jacks_game_music" );
    wait 1;
    
    if ( isdefined( level.s_zombiejacks_game.outer_circle_vfx ) )
    {
        level.s_zombiejacks_game.outer_circle_vfx freescriptable();
    }
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
    
    if ( isdefined( level.s_zombiejacks_game.var_6fdd2f80be44e1bf ) )
    {
        if ( b_success )
        {
            playfx( level._effect[ "zombiejacks_ball_disappear" ], level.s_zombiejacks_game.var_6fdd2f80be44e1bf.origin );
        }
        else
        {
            playfx( level._effect[ "goggles_pickup" ], level.s_zombiejacks_game.var_6fdd2f80be44e1bf.origin );
        }
    }
    
    waitframe();
    
    if ( isdefined( level.s_zombiejacks_game ) )
    {
        level.s_zombiejacks_game.sound_sbl freescriptable();
        level.s_zombiejacks_game.var_6fdd2f80be44e1bf delete();
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 0, eflags: 0x4
// Checksum 0x1ea4a227, Offset: 0x84f
// Size: 0x73
function private start_loop_rotate()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_6fdd2f80be44e1bf endon( #"hash_c971de69f46f5be9" );
    var_402653d154a75a2 = vectortoangles( utility::randomvector( 1 ) );
    
    while ( true )
    {
        if ( isdefined( self.var_6fdd2f80be44e1bf ) )
        {
            self.var_6fdd2f80be44e1bf rotateby( var_402653d154a75a2, 10, 0, 0 );
            wait 10;
        }
        
        waitframe();
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 2, eflags: 0x4
// Checksum 0xded543ba, Offset: 0x8ca
// Size: 0xae
function private function_b332f6a876e92eb8( instance, player )
{
    if ( !zm_quest::function_b0a5181ebe7bb905() || !zm_quest::function_f98968f17772726c() || player.ismutantinjection )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_mantis/maintis_minigame_btn", #description:&"zm_sat_mantis/maintis_minigame_des", #title:&"zm_sat_mantis/maintis_minigame_tile", #type:"HINT_BUTTON" };
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0xaef6a87a, Offset: 0x981
// Size: 0x80
function private on_start_zombiejacks_game( player )
{
    if ( !zm_quest::function_f98968f17772726c( 0, [ "progressing_soul_charging" ] ) )
    {
        return;
    }
    
    if ( player.ismutantinjection )
    {
        return;
    }
    
    level.s_zombiejacks_game.activator = player;
    level utility::flag_set( "progressing_mini_games" );
    namespace_2d09656773c0c203::function_4ef47d3c5c627fb6();
    level thread start_zombiejacks_game( player );
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"start_zombiejacks", #"bc_flavor_player_positive" );
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0xf4580b91, Offset: 0xa09
// Size: 0x1fb
function private zombiejacks_game_process( player )
{
    level endon( #"game_ended" );
    level endon( #"zombiejacks_game_completed" );
    ball = level.s_zombiejacks_game.var_6fdd2f80be44e1bf;
    n_round = 0;
    player val::set( "zjck_active", "ignoreme", 1 );
    level.s_zombiejacks_game.activator = player;
    
    while ( true )
    {
        ball waittill( #"hash_be05466f55c5efeb" );
        level thread function_6e05b949797347c8( n_round );
        playsoundatpos( ball.origin, #"hash_f514305b450ae2ea" );
        ball waittill( #"hash_be05466f55c5efeb" );
        utility::array_thread( level.s_zombiejacks_game.var_5ac7a8efabb8c784, &function_3cc4739557e6fe9e, ball );
        playsoundatpos( ball.origin, #"hash_777691667df5b891" );
        n_gravity = getdvarfloat( @"zombiejacks_gravity", -600 );
        ball.gravity = n_gravity / squared( ball.time_scale );
        ball.velocity /= ball.time_scale;
        ball waittill( #"hash_be05466f55c5efeb" );
        ball.gravity *= squared( ball.time_scale );
        ball.velocity *= ball.time_scale;
        wait 0.05;
        
        if ( level.s_zombiejacks_game.var_5ac7a8efabb8c784.size > 0 )
        {
            level notify( #"zombiejacks_game_completed", 0, "zombie_hit_ground" );
            return;
        }
        
        n_round++;
        
        if ( n_round >= 4 )
        {
            break;
        }
    }
    
    level notify( #"zombiejacks_game_completed", 1 );
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0xdae70347, Offset: 0xc0c
// Size: 0x2a9
function private function_6e05b949797347c8( n_round )
{
    level endon( #"game_ended" );
    level endon( #"zombiejacks_game_completed" );
    level.s_zombiejacks_game.var_5ac7a8efabb8c784 = [];
    var_5b64fd1d9acccb9b = 2 + n_round * 1;
    n_spawn_radius = 50 + n_round * 40 + 40;
    n_spawn_radius = clamp( n_spawn_radius, 0, 150 );
    spawn_points = ai::function_7bcb54b16c07d1ec( var_5b64fd1d9acccb9b, level.s_zombiejacks_game.var_fa795a9c34416db2.origin, 50, n_spawn_radius, 50 );
    
    foreach ( point in spawn_points )
    {
        zombie = zm_quest::spawn_zombies_at_location( "zombie_base", point, 1, 0, undefined, 1, 1, 1 )[ 0 ];
        zombie utility::callsharedfunc( #"zombie", #"stunZombie", 10 );
        zombie utility::ent_flag_set( "dissolve_purple" );
        zombie utility::ent_flag_set( "dark_aether_bubble" );
        zombie.forceragdollimmediate = 1;
        linkto_ent = utility::spawn_model( "tag_origin", zombie.origin );
        zombie linkto( linkto_ent );
        zombie.linkto_ent = linkto_ent;
        zombie thread function_c0a243ebedbd47c9( linkto_ent );
        zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "hide_immediately" );
        zombie utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_in" );
        zombie val::set( "zombiejacks", "ignoreall", 1 );
        zombie val::set( "zombiejacks", "ignoreme", 1 );
        zombie val::set( "zombiejacks", "damageshield", 1 );
        zombie val::set( "zombiejacks", "ammomod_immune", 1 );
        zombie val::set( "zombiejacks", "play_ambient_vo", 0 );
        zombie.nodamagenumbers = 1;
        playfx( utility::getfx( "zombie_game_spawn" ), zombie.origin + ( 0, 0, 50 ) );
        level.s_zombiejacks_game.var_5ac7a8efabb8c784[ level.s_zombiejacks_game.var_5ac7a8efabb8c784.size ] = zombie;
        wait 0.2;
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0x96cdcc0f, Offset: 0xebd
// Size: 0x45
function private function_3cc4739557e6fe9e( ball )
{
    if ( isdefined( self.linkto_ent ) && isdefined( ball ) )
    {
        self.linkto_ent linkto( ball );
    }
    
    if ( isdefined( self ) )
    {
        val::reset( "zombiejacks", "damageshield" );
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0x7a0f309b, Offset: 0xf0a
// Size: 0xd6
function private function_c0a243ebedbd47c9( linkto_ent )
{
    utility::waittill_any_ents( self, "death", level, "zombiejacks_game_completed" );
    
    if ( isdefined( linkto_ent ) )
    {
        linkto_ent delete();
    }
    
    if ( isalive( self ) )
    {
        val::nuke( "damageshield" );
        playfx( level._effect[ "zombiejack_despawn" ], self gettagorigin( "j_spine4" ) );
        self.forceannihilate = 1;
        self kill();
    }
    else if ( isdefined( level.s_zombiejacks_game.var_5ac7a8efabb8c784 ) )
    {
        level.s_zombiejacks_game.var_5ac7a8efabb8c784 = function_46f9072493651dc9( level.s_zombiejacks_game.var_5ac7a8efabb8c784 );
    }
    
    corpse = self getcorpseentity();
    
    if ( isdefined( corpse ) )
    {
        corpse thread utility::delete_after_delay( 6 );
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0x97f4616, Offset: 0xfe8
// Size: 0xaf
function private function_822f6cf46f6ee8da( player )
{
    level endon( #"game_ended" );
    level endon( #"zombiejacks_game_completed" );
    
    while ( true )
    {
        msg = player utility::waittill_any_timeout( 1, "death_or_disconnect" );
        
        if ( msg != "timeout" )
        {
            level notify( #"zombiejacks_game_completed", 0, "player_death_or_disconnect" );
            return;
        }
        
        if ( distancesquared( player.origin, level.s_zombiejacks_game.var_fa795a9c34416db2.origin ) > squared( 300 ) )
        {
            level notify( #"zombiejacks_game_completed", 0, "player_out_of_game_area" );
            return;
        }
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 0, eflags: 0x4
// Checksum 0x37ea7d17, Offset: 0x109f
// Size: 0x117
function private function_d5f263f90c265822()
{
    level endon( #"game_ended" );
    level waittill( #"zombiejacks_game_completed", b_success, reason );
    
    /#
        iprintlnbold( "<dev string:x24>" + ( b_success ? "<dev string:x40>" : "<dev string:x48>" ) + "<dev string:x4d>" + ( reason ?? "<dev string:x52>" ) );
    #/
    
    cleanup_zombiejacks_game( b_success );
    
    if ( isdefined( level.s_zombiejacks_game.activator ) )
    {
        level.s_zombiejacks_game.activator utility::delaythread( 2, &val::reset, "zjck_active", "ignoreme" );
    }
    
    if ( !b_success )
    {
        if ( !level.s_zombiejacks_game.var_6f783d42b80c3b4b )
        {
            level.s_zombiejacks_game.var_6f783d42b80c3b4b = 1;
            level utility::delaythread( 1, &zm_quest::function_d5ef98341fd6a057, [ #"hash_e2fda6bd431fdac2", #"hash_e2fda5bd431fd90f", #"hash_e2fda4bd431fd75c" ] );
        }
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 1, eflags: 0x4
// Checksum 0xbc1e6aaa, Offset: 0x11be
// Size: 0xc6
function private ball_damage_check( player )
{
    level endon( #"game_ended" );
    level endon( #"zombiejacks_game_completed" );
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        level notify( #"zombiejacks_game_completed", 0, "hit_the_ball" );
    }
}

// Namespace namespace_6f8905547d0e74ed
// Params 0, eflags: 0x4
// Checksum 0x2edc4519, Offset: 0x128c
// Size: 0x262
function private function_ebbb44d244ca0531()
{
    self notify( #"hash_c971de69f46f5be9" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.velocity = ( 0, 0, getdvarfloat( @"hash_7cce23101b0e8720", 300 ) );
    self.time_scale = level.players.size < 2 ? 2 : 1;
    self.gravity = getdvarfloat( @"zombiejacks_gravity", -600 );
    
    while ( true )
    {
        var_ec6ccdd6bccca71e = self.velocity[ 2 ];
        var_3b153a39b1443d9d = self.velocity[ 2 ] * 0.02 + 0.5 * self.gravity * squared( 0.02 );
        velocity_z = self.velocity[ 2 ] + self.gravity * 0.02;
        var_b1f700964c2fb850 = ( self.velocity[ 0 ] * 0.02, self.velocity[ 1 ] * 0.02, 0 );
        self.velocity = ( self.velocity[ 0 ], self.velocity[ 1 ], velocity_z );
        
        if ( var_ec6ccdd6bccca71e >= 0 && velocity_z < 0 )
        {
            wait getdvarfloat( @"hash_cd23f1b9d6e9c8ca", 0.25 );
        }
        
        if ( utility::ent_flag( "has_bounced" ) && velocity_z < 0 )
        {
            utility::ent_flag_clear( "has_bounced" );
        }
        
        if ( self.origin[ 2 ] + var_3b153a39b1443d9d + -5 <= level.s_zombiejacks_game.var_fa795a9c34416db2.origin[ 2 ] && !utility::ent_flag( "has_bounced" ) )
        {
            self.velocity = ( self.velocity[ 0 ], self.velocity[ 1 ], velocity_z * -1 );
            utility::ent_flag_set( "has_bounced" );
            playfx( utility::getfx( "zombie_ball_bounce" ), self.origin );
            playsoundatpos( self.origin, #"hash_1ef91b4b48404da1" );
            self notify( #"hash_be05466f55c5efeb" );
        }
        
        self.origin = self.origin + ( 0, 0, var_3b153a39b1443d9d ) + var_b1f700964c2fb850;
        wait 0.02;
    }
}

/#

    // Namespace namespace_6f8905547d0e74ed
    // Params 0, eflags: 0x4
    // Checksum 0x983d19de, Offset: 0x14f6
    // Size: 0x8a, Type: dev
    function private function_98f2489eb60da2fc()
    {
        circle( level.s_zombiejacks_game.var_fa795a9c34416db2.origin, 150, ( 0, 0, 1 ), ( 1, 0, 0 ), 0, 10000 );
        circle( level.s_zombiejacks_game.var_fa795a9c34416db2.origin, 300, ( 0, 0, 1 ), ( 0, 1, 0 ), 0, 10000 );
    }

#/
