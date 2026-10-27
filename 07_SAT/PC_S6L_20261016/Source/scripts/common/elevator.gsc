// scripts\common\elevator.gsc  (hash_3a68a1bdabcacff8.gscc) (size: 23497 Bytes / 0x5bc9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28482e6a (675819114)
// size ...... 23497 (0x5bc9)
// includes .. 1   (offset: 0x53f9)
// strings ... 66  (offset: 0x5401)
// dev strs .. 32  (offset: 0x59f1)
// exports ... 57  (offset: 0x3dd5)
// cseg ...... 0x422 + 0x39b3 (0x3dd5)
// imports ... 96  (offset: 0x46bd)
// animtree1 . 0   (offset: 0x5bc9)
// animtree2 . 0   (offset: 0x5bc9)
#using scripts\common\utility;

#namespace elevator;

// Namespace elevator
// Params 0
// Checksum 0x1cde0929, Offset: 0x440
// Size: 0x164
function init()
{
    if ( getdvarint( @"scr_elevator_disabled" ) == 1 )
    {
        return;
    }
    
    elevator_groups = getentarray( "elevator_group", #targetname );
    
    if ( !isdefined( elevator_groups ) )
    {
        return;
    }
    
    if ( !elevator_groups.size )
    {
        return;
    }
    
    precachestring( &"elevator_call_hint" );
    precachestring( &"elevator_use_hint" );
    precachestring( &"elevator_floor_select_hint" );
    thread elevator_update_global_dvars();
    level.elevators = [];
    level.elevator_callbutton_link_v = elevator_get_dvar_int( @"scr_elevator_callbutton_link_v", "96" );
    level.elevator_callbutton_link_h = elevator_get_dvar_int( @"scr_elevator_callbutton_link_h", "256" );
    build_elevators();
    position_elevators();
    elevator_call();
    
    if ( !level.elevators.size )
    {
        return;
    }
    
    foreach ( elevator in level.elevators )
    {
        elevator thread elevator_think();
        elevator thread elevator_sound_think();
    }
    
    thread elevator_debug();
}

// Namespace elevator
// Params 0
// Checksum 0x2e5bd42d, Offset: 0x5ac
// Size: 0x175
function elevator_update_global_dvars()
{
    while ( true )
    {
        level.elevator_accel = elevator_get_dvar( @"scr_elevator_accel", "0.2" );
        level.elevator_decel = elevator_get_dvar( @"scr_elevator_decel", "0.2" );
        level.elevator_music = elevator_get_dvar_int( @"scr_elevator_music", "1" );
        level.elevator_speed = elevator_get_dvar_int( @"scr_elevator_speed", "96" );
        level.elevator_innerdoorspeed = elevator_get_dvar_int( @"scr_elevator_innerdoorspeed", "14" );
        level.elevator_outterdoorspeed = elevator_get_dvar_int( @"scr_elevator_outterdoorspeed", "16" );
        level.elevator_return = elevator_get_dvar_int( @"scr_elevator_return", "0" );
        level.elevator_waittime = elevator_get_dvar_int( @"scr_elevator_waittime", "6" );
        level.elevator_aggressive_call = elevator_get_dvar_int( @"scr_elevator_aggressive_call", "0" );
        level.elevator_debug = elevator_get_dvar_int( @"debug_elevator", "0" );
        
        if ( utility::issp() )
        {
            level.elevator_motion_detection = elevator_get_dvar_int( @"scr_elevator_motion_detection", "0" );
        }
        else
        {
            level.elevator_motion_detection = elevator_get_dvar_int( @"scr_elevator_motion_detection", "1" );
        }
        
        wait 1;
    }
}

// Namespace elevator
// Params 0
// Checksum 0xd6089820, Offset: 0x729
// Size: 0xe
function elevator_think()
{
    elevator_fsm( "[A]" );
}

// Namespace elevator
// Params 0
// Checksum 0x9165b3c6, Offset: 0x73f
// Size: 0x7b
function elevator_call()
{
    foreach ( callbutton in level.elevator_callbuttons )
    {
        callbutton thread monitor_callbutton();
    }
}

// Namespace elevator
// Params 1
// Checksum 0x24c4a22f, Offset: 0x7c2
// Size: 0x73
function floor_override( inside_trig )
{
    self endon( #"elevator_moving" );
    self.floor_override = 0;
    self.overrider = undefined;
    
    while ( true )
    {
        inside_trig waittill( #"trigger", player );
        self.floor_override = 1;
        self.overrider = player;
        break;
    }
    
    self notify( #"floor_override" );
}

// Namespace elevator
// Params 1
// Checksum 0x8a58c8a6, Offset: 0x83d
// Size: 0x341
function elevator_fsm( state )
{
    self.estate = state;
    door_trig = get_housing_door_trigger();
    inside_trig = get_housing_inside_trigger();
    
    while ( true )
    {
        if ( self.estate == "[A]" )
        {
            if ( level.elevator_return && get_curfloor() != get_initfloor() )
            {
                self.moveto_floor = get_initfloor();
                thread floor_override( inside_trig );
                waittill_or_timeout( "floor_override", level.elevator_waittime );
                
                if ( self.floor_override && isplayer( self.overrider ) )
                {
                    get_floor( self.overrider );
                }
                
                self.estate = "[B]";
                continue;
            }
            
            while ( true )
            {
                if ( self.moveto_floor == get_curfloor() )
                {
                    param = inside_trig discrete_waittill( "trigger" );
                }
                else
                {
                    param = "elevator_called";
                }
                
                if ( isstring( param ) && param == "elevator_called" && self.moveto_floor != get_curfloor() )
                {
                    self.estate = "[B]";
                    break;
                }
                
                if ( isplayer( param ) && isalive( param ) )
                {
                    istouching_trigger = param istouching( inside_trig );
                    istouching_motion_trigger = isdefined( inside_trig.motion_trigger ) && param istouching( inside_trig.motion_trigger );
                    player_istouching_trigger = istouching_trigger || istouching_motion_trigger;
                    
                    if ( player_istouching_trigger )
                    {
                        player = param;
                        get_floor( player );
                        
                        if ( self.moveto_floor == get_curfloor() )
                        {
                            continue;
                        }
                        
                        self.estate = "[B]";
                        break;
                    }
                }
            }
        }
        
        if ( self.estate == "[B]" )
        {
            thread elevator_interrupt( door_trig );
            floor_num = get_curfloor();
            thread close_inner_doors();
            thread close_outer_doors( floor_num );
            utility::waittill_any( "closed_inner_doors", "interrupted" );
            
            if ( self.elevator_interrupted )
            {
                self.estate = "[C]";
                continue;
            }
            
            self.estate = "[D]";
            continue;
        }
        
        if ( self.estate == "[C]" )
        {
            floor_num = get_curfloor();
            thread open_inner_doors();
            thread open_outer_doors( floor_num );
            self waittill( "opened_floor_" + floor_num + "_outer_doors" );
            
            if ( self.elevator_interrupted )
            {
                self.estate = "[B]";
                continue;
            }
            
            self.estate = "[A]";
            continue;
        }
        
        if ( self.estate == "[D]" )
        {
            assert( isdefined( self.moveto_floor ), "<dev string:x24>" );
            
            if ( self.moveto_floor != get_curfloor() )
            {
                thread elevator_move( self.moveto_floor );
                self waittill( #"elevator_moved" );
            }
            
            self.estate = "[C]";
            continue;
        }
    }
}

// Namespace elevator
// Params 0
// Checksum 0x6b1746b7, Offset: 0xb86
// Size: 0x216
function monitor_callbutton()
{
    while ( true )
    {
        player = discrete_waittill( "trigger" );
        call_floor = undefined;
        call_elevators = [];
        
        foreach ( idx, linked_elevators in self.e )
        {
            call_floor = idx;
            call_elevators = linked_elevators;
        }
        
        assert( isdefined( call_floor ) && isdefined( call_elevators ) && call_elevators.size );
        elevator_called = 0;
        
        foreach ( elevator in call_elevators )
        {
            moving = elevator elevator_floor_update();
            
            if ( !level.elevator_aggressive_call && !moving )
            {
                if ( elevator get_curfloor() == call_floor )
                {
                    elevator_called = 1;
                    call_elevators = [];
                    break;
                }
            }
        }
        
        foreach ( elevator in call_elevators )
        {
            if ( elevator.estate == "[A]" )
            {
                elevator call_elevator( call_floor );
                elevator_called = 1;
                
                if ( !level.elevator_aggressive_call )
                {
                    break;
                }
            }
        }
        
        if ( elevator_called )
        {
            self playsound( "elev_bell_ding" );
        }
    }
}

// Namespace elevator
// Params 1
// Checksum 0xd0745c77, Offset: 0xda4
// Size: 0x62
function call_elevator( call_floor )
{
    self.moveto_floor = call_floor;
    inside_trigger = get_housing_inside_trigger();
    inside_trigger notify( #"trigger", "elevator_called" );
    
    if ( level.elevator_motion_detection )
    {
        inside_trigger.motion_trigger notify( #"trigger", "elevator_called" );
    }
}

// Namespace elevator
// Params 1
// Checksum 0x7de32fa9, Offset: 0xe0e
// Size: 0xac
function get_floor( player )
{
    bifloor = get_outer_doorsets();
    
    if ( bifloor.size == 2 )
    {
        curfloor = get_curfloor();
        self.moveto_floor = !curfloor;
        return;
    }
    
    player setclientdvar( @"player_current_floor", get_curfloor() );
    
    while ( true )
    {
        player waittill( #"menuresponse", menu, response );
        
        if ( menu == "elevator_floor_selector" )
        {
            if ( response != "none" )
            {
                self.moveto_floor = int( response );
            }
            
            break;
        }
    }
}

// Namespace elevator
// Params 1
// Checksum 0x7bcba4c3, Offset: 0xec2
// Size: 0x7d
function elevator_interrupt( door_trig )
{
    self notify( #"interrupt_watch" );
    level notify( #"hash_8fa80946f20c6fe0" );
    self endon( #"interrupt_watch" );
    self endon( #"elevator_moving" );
    self.elevator_interrupted = 0;
    wait 0.5;
    door_trig waittill( #"trigger", player );
    self notify( #"interrupted" );
    self.elevator_interrupted = 1;
}

// Namespace elevator
// Params 0
// Checksum 0x71a65871, Offset: 0xf47
// Size: 0xe0
function elevator_floor_update()
{
    mainframe = get_housing_mainframe();
    cur_pos = mainframe.origin;
    moving = 1;
    
    foreach ( idx, efloor in get_outer_doorsets() )
    {
        floor_pos = self.e[ "floor" + idx + "_pos" ];
        
        if ( cur_pos == floor_pos )
        {
            self.e[ "current_floor" ] = idx;
            moving = 0;
        }
    }
    
    return moving;
}

// Namespace elevator
// Params 0
// Checksum 0xa923284, Offset: 0x1030
// Size: 0x146
function elevator_sound_think()
{
    musak_model = get_housing_musak_model();
    
    if ( level.elevator_music && isdefined( musak_model ) )
    {
        musak_model playloopsound( "elev_musak_loop" );
    }
    
    thread listen_for( "closing_inner_doors" );
    thread listen_for( "opening_inner_doors" );
    thread listen_for( "closed_inner_doors" );
    thread listen_for( "opened_inner_doors" );
    
    foreach ( idx, efloor in get_outer_doorsets() )
    {
        thread listen_for( "closing_floor_" + idx + "_outer_doors" );
        thread listen_for( "opening_floor_" + idx + "_outer_doors" );
        thread listen_for( "closed_floor_" + idx + "_outer_doors" );
        thread listen_for( "opened_floor_" + idx + "_outer_doors" );
    }
    
    thread listen_for( "interrupted" );
    thread listen_for( "elevator_moving" );
    thread listen_for( "elevator_moved" );
}

// Namespace elevator
// Params 1
// Checksum 0xcd697906, Offset: 0x117e
// Size: 0xc9
function listen_for( msg )
{
    while ( true )
    {
        self waittill( msg );
        mainframe = get_housing_mainframe();
        
        if ( issubstr( msg, "closing_" ) )
        {
            mainframe playsound( "elev_door_close" );
        }
        
        if ( issubstr( msg, "opening_" ) )
        {
            mainframe playsound( "elev_door_open" );
        }
        
        if ( msg == "elevator_moving" )
        {
            mainframe playsound( "elev_run_start" );
            mainframe playloopsound( "elev_run_loop" );
        }
        
        if ( msg == "interrupted" )
        {
            mainframe playsound( "elev_door_interupt" );
        }
        
        if ( msg == "elevator_moved" )
        {
            mainframe stoploopsound( "elev_run_loop" );
            mainframe playsound( "elev_run_end" );
            mainframe playsound( "elev_bell_ding" );
        }
    }
}

// Namespace elevator
// Params 0
// Checksum 0x3ce93e90, Offset: 0x124f
// Size: 0x10b
function position_elevators()
{
    foreach ( elevator in level.elevators )
    {
        elevator.moveto_floor = elevator get_curfloor();
        
        foreach ( floor_num, outer_doorset in elevator get_outer_doorsets() )
        {
            if ( elevator get_curfloor() != floor_num )
            {
                elevator thread close_outer_doors( floor_num );
            }
        }
    }
}

// Namespace elevator
// Params 1
// Checksum 0x93bea1ff, Offset: 0x1362
// Size: 0x1e3
function elevator_move( floor_num )
{
    self notify( #"elevator_moving" );
    self endon( #"elevator_moving" );
    mainframe = get_housing_mainframe();
    delta_vec = self.e[ "floor" + floor_num + "_pos" ] - mainframe.origin;
    speed = level.elevator_speed;
    dist = abs( distance( self.e[ "floor" + floor_num + "_pos" ], mainframe.origin ) );
    movetime = dist / speed;
    mainframe moveto( mainframe.origin + delta_vec, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel );
    
    foreach ( part in get_housing_children() )
    {
        moveto_pos = part.origin + delta_vec;
        
        if ( !issubstr( part.classname, "trigger_" ) )
        {
            part moveto( moveto_pos, movetime, movetime * level.elevator_accel, movetime * level.elevator_decel );
            continue;
        }
        
        part.origin = moveto_pos;
    }
    
    waittill_finish_moving( mainframe, self.e[ "floor" + floor_num + "_pos" ] );
    self notify( #"elevator_moved" );
}

// Namespace elevator
// Params 0
// Checksum 0xc83b14cb, Offset: 0x154d
// Size: 0x113
function close_inner_doors()
{
    self notify( #"closing_inner_doors" );
    self endon( #"closing_inner_doors" );
    self endon( #"opening_inner_doors" );
    left_door = get_housing_leftdoor();
    right_door = get_housing_rightdoor();
    mainframe = get_housing_mainframe();
    old_closed_pos = get_housing_closedpos();
    closed_pos = ( old_closed_pos[ 0 ], old_closed_pos[ 1 ], mainframe.origin[ 2 ] );
    speed = level.elevator_innerdoorspeed;
    dist = abs( distance( left_door.origin, closed_pos ) );
    movetime = dist / speed;
    left_door moveto( closed_pos, movetime, movetime * 0.1, movetime * 0.25 );
    right_door moveto( closed_pos, movetime, movetime * 0.1, movetime * 0.25 );
    waittill_finish_moving( left_door, closed_pos, right_door, closed_pos );
    self notify( #"closed_inner_doors" );
}

// Namespace elevator
// Params 0
// Checksum 0xa4544588, Offset: 0x1668
// Size: 0x139
function open_inner_doors()
{
    self notify( #"opening_inner_doors" );
    self endon( #"opening_inner_doors" );
    left_door = get_housing_leftdoor();
    right_door = get_housing_rightdoor();
    mainframe = get_housing_mainframe();
    var_bb9a4cd269a5c6d2 = get_housing_leftdoor_opened_pos();
    var_8498d419879c3e2b = get_housing_rightdoor_opened_pos();
    var_cf1332df379acc3c = ( var_bb9a4cd269a5c6d2[ 0 ], var_bb9a4cd269a5c6d2[ 1 ], mainframe.origin[ 2 ] );
    var_39bfe6561fe64541 = ( var_8498d419879c3e2b[ 0 ], var_8498d419879c3e2b[ 1 ], mainframe.origin[ 2 ] );
    speed = level.elevator_innerdoorspeed;
    dist = abs( distance( var_cf1332df379acc3c, var_39bfe6561fe64541 ) * 0.5 );
    movetime = dist / speed * 0.5;
    left_door moveto( var_cf1332df379acc3c, movetime, movetime * 0.1, movetime * 0.25 );
    right_door moveto( var_39bfe6561fe64541, movetime, movetime * 0.1, movetime * 0.25 );
    waittill_finish_moving( left_door, var_cf1332df379acc3c, right_door, var_39bfe6561fe64541 );
    self notify( #"opened_inner_doors" );
}

// Namespace elevator
// Params 1
// Checksum 0xf435446e, Offset: 0x17a9
// Size: 0x10f
function close_outer_doors( floor_num )
{
    self notify( "closing_floor_" + floor_num + "_outer_doors" );
    self endon( "closing_floor_" + floor_num + "_outer_doors" );
    self endon( "opening_floor_" + floor_num + "_outer_doors" );
    left_door = get_outer_leftdoor( floor_num );
    right_door = get_outer_rightdoor( floor_num );
    var_cf1332df379acc3c = get_outer_leftdoor_openedpos( floor_num );
    closed_pos = get_outer_closedpos( floor_num );
    speed = level.elevator_outterdoorspeed;
    dist = abs( distance( var_cf1332df379acc3c, closed_pos ) );
    movetime = dist / speed;
    left_door moveto( closed_pos, movetime, movetime * 0.1, movetime * 0.25 );
    right_door moveto( closed_pos, movetime, movetime * 0.1, movetime * 0.25 );
    waittill_finish_moving( left_door, closed_pos, right_door, closed_pos );
    self notify( "closed_floor_" + floor_num + "_outer_doors" );
}

// Namespace elevator
// Params 1
// Checksum 0xa10cd4fb, Offset: 0x18c0
// Size: 0x122
function open_outer_doors( floor_num )
{
    level notify( #"elevator_doors_opening" );
    self notify( "opening_floor_" + floor_num + "_outer_doors" );
    self endon( "opening_floor_" + floor_num + "_outer_doors" );
    left_door = get_outer_leftdoor( floor_num );
    right_door = get_outer_rightdoor( floor_num );
    var_cf1332df379acc3c = get_outer_leftdoor_openedpos( floor_num );
    var_39bfe6561fe64541 = get_outer_rightdoor_openedpos( floor_num );
    closed_pos = get_outer_closedpos( floor_num );
    speed = level.elevator_outterdoorspeed;
    dist = abs( distance( var_cf1332df379acc3c, closed_pos ) );
    movetime = dist / speed * 0.5;
    left_door moveto( var_cf1332df379acc3c, movetime, movetime * 0.1, movetime * 0.25 );
    right_door moveto( var_39bfe6561fe64541, movetime, movetime * 0.1, movetime * 0.25 );
    waittill_finish_moving( left_door, var_cf1332df379acc3c, right_door, var_39bfe6561fe64541 );
    self notify( "opened_floor_" + floor_num + "_outer_doors" );
}

// Namespace elevator
// Params 0
// Checksum 0x3c3317aa, Offset: 0x19ea
// Size: 0xd50
function build_elevators()
{
    elevator_groups = getentarray( "elevator_group", #targetname );
    assert( isdefined( elevator_groups ) && elevator_groups.size, "<dev string:x45>" );
    elevator_housings = getentarray( "elevator_housing", #targetname );
    assert( isdefined( elevator_housings ) && elevator_housings.size >= elevator_groups.size, "<dev string:x70>" );
    elevator_doorsets = getentarray( "elevator_doorset", #targetname );
    assert( isdefined( elevator_doorsets ) && elevator_doorsets.size >= elevator_groups.size, "<dev string:xe2>" );
    
    foreach ( elevator_bound in elevator_groups )
    {
        elevator_bound_end = getent( elevator_bound.target, #targetname );
        var_a339a3887cd1d097 = [];
        var_a339a3887cd1d097[ 0 ] = min( elevator_bound.origin[ 0 ], elevator_bound_end.origin[ 0 ] );
        var_a339a3887cd1d097[ 1 ] = max( elevator_bound.origin[ 0 ], elevator_bound_end.origin[ 0 ] );
        var_a339a3887cd1d097[ 2 ] = min( elevator_bound.origin[ 1 ], elevator_bound_end.origin[ 1 ] );
        var_a339a3887cd1d097[ 3 ] = max( elevator_bound.origin[ 1 ], elevator_bound_end.origin[ 1 ] );
        parts = spawnstruct();
        parts.e[ "id" ] = level.elevators.size;
        parts.e[ "housing" ] = [];
        parts.e[ "housing" ][ "mainframe" ] = [];
        
        foreach ( elevator_housing in elevator_housings )
        {
            if ( elevator_housing isinbound( var_a339a3887cd1d097 ) )
            {
                parts.e[ "housing" ][ "mainframe" ][ parts.e[ "housing" ][ "mainframe" ].size ] = elevator_housing;
                
                if ( elevator_housing.classname == "script_model" )
                {
                    continue;
                }
                
                if ( elevator_housing.code_classname == "light" )
                {
                    continue;
                }
                
                inner_leftdoor = getent( elevator_housing.target, #targetname );
                parts.e[ "housing" ][ "left_door" ] = inner_leftdoor;
                parts.e[ "housing" ][ "left_door_opened_pos" ] = inner_leftdoor.origin;
                inner_rightdoor = getent( inner_leftdoor.target, #targetname );
                parts.e[ "housing" ][ "right_door" ] = inner_rightdoor;
                parts.e[ "housing" ][ "right_door_opened_pos" ] = inner_rightdoor.origin;
                inner_door_closed_pos = ( inner_leftdoor.origin - inner_rightdoor.origin ) * ( 0.5, 0.5, 0.5 ) + inner_rightdoor.origin;
                parts.e[ "housing" ][ "door_closed_pos" ] = inner_door_closed_pos;
                door_trigger = getent( inner_rightdoor.target, #targetname );
                parts.e[ "housing" ][ "door_trigger" ] = door_trigger;
                inside_trigger = getent( door_trigger.target, #targetname );
                parts.e[ "housing" ][ "inside_trigger" ] = inside_trigger;
                inside_trigger make_discrete_trigger();
                inside_trigger.motion_trigger = spawn( "trigger_radius", elevator_housing.origin, 0, 64, 128 );
                assert( isdefined( inside_trigger.motion_trigger ) );
            }
        }
        
        assert( isdefined( parts.e[ "<dev string:x104>" ] ) );
        parts.e[ "outer_doorset" ] = [];
        
        foreach ( elevator_doorset in elevator_doorsets )
        {
            if ( elevator_doorset isinbound( var_a339a3887cd1d097 ) )
            {
                var_332c8ce44166c373 = elevator_doorset.script_noteworthy == "closed_for_lighting";
                var_eff73607258f447b = parts.e[ "outer_doorset" ].size;
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ] = [];
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "door_closed_pos" ] = elevator_doorset.origin;
                leftdoor = getent( elevator_doorset.target, #targetname );
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "left_door" ] = leftdoor;
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "left_door_opened_pos" ] = leftdoor.origin;
                rightdoor = getent( leftdoor.target, #targetname );
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "right_door" ] = rightdoor;
                parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "right_door_opened_pos" ] = rightdoor.origin;
                
                if ( var_332c8ce44166c373 )
                {
                    left_door_vec = elevator_doorset.origin - leftdoor.origin;
                    elevator_doorset.origin = leftdoor.origin;
                    leftdoor.origin += left_door_vec;
                    rightdoor.origin -= left_door_vec;
                    parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "door_closed_pos" ] = elevator_doorset.origin;
                    parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "left_door_opened_pos" ] = leftdoor.origin;
                    parts.e[ "outer_doorset" ][ var_eff73607258f447b ][ "right_door_opened_pos" ] = rightdoor.origin;
                }
            }
        }
        
        assert( isdefined( parts.e[ "<dev string:x10c>" ] ) );
        
        for ( i = 0; i < parts.e[ "outer_doorset" ].size - 1 ; i++ )
        {
            for ( j = 0; j < parts.e[ "outer_doorset" ].size - 1 - i ; j++ )
            {
                if ( parts.e[ "outer_doorset" ][ j + 1 ][ "door_closed_pos" ][ 2 ] < parts.e[ "outer_doorset" ][ j ][ "door_closed_pos" ][ 2 ] )
                {
                    temp_left_door = parts.e[ "outer_doorset" ][ j ][ "left_door" ];
                    temp_left_door_opened_pos = parts.e[ "outer_doorset" ][ j ][ "left_door_opened_pos" ];
                    temp_right_door = parts.e[ "outer_doorset" ][ j ][ "right_door" ];
                    temp_right_door_opened_pos = parts.e[ "outer_doorset" ][ j ][ "right_door_opened_pos" ];
                    temp_closed_pos = parts.e[ "outer_doorset" ][ j ][ "door_closed_pos" ];
                    parts.e[ "outer_doorset" ][ j ][ "left_door" ] = parts.e[ "outer_doorset" ][ j + 1 ][ "left_door" ];
                    parts.e[ "outer_doorset" ][ j ][ "left_door_opened_pos" ] = parts.e[ "outer_doorset" ][ j + 1 ][ "left_door_opened_pos" ];
                    parts.e[ "outer_doorset" ][ j ][ "right_door" ] = parts.e[ "outer_doorset" ][ j + 1 ][ "right_door" ];
                    parts.e[ "outer_doorset" ][ j ][ "right_door_opened_pos" ] = parts.e[ "outer_doorset" ][ j + 1 ][ "right_door_opened_pos" ];
                    parts.e[ "outer_doorset" ][ j ][ "door_closed_pos" ] = parts.e[ "outer_doorset" ][ j + 1 ][ "door_closed_pos" ];
                    parts.e[ "outer_doorset" ][ j + 1 ][ "left_door" ] = temp_left_door;
                    parts.e[ "outer_doorset" ][ j + 1 ][ "left_door_opened_pos" ] = temp_left_door_opened_pos;
                    parts.e[ "outer_doorset" ][ j + 1 ][ "right_door" ] = temp_right_door;
                    parts.e[ "outer_doorset" ][ j + 1 ][ "right_door_opened_pos" ] = temp_right_door_opened_pos;
                    parts.e[ "outer_doorset" ][ j + 1 ][ "door_closed_pos" ] = temp_closed_pos;
                }
            }
        }
        
        floor_pos = [];
        
        foreach ( i, doorset in parts.e[ "outer_doorset" ] )
        {
            mainframe = parts get_housing_mainframe();
            floor_pos = ( mainframe.origin[ 0 ], mainframe.origin[ 1 ], doorset[ "door_closed_pos" ][ 2 ] );
            parts.e[ "floor" + i + "_pos" ] = floor_pos;
            
            if ( mainframe.origin == floor_pos )
            {
                parts.e[ "initial_floor" ] = i;
                parts.e[ "current_floor" ] = i;
            }
        }
        
        level.elevators[ level.elevators.size ] = parts;
        elevator_bound delete();
        elevator_bound_end delete();
    }
    
    foreach ( elevator_doorset in elevator_doorsets )
    {
        elevator_doorset delete();
    }
    
    build_call_buttons();
    
    if ( !level.elevator_motion_detection )
    {
        setup_hints();
    }
    
    foreach ( elevator in level.elevators )
    {
        plights = elevator get_housing_primarylight();
        
        if ( isdefined( plights ) && plights.size )
        {
            foreach ( plight in plights )
            {
                plight setlightintensity( 0.75 );
            }
        }
    }
}

// Namespace elevator
// Params 0
// Checksum 0xd628ca12, Offset: 0x2742
// Size: 0x317
function build_call_buttons()
{
    level.elevator_callbuttons = getentarray( "elevator_call", #targetname );
    assert( isdefined( level.elevator_callbuttons ) && level.elevator_callbuttons.size > 1, "<dev string:x11a>" );
    
    foreach ( callbutton in level.elevator_callbuttons )
    {
        callbutton.e = [];
        callbutton_v_vec = ( 0, 0, callbutton.origin[ 2 ] );
        callbutton_h_vec = ( callbutton.origin[ 0 ], callbutton.origin[ 1 ], 0 );
        var_e40ee86cc0e82d44 = [];
        
        foreach ( elevator in level.elevators )
        {
            foreach ( f_idx, efloor in elevator get_outer_doorsets() )
            {
                v_vec = ( 0, 0, elevator.e[ "floor" + f_idx + "_pos" ][ 2 ] );
                h_vec = ( elevator.e[ "floor" + f_idx + "_pos" ][ 0 ], elevator.e[ "floor" + f_idx + "_pos" ][ 1 ], 0 );
                
                if ( abs( distance( callbutton_v_vec, v_vec ) ) <= level.elevator_callbutton_link_v )
                {
                    if ( abs( distance( callbutton_h_vec, h_vec ) ) <= level.elevator_callbutton_link_h )
                    {
                        var_e40ee86cc0e82d44[ var_e40ee86cc0e82d44.size ] = elevator;
                        callbutton.e[ f_idx ] = var_e40ee86cc0e82d44;
                    }
                }
            }
        }
        
        callbutton make_discrete_trigger();
        assert( isdefined( callbutton.e ) && callbutton.e.size, "<dev string:x146>" + callbutton.origin + "<dev string:x15f>" );
        callbutton.motion_trigger = spawn( "trigger_radius", callbutton.origin + ( 0, 0, -32 ), 0, 32, 64 );
    }
}

// Namespace elevator
// Params 0
// Checksum 0x6af06439, Offset: 0x2a61
// Size: 0x164
function setup_hints()
{
    foreach ( elevator in level.elevators )
    {
        use_trig = elevator get_housing_inside_trigger();
        floors = elevator get_outer_doorsets();
        var_da4fcf29d94387e8 = floors.size;
        use_trig setcursorhint( "HINT_NOICON" );
        
        if ( var_da4fcf29d94387e8 > 2 )
        {
            use_trig sethintstring( &"elevator_floor_select_hint" );
            continue;
        }
        
        use_trig sethintstring( &"elevator_use_hint" );
    }
    
    foreach ( callbutton in level.elevator_callbuttons )
    {
        callbutton setcursorhint( "HINT_NOICON" );
        callbutton sethintstring( &"elevator_call_hint" );
    }
}

// Namespace elevator
// Params 0
// Checksum 0x1b984e3e, Offset: 0x2bcd
// Size: 0x14
function make_discrete_trigger()
{
    self.enabled = 1;
    disable_trigger();
}

// Namespace elevator
// Params 1
// Checksum 0x92fc4f89, Offset: 0x2be9
// Size: 0x5f
function discrete_waittill( msg )
{
    assert( isdefined( self.motion_trigger ) );
    enable_trigger();
    
    if ( level.elevator_motion_detection )
    {
        self.motion_trigger waittill( msg, param );
    }
    else
    {
        self waittill( msg, param );
    }
    
    disable_trigger();
    return param;
}

// Namespace elevator
// Params 0
// Checksum 0x36e3da3d, Offset: 0x2c51
// Size: 0x7c
function enable_trigger()
{
    if ( !self.enabled )
    {
        self.enabled = 1;
        self.origin += ( 0, 0, 10000 );
        
        if ( isdefined( self.motion_trigger ) )
        {
            self.motion_trigger.origin += ( 0, 0, 10000 );
        }
    }
}

// Namespace elevator
// Params 0
// Checksum 0x9227f0e, Offset: 0x2cd5
// Size: 0x21
function disable_trigger()
{
    self notify( #"disable_trigger" );
    
    if ( self.enabled )
    {
        thread disable_trigger_helper();
    }
}

// Namespace elevator
// Params 0
// Checksum 0x723fc9bf, Offset: 0x2cfe
// Size: 0x80
function disable_trigger_helper()
{
    self endon( #"disable_trigger" );
    self.enabled = 0;
    wait 1.5;
    self.origin += ( 0, 0, -10000 );
    
    if ( isdefined( self.motion_trigger ) )
    {
        self.motion_trigger.origin += ( 0, 0, -10000 );
    }
}

// Namespace elevator
// Params 1
// Checksum 0xb2c3fc95, Offset: 0x2d86
// Size: 0x1e
function get_outer_doorset( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ];
}

// Namespace elevator
// Params 0
// Checksum 0x9875cd67, Offset: 0x2dad
// Size: 0x11
function get_outer_doorsets()
{
    return self.e[ "outer_doorset" ];
}

// Namespace elevator
// Params 1
// Checksum 0x53884a08, Offset: 0x2dc7
// Size: 0x24
function get_outer_closedpos( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ][ "door_closed_pos" ];
}

// Namespace elevator
// Params 1
// Checksum 0xf4a51185, Offset: 0x2df4
// Size: 0x24
function get_outer_leftdoor( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ][ "left_door" ];
}

// Namespace elevator
// Params 1
// Checksum 0x86dd026e, Offset: 0x2e21
// Size: 0x24
function get_outer_rightdoor( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ][ "right_door" ];
}

// Namespace elevator
// Params 1
// Checksum 0xf4bc7df, Offset: 0x2e4e
// Size: 0x24
function get_outer_leftdoor_openedpos( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ][ "left_door_opened_pos" ];
}

// Namespace elevator
// Params 1
// Checksum 0x3f2684ea, Offset: 0x2e7b
// Size: 0x24
function get_outer_rightdoor_openedpos( floor_num )
{
    return self.e[ "outer_doorset" ][ floor_num ][ "right_door_opened_pos" ];
}

// Namespace elevator
// Params 0
// Checksum 0x42c93884, Offset: 0x2ea8
// Size: 0x18b
function get_housing_children()
{
    children = [];
    door_trig = get_housing_door_trigger();
    use_trig = get_housing_inside_trigger();
    motion_trig = use_trig.motion_trigger;
    left_door = get_housing_leftdoor();
    right_door = get_housing_rightdoor();
    children[ children.size ] = door_trig;
    children[ children.size ] = use_trig;
    children[ children.size ] = left_door;
    children[ children.size ] = right_door;
    
    if ( isdefined( motion_trig ) )
    {
        children[ children.size ] = motion_trig;
    }
    
    script_models = get_housing_models();
    
    foreach ( emodel in script_models )
    {
        children[ children.size ] = emodel;
    }
    
    primarylights = get_housing_primarylight();
    
    foreach ( plight in primarylights )
    {
        children[ children.size ] = plight;
    }
    
    return children;
}

// Namespace elevator
// Params 0
// Checksum 0xbbd3a161, Offset: 0x303c
// Size: 0xe5
function get_housing_mainframe()
{
    parts = self.e[ "housing" ][ "mainframe" ];
    housing_model = undefined;
    
    foreach ( part in parts )
    {
        if ( part.classname != "script_model" && part.code_classname != "light" )
        {
            assert( !isdefined( housing_model ), "<dev string:x192>" );
            housing_model = part;
        }
    }
    
    assert( isdefined( housing_model ), "<dev string:x1dd>" );
    return housing_model;
}

// Namespace elevator
// Params 0
// Checksum 0x6757cc50, Offset: 0x312a
// Size: 0xb2
function get_housing_models()
{
    parts = self.e[ "housing" ][ "mainframe" ];
    temp_model_array = [];
    
    foreach ( part in parts )
    {
        if ( part.classname == "script_model" )
        {
            temp_model_array[ temp_model_array.size ] = part;
        }
    }
    
    return temp_model_array;
}

// Namespace elevator
// Params 0
// Checksum 0xf8a2aa86, Offset: 0x31e5
// Size: 0xb2
function get_housing_primarylight()
{
    parts = self.e[ "housing" ][ "mainframe" ];
    temp_primarylights = [];
    
    foreach ( part in parts )
    {
        if ( part.code_classname == "light" )
        {
            temp_primarylights[ temp_primarylights.size ] = part;
        }
    }
    
    return temp_primarylights;
}

// Namespace elevator
// Params 0
// Checksum 0x8e2d6bc9, Offset: 0x32a0
// Size: 0xa0
function get_housing_musak_model()
{
    models = get_housing_models();
    musak_model = undefined;
    
    foreach ( emodel in models )
    {
        if ( emodel.script_noteworthy == "play_musak" )
        {
            musak_model = emodel;
        }
    }
    
    return musak_model;
}

// Namespace elevator
// Params 0
// Checksum 0x8775387f, Offset: 0x3349
// Size: 0x17
function get_housing_door_trigger()
{
    return self.e[ "housing" ][ "door_trigger" ];
}

// Namespace elevator
// Params 0
// Checksum 0xbea6867d, Offset: 0x3369
// Size: 0x17
function get_housing_inside_trigger()
{
    return self.e[ "housing" ][ "inside_trigger" ];
}

// Namespace elevator
// Params 0
// Checksum 0xedf5bb37, Offset: 0x3389
// Size: 0x17
function get_housing_closedpos()
{
    return self.e[ "housing" ][ "door_closed_pos" ];
}

// Namespace elevator
// Params 0
// Checksum 0x2ea61d11, Offset: 0x33a9
// Size: 0x17
function get_housing_leftdoor()
{
    return self.e[ "housing" ][ "left_door" ];
}

// Namespace elevator
// Params 0
// Checksum 0x38a0f351, Offset: 0x33c9
// Size: 0x17
function get_housing_rightdoor()
{
    return self.e[ "housing" ][ "right_door" ];
}

// Namespace elevator
// Params 0
// Checksum 0x69afa0e, Offset: 0x33e9
// Size: 0x17
function get_housing_leftdoor_opened_pos()
{
    return self.e[ "housing" ][ "left_door_opened_pos" ];
}

// Namespace elevator
// Params 0
// Checksum 0x30379f05, Offset: 0x3409
// Size: 0x17
function get_housing_rightdoor_opened_pos()
{
    return self.e[ "housing" ][ "right_door_opened_pos" ];
}

// Namespace elevator
// Params 0
// Checksum 0xc5399d38, Offset: 0x3429
// Size: 0x23
function get_curfloor()
{
    moving = elevator_floor_update();
    return self.e[ "current_floor" ];
}

// Namespace elevator
// Params 0
// Checksum 0xe791ce54, Offset: 0x3455
// Size: 0x11
function get_initfloor()
{
    return self.e[ "initial_floor" ];
}

// Namespace elevator
// Params 4
// Checksum 0xb3f5380f, Offset: 0x346f
// Size: 0x8a
function waittill_finish_moving( ent1, var_851ab79f5ce9eb26, ent2, var_c087854aca371c45 )
{
    if ( !isdefined( ent2 ) && !isdefined( var_c087854aca371c45 ) )
    {
        ent2 = ent1;
        var_c087854aca371c45 = var_851ab79f5ce9eb26;
    }
    
    while ( true )
    {
        var_f9bc501166097481 = ent1.origin;
        var_2cef8bd8b38fe764 = ent2.origin;
        
        if ( var_f9bc501166097481 == var_851ab79f5ce9eb26 && var_2cef8bd8b38fe764 == var_c087854aca371c45 )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace elevator
// Params 1
// Checksum 0x6308799, Offset: 0x3501
// Size: 0xa8, Type: bool
function isinbound( bounding_box )
{
    assert( isdefined( self ) && isdefined( self.origin ), "<dev string:x214>" );
    v_x = self.origin[ 0 ];
    v_y = self.origin[ 1 ];
    min_x = bounding_box[ 0 ];
    max_x = bounding_box[ 1 ];
    min_y = bounding_box[ 2 ];
    max_y = bounding_box[ 3 ];
    return v_x >= min_x && v_x <= max_x && v_y >= min_y && v_y <= max_y;
}

// Namespace elevator
// Params 1
// Checksum 0xd2655bb6, Offset: 0x35b2
// Size: 0xc3, Type: bool
function isinboundingspere( bounding_box )
{
    v_x = self.origin[ 0 ];
    v_y = self.origin[ 1 ];
    min_x = bounding_box[ 0 ];
    max_x = bounding_box[ 1 ];
    min_y = bounding_box[ 2 ];
    max_y = bounding_box[ 3 ];
    mid_x = ( min_x + max_x ) / 2;
    mid_y = ( min_y + max_y ) / 2;
    radius = abs( distance( ( min_x, min_y, 0 ), ( mid_x, mid_y, 0 ) ) );
    return abs( distance( ( v_x, v_y, 0 ), ( mid_x, mid_y, 0 ) ) ) < radius;
}

// Namespace elevator
// Params 2
// Checksum 0x1d596043, Offset: 0x367e
// Size: 0x1d
function waittill_or_timeout( msg, timer )
{
    self endon( msg );
    wait timer;
}

// Namespace elevator
// Params 2
// Checksum 0x77ad20b3, Offset: 0x36a3
// Size: 0x22
function elevator_get_dvar_int( dvar, def )
{
    return int( elevator_get_dvar( dvar, def ) );
}

// Namespace elevator
// Params 2
// Checksum 0xd8b99aaf, Offset: 0x36ce
// Size: 0x3e
function elevator_get_dvar( dvar, def )
{
    if ( getdvar( dvar, "" ) != "" )
    {
        return getdvarfloat( dvar );
    }
    
    setdvar( dvar, def );
    return def;
}

// Namespace elevator
// Params 0
// Checksum 0xd4718ac8, Offset: 0x3714
// Size: 0x5fe
function elevator_debug()
{
    if ( !level.elevator_debug )
    {
        return;
    }
    
    while ( true )
    {
        if ( level.elevator_debug != 2 )
        {
            continue;
        }
        
        foreach ( i, elevator in level.elevators )
        {
            mainframe = elevator get_housing_mainframe();
            musak_model = elevator get_housing_musak_model();
            
            /#
                print3d( musak_model.origin, "<dev string:x248>" + i + "<dev string:x24b>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            /#
                print3d( mainframe.origin, "<dev string:x248>" + i + "<dev string:x259>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            /#
                print3d( elevator.e[ "<dev string:x104>" ][ "<dev string:x264>" ].origin, "<dev string:x248>" + i + "<dev string:x26e>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            /#
                print3d( elevator.e[ "<dev string:x104>" ][ "<dev string:x279>" ].origin, "<dev string:x248>" + i + "<dev string:x284>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            /#
                print3d( elevator.e[ "<dev string:x104>" ][ "<dev string:x290>" ], "<dev string:x248>" + i + "<dev string:x2a0>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            /#
                print3d( elevator.e[ "<dev string:x104>" ][ "<dev string:x2a7>" ].origin, "<dev string:x248>" + i + "<dev string:x2b6>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            foreach ( j, efloor in elevator.e[ "outer_doorset" ] )
            {
                /#
                    print3d( efloor[ "<dev string:x264>" ].origin + ( 0, 0, 8 ), "<dev string:x248>" + i + "<dev string:x2bb>" + j + "<dev string:x26e>", ( 0.75, 1, 0.75 ), 1, 0.25, 20 );
                #/
                
                /#
                    print3d( efloor[ "<dev string:x279>" ].origin + ( 0, 0, 8 ), "<dev string:x248>" + i + "<dev string:x2bb>" + j + "<dev string:x284>", ( 0.75, 1, 0.75 ), 1, 0.25, 20 );
                #/
                
                /#
                    print3d( efloor[ "<dev string:x290>" ] + ( 0, 0, 8 ), "<dev string:x248>" + i + "<dev string:x2bb>" + j + "<dev string:x2a0>", ( 0.75, 1, 0.75 ), 1, 0.25, 20 );
                #/
                
                /#
                    print3d( elevator.e[ "<dev string:x2bf>" + j + "<dev string:x2c5>" ] + ( 0, 0, 8 ), "<dev string:x248>" + i + "<dev string:x2bb>" + j + "<dev string:x2ca>", ( 1, 0.75, 0.75 ), 1, 0.25, 20 );
                #/
            }
        }
        
        foreach ( callbutton in level.elevator_callbuttons )
        {
            /#
                print3d( callbutton.origin, "<dev string:x2d0>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
            #/
            
            foreach ( f_idx, efloor in callbutton.e )
            {
                printoffset = 0;
                
                foreach ( elinked in efloor )
                {
                    printoffset++;
                    print_pos = callbutton.origin + ( 0, 0, printoffset * -4 );
                    
                    /#
                        print3d( print_pos, "<dev string:x2db>" + f_idx + "<dev string:x2de>" + elinked.e[ "<dev string:x2e2>" ] + "<dev string:x2e5>", ( 0.75, 0.75, 1 ), 1, 0.25, 20 );
                    #/
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace elevator
// Params 1
// Checksum 0x79dc7408, Offset: 0x3d1a
// Size: 0xba, Type: bool
function is_moving_platform_elevator( movingplatforment )
{
    if ( !isdefined( movingplatforment ) )
    {
        return false;
    }
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevatorstruct in level.elevators )
        {
            if ( !isdefined( elevatorstruct.car ) )
            {
                continue;
            }
            
            if ( elevatorstruct.car == movingplatforment )
            {
                return true;
            }
        }
    }
    
    return false;
}

