// scripts\common\bots\bots_tactical_goals.gsc  (hash_66a15b717418650a.gscc) (size: 3206 Bytes / 0xc86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a523a85 (441596549)
// size ...... 3206 (0xc86)
// includes .. 1   (offset: 0xc3e)
// strings ... 5   (offset: 0xc46)
// dev strs .. 0   (offset: 0xc86)
// exports ... 9   (offset: 0x956)
// cseg ...... 0xb3 + 0x8a3 (0x956)
// imports ... 13  (offset: 0xabe)
// animtree1 . 0   (offset: 0xc86)
// animtree2 . 0   (offset: 0xc86)
#using scripts\common\bots\bots_util;

#namespace bots_tactical_goals;

// Namespace bots_tactical_goals
// Params 0
// Checksum 0x6a50320, Offset: 0xd1
// Size: 0x23a
function think_tactical_goals()
{
    self notify( #"think_tactical_goals" );
    self endon( #"think_tactical_goals" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.tactical_goals = [];
    self.tactical_goal_in_action_thread = 0;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( self.tactical_goals.size > 0 && !bots_util::bot_is_remote_or_linked() )
        {
            new_goal = self.tactical_goals[ 0 ];
            
            if ( !isdefined( new_goal.abort ) )
            {
                self notify( #"start_tactical_goal" );
                
                if ( isdefined( new_goal.start_thread ) )
                {
                    self [[ new_goal.start_thread ]]( new_goal );
                }
                
                childthread watch_goal_aborted( new_goal );
                goal_type = "tactical";
                
                if ( isdefined( new_goal.goal_type ) )
                {
                    goal_type = new_goal.goal_type;
                }
                
                if ( new_goal.clear_prev_goal )
                {
                    self botclearscriptgoal();
                }
                
                self botsetscriptgoal( new_goal.goal_position, new_goal.goal_radius, goal_type, new_goal.goal_yaw );
                
                if ( isdefined( new_goal.objective_radius ) )
                {
                    self botsetobjectiveradius( new_goal.objective_radius );
                }
                
                if ( isdefined( new_goal.short_term_goal ) )
                {
                    self botsetshorttermgoal( new_goal.short_term_goal );
                }
                
                result = bots_util::bot_waittill_goal_or_fail( undefined, "stop_tactical_goal" );
                self notify( #"hash_b8ad01b33c92c445" );
                
                if ( result == "goal" )
                {
                    if ( isdefined( new_goal.action_thread ) )
                    {
                        self.tactical_goal_in_action_thread = 1;
                        self [[ new_goal.action_thread ]]( new_goal );
                        self.tactical_goal_in_action_thread = 0;
                    }
                }
                
                if ( result != "script_goal_changed" )
                {
                    self botclearscriptgoal();
                }
                
                if ( isdefined( new_goal.end_thread ) )
                {
                    self [[ new_goal.end_thread ]]( new_goal );
                }
            }
            
            self.tactical_goals = arrayremove( self.tactical_goals, new_goal );
        }
        
        wait 0.05;
    }
}

// Namespace bots_tactical_goals
// Params 1
// Checksum 0x6eb33ae2, Offset: 0x313
// Size: 0x77
function watch_goal_aborted( goal )
{
    self endon( #"stop_tactical_goal" );
    self endon( #"hash_b8ad01b33c92c445" );
    wait 0.05;
    
    while ( true )
    {
        if ( isdefined( goal.abort ) || isdefined( goal.should_abort ) && self [[ goal.should_abort ]]( goal ) )
        {
            self notify( #"stop_tactical_goal" );
        }
        
        wait 0.05;
    }
}

// Namespace bots_tactical_goals
// Params 4
// Checksum 0xa272bfe6, Offset: 0x392
// Size: 0x25e
function new_tactical_goal( type, goal_position, priority, extra_params )
{
    new_goal = spawnstruct();
    new_goal.type = type;
    new_goal.goal_position = goal_position;
    
    if ( isdefined( self.only_allowable_tactical_goals ) )
    {
        if ( !arraycontains( self.only_allowable_tactical_goals, type ) )
        {
            return;
        }
    }
    
    assert( priority >= 0 && priority <= 100 );
    new_goal.priority = priority;
    new_goal.object = extra_params.object;
    new_goal.goal_type = extra_params.script_goal_type;
    new_goal.goal_yaw = extra_params.script_goal_yaw;
    new_goal.goal_radius = 0;
    
    if ( isdefined( extra_params.script_goal_radius ) )
    {
        new_goal.goal_radius = extra_params.script_goal_radius;
    }
    
    new_goal.start_thread = extra_params.start_thread;
    new_goal.end_thread = extra_params.end_thread;
    new_goal.should_abort = extra_params.should_abort;
    new_goal.action_thread = extra_params.action_thread;
    new_goal.objective_radius = extra_params.objective_radius;
    new_goal.short_term_goal = extra_params.short_term_goal;
    new_goal.optional_params = extra_params.optional_params;
    new_goal.clear_prev_goal = extra_params.clear_prev_goal;
    
    for ( position_to_add = 0; position_to_add < self.tactical_goals.size ; position_to_add++ )
    {
        if ( new_goal.priority > self.tactical_goals[ position_to_add ].priority )
        {
            break;
        }
    }
    
    for ( i = self.tactical_goals.size - 1; i >= position_to_add ; i-- )
    {
        self.tactical_goals[ i + 1 ] = self.tactical_goals[ i ];
    }
    
    self.tactical_goals[ position_to_add ] = new_goal;
}

// Namespace bots_tactical_goals
// Params 2
// Checksum 0x4b95f039, Offset: 0x5f8
// Size: 0xe8
function has_tactical_goal( goal_type, object )
{
    if ( !isdefined( self.tactical_goals ) )
    {
        return 0;
    }
    
    if ( isdefined( goal_type ) )
    {
        foreach ( goal in self.tactical_goals )
        {
            if ( goal.type == goal_type )
            {
                if ( isdefined( object ) && isdefined( goal.object ) )
                {
                    return ( goal.object == object );
                }
                
                return 1;
            }
        }
        
        return 0;
    }
    
    return self.tactical_goals.size > 0;
}

// Namespace bots_tactical_goals
// Params 1
// Checksum 0xcc760a2f, Offset: 0x6e8
// Size: 0xbe
function function_a133b1b29a15f51d( goal_type )
{
    goals = [];
    
    if ( isdefined( self.tactical_goals ) )
    {
        foreach ( goal in self.tactical_goals )
        {
            if ( !goal.abort && goal.type == goal_type )
            {
                goals[ goals.size ] = goal;
            }
        }
    }
    
    return goals;
}

// Namespace bots_tactical_goals
// Params 2
// Checksum 0x22ebb0b6, Offset: 0x7af
// Size: 0xe6
function abort_tactical_goal( goal_type, object )
{
    assert( isdefined( goal_type ) );
    
    if ( !isdefined( self.tactical_goals ) )
    {
        return;
    }
    
    foreach ( goal in self.tactical_goals )
    {
        if ( goal.type == goal_type )
        {
            if ( isdefined( object ) )
            {
                if ( goal.object == object )
                {
                    goal.abort = 1;
                }
                
                continue;
            }
            
            goal.abort = 1;
        }
    }
}

// Namespace bots_tactical_goals
// Params 0
// Checksum 0x33945f6b, Offset: 0x89d
// Size: 0xa5
function disable_tactical_goals()
{
    self.only_allowable_tactical_goals[ 0 ] = "map_interactive_object";
    
    foreach ( goal in self.tactical_goals )
    {
        if ( goal.type != "map_interactive_object" )
        {
            goal.abort = 1;
        }
    }
}

// Namespace bots_tactical_goals
// Params 0
// Checksum 0x28d9ebaf, Offset: 0x94a
// Size: 0xc
function enable_tactical_goals()
{
    self.only_allowable_tactical_goals = undefined;
}

