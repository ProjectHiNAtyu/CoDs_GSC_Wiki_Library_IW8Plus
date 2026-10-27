// scripts\mp\zm\systems\zm_equipment_oob.gsc  (hash_7fbed3f1c01c2b58.gscc) (size: 2151 Bytes / 0x867 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d9579c6 (2106948038)
// size ...... 2151 (0x867)
// includes .. 3   (offset: 0x837)
// strings ... 2   (offset: 0x84f)
// dev strs .. 0   (offset: 0x867)
// exports ... 6   (offset: 0x4bb)
// cseg ...... 0x94 + 0x427 (0x4bb)
// imports ... 22  (offset: 0x5ab)
// animtree1 . 0   (offset: 0x867)
// animtree2 . 0   (offset: 0x867)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_equipment_oob;

// Namespace zm_equipment_oob
// Params 0
// Checksum 0x83298eee, Offset: 0xb2
// Size: 0xb0
function init()
{
    level.zm_equipment_ignore_oob_volume = getentarray( "equipment_ignore_oob_volume", #script_noteworthy );
    level.var_65c5957bebc58d92 = getentarray( "equipment_force_oob_volum", #script_noteworthy );
    utility::registersharedfunc( #"equipment", #"hash_e0ab82e8a3d12d1d", &is_equipment_in_bounds );
    utility::registersharedfunc( #"equipment", #"hash_72c7c53eb92e361f", &function_80fd10a2ad8a9aa5 );
    utility::registersharedfunc( #"equipment", #"hash_b423513c70018ac2", &function_596c095bd19ec454 );
    utility::registersharedfunc( #"equipment", #"hash_1b48910965b8556e", &function_6ab86b677dd220e1 );
}

// Namespace zm_equipment_oob
// Params 4
// Checksum 0x8a8a1ea9, Offset: 0x16a
// Size: 0x273, Type: bool
function is_equipment_in_bounds( equipment_location, var_adfffe798cf97bc2, ignored_obstacles, var_2a909dd2c68b7619 )
{
    if ( isdefined( level.zm_equipment_ignore_oob_volume ) )
    {
        foreach ( volume in level.zm_equipment_ignore_oob_volume )
        {
            if ( self istouching( volume ) )
            {
                return true;
            }
        }
    }
    
    var_ce1489ecfb0be2ba = function_6ab86b677dd220e1();
    
    if ( var_ce1489ecfb0be2ba.size > 0 )
    {
        foreach ( volume in var_ce1489ecfb0be2ba )
        {
            if ( self istouching( volume ) )
            {
                return false;
            }
        }
    }
    
    zone_struct = zone_manager::function_90e5c3e2272b0130( equipment_location );
    
    if ( !isdefined( zone_struct ) || !zone_struct.is_enabled )
    {
        return false;
    }
    
    closest_navmesh_point = self.closest_navmesh_point;
    moving_platform_info = utility::function_7c45b71b8e0d3cff( self );
    
    if ( isdefined( moving_platform_info ) )
    {
        if ( moving_platform_info.groundent vehicle::is_vehicle() && moving_platform_info.groundent vehicle::is_boat() )
        {
            return false;
        }
        else if ( moving_platform_info.groundent.var_680baa076be6d8b )
        {
            return true;
        }
        
        closest_navmesh_point = getclosestpointonnavmesh( equipment_location, undefined, 1, 0, 1, 0, 0, 0, ignored_obstacles ?? 0, var_2a909dd2c68b7619 ?? 0 );
    }
    
    if ( !isdefined( closest_navmesh_point ) )
    {
        return false;
    }
    
    if ( var_adfffe798cf97bc2 )
    {
        return ( distance2dsquared( equipment_location, closest_navmesh_point ) < 2025 && abs( closest_navmesh_point[ 2 ] - equipment_location[ 2 ] ) <= 200 );
    }
    
    var_9b6ed8c717a0e55f = 400;
    
    if ( abs( closest_navmesh_point[ 2 ] - equipment_location[ 2 ] ) <= 20 )
    {
        sight_trace = sighttracepassed( equipment_location, closest_navmesh_point + ( 0, 0, 5 ), 0, self );
        
        if ( sight_trace )
        {
            var_9b6ed8c717a0e55f = 2025;
        }
    }
    
    return distancesquared( equipment_location, closest_navmesh_point ) < var_9b6ed8c717a0e55f;
}

// Namespace zm_equipment_oob
// Params 1
// Checksum 0x6cf56ee7, Offset: 0x3e6
// Size: 0x4a
function function_80fd10a2ad8a9aa5( volume )
{
    if ( !isent( volume ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_5be91b0ccba3a2ff ) )
    {
        level.var_5be91b0ccba3a2ff = [];
    }
    
    level.var_5be91b0ccba3a2ff = arraycombineunique( level.var_5be91b0ccba3a2ff, [ volume ] );
}

// Namespace zm_equipment_oob
// Params 1
// Checksum 0x135ed8c3, Offset: 0x438
// Size: 0x41
function function_596c095bd19ec454( volume )
{
    if ( !isent( volume ) )
    {
        return;
    }
    
    if ( !isarray( level.var_5be91b0ccba3a2ff ) )
    {
        return;
    }
    
    level.var_5be91b0ccba3a2ff = arrayremove( level.var_5be91b0ccba3a2ff, volume );
}

// Namespace zm_equipment_oob
// Params 0
// Checksum 0x683ad127, Offset: 0x481
// Size: 0x39
function function_6ab86b677dd220e1()
{
    map_volumes = level.var_65c5957bebc58d92 ?? [];
    temp_volumes = level.var_5be91b0ccba3a2ff ?? [];
    return arraycombineunique( map_volumes, temp_volumes );
}

