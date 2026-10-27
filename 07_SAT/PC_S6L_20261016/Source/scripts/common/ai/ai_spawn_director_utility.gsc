// scripts\common\ai\ai_spawn_director_utility.gsc  (hash_72c560c01b74f3db.gscc) (size: 9618 Bytes / 0x2592 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8078fc26 (2155412518)
// size ...... 9618 (0x2592)
// includes .. 7   (offset: 0x2406)
// strings ... 16  (offset: 0x243e)
// dev strs .. 8   (offset: 0x2526)
// exports ... 35  (offset: 0x1682)
// cseg ...... 0x161 + 0x1521 (0x1682)
// imports ... 67  (offset: 0x1bfa)
// animtree1 . 0   (offset: 0x2592)
// animtree2 . 0   (offset: 0x2592)
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\spawn;
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;

#namespace ai_spawn_director;

/#

    // Namespace ai_spawn_director
    // Params 0
    // Checksum 0x2d3b1069, Offset: 0x17f
    // Size: 0x5, Type: dev
    function function_a7044e927fb98ef7()
    {
        
    }

#/

// Namespace ai_spawn_director
// Params 1
// Checksum 0xb1f26114, Offset: 0x18c
// Size: 0x2b
function spawn_encounter_targetname( enc_targetname )
{
    request_id = lookup_spawn_request( enc_targetname );
    function_ef57f478f96b050c( request_id, 1 );
    return request_id;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x9f99942b, Offset: 0x1c0
// Size: 0x72
function function_5916e5e063ec9645( var_7157a9997af97948, flag_spawn, flag_shutdown )
{
    request_id = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        request_id = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    if ( flag_spawn )
    {
        function_c99d360d62c49a9c( request_id, &flag_set_callback, flag_spawn );
    }
    
    if ( flag_shutdown )
    {
        function_53289c032f506bb1( request_id, &flag_set_callback, flag_shutdown );
    }
    
    function_ef57f478f96b050c( request_id, 1 );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xee3bbc37, Offset: 0x23a
// Size: 0x1e, Type: bool
function private flag_set_callback( request_id, userdata )
{
    return level utility::flag( userdata );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x40 variadic
// Checksum 0xd68802d3, Offset: 0x261
// Size: 0x63
function array_spawn_function_targetname( targetname, func, ... )
{
    assert( isdefined( func ), "<dev string:x24>" );
    array = [[ level.var_801f708fff2ed632 ]]( targetname, "targetname" );
    array_spawn_function( array, func, flat_args( vararg, varargcount ) );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x40 variadic
// Checksum 0x21e5c323, Offset: 0x2cc
// Size: 0x63
function array_spawn_function_noteworthy( noteworthy, func, ... )
{
    assert( isdefined( func ), "<dev string:x58>" );
    array = [[ level.var_801f708fff2ed632 ]]( noteworthy, "script_noteworthy" );
    array_spawn_function( array, func, flat_args( vararg, varargcount ) );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x40 variadic
// Checksum 0x6a1a9d3c, Offset: 0x337
// Size: 0xe1
function array_spawn_function( array, func, ... )
{
    assert( isdefined( func ), "<dev string:x8c>" );
    assert( isdefined( array ), "<dev string:xb5>" );
    assert( isarray( array ), "<dev string:xb5>" );
    assert( array.size, "<dev string:xca>" );
    
    foreach ( spawner in array )
    {
        spawner thread add_spawn_function( func, flat_args( vararg, varargcount ) );
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x40 variadic
// Checksum 0x66cb525b, Offset: 0x420
// Size: 0xf2
function add_spawn_function( function, ... )
{
    if ( !isdefined( self.spawn_functions ) )
    {
        self.spawn_functions = [];
    }
    
    foreach ( func_array in self.spawn_functions )
    {
        if ( func_array[ "function" ] == function )
        {
            return;
        }
    }
    
    func = [];
    func[ "function" ] = function;
    func[ "vararg" ] = vararg;
    func[ "varargcount" ] = varargcount;
    self.spawn_functions[ self.spawn_functions.size ] = func;
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xaf205ace, Offset: 0x51a
// Size: 0x25c
function array_spawn_targetname( targetname )
{
    spawners = [[ level.var_801f708fff2ed632 ]]( targetname, "targetname" );
    assert( isdefined( spawners ), "<dev string:xdf>" + targetname );
    assert( isarray( spawners ), "<dev string:xdf>" + targetname );
    assert( spawners.size, "<dev string:xdf>" + targetname );
    groupid = function_e19f6a00c4bb7490( targetname, 0, 1, 1, 1, 2 );
    assert( isdefined( groupid ), "<dev string:x10d>" );
    userdata = spawnstruct();
    userdata.ai_array = [];
    userdata.spawner_array = [];
    function_35aa3b1d92cd8207( "OnSpawned", groupid, &function_22bf8a44780c9038, userdata );
    function_35aa3b1d92cd8207( "FinishedSpawningGroup", groupid, &function_982baa735109012c, userdata );
    function_35aa3b1d92cd8207( "Shutdown", groupid, &function_43eed35c324d33bc, userdata );
    
    foreach ( spawner in spawners )
    {
        count = spawner.count ?? 1;
        aitypename = spawner.script_aitype ?? spawner.classname;
        aitypename = removesubstr( aitypename, "actor_" );
        
        for ( index = 0; index < count ; index++ )
        {
            var_6d63bc1fea0a37c2 = function_9893a28f1d682a28( groupid, aitypename, spawner.origin, spawner.angles, 3 );
            userdata.spawner_array[ var_6d63bc1fea0a37c2 ] = spawner;
        }
    }
    
    userdata waittill( #"group_spawned" );
    function_c9330a7e3d1eaef2( "OnSpawned", groupid );
    function_c9330a7e3d1eaef2( "FinishedSpawningGroup", groupid );
    function_c9330a7e3d1eaef2( "Shutdown", groupid );
    userdata.ai_array = utility::array_removedead_or_dying( userdata.ai_array );
    return userdata.ai_array;
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x40991f26, Offset: 0x77f
// Size: 0x38
function spawn_targetname( targetname, bforcespawn )
{
    ai_array = array_spawn_targetname( targetname );
    
    if ( ai_array.size == 1 )
    {
        return ai_array[ 0 ];
    }
    
    return ai_array;
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xb3218bf0, Offset: 0x7c0
// Size: 0x43
function private set_goal_height_from_settings()
{
    if ( isdefined( self.script_goalheight ) )
    {
        self.goalheight = self.script_goalheight;
        return;
    }
    
    if ( isdefined( level.default_goalheight ) )
    {
        self.goalheight = level.default_goalheight;
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x3603a2e4, Offset: 0x80b
// Size: 0xbf
function private function_ef858eb3faaa3f30( node )
{
    if ( isdefined( self.script_radius ) )
    {
        self.goalradius = self.script_radius;
        return;
    }
    
    if ( isdefined( self.script_forcegoal ) )
    {
        if ( isdefined( node ) && isdefined( node.radius ) )
        {
            self.goalradius = node.radius;
            return;
        }
    }
    
    if ( !isdefined( self getgoalvolume() ) )
    {
        if ( self.unittype == "juggernaut" )
        {
            return;
        }
        
        if ( self.type == "civilian" )
        {
            self.goalradius = 128;
            return;
        }
        
        if ( isdefined( level.default_goalradius ) )
        {
            self.goalradius = level.default_goalradius;
        }
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xac5d57b9, Offset: 0x8d2
// Size: 0x86
function get_ai_group_ai( aigroup )
{
    level._ai_group[ aigroup ].ai = utility::array_removedead_or_dying( level._ai_group[ aigroup ].ai );
    level._ai_group[ aigroup ].ai = function_5713d46873b29625( level._ai_group[ aigroup ].ai );
    return level._ai_group[ aigroup ].ai;
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x1757af68, Offset: 0x961
// Size: 0x63
function private aigroup_create( aigroup )
{
    assert( !isdefined( level._ai_group[ aigroup ] ) );
    level._ai_group[ aigroup ] = spawnstruct();
    level._ai_group[ aigroup ].ai = [];
    level._ai_group[ aigroup ].aideaths = 0;
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xaa6fa234, Offset: 0x9cc
// Size: 0xbe
function private aigroup_spawnerthink()
{
    if ( !isdefined( self.script_aigroup ) )
    {
        return;
    }
    
    if ( !isdefined( level._ai_group[ self.script_aigroup ] ) )
    {
        aigroup_create( self.script_aigroup );
    }
    
    aigroup = level._ai_group[ self.script_aigroup ];
    aigroup.ai[ aigroup.ai.size ] = self;
    
    if ( isdefined( self.script_deathflag_longdeath ) )
    {
        ai::function_68ee59bed92c0434();
    }
    else
    {
        self waittill( #"death" );
    }
    
    aigroup.aideaths++;
    aigroup.ai = arrayremove( aigroup.ai, self );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x2622739e, Offset: 0xa92
// Size: 0x3d3
function private function_22bf8a44780c9038( groupid, userdata, agent, var_6d63bc1fea0a37c2 )
{
    userdata.ai_array[ userdata.ai_array.size ] = agent;
    spawner = userdata.spawner_array[ var_6d63bc1fea0a37c2 ];
    
    if ( spawner.targetname )
    {
        agent.targetname = spawner.targetname;
    }
    
    agent ai::spawner_fields( spawner, 1 );
    agent.script_aigroup = spawner.script_aigroup;
    agent thread aigroup_spawnerthink();
    agent set_goal_height_from_settings();
    agent function_ef858eb3faaa3f30();
    
    if ( spawner.script_sightconfigtemplate )
    {
        agent setsightconfigtemplateoverride( spawner.script_sightconfigtemplate );
    }
    
    if ( isdefined( agent.script_stealthgroup ) )
    {
        agent callbacks::stealth_call_thread( "do_stealth" );
    }
    else if ( isdefined( agent.target ) )
    {
        agent thread ai_utility::go_to_node();
    }
    
    for ( i = 0; i < spawner.spawn_functions.size ; i++ )
    {
        func = spawner.spawn_functions[ i ];
        agent thread [[ func[ "function" ] ]]( flat_args( func[ "vararg" ], func[ "varargcount" ] ) );
    }
    
    if ( isdefined( spawner.var_703a9d2bea5984c3 ) && isdefined( level.var_88cc975aac78e7df ) )
    {
        var_712e82c09a1690 = getscriptbundle( "ai_director_custom_infil:" + spawner.var_703a9d2bea5984c3 );
        assert( isdefined( var_712e82c09a1690 ), "<dev string:x127>" + spawner.var_703a9d2bea5984c3 );
        infilstruct = var_712e82c09a1690.infilstruct;
        var_aa94c83a13cb3d8d = spawnstruct();
        var_aa94c83a13cb3d8d.origin = agent.origin;
        var_aa94c83a13cb3d8d.angles = agent.angles;
        var_aa94c83a13cb3d8d.var_bb14ca646f014c6f = ( infilstruct.forwardoffset ?? 0, infilstruct.rightoffset ?? 0, infilstruct.upoffset ?? 0 );
        var_aa94c83a13cb3d8d.var_26f814b25a85020d = ( infilstruct.pitchoffset ?? 0, infilstruct.yawoffset ?? 0, infilstruct.rolloffset ?? 0 );
        var_aa94c83a13cb3d8d.var_586750f761586b3 = infilstruct.var_586750f761586b3;
        var_aa94c83a13cb3d8d.var_94654d69cf1fe557 = infilstruct.rootpartname;
        var_aa94c83a13cb3d8d.var_bcb5c9e91d2117a7 = infilstruct.var_ea1ceb62e7aeeff0;
        var_aa94c83a13cb3d8d.var_c56260e2f2f1e4e9 = infilstruct.var_effc0837109ed1a;
        var_aa94c83a13cb3d8d.var_24ada7b3f042e1a8 = randomfloatrange( infilstruct.var_d03ca5df622dc978 ?? 1, infilstruct.var_48026cd82be090e ?? 10 );
        agent hide();
        agent utility::delaycall( 0.5, &show );
        agent thread [[ level.var_88cc975aac78e7df ]]( var_aa94c83a13cb3d8d );
        
        if ( isdefined( level.var_16f375d1b0d1c224 ) && isdefined( infilstruct.var_47054278f598c3e4 ) )
        {
            spawndata = spawnstruct();
            spawndata.origin = agent.origin;
            spawndata.angles = agent.angles;
            spawndata.animscripted_origin = agent.origin;
            spawndata.var_f40d13031ef5df3 = 1;
            thread [[ level.var_16f375d1b0d1c224 ]]( agent, spawndata, infilstruct.var_47054278f598c3e4 );
        }
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x340ef77e, Offset: 0xe6d
// Size: 0x2b
function private function_982baa735109012c( groupid, userdata, var_b06d38cf76935416 )
{
    userdata notify( #"group_spawned" );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xb2bba0c9, Offset: 0xea0
// Size: 0x22
function private function_43eed35c324d33bc( groupid, userdata )
{
    userdata notify( #"group_spawned" );
}

/#

    // Namespace ai_spawn_director
    // Params 0
    // Checksum 0x7036e3bf, Offset: 0xeca
    // Size: 0x5, Type: dev
    function function_6cb04a60a1a58e8a()
    {
        
    }

#/

// Namespace ai_spawn_director
// Params 1
// Checksum 0x1fc08fb, Offset: 0xed7
// Size: 0x33
function get_encounter_data( var_7157a9997af97948 )
{
    request_id = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        request_id = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    return function_9b649316adcccbaa( request_id );
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0xf7907c7e, Offset: 0xf13
// Size: 0x68, Type: bool
function function_287dedbe99ad813( var_7157a9997af97948, stealth_state )
{
    request_id = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        request_id = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    enc_data = function_9b649316adcccbaa( request_id );
    return enc_data.ai && utility::function_fd44d9723f2344f9( enc_data.ai, stealth_state );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x4dd16a94, Offset: 0xf84
// Size: 0x2b
function function_5d069e637e2d0a05( var_7157a9997af97948 )
{
    enc_data = get_encounter_data( var_7157a9997af97948 );
    return enc_data.ai;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xc4cb27f9, Offset: 0xfb8
// Size: 0x53, Type: bool
function function_16096fa7d6fa6642( var_7157a9997af97948, ai_count, invert_check = 0 )
{
    current_ai = function_5d069e637e2d0a05( var_7157a9997af97948 );
    
    if ( invert_check )
    {
        return ( !current_ai || current_ai.size <= ai_count );
    }
    
    return current_ai.size >= ai_count;
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x3fd3e820, Offset: 0x1014
// Size: 0x37, Type: bool
function function_580d43812763f207( var_7157a9997af97948, ai_count )
{
    enc_data = get_encounter_data( var_7157a9997af97948 );
    return enc_data.var_b7cabcb75223b342 > ai_count;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xe9347c61, Offset: 0x1054
// Size: 0x90
function function_7d541347ef601f75( var_7157a9997af97948, var_8331362949497b67, player_search_radius )
{
    request_id = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        request_id = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    level.var_400b44c398b1e1d7[ request_id ] = spawnstruct();
    level.var_400b44c398b1e1d7[ request_id ].fncallback = &function_8286b324cff036ed;
    level.var_400b44c398b1e1d7[ request_id ].data = player_search_radius;
    level thread function_69c6c76fc92cdf8a( request_id, var_8331362949497b67, player_search_radius );
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x5313293f, Offset: 0x10ec
// Size: 0xcc
function private function_69c6c76fc92cdf8a( request_id, var_8331362949497b67, player_search_radius )
{
    level endon( "ai_encounter_shutdown_" + request_id );
    level endon( "ai_encounter_despawning_" + request_id );
    function_f3a452b8eb085112( request_id, var_8331362949497b67 );
    enc_data = get_encounter_data( request_id );
    
    foreach ( guy in enc_data.ai )
    {
        guy function_8286b324cff036ed( player_search_radius );
    }
}

// Namespace ai_spawn_director
// Params 6
// Checksum 0xe5ccc2bc, Offset: 0x11c0
// Size: 0xf7
function function_e7e2017ed3ad21b6( var_7157a9997af97948, var_8331362949497b67, fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn )
{
    request_id = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        request_id = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    level.var_400b44c398b1e1d7[ request_id ] = spawnstruct();
    level.var_400b44c398b1e1d7[ request_id ].fncallback = &function_18e4fc11e5330ae9;
    level.var_400b44c398b1e1d7[ request_id ].fallback_goal = fallback_goal;
    level.var_400b44c398b1e1d7[ request_id ].check_sight = check_sight;
    level.var_400b44c398b1e1d7[ request_id ].var_adc97ec15b3ff2e8 = var_adc97ec15b3ff2e8;
    level.var_400b44c398b1e1d7[ request_id ].early_despawn = early_despawn;
    level thread function_f977c1a0b362cb03( request_id, var_8331362949497b67, fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn );
}

// Namespace ai_spawn_director
// Params 6, eflags: 0x4
// Checksum 0x16912858, Offset: 0x12bf
// Size: 0xeb
function private function_f977c1a0b362cb03( request_id, var_8331362949497b67, fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn )
{
    level endon( "ai_encounter_shutdown_" + request_id );
    level endon( "ai_encounter_despawning_" + request_id );
    function_f3a452b8eb085112( request_id, var_8331362949497b67 );
    enc_data = get_encounter_data( request_id );
    
    foreach ( guy in enc_data.ai )
    {
        guy thread function_18e4fc11e5330ae9( fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn );
    }
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x51df42f2, Offset: 0x13b2
// Size: 0x10d
function private function_18e4fc11e5330ae9( fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn )
{
    if ( isstruct( fallback_goal ) )
    {
        assert( isdefined( fallback_goal.origin ) );
        self setgoalpos( fallback_goal.origin );
    }
    else
    {
        self setgoalvolumeauto( fallback_goal );
    }
    
    self.goalradius = 32;
    
    if ( !early_despawn )
    {
        self waittill( #"goal" );
    }
    
    if ( check_sight || early_despawn )
    {
        while ( true )
        {
            if ( !isplayer( self.enemy ) )
            {
                break;
            }
            
            var_dc6e9a378cdaf910 = getinfluencedistanceatposition( self.origin );
            
            if ( !isdefined( var_adc97ec15b3ff2e8 ) )
            {
                var_adc97ec15b3ff2e8 = 300;
            }
            
            if ( !self seerecently( self.enemy, 3 ) && var_dc6e9a378cdaf910 >= var_adc97ec15b3ff2e8 )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    if ( self.unittype == "zombie" )
    {
        function_79b337fe2944db3d();
        return;
    }
    
    function_93e0e37fcbd3aec3( 1 );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xcac959b2, Offset: 0x14c7
// Size: 0xa1
function private function_f3a452b8eb085112( var_7157a9997af97948, var_8331362949497b67 )
{
    if ( !isdefined( var_8331362949497b67 ) )
    {
        return;
    }
    
    trigger_player_seek = var_8331362949497b67;
    
    if ( isstring( trigger_player_seek ) )
    {
        level utility::flag_wait( trigger_player_seek );
        return;
    }
    
    spawn_end = 0;
    
    while ( true )
    {
        enc_data = get_encounter_data( var_7157a9997af97948 );
        
        if ( enc_data.ai.size >= enc_data.var_f05db2e05804484d )
        {
            spawn_end = 1;
        }
        
        if ( spawn_end && enc_data.ai.size <= trigger_player_seek )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x9e3441fd, Offset: 0x1570
// Size: 0x15
function private function_8286b324cff036ed( player_search_radius )
{
    thread function_9f6f951d2357bc92( player_search_radius );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x637d1d7a, Offset: 0x158d
// Size: 0xa0
function private function_9f6f951d2357bc92( player_search_radius )
{
    self endon( #"death" );
    target_player = undefined;
    
    if ( !isdefined( player_search_radius ) )
    {
        player_search_radius = 518;
    }
    
    while ( true )
    {
        if ( !isalive( target_player ) )
        {
            if ( isplayer( self.enemy ) )
            {
                target_player = self.enemy;
            }
            else
            {
                near_players = sortbydistancecullbyradius( level.players, self.origin, player_search_radius );
                
                if ( near_players.size != 0 )
                {
                    target_player = near_players[ 0 ];
                }
            }
            
            if ( isalive( target_player ) )
            {
                self setgoalentity( target_player );
            }
        }
        
        waitframe();
    }
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0x6e9aded4, Offset: 0x1635
// Size: 0x40
function function_d59dab99e82f4264( fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn )
{
    self endon( #"death" );
    thread function_18e4fc11e5330ae9( fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn );
}

/#

    // Namespace ai_spawn_director
    // Params 0
    // Checksum 0x92e6f292, Offset: 0x167d
    // Size: 0x5, Type: dev
    function function_a226fca54b2fc06()
    {
        
    }

#/
