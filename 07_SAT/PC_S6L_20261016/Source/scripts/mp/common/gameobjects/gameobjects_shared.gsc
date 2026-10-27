// scripts\mp\common\gameobjects\gameobjects_shared.gsc  (hash_3af635ec59e4f533.gscc) (size: 7350 Bytes / 0x1cb6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff2ef07f (4281266303)
// size ...... 7350 (0x1cb6)
// includes .. 6   (offset: 0x1aea)
// strings ... 15  (offset: 0x1b1a)
// dev strs .. 11  (offset: 0x1bf2)
// exports ... 32  (offset: 0xeba)
// cseg ...... 0x10c + 0xdae (0xeba)
// imports ... 64  (offset: 0x13ba)
// animtree1 . 0   (offset: 0x1cb6)
// animtree2 . 0   (offset: 0x1cb6)
#using script_382bf8d77c4fd348;
#using scripts\common\utility;
#using scripts\mp\common\gameobjects\gameobjects_carryobject;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\game;
#using scripts\mp\gameobjects;

#namespace gameobjects_shared;

// Namespace gameobjects_shared
// Params 1
// Checksum 0x5028ab1d, Offset: 0x12a
// Size: 0x41
function activate( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        game_object gameobjects::enableobject();
        return;
    }
    
    gameobjects_common::activate( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x8aab5f75, Offset: 0x173
// Size: 0x41
function deactivate( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        game_object gameobjects::disableobject();
        return;
    }
    
    gameobjects_common::deactivate( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xf14acd2, Offset: 0x1bc
// Size: 0x3f
function is_activated( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_6d4a88740ad5cdc6();
    }
    
    return gameobjects_common::is_activated( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x3b3e70ae, Offset: 0x204
// Size: 0x42
function get_objective_key( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object.objectivekey;
    }
    
    return gameobjects_common::get_objective_key( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xbecc5859, Offset: 0x24f
// Size: 0x42
function get_trigger( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object.trigger;
    }
    
    return gameobjects_common::get_trigger( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xa3af843b, Offset: 0x29a
// Size: 0x3f
function get_origin( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getorigin();
    }
    
    return gameobjects_common::get_origin( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xdc1eae9a, Offset: 0x2e2
// Size: 0x4c
function function_63e25df7cfbb206f( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object.trigger.angles;
    }
    
    return gameobjects_common::function_63e25df7cfbb206f( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xabcc38d3, Offset: 0x337
// Size: 0x3f
function get_use_team_name( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getownerteam();
    }
    
    return gameobjects_common::get_use_team_name( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x5000c2db, Offset: 0x37f
// Size: 0x3f
function get_use_time_seconds( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getusetime();
    }
    
    return gameobjects_common::get_use_time_seconds( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x80b11dc1, Offset: 0x3c7
// Size: 0x3f
function is_in_use( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_b0c3f102b9d11f5e();
    }
    
    return gameobjects_common::is_in_use( game_object );
}

// Namespace gameobjects_shared
// Params 2
// Checksum 0x41337334, Offset: 0x40f
// Size: 0x5c
function function_5e4346091ac030c0( game_object, player )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::caninteractwith( player.pers[ "team" ], player );
    }
    
    return gameobjects_common::function_5e4346091ac030c0( game_object, player );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xee1fdb06, Offset: 0x474
// Size: 0x3f
function get_players_using( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_6f8e6c2be9ba58e1();
    }
    
    return gameobjects_common::get_players_using( game_object );
}

// Namespace gameobjects_shared
// Params 2
// Checksum 0x270d719c, Offset: 0x4bc
// Size: 0x1b1
function function_de2f4638a165d21c( game_object, use_team_name )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_2c38b77b2ae4bfc5( use_team_name );
    }
    
    if ( !istrue( isdefined( use_team_name == "all" || use_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( use_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( use_team_name ) ? #"hash_ce911e3bbe99421f" : use_team_name == "none" || use_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + use_team_name + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team name '" + use_team_name + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    var_c68e9f43ed9cc918 = use_team_name == "all" || use_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( use_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( use_team_name ) ? #"hash_ce911e3bbe99421f" : use_team_name == "none" || use_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    return gameobjects_common::function_de2f4638a165d21c( game_object, var_c68e9f43ed9cc918 );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xcbb38251, Offset: 0x676
// Size: 0xc8
function function_c3218a3e4808e36c( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        players_using = game_object gameobjects::function_6f8e6c2be9ba58e1();
        var_5a66aec5c083cd9a = [];
        
        foreach ( players in players_using )
        {
            var_5a66aec5c083cd9a = arraycombine( var_5a66aec5c083cd9a, players );
        }
        
        return var_5a66aec5c083cd9a;
    }
    
    return gameobjects_common::function_c3218a3e4808e36c( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x16220a3a, Offset: 0x747
// Size: 0x3f
function function_d071a38f7d43555a( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getclaimteam();
    }
    
    return namespace_277c922f0d0dc523::get_claim_team_name( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x8f0cbc24, Offset: 0x78f
// Size: 0x3f
function function_b94c7e25e2a759f7( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getlastclaimteam();
    }
    
    return namespace_277c922f0d0dc523::function_3deac49163837186( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x43f17018, Offset: 0x7d7
// Size: 0x3f
function function_623b07f4735aecb2( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getownerteam();
    }
    
    return namespace_277c922f0d0dc523::get_owning_team_name( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0xfd4d9087, Offset: 0x81f
// Size: 0x3f
function function_55c8ebe2dd649ae5( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_70f36e1166a5877b();
    }
    
    return namespace_277c922f0d0dc523::function_6f5941c8ee118d52( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x2b06b736, Offset: 0x867
// Size: 0x6b, Type: bool
function function_c4931586039098d6( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        owning_team = game_object gameobjects::getownerteam();
        return ( owning_team != "none" && owning_team != "neutral" && owning_team != "all" );
    }
    
    return namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x8f009e44, Offset: 0x8db
// Size: 0x46
function function_7ed0697b0eea44f8( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return ( game_object.curprogress ?? 0 );
    }
    
    return gameobjects_common::function_7ed0697b0eea44f8( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x8f009e47, Offset: 0x92a
// Size: 0x6a
function get_use_progress( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return ( game_object.usetime != 0 ? game_object.curprogress / game_object.usetime : 0 );
    }
    
    return gameobjects_common::get_use_progress( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x5f22b7c4, Offset: 0x99d
// Size: 0x3f
function function_3d275bfdb7872815( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::iscontested();
    }
    
    return namespace_277c922f0d0dc523::is_contested( game_object );
}

// Namespace gameobjects_shared
// Params 2
// Checksum 0x3bd37b7c, Offset: 0x9e5
// Size: 0x4c
function function_90a33d23016ebce8( game_object, player )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return ( game_object gameobjects::getcarrier() == player );
    }
    
    return gameobjects_carryobject::is_carrier( game_object, player );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x92700135, Offset: 0xa3a
// Size: 0x3f
function carryobject_get_carrier( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::getcarrier();
    }
    
    return gameobjects_carryobject::function_c4ee22bf08509215( game_object );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x276a8f46, Offset: 0xa82
// Size: 0x3f
function function_855bff02ac882f59( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        return game_object gameobjects::function_7a09c690be7cc095();
    }
    
    return gameobjects_carryobject::get_last_carrier( game_object );
}

// Namespace gameobjects_shared
// Params 4, eflags: 0x40 variadic
// Checksum 0x1b6ca5f9, Offset: 0xaca
// Size: 0x62
function function_5a2d24ac6af6b087( game_object, player, ... )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        game_object gameobjects::setpickedup( player, flat_args( vararg, varargcount ) );
        return;
    }
    
    gameobjects_carryobject::force_pickup( game_object, player );
}

// Namespace gameobjects_shared
// Params 1
// Checksum 0x1830d81c, Offset: 0xb34
// Size: 0x41
function carryobject_force_drop( game_object )
{
    if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        game_object gameobjects::setdropped();
        return;
    }
    
    gameobjects_carryobject::function_b13de5e9932320b7( game_object );
}

/#

    // Namespace gameobjects_shared
    // Params 2
    // Checksum 0x713f514c, Offset: 0xb7d
    // Size: 0x45, Type: dev
    function function_579ac2f7e66ed64f( game_object, skip )
    {
        if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
        {
            return;
        }
        
        gameobjects_common::function_579ac2f7e66ed64f( game_object, skip );
    }

    // Namespace gameobjects_shared
    // Params 2
    // Checksum 0xf08f5f4b, Offset: 0xbca
    // Size: 0x1cd, Type: dev
    function function_888ee960e9b05c6a( game_object, use_team_name )
    {
        if ( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
        {
            use_team_name = use_team_name == "<dev string:x6b>" ? "<dev string:x70>" : use_team_name;
            game_object gameobjects::setownerteam( use_team_name );
            return;
        }
        
        if ( !istrue( isdefined( use_team_name == "<dev string:x78>" || use_team_name == "<dev string:x7c>" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( use_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( use_team_name ) ? #"hash_ce911e3bbe99421f" : use_team_name == "<dev string:x6b>" || use_team_name == "<dev string:x70>" ? #"hash_bb332da19f9944df" : undefined ) ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x33>" + use_team_name + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
            logstring( "<dev string:x24>" + "<dev string:x80>" + "<dev string:x33>" + use_team_name + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        }
        
        var_c68e9f43ed9cc918 = use_team_name == "<dev string:x78>" || use_team_name == "<dev string:x7c>" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( use_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( use_team_name ) ? #"hash_ce911e3bbe99421f" : use_team_name == "<dev string:x6b>" || use_team_name == "<dev string:x70>" ? #"hash_bb332da19f9944df" : undefined;
        namespace_277c922f0d0dc523::function_5e0c23aa66d30871( game_object, var_c68e9f43ed9cc918 );
    }

#/

// Namespace gameobjects_shared
// Params 0, eflags: 0x5
// Checksum 0x10d49f0a, Offset: 0xd9f
// Size: 0x7d
function private autoexec __init__()
{
    utility::registersharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_c01b9c3b31e617fa", &get_origin );
    utility::registersharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_97db60d016bf64fa", &function_3d275bfdb7872815 );
    utility::registersharedfunc( #"hash_39e6cc78ff2e9d53", #"carryobject_force_drop", &carryobject_force_drop );
    
    /#
        utility::registersharedfunc( #"hash_39e6cc78ff2e9d53", #"hash_d7f5cf7eefee4ed7", &function_888ee960e9b05c6a );
    #/
}

// Namespace gameobjects_shared
// Params 2, eflags: 0x4
// Checksum 0x33e38efe, Offset: 0xe24
// Size: 0x95
function private function_1c67f1c11934c45( game_object, team_name )
{
    assert( !isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ), "<dev string:x89>" );
    
    if ( team_name == "none" || team_name == "codcaster" )
    {
        return team_name;
    }
    
    if ( team_name == "all" )
    {
        return "any";
    }
    
    owning_team = game_object gameobjects::getownerteam();
    
    if ( team_name == owning_team )
    {
        return "friendly";
    }
    
    return "enemy";
}

