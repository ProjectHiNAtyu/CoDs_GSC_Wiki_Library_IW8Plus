// scripts\common\telemetry.gsc  (hash_4192352a88553d67.gscc) (size: 1049 Bytes / 0x419 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3367c8d (3006692493)
// size ...... 1049 (0x419)
// includes .. 0   (offset: 0x3d5)
// strings ... 1   (offset: 0x3d5)
// dev strs .. 1   (offset: 0x40d)
// exports ... 4   (offset: 0x2e1)
// cseg ...... 0x65 + 0x27c (0x2e1)
// imports ... 3   (offset: 0x381)
// animtree1 . 0   (offset: 0x419)
// animtree2 . 0   (offset: 0x419)
#namespace telemetry;

// Namespace telemetry
// Params 0
// Checksum 0xf7d218c7, Offset: 0x83
// Size: 0xf0
function init()
{
    if ( isdefined( game ) )
    {
        if ( !isdefined( game[ "telemetry" ] ) )
        {
            game[ "telemetry" ] = spawnstruct();
        }
        
        if ( !isdefined( game[ "telemetry" ].total_player_connections ) )
        {
            game[ "telemetry" ].total_player_connections = 0;
        }
        
        if ( !isdefined( game[ "telemetry" ].life_count ) )
        {
            game[ "telemetry" ].life_count = 0;
        }
        
        if ( !isdefined( game[ "telemetry" ].game_event_count ) )
        {
            game[ "telemetry" ].game_event_count = 0;
        }
        
        if ( !isdefined( game[ "telemetry" ].total_bot_count ) )
        {
            game[ "telemetry" ].total_bot_count = 0;
        }
        
        if ( !isdefined( game[ "telemetry" ].player_ids ) )
        {
            game[ "telemetry" ].player_ids = [];
        }
        
        return;
    }
    
    println( "<dev string:x24>" );
}

// Namespace telemetry
// Params 3
// Checksum 0x50c2545a, Offset: 0x17b
// Size: 0x69
function function_6367d060fde50007( telemetry_data, name, value )
{
    if ( !isdefined( telemetry_data.statupdates ) )
    {
        telemetry_data.statupdates = [];
    }
    
    telemetry_data.statupdates[ telemetry_data.statupdates.size ] = { #value:value, #name:name };
}

// Namespace telemetry
// Params 2
// Checksum 0x717ab663, Offset: 0x1ec
// Size: 0xf5
function function_25f6c2a46443f597( var_849ec34ccb1a0e78, weaponstatscontainer )
{
    foreach ( statupdate in var_849ec34ccb1a0e78.statupdates )
    {
        if ( !isdefined( weaponstatscontainer.stats[ statupdate.name ] ) )
        {
            weaponstatscontainer.stats[ statupdate.name ] = 0;
        }
        
        weaponstatscontainer.stats[ statupdate.name ] += statupdate.value;
    }
}

