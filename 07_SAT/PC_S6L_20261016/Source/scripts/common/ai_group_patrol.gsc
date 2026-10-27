// scripts\common\ai_group_patrol.gsc  (hash_7db80de62748c769.gscc) (size: 12643 Bytes / 0x3163 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe98cd484 (3918320772)
// size ...... 12643 (0x3163)
// includes .. 3   (offset: 0x301f)
// strings ... 14  (offset: 0x3037)
// dev strs .. 8   (offset: 0x3103)
// exports ... 27  (offset: 0x214b)
// cseg ...... 0x18d + 0x1fbe (0x214b)
// imports ... 86  (offset: 0x2583)
// animtree1 . 0   (offset: 0x3163)
// animtree2 . 0   (offset: 0x3163)
#using scripts\common\ai_formation;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace ai_group_patrol;

// Namespace ai_group_patrol
// Params 0
// Checksum 0xdaa5125c, Offset: 0x1ab
// Size: 0x18
function init()
{
    if ( !isdefined( level.var_efaf119164401d47 ) )
    {
        level.var_efaf119164401d47 = [];
    }
}

// Namespace ai_group_patrol
// Params 4
// Checksum 0x76480425, Offset: 0x1cb
// Size: 0xca
function function_7aa5ea0dd4ec9812( patrolname, formationtype, columncount = 2, horizontalspacing = 40 )
{
    if ( !isdefined( level.var_efaf119164401d47 ) )
    {
        init();
    }
    
    if ( isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return level.var_efaf119164401d47[ patrolname ];
    }
    
    assert( formationtype >= 0 && formationtype < 7, "<dev string:x24>" + formationtype );
    level.var_efaf119164401d47[ patrolname ] = spawnstruct();
    level.var_efaf119164401d47[ patrolname ].array = [];
    ai_formation::function_c37011dc917139e7( patrolname, formationtype, columncount, horizontalspacing );
    return level.var_efaf119164401d47[ patrolname ];
}

// Namespace ai_group_patrol
// Params 2
// Checksum 0xae6a210d, Offset: 0x29e
// Size: 0x117
function delete_patrol( patrolname, permanently = 0 )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    foreach ( ai in level.var_efaf119164401d47[ patrolname ].array )
    {
        if ( permanently )
        {
            ai notify( #"leave_group_patrol_permanently" );
            continue;
        }
        
        ai notify( #"leave_group_patrol" );
    }
    
    notifyname = function_c5974ef8c12299dd( patrolname );
    level notify( notifyname );
    ai_formation::leave_formation( level.var_efaf119164401d47[ patrolname ].array );
    ai_formation::delete_formation( patrolname );
    level.var_efaf119164401d47[ patrolname ] = undefined;
}

// Namespace ai_group_patrol
// Params 5
// Checksum 0xe81191f3, Offset: 0x3bd
// Size: 0x145
function function_180fa7e21b662f2f( patrolname, aitoadd, formationtype = 3, columncount = 2, horizontalspacing = 40 )
{
    if ( !isdefined( level.var_efaf119164401d47 ) )
    {
        init();
    }
    
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        function_7aa5ea0dd4ec9812( patrolname, formationtype, columncount, horizontalspacing );
    }
    
    if ( !isarray( aitoadd ) )
    {
        aitoadd = [ aitoadd ];
    }
    
    foreach ( ai in aitoadd )
    {
        if ( ai.grouppatrolname == patrolname && arraycontains( level.var_efaf119164401d47[ patrolname ].array, ai ) )
        {
            continue;
        }
        
        add_to_patrol( patrolname, ai, formationtype, columncount, horizontalspacing );
        ai thread function_beeeaf2a07ad3040( patrolname );
    }
}

