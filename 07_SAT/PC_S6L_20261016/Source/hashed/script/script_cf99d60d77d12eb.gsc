// script_cf99d60d77d12eb  (hash_0cf99d60d77d12eb.gscc) (size: 2902 Bytes / 0xb56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f62d39a (1868747674)
// size ...... 2902 (0xb56)
// includes .. 4   (offset: 0xaa2)
// strings ... 8   (offset: 0xac2)
// dev strs .. 4   (offset: 0xb26)
// exports ... 8   (offset: 0x5fa)
// cseg ...... 0xb6 + 0x544 (0x5fa)
// imports ... 30  (offset: 0x73a)
// animtree1 . 0   (offset: 0xb56)
// animtree2 . 0   (offset: 0xb56)
#using script_4e1f1a7ef824ddd5;
#using scripts\common\player_broadcasting;
#using scripts\common\string_messaging_util;
#using scripts\common\system;

#namespace namespace_1b399d08202b861f;

// Namespace namespace_1b399d08202b861f
// Params 0, eflags: 0x5
// Checksum 0x26b7d2f4, Offset: 0xd4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_17a211813478c07c", undefined, &function_e9680ccc39b004db, undefined );
}

// Namespace namespace_1b399d08202b861f
// Params 0, eflags: 0x4
// Checksum 0xbda3218b, Offset: 0xf5
// Size: 0x35
function private function_e9680ccc39b004db()
{
    player_broadcasting::function_f5e10214f3edd9df( "StringText", &function_ec9eda8a64cd5d1e );
    player_broadcasting::function_f5e10214f3edd9df( "StringReference", &function_607e3a0d045b4fb1 );
    player_broadcasting::function_f5e10214f3edd9df( "Omnvar", &function_81fd4e7d576bb );
}

// Namespace namespace_1b399d08202b861f
// Params 4
// Checksum 0x5796f632, Offset: 0x132
// Size: 0x1bc
function function_cdcae179fad195e6( players, broadcast_instance, broadcast_data_object, broadcast_command )
{
    omnvar_name = namespace_2aca03e533f9f843::function_cb600fd486bdb72a( broadcast_data_object );
    omnvar_type = namespace_2aca03e533f9f843::function_7993e978a51f1a99( broadcast_data_object );
    var_bae54c46de9c2c0d = namespace_2aca03e533f9f843::function_e66727a6acee8a5f( broadcast_data_object );
    
    if ( broadcast_command == 0 || broadcast_command == 1 )
    {
        omnvar_value = undefined;
        
        if ( omnvar_type == "dynamic" )
        {
            var_7cef713213064ef1 = namespace_2aca03e533f9f843::function_e2456da4d8c9ce1( broadcast_instance, broadcast_data_object, 0 );
            
            if ( isdefined( var_7cef713213064ef1 ) )
            {
                if ( var_7cef713213064ef1.type == "ProgressTracker" )
                {
                    var_f03f252dfe7001 = var_7cef713213064ef1.value;
                    progress_data = namespace_2aca03e533f9f843::function_66deba6127b6ba4( var_7cef713213064ef1.format, var_f03f252dfe7001.startingprogressvalue, var_f03f252dfe7001.currentprogressvalue, var_f03f252dfe7001.finalprogressvalue );
                    omnvar_value = [ 0 ];
                }
                else
                {
                    omnvar_value = var_7cef713213064ef1.value;
                }
            }
        }
        else
        {
            omnvar_value = namespace_2aca03e533f9f843::function_223197707cc140fe( broadcast_data_object );
        }
        
        if ( var_bae54c46de9c2c0d )
        {
            if ( !isarray( players ) )
            {
                players = [ players ];
            }
            
            foreach ( player in players )
            {
                player setclientomnvar( omnvar_name, omnvar_value );
            }
            
            return;
        }
        
        setomnvar( omnvar_name, omnvar_value );
    }
}

// Namespace namespace_1b399d08202b861f
// Params 3
// Checksum 0x3967c67c, Offset: 0x2f6
// Size: 0x10d
function function_ec9eda8a64cd5d1e( players, broadcast_instance, broadcast_command )
{
    assert( broadcast_instance player_broadcasting::getbroadcasttype() == "<dev string:x24>" );
    data_objects = broadcast_instance player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 || broadcast_command == 2 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        text = data_object.variant_object.stringtext;
        style = data_object.variant_object.stringtextstyle;
        
        if ( isstring( text ) && isstring( style ) )
        {
            /#
                text = function_8019a8fecb85939a( text, broadcast_instance, data_object );
                
                if ( style == "<dev string:x2f>" )
                {
                    iprintlnbold( text );
                }
                else
                {
                    iprintln( text );
                }
            #/
            
            continue;
        }
        
        assertmsg( "<dev string:x42>" );
    }
}

// Namespace namespace_1b399d08202b861f
// Params 3
// Checksum 0x9fd122cb, Offset: 0x40b
// Size: 0x85
function function_81fd4e7d576bb( players, broadcast_instance, broadcast_command )
{
    assert( broadcast_instance player_broadcasting::getbroadcasttype() == "<dev string:x98>" );
    data_objects = broadcast_instance player_broadcasting::function_d95fdf9867bbbdc3();
    
    if ( data_objects.size == 0 )
    {
        return;
    }
    
    for ( data_object_index = 0; data_object_index < data_objects.size ; data_object_index++ )
    {
        data_object = data_objects[ data_object_index ];
        function_cdcae179fad195e6( players, broadcast_instance, data_object, broadcast_command );
    }
}

// Namespace namespace_1b399d08202b861f
// Params 3
// Checksum 0xe3b200eb, Offset: 0x498
// Size: 0x29
function function_607e3a0d045b4fb1( players, broadcast, broadcast_command )
{
    string_messaging_util::function_1c934d8a432c54d7( players, broadcast, broadcast_command );
}

// Namespace namespace_1b399d08202b861f
// Params 3, eflags: 0x4
// Checksum 0xe89e5f46, Offset: 0x4c9
// Size: 0x130
function private function_8019a8fecb85939a( var_b06bbdd3aa93d566, broadcast_instance, data_object )
{
    dynamic_data_objects = namespace_2aca03e533f9f843::function_4f657490daa8ca51( data_object );
    dynamic_data_size = dynamic_data_objects.size;
    
    for ( var_dea3985ee297b6e = 0; var_dea3985ee297b6e < dynamic_data_size ; var_dea3985ee297b6e++ )
    {
        var_7cef713213064ef1 = namespace_2aca03e533f9f843::function_e2456da4d8c9ce1( broadcast_instance, data_object, var_dea3985ee297b6e );
        
        if ( isdefined( var_7cef713213064ef1 ) && isdefined( var_7cef713213064ef1.value ) )
        {
            var_ce74707260227c0e = var_7cef713213064ef1.value;
            
            if ( var_7cef713213064ef1.type != "String" )
            {
                var_ce74707260227c0e = string( var_ce74707260227c0e );
            }
            
            replacement_substring = "&&" + string( var_dea3985ee297b6e );
            string_array = strtok( var_b06bbdd3aa93d566, " " );
            replaced_string_array = [];
            
            for ( string_index = 0; string_index < string_array.size ; string_index++ )
            {
                substr = string_array[ string_index ];
                replaced_string_array[ string_index ] = substr == replacement_substring ? var_ce74707260227c0e : substr;
            }
            
            var_b06bbdd3aa93d566 = function_5d044133536d0766( " ", replaced_string_array );
        }
    }
    
    return var_b06bbdd3aa93d566;
}

