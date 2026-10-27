// scripts\common\metabone.gsc  (hash_429c2a03090c1ea1.gscc) (size: 23115 Bytes / 0x5a4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9477169b (2490832539)
// size ...... 23115 (0x5a4b)
// includes .. 3   (offset: 0x5787)
// strings ... 10  (offset: 0x579f)
// dev strs .. 40  (offset: 0x583b)
// exports ... 51  (offset: 0x4403)
// cseg ...... 0x113 + 0x42f0 (0x4403)
// imports ... 86  (offset: 0x4bfb)
// animtree1 . 0   (offset: 0x5a4b)
// animtree2 . 0   (offset: 0x5a4b)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;

#namespace metabone;

// Namespace metabone
// Params 1
// Checksum 0xca51b557, Offset: 0x131
// Size: 0xc4
function init_metabones( metabones_bundle_names )
{
    assert( !isdefined( self.metabones ), "<dev string:x24>" );
    
    if ( !isarray( metabones_bundle_names ) )
    {
        metabones_bundle_names = [ metabones_bundle_names ];
    }
    
    foreach ( bundle_name in metabones_bundle_names )
    {
        build_metabone_info( bundle_name );
    }
    
    callback::add( "on_ai_set_max_health", &function_8a959a3ac510c2d0 );
    
    /#
        thread debug_metabones();
    #/
}

// Namespace metabone
// Params 1
// Checksum 0x4d1bcdc3, Offset: 0x1fd
// Size: 0x2df
function restore_metabones( saved_metabones )
{
    foreach ( respawn_metabone in saved_metabones )
    {
        metabone_name = undefined;
        metabones_def = undefined;
        
        foreach ( bundle_name in self.metabones.bundle_names )
        {
            metabones_def = get_metabones_def( bundle_name );
            
            foreach ( metabone_def in metabones_def.metabones )
            {
                metabone_def_name = getxhash( metabone_def.name );
                
                if ( metabone_def_name == respawn_metabone.name )
                {
                    metabone_name = metabone_def.name;
                    break;
                }
            }
            
            if ( isdefined( metabone_name ) )
            {
                break;
            }
        }
        
        if ( !isdefined( metabone_name ) )
        {
            continue;
        }
        
        metabone_info = self.metabones.info[ metabone_name ];
        metabone_info.is_active = respawn_metabone.is_active;
        metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
        
        foreach ( state_name, state in metabone.var_63e19fb21594d5a2 )
        {
            if ( state.index == respawn_metabone.state_index )
            {
                set_metabone_state( metabone_name, state_name );
                
                if ( self getscriptablehaspart( metabone_name ) && self getscriptableparthasstate( metabone_name, state_name ) && self getscriptablepartstate( metabone_name ) != state_name )
                {
                    self setscriptablepartstate( metabone_name, state_name, 1 );
                }
                
                break;
            }
        }
    }
}

// Namespace metabone
// Params 1
// Checksum 0xffcc284b, Offset: 0x4e4
// Size: 0x7c
function is_metabone_destroyed( metabone_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) ) )
    {
        return 0;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    
    if ( isdefined( metabone ) )
    {
        return is_destroyed( metabone );
    }
    
    return 0;
}

// Namespace metabone
// Params 2
// Checksum 0x354055fd, Offset: 0x569
// Size: 0xa8
function get_metabone_metadata( metabone_name, data_type )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) ) )
    {
        return;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    
    if ( isdefined( metabone ) )
    {
        metadata = function_a4f4ee60be8ebe7b( metabone, data_type );
        
        if ( isdefined( metadata ) )
        {
            metadata_copy = structcopy( metadata, 1 );
            return metadata_copy;
        }
    }
}

