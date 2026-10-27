// scripts\mp\zm\zm_playerstats.gsc  (hash_529969bbb61615f4.gscc) (size: 649 Bytes / 0x289 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ac4e240 (1522852416)
// size ...... 649 (0x289)
// includes .. 3   (offset: 0x255)
// strings ... 2   (offset: 0x26d)
// dev strs .. 0   (offset: 0x289)
// exports ... 3   (offset: 0x135)
// cseg ...... 0x6f + 0xc6 (0x135)
// imports ... 6   (offset: 0x1ad)
// animtree1 . 0   (offset: 0x289)
// animtree2 . 0   (offset: 0x289)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\playerstats;

#namespace zm_playerstats;

// Namespace zm_playerstats
// Params 0
// Checksum 0xd192c6dd, Offset: 0x8d
// Size: 0x3d
function init()
{
    utility::registersharedfunc( #"player", #"hash_d89fce013242f931", &initplayer );
    
    if ( !level.var_cc0c7bf608489ed8 )
    {
        return;
    }
    
    level.zmPlayerStats = playerstats::function_3d300f501f20e5aa();
}

// Namespace zm_playerstats
// Params 0
// Checksum 0x989790a0, Offset: 0xd2
// Size: 0x63
function initplayer()
{
    if ( !level.var_cc0c7bf608489ed8 )
    {
        return;
    }
    
    if ( isdefined( self.pers[ "zmplayerstats" ] ) )
    {
        self.zmPlayerStats = self.pers[ "zmplayerstats" ];
    }
    else
    {
        self.zmPlayerStats = playerstats::function_66626e35d76bc952();
    }
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread playerstats::bufferedstatwritethink( "zm" );
    }
}

