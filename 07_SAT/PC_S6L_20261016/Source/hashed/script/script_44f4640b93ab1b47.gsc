// script_44f4640b93ab1b47  (hash_44f4640b93ab1b47.gscc) (size: 732 Bytes / 0x2dc)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf2e1303 (3475903235)
// size ...... 732 (0x2dc)
// includes .. 0   (offset: 0x2dc)
// strings ... 0   (offset: 0x2dc)
// dev strs .. 0   (offset: 0x2dc)
// exports ... 5   (offset: 0x180)
// cseg ...... 0x58 + 0x128 (0x180)
// imports ... 5   (offset: 0x248)
// animtree1 . 0   (offset: 0x2dc)
// animtree2 . 0   (offset: 0x2dc)
#namespace uav_manager;

// Namespace uav_manager
// Params 0
// Checksum 0x197aa50a, Offset: 0x76
// Size: 0x1c
function function_7ec01a0dd5083696()
{
    level.var_1de0def30019bb84 = [];
    level thread function_a0e799a2b9de8a1c();
    level thread function_ab166b49f4b3d675();
}

// Namespace uav_manager
// Params 0
// Checksum 0xa6709732, Offset: 0x9a
// Size: 0x60
function function_a0e799a2b9de8a1c()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"uav_started", uavowner, uavtype );
        
        if ( !isdefined( uavowner ) || isbot( uavowner ) )
        {
            continue;
        }
        
        level.var_1de0def30019bb84[ uavowner getentitynumber() ] = uavowner;
    }
}

// Namespace uav_manager
// Params 0
// Checksum 0x84bf3c38, Offset: 0x102
// Size: 0x67
function function_ab166b49f4b3d675()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"uav_finished", uavowner );
        
        if ( isbot( uavowner ) )
        {
            continue;
        }
        
        if ( isdefined( uavowner ) )
        {
            level.var_1de0def30019bb84[ uavowner getentitynumber() ] = undefined;
        }
        
        level.var_1de0def30019bb84 = function_5713d46873b29625( level.var_1de0def30019bb84 );
    }
}

// Namespace uav_manager
// Params 0
// Checksum 0xa4479cce, Offset: 0x171
// Size: 0xe, Type: bool
function function_ed10eddbbc9b44ea()
{
    return level.var_1de0def30019bb84.size > 0;
}

