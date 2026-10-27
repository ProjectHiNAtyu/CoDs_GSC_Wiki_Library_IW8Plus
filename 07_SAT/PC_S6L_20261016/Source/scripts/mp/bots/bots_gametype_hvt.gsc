// scripts\mp\bots\bots_gametype_hvt.gsc  (hash_4cc516d98dd40da7.gscc) (size: 3605 Bytes / 0xe15 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fa4a281 (1336189569)
// size ...... 3605 (0xe15)
// includes .. 6   (offset: 0xd3d)
// strings ... 12  (offset: 0xd6d)
// dev strs .. 1   (offset: 0xe09)
// exports ... 12  (offset: 0x6f9)
// cseg ...... 0x13a + 0x5bf (0x6f9)
// imports ... 38  (offset: 0x8d9)
// animtree1 . 0   (offset: 0xe15)
// animtree2 . 0   (offset: 0xe15)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\utility\team_utility;

#namespace bots_gametype_hvt;

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x8f690a3b, Offset: 0x158
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_hvt();
}

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x789d371e, Offset: 0x170
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_hvt_think;
    autopilot::initialize( undefined, undefined, [ "bot_hvt_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x6cc65e6b, Offset: 0x1ab
// Size: 0x56
function setup_bot_hvt()
{
    level.bot_gametype_attacker_limit_for_team = &function_20fe4ae990f420;
    level.bot_gametype_defender_limit_for_team = &function_cedeeecfc2b47dac;
    level.bot_gametype_allied_attackers_for_team = &function_26651d8c4fefa4ac;
    level.bot_gametype_allied_defenders_for_team = &function_d1c09da1050c6394;
    level.var_2ad52700d3f8deb1 = &function_80535384b274cdc0;
    level.var_aa1e78884fada2d1 = &function_80535384b274cdc0;
}

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x43448920, Offset: 0x209
// Size: 0x296
function bot_hvt_think()
{
    self notify( #"bot_hvt_think" );
    self endon( #"bot_hvt_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.next_flag_hide_time = 0;
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
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
        
        if ( self.ishvt )
        {
            self.role = undefined;
            
            if ( gettime() > self.next_flag_hide_time )
            {
                clear_defend();
                tacpoints = function_a034a927128ada11( self.origin, 800, 0, 300, botgetmaxnumscoreitems() );
                hide_tacpoint = bots_util::function_ec1247a9311f67a4( "bot_hvt_think -> tacpoint pick hide anywhere", tacpoints, tacpoints.size * 0.15, "hide_anywhere" );
                
                if ( !isdefined( hide_tacpoint ) )
                {
                    hide_tacpoint = utility::array_random( tacpoints );
                }
                
                assert( isdefined( hide_tacpoint ) );
                var_74a9f49efde97961 = bots_util::bot_out_of_ammo();
                goaltype = var_74a9f49efde97961 ? "guard" : "critical";
                
                if ( var_74a9f49efde97961 && self botgetscriptgoaltype() == "critical" )
                {
                    self botclearscriptgoal();
                }
                
                success = self botsetscriptgoal( hide_tacpoint, 0, goaltype );
                
                if ( success )
                {
                    self.next_flag_hide_time = gettime() + 15000;
                }
            }
            
            continue;
        }
        
        if ( !isdefined( self.role ) )
        {
            bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
        }
        
        if ( self.role == "attacker" )
        {
            enemy_hvt = function_687f2aab4300b12f( team_utility::getotherteam( self.team ) );
            
            if ( isdefined( enemy_hvt ) )
            {
                clear_defend();
                
                if ( self botgetscriptgoaltype() == "critical" )
                {
                    self botclearscriptgoal();
                }
                
                self botsetscriptgoal( enemy_hvt.origin, 16, "objective" );
                self botsetobjectiveradius( 300 );
            }
            else
            {
                self.role = "defender";
            }
            
            continue;
        }
        
        assert( self.role == "<dev string:x24>" );
        allied_hvt = function_687f2aab4300b12f( self.team );
        
        if ( isdefined( allied_hvt ) )
        {
            if ( !bots_scripted_defense::function_737443eaedb33690() )
            {
                clear_defend();
                self botclearscriptgoal();
                
                if ( isdefined( allied_hvt ) )
                {
                    bots_scripted_defense::guard_player( allied_hvt, 500 );
                }
            }
            
            continue;
        }
        
        self.role = "attacker";
    }
}

// Namespace bots_gametype_hvt
// Params 1
// Checksum 0x6fe50650, Offset: 0x4a7
// Size: 0xb8
function function_687f2aab4300b12f( team )
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) && isdefined( player.team ) && player.team == team )
        {
            if ( player.ishvt )
            {
                return player;
            }
        }
    }
}

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x86fab5cf, Offset: 0x567
// Size: 0x12
function clear_defend()
{
    if ( bots_scripted_defense::is_defending() )
    {
        bots_scripted_defense::function_87e8deae08ce1a0();
    }
}

// Namespace bots_gametype_hvt
// Params 1
// Checksum 0x5ce05b5b, Offset: 0x581
// Size: 0x4f
function function_20fe4ae990f420( team )
{
    team_limit = bots_gametype_common::bot_gametype_get_num_players_on_team( team );
    var_627c67489ef17119 = team_limit - 1;
    var_794a5a0be98082d5 = var_627c67489ef17119 * 0.66;
    var_794a5a0be98082d5 = int( ceil( var_794a5a0be98082d5 ) );
    return var_794a5a0be98082d5;
}

// Namespace bots_gametype_hvt
// Params 1
// Checksum 0xf373b4c2, Offset: 0x5d9
// Size: 0x51
function function_cedeeecfc2b47dac( team )
{
    team_limit = bots_gametype_common::bot_gametype_get_num_players_on_team( team );
    var_627c67489ef17119 = team_limit - 1;
    var_794a5a0be98082d5 = function_20fe4ae990f420( team );
    var_f041ee501f08ef11 = var_627c67489ef17119 - var_794a5a0be98082d5;
    return var_f041ee501f08ef11;
}

// Namespace bots_gametype_hvt
// Params 1
// Checksum 0x7e20cde1, Offset: 0x633
// Size: 0x57
function function_26651d8c4fefa4ac( team )
{
    attack_origin = undefined;
    enemy_hvt = function_687f2aab4300b12f( team_utility::getotherteam( self.team ) );
    
    if ( isdefined( enemy_hvt ) )
    {
        attack_origin = enemy_hvt.origin;
    }
    
    return bots_gametype_common::bot_gametype_get_allied_attackers_for_team( team, attack_origin, 300 );
}

// Namespace bots_gametype_hvt
// Params 1
// Checksum 0x1d8ff30c, Offset: 0x693
// Size: 0x51
function function_d1c09da1050c6394( team )
{
    defend_origin = undefined;
    allied_hvt = function_687f2aab4300b12f( self.team );
    
    if ( isdefined( allied_hvt ) )
    {
        defend_origin = allied_hvt.origin;
    }
    
    return bots_gametype_common::bot_gametype_get_allied_defenders_for_team( team, defend_origin, 500 );
}

// Namespace bots_gametype_hvt
// Params 0
// Checksum 0x7154eb62, Offset: 0x6ed
// Size: 0xb
function function_80535384b274cdc0()
{
    return self.ishvt;
}