// Namespace metabone
// Params 3
// Checksum 0x3d7310f7, Offset: 0x61a
// Size: 0x21e
function set_metabone_active( metabone_name, active, user_data )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    
    if ( isdefined( metabone ) )
    {
        metabone_info = self.metabones.info[ metabone.name ];
        metabone_info.is_active = active;
        function_94fdab7a61434c30( self.metabones.on_set_active, metabone_info.var_7c0af65ae40e856d, { #user_data:user_data, #active:active, #metabone_name:metabone.name } );
        
        /#
            if ( active && isdefined( metabone.tags ) )
            {
                foreach ( tag in metabone.tags )
                {
                    assert( isdefined( self gettagindex( tag.tagname ) ), "<dev string:x55>" + self getentitynumber() + "<dev string:x5e>" + tag.tagname + "<dev string:x76>" + metabone.name + "<dev string:x87>" + self.metabones.info[ metabone_name ].bundle_name + "<dev string:x8e>" );
                }
            }
        #/
    }
}

// Namespace metabone
// Params 2
// Checksum 0xf7eb9df8, Offset: 0x840
// Size: 0x1f8
function set_metabone_state( metabone_name, state_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    metabone_info = self.metabones.info[ metabone.name ];
    
    if ( isdefined( metabone ) )
    {
        if ( isdefined( metabone_info.current_state_index ) )
        {
            data = get_metadata_from_state( metabone.states[ metabone_info.current_state_index ], "Types_Damageable" );
            
            if ( isdefined( data ) )
            {
                if ( isdefined( metabone_info.health ) )
                {
                    metabone_info.var_9001c14ad8db7425[ metabone_info.current_state_index ] = metabone_info.health;
                }
            }
        }
        
        state = metabone.var_63e19fb21594d5a2[ state_name ];
        
        if ( isdefined( state ) )
        {
            metabone_info.current_state_index = state.index;
            
            if ( isdefined( metabone_info.var_9001c14ad8db7425[ metabone_info.current_state_index ] ) )
            {
                metabone_info.health = metabone_info.var_9001c14ad8db7425[ metabone_info.current_state_index ];
            }
            else
            {
                metabone_info.health = undefined;
            }
            
            params = spawnstruct();
            params.metabone_name = metabone.name;
            params.state_name = state.name;
            callback::callback( "metabone_state_changed", params );
        }
    }
}

// Namespace metabone
// Params 7
// Checksum 0xe614c171, Offset: 0xa40
// Size: 0x1b0
function damage_metabone( metabone_name, damage, eattacker, einflictor, vdir, vpoint, objweapon )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return 0;
    }
    
    function_9d446596537a8d42( metabone_name, vpoint );
    b_destroyed = 0;
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( metabone_info.health > 0 )
    {
        if ( damage < metabone_info.health )
        {
            metabone_info.health -= damage;
            params = spawnstruct();
            params.metabone_name = metabone_name;
            params.damage = damage;
            params.health = metabone_info.health;
            params.eattacker = eattacker;
            params.einflictor = einflictor;
            params.objweapon = objweapon;
            callback::callback( "metabone_damaged_not_destroyed", params );
            function_94fdab7a61434c30( self.metabones.var_ea5c19b7aa8fc9ad, metabone_info.var_7c0af65ae40e856d, params );
            self notify( #"metabone_damaged_not_destroyed" );
        }
        else
        {
            destroy_metabone( metabone_name, eattacker, einflictor, vdir, objweapon );
            self notify( #"metabone_destroyed" );
            b_destroyed = 1;
        }
    }
    
    return b_destroyed;
}

// Namespace metabone
// Params 5
// Checksum 0x2d3d57dc, Offset: 0xbf9
// Size: 0x75
function damage_metabone_state( metabone_name, damage, state_name, eattacker, einflictor )
{
    assert( isdefined( state_name ) && damage >= 0 );
    new_health = function_c635b0dc08baefad( metabone_name, 1, -1 * damage, state_name );
    
    if ( new_health <= 0 )
    {
        destroy_metabone( metabone_name, eattacker, einflictor );
    }
}

// Namespace metabone
// Params 3
// Checksum 0x14b33aa2, Offset: 0xc76
// Size: 0x2c
function function_dbe4a2c3b0797294( metabone_name, health, state_name )
{
    function_c635b0dc08baefad( metabone_name, 1, health, state_name );
}

// Namespace metabone
// Params 3
// Checksum 0x8b4628c4, Offset: 0xcaa
// Size: 0x2b
function set_metabone_health( metabone_name, health, state_name )
{
    function_c635b0dc08baefad( metabone_name, 0, health, state_name );
}

// Namespace metabone
// Params 1
// Checksum 0x6ab8dedf, Offset: 0xcdd
// Size: 0x5f
function function_50a0af5f47ae9a88( metabone_name )
{
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    init_metabone_health( metabone );
}

// Namespace metabone
// Params 2
// Checksum 0x714da14, Offset: 0xd44
// Size: 0x16d
function get_metabone_health( metabone_name, state_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( !isdefined( metabone_info ) )
    {
        assertmsg( "<dev string:xa0>" + metabone_name );
        return;
    }
    
    if ( isdefined( state_name ) )
    {
        metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
        target_metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
        target_state = target_metabone.var_63e19fb21594d5a2[ state_name ];
        target_state_index = target_state.index;
        
        if ( target_state_index != metabone_info.current_state_index )
        {
            damageable_data = get_metadata_from_state( target_state, "Types_Damageable" );
            
            if ( !isdefined( damageable_data ) )
            {
                return;
            }
            
            assert( isdefined( metabone_info.var_9001c14ad8db7425[ target_state_index ] ) );
            return metabone_info.var_9001c14ad8db7425[ target_state_index ];
        }
    }
    
    if ( isdefined( metabone_info.health ) )
    {
        return metabone_info.health;
    }
}

// Namespace metabone
// Params 2
// Checksum 0x16ab0267, Offset: 0xeba
// Size: 0x175
function get_metabone_maxhealth( metabone_name, state_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( !isdefined( metabone_info ) )
    {
        assertmsg( "<dev string:xa0>" + metabone_name );
        return;
    }
    
    maxhealth = undefined;
    
    if ( isdefined( state_name ) )
    {
        metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
        target_metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
        target_state = target_metabone.var_63e19fb21594d5a2[ state_name ];
        damageable_data = get_metadata_from_state( target_state, "Types_Damageable" );
        
        if ( isdefined( damageable_data ) )
        {
            if ( !damageable_data.absolutehealth )
            {
                maxhealth = int( damageable_data.health * self.metabones.stored_maxhealth );
                
                if ( damageable_data.healthcap > 0 )
                {
                    maxhealth = minint( maxhealth, damageable_data.healthcap );
                }
            }
            else
            {
                maxhealth = damageable_data.health;
            }
        }
    }
    
    return maxhealth;
}

// Namespace metabone
// Params 5
// Checksum 0xbac95f3c, Offset: 0x1038
// Size: 0x14f
function destroy_metabone( metabone_name, eattacker, einflictor, vdir, objweapon )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( metabone_info.health > 0 )
    {
        metabone_info.health = 0;
    }
    
    metabone_info.is_active = 0;
    
    if ( isai( self ) )
    {
        self._blackboard.var_3a0516652d1efb68 = metabone_name;
    }
    
    params = spawnstruct();
    params.metabone_name = metabone_name;
    params.eattacker = eattacker;
    params.einflictor = einflictor;
    params.vdir = vdir;
    params.objweapon = objweapon;
    callback::callback( "metabone_destroyed", params );
    function_94fdab7a61434c30( self.metabones.on_destroyed, metabone_info.var_7c0af65ae40e856d, params );
}

// Namespace metabone
// Params 2
// Checksum 0x2acd1c8, Offset: 0x118f
// Size: 0x28f
function function_ddf2fd7b79c9d5b5( hit_loc, direction )
{
    if ( !( isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( !self.metabones.info[ metabone.name ].is_active )
            {
                continue;
            }
            
            if ( is_destroyed( metabone ) )
            {
                continue;
            }
            
            if ( !isdefined( metabone.hitlocations ) )
            {
                continue;
            }
            
            foreach ( metabone_hit_loc in metabone.hitlocations )
            {
                if ( metabone_hit_loc.hitlocation == hit_loc )
                {
                    if ( isdefined( metabone_hit_loc.cosmaxangle ) && isdefined( direction ) )
                    {
                        root_forward = metabone_hit_loc.invertangle ? anglestoforward( self.angles ) * -1 : anglestoforward( self.angles );
                        hit_dot = vectordot( root_forward, vectornormalize( direction ) * -1 );
                        
                        if ( hit_dot < metabone_hit_loc.cosmaxangle )
                        {
                            continue;
                        }
                    }
                    
                    return metabone.name;
                }
            }
        }
    }
}

