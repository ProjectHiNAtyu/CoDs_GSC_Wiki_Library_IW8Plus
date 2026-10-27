// script_290c63919fb4afde  (hash_290c63919fb4afde.gscc) (size: 974 Bytes / 0x3ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x91aff055 (2444226645)
// size ...... 974 (0x3ce)
// includes .. 2   (offset: 0x3ae)
// strings ... 1   (offset: 0x3be)
// dev strs .. 0   (offset: 0x3ce)
// exports ... 6   (offset: 0x1de)
// cseg ...... 0x65 + 0x179 (0x1de)
// imports ... 8   (offset: 0x2ce)
// animtree1 . 0   (offset: 0x3ce)
// animtree2 . 0   (offset: 0x3ce)
#using scripts\anim\utility_common;
#using scripts\asm\asm;

#namespace namespace_2823e49aa0908abb;

// Namespace namespace_2823e49aa0908abb
// Params 2
// Checksum 0xe918627e, Offset: 0x83
// Size: 0x2f
function function_9f1707d1a108b8e4( point, radius )
{
    self.var_c0c42bbd970e30ee = point;
    self.var_a6a2972d94e39973 = squared( radius );
}

// Namespace namespace_2823e49aa0908abb
// Params 0
// Checksum 0x1a213628, Offset: 0xba
// Size: 0x9
function function_e5b80d1457b1280()
{
    thread manage_tail_slam();
}

// Namespace namespace_2823e49aa0908abb
// Params 0, eflags: 0x4
// Checksum 0x2fcadd6d, Offset: 0xcb
// Size: 0x1a
function private manage_tail_slam()
{
    self endon( #"death" );
    asm::function_7256f5ba459c840b( "tail_slam" );
}

// Namespace namespace_2823e49aa0908abb
// Params 4
// Checksum 0x5d250742, Offset: 0xed
// Size: 0xb7, Type: bool
function function_8ac6c1c5cc0e456b( asmname, statename, tostatename, params )
{
    target = self._blackboard.meleerequestedtarget;
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( self.var_c0c42bbd970e30ee && self.var_a6a2972d94e39973 && distance2dsquared( target.origin, self.var_c0c42bbd970e30ee ) <= self.var_a6a2972d94e39973 )
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

// Namespace namespace_2823e49aa0908abb
// Params 0
// Checksum 0x6d9b23f9, Offset: 0x1ad
// Size: 0x30, Type: bool
function function_e0f08ce5957fca9f()
{
    if ( isalive( self ) && isai( self ) && asm::asm_getcurrentstatename( self.asmname ) == "tail_slam" )
    {
        return true;
    }
    
    return false;
}

