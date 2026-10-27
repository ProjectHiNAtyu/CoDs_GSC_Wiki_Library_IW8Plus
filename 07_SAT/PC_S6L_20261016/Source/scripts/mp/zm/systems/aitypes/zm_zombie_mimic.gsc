// scripts\mp\zm\systems\aitypes\zm_zombie_mimic.gsc  (hash_447e781dda7a4abb.gscc) (size: 4357 Bytes / 0x1105 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x397b112f (964366639)
// size ...... 4357 (0x1105)
// includes .. 8   (offset: 0x1039)
// strings ... 11  (offset: 0x1079)
// dev strs .. 0   (offset: 0x1105)
// exports ... 9   (offset: 0xa31)
// cseg ...... 0x12f + 0x902 (0xa31)
// imports ... 40  (offset: 0xb99)
// animtree1 . 0   (offset: 0x1105)
// animtree2 . 0   (offset: 0x1105)
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_zombie_mimic;

// Namespace zm_zombie_mimic
// Params 2
// Checksum 0x52746e42, Offset: 0x14d
// Size: 0x100
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_747bbf448c211f92 ) )
    {
        return;
    }
    
    level.var_747bbf448c211f92 = 1;
    level thread namespace_a3764ff99ce0cd56::function_de819190b982b94e();
    level.var_29b254229e44041c = "mimicproplist:cer_mimic_prop_list_default";
    namespace_a3764ff99ce0cd56::function_e38030e0f56f312b( 1, &namespace_a3764ff99ce0cd56::function_931cd02a834f49f7, &function_e96c30608d3170c9 );
    
    if ( !isdefined( level.var_35b49e9ab3037480 ) )
    {
        aitypes = agent_utils::get_aitype_by_subclass( "zombie_mimic" );
        level.var_35b49e9ab3037480 = utility::array_random( aitypes );
    }
    
    level callback::add( "mimic_spawned", &on_mimic_spawned );
    level callback::add( "on_entity_hidden_in_prop", &function_99abf792b8a9194 );
    zm_cleanup_manager::function_f4275f0bbf17cbf6( "zombie_mimic", &function_ff4b5269695b08c2 );
    zm_cleanup_manager::function_f4275f0bbf17cbf6( "zombie_mimic_maraud", &function_ff4b5269695b08c2 );
    zm_cleanup_manager::function_f4275f0bbf17cbf6( "zombie_mimic_emp", &function_ff4b5269695b08c2 );
    level.var_8939c433088c0f10 = &function_6f957c883e70736a;
    level.var_d2b3b21e766f477e = &function_63571152a4525c0f;
}

// Namespace zm_zombie_mimic
// Params 1
// Checksum 0x4978a810, Offset: 0x255
// Size: 0x87
function on_mimic_spawned( params )
{
    self.ignore_enemy_count = 1;
    
    if ( self.grenadeweapon.basename != "none" )
    {
        weapon::registerkillstreakweaponmap( self.subclass, self.grenadeweapon.basename );
    }
    
    if ( level.var_c7c8ff1d46d97ab8 && isdefined( self.spawn_loc ) && utility::percent_chance( 100 ) )
    {
        self.var_e1994f7442414a09 = 1;
    }
}

