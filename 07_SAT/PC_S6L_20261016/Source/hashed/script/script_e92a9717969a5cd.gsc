// script_e92a9717969a5cd  (hash_0e92a9717969a5cd.gscc) (size: 7858 Bytes / 0x1eb2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ac6fcc2 (449248450)
// size ...... 7858 (0x1eb2)
// includes .. 11  (offset: 0x1cc6)
// strings ... 22  (offset: 0x1d1e)
// dev strs .. 8   (offset: 0x1e52)
// exports ... 31  (offset: 0xf1e)
// cseg ...... 0x17e + 0xda0 (0xf1e)
// imports ... 75  (offset: 0x13f6)
// animtree1 . 0   (offset: 0x1eb2)
// animtree2 . 0   (offset: 0x1eb2)
#using script_ac28d65e8605696;
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\traverse;
#using scripts\asm\traverse;
#using scripts\common\callbacks;
#using scripts\common\cap;
#using scripts\common\system;
#using scripts\common\utility;

#namespace europa_asm;

// Namespace europa_asm
// Params 0, eflags: 0x5
// Checksum 0xc1a1d738, Offset: 0x19c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_asm", undefined, undefined, &post_main );
}

// Namespace europa_asm
// Params 0
// Checksum 0x67b43a0d, Offset: 0x1bd
// Size: 0x1e
function post_main()
{
    callback::get_template( "europa" ) callback::add( "on_ai_init", &function_6e5a39315ec6971d );
}

// Namespace europa_asm
// Params 1
// Checksum 0x69a7d085, Offset: 0x1e3
// Size: 0x7c
function function_6e5a39315ec6971d( params )
{
    europa = self;
    
    if ( !isdefined( europa.europa_asm ) )
    {
        europa.europa_asm = spawnstruct();
    }
    
    if ( !isdefined( europa.var_5e505729e7585103 ) )
    {
        europa.var_5e505729e7585103 = &traverse::function_b1f841aaaec3f50b;
    }
    
    europa traverse::function_a6072a7a16075b70( "PlayTraverseAnim_External", &function_7b77a3826bb34763 );
    europa traverse::function_a6072a7a16075b70( "ChooseTraverseAnim_External", &function_9123d4c7a5dddf4 );
}

// Namespace europa_asm
// Params 3
// Checksum 0x981417b1, Offset: 0x267
// Size: 0x59
function europa_init( asmname, statename, params )
{
    europa::clear_goal_pos();
    
    if ( !isdefined( self.europa_asm ) )
    {
        self.europa_asm = spawnstruct();
    }
    
    if ( !isdefined( self getaiblackboarddynamic( "europa_activated" ) ) )
    {
        self function_786bb6aa1b76c7ee( "europa_activated", 0 );
    }
}

// Namespace europa_asm
// Params 3
// Checksum 0xb39f0519, Offset: 0x2c8
// Size: 0x2c
function europa_exit( asmname, statename, params )
{
    europa::clear_goal_pos();
    exit_cap();
}

// Namespace europa_asm
// Params 3
// Checksum 0x3b6b035e, Offset: 0x2fc
// Size: 0xb6
function europa_chooseanim( asmname, statename, params )
{
    if ( isdefined( params ) )
    {
        alias = params;
    }
    else
    {
        archetype = self.animsetname;
        aliases = archetypegetaliases( archetype, statename );
        
        if ( isdefined( aliases ) )
        {
            alias = aliases[ randomint( aliases.size ) ];
        }
    }
    
    if ( isdefined( alias ) )
    {
        animation = choose_anim( statename, alias );
    }
    
    if ( !isdefined( animation ) )
    {
        if ( statename == "loop" )
        {
            fire_event( "exit_loop", asmname );
        }
        else
        {
            fire_event( "end", asmname );
        }
    }
    
    return animation;
}

