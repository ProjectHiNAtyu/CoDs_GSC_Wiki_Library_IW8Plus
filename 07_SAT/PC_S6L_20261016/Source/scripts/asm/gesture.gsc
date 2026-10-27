// scripts\asm\gesture.gsc  (hash_22a56195290edd97.gscc) (size: 8249 Bytes / 0x2039 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ea572db (514159323)
// size ...... 8249 (0x2039)
// includes .. 3   (offset: 0x1d51)
// strings ... 44  (offset: 0x1d69)
// dev strs .. 5   (offset: 0x1ff9)
// exports ... 18  (offset: 0x1405)
// cseg ...... 0x29a + 0x116b (0x1405)
// imports ... 54  (offset: 0x16d5)
// animtree1 . 0   (offset: 0x2039)
// animtree2 . 0   (offset: 0x2039)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;

#namespace gesture;

// Namespace gesture
// Params 4
// Checksum 0x10bedf4e, Offset: 0x2b8
// Size: 0x3e
function ai_request_gesture( gesture, target_obj, timeout_ms = 1000, notify_name )
{
    ai_request_gesture_internal( gesture, target_obj, timeout_ms, notify_name );
}

// Namespace gesture
// Params 0
// Checksum 0xb08879ef, Offset: 0x2fe
// Size: 0x74
function ai_cancel_gesture()
{
    if ( !isdefined( self._blackboard.gesturerequest ) )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.gesturerequest.notifyname ) )
    {
        self notify( self._blackboard.gesturerequest.notifyname, "gesture_cancel" );
    }
    
    self._blackboard.gesturerequest = undefined;
}

// Namespace gesture
// Params 1
// Checksum 0x665e531b, Offset: 0x37a
// Size: 0x1c9
function handlegesturenotetrack( flagname )
{
    self waittill( flagname, notes );
    
    if ( !isdefined( notes ) )
    {
        notes = [ "undefined" ];
    }
    
    if ( !isarray( notes ) )
    {
        notes = [ notes ];
    }
    
    assert( isdefined( self.fnasm_handlenotetrack ) );
    defined_val = undefined;
    
    foreach ( note in notes )
    {
        if ( note == "start_gundown" )
        {
            self function_a83f7fcb7b07947b( undefined, "asm" );
            
            /#
                if ( getdvarint( @"hash_7528066c9678d0a0", 0 ) == 1 )
                {
                    print3d( self.origin + ( 0, 0, 60 ), "<dev string:x24>", ( 1, 1, 1 ), 1, 0.5, 20 );
                }
            #/
            
            continue;
        }
        else if ( note == "finish_early" )
        {
            /#
                if ( getdvarint( @"hash_7528066c9678d0a0", 0 ) == 1 )
                {
                    print3d( self.origin + ( 0, 0, 52 ), "<dev string:x32>", ( 1, 1, 1 ), 1, 0.5, 20 );
                }
            #/
            
            self._blackboard.partialgestureplaying = 0;
            continue;
        }
        else
        {
            val = [[ self.fnasm_handlenotetrack ]]( note, flagname );
        }
        
        if ( isdefined( val ) )
        {
            defined_val = val;
        }
    }
    
    return defined_val;
}

