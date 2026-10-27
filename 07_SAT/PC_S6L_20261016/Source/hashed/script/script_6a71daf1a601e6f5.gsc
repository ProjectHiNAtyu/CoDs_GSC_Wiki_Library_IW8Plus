// script_6a71daf1a601e6f5  (hash_6a71daf1a601e6f5.gscc) (size: 2989 Bytes / 0xbad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf25b7c00 (4066081792)
// size ...... 2989 (0xbad)
// includes .. 5   (offset: 0xaf1)
// strings ... 6   (offset: 0xb19)
// dev strs .. 6   (offset: 0xb65)
// exports ... 9   (offset: 0x5a9)
// cseg ...... 0xb3 + 0x4f6 (0x5a9)
// imports ... 34  (offset: 0x711)
// animtree1 . 0   (offset: 0xbad)
// animtree2 . 0   (offset: 0xbad)
#using script_640b69521097c6a5;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\utility;

#namespace namespace_cf4ab51195a21b92;

// Namespace namespace_cf4ab51195a21b92
// Params 0
// Checksum 0xf0392b4a, Offset: 0xd1
// Size: 0x13
function function_2ebcc6123b939f5()
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    thread manage_stinger_swipe();
}

// Namespace namespace_cf4ab51195a21b92
// Params 0, eflags: 0x4
// Checksum 0x526ae26d, Offset: 0xec
// Size: 0x1cb
function private manage_stinger_swipe()
{
    self endon( #"death" );
    var_95e33d9a1bef5290 = getdvarfloat( @"hash_6315802467223f1e", 0.25 );
    var_5f93b85fbe2403a8 = 1.7;
    function_169f8fd416967e6d();
    var_7708e4b765bfaf3c = -1 * anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x5b>" );
        }
    #/
    
    asm::function_7256f5ba459c840b( "stinger_swipe" );
    target = self._blackboard.meleerequestedtarget;
    
    if ( isalive( target ) )
    {
        predicted_target_pos = target.origin + target getvelocity() * 0.5;
        orient_dir = predicted_target_pos - self.origin;
        orient_dir = vectornormalize2( orient_dir );
        orient_dot = vectordot2( var_7708e4b765bfaf3c, orient_dir );
        
        if ( orient_dot < 0.05 )
        {
            orient_side_dir = rotatepointaroundvector( ( 0, 0, 1 ), var_7708e4b765bfaf3c, 90 );
            
            if ( vectordot2( orient_side_dir, orient_dir ) < 0 )
            {
                orient_side_dir = -1 * orient_side_dir;
            }
            
            var_b322759c2f1707bf = sqrt( 1 - squared( 0.05 ) );
            orient_dir = var_7708e4b765bfaf3c * 0.05 + orient_side_dir * var_b322759c2f1707bf;
        }
        
        prior_turnrate = self.turnrate;
        self.turnrate = var_95e33d9a1bef5290;
        self orientmode( "face angle", angleclamp180( vectortoyaw( -1 * orient_dir ) ) );
        utility::waittill_notify_or_timeout( "bmeleeended", var_5f93b85fbe2403a8 );
        self.turnrate = prior_turnrate;
    }
}

// Namespace namespace_cf4ab51195a21b92
// Params 0, eflags: 0x4
// Checksum 0x24c24d4a, Offset: 0x2bf
// Size: 0x8d
function private function_169f8fd416967e6d()
{
    var_a894a125ad654ac2 = self.origin + anglestoforward( self.angles ) * -395;
    var_a894a125ad654ac2 = utility::drop_to_ground( var_a894a125ad654ac2, 400 );
    
    /#
        sphere( var_a894a125ad654ac2, 10, ( 1, 1, 1 ), 0, 1000000 );
    #/
    
    var_d15d56a6c8e454e3 = clamp( -1 * angleclamp180( vectortopitch( var_a894a125ad654ac2 - self.origin ) ), -45, 45 );
    self function_a8fe8d86843b9cee( var_d15d56a6c8e454e3 );
}

// Namespace namespace_cf4ab51195a21b92
// Params 4
// Checksum 0x4bc37355, Offset: 0x354
// Size: 0x81, Type: bool
function function_46ba7d39dcdc79e0( asmname, statename, tostatename, params )
{
    if ( zombie_stun::is_stunned() )
    {
        return false;
    }
    
    target = self._blackboard.meleerequestedtarget;
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    yaw_to_target = utility_common::absyawtoorigin( target.origin );
    
    if ( yaw_to_target < 110 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_cf4ab51195a21b92
// Params 0
// Checksum 0xeccae985, Offset: 0x3de
// Size: 0x30, Type: bool
function function_9dddd89ce61e2f9e()
{
    if ( isalive( self ) && isai( self ) && asm::asm_getcurrentstatename( self.asmname ) == "stinger_swipe" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_cf4ab51195a21b92
// Params 0
// Checksum 0xaea22e78, Offset: 0x417
// Size: 0x10b
function function_3d02256c7ca08940()
{
    self endon( #"death" );
    
    if ( !function_9dddd89ce61e2f9e() )
    {
        return;
    }
    
    asm::asm_fireevent( self.asmname, "finish" );
    waitframe();
    
    if ( !function_9dddd89ce61e2f9e() )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) && self.var_578d003dc0623cbd )
        {
            self thread [[ self.var_578d003dc0623cbd ]]( "<dev string:x69>", 0 );
        }
    #/
    
    self.var_7cbde7b93399a096 = 0;
    self.var_59a67f4a2bd3b5f7 = 0;
    self.var_5854d52bc771060 = undefined;
    self.var_149c7ca28b59287b = 0;
    self.var_9c344f8b4d3d4884 = 0;
    self.var_50781d61dc86a4bf = 1;
    self.var_134f3cd53162e193 = 0;
    self.var_4864b6d03c1561ae = 0;
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x82>", "<dev string:xc3>" );
        }
    #/
    
    asm::asm_setstate( "neutral_passthrough" );
    waitframe();
    
    if ( utility::ent_flag( "in_melee" ) )
    {
        self notify( #"bmeleeended" );
    }
}

// Namespace namespace_cf4ab51195a21b92
// Params 0, eflags: 0x4
// Checksum 0x19ddafde, Offset: 0x52a
// Size: 0x4d
function private function_4d82a76a1cde4026()
{
    self endon( #"death" );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            logstring( "<dev string:xd7>" );
        }
    #/
    
    var_c3a0396445149976 = 0.5;
    wait 1.7 + var_c3a0396445149976;
    function_3d02256c7ca08940();
}

// Namespace namespace_cf4ab51195a21b92
// Params 0
// Checksum 0xffa43440, Offset: 0x57f
// Size: 0x2a
function function_c3b15f481cd323a2()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weyward_stinger_swipe_start" );
        thread function_4d82a76a1cde4026();
    }
}

