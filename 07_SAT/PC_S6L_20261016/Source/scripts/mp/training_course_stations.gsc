// scripts\mp\training_course_stations.gsc  (hash_7f23d8e377c5b6c4.gscc) (size: 24467 Bytes / 0x5f93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd86cecc (3716599500)
// size ...... 24467 (0x5f93)
// includes .. 10  (offset: 0x5c33)
// strings ... 48  (offset: 0x5c83)
// dev strs .. 10  (offset: 0x5f1b)
// exports ... 60  (offset: 0x3bb3)
// cseg ...... 0x48b + 0x3728 (0x3bb3)
// imports ... 189 (offset: 0x4513)
// animtree1 . 0   (offset: 0x5f93)
// animtree2 . 0   (offset: 0x5f93)
#using script_409e412fa44b6c91;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\training_course_utils;

#namespace training_course_stations;

// Namespace training_course_stations
// Params 3
// Checksum 0x8908f0bb, Offset: 0x4a9
// Size: 0x71
function function_696273ac9d3bea25( tutorial, new_state, player )
{
    training_course_utils::function_df581661be9ca5c5( player );
    
    if ( training_course_utils::function_1c1639bf73457e80( player ) )
    {
        training_course_utils::function_5e3e773127f754db( player );
    }
    
    if ( training_course_utils::function_33427acbfd53222( player ) )
    {
        training_course_utils::function_55099ffa73b4eff1( player );
    }
    
    if ( training_course_utils::function_ce08700870078f55( player ) )
    {
        training_course_utils::function_c58312077098c9c8( player );
    }
    
    tutorial.state = new_state;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x5dcb8d1b, Offset: 0x522
// Size: 0x19, Type: bool
function function_d1d2cf69e63f6596( tutorial )
{
    return tutorial.state == 0;
}

// Namespace training_course_stations
// Params 1
// Checksum 0xdd5da120, Offset: 0x544
// Size: 0x1a, Type: bool
function function_cbcead310c3cf8bd( tutorial )
{
    return tutorial.state == 1;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x4345eadf, Offset: 0x567
// Size: 0x1a, Type: bool
function function_7bc1290560032d39( tutorial )
{
    return tutorial.state == 3;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x3bc885b7, Offset: 0x58a
// Size: 0x27, Type: bool
function function_abaed5b5b01f5e28( tutorial )
{
    if ( !level.var_9b65db225ac25b95 )
    {
        return false;
    }
    
    return istrue( tutorial.var_a5fd41050e0ceb34 );
}

// Namespace training_course_stations
// Params 1
// Checksum 0xb00c5d40, Offset: 0x5ba
// Size: 0x17
function function_3c77ed00cac74efe( tutorial )
{
    return tutorial.is_locked;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x48e5e2da, Offset: 0x5da
// Size: 0x17
function function_faefa119842f585b( tutorial )
{
    return tutorial.is_completed;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x2f3a71dc, Offset: 0x5fa
// Size: 0x17
function function_655349246b97b3a1( tutorial )
{
    return tutorial.var_96e5beb113f41311;
}

// Namespace training_course_stations
// Params 1
// Checksum 0x3a96ce2e, Offset: 0x61a
// Size: 0x17
function function_399e310dabe4c2cc( tutorial )
{
    return tutorial.id_string;
}

// Namespace training_course_stations
// Params 1
// Checksum 0xd8689aa0, Offset: 0x63a
// Size: 0x17
function function_87ff4a0d38e17094( tutorial )
{
    return tutorial.tutorial_type;
}

// Namespace training_course_stations
// Params 1
// Checksum 0xe35554ec, Offset: 0x65a
// Size: 0x17
function function_8b878dec24bedc0e( tutorial )
{
    return tutorial.var_81173965ad64569;
}

// Namespace training_course_stations
// Params 2
// Checksum 0xd0345e46, Offset: 0x67a
// Size: 0x44
function function_f1ec08cd8f74da12( player, tutorial )
{
    if ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        training_course_utils::function_5c1689103ca32d82( player, tutorial );
        thread starttutorial( player, tutorial, 1, tutorial.var_b8abd6e1783d0f45, 0, 0 );
    }
}

// Namespace training_course_stations
// Params 2
// Checksum 0x55de0d56, Offset: 0x6c6
// Size: 0x73
function function_78ed747911e430e7( interactable, tutorial )
{
    level endon( #"game_ended" );
    interactable endon( #"delete" );
    interactable endon( #"hash_23f15c705d374165" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        interactable sethintinoperable( 1 );
        function_f1ec08cd8f74da12( player, tutorial );
        break;
    }
}

// Namespace training_course_stations
// Params 1
// Checksum 0x166a0d4d, Offset: 0x741
// Size: 0x19
function function_bfd317f43b3fe8e3( interactable )
{
    interactable notify( #"hash_23f15c705d374165" );
}

// Namespace training_course_stations
// Params 1, eflags: 0x4
// Checksum 0x35d3f891, Offset: 0x762
// Size: 0xa0
function private function_f5f4ddfbfd8dee71( player )
{
    if ( level.npc_enabled && !isdefined( player.leave_training_course_interactable ) )
    {
        leave_training_course_interactable = spawn( "script_model", training_course_utils::function_d58310d0f1d16d43( ( -30411, -57290, 272 ), player.map_instance_index ) );
        leave_training_course_interactable makeusable();
        leave_training_course_interactable setuserange( 100 );
        leave_training_course_interactable sethintstring( &"t10_training_course/leave_training_course" );
        leave_training_course_interactable setcursorhint( "HINT_NOICON" );
        player.leave_training_course_interactable = leave_training_course_interactable;
        thread function_312ad34cc38979e4( leave_training_course_interactable, player );
    }
}

// Namespace training_course_stations
// Params 2
// Checksum 0x7efb61bd, Offset: 0x80a
// Size: 0x7a
function function_312ad34cc38979e4( interactable, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    interactable endon( #"delete" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        
        if ( training_course_utils::function_d39dfc7ac04716ef( player ) )
        {
            training_course_utils::function_816ecee4d7db0c68( player, training_course_utils::function_d18dd74017e9db87( player.map_instance_index ), 1 );
        }
    }
}

// Namespace training_course_stations
// Params 6, eflags: 0x4
// Checksum 0x3efd2650, Offset: 0x88c
// Size: 0x9c
function private createboxtrigger( owning_tutorial, origin, size, angles, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_box", origin, 0, size * 0.5, size * 0.5 );
    trigger.trigger_size = size;
    trigger.angles = angles;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace training_course_stations
// Params 5
// Checksum 0x8e2579bd, Offset: 0x931
// Size: 0x78
function function_4c7f1d74ec378cc9( owning_tutorial, origin, radius, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_radius", origin, 0, radius, radius );
    trigger.radius = radius;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace training_course_stations
// Params 4, eflags: 0x4
// Checksum 0x782f2789, Offset: 0x9b2
// Size: 0x6c
function private function_2bc6e455359ea3f2( trigger, owning_tutorial, var_79d0387098c2d96a, var_42322f2afdbd8587 )
{
    trigger.var_cad029c2ab7a4f73 = var_79d0387098c2d96a;
    trigger.var_42322f2afdbd8587 = var_42322f2afdbd8587;
    trigger.owning_tutorial = owning_tutorial;
    trigger.debug_draw = 1;
    trigger.is_init_trigger = 0;
}

// Namespace training_course_stations
// Params 2
// Checksum 0x4dc06148, Offset: 0xa26
// Size: 0xe9
function function_a49fc858e731dcdb( tutorial, value )
{
    trigger = tutorial.init_trigger;
    function_44278d13f2543f10( trigger, value );
    
    if ( isdefined( trigger.chevrons ) )
    {
        function_1ba47b7678db87c3( trigger.chevrons, value ? "contested" : "off" );
    }
    
    if ( isdefined( trigger.flag ) )
    {
        if ( value )
        {
            trigger.flag show();
            trigger.flag sethintinoperable( 0 );
            thread function_78ed747911e430e7( trigger.flag, tutorial );
            return;
        }
        
        function_bfd317f43b3fe8e3( trigger.flag );
        trigger.flag sethintinoperable( 1 );
        trigger.flag hide();
    }
}

// Namespace training_course_stations
// Params 4
// Checksum 0xf96ff32, Offset: 0xb17
// Size: 0x101
function function_8becb86703380fc7( player, tutorial, var_bc057f2eb5601c58, var_3d8b9a40a0d8353b )
{
    trigger = tutorial.init_trigger;
    
    if ( isdefined( trigger.objective_marker ) )
    {
        if ( var_bc057f2eb5601c58 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( trigger.objective_marker.objidnum, player );
            objective_state( trigger.objective_marker.objidnum, var_3d8b9a40a0d8353b ? "current" : "invisible" );
            return;
        }
        
        if ( !var_3d8b9a40a0d8353b )
        {
            objidpoolmanager::objective_playermask_hidefromallplayers( trigger.objective_marker.objidnum );
            return;
        }
        
        objidpoolmanager::objective_playermask_addshowplayer( trigger.objective_marker.objidnum, player );
        objective_state( trigger.objective_marker.objidnum, "active" );
    }
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x8ee2da8d, Offset: 0xc20
// Size: 0x48
function private function_44278d13f2543f10( trigger, value )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    /#
        trigger.debug_draw = value;
    #/
    
    if ( value )
    {
        trigger utility::trigger_on_proc();
        return;
    }
    
    trigger utility::trigger_off_proc();
}

// Namespace training_course_stations
// Params 2
// Checksum 0x4da8416, Offset: 0xc70
// Size: 0x4b
function registertrigger( player, trigger )
{
    if ( !isdefined( player.registered_triggers ) )
    {
        player.registered_triggers = [];
    }
    
    player.registered_triggers[ player.registered_triggers.size ] = trigger;
}

// Namespace training_course_stations
// Params 2
// Checksum 0xf6e7b1c4, Offset: 0xcc3
// Size: 0xc2
function deregistertrigger( player, trigger_to_remove )
{
    foreach ( index, trigger in player.registered_triggers )
    {
        if ( trigger == trigger_to_remove )
        {
            trigger delete();
            trigger = undefined;
            player.registered_triggers[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( player.registered_triggers );
            }
            
            break;
        }
    }
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x7ff0a76c, Offset: 0xd8d
// Size: 0xa9
function private function_cc9a85feed9c8e34( player, tutorial )
{
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 0 );
            function_8becb86703380fc7( player, other_tutorial, 0, 0 );
        }
    }
}

// Namespace training_course_stations
// Params 1
// Checksum 0x7739571b, Offset: 0xe3e
// Size: 0xda
function function_89df6b3aced6d8cd( player )
{
    var_826a597648a0c05a = undefined;
    
    if ( player.var_bb4f4ac000751f63 != -1 )
    {
        var_826a597648a0c05a = player.var_80e907d847fdb68c[ player.var_bb4f4ac000751f63 ];
    }
    
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 1 );
            function_8becb86703380fc7( player, other_tutorial, var_826a597648a0c05a === other_tutorial, 1 );
        }
    }
}

// Namespace training_course_stations
// Params 6
// Checksum 0x8a5928c5, Offset: 0xf20
// Size: 0xee
function function_5bda2610dad9e6e9( tutorial_name, map_instance_index, origin, angles, size_min, size_max )
{
    [ origin, angles ] = training_course_utils::function_52ff81cfdbb3f234( origin, angles, map_instance_index );
    var_4ecf01568e38e4b2 = spawnstruct();
    var_4ecf01568e38e4b2.angles = angles;
    var_4ecf01568e38e4b2.origin = origin;
    var_4ecf01568e38e4b2.sizemin = size_min;
    var_4ecf01568e38e4b2.sizemax = size_max;
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ] ) )
    {
        level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ] = [];
    }
    
    oob_array_size = level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ].size;
    level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ][ oob_array_size ] = var_4ecf01568e38e4b2;
}

