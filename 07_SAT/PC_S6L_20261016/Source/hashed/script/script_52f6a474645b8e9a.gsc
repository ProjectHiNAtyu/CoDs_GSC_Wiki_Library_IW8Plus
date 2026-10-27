// script_52f6a474645b8e9a  (hash_52f6a474645b8e9a.gscc) (size: 3054 Bytes / 0xbee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c033c1b (1006844955)
// size ...... 3054 (0xbee)
// includes .. 4   (offset: 0xb9e)
// strings ... 3   (offset: 0xbbe)
// dev strs .. 0   (offset: 0xbee)
// exports ... 10  (offset: 0x736)
// cseg ...... 0x97 + 0x69f (0x736)
// imports ... 23  (offset: 0x8c6)
// animtree1 . 0   (offset: 0xbee)
// animtree2 . 0   (offset: 0xbee)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace namespace_c6e391ebf419f41d;

// Namespace namespace_c6e391ebf419f41d
// Params 0
// Checksum 0xa557d157, Offset: 0xb5
// Size: 0xe5
function init()
{
    if ( getdvarint( @"br_ftue_active", 0 ) == 0 )
    {
        return;
    }
    
    level.br_ftue_active = 1;
    level.var_1c7c255f57ba3f06 = getdvarint( @"hash_2401fbc45a4682a5", 100 );
    level.var_2f9249575ba20dd9 = getdvarint( @"hash_3fd4f18a01c87ce2", 10 );
    level.var_f7f4b42c3442522d = 0;
    level.var_ad7caf27cd82df2 = 0;
    utility::registersharedfunc( #"gametype", #"updatePlayerAndTeamCountUI", &ftue_updateplayerandteamcountui );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &ftue_onplayerkilled );
    utility::registersharedfunc( #"gametype", #"hash_a407cc94ad2c6279", &ftue_onplayerconnect );
    utility::registersharedfunc( #"gametype", #"onPlayerDisconnect", &ftue_onplayerdisconnect );
    level thread watchprematchdone();
}

// Namespace namespace_c6e391ebf419f41d
// Params 2
// Checksum 0x43852519, Offset: 0x1a2
// Size: 0x272
function ftue_updateplayerandteamcountui( aliveplayercount, activeteams )
{
    totalplayers = level.players.size;
    aliveplayercount = 0;
    var_651503a2996db478 = 0;
    activeteams = [];
    
    for ( i = 0; i < totalplayers ; i++ )
    {
        player = level.players[ i ];
        
        if ( player br::function_a29e5f57c1ef9e35() )
        {
            continue;
        }
        
        if ( !player.br_iseliminated )
        {
            if ( player.iszombie )
            {
                var_651503a2996db478++;
            }
            else
            {
                aliveplayercount++;
                activeteams[ player.team ] = 1;
            }
        }
        
        if ( !isdefined( activeteams[ player.team ] ) )
        {
            result = utility::callsharedfunc( #"gametype", #"isteameliminated", player.team );
            
            if ( isdefined( result ) )
            {
                if ( !result )
                {
                    activeteams[ player.team ] = 1;
                }
            }
        }
    }
    
    foreach ( uibot in br::function_cda6de7e2ba52066() )
    {
        aliveplayercount++;
        activeteams[ uibot.team ] = 1;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        activeteamcount = int( activeteams.size + level.var_1c7c255f57ba3f06 / game_utility::function_f24780eadd3fb772() );
        aliveplayercount = int( aliveplayercount + level.var_1c7c255f57ba3f06 );
    }
    else
    {
        activeteamcount = int( activeteams.size + level.var_f7f4b42c3442522d / game_utility::function_f24780eadd3fb772() );
        aliveplayercount = int( aliveplayercount + level.var_f7f4b42c3442522d );
    }
    
    level.var_ad7caf27cd82df2 = activeteamcount;
    level.var_fc71e82557e9a9c2 = aliveplayercount;
    level.var_227b8a3a9c083621 = activeteamcount;
    
    /#
        var_2d13161b905894b7 = 255;
        assert( var_651503a2996db478 <= var_2d13161b905894b7 );
        assert( aliveplayercount <= var_2d13161b905894b7 );
        assert( activeteams.size <= var_2d13161b905894b7 );
    #/
    
    var_a187995f65a64fdb = ( var_651503a2996db478 << 16 ) + ( activeteamcount << 8 ) + aliveplayercount;
    setomnvar( "ui_br_match_stats", var_a187995f65a64fdb );
}

// Namespace namespace_c6e391ebf419f41d
// Params 1
// Checksum 0x765b2699, Offset: 0x41c
// Size: 0x22
function ftue_onplayerkilled( deathdata )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        level thread function_2620bd5bb3a02db7();
    }
}

// Namespace namespace_c6e391ebf419f41d
// Params 1
// Checksum 0x7b4e296d, Offset: 0x446
// Size: 0xde
function ftue_onplayerconnect( player )
{
    var_2036c04f2fdaff81 = level.players.size - level.var_2f9249575ba20dd9;
    
    if ( var_2036c04f2fdaff81 > 0 )
    {
        var_fc1ce1d1783a660f = level.var_1c7c255f57ba3f06 / getdvarint( @"party_maxplayers", 1 );
    }
    else
    {
        var_fc1ce1d1783a660f = 0;
    }
    
    if ( var_fc1ce1d1783a660f <= 0 )
    {
        return;
    }
    
    totalplayers = level.players.size;
    var_7a3272ba70977635 = level.var_1c7c255f57ba3f06 + totalplayers;
    
    for ( i = 0; i < var_fc1ce1d1783a660f ; i++ )
    {
        level.var_f7f4b42c3442522d = min( var_7a3272ba70977635, level.var_f7f4b42c3442522d + 1 );
        br::updateplayerandteamcountui();
        
        if ( level.var_1c7c255f57ba3f06 <= 0 )
        {
            return;
        }
    }
    
    br::updateplayerandteamcountui();
}

// Namespace namespace_c6e391ebf419f41d
// Params 1
// Checksum 0xc70b9093, Offset: 0x52c
// Size: 0x2d
function ftue_onplayerdisconnect( player )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        level thread function_2620bd5bb3a02db7();
        return;
    }
    
    level thread function_2620bd5bb3a02db7( 1 );
}

