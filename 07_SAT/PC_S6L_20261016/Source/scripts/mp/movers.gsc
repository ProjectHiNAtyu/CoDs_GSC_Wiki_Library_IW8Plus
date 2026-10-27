// scripts\mp\movers.gsc  (hash_5a11116778a6d864.gscc) (size: 19420 Bytes / 0x4bdc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3fd37f0 (2751281136)
// size ...... 19420 (0x4bdc)
// includes .. 11  (offset: 0x48bc)
// strings ... 49  (offset: 0x4914)
// dev strs .. 1   (offset: 0x4bd0)
// exports ... 53  (offset: 0x2ffc)
// cseg ...... 0x36b + 0x2c91 (0x2ffc)
// imports ... 140 (offset: 0x3844)
// animtree1 . 0   (offset: 0x4bdc)
// animtree2 . 0   (offset: 0x4bdc)
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\weapons;

#namespace movers;

// Namespace movers
// Params 0
// Checksum 0x9c7a94f5, Offset: 0x389
// Size: 0x176
function main()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return;
    }
    
    level.script_mover_defaults = [];
    level.script_mover_defaults[ "move_time" ] = 5;
    level.script_mover_defaults[ "accel_time" ] = 0;
    level.script_mover_defaults[ "decel_time" ] = 0;
    level.script_mover_defaults[ "wait_time" ] = 0;
    level.script_mover_defaults[ "delay_time" ] = 0;
    level.script_mover_defaults[ "usable" ] = 0;
    level.script_mover_defaults[ "hintstring" ] = "activate";
    script_mover_add_hintstring( "activate", &"mp/activate_mover" );
    script_mover_add_parameters( "none", "" );
    level.script_mover_named_goals = [];
    waitframe();
    movers = [];
    classnames = script_mover_classnames();
    
    foreach ( class in classnames )
    {
        movers = arraycombine( movers, getentarray( class, #classname ) );
    }
    
    utility::array_thread( movers, &script_mover_int );
}

// Namespace movers
// Params 0
// Checksum 0x587af685, Offset: 0x507
// Size: 0x15
function script_mover_classnames()
{
    return [ "script_model_mover", "script_brushmodel_mover" ];
}

// Namespace movers
// Params 0
// Checksum 0x7d783361, Offset: 0x525
// Size: 0xb5
function script_mover_is_script_mover()
{
    var_7237854e3be197ca = self.script_mover;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    classnames = script_mover_classnames();
    
    foreach ( class in classnames )
    {
        if ( self.classname == class )
        {
            self.script_mover = 1;
            return 1;
        }
    }
    
    return 0;
}

// Namespace movers
// Params 2
// Checksum 0xd40aae42, Offset: 0x5e3
// Size: 0x39
function script_mover_add_hintstring( name, hintstring )
{
    if ( !isdefined( level.script_mover_hintstrings ) )
    {
        level.script_mover_hintstrings = [];
    }
    
    level.script_mover_hintstrings[ name ] = hintstring;
}

// Namespace movers
// Params 2
// Checksum 0xf675ad3c, Offset: 0x624
// Size: 0x39
function script_mover_add_parameters( name, parameters )
{
    if ( !isdefined( level.script_mover_parameters ) )
    {
        level.script_mover_parameters = [];
    }
    
    level.script_mover_parameters[ name ] = parameters;
}

// Namespace movers
// Params 0
// Checksum 0x7db1aea9, Offset: 0x665
// Size: 0x366
function script_mover_int()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    self.script_mover = 1;
    self.moving = 0;
    self.origin_ent = self;
    self.use_triggers = [];
    self.linked_ents = [];
    structs = utility::getstructarray( self.target, "targetname" );
    
    foreach ( target in structs )
    {
        if ( !isdefined( target.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_6479a60057df5aaf":
                if ( !isdefined( target.angles ) )
                {
                    target.angles = ( 0, 0, 0 );
                }
                
                self.origin_ent = spawn( "script_model", target.origin );
                self.origin_ent.angles = target.angles;
                self.origin_ent setmodel( "tag_origin" );
                self.origin_ent linkto( self );
                break;
            default:
                break;
        }
    }
    
    ents = getentarray( self.target, #targetname );
    
    foreach ( target in ents )
    {
        if ( !isdefined( target.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_66b78ac7e1f6f148":
                target enablelinkto();
                target linkto( self );
            case #"hash_cbaf3545ee235037":
                target script_mover_parse_targets();
                thread script_mover_use_trigger( target );
                self.use_triggers[ self.use_triggers.size ] = target;
                break;
            case #"hash_6fb23e39e833ccc9":
                target linkto( self );
                self.linked_ents[ self.linked_ents.size ] = target;
                break;
            default:
                break;
        }
    }
    
    thread script_mover_parse_targets();
    thread script_mover_init_move_parameters();
    thread script_mover_save_default_move_parameters();
    thread script_mover_apply_move_parameters( self );
    thread script_mover_move_to_target();
    
    foreach ( trigger in self.use_triggers )
    {
        script_mover_set_usable( trigger, 1 );
    }
}

// Namespace movers
// Params 1
// Checksum 0xff373e1d, Offset: 0x9d3
// Size: 0x63
function script_mover_use_trigger( trigger )
{
    self endon( #"death" );
    
    while ( true )
    {
        trigger waittill( #"trigger" );
        
        if ( trigger.goals.size > 0 )
        {
            self notify( #"new_path" );
            thread script_mover_move_to_target( trigger );
            continue;
        }
        
        self notify( #"trigger" );
    }
}

// Namespace movers
// Params 1
// Checksum 0xe76ded, Offset: 0xa3e
// Size: 0x49
function script_mover_move_to_named_goal( goal_name )
{
    if ( isdefined( level.script_mover_named_goals[ goal_name ] ) )
    {
        self notify( #"new_path" );
        self.goals = [ level.script_mover_named_goals[ goal_name ] ];
        thread script_mover_move_to_target();
    }
}

// Namespace movers
// Params 1
// Checksum 0x63e19f55, Offset: 0xa8f
// Size: 0x24
function anglesclamp180( angles )
{
    return ( angleclamp180( angles[ 0 ] ), angleclamp180( angles[ 1 ] ), angleclamp180( angles[ 2 ] ) );
}

// Namespace movers
// Params 0
// Checksum 0x14e0e33a, Offset: 0xabc
// Size: 0x405
function script_mover_parse_targets()
{
    if ( isdefined( self.parsed ) && self.parsed )
    {
        return;
    }
    
    self.parsed = 1;
    self.goals = [];
    self.movers = [];
    self.level_notify = [];
    structs = [];
    ents = [];
    
    if ( isdefined( self.target ) )
    {
        structs = utility::getstructarray( self.target, "targetname" );
        ents = getentarray( self.target, #targetname );
    }
    
    for ( i = 0; i < structs.size ; i++ )
    {
        target = structs[ i ];
        
        if ( !isdefined( target.script_noteworthy ) )
        {
            target.script_noteworthy = "goal";
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_f4a879c6a099e6a3":
                if ( isdefined( target.target ) )
                {
                    add_structs = utility::getstructarray( target.target, "targetname" );
                    
                    foreach ( add in add_structs )
                    {
                        structs[ structs.size ] = add;
                    }
                }
                
                break;
            case #"hash_8d43150f19c69bd6":
                target script_mover_init_move_parameters();
                target script_mover_parse_targets();
                self.goals[ self.goals.size ] = target;
                
                if ( isdefined( target.params[ "name" ] ) )
                {
                    level.script_mover_named_goals[ target.params[ "name" ] ] = target;
                }
                
                break;
            case #"hash_9d36212eda6f7813":
                if ( isdefined( target.script_parameters ) )
                {
                    self.level_notify[ self.level_notify.size ] = target;
                }
                
                break;
            default:
                break;
        }
    }
    
    foreach ( ent in ents )
    {
        if ( ent script_mover_is_script_mover() )
        {
            self.movers[ self.movers.size ] = ent;
            continue;
        }
        
        if ( !isdefined( ent.script_noteworthy ) )
        {
            continue;
        }
        
        toks = strtok( ent.script_noteworthy, "_" );
        
        if ( toks.size != 3 || toks[ 1 ] != "on" )
        {
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_897c0184865c23aa":
                thread script_mover_call_func_on_notify( ent, &delete, toks[ 2 ] );
                break;
            case #"hash_7ebb454a971d80d":
                thread script_mover_call_func_on_notify( ent, &hide, toks[ 2 ] );
                break;
            case #"hash_ca51c18a00a0a89c":
                ent hide();
                thread script_mover_call_func_on_notify( ent, &show, toks[ 2 ] );
                break;
            case #"hash_6fc6a816bd9d0753":
            case #"hash_a604a8dc3d70bb33":
                thread script_mover_func_on_notify( ent, &utility::trigger_off, toks[ 2 ] );
                break;
            case #"hash_59c0513670a01816":
            case #"hash_8cd851fbedf962f6":
                ent utility::trigger_off();
                thread script_mover_func_on_notify( ent, &utility::trigger_on, toks[ 2 ] );
                break;
            default:
                break;
        }
    }
}

// Namespace movers
// Params 3
// Checksum 0x81bcbed0, Offset: 0xec9
// Size: 0x4b
function script_mover_func_on_notify( ent, func, note )
{
    self endon( #"death" );
    ent endon( #"death" );
    
    while ( true )
    {
        self waittill( note );
        ent [[ func ]]();
    }
}

// Namespace movers
// Params 3
// Checksum 0x88f1a77c, Offset: 0xf1c
// Size: 0x4b
function script_mover_call_func_on_notify( ent, func, note )
{
    self endon( #"death" );
    ent endon( #"death" );
    
    while ( true )
    {
        self waittill( note );
        ent builtin [[ func ]]();
    }
}

// Namespace movers
// Params 0
// Checksum 0xe501ac44, Offset: 0xf6f
// Size: 0x9
function script_mover_trigger_on()
{
    utility::trigger_on();
}

// Namespace movers
// Params 1
// Checksum 0x373edc4, Offset: 0xf80
// Size: 0x5b2
function script_mover_move_to_target( current )
{
    self endon( #"death" );
    self endon( #"new_path" );
    
    if ( !isdefined( current ) )
    {
    }
    
    for ( current = self; current.goals.size != 0 ; current = goal )
    {
        goal = utility::array_random( current.goals );
        mover = self;
        mover script_mover_apply_move_parameters( goal );
        
        if ( isdefined( mover.params[ "delay_till" ] ) )
        {
            level waittill( mover.params[ "delay_till" ] );
        }
        
        if ( isdefined( mover.params[ "delay_till_trigger" ] ) && mover.params[ "delay_till_trigger" ] )
        {
            self waittill( #"trigger" );
        }
        
        if ( mover.params[ "delay_time" ] > 0 )
        {
            wait mover.params[ "delay_time" ];
        }
        
        move_time = mover.params[ "move_time" ];
        accel_time = mover.params[ "accel_time" ];
        decel_time = mover.params[ "decel_time" ];
        is_moveto = 0;
        is_rotateto = 0;
        trans = transformmove( goal.origin, goal.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles );
        
        if ( mover.origin != goal.origin )
        {
            if ( isdefined( mover.params[ "move_speed" ] ) )
            {
                dist = distance( mover.origin, goal.origin );
                move_time = dist / mover.params[ "move_speed" ];
            }
            
            if ( isdefined( mover.params[ "accel_frac" ] ) )
            {
                accel_time = mover.params[ "accel_frac" ] * move_time;
            }
            
            if ( isdefined( mover.params[ "decel_frac" ] ) )
            {
                decel_time = mover.params[ "decel_frac" ] * move_time;
            }
            
            mover moveto( trans[ "origin" ], move_time, accel_time, decel_time );
            
            foreach ( note in goal.level_notify )
            {
                thread script_mover_run_notify( note.origin, note.script_parameters, self.origin, goal.origin );
            }
            
            is_moveto = 1;
        }
        
        if ( anglesclamp180( trans[ "angles" ] ) != anglesclamp180( mover.angles ) )
        {
            mover rotateto( trans[ "angles" ], move_time, accel_time, decel_time );
            is_rotateto = 1;
        }
        
        foreach ( targeted_mover in mover.movers )
        {
            targeted_mover notify( #"trigger" );
        }
        
        current notify( #"depart" );
        mover script_mover_allow_usable( 0 );
        self.moving = 1;
        
        if ( isdefined( mover.params[ "move_time_offset" ] ) && mover.params[ "move_time_offset" ] + move_time > 0 )
        {
            wait mover.params[ "move_time_offset" ] + move_time;
        }
        else if ( is_moveto )
        {
            self waittill( #"movedone" );
        }
        else if ( is_rotateto )
        {
            self waittill( #"rotatedone" );
        }
        else
        {
            wait move_time;
        }
        
        self.moving = 0;
        self notify( #"move_end" );
        goal notify( #"arrive" );
        
        if ( isdefined( mover.params[ "solid" ] ) )
        {
            if ( mover.params[ "solid" ] )
            {
                mover solid();
            }
            else
            {
                mover notsolid();
            }
        }
        
        foreach ( targeted_mover in goal.movers )
        {
            targeted_mover notify( #"trigger" );
        }
        
        if ( isdefined( mover.params[ "wait_till" ] ) )
        {
            level waittill( mover.params[ "wait_till" ] );
        }
        
        if ( mover.params[ "wait_time" ] > 0 )
        {
            wait mover.params[ "wait_time" ];
        }
        
        mover script_mover_allow_usable( 1 );
    }
}

// Namespace movers
// Params 4
// Checksum 0xf224354d, Offset: 0x153a
// Size: 0x90
function script_mover_run_notify( notify_origin, level_notify, start, end )
{
    self endon( #"move_end" );
    mover = self;
    move_dir = vectornormalize( end - start );
    
    while ( true )
    {
        notify_dir = vectornormalize( notify_origin - mover.origin );
        
        if ( vectordot( move_dir, notify_dir ) <= 0 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    level notify( level_notify );
}

// Namespace movers
// Params 0
// Checksum 0xf9f52706, Offset: 0x15d2
// Size: 0x56
function script_mover_init_move_parameters()
{
    self.params = [];
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    self.angles = anglesclamp180( self.angles );
    script_mover_parse_move_parameters( self.script_parameters );
}

// Namespace movers
// Params 1
// Checksum 0xe1c5fd76, Offset: 0x1630
// Size: 0x247
function script_mover_parse_move_parameters( parameters = "" )
{
    params = strtok( parameters, ";" );
    
    foreach ( param in params )
    {
        toks = strtok( param, "=" );
        
        if ( toks.size != 2 )
        {
            continue;
        }
        
        if ( toks[ 1 ] == "undefined" || toks[ 1 ] == "default" )
        {
            self.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_2b74fd1351aa7a2c":
            case #"hash_3c39a00c7c7d0dc4":
            case #"hash_785811f02a52ccba":
            case #"hash_7b12226936aa30c5":
            case #"hash_7ce5e6f06cb19f77":
            case #"hash_85409ed1316ad84c":
            case #"hash_9a32d25bf1504c7e":
            case #"hash_cbf4d1a793ce27c8":
            case #"hash_ee220acc1acae64c":
                self.params[ toks[ 0 ] ] = script_mover_parse_range( toks[ 1 ] );
                break;
            case #"hash_3c36bb0c7c7af9ae":
            case #"hash_738c50493c45cf46":
            case #"hash_853da9d13168ab06":
            case #"hash_dde06d8e15af50a1":
                self.params[ toks[ 0 ] ] = toks[ 1 ];
                break;
            case #"hash_5277b19543577b0d":
            case #"hash_6cf0fecd49dc6429":
            case #"hash_b669df4fb84dddd4":
                self.params[ toks[ 0 ] ] = int( toks[ 1 ] );
                break;
            case #"hash_7eb55b2a3a2f02dd":
                param_name = toks[ 1 ];
                additional_params = level.script_mover_parameters[ param_name ];
                
                if ( isdefined( additional_params ) )
                {
                    script_mover_parse_move_parameters( additional_params );
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace movers
// Params 1
// Checksum 0x1117ce72, Offset: 0x187f
// Size: 0x88
function script_mover_parse_range( str )
{
    value = 0;
    toks = strtok( str, "," );
    
    if ( toks.size == 1 )
    {
        value = float( toks[ 0 ] );
    }
    else if ( toks.size == 2 )
    {
        minvalue = float( toks[ 0 ] );
        maxvalue = float( toks[ 1 ] );
        
        if ( minvalue >= maxvalue )
        {
            value = minvalue;
        }
        else
        {
            value = randomfloatrange( minvalue, maxvalue );
        }
    }
    
    return value;
}

// Namespace movers
// Params 1
// Checksum 0xe0339a0d, Offset: 0x1910
// Size: 0x8f
function script_mover_apply_move_parameters( from )
{
    foreach ( key, value in from.params )
    {
        script_mover_set_param( key, value );
    }
    
    script_mover_set_defaults();
}

// Namespace movers
// Params 2
// Checksum 0xcbf253a7, Offset: 0x19a7
// Size: 0x47
function script_mover_set_param( param_name, value )
{
    if ( !isdefined( param_name ) )
    {
        return;
    }
    
    if ( param_name == "usable" && isdefined( value ) )
    {
        script_mover_set_usable( self, value );
    }
    
    self.params[ param_name ] = value;
}

// Namespace movers
// Params 1
// Checksum 0xc61fa652, Offset: 0x19f6
// Size: 0xa2
function script_mover_allow_usable( usable )
{
    if ( self.params[ "usable" ] )
    {
        script_mover_set_usable( self, usable );
    }
    
    foreach ( trigger in self.use_triggers )
    {
        script_mover_set_usable( trigger, usable );
    }
}

// Namespace movers
// Params 2
// Checksum 0x3bb3d0e5, Offset: 0x1aa0
// Size: 0x57
function script_mover_set_usable( use_ent, usable )
{
    if ( usable )
    {
        use_ent makeusable();
        use_ent setcursorhint( "HINT_NOICON" );
        use_ent sethintstring( level.script_mover_hintstrings[ self.params[ "hintstring" ] ] );
        return;
    }
    
    use_ent makeunusable();
}

// Namespace movers
// Params 0
// Checksum 0x3ff428ec, Offset: 0x1aff
// Size: 0x8a
function script_mover_save_default_move_parameters()
{
    self.params_default = [];
    
    foreach ( key, value in self.params )
    {
        self.params_default[ key ] = value;
    }
}

// Namespace movers
// Params 0
// Checksum 0x24c86a39, Offset: 0x1b91
// Size: 0x113
function script_mover_set_defaults()
{
    foreach ( key, value in level.script_mover_defaults )
    {
        if ( !isdefined( self.params[ key ] ) )
        {
            script_mover_set_param( key, value );
        }
    }
    
    if ( isdefined( self.params_default ) )
    {
        foreach ( key, value in self.params_default )
        {
            if ( !isdefined( self.params[ key ] ) )
            {
                script_mover_set_param( key, value );
            }
        }
    }
}

// Namespace movers
// Params 0
// Checksum 0x74231809, Offset: 0x1cac
// Size: 0x12
function init()
{
    level thread script_mover_connect_watch();
    level thread script_mover_agent_spawn_watch();
}

// Namespace movers
// Params 0
// Checksum 0xa0afe410, Offset: 0x1cc6
// Size: 0x2c
function script_mover_connect_watch()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player thread player_unresolved_collision_watch();
    }
}

// Namespace movers
// Params 0
// Checksum 0xb471c826, Offset: 0x1cfa
// Size: 0x2c
function script_mover_agent_spawn_watch()
{
    while ( true )
    {
        level waittill( #"spawned_agent", agent );
        agent thread player_unresolved_collision_watch();
    }
}

// Namespace movers
// Params 3
// Checksum 0xc2a3c467, Offset: 0x1d2e
// Size: 0x1f8
function player_update_unresolved_collision( mover, penetration, var_10f70b7a2e40cd7f )
{
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    unresolved_collision_notify_min = 3;
    
    if ( isdefined( mover ) && isdefined( mover.unresolved_collision_notify_min ) )
    {
        unresolved_collision_notify_min = mover.unresolved_collision_notify_min;
    }
    
    if ( self.unresolved_collision_count >= unresolved_collision_notify_min )
    {
        if ( isdefined( mover ) )
        {
            if ( isdefined( mover.unresolved_collision_func ) )
            {
                mover [[ mover.unresolved_collision_func ]]( self, penetration );
            }
            else if ( isdefined( mover.unresolved_collision_kill ) && mover.unresolved_collision_kill )
            {
                mover unresolved_collision_owner_damage( self );
            }
            else
            {
                var_a5ca1d0f5eafe488 = isdefined( self.lastascenderusetime ) && gettime() - self.lastascenderusetime <= 250;
                
                if ( var_a5ca1d0f5eafe488 || mover vehicle::is_vehicle() && !vehicle_collision::function_419e88170394a188( mover, self ) )
                {
                    mover unresolved_collision_nearest_node( self, 0, mover, 0, var_10f70b7a2e40cd7f );
                }
                else
                {
                    allowsuicide = player_should_be_killed_by_mover( mover );
                    mover unresolved_collision_nearest_node( self, allowsuicide, mover, 0, var_10f70b7a2e40cd7f );
                }
            }
        }
        else
        {
            allowsuicide = player_should_be_killed_by_mover( mover );
            unresolved_collision_nearest_node( self, allowsuicide, undefined, 0, var_10f70b7a2e40cd7f );
        }
        
        self.unresolved_collision_count = 0;
        return;
    }
    
    if ( self.unresolved_collision_count == 1 )
    {
        if ( isplayer( self ) && isdefined( mover ) && !self function_f6d2dbd3ac10d2d5() )
        {
            radius = getdvarint( @"scr_unresolved_collision_door_check_radius", 120 );
            nearestdoor = function_6cf720856f2ecd74( self.origin, radius );
            
            if ( isdefined( nearestdoor ) && nearestdoor isscriptableinstance() )
            {
                allowsuicide = player_should_be_killed_by_mover( mover );
                mover unresolved_collision_nearest_node( self, allowsuicide, mover, 1, var_10f70b7a2e40cd7f );
                self.unresolved_collision_count = 0;
            }
        }
    }
}

// Namespace movers
// Params 1
// Checksum 0xdec0701c, Offset: 0x1f2e
// Size: 0x44
function player_should_be_killed_by_mover( mover )
{
    if ( mover.player_should_be_killed_by_mover )
    {
        return self [[ mover.player_should_be_killed_by_mover ]]( mover );
    }
    
    if ( isdefined( mover ) && mover.moverdoesnotkill )
    {
        return 0;
    }
    
    return 1;
}

// Namespace movers
// Params 0
// Checksum 0x9630f5dd, Offset: 0x1f7b
// Size: 0x7d
function player_unresolved_collision_watch()
{
    if ( isagent( self ) )
    {
        self endon( #"death_or_disconnect" );
    }
    else
    {
        self endon( #"disconnect" );
    }
    
    self.unresolved_collision_count = 0;
    
    while ( true )
    {
        self waittill( #"unresolved_collision", mover, penetration, var_10f70b7a2e40cd7f );
        
        if ( player_ignore_mover( mover ) )
        {
            continue;
        }
        
        player_update_unresolved_collision( mover, penetration, var_10f70b7a2e40cd7f );
    }
}

// Namespace movers
// Params 1
// Checksum 0x381e560f, Offset: 0x2000
// Size: 0x7c
function player_ignore_mover( mover )
{
    ignoremover = 0;
    
    if ( isdefined( mover.streakinfo ) && mover.streakinfo.streakname == "cruise_predator" )
    {
        ignoremover = 1;
    }
    
    if ( isdefined( mover.carriabletype ) )
    {
        ignoremover = 1;
    }
    
    if ( isplayer( self ) && !val::get( "unresolved_collisions" ) )
    {
        ignoremover = 1;
    }
    
    return ignoremover;
}

// Namespace movers
// Params 0
// Checksum 0xd8d2b7cd, Offset: 0x2085
// Size: 0x1e
function clear_unresolved_collision_count_next_frame()
{
    self endon( #"unresolved_collision" );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self.unresolved_collision_count = 0;
    }
}

// Namespace movers
// Params 1
// Checksum 0xab68d162, Offset: 0x20ab
// Size: 0x102
function unresolved_collision_owner_damage( player )
{
    inflictor = self;
    
    if ( !isdefined( inflictor.owner ) )
    {
        player mover_suicide();
        return;
    }
    
    var_1eedddfef56931e9 = 0;
    
    if ( level.teambased )
    {
        if ( isdefined( inflictor.owner.team ) && inflictor.owner.team != player.team )
        {
            var_1eedddfef56931e9 = 1;
        }
    }
    else if ( player != inflictor.owner )
    {
        var_1eedddfef56931e9 = 1;
    }
    
    if ( !var_1eedddfef56931e9 )
    {
        player mover_suicide();
        return;
    }
    
    damage_ammount = 1000;
    
    if ( isdefined( inflictor.unresolved_collision_damage ) )
    {
        damage_ammount = inflictor.unresolved_collision_damage;
    }
    
    player dodamage( damage_ammount, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH" );
}

// Namespace movers
// Params 5
// Checksum 0x3304341a, Offset: 0x21b5
// Size: 0x4c6
function unresolved_collision_nearest_node( player, ballowsuicide, mover, var_e011060012f69864, var_10f70b7a2e40cd7f )
{
    if ( isdefined( level.override_unresolved_collision ) )
    {
        self [[ level.override_unresolved_collision ]]( player, istrue( ballowsuicide ) );
        return;
    }
    
    if ( isdefined( mover ) && isdefined( mover.override_unresolved_collision ) )
    {
        self [[ mover.override_unresolved_collision ]]( player, istrue( ballowsuicide ) );
        return;
    }
    
    if ( isdefined( var_10f70b7a2e40cd7f.override_unresolved_collision ) )
    {
        self [[ var_10f70b7a2e40cd7f.override_unresolved_collision ]]( player, istrue( ballowsuicide ) );
        return;
    }
    
    if ( isdefined( mover.elevator ) )
    {
        if ( player elevators::isinsideelevator( mover ) )
        {
            return;
        }
    }
    
    if ( isdefined( mover.cover ) )
    {
        if ( player ishanging() )
        {
            player clearhanging();
        }
    }
    
    if ( game_utility::islargemap() || var_e011060012f69864 )
    {
        if ( mover vehicle::is_vehicle() )
        {
            exit = undefined;
            
            if ( mover vehicle_occupancy::function_63c6c86801e0685c() )
            {
                exit = vehicle_occupancy::function_7ce9972f31ab138b( player, mover, player.origin );
            }
            else
            {
                exit = vehicle_occupancy::get_emergency_exit( mover, player );
            }
            
            if ( isdefined( exit.origin ) )
            {
                if ( isdefined( exit.direction ) && ( exit.direction == "inside" || exit.direction == "top" ) )
                {
                    player function_b24bb8a9e05f54bc( exit.origin, mover );
                    return;
                }
                
                player setorigin( exit.origin );
                return;
            }
            else
            {
                vehicle_collision::function_419e88170394a188( mover, player );
                return;
            }
        }
        else if ( weapons::isplantedequipment( mover ) )
        {
            mover weapons::deleteexplosive();
            return;
        }
        else if ( isdefined( mover.riotshieldcover ) && isdefined( mover.riotshieldcover.var_df7a1b82191a68cf ) )
        {
            mover.riotshieldcover [[ mover.riotshieldcover.var_df7a1b82191a68cf ]]( 0, 1, undefined, undefined, 1 );
            return;
        }
        else if ( isdefined( mover.cover ) )
        {
            if ( utility::issharedfuncdefined( #"tactical_cover", #"destroy" ) )
            {
                mover.cover [[ utility::getsharedfunc( #"tactical_cover", #"destroy" ) ]]( undefined, 0 );
            }
            
            return;
        }
        else if ( isdefined( mover.var_dcd245efa3ae2e6d ) )
        {
            mover [[ mover.var_dcd245efa3ae2e6d ]]( player, mover );
            return;
        }
        else if ( isdefined( level.var_2b99407369ed59ae ) && [[ level.var_2b99407369ed59ae ]]( player, mover ) )
        {
            return;
        }
    }
    else
    {
        nodes = self.unresolved_collision_nodes;
        
        if ( isdefined( nodes ) )
        {
            nodes = sortbydistance( nodes, player.origin );
        }
        else
        {
            nodes = getnodesinradiussorted( player.origin, 500, 0, 128, "path" );
        }
        
        player cancelmantle();
        player dontinterpolate();
        ignorelist = get_mover_ents( mover );
        
        /#
            if ( ignorelist.size > 128 )
            {
                assertmsg( "<dev string:x24>" + ignorelist.size );
            }
        #/
        
        ignorelist = utility::get_array_of_closest( player.origin, ignorelist, undefined, 128 );
        contents = trace::create_contents( 0, 1, 1, 1, 1, 1 );
        
        for ( i = 0; i < nodes.size ; i++ )
        {
            if ( i == 3 )
            {
                break;
            }
            
            check_node = nodes[ i ];
            org = check_node.origin + ( 0, 0, 10 );
            trace = trace::ray_trace( player gettagorigin( "tag_eye" ), org, ignorelist, contents );
            
            if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
            
            if ( !canspawn( org ) )
            {
                continue;
            }
            
            if ( positionwouldtelefrag( org ) )
            {
                continue;
            }
            
            if ( player getstance() == "prone" )
            {
                player setstance( "crouch" );
            }
            
            player setorigin( org );
            return;
        }
    }
    
    if ( mover.var_27c250029fc222fc && isdefined( mover.owner ) )
    {
        player kill( mover.origin, mover.owner, mover, "MOD_CRUSH" );
        return;
    }
    
    if ( !isdefined( ballowsuicide ) )
    {
        ballowsuicide = 1;
    }
    
    if ( ballowsuicide )
    {
        if ( !getdvarint( @"hash_60159c88e0599409", 1 ) && mover.var_7814545a8310756d )
        {
            return;
        }
        
        player mover_suicide();
    }
}

// Namespace movers
// Params 1
// Checksum 0xb428905, Offset: 0x2683
// Size: 0xcf
function get_mover_ents( mover )
{
    moverents = [];
    
    if ( !isdefined( mover ) )
    {
        return moverents;
    }
    
    moverents[ moverents.size ] = mover;
    parent = mover getlinkedparent();
    children = mover getlinkedchildren( 1 );
    
    if ( isdefined( parent ) )
    {
        moverents[ moverents.size ] = parent;
    }
    
    if ( isdefined( children ) )
    {
        foreach ( child in children )
        {
            moverents[ moverents.size ] = child;
        }
    }
    
    return moverents;
}

// Namespace movers
// Params 2
// Checksum 0xc19336a4, Offset: 0x275b
// Size: 0x15
function unresolved_collision_void( player, penetration )
{
    
}

// Namespace movers
// Params 0
// Checksum 0xed42a0c7, Offset: 0x2778
// Size: 0x45
function mover_suicide()
{
    if ( game_utility_mp::islaststandenabled() || self.var_1d63f3432078fb2c )
    {
        self dodamage( self.health + 1000, self.origin, self, undefined, "MOD_SUICIDE" );
        return;
    }
    
    damage::_suicide();
}

// Namespace movers
// Params 1
// Checksum 0x3fa14b6e, Offset: 0x27c5
// Size: 0x82
function player_pushed_kill( min_mph )
{
    self endon( #"death" );
    self endon( #"hash_edfe1b02dda6a60a" );
    
    while ( true )
    {
        self waittill( #"player_pushed", player, platformmph );
        
        if ( isplayer( player ) || isagent( player ) )
        {
            mph = length( platformmph );
            
            if ( mph >= min_mph )
            {
                unresolved_collision_owner_damage( player );
            }
        }
    }
}

// Namespace movers
// Params 0
// Checksum 0x1624c9bd, Offset: 0x284f
// Size: 0xe
function stop_player_pushed_kill()
{
    self notify( #"hash_edfe1b02dda6a60a" );
}

// Namespace movers
// Params 0
// Checksum 0x8e573052, Offset: 0x2865
// Size: 0x36
function script_mover_get_top_parent()
{
    topparent = self getlinkedparent();
    
    for ( parent = topparent; isdefined( parent ) ; parent = parent getlinkedparent() )
    {
        topparent = parent;
    }
    
    return topparent;
}

// Namespace movers
// Params 1
// Checksum 0x1eb174fa, Offset: 0x28a4
// Size: 0xa9
function script_mover_start_use( useent )
{
    useparent = useent script_mover_get_top_parent();
    
    if ( isdefined( useparent ) )
    {
        useparent.startuseorigin = useparent.origin;
    }
    
    self.startusemover = self getmovingplatformparent();
    
    if ( isdefined( self.startusemover ) )
    {
        topparent = self.startusemover script_mover_get_top_parent();
        
        if ( isdefined( topparent ) )
        {
            self.startusemover = topparent;
        }
        
        self.startusemover.startuseorigin = self.startusemover.origin;
    }
}

// Namespace movers
// Params 1
// Checksum 0xf9717e5, Offset: 0x2955
// Size: 0x36, Type: bool
function script_mover_has_parent_moved( parent )
{
    if ( !isdefined( parent ) )
    {
        return false;
    }
    
    return lengthsquared( parent.origin - parent.startuseorigin ) > 0.001;
}

// Namespace movers
// Params 1
// Checksum 0xc6b4a9c4, Offset: 0x2994
// Size: 0x8d, Type: bool
function script_mover_use_can_link( ent )
{
    if ( !isplayer( self ) )
    {
        return true;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    topparent = ent script_mover_get_top_parent();
    playerparent = self.startusemover;
    
    if ( !isdefined( topparent ) && !isdefined( playerparent ) )
    {
        return true;
    }
    
    if ( isdefined( topparent ) && isdefined( playerparent ) && topparent == playerparent )
    {
        return true;
    }
    
    if ( script_mover_has_parent_moved( topparent ) )
    {
        return false;
    }
    
    if ( script_mover_has_parent_moved( playerparent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace movers
// Params 1
// Checksum 0x909864d8, Offset: 0x2a2a
// Size: 0x2f
function script_mover_link_to_use_object( player )
{
    if ( isplayer( player ) )
    {
        player script_mover_start_use( self );
    }
    
    player allowmovement( 0 );
    player allowjump( 0 );
}

// Namespace movers
// Params 1
// Checksum 0x68df55f6, Offset: 0x2a61
// Size: 0x1e
function script_mover_unlink_from_use_object( player )
{
    player allowmovement( 1 );
    player allowjump( 1 );
}

// Namespace movers
// Params 0
// Checksum 0xbc54847d, Offset: 0x2a87
// Size: 0xb9
function notify_moving_platform_invalid()
{
    children = self getlinkedchildren( 0 );
    
    if ( !isdefined( children ) )
    {
        return;
    }
    
    foreach ( child in children )
    {
        if ( isdefined( child.no_moving_platfrom_unlink ) && child.no_moving_platfrom_unlink )
        {
            continue;
        }
        
        child unlink();
        child notify( #"invalid_parent", self );
    }
}

// Namespace movers
// Params 2
// Checksum 0xe2c2f4d6, Offset: 0x2b48
// Size: 0x62
function process_moving_platform_death( data, platform )
{
    if ( isdefined( platform ) && platform.no_moving_platfrom_death )
    {
        return;
    }
    
    if ( isdefined( data.deathoverridecallback ) )
    {
        data.lasttouchedplatform = platform;
        self thread [[ data.deathoverridecallback ]]( data );
        return;
    }
    
    self delete();
}

// Namespace movers
// Params 1
// Checksum 0x797fe55d, Offset: 0x2bb2
// Size: 0x1ed
function handle_moving_platform_touch( data )
{
    self notify( #"hash_f31cf83bb6d2d38" );
    self endon( #"hash_f31cf83bb6d2d38" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_6216eaad644762d1" );
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    while ( true )
    {
        self waittill( #"touching_platform", platform );
        
        if ( platform.var_639a06f1517179e2 )
        {
            waitframe();
            continue;
        }
        
        if ( data.validateaccuratetouching )
        {
            if ( data.var_222269e8fc78589a )
            {
                custommidpoint = data.custommidpoint ?? self getboundsmidpoint();
                customhalfsize = data.customhalfsize ?? self getboundshalfsize();
                
                if ( !self function_265bf714eef2b2a5( platform, custommidpoint, customhalfsize ) )
                {
                    waitframe();
                    continue;
                }
            }
            else if ( !self istouching( platform ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( isdefined( data.var_f07590e06f628942 ) && data.var_f07590e06f628942 )
        {
            if ( utility::is_moving_platform_ent( platform ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( isdefined( self.streakinfo ) && ( self.streakinfo.streakname == "pac_sentry" || self.streakinfo.streakname == "remote_turret" ) )
        {
            if ( isdefined( platform ) && isdefined( platform.crate ) || isdefined( platform ) && isdefined( platform.var_f166f2009ce48f4 ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( !data.skipdeath )
        {
            thread process_moving_platform_death( data, platform );
        }
        
        self.touchedmovingplatform = 1;
        self.lastmovingplatform = platform;
        thread platform_cleanup_on_death();
        break;
    }
}

// Namespace movers
// Params 0
// Checksum 0x52296bb6, Offset: 0x2da7
// Size: 0x2d
function platform_cleanup_on_death()
{
    self endon( #"death" );
    self.lastmovingplatform waittill( #"death" );
    self.lastmovingplatform = undefined;
}

// Namespace movers
// Params 1
// Checksum 0x91e785d1, Offset: 0x2ddc
// Size: 0xab
function handle_moving_platform_invalid( data )
{
    self notify( #"hash_28e5856b6fe5b690" );
    self endon( #"hash_28e5856b6fe5b690" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_6216eaad644762d1" );
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    self waittill( #"invalid_parent", platform );
    
    if ( isdefined( data.invalidparentoverridecallback ) )
    {
        self thread [[ data.invalidparentoverridecallback ]]( data );
        return;
    }
    
    thread process_moving_platform_death( data, platform );
}

// Namespace movers
// Params 1
// Checksum 0x9b92ca2, Offset: 0x2e8f
// Size: 0x157
function handle_moving_platforms( data )
{
    self notify( #"hash_111a3d5eb2afbc11" );
    self endon( #"hash_111a3d5eb2afbc11" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_6216eaad644762d1" );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    if ( isdefined( data.linkparent ) && self != data.linkparent )
    {
        parent = self getlinkedparent();
        
        if ( parent != data.linkparent )
        {
            if ( utility::function_f77200072cabe8bc( self, data.linkparent ) )
            {
                if ( isdefined( data.linkoffset ) )
                {
                    self linkto( data.linkparent, "", data.linkoffset, data.angleoffset );
                }
                else
                {
                    self linkto( data.linkparent );
                }
            }
            
            if ( data.linkparent ismovingplatform() )
            {
                if ( level.var_df9a62d76792dc02 )
                {
                    data.invalidparentoverridecallback = &utility::empty_init_func;
                }
            }
        }
    }
    
    thread handle_moving_platform_touch( data );
    thread handle_moving_platform_invalid( data );
}

// Namespace movers
// Params 0
// Checksum 0xcc9d4b56, Offset: 0x2fee
// Size: 0xe
function stop_handling_moving_platforms()
{
    self notify( #"hash_6216eaad644762d1" );
}

