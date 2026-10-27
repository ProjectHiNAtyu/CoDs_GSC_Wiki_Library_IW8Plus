// script_1bfe8e965532ee8a  (hash_1bfe8e965532ee8a.gscc) (size: 3436 Bytes / 0xd6c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0504aa1 (3494922913)
// size ...... 3436 (0xd6c)
// includes .. 2   (offset: 0xcb8)
// strings ... 12  (offset: 0xcc8)
// dev strs .. 1   (offset: 0xd60)
// exports ... 11  (offset: 0x798)
// cseg ...... 0x143 + 0x655 (0x798)
// imports ... 30  (offset: 0x950)
// animtree1 . 0   (offset: 0xd6c)
// animtree2 . 0   (offset: 0xd6c)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace namespace_ad26fae8b8e8dfb9;

// Namespace namespace_ad26fae8b8e8dfb9
// Params 0
// Checksum 0xb5883a44, Offset: 0x161
// Size: 0x10
function init_ranged_attack_asm()
{
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 1
// Checksum 0xd29427ba, Offset: 0x179
// Size: 0x11f
function function_8b1372bc3a2d158e( targets )
{
    if ( self.ranged_attack_cooldown > gettime() )
    {
        self._blackboard.var_65f32caa86b87a2 = 0;
        return;
    }
    
    if ( !isdefined( targets ) )
    {
        targets = [ self.ranged_attack_target ];
    }
    
    var_f23a510da98de33f = [];
    
    foreach ( var_e1b150b361aa0993 in targets )
    {
        if ( isplayer( var_e1b150b361aa0993 ) )
        {
            if ( var_e1b150b361aa0993 function_ea1c30d42bd9c659() > self._blackboard.var_d751dec818290f98 )
            {
                continue;
            }
        }
        
        var_f23a510da98de33f[ var_f23a510da98de33f.size ] = var_e1b150b361aa0993;
    }
    
    if ( var_f23a510da98de33f.size == 0 )
    {
        self._blackboard.var_65f32caa86b87a2 = 0;
        return;
    }
    
    asm::function_7256f5ba459c840b( "ranged_attack_in" );
    thread manage_ranged_attack( var_f23a510da98de33f );
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 1, eflags: 0x4
// Checksum 0xbb57b393, Offset: 0x2a0
// Size: 0x120
function private manage_ranged_attack( targets )
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    
    if ( !isdefined( self.projectile_attach_tag ) )
    {
        self.projectile_attach_tag = "tag_weakpoint_mouth";
    }
    
    self waittill( #"hash_d7fc50931463bb39" );
    
    foreach ( var_e1b150b361aa0993 in targets )
    {
        if ( !isalive( var_e1b150b361aa0993 ) )
        {
            continue;
        }
        
        target_point = var_e1b150b361aa0993.origin;
        
        if ( var_e1b150b361aa0993 tagexists( "j_spine4" ) )
        {
            target_point = var_e1b150b361aa0993 gettagorigin( "j_spine4" );
        }
        
        function_bf22d281c4651259( target_point, var_e1b150b361aa0993 );
    }
    
    self.ranged_attack_cooldown = gettime() + self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a * 1000;
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 2, eflags: 0x4
// Checksum 0x9ef2971c, Offset: 0x3c8
// Size: 0x114
function private function_bf22d281c4651259( target_pos, var_e1b150b361aa0993 )
{
    if ( !isdefined( target_pos ) )
    {
        return;
    }
    
    thread function_30a6d2141f3a1af1( var_e1b150b361aa0993 );
    start_pos = self gettagorigin( self.projectile_attach_tag );
    var_ee6433c31961982d = target_pos - start_pos;
    
    if ( lengthsquared( var_ee6433c31961982d ) == 0 )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    gravity = getdvarfloat( @"bg_lowgravity", 400 );
    time = length( ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 ) ) / 700;
    launch_speed_z = ( 0.5 * gravity * squared( time ) + var_ee6433c31961982d[ 2 ] ) / time;
    var_ee6433c31961982d = vectornormalize( ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 ) );
    var_dcee11752ff222a4 = magicgrenademanual( self.grenadeweapon, start_pos, ( var_ee6433c31961982d[ 0 ] * 700, var_ee6433c31961982d[ 1 ] * 700, launch_speed_z ), self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    var_dcee11752ff222a4 thread watch_grenade_impact();
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 0, eflags: 0x4
// Checksum 0x8d86b50c, Offset: 0x4e4
// Size: 0x55
function private watch_grenade_impact()
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_player", hitent );
    
    if ( isplayer( hitent ) )
    {
        playfxontagforclients( utility::getfx( "player_hit_by_mimic_ranged_attack_fx" ), hitent, "j_head", hitent );
    }
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 5
// Checksum 0xdd24b30a, Offset: 0x541
// Size: 0x6f
function function_2408adb3cab0c16c( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( isdefined( eattacker.ranged_grenade_damage ) && isdefined( eattacker.grenadeweapon ) && objweapon == eattacker.grenadeweapon )
    {
        idamage = eattacker.ranged_grenade_damage;
    }
    
    return idamage;
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 1, eflags: 0x4
// Checksum 0x7b0f5856, Offset: 0x5b9
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 1, eflags: 0x4
// Checksum 0x32e50bae, Offset: 0x5df
// Size: 0x3d
function private function_30a6d2141f3a1af1( var_e1b150b361aa0993 )
{
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_884711fc94b10261();
    }
    
    utility::waittill_any( "terminate_ranged_attack", "death" );
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_88a6736ac53d2a25();
    }
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 4
// Checksum 0xdef5f6ec, Offset: 0x624
// Size: 0x81, Type: bool
function function_99d9ff5b13d4dc09( asmname, statename, tostatename, params )
{
    target = self.ranged_attack_target;
    
    if ( isdefined( target ) )
    {
        targetyaw = vectortoyaw( target.origin - self.origin );
        return ( abs( angleclamp180( self.angles[ 1 ] - targetyaw ) ) > 25 );
    }
    
    return false;
}

// Namespace namespace_ad26fae8b8e8dfb9
// Params 3
// Checksum 0x4b4801b9, Offset: 0x6ae
// Size: 0xe9
function function_867dbc92b8abf99a( asmname, statename, params )
{
    target = self.ranged_attack_target;
    alias = "ranged_attack";
    
    if ( isdefined( target ) )
    {
        if ( target.origin[ 2 ] - self.origin[ 2 ] > 200 )
        {
            alias = "ranged_attack_high";
        }
        else
        {
            targetyaw = vectortoyaw( target.origin - self.origin );
            var_c706a050d5655ef9 = angleclamp180( self.angles[ 1 ] - targetyaw );
            
            if ( var_c706a050d5655ef9 < -25 )
            {
                alias = "ranged_attack_left";
            }
            else if ( var_c706a050d5655ef9 > 25 )
            {
                alias = "ranged_attack_right";
            }
        }
    }
    
    result = asm::asm_lookupanimfromalias( statename, alias );
    return result;
}

