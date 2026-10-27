// script_590ec01abe3be472  (hash_590ec01abe3be472.gscc) (size: 11698 Bytes / 0x2db2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72c5f612 (1925576210)
// size ...... 11698 (0x2db2)
// includes .. 10  (offset: 0x2b16)
// strings ... 30  (offset: 0x2b66)
// dev strs .. 14  (offset: 0x2d0a)
// exports ... 29  (offset: 0x19aa)
// cseg ...... 0x20b + 0x179f (0x19aa)
// imports ... 111 (offset: 0x1e32)
// animtree1 . 0   (offset: 0x2db2)
// animtree2 . 0   (offset: 0x2db2)
#using script_437ee0f94301721b;
#using script_bdb08507b3b7b94;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;

#namespace zombie_uranus_fireball;

// Namespace zombie_uranus_fireball
// Params 1
// Checksum 0x6006b771, Offset: 0x229
// Size: 0x47
function function_2b091127547f62bc( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "uranus_fireball_burning_vfx", settings.var_b132d11a51169f2 );
    }
    
    /#
        devgui_init();
    #/
}

// Namespace zombie_uranus_fireball
// Params 0
// Checksum 0xd58b481d, Offset: 0x278
// Size: 0x67
function init_uranus_fireball()
{
    thread setup_uranus_eyes();
    zombie_uranus::register_can_use_skill( "uranus_skill_fireball", &function_571b331c1ff7f339 );
    zombie_uranus::register_cool_down( #"hash_a04fd9398c184d66", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.fireballcooldown );
    level zombie_utils::function_dfae6a5bd222c586( &function_943d8dd3946c8611 );
    
    /#
        if ( is_debug_draw_fireball() )
        {
            thread debug_draw_fireball();
        }
    #/
}

// Namespace zombie_uranus_fireball
// Params 0, eflags: 0x4
// Checksum 0xcfc0eabc, Offset: 0x2e7
// Size: 0x169
function private setup_uranus_eyes()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.uranus_eyes = [];
    waitframe();
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    for ( i = 0; i < 2 ; i++ )
    {
        tag = i == 0 ? "tag_eye_fx_le" : "tag_eye_fx_ri";
        chargepart = i == 0 ? "eye_le" : "eye_ri";
        origin = self gettagorigin( tag, 1 ) ?? self.origin;
        angles = self gettagangles( tag, 1 ) ?? self.angles;
        eye = utility::spawn_model( settings.eyeballmodel, origin, angles );
        eye.tag = tag;
        eye.chargepart = chargepart;
        
        if ( utility::hastag( self.model, tag ) )
        {
            eye linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
        
        thread utility::delete_on_death( eye );
        self.uranus_eyes[ self.uranus_eyes.size ] = eye;
    }
}

// Namespace zombie_uranus_fireball
// Params 0, eflags: 0x4
// Checksum 0x8a23cb5f, Offset: 0x458
// Size: 0x134
function private fireball_charge()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"uranus_interrupted" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.uranus_fireball_charging = 1;
    eye_charge( 1 );
    utility::function_32b24db3127bff40( "fireball", "charging" );
    zombie_uranus::do_action( "uranus_fireball" );
    zombie_uranus::start_cool_down( #"hash_61ccd92bbf0ca313" );
    zombie_uranus::start_cool_down( #"hash_a04fd9398c184d66" );
    introanimlength = zombie_uranus_asm::get_anim_length( "fireball_attack_intro" );
    var_5f21f017afdfa868 = max( 0, settings.var_5b23edba0c7d706 - introanimlength );
    thread watch_interrupt();
    wait var_5f21f017afdfa868;
    self asmsetstate( self.asmname, "fireball_attack_intro" );
    var_65eec6a195986c27 = settings.var_5b23edba0c7d706 - var_5f21f017afdfa868;
    self waittill( #"fire" );
    function_a1601949a8a5bfaf();
    
    if ( randomint( 100 ) < 20 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_3044598fbeb736d1" ] );
    }
}

// Namespace zombie_uranus_fireball
// Params 0
// Checksum 0x721974a, Offset: 0x594
// Size: 0x119
function function_a1601949a8a5bfaf()
{
    positions = [];
    
    foreach ( tgt in self.fireballtargets )
    {
        positions[ positions.size ] = tgt.origin;
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    radius = settings.var_aaf26eb043de23c0 + 10;
    positions = function_63d777a889756429( positions, radius );
    eye_fire();
    
    for ( i = 0; i < positions.size && i < self.uranus_eyes.size ; i++ )
    {
        thread fireball_attack( i, positions[ i ] );
    }
    
    wait 0.5;
    fireball_charge_end();
}

// Namespace zombie_uranus_fireball
// Params 1, eflags: 0x4
// Checksum 0x5dbd7a58, Offset: 0x6b5
// Size: 0x9c
function private eye_charge( on )
{
    foreach ( eye in self.uranus_eyes )
    {
        eye utility::function_32b24db3127bff40( "eye", on ? "activated" : "off" );
    }
}

// Namespace zombie_uranus_fireball
// Params 0, eflags: 0x4
// Checksum 0xaba777dd, Offset: 0x759
// Size: 0x85
function private eye_fire()
{
    foreach ( eye in self.uranus_eyes )
    {
        eye utility::function_32b24db3127bff40( "eye", "fire" );
    }
}

// Namespace zombie_uranus_fireball
// Params 0, eflags: 0x4
// Checksum 0x89e7d0ea, Offset: 0x7e6
// Size: 0x53
function private watch_interrupt()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::waittill_any( "death", "uranus_damaged" );
    asm::asm_fireevent( self.asmname, "exit_loop" );
    
    if ( self.uranus_fireball_charging )
    {
        fireball_charge_end();
    }
}

// Namespace zombie_uranus_fireball
// Params 0, eflags: 0x4
// Checksum 0x2879cad2, Offset: 0x841
// Size: 0x3d
function private fireball_charge_end()
{
    self.uranus_fireball_charging = 0;
    self notify( #"fireball_charge_end" );
    eye_charge( 0 );
    utility::function_32b24db3127bff40( "fireball", "off" );
    zombie_uranus::end_action( "uranus_fireball" );
}

// Namespace zombie_uranus_fireball
// Params 2, eflags: 0x4
// Checksum 0x34262409, Offset: 0x886
// Size: 0xc6
function private fireball_attack( eyeindex, pos )
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    eye = self.uranus_eyes[ eyeindex ];
    from = self gettagorigin( eye.tag );
    fireball = utility::spawn_model( settings.fireballmodel, from, eye.angles );
    fireball.owner = self;
    fireball utility::function_32b24db3127bff40( "trail", "on" );
    pos = utility::drop_to_ground( pos, 250, -1000 );
    thread function_989fb54f38428e35( eye, fireball, pos );
}

// Namespace zombie_uranus_fireball
// Params 3
// Checksum 0xa77ea942, Offset: 0x954
// Size: 0x311
function function_989fb54f38428e35( eye, fireball, pos )
{
    level endon( #"game_ended" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    tgtpos = utility::drop_to_ground( pos, 50, -1000 );
    dir = vectornormalize( tgtpos - eye.origin );
    dir2 = vectornormalize2( dir );
    right = vectorcross( dir2, ( 0, 0, 1 ) );
    ctrlangle = getdvarfloat( @"hash_e73a4fde3801435b", 30 );
    ctrldis = getdvarfloat( @"hash_a1a678e828894893", 1500 );
    dircontrol = rotatepointaroundvector( right, dir, ctrlangle );
    offsetdis = getdvarfloat( @"hash_fff795cb67712eb5", 800 );
    startpos = eye.origin + dircontrol * offsetdis;
    marker = utility::spawn_model( settings.fireballmodel, tgtpos );
    marker utility::function_32b24db3127bff40( "marker", "on" );
    thread utility::delete_on_death( marker );
    timelaunch = getdvarfloat( @"hash_3da9ffa97ee9d177", 1 );
    fireball.angles = vectortoangles( dircontrol );
    
    if ( timelaunch > 0 && ctrldis > 0 )
    {
        var_974caac5174e66dd = getdvarfloat( @"hash_b92a8ad75d58f475", 0.05 );
        var_974ca9c5174e64aa = getdvarfloat( @"hash_b92a89d75d58f242", 0.1 );
        fireball moveto( fireball.origin + dircontrol * ctrldis, timelaunch, var_974caac5174e66dd, var_974ca9c5174e64aa );
    }
    
    fireball childthread function_ec48fd38d78d86f3( tgtpos, eye, marker );
    
    if ( timelaunch > 0 )
    {
        wait timelaunch;
    }
    
    distance2 = distance2d( tgtpos, fireball.origin );
    var_534289cabbb88ee9 = getdvarfloat( @"hash_d95fb506b2f8f02", 0.5 );
    var_96e81673dd3580eb = fireball.origin + dircontrol * distance2 * var_534289cabbb88ee9;
    drawpath = 0;
    
    /#
        if ( is_debug_draw_fireball() )
        {
            drawpath = 1;
        }
    #/
    
    flytime = getdvarfloat( @"hash_abcdc7a8a24e5e76", settings.var_461921d6e02df67d ) - timelaunch;
    fireball thread utility::function_8001268940441423( fireball.origin, tgtpos, var_96e81673dd3580eb, flytime, drawpath );
    fireball waittill( #"fireball_end", hitpos );
    fireball notify( #"off_bezier_curve" );
    
    if ( hitpos )
    {
        if ( marker )
        {
            marker utility::function_32b24db3127bff40( "marker", "off" );
            marker delete();
        }
        
        fireball fireball_explode();
    }
    
    wait 1.5;
    
    if ( fireball )
    {
        fireball delete();
    }
}

// Namespace zombie_uranus_fireball
// Params 0
// Checksum 0x4462810a, Offset: 0xc6d
// Size: 0x284
function fireball_explode()
{
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    fireball = self;
    attacker = fireball.owner;
    fireball utility::function_32b24db3127bff40( "trail", "off" );
    fireball utility::function_32b24db3127bff40( "explosion", "on" );
    explodeorigin = utility::drop_to_ground( fireball.origin, 150, -300 ) + ( 0, 0, 10 );
    earthquake = settings.fireballearthquake;
    earthquakeadvanced( earthquake.magnitudemax, earthquake.magnitudemid, earthquake.magnitudemin, earthquake.duration, explodeorigin, earthquake.radiusmin, earthquake.radiusmid, earthquake.radiusmax );
    radiusdamage( explodeorigin, settings.fireballexplosionradius, settings.var_d2c5188320d0b583, settings.var_d2e80e8320f6e73d, attacker, "MOD_EXPLOSIVE" );
    hit_zombies = getaiarrayinradius( explodeorigin, settings.fireballexplosionradius, "team_two_hundred" );
    
    foreach ( zombie in hit_zombies )
    {
        if ( isalive( zombie ) && zombie.subclass == "zombie_base" )
        {
            throttle::throttle_wait_in_queue( level.boss_uranus.zombie_kill_throttle, zombie );
            
            if ( isalive( zombie ) )
            {
                zombie kill();
                corpse = zombie getcorpseentity();
                
                if ( isdefined( corpse ) )
                {
                    var_854e30d98ebcc406 = corpse.origin - explodeorigin + ( 0, 0, 10 );
                    var_d9ecbf82ea45f4eb = max( settings.fireballexplosionradius - distance2d( corpse.origin, explodeorigin ), 0 );
                    corpse startragdollfromimpact( "torso_upper", var_854e30d98ebcc406 * var_d9ecbf82ea45f4eb );
                }
            }
        }
    }
    
    thread fireball_burn( fireball );
}

// Namespace zombie_uranus_fireball
// Params 3
// Checksum 0xf96d2a2b, Offset: 0xef9
// Size: 0x19b
function function_ec48fd38d78d86f3( tgtpos, eye, marker )
{
    fireball = self;
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    timeout = gettime() + utility::function_4b74c15943231980( 10 );
    
    while ( self && gettime() < timeout )
    {
        dir = anglestoforward( fireball.angles );
        
        /#
            if ( is_debug_draw_fireball() )
            {
                sphere( fireball.origin, 50, ( 1, 0, 0 ), 0, 1 );
                line( fireball.origin, fireball.origin + dir * 350, ( 1, 0, 0 ), 1, 0, 1 );
            }
        #/
        
        lastpos = fireball.origin;
        result = trace::sphere_trace( lastpos, fireball.origin, 50, [ fireball, eye ] );
        
        if ( result[ "fraction" ] < 1 )
        {
            hitpos = result[ "position" ];
            break;
        }
        
        waitframe();
        dir = vectornormalize( fireball.origin - lastpos );
        
        if ( dir != ( 0, 0, 0 ) )
        {
            fireball.angles = vectortoangles( dir );
        }
    }
    
    self notify( #"fireball_end", hitpos );
}

// Namespace zombie_uranus_fireball
// Params 1
// Checksum 0x73a2ee36, Offset: 0x109c
// Size: 0x202
function fireball_burn( fireball )
{
    level endon( #"game_ended" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    attacker = fireball.owner;
    overridecontents = trace::create_contents( 0, 1, 1 );
    result = fireball trace::ray_trace( fireball.origin + ( 0, 0, 50 ), fireball.origin + ( 0, 0, -1000 ), [ fireball ], overridecontents );
    
    if ( result[ "fraction" ] < 1 )
    {
        pos = result[ "position" ];
    }
    else
    {
        pos = fireball.origin;
    }
    
    fxobj = spawnfx( utility::getfx( "uranus_fireball_burning_vfx" ), pos );
    triggerfx( fxobj );
    
    /#
        if ( is_debug_draw_fireball() )
        {
            duration = utility::function_329f35afae907694( settings.var_7c408652d398064e );
            thread utility::draw_circle( pos, settings.var_aaf26eb043de23c0, ( 1, 0, 0 ), 1, 0, duration );
        }
    #/
    
    fxobj utility::delaycall( settings.var_7c408652d398064e + 1, &delete );
    tick = settings.var_c6394dffed9c5bb7 > 0 ? settings.var_c6394dffed9c5bb7 : 0.5;
    count = settings.var_7c408652d398064e / tick;
    
    for ( i = 0; i < count ; i++ )
    {
        if ( !attacker )
        {
            break;
        }
        
        radiusdamage( pos, settings.var_aaf26eb043de23c0, settings.var_586c8e60f01b77f, settings.var_586c8e60f01b77f, attacker, "MOD_FIRE" );
        wait tick;
    }
}

// Namespace zombie_uranus_fireball
// Params 1
// Checksum 0x697cc1a9, Offset: 0x12a6
// Size: 0xa1
function function_943d8dd3946c8611( params )
{
    if ( params.eattacker.animsetname != "zombie_uranus" || params.smeansofdeath != "MOD_FIRE" )
    {
        return -1;
    }
    
    target = self;
    settings = params.eattacker.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    target effect_burn::burn( 1, 0, settings.var_c6394dffed9c5bb7, params.eattacker, "uranus_fireball_burn" );
    return -1;
}

// Namespace zombie_uranus_fireball
// Params 0
// Checksum 0x73a55add, Offset: 0x1350
// Size: 0x5d
function function_571b331c1ff7f339()
{
    /#
        if ( getdvarint( @"hash_d0cde55542ca7360" ) )
        {
            return anim.failure;
        }
    #/
    
    if ( !zombie_uranus::function_420be0b5922e064b() )
    {
        return 0;
    }
    
    if ( zombie_uranus::get_phase() < 2 )
    {
        return 0;
    }
    
    if ( self.uranus_fireball_charging )
    {
        return 0;
    }
    
    if ( zombie_uranus::has_cool_down( #"hash_a04fd9398c184d66" ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zombie_uranus_fireball
// Params 2, eflags: 0x4
// Checksum 0x296b25d6, Offset: 0x13b6
// Size: 0x123
function private function_63d777a889756429( positions, mindist )
{
    if ( mindist <= 0 || positions.size <= 1 )
    {
        return positions;
    }
    
    while ( true )
    {
        changed = 0;
        
        for ( i = 0; i < positions.size ; i++ )
        {
            for ( j = i + 1; j < positions.size ; j++ )
            {
                dist = distance2d( positions[ i ], positions[ j ] );
                
                if ( dist < mindist )
                {
                    if ( dist == 0 )
                    {
                        dir = rotatepointaroundvector( ( 0, 0, 1 ), ( 1, 0, 0 ), randomfloatrange( 0, 360 ) );
                    }
                    else
                    {
                        dir = positions[ i ] - positions[ j ];
                    }
                    
                    dir = vectornormalize2( dir );
                    push = max( 5, ( mindist - dist ) * 0.5 );
                    positions[ i ] += dir * push;
                    positions[ j ] -= dir * push;
                    changed = 1;
                }
            }
        }
        
        if ( !changed )
        {
            break;
        }
    }
    
    return positions;
}

// Namespace zombie_uranus_fireball
// Params 2
// Checksum 0x911b38c, Offset: 0x14e2
// Size: 0x79
function function_69087bcdf65f1231( taskid, params )
{
    self.fireballtargets = zombie_uranus::get_random_targets( 0, 2 );
    
    if ( self.fireballtargets.size == 0 )
    {
        return anim.failure;
    }
    
    if ( self.fireballtargets.size == 1 )
    {
        self.fireballtargets[ self.fireballtargets.size ] = self.fireballtargets[ 0 ];
    }
    
    return anim.success;
}

// Namespace zombie_uranus_fireball
// Params 2
// Checksum 0xf11a2b27, Offset: 0x1564
// Size: 0x3e
function function_a43ef8c59fa74174( taskid, params )
{
    if ( self.fireballtargets.size == 0 )
    {
        return anim.failure;
    }
    
    thread fireball_charge();
    return anim.success;
}

// Namespace zombie_uranus_fireball
// Params 2
// Checksum 0x537e2f6d, Offset: 0x15ab
// Size: 0x1e
function function_e292a0efbab6f217( taskid, params )
{
    return anim.success;
}

/#

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xbf507e34, Offset: 0x15d2
    // Size: 0x9f, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x48>" );
        devgui::add_devgui_func( "<dev string:x52>", "<dev string:x67>", &function_1a852e4eac6632a9, 1, 30 );
        devgui::add_devgui_func( "<dev string:x85>", "<dev string:x91>", &function_dee7214fddae820b, undefined, 31 );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xb4>", &function_8528718b89494834, 1, 32 );
        devgui::add_devgui_func( "<dev string:xc1>", "<dev string:xd3>", &function_e7d5558a52a65a83, 1, 33 );
        devgui::add_devgui_func( "<dev string:xee>", "<dev string:x104>", &function_96b56e250dde0ef6, 1, 34 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0x65a2b0ce, Offset: 0x1679
    // Size: 0x1a, Type: dev
    function private function_1a852e4eac6632a9()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x11c>", @"hash_d0cde55542ca7360" );
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0x1390d15a, Offset: 0x169b
    // Size: 0x51, Type: dev
    function private function_e7d5558a52a65a83()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x13e>", @"hash_793ebc9378d65f8a" );
        Uranus = level.debug_uranus;
        
        if ( is_debug_draw_fireball() )
        {
            Uranus thread debug_draw_fireball();
            return;
        }
        
        Uranus notify( #"hash_352560f90d010c16" );
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xcf84a95d, Offset: 0x16f4
    // Size: 0x13, Type: dev
    function private is_debug_draw_fireball()
    {
        return getdvarint( @"hash_793ebc9378d65f8a" );
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xe3dd76c2, Offset: 0x170f
    // Size: 0x9d, Type: dev
    function private function_dee7214fddae820b()
    {
        Uranus = level.debug_uranus;
        
        if ( Uranus && Uranus function_69087bcdf65f1231() )
        {
            tgt = Uranus utility::callsharedfunc( #"zombie_uranus", #"hash_fddaede65cd5e4f5" );
            tgtstruct = { #angles:( 0, 0, 0 ), #origin:tgt };
            Uranus.fireballtargets = [ tgtstruct, tgtstruct ];
            Uranus function_a43ef8c59fa74174();
        }
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0xc
    // Checksum 0x5b2e495a, Offset: 0x17b4
    // Size: 0x113, Type: dev
    function private debug_draw_fireball()
    {
        self notify( #"hash_dd12f69f68c275ae" );
        self endon( #"hash_dd12f69f68c275ae" );
        self endon( #"hash_352560f90d010c16" );
        
        while ( true )
        {
            foreach ( eye in self.uranus_eyes )
            {
                sphere( self gettagorigin( eye.tag ), 100, ( 1, 0, 0 ) );
                fwd = anglestoforward( eye.angles );
                line( eye.origin, eye.origin + fwd * 500, ( 1, 0, 0 ), 1, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0x1095596, Offset: 0x18cf
    // Size: 0x49, Type: dev
    function private function_8528718b89494834()
    {
        level endon( #"game_ended" );
        Uranus = level.debug_uranus;
        Uranus endon( #"death" );
        Uranus eye_fire();
        wait 1;
        Uranus eye_charge( 0 );
    }

    // Namespace zombie_uranus_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xd56b0b10, Offset: 0x1920
    // Size: 0x8a, Type: dev
    function private function_96b56e250dde0ef6()
    {
        level endon( #"game_ended" );
        tgtpos = devgui::function_97024c0a6d1256a6();
        settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
        fireball = utility::spawn_model( settings.fireballmodel, tgtpos );
        fireball.owner = level.debug_uranus;
        fireball fireball_explode();
        wait 1;
        fireball delete();
    }

#/
