// script_50af2b503af93bd3  (hash_50af2b503af93bd3.gscc) (size: 751 Bytes / 0x2ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47aa0d07 (1202326791)
// size ...... 751 (0x2ef)
// includes .. 3   (offset: 0x2d7)
// strings ... 0   (offset: 0x2ef)
// dev strs .. 0   (offset: 0x2ef)
// exports ... 4   (offset: 0x1a3)
// cseg ...... 0x58 + 0x14b (0x1a3)
// imports ... 5   (offset: 0x243)
// animtree1 . 0   (offset: 0x2ef)
// animtree2 . 0   (offset: 0x2ef)
#using script_26ccbfe3954cacf4;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\gamelogic;

#namespace namespace_2558014eb7af24fb;

// Namespace namespace_2558014eb7af24fb
// Params 1
// Checksum 0xe51503e8, Offset: 0x76
// Size: 0x34
function function_54405d0334fe0dc1( taskid )
{
    if ( !self.var_e2512b84b839d80f && !gamelogic_mp::inprematch() )
    {
        thread bots_gametype_br_super::function_2a2373e4cc4e8da0();
    }
    
    return anim.success;
}

// Namespace namespace_2558014eb7af24fb
// Params 1
// Checksum 0x68c92119, Offset: 0xb3
// Size: 0x1c
function tryrecycle( taskid )
{
    thread function_91fa8d1378b56350();
    return anim.success;
}

// Namespace namespace_2558014eb7af24fb
// Params 0, eflags: 0x4
// Checksum 0x138cc94c, Offset: 0xd8
// Size: 0xcb
function private function_91fa8d1378b56350()
{
    self endon( #"bot_suspended" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    waitframe();
    isprematch = gamelogic_mp::inprematch();
    stuck = self._blackboard.parachutingstuck;
    
    if ( !isprematch && !self.infil_complete )
    {
        self._blackboard.desiredzoneindex = -1;
        self.infil_complete = 1;
        recycletype = stuck ? 3 : 0;
        
        if ( manager::tryrecycle( recycletype ) )
        {
            return;
        }
    }
    
    if ( stuck )
    {
        while ( self isskydiving() )
        {
            if ( manager::tryrecycle( 3 ) )
            {
                return;
            }
            
            wait 1;
        }
    }
}