// Namespace europa_asm
// Params 3
// Checksum 0xe8b46d94, Offset: 0x3bb
// Size: 0xc1
function europa_chooseturnanim( asmname, statename, params )
{
    targetname = get_param_name( params );
    angle = 0;
    
    if ( isdefined( targetname ) )
    {
        target = europa::function_b8c0ff578e3412( targetname );
        
        if ( isdefined( target.angles ) )
        {
            angle = angleclamp180( target.angles[ 1 ] - self.angles[ 1 ] );
        }
    }
    
    alias = asm::yawdiffto2468( angle );
    turnanim = choose_anim( statename, alias );
    
    if ( !isdefined( turnanim ) )
    {
        fire_event( "end", asmname );
    }
    
    return turnanim;
}

// Namespace europa_asm
// Params 3
// Checksum 0xea0f5601, Offset: 0x485
// Size: 0x5c
function function_bf37b5ac7e21ab0e( asmname, statename, params )
{
    targetname = get_param_name( params );
    
    if ( isdefined( targetname ) )
    {
        target = europa::function_b8c0ff578e3412( targetname );
    }
    
    thread play_anim_thread( asmname, statename, target, 1, 0.2 );
}

// Namespace europa_asm
// Params 3
// Checksum 0xcd2d3a20, Offset: 0x4e9
// Size: 0x74
function function_7b77a3826bb34763( asmname, statename, params )
{
    if ( self.var_9d40c8bd8f7a879.traverse_data_calculated && self.var_9d40c8bd8f7a879.traversetype != statename )
    {
        asm::asm_setstate( self.var_9d40c8bd8f7a879.traversetype );
        return;
    }
    
    traverse::playtraverseanim_scaled( asmname, statename, params );
}

// Namespace europa_asm
// Params 3
// Checksum 0x569fe3db, Offset: 0x565
// Size: 0x97
function function_9123d4c7a5dddf4( asmname, statename, params )
{
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        assert( isdefined( self.var_9d40c8bd8f7a879 ), "<dev string:x24>" );
        endpos = self.var_9d40c8bd8f7a879.endpos;
        thread function_1488a5eed89265d5( endpos, 0.5 );
    }
    
    return choose_anim( statename, "default" );
}

// Namespace europa_asm
// Params 2
// Checksum 0x21a428e1, Offset: 0x605
// Size: 0x80
function function_1488a5eed89265d5( pos, time )
{
    mover = spawn( "script_model", self.origin );
    mover.angles = self.angles;
    self linkto( mover );
    mover moveto( pos, time );
    
    if ( time > 0 )
    {
        utility::waittill_notify_or_timeout_return( "death", time );
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
    }
    
    mover delete();
}

// Namespace europa_asm
// Params 2
// Checksum 0xf8b99338, Offset: 0x68d
// Size: 0xf4
function function_20a9b458c7b23fbd( asmname, params )
{
    targetname = get_param_name( params );
    
    if ( isdefined( targetname ) )
    {
        target = europa::function_b8c0ff578e3412( targetname );
        movetype = self getaiblackboarddynamic( "move_to_type" );
        
        if ( isdefined( target ) && movetype == "none" )
        {
            distancesq = distancesquared( target.origin, self.origin );
            var_5c5eb730d5ff1a7e = self.aisettings.specificaisettings.var_5c5eb730d5ff1a7e ?? 0;
            
            if ( var_5c5eb730d5ff1a7e > 0 && distancesq > squared( var_5c5eb730d5ff1a7e ) )
            {
                thread europa::function_1799fcdfd63d83a9( target );
                self function_786bb6aa1b76c7ee( "move_to_type", "fly" );
                return;
            }
            
            self function_786bb6aa1b76c7ee( "move_to_type", "walk" );
        }
    }
}

// Namespace europa_asm
// Params 2
// Checksum 0xb84c859a, Offset: 0x789
// Size: 0x1f
function function_3e296dcc79559c8b( asmname, params )
{
    thread function_69dabbedb72b15af( asmname, params );
}

