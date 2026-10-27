// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_leap.gsc  (hash_5ff46d0bfc571e71.gscc) (size: 10749 Bytes / 0x29fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb648f1e (3949235998)
// size ...... 10749 (0x29fd)
// includes .. 10  (offset: 0x27d1)
// strings ... 25  (offset: 0x2821)
// dev strs .. 9   (offset: 0x2989)
// exports ... 26  (offset: 0x16b9)
// cseg ...... 0x1d3 + 0x14e6 (0x16b9)
// imports ... 110 (offset: 0x1ac9)
// animtree1 . 0   (offset: 0x29fd)
// animtree2 . 0   (offset: 0x29fd)
#using script_16ea1b94f0f381b3;
#using script_6b56d7e66ae770bc;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_collision;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_phobos_leap;

// Namespace zombie_phobos_leap
// Params 1
// Checksum 0x8877032a, Offset: 0x1f1
// Size: 0xc
function function_c7ce84b91493e6bf( var_4b4d72d84afd1ebd )
{
    
}

// Namespace zombie_phobos_leap
// Params 0
// Checksum 0xf94f2bc9, Offset: 0x205
// Size: 0x13
function function_7190f4797876d15c()
{
    zombie_leap_attack::init_zombie_leap_attack_global();
    
    /#
        setup_leap_devgui();
    #/
}

// Namespace zombie_phobos_leap
// Params 0
// Checksum 0x37694d42, Offset: 0x220
// Size: 0x53
function init_zombie_phobos_leap()
{
    zombie_leap_attack::init_zombie_leap_attack();
    self.var_d92b1370dc5d2085 = self._blackboard.var_ed8e43492e9992f3;
    self.var_ec8b0ebe8388b53 = self._blackboard.var_93c0b68a5d2543c5;
    self.var_ba4a1749aa85d7fe = 150;
    thread leap_start_watcher();
}

// Namespace zombie_phobos_leap
// Params 2
// Checksum 0x4e9897c8, Offset: 0x27b
// Size: 0x7f, Type: bool
function leap_forward( phobos, dist )
{
    var_2738c4b734584497 = phobos.origin + anglestoforward( phobos.angles ) * dist;
    var_2738c4b734584497 = phobos function_351cbae8705f818b( var_2738c4b734584497 );
    
    if ( isdefined( var_2738c4b734584497 ) && !phobos function_115ace7999b27fd4( var_2738c4b734584497 ) )
    {
        phobos._blackboard.var_497e751941b50bed = var_2738c4b734584497;
        phobos namespace_4971355493d96d89::function_f7d845fe8c934a7a();
        return true;
    }
    
    return false;
}

// Namespace zombie_phobos_leap
// Params 2
// Checksum 0x6b15db85, Offset: 0x303
// Size: 0x7d
function function_e899b588829ddcb2( taskid, params )
{
    var_2f3067ff1bed58fe = getdvarfloat( @"hash_a52092a27ce3e3fd", -1 );
    
    if ( var_2f3067ff1bed58fe >= 0 )
    {
        return var_2f3067ff1bed58fe;
    }
    
    var_160dbfcceeaa514c = gettime() - ( self.leap_end_time ?? 0 );
    cooldown_score = clamp( math::remap( var_160dbfcceeaa514c, 0, utility::function_4b74c15943231980( 90 ), 0, 1 ), 0, 1 );
    return cooldown_score;
}

// Namespace zombie_phobos_leap
// Params 2
// Checksum 0xadfb3974, Offset: 0x389
// Size: 0xa0
function function_bca74febcceae810( taskid, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return 0;
    }
    
    dist = distance( self.enemy.origin, self.origin );
    var_d0cc61378b5e595c = 700;
    dist_falloff = 400;
    var_387f6eac55078e1c = min( abs( var_d0cc61378b5e595c - dist ), dist_falloff );
    var_689b8d27ece8ea69 = math::remap( var_387f6eac55078e1c, dist_falloff, 0, 0.25, 1 );
    return var_689b8d27ece8ea69;
}

