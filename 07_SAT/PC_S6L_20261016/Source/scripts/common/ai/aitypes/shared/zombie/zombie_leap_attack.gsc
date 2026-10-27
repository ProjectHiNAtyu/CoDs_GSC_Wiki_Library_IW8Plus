// scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack.gsc  (hash_3063a3a5a2e024a0.gscc) (size: 7322 Bytes / 0x1c9a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb728003d (3072852029)
// size ...... 7322 (0x1c9a)
// includes .. 5   (offset: 0x1b22)
// strings ... 7   (offset: 0x1b4a)
// dev strs .. 14  (offset: 0x1ba2)
// exports ... 32  (offset: 0xf12)
// cseg ...... 0xc3 + 0xe4f (0xf12)
// imports ... 61  (offset: 0x1412)
// animtree1 . 0   (offset: 0x1c9a)
// animtree2 . 0   (offset: 0x1c9a)
#using script_5fbb037f63a7a8a1;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_leap_attack;

// Namespace zombie_leap_attack
// Params 0
// Checksum 0xec04cd63, Offset: 0xe1
// Size: 0x2c
function init_zombie_leap_attack_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &on_zombie_killed );
    
    /#
        setup_leap_attack_devgui();
    #/
}

// Namespace zombie_leap_attack
// Params 2
// Checksum 0x8ae892ef, Offset: 0x115
// Size: 0x81
function init_zombie_leap_attack( var_efcd7b34b543c7e7, var_18be6ba5f7e8ffb6 )
{
    if ( var_efcd7b34b543c7e7 )
    {
        disable_leap_attack();
    }
    else
    {
        enable_leap_attack( var_18be6ba5f7e8ffb6 );
    }
    
    thread function_864c4059e1084127();
    
    if ( self.var_247a4fb59046e586 > 0 || self._blackboard.leapattackdamage > 0 )
    {
        if ( self.var_3dbe6d460bc26c63 > 0 )
        {
            thread leap_landed_listener();
        }
        else
        {
            thread function_d6d0333332d95337();
        }
    }
    
    thread function_81d908e1f14112a5();
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x2dab29bf, Offset: 0x19e
// Size: 0x76
function enable_leap_attack( var_18be6ba5f7e8ffb6 )
{
    self._blackboard.var_6716e5e0ff1e7a3d = 1;
    
    if ( !var_18be6ba5f7e8ffb6 )
    {
        self._blackboard.var_576df40752e47aac = gettime() + randomfloat( self._blackboard.var_61e56d196f8dacad );
        return;
    }
    
    self._blackboard.var_576df40752e47aac = gettime() + 1;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0x461d4487, Offset: 0x21c
// Size: 0x17
function disable_leap_attack()
{
    self._blackboard.var_6716e5e0ff1e7a3d = 0;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0xa6179b85, Offset: 0x23b
// Size: 0x16, Type: bool
function is_leap_attack_enabled()
{
    return istrue( self._blackboard.var_6716e5e0ff1e7a3d );
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0xa6960412, Offset: 0x25a
// Size: 0x16, Type: bool
function is_in_leap_attack()
{
    return istrue( self._blackboard.var_3a44698105717632 );
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0xbdbf5285, Offset: 0x279
// Size: 0x33
function set_leap_attack_cooldown( time )
{
    assert( time >= 0, "<dev string:x24>" );
    self._blackboard.var_61e56d196f8dacad = time;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0x21e636ea, Offset: 0x2b4
// Size: 0x46
function get_leap_attack_min_distance()
{
    assert( isdefined( self._blackboard.var_7a0ed1d8a025653 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    return self._blackboard.var_7a0ed1d8a025653;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x7f41742a, Offset: 0x303
// Size: 0x76
function set_leap_attack_min_distance( var_7734780573e19e93 )
{
    assert( isdefined( self._blackboard.var_7a0ed1d8a025653 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    assert( var_7734780573e19e93 <= self._blackboard.var_6dc50e9edbfedf79, "<dev string:xad>" );
    self._blackboard.var_7a0ed1d8a025653 = var_7734780573e19e93;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0xb1952600, Offset: 0x381
// Size: 0x46
function get_leap_attack_max_distance()
{
    assert( isdefined( self._blackboard.var_6dc50e9edbfedf79 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    return self._blackboard.var_6dc50e9edbfedf79;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x233f1fc9, Offset: 0x3d0
// Size: 0x76
function set_leap_attack_max_distance( var_7734780573e19e93 )
{
    assert( isdefined( self._blackboard.var_6dc50e9edbfedf79 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    assert( var_7734780573e19e93 >= self._blackboard.var_7a0ed1d8a025653, "<dev string:x108>" );
    self._blackboard.var_6dc50e9edbfedf79 = var_7734780573e19e93;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0xe662cc95, Offset: 0x44e
// Size: 0x46
function get_leap_attack_max_height()
{
    assert( isdefined( self._blackboard.var_da4bba45ef78c861 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    return self._blackboard.var_da4bba45ef78c861;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x66a40126, Offset: 0x49d
// Size: 0x53
function set_leap_attack_max_height( maxheight )
{
    assert( isdefined( self._blackboard.var_da4bba45ef78c861 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    self._blackboard.var_da4bba45ef78c861 = maxheight;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0xb5c49435, Offset: 0x4f8
// Size: 0x53
function set_leap_attack_min_speed( leapspeed )
{
    assert( isdefined( self._blackboard.var_ed8e43492e9992f3 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    self._blackboard.var_ed8e43492e9992f3 = leapspeed;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x622f2674, Offset: 0x553
// Size: 0x53
function set_leap_attack_max_speed( leapspeed )
{
    assert( isdefined( self._blackboard.var_93c0b68a5d2543c5 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    self._blackboard.var_93c0b68a5d2543c5 = leapspeed;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x28cc792a, Offset: 0x5ae
// Size: 0xa8
function function_7f43d0ce9021739c( scalefactor )
{
    assert( isdefined( self._blackboard.var_ed8e43492e9992f3 ) && isdefined( self._blackboard.var_93c0b68a5d2543c5 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    self._blackboard.var_ed8e43492e9992f3 *= scalefactor;
    self._blackboard.var_93c0b68a5d2543c5 *= scalefactor;
}

// Namespace zombie_leap_attack
// Params 0
// Checksum 0x7eae355c, Offset: 0x65e
// Size: 0x46
function function_5ac41a292cbb4e8a()
{
    assert( isdefined( self._blackboard.var_f1f95501251c9a40 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    return self._blackboard.var_f1f95501251c9a40;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x32ecaaa0, Offset: 0x6ad
// Size: 0x70
function function_13586f09be6e9c76( var_fa7a00aff527b762 )
{
    assert( isdefined( self._blackboard.var_f1f95501251c9a40 ), "<dev string:x65>" + self.subclass + "<dev string:xab>" );
    assert( var_fa7a00aff527b762 > 0 && var_fa7a00aff527b762 <= 1, "<dev string:x161>" );
    self._blackboard.var_f1f95501251c9a40 = var_fa7a00aff527b762;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0x899c301f, Offset: 0x725
// Size: 0x28
function set_leap_attack_knockback_strength( var_e5070b52534334ac )
{
    assert( var_e5070b52534334ac >= 0, "<dev string:x1b5>" );
    self.var_247a4fb59046e586 = var_e5070b52534334ac;
}

// Namespace zombie_leap_attack
// Params 1
// Checksum 0xb1a93ea3, Offset: 0x755
// Size: 0x35
function set_leap_attack_end_pos_offset( offset )
{
    assert( isvector( offset ), "<dev string:x1f6>" );
    self._blackboard.var_ccde537d03078e02 = offset;
}

// Namespace zombie_leap_attack
// Params 0, eflags: 0x4
// Checksum 0xe28bbb4d, Offset: 0x792
// Size: 0x9
function private request_leap_attack()
{
    zombie_leap_attack_asm::function_cc6b10a6c37c57e5();
}

// Namespace zombie_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x578de992, Offset: 0x7a3
// Size: 0x2a
function private function_864c4059e1084127()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_start" );
        request_leap_attack();
    }
}

// Namespace zombie_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x13bbdc33, Offset: 0x7d5
// Size: 0x93
function private function_d6d0333332d95337()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hit_leap", var_334102027623dfa0 );
        
        if ( !isent( var_334102027623dfa0 ) && isint( var_334102027623dfa0 ) )
        {
            hitent = getentbynum( var_334102027623dfa0 );
        }
        else
        {
            hitent = var_334102027623dfa0;
        }
        
        if ( isdefined( hitent ) )
        {
            function_1a633c01d0e06025( hitent );
            params = spawnstruct();
            params.var_c146e72268eb8492 = hitent;
            callback::callback( "on_zombie_leap_hit", params );
        }
    }
}

// Namespace zombie_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x80e77ccb, Offset: 0x870
// Size: 0xb5
function private leap_landed_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_landed" );
        hit_entities = getplayersandaiarrayinradius( self.origin, self.var_3dbe6d460bc26c63 );
        
        foreach ( var_90ec0886f9ccf215 in hit_entities )
        {
            function_1a633c01d0e06025( var_90ec0886f9ccf215 );
        }
    }
}

// Namespace zombie_leap_attack
// Params 1, eflags: 0x4
// Checksum 0xb15bcf2d, Offset: 0x92d
// Size: 0x2b7
function private function_1a633c01d0e06025( hitent )
{
    if ( hitent != self && isalive( hitent ) )
    {
        if ( self.var_247a4fb59046e586 > 0 )
        {
            var_efa6dfbf34dd731c = squared( self.var_1920d78ea78d0db2 );
            
            if ( isplayer( hitent ) && distancesquared( hitent.origin, self._blackboard.var_497e751941b50bed ) > var_efa6dfbf34dd731c )
            {
                hitent knockback_player( self.origin, self.var_247a4fb59046e586 );
            }
            else if ( !isplayer( hitent ) && ( !isdefined( hitent.aicategory ) || hitent.aicategory == "normal" ) && !hitent zombie_knockdown::function_6fc167d4a3590991( self.origin, self.var_247a4fb59046e586 ) )
            {
                var_42151c09e4f16eaa = self getboundshalfsize();
                var_2f19b3a62062955e = var_42151c09e4f16eaa[ 0 ] * 2;
                var_8535ca435320a891 = anglestoright( self.angles );
                var_b728533d53ff6b4e = vectornormalize( hitent.origin - self.origin );
                
                if ( vectordot( var_8535ca435320a891, var_b728533d53ff6b4e ) > 0 )
                {
                    displacementvec = var_2f19b3a62062955e * var_8535ca435320a891;
                }
                else
                {
                    displacementvec = var_2f19b3a62062955e * anglestoleft( self.angles );
                }
                
                var_812a67b1f920cec7 = getclosestpointonnavmesh( hitent.origin + displacementvec, self );
                
                if ( isdefined( var_812a67b1f920cec7 ) && ( isai( hitent ) || isbot( hitent ) ) )
                {
                    hitent thread function_98658978275ee5c0( var_812a67b1f920cec7 );
                }
                else
                {
                    hitent kill();
                }
            }
        }
        
        if ( self._blackboard.leapattackdamage > 0 )
        {
            hitent dodamage( self._blackboard.leapattackdamage, self.origin, self, self, "MOD_MELEE", undefined, "torso_upper" );
        }
        
        if ( self.var_7e762b2e75eb4a4c > 0 && isplayer( hitent ) )
        {
            hitent playrumbleonentity( self.var_7e762b2e75eb4a4c >= 0.5 ? "heavy_1s" : "light_1s" );
            
            if ( self.var_3dbe6d460bc26c63 > 0 )
            {
                hitent earthquakeforplayer( self.var_7e762b2e75eb4a4c, min( self.var_7e762b2e75eb4a4c * 2, 1 ), self.origin, self.var_3dbe6d460bc26c63 );
                return;
            }
            
            hitent earthquakeforplayer( self.var_7e762b2e75eb4a4c, min( self.var_7e762b2e75eb4a4c * 2, 1 ), hitent.origin, 100 );
        }
    }
}

// Namespace zombie_leap_attack
// Params 2, eflags: 0x4
// Checksum 0xee374a23, Offset: 0xbec
// Size: 0xac
function private knockback_player( var_43068cedef588bd3, var_e5070b52534334ac )
{
    var_2d838cc7415cda8a = vectornormalize2( self.origin - var_43068cedef588bd3 );
    var_263bcffe260f91d1 = vectorcross( var_2d838cc7415cda8a, ( 0, 0, 1 ) );
    var_8d61ce41875913ea = 50;
    var_d0d8606540539517 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_8d61ce41875913ea );
    var_4b13a178eaef6ee7 = getdvarfloat( @"hash_63a5c8451997935d", var_e5070b52534334ac );
    var_a42fc8397e352638 = rotatepointaroundvector( var_263bcffe260f91d1, var_2d838cc7415cda8a, var_d0d8606540539517 );
    self knockback( var_a42fc8397e352638, var_4b13a178eaef6ee7, 1 );
}

// Namespace zombie_leap_attack
// Params 1, eflags: 0x4
// Checksum 0xca3691e4, Offset: 0xca0
// Size: 0x77
function private function_98658978275ee5c0( finalpoint )
{
    self endon( #"death" );
    startingpoint = self.origin;
    lerpfrac = 0;
    
    while ( lerpfrac <= 1 )
    {
        var_8ab9bf8b9d5d968a = vectorlerp( startingpoint, finalpoint, lerpfrac );
        self forceteleport( var_8ab9bf8b9d5d968a, self.angles );
        lerpfrac += 0.05;
    }
}

// Namespace zombie_leap_attack
// Params 0, eflags: 0x4
// Checksum 0x6d09ce0f, Offset: 0xd1f
// Size: 0xa0
function private function_81d908e1f14112a5()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_failsafe" );
        assert( "<dev string:x223>" );
        
        if ( isdefined( self._blackboard.var_ec5d8f5eef26aba4 ) )
        {
            var_83e027be2fd8016d = getclosestpointonnavmesh( self._blackboard.var_497e751941b50bed, self );
        }
        else
        {
            var_83e027be2fd8016d = getclosestpointonnavmesh( self._blackboard.var_87e845ae407b82c2, self );
        }
        
        self forceteleport( var_83e027be2fd8016d, self.angles, 10, 1 );
    }
}

// Namespace zombie_leap_attack
// Params 1, eflags: 0x4
// Checksum 0xbc5b9305, Offset: 0xdc7
// Size: 0x55
function private on_zombie_killed( params )
{
    if ( is_in_leap_attack() )
    {
        if ( self.noragdoll || self.script_noragdoll )
        {
            self.forceannihilate = 1;
            return;
        }
        
        self.forceragdollimmediate = 1;
        self.ragdoll_damagelocation_none = "torso_upper";
    }
}

/#

    // Namespace zombie_leap_attack
    // Params 0
    // Checksum 0x12356eec, Offset: 0xe24
    // Size: 0x30, Type: dev
    function setup_leap_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x284>" );
        devgui::add_devgui_func( "<dev string:x2a1>", "<dev string:x2cc>", &toggle_leap_attack, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_leap_attack
    // Params 0, eflags: 0x4
    // Checksum 0x415c41e3, Offset: 0xe5c
    // Size: 0xb6, Type: dev
    function private toggle_leap_attack()
    {
        zombies = getaispeciesarray( "<dev string:x2df>", "<dev string:x2e3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        while ( true )
        {
            if ( !isalive( var_88f817d755d2b49c ) )
            {
                return;
            }
            
            target = var_88f817d755d2b49c.enemy;
            
            if ( isdefined( target._blackboard.var_6716e5e0ff1e7a3d ) )
            {
                target._blackboard.var_6716e5e0ff1e7a3d = !target._blackboard.var_6716e5e0ff1e7a3d;
            }
            
            waitframe();
        }
    }

#/
