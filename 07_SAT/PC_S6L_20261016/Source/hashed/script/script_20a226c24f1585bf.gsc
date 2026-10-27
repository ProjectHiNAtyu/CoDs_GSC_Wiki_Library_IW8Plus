// script_20a226c24f1585bf  (hash_20a226c24f1585bf.gscc) (size: 8574 Bytes / 0x217e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7c1ca8b (3082930827)
// size ...... 8574 (0x217e)
// includes .. 6   (offset: 0x2062)
// strings ... 18  (offset: 0x2092)
// dev strs .. 0   (offset: 0x217e)
// exports ... 16  (offset: 0x161e)
// cseg ...... 0x1c9 + 0x1455 (0x161e)
// imports ... 65  (offset: 0x189e)
// animtree1 . 0   (offset: 0x217e)
// animtree2 . 0   (offset: 0x217e)
#using script_2304453c69e996e2;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;

#namespace namespace_29dc0e7dd0232a5f;

// Namespace namespace_29dc0e7dd0232a5f
// Params 5
// Checksum 0xee046b49, Offset: 0x1e7
// Size: 0x3b1
function function_c096301eee95e66a( settings_bundle_name, var_1d7db852c9f1d31c, var_78ecc2c4155e1171, var_382a357bc5e77ba4, var_287192f54485c02f )
{
    if ( isdefined( var_382a357bc5e77ba4 ) )
    {
        var_9c56371fda28cf1b = var_382a357bc5e77ba4;
    }
    else
    {
        var_9c56371fda28cf1b = &function_b8043bcd6dd6be32;
    }
    
    vehicle_ref = vehicle::get_ref();
    var_e6a5fa52a2e9a3d0 = [];
    
    switch ( vehicle_ref )
    {
        case %"hash_1dd941f8f4026e3":
            var_e6a5fa52a2e9a3d0 = [ "tag_turret_front", "tag_turret_rear" ];
            break;
        case %"hash_1d1b82560f0cf69f":
            var_e6a5fa52a2e9a3d0 = [ "tag_turret" ];
            break;
        case #"hash_343a0ff44c1e5130":
            var_e6a5fa52a2e9a3d0 = [ "tag_turret" ];
            break;
        default:
            return;
    }
    
    if ( !isdefined( level._effect[ "turret_muzflash" ] ) )
    {
        level._effect[ "turret_muzflash" ] = loadfxasset( "vfx_core_muz_minigun_flash_cheap" );
    }
    
    self.turrets = [];
    
    foreach ( index, turret_tag in var_e6a5fa52a2e9a3d0 )
    {
        self.turrets[ index ] = spawnturret( "misc_turret", self gettagorigin( turret_tag ), "chopper_support_turret_mp" );
        
        if ( isdefined( self.turrets[ index ] ) )
        {
            self.turrets[ index ] setmodel( "veh9_mil_air_heli_hind_turret_mp" );
            self.turrets[ index ].team = self.team;
            self.turrets[ index ].angles = self.angles;
            
            if ( self.is_landed )
            {
                self.turrets[ index ].turreton = 0;
            }
            else
            {
                self.turrets[ index ].turreton = 1;
            }
            
            self.turrets[ index ].name = "heli_turret";
            self.turrets[ index ].current_target = undefined;
            self.turrets[ index ].turret_tag = turret_tag;
            self.turrets[ index ] linkto( self, turret_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            self.turrets[ index ] setturretteam( var_1d7db852c9f1d31c );
            self.turrets[ index ] setturretmodechangewait( 0 );
            self.turrets[ index ] setmode( "manual" );
            self.turrets[ index ] maketurretinoperable();
            self.turrets[ index ] makeunusable();
            settings_bundle_name = "magicturretsettings:" + settings_bundle_name;
            var_300037d32586873c = getscriptbundle( settings_bundle_name );
            var_7c625b4ebe90c02b = getscriptbundlenames( "magicturretsettings" );
            self.turrets[ index ] function_23e279078bfd5c73( var_300037d32586873c );
            self.turrets[ index ].team = var_1d7db852c9f1d31c;
            self.turrets[ index ].var_78ecc2c4155e1171 = var_78ecc2c4155e1171;
            self.turrets[ index ].var_9c56371fda28cf1b = var_9c56371fda28cf1b;
            self.turrets[ index ] function_2dcd4fada4e053c7( self, var_287192f54485c02f );
        }
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 1
// Checksum 0x1eaf4128, Offset: 0x5a0
// Size: 0x8a
function function_f8cbfe58b1b9a626( var_9c56371fda28cf1b )
{
    foreach ( turret in self.turrets )
    {
        turret.var_9c56371fda28cf1b = var_9c56371fda28cf1b;
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 2, eflags: 0x4
// Checksum 0x5ffc5c12, Offset: 0x632
// Size: 0x56
function private function_2dcd4fada4e053c7( vehicle, var_287192f54485c02f )
{
    vehicle endon( #"death" );
    vehicle endon( #"crashing" );
    vehicle endon( #"entitydeleted" );
    childthread function_a6252a223adbba4e();
    childthread function_ffa7660257bdf137( vehicle, var_287192f54485c02f );
    childthread function_f7ef49e612cbde07( vehicle );
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 1, eflags: 0x4
// Checksum 0xad610f3a, Offset: 0x690
// Size: 0x136
function private function_f7ef49e612cbde07( vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"crashing" );
    vehicle endon( #"entitydeleted" );
    self endon( #"death" );
    self setcandamage( 1 );
    self.maxhealth = 1000;
    self.health = 1000;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( attacker ) && !arraycontains( level.players, attacker ) )
        {
            self.health += amount;
            waitframe();
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 3, eflags: 0x4
// Checksum 0x11422ebd, Offset: 0x7ce
// Size: 0x1c0
function private function_ffa7660257bdf137( vehicle, var_287192f54485c02f, var_b15b2b92955785db )
{
    vehicle endon( #"death" );
    vehicle endon( #"crashing" );
    vehicle endon( #"entitydeleted" );
    self endon( #"death" );
    
    if ( !isdefined( var_b15b2b92955785db ) )
    {
        var_b15b2b92955785db = 3;
    }
    
    self.groundtargetent = spawn( "script_model", self.origin );
    self.groundtargetent setmodel( "tag_origin" );
    self.groundtargetent dontinterpolate();
    self settargetentity( self.groundtargetent );
    wait randomfloatrange( 1, 3 );
    
    while ( true )
    {
        if ( self.turreton )
        {
            current_target = [[ self.var_9c56371fda28cf1b ]]( vehicle );
            
            if ( isdefined( current_target ) )
            {
                if ( var_287192f54485c02f )
                {
                    if ( isplayer( current_target ) )
                    {
                        if ( !vehicle namespace_28acf6540b1bc740::heli_can_see_player( current_target ) )
                        {
                            wait var_b15b2b92955785db;
                            continue;
                        }
                    }
                    else if ( !vehicle namespace_28acf6540b1bc740::function_fb0e721df8b42022( current_target ) )
                    {
                        wait var_b15b2b92955785db;
                        continue;
                    }
                }
                
                vehicle notify( #"target_acquired" );
                vehicle.current_target = current_target;
                
                if ( function_4de57a6807875242( vehicle, current_target ) < self.var_359a527374fa8064 )
                {
                    waitframe();
                    continue;
                }
                
                childthread function_eb47d8dc040c073d( vehicle, current_target, self.var_d498ef3b54fe480f, self.minscaledistance, self.maxscaledistance, self.var_3393b95d38b4b807, self.var_3f427ac2a9b45b61, self.var_a89aa233943c9719, self.var_b23ee29a62af3a1f );
                function_4c7719c18ef5a176( vehicle, current_target );
            }
        }
        
        wait randomfloatrange( self.burst_delay_min, self.burst_delay_max );
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 1, eflags: 0x4
// Checksum 0x866da28d, Offset: 0x996
// Size: 0x3f5
function private function_b8043bcd6dd6be32( vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"crashing" );
    vehicle endon( #"entitydeleted" );
    self endon( #"death" );
    canseetarget = 0;
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    var_847f780b10d918e5 = [ vehicle, self ];
    var_a6d716663bee7b52 = sortbydistancecullbyradius( level.players, self.origin, self.var_5c765c85ea5d3fa0 );
    
    if ( var_a6d716663bee7b52.size > 0 )
    {
        foreach ( player in var_a6d716663bee7b52 )
        {
            if ( player::isinlaststand( player ) || player.ignoreme || player.notarget )
            {
                continue;
            }
            
            target_direction = player.origin - vehicle.origin;
            dot = vectordot2( target_direction, anglestoforward( vehicle.angles ), 1 );
            
            if ( dot < self.var_359a527374fa8064 )
            {
                continue;
            }
            
            if ( player vehicle::is_in_vehicle() )
            {
                occupiedvehicle = player vehicle::get_vehicle();
                var_847f780b10d918e5[ var_847f780b10d918e5.size ] = occupiedvehicle;
                linkedmodels = occupiedvehicle getlinkedchildren();
                
                if ( linkedmodels.size > 0 )
                {
                    var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
                }
            }
            
            if ( player tagexists( "j_head" ) )
            {
                canseetarget = trace::ray_trace_passed( vehicle gettagorigin( self.turret_tag ), player gettagorigin( "j_head" ), var_847f780b10d918e5, contentsoverride );
            }
            
            if ( canseetarget )
            {
                return player;
            }
        }
    }
    
    var_cd7b8b983418064 = [];
    
    foreach ( ai_team in self.var_78ecc2c4155e1171 )
    {
        var_cd7b8b983418064 = arraycombine( var_cd7b8b983418064, getaiarray( ai_team ) );
    }
    
    if ( var_cd7b8b983418064.size > 0 )
    {
        sorted_non_players = sortbydistancecullbyradius( var_cd7b8b983418064, self.origin, self.var_5c765c85ea5d3fa0 );
        
        if ( sorted_non_players.size > 0 )
        {
            foreach ( non_player in sorted_non_players )
            {
                target_direction = non_player.origin - vehicle.origin;
                dot = vectordot2( target_direction, anglestoforward( vehicle.angles ), 1 );
                
                if ( dot < self.var_359a527374fa8064 )
                {
                    continue;
                }
                
                if ( isdefined( non_player.vehicle ) && isdefined( non_player.vehicle_position ) )
                {
                    var_847f780b10d918e5[ var_847f780b10d918e5.size ] = non_player.vehicle;
                    linkedmodels = non_player.vehicle getlinkedchildren();
                    
                    if ( linkedmodels.size > 0 )
                    {
                        var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
                    }
                }
                
                canseetarget = trace::ray_trace_passed( vehicle gettagorigin( self.turret_tag ), non_player geteye(), var_847f780b10d918e5, contentsoverride );
                
                if ( canseetarget )
                {
                    return non_player;
                }
            }
        }
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 9, eflags: 0x4
// Checksum 0x15551f35, Offset: 0xd94
// Size: 0x3ef
function private function_eb47d8dc040c073d( vehicle, current_target, var_d498ef3b54fe480f, minscaledistance, maxscaledistance, var_3393b95d38b4b807, var_3f427ac2a9b45b61, var_a89aa233943c9719, var_b23ee29a62af3a1f )
{
    self endon( #"stop_turret_burst" );
    var_17173edc14e8a4fd = randomintrange( self.var_50213e7d348b675f, self.var_4ffe4c7d34653e71 );
    
    if ( var_d498ef3b54fe480f == "scaleByTime" )
    {
        burst_length = var_17173edc14e8a4fd * self.var_9f9f7dbdd5c0f1ea * 1000;
        end_time = gettime() + burst_length;
    }
    
    for ( i = 0; i < var_17173edc14e8a4fd ; i++ )
    {
        if ( !isdefined( current_target ) || isplayer( current_target ) && player::isinlaststand( current_target ) )
        {
            break;
        }
        
        var_361b6f15315a86fb = vehicle gettagorigin( self.turret_tag );
        targetposition = current_target getcentroid();
        targetdirection = targetposition - var_361b6f15315a86fb;
        targetdistance = length( targetdirection );
        targetdirection /= targetdistance;
        targetleft = vectorcross( ( 0, 0, 1 ), targetdirection );
        var_72123caa173b3d6a = vectorcross( targetdirection, targetleft );
        var_51e501604d282e50 = randomfloatrange( 0, 360 );
        var_6ada723395ba6c6d = axistoangles( targetdirection, targetleft * -1, var_72123caa173b3d6a );
        randomdirection = vectornormalize( ( 0, randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) );
        targetoffset = rotatevector( randomdirection, var_6ada723395ba6c6d );
        
        switch ( var_d498ef3b54fe480f )
        {
            case #"hash_34770b8adabe2feb":
                assert( maxscaledistance );
                var_e12de599ae0075c8 = clamp( ( targetdistance - minscaledistance ) / maxscaledistance, 0, 1 );
                minspread = math::lerp( var_3393b95d38b4b807, var_3f427ac2a9b45b61, var_e12de599ae0075c8 );
                maxspread = math::lerp( var_a89aa233943c9719, var_b23ee29a62af3a1f, var_e12de599ae0075c8 );
                var_e878a5e01e1e23e5 = randomfloatrange( minspread, maxspread );
                var_8b37317997ab5a27 = targetposition + targetoffset * var_e878a5e01e1e23e5;
                break;
            case #"hash_c088e0bbec822829":
                var_c64d04130ef3c7b2 = clamp( ( end_time - gettime() ) / burst_length, 0, 1 );
                minspread = math::lerp( var_3393b95d38b4b807, var_3f427ac2a9b45b61, var_c64d04130ef3c7b2 );
                maxspread = math::lerp( var_a89aa233943c9719, var_b23ee29a62af3a1f, var_c64d04130ef3c7b2 );
                var_e878a5e01e1e23e5 = randomfloatrange( minspread, maxspread );
                var_8b37317997ab5a27 = targetposition + targetoffset * var_e878a5e01e1e23e5;
                break;
            default:
                var_e878a5e01e1e23e5 = randomfloatrange( var_3393b95d38b4b807, var_a89aa233943c9719 );
                var_8b37317997ab5a27 = targetposition + targetoffset * var_e878a5e01e1e23e5;
                break;
        }
        
        /#
            var_f298853c344502c0 = getdvarint( @"hash_a5451df7c00d0400", 0 );
            
            if ( var_f298853c344502c0 )
            {
                duration = 800;
                line( targetposition, targetposition + targetleft * 30, ( 1, 0, 0 ), 1, 0, duration );
                line( targetposition, targetposition + targetdirection * 30, ( 0, 1, 0 ), 1, 0, duration );
                line( targetposition, targetposition + var_72123caa173b3d6a * 30, ( 0, 0, 1 ), 1, 0, duration );
                line( targetposition, var_8b37317997ab5a27, ( 1, 1, 0 ), 1, 0, duration );
                sphere( targetposition, minspread, ( 0.17, 1, 1 ), 0, duration );
                sphere( targetposition, maxspread, ( 0, 0, 1 ), 0, duration );
            }
        #/
        
        self.groundtargetent dontinterpolate();
        self.groundtargetent.origin = var_8b37317997ab5a27;
        self shootturret( "tag_flash", 6 );
        playfxontag( utility::getfx( "turret_muzflash" ), self, "tag_flash" );
        wait self.var_9f9f7dbdd5c0f1ea;
    }
    
    self notify( #"turret_burst_complete" );
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 2, eflags: 0x4
// Checksum 0x91385653, Offset: 0x118b
// Size: 0x56
function private function_4c7719c18ef5a176( vehicle, current_target )
{
    self endon( #"turret_burst_complete" );
    
    while ( true )
    {
        if ( function_4de57a6807875242( vehicle, current_target ) < self.var_359a527374fa8064 )
        {
            self notify( #"stop_turret_burst" );
            return;
        }
        
        wait self.var_9f9f7dbdd5c0f1ea;
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 1
// Checksum 0x1ffd7937, Offset: 0x11e9
// Size: 0x261
function function_23e279078bfd5c73( var_300037d32586873c )
{
    hasturret = var_300037d32586873c.hasturret ?? 0;
    var_5c765c85ea5d3fa0 = var_300037d32586873c.firerange ?? 2560;
    var_52284971217c2932 = var_300037d32586873c.var_a79b66fd24b67af6 ?? 45;
    var_9f9f7dbdd5c0f1ea = var_300037d32586873c.firedelay ?? 0.1;
    var_d09dafd0da560138 = var_300037d32586873c.var_2d332d5c86c5af6b ?? 12;
    var_d0c0c5d0da7c7952 = var_300037d32586873c.var_2d0f435c869d6515 ?? 16;
    burst_delay_min = var_300037d32586873c.var_807e0c0ede5f3009 ?? 2;
    burst_delay_max = var_300037d32586873c.var_805afe0ede38c987 ?? 4;
    var_d498ef3b54fe480f = var_300037d32586873c.var_d498ef3b54fe480f ?? "None";
    minscaledistance = var_300037d32586873c.minscaledistance ?? 1500;
    maxscaledistance = var_300037d32586873c.maxscaledistance ?? 4000;
    var_3393b95d38b4b807 = var_300037d32586873c.var_3393b95d38b4b807 ?? 20;
    var_a89aa233943c9719 = var_300037d32586873c.var_a89aa233943c9719 ?? 25;
    var_3f427ac2a9b45b61 = var_300037d32586873c.var_3f427ac2a9b45b61 ?? 50;
    var_b23ee29a62af3a1f = var_300037d32586873c.var_b23ee29a62af3a1f ?? 60;
    self.hasturret = hasturret;
    self.var_5c765c85ea5d3fa0 = var_5c765c85ea5d3fa0;
    self.var_fcb7420205a5939e = var_5c765c85ea5d3fa0;
    self.var_52284971217c2932 = var_52284971217c2932;
    self.var_359a527374fa8064 = cos( var_52284971217c2932 );
    self.var_9f9f7dbdd5c0f1ea = var_9f9f7dbdd5c0f1ea;
    self.var_50213e7d348b675f = var_d09dafd0da560138;
    self.var_4ffe4c7d34653e71 = var_d0c0c5d0da7c7952;
    self.var_d498ef3b54fe480f = var_d498ef3b54fe480f;
    self.burst_delay_min = burst_delay_min;
    self.burst_delay_max = burst_delay_max;
    self.minscaledistance = minscaledistance;
    self.maxscaledistance = maxscaledistance;
    self.var_3393b95d38b4b807 = var_3393b95d38b4b807;
    self.var_a89aa233943c9719 = var_a89aa233943c9719;
    self.var_3f427ac2a9b45b61 = var_3f427ac2a9b45b61;
    self.var_b23ee29a62af3a1f = var_b23ee29a62af3a1f;
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 1
// Checksum 0x2a80a646, Offset: 0x1452
// Size: 0x17
function function_bbf46c28eb6801c3( range )
{
    self.var_5c765c85ea5d3fa0 = range;
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 0
// Checksum 0xe618fd3d, Offset: 0x1471
// Size: 0x14
function reset_turret_range()
{
    self.var_5c765c85ea5d3fa0 = self.var_fcb7420205a5939e;
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 0
// Checksum 0xb0ca3298, Offset: 0x148d
// Size: 0xc
function function_c5e47f89c2e5b5c9()
{
    self.turreton = 0;
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 0
// Checksum 0x425dde9e, Offset: 0x14a1
// Size: 0xd
function function_5be10d63ce26cece()
{
    self.turreton = 1;
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 0
// Checksum 0xbf855ad6, Offset: 0x14b6
// Size: 0x110
function function_a6252a223adbba4e()
{
    while ( true )
    {
        burst_delay_min = getdvarfloat( @"hash_26a1c7b26c4d5065", -1 );
        
        if ( burst_delay_min != -1 && self.burst_delay_min != burst_delay_min )
        {
            self.burst_delay_min = burst_delay_min;
            
            if ( self.burst_delay_max < self.burst_delay_min )
            {
                setdvar( @"hash_34f933a0fc55b25f", self.burst_delay_min + 1 );
            }
        }
        
        burst_delay_max = getdvarfloat( @"hash_34f933a0fc55b25f", -1 );
        
        if ( burst_delay_max != -1 && self.burst_delay_max != burst_delay_max && burst_delay_max > self.burst_delay_min )
        {
            self.burst_delay_max = burst_delay_max;
        }
        
        var_52284971217c2932 = getdvarfloat( @"hash_b59235a8286b8e3d", -1 );
        
        if ( var_52284971217c2932 != -1 && self.var_52284971217c2932 != var_52284971217c2932 )
        {
            self.var_52284971217c2932 = var_52284971217c2932;
            self.var_359a527374fa8064 = cos( var_52284971217c2932 );
        }
        
        waitframe();
    }
}

// Namespace namespace_29dc0e7dd0232a5f
// Params 2, eflags: 0x4
// Checksum 0x5814020c, Offset: 0x15ce
// Size: 0x4f
function private function_4de57a6807875242( attacker, targ )
{
    target_direction = targ.origin - attacker.origin;
    return vectordot2( target_direction, anglestoforward( attacker.angles ), 1 );
}

