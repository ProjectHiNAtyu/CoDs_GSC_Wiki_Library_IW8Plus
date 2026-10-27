// scripts\mp\ftue\utility\ftue_firing.gsc  (hash_089c4e8e66e8a360.gscc) (size: 582 Bytes / 0x246 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad2b93c9 (2905314249)
// size ...... 582 (0x246)
// includes .. 1   (offset: 0x23e)
// strings ... 0   (offset: 0x246)
// dev strs .. 0   (offset: 0x246)
// exports ... 3   (offset: 0x18e)
// cseg ...... 0x58 + 0x136 (0x18e)
// imports ... 2   (offset: 0x206)
// animtree1 . 0   (offset: 0x246)
// animtree2 . 0   (offset: 0x246)
#using scripts\mp\common\utility\player;

#namespace ftue_firing;

// Namespace ftue_firing
// Params 3
// Checksum 0x75d50440, Offset: 0x76
// Size: 0x29
function function_dc79f33e8ed5962e( player, checkads, ondamagedcallback )
{
    thread function_f37fbea0ec6248f2( player, checkads, ondamagedcallback );
}

// Namespace ftue_firing
// Params 3, eflags: 0x4
// Checksum 0x4da25b20, Offset: 0xa7
// Size: 0xe7
function private function_f37fbea0ec6248f2( player, checkads, ondamagedcallback )
{
    self endon( #"entitydeleted" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( ( !checkads || player player::isplayerads() ) && attacker == player )
        {
            if ( isdefined( ondamagedcallback ) )
            {
                self [[ ondamagedcallback ]]( player );
            }
            
            return;
        }
    }
}

