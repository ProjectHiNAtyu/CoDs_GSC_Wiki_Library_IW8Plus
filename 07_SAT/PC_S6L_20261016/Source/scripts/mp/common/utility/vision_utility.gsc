// scripts\mp\common\utility\vision_utility.gsc  (hash_636b34758a0fb434.gscc) (size: 1434 Bytes / 0x59a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7989e712 (2039080722)
// size ...... 1434 (0x59a)
// includes .. 0   (offset: 0x572)
// strings ... 1   (offset: 0x572)
// dev strs .. 2   (offset: 0x582)
// exports ... 7   (offset: 0x3be)
// cseg ...... 0x5c + 0x362 (0x3be)
// imports ... 5   (offset: 0x4d6)
// animtree1 . 0   (offset: 0x59a)
// animtree2 . 0   (offset: 0x59a)
#namespace vision_utility;

// Namespace vision_utility
// Params 2
// Checksum 0xe0f770f7, Offset: 0x7a
// Size: 0x9b
function function_89d3efe42060754c( visionset, transitionduration )
{
    assert( isdefined( visionset ) || visionset == "<dev string:x24>", "<dev string:x25>" );
    
    if ( !isdefined( transitionduration ) )
    {
        transitionduration = 0;
    }
    
    if ( !isdefined( self.activevisionsetlist ) )
    {
        self.activevisionsetlist = [];
    }
    
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        self.activevisionsetlist[ visionset ] = 1;
    }
    else
    {
        self.activevisionsetlist[ visionset ]++;
    }
    
    if ( self.activevisionsetlist[ visionset ] == 1 )
    {
        thread function_5a9a06a6f2231968( visionset, transitionduration );
    }
}

// Namespace vision_utility
// Params 2
// Checksum 0xdc6bc511, Offset: 0x11d
// Size: 0xf3
function function_6cb9d8e0202ee81( visionset, removeduration )
{
    if ( !isdefined( self.activevisionsetlist ) )
    {
        return;
    }
    
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        return;
    }
    
    self.activevisionsetlist[ visionset ]--;
    
    if ( self.activevisionsetlist[ visionset ] == 0 )
    {
        var_8ea03e48c409079c = [];
        
        foreach ( visionindex, visionsetcount in self.activevisionsetlist )
        {
            if ( visionindex == visionset )
            {
                continue;
            }
            
            var_8ea03e48c409079c[ visionindex ] = visionsetcount;
        }
        
        self.activevisionsetlist = var_8ea03e48c409079c;
        thread function_ea4bc08a07ed926a( removeduration );
    }
}

// Namespace vision_utility
// Params 0
// Checksum 0x993ac2cd, Offset: 0x218
// Size: 0x26
function function_a2c4d6028bb5fee5()
{
    thread function_5a9a06a6f2231968( "", 0 );
    
    if ( isdefined( self.activevisionsetlist ) )
    {
        self.activevisionsetlist = undefined;
    }
}

// Namespace vision_utility
// Params 1
// Checksum 0xfdeb7fb9, Offset: 0x246
// Size: 0x34, Type: bool
function function_8c803017baaad028( visionset )
{
    if ( !isdefined( self.activevisionsetlist[ visionset ] ) )
    {
        return false;
    }
    
    if ( self.activevisionsetlist[ visionset ] > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace vision_utility
// Params 1, eflags: 0x4
// Checksum 0x56d2349, Offset: 0x283
// Size: 0xcd
function private function_ea4bc08a07ed926a( removeduration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    dur = 0;
    
    if ( isdefined( removeduration ) )
    {
        dur = removeduration;
    }
    
    thread function_5a9a06a6f2231968( "", dur );
    
    if ( dur > 0 )
    {
        wait dur;
        waitframe();
    }
    
    foreach ( visionindex, visionsetcount in self.activevisionsetlist )
    {
        thread function_5a9a06a6f2231968( visionindex, dur );
        waitframe();
    }
}

// Namespace vision_utility
// Params 2, eflags: 0x4
// Checksum 0x3518cbc, Offset: 0x358
// Size: 0x66
function private function_5a9a06a6f2231968( visionset, transitionduration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( self.var_db3ef35c4e515b9b )
    {
        waitframe();
    }
    
    self.var_db3ef35c4e515b9b = 1;
    self visionsetnakedforplayer( visionset, transitionduration );
    
    if ( transitionduration > 0 )
    {
        wait transitionduration;
    }
    
    waitframe();
    self.var_db3ef35c4e515b9b = undefined;
}

