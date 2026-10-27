// scripts\mp\common\gameobjects\gameobjects_carryobject.gsc  (hash_5888cb2732809dcc.gscc) (size: 12955 Bytes / 0x329b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3491cae (3813219502)
// size ...... 12955 (0x329b)
// includes .. 5   (offset: 0x2db3)
// strings ... 23  (offset: 0x2ddb)
// dev strs .. 16  (offset: 0x3097)
// exports ... 32  (offset: 0x218f)
// cseg ...... 0x289 + 0x1f06 (0x218f)
// imports ... 57  (offset: 0x268f)
// animtree1 . 0   (offset: 0x329b)
// animtree2 . 0   (offset: 0x329b)
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\game;
#using scripts\mp\outofbounds;

#namespace gameobjects_carryobject;

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0xd8d09582, Offset: 0x2a7
// Size: 0xb6, Type: bool
function is_carrier( game_object, player )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.carrier == player;
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0xdc5d43e2, Offset: 0x366
// Size: 0x18, Type: bool
function is_carrying( player )
{
    return isdefined( player.carry_object );
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0x576f4299, Offset: 0x387
// Size: 0xaa
function function_c4ee22bf08509215( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.carrier;
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0x31bace8d, Offset: 0x43a
// Size: 0xaa
function get_last_carrier( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.last_carrier;
}

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0x37ef7922, Offset: 0x4ed
// Size: 0x124
function set_return_home_position( game_object, position )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( isvector( position ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects argument 'position' to be a vector" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object.return_home_struct.origin = position;
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0xa84a95c6, Offset: 0x619
// Size: 0xb4
function get_return_home_position( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.return_home_struct.origin;
}

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0x4cb62e92, Offset: 0x6d6
// Size: 0x18d
function set_return_home_time( game_object, time_seconds )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( isnumber( time_seconds ) && time_seconds > 0 ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x96>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects argument 'time_seconds' to be a positive number" );
    }
    
    game_object.return_home_struct.var_da3a1cbbe694b617 = time_seconds;
    
    if ( !isdefined( game_object.carrier ) && game_object.return_home_struct.has_moved )
    {
        if ( isdefined( game_object.wait_time_start_ms ) )
        {
            time_waited_seconds = ( gettime() - game_object.wait_time_start_ms ) * 0.001;
            
            if ( time_waited_seconds >= time_seconds )
            {
                force_return_home( game_object );
            }
            else
            {
                game_object.return_home_struct.var_e2208455af4477d = time_seconds - time_waited_seconds;
            }
        }
        
        game_object thread function_5bdb6c755ae1d5fe( game_object );
    }
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0x4c3ce7a2, Offset: 0x86b
// Size: 0xd6
function function_ccfcf26cb7a6aaa4( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object.return_home_struct.var_da3a1cbbe694b617 = undefined;
    game_object notify( #"hash_a77ea896e6aa3c6f" );
    game_object.return_home_struct.wait_time_start_ms = undefined;
}

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0x96f80d95, Offset: 0x949
// Size: 0x1b4
function transition_carrier( game_object, player )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( isdefined( game_object.carrier ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xce>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "No players are carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( game_object.carrier != player ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xf7>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Unable to transition carriers to the player already carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object notify( #"hash_b9f8f5a9a410bc16" );
    profilestart();
    function_f787c47f64ec2ca8( game_object );
    function_f7bd246fadeae97e( game_object, game_object.last_carrier );
    function_d74c6a694dcbfc59( game_object, player );
    profilestop();
}

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0xe8182b05, Offset: 0xb05
// Size: 0xd3
function force_pickup( game_object, player )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !( isdefined( game_object.carrier ) && isdefined( player.carry_object ) ) )
    {
        function_d74c6a694dcbfc59( game_object, player, 1 );
    }
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0x9a9893c5, Offset: 0xbe0
// Size: 0xbc
function function_b13de5e9932320b7( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( isdefined( game_object.carrier ) )
    {
        game_object.var_66646fcceb16b26f = 1;
    }
}

// Namespace gameobjects_carryobject
// Params 2
// Checksum 0x95372b42, Offset: 0xca4
// Size: 0xce
function function_f20efc740638f6f1( game_object, position )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( isdefined( game_object.carrier ) )
    {
        game_object.force_drop_position = position;
        function_b13de5e9932320b7( game_object );
    }
}

// Namespace gameobjects_carryobject
// Params 1
// Checksum 0xd38eebfd, Offset: 0xd7a
// Size: 0xca
function force_return_home( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_carry_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_carry_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_carry_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object notify( #"hash_a77ea896e6aa3c6f" );
    game_object.return_home_struct.wait_time_start_ms = undefined;
    function_262face1068c6e5a( game_object );
}

// Namespace gameobjects_carryobject
// Params 0, eflags: 0x5
// Checksum 0x9987d662, Offset: 0xe4c
// Size: 0x42
function private autoexec __autoexec__()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        system::register( #"gameobjects_carryobject", #"gameobjects_common", &function_a53b566f98941da2, undefined );
    }
}

// Namespace gameobjects_carryobject
// Params 0, eflags: 0x4
// Checksum 0x21be3848, Offset: 0xe96
// Size: 0xe6
function private function_a53b566f98941da2()
{
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_carry_object", #"hash_aa89afe9cb4cc4a2", &function_a4eb4175aefac177 );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_carry_object", #"hash_b9c66d4b9cc93bfb", &function_ba29802e138b29fc );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_carry_object", #"hash_3f6e412bf6d9eee0", &function_6bfea8a5a1055c3f );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_carry_object", #"hash_27094dd06893389b", &function_91415420e8b1b2b0 );
    
    /#
        [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_carry_object", #"hash_8fb85d546a6d8844", &function_93a99be6fc27258b );
    #/
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0xd95c5bb2, Offset: 0xf84
// Size: 0xcf
function private function_a4eb4175aefac177( game_object, var_24290c36e2cab388 )
{
    game_object.manual_drop = var_24290c36e2cab388.game_object_definition.manualdrop;
    game_object.var_98165c6cf625ec4d = var_24290c36e2cab388.game_object_definition.var_b025f1dc031c7f78;
    game_object.return_home_struct = { #angles:var_24290c36e2cab388.angles, #origin:var_24290c36e2cab388.origin };
    
    if ( var_24290c36e2cab388.game_object_definition.usableproperties.enable )
    {
        game_object.usable_properties = var_24290c36e2cab388.game_object_definition.usableproperties;
    }
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0xfe91bee, Offset: 0x105b
// Size: 0xb4, Type: bool
function private function_ba29802e138b29fc( game_object, player )
{
    if ( game_object.var_66646fcceb16b26f )
    {
        return false;
    }
    
    if ( isdefined( player.carry_object ) && player.carry_object != game_object )
    {
        return false;
    }
    
    if ( isdefined( game_object.carrier ) )
    {
        if ( game_object.carrier != player )
        {
            return false;
        }
    }
    else if ( !isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        if ( !gameobjects_common::function_8a27a916a385b65c( game_object, player ) )
        {
            return false;
        }
    }
    
    entity_id = player getentitynumber();
    
    if ( isdefined( game_object.var_d5bb0aa29b226daf[ entity_id ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0xb35fbf02, Offset: 0x1118
// Size: 0x260
function private function_6bfea8a5a1055c3f( game_object, update_struct )
{
    update_struct.var_536395db3d80fedb = #"hash_bb332da19f9944df";
    
    foreach ( use_team_name in level.teamnamelist )
    {
        var_c68e9f43ed9cc918 = use_team_name == "all" || use_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( use_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( use_team_name ) ? #"hash_ce911e3bbe99421f" : use_team_name == "none" || use_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
        
        if ( gameobjects_common::function_de2f4638a165d21c( game_object, var_c68e9f43ed9cc918 ).size > 0 )
        {
            update_struct.var_536395db3d80fedb = var_c68e9f43ed9cc918;
            break;
        }
    }
    
    if ( update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" )
    {
        update_struct.status = #"hash_64b95fcceb630072";
        return;
    }
    
    if ( !isdefined( game_object.carrier ) )
    {
        if ( update_struct.use_time_scalar == 1 )
        {
            update_struct.status = #"hash_6b016a28066286ff";
        }
        else
        {
            update_struct.progress += level.framedurationseconds * update_struct.use_time_scalar;
            
            if ( update_struct.progress >= 1 )
            {
                update_struct.progress = 0;
                update_struct.status = #"hash_6b016a28066286ff";
            }
        }
        
        if ( update_struct.status == #"hash_6b016a28066286ff" )
        {
            carrier = game_object.players_using[ update_struct.var_536395db3d80fedb ][ 0 ];
            function_d74c6a694dcbfc59( game_object, carrier, 0 );
        }
        
        return;
    }
    
    update_struct.status = #"hash_6b016a28066286ff";
}

// Namespace gameobjects_carryobject
// Params 3, eflags: 0x4
// Checksum 0xbe4614d9, Offset: 0x1380
// Size: 0x225
function private function_2d39e24890da29b4( game_object, player, force_pickup )
{
    if ( !istrue( isdefined( game_object.carrier ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xce>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "No players are carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( isdefined( game_object.var_daaa29ac3e7ee276 ) )
    {
        game_object.var_daaa29ac3e7ee276 disableplayeruse( player );
    }
    
    var_c68e9f43ed9cc918 = player.team == "all" || player.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( player.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( player.team ) ? #"hash_ce911e3bbe99421f" : player.team == "none" || player.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    team_first_pickup = !isdefined( game_object.var_f7100a108cd234d7[ var_c68e9f43ed9cc918 ] );
    
    if ( team_first_pickup )
    {
        if ( !isdefined( game_object.var_f7100a108cd234d7 ) )
        {
            game_object.var_f7100a108cd234d7 = [];
        }
        
        game_object.var_f7100a108cd234d7[ var_c68e9f43ed9cc918 ] = 1;
    }
    
    gameobjects_common::deactivate( game_object );
    var_b19ce51dfc12b7f8 = { #force_pickup:force_pickup, #team_first_pickup:team_first_pickup, #player:player };
    gameobjects_common::queue_callback( game_object, #"hash_249e26f937238db4", var_b19ce51dfc12b7f8, 0 );
    game_object notify( #"hash_a77ea896e6aa3c6f" );
    game_object.return_home_struct.wait_time_start_ms = undefined;
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( game_object, 1 );
    #/
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0xc4fc5ff5, Offset: 0x15ad
// Size: 0x154
function private function_f7bd246fadeae97e( game_object, player )
{
    if ( !istrue( !isdefined( game_object.carrier ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x145>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "A player is still carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object.var_66646fcceb16b26f = undefined;
    game_object.has_moved = 1;
    gameobjects_common::update_origin( game_object, game_object.drop_position );
    gameobjects_common::function_37f390027536269c( game_object, game_object.drop_angles );
    gameobjects_common::activate( game_object );
    function_affabe070f4c15e6( player, 0 );
    game_object thread function_8fff6dd4d18d3790( game_object, player );
    game_object thread function_5bdb6c755ae1d5fe( game_object );
    var_b19ce51dfc12b7f8 = { #player:player };
    gameobjects_common::queue_callback( game_object, #"hash_a21546ba725310a2", var_b19ce51dfc12b7f8, 1 );
    level notify( #"carry_object_dropped", game_object );
    player notify( #"carry_object_dropped" );
    game_object notify( #"carry_object_dropped" );
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( game_object, level.bombplanted );
    #/
}

// Namespace gameobjects_carryobject
// Params 1, eflags: 0x4
// Checksum 0x8af19b1, Offset: 0x1709
// Size: 0x251
function private function_2c7f840579a25202( game_object )
{
    if ( !istrue( isdefined( game_object.carrier ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xce>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "No players are carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    player_angles = game_object.carrier getplayerangles( 1 );
    player_forward = vectornormalize( anglestoforward( player_angles ) );
    player_height = game_object.carrier geteye()[ 2 ] - game_object.carrier.origin[ 2 ];
    sphere_trace_radius = player_height * 0.5 - 1;
    
    if ( sphere_trace_radius <= 0 )
    {
        return;
    }
    
    drop_point = game_object.carrier.origin + 36 * player_forward;
    trace_start_point = game_object.carrier.origin + ( 0, 0, player_height * 0.5 );
    trace_end_point = drop_point + ( 0, 0, player_height * 0.5 );
    
    if ( !isdefined( ignore_list ) )
    {
        ignore_list = [];
    }
    
    ignore_list[ ignore_list.size ] = game_object.carrier;
    content_override = trace::create_solid_ai_contents( 1 );
    sphere_trace = trace::sphere_trace( trace_start_point, trace_end_point, sphere_trace_radius, ignore_list, content_override );
    
    /#
        game_object.debug_update_struct.manual_drop_sphere_trace = sphere_trace;
    #/
    
    if ( sphere_trace[ "fraction" ] == 1 )
    {
        trace_start_point = trace_end_point;
        trace_end_point = trace_start_point - ( 0, 0, player_height );
        ray_trace = trace::ray_trace( trace_start_point, trace_end_point, ignore_list, content_override );
        
        /#
            game_object.debug_update_struct.manual_drop_ray_trace = ray_trace;
        #/
        
        if ( ray_trace[ "fraction" ] < 1 && !outofbounds::ispointinoutofbounds( ray_trace[ "position" ] ) )
        {
            return { #normal:ray_trace[ "normal" ], #position:ray_trace[ "position" ] };
        }
    }
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0x1d094642, Offset: 0x1963
// Size: 0x80
function private function_affabe070f4c15e6( player, enable )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    command = player usinggamepad() ? "+actionslot 2" : "+armor";
    
    if ( enable )
    {
        player notifyonplayercommand( "manual_drop", command );
        player setclientomnvar( "ui_carry_object_can_drop", 1 );
        return;
    }
    
    player notifyonplayercommandremove( "manual_drop", command );
    player setclientomnvar( "ui_carry_object_can_drop", 0 );
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0xc
// Checksum 0xfbb9506c, Offset: 0x19eb
// Size: 0x63
function private function_e15900970b84dcdb( game_object, player )
{
    self notify( #"hash_80e0c8d5f66827c6" );
    self endon( #"hash_80e0c8d5f66827c6" );
    level endon( #"game_ended" );
    game_object endon( #"carry_object_dropped" );
    waittillframeend();
    player waittill( #"manual_drop" );
    game_object.var_66646fcceb16b26f = 1;
}

// Namespace gameobjects_carryobject
// Params 3, eflags: 0xc
// Checksum 0x5c17d552, Offset: 0x1a56
// Size: 0x196
function private function_a1a6e0870971c622( game_object, player, force_pickup )
{
    self notify( #"hash_97f251bde894652" );
    self endon( #"hash_97f251bde894652" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    game_object endon( #"hash_b9f8f5a9a410bc16" );
    waittillframeend();
    game_object.drop_position = player.origin;
    game_object.drop_angles = player.angles;
    manual_drop_enabled = 0;
    function_2d39e24890da29b4( game_object, player, force_pickup );
    
    if ( game_object.manual_drop )
    {
        game_object thread function_e15900970b84dcdb( game_object, player );
    }
    
    while ( gameobjects_common::function_5e4346091ac030c0( game_object, player ) )
    {
        var_c620d7130d574875 = function_2c7f840579a25202( game_object );
        var_a285fe60d121fd5c = manual_drop_enabled;
        manual_drop_enabled = game_object.manual_drop && isdefined( var_c620d7130d574875 );
        
        if ( isdefined( var_c620d7130d574875 ) )
        {
            game_object.drop_position = var_c620d7130d574875.position;
            game_object.drop_angles = generateaxisanglesfromupvector( var_c620d7130d574875.normal, player.angles );
        }
        
        if ( manual_drop_enabled != var_a285fe60d121fd5c )
        {
            function_affabe070f4c15e6( player, manual_drop_enabled );
        }
        
        waitframe();
    }
    
    if ( isdefined( game_object.force_drop_position ) )
    {
        game_object.drop_position = game_object.force_drop_position;
        game_object.force_drop_position = undefined;
    }
    
    function_f787c47f64ec2ca8( game_object );
    function_f7bd246fadeae97e( game_object, player );
}

// Namespace gameobjects_carryobject
// Params 3, eflags: 0x4
// Checksum 0xc606767e, Offset: 0x1bf4
// Size: 0xbc
function private function_d74c6a694dcbfc59( game_object, player, force_pickup )
{
    if ( !istrue( !isdefined( game_object.carrier ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x171>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "A player is already carrying this game object" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    game_object thread function_a1a6e0870971c622( game_object, player, force_pickup );
    game_object.carrier = player;
    game_object.carrier.carry_object = game_object;
}

// Namespace gameobjects_carryobject
// Params 1, eflags: 0x4
// Checksum 0x3795797a, Offset: 0x1cb8
// Size: 0x54
function private function_f787c47f64ec2ca8( game_object )
{
    if ( !isdefined( game_object.carrier ) )
    {
        return;
    }
    
    game_object.last_carrier = game_object.carrier;
    game_object.carrier.carry_object = undefined;
    game_object.carrier = undefined;
}

// Namespace gameobjects_carryobject
// Params 1, eflags: 0x4
// Checksum 0x6e03351, Offset: 0x1d14
// Size: 0x75
function private function_262face1068c6e5a( game_object )
{
    return_home_struct = game_object.return_home_struct;
    return_home_struct.wait_time_start_ms = undefined;
    return_home_struct.has_moved = undefined;
    gameobjects_common::update_origin( game_object, return_home_struct.origin );
    gameobjects_common::function_37f390027536269c( game_object, return_home_struct.angles );
    gameobjects_common::queue_callback( game_object, #"hash_754b791c5072837b", undefined, 0 );
}

// Namespace gameobjects_carryobject
// Params 1, eflags: 0xc
// Checksum 0xa8d99a52, Offset: 0x1d91
// Size: 0xe6
function private function_5bdb6c755ae1d5fe( game_object )
{
    self notify( #"hash_6b53007a4db893c4" );
    self endon( #"hash_6b53007a4db893c4" );
    level endon( #"game_ended" );
    game_object endon( #"hash_a77ea896e6aa3c6f" );
    
    if ( !isdefined( game_object.return_home_struct.var_da3a1cbbe694b617 ) )
    {
        return;
    }
    
    game_object.return_home_struct.wait_time_start_ms = gettime();
    
    if ( isdefined( game_object.return_home_struct.var_e2208455af4477d ) )
    {
        wait_time_seconds = game_object.return_home_struct.var_e2208455af4477d;
        game_object.return_home_struct.var_e2208455af4477d = undefined;
        wait wait_time_seconds;
    }
    else
    {
        wait game_object.return_home_struct.var_da3a1cbbe694b617;
    }
    
    function_262face1068c6e5a( game_object );
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0x81eb2c9c, Offset: 0x1e7f
// Size: 0x95
function private function_8fff6dd4d18d3790( game_object, player )
{
    level endon( #"game_ended" );
    entity_id = player getentitynumber();
    waittillframeend();
    
    if ( !isdefined( game_object.var_d5bb0aa29b226daf ) )
    {
        game_object.var_d5bb0aa29b226daf = [];
    }
    
    game_object.var_d5bb0aa29b226daf[ entity_id ] = player;
    wait game_object.var_98165c6cf625ec4d;
    game_object.var_d5bb0aa29b226daf[ entity_id ] = undefined;
    
    if ( game_object.var_d5bb0aa29b226daf.size == 0 )
    {
        game_object.var_d5bb0aa29b226daf = undefined;
    }
}

// Namespace gameobjects_carryobject
// Params 2, eflags: 0x4
// Checksum 0xe5fac347, Offset: 0x1f1c
// Size: 0x34
function private function_91415420e8b1b2b0( game_object, player )
{
    if ( is_carrier( game_object, player ) )
    {
        function_f787c47f64ec2ca8( game_object );
        function_f7bd246fadeae97e( game_object, player );
    }
}

/#

    // Namespace gameobjects_carryobject
    // Params 2, eflags: 0x4
    // Checksum 0x5466567e, Offset: 0x1f58
    // Size: 0x237, Type: dev
    function private function_93a99be6fc27258b( game_object, update_struct )
    {
        if ( isdefined( update_struct.manual_drop_sphere_trace ) )
        {
            draw_color = update_struct.manual_drop_sphere_trace[ "<dev string:x19f>" ] < 1 ? ( 1, 0.4, 0.4 ) : ( 0.4, 0.4, 1 );
            trace::draw_trace( update_struct.manual_drop_sphere_trace, draw_color, undefined, 1 );
            update_struct.manual_drop_sphere_trace = undefined;
        }
        
        if ( isdefined( update_struct.manual_drop_ray_trace ) )
        {
            draw_color = update_struct.manual_drop_ray_trace[ "<dev string:x19f>" ] < 1 ? ( 0.4, 1, 0.4 ) : ( 1, 0.4, 0.4 );
            trace::draw_trace( update_struct.manual_drop_ray_trace, draw_color, undefined, 1 );
            update_struct.manual_drop_ray_trace = undefined;
        }
        
        /#
            if ( !isdefined( game_object.debug_update_struct ) )
            {
                game_object.debug_update_struct = {};
            }
            
            if ( !isdefined( game_object.debug_update_struct.strings ) )
            {
                game_object.debug_update_struct.strings = [];
            }
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x1a8>" ) + "<dev string:x1ad>" + "<dev string:x1b0>";
        #/
        
        if ( isdefined( game_object.return_home_struct.time_seconds ) )
        {
            /#
                if ( !isdefined( game_object.debug_update_struct ) )
                {
                    game_object.debug_update_struct = {};
                }
                
                if ( !isdefined( game_object.debug_update_struct.strings ) )
                {
                    game_object.debug_update_struct.strings = [];
                }
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x1bd>" ) + "<dev string:x1ad>" + game_object.return_home_struct.var_da3a1cbbe694b617;
            #/
        }
    }

#/
