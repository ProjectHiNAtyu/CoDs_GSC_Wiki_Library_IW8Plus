// scripts\common\active_env\diving_board.gsc  (hash_64391e1d558430ed.gscc) (size: 907 Bytes / 0x38b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74ed6464 (1961714788)
// size ...... 907 (0x38b)
// includes .. 1   (offset: 0x35f)
// strings ... 3   (offset: 0x367)
// dev strs .. 0   (offset: 0x38b)
// exports ... 4   (offset: 0x1bf)
// cseg ...... 0x88 + 0x137 (0x1bf)
// imports ... 9   (offset: 0x25f)
// animtree1 . 0   (offset: 0x38b)
// animtree2 . 0   (offset: 0x38b)
#using scripts\mp\common\utility\trigger;

#namespace diving_board;

// Namespace diving_board
// Params 0
// Checksum 0xcc93ebb9, Offset: 0xa6
// Size: 0x22
function diving_board()
{
    self.var_8abdc31b7aa24442 = 1.1;
    trigger::makeenterexittrigger( self, &diving_board_enter, &diving_board_exit );
}

// Namespace diving_board
// Params 2, eflags: 0x4
// Checksum 0xcc2687fe, Offset: 0xd0
// Size: 0xbc
function private diving_board_enter( e_player, trigger )
{
    if ( isplayer( e_player ) && isalive( e_player ) )
    {
        e_player endon( #"diving_board_exited" );
        e_player = e_player;
        e_player notifyonplayercommand( "jump_pressed", "+gostand" );
        e_player waittill( #"jump_pressed" );
        v_up = ( 0, 0, 1 );
        n_last_vel = e_player getvelocity();
        n_new_vel = n_last_vel + n_last_vel * v_up * trigger.var_8abdc31b7aa24442;
        e_player setvelocity( n_new_vel );
        
        if ( level.var_72b8953c48ac73ee )
        {
            self playsound( "emt_diving_board" );
        }
    }
}

// Namespace diving_board
// Params 2, eflags: 0x4
// Checksum 0x880aed21, Offset: 0x194
// Size: 0x2b
function private diving_board_exit( e_player, trigger )
{
    if ( isplayer( e_player ) )
    {
        e_player notify( #"diving_board_exited" );
    }
}

