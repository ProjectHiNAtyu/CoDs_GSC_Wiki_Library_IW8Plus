// scripts\mp\common\utility\drop_event_aggregator.gsc  (hash_7ad2134e86d7d2a5.gscc) (size: 1537 Bytes / 0x601 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e6c819d (2657911197)
// size ...... 1537 (0x601)
// includes .. 0   (offset: 0x601)
// strings ... 0   (offset: 0x601)
// dev strs .. 0   (offset: 0x601)
// exports ... 9   (offset: 0x41d)
// cseg ...... 0x58 + 0x3c5 (0x41d)
// imports ... 4   (offset: 0x585)
// animtree1 . 0   (offset: 0x601)
// animtree2 . 0   (offset: 0x601)
#namespace drop_event_aggregator;

// Namespace drop_event_aggregator
// Params 0
// Checksum 0xcd7dc90b, Offset: 0x76
// Size: 0x2c
function init()
{
    if ( !isdefined( level.var_1561fa793d1553f6 ) )
    {
        level.var_1561fa793d1553f6 = [];
        level.var_f2f2ba39db7a0c2f = [];
    }
    
    level thread function_c55f66d48e128bb4();
}

// Namespace drop_event_aggregator
// Params 0
// Checksum 0xf777ca4, Offset: 0xaa
// Size: 0x30
function function_c55f66d48e128bb4()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread function_315c5f3690ac5ca();
        player thread function_7e8a259122b69a8b();
    }
}

// Namespace drop_event_aggregator
// Params 1
// Checksum 0xf3740841, Offset: 0xe2
// Size: 0x39
function function_d13dd0aff56a8cab( callback )
{
    if ( !isdefined( level.var_1561fa793d1553f6 ) )
    {
        level.var_1561fa793d1553f6 = [];
    }
    
    level.var_1561fa793d1553f6[ level.var_1561fa793d1553f6.size ] = callback;
}

// Namespace drop_event_aggregator
// Params 1
// Checksum 0x251f3208, Offset: 0x123
// Size: 0xa0
function function_5eeee05d25c3e703( weapondropcallback )
{
    temparray = [];
    
    foreach ( callback in level.var_1561fa793d1553f6 )
    {
        if ( weapondropcallback != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_1561fa793d1553f6 = temparray;
}

// Namespace drop_event_aggregator
// Params 1
// Checksum 0x910bf8bd, Offset: 0x1cb
// Size: 0x39
function function_23f91b1f576c522e( callback )
{
    if ( !isdefined( level.var_f2f2ba39db7a0c2f ) )
    {
        level.var_f2f2ba39db7a0c2f = [];
    }
    
    level.var_f2f2ba39db7a0c2f[ level.var_f2f2ba39db7a0c2f.size ] = callback;
}

// Namespace drop_event_aggregator
// Params 1
// Checksum 0xe357e081, Offset: 0x20c
// Size: 0xa0
function function_6ce5877d66798fe0( var_56c78075c80ad4bf )
{
    temparray = [];
    
    foreach ( callback in level.var_f2f2ba39db7a0c2f )
    {
        if ( var_56c78075c80ad4bf != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_f2f2ba39db7a0c2f = temparray;
}

// Namespace drop_event_aggregator
// Params 0
// Checksum 0x807294f9, Offset: 0x2b4
// Size: 0xab
function function_315c5f3690ac5ca()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"weapon_dropped", droppedentity, weaponobject );
        
        foreach ( callback in level.var_1561fa793d1553f6 )
        {
            self [[ callback ]]( droppedentity, weaponobject );
        }
    }
}

// Namespace drop_event_aggregator
// Params 0
// Checksum 0x9bfab4c7, Offset: 0x367
// Size: 0xb6
function function_7e8a259122b69a8b()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        self waittill( #"dropped_weapon_scriptable", droppedweapon, secondparam, soundposition );
        
        foreach ( callback in level.var_f2f2ba39db7a0c2f )
        {
            self [[ callback ]]( droppedweapon, secondparam, soundposition );
        }
    }
}

