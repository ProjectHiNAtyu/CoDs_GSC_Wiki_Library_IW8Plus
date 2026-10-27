// scripts\mp\bots\bots_gametype_siege.gsc  (hash_792c3f29e9856caa.gscc) (size: 3119 Bytes / 0xc2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6600d815 (1711331349)
// size ...... 3119 (0xc2f)
// includes .. 8   (offset: 0xb8b)
// strings ... 8   (offset: 0xbcb)
// dev strs .. 0   (offset: 0xc2f)
// exports ... 8   (offset: 0x75b)
// cseg ...... 0xea + 0x671 (0x75b)
// imports ... 26  (offset: 0x89b)
// animtree1 . 0   (offset: 0xc2f)
// animtree2 . 0   (offset: 0xc2f)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_war;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;

#namespace bots_gametype_siege;

// Namespace bots_gametype_siege
// Params 0
// Checksum 0x1e2244df, Offset: 0x108
// Size: 0x37
function main()
{
    setup_callbacks();
    
    if ( level.isgroundwarsiege )
    {
        bots_gametype_war::setup_bot_war();
        return;
    }
    
    thread bot_siege_manager_think();
    setup_bot_siege();
    
    /#
        thread function_834eaf129e57167b();
    #/
}

// Namespace bots_gametype_siege
// Params 0
// Checksum 0x4070d066, Offset: 0x147
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_siege_think;
    autopilot::initialize( undefined, undefined, [ "bot_siege_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_siege
// Params 0
// Checksum 0x25ad7b89, Offset: 0x182
// Size: 0xd
function setup_bot_siege()
{
    level.bot_gametype_precaching_done = 1;
}

/#

    // Namespace bots_gametype_siege
    // Params 0
    // Checksum 0xb5123abb, Offset: 0x197
    // Size: 0x106, Type: dev
    function function_834eaf129e57167b()
    {
        while ( !isdefined( level.bot_gametype_precaching_done ) )
        {
            wait 0.05;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_371d0b254090fbda", 0 ) == 1 )
            {
                foreach ( player in level.participants )
                {
                    if ( isai( player ) && isdefined( player.goalflag ) && player player::isreallyalive() )
                    {
                        line( player.origin, gameobjects_shared::get_origin( player.goalflag ), ( 0, 255, 0 ), 1, 0, 1 );
                    }
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace bots_gametype_siege
// Params 0
// Checksum 0x68848cc7, Offset: 0x2a5
// Size: 0x2cc
function bot_siege_manager_think()
{
    level.siege_bot_team_need_flags = [];
    flags::gameflagwait( "prematch_done" );
    level.siege_bot_team_triple_cap_check = [];
    level.siege_bot_team_had_advantage = [];
    
    for ( ;; )
    {
        level.siege_bot_team_need_flags = [];
        
        foreach ( player in level.players )
        {
            if ( !player::isreallyalive( player ) && player.hasspawned )
            {
                if ( player.team != "spectator" && player.team != "neutral" )
                {
                    level.siege_bot_team_need_flags[ player.team ] = 1;
                }
            }
        }
        
        flagcounts = [];
        
        foreach ( objective in level.objectives )
        {
            team = objective gameobjects::getownerteam();
            
            if ( team != "neutral" )
            {
                if ( !isdefined( flagcounts[ team ] ) )
                {
                    flagcounts[ team ] = 1;
                    continue;
                }
                
                flagcounts[ team ]++;
            }
        }
        
        foreach ( team, count in flagcounts )
        {
            if ( count >= 2 )
            {
                enemyteam = team_utility::getotherteam( team );
                level.siege_bot_team_need_flags[ enemyteam ] = 1;
                
                if ( count == 2 && !level.siege_bot_team_triple_cap_check[ team ] )
                {
                    if ( randomint( 100 ) > 75 )
                    {
                        level.siege_bot_team_need_flags[ team ] = 1;
                    }
                    else
                    {
                        level.siege_bot_team_triple_cap_check[ team ] = 0;
                    }
                    
                    level.siege_bot_team_had_advantage[ team ] = 1;
                }
                
                continue;
            }
            
            if ( count < 2 && level.siege_bot_team_had_advantage[ team ] )
            {
                level.siege_bot_team_had_advantage[ team ] = 0;
                level.siege_bot_team_triple_cap_check[ team ] = 0;
            }
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_siege
// Params 0
// Checksum 0xe7b0b651, Offset: 0x579
// Size: 0xca
function bot_siege_think()
{
    self notify( #"bot_siege_think" );
    self endon( #"bot_siege_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    while ( !isdefined( level.siege_bot_team_need_flags ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
    for ( ;; )
    {
        if ( level.siege_bot_team_need_flags[ self.team ] )
        {
            bot_choose_flag();
        }
        else if ( isdefined( self.goalflag ) )
        {
            if ( bots_scripted_defense::is_defending() )
            {
                bots_scripted_defense::function_87e8deae08ce1a0();
            }
            
            self.goalflag = undefined;
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_siege
// Params 0
// Checksum 0x804c3ada, Offset: 0x64b
// Size: 0x110
function bot_choose_flag()
{
    goalflag = undefined;
    shortestdistsq = undefined;
    
    foreach ( objective in level.objectives )
    {
        team = objective gameobjects::getownerteam();
        
        if ( team != self.team )
        {
            var_32c3907b14e9b33d = distancesquared( self.origin, gameobjects_shared::get_origin( objective ) );
            
            if ( !isdefined( shortestdistsq ) || var_32c3907b14e9b33d < shortestdistsq )
            {
                shortestdistsq = var_32c3907b14e9b33d;
                goalflag = objective;
            }
        }
    }
    
    if ( isdefined( goalflag ) )
    {
        if ( self.goalflag != goalflag )
        {
            self.goalflag = goalflag;
            bots_scripted_defense::capture_point( gameobjects_shared::get_origin( goalflag ), 100 );
        }
    }
}

