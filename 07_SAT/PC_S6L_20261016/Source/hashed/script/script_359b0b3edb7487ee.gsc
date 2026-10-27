// script_359b0b3edb7487ee  (hash_359b0b3edb7487ee.gscc) (size: 4048 Bytes / 0xfd0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e1408fe (504629502)
// size ...... 4048 (0xfd0)
// includes .. 3   (offset: 0xf50)
// strings ... 6   (offset: 0xf68)
// dev strs .. 2   (offset: 0xfb4)
// exports ... 11  (offset: 0x974)
// cseg ...... 0xbe + 0x8b6 (0x974)
// imports ... 37  (offset: 0xb2c)
// animtree1 . 0   (offset: 0xfd0)
// animtree2 . 0   (offset: 0xfd0)
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_ranged_attack_asm;

// Namespace zombie_ranged_attack_asm
// Params 0
// Checksum 0xa9bccd08, Offset: 0xdc
// Size: 0x57
function init_ranged_attack_asm()
{
    if ( !self.var_d6894f01a36b4ff3.var_61f7cb9d1effbf0a )
    {
        return;
    }
    
    assert( isdefined( self.grenadeweapon ), "<dev string:x24>" );
    self.default_ranged_attack_dist = self._blackboard.var_d075c035f7081d2a;
    self.var_6e920da0374faba7 = 0;
}

