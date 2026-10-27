// script_3bdadfff7554ceba  (hash_3bdadfff7554ceba.gscc) (size: 2307 Bytes / 0x903 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbc848da (4224207066)
// size ...... 2307 (0x903)
// includes .. 2   (offset: 0x85f)
// strings ... 8   (offset: 0x86f)
// dev strs .. 3   (offset: 0x8db)
// exports ... 9   (offset: 0x57b)
// cseg ...... 0xd2 + 0x4a9 (0x57b)
// imports ... 13  (offset: 0x6e3)
// animtree1 . 0   (offset: 0x903)
// animtree2 . 0   (offset: 0x903)
#using scripts\mp\bots\bots;
#using scripts\mp\common\utility\game;

#namespace namespace_a60e6d7e4e2fbfbf;

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 0
// Checksum 0x6dbc4005, Offset: 0xf0
// Size: 0x3b
function init()
{
    if ( getdvarint( @"hash_1a92c8ba1b57a968", 0 ) == 0 )
    {
        return;
    }
    
    /#
        setdevdvar( @"hash_ac6f58a6e20ed4c2", 1 );
    #/
    
    createthreatbiasgroup( "Bots" );
    level thread function_26692ec9e085f55d();
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 0
// Checksum 0xeac8c253, Offset: 0x133
// Size: 0x2ac
function function_26692ec9e085f55d()
{
    if ( game[ "roundsPlayed" ] > 0 )
    {
        return;
    }
    
    if ( level.teambased )
    {
        while ( !game_utility_mp::gamehasstarted() )
        {
            wait 0.05;
        }
    }
    else
    {
        while ( !level.prematchstarted )
        {
            waitframe();
        }
    }
    
    if ( getdvarint( @"hash_1a92c8ba1b57a968", 0 ) == 0 )
    {
        return;
    }
    
    while ( !game[ "gamestarted" ] )
    {
        waitframe();
    }
    
    if ( game[ "roundsPlayed" ] > 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_ca355bb894fd699e ) )
    {
        level.var_ca355bb894fd699e = level.teamnamelist;
    }
    
    if ( !isdefined( level.var_d3d68f944e6094af ) )
    {
        if ( level.teambased )
        {
            if ( isdefined( level.maxteamsize ) && level.maxteamsize != 0 )
            {
                level.var_d3d68f944e6094af = level.maxteamsize;
            }
            else
            {
                level.var_d3d68f944e6094af = 6;
            }
        }
        else
        {
            level.var_d3d68f944e6094af = int( 7 ) / 2;
        }
    }
    
    while ( level.var_2fde854ff9118643 )
    {
        waitframe();
    }
    
    /#
        if ( !level.onlinegame )
        {
            while ( !isdefined( level.player ) )
            {
                waitframe();
            }
            
            if ( level.teambased )
            {
                level.var_ca355bb894fd699e = arrayremove( level.var_ca355bb894fd699e, level.player.pers[ "<dev string:x24>" ] );
                level.var_ca355bb894fd699e = arraycombine( [ level.player.pers[ "<dev string:x24>" ] ], level.var_ca355bb894fd699e );
            }
            else
            {
                level.var_ca355bb894fd699e = [ "<dev string:x29>", "<dev string:x30>" ];
            }
        }
    #/
    
    level thread outline_players();
    
    foreach ( entry in level.var_ca355bb894fd699e )
    {
        if ( isdefined( level.player ) && level.player.pers[ "team" ] == entry )
        {
            num_to_spawn = level.var_d3d68f944e6094af - 1;
            
            if ( issplitscreen() )
            {
                num_to_spawn = level.var_d3d68f944e6094af - 1;
            }
        }
        else
        {
            num_to_spawn = level.var_d3d68f944e6094af;
        }
        
        level thread bots::spawn_bots( num_to_spawn, entry, undefined, undefined, undefined, "recruit" );
    }
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 0
// Checksum 0xb2cb831b, Offset: 0x3e7
// Size: 0xf7
function outline_players()
{
    if ( !getdvarint( @"hash_e40a51d94d1570ea", 0 ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( level.player ) && player.pers[ "team" ] == level.player.pers[ "team" ] )
                {
                    player hudoutlineenable( "outline_nodepth_green" );
                    continue;
                }
                
                player hudoutlineenable( "outline_nodepth_red" );
            }
        }
        
        wait 0.25;
    }
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 0
// Checksum 0xfb00d0b3, Offset: 0x4e6
// Size: 0xd
function pause()
{
    level.var_2fde854ff9118643 = 1;
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 0
// Checksum 0x7cece69f, Offset: 0x4fb
// Size: 0xc
function run()
{
    level.var_2fde854ff9118643 = 0;
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 1
// Checksum 0x3e97d36, Offset: 0x50f
// Size: 0x17
function function_654398669848ca76( teams )
{
    level.var_ca355bb894fd699e = teams;
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 1
// Checksum 0x32e1d557, Offset: 0x52e
// Size: 0x17
function function_9c34b2b20eea4249( count )
{
    level.var_d3d68f944e6094af = count;
}

// Namespace namespace_a60e6d7e4e2fbfbf
// Params 3
// Checksum 0x1b99bdfd, Offset: 0x54d
// Size: 0x2d
function modegetforceoperatorcustomization( player, operatorref, operatorSkinRef )
{
    return [ "jup_mp_delta", 0 ];
}

