// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss.gsc  (hash_120071a48c5721b9.gscc) (size: 11149 Bytes / 0x2b8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4dc377ea (1304655850)
// size ...... 11149 (0x2b8d)
// includes .. 6   (offset: 0x28dd)
// strings ... 42  (offset: 0x290d)
// dev strs .. 0   (offset: 0x2b8d)
// exports ... 28  (offset: 0x1cad)
// cseg ...... 0x458 + 0x1855 (0x1cad)
// imports ... 64  (offset: 0x210d)
// animtree1 . 0   (offset: 0x2b8d)
// animtree2 . 0   (offset: 0x2b8d)
#using script_636bd827a012af12;
#using scripts\common\ai\aitypes\aries_boss\aries_boss;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;
#using scripts\mp\objidpoolmanager;

#namespace mars;

/#

    // Namespace mars
    // Params 0
    // Checksum 0x9d0e1b8, Offset: 0x476
    // Size: 0x5, Type: dev
    function function_20c2bde95a9e06fb()
    {
        
    }

#/

// Namespace mars
// Params 0
// Checksum 0x5e9a187e, Offset: 0x483
// Size: 0x3cc
function weak_point_setup()
{
    self.var_4b5ba7899abdcee6 = [ "phase_three":40, "phase_two":35, "phase_one":25 ];
    self.var_1d42ef2fdb0dbb1a = [];
    self.var_1fca27f31170a90d = [];
    self.health = 0;
    self.total_weak_points = 0;
    self.var_7946223663a6d48a = 0;
    weakpoint_health = level.is_squad_size_small ? 562 : 1125;
    boss_health = level.is_squad_size_small ? 900 : 1800;
    weakpoint_intervals = level.is_squad_size_small ? 0 : 1;
    weakpoint_tags = [ "tag_weakpoint_1", "tag_weakpoint_2", "tag_weakpoint_3", "tag_weakpoint_4", "tag_weakpoint_5", "tag_weakpoint_6", "tag_weakpoint_7" ];
    weakpoint_deck = utility::create_deck( weakpoint_tags, 1, 1 );
    vital_point_cluster = weak_point::cluster_setup( "mars_vital_point_phase_1", "closed", weakpoint_health, &function_667409c1c0a3e67c, weakpoint_intervals );
    self.var_1d42ef2fdb0dbb1a[ "phase_one" ] = vital_point_cluster;
    self.total_weak_points += vital_point_cluster.arr_weak_point.size;
    self.health += vital_point_cluster.arr_weak_point.size * weakpoint_health;
    self.var_1fca27f31170a90d[ "phase_one" ] = vital_point_cluster.arr_weak_point.size * weakpoint_health;
    
    foreach ( weakpoint in vital_point_cluster.arr_weak_point )
    {
        weakpoint_tag = weakpoint_deck utility::deck_draw();
        
        if ( weakpoint_tag == "tag_weakpoint_7" )
        {
            link_weakpoint( weakpoint, weakpoint_tag, ( 0, 0, 128 ) );
            continue;
        }
        
        link_weakpoint( weakpoint, weakpoint_tag );
    }
    
    vital_point_cluster = weak_point::cluster_setup( "mars_vital_point_phase_2", "closed", weakpoint_health, &function_667409c1c0a3e67c, weakpoint_intervals );
    self.var_1d42ef2fdb0dbb1a[ "phase_two" ] = vital_point_cluster;
    self.total_weak_points += vital_point_cluster.arr_weak_point.size;
    self.health += vital_point_cluster.arr_weak_point.size * weakpoint_health;
    self.var_1fca27f31170a90d[ "phase_two" ] = vital_point_cluster.arr_weak_point.size * weakpoint_health;
    
    foreach ( weakpoint in vital_point_cluster.arr_weak_point )
    {
        weakpoint_tag = weakpoint_deck utility::deck_draw();
        
        if ( weakpoint_tag == "tag_weakpoint_7" )
        {
            link_weakpoint( weakpoint, weakpoint_tag, 1 );
            continue;
        }
        
        link_weakpoint( weakpoint, weakpoint_tag );
    }
    
    self.var_7946223663a6d48a = self.total_weak_points;
    self.health += 3 * boss_health;
    self.var_1fca27f31170a90d[ "phase_three" ] = 3 * boss_health;
    self.maxhealth = self.health;
}