// Namespace ai_group_patrol
// Params 3, eflags: 0x4
// Checksum 0xbf9243a9, Offset: 0x50a
// Size: 0xe6
function private function_7dad044b36a45b5b( formationtype, columncount = 2, horizontalspacing = 40 )
{
    level endon( #"game_ended" );
    grouppatrolname = self.grouppatrolname;
    thread function_dd7489399e42b8d3();
    msg = utility::waittill_any_return( "enemy", "leave_group_patrol", "death", "leave_group_patrol_permanently" );
    
    if ( isdefined( self ) )
    {
        interactionid = self getinteractionid();
        
        if ( isdefined( interactionid ) )
        {
            despawninteraction( interactionid );
        }
        
        leave_patrol( grouppatrolname, self );
        
        if ( isalive( self ) )
        {
            self enableavoidance( 1 );
            self.patroltarget = undefined;
            
            if ( msg === "leave_group_patrol_permanently" )
            {
                self notify( #"leave_group_patrol" );
                return;
            }
            
            thread function_da6bebd41c3e675c( formationtype, columncount, horizontalspacing );
        }
    }
}

// Namespace ai_group_patrol
// Params 0, eflags: 0x4
// Checksum 0x3bdb66a6, Offset: 0x5f8
// Size: 0x73
function private function_dd7489399e42b8d3()
{
    self endon( #"death" );
    self endon( #"enemy" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self choreographer_iscontrolled() )
        {
            break;
        }
        
        if ( isdefined( self.stealth ) && isdefined( self.fnisinstealthidle ) && ![[ self.fnisinstealthidle ]]() )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"leave_group_patrol" );
}

// Namespace ai_group_patrol
// Params 3, eflags: 0x4
// Checksum 0xe1c8d900, Offset: 0x673
// Size: 0xba
function private function_da6bebd41c3e675c( formationtype, columncount = 2, horizontalspacing = 40 )
{
    self endon( #"death" );
    self endon( #"leave_group_patrol_permanently" );
    
    while ( true )
    {
        if ( !self choreographer_iscontrolled() && isdefined( self.stealth ) && isdefined( self.fnisinstealthidle ) && [[ self.fnisinstealthidle ]]() && ( !isdefined( self.var_359a74e8e8304e04 ) || [[ self.var_359a74e8e8304e04 ]]() ) )
        {
            break;
        }
        
        waitframe();
    }
    
    function_180fa7e21b662f2f( self.grouppatrolname, self, formationtype, columncount, horizontalspacing );
}

// Namespace ai_group_patrol
// Params 1, eflags: 0x4
// Checksum 0xdcf22247, Offset: 0x735
// Size: 0x14
function private function_c5974ef8c12299dd( patrolname )
{
    return patrolname + "_kill_update";
}

// Namespace ai_group_patrol
// Params 1, eflags: 0x4
// Checksum 0xbaff9a46, Offset: 0x752
// Size: 0xbe3
function private function_beeeaf2a07ad3040( patrolname )
{
    self endon( #"death" );
    self endon( #"enemy" );
    self endon( #"leave_group_patrol" );
    self endon( #"following_entity" );
    level endon( #"game_ended" );
    wait 0.5;
    var_7d694b61d68efa7b = 200;
    goal_timeout = 5;
    goal_radius = 42;
    self.dont_enter_combat = 1;
    self notify( #"stop_going_to_node" );
    waitframe();
    self.dont_enter_combat = undefined;
    self clearbtgoal( 1 );
    self clearbtgoal( 3 );
    self.goalradius = goal_radius;
    formationid = level.formationlist[ patrolname ];
    
    if ( ai_formation::formation_valid( formationid ) )
    {
        self function_403190bdf322e3a8( 1 );
        setaiformationtargetradius( level.formationlist[ patrolname ], self aigetdesiredspeed() );
    }
    
    if ( level.var_efaf119164401d47[ patrolname ].array.size > 0 && level.var_efaf119164401d47[ patrolname ].array[ 0 ] == self )
    {
        if ( isdefined( self.spawnpoint.target ) )
        {
            patroltargets = get_target_goals( self.spawnpoint.target );
            assert( patroltargets.size > 0, "<dev string:x3f>" );
            self.patroltarget = patroltargets[ 0 ];
            level.var_efaf119164401d47[ patrolname ].groupleadertarget = self.patroltarget;
            self.currentnode = self.patroltarget;
        }
        else
        {
            while ( !isdefined( level.var_efaf119164401d47[ patrolname ].groupleadertarget ) )
            {
                waitframe();
            }
        }
    }
    else
    {
        self setgoalpos( self.origin, goal_radius );
        
        if ( isdefined( self.spawnpoint.target ) )
        {
            leader = get_patrol_leader( patrolname );
            
            if ( !isdefined( leader.patroltarget ) )
            {
                leadertarget = level.var_efaf119164401d47[ patrolname ].groupleadertarget;
            }
            else
            {
                leadertarget = leader.patroltarget;
            }
            
            if ( isdefined( leadertarget ) )
            {
                patroltargets = get_target_goals( self.spawnpoint.target );
                assert( patroltargets.size > 0, "<dev string:x77>" );
                self.patroltarget = patroltargets[ 0 ];
                bestdist = distance( self.patroltarget.origin, leadertarget.origin );
                visited = [ patroltargets[ 0 ] ];
                
                while ( true )
                {
                    nexttargets = get_target_goals( patroltargets[ 0 ].target );
                    assert( nexttargets.size > 0, "<dev string:xb8>" );
                    nexttarget = nexttargets[ 0 ];
                    
                    if ( !isdefined( nexttarget ) || arraycontains( visited, nexttarget ) )
                    {
                        break;
                    }
                    
                    nextdist = distance( nexttarget.origin, leadertarget.origin );
                    
                    if ( nextdist < bestdist )
                    {
                        self.patroltarget = nexttarget;
                        bestdist = nextdist;
                    }
                    
                    visited[ visited.size ] = nexttarget;
                }
                
                if ( distancesquared( leader.origin, leadertarget.origin ) < var_7d694b61d68efa7b )
                {
                    self setgoalpos( self.patroltarget.origin, goal_radius );
                    patroltargets = get_target_goals( self.patroltarget.target );
                    self.patroltarget = patroltargets[ 0 ];
                    leader waittill( #"group_patrol_node_wait_ended" );
                }
            }
            else
            {
                if ( !isdefined( self.patroltarget ) )
                {
                    patroltargets = get_target_goals( self.spawnpoint.target );
                    self.patroltarget = patroltargets[ 0 ];
                }
                
                level.var_efaf119164401d47[ patrolname ].groupleadertarget = self.patroltarget;
                set_patrol_leader();
            }
            
            self.currentnode = self.patroltarget;
        }
        else
        {
            while ( !isdefined( level.var_efaf119164401d47[ patrolname ].groupleadertarget ) )
            {
                waitframe();
            }
            
            formationupdatememberpath( level.formationlist[ patrolname ], self );
        }
    }
    
    interactionid = self getinteractionid();
    
    if ( isdefined( interactionid ) )
    {
        despawninteraction( interactionid );
    }
    
    while ( true )
    {
        leader = get_patrol_leader( patrolname );
        self function_403190bdf322e3a8( 1 );
        
        if ( self != leader && isdefined( self.patroltarget ) && self.patroltarget == level.var_efaf119164401d47[ patrolname ].groupleadertarget )
        {
            set_patrol_leader();
            leader = self;
        }
        
        if ( self == leader )
        {
            targetpos = isdefined( self.patroltarget ) ? self.patroltarget.origin : level.var_efaf119164401d47[ patrolname ].groupleadertarget.origin;
            ai_formation::set_goal( patrolname, targetpos );
            wait 0.1;
            var_7df184e702bb256c = level.var_efaf119164401d47[ patrolname ].var_7df184e702bb256c;
            
            if ( isdefined( var_7df184e702bb256c ) && var_7df184e702bb256c != 2 )
            {
                var_bf52d366dfa30bb3 = level.var_efaf119164401d47[ patrolname ].var_bf52d366dfa30bb3;
                horizontalseparation = level.var_efaf119164401d47[ patrolname ].horizontalseparation;
                verticalseparation = level.var_efaf119164401d47[ patrolname ].verticalseparation;
                leaderinfront = level.var_efaf119164401d47[ patrolname ].leaderinfront;
                
                if ( function_10d0d9d970d25dbb( level.formationlist[ patrolname ], self.origin, level.var_efaf119164401d47[ patrolname ].var_24fb42ff083faeb5, leaderinfront ) )
                {
                    if ( var_bf52d366dfa30bb3 != var_7df184e702bb256c )
                    {
                        function_40b916c0c1ec904a( patrolname, var_7df184e702bb256c, horizontalseparation, verticalseparation, leaderinfront );
                    }
                }
                else if ( var_bf52d366dfa30bb3 == var_7df184e702bb256c )
                {
                    if ( verticalseparation == 0 )
                    {
                        verticalseparation = 50;
                    }
                    
                    function_40b916c0c1ec904a( patrolname, 2, horizontalseparation, verticalseparation, leaderinfront );
                }
            }
        }
        
        while ( true )
        {
            if ( !isdefined( leader ) )
            {
                leader = get_patrol_leader( patrolname );
                patrolgoal = undefined;
            }
            
            if ( !isdefined( patrolgoal ) )
            {
                if ( isdefined( leader.patroltarget ) )
                {
                    patrolgoal = leader.patroltarget.origin;
                }
                else if ( isdefined( level.var_efaf119164401d47[ patrolname ].groupleadertarget ) )
                {
                    patrolgoal = level.var_efaf119164401d47[ patrolname ].groupleadertarget.origin;
                }
                
                leader clearbtgoal( 3 );
                leader setgoalpos( patrolgoal, goal_radius );
            }
            
            if ( isdefined( patrolgoal ) && distance( leader.origin, patrolgoal ) < var_7d694b61d68efa7b )
            {
                patrolgoal = undefined;
                break;
            }
            
            waitframe();
        }
        
        if ( isdefined( self.patroltarget ) )
        {
            leader = get_patrol_leader( patrolname );
            
            if ( self != leader )
            {
                self function_403190bdf322e3a8( 0 );
            }
            
            self clearbtgoal( 1 );
            self clearbtgoal( 3 );
            self setgoalpos( self.patroltarget.origin, goal_radius );
            self.goalradius = goal_radius;
        }
        else if ( self == leader )
        {
            self clearbtgoal( 1 );
            self clearbtgoal( 3 );
            self setgoalpos( level.var_efaf119164401d47[ patrolname ].groupleadertarget.origin, goal_radius );
            self.goalradius = goal_radius;
        }
        
        leader = get_patrol_leader( patrolname );
        
        if ( is_interaction_node( leader.patroltarget ) )
        {
            self notify( #"stop_going_to_node" );
            utility::array_wait( level.var_efaf119164401d47[ patrolname ].array, "goal", goal_timeout );
        }
        else
        {
            self waittill( #"goal" );
        }
        
        interactionai = [];
        node = self.patroltarget;
        var_6e216f540cc77cbe = 0;
        
        if ( isdefined( node ) )
        {
            leader = get_patrol_leader( patrolname );
            
            if ( self != leader )
            {
                self function_403190bdf322e3a8( 0 );
                wait randomfloatrange( 0.5, 1 );
            }
            
            if ( isdefined( node.interaction ) )
            {
                interactionid = self getinteractionid();
                ainode = self._blackboard.idlenode;
                
                if ( isdefined( interactionid ) )
                {
                    if ( node == ainode && isdefined( node.interactionid ) && function_e0737745ca681ec7( node.interactionid ) && node.interactionid == interactionid )
                    {
                        self enableavoidance( 0 );
                        interactionai[ interactionai.size ] = self;
                        var_6e216f540cc77cbe = 1;
                    }
                    else
                    {
                        despawninteraction( interactionid );
                        
                        if ( isdefined( ainode ) )
                        {
                            ainode.interactionid = undefined;
                        }
                    }
                }
                
                if ( !var_6e216f540cc77cbe )
                {
                    if ( isdefined( node.interactionid ) )
                    {
                        despawninteraction( node.interactionid );
                        node.interactionid = undefined;
                    }
                    
                    self._blackboard.idlenode = node;
                    angles = node.angles;
                    
                    if ( !isdefined( angles ) )
                    {
                        angles = ( 0, 0, 0 );
                    }
                    
                    interactiontoks = strtok( node.interaction, "+" );
                    interaction = utility::array_random( interactiontoks );
                    node.interactionid = spawninteraction( interaction, node.origin, angles );
                    self function_895b16b8fcd857ba( node.interactionid );
                    self enableavoidance( 0 );
                    self.repeatinteraction = istrue( node.repeat_interaction );
                    interactionai[ interactionai.size ] = self;
                }
            }
        }
        
        if ( is_interaction_node( leader.patroltarget ) )
        {
            childthread function_39464ff773957de6( node, leader );
            utility::array_wait( level.var_efaf119164401d47[ patrolname ].array, "group_patrol_node_wait_ended" );
            
            if ( self != leader )
            {
                wait randomfloatrange( 0.5, 1 );
            }
        }
        else
        {
            function_39464ff773957de6( node, leader );
        }
        
        self enableavoidance( 1 );
        self._blackboard.idlenode = node;
        self.repeatinteraction = istrue( node.repeat_interaction );
        node = self.patroltarget;
        
        if ( isdefined( node ) && isdefined( node.interactionid ) )
        {
            despawninteraction( node.interactionid );
            node.interactionid = undefined;
        }
        
        if ( isdefined( self.patroltarget ) && isdefined( self.patroltarget.target ) )
        {
            patroltargets = get_target_goals( self.patroltarget.target );
            self.patroltarget = patroltargets[ 0 ];
            self.currentnode = self.patroltarget;
            self clearbtgoal( 1 );
        }
        
        leader = get_patrol_leader( patrolname );
        
        if ( self == leader && isdefined( level.var_efaf119164401d47[ patrolname ].groupleadertarget.target ) )
        {
            [ level.var_efaf119164401d47[ patrolname ].groupleadertarget ] = get_target_goals( level.var_efaf119164401d47[ patrolname ].groupleadertarget.target );
        }
    }
}

// Namespace ai_group_patrol
// Params 1
// Checksum 0xf0892f8e, Offset: 0x133d
// Size: 0x134
function get_target_goals( target )
{
    goals = getnodearray( target, #targetname );
    new_goals = utility::getstructarray( target, "targetname" );
    
    foreach ( new in new_goals )
    {
        goals[ goals.size ] = new;
    }
    
    new_goals = getentarray( target, #targetname );
    
    foreach ( new in new_goals )
    {
        if ( !is_target_goal_valid( new ) )
        {
            continue;
        }
        
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace ai_group_patrol
// Params 1
// Checksum 0x9b61a2b8, Offset: 0x147a
// Size: 0x5e, Type: bool
function is_target_goal_valid( object )
{
    if ( isspawner( object ) )
    {
        return false;
    }
    
    switch ( object.code_classname )
    {
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_5e0756fcd4e0adcd":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_81903cb95a447b8c":
            return false;
    }
    
    return true;
}

// Namespace ai_group_patrol
// Params 1
// Checksum 0xcd661a72, Offset: 0x14e1
// Size: 0x3a, Type: bool
function is_interaction_node( node )
{
    if ( !isdefined( node ) )
    {
        return false;
    }
    
    if ( isdefined( node.interactionid ) )
    {
        return true;
    }
    
    if ( isdefined( node.interaction ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_group_patrol
// Params 1
// Checksum 0x2fa597b3, Offset: 0x1524
// Size: 0x7a
function get_patrol_leader( patrolname )
{
    assert( isdefined( level.var_efaf119164401d47[ patrolname ] ), "<dev string:xde>" );
    leader = ai_formation::get_leader( patrolname );
    
    if ( !isdefined( leader ) && level.var_efaf119164401d47[ patrolname ].array.size > 0 )
    {
        leader = level.var_efaf119164401d47[ patrolname ].array[ 0 ];
    }
    
    return leader;
}

// Namespace ai_group_patrol
// Params 2, eflags: 0x4
// Checksum 0xf9d3886f, Offset: 0x15a7
// Size: 0x14a
function private function_39464ff773957de6( node, leader )
{
    interactionid = self getinteractionid();
    
    if ( isdefined( interactionid ) )
    {
        msg = utility::waittill_any_return( "bseq_user_deleted", "cap_exit_completed" );
        
        if ( msg == "bseq_user_deleted" )
        {
            self waittill( #"cap_exit_completed" );
        }
    }
    else if ( !is_interaction_node( node ) )
    {
        if ( !isdefined( node ) )
        {
            if ( isdefined( leader.patroltarget ) )
            {
                node = leader.patroltarget;
            }
            else
            {
                node = level.var_efaf119164401d47[ self.grouppatrolname ].groupleadertarget;
            }
        }
        
        if ( !isdefined( node.script_delay ) && is_interaction_node( leader.patroltarget ) )
        {
            wait 0.5;
            self notify( #"group_patrol_node_wait_ended" );
            return;
        }
        
        node utility::script_delay();
    }
    
    if ( isdefined( node.script_flag_wait ) )
    {
        utility::flag_wait( node.script_flag_wait );
    }
    
    if ( isdefined( node.script_ent_flag_wait ) )
    {
        utility::ent_flag_wait( node.script_ent_flag_wait );
    }
    
    node utility::script_wait();
    self notify( #"group_patrol_node_wait_ended" );
}

// Namespace ai_group_patrol
// Params 5, eflags: 0x4
// Checksum 0xc6ed5c9c, Offset: 0x16f9
// Size: 0xa8
function private add_to_patrol( patrolname, aitoadd, formationtype, columncount = 2, horizontalspacing = 40 )
{
    index = level.var_efaf119164401d47[ patrolname ].array.size;
    level.var_efaf119164401d47[ patrolname ].array[ index ] = aitoadd;
    aitoadd.grouppatrolname = patrolname;
    ai_formation::function_452107292f74bf20( patrolname, aitoadd, formationtype, columncount, horizontalspacing );
    aitoadd thread function_7dad044b36a45b5b( formationtype, columncount, horizontalspacing );
}

// Namespace ai_group_patrol
// Params 2
// Checksum 0x663f5f92, Offset: 0x17a9
// Size: 0x31
function function_4c4de030ada6ee42( patrolname, customoffsetlist )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::function_4c4de030ada6ee42( patrolname, customoffsetlist );
}

// Namespace ai_group_patrol
// Params 3
// Checksum 0x663f5fcf, Offset: 0x17e2
// Size: 0x3b
function function_48a197da910dcd4d( patrolname, formationslot, customoffset )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::function_48a197da910dcd4d( patrolname, formationslot, customoffset );
}

// Namespace ai_group_patrol
// Params 2
// Checksum 0x663f5f92, Offset: 0x1825
// Size: 0x31
function set_goal( patrolname, goalposition )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    ai_formation::set_goal( patrolname, goalposition );
}

// Namespace ai_group_patrol
// Params 3
// Checksum 0x2ea258df, Offset: 0x185e
// Size: 0x15f
function leave_patrol( patrolname, aitoremove, permanently = 0 )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    if ( !isarray( aitoremove ) )
    {
        aitoremove = [ aitoremove ];
    }
    
    foreach ( ai in aitoremove )
    {
        ai_formation::leave_formation( ai );
        ai clearbtgoal( 1 );
        node = ai.patroltarget;
        
        if ( isdefined( node ) && isdefined( node.interactionid ) )
        {
            despawninteraction( node.interactionid );
            node.interactionid = undefined;
        }
        
        if ( permanently )
        {
            ai notify( #"leave_group_patrol_permanently" );
            continue;
        }
        
        ai notify( #"leave_group_patrol" );
    }
    
    level.var_efaf119164401d47[ patrolname ].array = arrayremove( level.var_efaf119164401d47[ patrolname ].array, aitoremove );
}

// Namespace ai_group_patrol
// Params 0
// Checksum 0x42db092c, Offset: 0x19c5
// Size: 0xbc
function set_patrol_leader()
{
    assert( self.grouppatrolname, "<dev string:xf3>" );
    ai_formation::set_as_leader( self.grouppatrolname );
    
    if ( isdefined( self.patroltarget ) )
    {
        level.var_efaf119164401d47[ self.grouppatrolname ].groupleadertarget = self.patroltarget;
        return;
    }
    
    if ( isdefined( self.spawnpoint.target ) )
    {
        [ level.var_efaf119164401d47[ self.grouppatrolname ].groupleadertarget ] = get_target_goals( self.spawnpoint.target );
    }
}

// Namespace ai_group_patrol
// Params 5
// Checksum 0x712f59ee, Offset: 0x1a89
// Size: 0x8a
function patrol_follow_entity( patrolname, ent, followdistance, timestep, usegoalentity = 0 )
{
    assert( isdefined( patrolname ) && isdefined( level.var_efaf119164401d47[ patrolname ] ), "<dev string:x120>" );
    assert( isdefined( ent ), "<dev string:x138>" );
    
    if ( usegoalentity )
    {
        thread function_9aa3936a09b5606a( patrolname, ent, followdistance, timestep );
        return;
    }
    
    thread function_826e332e24335e2d( patrolname, ent, followdistance, timestep );
}

// Namespace ai_group_patrol
// Params 4, eflags: 0x4
// Checksum 0x24a10231, Offset: 0x1b1b
// Size: 0xf8
function private function_9aa3936a09b5606a( patrolname, ent, followdistance, timestep )
{
    level endon( #"game_ended" );
    self endon( "stop_following_" + patrolname );
    
    if ( ai_formation::follow_entity( patrolname, ent, followdistance, timestep ) )
    {
        foreach ( agent in level.var_efaf119164401d47[ patrolname ].array )
        {
            agent notify( #"following_entity" );
        }
        
        ent utility::waittill_any( "death", "crashing", "entitydeleted" );
        function_6cc0f5f91d199027( patrolname );
    }
}

// Namespace ai_group_patrol
// Params 4, eflags: 0x4
// Checksum 0xb74c6a77, Offset: 0x1c1b
// Size: 0x11d
function private function_826e332e24335e2d( patrolname, ent, followdistance = 100, timestep = 2.5 )
{
    level endon( #"game_ended" );
    self endon( "stop_following_" + patrolname );
    
    foreach ( agent in level.var_efaf119164401d47[ patrolname ].array )
    {
        agent notify( #"following_entity" );
    }
    
    setaiformationleaderfollowdistance( level.formationlist[ patrolname ], followdistance );
    thread function_16d652632f7433e7( patrolname, ent, followdistance, timestep );
    ent utility::waittill_any( "death", "crashing", "entitydeleted" );
    function_6cc0f5f91d199027( patrolname );
}

// Namespace ai_group_patrol
// Params 4, eflags: 0x4
// Checksum 0x13a4d5bf, Offset: 0x1d40
// Size: 0x1a7
function private function_16d652632f7433e7( patrolname, ent, followdistance, timestep )
{
    ent endon( #"death" );
    ent endon( #"crashing" );
    ent endon( #"entitydeleted" );
    level endon( #"game_ended" );
    self endon( "stop_following_" + patrolname );
    notifyname = function_c5974ef8c12299dd( patrolname );
    level endon( notifyname );
    self notify( #"hash_e16d933afdead14d" );
    self endon( #"hash_e16d933afdead14d" );
    
    while ( isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        enthalfsize = ent getboundshalfsize();
        entforward = anglestoforward( ent.angles );
        offset = -1 * ( followdistance + enthalfsize[ 0 ] ) * entforward;
        newgoal = ent.origin + offset;
        newgoal = getclosestpointonnavmesh( newgoal );
        
        if ( level.var_efaf119164401d47[ patrolname ].array.size > 0 )
        {
            leader = get_patrol_leader( patrolname );
            leader setbtgoalpos( 3, newgoal );
            
            if ( isagent( ent ) )
            {
                leader aisetdesiredspeed( length( ent getvelocity() ) );
            }
            else if ( ent vehicle::is_vehicle() )
            {
                leader aisetdesiredspeed( length( ent vehicle_getvelocity() ) );
            }
            else if ( isdefined( ent.speed ) )
            {
                leader aisetdesiredspeed( ent.speed );
            }
        }
        else
        {
            break;
        }
        
        wait timestep;
    }
}

// Namespace ai_group_patrol
// Params 1
// Checksum 0xad0ec82f, Offset: 0x1eef
// Size: 0xd4
function function_6cc0f5f91d199027( patrolname )
{
    if ( ai_formation::unfollow_entity( patrolname ) )
    {
        self notify( "stop_following_" + patrolname );
        setaiformationleaderfollowdistance( level.formationlist[ patrolname ], 0 );
        leader = get_patrol_leader( patrolname );
        leader aiclearscriptdesiredspeed();
        
        foreach ( agent in level.var_efaf119164401d47[ patrolname ].array )
        {
            agent thread function_beeeaf2a07ad3040( patrolname );
        }
    }
}

// Namespace ai_group_patrol
// Params 5
// Checksum 0x2d3f3643, Offset: 0x1fcb
// Size: 0x180
function function_40b916c0c1ec904a( patrolname, formationshape, horizontalseparation, verticalseparation, leaderinfront = 0 )
{
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ] ) )
    {
        return;
    }
    
    numai = level.var_efaf119164401d47[ patrolname ].array.size;
    
    if ( numai == 0 )
    {
        return;
    }
    
    leaderinfront = leaderinfront || formationshape == 1;
    level.var_efaf119164401d47[ patrolname ].formationwidth = ai_formation::function_1fd64dcd55c92197( patrolname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront );
    level.var_efaf119164401d47[ patrolname ].horizontalseparation = horizontalseparation;
    level.var_efaf119164401d47[ patrolname ].verticalseparation = verticalseparation;
    level.var_efaf119164401d47[ patrolname ].var_bf52d366dfa30bb3 = formationshape;
    level.var_efaf119164401d47[ patrolname ].leaderinfront = leaderinfront;
    
    if ( !isdefined( level.var_efaf119164401d47[ patrolname ].var_7df184e702bb256c ) )
    {
        level.var_efaf119164401d47[ patrolname ].var_7df184e702bb256c = formationshape;
    }
    
    if ( formationshape == level.var_efaf119164401d47[ patrolname ].var_7df184e702bb256c )
    {
        level.var_efaf119164401d47[ patrolname ].var_24fb42ff083faeb5 = level.var_efaf119164401d47[ patrolname ].formationwidth;
    }
}

