// scripts\asm\gesture\script_funcs.gsc  (hash_55be6492b84e43c1.gscc) (size: 905 Bytes / 0x389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2daf1a2b (766450219)
// size ...... 905 (0x389)
// includes .. 0   (offset: 0x389)
// strings ... 0   (offset: 0x389)
// dev strs .. 0   (offset: 0x389)
// exports ... 9   (offset: 0x205)
// cseg ...... 0x58 + 0x1ad (0x205)
// imports ... 1   (offset: 0x36d)
// animtree1 . 0   (offset: 0x389)
// animtree2 . 0   (offset: 0x389)
#namespace script_funcs;

// Namespace script_funcs
// Params 4
// Checksum 0xa28287c3, Offset: 0x76
// Size: 0x3b, Type: bool
function ai_gesture_requested( asmname, statename, tostatename, params )
{
    return istrue( self._blackboard.gesture_active );
}

// Namespace script_funcs
// Params 4
// Checksum 0x4bff4eaf, Offset: 0xba
// Size: 0x3b, Type: bool
function ai_point_gesture_requested( asmname, statename, tostatename, params )
{
    return istrue( self._blackboard.point_gesture_active );
}

// Namespace script_funcs
// Params 0
// Checksum 0x3fd9952, Offset: 0xfe
// Size: 0xd
function ai_lookat_hold()
{
    self.hold_lookat = 1;
}

// Namespace script_funcs
// Params 0
// Checksum 0xf0834ad4, Offset: 0x113
// Size: 0xc
function ai_lookat_release()
{
    self.hold_lookat = undefined;
}

// Namespace script_funcs
// Params 0
// Checksum 0xc25e88d6, Offset: 0x127
// Size: 0x17
function ai_can_lookat()
{
    if ( isdefined( self.hold_lookat ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace script_funcs
// Params 5
// Checksum 0xa38750da, Offset: 0x146
// Size: 0x41
function float_remap( value, from1, to1, from2, to2 )
{
    return ( value - from1 ) / ( to1 - from1 ) * ( to2 - from2 ) + from2;
}

// Namespace script_funcs
// Params 3
// Checksum 0xcc2cd31b, Offset: 0x190
// Size: 0x27
function lerp_float( from, to, delta )
{
    return from + delta * ( to - from );
}

// Namespace script_funcs
// Params 3
// Checksum 0xe2285549, Offset: 0x1c0
// Size: 0x44
function smoothstep( start, end, delta )
{
    delta = clamp( ( delta - start ) / ( end - start ), 0, 1 );
    return delta * delta * ( 3 - 2 * delta );
}