// Namespace zm_zombie_mimic
// Params 1
// Checksum 0x9ce6c1e1, Offset: 0x2e4
// Size: 0xf9, Type: bool
function function_e96c30608d3170c9( lure_prop_struct )
{
    if ( self.var_b17113b985277e83 )
    {
        return false;
    }
    
    if ( !isdefined( lure_prop_struct.zone ) )
    {
        lure_prop_struct.zone = zone_manager::function_90e5c3e2272b0130( lure_prop_struct.origin );
    }
    
    if ( !isdefined( lure_prop_struct.zone ) || !lure_prop_struct.zone.is_active )
    {
        return false;
    }
    
    if ( lure_prop_struct.interact ishintinoperable() || !lure_prop_struct.interact function_45c212dce7227aa7() || !lure_prop_struct.interact isusable() )
    {
        return false;
    }
    
    if ( lure_prop_struct.interact isscriptable() && lure_prop_struct.interact getscriptablehaspart( "base" ) && lure_prop_struct.interact getscriptablepartstate( "base" ) == "power_off" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_zombie_mimic
// Params 2
// Checksum 0x6455d77a, Offset: 0x3e6
// Size: 0x153
function function_6f957c883e70736a( origin, num_points )
{
    player = utility::array_random( level.players );
    
    if ( !isdefined( player ) )
    {
        return [];
    }
    
    zone = player zone_manager::get_current_zone( 1, 1 );
    
    if ( !isdefined( zone ) && isdefined( origin ) )
    {
        zone = zone_manager::function_90e5c3e2272b0130( origin );
    }
    else if ( !isdefined( zone ) )
    {
        active_zones = zone_manager::get_active_zones();
        zone = active_zones[ randomint( active_zones.size ) ];
    }
    
    spawn_points = [];
    
    if ( isdefined( zone ) && zone.nodes.size )
    {
        node = utility::array_random( zone.nodes );
        spawn_points = getrandomnavpoints( node.origin, 1000, num_points * 2 );
        spawn_points = function_ec6dc363b1dae78( spawn_points, zone, num_points );
    }
    
    if ( !spawn_points.size )
    {
        if ( isdefined( zone ) && !isdefined( origin ) )
        {
            origin = zone.nodes[ randomint( zone.nodes.size ) ].origin;
        }
        
        if ( isdefined( origin ) )
        {
            spawn_points = utility::function_4cf0c9c46de1da7d( origin, num_points * 2, 50, 1000, 0 );
            spawn_points = function_ec6dc363b1dae78( spawn_points, zone, num_points );
        }
    }
    
    return spawn_points;
}

// Namespace zm_zombie_mimic
// Params 3
// Checksum 0x66bb945d, Offset: 0x542
// Size: 0x20a
function function_ec6dc363b1dae78( points, zone, num )
{
    var_24c2a895b0181308 = [];
    
    if ( isdefined( zone ) )
    {
        var_24c2a895b0181308 = utility::getstructarray( zone.zone_name + "_no_mimic_prop_node", "targetname" );
    }
    
    var_32ddd74997c5712 = [];
    
    foreach ( point in points )
    {
        if ( isvector( point ) )
        {
            temp_point = spawnstruct();
            temp_point.origin = point;
            point = temp_point;
        }
        
        if ( utility::get_array_of_closest( point.origin, level.var_bdaf1d69422ab15b, undefined, undefined, 32 ).size > 0 )
        {
            continue;
        }
        
        if ( var_24c2a895b0181308.size > 0 )
        {
            var_e9c7ab9f0c57df95 = 1;
            
            foreach ( no_prop in var_24c2a895b0181308 )
            {
                if ( abs( point.origin[ 2 ] - no_prop.origin[ 2 ] ) < no_prop.halfheight && distance2d( no_prop.origin, point.origin ) < no_prop.radius )
                {
                    var_e9c7ab9f0c57df95 = 0;
                    break;
                }
            }
            
            if ( !var_e9c7ab9f0c57df95 )
            {
                continue;
            }
        }
        
        var_32ddd74997c5712[ var_32ddd74997c5712.size ] = point;
        
        if ( var_32ddd74997c5712.size >= num )
        {
            break;
        }
    }
    
    return var_32ddd74997c5712;
}

// Namespace zm_zombie_mimic
// Params 1
// Checksum 0xdf5e15fe, Offset: 0x755
// Size: 0xc7
function function_99abf792b8a9194( params )
{
    prop = params.prop;
    
    if ( !isdefined( prop ) )
    {
        return;
    }
    
    prop endon( #"death" );
    self endon( #"death" );
    
    if ( !isdefined( prop.zone ) )
    {
        prop.zone = zone_manager::function_90e5c3e2272b0130( prop.origin + ( 0, 0, 15 ) );
    }
    
    if ( isdefined( prop.zone ) )
    {
        prop.var_39ce2fee55797172 = 1;
        
        while ( !prop.zone.is_active )
        {
            wait 0.5;
        }
        
        prop.var_39ce2fee55797172 = undefined;
    }
}

// Namespace zm_zombie_mimic
// Params 2, eflags: 0x4
// Checksum 0xf89289fe, Offset: 0x824
// Size: 0x42, Type: bool
function private function_ff4b5269695b08c2( var_5cb4f8bc8ebba77, var_46159e2772b2df4 )
{
    if ( !level.var_c7c8ff1d46d97ab8 || !zombie_mimic::function_fd0636371f71d2e6() )
    {
        zm_cleanup_manager::teleport_zombie( var_46159e2772b2df4, istrue( level.var_997e716c3f61f90 ) );
    }
    
    return true;
}

// Namespace zm_zombie_mimic
// Params 0, eflags: 0x4
// Checksum 0x15c4589f, Offset: 0x86f
// Size: 0x1c2
function private function_63571152a4525c0f()
{
    cur_zone = zone_manager::get_current_zone();
    
    if ( isdefined( cur_zone ) )
    {
        final_enable_zone = undefined;
        
        foreach ( adjacent_zone_name, var_1c5646f3c5cecb1 in cur_zone.var_c96b1c3cfbbd6aac )
        {
            adjacent_zone_struct = zone_manager::get_zone_struct( adjacent_zone_name );
            
            if ( !adjacent_zone_struct.is_enabled || !var_1c5646f3c5cecb1.var_3f0f2395ff496746 )
            {
                continue;
            }
            
            if ( self.var_b63bc1a2a918ba4b == adjacent_zone_struct.zone_name )
            {
                continue;
            }
            
            final_enable_zone = adjacent_zone_struct;
            
            if ( adjacent_zone_struct.occupants.size == 0 )
            {
                break;
            }
        }
        
        if ( isdefined( final_enable_zone ) )
        {
            self.var_b63bc1a2a918ba4b = cur_zone.zone_name;
            return getrandomnavpoint( final_enable_zone.origin, 128 );
        }
    }
    
    all_zones = zone_manager::get_active_zones();
    
    foreach ( zone in all_zones )
    {
        if ( zone.occupants.size == 0 )
        {
            return getrandomnavpoint( zone.origin, 128 );
        }
    }
}

