// scripts\mp\action_park_utility.gsc  (hash_405f357b051e0bc8.gscc) (size: 20214 Bytes / 0x4ef6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x301d3513 (807220499)
// size ...... 20214 (0x4ef6)
// includes .. 8   (offset: 0x478e)
// strings ... 99  (offset: 0x47ce)
// dev strs .. 11  (offset: 0x4e6a)
// exports ... 41  (offset: 0x32ba)
// cseg ...... 0xbfc + 0x26be (0x32ba)
// imports ... 113 (offset: 0x3922)
// animtree1 . 0   (offset: 0x4ef6)
// animtree2 . 0   (offset: 0x4ef6)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\spawnlogic;

#namespace action_park_utility;

// Namespace action_park_utility
// Params 0, eflags: 0x5
// Checksum 0xc3ccb91, Offset: 0xc1a
// Size: 0x182
function private autoexec __autoexec__()
{
    var_c584793a50e5de07 = hashcat( %"hash_7f29fab305ee59e4", level.mapinfobundle.mapname + "_apconfig" );
    var_262ff90ef3db112 = getscriptbundle( var_c584793a50e5de07 );
    
    if ( !var_262ff90ef3db112 )
    {
        logstring( "[ACTION PARK] " + "action_park_utility::__autoexec__" + ": " + "Failed to find actionparkmapdata bundle => " + var_c584793a50e5de07 );
        return;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_a50342fdfb6e3610", 1 );
        thread function_820edf9e4e15c54();
        thread function_9ed3e34c871b1e14();
    #/
    
    initialize_combo_data( var_262ff90ef3db112 );
    filter_inactive_entities();
    initialize_exterior_periph();
    initialize_oob_triggers();
    function_3ba258de774f7ff6();
    level.var_c0dd81d8b3b40fed = 1;
    level.var_ecc9a5fdfad46e14 = 1;
    callback::add( #"player_connect_start", &on_player_connect_start );
    spawnlogic::function_1c46bb1cf817b81c( #"hash_4ea6dfc8e7bb2936", &function_35b7f7f899261a9b );
    utility::registersharedfunc( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580", &get_combo_label );
    var_bd61d7d1d2ae3bb5 = function_ebbb3388880ace1d();
    setomnvar( "ui_dev_action_park_combo_index", get_combo_id() );
    setomnvar( "ui_dev_action_park_combo_left_index", var_bd61d7d1d2ae3bb5.left_index );
    setomnvar( "ui_dev_action_park_combo_center_index", var_bd61d7d1d2ae3bb5.center_index );
    setomnvar( "ui_dev_action_park_combo_right_index", var_bd61d7d1d2ae3bb5.right_index );
    flags::initlevelflags();
    flags::levelflaginit( "action_park_utility_initialized", 1 );
}

// Namespace action_park_utility
// Params 0
// Checksum 0x1be07cb, Offset: 0xda4
// Size: 0x1c, Type: bool
function is_enabled()
{
    return flags::function_6125c2f37d92dee( "action_park_utility_initialized" ) && flags::levelflag( "action_park_utility_initialized" );
}

// Namespace action_park_utility
// Params 1
// Checksum 0x58fd042c, Offset: 0xdc9
// Size: 0x2b
function get_combo_id( var_5cfe216327d3e91b )
{
    combo_data = get_combo_data( var_5cfe216327d3e91b );
    return combo_data.id;
}

// Namespace action_park_utility
// Params 1
// Checksum 0x9f5a8dd6, Offset: 0xdfd
// Size: 0x2b
function get_combo_label( var_5cfe216327d3e91b )
{
    combo_data = get_combo_data( var_5cfe216327d3e91b );
    return combo_data.label;
}

// Namespace action_park_utility
// Params 1
// Checksum 0x1e2d82fa, Offset: 0xe31
// Size: 0x2b
function get_combo_origin( var_5cfe216327d3e91b )
{
    combo_data = get_combo_data( var_5cfe216327d3e91b );
    return combo_data.origin;
}

// Namespace action_park_utility
// Params 1
// Checksum 0xca249009, Offset: 0xe65
// Size: 0x2b
function function_412fb68a48a53304( var_5cfe216327d3e91b )
{
    combo_data = get_combo_data( var_5cfe216327d3e91b );
    return combo_data.district_name;
}

// Namespace action_park_utility
// Params 1
// Checksum 0xfd54290b, Offset: 0xe99
// Size: 0x2b
function function_ebbb3388880ace1d( var_5cfe216327d3e91b )
{
    combo_data = get_combo_data( var_5cfe216327d3e91b );
    return combo_data.slab_data;
}

// Namespace action_park_utility
// Params 1
// Checksum 0xc429dd23, Offset: 0xecd
// Size: 0x2c
function function_c576bfbce27d7270( var_5cfe216327d3e91b )
{
    var_e5fd94d51e5762ee = function_a68a3dd70f4c7eb0( var_5cfe216327d3e91b );
    
    if ( var_e5fd94d51e5762ee )
    {
        return getxhash( var_e5fd94d51e5762ee );
    }
}

// Namespace action_park_utility
// Params 1
// Checksum 0x2443697f, Offset: 0xf02
// Size: 0xe1
function function_a68a3dd70f4c7eb0( var_5cfe216327d3e91b )
{
    if ( !level.var_545cb88c1a6ca273 )
    {
        return;
    }
    
    if ( !var_5cfe216327d3e91b )
    {
        return level.var_545cb88c1a6ca273.script_parameters;
    }
    
    combo_label = get_combo_label( var_5cfe216327d3e91b );
    
    foreach ( var_9bd2e34860b0d301 in utility::getstructarray( "arena_periph_origin", "targetname" ) )
    {
        if ( getxhash( var_9bd2e34860b0d301.script_noteworthy ) != combo_label )
        {
            continue;
        }
        
        return var_9bd2e34860b0d301.script_parameters;
    }
}

// Namespace action_park_utility
// Params 0
// Checksum 0xbe814c79, Offset: 0xfec
// Size: 0x26
function get_combo_index()
{
    if ( game[ #"action_park_utility" ] )
    {
        return game[ #"action_park_utility" ].combo_index;
    }
}

// Namespace action_park_utility
// Params 0
// Checksum 0xd929758d, Offset: 0x101b
// Size: 0xd
function function_7e663773e83336cd()
{
    return flags::gameflagexists( "action_park_cycling_next_combo" );
}

// Namespace action_park_utility
// Params 0
// Checksum 0x98554c02, Offset: 0x1031
// Size: 0x17
function function_e7058081c059c262()
{
    if ( function_7e663773e83336cd() )
    {
        flags::gameflagwait( "action_park_cycling_next_combo" );
    }
}

// Namespace action_park_utility
// Params 1
// Checksum 0x1447bb55, Offset: 0x1050
// Size: 0x28
function function_fd32c02a56ebd02d( player )
{
    if ( player.var_b660cc1baffd76e8 )
    {
        player waittill( #"hash_fd6047a5ddfdd8de" );
    }
}

// Namespace action_park_utility
// Params 0
// Checksum 0x758850bf, Offset: 0x1080
// Size: 0x30
function try_cycle_next_combo()
{
    if ( !function_adef85cc33621725() )
    {
        logstring( "[ACTION PARK] " + "action_park_utility::try_cycle_next_combo" + ": " + "Failed to cycle next combo" );
        return;
    }
    
    force_cycle_next_combo();
}

// Namespace action_park_utility
// Params 0
// Checksum 0xaeef4af4, Offset: 0x10b8
// Size: 0x183
function force_cycle_next_combo()
{
    prev_combo_index = game[ #"action_park_utility" ].combo_index;
    
    if ( function_ff90a833114ba0e4() )
    {
        combo_string = function_a6b92c710e6eec16();
        game[ #"action_park_utility" ].combo_index = function_d2083e2861a5afda( combo_string );
        function_c29636d7088d320a( combo_string );
    }
    else
    {
        game[ #"action_park_utility" ].combo_index++;
        
        if ( game[ #"action_park_utility" ].combo_index >= game[ #"action_park_utility" ].combo_list.size )
        {
            if ( game[ #"action_park_utility" ].randomize )
            {
                game[ #"action_park_utility" ].combo_list = randomize_combo_list( game[ #"action_park_utility" ].combo_list );
            }
            
            game[ #"action_park_utility" ].combo_index = 0;
        }
    }
    
    flags::gameflaginit( "action_park_cycling_next_combo", 0 );
    logstring( "[ACTION PARK] " + "action_park_utility::force_cycle_next_combo" + ": " + "The combo will cycle from index " + prev_combo_index + " to index " + get_combo_index() + " next round" );
    logstring( "[ACTION PARK] " + "action_park_utility::force_cycle_next_combo" + ": " + "The combo will cycle from " + get_combo_label( prev_combo_index ) + " to " + get_combo_label() + " next round" );
    district_streaming_update();
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0x34035999, Offset: 0x1243
// Size: 0x4a
function private get_combo_data( var_5cfe216327d3e91b )
{
    if ( game[ #"action_park_utility" ] )
    {
        index = var_5cfe216327d3e91b ?? get_combo_index();
        return game[ #"action_park_utility" ].combo_list[ index ];
    }
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0x1c7adf73, Offset: 0x1296
// Size: 0x3cf
function private initialize_combo_data( var_262ff90ef3db112 )
{
    if ( game[ #"action_park_utility" ] )
    {
        logstring( "[ACTION PARK] " + "action_park_utility::initialize_combo_data" + ": " + "Already initialized... skipping" );
        return;
    }
    
    combo_origins = [];
    
    foreach ( entity in getentarray() )
    {
        if ( !entity.script_noteworthy || !issubstr( entity.script_noteworthy, "multi_arena_map_" ) )
        {
            continue;
        }
        
        if ( entity.classname == "mp_global_intermission" )
        {
            combo_origins[ getxhash( entity.script_noteworthy ) ] = entity.origin;
        }
    }
    
    game[ #"action_park_utility" ] = {};
    game[ #"action_park_utility" ].combo_list = [];
    combo_index_range = get_combo_index_range( var_262ff90ef3db112 );
    
    for ( i = combo_index_range[ 0 ]; i <= combo_index_range[ 1 ] ; i++ )
    {
        combo_label = hashcat( #"multi_arena_map_", i );
        combo_struct = { #slab_data:{ #right_index:var_262ff90ef3db112.combinations[ i ].rightslab.index, #center_index:var_262ff90ef3db112.combinations[ i ].var_8922be80a24e11a3.index, #left_index:var_262ff90ef3db112.combinations[ i ].var_8ab089e384502aaf.index }, #district_name:var_262ff90ef3db112.combinations[ i ].districtname, #origin:combo_origins[ combo_label ], #label:combo_label, #id:i };
        game[ #"action_park_utility" ].combo_list[ game[ #"action_park_utility" ].combo_list.size ] = combo_struct;
    }
    
    if ( var_262ff90ef3db112.var_bb7b23371e56ba84 )
    {
        game[ #"action_park_utility" ].var_698d68a61e8da793 = { #var_78f0f63e7166815b:0, #length:var_262ff90ef3db112.var_fdcc6db81f044a11 };
    }
    
    if ( function_ff90a833114ba0e4() )
    {
        combo_string = function_a6b92c710e6eec16();
        game[ #"action_park_utility" ].combo_index = function_d2083e2861a5afda( combo_string );
        function_c29636d7088d320a( combo_string );
    }
    else if ( var_262ff90ef3db112.var_b63e1bcf34eac369 )
    {
        game[ #"action_park_utility" ].combo_index = 0;
        
        if ( var_262ff90ef3db112.var_b63e1bcf34eac369 )
        {
            game[ #"action_park_utility" ].combo_list = randomize_combo_list( game[ #"action_park_utility" ].combo_list );
            game[ #"action_park_utility" ].randomized = 1;
        }
    }
    
    logstring( "[ACTION PARK] " + "action_park_utility::initialize_combo_data" + ": " + "Initialized with combo index " + game[ #"action_park_utility" ].combo_index );
    logstring( "[ACTION PARK] " + "action_park_utility::initialize_combo_data" + ": " + "Initialized with combo " + get_combo_label() );
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0x1ac9166e, Offset: 0x166d
// Size: 0x17d
function private filter_inactive_entities()
{
    active_combos = [];
    count = 0;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        flags::function_b0491bb92d5acbb6( "gaminstanceDataSet" );
        
        foreach ( index in gameinstance::get_active_arenas() )
        {
            active_combos[ active_combos.size ] = get_combo_label( index );
        }
    }
    else
    {
        active_combos[ active_combos.size ] = get_combo_label();
    }
    
    foreach ( entity in getentarray() )
    {
        if ( entity.script_noteworthy && !arraycontains( active_combos, getxhash( entity.script_noteworthy ) ) )
        {
            entity delete();
            count++;
        }
    }
    
    logstring( "[ACTION PARK] " + "action_park_utility::filter_inactive_entities" + ": " + count + " inactive entities removed" );
}

/#

    // Namespace action_park_utility
    // Params 1, eflags: 0x4
    // Checksum 0x2e380cd8, Offset: 0x17f2
    // Size: 0xee, Type: dev
    function private function_727d9578b0c678c4( var_545cb88c1a6ca273 )
    {
        if ( isofflinetoolrun( 1 ) )
        {
            loop_index = 0;
            
            foreach ( var_9bd2e34860b0d301 in utility::getstructarray( "<dev string:x24>", "<dev string:x38>" ) )
            {
                var_8ac53f5c8a21da8f = function_412fb68a48a53304( loop_index );
                println( "<dev string:x43>" + loop_index + "<dev string:x5d>" + var_9bd2e34860b0d301.origin + "<dev string:x65>" + var_8ac53f5c8a21da8f );
                function_a628d1f117a53d95( var_9bd2e34860b0d301.origin );
                loop_index++;
            }
            
            function_e0dcff187ee18624( var_545cb88c1a6ca273 );
        }
    }

#/

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0x60a37ee3, Offset: 0x18e8
// Size: 0x167
function private initialize_exterior_periph()
{
    if ( getdvarint( @"hash_26b68c3e2860620a", 0 ) != 0 )
    {
        return;
    }
    
    combo_label = get_combo_label();
    
    foreach ( var_9bd2e34860b0d301 in utility::getstructarray( "arena_periph_origin", "targetname" ) )
    {
        if ( getxhash( var_9bd2e34860b0d301.script_noteworthy ) != combo_label )
        {
            continue;
        }
        
        level.var_545cb88c1a6ca273 = spawn( "script_model", var_9bd2e34860b0d301.origin );
        level.var_545cb88c1a6ca273.angles = ( 0, 0, 0 );
        level.var_545cb88c1a6ca273.script_parameters = var_9bd2e34860b0d301.script_parameters;
        level.var_545cb88c1a6ca273 setmodel( %"mp_rex_actionpark_vista_xcomposite_01" );
        logstring( "[ACTION PARK] " + "action_park_utility::initialize_exterior_periph" + ": " + "Exterior periph found at " + var_9bd2e34860b0d301.origin );
        break;
    }
    
    /#
        function_727d9578b0c678c4( level.var_545cb88c1a6ca273 );
    #/
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0x551815e1, Offset: 0x1a57
// Size: 0x3af
function private initialize_oob_triggers()
{
    foreach ( oob_trigger in getentarray( "OutOfBounds", "targetname" ) )
    {
        oob_trigger delete();
    }
    
    level.outofboundstriggers = [];
    
    foreach ( minimap_volume in getnoentvolumearray( "noent_volume_minimap", #classname ) )
    {
        if ( getxhash( minimap_volume.script_noteworthy ) != get_combo_label() )
        {
            continue;
        }
        
        center_x = minimap_volume.origin[ 0 ];
        center_y = minimap_volume.origin[ 1 ];
        center_z = minimap_volume.origin[ 2 ];
        left_center = ( center_x - 1950 - 6144, center_y, center_z );
        left_size = ( 6144, 7204, 12288 );
        oob_left = spawn( "trigger_box", left_center, 0, left_size, left_size );
        oob_left.targetname = "OutOfBounds";
        level.outofboundstriggers[ level.outofboundstriggers.size ] = oob_left;
        right_center = ( center_x + 1950 + 6144, center_y, center_z );
        right_size = ( 6144, 7204, 1060 );
        oob_right = spawn( "trigger_box", right_center, 0, right_size, right_size );
        oob_right.targetname = "OutOfBounds";
        level.outofboundstriggers[ level.outofboundstriggers.size ] = oob_right;
        top_center = ( center_x, center_y + 1060 + 6144, center_z );
        top_size = ( 8094, 6144, 1060 );
        oob_top = spawn( "trigger_box", top_center, 0, top_size, top_size );
        oob_top.targetname = "OutOfBounds";
        level.outofboundstriggers[ level.outofboundstriggers.size ] = oob_top;
        bottom_center = ( center_x, center_y - 1060 - 6144, center_z );
        bottom_size = ( 8094, 6144, 1060 );
        oob_bottom = spawn( "trigger_box", bottom_center, 0, bottom_size, bottom_size );
        oob_bottom.targetname = "OutOfBounds";
        level.outofboundstriggers[ level.outofboundstriggers.size ] = oob_bottom;
        ceiling_center = ( center_x, center_y, center_z + 1200 + 3072 );
        ceiling_size = ( 1950, 1060, 3072 );
        oob_ceiling = spawn( "trigger_box", ceiling_center, 0, ceiling_size, ceiling_size );
        oob_ceiling.targetname = "OutOfBounds";
        level.outofboundstriggers[ level.outofboundstriggers.size ] = oob_ceiling;
        logstring( "[ACTION PARK] " + "action_park_utility::initialize_oob_triggers" + ": " + "OOB triggers initialized" );
        break;
    }
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0xc7a362da, Offset: 0x1e0e
// Size: 0x1d8
function private function_3ba258de774f7ff6()
{
    combo_label = get_combo_label();
    var_1a21d1cc9149be20 = utility::getstructarray( "infil_door_attackers", "targetname" );
    var_503bbe0a31f23bc4 = utility::getstructarray( "infil_door_defenders", "targetname" );
    
    foreach ( infil_door_struct in var_1a21d1cc9149be20 )
    {
        if ( getxhash( infil_door_struct.script_noteworthy ) == combo_label )
        {
            level.var_ca417da178d7c093 = spawnscriptable( "actionpark_door_left", infil_door_struct.origin, infil_door_struct.angles );
            level.var_eea1c1831412959c = spawnscriptable( "actionpark_door_right", infil_door_struct.origin, infil_door_struct.angles );
        }
    }
    
    foreach ( infil_door_struct in var_503bbe0a31f23bc4 )
    {
        if ( getxhash( infil_door_struct.script_noteworthy ) == combo_label )
        {
            level.var_b2020b5d75cecf3 = spawnscriptable( "actionpark_door_left", infil_door_struct.origin, infil_door_struct.angles );
            level.var_aa46efdfdf62ca7c = spawnscriptable( "actionpark_door_right", infil_door_struct.origin, infil_door_struct.angles );
        }
    }
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0x9b4ba956, Offset: 0x1fee
// Size: 0x130
function private get_combo_index_range( var_262ff90ef3db112 )
{
    combo_index_min = 0;
    combo_index_max = var_262ff90ef3db112.combinations.size - 1;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        return [ combo_index_min, combo_index_max ];
    }
    
    combo_index_override = getdvarint( @"hash_2e6e24fa707c7726", -1 );
    
    if ( combo_index_override >= var_262ff90ef3db112.startingindex && combo_index_override < var_262ff90ef3db112.combinations.size )
    {
        combo_index_min = combo_index_override;
        combo_index_max = combo_index_override;
    }
    else
    {
        combo_index_min = getdvarint( @"hash_b90f2003057e000d", 0 );
        combo_index_max = getdvarint( @"hash_b8ec0a03055787f3", 2147483647 );
        
        if ( combo_index_min > combo_index_max )
        {
            assertmsg( "<dev string:x6d>" + "<dev string:x7c>" + "<dev string:xa7>" + "<dev string:xaa>" );
            combo_index_min = combo_index_max;
        }
        
        combo_index_min = clampint( combo_index_min, var_262ff90ef3db112.startingindex, var_262ff90ef3db112.combinations.size - 1 );
        combo_index_max = clampint( combo_index_max, var_262ff90ef3db112.startingindex, var_262ff90ef3db112.combinations.size - 1 );
    }
    
    return [ combo_index_min, combo_index_max ];
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0xc4ad7ef9, Offset: 0x2127
// Size: 0x25c
function private randomize_combo_list( combo_list )
{
    if ( combo_list.size < 2 )
    {
        return combo_list;
    }
    
    var_93362842123b94f4 = [];
    combo_buckets = [];
    
    foreach ( combo_struct in combo_list )
    {
        var_93362842123b94f4 = arraycombineunique( var_93362842123b94f4, [ combo_struct.slab_data.center_index ] );
        
        if ( !isdefined( combo_buckets[ combo_struct.slab_data.center_index ] ) )
        {
            combo_buckets[ combo_struct.slab_data.center_index ] = [];
        }
        
        combo_buckets[ combo_struct.slab_data.center_index ][ combo_buckets[ combo_struct.slab_data.center_index ].size ] = combo_struct;
    }
    
    cooldown_queue_size = int( var_93362842123b94f4.size * 0.66 );
    
    if ( cooldown_queue_size == 0 )
    {
        assertmsg( "<dev string:x6d>" + "<dev string:xec>" + "<dev string:xa7>" + "<dev string:x116>" );
        return combo_list;
    }
    
    cooldown_queue = utility::queue_create( cooldown_queue_size );
    randomized_combo_list = [];
    
    while ( var_93362842123b94f4.size > 0 && randomized_combo_list.size < combo_list.size )
    {
        if ( utility::queue_isfull( cooldown_queue ) )
        {
            var_7f095744c731ab4f = utility::queue_peek( cooldown_queue );
            utility::queue_dequeue( cooldown_queue );
            var_93362842123b94f4[ var_93362842123b94f4.size ] = var_7f095744c731ab4f;
        }
        
        random_index = randomint( var_93362842123b94f4.size );
        var_7f095744c731ab4f = var_93362842123b94f4[ random_index ];
        combo_bucket = combo_buckets[ var_7f095744c731ab4f ];
        var_93362842123b94f4[ random_index ] = undefined;
        
        if ( isint( random_index ) )
        {
            function_cdc669dbc8ea2101( var_93362842123b94f4 );
        }
        
        random_index = randomint( combo_bucket.size );
        combo_struct = combo_bucket[ random_index ];
        combo_bucket[ random_index ] = undefined;
        
        if ( isint( random_index ) )
        {
            function_cdc669dbc8ea2101( combo_bucket );
        }
        
        randomized_combo_list[ randomized_combo_list.size ] = combo_struct;
        
        if ( combo_bucket.size == 0 )
        {
            combo_buckets[ var_7f095744c731ab4f ] = undefined;
            continue;
        }
        
        utility::queue_enqueue( cooldown_queue, var_7f095744c731ab4f );
    }
    
    logstring( "[ACTION PARK] " + "action_park_utility::randomize_combo_list" + ": " + "Combo list successfully randomized" );
    return randomized_combo_list;
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0xacb8f67f, Offset: 0x238c
// Size: 0x58, Type: bool
function private function_adef85cc33621725()
{
    if ( game[ #"action_park_utility" ].combo_list.size > 1 )
    {
        var_ab89b175e95b24ca = getmatchrulesdata( "actionParkData", "roundsPerComboCycle" );
        
        if ( var_ab89b175e95b24ca > 0 && game[ "roundsPlayed" ] % var_ab89b175e95b24ca == 0 )
        {
            return !function_7e663773e83336cd();
        }
    }
    
    return false;
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0xbf40b2ce, Offset: 0x23ed
// Size: 0x200
function private function_35b7f7f899261a9b( params )
{
    if ( !game[ #"action_park_utility" ] || !level.var_545cb88c1a6ca273 )
    {
        return params.spawnpointlist;
    }
    
    var_5cfe216327d3e91b = undefined;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        var_5cfe216327d3e91b = gameinstance::get_instance_arena( params.instanceid );
    }
    
    combo_label = get_combo_label( var_5cfe216327d3e91b );
    max_spawn_distance = getdvarint( @"hash_aa140b40b98dd311", 3500 );
    max_spawn_distance *= max_spawn_distance;
    spawnpoints = [];
    
    foreach ( spawnpoint in params.spawnpointlist )
    {
        if ( !spawnpoint.script_noteworthy )
        {
            continue;
        }
        
        if ( getxhash( spawnpoint.script_noteworthy ) != combo_label )
        {
            continue;
        }
        
        if ( distance2dsquared( spawnpoint.origin, level.var_545cb88c1a6ca273.origin ) > max_spawn_distance )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::filter_spawnpoints" + ": " + "Invalid spawn at " + spawnpoint.origin + " => Combo: " + combo_label + ", Origin: " + level.var_545cb88c1a6ca273.origin );
            continue;
        }
        
        spawnpoints[ spawnpoints.size ] = spawnpoint;
    }
    
    logstring( "[ACTION PARK] " + "action_park_utility::filter_spawnpoints" + ": " + params.spawnpointlist.size - spawnpoints.size + " of " + params.spawnpointlist.size + " spawnpoints filtered" );
    return spawnpoints;
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0x3a4f6b20, Offset: 0x25f6
// Size: 0x13a
function private district_streaming_update()
{
    var_bafc425df90dd00 = !getdvarint( @"hash_2dad5e89223d52c3", 0 );
    
    foreach ( player in level.players )
    {
        if ( var_bafc425df90dd00 )
        {
            var_5cfe216327d3e91b = undefined;
            
            if ( level.multimatch ?? gameinstance::is_enabled() )
            {
                var_5cfe216327d3e91b = gameinstance::get_instance_id( player.instanceid );
            }
            
            district_name = function_412fb68a48a53304( var_5cfe216327d3e91b );
            stream_origin = get_combo_origin( var_5cfe216327d3e91b );
            player streamhint::playerstreamhintlocation( stream_origin, undefined, 1 );
            
            if ( function_7e663773e83336cd() )
            {
                district_streaming_load_and_hint_for_player( district_name, player );
            }
            else
            {
                district_streaming_load_and_visible_for_player( district_name, player );
            }
            
            continue;
        }
        
        player function_e0711492511cb04f();
        logstring( "[ACTION PARK] " + "action_park_utility::district_streaming_update" + ": " + "All manually streamed districts cleared" );
    }
}

// Namespace action_park_utility
// Params 2, eflags: 0x4
// Checksum 0xf6a33477, Offset: 0x2738
// Size: 0x51
function private district_streaming_load_and_hint_for_player( district_name, player )
{
    player function_da9eb65a82a157bb( [ district_name ], #"load_and_hinted" );
    logstring( "[ACTION PARK] " + "action_park_utility::district_streaming_load_and_hint_for_player" + ": " + "Manual streaming for district " + district_name + " set to load_and_hinted" );
}

// Namespace action_park_utility
// Params 2, eflags: 0x4
// Checksum 0xcc22d6db, Offset: 0x2791
// Size: 0x7c
function private district_streaming_load_and_visible_for_player( district_name, player )
{
    player setallstreamloaddist( 10000 );
    player function_11c632b7fbb6a0e7( #"hash_630dceaa6f488b60" );
    player function_e0711492511cb04f();
    player function_da9eb65a82a157bb( [ district_name ], #"load_and_visible" );
    player function_b998e77d4d3b925f( district_name );
    logstring( "[ACTION PARK] " + "action_park_utility::district_streaming_load_and_visible_for_player" + ": " + "Manual streaming for district " + district_name + " set to load_and_visible" );
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0xc7cdbbd8, Offset: 0x2815
// Size: 0x19e
function private function_b20c78b8506dbbbc( player )
{
    game[ #"action_park_utility" ].var_698d68a61e8da793.var_78f0f63e7166815b++;
    player.var_b660cc1baffd76e8 = 1;
    player game_utility::fadetoblackforplayer( player, 1, 0 );
    player game_utility::fadetoblackforplayerkeepui( player, 1, 0 );
    wait 0.5;
    player setclientomnvar( "post_game_state", 17 );
    wait 0.5;
    player game_utility::fadetoblackforplayer( player, 0, 0 );
    player game_utility::fadetoblackforplayerkeepui( player, 0, 0.5 );
    wait game[ #"action_park_utility" ].var_698d68a61e8da793.length;
    player game_utility::fadetoblackforplayer( player, 1, 0.5 );
    wait 0.5;
    player game_utility::fadetoblackforplayerkeepui( player, 1, 0 );
    waitframe();
    player game_utility::fadetoblackforplayer( player, 0, 0 );
    player setclientomnvar( "post_game_state", 0 );
    wait 0.5;
    
    if ( isdefined( player.lastspawnpoint ) )
    {
        player setplayerangles( player.lastspawnpoint.angles ?? ( 0, 0, 0 ) );
    }
    
    player.var_b660cc1baffd76e8 = undefined;
    player notify( #"hash_fd6047a5ddfdd8de" );
    game[ #"action_park_utility" ].var_698d68a61e8da793.var_78f0f63e7166815b--;
    
    if ( game[ #"action_park_utility" ].var_698d68a61e8da793.var_78f0f63e7166815b == 0 )
    {
        flags::gameflagset( "action_park_cycling_next_combo" );
        waitframe();
        flags::function_5a2cc698dcfaa82a( "action_park_cycling_next_combo" );
    }
}

// Namespace action_park_utility
// Params 0, eflags: 0x4
// Checksum 0x29ae81f2, Offset: 0x29bb
// Size: 0x2a, Type: bool
function private function_ff90a833114ba0e4()
{
    var_f1fc91e1566d5ee4 = getdvarint( @"hash_734bc6bd602ff5c9", 0 ) != 0;
    return var_f1fc91e1566d5ee4 && game_utility_mp::matchmakinggame();
}

// Namespace action_park_utility
// Params 1, eflags: 0x4
// Checksum 0x913c5d3c, Offset: 0x29ee
// Size: 0x7d
function private on_player_connect_start( params )
{
    self.pers[ "streamSyncComplete" ] = 0;
    var_5cfe216327d3e91b = undefined;
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        var_5cfe216327d3e91b = gameinstance::get_instance_id( self.instanceid );
    }
    
    district_name = function_412fb68a48a53304( var_5cfe216327d3e91b );
    district_streaming_load_and_visible_for_player( district_name, self );
    
    if ( function_7e663773e83336cd() )
    {
        function_b20c78b8506dbbbc( self );
    }
}

/#

    // Namespace action_park_utility
    // Params 0, eflags: 0xc
    // Checksum 0xbb18be5a, Offset: 0x2a73
    // Size: 0xa8, Type: dev
    function private function_820edf9e4e15c54()
    {
        self notify( #"hash_f1591aa57a3a250a" );
        self endon( #"hash_f1591aa57a3a250a" );
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_26b68c3e2860620a", 0 );
        var_11e36482478b4263 = !getdvarint( @"hash_26b68c3e2860620a", 0 );
        
        do
        {
            wait 1;
            var_37b568e1bfc50072 = !getdvarint( @"hash_26b68c3e2860620a", 0 );
            
            if ( var_11e36482478b4263 != var_37b568e1bfc50072 )
            {
                if ( var_37b568e1bfc50072 )
                {
                    initialize_exterior_periph();
                }
                else if ( level.var_545cb88c1a6ca273 )
                {
                    level.var_545cb88c1a6ca273 delete();
                }
                
                var_11e36482478b4263 = var_37b568e1bfc50072;
            }
        }
        while ( true );
    }

    // Namespace action_park_utility
    // Params 0, eflags: 0xc
    // Checksum 0xf8cbb974, Offset: 0x2b23
    // Size: 0x86, Type: dev
    function private function_9ed3e34c871b1e14()
    {
        self notify( #"hash_87374503038c4c0a" );
        self endon( #"hash_87374503038c4c0a" );
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_2dad5e89223d52c3", 0 );
        var_1183b2b264c61bb6 = !getdvarint( @"hash_2dad5e89223d52c3", 0 );
        
        do
        {
            wait 1;
            is_streaming_enabled = !getdvarint( @"hash_2dad5e89223d52c3", 0 );
            
            if ( var_1183b2b264c61bb6 != is_streaming_enabled )
            {
                district_streaming_update();
                var_1183b2b264c61bb6 = is_streaming_enabled;
            }
        }
        while ( true );
    }

#/

// Namespace action_park_utility
// Params 1
// Checksum 0x47b131fc, Offset: 0x2bb1
// Size: 0x200
function activate_weather_exploders( var_e5fd94d51e5762ee )
{
    logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "activate_weather_exploders called with: " + var_e5fd94d51e5762ee );
    
    if ( !var_e5fd94d51e5762ee )
    {
        logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "No script parameters provided, skipping weather exploders" );
        return;
    }
    
    combo_origin = get_combo_origin();
    
    if ( !isdefined( combo_origin ) )
    {
        logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "No combo origin available, skipping weather exploders" );
        return;
    }
    
    position_tokens = strtok( var_e5fd94d51e5762ee, ":" );
    logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "Parsed " + position_tokens.size + " position tokens" );
    
    foreach ( token in position_tokens )
    {
        parts = strtok( token, "_" );
        position = parts[ 0 ];
        index = int( parts[ 1 ] );
        logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "Token: " + token + " => position: " + position + ", index: " + index );
        var_4eb28fc094ea8de1 = get_weather_exploder_rule_for_position( position, index );
        
        if ( var_4eb28fc094ea8de1 )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "Weather exploder rule matched for position: " + position + " index: " + index );
            activate_weather_exploders_for_position( var_4eb28fc094ea8de1, combo_origin );
            continue;
        }
        
        logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders" + ": " + "No weather type matched for position: " + position + " index: " + index );
    }
}

// Namespace action_park_utility
// Params 2
// Checksum 0xa69c2f2d, Offset: 0x2db9
// Size: 0x261
function get_weather_exploder_rule_for_position( position, index )
{
    logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "get_weather_exploder_rule_for_position => position: " + position + ", index: " + index );
    
    if ( position == "mid" )
    {
        var_1e11dec84fbce141 = [ 38, 39, 40, 41, 42 ];
        var_7f80f37128ba4eb4 = [ 37, 43, 44, 45, 46, 47 ];
        logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Checking mid rain indices [38-42], mid snow indices [43-47]" );
        
        if ( arraycontains( var_1e11dec84fbce141, index ) )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " matched RAIN whitelist" );
            return function_92127ab6026d7876( "actionpark_water_sprinkler", position, index );
        }
        
        if ( arraycontains( var_7f80f37128ba4eb4, index ) )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " matched SNOW whitelist" );
            return function_92127ab6026d7876( "actionpark_snow_blower", position, index );
        }
        
        logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " did NOT match any mid whitelist" );
        return;
    }
    
    if ( position == "left" || position == "right" )
    {
        var_86dd8037714c4840 = [ 3 ];
        end_snow_indices = [ 6 ];
        logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Checking end rain indices [3], end snow indices [6]" );
        
        if ( arraycontains( var_86dd8037714c4840, index ) )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " matched RAIN whitelist for position: " + position );
            return function_92127ab6026d7876( "actionpark_water_sprinkler", position, index );
        }
        
        if ( arraycontains( end_snow_indices, index ) )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " matched SNOW whitelist for position: " + position );
            return function_92127ab6026d7876( "actionpark_snow_blower", position, index );
        }
        
        logstring( "[ACTION PARK] " + "action_park_utility::get_weather_exploder_rule_for_position" + ": " + "Index " + index + " did NOT match any end whitelist for position: " + position );
    }
}

// Namespace action_park_utility
// Params 3
// Checksum 0x800ae3cc, Offset: 0x3023
// Size: 0xa1
function function_92127ab6026d7876( exploder_base_name, position, index )
{
    rule_override = get_weather_exploder_rule_override( position, index );
    var_5748f44bb813783c = undefined;
    var_cb59978bca4e54b6 = [];
    
    if ( isdefined( rule_override ) )
    {
        var_5748f44bb813783c = rule_override.var_5748f44bb813783c;
        var_cb59978bca4e54b6 = rule_override.var_cb59978bca4e54b6;
    }
    
    return { #var_cb59978bca4e54b6:var_cb59978bca4e54b6, #var_5748f44bb813783c:var_5748f44bb813783c, #index:index, #position:position, #exploder_base_name:exploder_base_name };
}

// Namespace action_park_utility
// Params 2
// Checksum 0x1452e8c8, Offset: 0x30cd
// Size: 0x44
function get_weather_exploder_rule_override( position, index )
{
    if ( position == "mid" )
    {
        if ( index == 43 )
        {
            return { #var_cb59978bca4e54b6:[ 2 ], #var_5748f44bb813783c:undefined };
        }
    }
}

// Namespace action_park_utility
// Params 2
// Checksum 0x141767a3, Offset: 0x311a
// Size: 0x4e
function function_b4476e736809fef9( exploder_base_name, position )
{
    if ( exploder_base_name == "actionpark_snow_blower" )
    {
        if ( position == "mid" )
        {
            return 3;
        }
        
        return 7;
    }
    
    if ( exploder_base_name == "actionpark_water_sprinkler" )
    {
        if ( position == "mid" )
        {
            return 4;
        }
        
        return 7;
    }
    
    return 0;
}

// Namespace action_park_utility
// Params 2
// Checksum 0x3ebd402d, Offset: 0x3171
// Size: 0x149
function activate_weather_exploders_for_position( exploder_rule, combo_origin )
{
    max_exploder_index = function_b4476e736809fef9( exploder_rule.exploder_base_name, exploder_rule.position );
    
    for ( exploder_index = 0; exploder_index <= max_exploder_index ; exploder_index++ )
    {
        if ( isdefined( exploder_rule.var_5748f44bb813783c ) && !arraycontains( exploder_rule.var_5748f44bb813783c, exploder_index ) )
        {
            continue;
        }
        
        if ( arraycontains( exploder_rule.var_cb59978bca4e54b6, exploder_index ) )
        {
            logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders_for_position" + ": " + "Skipping exploder index " + exploder_index + " for position: " + exploder_rule.position + " slab index: " + exploder_rule.index );
            continue;
        }
        
        exploder_name = exploder_rule.exploder_base_name + "_" + exploder_rule.position + "_" + exploder_index;
        logstring( "[ACTION PARK] " + "action_park_utility::activate_weather_exploders_for_position" + ": " + "Activating exploder: " + exploder_name + " with radius " + 5000 + " at origin " + combo_origin );
        utility::exploder( exploder_name, undefined, undefined, 5000, combo_origin );
    }
}

