// scripts\mp\content_manager.gsc  (hash_7bef99a2b184bfd5.gscc) (size: 17199 Bytes / 0x432f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcad9f434 (3403281460)
// size ...... 17199 (0x432f)
// includes .. 5   (offset: 0x3fef)
// strings ... 16  (offset: 0x4017)
// dev strs .. 40  (offset: 0x4107)
// exports ... 50  (offset: 0x2e43)
// cseg ...... 0x147 + 0x2cfc (0x2e43)
// imports ... 73  (offset: 0x3613)
// animtree1 . 0   (offset: 0x432f)
// animtree2 . 0   (offset: 0x432f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\anim_scene;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;

#namespace content_manager;

// Namespace content_manager
// Params 2
// Checksum 0xda4872ef, Offset: 0x165
// Size: 0x38
function get_content_struct( instance, string )
{
    if ( isdefined( instance.var_1d6cddfc47031bff[ string ] ) )
    {
        return instance.var_1d6cddfc47031bff[ string ][ 0 ];
    }
}

// Namespace content_manager
// Params 2
// Checksum 0xcfb5679d, Offset: 0x1a5
// Size: 0x46
function get_content_struct_array( instance, string )
{
    var_d32e1acb2f90af0d = [];
    
    if ( isdefined( instance.var_1d6cddfc47031bff[ string ] ) )
    {
        var_d32e1acb2f90af0d = instance.var_1d6cddfc47031bff[ string ];
    }
    
    return var_d32e1acb2f90af0d;
}

