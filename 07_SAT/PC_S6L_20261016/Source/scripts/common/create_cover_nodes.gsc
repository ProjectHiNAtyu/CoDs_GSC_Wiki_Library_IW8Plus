// scripts\common\create_cover_nodes.gsc  (hash_2ffc9cc854107314.gscc) (size: 34843 Bytes / 0x881b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x67a24a48 (1738689096)
// size ...... 34843 (0x881b)
// includes .. 3   (offset: 0x81d3)
// strings ... 67  (offset: 0x81eb)
// dev strs .. 24  (offset: 0x86e7)
// exports ... 70  (offset: 0x6307)
// cseg ...... 0x4b0 + 0x5e57 (0x6307)
// imports ... 131 (offset: 0x6df7)
// animtree1 . 0   (offset: 0x881b)
// animtree2 . 0   (offset: 0x881b)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace create_cover_nodes;

// Namespace create_cover_nodes
// Params 0
// Checksum 0xc2b6484b, Offset: 0x4ce
// Size: 0x19f
function create_cover_node_init()
{
    level endon( #"game_ended" );
    initialize_path_node_placement();
    utility::flag_init( "file_opened" );
    
    /#
        level thread debug_activation( @"scr_create_nodes", &function_2a1d781434204e17 );
        cmd = "<dev string:x24>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x92>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x102>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x178>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x1f1>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x26c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x2df>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x354>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x3db>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x456>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x4c3>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x52c>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x594>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x600>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x67d>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x6ea>";
        addentrytodevgui( cmd );
        setdvarifuninitialized( @"hash_b2a482fbfca2360c", 1 );
        setdvarifuninitialized( @"hash_d11a371f8f8dec6e", 0 );
        setdvarifuninitialized( @"scr_draw_nodes", 0 );
        setdvarifuninitialized( @"scr_save_trace_data", 0 );
        setdvarifuninitialized( @"scr_use_bsp_nodes", 0 );
        setdvarifuninitialized( @"hash_f42b414f3a439bf6", 0 );
    #/
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x21cb0763, Offset: 0x675
// Size: 0x5c
function initialize_path_node_placement()
{
    struct = spawnstruct();
    struct.trace_contents = trace::create_solid_ai_contents( 1 );
    struct.all_node_positions = [];
    struct.map_ent_index = 1;
    level.path_node_debug_info = struct;
    reset_path_node_placement();
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xc91f81c4, Offset: 0x6da
// Size: 0x60
function reset_path_node_placement_for_radius()
{
    struct = reset_path_node_placement();
    struct.x_magnitude = 32;
    struct.y_magnitude = 32;
    struct.max_x = 20;
    struct.max_y = 20;
    level.path_node_debug_info = struct;
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xbb096c0c, Offset: 0x743
// Size: 0x60
function reset_path_node_placement_for_lookat()
{
    struct = reset_path_node_placement();
    struct.debug_boxes = 1;
    struct.node_creation_traces = 32;
    struct.delayed_creation_calls = 0;
    struct.create_node_throttle = 500;
    level.path_node_debug_info = struct;
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xf9e1c8cc, Offset: 0x7ac
// Size: 0xca
function reset_path_node_placement_for_box_creation()
{
    struct = reset_path_node_placement();
    struct.debug_boxes = 1;
    struct.debug_boxes_max_count = 50;
    struct.debug_boxes_count = 0;
    struct.valid_forward_dist = 64;
    struct.x_magnitude = 256;
    struct.y_magnitude = 256;
    struct.z_magnitude = 128;
    struct.max_nav_offset = 4096;
    struct.create_node_throttle = 5000;
    struct.max_x = undefined;
    struct.max_y = undefined;
    struct.max_z = undefined;
    level.path_node_debug_info = struct;
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x6f24e6b5, Offset: 0x87f
// Size: 0x523
function reset_path_node_placement()
{
    struct = level.path_node_debug_info;
    struct.total_grid_points = 0;
    struct.start_time = gettime();
    struct.end_time = gettime();
    struct.total_time = gettime();
    struct.box_x = 1024;
    struct.box_y = 1024;
    struct.box_z = 512;
    struct.box_x_min = 512;
    struct.box_y_min = 512;
    struct.box_z_min = 128;
    struct.increase_x = 1;
    struct.increase_y = 1;
    struct.increase_z = 1;
    struct.box_center = ( 0, 0, 0 );
    struct.box_angles = ( 0, 0, 0 );
    struct.freeze_location = 0;
    struct.box_disabled = 0;
    struct.x_done = 0;
    struct.y_done = 0;
    struct.z_done = 0;
    struct.auto_write_to_map = 1;
    struct.use_bsp_nodes = getdvarint( @"scr_use_bsp_nodes", 1 );
    struct.debug_boxes = getdvarint( @"scr_draw_nodes", 0 );
    struct.edge_placement = 1;
    struct.file_path = level.script + "_script_paths.map";
    struct.node_creation_traces = 16;
    struct.node_creation_trace_index = 0;
    struct.node_creation_trace_dist = 365;
    struct.node_creation_angle_frac = 360 / struct.node_creation_traces;
    struct.aa_status = "waiting";
    struct.create_node_throttle = 5000;
    struct.throttle_counter = 0;
    struct.traces_count = 0;
    struct.x_magnitude = 256;
    struct.y_magnitude = 256;
    struct.z_magnitude = 64;
    struct.max_nav_offset = 16384;
    struct.valid_forward_dist = 64;
    struct.current_forward_dist = undefined;
    struct.x = 1;
    struct.y = 1;
    struct.z = 1;
    struct.max_x = undefined;
    struct.max_y = undefined;
    struct.last_x = 1;
    struct.last_y = 1;
    struct.x_dir_fails = 0;
    struct.y_dir_fails = 0;
    struct.dir_fails = 0;
    struct.max_dir_fails = 500;
    struct.total_z_planes = 5;
    struct.origin_counter = 0;
    struct.origin_max_dirs = 8;
    struct.dir_valid[ 0 ] = 1;
    struct.dir_valid[ 1 ] = 1;
    struct.dir_valid[ 2 ] = 1;
    struct.dir_valid[ 3 ] = 1;
    struct.dir_valid[ 4 ] = 1;
    struct.dir_valid[ 5 ] = 1;
    struct.dir_valid[ 6 ] = 1;
    struct.dir_valid[ 7 ] = 1;
    struct.grid_points_found = 1;
    struct.wall_units = 0;
    struct.wall_units_required = 32;
    struct.found_left_edge = 0;
    struct.found_right_edge = 0;
    struct.found_up_edge = 0;
    struct.found_exposed_pos = 0;
    struct.use_trace_data = getdvarint( @"scr_save_trace_data", 0 );
    struct.save_trace_data = 0;
    struct.temp_trace_data = [];
    struct.temp_trace_data_colors = [];
    struct.trace_data = [];
    struct.trace_data_colors = [];
    struct.grid_origin = ( 0, 0, 0 );
    struct.density_radius = 64;
    struct.density_cap = 4;
    struct.density_cap_count = 0;
    struct.found_valid_node_pos = 0;
    struct.create_exposed_node = getdvarint( @"hash_f42b414f3a439bf6", 0 );
    struct.should_create_exposed_node = 1;
    level.path_node_debug_info = struct;
    level.increase_y = struct;
    level.num_fails = 0;
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x4ae71670, Offset: 0xdab
// Size: 0xb
function debugdata()
{
    return level.path_node_debug_info;
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xa40faa2b, Offset: 0xdbf
// Size: 0xb8
function run_single_grid_point_test( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level endon( #"hash_bf5f426b063a9323" );
    reset_path_node_placement_for_box_creation();
    data = debugdata();
    data.player = player;
    open_and_write_to_paths_map();
    player notifyonplayercommand( "use", "+usereload" );
    player notifyonplayercommand( "use", "+activate" );
    
    while ( true )
    {
        player waittill( #"use" );
        data thread delay_node_creation_from_single_point();
    }
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x7f0556ac, Offset: 0xe7f
// Size: 0xcc
function place_path_node_from_lookat( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level endon( #"hash_bf5f426b063a9323" );
    reset_path_node_placement_for_lookat();
    data = debugdata();
    data.player = player;
    open_and_write_to_paths_map();
    player notifyonplayercommand( "use", "+usereload" );
    player notifyonplayercommand( "use", "+activate" );
    
    while ( true )
    {
        player waittill( #"use" );
        data childthread show_running_tool_message();
        delay_node_creation_from_look_at();
        data notify( #"hash_78110b989852ce4d" );
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x80085a91, Offset: 0xf53
// Size: 0x185
function delay_node_creation_from_single_point()
{
    data = debugdata();
    player = data.player;
    open_and_write_to_paths_map();
    data.starting_pos = player.origin;
    player_forward = anglestoforward( player getplayerangles() );
    result = create_node_trace( data.player geteye(), data.player geteye() + player_forward * 10000 );
    
    if ( isdefined( result[ "position" ] ) && result[ "fraction" ] < 1 )
    {
        new_pos = utility::drop_to_ground( result[ "position" ] + -1 * player_forward * 32, 96, -300 ) + ( 0, 0, 16 );
        data.x = new_pos[ 0 ];
        data.y = new_pos[ 1 ];
        data.z = new_pos[ 2 ];
        data.origin = new_pos;
        data.grid_origin = new_pos;
        
        if ( validate_grid_pos() )
        {
            data.node_type = "script_struct";
            data.total_grid_points++;
            data.angles = ( 0, 0, 0 );
            write_struct_to_map();
            data.classname = "node_exposed";
            create_and_validate_node_from_single_grid_point();
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xba101eb, Offset: 0x10e0
// Size: 0x161
function delay_node_creation_from_look_at()
{
    data = debugdata();
    player = data.player;
    open_and_write_to_paths_map();
    data.starting_pos = player.origin;
    player_forward = anglestoforward( player getplayerangles() );
    result = create_node_trace( data.player geteye(), data.player geteye() + player_forward * 10000 );
    
    if ( isdefined( result[ "position" ] ) && result[ "fraction" ] < 1 )
    {
        new_pos = utility::drop_to_ground( result[ "position" ] + -1 * player_forward * 32, 24, -300 ) + ( 0, 0, 16 );
        data.x = new_pos[ 0 ];
        data.y = new_pos[ 1 ];
        data.z = new_pos[ 2 ];
        data.origin = new_pos;
        data.grid_origin = new_pos;
        
        if ( validate_grid_pos() )
        {
            data.angles = ( 0, 0, 0 );
            data.classname = "node_exposed";
            create_cover_nodes_from_grid_point();
        }
    }
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xa69306ab, Offset: 0x1249
// Size: 0x24d
function place_path_nodes_within_box( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level endon( #"hash_bf5f426b063a9323" );
    data = debugdata();
    data.player = player;
    player notifyonplayercommand( "use", "+usereload" );
    player notifyonplayercommand( "use", "+activate" );
    reset_path_node_placement_for_box_creation();
    data childthread create_and_update_box();
    
    while ( true )
    {
        player waittill( #"use" );
        data.x = 0;
        data.y = 0;
        data.z = 0;
        data.increase_x = 1;
        data.increase_y = 1;
        data.increase_z = 1;
        data.x_done = 0;
        data.y_done = 0;
        data.z_done = 0;
        data.max_x = int( data.box_x / data.x_magnitude / 2 + 1 );
        data.max_y = int( data.box_y / data.y_magnitude / 2 + 1 );
        data.max_z = int( data.box_z / data.z_magnitude / 2 + 1 );
        data.box_disabled = 1;
        open_and_write_to_paths_map();
        data.starting_pos = data.box_center;
        data childthread show_running_tool_message();
        data.start_time = gettime();
        create_cover_nodes_within_volume();
        data.end_time = gettime();
        data.total_time = ( data.end_time - data.start_time ) / 1000;
        data notify( #"hash_78110b989852ce4d" );
        data.box_disabled = 0;
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xdcb90899, Offset: 0x149e
// Size: 0x407
function create_and_update_box()
{
    data = debugdata();
    data.player notifyonplayercommand( "up", "+actionslot 1" );
    data.player notifyonplayercommand( "down", "+actionslot 2" );
    data.player notifyonplayercommand( "right", "+actionslot 4" );
    data.player notifyonplayercommand( "rb", "+frag" );
    data.player notifyonplayercommand( "lb", "+smoke" );
    data.player notifyonplayercommand( "a", "+gostand" );
    data.player notifyonplayercommand( "left", "+actionslot 3" );
    data.player notifyonplayercommand( "dpad_left_release", "-actionslot 3" );
    data.player notifyonplayercommand( "dpad_left_press", "+actionslot 3" );
    data childthread create_box();
    
    while ( true )
    {
        result = data.player utility::waittill_any_in_array_return( [ "up", "a", "down", "left", "rb", "lb", "right", "dpad_left_release", "dpad_left_press" ] );
        
        if ( data.box_disabled )
        {
            wait 1;
            continue;
        }
        
        switch ( result )
        {
            case #"hash_96815ce4f2a3dbc5":
                while ( data.player buttonpressed( "DPAD_RIGHT" ) )
                {
                    data.box_y += data.y_magnitude;
                    wait 0.1;
                }
                
                break;
            case #"hash_34523dac9b76b3ea":
            case #"hash_b067ebb7da264998":
            case #"hash_c9b3133a17a3b2d0":
                data.box_y = int( max( data.box_y - data.y_magnitude, data.box_y_min ) );
                wait 0.1;
                break;
            case #"hash_31103fbc01bd840c":
                if ( data.freeze_location )
                {
                    data.freeze_location = 0;
                }
                else
                {
                    data.freeze_location = 1;
                }
                
                break;
            case #"hash_fa3db8f6bd73eb80":
                while ( data.player buttonpressed( "DPAD_UP" ) )
                {
                    data.box_x += data.x_magnitude;
                    wait 0.1;
                }
                
                break;
            case #"hash_f91b350a054b6175":
                while ( data.player buttonpressed( "DPAD_DOWN" ) )
                {
                    data.box_x = int( max( data.box_x - data.x_magnitude, data.box_x_min ) );
                    wait 0.1;
                }
                
                break;
            case #"hash_fa53d4f6bd8560b5":
                while ( data.player buttonpressed( "BUTTON_RSHLDR" ) )
                {
                    data.box_z += data.z_magnitude;
                    wait 0.1;
                }
                
                break;
            case #"hash_fa27bcf6bd62a8ab":
                while ( data.player buttonpressed( "BUTTON_LSHLDR" ) )
                {
                    data.box_z = int( max( data.box_z - data.z_magnitude, data.box_z_min ) );
                    wait 0.1;
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xdf12c31, Offset: 0x18ad
// Size: 0x6a
function show_running_tool_message()
{
    self endon( #"hash_78110b989852ce4d" );
    timer = 0;
    
    while ( true )
    {
        v_spacing = 500;
        msg = "Creating Nodes | Time Elapsed: " + timer;
        
        /#
            printtoscreen2d( 750, v_spacing, msg, ( 1, 1, 1 ), 2 );
        #/
        
        waitframe();
        timer += 0.05;
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xb742a963, Offset: 0x191f
// Size: 0x2fe
function create_box()
{
    data = debugdata();
    player = data.player;
    box_origin = player.origin + anglestoforward( player.angles ) * 500;
    box_angles = player.angles;
    last_pos = box_origin;
    last_angles = box_angles;
    
    while ( true )
    {
        if ( data.box_disabled )
        {
            wait 1;
            continue;
        }
        
        v_spacing = 150;
        
        if ( getdvarint( @"scr_cs_box_x", 0 ) != 0 )
        {
            data.box_x = getdvarint( @"scr_cs_box_x", 0 );
            msg = "X: " + data.box_x;
        }
        else
        {
            msg = "X: " + data.box_x;
        }
        
        v_spacing += 25;
        
        /#
            printtoscreen2d( 750, v_spacing, msg, ( 1, 1, 1 ), 2 );
        #/
        
        if ( getdvarint( @"scr_cs_box_y", 0 ) != 0 )
        {
            data.box_x = getdvarint( @"scr_cs_box_y", 0 );
            msg = "Y: " + data.box_y;
        }
        else
        {
            msg = "Y: " + data.box_y;
        }
        
        v_spacing += 25;
        
        /#
            printtoscreen2d( 750, v_spacing, msg, ( 1, 1, 1 ), 2 );
        #/
        
        if ( getdvarint( @"scr_cs_box_z", 0 ) != 0 )
        {
            data.box_x = getdvarint( @"scr_cs_box_z", 0 );
            msg = "Z: " + data.box_z;
        }
        else
        {
            msg = "Z: " + data.box_z;
        }
        
        v_spacing += 25;
        
        /#
            printtoscreen2d( 750, v_spacing, msg, ( 1, 1, 1 ), 2 );
        #/
        
        msg = "Location Locked: " + data.freeze_location;
        v_spacing += 25;
        
        /#
            printtoscreen2d( 750, v_spacing, msg, ( 1, 1, 1 ), 2 );
        #/
        
        if ( data.freeze_location )
        {
            box_origin = last_pos;
            box_angles = last_angles;
        }
        else
        {
            box_origin = player.origin + anglestoforward( player.angles ) * 500;
            box_angles = player.angles;
        }
        
        last_pos = box_origin;
        last_angles = box_angles;
        data.box_center = box_origin;
        data.box_angles = box_angles;
        
        /#
            orientedbox( box_origin, ( data.box_x, data.box_y, data.box_z ), box_angles, ( 1, 1, 0 ), 0, 1 );
        #/
        
        waitframe();
    }
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xdda810ad, Offset: 0x1c25
// Size: 0xcd
function place_path_nodes_within_radius( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level endon( #"hash_bf5f426b063a9323" );
    data = debugdata();
    data.player = player;
    player notifyonplayercommand( "use", "+usereload" );
    player notifyonplayercommand( "use", "+activate" );
    
    while ( true )
    {
        reset_path_node_placement_for_radius();
        player waittill( #"use" );
        open_and_write_to_paths_map();
        data.starting_pos = player.origin;
        create_cover_nodes_from_grid_points();
    }
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x2270f579, Offset: 0x1cfa
// Size: 0xb7
function place_path_nodes( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    data = debugdata();
    data.player = player;
    data.starting_pos = player.origin;
    reset_path_node_placement();
    open_and_write_to_paths_map();
    data.aa_status = "starting";
    data childthread show_running_tool_message();
    create_cover_nodes_from_grid_points();
    data notify( #"hash_78110b989852ce4d" );
    close_map_write();
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xb2ca22b6, Offset: 0x1db9
// Size: 0x484
function clean_up_nodes()
{
    level endon( #"game_ended" );
    level endon( #"hash_bf5f426b063a9323" );
    data = debugdata();
    reset_path_node_placement();
    open_and_write_to_paths_map();
    data.aa_status = "starting";
    data.use_bsp_nodes = 0;
    data.file_path = level.script + "_script_paths_clean.map";
    data childthread show_running_tool_message();
    starting_node_list = getallnodes();
    all_nodes = starting_node_list;
    
    if ( getdvarint( @"hash_b2a482fbfca2360c", 1 ) && isdefined( level.path_node_table ) && tableexists( level.path_node_table ) )
    {
        table = level.path_node_table;
        
        for ( row = 0; true ; row++ )
        {
            classname = tablelookupbyrow( table, row, 0 );
            
            if ( classname == "" )
            {
                break;
            }
            
            table_origin = strtok( tablelookupbyrow( table, row, 2 ), " " );
            node_origin = ( float( table_origin[ 0 ] ), float( table_origin[ 1 ] ), float( table_origin[ 2 ] ) );
            table_angles = strtok( tablelookupbyrow( table, row, 3 ), " " );
            node_angles = ( float( table_angles[ 0 ] ), float( table_angles[ 1 ] ), float( table_angles[ 2 ] ) );
            dist_override = getdvarint( @"hash_c1200bc122dd1ee0" );
            
            if ( dist_override != 0 )
            {
            }
            
            data.origin = node_origin;
            data.angles = node_angles;
            origin_offset = strtok( tablelookupbyrow( table, row, 4 ), " " );
            origin_offset = ( float( origin_offset[ 0 ] ), float( origin_offset[ 1 ] ), float( origin_offset[ 2 ] ) );
            angles_offset = strtok( tablelookupbyrow( table, row, 5 ), " " );
            angles_offset = ( float( angles_offset[ 0 ] ), float( angles_offset[ 1 ] ), float( angles_offset[ 2 ] ) );
            data translate_position_with_offset_data( origin_offset, angles_offset );
            new_pos = getgroundposition( data.origin, 1 );
            data.origin = new_pos;
            
            if ( isdefined( classname ) )
            {
                if ( node_passes_nav_and_geo_validation() )
                {
                    data.origin = node_origin;
                    data.angles = node_angles;
                    data.node_type = classname;
                    write_struct_to_map();
                }
            }
        }
    }
    else
    {
        node_counter = 0;
        
        while ( all_nodes.size > 1 )
        {
            node = all_nodes[ 0 ];
            all_nodes[ 0 ] = undefined;
            function_cdc669dbc8ea2101( all_nodes );
            new_pos = getgroundposition( node.origin, 16 );
            data.origin = new_pos;
            data.angles = node.angles;
            
            if ( node_passes_nav_and_geo_validation( 1 ) )
            {
                if ( isdefined( node.type ) )
                {
                    switch ( node.type )
                    {
                        case #"hash_e1d8e1adebed5a61":
                            data.node_type = "node_cover_left";
                            write_struct_to_map();
                            break;
                        case #"hash_cd3ffe799551db82":
                            data.node_type = "node_cover_right";
                            write_struct_to_map();
                            break;
                        case #"hash_c3b74422dec48736":
                            data.node_type = "node_cover_crouch";
                            write_struct_to_map();
                            break;
                        case #"hash_cf178f370da8b13":
                            data.node_type = "node_exposed";
                            write_struct_to_map();
                            break;
                        case #"hash_78bfa3258dd84af":
                            data.node_type = "exposed_crouch";
                            write_struct_to_map();
                            break;
                        case #"hash_776752872754e5ee":
                            data.node_type = "node_cover_crouch_window";
                            write_struct_to_map();
                            break;
                        default:
                            break;
                    }
                }
                
                nearby_nodes = getnodesinradius( data.origin, 16, 0, 32 );
                all_nodes = arrayremove( all_nodes, nearby_nodes );
            }
            
            node_counter++;
            
            if ( node_counter % 100 )
            {
                waitframe();
            }
        }
    }
    
    data notify( #"hash_78110b989852ce4d" );
    close_map_write();
    reset_path_node_placement();
}

// Namespace create_cover_nodes
// Params 2
// Checksum 0x6dc5cc35, Offset: 0x2245
// Size: 0xc3
function translate_position_with_offset_data( struct_origin_offset, struct_angle_offset )
{
    if ( isdefined( struct_angle_offset ) )
    {
        prefab_angles_offset = struct_angle_offset;
    }
    else
    {
        prefab_angles_offset = ( 0, 0, 0 );
    }
    
    if ( isdefined( self.angles ) )
    {
        obj_angles = self.angles;
    }
    else
    {
        obj_angles = ( 0, 0, 0 );
    }
    
    obj_origin = self.origin;
    obj_forward = anglestoforward( obj_angles );
    self.origin = struct_origin_offset + rotatevector( obj_origin, prefab_angles_offset );
    new_obj_angles = vectortoangles( rotatevector( obj_forward, prefab_angles_offset ) );
    self.angles = new_obj_angles;
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x948a897, Offset: 0x2310
// Size: 0x9d
function node_passes_nav_and_geo_validation( var_15a3b1843c6fb4ee )
{
    data = debugdata();
    
    if ( distancesquared( getclosestpointonnavmesh( data.origin ), data.origin ) >= 1024 )
    {
        return 0;
    }
    
    if ( !can_spawn_capsule_trace( data.origin ) )
    {
        return 0;
    }
    
    if ( !var_15a3b1843c6fb4ee )
    {
        nearby_nodes = getnodesinradius( data.origin, 16, 0, 64 );
        
        if ( nearby_nodes.size < 1 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x60ecbde8, Offset: 0x23b5
// Size: 0x240
function remove_similar_nodes( player )
{
    level notify( #"hash_31118ccad7fddb5c" );
    level endon( #"hash_31118ccad7fddb5c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level endon( #"hash_bf5f426b063a9323" );
    dist = 100;
    dist_override = getdvarint( @"hash_c1200bc122dd1ee0" );
    
    if ( dist_override != 0 )
    {
        dist = dist_override;
    }
    
    dist_sq = dist * dist;
    data = debugdata();
    data.player = player;
    reset_path_node_placement();
    open_and_write_to_paths_map();
    data.aa_status = "starting";
    starting_node_list = getallnodes();
    
    for ( i = 0; i < starting_node_list.size ; i++ )
    {
        test_node = starting_node_list[ i ];
        
        if ( isdefined( test_node ) )
        {
            remove = 0;
            
            for ( j = 0; j < starting_node_list.size ; j++ )
            {
                other_node = starting_node_list[ j ];
                
                if ( !isdefined( other_node ) )
                {
                    continue;
                }
                
                if ( other_node.origin == test_node.origin )
                {
                    continue;
                }
                
                position = test_node.origin;
                comp_dist = distancesquared( position, other_node.origin );
                
                if ( comp_dist <= dist_sq )
                {
                    if ( test_node.type == other_node.type )
                    {
                        if ( test_node.angles == other_node.angles )
                        {
                            remove = 1;
                            break;
                        }
                    }
                }
            }
            
            if ( !remove )
            {
                data.node_type = get_node_type_from_type( test_node );
                
                if ( isdefined( data.node_type ) )
                {
                    data.origin = test_node.origin;
                    data.angles = test_node.angles;
                    write_struct_to_map();
                }
                else
                {
                    starting_node_list[ i ] = undefined;
                }
                
                continue;
            }
            
            starting_node_list[ i ] = undefined;
        }
    }
    
    level thread close_map_write();
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x7320c1db, Offset: 0x25fd
// Size: 0x169, Type: bool
function similar_nodes_nearby()
{
    data = debugdata();
    dist = 100;
    dist_sq = dist * dist;
    
    if ( data.use_bsp_nodes )
    {
        starting_node_list = getallnodes();
        
        for ( i = 0; i < starting_node_list.size ; i++ )
        {
            test_node = starting_node_list[ i ];
            
            if ( isdefined( test_node ) )
            {
                if ( data.origin == test_node.origin )
                {
                    return false;
                }
                
                comp_dist = distancesquared( test_node.origin, data.origin );
                
                if ( comp_dist <= dist_sq )
                {
                    if ( test_node.angles == data.angles )
                    {
                        return false;
                    }
                }
            }
        }
    }
    
    starting_node_list = level.path_node_debug_info.all_node_positions;
    
    for ( i = 0; i < starting_node_list.size ; i++ )
    {
        test_node = starting_node_list[ i ];
        
        if ( isdefined( test_node ) )
        {
            if ( data.origin == test_node.origin )
            {
                return false;
            }
            
            comp_dist = distancesquared( data.origin, test_node.origin );
            
            if ( comp_dist <= dist_sq )
            {
                if ( test_node.angles == data.angles )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x9aa54816, Offset: 0x276f
// Size: 0x79
function get_node_type_from_type( node )
{
    switch ( node.type )
    {
        case #"hash_c3b74422dec48736":
            return "node_cover_crouch";
        case #"hash_e1d8e1adebed5a61":
            return "node_cover_left";
        case #"hash_cd3ffe799551db82":
            return "node_cover_right";
        case #"hash_78b110033ccb68b0":
            return "node_cover_stand";
        case #"hash_4ce78c21d46239e0":
            return "node_exposed";
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x684dcc9e, Offset: 0x27f1
// Size: 0x7
function get_raw_or_devraw_subdir()
{
    return "raw";
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x4c35bb9e, Offset: 0x2801
// Size: 0xab
function close_map_write()
{
    data = debugdata();
    
    if ( utility::flag( "file_opened" ) )
    {
        utility::flag_clear( "file_opened" );
        scriptname = data.file_path;
        raw_or_devraw_subdir = get_raw_or_devraw_subdir();
        filepath = "/map_source/" + scriptname;
        bp4add = 1;
        utility::fileprint_launcher_end_file( filepath, bp4add );
        level notify( #"hash_bf5f426b063a9323" );
    }
    
    if ( getdvarint( @"scr_save_trace_data", 0 ) )
    {
        level thread debug_node_array( data.all_node_positions );
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x6eab8c56, Offset: 0x28b4
// Size: 0x128
function create_cover_nodes_within_volume()
{
    level endon( #"game_ended" );
    data = debugdata();
    data.aa_status = "creating_cover_node_positions";
    data.grid_points_found = 1;
    data.increase_y = 1;
    
    while ( data.grid_points_found )
    {
        data.num_fails = 0;
        
        for ( i = 0; i < data.origin_max_dirs ; i++ )
        {
            data.origin_counter = i;
            get_next_volume_origin();
            
            if ( vol_validate_grid_pos() )
            {
                data.angles = ( 0, 0, 0 );
                data.node_type = "script_struct";
                data.origin = data.grid_origin;
                data.classname = "node_exposed";
                vol_create_cover_nodes_from_grid_point();
            }
        }
        
        create_grid_point_in_volume();
    }
    
    iprintlnbold( "Create Node Completed " + data.all_node_positions.size + " Created." );
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xf5a65dbd, Offset: 0x29e4
// Size: 0x104
function vol_create_cover_nodes_from_grid_point()
{
    data = debugdata();
    data.should_create_exposed_node = 1;
    
    for ( i = 0; i <= data.node_creation_traces ; i++ )
    {
        data.node_creation_trace_index = i;
        vol_create_and_validate_node();
    }
    
    if ( data.create_exposed_node && data.should_create_exposed_node )
    {
        final_pos = utility::drop_to_ground( data.grid_origin, 16, -300 ) + ( 0, 0, 16 );
        data.origin = final_pos;
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.angles = ( 0, 0, 0 );
            
            if ( !similar_nodes_nearby() )
            {
                return;
            }
            
            data.node_type = "node_exposed";
            run_path_node_removal();
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x9c023244, Offset: 0x2af0
// Size: 0x13c
function create_cover_nodes_from_grid_points()
{
    level endon( #"game_ended" );
    level endon( #"hash_cc0c97a06dc146ad" );
    data = debugdata();
    data.aa_status = "creating_cover_node_positions";
    data.grid_points_found = 1;
    data.increase_y = 1;
    
    while ( data.grid_points_found )
    {
        data.num_fails = 0;
        create_grid_point();
        
        for ( i = 0; i < data.origin_max_dirs ; i++ )
        {
            data.origin_counter = i;
            
            for ( z = 0; z < data.total_z_planes ; z++ )
            {
                data.z = z;
                get_next_origin();
                
                if ( validate_grid_pos() )
                {
                    data.angles = ( 0, 0, 0 );
                    data.classname = "node_exposed";
                    create_cover_nodes_from_grid_point();
                }
            }
        }
    }
    
    iprintlnbold( "Create Node Completed " + data.all_node_positions.size + " Created." );
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xa6d8dc20, Offset: 0x2c34
// Size: 0xe1
function create_grid_point_in_volume()
{
    data = debugdata();
    
    if ( data.increase_x )
    {
        vol_increase_x_coordinate();
    }
    else if ( data.increase_y )
    {
        data.increase_x = 1;
        data.x = 0;
        vol_increase_y_coordinate();
    }
    else
    {
        data.increase_x = 1;
        data.increase_y = 1;
        data.x = 0;
        data.y = 0;
        vol_increase_z_coordinate();
    }
    
    if ( data.x_done && data.y_done && data.z_done )
    {
        data.grid_points_found = 0;
        level notify( #"hash_cc0c97a06dc146ad" );
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xafc41f2c, Offset: 0x2d1d
// Size: 0x6a
function create_grid_point()
{
    data = debugdata();
    num_fails = 0;
    
    if ( !increase_y_coordinate() )
    {
        num_fails++;
        
        if ( increase_x_coordinate() )
        {
            data.y = 1;
        }
        else
        {
            num_fails++;
        }
    }
    
    if ( num_fails >= 2 )
    {
        data.grid_points_found = 0;
        level notify( #"hash_cc0c97a06dc146ad" );
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xba8abd0f, Offset: 0x2d8f
// Size: 0x107
function create_grid_point_new()
{
    data = debugdata();
    
    if ( data.dir_fails >= data.max_dir_fails )
    {
        data.grid_points_found = 0;
        level notify( #"hash_cc0c97a06dc146ad" );
        return;
    }
    
    num_fails = 0;
    
    if ( isdefined( data.max_y ) )
    {
        if ( data.y > data.max_y )
        {
            num_fails++;
        }
    }
    
    if ( isdefined( data.max_x ) )
    {
        if ( data.x > data.max_x )
        {
            num_fails++;
        }
    }
    
    if ( num_fails >= 2 )
    {
        data.grid_points_found = 0;
        level notify( #"hash_cc0c97a06dc146ad" );
        return;
    }
    
    if ( data.increase_y )
    {
        increase_y_coordinate_new();
        data.increase_y = 0;
        return;
    }
    
    increase_x_coordinate_new();
    data.increase_y = 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x365fb163, Offset: 0x2e9e
// Size: 0x63
function increase_y_coordinate_new()
{
    data = debugdata();
    
    if ( isdefined( data.max_y ) )
    {
        if ( data.y < data.max_y )
        {
            data.y++;
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    data.y++;
    return 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xef301064, Offset: 0x2f09
// Size: 0x63
function increase_x_coordinate_new()
{
    data = debugdata();
    
    if ( isdefined( data.max_x ) )
    {
        if ( data.x < data.max_x )
        {
            data.x++;
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    data.x++;
    return 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xdb2836fc, Offset: 0x2f74
// Size: 0x82
function increase_x_coordinate()
{
    data = debugdata();
    
    if ( data.x_dir_fails <= data.max_dir_fails )
    {
        if ( isdefined( data.max_x ) )
        {
            if ( data.x < data.max_x )
            {
                data.x++;
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            data.x++;
            return 1;
        }
        
        return;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x5cd2cbc3, Offset: 0x2ffe
// Size: 0x7e
function vol_increase_x_coordinate()
{
    data = debugdata();
    
    if ( isdefined( data.max_x ) )
    {
        if ( data.x < data.max_x )
        {
            data.x++;
            return 1;
        }
        else
        {
            data.increase_x = 0;
            data.x_done = 1;
            return 0;
        }
        
        return;
    }
    
    data.x++;
    return 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xf60495c5, Offset: 0x3084
// Size: 0x82
function increase_y_coordinate()
{
    data = debugdata();
    
    if ( data.y_dir_fails <= data.max_dir_fails )
    {
        if ( isdefined( data.max_y ) )
        {
            if ( data.y < data.max_y )
            {
                data.y++;
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            data.y++;
            return 1;
        }
        
        return;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xc2b5409, Offset: 0x310e
// Size: 0x7e
function vol_increase_y_coordinate()
{
    data = debugdata();
    
    if ( isdefined( data.max_y ) )
    {
        if ( data.y < data.max_y )
        {
            data.y++;
            return 1;
        }
        else
        {
            data.increase_y = 0;
            data.y_done = 1;
            return 0;
        }
        
        return;
    }
    
    data.y++;
    return 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x699663b3, Offset: 0x3194
// Size: 0x71
function vol_increase_z_coordinate()
{
    data = debugdata();
    
    if ( isdefined( data.max_z ) )
    {
        if ( data.z < data.max_z )
        {
            data.z++;
            return 1;
        }
        else
        {
            data.z_done = 1;
            return 0;
        }
        
        return;
    }
    
    data.z++;
    return 1;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x99da758c, Offset: 0x320d
// Size: 0x2fd
function get_next_origin()
{
    data = debugdata();
    starting_pos = data.starting_pos;
    x = data.x;
    y = data.y;
    z = data.z;
    
    if ( data.dir_valid[ data.origin_counter ] )
    {
        switch ( data.origin_counter )
        {
            case 0:
                data.grid_origin = starting_pos + ( x * data.x_magnitude, y * data.y_magnitude, z * data.z_magnitude );
                break;
            case 1:
                data.grid_origin = starting_pos + ( -1 * x * data.x_magnitude, y * data.y_magnitude, z * data.z_magnitude );
                break;
            case 2:
                data.grid_origin = starting_pos + ( -1 * x * data.x_magnitude, -1 * y * data.y_magnitude, z * data.z_magnitude );
                break;
            case 3:
                data.grid_origin = starting_pos + ( -1 * x * data.x_magnitude, y * data.y_magnitude, -1 * z * data.z_magnitude );
                break;
            case 4:
                data.grid_origin = starting_pos + ( -1 * x * data.x_magnitude, -1 * y * data.y_magnitude, -1 * z * data.z_magnitude );
                break;
            case 5:
                data.grid_origin = starting_pos + ( x * data.x_magnitude, -1 * y * data.y_magnitude, z * data.z_magnitude );
                break;
            case 6:
                data.grid_origin = starting_pos + ( x * data.x_magnitude, -1 * y * data.y_magnitude, -1 * z * data.z_magnitude );
                break;
            case 7:
                data.grid_origin = starting_pos + ( x * data.x_magnitude, y * data.y_magnitude, -1 * z * data.z_magnitude );
                break;
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x67f847d6, Offset: 0x3512
// Size: 0x25e
function get_next_volume_origin()
{
    data = debugdata();
    starting_pos = data.starting_pos;
    x = data.x;
    y = data.y;
    z = data.z;
    angles = data.box_angles;
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    x_mag = forward * x * data.x_magnitude;
    y_mag = right * y * data.y_magnitude;
    z_mag = up * z * data.z_magnitude;
    
    switch ( data.origin_counter )
    {
        case 0:
            data.grid_origin = starting_pos + x_mag + y_mag + z_mag;
            break;
        case 1:
            data.grid_origin = starting_pos + -1 * x_mag + y_mag + z_mag;
            break;
        case 2:
            data.grid_origin = starting_pos + -1 * x_mag + -1 * y_mag + z_mag;
            break;
        case 3:
            data.grid_origin = starting_pos + -1 * x_mag + y_mag + -1 * z_mag;
            break;
        case 4:
            data.grid_origin = starting_pos + -1 * x_mag + -1 * y_mag + -1 * z_mag;
            break;
        case 5:
            data.grid_origin = starting_pos + x_mag + -1 * y_mag + z_mag;
            break;
        case 6:
            data.grid_origin = starting_pos + x_mag + -1 * y_mag + -1 * z_mag;
            break;
        case 7:
            data.grid_origin = starting_pos + x_mag + y_mag + -1 * z_mag;
            break;
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xa7b0e290, Offset: 0x3778
// Size: 0xc1
function vol_validate_grid_pos()
{
    data = debugdata();
    closest_nav_point = getclosestpointonnavmesh( data.grid_origin );
    
    if ( distancesquared( closest_nav_point, data.grid_origin ) <= data.max_nav_offset )
    {
        data.grid_origin = utility::drop_to_ground( closest_nav_point, 96, -300 );
        data.origin = data.grid_origin + ( 0, 0, 16 );
        data.last_x = data.x;
        data.last_y = data.y;
        return 1;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x9a703a6b, Offset: 0x3841
// Size: 0x133
function validate_grid_pos()
{
    data = debugdata();
    closest_nav_point = getclosestpointonnavmesh( data.grid_origin );
    
    if ( distancesquared( closest_nav_point, data.grid_origin ) <= data.max_nav_offset )
    {
        data.grid_origin = utility::drop_to_ground( closest_nav_point, 96, -300 ) + ( 0, 0, 16 );
        data.origin = data.grid_origin;
        data.last_x = data.x;
        data.last_y = data.y;
        data.x_dir_fails = 0;
        data.y_dir_fails = 0;
        return 1;
    }
    
    data.dir_fails++;
    
    if ( data.last_x != data.x )
    {
        data.x_dir_fails++;
    }
    
    if ( data.last_y != data.y )
    {
        data.y_dir_fails++;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x94758a84, Offset: 0x397c
// Size: 0x59
function create_cover_nodes_from_single_grid_point()
{
    data = debugdata();
    data.should_create_exposed_node = 1;
    
    for ( i = 0; i <= data.node_creation_traces ; i++ )
    {
        data.node_creation_trace_index = i;
        create_and_validate_node_from_single_grid_point();
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x2bba1253, Offset: 0x39dd
// Size: 0x104
function create_cover_nodes_from_grid_point()
{
    data = debugdata();
    data.should_create_exposed_node = 1;
    
    for ( i = 0; i <= data.node_creation_traces ; i++ )
    {
        data.node_creation_trace_index = i;
        create_and_validate_node();
    }
    
    if ( data.create_exposed_node && data.should_create_exposed_node )
    {
        final_pos = utility::drop_to_ground( data.grid_origin, 16, -300 ) + ( 0, 0, 16 );
        data.origin = final_pos;
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.angles = ( 0, 0, 0 );
            
            if ( !similar_nodes_nearby() )
            {
                return;
            }
            
            data.node_type = "node_exposed";
            run_path_node_removal();
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x44d7dd34, Offset: 0x3ae9
// Size: 0x211
function vol_create_and_validate_node()
{
    data = debugdata();
    pos = data.grid_origin;
    angle = data.node_creation_angle_frac * data.node_creation_trace_index;
    xadd = cos( angle ) * data.node_creation_trace_dist;
    yadd = sin( angle ) * data.node_creation_trace_dist;
    x = pos[ 0 ] + xadd;
    y = pos[ 1 ] + yadd;
    z = pos[ 2 ];
    new_pos = ( x, y, z );
    result = create_node_trace( pos, new_pos );
    
    if ( isdefined( result[ "position" ] ) && result[ "fraction" ] < 1 )
    {
        data.should_create_exposed_node = 0;
        
        if ( isdefined( result[ "normal" ] ) )
        {
            updot = vectordot( result[ "normal" ], ( 0, 0, 1 ) );
            data.origin = result[ "position" ];
            data.angles = ( 0, math::wrap( 0, 359, 180 + vectortoangles( result[ "normal" ] )[ 1 ] ), 0 );
            
            if ( -0.1 > updot || updot > 0.1 )
            {
                return;
            }
        }
        
        var_1a98c6702facfa33 = getclosestpointonnavmesh( result[ "position" ] );
        
        if ( distancesquared( result[ "position" ], var_1a98c6702facfa33 ) <= data.max_nav_offset )
        {
            data.should_create_exposed_node = 0;
            data.origin = utility::drop_to_ground( var_1a98c6702facfa33, 96, -300 ) + ( 0, 0, 16 );
            data.angles = ( 0, math::wrap( 0, 359, 180 + vectortoangles( result[ "normal" ] )[ 1 ] ), 0 );
            reposition_cover_node();
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x9b1bd3b4, Offset: 0x3d02
// Size: 0x219
function create_and_validate_node_from_single_grid_point()
{
    data = debugdata();
    pos = data.grid_origin;
    angle = data.node_creation_angle_frac * data.node_creation_trace_index;
    xadd = cos( angle ) * data.node_creation_trace_dist;
    yadd = sin( angle ) * data.node_creation_trace_dist;
    x = pos[ 0 ] + xadd;
    y = pos[ 1 ] + yadd;
    z = pos[ 2 ];
    new_pos = ( x, y, z );
    result = create_node_trace( pos, new_pos );
    
    if ( isdefined( result[ "normal" ] ) )
    {
        updot = vectordot( result[ "normal" ], ( 0, 0, 1 ) );
        
        if ( -0.1 > updot || updot > 0.1 )
        {
            return;
        }
    }
    
    var_1a98c6702facfa33 = getclosestpointonnavmesh( result[ "position" ] );
    
    if ( distancesquared( result[ "position" ], var_1a98c6702facfa33 ) <= data.max_nav_offset )
    {
        data.should_create_exposed_node = 0;
        data.node_type = "script_struct";
        data.origin = utility::drop_to_ground( var_1a98c6702facfa33, 12, -300 ) + ( 0, 0, 16 );
        data.angles = ( 0, math::wrap( 0, 359, 180 + vectortoangles( result[ "normal" ] )[ 1 ] ), 0 );
        write_struct_to_map();
        data.total_grid_points++;
        reposition_cover_node();
        return;
    }
    
    data.node_type = "script_struct";
    data.angles = ( 0, 0, 0 );
    data.origin = result[ "position" ];
    write_struct_to_map();
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xbb5a4db0, Offset: 0x3f23
// Size: 0x1c7
function create_and_validate_node()
{
    data = debugdata();
    pos = data.grid_origin;
    angle = data.node_creation_angle_frac * data.node_creation_trace_index;
    xadd = cos( angle ) * data.node_creation_trace_dist;
    yadd = sin( angle ) * data.node_creation_trace_dist;
    x = pos[ 0 ] + xadd;
    y = pos[ 1 ] + yadd;
    z = pos[ 2 ];
    new_pos = ( x, y, z );
    result = create_node_trace( pos, new_pos );
    
    if ( isdefined( result[ "position" ] ) && result[ "fraction" ] < 1 )
    {
        data.should_create_exposed_node = 0;
        
        if ( isdefined( result[ "normal" ] ) )
        {
            updot = vectordot( result[ "normal" ], ( 0, 0, 1 ) );
            
            if ( -0.1 > updot || updot > 0.1 )
            {
                return;
            }
        }
        
        var_1a98c6702facfa33 = getclosestpointonnavmesh( result[ "position" ] );
        
        if ( distancesquared( result[ "position" ], var_1a98c6702facfa33 ) <= data.max_nav_offset )
        {
            data.origin = utility::drop_to_ground( var_1a98c6702facfa33, 12, -300 ) + ( 0, 0, 16 );
            data.angles = ( 0, math::wrap( 0, 359, 180 + vectortoangles( result[ "normal" ] )[ 1 ] ), 0 );
            reposition_cover_node();
        }
    }
}

// Namespace create_cover_nodes
// Params 3
// Checksum 0x50522ee9, Offset: 0x40f2
// Size: 0x130
function create_node_trace( start_pos, end_pos, debug_color )
{
    data = debugdata();
    attempt_throttle();
    data.traces_count++;
    result = trace::ray_trace( start_pos, end_pos, level.players, data.trace_contents );
    
    if ( data.save_trace_data )
    {
        if ( isdefined( result[ "position" ] ) )
        {
            if ( !isdefined( debug_color ) )
            {
                debug_color = ( 1, 1, 1 );
            }
            
            data.temp_trace_data[ data.temp_trace_data.size ] = result[ "position" ];
            data.temp_trace_data_colors[ data.temp_trace_data_colors.size ] = debug_color;
            data.temp_trace_data[ data.temp_trace_data.size ] = end_pos;
            data.temp_trace_data_colors[ data.temp_trace_data_colors.size ] = ( 0, 0, 0 );
        }
    }
    
    return trace::ray_trace( start_pos, end_pos, level.players, data.trace_contents );
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x5734939e, Offset: 0x422b
// Size: 0x144
function debug_node_array( node_array )
{
    level notify( #"hash_6e74951fef2bb8df" );
    level endon( #"hash_6e74951fef2bb8df" );
    data = debugdata();
    
    while ( true )
    {
        level waittill( #"start_array_debug" );
        
        if ( isdefined( data.trace_data[ getdvarint( @"hash_d11a371f8f8dec6e", 0 ) ] ) )
        {
            trace_data = data.trace_data[ getdvarint( @"hash_d11a371f8f8dec6e", 0 ) ];
            
            foreach ( index2, item in trace_data )
            {
                color = data.trace_data_colors[ getdvarint( @"hash_d11a371f8f8dec6e", 0 ) ][ index2 ];
                level thread draw_line_until_endons( item, color[ 0 ], color[ 1 ], color[ 2 ], [ "start_array_debug" ] );
                
                if ( index2 % 100 )
                {
                    waitframe();
                }
            }
            
            waitframe();
        }
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xe132ce41, Offset: 0x4377
// Size: 0x706
function reposition_cover_node()
{
    if ( !similar_nodes_nearby() )
    {
        return;
    }
    
    level notify( #"hash_87efa04949ed695c" );
    data = debugdata();
    starting_pos = data.origin;
    angles = data.angles;
    right = anglestoright( angles );
    left = anglestoleft( angles );
    forward = anglestoforward( angles );
    backward = -1 * anglestoforward( angles );
    up = anglestoup( angles );
    dir_array = [ left, right ];
    var_a798d5444ce37e6f = undefined;
    var_35bd50c12bbd0672 = undefined;
    var_b5163ff856a874b = undefined;
    data.found_left_edge = 0;
    data.found_right_edge = 0;
    data.found_up_edge = 0;
    data.found_exposed_pos = 0;
    data.wall_units = 0;
    data.temp_trace_data = [];
    data.found_valid_node_pos = 0;
    data.temp_trace_data_colors = [];
    
    if ( getdvarint( @"scr_save_trace_data", 0 ) )
    {
        data.save_trace_data = 1;
        data.temp_trace_data[ data.temp_trace_data.size ] = starting_pos;
        data.temp_trace_data_colors[ data.temp_trace_data_colors.size ] = ( 1, 1, 1 );
    }
    
    forward_trace = data.valid_forward_dist;
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( dir_array.size < 1 )
        {
            break;
        }
        
        for ( z = 0; z < dir_array.size ; z++ )
        {
            dir = dir_array[ z ];
            new_pos = starting_pos + dir * i * 32;
            
            if ( !can_spawn_capsule_trace( new_pos ) )
            {
                dir_array = arrayremove( dir_array, dir );
                continue;
            }
            
            first_result = create_node_trace( new_pos, new_pos + forward * forward_trace, ( 0, 1, 1 ) );
            
            if ( !trace_result_hits_surface( first_result ) )
            {
                data.found_valid_node_pos = 0;
                
                for ( j = 1; j < 32 ; j++ )
                {
                    valid_pos = new_pos + -1 * dir * j;
                    
                    if ( !can_spawn_capsule_trace( valid_pos ) )
                    {
                        dir_array = arrayremove( dir_array, dir );
                        continue;
                    }
                    
                    result = create_node_trace( valid_pos, valid_pos + forward * 24, ( 0, 1, 1 ) );
                    
                    if ( trace_result_hits_surface( result ) )
                    {
                        data.found_valid_node_pos = 1;
                        data.should_create_exposed_node = 0;
                        
                        if ( position_near_other_nodes( result[ "position" ] ) )
                        {
                            dir_array = arrayremove( dir_array, dir );
                            break;
                        }
                        
                        if ( dir == left )
                        {
                            if ( !data.found_left_edge && data.edge_placement )
                            {
                                if ( edge_point_valid( valid_pos, dir, forward ) )
                                {
                                    data.found_left_edge = 1;
                                    var_a798d5444ce37e6f = utility::drop_to_ground( result[ "position" ], 12, -300 );
                                    dir_array = arrayremove( dir_array, dir );
                                    break;
                                }
                                else
                                {
                                    dir_array = arrayremove( dir_array, dir );
                                    break;
                                }
                            }
                            
                            continue;
                        }
                        
                        if ( !data.found_right_edge && data.edge_placement )
                        {
                            if ( edge_point_valid( valid_pos, dir, forward ) )
                            {
                                data.found_right_edge = 1;
                                var_35bd50c12bbd0672 = utility::drop_to_ground( result[ "position" ], 12, -300 );
                                dir_array = arrayremove( dir_array, dir );
                                continue;
                            }
                            
                            dir_array = arrayremove( dir_array, dir );
                            break;
                        }
                    }
                }
                
                continue;
            }
            
            up_result = create_node_trace( first_result[ "position" ] + up * 28, first_result[ "position" ] + forward * data.valid_forward_dist + up * 28, ( 1, 0, 1 ) );
            
            if ( !data.found_up_edge && !trace_result_hits_surface( up_result ) && !position_near_other_nodes( up_result[ "position" ] ) && up_point_valid( first_result[ "position" ] + -1 * forward, [ left, right ], forward, up ) )
            {
                data.found_up_edge = 1;
                data.should_create_exposed_node = 0;
                var_b5163ff856a874b = utility::drop_to_ground( first_result[ "position" ], 12, -300 );
            }
        }
    }
    
    level notify( #"hash_5cb352d8b1d2edff" );
    
    if ( isdefined( var_a798d5444ce37e6f ) && data.found_left_edge )
    {
        final_pos = utility::drop_to_ground( var_a798d5444ce37e6f + backward * 17 + -1 * left * 16, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            new_pos = final_pos + up * 24;
            result = create_node_trace( new_pos, new_pos + forward * data.valid_forward_dist, ( 1, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                data.node_type = "node_cover_left";
            }
            else
            {
                data.node_type = "node_cover_crouch";
            }
            
            run_path_node_removal();
        }
    }
    
    if ( isdefined( var_35bd50c12bbd0672 ) && data.found_right_edge )
    {
        final_pos = utility::drop_to_ground( var_35bd50c12bbd0672 + backward * 17 + -1 * right * 16, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            new_pos = final_pos + up * 24;
            result = create_node_trace( new_pos, new_pos + forward * 64, ( 1, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                data.node_type = "node_cover_right";
            }
            else
            {
                data.node_type = "node_cover_crouch";
            }
            
            run_path_node_removal();
        }
    }
    
    if ( isdefined( var_b5163ff856a874b ) && data.found_up_edge && !data.found_right_edge && !data.found_left_edge )
    {
        final_pos = utility::drop_to_ground( var_b5163ff856a874b + backward * 17, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            data.node_type = "node_cover_crouch";
            run_path_node_removal();
        }
    }
    
    data.save_trace_data = 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x84197f1d, Offset: 0x4a85
// Size: 0x692
function simple_reposition_node()
{
    if ( !similar_nodes_nearby() )
    {
        return;
    }
    
    level notify( #"hash_87efa04949ed695c" );
    data = debugdata();
    starting_pos = data.origin;
    angles = data.angles;
    right = anglestoright( angles );
    left = anglestoleft( angles );
    forward = anglestoforward( angles );
    backward = -1 * anglestoforward( angles );
    up = anglestoup( angles );
    
    if ( data.node_type == "node_cover_left" )
    {
        dir_array = [ left ];
    }
    else
    {
        dir_array = [ right ];
    }
    
    var_a798d5444ce37e6f = undefined;
    var_35bd50c12bbd0672 = undefined;
    var_b5163ff856a874b = undefined;
    data.found_left_edge = 0;
    data.found_right_edge = 0;
    data.found_up_edge = 0;
    data.found_exposed_pos = 0;
    data.wall_units = 0;
    data.temp_trace_data = [];
    data.found_valid_node_pos = 0;
    data.temp_trace_data_colors = [];
    forward_trace = data.valid_forward_dist;
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( dir_array.size < 1 )
        {
            break;
        }
        
        for ( z = 0; z < dir_array.size ; z++ )
        {
            dir = dir_array[ z ];
            new_pos = starting_pos + dir * i * 32;
            
            if ( !can_spawn_capsule_trace( new_pos ) )
            {
                dir_array = arrayremove( dir_array, dir );
                continue;
            }
            
            first_result = create_node_trace( new_pos, new_pos + forward * forward_trace, ( 0, 1, 1 ) );
            
            if ( !trace_result_hits_surface( first_result ) )
            {
                data.found_valid_node_pos = 0;
                
                for ( j = 1; j < 32 ; j++ )
                {
                    valid_pos = new_pos + -1 * dir * j;
                    
                    if ( !can_spawn_capsule_trace( valid_pos ) )
                    {
                        dir_array = arrayremove( dir_array, dir );
                        continue;
                    }
                    
                    result = create_node_trace( valid_pos, valid_pos + forward * 24, ( 0, 1, 1 ) );
                    
                    if ( trace_result_hits_surface( result ) )
                    {
                        data.found_valid_node_pos = 1;
                        data.should_create_exposed_node = 0;
                        
                        if ( dir == left )
                        {
                            if ( !data.found_left_edge && data.edge_placement )
                            {
                                if ( edge_point_valid( valid_pos, dir, forward ) )
                                {
                                    data.found_left_edge = 1;
                                    var_a798d5444ce37e6f = utility::drop_to_ground( result[ "position" ], 12, -300 );
                                    dir_array = arrayremove( dir_array, dir );
                                    break;
                                }
                                else
                                {
                                    dir_array = arrayremove( dir_array, dir );
                                    break;
                                }
                            }
                            
                            continue;
                        }
                        
                        if ( !data.found_right_edge && data.edge_placement )
                        {
                            if ( edge_point_valid( valid_pos, dir, forward ) )
                            {
                                data.found_right_edge = 1;
                                var_35bd50c12bbd0672 = utility::drop_to_ground( result[ "position" ], 12, -300 );
                                dir_array = arrayremove( dir_array, dir );
                                continue;
                            }
                            
                            dir_array = arrayremove( dir_array, dir );
                            break;
                        }
                    }
                }
                
                continue;
            }
            
            up_result = create_node_trace( first_result[ "position" ] + up * 28, first_result[ "position" ] + forward * data.valid_forward_dist + up * 28, ( 1, 0, 1 ) );
            
            if ( !data.found_up_edge && !trace_result_hits_surface( up_result ) && up_point_valid( first_result[ "position" ] + -1 * forward, [ left, right ], forward, up ) )
            {
                data.found_up_edge = 1;
                data.should_create_exposed_node = 0;
                var_b5163ff856a874b = utility::drop_to_ground( first_result[ "position" ], 12, -300 );
            }
        }
    }
    
    level notify( #"hash_5cb352d8b1d2edff" );
    
    if ( isdefined( var_a798d5444ce37e6f ) && data.found_left_edge )
    {
        final_pos = utility::drop_to_ground( var_a798d5444ce37e6f + backward * 17 + -1 * left * 16, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            new_pos = final_pos + up * 24;
            result = create_node_trace( new_pos, new_pos + forward * data.valid_forward_dist, ( 1, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                data.node_type = "node_cover_left";
            }
            else
            {
                data.node_type = "node_cover_crouch";
            }
            
            run_path_node_removal();
        }
    }
    
    if ( isdefined( var_35bd50c12bbd0672 ) && data.found_right_edge )
    {
        final_pos = utility::drop_to_ground( var_35bd50c12bbd0672 + backward * 17 + -1 * right * 16, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            new_pos = final_pos + up * 24;
            result = create_node_trace( new_pos, new_pos + forward * 64, ( 1, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                data.node_type = "node_cover_right";
            }
            else
            {
                data.node_type = "node_cover_crouch";
            }
            
            run_path_node_removal();
        }
    }
    
    if ( isdefined( var_b5163ff856a874b ) && data.found_up_edge && !data.found_right_edge && !data.found_left_edge )
    {
        final_pos = utility::drop_to_ground( var_b5163ff856a874b + backward * 17, 16, -300 ) + ( 0, 0, 16 );
        
        if ( can_spawn_capsule_trace( final_pos ) && !trace_for_stairs() )
        {
            data.origin = final_pos;
            data.node_type = "node_cover_crouch";
            run_path_node_removal();
        }
    }
    
    data.save_trace_data = 0;
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x1b37a65, Offset: 0x511f
// Size: 0xc
function find_final_position( pos )
{
    
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x1af88c67, Offset: 0x5133
// Size: 0x3, Type: bool
function trace_for_stairs()
{
    return false;
}

// Namespace create_cover_nodes
// Params 3
// Checksum 0xa1e255fe, Offset: 0x513f
// Size: 0x12f
function edge_point_valid( starting_pos, dir, forward )
{
    data = debugdata();
    
    for ( i = 32; i > 0 ; i-- )
    {
        new_pos = starting_pos + -1 * dir * i;
        
        if ( !can_spawn_capsule_trace( new_pos ) )
        {
            break;
        }
        
        result = create_node_trace( new_pos, new_pos + forward * 24, ( 0, 1, 0 ) );
        
        if ( trace_result_hits_surface( result ) )
        {
            data.wall_units++;
        }
    }
    
    if ( data.wall_units >= data.wall_units_required )
    {
        for ( j = 32; j > 0 ; j-- )
        {
            new_pos = starting_pos + dir * j;
            
            if ( !can_spawn_capsule_trace( new_pos ) )
            {
                return 0;
            }
            
            result = create_node_trace( new_pos, new_pos + forward * data.valid_forward_dist, ( 0, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                return 0;
            }
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 4
// Checksum 0x36e05024, Offset: 0x5276
// Size: 0x1a8
function up_point_valid( starting_pos, dirs, forward, up )
{
    data = debugdata();
    directions = dirs;
    
    for ( i = 32; i > 0 ; i-- )
    {
        for ( j = 0; j < directions.size ; j++ )
        {
            dir = directions[ j ];
            new_pos = starting_pos + -1 * dir * i;
            result = create_node_trace( new_pos, new_pos + forward * 24, ( 0, 1, 0 ) );
            
            if ( !trace_result_hits_surface( result ) )
            {
                data.wall_units++;
                
                if ( data.wall_units >= data.wall_units_required )
                {
                    break;
                }
                
                continue;
            }
        }
    }
    
    directions = dirs;
    data.wall_units = 0;
    
    for ( j = 32; j > 0 ; j-- )
    {
        for ( i = 0; i < directions.size ; i++ )
        {
            dir = directions[ i ];
            new_pos = starting_pos + dir * j + up * 28;
            result = create_node_trace( new_pos, new_pos + forward * data.valid_forward_dist, ( 0, 1, 0 ) );
            
            if ( trace_result_hits_surface( result ) )
            {
                continue;
            }
            
            data.wall_units++;
        }
    }
    
    if ( data.wall_units >= data.wall_units_required )
    {
        return 1;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x845aeaed, Offset: 0x5426
// Size: 0x48
function attempt_throttle()
{
    data = debugdata();
    data.throttle_counter++;
    
    if ( data.throttle_counter >= data.create_node_throttle )
    {
        data.throttle_counter = 0;
        waitframe();
    }
}

// Namespace create_cover_nodes
// Params 2
// Checksum 0x2f912c4f, Offset: 0x5476
// Size: 0x84
function trace_result_hits_surface( result, normal )
{
    data = debugdata();
    
    if ( isdefined( result[ "position" ] ) && result[ "fraction" ] < 1 && result[ "fraction" ] > 0 )
    {
        if ( isdefined( normal ) )
        {
            if ( isdefined( result[ "normal" ] ) )
            {
                if ( normal == result[ "normal" ] )
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 1;
            }
        }
        else
        {
            return 1;
        }
        
        return;
    }
    
    return 0;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0x7164f462, Offset: 0x5502
// Size: 0xa6
function open_and_write_to_paths_map()
{
    data = debugdata();
    
    if ( !utility::flag( "file_opened" ) )
    {
        utility::flag_set( "file_opened" );
        data.aa_status = "adding_nodes_to_map";
        utility::fileprint_launcher_start_file();
        tab = "\t";
        entcounter = 0;
        utility::fileprint_launcher( "iwmap 11" );
        utility::fileprint_launcher( tab + "entity " + entcounter );
        utility::fileprint_launcher( "{" );
        utility::fileprint_launcher( tab + "\"classname\" \"worldspawn\"" );
        utility::fileprint_launcher( "}" );
    }
}

// Namespace create_cover_nodes
// Params 2
// Checksum 0xadb21755, Offset: 0x55b0
// Size: 0x104
function draw_closest_wall_points( player, new_array )
{
    level endon( #"game_ended" );
    level notify( #"hash_7c105a827263669a" );
    level endon( #"hash_7c105a827263669a" );
    player endon( #"use" );
    player endon( #"disconnect" );
    data = debugdata();
    
    while ( true )
    {
        player notify( #"hash_215e46e77d7df1ad" );
        closest_node_points = utility::get_array_of_closest( player.origin, new_array, undefined, 50 );
        
        foreach ( item in closest_node_points )
        {
        }
        
        wait 1;
    }
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xab3fb276, Offset: 0x56bc
// Size: 0x257
function run_path_node_removal()
{
    level endon( #"game_ended" );
    level endon( #"get_nav_start_points" );
    data = debugdata();
    
    if ( !position_near_other_nodes( data.origin ) )
    {
        struct = spawnstruct();
        struct.angles = data.angles;
        struct.origin = data.origin;
        data.all_node_positions[ data.all_node_positions.size ] = struct;
        
        if ( getdvarint( @"scr_save_trace_data", 0 ) )
        {
            data.trace_data[ data.map_ent_index ] = data.temp_trace_data;
            data.trace_data_colors[ data.map_ent_index ] = data.temp_trace_data_colors;
        }
        
        data.should_create_exposed_node = 0;
        write_struct_to_map();
        
        if ( data.debug_boxes )
        {
            /#
                color = ( 1, 1, 1 );
                
                switch ( data.node_type )
                {
                    case #"hash_654dcfd19e2fb184":
                        color = ( 0, 1, 1 );
                        break;
                    case #"hash_2b53bf52604ebb4":
                        color = ( 1, 1, 0 );
                        break;
                    case #"hash_921313ec71ea472b":
                        color = ( 0.9, 0.6, 0 );
                        break;
                    default:
                        color = ( 1, 1, 1 );
                        break;
                }
                
                if ( data.debug_boxes_max_count )
                {
                    data.debug_boxes_count++;
                    
                    if ( data.debug_boxes_count >= data.debug_boxes_max_count )
                    {
                        data.debug_boxes_count = 0;
                    }
                    
                    level thread draw_box( data.origin, color, data.angles, 32, 1, 1, "<dev string:x796>" + data.debug_boxes_count );
                    return;
                }
                
                level thread draw_box( data.origin, color, data.angles, 32, 1, 1 );
            #/
        }
    }
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xf8177ead, Offset: 0x591b
// Size: 0x14b, Type: bool
function position_near_other_nodes( position )
{
    data = debugdata();
    data.density_cap_count = 0;
    
    if ( data.use_bsp_nodes )
    {
        all_nodes = getallnodes();
        
        for ( i = 0; i < all_nodes.size ; i++ )
        {
            other_node = all_nodes[ i ];
            
            if ( other_node.origin == position )
            {
                return true;
            }
            
            comp_dist = distancesquared( position, other_node.origin );
            
            if ( comp_dist <= 576 )
            {
                return true;
            }
        }
    }
    
    temp_array = data.all_node_positions;
    
    for ( i = 0; i < temp_array.size ; i++ )
    {
        other_struct = temp_array[ i ];
        
        if ( other_struct.origin == position )
        {
            return true;
        }
        
        comp_dist = distancesquared( position, other_struct.origin );
        
        if ( comp_dist <= 256 )
        {
            return true;
        }
        
        if ( comp_dist <= data.density_radius )
        {
            data.density_cap_count++;
            
            if ( data.density_cap_count >= data.density_cap )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace create_cover_nodes
// Params 0
// Checksum 0xbfb4cace, Offset: 0x5a6f
// Size: 0x15c
function write_struct_to_map()
{
    data = debugdata();
    tab = "\t";
    utility::fileprint_launcher( "entity " + data.map_ent_index );
    utility::fileprint_launcher( "{" );
    utility::fileprint_launcher( tab + "\"origin\" \"" + data.origin[ 0 ] + " " + data.origin[ 1 ] + " " + data.origin[ 2 ] + "\"" );
    
    if ( isdefined( data.node_type ) )
    {
        utility::fileprint_launcher( tab + "\"classname\" \"" + data.node_type + "\"" );
    }
    else
    {
        utility::fileprint_launcher( tab + "\"classname\" \"node_cover_left\"" );
    }
    
    if ( isdefined( data.angles ) )
    {
        utility::fileprint_launcher( tab + "\"angles\" \"" + data.angles[ 0 ] + " " + data.angles[ 1 ] + " " + data.angles[ 2 ] + "\"" );
    }
    else
    {
        utility::fileprint_launcher( tab + "\"angles\" \"0 0 0\"" );
    }
    
    utility::fileprint_launcher( "}" );
    data.map_ent_index++;
}

// Namespace create_cover_nodes
// Params 5
// Checksum 0x7b1fcdb6, Offset: 0x5bd3
// Size: 0xfb
function draw_line_until_endons( org1, r, g, b, end_string_array )
{
    self endon( #"death" );
    data = debugdata();
    
    if ( isdefined( end_string_array ) )
    {
        if ( isarray( end_string_array ) )
        {
            foreach ( end_string in end_string_array )
            {
                self endon( end_string );
            }
        }
        else
        {
            self endon( end_string_array );
        }
    }
    
    /#
        while ( true )
        {
            line( org1, org1 + ( 0, 0, 128 ), ( r, g, b ), 1 );
            waitframe();
        }
    #/
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0x243e4ff2, Offset: 0x5cd6
// Size: 0x16
function addentrytodevgui( command )
{
    level thread addentrytodevgui_internal( command );
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xff03e17d, Offset: 0x5cf4
// Size: 0x192
function addentrytodevgui_internal( command )
{
    /#
        level endon( #"game_ended" );
        wait 5;
        final_command = "<dev string:x7a6>";
        toks = strtok( command, "<dev string:x7a7>" );
        space = "<dev string:x7a9>";
        num_toks = 0;
        
        foreach ( tok in toks )
        {
            new_toks = strtok( tok, "<dev string:x7a9>" );
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
                final_command += "<dev string:x7a7>";
            }
        }
        
        adddebugcommand( final_command );
    #/
}

// Namespace create_cover_nodes
// Params 1
// Checksum 0xba26d3a0, Offset: 0x5e8e
// Size: 0x27
function can_spawn_capsule_trace( pos )
{
    return trace::capsule_trace_passed( pos + ( 0, 0, 32 ), pos, 16, 32 );
}

/#

    // Namespace create_cover_nodes
    // Params 2
    // Checksum 0xb5de5f73, Offset: 0x5ebe
    // Size: 0x76, Type: dev
    function debug_activation( dvar, action_func )
    {
        level endon( #"host_migration_begin" );
        setdevdvarifuninitialized( dvar, "<dev string:x7a6>" );
        
        while ( true )
        {
            result = getdvar( dvar );
            
            if ( result != "<dev string:x7a6>" )
            {
                [[ action_func ]]( result );
                wait 0.05;
                setdvar( dvar, "<dev string:x7a6>" );
                continue;
            }
            
            wait 0.25;
        }
    }

    // Namespace create_cover_nodes
    // Params 1
    // Checksum 0x32a19a99, Offset: 0x5f3c
    // Size: 0x235, Type: dev
    function function_2a1d781434204e17( itemref )
    {
        items = strtok( itemref, "<dev string:x7ab>" );
        playertoks = strtok( itemref, "<dev string:x7ad>" );
        player = undefined;
        
        if ( playertoks.size > 1 )
        {
            playerint = int( playertoks[ 0 ] );
            player = level.players[ playerint ];
        }
        
        switch ( items[ 0 ] )
        {
            case #"hash_334c896e25dc8345":
                level thread run_single_grid_point_test( level.players[ 0 ] );
                break;
            case #"hash_21387f6c1b328312":
                level thread place_path_nodes_within_box( level.players[ 0 ] );
                break;
            case #"hash_c6614888e37e0f66":
                if ( !isdefined( player ) )
                {
                    player = level.players[ 0 ];
                }
                
                data = debugdata();
                data.origin = player.origin;
                data.angles = player.angles;
                
                if ( trace_for_stairs() )
                {
                    iprintlnbold( "<dev string:x7be>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x7cc>" );
                }
                
                break;
            case #"hash_7e6fe08ccd73133c":
                close_map_write();
                break;
            case #"hash_b98a762ec515c13":
                level thread place_path_nodes_within_radius( level.players[ 0 ] );
                break;
            case #"hash_5ce6985bbb61c2d3":
                level thread place_path_node_from_lookat( level.players[ 0 ] );
                break;
            case #"hash_fe14da3695b88dc":
                level thread place_path_nodes( level.players[ 0 ] );
                break;
            case #"hash_c6514c88e37149bf":
                level notify( #"start_array_debug" );
                break;
            case #"hash_23d3b48a2fabf145":
                level notify( #"hash_bf5f426b063a9323" );
                break;
            case #"hash_a6f2bc30ca30e75d":
                level thread remove_similar_nodes( level.players[ 0 ] );
                break;
            case #"hash_e9d9f0b8daba731e":
                clean_up_nodes();
                break;
            default:
                break;
        }
    }

    // Namespace create_cover_nodes
    // Params 7
    // Checksum 0xb7fe86a4, Offset: 0x6179
    // Size: 0x18e, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest, endon_string )
    {
        data = debugdata();
        data.player endon( #"disconnect" );
        data.player endon( #"use" );
        
        if ( isdefined( endon_string ) )
        {
            data.player notify( endon_string );
            data.player endon( endon_string );
        }
        
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        start = pos + forward * size * 0.5;
        start += right * size * 0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * size;
        
        while ( true )
        {
            orientedbox( pos, ( 32, 32, 32 ), angles, color, 1, 1 );
            waitframe();
        }
    }

#/
