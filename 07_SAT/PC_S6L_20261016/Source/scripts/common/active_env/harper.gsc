// scripts\common\active_env\harper.gsc  (hash_75293ba9eaed0e75.gscc) (size: 9350 Bytes / 0x2486 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e58490a (1851279626)
// size ...... 9350 (0x2486)
// includes .. 8   (offset: 0x2126)
// strings ... 55  (offset: 0x2166)
// dev strs .. 1   (offset: 0x247a)
// exports ... 17  (offset: 0x15fa)
// cseg ...... 0x454 + 0x11a6 (0x15fa)
// imports ... 71  (offset: 0x18a2)
// animtree1 . 0   (offset: 0x2486)
// animtree2 . 0   (offset: 0x2486)
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;

#namespace harper;

// Namespace harper
// Params 3
// Checksum 0x1ee3ae51, Offset: 0x472
// Size: 0x99
function harper_init( var_2412645f35acaf72 = 0, var_9641700bdec6d936 = 0, b_randomize_sequence = 0 )
{
    level._effect[ "harper_impact" ] = loadfxasset( "vfx_sat_wc_vgo_crr_boss_dmg_impact_01" );
    level._effect[ "harper_slam" ] = loadfxasset( "vfx_sat_wc_vgo_boss_hand_aoe_ring_01" );
    s_harper_scene = utility::getstruct( "scene_harper_boss", "targetname" );
    s_harper_scene thread harper_controller( var_9641700bdec6d936, b_randomize_sequence );
    s_harper_scene setup_harper( var_2412645f35acaf72 );
}

