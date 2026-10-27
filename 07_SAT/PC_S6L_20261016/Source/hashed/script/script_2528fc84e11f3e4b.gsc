// script_2528fc84e11f3e4b  (hash_2528fc84e11f3e4b.gscc) (size: 4858 Bytes / 0x12fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46c70334 (1187447604)
// size ...... 4858 (0x12fa)
// includes .. 10  (offset: 0x11f6)
// strings ... 12  (offset: 0x1246)
// dev strs .. 1   (offset: 0x12ee)
// exports ... 16  (offset: 0xae6)
// cseg ...... 0x12c + 0x9ba (0xae6)
// imports ... 40  (offset: 0xd66)
// animtree1 . 0   (offset: 0x12fa)
// animtree2 . 0   (offset: 0x12fa)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;

#namespace namespace_80082437c22b4d6e;

// Namespace namespace_80082437c22b4d6e
// Params 1
// Checksum 0x7a6b864f, Offset: 0x14a
// Size: 0x48
function setup_participation_conditions( activity_instance )
{
    conditional_container::addcondition( activity_instance.participationconditions, &function_1cd278d54e539a4d, undefined, undefined, "Prematch has not yet completed." );
    conditional_container::addcondition( activity_instance.participationconditions, &function_c9db1f61203ebcd, undefined, undefined, "Player is not on the human team." );
}

// Namespace namespace_80082437c22b4d6e
// Params 2, eflags: 0x4
// Checksum 0xae23770c, Offset: 0x19a
// Size: 0x20
function private function_1cd278d54e539a4d( player, params )
{
    return flags::gameflag( "prematch_fade_done" );
}

// Namespace namespace_80082437c22b4d6e
// Params 2, eflags: 0x4
// Checksum 0xc68cd24b, Offset: 0x1c3
// Size: 0x26, Type: bool
function private function_c9db1f61203ebcd( player, params )
{
    return player.team == "allies";
}

// Namespace namespace_80082437c22b4d6e
// Params 4
// Checksum 0xafc7d9aa, Offset: 0x1f2
// Size: 0x74
function function_77688a5e67bd527f( encounter_id, user_data, agent, var_ca2ab9aefa6d2cfd )
{
    agent.activity_spawned = 1;
    var_81a5a78b4d1c8ec = utility::array_random( [ "run", "sprint", "super_sprint" ] );
    agent zombie_utils::function_a8ce00e0448cb6f0( var_81a5a78b4d1c8ec, "zombie_movement_type", 1 );
}

