// scripts\common\bots\bots_scripted_defense.gsc  (hash_2105f331571342b9.gscc) (size: 21982 Bytes / 0x55de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63362b5f (1664494431)
// size ...... 21982 (0x55de)
// includes .. 5   (offset: 0x50de)
// strings ... 59  (offset: 0x5106)
// dev strs .. 19  (offset: 0x54fa)
// exports ... 50  (offset: 0x38ba)
// cseg ...... 0x5c3 + 0x32f7 (0x38ba)
// imports ... 124 (offset: 0x408a)
// animtree1 . 0   (offset: 0x55de)
// animtree2 . 0   (offset: 0x55de)
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;

#namespace bots_scripted_defense;

// Namespace bots_scripted_defense
// Params 3
// Checksum 0x7c7f7a, Offset: 0x5e1
// Size: 0x2f
function capture_point( point, radius, optional_params )
{
    thread function_f1e30a8a1a62aff0( point, radius, "capture", optional_params );
}

// Namespace bots_scripted_defense
// Params 4
// Checksum 0xd5208bc7, Offset: 0x618
// Size: 0xa2
function capture_zone( point, tacpoints, capture_object_or_ent, optional_params )
{
    assert( tacpoints.size > 0 );
    assert( isdefined( capture_object_or_ent ) );
    
    /#
        if ( !isdefined( tacpoints ) || tacpoints.size == 0 || !isdefined( capture_object_or_ent ) )
        {
            return;
        }
    #/
    
    if ( gettime() == self.var_da111b928f41119f )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    self.var_da111b928f41119f = gettime();
    optional_params[ "capture_object" ] = capture_object_or_ent;
    thread function_f1e30a8a1a62aff0( point, tacpoints, "capture_zone", optional_params );
}

// Namespace bots_scripted_defense
// Params 3
// Checksum 0x266cccd7, Offset: 0x6c2
// Size: 0x83
function protect_point( point, radius, optional_params )
{
    if ( !isdefined( optional_params[ "min_goal_time" ] ) )
    {
        optional_params[ "min_goal_time" ] = 12;
    }
    
    if ( !isdefined( optional_params[ "max_goal_time" ] ) )
    {
        optional_params[ "max_goal_time" ] = 18;
    }
    
    if ( gettime() == self.var_cc8c0c03df773ccc )
    {
        assertmsg( "<dev string:x73>" );
        return;
    }
    
    self.var_cc8c0c03df773ccc = gettime();
    thread function_f1e30a8a1a62aff0( point, radius, "protect", optional_params );
}

// Namespace bots_scripted_defense
// Params 4
// Checksum 0xa5d1357b, Offset: 0x74d
// Size: 0x7e
function protect_zone( tacpoints, defend_point, uniqueid, optional_params )
{
    if ( !isdefined( optional_params[ "min_goal_time" ] ) )
    {
        optional_params[ "min_goal_time" ] = 12;
    }
    
    if ( !isdefined( optional_params[ "max_goal_time" ] ) )
    {
        optional_params[ "max_goal_time" ] = 18;
    }
    
    if ( !isdefined( optional_params[ "random_stance" ] ) )
    {
        optional_params[ "random_stance" ] = 1;
    }
    
    optional_params[ "uniqueID" ] = uniqueid;
    thread function_f1e30a8a1a62aff0( defend_point, tacpoints, "protect_zone", optional_params );
}

// Namespace bots_scripted_defense
// Params 3
// Checksum 0x555efefe, Offset: 0x7d3
// Size: 0x5d
function patrol_area( point, radius, optional_params )
{
    if ( !isdefined( optional_params[ "min_goal_time" ] ) )
    {
        optional_params[ "min_goal_time" ] = 0;
    }
    
    if ( !isdefined( optional_params[ "max_goal_time" ] ) )
    {
        optional_params[ "max_goal_time" ] = 0.01;
    }
    
    thread function_f1e30a8a1a62aff0( point, radius, "patrol", optional_params );
}