// Namespace training_course_stations
// Params 3
// Checksum 0xbf46216, Offset: 0x1016
// Size: 0x1e2
function function_bb59f9b0bdf2d248( player, tutorial, value )
{
    tutorial_name = function_399e310dabe4c2cc( tutorial );
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ player.map_instance_index ][ tutorial_name ] ) )
    {
        return;
    }
    
    foreach ( var_4ecf01568e38e4b2 in level.var_c03063b5f4fc2dde[ player.map_instance_index ][ tutorial_name ] )
    {
        if ( value )
        {
            if ( !isdefined( var_4ecf01568e38e4b2.trigger ) )
            {
                trigger = spawn( "trigger_box", var_4ecf01568e38e4b2.origin, 0, var_4ecf01568e38e4b2.sizemin, var_4ecf01568e38e4b2.sizemax );
                trigger.angles = var_4ecf01568e38e4b2.angles;
                trigger.disabled = 0;
                var_4ecf01568e38e4b2.trigger = trigger;
                outofbounds::function_ea64b5c2bd16e0f5( trigger );
            }
            
            continue;
        }
        
        if ( isdefined( var_4ecf01568e38e4b2.trigger ) )
        {
            outofbounds::function_73faa310ef29036a( var_4ecf01568e38e4b2.trigger );
            var_4ecf01568e38e4b2.trigger delete();
            var_4ecf01568e38e4b2.trigger = undefined;
        }
    }
    
    if ( isdefined( tutorial.oob_chevrons ) && tutorial.oob_chevrons.size > 0 )
    {
        function_1ba47b7678db87c3( tutorial.oob_chevrons, value ? function_74fb2b19273b495a( player.team ) : "off" );
    }
}

