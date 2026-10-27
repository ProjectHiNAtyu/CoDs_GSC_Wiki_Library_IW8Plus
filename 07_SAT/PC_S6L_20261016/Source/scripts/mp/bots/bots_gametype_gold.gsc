// scripts\mp\bots\bots_gametype_gold.gsc  (hash_77be9390de038203.gscc) (size: 6793 Bytes / 0x1a89 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2621dfe0 (639754208)
// size ...... 6793 (0x1a89)
// includes .. 10  (offset: 0x1885)
// strings ... 20  (offset: 0x18d5)
// dev strs .. 2   (offset: 0x1a71)
// exports ... 16  (offset: 0x1081)
// cseg ...... 0x183 + 0xefe (0x1081)
// imports ... 43  (offset: 0x1301)
// animtree1 . 0   (offset: 0x1a89)
// animtree2 . 0   (offset: 0x1a89)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;

#namespace bots_gametype_gold;

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x3b15d2b9, Offset: 0x1a1
// Size: 0x1a
function main()
{
    setup_callbacks();
    setup_bot_gold();
    
    /#
        thread function_cf52e285d192723e();
    #/
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0xe4ce8965, Offset: 0x1c3
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_gold_think;
    autopilot::initialize( undefined, undefined, [ "bot_gold_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x510b2e50, Offset: 0x1fe
// Size: 0x161
function setup_bot_gold()
{
    bots_util::bot_waittill_bots_enabled();
    level.var_9f7d9385e5500fec[ "take_money" ] = &take_money_update;
    level.var_9f7d9385e5500fec[ "steal_money" ] = &steal_money_update;
    level.var_9f7d9385e5500fec[ "defend_own_moneypile" ] = &defend_own_moneypile_update;
    level.var_9f7d9385e5500fec[ "random_killer" ] = &random_killer_update;
    
    while ( !isdefined( level.var_9df6acf7b55732d0 ) )
    {
        wait 0.05;
    }
    
    level.axismoneypile = undefined;
    level.alliesmoneypile = undefined;
    
    foreach ( moneypile in level.var_9df6acf7b55732d0 )
    {
        if ( moneypile.ownerteam == "axis" )
        {
            level.axismoneypile = moneypile;
        }
        else if ( moneypile.ownerteam == "allies" )
        {
            level.alliesmoneypile = moneypile;
        }
        
        moneypile.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( moneypile, 1 );
    }
    
    thread function_1561c2e2aa6b9916();
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x1992e347, Offset: 0x367
// Size: 0xd1
function bot_gold_think()
{
    self notify( #"bot_gold_think" );
    self endon( #"bot_gold_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    level.allow_random_killers = randomint( 3 ) <= 1;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 0.05;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( self.role ) )
        {
            function_2d4b2301fad9aa04();
        }
        
        self [[ level.var_9f7d9385e5500fec[ self.role ] ]]();
    }
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0xbd86d5e4, Offset: 0x440
// Size: 0x15f
function function_2d4b2301fad9aa04()
{
    var_ba46d152c2ba2d15 = bots_gametype_common::bot_gametype_get_num_players_on_team( "allies" );
    var_2284d8cf6cc15b2e = bots_gametype_common::bot_gametype_get_num_players_on_team( "axis" );
    var_c4f6670843111167 = self.team == "allies" ? var_ba46d152c2ba2d15 : var_2284d8cf6cc15b2e;
    personality_type = level.bot_personality_type[ self.personality ];
    strategy_level = self botgetdifficultysetting( "strategyLevel" );
    
    if ( !isdefined( self.role ) )
    {
        if ( personality_type == "active" )
        {
            if ( var_c4f6670843111167 <= 3 )
            {
                bot_set_role( "take_money" );
            }
            else
            {
                random_choice = randomint( 3 );
                
                if ( random_choice == 2 && strategy_level > 0 && level.allow_random_killers )
                {
                    bot_set_role( "random_killer" );
                }
                else
                {
                    bot_set_role( "take_money" );
                }
            }
            
            return;
        }
        
        if ( personality_type == "stationary" )
        {
            if ( var_c4f6670843111167 <= 3 )
            {
                bot_set_role( "defend_own_moneypile" );
                return;
            }
            
            random_choice = randomint( 3 );
            
            if ( random_choice == 2 && strategy_level > 0 && level.allow_random_killers )
            {
                bot_set_role( "random_killer" );
                return;
            }
            
            bot_set_role( "defend_own_moneypile" );
        }
    }
}

// Namespace bots_gametype_gold
// Params 1
// Checksum 0xefd22120, Offset: 0x5a7
// Size: 0x4d
function bot_set_role( new_role )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    bots_scripted_defense::function_87e8deae08ce1a0();
    self botsetpathingstyle( undefined );
    self.prev_role = self.role;
    self.role = new_role;
    self notify( #"new_role" );
}

// Namespace bots_gametype_gold
// Params 2
// Checksum 0x14fb500a, Offset: 0x5fc
// Size: 0xc9
function function_dd2f264dedb683ec( team, role )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( game_utility_common::isteamparticipant( player ) && player.role == role && player.team == team )
        {
            players[ players.size ] = player;
        }
    }
    
    return players.size;
}

// Namespace bots_gametype_gold
// Params 1
// Checksum 0x1986915f, Offset: 0x6ce
// Size: 0x4f
function function_97bf186bf6f531dd( moneypile )
{
    for ( i = 0; i < 10 ; i++ )
    {
        tacpoint = utility::array_random( moneypile.tacpoints );
        
        if ( navistacpointreachable( self, tacpoint ) )
        {
            return tacpoint;
        }
    }
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x31585cd0, Offset: 0x725
// Size: 0x17e
function take_money_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    var_a54bf2b362cfb1f0 = 0;
    var_76ba581c07e93416 = level.var_5ec855597cca078c[ level.var_26f0ef458768b0d0 ];
    
    if ( self.currentmoney < self.maxmoney )
    {
        moneypile_goal = function_97bf186bf6f531dd( var_76ba581c07e93416 );
        
        if ( isdefined( moneypile_goal ) )
        {
            self botsetpathingstyle( "objective" );
            var_a54bf2b362cfb1f0 = self botsetscriptgoal( moneypile_goal, 16, "critical" );
        }
    }
    
    if ( !var_a54bf2b362cfb1f0 )
    {
        return;
    }
    
    pathresult = bots_util::bot_waittill_goal_or_fail();
    
    if ( pathresult == "goal" )
    {
        self botsetstance( "crouch" );
        wait level.neutralcapturetime * ( self.maxmoney - self.currentmoney );
        self botclearscriptgoal();
        self botsetstance( "stand" );
        ownmoneypile = self.team == "axis" ? level.axismoneypile : level.alliesmoneypile;
        moneypile_goal = function_97bf186bf6f531dd( ownmoneypile );
        
        if ( isdefined( moneypile_goal ) )
        {
            self botsetscriptgoal( moneypile_goal, 16, "critical" );
            pathresult = bots_util::bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                succeeded = function_fbacbcbabef14ea5( level.teampiledroptime * self.currentmoney );
                
                if ( succeeded )
                {
                    self botclearscriptgoal();
                }
            }
        }
    }
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x4cf7a6de, Offset: 0x8ab
// Size: 0x18c
function steal_money_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        return;
    }
    
    var_f45673ff14518494 = 0;
    enemypile = self.team == "axis" ? level.alliesmoneypile : level.axismoneypile;
    
    if ( self.currentmoney < self.maxmoney )
    {
        moneypile_goal = function_97bf186bf6f531dd( enemypile );
        
        if ( isdefined( moneypile_goal ) )
        {
            self botsetpathingstyle( "objective" );
            var_f45673ff14518494 = self botsetscriptgoal( moneypile_goal, 16, "critical" );
        }
    }
    
    if ( !var_f45673ff14518494 )
    {
        return;
    }
    
    pathresult = bots_util::bot_waittill_goal_or_fail();
    
    if ( pathresult == "goal" )
    {
        self botsetstance( "crouch" );
        wait level.enemycapturetime * ( self.maxmoney - self.currentmoney );
        self botclearscriptgoal();
        self botsetstance( "stand" );
        ownmoneypile = self.team == "axis" ? level.axismoneypile : level.alliesmoneypile;
        moneypile_goal = function_97bf186bf6f531dd( ownmoneypile );
        
        if ( isdefined( moneypile_goal ) )
        {
            self botsetscriptgoal( moneypile_goal, 16, "critical" );
            pathresult = bots_util::bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                succeeded = function_fbacbcbabef14ea5( level.teampiledroptime * self.currentmoney );
                
                if ( succeeded )
                {
                    self botclearscriptgoal();
                }
            }
        }
    }
}

// Namespace bots_gametype_gold
// Params 1
// Checksum 0x6c6e6f27, Offset: 0xa3f
// Size: 0x27, Type: bool
function function_fbacbcbabef14ea5( time )
{
    self botsetstance( "crouch" );
    wait time;
    self botsetstance( "stand" );
    return true;
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0x94fa67b, Offset: 0xa6f
// Size: 0xa7
function defend_own_moneypile_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        return;
    }
    
    ownmoneypile = self.team == "axis" ? level.axismoneypile : level.alliesmoneypile;
    moneypile_goal = function_97bf186bf6f531dd( ownmoneypile );
    
    if ( isdefined( moneypile_goal ) )
    {
        self botsetscriptgoal( moneypile_goal, 20, "critical" );
        pathresult = bots_util::bot_waittill_goal_or_fail();
        
        if ( pathresult == "goal" )
        {
            self botclearscriptgoal();
            bots_scripted_defense::protect_point( ownmoneypile.origin, 250 );
        }
    }
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0xb124b77, Offset: 0xb1e
// Size: 0x2b
function random_killer_update()
{
    self endon( #"new_role" );
    
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
    
    self [[ self.personality_update_function ]]();
}

// Namespace bots_gametype_gold
// Params 0
// Checksum 0xedd9bc70, Offset: 0xb51
// Size: 0x380
function function_1561c2e2aa6b9916()
{
    level notify( #"hash_26e75233bb8f8673" );
    level endon( #"hash_26e75233bb8f8673" );
    level endon( #"game_ended" );
    neartimelimit = 0;
    nearscorelimit = 0;
    
    while ( true )
    {
        if ( level.timelimit != 0 && ( game_utility_mp::gettimelimit() - 60 ) * 1000 <= game_utility::gettimepassed() && !neartimelimit )
        {
            neartimelimit = 1;
            
            foreach ( player in level.players )
            {
                if ( !isai( player ) )
                {
                    continue;
                }
                
                if ( player.role != "take_money" )
                {
                    player thread bot_set_role( "take_money" );
                }
            }
        }
        
        if ( neartimelimit )
        {
            break;
        }
        
        foreach ( team in level.teamnamelist )
        {
            foreach ( player in level.players )
            {
                if ( !isai( player ) )
                {
                    continue;
                }
                
                if ( player.team != team )
                {
                    if ( game[ "teamScores" ][ team ] >= 25 )
                    {
                        if ( function_dd2f264dedb683ec( player.team, "steal_money" ) <= 3 && player.role != "steal_money" && player.role != "defend_own_moneypile" )
                        {
                            player thread bot_set_role( "steal_money" );
                        }
                    }
                    else if ( player.role == "steal_money" )
                    {
                        player thread bot_set_role( player.prev_role );
                    }
                }
                
                if ( game[ "teamScores" ][ team ] >= game_utility_mp::getscorelimit() - 10 )
                {
                    nearscorelimit = 1;
                    
                    if ( player.team == team )
                    {
                        if ( function_dd2f264dedb683ec( team, "defend_own_moneypile" ) <= 3 && player.role != "defend_own_moneypile" )
                        {
                            player thread bot_set_role( "defend_own_moneypile" );
                        }
                        else if ( function_dd2f264dedb683ec( team, "take_money" ) <= 1 && player.role != "take_money" && player.role != "defend_own_moneypile" )
                        {
                            player thread bot_set_role( "take_money" );
                        }
                        
                        continue;
                    }
                    
                    if ( player.role != "steal_money" )
                    {
                        player thread bot_set_role( "steal_money" );
                    }
                }
            }
        }
        
        if ( nearscorelimit )
        {
            break;
        }
        
        wait 0.5;
    }
}

/#

    // Namespace bots_gametype_gold
    // Params 0
    // Checksum 0xf32fbe88, Offset: 0xed9
    // Size: 0x1a8, Type: dev
    function function_cf52e285d192723e()
    {
        while ( !isdefined( level.bot_gametype_precaching_done ) )
        {
            wait 0.05;
        }
        
        while ( true )
        {
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
            {
                foreach ( moneypile in level.var_9df6acf7b55732d0 )
                {
                    trigger_color = ( 0, 1, 0 );
                    
                    if ( moneypile.ownerteam == "<dev string:x24>" )
                    {
                        trigger_color = ( 1, 0, 0 );
                    }
                    else if ( moneypile.ownerteam == "<dev string:x29>" )
                    {
                        trigger_color = ( 0, 0, 1 );
                    }
                    
                    bots_debug::function_8777d84a0c0c5802( 1, moneypile, trigger_color, 1 );
                    
                    foreach ( tacpoint in moneypile.tacpoints )
                    {
                        bots_util_mp::bot_draw_cylinder( tacpoint.groundpos, 10, 10, 0.05, undefined, trigger_color, 1, 4 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
