// script_22800c62e91a8956  (hash_22800c62e91a8956.gscc) (size: 1646 Bytes / 0x66e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f80cf7a (1870712698)
// size ...... 1646 (0x66e)
// includes .. 2   (offset: 0x626)
// strings ... 3   (offset: 0x636)
// dev strs .. 1   (offset: 0x662)
// exports ... 7   (offset: 0x306)
// cseg ...... 0x8a + 0x27c (0x306)
// imports ... 18  (offset: 0x41e)
// animtree1 . 0   (offset: 0x66e)
// animtree2 . 0   (offset: 0x66e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;

#namespace namespace_b76e7e4c1d057ec1;

// Namespace namespace_b76e7e4c1d057ec1
// Params 0
// Checksum 0x49d28791, Offset: 0xa8
// Size: 0x30
function function_c0467b6eefab8cac()
{
    template = callback::get_template( self.animsetname );
    template callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
}

// Namespace namespace_b76e7e4c1d057ec1
// Params 0
// Checksum 0x583889a5, Offset: 0xe0
// Size: 0x9
function function_a887d53ac5484b73()
{
    function_1a57e936d77691d2();
}

// Namespace namespace_b76e7e4c1d057ec1
// Params 1, eflags: 0x4
// Checksum 0xda2c911b, Offset: 0xf1
// Size: 0x13
function private function_e0d499c13803af86( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_b76e7e4c1d057ec1
// Params 0, eflags: 0x4
// Checksum 0x5e1caa19, Offset: 0x10c
// Size: 0xb2
function private function_1a57e936d77691d2()
{
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    alias = self function_805ca5e408d630c0( animset, "melee", featurearray, 0 );
    assert( isdefined( alias ), "<dev string:x24>" + self._blackboard.movetype );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "melee", alias );
    }
    
    return alias;
}

// Namespace namespace_b76e7e4c1d057ec1
// Params 1
// Checksum 0x523ce41e, Offset: 0x1c7
// Size: 0x66
function function_cede8b4d4a5ae444( target_ent )
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    is_moving_melee = calculate_is_moving_melee( target_ent );
    self._blackboard.var_c79e4fdbafb5ec9a = is_moving_melee;
    
    if ( self.is_moving_melee != is_moving_melee )
    {
        self.is_moving_melee = is_moving_melee;
        callback::callback( "on_is_moving_melee_changed" );
    }
}

// Namespace namespace_b76e7e4c1d057ec1
// Params 1
// Checksum 0x87866476, Offset: 0x235
// Size: 0xd0
function calculate_is_moving_melee( target_ent )
{
    moving_melee_threshold = getdvarint( @"hash_b17a9432a377356d", 32 );
    is_moving_melee = lengthsquared( self.velocity ) > squared( moving_melee_threshold );
    
    if ( is_moving_melee && isalive( target_ent ) )
    {
        target_pos = target_ent.origin;
        var_ee6433c31961982d = target_pos - self.origin;
        var_ac663d277d426e46 = lengthsquared( var_ee6433c31961982d );
        
        if ( var_ac663d277d426e46 < squared( self.melee_trigger_dist ) )
        {
            var_f69827bbfb33eb2b = target_ent getentityvelocity();
            is_moving_melee = vectordot2( var_f69827bbfb33eb2b, var_ee6433c31961982d ) > 0 && length2dsquared( var_f69827bbfb33eb2b ) > squared( 30 );
        }
    }
    
    return is_moving_melee;
}

