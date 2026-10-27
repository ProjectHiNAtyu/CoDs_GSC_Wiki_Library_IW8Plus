// scripts\mp\ftue\utility\ftue_camera.gsc  (hash_54e6d1e4fb728cb8.gscc) (size: 770 Bytes / 0x302 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x299096f4 (697341684)
// size ...... 770 (0x302)
// includes .. 1   (offset: 0x2fa)
// strings ... 0   (offset: 0x302)
// dev strs .. 0   (offset: 0x302)
// exports ... 4   (offset: 0x17a)
// cseg ...... 0x58 + 0x122 (0x17a)
// imports ... 8   (offset: 0x21a)
// animtree1 . 0   (offset: 0x302)
// animtree2 . 0   (offset: 0x302)
#using scripts\common\math;

#namespace ftue_camera;

// Namespace ftue_camera
// Params 3
// Checksum 0x9cb5a700, Offset: 0x76
// Size: 0x53
function function_7c311fa7c48e8381( lookatposition, delta, var_26c020ac116fc9fa )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( !function_3f07ff567ee093a8( lookatposition, delta ) )
    {
        waitframe();
    }
    
    if ( isdefined( var_26c020ac116fc9fa ) )
    {
        self [[ var_26c020ac116fc9fa ]]();
    }
}

// Namespace ftue_camera
// Params 3
// Checksum 0x8834d8d9, Offset: 0xd1
// Size: 0x32
function function_9e46e8b4ec3a1434( entity, delta, mindistance )
{
    return function_3f07ff567ee093a8( entity.origin, delta, mindistance );
}

// Namespace ftue_camera
// Params 3
// Checksum 0xcaab6e3c, Offset: 0x10c
// Size: 0x6d, Type: bool
function function_3f07ff567ee093a8( position, delta, mindistance )
{
    if ( distance2d( self.origin, position ) > mindistance )
    {
        return false;
    }
    
    forward = anglestoforward( self getplayerangles( 0 ) );
    normalized = vectornormalize( position - self geteye() );
    return math::anglebetweenvectorsunit( forward, normalized ) <= delta;
}

