// script_2734ab7e314a0bd3  (hash_2734ab7e314a0bd3.gscc) (size: 26060 Bytes / 0x65cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d3ee03f (1027530815)
// size ...... 26060 (0x65cc)
// includes .. 8   (offset: 0x6370)
// strings ... 20  (offset: 0x63b0)
// dev strs .. 19  (offset: 0x64dc)
// exports ... 48  (offset: 0x486c)
// cseg ...... 0x1bd + 0x46af (0x486c)
// imports ... 151 (offset: 0x4fec)
// animtree1 . 0   (offset: 0x65cc)
// animtree2 . 0   (offset: 0x65cc)
#using script_689b4e6de3cb80e2;
#using script_ac28d65e8605696;
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace europa_hover;

// Namespace europa_hover
// Params 0, eflags: 0x5
// Checksum 0xcfc73e42, Offset: 0x1db
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_hover", undefined, undefined, &post_main );
}

// Namespace europa_hover
// Params 0
// Checksum 0xd65cf787, Offset: 0x1fc
// Size: 0x21
function post_main()
{
    callback::add( #"europa_init", &init_hover );
    
    /#
        devgui_init();
    #/
}

// Namespace europa_hover
// Params 1
// Checksum 0xdddbbd49, Offset: 0x225
// Size: 0x109
function init_hover( params )
{
    if ( !level callback::exists( #"player_vehicle_enter", &on_player_entered_vehicle ) )
    {
        level callback::add( #"player_vehicle_enter", &on_player_entered_vehicle );
    }
    
    if ( !level callback::exists( #"player_vehicle_exit", &on_player_exit_vehicle ) )
    {
        level callback::add( #"player_vehicle_exit", &on_player_exit_vehicle );
    }
    
    if ( !level callback::exists( "on_player_ft_jp_entered", &function_b91127e578e6783f ) )
    {
        level callback::add( "on_player_ft_jp_entered", &function_b91127e578e6783f );
    }
    
    if ( !level callback::exists( "on_player_ft_jp_landed", &function_805e531c9a905bec ) )
    {
        level callback::add( "on_player_ft_jp_landed", &function_805e531c9a905bec );
    }
    
    if ( !level callback::exists( "on_zipline_attach", &on_player_use_zipline ) )
    {
        level callback::add( "on_zipline_attach", &on_player_use_zipline );
    }
    
    callback::add( #"hash_8e420a8ff3313166", &function_bf6341a86c399f62 );
    callback::add( #"europa_deactivated", &on_deactivated );
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xeb6657d, Offset: 0x336
// Size: 0x61
function private function_bf6341a86c399f62( params )
{
    function_71a68ebe6054d93f();
    thread function_55fceac5ca8afa9c();
    owner = europa::get_owner();
    
    if ( owner.vehicle && !is_follow_vehicle() )
    {
        thread function_b7daa5f3eafffead( owner.vehicle, [ "europa_owner_exit_vehicle" ] );
    }
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xc6069915, Offset: 0x39f
// Size: 0x47
function private on_deactivated( params )
{
    self.europa.hovering_to_target = 0;
    self.europa.hover_path = undefined;
    self.europa.hoverparam = undefined;
}

// Namespace europa_hover
// Params 0, eflags: 0xc
// Checksum 0x43a95666, Offset: 0x3ee
// Size: 0x1c1
function private function_55fceac5ca8afa9c()
{
    self notify( #"hash_992aa6fbb0113cfb" );
    self endon( #"hash_992aa6fbb0113cfb" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    stuck_pos = self.origin;
    stuck_time = 0;
    owner = europa::get_owner();
    const_stuck_timeout = 5000;
    
    while ( true )
    {
        if ( self.europa.hovermover || self islinked() )
        {
            skipcheck = 0;
            
            if ( owner.vehicle && self.europa.var_865efc00faa1dd36.type == 1 )
            {
                skipcheck = 1;
            }
            
            if ( skipcheck || distancesquared( self.origin, stuck_pos ) > 2500 )
            {
                stuck_time = gettime();
                stuck_pos = self.origin;
            }
            else if ( gettime() - stuck_time > const_stuck_timeout )
            {
                message = europa::function_6ab0868abe41859b( "hover" );
                logstring( message );
                function_71a68ebe6054d93f();
                
                if ( self.europa.var_865efc00faa1dd36.target.origin )
                {
                    thread europa::function_84919f8f8db67077( self.europa.var_865efc00faa1dd36.target.origin );
                }
                
                stuck_pos = self.origin;
                stuck_time = gettime();
            }
        }
        else
        {
            stuck_pos = self.origin;
            stuck_time = gettime();
        }
        
        waitframe();
    }
}

// Namespace europa_hover
// Params 0
// Checksum 0xe63955dd, Offset: 0x5b7
// Size: 0xb2
function function_71a68ebe6054d93f()
{
    self.europa.hovering_to_target = 0;
    self motionwarpcancel();
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    if ( self.europa.hovermover )
    {
        self.europa.hovermover delete();
        self.europa.hovermover = undefined;
    }
    
    if ( self function_51631ea7d587647d() )
    {
        europa_asm::exit_cap();
    }
    
    self.europa.hover_path = undefined;
    self.europa.hoverparam = undefined;
    utility::function_32b24db3127bff40( "jetboots", "off" );
}

// Namespace europa_hover
// Params 2
// Checksum 0x7f1c8abf, Offset: 0x671
// Size: 0xa3
function function_a29bc8195eac2631( goalpos, command )
{
    if ( is_hovering() )
    {
        return;
    }
    
    var_865efc00faa1dd36 = { #command:command, #findpath:1, #acceleration:3, #followheight:30, #targetdistance:100, #speedmaxdistance:1000, #speedmax:1000, #target:{ #origin:goalpos }, #type:0 };
    thread function_5b12aedd4acc980d( var_865efc00faa1dd36 );
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xf1d97b5b, Offset: 0x71c
// Size: 0x289
function private on_player_use_zipline( params )
{
    level endon( #"game_ended" );
    player = self;
    
    if ( isdefined( player.allyeuropa ) && player.allyeuropa europa::can_think() )
    {
        europa = player.allyeuropa;
        europa.europa.var_434b05f9582b4d8c = undefined;
        europa endon( #"europa_deactivated" );
        player thread function_6b7b7efd2338bcaf();
        europa europa::function_47761cd429bc0244();
        
        if ( !europa europa::can_think() )
        {
            return;
        }
        
        offset = ( 0, 0, 0 );
        
        if ( !params.isvertical )
        {
            europa europa::function_cdec0e301075f132();
            europa europa::add_command( #"hash_c43ad878d18906c2", {} );
            var_eff7a486d6004807 = 1440000;
            
            if ( distancesquared( europa.origin, player.origin ) > var_eff7a486d6004807 )
            {
                startpos = player.origin;
                wait 1;
                europa europa::function_84919f8f8db67077( startpos );
            }
            else
            {
                europa europa::move_to( player.origin, 0, { #forcehover:1 } );
                europa waittill( #"europa_move_to_end", result );
            }
            
            var_865efc00faa1dd36 = { #offset:offset, #acceleration:10, #followheight:120, #targetdistance:200, #speedmaxdistance:600, #speedmax:1000, #target:player, #ignorecollision:1, #type:3 };
            europa thread function_5b12aedd4acc980d( var_865efc00faa1dd36 );
            return;
        }
        
        timeout = gettime() + 5000;
        
        while ( !europa.europa.var_434b05f9582b4d8c )
        {
            if ( gettime() > timeout )
            {
                logstring( "[EUROPA] Wait player end zipline land timeout." );
                return;
            }
            
            waitframe();
        }
        
        var_86820c2b3829906c = distance2dsquared( europa.origin, europa.europa.var_434b05f9582b4d8c );
        
        if ( var_86820c2b3829906c < 250000 )
        {
            europa europa::move_to( player.origin, 0, { #forcewalk:1 } );
        }
    }
}

// Namespace europa_hover
// Params 0, eflags: 0x4
// Checksum 0x6a641f15, Offset: 0x9ad
// Size: 0x9e
function private function_6b7b7efd2338bcaf()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    msg = utility::waittill_any_timeout( 15, "ascender_detached", "ascender_detach_complete" );
    
    if ( msg != "timeout" && self.allyeuropa )
    {
        self.allyeuropa.europa.var_434b05f9582b4d8c = self.origin;
        self.allyeuropa.europa.var_e1d7738d07e690a = self.angles;
    }
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xe6de187, Offset: 0xa53
// Size: 0x107
function private function_b91127e578e6783f( params )
{
    level endon( #"game_ended" );
    player = params.player;
    europa = player.allyeuropa;
    
    if ( isdefined( europa ) && europa europa::can_think() )
    {
        europa endon( #"europa_deactivated" );
        europa europa::function_47761cd429bc0244();
        
        if ( !europa europa::can_think() )
        {
            return;
        }
        
        europa europa::function_cdec0e301075f132();
        europa europa::add_command( #"hash_c43ad878d18906c2", {} );
        player.fasttravel_jumppad = 1;
        var_865efc00faa1dd36 = { #acceleration:10, #followheight:100, #targetdistance:200, #speedmaxdistance:600, #speedmax:2500, #target:player, #type:2 };
        europa thread function_5b12aedd4acc980d( var_865efc00faa1dd36 );
    }
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xc3d37c85, Offset: 0xb62
// Size: 0x60
function private function_805e531c9a905bec( params )
{
    player = params.player;
    
    if ( isdefined( player.allyeuropa ) )
    {
        player.fasttravel_jumppad = 0;
        player.fasttravel_landing_target = { #origin:player.origin };
    }
}

// Namespace europa_hover
// Params 1, eflags: 0xc
// Checksum 0x6bd0ce82, Offset: 0xbca
// Size: 0x4ad
function private function_5b12aedd4acc980d( params )
{
    self notify( #"hash_202bdbee721cfe0e" );
    self endon( #"hash_202bdbee721cfe0e" );
    level endon( #"game_ended" );
    self endon( #"europa_deactivated" );
    
    /#
        debug_hover = function_bf9fca2a50a83961();
        
        if ( debug_hover )
        {
            logstring( "<dev string:x24>" );
        }
    #/
    
    function_71a68ebe6054d93f();
    owner = europa::get_owner();
    
    if ( params.type == 2 )
    {
        begintime = gettime();
        
        while ( !owner.var_d1c4c78b9fb7d153 )
        {
            if ( gettime() - begintime > 5000 )
            {
                return;
            }
            
            waitframe();
        }
    }
    
    params.sourceorigin = self.origin;
    params.starttime = gettime();
    self.europa.var_865efc00faa1dd36 = params;
    self.europa.var_fa2f23c9ef92d618 = 1;
    
    while ( true )
    {
        europa::function_47761cd429bc0244();
        result = function_207cff3ce5d7d3c( params );
        europa::function_47761cd429bc0244();
        
        if ( !result.finished )
        {
            if ( params.type == 1 )
            {
                tgtforward = anglestoforward( params.target.angles );
                overridecontents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
                vehpos = params.target.origin + ( 0, 0, 50 );
                checkradius = 250;
                var_f984e2d10670e942 = 22500;
                
                for ( i = 0; i < 8 ; i++ )
                {
                    deltaangle = 45 * round( i * 0.5 ) * pow( -1, i );
                    dir = rotatepointaroundvector( ( 0, 0, 1 ), tgtforward * -1, deltaangle );
                    checkpos = vehpos + dir * checkradius;
                    traceres = trace::ray_trace( vehpos, checkpos, params.target, overridecontents );
                    
                    if ( traceres[ "fraction" ] < 0.95 )
                    {
                        hit = traceres[ "position" ];
                        
                        /#
                            if ( debug_hover )
                            {
                                duration = utility::function_329f35afae907694( 1 );
                                line( vehpos, hit, ( 1, 0, 0 ), 1, 0, duration );
                                sphere( hit, 5, ( 1, 0, 0 ), 0, duration );
                            }
                        #/
                        
                        if ( distancesquared( hit, params.target.origin ) < var_f984e2d10670e942 )
                        {
                            continue;
                        }
                        
                        dir = vectornormalize( params.target.origin - checkpos );
                        targetpos = hit + dir * self.radius;
                        break;
                    }
                    
                    targetpos = checkpos;
                    break;
                }
                
                if ( targetpos )
                {
                    telepos = getclosestpointonnavmesh( targetpos, self );
                    europa::function_84919f8f8db67077( telepos );
                }
            }
            else if ( result.walkgoal )
            {
                self.europa.hover_path_data.walkgoal = result.walkgoal;
                function_43be42579b67e4e9( result.walkgoal );
                europa::function_47761cd429bc0244();
                
                if ( params.command && !europa::function_d7c804c78806fbc0( params.command.id ) )
                {
                    break;
                }
                
                var_4574a47fc908c0d9 = 40000;
                
                if ( result.var_2941619c6e6a305d )
                {
                    break;
                }
                else if ( distancesquared( self.origin, params.target.origin ) < var_4574a47fc908c0d9 )
                {
                    function_43be42579b67e4e9( params.target.origin );
                    break;
                }
            }
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"hash_163ed70cfa27146b" );
    
    if ( params.type == 2 || params.type == 3 )
    {
        europa::function_cdec0e301075f132();
    }
    
    /#
        if ( debug_hover )
        {
            logstring( "<dev string:x43>" );
        }
    #/
    
    europa_asm::function_8f949c842782e6ff( 3 );
    self.europa.var_fa2f23c9ef92d618 = 0;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0x6085f2ea, Offset: 0x107f
// Size: 0x4b
function private function_43be42579b67e4e9( location )
{
    level endon( #"game_ended" );
    self endon( #"europa_deactivated" );
    self setbtgoalpos( 3, location );
    europa::function_965adb362e3ddb52( 1 );
    
    while ( self pathdisttogoal() > 1 )
    {
        wait 0.1;
    }
}

// Namespace europa_hover
// Params 1
// Checksum 0x7f5616e, Offset: 0x10d2
// Size: 0x99
function get_hover_origin( hoveroffset )
{
    ongroundpos = self.origin + ( 0, 0, 10 );
    pos = self.europa.hovermover ? self.europa.hovermover.origin : ongroundpos;
    
    if ( hoveroffset )
    {
        pos += ( 0, 0, self.europa.var_2a0f029194eb5d61 * 0.3 );
    }
    
    return pos;
}

// Namespace europa_hover
// Params 1, eflags: 0xc
// Checksum 0xe392f77f, Offset: 0x1174
// Size: 0xe79
function private function_207cff3ce5d7d3c( params )
{
    self notify( #"hash_b660f7ee19394a4e" );
    self endon( #"hash_b660f7ee19394a4e" );
    owner = europa::get_owner();
    target = params.target;
    speedmax = params.speedmax ?? 1000;
    speedmaxdistance = params.speedmaxdistance ?? 600;
    targetdistance = params.targetdistance ?? 100;
    followheight = params.followheight ?? 30;
    rotatespeed = params.rotatespeed ?? 3;
    acceleration = params.acceleration ?? 5;
    var_220d0e10c4570471 = params.var_220d0e10c4570471 ?? 10;
    followoffset = params.offset ?? ( 0, 0, 0 );
    var_6872982114cffe7c = 22500;
    goalpos = target.origin;
    self.europa.hovering_to_target = 1;
    self.europa.hover_target = { #angles:target.angles, #origin:target.origin };
    self.europa.var_295bd1f82638b81f = undefined;
    self.europa.var_2a0f029194eb5d61 = followheight;
    
    /#
        debug_hover = function_bf9fca2a50a83961();
        
        if ( debug_hover )
        {
            logstring( "<dev string:x60>" );
        }
        
        rotatespeed = getdvarfloat( @"hash_f3b23c4f8e6b579e", rotatespeed );
        acceleration = getdvarfloat( @"scr_europa_hover_acceleration", acceleration );
        var_220d0e10c4570471 = getdvarfloat( @"hash_4d3363a9305a3eb4", var_220d0e10c4570471 );
    #/
    
    if ( params.findpath )
    {
        self clearpath();
        goalpos = europa::set_goal_pos( target.origin );
        
        if ( !europa::function_965adb362e3ddb52( 1 ) )
        {
            goalpos = getclosestpointonnavmesh( goalpos, self );
            goalpos = europa::set_goal_pos( goalpos );
            europa::function_965adb362e3ddb52( 1 );
        }
        
        self.europa.hover_path = self getpath();
        
        if ( !isdefined( self.europa.hover_path ) || self.europa.hover_path.size == 0 )
        {
            params.ignorecollision = 1;
            self.europa.hover_path = undefined;
        }
        else
        {
            self.europa.hover_path = arraycombine( [ self.origin ], self.europa.hover_path );
            goalpos = self.europa.hover_path[ self.europa.hover_path.size - 1 ] + ( 0, 0, followheight ) + followoffset;
        }
        
        build_path_data();
        
        /#
            if ( debug_hover )
            {
                childthread function_f5ff8c0e33b64529();
            }
        #/
    }
    
    var_b3d7bff9ea250962 = 22500;
    mover = undefined;
    var_295bd1f82638b81f = undefined;
    dt = 0;
    lasttime = gettime();
    velocity = ( 0, 0, 0 );
    self.europa.var_740d6980e3b6b375 = gettime();
    self.europa.var_3c1d2ba1ce29131e = self.origin;
    ret = { #finished:1 };
    self.europa.var_d13972954215a063 = 0;
    
    while ( self.europa.hovering_to_target )
    {
        if ( !isdefined( target ) )
        {
            self.europa.hovering_to_target = 0;
            break;
        }
        
        dt = utility::function_6f5d2e1f1ff70482( gettime() - lasttime );
        lasttime = gettime();
        
        if ( dt <= 0 )
        {
            dt = utility::function_6f5d2e1f1ff70482( getframeduration() );
        }
        
        if ( !mover && europa::is_script_animation() )
        {
            waitframe();
            continue;
        }
        
        moverpos = get_hover_origin();
        var_be475209f76b9db1 = moverpos;
        
        if ( params.type == 2 )
        {
            if ( isdefined( owner ) && isdefined( owner.fasttravel_landing_target ) && owner.fasttravel_jumppad == 0 )
            {
                target = owner.fasttravel_landing_target;
            }
        }
        else if ( params.type == 3 )
        {
            if ( self.europa.var_434b05f9582b4d8c )
            {
                target = { #origin:self.europa.var_434b05f9582b4d8c };
            }
        }
        
        if ( self.europa.hover_path )
        {
            result = function_3d2b0705df460af6( params );
            speed = result.speed;
            targetheight = followheight;
            
            if ( result.hitflag == 1 )
            {
                targetheight = min( followheight * 2, 100 );
            }
            else if ( result.hitflag == 2 )
            {
                targetheight = followheight * 0.1;
            }
            else if ( result.hitflag == 3 )
            {
                targetheight = followheight * 0.2;
            }
            
            self.europa.var_2a0f029194eb5d61 = targetheight;
            targetpos = result.pos + ( 0, 0, targetheight );
            var_19a3d8dc0345f0c3 = 10000;
            
            if ( distancesquared( moverpos, self.europa.var_3c1d2ba1ce29131e ) > var_19a3d8dc0345f0c3 )
            {
                self.europa.var_740d6980e3b6b375 = gettime();
                self.europa.var_3c1d2ba1ce29131e = moverpos;
            }
            else if ( gettime() - self.europa.var_740d6980e3b6b375 > 1000 )
            {
                result.stucktimeout = 1;
            }
            
            resultcurrent = function_8841e4ca1c65f80d( moverpos, 0 );
            self.europa.var_d13972954215a063 = max( resultcurrent.var_8f840d3112ae8c82, self.europa.var_d13972954215a063 );
            function_5b2a780596c1593( resultcurrent );
            
            if ( result.var_8f840d3112ae8c82 + 1 >= self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size - 1 ].index )
            {
                if ( params.type == 1 )
                {
                    self.europa.hover_path = undefined;
                    continue;
                }
            }
            
            /#
                if ( debug_hover )
                {
                    sphere( moverpos, 5, ( 0, 1, 1 ), 0, 1 );
                    sphere( resultcurrent.pos, 5, ( 1, 1, 0 ), 0, 1 );
                }
            #/
        }
        else
        {
            targetabove = target.origin + ( 0, 0, followheight );
            dir = vectornormalize( moverpos - targetabove );
            targetpos = targetabove + dir * targetdistance;
            speed = function_8054de5bd4532468( moverpos, targetpos, 0, speedmax, speedmaxdistance );
            self.europa.hover_target.origin = targetpos;
        }
        
        direction = vectornormalize( targetpos - moverpos );
        
        /#
            if ( debug_hover )
            {
                line( moverpos, moverpos + direction * speed * dt * 10, ( 0, 0, 1 ) );
            }
        #/
        
        var_df9adb69b75ff5f3 = direction * speed;
        velocity = update_velocity( velocity, var_df9adb69b75ff5f3, acceleration, dt );
        step = velocity * dt;
        
        if ( params.ignorecollision )
        {
            var_be475209f76b9db1 = moverpos + step;
        }
        else
        {
            tgtpos = moverpos + step;
            
            if ( params.type != 2 && params.type != 3 && !europa::is_pos_reachable( tgtpos ) )
            {
                self.europa.hovering_to_target = 0;
                break;
            }
            
            var_be475209f76b9db1 = adjust_move_pos( moverpos, tgtpos );
        }
        
        var_c7aa7bbfd7c7f0f7 = 1;
        
        if ( params.type == 2 || params.type == 3 || params.type == 1 )
        {
            var_c7aa7bbfd7c7f0f7 = 0;
        }
        
        /#
            if ( getdvarint( @"hash_1565db575f183d6c" ) )
            {
                var_c7aa7bbfd7c7f0f7 = 0;
            }
        #/
        
        if ( var_c7aa7bbfd7c7f0f7 )
        {
            walkthrough = 0;
            
            if ( !mover && result )
            {
                if ( result.hitwall && result.pos && distancesquared( moverpos, result.pos ) < var_6872982114cffe7c )
                {
                    walkthrough = 1;
                    nextnode = get_walk_node( result.var_8f840d3112ae8c82 + 1 );
                }
            }
            
            if ( resultcurrent )
            {
                if ( mover && result.stucktimeout )
                {
                    walkthrough = 1;
                    nextnode = get_walk_node( resultcurrent.var_8f840d3112ae8c82 + 1 );
                }
                else if ( !walkthrough )
                {
                    checkdistance = 150;
                    blocknode = function_32f0ea4e1006513d( resultcurrent.var_8f840d3112ae8c82, checkdistance );
                    
                    if ( blocknode && blocknode.var_d3c37b3e2a6c963f )
                    {
                        nextnode = get_path_data( blocknode.index + 1 );
                        
                        if ( nextnode && nextnode.inside != blocknode.inside )
                        {
                            walkthrough = 1;
                        }
                    }
                }
            }
            
            if ( walkthrough )
            {
                self.europa.hovering_to_target = 0;
                ret.finished = 0;
                
                if ( mover )
                {
                    fwd = anglestoforward( self.angles );
                    var_295bd1f82638b81f = utility::drop_to_ground( moverpos - fwd * 64, 15, -200 );
                    var_295bd1f82638b81f = europa::get_reachable_pos( var_295bd1f82638b81f, 0, 200 );
                    ret.forceland = 1;
                }
                
                ret.walkgoal = target.origin;
                ret.var_2941619c6e6a305d = 1;
                
                if ( nextnode )
                {
                    ret.walkgoal = nextnode.origin;
                    
                    if ( !nextnode.last )
                    {
                        ret.var_2941619c6e6a305d = 0;
                    }
                }
                
                break;
            }
        }
        
        if ( !mover )
        {
            europa::function_47761cd429bc0244();
            mover = start_hover();
        }
        
        mover.origin = var_be475209f76b9db1;
        self.europa.var_1b277634bf377425 = speed;
        pathforward = targetpos - mover.origin;
        targetangles = vectortoangles( pathforward );
        anglediff = angleclamp180( targetangles[ 1 ] - mover.angles[ 1 ] );
        yaw = mover.angles[ 1 ] + anglediff * rotatespeed * dt;
        mover.angles = ( mover.angles[ 0 ], yaw, mover.angles[ 2 ] );
        
        if ( gettime() - mover.starttime > 500 )
        {
            if ( isdefined( self.europa.hover_path ) && !params.var_afdb6d9c6a1449b6 )
            {
                if ( distancesquared( mover.origin, goalpos ) < var_b3d7bff9ea250962 && !function_bb134101e1b35271( mover.origin, goalpos ) )
                {
                    self.europa.hovering_to_target = 0;
                }
            }
            else if ( speed < 128 && distancesquared( mover.origin, targetpos ) < var_b3d7bff9ea250962 )
            {
                self.europa.hovering_to_target = 0;
            }
        }
        
        waitframe();
    }
    
    self.europa.var_1b277634bf377425 = undefined;
    
    if ( mover )
    {
        if ( var_295bd1f82638b81f )
        {
            pos = var_295bd1f82638b81f;
        }
        else if ( isdefined( self.europa.hover_path ) )
        {
            pos = self.europa.hover_path[ self.europa.hover_path.size - 1 ];
        }
        
        if ( !isdefined( pos ) )
        {
            pos = europa::get_reachable_pos( mover.origin, 0, 200 );
            
            if ( !pos )
            {
                pos = getclosestpointonnavmesh( mover.origin );
            }
        }
        
        self.europa.var_295bd1f82638b81f = utility::drop_to_ground( pos, 30, -200 );
        namespace_4306fdf641484f1f::exit_loop();
        var_295bd1f82638b81f = self.europa.var_295bd1f82638b81f;
        childthread landing_internal();
        self waittill( #"hover_landed" );
        
        if ( self islinked() )
        {
            self motionwarpcancel();
            self unlink();
        }
        
        if ( distancesquared( self.origin, var_295bd1f82638b81f ) > 2500 )
        {
            var_295bd1f82638b81f = europa::get_reachable_pos( var_295bd1f82638b81f, 0, 200 );
            
            if ( !var_295bd1f82638b81f )
            {
                var_295bd1f82638b81f = getclosestpointonnavmesh( var_295bd1f82638b81f ) ?? var_295bd1f82638b81f;
            }
            
            europa::set_goal_pos( var_295bd1f82638b81f );
            
            /#
                if ( function_bf9fca2a50a83961() )
                {
                    sphere( var_295bd1f82638b81f, 5, ( 1, 0, 1 ), 0, 500 );
                }
            #/
        }
        else
        {
            europa::set_goal_pos( self.origin );
        }
        
        self.europa.hover_target = undefined;
        self.europa.hovermover = undefined;
        
        if ( mover )
        {
            mover delete();
        }
    }
    
    function_71a68ebe6054d93f();
    return ret;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xa5f6ecf5, Offset: 0x1ff6
// Size: 0xb1
function private get_walk_node( var_ec607b8312a27f14 )
{
    var_a83856d3de75308d = 2500;
    curnode = get_path_data( var_ec607b8312a27f14 );
    
    for ( i = var_ec607b8312a27f14 + 1; i < self.europa.hover_path_data.path.size ; i++ )
    {
        nextnode = get_path_data( i );
        
        if ( nextnode.var_d3c37b3e2a6c963f )
        {
            continue;
        }
        
        if ( distancesquared( curnode.origin, nextnode.origin ) < var_a83856d3de75308d )
        {
            continue;
        }
        
        break;
    }
    
    return nextnode;
}

// Namespace europa_hover
// Params 0, eflags: 0x4
// Checksum 0x846fd7ad, Offset: 0x20b0
// Size: 0x479
function private landing_internal()
{
    mover = self.europa.hovermover;
    curpos = get_hover_origin();
    targetpos = self.europa.var_295bd1f82638b81f;
    speed = length( targetpos - curpos ) / 0.8;
    dt = level.framedurationseconds;
    var_742fec139d1e7360 = 1;
    var_27e50364cb880f6c = getdvarfloat( @"hash_d7ce90eb70684a91", 1000 );
    starttime = gettime();
    overridecontents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    landtime = starttime + utility::function_4b74c15943231980( 0.8 );
    checkoffset = ( 0, 0, 15 );
    var_c117daead4479b54 = 50;
    get_random_radius_max = 300;
    
    while ( mover )
    {
        curpos = get_hover_origin();
        dir = vectornormalize( targetpos - curpos );
        tomove = dir * speed * dt;
        tgtpos = curpos + tomove;
        newpos = curpos;
        hitpos = undefined;
        hitent = undefined;
        traceresult = trace::capsule_trace( curpos + checkoffset, targetpos + checkoffset, 15, self.height, undefined, self, overridecontents );
        
        if ( traceresult[ "fraction" ] < 0.95 )
        {
            hitent = traceresult[ "entity" ];
            var_295bd1f82638b81f = undefined;
            
            if ( hitent.vehicletype )
            {
                force = max( 100, hitent.veh_speed );
                hitpos = traceresult[ "position" ];
                pushdir = vectornormalize2( curpos - hitent.origin );
                var_295bd1f82638b81f = hitpos + pushdir * force;
            }
            else
            {
                hitent = undefined;
                hitpos = traceresult[ "position" ];
                pushdir = vectornormalize2( curpos - hitpos );
                var_295bd1f82638b81f = hitpos + pushdir * var_c117daead4479b54;
            }
            
            if ( !var_295bd1f82638b81f || !europa::is_pos_reachable( var_295bd1f82638b81f ) )
            {
                /#
                    badpos = var_295bd1f82638b81f;
                #/
                
                var_295bd1f82638b81f = europa::get_reachable_pos( curpos, self.radius, get_random_radius_max );
                
                if ( !var_295bd1f82638b81f )
                {
                    var_295bd1f82638b81f = curpos;
                }
                
                var_295bd1f82638b81f = utility::drop_to_ground( var_295bd1f82638b81f, 30, -200 );
                timeleft = 0.8 - ( gettime() - starttime ) / 1000;
                targetpos = var_295bd1f82638b81f;
                self.europa.var_295bd1f82638b81f = var_295bd1f82638b81f;
                
                if ( timeleft > 0 )
                {
                    speed = length( targetpos - curpos ) / timeleft;
                }
                
                dir = vectornormalize( targetpos - curpos );
                tomove = dir * speed * dt;
                
                /#
                    if ( function_bf9fca2a50a83961() )
                    {
                        sphere( badpos, 5, ( 1, 1, 0 ), 0, 500 );
                        sphere( var_295bd1f82638b81f, 5, ( 0, 1, 1 ), 0, 500 );
                        sphere( hitpos, 5, ( 0, 0, 1 ), 0, 500 );
                        line( badpos, var_295bd1f82638b81f, ( 1, 1, 1 ), 1, 0, 500 );
                    }
                #/
            }
        }
        
        newpos += tomove;
        
        if ( hitpos && hitent )
        {
            if ( distancesquared( newpos, hitent.origin ) < distancesquared( hitpos, hitent.origin ) )
            {
                newpos = ( hitpos[ 0 ], hitpos[ 1 ], newpos[ 2 ] ) + pushdir * self.radius;
            }
        }
        
        mover.origin = newpos;
        waitframe();
        
        if ( mover && distancesquared( mover.origin, targetpos ) < 100 || gettime() - landtime > 1000 )
        {
            break;
        }
    }
    
    if ( mover )
    {
        mover moveto( self.origin, 0.2 );
        wait 0.2;
        
        if ( self islinked() )
        {
            self motionwarpcancel();
            self unlink();
        }
    }
    
    timeout = gettime() + 1000;
    
    while ( europa_asm::is_playing() )
    {
        state = europa_asm::get_current_asm_state();
        
        if ( state == "loop" )
        {
            namespace_4306fdf641484f1f::exit_loop();
        }
        
        if ( gettime() > timeout )
        {
            europa_asm::exit_cap();
            break;
        }
        
        waitframe();
    }
    
    self notify( #"hover_landed" );
}

// Namespace europa_hover
// Params 2, eflags: 0x4
// Checksum 0xdeab5c00, Offset: 0x2531
// Size: 0x8a
function private function_32f0ea4e1006513d( currentindex, distance )
{
    var_4bad4d768a4c63cd = get_path_data( currentindex );
    checkorigin = var_4bad4d768a4c63cd.origin;
    distancesq = distance * distance;
    
    while ( var_4bad4d768a4c63cd && distancesquared( checkorigin, var_4bad4d768a4c63cd.origin ) < distancesq )
    {
        if ( var_4bad4d768a4c63cd.var_d3c37b3e2a6c963f )
        {
            return var_4bad4d768a4c63cd;
        }
        
        currentindex++;
        var_4bad4d768a4c63cd = get_path_data( currentindex );
    }
}

// Namespace europa_hover
// Params 0, eflags: 0x4
// Checksum 0xcc2a28be, Offset: 0x25c4
// Size: 0x339
function private build_path_data()
{
    self.europa.hover_path_data = spawnstruct();
    
    if ( !self.europa.hover_path )
    {
        return;
    }
    
    var_665914a56bfc8034 = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    zoffset = ( 0, 0, 15 );
    zoffsetheight = ( 0, 0, self.height * 1.5 );
    insideoffset = ( 0, 0, 500 );
    self.europa.hover_path_data.path = [];
    index = 0;
    
    for ( i = 0; i < self.europa.hover_path.size ; i++ )
    {
        data = spawnstruct();
        startpos = self.europa.hover_path[ i ];
        data.origin = startpos;
        data.var_d3c37b3e2a6c963f = 0;
        data.index = index;
        
        if ( i == self.europa.hover_path.size - 1 )
        {
            data.last = 1;
        }
        
        if ( function_bb134101e1b35271( startpos + zoffset, startpos + insideoffset ) )
        {
            data.inside = 1;
        }
        else
        {
            data.inside = 0;
        }
        
        endpos = self.europa.hover_path[ i + 1 ];
        
        if ( endpos )
        {
            startpos += zoffset;
            endpos += zoffset;
            result = body_trace( startpos, endpos );
            
            if ( result.hit )
            {
                cosine_check = 0.5;
                dir = vectornormalize( endpos - startpos );
                z = dir[ 2 ] > 0 ? 1 : -1;
                dot = vectordot( dir, ( 0, 0, z ) );
                
                if ( dot > cosine_check )
                {
                    added = function_10ff4202527225f( data, result.baseresult, startpos, endpos, index, 1 );
                    
                    if ( added >= 0 )
                    {
                        index = added;
                        continue;
                    }
                    else
                    {
                        data.var_d3c37b3e2a6c963f = 1;
                        data.vertical = 1;
                    }
                }
                else
                {
                    res = body_trace( startpos, endpos );
                    
                    if ( res.hit )
                    {
                        added = function_10ff4202527225f( data, res.baseresult, startpos, endpos, index, 0 );
                        
                        if ( added >= 0 )
                        {
                            index = added;
                            continue;
                        }
                        else
                        {
                            data.var_d3c37b3e2a6c963f = 1;
                        }
                    }
                }
            }
        }
        
        self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size ] = data;
        index++;
    }
}

// Namespace europa_hover
// Params 6, eflags: 0x4
// Checksum 0x37b23e00, Offset: 0x2905
// Size: 0x368
function private function_10ff4202527225f( data, traceresult, startpos, endpos, index, vertical )
{
    var_db24f7869e92f19 = [];
    
    if ( vertical )
    {
        if ( endpos[ 2 ] > startpos[ 2 ] )
        {
            var_cd25ba1139c1b92f = ( startpos[ 0 ], startpos[ 1 ], endpos[ 2 ] + self.height * 0.5 );
            var_cd25bb1139c1bb62 = ( endpos[ 0 ], endpos[ 1 ], endpos[ 2 ] + self.height * 0.5 );
        }
        else
        {
            var_cd25ba1139c1b92f = ( startpos[ 0 ], startpos[ 1 ], startpos[ 2 ] + self.height * 0.5 );
            var_cd25bb1139c1bb62 = ( endpos[ 0 ], endpos[ 1 ], startpos[ 2 ] + self.height * 0.5 );
        }
        
        var_db24f7869e92f19[ var_db24f7869e92f19.size ] = var_cd25ba1139c1b92f;
        var_db24f7869e92f19[ var_db24f7869e92f19.size ] = var_cd25bb1139c1bb62;
    }
    else if ( traceresult[ "position" ] )
    {
        checkpos = traceresult[ "position" ] + ( 0, 0, self.height * 0.5 );
        var_db24f7869e92f19[ var_db24f7869e92f19.size ] = checkpos;
        
        if ( distancesquared( startpos, endpos ) > 10000 )
        {
            res = body_trace( endpos, startpos );
            
            if ( res.hit )
            {
                var_cd25ba1139c1b92f = res.baseresult[ "position" ] + ( 0, 0, self.height * 0.5 );
                
                if ( distancesquared( checkpos, var_cd25ba1139c1b92f ) > 2500 )
                {
                    var_db24f7869e92f19[ var_db24f7869e92f19.size ] = var_cd25ba1139c1b92f;
                }
            }
        }
    }
    else
    {
        checkpos = ( ( startpos[ 0 ] + endpos[ 0 ] ) * 0.5, ( startpos[ 1 ] + endpos[ 1 ] ) * 0.5, ( startpos[ 2 ] + endpos[ 2 ] ) * 0.5 + self.height * 0.5 );
        var_db24f7869e92f19[ var_db24f7869e92f19.size ] = var_cd25ba1139c1b92f;
    }
    
    path = [ startpos ];
    
    foreach ( pos in var_db24f7869e92f19 )
    {
        path[ path.size ] = pos;
    }
    
    path[ path.size ] = endpos;
    
    if ( function_895cfd2d2add2f66( path ) )
    {
        zoffset = ( 0, 0, 15 );
        insideoffset = ( 0, 0, 500 );
        self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size ] = data;
        index++;
        
        foreach ( pos in var_db24f7869e92f19 )
        {
            inside = function_bb134101e1b35271( pos + zoffset, pos + insideoffset );
            function_17c3472321ac7f4a( pos, index, inside, 0, vertical );
            index++;
        }
        
        return index;
    }
    
    return -1;
}

// Namespace europa_hover
// Params 5, eflags: 0x4
// Checksum 0x141fd940, Offset: 0x2c76
// Size: 0xb3
function private function_17c3472321ac7f4a( origin, index, inside, block, vertical )
{
    newnode = { #vertical:vertical, #inside:inside, #var_d3c37b3e2a6c963f:block, #index:index, #origin:origin };
    self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size ] = newnode;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xd148896f, Offset: 0x2d31
// Size: 0x189, Type: bool
function private function_895cfd2d2add2f66( path )
{
    for ( i = 0; i < path.size ; i++ )
    {
        start = path[ i ];
        end = path[ i + 1 ];
        
        if ( !end )
        {
            break;
        }
        
        res = body_trace( start, end );
        
        if ( res.hit )
        {
            /#
                if ( function_bf9fca2a50a83961() )
                {
                    drawtime = 300;
                    last = undefined;
                    
                    foreach ( pos in path )
                    {
                        if ( last )
                        {
                            line( last, pos, ( 0.5, 0.5, 0.5 ), 1, 0, drawtime );
                        }
                        
                        last = pos;
                        sphere( pos, 5, ( 0.5, 0.5, 0.5 ), 0, drawtime );
                    }
                    
                    hitpos = res.baseresult[ "<dev string:x88>" ];
                    line( start, hitpos, ( 0.5, 0, 0 ), 1, 0, drawtime );
                    sphere( hitpos, 5, ( 0.5, 0, 0 ), 0, drawtime );
                }
            #/
            
            return false;
        }
    }
    
    return true;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xab5226fa, Offset: 0x2ec3
// Size: 0xbc
function private get_path_data( index )
{
    if ( !self.europa.hover_path )
    {
        return;
    }
    
    foreach ( node in self.europa.hover_path_data.path )
    {
        if ( node.index == index )
        {
            return node;
        }
    }
}

// Namespace europa_hover
// Params 2, eflags: 0x4
// Checksum 0xb2a8398c, Offset: 0x2f88
// Size: 0x1f0
function private adjust_move_pos( curpos, tgtpos )
{
    result = body_trace( curpos, tgtpos );
    adjustx = tgtpos[ 0 ];
    adjusty = tgtpos[ 1 ];
    adjustz = tgtpos[ 2 ];
    offsetz = 0;
    
    if ( result.hit )
    {
        /#
            if ( function_bf9fca2a50a83961() )
            {
                function_a2f1e88e246d5099( result, 1, ( 0, 1, 1 ), 120 );
            }
        #/
        
        movementscale = getdvarfloat( @"hash_bac3ba8c809c8933", 0.3 );
        adjustoffset = getdvarint( @"hash_eb092a564f651171", 10 );
        
        if ( result.hitflag == 1 )
        {
            adjustx = curpos[ 0 ] + ( tgtpos[ 0 ] - curpos[ 0 ] ) * movementscale;
            adjusty = curpos[ 1 ] + ( tgtpos[ 1 ] - curpos[ 1 ] ) * movementscale;
            offsetz = adjustoffset;
        }
        else if ( result.hitflag == 2 )
        {
            adjustx = curpos[ 0 ] + ( tgtpos[ 0 ] - curpos[ 0 ] ) * movementscale;
            adjusty = curpos[ 1 ] + ( tgtpos[ 1 ] - curpos[ 1 ] ) * movementscale;
            offsetz = adjustoffset * -1;
        }
        
        vel = tgtpos - curpos;
        bounceforce = getdvarfloat( @"hash_65530170759b9591", 1 );
        
        for ( i = 0; i < 2 ; i++ )
        {
            r = result.results[ i ];
            
            if ( r[ "fraction" ] < 0.95 )
            {
                normal = r[ "normal" ];
                pos = tgtpos + normal * length( vel ) * bounceforce + ( 0, 0, offsetz );
                adjustx = pos[ 0 ];
                adjusty = pos[ 1 ];
                adjustz = pos[ 2 ];
                return ( adjustx, adjusty, adjustz );
            }
        }
    }
    
    return ( adjustx, adjusty, adjustz );
}

// Namespace europa_hover
// Params 3, eflags: 0x4
// Checksum 0x8558bffb, Offset: 0x3181
// Size: 0x1b8
function private body_trace( from, to, height )
{
    radius = 15;
    fwd = vectornormalize2( to - from );
    to += fwd * radius;
    ret = { #hitflag:0, #results:[], #hit:0 };
    
    if ( !isdefined( height ) )
    {
        height = self.height;
    }
    
    overridecontents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    result = trace::capsule_trace( from, to, radius, height, undefined, self, overridecontents );
    ret.baseresult = result;
    
    if ( result[ "fraction" ] < 0.95 )
    {
        ret.hit = 1;
        
        if ( result[ "entity" ].vehicletype )
        {
            ret.hitvehicle = 1;
        }
        
        start = from;
        end = to;
        
        for ( i = 0; i < 2 ; i++ )
        {
            result = trace::ray_trace( start, end, self, overridecontents, undefined, undefined, 1 );
            result[ "origin" ] = start;
            ret.results[ ret.results.size ] = result;
            
            if ( result[ "fraction" ] < 0.95 )
            {
                ret.hit = 1;
                ret.hitflag |= 1 << i;
            }
            
            start = from + ( 0, 0, height );
            end = to + ( 0, 0, height );
        }
    }
    
    return ret;
}

// Namespace europa_hover
// Params 2, eflags: 0x4
// Checksum 0x7b69d8ac, Offset: 0x3342
// Size: 0x5e
function private function_bb134101e1b35271( from, to )
{
    contents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    result = trace::ray_trace( from, to, self, contents, undefined, undefined, 1 );
    
    if ( result[ "fraction" ] < 0.95 )
    {
        return result;
    }
}

// Namespace europa_hover
// Params 0
// Checksum 0x2f0ef989, Offset: 0x33a9
// Size: 0x15
function is_hovering()
{
    return self.europa.hovermover;
}

// Namespace europa_hover
// Params 0
// Checksum 0x8aba6b6a, Offset: 0x33c7
// Size: 0x15
function is_follow_vehicle()
{
    return self.europa.followvehicle;
}

// Namespace europa_hover
// Params 0, eflags: 0x4
// Checksum 0xc90308eb, Offset: 0x33e5
// Size: 0xb0
function private start_hover()
{
    goalpos = self.europa.goalpos;
    self clearpath();
    namespace_4306fdf641484f1f::play( "cap_europa_hover" );
    self.europa.goalpos = goalpos;
    mover = spawn( "script_model", self.origin );
    mover.angles = self.angles;
    mover.starttime = gettime();
    self motionwarpcancel();
    self linktoblendtotag( mover );
    self.europa.hovermover = mover;
    return mover;
}

// Namespace europa_hover
// Params 4, eflags: 0x4
// Checksum 0x9a5f79d4, Offset: 0x349e
// Size: 0x69
function private update_velocity( current, target, speed, dt )
{
    frac = clamp( speed * dt, 0, 1 );
    
    if ( frac == 1 )
    {
        return target;
    }
    
    difference = target - current;
    step = difference * frac;
    return current + step;
}

// Namespace europa_hover
// Params 5, eflags: 0x4
// Checksum 0x894f5682, Offset: 0x3510
// Size: 0x65
function private function_8054de5bd4532468( selfpos, targetpos, var_e237411aba59245e, var_e214531aba33043c, dis_max )
{
    distance = distance( selfpos, targetpos );
    distance = clamp( distance, 0, dis_max );
    ratio = distance / dis_max;
    return var_e237411aba59245e + ( var_e214531aba33043c - var_e237411aba59245e ) * ratio;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xe6ea756b, Offset: 0x357e
// Size: 0x453
function private function_3d2b0705df460af6( params )
{
    /#
        debug_hover = function_bf9fca2a50a83961();
    #/
    
    speedmax = params.speedmax ?? 1000;
    speedmaxdistance = params.speedmaxdistance ?? 600;
    targetdistance = params.targetdistance ?? 100;
    followheight = params.followheight ?? 30;
    posalongpath = self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size - 1 ].origin;
    goalpos = posalongpath + ( 0, 0, followheight );
    segindex = self.europa.hover_path_data.path[ 0 ].index;
    fraction = 0;
    moverpos = get_hover_origin();
    speed = function_8054de5bd4532468( moverpos, goalpos, 0, speedmax, speedmaxdistance );
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1 );
    hitwall = 0;
    hitflag = 0;
    var_4c21f7a74a267a85 = self.height;
    result = undefined;
    
    if ( self.europa.hover_path_data.path.size <= 2 )
    {
        targetpos = goalpos;
        traceresult = body_trace( moverpos, targetpos, var_4c21f7a74a267a85 );
        hitwall = traceresult.hit;
        hitflag = traceresult.hitflag;
    }
    else
    {
        var_46629ed866e839ca = 900;
        curnode = get_path_data( self.europa.var_d13972954215a063 );
        
        for ( i = 1; i < self.europa.hover_path_data.path.size ; i++ )
        {
            node = self.europa.hover_path_data.path[ self.europa.hover_path_data.path.size - i ];
            
            if ( result && ( node.index <= self.europa.var_d13972954215a063 || distancesquared( node.origin, curnode.origin ) < var_46629ed866e839ca ) )
            {
                break;
            }
            
            result = { #fraction:1, #var_8f840d3112ae8c82:node.index, #pos:node.origin };
            posalongpath = result.pos;
            segindex = result.var_8f840d3112ae8c82;
            fraction = result.fraction;
            hitwall = 0;
            targetpos = posalongpath + ( 0, 0, followheight );
            mid = ( moverpos + targetpos ) * 0.5;
            
            if ( !europa::is_pos_reachable( mid ) )
            {
                hitwall = 1;
                hitflag = 3;
                continue;
            }
            
            traceresult = body_trace( moverpos, targetpos, var_4c21f7a74a267a85 );
            hitflag = traceresult.hitflag;
            
            if ( traceresult.hit )
            {
                hitwall = 1;
                continue;
            }
            
            hitwall = 0;
            break;
        }
    }
    
    /#
        if ( debug_hover )
        {
            sphere( posalongpath, 10, ( 1, 0, 0 ), 0, 1 );
            sphere( targetpos, 10, ( 0, 1, 0 ), 0, 1 );
        }
    #/
    
    speed = function_8054de5bd4532468( moverpos, targetpos, 100, speedmax, speedmaxdistance );
    return { #hitflag:hitflag, #hitwall:hitwall, #pos:posalongpath, #speed:speed, #fraction:fraction, #var_8f840d3112ae8c82:segindex };
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0xe26d51dc, Offset: 0x39da
// Size: 0x30d
function private function_5b2a780596c1593( result )
{
    path = self.europa.hover_path;
    pathdata = self.europa.hover_path_data.path;
    
    if ( path.size <= 2 )
    {
        return;
    }
    
    if ( result.var_8f840d3112ae8c82 <= pathdata[ 0 ].index )
    {
        return;
    }
    
    if ( result.var_8f840d3112ae8c82 <= pathdata[ 1 ].index )
    {
        if ( result.fraction > 0 )
        {
            seg = pathdata[ 1 ].origin - pathdata[ 0 ].origin;
            path[ 0 ] = pathdata[ 0 ].origin + seg * result.fraction;
            pathdata[ 0 ].origin = path[ 0 ];
        }
        
        if ( distancesquared( pathdata[ 0 ].origin, pathdata[ 1 ].origin ) < 100 )
        {
            path[ 0 ] = undefined;
            function_cdc669dbc8ea2101( path );
            path = function_5713d46873b29625( path );
            
            if ( self.europa.hover_path_data.path )
            {
                self.europa.hover_path_data.path[ 0 ] = undefined;
                function_cdc669dbc8ea2101( self.europa.hover_path_data.path );
                self.europa.hover_path_data.path = function_5713d46873b29625( self.europa.hover_path_data.path );
            }
        }
        
        return;
    }
    
    foreach ( data in pathdata )
    {
        if ( data.index >= result.var_8f840d3112ae8c82 )
        {
            break;
        }
        
        path[ 0 ] = undefined;
        function_cdc669dbc8ea2101( path );
        self.europa.hover_path_data.path[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.europa.hover_path_data.path );
    }
    
    path = function_5713d46873b29625( path );
    
    if ( self.europa.hover_path_data.path )
    {
        self.europa.hover_path_data.path = function_5713d46873b29625( self.europa.hover_path_data.path );
    }
}

// Namespace europa_hover
// Params 2, eflags: 0x4
// Checksum 0x309ad9da, Offset: 0x3cef
// Size: 0x383
function private function_8841e4ca1c65f80d( point, traveldist )
{
    result = spawnstruct();
    pathdata = self.europa.hover_path_data.path;
    
    if ( !isdefined( pathdata ) || pathdata.size == 0 )
    {
        result.pos = point;
        result.var_8f840d3112ae8c82 = -1;
        return result;
    }
    
    var_8f840d3112ae8c82 = pathdata[ 0 ].index;
    
    if ( pathdata.size == 1 )
    {
        result.pos = pathdata[ 0 ].origin;
        result.var_8f840d3112ae8c82 = var_8f840d3112ae8c82;
        return result;
    }
    
    closestdist = -1;
    fraction = 0;
    index = 1;
    
    for ( i = 1; i < pathdata.size ; i++ )
    {
        segstart = pathdata[ i - 1 ];
        segend = pathdata[ i ];
        seg = segend.origin - segstart.origin;
        var_26975c975546588c = point - segstart.origin;
        
        if ( length( seg ) <= 0.1 )
        {
            continue;
        }
        
        t = clamp( vectordot( var_26975c975546588c, seg ) / vectordot( seg, seg ), 0, 1 );
        proj = segstart.origin + seg * t;
        distsq = distancesquared( point, proj );
        
        if ( closestdist < 0 || distsq <= closestdist )
        {
            closestdist = distsq;
            var_8f840d3112ae8c82 = segstart.index;
            fraction = t;
            index = i;
        }
    }
    
    startpos = pathdata[ index - 1 ];
    endpos = pathdata[ index ];
    seg = endpos.origin - startpos.origin;
    seglength = length( seg );
    pos = startpos.origin + seg * fraction;
    result.var_8f840d3112ae8c82 = var_8f840d3112ae8c82;
    result.fraction = fraction;
    result.pos = pos;
    
    if ( traveldist <= 0 )
    {
        return result;
    }
    
    var_e4eab89744e5cb96 = length( startpos.origin - segstart.origin );
    var_e4eab89744e5cb96 += traveldist;
    
    for ( i = index; i < pathdata.size ; i++ )
    {
        segstart = i == 0 ? pathdata[ 0 ] : pathdata[ i - 1 ];
        segend = pathdata[ i ];
        seg = segend.origin - segstart.origin;
        seglength = length( seg );
        result.var_8f840d3112ae8c82 = segstart.index;
        
        if ( var_e4eab89744e5cb96 <= seglength )
        {
            frac = var_e4eab89744e5cb96 / seglength;
            result.fraction = frac;
            result.pos = segstart.origin + seg * frac;
            return result;
        }
        
        var_e4eab89744e5cb96 -= seglength;
    }
    
    result.pos = pathdata[ pathdata.size - 1 ].origin;
    result.fraction = 1;
    return result;
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0x22a910af, Offset: 0x407b
// Size: 0x74
function private on_player_entered_vehicle( params )
{
    player = params.player;
    europa = player.allyeuropa;
    
    if ( isdefined( europa ) && europa europa::is_activated() )
    {
        europa thread function_b7daa5f3eafffead( params.vehicle, [ "europa_owner_exit_vehicle" ] );
        
        /#
            europa debug_draw_hover();
        #/
    }
}

// Namespace europa_hover
// Params 2, eflags: 0xc
// Checksum 0xa037a019, Offset: 0x40f7
// Size: 0x1cb
function private function_b7daa5f3eafffead( target, endonarr )
{
    self notify( #"hash_3d8d9ed6c81aad76" );
    self endon( #"hash_3d8d9ed6c81aad76" );
    level endon( #"game_ended" );
    self endon( #"europa_deactivated" );
    
    if ( isdefined( endonarr ) )
    {
        foreach ( var_2a5fa9b2868542da in endonarr )
        {
            self endon( var_2a5fa9b2868542da );
        }
    }
    
    self.europa.followvehicle = 1;
    owner = europa::get_owner();
    followdis = self.aisettings.specificaisettings.var_e1273e4e2b6ce9b2;
    
    while ( true )
    {
        if ( !self.europa.hovering_to_target )
        {
            if ( isdefined( owner.vehicle ) && !europa::is_script_animation() && europa::can_think() && !europa::is_pos_in_range( self.origin, target.origin, 600 ) )
            {
                europa::function_cdec0e301075f132();
                thread europa::play_vo( "follow_vehicle" );
                thread function_5b12aedd4acc980d( { #targetdistance:followdis, #followheight:80, #findpath:1, #var_afdb6d9c6a1449b6:1, #target:target, #type:1 } );
            }
        }
        
        wait 1;
    }
}

// Namespace europa_hover
// Params 1, eflags: 0x4
// Checksum 0x6698d59a, Offset: 0x42ca
// Size: 0x82
function private on_player_exit_vehicle( params )
{
    player = params.player;
    aientity = player.allyeuropa;
    
    if ( isdefined( aientity.europa ) )
    {
        aientity.europa.hovering_to_target = 0;
        aientity.europa.followvehicle = 0;
        aientity notify( #"europa_owner_exit_vehicle" );
    }
}

/#

    // Namespace europa_hover
    // Params 0
    // Checksum 0xac70acab, Offset: 0x4354
    // Size: 0x15, Type: dev
    function function_bf9fca2a50a83961()
    {
        return getdvarint( @"hash_25c1ebe4511d0ac8" ) > 0;
    }

    // Namespace europa_hover
    // Params 0
    // Checksum 0xdd5d7117, Offset: 0x4371
    // Size: 0xa0, Type: dev
    function debug_draw_hover()
    {
        level endon( #"game_ended" );
        self endon( #"europa_owner_exit_vehicle" );
        self endon( #"europa_deactivated" );
        
        while ( true )
        {
            if ( self.europa.hovering_to_target && isdefined( self.europa.var_1b277634bf377425 ) )
            {
                print3d( get_hover_origin( 0 ) + ( 0, 0, 100 ), "<dev string:x91>" + self.europa.var_1b277634bf377425, ( 1, 1, 1 ) );
            }
            
            waitframe();
        }
    }

    // Namespace europa_hover
    // Params 0
    // Checksum 0xd4ffeb34, Offset: 0x4419
    // Size: 0x19c, Type: dev
    function function_f5ff8c0e33b64529()
    {
        level endon( #"game_ended" );
        
        while ( self.europa.hover_path_data.path )
        {
            path = self.europa.hover_path_data.path;
            
            for ( i = 1; i < path.size ; i++ )
            {
                p0 = path[ i - 1 ].origin;
                p1 = path[ i ].origin;
                linecolor = ( 0, 1, 0 );
                var_1280c607cee9ac01 = ( 0, 0, 1 );
                
                if ( path[ i - 1 ].var_d3c37b3e2a6c963f )
                {
                    if ( path[ i - 1 ].vertical )
                    {
                        linecolor = ( 1, 0, 1 );
                    }
                    else
                    {
                        linecolor = ( 0, 0, 1 );
                    }
                }
                
                line( p0, p1, linecolor );
                
                if ( i == 1 )
                {
                    debug_draw_path_node( i - 1 );
                }
                
                debug_draw_path_node( i );
            }
            
            if ( self.europa.hover_path_data.walkgoal )
            {
                sphere( self.europa.hover_path_data.walkgoal, 8, ( 1, 1, 1 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace europa_hover
    // Params 1, eflags: 0x4
    // Checksum 0x3292b70c, Offset: 0x45bd
    // Size: 0x87, Type: dev
    function private debug_draw_path_node( i )
    {
        node = self.europa.hover_path_data.path[ i ];
        color = node.inside ? ( 0, 0, 1 ) : ( 0, 1, 0 );
        sphere( node.origin, 3, color, 0, 1 );
    }

    // Namespace europa_hover
    // Params 4, eflags: 0x4
    // Checksum 0xfe05e91a, Offset: 0x464c
    // Size: 0x106, Type: dev
    function private function_a2f1e88e246d5099( result, drawnormal, color, duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        foreach ( result in result.results )
        {
            hitpos = result[ "<dev string:x88>" ];
            
            if ( hitpos )
            {
                if ( drawnormal )
                {
                    line( hitpos, hitpos + result[ "<dev string:x9a>" ] * 10, color, 1, 0, duration );
                }
                else
                {
                    color = ( 0, 1, 1 );
                    line( result[ "<dev string:xa1>" ], hitpos, color, 1, 0, duration );
                }
                
                sphere( hitpos, 5, color, 0, duration );
            }
        }
    }

    // Namespace europa_hover
    // Params 0, eflags: 0x4
    // Checksum 0x33013504, Offset: 0x475a
    // Size: 0x60, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa8>" );
        devgui::add_devgui_func( "<dev string:xb9>", "<dev string:xcc>", &function_2d46ba959a181788, 1 );
        devgui::add_devgui_func( "<dev string:xd9>", "<dev string:xf0>", &function_c3915fa79e66c183, 1 );
        devgui::add_devgui_func( "<dev string:x101>", "<dev string:x118>", &function_98a9dc2407af225b, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa_hover
    // Params 0, eflags: 0x4
    // Checksum 0x2e135d7a, Offset: 0x47c2
    // Size: 0x1a, Type: dev
    function private function_2d46ba959a181788()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x129>", @"hash_fdbafab53253ce46" );
    }

    // Namespace europa_hover
    // Params 0, eflags: 0x4
    // Checksum 0xed4c95e2, Offset: 0x47e4
    // Size: 0x1a, Type: dev
    function private function_c3915fa79e66c183()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x147>", @"hash_1565db575f183d6c" );
    }

    // Namespace europa_hover
    // Params 0, eflags: 0x4
    // Checksum 0x5a7e7a24, Offset: 0x4806
    // Size: 0x66, Type: dev
    function private function_98a9dc2407af225b()
    {
        if ( level.europa )
        {
            curstate = level.europa getscriptablepartstate( "<dev string:x16a>" );
            state = curstate == "<dev string:x173>" ? "<dev string:x177>" : "<dev string:x173>";
            level.europa setscriptablepartstate( "<dev string:x16a>", state );
        }
    }

#/
