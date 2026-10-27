// scripts\common\ai\aitypes\aries_boss\aries_boss.gsc  (hash_6c7fb6f99395d552.gscc) (size: 23127 Bytes / 0x5a57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fdb05db (2413495771)
// size ...... 23127 (0x5a57)
// includes .. 15  (offset: 0x53e7)
// strings ... 81  (offset: 0x545f)
// dev strs .. 20  (offset: 0x5967)
// exports ... 54  (offset: 0x381b)
// cseg ...... 0x6af + 0x316c (0x381b)
// imports ... 152 (offset: 0x408b)
// animtree1 . 0   (offset: 0x5a57)
// animtree2 . 0   (offset: 0x5a57)
#using script_636bd827a012af12;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\snd\snd;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss;
#using scripts\mp\mp_agent_damage;

#namespace aries_boss;

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0x1768a793, Offset: 0x6cd
    // Size: 0x5, Type: dev
    function function_ef03a666b83ea204()
    {
        
    }

#/

// Namespace aries_boss
// Params 2
// Checksum 0x8dd61518, Offset: 0x6da
// Size: 0x2e
function precache( classname, aitypescriptbundle )
{
    level._effect[ "mars_projectile_explosion" ] = loadfxasset( "vfx_sat_mp_ob_ari_boss_orb_impact_1" );
}

