// scripts\mp\dmz\threat_list.gsc  (hash_28ec4a654f5c2d11.gscc) (size: 3202 Bytes / 0xc82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9457bb2d (2488777517)
// size ...... 3202 (0xc82)
// includes .. 1   (offset: 0xc6e)
// strings ... 0   (offset: 0xc76)
// dev strs .. 1   (offset: 0xc76)
// exports ... 7   (offset: 0xa2e)
// cseg ...... 0x58 + 0x9d6 (0xa2e)
// imports ... 10  (offset: 0xb46)
// animtree1 . 0   (offset: 0xc82)
// animtree2 . 0   (offset: 0xc82)
#using scripts\common\utility;

#namespace threat_list;

// Namespace threat_list
// Params 0
// Checksum 0xff781bd2, Offset: 0x76
// Size: 0x38
function function_f93f570e9f229858()
{
    assert( !isdefined( self.threatlist ), "<dev string:x24>" );
    self.threatlist = [];
    self.var_914f224900f864e8 = undefined;
    self.var_dffce5f0eeb96ff0 = undefined;
}

// Namespace threat_list
// Params 2
// Checksum 0x955f0a37, Offset: 0xb6
// Size: 0xec
function function_9df30f252e7d31e9( reqfunc, num )
{
    players = [];
    
    if ( !isdefined( num ) )
    {
        num = 1;
    }
    
    foreach ( threatentry in self.threatlist )
    {
        if ( self [[ reqfunc ]]( threatentry.player ) )
        {
            players[ players.size ] = threatentry.player;
            
            if ( players.size >= num )
            {
                break;
            }
        }
    }
    
    if ( num == 1 && players.size > 0 )
    {
        return players[ 0 ];
    }
    
    return players.size == 0 ? undefined : players;
}

// Namespace threat_list
// Params 3
// Checksum 0xdecc0d3f, Offset: 0x1ab
// Size: 0x50a
function addthreat( player, value, ignoredist )
{
    if ( !( isdefined( player ) && isdefined( player.guid ) ) )
    {
        return;
    }
    
    if ( !isdefined( self.threatlist[ player.guid ] ) )
    {
        self.threatlist[ player.guid ] = spawnstruct();
        self.threatlist[ player.guid ].player = player;
        self.threatlist[ player.guid ].threat = 0;
        self.threatlist[ player.guid ].ignoredist = 0;
    }
    
    if ( self.threatlist[ player.guid ].player != player )
    {
        self.threatlist[ player.guid ].player = player;
    }
    
    if ( ignoredist )
    {
        self.threatlist[ player.guid ].ignoredist = ignoredist;
    }
    
    if ( !( isdefined( self.var_914f224900f864e8 ) && isdefined( self.var_dffce5f0eeb96ff0 ) ) )
    {
        self.var_914f224900f864e8 = player.guid;
        self.var_dffce5f0eeb96ff0 = player.guid;
    }
    else if ( !isdefined( self.threatlist[ player.guid ].up ) && !isdefined( self.threatlist[ player.guid ].down ) && self.var_dffce5f0eeb96ff0 != player.guid )
    {
        self.threatlist[ self.var_914f224900f864e8 ].down = player.guid;
        self.threatlist[ player.guid ].up = self.var_914f224900f864e8;
        self.var_914f224900f864e8 = player.guid;
    }
    
    self.threatlist[ player.guid ].threat += value;
    
    if ( value > 0 )
    {
        if ( self.var_dffce5f0eeb96ff0 == player.guid )
        {
            return;
        }
        
        checkid = self.threatlist[ player.guid ].up;
        checkedids = [];
        
        while ( self.threatlist[ checkid ].threat < self.threatlist[ player.guid ].threat )
        {
            if ( arraycontains( checkedids, checkid ) )
            {
                self.threatlist = [];
                self.var_dffce5f0eeb96ff0 = undefined;
                self.var_914f224900f864e8 = undefined;
                return;
            }
            
            checkedids[ checkedids.size ] = checkid;
            checkid = self.threatlist[ checkid ].up;
        }
        
        if ( checkid != self.threatlist[ player.guid ].up )
        {
            function_a53ad3f1b4769ef7( player.guid );
            function_a066b6bd6c379f96( player.guid, checkid );
        }
        
        return;
    }
    
    if ( self.threatlist[ player.guid ].threat <= 0 )
    {
        function_a53ad3f1b4769ef7( player.guid );
        return;
    }
    
    if ( self.var_914f224900f864e8 == player.guid )
    {
        return;
    }
    
    checkid = self.threatlist[ player.guid ].down;
    checkedids = [];
    
    while ( self.threatlist[ checkid ].threat > self.threatlist[ player.guid ].threat )
    {
        if ( arraycontains( checkedids, checkid ) )
        {
            self.threatlist = [];
            self.var_dffce5f0eeb96ff0 = undefined;
            self.var_914f224900f864e8 = undefined;
            return;
        }
        
        checkedids[ checkedids.size ] = checkid;
        checkid = self.threatlist[ checkid ].down;
    }
    
    if ( checkid != self.threatlist[ player.guid ].down )
    {
        function_a53ad3f1b4769ef7( player.guid );
        function_a066b6bd6c379f96( player.guid, self.threatlist[ checkid ].up );
    }
}

