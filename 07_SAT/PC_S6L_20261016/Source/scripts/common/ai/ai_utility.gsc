// scripts\common\ai\ai_utility.gsc  (hash_169d47bdecd29782.gscc) (size: 16888 Bytes / 0x41f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf423d01 (2940353793)
// size ...... 16888 (0x41f8)
// includes .. 7   (offset: 0x4094)
// strings ... 17  (offset: 0x40cc)
// dev strs .. 5   (offset: 0x41b4)
// exports ... 48  (offset: 0x28bc)
// cseg ...... 0x208 + 0x26b4 (0x28bc)
// imports ... 138 (offset: 0x303c)
// animtree1 . 0   (offset: 0x41f8)
// animtree2 . 0   (offset: 0x41f8)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace ai_utility;

/#

    // Namespace ai_utility
    // Params 0
    // Checksum 0xd7eccd54, Offset: 0x226
    // Size: 0x5, Type: dev
    function function_5ffc0a348e13e444()
    {
        
    }

#/

// Namespace ai_utility
// Params 4
// Checksum 0xf7b44e5f, Offset: 0x233
// Size: 0x87
function go_to_node( nodes, optional_arrived_at_node_func, start_moving_func, override_start_node )
{
    if ( !isdefined( nodes ) )
    {
        nodes = [];
        
        if ( isdefined( self.target ) )
        {
            nodes = get_target_goals( self.target );
        }
        
        if ( nodes.size == 0 )
        {
            self notify( #"reached_path_end" );
            return;
        }
    }
    else if ( !isarray( nodes ) )
    {
        nodes = [ nodes ];
    }
    
    go_to_node_internal( nodes, optional_arrived_at_node_func, start_moving_func, override_start_node );
}

// Namespace ai_utility
// Params 4
// Checksum 0x6aee8a50, Offset: 0x2c2
// Size: 0x3cd
function go_to_node_internal( node, optional_arrived_at_node_func, start_moving_func, override_start_node )
{
    self notify( #"stop_going_to_node" );
    self endon( #"stop_going_to_node" );
    self endon( #"death" );
    self endon( #"hash_1432c75a80e7fb47" );
    
    if ( !isarray( node ) )
    {
        node = [ node ];
    }
    
    if ( isdefined( override_start_node ) )
    {
        startnode = override_start_node;
    }
    else
    {
        startnode = node[ 0 ];
    }
    
    thread go_to_node_end();
    usingpatharray = 0;
    patharray = undefined;
    self.interactionplayed = undefined;
    
    for ( ;; )
    {
        if ( !usingpatharray )
        {
            if ( isdefined( level.get_next_node_override ) )
            {
                node = [[ level.get_next_node_override ]]( node );
            }
            else
            {
                node = get_least_used_from_array( node );
            }
            
            self.patharraystartnode = startnode;
            patharray = get_path_array( node, startnode );
            self.patharray = patharray;
            self.patharrayindex = -1;
            
            if ( patharray.size > 1 )
            {
                usingpatharray = 1;
            }
        }
        
        self.currentnode = node;
        
        if ( isdefined( node.interaction ) && ( !isdefined( node.interactionid ) || !function_e0737745ca681ec7( node.interactionid ) ) )
        {
            angles = node.angles;
            
            if ( !isdefined( angles ) )
            {
                angles = ( 0, 0, 0 );
            }
            
            interactiontoks = strtok( node.interaction, "+" );
            interaction = utility::array_random( interactiontoks );
            node.interactionid = spawninteraction( interaction, node.origin, angles );
            self.customarrivalangles = angles;
        }
        
        if ( usingpatharray )
        {
            node = patharray[ patharray.size - 1 ];
            go_through_patharray( patharray, optional_arrived_at_node_func, start_moving_func );
            patharray = undefined;
            usingpatharray = 0;
        }
        else
        {
            node_fields_pre_goal( node );
            
            if ( isdefined( self.stealth ) )
            {
                callbacks::stealth_call( "go_to_node_wait", &go_to_node_set_goal, node );
            }
            else
            {
                go_to_node_set_goal( node );
                self waittill( #"goal" );
            }
        }
        
        node notify( #"trigger", self );
        node_fields_after_goal( node, optional_arrived_at_node_func );
        interactionid = self getinteractionid();
        
        if ( isdefined( interactionid ) )
        {
            self waittill( #"bseq_user_deleted" );
        }
        else if ( !isdefined( node.interactionid ) && !isdefined( node.interaction ) )
        {
            node utility::script_delay();
        }
        
        if ( isdefined( node.script_flag_wait ) )
        {
            utility::flag_wait( node.script_flag_wait );
        }
        
        if ( isdefined( node.script_flag_waitopen ) )
        {
            utility::flag_waitopen( node.script_flag_waitopen );
        }
        
        if ( isdefined( node.script_ent_flag_wait ) )
        {
            utility::ent_flag_wait( node.script_ent_flag_wait );
        }
        
        if ( isdefined( node.var_8a58f20e06232412 ) )
        {
            utility::ent_flag_waitopen_any( node.var_8a58f20e06232412 );
        }
        
        node utility::script_wait();
        node_fields_after_goal_and_wait( node, start_moving_func );
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        nextnode_array = get_target_goals( node.target );
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = nextnode_array;
    }
    
    self notify( #"reached_path_end" );
    
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    volume = self getgoalvolume();
    
    if ( isdefined( volume ) )
    {
        self setgoalvolumeauto( volume, volume ai::get_cover_volume_forward() );
        return;
    }
    
    self.goalradius = level.default_goalradius;
}

// Namespace ai_utility
// Params 3
// Checksum 0x2d01d0b9, Offset: 0x697
// Size: 0x1f0
function go_through_patharray( patharray, optional_arrived_at_node_func, start_moving_func )
{
    self setgoalpath( patharray );
    
    foreach ( index, tempnode in patharray )
    {
        node_fields_pre_goal( tempnode );
        
        if ( index == 0 )
        {
            while ( self.arriving )
            {
                waitframe();
            }
        }
        
        if ( isdefined( tempnode.interaction ) && ( !isdefined( tempnode.interactionid ) || !function_e0737745ca681ec7( tempnode.interactionid ) ) )
        {
            angles = tempnode.angles;
            
            if ( !isdefined( angles ) )
            {
                angles = ( 0, 0, 0 );
            }
            
            interactiontoks = strtok( tempnode.interaction, "+" );
            interaction = utility::array_random( interactiontoks );
            tempnode.interactionid = spawninteraction( interaction, tempnode.origin, angles );
            self.customarrivalangles = angles;
        }
        
        patharrayindex = waittill_subgoal();
        self.patharrayindex = patharrayindex;
        
        if ( isdefined( self.patharray ) && !isdefined( self.patharrayindex ) )
        {
            self.patharrayindex = self.patharray.size - 1;
        }
        
        if ( index == patharray.size - 1 )
        {
            self waittill( #"goal" );
            break;
        }
        
        tempnode notify( #"trigger", self );
        function_9a951138b78ca0c5( tempnode, optional_arrived_at_node_func );
        node_fields_after_goal_and_wait( tempnode, start_moving_func );
    }
}

// Namespace ai_utility
// Params 2
// Checksum 0xc777ca6c, Offset: 0x88f
// Size: 0x21
function function_9a951138b78ca0c5( node, optional_arrived_at_node_func )
{
    node_fields_after_goal( node, optional_arrived_at_node_func, 1 );
}

// Namespace ai_utility
// Params 3
// Checksum 0x3bf5aa48, Offset: 0x8b8
// Size: 0x16b
function node_fields_after_goal( node, optional_arrived_at_node_func, skip_next_goal )
{
    if ( isdefined( self.stealth ) )
    {
        callbacks::stealth_call( "go_to_node_arrive", &go_to_node_set_goal, node );
    }
    
    if ( !skip_next_goal )
    {
        if ( isdefined( node.interactionid ) || isdefined( node.interaction ) )
        {
            node utility::script_delay();
            ai::go_to_interaction( &go_to_node_set_goal, node );
        }
        else
        {
            go_to_node_set_goal();
            self waittill( #"goal" );
        }
    }
    
    if ( isdefined( optional_arrived_at_node_func ) )
    {
        [[ optional_arrived_at_node_func ]]( node );
    }
    
    if ( isdefined( self.pre_wait_func ) )
    {
        [[ self.pre_wait_func ]]( node );
    }
    
    if ( isdefined( node.script_flag_set ) )
    {
        utility::flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_set ) )
    {
        utility::ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_clear ) )
    {
        utility::ent_flag_clear( node.script_ent_flag_clear );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        utility::flag_clear( node.script_flag_clear );
    }
    
    if ( isdefined( node.var_cdcf18f42118e6ac ) )
    {
        ai::function_4aca9a055eaa9c89( node.var_cdcf18f42118e6ac );
    }
    
    if ( targets_and_uses_turret( node ) )
    {
        return 1;
    }
}

// Namespace ai_utility
// Params 2
// Checksum 0x1af1fbb, Offset: 0xa2b
// Size: 0xce
function ai_delete_when_out_of_sight( ai_array, fdist )
{
    if ( !isdefined( ai_array ) )
    {
        return;
    }
    
    var_3f2bb9b43f8c6900 = 0.75;
    
    while ( ai_array.size > 0 )
    {
        wait 1;
        
        for ( i = 0; i < ai_array.size ; i++ )
        {
            if ( !isalive( ai_array[ i ] ) )
            {
                ai_array = arrayremove( ai_array, ai_array[ i ] );
                continue;
            }
            
            if ( players_within_distance( fdist, ai_array[ i ].origin ) )
            {
                continue;
            }
            
            if ( either_player_looking_at( ai_array[ i ].origin + ( 0, 0, 48 ), var_3f2bb9b43f8c6900, 1 ) )
            {
                continue;
            }
            
            ai_array[ i ] delete_ai();
            ai_array = arrayremove( ai_array, ai_array[ i ] );
        }
    }
}

// Namespace ai_utility
// Params 0
// Checksum 0x464d7bf5, Offset: 0xb01
// Size: 0x30
function delete_ai()
{
    if ( isagent( self ) )
    {
        ai::function_dd7b3233e5b07718( 1 );
        return;
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        ai::stop_magic_bullet_shield();
    }
    
    self delete();
}

// Namespace ai_utility
// Params 1
// Checksum 0x2f03e7c4, Offset: 0xb39
// Size: 0x8f
function go_to_node_set_goal( ent )
{
    if ( isnode( ent ) )
    {
        go_to_node_set_goal_node( ent );
    }
    else if ( isstruct( ent ) )
    {
        go_to_node_set_goal_pos( ent );
    }
    else if ( isent( ent ) )
    {
        go_to_node_set_goal_ent( ent );
    }
    else if ( ent.classname == "noent_volume_info" )
    {
        function_2c41d114b22349ce( ent );
    }
    
    if ( isstruct( ent ) || isnode( ent ) )
    {
        ent.patrol_stop = go_to_node_should_stop( ent );
    }
}

// Namespace ai_utility
// Params 1
// Checksum 0x28b23041, Offset: 0xbd0
// Size: 0x28
function function_2c41d114b22349ce( ent )
{
    self setgoalvolumeauto( ent, ent ai::get_cover_volume_forward() );
    self notify( #"go_to_node_new_goal" );
}

// Namespace ai_utility
// Params 1
// Checksum 0xe91aead5, Offset: 0xc00
// Size: 0x46
function go_to_node_set_goal_ent( ent )
{
    if ( ent.code_classname == "info_volume" )
    {
        self setgoalvolumeauto( ent, ent ai::get_cover_volume_forward() );
        self notify( #"go_to_node_new_goal" );
        return;
    }
    
    go_to_node_set_goal_pos( ent );
}

// Namespace ai_utility
// Params 1
// Checksum 0xe485c4d0, Offset: 0xc4e
// Size: 0x21
function go_to_node_set_goal_pos( ent )
{
    set_goal_ent( ent );
    self notify( #"go_to_node_new_goal" );
}

// Namespace ai_utility
// Params 1
// Checksum 0x95680186, Offset: 0xc77
// Size: 0x21
function go_to_node_set_goal_node( node )
{
    set_goal_node( node );
    self notify( #"go_to_node_new_goal" );
}

// Namespace ai_utility
// Params 1
// Checksum 0x4450222b, Offset: 0xca0
// Size: 0x33
function set_goal_node( node )
{
    self.last_set_goalnode = node;
    self.last_set_goalpos = undefined;
    self.last_set_goalent = undefined;
    self setgoalnode( node );
}

// Namespace ai_utility
// Params 1
// Checksum 0x4bc1e131, Offset: 0xcdb
// Size: 0x54
function set_goal_ent( target )
{
    set_goal_pos( target.origin );
    self.last_set_goalent = target;
    
    if ( isstruct( target ) && !isdefined( target.type ) )
    {
        target.type = "struct";
    }
}

// Namespace ai_utility
// Params 1
// Checksum 0x8494b499, Offset: 0xd37
// Size: 0x33
function set_goal_pos( origin )
{
    self.last_set_goalnode = undefined;
    self.last_set_goalpos = origin;
    self.last_set_goalent = undefined;
    self setgoalpos( origin );
}

// Namespace ai_utility
// Params 2
// Checksum 0x972d0f10, Offset: 0xd72
// Size: 0x215, Type: bool
function go_to_node_wait_for_player( node, get_target_func )
{
    if ( distancesquared( level.player.origin, node.origin ) < distancesquared( self.origin, node.origin ) )
    {
        return true;
    }
    
    if ( !isdefined( node.script_dist_only ) )
    {
        vec = anglestoforward( self.angles );
        
        if ( isdefined( node.target ) )
        {
            temp = [[ get_target_func ]]( node.target );
            
            if ( temp.size == 1 )
            {
                vec = vectornormalize( temp[ 0 ].origin - node.origin );
            }
            else if ( isdefined( node.angles ) )
            {
                vec = anglestoforward( node.angles );
            }
        }
        else if ( isdefined( node.angles ) )
        {
            vec = anglestoforward( node.angles );
        }
        
        vec2 = [];
        vec2[ vec2.size ] = vectornormalize( level.player.origin - self.origin );
        
        foreach ( value in vec2 )
        {
            if ( vectordot( vec, value ) > 0 )
            {
                return true;
            }
        }
    }
    
    dist = 32;
    
    if ( node.script_requires_player > dist )
    {
        dist = node.script_requires_player;
    }
    
    if ( distancesquared( level.player.origin, self.origin ) < squared( dist ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_utility
// Params 2
// Checksum 0x679e7dab, Offset: 0xf90
// Size: 0x15a
function node_fields_after_goal_and_wait( node, start_moving_func )
{
    if ( isdefined( node.script_soundalias ) )
    {
        self playsound( node.script_soundalias );
    }
    
    if ( isdefined( self.stealth ) )
    {
        callbacks::stealth_call( "go_to_node_post_wait", &go_to_node_set_goal, node );
    }
    
    if ( isdefined( self.post_wait_func ) )
    {
        [[ self.post_wait_func ]]( node );
    }
    
    if ( isdefined( node.script_delay_post ) )
    {
        wait node.script_delay_post;
    }
    
    while ( isdefined( node.script_requires_player ) )
    {
        if ( go_to_node_wait_for_player( node, &get_target_goals ) )
        {
            node notify( #"script_requires_player" );
            break;
        }
        
        wait 0.1;
    }
    
    if ( isdefined( node.script_demeanor_post ) )
    {
        if ( node.script_demeanor_post == "cqb" )
        {
            utility::enable_cqbwalk();
        }
        else
        {
            utility::demeanor_override( node.script_demeanor_post );
        }
    }
    
    if ( isdefined( start_moving_func ) )
    {
        [[ start_moving_func ]]( node );
    }
    
    if ( node.script_death )
    {
        die();
    }
    
    if ( node.script_delete )
    {
        if ( node.script_nosight )
        {
            level thread ai_delete_when_out_of_sight( [ self ], 350 );
            return;
        }
        
        delete_ai();
    }
}

// Namespace ai_utility
// Params 0
// Checksum 0xbd8a3575, Offset: 0x10f2
// Size: 0x29
function waittill_subgoal()
{
    self endon( #"goal" );
    self waittill( #"subgoal", index );
    return index;
}

// Namespace ai_utility
// Params 1
// Checksum 0xc61a3d01, Offset: 0x1124
// Size: 0x2a2
function node_fields_pre_goal( node )
{
    if ( isdefined( node.radius ) )
    {
        self.goalradius = node.radius;
    }
    
    if ( isdefined( node.height ) )
    {
        self.goalheight = node.height;
    }
    
    if ( isdefined( node.script_demeanor ) )
    {
        if ( node.script_demeanor == "cqb" )
        {
            utility::enable_cqbwalk();
        }
        else
        {
            utility::demeanor_override( node.script_demeanor );
        }
    }
    
    if ( isdefined( node.script_civilian_state ) )
    {
        asm_bb::bb_setcivilianstate( node.script_civilian_state );
    }
    
    if ( isdefined( node.script_pacifist ) )
    {
        self.pacifist = node.script_pacifist;
    }
    
    if ( isdefined( node.script_ignoreall ) )
    {
        ai::set_ignoreall( node.script_ignoreall );
    }
    
    if ( isdefined( node.script_ignoreme ) )
    {
        ai::set_ignoreme( node.script_ignoreme );
    }
    
    if ( isdefined( node.script_moveplaybackrate ) )
    {
        set_moveplaybackrate( node.script_moveplaybackrate, 0.25 );
    }
    
    if ( isdefined( node.script_speed ) )
    {
        utility::set_movement_speed( node.script_speed );
    }
    
    if ( isdefined( node.script_gunpose ) )
    {
        ai::set_gunpose( node.script_gunpose );
    }
    
    if ( isdefined( node.script_disable_arrivals ) )
    {
        if ( node.script_disable_arrivals )
        {
            ai::disable_arrivals();
        }
        else
        {
            self.disablearrivals = 0;
        }
    }
    
    if ( isdefined( node.script_disable_exits ) )
    {
        if ( node.script_disable_exits )
        {
            ai::disable_exits();
        }
        else
        {
            ai::enable_exits();
        }
    }
    
    if ( isdefined( node.script_combatmode ) )
    {
        self.combatmode = node.script_combatmode;
    }
    
    if ( isdefined( node.script_forcegoal ) )
    {
        assert( isdefined( node.targetname ) );
        self.target = node.targetname;
    }
    
    if ( isdefined( self.pre_goal_func ) )
    {
        thread [[ self.pre_goal_func ]]();
    }
    
    if ( isdefined( node.script_scenescriptbundle ) )
    {
        if ( isdefined( level.scene ) && isdefined( level.scene.fnsceneplay ) )
        {
            node [[ level.scene.fnsceneplay ]]( [ self ] );
        }
    }
}

// Namespace ai_utility
// Params 2
// Checksum 0x70a9bb6, Offset: 0x13ce
// Size: 0x159
function get_path_array( node, startnode )
{
    array = [];
    count = 0;
    
    while ( true )
    {
        if ( node.code_classname == "info_volume" )
        {
            break;
        }
        
        array[ array.size ] = node;
        count++;
        
        if ( count == 16 )
        {
            break;
        }
        
        if ( !node.var_433da69892ae9b9f )
        {
            if ( isdefined( node.target ) )
            {
                node.interactionid = getinteractionidfortargetname( node.target );
                node.interactionidarray = getinteractionidsfortargetname( node.target );
            }
            
            node.var_433da69892ae9b9f = 1;
        }
        
        if ( isdefined( node.interactionid ) )
        {
            break;
        }
        
        if ( go_to_node_should_stop( node ) )
        {
            break;
        }
        
        if ( node == startnode )
        {
            if ( array.size > 1 )
            {
                break;
            }
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        nextnode_array = get_target_goals( node.target );
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        if ( isdefined( level.get_next_node_override ) )
        {
            node = [[ level.get_next_node_override ]]( nextnode_array );
            continue;
        }
        
        node = get_least_used_from_array( nextnode_array );
    }
    
    return array;
}

// Namespace ai_utility
// Params 1
// Checksum 0xcdd18b30, Offset: 0x1530
// Size: 0x15a, Type: bool
function go_to_node_should_stop( arrivaltarget )
{
    if ( !isdefined( arrivaltarget ) )
    {
        return true;
    }
    
    if ( !isdefined( arrivaltarget.target ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_add ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_waitopen ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_ent_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_post ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_requires_player ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_idle ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_stopnode ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.interaction ) || isdefined( arrivaltarget.interactionid ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_scenescriptbundle ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_utility
// Params 1
// Checksum 0x20d472b3, Offset: 0x1693
// Size: 0xfd
function get_least_used_from_array( array )
{
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    array = arrayrandomize( array );
    least_used = array[ 0 ];
    
    if ( !isdefined( least_used.used_time ) )
    {
        least_used.used_time = 0;
    }
    
    foreach ( node in array )
    {
        if ( !isdefined( node.used_time ) )
        {
            node.used_time = 0;
        }
        
        if ( node.used_time < least_used.used_time )
        {
            least_used = node;
        }
    }
    
    least_used.used_time = gettime();
    return least_used;
}

// Namespace ai_utility
// Params 1
// Checksum 0x132ef92d, Offset: 0x1799
// Size: 0x1ab
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
    
    new_goals = getnoentvolumearray( target, #targetname );
    
    foreach ( new in new_goals )
    {
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace ai_utility
// Params 1
// Checksum 0x1fd51c4b, Offset: 0x194d
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

// Namespace ai_utility
// Params 0
// Checksum 0xef01e299, Offset: 0x19b4
// Size: 0x50
function go_to_node_end()
{
    self endon( #"death" );
    waittillframeend();
    self.using_goto_node = 1;
    utility::waittill_any( "reached_path_end", "stop_going_to_node" );
    self.using_goto_node = undefined;
    self.patharray = undefined;
    self.patharrayindex = undefined;
    thread function_f114f9f169e6aeb1();
}

// Namespace ai_utility
// Params 0
// Checksum 0x7d7047d5, Offset: 0x1a0c
// Size: 0xab
function function_f114f9f169e6aeb1()
{
    self endon( #"death" );
    
    if ( isdefined( self.currentnode ) && isdefined( self.currentnode.interactionid ) && isdefined( self.currentnode.interaction ) )
    {
        if ( isdefined( self getinteractionid() ) )
        {
            self waittill( #"bseq_user_deleted" );
        }
        
        if ( isdefined( self.currentnode.interactionid ) )
        {
            despawninteraction( self.currentnode.interactionid );
            self.currentnode.interactionid = undefined;
        }
    }
    
    self.currentnode = undefined;
}

// Namespace ai_utility
// Params 4
// Checksum 0xa0e81ed8, Offset: 0x1abf
// Size: 0xdb
function player_looking_at( start, dot = 0.8, dot_only, ignore_ent )
{
    player = get_player_from_self();
    end = player geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = player getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    if ( isdefined( dot_only ) )
    {
        assert( dot_only, "<dev string:x24>" );
        return 1;
    }
    
    return trace::ray_trace_detail_passed( start, end, ignore_ent, trace::create_default_contents( 1 ) );
}

// Namespace ai_utility
// Params 4
// Checksum 0x644df15, Offset: 0x1ba3
// Size: 0x68, Type: bool
function either_player_looking_at( org, dot, dot_only, ignore_ent )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] player_looking_at( org, dot, dot_only, ignore_ent ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_utility
// Params 2
// Checksum 0x6a361a73, Offset: 0x1c14
// Size: 0x6c, Type: bool
function players_within_distance( fdist, org )
{
    fdistsquared = fdist * fdist;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( distancesquared( org, level.players[ i ].origin ) < fdistsquared )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_utility
// Params 0, eflags: 0x4
// Checksum 0x650e0872, Offset: 0x1c89
// Size: 0x15
function private die()
{
    self kill( ( 0, 0, 0 ) );
}

// Namespace ai_utility
// Params 0, eflags: 0x4
// Checksum 0x6039096b, Offset: 0x1ca6
// Size: 0x37
function private get_player_from_self()
{
    if ( isdefined( self ) )
    {
        if ( !arraycontains( level.players, self ) )
        {
            return level.player;
        }
        else
        {
            return self;
        }
        
        return;
    }
    
    return level.players[ 0 ];
}

// Namespace ai_utility
// Params 2
// Checksum 0x578d9edd, Offset: 0x1ce5
// Size: 0xc4
function set_moveplaybackrate( rate, time )
{
    self notify( #"set_moveplaybackrate" );
    self endon( #"set_moveplaybackrate" );
    self endon( #"death" );
    
    if ( isdefined( time ) )
    {
        current_rate = asm::asm_getmoveplaybackrate();
        range = rate - current_rate;
        interval = 0.05;
        numcycles = time / interval;
        fraction = range / numcycles;
        
        while ( abs( rate - current_rate ) > abs( fraction * 1.1 ) )
        {
            asm::asm_setmoveplaybackrate( current_rate + fraction );
            wait interval;
            current_rate = asm::asm_getmoveplaybackrate();
        }
    }
    
    asm::asm_setmoveplaybackrate( rate );
}

// Namespace ai_utility
// Params 1
// Checksum 0x9cb08c38, Offset: 0x1db1
// Size: 0xb6
function targets_and_uses_turret( node )
{
    if ( !isdefined( node.target ) )
    {
        return 0;
    }
    
    turrets = getentarray( node.target, #targetname );
    
    if ( !turrets.size )
    {
        return 0;
    }
    
    turret = turrets[ 0 ];
    
    if ( !issubstr( turret.classname, "misc_turret" ) )
    {
        return 0;
    }
    
    if ( isdefined( level.go_to_node_funcs.use_turret_func ) )
    {
        [[ level.go_to_node_funcs.use_turret_func ]]( turret );
        return 1;
    }
    
    assertmsg( "<dev string:x47>" );
    return 0;
}

/#

    // Namespace ai_utility
    // Params 0
    // Checksum 0xf67ba2a6, Offset: 0x1e6f
    // Size: 0x5, Type: dev
    function function_4f932967d48eb6c3()
    {
        
    }

#/

// Namespace ai_utility
// Params 7
// Checksum 0x4c0ab5d0, Offset: 0x1e7c
// Size: 0xd2
function enable_dynamic_run_speed( followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist )
{
    setdvarifuninitialized( @"hash_c459efa5216607ee", 0 );
    disable_dynamic_run_speed( 0 );
    
    if ( !isdefined( minspeed ) )
    {
        minspeed = 0;
    }
    
    if ( !isdefined( midspeed ) )
    {
        midspeed = 205;
    }
    
    if ( !isdefined( maxspeed ) )
    {
        maxspeed = 250;
    }
    
    if ( !isdefined( frontdist ) )
    {
        frontdist = 100;
    }
    
    if ( !isdefined( middist ) )
    {
        middist = -100;
    }
    
    if ( !isdefined( backdist ) )
    {
        backdist = -200;
    }
    
    assert( frontdist > middist, "<dev string:x6a>" );
    assert( frontdist > backdist, "<dev string:x6a>" );
    assert( middist > backdist, "<dev string:x6a>" );
    thread dynamic_run_speed_thread( followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist );
}

// Namespace ai_utility
// Params 1
// Checksum 0x6446eb27, Offset: 0x1f56
// Size: 0x4c
function disable_dynamic_run_speed( speed )
{
    /#
        if ( getdvarint( @"hash_c459efa5216607ee" ) )
        {
            iprintln( "<dev string:x90>" );
        }
    #/
    
    if ( !isdefined( speed ) )
    {
        speed = 165;
    }
    
    self notify( #"hash_9589bc8541210b45" );
    
    if ( speed )
    {
        utility::set_movement_speed( speed );
    }
}

// Namespace ai_utility
// Params 7
// Checksum 0x5e09d1e5, Offset: 0x1faa
// Size: 0x27b
function dynamic_run_speed_set( followent, forwarddist, backdist, dir, maxspeed, minspeed, isbehind )
{
    debugangles = vectortoangles( dir );
    debugright = anglestoright( debugangles );
    forwardpos = self.origin + dir * forwarddist;
    backpos = self.origin + dir * backdist;
    playerpos = pointonsegmentnearesttopoint( forwardpos, backpos, followent.origin );
    dist = distance( forwardpos, playerpos );
    totaldist = forwarddist - backdist;
    scale = 1 - math::lerp_fraction( 0, abs( totaldist ), dist );
    speed = math::lerp( minspeed, maxspeed, scale );
    speed = clamp( speed, 23, 250 );
    stopspeed = 30;
    minmovespeed = stopspeed + 1;
    
    if ( isbehind && speed <= stopspeed )
    {
        if ( !self.var_f18ea5190644189e )
        {
            utility::set_movement_speed( 0 );
            self.var_f18ea5190644189e = 1;
        }
    }
    else if ( speed >= minmovespeed )
    {
        if ( self.var_f18ea5190644189e )
        {
            self notify( #"hash_49ea0b69ede1a17e" );
            self.var_f18ea5190644189e = undefined;
        }
        
        if ( self.var_3fd87fc375bc09a )
        {
            if ( speed <= stopspeed )
            {
                if ( !self.var_4113ef8dccf5cb1d )
                {
                    self.var_4113ef8dccf5cb1d = gettime() + 800;
                }
                
                speed = 0;
            }
            
            if ( self.var_4113ef8dccf5cb1d )
            {
                if ( gettime() <= self.var_4113ef8dccf5cb1d )
                {
                    speed = 0;
                }
                else
                {
                    self.var_4113ef8dccf5cb1d = undefined;
                }
            }
        }
        
        utility::set_movement_speed( speed );
    }
    
    /#
        if ( getdvarint( @"hash_c459efa5216607ee" ) )
        {
            line( forwardpos + debugright * 100, forwardpos + debugright * -100, ( 0.9, 0.9, 0 ) );
            line( backpos + debugright * 100, backpos + debugright * -100, ( 0.9, 0.9, 0 ) );
            line( followent.origin, playerpos );
            print3d( playerpos + ( 0, 0, -4 ), speed, ( 0.9, 0.9, 0.9 ), 0.9, 0.4 );
        }
    #/
}

// Namespace ai_utility
// Params 7
// Checksum 0x20c7ed54, Offset: 0x222d
// Size: 0x1c8
function dynamic_run_speed_thread( followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist )
{
    self endon( #"death" );
    self endon( #"hash_9589bc8541210b45" );
    followent endon( #"death" );
    scale = 1;
    dir = anglestoforward( self.angles );
    self.var_f18ea5190644189e = 0;
    
    while ( true )
    {
        goalpos = dynamic_run_speed_goalpos();
        
        if ( distancesquared( goalpos, self.origin ) > 0 )
        {
            /#
                if ( getdvarint( @"hash_c459efa5216607ee" ) )
                {
                    line( self.origin, goalpos, ( 0.9, 0.9, 0.9 ) );
                    print3d( goalpos, "<dev string:xa7>", ( 0.9, 0.9, 0.9 ), 0.9, 0.4 );
                }
            #/
            
            goalpos2d = utility::flat_origin( goalpos );
            origin2d = utility::flat_origin( self.origin );
            
            if ( distancesquared( goalpos2d, origin2d ) > 100 )
            {
                dir = vectornormalize( goalpos2d - origin2d );
            }
            
            midpos = self.origin + dir * middist;
            relativedir = vectornormalize( followent.origin - midpos );
            dot = vectordot( relativedir, dir );
            
            if ( dot > 0 )
            {
                dynamic_run_speed_set( followent, frontdist, middist, dir, maxspeed, midspeed, 0 );
            }
            else
            {
                dynamic_run_speed_set( followent, middist, backdist, dir, midspeed, minspeed, 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace ai_utility
// Params 0
// Checksum 0x3f237da8, Offset: 0x23fd
// Size: 0x66
function dynamic_run_speed_goalpos()
{
    goalpos = undefined;
    
    if ( isdefined( self.follow_ent ) )
    {
        goalpos = self.follow_ent.origin;
    }
    else if ( isdefined( self.goalnode ) )
    {
        goalpos = self.goalnode.origin;
    }
    else
    {
        goalpos = self.scriptgoalpos;
    }
    
    return goalpos;
}

/#

    // Namespace ai_utility
    // Params 0
    // Checksum 0xf55a1497, Offset: 0x246c
    // Size: 0x5, Type: dev
    function function_e5dc9c442543be0d()
    {
        
    }

#/

// Namespace ai_utility
// Params 1
// Checksum 0x779ce9c3, Offset: 0x2479
// Size: 0x149
function player_seek_enable( var_d579aad656a3eb44 = 0 )
{
    self notify( #"hash_6b499989f0fd0bfd" );
    self endon( #"hash_6b499989f0fd0bfd" );
    
    if ( utility::ent_flag( "player_seek" ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"stop_player_seek" );
    self endon( #"entitydeleted" );
    self.og_goalradius = self.goalradius;
    utility::ent_flag_set( "player_seek" );
    self setgoalpos( self.origin );
    
    if ( !var_d579aad656a3eb44 )
    {
        self.defaultcoverselector = "cover_flank";
    }
    
    if ( !isdefined( self.enemy ) || isplayer( self.enemy ) )
    {
        childthread _player_seek_thread();
    }
    else
    {
        self.goalradius = self.og_goalradius;
        self setgoalentity( self.enemy );
    }
    
    while ( true )
    {
        self waittill( #"enemy" );
        
        if ( !isdefined( self.enemy ) || isplayer( self.enemy ) )
        {
            childthread _player_seek_thread();
            continue;
        }
        
        self.goalradius = self.og_goalradius;
        self setgoalentity( self.enemy );
    }
}

// Namespace ai_utility
// Params 0, eflags: 0x4
// Checksum 0xfc86d61, Offset: 0x25ca
// Size: 0x141
function private _player_seek_thread()
{
    self endon( #"enemy" );
    n_min_radius = 600;
    
    if ( isdefined( self.weapon ) )
    {
        switch ( weaponclass( self.weapon ) )
        {
            case #"hash_690c0d6a821b42e":
            case #"hash_719417cb1de832b6":
                n_min_radius = 250;
                break;
            case #"hash_6191aaef9f922f96":
            case #"hash_61e969dacaaf9881":
            case #"hash_f4b0076c03d93738":
                n_min_radius = 1200;
                break;
            default:
                break;
        }
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return;
    }
    
    if ( self.enemy.sessionstate != "playing" )
    {
        return;
    }
    
    n_goal_radius = distance( self.origin, self.enemy.origin );
    
    while ( isdefined( self.enemy ) )
    {
        wait 2;
        self.goalradius = n_goal_radius;
        self setgoalentity( self.enemy );
        n_goal_radius -= 175;
        
        if ( n_goal_radius < n_min_radius )
        {
            n_goal_radius = n_min_radius;
            return;
        }
    }
}

// Namespace ai_utility
// Params 0
// Checksum 0xd25ae426, Offset: 0x2713
// Size: 0x49
function player_seek_disable()
{
    if ( !utility::ent_flag( "player_seek" ) )
    {
        return;
    }
    
    utility::ent_flag_clear( "player_seek" );
    self notify( #"stop_player_seek" );
    
    if ( isdefined( self.og_goalradius ) )
    {
        self.goalradius = self.og_goalradius;
    }
}

/#

    // Namespace ai_utility
    // Params 0
    // Checksum 0xbbaee885, Offset: 0x2764
    // Size: 0x5, Type: dev
    function function_31a8308d24a2bcd1()
    {
        
    }

#/

// Namespace ai_utility
// Params 0
// Checksum 0xb4e4fd7a, Offset: 0x2771
// Size: 0x39
function get_power_tier()
{
    if ( utility::issharedfuncdefined( #"ai", #"getpowertier" ) )
    {
        return self [[ utility::getsharedfunc( #"ai", #"getpowertier" ) ]]();
    }
}

// Namespace ai_utility
// Params 0
// Checksum 0x1c5653bf, Offset: 0x27b2
// Size: 0x109
function get_ai_tier()
{
    agent_tier = get_power_tier();
    
    if ( agent_tier )
    {
        if ( self.type == "human" && agent_tier > 1 )
        {
            return ( agent_tier - 1 );
        }
        
        return agent_tier;
    }
    
    if ( self.type == "zombie" && isdefined( self.aicategory ) )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                return 1;
            case #"hash_8c089e813083e510":
                return 2;
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
                return 3;
            case #"hash_7e8a002ed096276c":
                return 4;
        }
    }
    else if ( self.type == "human" && isdefined( self.unittype ) )
    {
        switch ( self.unittype )
        {
            case #"hash_44aaeb0edd152195":
                return 1;
            case #"hash_4ad475e6e15635bd":
                return 2;
        }
    }
    
    return 0;
}

