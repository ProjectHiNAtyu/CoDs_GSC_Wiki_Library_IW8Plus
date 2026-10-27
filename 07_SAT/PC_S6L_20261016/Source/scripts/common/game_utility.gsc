// scripts\common\game_utility.gsc  (hash_73fd23444e07e6af.gscc) (size: 1452 Bytes / 0x5ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6070187b (1617959035)
// size ...... 1452 (0x5ac)
// includes .. 0   (offset: 0x5a0)
// strings ... 0   (offset: 0x5a0)
// dev strs .. 1   (offset: 0x5a0)
// exports ... 9   (offset: 0x298)
// cseg ...... 0x58 + 0x240 (0x298)
// imports ... 14  (offset: 0x400)
// animtree1 . 0   (offset: 0x5ac)
// animtree2 . 0   (offset: 0x5ac)
#namespace game_utility_common;

// Namespace game_utility_common
// Params 1
// Checksum 0x41ebafba, Offset: 0x76
// Size: 0x40, Type: bool
function isaigameparticipant( ent )
{
    if ( isagent( ent ) && ent.agent_gameparticipant )
    {
        return true;
    }
    
    if ( isbot( ent ) )
    {
        return true;
    }
    
    if ( isautopilot( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_common
// Params 1
// Checksum 0x9a747edf, Offset: 0xbf
// Size: 0x43, Type: bool
function isgameparticipant( ent )
{
    if ( isplayer( ent ) )
    {
        return true;
    }
    
    if ( isaigameparticipant( ent ) )
    {
        return true;
    }
    
    if ( isvector( ent ) )
    {
        return false;
    }
    
    if ( ent.forcegameparticipant )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_common
// Params 1
// Checksum 0x460583f0, Offset: 0x10b
// Size: 0x37, Type: bool
function isaiteamparticipant( ent )
{
    if ( isagent( ent ) && ent.agent_teamparticipant == 1 )
    {
        return true;
    }
    
    if ( isbot( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_common
// Params 1
// Checksum 0xabebfcd0, Offset: 0x14b
// Size: 0x27, Type: bool
function isteamparticipant( ent )
{
    if ( isaiteamparticipant( ent ) )
    {
        return true;
    }
    
    if ( isplayer( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_common
// Params 0
// Checksum 0xd5c66a6e, Offset: 0x17b
// Size: 0x27
function addtoparticipantsarray()
{
    assert( isgameparticipant( self ) );
    level.participants[ level.participants.size ] = self;
}

// Namespace game_utility_common
// Params 0
// Checksum 0x2f7d0b9f, Offset: 0x1aa
// Size: 0x9b
function removefromparticipantsarray()
{
    for ( entry = 0; entry < level.participants.size ; entry++ )
    {
        if ( level.participants[ entry ] == self )
        {
            while ( entry < level.participants.size - 1 )
            {
                level.participants[ entry ] = level.participants[ entry + 1 ];
                assert( level.participants[ entry ] != self );
                entry++;
            }
            
            level.participants[ entry ] = undefined;
            return;
        }
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace game_utility_common
// Params 0
// Checksum 0xb6265754, Offset: 0x24d
// Size: 0x32
function addtocharactersarray()
{
    assert( isplayer( self ) || isbot( self ) || isagent( self ) );
    level.characters[ self getentitynumber() ] = self;
}

// Namespace game_utility_common
// Params 0
// Checksum 0x9c040b36, Offset: 0x287
// Size: 0x11
function removefromcharactersarray()
{
    level.characters[ self getentitynumber() ] = undefined;
}