// Namespace threat_list
// Params 1, eflags: 0x4
// Checksum 0x834bc5f, Offset: 0x6bd
// Size: 0x16a
function private function_a53ad3f1b4769ef7( guid )
{
    if ( self.var_dffce5f0eeb96ff0 == guid && self.var_914f224900f864e8 == guid )
    {
        self.var_dffce5f0eeb96ff0 = undefined;
        self.var_914f224900f864e8 = undefined;
        return;
    }
    
    if ( isdefined( self.threatlist[ guid ].down ) )
    {
        if ( !isdefined( self.threatlist[ guid ].up ) )
        {
            self.var_dffce5f0eeb96ff0 = self.threatlist[ guid ].down;
        }
        
        self.threatlist[ self.threatlist[ guid ].down ].up = self.threatlist[ guid ].up;
    }
    
    if ( isdefined( self.threatlist[ guid ].up ) )
    {
        if ( !isdefined( self.threatlist[ guid ].down ) )
        {
            self.var_914f224900f864e8 = self.threatlist[ guid ].up;
        }
        
        self.threatlist[ self.threatlist[ guid ].up ].down = self.threatlist[ guid ].down;
    }
}

// Namespace threat_list
// Params 2, eflags: 0x4
// Checksum 0x9013b548, Offset: 0x82f
// Size: 0x149
function private function_a066b6bd6c379f96( guid, guidbefore )
{
    if ( !isdefined( guidbefore ) )
    {
        self.threatlist[ self.var_dffce5f0eeb96ff0 ].up = guid;
        self.threatlist[ guid ].down = self.var_dffce5f0eeb96ff0;
        self.threatlist[ guid ].up = undefined;
        self.var_dffce5f0eeb96ff0 = guid;
        return;
    }
    
    if ( isdefined( self.threatlist[ guidbefore ].down ) )
    {
        self.threatlist[ self.threatlist[ guidbefore ].down ].up = guid;
    }
    
    self.threatlist[ guid ].down = self.threatlist[ guidbefore ].down;
    self.threatlist[ guidbefore ].down = guid;
    self.threatlist[ guid ].up = guidbefore;
    
    if ( !isdefined( self.threatlist[ guid ].down ) )
    {
        self.var_914f224900f864e8 = guid;
    }
}

/#

    // Namespace threat_list
    // Params 0
    // Checksum 0x27071b5b, Offset: 0x980
    // Size: 0xae, Type: dev
    function threattest()
    {
        while ( true )
        {
            foreach ( agent in level.agentarray )
            {
                if ( !isdefined( agent.guid ) )
                {
                    continue;
                }
                
                if ( utility::percent_chance( 50 ) )
                {
                    addthreat( agent, randomint( 400 ) );
                }
            }
            
            wait 1;
        }
    }

#/
