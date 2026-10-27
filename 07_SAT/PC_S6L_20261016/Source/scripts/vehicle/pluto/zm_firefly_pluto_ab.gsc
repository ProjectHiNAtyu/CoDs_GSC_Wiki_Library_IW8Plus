// scripts\vehicle\pluto\zm_firefly_pluto_ab.gsc  (hash_26f8e8fd97898722.gscc) (size: 13676 Bytes / 0x356c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee2c76bc (3995891388)
// size ...... 13676 (0x356c)
// includes .. 11  (offset: 0x31a4)
// strings ... 50  (offset: 0x31fc)
// dev strs .. 1   (offset: 0x3560)
// exports ... 25  (offset: 0x20e0)
// cseg ...... 0x436 + 0x1caa (0x20e0)
// imports ... 102 (offset: 0x24c8)
// animtree1 . 0   (offset: 0x356c)
// animtree2 . 0   (offset: 0x356c)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\damagefeedback;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm_utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0x4b020979, Offset: 0x454
// Size: 0x74
function function_15d83b116cc098b9()
{
    if ( !utility::ent_flag( "pluto_abom_data_init" ) )
    {
        utility::add_fx( "abom_beam_fx", "vfx_jup_ob_gameplay_zm_ai_zai_abom_beam" );
        thread function_d877cff8fb31d97d();
        thread function_f32af1bbcbe45a06();
        thread function_b4df9767de0742e5();
        
        /#
            thread function_29ce0aa583a83cd8();
        #/
        
        if ( !level callback::exists( "on_powerup_pickup", &function_3ef4301b19476dfd ) )
        {
            level callback::add( "on_powerup_pickup", &function_3ef4301b19476dfd );
        }
        
        utility::ent_flag_set( "pluto_abom_data_init" );
    }
}

