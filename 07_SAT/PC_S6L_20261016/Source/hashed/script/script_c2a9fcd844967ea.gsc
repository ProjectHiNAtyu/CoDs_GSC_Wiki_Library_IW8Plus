// script_c2a9fcd844967ea  (hash_0c2a9fcd844967ea.gscc) (size: 888 Bytes / 0x378 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2c6f6b7a (745499514)
// size ...... 888 (0x378)
// includes .. 4   (offset: 0x334)
// strings ... 1   (offset: 0x354)
// dev strs .. 2   (offset: 0x360)
// exports ... 5   (offset: 0x16c)
// cseg ...... 0x78 + 0xf4 (0x16c)
// imports ... 9   (offset: 0x234)
// animtree1 . 0   (offset: 0x378)
// animtree2 . 0   (offset: 0x378)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_cache;

#namespace activity_rewards_mp;

// Namespace activity_rewards_mp
// Params 0, eflags: 0x5
// Checksum 0xf564986, Offset: 0x96
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_rewards_mp", #"activity_common", &function_813f83dccb72a48, undefined );
}

// Namespace activity_rewards_mp
// Params 0, eflags: 0x4
// Checksum 0xf0a9668d, Offset: 0xbf
// Size: 0x9
function private function_813f83dccb72a48()
{
    thread function_e5f8a4482d43638f();
}

// Namespace activity_rewards_mp
// Params 0, eflags: 0x4
// Checksum 0x51d3db18, Offset: 0xd0
// Size: 0x28
function private function_e5f8a4482d43638f()
{
    utility::flag_wait( "activity_nexus_init_complete" );
    
    if ( !activity_common::function_e9bc8a898f05077d( 9 ) )
    {
        activity_common::function_9fd46b47e0d8481d( 9, &function_2b11637b0400a17c );
    }
}

// Namespace activity_rewards_mp
// Params 1, eflags: 0x4
// Checksum 0x82cb4276, Offset: 0x100
// Size: 0x6c
function private function_2b11637b0400a17c( relevantparameters )
{
    grouprewardcache = relevantparameters.cache;
    player = relevantparameters.player;
    
    if ( !isdefined( grouprewardcache ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x66>" );
        return;
    }
    
    common_cache::openlootablecontainer( grouprewardcache, player );
}

