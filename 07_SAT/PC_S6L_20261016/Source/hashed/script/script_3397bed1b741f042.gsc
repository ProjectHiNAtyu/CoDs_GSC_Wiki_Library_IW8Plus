// script_3397bed1b741f042  (hash_3397bed1b741f042.gscc) (size: 6849 Bytes / 0x1ac1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x456f67e8 (1164929000)
// size ...... 6849 (0x1ac1)
// includes .. 8   (offset: 0x1851)
// strings ... 28  (offset: 0x1891)
// dev strs .. 15  (offset: 0x1a0d)
// exports ... 14  (offset: 0xe55)
// cseg ...... 0x1ec + 0xc69 (0xe55)
// imports ... 66  (offset: 0x1085)
// animtree1 . 0   (offset: 0x1ac1)
// animtree2 . 0   (offset: 0x1ac1)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_473bdc208d3e708a;

// Namespace namespace_473bdc208d3e708a
// Params 1
// Checksum 0xcbcd863b, Offset: 0x20a
// Size: 0x3d
function init_beam_attack_precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "deathworm_beam_vfx", settings.beamvfx );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0
// Checksum 0x5b20d5e, Offset: 0x24f
// Size: 0xa7
function init_beam_attack()
{
    self.worm_target_ent = undefined;
    self.worm_target_yaw = 0;
    self.worm_target_dist = 400;
    self.worm_beam_start_time = 0;
    self.var_6bb47f7753e4188d = 0;
    self.var_e772b21032e2f411 = undefined;
    self.worm_beam_target_ent = spawn( "script_model", self.origin );
    self.worm_beam_target_ent setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f4615ecafed1394d );
    thread utility::delete_on_death( self.worm_beam_target_ent );
    thread function_7c758e39cf7d3bc4();
    
    /#
        init_beam_attack_devgui();
    #/
}

