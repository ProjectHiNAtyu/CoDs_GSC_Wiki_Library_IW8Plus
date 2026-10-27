// script_47366beb5ba9fa22  (hash_47366beb5ba9fa22.gscc) (size: 1290 Bytes / 0x50a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5168c8d (3575024781)
// size ...... 1290 (0x50a)
// includes .. 2   (offset: 0x4d6)
// strings ... 0   (offset: 0x4e6)
// dev strs .. 3   (offset: 0x4e6)
// exports ... 4   (offset: 0x38e)
// cseg ...... 0xb2 + 0x2dc (0x38e)
// imports ... 6   (offset: 0x42e)
// animtree1 . 0   (offset: 0x50a)
// animtree2 . 0   (offset: 0x50a)
#using script_d74ae0b4aa21186;
#using scripts\mp\gameobjects;

#namespace namespace_c11142cfacfb2826;

// Namespace namespace_c11142cfacfb2826
// Params 0
// Checksum 0x7d579473, Offset: 0xd0
// Size: 0x67
function createevent()
{
    event = mind::function_1d123cae6381160b();
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_b915067066c47418 = event;
    eventstream.events[ eventstream.events.size ] = event;
}

// Namespace namespace_c11142cfacfb2826
// Params 0
// Checksum 0xaa4f67cc, Offset: 0x13f
// Size: 0x1d3
function getevent()
{
    event = self.mind.eventstream.var_b915067066c47418;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        if ( !isdefined( level.objectives ) )
        {
            return event.result;
        }
        
        foreach ( obj in level.objectives )
        {
            switch ( level.gametype )
            {
                case #"hash_ca6516c10db2c95":
                case #"hash_2f5af599c5c220d3":
                case #"hash_f4a9126c03d3385b":
                    if ( self.team == obj gameobjects::getownerteam() )
                    {
                        continue;
                    }
                    
                    break;
                case #"hash_6efb0f59a62300fb":
                case #"hash_cf3000550ee7e8b3":
                case #"hash_ec72fd25bbbac99e":
                    if ( !obj.active )
                    {
                        continue;
                    }
                    
                    break;
            }
            
            event.result[ event.result.size ] = obj;
        }
        
        if ( event.result.size > 1 )
        {
            event.result = sortbydistance( event.result, self.origin );
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

// Namespace namespace_c11142cfacfb2826
// Params 0
// Checksum 0x4646bb4f, Offset: 0x31b
// Size: 0x72
function function_e91d7f8f23d73054()
{
    assert( level.gametype == "<dev string:x24>" || level.gametype == "<dev string:x29>" || level.gametype == "<dev string:x34>" );
    nexthardpoint = level.prevzoneindex % level.objectives.size + 1;
    return level.objectives[ string( nexthardpoint ) ];
}

