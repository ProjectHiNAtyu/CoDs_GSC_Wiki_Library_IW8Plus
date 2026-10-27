// scripts\mp\bots\bots_gametype_sabattack.gsc  (hash_45b46fd500bf80b7.gscc) (size: 3915 Bytes / 0xf4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x711478e5 (1897167077)
// size ...... 3915 (0xf4b)
// includes .. 5   (offset: 0xe0b)
// strings ... 19  (offset: 0xe33)
// dev strs .. 0   (offset: 0xf4b)
// exports ... 12  (offset: 0x897)
// cseg ...... 0x195 + 0x702 (0x897)
// imports ... 30  (offset: 0xa77)
// animtree1 . 0   (offset: 0xf4b)
// animtree2 . 0   (offset: 0xf4b)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_personality;

#namespace bots_gametype_sabattack;

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xe333fa6, Offset: 0x1b3
// Size: 0x1b
function main()
{
    level.var_ae4d3fde002fedb4 = 1;
    setup_callbacks();
    setup_bot_sabattack();
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xbb6a3247, Offset: 0x1d6
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_sabattack_think;
    autopilot::initialize( undefined, undefined, [ "bot_sabattack_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xe4f50c1a, Offset: 0x211
// Size: 0x6b
function setup_bot_sabattack()
{
    level.var_3960077147cbbf4[ "take_flag" ] = &take_flag_update;
    level.var_3960077147cbbf4[ "capture_flag" ] = &capture_flag_update;
    level.var_3960077147cbbf4[ "defend_flag_carrier" ] = &defend_flag_carrier_update;
    level.var_3960077147cbbf4[ "kill_flag_carrier" ] = &kill_flag_carrier_update;
    level.var_3960077147cbbf4[ "defend_zone" ] = &defend_zone_update;
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0x5f49ddd4, Offset: 0x284
// Size: 0x12a
function bot_sabattack_think()
{
    self notify( #"bot_sabattack_think" );
    self endon( #"bot_sabattack_think" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
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
        
        wait 0.5;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( self.role ) )
        {
            function_f49997a97d5ca32a();
        }
        else if ( level.flagcarrier == self )
        {
            thread bot_set_role( "capture_flag" );
        }
        
        assert( isdefined( self.role ) );
        
        if ( isdefined( self.role ) )
        {
            role_func = level.var_3960077147cbbf4[ self.role ];
            assert( isdefined( role_func ), self.role );
            
            if ( isdefined( role_func ) )
            {
                self [[ role_func ]]();
            }
        }
    }
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0x87f51f66, Offset: 0x3b6
// Size: 0x6f
function function_f49997a97d5ca32a()
{
    personality_type = level.bot_personality_type[ self.personality ];
    
    if ( !isdefined( self.role ) || !isdefined( level.flagcarrier ) )
    {
        if ( personality_type == "active" )
        {
            thread bot_set_role( "take_flag" );
            return;
        }
        
        if ( personality_type == "stationary" )
        {
            thread bot_set_role( "defend_zone" );
        }
    }
}

// Namespace bots_gametype_sabattack
// Params 1
// Checksum 0xc4a5ad57, Offset: 0x42d
// Size: 0x7b
function bot_set_role( new_role )
{
    self endon( #"death_or_disconnect" );
    self endon( #"new_role" );
    
    if ( !isai( self ) )
    {
        return;
    }
    
    self.bot_defending_zone = undefined;
    self botsetflag( "force_sprint", 0 );
    bots_scripted_defense::function_87e8deae08ce1a0();
    self botsetpathingstyle( undefined );
    self.prev_role = self.role;
    self.role = new_role;
    self notify( #"new_role" );
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0x5337ce15, Offset: 0x4b0
// Size: 0x12d
function take_flag_update()
{
    self notify( #"hash_c519d1245b5cab69" );
    self endon( #"hash_c519d1245b5cab69" );
    self endon( #"new_role" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( level.flagcarrier ) )
    {
        self botclearscriptgoal();
        
        if ( level.flagcarrier == self )
        {
            thread bot_set_role( "capture_flag" );
        }
        else if ( level.flagcarrier.team == self.team )
        {
            thread bot_set_role( "defend_flag_carrier" );
        }
        else
        {
            thread bot_set_role( "kill_flag_carrier" );
        }
        
        return;
    }
    
    if ( level.flagcarrier != self && isdefined( level.var_e4d7f49e8039a388.origin ) )
    {
        if ( !self bothasscriptgoal() )
        {
            self botsetscriptgoal( level.var_e4d7f49e8039a388.origin, 0, "critical" );
            bots_util::bot_waittill_goal_or_fail();
        }
        
        return;
    }
    
    current_goal_type = self botgetscriptgoaltype();
    
    if ( current_goal_type == "objective" || current_goal_type == "critical" )
    {
        self botclearscriptgoal();
    }
    
    bots_personality::update_personality_default();
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0x9c720a27, Offset: 0x5e5
// Size: 0xcc
function capture_flag_update()
{
    self notify( #"hash_d435367ff9665c43" );
    self endon( #"hash_d435367ff9665c43" );
    self endon( #"new_role" );
    self endon( #"death_or_disconnect" );
    self botsetflag( "force_sprint", 1 );
    
    if ( !self bothasscriptgoal() && level.flagcarrier == self )
    {
        zonearray = self.team == game[ "attackers" ] ? level.axiszone : level.allieszone;
        zone_origin = utility::array_random( zonearray ).origin;
        self botsetscriptgoal( zone_origin, 0, "critical" );
        bots_util::bot_waittill_goal_or_fail();
        return;
    }
    
    thread bot_set_role( "take_flag" );
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xdb5a85b2, Offset: 0x6b9
// Size: 0x65
function defend_flag_carrier_update()
{
    self notify( #"hash_401ba89ed2a85b49" );
    self endon( #"hash_401ba89ed2a85b49" );
    self endon( #"new_role" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( level.flagcarrier ) )
    {
        self botsetflag( "force_sprint", 1 );
        self botclearscriptgoal();
        bots_scripted_defense::guard_player( level.flagcarrier, 400 );
    }
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xa16715ae, Offset: 0x726
// Size: 0x8b
function kill_flag_carrier_update()
{
    self notify( #"hash_f55f6678995a7b5d" );
    self endon( #"hash_f55f6678995a7b5d" );
    self endon( #"new_role" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( level.flagcarrier ) && isdefined( level.flagcarrier.botorigin ) )
    {
        self botsetflag( "force_sprint", 1 );
        self botsetscriptgoal( level.flagcarrier.botorigin, 16, "objective" );
        self botsetobjectiveradius( 10 );
    }
}

// Namespace bots_gametype_sabattack
// Params 0
// Checksum 0xdd46846a, Offset: 0x7b9
// Size: 0xde
function defend_zone_update()
{
    self notify( #"hash_c465c3048e3a6b56" );
    self endon( #"hash_c465c3048e3a6b56" );
    self endon( #"new_role" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.bot_defending_zone ) || !bots_scripted_defense::is_defending_point( self.bot_defending_zone.origin ) )
    {
        zonearray = self.team == game[ "defenders" ] ? level.axiszone : level.allieszone;
        self.bot_defending_zone = utility::array_random( zonearray );
        optional_params[ "score_flags" ] = "strict_los";
        bots_scripted_defense::function_87e8deae08ce1a0();
        bots_scripted_defense::protect_point( self.bot_defending_zone.origin, 200, optional_params );
    }
}

