// scripts\common\progress_tracker.gsc  (hash_0347e655acacdace.gscc) (size: 2502 Bytes / 0x9c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e577976 (2656532854)
// size ...... 2502 (0x9c6)
// includes .. 0   (offset: 0x98a)
// strings ... 0   (offset: 0x98a)
// dev strs .. 5   (offset: 0x98a)
// exports ... 15  (offset: 0x582)
// cseg ...... 0x58 + 0x52a (0x582)
// imports ... 14  (offset: 0x7da)
// animtree1 . 0   (offset: 0x9c6)
// animtree2 . 0   (offset: 0x9c6)
#namespace progress_tracker;

// Namespace progress_tracker
// Params 2
// Checksum 0x282129a9, Offset: 0x76
// Size: 0x82
function createprogresstracker( startingprogressvalue, finalprogressvalue )
{
    progresstracker = spawnstruct();
    progresstracker.progresscomplete = 0;
    progresstracker.callbacks = [];
    progresstracker.startingprogressvalue = startingprogressvalue;
    progresstracker.currentprogressvalue = startingprogressvalue;
    progresstracker.finalprogressvalue = finalprogressvalue;
    
    /#
        if ( startingprogressvalue == finalprogressvalue )
        {
            assertmsg( "<dev string:x24>" );
        }
    #/
    
    return progresstracker;
}

// Namespace progress_tracker
// Params 0
// Checksum 0x89077f2f, Offset: 0x101
// Size: 0x30
function function_c0a249a1971ef0c5()
{
    assert( isdefined( self.finalprogressvalue ), "<dev string:x91>" );
    return abs( self.finalprogressvalue - self.currentprogressvalue );
}

// Namespace progress_tracker
// Params 1
// Checksum 0xa80aa54c, Offset: 0x13a
// Size: 0x17
function setuniquename( uniquename )
{
    self.uniquename = uniquename;
}

// Namespace progress_tracker
// Params 0
// Checksum 0x9222ac75, Offset: 0x159
// Size: 0x3c
function getuniquename()
{
    /#
        if ( !isdefined( self.uniquename ) || self.uniquename == "<dev string:xd5>" )
        {
            assertmsg( "<dev string:xd6>" );
        }
    #/
    
    return self.uniquename;
}

// Namespace progress_tracker
// Params 0
// Checksum 0x59c00ffd, Offset: 0x19e
// Size: 0xb
function iscomplete()
{
    return self.progresscomplete;
}

// Namespace progress_tracker
// Params 0
// Checksum 0xa54e4571, Offset: 0x1b2
// Size: 0x32
function function_b656fe7ed168cff4()
{
    self.currentprogressvalue = self.finalprogressvalue;
    self.progresscomplete = 1;
    function_dd6634b62e39600d();
    self notify( #"hash_308138f33e37837e" );
}

// Namespace progress_tracker
// Params 2
// Checksum 0x1aecc471, Offset: 0x1ec
// Size: 0x58
function addcallback( callonobject, callbackfunction )
{
    newcallback = spawnstruct();
    newcallback.callon = callonobject;
    newcallback.callbackfunction = callbackfunction;
    self.callbacks[ self.callbacks.size ] = newcallback;
}

// Namespace progress_tracker
// Params 0
// Checksum 0x8f4d3755, Offset: 0x24c
// Size: 0xc3
function function_dd6634b62e39600d()
{
    var_5b82bcd1544b4d2a = 0;
    
    foreach ( callback in self.callbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon ?? level [[ callback.callbackfunction ]]( self );
            continue;
        }
        
        var_5b82bcd1544b4d2a = 1;
    }
    
    if ( var_5b82bcd1544b4d2a )
    {
        self.callbacks = function_5713d46873b29625( self.callbacks );
    }
}

// Namespace progress_tracker
// Params 1
// Checksum 0x8a23f971, Offset: 0x317
// Size: 0x40
function incrementcurrentprogress( incrementvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    if ( !isdefined( incrementvalue ) )
    {
        incrementvalue = 1;
    }
    
    incrementedprogress = self.currentprogressvalue + incrementvalue;
    function_cd85b94fa55140de( incrementedprogress );
}

// Namespace progress_tracker
// Params 1
// Checksum 0xbf712d33, Offset: 0x35f
// Size: 0x49
function decrementcurrentprogress( decrementvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    if ( !isdefined( decrementvalue ) )
    {
        decrementvalue = 1;
    }
    
    decrementedprogress = self.currentprogressvalue - decrementvalue;
    decrementedprogress = max( decrementedprogress, 0 );
    function_cd85b94fa55140de( decrementedprogress );
}

// Namespace progress_tracker
// Params 1
// Checksum 0x87199357, Offset: 0x3b0
// Size: 0x44
function setcurrentprogress( progressvalue )
{
    if ( progressvalue < self.currentprogressvalue )
    {
        decrementcurrentprogress( self.currentprogressvalue - progressvalue );
        return;
    }
    
    incrementcurrentprogress( progressvalue - self.currentprogressvalue );
}

// Namespace progress_tracker
// Params 1
// Checksum 0xefbde94b, Offset: 0x3fc
// Size: 0x41
function setfinalvalue( finalvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    assert( isdefined( finalvalue ), "<dev string:x10e>" );
    self.finalprogressvalue = finalvalue;
    function_cd85b94fa55140de( self.currentprogressvalue );
}

// Namespace progress_tracker
// Params 1, eflags: 0x4
// Checksum 0xe2ac0ff5, Offset: 0x445
// Size: 0x50
function private function_cd85b94fa55140de( newprogressvalue )
{
    self.progresscomplete = function_5f2dda1392947f9d( newprogressvalue );
    
    if ( self.progresscomplete )
    {
        self.currentprogressvalue = self.finalprogressvalue;
    }
    else
    {
        self.currentprogressvalue = newprogressvalue;
    }
    
    function_dd6634b62e39600d();
}

// Namespace progress_tracker
// Params 1, eflags: 0x4
// Checksum 0x9ef0f58e, Offset: 0x49d
// Size: 0xe4, Type: bool
function private function_5f2dda1392947f9d( newprogressvalue )
{
    if ( !isdefined( self.finalprogressvalue ) )
    {
        return false;
    }
    
    var_4d57de1d255cf62b = self.startingprogressvalue < self.finalprogressvalue && newprogressvalue >= self.finalprogressvalue;
    var_57bbd27d8a3d5857 = self.startingprogressvalue > self.finalprogressvalue && newprogressvalue <= self.finalprogressvalue;
    var_8784c4e767af6071 = self.startingprogressvalue == self.finalprogressvalue || iscomplete();
    var_59f26251e5cc7e24 = isfloat( newprogressvalue ) && abs( newprogressvalue - self.finalprogressvalue ) <= 0.25;
    
    if ( var_4d57de1d255cf62b || var_57bbd27d8a3d5857 || var_8784c4e767af6071 || var_59f26251e5cc7e24 )
    {
        return true;
    }
    
    return false;
}