// Namespace zombie_ranged_attack_asm
// Params 1
// Checksum 0xa3e1d482, Offset: 0x13b
// Size: 0xe1
function function_8b1372bc3a2d158e( target_ent )
{
    assert( isdefined( self.grenadeweapon ), "<dev string:x24>" );
    self.ranged_attack_target = target_ent;
    
    if ( isplayer( target_ent ) )
    {
        if ( target_ent function_ea1c30d42bd9c659() > self._blackboard.var_d751dec818290f98 )
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
    
    if ( self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a > 0 )
    {
        self.ranged_attack_cooldown = gettime() + self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a * 1000;
    }
    
    asm::function_7256f5ba459c840b( "ranged_attack_in" );
    thread function_f45ec09b7ed032dd();
}

// Namespace zombie_ranged_attack_asm
// Params 0, eflags: 0x4
// Checksum 0xe61a8dc7, Offset: 0x224
// Size: 0x23a
function private function_f45ec09b7ed032dd()
{
    self endon( #"death" );
    self notify( #"terminate_ranged_attack" );
    self endon( #"terminate_ranged_attack" );
    thread function_30a6d2141f3a1af1();
    self waittill( #"gutgrab" );
    
    if ( self._blackboard.var_99f794dc99944d15 )
    {
        self.projectile_attach_tag = self._blackboard.var_7ba1c73f07fdd7ae == 0 ? self.var_d6894f01a36b4ff3.projectileattachtagleft : self.var_d6894f01a36b4ff3.projectileattachtagright;
    }
    else
    {
        self.projectile_attach_tag = self.var_d6894f01a36b4ff3.projectileattachtag;
    }
    
    if ( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6.size > 0 )
    {
        self.var_d75eaefe66066143 = utility::array_random( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6 ).modelname;
        self attach( self.var_d75eaefe66066143, self.projectile_attach_tag );
    }
    
    self waittill( #"gutgo" );
    target = isent( self.ranged_attack_target ) ? self.ranged_attack_target : undefined;
    var_752221f0b48fc623 = self gettagorigin( self.projectile_attach_tag );
    local_throw_pos = coordtransformtranspose( var_752221f0b48fc623, self.origin, self.angles );
    
    if ( !isdefined( self.grenadeweapon ) || self.grenadeweapon == level.weaponnone )
    {
        return;
    }
    
    var_267d01d2be2d145 = self function_d5e40e88a4ac1386( self.grenadeweapon, target, 1, self._blackboard.var_7ba1c73f07fdd7ae, self.var_d6894f01a36b4ff3.var_119fef101c0ce9fd, self.var_d6894f01a36b4ff3.var_aa57d9825605b34b, self.var_d6894f01a36b4ff3.var_5e7bfcf78c63144b, local_throw_pos );
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        var_267d01d2be2d145 = self._blackboard.var_c894b0896ac6f7d;
    }
    
    function_bf22d281c4651259( var_267d01d2be2d145, var_752221f0b48fc623 );
}

// Namespace zombie_ranged_attack_asm
// Params 2, eflags: 0x4
// Checksum 0x305c3791, Offset: 0x466
// Size: 0x116
function private function_bf22d281c4651259( var_267d01d2be2d145, var_752221f0b48fc623 )
{
    var_d75eaefe66066143 = self.var_d75eaefe66066143;
    
    if ( isdefined( self.var_d75eaefe66066143 ) )
    {
        self detach( self.var_d75eaefe66066143, self.projectile_attach_tag );
        self.var_d75eaefe66066143 = undefined;
    }
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    if ( !isdefined( self.grenadeweapon ) || self.grenadeweapon == level.weaponnone )
    {
        return;
    }
    
    grenade = magicgrenademanual( self.grenadeweapon, var_752221f0b48fc623, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    grenade.angles = self gettagangles( self.projectile_attach_tag );
    grenade.owner = self;
    
    if ( isdefined( var_d75eaefe66066143 ) )
    {
        grenade setmodel( var_d75eaefe66066143 );
    }
    
    callback::callback( "on_zombie_gutthrow", { #target_pos:var_752221f0b48fc623, #projectile:grenade } );
    thread function_75fe720ef56ffd31( grenade );
}

// Namespace zombie_ranged_attack_asm
// Params 1, eflags: 0x4
// Checksum 0x4bdbcef, Offset: 0x584
// Size: 0x1df
function private function_3204dc1d4b756d6b( ai )
{
    self endon( #"projectile_impact_player" );
    ai endon( #"death" );
    ai waittill( #"projectile_impact", weapon, position );
    impact_radius = ai.var_d6894f01a36b4ff3.var_2e336f378c709a8c;
    var_114709d5b68798 = ai.var_d6894f01a36b4ff3.var_597b49917a1fdb2b;
    nearby_players = getplayersinradius( position, impact_radius, impact_radius, 1 );
    
    foreach ( player in nearby_players )
    {
        if ( isalive( player ) && player.team != ai.team && !player.var_b6f2224be9ed1a1b )
        {
            player dodamage( var_114709d5b68798, position, ai, self, "MOD_IMPACT", weapon );
            
            /#
                if ( debug_ranged_attack() )
                {
                    sphere( self.origin, impact_radius, ( 1, 0, 0 ), 0, 100 );
                    print3d( self.origin, "<dev string:x4d>" + distance( player.origin, self.origin ), ( 1, 0, 0 ), 1, 1, 100 );
                    line( self.origin, player.origin, ( 1, 0, 0 ), 1, 0, 100 );
                }
            #/
        }
    }
}

// Namespace zombie_ranged_attack_asm
// Params 1, eflags: 0x4
// Checksum 0x8583c79d, Offset: 0x76b
// Size: 0xca
function private function_75fe720ef56ffd31( grenade )
{
    self endon( #"death" );
    
    if ( self.var_d6894f01a36b4ff3.var_18fc8730079bfe71 )
    {
        grenade thread function_3204dc1d4b756d6b( self );
    }
    
    grenade thread function_5919705635a6b51( self );
    grenade waittill( #"delay_death" );
    self.var_6e920da0374faba7++;
    
    if ( self.var_6e920da0374faba7 > self.var_d6894f01a36b4ff3.var_cb36afac3d355fed )
    {
        self.var_6e920da0374faba7 = 0;
        self._blackboard.var_d075c035f7081d2a = 0;
        wait self.var_d6894f01a36b4ff3.var_dcc0228b6f066100;
        self._blackboard.var_d075c035f7081d2a = self.default_ranged_attack_dist;
    }
}

// Namespace zombie_ranged_attack_asm
// Params 1, eflags: 0x4
// Checksum 0xb3bd54d0, Offset: 0x83d
// Size: 0x4c
function private function_5919705635a6b51( ai )
{
    self endon( #"delay_death" );
    ai endon( #"death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_player" );
    ai.var_6e920da0374faba7 = -1;
}

// Namespace zombie_ranged_attack_asm
// Params 1, eflags: 0x4
// Checksum 0x98276558, Offset: 0x891
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace zombie_ranged_attack_asm
// Params 0, eflags: 0x4
// Checksum 0x829d501f, Offset: 0x8b7
// Size: 0x98
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
        if ( isdefined( self.var_d75eaefe66066143 ) )
        {
            self detach( self.var_d75eaefe66066143, self.projectile_attach_tag );
        }
        else if ( !isalive( self ) )
        {
            self detachall();
        }
        
        self.var_d75eaefe66066143 = undefined;
        self.projectile_attach_tag = undefined;
    }
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_88a6736ac53d2a25();
    }
}

/#

    // Namespace zombie_ranged_attack_asm
    // Params 0, eflags: 0x4
    // Checksum 0x4e094210, Offset: 0x957
    // Size: 0x1d, Type: dev
    function private debug_ranged_attack()
    {
        if ( getdvarint( @"debug_zombie_ranged_attack", 0 ) > 0 )
        {
            return 1;
        }
        
        return 0;
    }

#/
