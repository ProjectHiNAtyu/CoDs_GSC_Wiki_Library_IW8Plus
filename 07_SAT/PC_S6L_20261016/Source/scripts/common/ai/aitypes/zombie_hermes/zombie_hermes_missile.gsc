// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_missile.gsc  (hash_4d9fe0136c6924a3.gscc) (size: 19222 Bytes / 0x4b16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3d9cb7b (4091136891)
// size ...... 19222 (0x4b16)
// includes .. 8   (offset: 0x46e2)
// strings ... 40  (offset: 0x4722)
// dev strs .. 27  (offset: 0x499e)
// exports ... 41  (offset: 0x2f16)
// cseg ...... 0x382 + 0x2b94 (0x2f16)
// imports ... 133 (offset: 0x357e)
// animtree1 . 0   (offset: 0x4b16)
// animtree2 . 0   (offset: 0x4b16)
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_aetheric_energy;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;

#namespace zombie_hermes_missile;

// Namespace zombie_hermes_missile
// Params 0
// Checksum 0xab5232c3, Offset: 0x3a0
// Size: 0x9a
function init_zombie_hermes_missile()
{
    thread function_127f407f57e00231();
    self.hermes_missile_turret = spawnturret( "misc_turret", self.origin, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.missileasset, 0 );
    self.var_8361d0196aa3fa4f = spawnturret( "misc_turret", self.origin, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2a73eee9e6e10880, 0 );
    thread setup_zombie_hermes_missile();
    self.var_7f8ab9bb9f4957fc = &function_27e45ab205de1957;
    
    /#
        function_ae00e9fafdcbd63d();
    #/
}

