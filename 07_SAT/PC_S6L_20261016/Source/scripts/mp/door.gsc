// scripts\mp\door.gsc  (hash_578fb8ced8601826.gscc) (size: 66671 Bytes / 0x1046f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15938c77 (361991287)
// size ...... 66671 (0x1046f)
// includes .. 27  (offset: 0xf87b)
// strings ... 168 (offset: 0xf953)
// dev strs .. 11  (offset: 0x103cf)
// exports ... 124 (offset: 0xb477)
// cseg ...... 0xdd3 + 0xa6a4 (0xb477)
// imports ... 355 (offset: 0xc7d7)
// animtree1 . 1   (offset: 0x1045f)
// animtree2 . 0   (offset: 0x1046f)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\anim;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\emp_debuff;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\movers;
#using scripts\mp\rank;

#namespace door;

// Namespace door
// Params 1
// Checksum 0x273762a2, Offset: 0xdf1
// Size: 0x9b
function door_dynamic_setup( starthidden )
{
    if ( isdefined( level.doors ) )
    {
        return;
    }
    
    /#
        setdevdvarifuninitialized( @"scr_doors_open", 0 );
        setdevdvarifuninitialized( @"hash_b75e6afff090e790", 0 );
    #/
    
    setdvar( @"cg_buttonhintnaturaldistance", 150 );
    level.doors = [];
    level.doorsetupstarted = 0;
    thread door_dynamic_setup_adapter( "dynamic_door", 0 );
    thread door_dynamic_setup_adapter( "lean_dynamic_door", 1, starthidden );
    script_model_anims();
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace door
// Params 3
// Checksum 0x926ab3d6, Offset: 0xe94
// Size: 0x77a
function door_dynamic_setup_adapter( enttargetname, lean, starthidden )
{
    doors = getentarray( enttargetname, #targetname );
    level.doorsetupstarted++;
    level.doorsetupfinished = 0;
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip", "physicscontents_item" ];
    contentoverride = physics_createcontents( content );
    level.doorcontentoverride = contentoverride;
    
    foreach ( door in doors )
    {
        if ( isdefined( door.script_parameters ) )
        {
            door door_dynamic_parse_parameters( door.script_parameters );
        }
        
        door.doors = [];
        door.doors[ 0 ] = door;
        door.islean = lean;
        door.baseangles = door.angles;
        
        if ( door.baseangles[ 1 ] == 360 )
        {
            door.baseangles = ( door.baseangles[ 0 ], 0, door.baseangles[ 2 ] );
        }
        
        door.state = 0;
        doortarget = door.target;
        startopened = door.script_noteworthy == "OPEN" || getdvarint( @"scr_doors_open", 0 ) != 0;
        startlocked = door.script_noteworthy == "LOCKED";
        door.length = 52;
        door.height = 96;
        door.leftplantorg = door.origin + anglestoforward( door.angles ) * door.length * 0.5 + anglestoright( door.angles ) * -24.5;
        door.leftplantang = ( 0, door.baseangles[ 1 ] - 90, 0 );
        door.rightplantorg = door.origin + anglestoforward( door.angles ) * door.length * 0.5 + anglestoright( door.angles ) * 24.5;
        door.rightplantang = ( 0, door.baseangles[ 1 ] + 90, 0 );
        door.doorcenter = door.origin + anglestoforward( door.angles ) * door.length * 0.5 + anglestoup( door.angles ) * door.height * 0.5;
        door.max_yaw_left = 90;
        door.max_yaw_right = 90;
        handletag = door gettagorigin( "tag_door_handle", 1 );
        
        if ( isdefined( handletag ) )
        {
            door gameobjects::sethintobject( "tag_door_handle", "HINT_BUTTON", undefined, &"mp/door_use_open_double", undefined, "duration_none", undefined, 200, 90, 72, 90 );
            door.useprompt = door;
            door.useprompt setusewhenhandsoccupied( 1 );
            
            if ( !lean && !isbrgamemode() )
            {
                door.lockprompt = gameobjects::createhintobject( handletag, "HINT_BUTTON", undefined, &"MP/DOOR_USE_LOCK", undefined, undefined, "show", 200, 90, 72, 90 );
                door.lockprompt linkto( door, "tag_door_handle", ( 3, 0, 15 ), ( 0, 0, 0 ) );
                door.lockprompt setusewhenhandsoccupied( 1 );
                door.alarmprompts = [];
                var_4f405c3a819d30f3 = [ ( 4, 0, 4 ), ( 4, 0, 90 ) ];
                
                foreach ( offset in var_4f405c3a819d30f3 )
                {
                    alarmprompt = gameobjects::createhintobject( handletag, "HINT_BUTTON", undefined, &"mp/door_use_alarm", undefined, undefined, "show", 100, 90, 80, 20 );
                    alarmprompt linkto( door, "tag_origin", offset, ( 0, 0, 0 ) );
                    alarmprompt setusewhenhandsoccupied( 0 );
                    alarmnum = alarmprompt getentitynumber();
                    door.alarmprompts[ alarmnum ] = alarmprompt;
                }
                
                clip = undefined;
                
                if ( isdefined( doortarget ) )
                {
                    clip = getent( doortarget, #targetname );
                }
                
                if ( isdefined( clip ) )
                {
                    door.clipent = clip;
                    door.clipent linkto( door );
                    door.clipent.unresolved_collision_func = &movers::unresolved_collision_void;
                    door.clipent connectpaths();
                    
                    if ( isdefined( clip.target ) )
                    {
                        audioportal = getent( clip.target, #targetname );
                        door.audioportalent = audioportal;
                    }
                }
            }
            
            if ( startopened )
            {
                door thread changestate( 2 );
                door.angles = ( door.angles[ 0 ], door.angles[ 1 ] + 90, door.angles[ 2 ] );
            }
            else if ( startlocked )
            {
                door thread changestate( 7 );
            }
            else
            {
                door thread changestate( 0 );
            }
        }
        
        level.doors[ level.doors.size ] = door;
        waitframe();
    }
    
    if ( !lean )
    {
        level thread amortizeyawtraces();
        
        foreach ( door in level.doors )
        {
            door thread get_max_yaws();
        }
        
        level thread linkdoubledoors();
    }
    
    level.doorsetupstarted--;
    level.doorsetupfinished = level.doorsetupstarted == 0;
}

// Namespace door
// Params 0
// Checksum 0x701f55e2, Offset: 0x1616
// Size: 0xb5
function door_dynamic_setup_post_init()
{
    waitframe();
    
    if ( getdvarint( @"scr_doors_open", 0 ) != 0 )
    {
        foreach ( door in level.doors )
        {
            door.statecurr = 2;
            door.angles = door.doortarget.angles;
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x52badff5, Offset: 0x16d3
// Size: 0x235
function triggerlisten( door )
{
    self notify( #"hash_b4de995158d5b5ed" );
    self endon( #"hash_b4de995158d5b5ed" );
    level endon( #"game_ended" );
    
    if ( !door.islean && door.statecurr == 0 )
    {
        door thread bashmonitor();
    }
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self makeunusable();
        targetrotation = door.doortarget;
        
        if ( isdefined( door.doortargetccw ) )
        {
            doorangle = anglestoforward( door.angles );
            doorfwd = vectorcross( ( 0, 0, 1 ), doorangle );
            playerfwd = anglestoforward( ( 0, player.angles[ 1 ], 0 ) );
            
            if ( vectordot( playerfwd, doorfwd ) < 0 )
            {
                targetrotation = door.doortargetccw;
            }
        }
        
        transitiontime = 0.666;
        
        if ( door.statecurr == 0 )
        {
            self notify( #"hash_6155bf0f6a0247f5" );
            door.statecurr = 3;
            door rotateto( targetrotation.angles, transitiontime, 0, 0.333 );
            hintstring = &"mp/door_use_close";
        }
        else
        {
            door.statecurr = 1;
            door rotateto( door.baseangles, transitiontime, 0, 0.333 );
            hintstring = &"mp/door_use_open";
        }
        
        door events::doorused( player, door.statecurr == 3 );
        wait 0.1;
        door childthread door_state_update_sound();
        wait transitiontime;
        
        if ( door.statecurr == 1 )
        {
            door.statecurr = 0;
            
            if ( !door.islean )
            {
                door thread bashmonitor();
            }
        }
        else
        {
            door.statecurr = 2;
        }
        
        self makeusable();
        self sethintstring( hintstring );
    }
}

// Namespace door
// Params 1
// Checksum 0x9efe1696, Offset: 0x1910
// Size: 0x1c5
function door_dynamic_parse_parameters( parameters )
{
    door = self;
    door.button_sound = undefined;
    
    if ( !isdefined( parameters ) )
    {
        parameters = "";
    }
    
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
            door.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_5c3e74aaa13bc78d":
                door.stop_sound = toks[ 1 ];
                break;
            case #"hash_9e73d538861d053c":
                door.interrupt_sound = toks[ 1 ];
                break;
            case #"hash_78225775c0698cc3":
                door.loop_sound = toks[ 1 ];
                break;
            case #"hash_1e106e4c46349825":
                door.open_interrupt = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_4d982a4c5ddaeacf":
                door.start_sound = toks[ 1 ];
                break;
            case #"hash_edda8e2907d42dc0":
                door.material = toks[ 1 ];
                break;
        }
    }
}

// Namespace door
// Params 1
// Checksum 0xdb38861d, Offset: 0x1add
// Size: 0x122
function door_system_init( triggername )
{
    buttons = getentarray( triggername, #targetname );
    
    foreach ( button in buttons )
    {
        if ( isdefined( button.script_parameters ) )
        {
            button button_parse_parameters( button.script_parameters );
        }
        
        button door_setup();
    }
    
    foreach ( button in buttons )
    {
        button thread door_think();
    }
}

// Namespace door
// Params 0
// Checksum 0x94b8c3af, Offset: 0x1c07
// Size: 0x4f7
function door_setup()
{
    button = self;
    assert( isdefined( button.target ), "<dev string:x24>" );
    button.doors = [];
    button.hasbeenused = 0;
    
    if ( isdefined( button.script_index ) )
    {
        button.doormovetime = max( 0.1, float( button.script_index ) / 1000 );
    }
    
    targetents = getentarray( button.target, #targetname );
    
    foreach ( ent in targetents )
    {
        if ( issubstr( ent.classname, "trigger" ) )
        {
            if ( !isdefined( button.trigblock ) )
            {
                button.trigblock = [];
            }
            
            if ( isdefined( ent.script_parameters ) )
            {
                ent trigger_parse_parameters( ent.script_parameters );
            }
            
            if ( isdefined( ent.script_linkto ) )
            {
                linked_door = getent( ent.script_linkto, #script_linkname );
                ent enablelinkto();
                ent linkto( linked_door );
            }
            
            button.trigblock[ button.trigblock.size ] = ent;
            continue;
        }
        
        if ( ent.classname == "script_brushmodel" || ent.classname == "script_model" )
        {
            if ( isdefined( ent.script_noteworthy ) && issubstr( ent.script_noteworthy, "light" ) )
            {
                if ( issubstr( ent.script_noteworthy, "light_on" ) )
                {
                    if ( !isdefined( button.lights_on ) )
                    {
                        button.lights_on = [];
                    }
                    
                    ent hide();
                    button.lights_on[ button.lights_on.size ] = ent;
                }
                else if ( issubstr( ent.script_noteworthy, "light_off" ) )
                {
                    if ( !isdefined( button.lights_off ) )
                    {
                        button.lights_off = [];
                    }
                    
                    ent hide();
                    button.lights_off[ button.lights_off.size ] = ent;
                }
                else
                {
                    assertmsg( "<dev string:x60>" + ent.script_noteworthy );
                }
            }
            else if ( ent.spawnflags & 2 )
            {
                if ( !isdefined( button.ai_sight_brushes ) )
                {
                    button.ai_sight_brushes = [];
                }
                
                ent notsolid();
                ent hide();
                button.ai_sight_brushes[ button.ai_sight_brushes.size ] = ent;
            }
            else
            {
                button.doors[ button.doors.size ] = ent;
            }
            
            continue;
        }
        
        if ( ent.classname == "script_origin" )
        {
            button.entsound = ent;
        }
    }
    
    if ( !isdefined( button.entsound ) && button.doors.size )
    {
        button.entsound = sortbydistance( button.doors, button.origin )[ 0 ];
    }
    
    foreach ( door in button.doors )
    {
        assert( isdefined( door.target ), "<dev string:x8e>" );
        door.posclosed = door.origin;
        door.posopen = utility::getstruct( door.target, "targetname" ).origin;
        door.distmove = distance( door.posopen, door.posclosed );
        door.no_moving_unresolved_collisions = 0;
        
        if ( !button.start_closed )
        {
            door.origin = door.posopen;
        }
        
        if ( isdefined( door.script_parameters ) )
        {
            door door_parse_parameters( door.script_parameters );
        }
    }
}

// Namespace door
// Params 0
// Checksum 0x9c377737, Offset: 0x2106
// Size: 0xed
function door_think()
{
    button = self;
    startstate = button.start_closed ? 0 : 2;
    button door_state_change( startstate, 1 );
    
    while ( true )
    {
        button.statedone = undefined;
        button.stateinterrupted = undefined;
        button utility::waittill_any( "door_state_done", "door_state_interrupted" );
        
        if ( isdefined( button.statedone ) && button.statedone )
        {
            statenext = button door_state_next( button.statecurr );
            button door_state_change( statenext, 0 );
            continue;
        }
        
        if ( isdefined( button.stateinterrupted ) && button.stateinterrupted )
        {
            button door_state_change( 4, 0 );
            continue;
        }
        
        assertmsg( "<dev string:xce>" );
    }
}

// Namespace door
// Params 1
// Checksum 0xd7a3b9de, Offset: 0x21fb
// Size: 0xa1
function door_state_next( state )
{
    button = self;
    statenext = undefined;
    
    if ( state == 0 )
    {
        statenext = 3;
    }
    else if ( state == 2 )
    {
        statenext = 1;
    }
    else if ( state == 1 )
    {
        statenext = 0;
    }
    else if ( state == 3 )
    {
        statenext = 2;
    }
    else if ( state == 4 )
    {
        assert( isdefined( button.stateprev ), "<dev string:x10b>" );
        statenext = button.stateprev;
    }
    else
    {
        assertmsg( "<dev string:x15d>" + state );
    }
    
    return statenext;
}

// Namespace door
// Params 1
// Checksum 0xdd9d1289, Offset: 0x22a5
// Size: 0xc80
function door_state_update( nosound )
{
    button = self;
    button endon( #"door_state_interrupted" );
    button.statedone = undefined;
    
    if ( button.statecurr == 0 || button.statecurr == 2 )
    {
        if ( !nosound )
        {
            foreach ( door in button.doors )
            {
                if ( isdefined( door.stop_sound ) )
                {
                    door stoploopsound();
                    door playsoundonmovingent( door.stop_sound );
                }
            }
        }
        
        if ( isdefined( button.lights_on ) )
        {
            foreach ( light in button.lights_on )
            {
                light show();
            }
        }
        
        foreach ( door in button.doors )
        {
            if ( button.statecurr == 0 )
            {
                if ( isdefined( button.ai_sight_brushes ) )
                {
                    foreach ( var_3e81356516df0ef1 in button.ai_sight_brushes )
                    {
                        var_3e81356516df0ef1 show();
                    }
                }
            }
            else if ( isdefined( button.ai_sight_brushes ) )
            {
                foreach ( var_3e81356516df0ef1 in button.ai_sight_brushes )
                {
                    var_3e81356516df0ef1 hide();
                }
            }
            
            if ( isdefined( door.script_noteworthy ) )
            {
                if ( door.script_noteworthy == "clockwise_wheel" || door.script_noteworthy == "counterclockwise_wheel" )
                {
                    door rotatevelocity( ( 0, 0, 0 ), 0.1 );
                }
            }
            
            if ( door.no_moving_unresolved_collisions )
            {
                door.unresolved_collision_func = undefined;
            }
        }
        
        isusable = !button.one_time_use || !button.hasbeenused;
        
        if ( isusable )
        {
            hintstring = button.statecurr == 0 ? &"mp/door_use_open" : &"mp/door_use_close";
            button makeusable();
            
            if ( !game_utility::function_d3f8957534dc62af() )
            {
                button sethintstring( hintstring );
            }
            
            button waittill( #"trigger" );
            
            if ( isdefined( button.button_sound ) )
            {
                button playsound( button.button_sound );
            }
            
            button.hasbeenused = 1;
        }
        else
        {
            button waittill( #"forever" );
        }
    }
    else if ( button.statecurr == 1 || button.statecurr == 3 )
    {
        if ( isdefined( button.lights_off ) )
        {
            foreach ( light in button.lights_off )
            {
                light show();
            }
        }
        
        button makeunusable();
        
        if ( button.statecurr == 1 )
        {
            button thread door_state_on_interrupt();
            
            foreach ( door in button.doors )
            {
                if ( isdefined( door.script_noteworthy ) )
                {
                    timemove = button.doormovetime ?? 3;
                    posgoal = button.statecurr == 1 ? door.posclosed : door.posopen;
                    distremaining = distance( door.origin, posgoal );
                    time = max( 0.1, distremaining / door.distmove * timemove );
                    timeease = max( time * 0.25, 0.05 );
                    angulardistance = 360 * distremaining / 94.2;
                    
                    if ( door.script_noteworthy == "clockwise_wheel" )
                    {
                        door rotatevelocity( ( 0, 0, -1 * angulardistance / time ), time, timeease, timeease );
                        continue;
                    }
                    
                    if ( door.script_noteworthy == "counterclockwise_wheel" )
                    {
                        door rotatevelocity( ( 0, 0, angulardistance / time ), time, timeease, timeease );
                    }
                }
            }
        }
        else if ( button.statecurr == 3 )
        {
            if ( isdefined( button.open_interrupt ) && button.open_interrupt )
            {
                button thread door_state_on_interrupt();
            }
            
            foreach ( door in button.doors )
            {
                if ( isdefined( door.script_noteworthy ) )
                {
                    timemove = button.doormovetime ?? 3;
                    posgoal = button.statecurr == 1 ? door.posclosed : door.posopen;
                    distremaining = distance( door.origin, posgoal );
                    time = max( 0.1, distremaining / door.distmove * timemove );
                    timeease = max( time * 0.25, 0.05 );
                    angulardistance = 360 * distremaining / 94.2;
                    
                    if ( door.script_noteworthy == "clockwise_wheel" )
                    {
                        door rotatevelocity( ( 0, 0, angulardistance / time ), time, timeease, timeease );
                        continue;
                    }
                    
                    if ( door.script_noteworthy == "counterclockwise_wheel" )
                    {
                        door rotatevelocity( ( 0, 0, -1 * angulardistance / time ), time, timeease, timeease );
                    }
                }
            }
        }
        
        wait 0.1;
        button childthread door_state_update_sound();
        timemove = button.doormovetime ?? 3;
        timemax = undefined;
        
        foreach ( door in button.doors )
        {
            posgoal = button.statecurr == 1 ? door.posclosed : door.posopen;
            
            if ( door.origin != posgoal )
            {
                time = max( 0.1, distance( door.origin, posgoal ) / door.distmove * timemove );
                timeease = max( time * 0.25, 0.05 );
                door moveto( posgoal, time, timeease, timeease );
                door movers::notify_moving_platform_invalid();
                
                if ( door.no_moving_unresolved_collisions )
                {
                    door.unresolved_collision_func = &movers::unresolved_collision_void;
                }
                
                if ( !isdefined( timemax ) || time > timemax )
                {
                    timemax = time;
                }
            }
        }
        
        if ( isdefined( timemax ) )
        {
            wait timemax;
        }
    }
    else if ( button.statecurr == 4 )
    {
        foreach ( door in button.doors )
        {
            door moveto( door.origin, 0.05, 0, 0 );
            door movers::notify_moving_platform_invalid();
            
            if ( door.no_moving_unresolved_collisions )
            {
                door.unresolved_collision_func = undefined;
            }
            
            if ( isdefined( door.script_noteworthy ) )
            {
                if ( door.script_noteworthy == "clockwise_wheel" || door.script_noteworthy == "counterclockwise_wheel" )
                {
                    door rotatevelocity( ( 0, 0, 0 ), 0.05 );
                }
            }
        }
        
        assert( isdefined( button.stateprev ) && ( button.stateprev == 1 || button.stateprev == 3 ), "<dev string:x178>" );
        
        if ( isdefined( button.lights_off ) )
        {
            foreach ( light in button.lights_off )
            {
                light show();
            }
        }
        
        button.entsound stoploopsound();
        
        foreach ( door in button.doors )
        {
            if ( isdefined( door.interrupt_sound ) )
            {
                door playsound( door.interrupt_sound );
            }
        }
        
        wait 1;
    }
    else
    {
        assertmsg( "<dev string:x15d>" + button.statecurr );
    }
    
    button.statedone = 1;
    
    foreach ( door in button.doors )
    {
        door.statedone = 1;
    }
    
    button notify( #"door_state_done" );
}

// Namespace door
// Params 0
// Checksum 0xb6a0b5a0, Offset: 0x2f2d
// Size: 0x2aa
function door_state_update_sound()
{
    button = self;
    var_d864d94e48f44bc4 = 1;
    var_9a7f6c43360cdae6 = 1;
    sound_length = 0;
    
    if ( button.statecurr == 3 || button.statecurr == 1 )
    {
        foreach ( door in button.doors )
        {
            if ( isdefined( door.start_sound ) )
            {
                door playsoundonmovingent( door.start_sound );
                sound_length = lookupsoundlength( door.start_sound ) / 1000;
                var_d864d94e48f44bc4 = 0;
            }
        }
        
        if ( var_d864d94e48f44bc4 )
        {
            if ( !isdefined( button.entsound ) )
            {
                button.entsound = button;
            }
            
            if ( button.statecurr == 3 )
            {
                if ( soundexists( "scrpt_door_wood_double_open" ) )
                {
                    sound_length = lookupsoundlength( "scrpt_door_wood_double_open" ) / 1000;
                    playsoundatpos( button.entsound.origin, "scrpt_door_wood_double_open" );
                }
            }
            else if ( button.statecurr == 1 )
            {
                if ( soundexists( "scrpt_door_wood_double_close" ) )
                {
                    sound_length = lookupsoundlength( "scrpt_door_wood_double_close" ) / 1000;
                    playsoundatpos( button.entsound.origin, "scrpt_door_wood_double_close" );
                }
            }
        }
    }
    
    wait sound_length * 0.3;
    
    if ( button.statecurr == 3 || button.statecurr == 1 )
    {
        foreach ( door in button.doors )
        {
            if ( isdefined( door.loop_sound ) )
            {
                if ( door.loop_sound != "none" )
                {
                    door playloopsound( door.loop_sound );
                }
                
                var_9a7f6c43360cdae6 = 0;
            }
        }
        
        if ( var_9a7f6c43360cdae6 )
        {
            if ( soundexists( "" ) )
            {
                button.entsound playloopsound( "" );
            }
        }
    }
}

// Namespace door
// Params 2
// Checksum 0x6f870d31, Offset: 0x31df
// Size: 0x72
function door_state_change( state, nosound )
{
    button = self;
    
    if ( isdefined( button.statecurr ) )
    {
        door_state_exit( button.statecurr );
        button.stateprev = button.statecurr;
    }
    
    button.statecurr = state;
    button thread door_state_update( nosound );
}

// Namespace door
// Params 1
// Checksum 0xc092377f, Offset: 0x3259
// Size: 0x1f2
function door_state_exit( state )
{
    button = self;
    
    if ( state == 0 || state == 2 )
    {
        if ( isdefined( button.lights_on ) )
        {
            foreach ( light in button.lights_on )
            {
                light hide();
            }
        }
        
        return;
    }
    
    if ( state == 1 || state == 3 )
    {
        if ( isdefined( button.lights_off ) )
        {
            foreach ( light in button.lights_off )
            {
                light hide();
            }
        }
        
        button.entsound stoploopsound();
        
        foreach ( door in button.doors )
        {
            if ( isdefined( door.loop_sound ) )
            {
                door stoploopsound();
            }
        }
        
        return;
    }
    
    if ( state != 4 )
    {
        assertmsg( "<dev string:x15d>" + state );
    }
}

// Namespace door
// Params 0
// Checksum 0xd8c4165c, Offset: 0x3453
// Size: 0x173
function door_state_on_interrupt()
{
    button = self;
    button endon( #"door_state_done" );
    
    if ( !isdefined( button.trigblock ) )
    {
        return;
    }
    
    filtered_triggers = [];
    
    foreach ( trigger in button.trigblock )
    {
        if ( button.statecurr == 1 )
        {
            if ( isdefined( trigger.not_closing ) && trigger.not_closing == 1 )
            {
                continue;
            }
        }
        else if ( button.statecurr == 3 )
        {
            if ( isdefined( trigger.not_opening ) && trigger.not_opening == 1 )
            {
                continue;
            }
        }
        
        filtered_triggers[ filtered_triggers.size ] = trigger;
    }
    
    if ( filtered_triggers.size > 0 )
    {
        interrupter = button waittill_any_triggered_return_triggerer( filtered_triggers );
        
        if ( !isdefined( interrupter.fauxdead ) || interrupter.fauxdead == 0 )
        {
            button.stateinterrupted = 1;
            button notify( #"door_state_interrupted" );
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x82257254, Offset: 0x35ce
// Size: 0xa3
function waittill_any_triggered_return_triggerer( triggers )
{
    button = self;
    
    foreach ( trigger in triggers )
    {
        button thread return_triggerer( trigger );
    }
    
    button waittill( #"interrupted" );
    return button.interrupter;
}

// Namespace door
// Params 1
// Checksum 0xc0175e47, Offset: 0x367a
// Size: 0x119
function return_triggerer( trigger )
{
    button = self;
    button endon( #"door_state_done" );
    button endon( #"interrupted" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isdefined( trigger.prone_only ) && trigger.prone_only == 1 )
        {
            if ( isplayer( ent ) )
            {
                stance = ent getstance();
                
                if ( stance != "prone" )
                {
                    continue;
                }
                else
                {
                    norm_facing_vec = vectornormalize( anglestoforward( ent.angles ) );
                    var_e95203f9d926fe2a = vectornormalize( trigger.origin - ent.origin );
                    dot = vectordot( norm_facing_vec, var_e95203f9d926fe2a );
                    
                    if ( dot > 0 )
                    {
                        continue;
                    }
                }
            }
        }
        
        break;
    }
    
    button.interrupter = ent;
    button notify( #"interrupted" );
}

// Namespace door
// Params 1
// Checksum 0xff7265ac, Offset: 0x379b
// Size: 0x1a2
function button_parse_parameters( parameters )
{
    button = self;
    button.button_sound = undefined;
    
    if ( !isdefined( parameters ) )
    {
        parameters = "";
    }
    
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
            button.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_1e106e4c46349825":
                button.open_interrupt = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_6b61f3acb03c8ba1":
                button.button_sound = toks[ 1 ];
                break;
            case #"hash_4f3615defbb56240":
                button.start_closed = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_cf9b0fd30cea035":
                button.one_time_use = utility::string_to_bool( toks[ 1 ] );
                break;
            default:
                break;
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x2526568d, Offset: 0x3945
// Size: 0x246
function door_parse_parameters( parameters )
{
    door = self;
    door.start_sound = undefined;
    door.stop_sound = undefined;
    door.loop_sound = undefined;
    door.interrupt_sound = undefined;
    
    if ( !isdefined( parameters ) )
    {
        parameters = "";
    }
    
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
            door.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_5c3e74aaa13bc78d":
                door.stop_sound = toks[ 1 ];
                break;
            case #"hash_9e73d538861d053c":
                door.interrupt_sound = toks[ 1 ];
                break;
            case #"hash_78225775c0698cc3":
                door.loop_sound = toks[ 1 ];
                break;
            case #"hash_1e106e4c46349825":
                door.open_interrupt = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_4d982a4c5ddaeacf":
                door.start_sound = toks[ 1 ];
                break;
            case #"hash_82406ab59ce5c4df":
                door.unresolved_collision_nodes = getnodearray( toks[ 1 ], #targetname );
                break;
            case #"hash_16b31759aeac5f43":
                door.no_moving_unresolved_collisions = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_edda8e2907d42dc0":
                door.material = toks[ 1 ];
                break;
            default:
                break;
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x7217c94, Offset: 0x3b93
// Size: 0x178
function trigger_parse_parameters( parameters )
{
    trigger = self;
    
    if ( !isdefined( parameters ) )
    {
        parameters = "";
    }
    
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
            trigger.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_9d83eef6d488a45":
                trigger.not_opening = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_5f7e7fdb9440ae8e":
                trigger.not_closing = utility::string_to_bool( toks[ 1 ] );
                break;
            case #"hash_74a33663cf817e18":
                trigger.prone_only = utility::string_to_bool( toks[ 1 ] );
                break;
            default:
                break;
        }
    }
}

// Namespace door
// Params 0
// Checksum 0xae28ad70, Offset: 0x3d13
// Size: 0x159
function bashmonitor()
{
    if ( self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self endon( #"statechanged" );
    self notify( #"hash_77808edc4adedb4f" );
    self endon( #"hash_77808edc4adedb4f" );
    thread monitordamage();
    
    while ( true )
    {
        self.doorcenter = self.origin + anglestoforward( self.angles ) * self.length * 0.5 + anglestoup( self.angles ) * self.height * 0.5;
        players = getplayersinradius( self.origin, 250 );
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( bashproxcheck( player ) && shouldbashopen( player ) )
                {
                    thread bashopen( player, player.origin );
                }
            }
            
            waitframe();
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace door
// Params 1
// Checksum 0xe614c420, Offset: 0x3e74
// Size: 0x41, Type: bool
function bashproxcheck( player )
{
    d = distancesquared( player.origin, self.doorcenter );
    range = 4900;
    return d < range;
}

// Namespace door
// Params 1
// Checksum 0x16c480f7, Offset: 0x3ebe
// Size: 0x19a, Type: bool
function shouldbashopen( player )
{
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    playerfwd = anglestoforward( player.angles );
    
    if ( utility::within_fov( player.origin + playerfwd * -45, player.angles, self.doorcenter, cos( 43 ) ) )
    {
        doorright = anglestoright( self.angles );
        var_5963558a46c145b6 = vectornormalize( self.doorcenter - player geteye() );
        var_a1bac411bbdfb44f = vectordot( playerfwd, var_5963558a46c145b6 );
        var_433a75af1de5a48 = vectordot( playerfwd, doorright );
        playervelocity = player getvelocity();
        var_e01e5067d0b2903d = vectordot( vectornormalize( playervelocity ), ( 0, 0, 1 ) );
        
        if ( ( length( playervelocity ) >= 200 || player killstreak::isjuggernaut() && length( playervelocity ) >= 140 ) && abs( var_e01e5067d0b2903d ) < 0.75 && abs( var_433a75af1de5a48 ) > 0.75 && var_a1bac411bbdfb44f > 0.75 )
        {
            handletag = self gettagorigin( "tag_door_handle", 1 );
            
            if ( isdefined( handletag ) )
            {
                trace = trace::ray_trace( player geteye(), handletag, player, level.doorcontentoverride, 0 );
                
                if ( trace[ "entity" ] == self )
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace door
// Params 2
// Checksum 0xe70341c7, Offset: 0x4061
// Size: 0x3ed
function bashopen( player, pos )
{
    thread checktriggeralarm( player );
    thread changestate( 5 );
    
    if ( self.bashed )
    {
        return;
    }
    
    if ( !isdefined( self.useprompt ) )
    {
        self.bashed = 1;
    }
    
    origin = self.origin;
    angles = self.angles;
    right = anglestoright( angles );
    normal = vectornormalize( pos - self.origin );
    dot = vectordot( right, normal );
    openleft = dot > 0;
    bash_yaw = undefined;
    
    if ( isplayer( player ) )
    {
        if ( !isai( player ) )
        {
            thread bashpresentation( player );
        }
        else
        {
            self notify( #"ai_opened" );
        }
    }
    
    if ( isdefined( self.material ) )
    {
        if ( self.material == "metal" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_heavy_metal_single_bash" );
        }
        else if ( self.material == "wood" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_barn_bash" );
        }
    }
    else
    {
        playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_double_bash" );
    }
    
    if ( openleft )
    {
        bash_yaw = self.baseangles[ 1 ] + self.max_yaw_left;
    }
    else
    {
        bash_yaw = self.baseangles[ 1 ] - self.max_yaw_right;
    }
    
    if ( bash_yaw > 360 )
    {
        bash_yaw -= 360;
    }
    else if ( bash_yaw < 0 )
    {
        bash_yaw += 360;
    }
    
    maxbashtime = 0.35;
    minbashtime = 0.15;
    timefactor = math::normalize_value( 0, 170, bash_yaw );
    bashtime = math::factor_value( maxbashtime, minbashtime, timefactor );
    current_angles = self.angles;
    current_yaw = current_angles[ 1 ];
    
    if ( current_yaw > 360 )
    {
        current_yaw -= 360;
    }
    else if ( current_yaw < 0 )
    {
        current_yaw += 360;
    }
    
    currentdiff = angle_diff( current_yaw, self.baseangles[ 1 ] );
    bashdiff = angle_diff( bash_yaw, self.baseangles[ 1 ] );
    currentfwd = anglestoforward( current_angles );
    baseright = anglestoright( self.baseangles );
    var_be7588dbd21c836e = vectordot( currentfwd, baseright ) < 0;
    
    if ( openleft )
    {
        if ( !var_be7588dbd21c836e )
        {
            bashdiff += currentdiff;
        }
        else
        {
            bashdiff -= currentdiff;
        }
    }
    else
    {
        if ( var_be7588dbd21c836e )
        {
            bashdiff += currentdiff;
        }
        else
        {
            bashdiff -= currentdiff;
        }
        
        bashdiff *= -1;
    }
    
    var_3c9d7fe0d5ce8228 = ( 0, bashdiff, 0 );
    self rotateby( var_3c9d7fe0d5ce8228, bashtime );
    wait bashtime;
    self.lastpushtime = gettime();
    thread changestate( 6 );
    
    if ( !isdefined( self.useprompt ) )
    {
        self.statecurr = 2;
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            self.trigger sethintstring( &"mp/door_use_close" );
        }
    }
    
    self.bashed = 0;
    bounceback_time = randomfloatrange( 3, 5 );
    bounceback_yaw = randomfloatrange( 0.25, 2.5 );
    
    if ( openleft )
    {
        bounceback_yaw *= -1;
    }
    
    self rotateyaw( bounceback_yaw, bounceback_time, 0.5, bounceback_time - 0.5 );
}

// Namespace door
// Params 1
// Checksum 0x57d9c2a7, Offset: 0x4456
// Size: 0x36
function bashpresentation( player )
{
    player playrumbleonentity( "grenade_rumble" );
    player earthquakeforplayer( 0.35, 0.5, player.origin, 200 );
}

// Namespace door
// Params 0
// Checksum 0x970ff23e, Offset: 0x4494
// Size: 0x241
function monitordamage()
{
    self endon( #"statechanged" );
    self notify( #"monitordamage" );
    self endon( #"monitordamage" );
    self setcandamage( 1 );
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    meansofdeath = undefined;
    modelname = undefined;
    tagname = undefined;
    partname = undefined;
    idflags = undefined;
    objweapon = undefined;
    origin = undefined;
    angles = undefined;
    normal = undefined;
    inflictor = undefined;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( meansofdeath ) )
        {
            if ( meansofdeath == "MOD_MELEE" )
            {
                if ( self.issaloonstyle )
                {
                    self.otherdoor thread bashopen( attacker, attacker.origin );
                }
                
                thread bashopen( attacker, attacker.origin );
                continue;
            }
            
            if ( meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" )
            {
                ismolotov = isdefined( objweapon ) && isdefined( objweapon.basename ) && ( objweapon.basename == "molotov_mp" || objweapon.basename == "thermite_mp" || objweapon.basename == "thermite_ap_mp" || objweapon.basename == "thermite_av_mp" );
                
                if ( damage > 10 && !ismolotov )
                {
                    thread bashopen( inflictor, point );
                }
                
                continue;
            }
            
            if ( isdefined( objweapon ) && objweapon.basename == "pac_sentry_turret_mp" && ( meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" ) )
            {
                thread bashopen( inflictor, point );
            }
        }
    }
}

// Namespace door
// Params 0
// Checksum 0x925938d6, Offset: 0x46dd
// Size: 0x1a8
function openmonitor()
{
    self endon( #"statechanged" );
    
    if ( self.state == 7 || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    if ( self.islean || 0 || -1 )
    {
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            self.useprompt sethintstring( &"mp/door_use_open" );
        }
    }
    else if ( !game_utility::function_d3f8957534dc62af() )
    {
        self.useprompt sethintstring( &"mp/door_use_open_double" );
    }
    
    self.useprompt sethintdisplayrange( 200 );
    
    while ( true )
    {
        self.useprompt waittill( #"trigger_progress", player );
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        buttontime = 0;
        
        while ( buttontime < 0.1 )
        {
            if ( !player usebuttonpressed() )
            {
                break;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        if ( self.state == 7 )
        {
            handletag = self gettagorigin( "tag_door_handle", 1 );
            
            if ( isdefined( handletag ) )
            {
                playsoundatpos( handletag, "door_locked" );
            }
            else
            {
                playsoundatpos( self.origin + ( 0, 0, 42 ), "door_locked" );
            }
            
            continue;
        }
        
        if ( self.islean )
        {
            thread cheapopen( player );
            return;
        }
        
        if ( -1 && player playerads() > 0.9 )
        {
            thread ajar( player );
            return;
        }
        
        thread cheapopen( player );
    }
}

// Namespace door
// Params 1
// Checksum 0x31b10788, Offset: 0x488d
// Size: 0x2a6
function cheapopen( player )
{
    thread checktriggeralarm( player );
    origin = self.useprompt.origin;
    angles = self.angles;
    right = anglestoright( angles );
    normal = vectornormalize( player.origin - origin );
    dot = vectordot( right, normal );
    openleft = dot > 0;
    
    if ( isdefined( self.material ) )
    {
        if ( self.material == "metal" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_heavy_metal_single_open" );
        }
        else if ( self.material == "wood" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_barn_open" );
        }
    }
    else
    {
        playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_double_open" );
    }
    
    thread changestate( 3 );
    targetyaw = openleft ? self.max_yaw_left : self.max_yaw_right * -1;
    openangles = ( self.baseangles[ 0 ], self.baseangles[ 1 ] + targetyaw, self.baseangles[ 2 ] );
    self rotateto( openangles, 0.666, 0, 0.333 );
    
    if ( isdefined( self.otherdoor ) && self.issaloonstyle )
    {
        targetyaw = !openleft ? self.otherdoor.max_yaw_left : self.otherdoor.max_yaw_right * -1;
        openangles = ( self.otherdoor.baseangles[ 0 ], self.otherdoor.baseangles[ 1 ] + targetyaw, self.otherdoor.baseangles[ 2 ] );
        self.otherdoor rotateto( openangles, 0.666, 0, 0.333 );
    }
    
    wait 0.666;
    self.lastpushtime = gettime();
    thread changestate( 2 );
    
    if ( isdefined( self.otherdoor ) && self.issaloonstyle )
    {
        self.otherdoor thread changestate( 2 );
    }
}

// Namespace door
// Params 1
// Checksum 0x7702a3c5, Offset: 0x4b3b
// Size: 0x1e8
function ajar( player )
{
    thread checktriggeralarm( player );
    thread changestate( 6 );
    origin = self.useprompt.origin;
    angles = self.angles;
    right = anglestoright( angles );
    normal = vectornormalize( player.origin - origin );
    dot = vectordot( right, normal );
    openleft = dot > 0;
    time = 0.5;
    yaw_angle = openleft ? 15 : -15;
    player playrumbleonentity( "damage_heavy" );
    
    if ( isdefined( self.material ) )
    {
        if ( self.material == "metal" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_heavy_metal_single_start_peek" );
        }
        else if ( self.material == "wood" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_barn_start_peek" );
        }
    }
    else
    {
        playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_double_start_peek" );
    }
    
    self rotateyaw( yaw_angle, time, time * 0.25, time * 0.75 );
    
    if ( isdefined( self.otherdoor ) && self.issaloonstyle )
    {
        self.otherdoor thread changestate( 6 );
        yaw_angle = !openleft ? 15 : -15;
        self.otherdoor rotateyaw( yaw_angle, time, time * 0.25, time * 0.75 );
    }
    
    self.lastpushtime = gettime();
}

// Namespace door
// Params 0
// Checksum 0x366ba25d, Offset: 0x4d2b
// Size: 0x11e
function pushmonitor()
{
    if ( self.islean )
    {
        return;
    }
    
    self endon( #"statechanged" );
    self notify( #"hash_b0d6408cdb5dac31" );
    self endon( #"hash_b0d6408cdb5dac31" );
    wait 0.5;
    
    while ( true )
    {
        players = getplayersinradius( self.origin, 250 );
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( pushproxcheck( player ) )
                {
                    push( player );
                    self.lastpushtime = gettime();
                    door_destroynavobstacle();
                }
            }
        }
        
        if ( isdefined( self.lastpushtime ) && gettime() > self.lastpushtime + 2000 )
        {
            door_createnavobstacle();
        }
        
        waitframe();
    }
}

// Namespace door
// Params 1
// Checksum 0x13967afd, Offset: 0x4e51
// Size: 0xdb, Type: bool
function pushproxcheck( player )
{
    self.doorcenter = self.origin + anglestoforward( self.angles ) * self.length * 0.5 + anglestoup( self.angles ) * self.height * 0.5;
    
    if ( player.origin[ 2 ] > self.origin[ 2 ] + self.height || player.origin[ 2 ] + 70 < self.origin[ 2 ] )
    {
        return false;
    }
    
    d = distance2dsquared( player.origin, self.doorcenter );
    range = 900;
    return d < range;
}

// Namespace door
// Params 1
// Checksum 0x1732cd8, Offset: 0x4f35
// Size: 0x273
function push( player )
{
    max_dist = 26;
    min_dist = 0;
    max_push = 25;
    endpoint = self.origin + anglestoforward( self.angles ) * 28;
    dist = distance2d( player.origin, endpoint );
    percent = math::normalize_value( min_dist, max_dist, dist );
    amount = max_push * ( 1 - percent );
    
    if ( amount == 0 )
    {
        return;
    }
    
    origin = self.useprompt.origin;
    angles = self.angles;
    right = anglestoright( angles );
    normal = vectornormalize( player.origin - origin );
    dot = vectordot( right, normal );
    openleft = dot > 0;
    currentyaw = self.angles[ 1 ];
    isright = openleft == 1 ? 1 : -1;
    target_yaw = currentyaw + amount * isright;
    angle_diff = angle_diff( target_yaw, self.baseangles[ 1 ] );
    
    if ( openleft )
    {
        if ( angle_diff > self.max_yaw_left )
        {
            self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
            self.angles = ( self.angles[ 0 ], self.baseangles[ 1 ] + self.max_yaw_left, self.angles[ 2 ] );
            return;
        }
    }
    else if ( angle_diff > self.max_yaw_right )
    {
        self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
        self.angles = ( self.angles[ 0 ], self.baseangles[ 1 ] - self.max_yaw_right, self.angles[ 2 ] );
        return;
    }
    
    /#
        self.debug_activity = "<dev string:x1c2>" + target_yaw;
    #/
    
    self.angles = ( self.angles[ 0 ], target_yaw, self.angles[ 2 ] );
}

// Namespace door
// Params 0
// Checksum 0xfce78cdd, Offset: 0x51b0
// Size: 0xb5
function autoclosemonitor()
{
    if ( self.islean )
    {
        return;
    }
    
    self endon( #"statechanged" );
    self notify( #"hash_a039f1d029ab68b4" );
    self endon( #"hash_a039f1d029ab68b4" );
    wait 0.5;
    
    while ( true )
    {
        if ( angle_diff( self.angles[ 1 ], self.baseangles[ 1 ] ) < 40 )
        {
            if ( isdefined( self.lastpushtime ) && gettime() > self.lastpushtime + 3000 )
            {
                players = getplayersinradius( self.origin, 250 );
                
                if ( players.size == 0 )
                {
                    thread closedoor( 1 );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace door
// Params 1
// Checksum 0x32b3e38d, Offset: 0x526d
// Size: 0x29d
function changestate( newstate )
{
    if ( !isdefined( self.useprompt ) )
    {
        return;
    }
    
    switch ( self.state )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            if ( isdefined( self.useprompt ) )
            {
                self.useprompt sethinticon( "icon_door_unlocked" );
            }
            
            break;
        case 8:
            break;
    }
    
    self.state = newstate;
    self notify( #"statechanged" );
    
    switch ( newstate )
    {
        case 0:
            door_destroynavobstacle();
            door_disableaudioportal();
            thread openmonitor();
            thread bashmonitor();
            thread lockmonitor();
            thread alarmmonitor();
            thread ajarmonitor();
            break;
        case 1:
            door_destroynavobstacle();
            break;
        case 2:
            door_createnavobstacle();
            door_enableaudioportal();
            thread closemonitor();
            thread bashmonitor();
            break;
        case 3:
            door_destroynavobstacle();
            door_enableaudioportal();
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            door_enableaudioportal();
            thread closemonitor();
            thread pushmonitor();
            thread bashmonitor();
            thread autoclosemonitor();
            break;
        case 7:
            if ( isdefined( self.useprompt ) )
            {
                self.useprompt sethintdisplayrange( 300 );
                self.useprompt sethinticon( "icon_door_locked" );
                self.useprompt sethintstring( &"mp/door_use_locked" );
            }
            
            thread openmonitor();
            thread breachmonitor();
            break;
        case 8:
            thread openmonitor();
            thread bashmonitor();
            thread removealarmmonitor();
            thread disownalarmmonitor();
            break;
    }
    
    thread updatelockpromptvisibility();
    thread updatealarmpromptvisibility();
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread updatealarmpromptvisibility();
    }
}

// Namespace door
// Params 0
// Checksum 0x9f4cf536, Offset: 0x5512
// Size: 0x9a
function updatestate()
{
    switch ( self.state )
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
    }
}

// Namespace door
// Params 0
// Checksum 0xc1f2c572, Offset: 0x55b4
// Size: 0x106
function closemonitor()
{
    self endon( #"statechanged" );
    
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self.useprompt makeusable();
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        self.useprompt sethintstring( &"mp/door_use_close" );
    }
    
    self.useprompt sethintdisplayrange( 200 );
    self.useprompt sethintdisplayfov( 120 );
    self.useprompt setuserange( 125 );
    self.useprompt setusefov( 120 );
    
    while ( true )
    {
        self.useprompt waittill( #"trigger_progress", player );
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        buttontime = 0;
        
        while ( buttontime < 0.1 )
        {
            if ( !player usebuttonpressed() )
            {
                break;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        thread closedoor();
    }
}

// Namespace door
// Params 1
// Checksum 0xaf475e58, Offset: 0x56c2
// Size: 0x1e2
function closedoor( wasauto )
{
    if ( isdefined( self.material ) )
    {
        if ( self.material == "metal" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_heavy_metal_single_close" );
        }
        else if ( self.material == "wood" )
        {
            playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_barn_close" );
        }
    }
    else
    {
        playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_double_close" );
    }
    
    thread changestate( 1 );
    closeduration = 0.666;
    
    if ( wasauto )
    {
        closeduration *= 3;
    }
    
    self rotateto( self.baseangles, closeduration, 0, 0.333 );
    
    if ( isdefined( self.otherdoor ) && self.issaloonstyle )
    {
        self.otherdoor rotateto( self.otherdoor.baseangles, closeduration, 0, 0.333 );
    }
    
    wait closeduration;
    waitframe();
    
    if ( angle_diff( self.angles[ 1 ], self.baseangles[ 1 ] ) < 1 )
    {
        thread changestate( 0 );
    }
    else
    {
        thread changestate( 6 );
    }
    
    if ( isdefined( self.otherdoor ) && self.issaloonstyle )
    {
        if ( angle_diff( self.otherdoor.angles[ 1 ], self.otherdoor.baseangles[ 1 ] ) < 1 )
        {
            self.otherdoor thread changestate( 0 );
            return;
        }
        
        self.otherdoor thread changestate( 6 );
    }
}

// Namespace door
// Params 2
// Checksum 0x8ebc71b0, Offset: 0x58ac
// Size: 0x27
function angle_diff( value1, value2 )
{
    return 180 - abs( abs( value1 - value2 ) - 180 );
}

// Namespace door
// Params 0
// Checksum 0xd96e3746, Offset: 0x58dc
// Size: 0x261
function amortizeyawtraces()
{
    level.doorphase = 0;
    level.doortracequeue = 0;
    var_d344f2593accf664 = [];
    var_610d5d8ba7b79cc0 = [];
    level.doortracemetrics = spawnstruct();
    level.doortracemetrics.doorcount = level.doors.size;
    level.doortracemetrics.totaltracecount = 0;
    level.doortracemetrics.tracecountbyphase = [];
    level.doortracemetrics.tracetimebyphase = [];
    level.doortracemetrics.totaltime = 0;
    level.doortracemetrics.totalwaitframes = 0;
    level.waitcycles = 0;
    level.doortraces = 0;
    waitframe();
    level.doortracemetrics.totaltime = gettime();
    var_610d5d8ba7b79cc0[ 0 ] = level.doortracemetrics.totaltime;
    
    while ( true )
    {
        if ( level.doortracequeue == 0 )
        {
            currenttime = gettime();
            var_610d5d8ba7b79cc0[ level.doorphase ] = currenttime - var_610d5d8ba7b79cc0[ level.doorphase ];
            var_d344f2593accf664[ level.doorphase ] = level.doortraces;
            level.doortracemetrics.totaltracecount += level.doortraces;
            level.doortraces = 0;
            level.doortracemetrics.totalwaitframes += level.waitcycles;
            level.waitcycles = 0;
            level.doorphase++;
            level notify( #"hash_66c428278f6e663c" );
            
            if ( level.doorphase < 3 )
            {
                var_610d5d8ba7b79cc0[ level.doorphase ] = currenttime;
            }
            else
            {
                break;
            }
        }
        
        waitframe();
    }
    
    level.doortracemetrics.totaltime = gettime() - level.doortracemetrics.totaltime;
    level.doortracemetrics.tracecountbyphase = var_d344f2593accf664;
    level.doortracemetrics.tracetimebyphase = var_610d5d8ba7b79cc0;
}

// Namespace door
// Params 0
// Checksum 0x4e5c8b2f, Offset: 0x5b45
// Size: 0x13
function get_max_yaws()
{
    thread get_max_yaw( 1 );
    thread get_max_yaw( 0 );
}

// Namespace door
// Params 1
// Checksum 0x91d7ec0f, Offset: 0x5b60
// Size: 0x109
function get_max_yaw( left )
{
    if ( left )
    {
        if ( isdefined( self.script_max_left_angle ) )
        {
            self.max_yaw_left = self.script_max_left_angle;
            return;
        }
    }
    else if ( isdefined( self.script_max_right_angle ) )
    {
        self.max_yaw_right = self.script_max_right_angle;
        return;
    }
    
    testyaw = 90;
    testincrement = 10;
    safeyaw = 0;
    
    while ( level.doorphase < 3 )
    {
        safeyaw = get_max_yaw_internal( testyaw, testincrement, left );
        
        if ( left )
        {
            self.max_yaw_left = safeyaw;
        }
        else
        {
            self.max_yaw_right = safeyaw;
        }
        
        if ( safeyaw == 100 )
        {
            break;
        }
        
        testincrement *= 0.5;
        testyaw = safeyaw + testincrement;
        level waittill( #"hash_66c428278f6e663c" );
    }
    
    safeyaw = max( safeyaw, 90 );
    
    if ( left )
    {
        self.max_yaw_left = safeyaw;
        return;
    }
    
    self.max_yaw_right = safeyaw;
}

// Namespace door
// Params 3
// Checksum 0x15c4e565, Offset: 0x5c71
// Size: 0x19c
function get_max_yaw_internal( test_yaw, increment, left )
{
    if ( !isdefined( self.traces ) )
    {
        self.traces = 0;
    }
    
    if ( !isdefined( level.doortraces ) )
    {
        level.doortraces = 0;
    }
    
    failed_once = 0;
    finished = 0;
    level.doortracequeue++;
    waitframe();
    
    while ( !finished )
    {
        if ( test_yaw > 100 )
        {
            level.currentdoor = undefined;
            level.doortracequeue--;
            return 100;
        }
        
        while ( isdefined( level.currentdoor ) && self != level.currentdoor )
        {
            waitframe();
        }
        
        if ( !isdefined( level.currentdoor ) )
        {
            level.currentdoor = self;
        }
        
        safe_yaw = yaw_collision_check( test_yaw, increment, left );
        
        if ( safe_yaw )
        {
            if ( failed_once )
            {
                finish = 1;
            }
            
            test_yaw += increment;
        }
        else
        {
            if ( !failed_once )
            {
                failed_once = 1;
            }
            
            test_yaw -= increment;
            finished = 1;
        }
        
        self.traces++;
        level.doortraces++;
        currenttime = gettime();
        
        if ( level.doortraceframetime != currenttime )
        {
            level.doortraceframetime = currenttime;
            level.doortracesthisframe = 0;
        }
        
        level.doortracesthisframe++;
        
        if ( level.doortracesthisframe == 3 )
        {
            level.doortracesthisframe = 0;
            level.waitcycles++;
            waitframe();
        }
    }
    
    level.currentdoor = undefined;
    level.doortracequeue--;
    return test_yaw;
}

// Namespace door
// Params 3
// Checksum 0x47755d4c, Offset: 0x5e16
// Size: 0x1d2, Type: bool
function yaw_collision_check( yaw, increment, left )
{
    if ( !left )
    {
        yaw *= -1;
    }
    
    trace_angles = self.baseangles + ( 0, yaw, 0 );
    basestart = self.origin + ( 0, 0, 8 );
    testheight = self.height - 16;
    doorfwd = anglestoforward( trace_angles );
    start = basestart + doorfwd * self.length * 0.2;
    end = basestart + doorfwd * ( self.length - 2 );
    trace = trace::capsule_trace( start, end, 2, testheight, trace_angles, isdefined( self.clip ) ? [ self, self.clip ] : [ self ], level.doorcontentoverride, 0 );
    
    if ( getdvarint( @"scr_door_debug" ) )
    {
        color = ( 1, 1, 1 );
        
        if ( trace[ "fraction" ] == 1 )
        {
            color = ( 0, 1, 0 );
        }
        else
        {
            color = ( 1, 0, 0 );
        }
        
        thread debug::drawline( start, end, 600, color );
        thread debug::drawline( start + ( 0, 0, testheight ), end + ( 0, 0, testheight ), 600, color );
        thread debug::drawline( start, start + ( 0, 0, testheight ), 600, color );
        thread debug::drawline( end, end + ( 0, 0, testheight ), 600, color );
    }
    
    return trace[ "fraction" ] == 1;
}

// Namespace door
// Params 0
// Checksum 0x1c2c330a, Offset: 0x5ff1
// Size: 0x15d
function perk_doorsensethink()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( door in level.doors )
        {
            if ( door.state != 0 )
            {
                continue;
            }
            
            if ( level.playerswithdoorsense <= 0 )
            {
                continue;
            }
            
            playersneardoor = getplayersinradius( door.origin, 128 );
            
            if ( playersneardoor.size == 0 )
            {
                continue;
            }
            
            foreach ( player in playersneardoor )
            {
                if ( isdefined( player.perks[ "specialty_door_sense" ] ) )
                {
                    perk_doorsense_outlinedoor( player, playersneardoor, door );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace door
// Params 3
// Checksum 0x4d91349f, Offset: 0x6156
// Size: 0x157
function perk_doorsense_outlinedoor( var_8d49626e6622d332, playersneardoor, door )
{
    enemies = [];
    
    foreach ( player in playersneardoor )
    {
        if ( player.team != var_8d49626e6622d332.team )
        {
            enemies[ enemies.size ] = player;
        }
    }
    
    if ( enemies.size == 0 )
    {
        return;
    }
    
    foreach ( enemy in enemies )
    {
        if ( perk_doorsense_othersideofdoorcheck( var_8d49626e6622d332, enemy, door ) )
        {
            outlineid = outline::outlineenableforplayer( door, var_8d49626e6622d332, "outline_nodepth_orange", "equipment" );
            thread perk_doorsense_trackoutlinedisable( outlineid, door );
        }
    }
}

// Namespace door
// Params 3
// Checksum 0x3dc39992, Offset: 0x62b5
// Size: 0x157
function perk_doorsense_outlineenemies( var_8d49626e6622d332, playersneardoor, door )
{
    enemies = [];
    
    foreach ( player in playersneardoor )
    {
        if ( player.team != var_8d49626e6622d332.team )
        {
            enemies[ enemies.size ] = player;
        }
    }
    
    if ( enemies.size == 0 )
    {
        return;
    }
    
    foreach ( enemy in enemies )
    {
        if ( perk_doorsense_othersideofdoorcheck( var_8d49626e6622d332, enemy, door ) )
        {
            outlineid = outline::outlineenableforplayer( enemy, var_8d49626e6622d332, "outline_nodepth_orange", "equipment" );
            thread perk_doorsense_trackoutlinedisable( outlineid, enemy );
        }
    }
}

// Namespace door
// Params 3
// Checksum 0xb85713cb, Offset: 0x6414
// Size: 0xcc, Type: bool
function perk_doorsense_othersideofdoorcheck( player1, player2, door )
{
    var_f464ab9469130bd4 = vectornormalize( anglestoright( door.angles ) );
    var_978e828ba4697fa4 = vectornormalize( player1.origin - door.origin );
    var_1129730bc18e906d = vectornormalize( player2.origin - door.origin );
    dotplayer1 = vectordot( var_f464ab9469130bd4, var_978e828ba4697fa4 );
    dotplayer2 = vectordot( var_f464ab9469130bd4, var_1129730bc18e906d );
    
    if ( dotplayer1 > 0 && dotplayer2 < 0 || dotplayer1 < 0 && dotplayer2 > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace door
// Params 2
// Checksum 0xb6dced29, Offset: 0x64e9
// Size: 0x25
function perk_doorsense_trackoutlinedisable( outlineid, player )
{
    wait 0.2;
    outline::outlinedisable( outlineid, player );
}

// Namespace door
// Params 1
// Checksum 0x4dd39328, Offset: 0x6516
// Size: 0x6b
function onplayerspawned( params )
{
    var_82ddc727f162a5ca = isdefined( self.perks[ "specialty_door_breach" ] ) || getdvarint( @"hash_b75e6afff090e790", 0 ) == 1;
    updatealldoorslockvisibilityforplayer( self, var_82ddc727f162a5ca );
    var_ceebea6285ed4e46 = isdefined( self.perks[ "specialty_door_alarm" ] );
    updatealldoorsalarmvisibilityforplayer( self, var_ceebea6285ed4e46 );
}

// Namespace door
// Params 0
// Checksum 0xa681f9ad, Offset: 0x6589
// Size: 0xc9
function updatelockpromptvisibility()
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        var_82ddc727f162a5ca = isdefined( player.perks[ "specialty_door_breach" ] ) || getdvarint( @"hash_b75e6afff090e790", 0 ) == 1;
        updatelockpromptvisibilityforplayer( player, var_82ddc727f162a5ca );
    }
}

// Namespace door
// Params 2
// Checksum 0x51158d10, Offset: 0x665a
// Size: 0x90
function updatealldoorslockvisibilityforplayer( player, var_82ddc727f162a5ca )
{
    foreach ( door in level.doors )
    {
        door updatelockpromptvisibilityforplayer( player, var_82ddc727f162a5ca );
    }
}

// Namespace door
// Params 2
// Checksum 0xdb37b8e2, Offset: 0x66f2
// Size: 0x10d
function updatelockpromptvisibilityforplayer( player, visibility )
{
    if ( !isdefined( self.lockprompt ) )
    {
        return;
    }
    
    statecheck = self.state == 0 || self.state == 7;
    
    if ( statecheck && isdefined( self.otherdoor ) )
    {
        statecheck = self.otherdoor.state == 0 || self.otherdoor.state == 7;
    }
    
    if ( !self.breaching && statecheck )
    {
        if ( visibility )
        {
            self.lockprompt showtoplayer( player );
            self.lockprompt enableplayeruse( player );
        }
        else
        {
            self.lockprompt hidefromplayer( player );
            self.lockprompt disableplayeruse( player );
        }
        
        return;
    }
    
    self.lockprompt hidefromplayer( player );
    self.lockprompt disableplayeruse( player );
}

// Namespace door
// Params 0
// Checksum 0x1d549f67, Offset: 0x6807
// Size: 0xe7
function lockmonitor()
{
    if ( !isdefined( self.lockprompt ) || self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self endon( #"statechanged" );
    
    if ( isdefined( self.otherdoor ) )
    {
        while ( self.otherdoor.state != 0 )
        {
            waitframe();
        }
    }
    
    self.lockprompt sethintstring( &"MP/DOOR_USE_LOCK" );
    self.lockprompt setuseholdduration( "duration_medium" );
    updatelockpromptvisibility();
    
    while ( true )
    {
        self.lockprompt waittill( #"trigger", player );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        thread lockdoor();
    }
}

// Namespace door
// Params 0
// Checksum 0x234db4b0, Offset: 0x68f6
// Size: 0x2a
function lockdoor()
{
    thread changestate( 7 );
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread changestate( 7 );
    }
}

// Namespace door
// Params 0
// Checksum 0xfab56bdb, Offset: 0x6928
// Size: 0xb4
function updatealarmpromptvisibility()
{
    if ( game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        var_ceebea6285ed4e46 = isdefined( player.perks[ "specialty_door_alarm" ] );
        updatealarmpromptsvisibilityforplayer( player, var_ceebea6285ed4e46 );
    }
}

// Namespace door
// Params 2
// Checksum 0xf30277d1, Offset: 0x69e4
// Size: 0x90
function updatealldoorsalarmvisibilityforplayer( player, var_ceebea6285ed4e46 )
{
    foreach ( door in level.doors )
    {
        door updatealarmpromptsvisibilityforplayer( player, var_ceebea6285ed4e46 );
    }
}

// Namespace door
// Params 2
// Checksum 0x642046e3, Offset: 0x6a7c
// Size: 0x155
function updatealarmpromptsvisibilityforplayer( player, canseeprompt )
{
    if ( !isdefined( self.alarmprompts ) )
    {
        return;
    }
    
    foreach ( alarmprompt in self.alarmprompts )
    {
        visiblestate = canseeprompt && self.state == 0 || self.state == 8 && isdefined( self.dooralarmprompt ) && alarmprompt == self.dooralarmprompt;
        
        if ( visiblestate && isdefined( self.otherdoor ) )
        {
            visiblestate = canseeprompt && self.otherdoor.state == 0 || self.state == 8 && alarmprompt == self.dooralarmprompt;
        }
        
        if ( visiblestate )
        {
            alarmprompt showtoplayer( player );
            alarmprompt enableplayeruse( player );
            continue;
        }
        
        alarmprompt hidefromplayer( player );
        alarmprompt disableplayeruse( player );
    }
}

// Namespace door
// Params 0
// Checksum 0xc8586bf4, Offset: 0x6bd9
// Size: 0x150
function alarmmonitor()
{
    if ( self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self endon( #"statechanged" );
    
    if ( isdefined( self.otherdoor ) )
    {
        while ( self.otherdoor.state != 0 )
        {
            waitframe();
        }
    }
    
    foreach ( alarmprompt in self.alarmprompts )
    {
        alarmprompt sethintstring( &"mp/door_use_alarm" );
        alarmprompt setuseholdduration( "duration_medium" );
    }
    
    updatealarmpromptvisibility();
    
    foreach ( alarmprompt in self.alarmprompts )
    {
        thread _alarmmonitorinternal( alarmprompt );
    }
}

// Namespace door
// Params 1
// Checksum 0x1477b011, Offset: 0x6d31
// Size: 0x7e
function _alarmmonitorinternal( alarmprompt )
{
    self endon( #"statechanged" );
    
    while ( true )
    {
        alarmprompt waittill( #"trigger", player );
        
        if ( self.state != 0 )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        thread alarmdoor( player, alarmprompt );
    }
}

// Namespace door
// Params 2
// Checksum 0x2ee6b76b, Offset: 0x6db7
// Size: 0x16f
function alarmdoor( alarmowner, alarmprompt )
{
    playsoundatpos( alarmprompt.origin, "mp_door_alarm_on" );
    self.dooralarment = spawn( "script_model", alarmprompt.origin );
    self.dooralarment setmodel( "shardball_wm" );
    self.dooralarment.angles = self.angles;
    self.dooralarment linkto( self );
    self.dooralarment setentityowner( alarmowner );
    self.dooralarment setotherent( alarmowner );
    self.dooralarment setscriptablepartstate( "effects", "planted", 0 );
    self.dooralarmowner = alarmowner;
    self.dooralarmprompt = alarmprompt;
    self.dooralarmowner.alarmeddoors[ self.dooralarmowner.alarmeddoors.size ] = self;
    
    while ( self.dooralarmowner.alarmeddoors.size > 3 )
    {
        var_5632f60031090393 = self.dooralarmowner.alarmeddoors[ 0 ];
        var_5632f60031090393 removealarmdoor( 0 );
    }
    
    thread changestate( 8 );
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread changestate( 8 );
    }
}

// Namespace door
// Params 0
// Checksum 0x8c976fb7, Offset: 0x6f2e
// Size: 0x140
function removealarmmonitor()
{
    if ( !isdefined( self.dooralarmprompt ) || self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self endon( #"statechanged" );
    
    if ( isdefined( self.otherdoor ) )
    {
        while ( self.otherdoor.state != 8 )
        {
            waitframe();
        }
    }
    
    self.dooralarmprompt sethintstring( &"mp/door_use_remove_alarm" );
    self.dooralarmprompt setuseholdduration( "duration_medium" );
    self.dooralarmprompt.owner = self.dooralarmowner;
    self.dooralarmprompt.team = self.dooralarmowner.team;
    updatealarmpromptvisibility();
    
    while ( true )
    {
        self.dooralarmprompt waittill( #"trigger", player );
        
        if ( self.state != 8 )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        thread removealarmdoor( 1 );
    }
}

// Namespace door
// Params 0
// Checksum 0x4293fb8, Offset: 0x7076
// Size: 0x9d
function disownalarmmonitor()
{
    if ( !isdefined( self.dooralarmprompt ) || self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    self endon( #"statechanged" );
    
    if ( isdefined( self.otherdoor ) )
    {
        while ( self.otherdoor.state != 8 )
        {
            waitframe();
        }
    }
    
    while ( true )
    {
        self.dooralarmowner utility::waittill_any( "joined_team", "joined_spectators", "disconnect" );
        
        if ( self.state != 8 )
        {
            return;
        }
        
        thread removealarmdoor( 0 );
    }
}

// Namespace door
// Params 1
// Checksum 0x8d85dd65, Offset: 0x711b
// Size: 0xaf
function removealarmdoor( playsound )
{
    if ( playsound )
    {
        playsoundatpos( self.dooralarment.origin, "mp_door_alarm_off" );
    }
    
    if ( isdefined( self.dooralarmowner ) )
    {
        self.dooralarmowner.alarmeddoors = arrayremove( self.dooralarmowner.alarmeddoors, self );
    }
    
    self.dooralarment delete();
    self.dooralarmowner = undefined;
    self.dooralarmprompt = undefined;
    thread changestate( 0 );
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread changestate( 0 );
    }
}

// Namespace door
// Params 1
// Checksum 0x401e7eca, Offset: 0x71d2
// Size: 0x18c
function checktriggeralarm( victim )
{
    if ( self.state != 8 )
    {
        return;
    }
    
    alarmeddoor = self;
    
    if ( !isdefined( self.dooralarment ) && isdefined( self.otherdoor ) )
    {
        alarmeddoor = self.otherdoor;
    }
    
    if ( !isdefined( alarmeddoor.dooralarmowner ) )
    {
        return;
    }
    
    alarment = alarmeddoor.dooralarment;
    alarmowner = alarmeddoor.dooralarmowner;
    alarmeddoor.dooralarmowner.alarmeddoors = arrayremove( alarmeddoor.dooralarmowner.alarmeddoors, alarmeddoor );
    alarmeddoor.dooralarment = undefined;
    alarmeddoor.dooralarmowner = undefined;
    alarmeddoor.dooralarmprompt = undefined;
    alarmowner killstreaks::givescorefortriggeredalarmeddoor();
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread changestate( 0 );
    }
    
    if ( player_utility::playersareenemies( victim, alarmowner ) )
    {
        alarment playloopsound( "mp_door_alarm_lp" );
        pinglocationenemyteams( self.origin, victim.team );
        alarment setscriptablepartstate( "effects", "triggered", 0 );
        wait 4;
        alarment stoploopsound();
        alarment delete();
        return;
    }
    
    playsoundatpos( alarment.origin, "mp_door_alarm_off" );
    alarment setscriptablepartstate( "effects", "neutral", 0 );
    alarment delete();
}

// Namespace door
// Params 0
// Checksum 0x623b93ca, Offset: 0x7366
// Size: 0x76
function ajarmonitor()
{
    if ( self.islean || game_utility_mp::runleanthreadmode() )
    {
        return;
    }
    
    if ( !self.issaloonstyle )
    {
        return;
    }
    
    self endon( #"statechanged" );
    self notify( #"hash_419b73b700701b95" );
    self endon( #"hash_419b73b700701b95" );
    
    while ( true )
    {
        waitframe();
        waittillframeend();
        
        if ( self.otherdoor.state != 0 )
        {
            thread changestate( 6 );
        }
    }
}

// Namespace door
// Params 0
// Checksum 0xdd7ba58a, Offset: 0x73e4
// Size: 0x12b
function breachmonitor()
{
    self endon( #"statechanged" );
    thread monitorbreachmelee();
    self.lockprompt sethintstring( &"mp/door_use_breach" );
    self.lockprompt setuseholdduration( "duration_short" );
    updatelockpromptvisibility();
    
    if ( !isdefined( self.otherdoor ) )
    {
        self.doorcenter = self.origin + anglestoforward( self.angles ) * self.length * 0.5 + anglestoup( self.angles ) * self.height * 0.5;
    }
    
    thread updatelocklight( "lockedDoor" );
    
    while ( true )
    {
        self.lockprompt waittill( #"trigger", player );
        
        if ( player meleebuttonpressed() )
        {
            continue;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        if ( player issprinting() || player issprintsliding() )
        {
            continue;
        }
        
        if ( player ismantling() )
        {
            continue;
        }
        
        if ( self.breaching )
        {
            continue;
        }
        
        thread breachdoor( player );
    }
}

// Namespace door
// Params 1
// Checksum 0x6acdcc4d, Offset: 0x7517
// Size: 0x15
function breachdoor( player )
{
    thread plantbreach( player );
}

// Namespace door
// Params 0
// Checksum 0x475ae459, Offset: 0x7534
// Size: 0x2b5
function monitorbreachmelee()
{
    self endon( #"statechanged" );
    self notify( #"hash_d6a1c06b79a698a0" );
    self endon( #"hash_d6a1c06b79a698a0" );
    self.lockedmeleehealth = 150;
    self setcandamage( 1 );
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    meansofdeath = undefined;
    modelname = undefined;
    tagname = undefined;
    partname = undefined;
    idflags = undefined;
    objweapon = undefined;
    origin = undefined;
    angles = undefined;
    normal = undefined;
    inflictor = undefined;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( meansofdeath ) && !self.breaching )
        {
            if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" )
            {
                ismolotov = isdefined( objweapon ) && isdefined( objweapon.basename ) && ( objweapon.basename == "molotov_mp" || objweapon.basename == "thermite_mp" || objweapon.basename == "thermite_ap_mp" || objweapon.basename == "thermite_av_mp" );
                
                if ( ismolotov )
                {
                    continue;
                }
                
                self.lockedmeleehealth -= damage;
                
                if ( isdefined( self.otherdoor ) )
                {
                    self.otherdoor.lockedmeleehealth -= damage;
                }
                
                if ( self.lockedmeleehealth < 1 )
                {
                    if ( isdefined( self.otherdoor ) || self.issaloonstyle )
                    {
                        self.otherdoor thread updatelocklight( "off" );
                        self.otherdoor thread bashopen( attacker, attacker.origin );
                    }
                    
                    thread updatelocklight( "off" );
                    thread bashopen( attacker, attacker.origin );
                    continue;
                }
                
                playsoundatpos( self.origin + ( 0, 0, 42 ), "scrpt_door_wood_double_bash" );
            }
        }
    }
}

#using_animtree( "script_model" );

// Namespace door
// Params 1
// Checksum 0x7ce5289e, Offset: 0x77f1
// Size: 0x38c
function plantbreach( player )
{
    if ( isdefined( self.otherdoor ) && self.otherdoor.breaching )
    {
        return;
    }
    
    self.breaching = 1;
    thread updatelockpromptvisibility();
    thread watchplayerdeath( player );
    origin = self.origin;
    angles = self.angles;
    right = anglestoright( angles );
    normal = vectornormalize( player.origin - self.origin );
    dot = vectordot( right, normal );
    openleft = dot > 0;
    
    if ( openleft )
    {
        var_e20f0cf1c58669c0 = self.rightplantorg;
        var_3b5132f207c3fcce = self.rightplantang;
    }
    else
    {
        var_e20f0cf1c58669c0 = self.leftplantorg;
        var_3b5132f207c3fcce = self.leftplantang;
    }
    
    player.linktoent = player utility::spawn_tag_origin();
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0 );
    scenenode = utility::spawn_tag_origin( var_e20f0cf1c58669c0, var_3b5132f207c3fcce );
    player.linktoent moveto( var_e20f0cf1c58669c0, 0.25, 0.1, 0.1 );
    player.linktoent rotateto( var_3b5132f207c3fcce, 0.25, 0.1, 0.1 );
    player setstance( "stand" );
    
    if ( !player givegunless() )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
        self.breaching = 0;
        thread updatelockpromptvisibility();
        return 0;
    }
    
    if ( self.cancelplant )
    {
        self.breaching = 0;
        thread updatelockpromptvisibility();
        return 0;
    }
    
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( var_e20f0cf1c58669c0 );
    player setplayerangles( var_3b5132f207c3fcce );
    faction = player.team == "allies" ? "usp1" : "afp1";
    player queuedialogforplayer( #"queue1", "dx_mpp_" + faction + "_breach_plant", "cop_breach_plant", 2 );
    thread create_player_rig( player, "planter" );
    scenenode thread anim_mp::anim_player_solo( player, player.player_rig, "plant" );
    wm_c4 = spawn( "script_model", var_e20f0cf1c58669c0 );
    wm_c4 setmodel( "offhand_wm_c4" );
    wm_c4.animname = "c4";
    wm_c4 useanimtree( #animtree );
    self.plantedbomb = wm_c4;
    scenenode thread animation::anim_single_solo( wm_c4, "plant" );
    animlength = getanimlength( level.scr_anim[ "planter" ][ "plant" ] );
    armedtimeoffset = 0.5;
    wait animlength - armedtimeoffset;
    
    if ( self.cancelplant )
    {
        self.breaching = 0;
        thread updatelockpromptvisibility();
        return 0;
    }
    
    thread bomb_planted_think( player, openleft );
    givebreachscore( player );
    wait armedtimeoffset;
    
    if ( player isviewmodelanimplaying() )
    {
        player stopviewmodelanim();
    }
    
    player thread takegunless();
    remove_player_rig( player );
    return 1;
}

// Namespace door
// Params 2
// Checksum 0xadebff31, Offset: 0x7b86
// Size: 0x34b
function bomb_planted_think( player, openleft )
{
    plantedteam = player.team;
    self.defused = 0;
    
    if ( !isdefined( self.breachindex ) )
    {
        if ( !isdefined( level.breachindex ) )
        {
            level.breachindex = 0;
        }
        else
        {
            level.breachindex++;
        }
        
        self.breachindex = level.breachindex;
    }
    
    bomb_fuse_think( plantedteam );
    
    if ( !self.defused )
    {
        self.doorcenter = self.origin + anglestoforward( self.angles ) * self.length * 0.5 + anglestoup( self.angles ) * self.height * 0.5;
        explosionorigin = self.doorcenter;
        
        if ( openleft )
        {
            explosionang = self.rightplantang;
        }
        else
        {
            explosionang = self.leftplantang;
        }
        
        explosioneffect = spawnfx( level._effect[ "breach_explode" ], explosionorigin, anglestoforward( explosionang ) * -1, ( 0, 0, 1 ) );
        triggerfx( explosioneffect );
        physicsexplosionsphere( explosionorigin, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", explosionorigin );
        earthquake( 0.5, 1, explosionorigin, 1500 );
        player weapon::_launchgrenade( "flash_grenade_mp", self.plantedbomb.origin + anglestoforward( explosionang ) * 100, ( 0, 0, 0 ), 0.05, 1 );
        player weapon::_launchgrenade( "concussion_grenade_mp", self.plantedbomb.origin + anglestoforward( explosionang ) * 100, ( 0, 0, 0 ), 0.05, 1 );
        wait 0.1;
        
        if ( isdefined( player ) )
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 50, 10, 5, player, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        else
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 100, 50, 5, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        
        thread bashopen( player, self.plantedbomb.origin );
        
        if ( isdefined( self.otherdoor ) )
        {
            self.otherdoor thread bashopen( player, self.plantedbomb.origin );
        }
    }
    
    self.plantedbomb delete();
    self.plantedbomb = undefined;
    setomnvar( "ui_ingame_timer_" + self.breachindex, 0 );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, undefined );
    self.breaching = 0;
    thread updatelockpromptvisibility();
    thread updatelocklight( "off" );
    
    if ( isdefined( self.otherdoor ) )
    {
        self.otherdoor thread updatelocklight( "off" );
    }
}

// Namespace door
// Params 1
// Checksum 0x678534d9, Offset: 0x7ed9
// Size: 0x191
function bomb_fuse_think( team )
{
    self notify( #"breach_planted" );
    self.timerobject = spawn( "script_model", self.plantedbomb.origin );
    currenttime = gettime();
    bombendtime = int( currenttime + 1000 );
    setomnvar( "ui_ingame_timer_" + self.breachindex, bombendtime );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, self.timerobject );
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( !self.defused && var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 < 1500 )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                self.plantedbomb playsound( "breach_warning_beep_05" );
            }
            else if ( var_f4f3f0356fef8102 < 500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_04" );
            }
            else if ( var_f4f3f0356fef8102 < 1500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_03" );
            }
            else
            {
                self.plantedbomb playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
        }
        else if ( var_f4f3f0356fef8102 < 3500 )
        {
            self.plantedbomb playsound( "breach_warning_beep_02" );
            wait 0.5;
        }
        else
        {
            self.plantedbomb playsound( "breach_warning_beep_01" );
            wait 1;
        }
        
        if ( var_f4f3f0356fef8102 < 0 )
        {
            break;
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x785d959a, Offset: 0x8072
// Size: 0x7c
function watchplayerdeath( player )
{
    self endon( #"breach_planted" );
    self.cancelplant = 0;
    
    while ( true )
    {
        if ( !isdefined( player ) || !player::isreallyalive( player ) )
        {
            if ( isdefined( self.plantedbomb ) )
            {
                self.plantedbomb delete();
                self.plantedbomb = undefined;
                self.plantedkey = undefined;
            }
            
            self.cancelplant = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace door
// Params 0
// Checksum 0xb31daefb, Offset: 0x80f6
// Size: 0x2
function script_model_anims()
{
    
}

// Namespace door
// Params 3
// Checksum 0xa28c7e6e, Offset: 0x8100
// Size: 0xed
function create_player_rig( player, animname, rig_model )
{
    if ( !isdefined( player ) || isdefined( player.player_rig ) )
    {
        return;
    }
    
    player.animname = animname;
    
    if ( !isdefined( rig_model ) )
    {
        rig_model = "viewhands_base_iw8";
    }
    
    player.player_rig = spawn( "script_model", player.origin );
    player.player_rig setmodel( rig_model );
    player.player_rig hide();
    player.player_rig.animname = animname;
    player.player_rig useanimtree( #animtree );
    player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0 );
    player watch_remove_rig();
    remove_player_rig( player );
}

// Namespace door
// Params 1
// Checksum 0x44d1a69f, Offset: 0x81f5
// Size: 0x93
function remove_player_rig( player )
{
    if ( !( isdefined( player ) && isdefined( player.player_rig ) ) )
    {
        return;
    }
    
    player unlink();
    droppos = player getdroptofloorposition( player.origin );
    
    if ( isdefined( droppos ) )
    {
        player setorigin( droppos );
    }
    else
    {
        player setorigin( player.origin + ( 0, 0, 100 ) );
    }
    
    player.player_rig delete();
    player.player_rig = undefined;
}

// Namespace door
// Params 1
// Checksum 0xdb170230, Offset: 0x8290
// Size: 0x1d
function watch_remove_rig( struct )
{
    utility::waittill_any( "remove_rig", "death_or_disconnect" );
}

// Namespace door
// Params 1
// Checksum 0xbeb2983a, Offset: 0x82b5
// Size: 0x48
function givebreachscore( player )
{
    event = #"breach";
    points = rank::getscoreinfovalue( event );
    player thread rank::giverankxp( event, points );
    player thread rank::scoreeventpopup( event );
}

// Namespace door
// Params 0
// Checksum 0x16b698d4, Offset: 0x8305
// Size: 0x9e
function givegunless()
{
    self endon( #"death_or_disconnect" );
    gunless = makeweapon( "iw8_gunless" );
    inventory_utility::_giveweapon( gunless, undefined, undefined, 1 );
    success = inventory_utility::domonitoredweaponswitch( gunless, 0 );
    
    if ( success )
    {
        self.gunnlessweapon = gunless;
        val::set( "gunless", "weapon_switch", 0 );
        val::set( "gunless", "offhand_weapons", 0 );
        val::set( "gunless", "melee", 0 );
    }
    else
    {
        inventory_utility::_takeweapon( gunless );
        inventory_utility::forcevalidweapon();
    }
    
    return success;
}

// Namespace door
// Params 0
// Checksum 0x77714ec5, Offset: 0x83ac
// Size: 0xad
function takegunless()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    self.takinggunless = 1;
    
    while ( self hasweapon( self.gunnlessweapon ) )
    {
        if ( !inventory_utility::iscurrentweapon( self.gunnlessweapon ) )
        {
            inventory_utility::abortmonitoredweaponswitch( self.gunnlessweapon );
        }
        else
        {
            inventory_utility::_takeweapon( self.gunnlessweapon );
            inventory_utility::forcevalidweapon();
        }
        
        waitframe();
    }
    
    self.takinggunless = 0;
    self.gunnlessweapon = undefined;
    val::reset_all( "gunless" );
}

// Namespace door
// Params 1
// Checksum 0xcdafad38, Offset: 0x8461
// Size: 0x63
function updatelocklight( state )
{
    if ( !isdefined( self.locklight ) )
    {
        return;
    }
    
    self notify( #"hash_21b03eb42a2e5045" );
    self endon( #"hash_21b03eb42a2e5045" );
    
    if ( !flags::levelflag( "scriptables_ready" ) )
    {
        flags::levelflagwait( "scriptables_ready" );
    }
    
    self.locklight setscriptablepartstate( "marker", state );
}

// Namespace door
// Params 0
// Checksum 0x9a1b7a9d, Offset: 0x84cc
// Size: 0x3b6
function linkdoubledoors()
{
    foreach ( door in level.doors )
    {
        if ( isdefined( door.otherdoor ) )
        {
            continue;
        }
        
        foreach ( otherdoor in level.doors )
        {
            if ( otherdoor == door )
            {
                continue;
            }
            
            doorpos1 = door gettagorigin( "tag_door_handle", 1 );
            doorpos2 = otherdoor gettagorigin( "tag_door_handle", 1 );
            
            if ( !( isdefined( doorpos1 ) && isdefined( doorpos2 ) ) )
            {
                continue;
            }
            
            distsq = distancesquared( doorpos1, doorpos2 );
            
            if ( distsq < 225 )
            {
                if ( distsq < 100 )
                {
                    door.issaloonstyle = 1;
                    otherdoor.issaloonstyle = 1;
                }
                
                otherdoor.otherdoor = door;
                door.otherdoor = otherdoor;
                
                if ( isdefined( door.lockprompt ) && isdefined( otherdoor.lockprompt ) )
                {
                    otherdoor.lockprompt delete();
                    otherdoor.lockprompt = door.lockprompt;
                    avgpos = ( doorpos1 + doorpos2 ) * 0.5 + ( 0, 0, 15 );
                    door.lockprompt unlink();
                    door.lockprompt.origin = avgpos;
                    door thread changestate( door.state );
                    otherdoor thread changestate( otherdoor.state );
                    door.leftplantorg = ( avgpos[ 0 ], avgpos[ 1 ], door.origin[ 2 ] ) + anglestoright( door.baseangles ) * -24.5;
                    door.leftplantang = ( 0, door.baseangles[ 1 ] - 90, 0 );
                    door.rightplantorg = ( avgpos[ 0 ], avgpos[ 1 ], door.origin[ 2 ] ) + anglestoright( door.baseangles ) * 24.5;
                    door.rightplantang = ( 0, door.baseangles[ 1 ] + 90, 0 );
                    otherdoor.leftplantorg = ( avgpos[ 0 ], avgpos[ 1 ], otherdoor.origin[ 2 ] ) + anglestoright( otherdoor.baseangles ) * -24.5;
                    otherdoor.leftplantang = ( 0, otherdoor.baseangles[ 1 ] - 90, 0 );
                    otherdoor.rightplantorg = ( avgpos[ 0 ], avgpos[ 1 ], otherdoor.origin[ 2 ] ) + anglestoright( otherdoor.baseangles ) * 24.5;
                    otherdoor.rightplantang = ( 0, otherdoor.baseangles[ 1 ] + 90, 0 );
                }
            }
        }
    }
}

// Namespace door
// Params 0
// Checksum 0x1d2d1b5f, Offset: 0x888a
// Size: 0x35
function door_createnavobstacle()
{
    if ( !isdefined( self.clipent ) )
    {
        return;
    }
    
    if ( isdefined( self.doornavobstacle ) )
    {
        return;
    }
    
    self.doornavobstacle = createnavobstaclebyent( self.clipent );
}

// Namespace door
// Params 0
// Checksum 0xf662630c, Offset: 0x88c7
// Size: 0x29
function door_destroynavobstacle()
{
    if ( !isdefined( self.doornavobstacle ) )
    {
        return;
    }
    
    destroynavobstacle( self.doornavobstacle );
    self.doornavobstacle = undefined;
}

// Namespace door
// Params 0
// Checksum 0x9f883b7e, Offset: 0x88f8
// Size: 0x1f
function door_enableaudioportal()
{
    if ( isdefined( self.audioportalent ) )
    {
        self.audioportalent enableaudioportal( 1 );
    }
}

// Namespace door
// Params 0
// Checksum 0xa1400181, Offset: 0x891f
// Size: 0x79
function door_disableaudioportal()
{
    if ( isdefined( self.otherdoor ) && self.otherdoor.state != 0 && self.otherdoor.state != 7 && self.otherdoor.state != 8 )
    {
        return;
    }
    
    if ( isdefined( self.audioportalent ) )
    {
        self.audioportalent enableaudioportal( 0 );
    }
}

// Namespace door
// Params 0
// Checksum 0x3469c194, Offset: 0x89a0
// Size: 0x1d, Type: bool
function door_can_open_check()
{
    return self.state == 6 || self.state == 0;
}

// Namespace door
// Params 0
// Checksum 0x9c1a659e, Offset: 0x89c6
// Size: 0x158
function init_sliding_doors()
{
    scriptable::scriptable_addusedcallbackbypart( "double_door", &function_391015b9a305774e );
    scriptable::scriptable_addusedcallbackbypart( "sliding_double_door_button", &function_91005e4ed98ea8cd );
    level.slidingdoors = [];
    level.var_f3618d8d14b87c3d = getdvarint( @"hash_16d0155a4a9a119c", 1 );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    foreach ( door_trigger in getnoentvolumearray( "door_trigger", #targetname ) )
    {
        door_trigger.doors = getentitylessscriptablearray( door_trigger.target, #targetname );
        
        if ( door_trigger.doors.size == 0 )
        {
            continue;
        }
        
        trigger::makeenterexittrigger( door_trigger, &function_f25e202a42c7e3a4 );
        door_trigger.isslidingdoor = 1;
        door_trigger emp_debuff::set_apply_emp_callback( &sliding_door_empapplied );
        door_trigger emp_debuff::set_clear_emp_callback( &sliding_door_empcleared );
        level.slidingdoors[ level.slidingdoors.size ] = door_trigger;
    }
}

// Namespace door
// Params 6, eflags: 0x4
// Checksum 0x9c45aa54, Offset: 0x8b26
// Size: 0x1f7
function private function_91005e4ed98ea8cd( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.doors ) )
    {
        instance.doors = getentitylessscriptablearray( instance.target, #targetname );
    }
    
    assert( instance.doors.size, "<dev string:x1cd>" );
    nextstate = state == "closed" ? "opening" : "closing";
    
    foreach ( door in instance.doors )
    {
        door setscriptablepartstate( door function_84ad2f70189ee7c3(), nextstate );
    }
    
    instance setscriptablepartstate( part, nextstate );
    
    if ( state == "closed" )
    {
        instance endon( #"closing" );
        wait float( instance.script_noteworthy ?? "60" );
        
        foreach ( door in instance.doors )
        {
            door setscriptablepartstate( door function_84ad2f70189ee7c3(), "closing" );
        }
        
        instance setscriptablepartstate( part, "closing" );
        return;
    }
    
    instance notify( #"closing" );
}

// Namespace door
// Params 6, eflags: 0x4
// Checksum 0xbb3c7a51, Offset: 0x8d25
// Size: 0x22b
function private function_391015b9a305774e( instance, part, state, player, bautouse, usestring )
{
    if ( state == "closed" )
    {
        instance setscriptablepartstate( part, "opening" );
    }
    else if ( state == "open" )
    {
        instance setscriptablepartstate( part, "closing" );
    }
    
    if ( !isdefined( instance.linked ) )
    {
        if ( isdefined( instance.target ) )
        {
            instance.linked = getentitylessscriptablearray( instance.target, #targetname );
        }
        else if ( isdefined( instance.targetname ) )
        {
            instance.linked = getentitylessscriptablearray( instance.targetname, #target );
        }
        else
        {
            instance.linked = [];
        }
    }
    
    foreach ( linked_door in instance.linked )
    {
        current_state = linked_door getscriptablepartstate( "double_door" );
        
        if ( current_state != "unusable" )
        {
            linked_door.prevstate = current_state;
        }
        
        linked_door setscriptablepartstate( "double_door", "unusable" );
    }
    
    wait 0.4;
    
    foreach ( linked_door in instance.linked )
    {
        linked_door setscriptablepartstate( "double_door", linked_door.prevstate );
    }
}

// Namespace door
// Params 2, eflags: 0x4
// Checksum 0x39c257c, Offset: 0x8f58
// Size: 0x419
function private function_f25e202a42c7e3a4( ent, trigger )
{
    if ( isplayer( ent ) && ent getstance() != "stand" )
    {
        foreach ( door in trigger.doors )
        {
            door enablescriptableplayeruse( ent );
        }
        
        if ( trigger.open )
        {
            return;
        }
        
        trigger.open = 1;
        
        while ( true )
        {
            waitframe();
            
            if ( trigger.triggerenterents.size == 0 )
            {
                trigger.open = 0;
                return;
            }
            
            var_59544853c0e29549 = 0;
            
            foreach ( door in trigger.doors )
            {
                if ( door getscriptablepartstate( "automatic_door" ) == "opening" )
                {
                    var_59544853c0e29549 = 1;
                    break;
                }
            }
            
            foreach ( ent in trigger.triggerenterents )
            {
                if ( isplayer( ent ) && ent getstance() == "stand" )
                {
                    var_59544853c0e29549 = 1;
                    break;
                }
            }
            
            if ( var_59544853c0e29549 )
            {
                break;
            }
        }
    }
    else
    {
        if ( isplayer( ent ) )
        {
            foreach ( door in trigger.doors )
            {
                door disablescriptableplayeruse( ent );
            }
        }
        
        if ( trigger.open )
        {
            return;
        }
        
        trigger.open = 1;
    }
    
    foreach ( door in trigger.doors )
    {
        door setscriptablepartstate( "automatic_door", "opening" );
    }
    
    if ( getdvarint( @"hash_888a2d50ffcbd694", 1 ) == 0 )
    {
        return;
    }
    
    wait getdvarfloat( @"hash_9e425e26ee667e70", level.var_f7d0ffb4cc8e1506 ?? 30 );
    
    while ( trigger.triggerenterents.size > 0 || trigger.isempd )
    {
        waitframe();
    }
    
    foreach ( door in trigger.doors )
    {
        door setscriptablepartstate( "automatic_door", "closing" );
    }
    
    wait 0.4;
    trigger.open = 0;
    
    if ( trigger.triggerenterents.size > 0 )
    {
        function_f25e202a42c7e3a4( ent, trigger );
    }
}

// Namespace door
// Params 1
// Checksum 0x4d78483c, Offset: 0x9379
// Size: 0xc9
function sliding_door_empapplied( data )
{
    if ( data.var_4540f9188cfebe7e )
    {
        trigger = self;
        trigger.isempd = 1;
        
        foreach ( door in trigger.doors )
        {
            door setscriptablepartstate( "automatic_door", "opening", 0 );
            door setscriptablepartstate( "empd", "active", 0 );
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x599aae27, Offset: 0x944a
// Size: 0xd9
function sliding_door_empcleared( data )
{
    trigger = self;
    
    if ( trigger.isempd )
    {
        trigger.isempd = 0;
        
        if ( trigger.triggerenterents.size <= 0 )
        {
            foreach ( door in trigger.doors )
            {
                door setscriptablepartstate( "automatic_door", "closing", 0 );
                door setscriptablepartstate( "empd", "neutral", 0 );
            }
        }
    }
}

// Namespace door
// Params 0
// Checksum 0x6fc473e6, Offset: 0x952b
// Size: 0x506
function garage_door_init()
{
    scriptable::scriptable_addnotifycallback( "garage_door_crush", &function_44fbf9478385aead );
    
    foreach ( part in [ "right_button", "left_button", "right_button_2", "left_button_2" ] )
    {
        scriptable::scriptable_addusedcallbackbypart( part, &onusedbutton );
    }
    
    level.scriptable_garage_doors = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "garage_door_collision" );
    level.var_19f47b06ad6b40a4 = getdvarint( @"hash_c38ae783f00d166f", 1 );
    
    foreach ( door in level.scriptable_garage_doors )
    {
        door.var_78ff42993c4d2fdf = 1;
        door emp_debuff::set_apply_emp_callback( &garage_door_empapplied );
        door.volume = getnoentvolumearray( door.target, #targetname )[ 0 ];
        
        if ( door.volume )
        {
            door.volume function_ce168ef171df1112( 1 );
            door.volume callback::add( #"noent_volume_trigger_enter", &function_b7c94b58aa02c801 );
            door.volume callback::add( #"noent_volume_trigger_exit", &function_4f0321e52ab64ac1 );
        }
    }
    
    level.garage_doors = [];
    main_nodes = utility::getstructarray( "main_node", "script_noteworthy" );
    
    /#
        level thread function_6bc072e89474b1f2();
    #/
    
    if ( main_nodes.size == 0 )
    {
        return;
    }
    
    foreach ( node in main_nodes )
    {
        pan01 = getent( node.target, #targetname );
        pan02 = getent( pan01.target, #targetname );
        pan03 = getent( pan02.target, #targetname );
        pan04 = getent( pan03.target, #targetname );
        edgebrush = undefined;
        
        if ( isdefined( pan04.target ) )
        {
            edgebrush = getent( pan04.target, #targetname );
            edgebrush linkto( pan01 );
            edgebrush.unresolved_collision_func = &movers::unresolved_collision_void;
        }
        
        pan01.unresolved_collision_func = &movers::unresolved_collision_void;
        
        if ( node.targetname == "final_rotation" )
        {
            pan01.start_angles = pan01.angles;
            pan01.var_3713fe4fbd12ef53 = node.angles;
            pan02.start_angles = pan02.angles;
            pan02.var_3713fe4fbd12ef53 = node.angles;
            pan03.start_angles = pan03.angles;
            pan03.var_3713fe4fbd12ef53 = node.angles;
            pan04.start_angles = pan04.angles;
            pan04.var_3713fe4fbd12ef53 = node.angles;
        }
        
        node.pan01 = pan01;
        node.pan02 = pan02;
        node.pan03 = pan03;
        node.pan04 = pan04;
        node.buttons = node utility::get_linked_ents();
        node.edgebrush = edgebrush;
        pan01.navobstacleid = pan01 function_47d49bbcb01a83e5();
        pan02.navobstacleid = pan02 function_47d49bbcb01a83e5();
        pan03.navobstacleid = pan03 function_47d49bbcb01a83e5();
        pan04.navobstacleid = pan04 function_47d49bbcb01a83e5();
        node thread garage_door_think();
        level.garage_doors[ level.garage_doors.size ] = node;
    }
}

// Namespace door
// Params 6, eflags: 0x4
// Checksum 0xb8965c5b, Offset: 0x9a39
// Size: 0x8a
function private onusedbutton( instance, part, state, useplayer, bautouse, usestring )
{
    if ( !instance.var_78ff42993c4d2fdf )
    {
        return;
    }
    
    instance.lastuser = useplayer;
    
    if ( state == "open" )
    {
        instance setscriptablepartstate( part, "closing" );
        return;
    }
    
    if ( state == "closed" )
    {
        instance setscriptablepartstate( part, "opening" );
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0xe6769338, Offset: 0x9acb
// Size: 0x54
function private function_b7c94b58aa02c801( params )
{
    if ( isplayer( params.entity ) )
    {
        if ( !isdefined( self.inside ) )
        {
            self.inside = [];
        }
        
        self.inside[ self.inside.size ] = params.entity;
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x34a85b92, Offset: 0x9b27
// Size: 0x3f
function private function_4f0321e52ab64ac1( params )
{
    if ( isplayer( params.entity ) )
    {
        self.inside = arrayremove( self.inside, params.entity );
    }
}

// Namespace door
// Params 4, eflags: 0x4
// Checksum 0xacdc900, Offset: 0x9b6e
// Size: 0x824
function private function_44fbf9478385aead( instance, note, param, var_64ffacba090c91be )
{
    if ( !instance.volume )
    {
        return;
    }
    
    if ( !instance.segmentstart )
    {
        middle = instance.origin;
        yaw = instance.angles[ 1 ];
        
        if ( yaw < 1 || yaw > 179 && yaw < 181 || yaw > 359 )
        {
            doorlength = instance.volume getboundshalfsize()[ 0 ];
        }
        else
        {
            doorlength = instance.volume getboundshalfsize()[ 1 ] / abs( sin( yaw ) );
        }
        
        instance.segmentstart = middle + rotatevector( ( doorlength, 0, 0 ), instance.angles );
        instance.segmentend = middle - rotatevector( ( doorlength, 0, 0 ), instance.angles );
        
        /#
            if ( getdvarint( @"hash_cdf4eb59e59033a", 0 ) == 1 )
            {
                line( instance.segmentstart, instance.segmentend, ( 1, 0, 0 ), 1, 0, 2000 );
                print3d( instance.origin + ( 0, 0, 0.5 * instance.volume getboundshalfsize()[ 2 ] ), "<dev string:x208>" + doorlength, ( 1, 0, 0 ), 1, 0.3, 2000, 1 );
            }
        #/
    }
    
    var_b402d230c5a059ff = arraycopy( instance.volume.inside ?? [] );
    
    foreach ( vehicle in vehicle_getarrayinradius( instance.origin, 600 ) )
    {
        if ( !vehicle istouching( instance.volume ) )
        {
            continue;
        }
        
        if ( vehicle vehicle_occupancy::function_63c6c86801e0685c() )
        {
            leveldataforvehicle = vehicle_occupancy::get_data( vehicle vehicle::get_ref() );
            var_222683c6c7441756 = 0;
            
            foreach ( corner in [ vehicle.origin + rotatevector( ( leveldataforvehicle.exitextents[ "front" ], leveldataforvehicle.exitextents[ "right" ], 0 ), vehicle.angles ), vehicle.origin + rotatevector( ( leveldataforvehicle.exitextents[ "back" ] * -1, leveldataforvehicle.exitextents[ "right" ], 0 ), vehicle.angles ), vehicle.origin + rotatevector( ( leveldataforvehicle.exitextents[ "front" ], leveldataforvehicle.exitextents[ "left" ] * -1, 0 ), vehicle.angles ), vehicle.origin + rotatevector( ( leveldataforvehicle.exitextents[ "back" ] * -1, leveldataforvehicle.exitextents[ "left" ] * -1, 0 ), vehicle.angles ) ] )
            {
                var_e81588ff446d4998 = math::function_2e0e9b10b9c74d9e( corner, instance.segmentstart, instance.segmentend );
                var_e81588ff446d4998 = ( var_e81588ff446d4998[ 0 ], var_e81588ff446d4998[ 1 ], vehicle.origin[ 2 ] + leveldataforvehicle.exitextents[ "top" ] / 2 );
                
                /#
                    if ( getdvarint( @"hash_cdf4eb59e59033a", 0 ) == 1 )
                    {
                        sphere( var_e81588ff446d4998, 3, ( 1, 0, 0 ), 0, 2000 );
                    }
                #/
                
                if ( vehicle vehicle_occupancy::function_6b3a6137e14e34e2( var_e81588ff446d4998 ) )
                {
                    var_222683c6c7441756 = 1;
                    break;
                }
            }
            
            if ( !var_222683c6c7441756 )
            {
                continue;
            }
        }
        
        var_b402d230c5a059ff = arraycombineunique( var_b402d230c5a059ff, [ vehicle ] );
    }
    
    if ( !var_b402d230c5a059ff.size )
    {
        return;
    }
    
    foreach ( entity in var_b402d230c5a059ff )
    {
        entitysize = entity getboundshalfsize();
        entityclearance = entity getboundsmidpoint()[ 2 ] + entity.origin[ 2 ] + entitysize[ 2 ] - instance.origin[ 2 ];
        
        if ( entityclearance < param )
        {
            continue;
        }
        
        attacker = !instance.lastuser || player_utility::isfriendly( entity.team, instance.lastuser ) ? entity : instance.lastuser;
        
        if ( entity vehicle::is_vehicle() )
        {
            data = { #objweapon:entity.objweapon, #attacker:instance.lastuser, #meansofdeath:"MOD_CRUSH", #inflictor:instance };
            entity.dontspawnhusk = 1;
            entity vehicle::explode( data );
            continue;
        }
        
        if ( isplayer( entity ) )
        {
            var_e81588ff446d4998 = math::function_2e0e9b10b9c74d9e( entity.origin, instance.segmentstart, instance.segmentend );
            todoor = var_e81588ff446d4998 - entity.origin;
            var_3ca81fbcfdbe2214 = vectornormalize( ( todoor[ 0 ], todoor[ 1 ], 0 ) );
            var_d9b079ccd1f1f732 = entitysize[ 0 ] + 5;
            var_d4817f14a3a155a0 = var_e81588ff446d4998 + var_3ca81fbcfdbe2214 * var_d9b079ccd1f1f732 * -1;
            throughdoor = var_e81588ff446d4998 + var_3ca81fbcfdbe2214 * var_d9b079ccd1f1f732;
            var_d4817f14a3a155a0 = ( var_d4817f14a3a155a0[ 0 ], var_d4817f14a3a155a0[ 1 ], entity.origin[ 2 ] );
            throughdoor = ( throughdoor[ 0 ], throughdoor[ 1 ], entity.origin[ 2 ] );
            
            /#
                if ( getdvarint( @"hash_cdf4eb59e59033a", 0 ) == 1 )
                {
                    sphere( var_d4817f14a3a155a0, entitysize[ 0 ], ( 0, 0, 1 ), 0, 2000 );
                    sphere( throughdoor, entitysize[ 0 ], ( 1, 0, 0 ), 0, 2000 );
                }
            #/
            
            contents = physics_createcontents( [ "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy" ] );
            
            if ( !physics_charactercast( var_d4817f14a3a155a0, var_d4817f14a3a155a0, entity, 0, entity.angles, contents, [ entity ], "physicsquery_any" ) )
            {
                entity setorigin( var_d4817f14a3a155a0, 0 );
                continue;
            }
            
            if ( !physics_charactercast( throughdoor, throughdoor, entity, 0, entity.angles, contents, [ entity ], "physicsquery_any" ) )
            {
                entity setorigin( throughdoor, 0 );
                continue;
            }
            
            entity dodamage( entity.health + 1000, entity.origin, attacker, instance, "MOD_CRUSH" );
        }
    }
}

// Namespace door
// Params 0
// Checksum 0xe62d5778, Offset: 0xa39a
// Size: 0x26
function function_2ecb96e7205c7578()
{
    door = self;
    doorstate = door getscriptablepartstate( "door" );
    return doorstate;
}

// Namespace door
// Params 0
// Checksum 0x25d53880, Offset: 0xa3c9
// Size: 0x61
function function_10e930269e452b6()
{
    door = self;
    doorstate = door getscriptablepartstate( "door" );
    
    if ( doorstate == "closed" )
    {
        door setscriptablepartstate( "door", "opening", 0 );
        return;
    }
    
    if ( doorstate == "open" )
    {
        door setscriptablepartstate( "door", "closing", 0 );
    }
}

// Namespace door
// Params 1
// Checksum 0x636884bb, Offset: 0xa432
// Size: 0x79
function garage_door_empapplied( data )
{
    if ( data.var_4540f9188cfebe7e )
    {
        door = self;
        doorstate = door getscriptablepartstate( "door" );
        
        if ( doorstate == "closed" )
        {
            door setscriptablepartstate( "door", "opening", 0 );
            return;
        }
        
        if ( doorstate == "open" )
        {
            door setscriptablepartstate( "door", "closing", 0 );
        }
    }
}

// Namespace door
// Params 0, eflags: 0x4
// Checksum 0x22968a7a, Offset: 0xa4b3
// Size: 0x1ab
function private garage_door_think()
{
    node = self;
    pan01 = node.pan01;
    pan02 = node.pan02;
    pan03 = node.pan03;
    pan04 = node.pan04;
    buttons = node.buttons;
    edgebrush = node.edgebrush;
    
    if ( node.script_parameters == "open" || node.script_parameters == "respawn_open" && !game_utility_mp::islifelimited() )
    {
        node function_1d546d77527ba20b( pan01, pan02, pan03, pan04, 0.05 );
        enable_buttons( buttons );
        function_8c7d9853e46ed08f( buttons );
        disable_buttons( buttons );
        pan01 garage_door_play_sound( buttons );
        node function_8d0c99f3b2a41069( pan01, pan02, pan03, pan04 );
        pan01 garage_door_stop_sound();
        function_e5d74f5d7cf29d04( edgebrush );
    }
    
    while ( true )
    {
        enable_buttons( buttons );
        function_8c7d9853e46ed08f( buttons );
        disable_buttons( buttons );
        pan01 garage_door_play_sound( buttons );
        node function_1d546d77527ba20b( pan01, pan02, pan03, pan04 );
        pan01 garage_door_stop_sound();
        function_e5d74f5d7cf29d04( edgebrush );
        enable_buttons( buttons );
        function_8c7d9853e46ed08f( buttons );
        disable_buttons( buttons );
        pan01 garage_door_play_sound( buttons );
        node function_8d0c99f3b2a41069( pan01, pan02, pan03, pan04 );
        pan01 garage_door_stop_sound();
        function_3d7bb51457e1fdb7( edgebrush );
    }
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0xd30e11f7, Offset: 0xa666
// Size: 0x11d
function private garage_door_open( pan01, pan02, pan03, pan04, timer )
{
    pan01 panel_move_up( timer );
    pan02 panel_move_up( timer );
    pan03 panel_move_up( timer );
    pan04 function_852e262039308c26( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan04 hide();
    pan04 notsolid();
    pan01 panel_move_up( timer );
    pan02 panel_move_up( timer );
    pan03 function_852e262039308c26( timer );
    pan04 panel_move_up( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan03 hide();
    pan04 notsolid();
    pan01 panel_move_up( timer );
    pan02 function_852e262039308c26( timer );
    pan03 panel_move_up( timer );
    pan04 panel_move_up( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan02 hide();
    pan04 notsolid();
    pan01 function_2de470b96c0195fd();
    pan02 function_2de470b96c0195fd();
    pan03 function_2de470b96c0195fd();
    pan04 function_2de470b96c0195fd();
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0x5a0045b5, Offset: 0xa78b
// Size: 0xe8
function private function_cddc75c4d52b2df4( pan01, pan02, pan03, pan04, timer )
{
    pan04 hide();
    pan04 notsolid();
    pan01 panel_move_up( timer );
    pan02 panel_move_up( timer );
    pan03 function_852e262039308c26( timer );
    pan04 panel_move_up( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan03 hide();
    pan03 notsolid();
    pan01 panel_move_up( timer );
    pan02 function_852e262039308c26( timer );
    pan03 panel_move_up( timer );
    pan04 panel_move_up( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan02 hide();
    pan02 notsolid();
    pan01 function_2de470b96c0195fd();
    pan02 function_2de470b96c0195fd();
    pan03 function_2de470b96c0195fd();
    pan04 function_2de470b96c0195fd();
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0x34f8153d, Offset: 0xa87b
// Size: 0x149
function private garage_door_close( pan01, pan02, pan03, pan04, timer )
{
    pan02 show();
    pan02 solid();
    pan01 panel_move_down( timer );
    pan02 function_2524d44b21b7c70f( timer );
    pan03 panel_move_down( timer );
    pan04 panel_move_down( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan03 show();
    pan03 solid();
    pan01 panel_move_down( timer );
    pan02 panel_move_down( timer );
    pan03 function_2524d44b21b7c70f( timer );
    pan04 panel_move_down( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan04 show();
    pan04 solid();
    pan01 panel_move_down( timer );
    pan02 panel_move_down( timer );
    pan03 panel_move_down( timer );
    pan04 function_2524d44b21b7c70f( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan01.navobstacleid = pan01 function_47d49bbcb01a83e5();
    pan02.navobstacleid = pan02 function_47d49bbcb01a83e5();
    pan03.navobstacleid = pan03 function_47d49bbcb01a83e5();
    pan04.navobstacleid = pan04 function_47d49bbcb01a83e5();
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0x4fec6f40, Offset: 0xa9cc
// Size: 0x114
function private function_5f1a9e245beadc88( pan01, pan02, pan03, pan04, timer )
{
    pan02 show();
    pan02 solid();
    pan01 panel_move_down( timer );
    pan02 function_2524d44b21b7c70f( timer );
    pan03 panel_move_down( timer );
    pan04 panel_move_down( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan03 show();
    pan03 solid();
    pan01 panel_move_down( timer );
    pan02 panel_move_down( timer );
    pan03 function_2524d44b21b7c70f( timer );
    pan04 panel_move_down( timer );
    function_82785cd536b1e84c( pan01, pan02, pan03, pan04 );
    pan04 show();
    pan04 solid();
    pan01.navobstacleid = pan01 function_47d49bbcb01a83e5();
    pan02.navobstacleid = pan02 function_47d49bbcb01a83e5();
    pan03.navobstacleid = pan03 function_47d49bbcb01a83e5();
    pan04.navobstacleid = pan04 function_47d49bbcb01a83e5();
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0x2eb94da6, Offset: 0xaae8
// Size: 0x6f
function private function_1d546d77527ba20b( pan01, pan02, pan03, pan04, timer )
{
    self.var_ef1266e4608697d0 = "open";
    
    if ( self.script_label == "semi" )
    {
        function_cddc75c4d52b2df4( pan01, pan02, pan03, pan04, timer );
        return;
    }
    
    garage_door_open( pan01, pan02, pan03, pan04, timer );
}

// Namespace door
// Params 5, eflags: 0x4
// Checksum 0xf8321c11, Offset: 0xab5f
// Size: 0x6f
function private function_8d0c99f3b2a41069( pan01, pan02, pan03, pan04, timer )
{
    self.var_ef1266e4608697d0 = "closed";
    
    if ( self.script_label == "semi" )
    {
        function_5f1a9e245beadc88( pan01, pan02, pan03, pan04, timer );
        return;
    }
    
    garage_door_close( pan01, pan02, pan03, pan04, timer );
}

// Namespace door
// Params 0, eflags: 0x4
// Checksum 0x3d683dc3, Offset: 0xabd6
// Size: 0x85
function private function_833c1d5298bd096a()
{
    panel = self;
    delta = undefined;
    
    if ( panel.model == "gate_garage_door_48_scripted_01" )
    {
        delta = 48;
    }
    else if ( panel.model == "gate_garage_door_32_scripted_01" )
    {
        delta = 32;
    }
    else if ( panel.script_noteworthy == "brush_48" )
    {
        delta = 48;
    }
    else if ( panel.script_noteworthy == "brush_32" )
    {
        delta = 32;
    }
    
    return delta;
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x24d81dc8, Offset: 0xac64
// Size: 0x7c
function private panel_move_up( timer = 0.5 )
{
    dist = function_833c1d5298bd096a();
    
    if ( self.classname == "script_brushmodel" )
    {
        self movez( dist, timer );
        return;
    }
    
    if ( self.classname == "script_model" )
    {
        self moveto( self.origin + dist * anglestoup( self.angles ), timer );
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x4f60ea76, Offset: 0xace8
// Size: 0x82
function private panel_move_down( timer = 0.5 )
{
    dist = function_833c1d5298bd096a();
    
    if ( self.classname == "script_brushmodel" )
    {
        self movez( dist * -1, timer );
        return;
    }
    
    if ( self.classname == "script_model" )
    {
        self moveto( self.origin + dist * anglestoup( self.angles ) * -1, timer );
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x524cda62, Offset: 0xad72
// Size: 0x6b
function private function_852e262039308c26( timer = 0.5 )
{
    if ( isdefined( self.start_angles ) && isdefined( self.var_3713fe4fbd12ef53 ) )
    {
        self rotateto( self.var_3713fe4fbd12ef53, timer );
    }
    else
    {
        self rotatepitch( 90, timer );
    }
    
    dist = function_833c1d5298bd096a();
    self movez( dist, timer );
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x205e02c5, Offset: 0xade5
// Size: 0x6f
function private function_2524d44b21b7c70f( timer = 0.5 )
{
    if ( isdefined( self.start_angles ) && isdefined( self.var_3713fe4fbd12ef53 ) )
    {
        self rotateto( self.start_angles, timer );
    }
    else
    {
        self rotatepitch( -90, timer );
    }
    
    dist = function_833c1d5298bd096a();
    self movez( -1 * dist, timer );
}

// Namespace door
// Params 4, eflags: 0x4
// Checksum 0xcbeca843, Offset: 0xae5c
// Size: 0x4a
function private function_82785cd536b1e84c( ent1, ent2, ent3, ent4 )
{
    utility::waittill_any_ents( ent1, "movedone", ent2, "movedone", ent3, "movedone", ent4, "movedone" );
}

// Namespace door
// Params 0, eflags: 0x4
// Checksum 0x64d8bd36, Offset: 0xaeae
// Size: 0x80
function private function_47d49bbcb01a83e5()
{
    dist = function_833c1d5298bd096a();
    size = ( 0, 0, 0 );
    
    if ( dist == 48 )
    {
        size = ( 8, 128, 24 );
    }
    else if ( dist == 32 )
    {
        size = ( 8, 80, 16 );
    }
    
    navobstacleid = createnavobstaclebybounds( self.origin, size, self.angles );
    return navobstacleid;
}

// Namespace door
// Params 0, eflags: 0x4
// Checksum 0x906aa86f, Offset: 0xaf37
// Size: 0x27
function private function_2de470b96c0195fd()
{
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
    }
    
    self.navobstacleid = undefined;
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0xce7eb0b6, Offset: 0xaf66
// Size: 0x1a
function private function_8c7d9853e46ed08f( buttons )
{
    utility::waittill_any_ents_array( buttons, "trigger" );
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0xc81bab35, Offset: 0xaf88
// Size: 0xdd
function private disable_buttons( buttons )
{
    utility::array_call( buttons, &makeunusable );
    
    if ( isdefined( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_green" ] ) && isdefined( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_red" ] ) )
    {
        foreach ( button in buttons )
        {
            playfxontag( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_red" ], button, "tag_fx_light_red" );
            stopfxontag( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_green" ], button, "tag_fx_light_green" );
        }
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x67a59a69, Offset: 0xb06d
// Size: 0x13b
function private enable_buttons( buttons )
{
    utility::array_call( buttons, &makeusable );
    utility::array_call( buttons, &setuserange, 80 );
    utility::array_call( buttons, &sethintdisplayrange, 200 );
    utility::array_call( buttons, &setusefov, 120 );
    utility::array_call( buttons, &sethintdisplayfov, 120 );
    utility::array_call( buttons, &setcursorhint, "HINT_BUTTON" );
    utility::array_call( buttons, &sethintstring, &"mp/light_switch" );
    
    if ( isdefined( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_green" ] ) && isdefined( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_red" ] ) )
    {
        foreach ( button in buttons )
        {
            playfxontag( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_green" ], button, "tag_fx_light_green" );
            stopfxontag( level._effect[ "vfx_rex_level_shared_gate_warehouse_single_red" ], button, "tag_fx_light_red" );
        }
    }
}

// Namespace door
// Params 1
// Checksum 0x5ec23ee5, Offset: 0xb1b0
// Size: 0xc
function reset_buttons( buttons )
{
    
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0xea45950a, Offset: 0xb1c4
// Size: 0x84
function private garage_door_play_sound( buttons )
{
    if ( soundexists( "temp_mech_door_button_press" ) )
    {
        utility::play_sound_in_space( "temp_mech_door_button_press", buttons[ 0 ].origin );
        utility::play_sound_in_space( "temp_mech_door_button_press", buttons[ 1 ].origin );
    }
    
    if ( soundexists( "temp_mech_door_open_start" ) )
    {
        utility::play_sound_in_space( "temp_mech_door_open_start", self.origin );
    }
    
    if ( soundexists( "temp_mech_door_open_lp" ) )
    {
        thread utility::play_loop_sound_on_entity( "temp_mech_door_open_lp" );
    }
}

// Namespace door
// Params 0, eflags: 0x4
// Checksum 0x6d2a1f9d, Offset: 0xb250
// Size: 0x3b
function private garage_door_stop_sound()
{
    if ( soundexists( "temp_mech_door_open_stop" ) )
    {
        utility::play_sound_in_space( "temp_mech_door_open_stop", self.origin );
    }
    
    if ( soundexists( "temp_mech_door_open_lp" ) )
    {
        utility::stop_loop_sound_on_entity( "temp_mech_door_open_lp" );
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0x9296082c, Offset: 0xb293
// Size: 0x19
function private function_e5d74f5d7cf29d04( object )
{
    if ( isdefined( object ) )
    {
        object connectpaths();
    }
}

// Namespace door
// Params 1, eflags: 0x4
// Checksum 0xf4bdfbc6, Offset: 0xb2b4
// Size: 0x19
function private function_3d7bb51457e1fdb7( object )
{
    if ( isdefined( object ) )
    {
        object disconnectpaths();
    }
}

/#

    // Namespace door
    // Params 0, eflags: 0x4
    // Checksum 0xd4979f20, Offset: 0xb2d5
    // Size: 0x1a2, Type: dev
    function private function_6bc072e89474b1f2()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            while ( getdvarint( @"hash_a5efa3d8a23a614d", 0 ) == 0 )
            {
                wait 1;
            }
            
            foreach ( door in level.scriptable_garage_doors )
            {
                level thread utility::draw_line_for_time( door.origin, door.origin + ( 0, 0, 4096 ), 0, 1, 1, 200000, "<dev string:x216>" );
            }
            
            foreach ( door in level.garage_doors )
            {
                level thread utility::draw_line_for_time( door.origin, door.origin + ( 0, 0, 4096 ), 1, 0, 0, 200000, "<dev string:x216>" );
            }
            
            while ( getdvarint( @"hash_a5efa3d8a23a614d", 0 ) != 0 )
            {
                wait 1;
            }
            
            level notify( #"hash_facc335c7b18d492" );
        }
    }

#/
