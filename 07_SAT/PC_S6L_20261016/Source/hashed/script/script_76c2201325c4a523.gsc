// script_76c2201325c4a523  (hash_76c2201325c4a523.gscc) (size: 2753 Bytes / 0xac1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf37a1c0 (3476529600)
// size ...... 2753 (0xac1)
// includes .. 3   (offset: 0xa85)
// strings ... 2   (offset: 0xa9d)
// dev strs .. 0   (offset: 0xac1)
// exports ... 6   (offset: 0x7ed)
// cseg ...... 0x82 + 0x76b (0x7ed)
// imports ... 12  (offset: 0x8dd)
// animtree1 . 0   (offset: 0xac1)
// animtree2 . 0   (offset: 0xac1)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;

#namespace namespace_bd84f01aeefe9bd9;

// Namespace namespace_bd84f01aeefe9bd9
// Params 0
// Checksum 0x2676284c, Offset: 0xa0
// Size: 0x1d
function init_vehicles()
{
    if ( utility::flag( "sat_init_vehicles" ) )
    {
        return;
    }
    
    utility::flag_set( "sat_init_vehicles" );
}

// Namespace namespace_bd84f01aeefe9bd9
// Params 1
// Checksum 0xa8d7a2fe, Offset: 0xc5
// Size: 0x1d2
function function_9e9164d9466ec5be( a_s_groups )
{
    level utility::flag_wait( "vehicle_init_done" );
    var_1a71da8565d18818 = [];
    
    foreach ( var_9b8e26f2bba8cfcb in a_s_groups )
    {
        foreach ( refname in vehicle::function_75acd2d48a8f3605( 1 ) )
        {
            if ( !vehicle_spawn::can_spawn_vehicle( refname ) )
            {
                continue;
            }
            
            vh_spawn_structs = vehicle_spawn::get_spawn_structs( refname );
            
            foreach ( s_spawn in vh_spawn_structs )
            {
                if ( isdefined( s_spawn.script_string ) && isdefined( var_9b8e26f2bba8cfcb.script_string ) && s_spawn.script_string == var_9b8e26f2bba8cfcb.script_string )
                {
                    s_spawn.refname = refname;
                    var_1a71da8565d18818[ var_1a71da8565d18818.size ] = s_spawn;
                }
            }
        }
    }
    
    return var_1a71da8565d18818;
}

// Namespace namespace_bd84f01aeefe9bd9
// Params 0
// Checksum 0x47bee1bf, Offset: 0x2a0
// Size: 0x1fb
function function_afb3d1d504450ff2()
{
    var_a395317a31d832e4 = getdvarint( @"hash_e70605bdd7aa1e98", 0 );
    var_9dfceed9cdc01a6 = getdvarint( @"hash_771650cbeeca1ab2", 0 );
    
    if ( var_a395317a31d832e4 > var_9dfceed9cdc01a6 )
    {
        var_a395317a31d832e4 = var_9dfceed9cdc01a6;
    }
    
    if ( var_a395317a31d832e4 >= 0 && var_9dfceed9cdc01a6 > 0 && var_a395317a31d832e4 < var_9dfceed9cdc01a6 )
    {
        var_9dfceed9cdc01a6 = randomintrange( var_a395317a31d832e4, var_9dfceed9cdc01a6 + 1 );
    }
    
    var_d1432126ea82e59a = 0;
    level utility::flag_wait( "vehicle_init_done" );
    var_1a71da8565d18818 = [];
    var_f5de2b1206eb8f75 = [];
    wonder_veh_array = [];
    
    foreach ( refname in vehicle::function_75acd2d48a8f3605( 1 ) )
    {
        if ( !vehicle_spawn::can_spawn_vehicle( refname ) )
        {
            continue;
        }
        
        vh_spawn_structs = vehicle_spawn::get_spawn_structs( refname );
        
        foreach ( s_spawn in vh_spawn_structs )
        {
            s_spawn.refname = refname;
        }
        
        if ( refname == %"hash_1b24b36c27a04014" )
        {
            var_f5de2b1206eb8f75 = arrayrandomize( vh_spawn_structs );
            
            if ( var_f5de2b1206eb8f75.size >= var_9dfceed9cdc01a6 )
            {
                for ( i = 0; i < var_9dfceed9cdc01a6 ; i++ )
                {
                    wonder_veh_array[ i ] = var_f5de2b1206eb8f75[ i ];
                }
            }
            
            var_1a71da8565d18818 = arraycombine( var_1a71da8565d18818, wonder_veh_array );
            continue;
        }
        
        var_1a71da8565d18818 = arraycombine( var_1a71da8565d18818, vh_spawn_structs );
    }
    
    return arrayrandomize( var_1a71da8565d18818 );
}

// Namespace namespace_bd84f01aeefe9bd9
// Params 1
// Checksum 0x52f43062, Offset: 0x4a4
// Size: 0x2b
function spawn_vehicle( s_spawn )
{
    vehicle::spawn( s_spawn.refname, s_spawn );
    s_spawn.refname = undefined;
}

// Namespace namespace_bd84f01aeefe9bd9
// Params 1
// Checksum 0x57ef5cd6, Offset: 0x4d7
// Size: 0x316
function spawn_vehicle_groups( a_s_groups )
{
    if ( getdvarint( @"hash_a6e925b5c1930590", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "vehicle_init_done" );
    
    foreach ( var_9b8e26f2bba8cfcb in a_s_groups )
    {
        var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7 = [];
        
        foreach ( refname in vehicle::function_75acd2d48a8f3605( 1 ) )
        {
            vh_spawn_structs = vehicle_spawn::get_spawn_structs( refname );
            
            foreach ( s_spawn in vh_spawn_structs )
            {
                if ( isdefined( s_spawn.script_string ) && isdefined( var_9b8e26f2bba8cfcb.script_string ) && s_spawn.script_string == var_9b8e26f2bba8cfcb.script_string )
                {
                    var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7[ var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7.size ] = s_spawn;
                    var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7[ var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7.size - 1 ].refname = refname;
                }
            }
        }
    }
    
    foreach ( var_9b8e26f2bba8cfcb in a_s_groups )
    {
        a_s_vehicles = arrayrandomize( var_9b8e26f2bba8cfcb.var_239ddca6ca7e56e7 );
        
        if ( isdefined( a_s_vehicles[ 0 ] ) )
        {
            vh_driveable = vehicle::spawn( a_s_vehicles[ 0 ].refname, a_s_vehicles[ 0 ] );
            
            if ( a_s_vehicles[ 0 ].refname == %"hash_21df6558fa3c728b" )
            {
                for ( i = 1; i < a_s_vehicles.size - 1 ; i++ )
                {
                    if ( a_s_vehicles[ i ].refname == %"hash_21df6558fa3c728b" )
                    {
                        var_5d5d427554c04086 = vehicle::spawn( a_s_vehicles[ i ].refname, a_s_vehicles[ i ] );
                    }
                }
            }
        }
    }
}