// Namespace zombie_hermes_missile
// Params 0, eflags: 0x4
// Checksum 0x54b41a6e, Offset: 0x442
// Size: 0x26f
function private setup_zombie_hermes_missile()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    self.var_d35f33ff2bcf11f4 = [ self.hermes_missile_turret, self.var_8361d0196aa3fa4f ];
    
    foreach ( turret in self.var_d35f33ff2bcf11f4 )
    {
        if ( isdefined( turret ) )
        {
            turret setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.turretmodel );
            turret setmode( "manual" );
            turret show();
            pitch = turret == self.hermes_missile_turret ? 20 : -45;
            turret setdefaultdroppitch( pitch );
            turret.gunner = self;
            turret.var_10bee59409ebb9e1 = 0;
            var_ff296174642efe35 = 20;
            turret.link_properties = [ { #angle_variation:var_ff296174642efe35, #angle_offset:( 75, 90, 90 ), #origin_offset:( 45, 10, 0 ), #tag:"j_spine4_skin" }, { #angle_variation:var_ff296174642efe35, #angle_offset:( 195, 90, 90 ), #origin_offset:( 45, 10, 0 ), #tag:"j_spine4_skin" }, { #angle_variation:var_ff296174642efe35, #angle_offset:( 315, 90, 90 ), #origin_offset:( 45, 10, 0 ), #tag:"j_spine4_skin" } ];
            link_struct = turret.link_properties[ 0 ];
            waitframe();
            turret linkto( self, link_struct.tag, link_struct.origin_offset, link_struct.angle_offset );
            thread utility::delete_on_death( turret );
        }
    }
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x960bca5f, Offset: 0x6b9
// Size: 0x124
function function_5ea526b9b4ecef5b( taskid, params )
{
    target = function_9521404c516da58c( self );
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( self.var_e3369664b5e43878 && !utility::time_has_passed( self.var_e3369664b5e43878, 2 ) )
    {
        return anim.failure;
    }
    
    if ( getdvarint( @"hash_7645724da35e7d22", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( getdvarint( @"hash_74f6afbe029d89d9", 0 ) > 0 )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "head_state_recently_changed" ) )
    {
        return anim.failure;
    }
    
    cooldown = 10;
    
    if ( self.var_e3369664b5e43878 && !utility::time_has_passed( self.var_e3369664b5e43878, cooldown ) )
    {
        return anim.failure;
    }
    
    if ( self.var_31dccc1abe7714d0 && !utility::time_has_passed( self.var_31dccc1abe7714d0, 2 ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x7d6e7628, Offset: 0x7e6
// Size: 0x4b
function function_41d30dda5ff685e1( taskid, params )
{
    target = function_9521404c516da58c( self );
    
    if ( target )
    {
        self.var_5c1f307efe50278a = target;
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0xf45544ca, Offset: 0x83a
// Size: 0xd9
function function_7a0b7565ee5decae( taskid, params )
{
    charge_time = 4000;
    
    if ( zombie_hermes_aetheric_energy::get_hermes_phase( self ) == 2 )
    {
        charge_time = 3000;
    }
    
    if ( isfloat( params ) && params > 0 )
    {
        charge_time = int( charge_time * 0.5 );
    }
    
    charge_time = getdvarint( @"hermes_big_missile_charge_time", charge_time );
    utility::ent_flag_set( "hermes_big_missile_charge" );
    utility::function_7c10ea82c1e305b8( "big_missile_attack", "charging" );
    level callback::callback( "vo_shadow_energy_attack_launched" );
    self function_786bb6aa1b76c7ee( "big_missile_attack", 1 );
    self.hermes_big_missile_charge_time_end = gettime() + charge_time;
    self.var_3083e46e07b32149 = gettime() + charge_time * getdvarfloat( @"hash_5d1c8c924a951919", 0.5 );
    return anim.success;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x863ff513, Offset: 0x91c
// Size: 0x75
function function_bcc58b76de061dbc( taskid, params )
{
    if ( gettime() > self.var_3083e46e07b32149 && !utility::ent_flag( "hermes_big_missile_launched_missiles" ) )
    {
        utility::ent_flag_set( "hermes_big_missile_launched_missiles" );
        thread function_407aaf6549225095( self, get_big_missile_target( self ) );
    }
    
    if ( gettime() > self.hermes_big_missile_charge_time_end )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x4084f15b, Offset: 0x99a
// Size: 0x5d
function function_f6e081f7a88117b3( taskid, params )
{
    self.hermes_big_missile_charge_time_end = undefined;
    utility::ent_flag_clear( "hermes_big_missile_charge" );
    utility::ent_flag_clear( "hermes_big_missile_launched_missiles" );
    utility::function_7c10ea82c1e305b8( "big_missile_attack", "off" );
    self function_786bb6aa1b76c7ee( "big_missile_attack", 0 );
    return anim.success;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x72e071cf, Offset: 0xa00
// Size: 0x84
function function_947d70692d1e917e( taskid, params )
{
    attack_duration = 3000;
    self.hermes_big_missile_attack_time_end = gettime() + attack_duration;
    target = get_big_missile_target( self );
    utility::ent_flag_set( "hermes_big_missile_attack" );
    utility::function_7c10ea82c1e305b8( "big_missile_attack", "attack" );
    self function_786bb6aa1b76c7ee( "big_missile_attack", 1 );
    self notify( #"hermes_fire_big_missile_queue" );
    return anim.success;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0xc5b944f3, Offset: 0xa8d
// Size: 0x39
function function_ad1bc7c580bf9aec( taskid, params )
{
    if ( gettime() > self.hermes_big_missile_attack_time_end )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0xc64bc018, Offset: 0xacf
// Size: 0x54
function function_cd15efd48458fd63( taskid, params )
{
    self.var_e3369664b5e43878 = gettime();
    utility::ent_flag_clear( "hermes_big_missile_attack" );
    utility::function_7c10ea82c1e305b8( "big_missile_attack", "off" );
    self function_786bb6aa1b76c7ee( "big_missile_attack", 0 );
    return anim.success;
}

// Namespace zombie_hermes_missile
// Params 0, eflags: 0x4
// Checksum 0xb4bd2fa6, Offset: 0xb2c
// Size: 0x153
function private function_127f407f57e00231()
{
    self endon( #"death" );
    waitframe();
    
    while ( asm_bb::bb_isanimscripted() )
    {
        waitframe();
    }
    
    utility::waittill_notify_or_timeout( "damage", 10 );
    missile_cooldown = get_missile_cooldown( self );
    
    while ( true )
    {
        target_pos = self.origin;
        
        if ( !isdefined( self.enemy ) )
        {
            waitframe();
            continue;
        }
        
        if ( getdvarint( @"hash_b2a0b1e1e66246b4", 0 ) > 0 )
        {
            waitframe();
            continue;
        }
        
        if ( zombie_hermes_aetheric_energy::is_stunned( self ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "hermes_new_phase_set_recently" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_beam_charge" ) > 0 && !level.var_81dc9de2fda86a3f )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "hermes_beaming" ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "hermes_ufo_active" ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "marked_for_death" ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "hermes_big_missile_charge" ) || utility::ent_flag( "hermes_big_missile_waitframe" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.var_e3369664b5e43878 && !utility::time_has_passed( self.var_e3369664b5e43878, missile_cooldown ) )
        {
            waitframe();
            continue;
        }
        
        launch_missile_waves( self );
        missile_cooldown = get_missile_cooldown( self );
        wait missile_cooldown;
    }
}

// Namespace zombie_hermes_missile
// Params 1, eflags: 0x4
// Checksum 0x2cab7176, Offset: 0xc87
// Size: 0x2d
function private get_missile_cooldown( hermes )
{
    phase = zombie_hermes_aetheric_energy::get_hermes_phase( hermes );
    
    if ( phase != 1 )
    {
        return 15;
    }
    
    return 25;
}

// Namespace zombie_hermes_missile
// Params 1, eflags: 0x4
// Checksum 0x4d1345ea, Offset: 0xcbd
// Size: 0x27c
function private launch_missile_waves( hermes )
{
    hermes endon( #"death" );
    var_1063baf0902a3f78 = getdvarint( @"hash_6adc9ebf78a3674a", 5 );
    wave_index = 0;
    
    while ( wave_index < var_1063baf0902a3f78 )
    {
        targets = hermes function_f017e352a29a57a1( hermes.origin, 4000, 1 );
        known_vehicles = [];
        targets_in_vehicle = [];
        targets_other = [];
        
        foreach ( target in targets )
        {
            vehicle = target.vehicle ?? ( isplayer( target ) ? target getmovingplatformparent() : undefined );
            
            if ( vehicle.vehicletype )
            {
                if ( !arraycontains( known_vehicles, vehicle ) )
                {
                    known_vehicles[ known_vehicles.size ] = vehicle;
                    targets_in_vehicle[ targets_in_vehicle.size ] = target;
                }
                
                continue;
            }
            
            targets_other[ targets_other.size ] = target;
        }
        
        foreach ( target in targets_in_vehicle )
        {
            function_d507eef555f214a2( hermes, target );
            waitframe();
            waitframe();
            waitframe();
        }
        
        in_beam_charge = isai( self ) && self getaiblackboarddynamic( "in_beam_charge" ) > 0;
        
        if ( !in_beam_charge )
        {
            foreach ( target in targets_other )
            {
                if ( zombie_hermes_aetheric_energy::get_hermes_phase( hermes ) == 1 )
                {
                    launch_missile_direct( hermes, target );
                }
                else
                {
                    function_1acf062f485f2539( hermes, target );
                }
                
                waitframe();
                waitframe();
                waitframe();
            }
        }
        
        wait getdvarint( @"hash_2b980287b0ec2d37", 1 );
        wave_index += 1;
    }
}

// Namespace zombie_hermes_missile
// Params 2, eflags: 0x4
// Checksum 0xfe408c6d, Offset: 0xf41
// Size: 0x14b
function private function_d507eef555f214a2( hermes, target_ent )
{
    hermes endon( #"death" );
    angle = randomfloat( 360 );
    var_a5dd7a9cbd2fd168 = ( cos( angle ), cos( angle ), 0 ) * 250;
    hermes function_786bb6aa1b76c7ee( "hermes_aeth_launch", 1 );
    hermes thread utility::delaycall( 0.5, &function_786bb6aa1b76c7ee, "hermes_aeth_launch", 0 );
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_predict", undefined, getdvarfloat( @"hash_a1eb5597414aac10", 0.2 ) );
    waitframe();
    waitframe();
    waitframe();
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_predict", var_a5dd7a9cbd2fd168, getdvarfloat( @"hash_a1eb5597414aac10", 0.2 ) );
    waitframe();
    waitframe();
    waitframe();
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_predict", var_a5dd7a9cbd2fd168 * -1, getdvarfloat( @"hash_a1eb5597414aac10", 0.2 ) );
    waitframe();
    waitframe();
    waitframe();
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_predict_angular", undefined, getdvarfloat( @"hash_a1eb5597414aac10", 0.2 ), { #force_angular:1 } );
    waitframe();
    waitframe();
    waitframe();
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_direct", undefined, getdvarfloat( @"hash_a1eb5597414aac10", 0.2 ) );
}

// Namespace zombie_hermes_missile
// Params 2
// Checksum 0x2aec37c7, Offset: 0x1094
// Size: 0x5f
function launch_missile_direct( hermes, target_ent )
{
    hermes function_786bb6aa1b76c7ee( "hermes_aeth_launch", 1 );
    hermes thread utility::delaycall( 0.5, &function_786bb6aa1b76c7ee, "hermes_aeth_launch", 0 );
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_direct", undefined, getdvarfloat( @"hash_e9ca26f1cb721070", 0.4 ) );
}

// Namespace zombie_hermes_missile
// Params 2, eflags: 0x4
// Checksum 0x3fe3c1fa, Offset: 0x10fb
// Size: 0x94
function private function_1acf062f485f2539( hermes, target_ent )
{
    hermes endon( #"death" );
    hermes function_786bb6aa1b76c7ee( "hermes_aeth_launch", 1 );
    hermes thread utility::delaycall( 0.2, &function_786bb6aa1b76c7ee, "hermes_aeth_launch", 0 );
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_predict", undefined, getdvarfloat( @"hash_e9ca26f1cb721070", 0.4 ) );
    waitframe();
    waitframe();
    waitframe();
    hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, "player_direct", undefined, getdvarfloat( @"hash_e9ca26f1cb721070", 0.4 ) );
}

// Namespace zombie_hermes_missile
// Params 2, eflags: 0x4
// Checksum 0x4a489e2, Offset: 0x1197
// Size: 0x169
function private function_407aaf6549225095( hermes, target_ent )
{
    hermes endon( #"death" );
    hermes function_786bb6aa1b76c7ee( "hermes_aeth_launch", 1 );
    hermes thread utility::delaycall( 0.2, &function_786bb6aa1b76c7ee, "hermes_aeth_launch", 0 );
    is_target_close = 0;
    var_33bc639b97d52a1f = getdvarfloat( @"hash_9e1a0abbfdae8f6a", 800 );
    
    if ( self.arena_center_pos && distance2d( self.arena_center_pos, target_ent.origin ) < var_33bc639b97d52a1f )
    {
        is_target_close = 1;
    }
    
    offsets = function_3ec31c3bdcc032cf( hermes, target_ent, is_target_close );
    hermes.var_db7ba2c78b17a0d8 = [];
    offset_i = 0;
    
    while ( offset_i < offsets.size )
    {
        offset = offsets[ offset_i ];
        hermes thread function_85d9d79082b00dee( hermes, undefined, target_ent, "player_big_missile", offset, is_target_close );
        offset_i += 1;
    }
    
    hermes utility::waittill_notify_or_timeout( "hermes_fire_big_missile_queue", 10 );
    queue_i = 0;
    
    while ( queue_i < hermes.var_db7ba2c78b17a0d8.size )
    {
        missile_id = hermes.var_db7ba2c78b17a0d8[ queue_i ];
        hermes notify( "fire_missile_" + missile_id );
        waitframe();
        waitframe();
        waitframe();
        queue_i += 1;
    }
    
    hermes.var_db7ba2c78b17a0d8 = [];
}

// Namespace zombie_hermes_missile
// Params 2, eflags: 0x4
// Checksum 0x1d7878b0, Offset: 0x1308
// Size: 0x82
function private function_98ba5a96d62352c0( hermes, origin )
{
    if ( !isalive( hermes ) )
    {
        return;
    }
    
    marker = spawnscriptable( hermes.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_97aeb570cc679bbb, origin, ( 0, 0, 0 ) );
    
    if ( isdefined( marker ) )
    {
        marker utility::function_32b24db3127bff40( "target", "on" );
        thread function_52bae1fb4b7900da( marker );
    }
    
    return marker;
}

// Namespace zombie_hermes_missile
// Params 1, eflags: 0x4
// Checksum 0xb97875b3, Offset: 0x1393
// Size: 0x36
function private function_52bae1fb4b7900da( marker )
{
    marker endon( #"death" );
    wait getdvarint( @"hash_4a2c0ff601b05b3a", 15 );
    
    if ( isdefined( marker ) )
    {
        marker freescriptable();
    }
}

// Namespace zombie_hermes_missile
// Params 5, eflags: 0x4
// Checksum 0x420c5039, Offset: 0x13d1
// Size: 0x3ee
function private function_98b98f0425abe272( target_ent, target_type, target_offset, prediction_time_scalar = 1, other_params )
{
    target_pos = undefined;
    
    switch ( target_type )
    {
        case #"hash_fa69b8732be18414":
            target_pos = target_ent.origin;
            break;
        case #"hash_45ee819040d7aa8b":
        case #"hash_e685f1d4d46eddf2":
            var_df9adb69b75ff5f3 = undefined;
            target_angular_velocity = undefined;
            var_631938ab08153ea3 = target_ent.vehicle ?? ( isplayer( target_ent ) ? target_ent getmovingplatformparent() : undefined ) ?? target_ent;
            
            if ( var_631938ab08153ea3 && var_631938ab08153ea3.vehicletype )
            {
                target_veh = var_631938ab08153ea3;
                var_df9adb69b75ff5f3 = target_veh vehicle_getvelocity();
                target_angular_velocity = target_veh vehicle_getangularvelocity();
                
                if ( target_type == "player_predict_angular" )
                {
                    if ( length( target_angular_velocity ) > 5 )
                    {
                        target_pos = function_2f5381a0ce1ab124( target_veh, var_df9adb69b75ff5f3, target_angular_velocity );
                        break;
                    }
                }
            }
            
            if ( isai( var_631938ab08153ea3 ) || isplayer( var_631938ab08153ea3 ) )
            {
                if ( !isdefined( var_df9adb69b75ff5f3 ) )
                {
                    var_df9adb69b75ff5f3 = var_631938ab08153ea3 getvelocity();
                }
            }
            
            if ( !isdefined( var_df9adb69b75ff5f3 ) )
            {
                var_df9adb69b75ff5f3 = ( 0, 0, 0 );
            }
            
            target_speed = length2d( var_df9adb69b75ff5f3 );
            
            if ( target_type == "player_predict_angular" && other_params.force_angular && var_631938ab08153ea3 )
            {
                target_angular_velocity = ( 0, 0, 90 * utility::array_random( [ -1, 1 ] ) );
                target_pos = function_2f5381a0ce1ab124( var_631938ab08153ea3, var_df9adb69b75ff5f3, target_angular_velocity, prediction_time_scalar );
                break;
            }
            
            if ( target_speed > 0 )
            {
                target_dir = vectornormalize2( var_df9adb69b75ff5f3 );
                recorded_speed = [ 0, getdvarfloat( @"hash_9b534438a7477f1c", 600 ) ];
                predicted_dists = [ 0, getdvarfloat( @"hash_936b614ecf95d273", 1600 ) ];
                var_2e398834110513e4 = math::remap( target_speed, recorded_speed[ 0 ], recorded_speed[ 1 ], predicted_dists[ 0 ], predicted_dists[ 1 ] );
                var_2e398834110513e4 = clamp( var_2e398834110513e4, predicted_dists[ 0 ], predicted_dists[ 1 ] );
                var_2e398834110513e4 *= prediction_time_scalar;
                target_pos = var_631938ab08153ea3.origin + target_dir * var_2e398834110513e4;
                target_pos_nav = getclosestpointonnavmesh( target_pos );
                
                if ( !target_pos_nav || distance2d( target_pos, target_pos_nav ) > 100 )
                {
                    target_pos = var_631938ab08153ea3.origin + target_dir * var_2e398834110513e4 * randomfloatrange( 0.1, 0.25 );
                }
            }
            else
            {
                target_pos = var_631938ab08153ea3.origin;
            }
            
            break;
        case #"hash_d72141939fe01ea6":
            if ( !self.arena_center_pos )
            {
                target_pos = target_ent.origin;
                break;
            }
            
            var_e58f0aeccf7df5fe = vectornormalize2( target_ent.origin - self.arena_center_pos );
            var_5164f8ec38e0ff5 = getdvarfloat( @"hash_9b96a15977d5679f", 1200 );
            
            if ( other_params.is_target_close )
            {
                var_5164f8ec38e0ff5 = getdvarfloat( @"hash_332512e30d77a724", 800 );
            }
            
            target_pos = self.arena_center_pos + var_e58f0aeccf7df5fe * var_5164f8ec38e0ff5;
            break;
    }
    
    if ( !target_pos )
    {
        return;
    }
    
    if ( isvector( target_offset ) )
    {
        target_pos += target_offset;
    }
    
    target_pos = utility::drop_to_ground( target_pos, 200, -1000, undefined, physics_createcontents( [ "physicscontents_playerclip" ] ), [ target_ent, target_ent.vehicle ] );
    
    /#
        if ( function_9ffe93b9a4e48fee() )
        {
            sphere( target_pos, 10, ( 1, 0, 0 ) );
            print3d( target_pos, "<dev string:x24>", ( 1, 0, 0 ) );
            
            if ( isvector( target_offset ) )
            {
                line( target_pos - target_offset, target_pos, ( 1, 0, 0 ) );
            }
        }
    #/
    
    return target_pos;
}

// Namespace zombie_hermes_missile
// Params 4, eflags: 0x4
// Checksum 0xebee7162, Offset: 0x17c8
// Size: 0x1bc
function private function_2f5381a0ce1ab124( ent, vel, var_56762fced3b8e6d6, prediction_time_scalar = 1 )
{
    ang_vel_rad = ( math::degrees_to_radians( var_56762fced3b8e6d6[ 0 ] ), math::degrees_to_radians( var_56762fced3b8e6d6[ 1 ] ), math::degrees_to_radians( var_56762fced3b8e6d6[ 2 ] ) );
    ang_vel_rad *= prediction_time_scalar;
    to_circle_edge = vectorcross( ang_vel_rad, vel ) * -1 / lengthsquared( ang_vel_rad );
    circle_center = ent.origin - to_circle_edge;
    var_36eb8f8050a61d76 = length( ang_vel_rad );
    assert( var_36eb8f8050a61d76 > 0 );
    var_543a61e876c93093 = [ 0, math::degrees_to_radians( getdvarfloat( @"hash_af6675f1ad1e05cc", 90 ) ) ];
    predicted_angles = [ 0, math::degrees_to_radians( getdvarfloat( @"hash_452995ac36d13a5e", 250 ) ) ];
    var_47d0aebd6617877 = math::remap( var_36eb8f8050a61d76, var_543a61e876c93093[ 0 ], var_543a61e876c93093[ 1 ], predicted_angles[ 0 ], predicted_angles[ 1 ] );
    var_47d0aebd6617877 = clamp( var_47d0aebd6617877, predicted_angles[ 0 ], predicted_angles[ 1 ] );
    var_a9ab7400646be16c = math::radians_to_degrees( var_47d0aebd6617877 );
    radius_rotated = to_circle_edge * cos( var_a9ab7400646be16c ) + vel * sin( var_a9ab7400646be16c );
    predicted_pos = circle_center + radius_rotated;
    
    /#
        if ( function_9ffe93b9a4e48fee() )
        {
            col = ( 0.5, 0.3, 0 );
            sphere( circle_center, 10, col );
            print3d( circle_center, "<dev string:x37>", col );
            utility::draw_circle( circle_center, length( to_circle_edge ), col );
        }
    #/
    
    return predicted_pos;
}

// Namespace zombie_hermes_missile
// Params 7, eflags: 0x4
// Checksum 0x3595edd6, Offset: 0x198d
// Size: 0x4f3
function private function_2c2df09c995e041a( hermes, origin, target_ent, target_type, target_offset, var_af3256f700014f2f, other_params )
{
    level endon( #"game_ended" );
    
    if ( zombie_hermes_aetheric_energy::is_stunned( hermes ) )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = hermes.hermes_missile_turret.origin + anglestoforward( hermes.hermes_missile_turret.angles ) * 100 + ( 0, 0, getdvarfloat( @"hash_47c777bde50ebb72", 100 ) );
    }
    
    ent = spawn( "script_model", origin );
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent setmodel( "tag_origin" );
    
    /#
        if ( function_9ffe93b9a4e48fee() )
        {
            ent thread draw_missile_target();
        }
    #/
    
    missile_id = function_88c908982514abfb( hermes );
    waitframe();
    waitframe();
    
    if ( !isdefined( hermes.hermes_missile_turret ) )
    {
        if ( ent )
        {
            ent delete();
        }
        
        return;
    }
    
    shoot_turret( hermes, ent, hermes.hermes_missile_turret, missile_id );
    turret_origin = hermes.hermes_missile_turret.origin;
    var_3a60ad0551db5ad9 = getdvarfloat( @"hash_22731ba9dbbb788f", 2 );
    var_d94a8867711faa7a = getdvarfloat( @"hash_3734437dc2b6db34", 1 );
    marker = undefined;
    final_target_pos = undefined;
    offset_dist_inc = 1500;
    accumulated_offset = ( 0, 0, 0 );
    var_cf07ed2025430bbe = gettime() + utility::function_4b74c15943231980( var_d94a8867711faa7a );
    drop_timestamp = gettime() + utility::function_4b74c15943231980( var_3a60ad0551db5ad9 );
    lockon_end_timestamp = drop_timestamp + utility::function_4b74c15943231980( var_af3256f700014f2f ?? 0 );
    var_29b52466896cd8e7 = gettime() + utility::function_4b74c15943231980( var_3a60ad0551db5ad9 * 2 );
    
    if ( var_af3256f700014f2f > 0 && var_cf07ed2025430bbe < lockon_end_timestamp )
    {
        var_cf07ed2025430bbe = lockon_end_timestamp;
    }
    
    if ( var_cf07ed2025430bbe > lockon_end_timestamp )
    {
        var_cf07ed2025430bbe = lockon_end_timestamp;
    }
    
    var_eb76fdd0228017a8 = utility::function_6f5d2e1f1ff70482( var_29b52466896cd8e7 - var_cf07ed2025430bbe );
    prediction_scalar = math::remap( var_eb76fdd0228017a8, 0, 4.5, 0, 2 );
    end_time = max( var_cf07ed2025430bbe, drop_timestamp ) + 100;
    
    while ( gettime() < end_time || ent.origin != final_target_pos )
    {
        should_rise = gettime() < drop_timestamp;
        var_66646fcceb16b26f = gettime() >= drop_timestamp;
        should_lockon = var_66646fcceb16b26f && !isdefined( marker );
        var_c7469d5e45ed1031 = gettime() >= var_cf07ed2025430bbe && !isdefined( marker );
        
        if ( should_rise )
        {
            ent.origin = turret_origin + ( 0, 0, getdvarfloat( @"hash_f5b9b1af3155529", 3000 ) ) + accumulated_offset;
            
            if ( isdefined( ent.missile ) )
            {
                dist_to_target = distance( ent.missile.origin, ent.origin );
                
                if ( dist_to_target < 500 )
                {
                    new_offset = utility::function_9e0df7b136ab833c() * offset_dist_inc;
                    accumulated_offset += new_offset;
                }
            }
        }
        
        if ( var_c7469d5e45ed1031 )
        {
            final_target_pos = function_98b98f0425abe272( target_ent, target_type, target_offset, prediction_scalar, other_params );
            
            if ( final_target_pos )
            {
                marker = function_98ba5a96d62352c0( hermes, final_target_pos );
            }
        }
        else if ( should_lockon )
        {
            final_target_pos = function_98b98f0425abe272( target_ent, target_type, target_offset, prediction_scalar, other_params );
        }
        
        if ( var_66646fcceb16b26f && final_target_pos )
        {
            new_origin = math::function_b642fd3e37ae7eb4( ent.origin, final_target_pos, getdvarfloat( @"hash_9c79e2e80934a9c3", 500 ) );
            
            if ( isdefined( ent.missile ) && isdefined( new_origin ) )
            {
                dist_to_target = distance( ent.missile.origin, new_origin );
                safe_distance = 500;
                
                if ( dist_to_target < safe_distance )
                {
                    new_offset = vectornormalize( new_origin - ent.missile.origin ) * safe_distance;
                    new_origin += new_offset;
                }
            }
            
            if ( new_origin )
            {
                ent.origin = new_origin;
            }
        }
        
        waitframe();
    }
    
    while ( isdefined( ent ) && isdefined( ent.missile ) )
    {
        dist_to_target = distance( ent.origin, ent.missile.origin );
        
        if ( dist_to_target < 300 )
        {
            ent.missile setmagicgrenadecollision( 1 );
        }
        
        waitframe();
    }
    
    while ( isdefined( ent.missile ) )
    {
        waitframe();
    }
    
    ent delete();
    hermes notify( "cleanup_missile_" + missile_id );
    
    if ( isdefined( marker ) )
    {
        marker freescriptable();
    }
}

// Namespace zombie_hermes_missile
// Params 6, eflags: 0x4
// Checksum 0x3ff2ffe1, Offset: 0x1e88
// Size: 0x30d
function private function_85d9d79082b00dee( hermes, origin, target_ent, target_type, target_offset, is_target_close )
{
    if ( zombie_hermes_aetheric_energy::is_stunned( hermes ) )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = hermes.var_8361d0196aa3fa4f.origin + anglestoforward( hermes.var_8361d0196aa3fa4f.angles ) * 100 + ( 0, 0, getdvarfloat( @"hash_47c777bde50ebb72", 100 ) );
    }
    
    ent = spawn( "script_model", origin );
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent setmodel( "tag_origin" );
    
    /#
        if ( function_9ffe93b9a4e48fee() )
        {
            ent thread draw_missile_target();
        }
    #/
    
    prediction_scalar = 0;
    final_target_pos = function_98b98f0425abe272( target_ent, target_type, target_offset, prediction_scalar, { #is_target_close:is_target_close } );
    marker = function_98ba5a96d62352c0( hermes, final_target_pos );
    missile_id = function_88c908982514abfb( hermes );
    
    if ( !isdefined( hermes.var_db7ba2c78b17a0d8 ) )
    {
        hermes.var_db7ba2c78b17a0d8 = [];
    }
    
    hermes.var_db7ba2c78b17a0d8[ hermes.var_db7ba2c78b17a0d8.size ] = missile_id;
    hermes waittill( "fire_missile_" + missile_id );
    missile_id = shoot_turret( hermes, ent, hermes.var_8361d0196aa3fa4f, missile_id );
    turret_origin = hermes.var_8361d0196aa3fa4f.origin;
    end_time = gettime() + 100;
    
    while ( gettime() < end_time || ent.origin != final_target_pos )
    {
        new_origin = math::function_b642fd3e37ae7eb4( ent.origin, final_target_pos, getdvarfloat( @"hash_66700c5520a798d9", 500 ) );
        
        if ( isdefined( ent.missile ) )
        {
            dist_to_target = distance( ent.missile.origin, new_origin );
            safe_distance = 500;
            
            if ( dist_to_target < safe_distance )
            {
                new_offset = vectornormalize( new_origin - ent.missile.origin ) * safe_distance;
                new_origin += new_offset;
            }
        }
        
        ent.origin = new_origin;
        waitframe();
    }
    
    while ( isdefined( ent ) && isdefined( ent.missile ) )
    {
        dist_to_target = distance( ent.origin, ent.missile.origin );
        
        if ( dist_to_target < 500 )
        {
            ent.missile setmagicgrenadecollision( 1 );
        }
        
        waitframe();
    }
    
    while ( isdefined( ent.missile ) )
    {
        waitframe();
    }
    
    ent delete();
    hermes notify( "cleanup_missile_" + missile_id );
    
    if ( isdefined( marker ) )
    {
        marker freescriptable();
    }
}

// Namespace zombie_hermes_missile
// Params 1, eflags: 0x4
// Checksum 0x628c43a8, Offset: 0x219d
// Size: 0x5a
function private function_88c908982514abfb( hermes )
{
    if ( !isdefined( hermes.missile_id ) )
    {
        hermes.missile_id = 0;
    }
    
    hermes.missile_id += 1;
    missile_id = hermes.missile_id;
    return missile_id;
}

// Namespace zombie_hermes_missile
// Params 4, eflags: 0x4
// Checksum 0x73acb109, Offset: 0x2200
// Size: 0xcb
function private shoot_turret( hermes, target_ent, turret, missile_id )
{
    if ( !turret.link_properties.size )
    {
        return;
    }
    
    link_struct = turret.link_properties[ missile_id % turret.link_properties.size ];
    var_4cd753c1f21d1cbc = ( randomfloatrange( link_struct.angle_variation * -1, link_struct.angle_variation ), 0, 0 );
    turret linkto( hermes, link_struct.tag, link_struct.origin_offset, link_struct.angle_offset + var_4cd753c1f21d1cbc );
    thread function_88ef2e8044cd07d8( hermes, target_ent, turret, missile_id );
    turret shootturret();
    return missile_id;
}

// Namespace zombie_hermes_missile
// Params 4, eflags: 0x4
// Checksum 0x5270e9fa, Offset: 0x22d4
// Size: 0xe7
function private function_88ef2e8044cd07d8( hermes, target_ent, turret, missile_id )
{
    hermes endon( #"death" );
    hermes endon( "cleanup_missile_" + missile_id );
    turret waittill( #"turret_fire", missile );
    
    if ( isdefined( missile ) )
    {
        missile utility::function_32b24db3127bff40( "launch", "active" );
        missile utility::function_32b24db3127bff40( "trail", "active" );
        missile missile_settargetent( target_ent );
        missile setmagicgrenadecollision( 0 );
        target_ent.missile = missile;
        missile.owner = hermes;
        missile.ignore_turtle_shell = 1;
        missile endon( #"death" );
        hermes waittill( #"hash_ce9a5bbc5b4c6bd" );
        
        if ( missile )
        {
            missile delete();
        }
    }
}

// Namespace zombie_hermes_missile
// Params 1, eflags: 0x4
// Checksum 0xef258d14, Offset: 0x23c3
// Size: 0x62
function private function_9521404c516da58c( hermes )
{
    target = hermes.enemy;
    
    if ( hermes utility::ent_flag( "head_state_recently_changed" ) )
    {
        target = hermes.var_8e5c74439fd70703 ?? target;
    }
    
    if ( target.vehicletype )
    {
        target = target.owner;
    }
    
    return target;
}

// Namespace zombie_hermes_missile
// Params 1
// Checksum 0x30da6dd8, Offset: 0x242e
// Size: 0x17
function get_big_missile_target( hermes )
{
    return hermes.var_5c1f307efe50278a;
}

// Namespace zombie_hermes_missile
// Params 3, eflags: 0x4
// Checksum 0x5405406c, Offset: 0x244e
// Size: 0x284
function private function_3ec31c3bdcc032cf( hermes, target, is_target_close )
{
    var_ee6433c31961982d = vectornormalize2( target.origin - hermes.origin );
    to_target_right = vectorcross( var_ee6433c31961982d, ( 0, 0, 1 ) );
    density_dist = getdvarfloat( @"hash_2cdf127ef5fe9166", 400 );
    offsets = [ ( 0, 0, 0 ) ];
    
    if ( !is_target_close )
    {
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist * 2;
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist * 3;
    }
    else
    {
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist * -1;
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist * -2;
        offsets[ offsets.size ] = var_ee6433c31961982d * density_dist * -3;
    }
    
    side_i = -1;
    
    while ( side_i <= 1 )
    {
        if ( !is_target_close )
        {
            offsets[ offsets.size ] = to_target_right * density_dist * side_i + var_ee6433c31961982d * density_dist * 2;
            offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2 + var_ee6433c31961982d * density_dist * 2;
        }
        else
        {
            offsets[ offsets.size ] = to_target_right * density_dist * side_i + var_ee6433c31961982d * density_dist * -2;
            offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2 + var_ee6433c31961982d * density_dist * -2;
        }
        
        offsets[ offsets.size ] = to_target_right * density_dist * side_i;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 3;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 4;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 1.5 - var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2.5 - var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2 - var_ee6433c31961982d * density_dist * 2;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 3 - var_ee6433c31961982d * density_dist * 2;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 1.5 + var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 2.5 + var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 3.5 + var_ee6433c31961982d * density_dist;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 3 + var_ee6433c31961982d * density_dist * 2;
        offsets[ offsets.size ] = to_target_right * density_dist * side_i * 3.5 - var_ee6433c31961982d * density_dist;
        side_i += 2;
    }
    
    return offsets;
}

// Namespace zombie_hermes_missile
// Params 5, eflags: 0x4
// Checksum 0x76efd3a4, Offset: 0x26db
// Size: 0x356
function private function_27e45ab205de1957( damage, attacker, weapon, mod, vpoint )
{
    original_damage = damage;
    
    if ( isexplosivedamagemod( mod ) || mod == "MOD_IMPACT" )
    {
        var_f1b807e36f506e21 = distance2d( vpoint, self.origin );
        
        if ( self.vehicle )
        {
            if ( !self.var_da9b6be11a3d40b6 )
            {
                damage = 0;
            }
            
            if ( vehicle_occupancy::get_driver( self.vehicle, 1 ) === self )
            {
                damage *= 0.4;
                
                if ( attacker.var_1f06e3db65f4de8c )
                {
                    damage *= attacker.var_1f06e3db65f4de8c;
                }
            }
            else if ( self isinvehicleleanout() )
            {
                damage *= 0.75;
            }
            else
            {
                damage *= attacker.var_15b3c7c5e5bc403a ?? 0.25;
                
                if ( utility::ent_flag( "hermes_vehice_passenger_safe_from_damage" ) )
                {
                    damage = 0;
                }
            }
            
            if ( var_f1b807e36f506e21 > 150 )
            {
                damage *= 0.25;
            }
            
            if ( self.vehicle.var_e2c27eded7998a2c && !utility::time_has_passed( self.vehicle.var_e2c27eded7998a2c, 10 ) )
            {
                damage *= 0.25;
            }
            
            /#
                if ( function_9ffe93b9a4e48fee() )
                {
                    line( self.origin, vpoint, ( 1, 0, 0 ) );
                    print3d( vpoint, "<dev string:x55>" + var_f1b807e36f506e21, ( 1, 0, 0 ) );
                    iprintlnbold( "<dev string:x5c>" + var_f1b807e36f506e21 );
                }
            #/
        }
        else if ( utility::ent_flag( "hermes_exit_vehicle_recently" ) )
        {
            damage *= 0.5;
        }
        else
        {
            is_low_health = self.health / self.maxhealth < 0.5;
            var_17dbb6bcf8f146bd = self.armorhealth <= 0 && self.maxhealth <= 150;
            var_afca370e0ee2aca5 = ( !attacker.var_e3369664b5e43878 || utility::time_has_passed( attacker.var_e3369664b5e43878, 1 ) ) && !attacker utility::ent_flag( "hermes_big_missile_attack" );
            
            if ( ( is_low_health || var_17dbb6bcf8f146bd ) && var_afca370e0ee2aca5 && !self.var_bd523ebcb3040531 )
            {
                if ( var_f1b807e36f506e21 > 150 )
                {
                    damage = 0;
                }
                
                /#
                    if ( function_9ffe93b9a4e48fee() )
                    {
                        line( self.origin, vpoint, ( 1, 0, 0 ) );
                        print3d( vpoint, "<dev string:x55>" + var_f1b807e36f506e21, ( 1, 0, 0 ) );
                    }
                #/
            }
        }
        
        earthquake_scalar = 1;
        
        if ( !self.vehicle || vehicle_occupancy::get_driver( self.vehicle, 1 ) === self )
        {
            if ( damage < original_damage )
            {
                self playrumbleonentity( "damage_med" );
                self function_1424d4f7ff5404c5( 0.2 * earthquake_scalar, 0.1 * earthquake_scalar, 0.05 * earthquake_scalar, 0.5, vpoint, 50, 300, 600 );
            }
            else
            {
                self playrumbleonentity( "damage_heavy" );
                self earthquakeforplayer( 0.5 * earthquake_scalar, 0.5, vpoint, 600 );
            }
        }
    }
    
    return damage;
}

// Namespace zombie_hermes_missile
// Params 0, eflags: 0x4
// Checksum 0x69129f03, Offset: 0x2a3a
// Size: 0x12, Type: bool
function private function_9ffe93b9a4e48fee()
{
    return getdvarint( @"hash_127f3147ce2034df", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_missile
    // Params 0, eflags: 0x4
    // Checksum 0x2cc742f2, Offset: 0x2a55
    // Size: 0x131, Type: dev
    function private function_ae00e9fafdcbd63d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6b>" );
        devgui::add_devgui_func( "<dev string:x83>", "<dev string:x91>", &function_621287b438b36981, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa6>", "<dev string:xbb>" + "<dev string:xd1>", &function_5e7057c6d76bfd3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdf>", "<dev string:xbb>" + "<dev string:xf5>", &function_5e7057c6d76bfd3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x104>", "<dev string:xbb>" + "<dev string:x127>", &function_5e7057c6d76bfd3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13e>", "<dev string:xbb>" + "<dev string:xd1>" + "<dev string:x15c>", &function_5e7057c6d76bfd3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15f>", "<dev string:xbb>" + "<dev string:xf5>" + "<dev string:x15c>", &function_5e7057c6d76bfd3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17e>", "<dev string:x1be>", &function_2949633382cf1b8e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1dd>", "<dev string:x211>", &function_ed4d76487c311b9c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x236>", "<dev string:x254>", &function_1fb7f0844ef82063 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x279>", "<dev string:x2a0>", &function_ee758d6c7ab364f7 );
        devgui::function_77df7fe7dd273e10();
        
        if ( function_9ffe93b9a4e48fee() )
        {
            level thread function_7701898380a9ed18();
        }
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0x31a74101, Offset: 0x2b8e
    // Size: 0x44, Type: dev
    function private function_621287b438b36981( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x2c8>", @"hash_127f3147ce2034df" );
        
        if ( function_9ffe93b9a4e48fee() )
        {
            level thread function_7701898380a9ed18();
            return;
        }
        
        level notify( #"hash_eaba9cf72d34d13f" );
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0xbe601072, Offset: 0x2bda
    // Size: 0xd1, Type: dev
    function private function_5e7057c6d76bfd3e( params )
    {
        type = params[ 0 ];
        with_lockon = params[ 1 ] ? int( params[ 1 ] ) > 0 : 0;
        missile = undefined;
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
        target_pos = level.players[ 0 ].origin;
        target_ent = level.players[ 0 ];
        hermes thread function_2c2df09c995e041a( hermes, undefined, target_ent, type, undefined, with_lockon ? getdvarfloat( @"hash_e9ca26f1cb721070", 0.4 ) : undefined );
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0xc6128842, Offset: 0x2cb3
    // Size: 0x7a, Type: dev
    function private function_2949633382cf1b8e( params )
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
        target_pos = level.players[ 0 ].origin;
        target_ent = level.players[ 0 ];
        function_d507eef555f214a2( hermes, target_ent );
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0xbd036f18, Offset: 0x2d35
    // Size: 0x7a, Type: dev
    function private function_ed4d76487c311b9c( params )
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
        target_pos = level.players[ 0 ].origin;
        target_ent = level.players[ 0 ];
        function_1acf062f485f2539( hermes, target_ent );
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0x8b8b051f, Offset: 0x2db7
    // Size: 0x45, Type: dev
    function private function_1fb7f0844ef82063( params )
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
        launch_missile_waves( hermes );
    }

    // Namespace zombie_hermes_missile
    // Params 1, eflags: 0x4
    // Checksum 0x67b6ee7, Offset: 0x2e04
    // Size: 0x6b, Type: dev
    function private function_ee758d6c7ab364f7( params )
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
        target_ent = level.players[ 0 ];
        function_407aaf6549225095( hermes, target_ent );
        wait 4;
        hermes notify( #"hermes_fire_big_missile_queue" );
    }

    // Namespace zombie_hermes_missile
    // Params 0, eflags: 0x4
    // Checksum 0x9809de0c, Offset: 0x2e77
    // Size: 0x45, Type: dev
    function private draw_missile_target()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( !function_9ffe93b9a4e48fee() )
            {
                waitframe();
                continue;
            }
            
            sphere( self.origin, 10, ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace zombie_hermes_missile
    // Params 0, eflags: 0x4
    // Checksum 0x1e568d9c, Offset: 0x2ec4
    // Size: 0x52, Type: dev
    function private function_7701898380a9ed18()
    {
        level endon( #"hash_eaba9cf72d34d13f" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2dd>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

#/
