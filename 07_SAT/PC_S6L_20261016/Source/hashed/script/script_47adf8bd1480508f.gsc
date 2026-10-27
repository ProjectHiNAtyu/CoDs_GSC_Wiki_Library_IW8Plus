// script_47adf8bd1480508f  (hash_47adf8bd1480508f.gscc) (size: 1483 Bytes / 0x5cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6330b7a7 (1664137127)
// size ...... 1483 (0x5cb)
// includes .. 1   (offset: 0x5ab)
// strings ... 0   (offset: 0x5b3)
// dev strs .. 2   (offset: 0x5b3)
// exports ... 6   (offset: 0x2ef)
// cseg ...... 0x58 + 0x297 (0x2ef)
// imports ... 16  (offset: 0x3df)
// animtree1 . 0   (offset: 0x5cb)
// animtree2 . 0   (offset: 0x5cb)
#using scripts\common\callbacks;

#namespace medal_stats;

// Namespace medal_stats
// Params 0, eflags: 0x1
// Checksum 0x7801f8c7, Offset: 0x76
// Size: 0x10
function autoexec register_init()
{
    level.var_3eb8011b836083fd = &function_aef2def8f7046473;
}

// Namespace medal_stats
// Params 0, eflags: 0x4
// Checksum 0x3c7428c0, Offset: 0x8e
// Size: 0xa1
function private function_aef2def8f7046473()
{
    if ( level.stattracking.trackmedals )
    {
        assert( isdefined( level.matchmakingmatch ) );
        var_c0dfee01127f621f = level.matchmakingmatch && !level.var_29b966035bd23252;
        
        if ( getdvarint( @"hash_23eb92996796872a", 0 ) > 0 )
        {
            var_c0dfee01127f621f = 0;
        }
        
        /#
            if ( getdvarint( @"hash_365f7748df86baf8", 0 ) > 0 )
            {
                var_c0dfee01127f621f = 1;
            }
        #/
        
        if ( var_c0dfee01127f621f )
        {
            callback::add( #"medal_earned", &handle_medal_earned );
        }
    }
    
    level.var_3eb8011b836083fd = undefined;
}

// Namespace medal_stats
// Params 1, eflags: 0x4
// Checksum 0xdab4bf46, Offset: 0x137
// Size: 0x60
function private handle_medal_earned( params )
{
    medalref = params.ref;
    var_9a28881cd69ccb5f = level.var_9a28881cd69ccb5f;
    function_d490e7e1bc366ccc( var_9a28881cd69ccb5f, medalref );
    
    if ( level.stattracking.var_6394c01057d24a26 )
    {
        function_31de867947994800( var_9a28881cd69ccb5f, medalref );
    }
}

// Namespace medal_stats
// Params 2, eflags: 0x4
// Checksum 0xb34dbace, Offset: 0x19f
// Size: 0xb2
function private function_d490e7e1bc366ccc( var_6f9b00680ed002d8, medalref )
{
    var_f3c55e9bea0be416 = level.stattracking.var_f3c55e9bea0be416;
    
    if ( !isdefined( var_f3c55e9bea0be416 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !self hasplayerdata() )
    {
        return;
    }
    
    medalcount = self getplayerdata( var_6f9b00680ed002d8, var_f3c55e9bea0be416, medalref );
    
    if ( !isdefined( medalcount ) )
    {
        return;
    }
    
    if ( medalcount == 0 )
    {
        level callback::callback( #"hash_6c71d319dc089c27", { #player:self, #event:#"hash_26b81ca74d58f961" } );
    }
    
    medalcount++;
    self setplayerdata( var_6f9b00680ed002d8, var_f3c55e9bea0be416, medalref, medalcount );
}

// Namespace medal_stats
// Params 2, eflags: 0x4
// Checksum 0xd250a465, Offset: 0x259
// Size: 0x96
function private function_31de867947994800( var_6f9b00680ed002d8, medalref )
{
    var_79f09af54cddaee3 = level.stattracking.var_4fbc851a942d911a;
    
    if ( !isdefined( var_79f09af54cddaee3 ) )
    {
        assertmsg( "<dev string:x76>" );
        return;
    }
    
    utctime = self getplayerdata( var_6f9b00680ed002d8, var_79f09af54cddaee3, medalref );
    
    if ( isstring( utctime ) )
    {
        utctime = int( utctime );
    }
    
    if ( !isdefined( utctime ) )
    {
        return;
    }
    
    utcnow = getsystemtime();
    
    if ( utcnow > utctime )
    {
        self setplayerdata( var_6f9b00680ed002d8, var_79f09af54cddaee3, medalref, utcnow );
    }
}

