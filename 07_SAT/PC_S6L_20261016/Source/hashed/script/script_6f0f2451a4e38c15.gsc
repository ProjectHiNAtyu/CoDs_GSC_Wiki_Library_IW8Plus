// script_6f0f2451a4e38c15  (hash_6f0f2451a4e38c15.gscc) (size: 10957 Bytes / 0x2acd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35e74ccf (904350927)
// size ...... 10957 (0x2acd)
// includes .. 7   (offset: 0x2939)
// strings ... 23  (offset: 0x2971)
// dev strs .. 0   (offset: 0x2acd)
// exports ... 22  (offset: 0x1eb9)
// cseg ...... 0x241 + 0x1c78 (0x1eb9)
// imports ... 54  (offset: 0x2229)
// animtree1 . 0   (offset: 0x2acd)
// animtree2 . 0   (offset: 0x2acd)
#using scripts\common\callbacks;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\pickups_scriptable;

#namespace namespace_44f3cc5922e3a432;

// Namespace namespace_44f3cc5922e3a432
// Params 0, eflags: 0x4
// Checksum 0xe8b012e2, Offset: 0x25f
// Size: 0x10c
function private init()
{
    if ( !isdefined( level.var_87cea907baa23af3 ) )
    {
        level.var_87cea907baa23af3 = {};
    }
    
    if ( !isdefined( level.var_87cea907baa23af3.var_ea2d0505143913fa ) )
    {
        level.var_87cea907baa23af3.var_ea2d0505143913fa = [];
    }
    
    if ( !isdefined( level.var_87cea907baa23af3.var_a7cc9a6af28db7bb ) )
    {
        level.var_87cea907baa23af3.var_a7cc9a6af28db7bb = [];
    }
    
    level.var_87cea907baa23af3.var_b4952d784a370e6e = getdvarint( @"hash_def7ed82b9925c7", 1 );
    level callback::add( #"player_item_pickup", &function_7abef16cb7d2bfe6, level.var_87cea907baa23af3.var_a7cc9a6af28db7bb );
    level callback::add( #"player_item_drop", &function_1ffd0d9c5b0f26ac, level.var_87cea907baa23af3.var_a7cc9a6af28db7bb );
    level callback::add( #"hash_6be17d27fe58c7b1", &function_7effb3f0fcd4fce6, level.var_87cea907baa23af3.var_a7cc9a6af28db7bb );
}

// Namespace namespace_44f3cc5922e3a432
// Params 4
// Checksum 0xe81e9736, Offset: 0x373
// Size: 0x233
function function_39c5432728e178d7( activity_instance, var_1e5c8d5c74335501, image_name, optional_params = spawnstruct() )
{
    if ( !isdefined( optional_params.var_1c669d7332ae2d99 ) )
    {
        optional_params.var_1c669d7332ae2d99 = "icon_medium";
    }
    
    if ( !isdefined( optional_params.most_wanted_visual ) )
    {
        optional_params.most_wanted_visual = 0;
    }
    
    if ( !isdefined( optional_params.most_wanted_delay ) )
    {
        optional_params.most_wanted_delay = 1;
    }
    
    if ( !isdefined( optional_params.var_4fced433ba939d58 ) )
    {
        optional_params.var_4fced433ba939d58 = undefined;
    }
    
    if ( !isdefined( optional_params.var_48321f15e7322335 ) )
    {
        optional_params.var_48321f15e7322335 = undefined;
    }
    
    if ( !level.var_87cea907baa23af3 )
    {
        init();
    }
    
    if ( !arraycontains( level.var_87cea907baa23af3.var_ea2d0505143913fa, var_1e5c8d5c74335501 ) )
    {
        level.var_87cea907baa23af3.var_ea2d0505143913fa[ level.var_87cea907baa23af3.var_ea2d0505143913fa.size ] = var_1e5c8d5c74335501;
    }
    else
    {
        return;
    }
    
    if ( !isdefined( activity_instance.markers ) )
    {
        activity_instance.markers = [];
    }
    
    if ( !isdefined( activity_instance.markers[ var_1e5c8d5c74335501 ] ) )
    {
        activity_instance.markers[ var_1e5c8d5c74335501 ] = optional_params;
    }
    
    activity_instance.markers[ var_1e5c8d5c74335501 ].image_name = image_name;
    
    if ( !level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ] )
    {
        level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ] = activity_instance;
    }
    
    foreach ( player in activity_instance.playerparticipants )
    {
        function_151ac7767e230a26( player );
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1, eflags: 0x4
// Checksum 0x6e6fee72, Offset: 0x5ae
// Size: 0x108
function private function_151ac7767e230a26( player )
{
    foreach ( item in level.var_87cea907baa23af3.var_ea2d0505143913fa )
    {
        item_type = common_item::function_3cba34a99d02cd9( item );
        current_player_item = player common_item::function_c4c43ebb7aa636dc( item_type );
        
        if ( current_player_item.name && current_player_item.name == item )
        {
            params = { #player:player, #itembundlename:item };
            function_7abef16cb7d2bfe6( params, level.var_87cea907baa23af3.var_a7cc9a6af28db7bb );
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x4a6e50ab, Offset: 0x6be
// Size: 0xea
function private function_7effb3f0fcd4fce6( params, activity_instance_array )
{
    if ( !arraycontains( level.var_87cea907baa23af3.var_ea2d0505143913fa, params.itembundlename ) )
    {
        return;
    }
    
    foreach ( activity_instance in activity_instance_array )
    {
        if ( activity_instance.markers[ params.itembundlename ] )
        {
            marker_ref = activity_instance.markers[ params.itembundlename ];
            activity_instance function_77c5b8a4499a4958( marker_ref );
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x300fb313, Offset: 0x7b0
// Size: 0x10a
function private function_7abef16cb7d2bfe6( params, activity_instance_array )
{
    if ( !arraycontains( level.var_87cea907baa23af3.var_ea2d0505143913fa, params.itembundlename ) )
    {
        return;
    }
    
    foreach ( activity_instance in activity_instance_array )
    {
        if ( activity_instance.markers[ params.itembundlename ] )
        {
            marker_ref = activity_instance.markers[ params.itembundlename ];
            function_3c0ae9888d84e95b( marker_ref );
            activity_instance function_d991d65f155a905f( params.player, marker_ref, params.itembundlename );
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0xf9147a28, Offset: 0x8c2
// Size: 0x154
function private function_1ffd0d9c5b0f26ac( params, activity_instance_array )
{
    if ( !arraycontains( level.var_87cea907baa23af3.var_ea2d0505143913fa, params.itembundlename ) )
    {
        return;
    }
    
    if ( !isdefined( params.item ) )
    {
        return;
    }
    
    if ( level.var_87cea907baa23af3.var_b4952d784a370e6e )
    {
        var_26dae14f0efb1862 = function_bb9ca1293ab9ff57( params.item, params.itembundlename );
        
        if ( var_26dae14f0efb1862 )
        {
            params.item = var_26dae14f0efb1862;
        }
    }
    
    foreach ( activity_instance in activity_instance_array )
    {
        if ( activity_instance.markers[ params.itembundlename ] )
        {
            marker_ref = activity_instance.markers[ params.itembundlename ];
            activity_instance function_77c5b8a4499a4958( marker_ref );
            function_eea4d842da79ad12( params, marker_ref );
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 3
// Checksum 0xe4fabeb1, Offset: 0xa1e
// Size: 0xf7
function on_player_leave( player, spawned_item, removed_item_name )
{
    activity_instance_array = level.var_87cea907baa23af3.var_a7cc9a6af28db7bb;
    
    foreach ( activity_instance in activity_instance_array )
    {
        if ( activity_instance.markers[ removed_item_name ] )
        {
            marker_ref = activity_instance.markers[ removed_item_name ];
            activity_instance function_77c5b8a4499a4958( marker_ref );
            function_eea4d842da79ad12( { #item:spawned_item, #itembundlename:removed_item_name }, marker_ref );
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x4325ad4c, Offset: 0xb1d
// Size: 0x133
function private function_bb9ca1293ab9ff57( item, item_bundle )
{
    if ( outofbounds::ispointinoutofbounds( item.origin ) )
    {
        waitframe();
        
        if ( !item )
        {
            return;
        }
        
        new_origin = getclosestpointonnavmesh( item.origin );
        map_center = level.br_level.br_mapcenter ?? ( 0, 0, 0 );
        direction = vectornormalize( map_center - new_origin );
        push_distance = getdvarint( @"hash_ec25468772cfdd0e", 36 );
        new_origin = getclosestpointonnavmesh( new_origin + direction * push_distance );
        ground_offset = getdvarint( @"hash_6616b12ed778fb40", 16 );
        spawn_offset = ( 0, 0, ground_offset );
        spawn_origin = new_origin + spawn_offset;
        spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin );
        var_26dae14f0efb1862 = common_item::function_61c2c0251e742ffd( item_bundle, 1, spawn_options );
        var_26dae14f0efb1862 setscriptablepartstate( var_26dae14f0efb1862.type, "visible" );
        item pickups::deletescriptableinstance( 1 );
        return var_26dae14f0efb1862;
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 3, eflags: 0x4
// Checksum 0x43f36642, Offset: 0xc59
// Size: 0x303
function private function_d991d65f155a905f( player, marker_ref, marker_type )
{
    function_77c5b8a4499a4958( marker_ref );
    
    if ( player.team == marker_ref.var_48321f15e7322335 )
    {
        return;
    }
    
    if ( marker_ref.var_4fced433ba939d58 )
    {
        var_8a93bc29df6baddb = [[ marker_ref.var_4fced433ba939d58 ]]( self );
        
        if ( !isarray( var_8a93bc29df6baddb ) )
        {
            var_8a93bc29df6baddb = [ var_8a93bc29df6baddb ];
        }
    }
    
    if ( marker_ref.most_wanted_visual )
    {
        function_4313b12b8cc4e546( marker_ref, player, var_8a93bc29df6baddb );
    }
    
    carrier_obj_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_add_objective( carrier_obj_id, "current", player.origin, marker_ref.image_name, marker_ref.var_1c669d7332ae2d99 );
    objidpoolmanager::update_objective_onentity( carrier_obj_id, player );
    function_38b84cb3d4357dd7( carrier_obj_id );
    marker_ref.carrier_obj_id = carrier_obj_id;
    marker_ref.carrier_entity = player;
    br_activity_util::activitylog( self, "Creating carrier marker " + marker_ref.carrier_obj_id + " for " + marker_ref.image_name );
    
    if ( var_8a93bc29df6baddb )
    {
        marker_ref.var_b59f4c875568c65 = [];
        
        foreach ( var_1614048d7cfc8dca in var_8a93bc29df6baddb )
        {
            players = teams::getfriendlyplayers( var_1614048d7cfc8dca );
            
            foreach ( player in players )
            {
                objective_addclienttomask( carrier_obj_id, player );
            }
            
            marker_ref.var_b59f4c875568c65[ marker_ref.var_b59f4c875568c65.size ] = var_1614048d7cfc8dca;
        }
        
        objective_showtoplayersinmask( carrier_obj_id );
        return;
    }
    
    if ( !marker_ref.most_wanted_visual )
    {
        function_fd9ed552c76d6299( carrier_obj_id );
        
        if ( !isdefined( marker_ref.var_b59f4c875568c65 ) )
        {
            marker_ref.var_b59f4c875568c65 = [];
        }
        
        foreach ( team in level.teamswithplayers )
        {
            marker_ref.var_b59f4c875568c65[ marker_ref.var_b59f4c875568c65.size ] = team;
        }
    }
    
    objective_showtoplayersinmask( carrier_obj_id );
}

// Namespace namespace_44f3cc5922e3a432
// Params 3, eflags: 0x4
// Checksum 0x40a2b61c, Offset: 0xf64
// Size: 0x2ac
function private function_4313b12b8cc4e546( marker_ref, marked_player, var_6bd1bb82d9c1510e = undefined )
{
    marker_ref.most_wanted_obj_id = objidpoolmanager::requestobjectiveid();
    
    if ( marker_ref.most_wanted_obj_id == -1 )
    {
        marker_ref.most_wanted_obj_id = undefined;
        return;
    }
    
    br_activity_util::activitylog( self, "Creating most wanted marker " + marker_ref.most_wanted_obj_id + " for " + marker_ref.image_name );
    objidpoolmanager::objective_add_objective( marker_ref.most_wanted_obj_id, "active", marked_player.origin, marker_ref.image_name, marker_ref.var_1c669d7332ae2d99 );
    objidpoolmanager::objective_set_play_intro( marker_ref.most_wanted_obj_id, 1 );
    objective_disableping( marker_ref.most_wanted_obj_id, 1 );
    function_fd9ed552c76d6299( marker_ref.most_wanted_obj_id );
    
    foreach ( player in teams::getfriendlyplayers( marked_player.team ) )
    {
        objective_removeclientfrommask( marker_ref.most_wanted_obj_id, player );
    }
    
    marker_ref.var_d853fb78ef3dc0fd = [ marked_player.team ];
    
    if ( var_6bd1bb82d9c1510e )
    {
        foreach ( hide_team in var_6bd1bb82d9c1510e )
        {
            foreach ( player in teams::getfriendlyplayers( hide_team ) )
            {
                objective_removeclientfrommask( marker_ref.most_wanted_obj_id, player );
            }
            
            marker_ref.var_d853fb78ef3dc0fd[ marker_ref.var_d853fb78ef3dc0fd.size ] = hide_team;
        }
    }
    
    objective_showtoplayersinmask( marker_ref.most_wanted_obj_id );
    thread function_be26bfa1425e1d65( marker_ref, marked_player );
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x603fde25, Offset: 0x1218
// Size: 0x79
function private function_be26bfa1425e1d65( marker_ref, player )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player endon( #"death_or_disconnect" );
    self endon( marker_ref.image_name );
    
    while ( true )
    {
        objidpoolmanager::update_objective_position( marker_ref.most_wanted_obj_id, player.origin );
        wait marker_ref.most_wanted_delay;
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1, eflags: 0x4
// Checksum 0x5acbb29c, Offset: 0x1299
// Size: 0x71
function private function_8f50e54c69239d99( marker_ref )
{
    if ( isdefined( marker_ref.most_wanted_obj_id ) )
    {
        br_activity_util::activitylog( self, "Destroying most wanted marker " + marker_ref.most_wanted_obj_id + " for " + marker_ref.image_name );
        objidpoolmanager::returnobjectiveid( marker_ref.most_wanted_obj_id );
        marker_ref.most_wanted_obj_id = undefined;
        self notify( marker_ref.image_name );
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1, eflags: 0x4
// Checksum 0x94ae0a3e, Offset: 0x1312
// Size: 0x77
function private function_77c5b8a4499a4958( marker_ref )
{
    if ( isdefined( marker_ref.carrier_obj_id ) )
    {
        br_activity_util::activitylog( self, "Destroying carrier marker " + marker_ref.carrier_obj_id + " for " + marker_ref.image_name );
        objidpoolmanager::returnobjectiveid( marker_ref.carrier_obj_id );
        marker_ref.carrier_obj_id = undefined;
        marker_ref.carrier_entity = undefined;
    }
    
    function_8f50e54c69239d99( marker_ref );
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x6fc84cf3, Offset: 0x1391
// Size: 0x85
function private function_eea4d842da79ad12( params, marker_ref )
{
    function_3c0ae9888d84e95b( marker_ref );
    
    if ( params.item getscriptablehaspart( "objective" ) )
    {
        params.item setscriptablepartstate( "objective", "active" );
    }
    else
    {
        marker_ref.ground_obj_id = objidpoolmanager::requestobjectiveid();
        thread function_a397b89531018247( params, marker_ref );
    }
    
    marker_ref.item = params.item;
}

// Namespace namespace_44f3cc5922e3a432
// Params 2, eflags: 0x4
// Checksum 0x49681fab, Offset: 0x141e
// Size: 0x1a1
function private function_a397b89531018247( params, marker_ref )
{
    var_30f37d57a23dc69f = params.item;
    
    for ( prev_origin = var_30f37d57a23dc69f.origin; var_30f37d57a23dc69f ; prev_origin = var_30f37d57a23dc69f.origin )
    {
        wait 0.1;
        
        if ( var_30f37d57a23dc69f.linkedparent || distancesquared( var_30f37d57a23dc69f.origin, prev_origin ) < 1 )
        {
            break;
        }
    }
    
    if ( !var_30f37d57a23dc69f || !marker_ref )
    {
        return;
    }
    
    objidpoolmanager::objective_add_objective( marker_ref.ground_obj_id, "current", marker_ref.ground_anchor.origin, marker_ref.image_name, marker_ref.var_1c669d7332ae2d99 );
    br_activity_util::activitylog( self, "Creating ground marker " + marker_ref.ground_obj_id + " for " + marker_ref.image_name );
    
    if ( var_30f37d57a23dc69f.linkedparent )
    {
        wait 0.5;
        marker_ref.ground_anchor = spawn( "script_model", var_30f37d57a23dc69f.origin );
        marker_ref.ground_anchor setmodel( "tag_origin" );
        marker_ref.ground_anchor linkto( var_30f37d57a23dc69f.linkedparent );
        objidpoolmanager::update_objective_onentity( marker_ref.ground_obj_id, marker_ref.ground_anchor );
    }
    
    function_fd9ed552c76d6299( marker_ref.ground_obj_id );
    objective_showtoplayersinmask( marker_ref.ground_obj_id );
}

// Namespace namespace_44f3cc5922e3a432
// Params 1, eflags: 0x4
// Checksum 0xa5464652, Offset: 0x15c7
// Size: 0x9a
function private function_3c0ae9888d84e95b( marker_ref )
{
    marker_ref.item = undefined;
    
    if ( !isdefined( marker_ref.ground_obj_id ) )
    {
        return;
    }
    
    br_activity_util::activitylog( self, "Destroying ground marker " + marker_ref.ground_obj_id + " for " + marker_ref.image_name );
    objidpoolmanager::returnobjectiveid( marker_ref.ground_obj_id );
    marker_ref.ground_obj_id = undefined;
    
    if ( isdefined( marker_ref.ground_anchor ) )
    {
        marker_ref.ground_anchor delete();
        marker_ref.ground_anchor = undefined;
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1
// Checksum 0x36c82da5, Offset: 0x1669
// Size: 0x340
function function_c5b6e44b42ff4493( player )
{
    foreach ( activity_instance in level.var_87cea907baa23af3.var_a7cc9a6af28db7bb )
    {
        foreach ( marker_ref in activity_instance.markers )
        {
            if ( marker_ref.carrier_obj_id )
            {
                foreach ( team in marker_ref.var_b59f4c875568c65 )
                {
                    if ( team == player.team )
                    {
                        br_activity_util::activitylog( activity_instance, "Showing carrier marker " + marker_ref.carrier_obj_id + " for " + marker_ref.image_name + " to " + player.name );
                        objective_addclienttomask( marker_ref.carrier_obj_id, player );
                        break;
                    }
                }
                
                objective_showtoplayersinmask( marker_ref.carrier_obj_id );
            }
            
            if ( marker_ref.ground_obj_id )
            {
                br_activity_util::activitylog( activity_instance, "Showing ground marker " + marker_ref.ground_obj_id + " for " + marker_ref.image_name + " to " + player.name );
                objective_addclienttomask( marker_ref.ground_obj_id, player );
                objective_showtoplayersinmask( marker_ref.ground_obj_id );
            }
            
            if ( marker_ref.most_wanted_obj_id )
            {
                foreach ( team in marker_ref.var_d853fb78ef3dc0fd )
                {
                    if ( team == player.team )
                    {
                        br_activity_util::activitylog( activity_instance, "Showing most wanted marker " + marker_ref.most_wanted_obj_id + " for " + marker_ref.image_name + " to " + player.name );
                        objective_removeclientfrommask( marker_ref.most_wanted_obj_id, player );
                        break;
                    }
                }
                
                objective_showtoplayersinmask( marker_ref.most_wanted_obj_id );
            }
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1
// Checksum 0x48c3b93f, Offset: 0x19b1
// Size: 0x240
function function_d89c3e886fc93c4d( player )
{
    foreach ( activity_instance in level.var_87cea907baa23af3.var_a7cc9a6af28db7bb )
    {
        foreach ( marker_ref in activity_instance.markers )
        {
            if ( marker_ref.carrier_obj_id )
            {
                br_activity_util::activitylog( activity_instance, "Hiding carrier marker " + marker_ref.carrier_obj_id + " for " + marker_ref.image_name + " from " + player.name );
                objective_removeclientfrommask( marker_ref.carrier_obj_id, player );
                objective_showtoplayersinmask( marker_ref.carrier_obj_id );
            }
            
            if ( marker_ref.ground_obj_id )
            {
                br_activity_util::activitylog( activity_instance, "Hiding ground marker " + marker_ref.ground_obj_id + " for " + marker_ref.image_name + " from " + player.name );
                objective_removeclientfrommask( marker_ref.ground_obj_id, player );
                objective_showtoplayersinmask( marker_ref.ground_obj_id );
            }
            
            if ( marker_ref.most_wanted_obj_id )
            {
                br_activity_util::activitylog( activity_instance, "Hiding most wanted marker " + marker_ref.most_wanted_obj_id + " for " + marker_ref.image_name + " from " + player.name );
                objective_addclienttomask( marker_ref.most_wanted_obj_id, player );
                objective_showtoplayersinmask( marker_ref.most_wanted_obj_id );
            }
        }
    }
}

// Namespace namespace_44f3cc5922e3a432
// Params 1, eflags: 0x4
// Checksum 0xa3009bfa, Offset: 0x1bf9
// Size: 0x4b
function private function_d50c78c62154a258( activity_instance )
{
    markers = level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ].markers;
    return getarraykeys( markers ?? [] );
}

// Namespace namespace_44f3cc5922e3a432
// Params 1
// Checksum 0x6b30217b, Offset: 0x1c4d
// Size: 0x17a
function cleanup_all_markers( activity_instance )
{
    markers_array = activity_instance.markers;
    br_activity_util::activitylog( activity_instance, "Cleaning up all markers" );
    
    foreach ( marker in markers_array )
    {
        objidpoolmanager::returnobjectiveid( marker.carrier_obj_id );
        objidpoolmanager::returnobjectiveid( marker.ground_obj_id );
        objidpoolmanager::returnobjectiveid( marker.most_wanted_obj_id );
        marker.carrier_obj_id = undefined;
        marker.ground_obj_id = undefined;
        marker.most_wanted_obj_id = undefined;
        
        if ( isdefined( marker.ground_anchor ) )
        {
            marker.ground_anchor delete();
            marker.ground_anchor = undefined;
        }
    }
    
    items_tracked = function_d50c78c62154a258( activity_instance );
    level.var_87cea907baa23af3.var_ea2d0505143913fa = function_a5c1175d3ea3c25a( level.var_87cea907baa23af3.var_ea2d0505143913fa, items_tracked );
    markers_array = undefined;
    level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ] = undefined;
}

// Namespace namespace_44f3cc5922e3a432
// Params 2
// Checksum 0xc7324b0d, Offset: 0x1dcf
// Size: 0xe9
function get_marker_position( activity_instance, item_bundle_name )
{
    if ( !activity_instance.id || !item_bundle_name || !level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ] )
    {
        return;
    }
    
    markers = level.var_87cea907baa23af3.var_a7cc9a6af28db7bb[ activity_instance.id ].markers;
    
    if ( !markers )
    {
        return;
    }
    
    marker = markers[ item_bundle_name ];
    
    if ( !marker )
    {
        return;
    }
    
    if ( marker.carrier_entity )
    {
        return marker.carrier_entity.origin;
    }
    
    if ( marker.item )
    {
        return marker.item.origin;
    }
}

