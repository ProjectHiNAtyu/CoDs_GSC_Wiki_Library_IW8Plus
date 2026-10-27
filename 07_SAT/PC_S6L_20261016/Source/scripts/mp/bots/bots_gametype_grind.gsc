// scripts\mp\bots\bots_gametype_grind.gsc  (hash_38d2f990e380b36b.gscc) (size: 4321 Bytes / 0x10e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d691c6b (2104040555)
// size ...... 4321 (0x10e1)
// includes .. 7   (offset: 0xfdd)
// strings ... 15  (offset: 0x1015)
// dev strs .. 0   (offset: 0x10e1)
// exports ... 10  (offset: 0xa11)
// cseg ...... 0x16e + 0x8a3 (0xa11)
// imports ... 35  (offset: 0xba1)
// animtree1 . 0   (offset: 0x10e1)
// animtree2 . 0   (offset: 0x10e1)
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_conf;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\gameobjects\gameobjects_shared;

#namespace bots_gametype_grind;

// Namespace bots_gametype_grind
// Params 0
// Checksum 0x7387e8ed, Offset: 0x18c
// Size: 0x10
function main()
{
    setup_callbacks();
    bots_gametype_conf::setup_bot_conf();
}

// Namespace bots_gametype_grind
// Params 0
// Checksum 0xad028768, Offset: 0x1a4
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_grind_think;
    autopilot::initialize( undefined, undefined, [ "bot_grind_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_grind
// Params 0
// Checksum 0x68b7eb88, Offset: 0x1df
// Size: 0x7b
function bot_grind_think()
{
    self notify( #"bot_grind_think" );
    self endon( #"bot_grind_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.grind_waiting_to_bank = 0;
    self.goal_zone = undefined;
    self.conf_camping_zone = 0;
    self.additional_tactical_logic_func = &bot_grind_extra_think;
    
    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        childthread enemy_watcher();
    }
    
    bots_gametype_conf::bot_conf_think();
}

// Namespace bots_gametype_grind
// Params 1
// Checksum 0xc7b45f97, Offset: 0x262
// Size: 0x15
function function_6517c103c5127ad0( player )
{
    return gameobjects_shared::function_5e4346091ac030c0( player, self );
}

// Namespace bots_gametype_grind
// Params 0
// Checksum 0xbfb6a116, Offset: 0x280
// Size: 0xb9, Type: bool
function function_36263d550982103f()
{
    if ( self.grind_waiting_to_bank && isdefined( self.goal_zone ) && !self.goal_zone function_6517c103c5127ad0( self ) )
    {
        self.grind_waiting_to_bank = 0;
        self.goal_zone = undefined;
        self notify( #"hash_c2262b9ba37ca127" );
        self botclearscriptgoal();
        return false;
    }
    
    if ( self.conf_camping_zone && isdefined( self.var_d4152f0537c85e9d ) && !self.var_d4152f0537c85e9d function_6517c103c5127ad0( self ) )
    {
        self.conf_camping_zone = 0;
        self.var_d4152f0537c85e9d = undefined;
        self notify( #"hash_efca53a2687cdf44" );
        self botclearscriptgoal();
        bots_personality::clear_camper_data();
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_grind
// Params 0
// Checksum 0xf3f12a01, Offset: 0x342
// Size: 0x440, Type: bool
function bot_grind_extra_think()
{
    if ( !function_36263d550982103f() )
    {
        return true;
    }
    
    if ( !isdefined( self.tag_getting ) )
    {
        if ( self.tagscarried > 0 )
        {
            bestdistsq = squared( 500 + self.tagscarried * 250 );
            
            if ( game[ "teamScores" ][ self.team ] + self.tagscarried >= level.roundscorelimit )
            {
                bestdistsq = squared( 5000 );
            }
            else if ( !isdefined( self.enemy ) && !bots_util::bot_in_combat() )
            {
                bestdistsq = squared( 1500 + self.tagscarried * 250 );
            }
            
            bestzone = undefined;
            
            foreach ( objective in level.objectives )
            {
                if ( !objective function_6517c103c5127ad0( self ) )
                {
                    continue;
                }
                
                distsq = distancesquared( self.origin, gameobjects_shared::get_origin( objective ) );
                
                if ( distsq < bestdistsq )
                {
                    bestdistsq = distsq;
                    bestzone = objective;
                }
            }
            
            if ( isdefined( bestzone ) )
            {
                set_new_goal = 1;
                
                if ( self.grind_waiting_to_bank )
                {
                    if ( self.goal_zone == bestzone )
                    {
                        set_new_goal = 0;
                    }
                }
                
                if ( set_new_goal )
                {
                    self.grind_waiting_to_bank = 1;
                    self.goal_zone = bestzone;
                    self botclearscriptgoal();
                    self notify( #"hash_c2262b9ba37ca127" );
                    self notify( #"hash_efca53a2687cdf44" );
                    self.conf_camping_zone = 0;
                    bots_personality::clear_camper_data();
                    bots_tactical_goals::abort_tactical_goal( "kill_tag" );
                    childthread bot_goto_zone( bestzone, "tactical" );
                }
            }
            
            if ( self.grind_waiting_to_bank )
            {
                if ( game[ "teamScores" ][ self.team ] + self.tagscarried >= level.roundscorelimit )
                {
                    self botsetflag( "force_sprint", 1 );
                }
                
                if ( self.tagscarried >= 4 )
                {
                    self botsetflag( "force_sprint", 1 );
                }
            }
        }
        else if ( self.grind_waiting_to_bank )
        {
            self.grind_waiting_to_bank = 0;
            self.goal_zone = undefined;
            self notify( #"hash_c2262b9ba37ca127" );
            self botclearscriptgoal();
        }
        
        if ( self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank )
        {
            bestdistsq = undefined;
            bestzone = undefined;
            
            foreach ( objective in level.objectives )
            {
                if ( !objective function_6517c103c5127ad0( self ) )
                {
                    continue;
                }
                
                distsq = distancesquared( self.origin, gameobjects_shared::get_origin( objective ) );
                
                if ( !isdefined( bestdistsq ) || distsq < bestdistsq )
                {
                    bestdistsq = distsq;
                    bestzone = objective;
                }
            }
            
            if ( isdefined( bestzone ) )
            {
                if ( bots_personality::should_select_new_ambush_point() )
                {
                    if ( bots_personality::find_ambush_tacpoint( gameobjects_shared::get_origin( bestzone ) ) )
                    {
                        self.conf_camping_zone = 1;
                        self.var_d4152f0537c85e9d = bestzone;
                        self notify( #"hash_c2262b9ba37ca127" );
                        self.grind_waiting_to_bank = 0;
                        self botclearscriptgoal();
                        childthread bot_camp_zone_grind( bestzone, "camp" );
                    }
                    else
                    {
                        self notify( #"hash_efca53a2687cdf44" );
                        self.conf_camping_zone = 0;
                        bots_personality::clear_camper_data();
                    }
                }
            }
            else
            {
                self.conf_camping_zone = 1;
            }
        }
    }
    else
    {
        self notify( #"hash_c2262b9ba37ca127" );
        self.grind_waiting_to_bank = 0;
        self.goal_zone = undefined;
        self notify( #"hash_efca53a2687cdf44" );
        self.conf_camping_zone = 0;
    }
    
    return self.grind_waiting_to_bank || self.conf_camping_zone;
}

// Namespace bots_gametype_grind
// Params 2
// Checksum 0x5ad5fd71, Offset: 0x78b
// Size: 0x81
function bot_goto_zone( zone, goal_type )
{
    self endon( #"hash_c2262b9ba37ca127" );
    
    if ( !isdefined( zone.calculated_nearest_tacpoint ) )
    {
        zone.nearest_tacpoint = findclosesttacpointinsight( gameobjects_shared::get_origin( zone ) );
        zone.calculated_nearest_tacpoint = 1;
    }
    
    var_e3fcf17716a8e688 = zone.nearest_tacpoint;
    self botsetscriptgoal( var_e3fcf17716a8e688, 32, goal_type );
    bots_util::bot_waittill_goal_or_fail();
}

// Namespace bots_gametype_grind
// Params 2
// Checksum 0x9e0e9e8a, Offset: 0x814
// Size: 0xff
function bot_camp_zone_grind( zone, goal_type )
{
    self endon( #"hash_efca53a2687cdf44" );
    self botsetscriptgoal( self.var_624c9f3d7225954, 0, goal_type, self.ambush_yaw );
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        if ( !isdefined( zone.calculated_nearest_tacpoint ) )
        {
            zone.nearest_tacpoint = findclosesttacpointinsight( gameobjects_shared::get_origin( zone ) );
            zone.calculated_nearest_tacpoint = 1;
        }
        
        var_e3fcf17716a8e688 = zone.nearest_tacpoint;
        
        if ( isdefined( var_e3fcf17716a8e688 ) )
        {
            var_ee2b73b69a2b2e6f = self getnearesttacpoint();
            
            if ( isdefined( var_ee2b73b69a2b2e6f ) )
            {
                var_75ed9ce4d5888c0f = bots_util::function_f3e86dad4d2f79dc( "bot_camp_zone_grind -> tacpoint nearest bot", var_ee2b73b69a2b2e6f );
            }
            else
            {
                var_75ed9ce4d5888c0f = bots_util::function_f3e86dad4d2f79dc( "bot_camp_zone_grind -> self origin", self.origin );
            }
            
            var_75ed9ce4d5888c0f[ var_75ed9ce4d5888c0f.size ] = var_e3fcf17716a8e688;
            childthread bots_util_mp::bot_watch_tacpoints( var_75ed9ce4d5888c0f );
        }
    }
}

// Namespace bots_gametype_grind
// Params 0
// Checksum 0x84677b66, Offset: 0x91b
// Size: 0xf6
function enemy_watcher()
{
    self.default_meleechargedist = self botgetdifficultysetting( "meleeChargeDist" );
    
    while ( true )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) < 2 )
        {
            wait 0.5;
        }
        else
        {
            wait 0.2;
        }
        
        if ( isplayer( self.enemy ) && isdefined( self.enemy.tagscarried ) && self.enemy.tagscarried >= 3 && self botcanseeentity( self.enemy ) && distance( self.origin, self.enemy.origin ) <= 500 )
        {
            self botsetdifficultysetting( "meleeChargeDist", 500 );
            self botsetflag( "prefer_melee", 1 );
            continue;
        }
        
        self botsetdifficultysetting( "meleeChargeDist", self.default_meleechargedist );
        self botsetflag( "prefer_melee", 0 );
    }
}