// Namespace namespace_c6e391ebf419f41d
// Params 0
// Checksum 0x9aa89314, Offset: 0x561
// Size: 0x19
function function_19c459a55be9500()
{
    self setclientomnvar( "ui_br_player_position", level.var_ad7caf27cd82df2 + 1 );
}

// Namespace namespace_c6e391ebf419f41d
// Params 0
// Checksum 0x17a736b8, Offset: 0x582
// Size: 0x7a
function watchprematchdone()
{
    br::updateplayerandteamcountui();
    level waittill( #"prematch_over" );
    level.var_fc1ce1d1783a660f = undefined;
    level.var_f7f4b42c3442522d = undefined;
    var_4ae38e43e07e1b0e = level.players.size - level.var_2f9249575ba20dd9;
    
    if ( var_4ae38e43e07e1b0e > 0 )
    {
        level.var_47c0920464124b2 = level.var_1c7c255f57ba3f06 / var_4ae38e43e07e1b0e;
    }
    else
    {
        level.var_1c7c255f57ba3f06 = 0;
    }
    
    br::updateplayerandteamcountui();
}

// Namespace namespace_c6e391ebf419f41d
// Params 1
// Checksum 0x58c7dd0d, Offset: 0x604
// Size: 0xa7
function function_2620bd5bb3a02db7( bimmediate )
{
    if ( level.var_1c7c255f57ba3f06 <= 0 )
    {
        return;
    }
    
    decrementcount = flags::gameflag( "prematch_done" ) ? level.var_47c0920464124b2 : level.var_fc1ce1d1783a660f;
    
    if ( !isdefined( decrementcount ) )
    {
        return;
    }
    
    for ( i = 0; i < decrementcount ; i++ )
    {
        if ( !bimmediate )
        {
            wait randomfloat( 5 );
        }
        
        level.var_1c7c255f57ba3f06 = max( 0, level.var_1c7c255f57ba3f06 - 1 );
        br::updateplayerandteamcountui();
        
        if ( level.var_1c7c255f57ba3f06 <= 0 )
        {
            return;
        }
    }
}

// Namespace namespace_c6e391ebf419f41d
// Params 0
// Checksum 0x3832d215, Offset: 0x6b3
// Size: 0x82
function getalivecount()
{
    totalplayers = level.players.size;
    aliveplayercount = 0;
    
    for ( i = 0; i < totalplayers ; i++ )
    {
        player = level.players[ i ];
        
        if ( player br::function_a29e5f57c1ef9e35() )
        {
            continue;
        }
        
        if ( !player.br_iseliminated )
        {
            if ( !player.iszombie )
            {
                aliveplayercount++;
            }
        }
    }
    
    return aliveplayercount;
}

