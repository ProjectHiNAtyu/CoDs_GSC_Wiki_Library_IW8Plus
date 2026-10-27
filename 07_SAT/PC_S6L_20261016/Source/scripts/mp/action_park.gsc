// scripts\mp\action_park.gsc  (hash_05e9e5723e1c7cff.gscc) (size: 561 Bytes / 0x231 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97e82a45 (2548574789)
// size ...... 561 (0x231)
// includes .. 2   (offset: 0x209)
// strings ... 2   (offset: 0x219)
// dev strs .. 0   (offset: 0x231)
// exports ... 3   (offset: 0x121)
// cseg ...... 0x83 + 0x9e (0x121)
// imports ... 4   (offset: 0x199)
// animtree1 . 0   (offset: 0x231)
// animtree2 . 0   (offset: 0x231)
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game_utility;

#namespace action_park;

// Namespace action_park
// Params 0
// Checksum 0xfb1cae51, Offset: 0xa1
// Size: 0x56
function initialize()
{
    game_type = game_utility::getgametype();
    
    switch ( game_type )
    {
        case #"hash_5ff8e011d5b9d1c8":
            level.var_e4b03a4f3e97879c = &function_509cb2a3b9b8407d;
            break;
        default:
            break;
    }
    
    setomnvar( "ui_action_park", 1 );
}

// Namespace action_park
// Params 0, eflags: 0x4
// Checksum 0xcd0f4676, Offset: 0xff
// Size: 0x21, Type: bool
function private function_509cb2a3b9b8407d()
{
    if ( !( game[ "roundsPlayed" ] > 0 ) )
    {
        dialog::leaderdialogonplayer( #"boost_actionpark" );
    }
    
    return true;
}