// Namespace gesture
// Params 1
// Checksum 0x324bbcf7, Offset: 0x54c
// Size: 0x50
function gesturedonotetracks( animlength )
{
    self endon( #"gesture_timeout" );
    thread gesturenotetracktimeoutthread( animlength );
    
    for ( ;; )
    {
        val = handlegesturenotetrack( "gesture" );
        
        if ( isdefined( val ) )
        {
            return val;
        }
    }
    
    self notify( #"gesture_finish" );
}

// Namespace gesture
// Params 1
// Checksum 0x6aa531bd, Offset: 0x5a4
// Size: 0x27
function gesturenotetracktimeoutthread( timeout_sec )
{
    self endon( #"gesture_finish" );
    wait timeout_sec;
    self notify( #"gesture_timeout" );
}

// Namespace gesture
// Params 1
// Checksum 0x4b3eb40d, Offset: 0x5d3
// Size: 0x3c4
function gesture( asmname )
{
    self endon( #"asm_terminated" );
    self endon( #"death" );
    assert( !isdefined( self._blackboard.gesturerequest ), "<dev string:x3f>" );
    
    while ( true )
    {
        if ( !isdefined( self._blackboard.gesturerequest ) )
        {
            self waittill( #"gesture_requested" );
        }
        
        assert( isdefined( self._blackboard.gesturerequest ) );
        
        while ( true )
        {
            if ( !isdefined( self._blackboard.gesturerequest ) )
            {
                break;
            }
            
            if ( self._blackboard.gesturerequest.timeoutms > 0 && self._blackboard.gesturerequest.timeoutms < gettime() )
            {
                ai_cancel_gesture();
                break;
            }
            
            if ( self._blackboard.partialgestureplaying )
            {
                wait 0.1;
                continue;
            }
            
            if ( asm_bb::bb_moverequested() )
            {
                target_speed = self aigettargetspeed();
                
                if ( !self.allowrunninggesture && target_speed > 135 )
                {
                    wait 0.1;
                    continue;
                }
                
                if ( self pathdisttogoal() < target_speed * 2.5 )
                {
                    wait 0.1;
                    continue;
                }
            }
            
            self._blackboard.gesturerequest.latestalias = get_gesture_alias( self._blackboard.gesturerequest.gesture, self._blackboard.gesturerequest.target );
            gesture_anim = self aiplaygesture( self._blackboard.gesturerequest.latestalias );
            
            if ( !isdefined( gesture_anim ) )
            {
                self aicleargesture();
                wait 0.3;
                break;
            }
            
            self._blackboard.gesturerequest.timeoutms = -1;
            anim_length = getanimlength( gesture_anim );
            thread function_8d2651046547b8d4( anim_length );
            
            /#
                if ( getdvarint( @"hash_7528066c9678d0a0", 0 ) == 1 )
                {
                    print3d( self.origin + ( 0, 0, 72 ), self._blackboard.gesturerequest.gesture + "<dev string:x70>", ( 1, 1, 1 ), 1, 1, int( anim_length * 20 ) );
                }
            #/
            
            self function_a83f7fcb7b07947b( "disable", "asm" );
            self.baimedataimtarget = 0;
            
            if ( self._blackboard.gesturerequest.disablelookat )
            {
                self.disableautolookat = 1;
                self stoplookat();
            }
            
            notify_name = self._blackboard.gesturerequest.notifyname;
            self._blackboard.gesturerequest = undefined;
            self._blackboard.partialgestureplaying = 1;
            gesturedonotetracks( getanimlength( gesture_anim ) );
            self._blackboard.partialgestureplaying = 0;
            
            if ( isdefined( notify_name ) )
            {
                self notify( notify_name, "gesture_finish" );
                self asmfireephemeralevent( "gesture", "end" );
            }
            
            self.disableautolookat = 0;
            self function_a83f7fcb7b07947b( undefined, "asm" );
            self aicleargesture();
            wait 0.4;
            break;
        }
    }
}

// Namespace gesture
// Params 1
// Checksum 0xdd30f18e, Offset: 0x99f
// Size: 0x8b, Type: bool
function gesture_should_disable_lookat( gesture )
{
    var_267b8d593f67f1ff = [ "casual_point", "military_point", "beckon", "nvg_on", "nvg_off", "wrist_com_lower", "wrist_com_raise" ];
    
    if ( isdefined( self._blackboard.civilianfocuscurvalue ) && gesture == "beckon" )
    {
        return false;
    }
    
    if ( arraycontains( var_267b8d593f67f1ff, gesture ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gesture
// Params 4
// Checksum 0x42b6f1e0, Offset: 0xa33
// Size: 0x16c
function ai_request_gesture_internal( gesture, target_object, timeout_ms, notify_name )
{
    if ( isdefined( self._blackboard.gesturerequest ) )
    {
        ai_cancel_gesture();
    }
    
    /#
        if ( getdvarint( @"hash_7528066c9678d0a0", 0 ) == 1 )
        {
            print3d( self.origin + ( 0, 0, 84 ), gesture + "<dev string:x79>", ( 1, 1, 1 ), 1, 1, int( timeout_ms / 50 ) );
        }
    #/
    
    self._blackboard.gesturerequest = spawnstruct();
    self._blackboard.gesturerequest.gesture = gesture;
    self._blackboard.gesturerequest.target = target_object;
    self._blackboard.gesturerequest.timeoutms = gettime() + timeout_ms;
    self._blackboard.gesturerequest.notifyname = notify_name;
    self._blackboard.gesturerequest.disablelookat = gesture_should_disable_lookat( gesture );
    self notify( #"gesture_requested" );
}

// Namespace gesture
// Params 0
// Checksum 0xe45201e1, Offset: 0xba7
// Size: 0x18, Type: bool
function civisfocusingleft()
{
    return self._blackboard.civilianfocusstate == 3;
}

// Namespace gesture
// Params 0
// Checksum 0x2fa6ac78, Offset: 0xbc8
// Size: 0x18, Type: bool
function civisfocusingright()
{
    return self._blackboard.civilianfocusstate == 4;
}

// Namespace gesture
// Params 2
// Checksum 0xe018e79e, Offset: 0xbe9
// Size: 0x359
function get_gesture_alias( gesture, gesture_target )
{
    if ( isdefined( self._blackboard.civilianfocuscurvalue ) )
    {
        if ( gesture == "beckon" )
        {
            var_c70b9feabbf40297 = randomint( 3 ) + 1;
            
            if ( civisfocusingleft() )
            {
                gesture = gesture + "_" + var_c70b9feabbf40297 + "_l";
            }
            else if ( civisfocusingright() )
            {
                gesture = gesture + "_" + var_c70b9feabbf40297 + "_r";
            }
        }
        else if ( gesture == "glance" )
        {
            var_c70b9feabbf40297 = randomint( 2 ) + 1;
            
            if ( civisfocusingleft() )
            {
                gesture = gesture + "_" + var_c70b9feabbf40297 + "_l";
            }
            else if ( civisfocusingright() )
            {
                gesture = gesture + "_" + var_c70b9feabbf40297 + "_r";
            }
        }
    }
    
    if ( isdefined( gesture_target ) && ( gesture == "casual_point" || gesture == "military_point" || gesture == "beckon" || gesture == "stop" || gesture == "look" || gesture == "hide" ) )
    {
        if ( isvector( gesture_target ) )
        {
            targetorigin = gesture_target;
        }
        else
        {
            targetorigin = gesture_target.origin;
        }
        
        yawtotarget = vectortoyaw( targetorigin - self.origin );
        anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
        angleindex = getangleindex( anglediff, 22.5 );
        angleindex = utility::mapangleindextonumpad( angleindex );
        return ( gesture + angleindex );
    }
    
    squad_gestures = [ "point_forward", "point_forward_fast", "point_left", "point_left_fast", "point_right", "point_right_fast", "on_me", "on_me_fast", "halt", "halt_fast" ];
    
    if ( arraycontains( squad_gestures, gesture ) )
    {
        self function_28b54d425ee6f778( "all", "prohibit", "script_override" );
        self function_28b54d425ee6f778( "script_explicit", "request", "script_override" );
        self.lookatSpecName_current = "scripted_gesture";
        eyeposition = self geteye();
        vectorforward = anglestoforward( self.angles );
        positionoffset = ( 100, 100, eyeposition[ 2 ] );
        
        if ( gesture == squad_gestures[ 2 ] || gesture == squad_gestures[ 3 ] )
        {
            lookpos = eyeposition + positionoffset * rotatevector( vectorforward, ( 0, 60, 1 ) );
        }
        else if ( gesture == squad_gestures[ 4 ] || gesture == squad_gestures[ 5 ] )
        {
            lookpos = eyeposition + positionoffset * rotatevector( vectorforward, ( 0, -60, 1 ) );
        }
        else
        {
            lookpos = eyeposition + positionoffset * vectorforward;
        }
        
        if ( lookpos )
        {
            self setlookatstate( "request", "script_override" );
            self stoplookat();
            self lookat( { #explicit_override:1, #percent:100, #speed:4, #duration_ms:3000, #position:lookpos } );
        }
    }
    
    return gesture;
}

// Namespace gesture
// Params 0
// Checksum 0x9f6be71c, Offset: 0xf4b
// Size: 0x77
function ai_finish_gesture()
{
    assert( isdefined( self._blackboard.gesturerequest ) );
    
    if ( isdefined( self._blackboard.gesturerequest.notifyname ) )
    {
        self notify( self._blackboard.gesturerequest.notifyname, "gesture_finish" );
    }
    
    self._blackboard.gesturerequest = undefined;
}

// Namespace gesture
// Params 3
// Checksum 0x88463d52, Offset: 0xfca
// Size: 0x78
function chooseanim_gesture( asmname, statename, params )
{
    assert( isdefined( self._blackboard.gesturerequest ) );
    gesture_anim = asm::asm_lookupanimfromalias( statename, self._blackboard.gesturerequest.latestalias );
    assert( isdefined( gesture_anim ) );
    return gesture_anim;
}

// Namespace gesture
// Params 3
// Checksum 0xf4f641cd, Offset: 0x104b
// Size: 0x1d0
function playcoveranim_gesture( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self._blackboard.activegesturenotify = self._blackboard.gesturerequest.notifyname;
    self setuseanimgoalweight( 0.2 );
    myanim = asm::asm_getanim( asmname, statename );
    myxanim = asm::asm_getxanim( statename, myanim );
    self orientmode( "face current" );
    
    if ( asm::asm_currentstatehasflag( asmname, "notetrackAim" ) )
    {
        angledelta = getangledelta( myxanim, 0, 1 );
        self.stepoutyaw = self.angles[ 1 ] + angledelta;
    }
    
    /#
        if ( getdvarint( @"hash_7528066c9678d0a0", 0 ) == 1 )
        {
            print3d( self.origin + ( 0, 0, 72 ), self._blackboard.gesturerequest.gesture + "<dev string:x70>", ( 1, 1, 1 ), 1, 1, 80 );
        }
    #/
    
    self._blackboard.gesturerequest = undefined;
    self aisetanim( statename, myanim );
    asm::asm_playfacialanim( asmname, statename, myxanim );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    self orientmode( "face current" );
    
    if ( isdefined( self._blackboard.activegesturenotify ) )
    {
        self notify( self._blackboard.activegesturenotify, "gesture_finish" );
        self._blackboard.activegesturenotify = undefined;
    }
}

// Namespace gesture
// Params 3
// Checksum 0x4146f413, Offset: 0x1223
// Size: 0x63
function cleargestureanim( asmname, statename, params )
{
    if ( isdefined( self._blackboard.activegesturenotify ) )
    {
        self notify( self._blackboard.activegesturenotify, "gesture_cancel" );
        self._blackboard.activegesturenotify = undefined;
    }
}

// Namespace gesture
// Params 4
// Checksum 0x2795cb81, Offset: 0x128e
// Size: 0xeb, Type: bool
function gesture_finishearly( asmname, statename, tostatename, gesture )
{
    if ( asm_bb::bb_moverequested() && self.gestureinterruptible )
    {
        if ( isdefined( self.gestureinterruptibleifplayerwithindist ) )
        {
            if ( distancesquared( self.origin, level.player.origin ) < self.gestureinterruptibleifplayerwithindist * self.gestureinterruptibleifplayerwithindist )
            {
                self asmfireephemeralevent( "gesture", "end" );
                return true;
            }
        }
        else
        {
            self asmfireephemeralevent( "gesture", "end" );
            return true;
        }
    }
    
    if ( asm::asm_eventfired( asmname, "finish_early" ) && asm_bb::bb_moverequested() )
    {
        self asmfireephemeralevent( "gesture", "end" );
    }
    
    return asm::asm_eventfired( asmname, "finish_early" ) && asm_bb::bb_moverequested();
}

// Namespace gesture
// Params 1
// Checksum 0x7dd26a96, Offset: 0x1382
// Size: 0x83
function function_8d2651046547b8d4( gesturetime )
{
    self endon( #"death" );
    waittime = gesturetime - 0.6;
    var_8be5fd55118244a5 = 0;
    
    if ( waittime > 0 )
    {
        wait waittime;
        var_8be5fd55118244a5 = gesturetime - waittime;
    }
    
    self stoplookat();
    wait var_8be5fd55118244a5;
    self setlookatstate( "neutral", "script_override" );
    self function_28b54d425ee6f778( "all", "neutral", "script_override" );
    self.lookatSpecName_current = "default";
}

