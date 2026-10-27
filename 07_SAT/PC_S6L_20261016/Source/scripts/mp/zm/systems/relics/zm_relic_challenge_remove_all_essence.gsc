// scripts\mp\zm\systems\relics\zm_relic_challenge_remove_all_essence.gsc  (hash_0fa30a09db07d777.gscc) (size: 1575 Bytes / 0x627 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa71678d3 (2803267795)
// size ...... 1575 (0x627)
// includes .. 4   (offset: 0x5df)
// strings ... 1   (offset: 0x5ff)
// dev strs .. 2   (offset: 0x60f)
// exports ... 7   (offset: 0x2ef)
// cseg ...... 0x6d + 0x282 (0x2ef)
// imports ... 16  (offset: 0x407)
// animtree1 . 0   (offset: 0x627)
// animtree2 . 0   (offset: 0x627)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_remove_all_essence;

// Namespace zm_relic_challenge_remove_all_essence
// Params 0, eflags: 0x5
// Checksum 0x672ecbdf, Offset: 0x8b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_remove_all_essence", undefined, &init_relic_challenge_remove_all_essence, undefined );
}

// Namespace zm_relic_challenge_remove_all_essence
// Params 0
// Checksum 0x472d4301, Offset: 0xac
// Size: 0xa
function init_relic_challenge_remove_all_essence()
{
    level thread function_d0ba81ddbeb50d67();
}

// Namespace zm_relic_challenge_remove_all_essence
// Params 0
// Checksum 0x8481568f, Offset: 0xbe
// Size: 0x1c
function function_d0ba81ddbeb50d67()
{
    zm_relic_challenges::register_relic_challenge_functions( #"remove_all_essence", &function_8cf0eef5eff5047b, &function_21beff4c8f623c16 );
}

// Namespace zm_relic_challenge_remove_all_essence
// Params 0
// Checksum 0x56bfcd6f, Offset: 0xe2
// Size: 0xfa
function function_8cf0eef5eff5047b()
{
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player_id = player getentitynumber();
            level.var_87ea9f7fa24ff1b8[ player_id ] = player utility::callsharedfunc( #"points", #"get_points" );
            player utility::callsharedfunc( #"points", #"set_points", 0 );
        }
    }
    
    level.score_events_disabled = 1;
    callback::add( "on_essence_gained", &on_essence_gained );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_remove_all_essence
// Params 0
// Checksum 0x44ba63b7, Offset: 0x1e4
// Size: 0xdd
function function_21beff4c8f623c16()
{
    level.score_events_disabled = 0;
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player_id = player getentitynumber();
            player utility::callsharedfunc( #"points", #"set_points", level.var_87ea9f7fa24ff1b8[ player_id ] );
        }
    }
    
    callback::remove( "on_essence_gained", &on_essence_gained );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x56>" );
    #/
}

// Namespace zm_relic_challenge_remove_all_essence
// Params 1, eflags: 0x4
// Checksum 0x48276fa8, Offset: 0x2c9
// Size: 0x26
function private on_essence_gained( params )
{
    utility::callsharedfunc( #"points", #"set_points", 0 );
}

