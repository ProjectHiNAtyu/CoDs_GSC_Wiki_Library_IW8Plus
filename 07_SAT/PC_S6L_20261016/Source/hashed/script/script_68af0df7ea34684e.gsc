// script_68af0df7ea34684e  (hash_68af0df7ea34684e.gscc) (size: 1759 Bytes / 0x6df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ccae9f (147631775)
// size ...... 1759 (0x6df)
// includes .. 1   (offset: 0x693)
// strings ... 4   (offset: 0x69b)
// dev strs .. 1   (offset: 0x6d3)
// exports ... 8   (offset: 0x343)
// cseg ...... 0xa3 + 0x2a0 (0x343)
// imports ... 18  (offset: 0x483)
// animtree1 . 0   (offset: 0x6df)
// animtree2 . 0   (offset: 0x6df)
#using scripts\common\callbacks;

#namespace namespace_45591fb25244d549;

// Namespace namespace_45591fb25244d549
// Params 0
// Checksum 0xb69b74e6, Offset: 0xc1
// Size: 0x43
function function_a38858e4f5328064()
{
    template = callback::get_template( self.animsetname );
    template callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    template callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
}

// Namespace namespace_45591fb25244d549
// Params 0
// Checksum 0xd7afbec8, Offset: 0x10c
// Size: 0x9
function function_a887d53ac5484b73()
{
    function_1a57e936d77691d2();
}

// Namespace namespace_45591fb25244d549
// Params 1, eflags: 0x4
// Checksum 0xe8c719d, Offset: 0x11d
// Size: 0x13
function private melee_on_move_speed_changed( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_45591fb25244d549
// Params 1, eflags: 0x4
// Checksum 0x55bba676, Offset: 0x138
// Size: 0x13
function private function_e0d499c13803af86( params )
{
    function_1a57e936d77691d2();
}

// Namespace namespace_45591fb25244d549
// Params 0, eflags: 0x4
// Checksum 0x115d0191, Offset: 0x153
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

// Namespace namespace_45591fb25244d549
// Params 1
// Checksum 0xa77fd86e, Offset: 0x20e
// Size: 0x5c
function function_cede8b4d4a5ae444( target_ent )
{
    is_moving_melee = calculate_is_moving_melee( target_ent );
    self._blackboard.var_c79e4fdbafb5ec9a = is_moving_melee;
    
    if ( self.is_moving_melee != is_moving_melee )
    {
        self.is_moving_melee = is_moving_melee;
        callback::callback( "on_is_moving_melee_changed" );
    }
}

// Namespace namespace_45591fb25244d549
// Params 1
// Checksum 0x5543b585, Offset: 0x272
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
        
        if ( var_ac663d277d426e46 < squared( self.var_abf0b408c96a796 ) )
        {
            var_f69827bbfb33eb2b = target_ent getentityvelocity();
            is_moving_melee = vectordot2( var_f69827bbfb33eb2b, var_ee6433c31961982d ) > 0 && length2dsquared( var_f69827bbfb33eb2b ) > squared( 30 );
        }
    }
    
    return is_moving_melee;
}