// Namespace metabone
// Params 2
// Checksum 0xe2088a2a, Offset: 0x1427
// Size: 0x23f
function function_927e17286f4e0a54( part_name, direction )
{
    if ( !( isdefined( part_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( !self.metabones.info[ metabone.name ].is_active )
            {
                continue;
            }
            
            if ( is_destroyed( metabone ) )
            {
                continue;
            }
            
            if ( !( isdefined( metabone.parts ) && isdefined( metabone.partmap ) ) )
            {
                continue;
            }
            
            partindex = metabone.partmap[ part_name ];
            
            if ( isdefined( partindex ) )
            {
                metabone_part = metabone.parts[ partindex ];
                
                if ( isdefined( metabone_part.cosmaxangle ) && isdefined( direction ) )
                {
                    bone_forward = anglestoforward( self gettagangles( metabone_part.partname ) );
                    hit_dot = vectordot( bone_forward, vectornormalize( direction ) * -1 );
                    
                    if ( hit_dot < metabone_part.cosmaxangle )
                    {
                        continue;
                    }
                }
                
                return metabone.name;
            }
        }
    }
}

// Namespace metabone
// Params 2
// Checksum 0x1e70a16, Offset: 0x166f
// Size: 0x338
function function_2d9c443204521c97( point, direction )
{
    if ( !( isdefined( point ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_8ef2fd5f0121ed80", 0 ) > 0 )
        {
            sphere( point, 5, ( 1, 0, 0 ) );
            print3d( point, "<dev string:xd1>", ( 1, 0, 0 ), 0.5 );
        }
    #/
    
    closest_metabone = undefined;
    closest_metabone_dist_sq = 0;
    
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( !self.metabones.info[ metabone.name ].is_active )
            {
                continue;
            }
            
            if ( is_destroyed( metabone ) )
            {
                continue;
            }
            
            if ( !isdefined( metabone.tags ) )
            {
                continue;
            }
            
            foreach ( tag in metabone.tags )
            {
                tag_origin = self gettagorigin( tag.tagname );
                tag_radius_sq = squared( tag.radius ?? 1 );
                dist_sq = distancesquared( point, tag_origin );
                
                if ( dist_sq <= tag_radius_sq && ( !isdefined( closest_metabone ) || dist_sq < closest_metabone_dist_sq ) )
                {
                    if ( isdefined( tag.cosmaxangle ) && isdefined( direction ) )
                    {
                        tag_forward = anglestoforward( self gettagangles( tag.tagname ) );
                        tag_dot = vectordot( tag_forward, vectornormalize( direction ) * -1 );
                        
                        if ( tag_dot < tag.cosmaxangle )
                        {
                            continue;
                        }
                    }
                    
                    closest_metabone = metabone;
                    closest_metabone_dist_sq = dist_sq;
                }
            }
        }
    }
    
    if ( isdefined( closest_metabone ) )
    {
        return closest_metabone.name;
    }
}

// Namespace metabone
// Params 4
// Checksum 0xdfa8d4c7, Offset: 0x19b0
// Size: 0x51b
function get_metabone_name( hit_loc, part_name, point, direction )
{
    if ( !( isdefined( hit_loc ) && isdefined( point ) ) || !( isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( !self.metabones.info[ metabone.name ].is_active )
            {
                continue;
            }
            
            if ( is_destroyed( metabone ) )
            {
                continue;
            }
            
            if ( isdefined( metabone.hitlocations ) )
            {
                foreach ( metabone_hit_loc in metabone.hitlocations )
                {
                    if ( metabone_hit_loc.hitlocation == hit_loc )
                    {
                        if ( isdefined( metabone_hit_loc.cosmaxangle ) && isdefined( direction ) )
                        {
                            root_forward = metabone_hit_loc.invertangle ? anglestoforward( self.angles ) * -1 : anglestoforward( self.angles );
                            hit_dot = vectordot( root_forward, vectornormalize( direction ) * -1 );
                            
                            if ( hit_dot < metabone_hit_loc.cosmaxangle )
                            {
                                continue;
                            }
                        }
                        
                        return metabone.name;
                    }
                }
            }
            
            if ( isdefined( part_name ) && isdefined( metabone.parts ) && isdefined( metabone.partmap ) )
            {
                partindex = metabone.partmap[ part_name ];
                
                if ( isdefined( partindex ) )
                {
                    metabone_part = metabone.parts[ partindex ];
                    
                    if ( isdefined( metabone_part.cosmaxangle ) && isdefined( direction ) )
                    {
                        bone_forward = anglestoforward( self gettagangles( metabone_part.partname ) );
                        hit_dot = vectordot( bone_forward, vectornormalize( direction ) * -1 );
                        
                        if ( hit_dot < metabone_part.cosmaxangle )
                        {
                            continue;
                        }
                    }
                    
                    return metabone.name;
                }
            }
            
            if ( isdefined( metabone.tags ) )
            {
                closest_metabone = undefined;
                closest_metabone_dist_sq = 99999999;
                
                foreach ( tag in metabone.tags )
                {
                    tag_origin = self gettagorigin( tag.tagname );
                    dist_sq = distancesquared( point, tag_origin );
                    
                    if ( !isdefined( closest_metabone ) || dist_sq < closest_metabone_dist_sq )
                    {
                        tag_radius = tag.radius ?? 1;
                        penetration_dist = tag.penetrationdist;
                        
                        if ( isdefined( penetration_dist ) && isdefined( direction ) )
                        {
                            if ( !math::segmentvssphere( point, point + direction * penetration_dist, tag_origin, tag_radius ) )
                            {
                                continue;
                            }
                        }
                        else if ( dist_sq > squared( tag_radius ) )
                        {
                            continue;
                        }
                        
                        if ( isdefined( tag.cosmaxangle ) && isdefined( direction ) )
                        {
                            tag_forward = anglestoforward( self gettagangles( tag.tagname ) );
                            tag_dot = vectordot( tag_forward, vectornormalize( direction ) * -1 );
                            
                            if ( tag_dot < tag.cosmaxangle )
                            {
                                continue;
                            }
                        }
                        
                        closest_metabone = metabone;
                        closest_metabone_dist_sq = dist_sq;
                    }
                }
                
                if ( isdefined( closest_metabone ) )
                {
                    return closest_metabone.name;
                }
            }
        }
    }
}

// Namespace metabone
// Params 2
// Checksum 0x120c2e5e, Offset: 0x1ed4
// Size: 0x64
function function_cd947f1a3391c065( var_fb56e56d94279338, on_metabone_destroyed )
{
    if ( !isdefined( level.metabones_on_destroyed ) )
    {
        level.metabones_on_destroyed = [];
    }
    
    if ( !isdefined( level.metabones_on_destroyed[ var_fb56e56d94279338 ] ) )
    {
        level.metabones_on_destroyed[ var_fb56e56d94279338 ] = [];
    }
    
    level.metabones_on_destroyed[ var_fb56e56d94279338 ][ level.metabones_on_destroyed[ var_fb56e56d94279338 ].size ] = on_metabone_destroyed;
}

// Namespace metabone
// Params 2
// Checksum 0x74d33dec, Offset: 0x1f40
// Size: 0x4f
function function_1024597ed2932aba( var_fb56e56d94279338, on_metabone_destroyed )
{
    if ( level.metabones_on_destroyed && level.metabones_on_destroyed[ var_fb56e56d94279338 ] )
    {
        level.metabones_on_destroyed[ var_fb56e56d94279338 ] = arrayremove( level.metabones_on_destroyed[ var_fb56e56d94279338 ], on_metabone_destroyed );
    }
}

// Namespace metabone
// Params 2
// Checksum 0x33e775fa, Offset: 0x1f97
// Size: 0x64
function function_7b57cab1f2311c7b( var_fb56e56d94279338, on_metabone_damaged_not_destroyed )
{
    if ( !isdefined( level.var_9b860665f87348c8 ) )
    {
        level.var_9b860665f87348c8 = [];
    }
    
    if ( !isdefined( level.var_9b860665f87348c8[ var_fb56e56d94279338 ] ) )
    {
        level.var_9b860665f87348c8[ var_fb56e56d94279338 ] = [];
    }
    
    level.var_9b860665f87348c8[ var_fb56e56d94279338 ][ level.var_9b860665f87348c8[ var_fb56e56d94279338 ].size ] = on_metabone_damaged_not_destroyed;
}

// Namespace metabone
// Params 2
// Checksum 0xa71e35b4, Offset: 0x2003
// Size: 0x4f
function function_18cd355aaa8fb938( var_fb56e56d94279338, on_metabone_damaged_not_destroyed )
{
    if ( level.var_9b860665f87348c8 && level.var_9b860665f87348c8[ var_fb56e56d94279338 ] )
    {
        level.var_9b860665f87348c8[ var_fb56e56d94279338 ] = arrayremove( level.var_9b860665f87348c8[ var_fb56e56d94279338 ], on_metabone_damaged_not_destroyed );
    }
}

// Namespace metabone
// Params 2
// Checksum 0x302f6084, Offset: 0x205a
// Size: 0x64
function function_30ef852f36e88719( var_fb56e56d94279338, var_b878ed90950ee1ff )
{
    if ( !isdefined( level.var_295f9550d2db3dd0 ) )
    {
        level.var_295f9550d2db3dd0 = [];
    }
    
    if ( !isdefined( level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ] ) )
    {
        level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ] = [];
    }
    
    level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ][ level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ].size ] = var_b878ed90950ee1ff;
}

