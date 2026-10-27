// script_30a9571ffe15fb54  (hash_30a9571ffe15fb54.gscc) (size: 6669 Bytes / 0x1a0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x62eec14d (1659814221)
// size ...... 6669 (0x1a0d)
// includes .. 3   (offset: 0x1909)
// strings ... 14  (offset: 0x1921)
// dev strs .. 2   (offset: 0x19f5)
// exports ... 16  (offset: 0xec5)
// cseg ...... 0x14c + 0xd79 (0xec5)
// imports ... 65  (offset: 0x1145)
// animtree1 . 0   (offset: 0x1a0d)
// animtree2 . 0   (offset: 0x1a0d)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_web;
#using scripts\common\utility;

#namespace namespace_67309db3d9145ae0;

// Namespace namespace_67309db3d9145ae0
// Params 0
// Checksum 0xb9d1bb18, Offset: 0x16a
// Size: 0xd5
function function_8b1372bc3a2d158e()
{
    if ( isplayer( self.ranged_attack_target ) )
    {
        if ( self.ranged_attack_target function_ea1c30d42bd9c659() > self._blackboard.var_d751dec818290f98 )
        {
            self._blackboard.var_65f32caa86b87a2 = 0;
            return;
        }
        
        if ( self.ranged_attack_target function_ab2359b30bdc3b6a( "web_projectile" ) >= self getaiblackboarddynamic( "web_projectile_max_target_count" ) )
        {
            self._blackboard.var_65f32caa86b87a2 = 0;
            return;
        }
    }
    
    if ( self.ranged_attack_cooldown > gettime() )
    {
        self._blackboard.var_65f32caa86b87a2 = 0;
        return;
    }
    
    self.ranged_attack_cooldown = gettime() + self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a * 1000;
    thread manage_ranged_attack();
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0x36441b0, Offset: 0x247
// Size: 0xb4
function private manage_ranged_attack()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    thread function_30a6d2141f3a1af1();
    
    if ( !self._blackboard.var_99f794dc99944d15 )
    {
        self.projectile_attach_tag = self.var_d6894f01a36b4ff3.projectileattachtag ?? "j_tail_root";
        
        if ( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6.size > 0 )
        {
            self.var_d75eaefe66066143 = utility::array_random( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6 ).modelname;
        }
        
        asm::function_7256f5ba459c840b( "ranged_attack_in" );
        thread function_bf22d281c4651259();
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0x8c85d315, Offset: 0x303
// Size: 0x2b0
function private function_bf22d281c4651259()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    
    if ( isplayer( self.ranged_attack_target ) )
    {
        self.ranged_attack_target function_a58e1bd7ca9f6222( "web_projectile" );
        thread function_6577328944e469b5();
    }
    
    utility::function_32b24db3127bff40( "spit_charge", "mouth" );
    self waittill( #"launch_grenade_start" );
    utility::function_32b24db3127bff40( "spit_charge", "off" );
    thread function_69a99a13682073c9();
    start_pos = self gettagorigin( self.projectile_attach_tag );
    start_pos += ( 0, 0, 25 );
    local_start_pos = coordtransformtranspose( start_pos, self.origin, self.angles );
    ranged_target_ent = isent( self.ranged_attack_target ) ? self.ranged_attack_target : undefined;
    gravity_scale = self.grenadeweapon.var_4b34df4cbe697f89;
    var_267d01d2be2d145 = self function_d5e40e88a4ac1386( self.grenadeweapon, ranged_target_ent, 0, 0, self.var_d6894f01a36b4ff3.var_119fef101c0ce9fd, self.var_d6894f01a36b4ff3.var_aa57d9825605b34b, self.var_d6894f01a36b4ff3.var_5e7bfcf78c63144b, local_start_pos, self.var_d6894f01a36b4ff3.var_b5ff4d8a226be5fc, gravity_scale );
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        var_267d01d2be2d145 = self._blackboard.var_c894b0896ac6f7d;
    }
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    grenade = magicgrenademanual( self.grenadeweapon, start_pos, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    grenade.angles = vectortoangles( var_267d01d2be2d145 );
    grenade.target_ent = ranged_target_ent;
    
    if ( isdefined( self.var_d75eaefe66066143 ) )
    {
        grenade setmodel( self.var_d75eaefe66066143 );
    }
    
    grenade utility::function_32b24db3127bff40( "spit", "aerial" );
    grenade thread function_1b4c5f8abd5f46a7();
    grenade thread function_5919705635a6b51( self );
    grenade thread function_c83761c7191cf52d( self );
    grenade thread function_2f3300c51b73f8a6( self, ranged_target_ent, self.var_554143a73ca3a67d );
    var_ad1efe5e8f84b51c = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a ) );
    jitter_amount = int( var_ad1efe5e8f84b51c * 0.1 );
    var_f087162b5946d58 = randomintrange( jitter_amount * -1, jitter_amount );
    self function_786bb6aa1b76c7ee( "ranged_attack_time", gettime() + var_ad1efe5e8f84b51c + var_f087162b5946d58 );
}

