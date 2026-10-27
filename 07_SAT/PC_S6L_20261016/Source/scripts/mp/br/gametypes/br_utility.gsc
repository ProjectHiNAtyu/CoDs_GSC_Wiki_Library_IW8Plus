// scripts\mp\br\gametypes\br_utility.gsc  (hash_4b19eeae27382e36.gscc) (size: 7167 Bytes / 0x1bff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbba8da49 (3148405321)
// size ...... 7167 (0x1bff)
// includes .. 15  (offset: 0x1937)
// strings ... 41  (offset: 0x19af)
// dev strs .. 0   (offset: 0x1bff)
// exports ... 13  (offset: 0x120b)
// cseg ...... 0x2fb + 0xf10 (0x120b)
// imports ... 39  (offset: 0x1413)
// animtree1 . 0   (offset: 0x1bff)
// animtree2 . 0   (offset: 0x1bff)
#using script_23eca243497ca70a;
#using script_26ccbfe3954cacf4;
#using script_72af5a878a9d3397;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\team_assimilation;
#using scripts\mp\teams;

#namespace br_utility;

// Namespace br_utility
// Params 1
// Checksum 0x56c78765, Offset: 0x319
// Size: 0x119
function rankedquittimer( var_44ec8742923b025a )
{
    player = self;
    level endon( #"all_players_dead" );
    player endon( #"hash_130e88385e40bf77" );
    player endon( #"disconnect" );
    player notify( #"hash_24654fc349409dbc" );
    player endon( #"hash_24654fc349409dbc" );
    
    if ( teams::getactiveteamcount() > 1 )
    {
        remainingtime = var_44ec8742923b025a ? 3000 : 180000;
        var_432a92718eed7cc8 = istrue( var_44ec8742923b025a );
        timestart = gettime();
        timeend = timestart + remainingtime;
        
        while ( remainingtime > 0 )
        {
            player setclientomnvar( "ui_league_play_br_leave_penalty_timer", int( remainingtime ) );
            remainingtime = timeend - gettime();
            
            if ( !var_432a92718eed7cc8 && br::isbrteameliminated( player.team ) )
            {
                var_432a92718eed7cc8 = 1;
                timeend = min( timeend, timestart + 3000 );
            }
            
            wait 1;
        }
    }
    
    player setclientomnvar( "ui_league_play_br_leave_penalty_timer", 0 );
    player setclientomnvar( "ui_league_play_br_can_leave_with_party", istrue( var_44ec8742923b025a ) );
}

// Namespace br_utility
// Params 0
// Checksum 0xedc4da87, Offset: 0x43a
// Size: 0x5
function function_610b0cb5697b361a()
{
    return 3000;
}

// Namespace br_utility
// Params 2
// Checksum 0x5efba6af, Offset: 0x448
// Size: 0x15c
function markplayeraseliminated( player, context )
{
    if ( player.br_iseliminated )
    {
        return;
    }
    
    player function_acf2b6ad8c6dfd5a( 1, context );
    player.br_iseliminated = 1;
    player.br_eliminatedtime = gettime();
    player br_public::function_7813786b92d850ff( 1 );
    level notify( #"br_player_eliminated" );
    
    if ( level.var_309e3d9dac389de6 )
    {
        player setclientomnvar( "ui_leagueplay_allow_quit", 0 );
        player setclientomnvar( "ui_league_play_br_leave_penalty_timer", 180000 );
        player thread rankedquittimer( br::isbrteameliminated( player.team ) );
    }
    
    namespace_ddca46d216b096e2::onmarkplayeraseliminated( player, 1 );
    utility::callsharedfunc( #"gametype", #"onmarkplayeraseliminated", player );
    thread br_contract_manager::function_ec8e0db9b18cc122( self );
    canrespawn = utility::callsharedfunc( #"gametype", #"playershouldrespawn" ) || level.brgametype.respawnenable || level.useautorespawn;
    
    if ( game_utility::getgametype() != "zxp" && !canrespawn && isai( player ) )
    {
        player thread bots_gametype_br_super::function_7fb069819a6ed860();
    }
    
    player updateplayereliminatedomnvar( context );
    player gamelogic_mp::updateplayerleaderboardstats();
}

// Namespace br_utility
// Params 2
// Checksum 0x63a7e33a, Offset: 0x5ac
// Size: 0xac
function unmarkplayeraseliminated( player, context )
{
    player function_acf2b6ad8c6dfd5a( 0, context );
    player.br_iseliminated = 0;
    player.br_eliminatedtime = -1;
    player br_public::function_7813786b92d850ff( 0 );
    namespace_ddca46d216b096e2::onmarkplayeraseliminated( player, 0 );
    utility::callsharedfunc( #"gametype", #"onunmarkplayeraseliminated", player );
    player lower_message::setlowermessageomnvar( "clear_lower_msg" );
    player notify( #"hash_130e88385e40bf77" );
    player setclientomnvar( "ui_leagueplay_allow_quit", 3 );
    player setclientomnvar( "ui_league_play_br_leave_penalty_timer", -1 );
    player updateplayereliminatedomnvar( context );
}

// Namespace br_utility
// Params 1
// Checksum 0xbff12fca, Offset: 0x660
// Size: 0x56d
function updateplayereliminatedomnvar( context )
{
    player = self;
    packedvalue = 0;
    var_abd6eda442da0993 = 0;
    teammates = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
    var_44abc933a1765374 = br_public::function_ab5e009b1898c081();
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        var_44abc933a1765374 = team_assimilation::getmaxassimilationteamsize();
    }
    
    foreach ( member in teammates )
    {
        if ( getdvarint( @"scr_br_eliminated_debug_print", 0 ) )
        {
            if ( !isdefined( context ) )
            {
                context = "?";
            }
            
            logstring( "updatePlayerEliminatedOmnvar - time = " + gettime() + ", player = " + member.name + ", team = " + member.team + ", marked player = " + ( member == self ) + ", br_isEliminated = " + istrue( member.br_iseliminated ) + ", context = " + context + ", sessionuimemberindex = " + member.sessionuimemberindex );
        }
        
        assert( member.sessionuimemberindex <= var_44abc933a1765374 );
        
        if ( member.br_iseliminated )
        {
            packedvalue |= 1 << member.sessionuimemberindex;
        }
        
        if ( member.extracted )
        {
            var_abd6eda442da0993 |= 1 << member.sessionuimemberindex;
        }
    }
    
    foreach ( member in teammates )
    {
        member setclientomnvar( "ui_br_eliminated", packedvalue );
        member setclientomnvar( "ui_br_extracted", var_abd6eda442da0993 );
    }
    
    validgametype = !( isdefined( level.brgametype ) && ( level.brgametype.var_27018aab4e737fb3 || game_utility::getgametype() == "resurgence" ) ) && level.gametype != "ob" && level.gametype != "ob_rift_run";
    var_6fc85c0a8999baf9 = utility::callsharedfunc( #"gametype", #"hash_5ec07bb44d9babc6", {} );
    validgametype = validgametype && ( !isdefined( var_6fc85c0a8999baf9 ) || var_6fc85c0a8999baf9 );
    
    if ( level.matchmakingmatch && validgametype && !level.var_8d778b6ed49ccbc0 )
    {
        if ( getdvarint( @"hash_4c7f9021e6dc110d", 1 ) == 1 )
        {
            if ( teammates.size > 0 )
            {
                omnvarvalue = 2;
                
                foreach ( member in teammates )
                {
                    if ( isdefined( member ) && !member.br_iseliminated )
                    {
                        omnvarvalue = 0;
                        break;
                    }
                }
                
                foreach ( member in teammates )
                {
                    if ( member.extracted )
                    {
                        continue;
                    }
                    
                    member setclientomnvar( "ui_br_squad_eliminated_active", omnvarvalue );
                }
            }
            
            return;
        }
        
        fireteammembers = player getfireteammembers();
        
        if ( fireteammembers.size > 0 )
        {
            omnvarvalue = 2;
            
            foreach ( member in fireteammembers )
            {
                if ( isdefined( member ) && !member.br_iseliminated )
                {
                    omnvarvalue = 0;
                    break;
                }
            }
            
            if ( getdvarint( @"scr_br_eliminated_debug_print", 0 ) && omnvarvalue > 0 )
            {
                if ( !isdefined( context ) )
                {
                    context = "?";
                }
                
                logstring( "updatePlayerEliminatedOmnvar - time = " + gettime() + ", context = " + context + ", set ui_br_squad_eliminated_active to " + omnvarvalue );
            }
            
            player setclientomnvar( "ui_br_squad_eliminated_active", omnvarvalue );
            
            foreach ( member in fireteammembers )
            {
                member setclientomnvar( "ui_br_squad_eliminated_active", omnvarvalue );
            }
        }
    }
}

// Namespace br_utility
// Params 10
// Checksum 0x94522e9e, Offset: 0xbd5
// Size: 0x1a9
function function_98eeb9dcfa19a943( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( getdvarint( @"hash_11fa4c3ab4c1653d", 1 ) && !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        victimnum = "e?";
        meansofdeath = "m?";
        attackernum = "a?";
        inflictornum = "i?";
        attackerloc = "l?";
        
        if ( isdefined( self ) )
        {
            victimnum = self getentitynumber();
        }
        
        if ( isdefined( smeansofdeath ) )
        {
            meansofdeath = smeansofdeath;
        }
        
        if ( isdefined( attacker ) && !isstruct( attacker ) )
        {
            attackernum = attacker getentitynumber();
            attackerloc = "( " + attacker.origin[ 0 ] + "," + attacker.origin[ 1 ] + "," + attacker.origin[ 2 ] + " )";
        }
        
        if ( isdefined( einflictor ) )
        {
            inflictornum = einflictor getentitynumber();
        }
        
        stringref = "*-- Kill: " + gettime() + ", ";
        stringref += victimnum + ", ";
        stringref += meansofdeath + ", ";
        stringref += attackernum + ", ";
        stringref += inflictornum + ", ";
        stringref += attackerloc;
        logstring( stringref );
    }
}

// Namespace br_utility
// Params 2
// Checksum 0x2b064d9a, Offset: 0xd86
// Size: 0x96
function function_acf2b6ad8c6dfd5a( waseliminated, context )
{
    if ( getdvarint( @"hash_11fa4c3ab4c1653d", 1 ) && !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        stringref = ( waseliminated ? "*-- Mark: " : "*-- Unmark: " ) + gettime() + ", ";
        stringref += ( isdefined( self ) ? self getentitynumber() : "?" ) + ", ";
        stringref += context ?? "?";
        logstring( stringref );
    }
}

// Namespace br_utility
// Params 3
// Checksum 0x2f4a87d1, Offset: 0xe24
// Size: 0xa8
function function_309ab680afb1439e( wasadded, team, context )
{
    if ( getdvarint( @"hash_11fa4c3ab4c1653d", 1 ) && !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        stringref = ( wasadded ? "*-- Add: " : "*-- Remove: " ) + gettime() + ", ";
        stringref += ( isdefined( self ) ? self getentitynumber() : "?" ) + ", " + team + ", ";
        stringref += context ?? "none";
        logstring( stringref );
    }
}

// Namespace br_utility
// Params 1
// Checksum 0x20ebcb2a, Offset: 0xed4
// Size: 0x58
function printteameliminated( team )
{
    if ( getdvarint( @"hash_11fa4c3ab4c1653d", 1 ) && !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        stringref = "*-- Team Elim: " + gettime() + ", " + team;
        logstring( stringref );
    }
}

// Namespace br_utility
// Params 0
// Checksum 0xbe848f39, Offset: 0xf34
// Size: 0xe8
function function_1304786bb742a29c()
{
    index = 0;
    var_65aa5382054de4fe = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.team ) || player.team == "spectator" || player.team == "codcaster" )
        {
            continue;
        }
        
        if ( recycle_manager::isenabled() && player manager::isuibot() )
        {
            continue;
        }
        
        var_65aa5382054de4fe[ index ] = player;
        index++;
    }
    
    return var_65aa5382054de4fe;
}

// Namespace br_utility
// Params 0
// Checksum 0xd35a0690, Offset: 0x1025
// Size: 0x43
function function_a8021859c16f9008()
{
    if ( self isonascender() || self.var_c0b53846b1bfb648 || isdefined( self.var_38b04819cbeb9ab6 ) )
    {
        self dropoffascender();
        self notify( #"ascender_cancel" );
        self notify( #"ascender_solo_cancel" );
    }
}

// Namespace br_utility
// Params 0
// Checksum 0x880e610c, Offset: 0x1070
// Size: 0x19b
function function_287efb8e693e5711()
{
    if ( game_utility::getgametype() == "zonecontrol" )
    {
        return;
    }
    
    clusterscriptables = getentitylessscriptablearray( "zc_cluster", "targetname" );
    
    foreach ( cluster in clusterscriptables )
    {
        ents = getentarray( cluster.target, "targetname" );
        
        foreach ( ent in ents )
        {
            ent delete();
        }
        
        ents = getnoentvolumearray( cluster.target, "targetname" );
        
        foreach ( ent in ents )
        {
            ent delete();
        }
    }
}

