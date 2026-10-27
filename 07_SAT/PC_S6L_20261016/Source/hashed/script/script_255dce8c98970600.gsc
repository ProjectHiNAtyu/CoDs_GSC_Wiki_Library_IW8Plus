// script_255dce8c98970600  (hash_255dce8c98970600.gscc) (size: 10264 Bytes / 0x2818 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41dc1176 (1104941430)
// size ...... 10264 (0x2818)
// includes .. 10  (offset: 0x261c)
// strings ... 23  (offset: 0x266c)
// dev strs .. 7   (offset: 0x27c4)
// exports ... 24  (offset: 0x17f8)
// cseg ...... 0x1ae + 0x164a (0x17f8)
// imports ... 88  (offset: 0x1bb8)
// animtree1 . 0   (offset: 0x2818)
// animtree2 . 0   (offset: 0x2818)
#using script_437ee0f94301721b;
#using script_bdb08507b3b7b94;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;

#namespace zombie_uranus_beam;

// Namespace zombie_uranus_beam
// Params 1
// Checksum 0x3fb11f8f, Offset: 0x1cc
// Size: 0x55
function function_2b091127547f62bc( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        if ( settings.beamvfx )
        {
            utility::add_fx( "uranus_beam_vfx", settings.beamvfx );
        }
    }
    
    /#
        devgui_init();
    #/
}

// Namespace zombie_uranus_beam
// Params 0
// Checksum 0x3f35ed7a, Offset: 0x229
// Size: 0xdc
function init_uranus_beam_attack()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    model = settings.var_90cf7bf03220eeec ?? "tag_origin";
    self.uranus_beam_target_ents = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        beam_target_ent = utility::spawn_model( model, self.origin );
        self.uranus_beam_target_ents[ self.uranus_beam_target_ents.size ] = beam_target_ent;
        thread utility::delete_on_death( beam_target_ent );
    }
    
    thread setup_beam_source_ent();
    zombie_uranus::register_cool_down( #"hash_93e3001c9613e202", settings.beamcooldown );
    zombie_uranus::register_can_use_skill( "uranus_skill_beam", &can_beam_attack );
    
    /#
        level.debug_uranus = self;
    #/
}

