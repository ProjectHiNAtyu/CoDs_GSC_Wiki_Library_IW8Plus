// scripts\common\telemetry_utils.gsc  (hash_4a6760982b403bad.gscc) (size: 3212 Bytes / 0xc8c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9edf60b3 (2665439411)
// size ...... 3212 (0xc8c)
// includes .. 0   (offset: 0xbc0)
// strings ... 15  (offset: 0xbc0)
// dev strs .. 1   (offset: 0xc80)
// exports ... 15  (offset: 0x7b0)
// cseg ...... 0x171 + 0x63f (0x7b0)
// imports ... 15  (offset: 0xa08)
// animtree1 . 0   (offset: 0xc8c)
// animtree2 . 0   (offset: 0xc8c)
#namespace telemetry_utils;

// Namespace telemetry_utils
// Params 2
// Checksum 0xc18f53be, Offset: 0x18f
// Size: 0x64
function function_5995f9c2ef729dbd( callback, func )
{
    if ( !isdefined( level.telemetry_callbacks ) )
    {
        level.telemetry_callbacks = [];
    }
    
    if ( !isdefined( level.telemetry_callbacks[ callback ] ) )
    {
        level.telemetry_callbacks[ callback ] = [];
    }
    
    level.telemetry_callbacks[ callback ][ level.telemetry_callbacks[ callback ].size ] = func;
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x9bd6bd4b, Offset: 0x1fb
// Size: 0x19, Type: bool
function function_7ffb9ee91a85ee0d( callback )
{
    return isdefined( level.telemetry_callbacks[ callback ] );
}

// Namespace telemetry_utils
// Params 2
// Checksum 0xe9d1f08c, Offset: 0x21d
// Size: 0x10f
function function_af2d366f9522f76f( callback, data )
{
    callbacks = level.telemetry_callbacks[ callback ];
    
    if ( !isdefined( callbacks ) )
    {
        return;
    }
    
    if ( isdefined( data ) )
    {
        foreach ( callbackfunc in callbacks )
        {
            thread [[ callbackfunc ]]( data );
        }
        
        return;
    }
    
    foreach ( callbackfunc in callbacks )
    {
        thread [[ callbackfunc ]]();
    }
}

// Namespace telemetry_utils
// Params 2
// Checksum 0xfc635d28, Offset: 0x334
// Size: 0x69
function function_bce6584b90db3f0d( eventname, position )
{
    assert( isplayer( self ) );
    telemetry_data = { #position:position ?? self.origin, #eventname:eventname, #player:self };
    function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
}

// Namespace telemetry_utils
// Params 2
// Checksum 0xea8ff428, Offset: 0x3a5
// Size: 0xc1
function function_8fab541f1654a751( ability, damage )
{
    if ( !isplayer( self ) || !isstring( ability ) )
    {
        return;
    }
    
    self dlog_recordplayerevent( "dlog_event_ability_activated", [ "ability", ability, "damage", damage ?? 0, "time_msfrommatchstart", gettime() - ( level.starttime ?? 0 ), "playerposx", self.origin[ 0 ], "playerposy", self.origin[ 1 ], "playerposz", self.origin[ 2 ] ] );
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x6a7eda39, Offset: 0x46e
// Size: 0x38
function get_time_from_match_start( basetime )
{
    if ( isdefined( level.starttimefrommatchstart ) )
    {
        if ( basetime < level.starttimefrommatchstart )
        {
            return 0;
        }
        
        return ( basetime - level.starttimefrommatchstart );
    }
    
    return 0;
}

// Namespace telemetry_utils
// Params 0
// Checksum 0x60cbd5af, Offset: 0x4af
// Size: 0x5e
function function_cae236c583ce98fe()
{
    mountstring = self playermounttype();
    
    if ( isdefined( mountstring ) )
    {
        switch ( mountstring )
        {
            case #"hash_b882c19d3b9f4eb6":
                return "MOUNT_LEFT";
            case #"hash_c00b1399e3e96eeb":
                return "MOUNT_RIGHT";
            case #"hash_d45b94ed344be47e":
                return "MOUNT_TOP";
        }
    }
    
    return "MOUNT_NONE";
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x1031bded, Offset: 0x516
// Size: 0x1e
function is_valid_client( client )
{
    if ( game[ "isLaunchChunk" ] )
    {
        return 0;
    }
    
    return isplayer( client );
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x4ee79aed, Offset: 0x53d
// Size: 0x8a, Type: bool
function function_ac165ec93ebac8d5( data )
{
    if ( !isdefined( data.player ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers[ "telemetry" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers[ "telemetry" ].life ) )
    {
        return false;
    }
    
    return true;
}

// Namespace telemetry_utils
// Params 0
// Checksum 0x6581b9bb, Offset: 0x5d0
// Size: 0xab
function get_objective_type()
{
    objectivetype = "hub";
    
    if ( isdefined( level.active_objectives_string ) )
    {
        objectivetype = level.active_objectives_string;
    }
    else if ( isdefined( level.contentmanager ) && isdefined( level.contentmanager.activeobjective ) )
    {
        instance = level.contentmanager.activeobjective;
        location = instance.targetname;
        
        if ( isdefined( location ) )
        {
            objectivetype = location;
        }
    }
    else if ( isdefined( level.lastobjective ) )
    {
        objectivetype = level.lastobjective;
    }
    
    return objectivetype;
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x258d82d3, Offset: 0x684
// Size: 0x32
function function_5e023df7bfb08695( client )
{
    if ( is_valid_client( client ) )
    {
        return ( client.clientid < level.maxlogclients );
    }
    
    return 0;
}

// Namespace telemetry_utils
// Params 1
// Checksum 0xad3a427f, Offset: 0x6be
// Size: 0x5d, Type: bool
function function_e6eefbdfebae39bf( player )
{
    if ( is_valid_client( player ) && !isbot( player ) && getdvarint( @"hash_5e2f0f222e2d7721" ) > 0 )
    {
        var_954f21fb207ebeb6 = player function_28ce5f44a5393018();
        return ( var_954f21fb207ebeb6 >= getdvarint( @"hash_5e2f0f222e2d7721" ) * 1000 );
    }
    
    return false;
}

// Namespace telemetry_utils
// Params 1
// Checksum 0x8d226a3a, Offset: 0x724
// Size: 0x57
function function_c54601d44e7b8e8a( player )
{
    if ( !function_e6eefbdfebae39bf( player ) && player.pers[ "telemetry" ].reached_match_end == 0 )
    {
        player.pers[ "telemetry" ].reached_match_end = 1;
    }
}

// Namespace telemetry_utils
// Params 1
// Checksum 0xaacad21f, Offset: 0x783
// Size: 0x2c
function validatetuningdata( value )
{
    if ( !isfloat( value ) )
    {
        assert( "<dev string:x24>" );
        value = -1e+06;
    }
    
    return value;
}