// Namespace training_course_stations
// Params 1
// Checksum 0x5bda8f18, Offset: 0x1200
// Size: 0x1bf
function function_fb78e7c7ad8e2157( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_spectator_mode" );
    
    if ( isbot( player ) )
    {
        player endon( #"hash_27620d5c2e30b764" );
    }
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( player.registered_triggers ) )
        {
            continue;
        }
        
        foreach ( trigger in player.registered_triggers )
        {
            if ( !isdefined( trigger ) || trigger.trigger_off )
            {
                continue;
            }
            
            tutorial = trigger.owning_tutorial;
            
            if ( player istouching( trigger ) )
            {
                if ( !trigger.player_in_trigger )
                {
                    if ( isdefined( trigger.var_cad029c2ab7a4f73 ) )
                    {
                        if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                        {
                            player thread [[ trigger.var_cad029c2ab7a4f73 ]]( player, tutorial );
                        }
                    }
                }
                
                trigger.player_in_trigger = 1;
                continue;
            }
            
            if ( trigger.player_in_trigger )
            {
                trigger.player_in_trigger = 0;
                
                if ( isdefined( trigger.var_42322f2afdbd8587 ) )
                {
                    if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                    {
                        player thread [[ trigger.var_42322f2afdbd8587 ]]( player, tutorial );
                    }
                }
            }
        }
    }
}

