// scripts\common\string.gsc  (hash_2ed63158b46a6d6f.gscc) (size: 930 Bytes / 0x3a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e39be28 (1043971624)
// size ...... 930 (0x3a2)
// includes .. 0   (offset: 0x366)
// strings ... 2   (offset: 0x366)
// dev strs .. 2   (offset: 0x37e)
// exports ... 6   (offset: 0x1fe)
// cseg ...... 0x64 + 0x19a (0x1fe)
// imports ... 4   (offset: 0x2ee)
// animtree1 . 0   (offset: 0x3a2)
// animtree2 . 0   (offset: 0x3a2)
#namespace string;

// Namespace string
// Params 1
// Checksum 0x9b874ba3, Offset: 0x82
// Size: 0x1e
function to_string( var )
{
    if ( isdefined( var ) )
    {
        return string( var );
    }
    
    return "";
}

// Namespace string
// Params 1
// Checksum 0xa1ce4b9d, Offset: 0xa9
// Size: 0x1c, Type: bool
function function_63338a5831bf61d9( str )
{
    return !isdefined( str ) || str == "none";
}

/#

    // Namespace string
    // Params 3
    // Checksum 0xfb93f626, Offset: 0xce
    // Size: 0x58, Type: dev
    function rjust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x24>";
        }
        
        str_input = to_string( str_input );
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_fill + str_input;
    }

    // Namespace string
    // Params 3
    // Checksum 0x2443dfc5, Offset: 0x12e
    // Size: 0x58, Type: dev
    function ljust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x24>";
        }
        
        str_input = to_string( str_input );
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_input + str_fill;
    }

    // Namespace string
    // Params 2
    // Checksum 0xa0705744, Offset: 0x18e
    // Size: 0x70, Type: dev
    function fill( n_length, str_fill )
    {
        if ( !isdefined( str_fill ) || str_fill == "<dev string:x26>" )
        {
            str_fill = "<dev string:x24>";
        }
        
        str_return = "<dev string:x26>";
        
        while ( n_length > 0 )
        {
            str = getsubstr( str_fill, 0, n_length );
            n_length -= str.size;
            str_return += str;
        }
        
        return str_return;
    }

#/