// Namespace content_manager
// Params 0
// Checksum 0x3d857983, Offset: 0x1f4
// Size: 0x7f
function init_content_manager()
{
    utility::flag_init( "content_manager_initialized" );
    level.contentmanager = spawnstruct();
    level.contentmanager.var_5841e60f2d6d5c6e = [];
    level.contentmanager.var_91abe25e1e364d85 = [];
    function_432dba895790878d();
    function_cbd841ae87b7a198();
    level.contentmanager.spawnedinstances = [];
    utility::flag_set( "content_manager_initialized" );
    
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager
// Params 0
// Checksum 0x28cc352f, Offset: 0x27b
// Size: 0x2a
function refresh_content_manager()
{
    if ( !isdefined( level.contentmanager ) )
    {
        return;
    }
    
    function_432dba895790878d();
    function_cbd841ae87b7a198();
    
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager
// Params 3
// Checksum 0xd33d368e, Offset: 0x2ad
// Size: 0xd5
function function_3209da123476142f( scriptname, spawncallback, var_a5ec6e62bd08ef66 )
{
    assert( isstring( scriptname ) );
    assert( isdefined( spawncallback ) );
    assert( !isdefined( level.contentmanager.var_5841e60f2d6d5c6e[ scriptname ] ), scriptname + "<dev string:x24>" );
    script = spawnstruct();
    script.scriptname = scriptname;
    script.spawncallback = spawncallback;
    level.contentmanager.var_5841e60f2d6d5c6e[ scriptname ] = script;
    
    if ( var_a5ec6e62bd08ef66 )
    {
        level.contentmanager.worldeventscripts[ level.contentmanager.worldeventscripts.size ] = scriptname;
    }
    
    return script;
}

// Namespace content_manager
// Params 1
// Checksum 0xa5da010e, Offset: 0x38b
// Size: 0x30
function function_a81c3464c25252b8( scriptname )
{
    assert( isstring( scriptname ) );
    return level.contentmanager.var_5841e60f2d6d5c6e[ scriptname ];
}

// Namespace content_manager
// Params 2
// Checksum 0x89edd3e4, Offset: 0x3c4
// Size: 0x134
function function_1814a4dc926961b3( key, value )
{
    assert( isstring( key ) );
    
    if ( !isdefined( value ) )
    {
        return [];
    }
    
    var_5c0fde56f721c8a = utility::getstructarray( value, key );
    reg_scripts = [];
    
    foreach ( script in var_5c0fde56f721c8a )
    {
        foreach ( reg_script in level.contentmanager.var_5841e60f2d6d5c6e )
        {
            reg_scripts[ reg_scripts.size ] = reg_script;
        }
    }
    
    return reg_scripts;
}

// Namespace content_manager
// Params 0
// Checksum 0xc2843e07, Offset: 0x501
// Size: 0x23d
function function_432dba895790878d()
{
    level.contentmanager.destinations = [];
    
    if ( !isdefined( level.struct_class_names[ "variantname" ] ) )
    {
        return;
    }
    
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in var_959dbddcfff2592d )
    {
        assert( isdefined( destination.targetname ), "<dev string:x59>" + destination.origin + "<dev string:x71>" );
        assert( !isdefined( level.contentmanager.destinations[ destination.targetname ] ), "<dev string:x84>" + destination.targetname + "<dev string:xb7>" + destination.origin );
        level.contentmanager.destinations[ destination.targetname ] = destination;
        function_f59cf287160fcb8d( destination );
        destination.locations = [];
        children = function_fc95ac07a2a4f888( destination );
        
        foreach ( child in children )
        {
            if ( child.variantname != "content_location" )
            {
                continue;
            }
            
            assert( isdefined( child.targetname ) );
            assert( !isdefined( destination.locations[ child.targetname ] ) );
            destination.locations[ child.targetname ] = child;
        }
    }
}

// Namespace content_manager
// Params 2
// Checksum 0x42f785a3, Offset: 0x746
// Size: 0xfc
function function_3935a3fd0adf5f02( var_93e4a0a8514ca47e, var_9cf074dd4b2c2a54 )
{
    assert( isdefined( level.contentmanager.destinations[ var_93e4a0a8514ca47e ] ), "<dev string:xbc>" + var_93e4a0a8514ca47e );
    i = 0;
    
    foreach ( var_f7d7051998dbe2fb in var_9cf074dd4b2c2a54 )
    {
        var_a8ce772a5c02e1ac = utility::getstruct( var_f7d7051998dbe2fb );
        assert( isdefined( var_a8ce772a5c02e1ac ), "<dev string:xe8>" + var_f7d7051998dbe2fb );
        level.contentmanager.destinations[ var_93e4a0a8514ca47e ].var_118001bf5551f778[ i ] = var_a8ce772a5c02e1ac;
        i++;
    }
}

// Namespace content_manager
// Params 1
// Checksum 0x7d5bd18a, Offset: 0x84a
// Size: 0x62
function function_b886adf00bf95e03( location )
{
    assert( isstruct( location ) );
    assert( location.variantname == "<dev string:x11e>" );
    var_a237c72121d73007 = isarray( location.spawnedinstances ) && location.spawnedinstances.size > 0;
    return var_a237c72121d73007;
}

// Namespace content_manager
// Params 0
// Checksum 0x6bfab24, Offset: 0x8b5
// Size: 0x327
function function_cbd841ae87b7a198()
{
    level.contentmanager.locations = [];
    
    if ( !isdefined( level.struct_class_names[ "variantname" ] ) )
    {
        return;
    }
    
    var_23b1277313e18ab8 = utility::getstructarray( "content_location", "variantname" );
    
    foreach ( location in var_23b1277313e18ab8 )
    {
        assert( isdefined( location.targetname ) );
        assert( !isdefined( level.contentmanager.locations[ location.targetname ] ) );
        level.contentmanager.locations[ location.targetname ] = location;
        
        if ( isdefined( location.target ) )
        {
            parent = utility::getstruct( location.target, "targetname" );
            
            if ( isdefined( parent ) && parent.variantname == "content_destination" )
            {
                location.destination = parent;
            }
        }
        
        function_f59cf287160fcb8d( location );
        location.instances = [];
        children = function_fc95ac07a2a4f888( location );
        
        foreach ( child in children )
        {
            if ( child.variantname != "content_instance" )
            {
                continue;
            }
            
            assert( isdefined( child.content_script_name ) );
            
            if ( !isdefined( location.instances[ child.content_script_name ] ) )
            {
                location.instances[ child.content_script_name ] = spawnstruct();
                location.instances[ child.content_script_name ].versions = [];
            }
            
            if ( !isdefined( location.instances[ child.content_script_name ].versions ) )
            {
                location.instances[ child.content_script_name ].versions = [];
            }
            
            location.instances[ child.content_script_name ].versions = arraycombineunique( location.instances[ child.content_script_name ].versions, [ child ] );
            function_f59cf287160fcb8d( child );
            child.location = location;
        }
    }
}

// Namespace content_manager
// Params 1
// Checksum 0xe9ade887, Offset: 0xbe4
// Size: 0xbe
function function_67e4b7678fb21e11( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == "<dev string:x12f>" );
    assert( isstring( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    function_f59cf287160fcb8d( instance );
    script = level.contentmanager.var_5841e60f2d6d5c6e[ instance.content_script_name ];
    
    if ( isdefined( script.spawncallback ) )
    {
        level thread [[ script.spawncallback ]]( instance );
    }
    
    function_1219ea2618e9fa16( instance );
}

// Namespace content_manager
// Params 1
// Checksum 0xf38468f3, Offset: 0xcaa
// Size: 0x73, Type: bool
function can_spawn_instance( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == "<dev string:x12f>" );
    assert( isstring( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    return !function_b886adf00bf95e03( instance.location );
}

// Namespace content_manager
// Params 1
// Checksum 0x6f91eb7, Offset: 0xd26
// Size: 0xe6
function function_1219ea2618e9fa16( instance )
{
    assert( isarray( level.contentmanager.spawnedinstances ) );
    
    if ( !isdefined( instance.location.spawnedinstances ) )
    {
        instance.location.spawnedinstances = [];
    }
    
    instance.location.spawnedinstances[ instance.location.spawnedinstances.size ] = instance;
    spawnedinstances = level.contentmanager.spawnedinstances;
    
    if ( !isdefined( spawnedinstances[ instance.content_script_name ] ) )
    {
        spawnedinstances[ instance.content_script_name ] = [];
    }
    
    spawnedinstances[ instance.content_script_name ][ spawnedinstances[ instance.content_script_name ].size ] = instance;
}

// Namespace content_manager
// Params 4
// Checksum 0xd948600c, Offset: 0xe14
// Size: 0x96
function function_d88a4895de88fa18( struct, scriptable_name, usecallback, offset )
{
    assert( isstruct( struct ) );
    assert( isdefined( usecallback ) );
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    interact = spawnscriptable( scriptable_name, struct.origin + offset, struct.angles );
    interaction::register_scriptable_interact( interact, usecallback );
    interact function_5afb033891222160( 1 );
    return interact;
}

// Namespace content_manager
// Params 1
// Checksum 0x596c09dd, Offset: 0xeb3
// Size: 0x37
function function_5afb033891222160( b_show )
{
    state_name = "visible";
    
    if ( !b_show )
    {
        state_name = "hidden";
    }
    
    self setscriptablepartstate( "content_interact", state_name );
}

// Namespace content_manager
// Params 0
// Checksum 0xce7c0359, Offset: 0xef2
// Size: 0x12
function function_a4d10caa77ad3731()
{
    self setscriptablepartstate( "content_interact", "inactive" );
}

// Namespace content_manager
// Params 6
// Checksum 0x19caae, Offset: 0xf0c
// Size: 0x5b
function function_f9400f6877b2471c( interact, part, state, player, auto_use, var_fda8287cd15b107f )
{
    if ( !isdefined( interact.content_use_callback ) )
    {
        return;
    }
    
    interact thread [[ interact.content_use_callback ]]( player );
}

// Namespace content_manager
// Params 4
// Checksum 0xdc057a06, Offset: 0xf6f
// Size: 0xba
function spawn_script_models( var_1eb048ce41430987, modelname, cutnavmesh, pingable )
{
    models = [];
    
    foreach ( struct in var_1eb048ce41430987 )
    {
        model = spawn_script_model( struct, modelname, cutnavmesh, pingable );
        models[ models.size ] = model;
    }
    
    return models;
}

// Namespace content_manager
// Params 5
// Checksum 0x203189a1, Offset: 0x1032
// Size: 0x1dd
function spawn_script_model( struct, modelname, cutnavmesh = 0, pingable = 1, var_a9a6bf31642152ae = struct.origin )
{
    model = spawn( "script_model", var_a9a6bf31642152ae );
    model.angles = struct.angles ?? ( 0, 0, 0 );
    model setmodel( modelname );
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_string ) )
    {
        model.script_string = struct.script_string;
    }
    
    if ( cutnavmesh )
    {
        model disconnectpaths();
    }
    
    if ( pingable )
    {
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( parent.variantname == "content_instance" && isdefined( parent.a ) )
        {
            if ( !arraycontains( parent.a.models, model ) )
            {
                parent.a.models[ parent.a.models.size ] = model;
            }
            
            break;
        }
        
        if ( !isdefined( parent.target ) )
        {
            break;
        }
        
        parent = utility::getstruct( parent.target, "targetname" );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
        
        waitframe();
    }
    
    return model;
}

// Namespace content_manager
// Params 3
// Checksum 0x98262ae1, Offset: 0x1218
// Size: 0xf6
function function_3a0e12fd88261897( struct, var_dba9b1b356ee3877, var_c1f1759494742238 )
{
    var_145aee08d72b1663 = spawn( var_dba9b1b356ee3877, struct.origin );
    var_145aee08d72b1663.angles = struct.angles;
    
    if ( var_c1f1759494742238 )
    {
        var_145aee08d72b1663 disconnectpaths();
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( parent.variantname == "content_instance" )
        {
            if ( !arraycontains( parent.a.models, var_145aee08d72b1663 ) )
            {
                parent.a.models[ parent.a.models.size ] = var_145aee08d72b1663;
            }
            
            break;
        }
        
        parent = utility::getstruct( parent.target );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
    }
    
    return var_145aee08d72b1663;
}

// Namespace content_manager
// Params 0
// Checksum 0xede40e18, Offset: 0x1317
// Size: 0x2fe
function cleanup_spawned_instances()
{
    level notify( #"cleanup_spawned_instances" );
    var_1e1701bb28b09d81 = 10;
    var_845accacf0907a2b = 0;
    
    foreach ( group in level.contentmanager.spawnedinstances )
    {
        foreach ( instance in group )
        {
            if ( isdefined( instance.var_2a345ab3ef50328c ) )
            {
                foreach ( model in instance.var_2a345ab3ef50328c )
                {
                    if ( isdefined( model ) )
                    {
                        if ( isdefined( model.trigger ) )
                        {
                            model.trigger delete();
                        }
                        
                        if ( isdefined( model.var_fd90d65c2aa7a71b ) )
                        {
                            if ( isdefined( level.var_140ebb69272df9d ) )
                            {
                                [[ level.var_140ebb69272df9d ]]( model.var_fd90d65c2aa7a71b );
                            }
                            else
                            {
                                objective_delete( model.var_fd90d65c2aa7a71b );
                            }
                        }
                        
                        if ( isdefined( model.objectiveid ) )
                        {
                            if ( isdefined( level.var_140ebb69272df9d ) )
                            {
                                [[ level.var_140ebb69272df9d ]]( model.objectiveid );
                            }
                            else
                            {
                                objective_delete( model.objectiveid );
                            }
                        }
                        
                        model anim_scene::anim_scene_stop();
                        model delete();
                        var_845accacf0907a2b += 1;
                        
                        if ( var_845accacf0907a2b % var_1e1701bb28b09d81 == 0 )
                        {
                            wait 0.05;
                        }
                    }
                }
                
                instance.var_2a345ab3ef50328c = function_5713d46873b29625( instance.var_2a345ab3ef50328c );
            }
            
            group = arrayremove( group, instance );
            instance.location.spawnedinstances = arrayremove( instance.location.spawnedinstances, instance );
        }
        
        group = function_5713d46873b29625( group );
        level.contentmanager.spawnedinstances = arrayremove( level.contentmanager.spawnedinstances, group );
    }
    
    function_5713d46873b29625( level.contentmanager.spawnedinstances );
}

// Namespace content_manager
// Params 1
// Checksum 0x5320db09, Offset: 0x161d
// Size: 0xe6
function function_f59cf287160fcb8d( parent )
{
    children = function_fc95ac07a2a4f888( parent );
    var_1d6cddfc47031bff = function_d2f471191d182375( children );
    parent.var_1d6cddfc47031bff = var_1d6cddfc47031bff;
    
    foreach ( child in children )
    {
        if ( !isdefined( child.content_key ) || child.variantname != "content_struct" )
        {
            continue;
        }
        
        child.parent = parent;
        function_f59cf287160fcb8d( child );
    }
}

// Namespace content_manager
// Params 1
// Checksum 0x24f50fd9, Offset: 0x170b
// Size: 0xe8
function function_d2f471191d182375( children )
{
    groups = [];
    
    foreach ( child in children )
    {
        if ( !isdefined( child.content_key ) || child.variantname != "content_struct" )
        {
            continue;
        }
        
        if ( !isdefined( groups[ child.content_key ] ) )
        {
            groups[ child.content_key ] = [];
        }
        
        groups[ child.content_key ][ groups[ child.content_key ].size ] = child;
    }
    
    return groups;
}

// Namespace content_manager
// Params 1
// Checksum 0x49056ffb, Offset: 0x17fc
// Size: 0x34
function function_fc95ac07a2a4f888( parent )
{
    if ( !isdefined( parent.targetname ) )
    {
        return [];
    }
    
    return utility::getstructarray( parent.targetname, "target" );
}

// Namespace content_manager
// Params 0
// Checksum 0x71e1feb8, Offset: 0x1839
// Size: 0xad, Type: bool
function function_e0f0562adcd2c071()
{
    var_9349e424962b8eb0 = game_utility::getgametype();
    
    if ( isdefined( self.script_label ) )
    {
        var_9493257b18228d68 = strtok( self.script_label, "," );
        
        if ( arraycontains( var_9493257b18228d68, var_9349e424962b8eb0 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( self.script_gameobjectname ) )
    {
        var_e21b2c9f0b6ac7d2 = strtok( self.script_gameobjectname, "," );
        var_abdc8b523b17027c = strtok( self.script_gameobjectname, " " );
        
        if ( arraycontains( var_e21b2c9f0b6ac7d2, var_9349e424962b8eb0 ) || arraycontains( var_abdc8b523b17027c, var_9349e424962b8eb0 ) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    return true;
}

// Namespace content_manager
// Params 1
// Checksum 0x82c763a7, Offset: 0x18ef
// Size: 0x19b
function get_features_of_type( type )
{
    if ( level.var_1bc31921d079dc44[ type ] )
    {
        features = [];
        
        foreach ( feature in level.var_f301c0b95ea728e2 )
        {
            if ( feature.targetname == type )
            {
                features[ features.size ] = feature;
            }
        }
    }
    else if ( type == "exfil" )
    {
        features = level.s_zm_exfil.var_c7cfc464905e7bcd;
    }
    else
    {
        assert( isdefined( level.contentmanager.spawnedinstances[ type ] ), "<dev string:x140>" + type );
        instances = level.contentmanager.spawnedinstances[ type ];
        assert( instances.size == 1, "<dev string:x168>" + type + "<dev string:x196>" + instances.size );
        instance = instances[ 0 ];
        var_dcd011e2d015ea36 = getarraykeys( instance.var_1d6cddfc47031bff );
        assert( var_dcd011e2d015ea36.size == 1, "<dev string:x19d>" + var_dcd011e2d015ea36.size + "<dev string:x1c8>" + type );
        group_key = var_dcd011e2d015ea36[ 0 ];
        features = get_content_struct_array( instance, group_key );
    }
    
    return features;
}

// Namespace content_manager
// Params 4
// Checksum 0x87177eda, Offset: 0x1a93
// Size: 0xe7
function register_disable_toggle( type, on_filter, on_disable, on_enable )
{
    if ( !isdefined( level.contentmanager.toggle_type ) )
    {
        level.contentmanager.toggle_type = [];
    }
    
    if ( !isdefined( level.contentmanager.disabled_features ) )
    {
        level.contentmanager.disabled_features = [];
    }
    
    level.contentmanager.toggle_type[ type ] = { #on_enable:on_enable, #on_disable:on_disable, #on_filter:on_filter };
    
    if ( !isdefined( level.contentmanager.disabled_features[ type ] ) )
    {
        level.contentmanager.disabled_features[ type ] = [];
    }
}

// Namespace content_manager
// Params 3
// Checksum 0x555e6dab, Offset: 0x1b82
// Size: 0xa5
function function_150b588eee953686( feature_type, filter_func, sparams )
{
    var_6a8c8709962ba839 = filter_features( feature_type, filter_func, sparams );
    
    foreach ( feature in var_6a8c8709962ba839 )
    {
        disable_feature( feature, feature_type );
    }
}

// Namespace content_manager
// Params 3
// Checksum 0xd9f5173f, Offset: 0x1c2f
// Size: 0xa5
function function_d87b461e00238279( feature_type, filter_func, sparams )
{
    var_6a8c8709962ba839 = filter_features( feature_type, filter_func, sparams );
    
    foreach ( feature in var_6a8c8709962ba839 )
    {
        enable_feature( feature, feature_type );
    }
}

// Namespace content_manager
// Params 3
// Checksum 0xe6d3b620, Offset: 0x1cdc
// Size: 0xcd
function function_5d04e50a29a2142c( type, filter_func, sparams )
{
    profilestart();
    a_s_features = get_features_of_type( type );
    var_dcc0e197021a6c67 = [];
    
    foreach ( s_feature in a_s_features )
    {
        if ( isfunction( filter_func ) )
        {
            b_passed_filter = s_feature [[ filter_func ]]( sparams );
            
            if ( b_passed_filter )
            {
                var_dcc0e197021a6c67[ var_dcc0e197021a6c67.size ] = s_feature;
            }
        }
    }
    
    profilestop();
    return var_dcc0e197021a6c67;
}

// Namespace content_manager
// Params 3, eflags: 0x4
// Checksum 0x819904c, Offset: 0x1db3
// Size: 0x54
function private filter_features( type, filter_func, sparams )
{
    profilestart();
    filtered_features = [[ level.contentmanager.toggle_type[ type ].on_filter ]]( type, filter_func, sparams );
    profilestop();
    return filtered_features;
}

// Namespace content_manager
// Params 2
// Checksum 0xe8f73794, Offset: 0x1e11
// Size: 0x88
function disable_features( features, type )
{
    foreach ( feature in features )
    {
        disable_feature( feature, type );
    }
}

// Namespace content_manager
// Params 2
// Checksum 0xe6cdb55, Offset: 0x1ea1
// Size: 0xc4
function disable_feature( feature, type )
{
    profilestart();
    [[ level.contentmanager.toggle_type[ type ].on_disable ]]( feature );
    
    if ( !isdefined( level.contentmanager.disabled_features[ type ] ) )
    {
        level.contentmanager.disabled_features[ type ] = [];
    }
    
    level.contentmanager.disabled_features[ type ][ level.contentmanager.disabled_features[ type ].size ] = feature;
    level callback::callback( #"hash_fb99f4a65a74090", { #feature:feature, #type:type } );
    profilestop();
}

// Namespace content_manager
// Params 2
// Checksum 0xbda656dc, Offset: 0x1f6d
// Size: 0x88
function enable_features( features, type )
{
    foreach ( feature in features )
    {
        enable_feature( feature, type );
    }
}

// Namespace content_manager
// Params 2
// Checksum 0xcab586fc, Offset: 0x1ffd
// Size: 0xed
function enable_feature( feature, type )
{
    profilestart();
    [[ level.contentmanager.toggle_type[ type ].on_enable ]]( feature );
    assert( arraycontains( level.contentmanager.disabled_features[ type ], feature ), "<dev string:x1d4>" + type + "<dev string:x205>" + ( feature.origin ?? "<dev string:x214>" ) + "<dev string:x21e>" );
    level.contentmanager.disabled_features[ type ] = arrayremove( level.contentmanager.disabled_features[ type ], feature );
    level callback::callback( #"content_manager_feature_enabled", { #feature:feature, #type:type } );
    feature notify( #"content_manager_feature_enabled" );
    profilestop();
}

/#

    // Namespace content_manager
    // Params 0
    // Checksum 0xee1e6fe5, Offset: 0x20f2
    // Size: 0x46b, Type: dev
    function init_devgui()
    {
        level notify( #"hash_fa0f3347400aa8b7" );
        level endon( #"hash_fa0f3347400aa8b7" );
        wait 0.05;
        adddebugcommand( "<dev string:x2be>" + "<dev string:x2c8>" + "<dev string:x2e3>" );
        path = function_c97c1fa76d5f85fe( "<dev string:x2ea>", 0 );
        function_6d6d111f5149df24( function_c97c1fa76d5f85fe( "<dev string:x2ea>", 0 ), "<dev string:x2fc>" + "<dev string:x2c8>" + "<dev string:x304>" );
        
        foreach ( destination in level.contentmanager.destinations )
        {
            foreach ( location in destination.locations )
            {
                foreach ( var_60b0c6fa501215be in location.instances )
                {
                    foreach ( instance in var_60b0c6fa501215be.versions )
                    {
                        instancekey = location.targetname + "<dev string:x309>" + instance.content_script_name;
                        path = function_c97c1fa76d5f85fe( "<dev string:x30b>", 1, destination.targetname + "<dev string:x318>" + location.targetname + "<dev string:x318>" + instance.content_script_name );
                        function_6d6d111f5149df24( path, "<dev string:x31a>" + "<dev string:x31f>" + instancekey );
                    }
                }
            }
        }
        
        foreach ( location in level.contentmanager.locations )
        {
            foreach ( var_60b0c6fa501215be in location.instances )
            {
                foreach ( instance in var_60b0c6fa501215be.versions )
                {
                    instancekey = location.targetname + "<dev string:x309>" + instance.content_script_name;
                    path = function_c97c1fa76d5f85fe( "<dev string:x33d>", 2, location.targetname + "<dev string:x318>" + instance.content_script_name );
                    function_6d6d111f5149df24( path, "<dev string:x31a>" + "<dev string:x31f>" + instancekey );
                }
            }
        }
        
        level thread debug_draw();
        level thread devgui_spawn_instance();
    }

    // Namespace content_manager
    // Params 3
    // Checksum 0x8aaf475d, Offset: 0x2565
    // Size: 0x5e, Type: dev
    function function_c97c1fa76d5f85fe( name, pos, str )
    {
        path = "<dev string:x347>";
        path += "<dev string:x318>" + name + "<dev string:x309>" + pos;
        
        if ( isdefined( str ) )
        {
            path += "<dev string:x318>" + str;
        }
        
        return path;
    }

    // Namespace content_manager
    // Params 2
    // Checksum 0xba7de29, Offset: 0x25cb
    // Size: 0x44, Type: dev
    function function_6d6d111f5149df24( var_93094652f48d675, commands )
    {
        cmd = "<dev string:x35e>" + var_93094652f48d675 + "<dev string:x36b>" + commands + "<dev string:x36f>";
        addentrytodevgui( cmd );
    }

    // Namespace content_manager
    // Params 1
    // Checksum 0xfb77435, Offset: 0x2617
    // Size: 0x19, Type: dev
    function addentrytodevgui( command )
    {
        level thread addentrytodevgui_internal( command );
    }

    // Namespace content_manager
    // Params 1
    // Checksum 0xfbf4374f, Offset: 0x2638
    // Size: 0x19f, Type: dev
    function addentrytodevgui_internal( command )
    {
        if ( !isdefined( command ) )
        {
            return;
        }
        
        wait 5;
        
        if ( game[ "<dev string:x372>" ] == "<dev string:x378>" )
        {
            return;
        }
        
        final_command = "<dev string:x381>";
        toks = strtok( command, "<dev string:x318>" );
        space = "<dev string:x382>";
        num_toks = 0;
        
        foreach ( tok in toks )
        {
            new_toks = strtok( tok, "<dev string:x382>" );
            count = 1;
            size = new_toks.size;
            
            foreach ( new_tok in new_toks )
            {
                if ( count < size )
                {
                    final_command = final_command + new_tok + space;
                }
                else
                {
                    final_command += new_tok;
                }
                
                count++;
            }
            
            num_toks++;
            
            if ( num_toks < toks.size )
            {
                final_command += "<dev string:x318>";
            }
        }
        
        adddebugcommand( final_command );
    }

    // Namespace content_manager
    // Params 0
    // Checksum 0xe97cf27e, Offset: 0x27df
    // Size: 0x131, Type: dev
    function devgui_spawn_instance()
    {
        self notify( #"hash_3beb6895e4833446" );
        self endon( #"hash_3beb6895e4833446" );
        
        while ( true )
        {
            setdvar( @"hash_861046be2917f04e", "<dev string:x381>" );
            wait 0.05;
            instancekey = getdvar( @"hash_861046be2917f04e", "<dev string:x381>" );
            
            if ( instancekey == "<dev string:x381>" )
            {
                continue;
            }
            
            keys = strtok( instancekey, "<dev string:x309>" );
            
            if ( keys.size != 2 )
            {
                continue;
            }
            
            location = level.contentmanager.locations[ keys[ 0 ] ];
            
            if ( !isdefined( location ) )
            {
                continue;
            }
            
            if ( isdefined( location.var_79fa2b508da4958f ) )
            {
                continue;
            }
            
            instance = location.instances.versions[ keys[ 1 ] ];
            
            if ( !isdefined( instance ) )
            {
                continue;
            }
            
            teleport = get_content_struct( instance, "<dev string:x384>" );
            level.players[ 0 ] setorigin( teleport.origin );
            function_67e4b7678fb21e11( instance );
        }
    }

    // Namespace content_manager
    // Params 0
    // Checksum 0xc8862aec, Offset: 0x2918
    // Size: 0x14b, Type: dev
    function debug_draw()
    {
        self notify( #"endon_content_manager_debug_draw" );
        self endon( #"endon_content_manager_debug_draw" );
        
        while ( true )
        {
            if ( getdvarint( @"content_manager_debug_draw", 0 ) )
            {
                foreach ( destination in level.contentmanager.destinations )
                {
                    function_e53fc2ddbc44595f( destination );
                }
                
                foreach ( location in level.contentmanager.locations )
                {
                    function_330bfb73b0c30406( location, location.destination );
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace content_manager
    // Params 1
    // Checksum 0xdd041a6f, Offset: 0x2a6b
    // Size: 0x31, Type: dev
    function function_e53fc2ddbc44595f( destination )
    {
        function_8bdfb298e3dc9f40( destination, ( 0, 1, 0 ), undefined, destination.targetname );
    }

    // Namespace content_manager
    // Params 2
    // Checksum 0x85cf9667, Offset: 0x2aa4
    // Size: 0x127, Type: dev
    function function_330bfb73b0c30406( location, destination )
    {
        function_8bdfb298e3dc9f40( location, ( 0, 1, 1 ), destination, location.targetname );
        
        foreach ( var_60b0c6fa501215be in location.instances )
        {
            foreach ( instance in var_60b0c6fa501215be.versions )
            {
                function_334c956629a61b72( instance, location );
            }
        }
    }

    // Namespace content_manager
    // Params 2
    // Checksum 0xed682c3a, Offset: 0x2bd3
    // Size: 0x39, Type: dev
    function function_334c956629a61b72( instance, location )
    {
        function_8bdfb298e3dc9f40( instance, ( 0, 0, 1 ), location );
        function_5e68b9bda64c1527( instance );
    }

    // Namespace content_manager
    // Params 1
    // Checksum 0x16193ac0, Offset: 0x2c14
    // Size: 0x11b, Type: dev
    function function_5e68b9bda64c1527( node )
    {
        if ( isarray( node.var_1d6cddfc47031bff ) )
        {
            foreach ( group in node.var_1d6cddfc47031bff )
            {
                foreach ( child in group )
                {
                    function_8bdfb298e3dc9f40( child, ( 1, 0, 1 ), node );
                    function_5e68b9bda64c1527( child );
                }
            }
        }
    }

    // Namespace content_manager
    // Params 4
    // Checksum 0x61a84683, Offset: 0x2d37
    // Size: 0xca, Type: dev
    function function_8bdfb298e3dc9f40( struct, color, parent, var_817c238af82ac93f )
    {
        debugstr = undefined;
        debugstr = function_48943debe26b4815( debugstr, struct.variantname );
        debugstr = function_48943debe26b4815( debugstr, struct.content_script_name );
        debugstr = function_48943debe26b4815( debugstr, struct.content_key );
        debugstr = function_48943debe26b4815( debugstr, var_817c238af82ac93f );
        
        if ( isdefined( parent ) )
        {
            line( struct.origin, parent.origin, color );
        }
        
        sphere( struct.origin, 8, color );
        print3d( struct.origin, debugstr );
    }

    // Namespace content_manager
    // Params 2
    // Checksum 0x3b49ca72, Offset: 0x2e09
    // Size: 0x3a, Type: dev
    function function_48943debe26b4815( str, append )
    {
        if ( !isdefined( str ) )
        {
            return append;
        }
        else if ( isdefined( append ) )
        {
            return ( str + "<dev string:x38a>" + append );
        }
        
        return str;
    }

#/