// Namespace mars
// Params 3
// Checksum 0xbe454cb, Offset: 0x857
// Size: 0x111
function link_weakpoint( weakpoint, weakpoint_tag, do_offset = 0 )
{
    offset = ( 0, 0, 0 );
    
    if ( do_offset )
    {
        angles = vectortoangles( level.mars_ai.stalk gettagorigin( weakpoint_tag ) - level.mars_ai.stalk gettagorigin( "j_spinelower" ) );
        offset = 16 * anglestoforward( angles );
    }
    
    weakpoint.origin = level.mars_ai.stalk gettagorigin( weakpoint_tag ) + offset;
    weakpoint.angles = level.mars_ai.stalk gettagangles( weakpoint_tag );
    weakpoint enablelinkto();
    weakpoint linktomoveoffset( level.mars_ai.stalk, weakpoint_tag, offset, ( 0, 0, 0 ) );
}

// Namespace mars
// Params 0
// Checksum 0xf1d250b6, Offset: 0x970
// Size: 0x182
function function_8596f7e6758b6253()
{
    self.var_56e03db0739a3b35 = self.var_1d42ef2fdb0dbb1a[ "phase_one" ];
    self.phase_total_health = self.var_1fca27f31170a90d[ "phase_one" ];
    self.var_fc1aa1a5ea6eeff8 = self.var_1fca27f31170a90d[ "phase_two" ] + self.var_1fca27f31170a90d[ "phase_three" ];
    self.var_880bf9492790112 = self.var_4b5ba7899abdcee6[ "phase_one" ];
    self.var_f90c07a64fd1b2a1 = self.var_4b5ba7899abdcee6[ "phase_two" ] + self.var_4b5ba7899abdcee6[ "phase_three" ];
    self notify( #"notify_phase_start" );
    level utility::flag_wait_or_timeout( "flag_mars_first_dragon_breath", 20 );
    wait randomfloatrange( 2, 4 );
    
    foreach ( weak_point in self.var_56e03db0739a3b35.arr_weak_point )
    {
        thread function_650d8e35b59ed2c8( weak_point );
        weak_point thread weak_point::set_state( "opening", randomfloat( 4 ) );
    }
    
    self.var_56e03db0739a3b35 thread function_a4f2acd26d6cde7c( "aries_boss_phaseone_complete" );
    wait 4;
    level.mars_ai.inactive_state = 0;
}

// Namespace mars
// Params 0
// Checksum 0x5228b58d, Offset: 0xafa
// Size: 0x162
function function_58511065e929f1f2()
{
    self.var_56e03db0739a3b35 = self.var_1d42ef2fdb0dbb1a[ "phase_two" ];
    self.phase_total_health = self.var_1fca27f31170a90d[ "phase_two" ];
    self.var_fc1aa1a5ea6eeff8 = self.var_1fca27f31170a90d[ "phase_three" ];
    self.var_880bf9492790112 = self.var_4b5ba7899abdcee6[ "phase_two" ];
    self.var_f90c07a64fd1b2a1 = self.var_4b5ba7899abdcee6[ "phase_three" ];
    self notify( #"notify_phase_start" );
    level utility::flag_wait_or_timeout( "flag_mars_first_homing_projectile", 20 );
    wait randomfloatrange( 2, 4 );
    
    foreach ( weak_point in self.var_56e03db0739a3b35.arr_weak_point )
    {
        thread function_650d8e35b59ed2c8( weak_point );
        weak_point thread weak_point::set_state( "opening", randomfloat( 4 ) );
    }
    
    self.var_56e03db0739a3b35 thread function_a4f2acd26d6cde7c( "aries_boss_phasetwo_complete" );
    wait 4;
    level.mars_ai.inactive_state = 0;
}

// Namespace mars
// Params 1
// Checksum 0x8283192d, Offset: 0xc64
// Size: 0x99
function function_650d8e35b59ed2c8( weak_point )
{
    weak_point waittill( #"hash_17875999f2e2c3f" );
    weak_point_health = weak_point.health;
    
    while ( weak_point_health >= 0 )
    {
        weak_point utility::waittill_any( "notify_weak_point_damaged", "weak_point_destroyed" );
        mars_ref = level.mars_ai;
        
        if ( weak_point_health <= 0 )
        {
            mars_ref notify( #"weak_point_destroyed" );
            
            if ( !utility::flag( "flag_mars_weak_point_destroyed" ) )
            {
                utility::flag_set( "flag_mars_weak_point_destroyed" );
            }
        }
        
        mars_ref healthbar_update();
    }
}

// Namespace mars
// Params 1
// Checksum 0x37f8e4b5, Offset: 0xd05
// Size: 0x38
function weakpoint_callback( eattacker )
{
    if ( self.cluster.var_9f0a469e77d5227c > 0 )
    {
        self.cluster notify( #"all_weak_points_in_cluster_destroyed" );
    }
}

// Namespace mars
// Params 3
// Checksum 0x62f16a9d, Offset: 0xd45
// Size: 0xda
function function_667409c1c0a3e67c( damage_amount, weapon_object, var_b3cbd266eebbbb50 )
{
    switch ( weapon_object.classname )
    {
        case #"hash_8cdaf2e4ecfe5b51":
            return 25;
        case #"hash_900cb96c552c5e8e":
            return 15;
        case #"hash_fa24dff6bd60a12d":
            return 30;
        case #"hash_e224d0b635d0dadd":
            return 90;
        case #"hash_6191aaef9f922f96":
            return 100;
        case #"hash_690c0d6a821b42e":
            return 15;
        case #"hash_719417cb1de832b6":
            if ( var_b3cbd266eebbbb50 == "MOD_MELEE" )
            {
                return 500;
            }
            else
            {
                return 10;
            }
        case #"hash_61e969dacaaf9881":
            return 500;
        case #"hash_ceb3b5150f04b677":
            return 45;
        default:
            return damage_amount;
    }
}

// Namespace mars
// Params 0
// Checksum 0xb5961a1f, Offset: 0xe27
// Size: 0x9b
function function_7da2cbf0e84c6adf()
{
    foreach ( weak_point in self.var_56e03db0739a3b35.arr_weak_point )
    {
        if ( weak_point weak_point::get_state() != "inactive" )
        {
            weak_point weak_point::set_state( "dead" );
        }
    }
}

/#

    // Namespace mars
    // Params 0
    // Checksum 0x65450561, Offset: 0xeca
    // Size: 0x5, Type: dev
    function function_92832edc3452d519()
    {
        
    }

#/

// Namespace mars
// Params 0
// Checksum 0x20d7aae6, Offset: 0xed7
// Size: 0x1f
function healthbar_setup()
{
    level callback::add( #"player_spawned", &function_4a8bc5bb2b3bac58 );
    function_436a757980a8361a();
}

// Namespace mars
// Params 0
// Checksum 0x65dfdfc9, Offset: 0xefe
// Size: 0x9c
function function_436a757980a8361a()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.var_71c37977095602df ) )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_mars", self );
            player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        }
    }
}

// Namespace mars
// Params 0
// Checksum 0x9e02affa, Offset: 0xfa2
// Size: 0x3cf
function healthbar_update()
{
    function_436a757980a8361a();
    weakpoint_health = level.is_squad_size_small ? int( 562 ) : int( 1125 );
    var_43be5ac5a6bb28fe = level.is_squad_size_small ? int( 900 ) : int( 1800 );
    
    if ( isdefined( self.phase ) )
    {
        switch ( self.phase )
        {
            case 1:
                self.health = var_43be5ac5a6bb28fe * 3 + 4 * weakpoint_health;
                
                foreach ( weak_point in self.var_56e03db0739a3b35.arr_weak_point )
                {
                    self.health += max( 0, weak_point.health );
                }
                
                break;
            case 2:
                self.health = var_43be5ac5a6bb28fe * 3;
                
                foreach ( weak_point in self.var_56e03db0739a3b35.arr_weak_point )
                {
                    self.health += max( 0, weak_point.health );
                }
                
                break;
            default:
                var_eb89d5288c31b9e7 = 0;
                
                foreach ( head in self.var_e03a976980256ff1 )
                {
                    var_eb89d5288c31b9e7 += head.var_cce7c67ea2da8902;
                }
                
                self.health = var_eb89d5288c31b9e7;
                break;
        }
    }
    
    self.health -= self.var_1e0c729a105495d0;
    function_60864d55b669b2a6();
    
    if ( self.health < 200 && !utility::flag( "FLAG_MARS_DYING" ) )
    {
        utility::flag_set( "FLAG_MARS_DYING" );
    }
    
    if ( self.health > 0 )
    {
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
}

// Namespace mars
// Params 1
// Checksum 0xf9bf81ac, Offset: 0x1379
// Size: 0x107
function function_f6098d122e2499e3( var_df00f5fbf4a6d195 )
{
    if ( var_df00f5fbf4a6d195 )
    {
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace mars
// Params 0
// Checksum 0x7a53462a, Offset: 0x1488
// Size: 0x13b
function function_60864d55b669b2a6()
{
    if ( self.health <= self.health_threshold )
    {
        self.health = self.health_threshold;
        
        if ( self.phase == 1 || self.phase == 2 )
        {
            function_7da2cbf0e84c6adf();
            self.var_56e03db0739a3b35 notify( #"all_weak_points_in_cluster_destroyed" );
            return;
        }
        
        foreach ( head in level.mars_ai.var_e03a976980256ff1 )
        {
            if ( head getscriptablehaspart( "phase" ) && head getscriptablepartstate( "phase" ) != "dead" )
            {
                head notify( #"fake_death" );
                head aries_boss::function_9f6815fb4ef00ed6( undefined );
            }
        }
        
        level.mars_ai notify( #"death" );
        utility::flag_set( "aries_boss_phasethree_complete" );
    }
}

// Namespace mars
// Params 1
// Checksum 0x675945eb, Offset: 0x15cb
// Size: 0x4f
function function_4a8bc5bb2b3bac58( params )
{
    self notify( #"hash_ea1516bf570ba6cc" );
    self endon( #"hash_ea1516bf570ba6cc" );
    
    if ( !self.var_71c37977095602df )
    {
        ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_mars", level.mars_ai );
        ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

/#

    // Namespace mars
    // Params 0
    // Checksum 0x86b8172d, Offset: 0x1622
    // Size: 0x5, Type: dev
    function function_74cd7ef1ea300de()
    {
        
    }

#/

// Namespace mars
// Params 1
// Checksum 0xc60f161d, Offset: 0x162f
// Size: 0xdc
function function_a4f2acd26d6cde7c( var_14edd12998ee8ae6 )
{
    level endon( var_14edd12998ee8ae6 );
    weak_point_deck = utility::create_deck( self.arr_weak_point );
    
    while ( weak_point_deck.index < weak_point_deck.items.size )
    {
        wait 60;
        
        do
        {
            weak_point = weak_point_deck utility::deck_draw();
            weak_point_state = weak_point weak_point::get_state();
        }
        while ( weak_point_state == "inactive" && weak_point_deck.cycle < 1 );
        
        if ( weak_point_deck.cycle >= 1 )
        {
            break;
        }
        
        weak_point thread function_224f566d4fe5f6b1( 40, "weak_point_destroyed" );
        weak_point waittill( #"weak_point_destroyed" );
        
        if ( !utility::flag( "flag_mars_first_weakpoint_destroyed" ) )
        {
            level utility::flag_set( "flag_mars_first_weakpoint_destroyed" );
        }
    }
}

// Namespace mars
// Params 0
// Checksum 0xa43638b7, Offset: 0x1713
// Size: 0xcb
function function_11c81406e9fe90e4()
{
    level.mars_ai endon( #"death" );
    result = level.mars_ai utility::waittill_notify_or_timeout_return( "notify_mars_head_damaged", 60 );
    
    if ( result == "timeout" )
    {
        foreach ( head in level.mars_ai.var_e03a976980256ff1 )
        {
            head thread function_d8b6e51cc83a398c( 100, "fake_death" );
        }
    }
}

// Namespace mars
// Params 2
// Checksum 0x7279aea4, Offset: 0x17e6
// Size: 0x66
function function_d8b6e51cc83a398c( z_offset, death_notify )
{
    position = self gettagorigin( "tag_spawn_location" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( position, z_offset, level.players );
    utility::waittill_any_ents( self, death_notify );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
    {
        ob_story_mission_utils::objective_marker_clear( obj_id );
    }
}

// Namespace mars
// Params 3
// Checksum 0xb0cffc2d, Offset: 0x1854
// Size: 0x9c
function function_224f566d4fe5f6b1( z_offset, death_notify, tag_name )
{
    forward = anglestoup( self.angles );
    position = isdefined( tag_name ) ? self gettagorigin( tag_name ) : self.origin;
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( position + forward * 75, z_offset, level.players );
    utility::waittill_any_ents( self, death_notify, self.cluster, "all_weak_points_in_cluster_destroyed" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

/#

    // Namespace mars
    // Params 0
    // Checksum 0x5e73df05, Offset: 0x18f8
    // Size: 0x5, Type: dev
    function function_90dcac6256af38b6()
    {
        
    }

#/

// Namespace mars
// Params 4
// Checksum 0xe4b14684, Offset: 0x1905
// Size: 0x133, Type: bool
function environment_trace( var_b171067dd5489f35, target_tag_list, ignore_list, var_39e71bba4254dc31 )
{
    if ( var_b171067dd5489f35.sessionstate == "spectator" )
    {
        return false;
    }
    
    var_62ddc858cee09ea = physics_createcontents( [ "physicscontents_clipshot" ] );
    
    if ( isdefined( var_39e71bba4254dc31 ) && utility::hastag( self.model, var_39e71bba4254dc31 ) )
    {
        start_pos = self gettagorigin( var_39e71bba4254dc31 );
    }
    else
    {
        start_pos = self.origin;
    }
    
    foreach ( tag_name in target_tag_list )
    {
        end_pos = var_b171067dd5489f35 gettagorigin( tag_name );
        
        /#
        #/
        
        hit = physics_raycast( start_pos, end_pos, var_62ddc858cee09ea, ignore_list, 0, "physicsquery_any" );
        
        if ( !hit )
        {
            /#
            #/
            
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace mars
    // Params 0
    // Checksum 0xd8f4003d, Offset: 0x1a41
    // Size: 0x5, Type: dev
    function function_b5f8149395dde12a()
    {
        
    }

#/

// Namespace mars
// Params 0
// Checksum 0xd5991db6, Offset: 0x1a4e
// Size: 0x9b
function function_bf4982196464ad90()
{
    while ( true )
    {
        utility::waittill_any_ents_return( self.var_e03a976980256ff1[ 0 ], "fake_death", self.var_e03a976980256ff1[ 1 ], "fake_death", self.var_e03a976980256ff1[ 2 ], "fake_death" );
        level utility::flag_set( "flag_mars_one_head_killed" );
        
        if ( self.remaining_heads <= 1 )
        {
            level utility::flag_set( "flag_mars_heads_destroyed" );
        }
        
        if ( self.remaining_heads <= 0 )
        {
            function_f6098d122e2499e3( 1 );
            self notify( #"death" );
            utility::flag_set( "aries_boss_phasethree_complete" );
        }
    }
}

// Namespace mars
// Params 3
// Checksum 0x51463e1, Offset: 0x1af1
// Size: 0x134
function phase_transition_notify( notify_entity, start_notify, end_notify )
{
    notify_entity waittill( start_notify );
    
    foreach ( e_player in level.players )
    {
        e_player playsoundtoplayer( "evt_aries_boss_phase_scream_intro", e_player );
        e_player thread earthquake_follow_player( 2.5 );
        e_player playrumbleonentity( "artillery_rumble_heavy" );
    }
    
    notify_entity waittill( end_notify );
    
    foreach ( e_player in level.players )
    {
        e_player stoprumble( "artillery_rumble_heavy" );
    }
}

// Namespace mars
// Params 1
// Checksum 0x5388d4, Offset: 0x1c2d
// Size: 0x80
function earthquake_follow_player( duration )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    time = 0;
    time_intervals = 0.1;
    intensity = 0.35;
    
    while ( time < duration && isalive( self ) )
    {
        self earthquakeforplayer( intensity, duration, self.origin, 500 );
        time += time_intervals;
        wait time_intervals;
    }
}

