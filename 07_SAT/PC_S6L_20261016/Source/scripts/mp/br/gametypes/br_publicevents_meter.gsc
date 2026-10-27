// scripts\mp\br\gametypes\br_publicevents_meter.gsc  (hash_190a966aa35a278a.gscc) (size: 5256 Bytes / 0x1488 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x674f39ae (1733245358)
// size ...... 5256 (0x1488)
// includes .. 6   (offset: 0x1398)
// strings ... 11  (offset: 0x13c8)
// dev strs .. 3   (offset: 0x1464)
// exports ... 21  (offset: 0xbe0)
// cseg ...... 0x155 + 0xa8b (0xbe0)
// imports ... 37  (offset: 0xf28)
// animtree1 . 0   (offset: 0x1488)
// animtree2 . 0   (offset: 0x1488)
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\flags;

#namespace br_publicevents_meter;

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x8a863db3, Offset: 0x173
// Size: 0xd2
function init()
{
    level.br_pe_meter = spawnstruct();
    level.br_pe_meter.timescompleted = 0;
    level.br_pe_meter.state = 0;
    level.br_pe_meter.targets = function_9b28ca4930622c71();
    
    if ( function_d7a09e27a2ddab8e() )
    {
        level.br_pe_meter.predeterminedevents = function_6e9c7ceabbc36444();
    }
    
    level.br_pe_meter.timer = spawnstruct();
    level.br_pe_meter.timer.duration = level.br_pe_meter.targets[ 0 ];
    thread function_ba5553a84113ac87();
    
    /#
        function_728a5ccb9cecae47();
    #/
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x57f285e5, Offset: 0x24d
// Size: 0x12, Type: bool
function function_3579c7d501f13cef()
{
    return getdvarint( @"hash_4558abf9d259b284", 0 ) > 0;
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0xc88f15fd, Offset: 0x268
// Size: 0x13, Type: bool
function function_d7a09e27a2ddab8e()
{
    return getdvarint( @"scr_br_pe_meter_predetermined_events_enabled", 1 ) > 0;
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x5cdf713a, Offset: 0x284
// Size: 0xcb
function function_9b28ca4930622c71()
{
    var_2775e4f818fb071d = getdvar( @"hash_bc9d24d7d03581e3", "0 0 0" );
    var_547b8a5217454b25 = [];
    
    if ( var_2775e4f818fb071d != "" )
    {
        var_cb87b17d283434f0 = strtok( var_2775e4f818fb071d, " " );
        
        foreach ( target in var_cb87b17d283434f0 )
        {
            targetvalue = int( target );
            var_547b8a5217454b25[ var_547b8a5217454b25.size ] = targetvalue;
        }
    }
    
    return var_547b8a5217454b25;
}

// Namespace br_publicevents_meter
// Params 1
// Checksum 0x629f2644, Offset: 0x358
// Size: 0xd5
function function_8ef0c602af29d92c( eventname )
{
    var_acf417c99a1c26b7 = getdvar( hashcat( @"hash_abb46656d4b7e51c", eventname, "_pe_meter_event_weights" ), "0 0 0 0 0 0 0 0" );
    var_6dc02acf6b07a4a7 = [];
    
    if ( var_acf417c99a1c26b7 != "" )
    {
        var_81c66ecf1b4ec281 = strtok( var_acf417c99a1c26b7, " " );
        
        foreach ( weight in var_81c66ecf1b4ec281 )
        {
            var_6dc02acf6b07a4a7[ var_6dc02acf6b07a4a7.size ] = float( weight );
        }
    }
    
    return var_6dc02acf6b07a4a7;
}

// Namespace br_publicevents_meter
// Params 0, eflags: 0x4
// Checksum 0x5e0db500, Offset: 0x436
// Size: 0x13e
function private function_6e9c7ceabbc36444()
{
    predeterminedevents = spawnstruct();
    predeterminedevents.eventtypes = [];
    var_4ce43ddbd0ef949e = getdvar( @"scr_br_pe_meter_predetermined_events", "" );
    var_4d63578308f9369d = strtok( var_4ce43ddbd0ef949e, "," );
    
    if ( var_4d63578308f9369d.size == 0 )
    {
        script::demoforcesre( "Public Event Meters: No predetermined public events set! Set dvar 'scr_br_pe_meter_predetermined_events'" );
        return;
    }
    
    for ( i = 0; i < var_4d63578308f9369d.size ; i++ )
    {
        predeterminedevents.eventtypes[ i ] = [];
        meterevents = strtok( var_4d63578308f9369d[ i ], " " );
        
        foreach ( event in meterevents )
        {
            if ( event.size == 0 )
            {
                continue;
            }
            
            predeterminedevents.eventtypes[ i ][ predeterminedevents.eventtypes[ i ].size ] = getxhashasset( event );
        }
    }
    
    return predeterminedevents;
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x18369a97, Offset: 0x57d
// Size: 0x47
function function_e77d68f68a9a6e76()
{
    meterlevel = level.br_pe_meter.timescompleted;
    meterlevel = clamp( meterlevel, 0, level.br_pe_meter.targets.size - 1 );
    return int( meterlevel );
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x2d3948cc, Offset: 0x5cd
// Size: 0xc6
function function_3a7daaaa98464cc6()
{
    endtimems = level.br_pe_meter.timer.endtime;
    
    if ( !isdefined( endtimems ) )
    {
        return;
    }
    
    currenttimems = gettime();
    
    if ( currenttimems >= endtimems )
    {
        return;
    }
    
    meterlevel = function_e77d68f68a9a6e76();
    eventdurationms = utility::function_4b74c15943231980( level.br_pe_meter.targets[ meterlevel ] );
    
    if ( eventdurationms <= 0 )
    {
        assertmsg( "<dev string:x24>" );
        eventdurationms = 1;
    }
    
    starttimems = endtimems - eventdurationms;
    timeelapsed = currenttimems - starttimems;
    elapsedpercent = timeelapsed / eventdurationms;
    return elapsedpercent;
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0xc51ec98a, Offset: 0x69c
// Size: 0x46, Type: bool
function function_8d403249f88e4fa5()
{
    if ( !level.br_pe_meter.var_f975f4a4814d9bda )
    {
        return false;
    }
    
    return level.br_pe_meter.timescompleted > level.br_pe_meter.targets.size - 1;
}

// Namespace br_publicevents_meter
// Params 0, eflags: 0xc
// Checksum 0x5fe9dbea, Offset: 0x6eb
// Size: 0x42
function private function_ba5553a84113ac87()
{
    self notify( #"hash_7ac0d96e611be07" );
    self endon( #"hash_7ac0d96e611be07" );
    level endon( #"cancel_public_event" );
    flags::gameflagwait( "prematch_done" );
    function_8c4945d1b37cfa5( 1 );
    thread function_a07592046f99cf10();
}

// Namespace br_publicevents_meter
// Params 0, eflags: 0x4
// Checksum 0x9844c047, Offset: 0x735
// Size: 0xf9
function private function_636f709b6065e6eb()
{
    meterlevel = function_e77d68f68a9a6e76();
    
    if ( function_d7a09e27a2ddab8e() )
    {
        eventtypes = level.br_pe_meter.predeterminedevents.eventtypes[ meterlevel ];
        
        foreach ( eventtype in eventtypes )
        {
            level thread br_publicevents::runpubliceventoftype( eventtype, 1, meterlevel, 1 );
        }
    }
    else
    {
        level thread br_publicevents::choosepubliceventtype( 1, meterlevel, 1 );
    }
    
    level.br_pe_meter.timescompleted += 1;
}

// Namespace br_publicevents_meter
// Params 0, eflags: 0xc
// Checksum 0xeceb3fdd, Offset: 0x836
// Size: 0x126
function private function_a07592046f99cf10()
{
    self notify( #"hash_338a6cdbe11e8d40" );
    self endon( #"hash_338a6cdbe11e8d40" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        meterlevel = function_e77d68f68a9a6e76();
        target = level.br_pe_meter.targets[ meterlevel ];
        endtime = gettime() + target * 1000;
        function_8c4945d1b37cfa5( 1 );
        function_70f4cde9daa4a7d4( endtime );
        function_d0991ec5846f2b31( target );
        
        while ( gettime() < level.br_pe_meter.timer.endtime || level.br_pe_meter.state == 0 )
        {
            wait 0.1;
        }
        
        function_8c4945d1b37cfa5( 2 );
        function_636f709b6065e6eb();
        
        while ( br_publicevents::function_c0107b0309333b0d() )
        {
            level utility::waittill_any( "br_pe_end", "cancel_public_event" );
        }
        
        if ( level.br_pe_meter.var_a3bf88e374a5882c )
        {
            function_8c4945d1b37cfa5( 3 );
            return;
        }
        
        waitframe();
    }
}

// Namespace br_publicevents_meter
// Params 1
// Checksum 0x2d2e0534, Offset: 0x964
// Size: 0x7b
function function_867babbd9eab0091( seconds )
{
    if ( !isdefined( seconds ) || seconds == 0 || !isdefined( level.br_pe_meter.timer.endtime ) )
    {
        return;
    }
    
    endtime = level.br_pe_meter.timer.endtime;
    endtime += seconds * 1000;
    function_70f4cde9daa4a7d4( endtime );
}

// Namespace br_publicevents_meter
// Params 0
// Checksum 0x5ef09bcc, Offset: 0x9e7
// Size: 0x18
function function_a3bf88e374a5882c()
{
    level.br_pe_meter.var_a3bf88e374a5882c = 1;
}

/#

    // Namespace br_publicevents_meter
    // Params 0
    // Checksum 0x205207ce, Offset: 0xa07
    // Size: 0x23, Type: dev
    function function_b26490b1e738864f()
    {
        if ( level.br_pe_meter.var_a3bf88e374a5882c )
        {
            level thread function_ba5553a84113ac87();
        }
    }

#/

// Namespace br_publicevents_meter
// Params 1, eflags: 0x4
// Checksum 0x963213c6, Offset: 0xa32
// Size: 0x64
function private function_8c4945d1b37cfa5( state )
{
    if ( !isdefined( state ) || level.br_pe_meter.state == state )
    {
        return;
    }
    
    assert( -1, "<dev string:x68>" );
    level.br_pe_meter.state = state;
    omnvar_utility::function_8b206c75cb7ad548( "ui_br_pe_meter_data", 0, 2, state );
}

// Namespace br_publicevents_meter
// Params 1, eflags: 0x4
// Checksum 0x9f324a7d, Offset: 0xa9e
// Size: 0x54
function private function_70f4cde9daa4a7d4( endtime )
{
    level.br_pe_meter.timer.endtime = endtime;
    secondsendtime = int( endtime / 1000 );
    omnvar_utility::function_8b206c75cb7ad548( "ui_br_pe_meter_data", 2, 11, secondsendtime );
}

// Namespace br_publicevents_meter
// Params 1, eflags: 0x4
// Checksum 0x31e3d5ea, Offset: 0xafa
// Size: 0x3e
function private function_d0991ec5846f2b31( duration )
{
    level.br_pe_meter.timer.duration = duration;
    omnvar_utility::function_8b206c75cb7ad548( "ui_br_pe_meter_data", 13, 8, duration );
}

/#

    // Namespace br_publicevents_meter
    // Params 0
    // Checksum 0xc2b644c4, Offset: 0xb40
    // Size: 0x11, Type: dev
    function function_728a5ccb9cecae47()
    {
        br_dev::registerhandlecommand( &function_e78ba1d577b51e3a );
    }

    // Namespace br_publicevents_meter
    // Params 2, eflags: 0x4
    // Checksum 0x725c4b06, Offset: 0xb59
    // Size: 0x87, Type: dev
    function private function_e78ba1d577b51e3a( cmd, args )
    {
        if ( cmd != "<dev string:xc4>" )
        {
            return;
        }
        
        switch ( args[ 0 ] )
        {
            case #"hash_c61546c10a51754":
                function_867babbd9eab0091( int( args[ 1 ] ) );
                break;
            case #"hash_e9545d0bee0d374a":
                level.br_pe_meter.timescompleted = int( args[ 1 ] );
                break;
            default:
                break;
        }
    }

#/