// Namespace aries_boss
// Params 1
// Checksum 0x8ef77396, Offset: 0x710
// Size: 0xea
function function_3ee8405e0d6b0de8( taskid )
{
    profilestart();
    callback::add( #"on_ai_damaged", &function_e28c6c48eab919a6 );
    callback::add( #"on_ai_killed", &function_9f6815fb4ef00ed6 );
    scriptable::scriptable_adddamagedcallback( &projectile_damage_callback );
    thread body_setup();
    self.juggcontext = { #var_fb68c148d6ef3479:1 };
    self.ignore_list = [ self ];
    self.var_c127d6dcc18f3fe5 = [];
    self.phase = 1;
    thread function_8f5f99c32e041d35();
    self.head_enabled = 1;
    self.noragdoll = 1;
    self.nocorpse = 1;
    self.team = "neutral";
    self.var_bcf7c6160f060ce4 = gettime() + int( utility::function_4b74c15943231980( 3 ) );
    self function_786bb6aa1b76c7ee( "mars_init_complete", 1 );
    profilestop();
    return anim.success;
}

// Namespace aries_boss
// Params 0
// Checksum 0x79420615, Offset: 0x804
// Size: 0xd2
function body_setup()
{
    self waittill( #"linked_to_tag_origin" );
    self.original_angles = self.angles;
    self.var_2cb4615f702ac36c = self gettagorigin( "tag_spawn_location" );
    dragons_breath_angles = self gettagangles( "tag_spawn_location" );
    trigger_box_size = ( 175, 1250, 175 );
    self.dragons_breath_trigger = spawn( "trigger_box", self.var_2cb4615f702ac36c, 0, trigger_box_size, trigger_box_size );
    self.dragons_breath_trigger.angles = dragons_breath_angles;
    self.dragons_breath_trigger enablelinkto();
    self.dragons_breath_trigger linkto( self, "tag_spawn_location", ( 1250, 0, 0 ), ( 0, 90, 0 ) );
}

// Namespace aries_boss
// Params 0
// Checksum 0x1183ce01, Offset: 0x8de
// Size: 0x16a
function function_8f5f99c32e041d35()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            within_range = is_within_range( player.origin );
            var_4b6fe86760ff0a11 = player::function_ab853a75bb4247a9( player );
            
            /#
                if ( getdvarint( @"hash_dade3190d513e73c", 0 ) == 1 )
                {
                    debug_current_state();
                }
                
                if ( getdvarint( @"hash_411da6744f3b2499", 0 ) == 1 )
                {
                    debug_draw_attack_range( player.origin );
                }
            #/
            
            if ( !within_range || var_4b6fe86760ff0a11 )
            {
                if ( arraycontains( self.var_c127d6dcc18f3fe5, player ) )
                {
                    self.var_c127d6dcc18f3fe5 = arrayremove( self.var_c127d6dcc18f3fe5, player );
                }
                
                continue;
            }
            
            if ( !arraycontains( self.var_c127d6dcc18f3fe5, player ) )
            {
                self.var_c127d6dcc18f3fe5[ self.var_c127d6dcc18f3fe5.size ] = player;
            }
        }
        
        waitframe();
    }
}

// Namespace aries_boss
// Params 2
// Checksum 0x2d8b6f21, Offset: 0xa50
// Size: 0xbe
function is_within_range( target_pos, radius )
{
    forward_vec = vectornormalize( anglestoup( self.original_angles ) );
    pos_vec = vectornormalize( ( target_pos[ 0 ], target_pos[ 1 ], self.origin[ 2 ] ) - self.origin );
    var_d8d09d30e3724c59 = vectordot( forward_vec, pos_vec );
    angle = acos( var_d8d09d30e3724c59 );
    within_angle = angle < 60 || angle > 300;
    
    if ( isdefined( radius ) )
    {
        if ( distancesquared( target_pos, self.origin ) <= radius && within_angle )
        {
            return 1;
        }
    }
    
    return within_angle;
}

// Namespace aries_boss
// Params 1
// Checksum 0xf2dd9d2c, Offset: 0xb17
// Size: 0x4d
function set_phase( phase_number )
{
    self.phase = phase_number;
    
    if ( phase_number == 3 )
    {
        self setscriptablepartstate( "phase", "final" );
        metabone::set_metabone_state( "head", "destroyed" );
        metabone::set_metabone_active( "head", 0 );
    }
}

// Namespace aries_boss
// Params 0
// Checksum 0xe9fcdf09, Offset: 0xb6c
// Size: 0x59
function function_6556a3d9c5cf260e()
{
    if ( self getscriptablepartstate( "phase" ) == "dead" )
    {
        return 5;
    }
    
    if ( self getaiblackboarddynamic( "in_inactive" ) )
    {
        return 4;
    }
    
    if ( self getaiblackboarddynamic( "in_pain" ) )
    {
        return 3;
    }
    
    if ( self getaiblackboarddynamic( "in_projectile" ) )
    {
        return 2;
    }
    
    if ( self getaiblackboarddynamic( "in_dragons_breath" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace aries_boss
// Params 1
// Checksum 0x11e42688, Offset: 0xbce
// Size: 0x122
function function_10287b60f902efb2( next_phase )
{
    self.head_enabled = 0;
    interrupt_behavior();
    self endon( #"interrupted" );
    self function_786bb6aa1b76c7ee( "in_inactive", 1 );
    
    switch ( next_phase )
    {
        case 0:
            return;
        case 2:
            self function_786bb6aa1b76c7ee( "inactive_exit_to_rage", 1 );
            utility::flag_wait( "flag_phasetwo_start" );
            self function_f2df0257c63f229( "in_inactive" );
            self.head_enabled = 1;
            break;
        case 3:
            self function_786bb6aa1b76c7ee( "inactive_exit_to_rage", 1 );
            utility::flag_wait( "flag_phasethree_start" );
            self function_f2df0257c63f229( "in_inactive" );
            self.head_enabled = 1;
            break;
        default:
            self function_f2df0257c63f229( "inactive_exit_to_rage" );
            thread function_5a8122034ea5bb74();
            
            if ( !utility::flag( "FLAG_MARS_HEADS_STUNNED" ) )
            {
                level utility::flag_set( "FLAG_MARS_HEADS_STUNNED" );
            }
            
            wait 10;
            self function_f2df0257c63f229( "in_inactive" );
            wait 15;
            self.head_enabled = 1;
            break;
    }
}

// Namespace aries_boss
// Params 0
// Checksum 0x12353c27, Offset: 0xcf8
// Size: 0x45
function function_5a8122034ea5bb74()
{
    self setscriptablepartstate( "phase", "normal" );
    self setscriptablepartstate( "inactive", "inactive" );
    wait 25;
    self setscriptablepartstate( "phase", "vulnerable" );
    self setscriptablepartstate( "inactive", "normal" );
}

// Namespace aries_boss
// Params 0
// Checksum 0xa2a4a1d3, Offset: 0xd45
// Size: 0x8d
function function_8c917487a8054e27()
{
    self endon( #"interrupted" );
    wait_time = randomfloat( 0.75 );
    wait wait_time;
    interrupt_behavior();
    self function_786bb6aa1b76c7ee( "in_pain", 1 );
    var_6acc7b81b5df3dd9 = asm::asm_getanim( self.asmname, "pain" );
    xanim = asm::asm_getxanim( "pain", var_6acc7b81b5df3dd9 );
    anim_length = getanimlength( xanim );
    wait anim_length;
    self function_f2df0257c63f229( "in_pain" );
}

// Namespace aries_boss
// Params 0
// Checksum 0x5fafb7a3, Offset: 0xdda
// Size: 0x80
function interrupt_behavior()
{
    current_state = function_6556a3d9c5cf260e();
    self function_786bb6aa1b76c7ee( "interrupted", 1 );
    self notify( #"interrupted" );
    self notify( #"dragons_breath_end" );
    self setscriptablepartstate( "attack", "idle" );
    self function_f2df0257c63f229( "in_projectile" );
    self function_f2df0257c63f229( "in_dragons_breath" );
    self function_f2df0257c63f229( "in_inactive" );
    self.head_enabled = 1;
    self function_f2df0257c63f229( "in_pain" );
}

// Namespace aries_boss
// Params 1
// Checksum 0x5f6e8042, Offset: 0xe62
// Size: 0xfb
function set_health_threshold( phase_number )
{
    level.mars_ai.phase = phase_number;
    weakpoint_health = level.is_squad_size_small ? 562 : 1125;
    boss_health = level.is_squad_size_small ? 900 : 1800;
    
    switch ( phase_number )
    {
        case 2:
            level.mars_ai.health_threshold = boss_health * 3;
            break;
        case 3:
            level.mars_ai.health_threshold = 0;
            break;
        default:
            level.mars_ai.health_threshold = boss_health * 3 + weakpoint_health * 4;
            break;
    }
    
    level.mars_ai.var_1e0c729a105495d0 = 0;
}

// Namespace aries_boss
// Params 0
// Checksum 0xa248e903, Offset: 0xf65
// Size: 0x8b
function function_db70a947f03fd561()
{
    self notify( #"hash_f87416fa1fc25f05" );
    self endon( #"hash_f87416fa1fc25f05" );
    level endon( #"game_ended" );
    mars_obj_marker = utility::getstruct( "str_mars_icon", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( mars_obj_marker.origin, undefined, undefined, "sat_ob_objectivemarker_boss", 0, 0, 0 );
    objective_state( obj_id, "active" );
    utility::flag_wait( "aries_boss_phasethree_complete" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    obj_id = undefined;
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0xb3db4abb, Offset: 0xff8
    // Size: 0x5, Type: dev
    function function_cfdd1dd67476a0b6()
    {
        
    }

#/

// Namespace aries_boss
// Params 1
// Checksum 0x4b6f2cb1, Offset: 0x1005
// Size: 0x91
function function_8743acd63045f816( taskid )
{
    if ( !self getaiblackboarddynamic( "mars_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_bcf7c6160f060ce4 )
    {
        return anim.failure;
    }
    
    if ( function_6556a3d9c5cf260e() != 0 )
    {
        return anim.failure;
    }
    
    if ( self.phase == 2 )
    {
        return anim.failure;
    }
    
    if ( !function_673087d280d9c565() )
    {
        return anim.failure;
    }
    
    thread dragons_breath_handler();
    return anim.success;
}

// Namespace aries_boss
// Params 1
// Checksum 0xd0aa03eb, Offset: 0x109f
// Size: 0xb8
function function_2ad7198477b65c3f( taskid )
{
    if ( !self getaiblackboarddynamic( "mars_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_bcf7c6160f060ce4 )
    {
        return anim.failure;
    }
    
    if ( function_6556a3d9c5cf260e() != 0 )
    {
        return anim.failure;
    }
    
    if ( self.phase == 1 )
    {
        return anim.failure;
    }
    
    if ( ( !isarray( self.var_c127d6dcc18f3fe5 ) || self.var_c127d6dcc18f3fe5.size <= 0 ) && self.phase != 3 )
    {
        return anim.failure;
    }
    
    thread homing_projectile_barrage();
    return anim.success;
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0x9803d351, Offset: 0x1160
    // Size: 0x5, Type: dev
    function function_75b22651b276eefa()
    {
        
    }

    // Namespace aries_boss
    // Params 0
    // Checksum 0xd6a176c9, Offset: 0x116d
    // Size: 0x5, Type: dev
    function function_1aaf6882c8bbee1d()
    {
        
    }

#/

// Namespace aries_boss
// Params 2
// Checksum 0x3522352f, Offset: 0x117a
// Size: 0xa1
function ranged_attack( amount, target_player )
{
    self endon( #"death" );
    self endon( #"interrupted" );
    level endon( #"game_ended" );
    
    if ( !isdefined( target_player ) )
    {
        target_player = utility::array_random( self.var_c127d6dcc18f3fe5 );
    }
    
    forward = anglestoforward( self.angles );
    
    if ( isdefined( self.origin ) )
    {
        for ( i = 0; i < amount ; i++ )
        {
            thread homing_projectile_handler( self.homing_projectiles[ i ], target_player );
        }
    }
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0x5e0130fb, Offset: 0x1223
    // Size: 0x5, Type: dev
    function function_801fa93f7e58e10()
    {
        
    }

#/

// Namespace aries_boss
// Params 0
// Checksum 0x9b41de64, Offset: 0x1230
// Size: 0x224
function homing_projectile_barrage()
{
    self endon( #"death" );
    self endon( #"interrupted" );
    level endon( #"game_ended" );
    self.active_projectiles = [];
    
    switch ( self.phase )
    {
        case 2:
            cooldown = 8;
            waittime = 4;
            
            if ( level.is_squad_size_small )
            {
                amount = 4;
            }
            else
            {
                amount = 6;
            }
            
            target_array = self.var_c127d6dcc18f3fe5;
            break;
        case 3:
            cooldown = function_6cf796194f513a9a();
            waittime = 1;
            
            if ( isarray( self.var_c127d6dcc18f3fe5 ) && self.var_c127d6dcc18f3fe5.size > 0 )
            {
                amount = function_e75124ffa201ec5b();
                target_array = self.var_c127d6dcc18f3fe5;
                self function_f2df0257c63f229( "projectile_up" );
            }
            else
            {
                amount = function_f27df2d01ad2570a();
                target_array = function_7734e172f8439510();
                self function_786bb6aa1b76c7ee( "projectile_up", 1 );
            }
            
            break;
        default:
            assertmsg( "<dev string:x24>" + self.phase );
            break;
    }
    
    self waittill( #"hash_d7fc50931463bb39" );
    
    foreach ( player in target_array )
    {
        if ( player::isaliveandnotinlaststand( player ) )
        {
            thread ranged_attack( amount, player );
        }
    }
    
    self waittill( #"projectile_end" );
    
    if ( !utility::flag( "flag_mars_first_homing_projectile" ) )
    {
        utility::flag_set( "flag_mars_first_homing_projectile" );
    }
    
    ai::set_blackboard_cooldown( "mars_time_between_attacks", int( utility::function_4b74c15943231980( waittime ) ) );
    ai::set_blackboard_cooldown( "mars_projectile_cooldown", int( utility::function_4b74c15943231980( cooldown ) ) );
    self function_f2df0257c63f229( "in_projectile" );
}

// Namespace aries_boss
// Params 2
// Checksum 0xb5a120c1, Offset: 0x145c
// Size: 0x199
function homing_projectile_handler( homing_projectile, target_player )
{
    var_8fa1597c801fa4e5 = self gettagorigin( "tag_spawn_location" );
    var_6c781c970ee7be3b = self gettagangles( "tag_spawn_location" );
    homing_projectile = spawn( "script_model", var_8fa1597c801fa4e5 );
    homing_projectile.angles = var_6c781c970ee7be3b;
    homing_projectile setmodel( "c_sat_aries_mars_boss_projectile" );
    homing_projectile setcandamage( 1 );
    homing_projectile.health = 50;
    self.ignore_list[ self.ignore_list.size ] = homing_projectile;
    target_direction = vectortoangles( target_player.origin - homing_projectile.origin );
    homing_projectile setcandamage( 1 );
    homing_projectile.lifetime = 0;
    homing_projectile.movement_speed = 50 + randomfloatrange( -10, 10 );
    
    if ( self getaiblackboarddynamic( "projectile_up" ) == 1 )
    {
        homing_projectile.turning_factor = 0.42;
    }
    else
    {
        homing_projectile.turning_factor = 0.6;
    }
    
    homing_projectile thread function_6294533bbd09c059( self );
    homing_projectile thread function_c2f9ad91613083af( target_player, var_6c781c970ee7be3b, self );
    homing_projectile utility::waittill_any_in_array_or_timeout( [ "destroyed", "death" ], 30 );
    playfx( level._effect[ "mars_projectile_explosion" ], homing_projectile.origin );
    homing_projectile delete();
    
    if ( isalive( self ) )
    {
        self.ignore_list = function_5713d46873b29625( self.ignore_list );
    }
}

// Namespace aries_boss
// Params 1
// Checksum 0xaa252794, Offset: 0x15fd
// Size: 0x147
function function_6294533bbd09c059( mars )
{
    self endon( #"death" );
    wait 0.5;
    var_62ddc858cee09ea = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_clipshot", "physicscontents_characterproxy" ] );
    var_fca64e6d43316fe8 = physics_createcontents( [ "physicscontents_characterproxy" ] );
    
    while ( true )
    {
        sphere_start_point = self.origin;
        sphere_end_point = sphere_start_point + anglestoforward( self.angles ) * 50;
        var_cf5ef9b4d334b298 = physics_spherecast( sphere_start_point, sphere_end_point, 15, var_62ddc858cee09ea, mars.ignore_list, "physicsquery_any" );
        var_140728395f8b50ce = physics_spherecast( sphere_start_point, sphere_end_point, 35, var_fca64e6d43316fe8, mars.ignore_list, "physicsquery_any" );
        
        if ( var_cf5ef9b4d334b298 || var_140728395f8b50ce )
        {
            if ( var_cf5ef9b4d334b298 )
            {
                snd::play( "evt_aries_boss_orb_impt", self.origin );
            }
            else
            {
                snd::play( "evt_aries_boss_orb_plr_impt", self.origin );
            }
            
            function_56b2a28ef5d790( mars, mars.ignore_list );
            self notify( #"destroyed" );
        }
        
        wait 0.1;
    }
}

// Namespace aries_boss
// Params 3
// Checksum 0x653eee5c, Offset: 0x174c
// Size: 0x6af
function function_c2f9ad91613083af( target_player, var_6c781c970ee7be3b, mars_entity )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"entity_deleted" );
    
    if ( !isdefined( target_player ) )
    {
        self notify( #"destroyed" );
        return;
    }
    
    var_d722011cf54d3d5b = self.origin;
    last_player_position = target_player geteye() - ( 0, 0, 25 );
    self.var_ea82abf596b826f8 = self.angles;
    
    if ( mars_entity getaiblackboarddynamic( "projectile_up" ) == 1 )
    {
        forward = anglestoforward( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 3.5, self.movement_speed * 4.5 );
        right = anglestoright( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.75, self.movement_speed * 1.5 ) * ( randomint( 2 ) * 2 - 1 );
        up = anglestoup( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.5, self.movement_speed * 1.5 ) * ( randomint( 2 ) * 2 - 1 );
    }
    else
    {
        forward = anglestoforward( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.5, self.movement_speed * 1.5 );
        right = anglestoright( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.75, self.movement_speed * 2.5 ) * ( randomint( 2 ) * 2 - 1 );
        up = anglestoup( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.5, self.movement_speed * 1.5 ) * ( randomint( 2 ) * 2 - 1 );
    }
    
    setup_end_position = self.origin + anglestoforward( var_6c781c970ee7be3b ) * self.movement_speed;
    
    /#
    #/
    
    setup_end_position = setup_end_position + forward + right + up;
    var_e77ffdbc91796c3e = 0;
    
    /#
    #/
    
    while ( self.lifetime < 1.3 )
    {
        if ( distancesquared( self.origin, setup_end_position ) < squared( 50 ) )
        {
            var_e77ffdbc91796c3e = 1;
        }
        
        if ( !var_e77ffdbc91796c3e )
        {
            var_267d01d2be2d145 = get_projectile_velocity( setup_end_position, self.turning_factor );
        }
        else
        {
            var_267d01d2be2d145 = anglestoforward( self.var_ea82abf596b826f8 ) * self.movement_speed;
        }
        
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = vectortoangles( new_pos - self.origin );
        
        /#
        #/
        
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        distance_to_point = distancesquared( self.origin, setup_end_position );
        
        if ( self.lifetime >= 0.52 && self.movement_speed > 15 )
        {
            self.movement_speed *= 0.65;
        }
        
        if ( self.lifetime >= 0.91 )
        {
            self setscriptablepartstate( "vfx", "active" );
        }
    }
    
    turn_time = self.lifetime + 0.5;
    self.turning_factor = 0.1;
    
    while ( self.lifetime < turn_time )
    {
        var_267d01d2be2d145 = anglestoforward( self.var_ea82abf596b826f8 ) * self.movement_speed * 0.5;
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = lerp_angles( last_player_position, self.turning_factor );
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        
        if ( player::isaliveandnotinlaststand( target_player ) )
        {
            if ( !isdefined( target_player ) )
            {
                self notify( #"destroyed" );
                return;
            }
            
            last_player_position = target_player geteye() - ( 0, 0, 25 );
        }
        
        if ( self.turning_factor < 0.6 )
        {
            self.turning_factor += 0.2;
        }
    }
    
    if ( mars_entity getaiblackboarddynamic( "projectile_up" ) == 1 )
    {
        self.turning_factor = 0.21;
    }
    else
    {
        self.turning_factor = 0.6;
    }
    
    acceleration_increment = 7;
    acceleration_intervals = 3;
    var_70ad3d2b67564946 = 4;
    acceleration_count = 0;
    
    while ( true )
    {
        if ( acceleration_count < acceleration_intervals )
        {
            self.movement_speed += acceleration_increment;
            acceleration_increment += 10;
            acceleration_count++;
        }
        
        var_267d01d2be2d145 = get_projectile_velocity( last_player_position, self.turning_factor );
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = vectortoangles( new_pos - self.origin );
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        
        if ( player::isaliveandnotinlaststand( target_player ) )
        {
            if ( !isdefined( target_player ) )
            {
                self notify( #"destroyed" );
                return;
            }
            
            last_player_position = target_player geteye() - ( 0, 0, 25 );
        }
        
        self.movement_speed += 2;
        
        if ( var_70ad3d2b67564946 > 0 )
        {
            self.turning_factor += 0.05;
            var_70ad3d2b67564946--;
            continue;
        }
        
        if ( self.turning_factor > 0.15 )
        {
            self.turning_factor -= 0.05;
        }
    }
}

// Namespace aries_boss
// Params 2
// Checksum 0xd3cd9128, Offset: 0x1e03
// Size: 0x10d
function function_56b2a28ef5d790( mars, ignore_list )
{
    var_6f69c2de53a9549a = getentarrayinradius( undefined, undefined, self.origin, 120 );
    
    if ( !ob::nightmare() )
    {
        damage = level.is_squad_size_small ? 20 : 25;
    }
    else
    {
        damage = 100;
    }
    
    /#
    #/
    
    foreach ( blasted_entity in var_6f69c2de53a9549a )
    {
        if ( isplayer( blasted_entity ) && mars::environment_trace( blasted_entity, [ "j_head", "j_spine4" ], ignore_list ) )
        {
            blasted_entity dodamage( damage, self.origin, mars, undefined, "MOD_EXPLOSIVE" );
        }
    }
}

// Namespace aries_boss
// Params 11
// Checksum 0x83c20fe1, Offset: 0x1f18
// Size: 0x142
function projectile_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "aries_boss_homing_projectile" || instance.destroyed )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        eattacker damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
    }
    else if ( isplayer( eattacker.owner ) )
    {
        eattacker.owner damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
    }
    
    if ( instance.entity.health <= 0 )
    {
        instance.entity notify( #"destroyed" );
        snd::play( "evt_aries_boss_orb_impt", instance.entity );
        return;
    }
    
    instance setscriptablepartstate( "health", "damageable" );
}

// Namespace aries_boss
// Params 2
// Checksum 0xa7b710a5, Offset: 0x2062
// Size: 0x11b
function get_projectile_velocity( target_pos, var_60ab41322253e19f )
{
    current_angles = self.var_ea82abf596b826f8;
    projectile_forward = anglestoforward( current_angles );
    normal = vectornormalize( target_pos - self.origin );
    dot = vectordot( projectile_forward, normal );
    
    if ( dot > 0 || self.lifetime < 3 )
    {
        target_angles = calculate_target_angles( target_pos );
        move_angles_x = math::angle_lerp( current_angles[ 0 ], target_angles[ 0 ], var_60ab41322253e19f );
        move_angles_y = math::angle_lerp( current_angles[ 1 ], target_angles[ 1 ], var_60ab41322253e19f );
        move_angles_z = math::angle_lerp( current_angles[ 2 ], target_angles[ 2 ], var_60ab41322253e19f );
        var_562085c3a13bb970 = ( move_angles_x, move_angles_y, move_angles_z );
        forward_dir = anglestoforward( var_562085c3a13bb970 );
    }
    else
    {
        forward_dir = anglestoforward( self.angles );
    }
    
    return vectornormalize( forward_dir ) * self.movement_speed;
}

// Namespace aries_boss
// Params 1, eflags: 0x4
// Checksum 0x825efb7, Offset: 0x2186
// Size: 0x2a
function private calculate_target_angles( target_pos )
{
    target_angles = vectortoangles( target_pos - self.origin );
    return target_angles;
}

// Namespace aries_boss
// Params 2, eflags: 0x4
// Checksum 0xf6862c3e, Offset: 0x21b9
// Size: 0x8d
function private lerp_angles( target_pos, var_60ab41322253e19f )
{
    current_angles = self.var_ea82abf596b826f8;
    target_angles = calculate_target_angles( target_pos );
    move_angles_x = math::angle_lerp( current_angles[ 0 ], target_angles[ 0 ], var_60ab41322253e19f );
    move_angles_y = math::angle_lerp( current_angles[ 1 ], target_angles[ 1 ], var_60ab41322253e19f );
    move_angles_z = math::angle_lerp( current_angles[ 2 ], target_angles[ 2 ], var_60ab41322253e19f );
    return ( move_angles_x, move_angles_y, move_angles_z );
}

// Namespace aries_boss
// Params 0, eflags: 0x4
// Checksum 0x63a4452b, Offset: 0x224f
// Size: 0xa1
function private function_6cf796194f513a9a()
{
    if ( level.is_squad_size_small )
    {
        switch ( level.mars_ai.remaining_heads )
        {
            case 2:
                return 10;
            case 1:
                return 5;
            default:
                return 15;
        }
        
        return;
    }
    
    switch ( level.mars_ai.remaining_heads )
    {
        case 2:
            return 7;
        case 1:
            return 5;
        default:
            return 10;
    }
}

// Namespace aries_boss
// Params 0, eflags: 0x4
// Checksum 0xa5f20c60, Offset: 0x22f8
// Size: 0xa1
function private function_e75124ffa201ec5b()
{
    if ( level.is_squad_size_small )
    {
        switch ( level.mars_ai.remaining_heads )
        {
            case 2:
                return 6;
            case 1:
                return 8;
            default:
                return 4;
        }
        
        return;
    }
    
    switch ( level.mars_ai.remaining_heads )
    {
        case 2:
            return 8;
        case 1:
            return 10;
        default:
            return 6;
    }
}

// Namespace aries_boss
// Params 0, eflags: 0x4
// Checksum 0xaaba1ad5, Offset: 0x23a1
// Size: 0xa1
function private function_f27df2d01ad2570a()
{
    if ( level.is_squad_size_small )
    {
        switch ( level.mars_ai.remaining_heads )
        {
            case 2:
                return 4;
            case 1:
                return 8;
            default:
                return 2;
        }
        
        return;
    }
    
    switch ( level.mars_ai.remaining_heads )
    {
        case 2:
            return 5;
        case 1:
            return 10;
        default:
            return 3;
    }
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0x4b663525, Offset: 0x244a
    // Size: 0x5, Type: dev
    function function_3ea4c2e9658ae55a()
    {
        
    }

#/

// Namespace aries_boss
// Params 1
// Checksum 0x6e003e3d, Offset: 0x2457
// Size: 0x1bb
function dragons_breath_handler( skip_vfx )
{
    self endon( #"death" );
    self endon( #"interrupted" );
    level endon( #"game_ended" );
    
    if ( !skip_vfx )
    {
        self setscriptablepartstate( "attack", "dragons_breath_tell" );
        self waittill( #"dragons_breath_tell_end" );
        self setscriptablepartstate( "attack", "idle" );
        self waittill( #"dragons_breath_start" );
        childthread function_71c3a1bdcfbc4507();
        self setscriptablepartstate( "attack", "dragons_breath" );
        self waittill( #"dragons_breath_begin_exit" );
        self setscriptablepartstate( "attack", "idle" );
        self waittill( #"dragons_breath_end" );
        
        if ( !utility::flag( "flag_mars_first_dragon_breath" ) )
        {
            utility::flag_set( "flag_mars_first_dragon_breath" );
        }
    }
    else
    {
        self waittill( #"dragons_breath_end" );
    }
    
    if ( skip_vfx )
    {
        cooldown = 0;
        waittime = 0;
    }
    else
    {
        switch ( self.phase )
        {
            case 1:
                cooldown = level.is_squad_size_small ? 8 : 6;
                waittime = 2;
                break;
            case 3:
                cooldown = level.is_squad_size_small ? 10 : 8;
                waittime = 1;
                break;
            default:
                assertmsg( "<dev string:x58>" + self.phase );
                break;
        }
    }
    
    ai::set_blackboard_cooldown( "mars_time_between_attacks", int( utility::function_4b74c15943231980( waittime ) ) );
    ai::set_blackboard_cooldown( "mars_dragons_breath_cooldown", int( utility::function_4b74c15943231980( cooldown ) ) );
    self function_f2df0257c63f229( "in_dragons_breath" );
}

// Namespace aries_boss
// Params 0
// Checksum 0x4902c488, Offset: 0x261a
// Size: 0xdb
function function_71c3a1bdcfbc4507()
{
    self endon( #"dragons_breath_begin_exit" );
    var_3fb89cc70bd41d0 = self.dragons_breath_trigger;
    
    /#
        if ( getdvarint( @"scr_debug_dragons_breath", 0 ) == 1 )
        {
            childthread dragons_breath_debug_draw( var_3fb89cc70bd41d0 );
        }
    #/
    
    affected_players = [];
    
    while ( self getaiblackboarddynamic( "in_dragons_breath" ) )
    {
        var_3fb89cc70bd41d0 waittill( #"trigger", triggerer );
        
        if ( isplayer( triggerer ) && !arraycontains( affected_players, triggerer ) && mars::environment_trace( triggerer, [ "j_head", "j_spine4", "tag_origin" ], [ self ], "j_flower_face" ) && player::isaliveandnotinlaststand( triggerer ) )
        {
            triggerer thread dragons_breath_damage_callback( self );
            affected_players[ affected_players.size ] = triggerer;
        }
    }
}

// Namespace aries_boss
// Params 1
// Checksum 0xb8ef7fe1, Offset: 0x26fd
// Size: 0xae
function dragons_breath_damage_callback( mars )
{
    direction = vectornormalize( self.origin - mars.origin + ( 0, 0, 700 ) );
    damage = level.is_squad_size_small ? 75 : 100;
    self shellshock( "concussion_grenade_mp", 2 );
    knock_back( direction, 500 );
    self dodamage( damage, self.origin, mars, undefined, "MOD_EXPLOSIVE" );
    self playrumbleonpositionforclient( "artillery_rumble_heavy", self.origin );
    snd::play( "evt_aries_boss_breath_impt" );
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0x3d4721a1, Offset: 0x27b3
    // Size: 0x5, Type: dev
    function function_9b235dc3180dade5()
    {
        
    }

#/

// Namespace aries_boss
// Params 1
// Checksum 0xdda031f2, Offset: 0x27c0
// Size: 0x50b
function function_e28c6c48eab919a6( params )
{
    self.health = 9999;
    
    if ( function_6556a3d9c5cf260e() == 5 || params.smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        return;
    }
    
    damage = params.idamage;
    params.var_4f9d5587bf9a2b1e = 0;
    
    if ( is_inactive() )
    {
        level utility::flag_set( "flag_mars_players_shoot_immune_heads" );
        damage = 1;
    }
    else if ( self.phase == 3 && params.objweapon.classname == "sniper" )
    {
        damage = min( getdvarfloat( @"hash_ca4c260c5a56d0a2", 0.5 ) * damage, 200 );
    }
    else if ( params.shitloc != "torso_lower" )
    {
        damage = 1;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        if ( self.phase == 3 && params.shitloc == "torso_lower" )
        {
            params.eattacker damagefeedback::updatehitmarker( "standard", self.health == 0, 1, 1 );
        }
        else
        {
            params.eattacker damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
        }
    }
    else if ( isplayer( params.eattacker.owner ) )
    {
        if ( self.phase == 3 && params.shitloc == "torso_lower" )
        {
            params.eattacker.owner damagefeedback::updatehitmarker( "standard", self.health == 0, 1, 1 );
        }
        else
        {
            params.eattacker.owner damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
        }
    }
    
    if ( !utility::flag( "flag_mars_first_emitter_damaged" ) )
    {
        utility::flag_set( "flag_mars_first_emitter_damaged" );
    }
    
    if ( isexplosivedamagemod( params.smeansofdeath ) )
    {
        damage = 300;
    }
    
    if ( metabone::function_83525a0b05843168() )
    {
        params.metabonename = metabone::function_b7f4a00525689bee( params );
    }
    else
    {
        params.metabonename = metabone::get_metabone_name( params.shitloc, params.partname, params.vpoint, params.vdir );
        
        if ( isexplosivedamagemod( params.smeansofdeath ) && !isdefined( params.metabonename ) )
        {
            var_d906f3558dfa031f = metabone::function_30d906ccb9fe2142( "Types_Armor" );
            
            if ( var_d906f3558dfa031f.size > 0 )
            {
                params.metabonename = utility::array_random( var_d906f3558dfa031f );
            }
        }
        
        armor_data = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
        
        if ( isdefined( armor_data ) )
        {
            params.var_d5020ae6ddd07b6e = isexplosivedamagemod( params.smeansofdeath ) ? armor_data.explosivedamagemod : armor_data.damagemod;
            params.var_4f9d5587bf9a2b1e = isdefined( params.var_d5020ae6ddd07b6e );
            assert( isdefined( params.var_d5020ae6ddd07b6e ), "<dev string:x89>" + params.metabonename + "<dev string:xb4>" + metabone::get_metabone_state_name( params.metabonename ) + "<dev string:xc0>" + ( metabone::is_metabone_destroyed( params.metabonename ) ? "<dev string:xd1>" : "<dev string:xd6>" ) );
        }
        
        if ( params.var_4f9d5587bf9a2b1e )
        {
            assert( params.var_d5020ae6ddd07b6e <= 1 );
            damage = 1;
        }
    }
    
    if ( metabone::function_3866ce438fcee825() )
    {
        params.forcecrit = metabone::function_d985a5fbf5939161( params );
    }
    
    if ( params.metabonename && !metabone::is_metabone_armor( params.metabonename ) )
    {
        damage = try_damage_metabone( params );
    }
    
    if ( self.phase != 3 )
    {
        damage = 1;
    }
    
    if ( self.var_cce7c67ea2da8902 )
    {
        damage = min( damage, self.var_cce7c67ea2da8902 );
        self.var_cce7c67ea2da8902 -= damage;
    }
    else
    {
        level.mars_ai.var_1e0c729a105495d0 += damage;
    }
    
    if ( level.mars_ai.inactive_state == 0 )
    {
        level.mars_ai thread mars::healthbar_update();
        level.mars_ai notify( #"notify_mars_head_damaged" );
    }
    
    if ( self.var_cce7c67ea2da8902 <= 0 )
    {
        self notify( #"fake_death" );
        function_9f6815fb4ef00ed6( undefined );
    }
}

// Namespace aries_boss
// Params 1
// Checksum 0xe22fe95e, Offset: 0x2cd3
// Size: 0x122
function try_damage_metabone( dmg_struct )
{
    if ( self.damageshield )
    {
        return dmg_struct.idamage;
    }
    
    if ( isdefined( dmg_struct.metabonename ) )
    {
        metabone_start_health = metabone::get_metabone_health( dmg_struct.metabonename );
        b_destroyed = metabone::damage_metabone( dmg_struct.metabonename, dmg_struct.idamage, dmg_struct.eattacker, dmg_struct.einflictor, dmg_struct.vdir );
        
        if ( dmg_struct.var_4f9d5587bf9a2b1e && isdefined( self.modifiedidflags ) )
        {
            self.modifiedidflags |= 512;
            
            if ( b_destroyed )
            {
                self.modifiedidflags |= 1024;
            }
        }
        
        var_20049f434bd68701 = 0;
        
        if ( isdefined( metabone_start_health ) )
        {
            var_20049f434bd68701 = b_destroyed ? metabone_start_health : metabone_start_health - metabone::get_metabone_health( dmg_struct.metabonename );
        }
        
        return 0;
    }
    
    return dmg_struct.idamage;
}

// Namespace aries_boss
// Params 1
// Checksum 0x89d19dbe, Offset: 0x2dfe
// Size: 0x99
function function_9f6815fb4ef00ed6( params )
{
    interrupt_behavior();
    self setscriptablepartstate( "phase", "dead" );
    metabone::set_metabone_active( "head", 1 );
    metabone::set_metabone_state( "head", "disabled" );
    self function_786bb6aa1b76c7ee( "in_death", 1 );
    level.mars_ai.remaining_heads -= 1;
    level.mars_ai notify( #"notify_final_phase_head_destroyed" );
    utility::flag_set( "flag_mars_head_destroyed" );
}

// Namespace aries_boss
// Params 0
// Checksum 0x8c6e8c2a, Offset: 0x2e9f
// Size: 0x163
function function_673087d280d9c565()
{
    if ( !isarray( self.var_c127d6dcc18f3fe5 ) || self.var_c127d6dcc18f3fe5.size == 0 )
    {
        return;
    }
    
    var_bd9e4297979163 = 0;
    var_af539d054e4c8267 = floor( self.var_c127d6dcc18f3fe5.size * 0.5 * 100 );
    
    foreach ( player in self.var_c127d6dcc18f3fe5 )
    {
        on_platform = player.origin[ 2 ] - level.mars_ai.stalk.origin[ 2 ] > 250 && !player isjumping();
        
        if ( on_platform )
        {
            var_bd9e4297979163 += 100;
        }
    }
    
    self function_f2df0257c63f229( "dragons_breath_high" );
    
    if ( var_bd9e4297979163 > var_af539d054e4c8267 )
    {
        self function_786bb6aa1b76c7ee( "dragons_breath_high", 1 );
    }
    
    self function_f2df0257c63f229( "dragons_breath_left" );
    direction = randomint( 2 );
    
    if ( direction == 0 )
    {
        self function_786bb6aa1b76c7ee( "dragons_breath_left", 1 );
    }
    
    return 1;
}

// Namespace aries_boss
// Params 2
// Checksum 0xdcb95d43, Offset: 0x300b
// Size: 0x3c
function knock_back( direction, magnitude )
{
    self setorigin( self.origin + ( 0, 0, 20 ) );
    self setvelocity( direction * magnitude );
}

// Namespace aries_boss
// Params 1
// Checksum 0x8f6c1557, Offset: 0x304f
// Size: 0x2f
function function_e5e4f769eb69796b( mars_stalk_scene )
{
    mars_stalk_scene scene::play( self.stalk, "idle_loop" );
    self notify( #"notify_stalk_idle_finished" );
}

// Namespace aries_boss
// Params 0
// Checksum 0xdeea98f9, Offset: 0x3086
// Size: 0x272
function function_b9a054cc6f3e702f()
{
    self endon( #"death" );
    level endon( #"aries_boss_phasethree_complete" );
    mars_notifies = [ "mars_phasetwo_start", "mars_phasethree_start", "weak_point_destroyed", "notify_mars_inactive", "notify_stalk_idle_finished" ];
    self.stalk thread stalk_damage_watcher();
    
    /#
    #/
    
    mars_stalk_scene = utility::getstruct( "mars_stalk_scene", "targetname" );
    
    while ( true )
    {
        thread function_e5e4f769eb69796b( mars_stalk_scene );
        mars_notify = utility::waittill_any_in_array_return( mars_notifies );
        
        switch ( mars_notify )
        {
            case #"hash_18b595ff1bc0ac10":
                foreach ( head in self.var_e03a976980256ff1 )
                {
                    head thread function_8c917487a8054e27();
                }
                
                mars_stalk_scene scene::play( self.stalk, "pain" );
                break;
            case #"hash_1cd96563aec122d":
            case #"hash_7d6dcf45ac1f7f87":
                level.mars_ai.stalk setscriptablepartstate( "stalk_body", "active" );
                mars_stalk_scene scene::play( self.stalk, "rage_02" );
                
                foreach ( player in level.players )
                {
                    earthquake( 10, 4, player.origin, 10 );
                }
                
                break;
            case #"hash_f25677909e4b12b4":
                level.mars_ai.stalk setscriptablepartstate( "stalk_body", "inactive" );
                break;
            case #"hash_135c71f4358a2e62":
                break;
            default:
                break;
        }
    }
}

// Namespace aries_boss
// Params 0
// Checksum 0xf0d7ae64, Offset: 0x3300
// Size: 0xe9
function stalk_damage_watcher()
{
    while ( true )
    {
        level.mars_ai.stalk waittill( #"damage", idamage, eattacker, direction_vec, var_5fb4fe43f49ba675, means_of_death );
        
        if ( means_of_death == "MOD_TRIGGER_HURT" )
        {
            continue;
        }
        
        if ( level.mars_ai.inactive_state )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eattacker, self, "tag_origin", undefined, undefined, idamage, var_5fb4fe43f49ba675, 1 );
            continue;
        }
        
        mp_agent_damage::function_eb8ba16055d6da7c( eattacker, self, "tag_origin", undefined, undefined, 1, var_5fb4fe43f49ba675 );
        level.mars_ai.var_1e0c729a105495d0 += 1;
        level.mars_ai mars::healthbar_update();
    }
}

// Namespace aries_boss
// Params 0, eflags: 0x4
// Checksum 0x59b750a3, Offset: 0x33f1
// Size: 0x61, Type: bool
function private is_inactive()
{
    stalk_disabled = level.mars_ai.stalk getscriptablepartstate( "stalk_body" ) == "inactive";
    head_disabled = metabone::get_metabone_state_name( "head" ) == "disabled";
    return !self.head_enabled || stalk_disabled || head_disabled;
}

// Namespace aries_boss
// Params 0, eflags: 0x4
// Checksum 0x39d66cfc, Offset: 0x345b
// Size: 0x91
function private function_7734e172f8439510()
{
    active_players = [];
    
    foreach ( player in level.players )
    {
        if ( player::isaliveandnotinlaststand( player ) )
        {
            active_players[ active_players.size ] = player;
        }
    }
    
    return active_players;
}

/#

    // Namespace aries_boss
    // Params 0
    // Checksum 0xb9005704, Offset: 0x34f5
    // Size: 0x5, Type: dev
    function function_3989edafd8102783()
    {
        
    }

    // Namespace aries_boss
    // Params 0
    // Checksum 0xdb186931, Offset: 0x3502
    // Size: 0xac, Type: dev
    function function_7c53a041cf2aba3f()
    {
        stalk = self;
        
        while ( true )
        {
            waitframe();
            partstate = stalk getscriptablepartstate( "<dev string:xdc>" );
            
            if ( partstate == "<dev string:xe7>" )
            {
                print3d( self.origin, "<dev string:xee>", ( 0, 1, 0 ) );
                continue;
            }
            
            if ( partstate == "<dev string:x101>" )
            {
                print3d( self.origin, "<dev string:x10a>", ( 0, 1, 0 ) );
                continue;
            }
            
            print3d( self.origin, "<dev string:x11f>", ( 0, 1, 0 ) );
        }
    }

    // Namespace aries_boss
    // Params 0
    // Checksum 0x1e348790, Offset: 0x35b6
    // Size: 0x14a, Type: dev
    function debug_current_state()
    {
        state = function_6556a3d9c5cf260e();
        
        switch ( state )
        {
            case 0:
                print3d( self.origin, "<dev string:x133>", ( 0, 1, 0 ) );
                break;
            case 1:
                print3d( self.origin, "<dev string:x138>", ( 0, 1, 0 ) );
                break;
            case 2:
                print3d( self.origin, "<dev string:x148>", ( 0, 1, 0 ) );
                break;
            case 3:
                print3d( self.origin, "<dev string:x153>", ( 0, 1, 0 ) );
                break;
            case 4:
                print3d( self.origin, "<dev string:x158>", ( 0, 1, 0 ) );
                break;
            case 5:
                print3d( self.origin, "<dev string:x161>", ( 0, 1, 0 ) );
                break;
            default:
                break;
        }
    }

    // Namespace aries_boss
    // Params 1
    // Checksum 0xf24bbed7, Offset: 0x3708
    // Size: 0xcf, Type: dev
    function debug_draw_attack_range( target_pos )
    {
        forward_vec = vectornormalize( anglestoup( self.original_angles ) );
        pos_vec = vectornormalize( ( target_pos[ 0 ], target_pos[ 1 ], self.origin[ 2 ] ) - self.origin );
        var_d8d09d30e3724c59 = vectordot( forward_vec, pos_vec );
        angle = acos( var_d8d09d30e3724c59 );
        draw_color = ( 1, 0, 0 );
        
        if ( angle < 60 || angle > 300 )
        {
            draw_color = ( 0, 1, 0 );
        }
        
        utility::draw_cone( self.origin, forward_vec, 5000, 120, draw_color, undefined, undefined, undefined, 1 );
    }

    // Namespace aries_boss
    // Params 1
    // Checksum 0x644269aa, Offset: 0x37df
    // Size: 0x3c, Type: dev
    function dragons_breath_debug_draw( var_3fb89cc70bd41d0 )
    {
        while ( self getaiblackboarddynamic( "<dev string:x166>" ) )
        {
            drawtrigger( var_3fb89cc70bd41d0, ( 0, 1, 1 ), 0, 2 );
            wait 0.025;
        }
    }

#/
