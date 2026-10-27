// script_1746f14cc7bde851  (hash_1746f14cc7bde851.gscc) (size: 2631 Bytes / 0xa47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51c3388f (1371748495)
// size ...... 2631 (0xa47)
// includes .. 2   (offset: 0x9bb)
// strings ... 6   (offset: 0x9cb)
// dev strs .. 3   (offset: 0xa1f)
// exports ... 11  (offset: 0x5a3)
// cseg ...... 0x109 + 0x49a (0x5a3)
// imports ... 20  (offset: 0x75b)
// animtree1 . 0   (offset: 0xa47)
// animtree2 . 0   (offset: 0xa47)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_common_kiosk;

#namespace namespace_492d4ed3c588587e;

// Namespace namespace_492d4ed3c588587e
// Params 0
// Checksum 0xe02b8813, Offset: 0x127
// Size: 0x21
function init()
{
    function_f29511759e3ab138();
    function_62c400e98e1569df();
    thread function_930e7b2a05f2b1b5();
    
    /#
        thread function_f629f8071d914c55();
    #/
}

// Namespace namespace_492d4ed3c588587e
// Params 0
// Checksum 0xfea9f715, Offset: 0x150
// Size: 0x10
function function_106d3cd3d57cf4f5()
{
    return getdvarint( @"hash_4424ca8b4ba52855", 0 );
}

// Namespace namespace_492d4ed3c588587e
// Params 0
// Checksum 0x751efd46, Offset: 0x169
// Size: 0x11a
function function_f29511759e3ab138()
{
    level.armsrace = spawnstruct();
    level.var_e298f874f79103ed = 0;
    level.var_c3258700fcc17d2 = getdvarint( @"hash_3a46a72925b4f73d", 0 );
    level.armsrace.start_delay = getdvarint( @"hash_9bcad531e37e189f", 0 );
    level.armsrace.change_interval = getdvarint( @"hash_6d65b9271397b983", 30 );
    level.armsrace.var_7b8b60b7a83dacfb = [];
    level.armsrace.var_7d990459773a78fd = [];
    var_3d71e60acb29c1fd = getdvar( @"hash_d29a39db193366b3", "" );
    
    if ( var_3d71e60acb29c1fd != "" )
    {
        level.armsrace.var_7b8b60b7a83dacfb = strtok( var_3d71e60acb29c1fd, "," );
    }
    
    if ( getdvarint( @"hash_7ede86a9bc79f83d", 1 ) == 1 )
    {
        utility::registersharedfunc( #"gametype", #"hash_17812df302dd419a", &function_43b8f21016ee24e7 );
    }
}

// Namespace namespace_492d4ed3c588587e
// Params 0
// Checksum 0x2875691f, Offset: 0x28b
// Size: 0x20
function function_62c400e98e1569df()
{
    utility::registersharedfunc( #"gametype", #"hash_c9f08d54474fc48b", &function_86bab32eaa909797 );
}

// Namespace namespace_492d4ed3c588587e
// Params 2
// Checksum 0xde30ce44, Offset: 0x2b3
// Size: 0x27
function function_86bab32eaa909797( botloadoutphase, botdifficulty )
{
    if ( botloadoutphase == 0 )
    {
        return "classtable:classtable_br_bot_armsrace_loadouts_phase1";
    }
    
    return "classtable:classtable_br_bot_armsrace_loadouts_phase2";
}

// Namespace namespace_492d4ed3c588587e
// Params 2
// Checksum 0x80b9ac95, Offset: 0x2e3
// Size: 0x77
function function_2b5e4706e2adcd8f( time, countdowntime )
{
    setomnvar( "ui_br_quick_buystation_refresh_countdown", -1 );
    
    if ( !isdefined( countdowntime ) )
    {
        countdowntime = 5;
    }
    
    tick_time = 0.1;
    
    while ( time > 0 )
    {
        time -= tick_time;
        
        if ( time < 0 )
        {
            time = 0;
        }
        
        if ( time <= countdowntime )
        {
            setomnvar( "ui_br_quick_buystation_refresh_countdown", time );
        }
        
        wait tick_time;
    }
    
    setomnvar( "ui_br_quick_buystation_refresh_countdown", -1 );
}

// Namespace namespace_492d4ed3c588587e
// Params 0
// Checksum 0x1c43c1f2, Offset: 0x362
// Size: 0x159
function function_930e7b2a05f2b1b5()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    function_2b5e4706e2adcd8f( level.armsrace.start_delay );
    var_7b8b60b7a83dacfb = level.armsrace.var_7b8b60b7a83dacfb;
    var_7d990459773a78fd = level.armsrace.var_7d990459773a78fd;
    var_1ae31039c0b0d80 = 2;
    
    if ( var_7b8b60b7a83dacfb.size == 0 )
    {
        return;
    }
    
    /#
        printarray( var_7b8b60b7a83dacfb, "<dev string:x24>" );
    #/
    
    changetimes = 0;
    
    while ( true )
    {
        randomindex = randomintrange( 0, var_7b8b60b7a83dacfb.size );
        var_7f9c5820ecf9c1dd = var_7b8b60b7a83dacfb[ randomindex ];
        recycledindex = changetimes % var_1ae31039c0b0d80;
        var_b4c0acf8e1dcd457 = var_7d990459773a78fd[ recycledindex ];
        var_7d990459773a78fd[ recycledindex ] = var_7f9c5820ecf9c1dd;
        br_common_kiosk::function_da1991d7d5596e0a( var_7f9c5820ecf9c1dd );
        
        if ( isdefined( var_b4c0acf8e1dcd457 ) )
        {
            var_7b8b60b7a83dacfb[ randomindex ] = var_b4c0acf8e1dcd457;
        }
        else
        {
            var_7b8b60b7a83dacfb[ randomindex ] = undefined;
            
            if ( isint( randomindex ) )
            {
                function_cdc669dbc8ea2101( var_7b8b60b7a83dacfb );
            }
        }
        
        changetimes += 1;
        
        /#
            printarray( var_7b8b60b7a83dacfb, "<dev string:x24>" );
            printarray( var_7d990459773a78fd, "<dev string:x49>" );
        #/
        
        function_2b5e4706e2adcd8f( level.armsrace.change_interval );
    }
}

// Namespace namespace_492d4ed3c588587e
// Params 2
// Checksum 0x4be6eac3, Offset: 0x4c3
// Size: 0x2c
function function_43b8f21016ee24e7( kiosk, itemdata )
{
    if ( itemdata.type == "weapon" )
    {
        return 1;
    }
}

/#

    // Namespace namespace_492d4ed3c588587e
    // Params 2
    // Checksum 0x418fcf14, Offset: 0x4f8
    // Size: 0x9e, Type: dev
    function printarray( arr, tag )
    {
        logstring( tag + arr.size );
        
        foreach ( ele in arr )
        {
            logstring( tag + ele );
        }
        
        logstring( "<dev string:x69>" );
    }

    // Namespace namespace_492d4ed3c588587e
    // Params 0
    // Checksum 0xd11c6c58, Offset: 0x59e
    // Size: 0x5, Type: dev
    function function_f629f8071d914c55()
    {
        
    }

#/
