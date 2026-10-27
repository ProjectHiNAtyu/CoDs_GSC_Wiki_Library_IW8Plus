// scripts\mp\bots\bots_gametype_tdef.gsc  (hash_014a05a9ac9613e6.gscc) (size: 6096 Bytes / 0x17d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa53a0427 (2772042791)
// size ...... 6096 (0x17d0)
// includes .. 5   (offset: 0x16d0)
// strings ... 10  (offset: 0x16f8)
// dev strs .. 0   (offset: 0x17d0)
// exports ... 19  (offset: 0xf28)
// cseg ...... 0xda + 0xe4e (0xf28)
// imports ... 37  (offset: 0x1220)
// animtree1 . 0   (offset: 0x17d0)
// animtree2 . 0   (offset: 0x17d0)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;

#namespace bots_gametype_tdef;

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x1461ca53, Offset: 0xf8
// Size: 0x17
function main()
{
    setup_callbacks();
    setup_bot_flag();
    thread monitor_flag_carrier();
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x148138ac, Offset: 0x117
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_tdef_think;
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0xd9cbeb8d, Offset: 0x136
// Size: 0x35
function setup_bot_flag()
{
    bots_util::bot_waittill_bots_enabled( 1 );
    level.protect_radius = 600;
    level.bodyguard_radius = 400;
    thread bot_flag_ai_director_update();
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x4028185d, Offset: 0x173
// Size: 0xb
function bot_get_tdef_flag()
{
    return level.defenderflag;
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x304f4910, Offset: 0x187
// Size: 0x2a
function bot_get_flag_carrier()
{
    var_7237854e3be197ca = level.defenderflag.carrier;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0xb6e7c24, Offset: 0x1b9
// Size: 0x1f
function bot_get_enemy_team()
{
    if ( self.team == "allies" )
    {
        return "axis";
    }
    
    return "allies";
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x173498a1, Offset: 0x1e1
// Size: 0x2d3
function bot_tdef_think()
{
    self notify( #"bot_flag_think" );
    self endon( #"bot_flag_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "disable_separation", 1 );
    var_551662f13d0e42ce = undefined;
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( self.role ) )
        {
            initialize_flag_role();
        }
        
        if ( bots_tactical_goals::has_tactical_goal() )
        {
            continue;
        }
        
        if ( self.role != "carrier" && isdefined( self.carryobject ) )
        {
            flag_set_role( "carrier" );
        }
        
        if ( self.role == "carrier" )
        {
            if ( isdefined( self.carryobject ) )
            {
                disttoenemysq = 0;
                
                if ( isdefined( self.enemy ) )
                {
                    disttoenemysq = distancesquared( self.enemy.origin, self.origin );
                }
                
                if ( isdefined( self.enemy ) && disttoenemysq < 9216 )
                {
                }
                
                self botclearscriptgoal();
                
                if ( !isdefined( var_551662f13d0e42ce ) )
                {
                    var_551662f13d0e42ce = gettime() + randomintrange( 500, 1000 );
                }
                
                if ( gettime() > var_551662f13d0e42ce )
                {
                    var_551662f13d0e42ce = gettime() + randomintrange( 500, 1000 );
                }
            }
            else
            {
                tdefflag = bot_get_tdef_flag();
                
                if ( !isdefined( tdefflag ) )
                {
                    carrier = bot_get_flag_carrier();
                    
                    if ( isdefined( carrier ) && carrier != self )
                    {
                        initialize_flag_role();
                    }
                }
                else
                {
                    self botsetscriptgoal( tdefflag.curorigin, 16, "objective" );
                    continue;
                }
            }
        }
        
        if ( self.role == "attacker" )
        {
            tdefflag = bot_get_tdef_flag();
            
            if ( !isdefined( tdefflag ) )
            {
                carrier = bot_get_flag_carrier();
                
                if ( isdefined( carrier ) )
                {
                    if ( !namespace_14346d439f44a158::is_guarding_player( carrier ) )
                    {
                        namespace_14346d439f44a158::guard_player( carrier, level.bodyguard_radius );
                    }
                }
            }
            else if ( !tdefflag.isresetting && !tdefflag.in_goal )
            {
                defend_point = getclosestpointonnavmesh( tdefflag.curorigin );
                
                if ( !namespace_14346d439f44a158::is_defending_point( defend_point ) )
                {
                    namespace_14346d439f44a158::protect_point( defend_point, level.protect_radius );
                }
            }
            
            continue;
        }
        
        if ( self.role == "defender" )
        {
            var_136305a25d2f15b4 = level.defenderflag.carrier;
            goal = var_136305a25d2f15b4.origin;
            
            /#
            #/
            
            if ( !namespace_14346d439f44a158::is_defending_point( goal ) )
            {
                namespace_14346d439f44a158::protect_point( goal, level.protect_radius );
            }
        }
    }
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0xaa0a05ad, Offset: 0x4bc
// Size: 0x25e
function initialize_flag_role()
{
    attackers = get_allied_attackers_for_team( self.team );
    defenders = get_allied_defenders_for_team( self.team );
    attacker_limit = flag_bot_attacker_limit_for_team( self.team );
    defender_limit = flag_bot_defender_limit_for_team( self.team );
    personality_type = level.bot_personality_type[ self.personality ];
    
    if ( personality_type == "active" )
    {
        if ( attackers.size >= attacker_limit )
        {
            var_789f7fcf69555bf8 = 0;
            
            foreach ( attacker in attackers )
            {
                if ( isai( attacker ) && level.bot_personality_type[ attacker.personality ] == "stationary" )
                {
                    attacker.role = undefined;
                    var_789f7fcf69555bf8 = 1;
                    break;
                }
            }
            
            if ( var_789f7fcf69555bf8 )
            {
                flag_set_role( "attacker" );
            }
            else
            {
                flag_set_role( "defender" );
            }
        }
        else
        {
            flag_set_role( "attacker" );
        }
        
        return;
    }
    
    if ( personality_type == "stationary" )
    {
        if ( defenders.size >= defender_limit )
        {
            var_789f7fcf69555bf8 = 0;
            
            foreach ( defender in defenders )
            {
                if ( isai( defender ) && level.bot_personality_type[ defender.personality ] == "active" )
                {
                    defender.role = undefined;
                    var_789f7fcf69555bf8 = 1;
                    break;
                }
            }
            
            if ( var_789f7fcf69555bf8 )
            {
                flag_set_role( "defender" );
            }
            else
            {
                flag_set_role( "attacker" );
            }
            
            return;
        }
        
        flag_set_role( "defender" );
    }
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0xe2d811a, Offset: 0x722
// Size: 0x388
function bot_flag_ai_director_update()
{
    level notify( #"bot_flag_ai_director_update" );
    level endon( #"bot_flag_ai_director_update" );
    level endon( #"game_ended" );
    teams[ 0 ] = "allies";
    teams[ 1 ] = "axis";
    var_1917c77998722dd9 = [];
    
    while ( true )
    {
        foreach ( team in teams )
        {
            attacker_limit = flag_bot_attacker_limit_for_team( team );
            defender_limit = flag_bot_defender_limit_for_team( team );
            attackers = get_allied_attackers_for_team( team );
            defenders = get_allied_defenders_for_team( team );
            
            if ( attackers.size > attacker_limit )
            {
                ai_attackers = [];
                removed_attacker = 0;
                
                foreach ( attacker in attackers )
                {
                    if ( isai( attacker ) )
                    {
                        if ( level.bot_personality_type[ attacker.personality ] == "stationary" )
                        {
                            attacker flag_set_role( "defender" );
                            removed_attacker = 1;
                            break;
                        }
                        
                        ai_attackers[ ai_attackers.size ] = attacker;
                    }
                }
                
                if ( !removed_attacker && ai_attackers.size > 0 )
                {
                    utility::array_random( ai_attackers ) flag_set_role( "defender" );
                }
            }
            
            if ( defenders.size > defender_limit )
            {
                ai_defenders = [];
                removed_defender = 0;
                
                foreach ( defender in defenders )
                {
                    if ( isai( defender ) )
                    {
                        if ( level.bot_personality_type[ defender.personality ] == "active" )
                        {
                            defender flag_set_role( "attacker" );
                            removed_defender = 1;
                            break;
                        }
                        
                        ai_defenders[ ai_defenders.size ] = defender;
                    }
                }
                
                if ( !removed_defender && ai_defenders.size > 0 )
                {
                    utility::array_random( ai_defenders ) flag_set_role( "attacker" );
                }
            }
            
            tdefflag = bot_get_tdef_flag();
            
            if ( isdefined( tdefflag ) )
            {
                idealcarrier = pick_flagcarrier( team, tdefflag );
                
                if ( isdefined( idealcarrier ) && isdefined( idealcarrier.role ) && idealcarrier.role != "carrier" )
                {
                    if ( !isdefined( idealcarrier.carryobject ) )
                    {
                        previouscarrier = var_1917c77998722dd9[ team ];
                        
                        if ( isdefined( previouscarrier ) )
                        {
                            previouscarrier flag_set_role( undefined );
                        }
                        
                        idealcarrier flag_set_role( "carrier" );
                        var_1917c77998722dd9[ idealcarrier.team ] = idealcarrier;
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0x3077fb95, Offset: 0xab2
// Size: 0x22
function flag_bot_attacker_limit_for_team( team )
{
    team_limit = flag_num_players_on_team( team );
    return team_limit;
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0x4434523d, Offset: 0xadd
// Size: 0xd, Type: bool
function flag_bot_defender_limit_for_team( team )
{
    return false;
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0xb4f35177, Offset: 0xaf3
// Size: 0xb9
function flag_num_players_on_team( team )
{
    num_on_team = 0;
    
    foreach ( player in level.participants )
    {
        if ( game_utility_common::isteamparticipant( player ) && isdefined( player.team ) && player.team == team )
        {
            num_on_team++;
        }
    }
    
    return num_on_team;
}

// Namespace bots_gametype_tdef
// Params 2
// Checksum 0x1b2325bc, Offset: 0xbb5
// Size: 0x143
function pick_flagcarrier( team, tdefflag )
{
    closestbot = undefined;
    closestdistsq = undefined;
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( player.team != team )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isai( player ) )
        {
            continue;
        }
        
        if ( player.role == "defender" )
        {
            continue;
        }
        
        distsq = distancesquared( player.origin, tdefflag.curorigin );
        
        if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            closestbot = player;
        }
    }
    
    var_7237854e3be197ca = closestbot;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0xcf05d1eb, Offset: 0xd00
// Size: 0x27
function get_allied_attackers_for_team( team )
{
    attackers = get_players_by_role( "attacker", team );
    return attackers;
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0xb983a6c, Offset: 0xd30
// Size: 0x27
function get_allied_defenders_for_team( team )
{
    defenders = get_players_by_role( "defender", team );
    return defenders;
}

// Namespace bots_gametype_tdef
// Params 1
// Checksum 0x7c58e133, Offset: 0xd60
// Size: 0x24
function flag_set_role( new_role )
{
    self.role = new_role;
    self botclearscriptgoal();
    namespace_14346d439f44a158::function_87e8deae08ce1a0();
}

// Namespace bots_gametype_tdef
// Params 2
// Checksum 0x98577358, Offset: 0xd8c
// Size: 0xf5
function get_players_by_role( role, team )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( isalive( player ) && game_utility_common::isteamparticipant( player ) && player.team == team && isdefined( player.role ) && player.role == role )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace bots_gametype_tdef
// Params 0
// Checksum 0x73b6df16, Offset: 0xe8a
// Size: 0x9e
function monitor_flag_carrier()
{
    level endon( #"game_ended" );
    last_carrier = undefined;
    
    while ( true )
    {
        carrier = bot_get_flag_carrier();
        
        if ( !( isdefined( last_carrier ) && isdefined( carrier ) ) || carrier != last_carrier )
        {
            if ( isdefined( last_carrier ) && last_carrier.threatbias == 505 )
            {
                last_carrier.threatbias = 0;
            }
            
            last_carrier = carrier;
        }
        
        if ( isdefined( carrier ) && carrier.threatbias == 0 )
        {
            carrier.threatbias = 505;
        }
        
        wait 0.05;
    }
}

