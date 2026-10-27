// script_91d0bb7bd0f4e2b  (hash_091d0bb7bd0f4e2b.gscc) (size: 5351 Bytes / 0x14e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x851112ca (2232488650)
// size ...... 5351 (0x14e7)
// includes .. 10  (offset: 0x13ab)
// strings ... 14  (offset: 0x13fb)
// dev strs .. 3   (offset: 0x14c3)
// exports ... 17  (offset: 0xb03)
// cseg ...... 0x130 + 0x9d3 (0xb03)
// imports ... 52  (offset: 0xdab)
// animtree1 . 0   (offset: 0x14e7)
// animtree2 . 0   (offset: 0x14e7)
#using script_16ea1b94f0f381b3;
#using script_70fa7df687b2e3bf;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\spawnlogic;

#namespace zombie_spawner_mp_hardpoint;

// Namespace zombie_spawner_mp_hardpoint
// Params 0, eflags: 0x1
// Checksum 0xed5ee13c, Offset: 0x14e
// Size: 0x1f
function autoexec init()
{
    if ( level.gametypebundle.var_c61665741f9bb97c )
    {
        thread spawnerinit();
    }
}

// Namespace zombie_spawner_mp_hardpoint
// Params 0
// Checksum 0x8870cd16, Offset: 0x175
// Size: 0xad
function spawnerinit()
{
    level callback::add( #"game_ended", &ongameended );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( "on_zombie_ai_killed", &function_daa83d8f74dfdd0 );
    level callback::add( "on_agent_spawned", &function_c8085c6263ef36bf );
    level callback::add( "zone_captured", &function_e88fe3267473f098 );
    level callback::add( "zone_unoccupied", &function_e88fe3267473f098 );
    namespace_3047dff6a502386b::function_6c0fdc0c23f23397();
    createthreatbiasgroup( "team_two_hundred" );
    utility::registersharedfunc( #"combat_hologram", #"zombie_attractor_validator", &function_d0d8958d017bc54c );
    level thread function_9464570ccdf080fd();
}

// Namespace zombie_spawner_mp_hardpoint
// Params 2, eflags: 0x4
// Checksum 0xeb95cb5e, Offset: 0x22a
// Size: 0x20
function private function_d0d8958d017bc54c( attractor, ai )
{
    return ai.var_3d4b66b7212ffee0;
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0xa0ce5e1b, Offset: 0x253
// Size: 0x35
function on_player_spawned( params )
{
    friendteam = level.gametypebundle.var_cef67bd8fad2571f;
    namespace_3047dff6a502386b::function_281fbcb10cdce0df( self, friendteam );
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0x63de8802, Offset: 0x290
// Size: 0x14
function ongameended( winner )
{
    level thread function_b58379410a8707a7();
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0xa8abe774, Offset: 0x2ac
// Size: 0x5a
function function_daa83d8f74dfdd0( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    params.eattacker thread points::doscoreevent( #"hash_d27ffe8c22fcbf6c", undefined, 5 );
    spawnlogic::removespawninfluencer( params.agent.spawninfluencer );
}

// Namespace zombie_spawner_mp_hardpoint
// Params 0
// Checksum 0xf4309b35, Offset: 0x30e
// Size: 0x91
function function_b58379410a8707a7()
{
    activezombies = agent_utility::getactiveagentsoftype( "zombie_base" );
    
    foreach ( zombie in activezombies )
    {
        if ( isalive( zombie ) )
        {
            zombie kill();
            waitframe();
        }
    }
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0x29b0a5bd, Offset: 0x3a7
// Size: 0x2c
function function_e88fe3267473f098( params )
{
    allyteam = params.team;
    function_43a88847b0f07f90( allyteam );
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1, eflags: 0x4
// Checksum 0xc6ffb5cf, Offset: 0x3db
// Size: 0x3a
function private function_43a88847b0f07f90( allyteam )
{
    level.gametypebundle.var_cef67bd8fad2571f = allyteam;
    namespace_3047dff6a502386b::function_c48ec991a151d7ca( allyteam, "team_two_hundred" );
    level thread function_892be6d1db85dc41( allyteam );
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1, eflags: 0x4
// Checksum 0xd258aa06, Offset: 0x41d
// Size: 0xb1
function private function_892be6d1db85dc41( allyteam = "team_two_hundred" )
{
    activeagents = agent_utility::getactiveagentsoftype( "zombie_base" );
    
    foreach ( agent in activeagents )
    {
        agent namespace_3047dff6a502386b::function_d459dbb12782be2d( allyteam );
        agent clearenemy();
        namespace_3047dff6a502386b::function_44808593c36bbd6a( agent, allyteam );
    }
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0x2fdb4ba7, Offset: 0x4d6
// Size: 0xbb
function function_c8085c6263ef36bf( params )
{
    waitframe();
    allyteam = level.gametypebundle.var_cef67bd8fad2571f;
    
    if ( !isdefined( allyteam ) )
    {
        allyteam = "team_two_hundred";
    }
    
    params.agent namespace_3047dff6a502386b::function_d459dbb12782be2d( allyteam );
    namespace_3047dff6a502386b::function_44808593c36bbd6a( params.agent, allyteam );
    params.agent.spawninfluencer = spawnlogic::addspawninfluencer( #"hash_de4c5e46f803bae", params.agent.origin, undefined, undefined, params.agent );
    params.agent namespace_9d8e359c3b1041e5::function_b739495605e4ba8a( 1 );
}

// Namespace zombie_spawner_mp_hardpoint
// Params 0
// Checksum 0x5860eb07, Offset: 0x599
// Size: 0x1d0
function function_9464570ccdf080fd()
{
    level endon( #"game_ended" );
    level flags::function_2f3408423ccc9b2e( "prematch_done" );
    function_5fbc064da9b8ad4e();
    type = function_b3988325430ce242( "zombie_base" );
    
    /#
        level thread debug_zombie_count( type, level.gametypebundle.var_5fcbbe02c5506511 ?? 12 );
    #/
    
    while ( true )
    {
        var_5b110820daa2b673 = function_9767e7cfbc8e6e48( "zombie_base" );
        
        if ( var_5b110820daa2b673 < ( level.gametypebundle.var_5fcbbe02c5506511 ?? 12 ) )
        {
            spawnorigin = get_spawn_point();
            
            if ( isdefined( spawnorigin ) )
            {
                ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( type, spawnorigin, ( 0, randomint( 360 ), 0 ), "team_two_hundred" );
                
                if ( isagent( ai ) )
                {
                    ai thread utility::animscriptedagent( "spawn", "spawn_end", undefined, ( 0, 0, 0 ), "spawn_animating" );
                    ai.var_3d4b66b7212ffee0 = 1;
                    ai.stealth_enabled = 0;
                    movespeed = utility::random_weighted( [ "walk", "run", "sprint" ], [ level.gametypebundle.var_e7d7c6e2de538561 ?? 0, level.gametypebundle.var_95233e8916f383ad ?? 0, level.gametypebundle.var_932229a6f9966a10 ?? 100 ] );
                    ai zombie_utils::function_a8ce00e0448cb6f0( movespeed, "hp_zombie_spawn", 1 );
                    ai function_fa32376aaa88a7a2( ai.origin, 5000 );
                    ai setthreatbiasgroup( "team_two_hundred" );
                }
            }
        }
        
        wait 1.5;
    }
}

// Namespace zombie_spawner_mp_hardpoint
// Params 0, eflags: 0x4
// Checksum 0xab14fd1a, Offset: 0x771
// Size: 0x13
function private function_5fbc064da9b8ad4e()
{
    while ( !level.var_f334a2aa4deb0aeb )
    {
        waitframe();
    }
}

// Namespace zombie_spawner_mp_hardpoint
// Params 1
// Checksum 0xac5403f7, Offset: 0x78c
// Size: 0xa5
function function_9767e7cfbc8e6e48( type )
{
    agents = agent_utility::getactiveagentsoftype( type );
    count = 0;
    
    foreach ( agent in agents )
    {
        if ( agent.var_3d4b66b7212ffee0 )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace zombie_spawner_mp_hardpoint
// Params 0
// Checksum 0x5d711eba, Offset: 0x83a
// Size: 0x243
function get_spawn_point()
{
    if ( !level.players.size )
    {
        return;
    }
    
    hardpointorigin = isdefined( level.zone ) ? level.zone.curorigin : undefined;
    
    for ( attempt = 0; attempt < 20 ; attempt++ )
    {
        player = utility::array_random( level.players );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        x = ( randomint( 2048 ) + 512 ) * pow( -1, randomint( 2 ) );
        y = ( randomint( 2048 ) + 512 ) * pow( -1, randomint( 2 ) );
        candidate = getrandomnavpoint( player.origin + ( x, y, 0 ), 512 );
        
        if ( !candidate )
        {
            continue;
        }
        
        if ( hardpointorigin && distance2dsquared( candidate, hardpointorigin ) < 1048576 )
        {
            continue;
        }
        
        tooclose = 0;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( candidate, player.origin ) < 262144 )
            {
                tooclose = 1;
                break;
            }
        }
        
        if ( tooclose )
        {
            continue;
        }
        
        visible = 0;
        
        foreach ( player in level.players )
        {
            if ( sighttracepassed( player geteye(), candidate + ( 0, 0, 50 ), 0, player ) )
            {
                visible = 1;
                break;
            }
            
            waitframe();
        }
        
        if ( visible )
        {
            continue;
        }
        
        return candidate;
    }
}

/#

    // Namespace zombie_spawner_mp_hardpoint
    // Params 2
    // Checksum 0xcb5dba37, Offset: 0xa86
    // Size: 0x7d, Type: dev
    function debug_zombie_count( type, maxzombies )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_6ec4514bbc528e06" ) )
            {
                count = agent_utility::getnumactiveagents( "<dev string:x24>" );
                printtoscreen2d( 100, 100, "<dev string:x30>" + count + "<dev string:x3d>" + maxzombies, ( 1, 1, 0 ), 2 );
            }
            
            waitframe();
        }
    }

#/
