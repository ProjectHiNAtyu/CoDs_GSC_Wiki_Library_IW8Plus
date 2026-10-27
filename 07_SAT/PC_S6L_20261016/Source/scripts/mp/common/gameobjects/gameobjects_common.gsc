// scripts\mp\common\gameobjects\gameobjects_common.gsc  (hash_5b21ba28a2525703.gscc) (size: 39578 Bytes / 0x9a9a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe9640e3 (3197518051)
// size ...... 39578 (0x9a9a)
// includes .. 14  (offset: 0x91c6)
// strings ... 98  (offset: 0x9236)
// dev strs .. 30  (offset: 0x988e)
// exports ... 94  (offset: 0x6a7e)
// cseg ...... 0x915 + 0x6169 (0x6a7e)
// imports ... 188 (offset: 0x792e)
// animtree1 . 0   (offset: 0x9a9a)
// animtree2 . 0   (offset: 0x9a9a)
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trigger_group;
#using scripts\common\utility;
#using scripts\mp\action_park_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\matchdata;

#namespace gameobjects_common;

// Namespace gameobjects_common
// Params 5, eflags: 0x40 variadic
// Checksum 0xcdfd4713, Offset: 0x933
// Size: 0x36e
function function_22117b1fd559026f( game_object_name_hash, var_24290c36e2cab388, var_36671917263a4dfc, ... )
{
    game_object_name_hash = isxhash( game_object_name_hash ) ? game_object_name_hash : getxhash( game_object_name_hash );
    
    if ( isdefined( level.game_objects.var_a929f69e5aaaa308[ game_object_name_hash ] ) )
    {
        if ( !istrue( 0 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x33>" + game_object_name_hash + "<dev string:x72>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Initialization properties already registered for game object '" + game_object_name_hash + "'" );
        }
        
        return;
    }
    
    var_112235d348552d0 = game_utility_mp::function_4b7180ed8c2e9742( #"hash_14bb716c4b77c45a" );
    
    if ( !isdefined( var_112235d348552d0 ) )
    {
        if ( !istrue( 0 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x74>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Failed to find a valid reference to a 'gameobjectdefinitions' bundle" );
        }
        
        return;
    }
    
    init_properties = {};
    init_properties.var_24290c36e2cab388 = var_24290c36e2cab388 ?? { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
    init_properties.var_5dfc2bbf7f69f6f0 = isarray( var_36671917263a4dfc ) ? var_36671917263a4dfc[ 1 ] : undefined;
    init_properties.var_abb7aac0e7708b72 = isdefined( init_properties.var_5dfc2bbf7f69f6f0 ) ? var_36671917263a4dfc[ 0 ] : var_36671917263a4dfc;
    init_properties.additional_params = { #varargcount:varargcount, #vararg:vararg };
    
    foreach ( entry in var_112235d348552d0.list )
    {
        game_object_definition = entry.variant_object;
        
        if ( getxhash( game_object_definition.var_80258cc5fb500cc8 ) == game_object_name_hash )
        {
            init_properties.var_24290c36e2cab388.game_object_definition = game_object_definition;
            break;
        }
    }
    
    if ( !isdefined( init_properties.var_24290c36e2cab388.game_object_definition ) )
    {
        if ( !istrue( 0 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:xb9>" + game_object_name_hash + "<dev string:x72>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Failed to find a game object definition corresponding to '" + game_object_name_hash + "'" );
        }
        
        return;
    }
    
    if ( !isdefined( level.game_objects.var_a929f69e5aaaa308 ) )
    {
        level.game_objects.var_a929f69e5aaaa308 = [];
    }
    
    level.game_objects.var_a929f69e5aaaa308[ game_object_name_hash ] = init_properties;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x3894c5e2, Offset: 0xca9
// Size: 0x1c8
function function_73270cee679463ed( targetname )
{
    triggers = getentarray( targetname, #targetname );
    trigger_map = [];
    
    foreach ( trigger in triggers )
    {
        if ( issubstr( trigger.classname, "trigger" ) )
        {
            if ( level.multimatch ?? gameinstance::is_enabled() )
            {
                foreach ( instance_id, combo_index in gameinstance::get_active_arenas() )
                {
                    if ( trigger.script_noteworthy == action_park_utility::get_combo_label( combo_index ) )
                    {
                        if ( !isdefined( trigger_map[ instance_id ] ) )
                        {
                            trigger_map[ instance_id ] = [];
                        }
                        
                        trigger_map[ instance_id ][ trigger_map[ instance_id ].size ] = trigger;
                    }
                }
                
                continue;
            }
            
            if ( action_park_utility::is_enabled() )
            {
                if ( trigger.instance_id == action_park_utility::get_combo_index() || trigger.script_noteworthy == action_park_utility::get_combo_label() )
                {
                    if ( !isdefined( trigger_map[ 0 ] ) )
                    {
                        trigger_map[ 0 ] = [];
                    }
                    
                    trigger_map[ 0 ][ trigger_map[ 0 ].size ] = trigger;
                }
                
                continue;
            }
            
            if ( !isdefined( trigger_map[ 0 ] ) )
            {
                trigger_map[ 0 ] = [];
            }
            
            trigger_map[ 0 ][ trigger_map[ 0 ].size ] = trigger;
        }
    }
    
    return trigger_map;
}

// Namespace gameobjects_common
// Params 6, eflags: 0x40 variadic
// Checksum 0xb1b637fd, Offset: 0xe7a
// Size: 0x96
function initialize_game_object( game_object_name, var_24290c36e2cab388, var_1c1e374433af698d, var_abb7aac0e7708b72, ... )
{
    if ( !istrue( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xf4>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "No game object definitions found on game type bundle" );
    }
    
    thread function_7a82b341701b1c88( game_object_name, var_24290c36e2cab388, var_1c1e374433af698d, var_abb7aac0e7708b72, flat_args( vararg, varargcount ) );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x2b50afa0, Offset: 0xf18
// Size: 0x7d
function delete_game_object( game_object )
{
    deactivate( game_object );
    
    if ( game_object.has_trigger_group )
    {
        trigger_group::cleanup_enter_exit_trigger( game_object.trigger_group );
    }
    else
    {
        trigger::cleanup_enter_exit_trigger( game_object.trigger );
    }
    
    level.game_objects.list[ game_object.name_hash ] = undefined;
    queue_callback( game_object, #"hash_b9cd6b90f747164c", undefined, 0 );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xbc716660, Offset: 0xf9d
// Size: 0x58
function activate( game_object )
{
    if ( game_object.activated )
    {
        return;
    }
    
    activate_trigger( game_object );
    game_object.activated = 1;
    function_14088ca905f052c3( game_object, #"hash_18df75cc57a54d20" );
    queue_callback( game_object, #"hash_92c01688276809dc", undefined, 0 );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x4ea59cde, Offset: 0xffd
// Size: 0x17c
function deactivate( game_object )
{
    if ( !game_object.activated )
    {
        return;
    }
    
    game_object notify( #"game_object_deactivated" );
    level notify( #"game_object_deactivated", game_object.objective_key );
    game_object.var_7c1063f52ddc7189 = 1;
    deactivate_trigger( game_object );
    
    if ( isdefined( game_object.players_using ) )
    {
        foreach ( players_using in game_object.players_using )
        {
            foreach ( player in players_using )
            {
                function_bb00dd80a5b5365c( game_object, player, 1 );
            }
        }
    }
    
    game_object.activated = undefined;
    function_14088ca905f052c3( game_object, #"hash_53fdc082a3c4a3" );
    queue_callback( game_object, #"hash_89cf712b23a4d7b5", undefined, 0 );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xd09d56b1, Offset: 0x1181
// Size: 0x41
function activate_trigger( game_object )
{
    if ( game_object.has_trigger_group )
    {
        trigger_group::enable( game_object.trigger_group );
        return;
    }
    
    game_object.trigger utility::trigger_on();
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x4a25febd, Offset: 0x11ca
// Size: 0x41
function deactivate_trigger( game_object )
{
    if ( game_object.has_trigger_group )
    {
        trigger_group::disable( game_object.trigger_group );
        return;
    }
    
    game_object.trigger utility::trigger_off();
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x42a91468, Offset: 0x1213
// Size: 0xdb
function update_origin( game_object, origin )
{
    trigger_origin = has_trigger_group( game_object ) ? game_object.trigger_group.origin : game_object.trigger.origin;
    update_trigger_origin( game_object, origin + trigger_origin - game_object.origin );
    
    if ( isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        function_d31ff650f04e754b( game_object, origin + game_object.var_daaa29ac3e7ee276.origin - game_object.origin );
    }
    
    game_object.origin = origin;
    queue_callback( game_object, #"hash_448cb8c640d827ef", { #origin:origin }, 0 );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0xbf229dc9, Offset: 0x12f6
// Size: 0x1c9
function function_37f390027536269c( game_object, world_angles )
{
    trigger_origin = has_trigger_group( game_object ) ? game_object.trigger_group.origin : game_object.trigger.origin;
    local_origin = rotatevectorinverted( trigger_origin - game_object.origin, game_object.angles );
    update_trigger_origin( game_object, game_object.origin + rotatevector( local_origin, world_angles ) );
    trigger_angles = has_trigger_group( game_object ) ? game_object.trigger_group.angles : game_object.trigger.angles;
    local_angles = combineanglesinverted( game_object.angles, trigger_angles );
    update_trigger_angles( game_object, combineangles( world_angles, local_angles ) );
    
    if ( isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        local_origin = rotatevectorinverted( game_object.var_daaa29ac3e7ee276.origin - game_object.origin, game_object.angles );
        function_d31ff650f04e754b( game_object, game_object.origin + rotatevector( local_origin, world_angles ) );
        local_angles = combineanglesinverted( game_object.angles, game_object.var_daaa29ac3e7ee276.angles );
        function_11fdc1eec18521c5( game_object, combineangles( world_angles, local_angles ) );
    }
    
    game_object.angles = world_angles;
    queue_callback( game_object, #"hash_ff7296e8b6b20aa5", { #angles:world_angles }, 0 );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x84054f5f, Offset: 0x14c7
// Size: 0x71
function update_trigger_origin( game_object, origin )
{
    if ( game_object.has_trigger_group )
    {
        trigger_group::update_origin( game_object.trigger_group, origin );
    }
    else
    {
        game_object.trigger.origin = origin;
    }
    
    queue_callback( game_object, #"hash_b87fa092b5f61da2", { #origin:origin }, 0 );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0xd803c4e8, Offset: 0x1540
// Size: 0x71
function update_trigger_angles( game_object, world_angles )
{
    if ( game_object.has_trigger_group )
    {
        trigger_group::function_37f390027536269c( game_object.trigger_group, world_angles );
    }
    else
    {
        game_object.trigger.angles = world_angles;
    }
    
    queue_callback( game_object, #"hash_bdeed53855d336bc", { #angles:world_angles }, 0 );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x8c38949d, Offset: 0x15b9
// Size: 0x85
function function_d31ff650f04e754b( game_object, origin )
{
    if ( !isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        logstring( "[GAME OBJECT] " + "No use prompt entity exists for game object" + " { name_hash: " + game_object.name_hash + " }" );
        return;
    }
    
    game_object.var_daaa29ac3e7ee276.origin = origin;
    queue_callback( game_object, #"hash_25b47db5f4801aca", { #origin:origin }, 0 );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0xda19aa19, Offset: 0x1646
// Size: 0x85
function function_11fdc1eec18521c5( game_object, world_angles )
{
    if ( !isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        logstring( "[GAME OBJECT] " + "No use prompt entity exists for game object" + " { name_hash: " + game_object.name_hash + " }" );
        return;
    }
    
    game_object.var_daaa29ac3e7ee276.angles = world_angles;
    queue_callback( game_object, #"hash_1d1902218ebcf9a4", { #angles:world_angles }, 0 );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xc4f4fe69, Offset: 0x16d3
// Size: 0x18, Type: bool
function is_activated( game_object )
{
    return istrue( game_object.activated );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xefe4faaa, Offset: 0x16f4
// Size: 0x17
function get_type_hash( game_object )
{
    return game_object.type_hash;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x9abb59f5, Offset: 0x1714
// Size: 0x17
function get_instance_id( game_object )
{
    return game_object.instance_id;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xe8479f63, Offset: 0x1734
// Size: 0x17
function get_objective_key( game_object )
{
    return game_object.objective_key;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x5a8fc282, Offset: 0x1754
// Size: 0x17
function get_trigger( game_object )
{
    return game_object.trigger;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xe8479f63, Offset: 0x1774
// Size: 0x17
function get_trigger_group( game_object )
{
    return game_object.trigger_group;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x490c872f, Offset: 0x1794
// Size: 0x17
function get_origin( game_object )
{
    return game_object.origin;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x490c872f, Offset: 0x17b4
// Size: 0x17
function function_63e25df7cfbb206f( game_object )
{
    return game_object.angles;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x279fcda3, Offset: 0x17d4
// Size: 0x17
function get_objective_icon_offset( game_object )
{
    return game_object.objective_icon_offset;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xe8479f63, Offset: 0x17f4
// Size: 0x17
function function_273d5ec7dd391ec7( game_object )
{
    return game_object.var_c68e9f43ed9cc918;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x4fc7abcc, Offset: 0x1814
// Size: 0xa5
function get_use_team_name( game_object )
{
    return game_object.var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : game_object.var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xa9a9ee2d, Offset: 0x18c2
// Size: 0x39, Type: bool
function get_use_time_seconds( game_object )
{
    use_time_seconds = function_14088ca905f052c3( game_object, #"hash_9ac4aa0c62e211d1" );
    return use_time_seconds ?? game_object.use_time_seconds;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xdae585f2, Offset: 0x1904
// Size: 0x25, Type: bool
function get_use_progress( game_object )
{
    return game_object.update_struct.progress ?? undefined;
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xbbbe2d56, Offset: 0x1932
// Size: 0x23, Type: bool
function function_7ed0697b0eea44f8( game_object )
{
    return game_object.update_struct.progress > 0;
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x89301fc4, Offset: 0x195e
// Size: 0x48
function function_8a27a916a385b65c( game_object, entity )
{
    if ( game_object.has_trigger_group )
    {
        return trigger_group::is_touching( game_object.trigger_group, entity );
    }
    
    return entity istouching( game_object.trigger );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x538cf603, Offset: 0x19af
// Size: 0x48
function function_61563e90d683f4ee( game_object, point )
{
    if ( game_object.has_trigger_group )
    {
        return trigger_group::is_point_inside( game_object.trigger_group, point );
    }
    
    return ispointinvolume( point, game_object.trigger );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xc30c9306, Offset: 0x1a00
// Size: 0x18, Type: bool
function has_trigger_group( game_object )
{
    return istrue( game_object.has_trigger_group );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x2ff1de70, Offset: 0x1a21
// Size: 0x18, Type: bool
function is_in_use( game_object )
{
    return isdefined( game_object.players_using );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0xf4399749, Offset: 0x1a42
// Size: 0x133
function function_5e4346091ac030c0( game_object, player )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return 0;
    }
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( !game_object.var_45125cc488d8766a && !player::isreallyalive( player ) )
    {
        return 0;
    }
    
    if ( !game_object.var_c1b628bc3c716398 && player.disconnecting )
    {
        return 0;
    }
    
    if ( game_object.var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" && !game_utility_mp::is_attacker_team( player.team ) )
    {
        return 0;
    }
    else if ( game_object.var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" && !game_utility_mp::is_defender_team( player.team ) )
    {
        return 0;
    }
    else if ( game_object.var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" )
    {
        return 0;
    }
    
    if ( !game_object callback::response( 2, #"hash_dff7cb7b68f75deb", { #player:player, #game_object:game_object } ) )
    {
        return 0;
    }
    
    return function_14088ca905f052c3( game_object, #"hash_b9c66d4b9cc93bfb", player );
}

// Namespace gameobjects_common
// Params 2
// Checksum 0x71a97cbf, Offset: 0x1b7e
// Size: 0x2d, Type: bool
function function_6057f2c78ba2b3a2( game_object, player )
{
    return isdefined( player.var_731e60cf67806edb[ game_object.objective_key ] );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xc6008af, Offset: 0x1bb4
// Size: 0x2a, Type: bool
function function_8ca4dd777670917b( player )
{
    return player.var_731e60cf67806edb.size > 0 || isdefined( player.carry_object );
}

// Namespace gameobjects_common
// Params 1
// Checksum 0xe8479f68, Offset: 0x1be7
// Size: 0x1b, Type: bool
function get_players_using( game_object )
{
    return game_object.players_using ?? [];
}

// Namespace gameobjects_common
// Params 2
// Checksum 0xbff65807, Offset: 0x1c0b
// Size: 0x10d, Type: bool
function function_de2f4638a165d21c( game_object, var_c68e9f43ed9cc918 )
{
    if ( !istrue( isdefined( var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x129>" + var_c68e9f43ed9cc918 + "<dev string:x72>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.players_using[ var_c68e9f43ed9cc918 ] ?? [];
}

// Namespace gameobjects_common
// Params 1
// Checksum 0x222699ee, Offset: 0x1d21
// Size: 0x4b
function function_c3218a3e4808e36c( game_object )
{
    attackers_using = function_de2f4638a165d21c( game_object, #"hash_7118f9343873352b" );
    defenders_using = function_de2f4638a165d21c( game_object, #"hash_ce911e3bbe99421f" );
    return arraycombine( attackers_using, defenders_using );
}

// Namespace gameobjects_common
// Params 3
// Checksum 0x8f72f289, Offset: 0x1d75
// Size: 0x4c
function function_15afd79eb673a2ed( game_object, var_45125cc488d8766a, var_c1b628bc3c716398 )
{
    game_object.var_45125cc488d8766a = var_45125cc488d8766a ? var_45125cc488d8766a : undefined;
    game_object.var_c1b628bc3c716398 = var_c1b628bc3c716398 ? var_c1b628bc3c716398 : undefined;
}

// Namespace gameobjects_common
// Params 4
// Checksum 0xf899db0, Offset: 0x1dc9
// Size: 0x315
function queue_callback( game_object, event, params, instant )
{
    if ( !istrue( event == #"hash_be764a9e97b1cfc3" || event == #"hash_b9cd6b90f747164c" || event == #"hash_92c01688276809dc" || event == #"hash_89cf712b23a4d7b5" || event == #"hash_448cb8c640d827ef" || event == #"hash_ff7296e8b6b20aa5" || event == #"hash_b87fa092b5f61da2" || event == #"hash_bdeed53855d336bc" || event == #"hash_25b47db5f4801aca" || event == #"hash_1d1902218ebcf9a4" || event == #"hash_358d33b2497e2ce3" || event == #"hash_5d939c5f097361e9" || event == #"hash_3c955b1e6fcd76eb" || event == #"hash_45277be78cb54c51" || event == #"hash_47fedf1df6eafa30" || event == #"hash_a1e02ee2cc2ad28e" || event == #"hash_3aba7df6443df11d" || event == #"hash_2e3e0663aecb6f19" || event == #"hash_29eede2365f9349a" || event == #"hash_33ab895f04e4eec9" || event == #"hash_ae8f0f5e3b866b53" || event == #"hash_bc5f191157450d6b" || event == #"hash_a836ce9ab43d9e2" || event == #"hash_2daf3ace91057e84" || event == #"hash_300ad54dcc9beab1" || event == #"hash_629949853fbabab8" || event == #"hash_e3206e8d5d3df1e3" || event == #"hash_a4277d17a7a228c9" || event == #"hash_249e26f937238db4" || event == #"hash_a21546ba725310a2" || event == #"hash_754b791c5072837b" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x15f>" + event + "<dev string:x183>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object callback type (" + event + ")" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !isdefined( params ) )
    {
        params = {};
    }
    
    params.game_object = game_object;
    params.instance_id = game_object.instance_id;
    
    if ( instant )
    {
        if ( level.game_objects.var_1f53ebaf8dbac17d )
        {
            logstring( "[GAME OBJECT] " + "CALLBACK { event: " + event + ", instant: true }" + " { name_hash: " + game_object.name_hash + " }" );
        }
        
        game_object callback::callback_sequence( event, params );
        return;
    }
    
    thread function_b560f068802a681e( game_object, event, params );
}

/#

    // Namespace gameobjects_common
    // Params 2
    // Checksum 0x2bfa442, Offset: 0x20e6
    // Size: 0x31, Type: dev
    function function_579ac2f7e66ed64f( game_object, skip )
    {
        game_object.debug_update_struct.var_f78a6245a4ee23c3 = istrue( skip );
    }

#/

// Namespace gameobjects_common
// Params 0, eflags: 0x5
// Checksum 0x67a3db6e, Offset: 0x211f
// Size: 0x89
function private autoexec __autoexec__()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        /#
            setdevdvarifuninitialized( @"hash_e16c8525c6680130", 0, 0, 1 );
        #/
        
        level.game_objects = {};
        level.game_objects.var_1f53ebaf8dbac17d = getdvarint( @"hash_3b2378f12047a78b", 0 ) == 0;
        system::register( #"gameobjects_common", #"trigger_group", &function_a53b566f98941da2, &function_7772abdca2d7c70b );
    }
}

// Namespace gameobjects_common
// Params 0, eflags: 0x4
// Checksum 0xab736b8f, Offset: 0x21b0
// Size: 0x2bf
function private function_a53b566f98941da2()
{
    callback_sequence = [ #"hash_6947ec89a1af6d69", #"hash_abf23dc6100798bc", #"hash_7fa900bfddf4cbf6" ];
    callback::register_sequence( #"hash_be764a9e97b1cfc3", callback_sequence );
    callback::register_sequence( #"hash_b9cd6b90f747164c", callback_sequence );
    callback::register_sequence( #"hash_92c01688276809dc", callback_sequence );
    callback::register_sequence( #"hash_89cf712b23a4d7b5", callback_sequence );
    callback::register_sequence( #"hash_448cb8c640d827ef", callback_sequence );
    callback::register_sequence( #"hash_ff7296e8b6b20aa5", callback_sequence );
    callback::register_sequence( #"hash_b87fa092b5f61da2", callback_sequence );
    callback::register_sequence( #"hash_bdeed53855d336bc", callback_sequence );
    callback::register_sequence( #"hash_25b47db5f4801aca", callback_sequence );
    callback::register_sequence( #"hash_1d1902218ebcf9a4", callback_sequence );
    callback::register_sequence( #"hash_358d33b2497e2ce3", callback_sequence );
    callback::register_sequence( #"hash_5d939c5f097361e9", callback_sequence );
    callback::register_sequence( #"hash_3c955b1e6fcd76eb", callback_sequence );
    callback::register_sequence( #"hash_45277be78cb54c51", callback_sequence );
    callback::register_sequence( #"hash_47fedf1df6eafa30", callback_sequence );
    callback::register_sequence( #"hash_a1e02ee2cc2ad28e", callback_sequence );
    callback::register_sequence( #"hash_3aba7df6443df11d", callback_sequence );
    callback::register_sequence( #"hash_2e3e0663aecb6f19", callback_sequence );
    callback::register_sequence( #"hash_29eede2365f9349a", callback_sequence );
    callback::register_sequence( #"hash_33ab895f04e4eec9", callback_sequence );
    callback::register_sequence( #"hash_bc5f191157450d6b", callback_sequence );
    callback::register_sequence( #"hash_ae8f0f5e3b866b53", callback_sequence );
    callback::register_sequence( #"hash_a836ce9ab43d9e2", callback_sequence );
    callback::register_sequence( #"hash_2daf3ace91057e84", callback_sequence );
    callback::register_sequence( #"hash_300ad54dcc9beab1", callback_sequence );
    callback::register_sequence( #"hash_629949853fbabab8", callback_sequence );
    callback::register_sequence( #"hash_e3206e8d5d3df1e3", callback_sequence );
    callback::register_sequence( #"hash_a4277d17a7a228c9", callback_sequence );
    callback::register_sequence( #"hash_249e26f937238db4", callback_sequence );
    callback::register_sequence( #"hash_a21546ba725310a2", callback_sequence );
    callback::register_sequence( #"hash_754b791c5072837b", callback_sequence );
    callback::register_sequence( #"hash_4b88ae7136a85bfd", callback_sequence );
    callback::register_sequence( #"hash_e19a9f3d97f3e18f", callback_sequence );
    callback::register_sequence( #"hash_3a1fe5e4df493585", callback_sequence );
    level.game_objects.var_cce4fabe8192a953 = &function_cce4fabe8192a953;
    utility::flag_set( "gameobject_system_pre_init" );
}

// Namespace gameobjects_common
// Params 0, eflags: 0x4
// Checksum 0x906efc4a, Offset: 0x2477
// Size: 0x5c
function private function_7772abdca2d7c70b()
{
    join_team_aggregator::registeronplayerjointeamnospectatorcallback( &function_d8f595b657e0431a );
    disconnect_event_aggregator::registerondisconnecteventcallback( &function_91415420e8b1b2b0 );
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        function_61f93c0b00fdfe54();
    }
    
    level.game_objects.var_cce4fabe8192a953 = undefined;
    thread function_55ec07aa7be6f17a();
}

// Namespace gameobjects_common
// Params 0, eflags: 0xc
// Checksum 0x47835a51, Offset: 0x24db
// Size: 0x19c
function private function_55ec07aa7be6f17a()
{
    self notify( #"hash_437e876f2a856223" );
    self endon( #"hash_437e876f2a856223" );
    level endon( #"game_ended" );
    
    if ( utility::flag_exist( "create_script_initialized" ) )
    {
        utility::flag_wait( "create_script_initialized" );
        game_object_struct_array = function_7e96b6eabedc43c9();
        
        if ( game_object_struct_array.size > 0 )
        {
            level.game_objects.var_5f329cd264226f08 = 1;
            
            foreach ( game_object_struct in game_object_struct_array )
            {
                function_31183ac8c02f4240( game_object_struct );
            }
            
            foreach ( entity in getentarray() )
            {
                if ( isdefined( entity.script_gameobjectname ) && !entity.skip_deletion )
                {
                    entity delete();
                }
            }
        }
    }
    
    level.game_objects.var_a929f69e5aaaa308 = undefined;
    waitframe();
    utility::flag_set( "gameobject_system_post_init" );
    waitframe();
    utility::flag_set( "cs_gameobjects_constructed" );
}

// Namespace gameobjects_common
// Params 0, eflags: 0x4
// Checksum 0x756016c5, Offset: 0x267f
// Size: 0x37b
function private function_7e96b6eabedc43c9()
{
    var_67809ca0d80838af = [];
    
    if ( !isdefined( level.game_objects.var_a929f69e5aaaa308 ) )
    {
        return var_67809ca0d80838af;
    }
    
    foreach ( game_object_struct in utility::getstructarray( "gameobject" ) )
    {
        if ( game_object_struct.gametype != level.gametypebundle.namekey )
        {
            continue;
        }
        
        game_object_name_hash = getxhash( game_object_struct.game_object_name );
        
        if ( !isdefined( level.game_objects.var_a929f69e5aaaa308[ game_object_name_hash ] ) )
        {
            continue;
        }
        
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            foreach ( instance_id, combo_index in gameinstance::get_active_arenas() )
            {
                if ( game_object_struct.script_noteworthy == action_park_utility::get_combo_label( combo_index ) )
                {
                    if ( !isdefined( var_67809ca0d80838af[ game_object_name_hash ] ) )
                    {
                        var_67809ca0d80838af[ game_object_name_hash ] = [];
                    }
                    
                    if ( !isdefined( var_67809ca0d80838af[ game_object_name_hash ][ instance_id ] ) )
                    {
                        var_67809ca0d80838af[ game_object_name_hash ][ instance_id ] = [];
                    }
                    
                    var_67809ca0d80838af[ game_object_name_hash ][ instance_id ][ var_67809ca0d80838af[ game_object_name_hash ][ instance_id ].size ] = game_object_struct;
                    break;
                }
            }
        }
        else if ( action_park_utility::is_enabled() )
        {
            var_8bd4e6130da271c5 = hashcat( #"multi_arena_map_", game_object_struct.instance_id );
            
            if ( var_8bd4e6130da271c5 != action_park_utility::get_combo_label() )
            {
                continue;
            }
        }
        
        if ( !isdefined( var_67809ca0d80838af[ game_object_name_hash ] ) )
        {
            var_67809ca0d80838af[ game_object_name_hash ] = [];
        }
        
        var_67809ca0d80838af[ game_object_name_hash ][ var_67809ca0d80838af[ game_object_name_hash ].size ] = game_object_struct;
    }
    
    if ( var_67809ca0d80838af.size == 0 )
    {
        return var_67809ca0d80838af;
    }
    
    out_array = [];
    
    foreach ( game_object_name_hash, init_properties in level.game_objects.var_a929f69e5aaaa308 )
    {
        game_object_struct_array = var_67809ca0d80838af[ game_object_name_hash ];
        
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            foreach ( var_a0f937b0f17ba132 in game_object_struct_array )
            {
                if ( isdefined( init_properties.var_5dfc2bbf7f69f6f0 ) )
                {
                    var_a0f937b0f17ba132 = [[ init_properties.var_5dfc2bbf7f69f6f0 ]]( var_a0f937b0f17ba132 );
                }
                
                out_array = arraycombine( out_array, var_a0f937b0f17ba132 );
            }
            
            continue;
        }
        
        if ( isdefined( init_properties.var_5dfc2bbf7f69f6f0 ) )
        {
            game_object_struct_array = [[ init_properties.var_5dfc2bbf7f69f6f0 ]]( game_object_struct_array );
        }
        
        out_array = arraycombine( out_array, game_object_struct_array );
    }
    
    return out_array;
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xc30a2819, Offset: 0x2a03
// Size: 0x37b
function private function_31183ac8c02f4240( game_object_struct )
{
    if ( !isdefined( game_object_struct.target ) )
    {
        if ( !istrue( 0 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x185>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects a defined 'target' KVP on the game object struct which corresponds to the trigger" );
        }
        
        return;
    }
    
    if ( isdefined( game_object_struct.trigger_override ) )
    {
        trigger_entities = getentarrayinradius( game_object_struct.trigger_override, #targetname, game_object_struct.origin, 64 );
        
        if ( trigger_entities.size > 0 )
        {
            trigger = trigger_entities[ 0 ];
            trigger.skip_deletion = 1;
        }
    }
    else
    {
        trigger = utility::function_10d135e2ebebca29( game_object_struct.target, "targetname", game_object_struct.origin, 64 );
        trigger.skip_deletion = 1;
    }
    
    if ( !isdefined( trigger ) )
    {
        trigger_group = trigger_group::get( game_object_struct.trigger_override );
    }
    
    if ( !isdefined( trigger ) && !isdefined( trigger_group ) )
    {
        if ( !istrue( 0 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x1df>" + game_object_struct.target );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Failed to find a trigger corresponding to the 'targetname' " + game_object_struct.target );
        }
        
        return;
    }
    
    init_properties = structcopy( level.game_objects.var_a929f69e5aaaa308[ getxhash( game_object_struct.game_object_name ) ], 1 );
    var_24290c36e2cab388 = init_properties.var_24290c36e2cab388;
    var_abb7aac0e7708b72 = init_properties.var_abb7aac0e7708b72;
    additional_params = init_properties.additional_params;
    var_24290c36e2cab388.origin = game_object_struct.origin;
    var_24290c36e2cab388.angles = game_object_struct.angles;
    var_24290c36e2cab388.script_label = game_object_struct.script_label;
    var_24290c36e2cab388.script_noteworthy = game_object_struct.script_noteworthy;
    var_24290c36e2cab388.chevrons = game_object_struct.chevrons;
    var_24290c36e2cab388.instance_id = game_object_struct.instance_id;
    var_24290c36e2cab388.objective_icon_offset = game_object_struct.objective_icon_offset ?? ( 0, 0, 0 );
    var_24290c36e2cab388.var_d7c90dc73c1dcba8 = game_object_struct.var_d7c90dc73c1dcba8 ?? ( 0, 0, 0 );
    
    if ( isstring( var_24290c36e2cab388.objective_icon_offset ) )
    {
        tokens = strtok( var_24290c36e2cab388.objective_icon_offset, " " );
        var_24290c36e2cab388.objective_icon_offset = ( float( tokens[ 0 ] ), float( tokens[ 1 ] ), float( tokens[ 2 ] ) );
    }
    
    if ( isstring( var_24290c36e2cab388.var_d7c90dc73c1dcba8 ) )
    {
        tokens = strtok( var_24290c36e2cab388.var_d7c90dc73c1dcba8, " " );
        var_24290c36e2cab388.var_d7c90dc73c1dcba8 = ( float( tokens[ 0 ] ), float( tokens[ 1 ] ), float( tokens[ 2 ] ) );
    }
    
    thread function_7a82b341701b1c88( game_object_struct.game_object_name, var_24290c36e2cab388, trigger ?? trigger_group, var_abb7aac0e7708b72, flat_args( additional_params.vararg, additional_params.varargcount ) );
}

// Namespace gameobjects_common
// Params 6, eflags: 0x44 variadic
// Checksum 0xd8d3122d, Offset: 0x2d86
// Size: 0x1eb
function private function_7a82b341701b1c88( game_object_name, var_24290c36e2cab388, var_1c1e374433af698d, var_abb7aac0e7708b72, ... )
{
    level endon( #"game_ended" );
    utility::flag_wait( "gameobject_system_post_init" );
    var_112235d348552d0 = game_utility_mp::function_4b7180ed8c2e9742( #"hash_14bb716c4b77c45a" );
    
    foreach ( entry in var_112235d348552d0.list )
    {
        game_object_definition = entry.variant_object;
        
        if ( game_object_definition.var_80258cc5fb500cc8 == game_object_name )
        {
            var_24290c36e2cab388.game_object_definition = game_object_definition;
            
            if ( !isdefined( var_24290c36e2cab388.origin ) )
            {
                var_24290c36e2cab388.origin = var_1c1e374433af698d.origin;
            }
            
            if ( !isdefined( var_24290c36e2cab388.angles ) )
            {
                var_24290c36e2cab388.angles = var_1c1e374433af698d.angles;
            }
            
            if ( !isdefined( var_24290c36e2cab388.script_label ) )
            {
                var_24290c36e2cab388.script_label = var_1c1e374433af698d.script_label;
            }
            
            if ( !isdefined( var_24290c36e2cab388.script_noteworthy ) )
            {
                var_24290c36e2cab388.script_noteworthy = var_1c1e374433af698d.script_noteworthy;
            }
            
            profilestart();
            function_34df2614cca949a8( var_24290c36e2cab388, var_1c1e374433af698d, var_abb7aac0e7708b72, flat_args( vararg, varargcount ) );
            profilestop();
            return;
        }
    }
    
    if ( !istrue( 0 ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x21b>" + game_object_name );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Failed to construct game object " + game_object_name );
    }
}

// Namespace gameobjects_common
// Params 5, eflags: 0x44 variadic
// Checksum 0xf9a06804, Offset: 0x2f79
// Size: 0x82f
function private function_34df2614cca949a8( var_24290c36e2cab388, var_1c1e374433af698d, var_abb7aac0e7708b72, ... )
{
    game_object_name = var_24290c36e2cab388.game_object_definition.var_80258cc5fb500cc8;
    
    if ( isdefined( var_24290c36e2cab388.script_label ) )
    {
        game_object_name += ":" + string( var_24290c36e2cab388.script_label );
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        foreach ( instance_id, combo_index in gameinstance::get_active_arenas() )
        {
            if ( var_24290c36e2cab388.script_noteworthy == action_park_utility::get_combo_label( combo_index ) )
            {
                var_24290c36e2cab388.instance_id = instance_id;
                game_object_name += ":" + string( instance_id );
                break;
            }
        }
    }
    
    game_object_name_hash = getxhash( game_object_name );
    
    if ( !istrue( !isdefined( level.game_objects.list[ game_object_name_hash ] ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x23c>" + game_object_name + "<dev string:x249>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Game object " + game_object_name + " has already been constructed" );
    }
    
    if ( !trigger_group::is_trigger_group( var_1c1e374433af698d ) && getdvarint( @"hash_5f02fc18fbd1f61f", 0 ) != 0 )
    {
        trigger_origin = utility::drop_to_ground( var_24290c36e2cab388.origin, 32, -1024 );
        trigger_1 = spawn( "noent_volume_trigger_rotatable_radius", trigger_origin + ( 32, 32, 0 ), 0, 64, 64 );
        trigger_1.radius = 64;
        trigger_1.height = 64;
        trigger_1.targetname = var_1c1e374433af698d.targetname;
        trigger_2 = spawn( "noent_volume_trigger_rotatable_radius", trigger_origin + ( 32, 0, 0 ), 0, 64, 64 );
        trigger_2.radius = 64;
        trigger_2.height = 64;
        trigger_2.targetname = var_1c1e374433af698d.targetname;
        trigger_3 = spawn( "noent_volume_trigger_rotatable_radius", trigger_origin + ( 0, 32, 0 ), 0, 64, 64 );
        trigger_3.radius = 64;
        trigger_3.height = 64;
        trigger_3.targetname = var_1c1e374433af698d.targetname;
        var_1c1e374433af698d = trigger_group::create( game_object_name_hash, [ trigger_1, trigger_2, trigger_3 ], var_1c1e374433af698d.origin, var_1c1e374433af698d.angles );
        var_1c1e374433af698d.script_label = var_24290c36e2cab388.script_label;
        var_1c1e374433af698d.script_noteworthy = var_24290c36e2cab388.script_noteworthy;
    }
    
    game_object = {};
    
    switch ( var_24290c36e2cab388.game_object_definition.type )
    {
        case 0:
            game_object.type_hash = #"gameobject_type_capture_zone";
            break;
        case 1:
            game_object.type_hash = #"gameobject_type_carry_object";
            break;
        case 2:
            game_object.type_hash = #"gameobject_type_use_object";
            break;
    }
    
    if ( trigger_group::is_trigger_group( var_1c1e374433af698d ) )
    {
        game_object.has_trigger_group = 1;
        game_object.trigger_group = var_1c1e374433af698d;
        trigger_group::disable( var_1c1e374433af698d );
    }
    else
    {
        game_object.trigger = var_1c1e374433af698d;
        var_1c1e374433af698d utility::trigger_off();
    }
    
    game_object.name_hash = game_object_name_hash;
    game_object.instance_id = var_24290c36e2cab388.instance_id;
    game_object.origin = var_24290c36e2cab388.origin;
    game_object.angles = var_24290c36e2cab388.angles;
    game_object.objective_key = var_24290c36e2cab388.script_label ?? game_object_name;
    game_object.objective_icon_offset = var_24290c36e2cab388.objective_icon_offset;
    game_object.var_c68e9f43ed9cc918 = var_24290c36e2cab388.var_c68e9f43ed9cc918;
    game_object.use_time_seconds = float( var_24290c36e2cab388.use_time_seconds );
    game_object.chevrons = var_24290c36e2cab388.chevrons ?? var_24290c36e2cab388.game_object_definition.var_7eea6a4d192284b4;
    game_object.var_5bf611fcc144cce6 = var_24290c36e2cab388.game_object_definition.var_2423e3de6556dd9b;
    
    if ( !istrue( isdefined( var_24290c36e2cab388.var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_24290c36e2cab388.var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_24290c36e2cab388.var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_24290c36e2cab388.var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x129>" + var_24290c36e2cab388.var_c68e9f43ed9cc918 + "<dev string:x72>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_24290c36e2cab388.var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !isdefined( level.game_objects.list ) )
    {
        level.game_objects.list = [];
    }
    
    level.game_objects.list[ game_object_name_hash ] = game_object;
    function_14088ca905f052c3( game_object, #"hash_aa89afe9cb4cc4a2", var_24290c36e2cab388 );
    
    if ( isdefined( game_object.usable_properties ) )
    {
        game_object.var_daaa29ac3e7ee276 = spawn( "script_origin", game_object.origin + var_24290c36e2cab388.var_d7c90dc73c1dcba8 );
        game_object.var_daaa29ac3e7ee276 hide();
        
        foreach ( player in level.players )
        {
            thread __interact_trigger_toggle_player_usability_thread__( game_object, player );
        }
        
        game_object thread function_9253ca80216fc1a4( game_object );
    }
    else if ( game_object.has_trigger_group )
    {
        var_333384ff46564ab3 = getdvarint( @"hash_b2edb988a224856c", 1 ) == 1;
        
        if ( game_object.has_trigger_group )
        {
            trigger_group::function_b130b2b8d424652d( game_object.trigger_group, &function_fa225fd7cc22e305, &function_f8b4251137bf9d21, game_object, var_333384ff46564ab3 );
        }
        else
        {
            trigger::makeenterexittrigger( game_object.trigger, &function_fa225fd7cc22e305, &function_f8b4251137bf9d21, game_object, var_333384ff46564ab3 );
        }
    }
    
    /#
        game_object thread function_24e227a70d543f38( game_object, game_object_name );
    #/
    
    function_14088ca905f052c3( game_object, #"hash_bff43ef3bcefe7fd", var_24290c36e2cab388 );
    queue_callback( game_object, #"hash_be764a9e97b1cfc3", undefined, 0 );
    [[ var_abb7aac0e7708b72 ]]( game_object, flat_args( vararg, varargcount ) );
}

// Namespace gameobjects_common
// Params 5, eflags: 0x44 variadic
// Checksum 0x8cdaf2e, Offset: 0x37b0
// Size: 0x313
function private function_cce4fabe8192a953( type_hash, var_abce42bc6a519a4e, var_60b1d215698f5667, ... )
{
    if ( !istrue( !utility::flag( "gameobject_system_post_init" ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x267>" + "<dev string:x2ad>" + "<dev string:x2c9>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Game object internal function pointer must be registered before the '" + "gameobject_system_post_init" + "' flag is set" );
    }
    
    if ( !istrue( type_hash == #"gameobject_type_capture_zone" || type_hash == #"gameobject_type_carry_object" || type_hash == #"gameobject_type_use_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x2d7>" + type_hash + "<dev string:x72>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object type hash '" + type_hash + "'" );
    }
    
    if ( !istrue( var_abce42bc6a519a4e == #"hash_aa89afe9cb4cc4a2" || var_abce42bc6a519a4e == #"hash_bff43ef3bcefe7fd" || var_abce42bc6a519a4e == #"hash_18df75cc57a54d20" || var_abce42bc6a519a4e == #"hash_53fdc082a3c4a3" || var_abce42bc6a519a4e == #"hash_9ac4aa0c62e211d1" || var_abce42bc6a519a4e == #"hash_b9c66d4b9cc93bfb" || var_abce42bc6a519a4e == #"hash_42277c66f5bf6cbe" || var_abce42bc6a519a4e == #"hash_3f6e412bf6d9eee0" || var_abce42bc6a519a4e == #"hash_2ab47527155f279d" || var_abce42bc6a519a4e == #"hash_d7b0f53e6809c433" || var_abce42bc6a519a4e == #"hash_27094dd06893389b" || var_abce42bc6a519a4e == #"hash_8fb85d546a6d8844" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x2f7>" + var_abce42bc6a519a4e + "<dev string:x72>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object internal function pointer hash '" + var_abce42bc6a519a4e + "'" );
    }
    
    if ( !istrue( !isdefined( level.game_objects.var_820db61e65599dce[ type_hash ][ var_abce42bc6a519a4e ] ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x32c>" + var_abce42bc6a519a4e + "<dev string:x72>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "A function pointer has already been registered for internal game object function pointer hash '" + var_abce42bc6a519a4e + "'" );
    }
    
    var_acd56077a46a701f = {};
    var_acd56077a46a701f.var_60b1d215698f5667 = var_60b1d215698f5667;
    var_acd56077a46a701f.additional_params = { #varargcount:varargcount, #vararg:vararg };
    
    if ( !isdefined( level.game_objects.var_820db61e65599dce ) )
    {
        level.game_objects.var_820db61e65599dce = [];
    }
    
    if ( !isdefined( level.game_objects.var_820db61e65599dce[ type_hash ] ) )
    {
        level.game_objects.var_820db61e65599dce[ type_hash ] = [];
    }
    
    if ( !isdefined( level.game_objects.var_820db61e65599dce[ type_hash ][ var_abce42bc6a519a4e ] ) )
    {
        level.game_objects.var_820db61e65599dce[ type_hash ][ var_abce42bc6a519a4e ] = var_acd56077a46a701f;
    }
}

// Namespace gameobjects_common
// Params 4, eflags: 0x44 variadic
// Checksum 0x33a211ca, Offset: 0x3acb
// Size: 0x214
function private function_14088ca905f052c3( game_object, var_abce42bc6a519a4e, ... )
{
    if ( !istrue( var_abce42bc6a519a4e == #"hash_aa89afe9cb4cc4a2" || var_abce42bc6a519a4e == #"hash_bff43ef3bcefe7fd" || var_abce42bc6a519a4e == #"hash_18df75cc57a54d20" || var_abce42bc6a519a4e == #"hash_53fdc082a3c4a3" || var_abce42bc6a519a4e == #"hash_9ac4aa0c62e211d1" || var_abce42bc6a519a4e == #"hash_b9c66d4b9cc93bfb" || var_abce42bc6a519a4e == #"hash_42277c66f5bf6cbe" || var_abce42bc6a519a4e == #"hash_3f6e412bf6d9eee0" || var_abce42bc6a519a4e == #"hash_2ab47527155f279d" || var_abce42bc6a519a4e == #"hash_d7b0f53e6809c433" || var_abce42bc6a519a4e == #"hash_27094dd06893389b" || var_abce42bc6a519a4e == #"hash_8fb85d546a6d8844" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x38c>" + var_abce42bc6a519a4e + "<dev string:x183>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object internal function pointer hash (" + var_abce42bc6a519a4e + ")" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    result = undefined;
    var_f0430f1cf9e9bff6 = level.game_objects.var_820db61e65599dce[ game_object.type_hash ];
    
    if ( isdefined( var_f0430f1cf9e9bff6 ) )
    {
        var_acd56077a46a701f = var_f0430f1cf9e9bff6[ var_abce42bc6a519a4e ];
        
        if ( isdefined( var_acd56077a46a701f ) )
        {
            var_60b1d215698f5667 = var_acd56077a46a701f.var_60b1d215698f5667;
            additional_params = var_acd56077a46a701f.additional_params;
            result = [[ var_60b1d215698f5667 ]]( game_object, flat_args( additional_params.vararg, additional_params.varargcount ), flat_args( vararg, varargcount ) );
        }
    }
    
    if ( var_abce42bc6a519a4e == #"hash_9ac4aa0c62e211d1" )
    {
        return ( isnumber( result ) ? int( result ) : undefined );
    }
    
    return result;
}

// Namespace gameobjects_common
// Params 3, eflags: 0x4
// Checksum 0xc939d27f, Offset: 0x3ce8
// Size: 0xb6
function private function_b560f068802a681e( game_object, event, params )
{
    if ( game_object.var_815d6837a699b29 )
    {
        game_object waittill( #"hash_cbc24607437b9c12" );
    }
    
    if ( !isdefined( game_object.var_ea03c5db70ec561d ) )
    {
        game_object.var_ea03c5db70ec561d = [];
    }
    
    game_object.var_ea03c5db70ec561d[ game_object.var_ea03c5db70ec561d.size ] = { #params:params, #event:event };
    game_object notify( #"hash_b2644b94a48acb47" );
    level endon( #"game_ended" );
    game_object endon( #"hash_b2644b94a48acb47" );
    waittillframeend();
    game_object thread function_cfc80613bb8e321c( game_object );
}

// Namespace gameobjects_common
// Params 1, eflags: 0xc
// Checksum 0x7ac113a7, Offset: 0x3da6
// Size: 0x142
function private function_cfc80613bb8e321c( game_object )
{
    self notify( #"hash_94b9be2af3372769" );
    self endon( #"hash_94b9be2af3372769" );
    level endon( #"game_ended" );
    game_object.var_815d6837a699b29 = 1;
    
    foreach ( callback in game_object.var_ea03c5db70ec561d )
    {
        if ( level.game_objects.var_1f53ebaf8dbac17d )
        {
            logstring( "[GAME OBJECT] " + "CALLBACK { event: " + callback.event + ", instant: false }" + " { name_hash: " + game_object.name_hash + " }" );
        }
        
        game_object callback::callback_sequence( callback.event, callback.params );
    }
    
    game_object.var_ea03c5db70ec561d = undefined;
    game_object.var_815d6837a699b29 = undefined;
    game_object notify( #"hash_cbc24607437b9c12" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0xc
// Checksum 0xe11046bc, Offset: 0x3ef0
// Size: 0x2bb
function private function_9253ca80216fc1a4( game_object )
{
    self notify( #"hash_e1bdd027f3605a2a" );
    self endon( #"hash_e1bdd027f3605a2a" );
    level endon( #"game_ended" );
    waittillframeend();
    game_object.var_daaa29ac3e7ee276 makeusable();
    game_object.var_daaa29ac3e7ee276 setusepriority( -4 );
    game_object.var_daaa29ac3e7ee276 setuseholdduration( "duration_none" );
    
    if ( game_object.usable_properties.var_21e894778072020f )
    {
        game_object.var_daaa29ac3e7ee276 setcursorhint( "HINT_BUTTON" );
    }
    else
    {
        game_object.var_daaa29ac3e7ee276 setcursorhint( "HINT_NOICON" );
    }
    
    if ( game_object.usable_properties.var_9d50a9cdc2744d7b )
    {
        game_object.var_daaa29ac3e7ee276 sethintonobstruction( "show" );
    }
    else
    {
        game_object.var_daaa29ac3e7ee276 sethintonobstruction( "hide" );
    }
    
    if ( isdefined( game_object.usable_properties.hinticon ) && game_object.usable_properties.hinticon != "" )
    {
        game_object.var_daaa29ac3e7ee276 sethinticon( game_object.usable_properties.hinticon );
    }
    
    if ( isdefined( game_object.usable_properties.hintstring ) )
    {
        game_object.var_daaa29ac3e7ee276 sethintstring( game_object.usable_properties.hintstring );
    }
    
    if ( isdefined( game_object.usable_properties.hintdisplayfov ) )
    {
        game_object.var_daaa29ac3e7ee276 sethintdisplayfov( game_object.usable_properties.hintdisplayfov );
    }
    
    if ( isdefined( game_object.usable_properties.hintdisplayrange ) )
    {
        game_object.var_daaa29ac3e7ee276 sethintdisplayrange( game_object.usable_properties.hintdisplayrange );
    }
    
    if ( isdefined( game_object.usable_properties.usefov ) )
    {
        game_object.var_daaa29ac3e7ee276 setusefov( game_object.usable_properties.usefov );
    }
    
    if ( isdefined( game_object.usable_properties.userange ) )
    {
        game_object.var_daaa29ac3e7ee276 setuserange( game_object.usable_properties.userange );
    }
    
    while ( true )
    {
        game_object.var_daaa29ac3e7ee276 waittill( #"trigger", player );
        player thread function_bedde0b15c5ca036( game_object, player );
    }
}

// Namespace gameobjects_common
// Params 2, eflags: 0xc
// Checksum 0xb3746066, Offset: 0x41b3
// Size: 0xba
function private function_bedde0b15c5ca036( game_object, player )
{
    self notify( #"hash_ca8a6628e557cb9a" );
    self endon( #"hash_ca8a6628e557cb9a" );
    level endon( #"game_ended" );
    
    if ( function_af7d5b7489a26bbc( game_object, player ) )
    {
        game_object.var_daaa29ac3e7ee276 hidefromplayer( player );
        var_97d59c1b11c3cf1d = isdefined( game_object.used );
        
        while ( function_6057f2c78ba2b3a2( game_object, player ) && player usebuttonpressed( 1 ) && var_97d59c1b11c3cf1d == isdefined( game_object.used ) )
        {
            waitframe();
        }
        
        function_bb00dd80a5b5365c( game_object, player );
        game_object.var_daaa29ac3e7ee276 showtoplayer( player );
    }
}

// Namespace gameobjects_common
// Params 2, eflags: 0x4
// Checksum 0xcf391871, Offset: 0x4275
// Size: 0x1c4
function private __interact_trigger_toggle_player_usability_thread__( game_object, player )
{
    entity_id = player getentitynumber();
    game_object notify( "__interact_trigger_toggle_player_usability_thread__" + entity_id );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    game_object endon( "__interact_trigger_toggle_player_usability_thread__" + entity_id );
    
    if ( game_object.var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" || game_object.var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" && !game_utility_mp::is_attacker_team( player.team ) || game_object.var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" && !game_utility_mp::is_defender_team( player.team ) )
    {
        game_object.var_daaa29ac3e7ee276 disableplayeruse( player );
        game_object.var_daaa29ac3e7ee276 hidefromplayer( player );
        return;
    }
    
    waittillframeend();
    
    while ( true )
    {
        if ( game_object.carrier == player )
        {
            var_c7e8f37c220e9d96 = undefined;
            game_object.var_daaa29ac3e7ee276 disableplayeruse( player );
            game_object.var_daaa29ac3e7ee276 hidefromplayer( player );
            game_object waittill( #"carry_object_dropped" );
            continue;
        }
        
        var_91f29fae216e40e2 = function_5e4346091ac030c0( game_object, player );
        
        if ( !isdefined( var_c7e8f37c220e9d96 ) )
        {
            var_c7e8f37c220e9d96 = undefined;
        }
        
        if ( var_c7e8f37c220e9d96 != var_91f29fae216e40e2 )
        {
            if ( var_91f29fae216e40e2 )
            {
                game_object.var_daaa29ac3e7ee276 enableplayeruse( player );
                game_object.var_daaa29ac3e7ee276 showtoplayer( player );
            }
            else
            {
                game_object.var_daaa29ac3e7ee276 disableplayeruse( player );
                game_object.var_daaa29ac3e7ee276 hidefromplayer( player );
            }
            
            var_c7e8f37c220e9d96 = var_91f29fae216e40e2;
        }
        
        waitframe();
    }
}

// Namespace gameobjects_common
// Params 3, eflags: 0x4
// Checksum 0x8bd42a06, Offset: 0x4441
// Size: 0x28
function private function_fa225fd7cc22e305( player, trigger, game_object )
{
    function_af7d5b7489a26bbc( game_object, player );
}

// Namespace gameobjects_common
// Params 3, eflags: 0x4
// Checksum 0xf8549073, Offset: 0x4471
// Size: 0x28
function private function_f8b4251137bf9d21( player, trigger, game_object )
{
    function_bb00dd80a5b5365c( game_object, player );
}

// Namespace gameobjects_common
// Params 3, eflags: 0x4
// Checksum 0x5cea4a18, Offset: 0x44a1
// Size: 0x28, Type: bool
function private function_9abee9cf873fd0bb( player, trigger, game_object )
{
    return !function_5e4346091ac030c0( game_object, player );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x72d96a4, Offset: 0x44d2
// Size: 0x25a
function private function_43d4d17cde97f823( game_object )
{
    game_object notify( #"hash_547fdc62fd416988" );
    level endon( #"game_ended" );
    game_object endon( #"game_object_deactivated" );
    game_object endon( #"hash_547fdc62fd416988" );
    waittillframeend();
    
    while ( function_6bfea8a5a1055c3f( game_object ) )
    {
        claim_team_name = game_object.update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : game_object.update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
        var_b19ce51dfc12b7f8 = { #progress:game_object.update_struct.progress, #claim_team_name:claim_team_name };
        queue_callback( game_object, #"hash_47fedf1df6eafa30", var_b19ce51dfc12b7f8, 0 );
        waitframe();
    }
    
    if ( game_object.update_struct.status == #"hash_6b016a28066286ff" )
    {
        if ( isdefined( game_object.usable_properties ) )
        {
            if ( isdefined( game_object.used ) )
            {
                game_object.used = undefined;
            }
            else
            {
                game_object.used = 1;
            }
        }
        
        var_dbd0d4c325a7ae15 = game_object.players_using[ game_object.update_struct.var_536395db3d80fedb ][ 0 ];
        var_2b03add3a518dea6 = utility::array_slice( game_object.players_using[ game_object.update_struct.var_536395db3d80fedb ], 1 );
        var_b19ce51dfc12b7f8 = { #var_2b03add3a518dea6:var_2b03add3a518dea6, #var_dbd0d4c325a7ae15:var_dbd0d4c325a7ae15 };
        queue_callback( game_object, #"hash_a1e02ee2cc2ad28e", var_b19ce51dfc12b7f8, 0 );
        game_object.update_struct = undefined;
    }
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x506be0a3, Offset: 0x4734
// Size: 0x2b5, Type: bool
function private function_6bfea8a5a1055c3f( game_object )
{
    if ( !game_object.activated )
    {
        return false;
    }
    
    if ( isdefined( game_object.players_using ) )
    {
        foreach ( players_using in game_object.players_using )
        {
            foreach ( player in players_using )
            {
                if ( !function_5e4346091ac030c0( game_object, player ) )
                {
                    function_bb00dd80a5b5365c( game_object, player );
                }
            }
        }
    }
    
    if ( !isdefined( game_object.update_struct ) )
    {
        game_object.update_struct = { #var_18a3bf3521fb80fb:1, #current_segment:0, #progress:0 };
    }
    
    function_14088ca905f052c3( game_object, #"hash_42277c66f5bf6cbe", game_object.update_struct );
    
    if ( game_object.update_struct.var_18a3bf3521fb80fb )
    {
        update_struct = game_object.update_struct;
        update_struct.use_time_scalar = 1;
        update_struct.status = #"hash_1a786ad33a1c9a9";
        update_struct.var_18a3bf3521fb80fb = 0;
        use_time_seconds = get_use_time_seconds( game_object );
        
        if ( use_time_seconds > 0 )
        {
            update_struct.use_time_scalar /= use_time_seconds;
        }
        
        game_object.update_struct = update_struct;
    }
    
    function_14088ca905f052c3( game_object, #"hash_3f6e412bf6d9eee0", game_object.update_struct );
    function_14088ca905f052c3( game_object, #"hash_2ab47527155f279d", game_object.update_struct );
    game_object.update_struct.var_18a3bf3521fb80fb |= game_object.update_struct.status == #"hash_64b95fcceb630072";
    return game_object.update_struct.status == #"hash_1a786ad33a1c9a9";
}

// Namespace gameobjects_common
// Params 2, eflags: 0x4
// Checksum 0x87dabb49, Offset: 0x49f2
// Size: 0x294, Type: bool
function private function_af7d5b7489a26bbc( game_object, player )
{
    if ( function_5e4346091ac030c0( game_object, player ) && !function_6057f2c78ba2b3a2( game_object, player ) )
    {
        var_c68e9f43ed9cc918 = player.team == "all" || player.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( player.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( player.team ) ? #"hash_ce911e3bbe99421f" : player.team == "none" || player.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
        
        if ( !istrue( var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" || var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x3c1>" + player.team + "<dev string:x72>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Unsupported player team '" + player.team + "'" + " { name_hash: " + game_object.name_hash + " }" );
        }
        
        if ( !isdefined( game_object.players_using ) )
        {
            game_object.players_using = [];
            queue_callback( game_object, #"hash_358d33b2497e2ce3", undefined, 0 );
        }
        
        if ( !isdefined( game_object.players_using[ var_c68e9f43ed9cc918 ] ) )
        {
            game_object.players_using[ var_c68e9f43ed9cc918 ] = [];
        }
        
        game_object.players_using[ var_c68e9f43ed9cc918 ][ game_object.players_using[ var_c68e9f43ed9cc918 ].size ] = player;
        
        if ( !isdefined( player.var_731e60cf67806edb[ game_object.objective_key ] ) )
        {
            player.var_731e60cf67806edb[ game_object.objective_key ] = [];
        }
        
        player.var_731e60cf67806edb[ game_object.objective_key ][ player.var_731e60cf67806edb[ game_object.objective_key ].size ] = game_object;
        var_b19ce51dfc12b7f8 = { #player:player };
        queue_callback( game_object, #"hash_3c955b1e6fcd76eb", var_b19ce51dfc12b7f8, 0 );
        thread function_43d4d17cde97f823( game_object );
        return true;
    }
    
    return false;
}

// Namespace gameobjects_common
// Params 3, eflags: 0x4
// Checksum 0xd68363d8, Offset: 0x4c8f
// Size: 0x240, Type: bool
function private function_bb00dd80a5b5365c( game_object, player, instant_callbacks )
{
    if ( isplayer( player ) && function_6057f2c78ba2b3a2( game_object, player ) )
    {
        foreach ( teamhash, players in game_object.players_using )
        {
            if ( arraycontains( players, player ) )
            {
                var_c68e9f43ed9cc918 = teamhash;
                break;
            }
        }
        
        if ( !istrue( var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" || var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x3c1>" + player.team + "<dev string:x72>" + "<dev string:x14d>" + game_object.name_hash + "<dev string:x15c>" );
            logstring( "[GAME OBJECT] " + "ASSERT: " + "Unsupported player team '" + player.team + "'" + " { name_hash: " + game_object.name_hash + " }" );
        }
        
        game_object.players_using[ var_c68e9f43ed9cc918 ] = arrayremove( game_object.players_using[ var_c68e9f43ed9cc918 ], player );
        
        if ( game_object.players_using[ var_c68e9f43ed9cc918 ].size == 0 )
        {
            game_object.players_using[ var_c68e9f43ed9cc918 ] = undefined;
        }
        
        if ( game_object.players_using.size == 0 )
        {
            game_object.players_using = undefined;
            queue_callback( game_object, #"hash_5d939c5f097361e9", undefined, istrue( instant_callbacks ) );
        }
        
        player.var_731e60cf67806edb[ game_object.objective_key ] = undefined;
        
        if ( player.var_731e60cf67806edb.size == 0 )
        {
            player.var_731e60cf67806edb = undefined;
        }
        
        var_b19ce51dfc12b7f8 = { #player:player };
        queue_callback( game_object, #"hash_45277be78cb54c51", var_b19ce51dfc12b7f8, istrue( instant_callbacks ) );
        thread function_43d4d17cde97f823( game_object );
        return true;
    }
    
    return false;
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x884dd1b2, Offset: 0x4ed8
// Size: 0xca
function private function_d8f595b657e0431a( player )
{
    if ( isdefined( level.game_objects.list ) )
    {
        foreach ( game_object in level.game_objects.list )
        {
            if ( isdefined( game_object.usable_properties ) )
            {
                thread __interact_trigger_toggle_player_usability_thread__( game_object, player );
            }
            
            function_14088ca905f052c3( game_object, #"hash_d7b0f53e6809c433", player );
        }
    }
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xfe909906, Offset: 0x4faa
// Size: 0xce
function private function_91415420e8b1b2b0( player )
{
    if ( isdefined( level.game_objects.list ) )
    {
        foreach ( game_object in level.game_objects.list )
        {
            if ( game_object.var_c1b628bc3c716398 )
            {
                continue;
            }
            
            function_bb00dd80a5b5365c( game_object, player, 1 );
            function_14088ca905f052c3( game_object, #"hash_27094dd06893389b", player );
        }
    }
}

/#

    // Namespace gameobjects_common
    // Params 2, eflags: 0xc
    // Checksum 0xb6b747b4, Offset: 0x5080
    // Size: 0x8fe, Type: dev
    function private function_24e227a70d543f38( game_object, debug_name )
    {
        self notify( #"hash_fdb901caed53d425" );
        self endon( #"hash_fdb901caed53d425" );
        level endon( #"game_ended" );
        debug_update_struct = {};
        game_object.debug_update_struct = debug_update_struct;
        waittillframeend();
        
        while ( true )
        {
            if ( !( getdvarint( @"hash_e16c8525c6680130", 0 ) != 0 ) || level.players.size == 0 )
            {
                waitframe();
                continue;
            }
            
            debug_update_struct.draw_color = is_activated( game_object ) ? ( 0.235294, 0.862745, 0 ) : ( 0.862745, 0.235294, 0 );
            
            /#
                if ( !isdefined( game_object.debug_update_struct ) )
                {
                    game_object.debug_update_struct = {};
                }
                
                if ( !isdefined( game_object.debug_update_struct.strings ) )
                {
                    game_object.debug_update_struct.strings = [];
                }
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x3db>" ) + "<dev string:x3e0>" + debug_name;
            #/
            
            /#
                if ( !isdefined( game_object.debug_update_struct ) )
                {
                    game_object.debug_update_struct = {};
                }
                
                if ( !isdefined( game_object.debug_update_struct.strings ) )
                {
                    game_object.debug_update_struct.strings = [];
                }
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x3e3>" ) + "<dev string:x3e0>" + game_object.objective_key;
            #/
            
            /#
                if ( !isdefined( game_object.debug_update_struct ) )
                {
                    game_object.debug_update_struct = {};
                }
                
                if ( !isdefined( game_object.debug_update_struct.strings ) )
                {
                    game_object.debug_update_struct.strings = [];
                }
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x3f1>" ) + "<dev string:x3e0>" + get_use_team_name( game_object );
            #/
            
            /#
                if ( !isdefined( game_object.debug_update_struct ) )
                {
                    game_object.debug_update_struct = {};
                }
                
                if ( !isdefined( game_object.debug_update_struct.strings ) )
                {
                    game_object.debug_update_struct.strings = [];
                }
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x3fa>" ) + "<dev string:x3e0>" + get_use_time_seconds( game_object );
            #/
            
            function_14088ca905f052c3( game_object, #"hash_8fb85d546a6d8844", debug_update_struct );
            waittillframeend();
            
            if ( !debug_update_struct.var_f78a6245a4ee23c3 )
            {
                debug_text_origin = game_object.origin + ( 0, 0, debug_update_struct.strings.size * 3.5 );
                
                foreach ( string in debug_update_struct.strings )
                {
                    debug_text_origin -= ( 0, 0, 7 );
                    print3d( debug_text_origin, string, debug_update_struct.draw_color, 1, 0.5, 1, 0 );
                }
                
                if ( game_object.has_trigger_group )
                {
                    debug_update_struct.var_165d42d50591d151 = ( 0, 0.235294, 0.862745 );
                    debug_text_origin -= ( 0, 0, 7 );
                    print3d( debug_text_origin, "<dev string:x409>" + game_object.trigger_group.xhash_id, debug_update_struct.var_165d42d50591d151, 1, 0.5, 1, 0 );
                    debug_player = level.players[ 0 ];
                    best_trigger = undefined;
                    best_distance_squared = 262144;
                    var_1c4f4e7badb8b031 = cos( 30 );
                    
                    foreach ( trigger in game_object.trigger_group.triggers )
                    {
                        player_forward = anglestoforward( debug_player.angles );
                        to_trigger = trigger.origin - debug_player.origin;
                        angle_radians = vectordot( player_forward, vectornormalize( to_trigger ) );
                        
                        if ( angle_radians > var_1c4f4e7badb8b031 )
                        {
                            distance_squared = lengthsquared( to_trigger );
                            
                            if ( distance_squared < best_distance_squared )
                            {
                                best_trigger = trigger;
                                best_distance_squared = distance_squared;
                                var_1c4f4e7badb8b031 = angle_radians;
                            }
                        }
                    }
                    
                    foreach ( trigger in game_object.trigger_group.triggers )
                    {
                        if ( isent( trigger ) )
                        {
                            drawentitybounds( trigger, debug_update_struct.draw_color, 0, 1 );
                        }
                        else if ( isdefined( trigger.radius ) )
                        {
                            up = anglestoup( trigger.angles );
                            end = trigger.origin + up * trigger.height;
                            cylinder( trigger.origin, end, trigger.radius, debug_update_struct.draw_color, 0, 1 );
                        }
                        else
                        {
                            dimensions = trigger.size_min + trigger.size_max;
                            orientedbox( trigger.origin, dimensions, trigger.angles, debug_update_struct.draw_color, 0, 1 );
                        }
                        
                        if ( isdefined( best_trigger ) && trigger != best_trigger )
                        {
                            to = best_trigger.origin + ( 0, 0, 32 );
                            from = trigger.origin + ( 0, 0, 32 );
                            line( to, from, debug_update_struct.var_165d42d50591d151, 1, 0, 1 );
                        }
                    }
                }
                else if ( isdefined( game_object.trigger.radius ) )
                {
                    up_vector = anglestoup( game_object.trigger.angles );
                    end_position = game_object.trigger.origin + up_vector * game_object.trigger.height;
                    cylinder( game_object.trigger.origin, end_position, game_object.trigger.radius, debug_update_struct.draw_color, 0, 1 );
                }
                else if ( isent( game_object.trigger ) )
                {
                    drawentitybounds( game_object.trigger, debug_update_struct.draw_color, 0, 1 );
                }
                else
                {
                    dimensions = game_object.trigger.size_min + game_object.trigger.size_max;
                    orientedbox( game_object.trigger.origin, dimensions, game_object.trigger.angles, debug_update_struct.draw_color, 0, 1 );
                }
                
                if ( isdefined( game_object.var_daaa29ac3e7ee276 ) )
                {
                    debugaxis( game_object.var_daaa29ac3e7ee276.origin, game_object.var_daaa29ac3e7ee276.angles, undefined, undefined, undefined, 1 );
                }
            }
            
            debug_update_struct.strings = undefined;
            waitframe();
        }
    }

#/

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xc0dfb376, Offset: 0x5986
// Size: 0x56
function private function_43e308cf8b1d189d( type_hash )
{
    if ( type_hash == #"gameobject_type_capture_zone" )
    {
        return "capture_zone";
    }
    else if ( type_hash == #"gameobject_type_carry_object" )
    {
        return "carry_object";
    }
    else if ( type_hash == #"gameobject_type_use_object" )
    {
        return "use_object";
    }
    
    return "unknown";
}

// Namespace gameobjects_common
// Params 2, eflags: 0x4
// Checksum 0xbd4e712d, Offset: 0x59e5
// Size: 0xad
function private function_4f5136cd1d0f5062( game_object, team_hash )
{
    if ( !isdefined( team_hash ) )
    {
        return "";
    }
    
    team_name = team_hash == #"hash_a1360b18943e920" ? "all" : team_hash == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : team_hash == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : team_hash == #"hash_bb332da19f9944df" ? "none" : undefined;
    return team_name ?? "";
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xedbd1365, Offset: 0x5a9b
// Size: 0x110
function private function_f6e3e519a18d835c( game_object )
{
    players = [];
    
    if ( isdefined( game_object.players_using ) )
    {
        foreach ( team_players in game_object.players_using )
        {
            foreach ( player in team_players )
            {
                players = arraycombineunique( players, [ player ] );
            }
        }
    }
    
    return players;
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x2e5d3933, Offset: 0x5bb4
// Size: 0x1af
function private function_8bb9f484284af65( players )
{
    if ( !isdefined( players ) || players.size == 0 )
    {
        return "[]";
    }
    
    ids = [];
    max = 8;
    
    foreach ( player in players )
    {
        if ( ids.size >= max )
        {
            break;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        var_4d2ec7274a33c852 = player getplayerunoid() ?? "";
        
        if ( var_4d2ec7274a33c852 == "" )
        {
            continue;
        }
        
        quoted = "\"" + var_4d2ec7274a33c852 + "\"";
        ids = arraycombineunique( ids, [ quoted ] );
    }
    
    if ( ids.size == 0 )
    {
        return "[]";
    }
    
    result = "[";
    
    foreach ( i, id in ids )
    {
        if ( i > 0 )
        {
            result += ",";
        }
        
        result += id;
    }
    
    result += "]";
    return result;
}

// Namespace gameobjects_common
// Params 5, eflags: 0x4
// Checksum 0x5599324b, Offset: 0x5d6c
// Size: 0x243
function private function_bd6038246460d92e( game_object, action, previous_team_hash, current_team_hash, action_players )
{
    origin = game_object.origin ?? ( 0, 0, 0 );
    team_string = function_4f5136cd1d0f5062( game_object, current_team_hash ?? game_object.var_7f4958ce4e4277c3 ?? game_object.var_536395db3d80fedb ?? game_object.var_c68e9f43ed9cc918 );
    prev_team = function_4f5136cd1d0f5062( game_object, previous_team_hash );
    is_contested = istrue( game_object.is_contested );
    active_users = function_f6e3e519a18d835c( game_object );
    var_7311ff84fb8583b5 = function_8bb9f484284af65( active_users );
    var_263cb55f2c6d11f1 = isdefined( action_players ) ? function_8bb9f484284af65( action_players ) : "";
    dlog_recordevent( "dlog_event_mp_gameobject_state", [ "gameobject_type", function_43e308cf8b1d189d( game_object.type_hash ), "gameobject_name", game_object.objective_key ?? "", "gameobject_key", game_object.objective_key ?? "", "instance_id", game_object.instance_id ?? 0, "action", action, "team", team_string, "previous_team", prev_team, "is_active", istrue( game_object.activated ), "is_contested", is_contested, "origin_x", origin[ 0 ], "origin_y", origin[ 1 ], "origin_z", origin[ 2 ], "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "active_player_uno_ids", var_7311ff84fb8583b5, "action_player_uno_ids", var_263cb55f2c6d11f1 ] );
}

// Namespace gameobjects_common
// Params 5, eflags: 0x4
// Checksum 0x5dce15f9, Offset: 0x5fb7
// Size: 0x201
function private function_5439bb855aad6788( game_object, action, player, previous_team_hash, current_team_hash )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    origin = game_object.origin ?? ( 0, 0, 0 );
    team_string = function_4f5136cd1d0f5062( game_object, current_team_hash ?? game_object.var_7f4958ce4e4277c3 ?? game_object.var_536395db3d80fedb ?? game_object.var_c68e9f43ed9cc918 );
    prev_team = function_4f5136cd1d0f5062( game_object, previous_team_hash );
    player_team = player.team ?? "";
    is_contested = istrue( game_object.is_contested );
    player dlog_recordplayerevent( "dlog_event_mp_gameobject_player_state", [ "gameobject_type", function_43e308cf8b1d189d( game_object.type_hash ), "gameobject_name", game_object.objective_key ?? "", "gameobject_key", game_object.objective_key ?? "", "instance_id", game_object.instance_id ?? 0, "action", action, "team", team_string, "previous_team", prev_team, "player_team", player_team, "is_contested", is_contested, "origin_x", origin[ 0 ], "origin_y", origin[ 1 ], "origin_z", origin[ 2 ], "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x65e6fe33, Offset: 0x61c0
// Size: 0x23
function private function_75393e6660417174( params )
{
    function_bd6038246460d92e( params.game_object, "constructed" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x30d61c5, Offset: 0x61eb
// Size: 0x23
function private function_54ba81456f0287e7( params )
{
    function_bd6038246460d92e( params.game_object, "activated" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x8ca34963, Offset: 0x6216
// Size: 0x38
function private function_1264910f42c26b06( params )
{
    params.game_object.var_7c1063f52ddc7189 = undefined;
    function_bd6038246460d92e( params.game_object, "deactivated" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x21de5482, Offset: 0x6256
// Size: 0x23
function private function_58eac2caabdef3c7( params )
{
    function_bd6038246460d92e( params.game_object, "destroyed" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xf2009639, Offset: 0x6281
// Size: 0x23
function private function_e315979d6509705e( params )
{
    function_bd6038246460d92e( params.game_object, "moved" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x4d5c0ed7, Offset: 0x62ac
// Size: 0x65
function private function_e11ada8f14f6965( params )
{
    game_object = params.game_object;
    
    if ( game_object.var_7c1063f52ddc7189 || game_object.var_3baec90fe19817b3 )
    {
        return;
    }
    
    function_bd6038246460d92e( game_object, "claim_team_changed", game_object.var_feacd6e9542ddd64, game_object.var_536395db3d80fedb );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xee4acc94, Offset: 0x6319
// Size: 0x65
function private function_522324b02625598d( params )
{
    game_object = params.game_object;
    
    if ( game_object.var_7c1063f52ddc7189 || game_object.var_3baec90fe19817b3 )
    {
        return;
    }
    
    function_bd6038246460d92e( game_object, "owning_team_changed", game_object.var_54c587af6e056efe, game_object.var_7f4958ce4e4277c3 );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x74b58760, Offset: 0x6386
// Size: 0x39
function private function_c147facdf026f049( params )
{
    function_bd6038246460d92e( params.game_object, "contested", undefined, params.game_object.var_536395db3d80fedb );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xfa851574, Offset: 0x63c7
// Size: 0x39
function private function_493a87ac427cdb54( params )
{
    function_bd6038246460d92e( params.game_object, "uncontested", undefined, params.game_object.var_536395db3d80fedb );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x56f7b201, Offset: 0x6408
// Size: 0x23
function private function_38a86e033cf96ff7( params )
{
    function_bd6038246460d92e( params.game_object, "unoccupied" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xdc92506b, Offset: 0x6433
// Size: 0x23
function private function_65c8a8189b8fee75( params )
{
    function_bd6038246460d92e( params.game_object, "neutralized" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xfaa543b1, Offset: 0x645e
// Size: 0x23
function private function_68169fb3f4385863( params )
{
    function_bd6038246460d92e( params.game_object, "returned_home" );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x122c96f8, Offset: 0x6489
// Size: 0x45
function private function_8081273b32ddcdaf( params )
{
    if ( get_use_time_seconds( params.game_object ) == 0 )
    {
        return;
    }
    
    function_5439bb855aad6788( params.game_object, "use_complete", params.var_dbd0d4c325a7ae15 );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xcd36a786, Offset: 0x64d6
// Size: 0x2e
function private function_df9002ec0a740144( params )
{
    function_5439bb855aad6788( params.game_object, "picked_up", params.player );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xee838256, Offset: 0x650c
// Size: 0x3d
function private function_e3b5a4c71ce8292e( params )
{
    if ( isdefined( params.player ) )
    {
        function_5439bb855aad6788( params.game_object, "dropped", params.player );
    }
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xf19e2f68, Offset: 0x6551
// Size: 0x65
function private function_ba720c6f50b70b2a( params )
{
    game_object = params.game_object;
    
    if ( game_object.var_7c1063f52ddc7189 || game_object.var_3baec90fe19817b3 )
    {
        return;
    }
    
    current_users = function_f6e3e519a18d835c( game_object );
    function_bd6038246460d92e( game_object, "using_players_changed", undefined, undefined, current_users );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xa0f432b7, Offset: 0x65be
// Size: 0xef
function private function_8ac5db2cb3c310f6( params )
{
    params.game_object.var_3baec90fe19817b3 = undefined;
    action_players = [];
    
    if ( isdefined( params.var_dbd0d4c325a7ae15 ) )
    {
        action_players[ action_players.size ] = params.var_dbd0d4c325a7ae15;
        
        if ( isdefined( params.var_2b03add3a518dea6 ) )
        {
            foreach ( var_bc5b68d5112061e6 in params.var_2b03add3a518dea6 )
            {
                action_players[ action_players.size ] = var_bc5b68d5112061e6;
            }
        }
    }
    
    function_bd6038246460d92e( params.game_object, "captured", undefined, undefined, action_players );
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0x7f002a98, Offset: 0x66b5
// Size: 0x74
function private function_c1f0ff8c283649c3( params )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return;
    }
    
    game_object = params.var_1b55994025b9dc25;
    
    if ( isdefined( game_object ) && isdefined( params.player ) )
    {
        function_5439bb855aad6788( game_object, "bomb_planted", params.player );
    }
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xb1cc116, Offset: 0x6731
// Size: 0x74
function private function_8951c9109e6ea965( params )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return;
    }
    
    game_object = params.var_1b55994025b9dc25;
    
    if ( isdefined( game_object ) && isdefined( params.player ) )
    {
        function_5439bb855aad6788( game_object, "bomb_defused", params.player );
    }
}

// Namespace gameobjects_common
// Params 1, eflags: 0x4
// Checksum 0xacbd8345, Offset: 0x67ad
// Size: 0x5a
function private function_ffe6ccd4ca79fd8b( params )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return;
    }
    
    game_object = params.var_1b55994025b9dc25;
    
    if ( isdefined( game_object ) )
    {
        function_bd6038246460d92e( game_object, "bomb_detonated" );
    }
}

// Namespace gameobjects_common
// Params 0, eflags: 0x4
// Checksum 0xcd73e5c, Offset: 0x680f
// Size: 0x26f
function private function_61f93c0b00fdfe54()
{
    level callback::function_dc654a4d4126a928( #"hash_be764a9e97b1cfc3", #"hash_7fa900bfddf4cbf6", &function_75393e6660417174 );
    level callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_7fa900bfddf4cbf6", &function_54ba81456f0287e7 );
    level callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_7fa900bfddf4cbf6", &function_1264910f42c26b06 );
    level callback::function_dc654a4d4126a928( #"hash_b9cd6b90f747164c", #"hash_7fa900bfddf4cbf6", &function_58eac2caabdef3c7 );
    level callback::function_dc654a4d4126a928( #"hash_448cb8c640d827ef", #"hash_7fa900bfddf4cbf6", &function_e315979d6509705e );
    level callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_7fa900bfddf4cbf6", &function_e11ada8f14f6965 );
    level callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_7fa900bfddf4cbf6", &function_522324b02625598d );
    level callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_7fa900bfddf4cbf6", &function_c147facdf026f049 );
    level callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_7fa900bfddf4cbf6", &function_493a87ac427cdb54 );
    level callback::function_dc654a4d4126a928( #"hash_e3206e8d5d3df1e3", #"hash_7fa900bfddf4cbf6", &function_38a86e033cf96ff7 );
    level callback::function_dc654a4d4126a928( #"hash_33ab895f04e4eec9", #"hash_7fa900bfddf4cbf6", &function_65c8a8189b8fee75 );
    level callback::function_dc654a4d4126a928( #"hash_754b791c5072837b", #"hash_7fa900bfddf4cbf6", &function_68169fb3f4385863 );
    level callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_7fa900bfddf4cbf6", &function_8081273b32ddcdaf );
    level callback::function_dc654a4d4126a928( #"hash_249e26f937238db4", #"hash_7fa900bfddf4cbf6", &function_df9002ec0a740144 );
    level callback::function_dc654a4d4126a928( #"hash_a21546ba725310a2", #"hash_7fa900bfddf4cbf6", &function_e3b5a4c71ce8292e );
    level callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_7fa900bfddf4cbf6", &function_ba720c6f50b70b2a );
    level callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_7fa900bfddf4cbf6", &function_ba720c6f50b70b2a );
    level callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_7fa900bfddf4cbf6", &function_8ac5db2cb3c310f6 );
    callback::add( #"hash_4b88ae7136a85bfd", &function_c1f0ff8c283649c3 );
    callback::add( #"hash_e19a9f3d97f3e18f", &function_8951c9109e6ea965 );
    callback::add( #"hash_3a1fe5e4df493585", &function_ffe6ccd4ca79fd8b );
}

