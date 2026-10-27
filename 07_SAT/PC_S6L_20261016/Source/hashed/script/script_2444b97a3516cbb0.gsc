// script_2444b97a3516cbb0  (hash_2444b97a3516cbb0.gscc) (size: 882 Bytes / 0x372)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7fd9688 (3355285128)
// size ...... 882 (0x372)
// includes .. 0   (offset: 0x34e)
// strings ... 0   (offset: 0x34e)
// dev strs .. 3   (offset: 0x34e)
// exports ... 3   (offset: 0x22a)
// cseg ...... 0x58 + 0x1d2 (0x22a)
// imports ... 6   (offset: 0x2a2)
// animtree1 . 0   (offset: 0x372)
// animtree2 . 0   (offset: 0x372)
#namespace namespace_ddca46d216b096e2;

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x9e4b77f6, Offset: 0x76
// Size: 0x24, Type: bool
function isenabled()
{
    return isdefined( level.var_9bffc1c7425dcc18 ) && !level.var_9bffc1c7425dcc18.runtimedisabled;
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x911c67a, Offset: 0xa3
// Size: 0x187
function function_30b9db7247f23009()
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( isdefined( self.bba_id ) )
    {
        return;
    }
    
    bbaid = -1;
    var_44efc478a3d435b1 = isai( self );
    
    if ( !var_44efc478a3d435b1 )
    {
        bbaid = self getentitynumber();
    }
    else if ( isdefined( self.uibotprofile ) && isdefined( self.uibotprofile.bba_id ) )
    {
        bbaid = self.uibotprofile.bba_id;
    }
    else
    {
        level.var_9bffc1c7425dcc18.var_5ba95c7590874925 += 1;
        bbaid = level.var_9bffc1c7425dcc18.var_5ba95c7590874925;
    }
    
    /#
        for ( i = 0; i < level.players.size ; i++ )
        {
            checkplayer = level.players[ i ];
            
            if ( var_44efc478a3d435b1 && self != checkplayer && isai( checkplayer ) && isdefined( checkplayer.bba_id ) && checkplayer.bba_id == bbaid )
            {
                msg = "<dev string:x24>" + checkplayer.bba_id;
                msg += "<dev string:x3f>" + checkplayer getentitynumber();
                msg += "<dev string:x49>" + self getentitynumber();
                assertmsg( msg );
            }
        }
    #/
    
    self.bba_id = bbaid;
}

