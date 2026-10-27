// scripts\mp\zm\systems\relics\zm_relic_challenge_only_brainrot_kills.gsc  (hash_126b03d1bb337ec4.gscc) (size: 2799 Bytes / 0xaef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30f8d997 (821614999)
// size ...... 2799 (0xaef)
// includes .. 6   (offset: 0xa5f)
// strings ... 5   (offset: 0xa8f)
// dev strs .. 2   (offset: 0xad7)
// exports ... 11  (offset: 0x58f)
// cseg ...... 0xb0 + 0x4df (0x58f)
// imports ... 26  (offset: 0x747)
// animtree1 . 0   (offset: 0xaef)
// animtree2 . 0   (offset: 0xaef)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_brainrot_kills;

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0, eflags: 0x5
// Checksum 0xe3a33f20, Offset: 0xce
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_c132ee75cea61c3", undefined, &function_843ee96d3b71f03, undefined );
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0
// Checksum 0xa8ec397, Offset: 0xef
// Size: 0xa
function function_843ee96d3b71f03()
{
    level thread function_2aa207909f0440c0();
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0
// Checksum 0x14dd5e20, Offset: 0x101
// Size: 0x1c
function function_2aa207909f0440c0()
{
    zm_relic_challenges::register_relic_challenge_functions( #"only_brainrot_kills", &function_82e5dfb7e736b072, &function_c91763ff10242db1 );
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0
// Checksum 0x92ac5d55, Offset: 0x125
// Size: 0x7a
function function_82e5dfb7e736b072()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_3e474408af46ce1a );
    level thread function_148acc58de674d08();
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level callback::add( "on_turned", &on_brainrot_proc );
    level callback::add( "on_brainrot_end", &on_brainrot_end );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0
// Checksum 0xcf19134c, Offset: 0x1a7
// Size: 0x1ad
function function_c91763ff10242db1()
{
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    level callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level callback::remove( "on_turned", &on_brainrot_proc );
    level callback::remove( "on_brainrot_end", &on_brainrot_end );
    level.var_cdca5e730e05bc39 = 0;
    level notify( #"hash_707697430ec03e8a" );
    var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in var_d3bf5c32e7a64eb1 )
    {
        if ( isalive( zombie ) )
        {
            zombie zm_relic_challenges::function_908a1b8613e50514();
        }
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player.var_d979f5d362b549ab = undefined;
            player.var_21b6849991ff8d5d = undefined;
            player.var_1db20ec8603de2ad = undefined;
            player.var_3c03e691e10ab42d = undefined;
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x59>" );
    #/
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 1, eflags: 0x4
// Checksum 0xea5b47bb, Offset: 0x35c
// Size: 0xd4
function private function_3e474408af46ce1a( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( dmg_struct.eattacker && dmg_struct.eattacker zombie_utils::function_bf1464d09f4e4b40() || dmg_struct.einflictor && dmg_struct.einflictor zombie_utils::function_bf1464d09f4e4b40() || dmg_struct.einflictor.agentteam == level.player.team || dmg_struct.sweapon.basename == "sat_gas_grenade_zm" )
    {
        idamage *= 3;
        zm_relic_challenges::function_908a1b8613e50514();
    }
    else
    {
        idamage = 3;
        zm_relic_challenges::set_zombie_damage_invuln();
    }
    
    return idamage;
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 0, eflags: 0x4
// Checksum 0x1cd46017, Offset: 0x439
// Size: 0xe2
function private function_148acc58de674d08()
{
    level endon( #"game_ended" );
    level endon( #"hash_707697430ec03e8a" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isplayer( player ) )
            {
                player.var_d979f5d362b549ab = 1;
                player.var_21b6849991ff8d5d = 0.2;
                player.var_1db20ec8603de2ad = 0.1;
                player.var_3c03e691e10ab42d = 0.05;
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 1, eflags: 0x4
// Checksum 0x835fd4ae, Offset: 0x523
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 1, eflags: 0x4
// Checksum 0xc869de67, Offset: 0x53e
// Size: 0x2e
function private on_brainrot_end( params )
{
    if ( isagent( self ) && self.aicategory != "normal" )
    {
        zm_relic_challenges::set_zombie_damage_invuln();
    }
}

// Namespace zm_relic_challenge_only_brainrot_kills
// Params 1, eflags: 0x4
// Checksum 0x9682cce0, Offset: 0x574
// Size: 0x1b
function private on_brainrot_proc( params )
{
    if ( isagent( self ) )
    {
        zm_relic_challenges::function_908a1b8613e50514();
    }
}

