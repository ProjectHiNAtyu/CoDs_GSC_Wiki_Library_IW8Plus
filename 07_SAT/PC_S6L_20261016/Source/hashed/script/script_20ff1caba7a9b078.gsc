// script_20ff1caba7a9b078  (hash_20ff1caba7a9b078.gscc) (size: 468 Bytes / 0x1d4)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0a352cf (3768799951)
// size ...... 468 (0x1d4)
// includes .. 0   (offset: 0x1bc)
// strings ... 2   (offset: 0x1bc)
// dev strs .. 0   (offset: 0x1d4)
// exports ... 2   (offset: 0x130)
// cseg ...... 0x76 + 0xba (0x130)
// imports ... 2   (offset: 0x180)
// animtree1 . 0   (offset: 0x1d4)
// animtree2 . 0   (offset: 0x1d4)
#namespace namespace_71a06ce99f08ed83;

// Namespace namespace_71a06ce99f08ed83
// Params 3
// Checksum 0x5c96f8d7, Offset: 0x94
// Size: 0x9c
function function_a329e534646f2e1f( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_idle" );
    
    while ( true )
    {
        var_7d83f520111c08a5 = isdefined( self._blackboard ) && self._blackboard.var_79b2d8d61c6ef8b1;
        
        if ( !var_7d83f520111c08a5 && isalive( self.enemy ) )
        {
            self orientmode( "face enemy" );
        }
        else
        {
            self orientmode( "face current" );
        }
        
        waitframe();
    }
}

