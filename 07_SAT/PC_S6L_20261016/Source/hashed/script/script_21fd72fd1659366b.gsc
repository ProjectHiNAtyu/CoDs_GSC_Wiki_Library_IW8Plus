// script_21fd72fd1659366b  (hash_21fd72fd1659366b.gscc) (size: 2060 Bytes / 0x80c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2d63c0b (4074126347)
// size ...... 2060 (0x80c)
// includes .. 1   (offset: 0x76c)
// strings ... 10  (offset: 0x774)
// dev strs .. 0   (offset: 0x80c)
// exports ... 6   (offset: 0x490)
// cseg ...... 0xb9 + 0x3d7 (0x490)
// imports ... 16  (offset: 0x580)
// animtree1 . 0   (offset: 0x80c)
// animtree2 . 0   (offset: 0x80c)
#using scripts\autotests\autotests;

#namespace namespace_77a7a114795997f2;

// Namespace namespace_77a7a114795997f2
// Params 1
// Checksum 0xd8d6d9e3, Offset: 0xd7
// Size: 0x2a
function function_24e542264ef175e8( value )
{
    if ( isstring( value ) )
    {
        return ( "\"" + value + "\"" );
    }
    
    return string( value );
}

// Namespace namespace_77a7a114795997f2
// Params 1
// Checksum 0x2aa4d201, Offset: 0x10a
// Size: 0xc7
function function_ac73b98313f5b4d8( args )
{
    json = "{";
    first = 1;
    
    foreach ( key, value in args )
    {
        if ( !first )
        {
            json += ",";
        }
        
        json += "\"" + key + "\":" + function_24e542264ef175e8( value );
        first = 0;
    }
    
    return json + "}";
}

// Namespace namespace_77a7a114795997f2
// Params 2
// Checksum 0xf29230a1, Offset: 0x1da
// Size: 0x132
function function_fd47029ccb40f5eb( test_name, timeout_s )
{
    rec_name = "";
    start_time = gettime();
    timeout_ms = timeout_s * 1000;
    
    while ( rec_name != test_name )
    {
        while ( getdvarint( @"autotest_state" ) == 2 )
        {
            wait 0.1;
            
            if ( gettime() - start_time >= timeout_ms )
            {
                setdvar( @"autotest_state", 1 );
                setdvar( @"hash_2162d2e2be4e6b27", "" );
                return 8;
            }
        }
        
        response = strtok( getdvar( @"hash_2162d2e2be4e6b27" ), "|" );
        
        if ( !response || response.size < 2 )
        {
            setdvar( @"hash_2162d2e2be4e6b27", "" );
            setdvar( @"autotest_state", 2 );
            continue;
        }
        
        rec_name = response[ 0 ];
        rec_result = response[ 1 ];
        
        if ( rec_name != test_name )
        {
            setdvar( @"hash_2162d2e2be4e6b27", "" );
            setdvar( @"autotest_state", 2 );
        }
    }
    
    return rec_result;
}

// Namespace namespace_77a7a114795997f2
// Params 5
// Checksum 0xa5a38ffb, Offset: 0x315
// Size: 0xde
function function_f2eb460ffa6ebfc3( test_name, expected_result, timeout_s, file, line )
{
    if ( !getdvarint( @"hash_545c71bca6539094" ) )
    {
        setdvar( @"autotest_state", 1 );
        setdvar( @"hash_2162d2e2be4e6b27", "" );
        rec_result = 5;
    }
    else
    {
        setdvar( @"autotest_state", 2 );
        rec_result = int( function_fd47029ccb40f5eb( test_name, timeout_s ) );
    }
    
    if ( expected_result == 11 )
    {
        autotests::function_e496a326e5d58a25( test_name, rec_result, rec_result, rec_result, file, line );
    }
    else
    {
        response_matched = rec_result == expected_result;
        autotests::function_fa8a8f2a8961ec0b( test_name, response_matched, rec_result, expected_result, file, line );
    }
    
    setdvar( @"hash_2162d2e2be4e6b27", "" );
}

// Namespace namespace_77a7a114795997f2
// Params 7
// Checksum 0xc55c2e29, Offset: 0x3fb
// Size: 0x95
function call_intention( intent, args, test_name, expected_result, timeout_s, file, line )
{
    json_args = function_ac73b98313f5b4d8( args );
    msg = "event|run_intent|name|" + test_name + "|intent|{\"intent\":\"" + intent + "\",\"args\":" + json_args + "}";
    sendautotestmsg( msg );
    function_f2eb460ffa6ebfc3( test_name, expected_result, timeout_s, file, line );
}

