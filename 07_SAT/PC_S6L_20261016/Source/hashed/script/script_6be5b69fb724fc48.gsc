// script_6be5b69fb724fc48  (hash_6be5b69fb724fc48.gscc) (size: 5857 Bytes / 0x16e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5120e6f (3843165807)
// size ...... 5857 (0x16e1)
// includes .. 3   (offset: 0x15ed)
// strings ... 14  (offset: 0x1605)
// dev strs .. 2   (offset: 0x16c9)
// exports ... 15  (offset: 0xcb1)
// cseg ...... 0x147 + 0xb6a (0xcb1)
// imports ... 57  (offset: 0xf09)
// animtree1 . 0   (offset: 0x16e1)
// animtree2 . 0   (offset: 0x16e1)
#using scripts\asm\asm;
#using scripts\common\math;
#using scripts\common\utility;

#namespace namespace_4e91c4ed2c0457c1;

// Namespace namespace_4e91c4ed2c0457c1
// Params 0
// Checksum 0x88e4f4a3, Offset: 0x165
// Size: 0x9f
function function_8b1372bc3a2d158e()
{
    if ( isplayer( self.ranged_attack_target ) )
    {
        if ( self.ranged_attack_target function_ea1c30d42bd9c659() > self._blackboard.var_d751dec818290f98 )
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

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0x1a6c4671, Offset: 0x20c
// Size: 0x9e
function private manage_ranged_attack()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    thread function_30a6d2141f3a1af1();
    
    if ( !self._blackboard.var_99f794dc99944d15 )
    {
        self.projectile_attach_tag = "j_tongue_01";
        
        if ( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6.size > 0 )
        {
            self.var_d75eaefe66066143 = utility::array_random( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6 ).modelname;
        }
        
        asm::function_7256f5ba459c840b( "ranged_attack_in" );
        thread function_bf22d281c4651259();
    }
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 1, eflags: 0x4
// Checksum 0x741015f2, Offset: 0x2b2
// Size: 0x2d5
function private function_1f3d815e1511f7e( target )
{
    const_max_height = 30;
    gravity = getdvarfloat( @"bg_gravity" );
    targetpos = target geteye();
    
    if ( self.var_d6894f01a36b4ff3.var_8913bd01ec94af39 > 0 )
    {
        var_28923e9872f276ec = target getentityvelocity() * self.var_d6894f01a36b4ff3.var_8913bd01ec94af39;
        targetpos += var_28923e9872f276ec;
    }
    
    var_78cf8bd7fad69e78 = self gettagorigin( self.projectile_attach_tag );
    var_222d8c32cacafcfb = ( var_78cf8bd7fad69e78[ 0 ], var_78cf8bd7fad69e78[ 1 ], targetpos[ 2 ] );
    var_6752203b2ff0e94b = targetpos - var_222d8c32cacafcfb;
    var_ffc359536ebac83b = length( var_6752203b2ff0e94b );
    var_6752203b2ff0e94b = vectornormalize( var_6752203b2ff0e94b );
    var_11b18f1ac6dc624b = sqrt( 2 * gravity * const_max_height );
    a = -0.5 * gravity;
    b = var_11b18f1ac6dc624b;
    c = abs( var_222d8c32cacafcfb[ 2 ] );
    totaltime = ( -1 * b - sqrt( squared( b ) - 4 * a * c ) ) / 2 * a;
    var_76cfd46cb7c85258 = var_ffc359536ebac83b / totaltime;
    var_640e280f2ed8fb1a = var_76cfd46cb7c85258 * var_6752203b2ff0e94b;
    var_640e280f2ed8fb1a = ( var_640e280f2ed8fb1a[ 0 ], var_640e280f2ed8fb1a[ 1 ], var_11b18f1ac6dc624b );
    var_a3bbd36f4b1eda42 = asin( sqrt( 2 * gravity * const_max_height ) / length( var_640e280f2ed8fb1a ) );
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    upvec = anglestoup( self.angles );
    var_7e2c68e6fea83977 = vectordot( var_3d21eec29b566ffb, upvec );
    var_efc51695da7c705a = math::lerp_fraction( -1, 1, var_7e2c68e6fea83977 );
    var_2821d2f6651c0c99 = math::lerp( var_a3bbd36f4b1eda42, 0, var_efc51695da7c705a );
    rightvec = vectorcross( var_3d21eec29b566ffb, var_640e280f2ed8fb1a );
    var_d7c9f45bbf49fb0c = rotatepointaroundvector( rightvec, var_640e280f2ed8fb1a, var_2821d2f6651c0c99 );
    var_df0f11e015169fc8 = var_a3bbd36f4b1eda42 - var_2821d2f6651c0c99;
    starty = abs( var_78cf8bd7fad69e78[ 2 ] - targetpos[ 2 ] );
    finalx = var_ffc359536ebac83b;
    var_11b1911ac6dc66b1 = cos( var_df0f11e015169fc8 );
    var_11b1901ac6dc647e = sin( var_df0f11e015169fc8 );
    var_a06164b678e6037c = finalx / var_11b1911ac6dc66b1;
    var_e6280acbe849753f = 0.5 * gravity * squared( var_a06164b678e6037c );
    var_40f43dc4dc9f17d = starty + var_11b1901ac6dc647e * var_a06164b678e6037c;
    var_277034f3b7575612 = sqrt( var_e6280acbe849753f / var_40f43dc4dc9f17d );
    var_d7c9f45bbf49fb0c = var_277034f3b7575612 * vectornormalize( var_d7c9f45bbf49fb0c );
    return var_d7c9f45bbf49fb0c;
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0x8939415b, Offset: 0x590
// Size: 0x179
function private function_bf22d281c4651259()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    thread function_19c8fffa6488eee6();
    ranged_attack_weapon = self.grenadeweapon ?? "t10_zombie_ranged_attack_mp";
    self waittill( #"launch_grenade_start" );
    thread function_69a99a13682073c9();
    start_pos = self gettagorigin( self.projectile_attach_tag );
    
    if ( self._blackboard.var_397bfb4ed7256a7a && self._blackboard.var_697a504d7c395146 && isdefined( self.ranged_attack_target ) )
    {
        var_267d01d2be2d145 = function_1f3d815e1511f7e( self.ranged_attack_target );
    }
    else
    {
        var_267d01d2be2d145 = self function_d5e40e88a4ac1386( ranged_attack_weapon, self.ranged_attack_target, 0, 0 );
        
        if ( !isdefined( var_267d01d2be2d145 ) )
        {
            var_267d01d2be2d145 = self._blackboard.var_c894b0896ac6f7d;
        }
    }
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    grenade = magicgrenademanual( ranged_attack_weapon, start_pos, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    grenade.angles = self gettagangles( self.projectile_attach_tag );
    
    if ( isdefined( self.var_d75eaefe66066143 ) )
    {
        grenade setmodel( self.var_d75eaefe66066143 );
    }
    
    grenade utility::function_32b24db3127bff40( "spit", "aerial" );
    grenade thread function_1b4c5f8abd5f46a7();
    grenade thread function_5919705635a6b51();
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0xb897ff38, Offset: 0x711
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
    
    var_62e858c45bbf3f11 = utility::getfx( "vermin_ranged_attack_impact_fx" );
    
    if ( var_62e858c45bbf3f11 )
    {
        playfx( var_62e858c45bbf3f11, origin, forward, normal );
    }
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0x21f99934, Offset: 0x7c5
// Size: 0x66
function private function_5919705635a6b51()
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_player", hitent );
    var_62e858c45bbf3f11 = utility::getfx( "vermin_ranged_attack_screen_fx" );
    
    if ( isplayer( hitent ) && var_62e858c45bbf3f11 )
    {
        playfxontagforclients( var_62e858c45bbf3f11, hitent, "j_head", hitent );
    }
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 1, eflags: 0x4
// Checksum 0xefe3d02e, Offset: 0x833
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0x9078aabb, Offset: 0x859
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

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0xc4cb7fbd, Offset: 0x8b8
// Size: 0x3b
function private function_19c8fffa6488eee6()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit_charge", "mouth" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "spit_charge", "off" );
    }
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0, eflags: 0x4
// Checksum 0xde53943, Offset: 0x8fb
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

// Namespace namespace_4e91c4ed2c0457c1
// Params 0
// Checksum 0x5db5245a, Offset: 0x93e
// Size: 0x2a
function function_d6522b553acab81d()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        thread track_target_angles();
    }
}

// Namespace namespace_4e91c4ed2c0457c1
// Params 0
// Checksum 0x9cfb7e8f, Offset: 0x970
// Size: 0x153
function track_target_angles()
{
    self endon( #"death" );
    var_3f52a66d2d494317 = getdvarint( @"hash_1c37705df11066d9", 0 );
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
            
            if ( self._blackboard.var_397bfb4ed7256a7a || abs( targetpitch ) > var_78e4b20bb434aa )
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

// Namespace namespace_4e91c4ed2c0457c1
// Params 0
// Checksum 0xff2a7f84, Offset: 0xacb
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

// Namespace namespace_4e91c4ed2c0457c1
// Params 0
// Checksum 0xe4ee75c8, Offset: 0xbc2
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

