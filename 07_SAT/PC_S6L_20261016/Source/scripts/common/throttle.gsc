// scripts\common\throttle.gsc  (hash_3e94a066ede97cc2.gscc) (size: 8906 Bytes / 0x22ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30c37168 (818114920)
// size ...... 8906 (0x22ca)
// includes .. 0   (offset: 0x2016)
// strings ... 33  (offset: 0x2016)
// dev strs .. 13  (offset: 0x221e)
// exports ... 23  (offset: 0x162a)
// cseg ...... 0x3ce + 0x125c (0x162a)
// imports ... 39  (offset: 0x19c2)
// animtree1 . 0   (offset: 0x22ca)
// animtree2 . 0   (offset: 0x22ca)
#namespace throttle;

// Namespace throttle
// Params 1, eflags: 0x4
// Checksum 0xbb94e11c, Offset: 0x3ec
// Size: 0x39
function private function_8280c88863030872( throttle )
{
    throttle endon( throttle.var_538c5b918e960f74 );
    
    while ( isdefined( throttle ) )
    {
        _throttle_update( throttle );
        wait throttle.updaterate_;
    }
}

// Namespace throttle
// Params 1, eflags: 0x4
// Checksum 0xe6e362cf, Offset: 0x42d
// Size: 0xaf
function private _throttle_update( throttle )
{
    profilestart();
    processed = 0;
    
    for ( index = 0; index < throttle.queue_.size ; index++ )
    {
        item = throttle.queue_[ index ];
        throttle.queue_[ index ] = undefined;
        
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        item notify( throttle.var_9aff5df0dbb7c83 );
        processed++;
        
        if ( processed >= throttle.processlimit_ )
        {
            break;
        }
    }
    
    throttle.queue_ = function_5713d46873b29625( throttle.queue_ );
    profilestop();
}

