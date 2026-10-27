// scripts\mp\ob\activities\ob_activity_composite_utils.gsc  (hash_7775f591698cd091.gscc) (size: 2799 Bytes / 0xaef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba5f9db7 (3126828471)
// size ...... 2799 (0xaef)
// includes .. 6   (offset: 0xa63)
// strings ... 6   (offset: 0xa93)
// dev strs .. 1   (offset: 0xae3)
// exports ... 9   (offset: 0x6ef)
// cseg ...... 0xe3 + 0x60c (0x6ef)
// imports ... 18  (offset: 0x857)
// animtree1 . 0   (offset: 0xaef)
// animtree2 . 0   (offset: 0xaef)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_composite_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_composite_utils;

// Namespace ob_activity_composite_utils
// Params 2
// Checksum 0xb170c46, Offset: 0x101
// Size: 0x68
function function_934ca6cc64ad906d( var_f4e58cbc33d81889, var_93df4aee5edf0c1a )
{
    if ( is_child_activity() )
    {
        if ( isdefined( var_f4e58cbc33d81889 ) )
        {
            self [[ var_f4e58cbc33d81889 ]]();
        }
        
        msg = utility::waittill_any_return( "child_activity_begin", "child_activity_destroy" );
        
        if ( msg == "child_activity_destroy" )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
        
        if ( isdefined( var_93df4aee5edf0c1a ) )
        {
            self [[ var_93df4aee5edf0c1a ]]();
        }
    }
}

// Namespace ob_activity_composite_utils
// Params 0
// Checksum 0xa2511326, Offset: 0x171
// Size: 0x21, Type: bool
function is_child_activity()
{
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    return istrue( additional_spawn_data.var_d9274cd4b9b9a361 );
}

// Namespace ob_activity_composite_utils
// Params 0
// Checksum 0x192fae13, Offset: 0x19b
// Size: 0x2f
function get_parent_activity()
{
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additional_spawn_data.var_d9274cd4b9b9a361 )
    {
        return additional_spawn_data.var_71b6ce0e281f4b60;
    }
}

// Namespace ob_activity_composite_utils
// Params 0
// Checksum 0x6a26b603, Offset: 0x1d3
// Size: 0x52
function function_36bad4a225ab3edb()
{
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additional_spawn_data.var_d9274cd4b9b9a361 && isdefined( additional_spawn_data.var_71b6ce0e281f4b60 ) )
    {
        additional_spawn_data.var_71b6ce0e281f4b60 notify( #"child_activity_complete", self );
        return 1;
    }
    
    return 0;
}

// Namespace ob_activity_composite_utils
// Params 2
// Checksum 0x2309b023, Offset: 0x22d
// Size: 0x59
function setup_child_activity( variant_type, variant_tag )
{
    additional_spawn_data = {};
    additional_spawn_data.var_d9274cd4b9b9a361 = 1;
    additional_spawn_data.var_71b6ce0e281f4b60 = self;
    spawned_activity_instance = ob_activity_utility::function_fe0fd74238abb635( variant_type, variant_tag, "Activity", additional_spawn_data );
    return spawned_activity_instance;
}

// Namespace ob_activity_composite_utils
// Params 2
// Checksum 0x5aec0a32, Offset: 0x28f
// Size: 0x1c2
function setup_child_activities( var_e1ab0566e9474723, var_2d7b15030571af13 )
{
    self.var_7db5dfc0d5050e0c = [];
    self.child_activities = [];
    
    foreach ( activity_type in var_e1ab0566e9474723 )
    {
        activity_instance_candidate = function_666f5b886278ebe5( "Activity", activity_type, self.location, var_2d7b15030571af13, function_ae358577b00b433c( activity_type ) );
        
        if ( isdefined( activity_instance_candidate ) )
        {
            self.var_7db5dfc0d5050e0c[ self.var_7db5dfc0d5050e0c.size ] = activity_instance_candidate;
            continue;
        }
        
        break;
    }
    
    if ( var_e1ab0566e9474723.size == self.var_7db5dfc0d5050e0c.size )
    {
        foreach ( var_2de910df9a8625b7 in self.var_7db5dfc0d5050e0c )
        {
            additional_spawn_data = {};
            additional_spawn_data.var_d9274cd4b9b9a361 = 1;
            additional_spawn_data.var_71b6ce0e281f4b60 = self;
            spawned_activity_instance = ob_activity_manager::ob_activity_instance_init( var_2de910df9a8625b7, additional_spawn_data );
            self.child_activities[ self.child_activities.size ] = spawned_activity_instance;
        }
        
        var_bdec03daa0a56efb = 1;
    }
    else
    {
        var_bdec03daa0a56efb = 0;
    }
    
    return var_bdec03daa0a56efb;
}

// Namespace ob_activity_composite_utils
// Params 6
// Checksum 0x2e17f315, Offset: 0x45a
// Size: 0x255
function function_666f5b886278ebe5( activity_class, activity_type, origin, radius, ignore_overlapping, var_d7e8f77e3135ce72 )
{
    best_candidate = undefined;
    best_distance_sqr = radius * radius;
    
    if ( !( isdefined( activity_class ) && isdefined( activity_type ) ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return best_candidate;
    }
    
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    foreach ( region in regions )
    {
        if ( isdefined( level.var_e607236b193eb0c1.activityinstances[ activity_class ][ region.index ][ activity_type ] ) )
        {
            foreach ( activity_instance in level.var_e607236b193eb0c1.activityinstances[ activity_class ][ region.index ][ activity_type ] )
            {
                if ( self.var_7db5dfc0d5050e0c && arraycontains( self.var_7db5dfc0d5050e0c, activity_instance ) )
                {
                    continue;
                }
                
                if ( !ob_activity_manager::function_b5bdbf846da577f( activity_instance, [] ) )
                {
                    continue;
                }
                
                if ( !ob_activity_manager::function_10db83bfddb33fbf( activity_instance, [] ) )
                {
                    continue;
                }
                
                if ( !var_d7e8f77e3135ce72 && !ob_activity_manager::function_714537ed7c463c8c( activity_instance, [] ) )
                {
                    continue;
                }
                
                if ( !ignore_overlapping && !ob_activity_manager::function_7a5d6f5dbb63bffd( activity_instance, [] ) )
                {
                    continue;
                }
                
                var_ea54c0ab42a167ca = activity_instance.centerpoint ?? activity_instance_common::function_776ee11e7acc64a5( activity_instance );
                dist_sqr = distancesquared( origin, var_ea54c0ab42a167ca );
                
                if ( dist_sqr < best_distance_sqr || best_distance_sqr == 0 )
                {
                    best_distance_sqr = dist_sqr;
                    best_candidate = activity_instance;
                }
            }
        }
    }
    
    return best_candidate;
}

// Namespace ob_activity_composite_utils
// Params 1, eflags: 0x4
// Checksum 0xbe37b2e4, Offset: 0x6b8
// Size: 0x37
function private function_ae358577b00b433c( activity_type )
{
    if ( activity_type == "REV_OB_DESTROY_SUPPLIES" || activity_type == "REV_OB_HELI_TAKEDOWN" || activity_type == "REV_OB_MERC_STRONGHOLD" )
    {
        return 1;
    }
    
    return 0;
}

