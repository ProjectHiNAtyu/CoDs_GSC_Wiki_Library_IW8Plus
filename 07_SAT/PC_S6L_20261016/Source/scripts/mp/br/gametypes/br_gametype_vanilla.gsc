// scripts\mp\br\gametypes\br_gametype_vanilla.gsc  (hash_395a6bcc7fd838a6.gscc) (size: 6291 Bytes / 0x1893 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a5f3e0f (442449423)
// size ...... 6291 (0x1893)
// includes .. 12  (offset: 0x17a7)
// strings ... 10  (offset: 0x1807)
// dev strs .. 0   (offset: 0x1893)
// exports ... 16  (offset: 0xfa7)
// cseg ...... 0x12a + 0xe7d (0xfa7)
// imports ... 45  (offset: 0x1227)
// animtree1 . 0   (offset: 0x1893)
// animtree2 . 0   (offset: 0x1893)
#using script_1746f14cc7bde851;
#using script_26ccbfe3954cacf4;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\class;
#using scripts\mp\common\utility\teams;
#using scripts\mp\menus;

#namespace br_gametype_vanilla;

// Namespace br_gametype_vanilla
// Params 0
// Checksum 0x9e8ae398, Offset: 0x148
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_vanilla
// Params 0
// Checksum 0x4ac45491, Offset: 0x167
// Size: 0x1c8
function init()
{
    level.var_e5e4ea643e4531d2 = 0;
    level.var_20709a567373e521 = 0;
    level.var_3bf0c553963d5f37 = 0;
    level.var_43517c54ad74e3aa = 1;
    level.minplunderdropondeath = getdvarint( @"hash_e0a487b88d0e4410", 1 );
    utility::registersharedfunc( #"gametype", #"hash_730736e67a16d49f", &getbestspectatecandidate );
    utility::registersharedfunc( #"gametype", #"hash_a4eabcdb5f3aac07", &isvalidspectatetarget );
    utility::registersharedfunc( #"gametype", #"onmarkplayeraseliminated", &onmarkplayeraseliminated );
    utility::registersharedfunc( #"gametype", #"onunmarkplayeraseliminated", &onunmarkplayeraseliminated );
    utility::registersharedfunc( #"gametype", #"kioskreviveplayer", &function_34627a6a319fd2a );
    utility::registersharedfunc( #"gametype", #"getrandomloadout", &getrandomloadout );
    level.var_c21a63e88747885e = &function_32b846d3369552ec;
    level.quest_domdistmin = getdvarint( @"hash_a733bbfd9d9909fe", 500 );
    level.quest_domdistmax = getdvarint( @"hash_a710cdfd9d72e9dc", 7000 );
    level.quest_assdistmin = getdvarint( @"hash_4512e59f0eae9", 500 );
    level.quest_assdistmax = getdvarint( @"hash_ffe1432e59ca8467", 7000 );
    level.quest_scavdistmin = getdvarint( @"hash_a607164e2c76e4f1", 500 );
    level.quest_scavdistmax = getdvarint( @"hash_a62a284e2c9d543f", 7000 );
    level.shownonspectatingwinnersplash = 1;
    level.giveloadoutextraammo = 1;
    thread function_fd1beaf5cb97c51e();
    
    if ( namespace_492d4ed3c588587e::function_106d3cd3d57cf4f5() )
    {
        namespace_492d4ed3c588587e::init();
    }
}

// Namespace br_gametype_vanilla
// Params 0
// Checksum 0x35b13fb5, Offset: 0x337
// Size: 0x157
function function_fd1beaf5cb97c51e()
{
    if ( getdvarint( @"hash_d541be8ce632eac6", 0 ) == 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            totalplunder = level.teamdata[ team ][ "plunderTeamTotal" ];
            
            if ( isdefined( totalplunder ) )
            {
                players = teams::getfriendlyplayers( team, 0 );
                
                foreach ( player in players )
                {
                    player setclientomnvar( "ui_br_team_cash_pockets", totalplunder );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_vanilla
// Params 2
// Checksum 0x4c1ea1de, Offset: 0x496
// Size: 0x144
function getbestspectatecandidate( victim, attacker )
{
    playertospectate = undefined;
    
    if ( isvalidspectatetarget( victim.nextplayertospectate ) )
    {
        playertospectate = victim.nextplayertospectate;
        victim.nextplayertospectate = undefined;
        return playertospectate;
    }
    
    playertospectate = function_8e588ccd4ff5c40c( victim );
    
    if ( isvalidspectatetarget( playertospectate ) )
    {
        return playertospectate;
    }
    
    if ( isvalidspectatetarget( attacker ) )
    {
        return attacker;
    }
    
    playertospectateref = balancespectators( victim );
    
    if ( isdefined( playertospectateref ) )
    {
        return playertospectateref;
    }
    
    var_f0fb703a8085c806 = undefined;
    
    foreach ( bot in level.players )
    {
        if ( bot != victim && isvalidspectatetarget( bot ) )
        {
            if ( !bot manager::function_5c79ebe77f7d0528() )
            {
                return bot;
            }
            
            if ( !isdefined( var_f0fb703a8085c806 ) )
            {
                var_f0fb703a8085c806 = bot;
            }
        }
    }
    
    if ( isdefined( var_f0fb703a8085c806 ) )
    {
        return var_f0fb703a8085c806;
    }
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0xc6de36a9, Offset: 0x5e3
// Size: 0x4c, Type: bool
function isvalidspectatetarget( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player manager::isuibot() )
    {
        return false;
    }
    
    if ( !namespace_ef4547f85724edd1::isaliveplayer( player ) )
    {
        return false;
    }
    
    if ( player.inblackroom )
    {
        return false;
    }
    
    return !player.br_iseliminated;
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0xc182869b, Offset: 0x638
// Size: 0x35e
function function_8e588ccd4ff5c40c( victim )
{
    if ( level.onlinegame && isdefined( victim ) && victim getprivatepartysize() )
    {
        fireteamcandidates = victim getfireteammembers();
        var_55d4fff3441b053d = undefined;
        
        foreach ( player in fireteamcandidates )
        {
            if ( player == victim )
            {
                continue;
            }
            
            if ( player isfireteamleader() && isvalidspectatetarget( player ) )
            {
                return player;
            }
        }
        
        var_55d4fff3441b053d = undefined;
        closestdist = undefined;
        
        foreach ( player in fireteamcandidates )
        {
            if ( victim != player && isvalidspectatetarget( player ) )
            {
                if ( isdefined( victim.lastdeathpos ) )
                {
                    var_95aa9bf34724d204 = distance2dsquared( victim.lastdeathpos, player.origin );
                    
                    if ( !isdefined( closestdist ) || var_95aa9bf34724d204 < closestdist )
                    {
                        var_55d4fff3441b053d = player;
                        closestdist = var_95aa9bf34724d204;
                    }
                    
                    continue;
                }
                
                return player;
            }
        }
        
        if ( isdefined( var_55d4fff3441b053d ) )
        {
            return var_55d4fff3441b053d;
        }
    }
    
    botcandidate = undefined;
    
    if ( isdefined( victim.team ) )
    {
        teammates = teams::getfriendlyplayers( victim.team, 1 );
        
        if ( isdefined( victim.lastdeathpos ) )
        {
            var_56fd2381f5d8be13 = undefined;
            var_a7baaa08d90422c6 = undefined;
            closestdist = undefined;
            
            foreach ( player in teammates )
            {
                var_95aa9bf34724d204 = distance2dsquared( victim.lastdeathpos, player.origin );
                
                if ( function_565fe04ba8abb6bd( player ) )
                {
                    if ( !isdefined( var_a7baaa08d90422c6 ) || var_95aa9bf34724d204 < var_a7baaa08d90422c6 )
                    {
                        var_56fd2381f5d8be13 = player;
                        var_a7baaa08d90422c6 = var_95aa9bf34724d204;
                    }
                    
                    continue;
                }
                
                if ( !isdefined( var_56fd2381f5d8be13 ) && isvalidspectatetarget( player ) )
                {
                    if ( !isdefined( closestdist ) || var_95aa9bf34724d204 < closestdist )
                    {
                        botcandidate = player;
                        closestdist = var_95aa9bf34724d204;
                    }
                }
            }
            
            if ( isdefined( var_56fd2381f5d8be13 ) )
            {
                return var_56fd2381f5d8be13;
            }
        }
        else
        {
            foreach ( player in teammates )
            {
                if ( function_565fe04ba8abb6bd( player ) )
                {
                    return player;
                }
                
                if ( isvalidspectatetarget( player ) )
                {
                    botcandidate = player;
                }
            }
        }
    }
    
    return botcandidate;
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0xe34ebb90, Offset: 0x99f
// Size: 0xd4
function balancespectators( victim )
{
    playertospectate = undefined;
    var_a3343ca6f7223e15 = level.players.size;
    
    foreach ( player in level.players )
    {
        if ( player != victim && function_565fe04ba8abb6bd( player ) )
        {
            spectators = br_spectate::getspectatorsofplayer( player );
            
            if ( spectators.size < var_a3343ca6f7223e15 )
            {
                var_a3343ca6f7223e15 = spectators.size;
                playertospectate = player;
            }
        }
    }
    
    return playertospectate;
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0x78285aea, Offset: 0xa7c
// Size: 0x39, Type: bool
function function_565fe04ba8abb6bd( player )
{
    if ( !isdefined( player ) || isai( player ) )
    {
        return false;
    }
    
    if ( !namespace_ef4547f85724edd1::isaliveplayer( player ) )
    {
        return false;
    }
    
    return !player.br_iseliminated;
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0x99592726, Offset: 0xabe
// Size: 0x2dc
function function_4d9a2c0a974d1a3b( immediate )
{
    uibots = manager::function_cda6de7e2ba52066();
    teammembers = teams::getteamdata( self.team, "players" );
    
    if ( !immediate )
    {
        foreach ( member in teammembers )
        {
            if ( !member bots_gametype_br_super::iseliminated() && member != self )
            {
                return;
            }
        }
        
        foreach ( uibot in uibots )
        {
            if ( uibot.team == self.team )
            {
                return;
            }
        }
    }
    
    totalplayers = level.players.size;
    activeteams = [];
    
    for ( i = 0; i < totalplayers ; i++ )
    {
        player = level.players[ i ];
        
        if ( !player bots_gametype_br_super::iseliminated() && player.team != self.team )
        {
            activeteams[ player.team ] = 1;
        }
    }
    
    foreach ( uibot in uibots )
    {
        if ( uibot.team != self.team )
        {
            activeteams[ uibot.team ] = 1;
        }
    }
    
    place = activeteams.size + 1;
    
    foreach ( member in teammembers )
    {
        member.pers[ "br_place" ] = place;
    }
    
    self.pers[ "br_place" ] = place;
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0xd814a34b, Offset: 0xda2
// Size: 0x71
function onmarkplayeraseliminated_shared( player )
{
    player function_4d9a2c0a974d1a3b();
    player.pers[ "br_survival_time" ] = gettime() - level.starttime;
    
    if ( isdefined( player.pers[ "telemetry" ].is_early_disconnect ) )
    {
        player.pers[ "telemetry" ].is_early_disconnect = 0;
    }
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0x509e3cc4, Offset: 0xe1b
// Size: 0x15
function onmarkplayeraseliminated( player )
{
    onmarkplayeraseliminated_shared( player );
}

// Namespace br_gametype_vanilla
// Params 1
// Checksum 0x4725358c, Offset: 0xe38
// Size: 0x50
function onunmarkplayeraseliminated( player )
{
    player.pers[ "br_place" ] = 0;
    player.pers[ "br_survival_time" ] = 0;
    player.pers[ "telemetry" ].is_early_disconnect = 1;
}

// Namespace br_gametype_vanilla
// Params 0
// Checksum 0x7d41a7bc, Offset: 0xe90
// Size: 0x7b, Type: bool
function getrandomloadout()
{
    var_56bf4be9f69ec20e = 10;
    newclass = randomint( var_56bf4be9f69ec20e );
    
    if ( getomnvar( "ui_only_default_loadouts" ) == 1 )
    {
        var_c7ae6e52a0b243ce = 100;
        newclass += var_c7ae6e52a0b243ce;
    }
    
    newclasschoice = menus::getclasschoice( newclass );
    self.pers[ "class" ] = newclasschoice;
    self.class = newclasschoice;
    class::preloadandqueueclass( newclasschoice );
    return true;
}

// Namespace br_gametype_vanilla
// Params 2
// Checksum 0x15b96cbc, Offset: 0xf14
// Size: 0x31
function function_34627a6a319fd2a( player, usetoken )
{
    br_gulag::playergulagautowin( "vanillaKioskRevive", player, usetoken );
    
    if ( isdefined( self ) )
    {
        br_plunder::playersetplundercount( 0 );
    }
}

// Namespace br_gametype_vanilla
// Params 2
// Checksum 0x358b3ba9, Offset: 0xf4d
// Size: 0x5a
function function_32b846d3369552ec( var_81284df95fc81aba, var_f45803a2a6bbf870 )
{
    var_1ed28fe3362632ed = getdvarint( @"hash_2d936fb12b19ca30", 0 );
    
    if ( var_1ed28fe3362632ed )
    {
        counttime = clamp( var_81284df95fc81aba - var_f45803a2a6bbf870, 0, 65535 );
        setomnvar( "ui_match_start_countdown_not_reach_minplayer", int( counttime ) );
    }
}

