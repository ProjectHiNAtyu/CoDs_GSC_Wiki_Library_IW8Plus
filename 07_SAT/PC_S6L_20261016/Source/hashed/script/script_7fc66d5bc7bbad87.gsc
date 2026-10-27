// script_7fc66d5bc7bbad87  (hash_7fc66d5bc7bbad87.gscc) (size: 3159 Bytes / 0xc57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf86540d3 (4167385299)
// size ...... 3159 (0xc57)
// includes .. 7   (offset: 0xbb3)
// strings ... 5   (offset: 0xbeb)
// dev strs .. 4   (offset: 0xc27)
// exports ... 10  (offset: 0x633)
// cseg ...... 0x97 + 0x59c (0x633)
// imports ... 34  (offset: 0x7c3)
// animtree1 . 0   (offset: 0xc57)
// animtree2 . 0   (offset: 0xc57)
#using script_4e1f1a7ef824ddd5;
#using scripts\common\player_broadcasting;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\hud_message;
#using scripts\mp\overlord;

#namespace namespace_8f542cd1b399b165;

// Namespace namespace_8f542cd1b399b165
// Params 0, eflags: 0x5
// Checksum 0x3050114e, Offset: 0xb5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_591c4253c5bbb3e4", undefined, &function_c9072aa6f7bb6939, undefined );
}

// Namespace namespace_8f542cd1b399b165
// Params 0, eflags: 0x4
// Checksum 0x4f71c98b, Offset: 0xd6
// Size: 0x46
function private function_c9072aa6f7bb6939()
{
    player_broadcasting::function_f5e10214f3edd9df( "TitleSplash", &function_8592b9f0e25c74d3 );
    player_broadcasting::function_f5e10214f3edd9df( "Music", &function_7091f1584806a2e9 );
    player_broadcasting::function_f5e10214f3edd9df( "Overlord", &function_581b6faa1b75918f );
    player_broadcasting::function_f5e10214f3edd9df( "OverlordList", &function_a19dc5d50cb148b7 );
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0xc0798c6e, Offset: 0x124
// Size: 0xa0
function function_8accbce154447e83( players, broadcast_data_object, broadcast_command )
{
    musicevent = namespace_2aca03e533f9f843::function_822c710a6d0e6dae( broadcast_data_object );
    
    if ( !isdefined( musicevent ) )
    {
        musicevent = #"";
    }
    
    musicevent = getxhash( musicevent );
    delay = namespace_2aca03e533f9f843::function_d0f7937bb785acc4( broadcast_data_object );
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    if ( broadcast_command == 0 || broadcast_command == 1 )
    {
        level utility::delaythread( delay, &musicbank_utility::function_5aca66c390aa347d, players, musicevent );
        return;
    }
    
    if ( broadcast_command == 2 )
    {
        level musicbank_utility::function_4f253fd35ec68cbc( players, musicevent );
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 4
// Checksum 0xebee0ce7, Offset: 0x1cc
// Size: 0x154
function function_ad4e2822c5f9b8f9( players, broadcast_instance, broadcast_data_object, broadcast_command )
{
    splash_reference = namespace_2aca03e533f9f843::function_a0c228acf304b0b6( broadcast_data_object );
    var_71a21227cb691e60 = namespace_2aca03e533f9f843::function_f239baab75e464dd( broadcast_data_object );
    splash_delay = namespace_2aca03e533f9f843::function_c7ae09f981d840dc( broadcast_data_object );
    
    if ( !isdefined( splash_delay ) )
    {
        splash_delay = 0;
    }
    
    if ( broadcast_command == 0 || broadcast_command == 1 )
    {
        if ( !isarray( players ) )
        {
            players = [ players ];
        }
        
        var_b1c3e8331e3357ae = undefined;
        var_7cef713213064ef1 = namespace_2aca03e533f9f843::function_e2456da4d8c9ce1( broadcast_instance, broadcast_data_object, 0 );
        
        if ( isdefined( var_7cef713213064ef1 ) && var_7cef713213064ef1.type == "Integer" )
        {
            var_b1c3e8331e3357ae = var_7cef713213064ef1.value;
        }
        
        foreach ( player in players )
        {
            player utility::delaythread( splash_delay, &hud_message::showsplash, splash_reference, var_b1c3e8331e3357ae, undefined, undefined, 1, var_71a21227cb691e60 );
        }
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0xb318ea02, Offset: 0x328
// Size: 0xb7
function function_514e0038daf37703( players, broadcast_data_object, broadcast_command )
{
    var_8866b3b1d0cba966 = namespace_2aca03e533f9f843::function_252db8813aaa17aa( broadcast_data_object );
    var_93361e22570ab9ac = namespace_2aca03e533f9f843::function_31e84005fb5b9b08( broadcast_data_object );
    
    if ( !isdefined( var_93361e22570ab9ac ) )
    {
        var_93361e22570ab9ac = 0;
    }
    
    var_cad6b041c8301bf1 = namespace_2aca03e533f9f843::function_3d27a1ebdd4c4ce6( broadcast_data_object );
    var_af051b958b08800e = namespace_2aca03e533f9f843::function_8f40b0da2744bec2( broadcast_data_object );
    
    if ( broadcast_command == 0 || broadcast_command == 1 )
    {
        if ( !isarray( players ) )
        {
            players = [ players ];
        }
        
        if ( var_cad6b041c8301bf1 )
        {
            thread overlord::playconversation( var_8866b3b1d0cba966, players, var_93361e22570ab9ac, var_af051b958b08800e );
            return;
        }
        
        thread overlord::playevent( var_8866b3b1d0cba966, players, var_93361e22570ab9ac );
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0x5d1a9f29, Offset: 0x3e7
// Size: 0x83
function function_7091f1584806a2e9( players, broadcast, broadcast_command )
{
    assert( broadcast player_broadcasting::getbroadcasttype() == "<dev string:x24>" );
    data_objects = broadcast player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        function_8accbce154447e83( players, data_object, broadcast_command );
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0x263e4f42, Offset: 0x472
// Size: 0x85
function function_8592b9f0e25c74d3( players, broadcast_instance, broadcast_command )
{
    assert( broadcast_instance player_broadcasting::getbroadcasttype() == "<dev string:x2a>" );
    data_objects = broadcast_instance player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        function_ad4e2822c5f9b8f9( players, broadcast_instance, data_object, broadcast_command );
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0xf18f8095, Offset: 0x4ff
// Size: 0x83
function function_581b6faa1b75918f( players, broadcast, broadcast_command )
{
    assert( broadcast player_broadcasting::getbroadcasttype() == "<dev string:x36>" );
    data_objects = broadcast player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        function_514e0038daf37703( players, data_object, broadcast_command );
    }
}

// Namespace namespace_8f542cd1b399b165
// Params 3
// Checksum 0x2cfa797b, Offset: 0x58a
// Size: 0xa9
function function_a19dc5d50cb148b7( players, broadcast, broadcast_command )
{
    assert( broadcast player_broadcasting::getbroadcasttype() == "<dev string:x3f>" );
    data_objects = broadcast player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        data_object_rand = utility::array_random( data_object.overlordlistdata );
        function_514e0038daf37703( players, data_object_rand.variant_object, broadcast_command );
    }
}