// Namespace europa_asm
// Params 2
// Checksum 0x73053195, Offset: 0x7b0
// Size: 0x133
function function_69dabbedb72b15af( asmname, targetname )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_7324567888aaad3a = ( -20.926, 0.758, 3945.67 );
    var_35c8e34b73029c15 = ( 0, 0, 2723.44 );
    const_fly_time = 3;
    
    while ( true )
    {
        waitframe();
        target = europa::function_b8c0ff578e3412( targetname );
        
        if ( isdefined( target ) )
        {
            returnchair = self getaiblackboarddynamic( "return_to_chair" );
            offset = returnchair ? var_7324567888aaad3a : var_35c8e34b73029c15;
            targetpos = target.origin + offset;
            mover = spawn( "script_model", self.origin );
            self linkto( mover );
            mover moveto( targetpos, const_fly_time );
            wait const_fly_time;
            self unlink();
            mover delete();
            self forceteleport( targetpos, target.angles, 9999999, 0 );
            fire_event( "exit_loop", asmname );
            break;
        }
    }
}

// Namespace europa_asm
// Params 2
// Checksum 0x2d20193e, Offset: 0x8eb
// Size: 0x36
function function_4d5821788faf3e7b( asmname, params )
{
    self function_786bb6aa1b76c7ee( "return_to_chair", 0 );
    europa::set_on_chair( 1 );
    self notify( #"hash_46be2957b8bf5782" );
}

// Namespace europa_asm
// Params 2, eflags: 0x4
// Checksum 0xc263565c, Offset: 0x929
// Size: 0x3b
function private get_param_name( param, index )
{
    if ( isstring( param ) )
    {
        return param;
    }
    
    if ( isarray( param ) && param.size > 0 )
    {
        return param[ index ];
    }
}

// Namespace europa_asm
// Params 2
// Checksum 0x902b8072, Offset: 0x96d
// Size: 0x53
function choose_anim( statename, alias )
{
    arcname = utility::function_18bf04f16702b9b2();
    assert( isdefined( arcname ), "<dev string:x74>" );
    animresult = archetypegetrandomalias( arcname, statename, alias );
    
    if ( !isdefined( animresult ) )
    {
        return;
    }
    
    return animresult;
}

// Namespace europa_asm
// Params 5
// Checksum 0x7ae652dd, Offset: 0x9c9
// Size: 0x11b
function play_anim_thread( asmname, statename, targetnode, animrate = 1, blendtime )
{
    animid = self asmgetanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    
    if ( isdefined( xanim ) )
    {
        if ( isdefined( targetnode.origin ) && isdefined( targetnode.angles ) )
        {
            animstartpos = getstartorigin( targetnode.origin, targetnode.angles, xanim );
            animstartangles = getstartangles( targetnode.origin, targetnode.angles, xanim );
            self forceteleport( animstartpos, animstartangles, 9999999, 0 );
        }
        
        self aisetanim( statename, animid, animrate );
        self aisetanimrate( statename, animid, animrate );
        animlength = getanimlength( xanim );
        
        if ( animlength > 0 )
        {
            wait animlength;
        }
    }
    
    fire_event( "end", asmname );
}

// Namespace europa_asm
// Params 1
// Checksum 0xf06d3205, Offset: 0xaec
// Size: 0x36, Type: bool
function is_playing( asmname )
{
    if ( !self.europa_asm.playing )
    {
        return false;
    }
    
    if ( asmname )
    {
        return ( function_972cfe27021b9096() == asmname );
    }
    
    return true;
}

// Namespace europa_asm
// Params 0
// Checksum 0x46631bdf, Offset: 0xb2b
// Size: 0xb
function function_972cfe27021b9096()
{
    return self.asmname;
}

// Namespace europa_asm
// Params 0
// Checksum 0xcb156222, Offset: 0xb3f
// Size: 0x39
function get_current_asm_state()
{
    asm = function_972cfe27021b9096();
    
    if ( !isdefined( asm ) || asm == "" )
    {
        return "";
    }
    
    return asm::asm_getcurrentstate( function_972cfe27021b9096() );
}

// Namespace europa_asm
// Params 2
// Checksum 0x144adbd, Offset: 0xb81
// Size: 0x75
function play_cap( asm_name, cap_path )
{
    europa::clear_goal_pos();
    ret = cap::cap_start( asm_name, cap_path );
    
    if ( ret )
    {
        self.europa_asm.playing = 1;
        thread function_4618a3489fdaf18b();
    }
    
    /#
        if ( getdvarint( @"hash_79b53dd725bbd5dd" ) )
        {
            logstring( "<dev string:x98>" + cap_path );
        }
    #/
    
    return ret;
}

// Namespace europa_asm
// Params 0
// Checksum 0x732522ef, Offset: 0xbff
// Size: 0x31
function exit_cap()
{
    cap::cap_exit();
    self animmode( "normal" );
    
    /#
        if ( getdvarint( @"hash_79b53dd725bbd5dd" ) )
        {
            logstring( "<dev string:xab>" );
        }
    #/
}

// Namespace europa_asm
// Params 1
// Checksum 0x9cb4bb63, Offset: 0xc38
// Size: 0x5f
function function_8f949c842782e6ff( timeout )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_7165e51a584232d6 = gettime() + timeout * 1000;
    
    while ( is_playing() )
    {
        wait 0.1;
        
        if ( gettime() > var_7165e51a584232d6 )
        {
            exit_cap();
            waitframe();
        }
    }
}