// Namespace bots_scripted_defense
// Params 3
// Checksum 0x63c07d59, Offset: 0x838
// Size: 0x83
function guard_player( player, radius, optional_params )
{
    if ( !isdefined( optional_params[ "min_goal_time" ] ) )
    {
        optional_params[ "min_goal_time" ] = 15;
    }
    
    if ( !isdefined( optional_params[ "max_goal_time" ] ) )
    {
        optional_params[ "max_goal_time" ] = 20;
    }
    
    if ( gettime() == self.var_5406201abea46e0b )
    {
        assertmsg( "<dev string:xc3>" );
        return;
    }
    
    self.var_5406201abea46e0b = gettime();
    thread function_f1e30a8a1a62aff0( player, radius, "bodyguard", optional_params );
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0xd635c729, Offset: 0x8c3
// Size: 0x2c, Type: bool
function function_88c3e85a65496ae0( defense_type )
{
    if ( arraycontains( [ "protect_zone", "patrol" ], defense_type ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_scripted_defense
// Params 4
// Checksum 0x64874ddb, Offset: 0x8f8
// Size: 0xba0
function function_f1e30a8a1a62aff0( defendcenter, defendradius, defense_type, optional_params )
{
    self notify( #"hash_945ffa0940dbb39" );
    self endon( #"hash_945ffa0940dbb39" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_ee341639d000412d" );
    
    if ( gettime() == self.var_a2c26a73eb80ce70 )
    {
        assertmsg( "<dev string:x112>" );
        return;
    }
    
    if ( !isdefined( self getnearesttacpoint() ) )
    {
        wait 0.5;
    }
    
    /#
        if ( !game_utility_common::isaigameparticipant( self ) )
        {
            assertmsg( "<dev string:x16c>" + self.classname + "<dev string:x17d>" );
            return;
        }
    #/
    
    thread function_393801d08ec25cef();
    
    if ( isdefined( self.bot_defending ) || self botgetscriptgoaltype() == "camp" )
    {
        self botclearscriptgoal();
    }
    
    self.bot_defending = 1;
    self.bot_defending_type = defense_type;
    self.bot_defending_start_time = gettime();
    
    if ( defense_type == "capture_zone" )
    {
        self.bot_defending_radius = undefined;
        self.bot_defending_tacpoints = defendradius;
        self.bot_defending_game_object = optional_params[ "capture_object" ];
        assert( self.bot_defending_tacpoints.size > 0 );
        
        /#
            if ( !isdefined( self.bot_defending_tacpoints ) || self.bot_defending_tacpoints.size == 0 )
            {
                function_87e8deae08ce1a0();
            }
        #/
    }
    else if ( defense_type == "protect_zone" )
    {
        self.bot_defending_radius = undefined;
        self.bot_defending_tacpoints = defendradius;
        self.bot_defending_zone_id = optional_params[ "uniqueID" ];
        assert( isdefined( self.bot_defending_zone_id ) );
        assert( self.bot_defending_tacpoints.size > 0 );
        
        /#
            if ( !isdefined( self.bot_defending_tacpoints ) || self.bot_defending_tacpoints.size == 0 )
            {
                function_87e8deae08ce1a0();
            }
        #/
    }
    else
    {
        /#
            if ( isdefined( optional_params ) )
            {
                assert( !isdefined( optional_params[ "<dev string:x1f1>" ] ), "<dev string:x200>" );
            }
        #/
        
        self.bot_defending_radius = defendradius;
        self.bot_defending_tacpoints = undefined;
        self.bot_defending_game_object = undefined;
    }
    
    /#
        if ( function_88c3e85a65496ae0( defense_type ) && !isdefined( defendcenter ) )
        {
            assertmsg( "<dev string:x24d>" );
            function_87e8deae08ce1a0();
        }
    #/
    
    if ( game_utility_common::isgameparticipant( defendcenter ) )
    {
        self.bot_defend_player_guarding = defendcenter;
        childthread monitor_defend_player();
    }
    else
    {
        self.bot_defend_player_guarding = undefined;
        self.bot_defending_center = defendcenter;
    }
    
    /#
        if ( self.bot_defending_type == "<dev string:x28e>" )
        {
            if ( !isdefined( self.bot_defend_player_guarding ) || !game_utility_common::isgameparticipant( self.bot_defend_player_guarding ) )
            {
                assertmsg( "<dev string:x298>" + self.name + "<dev string:x29e>" );
            }
        }
    #/
    
    self botsetstance( "none" );
    goal_type = undefined;
    min_goal_time = 6;
    max_goal_time = 10;
    self.defense_score_flags = [];
    
    if ( isdefined( optional_params ) )
    {
        self.defend_entrance_index = optional_params[ "entrance_points_index" ];
        self.bot_defending_override_origin_tacpoint = optional_params[ "override_origin_tacpoint" ];
        
        if ( isdefined( optional_params[ "score_flags" ] ) )
        {
            if ( isarray( optional_params[ "score_flags" ] ) )
            {
                self.defense_score_flags = optional_params[ "score_flags" ];
            }
            else
            {
                self.defense_score_flags[ 0 ] = optional_params[ "score_flags" ];
            }
        }
        
        if ( isdefined( optional_params[ "override_goal_type" ] ) )
        {
            goal_type = optional_params[ "override_goal_type" ];
        }
        
        if ( isdefined( optional_params[ "min_goal_time" ] ) )
        {
            min_goal_time = optional_params[ "min_goal_time" ];
        }
        
        if ( isdefined( optional_params[ "max_goal_time" ] ) )
        {
            max_goal_time = optional_params[ "max_goal_time" ];
        }
        
        if ( optional_params[ "override_watch_tacpoints" ].size > 0 )
        {
            self.defense_override_watch_tacpoints = optional_params[ "override_watch_tacpoints" ];
        }
        
        self.defend_objective_radius = optional_params[ "objective_radius" ];
    }
    
    if ( !isdefined( self.bot_defend_player_guarding ) && function_88c3e85a65496ae0( defense_type ) )
    {
        nearest_tacpoint = undefined;
        
        if ( isdefined( optional_params[ "nearest_tacpoint_to_center" ] ) )
        {
            nearest_tacpoint = optional_params[ "nearest_tacpoint_to_center" ];
        }
        
        if ( !isdefined( nearest_tacpoint ) && isdefined( self.bot_defending_override_origin_tacpoint ) )
        {
            nearest_tacpoint = self.bot_defending_override_origin_tacpoint;
        }
        
        if ( !isdefined( nearest_tacpoint ) && isdefined( self.bot_defending_game_object ) && isdefined( self.bot_defending_game_object.nearest_tacpoint ) )
        {
            nearest_tacpoint = self.bot_defending_game_object.nearest_tacpoint;
        }
        
        if ( !isdefined( nearest_tacpoint ) )
        {
            nearest_tacpoint = findclosesttacpointinsight( get_valid_center() );
        }
        
        if ( !isdefined( nearest_tacpoint ) )
        {
            defend_center = get_valid_center();
            tacpoints = function_7801d05a86b06144( defend_center, 256, 0 );
            
            for ( i = 0; i < tacpoints.size ; i++ )
            {
                var_cbf6f96d37641654 = vectornormalize( tacpoints[ i ].groundpos - defend_center );
                trace_start = defend_center + var_cbf6f96d37641654 * 15;
                
                if ( sighttracepassed( trace_start, tacpoints[ i ].groundpos, 0, undefined ) )
                {
                    nearest_tacpoint = tacpoints[ i ];
                    break;
                }
                
                wait 0.05;
                
                if ( sighttracepassed( trace_start + ( 0, 0, 55 ), tacpoints[ i ].groundpos + ( 0, 0, 55 ), 0, undefined ) )
                {
                    nearest_tacpoint = tacpoints[ i ];
                    break;
                }
                
                wait 0.05;
            }
        }
        
        self.var_ed2c61ea014d90ab = nearest_tacpoint;
        assert( isdefined( self.var_ed2c61ea014d90ab ), "<dev string:x2c4>" + get_valid_center() );
    }
    else if ( isdefined( optional_params[ "nearest_tacpoint_to_center" ] ) )
    {
        self.var_ed2c61ea014d90ab = optional_params[ "nearest_tacpoint_to_center" ];
    }
    
    assert( min_goal_time < max_goal_time, "<dev string:x319>" );
    var_6c924a8f22acd54d = level.var_60b0dc5ab729292a[ defense_type ];
    
    if ( !isdefined( goal_type ) )
    {
        goal_type = "guard";
        
        if ( defense_type == "capture" || defense_type == "capture_zone" )
        {
            goal_type = "objective";
        }
    }
    
    var_b7a608b9ed51791e = 0;
    var_5ac4a3e3e2642965 = 0;
    
    if ( is_capturing() )
    {
        var_b7a608b9ed51791e = 1;
        var_5ac4a3e3e2642965 = isdefined( optional_params ) && isarray( optional_params[ "entrance_points_index" ] );
    }
    else if ( optional_params[ "random_stance" ] )
    {
        var_b7a608b9ed51791e = 1;
        var_5ac4a3e3e2642965 = 1;
    }
    
    var_e5c4d1f4c2205a6b = 1;
    
    if ( optional_params[ "dont_leave_goal_during_combat" ] )
    {
        var_e5c4d1f4c2205a6b = 0;
    }
    
    if ( defense_type == "protect" )
    {
        childthread protect_watch_allies();
    }
    
    for ( ;; )
    {
        waittillframeend();
        self.var_d8ee7fefe5ec03b7 = self.var_24c79f4f1d7b19ec;
        self.var_24c79f4f1d7b19ec = undefined;
        self.cur_defend_angle_override = undefined;
        self.cur_defend_point_override = undefined;
        self.cur_defend_stance = calculate_defend_stance( var_b7a608b9ed51791e, var_5ac4a3e3e2642965 );
        current_goal_type = self botgetscriptgoaltype();
        var_de18d77428b85d25 = bots_util_mp::bot_goal_can_override( goal_type, current_goal_type );
        
        if ( !var_de18d77428b85d25 )
        {
            wait 0.25;
            continue;
        }
        
        if ( !self function_ad6112195cf7b0ed() )
        {
            wait 0.25;
            continue;
        }
        
        cur_min_goal_time = min_goal_time;
        cur_max_goal_time = max_goal_time;
        var_e06c32053ae22d74 = 1;
        
        if ( isdefined( self.defense_investigate_specific_point ) )
        {
            self.cur_defend_point_override = self.defense_investigate_specific_point;
            self.defense_investigate_specific_point = undefined;
            var_e06c32053ae22d74 = 0;
            cur_min_goal_time = 1;
            cur_max_goal_time = 2;
        }
        else if ( isdefined( self.var_55a603a48d297a2d ) )
        {
            self.var_24c79f4f1d7b19ec = self.var_55a603a48d297a2d;
            self.var_55a603a48d297a2d = undefined;
        }
        else
        {
            if ( isdefined( level.aerial_danger_exists_for ) && level.aerial_danger_exists_for[ self.team ] )
            {
                if ( !arraycontains( self.defense_score_flags, "avoid_aerial_enemies" ) )
                {
                    self.defense_score_flags[ self.defense_score_flags.size ] = "avoid_aerial_enemies";
                }
            }
            
            if ( gettime() == self.var_a2c26a73eb80ce70 )
            {
                assertmsg( "<dev string:x363>" + self.var_15a01b5c0ab344ff + "<dev string:x3be>" + defense_type + "<dev string:x3d0>" + "<dev string:x3d2>" + self.bot_defending_start_time + "<dev string:x3e8>" + gettime() );
            }
            
            self.var_a2c26a73eb80ce70 = gettime();
            self.var_15a01b5c0ab344ff = defense_type;
            self [[ var_6c924a8f22acd54d ]]();
        }
        
        self botclearscriptgoal();
        result = "";
        
        if ( isdefined( self.var_24c79f4f1d7b19ec ) || isdefined( self.cur_defend_point_override ) )
        {
            if ( var_e06c32053ae22d74 && is_protecting() && !isplayer( defendcenter ) && isdefined( self.defend_entrance_index ) )
            {
                trap_item = bots_strategy::function_c6152abaead059f6( [ "trap_directional", "trap", "trap_activate" ] );
                
                if ( isdefined( trap_item ) )
                {
                    entrances = bots_util::bot_get_entrances_for_stance_and_index( undefined, self.defend_entrance_index );
                    bots_strategy::bot_set_ambush_trap( trap_item, entrances, self.var_ed2c61ea014d90ab );
                }
            }
            
            if ( isdefined( self.cur_defend_point_override ) )
            {
                yaw = undefined;
                
                if ( isdefined( self.cur_defend_angle_override ) )
                {
                    yaw = self.cur_defend_angle_override[ 1 ];
                }
                
                self botsetscriptgoal( self.cur_defend_point_override, 0, goal_type, yaw );
                
                if ( isdefined( self.defend_objective_radius ) )
                {
                    self botsetobjectiveradius( self.defend_objective_radius );
                }
            }
            else if ( !isdefined( self.cur_defend_angle_override ) )
            {
                self botsetscriptgoal( self.var_24c79f4f1d7b19ec, 0, goal_type );
                
                if ( isdefined( self.defend_objective_radius ) )
                {
                    self botsetobjectiveradius( self.defend_objective_radius );
                }
            }
            else
            {
                self botsetscriptgoal( self.var_24c79f4f1d7b19ec, 0, goal_type, self.cur_defend_angle_override[ 1 ] );
                
                if ( isdefined( self.defend_objective_radius ) )
                {
                    self botsetobjectiveradius( self.defend_objective_radius );
                }
            }
            
            if ( var_b7a608b9ed51791e )
            {
                if ( !( isdefined( self.var_d8ee7fefe5ec03b7 ) && isdefined( self.var_24c79f4f1d7b19ec ) ) || self.var_d8ee7fefe5ec03b7 != self.var_24c79f4f1d7b19ec )
                {
                    self botsetstance( "none" );
                }
            }
            
            previous_goal = self botgetscriptgoal();
            self notify( #"hash_87eabab865635f44" );
            bots_util_mp::watch_tacpoints_stop();
            
            if ( goal_type == "objective" )
            {
                bots_strategy::defense_cautious_approach();
                self botsetawareness( 1 );
                self botsetflag( "cautious", 0 );
            }
            
            if ( self bothasscriptgoal() )
            {
                current_goal = self botgetscriptgoal();
                
                if ( bots_util_mp::bot_vectors_are_equal( current_goal, previous_goal ) )
                {
                    result = bots_util::bot_waittill_goal_or_fail( 20, "defend_force_goal_recalculation" );
                }
            }
            
            if ( result == "goal" )
            {
                if ( var_b7a608b9ed51791e )
                {
                    self botsetstance( self.cur_defend_stance );
                }
                
                childthread watch_entrances_at_goal();
            }
        }
        
        if ( result != "goal" )
        {
            wait 0.25;
            continue;
        }
        
        wait_time = randomfloatrange( cur_min_goal_time, cur_max_goal_time );
        result = utility::waittill_any_timeout( wait_time, "goal_changed", "script_goal_changed", "defend_force_goal_recalculation", "bad_path" );
        
        if ( ( result == "bad_path" || result == "goal_changed" || result == "script_goal_changed" ) && ( self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone" ) )
        {
            self botsetstance( "none" );
        }
        
        if ( result == "timeout" && !var_e5c4d1f4c2205a6b )
        {
            bots_util::bot_waittill_out_of_combat_or_time();
        }
        
        waitframe();
    }
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0x3a5e0d72, Offset: 0x14a0
// Size: 0x150
function calculate_defend_stance( var_b7a608b9ed51791e, var_6eb8e63a963bfc43 )
{
    stance = "stand";
    
    if ( var_b7a608b9ed51791e )
    {
        chance_to_crouch = 0;
        chance_to_prone = 0;
        strategy_level = self botgetdifficultysetting( "strategyLevel" );
        
        if ( strategy_level == 1 )
        {
            chance_to_crouch = 25;
            chance_to_prone = 55;
        }
        else if ( strategy_level >= 2 )
        {
            chance_to_crouch = 20;
            chance_to_prone = 70;
        }
        
        choice = randomint( 100 );
        
        if ( choice < chance_to_crouch )
        {
            stance = "crouch";
        }
        else if ( choice < chance_to_crouch + chance_to_prone )
        {
            stance = "prone";
        }
        
        var_adc92b8ca9f4ba6f = !var_6eb8e63a963bfc43;
        
        if ( var_adc92b8ca9f4ba6f && stance == "prone" )
        {
            var_9cc68b0fcc97a6ea = function_de6817374946a471( "prone" );
            var_124b4fef52a9115f = function_ac5634dcf89ab86( "prone" );
            
            if ( var_124b4fef52a9115f.size >= var_9cc68b0fcc97a6ea.size )
            {
                stance = "crouch";
            }
        }
        
        if ( var_adc92b8ca9f4ba6f && stance == "crouch" )
        {
            var_ad69669117a87b2 = function_de6817374946a471( "crouch" );
            var_1c6f22cbb319992e = function_ac5634dcf89ab86( "crouch" );
            
            if ( var_1c6f22cbb319992e.size >= var_ad69669117a87b2.size )
            {
                stance = "stand";
            }
        }
    }
    
    return stance;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x4577540, Offset: 0x15f9
// Size: 0x2ae
function protect_watch_allies()
{
    self notify( #"protect_watch_allies" );
    self endon( #"protect_watch_allies" );
    var_6f4097c330ca1f06 = [];
    minimap_radius = 1050;
    minimap_radius_sq = minimap_radius * minimap_radius;
    radius_around_point = 900;
    
    if ( isdefined( level.protect_radius ) )
    {
        radius_around_point = level.protect_radius;
    }
    
    while ( true )
    {
        cur_time = gettime();
        var_befa24427247ef2c = get_teammates_in_radius( self.bot_defending_center, radius_around_point );
        
        foreach ( teammate in var_befa24427247ef2c )
        {
            teammate_entity_num = teammate.entity_number;
            
            if ( !isdefined( teammate_entity_num ) )
            {
                teammate_entity_num = teammate getentitynumber();
            }
            
            if ( !isdefined( var_6f4097c330ca1f06[ teammate_entity_num ] ) )
            {
                var_6f4097c330ca1f06[ teammate_entity_num ] = cur_time - 1;
            }
            
            if ( !isdefined( teammate.last_investigation_time ) )
            {
                teammate.last_investigation_time = cur_time - 10001;
            }
            
            if ( teammate.health == 0 && isdefined( teammate.deathtime ) && cur_time - teammate.deathtime < 5000 )
            {
                if ( cur_time - teammate.last_investigation_time > 10000 && cur_time > var_6f4097c330ca1f06[ teammate_entity_num ] )
                {
                    if ( isdefined( teammate.lastattacker ) && teammate.lastattacker.team == utility::get_enemy_team( self.team ) )
                    {
                        if ( teammate.body && distancesquared( teammate.body.origin, self.origin ) < minimap_radius_sq )
                        {
                            self getenemyinfo( teammate.lastattacker, teammate.body.origin );
                            var_5f5dae15306aa432 = findclosesttacpointinsight( teammate.body.origin );
                            
                            if ( isdefined( var_5f5dae15306aa432 ) )
                            {
                                self.defense_investigate_specific_point = var_5f5dae15306aa432.groundpos;
                                self notify( #"defend_force_goal_recalculation" );
                            }
                            
                            teammate.last_investigation_time = cur_time;
                        }
                        
                        var_6f4097c330ca1f06[ teammate_entity_num ] = cur_time + 10000;
                    }
                }
            }
        }
        
        wait ( randomint( 5 ) + 1 ) * 0.05;
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xfb56bf6e, Offset: 0x18af
// Size: 0x97
function get_initial_entrances()
{
    if ( isdefined( self.defense_override_watch_tacpoints ) )
    {
        return self.defense_override_watch_tacpoints;
    }
    
    if ( is_capturing() )
    {
        return function_de6817374946a471( self.cur_defend_stance, 1 );
    }
    
    if ( is_protecting() || function_737443eaedb33690() )
    {
        var_ee2b73b69a2b2e6f = self getnearesttacpoint();
        
        if ( isdefined( var_ee2b73b69a2b2e6f ) )
        {
            entrances = bots_util::function_f3e86dad4d2f79dc( "get_initial_entrances -> tacpoint nearest bot", var_ee2b73b69a2b2e6f );
        }
        else
        {
            entrances = bots_util::function_f3e86dad4d2f79dc( "get_initial_entrances -> self origin", self.origin );
        }
        
        return entrances;
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x8009b310, Offset: 0x194e
// Size: 0x1f3
function watch_entrances_at_goal()
{
    self notify( #"watch_entrances_at_goal" );
    self endon( #"watch_entrances_at_goal" );
    self endon( #"hash_87eabab865635f44" );
    self endon( #"script_goal_changed" );
    var_ee2b73b69a2b2e6f = self getnearesttacpoint();
    var_361c954512198cd3 = undefined;
    
    if ( is_capturing() )
    {
        precalculated_entrances = get_initial_entrances();
        var_361c954512198cd3 = [];
        
        if ( isdefined( var_ee2b73b69a2b2e6f ) )
        {
            foreach ( entrance in precalculated_entrances )
            {
                if ( tacpointsvisible( var_ee2b73b69a2b2e6f, entrance ) )
                {
                    var_361c954512198cd3[ var_361c954512198cd3.size ] = entrance;
                }
            }
        }
        
        if ( var_361c954512198cd3.size == 0 )
        {
            if ( isdefined( var_ee2b73b69a2b2e6f ) )
            {
                var_361c954512198cd3 = bots_util::function_f3e86dad4d2f79dc( "watch_entrances_at_goal -> tacpoint nearest bot", var_ee2b73b69a2b2e6f );
            }
            else
            {
                var_361c954512198cd3 = bots_util::function_f3e86dad4d2f79dc( "watch_entrances_at_goal -> self origin", self.origin );
            }
        }
    }
    else if ( is_protecting() || function_737443eaedb33690() )
    {
        var_361c954512198cd3 = get_initial_entrances();
        currentweapon = self getcurrentweapon();
        
        if ( isdefined( var_ee2b73b69a2b2e6f ) && isdefined( self.var_ed2c61ea014d90ab ) && !issubstr( currentweapon.basename, "riotshield" ) )
        {
            if ( tacpointsvisible( var_ee2b73b69a2b2e6f, self.var_ed2c61ea014d90ab ) )
            {
                var_361c954512198cd3[ var_361c954512198cd3.size ] = self.var_ed2c61ea014d90ab;
            }
        }
    }
    
    if ( isdefined( var_361c954512198cd3 ) && var_361c954512198cd3.size > 0 )
    {
        childthread bots_util_mp::bot_watch_tacpoints( var_361c954512198cd3 );
        
        if ( function_737443eaedb33690() )
        {
            childthread function_e0bf9220104724a();
            return;
        }
        
        if ( isdefined( level.bot_funcs[ "bot_entrance_update" ] ) )
        {
            self childthread [[ level.bot_funcs[ "bot_entrance_update" ] ]]();
            return;
        }
        
        childthread monitor_watch_entrances_at_goal();
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x2dc0d308, Offset: 0x1b49
// Size: 0x32a
function monitor_watch_entrances_at_goal()
{
    self notify( #"monitor_watch_entrances_at_goal" );
    self endon( #"monitor_watch_entrances_at_goal" );
    self notify( #"bot_monitor_watch_entrances" );
    self endon( #"bot_monitor_watch_entrances" );
    self endon( #"bot_watch_tacpoints_stop" );
    
    while ( !isdefined( self.watch_tacpoints ) )
    {
        wait 0.05;
    }
    
    watch_tacpoint_chance_func = level.bot_funcs[ "get_watch_tacpoint_chance" ];
    
    while ( true )
    {
        assert( isdefined( self.watch_tacpoints ) );
        center_chance = 0.8;
        non_center_chance = 1;
        
        if ( arraycontains( self.defense_score_flags, "strict_los" ) )
        {
            center_chance = 1;
            non_center_chance = 0.5;
        }
        
        if ( isdefined( self.var_ed2c61ea014d90ab ) )
        {
            foreach ( tacpoint_testing in self.watch_tacpoints )
            {
                assert( isdefined( self.entity_number ) );
                assert( isdefined( tacpoint_testing.watch_tacpoint_chance ) );
                assert( isdefined( tacpoint_testing.var_40758809a01da5b5 ) );
                base_chance = tacpoint_testing.var_40758809a01da5b5[ self.entity_number ];
                
                if ( tacpoint_testing == self.var_ed2c61ea014d90ab )
                {
                    tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] = base_chance * center_chance;
                    continue;
                }
                
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] = base_chance * non_center_chance;
            }
        }
        
        var_6d112a65f3f08cc9 = isdefined( watch_tacpoint_chance_func );
        
        if ( !var_6d112a65f3f08cc9 )
        {
            bots_util_mp::function_d041b15a08f29830( 0.5 );
        }
        
        foreach ( tacpoint_testing in self.watch_tacpoints )
        {
            if ( var_6d112a65f3f08cc9 )
            {
                gametype_scalar = self [[ watch_tacpoint_chance_func ]]( tacpoint_testing );
                assert( isdefined( gametype_scalar ) );
                assert( isdefined( self.entity_number ) );
                assert( isdefined( tacpoint_testing.watch_tacpoint_chance ) );
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] *= gametype_scalar;
            }
            
            if ( entrance_watched_by_ally( tacpoint_testing ) )
            {
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] *= 0.5;
            }
        }
        
        wait randomfloatrange( 0.5, 0.75 );
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xd9b50e08, Offset: 0x1e7b
// Size: 0x222
function function_e0bf9220104724a()
{
    self notify( #"hash_40d5675c9171cc6f" );
    self endon( #"hash_40d5675c9171cc6f" );
    self notify( #"bot_monitor_watch_entrances" );
    self endon( #"bot_monitor_watch_entrances" );
    
    while ( !isdefined( self.watch_tacpoints ) )
    {
        wait 0.05;
    }
    
    while ( true )
    {
        var_f9b81777a8346d29 = anglestoforward( self.bot_defend_player_guarding getplayerangles() ) * ( 1, 1, 0 );
        var_f9b81777a8346d29 = vectornormalize( var_f9b81777a8346d29 );
        
        foreach ( tacpoint_testing in self.watch_tacpoints )
        {
            tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] = tacpoint_testing.var_40758809a01da5b5[ self.entity_number ];
            var_ee79a0c8ca1ea98 = tacpoint_testing.groundpos - self.bot_defend_player_guarding.origin;
            var_ee79a0c8ca1ea98 = vectornormalize( var_ee79a0c8ca1ea98 );
            var_50c1c4d01a3749ed = vectordot( var_f9b81777a8346d29, var_ee79a0c8ca1ea98 );
            
            if ( var_50c1c4d01a3749ed > 0.6 )
            {
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] *= 0.33;
            }
            else if ( var_50c1c4d01a3749ed > 0 )
            {
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] *= 0.66;
            }
            
            if ( !function_75f3deddaafb2dfb( tacpoint_testing ) )
            {
                tacpoint_testing.watch_tacpoint_chance[ self.entity_number ] *= 0.5;
            }
        }
        
        wait randomfloatrange( 0.4, 0.6 );
    }
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0xfcb2f98c, Offset: 0x20a5
// Size: 0x13d, Type: bool
function function_75f3deddaafb2dfb( entrance_tacpoint )
{
    entrance_zone_index = entrance_tacpoint.navzoneindex;
    var_a10e7f78855262bc = vectornormalize( entrance_tacpoint.groundpos - self.origin );
    
    if ( entrance_tacpoint.navzoneindex == -1 )
    {
        return false;
    }
    
    var_2308e42d2993ed13 = function_5a0bc874a4a08aa1( entrance_tacpoint.navzoneindex );
    
    foreach ( zone in var_2308e42d2993ed13 )
    {
        if ( botzonegetcount( zone, self.team, "enemy_predict" ) > 0 )
        {
            if ( zone == entrance_zone_index )
            {
                return true;
            }
            
            var_7da73c34a3682b04 = vectornormalize( getzoneorigin( zone ) - self.origin );
            dot = vectordot( var_a10e7f78855262bc, var_7da73c34a3682b04 );
            
            if ( dot > 0.2 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0x8077b1dd, Offset: 0x21eb
// Size: 0xc4, Type: bool
function entrance_watched_by_ally( entrance )
{
    if ( self.bot_defending_type == "protect_zone" )
    {
        var_befa24427247ef2c = function_8fb21d5393290c35( self.bot_defending_zone_id );
    }
    else
    {
        var_befa24427247ef2c = function_dcad6a57c2f36d2f( self.bot_defending_center );
    }
    
    foreach ( teammate in var_befa24427247ef2c )
    {
        if ( entrance_watched_by_player( teammate, entrance ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0xd742be99, Offset: 0x22b8
// Size: 0x70, Type: bool
function entrance_watched_by_player( player, entrance )
{
    player_forward = anglestoforward( player getplayerangles() );
    var_3fbcfb7391de49e8 = vectornormalize( entrance.groundpos - player.origin );
    var_f8d2af94f85f91f5 = vectordot( player_forward, var_3fbcfb7391de49e8 );
    
    if ( var_f8d2af94f85f91f5 > 0.6 )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xfe25300e, Offset: 0x2331
// Size: 0x38
function function_ef6c1282198a0354()
{
    var_8ca6f1645405fefc = function_de6817374946a471( self.cur_defend_stance );
    
    if ( var_8ca6f1645405fefc.size > 0 )
    {
        return utility::array_random( var_8ca6f1645405fefc ).origin;
    }
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0xa94cc447, Offset: 0x2372
// Size: 0x4b
function function_de6817374946a471( stance, var_d084f3ad45fa98e7 )
{
    if ( isdefined( self.defend_entrance_index ) )
    {
        entrances = bots_util::bot_get_entrances_for_stance_and_index( stance, self.defend_entrance_index, var_d084f3ad45fa98e7 );
        
        if ( isdefined( entrances ) )
        {
            return entrances;
        }
    }
    
    return [];
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0x516dcec9, Offset: 0x23c6
// Size: 0xcd
function function_8fb21d5393290c35( zoneid )
{
    var_1d061d8083d47211 = [];
    teammates_in_radius = get_teammates_in_radius( self.origin, 1000 );
    
    foreach ( teammate in teammates_in_radius )
    {
        if ( !isai( teammate ) || teammate is_defending() && teammate.bot_defending_zone_id == zoneid )
        {
            var_1d061d8083d47211[ var_1d061d8083d47211.size ] = teammate;
        }
    }
    
    return var_1d061d8083d47211;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0x6ba6d1a1, Offset: 0x249c
// Size: 0xe3
function function_dcad6a57c2f36d2f( point, radius_around_point )
{
    if ( !isdefined( radius_around_point ) )
    {
        if ( isdefined( level.protect_radius ) )
        {
            radius_around_point = level.protect_radius;
        }
        else
        {
            radius_around_point = 900;
        }
    }
    
    var_1d061d8083d47211 = [];
    teammates_in_radius = get_teammates_in_radius( point, radius_around_point );
    
    foreach ( teammate in teammates_in_radius )
    {
        if ( !isai( teammate ) || teammate is_defending_point( point ) )
        {
            var_1d061d8083d47211[ var_1d061d8083d47211.size ] = teammate;
        }
    }
    
    return var_1d061d8083d47211;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0xf1554dd8, Offset: 0x2588
// Size: 0xc3
function get_teammates_in_radius( point, radius_around_point )
{
    radius_around_point_sq = radius_around_point * radius_around_point;
    teammates_in_radius = [];
    
    for ( i = 0; i < level.participants.size ; i++ )
    {
        other_player = level.participants[ i ];
        
        if ( other_player != self && isdefined( other_player.team ) && other_player.team == self.team && game_utility_common::isteamparticipant( other_player ) )
        {
            if ( distancesquared( point, other_player.origin ) < radius_around_point_sq )
            {
                teammates_in_radius[ teammates_in_radius.size ] = other_player;
            }
        }
    }
    
    return teammates_in_radius;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x1c69ae48, Offset: 0x2654
// Size: 0x4f
function function_393801d08ec25cef()
{
    level endon( #"game_ended" );
    self endon( #"hash_945ffa0940dbb39" );
    self endon( #"hash_ee341639d000412d" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "exit_autopilot" );
    
    if ( isdefined( self ) )
    {
        thread function_87e8deae08ce1a0();
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xb661123, Offset: 0x26ab
// Size: 0x102
function function_87e8deae08ce1a0()
{
    self notify( #"hash_ee341639d000412d" );
    self.bot_defending = undefined;
    self.bot_defending_center = undefined;
    self.bot_defending_radius = undefined;
    self.bot_defending_tacpoints = undefined;
    self.bot_defending_type = undefined;
    self.bot_defending_start_time = undefined;
    self.bot_defending_game_object = undefined;
    self.bot_defending_override_origin_tacpoint = undefined;
    self.bot_defend_player_guarding = undefined;
    self.bot_defending_zone_id = undefined;
    self.defense_score_flags = undefined;
    self.var_ed2c61ea014d90ab = undefined;
    self.defense_investigate_specific_point = undefined;
    self.var_55a603a48d297a2d = undefined;
    self.defend_objective_radius = undefined;
    self.var_d8ee7fefe5ec03b7 = undefined;
    self.var_24c79f4f1d7b19ec = undefined;
    self.cur_defend_angle_override = undefined;
    self.cur_defend_point_override = undefined;
    self.defend_entrance_index = undefined;
    self.defense_override_watch_tacpoints = undefined;
    
    if ( isbot( self ) || isautopilot( self ) )
    {
        self botclearscriptgoal();
        self botsetstance( "none" );
    }
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0x5d4317b8, Offset: 0x27b5
// Size: 0x128
function function_ac5634dcf89ab86( stance )
{
    var_2e1ec128ce1b6aee = [];
    
    foreach ( other_player in level.participants )
    {
        if ( !isdefined( other_player.team ) )
        {
            continue;
        }
        
        if ( other_player.team == self.team && other_player != self && isai( other_player ) && other_player is_defending() && isdefined( other_player.cur_defend_stance ) && other_player.cur_defend_stance == stance )
        {
            if ( other_player.bot_defending_type == self.bot_defending_type && is_defending_point( other_player.bot_defending_center ) )
            {
                var_2e1ec128ce1b6aee[ var_2e1ec128ce1b6aee.size ] = other_player;
            }
        }
    }
    
    return var_2e1ec128ce1b6aee;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xc1cc2ecb, Offset: 0x28e6
// Size: 0x26b
function monitor_defend_player()
{
    var_934a7c08b9333784 = 0;
    new_goal_radius = 175;
    last_player_pos = self.bot_defend_player_guarding.origin;
    prev_player_velocity = 0;
    var_b31df8c4980505a0 = 0;
    
    while ( true )
    {
        if ( !isdefined( self.bot_defend_player_guarding ) )
        {
            thread function_87e8deae08ce1a0();
        }
        
        self.bot_defending_center = self.bot_defend_player_guarding.origin;
        self.var_ed2c61ea014d90ab = self.bot_defend_player_guarding getnearesttacpoint();
        
        if ( !isdefined( self.var_ed2c61ea014d90ab ) )
        {
            self.var_ed2c61ea014d90ab = self getnearesttacpoint();
        }
        
        assert( isdefined( self.var_ed2c61ea014d90ab ) );
        
        if ( self botgetscriptgoaltype() != "none" )
        {
            script_goal = self botgetscriptgoal();
            var_14732a10809dbf9f = self.bot_defend_player_guarding getvelocity();
            var_ecd107969f94d370 = lengthsquared( var_14732a10809dbf9f );
            
            if ( var_ecd107969f94d370 > 100 )
            {
                var_934a7c08b9333784 = 0;
                
                if ( distancesquared( last_player_pos, self.bot_defend_player_guarding.origin ) > new_goal_radius * new_goal_radius )
                {
                    last_player_pos = self.bot_defend_player_guarding.origin;
                    var_b31df8c4980505a0 = 1;
                    player_to_script_goal = vectornormalize( script_goal - self.bot_defend_player_guarding.origin );
                    normalized_velocity = vectornormalize( var_14732a10809dbf9f );
                    
                    if ( vectordot( player_to_script_goal, normalized_velocity ) < 0.1 )
                    {
                        self notify( #"defend_force_goal_recalculation" );
                        wait 0.25;
                    }
                }
            }
            else
            {
                var_934a7c08b9333784 += 0.05;
                
                if ( prev_player_velocity > 100 && var_b31df8c4980505a0 )
                {
                    last_player_pos = self.bot_defend_player_guarding.origin;
                    var_b31df8c4980505a0 = 0;
                }
                
                if ( var_934a7c08b9333784 > 0.5 )
                {
                    distsq = distancesquared( script_goal, self.bot_defending_center );
                    
                    if ( distsq > self.bot_defending_radius * self.bot_defending_radius )
                    {
                        self notify( #"defend_force_goal_recalculation" );
                        wait 0.25;
                    }
                }
            }
            
            prev_player_velocity = var_ecd107969f94d370;
            
            if ( abs( self.bot_defend_player_guarding.origin[ 2 ] - script_goal[ 2 ] ) >= 50 )
            {
                self notify( #"defend_force_goal_recalculation" );
                wait 0.25;
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots_scripted_defense
// Params 3
// Checksum 0xc6e58a3e, Offset: 0x2b59
// Size: 0x361
function find_tacpoint_to_guard_player( var_84a67dd04f947d3e, radius, var_858a4e1aee5979d7 )
{
    result = undefined;
    var_14732a10809dbf9f = self.bot_defend_player_guarding getvelocity();
    
    if ( lengthsquared( var_14732a10809dbf9f ) > 100 )
    {
        all_tacpoints_raw = function_a034a927128ada11( var_84a67dd04f947d3e, radius * 1.75, radius * 0.5, 500 );
        all_tacpoints = [];
        normalized_velocity = vectornormalize( var_14732a10809dbf9f );
        
        for ( i = 0; i < all_tacpoints_raw.size ; i++ )
        {
            var_ee79a0c8ca1ea98 = vectornormalize( all_tacpoints_raw[ i ].groundpos - self.bot_defend_player_guarding.origin );
            
            if ( vectordot( var_ee79a0c8ca1ea98, normalized_velocity ) > 0.1 )
            {
                all_tacpoints[ all_tacpoints.size ] = all_tacpoints_raw[ i ];
            }
        }
    }
    else
    {
        all_tacpoints = function_a034a927128ada11( var_84a67dd04f947d3e, radius, 0, 500 );
    }
    
    if ( var_858a4e1aee5979d7 )
    {
        bot_to_player = vectornormalize( self.bot_defend_player_guarding.origin - self.origin );
        all_tacpoints_old = all_tacpoints;
        all_tacpoints = [];
        
        foreach ( tacpoint in all_tacpoints_old )
        {
            var_ee79a0c8ca1ea98 = vectornormalize( tacpoint.groundpos - self.bot_defend_player_guarding.origin );
            
            if ( vectordot( bot_to_player, var_ee79a0c8ca1ea98 ) > 0.2 )
            {
                all_tacpoints[ all_tacpoints.size ] = tacpoint;
            }
        }
    }
    
    var_b661a2b190f26408 = [];
    var_f0b12cbcecbe7e2c = [];
    var_72b50563144fdac3 = [];
    
    for ( i = 0; i < all_tacpoints.size ; i++ )
    {
        var_8dd7dd7a926ae5bc = distancesquared( all_tacpoints[ i ].groundpos, var_84a67dd04f947d3e ) > 10000;
        var_3975987131b3403c = abs( all_tacpoints[ i ].groundpos[ 2 ] - self.bot_defend_player_guarding.origin[ 2 ] ) < 50;
        
        if ( var_8dd7dd7a926ae5bc )
        {
            var_b661a2b190f26408[ var_b661a2b190f26408.size ] = all_tacpoints[ i ];
        }
        
        if ( var_3975987131b3403c )
        {
            var_f0b12cbcecbe7e2c[ var_f0b12cbcecbe7e2c.size ] = all_tacpoints[ i ];
        }
        
        if ( var_8dd7dd7a926ae5bc && var_3975987131b3403c )
        {
            var_72b50563144fdac3[ var_72b50563144fdac3.size ] = all_tacpoints[ i ];
        }
        
        if ( i % 100 == 99 )
        {
            wait 0.05;
        }
    }
    
    if ( var_72b50563144fdac3.size > 0 )
    {
        result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_guard_player -> tacpoint pick capture1", var_72b50563144fdac3, var_72b50563144fdac3.size * 0.15, "capture", var_84a67dd04f947d3e, undefined, self.defense_score_flags );
    }
    
    if ( !isdefined( result ) )
    {
        wait 0.05;
        
        if ( var_f0b12cbcecbe7e2c.size > 0 )
        {
            result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_guard_player -> tacpoint pick capture2", var_f0b12cbcecbe7e2c, var_f0b12cbcecbe7e2c.size * 0.15, "capture", var_84a67dd04f947d3e, undefined, self.defense_score_flags );
        }
        
        if ( !isdefined( result ) && var_b661a2b190f26408.size > 0 )
        {
            wait 0.05;
            result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_guard_player -> tacpoint pick capture3", var_b661a2b190f26408, var_b661a2b190f26408.size * 0.15, "capture", var_84a67dd04f947d3e, undefined, self.defense_score_flags );
        }
    }
    
    return result;
}

// Namespace bots_scripted_defense
// Params 3
// Checksum 0xd4999432, Offset: 0x2ec3
// Size: 0x89
function find_tacpoint_to_capture_point( var_84a67dd04f947d3e, radius, point_to_face )
{
    result = undefined;
    height = min( radius, 500 );
    all_tacpoints = function_a034a927128ada11( var_84a67dd04f947d3e, radius, 0, height, botgetmaxnumscoreitems() );
    
    if ( all_tacpoints.size > 0 )
    {
        result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_capture_point -> tacpoint pick", all_tacpoints, all_tacpoints.size * 0.15, "capture", var_84a67dd04f947d3e, point_to_face, self.defense_score_flags );
    }
    
    return result;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0x7063eeab, Offset: 0x2f55
// Size: 0x55
function find_tacpoint_to_capture_zone( tacpoints, point_to_face )
{
    result = undefined;
    
    if ( tacpoints.size > 0 )
    {
        result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_capture_zone -> tacpoint pick", tacpoints, tacpoints.size * 0.15, "capture", undefined, point_to_face, self.defense_score_flags );
    }
    
    return result;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0xd76f1dd6, Offset: 0x2fb3
// Size: 0x55
function find_tacpoint_to_protect_zone( tacpoints, var_84a67dd04f947d3e )
{
    result = undefined;
    
    if ( tacpoints.size > 0 )
    {
        result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_to_protect_zone -> tacpoint pick", tacpoints, tacpoints.size * 0.25, "capture", var_84a67dd04f947d3e, undefined, self.defense_score_flags );
    }
    
    return result;
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0xa498c41c, Offset: 0x3011
// Size: 0x72
function find_tacpoint_that_protects_point( var_84a67dd04f947d3e, radius )
{
    result = undefined;
    all_tacpoints = function_e46a5d842ba448ef( var_84a67dd04f947d3e, radius, 0 );
    
    if ( all_tacpoints.size > 0 )
    {
        all_tacpoints = bots_util::function_4eb61a3985ad712c( all_tacpoints, 1 );
        result = bots_util::function_ec1247a9311f67a4( "find_tacpoint_that_protects_point -> tacpoint pick", all_tacpoints, all_tacpoints.size * 0.15, "protect", var_84a67dd04f947d3e, self.defense_score_flags );
    }
    
    return result;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x3a36f5ab, Offset: 0x308c
// Size: 0xcd
function function_7cec708f5701acfc()
{
    entrance_point = function_ef6c1282198a0354();
    tacpoint = find_tacpoint_to_capture_point( get_valid_center(), self.bot_defending_radius, entrance_point );
    
    if ( isdefined( tacpoint ) )
    {
        if ( isdefined( entrance_point ) )
        {
            var_e00e2b9b644d20f3 = vectornormalize( entrance_point - tacpoint.groundpos );
            self.cur_defend_angle_override = vectortoangles( var_e00e2b9b644d20f3 );
        }
        else
        {
            var_cbf6f96d37641654 = vectornormalize( tacpoint.groundpos - get_valid_center() );
            self.cur_defend_angle_override = vectortoangles( var_cbf6f96d37641654 );
        }
        
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    if ( isdefined( entrance_point ) )
    {
        function_c197e214089223bf( entrance_point, undefined );
        return;
    }
    
    function_c197e214089223bf( undefined, get_valid_center() );
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x9f968ff9, Offset: 0x3161
// Size: 0xc7
function function_c0a033de446b16d3()
{
    entrance_point = function_ef6c1282198a0354();
    tacpoint = find_tacpoint_to_capture_zone( self.bot_defending_tacpoints, entrance_point );
    
    if ( isdefined( tacpoint ) )
    {
        if ( isdefined( entrance_point ) )
        {
            var_e00e2b9b644d20f3 = vectornormalize( entrance_point - tacpoint.groundpos );
            self.cur_defend_angle_override = vectortoangles( var_e00e2b9b644d20f3 );
        }
        else
        {
            var_cbf6f96d37641654 = vectornormalize( tacpoint.groundpos - get_valid_center() );
            self.cur_defend_angle_override = vectortoangles( var_cbf6f96d37641654 );
        }
        
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    if ( isdefined( entrance_point ) )
    {
        function_c197e214089223bf( entrance_point, undefined );
        return;
    }
    
    function_c197e214089223bf( undefined, get_valid_center() );
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x6ee7c88, Offset: 0x3230
// Size: 0x74
function function_1cd96bc453e3e9f5()
{
    tacpoint = find_tacpoint_that_protects_point( get_valid_center(), self.bot_defending_radius );
    
    if ( isdefined( tacpoint ) )
    {
        tacpoint_to_center = vectornormalize( get_valid_center() - tacpoint.groundpos );
        self.cur_defend_angle_override = vectortoangles( tacpoint_to_center );
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    function_c197e214089223bf( get_valid_center(), undefined );
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x69d180ad, Offset: 0x32ac
// Size: 0x45
function function_23c77d885f361d30()
{
    tacpoint = find_tacpoint_to_protect_zone( self.bot_defending_tacpoints, get_valid_center() );
    
    if ( isdefined( tacpoint ) )
    {
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    function_c197e214089223bf( get_valid_center(), undefined );
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xe29eb191, Offset: 0x32f9
// Size: 0x6c
function function_f4f6eb50019ab23b()
{
    tacpoint = find_tacpoint_to_guard_player( get_valid_center(), self.bot_defending_radius );
    
    if ( isdefined( tacpoint ) )
    {
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    nearest_tacpoint_bot = self getnearesttacpoint();
    
    if ( isdefined( nearest_tacpoint_bot ) )
    {
        self.var_24c79f4f1d7b19ec = nearest_tacpoint_bot;
        return;
    }
    
    self.cur_defend_point_override = self.origin;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xbd985297, Offset: 0x336d
// Size: 0x81
function find_defend_tacpoint_patrol()
{
    tacpoint = undefined;
    tacpoints = function_a034a927128ada11( get_valid_center(), self.bot_defending_radius, 0 );
    
    if ( tacpoints.size > 0 )
    {
        tacpoints = bots_util::function_4eb61a3985ad712c( tacpoints );
        tacpoint = bots_util::function_ec1247a9311f67a4( "find_defend_tacpoint_patrol -> tacpoint pick exposed", tacpoints, 1 + tacpoints.size * 0.5, "exposed" );
    }
    
    if ( isdefined( tacpoint ) )
    {
        self.var_24c79f4f1d7b19ec = tacpoint;
        return;
    }
    
    function_c197e214089223bf( undefined, get_valid_center() );
}

// Namespace bots_scripted_defense
// Params 2
// Checksum 0x93834c02, Offset: 0x33f6
// Size: 0x140
function function_c197e214089223bf( var_366394d70dcf8679, var_a78dfc3b70dc4086 )
{
    if ( !self function_ad6112195cf7b0ed() )
    {
        self.cur_defend_point_override = undefined;
        return;
    }
    
    if ( self.bot_defending_type == "protect_zone" )
    {
        self.cur_defend_point_override = utility::array_random( self.bot_defending_tacpoints ).origin;
        return;
    }
    
    assert( !isdefined( var_366394d70dcf8679 ) && isdefined( var_a78dfc3b70dc4086 ) || isdefined( var_366394d70dcf8679 ) && !isdefined( var_a78dfc3b70dc4086 ) );
    
    if ( self.bot_defending_type == "capture_zone" )
    {
        self.cur_defend_point_override = bots_util::bot_pick_random_point_from_set( get_valid_center(), self.bot_defending_tacpoints, &function_fc2af4c4a906cea );
    }
    else
    {
        self.cur_defend_point_override = bots_util::bot_pick_random_point_in_radius( get_valid_center(), self.bot_defending_radius, &function_fc2af4c4a906cea, 0.15, 0.9 );
    }
    
    if ( isdefined( var_366394d70dcf8679 ) )
    {
        angle_dir = vectornormalize( var_366394d70dcf8679 - self.cur_defend_point_override );
        self.cur_defend_angle_override = vectortoangles( angle_dir );
        return;
    }
    
    if ( isdefined( var_a78dfc3b70dc4086 ) )
    {
        angle_dir = vectornormalize( self.cur_defend_point_override - var_a78dfc3b70dc4086 );
        self.cur_defend_angle_override = vectortoangles( angle_dir );
    }
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0xd2b929cc, Offset: 0x353e
// Size: 0x21, Type: bool
function function_fc2af4c4a906cea( point )
{
    if ( function_d8436cfea4f7685a( point, 1, 1, 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_scripted_defense
// Params 4
// Checksum 0x123dcc0e, Offset: 0x3568
// Size: 0xfd, Type: bool
function function_d8436cfea4f7685a( position, var_50abbf8ca010bc47, var_298bfc5ea907076f, var_c0635811bbb707da )
{
    for ( i = 0; i < level.participants.size ; i++ )
    {
        other_player = level.participants[ i ];
        
        if ( other_player.team == self.team && other_player != self )
        {
            if ( isai( other_player ) )
            {
                if ( var_298bfc5ea907076f )
                {
                    if ( distancesquared( position, other_player.origin ) < 441 )
                    {
                        return true;
                    }
                }
                
                if ( var_c0635811bbb707da && other_player bothasscriptgoal() )
                {
                    bot_goal = other_player botgetscriptgoal();
                    
                    if ( distancesquared( position, bot_goal ) < 441 )
                    {
                        return true;
                    }
                }
                
                continue;
            }
            
            if ( var_50abbf8ca010bc47 )
            {
                if ( distancesquared( position, other_player.origin ) < 441 )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x21d08b78, Offset: 0x366e
// Size: 0xb7
function function_a45d057831c7f3cf()
{
    furthest_dist = 0;
    
    if ( isdefined( self.bot_defending_tacpoints ) )
    {
        foreach ( tacpoint in self.bot_defending_tacpoints )
        {
            var_a58a24990e3ffb3d = distance( self.bot_defending_center, tacpoint.groundpos );
            furthest_dist = max( var_a58a24990e3ffb3d, furthest_dist );
        }
    }
    
    return furthest_dist;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xabc26ac9, Offset: 0x372e
// Size: 0x41
function get_valid_center()
{
    if ( isdefined( self.bot_defending_override_origin_tacpoint ) )
    {
        return self.bot_defending_override_origin_tacpoint.groundpos;
    }
    
    var_7237854e3be197ca = self.bot_defending_center;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x529aee8d, Offset: 0x3777
// Size: 0x34, Type: bool
function is_capturing()
{
    if ( is_defending() )
    {
        if ( self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x89a5360b, Offset: 0x37b4
// Size: 0x21, Type: bool
function is_patrolling()
{
    if ( is_defending() )
    {
        if ( self.bot_defending_type == "patrol" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0xd8b914be, Offset: 0x37de
// Size: 0x34, Type: bool
function is_protecting()
{
    if ( is_defending() )
    {
        if ( self.bot_defending_type == "protect" || self.bot_defending_type == "protect_zone" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x69e33a04, Offset: 0x381b
// Size: 0x21, Type: bool
function function_737443eaedb33690()
{
    if ( is_defending() )
    {
        if ( self.bot_defending_type == "bodyguard" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 0
// Checksum 0x434cfed5, Offset: 0x3845
// Size: 0xc, Type: bool
function is_defending()
{
    return isdefined( self.bot_defending );
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0x5038dc30, Offset: 0x385a
// Size: 0x2d, Type: bool
function is_defending_point( point )
{
    if ( is_defending() )
    {
        if ( bots_util_mp::bot_vectors_are_equal( self.bot_defending_center, point ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_scripted_defense
// Params 1
// Checksum 0x2108fbf1, Offset: 0x3890
// Size: 0x29, Type: bool
function is_guarding_player( player )
{
    if ( function_737443eaedb33690() && self.bot_defend_player_guarding == player )
    {
        return true;
    }
    
    return false;
}