// Namespace namespace_80082437c22b4d6e
// Params 4
// Checksum 0xdc6ea67a, Offset: 0x26e
// Size: 0x198
function function_b9c4b4277cfc19bf( activity_instance, image, icon_origin, description )
{
    assert( image, "<dev string:x24>" );
    var_450c8b12e0e440c4 = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var_450c8b12e0e440c4 != -1 )
    {
        objidpoolmanager::objective_add_objective( var_450c8b12e0e440c4, "active", icon_origin, image );
        objidpoolmanager::update_objective_setbackground( var_450c8b12e0e440c4, 1 );
        objidpoolmanager::function_586b631e7bbb592a( var_450c8b12e0e440c4, 1 );
        
        if ( description )
        {
            objidpoolmanager::update_objective_description( var_450c8b12e0e440c4, description );
        }
        
        var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
        var_557d41c1e4ba8fc9 = arrayremove( var_557d41c1e4ba8fc9, level.blight_data.initial_infected );
        function_38b84cb3d4357dd7( var_450c8b12e0e440c4 );
        
        foreach ( player in var_557d41c1e4ba8fc9 )
        {
            objective_addclienttomask( var_450c8b12e0e440c4, player );
        }
        
        objective_showtoplayersinmask( var_450c8b12e0e440c4 );
        objective_setpingsforteam( var_450c8b12e0e440c4, "allies" );
        function_52ff09ba22610367( var_450c8b12e0e440c4, 0 );
        objective_settint( var_450c8b12e0e440c4, 237, 203, 86 );
        activity_instance.var_74af8104c44af9e5 = var_450c8b12e0e440c4;
    }
    
    if ( !level callback::exists( #"player_death", &function_7a70d42be25aa70a ) )
    {
        level callback::add( #"player_death", &function_7a70d42be25aa70a );
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 1, eflags: 0x4
// Checksum 0x39a29737, Offset: 0x40e
// Size: 0xf7
function private function_7a70d42be25aa70a( params )
{
    if ( !params.victim || params.victim.team != "allies" )
    {
        return;
    }
    
    foreach ( activity_instance in level.blight_data.var_300d6f8744c75f9c )
    {
        if ( activity_instance.state != "Active" )
        {
            continue;
        }
        
        if ( activity_instance.var_74af8104c44af9e5 )
        {
            objidpoolmanager::objective_playermask_hidefrom( activity_instance.var_74af8104c44af9e5, params.victim );
        }
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0x2d6f0c10, Offset: 0x50d
// Size: 0x89
function function_57e8668265b07078( activity_instance, activity_active = 1 )
{
    if ( activity_active )
    {
        if ( activity_instance.var_74af8104c44af9e5 )
        {
            objective_settint( activity_instance.var_74af8104c44af9e5, 45, 255, 119 );
        }
        
        activity_instance.var_1ffc13be888badbd = 1;
        return;
    }
    
    if ( activity_instance.var_74af8104c44af9e5 )
    {
        objective_settint( activity_instance.var_74af8104c44af9e5, 237, 203, 86 );
    }
    
    activity_instance.var_1ffc13be888badbd = 0;
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0xe81c5fa9, Offset: 0x59e
// Size: 0xd1
function function_8abdb71fd43f7130( activity_instance, players )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    if ( activity_instance.var_74af8104c44af9e5 )
    {
        foreach ( player in players )
        {
            if ( player.team == "allies" && isalive( player ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( activity_instance.var_74af8104c44af9e5, player );
            }
        }
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0xeec1e884, Offset: 0x677
// Size: 0xb3
function function_10f2ad982e66d1b( activity_instance, players )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    if ( activity_instance.var_74af8104c44af9e5 )
    {
        foreach ( player in players )
        {
            objidpoolmanager::objective_playermask_hidefrom( activity_instance.var_74af8104c44af9e5, player );
        }
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 1
// Checksum 0x97b6f2b0, Offset: 0x732
// Size: 0x51
function function_b25797193ea9d9db( activity_instance )
{
    if ( isdefined( activity_instance.var_74af8104c44af9e5 ) && activity_instance.var_74af8104c44af9e5 != -1 )
    {
        objidpoolmanager::objective_playermask_hidefromall( activity_instance.var_74af8104c44af9e5 );
        objidpoolmanager::returnobjectiveid( activity_instance.var_74af8104c44af9e5 );
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0xd91b2ec1, Offset: 0x78b
// Size: 0x93
function function_dab60f070f92291e( activity_instance, extra_params )
{
    if ( !activity_instance )
    {
        return;
    }
    
    players = activity_instance.playerparticipants;
    activityvariantdefinition = activity_instance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( isdefined( var_f2d9e7c8174d06a3 ) )
    {
        activityindex = function_43b5ed5a14a56573( #"scriptbundle_uiactivityinfo", var_f2d9e7c8174d06a3 );
        namespace_e55955ff7520be97::function_674cca638cafcae3( players, activity_instance, "ui_activity_index", activityindex, -1 );
    }
    
    function_5cdac4ed52d48636( activity_instance, extra_params );
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0xfb866d30, Offset: 0x826
// Size: 0xcd
function function_5cdac4ed52d48636( activity_instance, extra_params )
{
    if ( !activity_instance )
    {
        return;
    }
    
    players = extra_params.players ?? activity_instance.playerparticipants;
    
    if ( isdefined( extra_params.timer ) )
    {
        activity_definition_utils::updatetimer( extra_params.timer, activity_instance, { #players:players } );
    }
    
    if ( isdefined( extra_params.current_progress ) )
    {
        activity_definition_utils::updateprogress( extra_params.current_progress, activity_instance, extra_params.var_cf684f09b6c37c3a );
    }
    
    if ( isdefined( extra_params.step_index ) )
    {
        activity_definition_utils::function_a0a94881bc380bbf( extra_params.step_index, activity_instance, { #players:players } );
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0x6848e7a8, Offset: 0x8fb
// Size: 0x87
function function_36af27abcca0df47( activity_instance, players )
{
    if ( !activity_instance )
    {
        return;
    }
    
    activityvariantdefinition = activity_instance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( !isdefined( var_f2d9e7c8174d06a3 ) )
    {
        return;
    }
    
    activity_definition_utils::function_a0a94881bc380bbf( 0, activity_instance );
    
    if ( !isdefined( players ) )
    {
        players = activity_instance.playerparticipants;
    }
    
    if ( players && players.size > 0 )
    {
        namespace_e55955ff7520be97::function_674cca638cafcae3( players, activity_instance, "ui_activity_index", -1, -1 );
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0x1d7b449c, Offset: 0x98a
// Size: 0x9b
function function_52cc7a7f665dd279( activity_instance, player )
{
    if ( !isdefined( player.var_792cd370c8a86379[ activity_instance.id ] ) )
    {
        if ( !isdefined( player.var_792cd370c8a86379 ) )
        {
            player.var_792cd370c8a86379 = [];
        }
        
        player.var_792cd370c8a86379[ activity_instance.id ] = 1;
    }
    
    if ( player.var_792cd370c8a86379[ activity_instance.id ] )
    {
        activity_instance activity_player_broadcasting::function_cb4750c84882dd07( activity_instance.var_2e97f5b0db9f2142, [ player ] );
    }
}

// Namespace namespace_80082437c22b4d6e
// Params 2
// Checksum 0x5aa92665, Offset: 0xa2d
// Size: 0xb9
function function_f71e05d0dbeaa264( activity_instance, player )
{
    self notify( #"hash_190f553e05cc811c" );
    self endon( #"hash_190f553e05cc811c" );
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( player.var_792cd370c8a86379 ) )
    {
        player.var_792cd370c8a86379 = [];
    }
    
    player.var_792cd370c8a86379[ activity_instance.id ] = 0;
    wait 30;
    
    if ( activity_instance.state != "Active" )
    {
        return;
    }
    
    player.var_792cd370c8a86379[ activity_instance.id ] = 1;
}