/#

    // Namespace training_course_stations
    // Params 0
    // Checksum 0x48dfc3e4, Offset: 0x13c7
    // Size: 0xe9, Type: dev
    function function_833acbbe64353915()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( level.players[ 0 ].registered_triggers ) )
            {
                foreach ( trigger in level.players[ 0 ].registered_triggers )
                {
                    if ( trigger.debug_draw )
                    {
                        if ( getdvarint( @"hash_c01ca8e4931f5a75", 0 ) == 1 )
                        {
                            drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 0 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace training_course_stations
    // Params 0
    // Checksum 0x4214cc69, Offset: 0x14b8
    // Size: 0x1ae, Type: dev
    function function_893ed490f765fc47()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_f9119320cacb3f8c", 0 ) == 0 )
            {
                continue;
            }
            
            if ( !isdefined( level.var_c03063b5f4fc2dde ) )
            {
                continue;
            }
            
            foreach ( var_2147e11a2bc2fc64 in level.var_c03063b5f4fc2dde )
            {
                foreach ( trigger_array in var_2147e11a2bc2fc64 )
                {
                    foreach ( triggerdata in trigger_array )
                    {
                        if ( triggerdata.trigger )
                        {
                            drawtrigger( triggerdata.trigger, ( 1, 0, 0 ), 0, 1, 0 );
                        }
                    }
                }
            }
        }
    }

#/

// Namespace training_course_stations
// Params 5, eflags: 0x4
// Checksum 0xd6d32f5f, Offset: 0x166e
// Size: 0x156
function private function_c2bdaa68bf39d803( chevron_type, var_fb035a7b0ad53750, perimeter_vertices, var_7e40d40f67122c1b = 1, var_73d12631951e4c7b = 0 )
{
    if ( perimeter_vertices.size < 3 )
    {
        assertmsg( "<dev string:x24>" );
        return [];
    }
    
    inward_normals = function_bfd4538e73b78d19( perimeter_vertices, 1 );
    chevrons = [];
    
    for ( i = 0; i < perimeter_vertices.size ; i++ )
    {
        if ( !var_7e40d40f67122c1b && i == perimeter_vertices.size - 1 )
        {
            break;
        }
        
        middle_vector = ( inward_normals[ i ] + inward_normals[ ( i + 1 ) % inward_normals.size ] ) * 0.5;
        var_200af70048253636 = ( 0, vectortoangles( middle_vector )[ 1 ], 0 );
        var_9dfd5783fe0e619b = !var_7e40d40f67122c1b && i == 0 ? 0 : 1;
        chevron_line = function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, perimeter_vertices[ i ], perimeter_vertices[ ( i + 1 ) % perimeter_vertices.size ], vectortoangles( inward_normals[ i ] ), var_200af70048253636, var_73d12631951e4c7b, var_9dfd5783fe0e619b );
        chevrons = arraycombine( chevrons, chevron_line );
    }
    
    /#
        if ( getdvarint( @"hash_116be81c99e1c527", 0 ) == 1 )
        {
            thread function_5510c4ea1694380d( perimeter_vertices, inward_normals );
        }
    #/
    
    return chevrons;
}

// Namespace training_course_stations
// Params 5, eflags: 0x4
// Checksum 0x56d6d586, Offset: 0x17cd
// Size: 0xd5
function private function_a017d1ec37595fa( chevron_type, circle_origin, radius, step_size, var_ef43d1064d479fdd = 0 )
{
    circle_vertices = plotcircle( circle_origin, radius, step_size );
    chevrons = [];
    
    for ( i = 0; i < circle_vertices.size ; i++ )
    {
        direction = undefined;
        
        if ( var_ef43d1064d479fdd )
        {
            direction = circle_origin - circle_vertices[ i ];
        }
        else
        {
            direction = circle_vertices[ i ] - circle_origin;
        }
        
        angles = vectortoangles( direction );
        chevron = spawnscriptable( chevron_type, circle_vertices[ i ], angles );
        chevron setscriptablepartstate( "chevron_0", "contested" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace training_course_stations
// Params 8
// Checksum 0x6f989a16, Offset: 0x18ab
// Size: 0x192
function function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, start_origin, end_origin, angles, var_9d537a9ea9d659bf = undefined, heightaboveground = 0, var_9dfd5783fe0e619b = 0 )
{
    if ( !isdefined( var_9d537a9ea9d659bf ) )
    {
        var_9d537a9ea9d659bf = angles;
    }
    
    if ( var_fb035a7b0ad53750 <= 0 )
    {
        return [];
    }
    
    direction = vectornormalize( end_origin - start_origin );
    point_distance = distance( end_origin, start_origin );
    
    if ( point_distance <= 0 )
    {
        return [];
    }
    
    var_599cbf71370a2947 = int( ceil( point_distance / var_fb035a7b0ad53750 ) );
    var_c413de20b2897373 = point_distance / var_599cbf71370a2947;
    chevrons = [];
    
    for ( i = var_9dfd5783fe0e619b ? 1 : 0; i < var_599cbf71370a2947 + 1 ; i++ )
    {
        x = start_origin[ 0 ] + var_c413de20b2897373 * i * direction[ 0 ];
        y = start_origin[ 1 ] + var_c413de20b2897373 * i * direction[ 1 ];
        z = start_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + heightaboveground );
        chevron = spawnscriptable( chevron_type, origin, i == var_599cbf71370a2947 ? var_9d537a9ea9d659bf : angles );
        chevron setscriptablepartstate( "chevron_0", "idle" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace training_course_stations
// Params 5, eflags: 0x4
// Checksum 0xad43f94b, Offset: 0x1a46
// Size: 0xee
function private function_871cc06a4aaadaf5( tutorial, var_fb035a7b0ad53750, chevrons_vertices, angles = ( 0, 0, 0 ), var_7e40d40f67122c1b = 0 )
{
    if ( chevrons_vertices.size < 2 )
    {
        assertmsg( "<dev string:x5e>" );
        return;
    }
    
    chevrons = undefined;
    
    if ( chevrons_vertices.size == 2 )
    {
        chevrons = function_81f25287b76e02b2( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices[ 0 ], chevrons_vertices[ 1 ], angles );
    }
    else
    {
        chevrons = function_c2bdaa68bf39d803( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices, var_7e40d40f67122c1b );
    }
    
    function_1ba47b7678db87c3( chevrons, "off" );
    
    if ( !isdefined( tutorial.oob_chevrons ) )
    {
        tutorial.oob_chevrons = [];
    }
    
    tutorial.oob_chevrons = arraycombine( tutorial.oob_chevrons, chevrons );
}

// Namespace training_course_stations
// Params 1
// Checksum 0x6a5fd5a8, Offset: 0x1b3c
// Size: 0x81
function deletechevrons( chevron_array )
{
    foreach ( chevron in chevron_array )
    {
        chevron freescriptable();
    }
    
    chevron_array = [];
    return chevron_array;
}

// Namespace training_course_stations
// Params 2
// Checksum 0xa4a83457, Offset: 0x1bc6
// Size: 0xb0
function function_1ba47b7678db87c3( chevron_array, state )
{
    if ( !isdefined( chevron_array ) )
    {
        return;
    }
    
    if ( chevron_array.size > 0 && chevron_array[ 0 ] getscriptablepartstate( "chevron_0" ) == state )
    {
        return;
    }
    
    foreach ( chevron in chevron_array )
    {
        chevron setscriptablepartstate( "chevron_0", state );
    }
}

// Namespace training_course_stations
// Params 1
// Checksum 0x50df0a86, Offset: 0x1c7e
// Size: 0x24
function function_d7e4d4b8d06945ac( player_team )
{
    return player_team == "axis" ? "axis" : "contested";
}

// Namespace training_course_stations
// Params 1
// Checksum 0x2fb8c0d0, Offset: 0x1cab
// Size: 0x24
function function_74fb2b19273b495a( player_team )
{
    return player_team == "axis" ? "allies" : "axis";
}

// Namespace training_course_stations
// Params 2
// Checksum 0x893da8d3, Offset: 0x1cd8
// Size: 0x131
function function_bfd4538e73b78d19( vertices, var_5dbb6ff207c17611 )
{
    normals = [];
    centroid = ( 0, 0, 0 );
    
    foreach ( vertex in vertices )
    {
        centroid += vertex;
    }
    
    centroid /= vertices.size;
    
    for ( i = 0; i < vertices.size ; i++ )
    {
        edgevector = vertices[ ( i + 1 ) % vertices.size ] - vertices[ i ];
        normal = ( edgevector[ 1 ] * -1, edgevector[ 0 ], 0 );
        toedge = vertices[ i ] - centroid;
        
        if ( var_5dbb6ff207c17611 && vectordot( toedge, normal ) > 0 )
        {
            normal *= -1;
        }
        
        normal = vectornormalize2( normal );
        normals[ normals.size ] = normal;
    }
    
    return normals;
}

// Namespace training_course_stations
// Params 3, eflags: 0x4
// Checksum 0xd58aa2e1, Offset: 0x1e12
// Size: 0xe4
function private plotcircle( center_origin, radius, step_size )
{
    pi = 3.14159;
    centerx = center_origin[ 0 ];
    centery = center_origin[ 1 ];
    circle_vertices = [];
    theta = 0;
    
    while ( theta <= 2 * pi )
    {
        radians = theta * 180 / pi;
        x = round( centerx + radius * cos( radians ) );
        y = round( centery + radius * sin( radians ) );
        z = center_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        circle_vertices[ circle_vertices.size ] = origin;
        theta += step_size;
    }
    
    return circle_vertices;
}

/#

    // Namespace training_course_stations
    // Params 2, eflags: 0x4
    // Checksum 0xcd449d63, Offset: 0x1eff
    // Size: 0x114, Type: dev
    function private function_5510c4ea1694380d( perimeter_vertices, normals )
    {
        while ( true )
        {
            for ( i = 0; i < perimeter_vertices.size ; i++ )
            {
                sphere( perimeter_vertices[ i ], 5, ( 0, 1, 0 ), 0, 1 );
                print3d( perimeter_vertices[ i ], string( i ), ( 1, 0, 0 ), 1, 1, 1, 1 );
                
                if ( i < perimeter_vertices.size - 1 )
                {
                    line( perimeter_vertices[ i ], perimeter_vertices[ i + 1 ], ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            if ( perimeter_vertices.size > 1 )
            {
                line( perimeter_vertices[ perimeter_vertices.size - 1 ], perimeter_vertices[ 0 ], ( 1, 0, 0 ), 1, 0, 1 );
            }
            
            for ( i = 0; i < normals.size ; i++ )
            {
                normal = normals[ i ];
                utility::draw_arrow( perimeter_vertices[ i ], perimeter_vertices[ i ] + normal * 50, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/

// Namespace training_course_stations
// Params 1, eflags: 0x4
// Checksum 0x2490a127, Offset: 0x201b
// Size: 0x45
function private waitforplayerspawned( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    do
    {
        level waittill( #"player_spawned", spawned_player );
    }
    while ( player != spawned_player );
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x1e8a6537, Offset: 0x2068
// Size: 0x5c
function private function_b26daaaa9debed6e( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player notifyonplayercommand( "exit_tutorial_preview", "+gostand" );
    player waittill( #"exit_tutorial_preview" );
    thread restarttutorial( player, tutorial, 0, 0, 0, undefined );
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x5ae3fe1e, Offset: 0x20cc
// Size: 0x30
function private function_275e97f81427089d( tutorial, player )
{
    return function_abaed5b5b01f5e28( tutorial ) ? player.spectating_player : player;
}

// Namespace training_course_stations
// Params 28
// Checksum 0x72d11fac, Offset: 0x2105
// Size: 0x4e1
function createtutorial( player, id_string, var_81173965ad64569, tutorial_type, var_96e5beb113f41311, onsetup, oncleanup, onfail, onexit, startlogic, var_3dcac807aca26fce, var_fe1e173811f47789, var_47f8fc3de4a91658, respawn_position, respawn_angles, var_b8abd6e1783d0f45, var_daae47f54aee1cc3, respawn_delay, init_trigger_position, transition_fade_in_time, transition_fade_out_time, var_11b386f1f1fd262a, var_c7da30c496405c56 = 1, var_5953c9ce8530c19a = 110, start_trigger_radius = 100, var_d67fbb77e4f2e2b5 = 1.2, waypoint_icon_override = undefined, var_6d772cdfad7bf8d5 = undefined )
{
    [ respawn_position, respawn_angles ] = training_course_utils::function_52ff81cfdbb3f234( respawn_position, respawn_angles, player.map_instance_index );
    tutorial_struct = { #fail_state:-1, #is_completed:0, #is_locked:0, #var_11b386f1f1fd262a:var_11b386f1f1fd262a, #transition_fade_out_time:transition_fade_out_time, #transition_fade_in_time:transition_fade_in_time, #respawn_delay:respawn_delay, #respawn_angles:respawn_angles, #respawn_position:respawn_position, #var_daae47f54aee1cc3:var_daae47f54aee1cc3, #var_b8abd6e1783d0f45:var_b8abd6e1783d0f45, #startlogic:startlogic, #var_47f8fc3de4a91658:var_47f8fc3de4a91658, #var_fe1e173811f47789:var_fe1e173811f47789, #var_3dcac807aca26fce:var_3dcac807aca26fce, #onexit:onexit, #onfail:onfail, #oncleanup:oncleanup, #onsetup:onsetup, #oob_chevrons:[], #var_a5fd41050e0ceb34:0, #var_98cec33d0b4e8c5:0, #var_5a63045faffa8fee:0, #state:3, #var_96e5beb113f41311:var_96e5beb113f41311, #tutorial_type:tutorial_type, #var_81173965ad64569:var_81173965ad64569, #id_string:id_string };
    var_b3e7a6423912e4b7 = level.var_b3e7a6423912e4b7;
    tutorial_struct.order_number = -1;
    
    for ( i = 0; i < var_b3e7a6423912e4b7.size ; i++ )
    {
        if ( var_b3e7a6423912e4b7[ i ] == var_81173965ad64569 )
        {
            tutorial_struct.order_number = i;
            break;
        }
    }
    
    assert( tutorial_struct.order_number != -1, id_string + "<dev string:x9e>" );
    init_trigger_position = training_course_utils::function_d58310d0f1d16d43( init_trigger_position, player.map_instance_index );
    init_trigger = function_4c7f1d74ec378cc9( tutorial_struct, init_trigger_position, start_trigger_radius, &training_course_utils::function_3a0aec7f1e9988a3, &training_course_utils::function_5c1689103ca32d82 );
    init_trigger.is_init_trigger = 1;
    tutorial_struct.init_trigger = init_trigger;
    registertrigger( player, init_trigger );
    flag = spawn( "script_model", init_trigger_position );
    
    if ( var_c7da30c496405c56 )
    {
        flag setmodel( level.flag_model );
    }
    
    tutorial_struct.init_trigger.flag = flag;
    flag makeusable();
    flag setuserange( start_trigger_radius * var_d67fbb77e4f2e2b5 );
    flag sethintstring( &"t10_training_course/enter_station_hint" );
    flag setcursorhint( "HINT_NOICON" );
    thread function_78ed747911e430e7( flag, tutorial_struct );
    marker = gameobjects::createobjidobject( init_trigger_position, "neutral", ( 0, 0, var_5953c9ce8530c19a ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, waypoint_icon_override ?? function_de3c47a67959c59e( tutorial_struct.order_number ) );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, training_course_utils::function_fb000aeabac687eb() );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::function_586b631e7bbb592a( marker.objidnum, 1 );
    objective_setlabel( marker.objidnum, var_6d772cdfad7bf8d5 ?? training_course_utils::function_e2157f3642beec77( tutorial_struct.order_number ) );
    objidpoolmanager::objective_playermask_hidefromallplayers( marker.objidnum );
    tutorial_struct.init_trigger.objective_marker = marker;
    player.tutorial_dictionary[ id_string ] = tutorial_struct;
    function_bb59f9b0bdf2d248( player, tutorial_struct, 0 );
    return tutorial_struct;
}

// Namespace training_course_stations
// Params 3
// Checksum 0x8d92d79e, Offset: 0x25ef
// Size: 0xde
function deletetutorial( player, tutorial, is_disconnecting )
{
    if ( !function_7bc1290560032d39( tutorial ) )
    {
        exittutorial( player, tutorial, 0, undefined, 0, is_disconnecting );
    }
    
    objidpoolmanager::returnobjectiveid( tutorial.init_trigger.objective_marker.objidnum );
    tutorial.init_trigger.objective_marker = undefined;
    function_bfd317f43b3fe8e3( tutorial.init_trigger.flag );
    tutorial.init_trigger.flag delete();
    tutorial.init_trigger delete();
    
    if ( isdefined( tutorial.oob_chevrons ) )
    {
        deletechevrons( tutorial.oob_chevrons );
    }
    
    tutorial = {};
}

// Namespace training_course_stations
// Params 1, eflags: 0x4
// Checksum 0x5920ef74, Offset: 0x26d6
// Size: 0x56
function private function_de3c47a67959c59e( tutorial_order_number )
{
    icon_name = "sat_ui_icon_waypoint_training_station_";
    
    if ( tutorial_order_number < 0 || tutorial_order_number > 7 )
    {
        iprintlnbold( "Icon { " + icon_name + tutorial_order_number + 1 + " } does not exist. We would need to create one." );
        return ( icon_name + "1" );
    }
    
    return icon_name + tutorial_order_number + 1;
}

// Namespace training_course_stations
// Params 7
// Checksum 0x177b8b72, Offset: 0x2735
// Size: 0x6a8
function starttutorial( player, new_tutorial_struct, var_67d56ce428f7a6f9, var_21904a198ae4f24e = 0, var_2b4b07109454f1e4 = 0, was_failed = 0, var_1511c5590534bc27 = undefined )
{
    assert( isdefined( new_tutorial_struct ), "<dev string:xc8>" );
    player endon( #"disconnect" );
    player notify( #"tutorial_changed" );
    player endon( #"tutorial_changed" );
    
    if ( function_abaed5b5b01f5e28( player.current_tutorial ) )
    {
        training_course_utils::function_729244fb63340d85( player ) notify( #"tutorial_changed" );
    }
    
    thread function_ee1d3936eb6e1e03( player, new_tutorial_struct );
    
    if ( var_21904a198ae4f24e )
    {
        player allowmovement( 0 );
        training_course_utils::function_3f46a4fd28a17454( player, new_tutorial_struct );
        training_course_utils::function_48b7033aa12c2f72( function_abaed5b5b01f5e28( player.current_tutorial ) ? training_course_utils::function_729244fb63340d85( player ) : player, new_tutorial_struct.transition_fade_in_time );
        wait new_tutorial_struct.transition_fade_in_time;
        player setvelocity( ( 0, 0, 0 ) );
    }
    
    var_73d6e8949482c08c = function_abaed5b5b01f5e28( new_tutorial_struct );
    
    if ( isdefined( player.current_tutorial ) )
    {
        profilestart();
        function_bb59f9b0bdf2d248( player, player.current_tutorial, 0 );
        [[ player.current_tutorial.oncleanup ]]( function_abaed5b5b01f5e28( player.current_tutorial ) ? training_course_utils::function_729244fb63340d85( player ) : player, player.current_tutorial );
        profilestop();
        
        if ( level.var_9b65db225ac25b95 && function_abaed5b5b01f5e28( player.current_tutorial ) )
        {
            should_spawn_player = !var_2b4b07109454f1e4;
            function_1df2d986a2f9e167( training_course_utils::function_729244fb63340d85( player ), player.current_tutorial, should_spawn_player, 0, player );
            
            if ( should_spawn_player )
            {
                waitforplayerspawned( player );
            }
        }
        
        /#
            iprintln( "<dev string:xf0>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
        #/
    }
    
    /#
        iprintln( "<dev string:xfa>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
    #/
    
    namespace_512cbd6ffc19387::function_c06c98d7da9ead59( player );
    player setclientomnvar( "training_course_current_station_unique_id", function_8b878dec24bedc0e( new_tutorial_struct ) );
    player setclientomnvar( "training_course_current_station_type", function_87ff4a0d38e17094( new_tutorial_struct ) );
    player setclientomnvar( "is_in_training_course_tutorial_station", 1 );
    player setclientomnvar( "current_tutorial_has_preview", level.var_9b65db225ac25b95 && isdefined( new_tutorial_struct.var_fe1e173811f47789 ) );
    player setclientomnvar( "training_course_station_supports_instructions", function_655349246b97b3a1( new_tutorial_struct ) );
    function_cc9a85feed9c8e34( player, new_tutorial_struct );
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( training_course_utils::function_33427acbfd53222( player ) )
    {
        training_course_utils::function_55099ffa73b4eff1( player );
    }
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable hide();
    }
    
    if ( level.var_9b65db225ac25b95 && var_2b4b07109454f1e4 )
    {
        preview_bot = training_course_utils::function_729244fb63340d85( player );
        function_d7da7bef32a55e59( player, preview_bot, new_tutorial_struct );
        player = preview_bot;
    }
    
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapon.basename != "none" )
        {
            player setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
    }
    
    player.health = player.maxhealth;
    player freezecontrols( 1 );
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, new_tutorial_struct );
    }
    
    if ( isdefined( new_tutorial_struct.var_e7e7977f1d016e4c ) )
    {
        wait new_tutorial_struct.var_e7e7977f1d016e4c;
    }
    
    [[ new_tutorial_struct.onsetup ]]( player, new_tutorial_struct );
    
    if ( var_21904a198ae4f24e )
    {
        wait new_tutorial_struct.var_11b386f1f1fd262a;
        player setorigin( new_tutorial_struct.respawn_position );
        player setplayerangles( new_tutorial_struct.respawn_angles );
        outofbounds::enableoobimmunity( player );
        
        if ( !new_tutorial_struct.var_98cec33d0b4e8c5 )
        {
            player setstance( "stand", 1, 1 );
        }
    }
    
    function_bb59f9b0bdf2d248( player, new_tutorial_struct, 1 );
    
    if ( level.var_9b65db225ac25b95 && var_2b4b07109454f1e4 )
    {
        function_275e97f81427089d( new_tutorial_struct, player ) player::updatesessionstate( "spectator" );
    }
    
    if ( var_21904a198ae4f24e )
    {
        training_course_utils::function_471eaf1a49ed9cc9( player, new_tutorial_struct.transition_fade_out_time );
        wait new_tutorial_struct.transition_fade_out_time;
    }
    
    outofbounds::function_9aa3ce7806e04201( player );
    player.current_tutorial = new_tutorial_struct;
    var_773e146ef834850 = !function_faefa119842f585b( new_tutorial_struct ) && isdefined( new_tutorial_struct.var_47eb83743fd1597 ) && !was_failed && !var_2b4b07109454f1e4 && !var_73d6e8949482c08c;
    
    if ( var_773e146ef834850 )
    {
        thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, new_tutorial_struct.var_47eb83743fd1597, 1 );
    }
    
    if ( var_67d56ce428f7a6f9 && function_655349246b97b3a1( new_tutorial_struct ) )
    {
        var_c387f9f8e6ada71d = function_275e97f81427089d( new_tutorial_struct, player );
        training_course_utils::function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 1, !var_773e146ef834850 );
        new_tutorial_struct waittill( #"triptychs_training_course_station_start" );
        training_course_utils::function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 0, 0 );
    }
    
    training_course_utils::function_649644d8af5d56f( player, new_tutorial_struct );
    player freezecontrols( 0 );
    
    if ( !new_tutorial_struct.var_5a63045faffa8fee )
    {
        player allowmovement( 1 );
    }
    
    function_696273ac9d3bea25( new_tutorial_struct, 0, player );
    
    if ( isdefined( new_tutorial_struct.startlogic ) )
    {
        thread [[ new_tutorial_struct.startlogic ]]( player, new_tutorial_struct );
    }
    
    if ( !new_tutorial_struct.var_a5fd41050e0ceb34 && !was_failed )
    {
        player training_course_utils::function_ae1b81443a485a25();
        player training_course_utils::function_21095a8908de4687();
    }
    
    if ( level.var_9b65db225ac25b95 && var_2b4b07109454f1e4 )
    {
        function_a2935575b5b51ed6( player, new_tutorial_struct );
        
        if ( level.var_37f10e1572a7803b )
        {
            thread function_b26daaaa9debed6e( player.spectating_player, new_tutorial_struct );
        }
    }
    
    if ( was_failed && !isbot( player ) && training_course_utils::function_32d334aad6bf0ad3( new_tutorial_struct ) )
    {
        thread training_course_utils::showfailhint( player, new_tutorial_struct );
    }
    
    if ( isbot( player ) )
    {
        thread function_fb78e7c7ad8e2157( player );
    }
    
    new_tutorial_struct notify( #"tutorial_started" );
    player playlocalsound( "uin_t10_training_course_tutorial_start" );
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x39a6f673, Offset: 0x2de5
// Size: 0x7f
function private function_ee1d3936eb6e1e03( player, tutorial )
{
    player endon( #"tutorial_changed" );
    tutorial endon( #"tutorial_started" );
    player endon( #"disconnect" );
    
    if ( player::isreallyalive( player ) )
    {
        player waittill( #"death" );
    }
    
    while ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        if ( training_course_utils::function_faa438d8de9a4dc9( player ) )
        {
            break;
        }
        
        waitframe();
    }
    
    thread exittutorial( player, tutorial, 1 );
}

// Namespace training_course_stations
// Params 6
// Checksum 0x81131ca6, Offset: 0x2e6c
// Size: 0xc2
function restarttutorial( player, tutorial, var_2b4b07109454f1e4, var_67d56ce428f7a6f9, was_failed, var_1511c5590534bc27 = undefined )
{
    /#
        iprintln( "<dev string:x104>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    player notify( #"restart_tutorial" );
    player endon( #"restart_tutorial" );
    player endon( #"disconnect" );
    
    if ( outofbounds::isoob( player ) )
    {
        outofbounds::clearoob( player );
        outofbounds::enableoobimmunity( player );
    }
    
    function_696273ac9d3bea25( tutorial, 4, player );
    thread starttutorial( player, tutorial, var_67d56ce428f7a6f9, tutorial.var_daae47f54aee1cc3, var_2b4b07109454f1e4, was_failed, var_1511c5590534bc27 );
}

// Namespace training_course_stations
// Params 4
// Checksum 0xb23903d0, Offset: 0x2f36
// Size: 0x12a
function failtutorial( player, tutorial, var_e1f0ee5f702d4e4f, var_b0168b4849ac579b )
{
    player notify( #"fail_tutorial" );
    player endon( #"fail_tutorial" );
    player endon( #"disconnect" );
    
    /#
        iprintln( "<dev string:x110>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_failed" );
    function_696273ac9d3bea25( tutorial, 1, player );
    
    if ( true )
    {
        training_course_utils::function_3f46a4fd28a17454( player, tutorial );
    }
    
    if ( isdefined( tutorial.onfail ) )
    {
        thread [[ tutorial.onfail ]]( player, tutorial );
    }
    
    player.failed_attempts++;
    
    if ( isdefined( tutorial.var_8c2623b27b71c6bd ) )
    {
        thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, tutorial.var_8c2623b27b71c6bd, 1, 1 );
    }
    
    if ( var_e1f0ee5f702d4e4f && !training_course_utils::function_32d334aad6bf0ad3( tutorial ) )
    {
        training_course_utils::function_6c0ff087784b7b0( tutorial, var_b0168b4849ac579b ? &"t10_training_course/failhint_elimination_multiple_enemies" : &"t10_training_course/failhint_elimination_single_enemy" );
    }
    
    player playlocalsound( "uin_t10_training_course_tutorial_fail" );
}

// Namespace training_course_stations
// Params 6
// Checksum 0xe03dc4fd, Offset: 0x3068
// Size: 0x340
function exittutorial( player, tutorial, should_play_transition, var_1511c5590534bc27 = undefined, was_completed = 0, is_disconnecting = 0 )
{
    player endon( #"disconnect" );
    player notify( #"tutorial_changed" );
    player endon( #"tutorial_changed" );
    
    if ( function_abaed5b5b01f5e28( tutorial ) )
    {
        training_course_utils::function_729244fb63340d85( player ) notify( #"tutorial_changed" );
    }
    
    player setclientomnvar( "is_in_training_course_tutorial_station", 0 );
    player setclientomnvar( "training_course_is_in_preview", 0 );
    player setclientomnvar( "current_tutorial_has_preview", 0 );
    player setclientomnvar( "training_course_station_supports_instructions", 0 );
    function_696273ac9d3bea25( tutorial, 3, player );
    
    if ( should_play_transition )
    {
        training_course_utils::function_3f46a4fd28a17454( player );
        player freezecontrols( 1 );
        training_course_utils::function_48b7033aa12c2f72( function_abaed5b5b01f5e28( tutorial ) ? training_course_utils::function_729244fb63340d85( player ) : player, tutorial.transition_fade_in_time );
        wait tutorial.transition_fade_in_time;
    }
    
    if ( training_course_utils::function_faa438d8de9a4dc9( player ) )
    {
        training_course_utils::function_dfb331efe033ac6c( player, tutorial, 0, 0 );
    }
    
    /#
        iprintln( "<dev string:x119>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    profilestart();
    [[ tutorial.oncleanup ]]( function_abaed5b5b01f5e28( tutorial ) ? training_course_utils::function_729244fb63340d85( player ) : player, tutorial );
    profilestop();
    
    if ( level.var_9b65db225ac25b95 && function_abaed5b5b01f5e28( tutorial ) )
    {
        function_1df2d986a2f9e167( training_course_utils::function_729244fb63340d85( player ), tutorial, !is_disconnecting, is_disconnecting, player );
        
        if ( !is_disconnecting )
        {
            waitforplayerspawned( player );
        }
    }
    
    if ( isdefined( tutorial.onexit ) )
    {
        [[ tutorial.onexit ]]( function_abaed5b5b01f5e28( tutorial ) ? training_course_utils::function_729244fb63340d85( player ) : player, tutorial );
    }
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, tutorial );
    }
    
    function_89df6b3aced6d8cd( player );
    function_bb59f9b0bdf2d248( player, tutorial, 0 );
    namespace_512cbd6ffc19387::function_a028ec2a35d56827( player.map_instance_index );
    training_course_utils::function_6c0ff087784b7b0( tutorial, undefined );
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable show();
    }
    
    if ( should_play_transition )
    {
        namespace_512cbd6ffc19387::function_c06c98d7da9ead59( player );
    }
    else if ( !is_disconnecting )
    {
        var_f9c5d2ee69430bbb = 202500;
        thread namespace_512cbd6ffc19387::function_627eacd3e7dbf412( player, var_f9c5d2ee69430bbb );
    }
    
    if ( should_play_transition )
    {
        player setorigin( tutorial.respawn_position );
        player setplayerangles( tutorial.respawn_angles );
        player setstance( "stand", 1, 1 );
        training_course_utils::function_471eaf1a49ed9cc9( player, tutorial.transition_fade_out_time );
        wait tutorial.transition_fade_out_time;
    }
    
    training_course_utils::function_649644d8af5d56f( player );
    player freezecontrols( 0 );
    player allowmovement( 1 );
    outofbounds::function_9aa3ce7806e04201( player );
    player training_course_utils::function_ae1b81443a485a25( was_completed, 0 );
    
    if ( player.current_tutorial === tutorial )
    {
        player.current_tutorial = undefined;
    }
    
    if ( player.training_course_completed )
    {
        training_course_utils::function_ac53a17fd5b74658( player, &"sat_training_course/leave_training_course_hint" );
    }
}

// Namespace training_course_stations
// Params 3
// Checksum 0xde7c29e6, Offset: 0x33b0
// Size: 0x475
function completetutorial( player, tutorial, var_cb54f480ed623755 = 1 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player notify( #"complete_tutorial" );
    player endon( #"complete_tutorial" );
    
    /#
        iprintln( "<dev string:x122>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_completed" );
    function_696273ac9d3bea25( tutorial, 2, player );
    
    if ( function_abaed5b5b01f5e28( tutorial ) )
    {
        wait 1;
        thread restarttutorial( function_275e97f81427089d( tutorial, player ), tutorial, 0, 1, 0, undefined );
        return;
    }
    
    if ( !function_faefa119842f585b( tutorial ) && isdefined( tutorial.var_366e9014d86d580a ) )
    {
        thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, tutorial.var_366e9014d86d580a, 1, 1.5 );
    }
    else if ( isdefined( tutorial.var_6caae9f87149260b ) )
    {
        thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, tutorial.var_6caae9f87149260b, 1, 1.5 );
    }
    
    tutorial.is_completed = 1;
    player setclientomnvar( "training_course_tutorial_completed", function_8b878dec24bedc0e( tutorial ) );
    
    if ( var_cb54f480ed623755 )
    {
        player hud_message::function_ccbbac80e736b9f9( "training_tutorial_completed", undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    var_3ef8077d0bfd5d0f = 0;
    var_d4ac22c68ea6d8c9 = 0;
    
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( function_faefa119842f585b( other_tutorial ) )
        {
            var_3ef8077d0bfd5d0f++;
        }
    }
    
    if ( var_3ef8077d0bfd5d0f == player.tutorial_dictionary.size )
    {
        level callback::callback( #"hash_6c71d319dc089c27", { #player:player, #event:#"on_tutorial_completed" } );
        var_d4ac22c68ea6d8c9 = 1;
    }
    
    player.training_course_completed = var_d4ac22c68ea6d8c9;
    
    if ( level.var_37f10e1572a7803b )
    {
        emote_tutorial = player.tutorial_dictionary[ "emote" ];
        
        if ( function_3c77ed00cac74efe( emote_tutorial ) && !function_faefa119842f585b( emote_tutorial ) )
        {
            if ( var_3ef8077d0bfd5d0f == player.tutorial_dictionary.size - 1 )
            {
                function_bfa865dfd7b9bfd6( player, emote_tutorial, 0 );
                tutorials_to_add[ "emote" ] = emote_tutorial;
                thread training_course_utils::function_dc85cd6a6bf80d4b( player, "bonus_tutorial_unlocked", 2 );
                thread training_course_utils::function_e6c0ed093a236b20( player, 0, tutorials_to_add );
                thread training_course_utils::function_e6c0ed093a236b20( player, 0, tutorials_to_add );
            }
        }
    }
    
    if ( player.var_bb4f4ac000751f63 == tutorial.order_number && !var_d4ac22c68ea6d8c9 )
    {
        for ( i = player.var_bb4f4ac000751f63 + 1; i < player.var_80e907d847fdb68c.size ; i++ )
        {
            if ( !function_faefa119842f585b( player.var_80e907d847fdb68c[ i ] ) )
            {
                player.var_bb4f4ac000751f63 = player.var_80e907d847fdb68c[ i ].order_number;
                break;
            }
        }
    }
    else if ( var_d4ac22c68ea6d8c9 )
    {
        player.var_bb4f4ac000751f63 = -1;
    }
    
    if ( var_d4ac22c68ea6d8c9 && !player.training_course_completed_vo_played )
    {
        var_d2eca20e13d16605 = 2;
        vos_aliases = [ "dx_mp_mptc_mptcallstationcmpln1_smta", "dx_mp_mptc_mptcallstationcmpln2_smta" ];
        thread training_course_utils::function_e79357e1bec9adad( player.npc_agent, vos_aliases, 1, var_d2eca20e13d16605, 0.4 );
        thread training_course_utils::function_dc85cd6a6bf80d4b( player, "training_course_completed", var_d2eca20e13d16605 );
        player.training_course_completed_vo_played = 1;
    }
    
    if ( level.npc_enabled && !isdefined( player.leave_training_course_interactable ) && var_d4ac22c68ea6d8c9 )
    {
        thread training_course_utils::function_5b3639edf841fc69( player, player.npc_agent, training_course_utils::function_acd7b230b1df93c1( player.map_instance_index ) );
        function_f5f4ddfbfd8dee71( player );
    }
    
    thread exittutorial( player, tutorial, 0, undefined, 1 );
}

// Namespace training_course_stations
// Params 3, eflags: 0x4
// Checksum 0xc0f412ce, Offset: 0x382d
// Size: 0x153
function private function_d7da7bef32a55e59( player, bot, tutorial )
{
    tutorial.var_a5fd41050e0ceb34 = 1;
    bot playershow();
    
    if ( getdvarint( @"hash_27519d16bffbc440", 0 ) == 1 )
    {
        player freezecontrols( 0 );
        player allowmovement( 1 );
        player setclientomnvar( "ui_hide_hud", 1 );
        
        /#
            if ( !player isnoclip() )
            {
                player noclip();
            }
        #/
        
        player notify( #"enter_spectator_mode" );
    }
    else
    {
        spectatetargetentnum = bot getentitynumber();
        player.forcespectatorclient = spectatetargetentnum;
        player notify( #"enter_spectator_mode" );
    }
    
    bot.spectating_player = player;
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "dont_path_to_enemy", 1 );
    bot botsetflag( "disable_random_goal", 1 );
    bot botsetflag( "no_enemy_search", 1 );
    bot botsetflag( "disable_automatic_sprint", 1 );
    player setclientomnvar( "training_course_is_in_preview", 1 );
    
    if ( isdefined( tutorial.var_3dcac807aca26fce ) )
    {
        profilestart();
        [[ tutorial.var_3dcac807aca26fce ]]( bot, tutorial );
        profilestop();
    }
    
    player thread function_193ffe26151ddf4c( tutorial );
}

// Namespace training_course_stations
// Params 5, eflags: 0x4
// Checksum 0x5fb9444a, Offset: 0x3988
// Size: 0x139
function private function_1df2d986a2f9e167( bot, tutorial, should_spawn_player, is_disconnecting = 0, player )
{
    bot notify( #"hash_27620d5c2e30b764" );
    tutorial.var_a5fd41050e0ceb34 = 0;
    
    if ( isdefined( tutorial.var_47f8fc3de4a91658 ) )
    {
        profilestart();
        [[ tutorial.var_47f8fc3de4a91658 ]]( bot, tutorial );
        profilestop();
    }
    
    spectating_player = bot.spectating_player;
    
    if ( !is_disconnecting )
    {
        bot botsetstance( "stand" );
        
        while ( ( training_course_utils::function_ea0c6158d187ce84( bot ) || bot getstance() != "stand" ) && isalive( bot ) )
        {
            waitframe();
        }
        
        training_course_utils::function_f84dc38c3e66bb65( bot );
        bot setorigin( training_course_utils::function_d58310d0f1d16d43( level.var_f04c44c2cc365ae6, bot.map_instance_index ) );
        bot.spectating_player = undefined;
        bot playerhide();
    }
    
    if ( should_spawn_player && isdefined( spectating_player ) )
    {
        spectating_player playerlogic::removefromalivecount( 0 );
        thread training_course_utils::giveloadoutonspawn( spectating_player );
        thread [[ level.var_bf9f86692b45ce4 ]]( spectating_player, tutorial );
        thread function_fb78e7c7ad8e2157( spectating_player );
    }
}

// Namespace training_course_stations
// Params 2, eflags: 0x4
// Checksum 0x97c1ae2e, Offset: 0x3ac9
// Size: 0x35
function private function_a2935575b5b51ed6( bot, tutorial )
{
    if ( isdefined( tutorial.var_fe1e173811f47789 ) )
    {
        thread [[ tutorial.var_fe1e173811f47789 ]]( bot, tutorial );
    }
}

// Namespace training_course_stations
// Params 1, eflags: 0xc
// Checksum 0xaf225c20, Offset: 0x3b06
// Size: 0x5d
function private function_193ffe26151ddf4c( tutorial )
{
    self notify( #"hash_d0b339289f8eb85" );
    self endon( #"hash_d0b339289f8eb85" );
    player = self;
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 75;
    thread restarttutorial( player, tutorial, 0, 1, 0, undefined );
}

// Namespace training_course_stations
// Params 3
// Checksum 0xf66c42a1, Offset: 0x3b6b
// Size: 0x48
function function_bfa865dfd7b9bfd6( player, tutorial, value )
{
    tutorial.is_locked = value;
    function_a49fc858e731dcdb( tutorial, !value );
    function_8becb86703380fc7( player, tutorial, !value, !value );
}