// Namespace metabone
// Params 2
// Checksum 0xdb21aa84, Offset: 0x20c6
// Size: 0x4f
function function_60d37180ceef09d4( var_fb56e56d94279338, var_b878ed90950ee1ff )
{
    if ( level.var_295f9550d2db3dd0 && level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ] )
    {
        level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ] = arrayremove( level.var_295f9550d2db3dd0[ var_fb56e56d94279338 ], var_b878ed90950ee1ff );
    }
}

// Namespace metabone
// Params 1
// Checksum 0x154847ca, Offset: 0x211d
// Size: 0x17
function function_b68bd9932f284448( var_682bceb3c14d0d51 )
{
    self.var_682bceb3c14d0d51 = var_682bceb3c14d0d51;
}

// Namespace metabone
// Params 1
// Checksum 0x4ba659b5, Offset: 0x213c
// Size: 0x27
function function_b7f4a00525689bee( dmgstruct )
{
    if ( isdefined( self.var_682bceb3c14d0d51 ) )
    {
        return [[ self.var_682bceb3c14d0d51 ]]( dmgstruct );
    }
}

// Namespace metabone
// Params 0
// Checksum 0xc545d39, Offset: 0x216b
// Size: 0xc, Type: bool
function function_83525a0b05843168()
{
    return isdefined( self.var_682bceb3c14d0d51 );
}

// Namespace metabone
// Params 1
// Checksum 0x81fc8659, Offset: 0x2180
// Size: 0x17
function function_23dfe92664fb40fd( var_af316a1ce17a9c8a )
{
    self.var_af316a1ce17a9c8a = var_af316a1ce17a9c8a;
}

// Namespace metabone
// Params 1
// Checksum 0x1fed1c57, Offset: 0x219f
// Size: 0x27
function function_d985a5fbf5939161( dmgstruct )
{
    if ( isdefined( self.var_af316a1ce17a9c8a ) )
    {
        return [[ self.var_af316a1ce17a9c8a ]]( dmgstruct );
    }
}

// Namespace metabone
// Params 0
// Checksum 0x85237bef, Offset: 0x21ce
// Size: 0xc, Type: bool
function function_3866ce438fcee825()
{
    return isdefined( self.var_af316a1ce17a9c8a );
}

