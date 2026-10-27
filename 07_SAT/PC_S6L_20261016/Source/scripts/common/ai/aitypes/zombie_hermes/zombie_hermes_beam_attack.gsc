// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_beam_attack.gsc  (hash_011e4121d8dd508f.gscc) (size: 12331 Bytes / 0x302b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x89dcc5ff (2312947199)
// size ...... 12331 (0x302b)
// includes .. 10  (offset: 0x2d87)
// strings ... 32  (offset: 0x2dd7)
// dev strs .. 10  (offset: 0x2faf)
// exports ... 24  (offset: 0x1d53)
// cseg ...... 0x2cd + 0x1a86 (0x1d53)
// imports ... 99  (offset: 0x2113)
// animtree1 . 0   (offset: 0x302b)
// animtree2 . 0   (offset: 0x302b)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace zombie_hermes_beam_attack;

// Namespace zombie_hermes_beam_attack
// Params 1
// Checksum 0xdb53af96, Offset: 0x2eb
// Size: 0x3d
function init_beam_attack_precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "hermes_beam_vfx", settings.beamvfx );
    }
}

// Namespace zombie_hermes_beam_attack
// Params 0
// Checksum 0x71b99624, Offset: 0x330
// Size: 0xc2
function init_zombie_hermes_beam()
{
    self.hermes_beam = undefined;
    self.var_425631ac00d4c968 = spawn( "script_model", self.origin );
    self.var_425631ac00d4c968 setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f4615ecafed1394d );
    thread utility::delete_on_death( self.var_425631ac00d4c968 );
    self.var_a3cc86d40e6324d8 = spawn( "script_model", self.origin );
    self.var_a3cc86d40e6324d8 setmodel( "tag_origin" );
    thread utility::delete_on_death( self.var_a3cc86d40e6324d8 );
    self.var_a48163c16d11e1b1 = &function_623021c0cbd61e82;
    self.var_ed249d811e1a617b = 0;
    
    /#
        function_e3ff349de845c538();
    #/
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0xd9898a0a, Offset: 0x3fa
// Size: 0x71
function function_654beea3d555c3e0( taskid, params )
{
    if ( getdvarint( @"hash_568ab0ad9ede984e", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( getdvarint( @"hash_26afea0b2c9943e5", 0 ) > 0 )
    {
        return anim.failure;
    }
    
    if ( self.var_3196011060b46013 != 3 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0x2a6fe2a9, Offset: 0x474
// Size: 0x103
function function_e93e0c197f13292a( taskid, params )
{
    ent = self.enemy;
    
    if ( !isdefined( ent ) )
    {
        return anim.failure;
    }
    
    if ( getdvarint( @"hash_568ab0ad9ede984e", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( getdvarint( @"hash_26afea0b2c9943e5", 0 ) > 0 )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_50784dd4712a9afe )
    {
        return anim.failure;
    }
    
    if ( self.var_3196011060b46013 != 3 )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_gamera_spin" ) )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_new_phase_set_recently" ) )
    {
        return anim.failure;
    }
    
    head = function_a9a35e4caaf967d4();
    
    if ( !isdefined( head ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0xe1e385d6, Offset: 0x580
// Size: 0x138
function function_42b958853c0a929b( taskid, params )
{
    ent = self.enemy;
    
    if ( !isdefined( ent ) )
    {
        return anim.failure;
    }
    
    charge_time = getdvarint( @"hash_2a64048e75c66c5", 10000 );
    min_failed_attempts = 2;
    
    if ( self.var_ed249d811e1a617b > min_failed_attempts )
    {
        min_charge_time = getdvarint( @"hash_c7b62c95a7d3461a", 5000 );
        var_62e800b6ade49a0b = getdvarint( @"hash_e53d923b08dcbe05", 1500 );
        charge_time = clamp( charge_time - var_62e800b6ade49a0b * ( self.var_ed249d811e1a617b - min_failed_attempts ), min_charge_time, charge_time );
    }
    
    self.var_32335744efc85bef = gettime() + charge_time;
    self.var_8bcf69dec50b01c9 = function_a9a35e4caaf967d4();
    
    if ( !self.var_8bcf69dec50b01c9 )
    {
        return anim.failure;
    }
    
    asm::function_7256f5ba459c840b( "beam_attack_in" );
    self function_786bb6aa1b76c7ee( "in_beam_charge", 1 );
    utility::function_7c10ea82c1e305b8( self.var_8bcf69dec50b01c9 + "_beam", "charge" );
    function_776d4b87249cbbbf();
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0x28bbdae1, Offset: 0x6c1
// Size: 0x235
function function_1529aea53b264e2c( taskid, params )
{
    ent = self.enemy;
    
    if ( !isdefined( ent ) )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "hermes_stunned" ) > 0 )
    {
        return anim.failure;
    }
    
    if ( self.var_a1b7a38728db98eb && !utility::time_has_passed( self.var_a1b7a38728db98eb, 0.1 ) )
    {
        return anim.failure;
    }
    
    if ( !zombie_hermes_metabones::function_579ea20e41126f88( self.var_8bcf69dec50b01c9 ) )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_32335744efc85bef )
    {
        target_angles = vectortoangles( ent.origin - self.origin );
        head_tag = zombie_hermes_metabones::get_head_tag( self.var_8bcf69dec50b01c9 );
        head_yaw = self gettagangles( head_tag )[ 1 ];
        beam_source_angles = head_yaw;
        diff = angleclamp180( target_angles[ 1 ] - beam_source_angles );
        diff_sign = utility::sign( diff );
        turnrate = getdvarfloat( @"hash_3d39e1dbd4ab7dbc", 30 );
        slowdown_angle_threshold = 5;
        turnrate *= clamp( math::remap( abs( diff ), 0, slowdown_angle_threshold, 0.1, 1 ), 0.1, 1 );
        new_yaw = self.angles[ 1 ] + diff_sign * turnrate * level.framedurationseconds;
        new_angles = ( self.angles[ 0 ], new_yaw, self.angles[ 2 ] );
        self forceteleport( self.origin, new_angles );
        
        /#
            if ( debug_beam() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x24>" + self.var_32335744efc85bef - gettime(), ( 1, 0, 0 ) );
            }
        #/
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0x5bbf9225, Offset: 0x8ff
// Size: 0xaf
function function_cfa9918d0ed89a9c( taskid, params )
{
    if ( gettime() >= self.var_32335744efc85bef )
    {
        self.var_ed249d811e1a617b = 0;
    }
    else
    {
        beam_cooldown = getdvarfloat( @"hermes_beam_cooldown", 5000 );
        self.var_50784dd4712a9afe = gettime() + beam_cooldown;
        
        if ( !self.var_bba8c3d43b9de7d7 )
        {
            self.var_ed249d811e1a617b++;
        }
    }
    
    self.var_32335744efc85bef = undefined;
    self function_f2df0257c63f229( "in_beam_charge" );
    utility::function_7c10ea82c1e305b8( self.var_8bcf69dec50b01c9 + "_beam", "off" );
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0xc9edd80c, Offset: 0x9b7
// Size: 0x128
function function_277ddf05ff26042f( taskid, params )
{
    beam_time = getdvarint( @"hermes_beam_time", 7000 );
    self.var_3bc73d5ea0f7027c = gettime() + beam_time;
    self.var_286a36ad72c54d05 = gettime();
    self.var_e8beaa83c3e74bb6 = getdvarfloat( @"hash_990ae64055ab7f96", 1 );
    self.hermes_rotation_speed = self.var_e8beaa83c3e74bb6;
    self.var_f598ad1d18862980 = 0;
    self.var_684ae2a15cda892c = 0.01;
    self.var_2f0f901ad6e6e5bd = 1;
    level callback::callback( "vo_shadow_soul_beam_attack" );
    utility::ent_flag_set( "hermes_beaming" );
    self function_786bb6aa1b76c7ee( "in_beam_attack", 1 );
    utility::function_7c10ea82c1e305b8( self.var_8bcf69dec50b01c9 + "_beam", "on" );
    
    if ( !isdefined( self.var_8bcf69dec50b01c9 ) )
    {
        self.var_8bcf69dec50b01c9 = function_a9a35e4caaf967d4();
    }
    
    if ( !self.var_8bcf69dec50b01c9 )
    {
        return anim.failure;
    }
    
    thread utility::delaythread( 0.3, &start_beam );
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0xd7e435a3, Offset: 0xae8
// Size: 0x4b3
function function_e21d973452111ef0( taskid, params )
{
    if ( utility::ent_flag( "hermes_gamera_spin" ) )
    {
        return anim.failure;
    }
    
    if ( !self tagexists( zombie_hermes_metabones::get_head_tag( self.var_8bcf69dec50b01c9 ) ) )
    {
        return anim.failure;
    }
    
    if ( !zombie_hermes_metabones::function_579ea20e41126f88( self.var_8bcf69dec50b01c9 ) )
    {
        return anim.failure;
    }
    
    if ( self.hermes_beam && self.hermes_beam.should_end )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_3bc73d5ea0f7027c )
    {
        var_4c1cb74fbd599725 = self;
        self.var_e8beaa83c3e74bb6 = getdvarfloat( @"hash_990ae64055ab7f96", 6 );
        self.var_e89abc83c3bef894 = getdvarfloat( @"hash_c7c99851887440dd", 1 );
        accel = getdvarfloat( @"hash_763e709c1f766c05", 1 );
        target_angles = undefined;
        diff_sign = 1;
        ent = function_e8b70ddc1ddd4be1( self );
        
        if ( ent )
        {
            moving_platform_parent = isplayer( ent ) ? ent getmovingplatformparent() : undefined;
            var_e88477d7eb370d4a = ent.vehicle || ent.vehicletype;
            
            if ( utility::ent_flag( "hermes_beam_hit_player_recently" ) && var_e88477d7eb370d4a )
            {
                accel = getdvarfloat( @"hash_c8b19e9399cf006f", 0.5 );
            }
            
            var_b12f7f2b8b9c73d7 = distance2d( ent.origin, self.origin );
            
            if ( var_b12f7f2b8b9c73d7 < 500 )
            {
                accel *= 3;
            }
            
            self.var_684ae2a15cda892c = accel;
            var_76ccb7468438a569 = math::remap( var_b12f7f2b8b9c73d7, 500, 1500, self.var_e8beaa83c3e74bb6, self.var_e89abc83c3bef894 );
            target_rotation_speed = clamp( var_76ccb7468438a569, self.var_e89abc83c3bef894, self.var_e8beaa83c3e74bb6 );
            target_angles = vectortoangles( ent.origin - var_4c1cb74fbd599725.origin );
            head_tag = zombie_hermes_metabones::get_head_tag( self.var_8bcf69dec50b01c9 );
            head_yaw = self gettagangles( head_tag )[ 1 ];
            beam_source_angles = head_yaw + getdvarfloat( @"hash_be5f2d73951367e4", 0 );
            diff = angleclamp180( target_angles[ 1 ] - beam_source_angles );
            diff_sign = utility::sign( diff );
            slowdown_angle_threshold = getdvarfloat( @"hash_d82582c9ef398186", 5 );
            target_rotation_speed *= clamp( math::remap( abs( diff ), 0, slowdown_angle_threshold, 0.1, 1 ), 0.1, 1 );
            
            if ( ent.vehicle && ent.vehicle isboosting() )
            {
                target_rotation_speed *= getdvarfloat( @"hash_19c0ca14054c3bed", 0.1 );
            }
        }
        else
        {
            target_rotation_speed = 0;
        }
        
        self.var_f598ad1d18862980 += diff_sign * self.var_684ae2a15cda892c;
        
        if ( abs( self.var_f598ad1d18862980 ) > target_rotation_speed )
        {
            self.var_f598ad1d18862980 = math::function_b77296185c2d6c26( self.var_f598ad1d18862980, diff_sign * target_rotation_speed, self.var_684ae2a15cda892c );
        }
        
        new_yaw = var_4c1cb74fbd599725.angles[ 1 ] + self.var_f598ad1d18862980;
        
        if ( target_angles )
        {
            if ( anglesdelta( ( 0, new_yaw, 0 ), ( 0, target_angles[ 1 ], 0 ) ) <= abs( self.var_f598ad1d18862980 ) )
            {
                new_yaw = target_angles[ 1 ];
            }
        }
        
        new_angles = ( var_4c1cb74fbd599725.angles[ 0 ], new_yaw, var_4c1cb74fbd599725.angles[ 2 ] );
        var_4c1cb74fbd599725 forceteleport( var_4c1cb74fbd599725.origin, new_angles );
        var_313395549b5025e1 = abs( new_yaw - var_4c1cb74fbd599725.angles[ 1 ] );
        self.hermes_rotation_speed = min( self.hermes_rotation_speed, var_313395549b5025e1 );
        self.hermes_rotation_speed = min( self.hermes_rotation_speed + self.var_684ae2a15cda892c, self.var_e8beaa83c3e74bb6 );
        
        /#
            if ( debug_beam() )
            {
                print3d( var_4c1cb74fbd599725.origin + ( 0, 0, 200 ), "<dev string:x41>" + var_313395549b5025e1, ( 1, 0, 0 ) );
            }
        #/
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 2
// Checksum 0x4893766b, Offset: 0xfa4
// Size: 0x172
function function_ad6499e7e48cbc78( taskid, params )
{
    self notify( #"hermes_beam_attack_terminate" );
    beam_cooldown = getdvarfloat( @"hermes_beam_cooldown", 5000 );
    var_d244414fcb33ce3 = 0;
    nearby_vehicles = vehicle_getarrayinradius( self.origin, 2000 );
    
    foreach ( vehicle in nearby_vehicles )
    {
        if ( vehicle utility::function_9f2c41c1dcc8c94( "single", "vehicle_unusable" ) )
        {
            var_d244414fcb33ce3 = 1;
            continue;
        }
        
        var_d244414fcb33ce3 = 0;
        break;
    }
    
    if ( var_d244414fcb33ce3 )
    {
        beam_cooldown = getdvarfloat( @"hash_115b32b4cfe4d17a", 7000 );
    }
    
    self.var_50784dd4712a9afe = gettime() + beam_cooldown;
    utility::function_7c10ea82c1e305b8( self.var_8bcf69dec50b01c9 + "_beam", "off" );
    self.var_425631ac00d4c968 utility::function_32b24db3127bff40( "beam_target", "beam_target_off" );
    utility::ent_flag_clear( "hermes_beaming" );
    self function_786bb6aa1b76c7ee( "in_beam_attack", 0 );
    self.var_8bcf69dec50b01c9 = undefined;
    return anim.success;
}

// Namespace zombie_hermes_beam_attack
// Params 0, eflags: 0x4
// Checksum 0x799e884f, Offset: 0x111f
// Size: 0x135
function private start_beam()
{
    if ( !self.var_8bcf69dec50b01c9 )
    {
        return;
    }
    
    self.var_425631ac00d4c968 thread function_efe22a3acd67eefb( self );
    self.var_425631ac00d4c968 utility::function_32b24db3127bff40( "beam_target", "beam_target_on" );
    function_776d4b87249cbbbf();
    self.hermes_beam = playfxontagsbetweenclients( utility::getfx( "hermes_beam_vfx" ), self.var_a3cc86d40e6324d8, "tag_origin", self.var_425631ac00d4c968, "tag_origin" );
    
    if ( isdefined( self.hermes_beam ) )
    {
        self.hermes_beam namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
        self.hermes_beam.source_ent = self.var_a3cc86d40e6324d8;
        self.hermes_beam.target_ent = self.var_425631ac00d4c968;
        
        if ( !isdefined( level.var_799248d6e9435274 ) )
        {
            level.var_799248d6e9435274 = [];
        }
        
        level.var_799248d6e9435274[ level.var_799248d6e9435274.size ] = self.hermes_beam;
        level.var_799248d6e9435274 = function_5713d46873b29625( level.var_799248d6e9435274 );
        thread utility::function_9a9165839779317f( self.hermes_beam, "hermes_beam_attack_terminate" );
    }
    
    thread function_fe79601f51c095e9();
}

// Namespace zombie_hermes_beam_attack
// Params 1
// Checksum 0x8e656428, Offset: 0x125c
// Size: 0xb2
function function_e8b70ddc1ddd4be1( hermes )
{
    enemies = hermes function_f017e352a29a57a1( hermes.origin, 4000, 1 );
    
    foreach ( enemy in enemies )
    {
        if ( isdefined( enemy.vehicle ) )
        {
            return enemy;
        }
    }
    
    return hermes.enemy;
}

// Namespace zombie_hermes_beam_attack
// Params 1, eflags: 0x4
// Checksum 0x3c76b06f, Offset: 0x1317
// Size: 0x286
function private function_efe22a3acd67eefb( hermes )
{
    self endon( #"death" );
    hermes endon( #"hermes_beam_attack_terminate" );
    beam_length_max = getdvarfloat( @"hash_8daee7115f003f3a", 3000 );
    aim_offset = getdvarfloat( @"hash_acb23a1246954e61", 100 );
    var_273d51c17a5acf2 = beam_length_max;
    
    while ( true )
    {
        var_4c1cb74fbd599725 = hermes;
        
        if ( self.var_969b18d02e2ae5a5 && !utility::time_has_passed( self.var_969b18d02e2ae5a5, 0.25 ) )
        {
            self.origin = math::function_b642fd3e37ae7eb4( self.origin, self.var_c27c2431c8cafacc.origin, self.var_e36f197d6f01c100 * level.framedurationseconds );
        }
        else
        {
            var_a648afea39238b85 = function_e8b70ddc1ddd4be1( hermes );
            
            if ( isdefined( var_a648afea39238b85 ) )
            {
                var_b3dd8eee90061464 = math::remap( gettime(), hermes.var_286a36ad72c54d05, hermes.var_3bc73d5ea0f7027c, aim_offset * -1, aim_offset );
                var_273d51c17a5acf2 = min( distance2d( hermes.var_a3cc86d40e6324d8.origin, var_a648afea39238b85.origin ) + var_b3dd8eee90061464, beam_length_max );
            }
            
            if ( hermes.var_8bcf69dec50b01c9 )
            {
                forward_angles = hermes gettagangles( zombie_hermes_metabones::get_head_tag( hermes.var_8bcf69dec50b01c9 ) );
                var_b97c5d609b2c2cdb = ( 0, forward_angles[ 1 ], 0 );
                var_2432d72d93c0e6f9 = hermes.var_a3cc86d40e6324d8.origin + anglestoforward( var_b97c5d609b2c2cdb ) * var_273d51c17a5acf2 + ( 0, 0, 0 );
                var_2432d72d93c0e6f9 = ( var_2432d72d93c0e6f9[ 0 ], var_2432d72d93c0e6f9[ 1 ], var_a648afea39238b85.origin[ 2 ] ?? var_2432d72d93c0e6f9[ 2 ] );
                trace = trace::sphere_trace( hermes.var_a3cc86d40e6324d8.origin, var_2432d72d93c0e6f9, 30, hermes.hermes_brush_model[ "hermes_script_brushmodel" ] );
                trace_pos = trace[ "position" ];
                new_z = math::function_b77296185c2d6c26( self.origin[ 2 ], trace_pos[ 2 ], getdvarfloat( @"hash_76cfc7ebe4806be7", 300 ) * level.framedurationseconds );
                self.origin = ( trace_pos[ 0 ], trace_pos[ 1 ], new_z );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_beam_attack
// Params 0, eflags: 0x4
// Checksum 0x46a8c12c, Offset: 0x15a5
// Size: 0x29
function private function_a9a35e4caaf967d4()
{
    attached_heads = zombie_hermes_metabones::get_attached_heads( self );
    head = utility::array_random( attached_heads );
    return head;
}

// Namespace zombie_hermes_beam_attack
// Params 0, eflags: 0x4
// Checksum 0x36a02dc7, Offset: 0x15d7
// Size: 0x9e
function private function_776d4b87249cbbbf()
{
    self.var_a3cc86d40e6324d8 delete();
    self.var_a3cc86d40e6324d8 = spawn( "script_model", self.origin );
    self.var_a3cc86d40e6324d8 setmodel( "tag_origin" );
    thread utility::delete_on_death( self.var_a3cc86d40e6324d8 );
    head_tag = zombie_hermes_metabones::get_head_tag( self.var_8bcf69dec50b01c9 );
    
    if ( self tagexists( head_tag ) )
    {
        self.var_a3cc86d40e6324d8 linkto( self, head_tag, ( 20, 0, -40 ), ( 0, 0, 0 ) );
    }
}

// Namespace zombie_hermes_beam_attack
// Params 0, eflags: 0x4
// Checksum 0x2cac86b7, Offset: 0x167d
// Size: 0x370
function private function_fe79601f51c095e9()
{
    self endon( #"death" );
    self endon( #"hermes_beam_attack_terminate" );
    hermes = self;
    
    while ( true )
    {
        start = hermes.var_a3cc86d40e6324d8.origin;
        end = hermes.var_425631ac00d4c968.origin;
        contents = physics_createcontents( [ "physicscontents_vehicle", "physicscontents_characterproxy" ] );
        spherecasts = physics_spherecast( start, end, getdvarfloat( @"hermes_beam_radius", 100 ), contents, hermes, "physicsquery_all" );
        
        foreach ( spherecast in spherecasts )
        {
            ent = spherecast[ "entity" ];
            
            if ( ent.team == hermes.team )
            {
                continue;
            }
            
            if ( !isplayer( ent ) && !isai( ent ) && !issentient( ent ) && !ent.vehicletype )
            {
                continue;
            }
            
            if ( ent utility::ent_flag( "hermes_beam_hit" ) )
            {
                continue;
            }
            
            if ( isplayer( ent ) && !ent.vehicle )
            {
                cover_dist = 100;
                to_ai = vectornormalize( hermes.origin - ent geteye() );
                var_f5f71542ab259af5 = trace::ray_trace( ent geteye(), ent geteye() + to_ai * cover_dist );
                
                if ( var_f5f71542ab259af5[ "fraction" ] < 1 )
                {
                    continue;
                }
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                var_11973dfc7ae09bbd = distance( pointonsegmentnearesttopoint( start, end, ent.origin ), ent.origin );
                var_4193955b25309ca2 = ent vehicle_getspeed() < 10 ? 170 : 100;
                
                if ( var_11973dfc7ae09bbd > var_4193955b25309ca2 )
                {
                    continue;
                }
            }
            
            var_f170b524015f6863 = get_beam_damage( self, ent );
            ent dodamage( var_f170b524015f6863, spherecast[ "position" ], hermes, undefined, "MOD_PROJECTILE" );
            ent utility::ent_flag_set( "hermes_beam_hit" );
            ent thread utility::ent_flag_clear_delayed( "hermes_beam_hit", getdvarfloat( @"hash_6e61d930ed881d6e", 0.35 ) );
            
            if ( ent.vehicletype )
            {
                force_dir = vectornormalize( end - start );
                force_magnitude = getdvarfloat( @"hash_90882467c2c959f2", 2000000 );
                force_pos = ( 0, 0, 0 );
                force = force_dir * force_magnitude;
                
                if ( lengthsquared( force ) > 0 )
                {
                    ent vehphys_force( force, force_pos, 0.1 );
                }
            }
            
            if ( isplayer( ent ) && !hermes utility::ent_flag( "hermes_beam_hit_player_recently" ) )
            {
                hermes utility::ent_flag_set( "hermes_beam_hit_player_recently" );
                hermes thread utility::ent_flag_clear_delayed( "hermes_beam_hit_player_recently", 2 );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_beam_attack
// Params 2, eflags: 0x4
// Checksum 0xd174b181, Offset: 0x19f5
// Size: 0x8c
function private get_beam_damage( hermes, target_ent )
{
    if ( target_ent.vehicle )
    {
        if ( target_ent utility::ent_flag( "hermes_vehice_passenger_safe_from_damage" ) )
        {
            return 0;
        }
        
        if ( target_ent isinvehicleleanout() )
        {
            return getdvarfloat( @"hash_4ea9d7029428dadc", 50 );
        }
        
        return getdvarfloat( @"hash_e23dee504974bcaf", 20 );
    }
    
    if ( target_ent.vehicletype )
    {
        return getdvarfloat( @"hash_220df6c1cea4495d", 500 );
    }
    
    return getdvarfloat( @"hermes_beam_damage", 50 );
}

// Namespace zombie_hermes_beam_attack
// Params 4, eflags: 0x4
// Checksum 0x3fe0a89d, Offset: 0x1a8a
// Size: 0x40
function private function_623021c0cbd61e82( damageabsorbed, attacker, inflictor, smeansofdeath )
{
    if ( attacker utility::ent_flag( "hermes_beaming" ) )
    {
        damageabsorbed *= 3;
    }
    
    return damageabsorbed;
}

// Namespace zombie_hermes_beam_attack
// Params 0, eflags: 0x4
// Checksum 0xeb3a70a7, Offset: 0x1ad3
// Size: 0x12, Type: bool
function private debug_beam()
{
    return getdvarint( @"hash_36e78873fefdb22a", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_beam_attack
    // Params 0, eflags: 0x4
    // Checksum 0xfa55e1dd, Offset: 0x1aee
    // Size: 0x59, Type: dev
    function private function_e3ff349de845c538()
    {
        devgui::function_9082edeb5db93280( "<dev string:x50>" );
        devgui::add_devgui_func( "<dev string:x68>", "<dev string:x73>", &function_6149f34c5e04867c, 1 );
        devgui::add_devgui_func( "<dev string:x85>", "<dev string:x90>", &function_511980a4b2a22c68, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_beam() )
        {
            level thread function_2a5e3f3fecf1249f();
        }
    }

    // Namespace zombie_hermes_beam_attack
    // Params 1, eflags: 0x4
    // Checksum 0x12d51a4c, Offset: 0x1b4f
    // Size: 0x44, Type: dev
    function private function_6149f34c5e04867c( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa2>", @"hash_36e78873fefdb22a" );
        
        if ( debug_beam() )
        {
            level thread function_2a5e3f3fecf1249f();
            return;
        }
        
        level notify( #"hash_24d7db437b33fa0a" );
    }

    // Namespace zombie_hermes_beam_attack
    // Params 0, eflags: 0x4
    // Checksum 0xc1b3a4d6, Offset: 0x1b9b
    // Size: 0x50, Type: dev
    function private function_511980a4b2a22c68()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb4>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        hermes notify( #"hermes_beam_attack_terminate" );
        hermes start_beam();
    }

    // Namespace zombie_hermes_beam_attack
    // Params 0, eflags: 0x4
    // Checksum 0x28ba5327, Offset: 0x1bf3
    // Size: 0x160, Type: dev
    function private function_2a5e3f3fecf1249f()
    {
        level endon( #"hash_24d7db437b33fa0a" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xb4>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            hermes_head = hermes.var_8bcf69dec50b01c9;
            
            if ( isdefined( hermes_head ) && isdefined( hermes.var_a3cc86d40e6324d8 ) )
            {
                var_6608209e785d9778 = zombie_hermes_metabones::get_head_tag( hermes_head );
                hermes_head_angles = hermes gettagangles( var_6608209e785d9778 );
                start = hermes.var_a3cc86d40e6324d8.origin;
                target = hermes.var_a3cc86d40e6324d8.origin + anglestoforward( hermes_head_angles ) * 500;
                line( start, target, ( 1, 0, 0 ) );
                print3d( start + ( 0, 0, 50 ), "<dev string:xc2>" + hermes_head, ( 1, 0, 0 ) );
            }
            
            if ( hermes.var_a3cc86d40e6324d8 )
            {
                sphere( hermes.var_a3cc86d40e6324d8.origin, 10, ( 1, 0, 0 ), 1 );
            }
            
            waitframe();
        }
    }

#/