// Namespace namespace_67309db3d9145ae0
// Params 3, eflags: 0x4
// Checksum 0x4d9a0936, Offset: 0x5bb
// Size: 0x1d7
function private function_2f3300c51b73f8a6( owner, target, tolerance )
{
    if ( !isalive( target ) || !isalive( owner ) )
    {
        return;
    }
    
    self endon( #"death" );
    target endon( #"death" );
    bounds = target getboundshalfsize();
    radius = max( bounds[ 0 ], bounds[ 1 ] ) + tolerance;
    
    if ( radius <= 0 )
    {
        return;
    }
    
    check_dist_sqr = radius * radius;
    last_pos = self.origin;
    slow_factor = owner.var_697845a75531a531;
    slow_duration = owner.var_77b43222d017d38a;
    slow_cooldown = owner.var_a4ce25555468ce2f;
    
    while ( isalive( target ) && isalive( owner ) )
    {
        curr_pos = self.origin;
        target_origin = target.origin;
        target_height = isplayer( target ) ? target getplayerviewheight() : bounds[ 2 ];
        target_top = target_origin + ( 0, 0, target_height );
        to_target_flat = ( target_origin[ 0 ] - curr_pos[ 0 ], target_origin[ 1 ] - curr_pos[ 1 ], 0 );
        projectile_dir = curr_pos - last_pos;
        var_fd08df3e4d6e9c41 = ( projectile_dir[ 0 ], projectile_dir[ 1 ], 0 );
        closest_approach = function_8bc60184964417dc( last_pos, curr_pos, target_origin, target_top );
        
        if ( vectordot( to_target_flat, var_fd08df3e4d6e9c41 ) < 0 && closest_approach.distancesquared <= check_dist_sqr )
        {
            target zombie_loom_minion_web::web_target( owner, slow_factor, slow_duration, slow_cooldown );
            self detonate();
            return;
        }
        
        last_pos = curr_pos;
        waitframe();
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0xb5d4ebae, Offset: 0x79a
// Size: 0xac
function private function_1b4c5f8abd5f46a7()
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    rightvec = anglestoright( self.angles );
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    normal = isvector( var_4cd1a139c1b0c2b7 ) ? var_4cd1a139c1b0c2b7 : undefined;
    forward = undefined;
    
    if ( isdefined( normal ) )
    {
        forward = vectorcross( normal, rightvec );
    }
    
    var_62e858c45bbf3f11 = utility::getfx( "loom_minion_ranged_attack_impact_fx" );
    
    if ( var_62e858c45bbf3f11 )
    {
        playfx( var_62e858c45bbf3f11, origin, forward, normal );
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 1, eflags: 0x4
// Checksum 0xc688c684, Offset: 0x84e
// Size: 0x93
function private function_5919705635a6b51( owner )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    slow_factor = owner.var_697845a75531a531;
    slow_duration = owner.var_77b43222d017d38a;
    slow_cooldown = owner.var_a4ce25555468ce2f;
    self waittill( #"projectile_impact_player", hitent );
    
    if ( isplayer( hitent ) )
    {
        hitent zombie_loom_minion_web::web_target( owner, slow_factor, slow_duration, slow_cooldown );
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 1, eflags: 0x4
// Checksum 0x6f3a18d6, Offset: 0x8e9
// Size: 0x16e
function private function_c83761c7191cf52d( owner )
{
    if ( owner.var_4f5bcdc39e31d440 <= 0 )
    {
        return;
    }
    
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self endon( #"projectile_impact_player" );
    slow_factor = owner.var_697845a75531a531;
    slow_duration = owner.var_77b43222d017d38a;
    slow_cooldown = owner.var_a4ce25555468ce2f;
    query_radius = owner.var_4f5bcdc39e31d440;
    team = owner.team;
    self waittill( #"explode", impactpos );
    nearby_players = getplayersinradius( impactpos, query_radius, max( query_radius, 72 ), 1 );
    
    foreach ( player in nearby_players )
    {
        if ( player.team != team && isalive( player ) )
        {
            player zombie_loom_minion_web::web_target( owner, slow_factor, slow_duration, slow_cooldown );
        }
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0x414f3594, Offset: 0xa5f
// Size: 0x3a
function private function_6577328944e469b5()
{
    target = self.ranged_attack_target;
    utility::waittill_notify_or_timeout( "death", 3 );
    
    if ( isplayer( target ) )
    {
        target function_31d0b50675d9d6e( "web_projectile" );
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 1, eflags: 0x4
// Checksum 0x1d5fd839, Offset: 0xaa1
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0x6568a79a, Offset: 0xac7
// Size: 0x57
function private function_30a6d2141f3a1af1()
{
    var_e1b150b361aa0993 = self.ranged_attack_target;
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_884711fc94b10261();
    }
    
    utility::waittill_any( "terminate_ranged_attack", "death" );
    
    if ( isdefined( self ) )
    {
        self.projectile_attach_tag = undefined;
    }
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_88a6736ac53d2a25();
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0, eflags: 0x4
// Checksum 0xf8f53462, Offset: 0xb26
// Size: 0x3b
function private function_69a99a13682073c9()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit", "mouth" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "spit", "off" );
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0
// Checksum 0x1d1c7770, Offset: 0xb69
// Size: 0x2a
function function_c8b93063c30dc07f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        thread track_target_angles();
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0
// Checksum 0x7350c792, Offset: 0xb9b
// Size: 0x13c
function track_target_angles()
{
    self endon( #"death" );
    var_3f52a66d2d494317 = getdvarint( @"hash_2d0d3c2861266060", 0 );
    var_78e4b20bb434aa = 10;
    self function_af99635258e79543( 0 );
    self function_a8fe8d86843b9cee( 0 );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            targetpitch = function_e56cc8e53fd77526();
            targetpitch = angleclamp180( targetpitch );
            targetpitch = clamp( targetpitch, -45, 45 );
            
            if ( abs( targetpitch ) > var_78e4b20bb434aa )
            {
                targetyaw = 0;
            }
            else
            {
                targetpitch = 0;
                targetyaw = function_fb886bf979a6a84b();
                targetyaw = angleclamp180( targetyaw );
                targetyaw = clamp( targetyaw, -45, 45 );
            }
            
            self function_af99635258e79543( targetyaw );
            self function_a8fe8d86843b9cee( targetpitch );
            
            /#
                if ( var_3f52a66d2d494317 )
                {
                    print3d( self.origin, "<dev string:x24>" + targetyaw, ( 1, 0, 0 ), 1, 1, 1, 1 );
                    print3d( self.origin + ( 0, 0, -10 ), "<dev string:x31>" + targetpitch, ( 1, 0, 0 ), 1, 1, 1, 1 );
                }
            #/
        }
        
        waitframe();
    }
}

// Namespace namespace_67309db3d9145ae0
// Params 0
// Checksum 0xa3a72a5, Offset: 0xcdf
// Size: 0xee
function function_fb886bf979a6a84b()
{
    upvec = anglestoup( self.angles );
    vectotarget = self.enemy.origin - self.origin;
    var_2980533cea87923a = vectordot( upvec, vectotarget ) * upvec;
    var_84bff92eec7e3b12 = vectotarget - var_2980533cea87923a;
    forwardvec = anglestoforward( self.angles );
    var_8fc3c4bd3fa742 = clamp( vectordot( forwardvec, vectornormalize( var_84bff92eec7e3b12 ) ), -1, 1 );
    var_5d0fd8e48892c9e7 = acos( var_8fc3c4bd3fa742 );
    rightvec = anglestoright( self.angles );
    var_569daf9ae68807c9 = vectornormalize( vectotarget );
    
    if ( vectordot( rightvec, var_569daf9ae68807c9 ) < 0 )
    {
        var_5d0fd8e48892c9e7 = -1 * var_5d0fd8e48892c9e7;
    }
    
    return var_5d0fd8e48892c9e7;
}

// Namespace namespace_67309db3d9145ae0
// Params 0
// Checksum 0x11fe78e9, Offset: 0xdd6
// Size: 0xee
function function_e56cc8e53fd77526()
{
    rightvec = anglestoright( self.angles );
    vectotarget = self.enemy.origin - self.origin;
    var_2980533cea87923a = vectordot( rightvec, vectotarget ) * rightvec;
    var_84bff92eec7e3b12 = vectotarget - var_2980533cea87923a;
    forwardvec = anglestoforward( self.angles );
    var_ba0f5f467ac792bd = clamp( vectordot( forwardvec, vectornormalize( var_84bff92eec7e3b12 ) ), -1, 1 );
    var_df877174f816e91c = acos( var_ba0f5f467ac792bd );
    upvec = anglestoup( self.angles );
    var_569daf9ae68807c9 = vectornormalize( vectotarget );
    
    if ( vectordot( upvec, var_569daf9ae68807c9 ) < 0 )
    {
        var_df877174f816e91c = -1 * var_df877174f816e91c;
    }
    
    return var_df877174f816e91c;
}

