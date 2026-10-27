// scripts\common\feature_init.gsc  (hash_23a295a7d3a949db.gscc) (size: 1841 Bytes / 0x731 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38c3f662 (952366690)
// size ...... 1841 (0x731)
// includes .. 0   (offset: 0x6d9)
// strings ... 0   (offset: 0x6d9)
// dev strs .. 7   (offset: 0x6d9)
// exports ... 9   (offset: 0x441)
// cseg ...... 0x58 + 0x3e9 (0x441)
// imports ... 10  (offset: 0x5a9)
// animtree1 . 0   (offset: 0x731)
// animtree2 . 0   (offset: 0x731)
#namespace feature_init;

// Namespace feature_init
// Params 3
// Checksum 0xb15d393b, Offset: 0x76
// Size: 0xb5
function function_ad79f973e2bd4636( key, initcallback, dependencies )
{
    if ( !isdefined( level.initlist ) )
    {
        level.initlist = [];
    }
    
    if ( isdefined( level.initlist[ key ] ) )
    {
        assertmsg( "<dev string:x24>" + key );
        return;
    }
    
    if ( isdefined( dependencies ) && !isarray( dependencies ) )
    {
        dependencies = [ dependencies ];
    }
    
    initdata = spawnstruct();
    initdata.callback = initcallback;
    initdata.dependencies = dependencies;
    level.initlist[ key ] = initdata;
    
    /#
        function_45a468a1b002d10c( key );
    #/
}

// Namespace feature_init
// Params 0
// Checksum 0xa06d9554, Offset: 0x133
// Size: 0xb5
function processinitlist()
{
    if ( !isdefined( level.initlist ) )
    {
        return;
    }
    
    level.initcount = 0;
    level.var_f534d6df1fb0cbb4 = [];
    
    foreach ( key, initdata in level.initlist )
    {
        /#
            function_84adc5c425524feb( key );
        #/
        
        callinitfunction( key, initdata );
    }
    
    level.initcount = undefined;
}

// Namespace feature_init
// Params 1, eflags: 0x4
// Checksum 0xa6149aa, Offset: 0x1f0
// Size: 0x4b
function private function_769527dc7dcdb21a( key )
{
    if ( !isdefined( level.initlist[ key ] ) )
    {
        return;
    }
    
    /#
        function_84adc5c425524feb( key );
    #/
    
    callinitfunction( key, level.initlist[ key ] );
    level.initlist[ key ] = undefined;
}

// Namespace feature_init
// Params 2, eflags: 0x4
// Checksum 0x62f78893, Offset: 0x243
// Size: 0x7a
function private callinitfunction( key, initdata )
{
    if ( !isdefined( initdata.callback ) )
    {
        assertmsg( "<dev string:x62>" + key );
        return;
    }
    
    cancall = function_87cace81bb7c856b( key, initdata );
    
    if ( !cancall )
    {
        return;
    }
    
    level [[ initdata.callback ]]();
    level.var_f534d6df1fb0cbb4[ key ] = 1;
    level.initcount++;
}

// Namespace feature_init
// Params 2, eflags: 0x4
// Checksum 0xb0bed19e, Offset: 0x2c5
// Size: 0xc7, Type: bool
function private function_87cace81bb7c856b( key, initdata )
{
    if ( !isdefined( initdata.dependencies ) )
    {
        return true;
    }
    
    foreach ( dependency in initdata.dependencies )
    {
        if ( !level.var_f534d6df1fb0cbb4[ dependency ] )
        {
            assertmsg( "<dev string:x91>" + key + "<dev string:xc6>" + dependency );
            return false;
        }
    }
    
    return true;
}

// Namespace feature_init
// Params 0
// Checksum 0x99d9a965, Offset: 0x395
// Size: 0x40
function in_play_limits_init()
{
    if ( isdefined( level.in_play_limits ) && isfunction( level.in_play_limits.init ) )
    {
        [[ level.in_play_limits.init ]]();
    }
}

/#

    // Namespace feature_init
    // Params 1
    // Checksum 0x42d00f3b, Offset: 0x3dd
    // Size: 0x30, Type: dev
    function function_45a468a1b002d10c( key )
    {
        println( "<dev string:xee>" + level.initlist.size - 1 + "<dev string:xfe>" + key );
    }

    // Namespace feature_init
    // Params 1
    // Checksum 0xcb633779, Offset: 0x415
    // Size: 0x2c, Type: dev
    function function_84adc5c425524feb( key )
    {
        println( "<dev string:xee>" + level.initcount + "<dev string:x11f>" + key );
    }

#/