// Namespace pluto_veh
// Params 0
// Checksum 0x7f06b273, Offset: 0x4d0
// Size: 0x108
function function_b4df9767de0742e5()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    cooldownmax = utility::function_4b74c15943231980( getdvarint( @"pluto_beam_attack_cooldown", 15 ) );
    attacktime = utility::function_4b74c15943231980( 5.5 );
    
    while ( true )
    {
        if ( level utility::flag( "disable_pluto_beam" ) )
        {
            setomnvar( "ui_pluto_show_beam_attack", 0 );
            setomnvar( "ui_pluto_beam_attack_charge", 0 );
            waitframe();
            continue;
        }
        
        current_time = gettime();
        chargepercent = 1;
        
        if ( level utility::flag( "pluto_beam_attack_in_progress" ) && isdefined( self.var_7e3d23baf896e48e ) )
        {
            chargepercent = 1 - clamp( ( current_time - self.var_7e3d23baf896e48e ) / attacktime, 0, 1 );
        }
        else if ( isdefined( self.var_fcf38702b3c23b92 ) )
        {
            chargepercent = clamp( ( current_time - self.var_fcf38702b3c23b92 ) / cooldownmax, 0, 1 );
        }
        
        setomnvar( "ui_pluto_beam_attack_charge", chargepercent );
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0xe68ce1bc, Offset: 0x5e0
// Size: 0x116
function private function_d877cff8fb31d97d()
{
    self notify( #"hash_6bea8caa1f0757d8" );
    self endon( #"hash_6bea8caa1f0757d8" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( level.var_18eb5d4a85defe2 ) )
    {
        level.var_18eb5d4a85defe2 = throttle::throttle_initialize( "pluto_beam_attack", 1 );
    }
    
    if ( !isdefined( self.a_beam_end_points ) )
    {
        self.a_beam_end_points = [];
        function_e7db96bd462515e9();
    }
    
    var_344206aa22899062 = 0;
    
    while ( true )
    {
        if ( level utility::flag( "disable_pluto_beam" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.var_7493baa2cd62443 < 3 )
        {
            waitframe();
            continue;
        }
        
        if ( !isplayer( self.occupants[ "driver" ] ) )
        {
            var_344206aa22899062 = 0;
            waitframe();
            continue;
        }
        
        player = self.occupants[ "driver" ];
        
        if ( player attackbuttonpressed() )
        {
            if ( player isinvehicleleanout() )
            {
                var_344206aa22899062 = 1;
            }
            else if ( !var_344206aa22899062 )
            {
                var_344206aa22899062 = 1;
                function_306ec02e1a73e6bf();
            }
        }
        else
        {
            var_344206aa22899062 = 0;
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x1e42a36d, Offset: 0x6fe
// Size: 0xc7
function private function_e7db96bd462515e9()
{
    var_2d93159ec1b06de1 = utility::spawn_model( "tag_origin_abom_beam_tip", self gettagorigin( "tag_fx_jaw_le" ), ( 0, 0, 0 ) );
    thread utility::delete_on_death( var_2d93159ec1b06de1 );
    self.a_beam_end_points[ 0 ] = var_2d93159ec1b06de1;
    var_39d14854483e420a = utility::spawn_model( "tag_origin_abom_beam_tip", self gettagorigin( "tag_fx_jaw_center" ), ( 0, 0, 0 ) );
    thread utility::delete_on_death( var_39d14854483e420a );
    self.a_beam_end_points[ 1 ] = var_39d14854483e420a;
    var_2d93159ec1b06de1 = utility::spawn_model( "tag_origin_abom_beam_tip", self gettagorigin( "tag_fx_jaw_ri" ), ( 0, 0, 0 ) );
    thread utility::delete_on_death( var_2d93159ec1b06de1 );
    self.a_beam_end_points[ 2 ] = var_2d93159ec1b06de1;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x5ca8fd6b, Offset: 0x7cd
// Size: 0x144
function private function_306ec02e1a73e6bf( b_skip_cooldown = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !b_skip_cooldown )
    {
        current_time = gettime();
        
        if ( isdefined( self.var_fcf38702b3c23b92 ) && current_time - self.var_fcf38702b3c23b92 <= utility::function_4b74c15943231980( getdvarint( @"pluto_beam_attack_cooldown", 15 ) ) )
        {
            return;
        }
    }
    
    if ( level utility::flag( "pluto_beam_attack_in_progress" ) )
    {
        return;
    }
    
    level utility::flag_set( "pluto_beam_attack_in_progress" );
    setomnvar( "ui_pluto_is_beam_attack_active", 1 );
    self.var_7e3d23baf896e48e = gettime();
    self setscriptablepartstate( "abom_fxanim", "beam_attack" );
    wait 0.5;
    thread function_34ee068143ebda7d();
    thread function_4c0370f5bc377c4f( "tag_fx_jaw_center" );
    thread function_4c0370f5bc377c4f( "tag_fx_jaw_le" );
    thread function_4c0370f5bc377c4f( "tag_fx_jaw_ri" );
    var_305b9cb5a101de49 = self function_2e04b4dffc94a46d( "tag_ai_linkto_front" );
    
    if ( isdefined( var_305b9cb5a101de49 ) && !var_305b9cb5a101de49 val::get( "damageshield" ) )
    {
        var_305b9cb5a101de49.forceannihilate = 1;
        var_305b9cb5a101de49 kill( var_305b9cb5a101de49.origin, self );
    }
    
    wait 5;
    function_125a2294422fd6e9();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x9516a693, Offset: 0x919
// Size: 0x11f
function private function_34ee068143ebda7d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"beam_attack_end" );
    rumble_str = "damage_light";
    earthquake_scale = 0.2;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( arraycontains( self.occupants, player ) )
            {
                player playrumbleonentity( rumble_str );
                player earthquakeforplayer( earthquake_scale, 0.1, self.origin, 500 );
                continue;
            }
            
            if ( player getmovingplatformparent() == self )
            {
                player playrumbleonentity( rumble_str );
                player earthquakeforplayer( earthquake_scale, 0.1, self.origin, 500 );
            }
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa9cf14f0, Offset: 0xa40
// Size: 0x13d
function private function_4c0370f5bc377c4f( tag_name )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"beam_attack_end" );
    
    switch ( tag_name )
    {
        case #"hash_f619e229e9def66b":
            beam_end_ent = self.a_beam_end_points[ 0 ];
            break;
        case #"hash_1d893814a31092f1":
            beam_end_ent = self.a_beam_end_points[ 1 ];
            break;
        case #"hash_f65ee229ea151065":
            beam_end_ent = self.a_beam_end_points[ 2 ];
            break;
        default:
            assertmsg( "<dev string:x24>" );
            break;
    }
    
    beam_end_ent.origin = self gettagorigin( tag_name );
    waitframe();
    beam_end_ent setscriptablepartstate( "beam_tip", "hit" );
    beam_fx = playfxontagsbetweenclients( utility::getfx( "abom_beam_fx" ), self, tag_name, beam_end_ent, "tag_origin" );
    thread utility::delete_on_death( beam_fx );
    
    if ( !isdefined( self.a_beam_fx ) )
    {
        self.a_beam_fx = [];
    }
    
    self.a_beam_fx[ self.a_beam_fx.size ] = beam_fx;
    thread function_18b766b9326ba03b( tag_name, beam_end_ent );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x50289bcf, Offset: 0xb85
// Size: 0x157
function private function_125a2294422fd6e9( beam_end_point )
{
    self setscriptablepartstate( "abom_fxanim", "idle" );
    
    foreach ( end_point in self.a_beam_end_points )
    {
        end_point setscriptablepartstate( "beam_tip", "end" );
    }
    
    foreach ( beam_fx in self.a_beam_fx )
    {
        beam_fx delete();
    }
    
    self notify( #"beam_attack_end" );
    self.var_7e3d23baf896e48e = undefined;
    self.var_3f6837c8cfb37b04 = undefined;
    self.var_fcf38702b3c23b92 = gettime();
    level utility::flag_clear( "pluto_beam_attack_in_progress" );
    setomnvar( "ui_pluto_is_beam_attack_active", 0 );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x858c55d6, Offset: 0xce4
// Size: 0x366
function private function_18b766b9326ba03b( tag_name, beam_end_ent )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"beam_attack_end" );
    trace_contents = trace::create_contents( 1, 1, 0, 1, 0, 0, 0 );
    var_4a510287ba2baaff = anglestoforward( self.angles )[ 2 ];
    
    while ( true )
    {
        mouth_org = self gettagorigin( tag_name );
        fwd = anglestoforward( self.angles );
        fwd = ( fwd[ 0 ], fwd[ 1 ], clamp( fwd[ 2 ], -10, 10 ) );
        
        if ( abs( var_4a510287ba2baaff - fwd[ 2 ] ) > 1 )
        {
            if ( fwd[ 2 ] > var_4a510287ba2baaff )
            {
                fwd[ 2 ] = var_4a510287ba2baaff + 1;
            }
            else
            {
                fwd[ 2 ] = var_4a510287ba2baaff - 1;
            }
        }
        
        var_4a510287ba2baaff = fwd[ 2 ];
        fwd = vectornormalize( fwd );
        target_pos = mouth_org + fwd * 1000 + ( 0, 0, -80 );
        var_8f6f7b9e768f8fe9 = getdvarfloat( @"hash_e643b78fc8e8a6d9", 400 );
        var_699225d11510ae19 = function_2143c0da8ff4bf8( mouth_org, target_pos, var_8f6f7b9e768f8fe9, tag_name, beam_end_ent );
        
        if ( var_699225d11510ae19 )
        {
            beam_end_ent.origin = math::function_b642fd3e37ae7eb4( beam_end_ent.origin, var_699225d11510ae19, var_8f6f7b9e768f8fe9 * level.framedurationseconds );
            waitframe();
            continue;
        }
        
        trace = trace::ray_trace( mouth_org, target_pos, [ self ], trace_contents, 0, 0, 1 );
        
        if ( trace[ "hittype" ] == "hittype_entity" )
        {
            var_90ec0886f9ccf215 = trace[ "entity" ];
            var_90ec0886f9ccf215 = var_90ec0886f9ccf215.owner ?? var_90ec0886f9ccf215;
            
            if ( isai( var_90ec0886f9ccf215 ) && isalive( var_90ec0886f9ccf215 ) && var_90ec0886f9ccf215.team == zm_utility::get_zombie_team() )
            {
                var_90ec0886f9ccf215 thread function_9551d8d9c71e2979( self );
            }
            else if ( isplayer( var_90ec0886f9ccf215 ) && isalive( var_90ec0886f9ccf215 ) )
            {
                var_90ec0886f9ccf215 thread function_c4fedad78b625fb0( self );
            }
            
            move_to_org = trace[ "position" ];
        }
        else if ( trace[ "hittype" ] == "hittype_scriptable" && arraycontains( [ %"zm_sat_urchin_large", %"zm_loot_veh_barnacle_grown", %"zm_loot_veh_barnacle", #"zm_loot_veh_barnacle_boss" ], trace[ "scriptable" ].type ) )
        {
            trace[ "scriptable" ] thread function_945a7bdd07d210bd( self );
            
            if ( isplayer( self.occupants[ "driver" ] ) && trace[ "scriptable" ].type != "zm_loot_veh_barnacle_grown" )
            {
                self.occupants[ "driver" ] damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
            }
            
            move_to_org = trace[ "position" ];
        }
        else if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
        {
            move_to_org = trace[ "position" ];
        }
        else
        {
            move_to_org = target_pos;
        }
        
        move_to_org += ( randomintrange( -3, 4 ), randomintrange( -3, 4 ), randomintrange( -3, 4 ) );
        beam_end_ent.origin = move_to_org;
        throttle::throttle_wait_in_queue( level.var_18eb5d4a85defe2, self );
    }
}

// Namespace pluto_veh
// Params 5, eflags: 0x4
// Checksum 0x670043a8, Offset: 0x1052
// Size: 0x3b4
function private function_2143c0da8ff4bf8( mouth_org, target_pos, var_8f6f7b9e768f8fe9, tag_name, beam_end_ent )
{
    foreach ( beam in level.var_799248d6e9435274 ?? [] )
    {
        if ( !beam.source_ent || !beam.target_ent )
        {
            continue;
        }
        
        beam_time_perc = math::remap( gettime(), self.var_7e3d23baf896e48e, self.var_7e3d23baf896e48e + utility::function_4b74c15943231980( 5 ), 0, 1 );
        lerp_perc = math::remap( sin( gettime() * 0.001 * 9 ), -1, 1, 0.4, 0.6 );
        
        if ( beam_time_perc > 0.5 && !isdefined( self.var_3f6837c8cfb37b04 ) )
        {
            if ( !level.var_db456471145bf757 )
            {
                level.var_db456471145bf757 = 1;
                self.var_3f6837c8cfb37b04 = 1;
            }
            else
            {
                self.var_3f6837c8cfb37b04 = utility::array_random( [ 0, 1, 1 ] );
            }
        }
        
        if ( beam_time_perc >= 0.95 && self.var_3f6837c8cfb37b04 )
        {
            beam.should_end = 1;
        }
        
        if ( isdefined( self.var_3f6837c8cfb37b04 ) )
        {
            lerp_perc = self.var_3f6837c8cfb37b04;
        }
        
        mid_point = vectorlerp( mouth_org, beam.source_ent.origin, lerp_perc );
        var_58e6df77a50f979e = math::function_2e0e9b10b9c74d9e( mid_point, mouth_org, target_pos );
        var_d35525b26f7131b9 = math::function_2e0e9b10b9c74d9e( mid_point, beam.source_ent.origin, beam.target_ent.origin );
        var_8032aeabd375006e = 500;
        dot_product_threshold = -0.75;
        var_1ea693cbc61f7d6e = 50;
        var_b306c6bf4bcd9f8e = distance( var_58e6df77a50f979e, mid_point ) < var_8032aeabd375006e;
        var_6435535501acce97 = distance( var_d35525b26f7131b9, mid_point ) < var_8032aeabd375006e;
        other_beam_length = distance( beam.target_ent.origin, beam.source_ent.origin );
        dot_product = vectordot( vectornormalize( target_pos - mouth_org ), vectornormalize( beam.target_ent.origin - beam.source_ent.origin ) );
        
        if ( dot_product < dot_product_threshold || other_beam_length <= var_1ea693cbc61f7d6e )
        {
            if ( tag_name === "tag_fx_jaw_center" )
            {
                beam.target_ent.var_969b18d02e2ae5a5 = gettime();
                beam.target_ent.var_86829f9bd999ba9 = mid_point;
                beam.target_ent.var_e36f197d6f01c100 = var_8f6f7b9e768f8fe9;
                beam.target_ent.var_c27c2431c8cafacc = beam_end_ent;
            }
            
            return mid_point;
        }
        
        /#
            if ( getdvarint( @"hash_bb6fc845e5a842b5", 0 ) > 0 )
            {
                sphere( mid_point, var_8032aeabd375006e, ( 1, 0.3, 0 ) );
            }
        #/
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xc6d2a9e1, Offset: 0x140e
// Size: 0xa9
function private function_c4fedad78b625fb0( veh )
{
    if ( !isdefined( self.var_36edb7360e4bfe98 ) )
    {
        self.var_36edb7360e4bfe98 = 0;
    }
    
    current_time = gettime();
    
    if ( current_time - self.var_36edb7360e4bfe98 < utility::function_4b74c15943231980( 0.5 ) )
    {
        return;
    }
    
    self.var_36edb7360e4bfe98 = gettime();
    n_damage = self.maxhealth * 0.03 + 1;
    self dodamage( n_damage, self getcentroid(), veh function_1426dbae9165f4b1(), veh, "MOD_ELEMENTAL_ELEC" );
    self playsoundevent( %"sndevent_abom_beam_hit_player" );
    thread function_f57cd51cba6a98fc();
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x2fa63b1d, Offset: 0x14bf
// Size: 0x57
function private function_f57cd51cba6a98fc()
{
    self notify( #"hash_c8d839247a32c13f" );
    self endon( #"hash_c8d839247a32c13f" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    utility::function_32b24db3127bff40( "shockStickVFX", "vfx_start" );
    wait 2;
    utility::function_32b24db3127bff40( "shockStickVFX", "off" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x33940352, Offset: 0x151e
// Size: 0xe9
function private function_9551d8d9c71e2979( veh )
{
    if ( !isdefined( self.var_36edb7360e4bfe98 ) )
    {
        self.var_36edb7360e4bfe98 = 0;
    }
    
    current_time = gettime();
    
    if ( current_time - self.var_36edb7360e4bfe98 < utility::function_4b74c15943231980( 0.5 ) )
    {
        return;
    }
    
    self.var_36edb7360e4bfe98 = gettime();
    
    switch ( self.aicategory )
    {
        case #"hash_8c089e813083e510":
            veh thread function_c1902eaff9d5e919( self );
            break;
        case #"hash_7b0e2f2ed84f34":
            veh thread function_74e22aa467dee2bd( self );
            break;
        case #"hash_4e47eb6c32f5b165":
            veh thread function_74e22aa467dee2bd( self );
            break;
        case #"hash_7e8a002ed096276c":
            veh thread function_2727424110ab33e5( self );
            break;
        default:
            veh thread function_622b009db1eee5f( self );
            break;
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa1f65849, Offset: 0x160f
// Size: 0xd3
function private function_622b009db1eee5f( var_bd2c4ac1948d79c6 )
{
    if ( var_bd2c4ac1948d79c6 val::get( "damageshield" ) && !var_bd2c4ac1948d79c6 val::get( "damageshield_allow_quest_kill" ) )
    {
        return;
    }
    
    if ( var_bd2c4ac1948d79c6 val::get( "damageshield_allow_quest_kill" ) )
    {
        var_bd2c4ac1948d79c6 utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
    }
    
    var_bd2c4ac1948d79c6.full_gib = 1;
    var_bd2c4ac1948d79c6.forceannihilate = 1;
    var_bd2c4ac1948d79c6 kill( var_bd2c4ac1948d79c6.origin, function_1426dbae9165f4b1(), self );
    
    if ( isplayer( self.occupants[ "driver" ] ) )
    {
        driver = self.occupants[ "driver" ];
        driver damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x93ecb926, Offset: 0x16ea
// Size: 0xaf
function private function_c1902eaff9d5e919( var_bd2c4ac1948d79c6 )
{
    var_bd2c4ac1948d79c6 thread effect_stun::stun( "deadwire", 2, undefined, "shocked_on", undefined, "electrical" );
    n_damage = var_bd2c4ac1948d79c6.maxhealth * 0.07 + 1;
    var_bd2c4ac1948d79c6 dodamage( n_damage, var_bd2c4ac1948d79c6 getcentroid(), function_1426dbae9165f4b1(), self, "MOD_ELEMENTAL_ELEC" );
    
    if ( isplayer( self.occupants[ "driver" ] ) )
    {
        driver = self.occupants[ "driver" ];
        driver damagefeedback::updatehitmarker( "standard", var_bd2c4ac1948d79c6.health <= 0, 0, 0, undefined );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xfa72acc1, Offset: 0x17a1
// Size: 0x93
function private function_2727424110ab33e5( var_bd2c4ac1948d79c6 )
{
    n_damage = var_bd2c4ac1948d79c6.maxhealth * 0.003 + 1;
    var_bd2c4ac1948d79c6 dodamage( n_damage, var_bd2c4ac1948d79c6 getcentroid(), function_1426dbae9165f4b1(), self, "MOD_ELEMENTAL_ELEC" );
    
    if ( isplayer( self.occupants[ "driver" ] ) )
    {
        driver = self.occupants[ "driver" ];
        driver damagefeedback::updatehitmarker( "standard", var_bd2c4ac1948d79c6.health <= 0, 0, 0, undefined );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xf6405569, Offset: 0x183c
// Size: 0xc0
function private function_74e22aa467dee2bd( var_bd2c4ac1948d79c6 )
{
    if ( var_bd2c4ac1948d79c6.aicategory == "hvt" )
    {
        n_damage = var_bd2c4ac1948d79c6.maxhealth * 0.02 + 1;
    }
    else
    {
        n_damage = var_bd2c4ac1948d79c6.maxhealth * 0.034 + 1;
    }
    
    var_bd2c4ac1948d79c6 dodamage( n_damage, var_bd2c4ac1948d79c6 getcentroid(), function_1426dbae9165f4b1(), self, "MOD_ELEMENTAL_ELEC" );
    
    if ( isplayer( self.occupants[ "driver" ] ) )
    {
        driver = self.occupants[ "driver" ];
        driver damagefeedback::updatehitmarker( "standard", var_bd2c4ac1948d79c6.health <= 0, 0, 0, undefined );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x604a0790, Offset: 0x1904
// Size: 0x189
function private function_945a7bdd07d210bd( veh )
{
    self endon( #"death" );
    
    switch ( self.type )
    {
        case #"hash_9e4005df176d437a":
            if ( isdefined( self.fn_damage_callback ) )
            {
                [[ self.fn_damage_callback ]]( veh, veh.occupants[ "driver" ], self, 1, undefined, "MOD_ELEMENTAL_ELEC", undefined, undefined, self.origin );
            }
            
            break;
        case #"hash_3df9a2bb912653f3":
            if ( isdefined( self.fn_damage_callback ) )
            {
                [[ self.fn_damage_callback ]]( veh, veh.occupants[ "driver" ], self, self.health, undefined, "MOD_ELEMENTAL_ELEC", undefined, undefined, self.origin );
            }
            
            break;
        case #"hash_80add04522c70d86":
            if ( isdefined( self.fn_damage_callback ) )
            {
                [[ self.fn_damage_callback ]]( veh, veh.occupants[ "driver" ], self, self.health, undefined, "MOD_ELEMENTAL_ELEC", undefined, undefined, self.origin );
            }
            
            break;
        case #"hash_b986558bb965212a":
            if ( isdefined( self.fn_damage_callback ) )
            {
                [[ self.fn_damage_callback ]]( veh, veh.occupants[ "driver" ], self, self.health, undefined, "MOD_ELEMENTAL_ELEC", undefined, undefined, self.origin );
            }
            
            break;
        default:
            break;
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd6766254, Offset: 0x1a95
// Size: 0x214
function private function_f32af1bbcbe45a06()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( level.var_7c3690a13831cfa7 ) )
    {
        level.var_7c3690a13831cfa7 = throttle::throttle_initialize( "pluto_bite_attack", 1 );
    }
    
    while ( true )
    {
        if ( self.var_7493baa2cd62443 < 3 || self getscriptablepartstate( "single" ) == "vehicle_unusable" )
        {
            waitframe();
            continue;
        }
        
        level throttle::throttle_wait_in_queue( level.var_7c3690a13831cfa7, self );
        
        if ( level utility::flag( "pluto_beam_attack_in_progress" ) || self function_141a0b921cd37703() )
        {
            continue;
        }
        
        a_zombs = function_10584f185f2a258a();
        
        if ( a_zombs.size > 0 )
        {
            if ( a_zombs.size >= zm_round_spawning::function_f8f9048f8658271c() )
            {
                waitframe();
                continue;
            }
            
            if ( utility::percent_chance( 0.33 ) )
            {
                wait randomintrange( 2, 9 );
                continue;
            }
            
            self setscriptablepartstate( "abom_fxanim", "bite" );
            wait 0.3;
            
            foreach ( var_bd2c4ac1948d79c6 in a_zombs )
            {
                if ( isalive( var_bd2c4ac1948d79c6 ) )
                {
                    n_damage = function_453c8ec67fc04db1( var_bd2c4ac1948d79c6 );
                    
                    if ( var_bd2c4ac1948d79c6.health - n_damage <= 0 )
                    {
                        var_bd2c4ac1948d79c6.full_gib = 1;
                        var_bd2c4ac1948d79c6.forceannihilate = 1;
                        var_bd2c4ac1948d79c6.var_efc8dd6782b7f37e = 1;
                    }
                    
                    var_bd2c4ac1948d79c6 dodamage( n_damage, var_bd2c4ac1948d79c6 getcentroid(), function_1426dbae9165f4b1(), self, "MOD_CRUSH" );
                    
                    if ( isalive( var_bd2c4ac1948d79c6 ) )
                    {
                        var_bd2c4ac1948d79c6.var_efc8dd6782b7f37e = 0;
                    }
                }
            }
            
            wait 0.5;
            
            if ( self getscriptablepartstate( "abom_fxanim" ) != "beam_attack" )
            {
                self setscriptablepartstate( "abom_fxanim", "idle" );
            }
            
            wait randomintrange( 2, 9 );
        }
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x63115fbf, Offset: 0x1cb1
// Size: 0xd1
function private function_453c8ec67fc04db1( var_bd2c4ac1948d79c6 )
{
    if ( var_bd2c4ac1948d79c6.subclass == "zombie_shade" )
    {
        return var_bd2c4ac1948d79c6.maxhealth;
    }
    
    switch ( var_bd2c4ac1948d79c6.aicategory )
    {
        case #"hash_8c089e813083e510":
            return ( var_bd2c4ac1948d79c6.maxhealth * 0.015 + 1 );
        case #"hash_7b0e2f2ed84f34":
            return ( var_bd2c4ac1948d79c6.maxhealth * 0.008 + 1 );
        case #"hash_4e47eb6c32f5b165":
            return ( var_bd2c4ac1948d79c6.maxhealth * 0.005 + 1 );
        case #"hash_7e8a002ed096276c":
            return 0;
        default:
            return ( var_bd2c4ac1948d79c6.maxhealth * 0.5 + 1 );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xcd088bd4, Offset: 0x1d8a
// Size: 0x270
function private function_10584f185f2a258a()
{
    if ( self.var_7493baa2cd62443 < 3 || self getscriptablepartstate( "single" ) == "vehicle_unusable" )
    {
        return;
    }
    
    var_8cf6bca07fa8d6e7 = [];
    veh_fwd = vectornormalize( anglestoforward( self.angles ) );
    speed = self vehicle_getspeed();
    topspeed = self vehicle_gettopspeedforward();
    distcheck = min( speed, topspeed ) * 6;
    rectangle_length = clamp( distcheck, 6, topspeed * 6 );
    var_5a7d8050335c77cf = self gettagorigin( "tag_fx_jaw_center" ) + veh_fwd;
    var_2b7b20b454ab93cd = getdvarint( @"hash_15bf80c4eb46fbbb", 100 );
    corner_a = self gettagorigin( "tag_fx_jaw_le" ) + veh_fwd;
    corner_b = corner_a + veh_fwd * rectangle_length;
    corner_d = self gettagorigin( "tag_fx_jaw_ri" ) + veh_fwd;
    
    /#
        if ( getdvarint( @"hash_c3c85a0049800cc0", 0 ) )
        {
            corner_c = corner_d + veh_fwd * rectangle_length;
            utility::draw_rectangle( corner_a, corner_b, corner_c, corner_d, ( 0, 0, 1 ), 1, 10, undefined );
            utility::draw_circle( var_5a7d8050335c77cf, var_2b7b20b454ab93cd, ( 0, 1, 0 ), 1, undefined, 100 );
        }
    #/
    
    var_305b9cb5a101de49 = self function_2e04b4dffc94a46d( "tag_ai_linkto_front" );
    a_zombs = getaiarrayinradius( var_5a7d8050335c77cf, var_2b7b20b454ab93cd, zm_utility::get_zombie_team() );
    
    foreach ( var_bd2c4ac1948d79c6 in a_zombs )
    {
        if ( isalive( var_bd2c4ac1948d79c6 ) )
        {
            if ( var_bd2c4ac1948d79c6 zombie_vehicle_attack::is_in_vehicle_attack() && var_bd2c4ac1948d79c6 != var_305b9cb5a101de49 )
            {
                continue;
            }
            
            if ( utility::function_f1534d42bbbf62e( var_bd2c4ac1948d79c6.origin, corner_a, corner_b, corner_d ) )
            {
                var_8cf6bca07fa8d6e7[ var_8cf6bca07fa8d6e7.size ] = var_bd2c4ac1948d79c6;
                
                /#
                    if ( getdvarint( @"hash_c3c85a0049800cc0", 0 ) )
                    {
                        utility::draw_circle( var_bd2c4ac1948d79c6.origin, 20, ( 1, 0, 0 ), 1, undefined, 100 );
                    }
                #/
            }
        }
    }
    
    return var_8cf6bca07fa8d6e7;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xed8b78f5, Offset: 0x2003
// Size: 0x3b
function private function_1426dbae9165f4b1()
{
    if ( isplayer( self.occupants[ "driver" ] ) )
    {
        eattacker = self.occupants[ "driver" ];
    }
    else
    {
        eattacker = self;
    }
    
    return eattacker;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x8bab1e99, Offset: 0x2047
// Size: 0x43
function private function_3ef4301b19476dfd( params )
{
    if ( isdefined( level.wonder_veh ) && params.str_powerup == "full_power" )
    {
        level.wonder_veh.var_fcf38702b3c23b92 = 0;
    }
}

/#

    // Namespace pluto_veh
    // Params 0, eflags: 0x4
    // Checksum 0xd8598794, Offset: 0x2092
    // Size: 0x4e, Type: dev
    function private function_29ce0aa583a83cd8()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_bb6fc845e5a842b5" ) )
            {
                thread function_306ec02e1a73e6bf( 1 );
                setdvar( @"hash_bb6fc845e5a842b5", 0 );
            }
            
            waitframe();
        }
    }

#/
