// script_1c60c697ef3386e  (hash_01c60c697ef3386e.gscc) (size: 1327 Bytes / 0x52f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x569a23a6 (1452942246)
// size ...... 1327 (0x52f)
// includes .. 4   (offset: 0x4fb)
// strings ... 1   (offset: 0x51b)
// dev strs .. 0   (offset: 0x52f)
// exports ... 4   (offset: 0x353)
// cseg ...... 0xa0 + 0x2b3 (0x353)
// imports ... 9   (offset: 0x3f3)
// animtree1 . 0   (offset: 0x52f)
// animtree2 . 0   (offset: 0x52f)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\points;

#namespace bgb_profit_sharing_zm;

// Namespace bgb_profit_sharing_zm
// Params 0, eflags: 0x5
// Checksum 0x8873737f, Offset: 0xbe
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"profit_sharing_zm", "profit_sharing", &pre_main, undefined );
}

// Namespace bgb_profit_sharing_zm
// Params 0, eflags: 0x4
// Checksum 0xdd99f7b2, Offset: 0xe3
// Size: 0x1c
function private pre_main()
{
    utility::registersharedfunc( "profit_sharing", #"hash_69e473d4d077e03e", &function_ed911cdbb38c6719 );
}

// Namespace bgb_profit_sharing_zm
// Params 3
// Checksum 0x4ee458b7, Offset: 0x107
// Size: 0x24b, Type: bool
function function_ed911cdbb38c6719( var_eb8fc40490886d0a, var_18484ecb85b885be, var_f73031792a7a61f4 )
{
    if ( !isdefined( var_18484ecb85b885be ) )
    {
        return false;
    }
    
    switch ( var_18484ecb85b885be )
    {
        case #"profit_sharing":
        case #"powerup_bonus_points_team":
        case #"hash_495c0c1b33d9b414":
        case #"bgb_gift_card":
        case #"hash_94a335b456789386":
        case #"hash_9fbcf64817cd3e0c":
        case #"powerup_nuke":
        case #"hash_f0666fbe26b6cffa":
            return false;
        default:
            break;
    }
    
    if ( !var_f73031792a7a61f4 )
    {
        foreach ( e_player in level.players )
        {
            if ( isdefined( e_player ) && self.team == e_player.team && e_player namespace_6616340f3419ea2d::is_enabled( "profit_sharing" ) )
            {
                if ( isdefined( e_player.var_d2d61a0b77c6612 ) && arraycontains( e_player.var_d2d61a0b77c6612, self ) )
                {
                    e_player points::zm_give_points( #"profit_sharing", var_eb8fc40490886d0a );
                    e_player playlocalsound( #"hash_12138bab37bdc070" );
                }
            }
        }
    }
    else if ( self.var_d2d61a0b77c6612.size > 0 )
    {
        foreach ( e_player in self.var_d2d61a0b77c6612 )
        {
            if ( isdefined( e_player ) && self.team == e_player.team )
            {
                e_player points::zm_give_points( #"profit_sharing", var_eb8fc40490886d0a );
                e_player playlocalsound( #"hash_12138bab37bdc070" );
            }
        }
    }
    
    return false;
}