// Namespace europa_asm
// Params 2
// Checksum 0x59d8c09, Offset: 0xc9f
// Size: 0x82
function fire_event( event, asmname )
{
    if ( is_playing() )
    {
        if ( !isdefined( asmname ) )
        {
            asmname = function_972cfe27021b9096();
        }
        
        asm::asm_fireevent( asmname, event );
        
        /#
            if ( getdvarint( @"hash_79b53dd725bbd5dd" ) )
            {
                logstring( "<dev string:xbd>" + asmname + "<dev string:xd2>" + event );
            }
        #/
        
        return;
    }
    
    /#
        if ( getdvarint( @"hash_79b53dd725bbd5dd" ) )
        {
            assert( 0, "<dev string:xd5>" );
        }
    #/
}

// Namespace europa_asm
// Params 0, eflags: 0x4
// Checksum 0x29e55a2, Offset: 0xd29
// Size: 0x53
function private function_4618a3489fdaf18b()
{
    self endon( #"death" );
    self waittill( #"cap_exit_completed" );
    
    if ( self function_51631ea7d587647d() )
    {
        assertmsg( "<dev string:x103>" + function_972cfe27021b9096() );
        exit_cap();
    }
    
    self.europa_asm.playing = 0;
}

// Namespace europa_asm
// Params 0
// Checksum 0xa4f488f0, Offset: 0xd84
// Size: 0x15
function is_script_animation()
{
    return self.europa_asm.is_script_animation;
}

// Namespace europa_asm
// Params 1
// Checksum 0x8f0c9640, Offset: 0xda2
// Size: 0xbc
function play_scripted_anim( aliasname )
{
    self notify( #"hash_c855ae4922bc1ba9" );
    self endon( #"hash_c855ae4922bc1ba9" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"scripted_anim_cleared" );
    self.europa_asm.is_script_animation = 1;
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    self aisetanim( "animscripted", animindex );
    wait animlength;
    function_4d732b0c87bec23e();
}

// Namespace europa_asm
// Params 0
// Checksum 0x95e09633, Offset: 0xe66
// Size: 0x2a
function function_4d732b0c87bec23e()
{
    utility::animscripted_clear();
    self.europa_asm.is_script_animation = 0;
    self notify( #"scripted_anim_cleared" );
}

// Namespace europa_asm
// Params 2
// Checksum 0xe48002fe, Offset: 0xe98
// Size: 0x86
function face_to_target( target, seconds )
{
    self notify( #"hash_97820d2df60c9ec1" );
    self endon( #"hash_97820d2df60c9ec1" );
    level endon( #"game_ended" );
    self endon( #"death" );
    endtime = gettime() + seconds * 1000;
    
    while ( target && gettime() <= endtime )
    {
        self orientmode( "face point", target.origin );
        waitframe();
    }
}

