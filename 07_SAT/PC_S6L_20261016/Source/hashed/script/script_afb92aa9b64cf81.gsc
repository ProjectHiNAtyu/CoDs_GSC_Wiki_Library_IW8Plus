// script_afb92aa9b64cf81  (hash_0afb92aa9b64cf81.gscc) (size: 2884 Bytes / 0xb44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a6f75d1 (2590995921)
// size ...... 2884 (0xb44)
// includes .. 6   (offset: 0xa5c)
// strings ... 11  (offset: 0xa8c)
// dev strs .. 2   (offset: 0xb28)
// exports ... 10  (offset: 0x668)
// cseg ...... 0x150 + 0x518 (0x668)
// imports ... 20  (offset: 0x7f8)
// animtree1 . 0   (offset: 0xb44)
// animtree2 . 0   (offset: 0xb44)
#using script_16ea1b94f0f381b3;
#using script_32fa79d079aea5f0;
#using script_670486d63d6d8151;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\utility;

#namespace zombie_triton_foot_stomp;

// Namespace zombie_triton_foot_stomp
// Params 1
// Checksum 0xd73e79ba, Offset: 0x16e
// Size: 0x29
function function_b003b34aadc2c3a0( var_4b4d72d84afd1ebd )
{
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "triton_foot_stomp_ground_impact_fx", var_4b4d72d84afd1ebd.var_154e12b7cee56903 );
    }
}

/#

    // Namespace zombie_triton_foot_stomp
    // Params 0
    // Checksum 0x37c2719, Offset: 0x19f
    // Size: 0x1a, Type: dev
    function function_199685f339d4c809()
    {
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f3008418bc1b8cfa", &function_61fc54607bf7aee0 );
    }

#/

// Namespace zombie_triton_foot_stomp
// Params 0
// Checksum 0x94558a, Offset: 0x1c1
// Size: 0x10f
function init_triton_foot_stomp()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    self._blackboard.var_5692974bb0dd3579 = int( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.footStompAttackRange );
    self._blackboard.var_f98a47aa5cd0dadf = 40;
    self.var_43bac716d39a83e0 = getdvarfloat( @"hash_be9c1052981eee22", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_43bac716d39a83e0 );
    self.var_77998900691948fb = getdvarfloat( @"hash_87cee7a55e670d95", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_77998900691948fb );
    self function_786bb6aa1b76c7ee( "footStompAttackRange", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.footStompAttackRange );
    utility::ent_flag_set( "foot_stomp_range_defined" );
    thread function_69c8d4151564e74d();
}

// Namespace zombie_triton_foot_stomp
// Params 2
// Checksum 0x53dc1a7a, Offset: 0x2d8
// Size: 0x37
function set_foot_stomp_damage_range( minrange, maxrange )
{
    if ( isdefined( minrange ) )
    {
        self.var_77998900691948fb = minrange;
    }
    
    if ( isdefined( maxrange ) )
    {
        self.var_43bac716d39a83e0 = maxrange;
    }
}

// Namespace zombie_triton_foot_stomp
// Params 1
// Checksum 0xae2529b4, Offset: 0x317
// Size: 0x37
function set_foot_stomp_range( footstomprange )
{
    self._blackboard.var_5692974bb0dd3579 = int( footstomprange );
    self function_786bb6aa1b76c7ee( "footStompAttackRange", int( footstomprange ) );
}

// Namespace zombie_triton_foot_stomp
// Params 0, eflags: 0x4
// Checksum 0x36660712, Offset: 0x356
// Size: 0x75
function private function_69c8d4151564e74d()
{
    self endon( #"death" );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    
    while ( true )
    {
        while ( self getaiblackboarddynamic( "in_foot_stomp" ) )
        {
            waitframe();
        }
        
        if ( self getaiblackboarddynamic( "foot_stomp_nearby_enemy" ) )
        {
            self function_786bb6aa1b76c7ee( "foot_stomp_nearby_enemy", 0 );
        }
        
        self waittill( #"triton_foot_stomp_start" );
        thread function_e16531dbb2fb2d4f();
    }
}

// Namespace zombie_triton_foot_stomp
// Params 0, eflags: 0xc
// Checksum 0x98de3101, Offset: 0x3d3
// Size: 0x1da
function private function_e16531dbb2fb2d4f()
{
    self notify( #"hash_26df1873d051bed4" );
    self endon( #"hash_26df1873d051bed4" );
    var_cf13477fe2b9fc7d = getdvarfloat( @"hash_81d94142c7210fe", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_21ac69116d8ff100 );
    var_3f9fe6c6d730bba8 = getdvarfloat( @"hash_a218d792b2acbbd9", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a59dfc417f52950d );
    var_97b2e397e7f1348b = 140;
    
    if ( isdefined( self.var_d5406f9626075326 ) )
    {
        self orientmode( "face angle", vectortoyaw( self.var_d5406f9626075326.origin - self.origin ) );
    }
    else if ( isdefined( self.enemy ) )
    {
        self orientmode( "face angle", vectortoyaw( self.enemy.origin - self.origin ) );
    }
    
    thread namespace_50b495c8d5e1c636::function_23b19f0f52f2a61e();
    asm::function_7256f5ba459c840b( "foot_stomp_in" );
    self waittill( #"foot_stomp_impact" );
    
    if ( isdefined( self.var_d5406f9626075326 ) )
    {
        self.var_d5406f9626075326 = undefined;
    }
    
    self orientmode( "face current" );
    zombie_triton_impact::radius_ground_impact( undefined, var_cf13477fe2b9fc7d * 0.6, 0, "MOD_MELEE", self.var_77998900691948fb * 0.6, self.var_43bac716d39a83e0 * 0.6, undefined, undefined, undefined, undefined, var_97b2e397e7f1348b, undefined, 1, 0 );
    zombie_triton_impact::cone_ground_impact( "j_ball_ri", var_97b2e397e7f1348b, var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, "MOD_MELEE", self.var_77998900691948fb, self.var_43bac716d39a83e0, "triton_foot_stomp_ground_impact_fx", undefined, "triton_slam_impact_concussive_wave_fx", 1, 1 );
    self waittill( #"foot_stomp_end" );
    self function_a8fe8d86843b9cee( 0 );
}

// Namespace zombie_triton_foot_stomp
// Params 0, eflags: 0x4
// Checksum 0x48354fbc, Offset: 0x5b5
// Size: 0x5c
function private function_54558932ec78348f()
{
    self endon( #"death" );
    self endon( #"foot_stomp_impact" );
    
    while ( true )
    {
        if ( isdefined( self.var_d5406f9626075326 ) )
        {
            self orientmode( "face angle", vectortoyaw( self.var_d5406f9626075326.origin - self.origin ) );
        }
        
        waitframe();
    }
}

/#

    // Namespace zombie_triton_foot_stomp
    // Params 1
    // Checksum 0x545b53fe, Offset: 0x619
    // Size: 0x4f, Type: dev
    function function_61fc54607bf7aee0( params )
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x98>" );
        
        if ( isdefined( triton ) )
        {
            triton notify( #"triton_foot_stomp_start" );
        }
    }

#/