// Namespace metabone
// Params 1
// Checksum 0x4482d0a1, Offset: 0x21e3
// Size: 0x339
function function_8a959a3ac510c2d0( params )
{
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( metabone.states.size > 0 )
            {
                metabone_info = self.metabones.info[ metabone.name ];
                
                foreach ( state_index, state in metabone.states )
                {
                    damageable_data = get_metadata_from_state( state, "Types_Damageable" );
                    
                    if ( isdefined( damageable_data ) )
                    {
                        if ( !damageable_data.absolutehealth )
                        {
                            assert( isdefined( self.maxhealth ), "<dev string:x55>" + self getentitynumber() + "<dev string:xe0>" + metabone.name + "<dev string:x87>" + bundle_name + "<dev string:x108>" );
                            var_9ff900e47a6acddc = damageable_data.health;
                            
                            if ( isdefined( self.metabones.stored_maxhealth ) && isdefined( damageable_data.health ) )
                            {
                                var_9ff900e47a6acddc = int( damageable_data.health * self.metabones.stored_maxhealth );
                                
                                if ( damageable_data.healthcap > 0 )
                                {
                                    var_9ff900e47a6acddc = minint( var_9ff900e47a6acddc, damageable_data.healthcap );
                                }
                            }
                            
                            if ( state_index == metabone_info.current_state_index && isdefined( metabone_info.health ) )
                            {
                                var_cf4e5bdc673857ce = metabone_info.health / var_9ff900e47a6acddc;
                                metabone_info.health = damageable_data.health * self.maxhealth * var_cf4e5bdc673857ce;
                                continue;
                            }
                            
                            var_cf4e5bdc673857ce = metabone_info.var_9001c14ad8db7425[ state_index ] / var_9ff900e47a6acddc;
                            metabone_info.var_9001c14ad8db7425[ state_index ] = damageable_data.health * self.maxhealth * var_cf4e5bdc673857ce;
                        }
                    }
                }
            }
        }
    }
}