// Namespace zombie_phobos_leap
// Params 2
// Checksum 0xf3453f5c, Offset: 0x432
// Size: 0xf6
function function_88b3747e9a4b159d( taskid, params )
{
    score = 0.5;
    
    if ( !isplayer( self.enemy ) )
    {
        return score;
    }
    
    player = self.enemy;
    playerorigin = player geteye();
    playerangles = player getgunangles();
    
    if ( utility::within_fov( playerorigin, playerangles, self getcentroid(), 0.77 ) )
    {
        score += 0.25;
    }
    
    is_recently_damaged = isdefined( self.last_dmg_struct.timehit ) && gettime() - self.last_dmg_struct.timehit < 1000 && self.last_dmg_struct.eattacker == player;
    
    if ( is_recently_damaged )
    {
        score += 0.25;
    }
    
    return score;
}

// Namespace zombie_phobos_leap
// Params 2
// Checksum 0x5f39b23c, Offset: 0x531
// Size: 0x68
function function_ea3d8732794416ce( taskid, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return 0;
    }
    
    var_df7ec5a5be083365 = 2500;
    
    if ( self.var_72db27666d830ea3 && gettime() - self.var_72db27666d830ea3 < var_df7ec5a5be083365 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0x38172d75, Offset: 0x5a2
// Size: 0x5a
function private leap_start_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_start" );
        on_leap_start();
        thread utility::thread_on_notify( "hit_ground", &function_f262a45bbc032382, self, self, "leap_attack_end" );
        thread utility::thread_on_notify( "leap_attack_end", &on_leap_end, self, self, "leap_start" );
    }
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0x4341a5bb, Offset: 0x604
// Size: 0xf1
function private on_leap_start()
{
    self.turnrate = 1;
    self orientmode( "face point", self._blackboard.var_497e751941b50bed );
    utility::ent_flag_set( "in_phobos_leap" );
    
    if ( !self._blackboard.leapnoclip && function_2123139bf008be9b() )
    {
        self._blackboard.leapnoclip = 1;
        thread function_5a0b48393d948e3d();
    }
    
    dist2d = distance2d( self.origin, self._blackboard.var_497e751941b50bed );
    dist_scalar = clamp( math::remap( dist2d, 500, 1000, 0.5, 1 ), 0.5, 1 );
    zombie_leap_attack::set_leap_attack_min_speed( self.var_d92b1370dc5d2085 * dist_scalar );
    zombie_leap_attack::set_leap_attack_max_speed( self.var_ec8b0ebe8388b53 * dist_scalar );
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0xef131671, Offset: 0x6fd
// Size: 0xd9, Type: bool
function private function_2123139bf008be9b()
{
    var_6593c68a57c9b166 = 0.3;
    var_cf92485977bcf207 = 0.95;
    var_9dafaad9cf7295c6 = 32;
    var_19a82d47f70abd4c = utility::drop_to_ground( self.origin + anglestoforward( self.angles ) * var_9dafaad9cf7295c6, undefined, undefined, undefined, undefined, self, 1 );
    
    if ( !var_19a82d47f70abd4c )
    {
        return false;
    }
    
    ground_normal = var_19a82d47f70abd4c[ 1 ];
    
    if ( !ground_normal )
    {
        return false;
    }
    
    world_up = ( 0, 0, 1 );
    forward2d = vectornormalize2( anglestoforward( self.angles ) );
    up_dot = vectordot( ground_normal, world_up );
    return up_dot >= var_6593c68a57c9b166 && up_dot <= var_cf92485977bcf207 && vectordot( ground_normal, forward2d ) < 0;
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0xda1b8247, Offset: 0x7df
// Size: 0x30
function private function_5a0b48393d948e3d()
{
    self endon( #"death" );
    self waittill( #"leap_attack_end" );
    self._blackboard.leapnoclip = 0;
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0x91a97bdd, Offset: 0x817
// Size: 0x513
function private function_f262a45bbc032382()
{
    max_radius = getdvarfloat( @"hash_786293be1de8b667", 600 );
    enemies = self function_f017e352a29a57a1( self.origin, max_radius );
    var_a2a180f1053ba8a4 = getdvarfloat( @"hash_a6c49744c406ad3b", 200 );
    var_acd03f9b638ba930 = self.origin + anglestoforward( self.angles ) * var_a2a180f1053ba8a4;
    var_4b93e221138968ed = getdvarfloat( @"hash_488e4c562a82c50a", 150 );
    
    /#
        if ( debug_leap() )
        {
            utility::draw_circle( self.origin, max_radius, ( 0.5, 0.2, 0.4 ) );
            utility::draw_circle( var_acd03f9b638ba930, var_a2a180f1053ba8a4, ( 0.8, 0.1, 0.3 ) );
            line( var_acd03f9b638ba930, var_acd03f9b638ba930 + anglestoright( self.angles ) * var_4b93e221138968ed, ( 0.8, 0.1, 0.3 ) );
        }
    #/
    
    earthquake( 0.3, 3, self.origin, max_radius + 100 );
    chosen_enemy = undefined;
    target_loc = function_6dadfb58f5945af5( self );
    target_loc_nav = getclosestpointonnavmesh( target_loc );
    
    if ( isdefined( target_loc_nav ) && distance2d( target_loc_nav, target_loc ) < 15 )
    {
        chosen_distance = var_a2a180f1053ba8a4;
        
        foreach ( enemy in enemies )
        {
            dist = distance2d( enemy.origin, var_acd03f9b638ba930 );
            
            if ( dist <= var_a2a180f1053ba8a4 )
            {
                var_ee6433c31961982d = enemy.origin - self.origin;
                target_dist_right = vectordot( anglestoright( self.angles ), var_ee6433c31961982d );
                
                if ( abs( target_dist_right ) > var_4b93e221138968ed )
                {
                    continue;
                }
                
                if ( enemy islinked() )
                {
                    continue;
                }
                
                health_threshold = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a326b1134d0f212c;
                
                if ( self._blackboard.var_606bf8ea1f70975d > 0 )
                {
                    health_threshold = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e274589c93f2ef11 ?? health_threshold;
                }
                
                health_threshold = getdvarfloat( @"hash_414bf03f977f2d22", health_threshold );
                
                if ( isplayer( enemy ) && enemy.health > health_threshold )
                {
                    continue;
                }
                
                if ( enemy == self.enemy )
                {
                    chosen_enemy = enemy;
                    break;
                }
                
                if ( dist < chosen_distance )
                {
                    chosen_enemy = enemy;
                    chosen_distance = dist;
                }
            }
        }
        
        if ( chosen_enemy && isplayer( chosen_enemy ) )
        {
            thread start_post_leap_attack( self, chosen_enemy );
        }
    }
    
    base_zombie_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zombie_utils::get_zombie_round_difficulty() );
    
    foreach ( enemy in enemies )
    {
        if ( enemy == chosen_enemy )
        {
            continue;
        }
        
        if ( zombie_phobos_collision::is_player_attached( enemy ) )
        {
            continue;
        }
        
        if ( isplayer( enemy ) )
        {
            enemy dodamage( self._blackboard.leapattackdamage, self.origin, self, self, "MOD_MELEE" );
            knockback_dir = enemy.origin - self.origin + ( 0, 0, 100 );
            knockback_dir = vectornormalize( ( knockback_dir[ 0 ], knockback_dir[ 1 ], max( 100, knockback_dir[ 2 ] ) ) );
            enemy knockback( knockback_dir, 500, 1 );
            enemy playrumbleonentity( "heavy_1s" );
            continue;
        }
        
        enemy dodamage( base_zombie_health, self.origin, self, self, "MOD_MELEE", undefined, undefined, undefined, 1073741824 );
        enemy zombie_knockdown::function_6fc167d4a3590991( self.origin, 200, 45 );
    }
    
    allies = getaiarrayinradius( self.origin, 256, self.team );
    
    foreach ( ally in allies )
    {
        if ( ally != self )
        {
            ally zombie_knockdown::function_6fc167d4a3590991( self.origin, 200, 45 );
        }
    }
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0x530f4317, Offset: 0xd32
// Size: 0x28
function private on_leap_end()
{
    self.leap_end_time = gettime();
    self clearpath();
    self setbtgoalstationary( 0 );
    utility::ent_flag_clear( "in_phobos_leap" );
}

// Namespace zombie_phobos_leap
// Params 2, eflags: 0x4
// Checksum 0x1adb48cb, Offset: 0xd62
// Size: 0x55c
function private start_post_leap_attack( phobos, player )
{
    player endon( #"death" );
    var_46af5b1f2d47005f = int( min( phobos._blackboard.leapattackdamage, player.health * 0.5 ) );
    player dodamage( var_46af5b1f2d47005f, phobos.origin, phobos, phobos, "MOD_MELEE" );
    player playrumbleonentity( "heavy_2s" );
    assert( !isdefined( phobos.var_90b234392888ec7b ) );
    phobos utility::ent_flag_set( "post_leap_attack" );
    phobos.var_90b234392888ec7b = utility::spawn_tag_origin( player.origin, phobos.angles + ( -50, 180, 0 ) );
    phobos thread utility::delete_on_death( phobos.var_90b234392888ec7b );
    attach_org = phobos.var_90b234392888ec7b;
    player playerlinktodelta( attach_org, "tag_origin", 10, 10, 10, 10, 10, 1 );
    attach_org utility::thread_on_notify_no_endon_death( "death", &unlink_player, player, player );
    player hidelegs();
    player setstance( "prone", 1, 1 );
    phobos function_786bb6aa1b76c7ee( "post_leap_attack_requested", 1 );
    msg = phobos utility::waittill_any_timeout( 1, "post_leap_attack_init", "death" );
    phobos function_786bb6aa1b76c7ee( "post_leap_attack_requested", 0 );
    
    if ( msg == "post_leap_attack_init" )
    {
        phobos thread utility::thread_on_notify( "post_leap_attack_terminate", &cleanup_post_leap_attack, phobos, phobos, "post_leap_attack_init", phobos );
        target_location = function_6dadfb58f5945af5( phobos );
        attach_org moveto( target_location, getdvarfloat( @"hash_156dc0e806992915", 0.2 ), 0.1 );
        phobos waittill( #"initial_bite" );
        phobos utility::function_7c10ea82c1e305b8( "bite", "hit" );
        attach_offset = ( 30, 0, 30 );
        var_3f361f859aabeb74 = ( 0, 180, -90 );
        
        if ( phobos && attach_org )
        {
            attach_org linkto( phobos, "j_tongue6", attach_offset, var_3f361f859aabeb74 );
        }
        
        player setstance( "crouch", 1, 1 );
        player earthquakeforplayer( 0.5, 0.5, player.origin, 500 );
        var_b202d837cf867e71 = int( min( phobos.var_6c41e8e873b7594e, player.health * 0.5 ) );
        player dodamage( var_b202d837cf867e71, phobos.origin, phobos, phobos, "MOD_MELEE" );
        player val::set( "phobos_post_leap_attack", "weapon", 1 );
        player val::set( "phobos_post_leap_attack", "freezecontrols", 1 );
        
        if ( phobos )
        {
            phobos waittill( #"initial_bite_release" );
        }
        
        player setstance( "stand", 1, 1 );
        
        if ( attach_org && phobos )
        {
            attach_org unlink();
            target_origin = phobos gettagorigin( "j_jaw" ) + ( 0, 0, 100 ) - anglestoforward( phobos.angles ) * getdvarfloat( @"hash_913c19443be0c7a1", 0 );
            attach_org moveto( target_origin + ( 0, 0, 320 ), getdvarfloat( @"hash_91f789b6f8e27365", 0.6 ), 0, 0.6 );
            target_angles = ( 89, 180 + phobos.angles[ 1 ], 0 );
            attach_org rotateto( target_angles, 0.3, 0, 0.2 );
        }
        
        wait getdvarfloat( @"hash_91f789b6f8e27365", 0.6 );
        
        if ( isdefined( attach_org ) )
        {
            attach_org moveto( attach_org.origin - ( 0, 0, 350 ), getdvarfloat( @"hash_54e327481d3a8e92", 0.6 ), 0.6, 0 );
        }
        
        if ( phobos )
        {
            phobos waittill( #"final_bite" );
        }
        
        player.falldamageprotection = 1;
        player thread utility::delaythread( 5, &function_ddd975eae1034efd );
        damage = phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9b95ac43ea7ec811 ?? 1;
        
        if ( self._blackboard.var_606bf8ea1f70975d > 0 )
        {
            damage = phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6e8add37cec213a4 ?? damage;
        }
        
        player dodamage( damage, phobos.origin, phobos, phobos, "MOD_MELEE" );
        
        if ( phobos )
        {
            phobos utility::function_7c10ea82c1e305b8( "bite", "hit" );
        }
        
        player earthquakeforplayer( 0.5, 0.5, player.origin, 500 );
        cleanup_post_leap_attack( phobos );
        random_dir = anglestoforward( phobos.angles + ( getdvarfloat( @"hash_b83bdbfcb14bf6dc", 10 ), 0, 0 ) );
        player knockback( random_dir, getdvarfloat( @"hash_f6427bd70a37e3e1", 300 ), 1 );
        return;
    }
    
    cleanup_post_leap_attack( phobos );
}

// Namespace zombie_phobos_leap
// Params 1, eflags: 0x4
// Checksum 0x67a06b55, Offset: 0x12c6
// Size: 0x13
function private unlink_player( player )
{
    player unlink();
}

// Namespace zombie_phobos_leap
// Params 1, eflags: 0x4
// Checksum 0xc421ff91, Offset: 0x12e1
// Size: 0x38
function private function_6dadfb58f5945af5( phobos )
{
    return phobos.origin + anglestoforward( phobos.angles ) * getdvarfloat( @"hash_3169dd5ba235fd84", 300 );
}

// Namespace zombie_phobos_leap
// Params 0, eflags: 0x4
// Checksum 0xf883632d, Offset: 0x1322
// Size: 0xc
function private function_ddd975eae1034efd()
{
    self.falldamageprotection = 0;
}

// Namespace zombie_phobos_leap
// Params 1, eflags: 0x4
// Checksum 0x30662979, Offset: 0x1336
// Size: 0x104
function private cleanup_post_leap_attack( phobos )
{
    if ( isdefined( phobos.var_90b234392888ec7b ) )
    {
        linked_ents = phobos.var_90b234392888ec7b getlinkedchildren();
        
        foreach ( ent in linked_ents )
        {
            if ( isplayer( ent ) )
            {
                ent showlegs();
                ent setplayerangles( phobos.var_90b234392888ec7b.angles );
                ent val::reset_all( "phobos_post_leap_attack" );
                thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( ent, 0, 0.05 );
            }
        }
        
        phobos.var_90b234392888ec7b delete();
    }
    
    phobos utility::ent_flag_clear( "post_leap_attack" );
}

/#

    // Namespace zombie_phobos_leap
    // Params 0
    // Checksum 0x40434ead, Offset: 0x1442
    // Size: 0x6f, Type: dev
    function setup_leap_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x47>", &force_leap, 1 );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x70>", &function_832eddb384d74758 );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:x99>", &function_44541b12b5539155, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_leap() )
        {
            level thread function_98055717ea94b90d();
        }
    }

    // Namespace zombie_phobos_leap
    // Params 0, eflags: 0x4
    // Checksum 0x7784df4a, Offset: 0x14b9
    // Size: 0x44, Type: dev
    function private force_leap()
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xab>" );
        
        if ( isdefined( phobos ) )
        {
            leap_forward( phobos, 1000 );
        }
    }

    // Namespace zombie_phobos_leap
    // Params 0, eflags: 0x4
    // Checksum 0x5f72aa4a, Offset: 0x1505
    // Size: 0x5b, Type: dev
    function private function_832eddb384d74758()
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xab>" );
        
        if ( isdefined( phobos ) )
        {
            thread start_post_leap_attack( phobos, level.players[ 0 ] );
            wait 0.2;
            phobos namespace_4971355493d96d89::function_a842a936c41c5dde();
        }
    }

    // Namespace zombie_phobos_leap
    // Params 1, eflags: 0x4
    // Checksum 0x4fa718f2, Offset: 0x1568
    // Size: 0x44, Type: dev
    function private function_44541b12b5539155( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb9>", @"hash_f5984272459bb190" );
        
        if ( debug_leap() )
        {
            level thread function_98055717ea94b90d();
            return;
        }
        
        level notify( #"hash_758b307cf320a5c0" );
    }

    // Namespace zombie_phobos_leap
    // Params 0, eflags: 0x4
    // Checksum 0x7d921339, Offset: 0x15b4
    // Size: 0x16, Type: dev
    function private debug_leap()
    {
        return getdvarint( @"hash_f5984272459bb190", 0 ) > 0;
    }

    // Namespace zombie_phobos_leap
    // Params 0, eflags: 0x4
    // Checksum 0xd887fb20, Offset: 0x15d2
    // Size: 0xe7, Type: dev
    function private function_98055717ea94b90d()
    {
        level endon( #"hash_758b307cf320a5c0" );
        
        while ( true )
        {
            phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xab>" );
            
            if ( !isdefined( phobos ) )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( phobos.var_90b234392888ec7b ) )
            {
                sphere( phobos.var_90b234392888ec7b.origin, 15, ( 1, 0, 0 ), 1, 20 );
                line( phobos.var_90b234392888ec7b.origin, phobos.var_90b234392888ec7b.origin + anglestoforward( phobos.var_90b234392888ec7b.angles ) * 30, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
