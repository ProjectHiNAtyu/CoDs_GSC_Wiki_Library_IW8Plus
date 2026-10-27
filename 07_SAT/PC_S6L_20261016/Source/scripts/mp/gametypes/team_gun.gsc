// scripts\mp\gametypes\team_gun.gsc  (hash_65df1ea6c7e0b8ce.gscc) (size: 634 Bytes / 0x27a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba3d50c9 (3124580553)
// size ...... 634 (0x27a)
// includes .. 1   (offset: 0x25a)
// strings ... 2   (offset: 0x262)
// dev strs .. 0   (offset: 0x27a)
// exports ... 4   (offset: 0x166)
// cseg ...... 0x6c + 0xfa (0x166)
// imports ... 3   (offset: 0x206)
// animtree1 . 0   (offset: 0x27a)
// animtree2 . 0   (offset: 0x27a)
#using scripts\mp\common\utility\game_utility;

#namespace team_gun;

// Namespace team_gun
// Params 0
// Checksum 0x9e02050f, Offset: 0x8a
// Size: 0xe, Type: bool
function function_ab3051539fb113f1()
{
    return game_utility::getgametype() == "team_gun";
}

// Namespace team_gun
// Params 0
// Checksum 0xc866d7f0, Offset: 0xa1
// Size: 0x91
function function_7f7964a1bdd7adc5()
{
    player = self;
    
    if ( isbot( player ) )
    {
        team = player.bot_team;
    }
    else
    {
        team = player.pers[ "team" ];
    }
    
    player.gungamegunindex = function_db57c6d06e6168e( team );
    
    if ( player.gungamegunindex == 0 )
    {
        player.gungameprevgunindex = 0;
        return;
    }
    
    player.gungameprevgunindex = player.gungamegunindex - 1;
}

// Namespace team_gun
// Params 1
// Checksum 0xf2fea637, Offset: 0x13a
// Size: 0x2b
function function_db57c6d06e6168e( team )
{
    if ( !isdefined( level.var_4eeecb77cf60cfea[ team ] ) )
    {
        return 0;
    }
    
    return level.var_4eeecb77cf60cfea[ team ];
}