// Namespace metabone
// Params 1
// Checksum 0x13ba6abb, Offset: 0x2524
// Size: 0xf6, Type: bool
function is_metabone_armor( metabone_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return false;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( !( isdefined( metabone_info ) && isdefined( metabone_info.current_state_index ) ) )
    {
        return false;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    state = metabone.states[ metabone_info.current_state_index ];
    armor_data = get_metadata_from_state( state, "Types_Armor" );
    return isdefined( armor_data );
}

// Namespace metabone
// Params 1
// Checksum 0xf32dd1a4, Offset: 0x2623
// Size: 0xec
function get_metabone_state_name( metabone_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( !( isdefined( metabone_info ) && isdefined( metabone_info.current_state_index ) ) )
    {
        return;
    }
    
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    state = metabone.states[ metabone_info.current_state_index ];
    
    if ( isdefined( state ) )
    {
        return state.name;
    }
}

// Namespace metabone
// Params 1
// Checksum 0x2520dadf, Offset: 0x2717
// Size: 0x1ab
function function_30d906ccb9fe2142( data_type )
{
    if ( !( isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return [];
    }
    
    active_metabones = [];
    
    foreach ( bundle_name in self.metabones.bundle_names )
    {
        metabones_def = get_metabones_def( bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            metabone_info = self.metabones.info[ metabone.name ];
            
            if ( !metabone_info.is_active )
            {
                continue;
            }
            
            if ( isdefined( data_type ) )
            {
                metadata = function_a4f4ee60be8ebe7b( metabone, data_type );
                
                if ( !isdefined( metadata ) )
                {
                    continue;
                }
            }
            
            active_metabones[ active_metabones.size ] = metabone.name;
        }
    }
    
    return active_metabones;
}

// Namespace metabone
// Params 1
// Checksum 0xe6f06633, Offset: 0x28cb
// Size: 0x66
function is_active( metabone_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return 0;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    return metabone_info.is_active;
}

// Namespace metabone
// Params 4, eflags: 0x4
// Checksum 0x75a67ee2, Offset: 0x293a
// Size: 0x1e9
function private function_c635b0dc08baefad( metabone_name, relative_add, health, state_name )
{
    if ( !( isdefined( metabone_name ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone_name ];
    
    if ( !isdefined( metabone_info ) )
    {
        assertmsg( "<dev string:x13d>" + metabone_name );
        return;
    }
    
    if ( isdefined( state_name ) )
    {
        metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
        target_metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
        target_state = target_metabone.var_63e19fb21594d5a2[ state_name ];
        target_state_index = target_state.index;
        
        if ( target_state_index != metabone_info.current_state_index )
        {
            /#
                damageable_data = get_metadata_from_state( target_state, "<dev string:x16e>" );
                assert( isdefined( damageable_data ) );
                assert( isdefined( metabone_info.var_9001c14ad8db7425[ target_state_index ] ) );
            #/
            
            if ( relative_add )
            {
                metabone_info.var_9001c14ad8db7425[ target_state_index ] += health;
            }
            else
            {
                metabone_info.var_9001c14ad8db7425[ target_state_index ] = health;
            }
            
            return metabone_info.var_9001c14ad8db7425[ target_state_index ];
        }
    }
    
    if ( isdefined( metabone_info.health ) )
    {
        if ( relative_add )
        {
            metabone_info.health += health;
        }
        else
        {
            metabone_info.health = health;
        }
    }
    
    return metabone_info.health;
}

// Namespace metabone
// Params 1, eflags: 0x4
// Checksum 0xc6821e8d, Offset: 0x2b2c
// Size: 0x71, Type: bool
function private is_destroyed( metabone )
{
    if ( !( isdefined( metabone ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return false;
    }
    
    metabone_info = self.metabones.info[ metabone.name ];
    return metabone_info.health <= 0;
}

// Namespace metabone
// Params 2, eflags: 0x4
// Checksum 0xcc1d3912, Offset: 0x2ba6
// Size: 0x132
function private function_a4f4ee60be8ebe7b( metabone, data_type )
{
    if ( !( isdefined( metabone ) && isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    metabone_info = self.metabones.info[ metabone.name ];
    
    if ( isdefined( metabone_info.current_state_index ) )
    {
        data = get_metadata_from_state( metabone.states[ metabone_info.current_state_index ], data_type );
        
        if ( isdefined( data ) )
        {
            return data;
        }
    }
    
    foreach ( data in metabone.metadata )
    {
        if ( data.variant_type == data_type )
        {
            return data.variant_object;
        }
    }
}

// Namespace metabone
// Params 2, eflags: 0x4
// Checksum 0xbd2e4645, Offset: 0x2ce1
// Size: 0xa4
function private get_metadata_from_state( metabone_state, data_type )
{
    foreach ( data in metabone_state.metadata )
    {
        if ( data.variant_type == data_type )
        {
            return data.variant_object;
        }
    }
}

// Namespace metabone
// Params 1
// Checksum 0x4689e5e0, Offset: 0x2d8e
// Size: 0x60
function get_metabones_def( metabones_bundle_name )
{
    metabones_def = undefined;
    
    if ( isdefined( level.metabones_defs ) )
    {
        metabones_def = level.metabones_defs[ metabones_bundle_name ];
    }
    
    if ( !isdefined( metabones_def ) )
    {
        metabones_def = load_metabones_def( metabones_bundle_name );
        level.metabones_defs[ metabones_bundle_name ] = metabones_def;
    }
    
    assert( isdefined( metabones_def ) );
    return metabones_def;
}

// Namespace metabone
// Params 1, eflags: 0x4
// Checksum 0x30642aa2, Offset: 0x2df7
// Size: 0x192
function private load_metabones_def( metabones_bundle_name )
{
    metabones_def = getscriptbundle( "metabonelist:" + metabones_bundle_name );
    metabones_def.var_2972332beaa5b174 = [];
    
    for ( metabone_index = 0; metabone_index < metabones_def.metabones.size ; metabone_index++ )
    {
        metabone = metabones_def.metabones[ metabone_index ];
        
        if ( !isdefined( metabone.name ) || metabone.name == "" )
        {
            metabone.name = string( metabone_index );
        }
        
        if ( isdefined( metabones_def.var_2972332beaa5b174[ metabone.name ] ) )
        {
            assertmsg( "<dev string:x17f>" + metabones_bundle_name + "<dev string:x188>" + metabone.name + "<dev string:x1ad>" );
            metabone.name = string( metabone_index );
        }
        
        metabones_def.var_2972332beaa5b174[ metabone.name ] = metabone;
        metabone.var_63e19fb21594d5a2 = [];
        
        for ( state_index = 0; state_index < metabone.states.size ; state_index++ )
        {
            state = metabone.states[ state_index ];
            state.index = state_index;
            
            if ( state.name )
            {
                metabone.var_63e19fb21594d5a2[ state.name ] = state;
            }
        }
    }
    
    return metabones_def;
}

// Namespace metabone
// Params 3, eflags: 0x4
// Checksum 0xd1eb87cd, Offset: 0x2f92
// Size: 0x9f
function private function_94fdab7a61434c30( callback_table, var_7c0af65ae40e856d, params )
{
    if ( isdefined( var_7c0af65ae40e856d ) && isdefined( callback_table[ var_7c0af65ae40e856d ] ) )
    {
        foreach ( fn in callback_table[ var_7c0af65ae40e856d ] )
        {
            self thread [[ fn ]]( params );
        }
    }
}

// Namespace metabone
// Params 1, eflags: 0x4
// Checksum 0x103362c2, Offset: 0x3039
// Size: 0x716
function private build_metabone_info( metabones_bundle_name )
{
    if ( !isdefined( self.metabones ) )
    {
        self.metabones = spawnstruct();
        self.metabones.bundle_names = [];
        self.metabones.info = [];
        self.metabones.stored_maxhealth = self.maxhealth;
        self.metabones.on_destroyed = [];
        self.metabones.var_ea5c19b7aa8fc9ad = [];
        self.metabones.on_set_active = [];
    }
    
    if ( !isdefined( self.metabones.bundle_name ) )
    {
        self.metabones.bundle_name = metabones_bundle_name;
    }
    
    if ( arraycontains( self.metabones.bundle_names, metabones_bundle_name ) )
    {
        return;
    }
    
    self.metabones.bundle_names[ self.metabones.bundle_names.size ] = metabones_bundle_name;
    metabones_def = get_metabones_def( metabones_bundle_name );
    
    foreach ( metabone in metabones_def.metabones )
    {
        assert( !isdefined( self.metabones.info[ metabone.name ] ), "<dev string:x1af>" + metabone.name + "<dev string:x1ca>" + metabones_bundle_name + "<dev string:x1d8>" + self.metabones.info[ metabone.name ].bundle_name + "<dev string:x1ad>" );
        metabone_info = spawnstruct();
        metabone_info.bundle_name = metabones_bundle_name;
        metabone_info.var_7c0af65ae40e856d = metabones_def.var_90ed8916f56ef56d;
        self.metabones.info[ metabone.name ] = metabone_info;
        
        if ( metabone.states.size > 0 )
        {
            metabone_info.current_state_index = 0;
        }
        
        init_metabone_health( metabone );
        
        if ( isdefined( metabone.tags ) )
        {
            foreach ( tag in metabone.tags )
            {
                if ( isdefined( tag.maxangle ) )
                {
                    tag.cosmaxangle = cos( tag.maxangle * 0.5 );
                }
            }
        }
        
        if ( isdefined( metabone.hitlocations ) )
        {
            foreach ( metabone_hit_loc in metabone.hitlocations )
            {
                if ( isdefined( metabone_hit_loc.maxangle ) )
                {
                    metabone_hit_loc.cosmaxangle = cos( metabone_hit_loc.maxangle * 0.5 );
                }
            }
        }
        
        if ( isdefined( metabone.parts ) )
        {
            if ( metabone.parts.size > 0 )
            {
                metabone.partmap = [];
                
                for ( i = 0; i < metabone.parts.size ; i++ )
                {
                    metabone_part = metabone.parts[ i ];
                    metabone.partmap[ metabone_part.partname ] = i;
                    
                    if ( isdefined( metabone_part.maxangle ) )
                    {
                        metabone_part.cosmaxangle = cos( metabone_part.maxangle * 0.5 );
                    }
                }
            }
        }
    }
    
    if ( isdefined( metabones_def.var_90ed8916f56ef56d ) && isdefined( level.metabones_on_destroyed[ metabones_def.var_90ed8916f56ef56d ] ) )
    {
        assert( !isdefined( self.metabones.on_destroyed[ metabones_def.var_90ed8916f56ef56d ] ), "<dev string:x1f7>" + metabones_def.var_90ed8916f56ef56d + "<dev string:x229>" );
        self.metabones.on_destroyed[ metabones_def.var_90ed8916f56ef56d ] = level.metabones_on_destroyed[ metabones_def.var_90ed8916f56ef56d ];
    }
    
    if ( isdefined( metabones_def.var_90ed8916f56ef56d ) && isdefined( level.var_9b860665f87348c8[ metabones_def.var_90ed8916f56ef56d ] ) )
    {
        assert( !isdefined( self.metabones.var_ea5c19b7aa8fc9ad[ metabones_def.var_90ed8916f56ef56d ] ), "<dev string:x250>" + metabones_def.var_90ed8916f56ef56d + "<dev string:x229>" );
        self.metabones.var_ea5c19b7aa8fc9ad[ metabones_def.var_90ed8916f56ef56d ] = level.var_9b860665f87348c8[ metabones_def.var_90ed8916f56ef56d ];
    }
    
    if ( isdefined( metabones_def.var_90ed8916f56ef56d ) && isdefined( level.var_295f9550d2db3dd0[ metabones_def.var_90ed8916f56ef56d ] ) )
    {
        assert( !isdefined( self.metabones.on_set_active[ metabones_def.var_90ed8916f56ef56d ] ), "<dev string:x28e>" + metabones_def.var_90ed8916f56ef56d + "<dev string:x229>" );
        self.metabones.on_set_active[ metabones_def.var_90ed8916f56ef56d ] = level.var_295f9550d2db3dd0[ metabones_def.var_90ed8916f56ef56d ];
    }
    
    foreach ( metabone in metabones_def.metabones )
    {
        set_metabone_active( metabone.name, metabone.activebydefault ?? 0 );
    }
    
    /#
        function_b2541208a1854334( metabones_bundle_name );
    #/
}

// Namespace metabone
// Params 1, eflags: 0x4
// Checksum 0xa3d52506, Offset: 0x3757
// Size: 0x1aa
function private init_metabone_health( metabone )
{
    metabone_info = self.metabones.info[ metabone.name ];
    metabone_info.health = undefined;
    
    if ( !isdefined( metabone_info.var_9001c14ad8db7425 ) )
    {
        metabone_info.var_9001c14ad8db7425 = [];
        
        foreach ( state in metabone.var_63e19fb21594d5a2 )
        {
            damageable_data = get_metadata_from_state( state, "Types_Damageable" );
            
            if ( isdefined( damageable_data ) )
            {
                metabone_info.var_9001c14ad8db7425[ state.index ] = function_159026b8b70ff467( self, damageable_data );
            }
        }
    }
    
    if ( isdefined( metabone_info.var_9001c14ad8db7425[ metabone_info.current_state_index ] ) )
    {
        metabone_info.health = metabone_info.var_9001c14ad8db7425[ metabone_info.current_state_index ];
        return;
    }
    
    var_26517a1aa9262796 = function_a4f4ee60be8ebe7b( metabone, "Types_Damageable" );
    
    if ( isdefined( var_26517a1aa9262796 ) )
    {
        assert( metabone_info.var_9001c14ad8db7425.size <= 0, "<dev string:x2c1>" + metabone.name );
        metabone_info.health = function_159026b8b70ff467( self, var_26517a1aa9262796 );
    }
}

// Namespace metabone
// Params 2, eflags: 0x4
// Checksum 0xb0e5d645, Offset: 0x3909
// Size: 0xa1
function private function_159026b8b70ff467( entity, damageable_data )
{
    if ( damageable_data.absolutehealth )
    {
        return damageable_data.health;
    }
    
    assert( isdefined( entity.maxhealth ), "<dev string:x55>" + entity getentitynumber() + "<dev string:x306>" );
    health = int( damageable_data.health * entity.maxhealth );
    
    if ( damageable_data.healthcap > 0 )
    {
        health = minint( health, damageable_data.healthcap );
    }
    
    return health;
}

// Namespace metabone
// Params 2, eflags: 0x4
// Checksum 0x47ddefc7, Offset: 0x39b3
// Size: 0x22e
function private function_9d446596537a8d42( metabone_name, hit_loc )
{
    metabones_def = get_metabones_def( self.metabones.info[ metabone_name ].bundle_name );
    metabone = metabones_def.var_2972332beaa5b174[ metabone_name ];
    current_state_index = self.metabones.info[ metabone_name ].current_state_index;
    
    if ( isdefined( current_state_index ) && isdefined( metabone.states[ current_state_index ].impactvfx ) )
    {
        currentstate = metabone.states[ current_state_index ];
        
        if ( !isdefined( metabone.vfxid[ currentstate.name ] ) )
        {
            metabone.vfxid[ currentstate.name ] = loadfxasset( currentstate.impactvfx );
        }
        
        var_827a2a5369774085 = metabone.vfxid[ currentstate.name ];
    }
    else if ( isdefined( metabone.impactvfx ) )
    {
        if ( !isdefined( metabone.vfxid[ "metabone" ] ) )
        {
            metabone.vfxid[ "metabone" ] = loadfxasset( metabone.impactvfx );
        }
        
        var_827a2a5369774085 = metabone.vfxid[ "metabone" ];
    }
    else if ( isdefined( metabones_def.var_41120aa0069417d7 ) )
    {
        if ( !isdefined( metabone.vfxid[ "universal" ] ) )
        {
            metabone.vfxid[ "universal" ] = loadfxasset( metabones_def.var_41120aa0069417d7 );
        }
        
        var_827a2a5369774085 = metabone.vfxid[ "universal" ];
    }
    else
    {
        return;
    }
    
    if ( isdefined( metabone.tags ) && metabone.tags.size > 0 )
    {
        playfxontag( var_827a2a5369774085, self, metabone.tags[ 0 ].tagname );
        return;
    }
    
    if ( hit_loc )
    {
        playfx( var_827a2a5369774085, hit_loc );
    }
}

/#

    // Namespace metabone
    // Params 1, eflags: 0x4
    // Checksum 0xc69975e6, Offset: 0x3be9
    // Size: 0x196, Type: dev
    function private function_b2541208a1854334( metabones_bundle_name )
    {
        metabones_def = get_metabones_def( metabones_bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            if ( isdefined( metabone.tags ) && self.metabones.info[ metabone.name ].is_active )
            {
                foreach ( tag in metabone.tags )
                {
                    assert( isdefined( self gettagindex( tag.tagname ) ), "<dev string:x55>" + self getentitynumber() + "<dev string:x5e>" + tag.tagname + "<dev string:x76>" + metabone.name + "<dev string:x87>" + metabones_bundle_name + "<dev string:x8e>" );
                }
            }
        }
    }

    // Namespace metabone
    // Params 0, eflags: 0x4
    // Checksum 0x1836e773, Offset: 0x3d87
    // Size: 0x5f2, Type: dev
    function private debug_metabones()
    {
        if ( level.b_debug_metabones )
        {
            return;
        }
        
        level.b_debug_metabones = 1;
        level endon( #"game_ended" );
        devgui::function_9082edeb5db93280( "<dev string:x352>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x364>", @"debug_metabones" );
        devgui::add_devgui_func( "<dev string:x37e>", "<dev string:x39c>", &function_2d207b2301e14996 );
        devgui::function_77df7fe7dd273e10();
        
        while ( true )
        {
            if ( getdvarint( @"debug_metabones", 0 ) <= 0 )
            {
                waitframe();
                continue;
            }
            
            entity_num = getdvarint( @"debug_metabones_entnum", -1 );
            entity = getentbynum( entity_num );
            
            if ( !isalive( entity ) )
            {
                entity_num = get_facing_entnum();
                entity = getentbynum( entity_num );
            }
            
            if ( isdefined( entity ) && isdefined( entity.metabones ) )
            {
                print_x = 400;
                print_y = 200;
                var_c0120496c3299fb1 = 30;
                printtoscreen2d( print_x, print_y, "<dev string:x3bb>" );
                
                foreach ( bundle_name in entity.metabones.bundle_names )
                {
                    metabones_def = get_metabones_def( bundle_name );
                    
                    foreach ( metabone in metabones_def.metabones )
                    {
                        print_y += 40;
                        metabone_info = entity.metabones.info[ metabone.name ];
                        metabone_color = ( 1, 1, 1 );
                        var_a9485e6a874a730a = metabone.name;
                        
                        if ( !metabone_info.is_active )
                        {
                            var_a9485e6a874a730a += "<dev string:x3c5>";
                            metabone_color = ( 0.6, 0.6, 0.6 );
                        }
                        
                        if ( entity is_destroyed( metabone ) )
                        {
                            var_a9485e6a874a730a += "<dev string:x3d1>";
                            metabone_color = ( 0.7, 0.7, 0.7 );
                        }
                        
                        printtoscreen2d( print_x, print_y, var_a9485e6a874a730a, metabone_color, 1 );
                        state_name = undefined;
                        print_y += 18;
                        
                        if ( isdefined( metabone_info.current_state_index ) )
                        {
                            state = metabone.states[ metabone_info.current_state_index ];
                            state_debug_info = "<dev string:x3de>" + metabone_info.current_state_index;
                            
                            if ( isdefined( state.name ) )
                            {
                                state_name = state.name;
                                state_debug_info = "<dev string:x3e6>" + state.name + "<dev string:x3e8>";
                            }
                            
                            printtoscreen2d( print_x + var_c0120496c3299fb1, print_y, state_debug_info, metabone_color );
                        }
                        
                        print_y += 18;
                        hurt_col = undefined;
                        
                        if ( isdefined( metabone_info.health ) )
                        {
                            max_health = entity get_metabone_maxhealth( metabone.name, state_name );
                            health_percentage = "<dev string:x3ea>";
                            
                            if ( isdefined( max_health ) )
                            {
                                health_percentage = "<dev string:x3eb>" + metabone_info.health / max_health * 100 + "<dev string:x3ee>";
                            }
                            
                            health_col = metabone_color;
                            
                            if ( isdefined( state_name ) && entity.last_dmg_struct.metabonename == metabone.name && gettime() - ( entity.last_dmg_struct.timehit ?? 0 ) < 100 )
                            {
                                hurt_col = ( 0.1, 1, 0.1 );
                                health_col = hurt_col;
                            }
                            
                            printtoscreen2d( print_x + var_c0120496c3299fb1, print_y, "<dev string:x3f1>" + metabone_info.health + health_percentage, health_col );
                        }
                        else
                        {
                            printtoscreen2d( print_x + var_c0120496c3299fb1, print_y, "<dev string:x3fa>", metabone_color );
                        }
                        
                        if ( entity isscriptable() )
                        {
                            if ( entity getscriptablehaspart( metabone.name ) )
                            {
                                scriptable_state = entity getscriptablepartstate( metabone.name, 1 );
                                
                                if ( isdefined( scriptable_state ) )
                                {
                                    print_y += 18;
                                    printtoscreen2d( print_x + var_c0120496c3299fb1, print_y, "<dev string:x406>" + scriptable_state, metabone_color );
                                }
                            }
                        }
                        
                        if ( !entity is_destroyed( metabone ) )
                        {
                            if ( isdefined( metabone.tags ) )
                            {
                                foreach ( tag in metabone.tags )
                                {
                                    tagorigin = entity gettagorigin( tag.tagname, 1 );
                                    
                                    if ( isdefined( tagorigin ) )
                                    {
                                        tag_color = hurt_col ?? ( metabone_info.is_active ? ( 0.2, 0.2, 1 ) : ( 0.7, 0.1, 0.1 ) );
                                        sphere( tagorigin, tag.radius, tag_color, 1 );
                                        print3d( tagorigin, metabone.name, tag_color, 1, 0.25 );
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace metabone
    // Params 1, eflags: 0x4
    // Checksum 0xd8c0f0c9, Offset: 0x4381
    // Size: 0x23, Type: dev
    function private function_2d207b2301e14996( params )
    {
        setdvar( @"debug_metabones_entnum", get_facing_entnum() );
    }

    // Namespace metabone
    // Params 0, eflags: 0x4
    // Checksum 0x2ffc16cf, Offset: 0x43ac
    // Size: 0x57, Type: dev
    function private get_facing_entnum()
    {
        look_pos = devgui::function_97024c0a6d1256a6();
        
        if ( isdefined( look_pos ) )
        {
            nearby_ai = getaiarrayinradius( look_pos, 512 );
            
            if ( isdefined( nearby_ai ) )
            {
                entity = function_47c86977a18df38b( nearby_ai, look_pos );
                
                if ( isdefined( entity ) )
                {
                    return entity getentitynumber();
                }
            }
        }
        
        return -1;
    }

#/
