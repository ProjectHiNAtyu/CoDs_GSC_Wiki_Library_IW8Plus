// scripts\mp\zm\systems\relics\zm_relic_challenge_no_health_regen.gsc  (hash_14e83682478089a8.gscc) (size: 1802 Bytes / 0x70a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bfa62bc (2080006844)
// size ...... 1802 (0x70a)
// includes .. 4   (offset: 0x6be)
// strings ... 1   (offset: 0x6de)
// dev strs .. 2   (offset: 0x6f2)
// exports ... 8   (offset: 0x37a)
// cseg ...... 0x80 + 0x2fa (0x37a)
// imports ... 17  (offset: 0x4ba)
// animtree1 . 0   (offset: 0x70a)
// animtree2 . 0   (offset: 0x70a)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\playerhealth;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_no_health_regen;

// Namespace zm_relic_challenge_no_health_regen
// Params 0, eflags: 0x5
// Checksum 0x6c0a03d2, Offset: 0x9e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_cacba369694765bd", undefined, &function_d6e308bea9ee177d, undefined );
}

// Namespace zm_relic_challenge_no_health_regen
// Params 0
// Checksum 0xf14745e1, Offset: 0xbf
// Size: 0xa
function function_d6e308bea9ee177d()
{
    level thread function_3a738ae9c9c6ef1a();
}

// Namespace zm_relic_challenge_no_health_regen
// Params 0
// Checksum 0xefead6e6, Offset: 0xd1
// Size: 0x1c
function function_3a738ae9c9c6ef1a()
{
    zm_relic_challenges::register_relic_challenge_functions( #"no_health_regen", &function_3d6a176cf418a488, &function_7024ae6d4c3fae5f );
}

// Namespace zm_relic_challenge_no_health_regen
// Params 0
// Checksum 0x1741da41, Offset: 0xf5
// Size: 0xdb
function function_3d6a176cf418a488()
{
    level.healthregendisabled = 1;
    
    if ( !callback::exists( "on_relic_challenge_objective_updated", &function_90fbd895de4e36d6 ) )
    {
        callback::add( "on_relic_challenge_objective_updated", &function_90fbd895de4e36d6 );
    }
    
    callback::add( #"player_spawned", &on_player_spawned );
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player playerhealth::function_5be24c25b7e649ba( 1 );
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_no_health_regen
// Params 0
// Checksum 0x18c61d08, Offset: 0x1d8
// Size: 0xc5
function function_7024ae6d4c3fae5f()
{
    level.healthregendisabled = undefined;
    callback::remove( "on_relic_challenge_objective_updated", &function_90fbd895de4e36d6 );
    callback::remove( #"player_spawned", &on_player_spawned );
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player playerhealth::function_5be24c25b7e649ba( 0 );
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x53>" );
    #/
}

// Namespace zm_relic_challenge_no_health_regen
// Params 1, eflags: 0x4
// Checksum 0xc0fc010c, Offset: 0x2a5
// Size: 0xac
function private function_90fbd895de4e36d6( params )
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            player.health = player.maxhealth;
        }
    }
}

// Namespace zm_relic_challenge_no_health_regen
// Params 1, eflags: 0x4
// Checksum 0x539b52c1, Offset: 0x359
// Size: 0x21
function private on_player_spawned( params )
{
    self endon( #"death_or_disconnect" );
    playerhealth::function_5be24c25b7e649ba( 1 );
}