// Namespace zombie_uranus_beam
// Params 0, eflags: 0x4
// Checksum 0x3ce4359e, Offset: 0x30d
// Size: 0xaa
function private setup_beam_source_ent()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    origin = self gettagorigin( "tag_laser", 1 ) ?? self.origin;
    self.var_4a28d3c527b2e986 = utility::spawn_model( "tag_origin", origin );
    
    if ( utility::hastag( self.model, "tag_laser" ) )
    {
        self.var_4a28d3c527b2e986 linkto( self, "tag_laser", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    thread utility::delete_on_death( self.var_4a28d3c527b2e986 );
}

// Namespace zombie_uranus_beam
// Params 2, eflags: 0xc
// Checksum 0xf2306940, Offset: 0x3bf
// Size: 0x16f
function private beam_charge( target, var_65eec6a195986c27 )
{
    self notify( #"hash_eb1db5438be23015" );
    self endon( #"hash_eb1db5438be23015" );
    level endon( #"game_ended" );
    self endon( #"death" );
    zombie_uranus::do_action( "uranus_beam" );
    self.uranus_beam_charging = 1;
    thread function_37c9c6af1e3f99e5();
    introanimlength = zombie_uranus_asm::get_anim_length( "beam_attack_intro" );
    var_5f21f017afdfa868 = max( 0, var_65eec6a195986c27 - introanimlength );
    thread function_b96fc95130ccca70( var_5f21f017afdfa868 );
    utility::function_32b24db3127bff40( "beam", "charging" );
    endtime = gettime() + var_65eec6a195986c27 * 1000;
    uranus_beam_target_ent = self.uranus_beam_target_ents[ 0 ];
    uranus_beam_target_ent.origin = target getcentroid();
    rotatespeed = 1;
    thread zombie_uranus::look_at_target_thread( uranus_beam_target_ent, rotatespeed, "beam_charge_end" );
    
    if ( randomint( 100 ) < 20 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_cf2a4ccb4aa472cc" ] );
    }
    
    while ( isalive( target ) && gettime() < endtime )
    {
        uranus_beam_target_ent.origin = target getcentroid();
        waitframe();
    }
    
    beam_charge_end();
    
    if ( !self.interrupted )
    {
        start_beam_attack();
        return;
    }
    
    beam_attack_end();
}

// Namespace zombie_uranus_beam
// Params 0, eflags: 0x4
// Checksum 0x248e0ec9, Offset: 0x536
// Size: 0x16c
function private start_beam_attack()
{
    thread zombie_uranus::look_at_target_thread( self.uranus_beam_target_ents[ 0 ], 1, "beam_attack_end" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    beam_number = 1;
    
    switch ( level.players.size )
    {
        case 2:
            beam_number = maxint( settings.var_9155aac59f74d23c, 1 );
            break;
        case 3:
            beam_number = maxint( settings.var_fe6520c1e00ce2cf, 1 );
            break;
        case 4:
            beam_number = maxint( settings.var_4c106bcd6431326e, 1 );
            break;
    }
    
    targets = zombie_uranus::get_random_targets( 0, beam_number, 1 );
    
    foreach ( index, target in targets )
    {
        uranus_beam_target_ent = self.uranus_beam_target_ents[ index ];
        uranus_beam_target_ent.origin = target getcentroid();
        thread beam_attack( target, uranus_beam_target_ent );
    }
}

// Namespace zombie_uranus_beam
// Params 1
// Checksum 0xf6b1dfc3, Offset: 0x6aa
// Size: 0x4e
function function_b96fc95130ccca70( waittime )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"uranus_damaged" );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    self asmsetstate( self.asmname, "beam_attack_intro" );
}

// Namespace zombie_uranus_beam
// Params 0, eflags: 0x4
// Checksum 0x332ecc3c, Offset: 0x700
// Size: 0x29
function private beam_charge_end()
{
    utility::function_32b24db3127bff40( "beam", "off" );
    self.uranus_beam_charging = 0;
    self notify( #"beam_charge_end" );
}

// Namespace zombie_uranus_beam
// Params 0, eflags: 0xc
// Checksum 0xaa4d2016, Offset: 0x731
// Size: 0x81
function private function_37c9c6af1e3f99e5()
{
    self notify( #"hash_d3a2086e77e9d2d2" );
    self endon( #"hash_d3a2086e77e9d2d2" );
    level endon( #"game_ended" );
    self endon( #"beam_attack_end" );
    utility::waittill_any( "death", "uranus_damaged" );
    
    if ( self.asmname )
    {
        asm::asm_fireevent( self.asmname, "exit_loop" );
    }
    
    if ( self.uranus_beam_charging )
    {
        beam_charge_end();
        return;
    }
    
    beam_attack_end();
}

// Namespace zombie_uranus_beam
// Params 2, eflags: 0x4
// Checksum 0x98ff1045, Offset: 0x7ba
// Size: 0x587
function private beam_attack( target, uranus_beam_target_ent )
{
    level endon( #"game_ended" );
    self endon( #"beam_attack_end" );
    self endon( #"death" );
    target_is_player = isplayer( target );
    
    if ( target_is_player && !zombie_uranus::can_attack_target( target ) )
    {
        waitframe();
        
        while ( !zombie_uranus::can_attack_target( target ) )
        {
            if ( !isalive( target ) )
            {
                beam_attack_end( uranus_beam_target_ent );
                return;
            }
            
            waitframe();
        }
        
        wait 1;
        
        if ( !isalive( target ) )
        {
            beam_attack_end( uranus_beam_target_ent );
            return;
        }
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( !isdefined( uranus_beam_target_ent ) )
    {
        uranus_beam_target_ent = self.uranus_beam_target_ents[ 0 ];
    }
    
    uranus_beam_target_ent.origin = function_ae0c9ceb81c9a9a0( self.var_4a28d3c527b2e986.origin, uranus_beam_target_ent.origin );
    beamfx = playfxontagsbetweenclients( utility::getfx( "uranus_beam_vfx" ), self.var_4a28d3c527b2e986, "tag_origin", uranus_beam_target_ent, "tag_origin" );
    uranus_beam_target_ent.beamfx = beamfx;
    uranus_beam_target_ent utility::function_7c10ea82c1e305b8( "beam", "beam_on" );
    uranus_beam_target_ent.active = 1;
    endtime = gettime() + settings.beamduration * 1000;
    damagetick = settings.var_c5b639bcb6641385;
    damagetime = 0;
    uranus_beam_burn_uid = "uranus_beam_burn";
    var_a77a7baed79d52a2 = 0;
    var_5a9884ed05674567 = 1;
    burntick = 0.5;
    self.uranus_beam_attacking = 1;
    aimtarget = uranus_beam_target_ent.origin;
    wait settings.var_c2941f23a40c83af;
    beam_attack_struct = undefined;
    childthread function_105d5a9a648ba620( uranus_beam_target_ent );
    
    while ( gettime() < endtime )
    {
        if ( target_is_player && !target )
        {
            beam_attack_end( uranus_beam_target_ent );
            return;
        }
        
        dt = utility::function_6f5d2e1f1ff70482( getframeduration() );
        start = self.var_4a28d3c527b2e986.origin;
        
        if ( target.chaseendtime && target.chaseendtime >= gettime() || zombie_uranus::can_attack_target( target ) )
        {
            if ( isplayer( target ) )
            {
                current_pos = target getcentroid();
                beam_attack_struct = get_beam_attack_points( start, current_pos, beam_attack_struct, target );
                target_pos = beam_attack_struct.target_pos;
            }
            else
            {
                target_pos = target.origin;
            }
            
            dir = target_pos - aimtarget;
            dis = length( dir );
            dir = vectornormalize( dir );
            followspeed = settings.var_4efeb0dc1132b23;
            
            /#
                if ( isdvardefined( @"hash_3a022f345e64eedd" ) )
                {
                    followspeed = getdvarfloat( @"hash_3a022f345e64eedd" );
                }
            #/
            
            speed = min( followspeed, dis );
            aimtarget += dir * speed * dt;
            uranus_beam_target_ent.origin = aimtarget;
        }
        else if ( !target.chaseendtime || gettime() > target.chaseendtime )
        {
            target = zombie_uranus::get_random_targets( 0, 1 )[ 0 ];
            
            if ( !target )
            {
                randpos = getrandomnavpoint( uranus_beam_target_ent.origin, 500 );
                target = { #chaseendtime:gettime() + 2000, #origin:randpos };
            }
        }
        
        uranus_beam_target_ent.origin = function_ae0c9ceb81c9a9a0( start, uranus_beam_target_ent.origin );
        end = uranus_beam_target_ent.origin;
        contents = trace::create_contents( 1 );
        beamradius = settings.beamradius;
        spherecasts = physics_spherecast( start, end, beamradius, contents, self, "physicsquery_all" );
        
        foreach ( spherecast in spherecasts )
        {
            ent = spherecast[ "entity" ];
            
            if ( isplayer( ent ) )
            {
                damage = settings.var_55508b53329e7d8c;
            }
            else if ( isai( ent ) && isalive( ent ) )
            {
                damage = ent.maxhealth * settings.var_f9339acc6ff32da7;
            }
            else
            {
                continue;
            }
            
            if ( ent utility::ent_flag( "uranus_beam_hit" ) )
            {
                continue;
            }
            
            self.ignore_turtle_shell = 1;
            ent dodamage( damage, spherecast[ "position" ], self, self, "MOD_PROJECTILE" );
            self.ignore_turtle_shell = undefined;
            ent utility::ent_flag_set( "uranus_beam_hit" );
            ent thread utility::ent_flag_clear_delayed( "uranus_beam_hit", damagetick );
            ent effect_burn::burn( var_5a9884ed05674567, var_a77a7baed79d52a2, burntick, self, uranus_beam_burn_uid );
        }
        
        waitframe();
    }
    
    beam_attack_end( uranus_beam_target_ent );
}

// Namespace zombie_uranus_beam
// Params 2, eflags: 0x4
// Checksum 0xc7b7340d, Offset: 0xd49
// Size: 0x72
function private function_ae0c9ceb81c9a9a0( start, end )
{
    beamdir = vectornormalize( end - start );
    end += beamdir * 500;
    contents = trace::create_default_contents( 1 );
    result = trace::ray_trace( start, end, self, contents );
    
    if ( result[ "fraction" ] < 1 )
    {
        return result[ "position" ];
    }
    
    return end;
}

// Namespace zombie_uranus_beam
// Params 4, eflags: 0x4
// Checksum 0x7d0e97d5, Offset: 0xdc4
// Size: 0x333
function private get_beam_attack_points( start, current_pos, var_9babf953f2de9ab2 = { #visible_points:[], #target_pos_update_time:0, #target_pos:undefined, #var_6bb0cbaf7de22337:0, #var_bc80ae1760d9ab2d:0, #var_45c5a35b24049d16:undefined }, target )
{
    /#
        can_see = 0;
    #/
    
    if ( sighttracepassed( start, current_pos, 0, self, target ) )
    {
        var_9babf953f2de9ab2.var_45c5a35b24049d16 = current_pos;
        var_9babf953f2de9ab2.var_bc80ae1760d9ab2d = gettime();
        var_9babf953f2de9ab2.target_pos = current_pos;
        var_9babf953f2de9ab2.target_pos_update_time = gettime();
        
        /#
            can_see = 1;
        #/
        
        var_9babf953f2de9ab2.visible_points = [];
        var_9babf953f2de9ab2.visible_points[ var_9babf953f2de9ab2.visible_points.size ] = current_pos;
    }
    else
    {
        if ( var_9babf953f2de9ab2.visible_points.size < 5 )
        {
            radius = undefined;
            var_83beaa896eded17a = undefined;
            pos = undefined;
            
            if ( var_9babf953f2de9ab2.var_45c5a35b24049d16 )
            {
                if ( gettime() - var_9babf953f2de9ab2.var_bc80ae1760d9ab2d > 1000 && gettime() - var_9babf953f2de9ab2.var_6bb0cbaf7de22337 > 1000 )
                {
                    radius = 100;
                    var_83beaa896eded17a = 10;
                    pos = var_9babf953f2de9ab2.var_45c5a35b24049d16;
                }
            }
            else if ( gettime() - var_9babf953f2de9ab2.var_6bb0cbaf7de22337 > 1000 )
            {
                if ( var_9babf953f2de9ab2.visible_points.size > 0 )
                {
                    radius = 100;
                    var_83beaa896eded17a = 10;
                    pos = var_9babf953f2de9ab2.visible_points[ 0 ];
                }
                else
                {
                    radius = 200;
                    var_83beaa896eded17a = 10;
                    pos = current_pos;
                }
            }
            
            if ( radius && var_83beaa896eded17a && pos )
            {
                var_4d7d4fdebb3384d2 = get_visible_nav_point( start, pos, radius, var_83beaa896eded17a, self, target );
                
                if ( var_4d7d4fdebb3384d2 )
                {
                    var_9babf953f2de9ab2.var_6bb0cbaf7de22337 = gettime();
                    var_9babf953f2de9ab2.visible_points[ var_9babf953f2de9ab2.visible_points.size ] = var_4d7d4fdebb3384d2;
                }
            }
        }
        
        if ( var_9babf953f2de9ab2.target_pos && gettime() - var_9babf953f2de9ab2.target_pos_update_time < 1000 )
        {
        }
        else if ( var_9babf953f2de9ab2.visible_points.size )
        {
            if ( var_9babf953f2de9ab2.visible_points.size == 1 )
            {
                var_9babf953f2de9ab2.target_pos = var_9babf953f2de9ab2.visible_points[ 0 ];
            }
            else
            {
                var_9babf953f2de9ab2.target_pos = var_9babf953f2de9ab2.visible_points[ randomint( var_9babf953f2de9ab2.visible_points.size ) ];
            }
            
            var_9babf953f2de9ab2.target_pos_update_time = gettime();
        }
        else
        {
            var_9babf953f2de9ab2.target_pos = current_pos;
        }
    }
    
    /#
        if ( getdvarint( @"hash_c1f461426843072d", 0 ) )
        {
            color = can_see ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            debug::sphere( var_9babf953f2de9ab2.target_pos, 5, color, 0.5 );
        }
    #/
    
    return var_9babf953f2de9ab2;
}

// Namespace zombie_uranus_beam
// Params 6, eflags: 0x4
// Checksum 0xa2f8844f, Offset: 0x1100
// Size: 0xe4
function private get_visible_nav_point( start, pos, radius, maxpoints, var_dac8f572c916ce9d, var_dac8f272c916c804 )
{
    navpoints = getrandomnavpoints( pos, radius, maxpoints );
    
    if ( !navpoints || !navpoints.size )
    {
        return;
    }
    
    foreach ( point in navpoints )
    {
        if ( distancesquared( pos, point ) <= 100 )
        {
            continue;
        }
        
        if ( sighttracepassed( start, point, 0, var_dac8f572c916ce9d, var_dac8f272c916c804 ) )
        {
            return point;
        }
    }
}

// Namespace zombie_uranus_beam
// Params 1
// Checksum 0x2b8a7bbb, Offset: 0x11ed
// Size: 0xca
function function_105d5a9a648ba620( target )
{
    level endon( #"game_ended" );
    self endon( #"beam_attack_end" );
    self endon( #"death" );
    earthquake = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.beamearthquake;
    
    while ( true )
    {
        earthquakeadvanced( earthquake.magnitudemax, earthquake.magnitudemid, earthquake.magnitudemin, earthquake.duration, target.origin, earthquake.radiusmin, earthquake.radiusmid, earthquake.radiusmax );
        wait earthquake.duration;
    }
}

// Namespace zombie_uranus_beam
// Params 1, eflags: 0x4
// Checksum 0x899db6f3, Offset: 0x12bf
// Size: 0x20b
function private beam_attack_end( uranus_beam_target_ent )
{
    if ( uranus_beam_target_ent )
    {
        uranus_beam_target_ent utility::function_7c10ea82c1e305b8( "beam", "beam_off" );
        uranus_beam_target_ent.active = 0;
        
        if ( uranus_beam_target_ent.beamfx )
        {
            uranus_beam_target_ent.beamfx delete();
            uranus_beam_target_ent.beamfx = undefined;
        }
    }
    else if ( self.uranus_beam_target_ents )
    {
        foreach ( beam_target_ent in self.uranus_beam_target_ents )
        {
            beam_target_ent utility::function_7c10ea82c1e305b8( "beam", "beam_off" );
            
            if ( beam_target_ent.beamfx )
            {
                beam_target_ent.beamfx delete();
                beam_target_ent.beamfx = undefined;
            }
            
            beam_target_ent.active = 0;
        }
    }
    
    var_dc9701e5ec8e014a = 0;
    
    foreach ( beam_target_ent in self.uranus_beam_target_ents )
    {
        if ( beam_target_ent.active )
        {
            var_dc9701e5ec8e014a++;
        }
    }
    
    if ( isalive( self ) && var_dc9701e5ec8e014a == 0 )
    {
        zombie_uranus::start_cool_down( #"hash_93e3001c9613e202" );
        zombie_uranus::start_cool_down( #"hash_61ccd92bbf0ca313" );
        self.uranus_beam_attacking = 0;
        asm::asm_fireevent( self.asmname, "exit_loop" );
        zombie_uranus::end_action( "uranus_beam" );
        self notify( #"beam_attack_end" );
    }
}

// Namespace zombie_uranus_beam
// Params 0
// Checksum 0x32d99d75, Offset: 0x14d2
// Size: 0x54, Type: bool
function can_beam_attack()
{
    /#
        if ( getdvarint( @"hash_3e917da7a30eaca2" ) )
        {
            return false;
        }
    #/
    
    if ( !zombie_uranus::function_420be0b5922e064b() )
    {
        return false;
    }
    
    if ( self.uranus_beam_charging || self.uranus_beam_attacking )
    {
        return false;
    }
    
    if ( zombie_uranus::has_cool_down( #"hash_93e3001c9613e202" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_uranus_beam
// Params 2
// Checksum 0x228e5099, Offset: 0x152f
// Size: 0x66
function function_413aab3dbef9d757( taskid, params )
{
    targets = zombie_uranus::get_random_targets( 0 );
    
    if ( targets.size == 0 )
    {
        return anim.failure;
    }
    
    self.var_b9ccc2459bdce040 = targets[ 0 ];
    
    if ( !self.var_b9ccc2459bdce040 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_uranus_beam
// Params 2
// Checksum 0x2425c38a, Offset: 0x159e
// Size: 0x6f
function function_7c672c96bd082e1a( taskid, params )
{
    if ( !self.var_b9ccc2459bdce040 )
    {
        return anim.failure;
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    thread beam_charge( self.var_b9ccc2459bdce040, settings.var_805c58c776827370 );
    return anim.success;
}

// Namespace zombie_uranus_beam
// Params 2
// Checksum 0x659ad1ed, Offset: 0x1616
// Size: 0x4f
function function_30e91464a2e74e89( taskid, params )
{
    if ( !isalive( self.var_b9ccc2459bdce040 ) )
    {
        return anim.failure;
    }
    
    if ( self.uranus_beam_charging )
    {
        return anim.running;
    }
    
    return anim.success;
}

// Namespace zombie_uranus_beam
// Params 2
// Checksum 0x75fc54b2, Offset: 0x166e
// Size: 0x2e
function function_6623732813443d3a( taskid, params )
{
    thread beam_attack( self.var_b9ccc2459bdce040 );
    return anim.success;
}

// Namespace zombie_uranus_beam
// Params 2
// Checksum 0x60b66eca, Offset: 0x16a5
// Size: 0x34
function function_23c8aa9574c946a9( taskid, params )
{
    if ( self.uranus_beam_attacking )
    {
        return anim.running;
    }
    
    return anim.success;
}

/#

    // Namespace zombie_uranus_beam
    // Params 0
    // Checksum 0x13c29780, Offset: 0x16e2
    // Size: 0x51, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x48>" );
        devgui::add_devgui_func( "<dev string:x4e>", "<dev string:x63>", &function_56929a5b8baa7273, 1, 20 );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x82>", &debug_start_beam_attack, 0, 21 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_uranus_beam
    // Params 1, eflags: 0x4
    // Checksum 0xfe1249, Offset: 0x173b
    // Size: 0x24, Type: dev
    function private function_56929a5b8baa7273( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x94>", @"hash_3e917da7a30eaca2" );
    }

    // Namespace zombie_uranus_beam
    // Params 0, eflags: 0x4
    // Checksum 0xbbf96627, Offset: 0x1767
    // Size: 0x91, Type: dev
    function private debug_start_beam_attack()
    {
        var_733163115b05935e = level.debug_uranus;
        
        if ( !var_733163115b05935e )
        {
            return;
        }
        
        [ var_733163115b05935e.var_b9ccc2459bdce040 ] = var_733163115b05935e zombie_uranus::get_random_targets( 0 );
        
        if ( !var_733163115b05935e.var_b9ccc2459bdce040 )
        {
            return;
        }
        
        settings = var_733163115b05935e.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        var_733163115b05935e beam_charge( var_733163115b05935e.var_b9ccc2459bdce040, settings.var_805c58c776827370 );
    }

#/
