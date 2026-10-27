// scripts\common\progress_tracker_common.gsc  (hash_7f9409b703dad400.gscc) (size: 1152 Bytes / 0x480 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe60017cf (3858765775)
// size ...... 1152 (0x480)
// includes .. 1   (offset: 0x478)
// strings ... 0   (offset: 0x480)
// dev strs .. 0   (offset: 0x480)
// exports ... 6   (offset: 0x28c)
// cseg ...... 0x58 + 0x234 (0x28c)
// imports ... 8   (offset: 0x37c)
// animtree1 . 0   (offset: 0x480)
// animtree2 . 0   (offset: 0x480)
#using scripts\common\progress_tracker;

#namespace progress_tracker_common;

// Namespace progress_tracker_common
// Params 2
// Checksum 0x1719465a, Offset: 0x76
// Size: 0x51
function function_76acb76673edfa1a( endtimeinseconds, var_96ac7f545e743ad6 )
{
    stopwatchprogresstracker = progress_tracker::createprogresstracker( 0, endtimeinseconds );
    
    if ( !isdefined( var_96ac7f545e743ad6 ) )
    {
        var_96ac7f545e743ad6 = 0.25;
    }
    
    stopwatchprogresstracker.paused = 0;
    stopwatchprogresstracker thread function_6389003d3fd3a677( 0, var_96ac7f545e743ad6 );
    return stopwatchprogresstracker;
}

// Namespace progress_tracker_common
// Params 2
// Checksum 0x1ac83cf5, Offset: 0xd0
// Size: 0x52
function function_c817339e497404af( timeinseconds, var_96ac7f545e743ad6 )
{
    countdowntimerprogresstracker = progress_tracker::createprogresstracker( timeinseconds, 0 );
    
    if ( !isdefined( var_96ac7f545e743ad6 ) )
    {
        var_96ac7f545e743ad6 = 0.25;
    }
    
    countdowntimerprogresstracker.paused = 0;
    countdowntimerprogresstracker thread function_6389003d3fd3a677( 1, var_96ac7f545e743ad6 );
    return countdowntimerprogresstracker;
}

// Namespace progress_tracker_common
// Params 2
// Checksum 0xb89f39bc, Offset: 0x12b
// Size: 0x44
function function_12361b4f025c54ff( var_c8cb9ed020b00fdb, var_96ac7f545e743ad6 )
{
    killprogresstracker = progress_tracker::createprogresstracker( 0, var_c8cb9ed020b00fdb.size );
    
    if ( !isdefined( var_96ac7f545e743ad6 ) )
    {
        var_96ac7f545e743ad6 = 0.5;
    }
    
    killprogresstracker thread function_93bc422f4248b8de( var_c8cb9ed020b00fdb, var_96ac7f545e743ad6 );
    return killprogresstracker;
}

// Namespace progress_tracker_common
// Params 2
// Checksum 0xd4841a6a, Offset: 0x178
// Size: 0x9e
function function_6389003d3fd3a677( shoulddecrement, var_96ac7f545e743ad6 )
{
    self endon( #"hash_308138f33e37837e" );
    var_8682d885f65314ac = gettime();
    
    while ( !progress_tracker::iscomplete() )
    {
        var_38ab1a8ecfb1cfbd = gettime();
        timepassedinseconds = ( var_38ab1a8ecfb1cfbd - var_8682d885f65314ac ) / 1000;
        var_8682d885f65314ac = var_38ab1a8ecfb1cfbd;
        
        if ( shoulddecrement )
        {
            progress_tracker::decrementcurrentprogress( timepassedinseconds );
        }
        else
        {
            progress_tracker::incrementcurrentprogress( timepassedinseconds );
        }
        
        if ( self.paused )
        {
            self waittill( #"resume" );
            var_8682d885f65314ac = gettime();
        }
        
        wait var_96ac7f545e743ad6;
    }
}

// Namespace progress_tracker_common
// Params 2
// Checksum 0xef469f13, Offset: 0x21e
// Size: 0x6e
function function_93bc422f4248b8de( var_c8cb9ed020b00fdb, var_96ac7f545e743ad6 )
{
    self endon( #"hash_308138f33e37837e" );
    enemiesremaining = var_c8cb9ed020b00fdb.size;
    
    while ( !progress_tracker::iscomplete() )
    {
        var_c8cb9ed020b00fdb = function_46f9072493651dc9( var_c8cb9ed020b00fdb );
        
        if ( var_c8cb9ed020b00fdb.size < enemiesremaining )
        {
            recentkills = enemiesremaining - var_c8cb9ed020b00fdb.size;
            progress_tracker::incrementcurrentprogress( recentkills );
            enemiesremaining = var_c8cb9ed020b00fdb.size;
        }
        
        wait var_96ac7f545e743ad6;
    }
}

