// scripts\common\activity_nexus\activity_progress_tracking.gsc  (hash_0b90e9249b83faa5.gscc) (size: 2636 Bytes / 0xa4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c2d0710 (1278019344)
// size ...... 2636 (0xa4c)
// includes .. 7   (offset: 0x964)
// strings ... 0   (offset: 0x99c)
// dev strs .. 12  (offset: 0x99c)
// exports ... 11  (offset: 0x50c)
// cseg ...... 0x58 + 0x4b4 (0x50c)
// imports ... 22  (offset: 0x6c4)
// animtree1 . 0   (offset: 0xa4c)
// animtree2 . 0   (offset: 0xa4c)
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\data_tracker;
#using scripts\common\progress_tracker;
#using scripts\common\progress_tracker_common;
#using scripts\common\progress_tracker_container;

#namespace activity_progress_tracking;

// Namespace activity_progress_tracking
// Params 4
// Checksum 0x87c03a, Offset: 0x76
// Size: 0x69
function function_c3f4671492898d76( uniquename, startingprogressvalue, finalprogressvalue, customcallbackfunction )
{
    progresstracker = progress_tracker::createprogresstracker( startingprogressvalue, finalprogressvalue );
    function_e3f2755adc007851( uniquename, progresstracker, customcallbackfunction );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>" + uniquename + "<dev string:x37>", @"hash_c6dd0e44e8224971", self );
    #/
}

// Namespace activity_progress_tracking
// Params 3
// Checksum 0x456f3e31, Offset: 0xe7
// Size: 0x5f
function function_66b1dbf757fbc9cd( uniquename, endtimeinseconds, customcallbackfunction )
{
    stopwatchprogresstracker = progress_tracker_common::function_76acb76673edfa1a( endtimeinseconds );
    function_e3f2755adc007851( uniquename, stopwatchprogresstracker, customcallbackfunction );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x52>" + uniquename + "<dev string:x37>", @"hash_c6dd0e44e8224971", self );
    #/
}

// Namespace activity_progress_tracking
// Params 3
// Checksum 0x78fcf15f, Offset: 0x14e
// Size: 0x5f
function function_61568a80767f1652( uniquename, timeinseconds, customcallbackfunction )
{
    countdowntimerprogresstracker = progress_tracker_common::function_c817339e497404af( timeinseconds );
    function_e3f2755adc007851( uniquename, countdowntimerprogresstracker, customcallbackfunction );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x6f>" + uniquename + "<dev string:x37>", @"hash_c6dd0e44e8224971", self );
    #/
}

// Namespace activity_progress_tracking
// Params 3
// Checksum 0xa9cb5f85, Offset: 0x1b5
// Size: 0x5f
function function_82d854bb84c20512( uniquename, var_c8cb9ed020b00fdb, customcallbackfunction )
{
    killprogresstracker = progress_tracker_common::function_12361b4f025c54ff( var_c8cb9ed020b00fdb );
    function_e3f2755adc007851( uniquename, killprogresstracker, customcallbackfunction );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x8c>" + uniquename + "<dev string:x37>", @"hash_c6dd0e44e8224971", self );
    #/
}

// Namespace activity_progress_tracking
// Params 0
// Checksum 0x27c89f4e, Offset: 0x21c
// Size: 0x84
function function_a349dbc284b26b2f()
{
    if ( progress_tracker_container::function_ab32c21fadcfccfa() )
    {
        foreach ( progresstracker in self.progresstrackers )
        {
            function_c971d772f519346d( progresstracker );
        }
    }
}

// Namespace activity_progress_tracking
// Params 1
// Checksum 0xd8f930d1, Offset: 0x2a8
// Size: 0x46
function function_3ff7386bdfd71aca( uniquename )
{
    progresstracker = self.progresstrackers[ uniquename ];
    assert( isdefined( progresstracker ), "<dev string:xa4>" + uniquename + "<dev string:xb3>" );
    function_c971d772f519346d( progresstracker );
}

// Namespace activity_progress_tracking
// Params 2
// Checksum 0xa511ff4b, Offset: 0x2f6
// Size: 0xbd
function function_610c09b20092b8bf( uniquename, pausetimer )
{
    progresstracker = self.progresstrackers[ uniquename ];
    assert( isdefined( progresstracker ), "<dev string:xee>" + uniquename + "<dev string:xb3>" );
    assert( isdefined( progresstracker.paused ), "<dev string:xee>" + uniquename + "<dev string:xff>" );
    
    if ( pausetimer && !progresstracker.paused )
    {
        progresstracker.paused = 1;
        return;
    }
    
    if ( !pausetimer && progresstracker.paused )
    {
        progresstracker.paused = 0;
        progresstracker notify( #"resume" );
    }
}

// Namespace activity_progress_tracking
// Params 3, eflags: 0x4
// Checksum 0x14634217, Offset: 0x3bb
// Size: 0x5d
function private function_e3f2755adc007851( uniquename, progresstracker, customcallbackfunction )
{
    progresstracker progress_tracker::addcallback( self, &function_b80fd8e164d30554 );
    
    if ( isdefined( customcallbackfunction ) )
    {
        progresstracker progress_tracker::addcallback( self, customcallbackfunction );
    }
    
    progress_tracker_container::addprogresstracker( uniquename, progresstracker );
    data_tracker::adddataprogresstracker( uniquename, progresstracker );
    activity_instance_common::function_5e2f9c673ccd965f( self, uniquename );
}

// Namespace activity_progress_tracking
// Params 1, eflags: 0x4
// Checksum 0x7ea1fbc3, Offset: 0x420
// Size: 0x7e
function private function_b80fd8e164d30554( progresstracker )
{
    uniquename = progresstracker progress_tracker::getuniquename();
    data_tracker::function_d2b6731449926c27( uniquename );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>" + uniquename + "<dev string:x137>" + progresstracker progress_tracker::function_c0a249a1971ef0c5(), @"hash_c6dd0e44e8224971", self );
        
        if ( progresstracker progress_tracker::iscomplete() )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>" + uniquename + "<dev string:x168>", @"hash_c6dd0e44e8224971", self );
        }
    #/
}

// Namespace activity_progress_tracking
// Params 1, eflags: 0x4
// Checksum 0x9665c645, Offset: 0x4a6
// Size: 0x66
function private function_c971d772f519346d( progresstracker )
{
    uniquename = progresstracker progress_tracker::getuniquename();
    data_tracker::removedata( uniquename );
    activity_player_broadcasting::function_14b649cbfe7ea3c4( uniquename, self.playerparticipants );
    progress_tracker_container::endprogresstracker( uniquename );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>" + uniquename + "<dev string:x176>", @"hash_c6dd0e44e8224971", self );
    #/
}