// Namespace throttle
// Params 4
// Checksum 0xe679abaf, Offset: 0x4e4
// Size: 0xe9
function throttle_initialize( name, processlimit = 1, updaterate, queuelimit )
{
    if ( processlimit == 0 )
    {
        return;
    }
    
    assert( isstring( name ) );
    throttle = spawnstruct();
    throttle.queue_ = [];
    throttle.var_9aff5df0dbb7c83 = name + "_wake_up";
    throttle.var_538c5b918e960f74 = name + "_stop_threads";
    throttle.processlimit_ = processlimit;
    throttle.updaterate_ = updaterate ?? level.framedurationseconds;
    throttle.queuelimit_ = queuelimit;
    
    if ( !isdefined( throttle.updaterate_ ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    thread function_8280c88863030872( throttle );
    return throttle;
}

// Namespace throttle
// Params 1
// Checksum 0xa8351cd4, Offset: 0x5d6
// Size: 0x19, Type: bool
function is_empty( throttle )
{
    return !throttle.queue_.size;
}

// Namespace throttle
// Params 1
// Checksum 0x1b12d655, Offset: 0x5f8
// Size: 0x9b, Type: bool
function function_eed893c053dbf304( throttle )
{
    if ( !isdefined( throttle.queue_ ) )
    {
        return true;
    }
    
    foreach ( item in throttle.queue_ )
    {
        if ( isdefined( item ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace throttle
// Params 1
// Checksum 0x9edd6a0, Offset: 0x69c
// Size: 0x24
function throttle_destroy( throttle )
{
    if ( isdefined( throttle ) )
    {
        throttle notify( throttle.var_538c5b918e960f74 );
        throttle = undefined;
    }
}

// Namespace throttle
// Params 2
// Checksum 0xcabd5525, Offset: 0x6c8
// Size: 0xf5
function throttle_wait_in_queue( throttle, entity )
{
    assert( !isdefined( throttle.gate ), "<dev string:x82>" );
    throttle endon( throttle.var_538c5b918e960f74 );
    
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:xd8>" );
        return;
    }
    
    while ( throttle.queue_.size > throttle.queuelimit_ )
    {
        _throttle_update( throttle );
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isent( entity ) && !isstruct( entity ) )
    {
        return;
    }
    
    if ( !arraycontains( throttle.queue_, entity ) )
    {
        throttle.queue_[ throttle.queue_.size ] = entity;
    }
    
    entity endon( #"death" );
    entity endon( #"delete" );
    entity waittill( throttle.var_9aff5df0dbb7c83 );
}

// Namespace throttle
// Params 2
// Checksum 0x2525a6bf, Offset: 0x7c5
// Size: 0x26
function function_311421fabea78894( throttle, entity )
{
    return arraycontains( throttle.queue_, entity );
}

// Namespace throttle
// Params 2
// Checksum 0x231531d4, Offset: 0x7f4
// Size: 0x32
function throttle_leave_queue( throttle, entity )
{
    throttle.queue_ = arrayremove( throttle.queue_, entity );
}

// Namespace throttle
// Params 3
// Checksum 0x72957935, Offset: 0x82e
// Size: 0xa9
function throttle_initialize_gate( name, processlimit = 1, updaterate )
{
    if ( processlimit == 0 )
    {
        return;
    }
    
    assert( isstring( name ) );
    throttle = spawnstruct();
    throttle.var_538c5b918e960f74 = name + "_stop_threads";
    throttle.var_13c10823fd93bc91 = 0;
    throttle.processlimit_ = processlimit;
    throttle.updaterate_ = updaterate ?? level.framedurationseconds;
    
    /#
        throttle.gate = 1;
    #/
    
    return throttle;
}

// Namespace throttle
// Params 1
// Checksum 0xbf02e8ea, Offset: 0x8e0
// Size: 0x8f
function throttle_wait_gate( throttle )
{
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:xd8>" );
        return;
    }
    
    assert( throttle.gate, "<dev string:xf1>" );
    
    if ( throttle.var_13c10823fd93bc91 >= throttle.processlimit_ )
    {
        throttle endon( throttle.var_538c5b918e960f74 );
        wait throttle.updaterate_;
        throttle.var_13c10823fd93bc91 = 1;
        return 1;
    }
    
    throttle.var_13c10823fd93bc91++;
    return 0;
}

// Namespace throttle
// Params 4
// Checksum 0x13effb3a, Offset: 0x978
// Size: 0xe2
function function_ac02df3f2e81cbab( name, processlimit = 1, updaterate, gatefrequency )
{
    if ( processlimit == 0 )
    {
        return;
    }
    
    assert( isstring( name ) );
    throttle = spawnstruct();
    throttle.var_538c5b918e960f74 = name + "_stop_threads";
    throttle.var_13c10823fd93bc91 = 0;
    throttle.processlimit_ = processlimit;
    throttle.updaterate_ = updaterate ?? level.framedurationseconds;
    throttle.var_e064ce760682c986 = int( ( gatefrequency ?? level.framedurationseconds ) * 1000 );
    throttle.var_659ff8afcce5a7c9 = -1;
    
    /#
        throttle.var_8e7b3e975fdd2a97 = 1;
    #/
    
    return throttle;
}

// Namespace throttle
// Params 1
// Checksum 0x9c0991ff, Offset: 0xa63
// Size: 0xcb
function function_706ed379a3746335( throttle )
{
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:xd8>" );
        return;
    }
    
    assert( throttle.var_8e7b3e975fdd2a97, "<dev string:x148>" );
    timenow = gettime();
    
    if ( timenow < throttle.var_659ff8afcce5a7c9 )
    {
        throttle endon( throttle.var_538c5b918e960f74 );
        secondstowait = ( throttle.var_659ff8afcce5a7c9 - timenow ) * 0.001;
        wait secondstowait;
    }
    else if ( throttle.var_659ff8afcce5a7c9 != -1 )
    {
        waitframe();
    }
    
    throttle.var_659ff8afcce5a7c9 = gettime() + throttle.var_e064ce760682c986;
    throttle.var_13c10823fd93bc91 = 0;
}

// Namespace throttle
// Params 1
// Checksum 0x47aa5fd1, Offset: 0xb36
// Size: 0x8a
function function_1302aa73badc74f0( throttle )
{
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:xd8>" );
        return;
    }
    
    assert( throttle.var_8e7b3e975fdd2a97, "<dev string:x1bc>" );
    
    if ( throttle.var_13c10823fd93bc91 >= throttle.processlimit_ )
    {
        throttle endon( throttle.var_538c5b918e960f74 );
        wait throttle.updaterate_;
        throttle.var_13c10823fd93bc91 = 0;
    }
    
    throttle.var_13c10823fd93bc91++;
}

// Namespace throttle
// Params 0
// Checksum 0xbc932e97, Offset: 0xbc8
// Size: 0x2c
function function_fd10bab4295ec41f()
{
    throttle_ut_initialize();
    throttle_ut_queue();
    throttle_ut_queue_10();
    throttle_ut_queue_10_threaded();
    throttle_ut_leave_queue();
    function_d4806c82433d6d48();
}

// Namespace throttle
// Params 1
// Checksum 0xcc47a072, Offset: 0xbfc
// Size: 0x20
function test_print( msg )
{
    /#
        msg = "<dev string:x227>" + msg;
        println( msg );
    #/
}

// Namespace throttle
// Params 0
// Checksum 0x6619e2fa, Offset: 0xc24
// Size: 0x24b
function throttle_ut_initialize()
{
    test_print( "BEGIN throttle_UT_initialize" );
    test_throttle = throttle_initialize( "test_throttle_1", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( test_throttle_1, " + 1 + ", " + level.framedurationseconds + ")" );
    assert( isarray( test_throttle.queue_ ) && test_throttle.queue_.size == 0 );
    assert( test_throttle.var_9aff5df0dbb7c83 == "<dev string:x237>" + "<dev string:x247>" );
    assert( test_throttle.processlimit_ == 1 );
    assert( test_throttle.updaterate_ == level.framedurationseconds );
    assert( !isdefined( test_throttle.queuelimit_ ) );
    test_throttle = throttle_initialize( "test_throttle_2", 2, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( test_throttle_2, " + 2 + ", " + level.framedurationseconds + ")" );
    assert( test_throttle.processlimit_ == 2 );
    test_throttle = throttle_initialize( "test_throttle_queueLimit", 1, level.framedurationseconds, 3 );
    test_print( "CALL - throttle_initialize( test_throttle_queueLimit, " + 1 + ", " + level.framedurationseconds + ", " + 3 + ")" );
    assert( test_throttle.queuelimit_ == 3 );
    test_throttle = throttle_initialize( "test_throttle_defaults" );
    test_print( "CALL - throttle_initialize( test_throttle_defaults )" );
    assert( isarray( test_throttle.queue_ ) && test_throttle.queue_.size == 0 );
    assert( test_throttle.var_9aff5df0dbb7c83 == "<dev string:x250>" + "<dev string:x247>" );
    assert( test_throttle.processlimit_ == 1 );
    assert( test_throttle.updaterate_ == level.framedurationseconds );
    assert( !isdefined( test_throttle.queuelimit_ ) );
    test_print( "END throttle_UT_initialize" );
}

// Namespace throttle
// Params 0
// Checksum 0xf6be0c0f, Offset: 0xe77
// Size: 0xc4
function throttle_ut_queue()
{
    test_print( "BEGIN throttle_UT_queue" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    entity = spawn( "script_model", ( 0, 0, 0 ) );
    throttle_wait_in_queue( test_throttle, entity );
    test_print( "CALL - wait_in_queue" );
    isinqueue = function_311421fabea78894( test_throttle, entity );
    test_print( "Ent in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_queue" );
}

// Namespace throttle
// Params 0
// Checksum 0x512d8969, Offset: 0xf43
// Size: 0x11c
function throttle_ut_queue_10()
{
    test_print( "BEGIN throttle_UT_queue_10" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        throttle_wait_in_queue( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
        test_print( "Ents in Queue - " + test_throttle.queue_.size );
    }
    
    isinqueue = function_311421fabea78894( test_throttle, ents[ 3 ] );
    test_print( "Ent 3 in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_queue_10" );
}

// Namespace throttle
// Params 0
// Checksum 0x2a415cf9, Offset: 0x1067
// Size: 0x11b
function throttle_ut_queue_10_threaded()
{
    test_print( "BEGIN throttle_UT_queue_10_threaded" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        thread throttle_wait_in_queue( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
        test_print( "Ents in Queue - " + test_throttle.queue_.size );
    }
    
    isinqueue = function_311421fabea78894( test_throttle, ents[ 3 ] );
    test_print( "Ent 3 in queue: " + isinqueue );
    assert( isinqueue );
    test_print( "END throttle_UT_queue_10_threaded" );
}

// Namespace throttle
// Params 0
// Checksum 0xb0a1a746, Offset: 0x118a
// Size: 0x143
function throttle_ut_leave_queue()
{
    test_print( "BEGIN throttle_UT_leave_queue" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        thread throttle_wait_in_queue( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
    }
    
    isinqueue = function_311421fabea78894( test_throttle, ents[ 3 ] );
    test_print( "ent 3 in queue: " + isinqueue );
    assert( isinqueue );
    throttle_leave_queue( test_throttle, ents[ 3 ] );
    test_print( "CALL - leave_queue" );
    isinqueue = function_311421fabea78894( test_throttle, ents[ 3 ] );
    test_print( "ent 3 in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_leave_queue" );
}

// Namespace throttle
// Params 0
// Checksum 0x61d6c6c6, Offset: 0x12d5
// Size: 0x355
function function_d4806c82433d6d48()
{
    /#
        test_print( "<dev string:x267>" );
        test_throttle = function_ac02df3f2e81cbab( "<dev string:x28d>", 2, undefined, 0.5 );
        assert( test_throttle.var_13c10823fd93bc91 == 0 );
        assert( test_throttle.processlimit_ == 2 );
        assert( test_throttle.updaterate_ == level.framedurationseconds );
        assert( isint( test_throttle.var_e064ce760682c986 ) );
        assert( test_throttle.var_e064ce760682c986 == 500 );
        assert( test_throttle.var_659ff8afcce5a7c9 == -1 );
        assert( test_throttle.var_8e7b3e975fdd2a97 );
        timenow = gettime();
        origtime = timenow;
        function_706ed379a3746335( test_throttle );
        assert( gettime() == timenow );
        assert( test_throttle.var_659ff8afcce5a7c9 != -1 );
        function_706ed379a3746335( test_throttle );
        var_e6bedfc791723be4 = level.frameduration * int( 500 / level.frameduration );
        assert( gettime() == timenow + var_e6bedfc791723be4 );
        timenow = gettime();
        origtime = timenow;
        function_1302aa73badc74f0( test_throttle );
        assert( gettime() == timenow );
        assert( test_throttle.var_13c10823fd93bc91 == 1 );
        function_1302aa73badc74f0( test_throttle );
        assert( gettime() == timenow );
        assert( test_throttle.var_13c10823fd93bc91 == 2 );
        function_1302aa73badc74f0( test_throttle );
        assert( gettime() == timenow + test_throttle.updaterate_ * 1000 );
        assert( test_throttle.var_13c10823fd93bc91 == 1 );
        function_1302aa73badc74f0( test_throttle );
        assert( gettime() == timenow + test_throttle.updaterate_ * 1000 );
        assert( test_throttle.var_13c10823fd93bc91 == 2 );
        timenow = gettime();
        function_1302aa73badc74f0( test_throttle );
        assert( gettime() == timenow + test_throttle.updaterate_ * 1000 );
        assert( test_throttle.var_13c10823fd93bc91 == 1 );
        timenow = gettime();
        assert( origtime < timenow );
        function_706ed379a3746335( test_throttle );
        assert( test_throttle.var_13c10823fd93bc91 == 0 );
        assert( gettime() != timenow + var_e6bedfc791723be4 );
        assert( gettime() == origtime + var_e6bedfc791723be4 );
        testframes = int( test_throttle.var_e064ce760682c986 / level.frameduration * test_throttle.processlimit_ ) + 1;
        
        for ( i = 0; i < testframes ; i++ )
        {
            function_1302aa73badc74f0( test_throttle );
        }
        
        timenow = gettime();
        function_706ed379a3746335( test_throttle );
        assert( gettime() == timenow + level.frameduration );
        test_print( "<dev string:x2a1>" );
    #/
}