// Namespace harper
// Params 1, eflags: 0x4
// Checksum 0x7632af45, Offset: 0x513
// Size: 0xa2
function private setup_harper( var_b2b00cec8b23fbd8 )
{
    level endon( #"game_ended" );
    level utility::registersharedfunc( "hellstorm_missile", #"directionoverride", &function_6b8c078a7b861b4, 1 );
    level.harper = scene::get_entity( "harper_boss" );
    scene::set_notify_note( level, "slam_right", "Types_Prop", 1 );
    scene::set_notify_note( level, "slam_left", "Types_Prop", 1 );
    
    if ( var_b2b00cec8b23fbd8 )
    {
        thread function_7ec3d3be60a69589();
        level thread harper_damage_listener();
        level utility::flag_set( "flag_allow_harper_damage" );
        level.harper thread harper_damage_setup();
    }
}

// Namespace harper
// Params 2, eflags: 0x4
// Checksum 0xbad571a3, Offset: 0x5bd
// Size: 0x2cd
function private harper_controller( b_do_damage, b_randomize_sequence )
{
    level endon( #"game_ended" );
    var_d1e229c5b9da26b8[ "enter" ] = "enter_normal";
    var_d1e229c5b9da26b8[ "intro" ] = "intro_roar";
    var_d1e229c5b9da26b8[ "idle" ] = "idle_normal";
    var_d1e229c5b9da26b8[ "yell" ] = "attack_yell";
    var_d1e229c5b9da26b8[ "cradle" ] = "attack_cradle";
    var_d1e229c5b9da26b8[ "slam_left" ] = "palm_slam_left";
    var_d1e229c5b9da26b8[ "slam_right" ] = "palm_slam_right";
    var_d1e229c5b9da26b8[ "death" ] = "death";
    s_harper = spawnstruct();
    s_harper.s_scene = self;
    s_harper.s_action_queue = utility::queue_create();
    s_harper.s_slam_left = utility::getstruct( "struct_boss_palm_strike_left", "targetname" );
    s_harper.s_slam_right = utility::getstruct( "struct_boss_palm_strike_right", "targetname" );
    
    if ( !b_randomize_sequence )
    {
        var_9249fbc19dfbfa94 = [ "idle", "slam_left", "idle", "slam_right", "idle", "cradle" ];
    }
    else
    {
        var_9249fbc19dfbfa94 = function_958fbae7245d445c( [ "slam_left", "slam_right", "yell" ], "death" );
    }
    
    s_harper.s_action_queue = utility::queue_create( 10 );
    utility::queue_enqueue( s_harper.s_action_queue, "enter" );
    
    while ( true )
    {
        if ( utility::queue_isempty( s_harper.s_action_queue ) )
        {
            foreach ( var_10d0ec8539ca87f8 in var_9249fbc19dfbfa94 )
            {
                utility::queue_enqueue( s_harper.s_action_queue, var_10d0ec8539ca87f8 );
            }
        }
        
        var_10d0ec8539ca87f8 = utility::queue_peek( s_harper.s_action_queue );
        utility::queue_dequeue( s_harper.s_action_queue );
        
        switch ( var_10d0ec8539ca87f8 )
        {
            case #"hash_84a9418d3814303c":
                level thread slam_logic( undefined, s_harper.s_slam_left, b_do_damage );
                break;
            case #"hash_671d42da5e151609":
                level thread slam_logic( undefined, s_harper.s_slam_right, b_do_damage );
                break;
            default:
                break;
        }
        
        scene::play( self, var_d1e229c5b9da26b8[ var_10d0ec8539ca87f8 ] );
        
        if ( var_10d0ec8539ca87f8 == "death" )
        {
            return;
        }
    }
}

// Namespace harper
// Params 2, eflags: 0x4
// Checksum 0xa252153e, Offset: 0x892
// Size: 0x78
function private function_958fbae7245d445c( var_715fac389954daf5, str_finisher )
{
    var_9249fbc19dfbfa94 = [];
    var_715fac389954daf5 = arrayrandomize( var_715fac389954daf5 );
    
    for ( i = 0; i < var_715fac389954daf5.size ; i++ )
    {
        if ( randomint( 100 ) > 25 )
        {
            var_9249fbc19dfbfa94[ var_9249fbc19dfbfa94.size ] = "idle";
        }
        
        var_9249fbc19dfbfa94[ var_9249fbc19dfbfa94.size ] = var_715fac389954daf5[ i ];
    }
    
    var_9249fbc19dfbfa94[ var_9249fbc19dfbfa94.size ] = "idle";
    var_9249fbc19dfbfa94[ var_9249fbc19dfbfa94.size ] = str_finisher;
    return var_9249fbc19dfbfa94;
}

// Namespace harper
// Params 0, eflags: 0x4
// Checksum 0x2a81ea62, Offset: 0x913
// Size: 0x374
function private harper_damage_setup()
{
    e_harper = self;
    level.var_501ade91cd412744 = getdvarint( @"hash_38ecac846c8aebd1", 250 );
    var_49ac41bdafeaac67 = 1.01;
    var_b32ad186eb48ace4 = 0.7;
    var_d4bfd468262c22fd = 0.6;
    var_366933b00f28f41a = 0.4;
    e_clip_chest = getent( "harper_clip_chest", #targetname );
    e_clip_chest linkto( e_harper, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_chest thread harper_damage_piece( var_b32ad186eb48ace4 );
    e_clip_head = getent( "harper_clip_head", #targetname );
    e_clip_head linkto( e_harper, "j_head", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_head thread harper_damage_piece( var_49ac41bdafeaac67 );
    e_clip_bicep_l = getent( "harper_clip_bicep_l", #targetname );
    e_clip_bicep_l linkto( e_harper, "j_shoulder_le", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_bicep_l thread harper_damage_piece( var_d4bfd468262c22fd );
    e_clip_bicep_r = getent( "harper_clip_bicep_r", #targetname );
    e_clip_bicep_r linkto( e_harper, "j_shoulder_ri", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_bicep_r thread harper_damage_piece( var_d4bfd468262c22fd );
    e_clip_forearm_l = getent( "harper_clip_forearm_l", #targetname );
    e_clip_forearm_l linkto( e_harper, "j_elbow_le", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_forearm_l thread harper_damage_piece( var_d4bfd468262c22fd );
    e_clip_forearm_r = getent( "harper_clip_forearm_r", #targetname );
    e_clip_forearm_r linkto( e_harper, "j_elbow_ri", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_forearm_r thread harper_damage_piece( var_d4bfd468262c22fd );
    e_clip_hand_l = getent( "harper_clip_hand_l", #targetname );
    e_clip_hand_l linkto( e_harper, "j_wrist_le", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_hand_l thread harper_damage_piece( var_366933b00f28f41a );
    e_clip_hand_r = getent( "harper_clip_hand_r", #targetname );
    e_clip_hand_r linkto( e_harper, "j_wrist_ri", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    e_clip_hand_r thread harper_damage_piece( var_366933b00f28f41a );
    e_clip_hip = getent( "harper_clip_hips", #targetname );
    
    if ( isdefined( e_clip_hip ) )
    {
        e_clip_hip linkto( e_harper, "j_mainroot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        e_clip_hip thread harper_damage_piece( var_b32ad186eb48ace4 );
    }
    
    level.harper_objective = utility::spawn_tag_origin( e_harper gettagorigin( "j_head" ), ( 0, 0, 0 ) );
    level.harper_objective linkto( e_harper, "j_head", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace harper
// Params 0, eflags: 0x4
// Checksum 0xe1f2b2a0, Offset: 0xc8f
// Size: 0xf1
function private function_7ec3d3be60a69589()
{
    n_boss_health = 120000;
    level.s_harper_health = {};
    level.s_harper_health.health = n_boss_health;
    level.s_harper_health.maxhealth = n_boss_health;
    level.s_harper_health zombie_boss_healthbar::function_f50a10314e72caa1();
    level.s_harper_health zombie_boss_healthbar::init_zombie_boss_healthbar();
    wait 10;
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( "ob_boss_harper", level.s_harper_health );
    }
}

// Namespace harper
// Params 1, eflags: 0x4
// Checksum 0x9142896a, Offset: 0xd88
// Size: 0x172
function private harper_damage_piece( multiplier = 1 )
{
    level endon( #"game_ended" );
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, e_attacker, direction, point, type, model, tag, part, idflags, objweapon );
        
        if ( isplayer( e_attacker ) )
        {
            if ( level utility::flag( "flag_allow_harper_damage" ) )
            {
                n_damage *= 8;
                n_damage = multiplier * n_damage;
                n_damage = clamp( n_damage, 100, 1200 );
                level notify( #"harper_damaged", n_damage );
                
                if ( isdefined( point ) )
                {
                    playfx( level._effect[ "harper_impact" ], point );
                }
                
                if ( multiplier > 1 )
                {
                    e_attacker damagefeedback::updatehitmarker( 1, 0, 1, 0, undefined, undefined, undefined, undefined, 1 );
                }
                else
                {
                    e_attacker damagefeedback::updatehitmarker( 1, 0, 0, 0, undefined, undefined, undefined, undefined, 1 );
                }
                
                e_attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
                continue;
            }
            
            e_attacker damagefeedback::updatedamagefeedback( "hitimmune", 0, 0 );
            n_current_time = gettime();
        }
    }
}

// Namespace harper
// Params 0, eflags: 0x4
// Checksum 0xa5d12eaa, Offset: 0xf02
// Size: 0xb4
function private harper_damage_listener()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"harper_damaged", var_4e00ee8d01ee7fa3 );
        
        if ( level utility::flag( "flag_stun_harper" ) )
        {
            n_dmg_multiplier = 1.05;
        }
        else
        {
            n_dmg_multiplier = 1;
        }
        
        if ( level utility::flag( "flag_allow_harper_damage" ) )
        {
            var_2b5cab6ff30eee0d = var_4e00ee8d01ee7fa3 * n_dmg_multiplier;
            level.s_harper_health.health -= var_2b5cab6ff30eee0d;
            level callback::callback( "on_boss_progress_updated", level.s_harper_health );
        }
    }
}

/#

    // Namespace harper
    // Params 0
    // Checksum 0x7e78402c, Offset: 0xfbe
    // Size: 0x5, Type: dev
    function function_c01b83b96e2eb6df()
    {
        
    }

#/

// Namespace harper
// Params 3, eflags: 0x4
// Checksum 0x7ee08a4c, Offset: 0xfcb
// Size: 0x51
function private slam_logic( stop_flag, struct, b_do_damage )
{
    level endon( #"game_ended" );
    level utility::waittill_any( "slam_right", "slam_left" );
    level thread slam_shockwave( struct.origin, b_do_damage );
}

// Namespace harper
// Params 2, eflags: 0x4
// Checksum 0xde0933a9, Offset: 0x1024
// Size: 0x32e
function private slam_shockwave( var_d5d5f4b63ba0b950, b_do_damage )
{
    level endon( #"game_ended" );
    n_current_radius = 0;
    earthquake( 0.7, 0.3, var_d5d5f4b63ba0b950, 4000 );
    level thread function_619612726bb47e08( var_d5d5f4b63ba0b950, 4000, 1800 );
    
    if ( !b_do_damage )
    {
        return;
    }
    
    playfx( level._effect[ "harper_slam" ], var_d5d5f4b63ba0b950 );
    
    while ( true )
    {
        n_max_radius = 4000;
        
        /#
            n_max_radius = getdvarfloat( @"hash_eb0728328b9612a0", 4000 );
        #/
        
        n_travel_speed = 1800;
        
        /#
            n_travel_speed = getdvarfloat( @"hash_9ae12f01fd46d8a0", 1800 );
        #/
        
        var_26270ba2437f5697 = n_current_radius;
        n_current_radius += n_travel_speed * level.framedurationseconds;
        
        /#
            if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
            {
                cylinder( var_d5d5f4b63ba0b950, var_d5d5f4b63ba0b950 + ( 0, 0, 10 ), n_current_radius, ( 1, 1, 0 ), 1, 1 );
            }
        #/
        
        n_player_radius = 16;
        
        /#
            n_player_radius = getdvarfloat( @"hash_bb65ec1ec6eb3ceb", 16 );
        #/
        
        foreach ( e_player in level.players )
        {
            if ( player::isreallyalive( e_player ) && e_player.sessionstate == "playing" )
            {
                if ( !e_player function_dd48b56c28acb2e3( n_player_radius, var_d5d5f4b63ba0b950, var_26270ba2437f5697, n_current_radius ) )
                {
                    continue;
                }
                
                if ( e_player.isstunned )
                {
                    continue;
                }
                
                if ( e_player isonground() )
                {
                    /#
                        if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
                        {
                            cylinder( e_player.origin, e_player.origin + ( 0, 0, 2 ), n_player_radius, ( 1, 0, 0 ), 0, 400 );
                            var_ac26e3818b7168a8 = vectornormalize2( e_player.origin - var_d5d5f4b63ba0b950 );
                            var_d791d1e26b912fad = ( var_d5d5f4b63ba0b950[ 0 ], var_d5d5f4b63ba0b950[ 1 ], e_player.origin[ 2 ] );
                            var_4d5d4e179e2ae0ad = var_d791d1e26b912fad + var_ac26e3818b7168a8 * var_26270ba2437f5697;
                            var_3055b5bbc6767dbe = var_d791d1e26b912fad + var_ac26e3818b7168a8 * n_current_radius;
                            line( var_4d5d4e179e2ae0ad, var_3055b5bbc6767dbe, ( 1, 0, 0 ), 1, 0, 400 );
                        }
                    #/
                    
                    var_27e3bb332e5e12dc = 2;
                    e_player utility::setplayerstunned();
                    
                    /#
                        iprintlnbold( "<dev string:x24>" );
                    #/
                    
                    e_player dodamage( 30, var_d5d5f4b63ba0b950, e_player );
                    e_player thread weapon_utility::cleanupconcussionstun( var_27e3bb332e5e12dc );
                    e_player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_slam", #"stun", var_27e3bb332e5e12dc, 1, 1500 );
                    e_player playrumbleonentity( "damage_heavy" );
                }
            }
        }
        
        if ( n_current_radius > n_max_radius )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace harper
// Params 3
// Checksum 0x6a45ff12, Offset: 0x135a
// Size: 0x181
function function_619612726bb47e08( originpoint, max_radius, max_speed )
{
    /#
        max_radius = getdvarfloat( @"hash_eb0728328b9612a0", max_radius );
    #/
    
    var_ccf9a72ba0ac0132 = max_speed;
    
    /#
        var_ccf9a72ba0ac0132 = getdvarfloat( @"hash_9ae12f01fd46d8a0", max_speed );
    #/
    
    foreach ( e_player in level.players )
    {
        if ( player::isreallyalive( e_player ) && e_player.sessionstate == "playing" )
        {
            player_distance = distance( originpoint, e_player.origin );
            v_dir_to_player = vectornormalize( e_player.origin - originpoint );
            sound_ent = spawn( "script_model", originpoint );
            sound_ent setmodel( "tag_origin" );
            e_player playsoundtoplayer( "evt_harper_giant_hand_deck_smash_shockwave_wall", e_player, sound_ent );
            v_end_point = originpoint + v_dir_to_player * max_radius;
            n_travel_time = max_radius / var_ccf9a72ba0ac0132;
            sound_ent moveto( v_end_point, n_travel_time );
            sound_ent thread delete_after_move( n_travel_time + 0.5 );
        }
    }
}

// Namespace harper
// Params 1
// Checksum 0x1bd072a6, Offset: 0x14e3
// Size: 0x2d
function delete_after_move( n_time_s )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait n_time_s;
    self delete();
}

// Namespace harper
// Params 4, eflags: 0x4
// Checksum 0x838ae13f, Offset: 0x1518
// Size: 0x78, Type: bool
function private function_dd48b56c28acb2e3( ent_radius, wave_center, var_71054ba8718cc78b, var_687e4f51197b1bdb )
{
    e_ent = self;
    var_b3f50ca949e18afc = distance2d( e_ent.origin, wave_center );
    var_4078e7c6d3244210 = var_b3f50ca949e18afc - ent_radius;
    var_4055ddc6d2fde45a = var_b3f50ca949e18afc + ent_radius;
    return !( var_687e4f51197b1bdb < var_4078e7c6d3244210 || var_71054ba8718cc78b > var_4055ddc6d2fde45a );
}

/#

    // Namespace harper
    // Params 0
    // Checksum 0xf0bae0fe, Offset: 0x1599
    // Size: 0x5, Type: dev
    function function_23bb3f772b92ac73()
    {
        
    }

#/

// Namespace harper
// Params 0, eflags: 0x4
// Checksum 0x56ac5912, Offset: 0x15a6
// Size: 0x53
function private function_6b8c078a7b861b4()
{
    s_struct_1 = utility::getstruct( "struct_boss_palm_strike_right", "targetname" );
    s_struct_2 = utility::getstruct( "carrier_airdrop_2", "targetname" );
    return vectornormalize( s_struct_1.origin - s_struct_2.origin );
}

