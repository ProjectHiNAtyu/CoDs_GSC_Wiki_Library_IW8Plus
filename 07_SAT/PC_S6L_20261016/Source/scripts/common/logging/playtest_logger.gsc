// scripts\common\logging\playtest_logger.gsc  (hash_507576ed5f2c7201.gscc) (size: 1904 Bytes / 0x770 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12c4e227 (314892839)
// size ...... 1904 (0x770)
// includes .. 0   (offset: 0x728)
// strings ... 6   (offset: 0x728)
// dev strs .. 0   (offset: 0x770)
// exports ... 9   (offset: 0x470)
// cseg ...... 0xb3 + 0x3bd (0x470)
// imports ... 11  (offset: 0x5d8)
// animtree1 . 0   (offset: 0x770)
// animtree2 . 0   (offset: 0x770)
#namespace playtest_logger;

// Namespace playtest_logger
// Params 8
// Checksum 0x2d69d8f0, Offset: 0xd1
// Size: 0xd9
function function_81cc4ca859a01d68( var_97682644a8d19e7c, var_d2f7ceaf88896048, var_4d8c952cd0ca99a1, var_a32af1600b7d8503, var_4546ebd04305a9ef, var_7c91d6bc3b52ffaf, var_d0e826c9a2ed0924, logmsgprefix = "PLAYTEST_LOGGER" )
{
    struct = spawnstruct();
    struct.logmsgprefix = logmsgprefix;
    struct.var_97682644a8d19e7c = var_97682644a8d19e7c;
    struct.var_d2f7ceaf88896048 = var_d2f7ceaf88896048;
    struct.var_4d8c952cd0ca99a1 = var_4d8c952cd0ca99a1;
    struct.var_a32af1600b7d8503 = var_a32af1600b7d8503;
    struct.var_4546ebd04305a9ef = var_4546ebd04305a9ef;
    struct.var_7c91d6bc3b52ffaf = var_7c91d6bc3b52ffaf;
    struct.var_d0e826c9a2ed0924 = var_d0e826c9a2ed0924;
    return struct;
}

// Namespace playtest_logger
// Params 2
// Checksum 0xed6f6588, Offset: 0x1b3
// Size: 0x22
function logassert( assertmessage, var_60fef2e8ce64f16e )
{
    function_b3bbbcdc1984dae9( assertmessage, 3, var_60fef2e8ce64f16e );
}

// Namespace playtest_logger
// Params 2
// Checksum 0x5abac539, Offset: 0x1dd
// Size: 0x21
function logerror( msg, var_60fef2e8ce64f16e )
{
    function_b3bbbcdc1984dae9( msg, 0, var_60fef2e8ce64f16e );
}

// Namespace playtest_logger
// Params 2
// Checksum 0x5ffcb8dd, Offset: 0x206
// Size: 0x22
function logwarning( msg, var_60fef2e8ce64f16e )
{
    function_b3bbbcdc1984dae9( msg, 2, var_60fef2e8ce64f16e );
}

// Namespace playtest_logger
// Params 2
// Checksum 0xf5133da1, Offset: 0x230
// Size: 0x22
function loginfo( msg, var_60fef2e8ce64f16e )
{
    function_b3bbbcdc1984dae9( msg, 1, var_60fef2e8ce64f16e );
}

// Namespace playtest_logger
// Params 3
// Checksum 0x98c4c960, Offset: 0x25a
// Size: 0xa5
function function_b3bbbcdc1984dae9( msg, loglevel, loggerconfig )
{
    var_541b4bfa6cd850a = function_49a3e486d8ae7340( loglevel, loggerconfig );
    
    if ( var_541b4bfa6cd850a )
    {
        logmsg = function_de9b7a53ee2c23d( msg, loglevel, loggerconfig );
        logstring( logmsg );
    }
    
    /#
        if ( !isdefined( logmsg ) )
        {
            logmsg = function_de9b7a53ee2c23d( msg, loglevel, loggerconfig );
        }
        
        if ( loglevel == 3 || loglevel == 0 && getdvarint( loggerconfig.var_d0e826c9a2ed0924, 0 ) )
        {
            assertmsg( logmsg );
            return;
        }
        
        if ( !var_541b4bfa6cd850a )
        {
            println( logmsg );
        }
    #/
}

// Namespace playtest_logger
// Params 3, eflags: 0x4
// Checksum 0xa7cf6a18, Offset: 0x307
// Size: 0xab
function private function_de9b7a53ee2c23d( msg, loglevel, loggerconfig )
{
    if ( loglevel == 3 )
    {
        return ( loggerconfig.logmsgprefix + "ASSERT: " + msg );
    }
    else if ( loglevel == 1 )
    {
        return ( loggerconfig.logmsgprefix + "INFO: " + msg );
    }
    else if ( loglevel == 0 )
    {
        return ( loggerconfig.logmsgprefix + "ERROR: " + msg );
    }
    else if ( loglevel == 2 )
    {
        return ( loggerconfig.logmsgprefix + "WARNING: " + msg );
    }
    
    return loggerconfig.logmsgprefix + " [unknown log level]: ";
}

// Namespace playtest_logger
// Params 2, eflags: 0x4
// Checksum 0xb0df2146, Offset: 0x3bb
// Size: 0xb4, Type: bool
function private function_49a3e486d8ae7340( loglevel, loggerconfig )
{
    if ( !getdvarint( loggerconfig.var_97682644a8d19e7c, 0 ) )
    {
        return false;
    }
    
    if ( getdvarint( loggerconfig.var_7c91d6bc3b52ffaf, 0 ) )
    {
        return true;
    }
    else if ( loglevel == 3 )
    {
        return istrue( getdvarint( loggerconfig.var_4546ebd04305a9ef ) );
    }
    else if ( loglevel == 1 )
    {
        return istrue( getdvarint( loggerconfig.var_d2f7ceaf88896048, 0 ) );
    }
    else if ( loglevel == 0 )
    {
        return istrue( getdvarint( loggerconfig.var_a32af1600b7d8503, 0 ) );
    }
    else if ( loglevel == 2 )
    {
        return istrue( getdvarint( loggerconfig.var_4d8c952cd0ca99a1, 0 ) );
    }
    
    return false;
}