// Namespace namespace_473bdc208d3e708a
// Params 4
// Checksum 0x1e48f72, Offset: 0x2fe
// Size: 0x7a, Type: bool
function function_6a45376d254099c2( asmname, statename, tostatename, params )
{
    var_d1bc21baf5f18f5d = gettime() - self.worm_beam_start_time;
    worm_beam_time = get_beaming_time() + get_pause_time();
    
    if ( worm_beam_time > 0 && var_d1bc21baf5f18f5d >= worm_beam_time )
    {
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:x24>" );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x2f684da6, Offset: 0x381
// Size: 0x12
function private get_pause_time()
{
    return getdvarfloat( @"worm_beam_pause_time", 600 );
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x88d8b41f, Offset: 0x39c
// Size: 0xb
function private get_beaming_time()
{
    return self.var_a4a2b1f3f3b58ce9;
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x74488ed7, Offset: 0x3b0
// Size: 0x7c4
function private function_4f723fcaf2ed1d76()
{
    self endon( #"death" );
    self endon( #"beam_attack_end" );
    self.var_a4a2b1f3f3b58ce9 = getdvarfloat( @"worm_beam_time", 2000 );
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    var_121423597bb042b0 = self.health < self.maxhealth * 0.5;
    
    if ( gettime() - self.var_6bb47f7753e4188d < 30000 || var_4912869f02b165bf >= 4 || var_4912869f02b165bf > 1 && var_9c18eb30cf6a1214 >= 1 || var_121423597bb042b0 )
    {
        self.var_a4a2b1f3f3b58ce9 *= 0.5;
    }
    
    target_yaw = 0;
    
    if ( isdefined( self.worm_target_ent ) )
    {
        target_ent_velocity = ( 0, 0, 0 );
        
        if ( isagent( self.worm_target_ent ) || isplayer( self.worm_target_ent ) )
        {
            target_ent_velocity = self.worm_target_ent getvelocity();
            
            if ( isdefined( self.worm_target_ent.vehicle ) )
            {
                target_ent_velocity = self.worm_target_ent.vehicle vehicle_getvelocity();
            }
        }
        
        target_ent_pos = self.worm_target_ent.origin;
        var_3ef0280c1b384aef = distance2d( self.origin, target_ent_pos ) / 2000;
        predicted_pos = target_ent_pos + target_ent_velocity * ( get_pause_time() + get_beaming_time() * var_3ef0280c1b384aef ) / 1000;
        
        /#
            if ( debug_beam_attack() )
            {
                line( target_ent_pos, predicted_pos, ( 1, 0, 0 ) );
                function_ba3b0c32f8e1d7a1( "<dev string:x41>", predicted_pos );
            }
        #/
        
        target_ent_pos = predicted_pos;
        target_yaw = utility::getyawtospot( target_ent_pos );
        target_yaw = clamp( target_yaw, -70, 70 );
    }
    
    target_vec_normalized = anglestoforward( ( 0, target_yaw + self.angles[ 1 ], 0 ) );
    max_beam_length = getdvarfloat( @"worm_beam_max_length", 3000 );
    self function_536f8624346a747b( target_yaw );
    self function_ba5334b674dfb9d0( 0 );
    wait get_pause_time() / 1000;
    start_time = gettime();
    end_time = start_time + get_beaming_time();
    self.var_e772b21032e2f411 = playfxontagsbetweenclients( utility::getfx( "deathworm_beam_vfx" ), self, "tag_fx_beam_rotate", self.worm_beam_target_ent, "tag_origin" );
    
    if ( isdefined( self.var_e772b21032e2f411 ) )
    {
        self.var_e772b21032e2f411 namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
        thread utility::function_9a9165839779317f( self.var_e772b21032e2f411, "beam_attack_end" );
    }
    
    self.worm_beam_target_ent utility::function_32b24db3127bff40( "beam_target", "beam_target_on" );
    self.worm_beam_target_ent dontinterpolate();
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    
    while ( true )
    {
        aim_start_pos = self gettagorigin( "tag_fx_beam_rotate" );
        var_76af8187404125b4 = math::remap( gettime(), start_time, end_time, 0, 1 );
        var_3ef0280c1b384aef = var_76af8187404125b4;
        
        if ( var_4912869f02b165bf < 7 )
        {
            var_3ef0280c1b384aef = easepower( var_76af8187404125b4, getdvarfloat( @"hash_3e747e1d7b24b293", 1.25 ), 1, 0 );
        }
        
        var_a0d3f1c68d25c770 = math::remap( var_3ef0280c1b384aef, 0, 1, 300, 2000 );
        var_a0d3f1c68d25c770 = clamp( var_a0d3f1c68d25c770, 300, 2000 );
        target_aim_pos = target_vec_normalized * var_a0d3f1c68d25c770 + self.origin;
        var_b150449b2916bef9 = vectornormalize( target_aim_pos - aim_start_pos );
        target_aim_pos = aim_start_pos + var_b150449b2916bef9 * max_beam_length;
        a_trace_results = trace::ray_trace_get_all_results( aim_start_pos, target_aim_pos );
        var_840926d75db91652 = [];
        hit_position = target_aim_pos;
        
        foreach ( trace_result in a_trace_results )
        {
            if ( trace_result[ "hittype" ] == "hittype_world" )
            {
                hit_position = trace_result[ "position" ];
                break;
            }
            
            if ( trace_result[ "hittype" ] == "hittype_entity" )
            {
                var_840926d75db91652[ var_840926d75db91652.size ] = trace_result[ "entity" ];
            }
        }
        
        blast_radius = 80;
        var_2c4896a24434f88b = getplayersandaiarrayinradius( hit_position, blast_radius );
        var_840926d75db91652 = arraycombineunique( var_840926d75db91652, var_2c4896a24434f88b );
        
        foreach ( var_90ec0886f9ccf215 in var_840926d75db91652 )
        {
            if ( !isalive( var_90ec0886f9ccf215 ) || self == var_90ec0886f9ccf215 )
            {
                continue;
            }
            
            if ( var_90ec0886f9ccf215 utility::ent_flag( "worm_beamed" ) )
            {
                /#
                    function_ba3b0c32f8e1d7a1( "<dev string:x4f>", var_90ec0886f9ccf215.origin );
                #/
                
                continue;
            }
            
            var_f170b524015f6863 = 50;
            beam_should_kill = 0;
            
            if ( isplayer( var_90ec0886f9ccf215 ) )
            {
                var_f170b524015f6863 = 250;
            }
            else if ( isai( var_90ec0886f9ccf215 ) )
            {
                if ( var_90ec0886f9ccf215.subclass == "zombie_hellhound_pet" )
                {
                    var_f170b524015f6863 = 7500;
                }
                else if ( ( !isdefined( var_90ec0886f9ccf215.aicategory ) || var_90ec0886f9ccf215.aicategory == "normal" ) && !var_90ec0886f9ccf215.damageshield )
                {
                    beam_should_kill = 1;
                }
                else if ( var_90ec0886f9ccf215.aicategory == "special" )
                {
                    var_f170b524015f6863 = 50000;
                }
                else if ( var_90ec0886f9ccf215.aicategory == "elite" || var_90ec0886f9ccf215.aicategory == "hvt" )
                {
                    var_f170b524015f6863 = 25000;
                }
            }
            
            if ( beam_should_kill )
            {
                var_90ec0886f9ccf215 utility::ent_flag_set( "dissolve" );
                var_90ec0886f9ccf215 kill( aim_start_pos, self, self, "MOD_PROJECTILE" );
                continue;
            }
            
            if ( self.use_lethal_attacks && self.var_6005157a6615b97f > 1 && isplayer( var_90ec0886f9ccf215 ) )
            {
                var_90ec0886f9ccf215 dodamage( var_f170b524015f6863, aim_start_pos, self, self, "MOD_PROJECTILE" );
            }
            
            var_90ec0886f9ccf215 dodamage( var_f170b524015f6863, aim_start_pos, self, self, "MOD_PROJECTILE" );
            var_90ec0886f9ccf215 utility::ent_flag_set( "worm_beamed" );
            var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "worm_beamed", 0.5 );
            
            /#
                function_ba3b0c32f8e1d7a1( "<dev string:x5d>", var_90ec0886f9ccf215.origin );
            #/
        }
        
        /#
            if ( debug_beam_attack() )
            {
                sphere( hit_position, blast_radius, ( 1, 0, 0 ) );
            }
        #/
        
        self.worm_beam_target_ent.origin = hit_position;
        self.worm_target_yaw = target_yaw;
        self.worm_target_dist = var_a0d3f1c68d25c770;
        
        /#
            if ( debug_beam_attack() )
            {
                line( aim_start_pos, self.worm_beam_target_ent.origin, ( 1, 0, 0 ) );
                function_ba3b0c32f8e1d7a1( "<dev string:x7b>", self.worm_beam_target_ent.origin );
                line( self.worm_beam_target_ent.origin, target_aim_pos, ( 1, 1, 0 ), 0.3 );
            }
        #/
        
        self function_536f8624346a747b( self.worm_target_yaw );
        self function_ba5334b674dfb9d0( self.worm_target_dist );
        waitframe();
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x444b8ca3, Offset: 0xb7c
// Size: 0xf4
function private function_7c758e39cf7d3bc4()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"beam_attack_start" );
        self.worm_beam_start_time = gettime();
        self.worm_target_ent = self.enemy;
        utility::function_32b24db3127bff40( "mouth", "beam" );
        metabone::set_metabone_active( "beaming_head", 1 );
        yaw_to_enemy = 0;
        
        if ( isdefined( self.enemy ) )
        {
            yaw_to_enemy = utility::getyawtospot( self.enemy.origin );
            
            if ( abs( yaw_to_enemy ) < getdvarfloat( @"hash_290f687417871da4", 130 ) )
            {
                self.turnrate = getdvarfloat( @"hash_600c759093c68d43", 0.025 );
            }
            else
            {
                self.turnrate = 0.01;
            }
        }
        
        thread function_4f723fcaf2ed1d76();
        thread utility::thread_on_notify( "beam_attack_end", &on_beam_attack_end, self );
    }
}

// Namespace namespace_473bdc208d3e708a
// Params 0, eflags: 0x4
// Checksum 0x4dd76251, Offset: 0xc78
// Size: 0x74
function private on_beam_attack_end()
{
    utility::function_32b24db3127bff40( "mouth", "off" );
    utility::function_32b24db3127bff40( "audio", "beam_off" );
    self.worm_beam_target_ent utility::function_32b24db3127bff40( "beam_target", "beam_target_off" );
    metabone::set_metabone_active( "beaming_head", 0 );
    ai::set_blackboard_cooldown( "beam_attack_cooldown", getdvarint( @"worm_beam_cooldown", 16000 ) );
    self.var_6bb47f7753e4188d = gettime();
}

/#

    // Namespace namespace_473bdc208d3e708a
    // Params 0
    // Checksum 0xed72d387, Offset: 0xcf4
    // Size: 0x44, Type: dev
    function init_beam_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x86>" );
        devgui::add_devgui_func( "<dev string:xa2>", "<dev string:xb4>", &force_beam_attack );
        devgui::add_devgui_func( "<dev string:xcb>", "<dev string:xdd>", &function_1a3b3a6ad2d7ea45 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0xc47896f8, Offset: 0xd40
    // Size: 0x72, Type: dev
    function private force_beam_attack()
    {
        var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xf4>" );
        
        if ( !isdefined( var_f39d8960915f9a15 ) )
        {
            var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x105>" );
            
            if ( !isdefined( var_f39d8960915f9a15 ) )
            {
                return;
            }
        }
        
        var_f39d8960915f9a15 function_786bb6aa1b76c7ee( "<dev string:x11b>", 1 );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0xb9d98b03, Offset: 0xdba
    // Size: 0x16, Type: dev
    function private debug_beam_attack()
    {
        return getdvarint( @"hash_f6e0c15a97baed74", 0 ) > 0;
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 0, eflags: 0x4
    // Checksum 0x607a9e51, Offset: 0xdd8
    // Size: 0x1a, Type: dev
    function private function_1a3b3a6ad2d7ea45()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x12a>", @"hash_f6e0c15a97baed74" );
    }

    // Namespace namespace_473bdc208d3e708a
    // Params 2, eflags: 0x4
    // Checksum 0x911106d8, Offset: 0xdfa
    // Size: 0x5b, Type: dev
    function private function_ba3b0c32f8e1d7a1( text, pos )
    {
        if ( debug_beam_attack() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x146>" + text, ( 1, 0, 0 ) );
        }
    }

#/
