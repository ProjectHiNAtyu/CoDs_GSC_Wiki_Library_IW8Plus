// script_79289efe13773540  (hash_79289efe13773540.gscc) (size: 3097 Bytes / 0xc19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58f8ce48 (1492700744)
// size ...... 3097 (0xc19)
// includes .. 2   (offset: 0xb59)
// strings ... 12  (offset: 0xb69)
// dev strs .. 1   (offset: 0xc0d)
// exports ... 9   (offset: 0x62d)
// cseg ...... 0x116 + 0x517 (0x62d)
// imports ... 34  (offset: 0x795)
// animtree1 . 0   (offset: 0xc19)
// animtree2 . 0   (offset: 0xc19)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace namespace_75a5bbd3a938f9df;

// Namespace namespace_75a5bbd3a938f9df
// Params 0
// Checksum 0x41ced039, Offset: 0x134
// Size: 0xf4
function function_8b1372bc3a2d158e()
{
    assert( isdefined( self.grenadeweapon ), "<dev string:x24>" );
    
    if ( isplayer( self.ranged_attack_target ) )
    {
        concurrent_attacks = self.ranged_attack_target function_ab2359b30bdc3b6a( "spit_attack" );
        
        /#
            var_c338a9ae91c40768 = getdvarint( @"scr_parasite_debug", 0 ) == 3;
            
            if ( var_c338a9ae91c40768 )
            {
                debug_color = concurrent_attacks >= self._blackboard.var_22b3c9556dff44b1 ? ( 1, 0, 0 ) : ( 0, 1, 0 );
                debugstar( self.origin, debug_color, 10, concurrent_attacks );
            }
        #/
        
        if ( concurrent_attacks >= self._blackboard.var_22b3c9556dff44b1 )
        {
            self._blackboard.var_65f32caa86b87a2 = 0;
            return;
        }
    }
    
    thread manage_ranged_attack();
}

// Namespace namespace_75a5bbd3a938f9df
// Params 0, eflags: 0x4
// Checksum 0xb8ef0842, Offset: 0x230
// Size: 0xea
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
        
        spit_attack_cooldown = int( utility::function_4b74c15943231980( randomfloatrange( self.var_fe9bb2f0c2468d9a, self.var_95fe29c1ef1d5ac0 ) ) );
        self function_786bb6aa1b76c7ee( "ranged_attack_cooldown", spit_attack_cooldown );
        asm::function_7256f5ba459c840b( "ranged_attack_in" );
        thread function_bf22d281c4651259( self._blackboard.var_c894b0896ac6f7d );
    }
}

// Namespace namespace_75a5bbd3a938f9df
// Params 1, eflags: 0x4
// Checksum 0xf7dd0027, Offset: 0x322
// Size: 0x129
function private function_bf22d281c4651259( var_267d01d2be2d145 )
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    thread spit_mouth_glow();
    self waittill( #"launch_grenade_start" );
    start_pos = self gettagorigin( self.projectile_attach_tag );
    ranged_weapon = self.grenadeweapon;
    
    if ( isdefined( self.ranged_attack_target ) )
    {
        var_12095e4a686b23f2 = self function_d5e40e88a4ac1386( ranged_weapon, self.ranged_attack_target, 0, 0 );
        var_267d01d2be2d145 = var_12095e4a686b23f2 ?? var_267d01d2be2d145;
    }
    
    grenade = magicgrenademanual( ranged_weapon, start_pos, var_267d01d2be2d145, 8, self );
    grenade.angles = self gettagangles( self.projectile_attach_tag );
    
    if ( isdefined( self.var_d75eaefe66066143 ) )
    {
        grenade setmodel( self.var_d75eaefe66066143 );
    }
    
    if ( isdefined( self.var_9202ed60c8e01258 ) )
    {
        grenade.var_9202ed60c8e01258 = self.var_9202ed60c8e01258;
    }
    
    grenade utility::function_32b24db3127bff40( "spit", "aerial" );
    grenade thread watch_grenade_impact();
}

// Namespace namespace_75a5bbd3a938f9df
// Params 0, eflags: 0x4
// Checksum 0x6413dbc9, Offset: 0x453
// Size: 0x96
function private watch_grenade_impact()
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    normal = isvector( var_4cd1a139c1b0c2b7 ) ? var_4cd1a139c1b0c2b7 : undefined;
    var_2f7ee79efdc2bbec = utility::function_e153375527829ec3( self.var_9202ed60c8e01258, "parasite_spit_attack_impact_fx" );
    var_62e858c45bbf3f11 = utility::getfx( var_2f7ee79efdc2bbec );
    
    if ( var_62e858c45bbf3f11 )
    {
        playfx( var_62e858c45bbf3f11, origin, undefined, normal );
    }
}

// Namespace namespace_75a5bbd3a938f9df
// Params 1, eflags: 0x4
// Checksum 0x6adf7e30, Offset: 0x4f1
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace namespace_75a5bbd3a938f9df
// Params 0, eflags: 0x4
// Checksum 0x6e9f1e6d, Offset: 0x517
// Size: 0x6f
function private function_30a6d2141f3a1af1()
{
    var_e1b150b361aa0993 = self.ranged_attack_target;
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_884711fc94b10261();
        var_e1b150b361aa0993 function_a58e1bd7ca9f6222( "spit_attack" );
    }
    
    utility::waittill_any( "terminate_ranged_attack", "death" );
    
    if ( isdefined( self ) )
    {
        self.projectile_attach_tag = undefined;
    }
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_88a6736ac53d2a25();
        var_e1b150b361aa0993 function_31d0b50675d9d6e( "spit_attack" );
    }
}

// Namespace namespace_75a5bbd3a938f9df
// Params 1, eflags: 0x4
// Checksum 0xe9e31c97, Offset: 0x58e
// Size: 0x67
function private play_mouth_glow( duration )
{
    self notify( #"play_mouth_glow" );
    self endon( #"play_mouth_glow" );
    
    if ( self.b_invisible )
    {
        return;
    }
    
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit", "glow" );
    wait duration;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "spit", "idle" );
    }
}

// Namespace namespace_75a5bbd3a938f9df
// Params 0, eflags: 0x4
// Checksum 0xa15aa841, Offset: 0x5fd
// Size: 0x30
function private spit_mouth_glow()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    self waittill( #"mouth_glow" );
    thread play_mouth_glow( 1 );
}

