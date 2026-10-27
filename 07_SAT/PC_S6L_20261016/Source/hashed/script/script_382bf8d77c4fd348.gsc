// script_382bf8d77c4fd348  (hash_382bf8d77c4fd348.gscc) (size: 21581 Bytes / 0x544d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf651f5a6 (4132566438)
// size ...... 21581 (0x544d)
// includes .. 4   (offset: 0x4dd5)
// strings ... 14  (offset: 0x4df5)
// dev strs .. 21  (offset: 0x5179)
// exports ... 41  (offset: 0x40b1)
// cseg ...... 0x160 + 0x3f51 (0x40b1)
// imports ... 45  (offset: 0x4719)
// animtree1 . 0   (offset: 0x544d)
// animtree2 . 0   (offset: 0x544d)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\game;

#namespace namespace_277c922f0d0dc523;

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x62c530a7, Offset: 0x17e
// Size: 0xaa
function get_claim_team_hash( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_536395db3d80fedb;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xc0db5867, Offset: 0x231
// Size: 0x138
function get_claim_team_name( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : game_object.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x81038081, Offset: 0x372
// Size: 0xaa
function function_f559b5c2d3f6c691( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_feacd6e9542ddd64;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xc9a6a871, Offset: 0x425
// Size: 0x138
function function_3deac49163837186( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_feacd6e9542ddd64 == #"hash_a1360b18943e920" ? "all" : game_object.var_feacd6e9542ddd64 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_feacd6e9542ddd64 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_feacd6e9542ddd64 == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x2aef19cf, Offset: 0x566
// Size: 0xaa
function function_9b71aa2788e21706( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_7f4958ce4e4277c3;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xe7768fe7, Offset: 0x619
// Size: 0x138
function get_owning_team_name( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_7f4958ce4e4277c3 == #"hash_a1360b18943e920" ? "all" : game_object.var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xf8015a82, Offset: 0x75a
// Size: 0xaa
function function_42fe8a34960d7a25( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_54c587af6e056efe;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x13ab4746, Offset: 0x80d
// Size: 0x138
function function_6f5941c8ee118d52( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_54c587af6e056efe == #"hash_a1360b18943e920" ? "all" : game_object.var_54c587af6e056efe == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_54c587af6e056efe == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_54c587af6e056efe == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x8658eb65, Offset: 0x94e
// Size: 0xaa
function function_a33241bbed7a745d( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_d07b2b95cdf20f0c;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xa786e307, Offset: 0xa01
// Size: 0x138
function get_progress_team_name( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_d07b2b95cdf20f0c == #"hash_a1360b18943e920" ? "all" : game_object.var_d07b2b95cdf20f0c == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_d07b2b95cdf20f0c == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_d07b2b95cdf20f0c == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x2c5a18e9, Offset: 0xb42
// Size: 0xaa
function function_ab63c363d54ec6b2( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_dd8d8f32ef3f67c5;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x8525d0f0, Offset: 0xbf5
// Size: 0x138
function function_21123da20e2652d( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_dd8d8f32ef3f67c5 == #"hash_a1360b18943e920" ? "all" : game_object.var_dd8d8f32ef3f67c5 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_dd8d8f32ef3f67c5 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_dd8d8f32ef3f67c5 == #"hash_bb332da19f9944df" ? "none" : undefined;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xc094aa9c, Offset: 0xd36
// Size: 0xcd, Type: bool
function function_79ed8dd2c414e8ed( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_7f4958ce4e4277c3 != #"hash_bb332da19f9944df" && game_object.var_7f4958ce4e4277c3 != #"hash_a1360b18943e920";
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x1c920427, Offset: 0xe0c
// Size: 0xab, Type: bool
function is_contested( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return istrue( game_object.is_contested );
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0x28455ebd, Offset: 0xec0
// Size: 0xaa
function function_6f7e649cce3dd66b( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.overcap_index;
}

// Namespace namespace_277c922f0d0dc523
// Params 1
// Checksum 0xdbe2aec9, Offset: 0xf73
// Size: 0xbb
function function_865dc8c8e74399eb( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( isdefined( game_object.var_47052359601596e ) )
    {
        return game_object.var_47052359601596e.size;
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 2
// Checksum 0xf9afeacc, Offset: 0x1037
// Size: 0x198
function function_5e0c23aa66d30871( game_object, var_c68e9f43ed9cc918 )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( isdefined( var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + var_c68e9f43ed9cc918 + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    function_9bc743a07ff3a375( game_object, var_c68e9f43ed9cc918 );
}

// Namespace namespace_277c922f0d0dc523
// Params 0, eflags: 0x5
// Checksum 0x68d3ab10, Offset: 0x11d7
// Size: 0x42
function private autoexec __autoexec__()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        system::register( #"hash_6c895d25c543602a", #"gameobjects_common", &function_a53b566f98941da2, undefined );
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 0, eflags: 0x4
// Checksum 0x5d59644e, Offset: 0x1221
// Size: 0x1c7
function private function_a53b566f98941da2()
{
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_aa89afe9cb4cc4a2", &function_b14c5c5ce6b1de8d );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_bff43ef3bcefe7fd", &function_520a58192548e296 );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_53fdc082a3c4a3", &function_4cf3ab2db3219b90 );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_9ac4aa0c62e211d1", &function_a91521e1c685e3f8 );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_b9c66d4b9cc93bfb", &function_ba29802e138b29fc );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_42277c66f5bf6cbe", &function_4edb005d6e8e10e1 );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_3f6e412bf6d9eee0", &function_6bfea8a5a1055c3f );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_2ab47527155f279d", &function_f87ca3f816b60d3c );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_d7b0f53e6809c433", &function_d8f595b657e0431a );
    
    /#
        [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_capture_zone", #"hash_8fb85d546a6d8844", &function_93a99be6fc27258b );
    #/
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0xdc739d13, Offset: 0x13f0
// Size: 0x3dd
function private function_b14c5c5ce6b1de8d( game_object, var_24290c36e2cab388 )
{
    game_object.var_536395db3d80fedb = #"hash_bb332da19f9944df";
    game_object.var_feacd6e9542ddd64 = #"hash_bb332da19f9944df";
    game_object.var_7f4958ce4e4277c3 = var_24290c36e2cab388.var_7f4958ce4e4277c3;
    game_object.var_54c587af6e056efe = #"hash_bb332da19f9944df";
    game_object.var_d07b2b95cdf20f0c = #"hash_bb332da19f9944df";
    game_object.var_dd8d8f32ef3f67c5 = #"hash_bb332da19f9944df";
    game_object.var_3cac40f904c73c7e = [];
    game_object.var_3cac40f904c73c7e[ #"hash_7118f9343873352b" ] = 0;
    game_object.var_3cac40f904c73c7e[ #"hash_ce911e3bbe99421f" ] = 0;
    game_object.is_contested = 0;
    game_object.exclusive_use = var_24290c36e2cab388.game_object_definition.exclusiveuse;
    game_object.var_5e17c98f795c6c9c = var_24290c36e2cab388.game_object_definition.var_34358ce0bd5c6764;
    game_object.var_2599c68edacafeb1 = var_24290c36e2cab388.game_object_definition.var_657cccd388803b0;
    game_object.var_a11ce7a907e5600d = var_24290c36e2cab388.game_object_definition.var_2f695b133ba9e636;
    game_object.var_74d8ffdc4737b2f = var_24290c36e2cab388.game_object_definition.var_63922def04b5ae85;
    game_object.var_6da080cbcebbdb64 = var_24290c36e2cab388.game_object_definition.var_349b3deaf585f317;
    game_object.var_49590e9c849cbfb0 = var_24290c36e2cab388.game_object_definition.playerusescalar;
    game_object.var_a5cdddbbc5e6379c = var_24290c36e2cab388.game_object_definition.playerusecap ?? 4;
    game_object.var_e0a84791802b820 = var_24290c36e2cab388.game_object_definition.var_ae224ddf25004d14 ?? 1;
    game_object.var_333d3689d793bcc7 = float( var_24290c36e2cab388.var_333d3689d793bcc7 );
    game_object.var_16f8e5701c6d7812 = int( var_24290c36e2cab388.capture_segment_count );
    
    if ( var_24290c36e2cab388.game_object_definition.var_d24a627b1cb92e19 )
    {
        game_object.progress_reset_value = var_24290c36e2cab388.game_object_definition.var_a392302ef9cdb345 * 0.01;
    }
    
    if ( var_24290c36e2cab388.game_object_definition.var_26ab2abf4dbbf613.size > 0 )
    {
        game_object.overcap_index = 0;
        game_object.var_47052359601596e = var_24290c36e2cab388.game_object_definition.var_26ab2abf4dbbf613;
    }
    
    switch ( var_24290c36e2cab388.game_object_definition.capturetype )
    {
        case #"hash_1824cb7fbde9003c":
            game_object.capture_type = #"hash_e560d4d11ba31739";
            break;
        case #"hash_659505774b1fa602":
            game_object.capture_type = #"hash_6eb547fe0dc88c53";
            break;
        default:
            break;
    }
    
    switch ( var_24290c36e2cab388.game_object_definition.var_66145bb4bdea68eb )
    {
        case #"clear":
            game_object.var_6c2a923e0343e7e7 = #"hash_62a7d54d0b0bd6f8";
            break;
        case #"decay":
            game_object.var_6c2a923e0343e7e7 = #"hash_fc974776eaecb73f";
            break;
        case #"save":
            game_object.var_6c2a923e0343e7e7 = #"hash_f8b49892b70a5bf2";
            break;
        default:
            break;
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0xe8381aca, Offset: 0x17d5
// Size: 0x209
function private function_520a58192548e296( game_object, var_24290c36e2cab388 )
{
    if ( !istrue( isdefined( var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_a1360b18943e920" ? "all" : var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + var_24290c36e2cab388.var_7f4958ce4e4277c3 + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_24290c36e2cab388.var_7f4958ce4e4277c3 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( !istrue( var_24290c36e2cab388.var_7f4958ce4e4277c3 != #"hash_a1360b18943e920" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x8f>" + #"hash_a1360b18943e920" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Unable to initialize the owning team to '" + #"hash_a1360b18943e920" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" || var_24290c36e2cab388.var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" )
    {
        function_9bc743a07ff3a375( game_object, var_24290c36e2cab388.var_7f4958ce4e4277c3 );
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 1, eflags: 0x4
// Checksum 0xf631c48b, Offset: 0x19e6
// Size: 0xdc
function private function_4cf3ab2db3219b90( game_object )
{
    game_object.var_3cac40f904c73c7e[ #"hash_7118f9343873352b" ] = 0;
    game_object.var_3cac40f904c73c7e[ #"hash_ce911e3bbe99421f" ] = 0;
    function_e1e21bf90dfd7ccb( game_object, #"hash_bb332da19f9944df", 1 );
    function_8feacce38c7eab8c( game_object, #"hash_bb332da19f9944df", 1 );
    
    if ( game_object.var_74d8ffdc4737b2f )
    {
        function_9bc743a07ff3a375( game_object, #"hash_bb332da19f9944df", 1 );
    }
    
    if ( game_object.var_6da080cbcebbdb64 && game_object.update_struct )
    {
        game_object.update_struct.progress = 0;
    }
    
    game_object notify( #"capture_zone_deactivated" );
    level notify( #"capture_zone_deactivated", game_object.objective_key );
}

// Namespace namespace_277c922f0d0dc523
// Params 1, eflags: 0x4
// Checksum 0x7ce6925b, Offset: 0x1aca
// Size: 0x11c
function private function_a91521e1c685e3f8( game_object )
{
    if ( isdefined( game_object.update_struct ) )
    {
        update_struct = game_object.update_struct;
        
        if ( update_struct.var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" || update_struct.var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" )
        {
            if ( update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" || update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" )
            {
                if ( update_struct.var_7f4958ce4e4277c3 != update_struct.var_536395db3d80fedb )
                {
                    if ( level.flagneutralization )
                    {
                        return game_object.var_333d3689d793bcc7;
                    }
                }
                else if ( game_object.overcap_index < game_object.var_47052359601596e.size )
                {
                    var_5bf49b2bb3b2d4b3 = game_object.var_47052359601596e[ game_object.overcap_index ];
                    return var_5bf49b2bb3b2d4b3.usetimeseconds;
                }
            }
        }
    }
    
    return game_object.use_time_seconds;
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x86c07f9f, Offset: 0x1bef
// Size: 0x101, Type: bool
function private function_ba29802e138b29fc( game_object, player )
{
    if ( game_object.exclusive_use && isdefined( game_object.players_using ) )
    {
        var_c68e9f43ed9cc918 = player.team == "all" || player.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( player.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( player.team ) ? #"hash_ce911e3bbe99421f" : player.team == "none" || player.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
        return !arraycontains( game_object.players_using[ var_c68e9f43ed9cc918 ], player );
    }
    
    return true;
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x95aea579, Offset: 0x1cf9
// Size: 0x15c
function private function_4edb005d6e8e10e1( game_object, update_struct )
{
    update_struct.var_536395db3d80fedb = #"hash_bb332da19f9944df";
    update_struct.var_7f4958ce4e4277c3 = game_object.var_7f4958ce4e4277c3;
    update_struct.var_d07b2b95cdf20f0c = game_object.var_d07b2b95cdf20f0c;
    update_struct.is_contested = 0;
    players_using = gameobjects_common::get_players_using( game_object );
    player_count = 0;
    
    foreach ( var_c68e9f43ed9cc918, players in players_using )
    {
        if ( players.size > player_count )
        {
            update_struct.var_536395db3d80fedb = var_c68e9f43ed9cc918;
            player_count = players.size;
            continue;
        }
        
        if ( players.size == player_count )
        {
            update_struct.var_536395db3d80fedb = #"hash_a1360b18943e920";
            update_struct.is_contested = 1;
        }
    }
    
    if ( game_object.var_5e17c98f795c6c9c && players_using.size > 1 )
    {
        update_struct.is_contested = 1;
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x74f56eb6, Offset: 0x1e5d
// Size: 0xbc
function private function_6bfea8a5a1055c3f( game_object, update_struct )
{
    var_6eac0773eec08774 = update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" || update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f";
    var_6eac0773eec08774 &= !update_struct.is_contested || !game_object.var_2599c68edacafeb1;
    
    if ( var_6eac0773eec08774 )
    {
        function_4d020de0265e5fb5( game_object, update_struct );
        return;
    }
    
    if ( update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" )
    {
        function_1610a4961ca8139b( game_object, update_struct );
        return;
    }
    
    update_struct.status = #"hash_64b95fcceb630072";
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x945febca, Offset: 0x1f21
// Size: 0xc6
function private function_f87ca3f816b60d3c( game_object, update_struct )
{
    if ( update_struct.is_contested != game_object.is_contested )
    {
        if ( update_struct.is_contested )
        {
            gameobjects_common::queue_callback( game_object, #"hash_300ad54dcc9beab1", undefined, 0 );
        }
        else
        {
            gameobjects_common::queue_callback( game_object, #"hash_629949853fbabab8", undefined, 0 );
        }
        
        game_object.is_contested = update_struct.is_contested;
        update_struct.is_contested = undefined;
    }
    
    function_e1e21bf90dfd7ccb( game_object, update_struct.var_536395db3d80fedb );
    function_9bc743a07ff3a375( game_object, update_struct.var_7f4958ce4e4277c3 );
    function_8feacce38c7eab8c( game_object, update_struct.var_d07b2b95cdf20f0c );
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x8351780b, Offset: 0x1fef
// Size: 0x720
function private function_4d020de0265e5fb5( game_object, update_struct )
{
    claim_team_name = update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
    var_be2b0a62574f8ad8 = game_utility_mp::getotherteam( claim_team_name )[ 0 ];
    var_5c51330e5cbcc93 = var_be2b0a62574f8ad8 == "all" || var_be2b0a62574f8ad8 == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( var_be2b0a62574f8ad8 ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( var_be2b0a62574f8ad8 ) ? #"hash_ce911e3bbe99421f" : var_be2b0a62574f8ad8 == "none" || var_be2b0a62574f8ad8 == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    var_7d5a92c84019a1e3 = game_object.overcap_index < game_object.var_47052359601596e.size;
    var_7d5a92c84019a1e3 &= update_struct.var_536395db3d80fedb == update_struct.var_7f4958ce4e4277c3;
    var_cd55ef98192532bf = update_struct.var_d07b2b95cdf20f0c != update_struct.var_536395db3d80fedb && !update_struct.var_7d5a92c84019a1e3;
    var_cd55ef98192532bf &= update_struct.var_7f4958ce4e4277c3 != #"hash_7118f9343873352b" || update_struct.var_7f4958ce4e4277c3 != #"hash_ce911e3bbe99421f";
    var_cd55ef98192532bf &= update_struct.progress > 0;
    var_2765be9c28e47c68 = !var_cd55ef98192532bf;
    var_2765be9c28e47c68 &= update_struct.var_536395db3d80fedb != update_struct.var_7f4958ce4e4277c3 || var_7d5a92c84019a1e3;
    progress_delta = int( update_struct.use_time_scalar == 1 );
    
    if ( progress_delta < 1 )
    {
        var_5d2d3db621f8588 = isdefined( game_object.players_using[ var_5c51330e5cbcc93 ] ) ? game_object.players_using[ var_5c51330e5cbcc93 ].size : 0;
        var_6f966d614b2aff49 = game_object.players_using[ update_struct.var_536395db3d80fedb ].size - var_5d2d3db621f8588 - 1;
        var_49590e9c849cbfb0 = 1 + game_object.var_49590e9c849cbfb0 * clamp( var_6f966d614b2aff49, 0, game_object.var_a5cdddbbc5e6379c );
        var_e0a84791802b820 = var_cd55ef98192532bf ? game_object.var_e0a84791802b820 : 1;
        progress_delta = level.framedurationseconds * update_struct.use_time_scalar * var_49590e9c849cbfb0 * var_e0a84791802b820 * game_object.var_16f8e5701c6d7812;
    }
    
    if ( var_2765be9c28e47c68 )
    {
        update_struct.var_d07b2b95cdf20f0c = update_struct.var_536395db3d80fedb;
        
        if ( function_28f9e78da77f46ee( game_object, update_struct, progress_delta, var_7d5a92c84019a1e3 ) )
        {
            if ( game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ] == game_object.var_16f8e5701c6d7812 )
            {
                update_struct.var_7f4958ce4e4277c3 = update_struct.var_536395db3d80fedb;
                var_b19ce51dfc12b7f8 = {};
                var_b19ce51dfc12b7f8.team_name = claim_team_name;
                var_b19ce51dfc12b7f8.var_dbd0d4c325a7ae15 = game_object.players_using[ update_struct.var_536395db3d80fedb ][ 0 ];
                var_b19ce51dfc12b7f8.var_2b03add3a518dea6 = utility::array_slice( game_object.players_using[ update_struct.var_536395db3d80fedb ], 1 );
                game_object.var_3baec90fe19817b3 = 1;
                gameobjects_common::queue_callback( game_object, #"hash_a836ce9ab43d9e2", var_b19ce51dfc12b7f8, 0 );
            }
            else if ( game_object.var_3cac40f904c73c7e[ var_5c51330e5cbcc93 ] == 0 )
            {
                update_struct.var_7f4958ce4e4277c3 = #"hash_bb332da19f9944df";
                var_b19ce51dfc12b7f8 = {};
                var_b19ce51dfc12b7f8.team_name = claim_team_name;
                var_b19ce51dfc12b7f8.var_dbd0d4c325a7ae15 = game_object.players_using[ update_struct.var_536395db3d80fedb ][ 0 ];
                var_b19ce51dfc12b7f8.var_2b03add3a518dea6 = utility::array_slice( game_object.players_using[ update_struct.var_536395db3d80fedb ], 1 );
                gameobjects_common::queue_callback( game_object, #"hash_33ab895f04e4eec9", var_b19ce51dfc12b7f8, 0 );
            }
            
            if ( isdefined( game_object.overcap_index ) )
            {
                game_object.overcap_index = 0;
                update_struct.var_7d5a92c84019a1e3 = undefined;
                update_struct.overcap_progress = undefined;
            }
        }
        
        return;
    }
    
    if ( var_cd55ef98192532bf )
    {
        update_struct.progress -= progress_delta;
        
        if ( update_struct.progress <= 0 )
        {
            update_struct.progress = 0;
            claim_team_name = update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
            other_team_name = game_utility_mp::getotherteam( claim_team_name )[ 0 ];
            other_team_hash = other_team_name == "all" || other_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( other_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( other_team_name ) ? #"hash_ce911e3bbe99421f" : other_team_name == "none" || other_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
            current_team_segments = [];
            current_team_segments[ claim_team_name ] = game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ];
            current_team_segments[ other_team_name ] = game_object.var_3cac40f904c73c7e[ other_team_hash ];
            var_b19ce51dfc12b7f8 = {};
            var_b19ce51dfc12b7f8.var_3fb67f294d22fb9a = game_object.players_using[ update_struct.var_536395db3d80fedb ];
            var_b19ce51dfc12b7f8.current_team_segments = current_team_segments;
            var_b19ce51dfc12b7f8.var_16f8e5701c6d7812 = game_object.var_16f8e5701c6d7812;
            gameobjects_common::queue_callback( game_object, #"hash_a4277d17a7a228c9", var_b19ce51dfc12b7f8, 0 );
        }
        
        return;
    }
    
    update_struct.var_d07b2b95cdf20f0c = #"hash_bb332da19f9944df";
    update_struct.status = #"hash_6b016a28066286ff";
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x889f804c, Offset: 0x2717
// Size: 0x53
function private function_62524b845fe29a6d( game_object, update_struct )
{
    update_struct.var_7f4958ce4e4277c3 = #"hash_a1360b18943e920";
    update_struct.status = #"hash_64b95fcceb630072";
    gameobjects_common::queue_callback( game_object, #"hash_300ad54dcc9beab1", undefined, 0 );
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0xbfbefe93, Offset: 0x2772
// Size: 0x4e
function private function_8b0a75008877ca88( game_object, update_struct )
{
    update_struct.var_7f4958ce4e4277c3 = game_object.var_54c587af6e056efe;
    update_struct.var_18a3bf3521fb80fb = 1;
    gameobjects_common::queue_callback( game_object, #"hash_629949853fbabab8", undefined, 0 );
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x18d1e75c, Offset: 0x27c8
// Size: 0x243
function private function_1610a4961ca8139b( game_object, update_struct )
{
    var_1cec87eb63ae976e = undefined;
    var_a86c6b9b7027eea5 = undefined;
    
    if ( game_object.var_536395db3d80fedb != #"hash_bb332da19f9944df" )
    {
        if ( game_object.var_536395db3d80fedb != #"hash_a1360b18943e920" )
        {
            var_1cec87eb63ae976e = game_object.var_536395db3d80fedb;
        }
        else if ( game_object.var_feacd6e9542ddd64 != #"hash_bb332da19f9944df" && game_object.var_feacd6e9542ddd64 != #"hash_a1360b18943e920" )
        {
            var_1cec87eb63ae976e = game_object.var_feacd6e9542ddd64;
        }
        
        gameobjects_common::queue_callback( game_object, #"hash_e3206e8d5d3df1e3", undefined, 0 );
    }
    
    if ( game_object.var_7f4958ce4e4277c3 == #"hash_a1360b18943e920" )
    {
        function_8b0a75008877ca88( game_object, update_struct );
    }
    
    if ( game_object.var_a11ce7a907e5600d )
    {
        update_struct.var_7f4958ce4e4277c3 = #"hash_bb332da19f9944df";
    }
    
    if ( game_object.var_6c2a923e0343e7e7 == #"hash_62a7d54d0b0bd6f8" )
    {
        var_a86c6b9b7027eea5 = isdefined( var_1cec87eb63ae976e );
        update_struct.progress = 0;
        update_struct.status = #"hash_64b95fcceb630072";
    }
    else if ( game_object.var_6c2a923e0343e7e7 == #"hash_fc974776eaecb73f" )
    {
        var_a86c6b9b7027eea5 = isdefined( var_1cec87eb63ae976e );
        
        if ( update_struct.use_time_scalar == 1 )
        {
            update_struct.progress = 0;
            update_struct.status = #"hash_64b95fcceb630072";
        }
        
        update_struct.progress -= update_struct.use_time_scalar * level.framedurationseconds;
        
        if ( update_struct.progress <= 0 )
        {
            update_struct.progress = 0;
            update_struct.status = #"hash_64b95fcceb630072";
        }
    }
    else
    {
        update_struct.status = #"hash_64b95fcceb630072";
    }
    
    if ( var_a86c6b9b7027eea5 )
    {
        game_object.var_3cac40f904c73c7e[ var_1cec87eb63ae976e ]--;
        game_object.var_3cac40f904c73c7e[ var_1cec87eb63ae976e ] = maxint( game_object.var_3cac40f904c73c7e[ var_1cec87eb63ae976e ], 0 );
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 4, eflags: 0x4
// Checksum 0x2bf71488, Offset: 0x2a13
// Size: 0x2c3
function private function_28f9e78da77f46ee( game_object, update_struct, progress_delta, var_7d5a92c84019a1e3 )
{
    if ( var_7d5a92c84019a1e3 )
    {
        if ( !isdefined( update_struct.var_7d5a92c84019a1e3 ) )
        {
            update_struct.var_7d5a92c84019a1e3 = 1;
        }
        
        if ( isdefined( update_struct.overcap_progress ) )
        {
            update_struct.progress = update_struct.overcap_progress;
            update_struct.overcap_progress = undefined;
        }
    }
    else if ( update_struct.var_7d5a92c84019a1e3 && !isdefined( update_struct.overcap_progress ) )
    {
        if ( !isdefined( update_struct.overcap_progress ) )
        {
            update_struct.overcap_progress = update_struct.progress;
        }
        
        update_struct.progress = 0;
    }
    
    updated_progress = update_struct.progress + progress_delta;
    
    if ( updated_progress >= 1 )
    {
        if ( update_struct.is_contested )
        {
            update_struct.status = #"hash_64b95fcceb630072";
        }
        else
        {
            update_struct.progress = updated_progress - 1;
            update_struct.var_18a3bf3521fb80fb = 1;
            
            if ( var_7d5a92c84019a1e3 )
            {
                if ( game_object.overcap_index < game_object.var_47052359601596e.size )
                {
                    game_object.overcap_index++;
                    var_b19ce51dfc12b7f8 = {};
                    var_b19ce51dfc12b7f8.team_name = update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
                    var_b19ce51dfc12b7f8.var_dbd0d4c325a7ae15 = game_object.players_using[ update_struct.var_536395db3d80fedb ][ 0 ];
                    var_b19ce51dfc12b7f8.var_2b03add3a518dea6 = utility::array_slice( game_object.players_using[ update_struct.var_536395db3d80fedb ], 1 );
                    var_b19ce51dfc12b7f8.var_efea8c5223ca7ba7 = game_object.overcap_index;
                    var_b19ce51dfc12b7f8.var_a8a094084f5c8b71 = game_object.var_47052359601596e.size;
                    gameobjects_common::queue_callback( game_object, #"hash_ae8f0f5e3b866b53", var_b19ce51dfc12b7f8, 0 );
                }
            }
            else
            {
                return function_d179ba484c45d68e( game_object, update_struct );
            }
        }
    }
    else
    {
        update_struct.progress = updated_progress;
    }
    
    return 0;
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x182f725d, Offset: 0x2cdf
// Size: 0x319
function private function_d179ba484c45d68e( game_object, update_struct )
{
    claim_team_name = update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "all" : update_struct.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "none" : undefined;
    other_team_name = game_utility_mp::getotherteam( claim_team_name )[ 0 ];
    other_team_hash = other_team_name == "all" || other_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( other_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( other_team_name ) ? #"hash_ce911e3bbe99421f" : other_team_name == "none" || other_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    was_capture = game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ] < game_object.var_16f8e5701c6d7812;
    
    if ( game_object.capture_type != #"hash_e560d4d11ba31739" && game_object.var_3cac40f904c73c7e[ other_team_hash ] > 0 )
    {
        game_object.var_3cac40f904c73c7e[ other_team_hash ]--;
        was_capture = !level.flagneutralization;
    }
    
    if ( was_capture )
    {
        game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ]++;
    }
    
    current_team_segments = [];
    current_team_segments[ claim_team_name ] = game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ];
    current_team_segments[ other_team_name ] = game_object.var_3cac40f904c73c7e[ other_team_hash ];
    var_b19ce51dfc12b7f8 = {};
    var_b19ce51dfc12b7f8.team_name = claim_team_name;
    var_b19ce51dfc12b7f8.var_dbd0d4c325a7ae15 = game_object.players_using[ update_struct.var_536395db3d80fedb ][ 0 ];
    var_b19ce51dfc12b7f8.var_2b03add3a518dea6 = utility::array_slice( game_object.players_using[ update_struct.var_536395db3d80fedb ], 1 );
    var_b19ce51dfc12b7f8.current_team_segments = current_team_segments;
    var_b19ce51dfc12b7f8.var_16f8e5701c6d7812 = game_object.var_16f8e5701c6d7812;
    
    if ( was_capture )
    {
        gameobjects_common::queue_callback( game_object, #"hash_2daf3ace91057e84", var_b19ce51dfc12b7f8, 0 );
        return ( game_object.var_3cac40f904c73c7e[ update_struct.var_536395db3d80fedb ] == game_object.var_16f8e5701c6d7812 );
    }
    
    if ( level.flagneutralization )
    {
        gameobjects_common::queue_callback( game_object, #"hash_bc5f191157450d6b", var_b19ce51dfc12b7f8, 0 );
        return ( game_object.var_3cac40f904c73c7e[ other_team_hash ] == 0 );
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 3, eflags: 0x4
// Checksum 0x4f85cf3a, Offset: 0x3000
// Size: 0x3a6
function private function_e1e21bf90dfd7ccb( game_object, var_c68e9f43ed9cc918, instant_callback )
{
    if ( !istrue( isdefined( var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + var_c68e9f43ed9cc918 + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( game_object.var_536395db3d80fedb == var_c68e9f43ed9cc918 )
    {
        return;
    }
    
    is_one_way_capture = game_object.capture_type == #"hash_e560d4d11ba31739";
    var_d2b234b3c6d430d6 = game_object.var_6c2a923e0343e7e7 != #"hash_62a7d54d0b0bd6f8";
    
    if ( is_one_way_capture && var_d2b234b3c6d430d6 && isdefined( game_object.update_struct ) )
    {
        if ( !isdefined( game_object.update_struct.var_e9ef17904feb9ea9 ) )
        {
            game_object.update_struct.var_e9ef17904feb9ea9 = [];
        }
        
        if ( game_object.var_536395db3d80fedb == #"hash_7118f9343873352b" || game_object.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" )
        {
            game_object.update_struct.var_e9ef17904feb9ea9[ game_object.var_536395db3d80fedb ] = game_object.update_struct.progress;
            game_object.update_struct.progress = 0;
            game_object thread function_61ab7168dd005a5c( game_object, game_object.var_536395db3d80fedb );
        }
        
        if ( var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" || var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" )
        {
            if ( isdefined( game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] ) )
            {
                game_object.update_struct.progress += game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ];
                clamp( game_object.update_struct.progress, 0, 1 );
            }
        }
    }
    
    game_object.var_feacd6e9542ddd64 = game_object.var_536395db3d80fedb;
    game_object.var_536395db3d80fedb = var_c68e9f43ed9cc918;
    
    if ( !isdefined( team_name ) )
    {
        team_name = var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined;
    }
    
    var_b19ce51dfc12b7f8 = { #team_name:team_name };
    gameobjects_common::queue_callback( game_object, #"hash_3aba7df6443df11d", var_b19ce51dfc12b7f8, istrue( instant_callback ) );
}

// Namespace namespace_277c922f0d0dc523
// Params 3, eflags: 0x4
// Checksum 0x5c0ff2de, Offset: 0x33ae
// Size: 0x1e9
function private function_9bc743a07ff3a375( game_object, var_c68e9f43ed9cc918, instant_callback )
{
    if ( !istrue( isdefined( var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + var_c68e9f43ed9cc918 + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( game_object.var_7f4958ce4e4277c3 == var_c68e9f43ed9cc918 )
    {
        return;
    }
    
    game_object.var_54c587af6e056efe = game_object.var_7f4958ce4e4277c3;
    game_object.var_7f4958ce4e4277c3 = var_c68e9f43ed9cc918;
    team_name = var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined;
    var_b19ce51dfc12b7f8 = { #team_name:team_name };
    gameobjects_common::queue_callback( game_object, #"hash_2e3e0663aecb6f19", var_b19ce51dfc12b7f8, istrue( instant_callback ) );
}

// Namespace namespace_277c922f0d0dc523
// Params 3, eflags: 0x4
// Checksum 0x9d522d36, Offset: 0x359f
// Size: 0x1e9
function private function_8feacce38c7eab8c( game_object, var_c68e9f43ed9cc918, instant_callback )
{
    if ( !istrue( isdefined( var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + var_c68e9f43ed9cc918 + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + var_c68e9f43ed9cc918 + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    if ( game_object.var_d07b2b95cdf20f0c == var_c68e9f43ed9cc918 )
    {
        return;
    }
    
    game_object.var_dd8d8f32ef3f67c5 = game_object.var_d07b2b95cdf20f0c;
    game_object.var_d07b2b95cdf20f0c = var_c68e9f43ed9cc918;
    team_name = var_c68e9f43ed9cc918 == #"hash_a1360b18943e920" ? "all" : var_c68e9f43ed9cc918 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : var_c68e9f43ed9cc918 == #"hash_bb332da19f9944df" ? "none" : undefined;
    var_b19ce51dfc12b7f8 = { #team_name:team_name };
    gameobjects_common::queue_callback( game_object, #"hash_29eede2365f9349a", var_b19ce51dfc12b7f8, istrue( instant_callback ) );
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x1ea65d54, Offset: 0x3790
// Size: 0x1f
function private function_d8f595b657e0431a( game_object, player )
{
    thread __player_damage_listen_thread__( game_object, player );
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0xc
// Checksum 0xe6e3d827, Offset: 0x37b7
// Size: 0x144
function private function_61ab7168dd005a5c( game_object, var_c68e9f43ed9cc918 )
{
    self notify( #"hash_c68c6b4c5afd9c19" );
    self endon( #"hash_c68c6b4c5afd9c19" );
    level endon( #"game_ended" );
    
    if ( game_object.var_6c2a923e0343e7e7 != #"hash_fc974776eaecb73f" )
    {
        return;
    }
    
    waittillframeend();
    
    while ( game_object.var_536395db3d80fedb != var_c68e9f43ed9cc918 )
    {
        if ( !isdefined( game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] ) )
        {
            break;
        }
        
        if ( game_object.update_struct.use_time_scalar < 1 )
        {
            game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] -= level.framedurationseconds * game_object.update_struct.use_time_scalar;
            
            if ( game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] <= 0 )
            {
                game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] = undefined;
            }
        }
        else
        {
            game_object.update_struct.var_e9ef17904feb9ea9[ var_c68e9f43ed9cc918 ] = undefined;
        }
        
        waitframe();
    }
}

// Namespace namespace_277c922f0d0dc523
// Params 2, eflags: 0x4
// Checksum 0x2a642774, Offset: 0x3903
// Size: 0x1e3
function private __player_damage_listen_thread__( game_object, player )
{
    player notify( "__player_damage_listen_thread__" + game_object.objective_key );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( "__player_damage_listen_thread__" + game_object.objective_key );
    
    while ( isdefined( game_object.progress_reset_value ) )
    {
        player waittill( #"damage", amount, attacker );
        
        if ( !isdefined( game_object.update_struct ) )
        {
            continue;
        }
        
        if ( !gameobjects_common::function_6057f2c78ba2b3a2( game_object, player ) )
        {
            continue;
        }
        
        var_c68e9f43ed9cc918 = player.team == "all" || player.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( player.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( player.team ) ? #"hash_ce911e3bbe99421f" : player.team == "none" || player.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
        
        if ( var_c68e9f43ed9cc918 == game_object.var_7f4958ce4e4277c3 )
        {
            continue;
        }
        
        if ( game_object.update_struct.progress < game_object.progress_reset_value )
        {
            continue;
        }
        
        if ( attacker == self )
        {
            continue;
        }
        
        if ( attacker.classname == "worldspawn" )
        {
            continue;
        }
        
        game_object.update_struct.progress = game_object.progress_reset_value;
    }
}

/#

    // Namespace namespace_277c922f0d0dc523
    // Params 2, eflags: 0x4
    // Checksum 0xffd31150, Offset: 0x3aee
    // Size: 0x5c3, Type: dev
    function private function_93a99be6fc27258b( game_object, update_struct )
    {
        attacker_segments = game_object.var_3cac40f904c73c7e[ #"hash_7118f9343873352b" ];
        defender_segments = game_object.var_3cac40f904c73c7e[ #"hash_ce911e3bbe99421f" ];
        
        /#
            if ( !isdefined( game_object.debug_update_struct ) )
            {
                game_object.debug_update_struct = {};
            }
            
            if ( !isdefined( game_object.debug_update_struct.strings ) )
            {
                game_object.debug_update_struct.strings = [];
            }
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:xb9>" ) + "<dev string:xbe>" + "<dev string:xc1>";
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
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:xce>" ) + "<dev string:xbe>" + ( game_object.var_536395db3d80fedb == #"hash_a1360b18943e920" ? "<dev string:xd9>" : game_object.var_536395db3d80fedb == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_536395db3d80fedb == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_536395db3d80fedb == #"hash_bb332da19f9944df" ? "<dev string:xdd>" : undefined );
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
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:xe2>" ) + "<dev string:xbe>" + ( game_object.var_7f4958ce4e4277c3 == #"hash_a1360b18943e920" ? "<dev string:xd9>" : game_object.var_7f4958ce4e4277c3 == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( game_object.instance_id ) : game_object.var_7f4958ce4e4277c3 == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( game_object.instance_id ) : game_object.var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" ? "<dev string:xdd>" : undefined );
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
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:xee>" ) + "<dev string:xbe>" + ( level.flagneutralization ? "<dev string:x106>" : "<dev string:x10b>" );
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
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x111>" ) + "<dev string:xbe>" + attacker_segments + "<dev string:x123>" + game_object.var_16f8e5701c6d7812;
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
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x125>" ) + "<dev string:xbe>" + defender_segments + "<dev string:x123>" + game_object.var_16f8e5701c6d7812;
        #/
        
        if ( isdefined( game_object.overcap_index ) )
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
                
                game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x137>" ) + "<dev string:xbe>" + game_object.overcap_index + "<dev string:x123>" + game_object.var_47052359601596e.size;
            #/
        }
    }

#/
